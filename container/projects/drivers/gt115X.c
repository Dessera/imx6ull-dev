#include "asm-generic/errno-base.h"
#include <linux/acpi.h>
#include <linux/dev_printk.h>
#include <linux/err.h>
#include <linux/gfp_types.h>
#include <linux/gpio/consumer.h>
#include <linux/i2c.h>
#include <linux/init.h>
#include <linux/input.h>
#include <linux/module.h>
#include <linux/of.h>
#include <linux/types.h>

struct gt115X_priv_data
{
  struct gpio_desc* gpio_irq;
  struct gpio_desc* gpio_rst;
  struct i2c_client* client;
  struct input_dev* input;
  size_t width;
  size_t height;
};

static int
gt115X_probe(struct i2c_client* client)
{
  dev_dbg(&client->dev, "I2C Address: 0x%02x\n", client->addr);

  if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
    return dev_err_probe(
      &client->dev, -ENXIO, "I2C check functionality failed\n");
  }

  struct gt115X_priv_data* tsdata =
    devm_kzalloc(&client->dev, sizeof(*tsdata), GFP_KERNEL);
  if (IS_ERR(tsdata)) {
    return dev_err_probe(
      &client->dev, PTR_ERR(tsdata), "Failed to alloc device data\n");
  }

  tsdata->client = client;
  i2c_set_clientdata(client, tsdata);

  tsdata->gpio_irq = devm_gpiod_get_optional(&client->dev, "irq", GPIOD_IN);
  if (IS_ERR(tsdata->gpio_irq)) {
    return dev_err_probe(
      &client->dev, PTR_ERR(tsdata->gpio_irq), "Failed to get irq GPIO\n");
  }

  return 0;
}
static void
gt115X_remove(struct i2c_client* client)
{
}

static const struct of_device_id gt115X_of_match[] = { { .compatible =
                                                           "alientek,gt115X" },
                                                       { /* sentinel */ } };

MODULE_DEVICE_TABLE(of, gt115X_of_match);

static struct i2c_driver gt115X_i2c_driver = {
  .probe = gt115X_probe,
  .remove = gt115X_remove,
  .driver = { .name = "GT115X",
              .owner = THIS_MODULE,
              .of_match_table = of_match_ptr(gt115X_of_match), },
};

module_i2c_driver(gt115X_i2c_driver);

MODULE_AUTHOR("Dessera");
MODULE_DESCRIPTION("GT115X tsc with Alientek modification");
MODULE_LICENSE("Dual MIT/GPL");
MODULE_VERSION("0.1");
