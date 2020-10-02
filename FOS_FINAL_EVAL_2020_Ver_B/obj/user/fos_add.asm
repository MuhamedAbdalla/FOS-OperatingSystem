
obj/user/fos_add:     file format elf32-i386


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
  800031:	e8 60 00 00 00       	call   800096 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// hello, world
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	int i1=0;
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int i2=0;
  800045:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	i1 = strtol("1", NULL, 10);
  80004c:	83 ec 04             	sub    $0x4,%esp
  80004f:	6a 0a                	push   $0xa
  800051:	6a 00                	push   $0x0
  800053:	68 00 19 80 00       	push   $0x801900
  800058:	e8 14 0c 00 00       	call   800c71 <strtol>
  80005d:	83 c4 10             	add    $0x10,%esp
  800060:	89 45 f4             	mov    %eax,-0xc(%ebp)
	i2 = strtol("2", NULL, 10);
  800063:	83 ec 04             	sub    $0x4,%esp
  800066:	6a 0a                	push   $0xa
  800068:	6a 00                	push   $0x0
  80006a:	68 02 19 80 00       	push   $0x801902
  80006f:	e8 fd 0b 00 00       	call   800c71 <strtol>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("number 1 + number 2 = %d\n",i1+i2);
  80007a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80007d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800080:	01 d0                	add    %edx,%eax
  800082:	83 ec 08             	sub    $0x8,%esp
  800085:	50                   	push   %eax
  800086:	68 04 19 80 00       	push   $0x801904
  80008b:	e8 2c 02 00 00       	call   8002bc <atomic_cprintf>
  800090:	83 c4 10             	add    $0x10,%esp
	//cprintf("number 1 + number 2 = \n");
	return;
  800093:	90                   	nop
}
  800094:	c9                   	leave  
  800095:	c3                   	ret    

00800096 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800096:	55                   	push   %ebp
  800097:	89 e5                	mov    %esp,%ebp
  800099:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80009c:	e8 19 10 00 00       	call   8010ba <sys_getenvindex>
  8000a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000a7:	89 d0                	mov    %edx,%eax
  8000a9:	c1 e0 03             	shl    $0x3,%eax
  8000ac:	01 d0                	add    %edx,%eax
  8000ae:	c1 e0 02             	shl    $0x2,%eax
  8000b1:	01 d0                	add    %edx,%eax
  8000b3:	c1 e0 06             	shl    $0x6,%eax
  8000b6:	29 d0                	sub    %edx,%eax
  8000b8:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8000bf:	01 c8                	add    %ecx,%eax
  8000c1:	01 d0                	add    %edx,%eax
  8000c3:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000c8:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000cd:	a1 20 20 80 00       	mov    0x802020,%eax
  8000d2:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  8000d8:	84 c0                	test   %al,%al
  8000da:	74 0f                	je     8000eb <libmain+0x55>
		binaryname = myEnv->prog_name;
  8000dc:	a1 20 20 80 00       	mov    0x802020,%eax
  8000e1:	05 b0 52 00 00       	add    $0x52b0,%eax
  8000e6:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000eb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000ef:	7e 0a                	jle    8000fb <libmain+0x65>
		binaryname = argv[0];
  8000f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000f4:	8b 00                	mov    (%eax),%eax
  8000f6:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000fb:	83 ec 08             	sub    $0x8,%esp
  8000fe:	ff 75 0c             	pushl  0xc(%ebp)
  800101:	ff 75 08             	pushl  0x8(%ebp)
  800104:	e8 2f ff ff ff       	call   800038 <_main>
  800109:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80010c:	e8 44 11 00 00       	call   801255 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800111:	83 ec 0c             	sub    $0xc,%esp
  800114:	68 38 19 80 00       	push   $0x801938
  800119:	e8 71 01 00 00       	call   80028f <cprintf>
  80011e:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800121:	a1 20 20 80 00       	mov    0x802020,%eax
  800126:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  80012c:	a1 20 20 80 00       	mov    0x802020,%eax
  800131:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  800137:	83 ec 04             	sub    $0x4,%esp
  80013a:	52                   	push   %edx
  80013b:	50                   	push   %eax
  80013c:	68 60 19 80 00       	push   $0x801960
  800141:	e8 49 01 00 00       	call   80028f <cprintf>
  800146:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800149:	a1 20 20 80 00       	mov    0x802020,%eax
  80014e:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  800154:	a1 20 20 80 00       	mov    0x802020,%eax
  800159:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  80015f:	a1 20 20 80 00       	mov    0x802020,%eax
  800164:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  80016a:	51                   	push   %ecx
  80016b:	52                   	push   %edx
  80016c:	50                   	push   %eax
  80016d:	68 88 19 80 00       	push   $0x801988
  800172:	e8 18 01 00 00       	call   80028f <cprintf>
  800177:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80017a:	83 ec 0c             	sub    $0xc,%esp
  80017d:	68 38 19 80 00       	push   $0x801938
  800182:	e8 08 01 00 00       	call   80028f <cprintf>
  800187:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80018a:	e8 e0 10 00 00       	call   80126f <sys_enable_interrupt>

	// exit gracefully
	exit();
  80018f:	e8 19 00 00 00       	call   8001ad <exit>
}
  800194:	90                   	nop
  800195:	c9                   	leave  
  800196:	c3                   	ret    

00800197 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800197:	55                   	push   %ebp
  800198:	89 e5                	mov    %esp,%ebp
  80019a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80019d:	83 ec 0c             	sub    $0xc,%esp
  8001a0:	6a 00                	push   $0x0
  8001a2:	e8 df 0e 00 00       	call   801086 <sys_env_destroy>
  8001a7:	83 c4 10             	add    $0x10,%esp
}
  8001aa:	90                   	nop
  8001ab:	c9                   	leave  
  8001ac:	c3                   	ret    

008001ad <exit>:

void
exit(void)
{
  8001ad:	55                   	push   %ebp
  8001ae:	89 e5                	mov    %esp,%ebp
  8001b0:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001b3:	e8 34 0f 00 00       	call   8010ec <sys_env_exit>
}
  8001b8:	90                   	nop
  8001b9:	c9                   	leave  
  8001ba:	c3                   	ret    

008001bb <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001bb:	55                   	push   %ebp
  8001bc:	89 e5                	mov    %esp,%ebp
  8001be:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c4:	8b 00                	mov    (%eax),%eax
  8001c6:	8d 48 01             	lea    0x1(%eax),%ecx
  8001c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001cc:	89 0a                	mov    %ecx,(%edx)
  8001ce:	8b 55 08             	mov    0x8(%ebp),%edx
  8001d1:	88 d1                	mov    %dl,%cl
  8001d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001d6:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001dd:	8b 00                	mov    (%eax),%eax
  8001df:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001e4:	75 2c                	jne    800212 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001e6:	a0 24 20 80 00       	mov    0x802024,%al
  8001eb:	0f b6 c0             	movzbl %al,%eax
  8001ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001f1:	8b 12                	mov    (%edx),%edx
  8001f3:	89 d1                	mov    %edx,%ecx
  8001f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001f8:	83 c2 08             	add    $0x8,%edx
  8001fb:	83 ec 04             	sub    $0x4,%esp
  8001fe:	50                   	push   %eax
  8001ff:	51                   	push   %ecx
  800200:	52                   	push   %edx
  800201:	e8 3e 0e 00 00       	call   801044 <sys_cputs>
  800206:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800209:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800212:	8b 45 0c             	mov    0xc(%ebp),%eax
  800215:	8b 40 04             	mov    0x4(%eax),%eax
  800218:	8d 50 01             	lea    0x1(%eax),%edx
  80021b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80021e:	89 50 04             	mov    %edx,0x4(%eax)
}
  800221:	90                   	nop
  800222:	c9                   	leave  
  800223:	c3                   	ret    

00800224 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800224:	55                   	push   %ebp
  800225:	89 e5                	mov    %esp,%ebp
  800227:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80022d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800234:	00 00 00 
	b.cnt = 0;
  800237:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80023e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800241:	ff 75 0c             	pushl  0xc(%ebp)
  800244:	ff 75 08             	pushl  0x8(%ebp)
  800247:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80024d:	50                   	push   %eax
  80024e:	68 bb 01 80 00       	push   $0x8001bb
  800253:	e8 11 02 00 00       	call   800469 <vprintfmt>
  800258:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80025b:	a0 24 20 80 00       	mov    0x802024,%al
  800260:	0f b6 c0             	movzbl %al,%eax
  800263:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800269:	83 ec 04             	sub    $0x4,%esp
  80026c:	50                   	push   %eax
  80026d:	52                   	push   %edx
  80026e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800274:	83 c0 08             	add    $0x8,%eax
  800277:	50                   	push   %eax
  800278:	e8 c7 0d 00 00       	call   801044 <sys_cputs>
  80027d:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800280:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  800287:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80028d:	c9                   	leave  
  80028e:	c3                   	ret    

0080028f <cprintf>:

int cprintf(const char *fmt, ...) {
  80028f:	55                   	push   %ebp
  800290:	89 e5                	mov    %esp,%ebp
  800292:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800295:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  80029c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80029f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8002a5:	83 ec 08             	sub    $0x8,%esp
  8002a8:	ff 75 f4             	pushl  -0xc(%ebp)
  8002ab:	50                   	push   %eax
  8002ac:	e8 73 ff ff ff       	call   800224 <vcprintf>
  8002b1:	83 c4 10             	add    $0x10,%esp
  8002b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002ba:	c9                   	leave  
  8002bb:	c3                   	ret    

008002bc <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002bc:	55                   	push   %ebp
  8002bd:	89 e5                	mov    %esp,%ebp
  8002bf:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002c2:	e8 8e 0f 00 00       	call   801255 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002c7:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d0:	83 ec 08             	sub    $0x8,%esp
  8002d3:	ff 75 f4             	pushl  -0xc(%ebp)
  8002d6:	50                   	push   %eax
  8002d7:	e8 48 ff ff ff       	call   800224 <vcprintf>
  8002dc:	83 c4 10             	add    $0x10,%esp
  8002df:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002e2:	e8 88 0f 00 00       	call   80126f <sys_enable_interrupt>
	return cnt;
  8002e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002ea:	c9                   	leave  
  8002eb:	c3                   	ret    

008002ec <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002ec:	55                   	push   %ebp
  8002ed:	89 e5                	mov    %esp,%ebp
  8002ef:	53                   	push   %ebx
  8002f0:	83 ec 14             	sub    $0x14,%esp
  8002f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8002f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8002fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002ff:	8b 45 18             	mov    0x18(%ebp),%eax
  800302:	ba 00 00 00 00       	mov    $0x0,%edx
  800307:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80030a:	77 55                	ja     800361 <printnum+0x75>
  80030c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80030f:	72 05                	jb     800316 <printnum+0x2a>
  800311:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800314:	77 4b                	ja     800361 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800316:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800319:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80031c:	8b 45 18             	mov    0x18(%ebp),%eax
  80031f:	ba 00 00 00 00       	mov    $0x0,%edx
  800324:	52                   	push   %edx
  800325:	50                   	push   %eax
  800326:	ff 75 f4             	pushl  -0xc(%ebp)
  800329:	ff 75 f0             	pushl  -0x10(%ebp)
  80032c:	e8 63 13 00 00       	call   801694 <__udivdi3>
  800331:	83 c4 10             	add    $0x10,%esp
  800334:	83 ec 04             	sub    $0x4,%esp
  800337:	ff 75 20             	pushl  0x20(%ebp)
  80033a:	53                   	push   %ebx
  80033b:	ff 75 18             	pushl  0x18(%ebp)
  80033e:	52                   	push   %edx
  80033f:	50                   	push   %eax
  800340:	ff 75 0c             	pushl  0xc(%ebp)
  800343:	ff 75 08             	pushl  0x8(%ebp)
  800346:	e8 a1 ff ff ff       	call   8002ec <printnum>
  80034b:	83 c4 20             	add    $0x20,%esp
  80034e:	eb 1a                	jmp    80036a <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800350:	83 ec 08             	sub    $0x8,%esp
  800353:	ff 75 0c             	pushl  0xc(%ebp)
  800356:	ff 75 20             	pushl  0x20(%ebp)
  800359:	8b 45 08             	mov    0x8(%ebp),%eax
  80035c:	ff d0                	call   *%eax
  80035e:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800361:	ff 4d 1c             	decl   0x1c(%ebp)
  800364:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800368:	7f e6                	jg     800350 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80036a:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80036d:	bb 00 00 00 00       	mov    $0x0,%ebx
  800372:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800375:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800378:	53                   	push   %ebx
  800379:	51                   	push   %ecx
  80037a:	52                   	push   %edx
  80037b:	50                   	push   %eax
  80037c:	e8 23 14 00 00       	call   8017a4 <__umoddi3>
  800381:	83 c4 10             	add    $0x10,%esp
  800384:	05 f4 1b 80 00       	add    $0x801bf4,%eax
  800389:	8a 00                	mov    (%eax),%al
  80038b:	0f be c0             	movsbl %al,%eax
  80038e:	83 ec 08             	sub    $0x8,%esp
  800391:	ff 75 0c             	pushl  0xc(%ebp)
  800394:	50                   	push   %eax
  800395:	8b 45 08             	mov    0x8(%ebp),%eax
  800398:	ff d0                	call   *%eax
  80039a:	83 c4 10             	add    $0x10,%esp
}
  80039d:	90                   	nop
  80039e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003a1:	c9                   	leave  
  8003a2:	c3                   	ret    

008003a3 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003a3:	55                   	push   %ebp
  8003a4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003a6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003aa:	7e 1c                	jle    8003c8 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8003af:	8b 00                	mov    (%eax),%eax
  8003b1:	8d 50 08             	lea    0x8(%eax),%edx
  8003b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b7:	89 10                	mov    %edx,(%eax)
  8003b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bc:	8b 00                	mov    (%eax),%eax
  8003be:	83 e8 08             	sub    $0x8,%eax
  8003c1:	8b 50 04             	mov    0x4(%eax),%edx
  8003c4:	8b 00                	mov    (%eax),%eax
  8003c6:	eb 40                	jmp    800408 <getuint+0x65>
	else if (lflag)
  8003c8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003cc:	74 1e                	je     8003ec <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d1:	8b 00                	mov    (%eax),%eax
  8003d3:	8d 50 04             	lea    0x4(%eax),%edx
  8003d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d9:	89 10                	mov    %edx,(%eax)
  8003db:	8b 45 08             	mov    0x8(%ebp),%eax
  8003de:	8b 00                	mov    (%eax),%eax
  8003e0:	83 e8 04             	sub    $0x4,%eax
  8003e3:	8b 00                	mov    (%eax),%eax
  8003e5:	ba 00 00 00 00       	mov    $0x0,%edx
  8003ea:	eb 1c                	jmp    800408 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ef:	8b 00                	mov    (%eax),%eax
  8003f1:	8d 50 04             	lea    0x4(%eax),%edx
  8003f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f7:	89 10                	mov    %edx,(%eax)
  8003f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fc:	8b 00                	mov    (%eax),%eax
  8003fe:	83 e8 04             	sub    $0x4,%eax
  800401:	8b 00                	mov    (%eax),%eax
  800403:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800408:	5d                   	pop    %ebp
  800409:	c3                   	ret    

0080040a <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80040a:	55                   	push   %ebp
  80040b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80040d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800411:	7e 1c                	jle    80042f <getint+0x25>
		return va_arg(*ap, long long);
  800413:	8b 45 08             	mov    0x8(%ebp),%eax
  800416:	8b 00                	mov    (%eax),%eax
  800418:	8d 50 08             	lea    0x8(%eax),%edx
  80041b:	8b 45 08             	mov    0x8(%ebp),%eax
  80041e:	89 10                	mov    %edx,(%eax)
  800420:	8b 45 08             	mov    0x8(%ebp),%eax
  800423:	8b 00                	mov    (%eax),%eax
  800425:	83 e8 08             	sub    $0x8,%eax
  800428:	8b 50 04             	mov    0x4(%eax),%edx
  80042b:	8b 00                	mov    (%eax),%eax
  80042d:	eb 38                	jmp    800467 <getint+0x5d>
	else if (lflag)
  80042f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800433:	74 1a                	je     80044f <getint+0x45>
		return va_arg(*ap, long);
  800435:	8b 45 08             	mov    0x8(%ebp),%eax
  800438:	8b 00                	mov    (%eax),%eax
  80043a:	8d 50 04             	lea    0x4(%eax),%edx
  80043d:	8b 45 08             	mov    0x8(%ebp),%eax
  800440:	89 10                	mov    %edx,(%eax)
  800442:	8b 45 08             	mov    0x8(%ebp),%eax
  800445:	8b 00                	mov    (%eax),%eax
  800447:	83 e8 04             	sub    $0x4,%eax
  80044a:	8b 00                	mov    (%eax),%eax
  80044c:	99                   	cltd   
  80044d:	eb 18                	jmp    800467 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80044f:	8b 45 08             	mov    0x8(%ebp),%eax
  800452:	8b 00                	mov    (%eax),%eax
  800454:	8d 50 04             	lea    0x4(%eax),%edx
  800457:	8b 45 08             	mov    0x8(%ebp),%eax
  80045a:	89 10                	mov    %edx,(%eax)
  80045c:	8b 45 08             	mov    0x8(%ebp),%eax
  80045f:	8b 00                	mov    (%eax),%eax
  800461:	83 e8 04             	sub    $0x4,%eax
  800464:	8b 00                	mov    (%eax),%eax
  800466:	99                   	cltd   
}
  800467:	5d                   	pop    %ebp
  800468:	c3                   	ret    

00800469 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800469:	55                   	push   %ebp
  80046a:	89 e5                	mov    %esp,%ebp
  80046c:	56                   	push   %esi
  80046d:	53                   	push   %ebx
  80046e:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800471:	eb 17                	jmp    80048a <vprintfmt+0x21>
			if (ch == '\0')
  800473:	85 db                	test   %ebx,%ebx
  800475:	0f 84 af 03 00 00    	je     80082a <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80047b:	83 ec 08             	sub    $0x8,%esp
  80047e:	ff 75 0c             	pushl  0xc(%ebp)
  800481:	53                   	push   %ebx
  800482:	8b 45 08             	mov    0x8(%ebp),%eax
  800485:	ff d0                	call   *%eax
  800487:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80048a:	8b 45 10             	mov    0x10(%ebp),%eax
  80048d:	8d 50 01             	lea    0x1(%eax),%edx
  800490:	89 55 10             	mov    %edx,0x10(%ebp)
  800493:	8a 00                	mov    (%eax),%al
  800495:	0f b6 d8             	movzbl %al,%ebx
  800498:	83 fb 25             	cmp    $0x25,%ebx
  80049b:	75 d6                	jne    800473 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80049d:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004a1:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004a8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004af:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004b6:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c0:	8d 50 01             	lea    0x1(%eax),%edx
  8004c3:	89 55 10             	mov    %edx,0x10(%ebp)
  8004c6:	8a 00                	mov    (%eax),%al
  8004c8:	0f b6 d8             	movzbl %al,%ebx
  8004cb:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004ce:	83 f8 55             	cmp    $0x55,%eax
  8004d1:	0f 87 2b 03 00 00    	ja     800802 <vprintfmt+0x399>
  8004d7:	8b 04 85 18 1c 80 00 	mov    0x801c18(,%eax,4),%eax
  8004de:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004e0:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004e4:	eb d7                	jmp    8004bd <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004e6:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004ea:	eb d1                	jmp    8004bd <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004ec:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004f3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004f6:	89 d0                	mov    %edx,%eax
  8004f8:	c1 e0 02             	shl    $0x2,%eax
  8004fb:	01 d0                	add    %edx,%eax
  8004fd:	01 c0                	add    %eax,%eax
  8004ff:	01 d8                	add    %ebx,%eax
  800501:	83 e8 30             	sub    $0x30,%eax
  800504:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800507:	8b 45 10             	mov    0x10(%ebp),%eax
  80050a:	8a 00                	mov    (%eax),%al
  80050c:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80050f:	83 fb 2f             	cmp    $0x2f,%ebx
  800512:	7e 3e                	jle    800552 <vprintfmt+0xe9>
  800514:	83 fb 39             	cmp    $0x39,%ebx
  800517:	7f 39                	jg     800552 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800519:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80051c:	eb d5                	jmp    8004f3 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80051e:	8b 45 14             	mov    0x14(%ebp),%eax
  800521:	83 c0 04             	add    $0x4,%eax
  800524:	89 45 14             	mov    %eax,0x14(%ebp)
  800527:	8b 45 14             	mov    0x14(%ebp),%eax
  80052a:	83 e8 04             	sub    $0x4,%eax
  80052d:	8b 00                	mov    (%eax),%eax
  80052f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800532:	eb 1f                	jmp    800553 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800534:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800538:	79 83                	jns    8004bd <vprintfmt+0x54>
				width = 0;
  80053a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800541:	e9 77 ff ff ff       	jmp    8004bd <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800546:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80054d:	e9 6b ff ff ff       	jmp    8004bd <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800552:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800553:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800557:	0f 89 60 ff ff ff    	jns    8004bd <vprintfmt+0x54>
				width = precision, precision = -1;
  80055d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800560:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800563:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80056a:	e9 4e ff ff ff       	jmp    8004bd <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80056f:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800572:	e9 46 ff ff ff       	jmp    8004bd <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800577:	8b 45 14             	mov    0x14(%ebp),%eax
  80057a:	83 c0 04             	add    $0x4,%eax
  80057d:	89 45 14             	mov    %eax,0x14(%ebp)
  800580:	8b 45 14             	mov    0x14(%ebp),%eax
  800583:	83 e8 04             	sub    $0x4,%eax
  800586:	8b 00                	mov    (%eax),%eax
  800588:	83 ec 08             	sub    $0x8,%esp
  80058b:	ff 75 0c             	pushl  0xc(%ebp)
  80058e:	50                   	push   %eax
  80058f:	8b 45 08             	mov    0x8(%ebp),%eax
  800592:	ff d0                	call   *%eax
  800594:	83 c4 10             	add    $0x10,%esp
			break;
  800597:	e9 89 02 00 00       	jmp    800825 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80059c:	8b 45 14             	mov    0x14(%ebp),%eax
  80059f:	83 c0 04             	add    $0x4,%eax
  8005a2:	89 45 14             	mov    %eax,0x14(%ebp)
  8005a5:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a8:	83 e8 04             	sub    $0x4,%eax
  8005ab:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005ad:	85 db                	test   %ebx,%ebx
  8005af:	79 02                	jns    8005b3 <vprintfmt+0x14a>
				err = -err;
  8005b1:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005b3:	83 fb 64             	cmp    $0x64,%ebx
  8005b6:	7f 0b                	jg     8005c3 <vprintfmt+0x15a>
  8005b8:	8b 34 9d 60 1a 80 00 	mov    0x801a60(,%ebx,4),%esi
  8005bf:	85 f6                	test   %esi,%esi
  8005c1:	75 19                	jne    8005dc <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005c3:	53                   	push   %ebx
  8005c4:	68 05 1c 80 00       	push   $0x801c05
  8005c9:	ff 75 0c             	pushl  0xc(%ebp)
  8005cc:	ff 75 08             	pushl  0x8(%ebp)
  8005cf:	e8 5e 02 00 00       	call   800832 <printfmt>
  8005d4:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005d7:	e9 49 02 00 00       	jmp    800825 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005dc:	56                   	push   %esi
  8005dd:	68 0e 1c 80 00       	push   $0x801c0e
  8005e2:	ff 75 0c             	pushl  0xc(%ebp)
  8005e5:	ff 75 08             	pushl  0x8(%ebp)
  8005e8:	e8 45 02 00 00       	call   800832 <printfmt>
  8005ed:	83 c4 10             	add    $0x10,%esp
			break;
  8005f0:	e9 30 02 00 00       	jmp    800825 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8005f8:	83 c0 04             	add    $0x4,%eax
  8005fb:	89 45 14             	mov    %eax,0x14(%ebp)
  8005fe:	8b 45 14             	mov    0x14(%ebp),%eax
  800601:	83 e8 04             	sub    $0x4,%eax
  800604:	8b 30                	mov    (%eax),%esi
  800606:	85 f6                	test   %esi,%esi
  800608:	75 05                	jne    80060f <vprintfmt+0x1a6>
				p = "(null)";
  80060a:	be 11 1c 80 00       	mov    $0x801c11,%esi
			if (width > 0 && padc != '-')
  80060f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800613:	7e 6d                	jle    800682 <vprintfmt+0x219>
  800615:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800619:	74 67                	je     800682 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80061b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80061e:	83 ec 08             	sub    $0x8,%esp
  800621:	50                   	push   %eax
  800622:	56                   	push   %esi
  800623:	e8 0c 03 00 00       	call   800934 <strnlen>
  800628:	83 c4 10             	add    $0x10,%esp
  80062b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80062e:	eb 16                	jmp    800646 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800630:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800634:	83 ec 08             	sub    $0x8,%esp
  800637:	ff 75 0c             	pushl  0xc(%ebp)
  80063a:	50                   	push   %eax
  80063b:	8b 45 08             	mov    0x8(%ebp),%eax
  80063e:	ff d0                	call   *%eax
  800640:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800643:	ff 4d e4             	decl   -0x1c(%ebp)
  800646:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80064a:	7f e4                	jg     800630 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80064c:	eb 34                	jmp    800682 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80064e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800652:	74 1c                	je     800670 <vprintfmt+0x207>
  800654:	83 fb 1f             	cmp    $0x1f,%ebx
  800657:	7e 05                	jle    80065e <vprintfmt+0x1f5>
  800659:	83 fb 7e             	cmp    $0x7e,%ebx
  80065c:	7e 12                	jle    800670 <vprintfmt+0x207>
					putch('?', putdat);
  80065e:	83 ec 08             	sub    $0x8,%esp
  800661:	ff 75 0c             	pushl  0xc(%ebp)
  800664:	6a 3f                	push   $0x3f
  800666:	8b 45 08             	mov    0x8(%ebp),%eax
  800669:	ff d0                	call   *%eax
  80066b:	83 c4 10             	add    $0x10,%esp
  80066e:	eb 0f                	jmp    80067f <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800670:	83 ec 08             	sub    $0x8,%esp
  800673:	ff 75 0c             	pushl  0xc(%ebp)
  800676:	53                   	push   %ebx
  800677:	8b 45 08             	mov    0x8(%ebp),%eax
  80067a:	ff d0                	call   *%eax
  80067c:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80067f:	ff 4d e4             	decl   -0x1c(%ebp)
  800682:	89 f0                	mov    %esi,%eax
  800684:	8d 70 01             	lea    0x1(%eax),%esi
  800687:	8a 00                	mov    (%eax),%al
  800689:	0f be d8             	movsbl %al,%ebx
  80068c:	85 db                	test   %ebx,%ebx
  80068e:	74 24                	je     8006b4 <vprintfmt+0x24b>
  800690:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800694:	78 b8                	js     80064e <vprintfmt+0x1e5>
  800696:	ff 4d e0             	decl   -0x20(%ebp)
  800699:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80069d:	79 af                	jns    80064e <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80069f:	eb 13                	jmp    8006b4 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006a1:	83 ec 08             	sub    $0x8,%esp
  8006a4:	ff 75 0c             	pushl  0xc(%ebp)
  8006a7:	6a 20                	push   $0x20
  8006a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ac:	ff d0                	call   *%eax
  8006ae:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006b1:	ff 4d e4             	decl   -0x1c(%ebp)
  8006b4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006b8:	7f e7                	jg     8006a1 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006ba:	e9 66 01 00 00       	jmp    800825 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006bf:	83 ec 08             	sub    $0x8,%esp
  8006c2:	ff 75 e8             	pushl  -0x18(%ebp)
  8006c5:	8d 45 14             	lea    0x14(%ebp),%eax
  8006c8:	50                   	push   %eax
  8006c9:	e8 3c fd ff ff       	call   80040a <getint>
  8006ce:	83 c4 10             	add    $0x10,%esp
  8006d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006d4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006dd:	85 d2                	test   %edx,%edx
  8006df:	79 23                	jns    800704 <vprintfmt+0x29b>
				putch('-', putdat);
  8006e1:	83 ec 08             	sub    $0x8,%esp
  8006e4:	ff 75 0c             	pushl  0xc(%ebp)
  8006e7:	6a 2d                	push   $0x2d
  8006e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ec:	ff d0                	call   *%eax
  8006ee:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006f7:	f7 d8                	neg    %eax
  8006f9:	83 d2 00             	adc    $0x0,%edx
  8006fc:	f7 da                	neg    %edx
  8006fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800701:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800704:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80070b:	e9 bc 00 00 00       	jmp    8007cc <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800710:	83 ec 08             	sub    $0x8,%esp
  800713:	ff 75 e8             	pushl  -0x18(%ebp)
  800716:	8d 45 14             	lea    0x14(%ebp),%eax
  800719:	50                   	push   %eax
  80071a:	e8 84 fc ff ff       	call   8003a3 <getuint>
  80071f:	83 c4 10             	add    $0x10,%esp
  800722:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800725:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800728:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80072f:	e9 98 00 00 00       	jmp    8007cc <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800734:	83 ec 08             	sub    $0x8,%esp
  800737:	ff 75 0c             	pushl  0xc(%ebp)
  80073a:	6a 58                	push   $0x58
  80073c:	8b 45 08             	mov    0x8(%ebp),%eax
  80073f:	ff d0                	call   *%eax
  800741:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800744:	83 ec 08             	sub    $0x8,%esp
  800747:	ff 75 0c             	pushl  0xc(%ebp)
  80074a:	6a 58                	push   $0x58
  80074c:	8b 45 08             	mov    0x8(%ebp),%eax
  80074f:	ff d0                	call   *%eax
  800751:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800754:	83 ec 08             	sub    $0x8,%esp
  800757:	ff 75 0c             	pushl  0xc(%ebp)
  80075a:	6a 58                	push   $0x58
  80075c:	8b 45 08             	mov    0x8(%ebp),%eax
  80075f:	ff d0                	call   *%eax
  800761:	83 c4 10             	add    $0x10,%esp
			break;
  800764:	e9 bc 00 00 00       	jmp    800825 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800769:	83 ec 08             	sub    $0x8,%esp
  80076c:	ff 75 0c             	pushl  0xc(%ebp)
  80076f:	6a 30                	push   $0x30
  800771:	8b 45 08             	mov    0x8(%ebp),%eax
  800774:	ff d0                	call   *%eax
  800776:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800779:	83 ec 08             	sub    $0x8,%esp
  80077c:	ff 75 0c             	pushl  0xc(%ebp)
  80077f:	6a 78                	push   $0x78
  800781:	8b 45 08             	mov    0x8(%ebp),%eax
  800784:	ff d0                	call   *%eax
  800786:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800789:	8b 45 14             	mov    0x14(%ebp),%eax
  80078c:	83 c0 04             	add    $0x4,%eax
  80078f:	89 45 14             	mov    %eax,0x14(%ebp)
  800792:	8b 45 14             	mov    0x14(%ebp),%eax
  800795:	83 e8 04             	sub    $0x4,%eax
  800798:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80079a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80079d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007a4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007ab:	eb 1f                	jmp    8007cc <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007ad:	83 ec 08             	sub    $0x8,%esp
  8007b0:	ff 75 e8             	pushl  -0x18(%ebp)
  8007b3:	8d 45 14             	lea    0x14(%ebp),%eax
  8007b6:	50                   	push   %eax
  8007b7:	e8 e7 fb ff ff       	call   8003a3 <getuint>
  8007bc:	83 c4 10             	add    $0x10,%esp
  8007bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007c2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007c5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007cc:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007d3:	83 ec 04             	sub    $0x4,%esp
  8007d6:	52                   	push   %edx
  8007d7:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007da:	50                   	push   %eax
  8007db:	ff 75 f4             	pushl  -0xc(%ebp)
  8007de:	ff 75 f0             	pushl  -0x10(%ebp)
  8007e1:	ff 75 0c             	pushl  0xc(%ebp)
  8007e4:	ff 75 08             	pushl  0x8(%ebp)
  8007e7:	e8 00 fb ff ff       	call   8002ec <printnum>
  8007ec:	83 c4 20             	add    $0x20,%esp
			break;
  8007ef:	eb 34                	jmp    800825 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007f1:	83 ec 08             	sub    $0x8,%esp
  8007f4:	ff 75 0c             	pushl  0xc(%ebp)
  8007f7:	53                   	push   %ebx
  8007f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fb:	ff d0                	call   *%eax
  8007fd:	83 c4 10             	add    $0x10,%esp
			break;
  800800:	eb 23                	jmp    800825 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800802:	83 ec 08             	sub    $0x8,%esp
  800805:	ff 75 0c             	pushl  0xc(%ebp)
  800808:	6a 25                	push   $0x25
  80080a:	8b 45 08             	mov    0x8(%ebp),%eax
  80080d:	ff d0                	call   *%eax
  80080f:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800812:	ff 4d 10             	decl   0x10(%ebp)
  800815:	eb 03                	jmp    80081a <vprintfmt+0x3b1>
  800817:	ff 4d 10             	decl   0x10(%ebp)
  80081a:	8b 45 10             	mov    0x10(%ebp),%eax
  80081d:	48                   	dec    %eax
  80081e:	8a 00                	mov    (%eax),%al
  800820:	3c 25                	cmp    $0x25,%al
  800822:	75 f3                	jne    800817 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800824:	90                   	nop
		}
	}
  800825:	e9 47 fc ff ff       	jmp    800471 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80082a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80082b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80082e:	5b                   	pop    %ebx
  80082f:	5e                   	pop    %esi
  800830:	5d                   	pop    %ebp
  800831:	c3                   	ret    

00800832 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800832:	55                   	push   %ebp
  800833:	89 e5                	mov    %esp,%ebp
  800835:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800838:	8d 45 10             	lea    0x10(%ebp),%eax
  80083b:	83 c0 04             	add    $0x4,%eax
  80083e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800841:	8b 45 10             	mov    0x10(%ebp),%eax
  800844:	ff 75 f4             	pushl  -0xc(%ebp)
  800847:	50                   	push   %eax
  800848:	ff 75 0c             	pushl  0xc(%ebp)
  80084b:	ff 75 08             	pushl  0x8(%ebp)
  80084e:	e8 16 fc ff ff       	call   800469 <vprintfmt>
  800853:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800856:	90                   	nop
  800857:	c9                   	leave  
  800858:	c3                   	ret    

00800859 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800859:	55                   	push   %ebp
  80085a:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80085c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80085f:	8b 40 08             	mov    0x8(%eax),%eax
  800862:	8d 50 01             	lea    0x1(%eax),%edx
  800865:	8b 45 0c             	mov    0xc(%ebp),%eax
  800868:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80086b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80086e:	8b 10                	mov    (%eax),%edx
  800870:	8b 45 0c             	mov    0xc(%ebp),%eax
  800873:	8b 40 04             	mov    0x4(%eax),%eax
  800876:	39 c2                	cmp    %eax,%edx
  800878:	73 12                	jae    80088c <sprintputch+0x33>
		*b->buf++ = ch;
  80087a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80087d:	8b 00                	mov    (%eax),%eax
  80087f:	8d 48 01             	lea    0x1(%eax),%ecx
  800882:	8b 55 0c             	mov    0xc(%ebp),%edx
  800885:	89 0a                	mov    %ecx,(%edx)
  800887:	8b 55 08             	mov    0x8(%ebp),%edx
  80088a:	88 10                	mov    %dl,(%eax)
}
  80088c:	90                   	nop
  80088d:	5d                   	pop    %ebp
  80088e:	c3                   	ret    

0080088f <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80088f:	55                   	push   %ebp
  800890:	89 e5                	mov    %esp,%ebp
  800892:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800895:	8b 45 08             	mov    0x8(%ebp),%eax
  800898:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80089b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089e:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a4:	01 d0                	add    %edx,%eax
  8008a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008a9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008b0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008b4:	74 06                	je     8008bc <vsnprintf+0x2d>
  8008b6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008ba:	7f 07                	jg     8008c3 <vsnprintf+0x34>
		return -E_INVAL;
  8008bc:	b8 03 00 00 00       	mov    $0x3,%eax
  8008c1:	eb 20                	jmp    8008e3 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008c3:	ff 75 14             	pushl  0x14(%ebp)
  8008c6:	ff 75 10             	pushl  0x10(%ebp)
  8008c9:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008cc:	50                   	push   %eax
  8008cd:	68 59 08 80 00       	push   $0x800859
  8008d2:	e8 92 fb ff ff       	call   800469 <vprintfmt>
  8008d7:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008da:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008dd:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008e3:	c9                   	leave  
  8008e4:	c3                   	ret    

008008e5 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008e5:	55                   	push   %ebp
  8008e6:	89 e5                	mov    %esp,%ebp
  8008e8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008eb:	8d 45 10             	lea    0x10(%ebp),%eax
  8008ee:	83 c0 04             	add    $0x4,%eax
  8008f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8008f7:	ff 75 f4             	pushl  -0xc(%ebp)
  8008fa:	50                   	push   %eax
  8008fb:	ff 75 0c             	pushl  0xc(%ebp)
  8008fe:	ff 75 08             	pushl  0x8(%ebp)
  800901:	e8 89 ff ff ff       	call   80088f <vsnprintf>
  800906:	83 c4 10             	add    $0x10,%esp
  800909:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80090c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80090f:	c9                   	leave  
  800910:	c3                   	ret    

00800911 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800911:	55                   	push   %ebp
  800912:	89 e5                	mov    %esp,%ebp
  800914:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800917:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80091e:	eb 06                	jmp    800926 <strlen+0x15>
		n++;
  800920:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800923:	ff 45 08             	incl   0x8(%ebp)
  800926:	8b 45 08             	mov    0x8(%ebp),%eax
  800929:	8a 00                	mov    (%eax),%al
  80092b:	84 c0                	test   %al,%al
  80092d:	75 f1                	jne    800920 <strlen+0xf>
		n++;
	return n;
  80092f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800932:	c9                   	leave  
  800933:	c3                   	ret    

00800934 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800934:	55                   	push   %ebp
  800935:	89 e5                	mov    %esp,%ebp
  800937:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80093a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800941:	eb 09                	jmp    80094c <strnlen+0x18>
		n++;
  800943:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800946:	ff 45 08             	incl   0x8(%ebp)
  800949:	ff 4d 0c             	decl   0xc(%ebp)
  80094c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800950:	74 09                	je     80095b <strnlen+0x27>
  800952:	8b 45 08             	mov    0x8(%ebp),%eax
  800955:	8a 00                	mov    (%eax),%al
  800957:	84 c0                	test   %al,%al
  800959:	75 e8                	jne    800943 <strnlen+0xf>
		n++;
	return n;
  80095b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80095e:	c9                   	leave  
  80095f:	c3                   	ret    

00800960 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800960:	55                   	push   %ebp
  800961:	89 e5                	mov    %esp,%ebp
  800963:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800966:	8b 45 08             	mov    0x8(%ebp),%eax
  800969:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80096c:	90                   	nop
  80096d:	8b 45 08             	mov    0x8(%ebp),%eax
  800970:	8d 50 01             	lea    0x1(%eax),%edx
  800973:	89 55 08             	mov    %edx,0x8(%ebp)
  800976:	8b 55 0c             	mov    0xc(%ebp),%edx
  800979:	8d 4a 01             	lea    0x1(%edx),%ecx
  80097c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80097f:	8a 12                	mov    (%edx),%dl
  800981:	88 10                	mov    %dl,(%eax)
  800983:	8a 00                	mov    (%eax),%al
  800985:	84 c0                	test   %al,%al
  800987:	75 e4                	jne    80096d <strcpy+0xd>
		/* do nothing */;
	return ret;
  800989:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80098c:	c9                   	leave  
  80098d:	c3                   	ret    

0080098e <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80098e:	55                   	push   %ebp
  80098f:	89 e5                	mov    %esp,%ebp
  800991:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800994:	8b 45 08             	mov    0x8(%ebp),%eax
  800997:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80099a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009a1:	eb 1f                	jmp    8009c2 <strncpy+0x34>
		*dst++ = *src;
  8009a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a6:	8d 50 01             	lea    0x1(%eax),%edx
  8009a9:	89 55 08             	mov    %edx,0x8(%ebp)
  8009ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009af:	8a 12                	mov    (%edx),%dl
  8009b1:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b6:	8a 00                	mov    (%eax),%al
  8009b8:	84 c0                	test   %al,%al
  8009ba:	74 03                	je     8009bf <strncpy+0x31>
			src++;
  8009bc:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009bf:	ff 45 fc             	incl   -0x4(%ebp)
  8009c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009c5:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009c8:	72 d9                	jb     8009a3 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009cd:	c9                   	leave  
  8009ce:	c3                   	ret    

008009cf <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009cf:	55                   	push   %ebp
  8009d0:	89 e5                	mov    %esp,%ebp
  8009d2:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009db:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009df:	74 30                	je     800a11 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009e1:	eb 16                	jmp    8009f9 <strlcpy+0x2a>
			*dst++ = *src++;
  8009e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e6:	8d 50 01             	lea    0x1(%eax),%edx
  8009e9:	89 55 08             	mov    %edx,0x8(%ebp)
  8009ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009ef:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009f2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009f5:	8a 12                	mov    (%edx),%dl
  8009f7:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009f9:	ff 4d 10             	decl   0x10(%ebp)
  8009fc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a00:	74 09                	je     800a0b <strlcpy+0x3c>
  800a02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a05:	8a 00                	mov    (%eax),%al
  800a07:	84 c0                	test   %al,%al
  800a09:	75 d8                	jne    8009e3 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a11:	8b 55 08             	mov    0x8(%ebp),%edx
  800a14:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a17:	29 c2                	sub    %eax,%edx
  800a19:	89 d0                	mov    %edx,%eax
}
  800a1b:	c9                   	leave  
  800a1c:	c3                   	ret    

00800a1d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a1d:	55                   	push   %ebp
  800a1e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a20:	eb 06                	jmp    800a28 <strcmp+0xb>
		p++, q++;
  800a22:	ff 45 08             	incl   0x8(%ebp)
  800a25:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a28:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2b:	8a 00                	mov    (%eax),%al
  800a2d:	84 c0                	test   %al,%al
  800a2f:	74 0e                	je     800a3f <strcmp+0x22>
  800a31:	8b 45 08             	mov    0x8(%ebp),%eax
  800a34:	8a 10                	mov    (%eax),%dl
  800a36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a39:	8a 00                	mov    (%eax),%al
  800a3b:	38 c2                	cmp    %al,%dl
  800a3d:	74 e3                	je     800a22 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a42:	8a 00                	mov    (%eax),%al
  800a44:	0f b6 d0             	movzbl %al,%edx
  800a47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4a:	8a 00                	mov    (%eax),%al
  800a4c:	0f b6 c0             	movzbl %al,%eax
  800a4f:	29 c2                	sub    %eax,%edx
  800a51:	89 d0                	mov    %edx,%eax
}
  800a53:	5d                   	pop    %ebp
  800a54:	c3                   	ret    

00800a55 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a55:	55                   	push   %ebp
  800a56:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a58:	eb 09                	jmp    800a63 <strncmp+0xe>
		n--, p++, q++;
  800a5a:	ff 4d 10             	decl   0x10(%ebp)
  800a5d:	ff 45 08             	incl   0x8(%ebp)
  800a60:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a63:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a67:	74 17                	je     800a80 <strncmp+0x2b>
  800a69:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6c:	8a 00                	mov    (%eax),%al
  800a6e:	84 c0                	test   %al,%al
  800a70:	74 0e                	je     800a80 <strncmp+0x2b>
  800a72:	8b 45 08             	mov    0x8(%ebp),%eax
  800a75:	8a 10                	mov    (%eax),%dl
  800a77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a7a:	8a 00                	mov    (%eax),%al
  800a7c:	38 c2                	cmp    %al,%dl
  800a7e:	74 da                	je     800a5a <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a80:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a84:	75 07                	jne    800a8d <strncmp+0x38>
		return 0;
  800a86:	b8 00 00 00 00       	mov    $0x0,%eax
  800a8b:	eb 14                	jmp    800aa1 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a90:	8a 00                	mov    (%eax),%al
  800a92:	0f b6 d0             	movzbl %al,%edx
  800a95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a98:	8a 00                	mov    (%eax),%al
  800a9a:	0f b6 c0             	movzbl %al,%eax
  800a9d:	29 c2                	sub    %eax,%edx
  800a9f:	89 d0                	mov    %edx,%eax
}
  800aa1:	5d                   	pop    %ebp
  800aa2:	c3                   	ret    

00800aa3 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800aa3:	55                   	push   %ebp
  800aa4:	89 e5                	mov    %esp,%ebp
  800aa6:	83 ec 04             	sub    $0x4,%esp
  800aa9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aac:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800aaf:	eb 12                	jmp    800ac3 <strchr+0x20>
		if (*s == c)
  800ab1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab4:	8a 00                	mov    (%eax),%al
  800ab6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ab9:	75 05                	jne    800ac0 <strchr+0x1d>
			return (char *) s;
  800abb:	8b 45 08             	mov    0x8(%ebp),%eax
  800abe:	eb 11                	jmp    800ad1 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ac0:	ff 45 08             	incl   0x8(%ebp)
  800ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac6:	8a 00                	mov    (%eax),%al
  800ac8:	84 c0                	test   %al,%al
  800aca:	75 e5                	jne    800ab1 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800acc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ad1:	c9                   	leave  
  800ad2:	c3                   	ret    

00800ad3 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ad3:	55                   	push   %ebp
  800ad4:	89 e5                	mov    %esp,%ebp
  800ad6:	83 ec 04             	sub    $0x4,%esp
  800ad9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800adc:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800adf:	eb 0d                	jmp    800aee <strfind+0x1b>
		if (*s == c)
  800ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae4:	8a 00                	mov    (%eax),%al
  800ae6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ae9:	74 0e                	je     800af9 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800aeb:	ff 45 08             	incl   0x8(%ebp)
  800aee:	8b 45 08             	mov    0x8(%ebp),%eax
  800af1:	8a 00                	mov    (%eax),%al
  800af3:	84 c0                	test   %al,%al
  800af5:	75 ea                	jne    800ae1 <strfind+0xe>
  800af7:	eb 01                	jmp    800afa <strfind+0x27>
		if (*s == c)
			break;
  800af9:	90                   	nop
	return (char *) s;
  800afa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800afd:	c9                   	leave  
  800afe:	c3                   	ret    

00800aff <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800aff:	55                   	push   %ebp
  800b00:	89 e5                	mov    %esp,%ebp
  800b02:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b05:	8b 45 08             	mov    0x8(%ebp),%eax
  800b08:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b0b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b0e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b11:	eb 0e                	jmp    800b21 <memset+0x22>
		*p++ = c;
  800b13:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b16:	8d 50 01             	lea    0x1(%eax),%edx
  800b19:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b1c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b1f:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b21:	ff 4d f8             	decl   -0x8(%ebp)
  800b24:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b28:	79 e9                	jns    800b13 <memset+0x14>
		*p++ = c;

	return v;
  800b2a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b2d:	c9                   	leave  
  800b2e:	c3                   	ret    

00800b2f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b2f:	55                   	push   %ebp
  800b30:	89 e5                	mov    %esp,%ebp
  800b32:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b38:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b41:	eb 16                	jmp    800b59 <memcpy+0x2a>
		*d++ = *s++;
  800b43:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b46:	8d 50 01             	lea    0x1(%eax),%edx
  800b49:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b4c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b4f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b52:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b55:	8a 12                	mov    (%edx),%dl
  800b57:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b59:	8b 45 10             	mov    0x10(%ebp),%eax
  800b5c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b5f:	89 55 10             	mov    %edx,0x10(%ebp)
  800b62:	85 c0                	test   %eax,%eax
  800b64:	75 dd                	jne    800b43 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b66:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b69:	c9                   	leave  
  800b6a:	c3                   	ret    

00800b6b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b6b:	55                   	push   %ebp
  800b6c:	89 e5                	mov    %esp,%ebp
  800b6e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b74:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b77:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b80:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b83:	73 50                	jae    800bd5 <memmove+0x6a>
  800b85:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b88:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8b:	01 d0                	add    %edx,%eax
  800b8d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b90:	76 43                	jbe    800bd5 <memmove+0x6a>
		s += n;
  800b92:	8b 45 10             	mov    0x10(%ebp),%eax
  800b95:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b98:	8b 45 10             	mov    0x10(%ebp),%eax
  800b9b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b9e:	eb 10                	jmp    800bb0 <memmove+0x45>
			*--d = *--s;
  800ba0:	ff 4d f8             	decl   -0x8(%ebp)
  800ba3:	ff 4d fc             	decl   -0x4(%ebp)
  800ba6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ba9:	8a 10                	mov    (%eax),%dl
  800bab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bae:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bb0:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bb6:	89 55 10             	mov    %edx,0x10(%ebp)
  800bb9:	85 c0                	test   %eax,%eax
  800bbb:	75 e3                	jne    800ba0 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bbd:	eb 23                	jmp    800be2 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bbf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bc2:	8d 50 01             	lea    0x1(%eax),%edx
  800bc5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bc8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bcb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bce:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bd1:	8a 12                	mov    (%edx),%dl
  800bd3:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bd5:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bdb:	89 55 10             	mov    %edx,0x10(%ebp)
  800bde:	85 c0                	test   %eax,%eax
  800be0:	75 dd                	jne    800bbf <memmove+0x54>
			*d++ = *s++;

	return dst;
  800be2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800be5:	c9                   	leave  
  800be6:	c3                   	ret    

00800be7 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800be7:	55                   	push   %ebp
  800be8:	89 e5                	mov    %esp,%ebp
  800bea:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bed:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bf3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf6:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bf9:	eb 2a                	jmp    800c25 <memcmp+0x3e>
		if (*s1 != *s2)
  800bfb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bfe:	8a 10                	mov    (%eax),%dl
  800c00:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c03:	8a 00                	mov    (%eax),%al
  800c05:	38 c2                	cmp    %al,%dl
  800c07:	74 16                	je     800c1f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c09:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c0c:	8a 00                	mov    (%eax),%al
  800c0e:	0f b6 d0             	movzbl %al,%edx
  800c11:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c14:	8a 00                	mov    (%eax),%al
  800c16:	0f b6 c0             	movzbl %al,%eax
  800c19:	29 c2                	sub    %eax,%edx
  800c1b:	89 d0                	mov    %edx,%eax
  800c1d:	eb 18                	jmp    800c37 <memcmp+0x50>
		s1++, s2++;
  800c1f:	ff 45 fc             	incl   -0x4(%ebp)
  800c22:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c25:	8b 45 10             	mov    0x10(%ebp),%eax
  800c28:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c2b:	89 55 10             	mov    %edx,0x10(%ebp)
  800c2e:	85 c0                	test   %eax,%eax
  800c30:	75 c9                	jne    800bfb <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c32:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c37:	c9                   	leave  
  800c38:	c3                   	ret    

00800c39 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c39:	55                   	push   %ebp
  800c3a:	89 e5                	mov    %esp,%ebp
  800c3c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c3f:	8b 55 08             	mov    0x8(%ebp),%edx
  800c42:	8b 45 10             	mov    0x10(%ebp),%eax
  800c45:	01 d0                	add    %edx,%eax
  800c47:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c4a:	eb 15                	jmp    800c61 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4f:	8a 00                	mov    (%eax),%al
  800c51:	0f b6 d0             	movzbl %al,%edx
  800c54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c57:	0f b6 c0             	movzbl %al,%eax
  800c5a:	39 c2                	cmp    %eax,%edx
  800c5c:	74 0d                	je     800c6b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c5e:	ff 45 08             	incl   0x8(%ebp)
  800c61:	8b 45 08             	mov    0x8(%ebp),%eax
  800c64:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c67:	72 e3                	jb     800c4c <memfind+0x13>
  800c69:	eb 01                	jmp    800c6c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c6b:	90                   	nop
	return (void *) s;
  800c6c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c6f:	c9                   	leave  
  800c70:	c3                   	ret    

00800c71 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c71:	55                   	push   %ebp
  800c72:	89 e5                	mov    %esp,%ebp
  800c74:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c77:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c7e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c85:	eb 03                	jmp    800c8a <strtol+0x19>
		s++;
  800c87:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8d:	8a 00                	mov    (%eax),%al
  800c8f:	3c 20                	cmp    $0x20,%al
  800c91:	74 f4                	je     800c87 <strtol+0x16>
  800c93:	8b 45 08             	mov    0x8(%ebp),%eax
  800c96:	8a 00                	mov    (%eax),%al
  800c98:	3c 09                	cmp    $0x9,%al
  800c9a:	74 eb                	je     800c87 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9f:	8a 00                	mov    (%eax),%al
  800ca1:	3c 2b                	cmp    $0x2b,%al
  800ca3:	75 05                	jne    800caa <strtol+0x39>
		s++;
  800ca5:	ff 45 08             	incl   0x8(%ebp)
  800ca8:	eb 13                	jmp    800cbd <strtol+0x4c>
	else if (*s == '-')
  800caa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cad:	8a 00                	mov    (%eax),%al
  800caf:	3c 2d                	cmp    $0x2d,%al
  800cb1:	75 0a                	jne    800cbd <strtol+0x4c>
		s++, neg = 1;
  800cb3:	ff 45 08             	incl   0x8(%ebp)
  800cb6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cbd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc1:	74 06                	je     800cc9 <strtol+0x58>
  800cc3:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cc7:	75 20                	jne    800ce9 <strtol+0x78>
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	8a 00                	mov    (%eax),%al
  800cce:	3c 30                	cmp    $0x30,%al
  800cd0:	75 17                	jne    800ce9 <strtol+0x78>
  800cd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd5:	40                   	inc    %eax
  800cd6:	8a 00                	mov    (%eax),%al
  800cd8:	3c 78                	cmp    $0x78,%al
  800cda:	75 0d                	jne    800ce9 <strtol+0x78>
		s += 2, base = 16;
  800cdc:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800ce0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ce7:	eb 28                	jmp    800d11 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ce9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ced:	75 15                	jne    800d04 <strtol+0x93>
  800cef:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf2:	8a 00                	mov    (%eax),%al
  800cf4:	3c 30                	cmp    $0x30,%al
  800cf6:	75 0c                	jne    800d04 <strtol+0x93>
		s++, base = 8;
  800cf8:	ff 45 08             	incl   0x8(%ebp)
  800cfb:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d02:	eb 0d                	jmp    800d11 <strtol+0xa0>
	else if (base == 0)
  800d04:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d08:	75 07                	jne    800d11 <strtol+0xa0>
		base = 10;
  800d0a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
  800d14:	8a 00                	mov    (%eax),%al
  800d16:	3c 2f                	cmp    $0x2f,%al
  800d18:	7e 19                	jle    800d33 <strtol+0xc2>
  800d1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1d:	8a 00                	mov    (%eax),%al
  800d1f:	3c 39                	cmp    $0x39,%al
  800d21:	7f 10                	jg     800d33 <strtol+0xc2>
			dig = *s - '0';
  800d23:	8b 45 08             	mov    0x8(%ebp),%eax
  800d26:	8a 00                	mov    (%eax),%al
  800d28:	0f be c0             	movsbl %al,%eax
  800d2b:	83 e8 30             	sub    $0x30,%eax
  800d2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d31:	eb 42                	jmp    800d75 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d33:	8b 45 08             	mov    0x8(%ebp),%eax
  800d36:	8a 00                	mov    (%eax),%al
  800d38:	3c 60                	cmp    $0x60,%al
  800d3a:	7e 19                	jle    800d55 <strtol+0xe4>
  800d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3f:	8a 00                	mov    (%eax),%al
  800d41:	3c 7a                	cmp    $0x7a,%al
  800d43:	7f 10                	jg     800d55 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
  800d48:	8a 00                	mov    (%eax),%al
  800d4a:	0f be c0             	movsbl %al,%eax
  800d4d:	83 e8 57             	sub    $0x57,%eax
  800d50:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d53:	eb 20                	jmp    800d75 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
  800d58:	8a 00                	mov    (%eax),%al
  800d5a:	3c 40                	cmp    $0x40,%al
  800d5c:	7e 39                	jle    800d97 <strtol+0x126>
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d61:	8a 00                	mov    (%eax),%al
  800d63:	3c 5a                	cmp    $0x5a,%al
  800d65:	7f 30                	jg     800d97 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d67:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6a:	8a 00                	mov    (%eax),%al
  800d6c:	0f be c0             	movsbl %al,%eax
  800d6f:	83 e8 37             	sub    $0x37,%eax
  800d72:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d75:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d78:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d7b:	7d 19                	jge    800d96 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d7d:	ff 45 08             	incl   0x8(%ebp)
  800d80:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d83:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d87:	89 c2                	mov    %eax,%edx
  800d89:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d8c:	01 d0                	add    %edx,%eax
  800d8e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d91:	e9 7b ff ff ff       	jmp    800d11 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d96:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d97:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d9b:	74 08                	je     800da5 <strtol+0x134>
		*endptr = (char *) s;
  800d9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da0:	8b 55 08             	mov    0x8(%ebp),%edx
  800da3:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800da5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800da9:	74 07                	je     800db2 <strtol+0x141>
  800dab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dae:	f7 d8                	neg    %eax
  800db0:	eb 03                	jmp    800db5 <strtol+0x144>
  800db2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800db5:	c9                   	leave  
  800db6:	c3                   	ret    

00800db7 <ltostr>:

void
ltostr(long value, char *str)
{
  800db7:	55                   	push   %ebp
  800db8:	89 e5                	mov    %esp,%ebp
  800dba:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dbd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800dc4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800dcb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dcf:	79 13                	jns    800de4 <ltostr+0x2d>
	{
		neg = 1;
  800dd1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800dd8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ddb:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800dde:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800de1:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800de4:	8b 45 08             	mov    0x8(%ebp),%eax
  800de7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800dec:	99                   	cltd   
  800ded:	f7 f9                	idiv   %ecx
  800def:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800df2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df5:	8d 50 01             	lea    0x1(%eax),%edx
  800df8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dfb:	89 c2                	mov    %eax,%edx
  800dfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e00:	01 d0                	add    %edx,%eax
  800e02:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e05:	83 c2 30             	add    $0x30,%edx
  800e08:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e0a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e0d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e12:	f7 e9                	imul   %ecx
  800e14:	c1 fa 02             	sar    $0x2,%edx
  800e17:	89 c8                	mov    %ecx,%eax
  800e19:	c1 f8 1f             	sar    $0x1f,%eax
  800e1c:	29 c2                	sub    %eax,%edx
  800e1e:	89 d0                	mov    %edx,%eax
  800e20:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e23:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e26:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e2b:	f7 e9                	imul   %ecx
  800e2d:	c1 fa 02             	sar    $0x2,%edx
  800e30:	89 c8                	mov    %ecx,%eax
  800e32:	c1 f8 1f             	sar    $0x1f,%eax
  800e35:	29 c2                	sub    %eax,%edx
  800e37:	89 d0                	mov    %edx,%eax
  800e39:	c1 e0 02             	shl    $0x2,%eax
  800e3c:	01 d0                	add    %edx,%eax
  800e3e:	01 c0                	add    %eax,%eax
  800e40:	29 c1                	sub    %eax,%ecx
  800e42:	89 ca                	mov    %ecx,%edx
  800e44:	85 d2                	test   %edx,%edx
  800e46:	75 9c                	jne    800de4 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e48:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e4f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e52:	48                   	dec    %eax
  800e53:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e56:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e5a:	74 3d                	je     800e99 <ltostr+0xe2>
		start = 1 ;
  800e5c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e63:	eb 34                	jmp    800e99 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e65:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6b:	01 d0                	add    %edx,%eax
  800e6d:	8a 00                	mov    (%eax),%al
  800e6f:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e72:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e78:	01 c2                	add    %eax,%edx
  800e7a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e80:	01 c8                	add    %ecx,%eax
  800e82:	8a 00                	mov    (%eax),%al
  800e84:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e86:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8c:	01 c2                	add    %eax,%edx
  800e8e:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e91:	88 02                	mov    %al,(%edx)
		start++ ;
  800e93:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e96:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e99:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e9c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e9f:	7c c4                	jl     800e65 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800ea1:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ea4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea7:	01 d0                	add    %edx,%eax
  800ea9:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800eac:	90                   	nop
  800ead:	c9                   	leave  
  800eae:	c3                   	ret    

00800eaf <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800eaf:	55                   	push   %ebp
  800eb0:	89 e5                	mov    %esp,%ebp
  800eb2:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800eb5:	ff 75 08             	pushl  0x8(%ebp)
  800eb8:	e8 54 fa ff ff       	call   800911 <strlen>
  800ebd:	83 c4 04             	add    $0x4,%esp
  800ec0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800ec3:	ff 75 0c             	pushl  0xc(%ebp)
  800ec6:	e8 46 fa ff ff       	call   800911 <strlen>
  800ecb:	83 c4 04             	add    $0x4,%esp
  800ece:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ed1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ed8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800edf:	eb 17                	jmp    800ef8 <strcconcat+0x49>
		final[s] = str1[s] ;
  800ee1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ee4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee7:	01 c2                	add    %eax,%edx
  800ee9:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800eec:	8b 45 08             	mov    0x8(%ebp),%eax
  800eef:	01 c8                	add    %ecx,%eax
  800ef1:	8a 00                	mov    (%eax),%al
  800ef3:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800ef5:	ff 45 fc             	incl   -0x4(%ebp)
  800ef8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800efb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800efe:	7c e1                	jl     800ee1 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f00:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f07:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f0e:	eb 1f                	jmp    800f2f <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f10:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f13:	8d 50 01             	lea    0x1(%eax),%edx
  800f16:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f19:	89 c2                	mov    %eax,%edx
  800f1b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1e:	01 c2                	add    %eax,%edx
  800f20:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f26:	01 c8                	add    %ecx,%eax
  800f28:	8a 00                	mov    (%eax),%al
  800f2a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f2c:	ff 45 f8             	incl   -0x8(%ebp)
  800f2f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f32:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f35:	7c d9                	jl     800f10 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f37:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f3a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3d:	01 d0                	add    %edx,%eax
  800f3f:	c6 00 00             	movb   $0x0,(%eax)
}
  800f42:	90                   	nop
  800f43:	c9                   	leave  
  800f44:	c3                   	ret    

00800f45 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f45:	55                   	push   %ebp
  800f46:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f48:	8b 45 14             	mov    0x14(%ebp),%eax
  800f4b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f51:	8b 45 14             	mov    0x14(%ebp),%eax
  800f54:	8b 00                	mov    (%eax),%eax
  800f56:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f5d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f60:	01 d0                	add    %edx,%eax
  800f62:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f68:	eb 0c                	jmp    800f76 <strsplit+0x31>
			*string++ = 0;
  800f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6d:	8d 50 01             	lea    0x1(%eax),%edx
  800f70:	89 55 08             	mov    %edx,0x8(%ebp)
  800f73:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f76:	8b 45 08             	mov    0x8(%ebp),%eax
  800f79:	8a 00                	mov    (%eax),%al
  800f7b:	84 c0                	test   %al,%al
  800f7d:	74 18                	je     800f97 <strsplit+0x52>
  800f7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f82:	8a 00                	mov    (%eax),%al
  800f84:	0f be c0             	movsbl %al,%eax
  800f87:	50                   	push   %eax
  800f88:	ff 75 0c             	pushl  0xc(%ebp)
  800f8b:	e8 13 fb ff ff       	call   800aa3 <strchr>
  800f90:	83 c4 08             	add    $0x8,%esp
  800f93:	85 c0                	test   %eax,%eax
  800f95:	75 d3                	jne    800f6a <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800f97:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9a:	8a 00                	mov    (%eax),%al
  800f9c:	84 c0                	test   %al,%al
  800f9e:	74 5a                	je     800ffa <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800fa0:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa3:	8b 00                	mov    (%eax),%eax
  800fa5:	83 f8 0f             	cmp    $0xf,%eax
  800fa8:	75 07                	jne    800fb1 <strsplit+0x6c>
		{
			return 0;
  800faa:	b8 00 00 00 00       	mov    $0x0,%eax
  800faf:	eb 66                	jmp    801017 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fb1:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb4:	8b 00                	mov    (%eax),%eax
  800fb6:	8d 48 01             	lea    0x1(%eax),%ecx
  800fb9:	8b 55 14             	mov    0x14(%ebp),%edx
  800fbc:	89 0a                	mov    %ecx,(%edx)
  800fbe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fc5:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc8:	01 c2                	add    %eax,%edx
  800fca:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcd:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fcf:	eb 03                	jmp    800fd4 <strsplit+0x8f>
			string++;
  800fd1:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd7:	8a 00                	mov    (%eax),%al
  800fd9:	84 c0                	test   %al,%al
  800fdb:	74 8b                	je     800f68 <strsplit+0x23>
  800fdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe0:	8a 00                	mov    (%eax),%al
  800fe2:	0f be c0             	movsbl %al,%eax
  800fe5:	50                   	push   %eax
  800fe6:	ff 75 0c             	pushl  0xc(%ebp)
  800fe9:	e8 b5 fa ff ff       	call   800aa3 <strchr>
  800fee:	83 c4 08             	add    $0x8,%esp
  800ff1:	85 c0                	test   %eax,%eax
  800ff3:	74 dc                	je     800fd1 <strsplit+0x8c>
			string++;
	}
  800ff5:	e9 6e ff ff ff       	jmp    800f68 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800ffa:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800ffb:	8b 45 14             	mov    0x14(%ebp),%eax
  800ffe:	8b 00                	mov    (%eax),%eax
  801000:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801007:	8b 45 10             	mov    0x10(%ebp),%eax
  80100a:	01 d0                	add    %edx,%eax
  80100c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801012:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801017:	c9                   	leave  
  801018:	c3                   	ret    

00801019 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801019:	55                   	push   %ebp
  80101a:	89 e5                	mov    %esp,%ebp
  80101c:	57                   	push   %edi
  80101d:	56                   	push   %esi
  80101e:	53                   	push   %ebx
  80101f:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801022:	8b 45 08             	mov    0x8(%ebp),%eax
  801025:	8b 55 0c             	mov    0xc(%ebp),%edx
  801028:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80102b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80102e:	8b 7d 18             	mov    0x18(%ebp),%edi
  801031:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801034:	cd 30                	int    $0x30
  801036:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801039:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80103c:	83 c4 10             	add    $0x10,%esp
  80103f:	5b                   	pop    %ebx
  801040:	5e                   	pop    %esi
  801041:	5f                   	pop    %edi
  801042:	5d                   	pop    %ebp
  801043:	c3                   	ret    

00801044 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801044:	55                   	push   %ebp
  801045:	89 e5                	mov    %esp,%ebp
  801047:	83 ec 04             	sub    $0x4,%esp
  80104a:	8b 45 10             	mov    0x10(%ebp),%eax
  80104d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801050:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801054:	8b 45 08             	mov    0x8(%ebp),%eax
  801057:	6a 00                	push   $0x0
  801059:	6a 00                	push   $0x0
  80105b:	52                   	push   %edx
  80105c:	ff 75 0c             	pushl  0xc(%ebp)
  80105f:	50                   	push   %eax
  801060:	6a 00                	push   $0x0
  801062:	e8 b2 ff ff ff       	call   801019 <syscall>
  801067:	83 c4 18             	add    $0x18,%esp
}
  80106a:	90                   	nop
  80106b:	c9                   	leave  
  80106c:	c3                   	ret    

0080106d <sys_cgetc>:

int
sys_cgetc(void)
{
  80106d:	55                   	push   %ebp
  80106e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801070:	6a 00                	push   $0x0
  801072:	6a 00                	push   $0x0
  801074:	6a 00                	push   $0x0
  801076:	6a 00                	push   $0x0
  801078:	6a 00                	push   $0x0
  80107a:	6a 01                	push   $0x1
  80107c:	e8 98 ff ff ff       	call   801019 <syscall>
  801081:	83 c4 18             	add    $0x18,%esp
}
  801084:	c9                   	leave  
  801085:	c3                   	ret    

00801086 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801086:	55                   	push   %ebp
  801087:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801089:	8b 45 08             	mov    0x8(%ebp),%eax
  80108c:	6a 00                	push   $0x0
  80108e:	6a 00                	push   $0x0
  801090:	6a 00                	push   $0x0
  801092:	6a 00                	push   $0x0
  801094:	50                   	push   %eax
  801095:	6a 05                	push   $0x5
  801097:	e8 7d ff ff ff       	call   801019 <syscall>
  80109c:	83 c4 18             	add    $0x18,%esp
}
  80109f:	c9                   	leave  
  8010a0:	c3                   	ret    

008010a1 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010a1:	55                   	push   %ebp
  8010a2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010a4:	6a 00                	push   $0x0
  8010a6:	6a 00                	push   $0x0
  8010a8:	6a 00                	push   $0x0
  8010aa:	6a 00                	push   $0x0
  8010ac:	6a 00                	push   $0x0
  8010ae:	6a 02                	push   $0x2
  8010b0:	e8 64 ff ff ff       	call   801019 <syscall>
  8010b5:	83 c4 18             	add    $0x18,%esp
}
  8010b8:	c9                   	leave  
  8010b9:	c3                   	ret    

008010ba <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010ba:	55                   	push   %ebp
  8010bb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010bd:	6a 00                	push   $0x0
  8010bf:	6a 00                	push   $0x0
  8010c1:	6a 00                	push   $0x0
  8010c3:	6a 00                	push   $0x0
  8010c5:	6a 00                	push   $0x0
  8010c7:	6a 03                	push   $0x3
  8010c9:	e8 4b ff ff ff       	call   801019 <syscall>
  8010ce:	83 c4 18             	add    $0x18,%esp
}
  8010d1:	c9                   	leave  
  8010d2:	c3                   	ret    

008010d3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010d3:	55                   	push   %ebp
  8010d4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010d6:	6a 00                	push   $0x0
  8010d8:	6a 00                	push   $0x0
  8010da:	6a 00                	push   $0x0
  8010dc:	6a 00                	push   $0x0
  8010de:	6a 00                	push   $0x0
  8010e0:	6a 04                	push   $0x4
  8010e2:	e8 32 ff ff ff       	call   801019 <syscall>
  8010e7:	83 c4 18             	add    $0x18,%esp
}
  8010ea:	c9                   	leave  
  8010eb:	c3                   	ret    

008010ec <sys_env_exit>:


void sys_env_exit(void)
{
  8010ec:	55                   	push   %ebp
  8010ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010ef:	6a 00                	push   $0x0
  8010f1:	6a 00                	push   $0x0
  8010f3:	6a 00                	push   $0x0
  8010f5:	6a 00                	push   $0x0
  8010f7:	6a 00                	push   $0x0
  8010f9:	6a 06                	push   $0x6
  8010fb:	e8 19 ff ff ff       	call   801019 <syscall>
  801100:	83 c4 18             	add    $0x18,%esp
}
  801103:	90                   	nop
  801104:	c9                   	leave  
  801105:	c3                   	ret    

00801106 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801106:	55                   	push   %ebp
  801107:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801109:	8b 55 0c             	mov    0xc(%ebp),%edx
  80110c:	8b 45 08             	mov    0x8(%ebp),%eax
  80110f:	6a 00                	push   $0x0
  801111:	6a 00                	push   $0x0
  801113:	6a 00                	push   $0x0
  801115:	52                   	push   %edx
  801116:	50                   	push   %eax
  801117:	6a 07                	push   $0x7
  801119:	e8 fb fe ff ff       	call   801019 <syscall>
  80111e:	83 c4 18             	add    $0x18,%esp
}
  801121:	c9                   	leave  
  801122:	c3                   	ret    

00801123 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801123:	55                   	push   %ebp
  801124:	89 e5                	mov    %esp,%ebp
  801126:	56                   	push   %esi
  801127:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801128:	8b 75 18             	mov    0x18(%ebp),%esi
  80112b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80112e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801131:	8b 55 0c             	mov    0xc(%ebp),%edx
  801134:	8b 45 08             	mov    0x8(%ebp),%eax
  801137:	56                   	push   %esi
  801138:	53                   	push   %ebx
  801139:	51                   	push   %ecx
  80113a:	52                   	push   %edx
  80113b:	50                   	push   %eax
  80113c:	6a 08                	push   $0x8
  80113e:	e8 d6 fe ff ff       	call   801019 <syscall>
  801143:	83 c4 18             	add    $0x18,%esp
}
  801146:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801149:	5b                   	pop    %ebx
  80114a:	5e                   	pop    %esi
  80114b:	5d                   	pop    %ebp
  80114c:	c3                   	ret    

0080114d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80114d:	55                   	push   %ebp
  80114e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801150:	8b 55 0c             	mov    0xc(%ebp),%edx
  801153:	8b 45 08             	mov    0x8(%ebp),%eax
  801156:	6a 00                	push   $0x0
  801158:	6a 00                	push   $0x0
  80115a:	6a 00                	push   $0x0
  80115c:	52                   	push   %edx
  80115d:	50                   	push   %eax
  80115e:	6a 09                	push   $0x9
  801160:	e8 b4 fe ff ff       	call   801019 <syscall>
  801165:	83 c4 18             	add    $0x18,%esp
}
  801168:	c9                   	leave  
  801169:	c3                   	ret    

0080116a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80116a:	55                   	push   %ebp
  80116b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80116d:	6a 00                	push   $0x0
  80116f:	6a 00                	push   $0x0
  801171:	6a 00                	push   $0x0
  801173:	ff 75 0c             	pushl  0xc(%ebp)
  801176:	ff 75 08             	pushl  0x8(%ebp)
  801179:	6a 0a                	push   $0xa
  80117b:	e8 99 fe ff ff       	call   801019 <syscall>
  801180:	83 c4 18             	add    $0x18,%esp
}
  801183:	c9                   	leave  
  801184:	c3                   	ret    

00801185 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801185:	55                   	push   %ebp
  801186:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801188:	6a 00                	push   $0x0
  80118a:	6a 00                	push   $0x0
  80118c:	6a 00                	push   $0x0
  80118e:	6a 00                	push   $0x0
  801190:	6a 00                	push   $0x0
  801192:	6a 0b                	push   $0xb
  801194:	e8 80 fe ff ff       	call   801019 <syscall>
  801199:	83 c4 18             	add    $0x18,%esp
}
  80119c:	c9                   	leave  
  80119d:	c3                   	ret    

0080119e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80119e:	55                   	push   %ebp
  80119f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011a1:	6a 00                	push   $0x0
  8011a3:	6a 00                	push   $0x0
  8011a5:	6a 00                	push   $0x0
  8011a7:	6a 00                	push   $0x0
  8011a9:	6a 00                	push   $0x0
  8011ab:	6a 0c                	push   $0xc
  8011ad:	e8 67 fe ff ff       	call   801019 <syscall>
  8011b2:	83 c4 18             	add    $0x18,%esp
}
  8011b5:	c9                   	leave  
  8011b6:	c3                   	ret    

008011b7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011b7:	55                   	push   %ebp
  8011b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011ba:	6a 00                	push   $0x0
  8011bc:	6a 00                	push   $0x0
  8011be:	6a 00                	push   $0x0
  8011c0:	6a 00                	push   $0x0
  8011c2:	6a 00                	push   $0x0
  8011c4:	6a 0d                	push   $0xd
  8011c6:	e8 4e fe ff ff       	call   801019 <syscall>
  8011cb:	83 c4 18             	add    $0x18,%esp
}
  8011ce:	c9                   	leave  
  8011cf:	c3                   	ret    

008011d0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011d0:	55                   	push   %ebp
  8011d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011d3:	6a 00                	push   $0x0
  8011d5:	6a 00                	push   $0x0
  8011d7:	6a 00                	push   $0x0
  8011d9:	ff 75 0c             	pushl  0xc(%ebp)
  8011dc:	ff 75 08             	pushl  0x8(%ebp)
  8011df:	6a 11                	push   $0x11
  8011e1:	e8 33 fe ff ff       	call   801019 <syscall>
  8011e6:	83 c4 18             	add    $0x18,%esp
	return;
  8011e9:	90                   	nop
}
  8011ea:	c9                   	leave  
  8011eb:	c3                   	ret    

008011ec <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011ec:	55                   	push   %ebp
  8011ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011ef:	6a 00                	push   $0x0
  8011f1:	6a 00                	push   $0x0
  8011f3:	6a 00                	push   $0x0
  8011f5:	ff 75 0c             	pushl  0xc(%ebp)
  8011f8:	ff 75 08             	pushl  0x8(%ebp)
  8011fb:	6a 12                	push   $0x12
  8011fd:	e8 17 fe ff ff       	call   801019 <syscall>
  801202:	83 c4 18             	add    $0x18,%esp
	return ;
  801205:	90                   	nop
}
  801206:	c9                   	leave  
  801207:	c3                   	ret    

00801208 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801208:	55                   	push   %ebp
  801209:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80120b:	6a 00                	push   $0x0
  80120d:	6a 00                	push   $0x0
  80120f:	6a 00                	push   $0x0
  801211:	6a 00                	push   $0x0
  801213:	6a 00                	push   $0x0
  801215:	6a 0e                	push   $0xe
  801217:	e8 fd fd ff ff       	call   801019 <syscall>
  80121c:	83 c4 18             	add    $0x18,%esp
}
  80121f:	c9                   	leave  
  801220:	c3                   	ret    

00801221 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801221:	55                   	push   %ebp
  801222:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801224:	6a 00                	push   $0x0
  801226:	6a 00                	push   $0x0
  801228:	6a 00                	push   $0x0
  80122a:	6a 00                	push   $0x0
  80122c:	ff 75 08             	pushl  0x8(%ebp)
  80122f:	6a 0f                	push   $0xf
  801231:	e8 e3 fd ff ff       	call   801019 <syscall>
  801236:	83 c4 18             	add    $0x18,%esp
}
  801239:	c9                   	leave  
  80123a:	c3                   	ret    

0080123b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80123b:	55                   	push   %ebp
  80123c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80123e:	6a 00                	push   $0x0
  801240:	6a 00                	push   $0x0
  801242:	6a 00                	push   $0x0
  801244:	6a 00                	push   $0x0
  801246:	6a 00                	push   $0x0
  801248:	6a 10                	push   $0x10
  80124a:	e8 ca fd ff ff       	call   801019 <syscall>
  80124f:	83 c4 18             	add    $0x18,%esp
}
  801252:	90                   	nop
  801253:	c9                   	leave  
  801254:	c3                   	ret    

00801255 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801255:	55                   	push   %ebp
  801256:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801258:	6a 00                	push   $0x0
  80125a:	6a 00                	push   $0x0
  80125c:	6a 00                	push   $0x0
  80125e:	6a 00                	push   $0x0
  801260:	6a 00                	push   $0x0
  801262:	6a 14                	push   $0x14
  801264:	e8 b0 fd ff ff       	call   801019 <syscall>
  801269:	83 c4 18             	add    $0x18,%esp
}
  80126c:	90                   	nop
  80126d:	c9                   	leave  
  80126e:	c3                   	ret    

0080126f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80126f:	55                   	push   %ebp
  801270:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801272:	6a 00                	push   $0x0
  801274:	6a 00                	push   $0x0
  801276:	6a 00                	push   $0x0
  801278:	6a 00                	push   $0x0
  80127a:	6a 00                	push   $0x0
  80127c:	6a 15                	push   $0x15
  80127e:	e8 96 fd ff ff       	call   801019 <syscall>
  801283:	83 c4 18             	add    $0x18,%esp
}
  801286:	90                   	nop
  801287:	c9                   	leave  
  801288:	c3                   	ret    

00801289 <sys_cputc>:


void
sys_cputc(const char c)
{
  801289:	55                   	push   %ebp
  80128a:	89 e5                	mov    %esp,%ebp
  80128c:	83 ec 04             	sub    $0x4,%esp
  80128f:	8b 45 08             	mov    0x8(%ebp),%eax
  801292:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801295:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801299:	6a 00                	push   $0x0
  80129b:	6a 00                	push   $0x0
  80129d:	6a 00                	push   $0x0
  80129f:	6a 00                	push   $0x0
  8012a1:	50                   	push   %eax
  8012a2:	6a 16                	push   $0x16
  8012a4:	e8 70 fd ff ff       	call   801019 <syscall>
  8012a9:	83 c4 18             	add    $0x18,%esp
}
  8012ac:	90                   	nop
  8012ad:	c9                   	leave  
  8012ae:	c3                   	ret    

008012af <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012af:	55                   	push   %ebp
  8012b0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012b2:	6a 00                	push   $0x0
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 00                	push   $0x0
  8012ba:	6a 00                	push   $0x0
  8012bc:	6a 17                	push   $0x17
  8012be:	e8 56 fd ff ff       	call   801019 <syscall>
  8012c3:	83 c4 18             	add    $0x18,%esp
}
  8012c6:	90                   	nop
  8012c7:	c9                   	leave  
  8012c8:	c3                   	ret    

008012c9 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012c9:	55                   	push   %ebp
  8012ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cf:	6a 00                	push   $0x0
  8012d1:	6a 00                	push   $0x0
  8012d3:	6a 00                	push   $0x0
  8012d5:	ff 75 0c             	pushl  0xc(%ebp)
  8012d8:	50                   	push   %eax
  8012d9:	6a 18                	push   $0x18
  8012db:	e8 39 fd ff ff       	call   801019 <syscall>
  8012e0:	83 c4 18             	add    $0x18,%esp
}
  8012e3:	c9                   	leave  
  8012e4:	c3                   	ret    

008012e5 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012e5:	55                   	push   %ebp
  8012e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ee:	6a 00                	push   $0x0
  8012f0:	6a 00                	push   $0x0
  8012f2:	6a 00                	push   $0x0
  8012f4:	52                   	push   %edx
  8012f5:	50                   	push   %eax
  8012f6:	6a 1b                	push   $0x1b
  8012f8:	e8 1c fd ff ff       	call   801019 <syscall>
  8012fd:	83 c4 18             	add    $0x18,%esp
}
  801300:	c9                   	leave  
  801301:	c3                   	ret    

00801302 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801302:	55                   	push   %ebp
  801303:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801305:	8b 55 0c             	mov    0xc(%ebp),%edx
  801308:	8b 45 08             	mov    0x8(%ebp),%eax
  80130b:	6a 00                	push   $0x0
  80130d:	6a 00                	push   $0x0
  80130f:	6a 00                	push   $0x0
  801311:	52                   	push   %edx
  801312:	50                   	push   %eax
  801313:	6a 19                	push   $0x19
  801315:	e8 ff fc ff ff       	call   801019 <syscall>
  80131a:	83 c4 18             	add    $0x18,%esp
}
  80131d:	90                   	nop
  80131e:	c9                   	leave  
  80131f:	c3                   	ret    

00801320 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801320:	55                   	push   %ebp
  801321:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801323:	8b 55 0c             	mov    0xc(%ebp),%edx
  801326:	8b 45 08             	mov    0x8(%ebp),%eax
  801329:	6a 00                	push   $0x0
  80132b:	6a 00                	push   $0x0
  80132d:	6a 00                	push   $0x0
  80132f:	52                   	push   %edx
  801330:	50                   	push   %eax
  801331:	6a 1a                	push   $0x1a
  801333:	e8 e1 fc ff ff       	call   801019 <syscall>
  801338:	83 c4 18             	add    $0x18,%esp
}
  80133b:	90                   	nop
  80133c:	c9                   	leave  
  80133d:	c3                   	ret    

0080133e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80133e:	55                   	push   %ebp
  80133f:	89 e5                	mov    %esp,%ebp
  801341:	83 ec 04             	sub    $0x4,%esp
  801344:	8b 45 10             	mov    0x10(%ebp),%eax
  801347:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80134a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80134d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801351:	8b 45 08             	mov    0x8(%ebp),%eax
  801354:	6a 00                	push   $0x0
  801356:	51                   	push   %ecx
  801357:	52                   	push   %edx
  801358:	ff 75 0c             	pushl  0xc(%ebp)
  80135b:	50                   	push   %eax
  80135c:	6a 1c                	push   $0x1c
  80135e:	e8 b6 fc ff ff       	call   801019 <syscall>
  801363:	83 c4 18             	add    $0x18,%esp
}
  801366:	c9                   	leave  
  801367:	c3                   	ret    

00801368 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801368:	55                   	push   %ebp
  801369:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80136b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136e:	8b 45 08             	mov    0x8(%ebp),%eax
  801371:	6a 00                	push   $0x0
  801373:	6a 00                	push   $0x0
  801375:	6a 00                	push   $0x0
  801377:	52                   	push   %edx
  801378:	50                   	push   %eax
  801379:	6a 1d                	push   $0x1d
  80137b:	e8 99 fc ff ff       	call   801019 <syscall>
  801380:	83 c4 18             	add    $0x18,%esp
}
  801383:	c9                   	leave  
  801384:	c3                   	ret    

00801385 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801385:	55                   	push   %ebp
  801386:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801388:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80138b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	6a 00                	push   $0x0
  801393:	6a 00                	push   $0x0
  801395:	51                   	push   %ecx
  801396:	52                   	push   %edx
  801397:	50                   	push   %eax
  801398:	6a 1e                	push   $0x1e
  80139a:	e8 7a fc ff ff       	call   801019 <syscall>
  80139f:	83 c4 18             	add    $0x18,%esp
}
  8013a2:	c9                   	leave  
  8013a3:	c3                   	ret    

008013a4 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013a4:	55                   	push   %ebp
  8013a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ad:	6a 00                	push   $0x0
  8013af:	6a 00                	push   $0x0
  8013b1:	6a 00                	push   $0x0
  8013b3:	52                   	push   %edx
  8013b4:	50                   	push   %eax
  8013b5:	6a 1f                	push   $0x1f
  8013b7:	e8 5d fc ff ff       	call   801019 <syscall>
  8013bc:	83 c4 18             	add    $0x18,%esp
}
  8013bf:	c9                   	leave  
  8013c0:	c3                   	ret    

008013c1 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013c1:	55                   	push   %ebp
  8013c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013c4:	6a 00                	push   $0x0
  8013c6:	6a 00                	push   $0x0
  8013c8:	6a 00                	push   $0x0
  8013ca:	6a 00                	push   $0x0
  8013cc:	6a 00                	push   $0x0
  8013ce:	6a 20                	push   $0x20
  8013d0:	e8 44 fc ff ff       	call   801019 <syscall>
  8013d5:	83 c4 18             	add    $0x18,%esp
}
  8013d8:	c9                   	leave  
  8013d9:	c3                   	ret    

008013da <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8013da:	55                   	push   %ebp
  8013db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8013dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e0:	6a 00                	push   $0x0
  8013e2:	ff 75 14             	pushl  0x14(%ebp)
  8013e5:	ff 75 10             	pushl  0x10(%ebp)
  8013e8:	ff 75 0c             	pushl  0xc(%ebp)
  8013eb:	50                   	push   %eax
  8013ec:	6a 21                	push   $0x21
  8013ee:	e8 26 fc ff ff       	call   801019 <syscall>
  8013f3:	83 c4 18             	add    $0x18,%esp
}
  8013f6:	c9                   	leave  
  8013f7:	c3                   	ret    

008013f8 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8013f8:	55                   	push   %ebp
  8013f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fe:	6a 00                	push   $0x0
  801400:	6a 00                	push   $0x0
  801402:	6a 00                	push   $0x0
  801404:	6a 00                	push   $0x0
  801406:	50                   	push   %eax
  801407:	6a 22                	push   $0x22
  801409:	e8 0b fc ff ff       	call   801019 <syscall>
  80140e:	83 c4 18             	add    $0x18,%esp
}
  801411:	90                   	nop
  801412:	c9                   	leave  
  801413:	c3                   	ret    

00801414 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801414:	55                   	push   %ebp
  801415:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801417:	8b 45 08             	mov    0x8(%ebp),%eax
  80141a:	6a 00                	push   $0x0
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	50                   	push   %eax
  801423:	6a 23                	push   $0x23
  801425:	e8 ef fb ff ff       	call   801019 <syscall>
  80142a:	83 c4 18             	add    $0x18,%esp
}
  80142d:	90                   	nop
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
  801433:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801436:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801439:	8d 50 04             	lea    0x4(%eax),%edx
  80143c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	6a 00                	push   $0x0
  801445:	52                   	push   %edx
  801446:	50                   	push   %eax
  801447:	6a 24                	push   $0x24
  801449:	e8 cb fb ff ff       	call   801019 <syscall>
  80144e:	83 c4 18             	add    $0x18,%esp
	return result;
  801451:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801454:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801457:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80145a:	89 01                	mov    %eax,(%ecx)
  80145c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80145f:	8b 45 08             	mov    0x8(%ebp),%eax
  801462:	c9                   	leave  
  801463:	c2 04 00             	ret    $0x4

00801466 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801466:	55                   	push   %ebp
  801467:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801469:	6a 00                	push   $0x0
  80146b:	6a 00                	push   $0x0
  80146d:	ff 75 10             	pushl  0x10(%ebp)
  801470:	ff 75 0c             	pushl  0xc(%ebp)
  801473:	ff 75 08             	pushl  0x8(%ebp)
  801476:	6a 13                	push   $0x13
  801478:	e8 9c fb ff ff       	call   801019 <syscall>
  80147d:	83 c4 18             	add    $0x18,%esp
	return ;
  801480:	90                   	nop
}
  801481:	c9                   	leave  
  801482:	c3                   	ret    

00801483 <sys_rcr2>:
uint32 sys_rcr2()
{
  801483:	55                   	push   %ebp
  801484:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801486:	6a 00                	push   $0x0
  801488:	6a 00                	push   $0x0
  80148a:	6a 00                	push   $0x0
  80148c:	6a 00                	push   $0x0
  80148e:	6a 00                	push   $0x0
  801490:	6a 25                	push   $0x25
  801492:	e8 82 fb ff ff       	call   801019 <syscall>
  801497:	83 c4 18             	add    $0x18,%esp
}
  80149a:	c9                   	leave  
  80149b:	c3                   	ret    

0080149c <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80149c:	55                   	push   %ebp
  80149d:	89 e5                	mov    %esp,%ebp
  80149f:	83 ec 04             	sub    $0x4,%esp
  8014a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014a8:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 00                	push   $0x0
  8014b2:	6a 00                	push   $0x0
  8014b4:	50                   	push   %eax
  8014b5:	6a 26                	push   $0x26
  8014b7:	e8 5d fb ff ff       	call   801019 <syscall>
  8014bc:	83 c4 18             	add    $0x18,%esp
	return ;
  8014bf:	90                   	nop
}
  8014c0:	c9                   	leave  
  8014c1:	c3                   	ret    

008014c2 <rsttst>:
void rsttst()
{
  8014c2:	55                   	push   %ebp
  8014c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 00                	push   $0x0
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 28                	push   $0x28
  8014d1:	e8 43 fb ff ff       	call   801019 <syscall>
  8014d6:	83 c4 18             	add    $0x18,%esp
	return ;
  8014d9:	90                   	nop
}
  8014da:	c9                   	leave  
  8014db:	c3                   	ret    

008014dc <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014dc:	55                   	push   %ebp
  8014dd:	89 e5                	mov    %esp,%ebp
  8014df:	83 ec 04             	sub    $0x4,%esp
  8014e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8014e5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014e8:	8b 55 18             	mov    0x18(%ebp),%edx
  8014eb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014ef:	52                   	push   %edx
  8014f0:	50                   	push   %eax
  8014f1:	ff 75 10             	pushl  0x10(%ebp)
  8014f4:	ff 75 0c             	pushl  0xc(%ebp)
  8014f7:	ff 75 08             	pushl  0x8(%ebp)
  8014fa:	6a 27                	push   $0x27
  8014fc:	e8 18 fb ff ff       	call   801019 <syscall>
  801501:	83 c4 18             	add    $0x18,%esp
	return ;
  801504:	90                   	nop
}
  801505:	c9                   	leave  
  801506:	c3                   	ret    

00801507 <chktst>:
void chktst(uint32 n)
{
  801507:	55                   	push   %ebp
  801508:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80150a:	6a 00                	push   $0x0
  80150c:	6a 00                	push   $0x0
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	ff 75 08             	pushl  0x8(%ebp)
  801515:	6a 29                	push   $0x29
  801517:	e8 fd fa ff ff       	call   801019 <syscall>
  80151c:	83 c4 18             	add    $0x18,%esp
	return ;
  80151f:	90                   	nop
}
  801520:	c9                   	leave  
  801521:	c3                   	ret    

00801522 <inctst>:

void inctst()
{
  801522:	55                   	push   %ebp
  801523:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	6a 00                	push   $0x0
  80152f:	6a 2a                	push   $0x2a
  801531:	e8 e3 fa ff ff       	call   801019 <syscall>
  801536:	83 c4 18             	add    $0x18,%esp
	return ;
  801539:	90                   	nop
}
  80153a:	c9                   	leave  
  80153b:	c3                   	ret    

0080153c <gettst>:
uint32 gettst()
{
  80153c:	55                   	push   %ebp
  80153d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	6a 00                	push   $0x0
  801547:	6a 00                	push   $0x0
  801549:	6a 2b                	push   $0x2b
  80154b:	e8 c9 fa ff ff       	call   801019 <syscall>
  801550:	83 c4 18             	add    $0x18,%esp
}
  801553:	c9                   	leave  
  801554:	c3                   	ret    

00801555 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801555:	55                   	push   %ebp
  801556:	89 e5                	mov    %esp,%ebp
  801558:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80155b:	6a 00                	push   $0x0
  80155d:	6a 00                	push   $0x0
  80155f:	6a 00                	push   $0x0
  801561:	6a 00                	push   $0x0
  801563:	6a 00                	push   $0x0
  801565:	6a 2c                	push   $0x2c
  801567:	e8 ad fa ff ff       	call   801019 <syscall>
  80156c:	83 c4 18             	add    $0x18,%esp
  80156f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801572:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801576:	75 07                	jne    80157f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801578:	b8 01 00 00 00       	mov    $0x1,%eax
  80157d:	eb 05                	jmp    801584 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80157f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801584:	c9                   	leave  
  801585:	c3                   	ret    

00801586 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801586:	55                   	push   %ebp
  801587:	89 e5                	mov    %esp,%ebp
  801589:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 2c                	push   $0x2c
  801598:	e8 7c fa ff ff       	call   801019 <syscall>
  80159d:	83 c4 18             	add    $0x18,%esp
  8015a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015a3:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015a7:	75 07                	jne    8015b0 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015a9:	b8 01 00 00 00       	mov    $0x1,%eax
  8015ae:	eb 05                	jmp    8015b5 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015b0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015b5:	c9                   	leave  
  8015b6:	c3                   	ret    

008015b7 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015b7:	55                   	push   %ebp
  8015b8:	89 e5                	mov    %esp,%ebp
  8015ba:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 2c                	push   $0x2c
  8015c9:	e8 4b fa ff ff       	call   801019 <syscall>
  8015ce:	83 c4 18             	add    $0x18,%esp
  8015d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015d4:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015d8:	75 07                	jne    8015e1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015da:	b8 01 00 00 00       	mov    $0x1,%eax
  8015df:	eb 05                	jmp    8015e6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015e1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015e6:	c9                   	leave  
  8015e7:	c3                   	ret    

008015e8 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015e8:	55                   	push   %ebp
  8015e9:	89 e5                	mov    %esp,%ebp
  8015eb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 2c                	push   $0x2c
  8015fa:	e8 1a fa ff ff       	call   801019 <syscall>
  8015ff:	83 c4 18             	add    $0x18,%esp
  801602:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801605:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801609:	75 07                	jne    801612 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80160b:	b8 01 00 00 00       	mov    $0x1,%eax
  801610:	eb 05                	jmp    801617 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801612:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801617:	c9                   	leave  
  801618:	c3                   	ret    

00801619 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801619:	55                   	push   %ebp
  80161a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	6a 00                	push   $0x0
  801622:	6a 00                	push   $0x0
  801624:	ff 75 08             	pushl  0x8(%ebp)
  801627:	6a 2d                	push   $0x2d
  801629:	e8 eb f9 ff ff       	call   801019 <syscall>
  80162e:	83 c4 18             	add    $0x18,%esp
	return ;
  801631:	90                   	nop
}
  801632:	c9                   	leave  
  801633:	c3                   	ret    

00801634 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801634:	55                   	push   %ebp
  801635:	89 e5                	mov    %esp,%ebp
  801637:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801638:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80163b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80163e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801641:	8b 45 08             	mov    0x8(%ebp),%eax
  801644:	6a 00                	push   $0x0
  801646:	53                   	push   %ebx
  801647:	51                   	push   %ecx
  801648:	52                   	push   %edx
  801649:	50                   	push   %eax
  80164a:	6a 2e                	push   $0x2e
  80164c:	e8 c8 f9 ff ff       	call   801019 <syscall>
  801651:	83 c4 18             	add    $0x18,%esp
}
  801654:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801657:	c9                   	leave  
  801658:	c3                   	ret    

00801659 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801659:	55                   	push   %ebp
  80165a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80165c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	52                   	push   %edx
  801669:	50                   	push   %eax
  80166a:	6a 2f                	push   $0x2f
  80166c:	e8 a8 f9 ff ff       	call   801019 <syscall>
  801671:	83 c4 18             	add    $0x18,%esp
}
  801674:	c9                   	leave  
  801675:	c3                   	ret    

00801676 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801676:	55                   	push   %ebp
  801677:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801679:	6a 00                	push   $0x0
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	ff 75 0c             	pushl  0xc(%ebp)
  801682:	ff 75 08             	pushl  0x8(%ebp)
  801685:	6a 30                	push   $0x30
  801687:	e8 8d f9 ff ff       	call   801019 <syscall>
  80168c:	83 c4 18             	add    $0x18,%esp
	return ;
  80168f:	90                   	nop
}
  801690:	c9                   	leave  
  801691:	c3                   	ret    
  801692:	66 90                	xchg   %ax,%ax

00801694 <__udivdi3>:
  801694:	55                   	push   %ebp
  801695:	57                   	push   %edi
  801696:	56                   	push   %esi
  801697:	53                   	push   %ebx
  801698:	83 ec 1c             	sub    $0x1c,%esp
  80169b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80169f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8016a3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016a7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8016ab:	89 ca                	mov    %ecx,%edx
  8016ad:	89 f8                	mov    %edi,%eax
  8016af:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8016b3:	85 f6                	test   %esi,%esi
  8016b5:	75 2d                	jne    8016e4 <__udivdi3+0x50>
  8016b7:	39 cf                	cmp    %ecx,%edi
  8016b9:	77 65                	ja     801720 <__udivdi3+0x8c>
  8016bb:	89 fd                	mov    %edi,%ebp
  8016bd:	85 ff                	test   %edi,%edi
  8016bf:	75 0b                	jne    8016cc <__udivdi3+0x38>
  8016c1:	b8 01 00 00 00       	mov    $0x1,%eax
  8016c6:	31 d2                	xor    %edx,%edx
  8016c8:	f7 f7                	div    %edi
  8016ca:	89 c5                	mov    %eax,%ebp
  8016cc:	31 d2                	xor    %edx,%edx
  8016ce:	89 c8                	mov    %ecx,%eax
  8016d0:	f7 f5                	div    %ebp
  8016d2:	89 c1                	mov    %eax,%ecx
  8016d4:	89 d8                	mov    %ebx,%eax
  8016d6:	f7 f5                	div    %ebp
  8016d8:	89 cf                	mov    %ecx,%edi
  8016da:	89 fa                	mov    %edi,%edx
  8016dc:	83 c4 1c             	add    $0x1c,%esp
  8016df:	5b                   	pop    %ebx
  8016e0:	5e                   	pop    %esi
  8016e1:	5f                   	pop    %edi
  8016e2:	5d                   	pop    %ebp
  8016e3:	c3                   	ret    
  8016e4:	39 ce                	cmp    %ecx,%esi
  8016e6:	77 28                	ja     801710 <__udivdi3+0x7c>
  8016e8:	0f bd fe             	bsr    %esi,%edi
  8016eb:	83 f7 1f             	xor    $0x1f,%edi
  8016ee:	75 40                	jne    801730 <__udivdi3+0x9c>
  8016f0:	39 ce                	cmp    %ecx,%esi
  8016f2:	72 0a                	jb     8016fe <__udivdi3+0x6a>
  8016f4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8016f8:	0f 87 9e 00 00 00    	ja     80179c <__udivdi3+0x108>
  8016fe:	b8 01 00 00 00       	mov    $0x1,%eax
  801703:	89 fa                	mov    %edi,%edx
  801705:	83 c4 1c             	add    $0x1c,%esp
  801708:	5b                   	pop    %ebx
  801709:	5e                   	pop    %esi
  80170a:	5f                   	pop    %edi
  80170b:	5d                   	pop    %ebp
  80170c:	c3                   	ret    
  80170d:	8d 76 00             	lea    0x0(%esi),%esi
  801710:	31 ff                	xor    %edi,%edi
  801712:	31 c0                	xor    %eax,%eax
  801714:	89 fa                	mov    %edi,%edx
  801716:	83 c4 1c             	add    $0x1c,%esp
  801719:	5b                   	pop    %ebx
  80171a:	5e                   	pop    %esi
  80171b:	5f                   	pop    %edi
  80171c:	5d                   	pop    %ebp
  80171d:	c3                   	ret    
  80171e:	66 90                	xchg   %ax,%ax
  801720:	89 d8                	mov    %ebx,%eax
  801722:	f7 f7                	div    %edi
  801724:	31 ff                	xor    %edi,%edi
  801726:	89 fa                	mov    %edi,%edx
  801728:	83 c4 1c             	add    $0x1c,%esp
  80172b:	5b                   	pop    %ebx
  80172c:	5e                   	pop    %esi
  80172d:	5f                   	pop    %edi
  80172e:	5d                   	pop    %ebp
  80172f:	c3                   	ret    
  801730:	bd 20 00 00 00       	mov    $0x20,%ebp
  801735:	89 eb                	mov    %ebp,%ebx
  801737:	29 fb                	sub    %edi,%ebx
  801739:	89 f9                	mov    %edi,%ecx
  80173b:	d3 e6                	shl    %cl,%esi
  80173d:	89 c5                	mov    %eax,%ebp
  80173f:	88 d9                	mov    %bl,%cl
  801741:	d3 ed                	shr    %cl,%ebp
  801743:	89 e9                	mov    %ebp,%ecx
  801745:	09 f1                	or     %esi,%ecx
  801747:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80174b:	89 f9                	mov    %edi,%ecx
  80174d:	d3 e0                	shl    %cl,%eax
  80174f:	89 c5                	mov    %eax,%ebp
  801751:	89 d6                	mov    %edx,%esi
  801753:	88 d9                	mov    %bl,%cl
  801755:	d3 ee                	shr    %cl,%esi
  801757:	89 f9                	mov    %edi,%ecx
  801759:	d3 e2                	shl    %cl,%edx
  80175b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80175f:	88 d9                	mov    %bl,%cl
  801761:	d3 e8                	shr    %cl,%eax
  801763:	09 c2                	or     %eax,%edx
  801765:	89 d0                	mov    %edx,%eax
  801767:	89 f2                	mov    %esi,%edx
  801769:	f7 74 24 0c          	divl   0xc(%esp)
  80176d:	89 d6                	mov    %edx,%esi
  80176f:	89 c3                	mov    %eax,%ebx
  801771:	f7 e5                	mul    %ebp
  801773:	39 d6                	cmp    %edx,%esi
  801775:	72 19                	jb     801790 <__udivdi3+0xfc>
  801777:	74 0b                	je     801784 <__udivdi3+0xf0>
  801779:	89 d8                	mov    %ebx,%eax
  80177b:	31 ff                	xor    %edi,%edi
  80177d:	e9 58 ff ff ff       	jmp    8016da <__udivdi3+0x46>
  801782:	66 90                	xchg   %ax,%ax
  801784:	8b 54 24 08          	mov    0x8(%esp),%edx
  801788:	89 f9                	mov    %edi,%ecx
  80178a:	d3 e2                	shl    %cl,%edx
  80178c:	39 c2                	cmp    %eax,%edx
  80178e:	73 e9                	jae    801779 <__udivdi3+0xe5>
  801790:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801793:	31 ff                	xor    %edi,%edi
  801795:	e9 40 ff ff ff       	jmp    8016da <__udivdi3+0x46>
  80179a:	66 90                	xchg   %ax,%ax
  80179c:	31 c0                	xor    %eax,%eax
  80179e:	e9 37 ff ff ff       	jmp    8016da <__udivdi3+0x46>
  8017a3:	90                   	nop

008017a4 <__umoddi3>:
  8017a4:	55                   	push   %ebp
  8017a5:	57                   	push   %edi
  8017a6:	56                   	push   %esi
  8017a7:	53                   	push   %ebx
  8017a8:	83 ec 1c             	sub    $0x1c,%esp
  8017ab:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8017af:	8b 74 24 34          	mov    0x34(%esp),%esi
  8017b3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017b7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8017bb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8017bf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8017c3:	89 f3                	mov    %esi,%ebx
  8017c5:	89 fa                	mov    %edi,%edx
  8017c7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8017cb:	89 34 24             	mov    %esi,(%esp)
  8017ce:	85 c0                	test   %eax,%eax
  8017d0:	75 1a                	jne    8017ec <__umoddi3+0x48>
  8017d2:	39 f7                	cmp    %esi,%edi
  8017d4:	0f 86 a2 00 00 00    	jbe    80187c <__umoddi3+0xd8>
  8017da:	89 c8                	mov    %ecx,%eax
  8017dc:	89 f2                	mov    %esi,%edx
  8017de:	f7 f7                	div    %edi
  8017e0:	89 d0                	mov    %edx,%eax
  8017e2:	31 d2                	xor    %edx,%edx
  8017e4:	83 c4 1c             	add    $0x1c,%esp
  8017e7:	5b                   	pop    %ebx
  8017e8:	5e                   	pop    %esi
  8017e9:	5f                   	pop    %edi
  8017ea:	5d                   	pop    %ebp
  8017eb:	c3                   	ret    
  8017ec:	39 f0                	cmp    %esi,%eax
  8017ee:	0f 87 ac 00 00 00    	ja     8018a0 <__umoddi3+0xfc>
  8017f4:	0f bd e8             	bsr    %eax,%ebp
  8017f7:	83 f5 1f             	xor    $0x1f,%ebp
  8017fa:	0f 84 ac 00 00 00    	je     8018ac <__umoddi3+0x108>
  801800:	bf 20 00 00 00       	mov    $0x20,%edi
  801805:	29 ef                	sub    %ebp,%edi
  801807:	89 fe                	mov    %edi,%esi
  801809:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80180d:	89 e9                	mov    %ebp,%ecx
  80180f:	d3 e0                	shl    %cl,%eax
  801811:	89 d7                	mov    %edx,%edi
  801813:	89 f1                	mov    %esi,%ecx
  801815:	d3 ef                	shr    %cl,%edi
  801817:	09 c7                	or     %eax,%edi
  801819:	89 e9                	mov    %ebp,%ecx
  80181b:	d3 e2                	shl    %cl,%edx
  80181d:	89 14 24             	mov    %edx,(%esp)
  801820:	89 d8                	mov    %ebx,%eax
  801822:	d3 e0                	shl    %cl,%eax
  801824:	89 c2                	mov    %eax,%edx
  801826:	8b 44 24 08          	mov    0x8(%esp),%eax
  80182a:	d3 e0                	shl    %cl,%eax
  80182c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801830:	8b 44 24 08          	mov    0x8(%esp),%eax
  801834:	89 f1                	mov    %esi,%ecx
  801836:	d3 e8                	shr    %cl,%eax
  801838:	09 d0                	or     %edx,%eax
  80183a:	d3 eb                	shr    %cl,%ebx
  80183c:	89 da                	mov    %ebx,%edx
  80183e:	f7 f7                	div    %edi
  801840:	89 d3                	mov    %edx,%ebx
  801842:	f7 24 24             	mull   (%esp)
  801845:	89 c6                	mov    %eax,%esi
  801847:	89 d1                	mov    %edx,%ecx
  801849:	39 d3                	cmp    %edx,%ebx
  80184b:	0f 82 87 00 00 00    	jb     8018d8 <__umoddi3+0x134>
  801851:	0f 84 91 00 00 00    	je     8018e8 <__umoddi3+0x144>
  801857:	8b 54 24 04          	mov    0x4(%esp),%edx
  80185b:	29 f2                	sub    %esi,%edx
  80185d:	19 cb                	sbb    %ecx,%ebx
  80185f:	89 d8                	mov    %ebx,%eax
  801861:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801865:	d3 e0                	shl    %cl,%eax
  801867:	89 e9                	mov    %ebp,%ecx
  801869:	d3 ea                	shr    %cl,%edx
  80186b:	09 d0                	or     %edx,%eax
  80186d:	89 e9                	mov    %ebp,%ecx
  80186f:	d3 eb                	shr    %cl,%ebx
  801871:	89 da                	mov    %ebx,%edx
  801873:	83 c4 1c             	add    $0x1c,%esp
  801876:	5b                   	pop    %ebx
  801877:	5e                   	pop    %esi
  801878:	5f                   	pop    %edi
  801879:	5d                   	pop    %ebp
  80187a:	c3                   	ret    
  80187b:	90                   	nop
  80187c:	89 fd                	mov    %edi,%ebp
  80187e:	85 ff                	test   %edi,%edi
  801880:	75 0b                	jne    80188d <__umoddi3+0xe9>
  801882:	b8 01 00 00 00       	mov    $0x1,%eax
  801887:	31 d2                	xor    %edx,%edx
  801889:	f7 f7                	div    %edi
  80188b:	89 c5                	mov    %eax,%ebp
  80188d:	89 f0                	mov    %esi,%eax
  80188f:	31 d2                	xor    %edx,%edx
  801891:	f7 f5                	div    %ebp
  801893:	89 c8                	mov    %ecx,%eax
  801895:	f7 f5                	div    %ebp
  801897:	89 d0                	mov    %edx,%eax
  801899:	e9 44 ff ff ff       	jmp    8017e2 <__umoddi3+0x3e>
  80189e:	66 90                	xchg   %ax,%ax
  8018a0:	89 c8                	mov    %ecx,%eax
  8018a2:	89 f2                	mov    %esi,%edx
  8018a4:	83 c4 1c             	add    $0x1c,%esp
  8018a7:	5b                   	pop    %ebx
  8018a8:	5e                   	pop    %esi
  8018a9:	5f                   	pop    %edi
  8018aa:	5d                   	pop    %ebp
  8018ab:	c3                   	ret    
  8018ac:	3b 04 24             	cmp    (%esp),%eax
  8018af:	72 06                	jb     8018b7 <__umoddi3+0x113>
  8018b1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8018b5:	77 0f                	ja     8018c6 <__umoddi3+0x122>
  8018b7:	89 f2                	mov    %esi,%edx
  8018b9:	29 f9                	sub    %edi,%ecx
  8018bb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8018bf:	89 14 24             	mov    %edx,(%esp)
  8018c2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018c6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8018ca:	8b 14 24             	mov    (%esp),%edx
  8018cd:	83 c4 1c             	add    $0x1c,%esp
  8018d0:	5b                   	pop    %ebx
  8018d1:	5e                   	pop    %esi
  8018d2:	5f                   	pop    %edi
  8018d3:	5d                   	pop    %ebp
  8018d4:	c3                   	ret    
  8018d5:	8d 76 00             	lea    0x0(%esi),%esi
  8018d8:	2b 04 24             	sub    (%esp),%eax
  8018db:	19 fa                	sbb    %edi,%edx
  8018dd:	89 d1                	mov    %edx,%ecx
  8018df:	89 c6                	mov    %eax,%esi
  8018e1:	e9 71 ff ff ff       	jmp    801857 <__umoddi3+0xb3>
  8018e6:	66 90                	xchg   %ax,%ax
  8018e8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8018ec:	72 ea                	jb     8018d8 <__umoddi3+0x134>
  8018ee:	89 d9                	mov    %ebx,%ecx
  8018f0:	e9 62 ff ff ff       	jmp    801857 <__umoddi3+0xb3>
