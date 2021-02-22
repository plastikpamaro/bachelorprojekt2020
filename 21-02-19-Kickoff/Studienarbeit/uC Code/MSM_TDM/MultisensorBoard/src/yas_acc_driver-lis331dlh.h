/*
 * yas_acc_driver_lis331dlh.h
 *
 * Created: 12.09.2017 12:59:44
 *  Author: USER
 */ 

//#define LIS331DLH_H_

#ifndef YAS_ACC_DRIVER
#define YAS_ACC_DRIVER LIS331DLH_H_

#define YAS_NO_ERROR						(0)
#define YAS_ERROR_ARG						(-1)
#define YAS_ERROR_NOT_INITIALIZED			(-2)
#define YAS_ERROR_BUSY						(-3)
#define YAS_ERROR_DEVICE_COMMUNICATION		(-4)
#define YAS_ERROR_CHIP_ID					(-5)
#define YAS_ERROR_NOT_ACTIVE				(-6)
#define YAS_ERROR_RESTARTSYS				(-7)
#define YAS_ERROR_HARDOFFSET_NOT_WRITTEN	(-8)
#define YAS_ERROR_INTERRUPT					(-9)
#define YAS_ERROR_ERROR						(-128)

//#define NULL ((void *)(0))
#define ABS(a) ((a) > 0 ? (a) : -(a))

#define LIS331DLH_TWI_ADDR					0x18



#define YAS_ACC_DEFAULT_FILTER_THRESH									(95760) /* ((9.576 um/s^2)/count*10 */

#define YAS_LIS331DLH_RESOLUTION                                            1024

/* Axes data range  [um/s^2] */
//#define YAS_LIS331DLH_GRAVITY_EARTH                                      9806550
#define YAS_LIS331DLH_GRAVITY_EARTH					                     9806650 // wikipedia
#define YAS_LIS331DLH_ABSMIN_2G               (-YAS_LIS331DLH_GRAVITY_EARTH * 2)
#define YAS_LIS331DLH_ABSMAX_2G                (YAS_LIS331DLH_GRAVITY_EARTH * 2)


/* Default parameters */
#define YAS_LIS331DLH_DEFAULT_DELAY                                          100
#define YAS_LIS331DLH_DEFAULT_POSITION                                         0

#define YAS_LIS331DLH_MAX_DELAY                                              200
#define YAS_LIS331DLH_MIN_DELAY                                               10

/* Registers */
#define YAS_LIS331DLH_WHO_AM_I_REG                                          0x0f
#define YAS_LIS331DLH_WHO_AM_I                                              0x32

#define YAS_LIS331DLH_CTRL_REG1                                             0x20
#define YAS_LIS331DLH_CTRL_REG2                                             0x21
#define YAS_LIS331DLH_CTRL_REG3                                             0x22
#define YAS_LIS331DLH_CTRL_REG4                                             0x23
#define YAS_LIS331DLH_CTRL_REG5                                             0x24

#define YAS_LIS331DLH_X_ENABLE                                              0x01
#define YAS_LIS331DLH_Y_ENABLE                                              0x02
#define YAS_LIS331DLH_Z_ENABLE                                              0x04
#define YAS_LIS331DLH_XYZ_ENABLE                                            0x07

#define YAS_LIS331DLH_BDU_ON                                                0x80
#define YAS_LIS331DLH_BDU_OFF                                               0x00
#define YAS_LIS331DLH_BLE_BE                                                0x40
#define YAS_LIS331DLH_BLE_LE                                                0x00
#define YAS_LIS331DLH_FS_2G                                                 0x00
#define YAS_LIS331DLH_FS_4G                                                 0x10
#define YAS_LIS331DLH_FS_8G                                                 0x20

/* DR bits of CTRL_REG1 in low power mode */
#define YAS_DR_LP_LPF_37HZ                                                (0<<3)
#define YAS_DR_LP_LPF_74HZ                                                (1<<3)
#define YAS_DR_LP_LPF_292HZ                                               (2<<3)
#define YAS_DR_LP_LPF_780HZ                                               (3<<3)


#define YAS_LIS331DLH_ACC_REG                                               0x28

struct yas_acc_filter {
	int threshold; /* um/s^2 */
};

struct yas_vector {
	int32_t v[3];
};

struct yas_acc_data {
	struct yas_vector xyz;
	struct yas_vector raw;
};

struct yas_acc_driver_callback {
	int (*lock)(void);
	int (*unlock)(void);
	int (*device_open)(void);
	int (*device_close)(void);
	int (*device_write)(uint8_t adr, const uint8_t *buf, int len);
	int (*device_read) (uint8_t adr, uint8_t *buf, int len);
	void (*msleep)(int msec);
};

struct yas_acc_driver {
	int (*init)(void);
	int (*term)(void);
	int (*get_delay)(void);
	int (*set_delay)(int delay);
	int (*get_offset)(struct yas_vector *offset);
	int (*set_offset)(struct yas_vector *offset);
	int (*get_enable)(void);
	int (*set_enable)(int enable);
	int (*get_filter)(struct yas_acc_filter *filter);
	int (*set_filter)(struct yas_acc_filter *filter);
	int (*get_filter_enable)(void);
	int (*set_filter_enable)(int enable);
	int (*get_position)(void);
	int (*set_position)(int position);
	int (*measure)(struct yas_acc_data *data);
	#if DEBUG
	int (*get_register)(uint8_t adr, uint8_t *val);
	#endif
	struct yas_acc_driver_callback callback;
};

int yas_acc_driver_init(struct yas_acc_driver *f);



#endif /* YAS_ACC_DRIVER-LIS331DLH_H_ */