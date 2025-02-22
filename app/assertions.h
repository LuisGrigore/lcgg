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
            printf("Assertion failed: %s != %s :", #expected, #actual); \
			printf(RED "%s\n" RESET,KO); \
            exit(1); \
        } \
    } while (0); \
	printf(GREEN "%s" RESET,OK);

#define assert_true(condition) \
    do { \
        if (!(condition)) { \
            printf("Assertion failed: %s is not true :", #condition); \
			printf(RED "%s\n" RESET,KO); \
			exit(1); \
        } \
    } while (0); \
	printf(GREEN "%s" RESET,OK);

#define assert_false(condition) \
    do { \
        if (condition) { \
            printf("Assertion failed: %s is not false :", #condition); \
			printf(RED "%s\n" RESET,KO); \
			exit(1); \
        } \
    } while (0); \
	printf(GREEN "%s" RESET,OK);

#define assert_not_null(ptr) \
    do { \
        if ((ptr) == NULL) { \
            printf("Assertion failed: %s is NULL :", #ptr); \
			printf(RED "%s\n" RESET,KO); \
			exit(1); \
        } \
    } while (0); \
	printf(GREEN "%s" RESET,OK);

#define start_unit_test() \
	printf("%s:\n", __func__);

#endif