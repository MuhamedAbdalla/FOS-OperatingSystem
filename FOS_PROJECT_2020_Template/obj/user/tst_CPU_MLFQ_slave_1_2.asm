
obj/user/tst_CPU_MLFQ_slave_1_2:     file format elf32-i386


Disassembly of section .text:

00800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	mov $0, %eax
  800020:	b8 00 00 00 00       	mov    $0x0,%eax
	cmpl $USTACKTOP, %esp
  800025:	81 fc 00 e0 bf ee    	cmp    $0xeebfe000,%esp
	jne args_exist
  80002b:	75 04                	jne    800031 <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushl $0
  80002d:	6a 00                	push   $0x0
	pushl $0
  80002f:	6a 00                	push   $0x0

00800031 <args_exist>:

args_exist:
	call libmain
  800031:	e8 7e 00 00 00       	call   8000b4 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	// Create & run the slave environments
	int ID;
	for(int i = 0; i < 3; ++i)
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800045:	eb 44                	jmp    80008b <_main+0x53>
	{
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  800047:	a1 20 20 80 00       	mov    0x802020,%eax
  80004c:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  800052:	a1 20 20 80 00       	mov    0x802020,%eax
  800057:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80005d:	89 c1                	mov    %eax,%ecx
  80005f:	a1 20 20 80 00       	mov    0x802020,%eax
  800064:	8b 40 74             	mov    0x74(%eax),%eax
  800067:	52                   	push   %edx
  800068:	51                   	push   %ecx
  800069:	50                   	push   %eax
  80006a:	68 e0 19 80 00       	push   $0x8019e0
  80006f:	e8 a4 13 00 00       	call   801418 <sys_create_env>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 f0             	mov    %eax,-0x10(%ebp)
		sys_run_env(ID);
  80007a:	83 ec 0c             	sub    $0xc,%esp
  80007d:	ff 75 f0             	pushl  -0x10(%ebp)
  800080:	e8 b1 13 00 00       	call   801436 <sys_run_env>
  800085:	83 c4 10             	add    $0x10,%esp

void _main(void)
{
	// Create & run the slave environments
	int ID;
	for(int i = 0; i < 3; ++i)
  800088:	ff 45 f4             	incl   -0xc(%ebp)
  80008b:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
  80008f:	7e b6                	jle    800047 <_main+0xf>
	{
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(ID);
	}

	env_sleep(100000);
  800091:	83 ec 0c             	sub    $0xc,%esp
  800094:	68 a0 86 01 00       	push   $0x186a0
  800099:	e8 16 16 00 00       	call   8016b4 <env_sleep>
  80009e:	83 c4 10             	add    $0x10,%esp
	// To ensure that the slave environments completed successfully
	cprintf("Congratulations!! test CPU SCHEDULING using MLFQ is completed successfully.\n");
  8000a1:	83 ec 0c             	sub    $0xc,%esp
  8000a4:	68 f0 19 80 00       	push   $0x8019f0
  8000a9:	e8 1f 02 00 00       	call   8002cd <cprintf>
  8000ae:	83 c4 10             	add    $0x10,%esp

	return;
  8000b1:	90                   	nop
}
  8000b2:	c9                   	leave  
  8000b3:	c3                   	ret    

008000b4 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000b4:	55                   	push   %ebp
  8000b5:	89 e5                	mov    %esp,%ebp
  8000b7:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000ba:	e8 39 10 00 00       	call   8010f8 <sys_getenvindex>
  8000bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000c2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000c5:	89 d0                	mov    %edx,%eax
  8000c7:	c1 e0 03             	shl    $0x3,%eax
  8000ca:	01 d0                	add    %edx,%eax
  8000cc:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8000d3:	01 c8                	add    %ecx,%eax
  8000d5:	01 c0                	add    %eax,%eax
  8000d7:	01 d0                	add    %edx,%eax
  8000d9:	01 c0                	add    %eax,%eax
  8000db:	01 d0                	add    %edx,%eax
  8000dd:	89 c2                	mov    %eax,%edx
  8000df:	c1 e2 05             	shl    $0x5,%edx
  8000e2:	29 c2                	sub    %eax,%edx
  8000e4:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8000eb:	89 c2                	mov    %eax,%edx
  8000ed:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8000f3:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000f8:	a1 20 20 80 00       	mov    0x802020,%eax
  8000fd:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800103:	84 c0                	test   %al,%al
  800105:	74 0f                	je     800116 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800107:	a1 20 20 80 00       	mov    0x802020,%eax
  80010c:	05 40 3c 01 00       	add    $0x13c40,%eax
  800111:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800116:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80011a:	7e 0a                	jle    800126 <libmain+0x72>
		binaryname = argv[0];
  80011c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80011f:	8b 00                	mov    (%eax),%eax
  800121:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800126:	83 ec 08             	sub    $0x8,%esp
  800129:	ff 75 0c             	pushl  0xc(%ebp)
  80012c:	ff 75 08             	pushl  0x8(%ebp)
  80012f:	e8 04 ff ff ff       	call   800038 <_main>
  800134:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800137:	e8 57 11 00 00       	call   801293 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80013c:	83 ec 0c             	sub    $0xc,%esp
  80013f:	68 58 1a 80 00       	push   $0x801a58
  800144:	e8 84 01 00 00       	call   8002cd <cprintf>
  800149:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80014c:	a1 20 20 80 00       	mov    0x802020,%eax
  800151:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800157:	a1 20 20 80 00       	mov    0x802020,%eax
  80015c:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800162:	83 ec 04             	sub    $0x4,%esp
  800165:	52                   	push   %edx
  800166:	50                   	push   %eax
  800167:	68 80 1a 80 00       	push   $0x801a80
  80016c:	e8 5c 01 00 00       	call   8002cd <cprintf>
  800171:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800174:	a1 20 20 80 00       	mov    0x802020,%eax
  800179:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80017f:	a1 20 20 80 00       	mov    0x802020,%eax
  800184:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80018a:	83 ec 04             	sub    $0x4,%esp
  80018d:	52                   	push   %edx
  80018e:	50                   	push   %eax
  80018f:	68 a8 1a 80 00       	push   $0x801aa8
  800194:	e8 34 01 00 00       	call   8002cd <cprintf>
  800199:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80019c:	a1 20 20 80 00       	mov    0x802020,%eax
  8001a1:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8001a7:	83 ec 08             	sub    $0x8,%esp
  8001aa:	50                   	push   %eax
  8001ab:	68 e9 1a 80 00       	push   $0x801ae9
  8001b0:	e8 18 01 00 00       	call   8002cd <cprintf>
  8001b5:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001b8:	83 ec 0c             	sub    $0xc,%esp
  8001bb:	68 58 1a 80 00       	push   $0x801a58
  8001c0:	e8 08 01 00 00       	call   8002cd <cprintf>
  8001c5:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001c8:	e8 e0 10 00 00       	call   8012ad <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001cd:	e8 19 00 00 00       	call   8001eb <exit>
}
  8001d2:	90                   	nop
  8001d3:	c9                   	leave  
  8001d4:	c3                   	ret    

008001d5 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001d5:	55                   	push   %ebp
  8001d6:	89 e5                	mov    %esp,%ebp
  8001d8:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001db:	83 ec 0c             	sub    $0xc,%esp
  8001de:	6a 00                	push   $0x0
  8001e0:	e8 df 0e 00 00       	call   8010c4 <sys_env_destroy>
  8001e5:	83 c4 10             	add    $0x10,%esp
}
  8001e8:	90                   	nop
  8001e9:	c9                   	leave  
  8001ea:	c3                   	ret    

008001eb <exit>:

void
exit(void)
{
  8001eb:	55                   	push   %ebp
  8001ec:	89 e5                	mov    %esp,%ebp
  8001ee:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001f1:	e8 34 0f 00 00       	call   80112a <sys_env_exit>
}
  8001f6:	90                   	nop
  8001f7:	c9                   	leave  
  8001f8:	c3                   	ret    

008001f9 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001f9:	55                   	push   %ebp
  8001fa:	89 e5                	mov    %esp,%ebp
  8001fc:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800202:	8b 00                	mov    (%eax),%eax
  800204:	8d 48 01             	lea    0x1(%eax),%ecx
  800207:	8b 55 0c             	mov    0xc(%ebp),%edx
  80020a:	89 0a                	mov    %ecx,(%edx)
  80020c:	8b 55 08             	mov    0x8(%ebp),%edx
  80020f:	88 d1                	mov    %dl,%cl
  800211:	8b 55 0c             	mov    0xc(%ebp),%edx
  800214:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800218:	8b 45 0c             	mov    0xc(%ebp),%eax
  80021b:	8b 00                	mov    (%eax),%eax
  80021d:	3d ff 00 00 00       	cmp    $0xff,%eax
  800222:	75 2c                	jne    800250 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800224:	a0 24 20 80 00       	mov    0x802024,%al
  800229:	0f b6 c0             	movzbl %al,%eax
  80022c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80022f:	8b 12                	mov    (%edx),%edx
  800231:	89 d1                	mov    %edx,%ecx
  800233:	8b 55 0c             	mov    0xc(%ebp),%edx
  800236:	83 c2 08             	add    $0x8,%edx
  800239:	83 ec 04             	sub    $0x4,%esp
  80023c:	50                   	push   %eax
  80023d:	51                   	push   %ecx
  80023e:	52                   	push   %edx
  80023f:	e8 3e 0e 00 00       	call   801082 <sys_cputs>
  800244:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800247:	8b 45 0c             	mov    0xc(%ebp),%eax
  80024a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800250:	8b 45 0c             	mov    0xc(%ebp),%eax
  800253:	8b 40 04             	mov    0x4(%eax),%eax
  800256:	8d 50 01             	lea    0x1(%eax),%edx
  800259:	8b 45 0c             	mov    0xc(%ebp),%eax
  80025c:	89 50 04             	mov    %edx,0x4(%eax)
}
  80025f:	90                   	nop
  800260:	c9                   	leave  
  800261:	c3                   	ret    

00800262 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800262:	55                   	push   %ebp
  800263:	89 e5                	mov    %esp,%ebp
  800265:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80026b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800272:	00 00 00 
	b.cnt = 0;
  800275:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80027c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80027f:	ff 75 0c             	pushl  0xc(%ebp)
  800282:	ff 75 08             	pushl  0x8(%ebp)
  800285:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80028b:	50                   	push   %eax
  80028c:	68 f9 01 80 00       	push   $0x8001f9
  800291:	e8 11 02 00 00       	call   8004a7 <vprintfmt>
  800296:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800299:	a0 24 20 80 00       	mov    0x802024,%al
  80029e:	0f b6 c0             	movzbl %al,%eax
  8002a1:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002a7:	83 ec 04             	sub    $0x4,%esp
  8002aa:	50                   	push   %eax
  8002ab:	52                   	push   %edx
  8002ac:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002b2:	83 c0 08             	add    $0x8,%eax
  8002b5:	50                   	push   %eax
  8002b6:	e8 c7 0d 00 00       	call   801082 <sys_cputs>
  8002bb:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002be:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  8002c5:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002cb:	c9                   	leave  
  8002cc:	c3                   	ret    

008002cd <cprintf>:

int cprintf(const char *fmt, ...) {
  8002cd:	55                   	push   %ebp
  8002ce:	89 e5                	mov    %esp,%ebp
  8002d0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002d3:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  8002da:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e3:	83 ec 08             	sub    $0x8,%esp
  8002e6:	ff 75 f4             	pushl  -0xc(%ebp)
  8002e9:	50                   	push   %eax
  8002ea:	e8 73 ff ff ff       	call   800262 <vcprintf>
  8002ef:	83 c4 10             	add    $0x10,%esp
  8002f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002f8:	c9                   	leave  
  8002f9:	c3                   	ret    

008002fa <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002fa:	55                   	push   %ebp
  8002fb:	89 e5                	mov    %esp,%ebp
  8002fd:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800300:	e8 8e 0f 00 00       	call   801293 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800305:	8d 45 0c             	lea    0xc(%ebp),%eax
  800308:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80030b:	8b 45 08             	mov    0x8(%ebp),%eax
  80030e:	83 ec 08             	sub    $0x8,%esp
  800311:	ff 75 f4             	pushl  -0xc(%ebp)
  800314:	50                   	push   %eax
  800315:	e8 48 ff ff ff       	call   800262 <vcprintf>
  80031a:	83 c4 10             	add    $0x10,%esp
  80031d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800320:	e8 88 0f 00 00       	call   8012ad <sys_enable_interrupt>
	return cnt;
  800325:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800328:	c9                   	leave  
  800329:	c3                   	ret    

0080032a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80032a:	55                   	push   %ebp
  80032b:	89 e5                	mov    %esp,%ebp
  80032d:	53                   	push   %ebx
  80032e:	83 ec 14             	sub    $0x14,%esp
  800331:	8b 45 10             	mov    0x10(%ebp),%eax
  800334:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800337:	8b 45 14             	mov    0x14(%ebp),%eax
  80033a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80033d:	8b 45 18             	mov    0x18(%ebp),%eax
  800340:	ba 00 00 00 00       	mov    $0x0,%edx
  800345:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800348:	77 55                	ja     80039f <printnum+0x75>
  80034a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80034d:	72 05                	jb     800354 <printnum+0x2a>
  80034f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800352:	77 4b                	ja     80039f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800354:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800357:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80035a:	8b 45 18             	mov    0x18(%ebp),%eax
  80035d:	ba 00 00 00 00       	mov    $0x0,%edx
  800362:	52                   	push   %edx
  800363:	50                   	push   %eax
  800364:	ff 75 f4             	pushl  -0xc(%ebp)
  800367:	ff 75 f0             	pushl  -0x10(%ebp)
  80036a:	e8 f9 13 00 00       	call   801768 <__udivdi3>
  80036f:	83 c4 10             	add    $0x10,%esp
  800372:	83 ec 04             	sub    $0x4,%esp
  800375:	ff 75 20             	pushl  0x20(%ebp)
  800378:	53                   	push   %ebx
  800379:	ff 75 18             	pushl  0x18(%ebp)
  80037c:	52                   	push   %edx
  80037d:	50                   	push   %eax
  80037e:	ff 75 0c             	pushl  0xc(%ebp)
  800381:	ff 75 08             	pushl  0x8(%ebp)
  800384:	e8 a1 ff ff ff       	call   80032a <printnum>
  800389:	83 c4 20             	add    $0x20,%esp
  80038c:	eb 1a                	jmp    8003a8 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80038e:	83 ec 08             	sub    $0x8,%esp
  800391:	ff 75 0c             	pushl  0xc(%ebp)
  800394:	ff 75 20             	pushl  0x20(%ebp)
  800397:	8b 45 08             	mov    0x8(%ebp),%eax
  80039a:	ff d0                	call   *%eax
  80039c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80039f:	ff 4d 1c             	decl   0x1c(%ebp)
  8003a2:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003a6:	7f e6                	jg     80038e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003a8:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003ab:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003b6:	53                   	push   %ebx
  8003b7:	51                   	push   %ecx
  8003b8:	52                   	push   %edx
  8003b9:	50                   	push   %eax
  8003ba:	e8 b9 14 00 00       	call   801878 <__umoddi3>
  8003bf:	83 c4 10             	add    $0x10,%esp
  8003c2:	05 14 1d 80 00       	add    $0x801d14,%eax
  8003c7:	8a 00                	mov    (%eax),%al
  8003c9:	0f be c0             	movsbl %al,%eax
  8003cc:	83 ec 08             	sub    $0x8,%esp
  8003cf:	ff 75 0c             	pushl  0xc(%ebp)
  8003d2:	50                   	push   %eax
  8003d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d6:	ff d0                	call   *%eax
  8003d8:	83 c4 10             	add    $0x10,%esp
}
  8003db:	90                   	nop
  8003dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003df:	c9                   	leave  
  8003e0:	c3                   	ret    

008003e1 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003e1:	55                   	push   %ebp
  8003e2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003e4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003e8:	7e 1c                	jle    800406 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ed:	8b 00                	mov    (%eax),%eax
  8003ef:	8d 50 08             	lea    0x8(%eax),%edx
  8003f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f5:	89 10                	mov    %edx,(%eax)
  8003f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fa:	8b 00                	mov    (%eax),%eax
  8003fc:	83 e8 08             	sub    $0x8,%eax
  8003ff:	8b 50 04             	mov    0x4(%eax),%edx
  800402:	8b 00                	mov    (%eax),%eax
  800404:	eb 40                	jmp    800446 <getuint+0x65>
	else if (lflag)
  800406:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80040a:	74 1e                	je     80042a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80040c:	8b 45 08             	mov    0x8(%ebp),%eax
  80040f:	8b 00                	mov    (%eax),%eax
  800411:	8d 50 04             	lea    0x4(%eax),%edx
  800414:	8b 45 08             	mov    0x8(%ebp),%eax
  800417:	89 10                	mov    %edx,(%eax)
  800419:	8b 45 08             	mov    0x8(%ebp),%eax
  80041c:	8b 00                	mov    (%eax),%eax
  80041e:	83 e8 04             	sub    $0x4,%eax
  800421:	8b 00                	mov    (%eax),%eax
  800423:	ba 00 00 00 00       	mov    $0x0,%edx
  800428:	eb 1c                	jmp    800446 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80042a:	8b 45 08             	mov    0x8(%ebp),%eax
  80042d:	8b 00                	mov    (%eax),%eax
  80042f:	8d 50 04             	lea    0x4(%eax),%edx
  800432:	8b 45 08             	mov    0x8(%ebp),%eax
  800435:	89 10                	mov    %edx,(%eax)
  800437:	8b 45 08             	mov    0x8(%ebp),%eax
  80043a:	8b 00                	mov    (%eax),%eax
  80043c:	83 e8 04             	sub    $0x4,%eax
  80043f:	8b 00                	mov    (%eax),%eax
  800441:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800446:	5d                   	pop    %ebp
  800447:	c3                   	ret    

00800448 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800448:	55                   	push   %ebp
  800449:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80044b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80044f:	7e 1c                	jle    80046d <getint+0x25>
		return va_arg(*ap, long long);
  800451:	8b 45 08             	mov    0x8(%ebp),%eax
  800454:	8b 00                	mov    (%eax),%eax
  800456:	8d 50 08             	lea    0x8(%eax),%edx
  800459:	8b 45 08             	mov    0x8(%ebp),%eax
  80045c:	89 10                	mov    %edx,(%eax)
  80045e:	8b 45 08             	mov    0x8(%ebp),%eax
  800461:	8b 00                	mov    (%eax),%eax
  800463:	83 e8 08             	sub    $0x8,%eax
  800466:	8b 50 04             	mov    0x4(%eax),%edx
  800469:	8b 00                	mov    (%eax),%eax
  80046b:	eb 38                	jmp    8004a5 <getint+0x5d>
	else if (lflag)
  80046d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800471:	74 1a                	je     80048d <getint+0x45>
		return va_arg(*ap, long);
  800473:	8b 45 08             	mov    0x8(%ebp),%eax
  800476:	8b 00                	mov    (%eax),%eax
  800478:	8d 50 04             	lea    0x4(%eax),%edx
  80047b:	8b 45 08             	mov    0x8(%ebp),%eax
  80047e:	89 10                	mov    %edx,(%eax)
  800480:	8b 45 08             	mov    0x8(%ebp),%eax
  800483:	8b 00                	mov    (%eax),%eax
  800485:	83 e8 04             	sub    $0x4,%eax
  800488:	8b 00                	mov    (%eax),%eax
  80048a:	99                   	cltd   
  80048b:	eb 18                	jmp    8004a5 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80048d:	8b 45 08             	mov    0x8(%ebp),%eax
  800490:	8b 00                	mov    (%eax),%eax
  800492:	8d 50 04             	lea    0x4(%eax),%edx
  800495:	8b 45 08             	mov    0x8(%ebp),%eax
  800498:	89 10                	mov    %edx,(%eax)
  80049a:	8b 45 08             	mov    0x8(%ebp),%eax
  80049d:	8b 00                	mov    (%eax),%eax
  80049f:	83 e8 04             	sub    $0x4,%eax
  8004a2:	8b 00                	mov    (%eax),%eax
  8004a4:	99                   	cltd   
}
  8004a5:	5d                   	pop    %ebp
  8004a6:	c3                   	ret    

008004a7 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004a7:	55                   	push   %ebp
  8004a8:	89 e5                	mov    %esp,%ebp
  8004aa:	56                   	push   %esi
  8004ab:	53                   	push   %ebx
  8004ac:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004af:	eb 17                	jmp    8004c8 <vprintfmt+0x21>
			if (ch == '\0')
  8004b1:	85 db                	test   %ebx,%ebx
  8004b3:	0f 84 af 03 00 00    	je     800868 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004b9:	83 ec 08             	sub    $0x8,%esp
  8004bc:	ff 75 0c             	pushl  0xc(%ebp)
  8004bf:	53                   	push   %ebx
  8004c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c3:	ff d0                	call   *%eax
  8004c5:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8004cb:	8d 50 01             	lea    0x1(%eax),%edx
  8004ce:	89 55 10             	mov    %edx,0x10(%ebp)
  8004d1:	8a 00                	mov    (%eax),%al
  8004d3:	0f b6 d8             	movzbl %al,%ebx
  8004d6:	83 fb 25             	cmp    $0x25,%ebx
  8004d9:	75 d6                	jne    8004b1 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004db:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004df:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004e6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004ed:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004f4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8004fe:	8d 50 01             	lea    0x1(%eax),%edx
  800501:	89 55 10             	mov    %edx,0x10(%ebp)
  800504:	8a 00                	mov    (%eax),%al
  800506:	0f b6 d8             	movzbl %al,%ebx
  800509:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80050c:	83 f8 55             	cmp    $0x55,%eax
  80050f:	0f 87 2b 03 00 00    	ja     800840 <vprintfmt+0x399>
  800515:	8b 04 85 38 1d 80 00 	mov    0x801d38(,%eax,4),%eax
  80051c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80051e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800522:	eb d7                	jmp    8004fb <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800524:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800528:	eb d1                	jmp    8004fb <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80052a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800531:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800534:	89 d0                	mov    %edx,%eax
  800536:	c1 e0 02             	shl    $0x2,%eax
  800539:	01 d0                	add    %edx,%eax
  80053b:	01 c0                	add    %eax,%eax
  80053d:	01 d8                	add    %ebx,%eax
  80053f:	83 e8 30             	sub    $0x30,%eax
  800542:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800545:	8b 45 10             	mov    0x10(%ebp),%eax
  800548:	8a 00                	mov    (%eax),%al
  80054a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80054d:	83 fb 2f             	cmp    $0x2f,%ebx
  800550:	7e 3e                	jle    800590 <vprintfmt+0xe9>
  800552:	83 fb 39             	cmp    $0x39,%ebx
  800555:	7f 39                	jg     800590 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800557:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80055a:	eb d5                	jmp    800531 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80055c:	8b 45 14             	mov    0x14(%ebp),%eax
  80055f:	83 c0 04             	add    $0x4,%eax
  800562:	89 45 14             	mov    %eax,0x14(%ebp)
  800565:	8b 45 14             	mov    0x14(%ebp),%eax
  800568:	83 e8 04             	sub    $0x4,%eax
  80056b:	8b 00                	mov    (%eax),%eax
  80056d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800570:	eb 1f                	jmp    800591 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800572:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800576:	79 83                	jns    8004fb <vprintfmt+0x54>
				width = 0;
  800578:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80057f:	e9 77 ff ff ff       	jmp    8004fb <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800584:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80058b:	e9 6b ff ff ff       	jmp    8004fb <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800590:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800591:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800595:	0f 89 60 ff ff ff    	jns    8004fb <vprintfmt+0x54>
				width = precision, precision = -1;
  80059b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80059e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005a1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005a8:	e9 4e ff ff ff       	jmp    8004fb <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005ad:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005b0:	e9 46 ff ff ff       	jmp    8004fb <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b8:	83 c0 04             	add    $0x4,%eax
  8005bb:	89 45 14             	mov    %eax,0x14(%ebp)
  8005be:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c1:	83 e8 04             	sub    $0x4,%eax
  8005c4:	8b 00                	mov    (%eax),%eax
  8005c6:	83 ec 08             	sub    $0x8,%esp
  8005c9:	ff 75 0c             	pushl  0xc(%ebp)
  8005cc:	50                   	push   %eax
  8005cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d0:	ff d0                	call   *%eax
  8005d2:	83 c4 10             	add    $0x10,%esp
			break;
  8005d5:	e9 89 02 00 00       	jmp    800863 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005da:	8b 45 14             	mov    0x14(%ebp),%eax
  8005dd:	83 c0 04             	add    $0x4,%eax
  8005e0:	89 45 14             	mov    %eax,0x14(%ebp)
  8005e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e6:	83 e8 04             	sub    $0x4,%eax
  8005e9:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005eb:	85 db                	test   %ebx,%ebx
  8005ed:	79 02                	jns    8005f1 <vprintfmt+0x14a>
				err = -err;
  8005ef:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005f1:	83 fb 64             	cmp    $0x64,%ebx
  8005f4:	7f 0b                	jg     800601 <vprintfmt+0x15a>
  8005f6:	8b 34 9d 80 1b 80 00 	mov    0x801b80(,%ebx,4),%esi
  8005fd:	85 f6                	test   %esi,%esi
  8005ff:	75 19                	jne    80061a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800601:	53                   	push   %ebx
  800602:	68 25 1d 80 00       	push   $0x801d25
  800607:	ff 75 0c             	pushl  0xc(%ebp)
  80060a:	ff 75 08             	pushl  0x8(%ebp)
  80060d:	e8 5e 02 00 00       	call   800870 <printfmt>
  800612:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800615:	e9 49 02 00 00       	jmp    800863 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80061a:	56                   	push   %esi
  80061b:	68 2e 1d 80 00       	push   $0x801d2e
  800620:	ff 75 0c             	pushl  0xc(%ebp)
  800623:	ff 75 08             	pushl  0x8(%ebp)
  800626:	e8 45 02 00 00       	call   800870 <printfmt>
  80062b:	83 c4 10             	add    $0x10,%esp
			break;
  80062e:	e9 30 02 00 00       	jmp    800863 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800633:	8b 45 14             	mov    0x14(%ebp),%eax
  800636:	83 c0 04             	add    $0x4,%eax
  800639:	89 45 14             	mov    %eax,0x14(%ebp)
  80063c:	8b 45 14             	mov    0x14(%ebp),%eax
  80063f:	83 e8 04             	sub    $0x4,%eax
  800642:	8b 30                	mov    (%eax),%esi
  800644:	85 f6                	test   %esi,%esi
  800646:	75 05                	jne    80064d <vprintfmt+0x1a6>
				p = "(null)";
  800648:	be 31 1d 80 00       	mov    $0x801d31,%esi
			if (width > 0 && padc != '-')
  80064d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800651:	7e 6d                	jle    8006c0 <vprintfmt+0x219>
  800653:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800657:	74 67                	je     8006c0 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800659:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80065c:	83 ec 08             	sub    $0x8,%esp
  80065f:	50                   	push   %eax
  800660:	56                   	push   %esi
  800661:	e8 0c 03 00 00       	call   800972 <strnlen>
  800666:	83 c4 10             	add    $0x10,%esp
  800669:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80066c:	eb 16                	jmp    800684 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80066e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800672:	83 ec 08             	sub    $0x8,%esp
  800675:	ff 75 0c             	pushl  0xc(%ebp)
  800678:	50                   	push   %eax
  800679:	8b 45 08             	mov    0x8(%ebp),%eax
  80067c:	ff d0                	call   *%eax
  80067e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800681:	ff 4d e4             	decl   -0x1c(%ebp)
  800684:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800688:	7f e4                	jg     80066e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80068a:	eb 34                	jmp    8006c0 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80068c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800690:	74 1c                	je     8006ae <vprintfmt+0x207>
  800692:	83 fb 1f             	cmp    $0x1f,%ebx
  800695:	7e 05                	jle    80069c <vprintfmt+0x1f5>
  800697:	83 fb 7e             	cmp    $0x7e,%ebx
  80069a:	7e 12                	jle    8006ae <vprintfmt+0x207>
					putch('?', putdat);
  80069c:	83 ec 08             	sub    $0x8,%esp
  80069f:	ff 75 0c             	pushl  0xc(%ebp)
  8006a2:	6a 3f                	push   $0x3f
  8006a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a7:	ff d0                	call   *%eax
  8006a9:	83 c4 10             	add    $0x10,%esp
  8006ac:	eb 0f                	jmp    8006bd <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006ae:	83 ec 08             	sub    $0x8,%esp
  8006b1:	ff 75 0c             	pushl  0xc(%ebp)
  8006b4:	53                   	push   %ebx
  8006b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b8:	ff d0                	call   *%eax
  8006ba:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006bd:	ff 4d e4             	decl   -0x1c(%ebp)
  8006c0:	89 f0                	mov    %esi,%eax
  8006c2:	8d 70 01             	lea    0x1(%eax),%esi
  8006c5:	8a 00                	mov    (%eax),%al
  8006c7:	0f be d8             	movsbl %al,%ebx
  8006ca:	85 db                	test   %ebx,%ebx
  8006cc:	74 24                	je     8006f2 <vprintfmt+0x24b>
  8006ce:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006d2:	78 b8                	js     80068c <vprintfmt+0x1e5>
  8006d4:	ff 4d e0             	decl   -0x20(%ebp)
  8006d7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006db:	79 af                	jns    80068c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006dd:	eb 13                	jmp    8006f2 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006df:	83 ec 08             	sub    $0x8,%esp
  8006e2:	ff 75 0c             	pushl  0xc(%ebp)
  8006e5:	6a 20                	push   $0x20
  8006e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ea:	ff d0                	call   *%eax
  8006ec:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006ef:	ff 4d e4             	decl   -0x1c(%ebp)
  8006f2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006f6:	7f e7                	jg     8006df <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006f8:	e9 66 01 00 00       	jmp    800863 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006fd:	83 ec 08             	sub    $0x8,%esp
  800700:	ff 75 e8             	pushl  -0x18(%ebp)
  800703:	8d 45 14             	lea    0x14(%ebp),%eax
  800706:	50                   	push   %eax
  800707:	e8 3c fd ff ff       	call   800448 <getint>
  80070c:	83 c4 10             	add    $0x10,%esp
  80070f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800712:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800715:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800718:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80071b:	85 d2                	test   %edx,%edx
  80071d:	79 23                	jns    800742 <vprintfmt+0x29b>
				putch('-', putdat);
  80071f:	83 ec 08             	sub    $0x8,%esp
  800722:	ff 75 0c             	pushl  0xc(%ebp)
  800725:	6a 2d                	push   $0x2d
  800727:	8b 45 08             	mov    0x8(%ebp),%eax
  80072a:	ff d0                	call   *%eax
  80072c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80072f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800732:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800735:	f7 d8                	neg    %eax
  800737:	83 d2 00             	adc    $0x0,%edx
  80073a:	f7 da                	neg    %edx
  80073c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80073f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800742:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800749:	e9 bc 00 00 00       	jmp    80080a <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80074e:	83 ec 08             	sub    $0x8,%esp
  800751:	ff 75 e8             	pushl  -0x18(%ebp)
  800754:	8d 45 14             	lea    0x14(%ebp),%eax
  800757:	50                   	push   %eax
  800758:	e8 84 fc ff ff       	call   8003e1 <getuint>
  80075d:	83 c4 10             	add    $0x10,%esp
  800760:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800763:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800766:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80076d:	e9 98 00 00 00       	jmp    80080a <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800772:	83 ec 08             	sub    $0x8,%esp
  800775:	ff 75 0c             	pushl  0xc(%ebp)
  800778:	6a 58                	push   $0x58
  80077a:	8b 45 08             	mov    0x8(%ebp),%eax
  80077d:	ff d0                	call   *%eax
  80077f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800782:	83 ec 08             	sub    $0x8,%esp
  800785:	ff 75 0c             	pushl  0xc(%ebp)
  800788:	6a 58                	push   $0x58
  80078a:	8b 45 08             	mov    0x8(%ebp),%eax
  80078d:	ff d0                	call   *%eax
  80078f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800792:	83 ec 08             	sub    $0x8,%esp
  800795:	ff 75 0c             	pushl  0xc(%ebp)
  800798:	6a 58                	push   $0x58
  80079a:	8b 45 08             	mov    0x8(%ebp),%eax
  80079d:	ff d0                	call   *%eax
  80079f:	83 c4 10             	add    $0x10,%esp
			break;
  8007a2:	e9 bc 00 00 00       	jmp    800863 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007a7:	83 ec 08             	sub    $0x8,%esp
  8007aa:	ff 75 0c             	pushl  0xc(%ebp)
  8007ad:	6a 30                	push   $0x30
  8007af:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b2:	ff d0                	call   *%eax
  8007b4:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007b7:	83 ec 08             	sub    $0x8,%esp
  8007ba:	ff 75 0c             	pushl  0xc(%ebp)
  8007bd:	6a 78                	push   $0x78
  8007bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c2:	ff d0                	call   *%eax
  8007c4:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ca:	83 c0 04             	add    $0x4,%eax
  8007cd:	89 45 14             	mov    %eax,0x14(%ebp)
  8007d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d3:	83 e8 04             	sub    $0x4,%eax
  8007d6:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007e2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007e9:	eb 1f                	jmp    80080a <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007eb:	83 ec 08             	sub    $0x8,%esp
  8007ee:	ff 75 e8             	pushl  -0x18(%ebp)
  8007f1:	8d 45 14             	lea    0x14(%ebp),%eax
  8007f4:	50                   	push   %eax
  8007f5:	e8 e7 fb ff ff       	call   8003e1 <getuint>
  8007fa:	83 c4 10             	add    $0x10,%esp
  8007fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800800:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800803:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80080a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80080e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800811:	83 ec 04             	sub    $0x4,%esp
  800814:	52                   	push   %edx
  800815:	ff 75 e4             	pushl  -0x1c(%ebp)
  800818:	50                   	push   %eax
  800819:	ff 75 f4             	pushl  -0xc(%ebp)
  80081c:	ff 75 f0             	pushl  -0x10(%ebp)
  80081f:	ff 75 0c             	pushl  0xc(%ebp)
  800822:	ff 75 08             	pushl  0x8(%ebp)
  800825:	e8 00 fb ff ff       	call   80032a <printnum>
  80082a:	83 c4 20             	add    $0x20,%esp
			break;
  80082d:	eb 34                	jmp    800863 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80082f:	83 ec 08             	sub    $0x8,%esp
  800832:	ff 75 0c             	pushl  0xc(%ebp)
  800835:	53                   	push   %ebx
  800836:	8b 45 08             	mov    0x8(%ebp),%eax
  800839:	ff d0                	call   *%eax
  80083b:	83 c4 10             	add    $0x10,%esp
			break;
  80083e:	eb 23                	jmp    800863 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800840:	83 ec 08             	sub    $0x8,%esp
  800843:	ff 75 0c             	pushl  0xc(%ebp)
  800846:	6a 25                	push   $0x25
  800848:	8b 45 08             	mov    0x8(%ebp),%eax
  80084b:	ff d0                	call   *%eax
  80084d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800850:	ff 4d 10             	decl   0x10(%ebp)
  800853:	eb 03                	jmp    800858 <vprintfmt+0x3b1>
  800855:	ff 4d 10             	decl   0x10(%ebp)
  800858:	8b 45 10             	mov    0x10(%ebp),%eax
  80085b:	48                   	dec    %eax
  80085c:	8a 00                	mov    (%eax),%al
  80085e:	3c 25                	cmp    $0x25,%al
  800860:	75 f3                	jne    800855 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800862:	90                   	nop
		}
	}
  800863:	e9 47 fc ff ff       	jmp    8004af <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800868:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800869:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80086c:	5b                   	pop    %ebx
  80086d:	5e                   	pop    %esi
  80086e:	5d                   	pop    %ebp
  80086f:	c3                   	ret    

00800870 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800870:	55                   	push   %ebp
  800871:	89 e5                	mov    %esp,%ebp
  800873:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800876:	8d 45 10             	lea    0x10(%ebp),%eax
  800879:	83 c0 04             	add    $0x4,%eax
  80087c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80087f:	8b 45 10             	mov    0x10(%ebp),%eax
  800882:	ff 75 f4             	pushl  -0xc(%ebp)
  800885:	50                   	push   %eax
  800886:	ff 75 0c             	pushl  0xc(%ebp)
  800889:	ff 75 08             	pushl  0x8(%ebp)
  80088c:	e8 16 fc ff ff       	call   8004a7 <vprintfmt>
  800891:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800894:	90                   	nop
  800895:	c9                   	leave  
  800896:	c3                   	ret    

00800897 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800897:	55                   	push   %ebp
  800898:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80089a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089d:	8b 40 08             	mov    0x8(%eax),%eax
  8008a0:	8d 50 01             	lea    0x1(%eax),%edx
  8008a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a6:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ac:	8b 10                	mov    (%eax),%edx
  8008ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b1:	8b 40 04             	mov    0x4(%eax),%eax
  8008b4:	39 c2                	cmp    %eax,%edx
  8008b6:	73 12                	jae    8008ca <sprintputch+0x33>
		*b->buf++ = ch;
  8008b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008bb:	8b 00                	mov    (%eax),%eax
  8008bd:	8d 48 01             	lea    0x1(%eax),%ecx
  8008c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008c3:	89 0a                	mov    %ecx,(%edx)
  8008c5:	8b 55 08             	mov    0x8(%ebp),%edx
  8008c8:	88 10                	mov    %dl,(%eax)
}
  8008ca:	90                   	nop
  8008cb:	5d                   	pop    %ebp
  8008cc:	c3                   	ret    

008008cd <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008cd:	55                   	push   %ebp
  8008ce:	89 e5                	mov    %esp,%ebp
  8008d0:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008dc:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008df:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e2:	01 d0                	add    %edx,%eax
  8008e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008ee:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008f2:	74 06                	je     8008fa <vsnprintf+0x2d>
  8008f4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008f8:	7f 07                	jg     800901 <vsnprintf+0x34>
		return -E_INVAL;
  8008fa:	b8 03 00 00 00       	mov    $0x3,%eax
  8008ff:	eb 20                	jmp    800921 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800901:	ff 75 14             	pushl  0x14(%ebp)
  800904:	ff 75 10             	pushl  0x10(%ebp)
  800907:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80090a:	50                   	push   %eax
  80090b:	68 97 08 80 00       	push   $0x800897
  800910:	e8 92 fb ff ff       	call   8004a7 <vprintfmt>
  800915:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800918:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80091b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80091e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800921:	c9                   	leave  
  800922:	c3                   	ret    

00800923 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800923:	55                   	push   %ebp
  800924:	89 e5                	mov    %esp,%ebp
  800926:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800929:	8d 45 10             	lea    0x10(%ebp),%eax
  80092c:	83 c0 04             	add    $0x4,%eax
  80092f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800932:	8b 45 10             	mov    0x10(%ebp),%eax
  800935:	ff 75 f4             	pushl  -0xc(%ebp)
  800938:	50                   	push   %eax
  800939:	ff 75 0c             	pushl  0xc(%ebp)
  80093c:	ff 75 08             	pushl  0x8(%ebp)
  80093f:	e8 89 ff ff ff       	call   8008cd <vsnprintf>
  800944:	83 c4 10             	add    $0x10,%esp
  800947:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80094a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80094d:	c9                   	leave  
  80094e:	c3                   	ret    

0080094f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80094f:	55                   	push   %ebp
  800950:	89 e5                	mov    %esp,%ebp
  800952:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800955:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80095c:	eb 06                	jmp    800964 <strlen+0x15>
		n++;
  80095e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800961:	ff 45 08             	incl   0x8(%ebp)
  800964:	8b 45 08             	mov    0x8(%ebp),%eax
  800967:	8a 00                	mov    (%eax),%al
  800969:	84 c0                	test   %al,%al
  80096b:	75 f1                	jne    80095e <strlen+0xf>
		n++;
	return n;
  80096d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800970:	c9                   	leave  
  800971:	c3                   	ret    

00800972 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800972:	55                   	push   %ebp
  800973:	89 e5                	mov    %esp,%ebp
  800975:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800978:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80097f:	eb 09                	jmp    80098a <strnlen+0x18>
		n++;
  800981:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800984:	ff 45 08             	incl   0x8(%ebp)
  800987:	ff 4d 0c             	decl   0xc(%ebp)
  80098a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80098e:	74 09                	je     800999 <strnlen+0x27>
  800990:	8b 45 08             	mov    0x8(%ebp),%eax
  800993:	8a 00                	mov    (%eax),%al
  800995:	84 c0                	test   %al,%al
  800997:	75 e8                	jne    800981 <strnlen+0xf>
		n++;
	return n;
  800999:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80099c:	c9                   	leave  
  80099d:	c3                   	ret    

0080099e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80099e:	55                   	push   %ebp
  80099f:	89 e5                	mov    %esp,%ebp
  8009a1:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8009a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8009aa:	90                   	nop
  8009ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ae:	8d 50 01             	lea    0x1(%eax),%edx
  8009b1:	89 55 08             	mov    %edx,0x8(%ebp)
  8009b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009b7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009ba:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009bd:	8a 12                	mov    (%edx),%dl
  8009bf:	88 10                	mov    %dl,(%eax)
  8009c1:	8a 00                	mov    (%eax),%al
  8009c3:	84 c0                	test   %al,%al
  8009c5:	75 e4                	jne    8009ab <strcpy+0xd>
		/* do nothing */;
	return ret;
  8009c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009ca:	c9                   	leave  
  8009cb:	c3                   	ret    

008009cc <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8009cc:	55                   	push   %ebp
  8009cd:	89 e5                	mov    %esp,%ebp
  8009cf:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8009d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009df:	eb 1f                	jmp    800a00 <strncpy+0x34>
		*dst++ = *src;
  8009e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e4:	8d 50 01             	lea    0x1(%eax),%edx
  8009e7:	89 55 08             	mov    %edx,0x8(%ebp)
  8009ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009ed:	8a 12                	mov    (%edx),%dl
  8009ef:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f4:	8a 00                	mov    (%eax),%al
  8009f6:	84 c0                	test   %al,%al
  8009f8:	74 03                	je     8009fd <strncpy+0x31>
			src++;
  8009fa:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009fd:	ff 45 fc             	incl   -0x4(%ebp)
  800a00:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a03:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a06:	72 d9                	jb     8009e1 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a08:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a0b:	c9                   	leave  
  800a0c:	c3                   	ret    

00800a0d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a0d:	55                   	push   %ebp
  800a0e:	89 e5                	mov    %esp,%ebp
  800a10:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a13:	8b 45 08             	mov    0x8(%ebp),%eax
  800a16:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a19:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a1d:	74 30                	je     800a4f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a1f:	eb 16                	jmp    800a37 <strlcpy+0x2a>
			*dst++ = *src++;
  800a21:	8b 45 08             	mov    0x8(%ebp),%eax
  800a24:	8d 50 01             	lea    0x1(%eax),%edx
  800a27:	89 55 08             	mov    %edx,0x8(%ebp)
  800a2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a2d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a30:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a33:	8a 12                	mov    (%edx),%dl
  800a35:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a37:	ff 4d 10             	decl   0x10(%ebp)
  800a3a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a3e:	74 09                	je     800a49 <strlcpy+0x3c>
  800a40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a43:	8a 00                	mov    (%eax),%al
  800a45:	84 c0                	test   %al,%al
  800a47:	75 d8                	jne    800a21 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a49:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a4f:	8b 55 08             	mov    0x8(%ebp),%edx
  800a52:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a55:	29 c2                	sub    %eax,%edx
  800a57:	89 d0                	mov    %edx,%eax
}
  800a59:	c9                   	leave  
  800a5a:	c3                   	ret    

00800a5b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a5b:	55                   	push   %ebp
  800a5c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a5e:	eb 06                	jmp    800a66 <strcmp+0xb>
		p++, q++;
  800a60:	ff 45 08             	incl   0x8(%ebp)
  800a63:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a66:	8b 45 08             	mov    0x8(%ebp),%eax
  800a69:	8a 00                	mov    (%eax),%al
  800a6b:	84 c0                	test   %al,%al
  800a6d:	74 0e                	je     800a7d <strcmp+0x22>
  800a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a72:	8a 10                	mov    (%eax),%dl
  800a74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a77:	8a 00                	mov    (%eax),%al
  800a79:	38 c2                	cmp    %al,%dl
  800a7b:	74 e3                	je     800a60 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a80:	8a 00                	mov    (%eax),%al
  800a82:	0f b6 d0             	movzbl %al,%edx
  800a85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a88:	8a 00                	mov    (%eax),%al
  800a8a:	0f b6 c0             	movzbl %al,%eax
  800a8d:	29 c2                	sub    %eax,%edx
  800a8f:	89 d0                	mov    %edx,%eax
}
  800a91:	5d                   	pop    %ebp
  800a92:	c3                   	ret    

00800a93 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a93:	55                   	push   %ebp
  800a94:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a96:	eb 09                	jmp    800aa1 <strncmp+0xe>
		n--, p++, q++;
  800a98:	ff 4d 10             	decl   0x10(%ebp)
  800a9b:	ff 45 08             	incl   0x8(%ebp)
  800a9e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800aa1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800aa5:	74 17                	je     800abe <strncmp+0x2b>
  800aa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aaa:	8a 00                	mov    (%eax),%al
  800aac:	84 c0                	test   %al,%al
  800aae:	74 0e                	je     800abe <strncmp+0x2b>
  800ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab3:	8a 10                	mov    (%eax),%dl
  800ab5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab8:	8a 00                	mov    (%eax),%al
  800aba:	38 c2                	cmp    %al,%dl
  800abc:	74 da                	je     800a98 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800abe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ac2:	75 07                	jne    800acb <strncmp+0x38>
		return 0;
  800ac4:	b8 00 00 00 00       	mov    $0x0,%eax
  800ac9:	eb 14                	jmp    800adf <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800acb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ace:	8a 00                	mov    (%eax),%al
  800ad0:	0f b6 d0             	movzbl %al,%edx
  800ad3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad6:	8a 00                	mov    (%eax),%al
  800ad8:	0f b6 c0             	movzbl %al,%eax
  800adb:	29 c2                	sub    %eax,%edx
  800add:	89 d0                	mov    %edx,%eax
}
  800adf:	5d                   	pop    %ebp
  800ae0:	c3                   	ret    

00800ae1 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ae1:	55                   	push   %ebp
  800ae2:	89 e5                	mov    %esp,%ebp
  800ae4:	83 ec 04             	sub    $0x4,%esp
  800ae7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aea:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800aed:	eb 12                	jmp    800b01 <strchr+0x20>
		if (*s == c)
  800aef:	8b 45 08             	mov    0x8(%ebp),%eax
  800af2:	8a 00                	mov    (%eax),%al
  800af4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800af7:	75 05                	jne    800afe <strchr+0x1d>
			return (char *) s;
  800af9:	8b 45 08             	mov    0x8(%ebp),%eax
  800afc:	eb 11                	jmp    800b0f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800afe:	ff 45 08             	incl   0x8(%ebp)
  800b01:	8b 45 08             	mov    0x8(%ebp),%eax
  800b04:	8a 00                	mov    (%eax),%al
  800b06:	84 c0                	test   %al,%al
  800b08:	75 e5                	jne    800aef <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b0a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b0f:	c9                   	leave  
  800b10:	c3                   	ret    

00800b11 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b11:	55                   	push   %ebp
  800b12:	89 e5                	mov    %esp,%ebp
  800b14:	83 ec 04             	sub    $0x4,%esp
  800b17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b1d:	eb 0d                	jmp    800b2c <strfind+0x1b>
		if (*s == c)
  800b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b22:	8a 00                	mov    (%eax),%al
  800b24:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b27:	74 0e                	je     800b37 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b29:	ff 45 08             	incl   0x8(%ebp)
  800b2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2f:	8a 00                	mov    (%eax),%al
  800b31:	84 c0                	test   %al,%al
  800b33:	75 ea                	jne    800b1f <strfind+0xe>
  800b35:	eb 01                	jmp    800b38 <strfind+0x27>
		if (*s == c)
			break;
  800b37:	90                   	nop
	return (char *) s;
  800b38:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b3b:	c9                   	leave  
  800b3c:	c3                   	ret    

00800b3d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b3d:	55                   	push   %ebp
  800b3e:	89 e5                	mov    %esp,%ebp
  800b40:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b43:	8b 45 08             	mov    0x8(%ebp),%eax
  800b46:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b49:	8b 45 10             	mov    0x10(%ebp),%eax
  800b4c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b4f:	eb 0e                	jmp    800b5f <memset+0x22>
		*p++ = c;
  800b51:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b54:	8d 50 01             	lea    0x1(%eax),%edx
  800b57:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b5a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b5d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b5f:	ff 4d f8             	decl   -0x8(%ebp)
  800b62:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b66:	79 e9                	jns    800b51 <memset+0x14>
		*p++ = c;

	return v;
  800b68:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b6b:	c9                   	leave  
  800b6c:	c3                   	ret    

00800b6d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b6d:	55                   	push   %ebp
  800b6e:	89 e5                	mov    %esp,%ebp
  800b70:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b76:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b79:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b7f:	eb 16                	jmp    800b97 <memcpy+0x2a>
		*d++ = *s++;
  800b81:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b84:	8d 50 01             	lea    0x1(%eax),%edx
  800b87:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b8a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b8d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b90:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b93:	8a 12                	mov    (%edx),%dl
  800b95:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b97:	8b 45 10             	mov    0x10(%ebp),%eax
  800b9a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b9d:	89 55 10             	mov    %edx,0x10(%ebp)
  800ba0:	85 c0                	test   %eax,%eax
  800ba2:	75 dd                	jne    800b81 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ba4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ba7:	c9                   	leave  
  800ba8:	c3                   	ret    

00800ba9 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ba9:	55                   	push   %ebp
  800baa:	89 e5                	mov    %esp,%ebp
  800bac:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800baf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800bbb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bbe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bc1:	73 50                	jae    800c13 <memmove+0x6a>
  800bc3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bc6:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc9:	01 d0                	add    %edx,%eax
  800bcb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bce:	76 43                	jbe    800c13 <memmove+0x6a>
		s += n;
  800bd0:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd3:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800bd6:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd9:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800bdc:	eb 10                	jmp    800bee <memmove+0x45>
			*--d = *--s;
  800bde:	ff 4d f8             	decl   -0x8(%ebp)
  800be1:	ff 4d fc             	decl   -0x4(%ebp)
  800be4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800be7:	8a 10                	mov    (%eax),%dl
  800be9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bec:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bee:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bf4:	89 55 10             	mov    %edx,0x10(%ebp)
  800bf7:	85 c0                	test   %eax,%eax
  800bf9:	75 e3                	jne    800bde <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bfb:	eb 23                	jmp    800c20 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bfd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c00:	8d 50 01             	lea    0x1(%eax),%edx
  800c03:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c06:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c09:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c0c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c0f:	8a 12                	mov    (%edx),%dl
  800c11:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c13:	8b 45 10             	mov    0x10(%ebp),%eax
  800c16:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c19:	89 55 10             	mov    %edx,0x10(%ebp)
  800c1c:	85 c0                	test   %eax,%eax
  800c1e:	75 dd                	jne    800bfd <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c20:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c23:	c9                   	leave  
  800c24:	c3                   	ret    

00800c25 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c25:	55                   	push   %ebp
  800c26:	89 e5                	mov    %esp,%ebp
  800c28:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c34:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c37:	eb 2a                	jmp    800c63 <memcmp+0x3e>
		if (*s1 != *s2)
  800c39:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c3c:	8a 10                	mov    (%eax),%dl
  800c3e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c41:	8a 00                	mov    (%eax),%al
  800c43:	38 c2                	cmp    %al,%dl
  800c45:	74 16                	je     800c5d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c47:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c4a:	8a 00                	mov    (%eax),%al
  800c4c:	0f b6 d0             	movzbl %al,%edx
  800c4f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c52:	8a 00                	mov    (%eax),%al
  800c54:	0f b6 c0             	movzbl %al,%eax
  800c57:	29 c2                	sub    %eax,%edx
  800c59:	89 d0                	mov    %edx,%eax
  800c5b:	eb 18                	jmp    800c75 <memcmp+0x50>
		s1++, s2++;
  800c5d:	ff 45 fc             	incl   -0x4(%ebp)
  800c60:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c63:	8b 45 10             	mov    0x10(%ebp),%eax
  800c66:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c69:	89 55 10             	mov    %edx,0x10(%ebp)
  800c6c:	85 c0                	test   %eax,%eax
  800c6e:	75 c9                	jne    800c39 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c70:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c75:	c9                   	leave  
  800c76:	c3                   	ret    

00800c77 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c77:	55                   	push   %ebp
  800c78:	89 e5                	mov    %esp,%ebp
  800c7a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c7d:	8b 55 08             	mov    0x8(%ebp),%edx
  800c80:	8b 45 10             	mov    0x10(%ebp),%eax
  800c83:	01 d0                	add    %edx,%eax
  800c85:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c88:	eb 15                	jmp    800c9f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8d:	8a 00                	mov    (%eax),%al
  800c8f:	0f b6 d0             	movzbl %al,%edx
  800c92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c95:	0f b6 c0             	movzbl %al,%eax
  800c98:	39 c2                	cmp    %eax,%edx
  800c9a:	74 0d                	je     800ca9 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c9c:	ff 45 08             	incl   0x8(%ebp)
  800c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ca5:	72 e3                	jb     800c8a <memfind+0x13>
  800ca7:	eb 01                	jmp    800caa <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ca9:	90                   	nop
	return (void *) s;
  800caa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cad:	c9                   	leave  
  800cae:	c3                   	ret    

00800caf <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800caf:	55                   	push   %ebp
  800cb0:	89 e5                	mov    %esp,%ebp
  800cb2:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800cb5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800cbc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cc3:	eb 03                	jmp    800cc8 <strtol+0x19>
		s++;
  800cc5:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	8a 00                	mov    (%eax),%al
  800ccd:	3c 20                	cmp    $0x20,%al
  800ccf:	74 f4                	je     800cc5 <strtol+0x16>
  800cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd4:	8a 00                	mov    (%eax),%al
  800cd6:	3c 09                	cmp    $0x9,%al
  800cd8:	74 eb                	je     800cc5 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800cda:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdd:	8a 00                	mov    (%eax),%al
  800cdf:	3c 2b                	cmp    $0x2b,%al
  800ce1:	75 05                	jne    800ce8 <strtol+0x39>
		s++;
  800ce3:	ff 45 08             	incl   0x8(%ebp)
  800ce6:	eb 13                	jmp    800cfb <strtol+0x4c>
	else if (*s == '-')
  800ce8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ceb:	8a 00                	mov    (%eax),%al
  800ced:	3c 2d                	cmp    $0x2d,%al
  800cef:	75 0a                	jne    800cfb <strtol+0x4c>
		s++, neg = 1;
  800cf1:	ff 45 08             	incl   0x8(%ebp)
  800cf4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cfb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cff:	74 06                	je     800d07 <strtol+0x58>
  800d01:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d05:	75 20                	jne    800d27 <strtol+0x78>
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0a:	8a 00                	mov    (%eax),%al
  800d0c:	3c 30                	cmp    $0x30,%al
  800d0e:	75 17                	jne    800d27 <strtol+0x78>
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	40                   	inc    %eax
  800d14:	8a 00                	mov    (%eax),%al
  800d16:	3c 78                	cmp    $0x78,%al
  800d18:	75 0d                	jne    800d27 <strtol+0x78>
		s += 2, base = 16;
  800d1a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d1e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d25:	eb 28                	jmp    800d4f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d27:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d2b:	75 15                	jne    800d42 <strtol+0x93>
  800d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d30:	8a 00                	mov    (%eax),%al
  800d32:	3c 30                	cmp    $0x30,%al
  800d34:	75 0c                	jne    800d42 <strtol+0x93>
		s++, base = 8;
  800d36:	ff 45 08             	incl   0x8(%ebp)
  800d39:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d40:	eb 0d                	jmp    800d4f <strtol+0xa0>
	else if (base == 0)
  800d42:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d46:	75 07                	jne    800d4f <strtol+0xa0>
		base = 10;
  800d48:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8a 00                	mov    (%eax),%al
  800d54:	3c 2f                	cmp    $0x2f,%al
  800d56:	7e 19                	jle    800d71 <strtol+0xc2>
  800d58:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5b:	8a 00                	mov    (%eax),%al
  800d5d:	3c 39                	cmp    $0x39,%al
  800d5f:	7f 10                	jg     800d71 <strtol+0xc2>
			dig = *s - '0';
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	8a 00                	mov    (%eax),%al
  800d66:	0f be c0             	movsbl %al,%eax
  800d69:	83 e8 30             	sub    $0x30,%eax
  800d6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d6f:	eb 42                	jmp    800db3 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d71:	8b 45 08             	mov    0x8(%ebp),%eax
  800d74:	8a 00                	mov    (%eax),%al
  800d76:	3c 60                	cmp    $0x60,%al
  800d78:	7e 19                	jle    800d93 <strtol+0xe4>
  800d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7d:	8a 00                	mov    (%eax),%al
  800d7f:	3c 7a                	cmp    $0x7a,%al
  800d81:	7f 10                	jg     800d93 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d83:	8b 45 08             	mov    0x8(%ebp),%eax
  800d86:	8a 00                	mov    (%eax),%al
  800d88:	0f be c0             	movsbl %al,%eax
  800d8b:	83 e8 57             	sub    $0x57,%eax
  800d8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d91:	eb 20                	jmp    800db3 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d93:	8b 45 08             	mov    0x8(%ebp),%eax
  800d96:	8a 00                	mov    (%eax),%al
  800d98:	3c 40                	cmp    $0x40,%al
  800d9a:	7e 39                	jle    800dd5 <strtol+0x126>
  800d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9f:	8a 00                	mov    (%eax),%al
  800da1:	3c 5a                	cmp    $0x5a,%al
  800da3:	7f 30                	jg     800dd5 <strtol+0x126>
			dig = *s - 'A' + 10;
  800da5:	8b 45 08             	mov    0x8(%ebp),%eax
  800da8:	8a 00                	mov    (%eax),%al
  800daa:	0f be c0             	movsbl %al,%eax
  800dad:	83 e8 37             	sub    $0x37,%eax
  800db0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800db3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800db6:	3b 45 10             	cmp    0x10(%ebp),%eax
  800db9:	7d 19                	jge    800dd4 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800dbb:	ff 45 08             	incl   0x8(%ebp)
  800dbe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dc1:	0f af 45 10          	imul   0x10(%ebp),%eax
  800dc5:	89 c2                	mov    %eax,%edx
  800dc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dca:	01 d0                	add    %edx,%eax
  800dcc:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800dcf:	e9 7b ff ff ff       	jmp    800d4f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800dd4:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800dd5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dd9:	74 08                	je     800de3 <strtol+0x134>
		*endptr = (char *) s;
  800ddb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dde:	8b 55 08             	mov    0x8(%ebp),%edx
  800de1:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800de3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800de7:	74 07                	je     800df0 <strtol+0x141>
  800de9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dec:	f7 d8                	neg    %eax
  800dee:	eb 03                	jmp    800df3 <strtol+0x144>
  800df0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800df3:	c9                   	leave  
  800df4:	c3                   	ret    

00800df5 <ltostr>:

void
ltostr(long value, char *str)
{
  800df5:	55                   	push   %ebp
  800df6:	89 e5                	mov    %esp,%ebp
  800df8:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dfb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e02:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e09:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e0d:	79 13                	jns    800e22 <ltostr+0x2d>
	{
		neg = 1;
  800e0f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e19:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e1c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e1f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e22:	8b 45 08             	mov    0x8(%ebp),%eax
  800e25:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e2a:	99                   	cltd   
  800e2b:	f7 f9                	idiv   %ecx
  800e2d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e30:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e33:	8d 50 01             	lea    0x1(%eax),%edx
  800e36:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e39:	89 c2                	mov    %eax,%edx
  800e3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3e:	01 d0                	add    %edx,%eax
  800e40:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e43:	83 c2 30             	add    $0x30,%edx
  800e46:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e48:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e4b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e50:	f7 e9                	imul   %ecx
  800e52:	c1 fa 02             	sar    $0x2,%edx
  800e55:	89 c8                	mov    %ecx,%eax
  800e57:	c1 f8 1f             	sar    $0x1f,%eax
  800e5a:	29 c2                	sub    %eax,%edx
  800e5c:	89 d0                	mov    %edx,%eax
  800e5e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e61:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e64:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e69:	f7 e9                	imul   %ecx
  800e6b:	c1 fa 02             	sar    $0x2,%edx
  800e6e:	89 c8                	mov    %ecx,%eax
  800e70:	c1 f8 1f             	sar    $0x1f,%eax
  800e73:	29 c2                	sub    %eax,%edx
  800e75:	89 d0                	mov    %edx,%eax
  800e77:	c1 e0 02             	shl    $0x2,%eax
  800e7a:	01 d0                	add    %edx,%eax
  800e7c:	01 c0                	add    %eax,%eax
  800e7e:	29 c1                	sub    %eax,%ecx
  800e80:	89 ca                	mov    %ecx,%edx
  800e82:	85 d2                	test   %edx,%edx
  800e84:	75 9c                	jne    800e22 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e86:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e8d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e90:	48                   	dec    %eax
  800e91:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e94:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e98:	74 3d                	je     800ed7 <ltostr+0xe2>
		start = 1 ;
  800e9a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800ea1:	eb 34                	jmp    800ed7 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800ea3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ea6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea9:	01 d0                	add    %edx,%eax
  800eab:	8a 00                	mov    (%eax),%al
  800ead:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800eb0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800eb3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb6:	01 c2                	add    %eax,%edx
  800eb8:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800ebb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebe:	01 c8                	add    %ecx,%eax
  800ec0:	8a 00                	mov    (%eax),%al
  800ec2:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800ec4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800ec7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eca:	01 c2                	add    %eax,%edx
  800ecc:	8a 45 eb             	mov    -0x15(%ebp),%al
  800ecf:	88 02                	mov    %al,(%edx)
		start++ ;
  800ed1:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800ed4:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800ed7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800eda:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800edd:	7c c4                	jl     800ea3 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800edf:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ee2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee5:	01 d0                	add    %edx,%eax
  800ee7:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800eea:	90                   	nop
  800eeb:	c9                   	leave  
  800eec:	c3                   	ret    

00800eed <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800eed:	55                   	push   %ebp
  800eee:	89 e5                	mov    %esp,%ebp
  800ef0:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ef3:	ff 75 08             	pushl  0x8(%ebp)
  800ef6:	e8 54 fa ff ff       	call   80094f <strlen>
  800efb:	83 c4 04             	add    $0x4,%esp
  800efe:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f01:	ff 75 0c             	pushl  0xc(%ebp)
  800f04:	e8 46 fa ff ff       	call   80094f <strlen>
  800f09:	83 c4 04             	add    $0x4,%esp
  800f0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f0f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f16:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f1d:	eb 17                	jmp    800f36 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f1f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f22:	8b 45 10             	mov    0x10(%ebp),%eax
  800f25:	01 c2                	add    %eax,%edx
  800f27:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2d:	01 c8                	add    %ecx,%eax
  800f2f:	8a 00                	mov    (%eax),%al
  800f31:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f33:	ff 45 fc             	incl   -0x4(%ebp)
  800f36:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f39:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f3c:	7c e1                	jl     800f1f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f3e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f45:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f4c:	eb 1f                	jmp    800f6d <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f51:	8d 50 01             	lea    0x1(%eax),%edx
  800f54:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f57:	89 c2                	mov    %eax,%edx
  800f59:	8b 45 10             	mov    0x10(%ebp),%eax
  800f5c:	01 c2                	add    %eax,%edx
  800f5e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f61:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f64:	01 c8                	add    %ecx,%eax
  800f66:	8a 00                	mov    (%eax),%al
  800f68:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f6a:	ff 45 f8             	incl   -0x8(%ebp)
  800f6d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f70:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f73:	7c d9                	jl     800f4e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f75:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f78:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7b:	01 d0                	add    %edx,%eax
  800f7d:	c6 00 00             	movb   $0x0,(%eax)
}
  800f80:	90                   	nop
  800f81:	c9                   	leave  
  800f82:	c3                   	ret    

00800f83 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f83:	55                   	push   %ebp
  800f84:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f86:	8b 45 14             	mov    0x14(%ebp),%eax
  800f89:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f92:	8b 00                	mov    (%eax),%eax
  800f94:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f9b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9e:	01 d0                	add    %edx,%eax
  800fa0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800fa6:	eb 0c                	jmp    800fb4 <strsplit+0x31>
			*string++ = 0;
  800fa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fab:	8d 50 01             	lea    0x1(%eax),%edx
  800fae:	89 55 08             	mov    %edx,0x8(%ebp)
  800fb1:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb7:	8a 00                	mov    (%eax),%al
  800fb9:	84 c0                	test   %al,%al
  800fbb:	74 18                	je     800fd5 <strsplit+0x52>
  800fbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc0:	8a 00                	mov    (%eax),%al
  800fc2:	0f be c0             	movsbl %al,%eax
  800fc5:	50                   	push   %eax
  800fc6:	ff 75 0c             	pushl  0xc(%ebp)
  800fc9:	e8 13 fb ff ff       	call   800ae1 <strchr>
  800fce:	83 c4 08             	add    $0x8,%esp
  800fd1:	85 c0                	test   %eax,%eax
  800fd3:	75 d3                	jne    800fa8 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800fd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd8:	8a 00                	mov    (%eax),%al
  800fda:	84 c0                	test   %al,%al
  800fdc:	74 5a                	je     801038 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800fde:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe1:	8b 00                	mov    (%eax),%eax
  800fe3:	83 f8 0f             	cmp    $0xf,%eax
  800fe6:	75 07                	jne    800fef <strsplit+0x6c>
		{
			return 0;
  800fe8:	b8 00 00 00 00       	mov    $0x0,%eax
  800fed:	eb 66                	jmp    801055 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fef:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff2:	8b 00                	mov    (%eax),%eax
  800ff4:	8d 48 01             	lea    0x1(%eax),%ecx
  800ff7:	8b 55 14             	mov    0x14(%ebp),%edx
  800ffa:	89 0a                	mov    %ecx,(%edx)
  800ffc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801003:	8b 45 10             	mov    0x10(%ebp),%eax
  801006:	01 c2                	add    %eax,%edx
  801008:	8b 45 08             	mov    0x8(%ebp),%eax
  80100b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80100d:	eb 03                	jmp    801012 <strsplit+0x8f>
			string++;
  80100f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801012:	8b 45 08             	mov    0x8(%ebp),%eax
  801015:	8a 00                	mov    (%eax),%al
  801017:	84 c0                	test   %al,%al
  801019:	74 8b                	je     800fa6 <strsplit+0x23>
  80101b:	8b 45 08             	mov    0x8(%ebp),%eax
  80101e:	8a 00                	mov    (%eax),%al
  801020:	0f be c0             	movsbl %al,%eax
  801023:	50                   	push   %eax
  801024:	ff 75 0c             	pushl  0xc(%ebp)
  801027:	e8 b5 fa ff ff       	call   800ae1 <strchr>
  80102c:	83 c4 08             	add    $0x8,%esp
  80102f:	85 c0                	test   %eax,%eax
  801031:	74 dc                	je     80100f <strsplit+0x8c>
			string++;
	}
  801033:	e9 6e ff ff ff       	jmp    800fa6 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801038:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801039:	8b 45 14             	mov    0x14(%ebp),%eax
  80103c:	8b 00                	mov    (%eax),%eax
  80103e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801045:	8b 45 10             	mov    0x10(%ebp),%eax
  801048:	01 d0                	add    %edx,%eax
  80104a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801050:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801055:	c9                   	leave  
  801056:	c3                   	ret    

00801057 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801057:	55                   	push   %ebp
  801058:	89 e5                	mov    %esp,%ebp
  80105a:	57                   	push   %edi
  80105b:	56                   	push   %esi
  80105c:	53                   	push   %ebx
  80105d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801060:	8b 45 08             	mov    0x8(%ebp),%eax
  801063:	8b 55 0c             	mov    0xc(%ebp),%edx
  801066:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801069:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80106c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80106f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801072:	cd 30                	int    $0x30
  801074:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801077:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80107a:	83 c4 10             	add    $0x10,%esp
  80107d:	5b                   	pop    %ebx
  80107e:	5e                   	pop    %esi
  80107f:	5f                   	pop    %edi
  801080:	5d                   	pop    %ebp
  801081:	c3                   	ret    

00801082 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801082:	55                   	push   %ebp
  801083:	89 e5                	mov    %esp,%ebp
  801085:	83 ec 04             	sub    $0x4,%esp
  801088:	8b 45 10             	mov    0x10(%ebp),%eax
  80108b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80108e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801092:	8b 45 08             	mov    0x8(%ebp),%eax
  801095:	6a 00                	push   $0x0
  801097:	6a 00                	push   $0x0
  801099:	52                   	push   %edx
  80109a:	ff 75 0c             	pushl  0xc(%ebp)
  80109d:	50                   	push   %eax
  80109e:	6a 00                	push   $0x0
  8010a0:	e8 b2 ff ff ff       	call   801057 <syscall>
  8010a5:	83 c4 18             	add    $0x18,%esp
}
  8010a8:	90                   	nop
  8010a9:	c9                   	leave  
  8010aa:	c3                   	ret    

008010ab <sys_cgetc>:

int
sys_cgetc(void)
{
  8010ab:	55                   	push   %ebp
  8010ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8010ae:	6a 00                	push   $0x0
  8010b0:	6a 00                	push   $0x0
  8010b2:	6a 00                	push   $0x0
  8010b4:	6a 00                	push   $0x0
  8010b6:	6a 00                	push   $0x0
  8010b8:	6a 01                	push   $0x1
  8010ba:	e8 98 ff ff ff       	call   801057 <syscall>
  8010bf:	83 c4 18             	add    $0x18,%esp
}
  8010c2:	c9                   	leave  
  8010c3:	c3                   	ret    

008010c4 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8010c4:	55                   	push   %ebp
  8010c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8010c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ca:	6a 00                	push   $0x0
  8010cc:	6a 00                	push   $0x0
  8010ce:	6a 00                	push   $0x0
  8010d0:	6a 00                	push   $0x0
  8010d2:	50                   	push   %eax
  8010d3:	6a 05                	push   $0x5
  8010d5:	e8 7d ff ff ff       	call   801057 <syscall>
  8010da:	83 c4 18             	add    $0x18,%esp
}
  8010dd:	c9                   	leave  
  8010de:	c3                   	ret    

008010df <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010df:	55                   	push   %ebp
  8010e0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010e2:	6a 00                	push   $0x0
  8010e4:	6a 00                	push   $0x0
  8010e6:	6a 00                	push   $0x0
  8010e8:	6a 00                	push   $0x0
  8010ea:	6a 00                	push   $0x0
  8010ec:	6a 02                	push   $0x2
  8010ee:	e8 64 ff ff ff       	call   801057 <syscall>
  8010f3:	83 c4 18             	add    $0x18,%esp
}
  8010f6:	c9                   	leave  
  8010f7:	c3                   	ret    

008010f8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010f8:	55                   	push   %ebp
  8010f9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010fb:	6a 00                	push   $0x0
  8010fd:	6a 00                	push   $0x0
  8010ff:	6a 00                	push   $0x0
  801101:	6a 00                	push   $0x0
  801103:	6a 00                	push   $0x0
  801105:	6a 03                	push   $0x3
  801107:	e8 4b ff ff ff       	call   801057 <syscall>
  80110c:	83 c4 18             	add    $0x18,%esp
}
  80110f:	c9                   	leave  
  801110:	c3                   	ret    

00801111 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801111:	55                   	push   %ebp
  801112:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801114:	6a 00                	push   $0x0
  801116:	6a 00                	push   $0x0
  801118:	6a 00                	push   $0x0
  80111a:	6a 00                	push   $0x0
  80111c:	6a 00                	push   $0x0
  80111e:	6a 04                	push   $0x4
  801120:	e8 32 ff ff ff       	call   801057 <syscall>
  801125:	83 c4 18             	add    $0x18,%esp
}
  801128:	c9                   	leave  
  801129:	c3                   	ret    

0080112a <sys_env_exit>:


void sys_env_exit(void)
{
  80112a:	55                   	push   %ebp
  80112b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80112d:	6a 00                	push   $0x0
  80112f:	6a 00                	push   $0x0
  801131:	6a 00                	push   $0x0
  801133:	6a 00                	push   $0x0
  801135:	6a 00                	push   $0x0
  801137:	6a 06                	push   $0x6
  801139:	e8 19 ff ff ff       	call   801057 <syscall>
  80113e:	83 c4 18             	add    $0x18,%esp
}
  801141:	90                   	nop
  801142:	c9                   	leave  
  801143:	c3                   	ret    

00801144 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801144:	55                   	push   %ebp
  801145:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801147:	8b 55 0c             	mov    0xc(%ebp),%edx
  80114a:	8b 45 08             	mov    0x8(%ebp),%eax
  80114d:	6a 00                	push   $0x0
  80114f:	6a 00                	push   $0x0
  801151:	6a 00                	push   $0x0
  801153:	52                   	push   %edx
  801154:	50                   	push   %eax
  801155:	6a 07                	push   $0x7
  801157:	e8 fb fe ff ff       	call   801057 <syscall>
  80115c:	83 c4 18             	add    $0x18,%esp
}
  80115f:	c9                   	leave  
  801160:	c3                   	ret    

00801161 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801161:	55                   	push   %ebp
  801162:	89 e5                	mov    %esp,%ebp
  801164:	56                   	push   %esi
  801165:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801166:	8b 75 18             	mov    0x18(%ebp),%esi
  801169:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80116c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80116f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801172:	8b 45 08             	mov    0x8(%ebp),%eax
  801175:	56                   	push   %esi
  801176:	53                   	push   %ebx
  801177:	51                   	push   %ecx
  801178:	52                   	push   %edx
  801179:	50                   	push   %eax
  80117a:	6a 08                	push   $0x8
  80117c:	e8 d6 fe ff ff       	call   801057 <syscall>
  801181:	83 c4 18             	add    $0x18,%esp
}
  801184:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801187:	5b                   	pop    %ebx
  801188:	5e                   	pop    %esi
  801189:	5d                   	pop    %ebp
  80118a:	c3                   	ret    

0080118b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80118b:	55                   	push   %ebp
  80118c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80118e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801191:	8b 45 08             	mov    0x8(%ebp),%eax
  801194:	6a 00                	push   $0x0
  801196:	6a 00                	push   $0x0
  801198:	6a 00                	push   $0x0
  80119a:	52                   	push   %edx
  80119b:	50                   	push   %eax
  80119c:	6a 09                	push   $0x9
  80119e:	e8 b4 fe ff ff       	call   801057 <syscall>
  8011a3:	83 c4 18             	add    $0x18,%esp
}
  8011a6:	c9                   	leave  
  8011a7:	c3                   	ret    

008011a8 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8011a8:	55                   	push   %ebp
  8011a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8011ab:	6a 00                	push   $0x0
  8011ad:	6a 00                	push   $0x0
  8011af:	6a 00                	push   $0x0
  8011b1:	ff 75 0c             	pushl  0xc(%ebp)
  8011b4:	ff 75 08             	pushl  0x8(%ebp)
  8011b7:	6a 0a                	push   $0xa
  8011b9:	e8 99 fe ff ff       	call   801057 <syscall>
  8011be:	83 c4 18             	add    $0x18,%esp
}
  8011c1:	c9                   	leave  
  8011c2:	c3                   	ret    

008011c3 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8011c3:	55                   	push   %ebp
  8011c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8011c6:	6a 00                	push   $0x0
  8011c8:	6a 00                	push   $0x0
  8011ca:	6a 00                	push   $0x0
  8011cc:	6a 00                	push   $0x0
  8011ce:	6a 00                	push   $0x0
  8011d0:	6a 0b                	push   $0xb
  8011d2:	e8 80 fe ff ff       	call   801057 <syscall>
  8011d7:	83 c4 18             	add    $0x18,%esp
}
  8011da:	c9                   	leave  
  8011db:	c3                   	ret    

008011dc <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011dc:	55                   	push   %ebp
  8011dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011df:	6a 00                	push   $0x0
  8011e1:	6a 00                	push   $0x0
  8011e3:	6a 00                	push   $0x0
  8011e5:	6a 00                	push   $0x0
  8011e7:	6a 00                	push   $0x0
  8011e9:	6a 0c                	push   $0xc
  8011eb:	e8 67 fe ff ff       	call   801057 <syscall>
  8011f0:	83 c4 18             	add    $0x18,%esp
}
  8011f3:	c9                   	leave  
  8011f4:	c3                   	ret    

008011f5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011f5:	55                   	push   %ebp
  8011f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011f8:	6a 00                	push   $0x0
  8011fa:	6a 00                	push   $0x0
  8011fc:	6a 00                	push   $0x0
  8011fe:	6a 00                	push   $0x0
  801200:	6a 00                	push   $0x0
  801202:	6a 0d                	push   $0xd
  801204:	e8 4e fe ff ff       	call   801057 <syscall>
  801209:	83 c4 18             	add    $0x18,%esp
}
  80120c:	c9                   	leave  
  80120d:	c3                   	ret    

0080120e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80120e:	55                   	push   %ebp
  80120f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801211:	6a 00                	push   $0x0
  801213:	6a 00                	push   $0x0
  801215:	6a 00                	push   $0x0
  801217:	ff 75 0c             	pushl  0xc(%ebp)
  80121a:	ff 75 08             	pushl  0x8(%ebp)
  80121d:	6a 11                	push   $0x11
  80121f:	e8 33 fe ff ff       	call   801057 <syscall>
  801224:	83 c4 18             	add    $0x18,%esp
	return;
  801227:	90                   	nop
}
  801228:	c9                   	leave  
  801229:	c3                   	ret    

0080122a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80122a:	55                   	push   %ebp
  80122b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80122d:	6a 00                	push   $0x0
  80122f:	6a 00                	push   $0x0
  801231:	6a 00                	push   $0x0
  801233:	ff 75 0c             	pushl  0xc(%ebp)
  801236:	ff 75 08             	pushl  0x8(%ebp)
  801239:	6a 12                	push   $0x12
  80123b:	e8 17 fe ff ff       	call   801057 <syscall>
  801240:	83 c4 18             	add    $0x18,%esp
	return ;
  801243:	90                   	nop
}
  801244:	c9                   	leave  
  801245:	c3                   	ret    

00801246 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801246:	55                   	push   %ebp
  801247:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801249:	6a 00                	push   $0x0
  80124b:	6a 00                	push   $0x0
  80124d:	6a 00                	push   $0x0
  80124f:	6a 00                	push   $0x0
  801251:	6a 00                	push   $0x0
  801253:	6a 0e                	push   $0xe
  801255:	e8 fd fd ff ff       	call   801057 <syscall>
  80125a:	83 c4 18             	add    $0x18,%esp
}
  80125d:	c9                   	leave  
  80125e:	c3                   	ret    

0080125f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80125f:	55                   	push   %ebp
  801260:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801262:	6a 00                	push   $0x0
  801264:	6a 00                	push   $0x0
  801266:	6a 00                	push   $0x0
  801268:	6a 00                	push   $0x0
  80126a:	ff 75 08             	pushl  0x8(%ebp)
  80126d:	6a 0f                	push   $0xf
  80126f:	e8 e3 fd ff ff       	call   801057 <syscall>
  801274:	83 c4 18             	add    $0x18,%esp
}
  801277:	c9                   	leave  
  801278:	c3                   	ret    

00801279 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801279:	55                   	push   %ebp
  80127a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80127c:	6a 00                	push   $0x0
  80127e:	6a 00                	push   $0x0
  801280:	6a 00                	push   $0x0
  801282:	6a 00                	push   $0x0
  801284:	6a 00                	push   $0x0
  801286:	6a 10                	push   $0x10
  801288:	e8 ca fd ff ff       	call   801057 <syscall>
  80128d:	83 c4 18             	add    $0x18,%esp
}
  801290:	90                   	nop
  801291:	c9                   	leave  
  801292:	c3                   	ret    

00801293 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801293:	55                   	push   %ebp
  801294:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801296:	6a 00                	push   $0x0
  801298:	6a 00                	push   $0x0
  80129a:	6a 00                	push   $0x0
  80129c:	6a 00                	push   $0x0
  80129e:	6a 00                	push   $0x0
  8012a0:	6a 14                	push   $0x14
  8012a2:	e8 b0 fd ff ff       	call   801057 <syscall>
  8012a7:	83 c4 18             	add    $0x18,%esp
}
  8012aa:	90                   	nop
  8012ab:	c9                   	leave  
  8012ac:	c3                   	ret    

008012ad <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8012ad:	55                   	push   %ebp
  8012ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8012b0:	6a 00                	push   $0x0
  8012b2:	6a 00                	push   $0x0
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 00                	push   $0x0
  8012ba:	6a 15                	push   $0x15
  8012bc:	e8 96 fd ff ff       	call   801057 <syscall>
  8012c1:	83 c4 18             	add    $0x18,%esp
}
  8012c4:	90                   	nop
  8012c5:	c9                   	leave  
  8012c6:	c3                   	ret    

008012c7 <sys_cputc>:


void
sys_cputc(const char c)
{
  8012c7:	55                   	push   %ebp
  8012c8:	89 e5                	mov    %esp,%ebp
  8012ca:	83 ec 04             	sub    $0x4,%esp
  8012cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8012d3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012d7:	6a 00                	push   $0x0
  8012d9:	6a 00                	push   $0x0
  8012db:	6a 00                	push   $0x0
  8012dd:	6a 00                	push   $0x0
  8012df:	50                   	push   %eax
  8012e0:	6a 16                	push   $0x16
  8012e2:	e8 70 fd ff ff       	call   801057 <syscall>
  8012e7:	83 c4 18             	add    $0x18,%esp
}
  8012ea:	90                   	nop
  8012eb:	c9                   	leave  
  8012ec:	c3                   	ret    

008012ed <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012ed:	55                   	push   %ebp
  8012ee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012f0:	6a 00                	push   $0x0
  8012f2:	6a 00                	push   $0x0
  8012f4:	6a 00                	push   $0x0
  8012f6:	6a 00                	push   $0x0
  8012f8:	6a 00                	push   $0x0
  8012fa:	6a 17                	push   $0x17
  8012fc:	e8 56 fd ff ff       	call   801057 <syscall>
  801301:	83 c4 18             	add    $0x18,%esp
}
  801304:	90                   	nop
  801305:	c9                   	leave  
  801306:	c3                   	ret    

00801307 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801307:	55                   	push   %ebp
  801308:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80130a:	8b 45 08             	mov    0x8(%ebp),%eax
  80130d:	6a 00                	push   $0x0
  80130f:	6a 00                	push   $0x0
  801311:	6a 00                	push   $0x0
  801313:	ff 75 0c             	pushl  0xc(%ebp)
  801316:	50                   	push   %eax
  801317:	6a 18                	push   $0x18
  801319:	e8 39 fd ff ff       	call   801057 <syscall>
  80131e:	83 c4 18             	add    $0x18,%esp
}
  801321:	c9                   	leave  
  801322:	c3                   	ret    

00801323 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801323:	55                   	push   %ebp
  801324:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801326:	8b 55 0c             	mov    0xc(%ebp),%edx
  801329:	8b 45 08             	mov    0x8(%ebp),%eax
  80132c:	6a 00                	push   $0x0
  80132e:	6a 00                	push   $0x0
  801330:	6a 00                	push   $0x0
  801332:	52                   	push   %edx
  801333:	50                   	push   %eax
  801334:	6a 1b                	push   $0x1b
  801336:	e8 1c fd ff ff       	call   801057 <syscall>
  80133b:	83 c4 18             	add    $0x18,%esp
}
  80133e:	c9                   	leave  
  80133f:	c3                   	ret    

00801340 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801340:	55                   	push   %ebp
  801341:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801343:	8b 55 0c             	mov    0xc(%ebp),%edx
  801346:	8b 45 08             	mov    0x8(%ebp),%eax
  801349:	6a 00                	push   $0x0
  80134b:	6a 00                	push   $0x0
  80134d:	6a 00                	push   $0x0
  80134f:	52                   	push   %edx
  801350:	50                   	push   %eax
  801351:	6a 19                	push   $0x19
  801353:	e8 ff fc ff ff       	call   801057 <syscall>
  801358:	83 c4 18             	add    $0x18,%esp
}
  80135b:	90                   	nop
  80135c:	c9                   	leave  
  80135d:	c3                   	ret    

0080135e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80135e:	55                   	push   %ebp
  80135f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801361:	8b 55 0c             	mov    0xc(%ebp),%edx
  801364:	8b 45 08             	mov    0x8(%ebp),%eax
  801367:	6a 00                	push   $0x0
  801369:	6a 00                	push   $0x0
  80136b:	6a 00                	push   $0x0
  80136d:	52                   	push   %edx
  80136e:	50                   	push   %eax
  80136f:	6a 1a                	push   $0x1a
  801371:	e8 e1 fc ff ff       	call   801057 <syscall>
  801376:	83 c4 18             	add    $0x18,%esp
}
  801379:	90                   	nop
  80137a:	c9                   	leave  
  80137b:	c3                   	ret    

0080137c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80137c:	55                   	push   %ebp
  80137d:	89 e5                	mov    %esp,%ebp
  80137f:	83 ec 04             	sub    $0x4,%esp
  801382:	8b 45 10             	mov    0x10(%ebp),%eax
  801385:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801388:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80138b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80138f:	8b 45 08             	mov    0x8(%ebp),%eax
  801392:	6a 00                	push   $0x0
  801394:	51                   	push   %ecx
  801395:	52                   	push   %edx
  801396:	ff 75 0c             	pushl  0xc(%ebp)
  801399:	50                   	push   %eax
  80139a:	6a 1c                	push   $0x1c
  80139c:	e8 b6 fc ff ff       	call   801057 <syscall>
  8013a1:	83 c4 18             	add    $0x18,%esp
}
  8013a4:	c9                   	leave  
  8013a5:	c3                   	ret    

008013a6 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8013a6:	55                   	push   %ebp
  8013a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8013a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8013af:	6a 00                	push   $0x0
  8013b1:	6a 00                	push   $0x0
  8013b3:	6a 00                	push   $0x0
  8013b5:	52                   	push   %edx
  8013b6:	50                   	push   %eax
  8013b7:	6a 1d                	push   $0x1d
  8013b9:	e8 99 fc ff ff       	call   801057 <syscall>
  8013be:	83 c4 18             	add    $0x18,%esp
}
  8013c1:	c9                   	leave  
  8013c2:	c3                   	ret    

008013c3 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8013c3:	55                   	push   %ebp
  8013c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8013c6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 00                	push   $0x0
  8013d3:	51                   	push   %ecx
  8013d4:	52                   	push   %edx
  8013d5:	50                   	push   %eax
  8013d6:	6a 1e                	push   $0x1e
  8013d8:	e8 7a fc ff ff       	call   801057 <syscall>
  8013dd:	83 c4 18             	add    $0x18,%esp
}
  8013e0:	c9                   	leave  
  8013e1:	c3                   	ret    

008013e2 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013e2:	55                   	push   %ebp
  8013e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 00                	push   $0x0
  8013f1:	52                   	push   %edx
  8013f2:	50                   	push   %eax
  8013f3:	6a 1f                	push   $0x1f
  8013f5:	e8 5d fc ff ff       	call   801057 <syscall>
  8013fa:	83 c4 18             	add    $0x18,%esp
}
  8013fd:	c9                   	leave  
  8013fe:	c3                   	ret    

008013ff <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013ff:	55                   	push   %ebp
  801400:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801402:	6a 00                	push   $0x0
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	6a 00                	push   $0x0
  80140a:	6a 00                	push   $0x0
  80140c:	6a 20                	push   $0x20
  80140e:	e8 44 fc ff ff       	call   801057 <syscall>
  801413:	83 c4 18             	add    $0x18,%esp
}
  801416:	c9                   	leave  
  801417:	c3                   	ret    

00801418 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801418:	55                   	push   %ebp
  801419:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80141b:	8b 45 08             	mov    0x8(%ebp),%eax
  80141e:	6a 00                	push   $0x0
  801420:	ff 75 14             	pushl  0x14(%ebp)
  801423:	ff 75 10             	pushl  0x10(%ebp)
  801426:	ff 75 0c             	pushl  0xc(%ebp)
  801429:	50                   	push   %eax
  80142a:	6a 21                	push   $0x21
  80142c:	e8 26 fc ff ff       	call   801057 <syscall>
  801431:	83 c4 18             	add    $0x18,%esp
}
  801434:	c9                   	leave  
  801435:	c3                   	ret    

00801436 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801436:	55                   	push   %ebp
  801437:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801439:	8b 45 08             	mov    0x8(%ebp),%eax
  80143c:	6a 00                	push   $0x0
  80143e:	6a 00                	push   $0x0
  801440:	6a 00                	push   $0x0
  801442:	6a 00                	push   $0x0
  801444:	50                   	push   %eax
  801445:	6a 22                	push   $0x22
  801447:	e8 0b fc ff ff       	call   801057 <syscall>
  80144c:	83 c4 18             	add    $0x18,%esp
}
  80144f:	90                   	nop
  801450:	c9                   	leave  
  801451:	c3                   	ret    

00801452 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801452:	55                   	push   %ebp
  801453:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801455:	8b 45 08             	mov    0x8(%ebp),%eax
  801458:	6a 00                	push   $0x0
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	50                   	push   %eax
  801461:	6a 23                	push   $0x23
  801463:	e8 ef fb ff ff       	call   801057 <syscall>
  801468:	83 c4 18             	add    $0x18,%esp
}
  80146b:	90                   	nop
  80146c:	c9                   	leave  
  80146d:	c3                   	ret    

0080146e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80146e:	55                   	push   %ebp
  80146f:	89 e5                	mov    %esp,%ebp
  801471:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801474:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801477:	8d 50 04             	lea    0x4(%eax),%edx
  80147a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80147d:	6a 00                	push   $0x0
  80147f:	6a 00                	push   $0x0
  801481:	6a 00                	push   $0x0
  801483:	52                   	push   %edx
  801484:	50                   	push   %eax
  801485:	6a 24                	push   $0x24
  801487:	e8 cb fb ff ff       	call   801057 <syscall>
  80148c:	83 c4 18             	add    $0x18,%esp
	return result;
  80148f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801492:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801495:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801498:	89 01                	mov    %eax,(%ecx)
  80149a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80149d:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a0:	c9                   	leave  
  8014a1:	c2 04 00             	ret    $0x4

008014a4 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8014a4:	55                   	push   %ebp
  8014a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	ff 75 10             	pushl  0x10(%ebp)
  8014ae:	ff 75 0c             	pushl  0xc(%ebp)
  8014b1:	ff 75 08             	pushl  0x8(%ebp)
  8014b4:	6a 13                	push   $0x13
  8014b6:	e8 9c fb ff ff       	call   801057 <syscall>
  8014bb:	83 c4 18             	add    $0x18,%esp
	return ;
  8014be:	90                   	nop
}
  8014bf:	c9                   	leave  
  8014c0:	c3                   	ret    

008014c1 <sys_rcr2>:
uint32 sys_rcr2()
{
  8014c1:	55                   	push   %ebp
  8014c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 00                	push   $0x0
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 25                	push   $0x25
  8014d0:	e8 82 fb ff ff       	call   801057 <syscall>
  8014d5:	83 c4 18             	add    $0x18,%esp
}
  8014d8:	c9                   	leave  
  8014d9:	c3                   	ret    

008014da <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014da:	55                   	push   %ebp
  8014db:	89 e5                	mov    %esp,%ebp
  8014dd:	83 ec 04             	sub    $0x4,%esp
  8014e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014e6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 00                	push   $0x0
  8014f0:	6a 00                	push   $0x0
  8014f2:	50                   	push   %eax
  8014f3:	6a 26                	push   $0x26
  8014f5:	e8 5d fb ff ff       	call   801057 <syscall>
  8014fa:	83 c4 18             	add    $0x18,%esp
	return ;
  8014fd:	90                   	nop
}
  8014fe:	c9                   	leave  
  8014ff:	c3                   	ret    

00801500 <rsttst>:
void rsttst()
{
  801500:	55                   	push   %ebp
  801501:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801503:	6a 00                	push   $0x0
  801505:	6a 00                	push   $0x0
  801507:	6a 00                	push   $0x0
  801509:	6a 00                	push   $0x0
  80150b:	6a 00                	push   $0x0
  80150d:	6a 28                	push   $0x28
  80150f:	e8 43 fb ff ff       	call   801057 <syscall>
  801514:	83 c4 18             	add    $0x18,%esp
	return ;
  801517:	90                   	nop
}
  801518:	c9                   	leave  
  801519:	c3                   	ret    

0080151a <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80151a:	55                   	push   %ebp
  80151b:	89 e5                	mov    %esp,%ebp
  80151d:	83 ec 04             	sub    $0x4,%esp
  801520:	8b 45 14             	mov    0x14(%ebp),%eax
  801523:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801526:	8b 55 18             	mov    0x18(%ebp),%edx
  801529:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80152d:	52                   	push   %edx
  80152e:	50                   	push   %eax
  80152f:	ff 75 10             	pushl  0x10(%ebp)
  801532:	ff 75 0c             	pushl  0xc(%ebp)
  801535:	ff 75 08             	pushl  0x8(%ebp)
  801538:	6a 27                	push   $0x27
  80153a:	e8 18 fb ff ff       	call   801057 <syscall>
  80153f:	83 c4 18             	add    $0x18,%esp
	return ;
  801542:	90                   	nop
}
  801543:	c9                   	leave  
  801544:	c3                   	ret    

00801545 <chktst>:
void chktst(uint32 n)
{
  801545:	55                   	push   %ebp
  801546:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801548:	6a 00                	push   $0x0
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	ff 75 08             	pushl  0x8(%ebp)
  801553:	6a 29                	push   $0x29
  801555:	e8 fd fa ff ff       	call   801057 <syscall>
  80155a:	83 c4 18             	add    $0x18,%esp
	return ;
  80155d:	90                   	nop
}
  80155e:	c9                   	leave  
  80155f:	c3                   	ret    

00801560 <inctst>:

void inctst()
{
  801560:	55                   	push   %ebp
  801561:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801563:	6a 00                	push   $0x0
  801565:	6a 00                	push   $0x0
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	6a 2a                	push   $0x2a
  80156f:	e8 e3 fa ff ff       	call   801057 <syscall>
  801574:	83 c4 18             	add    $0x18,%esp
	return ;
  801577:	90                   	nop
}
  801578:	c9                   	leave  
  801579:	c3                   	ret    

0080157a <gettst>:
uint32 gettst()
{
  80157a:	55                   	push   %ebp
  80157b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 00                	push   $0x0
  801587:	6a 2b                	push   $0x2b
  801589:	e8 c9 fa ff ff       	call   801057 <syscall>
  80158e:	83 c4 18             	add    $0x18,%esp
}
  801591:	c9                   	leave  
  801592:	c3                   	ret    

00801593 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801593:	55                   	push   %ebp
  801594:	89 e5                	mov    %esp,%ebp
  801596:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 2c                	push   $0x2c
  8015a5:	e8 ad fa ff ff       	call   801057 <syscall>
  8015aa:	83 c4 18             	add    $0x18,%esp
  8015ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8015b0:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8015b4:	75 07                	jne    8015bd <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8015b6:	b8 01 00 00 00       	mov    $0x1,%eax
  8015bb:	eb 05                	jmp    8015c2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8015bd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015c2:	c9                   	leave  
  8015c3:	c3                   	ret    

008015c4 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8015c4:	55                   	push   %ebp
  8015c5:	89 e5                	mov    %esp,%ebp
  8015c7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 00                	push   $0x0
  8015ce:	6a 00                	push   $0x0
  8015d0:	6a 00                	push   $0x0
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 2c                	push   $0x2c
  8015d6:	e8 7c fa ff ff       	call   801057 <syscall>
  8015db:	83 c4 18             	add    $0x18,%esp
  8015de:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015e1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015e5:	75 07                	jne    8015ee <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015e7:	b8 01 00 00 00       	mov    $0x1,%eax
  8015ec:	eb 05                	jmp    8015f3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015f3:	c9                   	leave  
  8015f4:	c3                   	ret    

008015f5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015f5:	55                   	push   %ebp
  8015f6:	89 e5                	mov    %esp,%ebp
  8015f8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	6a 00                	push   $0x0
  801603:	6a 00                	push   $0x0
  801605:	6a 2c                	push   $0x2c
  801607:	e8 4b fa ff ff       	call   801057 <syscall>
  80160c:	83 c4 18             	add    $0x18,%esp
  80160f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801612:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801616:	75 07                	jne    80161f <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801618:	b8 01 00 00 00       	mov    $0x1,%eax
  80161d:	eb 05                	jmp    801624 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80161f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801624:	c9                   	leave  
  801625:	c3                   	ret    

00801626 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801626:	55                   	push   %ebp
  801627:	89 e5                	mov    %esp,%ebp
  801629:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80162c:	6a 00                	push   $0x0
  80162e:	6a 00                	push   $0x0
  801630:	6a 00                	push   $0x0
  801632:	6a 00                	push   $0x0
  801634:	6a 00                	push   $0x0
  801636:	6a 2c                	push   $0x2c
  801638:	e8 1a fa ff ff       	call   801057 <syscall>
  80163d:	83 c4 18             	add    $0x18,%esp
  801640:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801643:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801647:	75 07                	jne    801650 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801649:	b8 01 00 00 00       	mov    $0x1,%eax
  80164e:	eb 05                	jmp    801655 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801650:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801655:	c9                   	leave  
  801656:	c3                   	ret    

00801657 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801657:	55                   	push   %ebp
  801658:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80165a:	6a 00                	push   $0x0
  80165c:	6a 00                	push   $0x0
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	ff 75 08             	pushl  0x8(%ebp)
  801665:	6a 2d                	push   $0x2d
  801667:	e8 eb f9 ff ff       	call   801057 <syscall>
  80166c:	83 c4 18             	add    $0x18,%esp
	return ;
  80166f:	90                   	nop
}
  801670:	c9                   	leave  
  801671:	c3                   	ret    

00801672 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801672:	55                   	push   %ebp
  801673:	89 e5                	mov    %esp,%ebp
  801675:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801676:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801679:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80167c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80167f:	8b 45 08             	mov    0x8(%ebp),%eax
  801682:	6a 00                	push   $0x0
  801684:	53                   	push   %ebx
  801685:	51                   	push   %ecx
  801686:	52                   	push   %edx
  801687:	50                   	push   %eax
  801688:	6a 2e                	push   $0x2e
  80168a:	e8 c8 f9 ff ff       	call   801057 <syscall>
  80168f:	83 c4 18             	add    $0x18,%esp
}
  801692:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801695:	c9                   	leave  
  801696:	c3                   	ret    

00801697 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801697:	55                   	push   %ebp
  801698:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80169a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80169d:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 00                	push   $0x0
  8016a4:	6a 00                	push   $0x0
  8016a6:	52                   	push   %edx
  8016a7:	50                   	push   %eax
  8016a8:	6a 2f                	push   $0x2f
  8016aa:	e8 a8 f9 ff ff       	call   801057 <syscall>
  8016af:	83 c4 18             	add    $0x18,%esp
}
  8016b2:	c9                   	leave  
  8016b3:	c3                   	ret    

008016b4 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8016b4:	55                   	push   %ebp
  8016b5:	89 e5                	mov    %esp,%ebp
  8016b7:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8016ba:	8b 55 08             	mov    0x8(%ebp),%edx
  8016bd:	89 d0                	mov    %edx,%eax
  8016bf:	c1 e0 02             	shl    $0x2,%eax
  8016c2:	01 d0                	add    %edx,%eax
  8016c4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016cb:	01 d0                	add    %edx,%eax
  8016cd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016d4:	01 d0                	add    %edx,%eax
  8016d6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016dd:	01 d0                	add    %edx,%eax
  8016df:	c1 e0 04             	shl    $0x4,%eax
  8016e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8016e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8016ec:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8016ef:	83 ec 0c             	sub    $0xc,%esp
  8016f2:	50                   	push   %eax
  8016f3:	e8 76 fd ff ff       	call   80146e <sys_get_virtual_time>
  8016f8:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8016fb:	eb 41                	jmp    80173e <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8016fd:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801700:	83 ec 0c             	sub    $0xc,%esp
  801703:	50                   	push   %eax
  801704:	e8 65 fd ff ff       	call   80146e <sys_get_virtual_time>
  801709:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  80170c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80170f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801712:	29 c2                	sub    %eax,%edx
  801714:	89 d0                	mov    %edx,%eax
  801716:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801719:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80171c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80171f:	89 d1                	mov    %edx,%ecx
  801721:	29 c1                	sub    %eax,%ecx
  801723:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801726:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801729:	39 c2                	cmp    %eax,%edx
  80172b:	0f 97 c0             	seta   %al
  80172e:	0f b6 c0             	movzbl %al,%eax
  801731:	29 c1                	sub    %eax,%ecx
  801733:	89 c8                	mov    %ecx,%eax
  801735:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801738:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80173b:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  80173e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801741:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801744:	72 b7                	jb     8016fd <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801746:	90                   	nop
  801747:	c9                   	leave  
  801748:	c3                   	ret    

00801749 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801749:	55                   	push   %ebp
  80174a:	89 e5                	mov    %esp,%ebp
  80174c:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80174f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801756:	eb 03                	jmp    80175b <busy_wait+0x12>
  801758:	ff 45 fc             	incl   -0x4(%ebp)
  80175b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80175e:	3b 45 08             	cmp    0x8(%ebp),%eax
  801761:	72 f5                	jb     801758 <busy_wait+0xf>
	return i;
  801763:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801766:	c9                   	leave  
  801767:	c3                   	ret    

00801768 <__udivdi3>:
  801768:	55                   	push   %ebp
  801769:	57                   	push   %edi
  80176a:	56                   	push   %esi
  80176b:	53                   	push   %ebx
  80176c:	83 ec 1c             	sub    $0x1c,%esp
  80176f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801773:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801777:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80177b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80177f:	89 ca                	mov    %ecx,%edx
  801781:	89 f8                	mov    %edi,%eax
  801783:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801787:	85 f6                	test   %esi,%esi
  801789:	75 2d                	jne    8017b8 <__udivdi3+0x50>
  80178b:	39 cf                	cmp    %ecx,%edi
  80178d:	77 65                	ja     8017f4 <__udivdi3+0x8c>
  80178f:	89 fd                	mov    %edi,%ebp
  801791:	85 ff                	test   %edi,%edi
  801793:	75 0b                	jne    8017a0 <__udivdi3+0x38>
  801795:	b8 01 00 00 00       	mov    $0x1,%eax
  80179a:	31 d2                	xor    %edx,%edx
  80179c:	f7 f7                	div    %edi
  80179e:	89 c5                	mov    %eax,%ebp
  8017a0:	31 d2                	xor    %edx,%edx
  8017a2:	89 c8                	mov    %ecx,%eax
  8017a4:	f7 f5                	div    %ebp
  8017a6:	89 c1                	mov    %eax,%ecx
  8017a8:	89 d8                	mov    %ebx,%eax
  8017aa:	f7 f5                	div    %ebp
  8017ac:	89 cf                	mov    %ecx,%edi
  8017ae:	89 fa                	mov    %edi,%edx
  8017b0:	83 c4 1c             	add    $0x1c,%esp
  8017b3:	5b                   	pop    %ebx
  8017b4:	5e                   	pop    %esi
  8017b5:	5f                   	pop    %edi
  8017b6:	5d                   	pop    %ebp
  8017b7:	c3                   	ret    
  8017b8:	39 ce                	cmp    %ecx,%esi
  8017ba:	77 28                	ja     8017e4 <__udivdi3+0x7c>
  8017bc:	0f bd fe             	bsr    %esi,%edi
  8017bf:	83 f7 1f             	xor    $0x1f,%edi
  8017c2:	75 40                	jne    801804 <__udivdi3+0x9c>
  8017c4:	39 ce                	cmp    %ecx,%esi
  8017c6:	72 0a                	jb     8017d2 <__udivdi3+0x6a>
  8017c8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8017cc:	0f 87 9e 00 00 00    	ja     801870 <__udivdi3+0x108>
  8017d2:	b8 01 00 00 00       	mov    $0x1,%eax
  8017d7:	89 fa                	mov    %edi,%edx
  8017d9:	83 c4 1c             	add    $0x1c,%esp
  8017dc:	5b                   	pop    %ebx
  8017dd:	5e                   	pop    %esi
  8017de:	5f                   	pop    %edi
  8017df:	5d                   	pop    %ebp
  8017e0:	c3                   	ret    
  8017e1:	8d 76 00             	lea    0x0(%esi),%esi
  8017e4:	31 ff                	xor    %edi,%edi
  8017e6:	31 c0                	xor    %eax,%eax
  8017e8:	89 fa                	mov    %edi,%edx
  8017ea:	83 c4 1c             	add    $0x1c,%esp
  8017ed:	5b                   	pop    %ebx
  8017ee:	5e                   	pop    %esi
  8017ef:	5f                   	pop    %edi
  8017f0:	5d                   	pop    %ebp
  8017f1:	c3                   	ret    
  8017f2:	66 90                	xchg   %ax,%ax
  8017f4:	89 d8                	mov    %ebx,%eax
  8017f6:	f7 f7                	div    %edi
  8017f8:	31 ff                	xor    %edi,%edi
  8017fa:	89 fa                	mov    %edi,%edx
  8017fc:	83 c4 1c             	add    $0x1c,%esp
  8017ff:	5b                   	pop    %ebx
  801800:	5e                   	pop    %esi
  801801:	5f                   	pop    %edi
  801802:	5d                   	pop    %ebp
  801803:	c3                   	ret    
  801804:	bd 20 00 00 00       	mov    $0x20,%ebp
  801809:	89 eb                	mov    %ebp,%ebx
  80180b:	29 fb                	sub    %edi,%ebx
  80180d:	89 f9                	mov    %edi,%ecx
  80180f:	d3 e6                	shl    %cl,%esi
  801811:	89 c5                	mov    %eax,%ebp
  801813:	88 d9                	mov    %bl,%cl
  801815:	d3 ed                	shr    %cl,%ebp
  801817:	89 e9                	mov    %ebp,%ecx
  801819:	09 f1                	or     %esi,%ecx
  80181b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80181f:	89 f9                	mov    %edi,%ecx
  801821:	d3 e0                	shl    %cl,%eax
  801823:	89 c5                	mov    %eax,%ebp
  801825:	89 d6                	mov    %edx,%esi
  801827:	88 d9                	mov    %bl,%cl
  801829:	d3 ee                	shr    %cl,%esi
  80182b:	89 f9                	mov    %edi,%ecx
  80182d:	d3 e2                	shl    %cl,%edx
  80182f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801833:	88 d9                	mov    %bl,%cl
  801835:	d3 e8                	shr    %cl,%eax
  801837:	09 c2                	or     %eax,%edx
  801839:	89 d0                	mov    %edx,%eax
  80183b:	89 f2                	mov    %esi,%edx
  80183d:	f7 74 24 0c          	divl   0xc(%esp)
  801841:	89 d6                	mov    %edx,%esi
  801843:	89 c3                	mov    %eax,%ebx
  801845:	f7 e5                	mul    %ebp
  801847:	39 d6                	cmp    %edx,%esi
  801849:	72 19                	jb     801864 <__udivdi3+0xfc>
  80184b:	74 0b                	je     801858 <__udivdi3+0xf0>
  80184d:	89 d8                	mov    %ebx,%eax
  80184f:	31 ff                	xor    %edi,%edi
  801851:	e9 58 ff ff ff       	jmp    8017ae <__udivdi3+0x46>
  801856:	66 90                	xchg   %ax,%ax
  801858:	8b 54 24 08          	mov    0x8(%esp),%edx
  80185c:	89 f9                	mov    %edi,%ecx
  80185e:	d3 e2                	shl    %cl,%edx
  801860:	39 c2                	cmp    %eax,%edx
  801862:	73 e9                	jae    80184d <__udivdi3+0xe5>
  801864:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801867:	31 ff                	xor    %edi,%edi
  801869:	e9 40 ff ff ff       	jmp    8017ae <__udivdi3+0x46>
  80186e:	66 90                	xchg   %ax,%ax
  801870:	31 c0                	xor    %eax,%eax
  801872:	e9 37 ff ff ff       	jmp    8017ae <__udivdi3+0x46>
  801877:	90                   	nop

00801878 <__umoddi3>:
  801878:	55                   	push   %ebp
  801879:	57                   	push   %edi
  80187a:	56                   	push   %esi
  80187b:	53                   	push   %ebx
  80187c:	83 ec 1c             	sub    $0x1c,%esp
  80187f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801883:	8b 74 24 34          	mov    0x34(%esp),%esi
  801887:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80188b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80188f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801893:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801897:	89 f3                	mov    %esi,%ebx
  801899:	89 fa                	mov    %edi,%edx
  80189b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80189f:	89 34 24             	mov    %esi,(%esp)
  8018a2:	85 c0                	test   %eax,%eax
  8018a4:	75 1a                	jne    8018c0 <__umoddi3+0x48>
  8018a6:	39 f7                	cmp    %esi,%edi
  8018a8:	0f 86 a2 00 00 00    	jbe    801950 <__umoddi3+0xd8>
  8018ae:	89 c8                	mov    %ecx,%eax
  8018b0:	89 f2                	mov    %esi,%edx
  8018b2:	f7 f7                	div    %edi
  8018b4:	89 d0                	mov    %edx,%eax
  8018b6:	31 d2                	xor    %edx,%edx
  8018b8:	83 c4 1c             	add    $0x1c,%esp
  8018bb:	5b                   	pop    %ebx
  8018bc:	5e                   	pop    %esi
  8018bd:	5f                   	pop    %edi
  8018be:	5d                   	pop    %ebp
  8018bf:	c3                   	ret    
  8018c0:	39 f0                	cmp    %esi,%eax
  8018c2:	0f 87 ac 00 00 00    	ja     801974 <__umoddi3+0xfc>
  8018c8:	0f bd e8             	bsr    %eax,%ebp
  8018cb:	83 f5 1f             	xor    $0x1f,%ebp
  8018ce:	0f 84 ac 00 00 00    	je     801980 <__umoddi3+0x108>
  8018d4:	bf 20 00 00 00       	mov    $0x20,%edi
  8018d9:	29 ef                	sub    %ebp,%edi
  8018db:	89 fe                	mov    %edi,%esi
  8018dd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8018e1:	89 e9                	mov    %ebp,%ecx
  8018e3:	d3 e0                	shl    %cl,%eax
  8018e5:	89 d7                	mov    %edx,%edi
  8018e7:	89 f1                	mov    %esi,%ecx
  8018e9:	d3 ef                	shr    %cl,%edi
  8018eb:	09 c7                	or     %eax,%edi
  8018ed:	89 e9                	mov    %ebp,%ecx
  8018ef:	d3 e2                	shl    %cl,%edx
  8018f1:	89 14 24             	mov    %edx,(%esp)
  8018f4:	89 d8                	mov    %ebx,%eax
  8018f6:	d3 e0                	shl    %cl,%eax
  8018f8:	89 c2                	mov    %eax,%edx
  8018fa:	8b 44 24 08          	mov    0x8(%esp),%eax
  8018fe:	d3 e0                	shl    %cl,%eax
  801900:	89 44 24 04          	mov    %eax,0x4(%esp)
  801904:	8b 44 24 08          	mov    0x8(%esp),%eax
  801908:	89 f1                	mov    %esi,%ecx
  80190a:	d3 e8                	shr    %cl,%eax
  80190c:	09 d0                	or     %edx,%eax
  80190e:	d3 eb                	shr    %cl,%ebx
  801910:	89 da                	mov    %ebx,%edx
  801912:	f7 f7                	div    %edi
  801914:	89 d3                	mov    %edx,%ebx
  801916:	f7 24 24             	mull   (%esp)
  801919:	89 c6                	mov    %eax,%esi
  80191b:	89 d1                	mov    %edx,%ecx
  80191d:	39 d3                	cmp    %edx,%ebx
  80191f:	0f 82 87 00 00 00    	jb     8019ac <__umoddi3+0x134>
  801925:	0f 84 91 00 00 00    	je     8019bc <__umoddi3+0x144>
  80192b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80192f:	29 f2                	sub    %esi,%edx
  801931:	19 cb                	sbb    %ecx,%ebx
  801933:	89 d8                	mov    %ebx,%eax
  801935:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801939:	d3 e0                	shl    %cl,%eax
  80193b:	89 e9                	mov    %ebp,%ecx
  80193d:	d3 ea                	shr    %cl,%edx
  80193f:	09 d0                	or     %edx,%eax
  801941:	89 e9                	mov    %ebp,%ecx
  801943:	d3 eb                	shr    %cl,%ebx
  801945:	89 da                	mov    %ebx,%edx
  801947:	83 c4 1c             	add    $0x1c,%esp
  80194a:	5b                   	pop    %ebx
  80194b:	5e                   	pop    %esi
  80194c:	5f                   	pop    %edi
  80194d:	5d                   	pop    %ebp
  80194e:	c3                   	ret    
  80194f:	90                   	nop
  801950:	89 fd                	mov    %edi,%ebp
  801952:	85 ff                	test   %edi,%edi
  801954:	75 0b                	jne    801961 <__umoddi3+0xe9>
  801956:	b8 01 00 00 00       	mov    $0x1,%eax
  80195b:	31 d2                	xor    %edx,%edx
  80195d:	f7 f7                	div    %edi
  80195f:	89 c5                	mov    %eax,%ebp
  801961:	89 f0                	mov    %esi,%eax
  801963:	31 d2                	xor    %edx,%edx
  801965:	f7 f5                	div    %ebp
  801967:	89 c8                	mov    %ecx,%eax
  801969:	f7 f5                	div    %ebp
  80196b:	89 d0                	mov    %edx,%eax
  80196d:	e9 44 ff ff ff       	jmp    8018b6 <__umoddi3+0x3e>
  801972:	66 90                	xchg   %ax,%ax
  801974:	89 c8                	mov    %ecx,%eax
  801976:	89 f2                	mov    %esi,%edx
  801978:	83 c4 1c             	add    $0x1c,%esp
  80197b:	5b                   	pop    %ebx
  80197c:	5e                   	pop    %esi
  80197d:	5f                   	pop    %edi
  80197e:	5d                   	pop    %ebp
  80197f:	c3                   	ret    
  801980:	3b 04 24             	cmp    (%esp),%eax
  801983:	72 06                	jb     80198b <__umoddi3+0x113>
  801985:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801989:	77 0f                	ja     80199a <__umoddi3+0x122>
  80198b:	89 f2                	mov    %esi,%edx
  80198d:	29 f9                	sub    %edi,%ecx
  80198f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801993:	89 14 24             	mov    %edx,(%esp)
  801996:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80199a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80199e:	8b 14 24             	mov    (%esp),%edx
  8019a1:	83 c4 1c             	add    $0x1c,%esp
  8019a4:	5b                   	pop    %ebx
  8019a5:	5e                   	pop    %esi
  8019a6:	5f                   	pop    %edi
  8019a7:	5d                   	pop    %ebp
  8019a8:	c3                   	ret    
  8019a9:	8d 76 00             	lea    0x0(%esi),%esi
  8019ac:	2b 04 24             	sub    (%esp),%eax
  8019af:	19 fa                	sbb    %edi,%edx
  8019b1:	89 d1                	mov    %edx,%ecx
  8019b3:	89 c6                	mov    %eax,%esi
  8019b5:	e9 71 ff ff ff       	jmp    80192b <__umoddi3+0xb3>
  8019ba:	66 90                	xchg   %ax,%ax
  8019bc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8019c0:	72 ea                	jb     8019ac <__umoddi3+0x134>
  8019c2:	89 d9                	mov    %ebx,%ecx
  8019c4:	e9 62 ff ff ff       	jmp    80192b <__umoddi3+0xb3>
