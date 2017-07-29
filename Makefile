CC = gcc
CFLAGS = -fPIC -Wall -Wextra -O2 -g
LDFLAGS = -shared
RM = rm -f
TARGET_SHARED_LIB = libtestso.so
LIB_DIR = lib

SRCS = test.c
LIB_SRCS =  testso.c
OBJS = $(SRCS:.c=.o)
LIB_OBJS = $(LIB_SRCS:.c=.o)
TARGET=test

.PHONY: all
all: $(TARGET_SHARED_LIB)
	$(CC) $(SRCS) $(CFLAGS) -o $(TARGET) -L$(LIB_DIR) -ldl

$(TARGET_SHARED_LIB): $(LIB_OBJS)
	$(CC) ${LDFLAGS} -o $@ $^
	@mv $(TARGET_SHARED_LIB) $(LIB_DIR)
$(LIB_OBJS): $(LIB_SRCS)
	$(CC) -c $^
$(SRCS:.c=.d):%.d:%.c
	$(CC) $(CFLAGS) -MM $< >$@

-include $(SRCS:.c=.d)

.PHONY: clean
clean:
	-${RM} ${TARGET} ${OBJS} ${SRCS:.c=.d} ${LIB_OBJS} ${LIB_SRCS:.c=.d} ${LIB_DIR}/${TARGET_SHARED_LIB}
