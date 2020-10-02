
obj/user/fos_fibonacci:     file format elf32-i386


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
  800031:	e8 ab 00 00 00       	call   8000e1 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int fibonacci(int n);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	char buff1[256];
	atomic_readline("Please enter Fibonacci index:", buff1);
  800048:	83 ec 08             	sub    $0x8,%esp
  80004b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800051:	50                   	push   %eax
  800052:	68 00 1c 80 00       	push   $0x801c00
  800057:	e8 fe 09 00 00       	call   800a5a <atomic_readline>
  80005c:	83 c4 10             	add    $0x10,%esp
	i1 = strtol(buff1, NULL, 10);
  80005f:	83 ec 04             	sub    $0x4,%esp
  800062:	6a 0a                	push   $0xa
  800064:	6a 00                	push   $0x0
  800066:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80006c:	50                   	push   %eax
  80006d:	e8 50 0e 00 00       	call   800ec2 <strtol>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 f4             	mov    %eax,-0xc(%ebp)

	int res = fibonacci(i1) ;
  800078:	83 ec 0c             	sub    $0xc,%esp
  80007b:	ff 75 f4             	pushl  -0xc(%ebp)
  80007e:	e8 1f 00 00 00       	call   8000a2 <fibonacci>
  800083:	83 c4 10             	add    $0x10,%esp
  800086:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("Fibonacci #%d = %d\n",i1, res);
  800089:	83 ec 04             	sub    $0x4,%esp
  80008c:	ff 75 f0             	pushl  -0x10(%ebp)
  80008f:	ff 75 f4             	pushl  -0xc(%ebp)
  800092:	68 1e 1c 80 00       	push   $0x801c1e
  800097:	e8 6b 02 00 00       	call   800307 <atomic_cprintf>
  80009c:	83 c4 10             	add    $0x10,%esp
	return;
  80009f:	90                   	nop
}
  8000a0:	c9                   	leave  
  8000a1:	c3                   	ret    

008000a2 <fibonacci>:


int fibonacci(int n)
{
  8000a2:	55                   	push   %ebp
  8000a3:	89 e5                	mov    %esp,%ebp
  8000a5:	53                   	push   %ebx
  8000a6:	83 ec 04             	sub    $0x4,%esp
	if (n <= 1)
  8000a9:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  8000ad:	7f 07                	jg     8000b6 <fibonacci+0x14>
		return 1 ;
  8000af:	b8 01 00 00 00       	mov    $0x1,%eax
  8000b4:	eb 26                	jmp    8000dc <fibonacci+0x3a>
	return fibonacci(n-1) + fibonacci(n-2) ;
  8000b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8000b9:	48                   	dec    %eax
  8000ba:	83 ec 0c             	sub    $0xc,%esp
  8000bd:	50                   	push   %eax
  8000be:	e8 df ff ff ff       	call   8000a2 <fibonacci>
  8000c3:	83 c4 10             	add    $0x10,%esp
  8000c6:	89 c3                	mov    %eax,%ebx
  8000c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8000cb:	83 e8 02             	sub    $0x2,%eax
  8000ce:	83 ec 0c             	sub    $0xc,%esp
  8000d1:	50                   	push   %eax
  8000d2:	e8 cb ff ff ff       	call   8000a2 <fibonacci>
  8000d7:	83 c4 10             	add    $0x10,%esp
  8000da:	01 d8                	add    %ebx,%eax
}
  8000dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8000df:	c9                   	leave  
  8000e0:	c3                   	ret    

008000e1 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000e1:	55                   	push   %ebp
  8000e2:	89 e5                	mov    %esp,%ebp
  8000e4:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000e7:	e8 1f 12 00 00       	call   80130b <sys_getenvindex>
  8000ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000ef:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000f2:	89 d0                	mov    %edx,%eax
  8000f4:	c1 e0 03             	shl    $0x3,%eax
  8000f7:	01 d0                	add    %edx,%eax
  8000f9:	c1 e0 02             	shl    $0x2,%eax
  8000fc:	01 d0                	add    %edx,%eax
  8000fe:	c1 e0 06             	shl    $0x6,%eax
  800101:	29 d0                	sub    %edx,%eax
  800103:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80010a:	01 c8                	add    %ecx,%eax
  80010c:	01 d0                	add    %edx,%eax
  80010e:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800113:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800118:	a1 20 30 80 00       	mov    0x803020,%eax
  80011d:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  800123:	84 c0                	test   %al,%al
  800125:	74 0f                	je     800136 <libmain+0x55>
		binaryname = myEnv->prog_name;
  800127:	a1 20 30 80 00       	mov    0x803020,%eax
  80012c:	05 b0 52 00 00       	add    $0x52b0,%eax
  800131:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800136:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80013a:	7e 0a                	jle    800146 <libmain+0x65>
		binaryname = argv[0];
  80013c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80013f:	8b 00                	mov    (%eax),%eax
  800141:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800146:	83 ec 08             	sub    $0x8,%esp
  800149:	ff 75 0c             	pushl  0xc(%ebp)
  80014c:	ff 75 08             	pushl  0x8(%ebp)
  80014f:	e8 e4 fe ff ff       	call   800038 <_main>
  800154:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800157:	e8 4a 13 00 00       	call   8014a6 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80015c:	83 ec 0c             	sub    $0xc,%esp
  80015f:	68 4c 1c 80 00       	push   $0x801c4c
  800164:	e8 71 01 00 00       	call   8002da <cprintf>
  800169:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80016c:	a1 20 30 80 00       	mov    0x803020,%eax
  800171:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  800177:	a1 20 30 80 00       	mov    0x803020,%eax
  80017c:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  800182:	83 ec 04             	sub    $0x4,%esp
  800185:	52                   	push   %edx
  800186:	50                   	push   %eax
  800187:	68 74 1c 80 00       	push   $0x801c74
  80018c:	e8 49 01 00 00       	call   8002da <cprintf>
  800191:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800194:	a1 20 30 80 00       	mov    0x803020,%eax
  800199:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  80019f:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a4:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  8001aa:	a1 20 30 80 00       	mov    0x803020,%eax
  8001af:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  8001b5:	51                   	push   %ecx
  8001b6:	52                   	push   %edx
  8001b7:	50                   	push   %eax
  8001b8:	68 9c 1c 80 00       	push   $0x801c9c
  8001bd:	e8 18 01 00 00       	call   8002da <cprintf>
  8001c2:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8001c5:	83 ec 0c             	sub    $0xc,%esp
  8001c8:	68 4c 1c 80 00       	push   $0x801c4c
  8001cd:	e8 08 01 00 00       	call   8002da <cprintf>
  8001d2:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001d5:	e8 e6 12 00 00       	call   8014c0 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001da:	e8 19 00 00 00       	call   8001f8 <exit>
}
  8001df:	90                   	nop
  8001e0:	c9                   	leave  
  8001e1:	c3                   	ret    

008001e2 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001e2:	55                   	push   %ebp
  8001e3:	89 e5                	mov    %esp,%ebp
  8001e5:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001e8:	83 ec 0c             	sub    $0xc,%esp
  8001eb:	6a 00                	push   $0x0
  8001ed:	e8 e5 10 00 00       	call   8012d7 <sys_env_destroy>
  8001f2:	83 c4 10             	add    $0x10,%esp
}
  8001f5:	90                   	nop
  8001f6:	c9                   	leave  
  8001f7:	c3                   	ret    

008001f8 <exit>:

void
exit(void)
{
  8001f8:	55                   	push   %ebp
  8001f9:	89 e5                	mov    %esp,%ebp
  8001fb:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001fe:	e8 3a 11 00 00       	call   80133d <sys_env_exit>
}
  800203:	90                   	nop
  800204:	c9                   	leave  
  800205:	c3                   	ret    

00800206 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800206:	55                   	push   %ebp
  800207:	89 e5                	mov    %esp,%ebp
  800209:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80020c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020f:	8b 00                	mov    (%eax),%eax
  800211:	8d 48 01             	lea    0x1(%eax),%ecx
  800214:	8b 55 0c             	mov    0xc(%ebp),%edx
  800217:	89 0a                	mov    %ecx,(%edx)
  800219:	8b 55 08             	mov    0x8(%ebp),%edx
  80021c:	88 d1                	mov    %dl,%cl
  80021e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800221:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800225:	8b 45 0c             	mov    0xc(%ebp),%eax
  800228:	8b 00                	mov    (%eax),%eax
  80022a:	3d ff 00 00 00       	cmp    $0xff,%eax
  80022f:	75 2c                	jne    80025d <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800231:	a0 24 30 80 00       	mov    0x803024,%al
  800236:	0f b6 c0             	movzbl %al,%eax
  800239:	8b 55 0c             	mov    0xc(%ebp),%edx
  80023c:	8b 12                	mov    (%edx),%edx
  80023e:	89 d1                	mov    %edx,%ecx
  800240:	8b 55 0c             	mov    0xc(%ebp),%edx
  800243:	83 c2 08             	add    $0x8,%edx
  800246:	83 ec 04             	sub    $0x4,%esp
  800249:	50                   	push   %eax
  80024a:	51                   	push   %ecx
  80024b:	52                   	push   %edx
  80024c:	e8 44 10 00 00       	call   801295 <sys_cputs>
  800251:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800254:	8b 45 0c             	mov    0xc(%ebp),%eax
  800257:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80025d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800260:	8b 40 04             	mov    0x4(%eax),%eax
  800263:	8d 50 01             	lea    0x1(%eax),%edx
  800266:	8b 45 0c             	mov    0xc(%ebp),%eax
  800269:	89 50 04             	mov    %edx,0x4(%eax)
}
  80026c:	90                   	nop
  80026d:	c9                   	leave  
  80026e:	c3                   	ret    

0080026f <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80026f:	55                   	push   %ebp
  800270:	89 e5                	mov    %esp,%ebp
  800272:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800278:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80027f:	00 00 00 
	b.cnt = 0;
  800282:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800289:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80028c:	ff 75 0c             	pushl  0xc(%ebp)
  80028f:	ff 75 08             	pushl  0x8(%ebp)
  800292:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800298:	50                   	push   %eax
  800299:	68 06 02 80 00       	push   $0x800206
  80029e:	e8 11 02 00 00       	call   8004b4 <vprintfmt>
  8002a3:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002a6:	a0 24 30 80 00       	mov    0x803024,%al
  8002ab:	0f b6 c0             	movzbl %al,%eax
  8002ae:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002b4:	83 ec 04             	sub    $0x4,%esp
  8002b7:	50                   	push   %eax
  8002b8:	52                   	push   %edx
  8002b9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002bf:	83 c0 08             	add    $0x8,%eax
  8002c2:	50                   	push   %eax
  8002c3:	e8 cd 0f 00 00       	call   801295 <sys_cputs>
  8002c8:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002cb:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8002d2:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002d8:	c9                   	leave  
  8002d9:	c3                   	ret    

008002da <cprintf>:

int cprintf(const char *fmt, ...) {
  8002da:	55                   	push   %ebp
  8002db:	89 e5                	mov    %esp,%ebp
  8002dd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002e0:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8002e7:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f0:	83 ec 08             	sub    $0x8,%esp
  8002f3:	ff 75 f4             	pushl  -0xc(%ebp)
  8002f6:	50                   	push   %eax
  8002f7:	e8 73 ff ff ff       	call   80026f <vcprintf>
  8002fc:	83 c4 10             	add    $0x10,%esp
  8002ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800302:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800305:	c9                   	leave  
  800306:	c3                   	ret    

00800307 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800307:	55                   	push   %ebp
  800308:	89 e5                	mov    %esp,%ebp
  80030a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80030d:	e8 94 11 00 00       	call   8014a6 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800312:	8d 45 0c             	lea    0xc(%ebp),%eax
  800315:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800318:	8b 45 08             	mov    0x8(%ebp),%eax
  80031b:	83 ec 08             	sub    $0x8,%esp
  80031e:	ff 75 f4             	pushl  -0xc(%ebp)
  800321:	50                   	push   %eax
  800322:	e8 48 ff ff ff       	call   80026f <vcprintf>
  800327:	83 c4 10             	add    $0x10,%esp
  80032a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80032d:	e8 8e 11 00 00       	call   8014c0 <sys_enable_interrupt>
	return cnt;
  800332:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800335:	c9                   	leave  
  800336:	c3                   	ret    

00800337 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800337:	55                   	push   %ebp
  800338:	89 e5                	mov    %esp,%ebp
  80033a:	53                   	push   %ebx
  80033b:	83 ec 14             	sub    $0x14,%esp
  80033e:	8b 45 10             	mov    0x10(%ebp),%eax
  800341:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800344:	8b 45 14             	mov    0x14(%ebp),%eax
  800347:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80034a:	8b 45 18             	mov    0x18(%ebp),%eax
  80034d:	ba 00 00 00 00       	mov    $0x0,%edx
  800352:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800355:	77 55                	ja     8003ac <printnum+0x75>
  800357:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80035a:	72 05                	jb     800361 <printnum+0x2a>
  80035c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80035f:	77 4b                	ja     8003ac <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800361:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800364:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800367:	8b 45 18             	mov    0x18(%ebp),%eax
  80036a:	ba 00 00 00 00       	mov    $0x0,%edx
  80036f:	52                   	push   %edx
  800370:	50                   	push   %eax
  800371:	ff 75 f4             	pushl  -0xc(%ebp)
  800374:	ff 75 f0             	pushl  -0x10(%ebp)
  800377:	e8 08 16 00 00       	call   801984 <__udivdi3>
  80037c:	83 c4 10             	add    $0x10,%esp
  80037f:	83 ec 04             	sub    $0x4,%esp
  800382:	ff 75 20             	pushl  0x20(%ebp)
  800385:	53                   	push   %ebx
  800386:	ff 75 18             	pushl  0x18(%ebp)
  800389:	52                   	push   %edx
  80038a:	50                   	push   %eax
  80038b:	ff 75 0c             	pushl  0xc(%ebp)
  80038e:	ff 75 08             	pushl  0x8(%ebp)
  800391:	e8 a1 ff ff ff       	call   800337 <printnum>
  800396:	83 c4 20             	add    $0x20,%esp
  800399:	eb 1a                	jmp    8003b5 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80039b:	83 ec 08             	sub    $0x8,%esp
  80039e:	ff 75 0c             	pushl  0xc(%ebp)
  8003a1:	ff 75 20             	pushl  0x20(%ebp)
  8003a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a7:	ff d0                	call   *%eax
  8003a9:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003ac:	ff 4d 1c             	decl   0x1c(%ebp)
  8003af:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003b3:	7f e6                	jg     80039b <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003b5:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003b8:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003c3:	53                   	push   %ebx
  8003c4:	51                   	push   %ecx
  8003c5:	52                   	push   %edx
  8003c6:	50                   	push   %eax
  8003c7:	e8 c8 16 00 00       	call   801a94 <__umoddi3>
  8003cc:	83 c4 10             	add    $0x10,%esp
  8003cf:	05 14 1f 80 00       	add    $0x801f14,%eax
  8003d4:	8a 00                	mov    (%eax),%al
  8003d6:	0f be c0             	movsbl %al,%eax
  8003d9:	83 ec 08             	sub    $0x8,%esp
  8003dc:	ff 75 0c             	pushl  0xc(%ebp)
  8003df:	50                   	push   %eax
  8003e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e3:	ff d0                	call   *%eax
  8003e5:	83 c4 10             	add    $0x10,%esp
}
  8003e8:	90                   	nop
  8003e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003ec:	c9                   	leave  
  8003ed:	c3                   	ret    

008003ee <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003ee:	55                   	push   %ebp
  8003ef:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003f1:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003f5:	7e 1c                	jle    800413 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fa:	8b 00                	mov    (%eax),%eax
  8003fc:	8d 50 08             	lea    0x8(%eax),%edx
  8003ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800402:	89 10                	mov    %edx,(%eax)
  800404:	8b 45 08             	mov    0x8(%ebp),%eax
  800407:	8b 00                	mov    (%eax),%eax
  800409:	83 e8 08             	sub    $0x8,%eax
  80040c:	8b 50 04             	mov    0x4(%eax),%edx
  80040f:	8b 00                	mov    (%eax),%eax
  800411:	eb 40                	jmp    800453 <getuint+0x65>
	else if (lflag)
  800413:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800417:	74 1e                	je     800437 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800419:	8b 45 08             	mov    0x8(%ebp),%eax
  80041c:	8b 00                	mov    (%eax),%eax
  80041e:	8d 50 04             	lea    0x4(%eax),%edx
  800421:	8b 45 08             	mov    0x8(%ebp),%eax
  800424:	89 10                	mov    %edx,(%eax)
  800426:	8b 45 08             	mov    0x8(%ebp),%eax
  800429:	8b 00                	mov    (%eax),%eax
  80042b:	83 e8 04             	sub    $0x4,%eax
  80042e:	8b 00                	mov    (%eax),%eax
  800430:	ba 00 00 00 00       	mov    $0x0,%edx
  800435:	eb 1c                	jmp    800453 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800437:	8b 45 08             	mov    0x8(%ebp),%eax
  80043a:	8b 00                	mov    (%eax),%eax
  80043c:	8d 50 04             	lea    0x4(%eax),%edx
  80043f:	8b 45 08             	mov    0x8(%ebp),%eax
  800442:	89 10                	mov    %edx,(%eax)
  800444:	8b 45 08             	mov    0x8(%ebp),%eax
  800447:	8b 00                	mov    (%eax),%eax
  800449:	83 e8 04             	sub    $0x4,%eax
  80044c:	8b 00                	mov    (%eax),%eax
  80044e:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800453:	5d                   	pop    %ebp
  800454:	c3                   	ret    

00800455 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800455:	55                   	push   %ebp
  800456:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800458:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80045c:	7e 1c                	jle    80047a <getint+0x25>
		return va_arg(*ap, long long);
  80045e:	8b 45 08             	mov    0x8(%ebp),%eax
  800461:	8b 00                	mov    (%eax),%eax
  800463:	8d 50 08             	lea    0x8(%eax),%edx
  800466:	8b 45 08             	mov    0x8(%ebp),%eax
  800469:	89 10                	mov    %edx,(%eax)
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	8b 00                	mov    (%eax),%eax
  800470:	83 e8 08             	sub    $0x8,%eax
  800473:	8b 50 04             	mov    0x4(%eax),%edx
  800476:	8b 00                	mov    (%eax),%eax
  800478:	eb 38                	jmp    8004b2 <getint+0x5d>
	else if (lflag)
  80047a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80047e:	74 1a                	je     80049a <getint+0x45>
		return va_arg(*ap, long);
  800480:	8b 45 08             	mov    0x8(%ebp),%eax
  800483:	8b 00                	mov    (%eax),%eax
  800485:	8d 50 04             	lea    0x4(%eax),%edx
  800488:	8b 45 08             	mov    0x8(%ebp),%eax
  80048b:	89 10                	mov    %edx,(%eax)
  80048d:	8b 45 08             	mov    0x8(%ebp),%eax
  800490:	8b 00                	mov    (%eax),%eax
  800492:	83 e8 04             	sub    $0x4,%eax
  800495:	8b 00                	mov    (%eax),%eax
  800497:	99                   	cltd   
  800498:	eb 18                	jmp    8004b2 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80049a:	8b 45 08             	mov    0x8(%ebp),%eax
  80049d:	8b 00                	mov    (%eax),%eax
  80049f:	8d 50 04             	lea    0x4(%eax),%edx
  8004a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a5:	89 10                	mov    %edx,(%eax)
  8004a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004aa:	8b 00                	mov    (%eax),%eax
  8004ac:	83 e8 04             	sub    $0x4,%eax
  8004af:	8b 00                	mov    (%eax),%eax
  8004b1:	99                   	cltd   
}
  8004b2:	5d                   	pop    %ebp
  8004b3:	c3                   	ret    

008004b4 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004b4:	55                   	push   %ebp
  8004b5:	89 e5                	mov    %esp,%ebp
  8004b7:	56                   	push   %esi
  8004b8:	53                   	push   %ebx
  8004b9:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004bc:	eb 17                	jmp    8004d5 <vprintfmt+0x21>
			if (ch == '\0')
  8004be:	85 db                	test   %ebx,%ebx
  8004c0:	0f 84 af 03 00 00    	je     800875 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004c6:	83 ec 08             	sub    $0x8,%esp
  8004c9:	ff 75 0c             	pushl  0xc(%ebp)
  8004cc:	53                   	push   %ebx
  8004cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d0:	ff d0                	call   *%eax
  8004d2:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8004d8:	8d 50 01             	lea    0x1(%eax),%edx
  8004db:	89 55 10             	mov    %edx,0x10(%ebp)
  8004de:	8a 00                	mov    (%eax),%al
  8004e0:	0f b6 d8             	movzbl %al,%ebx
  8004e3:	83 fb 25             	cmp    $0x25,%ebx
  8004e6:	75 d6                	jne    8004be <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004e8:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004ec:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004f3:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004fa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800501:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800508:	8b 45 10             	mov    0x10(%ebp),%eax
  80050b:	8d 50 01             	lea    0x1(%eax),%edx
  80050e:	89 55 10             	mov    %edx,0x10(%ebp)
  800511:	8a 00                	mov    (%eax),%al
  800513:	0f b6 d8             	movzbl %al,%ebx
  800516:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800519:	83 f8 55             	cmp    $0x55,%eax
  80051c:	0f 87 2b 03 00 00    	ja     80084d <vprintfmt+0x399>
  800522:	8b 04 85 38 1f 80 00 	mov    0x801f38(,%eax,4),%eax
  800529:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80052b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80052f:	eb d7                	jmp    800508 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800531:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800535:	eb d1                	jmp    800508 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800537:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80053e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800541:	89 d0                	mov    %edx,%eax
  800543:	c1 e0 02             	shl    $0x2,%eax
  800546:	01 d0                	add    %edx,%eax
  800548:	01 c0                	add    %eax,%eax
  80054a:	01 d8                	add    %ebx,%eax
  80054c:	83 e8 30             	sub    $0x30,%eax
  80054f:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800552:	8b 45 10             	mov    0x10(%ebp),%eax
  800555:	8a 00                	mov    (%eax),%al
  800557:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80055a:	83 fb 2f             	cmp    $0x2f,%ebx
  80055d:	7e 3e                	jle    80059d <vprintfmt+0xe9>
  80055f:	83 fb 39             	cmp    $0x39,%ebx
  800562:	7f 39                	jg     80059d <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800564:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800567:	eb d5                	jmp    80053e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800569:	8b 45 14             	mov    0x14(%ebp),%eax
  80056c:	83 c0 04             	add    $0x4,%eax
  80056f:	89 45 14             	mov    %eax,0x14(%ebp)
  800572:	8b 45 14             	mov    0x14(%ebp),%eax
  800575:	83 e8 04             	sub    $0x4,%eax
  800578:	8b 00                	mov    (%eax),%eax
  80057a:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80057d:	eb 1f                	jmp    80059e <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80057f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800583:	79 83                	jns    800508 <vprintfmt+0x54>
				width = 0;
  800585:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80058c:	e9 77 ff ff ff       	jmp    800508 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800591:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800598:	e9 6b ff ff ff       	jmp    800508 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80059d:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80059e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005a2:	0f 89 60 ff ff ff    	jns    800508 <vprintfmt+0x54>
				width = precision, precision = -1;
  8005a8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005ab:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005ae:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005b5:	e9 4e ff ff ff       	jmp    800508 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005ba:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005bd:	e9 46 ff ff ff       	jmp    800508 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c5:	83 c0 04             	add    $0x4,%eax
  8005c8:	89 45 14             	mov    %eax,0x14(%ebp)
  8005cb:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ce:	83 e8 04             	sub    $0x4,%eax
  8005d1:	8b 00                	mov    (%eax),%eax
  8005d3:	83 ec 08             	sub    $0x8,%esp
  8005d6:	ff 75 0c             	pushl  0xc(%ebp)
  8005d9:	50                   	push   %eax
  8005da:	8b 45 08             	mov    0x8(%ebp),%eax
  8005dd:	ff d0                	call   *%eax
  8005df:	83 c4 10             	add    $0x10,%esp
			break;
  8005e2:	e9 89 02 00 00       	jmp    800870 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ea:	83 c0 04             	add    $0x4,%eax
  8005ed:	89 45 14             	mov    %eax,0x14(%ebp)
  8005f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8005f3:	83 e8 04             	sub    $0x4,%eax
  8005f6:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005f8:	85 db                	test   %ebx,%ebx
  8005fa:	79 02                	jns    8005fe <vprintfmt+0x14a>
				err = -err;
  8005fc:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005fe:	83 fb 64             	cmp    $0x64,%ebx
  800601:	7f 0b                	jg     80060e <vprintfmt+0x15a>
  800603:	8b 34 9d 80 1d 80 00 	mov    0x801d80(,%ebx,4),%esi
  80060a:	85 f6                	test   %esi,%esi
  80060c:	75 19                	jne    800627 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80060e:	53                   	push   %ebx
  80060f:	68 25 1f 80 00       	push   $0x801f25
  800614:	ff 75 0c             	pushl  0xc(%ebp)
  800617:	ff 75 08             	pushl  0x8(%ebp)
  80061a:	e8 5e 02 00 00       	call   80087d <printfmt>
  80061f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800622:	e9 49 02 00 00       	jmp    800870 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800627:	56                   	push   %esi
  800628:	68 2e 1f 80 00       	push   $0x801f2e
  80062d:	ff 75 0c             	pushl  0xc(%ebp)
  800630:	ff 75 08             	pushl  0x8(%ebp)
  800633:	e8 45 02 00 00       	call   80087d <printfmt>
  800638:	83 c4 10             	add    $0x10,%esp
			break;
  80063b:	e9 30 02 00 00       	jmp    800870 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800640:	8b 45 14             	mov    0x14(%ebp),%eax
  800643:	83 c0 04             	add    $0x4,%eax
  800646:	89 45 14             	mov    %eax,0x14(%ebp)
  800649:	8b 45 14             	mov    0x14(%ebp),%eax
  80064c:	83 e8 04             	sub    $0x4,%eax
  80064f:	8b 30                	mov    (%eax),%esi
  800651:	85 f6                	test   %esi,%esi
  800653:	75 05                	jne    80065a <vprintfmt+0x1a6>
				p = "(null)";
  800655:	be 31 1f 80 00       	mov    $0x801f31,%esi
			if (width > 0 && padc != '-')
  80065a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80065e:	7e 6d                	jle    8006cd <vprintfmt+0x219>
  800660:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800664:	74 67                	je     8006cd <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800666:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800669:	83 ec 08             	sub    $0x8,%esp
  80066c:	50                   	push   %eax
  80066d:	56                   	push   %esi
  80066e:	e8 12 05 00 00       	call   800b85 <strnlen>
  800673:	83 c4 10             	add    $0x10,%esp
  800676:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800679:	eb 16                	jmp    800691 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80067b:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80067f:	83 ec 08             	sub    $0x8,%esp
  800682:	ff 75 0c             	pushl  0xc(%ebp)
  800685:	50                   	push   %eax
  800686:	8b 45 08             	mov    0x8(%ebp),%eax
  800689:	ff d0                	call   *%eax
  80068b:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80068e:	ff 4d e4             	decl   -0x1c(%ebp)
  800691:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800695:	7f e4                	jg     80067b <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800697:	eb 34                	jmp    8006cd <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800699:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80069d:	74 1c                	je     8006bb <vprintfmt+0x207>
  80069f:	83 fb 1f             	cmp    $0x1f,%ebx
  8006a2:	7e 05                	jle    8006a9 <vprintfmt+0x1f5>
  8006a4:	83 fb 7e             	cmp    $0x7e,%ebx
  8006a7:	7e 12                	jle    8006bb <vprintfmt+0x207>
					putch('?', putdat);
  8006a9:	83 ec 08             	sub    $0x8,%esp
  8006ac:	ff 75 0c             	pushl  0xc(%ebp)
  8006af:	6a 3f                	push   $0x3f
  8006b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b4:	ff d0                	call   *%eax
  8006b6:	83 c4 10             	add    $0x10,%esp
  8006b9:	eb 0f                	jmp    8006ca <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006bb:	83 ec 08             	sub    $0x8,%esp
  8006be:	ff 75 0c             	pushl  0xc(%ebp)
  8006c1:	53                   	push   %ebx
  8006c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c5:	ff d0                	call   *%eax
  8006c7:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006ca:	ff 4d e4             	decl   -0x1c(%ebp)
  8006cd:	89 f0                	mov    %esi,%eax
  8006cf:	8d 70 01             	lea    0x1(%eax),%esi
  8006d2:	8a 00                	mov    (%eax),%al
  8006d4:	0f be d8             	movsbl %al,%ebx
  8006d7:	85 db                	test   %ebx,%ebx
  8006d9:	74 24                	je     8006ff <vprintfmt+0x24b>
  8006db:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006df:	78 b8                	js     800699 <vprintfmt+0x1e5>
  8006e1:	ff 4d e0             	decl   -0x20(%ebp)
  8006e4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006e8:	79 af                	jns    800699 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006ea:	eb 13                	jmp    8006ff <vprintfmt+0x24b>
				putch(' ', putdat);
  8006ec:	83 ec 08             	sub    $0x8,%esp
  8006ef:	ff 75 0c             	pushl  0xc(%ebp)
  8006f2:	6a 20                	push   $0x20
  8006f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f7:	ff d0                	call   *%eax
  8006f9:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006fc:	ff 4d e4             	decl   -0x1c(%ebp)
  8006ff:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800703:	7f e7                	jg     8006ec <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800705:	e9 66 01 00 00       	jmp    800870 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80070a:	83 ec 08             	sub    $0x8,%esp
  80070d:	ff 75 e8             	pushl  -0x18(%ebp)
  800710:	8d 45 14             	lea    0x14(%ebp),%eax
  800713:	50                   	push   %eax
  800714:	e8 3c fd ff ff       	call   800455 <getint>
  800719:	83 c4 10             	add    $0x10,%esp
  80071c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80071f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800722:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800725:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800728:	85 d2                	test   %edx,%edx
  80072a:	79 23                	jns    80074f <vprintfmt+0x29b>
				putch('-', putdat);
  80072c:	83 ec 08             	sub    $0x8,%esp
  80072f:	ff 75 0c             	pushl  0xc(%ebp)
  800732:	6a 2d                	push   $0x2d
  800734:	8b 45 08             	mov    0x8(%ebp),%eax
  800737:	ff d0                	call   *%eax
  800739:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80073c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80073f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800742:	f7 d8                	neg    %eax
  800744:	83 d2 00             	adc    $0x0,%edx
  800747:	f7 da                	neg    %edx
  800749:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80074c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80074f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800756:	e9 bc 00 00 00       	jmp    800817 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80075b:	83 ec 08             	sub    $0x8,%esp
  80075e:	ff 75 e8             	pushl  -0x18(%ebp)
  800761:	8d 45 14             	lea    0x14(%ebp),%eax
  800764:	50                   	push   %eax
  800765:	e8 84 fc ff ff       	call   8003ee <getuint>
  80076a:	83 c4 10             	add    $0x10,%esp
  80076d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800770:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800773:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80077a:	e9 98 00 00 00       	jmp    800817 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80077f:	83 ec 08             	sub    $0x8,%esp
  800782:	ff 75 0c             	pushl  0xc(%ebp)
  800785:	6a 58                	push   $0x58
  800787:	8b 45 08             	mov    0x8(%ebp),%eax
  80078a:	ff d0                	call   *%eax
  80078c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80078f:	83 ec 08             	sub    $0x8,%esp
  800792:	ff 75 0c             	pushl  0xc(%ebp)
  800795:	6a 58                	push   $0x58
  800797:	8b 45 08             	mov    0x8(%ebp),%eax
  80079a:	ff d0                	call   *%eax
  80079c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80079f:	83 ec 08             	sub    $0x8,%esp
  8007a2:	ff 75 0c             	pushl  0xc(%ebp)
  8007a5:	6a 58                	push   $0x58
  8007a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007aa:	ff d0                	call   *%eax
  8007ac:	83 c4 10             	add    $0x10,%esp
			break;
  8007af:	e9 bc 00 00 00       	jmp    800870 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007b4:	83 ec 08             	sub    $0x8,%esp
  8007b7:	ff 75 0c             	pushl  0xc(%ebp)
  8007ba:	6a 30                	push   $0x30
  8007bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bf:	ff d0                	call   *%eax
  8007c1:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007c4:	83 ec 08             	sub    $0x8,%esp
  8007c7:	ff 75 0c             	pushl  0xc(%ebp)
  8007ca:	6a 78                	push   $0x78
  8007cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cf:	ff d0                	call   *%eax
  8007d1:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d7:	83 c0 04             	add    $0x4,%eax
  8007da:	89 45 14             	mov    %eax,0x14(%ebp)
  8007dd:	8b 45 14             	mov    0x14(%ebp),%eax
  8007e0:	83 e8 04             	sub    $0x4,%eax
  8007e3:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007ef:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007f6:	eb 1f                	jmp    800817 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007f8:	83 ec 08             	sub    $0x8,%esp
  8007fb:	ff 75 e8             	pushl  -0x18(%ebp)
  8007fe:	8d 45 14             	lea    0x14(%ebp),%eax
  800801:	50                   	push   %eax
  800802:	e8 e7 fb ff ff       	call   8003ee <getuint>
  800807:	83 c4 10             	add    $0x10,%esp
  80080a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80080d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800810:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800817:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80081b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80081e:	83 ec 04             	sub    $0x4,%esp
  800821:	52                   	push   %edx
  800822:	ff 75 e4             	pushl  -0x1c(%ebp)
  800825:	50                   	push   %eax
  800826:	ff 75 f4             	pushl  -0xc(%ebp)
  800829:	ff 75 f0             	pushl  -0x10(%ebp)
  80082c:	ff 75 0c             	pushl  0xc(%ebp)
  80082f:	ff 75 08             	pushl  0x8(%ebp)
  800832:	e8 00 fb ff ff       	call   800337 <printnum>
  800837:	83 c4 20             	add    $0x20,%esp
			break;
  80083a:	eb 34                	jmp    800870 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80083c:	83 ec 08             	sub    $0x8,%esp
  80083f:	ff 75 0c             	pushl  0xc(%ebp)
  800842:	53                   	push   %ebx
  800843:	8b 45 08             	mov    0x8(%ebp),%eax
  800846:	ff d0                	call   *%eax
  800848:	83 c4 10             	add    $0x10,%esp
			break;
  80084b:	eb 23                	jmp    800870 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80084d:	83 ec 08             	sub    $0x8,%esp
  800850:	ff 75 0c             	pushl  0xc(%ebp)
  800853:	6a 25                	push   $0x25
  800855:	8b 45 08             	mov    0x8(%ebp),%eax
  800858:	ff d0                	call   *%eax
  80085a:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80085d:	ff 4d 10             	decl   0x10(%ebp)
  800860:	eb 03                	jmp    800865 <vprintfmt+0x3b1>
  800862:	ff 4d 10             	decl   0x10(%ebp)
  800865:	8b 45 10             	mov    0x10(%ebp),%eax
  800868:	48                   	dec    %eax
  800869:	8a 00                	mov    (%eax),%al
  80086b:	3c 25                	cmp    $0x25,%al
  80086d:	75 f3                	jne    800862 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80086f:	90                   	nop
		}
	}
  800870:	e9 47 fc ff ff       	jmp    8004bc <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800875:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800876:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800879:	5b                   	pop    %ebx
  80087a:	5e                   	pop    %esi
  80087b:	5d                   	pop    %ebp
  80087c:	c3                   	ret    

0080087d <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80087d:	55                   	push   %ebp
  80087e:	89 e5                	mov    %esp,%ebp
  800880:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800883:	8d 45 10             	lea    0x10(%ebp),%eax
  800886:	83 c0 04             	add    $0x4,%eax
  800889:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80088c:	8b 45 10             	mov    0x10(%ebp),%eax
  80088f:	ff 75 f4             	pushl  -0xc(%ebp)
  800892:	50                   	push   %eax
  800893:	ff 75 0c             	pushl  0xc(%ebp)
  800896:	ff 75 08             	pushl  0x8(%ebp)
  800899:	e8 16 fc ff ff       	call   8004b4 <vprintfmt>
  80089e:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008a1:	90                   	nop
  8008a2:	c9                   	leave  
  8008a3:	c3                   	ret    

008008a4 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008a4:	55                   	push   %ebp
  8008a5:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008aa:	8b 40 08             	mov    0x8(%eax),%eax
  8008ad:	8d 50 01             	lea    0x1(%eax),%edx
  8008b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b3:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b9:	8b 10                	mov    (%eax),%edx
  8008bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008be:	8b 40 04             	mov    0x4(%eax),%eax
  8008c1:	39 c2                	cmp    %eax,%edx
  8008c3:	73 12                	jae    8008d7 <sprintputch+0x33>
		*b->buf++ = ch;
  8008c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c8:	8b 00                	mov    (%eax),%eax
  8008ca:	8d 48 01             	lea    0x1(%eax),%ecx
  8008cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008d0:	89 0a                	mov    %ecx,(%edx)
  8008d2:	8b 55 08             	mov    0x8(%ebp),%edx
  8008d5:	88 10                	mov    %dl,(%eax)
}
  8008d7:	90                   	nop
  8008d8:	5d                   	pop    %ebp
  8008d9:	c3                   	ret    

008008da <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008da:	55                   	push   %ebp
  8008db:	89 e5                	mov    %esp,%ebp
  8008dd:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ef:	01 d0                	add    %edx,%eax
  8008f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008fb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008ff:	74 06                	je     800907 <vsnprintf+0x2d>
  800901:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800905:	7f 07                	jg     80090e <vsnprintf+0x34>
		return -E_INVAL;
  800907:	b8 03 00 00 00       	mov    $0x3,%eax
  80090c:	eb 20                	jmp    80092e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80090e:	ff 75 14             	pushl  0x14(%ebp)
  800911:	ff 75 10             	pushl  0x10(%ebp)
  800914:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800917:	50                   	push   %eax
  800918:	68 a4 08 80 00       	push   $0x8008a4
  80091d:	e8 92 fb ff ff       	call   8004b4 <vprintfmt>
  800922:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800925:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800928:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80092b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80092e:	c9                   	leave  
  80092f:	c3                   	ret    

00800930 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800930:	55                   	push   %ebp
  800931:	89 e5                	mov    %esp,%ebp
  800933:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800936:	8d 45 10             	lea    0x10(%ebp),%eax
  800939:	83 c0 04             	add    $0x4,%eax
  80093c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80093f:	8b 45 10             	mov    0x10(%ebp),%eax
  800942:	ff 75 f4             	pushl  -0xc(%ebp)
  800945:	50                   	push   %eax
  800946:	ff 75 0c             	pushl  0xc(%ebp)
  800949:	ff 75 08             	pushl  0x8(%ebp)
  80094c:	e8 89 ff ff ff       	call   8008da <vsnprintf>
  800951:	83 c4 10             	add    $0x10,%esp
  800954:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800957:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80095a:	c9                   	leave  
  80095b:	c3                   	ret    

0080095c <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80095c:	55                   	push   %ebp
  80095d:	89 e5                	mov    %esp,%ebp
  80095f:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  800962:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800966:	74 13                	je     80097b <readline+0x1f>
		cprintf("%s", prompt);
  800968:	83 ec 08             	sub    $0x8,%esp
  80096b:	ff 75 08             	pushl  0x8(%ebp)
  80096e:	68 90 20 80 00       	push   $0x802090
  800973:	e8 62 f9 ff ff       	call   8002da <cprintf>
  800978:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80097b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800982:	83 ec 0c             	sub    $0xc,%esp
  800985:	6a 00                	push   $0x0
  800987:	e8 ed 0f 00 00       	call   801979 <iscons>
  80098c:	83 c4 10             	add    $0x10,%esp
  80098f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800992:	e8 94 0f 00 00       	call   80192b <getchar>
  800997:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80099a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80099e:	79 22                	jns    8009c2 <readline+0x66>
			if (c != -E_EOF)
  8009a0:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8009a4:	0f 84 ad 00 00 00    	je     800a57 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8009aa:	83 ec 08             	sub    $0x8,%esp
  8009ad:	ff 75 ec             	pushl  -0x14(%ebp)
  8009b0:	68 93 20 80 00       	push   $0x802093
  8009b5:	e8 20 f9 ff ff       	call   8002da <cprintf>
  8009ba:	83 c4 10             	add    $0x10,%esp
			return;
  8009bd:	e9 95 00 00 00       	jmp    800a57 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8009c2:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8009c6:	7e 34                	jle    8009fc <readline+0xa0>
  8009c8:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8009cf:	7f 2b                	jg     8009fc <readline+0xa0>
			if (echoing)
  8009d1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009d5:	74 0e                	je     8009e5 <readline+0x89>
				cputchar(c);
  8009d7:	83 ec 0c             	sub    $0xc,%esp
  8009da:	ff 75 ec             	pushl  -0x14(%ebp)
  8009dd:	e8 01 0f 00 00       	call   8018e3 <cputchar>
  8009e2:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8009e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009e8:	8d 50 01             	lea    0x1(%eax),%edx
  8009eb:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8009ee:	89 c2                	mov    %eax,%edx
  8009f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f3:	01 d0                	add    %edx,%eax
  8009f5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8009f8:	88 10                	mov    %dl,(%eax)
  8009fa:	eb 56                	jmp    800a52 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8009fc:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800a00:	75 1f                	jne    800a21 <readline+0xc5>
  800a02:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800a06:	7e 19                	jle    800a21 <readline+0xc5>
			if (echoing)
  800a08:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a0c:	74 0e                	je     800a1c <readline+0xc0>
				cputchar(c);
  800a0e:	83 ec 0c             	sub    $0xc,%esp
  800a11:	ff 75 ec             	pushl  -0x14(%ebp)
  800a14:	e8 ca 0e 00 00       	call   8018e3 <cputchar>
  800a19:	83 c4 10             	add    $0x10,%esp

			i--;
  800a1c:	ff 4d f4             	decl   -0xc(%ebp)
  800a1f:	eb 31                	jmp    800a52 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800a21:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800a25:	74 0a                	je     800a31 <readline+0xd5>
  800a27:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800a2b:	0f 85 61 ff ff ff    	jne    800992 <readline+0x36>
			if (echoing)
  800a31:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a35:	74 0e                	je     800a45 <readline+0xe9>
				cputchar(c);
  800a37:	83 ec 0c             	sub    $0xc,%esp
  800a3a:	ff 75 ec             	pushl  -0x14(%ebp)
  800a3d:	e8 a1 0e 00 00       	call   8018e3 <cputchar>
  800a42:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800a45:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4b:	01 d0                	add    %edx,%eax
  800a4d:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800a50:	eb 06                	jmp    800a58 <readline+0xfc>
		}
	}
  800a52:	e9 3b ff ff ff       	jmp    800992 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800a57:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800a58:	c9                   	leave  
  800a59:	c3                   	ret    

00800a5a <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800a5a:	55                   	push   %ebp
  800a5b:	89 e5                	mov    %esp,%ebp
  800a5d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a60:	e8 41 0a 00 00       	call   8014a6 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800a65:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a69:	74 13                	je     800a7e <atomic_readline+0x24>
		cprintf("%s", prompt);
  800a6b:	83 ec 08             	sub    $0x8,%esp
  800a6e:	ff 75 08             	pushl  0x8(%ebp)
  800a71:	68 90 20 80 00       	push   $0x802090
  800a76:	e8 5f f8 ff ff       	call   8002da <cprintf>
  800a7b:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800a7e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800a85:	83 ec 0c             	sub    $0xc,%esp
  800a88:	6a 00                	push   $0x0
  800a8a:	e8 ea 0e 00 00       	call   801979 <iscons>
  800a8f:	83 c4 10             	add    $0x10,%esp
  800a92:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800a95:	e8 91 0e 00 00       	call   80192b <getchar>
  800a9a:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800a9d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800aa1:	79 23                	jns    800ac6 <atomic_readline+0x6c>
			if (c != -E_EOF)
  800aa3:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800aa7:	74 13                	je     800abc <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800aa9:	83 ec 08             	sub    $0x8,%esp
  800aac:	ff 75 ec             	pushl  -0x14(%ebp)
  800aaf:	68 93 20 80 00       	push   $0x802093
  800ab4:	e8 21 f8 ff ff       	call   8002da <cprintf>
  800ab9:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800abc:	e8 ff 09 00 00       	call   8014c0 <sys_enable_interrupt>
			return;
  800ac1:	e9 9a 00 00 00       	jmp    800b60 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800ac6:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800aca:	7e 34                	jle    800b00 <atomic_readline+0xa6>
  800acc:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800ad3:	7f 2b                	jg     800b00 <atomic_readline+0xa6>
			if (echoing)
  800ad5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800ad9:	74 0e                	je     800ae9 <atomic_readline+0x8f>
				cputchar(c);
  800adb:	83 ec 0c             	sub    $0xc,%esp
  800ade:	ff 75 ec             	pushl  -0x14(%ebp)
  800ae1:	e8 fd 0d 00 00       	call   8018e3 <cputchar>
  800ae6:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800ae9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800aec:	8d 50 01             	lea    0x1(%eax),%edx
  800aef:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800af2:	89 c2                	mov    %eax,%edx
  800af4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af7:	01 d0                	add    %edx,%eax
  800af9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800afc:	88 10                	mov    %dl,(%eax)
  800afe:	eb 5b                	jmp    800b5b <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800b00:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800b04:	75 1f                	jne    800b25 <atomic_readline+0xcb>
  800b06:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800b0a:	7e 19                	jle    800b25 <atomic_readline+0xcb>
			if (echoing)
  800b0c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b10:	74 0e                	je     800b20 <atomic_readline+0xc6>
				cputchar(c);
  800b12:	83 ec 0c             	sub    $0xc,%esp
  800b15:	ff 75 ec             	pushl  -0x14(%ebp)
  800b18:	e8 c6 0d 00 00       	call   8018e3 <cputchar>
  800b1d:	83 c4 10             	add    $0x10,%esp
			i--;
  800b20:	ff 4d f4             	decl   -0xc(%ebp)
  800b23:	eb 36                	jmp    800b5b <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800b25:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800b29:	74 0a                	je     800b35 <atomic_readline+0xdb>
  800b2b:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800b2f:	0f 85 60 ff ff ff    	jne    800a95 <atomic_readline+0x3b>
			if (echoing)
  800b35:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b39:	74 0e                	je     800b49 <atomic_readline+0xef>
				cputchar(c);
  800b3b:	83 ec 0c             	sub    $0xc,%esp
  800b3e:	ff 75 ec             	pushl  -0x14(%ebp)
  800b41:	e8 9d 0d 00 00       	call   8018e3 <cputchar>
  800b46:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800b49:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4f:	01 d0                	add    %edx,%eax
  800b51:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800b54:	e8 67 09 00 00       	call   8014c0 <sys_enable_interrupt>
			return;
  800b59:	eb 05                	jmp    800b60 <atomic_readline+0x106>
		}
	}
  800b5b:	e9 35 ff ff ff       	jmp    800a95 <atomic_readline+0x3b>
}
  800b60:	c9                   	leave  
  800b61:	c3                   	ret    

00800b62 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b62:	55                   	push   %ebp
  800b63:	89 e5                	mov    %esp,%ebp
  800b65:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b68:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b6f:	eb 06                	jmp    800b77 <strlen+0x15>
		n++;
  800b71:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b74:	ff 45 08             	incl   0x8(%ebp)
  800b77:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7a:	8a 00                	mov    (%eax),%al
  800b7c:	84 c0                	test   %al,%al
  800b7e:	75 f1                	jne    800b71 <strlen+0xf>
		n++;
	return n;
  800b80:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b83:	c9                   	leave  
  800b84:	c3                   	ret    

00800b85 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b85:	55                   	push   %ebp
  800b86:	89 e5                	mov    %esp,%ebp
  800b88:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b8b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b92:	eb 09                	jmp    800b9d <strnlen+0x18>
		n++;
  800b94:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b97:	ff 45 08             	incl   0x8(%ebp)
  800b9a:	ff 4d 0c             	decl   0xc(%ebp)
  800b9d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ba1:	74 09                	je     800bac <strnlen+0x27>
  800ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba6:	8a 00                	mov    (%eax),%al
  800ba8:	84 c0                	test   %al,%al
  800baa:	75 e8                	jne    800b94 <strnlen+0xf>
		n++;
	return n;
  800bac:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800baf:	c9                   	leave  
  800bb0:	c3                   	ret    

00800bb1 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bb1:	55                   	push   %ebp
  800bb2:	89 e5                	mov    %esp,%ebp
  800bb4:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bbd:	90                   	nop
  800bbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc1:	8d 50 01             	lea    0x1(%eax),%edx
  800bc4:	89 55 08             	mov    %edx,0x8(%ebp)
  800bc7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bca:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bcd:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bd0:	8a 12                	mov    (%edx),%dl
  800bd2:	88 10                	mov    %dl,(%eax)
  800bd4:	8a 00                	mov    (%eax),%al
  800bd6:	84 c0                	test   %al,%al
  800bd8:	75 e4                	jne    800bbe <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bda:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bdd:	c9                   	leave  
  800bde:	c3                   	ret    

00800bdf <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bdf:	55                   	push   %ebp
  800be0:	89 e5                	mov    %esp,%ebp
  800be2:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800be5:	8b 45 08             	mov    0x8(%ebp),%eax
  800be8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800beb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bf2:	eb 1f                	jmp    800c13 <strncpy+0x34>
		*dst++ = *src;
  800bf4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf7:	8d 50 01             	lea    0x1(%eax),%edx
  800bfa:	89 55 08             	mov    %edx,0x8(%ebp)
  800bfd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c00:	8a 12                	mov    (%edx),%dl
  800c02:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c04:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c07:	8a 00                	mov    (%eax),%al
  800c09:	84 c0                	test   %al,%al
  800c0b:	74 03                	je     800c10 <strncpy+0x31>
			src++;
  800c0d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c10:	ff 45 fc             	incl   -0x4(%ebp)
  800c13:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c16:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c19:	72 d9                	jb     800bf4 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c1b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c1e:	c9                   	leave  
  800c1f:	c3                   	ret    

00800c20 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c20:	55                   	push   %ebp
  800c21:	89 e5                	mov    %esp,%ebp
  800c23:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c26:	8b 45 08             	mov    0x8(%ebp),%eax
  800c29:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c2c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c30:	74 30                	je     800c62 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c32:	eb 16                	jmp    800c4a <strlcpy+0x2a>
			*dst++ = *src++;
  800c34:	8b 45 08             	mov    0x8(%ebp),%eax
  800c37:	8d 50 01             	lea    0x1(%eax),%edx
  800c3a:	89 55 08             	mov    %edx,0x8(%ebp)
  800c3d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c40:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c43:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c46:	8a 12                	mov    (%edx),%dl
  800c48:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c4a:	ff 4d 10             	decl   0x10(%ebp)
  800c4d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c51:	74 09                	je     800c5c <strlcpy+0x3c>
  800c53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c56:	8a 00                	mov    (%eax),%al
  800c58:	84 c0                	test   %al,%al
  800c5a:	75 d8                	jne    800c34 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c62:	8b 55 08             	mov    0x8(%ebp),%edx
  800c65:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c68:	29 c2                	sub    %eax,%edx
  800c6a:	89 d0                	mov    %edx,%eax
}
  800c6c:	c9                   	leave  
  800c6d:	c3                   	ret    

00800c6e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c6e:	55                   	push   %ebp
  800c6f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c71:	eb 06                	jmp    800c79 <strcmp+0xb>
		p++, q++;
  800c73:	ff 45 08             	incl   0x8(%ebp)
  800c76:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c79:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7c:	8a 00                	mov    (%eax),%al
  800c7e:	84 c0                	test   %al,%al
  800c80:	74 0e                	je     800c90 <strcmp+0x22>
  800c82:	8b 45 08             	mov    0x8(%ebp),%eax
  800c85:	8a 10                	mov    (%eax),%dl
  800c87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8a:	8a 00                	mov    (%eax),%al
  800c8c:	38 c2                	cmp    %al,%dl
  800c8e:	74 e3                	je     800c73 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c90:	8b 45 08             	mov    0x8(%ebp),%eax
  800c93:	8a 00                	mov    (%eax),%al
  800c95:	0f b6 d0             	movzbl %al,%edx
  800c98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c9b:	8a 00                	mov    (%eax),%al
  800c9d:	0f b6 c0             	movzbl %al,%eax
  800ca0:	29 c2                	sub    %eax,%edx
  800ca2:	89 d0                	mov    %edx,%eax
}
  800ca4:	5d                   	pop    %ebp
  800ca5:	c3                   	ret    

00800ca6 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ca6:	55                   	push   %ebp
  800ca7:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ca9:	eb 09                	jmp    800cb4 <strncmp+0xe>
		n--, p++, q++;
  800cab:	ff 4d 10             	decl   0x10(%ebp)
  800cae:	ff 45 08             	incl   0x8(%ebp)
  800cb1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cb4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cb8:	74 17                	je     800cd1 <strncmp+0x2b>
  800cba:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbd:	8a 00                	mov    (%eax),%al
  800cbf:	84 c0                	test   %al,%al
  800cc1:	74 0e                	je     800cd1 <strncmp+0x2b>
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	8a 10                	mov    (%eax),%dl
  800cc8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ccb:	8a 00                	mov    (%eax),%al
  800ccd:	38 c2                	cmp    %al,%dl
  800ccf:	74 da                	je     800cab <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cd1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd5:	75 07                	jne    800cde <strncmp+0x38>
		return 0;
  800cd7:	b8 00 00 00 00       	mov    $0x0,%eax
  800cdc:	eb 14                	jmp    800cf2 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cde:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce1:	8a 00                	mov    (%eax),%al
  800ce3:	0f b6 d0             	movzbl %al,%edx
  800ce6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce9:	8a 00                	mov    (%eax),%al
  800ceb:	0f b6 c0             	movzbl %al,%eax
  800cee:	29 c2                	sub    %eax,%edx
  800cf0:	89 d0                	mov    %edx,%eax
}
  800cf2:	5d                   	pop    %ebp
  800cf3:	c3                   	ret    

00800cf4 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800cf4:	55                   	push   %ebp
  800cf5:	89 e5                	mov    %esp,%ebp
  800cf7:	83 ec 04             	sub    $0x4,%esp
  800cfa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cfd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d00:	eb 12                	jmp    800d14 <strchr+0x20>
		if (*s == c)
  800d02:	8b 45 08             	mov    0x8(%ebp),%eax
  800d05:	8a 00                	mov    (%eax),%al
  800d07:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d0a:	75 05                	jne    800d11 <strchr+0x1d>
			return (char *) s;
  800d0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0f:	eb 11                	jmp    800d22 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d11:	ff 45 08             	incl   0x8(%ebp)
  800d14:	8b 45 08             	mov    0x8(%ebp),%eax
  800d17:	8a 00                	mov    (%eax),%al
  800d19:	84 c0                	test   %al,%al
  800d1b:	75 e5                	jne    800d02 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d1d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d22:	c9                   	leave  
  800d23:	c3                   	ret    

00800d24 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d24:	55                   	push   %ebp
  800d25:	89 e5                	mov    %esp,%ebp
  800d27:	83 ec 04             	sub    $0x4,%esp
  800d2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d30:	eb 0d                	jmp    800d3f <strfind+0x1b>
		if (*s == c)
  800d32:	8b 45 08             	mov    0x8(%ebp),%eax
  800d35:	8a 00                	mov    (%eax),%al
  800d37:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d3a:	74 0e                	je     800d4a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d3c:	ff 45 08             	incl   0x8(%ebp)
  800d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d42:	8a 00                	mov    (%eax),%al
  800d44:	84 c0                	test   %al,%al
  800d46:	75 ea                	jne    800d32 <strfind+0xe>
  800d48:	eb 01                	jmp    800d4b <strfind+0x27>
		if (*s == c)
			break;
  800d4a:	90                   	nop
	return (char *) s;
  800d4b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d4e:	c9                   	leave  
  800d4f:	c3                   	ret    

00800d50 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d50:	55                   	push   %ebp
  800d51:	89 e5                	mov    %esp,%ebp
  800d53:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d56:	8b 45 08             	mov    0x8(%ebp),%eax
  800d59:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d5c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d5f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d62:	eb 0e                	jmp    800d72 <memset+0x22>
		*p++ = c;
  800d64:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d67:	8d 50 01             	lea    0x1(%eax),%edx
  800d6a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d70:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d72:	ff 4d f8             	decl   -0x8(%ebp)
  800d75:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d79:	79 e9                	jns    800d64 <memset+0x14>
		*p++ = c;

	return v;
  800d7b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d7e:	c9                   	leave  
  800d7f:	c3                   	ret    

00800d80 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d80:	55                   	push   %ebp
  800d81:	89 e5                	mov    %esp,%ebp
  800d83:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d89:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d92:	eb 16                	jmp    800daa <memcpy+0x2a>
		*d++ = *s++;
  800d94:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d97:	8d 50 01             	lea    0x1(%eax),%edx
  800d9a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d9d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800da0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800da3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800da6:	8a 12                	mov    (%edx),%dl
  800da8:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800daa:	8b 45 10             	mov    0x10(%ebp),%eax
  800dad:	8d 50 ff             	lea    -0x1(%eax),%edx
  800db0:	89 55 10             	mov    %edx,0x10(%ebp)
  800db3:	85 c0                	test   %eax,%eax
  800db5:	75 dd                	jne    800d94 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800db7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dba:	c9                   	leave  
  800dbb:	c3                   	ret    

00800dbc <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800dbc:	55                   	push   %ebp
  800dbd:	89 e5                	mov    %esp,%ebp
  800dbf:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800dce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dd1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dd4:	73 50                	jae    800e26 <memmove+0x6a>
  800dd6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dd9:	8b 45 10             	mov    0x10(%ebp),%eax
  800ddc:	01 d0                	add    %edx,%eax
  800dde:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800de1:	76 43                	jbe    800e26 <memmove+0x6a>
		s += n;
  800de3:	8b 45 10             	mov    0x10(%ebp),%eax
  800de6:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800de9:	8b 45 10             	mov    0x10(%ebp),%eax
  800dec:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800def:	eb 10                	jmp    800e01 <memmove+0x45>
			*--d = *--s;
  800df1:	ff 4d f8             	decl   -0x8(%ebp)
  800df4:	ff 4d fc             	decl   -0x4(%ebp)
  800df7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dfa:	8a 10                	mov    (%eax),%dl
  800dfc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dff:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e01:	8b 45 10             	mov    0x10(%ebp),%eax
  800e04:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e07:	89 55 10             	mov    %edx,0x10(%ebp)
  800e0a:	85 c0                	test   %eax,%eax
  800e0c:	75 e3                	jne    800df1 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e0e:	eb 23                	jmp    800e33 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e10:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e13:	8d 50 01             	lea    0x1(%eax),%edx
  800e16:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e19:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e1c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e1f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e22:	8a 12                	mov    (%edx),%dl
  800e24:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e26:	8b 45 10             	mov    0x10(%ebp),%eax
  800e29:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e2c:	89 55 10             	mov    %edx,0x10(%ebp)
  800e2f:	85 c0                	test   %eax,%eax
  800e31:	75 dd                	jne    800e10 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e33:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e36:	c9                   	leave  
  800e37:	c3                   	ret    

00800e38 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e38:	55                   	push   %ebp
  800e39:	89 e5                	mov    %esp,%ebp
  800e3b:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e47:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e4a:	eb 2a                	jmp    800e76 <memcmp+0x3e>
		if (*s1 != *s2)
  800e4c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e4f:	8a 10                	mov    (%eax),%dl
  800e51:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e54:	8a 00                	mov    (%eax),%al
  800e56:	38 c2                	cmp    %al,%dl
  800e58:	74 16                	je     800e70 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e5d:	8a 00                	mov    (%eax),%al
  800e5f:	0f b6 d0             	movzbl %al,%edx
  800e62:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e65:	8a 00                	mov    (%eax),%al
  800e67:	0f b6 c0             	movzbl %al,%eax
  800e6a:	29 c2                	sub    %eax,%edx
  800e6c:	89 d0                	mov    %edx,%eax
  800e6e:	eb 18                	jmp    800e88 <memcmp+0x50>
		s1++, s2++;
  800e70:	ff 45 fc             	incl   -0x4(%ebp)
  800e73:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e76:	8b 45 10             	mov    0x10(%ebp),%eax
  800e79:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e7c:	89 55 10             	mov    %edx,0x10(%ebp)
  800e7f:	85 c0                	test   %eax,%eax
  800e81:	75 c9                	jne    800e4c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e83:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e88:	c9                   	leave  
  800e89:	c3                   	ret    

00800e8a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e8a:	55                   	push   %ebp
  800e8b:	89 e5                	mov    %esp,%ebp
  800e8d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e90:	8b 55 08             	mov    0x8(%ebp),%edx
  800e93:	8b 45 10             	mov    0x10(%ebp),%eax
  800e96:	01 d0                	add    %edx,%eax
  800e98:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e9b:	eb 15                	jmp    800eb2 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea0:	8a 00                	mov    (%eax),%al
  800ea2:	0f b6 d0             	movzbl %al,%edx
  800ea5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea8:	0f b6 c0             	movzbl %al,%eax
  800eab:	39 c2                	cmp    %eax,%edx
  800ead:	74 0d                	je     800ebc <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800eaf:	ff 45 08             	incl   0x8(%ebp)
  800eb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800eb8:	72 e3                	jb     800e9d <memfind+0x13>
  800eba:	eb 01                	jmp    800ebd <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ebc:	90                   	nop
	return (void *) s;
  800ebd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ec0:	c9                   	leave  
  800ec1:	c3                   	ret    

00800ec2 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ec2:	55                   	push   %ebp
  800ec3:	89 e5                	mov    %esp,%ebp
  800ec5:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ec8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ecf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ed6:	eb 03                	jmp    800edb <strtol+0x19>
		s++;
  800ed8:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800edb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ede:	8a 00                	mov    (%eax),%al
  800ee0:	3c 20                	cmp    $0x20,%al
  800ee2:	74 f4                	je     800ed8 <strtol+0x16>
  800ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee7:	8a 00                	mov    (%eax),%al
  800ee9:	3c 09                	cmp    $0x9,%al
  800eeb:	74 eb                	je     800ed8 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800eed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef0:	8a 00                	mov    (%eax),%al
  800ef2:	3c 2b                	cmp    $0x2b,%al
  800ef4:	75 05                	jne    800efb <strtol+0x39>
		s++;
  800ef6:	ff 45 08             	incl   0x8(%ebp)
  800ef9:	eb 13                	jmp    800f0e <strtol+0x4c>
	else if (*s == '-')
  800efb:	8b 45 08             	mov    0x8(%ebp),%eax
  800efe:	8a 00                	mov    (%eax),%al
  800f00:	3c 2d                	cmp    $0x2d,%al
  800f02:	75 0a                	jne    800f0e <strtol+0x4c>
		s++, neg = 1;
  800f04:	ff 45 08             	incl   0x8(%ebp)
  800f07:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f0e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f12:	74 06                	je     800f1a <strtol+0x58>
  800f14:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f18:	75 20                	jne    800f3a <strtol+0x78>
  800f1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1d:	8a 00                	mov    (%eax),%al
  800f1f:	3c 30                	cmp    $0x30,%al
  800f21:	75 17                	jne    800f3a <strtol+0x78>
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
  800f26:	40                   	inc    %eax
  800f27:	8a 00                	mov    (%eax),%al
  800f29:	3c 78                	cmp    $0x78,%al
  800f2b:	75 0d                	jne    800f3a <strtol+0x78>
		s += 2, base = 16;
  800f2d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f31:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f38:	eb 28                	jmp    800f62 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f3a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f3e:	75 15                	jne    800f55 <strtol+0x93>
  800f40:	8b 45 08             	mov    0x8(%ebp),%eax
  800f43:	8a 00                	mov    (%eax),%al
  800f45:	3c 30                	cmp    $0x30,%al
  800f47:	75 0c                	jne    800f55 <strtol+0x93>
		s++, base = 8;
  800f49:	ff 45 08             	incl   0x8(%ebp)
  800f4c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f53:	eb 0d                	jmp    800f62 <strtol+0xa0>
	else if (base == 0)
  800f55:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f59:	75 07                	jne    800f62 <strtol+0xa0>
		base = 10;
  800f5b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f62:	8b 45 08             	mov    0x8(%ebp),%eax
  800f65:	8a 00                	mov    (%eax),%al
  800f67:	3c 2f                	cmp    $0x2f,%al
  800f69:	7e 19                	jle    800f84 <strtol+0xc2>
  800f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6e:	8a 00                	mov    (%eax),%al
  800f70:	3c 39                	cmp    $0x39,%al
  800f72:	7f 10                	jg     800f84 <strtol+0xc2>
			dig = *s - '0';
  800f74:	8b 45 08             	mov    0x8(%ebp),%eax
  800f77:	8a 00                	mov    (%eax),%al
  800f79:	0f be c0             	movsbl %al,%eax
  800f7c:	83 e8 30             	sub    $0x30,%eax
  800f7f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f82:	eb 42                	jmp    800fc6 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f84:	8b 45 08             	mov    0x8(%ebp),%eax
  800f87:	8a 00                	mov    (%eax),%al
  800f89:	3c 60                	cmp    $0x60,%al
  800f8b:	7e 19                	jle    800fa6 <strtol+0xe4>
  800f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f90:	8a 00                	mov    (%eax),%al
  800f92:	3c 7a                	cmp    $0x7a,%al
  800f94:	7f 10                	jg     800fa6 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f96:	8b 45 08             	mov    0x8(%ebp),%eax
  800f99:	8a 00                	mov    (%eax),%al
  800f9b:	0f be c0             	movsbl %al,%eax
  800f9e:	83 e8 57             	sub    $0x57,%eax
  800fa1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fa4:	eb 20                	jmp    800fc6 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa9:	8a 00                	mov    (%eax),%al
  800fab:	3c 40                	cmp    $0x40,%al
  800fad:	7e 39                	jle    800fe8 <strtol+0x126>
  800faf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb2:	8a 00                	mov    (%eax),%al
  800fb4:	3c 5a                	cmp    $0x5a,%al
  800fb6:	7f 30                	jg     800fe8 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	8a 00                	mov    (%eax),%al
  800fbd:	0f be c0             	movsbl %al,%eax
  800fc0:	83 e8 37             	sub    $0x37,%eax
  800fc3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fc9:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fcc:	7d 19                	jge    800fe7 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fce:	ff 45 08             	incl   0x8(%ebp)
  800fd1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd4:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fd8:	89 c2                	mov    %eax,%edx
  800fda:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fdd:	01 d0                	add    %edx,%eax
  800fdf:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fe2:	e9 7b ff ff ff       	jmp    800f62 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fe7:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fe8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fec:	74 08                	je     800ff6 <strtol+0x134>
		*endptr = (char *) s;
  800fee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff1:	8b 55 08             	mov    0x8(%ebp),%edx
  800ff4:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800ff6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ffa:	74 07                	je     801003 <strtol+0x141>
  800ffc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fff:	f7 d8                	neg    %eax
  801001:	eb 03                	jmp    801006 <strtol+0x144>
  801003:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801006:	c9                   	leave  
  801007:	c3                   	ret    

00801008 <ltostr>:

void
ltostr(long value, char *str)
{
  801008:	55                   	push   %ebp
  801009:	89 e5                	mov    %esp,%ebp
  80100b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80100e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801015:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80101c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801020:	79 13                	jns    801035 <ltostr+0x2d>
	{
		neg = 1;
  801022:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801029:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102c:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80102f:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801032:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801035:	8b 45 08             	mov    0x8(%ebp),%eax
  801038:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80103d:	99                   	cltd   
  80103e:	f7 f9                	idiv   %ecx
  801040:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801043:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801046:	8d 50 01             	lea    0x1(%eax),%edx
  801049:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80104c:	89 c2                	mov    %eax,%edx
  80104e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801051:	01 d0                	add    %edx,%eax
  801053:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801056:	83 c2 30             	add    $0x30,%edx
  801059:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80105b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80105e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801063:	f7 e9                	imul   %ecx
  801065:	c1 fa 02             	sar    $0x2,%edx
  801068:	89 c8                	mov    %ecx,%eax
  80106a:	c1 f8 1f             	sar    $0x1f,%eax
  80106d:	29 c2                	sub    %eax,%edx
  80106f:	89 d0                	mov    %edx,%eax
  801071:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801074:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801077:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80107c:	f7 e9                	imul   %ecx
  80107e:	c1 fa 02             	sar    $0x2,%edx
  801081:	89 c8                	mov    %ecx,%eax
  801083:	c1 f8 1f             	sar    $0x1f,%eax
  801086:	29 c2                	sub    %eax,%edx
  801088:	89 d0                	mov    %edx,%eax
  80108a:	c1 e0 02             	shl    $0x2,%eax
  80108d:	01 d0                	add    %edx,%eax
  80108f:	01 c0                	add    %eax,%eax
  801091:	29 c1                	sub    %eax,%ecx
  801093:	89 ca                	mov    %ecx,%edx
  801095:	85 d2                	test   %edx,%edx
  801097:	75 9c                	jne    801035 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801099:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010a3:	48                   	dec    %eax
  8010a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010a7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010ab:	74 3d                	je     8010ea <ltostr+0xe2>
		start = 1 ;
  8010ad:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010b4:	eb 34                	jmp    8010ea <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010bc:	01 d0                	add    %edx,%eax
  8010be:	8a 00                	mov    (%eax),%al
  8010c0:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c9:	01 c2                	add    %eax,%edx
  8010cb:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d1:	01 c8                	add    %ecx,%eax
  8010d3:	8a 00                	mov    (%eax),%al
  8010d5:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010d7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010dd:	01 c2                	add    %eax,%edx
  8010df:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010e2:	88 02                	mov    %al,(%edx)
		start++ ;
  8010e4:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010e7:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010ed:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010f0:	7c c4                	jl     8010b6 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010f2:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f8:	01 d0                	add    %edx,%eax
  8010fa:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010fd:	90                   	nop
  8010fe:	c9                   	leave  
  8010ff:	c3                   	ret    

00801100 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801100:	55                   	push   %ebp
  801101:	89 e5                	mov    %esp,%ebp
  801103:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801106:	ff 75 08             	pushl  0x8(%ebp)
  801109:	e8 54 fa ff ff       	call   800b62 <strlen>
  80110e:	83 c4 04             	add    $0x4,%esp
  801111:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801114:	ff 75 0c             	pushl  0xc(%ebp)
  801117:	e8 46 fa ff ff       	call   800b62 <strlen>
  80111c:	83 c4 04             	add    $0x4,%esp
  80111f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801122:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801129:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801130:	eb 17                	jmp    801149 <strcconcat+0x49>
		final[s] = str1[s] ;
  801132:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801135:	8b 45 10             	mov    0x10(%ebp),%eax
  801138:	01 c2                	add    %eax,%edx
  80113a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80113d:	8b 45 08             	mov    0x8(%ebp),%eax
  801140:	01 c8                	add    %ecx,%eax
  801142:	8a 00                	mov    (%eax),%al
  801144:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801146:	ff 45 fc             	incl   -0x4(%ebp)
  801149:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80114c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80114f:	7c e1                	jl     801132 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801151:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801158:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80115f:	eb 1f                	jmp    801180 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801161:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801164:	8d 50 01             	lea    0x1(%eax),%edx
  801167:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80116a:	89 c2                	mov    %eax,%edx
  80116c:	8b 45 10             	mov    0x10(%ebp),%eax
  80116f:	01 c2                	add    %eax,%edx
  801171:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801174:	8b 45 0c             	mov    0xc(%ebp),%eax
  801177:	01 c8                	add    %ecx,%eax
  801179:	8a 00                	mov    (%eax),%al
  80117b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80117d:	ff 45 f8             	incl   -0x8(%ebp)
  801180:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801183:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801186:	7c d9                	jl     801161 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801188:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80118b:	8b 45 10             	mov    0x10(%ebp),%eax
  80118e:	01 d0                	add    %edx,%eax
  801190:	c6 00 00             	movb   $0x0,(%eax)
}
  801193:	90                   	nop
  801194:	c9                   	leave  
  801195:	c3                   	ret    

00801196 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801196:	55                   	push   %ebp
  801197:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801199:	8b 45 14             	mov    0x14(%ebp),%eax
  80119c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8011a5:	8b 00                	mov    (%eax),%eax
  8011a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b1:	01 d0                	add    %edx,%eax
  8011b3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011b9:	eb 0c                	jmp    8011c7 <strsplit+0x31>
			*string++ = 0;
  8011bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011be:	8d 50 01             	lea    0x1(%eax),%edx
  8011c1:	89 55 08             	mov    %edx,0x8(%ebp)
  8011c4:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ca:	8a 00                	mov    (%eax),%al
  8011cc:	84 c0                	test   %al,%al
  8011ce:	74 18                	je     8011e8 <strsplit+0x52>
  8011d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d3:	8a 00                	mov    (%eax),%al
  8011d5:	0f be c0             	movsbl %al,%eax
  8011d8:	50                   	push   %eax
  8011d9:	ff 75 0c             	pushl  0xc(%ebp)
  8011dc:	e8 13 fb ff ff       	call   800cf4 <strchr>
  8011e1:	83 c4 08             	add    $0x8,%esp
  8011e4:	85 c0                	test   %eax,%eax
  8011e6:	75 d3                	jne    8011bb <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8011e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011eb:	8a 00                	mov    (%eax),%al
  8011ed:	84 c0                	test   %al,%al
  8011ef:	74 5a                	je     80124b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8011f1:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f4:	8b 00                	mov    (%eax),%eax
  8011f6:	83 f8 0f             	cmp    $0xf,%eax
  8011f9:	75 07                	jne    801202 <strsplit+0x6c>
		{
			return 0;
  8011fb:	b8 00 00 00 00       	mov    $0x0,%eax
  801200:	eb 66                	jmp    801268 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801202:	8b 45 14             	mov    0x14(%ebp),%eax
  801205:	8b 00                	mov    (%eax),%eax
  801207:	8d 48 01             	lea    0x1(%eax),%ecx
  80120a:	8b 55 14             	mov    0x14(%ebp),%edx
  80120d:	89 0a                	mov    %ecx,(%edx)
  80120f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801216:	8b 45 10             	mov    0x10(%ebp),%eax
  801219:	01 c2                	add    %eax,%edx
  80121b:	8b 45 08             	mov    0x8(%ebp),%eax
  80121e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801220:	eb 03                	jmp    801225 <strsplit+0x8f>
			string++;
  801222:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801225:	8b 45 08             	mov    0x8(%ebp),%eax
  801228:	8a 00                	mov    (%eax),%al
  80122a:	84 c0                	test   %al,%al
  80122c:	74 8b                	je     8011b9 <strsplit+0x23>
  80122e:	8b 45 08             	mov    0x8(%ebp),%eax
  801231:	8a 00                	mov    (%eax),%al
  801233:	0f be c0             	movsbl %al,%eax
  801236:	50                   	push   %eax
  801237:	ff 75 0c             	pushl  0xc(%ebp)
  80123a:	e8 b5 fa ff ff       	call   800cf4 <strchr>
  80123f:	83 c4 08             	add    $0x8,%esp
  801242:	85 c0                	test   %eax,%eax
  801244:	74 dc                	je     801222 <strsplit+0x8c>
			string++;
	}
  801246:	e9 6e ff ff ff       	jmp    8011b9 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80124b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80124c:	8b 45 14             	mov    0x14(%ebp),%eax
  80124f:	8b 00                	mov    (%eax),%eax
  801251:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801258:	8b 45 10             	mov    0x10(%ebp),%eax
  80125b:	01 d0                	add    %edx,%eax
  80125d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801263:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801268:	c9                   	leave  
  801269:	c3                   	ret    

0080126a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80126a:	55                   	push   %ebp
  80126b:	89 e5                	mov    %esp,%ebp
  80126d:	57                   	push   %edi
  80126e:	56                   	push   %esi
  80126f:	53                   	push   %ebx
  801270:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801273:	8b 45 08             	mov    0x8(%ebp),%eax
  801276:	8b 55 0c             	mov    0xc(%ebp),%edx
  801279:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80127c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80127f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801282:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801285:	cd 30                	int    $0x30
  801287:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80128a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80128d:	83 c4 10             	add    $0x10,%esp
  801290:	5b                   	pop    %ebx
  801291:	5e                   	pop    %esi
  801292:	5f                   	pop    %edi
  801293:	5d                   	pop    %ebp
  801294:	c3                   	ret    

00801295 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801295:	55                   	push   %ebp
  801296:	89 e5                	mov    %esp,%ebp
  801298:	83 ec 04             	sub    $0x4,%esp
  80129b:	8b 45 10             	mov    0x10(%ebp),%eax
  80129e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012a1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a8:	6a 00                	push   $0x0
  8012aa:	6a 00                	push   $0x0
  8012ac:	52                   	push   %edx
  8012ad:	ff 75 0c             	pushl  0xc(%ebp)
  8012b0:	50                   	push   %eax
  8012b1:	6a 00                	push   $0x0
  8012b3:	e8 b2 ff ff ff       	call   80126a <syscall>
  8012b8:	83 c4 18             	add    $0x18,%esp
}
  8012bb:	90                   	nop
  8012bc:	c9                   	leave  
  8012bd:	c3                   	ret    

008012be <sys_cgetc>:

int
sys_cgetc(void)
{
  8012be:	55                   	push   %ebp
  8012bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012c1:	6a 00                	push   $0x0
  8012c3:	6a 00                	push   $0x0
  8012c5:	6a 00                	push   $0x0
  8012c7:	6a 00                	push   $0x0
  8012c9:	6a 00                	push   $0x0
  8012cb:	6a 01                	push   $0x1
  8012cd:	e8 98 ff ff ff       	call   80126a <syscall>
  8012d2:	83 c4 18             	add    $0x18,%esp
}
  8012d5:	c9                   	leave  
  8012d6:	c3                   	ret    

008012d7 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012d7:	55                   	push   %ebp
  8012d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012da:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dd:	6a 00                	push   $0x0
  8012df:	6a 00                	push   $0x0
  8012e1:	6a 00                	push   $0x0
  8012e3:	6a 00                	push   $0x0
  8012e5:	50                   	push   %eax
  8012e6:	6a 05                	push   $0x5
  8012e8:	e8 7d ff ff ff       	call   80126a <syscall>
  8012ed:	83 c4 18             	add    $0x18,%esp
}
  8012f0:	c9                   	leave  
  8012f1:	c3                   	ret    

008012f2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012f2:	55                   	push   %ebp
  8012f3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012f5:	6a 00                	push   $0x0
  8012f7:	6a 00                	push   $0x0
  8012f9:	6a 00                	push   $0x0
  8012fb:	6a 00                	push   $0x0
  8012fd:	6a 00                	push   $0x0
  8012ff:	6a 02                	push   $0x2
  801301:	e8 64 ff ff ff       	call   80126a <syscall>
  801306:	83 c4 18             	add    $0x18,%esp
}
  801309:	c9                   	leave  
  80130a:	c3                   	ret    

0080130b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80130b:	55                   	push   %ebp
  80130c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80130e:	6a 00                	push   $0x0
  801310:	6a 00                	push   $0x0
  801312:	6a 00                	push   $0x0
  801314:	6a 00                	push   $0x0
  801316:	6a 00                	push   $0x0
  801318:	6a 03                	push   $0x3
  80131a:	e8 4b ff ff ff       	call   80126a <syscall>
  80131f:	83 c4 18             	add    $0x18,%esp
}
  801322:	c9                   	leave  
  801323:	c3                   	ret    

00801324 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801324:	55                   	push   %ebp
  801325:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801327:	6a 00                	push   $0x0
  801329:	6a 00                	push   $0x0
  80132b:	6a 00                	push   $0x0
  80132d:	6a 00                	push   $0x0
  80132f:	6a 00                	push   $0x0
  801331:	6a 04                	push   $0x4
  801333:	e8 32 ff ff ff       	call   80126a <syscall>
  801338:	83 c4 18             	add    $0x18,%esp
}
  80133b:	c9                   	leave  
  80133c:	c3                   	ret    

0080133d <sys_env_exit>:


void sys_env_exit(void)
{
  80133d:	55                   	push   %ebp
  80133e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801340:	6a 00                	push   $0x0
  801342:	6a 00                	push   $0x0
  801344:	6a 00                	push   $0x0
  801346:	6a 00                	push   $0x0
  801348:	6a 00                	push   $0x0
  80134a:	6a 06                	push   $0x6
  80134c:	e8 19 ff ff ff       	call   80126a <syscall>
  801351:	83 c4 18             	add    $0x18,%esp
}
  801354:	90                   	nop
  801355:	c9                   	leave  
  801356:	c3                   	ret    

00801357 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801357:	55                   	push   %ebp
  801358:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80135a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80135d:	8b 45 08             	mov    0x8(%ebp),%eax
  801360:	6a 00                	push   $0x0
  801362:	6a 00                	push   $0x0
  801364:	6a 00                	push   $0x0
  801366:	52                   	push   %edx
  801367:	50                   	push   %eax
  801368:	6a 07                	push   $0x7
  80136a:	e8 fb fe ff ff       	call   80126a <syscall>
  80136f:	83 c4 18             	add    $0x18,%esp
}
  801372:	c9                   	leave  
  801373:	c3                   	ret    

00801374 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801374:	55                   	push   %ebp
  801375:	89 e5                	mov    %esp,%ebp
  801377:	56                   	push   %esi
  801378:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801379:	8b 75 18             	mov    0x18(%ebp),%esi
  80137c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80137f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801382:	8b 55 0c             	mov    0xc(%ebp),%edx
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	56                   	push   %esi
  801389:	53                   	push   %ebx
  80138a:	51                   	push   %ecx
  80138b:	52                   	push   %edx
  80138c:	50                   	push   %eax
  80138d:	6a 08                	push   $0x8
  80138f:	e8 d6 fe ff ff       	call   80126a <syscall>
  801394:	83 c4 18             	add    $0x18,%esp
}
  801397:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80139a:	5b                   	pop    %ebx
  80139b:	5e                   	pop    %esi
  80139c:	5d                   	pop    %ebp
  80139d:	c3                   	ret    

0080139e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80139e:	55                   	push   %ebp
  80139f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a7:	6a 00                	push   $0x0
  8013a9:	6a 00                	push   $0x0
  8013ab:	6a 00                	push   $0x0
  8013ad:	52                   	push   %edx
  8013ae:	50                   	push   %eax
  8013af:	6a 09                	push   $0x9
  8013b1:	e8 b4 fe ff ff       	call   80126a <syscall>
  8013b6:	83 c4 18             	add    $0x18,%esp
}
  8013b9:	c9                   	leave  
  8013ba:	c3                   	ret    

008013bb <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013bb:	55                   	push   %ebp
  8013bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013be:	6a 00                	push   $0x0
  8013c0:	6a 00                	push   $0x0
  8013c2:	6a 00                	push   $0x0
  8013c4:	ff 75 0c             	pushl  0xc(%ebp)
  8013c7:	ff 75 08             	pushl  0x8(%ebp)
  8013ca:	6a 0a                	push   $0xa
  8013cc:	e8 99 fe ff ff       	call   80126a <syscall>
  8013d1:	83 c4 18             	add    $0x18,%esp
}
  8013d4:	c9                   	leave  
  8013d5:	c3                   	ret    

008013d6 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013d6:	55                   	push   %ebp
  8013d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013d9:	6a 00                	push   $0x0
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 00                	push   $0x0
  8013df:	6a 00                	push   $0x0
  8013e1:	6a 00                	push   $0x0
  8013e3:	6a 0b                	push   $0xb
  8013e5:	e8 80 fe ff ff       	call   80126a <syscall>
  8013ea:	83 c4 18             	add    $0x18,%esp
}
  8013ed:	c9                   	leave  
  8013ee:	c3                   	ret    

008013ef <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013ef:	55                   	push   %ebp
  8013f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013f2:	6a 00                	push   $0x0
  8013f4:	6a 00                	push   $0x0
  8013f6:	6a 00                	push   $0x0
  8013f8:	6a 00                	push   $0x0
  8013fa:	6a 00                	push   $0x0
  8013fc:	6a 0c                	push   $0xc
  8013fe:	e8 67 fe ff ff       	call   80126a <syscall>
  801403:	83 c4 18             	add    $0x18,%esp
}
  801406:	c9                   	leave  
  801407:	c3                   	ret    

00801408 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801408:	55                   	push   %ebp
  801409:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80140b:	6a 00                	push   $0x0
  80140d:	6a 00                	push   $0x0
  80140f:	6a 00                	push   $0x0
  801411:	6a 00                	push   $0x0
  801413:	6a 00                	push   $0x0
  801415:	6a 0d                	push   $0xd
  801417:	e8 4e fe ff ff       	call   80126a <syscall>
  80141c:	83 c4 18             	add    $0x18,%esp
}
  80141f:	c9                   	leave  
  801420:	c3                   	ret    

00801421 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801421:	55                   	push   %ebp
  801422:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801424:	6a 00                	push   $0x0
  801426:	6a 00                	push   $0x0
  801428:	6a 00                	push   $0x0
  80142a:	ff 75 0c             	pushl  0xc(%ebp)
  80142d:	ff 75 08             	pushl  0x8(%ebp)
  801430:	6a 11                	push   $0x11
  801432:	e8 33 fe ff ff       	call   80126a <syscall>
  801437:	83 c4 18             	add    $0x18,%esp
	return;
  80143a:	90                   	nop
}
  80143b:	c9                   	leave  
  80143c:	c3                   	ret    

0080143d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80143d:	55                   	push   %ebp
  80143e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801440:	6a 00                	push   $0x0
  801442:	6a 00                	push   $0x0
  801444:	6a 00                	push   $0x0
  801446:	ff 75 0c             	pushl  0xc(%ebp)
  801449:	ff 75 08             	pushl  0x8(%ebp)
  80144c:	6a 12                	push   $0x12
  80144e:	e8 17 fe ff ff       	call   80126a <syscall>
  801453:	83 c4 18             	add    $0x18,%esp
	return ;
  801456:	90                   	nop
}
  801457:	c9                   	leave  
  801458:	c3                   	ret    

00801459 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801459:	55                   	push   %ebp
  80145a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	6a 00                	push   $0x0
  801462:	6a 00                	push   $0x0
  801464:	6a 00                	push   $0x0
  801466:	6a 0e                	push   $0xe
  801468:	e8 fd fd ff ff       	call   80126a <syscall>
  80146d:	83 c4 18             	add    $0x18,%esp
}
  801470:	c9                   	leave  
  801471:	c3                   	ret    

00801472 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801472:	55                   	push   %ebp
  801473:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801475:	6a 00                	push   $0x0
  801477:	6a 00                	push   $0x0
  801479:	6a 00                	push   $0x0
  80147b:	6a 00                	push   $0x0
  80147d:	ff 75 08             	pushl  0x8(%ebp)
  801480:	6a 0f                	push   $0xf
  801482:	e8 e3 fd ff ff       	call   80126a <syscall>
  801487:	83 c4 18             	add    $0x18,%esp
}
  80148a:	c9                   	leave  
  80148b:	c3                   	ret    

0080148c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80148c:	55                   	push   %ebp
  80148d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	6a 00                	push   $0x0
  801495:	6a 00                	push   $0x0
  801497:	6a 00                	push   $0x0
  801499:	6a 10                	push   $0x10
  80149b:	e8 ca fd ff ff       	call   80126a <syscall>
  8014a0:	83 c4 18             	add    $0x18,%esp
}
  8014a3:	90                   	nop
  8014a4:	c9                   	leave  
  8014a5:	c3                   	ret    

008014a6 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014a6:	55                   	push   %ebp
  8014a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 00                	push   $0x0
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 14                	push   $0x14
  8014b5:	e8 b0 fd ff ff       	call   80126a <syscall>
  8014ba:	83 c4 18             	add    $0x18,%esp
}
  8014bd:	90                   	nop
  8014be:	c9                   	leave  
  8014bf:	c3                   	ret    

008014c0 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014c0:	55                   	push   %ebp
  8014c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 00                	push   $0x0
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 15                	push   $0x15
  8014cf:	e8 96 fd ff ff       	call   80126a <syscall>
  8014d4:	83 c4 18             	add    $0x18,%esp
}
  8014d7:	90                   	nop
  8014d8:	c9                   	leave  
  8014d9:	c3                   	ret    

008014da <sys_cputc>:


void
sys_cputc(const char c)
{
  8014da:	55                   	push   %ebp
  8014db:	89 e5                	mov    %esp,%ebp
  8014dd:	83 ec 04             	sub    $0x4,%esp
  8014e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014e6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 00                	push   $0x0
  8014f0:	6a 00                	push   $0x0
  8014f2:	50                   	push   %eax
  8014f3:	6a 16                	push   $0x16
  8014f5:	e8 70 fd ff ff       	call   80126a <syscall>
  8014fa:	83 c4 18             	add    $0x18,%esp
}
  8014fd:	90                   	nop
  8014fe:	c9                   	leave  
  8014ff:	c3                   	ret    

00801500 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801500:	55                   	push   %ebp
  801501:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801503:	6a 00                	push   $0x0
  801505:	6a 00                	push   $0x0
  801507:	6a 00                	push   $0x0
  801509:	6a 00                	push   $0x0
  80150b:	6a 00                	push   $0x0
  80150d:	6a 17                	push   $0x17
  80150f:	e8 56 fd ff ff       	call   80126a <syscall>
  801514:	83 c4 18             	add    $0x18,%esp
}
  801517:	90                   	nop
  801518:	c9                   	leave  
  801519:	c3                   	ret    

0080151a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80151a:	55                   	push   %ebp
  80151b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80151d:	8b 45 08             	mov    0x8(%ebp),%eax
  801520:	6a 00                	push   $0x0
  801522:	6a 00                	push   $0x0
  801524:	6a 00                	push   $0x0
  801526:	ff 75 0c             	pushl  0xc(%ebp)
  801529:	50                   	push   %eax
  80152a:	6a 18                	push   $0x18
  80152c:	e8 39 fd ff ff       	call   80126a <syscall>
  801531:	83 c4 18             	add    $0x18,%esp
}
  801534:	c9                   	leave  
  801535:	c3                   	ret    

00801536 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801536:	55                   	push   %ebp
  801537:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801539:	8b 55 0c             	mov    0xc(%ebp),%edx
  80153c:	8b 45 08             	mov    0x8(%ebp),%eax
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	52                   	push   %edx
  801546:	50                   	push   %eax
  801547:	6a 1b                	push   $0x1b
  801549:	e8 1c fd ff ff       	call   80126a <syscall>
  80154e:	83 c4 18             	add    $0x18,%esp
}
  801551:	c9                   	leave  
  801552:	c3                   	ret    

00801553 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801553:	55                   	push   %ebp
  801554:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801556:	8b 55 0c             	mov    0xc(%ebp),%edx
  801559:	8b 45 08             	mov    0x8(%ebp),%eax
  80155c:	6a 00                	push   $0x0
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	52                   	push   %edx
  801563:	50                   	push   %eax
  801564:	6a 19                	push   $0x19
  801566:	e8 ff fc ff ff       	call   80126a <syscall>
  80156b:	83 c4 18             	add    $0x18,%esp
}
  80156e:	90                   	nop
  80156f:	c9                   	leave  
  801570:	c3                   	ret    

00801571 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801571:	55                   	push   %ebp
  801572:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801574:	8b 55 0c             	mov    0xc(%ebp),%edx
  801577:	8b 45 08             	mov    0x8(%ebp),%eax
  80157a:	6a 00                	push   $0x0
  80157c:	6a 00                	push   $0x0
  80157e:	6a 00                	push   $0x0
  801580:	52                   	push   %edx
  801581:	50                   	push   %eax
  801582:	6a 1a                	push   $0x1a
  801584:	e8 e1 fc ff ff       	call   80126a <syscall>
  801589:	83 c4 18             	add    $0x18,%esp
}
  80158c:	90                   	nop
  80158d:	c9                   	leave  
  80158e:	c3                   	ret    

0080158f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80158f:	55                   	push   %ebp
  801590:	89 e5                	mov    %esp,%ebp
  801592:	83 ec 04             	sub    $0x4,%esp
  801595:	8b 45 10             	mov    0x10(%ebp),%eax
  801598:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80159b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80159e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a5:	6a 00                	push   $0x0
  8015a7:	51                   	push   %ecx
  8015a8:	52                   	push   %edx
  8015a9:	ff 75 0c             	pushl  0xc(%ebp)
  8015ac:	50                   	push   %eax
  8015ad:	6a 1c                	push   $0x1c
  8015af:	e8 b6 fc ff ff       	call   80126a <syscall>
  8015b4:	83 c4 18             	add    $0x18,%esp
}
  8015b7:	c9                   	leave  
  8015b8:	c3                   	ret    

008015b9 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015b9:	55                   	push   %ebp
  8015ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	52                   	push   %edx
  8015c9:	50                   	push   %eax
  8015ca:	6a 1d                	push   $0x1d
  8015cc:	e8 99 fc ff ff       	call   80126a <syscall>
  8015d1:	83 c4 18             	add    $0x18,%esp
}
  8015d4:	c9                   	leave  
  8015d5:	c3                   	ret    

008015d6 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015d6:	55                   	push   %ebp
  8015d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015d9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015df:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	51                   	push   %ecx
  8015e7:	52                   	push   %edx
  8015e8:	50                   	push   %eax
  8015e9:	6a 1e                	push   $0x1e
  8015eb:	e8 7a fc ff ff       	call   80126a <syscall>
  8015f0:	83 c4 18             	add    $0x18,%esp
}
  8015f3:	c9                   	leave  
  8015f4:	c3                   	ret    

008015f5 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015f5:	55                   	push   %ebp
  8015f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fe:	6a 00                	push   $0x0
  801600:	6a 00                	push   $0x0
  801602:	6a 00                	push   $0x0
  801604:	52                   	push   %edx
  801605:	50                   	push   %eax
  801606:	6a 1f                	push   $0x1f
  801608:	e8 5d fc ff ff       	call   80126a <syscall>
  80160d:	83 c4 18             	add    $0x18,%esp
}
  801610:	c9                   	leave  
  801611:	c3                   	ret    

00801612 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801612:	55                   	push   %ebp
  801613:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	6a 00                	push   $0x0
  80161f:	6a 20                	push   $0x20
  801621:	e8 44 fc ff ff       	call   80126a <syscall>
  801626:	83 c4 18             	add    $0x18,%esp
}
  801629:	c9                   	leave  
  80162a:	c3                   	ret    

0080162b <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80162b:	55                   	push   %ebp
  80162c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80162e:	8b 45 08             	mov    0x8(%ebp),%eax
  801631:	6a 00                	push   $0x0
  801633:	ff 75 14             	pushl  0x14(%ebp)
  801636:	ff 75 10             	pushl  0x10(%ebp)
  801639:	ff 75 0c             	pushl  0xc(%ebp)
  80163c:	50                   	push   %eax
  80163d:	6a 21                	push   $0x21
  80163f:	e8 26 fc ff ff       	call   80126a <syscall>
  801644:	83 c4 18             	add    $0x18,%esp
}
  801647:	c9                   	leave  
  801648:	c3                   	ret    

00801649 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801649:	55                   	push   %ebp
  80164a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80164c:	8b 45 08             	mov    0x8(%ebp),%eax
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	6a 00                	push   $0x0
  801655:	6a 00                	push   $0x0
  801657:	50                   	push   %eax
  801658:	6a 22                	push   $0x22
  80165a:	e8 0b fc ff ff       	call   80126a <syscall>
  80165f:	83 c4 18             	add    $0x18,%esp
}
  801662:	90                   	nop
  801663:	c9                   	leave  
  801664:	c3                   	ret    

00801665 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801665:	55                   	push   %ebp
  801666:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801668:	8b 45 08             	mov    0x8(%ebp),%eax
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	6a 00                	push   $0x0
  801673:	50                   	push   %eax
  801674:	6a 23                	push   $0x23
  801676:	e8 ef fb ff ff       	call   80126a <syscall>
  80167b:	83 c4 18             	add    $0x18,%esp
}
  80167e:	90                   	nop
  80167f:	c9                   	leave  
  801680:	c3                   	ret    

00801681 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801681:	55                   	push   %ebp
  801682:	89 e5                	mov    %esp,%ebp
  801684:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801687:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80168a:	8d 50 04             	lea    0x4(%eax),%edx
  80168d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801690:	6a 00                	push   $0x0
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	52                   	push   %edx
  801697:	50                   	push   %eax
  801698:	6a 24                	push   $0x24
  80169a:	e8 cb fb ff ff       	call   80126a <syscall>
  80169f:	83 c4 18             	add    $0x18,%esp
	return result;
  8016a2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016a8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016ab:	89 01                	mov    %eax,(%ecx)
  8016ad:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b3:	c9                   	leave  
  8016b4:	c2 04 00             	ret    $0x4

008016b7 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016b7:	55                   	push   %ebp
  8016b8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	ff 75 10             	pushl  0x10(%ebp)
  8016c1:	ff 75 0c             	pushl  0xc(%ebp)
  8016c4:	ff 75 08             	pushl  0x8(%ebp)
  8016c7:	6a 13                	push   $0x13
  8016c9:	e8 9c fb ff ff       	call   80126a <syscall>
  8016ce:	83 c4 18             	add    $0x18,%esp
	return ;
  8016d1:	90                   	nop
}
  8016d2:	c9                   	leave  
  8016d3:	c3                   	ret    

008016d4 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016d4:	55                   	push   %ebp
  8016d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 00                	push   $0x0
  8016df:	6a 00                	push   $0x0
  8016e1:	6a 25                	push   $0x25
  8016e3:	e8 82 fb ff ff       	call   80126a <syscall>
  8016e8:	83 c4 18             	add    $0x18,%esp
}
  8016eb:	c9                   	leave  
  8016ec:	c3                   	ret    

008016ed <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016ed:	55                   	push   %ebp
  8016ee:	89 e5                	mov    %esp,%ebp
  8016f0:	83 ec 04             	sub    $0x4,%esp
  8016f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016f9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016fd:	6a 00                	push   $0x0
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	50                   	push   %eax
  801706:	6a 26                	push   $0x26
  801708:	e8 5d fb ff ff       	call   80126a <syscall>
  80170d:	83 c4 18             	add    $0x18,%esp
	return ;
  801710:	90                   	nop
}
  801711:	c9                   	leave  
  801712:	c3                   	ret    

00801713 <rsttst>:
void rsttst()
{
  801713:	55                   	push   %ebp
  801714:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801716:	6a 00                	push   $0x0
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	6a 00                	push   $0x0
  801720:	6a 28                	push   $0x28
  801722:	e8 43 fb ff ff       	call   80126a <syscall>
  801727:	83 c4 18             	add    $0x18,%esp
	return ;
  80172a:	90                   	nop
}
  80172b:	c9                   	leave  
  80172c:	c3                   	ret    

0080172d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80172d:	55                   	push   %ebp
  80172e:	89 e5                	mov    %esp,%ebp
  801730:	83 ec 04             	sub    $0x4,%esp
  801733:	8b 45 14             	mov    0x14(%ebp),%eax
  801736:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801739:	8b 55 18             	mov    0x18(%ebp),%edx
  80173c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801740:	52                   	push   %edx
  801741:	50                   	push   %eax
  801742:	ff 75 10             	pushl  0x10(%ebp)
  801745:	ff 75 0c             	pushl  0xc(%ebp)
  801748:	ff 75 08             	pushl  0x8(%ebp)
  80174b:	6a 27                	push   $0x27
  80174d:	e8 18 fb ff ff       	call   80126a <syscall>
  801752:	83 c4 18             	add    $0x18,%esp
	return ;
  801755:	90                   	nop
}
  801756:	c9                   	leave  
  801757:	c3                   	ret    

00801758 <chktst>:
void chktst(uint32 n)
{
  801758:	55                   	push   %ebp
  801759:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	ff 75 08             	pushl  0x8(%ebp)
  801766:	6a 29                	push   $0x29
  801768:	e8 fd fa ff ff       	call   80126a <syscall>
  80176d:	83 c4 18             	add    $0x18,%esp
	return ;
  801770:	90                   	nop
}
  801771:	c9                   	leave  
  801772:	c3                   	ret    

00801773 <inctst>:

void inctst()
{
  801773:	55                   	push   %ebp
  801774:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	6a 2a                	push   $0x2a
  801782:	e8 e3 fa ff ff       	call   80126a <syscall>
  801787:	83 c4 18             	add    $0x18,%esp
	return ;
  80178a:	90                   	nop
}
  80178b:	c9                   	leave  
  80178c:	c3                   	ret    

0080178d <gettst>:
uint32 gettst()
{
  80178d:	55                   	push   %ebp
  80178e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 2b                	push   $0x2b
  80179c:	e8 c9 fa ff ff       	call   80126a <syscall>
  8017a1:	83 c4 18             	add    $0x18,%esp
}
  8017a4:	c9                   	leave  
  8017a5:	c3                   	ret    

008017a6 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017a6:	55                   	push   %ebp
  8017a7:	89 e5                	mov    %esp,%ebp
  8017a9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 2c                	push   $0x2c
  8017b8:	e8 ad fa ff ff       	call   80126a <syscall>
  8017bd:	83 c4 18             	add    $0x18,%esp
  8017c0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017c3:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017c7:	75 07                	jne    8017d0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017c9:	b8 01 00 00 00       	mov    $0x1,%eax
  8017ce:	eb 05                	jmp    8017d5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017d0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017d5:	c9                   	leave  
  8017d6:	c3                   	ret    

008017d7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017d7:	55                   	push   %ebp
  8017d8:	89 e5                	mov    %esp,%ebp
  8017da:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 00                	push   $0x0
  8017e7:	6a 2c                	push   $0x2c
  8017e9:	e8 7c fa ff ff       	call   80126a <syscall>
  8017ee:	83 c4 18             	add    $0x18,%esp
  8017f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017f4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017f8:	75 07                	jne    801801 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017fa:	b8 01 00 00 00       	mov    $0x1,%eax
  8017ff:	eb 05                	jmp    801806 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801801:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801806:	c9                   	leave  
  801807:	c3                   	ret    

00801808 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801808:	55                   	push   %ebp
  801809:	89 e5                	mov    %esp,%ebp
  80180b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 2c                	push   $0x2c
  80181a:	e8 4b fa ff ff       	call   80126a <syscall>
  80181f:	83 c4 18             	add    $0x18,%esp
  801822:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801825:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801829:	75 07                	jne    801832 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80182b:	b8 01 00 00 00       	mov    $0x1,%eax
  801830:	eb 05                	jmp    801837 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801832:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801837:	c9                   	leave  
  801838:	c3                   	ret    

00801839 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801839:	55                   	push   %ebp
  80183a:	89 e5                	mov    %esp,%ebp
  80183c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	6a 00                	push   $0x0
  801849:	6a 2c                	push   $0x2c
  80184b:	e8 1a fa ff ff       	call   80126a <syscall>
  801850:	83 c4 18             	add    $0x18,%esp
  801853:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801856:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80185a:	75 07                	jne    801863 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80185c:	b8 01 00 00 00       	mov    $0x1,%eax
  801861:	eb 05                	jmp    801868 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801863:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801868:	c9                   	leave  
  801869:	c3                   	ret    

0080186a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80186a:	55                   	push   %ebp
  80186b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	ff 75 08             	pushl  0x8(%ebp)
  801878:	6a 2d                	push   $0x2d
  80187a:	e8 eb f9 ff ff       	call   80126a <syscall>
  80187f:	83 c4 18             	add    $0x18,%esp
	return ;
  801882:	90                   	nop
}
  801883:	c9                   	leave  
  801884:	c3                   	ret    

00801885 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801885:	55                   	push   %ebp
  801886:	89 e5                	mov    %esp,%ebp
  801888:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801889:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80188c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80188f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801892:	8b 45 08             	mov    0x8(%ebp),%eax
  801895:	6a 00                	push   $0x0
  801897:	53                   	push   %ebx
  801898:	51                   	push   %ecx
  801899:	52                   	push   %edx
  80189a:	50                   	push   %eax
  80189b:	6a 2e                	push   $0x2e
  80189d:	e8 c8 f9 ff ff       	call   80126a <syscall>
  8018a2:	83 c4 18             	add    $0x18,%esp
}
  8018a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8018a8:	c9                   	leave  
  8018a9:	c3                   	ret    

008018aa <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8018aa:	55                   	push   %ebp
  8018ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8018ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b3:	6a 00                	push   $0x0
  8018b5:	6a 00                	push   $0x0
  8018b7:	6a 00                	push   $0x0
  8018b9:	52                   	push   %edx
  8018ba:	50                   	push   %eax
  8018bb:	6a 2f                	push   $0x2f
  8018bd:	e8 a8 f9 ff ff       	call   80126a <syscall>
  8018c2:	83 c4 18             	add    $0x18,%esp
}
  8018c5:	c9                   	leave  
  8018c6:	c3                   	ret    

008018c7 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8018c7:	55                   	push   %ebp
  8018c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	ff 75 0c             	pushl  0xc(%ebp)
  8018d3:	ff 75 08             	pushl  0x8(%ebp)
  8018d6:	6a 30                	push   $0x30
  8018d8:	e8 8d f9 ff ff       	call   80126a <syscall>
  8018dd:	83 c4 18             	add    $0x18,%esp
	return ;
  8018e0:	90                   	nop
}
  8018e1:	c9                   	leave  
  8018e2:	c3                   	ret    

008018e3 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8018e3:	55                   	push   %ebp
  8018e4:	89 e5                	mov    %esp,%ebp
  8018e6:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8018e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ec:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8018ef:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8018f3:	83 ec 0c             	sub    $0xc,%esp
  8018f6:	50                   	push   %eax
  8018f7:	e8 de fb ff ff       	call   8014da <sys_cputc>
  8018fc:	83 c4 10             	add    $0x10,%esp
}
  8018ff:	90                   	nop
  801900:	c9                   	leave  
  801901:	c3                   	ret    

00801902 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  801902:	55                   	push   %ebp
  801903:	89 e5                	mov    %esp,%ebp
  801905:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801908:	e8 99 fb ff ff       	call   8014a6 <sys_disable_interrupt>
	char c = ch;
  80190d:	8b 45 08             	mov    0x8(%ebp),%eax
  801910:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  801913:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  801917:	83 ec 0c             	sub    $0xc,%esp
  80191a:	50                   	push   %eax
  80191b:	e8 ba fb ff ff       	call   8014da <sys_cputc>
  801920:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  801923:	e8 98 fb ff ff       	call   8014c0 <sys_enable_interrupt>
}
  801928:	90                   	nop
  801929:	c9                   	leave  
  80192a:	c3                   	ret    

0080192b <getchar>:

int
getchar(void)
{
  80192b:	55                   	push   %ebp
  80192c:	89 e5                	mov    %esp,%ebp
  80192e:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  801931:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801938:	eb 08                	jmp    801942 <getchar+0x17>
	{
		c = sys_cgetc();
  80193a:	e8 7f f9 ff ff       	call   8012be <sys_cgetc>
  80193f:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  801942:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801946:	74 f2                	je     80193a <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  801948:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80194b:	c9                   	leave  
  80194c:	c3                   	ret    

0080194d <atomic_getchar>:

int
atomic_getchar(void)
{
  80194d:	55                   	push   %ebp
  80194e:	89 e5                	mov    %esp,%ebp
  801950:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801953:	e8 4e fb ff ff       	call   8014a6 <sys_disable_interrupt>
	int c=0;
  801958:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80195f:	eb 08                	jmp    801969 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  801961:	e8 58 f9 ff ff       	call   8012be <sys_cgetc>
  801966:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  801969:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80196d:	74 f2                	je     801961 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  80196f:	e8 4c fb ff ff       	call   8014c0 <sys_enable_interrupt>
	return c;
  801974:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801977:	c9                   	leave  
  801978:	c3                   	ret    

00801979 <iscons>:

int iscons(int fdnum)
{
  801979:	55                   	push   %ebp
  80197a:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80197c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801981:	5d                   	pop    %ebp
  801982:	c3                   	ret    
  801983:	90                   	nop

00801984 <__udivdi3>:
  801984:	55                   	push   %ebp
  801985:	57                   	push   %edi
  801986:	56                   	push   %esi
  801987:	53                   	push   %ebx
  801988:	83 ec 1c             	sub    $0x1c,%esp
  80198b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80198f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801993:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801997:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80199b:	89 ca                	mov    %ecx,%edx
  80199d:	89 f8                	mov    %edi,%eax
  80199f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8019a3:	85 f6                	test   %esi,%esi
  8019a5:	75 2d                	jne    8019d4 <__udivdi3+0x50>
  8019a7:	39 cf                	cmp    %ecx,%edi
  8019a9:	77 65                	ja     801a10 <__udivdi3+0x8c>
  8019ab:	89 fd                	mov    %edi,%ebp
  8019ad:	85 ff                	test   %edi,%edi
  8019af:	75 0b                	jne    8019bc <__udivdi3+0x38>
  8019b1:	b8 01 00 00 00       	mov    $0x1,%eax
  8019b6:	31 d2                	xor    %edx,%edx
  8019b8:	f7 f7                	div    %edi
  8019ba:	89 c5                	mov    %eax,%ebp
  8019bc:	31 d2                	xor    %edx,%edx
  8019be:	89 c8                	mov    %ecx,%eax
  8019c0:	f7 f5                	div    %ebp
  8019c2:	89 c1                	mov    %eax,%ecx
  8019c4:	89 d8                	mov    %ebx,%eax
  8019c6:	f7 f5                	div    %ebp
  8019c8:	89 cf                	mov    %ecx,%edi
  8019ca:	89 fa                	mov    %edi,%edx
  8019cc:	83 c4 1c             	add    $0x1c,%esp
  8019cf:	5b                   	pop    %ebx
  8019d0:	5e                   	pop    %esi
  8019d1:	5f                   	pop    %edi
  8019d2:	5d                   	pop    %ebp
  8019d3:	c3                   	ret    
  8019d4:	39 ce                	cmp    %ecx,%esi
  8019d6:	77 28                	ja     801a00 <__udivdi3+0x7c>
  8019d8:	0f bd fe             	bsr    %esi,%edi
  8019db:	83 f7 1f             	xor    $0x1f,%edi
  8019de:	75 40                	jne    801a20 <__udivdi3+0x9c>
  8019e0:	39 ce                	cmp    %ecx,%esi
  8019e2:	72 0a                	jb     8019ee <__udivdi3+0x6a>
  8019e4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8019e8:	0f 87 9e 00 00 00    	ja     801a8c <__udivdi3+0x108>
  8019ee:	b8 01 00 00 00       	mov    $0x1,%eax
  8019f3:	89 fa                	mov    %edi,%edx
  8019f5:	83 c4 1c             	add    $0x1c,%esp
  8019f8:	5b                   	pop    %ebx
  8019f9:	5e                   	pop    %esi
  8019fa:	5f                   	pop    %edi
  8019fb:	5d                   	pop    %ebp
  8019fc:	c3                   	ret    
  8019fd:	8d 76 00             	lea    0x0(%esi),%esi
  801a00:	31 ff                	xor    %edi,%edi
  801a02:	31 c0                	xor    %eax,%eax
  801a04:	89 fa                	mov    %edi,%edx
  801a06:	83 c4 1c             	add    $0x1c,%esp
  801a09:	5b                   	pop    %ebx
  801a0a:	5e                   	pop    %esi
  801a0b:	5f                   	pop    %edi
  801a0c:	5d                   	pop    %ebp
  801a0d:	c3                   	ret    
  801a0e:	66 90                	xchg   %ax,%ax
  801a10:	89 d8                	mov    %ebx,%eax
  801a12:	f7 f7                	div    %edi
  801a14:	31 ff                	xor    %edi,%edi
  801a16:	89 fa                	mov    %edi,%edx
  801a18:	83 c4 1c             	add    $0x1c,%esp
  801a1b:	5b                   	pop    %ebx
  801a1c:	5e                   	pop    %esi
  801a1d:	5f                   	pop    %edi
  801a1e:	5d                   	pop    %ebp
  801a1f:	c3                   	ret    
  801a20:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a25:	89 eb                	mov    %ebp,%ebx
  801a27:	29 fb                	sub    %edi,%ebx
  801a29:	89 f9                	mov    %edi,%ecx
  801a2b:	d3 e6                	shl    %cl,%esi
  801a2d:	89 c5                	mov    %eax,%ebp
  801a2f:	88 d9                	mov    %bl,%cl
  801a31:	d3 ed                	shr    %cl,%ebp
  801a33:	89 e9                	mov    %ebp,%ecx
  801a35:	09 f1                	or     %esi,%ecx
  801a37:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a3b:	89 f9                	mov    %edi,%ecx
  801a3d:	d3 e0                	shl    %cl,%eax
  801a3f:	89 c5                	mov    %eax,%ebp
  801a41:	89 d6                	mov    %edx,%esi
  801a43:	88 d9                	mov    %bl,%cl
  801a45:	d3 ee                	shr    %cl,%esi
  801a47:	89 f9                	mov    %edi,%ecx
  801a49:	d3 e2                	shl    %cl,%edx
  801a4b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a4f:	88 d9                	mov    %bl,%cl
  801a51:	d3 e8                	shr    %cl,%eax
  801a53:	09 c2                	or     %eax,%edx
  801a55:	89 d0                	mov    %edx,%eax
  801a57:	89 f2                	mov    %esi,%edx
  801a59:	f7 74 24 0c          	divl   0xc(%esp)
  801a5d:	89 d6                	mov    %edx,%esi
  801a5f:	89 c3                	mov    %eax,%ebx
  801a61:	f7 e5                	mul    %ebp
  801a63:	39 d6                	cmp    %edx,%esi
  801a65:	72 19                	jb     801a80 <__udivdi3+0xfc>
  801a67:	74 0b                	je     801a74 <__udivdi3+0xf0>
  801a69:	89 d8                	mov    %ebx,%eax
  801a6b:	31 ff                	xor    %edi,%edi
  801a6d:	e9 58 ff ff ff       	jmp    8019ca <__udivdi3+0x46>
  801a72:	66 90                	xchg   %ax,%ax
  801a74:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a78:	89 f9                	mov    %edi,%ecx
  801a7a:	d3 e2                	shl    %cl,%edx
  801a7c:	39 c2                	cmp    %eax,%edx
  801a7e:	73 e9                	jae    801a69 <__udivdi3+0xe5>
  801a80:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a83:	31 ff                	xor    %edi,%edi
  801a85:	e9 40 ff ff ff       	jmp    8019ca <__udivdi3+0x46>
  801a8a:	66 90                	xchg   %ax,%ax
  801a8c:	31 c0                	xor    %eax,%eax
  801a8e:	e9 37 ff ff ff       	jmp    8019ca <__udivdi3+0x46>
  801a93:	90                   	nop

00801a94 <__umoddi3>:
  801a94:	55                   	push   %ebp
  801a95:	57                   	push   %edi
  801a96:	56                   	push   %esi
  801a97:	53                   	push   %ebx
  801a98:	83 ec 1c             	sub    $0x1c,%esp
  801a9b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a9f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801aa3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801aa7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801aab:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801aaf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801ab3:	89 f3                	mov    %esi,%ebx
  801ab5:	89 fa                	mov    %edi,%edx
  801ab7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801abb:	89 34 24             	mov    %esi,(%esp)
  801abe:	85 c0                	test   %eax,%eax
  801ac0:	75 1a                	jne    801adc <__umoddi3+0x48>
  801ac2:	39 f7                	cmp    %esi,%edi
  801ac4:	0f 86 a2 00 00 00    	jbe    801b6c <__umoddi3+0xd8>
  801aca:	89 c8                	mov    %ecx,%eax
  801acc:	89 f2                	mov    %esi,%edx
  801ace:	f7 f7                	div    %edi
  801ad0:	89 d0                	mov    %edx,%eax
  801ad2:	31 d2                	xor    %edx,%edx
  801ad4:	83 c4 1c             	add    $0x1c,%esp
  801ad7:	5b                   	pop    %ebx
  801ad8:	5e                   	pop    %esi
  801ad9:	5f                   	pop    %edi
  801ada:	5d                   	pop    %ebp
  801adb:	c3                   	ret    
  801adc:	39 f0                	cmp    %esi,%eax
  801ade:	0f 87 ac 00 00 00    	ja     801b90 <__umoddi3+0xfc>
  801ae4:	0f bd e8             	bsr    %eax,%ebp
  801ae7:	83 f5 1f             	xor    $0x1f,%ebp
  801aea:	0f 84 ac 00 00 00    	je     801b9c <__umoddi3+0x108>
  801af0:	bf 20 00 00 00       	mov    $0x20,%edi
  801af5:	29 ef                	sub    %ebp,%edi
  801af7:	89 fe                	mov    %edi,%esi
  801af9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801afd:	89 e9                	mov    %ebp,%ecx
  801aff:	d3 e0                	shl    %cl,%eax
  801b01:	89 d7                	mov    %edx,%edi
  801b03:	89 f1                	mov    %esi,%ecx
  801b05:	d3 ef                	shr    %cl,%edi
  801b07:	09 c7                	or     %eax,%edi
  801b09:	89 e9                	mov    %ebp,%ecx
  801b0b:	d3 e2                	shl    %cl,%edx
  801b0d:	89 14 24             	mov    %edx,(%esp)
  801b10:	89 d8                	mov    %ebx,%eax
  801b12:	d3 e0                	shl    %cl,%eax
  801b14:	89 c2                	mov    %eax,%edx
  801b16:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b1a:	d3 e0                	shl    %cl,%eax
  801b1c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b20:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b24:	89 f1                	mov    %esi,%ecx
  801b26:	d3 e8                	shr    %cl,%eax
  801b28:	09 d0                	or     %edx,%eax
  801b2a:	d3 eb                	shr    %cl,%ebx
  801b2c:	89 da                	mov    %ebx,%edx
  801b2e:	f7 f7                	div    %edi
  801b30:	89 d3                	mov    %edx,%ebx
  801b32:	f7 24 24             	mull   (%esp)
  801b35:	89 c6                	mov    %eax,%esi
  801b37:	89 d1                	mov    %edx,%ecx
  801b39:	39 d3                	cmp    %edx,%ebx
  801b3b:	0f 82 87 00 00 00    	jb     801bc8 <__umoddi3+0x134>
  801b41:	0f 84 91 00 00 00    	je     801bd8 <__umoddi3+0x144>
  801b47:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b4b:	29 f2                	sub    %esi,%edx
  801b4d:	19 cb                	sbb    %ecx,%ebx
  801b4f:	89 d8                	mov    %ebx,%eax
  801b51:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b55:	d3 e0                	shl    %cl,%eax
  801b57:	89 e9                	mov    %ebp,%ecx
  801b59:	d3 ea                	shr    %cl,%edx
  801b5b:	09 d0                	or     %edx,%eax
  801b5d:	89 e9                	mov    %ebp,%ecx
  801b5f:	d3 eb                	shr    %cl,%ebx
  801b61:	89 da                	mov    %ebx,%edx
  801b63:	83 c4 1c             	add    $0x1c,%esp
  801b66:	5b                   	pop    %ebx
  801b67:	5e                   	pop    %esi
  801b68:	5f                   	pop    %edi
  801b69:	5d                   	pop    %ebp
  801b6a:	c3                   	ret    
  801b6b:	90                   	nop
  801b6c:	89 fd                	mov    %edi,%ebp
  801b6e:	85 ff                	test   %edi,%edi
  801b70:	75 0b                	jne    801b7d <__umoddi3+0xe9>
  801b72:	b8 01 00 00 00       	mov    $0x1,%eax
  801b77:	31 d2                	xor    %edx,%edx
  801b79:	f7 f7                	div    %edi
  801b7b:	89 c5                	mov    %eax,%ebp
  801b7d:	89 f0                	mov    %esi,%eax
  801b7f:	31 d2                	xor    %edx,%edx
  801b81:	f7 f5                	div    %ebp
  801b83:	89 c8                	mov    %ecx,%eax
  801b85:	f7 f5                	div    %ebp
  801b87:	89 d0                	mov    %edx,%eax
  801b89:	e9 44 ff ff ff       	jmp    801ad2 <__umoddi3+0x3e>
  801b8e:	66 90                	xchg   %ax,%ax
  801b90:	89 c8                	mov    %ecx,%eax
  801b92:	89 f2                	mov    %esi,%edx
  801b94:	83 c4 1c             	add    $0x1c,%esp
  801b97:	5b                   	pop    %ebx
  801b98:	5e                   	pop    %esi
  801b99:	5f                   	pop    %edi
  801b9a:	5d                   	pop    %ebp
  801b9b:	c3                   	ret    
  801b9c:	3b 04 24             	cmp    (%esp),%eax
  801b9f:	72 06                	jb     801ba7 <__umoddi3+0x113>
  801ba1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ba5:	77 0f                	ja     801bb6 <__umoddi3+0x122>
  801ba7:	89 f2                	mov    %esi,%edx
  801ba9:	29 f9                	sub    %edi,%ecx
  801bab:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801baf:	89 14 24             	mov    %edx,(%esp)
  801bb2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bb6:	8b 44 24 04          	mov    0x4(%esp),%eax
  801bba:	8b 14 24             	mov    (%esp),%edx
  801bbd:	83 c4 1c             	add    $0x1c,%esp
  801bc0:	5b                   	pop    %ebx
  801bc1:	5e                   	pop    %esi
  801bc2:	5f                   	pop    %edi
  801bc3:	5d                   	pop    %ebp
  801bc4:	c3                   	ret    
  801bc5:	8d 76 00             	lea    0x0(%esi),%esi
  801bc8:	2b 04 24             	sub    (%esp),%eax
  801bcb:	19 fa                	sbb    %edi,%edx
  801bcd:	89 d1                	mov    %edx,%ecx
  801bcf:	89 c6                	mov    %eax,%esi
  801bd1:	e9 71 ff ff ff       	jmp    801b47 <__umoddi3+0xb3>
  801bd6:	66 90                	xchg   %ax,%ax
  801bd8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801bdc:	72 ea                	jb     801bc8 <__umoddi3+0x134>
  801bde:	89 d9                	mov    %ebx,%ecx
  801be0:	e9 62 ff ff ff       	jmp    801b47 <__umoddi3+0xb3>
