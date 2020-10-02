
obj/user/fos_data_on_stack:     file format elf32-i386


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
  800031:	e8 1e 00 00 00       	call   800054 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>


void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 48 27 00 00    	sub    $0x2748,%esp
	/// Adding array of 512 integer on user stack
	int arr[2512];

	atomic_cprintf("user stack contains 512 integer\n");
  800041:	83 ec 0c             	sub    $0xc,%esp
  800044:	68 c0 18 80 00       	push   $0x8018c0
  800049:	e8 2f 02 00 00       	call   80027d <atomic_cprintf>
  80004e:	83 c4 10             	add    $0x10,%esp

	return;	
  800051:	90                   	nop
}
  800052:	c9                   	leave  
  800053:	c3                   	ret    

00800054 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800054:	55                   	push   %ebp
  800055:	89 e5                	mov    %esp,%ebp
  800057:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80005a:	e8 1c 10 00 00       	call   80107b <sys_getenvindex>
  80005f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800062:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800065:	89 d0                	mov    %edx,%eax
  800067:	01 c0                	add    %eax,%eax
  800069:	01 d0                	add    %edx,%eax
  80006b:	c1 e0 07             	shl    $0x7,%eax
  80006e:	29 d0                	sub    %edx,%eax
  800070:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800077:	01 c8                	add    %ecx,%eax
  800079:	01 c0                	add    %eax,%eax
  80007b:	01 d0                	add    %edx,%eax
  80007d:	01 c0                	add    %eax,%eax
  80007f:	01 d0                	add    %edx,%eax
  800081:	c1 e0 03             	shl    $0x3,%eax
  800084:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800089:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80008e:	a1 20 20 80 00       	mov    0x802020,%eax
  800093:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  800099:	84 c0                	test   %al,%al
  80009b:	74 0f                	je     8000ac <libmain+0x58>
		binaryname = myEnv->prog_name;
  80009d:	a1 20 20 80 00       	mov    0x802020,%eax
  8000a2:	05 f0 ee 00 00       	add    $0xeef0,%eax
  8000a7:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000ac:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000b0:	7e 0a                	jle    8000bc <libmain+0x68>
		binaryname = argv[0];
  8000b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000bc:	83 ec 08             	sub    $0x8,%esp
  8000bf:	ff 75 0c             	pushl  0xc(%ebp)
  8000c2:	ff 75 08             	pushl  0x8(%ebp)
  8000c5:	e8 6e ff ff ff       	call   800038 <_main>
  8000ca:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000cd:	e8 44 11 00 00       	call   801216 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000d2:	83 ec 0c             	sub    $0xc,%esp
  8000d5:	68 fc 18 80 00       	push   $0x8018fc
  8000da:	e8 71 01 00 00       	call   800250 <cprintf>
  8000df:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8000e2:	a1 20 20 80 00       	mov    0x802020,%eax
  8000e7:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  8000ed:	a1 20 20 80 00       	mov    0x802020,%eax
  8000f2:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  8000f8:	83 ec 04             	sub    $0x4,%esp
  8000fb:	52                   	push   %edx
  8000fc:	50                   	push   %eax
  8000fd:	68 24 19 80 00       	push   $0x801924
  800102:	e8 49 01 00 00       	call   800250 <cprintf>
  800107:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80010a:	a1 20 20 80 00       	mov    0x802020,%eax
  80010f:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  800115:	a1 20 20 80 00       	mov    0x802020,%eax
  80011a:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  800120:	a1 20 20 80 00       	mov    0x802020,%eax
  800125:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  80012b:	51                   	push   %ecx
  80012c:	52                   	push   %edx
  80012d:	50                   	push   %eax
  80012e:	68 4c 19 80 00       	push   $0x80194c
  800133:	e8 18 01 00 00       	call   800250 <cprintf>
  800138:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80013b:	83 ec 0c             	sub    $0xc,%esp
  80013e:	68 fc 18 80 00       	push   $0x8018fc
  800143:	e8 08 01 00 00       	call   800250 <cprintf>
  800148:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80014b:	e8 e0 10 00 00       	call   801230 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800150:	e8 19 00 00 00       	call   80016e <exit>
}
  800155:	90                   	nop
  800156:	c9                   	leave  
  800157:	c3                   	ret    

00800158 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800158:	55                   	push   %ebp
  800159:	89 e5                	mov    %esp,%ebp
  80015b:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80015e:	83 ec 0c             	sub    $0xc,%esp
  800161:	6a 00                	push   $0x0
  800163:	e8 df 0e 00 00       	call   801047 <sys_env_destroy>
  800168:	83 c4 10             	add    $0x10,%esp
}
  80016b:	90                   	nop
  80016c:	c9                   	leave  
  80016d:	c3                   	ret    

0080016e <exit>:

void
exit(void)
{
  80016e:	55                   	push   %ebp
  80016f:	89 e5                	mov    %esp,%ebp
  800171:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800174:	e8 34 0f 00 00       	call   8010ad <sys_env_exit>
}
  800179:	90                   	nop
  80017a:	c9                   	leave  
  80017b:	c3                   	ret    

0080017c <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80017c:	55                   	push   %ebp
  80017d:	89 e5                	mov    %esp,%ebp
  80017f:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800182:	8b 45 0c             	mov    0xc(%ebp),%eax
  800185:	8b 00                	mov    (%eax),%eax
  800187:	8d 48 01             	lea    0x1(%eax),%ecx
  80018a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80018d:	89 0a                	mov    %ecx,(%edx)
  80018f:	8b 55 08             	mov    0x8(%ebp),%edx
  800192:	88 d1                	mov    %dl,%cl
  800194:	8b 55 0c             	mov    0xc(%ebp),%edx
  800197:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80019b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80019e:	8b 00                	mov    (%eax),%eax
  8001a0:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001a5:	75 2c                	jne    8001d3 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001a7:	a0 24 20 80 00       	mov    0x802024,%al
  8001ac:	0f b6 c0             	movzbl %al,%eax
  8001af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001b2:	8b 12                	mov    (%edx),%edx
  8001b4:	89 d1                	mov    %edx,%ecx
  8001b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001b9:	83 c2 08             	add    $0x8,%edx
  8001bc:	83 ec 04             	sub    $0x4,%esp
  8001bf:	50                   	push   %eax
  8001c0:	51                   	push   %ecx
  8001c1:	52                   	push   %edx
  8001c2:	e8 3e 0e 00 00       	call   801005 <sys_cputs>
  8001c7:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001cd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d6:	8b 40 04             	mov    0x4(%eax),%eax
  8001d9:	8d 50 01             	lea    0x1(%eax),%edx
  8001dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001df:	89 50 04             	mov    %edx,0x4(%eax)
}
  8001e2:	90                   	nop
  8001e3:	c9                   	leave  
  8001e4:	c3                   	ret    

008001e5 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8001e5:	55                   	push   %ebp
  8001e6:	89 e5                	mov    %esp,%ebp
  8001e8:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8001ee:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8001f5:	00 00 00 
	b.cnt = 0;
  8001f8:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8001ff:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800202:	ff 75 0c             	pushl  0xc(%ebp)
  800205:	ff 75 08             	pushl  0x8(%ebp)
  800208:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80020e:	50                   	push   %eax
  80020f:	68 7c 01 80 00       	push   $0x80017c
  800214:	e8 11 02 00 00       	call   80042a <vprintfmt>
  800219:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80021c:	a0 24 20 80 00       	mov    0x802024,%al
  800221:	0f b6 c0             	movzbl %al,%eax
  800224:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80022a:	83 ec 04             	sub    $0x4,%esp
  80022d:	50                   	push   %eax
  80022e:	52                   	push   %edx
  80022f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800235:	83 c0 08             	add    $0x8,%eax
  800238:	50                   	push   %eax
  800239:	e8 c7 0d 00 00       	call   801005 <sys_cputs>
  80023e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800241:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  800248:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80024e:	c9                   	leave  
  80024f:	c3                   	ret    

00800250 <cprintf>:

int cprintf(const char *fmt, ...) {
  800250:	55                   	push   %ebp
  800251:	89 e5                	mov    %esp,%ebp
  800253:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800256:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  80025d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800260:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800263:	8b 45 08             	mov    0x8(%ebp),%eax
  800266:	83 ec 08             	sub    $0x8,%esp
  800269:	ff 75 f4             	pushl  -0xc(%ebp)
  80026c:	50                   	push   %eax
  80026d:	e8 73 ff ff ff       	call   8001e5 <vcprintf>
  800272:	83 c4 10             	add    $0x10,%esp
  800275:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800278:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80027b:	c9                   	leave  
  80027c:	c3                   	ret    

0080027d <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80027d:	55                   	push   %ebp
  80027e:	89 e5                	mov    %esp,%ebp
  800280:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800283:	e8 8e 0f 00 00       	call   801216 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800288:	8d 45 0c             	lea    0xc(%ebp),%eax
  80028b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80028e:	8b 45 08             	mov    0x8(%ebp),%eax
  800291:	83 ec 08             	sub    $0x8,%esp
  800294:	ff 75 f4             	pushl  -0xc(%ebp)
  800297:	50                   	push   %eax
  800298:	e8 48 ff ff ff       	call   8001e5 <vcprintf>
  80029d:	83 c4 10             	add    $0x10,%esp
  8002a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002a3:	e8 88 0f 00 00       	call   801230 <sys_enable_interrupt>
	return cnt;
  8002a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002ab:	c9                   	leave  
  8002ac:	c3                   	ret    

008002ad <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002ad:	55                   	push   %ebp
  8002ae:	89 e5                	mov    %esp,%ebp
  8002b0:	53                   	push   %ebx
  8002b1:	83 ec 14             	sub    $0x14,%esp
  8002b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8002b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002ba:	8b 45 14             	mov    0x14(%ebp),%eax
  8002bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002c0:	8b 45 18             	mov    0x18(%ebp),%eax
  8002c3:	ba 00 00 00 00       	mov    $0x0,%edx
  8002c8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002cb:	77 55                	ja     800322 <printnum+0x75>
  8002cd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002d0:	72 05                	jb     8002d7 <printnum+0x2a>
  8002d2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002d5:	77 4b                	ja     800322 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8002d7:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8002da:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8002dd:	8b 45 18             	mov    0x18(%ebp),%eax
  8002e0:	ba 00 00 00 00       	mov    $0x0,%edx
  8002e5:	52                   	push   %edx
  8002e6:	50                   	push   %eax
  8002e7:	ff 75 f4             	pushl  -0xc(%ebp)
  8002ea:	ff 75 f0             	pushl  -0x10(%ebp)
  8002ed:	e8 62 13 00 00       	call   801654 <__udivdi3>
  8002f2:	83 c4 10             	add    $0x10,%esp
  8002f5:	83 ec 04             	sub    $0x4,%esp
  8002f8:	ff 75 20             	pushl  0x20(%ebp)
  8002fb:	53                   	push   %ebx
  8002fc:	ff 75 18             	pushl  0x18(%ebp)
  8002ff:	52                   	push   %edx
  800300:	50                   	push   %eax
  800301:	ff 75 0c             	pushl  0xc(%ebp)
  800304:	ff 75 08             	pushl  0x8(%ebp)
  800307:	e8 a1 ff ff ff       	call   8002ad <printnum>
  80030c:	83 c4 20             	add    $0x20,%esp
  80030f:	eb 1a                	jmp    80032b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800311:	83 ec 08             	sub    $0x8,%esp
  800314:	ff 75 0c             	pushl  0xc(%ebp)
  800317:	ff 75 20             	pushl  0x20(%ebp)
  80031a:	8b 45 08             	mov    0x8(%ebp),%eax
  80031d:	ff d0                	call   *%eax
  80031f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800322:	ff 4d 1c             	decl   0x1c(%ebp)
  800325:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800329:	7f e6                	jg     800311 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80032b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80032e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800333:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800336:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800339:	53                   	push   %ebx
  80033a:	51                   	push   %ecx
  80033b:	52                   	push   %edx
  80033c:	50                   	push   %eax
  80033d:	e8 22 14 00 00       	call   801764 <__umoddi3>
  800342:	83 c4 10             	add    $0x10,%esp
  800345:	05 d4 1b 80 00       	add    $0x801bd4,%eax
  80034a:	8a 00                	mov    (%eax),%al
  80034c:	0f be c0             	movsbl %al,%eax
  80034f:	83 ec 08             	sub    $0x8,%esp
  800352:	ff 75 0c             	pushl  0xc(%ebp)
  800355:	50                   	push   %eax
  800356:	8b 45 08             	mov    0x8(%ebp),%eax
  800359:	ff d0                	call   *%eax
  80035b:	83 c4 10             	add    $0x10,%esp
}
  80035e:	90                   	nop
  80035f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800362:	c9                   	leave  
  800363:	c3                   	ret    

00800364 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800364:	55                   	push   %ebp
  800365:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800367:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80036b:	7e 1c                	jle    800389 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80036d:	8b 45 08             	mov    0x8(%ebp),%eax
  800370:	8b 00                	mov    (%eax),%eax
  800372:	8d 50 08             	lea    0x8(%eax),%edx
  800375:	8b 45 08             	mov    0x8(%ebp),%eax
  800378:	89 10                	mov    %edx,(%eax)
  80037a:	8b 45 08             	mov    0x8(%ebp),%eax
  80037d:	8b 00                	mov    (%eax),%eax
  80037f:	83 e8 08             	sub    $0x8,%eax
  800382:	8b 50 04             	mov    0x4(%eax),%edx
  800385:	8b 00                	mov    (%eax),%eax
  800387:	eb 40                	jmp    8003c9 <getuint+0x65>
	else if (lflag)
  800389:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80038d:	74 1e                	je     8003ad <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80038f:	8b 45 08             	mov    0x8(%ebp),%eax
  800392:	8b 00                	mov    (%eax),%eax
  800394:	8d 50 04             	lea    0x4(%eax),%edx
  800397:	8b 45 08             	mov    0x8(%ebp),%eax
  80039a:	89 10                	mov    %edx,(%eax)
  80039c:	8b 45 08             	mov    0x8(%ebp),%eax
  80039f:	8b 00                	mov    (%eax),%eax
  8003a1:	83 e8 04             	sub    $0x4,%eax
  8003a4:	8b 00                	mov    (%eax),%eax
  8003a6:	ba 00 00 00 00       	mov    $0x0,%edx
  8003ab:	eb 1c                	jmp    8003c9 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b0:	8b 00                	mov    (%eax),%eax
  8003b2:	8d 50 04             	lea    0x4(%eax),%edx
  8003b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b8:	89 10                	mov    %edx,(%eax)
  8003ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bd:	8b 00                	mov    (%eax),%eax
  8003bf:	83 e8 04             	sub    $0x4,%eax
  8003c2:	8b 00                	mov    (%eax),%eax
  8003c4:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003c9:	5d                   	pop    %ebp
  8003ca:	c3                   	ret    

008003cb <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003cb:	55                   	push   %ebp
  8003cc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003ce:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003d2:	7e 1c                	jle    8003f0 <getint+0x25>
		return va_arg(*ap, long long);
  8003d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d7:	8b 00                	mov    (%eax),%eax
  8003d9:	8d 50 08             	lea    0x8(%eax),%edx
  8003dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003df:	89 10                	mov    %edx,(%eax)
  8003e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e4:	8b 00                	mov    (%eax),%eax
  8003e6:	83 e8 08             	sub    $0x8,%eax
  8003e9:	8b 50 04             	mov    0x4(%eax),%edx
  8003ec:	8b 00                	mov    (%eax),%eax
  8003ee:	eb 38                	jmp    800428 <getint+0x5d>
	else if (lflag)
  8003f0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003f4:	74 1a                	je     800410 <getint+0x45>
		return va_arg(*ap, long);
  8003f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f9:	8b 00                	mov    (%eax),%eax
  8003fb:	8d 50 04             	lea    0x4(%eax),%edx
  8003fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800401:	89 10                	mov    %edx,(%eax)
  800403:	8b 45 08             	mov    0x8(%ebp),%eax
  800406:	8b 00                	mov    (%eax),%eax
  800408:	83 e8 04             	sub    $0x4,%eax
  80040b:	8b 00                	mov    (%eax),%eax
  80040d:	99                   	cltd   
  80040e:	eb 18                	jmp    800428 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800410:	8b 45 08             	mov    0x8(%ebp),%eax
  800413:	8b 00                	mov    (%eax),%eax
  800415:	8d 50 04             	lea    0x4(%eax),%edx
  800418:	8b 45 08             	mov    0x8(%ebp),%eax
  80041b:	89 10                	mov    %edx,(%eax)
  80041d:	8b 45 08             	mov    0x8(%ebp),%eax
  800420:	8b 00                	mov    (%eax),%eax
  800422:	83 e8 04             	sub    $0x4,%eax
  800425:	8b 00                	mov    (%eax),%eax
  800427:	99                   	cltd   
}
  800428:	5d                   	pop    %ebp
  800429:	c3                   	ret    

0080042a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80042a:	55                   	push   %ebp
  80042b:	89 e5                	mov    %esp,%ebp
  80042d:	56                   	push   %esi
  80042e:	53                   	push   %ebx
  80042f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800432:	eb 17                	jmp    80044b <vprintfmt+0x21>
			if (ch == '\0')
  800434:	85 db                	test   %ebx,%ebx
  800436:	0f 84 af 03 00 00    	je     8007eb <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80043c:	83 ec 08             	sub    $0x8,%esp
  80043f:	ff 75 0c             	pushl  0xc(%ebp)
  800442:	53                   	push   %ebx
  800443:	8b 45 08             	mov    0x8(%ebp),%eax
  800446:	ff d0                	call   *%eax
  800448:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80044b:	8b 45 10             	mov    0x10(%ebp),%eax
  80044e:	8d 50 01             	lea    0x1(%eax),%edx
  800451:	89 55 10             	mov    %edx,0x10(%ebp)
  800454:	8a 00                	mov    (%eax),%al
  800456:	0f b6 d8             	movzbl %al,%ebx
  800459:	83 fb 25             	cmp    $0x25,%ebx
  80045c:	75 d6                	jne    800434 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80045e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800462:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800469:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800470:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800477:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80047e:	8b 45 10             	mov    0x10(%ebp),%eax
  800481:	8d 50 01             	lea    0x1(%eax),%edx
  800484:	89 55 10             	mov    %edx,0x10(%ebp)
  800487:	8a 00                	mov    (%eax),%al
  800489:	0f b6 d8             	movzbl %al,%ebx
  80048c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80048f:	83 f8 55             	cmp    $0x55,%eax
  800492:	0f 87 2b 03 00 00    	ja     8007c3 <vprintfmt+0x399>
  800498:	8b 04 85 f8 1b 80 00 	mov    0x801bf8(,%eax,4),%eax
  80049f:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004a1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004a5:	eb d7                	jmp    80047e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004a7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004ab:	eb d1                	jmp    80047e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004ad:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004b4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004b7:	89 d0                	mov    %edx,%eax
  8004b9:	c1 e0 02             	shl    $0x2,%eax
  8004bc:	01 d0                	add    %edx,%eax
  8004be:	01 c0                	add    %eax,%eax
  8004c0:	01 d8                	add    %ebx,%eax
  8004c2:	83 e8 30             	sub    $0x30,%eax
  8004c5:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8004cb:	8a 00                	mov    (%eax),%al
  8004cd:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004d0:	83 fb 2f             	cmp    $0x2f,%ebx
  8004d3:	7e 3e                	jle    800513 <vprintfmt+0xe9>
  8004d5:	83 fb 39             	cmp    $0x39,%ebx
  8004d8:	7f 39                	jg     800513 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004da:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8004dd:	eb d5                	jmp    8004b4 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8004df:	8b 45 14             	mov    0x14(%ebp),%eax
  8004e2:	83 c0 04             	add    $0x4,%eax
  8004e5:	89 45 14             	mov    %eax,0x14(%ebp)
  8004e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8004eb:	83 e8 04             	sub    $0x4,%eax
  8004ee:	8b 00                	mov    (%eax),%eax
  8004f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8004f3:	eb 1f                	jmp    800514 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8004f5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8004f9:	79 83                	jns    80047e <vprintfmt+0x54>
				width = 0;
  8004fb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800502:	e9 77 ff ff ff       	jmp    80047e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800507:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80050e:	e9 6b ff ff ff       	jmp    80047e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800513:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800514:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800518:	0f 89 60 ff ff ff    	jns    80047e <vprintfmt+0x54>
				width = precision, precision = -1;
  80051e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800521:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800524:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80052b:	e9 4e ff ff ff       	jmp    80047e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800530:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800533:	e9 46 ff ff ff       	jmp    80047e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800538:	8b 45 14             	mov    0x14(%ebp),%eax
  80053b:	83 c0 04             	add    $0x4,%eax
  80053e:	89 45 14             	mov    %eax,0x14(%ebp)
  800541:	8b 45 14             	mov    0x14(%ebp),%eax
  800544:	83 e8 04             	sub    $0x4,%eax
  800547:	8b 00                	mov    (%eax),%eax
  800549:	83 ec 08             	sub    $0x8,%esp
  80054c:	ff 75 0c             	pushl  0xc(%ebp)
  80054f:	50                   	push   %eax
  800550:	8b 45 08             	mov    0x8(%ebp),%eax
  800553:	ff d0                	call   *%eax
  800555:	83 c4 10             	add    $0x10,%esp
			break;
  800558:	e9 89 02 00 00       	jmp    8007e6 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80055d:	8b 45 14             	mov    0x14(%ebp),%eax
  800560:	83 c0 04             	add    $0x4,%eax
  800563:	89 45 14             	mov    %eax,0x14(%ebp)
  800566:	8b 45 14             	mov    0x14(%ebp),%eax
  800569:	83 e8 04             	sub    $0x4,%eax
  80056c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80056e:	85 db                	test   %ebx,%ebx
  800570:	79 02                	jns    800574 <vprintfmt+0x14a>
				err = -err;
  800572:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800574:	83 fb 64             	cmp    $0x64,%ebx
  800577:	7f 0b                	jg     800584 <vprintfmt+0x15a>
  800579:	8b 34 9d 40 1a 80 00 	mov    0x801a40(,%ebx,4),%esi
  800580:	85 f6                	test   %esi,%esi
  800582:	75 19                	jne    80059d <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800584:	53                   	push   %ebx
  800585:	68 e5 1b 80 00       	push   $0x801be5
  80058a:	ff 75 0c             	pushl  0xc(%ebp)
  80058d:	ff 75 08             	pushl  0x8(%ebp)
  800590:	e8 5e 02 00 00       	call   8007f3 <printfmt>
  800595:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800598:	e9 49 02 00 00       	jmp    8007e6 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80059d:	56                   	push   %esi
  80059e:	68 ee 1b 80 00       	push   $0x801bee
  8005a3:	ff 75 0c             	pushl  0xc(%ebp)
  8005a6:	ff 75 08             	pushl  0x8(%ebp)
  8005a9:	e8 45 02 00 00       	call   8007f3 <printfmt>
  8005ae:	83 c4 10             	add    $0x10,%esp
			break;
  8005b1:	e9 30 02 00 00       	jmp    8007e6 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b9:	83 c0 04             	add    $0x4,%eax
  8005bc:	89 45 14             	mov    %eax,0x14(%ebp)
  8005bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c2:	83 e8 04             	sub    $0x4,%eax
  8005c5:	8b 30                	mov    (%eax),%esi
  8005c7:	85 f6                	test   %esi,%esi
  8005c9:	75 05                	jne    8005d0 <vprintfmt+0x1a6>
				p = "(null)";
  8005cb:	be f1 1b 80 00       	mov    $0x801bf1,%esi
			if (width > 0 && padc != '-')
  8005d0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005d4:	7e 6d                	jle    800643 <vprintfmt+0x219>
  8005d6:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8005da:	74 67                	je     800643 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8005dc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005df:	83 ec 08             	sub    $0x8,%esp
  8005e2:	50                   	push   %eax
  8005e3:	56                   	push   %esi
  8005e4:	e8 0c 03 00 00       	call   8008f5 <strnlen>
  8005e9:	83 c4 10             	add    $0x10,%esp
  8005ec:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8005ef:	eb 16                	jmp    800607 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8005f1:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8005f5:	83 ec 08             	sub    $0x8,%esp
  8005f8:	ff 75 0c             	pushl  0xc(%ebp)
  8005fb:	50                   	push   %eax
  8005fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ff:	ff d0                	call   *%eax
  800601:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800604:	ff 4d e4             	decl   -0x1c(%ebp)
  800607:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80060b:	7f e4                	jg     8005f1 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80060d:	eb 34                	jmp    800643 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80060f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800613:	74 1c                	je     800631 <vprintfmt+0x207>
  800615:	83 fb 1f             	cmp    $0x1f,%ebx
  800618:	7e 05                	jle    80061f <vprintfmt+0x1f5>
  80061a:	83 fb 7e             	cmp    $0x7e,%ebx
  80061d:	7e 12                	jle    800631 <vprintfmt+0x207>
					putch('?', putdat);
  80061f:	83 ec 08             	sub    $0x8,%esp
  800622:	ff 75 0c             	pushl  0xc(%ebp)
  800625:	6a 3f                	push   $0x3f
  800627:	8b 45 08             	mov    0x8(%ebp),%eax
  80062a:	ff d0                	call   *%eax
  80062c:	83 c4 10             	add    $0x10,%esp
  80062f:	eb 0f                	jmp    800640 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800631:	83 ec 08             	sub    $0x8,%esp
  800634:	ff 75 0c             	pushl  0xc(%ebp)
  800637:	53                   	push   %ebx
  800638:	8b 45 08             	mov    0x8(%ebp),%eax
  80063b:	ff d0                	call   *%eax
  80063d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800640:	ff 4d e4             	decl   -0x1c(%ebp)
  800643:	89 f0                	mov    %esi,%eax
  800645:	8d 70 01             	lea    0x1(%eax),%esi
  800648:	8a 00                	mov    (%eax),%al
  80064a:	0f be d8             	movsbl %al,%ebx
  80064d:	85 db                	test   %ebx,%ebx
  80064f:	74 24                	je     800675 <vprintfmt+0x24b>
  800651:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800655:	78 b8                	js     80060f <vprintfmt+0x1e5>
  800657:	ff 4d e0             	decl   -0x20(%ebp)
  80065a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80065e:	79 af                	jns    80060f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800660:	eb 13                	jmp    800675 <vprintfmt+0x24b>
				putch(' ', putdat);
  800662:	83 ec 08             	sub    $0x8,%esp
  800665:	ff 75 0c             	pushl  0xc(%ebp)
  800668:	6a 20                	push   $0x20
  80066a:	8b 45 08             	mov    0x8(%ebp),%eax
  80066d:	ff d0                	call   *%eax
  80066f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800672:	ff 4d e4             	decl   -0x1c(%ebp)
  800675:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800679:	7f e7                	jg     800662 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80067b:	e9 66 01 00 00       	jmp    8007e6 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800680:	83 ec 08             	sub    $0x8,%esp
  800683:	ff 75 e8             	pushl  -0x18(%ebp)
  800686:	8d 45 14             	lea    0x14(%ebp),%eax
  800689:	50                   	push   %eax
  80068a:	e8 3c fd ff ff       	call   8003cb <getint>
  80068f:	83 c4 10             	add    $0x10,%esp
  800692:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800695:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800698:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80069b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80069e:	85 d2                	test   %edx,%edx
  8006a0:	79 23                	jns    8006c5 <vprintfmt+0x29b>
				putch('-', putdat);
  8006a2:	83 ec 08             	sub    $0x8,%esp
  8006a5:	ff 75 0c             	pushl  0xc(%ebp)
  8006a8:	6a 2d                	push   $0x2d
  8006aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ad:	ff d0                	call   *%eax
  8006af:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006b8:	f7 d8                	neg    %eax
  8006ba:	83 d2 00             	adc    $0x0,%edx
  8006bd:	f7 da                	neg    %edx
  8006bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006c2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006c5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006cc:	e9 bc 00 00 00       	jmp    80078d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006d1:	83 ec 08             	sub    $0x8,%esp
  8006d4:	ff 75 e8             	pushl  -0x18(%ebp)
  8006d7:	8d 45 14             	lea    0x14(%ebp),%eax
  8006da:	50                   	push   %eax
  8006db:	e8 84 fc ff ff       	call   800364 <getuint>
  8006e0:	83 c4 10             	add    $0x10,%esp
  8006e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006e6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8006e9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006f0:	e9 98 00 00 00       	jmp    80078d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8006f5:	83 ec 08             	sub    $0x8,%esp
  8006f8:	ff 75 0c             	pushl  0xc(%ebp)
  8006fb:	6a 58                	push   $0x58
  8006fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800700:	ff d0                	call   *%eax
  800702:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800705:	83 ec 08             	sub    $0x8,%esp
  800708:	ff 75 0c             	pushl  0xc(%ebp)
  80070b:	6a 58                	push   $0x58
  80070d:	8b 45 08             	mov    0x8(%ebp),%eax
  800710:	ff d0                	call   *%eax
  800712:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800715:	83 ec 08             	sub    $0x8,%esp
  800718:	ff 75 0c             	pushl  0xc(%ebp)
  80071b:	6a 58                	push   $0x58
  80071d:	8b 45 08             	mov    0x8(%ebp),%eax
  800720:	ff d0                	call   *%eax
  800722:	83 c4 10             	add    $0x10,%esp
			break;
  800725:	e9 bc 00 00 00       	jmp    8007e6 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80072a:	83 ec 08             	sub    $0x8,%esp
  80072d:	ff 75 0c             	pushl  0xc(%ebp)
  800730:	6a 30                	push   $0x30
  800732:	8b 45 08             	mov    0x8(%ebp),%eax
  800735:	ff d0                	call   *%eax
  800737:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80073a:	83 ec 08             	sub    $0x8,%esp
  80073d:	ff 75 0c             	pushl  0xc(%ebp)
  800740:	6a 78                	push   $0x78
  800742:	8b 45 08             	mov    0x8(%ebp),%eax
  800745:	ff d0                	call   *%eax
  800747:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80074a:	8b 45 14             	mov    0x14(%ebp),%eax
  80074d:	83 c0 04             	add    $0x4,%eax
  800750:	89 45 14             	mov    %eax,0x14(%ebp)
  800753:	8b 45 14             	mov    0x14(%ebp),%eax
  800756:	83 e8 04             	sub    $0x4,%eax
  800759:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80075b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80075e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800765:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80076c:	eb 1f                	jmp    80078d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80076e:	83 ec 08             	sub    $0x8,%esp
  800771:	ff 75 e8             	pushl  -0x18(%ebp)
  800774:	8d 45 14             	lea    0x14(%ebp),%eax
  800777:	50                   	push   %eax
  800778:	e8 e7 fb ff ff       	call   800364 <getuint>
  80077d:	83 c4 10             	add    $0x10,%esp
  800780:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800783:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800786:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80078d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800791:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800794:	83 ec 04             	sub    $0x4,%esp
  800797:	52                   	push   %edx
  800798:	ff 75 e4             	pushl  -0x1c(%ebp)
  80079b:	50                   	push   %eax
  80079c:	ff 75 f4             	pushl  -0xc(%ebp)
  80079f:	ff 75 f0             	pushl  -0x10(%ebp)
  8007a2:	ff 75 0c             	pushl  0xc(%ebp)
  8007a5:	ff 75 08             	pushl  0x8(%ebp)
  8007a8:	e8 00 fb ff ff       	call   8002ad <printnum>
  8007ad:	83 c4 20             	add    $0x20,%esp
			break;
  8007b0:	eb 34                	jmp    8007e6 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007b2:	83 ec 08             	sub    $0x8,%esp
  8007b5:	ff 75 0c             	pushl  0xc(%ebp)
  8007b8:	53                   	push   %ebx
  8007b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bc:	ff d0                	call   *%eax
  8007be:	83 c4 10             	add    $0x10,%esp
			break;
  8007c1:	eb 23                	jmp    8007e6 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007c3:	83 ec 08             	sub    $0x8,%esp
  8007c6:	ff 75 0c             	pushl  0xc(%ebp)
  8007c9:	6a 25                	push   $0x25
  8007cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ce:	ff d0                	call   *%eax
  8007d0:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007d3:	ff 4d 10             	decl   0x10(%ebp)
  8007d6:	eb 03                	jmp    8007db <vprintfmt+0x3b1>
  8007d8:	ff 4d 10             	decl   0x10(%ebp)
  8007db:	8b 45 10             	mov    0x10(%ebp),%eax
  8007de:	48                   	dec    %eax
  8007df:	8a 00                	mov    (%eax),%al
  8007e1:	3c 25                	cmp    $0x25,%al
  8007e3:	75 f3                	jne    8007d8 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8007e5:	90                   	nop
		}
	}
  8007e6:	e9 47 fc ff ff       	jmp    800432 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8007eb:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8007ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8007ef:	5b                   	pop    %ebx
  8007f0:	5e                   	pop    %esi
  8007f1:	5d                   	pop    %ebp
  8007f2:	c3                   	ret    

008007f3 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8007f3:	55                   	push   %ebp
  8007f4:	89 e5                	mov    %esp,%ebp
  8007f6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8007f9:	8d 45 10             	lea    0x10(%ebp),%eax
  8007fc:	83 c0 04             	add    $0x4,%eax
  8007ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800802:	8b 45 10             	mov    0x10(%ebp),%eax
  800805:	ff 75 f4             	pushl  -0xc(%ebp)
  800808:	50                   	push   %eax
  800809:	ff 75 0c             	pushl  0xc(%ebp)
  80080c:	ff 75 08             	pushl  0x8(%ebp)
  80080f:	e8 16 fc ff ff       	call   80042a <vprintfmt>
  800814:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800817:	90                   	nop
  800818:	c9                   	leave  
  800819:	c3                   	ret    

0080081a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80081a:	55                   	push   %ebp
  80081b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80081d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800820:	8b 40 08             	mov    0x8(%eax),%eax
  800823:	8d 50 01             	lea    0x1(%eax),%edx
  800826:	8b 45 0c             	mov    0xc(%ebp),%eax
  800829:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80082c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80082f:	8b 10                	mov    (%eax),%edx
  800831:	8b 45 0c             	mov    0xc(%ebp),%eax
  800834:	8b 40 04             	mov    0x4(%eax),%eax
  800837:	39 c2                	cmp    %eax,%edx
  800839:	73 12                	jae    80084d <sprintputch+0x33>
		*b->buf++ = ch;
  80083b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80083e:	8b 00                	mov    (%eax),%eax
  800840:	8d 48 01             	lea    0x1(%eax),%ecx
  800843:	8b 55 0c             	mov    0xc(%ebp),%edx
  800846:	89 0a                	mov    %ecx,(%edx)
  800848:	8b 55 08             	mov    0x8(%ebp),%edx
  80084b:	88 10                	mov    %dl,(%eax)
}
  80084d:	90                   	nop
  80084e:	5d                   	pop    %ebp
  80084f:	c3                   	ret    

00800850 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800850:	55                   	push   %ebp
  800851:	89 e5                	mov    %esp,%ebp
  800853:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800856:	8b 45 08             	mov    0x8(%ebp),%eax
  800859:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80085c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80085f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800862:	8b 45 08             	mov    0x8(%ebp),%eax
  800865:	01 d0                	add    %edx,%eax
  800867:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80086a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800871:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800875:	74 06                	je     80087d <vsnprintf+0x2d>
  800877:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80087b:	7f 07                	jg     800884 <vsnprintf+0x34>
		return -E_INVAL;
  80087d:	b8 03 00 00 00       	mov    $0x3,%eax
  800882:	eb 20                	jmp    8008a4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800884:	ff 75 14             	pushl  0x14(%ebp)
  800887:	ff 75 10             	pushl  0x10(%ebp)
  80088a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80088d:	50                   	push   %eax
  80088e:	68 1a 08 80 00       	push   $0x80081a
  800893:	e8 92 fb ff ff       	call   80042a <vprintfmt>
  800898:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80089b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80089e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008a4:	c9                   	leave  
  8008a5:	c3                   	ret    

008008a6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008a6:	55                   	push   %ebp
  8008a7:	89 e5                	mov    %esp,%ebp
  8008a9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008ac:	8d 45 10             	lea    0x10(%ebp),%eax
  8008af:	83 c0 04             	add    $0x4,%eax
  8008b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8008b8:	ff 75 f4             	pushl  -0xc(%ebp)
  8008bb:	50                   	push   %eax
  8008bc:	ff 75 0c             	pushl  0xc(%ebp)
  8008bf:	ff 75 08             	pushl  0x8(%ebp)
  8008c2:	e8 89 ff ff ff       	call   800850 <vsnprintf>
  8008c7:	83 c4 10             	add    $0x10,%esp
  8008ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008d0:	c9                   	leave  
  8008d1:	c3                   	ret    

008008d2 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008d2:	55                   	push   %ebp
  8008d3:	89 e5                	mov    %esp,%ebp
  8008d5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8008d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008df:	eb 06                	jmp    8008e7 <strlen+0x15>
		n++;
  8008e1:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8008e4:	ff 45 08             	incl   0x8(%ebp)
  8008e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ea:	8a 00                	mov    (%eax),%al
  8008ec:	84 c0                	test   %al,%al
  8008ee:	75 f1                	jne    8008e1 <strlen+0xf>
		n++;
	return n;
  8008f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8008f3:	c9                   	leave  
  8008f4:	c3                   	ret    

008008f5 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8008f5:	55                   	push   %ebp
  8008f6:	89 e5                	mov    %esp,%ebp
  8008f8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008fb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800902:	eb 09                	jmp    80090d <strnlen+0x18>
		n++;
  800904:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800907:	ff 45 08             	incl   0x8(%ebp)
  80090a:	ff 4d 0c             	decl   0xc(%ebp)
  80090d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800911:	74 09                	je     80091c <strnlen+0x27>
  800913:	8b 45 08             	mov    0x8(%ebp),%eax
  800916:	8a 00                	mov    (%eax),%al
  800918:	84 c0                	test   %al,%al
  80091a:	75 e8                	jne    800904 <strnlen+0xf>
		n++;
	return n;
  80091c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80091f:	c9                   	leave  
  800920:	c3                   	ret    

00800921 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800921:	55                   	push   %ebp
  800922:	89 e5                	mov    %esp,%ebp
  800924:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800927:	8b 45 08             	mov    0x8(%ebp),%eax
  80092a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80092d:	90                   	nop
  80092e:	8b 45 08             	mov    0x8(%ebp),%eax
  800931:	8d 50 01             	lea    0x1(%eax),%edx
  800934:	89 55 08             	mov    %edx,0x8(%ebp)
  800937:	8b 55 0c             	mov    0xc(%ebp),%edx
  80093a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80093d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800940:	8a 12                	mov    (%edx),%dl
  800942:	88 10                	mov    %dl,(%eax)
  800944:	8a 00                	mov    (%eax),%al
  800946:	84 c0                	test   %al,%al
  800948:	75 e4                	jne    80092e <strcpy+0xd>
		/* do nothing */;
	return ret;
  80094a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80094d:	c9                   	leave  
  80094e:	c3                   	ret    

0080094f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80094f:	55                   	push   %ebp
  800950:	89 e5                	mov    %esp,%ebp
  800952:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800955:	8b 45 08             	mov    0x8(%ebp),%eax
  800958:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80095b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800962:	eb 1f                	jmp    800983 <strncpy+0x34>
		*dst++ = *src;
  800964:	8b 45 08             	mov    0x8(%ebp),%eax
  800967:	8d 50 01             	lea    0x1(%eax),%edx
  80096a:	89 55 08             	mov    %edx,0x8(%ebp)
  80096d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800970:	8a 12                	mov    (%edx),%dl
  800972:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800974:	8b 45 0c             	mov    0xc(%ebp),%eax
  800977:	8a 00                	mov    (%eax),%al
  800979:	84 c0                	test   %al,%al
  80097b:	74 03                	je     800980 <strncpy+0x31>
			src++;
  80097d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800980:	ff 45 fc             	incl   -0x4(%ebp)
  800983:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800986:	3b 45 10             	cmp    0x10(%ebp),%eax
  800989:	72 d9                	jb     800964 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80098b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80098e:	c9                   	leave  
  80098f:	c3                   	ret    

00800990 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800990:	55                   	push   %ebp
  800991:	89 e5                	mov    %esp,%ebp
  800993:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800996:	8b 45 08             	mov    0x8(%ebp),%eax
  800999:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80099c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009a0:	74 30                	je     8009d2 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009a2:	eb 16                	jmp    8009ba <strlcpy+0x2a>
			*dst++ = *src++;
  8009a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a7:	8d 50 01             	lea    0x1(%eax),%edx
  8009aa:	89 55 08             	mov    %edx,0x8(%ebp)
  8009ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009b0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009b3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009b6:	8a 12                	mov    (%edx),%dl
  8009b8:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009ba:	ff 4d 10             	decl   0x10(%ebp)
  8009bd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009c1:	74 09                	je     8009cc <strlcpy+0x3c>
  8009c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c6:	8a 00                	mov    (%eax),%al
  8009c8:	84 c0                	test   %al,%al
  8009ca:	75 d8                	jne    8009a4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cf:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009d2:	8b 55 08             	mov    0x8(%ebp),%edx
  8009d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009d8:	29 c2                	sub    %eax,%edx
  8009da:	89 d0                	mov    %edx,%eax
}
  8009dc:	c9                   	leave  
  8009dd:	c3                   	ret    

008009de <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8009de:	55                   	push   %ebp
  8009df:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8009e1:	eb 06                	jmp    8009e9 <strcmp+0xb>
		p++, q++;
  8009e3:	ff 45 08             	incl   0x8(%ebp)
  8009e6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8009e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ec:	8a 00                	mov    (%eax),%al
  8009ee:	84 c0                	test   %al,%al
  8009f0:	74 0e                	je     800a00 <strcmp+0x22>
  8009f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f5:	8a 10                	mov    (%eax),%dl
  8009f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009fa:	8a 00                	mov    (%eax),%al
  8009fc:	38 c2                	cmp    %al,%dl
  8009fe:	74 e3                	je     8009e3 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a00:	8b 45 08             	mov    0x8(%ebp),%eax
  800a03:	8a 00                	mov    (%eax),%al
  800a05:	0f b6 d0             	movzbl %al,%edx
  800a08:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a0b:	8a 00                	mov    (%eax),%al
  800a0d:	0f b6 c0             	movzbl %al,%eax
  800a10:	29 c2                	sub    %eax,%edx
  800a12:	89 d0                	mov    %edx,%eax
}
  800a14:	5d                   	pop    %ebp
  800a15:	c3                   	ret    

00800a16 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a16:	55                   	push   %ebp
  800a17:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a19:	eb 09                	jmp    800a24 <strncmp+0xe>
		n--, p++, q++;
  800a1b:	ff 4d 10             	decl   0x10(%ebp)
  800a1e:	ff 45 08             	incl   0x8(%ebp)
  800a21:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a24:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a28:	74 17                	je     800a41 <strncmp+0x2b>
  800a2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2d:	8a 00                	mov    (%eax),%al
  800a2f:	84 c0                	test   %al,%al
  800a31:	74 0e                	je     800a41 <strncmp+0x2b>
  800a33:	8b 45 08             	mov    0x8(%ebp),%eax
  800a36:	8a 10                	mov    (%eax),%dl
  800a38:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3b:	8a 00                	mov    (%eax),%al
  800a3d:	38 c2                	cmp    %al,%dl
  800a3f:	74 da                	je     800a1b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a41:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a45:	75 07                	jne    800a4e <strncmp+0x38>
		return 0;
  800a47:	b8 00 00 00 00       	mov    $0x0,%eax
  800a4c:	eb 14                	jmp    800a62 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a51:	8a 00                	mov    (%eax),%al
  800a53:	0f b6 d0             	movzbl %al,%edx
  800a56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a59:	8a 00                	mov    (%eax),%al
  800a5b:	0f b6 c0             	movzbl %al,%eax
  800a5e:	29 c2                	sub    %eax,%edx
  800a60:	89 d0                	mov    %edx,%eax
}
  800a62:	5d                   	pop    %ebp
  800a63:	c3                   	ret    

00800a64 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a64:	55                   	push   %ebp
  800a65:	89 e5                	mov    %esp,%ebp
  800a67:	83 ec 04             	sub    $0x4,%esp
  800a6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a70:	eb 12                	jmp    800a84 <strchr+0x20>
		if (*s == c)
  800a72:	8b 45 08             	mov    0x8(%ebp),%eax
  800a75:	8a 00                	mov    (%eax),%al
  800a77:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a7a:	75 05                	jne    800a81 <strchr+0x1d>
			return (char *) s;
  800a7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7f:	eb 11                	jmp    800a92 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800a81:	ff 45 08             	incl   0x8(%ebp)
  800a84:	8b 45 08             	mov    0x8(%ebp),%eax
  800a87:	8a 00                	mov    (%eax),%al
  800a89:	84 c0                	test   %al,%al
  800a8b:	75 e5                	jne    800a72 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800a8d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800a92:	c9                   	leave  
  800a93:	c3                   	ret    

00800a94 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800a94:	55                   	push   %ebp
  800a95:	89 e5                	mov    %esp,%ebp
  800a97:	83 ec 04             	sub    $0x4,%esp
  800a9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800aa0:	eb 0d                	jmp    800aaf <strfind+0x1b>
		if (*s == c)
  800aa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa5:	8a 00                	mov    (%eax),%al
  800aa7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800aaa:	74 0e                	je     800aba <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800aac:	ff 45 08             	incl   0x8(%ebp)
  800aaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab2:	8a 00                	mov    (%eax),%al
  800ab4:	84 c0                	test   %al,%al
  800ab6:	75 ea                	jne    800aa2 <strfind+0xe>
  800ab8:	eb 01                	jmp    800abb <strfind+0x27>
		if (*s == c)
			break;
  800aba:	90                   	nop
	return (char *) s;
  800abb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800abe:	c9                   	leave  
  800abf:	c3                   	ret    

00800ac0 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ac0:	55                   	push   %ebp
  800ac1:	89 e5                	mov    %esp,%ebp
  800ac3:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800acc:	8b 45 10             	mov    0x10(%ebp),%eax
  800acf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ad2:	eb 0e                	jmp    800ae2 <memset+0x22>
		*p++ = c;
  800ad4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ad7:	8d 50 01             	lea    0x1(%eax),%edx
  800ada:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800add:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae0:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ae2:	ff 4d f8             	decl   -0x8(%ebp)
  800ae5:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ae9:	79 e9                	jns    800ad4 <memset+0x14>
		*p++ = c;

	return v;
  800aeb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800aee:	c9                   	leave  
  800aef:	c3                   	ret    

00800af0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800af0:	55                   	push   %ebp
  800af1:	89 e5                	mov    %esp,%ebp
  800af3:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800af6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800afc:	8b 45 08             	mov    0x8(%ebp),%eax
  800aff:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b02:	eb 16                	jmp    800b1a <memcpy+0x2a>
		*d++ = *s++;
  800b04:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b07:	8d 50 01             	lea    0x1(%eax),%edx
  800b0a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b0d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b10:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b13:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b16:	8a 12                	mov    (%edx),%dl
  800b18:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b1a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b1d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b20:	89 55 10             	mov    %edx,0x10(%ebp)
  800b23:	85 c0                	test   %eax,%eax
  800b25:	75 dd                	jne    800b04 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b27:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b2a:	c9                   	leave  
  800b2b:	c3                   	ret    

00800b2c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b2c:	55                   	push   %ebp
  800b2d:	89 e5                	mov    %esp,%ebp
  800b2f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b35:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b38:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b3e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b41:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b44:	73 50                	jae    800b96 <memmove+0x6a>
  800b46:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b49:	8b 45 10             	mov    0x10(%ebp),%eax
  800b4c:	01 d0                	add    %edx,%eax
  800b4e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b51:	76 43                	jbe    800b96 <memmove+0x6a>
		s += n;
  800b53:	8b 45 10             	mov    0x10(%ebp),%eax
  800b56:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b59:	8b 45 10             	mov    0x10(%ebp),%eax
  800b5c:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b5f:	eb 10                	jmp    800b71 <memmove+0x45>
			*--d = *--s;
  800b61:	ff 4d f8             	decl   -0x8(%ebp)
  800b64:	ff 4d fc             	decl   -0x4(%ebp)
  800b67:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b6a:	8a 10                	mov    (%eax),%dl
  800b6c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b6f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b71:	8b 45 10             	mov    0x10(%ebp),%eax
  800b74:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b77:	89 55 10             	mov    %edx,0x10(%ebp)
  800b7a:	85 c0                	test   %eax,%eax
  800b7c:	75 e3                	jne    800b61 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800b7e:	eb 23                	jmp    800ba3 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800b80:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b83:	8d 50 01             	lea    0x1(%eax),%edx
  800b86:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b89:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b8c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b8f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b92:	8a 12                	mov    (%edx),%dl
  800b94:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800b96:	8b 45 10             	mov    0x10(%ebp),%eax
  800b99:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b9c:	89 55 10             	mov    %edx,0x10(%ebp)
  800b9f:	85 c0                	test   %eax,%eax
  800ba1:	75 dd                	jne    800b80 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ba3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ba6:	c9                   	leave  
  800ba7:	c3                   	ret    

00800ba8 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ba8:	55                   	push   %ebp
  800ba9:	89 e5                	mov    %esp,%ebp
  800bab:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bae:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb7:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bba:	eb 2a                	jmp    800be6 <memcmp+0x3e>
		if (*s1 != *s2)
  800bbc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bbf:	8a 10                	mov    (%eax),%dl
  800bc1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bc4:	8a 00                	mov    (%eax),%al
  800bc6:	38 c2                	cmp    %al,%dl
  800bc8:	74 16                	je     800be0 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bcd:	8a 00                	mov    (%eax),%al
  800bcf:	0f b6 d0             	movzbl %al,%edx
  800bd2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bd5:	8a 00                	mov    (%eax),%al
  800bd7:	0f b6 c0             	movzbl %al,%eax
  800bda:	29 c2                	sub    %eax,%edx
  800bdc:	89 d0                	mov    %edx,%eax
  800bde:	eb 18                	jmp    800bf8 <memcmp+0x50>
		s1++, s2++;
  800be0:	ff 45 fc             	incl   -0x4(%ebp)
  800be3:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800be6:	8b 45 10             	mov    0x10(%ebp),%eax
  800be9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bec:	89 55 10             	mov    %edx,0x10(%ebp)
  800bef:	85 c0                	test   %eax,%eax
  800bf1:	75 c9                	jne    800bbc <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800bf3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800bf8:	c9                   	leave  
  800bf9:	c3                   	ret    

00800bfa <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800bfa:	55                   	push   %ebp
  800bfb:	89 e5                	mov    %esp,%ebp
  800bfd:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c00:	8b 55 08             	mov    0x8(%ebp),%edx
  800c03:	8b 45 10             	mov    0x10(%ebp),%eax
  800c06:	01 d0                	add    %edx,%eax
  800c08:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c0b:	eb 15                	jmp    800c22 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c10:	8a 00                	mov    (%eax),%al
  800c12:	0f b6 d0             	movzbl %al,%edx
  800c15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c18:	0f b6 c0             	movzbl %al,%eax
  800c1b:	39 c2                	cmp    %eax,%edx
  800c1d:	74 0d                	je     800c2c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c1f:	ff 45 08             	incl   0x8(%ebp)
  800c22:	8b 45 08             	mov    0x8(%ebp),%eax
  800c25:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c28:	72 e3                	jb     800c0d <memfind+0x13>
  800c2a:	eb 01                	jmp    800c2d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c2c:	90                   	nop
	return (void *) s;
  800c2d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c30:	c9                   	leave  
  800c31:	c3                   	ret    

00800c32 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c32:	55                   	push   %ebp
  800c33:	89 e5                	mov    %esp,%ebp
  800c35:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c38:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c3f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c46:	eb 03                	jmp    800c4b <strtol+0x19>
		s++;
  800c48:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4e:	8a 00                	mov    (%eax),%al
  800c50:	3c 20                	cmp    $0x20,%al
  800c52:	74 f4                	je     800c48 <strtol+0x16>
  800c54:	8b 45 08             	mov    0x8(%ebp),%eax
  800c57:	8a 00                	mov    (%eax),%al
  800c59:	3c 09                	cmp    $0x9,%al
  800c5b:	74 eb                	je     800c48 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c60:	8a 00                	mov    (%eax),%al
  800c62:	3c 2b                	cmp    $0x2b,%al
  800c64:	75 05                	jne    800c6b <strtol+0x39>
		s++;
  800c66:	ff 45 08             	incl   0x8(%ebp)
  800c69:	eb 13                	jmp    800c7e <strtol+0x4c>
	else if (*s == '-')
  800c6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6e:	8a 00                	mov    (%eax),%al
  800c70:	3c 2d                	cmp    $0x2d,%al
  800c72:	75 0a                	jne    800c7e <strtol+0x4c>
		s++, neg = 1;
  800c74:	ff 45 08             	incl   0x8(%ebp)
  800c77:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800c7e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c82:	74 06                	je     800c8a <strtol+0x58>
  800c84:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800c88:	75 20                	jne    800caa <strtol+0x78>
  800c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8d:	8a 00                	mov    (%eax),%al
  800c8f:	3c 30                	cmp    $0x30,%al
  800c91:	75 17                	jne    800caa <strtol+0x78>
  800c93:	8b 45 08             	mov    0x8(%ebp),%eax
  800c96:	40                   	inc    %eax
  800c97:	8a 00                	mov    (%eax),%al
  800c99:	3c 78                	cmp    $0x78,%al
  800c9b:	75 0d                	jne    800caa <strtol+0x78>
		s += 2, base = 16;
  800c9d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800ca1:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ca8:	eb 28                	jmp    800cd2 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800caa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cae:	75 15                	jne    800cc5 <strtol+0x93>
  800cb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb3:	8a 00                	mov    (%eax),%al
  800cb5:	3c 30                	cmp    $0x30,%al
  800cb7:	75 0c                	jne    800cc5 <strtol+0x93>
		s++, base = 8;
  800cb9:	ff 45 08             	incl   0x8(%ebp)
  800cbc:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cc3:	eb 0d                	jmp    800cd2 <strtol+0xa0>
	else if (base == 0)
  800cc5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc9:	75 07                	jne    800cd2 <strtol+0xa0>
		base = 10;
  800ccb:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800cd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd5:	8a 00                	mov    (%eax),%al
  800cd7:	3c 2f                	cmp    $0x2f,%al
  800cd9:	7e 19                	jle    800cf4 <strtol+0xc2>
  800cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cde:	8a 00                	mov    (%eax),%al
  800ce0:	3c 39                	cmp    $0x39,%al
  800ce2:	7f 10                	jg     800cf4 <strtol+0xc2>
			dig = *s - '0';
  800ce4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce7:	8a 00                	mov    (%eax),%al
  800ce9:	0f be c0             	movsbl %al,%eax
  800cec:	83 e8 30             	sub    $0x30,%eax
  800cef:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800cf2:	eb 42                	jmp    800d36 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800cf4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf7:	8a 00                	mov    (%eax),%al
  800cf9:	3c 60                	cmp    $0x60,%al
  800cfb:	7e 19                	jle    800d16 <strtol+0xe4>
  800cfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800d00:	8a 00                	mov    (%eax),%al
  800d02:	3c 7a                	cmp    $0x7a,%al
  800d04:	7f 10                	jg     800d16 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	8a 00                	mov    (%eax),%al
  800d0b:	0f be c0             	movsbl %al,%eax
  800d0e:	83 e8 57             	sub    $0x57,%eax
  800d11:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d14:	eb 20                	jmp    800d36 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d16:	8b 45 08             	mov    0x8(%ebp),%eax
  800d19:	8a 00                	mov    (%eax),%al
  800d1b:	3c 40                	cmp    $0x40,%al
  800d1d:	7e 39                	jle    800d58 <strtol+0x126>
  800d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d22:	8a 00                	mov    (%eax),%al
  800d24:	3c 5a                	cmp    $0x5a,%al
  800d26:	7f 30                	jg     800d58 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d28:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2b:	8a 00                	mov    (%eax),%al
  800d2d:	0f be c0             	movsbl %al,%eax
  800d30:	83 e8 37             	sub    $0x37,%eax
  800d33:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d36:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d39:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d3c:	7d 19                	jge    800d57 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d3e:	ff 45 08             	incl   0x8(%ebp)
  800d41:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d44:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d48:	89 c2                	mov    %eax,%edx
  800d4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d4d:	01 d0                	add    %edx,%eax
  800d4f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d52:	e9 7b ff ff ff       	jmp    800cd2 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d57:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d58:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d5c:	74 08                	je     800d66 <strtol+0x134>
		*endptr = (char *) s;
  800d5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d61:	8b 55 08             	mov    0x8(%ebp),%edx
  800d64:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d66:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d6a:	74 07                	je     800d73 <strtol+0x141>
  800d6c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d6f:	f7 d8                	neg    %eax
  800d71:	eb 03                	jmp    800d76 <strtol+0x144>
  800d73:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d76:	c9                   	leave  
  800d77:	c3                   	ret    

00800d78 <ltostr>:

void
ltostr(long value, char *str)
{
  800d78:	55                   	push   %ebp
  800d79:	89 e5                	mov    %esp,%ebp
  800d7b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800d7e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800d85:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800d8c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d90:	79 13                	jns    800da5 <ltostr+0x2d>
	{
		neg = 1;
  800d92:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800d99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d9c:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800d9f:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800da2:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800da5:	8b 45 08             	mov    0x8(%ebp),%eax
  800da8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800dad:	99                   	cltd   
  800dae:	f7 f9                	idiv   %ecx
  800db0:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800db3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db6:	8d 50 01             	lea    0x1(%eax),%edx
  800db9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dbc:	89 c2                	mov    %eax,%edx
  800dbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc1:	01 d0                	add    %edx,%eax
  800dc3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dc6:	83 c2 30             	add    $0x30,%edx
  800dc9:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800dcb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dce:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dd3:	f7 e9                	imul   %ecx
  800dd5:	c1 fa 02             	sar    $0x2,%edx
  800dd8:	89 c8                	mov    %ecx,%eax
  800dda:	c1 f8 1f             	sar    $0x1f,%eax
  800ddd:	29 c2                	sub    %eax,%edx
  800ddf:	89 d0                	mov    %edx,%eax
  800de1:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800de4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800de7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dec:	f7 e9                	imul   %ecx
  800dee:	c1 fa 02             	sar    $0x2,%edx
  800df1:	89 c8                	mov    %ecx,%eax
  800df3:	c1 f8 1f             	sar    $0x1f,%eax
  800df6:	29 c2                	sub    %eax,%edx
  800df8:	89 d0                	mov    %edx,%eax
  800dfa:	c1 e0 02             	shl    $0x2,%eax
  800dfd:	01 d0                	add    %edx,%eax
  800dff:	01 c0                	add    %eax,%eax
  800e01:	29 c1                	sub    %eax,%ecx
  800e03:	89 ca                	mov    %ecx,%edx
  800e05:	85 d2                	test   %edx,%edx
  800e07:	75 9c                	jne    800da5 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e09:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e10:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e13:	48                   	dec    %eax
  800e14:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e17:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e1b:	74 3d                	je     800e5a <ltostr+0xe2>
		start = 1 ;
  800e1d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e24:	eb 34                	jmp    800e5a <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e26:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e29:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2c:	01 d0                	add    %edx,%eax
  800e2e:	8a 00                	mov    (%eax),%al
  800e30:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e33:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e39:	01 c2                	add    %eax,%edx
  800e3b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e41:	01 c8                	add    %ecx,%eax
  800e43:	8a 00                	mov    (%eax),%al
  800e45:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e47:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4d:	01 c2                	add    %eax,%edx
  800e4f:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e52:	88 02                	mov    %al,(%edx)
		start++ ;
  800e54:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e57:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e5d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e60:	7c c4                	jl     800e26 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e62:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e68:	01 d0                	add    %edx,%eax
  800e6a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e6d:	90                   	nop
  800e6e:	c9                   	leave  
  800e6f:	c3                   	ret    

00800e70 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e70:	55                   	push   %ebp
  800e71:	89 e5                	mov    %esp,%ebp
  800e73:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e76:	ff 75 08             	pushl  0x8(%ebp)
  800e79:	e8 54 fa ff ff       	call   8008d2 <strlen>
  800e7e:	83 c4 04             	add    $0x4,%esp
  800e81:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800e84:	ff 75 0c             	pushl  0xc(%ebp)
  800e87:	e8 46 fa ff ff       	call   8008d2 <strlen>
  800e8c:	83 c4 04             	add    $0x4,%esp
  800e8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800e92:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800e99:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ea0:	eb 17                	jmp    800eb9 <strcconcat+0x49>
		final[s] = str1[s] ;
  800ea2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ea5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea8:	01 c2                	add    %eax,%edx
  800eaa:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ead:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb0:	01 c8                	add    %ecx,%eax
  800eb2:	8a 00                	mov    (%eax),%al
  800eb4:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800eb6:	ff 45 fc             	incl   -0x4(%ebp)
  800eb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ebc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ebf:	7c e1                	jl     800ea2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ec1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ec8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800ecf:	eb 1f                	jmp    800ef0 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800ed1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ed4:	8d 50 01             	lea    0x1(%eax),%edx
  800ed7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800eda:	89 c2                	mov    %eax,%edx
  800edc:	8b 45 10             	mov    0x10(%ebp),%eax
  800edf:	01 c2                	add    %eax,%edx
  800ee1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800ee4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee7:	01 c8                	add    %ecx,%eax
  800ee9:	8a 00                	mov    (%eax),%al
  800eeb:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800eed:	ff 45 f8             	incl   -0x8(%ebp)
  800ef0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ef3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ef6:	7c d9                	jl     800ed1 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800ef8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800efb:	8b 45 10             	mov    0x10(%ebp),%eax
  800efe:	01 d0                	add    %edx,%eax
  800f00:	c6 00 00             	movb   $0x0,(%eax)
}
  800f03:	90                   	nop
  800f04:	c9                   	leave  
  800f05:	c3                   	ret    

00800f06 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f06:	55                   	push   %ebp
  800f07:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f09:	8b 45 14             	mov    0x14(%ebp),%eax
  800f0c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f12:	8b 45 14             	mov    0x14(%ebp),%eax
  800f15:	8b 00                	mov    (%eax),%eax
  800f17:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f1e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f21:	01 d0                	add    %edx,%eax
  800f23:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f29:	eb 0c                	jmp    800f37 <strsplit+0x31>
			*string++ = 0;
  800f2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2e:	8d 50 01             	lea    0x1(%eax),%edx
  800f31:	89 55 08             	mov    %edx,0x8(%ebp)
  800f34:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f37:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3a:	8a 00                	mov    (%eax),%al
  800f3c:	84 c0                	test   %al,%al
  800f3e:	74 18                	je     800f58 <strsplit+0x52>
  800f40:	8b 45 08             	mov    0x8(%ebp),%eax
  800f43:	8a 00                	mov    (%eax),%al
  800f45:	0f be c0             	movsbl %al,%eax
  800f48:	50                   	push   %eax
  800f49:	ff 75 0c             	pushl  0xc(%ebp)
  800f4c:	e8 13 fb ff ff       	call   800a64 <strchr>
  800f51:	83 c4 08             	add    $0x8,%esp
  800f54:	85 c0                	test   %eax,%eax
  800f56:	75 d3                	jne    800f2b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800f58:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5b:	8a 00                	mov    (%eax),%al
  800f5d:	84 c0                	test   %al,%al
  800f5f:	74 5a                	je     800fbb <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800f61:	8b 45 14             	mov    0x14(%ebp),%eax
  800f64:	8b 00                	mov    (%eax),%eax
  800f66:	83 f8 0f             	cmp    $0xf,%eax
  800f69:	75 07                	jne    800f72 <strsplit+0x6c>
		{
			return 0;
  800f6b:	b8 00 00 00 00       	mov    $0x0,%eax
  800f70:	eb 66                	jmp    800fd8 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f72:	8b 45 14             	mov    0x14(%ebp),%eax
  800f75:	8b 00                	mov    (%eax),%eax
  800f77:	8d 48 01             	lea    0x1(%eax),%ecx
  800f7a:	8b 55 14             	mov    0x14(%ebp),%edx
  800f7d:	89 0a                	mov    %ecx,(%edx)
  800f7f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f86:	8b 45 10             	mov    0x10(%ebp),%eax
  800f89:	01 c2                	add    %eax,%edx
  800f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f90:	eb 03                	jmp    800f95 <strsplit+0x8f>
			string++;
  800f92:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f95:	8b 45 08             	mov    0x8(%ebp),%eax
  800f98:	8a 00                	mov    (%eax),%al
  800f9a:	84 c0                	test   %al,%al
  800f9c:	74 8b                	je     800f29 <strsplit+0x23>
  800f9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa1:	8a 00                	mov    (%eax),%al
  800fa3:	0f be c0             	movsbl %al,%eax
  800fa6:	50                   	push   %eax
  800fa7:	ff 75 0c             	pushl  0xc(%ebp)
  800faa:	e8 b5 fa ff ff       	call   800a64 <strchr>
  800faf:	83 c4 08             	add    $0x8,%esp
  800fb2:	85 c0                	test   %eax,%eax
  800fb4:	74 dc                	je     800f92 <strsplit+0x8c>
			string++;
	}
  800fb6:	e9 6e ff ff ff       	jmp    800f29 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800fbb:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fbc:	8b 45 14             	mov    0x14(%ebp),%eax
  800fbf:	8b 00                	mov    (%eax),%eax
  800fc1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fc8:	8b 45 10             	mov    0x10(%ebp),%eax
  800fcb:	01 d0                	add    %edx,%eax
  800fcd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800fd3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800fd8:	c9                   	leave  
  800fd9:	c3                   	ret    

00800fda <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  800fda:	55                   	push   %ebp
  800fdb:	89 e5                	mov    %esp,%ebp
  800fdd:	57                   	push   %edi
  800fde:	56                   	push   %esi
  800fdf:	53                   	push   %ebx
  800fe0:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fe9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800fec:	8b 5d 14             	mov    0x14(%ebp),%ebx
  800fef:	8b 7d 18             	mov    0x18(%ebp),%edi
  800ff2:	8b 75 1c             	mov    0x1c(%ebp),%esi
  800ff5:	cd 30                	int    $0x30
  800ff7:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  800ffa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ffd:	83 c4 10             	add    $0x10,%esp
  801000:	5b                   	pop    %ebx
  801001:	5e                   	pop    %esi
  801002:	5f                   	pop    %edi
  801003:	5d                   	pop    %ebp
  801004:	c3                   	ret    

00801005 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801005:	55                   	push   %ebp
  801006:	89 e5                	mov    %esp,%ebp
  801008:	83 ec 04             	sub    $0x4,%esp
  80100b:	8b 45 10             	mov    0x10(%ebp),%eax
  80100e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801011:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801015:	8b 45 08             	mov    0x8(%ebp),%eax
  801018:	6a 00                	push   $0x0
  80101a:	6a 00                	push   $0x0
  80101c:	52                   	push   %edx
  80101d:	ff 75 0c             	pushl  0xc(%ebp)
  801020:	50                   	push   %eax
  801021:	6a 00                	push   $0x0
  801023:	e8 b2 ff ff ff       	call   800fda <syscall>
  801028:	83 c4 18             	add    $0x18,%esp
}
  80102b:	90                   	nop
  80102c:	c9                   	leave  
  80102d:	c3                   	ret    

0080102e <sys_cgetc>:

int
sys_cgetc(void)
{
  80102e:	55                   	push   %ebp
  80102f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801031:	6a 00                	push   $0x0
  801033:	6a 00                	push   $0x0
  801035:	6a 00                	push   $0x0
  801037:	6a 00                	push   $0x0
  801039:	6a 00                	push   $0x0
  80103b:	6a 01                	push   $0x1
  80103d:	e8 98 ff ff ff       	call   800fda <syscall>
  801042:	83 c4 18             	add    $0x18,%esp
}
  801045:	c9                   	leave  
  801046:	c3                   	ret    

00801047 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801047:	55                   	push   %ebp
  801048:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80104a:	8b 45 08             	mov    0x8(%ebp),%eax
  80104d:	6a 00                	push   $0x0
  80104f:	6a 00                	push   $0x0
  801051:	6a 00                	push   $0x0
  801053:	6a 00                	push   $0x0
  801055:	50                   	push   %eax
  801056:	6a 05                	push   $0x5
  801058:	e8 7d ff ff ff       	call   800fda <syscall>
  80105d:	83 c4 18             	add    $0x18,%esp
}
  801060:	c9                   	leave  
  801061:	c3                   	ret    

00801062 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801062:	55                   	push   %ebp
  801063:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801065:	6a 00                	push   $0x0
  801067:	6a 00                	push   $0x0
  801069:	6a 00                	push   $0x0
  80106b:	6a 00                	push   $0x0
  80106d:	6a 00                	push   $0x0
  80106f:	6a 02                	push   $0x2
  801071:	e8 64 ff ff ff       	call   800fda <syscall>
  801076:	83 c4 18             	add    $0x18,%esp
}
  801079:	c9                   	leave  
  80107a:	c3                   	ret    

0080107b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80107b:	55                   	push   %ebp
  80107c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80107e:	6a 00                	push   $0x0
  801080:	6a 00                	push   $0x0
  801082:	6a 00                	push   $0x0
  801084:	6a 00                	push   $0x0
  801086:	6a 00                	push   $0x0
  801088:	6a 03                	push   $0x3
  80108a:	e8 4b ff ff ff       	call   800fda <syscall>
  80108f:	83 c4 18             	add    $0x18,%esp
}
  801092:	c9                   	leave  
  801093:	c3                   	ret    

00801094 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801094:	55                   	push   %ebp
  801095:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801097:	6a 00                	push   $0x0
  801099:	6a 00                	push   $0x0
  80109b:	6a 00                	push   $0x0
  80109d:	6a 00                	push   $0x0
  80109f:	6a 00                	push   $0x0
  8010a1:	6a 04                	push   $0x4
  8010a3:	e8 32 ff ff ff       	call   800fda <syscall>
  8010a8:	83 c4 18             	add    $0x18,%esp
}
  8010ab:	c9                   	leave  
  8010ac:	c3                   	ret    

008010ad <sys_env_exit>:


void sys_env_exit(void)
{
  8010ad:	55                   	push   %ebp
  8010ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010b0:	6a 00                	push   $0x0
  8010b2:	6a 00                	push   $0x0
  8010b4:	6a 00                	push   $0x0
  8010b6:	6a 00                	push   $0x0
  8010b8:	6a 00                	push   $0x0
  8010ba:	6a 06                	push   $0x6
  8010bc:	e8 19 ff ff ff       	call   800fda <syscall>
  8010c1:	83 c4 18             	add    $0x18,%esp
}
  8010c4:	90                   	nop
  8010c5:	c9                   	leave  
  8010c6:	c3                   	ret    

008010c7 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010c7:	55                   	push   %ebp
  8010c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d0:	6a 00                	push   $0x0
  8010d2:	6a 00                	push   $0x0
  8010d4:	6a 00                	push   $0x0
  8010d6:	52                   	push   %edx
  8010d7:	50                   	push   %eax
  8010d8:	6a 07                	push   $0x7
  8010da:	e8 fb fe ff ff       	call   800fda <syscall>
  8010df:	83 c4 18             	add    $0x18,%esp
}
  8010e2:	c9                   	leave  
  8010e3:	c3                   	ret    

008010e4 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8010e4:	55                   	push   %ebp
  8010e5:	89 e5                	mov    %esp,%ebp
  8010e7:	56                   	push   %esi
  8010e8:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8010e9:	8b 75 18             	mov    0x18(%ebp),%esi
  8010ec:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010ef:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f8:	56                   	push   %esi
  8010f9:	53                   	push   %ebx
  8010fa:	51                   	push   %ecx
  8010fb:	52                   	push   %edx
  8010fc:	50                   	push   %eax
  8010fd:	6a 08                	push   $0x8
  8010ff:	e8 d6 fe ff ff       	call   800fda <syscall>
  801104:	83 c4 18             	add    $0x18,%esp
}
  801107:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80110a:	5b                   	pop    %ebx
  80110b:	5e                   	pop    %esi
  80110c:	5d                   	pop    %ebp
  80110d:	c3                   	ret    

0080110e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80110e:	55                   	push   %ebp
  80110f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801111:	8b 55 0c             	mov    0xc(%ebp),%edx
  801114:	8b 45 08             	mov    0x8(%ebp),%eax
  801117:	6a 00                	push   $0x0
  801119:	6a 00                	push   $0x0
  80111b:	6a 00                	push   $0x0
  80111d:	52                   	push   %edx
  80111e:	50                   	push   %eax
  80111f:	6a 09                	push   $0x9
  801121:	e8 b4 fe ff ff       	call   800fda <syscall>
  801126:	83 c4 18             	add    $0x18,%esp
}
  801129:	c9                   	leave  
  80112a:	c3                   	ret    

0080112b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80112b:	55                   	push   %ebp
  80112c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80112e:	6a 00                	push   $0x0
  801130:	6a 00                	push   $0x0
  801132:	6a 00                	push   $0x0
  801134:	ff 75 0c             	pushl  0xc(%ebp)
  801137:	ff 75 08             	pushl  0x8(%ebp)
  80113a:	6a 0a                	push   $0xa
  80113c:	e8 99 fe ff ff       	call   800fda <syscall>
  801141:	83 c4 18             	add    $0x18,%esp
}
  801144:	c9                   	leave  
  801145:	c3                   	ret    

00801146 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801146:	55                   	push   %ebp
  801147:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801149:	6a 00                	push   $0x0
  80114b:	6a 00                	push   $0x0
  80114d:	6a 00                	push   $0x0
  80114f:	6a 00                	push   $0x0
  801151:	6a 00                	push   $0x0
  801153:	6a 0b                	push   $0xb
  801155:	e8 80 fe ff ff       	call   800fda <syscall>
  80115a:	83 c4 18             	add    $0x18,%esp
}
  80115d:	c9                   	leave  
  80115e:	c3                   	ret    

0080115f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80115f:	55                   	push   %ebp
  801160:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801162:	6a 00                	push   $0x0
  801164:	6a 00                	push   $0x0
  801166:	6a 00                	push   $0x0
  801168:	6a 00                	push   $0x0
  80116a:	6a 00                	push   $0x0
  80116c:	6a 0c                	push   $0xc
  80116e:	e8 67 fe ff ff       	call   800fda <syscall>
  801173:	83 c4 18             	add    $0x18,%esp
}
  801176:	c9                   	leave  
  801177:	c3                   	ret    

00801178 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801178:	55                   	push   %ebp
  801179:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80117b:	6a 00                	push   $0x0
  80117d:	6a 00                	push   $0x0
  80117f:	6a 00                	push   $0x0
  801181:	6a 00                	push   $0x0
  801183:	6a 00                	push   $0x0
  801185:	6a 0d                	push   $0xd
  801187:	e8 4e fe ff ff       	call   800fda <syscall>
  80118c:	83 c4 18             	add    $0x18,%esp
}
  80118f:	c9                   	leave  
  801190:	c3                   	ret    

00801191 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801191:	55                   	push   %ebp
  801192:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801194:	6a 00                	push   $0x0
  801196:	6a 00                	push   $0x0
  801198:	6a 00                	push   $0x0
  80119a:	ff 75 0c             	pushl  0xc(%ebp)
  80119d:	ff 75 08             	pushl  0x8(%ebp)
  8011a0:	6a 11                	push   $0x11
  8011a2:	e8 33 fe ff ff       	call   800fda <syscall>
  8011a7:	83 c4 18             	add    $0x18,%esp
	return;
  8011aa:	90                   	nop
}
  8011ab:	c9                   	leave  
  8011ac:	c3                   	ret    

008011ad <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011ad:	55                   	push   %ebp
  8011ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011b0:	6a 00                	push   $0x0
  8011b2:	6a 00                	push   $0x0
  8011b4:	6a 00                	push   $0x0
  8011b6:	ff 75 0c             	pushl  0xc(%ebp)
  8011b9:	ff 75 08             	pushl  0x8(%ebp)
  8011bc:	6a 12                	push   $0x12
  8011be:	e8 17 fe ff ff       	call   800fda <syscall>
  8011c3:	83 c4 18             	add    $0x18,%esp
	return ;
  8011c6:	90                   	nop
}
  8011c7:	c9                   	leave  
  8011c8:	c3                   	ret    

008011c9 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011c9:	55                   	push   %ebp
  8011ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011cc:	6a 00                	push   $0x0
  8011ce:	6a 00                	push   $0x0
  8011d0:	6a 00                	push   $0x0
  8011d2:	6a 00                	push   $0x0
  8011d4:	6a 00                	push   $0x0
  8011d6:	6a 0e                	push   $0xe
  8011d8:	e8 fd fd ff ff       	call   800fda <syscall>
  8011dd:	83 c4 18             	add    $0x18,%esp
}
  8011e0:	c9                   	leave  
  8011e1:	c3                   	ret    

008011e2 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8011e2:	55                   	push   %ebp
  8011e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8011e5:	6a 00                	push   $0x0
  8011e7:	6a 00                	push   $0x0
  8011e9:	6a 00                	push   $0x0
  8011eb:	6a 00                	push   $0x0
  8011ed:	ff 75 08             	pushl  0x8(%ebp)
  8011f0:	6a 0f                	push   $0xf
  8011f2:	e8 e3 fd ff ff       	call   800fda <syscall>
  8011f7:	83 c4 18             	add    $0x18,%esp
}
  8011fa:	c9                   	leave  
  8011fb:	c3                   	ret    

008011fc <sys_scarce_memory>:

void sys_scarce_memory()
{
  8011fc:	55                   	push   %ebp
  8011fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8011ff:	6a 00                	push   $0x0
  801201:	6a 00                	push   $0x0
  801203:	6a 00                	push   $0x0
  801205:	6a 00                	push   $0x0
  801207:	6a 00                	push   $0x0
  801209:	6a 10                	push   $0x10
  80120b:	e8 ca fd ff ff       	call   800fda <syscall>
  801210:	83 c4 18             	add    $0x18,%esp
}
  801213:	90                   	nop
  801214:	c9                   	leave  
  801215:	c3                   	ret    

00801216 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801216:	55                   	push   %ebp
  801217:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801219:	6a 00                	push   $0x0
  80121b:	6a 00                	push   $0x0
  80121d:	6a 00                	push   $0x0
  80121f:	6a 00                	push   $0x0
  801221:	6a 00                	push   $0x0
  801223:	6a 14                	push   $0x14
  801225:	e8 b0 fd ff ff       	call   800fda <syscall>
  80122a:	83 c4 18             	add    $0x18,%esp
}
  80122d:	90                   	nop
  80122e:	c9                   	leave  
  80122f:	c3                   	ret    

00801230 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801230:	55                   	push   %ebp
  801231:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801233:	6a 00                	push   $0x0
  801235:	6a 00                	push   $0x0
  801237:	6a 00                	push   $0x0
  801239:	6a 00                	push   $0x0
  80123b:	6a 00                	push   $0x0
  80123d:	6a 15                	push   $0x15
  80123f:	e8 96 fd ff ff       	call   800fda <syscall>
  801244:	83 c4 18             	add    $0x18,%esp
}
  801247:	90                   	nop
  801248:	c9                   	leave  
  801249:	c3                   	ret    

0080124a <sys_cputc>:


void
sys_cputc(const char c)
{
  80124a:	55                   	push   %ebp
  80124b:	89 e5                	mov    %esp,%ebp
  80124d:	83 ec 04             	sub    $0x4,%esp
  801250:	8b 45 08             	mov    0x8(%ebp),%eax
  801253:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801256:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80125a:	6a 00                	push   $0x0
  80125c:	6a 00                	push   $0x0
  80125e:	6a 00                	push   $0x0
  801260:	6a 00                	push   $0x0
  801262:	50                   	push   %eax
  801263:	6a 16                	push   $0x16
  801265:	e8 70 fd ff ff       	call   800fda <syscall>
  80126a:	83 c4 18             	add    $0x18,%esp
}
  80126d:	90                   	nop
  80126e:	c9                   	leave  
  80126f:	c3                   	ret    

00801270 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801270:	55                   	push   %ebp
  801271:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801273:	6a 00                	push   $0x0
  801275:	6a 00                	push   $0x0
  801277:	6a 00                	push   $0x0
  801279:	6a 00                	push   $0x0
  80127b:	6a 00                	push   $0x0
  80127d:	6a 17                	push   $0x17
  80127f:	e8 56 fd ff ff       	call   800fda <syscall>
  801284:	83 c4 18             	add    $0x18,%esp
}
  801287:	90                   	nop
  801288:	c9                   	leave  
  801289:	c3                   	ret    

0080128a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80128a:	55                   	push   %ebp
  80128b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80128d:	8b 45 08             	mov    0x8(%ebp),%eax
  801290:	6a 00                	push   $0x0
  801292:	6a 00                	push   $0x0
  801294:	6a 00                	push   $0x0
  801296:	ff 75 0c             	pushl  0xc(%ebp)
  801299:	50                   	push   %eax
  80129a:	6a 18                	push   $0x18
  80129c:	e8 39 fd ff ff       	call   800fda <syscall>
  8012a1:	83 c4 18             	add    $0x18,%esp
}
  8012a4:	c9                   	leave  
  8012a5:	c3                   	ret    

008012a6 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012a6:	55                   	push   %ebp
  8012a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8012af:	6a 00                	push   $0x0
  8012b1:	6a 00                	push   $0x0
  8012b3:	6a 00                	push   $0x0
  8012b5:	52                   	push   %edx
  8012b6:	50                   	push   %eax
  8012b7:	6a 1b                	push   $0x1b
  8012b9:	e8 1c fd ff ff       	call   800fda <syscall>
  8012be:	83 c4 18             	add    $0x18,%esp
}
  8012c1:	c9                   	leave  
  8012c2:	c3                   	ret    

008012c3 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012c3:	55                   	push   %ebp
  8012c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cc:	6a 00                	push   $0x0
  8012ce:	6a 00                	push   $0x0
  8012d0:	6a 00                	push   $0x0
  8012d2:	52                   	push   %edx
  8012d3:	50                   	push   %eax
  8012d4:	6a 19                	push   $0x19
  8012d6:	e8 ff fc ff ff       	call   800fda <syscall>
  8012db:	83 c4 18             	add    $0x18,%esp
}
  8012de:	90                   	nop
  8012df:	c9                   	leave  
  8012e0:	c3                   	ret    

008012e1 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012e1:	55                   	push   %ebp
  8012e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ea:	6a 00                	push   $0x0
  8012ec:	6a 00                	push   $0x0
  8012ee:	6a 00                	push   $0x0
  8012f0:	52                   	push   %edx
  8012f1:	50                   	push   %eax
  8012f2:	6a 1a                	push   $0x1a
  8012f4:	e8 e1 fc ff ff       	call   800fda <syscall>
  8012f9:	83 c4 18             	add    $0x18,%esp
}
  8012fc:	90                   	nop
  8012fd:	c9                   	leave  
  8012fe:	c3                   	ret    

008012ff <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8012ff:	55                   	push   %ebp
  801300:	89 e5                	mov    %esp,%ebp
  801302:	83 ec 04             	sub    $0x4,%esp
  801305:	8b 45 10             	mov    0x10(%ebp),%eax
  801308:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80130b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80130e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801312:	8b 45 08             	mov    0x8(%ebp),%eax
  801315:	6a 00                	push   $0x0
  801317:	51                   	push   %ecx
  801318:	52                   	push   %edx
  801319:	ff 75 0c             	pushl  0xc(%ebp)
  80131c:	50                   	push   %eax
  80131d:	6a 1c                	push   $0x1c
  80131f:	e8 b6 fc ff ff       	call   800fda <syscall>
  801324:	83 c4 18             	add    $0x18,%esp
}
  801327:	c9                   	leave  
  801328:	c3                   	ret    

00801329 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801329:	55                   	push   %ebp
  80132a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80132c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80132f:	8b 45 08             	mov    0x8(%ebp),%eax
  801332:	6a 00                	push   $0x0
  801334:	6a 00                	push   $0x0
  801336:	6a 00                	push   $0x0
  801338:	52                   	push   %edx
  801339:	50                   	push   %eax
  80133a:	6a 1d                	push   $0x1d
  80133c:	e8 99 fc ff ff       	call   800fda <syscall>
  801341:	83 c4 18             	add    $0x18,%esp
}
  801344:	c9                   	leave  
  801345:	c3                   	ret    

00801346 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801346:	55                   	push   %ebp
  801347:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801349:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80134c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134f:	8b 45 08             	mov    0x8(%ebp),%eax
  801352:	6a 00                	push   $0x0
  801354:	6a 00                	push   $0x0
  801356:	51                   	push   %ecx
  801357:	52                   	push   %edx
  801358:	50                   	push   %eax
  801359:	6a 1e                	push   $0x1e
  80135b:	e8 7a fc ff ff       	call   800fda <syscall>
  801360:	83 c4 18             	add    $0x18,%esp
}
  801363:	c9                   	leave  
  801364:	c3                   	ret    

00801365 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801365:	55                   	push   %ebp
  801366:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801368:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	6a 00                	push   $0x0
  801370:	6a 00                	push   $0x0
  801372:	6a 00                	push   $0x0
  801374:	52                   	push   %edx
  801375:	50                   	push   %eax
  801376:	6a 1f                	push   $0x1f
  801378:	e8 5d fc ff ff       	call   800fda <syscall>
  80137d:	83 c4 18             	add    $0x18,%esp
}
  801380:	c9                   	leave  
  801381:	c3                   	ret    

00801382 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801382:	55                   	push   %ebp
  801383:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801385:	6a 00                	push   $0x0
  801387:	6a 00                	push   $0x0
  801389:	6a 00                	push   $0x0
  80138b:	6a 00                	push   $0x0
  80138d:	6a 00                	push   $0x0
  80138f:	6a 20                	push   $0x20
  801391:	e8 44 fc ff ff       	call   800fda <syscall>
  801396:	83 c4 18             	add    $0x18,%esp
}
  801399:	c9                   	leave  
  80139a:	c3                   	ret    

0080139b <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80139b:	55                   	push   %ebp
  80139c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80139e:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a1:	6a 00                	push   $0x0
  8013a3:	ff 75 14             	pushl  0x14(%ebp)
  8013a6:	ff 75 10             	pushl  0x10(%ebp)
  8013a9:	ff 75 0c             	pushl  0xc(%ebp)
  8013ac:	50                   	push   %eax
  8013ad:	6a 21                	push   $0x21
  8013af:	e8 26 fc ff ff       	call   800fda <syscall>
  8013b4:	83 c4 18             	add    $0x18,%esp
}
  8013b7:	c9                   	leave  
  8013b8:	c3                   	ret    

008013b9 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8013b9:	55                   	push   %ebp
  8013ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bf:	6a 00                	push   $0x0
  8013c1:	6a 00                	push   $0x0
  8013c3:	6a 00                	push   $0x0
  8013c5:	6a 00                	push   $0x0
  8013c7:	50                   	push   %eax
  8013c8:	6a 22                	push   $0x22
  8013ca:	e8 0b fc ff ff       	call   800fda <syscall>
  8013cf:	83 c4 18             	add    $0x18,%esp
}
  8013d2:	90                   	nop
  8013d3:	c9                   	leave  
  8013d4:	c3                   	ret    

008013d5 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013d5:	55                   	push   %ebp
  8013d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8013d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 00                	push   $0x0
  8013df:	6a 00                	push   $0x0
  8013e1:	6a 00                	push   $0x0
  8013e3:	50                   	push   %eax
  8013e4:	6a 23                	push   $0x23
  8013e6:	e8 ef fb ff ff       	call   800fda <syscall>
  8013eb:	83 c4 18             	add    $0x18,%esp
}
  8013ee:	90                   	nop
  8013ef:	c9                   	leave  
  8013f0:	c3                   	ret    

008013f1 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8013f1:	55                   	push   %ebp
  8013f2:	89 e5                	mov    %esp,%ebp
  8013f4:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8013f7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013fa:	8d 50 04             	lea    0x4(%eax),%edx
  8013fd:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801400:	6a 00                	push   $0x0
  801402:	6a 00                	push   $0x0
  801404:	6a 00                	push   $0x0
  801406:	52                   	push   %edx
  801407:	50                   	push   %eax
  801408:	6a 24                	push   $0x24
  80140a:	e8 cb fb ff ff       	call   800fda <syscall>
  80140f:	83 c4 18             	add    $0x18,%esp
	return result;
  801412:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801415:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801418:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80141b:	89 01                	mov    %eax,(%ecx)
  80141d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801420:	8b 45 08             	mov    0x8(%ebp),%eax
  801423:	c9                   	leave  
  801424:	c2 04 00             	ret    $0x4

00801427 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801427:	55                   	push   %ebp
  801428:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80142a:	6a 00                	push   $0x0
  80142c:	6a 00                	push   $0x0
  80142e:	ff 75 10             	pushl  0x10(%ebp)
  801431:	ff 75 0c             	pushl  0xc(%ebp)
  801434:	ff 75 08             	pushl  0x8(%ebp)
  801437:	6a 13                	push   $0x13
  801439:	e8 9c fb ff ff       	call   800fda <syscall>
  80143e:	83 c4 18             	add    $0x18,%esp
	return ;
  801441:	90                   	nop
}
  801442:	c9                   	leave  
  801443:	c3                   	ret    

00801444 <sys_rcr2>:
uint32 sys_rcr2()
{
  801444:	55                   	push   %ebp
  801445:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801447:	6a 00                	push   $0x0
  801449:	6a 00                	push   $0x0
  80144b:	6a 00                	push   $0x0
  80144d:	6a 00                	push   $0x0
  80144f:	6a 00                	push   $0x0
  801451:	6a 25                	push   $0x25
  801453:	e8 82 fb ff ff       	call   800fda <syscall>
  801458:	83 c4 18             	add    $0x18,%esp
}
  80145b:	c9                   	leave  
  80145c:	c3                   	ret    

0080145d <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80145d:	55                   	push   %ebp
  80145e:	89 e5                	mov    %esp,%ebp
  801460:	83 ec 04             	sub    $0x4,%esp
  801463:	8b 45 08             	mov    0x8(%ebp),%eax
  801466:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801469:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80146d:	6a 00                	push   $0x0
  80146f:	6a 00                	push   $0x0
  801471:	6a 00                	push   $0x0
  801473:	6a 00                	push   $0x0
  801475:	50                   	push   %eax
  801476:	6a 26                	push   $0x26
  801478:	e8 5d fb ff ff       	call   800fda <syscall>
  80147d:	83 c4 18             	add    $0x18,%esp
	return ;
  801480:	90                   	nop
}
  801481:	c9                   	leave  
  801482:	c3                   	ret    

00801483 <rsttst>:
void rsttst()
{
  801483:	55                   	push   %ebp
  801484:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801486:	6a 00                	push   $0x0
  801488:	6a 00                	push   $0x0
  80148a:	6a 00                	push   $0x0
  80148c:	6a 00                	push   $0x0
  80148e:	6a 00                	push   $0x0
  801490:	6a 28                	push   $0x28
  801492:	e8 43 fb ff ff       	call   800fda <syscall>
  801497:	83 c4 18             	add    $0x18,%esp
	return ;
  80149a:	90                   	nop
}
  80149b:	c9                   	leave  
  80149c:	c3                   	ret    

0080149d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80149d:	55                   	push   %ebp
  80149e:	89 e5                	mov    %esp,%ebp
  8014a0:	83 ec 04             	sub    $0x4,%esp
  8014a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8014a6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014a9:	8b 55 18             	mov    0x18(%ebp),%edx
  8014ac:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014b0:	52                   	push   %edx
  8014b1:	50                   	push   %eax
  8014b2:	ff 75 10             	pushl  0x10(%ebp)
  8014b5:	ff 75 0c             	pushl  0xc(%ebp)
  8014b8:	ff 75 08             	pushl  0x8(%ebp)
  8014bb:	6a 27                	push   $0x27
  8014bd:	e8 18 fb ff ff       	call   800fda <syscall>
  8014c2:	83 c4 18             	add    $0x18,%esp
	return ;
  8014c5:	90                   	nop
}
  8014c6:	c9                   	leave  
  8014c7:	c3                   	ret    

008014c8 <chktst>:
void chktst(uint32 n)
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 00                	push   $0x0
  8014d1:	6a 00                	push   $0x0
  8014d3:	ff 75 08             	pushl  0x8(%ebp)
  8014d6:	6a 29                	push   $0x29
  8014d8:	e8 fd fa ff ff       	call   800fda <syscall>
  8014dd:	83 c4 18             	add    $0x18,%esp
	return ;
  8014e0:	90                   	nop
}
  8014e1:	c9                   	leave  
  8014e2:	c3                   	ret    

008014e3 <inctst>:

void inctst()
{
  8014e3:	55                   	push   %ebp
  8014e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 00                	push   $0x0
  8014f0:	6a 2a                	push   $0x2a
  8014f2:	e8 e3 fa ff ff       	call   800fda <syscall>
  8014f7:	83 c4 18             	add    $0x18,%esp
	return ;
  8014fa:	90                   	nop
}
  8014fb:	c9                   	leave  
  8014fc:	c3                   	ret    

008014fd <gettst>:
uint32 gettst()
{
  8014fd:	55                   	push   %ebp
  8014fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801500:	6a 00                	push   $0x0
  801502:	6a 00                	push   $0x0
  801504:	6a 00                	push   $0x0
  801506:	6a 00                	push   $0x0
  801508:	6a 00                	push   $0x0
  80150a:	6a 2b                	push   $0x2b
  80150c:	e8 c9 fa ff ff       	call   800fda <syscall>
  801511:	83 c4 18             	add    $0x18,%esp
}
  801514:	c9                   	leave  
  801515:	c3                   	ret    

00801516 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801516:	55                   	push   %ebp
  801517:	89 e5                	mov    %esp,%ebp
  801519:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80151c:	6a 00                	push   $0x0
  80151e:	6a 00                	push   $0x0
  801520:	6a 00                	push   $0x0
  801522:	6a 00                	push   $0x0
  801524:	6a 00                	push   $0x0
  801526:	6a 2c                	push   $0x2c
  801528:	e8 ad fa ff ff       	call   800fda <syscall>
  80152d:	83 c4 18             	add    $0x18,%esp
  801530:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801533:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801537:	75 07                	jne    801540 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801539:	b8 01 00 00 00       	mov    $0x1,%eax
  80153e:	eb 05                	jmp    801545 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801540:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801545:	c9                   	leave  
  801546:	c3                   	ret    

00801547 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801547:	55                   	push   %ebp
  801548:	89 e5                	mov    %esp,%ebp
  80154a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	6a 2c                	push   $0x2c
  801559:	e8 7c fa ff ff       	call   800fda <syscall>
  80155e:	83 c4 18             	add    $0x18,%esp
  801561:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801564:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801568:	75 07                	jne    801571 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80156a:	b8 01 00 00 00       	mov    $0x1,%eax
  80156f:	eb 05                	jmp    801576 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801571:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801576:	c9                   	leave  
  801577:	c3                   	ret    

00801578 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801578:	55                   	push   %ebp
  801579:	89 e5                	mov    %esp,%ebp
  80157b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	6a 00                	push   $0x0
  801584:	6a 00                	push   $0x0
  801586:	6a 00                	push   $0x0
  801588:	6a 2c                	push   $0x2c
  80158a:	e8 4b fa ff ff       	call   800fda <syscall>
  80158f:	83 c4 18             	add    $0x18,%esp
  801592:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801595:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801599:	75 07                	jne    8015a2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80159b:	b8 01 00 00 00       	mov    $0x1,%eax
  8015a0:	eb 05                	jmp    8015a7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015a7:	c9                   	leave  
  8015a8:	c3                   	ret    

008015a9 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015a9:	55                   	push   %ebp
  8015aa:	89 e5                	mov    %esp,%ebp
  8015ac:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 00                	push   $0x0
  8015b9:	6a 2c                	push   $0x2c
  8015bb:	e8 1a fa ff ff       	call   800fda <syscall>
  8015c0:	83 c4 18             	add    $0x18,%esp
  8015c3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015c6:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015ca:	75 07                	jne    8015d3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015cc:	b8 01 00 00 00       	mov    $0x1,%eax
  8015d1:	eb 05                	jmp    8015d8 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015d3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d8:	c9                   	leave  
  8015d9:	c3                   	ret    

008015da <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8015da:	55                   	push   %ebp
  8015db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	ff 75 08             	pushl  0x8(%ebp)
  8015e8:	6a 2d                	push   $0x2d
  8015ea:	e8 eb f9 ff ff       	call   800fda <syscall>
  8015ef:	83 c4 18             	add    $0x18,%esp
	return ;
  8015f2:	90                   	nop
}
  8015f3:	c9                   	leave  
  8015f4:	c3                   	ret    

008015f5 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8015f5:	55                   	push   %ebp
  8015f6:	89 e5                	mov    %esp,%ebp
  8015f8:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8015f9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015fc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801602:	8b 45 08             	mov    0x8(%ebp),%eax
  801605:	6a 00                	push   $0x0
  801607:	53                   	push   %ebx
  801608:	51                   	push   %ecx
  801609:	52                   	push   %edx
  80160a:	50                   	push   %eax
  80160b:	6a 2e                	push   $0x2e
  80160d:	e8 c8 f9 ff ff       	call   800fda <syscall>
  801612:	83 c4 18             	add    $0x18,%esp
}
  801615:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801618:	c9                   	leave  
  801619:	c3                   	ret    

0080161a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80161a:	55                   	push   %ebp
  80161b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80161d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801620:	8b 45 08             	mov    0x8(%ebp),%eax
  801623:	6a 00                	push   $0x0
  801625:	6a 00                	push   $0x0
  801627:	6a 00                	push   $0x0
  801629:	52                   	push   %edx
  80162a:	50                   	push   %eax
  80162b:	6a 2f                	push   $0x2f
  80162d:	e8 a8 f9 ff ff       	call   800fda <syscall>
  801632:	83 c4 18             	add    $0x18,%esp
}
  801635:	c9                   	leave  
  801636:	c3                   	ret    

00801637 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801637:	55                   	push   %ebp
  801638:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80163a:	6a 00                	push   $0x0
  80163c:	6a 00                	push   $0x0
  80163e:	6a 00                	push   $0x0
  801640:	ff 75 0c             	pushl  0xc(%ebp)
  801643:	ff 75 08             	pushl  0x8(%ebp)
  801646:	6a 30                	push   $0x30
  801648:	e8 8d f9 ff ff       	call   800fda <syscall>
  80164d:	83 c4 18             	add    $0x18,%esp
	return ;
  801650:	90                   	nop
}
  801651:	c9                   	leave  
  801652:	c3                   	ret    
  801653:	90                   	nop

00801654 <__udivdi3>:
  801654:	55                   	push   %ebp
  801655:	57                   	push   %edi
  801656:	56                   	push   %esi
  801657:	53                   	push   %ebx
  801658:	83 ec 1c             	sub    $0x1c,%esp
  80165b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80165f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801663:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801667:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80166b:	89 ca                	mov    %ecx,%edx
  80166d:	89 f8                	mov    %edi,%eax
  80166f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801673:	85 f6                	test   %esi,%esi
  801675:	75 2d                	jne    8016a4 <__udivdi3+0x50>
  801677:	39 cf                	cmp    %ecx,%edi
  801679:	77 65                	ja     8016e0 <__udivdi3+0x8c>
  80167b:	89 fd                	mov    %edi,%ebp
  80167d:	85 ff                	test   %edi,%edi
  80167f:	75 0b                	jne    80168c <__udivdi3+0x38>
  801681:	b8 01 00 00 00       	mov    $0x1,%eax
  801686:	31 d2                	xor    %edx,%edx
  801688:	f7 f7                	div    %edi
  80168a:	89 c5                	mov    %eax,%ebp
  80168c:	31 d2                	xor    %edx,%edx
  80168e:	89 c8                	mov    %ecx,%eax
  801690:	f7 f5                	div    %ebp
  801692:	89 c1                	mov    %eax,%ecx
  801694:	89 d8                	mov    %ebx,%eax
  801696:	f7 f5                	div    %ebp
  801698:	89 cf                	mov    %ecx,%edi
  80169a:	89 fa                	mov    %edi,%edx
  80169c:	83 c4 1c             	add    $0x1c,%esp
  80169f:	5b                   	pop    %ebx
  8016a0:	5e                   	pop    %esi
  8016a1:	5f                   	pop    %edi
  8016a2:	5d                   	pop    %ebp
  8016a3:	c3                   	ret    
  8016a4:	39 ce                	cmp    %ecx,%esi
  8016a6:	77 28                	ja     8016d0 <__udivdi3+0x7c>
  8016a8:	0f bd fe             	bsr    %esi,%edi
  8016ab:	83 f7 1f             	xor    $0x1f,%edi
  8016ae:	75 40                	jne    8016f0 <__udivdi3+0x9c>
  8016b0:	39 ce                	cmp    %ecx,%esi
  8016b2:	72 0a                	jb     8016be <__udivdi3+0x6a>
  8016b4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8016b8:	0f 87 9e 00 00 00    	ja     80175c <__udivdi3+0x108>
  8016be:	b8 01 00 00 00       	mov    $0x1,%eax
  8016c3:	89 fa                	mov    %edi,%edx
  8016c5:	83 c4 1c             	add    $0x1c,%esp
  8016c8:	5b                   	pop    %ebx
  8016c9:	5e                   	pop    %esi
  8016ca:	5f                   	pop    %edi
  8016cb:	5d                   	pop    %ebp
  8016cc:	c3                   	ret    
  8016cd:	8d 76 00             	lea    0x0(%esi),%esi
  8016d0:	31 ff                	xor    %edi,%edi
  8016d2:	31 c0                	xor    %eax,%eax
  8016d4:	89 fa                	mov    %edi,%edx
  8016d6:	83 c4 1c             	add    $0x1c,%esp
  8016d9:	5b                   	pop    %ebx
  8016da:	5e                   	pop    %esi
  8016db:	5f                   	pop    %edi
  8016dc:	5d                   	pop    %ebp
  8016dd:	c3                   	ret    
  8016de:	66 90                	xchg   %ax,%ax
  8016e0:	89 d8                	mov    %ebx,%eax
  8016e2:	f7 f7                	div    %edi
  8016e4:	31 ff                	xor    %edi,%edi
  8016e6:	89 fa                	mov    %edi,%edx
  8016e8:	83 c4 1c             	add    $0x1c,%esp
  8016eb:	5b                   	pop    %ebx
  8016ec:	5e                   	pop    %esi
  8016ed:	5f                   	pop    %edi
  8016ee:	5d                   	pop    %ebp
  8016ef:	c3                   	ret    
  8016f0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8016f5:	89 eb                	mov    %ebp,%ebx
  8016f7:	29 fb                	sub    %edi,%ebx
  8016f9:	89 f9                	mov    %edi,%ecx
  8016fb:	d3 e6                	shl    %cl,%esi
  8016fd:	89 c5                	mov    %eax,%ebp
  8016ff:	88 d9                	mov    %bl,%cl
  801701:	d3 ed                	shr    %cl,%ebp
  801703:	89 e9                	mov    %ebp,%ecx
  801705:	09 f1                	or     %esi,%ecx
  801707:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80170b:	89 f9                	mov    %edi,%ecx
  80170d:	d3 e0                	shl    %cl,%eax
  80170f:	89 c5                	mov    %eax,%ebp
  801711:	89 d6                	mov    %edx,%esi
  801713:	88 d9                	mov    %bl,%cl
  801715:	d3 ee                	shr    %cl,%esi
  801717:	89 f9                	mov    %edi,%ecx
  801719:	d3 e2                	shl    %cl,%edx
  80171b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80171f:	88 d9                	mov    %bl,%cl
  801721:	d3 e8                	shr    %cl,%eax
  801723:	09 c2                	or     %eax,%edx
  801725:	89 d0                	mov    %edx,%eax
  801727:	89 f2                	mov    %esi,%edx
  801729:	f7 74 24 0c          	divl   0xc(%esp)
  80172d:	89 d6                	mov    %edx,%esi
  80172f:	89 c3                	mov    %eax,%ebx
  801731:	f7 e5                	mul    %ebp
  801733:	39 d6                	cmp    %edx,%esi
  801735:	72 19                	jb     801750 <__udivdi3+0xfc>
  801737:	74 0b                	je     801744 <__udivdi3+0xf0>
  801739:	89 d8                	mov    %ebx,%eax
  80173b:	31 ff                	xor    %edi,%edi
  80173d:	e9 58 ff ff ff       	jmp    80169a <__udivdi3+0x46>
  801742:	66 90                	xchg   %ax,%ax
  801744:	8b 54 24 08          	mov    0x8(%esp),%edx
  801748:	89 f9                	mov    %edi,%ecx
  80174a:	d3 e2                	shl    %cl,%edx
  80174c:	39 c2                	cmp    %eax,%edx
  80174e:	73 e9                	jae    801739 <__udivdi3+0xe5>
  801750:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801753:	31 ff                	xor    %edi,%edi
  801755:	e9 40 ff ff ff       	jmp    80169a <__udivdi3+0x46>
  80175a:	66 90                	xchg   %ax,%ax
  80175c:	31 c0                	xor    %eax,%eax
  80175e:	e9 37 ff ff ff       	jmp    80169a <__udivdi3+0x46>
  801763:	90                   	nop

00801764 <__umoddi3>:
  801764:	55                   	push   %ebp
  801765:	57                   	push   %edi
  801766:	56                   	push   %esi
  801767:	53                   	push   %ebx
  801768:	83 ec 1c             	sub    $0x1c,%esp
  80176b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80176f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801773:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801777:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80177b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80177f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801783:	89 f3                	mov    %esi,%ebx
  801785:	89 fa                	mov    %edi,%edx
  801787:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80178b:	89 34 24             	mov    %esi,(%esp)
  80178e:	85 c0                	test   %eax,%eax
  801790:	75 1a                	jne    8017ac <__umoddi3+0x48>
  801792:	39 f7                	cmp    %esi,%edi
  801794:	0f 86 a2 00 00 00    	jbe    80183c <__umoddi3+0xd8>
  80179a:	89 c8                	mov    %ecx,%eax
  80179c:	89 f2                	mov    %esi,%edx
  80179e:	f7 f7                	div    %edi
  8017a0:	89 d0                	mov    %edx,%eax
  8017a2:	31 d2                	xor    %edx,%edx
  8017a4:	83 c4 1c             	add    $0x1c,%esp
  8017a7:	5b                   	pop    %ebx
  8017a8:	5e                   	pop    %esi
  8017a9:	5f                   	pop    %edi
  8017aa:	5d                   	pop    %ebp
  8017ab:	c3                   	ret    
  8017ac:	39 f0                	cmp    %esi,%eax
  8017ae:	0f 87 ac 00 00 00    	ja     801860 <__umoddi3+0xfc>
  8017b4:	0f bd e8             	bsr    %eax,%ebp
  8017b7:	83 f5 1f             	xor    $0x1f,%ebp
  8017ba:	0f 84 ac 00 00 00    	je     80186c <__umoddi3+0x108>
  8017c0:	bf 20 00 00 00       	mov    $0x20,%edi
  8017c5:	29 ef                	sub    %ebp,%edi
  8017c7:	89 fe                	mov    %edi,%esi
  8017c9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8017cd:	89 e9                	mov    %ebp,%ecx
  8017cf:	d3 e0                	shl    %cl,%eax
  8017d1:	89 d7                	mov    %edx,%edi
  8017d3:	89 f1                	mov    %esi,%ecx
  8017d5:	d3 ef                	shr    %cl,%edi
  8017d7:	09 c7                	or     %eax,%edi
  8017d9:	89 e9                	mov    %ebp,%ecx
  8017db:	d3 e2                	shl    %cl,%edx
  8017dd:	89 14 24             	mov    %edx,(%esp)
  8017e0:	89 d8                	mov    %ebx,%eax
  8017e2:	d3 e0                	shl    %cl,%eax
  8017e4:	89 c2                	mov    %eax,%edx
  8017e6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017ea:	d3 e0                	shl    %cl,%eax
  8017ec:	89 44 24 04          	mov    %eax,0x4(%esp)
  8017f0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017f4:	89 f1                	mov    %esi,%ecx
  8017f6:	d3 e8                	shr    %cl,%eax
  8017f8:	09 d0                	or     %edx,%eax
  8017fa:	d3 eb                	shr    %cl,%ebx
  8017fc:	89 da                	mov    %ebx,%edx
  8017fe:	f7 f7                	div    %edi
  801800:	89 d3                	mov    %edx,%ebx
  801802:	f7 24 24             	mull   (%esp)
  801805:	89 c6                	mov    %eax,%esi
  801807:	89 d1                	mov    %edx,%ecx
  801809:	39 d3                	cmp    %edx,%ebx
  80180b:	0f 82 87 00 00 00    	jb     801898 <__umoddi3+0x134>
  801811:	0f 84 91 00 00 00    	je     8018a8 <__umoddi3+0x144>
  801817:	8b 54 24 04          	mov    0x4(%esp),%edx
  80181b:	29 f2                	sub    %esi,%edx
  80181d:	19 cb                	sbb    %ecx,%ebx
  80181f:	89 d8                	mov    %ebx,%eax
  801821:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801825:	d3 e0                	shl    %cl,%eax
  801827:	89 e9                	mov    %ebp,%ecx
  801829:	d3 ea                	shr    %cl,%edx
  80182b:	09 d0                	or     %edx,%eax
  80182d:	89 e9                	mov    %ebp,%ecx
  80182f:	d3 eb                	shr    %cl,%ebx
  801831:	89 da                	mov    %ebx,%edx
  801833:	83 c4 1c             	add    $0x1c,%esp
  801836:	5b                   	pop    %ebx
  801837:	5e                   	pop    %esi
  801838:	5f                   	pop    %edi
  801839:	5d                   	pop    %ebp
  80183a:	c3                   	ret    
  80183b:	90                   	nop
  80183c:	89 fd                	mov    %edi,%ebp
  80183e:	85 ff                	test   %edi,%edi
  801840:	75 0b                	jne    80184d <__umoddi3+0xe9>
  801842:	b8 01 00 00 00       	mov    $0x1,%eax
  801847:	31 d2                	xor    %edx,%edx
  801849:	f7 f7                	div    %edi
  80184b:	89 c5                	mov    %eax,%ebp
  80184d:	89 f0                	mov    %esi,%eax
  80184f:	31 d2                	xor    %edx,%edx
  801851:	f7 f5                	div    %ebp
  801853:	89 c8                	mov    %ecx,%eax
  801855:	f7 f5                	div    %ebp
  801857:	89 d0                	mov    %edx,%eax
  801859:	e9 44 ff ff ff       	jmp    8017a2 <__umoddi3+0x3e>
  80185e:	66 90                	xchg   %ax,%ax
  801860:	89 c8                	mov    %ecx,%eax
  801862:	89 f2                	mov    %esi,%edx
  801864:	83 c4 1c             	add    $0x1c,%esp
  801867:	5b                   	pop    %ebx
  801868:	5e                   	pop    %esi
  801869:	5f                   	pop    %edi
  80186a:	5d                   	pop    %ebp
  80186b:	c3                   	ret    
  80186c:	3b 04 24             	cmp    (%esp),%eax
  80186f:	72 06                	jb     801877 <__umoddi3+0x113>
  801871:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801875:	77 0f                	ja     801886 <__umoddi3+0x122>
  801877:	89 f2                	mov    %esi,%edx
  801879:	29 f9                	sub    %edi,%ecx
  80187b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80187f:	89 14 24             	mov    %edx,(%esp)
  801882:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801886:	8b 44 24 04          	mov    0x4(%esp),%eax
  80188a:	8b 14 24             	mov    (%esp),%edx
  80188d:	83 c4 1c             	add    $0x1c,%esp
  801890:	5b                   	pop    %ebx
  801891:	5e                   	pop    %esi
  801892:	5f                   	pop    %edi
  801893:	5d                   	pop    %ebp
  801894:	c3                   	ret    
  801895:	8d 76 00             	lea    0x0(%esi),%esi
  801898:	2b 04 24             	sub    (%esp),%eax
  80189b:	19 fa                	sbb    %edi,%edx
  80189d:	89 d1                	mov    %edx,%ecx
  80189f:	89 c6                	mov    %eax,%esi
  8018a1:	e9 71 ff ff ff       	jmp    801817 <__umoddi3+0xb3>
  8018a6:	66 90                	xchg   %ax,%ax
  8018a8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8018ac:	72 ea                	jb     801898 <__umoddi3+0x134>
  8018ae:	89 d9                	mov    %ebx,%ecx
  8018b0:	e9 62 ff ff ff       	jmp    801817 <__umoddi3+0xb3>
