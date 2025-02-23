#ifndef ASSERTIONS
#	define ASSERTIONS
#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#define OK "OK"
#define KO "KO"

#define RED     "\x1b[31m"
#define GREEN   "\x1b[32m"
#define RESET   "\x1b[0m"

#define assert_equal_str(expected, actual) \
    do { \
        if (strcmp((expected), (actual)) != 0) { \
            printf(RED "(Assertion failed: %s != %s) " RESET, #expected, #actual); \
        } \
        else { \
            printf(GREEN "%s " RESET, OK); \
        } \
    } while (0);

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

#define capture_output(buffer, size, output, func_call) \
do { \
    int pipefd[2]; \
    if (pipe(pipefd) == -1) { \
        perror("pipe falló"); \
        exit(1); \
    } \
    \
    fflush(output); \
    pid_t pid = fork(); \
    if (pid == -1) { \
        perror("fork falló"); \
        exit(1); \
    } \
    if (pid == 0) {\
        close(pipefd[0]);\
        dup2(pipefd[1], fileno(output));\
        close(pipefd[1]); \
        func_call;\
        fflush(output); \
        exit(0); \
    } else {\
        close(pipefd[1]);\
        read(pipefd[0], buffer, size - 1);\
        close(pipefd[0]); \
        wait(NULL);\
    } \
} while (0);

#define start_unit_test() \
	printf("\n%s: ", __func__);

#endif