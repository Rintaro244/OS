/* FIFO���C�u���� */

#include "bootpack.h"

#define FLAGS_OVERRUN		0x0001

void fifo8_init(struct FIFO8 *fifo, int size, unsigned char *buf)
/* FIFO�o�b�t�@�̏����� */
{
	fifo->size = size;
	fifo->buf = buf;
	fifo->free = size; /* �� */
	fifo->flags = 0;
	fifo->p = 0; /* �������݈ʒu */
	fifo->q = 0; /* �ǂݍ��݈ʒu */
	return;
}

int fifo8_put(struct FIFO8 *fifo, unsigned char data)
/* FIFO�փf�[�^�𑗂荞��Œ~���� */
{
	if (fifo->free == 0) {
		/* �󂫂��Ȃ��Ă��ӂꂽ */
		fifo->flags |= FLAGS_OVERRUN;
		return -1;
	}
	fifo->buf[fifo->p] = data;
	fifo->p++;
	if (fifo->p == fifo->size) {
		fifo->p = 0;
	}
	fifo->free--;
	return 0;
}

int fifo8_get(struct FIFO8 *fifo)
/* FIFO����f�[�^����Ƃ��Ă��� */
{
	int data;
	if (fifo->free == fifo->size) {
		/* �o�b�t�@������ۂ̂Ƃ��́A�Ƃ肠����-1���Ԃ���� */
		return -1;
	}
	data = fifo->buf[fifo->q];
	fifo->q++;
	if (fifo->q == fifo->size) {
		fifo->q = 0;
	}
	fifo->free++;
	return data;
}

int fifo8_status(struct FIFO8 *fifo)
/* �ǂ̂��炢�f�[�^�����܂��Ă��邩��񍐂��� */
{
	return fifo->size - fifo->free;
}
