#include <asm-generic/errno-base.h>
#include <linux/cdev.h>
#include <linux/dev_printk.h>
#include <linux/fs.h>
#include <linux/gpio.h>
#include <linux/init.h>
#include <linux/mod_devicetable.h>
#include <linux/module.h>
#include <linux/of.h>
#include <linux/of_gpio.h>
#include <linux/platform_device.h>
#include <linux/printk.h>
#include <linux/types.h>

#define LED_DEV_NAME "led"
#define LED_DEV_FMT LED_DEV_NAME "%d"

enum led_state
{
  LED_ON = 0,
  LED_OFF = 1
};

struct led_dev_priv
{
  struct cdev cdev;
  struct device* dev;
  struct device_node* nd;
  int led_gpio;
};

static dev_t led_dev_id = 0;
static int led_dev_major = 0;
static int led_dev_counter = 0;

static struct class* led_class = NULL;

static int
led_open(struct inode* inode, struct file* file)
{
  struct led_dev_priv* led_data =
    container_of(inode->i_cdev, struct led_dev_priv, cdev);
  file->private_data = led_data;
  return 0;
}

static ssize_t
// NOLINTNEXTLINE
led_write(struct file* file, const char __user* buf, size_t cnt, loff_t* offs)
{
  char data[2] = { 0 };
  struct led_dev_priv* led_data = file->private_data;

  if (cnt > 2) {
    cnt = 2;
  }

  if (copy_from_user(data, buf, cnt) < 0) {
    dev_err(led_data->dev, "failed to copy from user\n");
    return -EFAULT;
  }

  if (data[0] == '0') {
    gpio_set_value(led_data->led_gpio, LED_OFF);
  } else if (data[0] == '1') {
    gpio_set_value(led_data->led_gpio, LED_ON);
  }

  return 0;
}

static struct file_operations led_fops = {
  .owner = THIS_MODULE,
  .write = led_write,
  .open = led_open,
};

static int
// NOLINTNEXTLINE
led_probe(struct platform_device* pdev)
{
  int err = 0;

  if (!led_dev_major) {
    err = alloc_chrdev_region(&led_dev_id, 0, 1, LED_DEV_NAME);
    if (err < 0) {
      dev_err(&pdev->dev, "failed to allocate char device region\n");
      goto led_register_chrdev_err;
    }

    led_dev_major = MAJOR(led_dev_id);
  } else {
    err = register_chrdev_region(led_dev_id, 1, LED_DEV_NAME);
    if (err < 0) {
      dev_err(&pdev->dev, "failed to register char device region\n");
      goto led_register_chrdev_err;
    }
  }

  dev_t dev_id = MKDEV(led_dev_major, led_dev_counter);

  struct led_dev_priv* led_data =
    devm_kzalloc(&pdev->dev, sizeof(struct led_dev_priv), GFP_KERNEL);
  if (!led_data) {
    dev_err(&pdev->dev, "failed to allocate led data\n");
    err = -ENOMEM;
    goto led_priv_alloc_err;
  }

  led_data->nd = pdev->dev.of_node;
  led_data->led_gpio = of_get_named_gpio(led_data->nd, "led-gpio", 0);
  if (led_data->led_gpio < 0) {
    dev_err(&pdev->dev, "failed to get led gpio\n");
    err = led_data->led_gpio;
    goto led_priv_alloc_err;
  }

  err = gpio_request(led_data->led_gpio, "led-gpio");
  if (err < 0) {
    dev_err(&pdev->dev, "failed to request led gpio\n");
    goto led_priv_alloc_err;
  }
  err = gpio_direction_output(led_data->led_gpio, LED_OFF);
  if (err < 0) {
    dev_err(&pdev->dev, "failed to set led gpio direction\n");
    goto led_gpio_err;
  }

  led_data->dev = device_create(
    led_class, &pdev->dev, dev_id, NULL, LED_DEV_FMT, led_dev_counter);
  if (IS_ERR(led_data->dev)) {
    dev_err(&pdev->dev, "failed to create device\n");
    err = PTR_ERR(led_data->dev);
    goto led_dev_alloc_err;
  }

  cdev_init(&led_data->cdev, &led_fops);
  err = cdev_add(&led_data->cdev, dev_id, 1);
  if (err < 0) {
    dev_err(&pdev->dev, "failed to add char device\n");
    goto led_cdev_add_err;
  }

  platform_set_drvdata(pdev, led_data);
  led_dev_counter++;

  return 0;

led_cdev_add_err:
  device_destroy(led_class, dev_id);
led_dev_alloc_err:
  devm_kfree(&pdev->dev, led_data);
led_gpio_err:
  gpio_free(led_data->led_gpio);
led_priv_alloc_err:
  unregister_chrdev_region(led_dev_id, 1);
led_register_chrdev_err:
  return err;
}

static void
led_remove(struct platform_device* pdev)
{
  struct led_dev_priv* led_data = platform_get_drvdata(pdev);

  gpio_set_value(led_data->led_gpio, LED_OFF);
  gpio_free(led_data->led_gpio);

  cdev_del(&led_data->cdev);
  device_destroy(led_class, led_data->dev->devt);
  unregister_chrdev_region(led_dev_id, 1);
}

static struct of_device_id leds_of_match[] = { { .compatible = "led-gpio" },
                                               {} };

static struct platform_driver led_driver = {
  .driver = { .name = "led", .of_match_table = of_match_ptr(leds_of_match) },
  .probe = led_probe,
  .remove = led_remove,
};

static int __init
led_init(void)
{
  led_class = class_create(LED_DEV_NAME);
  if (IS_ERR(led_class)) {
    pr_err("failed to create led class\n");
    return PTR_ERR(led_class);
  }

  return platform_driver_register(&led_driver);
}

static void __exit
led_exit(void)
{
  platform_driver_unregister(&led_driver);
  class_destroy(led_class);
}

module_init(led_init);
module_exit(led_exit);

MODULE_AUTHOR("Dessera");
MODULE_DESCRIPTION("I.MX6ULL (Alientek Alpha) Led controller");
MODULE_LICENSE("MIT");
MODULE_VERSION("0.2");
