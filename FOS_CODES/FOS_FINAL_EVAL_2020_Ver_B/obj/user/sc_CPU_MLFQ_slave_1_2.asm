
obj/user/sc_CPU_MLFQ_slave_1_2:     file format elf32-i386


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
  800031:	e8 3d 00 00 00       	call   800073 <libmain>
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
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D %d\n",4);
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D \n");
	int sum = 0;
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for(int i = 0; i < 5; i++)
  800045:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004c:	eb 09                	jmp    800057 <_main+0x1f>
		sum+=i;
  80004e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800051:	01 45 f4             	add    %eax,-0xc(%ebp)
_main(void)
{
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D %d\n",4);
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D \n");
	int sum = 0;
	for(int i = 0; i < 5; i++)
  800054:	ff 45 f0             	incl   -0x10(%ebp)
  800057:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
  80005b:	7e f1                	jle    80004e <_main+0x16>
		sum+=i;

	//int x = busy_wait(RAND(500000, 1000000));
	int x = busy_wait(100000);
  80005d:	83 ec 0c             	sub    $0xc,%esp
  800060:	68 a0 86 01 00       	push   $0x186a0
  800065:	e8 9a 16 00 00       	call   801704 <busy_wait>
  80006a:	83 c4 10             	add    $0x10,%esp
  80006d:	89 45 ec             	mov    %eax,-0x14(%ebp)

	//env_sleep(10);
}
  800070:	90                   	nop
  800071:	c9                   	leave  
  800072:	c3                   	ret    

00800073 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800073:	55                   	push   %ebp
  800074:	89 e5                	mov    %esp,%ebp
  800076:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800079:	e8 19 10 00 00       	call   801097 <sys_getenvindex>
  80007e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800081:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800084:	89 d0                	mov    %edx,%eax
  800086:	c1 e0 03             	shl    $0x3,%eax
  800089:	01 d0                	add    %edx,%eax
  80008b:	c1 e0 02             	shl    $0x2,%eax
  80008e:	01 d0                	add    %edx,%eax
  800090:	c1 e0 06             	shl    $0x6,%eax
  800093:	29 d0                	sub    %edx,%eax
  800095:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80009c:	01 c8                	add    %ecx,%eax
  80009e:	01 d0                	add    %edx,%eax
  8000a0:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000a5:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000aa:	a1 20 20 80 00       	mov    0x802020,%eax
  8000af:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  8000b5:	84 c0                	test   %al,%al
  8000b7:	74 0f                	je     8000c8 <libmain+0x55>
		binaryname = myEnv->prog_name;
  8000b9:	a1 20 20 80 00       	mov    0x802020,%eax
  8000be:	05 b0 52 00 00       	add    $0x52b0,%eax
  8000c3:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000c8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000cc:	7e 0a                	jle    8000d8 <libmain+0x65>
		binaryname = argv[0];
  8000ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000d1:	8b 00                	mov    (%eax),%eax
  8000d3:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000d8:	83 ec 08             	sub    $0x8,%esp
  8000db:	ff 75 0c             	pushl  0xc(%ebp)
  8000de:	ff 75 08             	pushl  0x8(%ebp)
  8000e1:	e8 52 ff ff ff       	call   800038 <_main>
  8000e6:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000e9:	e8 44 11 00 00       	call   801232 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000ee:	83 ec 0c             	sub    $0xc,%esp
  8000f1:	68 b8 19 80 00       	push   $0x8019b8
  8000f6:	e8 71 01 00 00       	call   80026c <cprintf>
  8000fb:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8000fe:	a1 20 20 80 00       	mov    0x802020,%eax
  800103:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  800109:	a1 20 20 80 00       	mov    0x802020,%eax
  80010e:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  800114:	83 ec 04             	sub    $0x4,%esp
  800117:	52                   	push   %edx
  800118:	50                   	push   %eax
  800119:	68 e0 19 80 00       	push   $0x8019e0
  80011e:	e8 49 01 00 00       	call   80026c <cprintf>
  800123:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800126:	a1 20 20 80 00       	mov    0x802020,%eax
  80012b:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  800131:	a1 20 20 80 00       	mov    0x802020,%eax
  800136:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  80013c:	a1 20 20 80 00       	mov    0x802020,%eax
  800141:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  800147:	51                   	push   %ecx
  800148:	52                   	push   %edx
  800149:	50                   	push   %eax
  80014a:	68 08 1a 80 00       	push   $0x801a08
  80014f:	e8 18 01 00 00       	call   80026c <cprintf>
  800154:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800157:	83 ec 0c             	sub    $0xc,%esp
  80015a:	68 b8 19 80 00       	push   $0x8019b8
  80015f:	e8 08 01 00 00       	call   80026c <cprintf>
  800164:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800167:	e8 e0 10 00 00       	call   80124c <sys_enable_interrupt>

	// exit gracefully
	exit();
  80016c:	e8 19 00 00 00       	call   80018a <exit>
}
  800171:	90                   	nop
  800172:	c9                   	leave  
  800173:	c3                   	ret    

00800174 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800174:	55                   	push   %ebp
  800175:	89 e5                	mov    %esp,%ebp
  800177:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80017a:	83 ec 0c             	sub    $0xc,%esp
  80017d:	6a 00                	push   $0x0
  80017f:	e8 df 0e 00 00       	call   801063 <sys_env_destroy>
  800184:	83 c4 10             	add    $0x10,%esp
}
  800187:	90                   	nop
  800188:	c9                   	leave  
  800189:	c3                   	ret    

0080018a <exit>:

void
exit(void)
{
  80018a:	55                   	push   %ebp
  80018b:	89 e5                	mov    %esp,%ebp
  80018d:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800190:	e8 34 0f 00 00       	call   8010c9 <sys_env_exit>
}
  800195:	90                   	nop
  800196:	c9                   	leave  
  800197:	c3                   	ret    

00800198 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800198:	55                   	push   %ebp
  800199:	89 e5                	mov    %esp,%ebp
  80019b:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80019e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001a1:	8b 00                	mov    (%eax),%eax
  8001a3:	8d 48 01             	lea    0x1(%eax),%ecx
  8001a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001a9:	89 0a                	mov    %ecx,(%edx)
  8001ab:	8b 55 08             	mov    0x8(%ebp),%edx
  8001ae:	88 d1                	mov    %dl,%cl
  8001b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001b3:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ba:	8b 00                	mov    (%eax),%eax
  8001bc:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001c1:	75 2c                	jne    8001ef <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001c3:	a0 24 20 80 00       	mov    0x802024,%al
  8001c8:	0f b6 c0             	movzbl %al,%eax
  8001cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001ce:	8b 12                	mov    (%edx),%edx
  8001d0:	89 d1                	mov    %edx,%ecx
  8001d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001d5:	83 c2 08             	add    $0x8,%edx
  8001d8:	83 ec 04             	sub    $0x4,%esp
  8001db:	50                   	push   %eax
  8001dc:	51                   	push   %ecx
  8001dd:	52                   	push   %edx
  8001de:	e8 3e 0e 00 00       	call   801021 <sys_cputs>
  8001e3:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001e9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f2:	8b 40 04             	mov    0x4(%eax),%eax
  8001f5:	8d 50 01             	lea    0x1(%eax),%edx
  8001f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001fb:	89 50 04             	mov    %edx,0x4(%eax)
}
  8001fe:	90                   	nop
  8001ff:	c9                   	leave  
  800200:	c3                   	ret    

00800201 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800201:	55                   	push   %ebp
  800202:	89 e5                	mov    %esp,%ebp
  800204:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80020a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800211:	00 00 00 
	b.cnt = 0;
  800214:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80021b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80021e:	ff 75 0c             	pushl  0xc(%ebp)
  800221:	ff 75 08             	pushl  0x8(%ebp)
  800224:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80022a:	50                   	push   %eax
  80022b:	68 98 01 80 00       	push   $0x800198
  800230:	e8 11 02 00 00       	call   800446 <vprintfmt>
  800235:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800238:	a0 24 20 80 00       	mov    0x802024,%al
  80023d:	0f b6 c0             	movzbl %al,%eax
  800240:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800246:	83 ec 04             	sub    $0x4,%esp
  800249:	50                   	push   %eax
  80024a:	52                   	push   %edx
  80024b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800251:	83 c0 08             	add    $0x8,%eax
  800254:	50                   	push   %eax
  800255:	e8 c7 0d 00 00       	call   801021 <sys_cputs>
  80025a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80025d:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  800264:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80026a:	c9                   	leave  
  80026b:	c3                   	ret    

0080026c <cprintf>:

int cprintf(const char *fmt, ...) {
  80026c:	55                   	push   %ebp
  80026d:	89 e5                	mov    %esp,%ebp
  80026f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800272:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  800279:	8d 45 0c             	lea    0xc(%ebp),%eax
  80027c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80027f:	8b 45 08             	mov    0x8(%ebp),%eax
  800282:	83 ec 08             	sub    $0x8,%esp
  800285:	ff 75 f4             	pushl  -0xc(%ebp)
  800288:	50                   	push   %eax
  800289:	e8 73 ff ff ff       	call   800201 <vcprintf>
  80028e:	83 c4 10             	add    $0x10,%esp
  800291:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800294:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800297:	c9                   	leave  
  800298:	c3                   	ret    

00800299 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800299:	55                   	push   %ebp
  80029a:	89 e5                	mov    %esp,%ebp
  80029c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80029f:	e8 8e 0f 00 00       	call   801232 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002a4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ad:	83 ec 08             	sub    $0x8,%esp
  8002b0:	ff 75 f4             	pushl  -0xc(%ebp)
  8002b3:	50                   	push   %eax
  8002b4:	e8 48 ff ff ff       	call   800201 <vcprintf>
  8002b9:	83 c4 10             	add    $0x10,%esp
  8002bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002bf:	e8 88 0f 00 00       	call   80124c <sys_enable_interrupt>
	return cnt;
  8002c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002c7:	c9                   	leave  
  8002c8:	c3                   	ret    

008002c9 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002c9:	55                   	push   %ebp
  8002ca:	89 e5                	mov    %esp,%ebp
  8002cc:	53                   	push   %ebx
  8002cd:	83 ec 14             	sub    $0x14,%esp
  8002d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8002d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8002d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002dc:	8b 45 18             	mov    0x18(%ebp),%eax
  8002df:	ba 00 00 00 00       	mov    $0x0,%edx
  8002e4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002e7:	77 55                	ja     80033e <printnum+0x75>
  8002e9:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002ec:	72 05                	jb     8002f3 <printnum+0x2a>
  8002ee:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002f1:	77 4b                	ja     80033e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8002f3:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8002f6:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8002f9:	8b 45 18             	mov    0x18(%ebp),%eax
  8002fc:	ba 00 00 00 00       	mov    $0x0,%edx
  800301:	52                   	push   %edx
  800302:	50                   	push   %eax
  800303:	ff 75 f4             	pushl  -0xc(%ebp)
  800306:	ff 75 f0             	pushl  -0x10(%ebp)
  800309:	e8 16 14 00 00       	call   801724 <__udivdi3>
  80030e:	83 c4 10             	add    $0x10,%esp
  800311:	83 ec 04             	sub    $0x4,%esp
  800314:	ff 75 20             	pushl  0x20(%ebp)
  800317:	53                   	push   %ebx
  800318:	ff 75 18             	pushl  0x18(%ebp)
  80031b:	52                   	push   %edx
  80031c:	50                   	push   %eax
  80031d:	ff 75 0c             	pushl  0xc(%ebp)
  800320:	ff 75 08             	pushl  0x8(%ebp)
  800323:	e8 a1 ff ff ff       	call   8002c9 <printnum>
  800328:	83 c4 20             	add    $0x20,%esp
  80032b:	eb 1a                	jmp    800347 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80032d:	83 ec 08             	sub    $0x8,%esp
  800330:	ff 75 0c             	pushl  0xc(%ebp)
  800333:	ff 75 20             	pushl  0x20(%ebp)
  800336:	8b 45 08             	mov    0x8(%ebp),%eax
  800339:	ff d0                	call   *%eax
  80033b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80033e:	ff 4d 1c             	decl   0x1c(%ebp)
  800341:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800345:	7f e6                	jg     80032d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800347:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80034a:	bb 00 00 00 00       	mov    $0x0,%ebx
  80034f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800352:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800355:	53                   	push   %ebx
  800356:	51                   	push   %ecx
  800357:	52                   	push   %edx
  800358:	50                   	push   %eax
  800359:	e8 d6 14 00 00       	call   801834 <__umoddi3>
  80035e:	83 c4 10             	add    $0x10,%esp
  800361:	05 74 1c 80 00       	add    $0x801c74,%eax
  800366:	8a 00                	mov    (%eax),%al
  800368:	0f be c0             	movsbl %al,%eax
  80036b:	83 ec 08             	sub    $0x8,%esp
  80036e:	ff 75 0c             	pushl  0xc(%ebp)
  800371:	50                   	push   %eax
  800372:	8b 45 08             	mov    0x8(%ebp),%eax
  800375:	ff d0                	call   *%eax
  800377:	83 c4 10             	add    $0x10,%esp
}
  80037a:	90                   	nop
  80037b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80037e:	c9                   	leave  
  80037f:	c3                   	ret    

00800380 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800380:	55                   	push   %ebp
  800381:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800383:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800387:	7e 1c                	jle    8003a5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800389:	8b 45 08             	mov    0x8(%ebp),%eax
  80038c:	8b 00                	mov    (%eax),%eax
  80038e:	8d 50 08             	lea    0x8(%eax),%edx
  800391:	8b 45 08             	mov    0x8(%ebp),%eax
  800394:	89 10                	mov    %edx,(%eax)
  800396:	8b 45 08             	mov    0x8(%ebp),%eax
  800399:	8b 00                	mov    (%eax),%eax
  80039b:	83 e8 08             	sub    $0x8,%eax
  80039e:	8b 50 04             	mov    0x4(%eax),%edx
  8003a1:	8b 00                	mov    (%eax),%eax
  8003a3:	eb 40                	jmp    8003e5 <getuint+0x65>
	else if (lflag)
  8003a5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003a9:	74 1e                	je     8003c9 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ae:	8b 00                	mov    (%eax),%eax
  8003b0:	8d 50 04             	lea    0x4(%eax),%edx
  8003b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b6:	89 10                	mov    %edx,(%eax)
  8003b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bb:	8b 00                	mov    (%eax),%eax
  8003bd:	83 e8 04             	sub    $0x4,%eax
  8003c0:	8b 00                	mov    (%eax),%eax
  8003c2:	ba 00 00 00 00       	mov    $0x0,%edx
  8003c7:	eb 1c                	jmp    8003e5 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cc:	8b 00                	mov    (%eax),%eax
  8003ce:	8d 50 04             	lea    0x4(%eax),%edx
  8003d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d4:	89 10                	mov    %edx,(%eax)
  8003d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d9:	8b 00                	mov    (%eax),%eax
  8003db:	83 e8 04             	sub    $0x4,%eax
  8003de:	8b 00                	mov    (%eax),%eax
  8003e0:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003e5:	5d                   	pop    %ebp
  8003e6:	c3                   	ret    

008003e7 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003e7:	55                   	push   %ebp
  8003e8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003ea:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003ee:	7e 1c                	jle    80040c <getint+0x25>
		return va_arg(*ap, long long);
  8003f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f3:	8b 00                	mov    (%eax),%eax
  8003f5:	8d 50 08             	lea    0x8(%eax),%edx
  8003f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fb:	89 10                	mov    %edx,(%eax)
  8003fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800400:	8b 00                	mov    (%eax),%eax
  800402:	83 e8 08             	sub    $0x8,%eax
  800405:	8b 50 04             	mov    0x4(%eax),%edx
  800408:	8b 00                	mov    (%eax),%eax
  80040a:	eb 38                	jmp    800444 <getint+0x5d>
	else if (lflag)
  80040c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800410:	74 1a                	je     80042c <getint+0x45>
		return va_arg(*ap, long);
  800412:	8b 45 08             	mov    0x8(%ebp),%eax
  800415:	8b 00                	mov    (%eax),%eax
  800417:	8d 50 04             	lea    0x4(%eax),%edx
  80041a:	8b 45 08             	mov    0x8(%ebp),%eax
  80041d:	89 10                	mov    %edx,(%eax)
  80041f:	8b 45 08             	mov    0x8(%ebp),%eax
  800422:	8b 00                	mov    (%eax),%eax
  800424:	83 e8 04             	sub    $0x4,%eax
  800427:	8b 00                	mov    (%eax),%eax
  800429:	99                   	cltd   
  80042a:	eb 18                	jmp    800444 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80042c:	8b 45 08             	mov    0x8(%ebp),%eax
  80042f:	8b 00                	mov    (%eax),%eax
  800431:	8d 50 04             	lea    0x4(%eax),%edx
  800434:	8b 45 08             	mov    0x8(%ebp),%eax
  800437:	89 10                	mov    %edx,(%eax)
  800439:	8b 45 08             	mov    0x8(%ebp),%eax
  80043c:	8b 00                	mov    (%eax),%eax
  80043e:	83 e8 04             	sub    $0x4,%eax
  800441:	8b 00                	mov    (%eax),%eax
  800443:	99                   	cltd   
}
  800444:	5d                   	pop    %ebp
  800445:	c3                   	ret    

00800446 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800446:	55                   	push   %ebp
  800447:	89 e5                	mov    %esp,%ebp
  800449:	56                   	push   %esi
  80044a:	53                   	push   %ebx
  80044b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80044e:	eb 17                	jmp    800467 <vprintfmt+0x21>
			if (ch == '\0')
  800450:	85 db                	test   %ebx,%ebx
  800452:	0f 84 af 03 00 00    	je     800807 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800458:	83 ec 08             	sub    $0x8,%esp
  80045b:	ff 75 0c             	pushl  0xc(%ebp)
  80045e:	53                   	push   %ebx
  80045f:	8b 45 08             	mov    0x8(%ebp),%eax
  800462:	ff d0                	call   *%eax
  800464:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800467:	8b 45 10             	mov    0x10(%ebp),%eax
  80046a:	8d 50 01             	lea    0x1(%eax),%edx
  80046d:	89 55 10             	mov    %edx,0x10(%ebp)
  800470:	8a 00                	mov    (%eax),%al
  800472:	0f b6 d8             	movzbl %al,%ebx
  800475:	83 fb 25             	cmp    $0x25,%ebx
  800478:	75 d6                	jne    800450 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80047a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80047e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800485:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80048c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800493:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80049a:	8b 45 10             	mov    0x10(%ebp),%eax
  80049d:	8d 50 01             	lea    0x1(%eax),%edx
  8004a0:	89 55 10             	mov    %edx,0x10(%ebp)
  8004a3:	8a 00                	mov    (%eax),%al
  8004a5:	0f b6 d8             	movzbl %al,%ebx
  8004a8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004ab:	83 f8 55             	cmp    $0x55,%eax
  8004ae:	0f 87 2b 03 00 00    	ja     8007df <vprintfmt+0x399>
  8004b4:	8b 04 85 98 1c 80 00 	mov    0x801c98(,%eax,4),%eax
  8004bb:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004bd:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004c1:	eb d7                	jmp    80049a <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004c3:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004c7:	eb d1                	jmp    80049a <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004c9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004d0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004d3:	89 d0                	mov    %edx,%eax
  8004d5:	c1 e0 02             	shl    $0x2,%eax
  8004d8:	01 d0                	add    %edx,%eax
  8004da:	01 c0                	add    %eax,%eax
  8004dc:	01 d8                	add    %ebx,%eax
  8004de:	83 e8 30             	sub    $0x30,%eax
  8004e1:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8004e7:	8a 00                	mov    (%eax),%al
  8004e9:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004ec:	83 fb 2f             	cmp    $0x2f,%ebx
  8004ef:	7e 3e                	jle    80052f <vprintfmt+0xe9>
  8004f1:	83 fb 39             	cmp    $0x39,%ebx
  8004f4:	7f 39                	jg     80052f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004f6:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8004f9:	eb d5                	jmp    8004d0 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8004fb:	8b 45 14             	mov    0x14(%ebp),%eax
  8004fe:	83 c0 04             	add    $0x4,%eax
  800501:	89 45 14             	mov    %eax,0x14(%ebp)
  800504:	8b 45 14             	mov    0x14(%ebp),%eax
  800507:	83 e8 04             	sub    $0x4,%eax
  80050a:	8b 00                	mov    (%eax),%eax
  80050c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80050f:	eb 1f                	jmp    800530 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800511:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800515:	79 83                	jns    80049a <vprintfmt+0x54>
				width = 0;
  800517:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80051e:	e9 77 ff ff ff       	jmp    80049a <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800523:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80052a:	e9 6b ff ff ff       	jmp    80049a <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80052f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800530:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800534:	0f 89 60 ff ff ff    	jns    80049a <vprintfmt+0x54>
				width = precision, precision = -1;
  80053a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80053d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800540:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800547:	e9 4e ff ff ff       	jmp    80049a <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80054c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80054f:	e9 46 ff ff ff       	jmp    80049a <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800554:	8b 45 14             	mov    0x14(%ebp),%eax
  800557:	83 c0 04             	add    $0x4,%eax
  80055a:	89 45 14             	mov    %eax,0x14(%ebp)
  80055d:	8b 45 14             	mov    0x14(%ebp),%eax
  800560:	83 e8 04             	sub    $0x4,%eax
  800563:	8b 00                	mov    (%eax),%eax
  800565:	83 ec 08             	sub    $0x8,%esp
  800568:	ff 75 0c             	pushl  0xc(%ebp)
  80056b:	50                   	push   %eax
  80056c:	8b 45 08             	mov    0x8(%ebp),%eax
  80056f:	ff d0                	call   *%eax
  800571:	83 c4 10             	add    $0x10,%esp
			break;
  800574:	e9 89 02 00 00       	jmp    800802 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800579:	8b 45 14             	mov    0x14(%ebp),%eax
  80057c:	83 c0 04             	add    $0x4,%eax
  80057f:	89 45 14             	mov    %eax,0x14(%ebp)
  800582:	8b 45 14             	mov    0x14(%ebp),%eax
  800585:	83 e8 04             	sub    $0x4,%eax
  800588:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80058a:	85 db                	test   %ebx,%ebx
  80058c:	79 02                	jns    800590 <vprintfmt+0x14a>
				err = -err;
  80058e:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800590:	83 fb 64             	cmp    $0x64,%ebx
  800593:	7f 0b                	jg     8005a0 <vprintfmt+0x15a>
  800595:	8b 34 9d e0 1a 80 00 	mov    0x801ae0(,%ebx,4),%esi
  80059c:	85 f6                	test   %esi,%esi
  80059e:	75 19                	jne    8005b9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005a0:	53                   	push   %ebx
  8005a1:	68 85 1c 80 00       	push   $0x801c85
  8005a6:	ff 75 0c             	pushl  0xc(%ebp)
  8005a9:	ff 75 08             	pushl  0x8(%ebp)
  8005ac:	e8 5e 02 00 00       	call   80080f <printfmt>
  8005b1:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005b4:	e9 49 02 00 00       	jmp    800802 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005b9:	56                   	push   %esi
  8005ba:	68 8e 1c 80 00       	push   $0x801c8e
  8005bf:	ff 75 0c             	pushl  0xc(%ebp)
  8005c2:	ff 75 08             	pushl  0x8(%ebp)
  8005c5:	e8 45 02 00 00       	call   80080f <printfmt>
  8005ca:	83 c4 10             	add    $0x10,%esp
			break;
  8005cd:	e9 30 02 00 00       	jmp    800802 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d5:	83 c0 04             	add    $0x4,%eax
  8005d8:	89 45 14             	mov    %eax,0x14(%ebp)
  8005db:	8b 45 14             	mov    0x14(%ebp),%eax
  8005de:	83 e8 04             	sub    $0x4,%eax
  8005e1:	8b 30                	mov    (%eax),%esi
  8005e3:	85 f6                	test   %esi,%esi
  8005e5:	75 05                	jne    8005ec <vprintfmt+0x1a6>
				p = "(null)";
  8005e7:	be 91 1c 80 00       	mov    $0x801c91,%esi
			if (width > 0 && padc != '-')
  8005ec:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005f0:	7e 6d                	jle    80065f <vprintfmt+0x219>
  8005f2:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8005f6:	74 67                	je     80065f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8005f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005fb:	83 ec 08             	sub    $0x8,%esp
  8005fe:	50                   	push   %eax
  8005ff:	56                   	push   %esi
  800600:	e8 0c 03 00 00       	call   800911 <strnlen>
  800605:	83 c4 10             	add    $0x10,%esp
  800608:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80060b:	eb 16                	jmp    800623 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80060d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800611:	83 ec 08             	sub    $0x8,%esp
  800614:	ff 75 0c             	pushl  0xc(%ebp)
  800617:	50                   	push   %eax
  800618:	8b 45 08             	mov    0x8(%ebp),%eax
  80061b:	ff d0                	call   *%eax
  80061d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800620:	ff 4d e4             	decl   -0x1c(%ebp)
  800623:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800627:	7f e4                	jg     80060d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800629:	eb 34                	jmp    80065f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80062b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80062f:	74 1c                	je     80064d <vprintfmt+0x207>
  800631:	83 fb 1f             	cmp    $0x1f,%ebx
  800634:	7e 05                	jle    80063b <vprintfmt+0x1f5>
  800636:	83 fb 7e             	cmp    $0x7e,%ebx
  800639:	7e 12                	jle    80064d <vprintfmt+0x207>
					putch('?', putdat);
  80063b:	83 ec 08             	sub    $0x8,%esp
  80063e:	ff 75 0c             	pushl  0xc(%ebp)
  800641:	6a 3f                	push   $0x3f
  800643:	8b 45 08             	mov    0x8(%ebp),%eax
  800646:	ff d0                	call   *%eax
  800648:	83 c4 10             	add    $0x10,%esp
  80064b:	eb 0f                	jmp    80065c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80064d:	83 ec 08             	sub    $0x8,%esp
  800650:	ff 75 0c             	pushl  0xc(%ebp)
  800653:	53                   	push   %ebx
  800654:	8b 45 08             	mov    0x8(%ebp),%eax
  800657:	ff d0                	call   *%eax
  800659:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80065c:	ff 4d e4             	decl   -0x1c(%ebp)
  80065f:	89 f0                	mov    %esi,%eax
  800661:	8d 70 01             	lea    0x1(%eax),%esi
  800664:	8a 00                	mov    (%eax),%al
  800666:	0f be d8             	movsbl %al,%ebx
  800669:	85 db                	test   %ebx,%ebx
  80066b:	74 24                	je     800691 <vprintfmt+0x24b>
  80066d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800671:	78 b8                	js     80062b <vprintfmt+0x1e5>
  800673:	ff 4d e0             	decl   -0x20(%ebp)
  800676:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80067a:	79 af                	jns    80062b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80067c:	eb 13                	jmp    800691 <vprintfmt+0x24b>
				putch(' ', putdat);
  80067e:	83 ec 08             	sub    $0x8,%esp
  800681:	ff 75 0c             	pushl  0xc(%ebp)
  800684:	6a 20                	push   $0x20
  800686:	8b 45 08             	mov    0x8(%ebp),%eax
  800689:	ff d0                	call   *%eax
  80068b:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80068e:	ff 4d e4             	decl   -0x1c(%ebp)
  800691:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800695:	7f e7                	jg     80067e <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800697:	e9 66 01 00 00       	jmp    800802 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80069c:	83 ec 08             	sub    $0x8,%esp
  80069f:	ff 75 e8             	pushl  -0x18(%ebp)
  8006a2:	8d 45 14             	lea    0x14(%ebp),%eax
  8006a5:	50                   	push   %eax
  8006a6:	e8 3c fd ff ff       	call   8003e7 <getint>
  8006ab:	83 c4 10             	add    $0x10,%esp
  8006ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006b1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006ba:	85 d2                	test   %edx,%edx
  8006bc:	79 23                	jns    8006e1 <vprintfmt+0x29b>
				putch('-', putdat);
  8006be:	83 ec 08             	sub    $0x8,%esp
  8006c1:	ff 75 0c             	pushl  0xc(%ebp)
  8006c4:	6a 2d                	push   $0x2d
  8006c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c9:	ff d0                	call   *%eax
  8006cb:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006d4:	f7 d8                	neg    %eax
  8006d6:	83 d2 00             	adc    $0x0,%edx
  8006d9:	f7 da                	neg    %edx
  8006db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006de:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006e1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006e8:	e9 bc 00 00 00       	jmp    8007a9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006ed:	83 ec 08             	sub    $0x8,%esp
  8006f0:	ff 75 e8             	pushl  -0x18(%ebp)
  8006f3:	8d 45 14             	lea    0x14(%ebp),%eax
  8006f6:	50                   	push   %eax
  8006f7:	e8 84 fc ff ff       	call   800380 <getuint>
  8006fc:	83 c4 10             	add    $0x10,%esp
  8006ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800702:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800705:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80070c:	e9 98 00 00 00       	jmp    8007a9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800711:	83 ec 08             	sub    $0x8,%esp
  800714:	ff 75 0c             	pushl  0xc(%ebp)
  800717:	6a 58                	push   $0x58
  800719:	8b 45 08             	mov    0x8(%ebp),%eax
  80071c:	ff d0                	call   *%eax
  80071e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800721:	83 ec 08             	sub    $0x8,%esp
  800724:	ff 75 0c             	pushl  0xc(%ebp)
  800727:	6a 58                	push   $0x58
  800729:	8b 45 08             	mov    0x8(%ebp),%eax
  80072c:	ff d0                	call   *%eax
  80072e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800731:	83 ec 08             	sub    $0x8,%esp
  800734:	ff 75 0c             	pushl  0xc(%ebp)
  800737:	6a 58                	push   $0x58
  800739:	8b 45 08             	mov    0x8(%ebp),%eax
  80073c:	ff d0                	call   *%eax
  80073e:	83 c4 10             	add    $0x10,%esp
			break;
  800741:	e9 bc 00 00 00       	jmp    800802 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800746:	83 ec 08             	sub    $0x8,%esp
  800749:	ff 75 0c             	pushl  0xc(%ebp)
  80074c:	6a 30                	push   $0x30
  80074e:	8b 45 08             	mov    0x8(%ebp),%eax
  800751:	ff d0                	call   *%eax
  800753:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800756:	83 ec 08             	sub    $0x8,%esp
  800759:	ff 75 0c             	pushl  0xc(%ebp)
  80075c:	6a 78                	push   $0x78
  80075e:	8b 45 08             	mov    0x8(%ebp),%eax
  800761:	ff d0                	call   *%eax
  800763:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800766:	8b 45 14             	mov    0x14(%ebp),%eax
  800769:	83 c0 04             	add    $0x4,%eax
  80076c:	89 45 14             	mov    %eax,0x14(%ebp)
  80076f:	8b 45 14             	mov    0x14(%ebp),%eax
  800772:	83 e8 04             	sub    $0x4,%eax
  800775:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800777:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80077a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800781:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800788:	eb 1f                	jmp    8007a9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80078a:	83 ec 08             	sub    $0x8,%esp
  80078d:	ff 75 e8             	pushl  -0x18(%ebp)
  800790:	8d 45 14             	lea    0x14(%ebp),%eax
  800793:	50                   	push   %eax
  800794:	e8 e7 fb ff ff       	call   800380 <getuint>
  800799:	83 c4 10             	add    $0x10,%esp
  80079c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80079f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007a2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007a9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007b0:	83 ec 04             	sub    $0x4,%esp
  8007b3:	52                   	push   %edx
  8007b4:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007b7:	50                   	push   %eax
  8007b8:	ff 75 f4             	pushl  -0xc(%ebp)
  8007bb:	ff 75 f0             	pushl  -0x10(%ebp)
  8007be:	ff 75 0c             	pushl  0xc(%ebp)
  8007c1:	ff 75 08             	pushl  0x8(%ebp)
  8007c4:	e8 00 fb ff ff       	call   8002c9 <printnum>
  8007c9:	83 c4 20             	add    $0x20,%esp
			break;
  8007cc:	eb 34                	jmp    800802 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007ce:	83 ec 08             	sub    $0x8,%esp
  8007d1:	ff 75 0c             	pushl  0xc(%ebp)
  8007d4:	53                   	push   %ebx
  8007d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d8:	ff d0                	call   *%eax
  8007da:	83 c4 10             	add    $0x10,%esp
			break;
  8007dd:	eb 23                	jmp    800802 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007df:	83 ec 08             	sub    $0x8,%esp
  8007e2:	ff 75 0c             	pushl  0xc(%ebp)
  8007e5:	6a 25                	push   $0x25
  8007e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ea:	ff d0                	call   *%eax
  8007ec:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007ef:	ff 4d 10             	decl   0x10(%ebp)
  8007f2:	eb 03                	jmp    8007f7 <vprintfmt+0x3b1>
  8007f4:	ff 4d 10             	decl   0x10(%ebp)
  8007f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8007fa:	48                   	dec    %eax
  8007fb:	8a 00                	mov    (%eax),%al
  8007fd:	3c 25                	cmp    $0x25,%al
  8007ff:	75 f3                	jne    8007f4 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800801:	90                   	nop
		}
	}
  800802:	e9 47 fc ff ff       	jmp    80044e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800807:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800808:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80080b:	5b                   	pop    %ebx
  80080c:	5e                   	pop    %esi
  80080d:	5d                   	pop    %ebp
  80080e:	c3                   	ret    

0080080f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80080f:	55                   	push   %ebp
  800810:	89 e5                	mov    %esp,%ebp
  800812:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800815:	8d 45 10             	lea    0x10(%ebp),%eax
  800818:	83 c0 04             	add    $0x4,%eax
  80081b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80081e:	8b 45 10             	mov    0x10(%ebp),%eax
  800821:	ff 75 f4             	pushl  -0xc(%ebp)
  800824:	50                   	push   %eax
  800825:	ff 75 0c             	pushl  0xc(%ebp)
  800828:	ff 75 08             	pushl  0x8(%ebp)
  80082b:	e8 16 fc ff ff       	call   800446 <vprintfmt>
  800830:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800833:	90                   	nop
  800834:	c9                   	leave  
  800835:	c3                   	ret    

00800836 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800836:	55                   	push   %ebp
  800837:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800839:	8b 45 0c             	mov    0xc(%ebp),%eax
  80083c:	8b 40 08             	mov    0x8(%eax),%eax
  80083f:	8d 50 01             	lea    0x1(%eax),%edx
  800842:	8b 45 0c             	mov    0xc(%ebp),%eax
  800845:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800848:	8b 45 0c             	mov    0xc(%ebp),%eax
  80084b:	8b 10                	mov    (%eax),%edx
  80084d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800850:	8b 40 04             	mov    0x4(%eax),%eax
  800853:	39 c2                	cmp    %eax,%edx
  800855:	73 12                	jae    800869 <sprintputch+0x33>
		*b->buf++ = ch;
  800857:	8b 45 0c             	mov    0xc(%ebp),%eax
  80085a:	8b 00                	mov    (%eax),%eax
  80085c:	8d 48 01             	lea    0x1(%eax),%ecx
  80085f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800862:	89 0a                	mov    %ecx,(%edx)
  800864:	8b 55 08             	mov    0x8(%ebp),%edx
  800867:	88 10                	mov    %dl,(%eax)
}
  800869:	90                   	nop
  80086a:	5d                   	pop    %ebp
  80086b:	c3                   	ret    

0080086c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80086c:	55                   	push   %ebp
  80086d:	89 e5                	mov    %esp,%ebp
  80086f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800872:	8b 45 08             	mov    0x8(%ebp),%eax
  800875:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800878:	8b 45 0c             	mov    0xc(%ebp),%eax
  80087b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80087e:	8b 45 08             	mov    0x8(%ebp),%eax
  800881:	01 d0                	add    %edx,%eax
  800883:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800886:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80088d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800891:	74 06                	je     800899 <vsnprintf+0x2d>
  800893:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800897:	7f 07                	jg     8008a0 <vsnprintf+0x34>
		return -E_INVAL;
  800899:	b8 03 00 00 00       	mov    $0x3,%eax
  80089e:	eb 20                	jmp    8008c0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008a0:	ff 75 14             	pushl  0x14(%ebp)
  8008a3:	ff 75 10             	pushl  0x10(%ebp)
  8008a6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008a9:	50                   	push   %eax
  8008aa:	68 36 08 80 00       	push   $0x800836
  8008af:	e8 92 fb ff ff       	call   800446 <vprintfmt>
  8008b4:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008ba:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008c0:	c9                   	leave  
  8008c1:	c3                   	ret    

008008c2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008c2:	55                   	push   %ebp
  8008c3:	89 e5                	mov    %esp,%ebp
  8008c5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008c8:	8d 45 10             	lea    0x10(%ebp),%eax
  8008cb:	83 c0 04             	add    $0x4,%eax
  8008ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8008d4:	ff 75 f4             	pushl  -0xc(%ebp)
  8008d7:	50                   	push   %eax
  8008d8:	ff 75 0c             	pushl  0xc(%ebp)
  8008db:	ff 75 08             	pushl  0x8(%ebp)
  8008de:	e8 89 ff ff ff       	call   80086c <vsnprintf>
  8008e3:	83 c4 10             	add    $0x10,%esp
  8008e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008ec:	c9                   	leave  
  8008ed:	c3                   	ret    

008008ee <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008ee:	55                   	push   %ebp
  8008ef:	89 e5                	mov    %esp,%ebp
  8008f1:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8008f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008fb:	eb 06                	jmp    800903 <strlen+0x15>
		n++;
  8008fd:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800900:	ff 45 08             	incl   0x8(%ebp)
  800903:	8b 45 08             	mov    0x8(%ebp),%eax
  800906:	8a 00                	mov    (%eax),%al
  800908:	84 c0                	test   %al,%al
  80090a:	75 f1                	jne    8008fd <strlen+0xf>
		n++;
	return n;
  80090c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80090f:	c9                   	leave  
  800910:	c3                   	ret    

00800911 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800911:	55                   	push   %ebp
  800912:	89 e5                	mov    %esp,%ebp
  800914:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800917:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80091e:	eb 09                	jmp    800929 <strnlen+0x18>
		n++;
  800920:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800923:	ff 45 08             	incl   0x8(%ebp)
  800926:	ff 4d 0c             	decl   0xc(%ebp)
  800929:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80092d:	74 09                	je     800938 <strnlen+0x27>
  80092f:	8b 45 08             	mov    0x8(%ebp),%eax
  800932:	8a 00                	mov    (%eax),%al
  800934:	84 c0                	test   %al,%al
  800936:	75 e8                	jne    800920 <strnlen+0xf>
		n++;
	return n;
  800938:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80093b:	c9                   	leave  
  80093c:	c3                   	ret    

0080093d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80093d:	55                   	push   %ebp
  80093e:	89 e5                	mov    %esp,%ebp
  800940:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800943:	8b 45 08             	mov    0x8(%ebp),%eax
  800946:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800949:	90                   	nop
  80094a:	8b 45 08             	mov    0x8(%ebp),%eax
  80094d:	8d 50 01             	lea    0x1(%eax),%edx
  800950:	89 55 08             	mov    %edx,0x8(%ebp)
  800953:	8b 55 0c             	mov    0xc(%ebp),%edx
  800956:	8d 4a 01             	lea    0x1(%edx),%ecx
  800959:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80095c:	8a 12                	mov    (%edx),%dl
  80095e:	88 10                	mov    %dl,(%eax)
  800960:	8a 00                	mov    (%eax),%al
  800962:	84 c0                	test   %al,%al
  800964:	75 e4                	jne    80094a <strcpy+0xd>
		/* do nothing */;
	return ret;
  800966:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800969:	c9                   	leave  
  80096a:	c3                   	ret    

0080096b <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80096b:	55                   	push   %ebp
  80096c:	89 e5                	mov    %esp,%ebp
  80096e:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800971:	8b 45 08             	mov    0x8(%ebp),%eax
  800974:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800977:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80097e:	eb 1f                	jmp    80099f <strncpy+0x34>
		*dst++ = *src;
  800980:	8b 45 08             	mov    0x8(%ebp),%eax
  800983:	8d 50 01             	lea    0x1(%eax),%edx
  800986:	89 55 08             	mov    %edx,0x8(%ebp)
  800989:	8b 55 0c             	mov    0xc(%ebp),%edx
  80098c:	8a 12                	mov    (%edx),%dl
  80098e:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800990:	8b 45 0c             	mov    0xc(%ebp),%eax
  800993:	8a 00                	mov    (%eax),%al
  800995:	84 c0                	test   %al,%al
  800997:	74 03                	je     80099c <strncpy+0x31>
			src++;
  800999:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80099c:	ff 45 fc             	incl   -0x4(%ebp)
  80099f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009a2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009a5:	72 d9                	jb     800980 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009aa:	c9                   	leave  
  8009ab:	c3                   	ret    

008009ac <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009ac:	55                   	push   %ebp
  8009ad:	89 e5                	mov    %esp,%ebp
  8009af:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009b8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009bc:	74 30                	je     8009ee <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009be:	eb 16                	jmp    8009d6 <strlcpy+0x2a>
			*dst++ = *src++;
  8009c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c3:	8d 50 01             	lea    0x1(%eax),%edx
  8009c6:	89 55 08             	mov    %edx,0x8(%ebp)
  8009c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009cc:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009cf:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009d2:	8a 12                	mov    (%edx),%dl
  8009d4:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009d6:	ff 4d 10             	decl   0x10(%ebp)
  8009d9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009dd:	74 09                	je     8009e8 <strlcpy+0x3c>
  8009df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e2:	8a 00                	mov    (%eax),%al
  8009e4:	84 c0                	test   %al,%al
  8009e6:	75 d8                	jne    8009c0 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009eb:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009ee:	8b 55 08             	mov    0x8(%ebp),%edx
  8009f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009f4:	29 c2                	sub    %eax,%edx
  8009f6:	89 d0                	mov    %edx,%eax
}
  8009f8:	c9                   	leave  
  8009f9:	c3                   	ret    

008009fa <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8009fa:	55                   	push   %ebp
  8009fb:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8009fd:	eb 06                	jmp    800a05 <strcmp+0xb>
		p++, q++;
  8009ff:	ff 45 08             	incl   0x8(%ebp)
  800a02:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a05:	8b 45 08             	mov    0x8(%ebp),%eax
  800a08:	8a 00                	mov    (%eax),%al
  800a0a:	84 c0                	test   %al,%al
  800a0c:	74 0e                	je     800a1c <strcmp+0x22>
  800a0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a11:	8a 10                	mov    (%eax),%dl
  800a13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a16:	8a 00                	mov    (%eax),%al
  800a18:	38 c2                	cmp    %al,%dl
  800a1a:	74 e3                	je     8009ff <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1f:	8a 00                	mov    (%eax),%al
  800a21:	0f b6 d0             	movzbl %al,%edx
  800a24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a27:	8a 00                	mov    (%eax),%al
  800a29:	0f b6 c0             	movzbl %al,%eax
  800a2c:	29 c2                	sub    %eax,%edx
  800a2e:	89 d0                	mov    %edx,%eax
}
  800a30:	5d                   	pop    %ebp
  800a31:	c3                   	ret    

00800a32 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a32:	55                   	push   %ebp
  800a33:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a35:	eb 09                	jmp    800a40 <strncmp+0xe>
		n--, p++, q++;
  800a37:	ff 4d 10             	decl   0x10(%ebp)
  800a3a:	ff 45 08             	incl   0x8(%ebp)
  800a3d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a40:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a44:	74 17                	je     800a5d <strncmp+0x2b>
  800a46:	8b 45 08             	mov    0x8(%ebp),%eax
  800a49:	8a 00                	mov    (%eax),%al
  800a4b:	84 c0                	test   %al,%al
  800a4d:	74 0e                	je     800a5d <strncmp+0x2b>
  800a4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a52:	8a 10                	mov    (%eax),%dl
  800a54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a57:	8a 00                	mov    (%eax),%al
  800a59:	38 c2                	cmp    %al,%dl
  800a5b:	74 da                	je     800a37 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a5d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a61:	75 07                	jne    800a6a <strncmp+0x38>
		return 0;
  800a63:	b8 00 00 00 00       	mov    $0x0,%eax
  800a68:	eb 14                	jmp    800a7e <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6d:	8a 00                	mov    (%eax),%al
  800a6f:	0f b6 d0             	movzbl %al,%edx
  800a72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a75:	8a 00                	mov    (%eax),%al
  800a77:	0f b6 c0             	movzbl %al,%eax
  800a7a:	29 c2                	sub    %eax,%edx
  800a7c:	89 d0                	mov    %edx,%eax
}
  800a7e:	5d                   	pop    %ebp
  800a7f:	c3                   	ret    

00800a80 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a80:	55                   	push   %ebp
  800a81:	89 e5                	mov    %esp,%ebp
  800a83:	83 ec 04             	sub    $0x4,%esp
  800a86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a89:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a8c:	eb 12                	jmp    800aa0 <strchr+0x20>
		if (*s == c)
  800a8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a91:	8a 00                	mov    (%eax),%al
  800a93:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a96:	75 05                	jne    800a9d <strchr+0x1d>
			return (char *) s;
  800a98:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9b:	eb 11                	jmp    800aae <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800a9d:	ff 45 08             	incl   0x8(%ebp)
  800aa0:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa3:	8a 00                	mov    (%eax),%al
  800aa5:	84 c0                	test   %al,%al
  800aa7:	75 e5                	jne    800a8e <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800aa9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800aae:	c9                   	leave  
  800aaf:	c3                   	ret    

00800ab0 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ab0:	55                   	push   %ebp
  800ab1:	89 e5                	mov    %esp,%ebp
  800ab3:	83 ec 04             	sub    $0x4,%esp
  800ab6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800abc:	eb 0d                	jmp    800acb <strfind+0x1b>
		if (*s == c)
  800abe:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac1:	8a 00                	mov    (%eax),%al
  800ac3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ac6:	74 0e                	je     800ad6 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ac8:	ff 45 08             	incl   0x8(%ebp)
  800acb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ace:	8a 00                	mov    (%eax),%al
  800ad0:	84 c0                	test   %al,%al
  800ad2:	75 ea                	jne    800abe <strfind+0xe>
  800ad4:	eb 01                	jmp    800ad7 <strfind+0x27>
		if (*s == c)
			break;
  800ad6:	90                   	nop
	return (char *) s;
  800ad7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ada:	c9                   	leave  
  800adb:	c3                   	ret    

00800adc <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800adc:	55                   	push   %ebp
  800add:	89 e5                	mov    %esp,%ebp
  800adf:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ae2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ae8:	8b 45 10             	mov    0x10(%ebp),%eax
  800aeb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800aee:	eb 0e                	jmp    800afe <memset+0x22>
		*p++ = c;
  800af0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800af3:	8d 50 01             	lea    0x1(%eax),%edx
  800af6:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800af9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800afc:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800afe:	ff 4d f8             	decl   -0x8(%ebp)
  800b01:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b05:	79 e9                	jns    800af0 <memset+0x14>
		*p++ = c;

	return v;
  800b07:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b0a:	c9                   	leave  
  800b0b:	c3                   	ret    

00800b0c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b0c:	55                   	push   %ebp
  800b0d:	89 e5                	mov    %esp,%ebp
  800b0f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b12:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b15:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b18:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b1e:	eb 16                	jmp    800b36 <memcpy+0x2a>
		*d++ = *s++;
  800b20:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b23:	8d 50 01             	lea    0x1(%eax),%edx
  800b26:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b29:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b2c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b2f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b32:	8a 12                	mov    (%edx),%dl
  800b34:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b36:	8b 45 10             	mov    0x10(%ebp),%eax
  800b39:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b3c:	89 55 10             	mov    %edx,0x10(%ebp)
  800b3f:	85 c0                	test   %eax,%eax
  800b41:	75 dd                	jne    800b20 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b43:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b46:	c9                   	leave  
  800b47:	c3                   	ret    

00800b48 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b48:	55                   	push   %ebp
  800b49:	89 e5                	mov    %esp,%ebp
  800b4b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b51:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b54:	8b 45 08             	mov    0x8(%ebp),%eax
  800b57:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b5d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b60:	73 50                	jae    800bb2 <memmove+0x6a>
  800b62:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b65:	8b 45 10             	mov    0x10(%ebp),%eax
  800b68:	01 d0                	add    %edx,%eax
  800b6a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b6d:	76 43                	jbe    800bb2 <memmove+0x6a>
		s += n;
  800b6f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b72:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b75:	8b 45 10             	mov    0x10(%ebp),%eax
  800b78:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b7b:	eb 10                	jmp    800b8d <memmove+0x45>
			*--d = *--s;
  800b7d:	ff 4d f8             	decl   -0x8(%ebp)
  800b80:	ff 4d fc             	decl   -0x4(%ebp)
  800b83:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b86:	8a 10                	mov    (%eax),%dl
  800b88:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b8b:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b8d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b90:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b93:	89 55 10             	mov    %edx,0x10(%ebp)
  800b96:	85 c0                	test   %eax,%eax
  800b98:	75 e3                	jne    800b7d <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800b9a:	eb 23                	jmp    800bbf <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800b9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b9f:	8d 50 01             	lea    0x1(%eax),%edx
  800ba2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ba5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ba8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bab:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bae:	8a 12                	mov    (%edx),%dl
  800bb0:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bb2:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bb8:	89 55 10             	mov    %edx,0x10(%ebp)
  800bbb:	85 c0                	test   %eax,%eax
  800bbd:	75 dd                	jne    800b9c <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bbf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bc2:	c9                   	leave  
  800bc3:	c3                   	ret    

00800bc4 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bc4:	55                   	push   %ebp
  800bc5:	89 e5                	mov    %esp,%ebp
  800bc7:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bca:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bd0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd3:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bd6:	eb 2a                	jmp    800c02 <memcmp+0x3e>
		if (*s1 != *s2)
  800bd8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bdb:	8a 10                	mov    (%eax),%dl
  800bdd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800be0:	8a 00                	mov    (%eax),%al
  800be2:	38 c2                	cmp    %al,%dl
  800be4:	74 16                	je     800bfc <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800be6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800be9:	8a 00                	mov    (%eax),%al
  800beb:	0f b6 d0             	movzbl %al,%edx
  800bee:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bf1:	8a 00                	mov    (%eax),%al
  800bf3:	0f b6 c0             	movzbl %al,%eax
  800bf6:	29 c2                	sub    %eax,%edx
  800bf8:	89 d0                	mov    %edx,%eax
  800bfa:	eb 18                	jmp    800c14 <memcmp+0x50>
		s1++, s2++;
  800bfc:	ff 45 fc             	incl   -0x4(%ebp)
  800bff:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c02:	8b 45 10             	mov    0x10(%ebp),%eax
  800c05:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c08:	89 55 10             	mov    %edx,0x10(%ebp)
  800c0b:	85 c0                	test   %eax,%eax
  800c0d:	75 c9                	jne    800bd8 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c0f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c14:	c9                   	leave  
  800c15:	c3                   	ret    

00800c16 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c16:	55                   	push   %ebp
  800c17:	89 e5                	mov    %esp,%ebp
  800c19:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c1c:	8b 55 08             	mov    0x8(%ebp),%edx
  800c1f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c22:	01 d0                	add    %edx,%eax
  800c24:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c27:	eb 15                	jmp    800c3e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c29:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2c:	8a 00                	mov    (%eax),%al
  800c2e:	0f b6 d0             	movzbl %al,%edx
  800c31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c34:	0f b6 c0             	movzbl %al,%eax
  800c37:	39 c2                	cmp    %eax,%edx
  800c39:	74 0d                	je     800c48 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c3b:	ff 45 08             	incl   0x8(%ebp)
  800c3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c41:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c44:	72 e3                	jb     800c29 <memfind+0x13>
  800c46:	eb 01                	jmp    800c49 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c48:	90                   	nop
	return (void *) s;
  800c49:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c4c:	c9                   	leave  
  800c4d:	c3                   	ret    

00800c4e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c4e:	55                   	push   %ebp
  800c4f:	89 e5                	mov    %esp,%ebp
  800c51:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c54:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c5b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c62:	eb 03                	jmp    800c67 <strtol+0x19>
		s++;
  800c64:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c67:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6a:	8a 00                	mov    (%eax),%al
  800c6c:	3c 20                	cmp    $0x20,%al
  800c6e:	74 f4                	je     800c64 <strtol+0x16>
  800c70:	8b 45 08             	mov    0x8(%ebp),%eax
  800c73:	8a 00                	mov    (%eax),%al
  800c75:	3c 09                	cmp    $0x9,%al
  800c77:	74 eb                	je     800c64 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c79:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7c:	8a 00                	mov    (%eax),%al
  800c7e:	3c 2b                	cmp    $0x2b,%al
  800c80:	75 05                	jne    800c87 <strtol+0x39>
		s++;
  800c82:	ff 45 08             	incl   0x8(%ebp)
  800c85:	eb 13                	jmp    800c9a <strtol+0x4c>
	else if (*s == '-')
  800c87:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8a:	8a 00                	mov    (%eax),%al
  800c8c:	3c 2d                	cmp    $0x2d,%al
  800c8e:	75 0a                	jne    800c9a <strtol+0x4c>
		s++, neg = 1;
  800c90:	ff 45 08             	incl   0x8(%ebp)
  800c93:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800c9a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c9e:	74 06                	je     800ca6 <strtol+0x58>
  800ca0:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ca4:	75 20                	jne    800cc6 <strtol+0x78>
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	8a 00                	mov    (%eax),%al
  800cab:	3c 30                	cmp    $0x30,%al
  800cad:	75 17                	jne    800cc6 <strtol+0x78>
  800caf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb2:	40                   	inc    %eax
  800cb3:	8a 00                	mov    (%eax),%al
  800cb5:	3c 78                	cmp    $0x78,%al
  800cb7:	75 0d                	jne    800cc6 <strtol+0x78>
		s += 2, base = 16;
  800cb9:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cbd:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cc4:	eb 28                	jmp    800cee <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800cc6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cca:	75 15                	jne    800ce1 <strtol+0x93>
  800ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccf:	8a 00                	mov    (%eax),%al
  800cd1:	3c 30                	cmp    $0x30,%al
  800cd3:	75 0c                	jne    800ce1 <strtol+0x93>
		s++, base = 8;
  800cd5:	ff 45 08             	incl   0x8(%ebp)
  800cd8:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cdf:	eb 0d                	jmp    800cee <strtol+0xa0>
	else if (base == 0)
  800ce1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce5:	75 07                	jne    800cee <strtol+0xa0>
		base = 10;
  800ce7:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800cee:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf1:	8a 00                	mov    (%eax),%al
  800cf3:	3c 2f                	cmp    $0x2f,%al
  800cf5:	7e 19                	jle    800d10 <strtol+0xc2>
  800cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfa:	8a 00                	mov    (%eax),%al
  800cfc:	3c 39                	cmp    $0x39,%al
  800cfe:	7f 10                	jg     800d10 <strtol+0xc2>
			dig = *s - '0';
  800d00:	8b 45 08             	mov    0x8(%ebp),%eax
  800d03:	8a 00                	mov    (%eax),%al
  800d05:	0f be c0             	movsbl %al,%eax
  800d08:	83 e8 30             	sub    $0x30,%eax
  800d0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d0e:	eb 42                	jmp    800d52 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	8a 00                	mov    (%eax),%al
  800d15:	3c 60                	cmp    $0x60,%al
  800d17:	7e 19                	jle    800d32 <strtol+0xe4>
  800d19:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1c:	8a 00                	mov    (%eax),%al
  800d1e:	3c 7a                	cmp    $0x7a,%al
  800d20:	7f 10                	jg     800d32 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d22:	8b 45 08             	mov    0x8(%ebp),%eax
  800d25:	8a 00                	mov    (%eax),%al
  800d27:	0f be c0             	movsbl %al,%eax
  800d2a:	83 e8 57             	sub    $0x57,%eax
  800d2d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d30:	eb 20                	jmp    800d52 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d32:	8b 45 08             	mov    0x8(%ebp),%eax
  800d35:	8a 00                	mov    (%eax),%al
  800d37:	3c 40                	cmp    $0x40,%al
  800d39:	7e 39                	jle    800d74 <strtol+0x126>
  800d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3e:	8a 00                	mov    (%eax),%al
  800d40:	3c 5a                	cmp    $0x5a,%al
  800d42:	7f 30                	jg     800d74 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d44:	8b 45 08             	mov    0x8(%ebp),%eax
  800d47:	8a 00                	mov    (%eax),%al
  800d49:	0f be c0             	movsbl %al,%eax
  800d4c:	83 e8 37             	sub    $0x37,%eax
  800d4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d52:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d55:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d58:	7d 19                	jge    800d73 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d5a:	ff 45 08             	incl   0x8(%ebp)
  800d5d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d60:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d64:	89 c2                	mov    %eax,%edx
  800d66:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d69:	01 d0                	add    %edx,%eax
  800d6b:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d6e:	e9 7b ff ff ff       	jmp    800cee <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d73:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d74:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d78:	74 08                	je     800d82 <strtol+0x134>
		*endptr = (char *) s;
  800d7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7d:	8b 55 08             	mov    0x8(%ebp),%edx
  800d80:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d82:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d86:	74 07                	je     800d8f <strtol+0x141>
  800d88:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d8b:	f7 d8                	neg    %eax
  800d8d:	eb 03                	jmp    800d92 <strtol+0x144>
  800d8f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d92:	c9                   	leave  
  800d93:	c3                   	ret    

00800d94 <ltostr>:

void
ltostr(long value, char *str)
{
  800d94:	55                   	push   %ebp
  800d95:	89 e5                	mov    %esp,%ebp
  800d97:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800d9a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800da1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800da8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dac:	79 13                	jns    800dc1 <ltostr+0x2d>
	{
		neg = 1;
  800dae:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800db5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db8:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800dbb:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800dbe:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800dc9:	99                   	cltd   
  800dca:	f7 f9                	idiv   %ecx
  800dcc:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800dcf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dd2:	8d 50 01             	lea    0x1(%eax),%edx
  800dd5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dd8:	89 c2                	mov    %eax,%edx
  800dda:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ddd:	01 d0                	add    %edx,%eax
  800ddf:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800de2:	83 c2 30             	add    $0x30,%edx
  800de5:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800de7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dea:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800def:	f7 e9                	imul   %ecx
  800df1:	c1 fa 02             	sar    $0x2,%edx
  800df4:	89 c8                	mov    %ecx,%eax
  800df6:	c1 f8 1f             	sar    $0x1f,%eax
  800df9:	29 c2                	sub    %eax,%edx
  800dfb:	89 d0                	mov    %edx,%eax
  800dfd:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e00:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e03:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e08:	f7 e9                	imul   %ecx
  800e0a:	c1 fa 02             	sar    $0x2,%edx
  800e0d:	89 c8                	mov    %ecx,%eax
  800e0f:	c1 f8 1f             	sar    $0x1f,%eax
  800e12:	29 c2                	sub    %eax,%edx
  800e14:	89 d0                	mov    %edx,%eax
  800e16:	c1 e0 02             	shl    $0x2,%eax
  800e19:	01 d0                	add    %edx,%eax
  800e1b:	01 c0                	add    %eax,%eax
  800e1d:	29 c1                	sub    %eax,%ecx
  800e1f:	89 ca                	mov    %ecx,%edx
  800e21:	85 d2                	test   %edx,%edx
  800e23:	75 9c                	jne    800dc1 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e25:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e2c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e2f:	48                   	dec    %eax
  800e30:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e33:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e37:	74 3d                	je     800e76 <ltostr+0xe2>
		start = 1 ;
  800e39:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e40:	eb 34                	jmp    800e76 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e42:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e48:	01 d0                	add    %edx,%eax
  800e4a:	8a 00                	mov    (%eax),%al
  800e4c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e4f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e55:	01 c2                	add    %eax,%edx
  800e57:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5d:	01 c8                	add    %ecx,%eax
  800e5f:	8a 00                	mov    (%eax),%al
  800e61:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e63:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e69:	01 c2                	add    %eax,%edx
  800e6b:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e6e:	88 02                	mov    %al,(%edx)
		start++ ;
  800e70:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e73:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e76:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e79:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e7c:	7c c4                	jl     800e42 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e7e:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e84:	01 d0                	add    %edx,%eax
  800e86:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e89:	90                   	nop
  800e8a:	c9                   	leave  
  800e8b:	c3                   	ret    

00800e8c <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e8c:	55                   	push   %ebp
  800e8d:	89 e5                	mov    %esp,%ebp
  800e8f:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e92:	ff 75 08             	pushl  0x8(%ebp)
  800e95:	e8 54 fa ff ff       	call   8008ee <strlen>
  800e9a:	83 c4 04             	add    $0x4,%esp
  800e9d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800ea0:	ff 75 0c             	pushl  0xc(%ebp)
  800ea3:	e8 46 fa ff ff       	call   8008ee <strlen>
  800ea8:	83 c4 04             	add    $0x4,%esp
  800eab:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800eae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800eb5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ebc:	eb 17                	jmp    800ed5 <strcconcat+0x49>
		final[s] = str1[s] ;
  800ebe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ec1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec4:	01 c2                	add    %eax,%edx
  800ec6:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ec9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecc:	01 c8                	add    %ecx,%eax
  800ece:	8a 00                	mov    (%eax),%al
  800ed0:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800ed2:	ff 45 fc             	incl   -0x4(%ebp)
  800ed5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ed8:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800edb:	7c e1                	jl     800ebe <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800edd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ee4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800eeb:	eb 1f                	jmp    800f0c <strcconcat+0x80>
		final[s++] = str2[i] ;
  800eed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ef0:	8d 50 01             	lea    0x1(%eax),%edx
  800ef3:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ef6:	89 c2                	mov    %eax,%edx
  800ef8:	8b 45 10             	mov    0x10(%ebp),%eax
  800efb:	01 c2                	add    %eax,%edx
  800efd:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f03:	01 c8                	add    %ecx,%eax
  800f05:	8a 00                	mov    (%eax),%al
  800f07:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f09:	ff 45 f8             	incl   -0x8(%ebp)
  800f0c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f0f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f12:	7c d9                	jl     800eed <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f14:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f17:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1a:	01 d0                	add    %edx,%eax
  800f1c:	c6 00 00             	movb   $0x0,(%eax)
}
  800f1f:	90                   	nop
  800f20:	c9                   	leave  
  800f21:	c3                   	ret    

00800f22 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f22:	55                   	push   %ebp
  800f23:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f25:	8b 45 14             	mov    0x14(%ebp),%eax
  800f28:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f2e:	8b 45 14             	mov    0x14(%ebp),%eax
  800f31:	8b 00                	mov    (%eax),%eax
  800f33:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f3a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3d:	01 d0                	add    %edx,%eax
  800f3f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f45:	eb 0c                	jmp    800f53 <strsplit+0x31>
			*string++ = 0;
  800f47:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4a:	8d 50 01             	lea    0x1(%eax),%edx
  800f4d:	89 55 08             	mov    %edx,0x8(%ebp)
  800f50:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f53:	8b 45 08             	mov    0x8(%ebp),%eax
  800f56:	8a 00                	mov    (%eax),%al
  800f58:	84 c0                	test   %al,%al
  800f5a:	74 18                	je     800f74 <strsplit+0x52>
  800f5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5f:	8a 00                	mov    (%eax),%al
  800f61:	0f be c0             	movsbl %al,%eax
  800f64:	50                   	push   %eax
  800f65:	ff 75 0c             	pushl  0xc(%ebp)
  800f68:	e8 13 fb ff ff       	call   800a80 <strchr>
  800f6d:	83 c4 08             	add    $0x8,%esp
  800f70:	85 c0                	test   %eax,%eax
  800f72:	75 d3                	jne    800f47 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800f74:	8b 45 08             	mov    0x8(%ebp),%eax
  800f77:	8a 00                	mov    (%eax),%al
  800f79:	84 c0                	test   %al,%al
  800f7b:	74 5a                	je     800fd7 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800f7d:	8b 45 14             	mov    0x14(%ebp),%eax
  800f80:	8b 00                	mov    (%eax),%eax
  800f82:	83 f8 0f             	cmp    $0xf,%eax
  800f85:	75 07                	jne    800f8e <strsplit+0x6c>
		{
			return 0;
  800f87:	b8 00 00 00 00       	mov    $0x0,%eax
  800f8c:	eb 66                	jmp    800ff4 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f8e:	8b 45 14             	mov    0x14(%ebp),%eax
  800f91:	8b 00                	mov    (%eax),%eax
  800f93:	8d 48 01             	lea    0x1(%eax),%ecx
  800f96:	8b 55 14             	mov    0x14(%ebp),%edx
  800f99:	89 0a                	mov    %ecx,(%edx)
  800f9b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fa2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa5:	01 c2                	add    %eax,%edx
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fac:	eb 03                	jmp    800fb1 <strsplit+0x8f>
			string++;
  800fae:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb4:	8a 00                	mov    (%eax),%al
  800fb6:	84 c0                	test   %al,%al
  800fb8:	74 8b                	je     800f45 <strsplit+0x23>
  800fba:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbd:	8a 00                	mov    (%eax),%al
  800fbf:	0f be c0             	movsbl %al,%eax
  800fc2:	50                   	push   %eax
  800fc3:	ff 75 0c             	pushl  0xc(%ebp)
  800fc6:	e8 b5 fa ff ff       	call   800a80 <strchr>
  800fcb:	83 c4 08             	add    $0x8,%esp
  800fce:	85 c0                	test   %eax,%eax
  800fd0:	74 dc                	je     800fae <strsplit+0x8c>
			string++;
	}
  800fd2:	e9 6e ff ff ff       	jmp    800f45 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800fd7:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fd8:	8b 45 14             	mov    0x14(%ebp),%eax
  800fdb:	8b 00                	mov    (%eax),%eax
  800fdd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fe4:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe7:	01 d0                	add    %edx,%eax
  800fe9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800fef:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800ff4:	c9                   	leave  
  800ff5:	c3                   	ret    

00800ff6 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  800ff6:	55                   	push   %ebp
  800ff7:	89 e5                	mov    %esp,%ebp
  800ff9:	57                   	push   %edi
  800ffa:	56                   	push   %esi
  800ffb:	53                   	push   %ebx
  800ffc:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800fff:	8b 45 08             	mov    0x8(%ebp),%eax
  801002:	8b 55 0c             	mov    0xc(%ebp),%edx
  801005:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801008:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80100b:	8b 7d 18             	mov    0x18(%ebp),%edi
  80100e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801011:	cd 30                	int    $0x30
  801013:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801016:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801019:	83 c4 10             	add    $0x10,%esp
  80101c:	5b                   	pop    %ebx
  80101d:	5e                   	pop    %esi
  80101e:	5f                   	pop    %edi
  80101f:	5d                   	pop    %ebp
  801020:	c3                   	ret    

00801021 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801021:	55                   	push   %ebp
  801022:	89 e5                	mov    %esp,%ebp
  801024:	83 ec 04             	sub    $0x4,%esp
  801027:	8b 45 10             	mov    0x10(%ebp),%eax
  80102a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80102d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801031:	8b 45 08             	mov    0x8(%ebp),%eax
  801034:	6a 00                	push   $0x0
  801036:	6a 00                	push   $0x0
  801038:	52                   	push   %edx
  801039:	ff 75 0c             	pushl  0xc(%ebp)
  80103c:	50                   	push   %eax
  80103d:	6a 00                	push   $0x0
  80103f:	e8 b2 ff ff ff       	call   800ff6 <syscall>
  801044:	83 c4 18             	add    $0x18,%esp
}
  801047:	90                   	nop
  801048:	c9                   	leave  
  801049:	c3                   	ret    

0080104a <sys_cgetc>:

int
sys_cgetc(void)
{
  80104a:	55                   	push   %ebp
  80104b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80104d:	6a 00                	push   $0x0
  80104f:	6a 00                	push   $0x0
  801051:	6a 00                	push   $0x0
  801053:	6a 00                	push   $0x0
  801055:	6a 00                	push   $0x0
  801057:	6a 01                	push   $0x1
  801059:	e8 98 ff ff ff       	call   800ff6 <syscall>
  80105e:	83 c4 18             	add    $0x18,%esp
}
  801061:	c9                   	leave  
  801062:	c3                   	ret    

00801063 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801063:	55                   	push   %ebp
  801064:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801066:	8b 45 08             	mov    0x8(%ebp),%eax
  801069:	6a 00                	push   $0x0
  80106b:	6a 00                	push   $0x0
  80106d:	6a 00                	push   $0x0
  80106f:	6a 00                	push   $0x0
  801071:	50                   	push   %eax
  801072:	6a 05                	push   $0x5
  801074:	e8 7d ff ff ff       	call   800ff6 <syscall>
  801079:	83 c4 18             	add    $0x18,%esp
}
  80107c:	c9                   	leave  
  80107d:	c3                   	ret    

0080107e <sys_getenvid>:

int32 sys_getenvid(void)
{
  80107e:	55                   	push   %ebp
  80107f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801081:	6a 00                	push   $0x0
  801083:	6a 00                	push   $0x0
  801085:	6a 00                	push   $0x0
  801087:	6a 00                	push   $0x0
  801089:	6a 00                	push   $0x0
  80108b:	6a 02                	push   $0x2
  80108d:	e8 64 ff ff ff       	call   800ff6 <syscall>
  801092:	83 c4 18             	add    $0x18,%esp
}
  801095:	c9                   	leave  
  801096:	c3                   	ret    

00801097 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801097:	55                   	push   %ebp
  801098:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80109a:	6a 00                	push   $0x0
  80109c:	6a 00                	push   $0x0
  80109e:	6a 00                	push   $0x0
  8010a0:	6a 00                	push   $0x0
  8010a2:	6a 00                	push   $0x0
  8010a4:	6a 03                	push   $0x3
  8010a6:	e8 4b ff ff ff       	call   800ff6 <syscall>
  8010ab:	83 c4 18             	add    $0x18,%esp
}
  8010ae:	c9                   	leave  
  8010af:	c3                   	ret    

008010b0 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010b0:	55                   	push   %ebp
  8010b1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010b3:	6a 00                	push   $0x0
  8010b5:	6a 00                	push   $0x0
  8010b7:	6a 00                	push   $0x0
  8010b9:	6a 00                	push   $0x0
  8010bb:	6a 00                	push   $0x0
  8010bd:	6a 04                	push   $0x4
  8010bf:	e8 32 ff ff ff       	call   800ff6 <syscall>
  8010c4:	83 c4 18             	add    $0x18,%esp
}
  8010c7:	c9                   	leave  
  8010c8:	c3                   	ret    

008010c9 <sys_env_exit>:


void sys_env_exit(void)
{
  8010c9:	55                   	push   %ebp
  8010ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010cc:	6a 00                	push   $0x0
  8010ce:	6a 00                	push   $0x0
  8010d0:	6a 00                	push   $0x0
  8010d2:	6a 00                	push   $0x0
  8010d4:	6a 00                	push   $0x0
  8010d6:	6a 06                	push   $0x6
  8010d8:	e8 19 ff ff ff       	call   800ff6 <syscall>
  8010dd:	83 c4 18             	add    $0x18,%esp
}
  8010e0:	90                   	nop
  8010e1:	c9                   	leave  
  8010e2:	c3                   	ret    

008010e3 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010e3:	55                   	push   %ebp
  8010e4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ec:	6a 00                	push   $0x0
  8010ee:	6a 00                	push   $0x0
  8010f0:	6a 00                	push   $0x0
  8010f2:	52                   	push   %edx
  8010f3:	50                   	push   %eax
  8010f4:	6a 07                	push   $0x7
  8010f6:	e8 fb fe ff ff       	call   800ff6 <syscall>
  8010fb:	83 c4 18             	add    $0x18,%esp
}
  8010fe:	c9                   	leave  
  8010ff:	c3                   	ret    

00801100 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801100:	55                   	push   %ebp
  801101:	89 e5                	mov    %esp,%ebp
  801103:	56                   	push   %esi
  801104:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801105:	8b 75 18             	mov    0x18(%ebp),%esi
  801108:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80110b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80110e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801111:	8b 45 08             	mov    0x8(%ebp),%eax
  801114:	56                   	push   %esi
  801115:	53                   	push   %ebx
  801116:	51                   	push   %ecx
  801117:	52                   	push   %edx
  801118:	50                   	push   %eax
  801119:	6a 08                	push   $0x8
  80111b:	e8 d6 fe ff ff       	call   800ff6 <syscall>
  801120:	83 c4 18             	add    $0x18,%esp
}
  801123:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801126:	5b                   	pop    %ebx
  801127:	5e                   	pop    %esi
  801128:	5d                   	pop    %ebp
  801129:	c3                   	ret    

0080112a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80112a:	55                   	push   %ebp
  80112b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80112d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801130:	8b 45 08             	mov    0x8(%ebp),%eax
  801133:	6a 00                	push   $0x0
  801135:	6a 00                	push   $0x0
  801137:	6a 00                	push   $0x0
  801139:	52                   	push   %edx
  80113a:	50                   	push   %eax
  80113b:	6a 09                	push   $0x9
  80113d:	e8 b4 fe ff ff       	call   800ff6 <syscall>
  801142:	83 c4 18             	add    $0x18,%esp
}
  801145:	c9                   	leave  
  801146:	c3                   	ret    

00801147 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801147:	55                   	push   %ebp
  801148:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80114a:	6a 00                	push   $0x0
  80114c:	6a 00                	push   $0x0
  80114e:	6a 00                	push   $0x0
  801150:	ff 75 0c             	pushl  0xc(%ebp)
  801153:	ff 75 08             	pushl  0x8(%ebp)
  801156:	6a 0a                	push   $0xa
  801158:	e8 99 fe ff ff       	call   800ff6 <syscall>
  80115d:	83 c4 18             	add    $0x18,%esp
}
  801160:	c9                   	leave  
  801161:	c3                   	ret    

00801162 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801162:	55                   	push   %ebp
  801163:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801165:	6a 00                	push   $0x0
  801167:	6a 00                	push   $0x0
  801169:	6a 00                	push   $0x0
  80116b:	6a 00                	push   $0x0
  80116d:	6a 00                	push   $0x0
  80116f:	6a 0b                	push   $0xb
  801171:	e8 80 fe ff ff       	call   800ff6 <syscall>
  801176:	83 c4 18             	add    $0x18,%esp
}
  801179:	c9                   	leave  
  80117a:	c3                   	ret    

0080117b <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80117b:	55                   	push   %ebp
  80117c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80117e:	6a 00                	push   $0x0
  801180:	6a 00                	push   $0x0
  801182:	6a 00                	push   $0x0
  801184:	6a 00                	push   $0x0
  801186:	6a 00                	push   $0x0
  801188:	6a 0c                	push   $0xc
  80118a:	e8 67 fe ff ff       	call   800ff6 <syscall>
  80118f:	83 c4 18             	add    $0x18,%esp
}
  801192:	c9                   	leave  
  801193:	c3                   	ret    

00801194 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801194:	55                   	push   %ebp
  801195:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801197:	6a 00                	push   $0x0
  801199:	6a 00                	push   $0x0
  80119b:	6a 00                	push   $0x0
  80119d:	6a 00                	push   $0x0
  80119f:	6a 00                	push   $0x0
  8011a1:	6a 0d                	push   $0xd
  8011a3:	e8 4e fe ff ff       	call   800ff6 <syscall>
  8011a8:	83 c4 18             	add    $0x18,%esp
}
  8011ab:	c9                   	leave  
  8011ac:	c3                   	ret    

008011ad <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011ad:	55                   	push   %ebp
  8011ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011b0:	6a 00                	push   $0x0
  8011b2:	6a 00                	push   $0x0
  8011b4:	6a 00                	push   $0x0
  8011b6:	ff 75 0c             	pushl  0xc(%ebp)
  8011b9:	ff 75 08             	pushl  0x8(%ebp)
  8011bc:	6a 11                	push   $0x11
  8011be:	e8 33 fe ff ff       	call   800ff6 <syscall>
  8011c3:	83 c4 18             	add    $0x18,%esp
	return;
  8011c6:	90                   	nop
}
  8011c7:	c9                   	leave  
  8011c8:	c3                   	ret    

008011c9 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011c9:	55                   	push   %ebp
  8011ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011cc:	6a 00                	push   $0x0
  8011ce:	6a 00                	push   $0x0
  8011d0:	6a 00                	push   $0x0
  8011d2:	ff 75 0c             	pushl  0xc(%ebp)
  8011d5:	ff 75 08             	pushl  0x8(%ebp)
  8011d8:	6a 12                	push   $0x12
  8011da:	e8 17 fe ff ff       	call   800ff6 <syscall>
  8011df:	83 c4 18             	add    $0x18,%esp
	return ;
  8011e2:	90                   	nop
}
  8011e3:	c9                   	leave  
  8011e4:	c3                   	ret    

008011e5 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011e5:	55                   	push   %ebp
  8011e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011e8:	6a 00                	push   $0x0
  8011ea:	6a 00                	push   $0x0
  8011ec:	6a 00                	push   $0x0
  8011ee:	6a 00                	push   $0x0
  8011f0:	6a 00                	push   $0x0
  8011f2:	6a 0e                	push   $0xe
  8011f4:	e8 fd fd ff ff       	call   800ff6 <syscall>
  8011f9:	83 c4 18             	add    $0x18,%esp
}
  8011fc:	c9                   	leave  
  8011fd:	c3                   	ret    

008011fe <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8011fe:	55                   	push   %ebp
  8011ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801201:	6a 00                	push   $0x0
  801203:	6a 00                	push   $0x0
  801205:	6a 00                	push   $0x0
  801207:	6a 00                	push   $0x0
  801209:	ff 75 08             	pushl  0x8(%ebp)
  80120c:	6a 0f                	push   $0xf
  80120e:	e8 e3 fd ff ff       	call   800ff6 <syscall>
  801213:	83 c4 18             	add    $0x18,%esp
}
  801216:	c9                   	leave  
  801217:	c3                   	ret    

00801218 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801218:	55                   	push   %ebp
  801219:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80121b:	6a 00                	push   $0x0
  80121d:	6a 00                	push   $0x0
  80121f:	6a 00                	push   $0x0
  801221:	6a 00                	push   $0x0
  801223:	6a 00                	push   $0x0
  801225:	6a 10                	push   $0x10
  801227:	e8 ca fd ff ff       	call   800ff6 <syscall>
  80122c:	83 c4 18             	add    $0x18,%esp
}
  80122f:	90                   	nop
  801230:	c9                   	leave  
  801231:	c3                   	ret    

00801232 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801232:	55                   	push   %ebp
  801233:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801235:	6a 00                	push   $0x0
  801237:	6a 00                	push   $0x0
  801239:	6a 00                	push   $0x0
  80123b:	6a 00                	push   $0x0
  80123d:	6a 00                	push   $0x0
  80123f:	6a 14                	push   $0x14
  801241:	e8 b0 fd ff ff       	call   800ff6 <syscall>
  801246:	83 c4 18             	add    $0x18,%esp
}
  801249:	90                   	nop
  80124a:	c9                   	leave  
  80124b:	c3                   	ret    

0080124c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80124c:	55                   	push   %ebp
  80124d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80124f:	6a 00                	push   $0x0
  801251:	6a 00                	push   $0x0
  801253:	6a 00                	push   $0x0
  801255:	6a 00                	push   $0x0
  801257:	6a 00                	push   $0x0
  801259:	6a 15                	push   $0x15
  80125b:	e8 96 fd ff ff       	call   800ff6 <syscall>
  801260:	83 c4 18             	add    $0x18,%esp
}
  801263:	90                   	nop
  801264:	c9                   	leave  
  801265:	c3                   	ret    

00801266 <sys_cputc>:


void
sys_cputc(const char c)
{
  801266:	55                   	push   %ebp
  801267:	89 e5                	mov    %esp,%ebp
  801269:	83 ec 04             	sub    $0x4,%esp
  80126c:	8b 45 08             	mov    0x8(%ebp),%eax
  80126f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801272:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801276:	6a 00                	push   $0x0
  801278:	6a 00                	push   $0x0
  80127a:	6a 00                	push   $0x0
  80127c:	6a 00                	push   $0x0
  80127e:	50                   	push   %eax
  80127f:	6a 16                	push   $0x16
  801281:	e8 70 fd ff ff       	call   800ff6 <syscall>
  801286:	83 c4 18             	add    $0x18,%esp
}
  801289:	90                   	nop
  80128a:	c9                   	leave  
  80128b:	c3                   	ret    

0080128c <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80128c:	55                   	push   %ebp
  80128d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80128f:	6a 00                	push   $0x0
  801291:	6a 00                	push   $0x0
  801293:	6a 00                	push   $0x0
  801295:	6a 00                	push   $0x0
  801297:	6a 00                	push   $0x0
  801299:	6a 17                	push   $0x17
  80129b:	e8 56 fd ff ff       	call   800ff6 <syscall>
  8012a0:	83 c4 18             	add    $0x18,%esp
}
  8012a3:	90                   	nop
  8012a4:	c9                   	leave  
  8012a5:	c3                   	ret    

008012a6 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012a6:	55                   	push   %ebp
  8012a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ac:	6a 00                	push   $0x0
  8012ae:	6a 00                	push   $0x0
  8012b0:	6a 00                	push   $0x0
  8012b2:	ff 75 0c             	pushl  0xc(%ebp)
  8012b5:	50                   	push   %eax
  8012b6:	6a 18                	push   $0x18
  8012b8:	e8 39 fd ff ff       	call   800ff6 <syscall>
  8012bd:	83 c4 18             	add    $0x18,%esp
}
  8012c0:	c9                   	leave  
  8012c1:	c3                   	ret    

008012c2 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012c2:	55                   	push   %ebp
  8012c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cb:	6a 00                	push   $0x0
  8012cd:	6a 00                	push   $0x0
  8012cf:	6a 00                	push   $0x0
  8012d1:	52                   	push   %edx
  8012d2:	50                   	push   %eax
  8012d3:	6a 1b                	push   $0x1b
  8012d5:	e8 1c fd ff ff       	call   800ff6 <syscall>
  8012da:	83 c4 18             	add    $0x18,%esp
}
  8012dd:	c9                   	leave  
  8012de:	c3                   	ret    

008012df <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012df:	55                   	push   %ebp
  8012e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e8:	6a 00                	push   $0x0
  8012ea:	6a 00                	push   $0x0
  8012ec:	6a 00                	push   $0x0
  8012ee:	52                   	push   %edx
  8012ef:	50                   	push   %eax
  8012f0:	6a 19                	push   $0x19
  8012f2:	e8 ff fc ff ff       	call   800ff6 <syscall>
  8012f7:	83 c4 18             	add    $0x18,%esp
}
  8012fa:	90                   	nop
  8012fb:	c9                   	leave  
  8012fc:	c3                   	ret    

008012fd <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012fd:	55                   	push   %ebp
  8012fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801300:	8b 55 0c             	mov    0xc(%ebp),%edx
  801303:	8b 45 08             	mov    0x8(%ebp),%eax
  801306:	6a 00                	push   $0x0
  801308:	6a 00                	push   $0x0
  80130a:	6a 00                	push   $0x0
  80130c:	52                   	push   %edx
  80130d:	50                   	push   %eax
  80130e:	6a 1a                	push   $0x1a
  801310:	e8 e1 fc ff ff       	call   800ff6 <syscall>
  801315:	83 c4 18             	add    $0x18,%esp
}
  801318:	90                   	nop
  801319:	c9                   	leave  
  80131a:	c3                   	ret    

0080131b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80131b:	55                   	push   %ebp
  80131c:	89 e5                	mov    %esp,%ebp
  80131e:	83 ec 04             	sub    $0x4,%esp
  801321:	8b 45 10             	mov    0x10(%ebp),%eax
  801324:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801327:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80132a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80132e:	8b 45 08             	mov    0x8(%ebp),%eax
  801331:	6a 00                	push   $0x0
  801333:	51                   	push   %ecx
  801334:	52                   	push   %edx
  801335:	ff 75 0c             	pushl  0xc(%ebp)
  801338:	50                   	push   %eax
  801339:	6a 1c                	push   $0x1c
  80133b:	e8 b6 fc ff ff       	call   800ff6 <syscall>
  801340:	83 c4 18             	add    $0x18,%esp
}
  801343:	c9                   	leave  
  801344:	c3                   	ret    

00801345 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801345:	55                   	push   %ebp
  801346:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801348:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134b:	8b 45 08             	mov    0x8(%ebp),%eax
  80134e:	6a 00                	push   $0x0
  801350:	6a 00                	push   $0x0
  801352:	6a 00                	push   $0x0
  801354:	52                   	push   %edx
  801355:	50                   	push   %eax
  801356:	6a 1d                	push   $0x1d
  801358:	e8 99 fc ff ff       	call   800ff6 <syscall>
  80135d:	83 c4 18             	add    $0x18,%esp
}
  801360:	c9                   	leave  
  801361:	c3                   	ret    

00801362 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801362:	55                   	push   %ebp
  801363:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801365:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801368:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	6a 00                	push   $0x0
  801370:	6a 00                	push   $0x0
  801372:	51                   	push   %ecx
  801373:	52                   	push   %edx
  801374:	50                   	push   %eax
  801375:	6a 1e                	push   $0x1e
  801377:	e8 7a fc ff ff       	call   800ff6 <syscall>
  80137c:	83 c4 18             	add    $0x18,%esp
}
  80137f:	c9                   	leave  
  801380:	c3                   	ret    

00801381 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801381:	55                   	push   %ebp
  801382:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801384:	8b 55 0c             	mov    0xc(%ebp),%edx
  801387:	8b 45 08             	mov    0x8(%ebp),%eax
  80138a:	6a 00                	push   $0x0
  80138c:	6a 00                	push   $0x0
  80138e:	6a 00                	push   $0x0
  801390:	52                   	push   %edx
  801391:	50                   	push   %eax
  801392:	6a 1f                	push   $0x1f
  801394:	e8 5d fc ff ff       	call   800ff6 <syscall>
  801399:	83 c4 18             	add    $0x18,%esp
}
  80139c:	c9                   	leave  
  80139d:	c3                   	ret    

0080139e <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80139e:	55                   	push   %ebp
  80139f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013a1:	6a 00                	push   $0x0
  8013a3:	6a 00                	push   $0x0
  8013a5:	6a 00                	push   $0x0
  8013a7:	6a 00                	push   $0x0
  8013a9:	6a 00                	push   $0x0
  8013ab:	6a 20                	push   $0x20
  8013ad:	e8 44 fc ff ff       	call   800ff6 <syscall>
  8013b2:	83 c4 18             	add    $0x18,%esp
}
  8013b5:	c9                   	leave  
  8013b6:	c3                   	ret    

008013b7 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8013b7:	55                   	push   %ebp
  8013b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8013ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bd:	6a 00                	push   $0x0
  8013bf:	ff 75 14             	pushl  0x14(%ebp)
  8013c2:	ff 75 10             	pushl  0x10(%ebp)
  8013c5:	ff 75 0c             	pushl  0xc(%ebp)
  8013c8:	50                   	push   %eax
  8013c9:	6a 21                	push   $0x21
  8013cb:	e8 26 fc ff ff       	call   800ff6 <syscall>
  8013d0:	83 c4 18             	add    $0x18,%esp
}
  8013d3:	c9                   	leave  
  8013d4:	c3                   	ret    

008013d5 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8013d5:	55                   	push   %ebp
  8013d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 00                	push   $0x0
  8013df:	6a 00                	push   $0x0
  8013e1:	6a 00                	push   $0x0
  8013e3:	50                   	push   %eax
  8013e4:	6a 22                	push   $0x22
  8013e6:	e8 0b fc ff ff       	call   800ff6 <syscall>
  8013eb:	83 c4 18             	add    $0x18,%esp
}
  8013ee:	90                   	nop
  8013ef:	c9                   	leave  
  8013f0:	c3                   	ret    

008013f1 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013f1:	55                   	push   %ebp
  8013f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8013f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 00                	push   $0x0
  8013ff:	50                   	push   %eax
  801400:	6a 23                	push   $0x23
  801402:	e8 ef fb ff ff       	call   800ff6 <syscall>
  801407:	83 c4 18             	add    $0x18,%esp
}
  80140a:	90                   	nop
  80140b:	c9                   	leave  
  80140c:	c3                   	ret    

0080140d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80140d:	55                   	push   %ebp
  80140e:	89 e5                	mov    %esp,%ebp
  801410:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801413:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801416:	8d 50 04             	lea    0x4(%eax),%edx
  801419:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	52                   	push   %edx
  801423:	50                   	push   %eax
  801424:	6a 24                	push   $0x24
  801426:	e8 cb fb ff ff       	call   800ff6 <syscall>
  80142b:	83 c4 18             	add    $0x18,%esp
	return result;
  80142e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801431:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801434:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801437:	89 01                	mov    %eax,(%ecx)
  801439:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80143c:	8b 45 08             	mov    0x8(%ebp),%eax
  80143f:	c9                   	leave  
  801440:	c2 04 00             	ret    $0x4

00801443 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801443:	55                   	push   %ebp
  801444:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	ff 75 10             	pushl  0x10(%ebp)
  80144d:	ff 75 0c             	pushl  0xc(%ebp)
  801450:	ff 75 08             	pushl  0x8(%ebp)
  801453:	6a 13                	push   $0x13
  801455:	e8 9c fb ff ff       	call   800ff6 <syscall>
  80145a:	83 c4 18             	add    $0x18,%esp
	return ;
  80145d:	90                   	nop
}
  80145e:	c9                   	leave  
  80145f:	c3                   	ret    

00801460 <sys_rcr2>:
uint32 sys_rcr2()
{
  801460:	55                   	push   %ebp
  801461:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801463:	6a 00                	push   $0x0
  801465:	6a 00                	push   $0x0
  801467:	6a 00                	push   $0x0
  801469:	6a 00                	push   $0x0
  80146b:	6a 00                	push   $0x0
  80146d:	6a 25                	push   $0x25
  80146f:	e8 82 fb ff ff       	call   800ff6 <syscall>
  801474:	83 c4 18             	add    $0x18,%esp
}
  801477:	c9                   	leave  
  801478:	c3                   	ret    

00801479 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801479:	55                   	push   %ebp
  80147a:	89 e5                	mov    %esp,%ebp
  80147c:	83 ec 04             	sub    $0x4,%esp
  80147f:	8b 45 08             	mov    0x8(%ebp),%eax
  801482:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801485:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801489:	6a 00                	push   $0x0
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	50                   	push   %eax
  801492:	6a 26                	push   $0x26
  801494:	e8 5d fb ff ff       	call   800ff6 <syscall>
  801499:	83 c4 18             	add    $0x18,%esp
	return ;
  80149c:	90                   	nop
}
  80149d:	c9                   	leave  
  80149e:	c3                   	ret    

0080149f <rsttst>:
void rsttst()
{
  80149f:	55                   	push   %ebp
  8014a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014a2:	6a 00                	push   $0x0
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 00                	push   $0x0
  8014ac:	6a 28                	push   $0x28
  8014ae:	e8 43 fb ff ff       	call   800ff6 <syscall>
  8014b3:	83 c4 18             	add    $0x18,%esp
	return ;
  8014b6:	90                   	nop
}
  8014b7:	c9                   	leave  
  8014b8:	c3                   	ret    

008014b9 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014b9:	55                   	push   %ebp
  8014ba:	89 e5                	mov    %esp,%ebp
  8014bc:	83 ec 04             	sub    $0x4,%esp
  8014bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8014c2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014c5:	8b 55 18             	mov    0x18(%ebp),%edx
  8014c8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014cc:	52                   	push   %edx
  8014cd:	50                   	push   %eax
  8014ce:	ff 75 10             	pushl  0x10(%ebp)
  8014d1:	ff 75 0c             	pushl  0xc(%ebp)
  8014d4:	ff 75 08             	pushl  0x8(%ebp)
  8014d7:	6a 27                	push   $0x27
  8014d9:	e8 18 fb ff ff       	call   800ff6 <syscall>
  8014de:	83 c4 18             	add    $0x18,%esp
	return ;
  8014e1:	90                   	nop
}
  8014e2:	c9                   	leave  
  8014e3:	c3                   	ret    

008014e4 <chktst>:
void chktst(uint32 n)
{
  8014e4:	55                   	push   %ebp
  8014e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 00                	push   $0x0
  8014ef:	ff 75 08             	pushl  0x8(%ebp)
  8014f2:	6a 29                	push   $0x29
  8014f4:	e8 fd fa ff ff       	call   800ff6 <syscall>
  8014f9:	83 c4 18             	add    $0x18,%esp
	return ;
  8014fc:	90                   	nop
}
  8014fd:	c9                   	leave  
  8014fe:	c3                   	ret    

008014ff <inctst>:

void inctst()
{
  8014ff:	55                   	push   %ebp
  801500:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801502:	6a 00                	push   $0x0
  801504:	6a 00                	push   $0x0
  801506:	6a 00                	push   $0x0
  801508:	6a 00                	push   $0x0
  80150a:	6a 00                	push   $0x0
  80150c:	6a 2a                	push   $0x2a
  80150e:	e8 e3 fa ff ff       	call   800ff6 <syscall>
  801513:	83 c4 18             	add    $0x18,%esp
	return ;
  801516:	90                   	nop
}
  801517:	c9                   	leave  
  801518:	c3                   	ret    

00801519 <gettst>:
uint32 gettst()
{
  801519:	55                   	push   %ebp
  80151a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80151c:	6a 00                	push   $0x0
  80151e:	6a 00                	push   $0x0
  801520:	6a 00                	push   $0x0
  801522:	6a 00                	push   $0x0
  801524:	6a 00                	push   $0x0
  801526:	6a 2b                	push   $0x2b
  801528:	e8 c9 fa ff ff       	call   800ff6 <syscall>
  80152d:	83 c4 18             	add    $0x18,%esp
}
  801530:	c9                   	leave  
  801531:	c3                   	ret    

00801532 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801532:	55                   	push   %ebp
  801533:	89 e5                	mov    %esp,%ebp
  801535:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801538:	6a 00                	push   $0x0
  80153a:	6a 00                	push   $0x0
  80153c:	6a 00                	push   $0x0
  80153e:	6a 00                	push   $0x0
  801540:	6a 00                	push   $0x0
  801542:	6a 2c                	push   $0x2c
  801544:	e8 ad fa ff ff       	call   800ff6 <syscall>
  801549:	83 c4 18             	add    $0x18,%esp
  80154c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80154f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801553:	75 07                	jne    80155c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801555:	b8 01 00 00 00       	mov    $0x1,%eax
  80155a:	eb 05                	jmp    801561 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80155c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801561:	c9                   	leave  
  801562:	c3                   	ret    

00801563 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801563:	55                   	push   %ebp
  801564:	89 e5                	mov    %esp,%ebp
  801566:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	6a 00                	push   $0x0
  801571:	6a 00                	push   $0x0
  801573:	6a 2c                	push   $0x2c
  801575:	e8 7c fa ff ff       	call   800ff6 <syscall>
  80157a:	83 c4 18             	add    $0x18,%esp
  80157d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801580:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801584:	75 07                	jne    80158d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801586:	b8 01 00 00 00       	mov    $0x1,%eax
  80158b:	eb 05                	jmp    801592 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80158d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801592:	c9                   	leave  
  801593:	c3                   	ret    

00801594 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801594:	55                   	push   %ebp
  801595:	89 e5                	mov    %esp,%ebp
  801597:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80159a:	6a 00                	push   $0x0
  80159c:	6a 00                	push   $0x0
  80159e:	6a 00                	push   $0x0
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 2c                	push   $0x2c
  8015a6:	e8 4b fa ff ff       	call   800ff6 <syscall>
  8015ab:	83 c4 18             	add    $0x18,%esp
  8015ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015b1:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015b5:	75 07                	jne    8015be <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015b7:	b8 01 00 00 00       	mov    $0x1,%eax
  8015bc:	eb 05                	jmp    8015c3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015be:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015c3:	c9                   	leave  
  8015c4:	c3                   	ret    

008015c5 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015c5:	55                   	push   %ebp
  8015c6:	89 e5                	mov    %esp,%ebp
  8015c8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015cb:	6a 00                	push   $0x0
  8015cd:	6a 00                	push   $0x0
  8015cf:	6a 00                	push   $0x0
  8015d1:	6a 00                	push   $0x0
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 2c                	push   $0x2c
  8015d7:	e8 1a fa ff ff       	call   800ff6 <syscall>
  8015dc:	83 c4 18             	add    $0x18,%esp
  8015df:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015e2:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015e6:	75 07                	jne    8015ef <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015e8:	b8 01 00 00 00       	mov    $0x1,%eax
  8015ed:	eb 05                	jmp    8015f4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015f4:	c9                   	leave  
  8015f5:	c3                   	ret    

008015f6 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8015f6:	55                   	push   %ebp
  8015f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	ff 75 08             	pushl  0x8(%ebp)
  801604:	6a 2d                	push   $0x2d
  801606:	e8 eb f9 ff ff       	call   800ff6 <syscall>
  80160b:	83 c4 18             	add    $0x18,%esp
	return ;
  80160e:	90                   	nop
}
  80160f:	c9                   	leave  
  801610:	c3                   	ret    

00801611 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801611:	55                   	push   %ebp
  801612:	89 e5                	mov    %esp,%ebp
  801614:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801615:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801618:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80161b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80161e:	8b 45 08             	mov    0x8(%ebp),%eax
  801621:	6a 00                	push   $0x0
  801623:	53                   	push   %ebx
  801624:	51                   	push   %ecx
  801625:	52                   	push   %edx
  801626:	50                   	push   %eax
  801627:	6a 2e                	push   $0x2e
  801629:	e8 c8 f9 ff ff       	call   800ff6 <syscall>
  80162e:	83 c4 18             	add    $0x18,%esp
}
  801631:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801634:	c9                   	leave  
  801635:	c3                   	ret    

00801636 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801636:	55                   	push   %ebp
  801637:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801639:	8b 55 0c             	mov    0xc(%ebp),%edx
  80163c:	8b 45 08             	mov    0x8(%ebp),%eax
  80163f:	6a 00                	push   $0x0
  801641:	6a 00                	push   $0x0
  801643:	6a 00                	push   $0x0
  801645:	52                   	push   %edx
  801646:	50                   	push   %eax
  801647:	6a 2f                	push   $0x2f
  801649:	e8 a8 f9 ff ff       	call   800ff6 <syscall>
  80164e:	83 c4 18             	add    $0x18,%esp
}
  801651:	c9                   	leave  
  801652:	c3                   	ret    

00801653 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801653:	55                   	push   %ebp
  801654:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801656:	6a 00                	push   $0x0
  801658:	6a 00                	push   $0x0
  80165a:	6a 00                	push   $0x0
  80165c:	ff 75 0c             	pushl  0xc(%ebp)
  80165f:	ff 75 08             	pushl  0x8(%ebp)
  801662:	6a 30                	push   $0x30
  801664:	e8 8d f9 ff ff       	call   800ff6 <syscall>
  801669:	83 c4 18             	add    $0x18,%esp
	return ;
  80166c:	90                   	nop
}
  80166d:	c9                   	leave  
  80166e:	c3                   	ret    

0080166f <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  80166f:	55                   	push   %ebp
  801670:	89 e5                	mov    %esp,%ebp
  801672:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801675:	8b 55 08             	mov    0x8(%ebp),%edx
  801678:	89 d0                	mov    %edx,%eax
  80167a:	c1 e0 02             	shl    $0x2,%eax
  80167d:	01 d0                	add    %edx,%eax
  80167f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801686:	01 d0                	add    %edx,%eax
  801688:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80168f:	01 d0                	add    %edx,%eax
  801691:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801698:	01 d0                	add    %edx,%eax
  80169a:	c1 e0 04             	shl    $0x4,%eax
  80169d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8016a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8016a7:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8016aa:	83 ec 0c             	sub    $0xc,%esp
  8016ad:	50                   	push   %eax
  8016ae:	e8 5a fd ff ff       	call   80140d <sys_get_virtual_time>
  8016b3:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8016b6:	eb 41                	jmp    8016f9 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8016b8:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8016bb:	83 ec 0c             	sub    $0xc,%esp
  8016be:	50                   	push   %eax
  8016bf:	e8 49 fd ff ff       	call   80140d <sys_get_virtual_time>
  8016c4:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8016c7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8016ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8016cd:	29 c2                	sub    %eax,%edx
  8016cf:	89 d0                	mov    %edx,%eax
  8016d1:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8016d4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8016d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8016da:	89 d1                	mov    %edx,%ecx
  8016dc:	29 c1                	sub    %eax,%ecx
  8016de:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8016e1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8016e4:	39 c2                	cmp    %eax,%edx
  8016e6:	0f 97 c0             	seta   %al
  8016e9:	0f b6 c0             	movzbl %al,%eax
  8016ec:	29 c1                	sub    %eax,%ecx
  8016ee:	89 c8                	mov    %ecx,%eax
  8016f0:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8016f3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8016f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  8016f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016fc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8016ff:	72 b7                	jb     8016b8 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801701:	90                   	nop
  801702:	c9                   	leave  
  801703:	c3                   	ret    

00801704 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801704:	55                   	push   %ebp
  801705:	89 e5                	mov    %esp,%ebp
  801707:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80170a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801711:	eb 03                	jmp    801716 <busy_wait+0x12>
  801713:	ff 45 fc             	incl   -0x4(%ebp)
  801716:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801719:	3b 45 08             	cmp    0x8(%ebp),%eax
  80171c:	72 f5                	jb     801713 <busy_wait+0xf>
	return i;
  80171e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801721:	c9                   	leave  
  801722:	c3                   	ret    
  801723:	90                   	nop

00801724 <__udivdi3>:
  801724:	55                   	push   %ebp
  801725:	57                   	push   %edi
  801726:	56                   	push   %esi
  801727:	53                   	push   %ebx
  801728:	83 ec 1c             	sub    $0x1c,%esp
  80172b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80172f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801733:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801737:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80173b:	89 ca                	mov    %ecx,%edx
  80173d:	89 f8                	mov    %edi,%eax
  80173f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801743:	85 f6                	test   %esi,%esi
  801745:	75 2d                	jne    801774 <__udivdi3+0x50>
  801747:	39 cf                	cmp    %ecx,%edi
  801749:	77 65                	ja     8017b0 <__udivdi3+0x8c>
  80174b:	89 fd                	mov    %edi,%ebp
  80174d:	85 ff                	test   %edi,%edi
  80174f:	75 0b                	jne    80175c <__udivdi3+0x38>
  801751:	b8 01 00 00 00       	mov    $0x1,%eax
  801756:	31 d2                	xor    %edx,%edx
  801758:	f7 f7                	div    %edi
  80175a:	89 c5                	mov    %eax,%ebp
  80175c:	31 d2                	xor    %edx,%edx
  80175e:	89 c8                	mov    %ecx,%eax
  801760:	f7 f5                	div    %ebp
  801762:	89 c1                	mov    %eax,%ecx
  801764:	89 d8                	mov    %ebx,%eax
  801766:	f7 f5                	div    %ebp
  801768:	89 cf                	mov    %ecx,%edi
  80176a:	89 fa                	mov    %edi,%edx
  80176c:	83 c4 1c             	add    $0x1c,%esp
  80176f:	5b                   	pop    %ebx
  801770:	5e                   	pop    %esi
  801771:	5f                   	pop    %edi
  801772:	5d                   	pop    %ebp
  801773:	c3                   	ret    
  801774:	39 ce                	cmp    %ecx,%esi
  801776:	77 28                	ja     8017a0 <__udivdi3+0x7c>
  801778:	0f bd fe             	bsr    %esi,%edi
  80177b:	83 f7 1f             	xor    $0x1f,%edi
  80177e:	75 40                	jne    8017c0 <__udivdi3+0x9c>
  801780:	39 ce                	cmp    %ecx,%esi
  801782:	72 0a                	jb     80178e <__udivdi3+0x6a>
  801784:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801788:	0f 87 9e 00 00 00    	ja     80182c <__udivdi3+0x108>
  80178e:	b8 01 00 00 00       	mov    $0x1,%eax
  801793:	89 fa                	mov    %edi,%edx
  801795:	83 c4 1c             	add    $0x1c,%esp
  801798:	5b                   	pop    %ebx
  801799:	5e                   	pop    %esi
  80179a:	5f                   	pop    %edi
  80179b:	5d                   	pop    %ebp
  80179c:	c3                   	ret    
  80179d:	8d 76 00             	lea    0x0(%esi),%esi
  8017a0:	31 ff                	xor    %edi,%edi
  8017a2:	31 c0                	xor    %eax,%eax
  8017a4:	89 fa                	mov    %edi,%edx
  8017a6:	83 c4 1c             	add    $0x1c,%esp
  8017a9:	5b                   	pop    %ebx
  8017aa:	5e                   	pop    %esi
  8017ab:	5f                   	pop    %edi
  8017ac:	5d                   	pop    %ebp
  8017ad:	c3                   	ret    
  8017ae:	66 90                	xchg   %ax,%ax
  8017b0:	89 d8                	mov    %ebx,%eax
  8017b2:	f7 f7                	div    %edi
  8017b4:	31 ff                	xor    %edi,%edi
  8017b6:	89 fa                	mov    %edi,%edx
  8017b8:	83 c4 1c             	add    $0x1c,%esp
  8017bb:	5b                   	pop    %ebx
  8017bc:	5e                   	pop    %esi
  8017bd:	5f                   	pop    %edi
  8017be:	5d                   	pop    %ebp
  8017bf:	c3                   	ret    
  8017c0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8017c5:	89 eb                	mov    %ebp,%ebx
  8017c7:	29 fb                	sub    %edi,%ebx
  8017c9:	89 f9                	mov    %edi,%ecx
  8017cb:	d3 e6                	shl    %cl,%esi
  8017cd:	89 c5                	mov    %eax,%ebp
  8017cf:	88 d9                	mov    %bl,%cl
  8017d1:	d3 ed                	shr    %cl,%ebp
  8017d3:	89 e9                	mov    %ebp,%ecx
  8017d5:	09 f1                	or     %esi,%ecx
  8017d7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8017db:	89 f9                	mov    %edi,%ecx
  8017dd:	d3 e0                	shl    %cl,%eax
  8017df:	89 c5                	mov    %eax,%ebp
  8017e1:	89 d6                	mov    %edx,%esi
  8017e3:	88 d9                	mov    %bl,%cl
  8017e5:	d3 ee                	shr    %cl,%esi
  8017e7:	89 f9                	mov    %edi,%ecx
  8017e9:	d3 e2                	shl    %cl,%edx
  8017eb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017ef:	88 d9                	mov    %bl,%cl
  8017f1:	d3 e8                	shr    %cl,%eax
  8017f3:	09 c2                	or     %eax,%edx
  8017f5:	89 d0                	mov    %edx,%eax
  8017f7:	89 f2                	mov    %esi,%edx
  8017f9:	f7 74 24 0c          	divl   0xc(%esp)
  8017fd:	89 d6                	mov    %edx,%esi
  8017ff:	89 c3                	mov    %eax,%ebx
  801801:	f7 e5                	mul    %ebp
  801803:	39 d6                	cmp    %edx,%esi
  801805:	72 19                	jb     801820 <__udivdi3+0xfc>
  801807:	74 0b                	je     801814 <__udivdi3+0xf0>
  801809:	89 d8                	mov    %ebx,%eax
  80180b:	31 ff                	xor    %edi,%edi
  80180d:	e9 58 ff ff ff       	jmp    80176a <__udivdi3+0x46>
  801812:	66 90                	xchg   %ax,%ax
  801814:	8b 54 24 08          	mov    0x8(%esp),%edx
  801818:	89 f9                	mov    %edi,%ecx
  80181a:	d3 e2                	shl    %cl,%edx
  80181c:	39 c2                	cmp    %eax,%edx
  80181e:	73 e9                	jae    801809 <__udivdi3+0xe5>
  801820:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801823:	31 ff                	xor    %edi,%edi
  801825:	e9 40 ff ff ff       	jmp    80176a <__udivdi3+0x46>
  80182a:	66 90                	xchg   %ax,%ax
  80182c:	31 c0                	xor    %eax,%eax
  80182e:	e9 37 ff ff ff       	jmp    80176a <__udivdi3+0x46>
  801833:	90                   	nop

00801834 <__umoddi3>:
  801834:	55                   	push   %ebp
  801835:	57                   	push   %edi
  801836:	56                   	push   %esi
  801837:	53                   	push   %ebx
  801838:	83 ec 1c             	sub    $0x1c,%esp
  80183b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80183f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801843:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801847:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80184b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80184f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801853:	89 f3                	mov    %esi,%ebx
  801855:	89 fa                	mov    %edi,%edx
  801857:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80185b:	89 34 24             	mov    %esi,(%esp)
  80185e:	85 c0                	test   %eax,%eax
  801860:	75 1a                	jne    80187c <__umoddi3+0x48>
  801862:	39 f7                	cmp    %esi,%edi
  801864:	0f 86 a2 00 00 00    	jbe    80190c <__umoddi3+0xd8>
  80186a:	89 c8                	mov    %ecx,%eax
  80186c:	89 f2                	mov    %esi,%edx
  80186e:	f7 f7                	div    %edi
  801870:	89 d0                	mov    %edx,%eax
  801872:	31 d2                	xor    %edx,%edx
  801874:	83 c4 1c             	add    $0x1c,%esp
  801877:	5b                   	pop    %ebx
  801878:	5e                   	pop    %esi
  801879:	5f                   	pop    %edi
  80187a:	5d                   	pop    %ebp
  80187b:	c3                   	ret    
  80187c:	39 f0                	cmp    %esi,%eax
  80187e:	0f 87 ac 00 00 00    	ja     801930 <__umoddi3+0xfc>
  801884:	0f bd e8             	bsr    %eax,%ebp
  801887:	83 f5 1f             	xor    $0x1f,%ebp
  80188a:	0f 84 ac 00 00 00    	je     80193c <__umoddi3+0x108>
  801890:	bf 20 00 00 00       	mov    $0x20,%edi
  801895:	29 ef                	sub    %ebp,%edi
  801897:	89 fe                	mov    %edi,%esi
  801899:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80189d:	89 e9                	mov    %ebp,%ecx
  80189f:	d3 e0                	shl    %cl,%eax
  8018a1:	89 d7                	mov    %edx,%edi
  8018a3:	89 f1                	mov    %esi,%ecx
  8018a5:	d3 ef                	shr    %cl,%edi
  8018a7:	09 c7                	or     %eax,%edi
  8018a9:	89 e9                	mov    %ebp,%ecx
  8018ab:	d3 e2                	shl    %cl,%edx
  8018ad:	89 14 24             	mov    %edx,(%esp)
  8018b0:	89 d8                	mov    %ebx,%eax
  8018b2:	d3 e0                	shl    %cl,%eax
  8018b4:	89 c2                	mov    %eax,%edx
  8018b6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8018ba:	d3 e0                	shl    %cl,%eax
  8018bc:	89 44 24 04          	mov    %eax,0x4(%esp)
  8018c0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8018c4:	89 f1                	mov    %esi,%ecx
  8018c6:	d3 e8                	shr    %cl,%eax
  8018c8:	09 d0                	or     %edx,%eax
  8018ca:	d3 eb                	shr    %cl,%ebx
  8018cc:	89 da                	mov    %ebx,%edx
  8018ce:	f7 f7                	div    %edi
  8018d0:	89 d3                	mov    %edx,%ebx
  8018d2:	f7 24 24             	mull   (%esp)
  8018d5:	89 c6                	mov    %eax,%esi
  8018d7:	89 d1                	mov    %edx,%ecx
  8018d9:	39 d3                	cmp    %edx,%ebx
  8018db:	0f 82 87 00 00 00    	jb     801968 <__umoddi3+0x134>
  8018e1:	0f 84 91 00 00 00    	je     801978 <__umoddi3+0x144>
  8018e7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8018eb:	29 f2                	sub    %esi,%edx
  8018ed:	19 cb                	sbb    %ecx,%ebx
  8018ef:	89 d8                	mov    %ebx,%eax
  8018f1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8018f5:	d3 e0                	shl    %cl,%eax
  8018f7:	89 e9                	mov    %ebp,%ecx
  8018f9:	d3 ea                	shr    %cl,%edx
  8018fb:	09 d0                	or     %edx,%eax
  8018fd:	89 e9                	mov    %ebp,%ecx
  8018ff:	d3 eb                	shr    %cl,%ebx
  801901:	89 da                	mov    %ebx,%edx
  801903:	83 c4 1c             	add    $0x1c,%esp
  801906:	5b                   	pop    %ebx
  801907:	5e                   	pop    %esi
  801908:	5f                   	pop    %edi
  801909:	5d                   	pop    %ebp
  80190a:	c3                   	ret    
  80190b:	90                   	nop
  80190c:	89 fd                	mov    %edi,%ebp
  80190e:	85 ff                	test   %edi,%edi
  801910:	75 0b                	jne    80191d <__umoddi3+0xe9>
  801912:	b8 01 00 00 00       	mov    $0x1,%eax
  801917:	31 d2                	xor    %edx,%edx
  801919:	f7 f7                	div    %edi
  80191b:	89 c5                	mov    %eax,%ebp
  80191d:	89 f0                	mov    %esi,%eax
  80191f:	31 d2                	xor    %edx,%edx
  801921:	f7 f5                	div    %ebp
  801923:	89 c8                	mov    %ecx,%eax
  801925:	f7 f5                	div    %ebp
  801927:	89 d0                	mov    %edx,%eax
  801929:	e9 44 ff ff ff       	jmp    801872 <__umoddi3+0x3e>
  80192e:	66 90                	xchg   %ax,%ax
  801930:	89 c8                	mov    %ecx,%eax
  801932:	89 f2                	mov    %esi,%edx
  801934:	83 c4 1c             	add    $0x1c,%esp
  801937:	5b                   	pop    %ebx
  801938:	5e                   	pop    %esi
  801939:	5f                   	pop    %edi
  80193a:	5d                   	pop    %ebp
  80193b:	c3                   	ret    
  80193c:	3b 04 24             	cmp    (%esp),%eax
  80193f:	72 06                	jb     801947 <__umoddi3+0x113>
  801941:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801945:	77 0f                	ja     801956 <__umoddi3+0x122>
  801947:	89 f2                	mov    %esi,%edx
  801949:	29 f9                	sub    %edi,%ecx
  80194b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80194f:	89 14 24             	mov    %edx,(%esp)
  801952:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801956:	8b 44 24 04          	mov    0x4(%esp),%eax
  80195a:	8b 14 24             	mov    (%esp),%edx
  80195d:	83 c4 1c             	add    $0x1c,%esp
  801960:	5b                   	pop    %ebx
  801961:	5e                   	pop    %esi
  801962:	5f                   	pop    %edi
  801963:	5d                   	pop    %ebp
  801964:	c3                   	ret    
  801965:	8d 76 00             	lea    0x0(%esi),%esi
  801968:	2b 04 24             	sub    (%esp),%eax
  80196b:	19 fa                	sbb    %edi,%edx
  80196d:	89 d1                	mov    %edx,%ecx
  80196f:	89 c6                	mov    %eax,%esi
  801971:	e9 71 ff ff ff       	jmp    8018e7 <__umoddi3+0xb3>
  801976:	66 90                	xchg   %ax,%ax
  801978:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80197c:	72 ea                	jb     801968 <__umoddi3+0x134>
  80197e:	89 d9                	mov    %ebx,%ecx
  801980:	e9 62 ff ff ff       	jmp    8018e7 <__umoddi3+0xb3>
