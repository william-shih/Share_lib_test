CC = g++
CFLAGS = -fPIC -Wall -Wextra -O2 -g
LDFLAGS = -shared
RM = rm -f
TARGET_SHARED_LIB = libtestso.so
LIB_DIR = lib

SRCS = test.c testso.c
OBJS = $(SRCS:.c=.o)

.PHONY: all
all: $(TARGET_SHARED_LIB)
	$(CC) test.c $(CFLAGS) -o test -L$(LIB_DIR) -ldl

$(TARGET_SHARED_LIB): $(OBJS)
	$(CC) ${LDFLAGS} -o $@ $^
	@mv $(TARGET_SHARED_LIB) $(LIB_DIR)
$(SRCS:.c=.d):%.d:%.c
	$(CC) $(CFLAGS) -MM $< >$@

include $(SRCS:.c=.d)
.PHONY: clean
clean:
	-${RM} ${TARGET_LIB} ${OBJS} ${SRCS:.c=.d}
