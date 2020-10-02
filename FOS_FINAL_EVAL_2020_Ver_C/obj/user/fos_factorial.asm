
obj/user/fos_factorial:     file format elf32-i386


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
  800031:	e8 95 00 00 00       	call   8000cb <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int factorial(int n);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	char buff1[256];
	atomic_readline("Please enter a number:", buff1);
  800048:	83 ec 08             	sub    $0x8,%esp
  80004b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800051:	50                   	push   %eax
  800052:	68 e0 1b 80 00       	push   $0x801be0
  800057:	e8 eb 09 00 00       	call   800a47 <atomic_readline>
  80005c:	83 c4 10             	add    $0x10,%esp
	i1 = strtol(buff1, NULL, 10);
  80005f:	83 ec 04             	sub    $0x4,%esp
  800062:	6a 0a                	push   $0xa
  800064:	6a 00                	push   $0x0
  800066:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80006c:	50                   	push   %eax
  80006d:	e8 3d 0e 00 00       	call   800eaf <strtol>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 f4             	mov    %eax,-0xc(%ebp)

	int res = factorial(i1) ;
  800078:	83 ec 0c             	sub    $0xc,%esp
  80007b:	ff 75 f4             	pushl  -0xc(%ebp)
  80007e:	e8 1f 00 00 00       	call   8000a2 <factorial>
  800083:	83 c4 10             	add    $0x10,%esp
  800086:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("Factorial %d = %d\n",i1, res);
  800089:	83 ec 04             	sub    $0x4,%esp
  80008c:	ff 75 f0             	pushl  -0x10(%ebp)
  80008f:	ff 75 f4             	pushl  -0xc(%ebp)
  800092:	68 f7 1b 80 00       	push   $0x801bf7
  800097:	e8 58 02 00 00       	call   8002f4 <atomic_cprintf>
  80009c:	83 c4 10             	add    $0x10,%esp
	return;
  80009f:	90                   	nop
}
  8000a0:	c9                   	leave  
  8000a1:	c3                   	ret    

008000a2 <factorial>:


int factorial(int n)
{
  8000a2:	55                   	push   %ebp
  8000a3:	89 e5                	mov    %esp,%ebp
  8000a5:	83 ec 08             	sub    $0x8,%esp
	if (n <= 1)
  8000a8:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  8000ac:	7f 07                	jg     8000b5 <factorial+0x13>
		return 1 ;
  8000ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8000b3:	eb 14                	jmp    8000c9 <factorial+0x27>
	return n * factorial(n-1) ;
  8000b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8000b8:	48                   	dec    %eax
  8000b9:	83 ec 0c             	sub    $0xc,%esp
  8000bc:	50                   	push   %eax
  8000bd:	e8 e0 ff ff ff       	call   8000a2 <factorial>
  8000c2:	83 c4 10             	add    $0x10,%esp
  8000c5:	0f af 45 08          	imul   0x8(%ebp),%eax
}
  8000c9:	c9                   	leave  
  8000ca:	c3                   	ret    

008000cb <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000cb:	55                   	push   %ebp
  8000cc:	89 e5                	mov    %esp,%ebp
  8000ce:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000d1:	e8 22 12 00 00       	call   8012f8 <sys_getenvindex>
  8000d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000dc:	89 d0                	mov    %edx,%eax
  8000de:	01 c0                	add    %eax,%eax
  8000e0:	01 d0                	add    %edx,%eax
  8000e2:	c1 e0 07             	shl    $0x7,%eax
  8000e5:	29 d0                	sub    %edx,%eax
  8000e7:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8000ee:	01 c8                	add    %ecx,%eax
  8000f0:	01 c0                	add    %eax,%eax
  8000f2:	01 d0                	add    %edx,%eax
  8000f4:	01 c0                	add    %eax,%eax
  8000f6:	01 d0                	add    %edx,%eax
  8000f8:	c1 e0 03             	shl    $0x3,%eax
  8000fb:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800100:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800105:	a1 20 30 80 00       	mov    0x803020,%eax
  80010a:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  800110:	84 c0                	test   %al,%al
  800112:	74 0f                	je     800123 <libmain+0x58>
		binaryname = myEnv->prog_name;
  800114:	a1 20 30 80 00       	mov    0x803020,%eax
  800119:	05 f0 ee 00 00       	add    $0xeef0,%eax
  80011e:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800123:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800127:	7e 0a                	jle    800133 <libmain+0x68>
		binaryname = argv[0];
  800129:	8b 45 0c             	mov    0xc(%ebp),%eax
  80012c:	8b 00                	mov    (%eax),%eax
  80012e:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800133:	83 ec 08             	sub    $0x8,%esp
  800136:	ff 75 0c             	pushl  0xc(%ebp)
  800139:	ff 75 08             	pushl  0x8(%ebp)
  80013c:	e8 f7 fe ff ff       	call   800038 <_main>
  800141:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800144:	e8 4a 13 00 00       	call   801493 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800149:	83 ec 0c             	sub    $0xc,%esp
  80014c:	68 24 1c 80 00       	push   $0x801c24
  800151:	e8 71 01 00 00       	call   8002c7 <cprintf>
  800156:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800159:	a1 20 30 80 00       	mov    0x803020,%eax
  80015e:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  800164:	a1 20 30 80 00       	mov    0x803020,%eax
  800169:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  80016f:	83 ec 04             	sub    $0x4,%esp
  800172:	52                   	push   %edx
  800173:	50                   	push   %eax
  800174:	68 4c 1c 80 00       	push   $0x801c4c
  800179:	e8 49 01 00 00       	call   8002c7 <cprintf>
  80017e:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800181:	a1 20 30 80 00       	mov    0x803020,%eax
  800186:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  80018c:	a1 20 30 80 00       	mov    0x803020,%eax
  800191:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  800197:	a1 20 30 80 00       	mov    0x803020,%eax
  80019c:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  8001a2:	51                   	push   %ecx
  8001a3:	52                   	push   %edx
  8001a4:	50                   	push   %eax
  8001a5:	68 74 1c 80 00       	push   $0x801c74
  8001aa:	e8 18 01 00 00       	call   8002c7 <cprintf>
  8001af:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8001b2:	83 ec 0c             	sub    $0xc,%esp
  8001b5:	68 24 1c 80 00       	push   $0x801c24
  8001ba:	e8 08 01 00 00       	call   8002c7 <cprintf>
  8001bf:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001c2:	e8 e6 12 00 00       	call   8014ad <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001c7:	e8 19 00 00 00       	call   8001e5 <exit>
}
  8001cc:	90                   	nop
  8001cd:	c9                   	leave  
  8001ce:	c3                   	ret    

008001cf <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001cf:	55                   	push   %ebp
  8001d0:	89 e5                	mov    %esp,%ebp
  8001d2:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001d5:	83 ec 0c             	sub    $0xc,%esp
  8001d8:	6a 00                	push   $0x0
  8001da:	e8 e5 10 00 00       	call   8012c4 <sys_env_destroy>
  8001df:	83 c4 10             	add    $0x10,%esp
}
  8001e2:	90                   	nop
  8001e3:	c9                   	leave  
  8001e4:	c3                   	ret    

008001e5 <exit>:

void
exit(void)
{
  8001e5:	55                   	push   %ebp
  8001e6:	89 e5                	mov    %esp,%ebp
  8001e8:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001eb:	e8 3a 11 00 00       	call   80132a <sys_env_exit>
}
  8001f0:	90                   	nop
  8001f1:	c9                   	leave  
  8001f2:	c3                   	ret    

008001f3 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001f3:	55                   	push   %ebp
  8001f4:	89 e5                	mov    %esp,%ebp
  8001f6:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001fc:	8b 00                	mov    (%eax),%eax
  8001fe:	8d 48 01             	lea    0x1(%eax),%ecx
  800201:	8b 55 0c             	mov    0xc(%ebp),%edx
  800204:	89 0a                	mov    %ecx,(%edx)
  800206:	8b 55 08             	mov    0x8(%ebp),%edx
  800209:	88 d1                	mov    %dl,%cl
  80020b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80020e:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800212:	8b 45 0c             	mov    0xc(%ebp),%eax
  800215:	8b 00                	mov    (%eax),%eax
  800217:	3d ff 00 00 00       	cmp    $0xff,%eax
  80021c:	75 2c                	jne    80024a <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80021e:	a0 24 30 80 00       	mov    0x803024,%al
  800223:	0f b6 c0             	movzbl %al,%eax
  800226:	8b 55 0c             	mov    0xc(%ebp),%edx
  800229:	8b 12                	mov    (%edx),%edx
  80022b:	89 d1                	mov    %edx,%ecx
  80022d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800230:	83 c2 08             	add    $0x8,%edx
  800233:	83 ec 04             	sub    $0x4,%esp
  800236:	50                   	push   %eax
  800237:	51                   	push   %ecx
  800238:	52                   	push   %edx
  800239:	e8 44 10 00 00       	call   801282 <sys_cputs>
  80023e:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800241:	8b 45 0c             	mov    0xc(%ebp),%eax
  800244:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80024a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80024d:	8b 40 04             	mov    0x4(%eax),%eax
  800250:	8d 50 01             	lea    0x1(%eax),%edx
  800253:	8b 45 0c             	mov    0xc(%ebp),%eax
  800256:	89 50 04             	mov    %edx,0x4(%eax)
}
  800259:	90                   	nop
  80025a:	c9                   	leave  
  80025b:	c3                   	ret    

0080025c <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80025c:	55                   	push   %ebp
  80025d:	89 e5                	mov    %esp,%ebp
  80025f:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800265:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80026c:	00 00 00 
	b.cnt = 0;
  80026f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800276:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800279:	ff 75 0c             	pushl  0xc(%ebp)
  80027c:	ff 75 08             	pushl  0x8(%ebp)
  80027f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800285:	50                   	push   %eax
  800286:	68 f3 01 80 00       	push   $0x8001f3
  80028b:	e8 11 02 00 00       	call   8004a1 <vprintfmt>
  800290:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800293:	a0 24 30 80 00       	mov    0x803024,%al
  800298:	0f b6 c0             	movzbl %al,%eax
  80029b:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002a1:	83 ec 04             	sub    $0x4,%esp
  8002a4:	50                   	push   %eax
  8002a5:	52                   	push   %edx
  8002a6:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002ac:	83 c0 08             	add    $0x8,%eax
  8002af:	50                   	push   %eax
  8002b0:	e8 cd 0f 00 00       	call   801282 <sys_cputs>
  8002b5:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002b8:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8002bf:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002c5:	c9                   	leave  
  8002c6:	c3                   	ret    

008002c7 <cprintf>:

int cprintf(const char *fmt, ...) {
  8002c7:	55                   	push   %ebp
  8002c8:	89 e5                	mov    %esp,%ebp
  8002ca:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002cd:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8002d4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002da:	8b 45 08             	mov    0x8(%ebp),%eax
  8002dd:	83 ec 08             	sub    $0x8,%esp
  8002e0:	ff 75 f4             	pushl  -0xc(%ebp)
  8002e3:	50                   	push   %eax
  8002e4:	e8 73 ff ff ff       	call   80025c <vcprintf>
  8002e9:	83 c4 10             	add    $0x10,%esp
  8002ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002f2:	c9                   	leave  
  8002f3:	c3                   	ret    

008002f4 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002f4:	55                   	push   %ebp
  8002f5:	89 e5                	mov    %esp,%ebp
  8002f7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002fa:	e8 94 11 00 00       	call   801493 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002ff:	8d 45 0c             	lea    0xc(%ebp),%eax
  800302:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800305:	8b 45 08             	mov    0x8(%ebp),%eax
  800308:	83 ec 08             	sub    $0x8,%esp
  80030b:	ff 75 f4             	pushl  -0xc(%ebp)
  80030e:	50                   	push   %eax
  80030f:	e8 48 ff ff ff       	call   80025c <vcprintf>
  800314:	83 c4 10             	add    $0x10,%esp
  800317:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80031a:	e8 8e 11 00 00       	call   8014ad <sys_enable_interrupt>
	return cnt;
  80031f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800322:	c9                   	leave  
  800323:	c3                   	ret    

00800324 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800324:	55                   	push   %ebp
  800325:	89 e5                	mov    %esp,%ebp
  800327:	53                   	push   %ebx
  800328:	83 ec 14             	sub    $0x14,%esp
  80032b:	8b 45 10             	mov    0x10(%ebp),%eax
  80032e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800331:	8b 45 14             	mov    0x14(%ebp),%eax
  800334:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800337:	8b 45 18             	mov    0x18(%ebp),%eax
  80033a:	ba 00 00 00 00       	mov    $0x0,%edx
  80033f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800342:	77 55                	ja     800399 <printnum+0x75>
  800344:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800347:	72 05                	jb     80034e <printnum+0x2a>
  800349:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80034c:	77 4b                	ja     800399 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80034e:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800351:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800354:	8b 45 18             	mov    0x18(%ebp),%eax
  800357:	ba 00 00 00 00       	mov    $0x0,%edx
  80035c:	52                   	push   %edx
  80035d:	50                   	push   %eax
  80035e:	ff 75 f4             	pushl  -0xc(%ebp)
  800361:	ff 75 f0             	pushl  -0x10(%ebp)
  800364:	e8 07 16 00 00       	call   801970 <__udivdi3>
  800369:	83 c4 10             	add    $0x10,%esp
  80036c:	83 ec 04             	sub    $0x4,%esp
  80036f:	ff 75 20             	pushl  0x20(%ebp)
  800372:	53                   	push   %ebx
  800373:	ff 75 18             	pushl  0x18(%ebp)
  800376:	52                   	push   %edx
  800377:	50                   	push   %eax
  800378:	ff 75 0c             	pushl  0xc(%ebp)
  80037b:	ff 75 08             	pushl  0x8(%ebp)
  80037e:	e8 a1 ff ff ff       	call   800324 <printnum>
  800383:	83 c4 20             	add    $0x20,%esp
  800386:	eb 1a                	jmp    8003a2 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800388:	83 ec 08             	sub    $0x8,%esp
  80038b:	ff 75 0c             	pushl  0xc(%ebp)
  80038e:	ff 75 20             	pushl  0x20(%ebp)
  800391:	8b 45 08             	mov    0x8(%ebp),%eax
  800394:	ff d0                	call   *%eax
  800396:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800399:	ff 4d 1c             	decl   0x1c(%ebp)
  80039c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003a0:	7f e6                	jg     800388 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003a2:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003a5:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003b0:	53                   	push   %ebx
  8003b1:	51                   	push   %ecx
  8003b2:	52                   	push   %edx
  8003b3:	50                   	push   %eax
  8003b4:	e8 c7 16 00 00       	call   801a80 <__umoddi3>
  8003b9:	83 c4 10             	add    $0x10,%esp
  8003bc:	05 f4 1e 80 00       	add    $0x801ef4,%eax
  8003c1:	8a 00                	mov    (%eax),%al
  8003c3:	0f be c0             	movsbl %al,%eax
  8003c6:	83 ec 08             	sub    $0x8,%esp
  8003c9:	ff 75 0c             	pushl  0xc(%ebp)
  8003cc:	50                   	push   %eax
  8003cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d0:	ff d0                	call   *%eax
  8003d2:	83 c4 10             	add    $0x10,%esp
}
  8003d5:	90                   	nop
  8003d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003d9:	c9                   	leave  
  8003da:	c3                   	ret    

008003db <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003db:	55                   	push   %ebp
  8003dc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003de:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003e2:	7e 1c                	jle    800400 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e7:	8b 00                	mov    (%eax),%eax
  8003e9:	8d 50 08             	lea    0x8(%eax),%edx
  8003ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ef:	89 10                	mov    %edx,(%eax)
  8003f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f4:	8b 00                	mov    (%eax),%eax
  8003f6:	83 e8 08             	sub    $0x8,%eax
  8003f9:	8b 50 04             	mov    0x4(%eax),%edx
  8003fc:	8b 00                	mov    (%eax),%eax
  8003fe:	eb 40                	jmp    800440 <getuint+0x65>
	else if (lflag)
  800400:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800404:	74 1e                	je     800424 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800406:	8b 45 08             	mov    0x8(%ebp),%eax
  800409:	8b 00                	mov    (%eax),%eax
  80040b:	8d 50 04             	lea    0x4(%eax),%edx
  80040e:	8b 45 08             	mov    0x8(%ebp),%eax
  800411:	89 10                	mov    %edx,(%eax)
  800413:	8b 45 08             	mov    0x8(%ebp),%eax
  800416:	8b 00                	mov    (%eax),%eax
  800418:	83 e8 04             	sub    $0x4,%eax
  80041b:	8b 00                	mov    (%eax),%eax
  80041d:	ba 00 00 00 00       	mov    $0x0,%edx
  800422:	eb 1c                	jmp    800440 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800424:	8b 45 08             	mov    0x8(%ebp),%eax
  800427:	8b 00                	mov    (%eax),%eax
  800429:	8d 50 04             	lea    0x4(%eax),%edx
  80042c:	8b 45 08             	mov    0x8(%ebp),%eax
  80042f:	89 10                	mov    %edx,(%eax)
  800431:	8b 45 08             	mov    0x8(%ebp),%eax
  800434:	8b 00                	mov    (%eax),%eax
  800436:	83 e8 04             	sub    $0x4,%eax
  800439:	8b 00                	mov    (%eax),%eax
  80043b:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800440:	5d                   	pop    %ebp
  800441:	c3                   	ret    

00800442 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800442:	55                   	push   %ebp
  800443:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800445:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800449:	7e 1c                	jle    800467 <getint+0x25>
		return va_arg(*ap, long long);
  80044b:	8b 45 08             	mov    0x8(%ebp),%eax
  80044e:	8b 00                	mov    (%eax),%eax
  800450:	8d 50 08             	lea    0x8(%eax),%edx
  800453:	8b 45 08             	mov    0x8(%ebp),%eax
  800456:	89 10                	mov    %edx,(%eax)
  800458:	8b 45 08             	mov    0x8(%ebp),%eax
  80045b:	8b 00                	mov    (%eax),%eax
  80045d:	83 e8 08             	sub    $0x8,%eax
  800460:	8b 50 04             	mov    0x4(%eax),%edx
  800463:	8b 00                	mov    (%eax),%eax
  800465:	eb 38                	jmp    80049f <getint+0x5d>
	else if (lflag)
  800467:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80046b:	74 1a                	je     800487 <getint+0x45>
		return va_arg(*ap, long);
  80046d:	8b 45 08             	mov    0x8(%ebp),%eax
  800470:	8b 00                	mov    (%eax),%eax
  800472:	8d 50 04             	lea    0x4(%eax),%edx
  800475:	8b 45 08             	mov    0x8(%ebp),%eax
  800478:	89 10                	mov    %edx,(%eax)
  80047a:	8b 45 08             	mov    0x8(%ebp),%eax
  80047d:	8b 00                	mov    (%eax),%eax
  80047f:	83 e8 04             	sub    $0x4,%eax
  800482:	8b 00                	mov    (%eax),%eax
  800484:	99                   	cltd   
  800485:	eb 18                	jmp    80049f <getint+0x5d>
	else
		return va_arg(*ap, int);
  800487:	8b 45 08             	mov    0x8(%ebp),%eax
  80048a:	8b 00                	mov    (%eax),%eax
  80048c:	8d 50 04             	lea    0x4(%eax),%edx
  80048f:	8b 45 08             	mov    0x8(%ebp),%eax
  800492:	89 10                	mov    %edx,(%eax)
  800494:	8b 45 08             	mov    0x8(%ebp),%eax
  800497:	8b 00                	mov    (%eax),%eax
  800499:	83 e8 04             	sub    $0x4,%eax
  80049c:	8b 00                	mov    (%eax),%eax
  80049e:	99                   	cltd   
}
  80049f:	5d                   	pop    %ebp
  8004a0:	c3                   	ret    

008004a1 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004a1:	55                   	push   %ebp
  8004a2:	89 e5                	mov    %esp,%ebp
  8004a4:	56                   	push   %esi
  8004a5:	53                   	push   %ebx
  8004a6:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004a9:	eb 17                	jmp    8004c2 <vprintfmt+0x21>
			if (ch == '\0')
  8004ab:	85 db                	test   %ebx,%ebx
  8004ad:	0f 84 af 03 00 00    	je     800862 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004b3:	83 ec 08             	sub    $0x8,%esp
  8004b6:	ff 75 0c             	pushl  0xc(%ebp)
  8004b9:	53                   	push   %ebx
  8004ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bd:	ff d0                	call   *%eax
  8004bf:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c5:	8d 50 01             	lea    0x1(%eax),%edx
  8004c8:	89 55 10             	mov    %edx,0x10(%ebp)
  8004cb:	8a 00                	mov    (%eax),%al
  8004cd:	0f b6 d8             	movzbl %al,%ebx
  8004d0:	83 fb 25             	cmp    $0x25,%ebx
  8004d3:	75 d6                	jne    8004ab <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004d5:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004d9:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004e0:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004e7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004ee:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8004f8:	8d 50 01             	lea    0x1(%eax),%edx
  8004fb:	89 55 10             	mov    %edx,0x10(%ebp)
  8004fe:	8a 00                	mov    (%eax),%al
  800500:	0f b6 d8             	movzbl %al,%ebx
  800503:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800506:	83 f8 55             	cmp    $0x55,%eax
  800509:	0f 87 2b 03 00 00    	ja     80083a <vprintfmt+0x399>
  80050f:	8b 04 85 18 1f 80 00 	mov    0x801f18(,%eax,4),%eax
  800516:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800518:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80051c:	eb d7                	jmp    8004f5 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80051e:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800522:	eb d1                	jmp    8004f5 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800524:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80052b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80052e:	89 d0                	mov    %edx,%eax
  800530:	c1 e0 02             	shl    $0x2,%eax
  800533:	01 d0                	add    %edx,%eax
  800535:	01 c0                	add    %eax,%eax
  800537:	01 d8                	add    %ebx,%eax
  800539:	83 e8 30             	sub    $0x30,%eax
  80053c:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80053f:	8b 45 10             	mov    0x10(%ebp),%eax
  800542:	8a 00                	mov    (%eax),%al
  800544:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800547:	83 fb 2f             	cmp    $0x2f,%ebx
  80054a:	7e 3e                	jle    80058a <vprintfmt+0xe9>
  80054c:	83 fb 39             	cmp    $0x39,%ebx
  80054f:	7f 39                	jg     80058a <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800551:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800554:	eb d5                	jmp    80052b <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800556:	8b 45 14             	mov    0x14(%ebp),%eax
  800559:	83 c0 04             	add    $0x4,%eax
  80055c:	89 45 14             	mov    %eax,0x14(%ebp)
  80055f:	8b 45 14             	mov    0x14(%ebp),%eax
  800562:	83 e8 04             	sub    $0x4,%eax
  800565:	8b 00                	mov    (%eax),%eax
  800567:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80056a:	eb 1f                	jmp    80058b <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80056c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800570:	79 83                	jns    8004f5 <vprintfmt+0x54>
				width = 0;
  800572:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800579:	e9 77 ff ff ff       	jmp    8004f5 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80057e:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800585:	e9 6b ff ff ff       	jmp    8004f5 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80058a:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80058b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80058f:	0f 89 60 ff ff ff    	jns    8004f5 <vprintfmt+0x54>
				width = precision, precision = -1;
  800595:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800598:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80059b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005a2:	e9 4e ff ff ff       	jmp    8004f5 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005a7:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005aa:	e9 46 ff ff ff       	jmp    8004f5 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005af:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b2:	83 c0 04             	add    $0x4,%eax
  8005b5:	89 45 14             	mov    %eax,0x14(%ebp)
  8005b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8005bb:	83 e8 04             	sub    $0x4,%eax
  8005be:	8b 00                	mov    (%eax),%eax
  8005c0:	83 ec 08             	sub    $0x8,%esp
  8005c3:	ff 75 0c             	pushl  0xc(%ebp)
  8005c6:	50                   	push   %eax
  8005c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ca:	ff d0                	call   *%eax
  8005cc:	83 c4 10             	add    $0x10,%esp
			break;
  8005cf:	e9 89 02 00 00       	jmp    80085d <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d7:	83 c0 04             	add    $0x4,%eax
  8005da:	89 45 14             	mov    %eax,0x14(%ebp)
  8005dd:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e0:	83 e8 04             	sub    $0x4,%eax
  8005e3:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005e5:	85 db                	test   %ebx,%ebx
  8005e7:	79 02                	jns    8005eb <vprintfmt+0x14a>
				err = -err;
  8005e9:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005eb:	83 fb 64             	cmp    $0x64,%ebx
  8005ee:	7f 0b                	jg     8005fb <vprintfmt+0x15a>
  8005f0:	8b 34 9d 60 1d 80 00 	mov    0x801d60(,%ebx,4),%esi
  8005f7:	85 f6                	test   %esi,%esi
  8005f9:	75 19                	jne    800614 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005fb:	53                   	push   %ebx
  8005fc:	68 05 1f 80 00       	push   $0x801f05
  800601:	ff 75 0c             	pushl  0xc(%ebp)
  800604:	ff 75 08             	pushl  0x8(%ebp)
  800607:	e8 5e 02 00 00       	call   80086a <printfmt>
  80060c:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80060f:	e9 49 02 00 00       	jmp    80085d <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800614:	56                   	push   %esi
  800615:	68 0e 1f 80 00       	push   $0x801f0e
  80061a:	ff 75 0c             	pushl  0xc(%ebp)
  80061d:	ff 75 08             	pushl  0x8(%ebp)
  800620:	e8 45 02 00 00       	call   80086a <printfmt>
  800625:	83 c4 10             	add    $0x10,%esp
			break;
  800628:	e9 30 02 00 00       	jmp    80085d <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80062d:	8b 45 14             	mov    0x14(%ebp),%eax
  800630:	83 c0 04             	add    $0x4,%eax
  800633:	89 45 14             	mov    %eax,0x14(%ebp)
  800636:	8b 45 14             	mov    0x14(%ebp),%eax
  800639:	83 e8 04             	sub    $0x4,%eax
  80063c:	8b 30                	mov    (%eax),%esi
  80063e:	85 f6                	test   %esi,%esi
  800640:	75 05                	jne    800647 <vprintfmt+0x1a6>
				p = "(null)";
  800642:	be 11 1f 80 00       	mov    $0x801f11,%esi
			if (width > 0 && padc != '-')
  800647:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80064b:	7e 6d                	jle    8006ba <vprintfmt+0x219>
  80064d:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800651:	74 67                	je     8006ba <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800653:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800656:	83 ec 08             	sub    $0x8,%esp
  800659:	50                   	push   %eax
  80065a:	56                   	push   %esi
  80065b:	e8 12 05 00 00       	call   800b72 <strnlen>
  800660:	83 c4 10             	add    $0x10,%esp
  800663:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800666:	eb 16                	jmp    80067e <vprintfmt+0x1dd>
					putch(padc, putdat);
  800668:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80066c:	83 ec 08             	sub    $0x8,%esp
  80066f:	ff 75 0c             	pushl  0xc(%ebp)
  800672:	50                   	push   %eax
  800673:	8b 45 08             	mov    0x8(%ebp),%eax
  800676:	ff d0                	call   *%eax
  800678:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80067b:	ff 4d e4             	decl   -0x1c(%ebp)
  80067e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800682:	7f e4                	jg     800668 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800684:	eb 34                	jmp    8006ba <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800686:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80068a:	74 1c                	je     8006a8 <vprintfmt+0x207>
  80068c:	83 fb 1f             	cmp    $0x1f,%ebx
  80068f:	7e 05                	jle    800696 <vprintfmt+0x1f5>
  800691:	83 fb 7e             	cmp    $0x7e,%ebx
  800694:	7e 12                	jle    8006a8 <vprintfmt+0x207>
					putch('?', putdat);
  800696:	83 ec 08             	sub    $0x8,%esp
  800699:	ff 75 0c             	pushl  0xc(%ebp)
  80069c:	6a 3f                	push   $0x3f
  80069e:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a1:	ff d0                	call   *%eax
  8006a3:	83 c4 10             	add    $0x10,%esp
  8006a6:	eb 0f                	jmp    8006b7 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006a8:	83 ec 08             	sub    $0x8,%esp
  8006ab:	ff 75 0c             	pushl  0xc(%ebp)
  8006ae:	53                   	push   %ebx
  8006af:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b2:	ff d0                	call   *%eax
  8006b4:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006b7:	ff 4d e4             	decl   -0x1c(%ebp)
  8006ba:	89 f0                	mov    %esi,%eax
  8006bc:	8d 70 01             	lea    0x1(%eax),%esi
  8006bf:	8a 00                	mov    (%eax),%al
  8006c1:	0f be d8             	movsbl %al,%ebx
  8006c4:	85 db                	test   %ebx,%ebx
  8006c6:	74 24                	je     8006ec <vprintfmt+0x24b>
  8006c8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006cc:	78 b8                	js     800686 <vprintfmt+0x1e5>
  8006ce:	ff 4d e0             	decl   -0x20(%ebp)
  8006d1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006d5:	79 af                	jns    800686 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006d7:	eb 13                	jmp    8006ec <vprintfmt+0x24b>
				putch(' ', putdat);
  8006d9:	83 ec 08             	sub    $0x8,%esp
  8006dc:	ff 75 0c             	pushl  0xc(%ebp)
  8006df:	6a 20                	push   $0x20
  8006e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e4:	ff d0                	call   *%eax
  8006e6:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006e9:	ff 4d e4             	decl   -0x1c(%ebp)
  8006ec:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006f0:	7f e7                	jg     8006d9 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006f2:	e9 66 01 00 00       	jmp    80085d <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006f7:	83 ec 08             	sub    $0x8,%esp
  8006fa:	ff 75 e8             	pushl  -0x18(%ebp)
  8006fd:	8d 45 14             	lea    0x14(%ebp),%eax
  800700:	50                   	push   %eax
  800701:	e8 3c fd ff ff       	call   800442 <getint>
  800706:	83 c4 10             	add    $0x10,%esp
  800709:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80070c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80070f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800712:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800715:	85 d2                	test   %edx,%edx
  800717:	79 23                	jns    80073c <vprintfmt+0x29b>
				putch('-', putdat);
  800719:	83 ec 08             	sub    $0x8,%esp
  80071c:	ff 75 0c             	pushl  0xc(%ebp)
  80071f:	6a 2d                	push   $0x2d
  800721:	8b 45 08             	mov    0x8(%ebp),%eax
  800724:	ff d0                	call   *%eax
  800726:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800729:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80072c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80072f:	f7 d8                	neg    %eax
  800731:	83 d2 00             	adc    $0x0,%edx
  800734:	f7 da                	neg    %edx
  800736:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800739:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80073c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800743:	e9 bc 00 00 00       	jmp    800804 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800748:	83 ec 08             	sub    $0x8,%esp
  80074b:	ff 75 e8             	pushl  -0x18(%ebp)
  80074e:	8d 45 14             	lea    0x14(%ebp),%eax
  800751:	50                   	push   %eax
  800752:	e8 84 fc ff ff       	call   8003db <getuint>
  800757:	83 c4 10             	add    $0x10,%esp
  80075a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80075d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800760:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800767:	e9 98 00 00 00       	jmp    800804 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80076c:	83 ec 08             	sub    $0x8,%esp
  80076f:	ff 75 0c             	pushl  0xc(%ebp)
  800772:	6a 58                	push   $0x58
  800774:	8b 45 08             	mov    0x8(%ebp),%eax
  800777:	ff d0                	call   *%eax
  800779:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80077c:	83 ec 08             	sub    $0x8,%esp
  80077f:	ff 75 0c             	pushl  0xc(%ebp)
  800782:	6a 58                	push   $0x58
  800784:	8b 45 08             	mov    0x8(%ebp),%eax
  800787:	ff d0                	call   *%eax
  800789:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80078c:	83 ec 08             	sub    $0x8,%esp
  80078f:	ff 75 0c             	pushl  0xc(%ebp)
  800792:	6a 58                	push   $0x58
  800794:	8b 45 08             	mov    0x8(%ebp),%eax
  800797:	ff d0                	call   *%eax
  800799:	83 c4 10             	add    $0x10,%esp
			break;
  80079c:	e9 bc 00 00 00       	jmp    80085d <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007a1:	83 ec 08             	sub    $0x8,%esp
  8007a4:	ff 75 0c             	pushl  0xc(%ebp)
  8007a7:	6a 30                	push   $0x30
  8007a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ac:	ff d0                	call   *%eax
  8007ae:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007b1:	83 ec 08             	sub    $0x8,%esp
  8007b4:	ff 75 0c             	pushl  0xc(%ebp)
  8007b7:	6a 78                	push   $0x78
  8007b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bc:	ff d0                	call   *%eax
  8007be:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c4:	83 c0 04             	add    $0x4,%eax
  8007c7:	89 45 14             	mov    %eax,0x14(%ebp)
  8007ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8007cd:	83 e8 04             	sub    $0x4,%eax
  8007d0:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007dc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007e3:	eb 1f                	jmp    800804 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007e5:	83 ec 08             	sub    $0x8,%esp
  8007e8:	ff 75 e8             	pushl  -0x18(%ebp)
  8007eb:	8d 45 14             	lea    0x14(%ebp),%eax
  8007ee:	50                   	push   %eax
  8007ef:	e8 e7 fb ff ff       	call   8003db <getuint>
  8007f4:	83 c4 10             	add    $0x10,%esp
  8007f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007fa:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007fd:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800804:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800808:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80080b:	83 ec 04             	sub    $0x4,%esp
  80080e:	52                   	push   %edx
  80080f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800812:	50                   	push   %eax
  800813:	ff 75 f4             	pushl  -0xc(%ebp)
  800816:	ff 75 f0             	pushl  -0x10(%ebp)
  800819:	ff 75 0c             	pushl  0xc(%ebp)
  80081c:	ff 75 08             	pushl  0x8(%ebp)
  80081f:	e8 00 fb ff ff       	call   800324 <printnum>
  800824:	83 c4 20             	add    $0x20,%esp
			break;
  800827:	eb 34                	jmp    80085d <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800829:	83 ec 08             	sub    $0x8,%esp
  80082c:	ff 75 0c             	pushl  0xc(%ebp)
  80082f:	53                   	push   %ebx
  800830:	8b 45 08             	mov    0x8(%ebp),%eax
  800833:	ff d0                	call   *%eax
  800835:	83 c4 10             	add    $0x10,%esp
			break;
  800838:	eb 23                	jmp    80085d <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80083a:	83 ec 08             	sub    $0x8,%esp
  80083d:	ff 75 0c             	pushl  0xc(%ebp)
  800840:	6a 25                	push   $0x25
  800842:	8b 45 08             	mov    0x8(%ebp),%eax
  800845:	ff d0                	call   *%eax
  800847:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80084a:	ff 4d 10             	decl   0x10(%ebp)
  80084d:	eb 03                	jmp    800852 <vprintfmt+0x3b1>
  80084f:	ff 4d 10             	decl   0x10(%ebp)
  800852:	8b 45 10             	mov    0x10(%ebp),%eax
  800855:	48                   	dec    %eax
  800856:	8a 00                	mov    (%eax),%al
  800858:	3c 25                	cmp    $0x25,%al
  80085a:	75 f3                	jne    80084f <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80085c:	90                   	nop
		}
	}
  80085d:	e9 47 fc ff ff       	jmp    8004a9 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800862:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800863:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800866:	5b                   	pop    %ebx
  800867:	5e                   	pop    %esi
  800868:	5d                   	pop    %ebp
  800869:	c3                   	ret    

0080086a <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80086a:	55                   	push   %ebp
  80086b:	89 e5                	mov    %esp,%ebp
  80086d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800870:	8d 45 10             	lea    0x10(%ebp),%eax
  800873:	83 c0 04             	add    $0x4,%eax
  800876:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800879:	8b 45 10             	mov    0x10(%ebp),%eax
  80087c:	ff 75 f4             	pushl  -0xc(%ebp)
  80087f:	50                   	push   %eax
  800880:	ff 75 0c             	pushl  0xc(%ebp)
  800883:	ff 75 08             	pushl  0x8(%ebp)
  800886:	e8 16 fc ff ff       	call   8004a1 <vprintfmt>
  80088b:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80088e:	90                   	nop
  80088f:	c9                   	leave  
  800890:	c3                   	ret    

00800891 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800891:	55                   	push   %ebp
  800892:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800894:	8b 45 0c             	mov    0xc(%ebp),%eax
  800897:	8b 40 08             	mov    0x8(%eax),%eax
  80089a:	8d 50 01             	lea    0x1(%eax),%edx
  80089d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a0:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a6:	8b 10                	mov    (%eax),%edx
  8008a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ab:	8b 40 04             	mov    0x4(%eax),%eax
  8008ae:	39 c2                	cmp    %eax,%edx
  8008b0:	73 12                	jae    8008c4 <sprintputch+0x33>
		*b->buf++ = ch;
  8008b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b5:	8b 00                	mov    (%eax),%eax
  8008b7:	8d 48 01             	lea    0x1(%eax),%ecx
  8008ba:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008bd:	89 0a                	mov    %ecx,(%edx)
  8008bf:	8b 55 08             	mov    0x8(%ebp),%edx
  8008c2:	88 10                	mov    %dl,(%eax)
}
  8008c4:	90                   	nop
  8008c5:	5d                   	pop    %ebp
  8008c6:	c3                   	ret    

008008c7 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008c7:	55                   	push   %ebp
  8008c8:	89 e5                	mov    %esp,%ebp
  8008ca:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008dc:	01 d0                	add    %edx,%eax
  8008de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008e1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008e8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008ec:	74 06                	je     8008f4 <vsnprintf+0x2d>
  8008ee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008f2:	7f 07                	jg     8008fb <vsnprintf+0x34>
		return -E_INVAL;
  8008f4:	b8 03 00 00 00       	mov    $0x3,%eax
  8008f9:	eb 20                	jmp    80091b <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008fb:	ff 75 14             	pushl  0x14(%ebp)
  8008fe:	ff 75 10             	pushl  0x10(%ebp)
  800901:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800904:	50                   	push   %eax
  800905:	68 91 08 80 00       	push   $0x800891
  80090a:	e8 92 fb ff ff       	call   8004a1 <vprintfmt>
  80090f:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800912:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800915:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800918:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80091b:	c9                   	leave  
  80091c:	c3                   	ret    

0080091d <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80091d:	55                   	push   %ebp
  80091e:	89 e5                	mov    %esp,%ebp
  800920:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800923:	8d 45 10             	lea    0x10(%ebp),%eax
  800926:	83 c0 04             	add    $0x4,%eax
  800929:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80092c:	8b 45 10             	mov    0x10(%ebp),%eax
  80092f:	ff 75 f4             	pushl  -0xc(%ebp)
  800932:	50                   	push   %eax
  800933:	ff 75 0c             	pushl  0xc(%ebp)
  800936:	ff 75 08             	pushl  0x8(%ebp)
  800939:	e8 89 ff ff ff       	call   8008c7 <vsnprintf>
  80093e:	83 c4 10             	add    $0x10,%esp
  800941:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800944:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800947:	c9                   	leave  
  800948:	c3                   	ret    

00800949 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800949:	55                   	push   %ebp
  80094a:	89 e5                	mov    %esp,%ebp
  80094c:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80094f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800953:	74 13                	je     800968 <readline+0x1f>
		cprintf("%s", prompt);
  800955:	83 ec 08             	sub    $0x8,%esp
  800958:	ff 75 08             	pushl  0x8(%ebp)
  80095b:	68 70 20 80 00       	push   $0x802070
  800960:	e8 62 f9 ff ff       	call   8002c7 <cprintf>
  800965:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800968:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80096f:	83 ec 0c             	sub    $0xc,%esp
  800972:	6a 00                	push   $0x0
  800974:	e8 ed 0f 00 00       	call   801966 <iscons>
  800979:	83 c4 10             	add    $0x10,%esp
  80097c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80097f:	e8 94 0f 00 00       	call   801918 <getchar>
  800984:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800987:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80098b:	79 22                	jns    8009af <readline+0x66>
			if (c != -E_EOF)
  80098d:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800991:	0f 84 ad 00 00 00    	je     800a44 <readline+0xfb>
				cprintf("read error: %e\n", c);
  800997:	83 ec 08             	sub    $0x8,%esp
  80099a:	ff 75 ec             	pushl  -0x14(%ebp)
  80099d:	68 73 20 80 00       	push   $0x802073
  8009a2:	e8 20 f9 ff ff       	call   8002c7 <cprintf>
  8009a7:	83 c4 10             	add    $0x10,%esp
			return;
  8009aa:	e9 95 00 00 00       	jmp    800a44 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8009af:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8009b3:	7e 34                	jle    8009e9 <readline+0xa0>
  8009b5:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8009bc:	7f 2b                	jg     8009e9 <readline+0xa0>
			if (echoing)
  8009be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009c2:	74 0e                	je     8009d2 <readline+0x89>
				cputchar(c);
  8009c4:	83 ec 0c             	sub    $0xc,%esp
  8009c7:	ff 75 ec             	pushl  -0x14(%ebp)
  8009ca:	e8 01 0f 00 00       	call   8018d0 <cputchar>
  8009cf:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8009d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009d5:	8d 50 01             	lea    0x1(%eax),%edx
  8009d8:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8009db:	89 c2                	mov    %eax,%edx
  8009dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e0:	01 d0                	add    %edx,%eax
  8009e2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8009e5:	88 10                	mov    %dl,(%eax)
  8009e7:	eb 56                	jmp    800a3f <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8009e9:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8009ed:	75 1f                	jne    800a0e <readline+0xc5>
  8009ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8009f3:	7e 19                	jle    800a0e <readline+0xc5>
			if (echoing)
  8009f5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009f9:	74 0e                	je     800a09 <readline+0xc0>
				cputchar(c);
  8009fb:	83 ec 0c             	sub    $0xc,%esp
  8009fe:	ff 75 ec             	pushl  -0x14(%ebp)
  800a01:	e8 ca 0e 00 00       	call   8018d0 <cputchar>
  800a06:	83 c4 10             	add    $0x10,%esp

			i--;
  800a09:	ff 4d f4             	decl   -0xc(%ebp)
  800a0c:	eb 31                	jmp    800a3f <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800a0e:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800a12:	74 0a                	je     800a1e <readline+0xd5>
  800a14:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800a18:	0f 85 61 ff ff ff    	jne    80097f <readline+0x36>
			if (echoing)
  800a1e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a22:	74 0e                	je     800a32 <readline+0xe9>
				cputchar(c);
  800a24:	83 ec 0c             	sub    $0xc,%esp
  800a27:	ff 75 ec             	pushl  -0x14(%ebp)
  800a2a:	e8 a1 0e 00 00       	call   8018d0 <cputchar>
  800a2f:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800a32:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a38:	01 d0                	add    %edx,%eax
  800a3a:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800a3d:	eb 06                	jmp    800a45 <readline+0xfc>
		}
	}
  800a3f:	e9 3b ff ff ff       	jmp    80097f <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800a44:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800a45:	c9                   	leave  
  800a46:	c3                   	ret    

00800a47 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800a47:	55                   	push   %ebp
  800a48:	89 e5                	mov    %esp,%ebp
  800a4a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a4d:	e8 41 0a 00 00       	call   801493 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800a52:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a56:	74 13                	je     800a6b <atomic_readline+0x24>
		cprintf("%s", prompt);
  800a58:	83 ec 08             	sub    $0x8,%esp
  800a5b:	ff 75 08             	pushl  0x8(%ebp)
  800a5e:	68 70 20 80 00       	push   $0x802070
  800a63:	e8 5f f8 ff ff       	call   8002c7 <cprintf>
  800a68:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800a6b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800a72:	83 ec 0c             	sub    $0xc,%esp
  800a75:	6a 00                	push   $0x0
  800a77:	e8 ea 0e 00 00       	call   801966 <iscons>
  800a7c:	83 c4 10             	add    $0x10,%esp
  800a7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800a82:	e8 91 0e 00 00       	call   801918 <getchar>
  800a87:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800a8a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a8e:	79 23                	jns    800ab3 <atomic_readline+0x6c>
			if (c != -E_EOF)
  800a90:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800a94:	74 13                	je     800aa9 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800a96:	83 ec 08             	sub    $0x8,%esp
  800a99:	ff 75 ec             	pushl  -0x14(%ebp)
  800a9c:	68 73 20 80 00       	push   $0x802073
  800aa1:	e8 21 f8 ff ff       	call   8002c7 <cprintf>
  800aa6:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800aa9:	e8 ff 09 00 00       	call   8014ad <sys_enable_interrupt>
			return;
  800aae:	e9 9a 00 00 00       	jmp    800b4d <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800ab3:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800ab7:	7e 34                	jle    800aed <atomic_readline+0xa6>
  800ab9:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800ac0:	7f 2b                	jg     800aed <atomic_readline+0xa6>
			if (echoing)
  800ac2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800ac6:	74 0e                	je     800ad6 <atomic_readline+0x8f>
				cputchar(c);
  800ac8:	83 ec 0c             	sub    $0xc,%esp
  800acb:	ff 75 ec             	pushl  -0x14(%ebp)
  800ace:	e8 fd 0d 00 00       	call   8018d0 <cputchar>
  800ad3:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800ad6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ad9:	8d 50 01             	lea    0x1(%eax),%edx
  800adc:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800adf:	89 c2                	mov    %eax,%edx
  800ae1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae4:	01 d0                	add    %edx,%eax
  800ae6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ae9:	88 10                	mov    %dl,(%eax)
  800aeb:	eb 5b                	jmp    800b48 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800aed:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800af1:	75 1f                	jne    800b12 <atomic_readline+0xcb>
  800af3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800af7:	7e 19                	jle    800b12 <atomic_readline+0xcb>
			if (echoing)
  800af9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800afd:	74 0e                	je     800b0d <atomic_readline+0xc6>
				cputchar(c);
  800aff:	83 ec 0c             	sub    $0xc,%esp
  800b02:	ff 75 ec             	pushl  -0x14(%ebp)
  800b05:	e8 c6 0d 00 00       	call   8018d0 <cputchar>
  800b0a:	83 c4 10             	add    $0x10,%esp
			i--;
  800b0d:	ff 4d f4             	decl   -0xc(%ebp)
  800b10:	eb 36                	jmp    800b48 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800b12:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800b16:	74 0a                	je     800b22 <atomic_readline+0xdb>
  800b18:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800b1c:	0f 85 60 ff ff ff    	jne    800a82 <atomic_readline+0x3b>
			if (echoing)
  800b22:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b26:	74 0e                	je     800b36 <atomic_readline+0xef>
				cputchar(c);
  800b28:	83 ec 0c             	sub    $0xc,%esp
  800b2b:	ff 75 ec             	pushl  -0x14(%ebp)
  800b2e:	e8 9d 0d 00 00       	call   8018d0 <cputchar>
  800b33:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800b36:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3c:	01 d0                	add    %edx,%eax
  800b3e:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800b41:	e8 67 09 00 00       	call   8014ad <sys_enable_interrupt>
			return;
  800b46:	eb 05                	jmp    800b4d <atomic_readline+0x106>
		}
	}
  800b48:	e9 35 ff ff ff       	jmp    800a82 <atomic_readline+0x3b>
}
  800b4d:	c9                   	leave  
  800b4e:	c3                   	ret    

00800b4f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b4f:	55                   	push   %ebp
  800b50:	89 e5                	mov    %esp,%ebp
  800b52:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b55:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b5c:	eb 06                	jmp    800b64 <strlen+0x15>
		n++;
  800b5e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b61:	ff 45 08             	incl   0x8(%ebp)
  800b64:	8b 45 08             	mov    0x8(%ebp),%eax
  800b67:	8a 00                	mov    (%eax),%al
  800b69:	84 c0                	test   %al,%al
  800b6b:	75 f1                	jne    800b5e <strlen+0xf>
		n++;
	return n;
  800b6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b70:	c9                   	leave  
  800b71:	c3                   	ret    

00800b72 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b72:	55                   	push   %ebp
  800b73:	89 e5                	mov    %esp,%ebp
  800b75:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b78:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b7f:	eb 09                	jmp    800b8a <strnlen+0x18>
		n++;
  800b81:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b84:	ff 45 08             	incl   0x8(%ebp)
  800b87:	ff 4d 0c             	decl   0xc(%ebp)
  800b8a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b8e:	74 09                	je     800b99 <strnlen+0x27>
  800b90:	8b 45 08             	mov    0x8(%ebp),%eax
  800b93:	8a 00                	mov    (%eax),%al
  800b95:	84 c0                	test   %al,%al
  800b97:	75 e8                	jne    800b81 <strnlen+0xf>
		n++;
	return n;
  800b99:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b9c:	c9                   	leave  
  800b9d:	c3                   	ret    

00800b9e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b9e:	55                   	push   %ebp
  800b9f:	89 e5                	mov    %esp,%ebp
  800ba1:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800baa:	90                   	nop
  800bab:	8b 45 08             	mov    0x8(%ebp),%eax
  800bae:	8d 50 01             	lea    0x1(%eax),%edx
  800bb1:	89 55 08             	mov    %edx,0x8(%ebp)
  800bb4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bb7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bba:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bbd:	8a 12                	mov    (%edx),%dl
  800bbf:	88 10                	mov    %dl,(%eax)
  800bc1:	8a 00                	mov    (%eax),%al
  800bc3:	84 c0                	test   %al,%al
  800bc5:	75 e4                	jne    800bab <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bc7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bca:	c9                   	leave  
  800bcb:	c3                   	ret    

00800bcc <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bcc:	55                   	push   %ebp
  800bcd:	89 e5                	mov    %esp,%ebp
  800bcf:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bd8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bdf:	eb 1f                	jmp    800c00 <strncpy+0x34>
		*dst++ = *src;
  800be1:	8b 45 08             	mov    0x8(%ebp),%eax
  800be4:	8d 50 01             	lea    0x1(%eax),%edx
  800be7:	89 55 08             	mov    %edx,0x8(%ebp)
  800bea:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bed:	8a 12                	mov    (%edx),%dl
  800bef:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800bf1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf4:	8a 00                	mov    (%eax),%al
  800bf6:	84 c0                	test   %al,%al
  800bf8:	74 03                	je     800bfd <strncpy+0x31>
			src++;
  800bfa:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800bfd:	ff 45 fc             	incl   -0x4(%ebp)
  800c00:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c03:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c06:	72 d9                	jb     800be1 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c08:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c0b:	c9                   	leave  
  800c0c:	c3                   	ret    

00800c0d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c0d:	55                   	push   %ebp
  800c0e:	89 e5                	mov    %esp,%ebp
  800c10:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c13:	8b 45 08             	mov    0x8(%ebp),%eax
  800c16:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c19:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c1d:	74 30                	je     800c4f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c1f:	eb 16                	jmp    800c37 <strlcpy+0x2a>
			*dst++ = *src++;
  800c21:	8b 45 08             	mov    0x8(%ebp),%eax
  800c24:	8d 50 01             	lea    0x1(%eax),%edx
  800c27:	89 55 08             	mov    %edx,0x8(%ebp)
  800c2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c2d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c30:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c33:	8a 12                	mov    (%edx),%dl
  800c35:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c37:	ff 4d 10             	decl   0x10(%ebp)
  800c3a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c3e:	74 09                	je     800c49 <strlcpy+0x3c>
  800c40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c43:	8a 00                	mov    (%eax),%al
  800c45:	84 c0                	test   %al,%al
  800c47:	75 d8                	jne    800c21 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c49:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c4f:	8b 55 08             	mov    0x8(%ebp),%edx
  800c52:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c55:	29 c2                	sub    %eax,%edx
  800c57:	89 d0                	mov    %edx,%eax
}
  800c59:	c9                   	leave  
  800c5a:	c3                   	ret    

00800c5b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c5b:	55                   	push   %ebp
  800c5c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c5e:	eb 06                	jmp    800c66 <strcmp+0xb>
		p++, q++;
  800c60:	ff 45 08             	incl   0x8(%ebp)
  800c63:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c66:	8b 45 08             	mov    0x8(%ebp),%eax
  800c69:	8a 00                	mov    (%eax),%al
  800c6b:	84 c0                	test   %al,%al
  800c6d:	74 0e                	je     800c7d <strcmp+0x22>
  800c6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c72:	8a 10                	mov    (%eax),%dl
  800c74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c77:	8a 00                	mov    (%eax),%al
  800c79:	38 c2                	cmp    %al,%dl
  800c7b:	74 e3                	je     800c60 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c80:	8a 00                	mov    (%eax),%al
  800c82:	0f b6 d0             	movzbl %al,%edx
  800c85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c88:	8a 00                	mov    (%eax),%al
  800c8a:	0f b6 c0             	movzbl %al,%eax
  800c8d:	29 c2                	sub    %eax,%edx
  800c8f:	89 d0                	mov    %edx,%eax
}
  800c91:	5d                   	pop    %ebp
  800c92:	c3                   	ret    

00800c93 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c93:	55                   	push   %ebp
  800c94:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c96:	eb 09                	jmp    800ca1 <strncmp+0xe>
		n--, p++, q++;
  800c98:	ff 4d 10             	decl   0x10(%ebp)
  800c9b:	ff 45 08             	incl   0x8(%ebp)
  800c9e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ca1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ca5:	74 17                	je     800cbe <strncmp+0x2b>
  800ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  800caa:	8a 00                	mov    (%eax),%al
  800cac:	84 c0                	test   %al,%al
  800cae:	74 0e                	je     800cbe <strncmp+0x2b>
  800cb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb3:	8a 10                	mov    (%eax),%dl
  800cb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb8:	8a 00                	mov    (%eax),%al
  800cba:	38 c2                	cmp    %al,%dl
  800cbc:	74 da                	je     800c98 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cbe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc2:	75 07                	jne    800ccb <strncmp+0x38>
		return 0;
  800cc4:	b8 00 00 00 00       	mov    $0x0,%eax
  800cc9:	eb 14                	jmp    800cdf <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ccb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cce:	8a 00                	mov    (%eax),%al
  800cd0:	0f b6 d0             	movzbl %al,%edx
  800cd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd6:	8a 00                	mov    (%eax),%al
  800cd8:	0f b6 c0             	movzbl %al,%eax
  800cdb:	29 c2                	sub    %eax,%edx
  800cdd:	89 d0                	mov    %edx,%eax
}
  800cdf:	5d                   	pop    %ebp
  800ce0:	c3                   	ret    

00800ce1 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ce1:	55                   	push   %ebp
  800ce2:	89 e5                	mov    %esp,%ebp
  800ce4:	83 ec 04             	sub    $0x4,%esp
  800ce7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cea:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ced:	eb 12                	jmp    800d01 <strchr+0x20>
		if (*s == c)
  800cef:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf2:	8a 00                	mov    (%eax),%al
  800cf4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cf7:	75 05                	jne    800cfe <strchr+0x1d>
			return (char *) s;
  800cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfc:	eb 11                	jmp    800d0f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800cfe:	ff 45 08             	incl   0x8(%ebp)
  800d01:	8b 45 08             	mov    0x8(%ebp),%eax
  800d04:	8a 00                	mov    (%eax),%al
  800d06:	84 c0                	test   %al,%al
  800d08:	75 e5                	jne    800cef <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d0a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d0f:	c9                   	leave  
  800d10:	c3                   	ret    

00800d11 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d11:	55                   	push   %ebp
  800d12:	89 e5                	mov    %esp,%ebp
  800d14:	83 ec 04             	sub    $0x4,%esp
  800d17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d1d:	eb 0d                	jmp    800d2c <strfind+0x1b>
		if (*s == c)
  800d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d22:	8a 00                	mov    (%eax),%al
  800d24:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d27:	74 0e                	je     800d37 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d29:	ff 45 08             	incl   0x8(%ebp)
  800d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2f:	8a 00                	mov    (%eax),%al
  800d31:	84 c0                	test   %al,%al
  800d33:	75 ea                	jne    800d1f <strfind+0xe>
  800d35:	eb 01                	jmp    800d38 <strfind+0x27>
		if (*s == c)
			break;
  800d37:	90                   	nop
	return (char *) s;
  800d38:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d3b:	c9                   	leave  
  800d3c:	c3                   	ret    

00800d3d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d3d:	55                   	push   %ebp
  800d3e:	89 e5                	mov    %esp,%ebp
  800d40:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d49:	8b 45 10             	mov    0x10(%ebp),%eax
  800d4c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d4f:	eb 0e                	jmp    800d5f <memset+0x22>
		*p++ = c;
  800d51:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d54:	8d 50 01             	lea    0x1(%eax),%edx
  800d57:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d5a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d5d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d5f:	ff 4d f8             	decl   -0x8(%ebp)
  800d62:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d66:	79 e9                	jns    800d51 <memset+0x14>
		*p++ = c;

	return v;
  800d68:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d6b:	c9                   	leave  
  800d6c:	c3                   	ret    

00800d6d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d6d:	55                   	push   %ebp
  800d6e:	89 e5                	mov    %esp,%ebp
  800d70:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d76:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d79:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d7f:	eb 16                	jmp    800d97 <memcpy+0x2a>
		*d++ = *s++;
  800d81:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d84:	8d 50 01             	lea    0x1(%eax),%edx
  800d87:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d8a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d8d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d90:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d93:	8a 12                	mov    (%edx),%dl
  800d95:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d97:	8b 45 10             	mov    0x10(%ebp),%eax
  800d9a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d9d:	89 55 10             	mov    %edx,0x10(%ebp)
  800da0:	85 c0                	test   %eax,%eax
  800da2:	75 dd                	jne    800d81 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800da4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800da7:	c9                   	leave  
  800da8:	c3                   	ret    

00800da9 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800da9:	55                   	push   %ebp
  800daa:	89 e5                	mov    %esp,%ebp
  800dac:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800daf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800db5:	8b 45 08             	mov    0x8(%ebp),%eax
  800db8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800dbb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dbe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dc1:	73 50                	jae    800e13 <memmove+0x6a>
  800dc3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dc6:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc9:	01 d0                	add    %edx,%eax
  800dcb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dce:	76 43                	jbe    800e13 <memmove+0x6a>
		s += n;
  800dd0:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd3:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800dd6:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd9:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ddc:	eb 10                	jmp    800dee <memmove+0x45>
			*--d = *--s;
  800dde:	ff 4d f8             	decl   -0x8(%ebp)
  800de1:	ff 4d fc             	decl   -0x4(%ebp)
  800de4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800de7:	8a 10                	mov    (%eax),%dl
  800de9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dec:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800dee:	8b 45 10             	mov    0x10(%ebp),%eax
  800df1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800df4:	89 55 10             	mov    %edx,0x10(%ebp)
  800df7:	85 c0                	test   %eax,%eax
  800df9:	75 e3                	jne    800dde <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800dfb:	eb 23                	jmp    800e20 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800dfd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e00:	8d 50 01             	lea    0x1(%eax),%edx
  800e03:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e06:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e09:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e0c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e0f:	8a 12                	mov    (%edx),%dl
  800e11:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e13:	8b 45 10             	mov    0x10(%ebp),%eax
  800e16:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e19:	89 55 10             	mov    %edx,0x10(%ebp)
  800e1c:	85 c0                	test   %eax,%eax
  800e1e:	75 dd                	jne    800dfd <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e20:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e23:	c9                   	leave  
  800e24:	c3                   	ret    

00800e25 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e25:	55                   	push   %ebp
  800e26:	89 e5                	mov    %esp,%ebp
  800e28:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e34:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e37:	eb 2a                	jmp    800e63 <memcmp+0x3e>
		if (*s1 != *s2)
  800e39:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e3c:	8a 10                	mov    (%eax),%dl
  800e3e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e41:	8a 00                	mov    (%eax),%al
  800e43:	38 c2                	cmp    %al,%dl
  800e45:	74 16                	je     800e5d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e47:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e4a:	8a 00                	mov    (%eax),%al
  800e4c:	0f b6 d0             	movzbl %al,%edx
  800e4f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e52:	8a 00                	mov    (%eax),%al
  800e54:	0f b6 c0             	movzbl %al,%eax
  800e57:	29 c2                	sub    %eax,%edx
  800e59:	89 d0                	mov    %edx,%eax
  800e5b:	eb 18                	jmp    800e75 <memcmp+0x50>
		s1++, s2++;
  800e5d:	ff 45 fc             	incl   -0x4(%ebp)
  800e60:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e63:	8b 45 10             	mov    0x10(%ebp),%eax
  800e66:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e69:	89 55 10             	mov    %edx,0x10(%ebp)
  800e6c:	85 c0                	test   %eax,%eax
  800e6e:	75 c9                	jne    800e39 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e70:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e75:	c9                   	leave  
  800e76:	c3                   	ret    

00800e77 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e77:	55                   	push   %ebp
  800e78:	89 e5                	mov    %esp,%ebp
  800e7a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e7d:	8b 55 08             	mov    0x8(%ebp),%edx
  800e80:	8b 45 10             	mov    0x10(%ebp),%eax
  800e83:	01 d0                	add    %edx,%eax
  800e85:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e88:	eb 15                	jmp    800e9f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8d:	8a 00                	mov    (%eax),%al
  800e8f:	0f b6 d0             	movzbl %al,%edx
  800e92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e95:	0f b6 c0             	movzbl %al,%eax
  800e98:	39 c2                	cmp    %eax,%edx
  800e9a:	74 0d                	je     800ea9 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e9c:	ff 45 08             	incl   0x8(%ebp)
  800e9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ea5:	72 e3                	jb     800e8a <memfind+0x13>
  800ea7:	eb 01                	jmp    800eaa <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ea9:	90                   	nop
	return (void *) s;
  800eaa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ead:	c9                   	leave  
  800eae:	c3                   	ret    

00800eaf <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800eaf:	55                   	push   %ebp
  800eb0:	89 e5                	mov    %esp,%ebp
  800eb2:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800eb5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ebc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ec3:	eb 03                	jmp    800ec8 <strtol+0x19>
		s++;
  800ec5:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ec8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecb:	8a 00                	mov    (%eax),%al
  800ecd:	3c 20                	cmp    $0x20,%al
  800ecf:	74 f4                	je     800ec5 <strtol+0x16>
  800ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed4:	8a 00                	mov    (%eax),%al
  800ed6:	3c 09                	cmp    $0x9,%al
  800ed8:	74 eb                	je     800ec5 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800eda:	8b 45 08             	mov    0x8(%ebp),%eax
  800edd:	8a 00                	mov    (%eax),%al
  800edf:	3c 2b                	cmp    $0x2b,%al
  800ee1:	75 05                	jne    800ee8 <strtol+0x39>
		s++;
  800ee3:	ff 45 08             	incl   0x8(%ebp)
  800ee6:	eb 13                	jmp    800efb <strtol+0x4c>
	else if (*s == '-')
  800ee8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eeb:	8a 00                	mov    (%eax),%al
  800eed:	3c 2d                	cmp    $0x2d,%al
  800eef:	75 0a                	jne    800efb <strtol+0x4c>
		s++, neg = 1;
  800ef1:	ff 45 08             	incl   0x8(%ebp)
  800ef4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800efb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eff:	74 06                	je     800f07 <strtol+0x58>
  800f01:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f05:	75 20                	jne    800f27 <strtol+0x78>
  800f07:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0a:	8a 00                	mov    (%eax),%al
  800f0c:	3c 30                	cmp    $0x30,%al
  800f0e:	75 17                	jne    800f27 <strtol+0x78>
  800f10:	8b 45 08             	mov    0x8(%ebp),%eax
  800f13:	40                   	inc    %eax
  800f14:	8a 00                	mov    (%eax),%al
  800f16:	3c 78                	cmp    $0x78,%al
  800f18:	75 0d                	jne    800f27 <strtol+0x78>
		s += 2, base = 16;
  800f1a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f1e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f25:	eb 28                	jmp    800f4f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f27:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f2b:	75 15                	jne    800f42 <strtol+0x93>
  800f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f30:	8a 00                	mov    (%eax),%al
  800f32:	3c 30                	cmp    $0x30,%al
  800f34:	75 0c                	jne    800f42 <strtol+0x93>
		s++, base = 8;
  800f36:	ff 45 08             	incl   0x8(%ebp)
  800f39:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f40:	eb 0d                	jmp    800f4f <strtol+0xa0>
	else if (base == 0)
  800f42:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f46:	75 07                	jne    800f4f <strtol+0xa0>
		base = 10;
  800f48:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f52:	8a 00                	mov    (%eax),%al
  800f54:	3c 2f                	cmp    $0x2f,%al
  800f56:	7e 19                	jle    800f71 <strtol+0xc2>
  800f58:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5b:	8a 00                	mov    (%eax),%al
  800f5d:	3c 39                	cmp    $0x39,%al
  800f5f:	7f 10                	jg     800f71 <strtol+0xc2>
			dig = *s - '0';
  800f61:	8b 45 08             	mov    0x8(%ebp),%eax
  800f64:	8a 00                	mov    (%eax),%al
  800f66:	0f be c0             	movsbl %al,%eax
  800f69:	83 e8 30             	sub    $0x30,%eax
  800f6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f6f:	eb 42                	jmp    800fb3 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f71:	8b 45 08             	mov    0x8(%ebp),%eax
  800f74:	8a 00                	mov    (%eax),%al
  800f76:	3c 60                	cmp    $0x60,%al
  800f78:	7e 19                	jle    800f93 <strtol+0xe4>
  800f7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7d:	8a 00                	mov    (%eax),%al
  800f7f:	3c 7a                	cmp    $0x7a,%al
  800f81:	7f 10                	jg     800f93 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f83:	8b 45 08             	mov    0x8(%ebp),%eax
  800f86:	8a 00                	mov    (%eax),%al
  800f88:	0f be c0             	movsbl %al,%eax
  800f8b:	83 e8 57             	sub    $0x57,%eax
  800f8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f91:	eb 20                	jmp    800fb3 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f93:	8b 45 08             	mov    0x8(%ebp),%eax
  800f96:	8a 00                	mov    (%eax),%al
  800f98:	3c 40                	cmp    $0x40,%al
  800f9a:	7e 39                	jle    800fd5 <strtol+0x126>
  800f9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9f:	8a 00                	mov    (%eax),%al
  800fa1:	3c 5a                	cmp    $0x5a,%al
  800fa3:	7f 30                	jg     800fd5 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa8:	8a 00                	mov    (%eax),%al
  800faa:	0f be c0             	movsbl %al,%eax
  800fad:	83 e8 37             	sub    $0x37,%eax
  800fb0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fb6:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fb9:	7d 19                	jge    800fd4 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fbb:	ff 45 08             	incl   0x8(%ebp)
  800fbe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fc1:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fc5:	89 c2                	mov    %eax,%edx
  800fc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fca:	01 d0                	add    %edx,%eax
  800fcc:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fcf:	e9 7b ff ff ff       	jmp    800f4f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fd4:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fd5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fd9:	74 08                	je     800fe3 <strtol+0x134>
		*endptr = (char *) s;
  800fdb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fde:	8b 55 08             	mov    0x8(%ebp),%edx
  800fe1:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fe3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fe7:	74 07                	je     800ff0 <strtol+0x141>
  800fe9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fec:	f7 d8                	neg    %eax
  800fee:	eb 03                	jmp    800ff3 <strtol+0x144>
  800ff0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ff3:	c9                   	leave  
  800ff4:	c3                   	ret    

00800ff5 <ltostr>:

void
ltostr(long value, char *str)
{
  800ff5:	55                   	push   %ebp
  800ff6:	89 e5                	mov    %esp,%ebp
  800ff8:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800ffb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801002:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801009:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80100d:	79 13                	jns    801022 <ltostr+0x2d>
	{
		neg = 1;
  80100f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801016:	8b 45 0c             	mov    0xc(%ebp),%eax
  801019:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80101c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80101f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801022:	8b 45 08             	mov    0x8(%ebp),%eax
  801025:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80102a:	99                   	cltd   
  80102b:	f7 f9                	idiv   %ecx
  80102d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801030:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801033:	8d 50 01             	lea    0x1(%eax),%edx
  801036:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801039:	89 c2                	mov    %eax,%edx
  80103b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103e:	01 d0                	add    %edx,%eax
  801040:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801043:	83 c2 30             	add    $0x30,%edx
  801046:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801048:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80104b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801050:	f7 e9                	imul   %ecx
  801052:	c1 fa 02             	sar    $0x2,%edx
  801055:	89 c8                	mov    %ecx,%eax
  801057:	c1 f8 1f             	sar    $0x1f,%eax
  80105a:	29 c2                	sub    %eax,%edx
  80105c:	89 d0                	mov    %edx,%eax
  80105e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801061:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801064:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801069:	f7 e9                	imul   %ecx
  80106b:	c1 fa 02             	sar    $0x2,%edx
  80106e:	89 c8                	mov    %ecx,%eax
  801070:	c1 f8 1f             	sar    $0x1f,%eax
  801073:	29 c2                	sub    %eax,%edx
  801075:	89 d0                	mov    %edx,%eax
  801077:	c1 e0 02             	shl    $0x2,%eax
  80107a:	01 d0                	add    %edx,%eax
  80107c:	01 c0                	add    %eax,%eax
  80107e:	29 c1                	sub    %eax,%ecx
  801080:	89 ca                	mov    %ecx,%edx
  801082:	85 d2                	test   %edx,%edx
  801084:	75 9c                	jne    801022 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801086:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80108d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801090:	48                   	dec    %eax
  801091:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801094:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801098:	74 3d                	je     8010d7 <ltostr+0xe2>
		start = 1 ;
  80109a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010a1:	eb 34                	jmp    8010d7 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a9:	01 d0                	add    %edx,%eax
  8010ab:	8a 00                	mov    (%eax),%al
  8010ad:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b6:	01 c2                	add    %eax,%edx
  8010b8:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010be:	01 c8                	add    %ecx,%eax
  8010c0:	8a 00                	mov    (%eax),%al
  8010c2:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010c4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ca:	01 c2                	add    %eax,%edx
  8010cc:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010cf:	88 02                	mov    %al,(%edx)
		start++ ;
  8010d1:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010d4:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010da:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010dd:	7c c4                	jl     8010a3 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010df:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e5:	01 d0                	add    %edx,%eax
  8010e7:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010ea:	90                   	nop
  8010eb:	c9                   	leave  
  8010ec:	c3                   	ret    

008010ed <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010ed:	55                   	push   %ebp
  8010ee:	89 e5                	mov    %esp,%ebp
  8010f0:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010f3:	ff 75 08             	pushl  0x8(%ebp)
  8010f6:	e8 54 fa ff ff       	call   800b4f <strlen>
  8010fb:	83 c4 04             	add    $0x4,%esp
  8010fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801101:	ff 75 0c             	pushl  0xc(%ebp)
  801104:	e8 46 fa ff ff       	call   800b4f <strlen>
  801109:	83 c4 04             	add    $0x4,%esp
  80110c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80110f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801116:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80111d:	eb 17                	jmp    801136 <strcconcat+0x49>
		final[s] = str1[s] ;
  80111f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801122:	8b 45 10             	mov    0x10(%ebp),%eax
  801125:	01 c2                	add    %eax,%edx
  801127:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80112a:	8b 45 08             	mov    0x8(%ebp),%eax
  80112d:	01 c8                	add    %ecx,%eax
  80112f:	8a 00                	mov    (%eax),%al
  801131:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801133:	ff 45 fc             	incl   -0x4(%ebp)
  801136:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801139:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80113c:	7c e1                	jl     80111f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80113e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801145:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80114c:	eb 1f                	jmp    80116d <strcconcat+0x80>
		final[s++] = str2[i] ;
  80114e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801151:	8d 50 01             	lea    0x1(%eax),%edx
  801154:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801157:	89 c2                	mov    %eax,%edx
  801159:	8b 45 10             	mov    0x10(%ebp),%eax
  80115c:	01 c2                	add    %eax,%edx
  80115e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801161:	8b 45 0c             	mov    0xc(%ebp),%eax
  801164:	01 c8                	add    %ecx,%eax
  801166:	8a 00                	mov    (%eax),%al
  801168:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80116a:	ff 45 f8             	incl   -0x8(%ebp)
  80116d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801170:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801173:	7c d9                	jl     80114e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801175:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801178:	8b 45 10             	mov    0x10(%ebp),%eax
  80117b:	01 d0                	add    %edx,%eax
  80117d:	c6 00 00             	movb   $0x0,(%eax)
}
  801180:	90                   	nop
  801181:	c9                   	leave  
  801182:	c3                   	ret    

00801183 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801183:	55                   	push   %ebp
  801184:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801186:	8b 45 14             	mov    0x14(%ebp),%eax
  801189:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80118f:	8b 45 14             	mov    0x14(%ebp),%eax
  801192:	8b 00                	mov    (%eax),%eax
  801194:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80119b:	8b 45 10             	mov    0x10(%ebp),%eax
  80119e:	01 d0                	add    %edx,%eax
  8011a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011a6:	eb 0c                	jmp    8011b4 <strsplit+0x31>
			*string++ = 0;
  8011a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ab:	8d 50 01             	lea    0x1(%eax),%edx
  8011ae:	89 55 08             	mov    %edx,0x8(%ebp)
  8011b1:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b7:	8a 00                	mov    (%eax),%al
  8011b9:	84 c0                	test   %al,%al
  8011bb:	74 18                	je     8011d5 <strsplit+0x52>
  8011bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c0:	8a 00                	mov    (%eax),%al
  8011c2:	0f be c0             	movsbl %al,%eax
  8011c5:	50                   	push   %eax
  8011c6:	ff 75 0c             	pushl  0xc(%ebp)
  8011c9:	e8 13 fb ff ff       	call   800ce1 <strchr>
  8011ce:	83 c4 08             	add    $0x8,%esp
  8011d1:	85 c0                	test   %eax,%eax
  8011d3:	75 d3                	jne    8011a8 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8011d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d8:	8a 00                	mov    (%eax),%al
  8011da:	84 c0                	test   %al,%al
  8011dc:	74 5a                	je     801238 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8011de:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e1:	8b 00                	mov    (%eax),%eax
  8011e3:	83 f8 0f             	cmp    $0xf,%eax
  8011e6:	75 07                	jne    8011ef <strsplit+0x6c>
		{
			return 0;
  8011e8:	b8 00 00 00 00       	mov    $0x0,%eax
  8011ed:	eb 66                	jmp    801255 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f2:	8b 00                	mov    (%eax),%eax
  8011f4:	8d 48 01             	lea    0x1(%eax),%ecx
  8011f7:	8b 55 14             	mov    0x14(%ebp),%edx
  8011fa:	89 0a                	mov    %ecx,(%edx)
  8011fc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801203:	8b 45 10             	mov    0x10(%ebp),%eax
  801206:	01 c2                	add    %eax,%edx
  801208:	8b 45 08             	mov    0x8(%ebp),%eax
  80120b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80120d:	eb 03                	jmp    801212 <strsplit+0x8f>
			string++;
  80120f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801212:	8b 45 08             	mov    0x8(%ebp),%eax
  801215:	8a 00                	mov    (%eax),%al
  801217:	84 c0                	test   %al,%al
  801219:	74 8b                	je     8011a6 <strsplit+0x23>
  80121b:	8b 45 08             	mov    0x8(%ebp),%eax
  80121e:	8a 00                	mov    (%eax),%al
  801220:	0f be c0             	movsbl %al,%eax
  801223:	50                   	push   %eax
  801224:	ff 75 0c             	pushl  0xc(%ebp)
  801227:	e8 b5 fa ff ff       	call   800ce1 <strchr>
  80122c:	83 c4 08             	add    $0x8,%esp
  80122f:	85 c0                	test   %eax,%eax
  801231:	74 dc                	je     80120f <strsplit+0x8c>
			string++;
	}
  801233:	e9 6e ff ff ff       	jmp    8011a6 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801238:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801239:	8b 45 14             	mov    0x14(%ebp),%eax
  80123c:	8b 00                	mov    (%eax),%eax
  80123e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801245:	8b 45 10             	mov    0x10(%ebp),%eax
  801248:	01 d0                	add    %edx,%eax
  80124a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801250:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801255:	c9                   	leave  
  801256:	c3                   	ret    

00801257 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801257:	55                   	push   %ebp
  801258:	89 e5                	mov    %esp,%ebp
  80125a:	57                   	push   %edi
  80125b:	56                   	push   %esi
  80125c:	53                   	push   %ebx
  80125d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801260:	8b 45 08             	mov    0x8(%ebp),%eax
  801263:	8b 55 0c             	mov    0xc(%ebp),%edx
  801266:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801269:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80126c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80126f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801272:	cd 30                	int    $0x30
  801274:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801277:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80127a:	83 c4 10             	add    $0x10,%esp
  80127d:	5b                   	pop    %ebx
  80127e:	5e                   	pop    %esi
  80127f:	5f                   	pop    %edi
  801280:	5d                   	pop    %ebp
  801281:	c3                   	ret    

00801282 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801282:	55                   	push   %ebp
  801283:	89 e5                	mov    %esp,%ebp
  801285:	83 ec 04             	sub    $0x4,%esp
  801288:	8b 45 10             	mov    0x10(%ebp),%eax
  80128b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80128e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801292:	8b 45 08             	mov    0x8(%ebp),%eax
  801295:	6a 00                	push   $0x0
  801297:	6a 00                	push   $0x0
  801299:	52                   	push   %edx
  80129a:	ff 75 0c             	pushl  0xc(%ebp)
  80129d:	50                   	push   %eax
  80129e:	6a 00                	push   $0x0
  8012a0:	e8 b2 ff ff ff       	call   801257 <syscall>
  8012a5:	83 c4 18             	add    $0x18,%esp
}
  8012a8:	90                   	nop
  8012a9:	c9                   	leave  
  8012aa:	c3                   	ret    

008012ab <sys_cgetc>:

int
sys_cgetc(void)
{
  8012ab:	55                   	push   %ebp
  8012ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012ae:	6a 00                	push   $0x0
  8012b0:	6a 00                	push   $0x0
  8012b2:	6a 00                	push   $0x0
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 01                	push   $0x1
  8012ba:	e8 98 ff ff ff       	call   801257 <syscall>
  8012bf:	83 c4 18             	add    $0x18,%esp
}
  8012c2:	c9                   	leave  
  8012c3:	c3                   	ret    

008012c4 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012c4:	55                   	push   %ebp
  8012c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ca:	6a 00                	push   $0x0
  8012cc:	6a 00                	push   $0x0
  8012ce:	6a 00                	push   $0x0
  8012d0:	6a 00                	push   $0x0
  8012d2:	50                   	push   %eax
  8012d3:	6a 05                	push   $0x5
  8012d5:	e8 7d ff ff ff       	call   801257 <syscall>
  8012da:	83 c4 18             	add    $0x18,%esp
}
  8012dd:	c9                   	leave  
  8012de:	c3                   	ret    

008012df <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012df:	55                   	push   %ebp
  8012e0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012e2:	6a 00                	push   $0x0
  8012e4:	6a 00                	push   $0x0
  8012e6:	6a 00                	push   $0x0
  8012e8:	6a 00                	push   $0x0
  8012ea:	6a 00                	push   $0x0
  8012ec:	6a 02                	push   $0x2
  8012ee:	e8 64 ff ff ff       	call   801257 <syscall>
  8012f3:	83 c4 18             	add    $0x18,%esp
}
  8012f6:	c9                   	leave  
  8012f7:	c3                   	ret    

008012f8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8012f8:	55                   	push   %ebp
  8012f9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8012fb:	6a 00                	push   $0x0
  8012fd:	6a 00                	push   $0x0
  8012ff:	6a 00                	push   $0x0
  801301:	6a 00                	push   $0x0
  801303:	6a 00                	push   $0x0
  801305:	6a 03                	push   $0x3
  801307:	e8 4b ff ff ff       	call   801257 <syscall>
  80130c:	83 c4 18             	add    $0x18,%esp
}
  80130f:	c9                   	leave  
  801310:	c3                   	ret    

00801311 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801311:	55                   	push   %ebp
  801312:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801314:	6a 00                	push   $0x0
  801316:	6a 00                	push   $0x0
  801318:	6a 00                	push   $0x0
  80131a:	6a 00                	push   $0x0
  80131c:	6a 00                	push   $0x0
  80131e:	6a 04                	push   $0x4
  801320:	e8 32 ff ff ff       	call   801257 <syscall>
  801325:	83 c4 18             	add    $0x18,%esp
}
  801328:	c9                   	leave  
  801329:	c3                   	ret    

0080132a <sys_env_exit>:


void sys_env_exit(void)
{
  80132a:	55                   	push   %ebp
  80132b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80132d:	6a 00                	push   $0x0
  80132f:	6a 00                	push   $0x0
  801331:	6a 00                	push   $0x0
  801333:	6a 00                	push   $0x0
  801335:	6a 00                	push   $0x0
  801337:	6a 06                	push   $0x6
  801339:	e8 19 ff ff ff       	call   801257 <syscall>
  80133e:	83 c4 18             	add    $0x18,%esp
}
  801341:	90                   	nop
  801342:	c9                   	leave  
  801343:	c3                   	ret    

00801344 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801344:	55                   	push   %ebp
  801345:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801347:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134a:	8b 45 08             	mov    0x8(%ebp),%eax
  80134d:	6a 00                	push   $0x0
  80134f:	6a 00                	push   $0x0
  801351:	6a 00                	push   $0x0
  801353:	52                   	push   %edx
  801354:	50                   	push   %eax
  801355:	6a 07                	push   $0x7
  801357:	e8 fb fe ff ff       	call   801257 <syscall>
  80135c:	83 c4 18             	add    $0x18,%esp
}
  80135f:	c9                   	leave  
  801360:	c3                   	ret    

00801361 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801361:	55                   	push   %ebp
  801362:	89 e5                	mov    %esp,%ebp
  801364:	56                   	push   %esi
  801365:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801366:	8b 75 18             	mov    0x18(%ebp),%esi
  801369:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80136c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80136f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801372:	8b 45 08             	mov    0x8(%ebp),%eax
  801375:	56                   	push   %esi
  801376:	53                   	push   %ebx
  801377:	51                   	push   %ecx
  801378:	52                   	push   %edx
  801379:	50                   	push   %eax
  80137a:	6a 08                	push   $0x8
  80137c:	e8 d6 fe ff ff       	call   801257 <syscall>
  801381:	83 c4 18             	add    $0x18,%esp
}
  801384:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801387:	5b                   	pop    %ebx
  801388:	5e                   	pop    %esi
  801389:	5d                   	pop    %ebp
  80138a:	c3                   	ret    

0080138b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80138b:	55                   	push   %ebp
  80138c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80138e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801391:	8b 45 08             	mov    0x8(%ebp),%eax
  801394:	6a 00                	push   $0x0
  801396:	6a 00                	push   $0x0
  801398:	6a 00                	push   $0x0
  80139a:	52                   	push   %edx
  80139b:	50                   	push   %eax
  80139c:	6a 09                	push   $0x9
  80139e:	e8 b4 fe ff ff       	call   801257 <syscall>
  8013a3:	83 c4 18             	add    $0x18,%esp
}
  8013a6:	c9                   	leave  
  8013a7:	c3                   	ret    

008013a8 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013a8:	55                   	push   %ebp
  8013a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013ab:	6a 00                	push   $0x0
  8013ad:	6a 00                	push   $0x0
  8013af:	6a 00                	push   $0x0
  8013b1:	ff 75 0c             	pushl  0xc(%ebp)
  8013b4:	ff 75 08             	pushl  0x8(%ebp)
  8013b7:	6a 0a                	push   $0xa
  8013b9:	e8 99 fe ff ff       	call   801257 <syscall>
  8013be:	83 c4 18             	add    $0x18,%esp
}
  8013c1:	c9                   	leave  
  8013c2:	c3                   	ret    

008013c3 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013c3:	55                   	push   %ebp
  8013c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013c6:	6a 00                	push   $0x0
  8013c8:	6a 00                	push   $0x0
  8013ca:	6a 00                	push   $0x0
  8013cc:	6a 00                	push   $0x0
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 0b                	push   $0xb
  8013d2:	e8 80 fe ff ff       	call   801257 <syscall>
  8013d7:	83 c4 18             	add    $0x18,%esp
}
  8013da:	c9                   	leave  
  8013db:	c3                   	ret    

008013dc <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013dc:	55                   	push   %ebp
  8013dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013df:	6a 00                	push   $0x0
  8013e1:	6a 00                	push   $0x0
  8013e3:	6a 00                	push   $0x0
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 0c                	push   $0xc
  8013eb:	e8 67 fe ff ff       	call   801257 <syscall>
  8013f0:	83 c4 18             	add    $0x18,%esp
}
  8013f3:	c9                   	leave  
  8013f4:	c3                   	ret    

008013f5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013f5:	55                   	push   %ebp
  8013f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013f8:	6a 00                	push   $0x0
  8013fa:	6a 00                	push   $0x0
  8013fc:	6a 00                	push   $0x0
  8013fe:	6a 00                	push   $0x0
  801400:	6a 00                	push   $0x0
  801402:	6a 0d                	push   $0xd
  801404:	e8 4e fe ff ff       	call   801257 <syscall>
  801409:	83 c4 18             	add    $0x18,%esp
}
  80140c:	c9                   	leave  
  80140d:	c3                   	ret    

0080140e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80140e:	55                   	push   %ebp
  80140f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801411:	6a 00                	push   $0x0
  801413:	6a 00                	push   $0x0
  801415:	6a 00                	push   $0x0
  801417:	ff 75 0c             	pushl  0xc(%ebp)
  80141a:	ff 75 08             	pushl  0x8(%ebp)
  80141d:	6a 11                	push   $0x11
  80141f:	e8 33 fe ff ff       	call   801257 <syscall>
  801424:	83 c4 18             	add    $0x18,%esp
	return;
  801427:	90                   	nop
}
  801428:	c9                   	leave  
  801429:	c3                   	ret    

0080142a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80142a:	55                   	push   %ebp
  80142b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80142d:	6a 00                	push   $0x0
  80142f:	6a 00                	push   $0x0
  801431:	6a 00                	push   $0x0
  801433:	ff 75 0c             	pushl  0xc(%ebp)
  801436:	ff 75 08             	pushl  0x8(%ebp)
  801439:	6a 12                	push   $0x12
  80143b:	e8 17 fe ff ff       	call   801257 <syscall>
  801440:	83 c4 18             	add    $0x18,%esp
	return ;
  801443:	90                   	nop
}
  801444:	c9                   	leave  
  801445:	c3                   	ret    

00801446 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801446:	55                   	push   %ebp
  801447:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801449:	6a 00                	push   $0x0
  80144b:	6a 00                	push   $0x0
  80144d:	6a 00                	push   $0x0
  80144f:	6a 00                	push   $0x0
  801451:	6a 00                	push   $0x0
  801453:	6a 0e                	push   $0xe
  801455:	e8 fd fd ff ff       	call   801257 <syscall>
  80145a:	83 c4 18             	add    $0x18,%esp
}
  80145d:	c9                   	leave  
  80145e:	c3                   	ret    

0080145f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80145f:	55                   	push   %ebp
  801460:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801462:	6a 00                	push   $0x0
  801464:	6a 00                	push   $0x0
  801466:	6a 00                	push   $0x0
  801468:	6a 00                	push   $0x0
  80146a:	ff 75 08             	pushl  0x8(%ebp)
  80146d:	6a 0f                	push   $0xf
  80146f:	e8 e3 fd ff ff       	call   801257 <syscall>
  801474:	83 c4 18             	add    $0x18,%esp
}
  801477:	c9                   	leave  
  801478:	c3                   	ret    

00801479 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801479:	55                   	push   %ebp
  80147a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80147c:	6a 00                	push   $0x0
  80147e:	6a 00                	push   $0x0
  801480:	6a 00                	push   $0x0
  801482:	6a 00                	push   $0x0
  801484:	6a 00                	push   $0x0
  801486:	6a 10                	push   $0x10
  801488:	e8 ca fd ff ff       	call   801257 <syscall>
  80148d:	83 c4 18             	add    $0x18,%esp
}
  801490:	90                   	nop
  801491:	c9                   	leave  
  801492:	c3                   	ret    

00801493 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801493:	55                   	push   %ebp
  801494:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	6a 00                	push   $0x0
  80149e:	6a 00                	push   $0x0
  8014a0:	6a 14                	push   $0x14
  8014a2:	e8 b0 fd ff ff       	call   801257 <syscall>
  8014a7:	83 c4 18             	add    $0x18,%esp
}
  8014aa:	90                   	nop
  8014ab:	c9                   	leave  
  8014ac:	c3                   	ret    

008014ad <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014ad:	55                   	push   %ebp
  8014ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014b0:	6a 00                	push   $0x0
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	6a 15                	push   $0x15
  8014bc:	e8 96 fd ff ff       	call   801257 <syscall>
  8014c1:	83 c4 18             	add    $0x18,%esp
}
  8014c4:	90                   	nop
  8014c5:	c9                   	leave  
  8014c6:	c3                   	ret    

008014c7 <sys_cputc>:


void
sys_cputc(const char c)
{
  8014c7:	55                   	push   %ebp
  8014c8:	89 e5                	mov    %esp,%ebp
  8014ca:	83 ec 04             	sub    $0x4,%esp
  8014cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014d3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	50                   	push   %eax
  8014e0:	6a 16                	push   $0x16
  8014e2:	e8 70 fd ff ff       	call   801257 <syscall>
  8014e7:	83 c4 18             	add    $0x18,%esp
}
  8014ea:	90                   	nop
  8014eb:	c9                   	leave  
  8014ec:	c3                   	ret    

008014ed <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014ed:	55                   	push   %ebp
  8014ee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 17                	push   $0x17
  8014fc:	e8 56 fd ff ff       	call   801257 <syscall>
  801501:	83 c4 18             	add    $0x18,%esp
}
  801504:	90                   	nop
  801505:	c9                   	leave  
  801506:	c3                   	ret    

00801507 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801507:	55                   	push   %ebp
  801508:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80150a:	8b 45 08             	mov    0x8(%ebp),%eax
  80150d:	6a 00                	push   $0x0
  80150f:	6a 00                	push   $0x0
  801511:	6a 00                	push   $0x0
  801513:	ff 75 0c             	pushl  0xc(%ebp)
  801516:	50                   	push   %eax
  801517:	6a 18                	push   $0x18
  801519:	e8 39 fd ff ff       	call   801257 <syscall>
  80151e:	83 c4 18             	add    $0x18,%esp
}
  801521:	c9                   	leave  
  801522:	c3                   	ret    

00801523 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801523:	55                   	push   %ebp
  801524:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801526:	8b 55 0c             	mov    0xc(%ebp),%edx
  801529:	8b 45 08             	mov    0x8(%ebp),%eax
  80152c:	6a 00                	push   $0x0
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	52                   	push   %edx
  801533:	50                   	push   %eax
  801534:	6a 1b                	push   $0x1b
  801536:	e8 1c fd ff ff       	call   801257 <syscall>
  80153b:	83 c4 18             	add    $0x18,%esp
}
  80153e:	c9                   	leave  
  80153f:	c3                   	ret    

00801540 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801540:	55                   	push   %ebp
  801541:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801543:	8b 55 0c             	mov    0xc(%ebp),%edx
  801546:	8b 45 08             	mov    0x8(%ebp),%eax
  801549:	6a 00                	push   $0x0
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	52                   	push   %edx
  801550:	50                   	push   %eax
  801551:	6a 19                	push   $0x19
  801553:	e8 ff fc ff ff       	call   801257 <syscall>
  801558:	83 c4 18             	add    $0x18,%esp
}
  80155b:	90                   	nop
  80155c:	c9                   	leave  
  80155d:	c3                   	ret    

0080155e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80155e:	55                   	push   %ebp
  80155f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801561:	8b 55 0c             	mov    0xc(%ebp),%edx
  801564:	8b 45 08             	mov    0x8(%ebp),%eax
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	52                   	push   %edx
  80156e:	50                   	push   %eax
  80156f:	6a 1a                	push   $0x1a
  801571:	e8 e1 fc ff ff       	call   801257 <syscall>
  801576:	83 c4 18             	add    $0x18,%esp
}
  801579:	90                   	nop
  80157a:	c9                   	leave  
  80157b:	c3                   	ret    

0080157c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80157c:	55                   	push   %ebp
  80157d:	89 e5                	mov    %esp,%ebp
  80157f:	83 ec 04             	sub    $0x4,%esp
  801582:	8b 45 10             	mov    0x10(%ebp),%eax
  801585:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801588:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80158b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80158f:	8b 45 08             	mov    0x8(%ebp),%eax
  801592:	6a 00                	push   $0x0
  801594:	51                   	push   %ecx
  801595:	52                   	push   %edx
  801596:	ff 75 0c             	pushl  0xc(%ebp)
  801599:	50                   	push   %eax
  80159a:	6a 1c                	push   $0x1c
  80159c:	e8 b6 fc ff ff       	call   801257 <syscall>
  8015a1:	83 c4 18             	add    $0x18,%esp
}
  8015a4:	c9                   	leave  
  8015a5:	c3                   	ret    

008015a6 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015a6:	55                   	push   %ebp
  8015a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 00                	push   $0x0
  8015b5:	52                   	push   %edx
  8015b6:	50                   	push   %eax
  8015b7:	6a 1d                	push   $0x1d
  8015b9:	e8 99 fc ff ff       	call   801257 <syscall>
  8015be:	83 c4 18             	add    $0x18,%esp
}
  8015c1:	c9                   	leave  
  8015c2:	c3                   	ret    

008015c3 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015c3:	55                   	push   %ebp
  8015c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015c6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cf:	6a 00                	push   $0x0
  8015d1:	6a 00                	push   $0x0
  8015d3:	51                   	push   %ecx
  8015d4:	52                   	push   %edx
  8015d5:	50                   	push   %eax
  8015d6:	6a 1e                	push   $0x1e
  8015d8:	e8 7a fc ff ff       	call   801257 <syscall>
  8015dd:	83 c4 18             	add    $0x18,%esp
}
  8015e0:	c9                   	leave  
  8015e1:	c3                   	ret    

008015e2 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015e2:	55                   	push   %ebp
  8015e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015eb:	6a 00                	push   $0x0
  8015ed:	6a 00                	push   $0x0
  8015ef:	6a 00                	push   $0x0
  8015f1:	52                   	push   %edx
  8015f2:	50                   	push   %eax
  8015f3:	6a 1f                	push   $0x1f
  8015f5:	e8 5d fc ff ff       	call   801257 <syscall>
  8015fa:	83 c4 18             	add    $0x18,%esp
}
  8015fd:	c9                   	leave  
  8015fe:	c3                   	ret    

008015ff <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8015ff:	55                   	push   %ebp
  801600:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801602:	6a 00                	push   $0x0
  801604:	6a 00                	push   $0x0
  801606:	6a 00                	push   $0x0
  801608:	6a 00                	push   $0x0
  80160a:	6a 00                	push   $0x0
  80160c:	6a 20                	push   $0x20
  80160e:	e8 44 fc ff ff       	call   801257 <syscall>
  801613:	83 c4 18             	add    $0x18,%esp
}
  801616:	c9                   	leave  
  801617:	c3                   	ret    

00801618 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801618:	55                   	push   %ebp
  801619:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80161b:	8b 45 08             	mov    0x8(%ebp),%eax
  80161e:	6a 00                	push   $0x0
  801620:	ff 75 14             	pushl  0x14(%ebp)
  801623:	ff 75 10             	pushl  0x10(%ebp)
  801626:	ff 75 0c             	pushl  0xc(%ebp)
  801629:	50                   	push   %eax
  80162a:	6a 21                	push   $0x21
  80162c:	e8 26 fc ff ff       	call   801257 <syscall>
  801631:	83 c4 18             	add    $0x18,%esp
}
  801634:	c9                   	leave  
  801635:	c3                   	ret    

00801636 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801636:	55                   	push   %ebp
  801637:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801639:	8b 45 08             	mov    0x8(%ebp),%eax
  80163c:	6a 00                	push   $0x0
  80163e:	6a 00                	push   $0x0
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	50                   	push   %eax
  801645:	6a 22                	push   $0x22
  801647:	e8 0b fc ff ff       	call   801257 <syscall>
  80164c:	83 c4 18             	add    $0x18,%esp
}
  80164f:	90                   	nop
  801650:	c9                   	leave  
  801651:	c3                   	ret    

00801652 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801652:	55                   	push   %ebp
  801653:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801655:	8b 45 08             	mov    0x8(%ebp),%eax
  801658:	6a 00                	push   $0x0
  80165a:	6a 00                	push   $0x0
  80165c:	6a 00                	push   $0x0
  80165e:	6a 00                	push   $0x0
  801660:	50                   	push   %eax
  801661:	6a 23                	push   $0x23
  801663:	e8 ef fb ff ff       	call   801257 <syscall>
  801668:	83 c4 18             	add    $0x18,%esp
}
  80166b:	90                   	nop
  80166c:	c9                   	leave  
  80166d:	c3                   	ret    

0080166e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80166e:	55                   	push   %ebp
  80166f:	89 e5                	mov    %esp,%ebp
  801671:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801674:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801677:	8d 50 04             	lea    0x4(%eax),%edx
  80167a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	6a 00                	push   $0x0
  801683:	52                   	push   %edx
  801684:	50                   	push   %eax
  801685:	6a 24                	push   $0x24
  801687:	e8 cb fb ff ff       	call   801257 <syscall>
  80168c:	83 c4 18             	add    $0x18,%esp
	return result;
  80168f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801692:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801695:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801698:	89 01                	mov    %eax,(%ecx)
  80169a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80169d:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a0:	c9                   	leave  
  8016a1:	c2 04 00             	ret    $0x4

008016a4 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016a4:	55                   	push   %ebp
  8016a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 00                	push   $0x0
  8016ab:	ff 75 10             	pushl  0x10(%ebp)
  8016ae:	ff 75 0c             	pushl  0xc(%ebp)
  8016b1:	ff 75 08             	pushl  0x8(%ebp)
  8016b4:	6a 13                	push   $0x13
  8016b6:	e8 9c fb ff ff       	call   801257 <syscall>
  8016bb:	83 c4 18             	add    $0x18,%esp
	return ;
  8016be:	90                   	nop
}
  8016bf:	c9                   	leave  
  8016c0:	c3                   	ret    

008016c1 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016c1:	55                   	push   %ebp
  8016c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016c4:	6a 00                	push   $0x0
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 25                	push   $0x25
  8016d0:	e8 82 fb ff ff       	call   801257 <syscall>
  8016d5:	83 c4 18             	add    $0x18,%esp
}
  8016d8:	c9                   	leave  
  8016d9:	c3                   	ret    

008016da <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016da:	55                   	push   %ebp
  8016db:	89 e5                	mov    %esp,%ebp
  8016dd:	83 ec 04             	sub    $0x4,%esp
  8016e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016e6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016ea:	6a 00                	push   $0x0
  8016ec:	6a 00                	push   $0x0
  8016ee:	6a 00                	push   $0x0
  8016f0:	6a 00                	push   $0x0
  8016f2:	50                   	push   %eax
  8016f3:	6a 26                	push   $0x26
  8016f5:	e8 5d fb ff ff       	call   801257 <syscall>
  8016fa:	83 c4 18             	add    $0x18,%esp
	return ;
  8016fd:	90                   	nop
}
  8016fe:	c9                   	leave  
  8016ff:	c3                   	ret    

00801700 <rsttst>:
void rsttst()
{
  801700:	55                   	push   %ebp
  801701:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801703:	6a 00                	push   $0x0
  801705:	6a 00                	push   $0x0
  801707:	6a 00                	push   $0x0
  801709:	6a 00                	push   $0x0
  80170b:	6a 00                	push   $0x0
  80170d:	6a 28                	push   $0x28
  80170f:	e8 43 fb ff ff       	call   801257 <syscall>
  801714:	83 c4 18             	add    $0x18,%esp
	return ;
  801717:	90                   	nop
}
  801718:	c9                   	leave  
  801719:	c3                   	ret    

0080171a <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80171a:	55                   	push   %ebp
  80171b:	89 e5                	mov    %esp,%ebp
  80171d:	83 ec 04             	sub    $0x4,%esp
  801720:	8b 45 14             	mov    0x14(%ebp),%eax
  801723:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801726:	8b 55 18             	mov    0x18(%ebp),%edx
  801729:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80172d:	52                   	push   %edx
  80172e:	50                   	push   %eax
  80172f:	ff 75 10             	pushl  0x10(%ebp)
  801732:	ff 75 0c             	pushl  0xc(%ebp)
  801735:	ff 75 08             	pushl  0x8(%ebp)
  801738:	6a 27                	push   $0x27
  80173a:	e8 18 fb ff ff       	call   801257 <syscall>
  80173f:	83 c4 18             	add    $0x18,%esp
	return ;
  801742:	90                   	nop
}
  801743:	c9                   	leave  
  801744:	c3                   	ret    

00801745 <chktst>:
void chktst(uint32 n)
{
  801745:	55                   	push   %ebp
  801746:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801748:	6a 00                	push   $0x0
  80174a:	6a 00                	push   $0x0
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	ff 75 08             	pushl  0x8(%ebp)
  801753:	6a 29                	push   $0x29
  801755:	e8 fd fa ff ff       	call   801257 <syscall>
  80175a:	83 c4 18             	add    $0x18,%esp
	return ;
  80175d:	90                   	nop
}
  80175e:	c9                   	leave  
  80175f:	c3                   	ret    

00801760 <inctst>:

void inctst()
{
  801760:	55                   	push   %ebp
  801761:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 2a                	push   $0x2a
  80176f:	e8 e3 fa ff ff       	call   801257 <syscall>
  801774:	83 c4 18             	add    $0x18,%esp
	return ;
  801777:	90                   	nop
}
  801778:	c9                   	leave  
  801779:	c3                   	ret    

0080177a <gettst>:
uint32 gettst()
{
  80177a:	55                   	push   %ebp
  80177b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 2b                	push   $0x2b
  801789:	e8 c9 fa ff ff       	call   801257 <syscall>
  80178e:	83 c4 18             	add    $0x18,%esp
}
  801791:	c9                   	leave  
  801792:	c3                   	ret    

00801793 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801793:	55                   	push   %ebp
  801794:	89 e5                	mov    %esp,%ebp
  801796:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 2c                	push   $0x2c
  8017a5:	e8 ad fa ff ff       	call   801257 <syscall>
  8017aa:	83 c4 18             	add    $0x18,%esp
  8017ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017b0:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017b4:	75 07                	jne    8017bd <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017b6:	b8 01 00 00 00       	mov    $0x1,%eax
  8017bb:	eb 05                	jmp    8017c2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017bd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017c2:	c9                   	leave  
  8017c3:	c3                   	ret    

008017c4 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017c4:	55                   	push   %ebp
  8017c5:	89 e5                	mov    %esp,%ebp
  8017c7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 2c                	push   $0x2c
  8017d6:	e8 7c fa ff ff       	call   801257 <syscall>
  8017db:	83 c4 18             	add    $0x18,%esp
  8017de:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017e1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017e5:	75 07                	jne    8017ee <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017e7:	b8 01 00 00 00       	mov    $0x1,%eax
  8017ec:	eb 05                	jmp    8017f3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017f3:	c9                   	leave  
  8017f4:	c3                   	ret    

008017f5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8017f5:	55                   	push   %ebp
  8017f6:	89 e5                	mov    %esp,%ebp
  8017f8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	6a 2c                	push   $0x2c
  801807:	e8 4b fa ff ff       	call   801257 <syscall>
  80180c:	83 c4 18             	add    $0x18,%esp
  80180f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801812:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801816:	75 07                	jne    80181f <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801818:	b8 01 00 00 00       	mov    $0x1,%eax
  80181d:	eb 05                	jmp    801824 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80181f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801824:	c9                   	leave  
  801825:	c3                   	ret    

00801826 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801826:	55                   	push   %ebp
  801827:	89 e5                	mov    %esp,%ebp
  801829:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 2c                	push   $0x2c
  801838:	e8 1a fa ff ff       	call   801257 <syscall>
  80183d:	83 c4 18             	add    $0x18,%esp
  801840:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801843:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801847:	75 07                	jne    801850 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801849:	b8 01 00 00 00       	mov    $0x1,%eax
  80184e:	eb 05                	jmp    801855 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801850:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801855:	c9                   	leave  
  801856:	c3                   	ret    

00801857 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801857:	55                   	push   %ebp
  801858:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80185a:	6a 00                	push   $0x0
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	ff 75 08             	pushl  0x8(%ebp)
  801865:	6a 2d                	push   $0x2d
  801867:	e8 eb f9 ff ff       	call   801257 <syscall>
  80186c:	83 c4 18             	add    $0x18,%esp
	return ;
  80186f:	90                   	nop
}
  801870:	c9                   	leave  
  801871:	c3                   	ret    

00801872 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801872:	55                   	push   %ebp
  801873:	89 e5                	mov    %esp,%ebp
  801875:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801876:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801879:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80187c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80187f:	8b 45 08             	mov    0x8(%ebp),%eax
  801882:	6a 00                	push   $0x0
  801884:	53                   	push   %ebx
  801885:	51                   	push   %ecx
  801886:	52                   	push   %edx
  801887:	50                   	push   %eax
  801888:	6a 2e                	push   $0x2e
  80188a:	e8 c8 f9 ff ff       	call   801257 <syscall>
  80188f:	83 c4 18             	add    $0x18,%esp
}
  801892:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801895:	c9                   	leave  
  801896:	c3                   	ret    

00801897 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801897:	55                   	push   %ebp
  801898:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80189a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80189d:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a0:	6a 00                	push   $0x0
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 00                	push   $0x0
  8018a6:	52                   	push   %edx
  8018a7:	50                   	push   %eax
  8018a8:	6a 2f                	push   $0x2f
  8018aa:	e8 a8 f9 ff ff       	call   801257 <syscall>
  8018af:	83 c4 18             	add    $0x18,%esp
}
  8018b2:	c9                   	leave  
  8018b3:	c3                   	ret    

008018b4 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8018b4:	55                   	push   %ebp
  8018b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8018b7:	6a 00                	push   $0x0
  8018b9:	6a 00                	push   $0x0
  8018bb:	6a 00                	push   $0x0
  8018bd:	ff 75 0c             	pushl  0xc(%ebp)
  8018c0:	ff 75 08             	pushl  0x8(%ebp)
  8018c3:	6a 30                	push   $0x30
  8018c5:	e8 8d f9 ff ff       	call   801257 <syscall>
  8018ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8018cd:	90                   	nop
}
  8018ce:	c9                   	leave  
  8018cf:	c3                   	ret    

008018d0 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8018d0:	55                   	push   %ebp
  8018d1:	89 e5                	mov    %esp,%ebp
  8018d3:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8018d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d9:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8018dc:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8018e0:	83 ec 0c             	sub    $0xc,%esp
  8018e3:	50                   	push   %eax
  8018e4:	e8 de fb ff ff       	call   8014c7 <sys_cputc>
  8018e9:	83 c4 10             	add    $0x10,%esp
}
  8018ec:	90                   	nop
  8018ed:	c9                   	leave  
  8018ee:	c3                   	ret    

008018ef <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8018ef:	55                   	push   %ebp
  8018f0:	89 e5                	mov    %esp,%ebp
  8018f2:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8018f5:	e8 99 fb ff ff       	call   801493 <sys_disable_interrupt>
	char c = ch;
  8018fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fd:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  801900:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  801904:	83 ec 0c             	sub    $0xc,%esp
  801907:	50                   	push   %eax
  801908:	e8 ba fb ff ff       	call   8014c7 <sys_cputc>
  80190d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  801910:	e8 98 fb ff ff       	call   8014ad <sys_enable_interrupt>
}
  801915:	90                   	nop
  801916:	c9                   	leave  
  801917:	c3                   	ret    

00801918 <getchar>:

int
getchar(void)
{
  801918:	55                   	push   %ebp
  801919:	89 e5                	mov    %esp,%ebp
  80191b:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  80191e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801925:	eb 08                	jmp    80192f <getchar+0x17>
	{
		c = sys_cgetc();
  801927:	e8 7f f9 ff ff       	call   8012ab <sys_cgetc>
  80192c:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  80192f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801933:	74 f2                	je     801927 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  801935:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801938:	c9                   	leave  
  801939:	c3                   	ret    

0080193a <atomic_getchar>:

int
atomic_getchar(void)
{
  80193a:	55                   	push   %ebp
  80193b:	89 e5                	mov    %esp,%ebp
  80193d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801940:	e8 4e fb ff ff       	call   801493 <sys_disable_interrupt>
	int c=0;
  801945:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80194c:	eb 08                	jmp    801956 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  80194e:	e8 58 f9 ff ff       	call   8012ab <sys_cgetc>
  801953:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  801956:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80195a:	74 f2                	je     80194e <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  80195c:	e8 4c fb ff ff       	call   8014ad <sys_enable_interrupt>
	return c;
  801961:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801964:	c9                   	leave  
  801965:	c3                   	ret    

00801966 <iscons>:

int iscons(int fdnum)
{
  801966:	55                   	push   %ebp
  801967:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  801969:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80196e:	5d                   	pop    %ebp
  80196f:	c3                   	ret    

00801970 <__udivdi3>:
  801970:	55                   	push   %ebp
  801971:	57                   	push   %edi
  801972:	56                   	push   %esi
  801973:	53                   	push   %ebx
  801974:	83 ec 1c             	sub    $0x1c,%esp
  801977:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80197b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80197f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801983:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801987:	89 ca                	mov    %ecx,%edx
  801989:	89 f8                	mov    %edi,%eax
  80198b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80198f:	85 f6                	test   %esi,%esi
  801991:	75 2d                	jne    8019c0 <__udivdi3+0x50>
  801993:	39 cf                	cmp    %ecx,%edi
  801995:	77 65                	ja     8019fc <__udivdi3+0x8c>
  801997:	89 fd                	mov    %edi,%ebp
  801999:	85 ff                	test   %edi,%edi
  80199b:	75 0b                	jne    8019a8 <__udivdi3+0x38>
  80199d:	b8 01 00 00 00       	mov    $0x1,%eax
  8019a2:	31 d2                	xor    %edx,%edx
  8019a4:	f7 f7                	div    %edi
  8019a6:	89 c5                	mov    %eax,%ebp
  8019a8:	31 d2                	xor    %edx,%edx
  8019aa:	89 c8                	mov    %ecx,%eax
  8019ac:	f7 f5                	div    %ebp
  8019ae:	89 c1                	mov    %eax,%ecx
  8019b0:	89 d8                	mov    %ebx,%eax
  8019b2:	f7 f5                	div    %ebp
  8019b4:	89 cf                	mov    %ecx,%edi
  8019b6:	89 fa                	mov    %edi,%edx
  8019b8:	83 c4 1c             	add    $0x1c,%esp
  8019bb:	5b                   	pop    %ebx
  8019bc:	5e                   	pop    %esi
  8019bd:	5f                   	pop    %edi
  8019be:	5d                   	pop    %ebp
  8019bf:	c3                   	ret    
  8019c0:	39 ce                	cmp    %ecx,%esi
  8019c2:	77 28                	ja     8019ec <__udivdi3+0x7c>
  8019c4:	0f bd fe             	bsr    %esi,%edi
  8019c7:	83 f7 1f             	xor    $0x1f,%edi
  8019ca:	75 40                	jne    801a0c <__udivdi3+0x9c>
  8019cc:	39 ce                	cmp    %ecx,%esi
  8019ce:	72 0a                	jb     8019da <__udivdi3+0x6a>
  8019d0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8019d4:	0f 87 9e 00 00 00    	ja     801a78 <__udivdi3+0x108>
  8019da:	b8 01 00 00 00       	mov    $0x1,%eax
  8019df:	89 fa                	mov    %edi,%edx
  8019e1:	83 c4 1c             	add    $0x1c,%esp
  8019e4:	5b                   	pop    %ebx
  8019e5:	5e                   	pop    %esi
  8019e6:	5f                   	pop    %edi
  8019e7:	5d                   	pop    %ebp
  8019e8:	c3                   	ret    
  8019e9:	8d 76 00             	lea    0x0(%esi),%esi
  8019ec:	31 ff                	xor    %edi,%edi
  8019ee:	31 c0                	xor    %eax,%eax
  8019f0:	89 fa                	mov    %edi,%edx
  8019f2:	83 c4 1c             	add    $0x1c,%esp
  8019f5:	5b                   	pop    %ebx
  8019f6:	5e                   	pop    %esi
  8019f7:	5f                   	pop    %edi
  8019f8:	5d                   	pop    %ebp
  8019f9:	c3                   	ret    
  8019fa:	66 90                	xchg   %ax,%ax
  8019fc:	89 d8                	mov    %ebx,%eax
  8019fe:	f7 f7                	div    %edi
  801a00:	31 ff                	xor    %edi,%edi
  801a02:	89 fa                	mov    %edi,%edx
  801a04:	83 c4 1c             	add    $0x1c,%esp
  801a07:	5b                   	pop    %ebx
  801a08:	5e                   	pop    %esi
  801a09:	5f                   	pop    %edi
  801a0a:	5d                   	pop    %ebp
  801a0b:	c3                   	ret    
  801a0c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a11:	89 eb                	mov    %ebp,%ebx
  801a13:	29 fb                	sub    %edi,%ebx
  801a15:	89 f9                	mov    %edi,%ecx
  801a17:	d3 e6                	shl    %cl,%esi
  801a19:	89 c5                	mov    %eax,%ebp
  801a1b:	88 d9                	mov    %bl,%cl
  801a1d:	d3 ed                	shr    %cl,%ebp
  801a1f:	89 e9                	mov    %ebp,%ecx
  801a21:	09 f1                	or     %esi,%ecx
  801a23:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a27:	89 f9                	mov    %edi,%ecx
  801a29:	d3 e0                	shl    %cl,%eax
  801a2b:	89 c5                	mov    %eax,%ebp
  801a2d:	89 d6                	mov    %edx,%esi
  801a2f:	88 d9                	mov    %bl,%cl
  801a31:	d3 ee                	shr    %cl,%esi
  801a33:	89 f9                	mov    %edi,%ecx
  801a35:	d3 e2                	shl    %cl,%edx
  801a37:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a3b:	88 d9                	mov    %bl,%cl
  801a3d:	d3 e8                	shr    %cl,%eax
  801a3f:	09 c2                	or     %eax,%edx
  801a41:	89 d0                	mov    %edx,%eax
  801a43:	89 f2                	mov    %esi,%edx
  801a45:	f7 74 24 0c          	divl   0xc(%esp)
  801a49:	89 d6                	mov    %edx,%esi
  801a4b:	89 c3                	mov    %eax,%ebx
  801a4d:	f7 e5                	mul    %ebp
  801a4f:	39 d6                	cmp    %edx,%esi
  801a51:	72 19                	jb     801a6c <__udivdi3+0xfc>
  801a53:	74 0b                	je     801a60 <__udivdi3+0xf0>
  801a55:	89 d8                	mov    %ebx,%eax
  801a57:	31 ff                	xor    %edi,%edi
  801a59:	e9 58 ff ff ff       	jmp    8019b6 <__udivdi3+0x46>
  801a5e:	66 90                	xchg   %ax,%ax
  801a60:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a64:	89 f9                	mov    %edi,%ecx
  801a66:	d3 e2                	shl    %cl,%edx
  801a68:	39 c2                	cmp    %eax,%edx
  801a6a:	73 e9                	jae    801a55 <__udivdi3+0xe5>
  801a6c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a6f:	31 ff                	xor    %edi,%edi
  801a71:	e9 40 ff ff ff       	jmp    8019b6 <__udivdi3+0x46>
  801a76:	66 90                	xchg   %ax,%ax
  801a78:	31 c0                	xor    %eax,%eax
  801a7a:	e9 37 ff ff ff       	jmp    8019b6 <__udivdi3+0x46>
  801a7f:	90                   	nop

00801a80 <__umoddi3>:
  801a80:	55                   	push   %ebp
  801a81:	57                   	push   %edi
  801a82:	56                   	push   %esi
  801a83:	53                   	push   %ebx
  801a84:	83 ec 1c             	sub    $0x1c,%esp
  801a87:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a8b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a8f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a93:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a97:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a9b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a9f:	89 f3                	mov    %esi,%ebx
  801aa1:	89 fa                	mov    %edi,%edx
  801aa3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801aa7:	89 34 24             	mov    %esi,(%esp)
  801aaa:	85 c0                	test   %eax,%eax
  801aac:	75 1a                	jne    801ac8 <__umoddi3+0x48>
  801aae:	39 f7                	cmp    %esi,%edi
  801ab0:	0f 86 a2 00 00 00    	jbe    801b58 <__umoddi3+0xd8>
  801ab6:	89 c8                	mov    %ecx,%eax
  801ab8:	89 f2                	mov    %esi,%edx
  801aba:	f7 f7                	div    %edi
  801abc:	89 d0                	mov    %edx,%eax
  801abe:	31 d2                	xor    %edx,%edx
  801ac0:	83 c4 1c             	add    $0x1c,%esp
  801ac3:	5b                   	pop    %ebx
  801ac4:	5e                   	pop    %esi
  801ac5:	5f                   	pop    %edi
  801ac6:	5d                   	pop    %ebp
  801ac7:	c3                   	ret    
  801ac8:	39 f0                	cmp    %esi,%eax
  801aca:	0f 87 ac 00 00 00    	ja     801b7c <__umoddi3+0xfc>
  801ad0:	0f bd e8             	bsr    %eax,%ebp
  801ad3:	83 f5 1f             	xor    $0x1f,%ebp
  801ad6:	0f 84 ac 00 00 00    	je     801b88 <__umoddi3+0x108>
  801adc:	bf 20 00 00 00       	mov    $0x20,%edi
  801ae1:	29 ef                	sub    %ebp,%edi
  801ae3:	89 fe                	mov    %edi,%esi
  801ae5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ae9:	89 e9                	mov    %ebp,%ecx
  801aeb:	d3 e0                	shl    %cl,%eax
  801aed:	89 d7                	mov    %edx,%edi
  801aef:	89 f1                	mov    %esi,%ecx
  801af1:	d3 ef                	shr    %cl,%edi
  801af3:	09 c7                	or     %eax,%edi
  801af5:	89 e9                	mov    %ebp,%ecx
  801af7:	d3 e2                	shl    %cl,%edx
  801af9:	89 14 24             	mov    %edx,(%esp)
  801afc:	89 d8                	mov    %ebx,%eax
  801afe:	d3 e0                	shl    %cl,%eax
  801b00:	89 c2                	mov    %eax,%edx
  801b02:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b06:	d3 e0                	shl    %cl,%eax
  801b08:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b0c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b10:	89 f1                	mov    %esi,%ecx
  801b12:	d3 e8                	shr    %cl,%eax
  801b14:	09 d0                	or     %edx,%eax
  801b16:	d3 eb                	shr    %cl,%ebx
  801b18:	89 da                	mov    %ebx,%edx
  801b1a:	f7 f7                	div    %edi
  801b1c:	89 d3                	mov    %edx,%ebx
  801b1e:	f7 24 24             	mull   (%esp)
  801b21:	89 c6                	mov    %eax,%esi
  801b23:	89 d1                	mov    %edx,%ecx
  801b25:	39 d3                	cmp    %edx,%ebx
  801b27:	0f 82 87 00 00 00    	jb     801bb4 <__umoddi3+0x134>
  801b2d:	0f 84 91 00 00 00    	je     801bc4 <__umoddi3+0x144>
  801b33:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b37:	29 f2                	sub    %esi,%edx
  801b39:	19 cb                	sbb    %ecx,%ebx
  801b3b:	89 d8                	mov    %ebx,%eax
  801b3d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b41:	d3 e0                	shl    %cl,%eax
  801b43:	89 e9                	mov    %ebp,%ecx
  801b45:	d3 ea                	shr    %cl,%edx
  801b47:	09 d0                	or     %edx,%eax
  801b49:	89 e9                	mov    %ebp,%ecx
  801b4b:	d3 eb                	shr    %cl,%ebx
  801b4d:	89 da                	mov    %ebx,%edx
  801b4f:	83 c4 1c             	add    $0x1c,%esp
  801b52:	5b                   	pop    %ebx
  801b53:	5e                   	pop    %esi
  801b54:	5f                   	pop    %edi
  801b55:	5d                   	pop    %ebp
  801b56:	c3                   	ret    
  801b57:	90                   	nop
  801b58:	89 fd                	mov    %edi,%ebp
  801b5a:	85 ff                	test   %edi,%edi
  801b5c:	75 0b                	jne    801b69 <__umoddi3+0xe9>
  801b5e:	b8 01 00 00 00       	mov    $0x1,%eax
  801b63:	31 d2                	xor    %edx,%edx
  801b65:	f7 f7                	div    %edi
  801b67:	89 c5                	mov    %eax,%ebp
  801b69:	89 f0                	mov    %esi,%eax
  801b6b:	31 d2                	xor    %edx,%edx
  801b6d:	f7 f5                	div    %ebp
  801b6f:	89 c8                	mov    %ecx,%eax
  801b71:	f7 f5                	div    %ebp
  801b73:	89 d0                	mov    %edx,%eax
  801b75:	e9 44 ff ff ff       	jmp    801abe <__umoddi3+0x3e>
  801b7a:	66 90                	xchg   %ax,%ax
  801b7c:	89 c8                	mov    %ecx,%eax
  801b7e:	89 f2                	mov    %esi,%edx
  801b80:	83 c4 1c             	add    $0x1c,%esp
  801b83:	5b                   	pop    %ebx
  801b84:	5e                   	pop    %esi
  801b85:	5f                   	pop    %edi
  801b86:	5d                   	pop    %ebp
  801b87:	c3                   	ret    
  801b88:	3b 04 24             	cmp    (%esp),%eax
  801b8b:	72 06                	jb     801b93 <__umoddi3+0x113>
  801b8d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b91:	77 0f                	ja     801ba2 <__umoddi3+0x122>
  801b93:	89 f2                	mov    %esi,%edx
  801b95:	29 f9                	sub    %edi,%ecx
  801b97:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b9b:	89 14 24             	mov    %edx,(%esp)
  801b9e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ba2:	8b 44 24 04          	mov    0x4(%esp),%eax
  801ba6:	8b 14 24             	mov    (%esp),%edx
  801ba9:	83 c4 1c             	add    $0x1c,%esp
  801bac:	5b                   	pop    %ebx
  801bad:	5e                   	pop    %esi
  801bae:	5f                   	pop    %edi
  801baf:	5d                   	pop    %ebp
  801bb0:	c3                   	ret    
  801bb1:	8d 76 00             	lea    0x0(%esi),%esi
  801bb4:	2b 04 24             	sub    (%esp),%eax
  801bb7:	19 fa                	sbb    %edi,%edx
  801bb9:	89 d1                	mov    %edx,%ecx
  801bbb:	89 c6                	mov    %eax,%esi
  801bbd:	e9 71 ff ff ff       	jmp    801b33 <__umoddi3+0xb3>
  801bc2:	66 90                	xchg   %ax,%ax
  801bc4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801bc8:	72 ea                	jb     801bb4 <__umoddi3+0x134>
  801bca:	89 d9                	mov    %ebx,%ecx
  801bcc:	e9 62 ff ff ff       	jmp    801b33 <__umoddi3+0xb3>
