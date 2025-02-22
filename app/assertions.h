#ifndef ASSERTIONS
#	define ASSERTIONS
#include <stdio.h>
#include <assert.h>
#include <stdlib.h>

#define OK "OK"
#define KO "KO"

#define RED     "\x1b[31m"
#define GREEN   "\x1b[32m"
#define RESET   "\x1b[0m"

#define assert_equal(expected, actual) \
    do { \
        if ((expected) != (actual)) { \
            printf(RED "(Assertion failed: %s != %s) " RESET, #expected, #actual); \
        } \
		else { \
			printf(GREEN "%s " RESET,OK); \
		} \
    } while (0);

#define assert_true(condition) \
    do { \
        if (!(condition)) { \
            printf(RED "(Assertion failed: %s is not true) " RESET, #condition); \
        } \
		else { \
			printf(GREEN "%s " RESET,OK); \
		} \
    } while (0);

#define assert_false(condition) \
    do { \
        if (condition) { \
            printf(RED "(Assertion failed: %s is not false) " RESET, #condition); \
        } \
		else { \
			printf(GREEN "%s " RESET,OK); \
		} \
    } while (0);

#define assert_not_null(ptr) \
    do { \
        if ((ptr) == NULL) { \
            printf(RED "(Assertion failed: %s is NULL) " RESET, #ptr); \
			exit(1); \
        } \
		else { \
			printf(GREEN "%s " RESET,OK); \
		} \
    } while (0);

#define assert_null(ptr) \
do { \
    if ((ptr) != NULL) { \
        printf(RED "(Assertion failed: %s is not NULL) " RESET, #ptr); \
    } \
    else { \
        printf(GREEN "%s " RESET, OK); \
    } \
} while (0);

#define start_unit_test() \
	printf("\n%s: ", __func__);

#endif