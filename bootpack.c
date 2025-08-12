/* ���̃t�@�C���ō�����֐�������܂���C�R���p�C���ɋ����� */

void io_hlt(void);

/* �֐��錾�Ȃ̂ɁA{}���Ȃ��Ă����Ȃ�;�������ƁA
	���̃t�@�C���ɂ��邩���낵���ˁA�Ƃ����Ӗ��ɂȂ�̂ł��B */

void HariMain(void)
{

fin:
	io_hlt(); /* �����naskfunc.nas��_io_hlt�����s����܂� */
	goto fin;

}
