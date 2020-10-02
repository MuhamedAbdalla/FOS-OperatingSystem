
obj/user/game:     file format elf32-i386


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
  800031:	e8 79 00 00 00       	call   8000af <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>
	
void
_main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	int i=28;
  80003e:	c7 45 f4 1c 00 00 00 	movl   $0x1c,-0xc(%ebp)
	for(;i<128; i++)
  800045:	eb 5f                	jmp    8000a6 <_main+0x6e>
	{
		int c=0;
  800047:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		for(;c<10; c++)
  80004e:	eb 16                	jmp    800066 <_main+0x2e>
		{
			cprintf("%c",i);
  800050:	83 ec 08             	sub    $0x8,%esp
  800053:	ff 75 f4             	pushl  -0xc(%ebp)
  800056:	68 20 19 80 00       	push   $0x801920
  80005b:	e8 48 02 00 00       	call   8002a8 <cprintf>
  800060:	83 c4 10             	add    $0x10,%esp
{	
	int i=28;
	for(;i<128; i++)
	{
		int c=0;
		for(;c<10; c++)
  800063:	ff 45 f0             	incl   -0x10(%ebp)
  800066:	83 7d f0 09          	cmpl   $0x9,-0x10(%ebp)
  80006a:	7e e4                	jle    800050 <_main+0x18>
		{
			cprintf("%c",i);
		}
		int d=0;
  80006c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for(; d< 500000; d++);	
  800073:	eb 03                	jmp    800078 <_main+0x40>
  800075:	ff 45 ec             	incl   -0x14(%ebp)
  800078:	81 7d ec 1f a1 07 00 	cmpl   $0x7a11f,-0x14(%ebp)
  80007f:	7e f4                	jle    800075 <_main+0x3d>
		c=0;
  800081:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		for(;c<10; c++)
  800088:	eb 13                	jmp    80009d <_main+0x65>
		{
			cprintf("\b");
  80008a:	83 ec 0c             	sub    $0xc,%esp
  80008d:	68 23 19 80 00       	push   $0x801923
  800092:	e8 11 02 00 00       	call   8002a8 <cprintf>
  800097:	83 c4 10             	add    $0x10,%esp
			cprintf("%c",i);
		}
		int d=0;
		for(; d< 500000; d++);	
		c=0;
		for(;c<10; c++)
  80009a:	ff 45 f0             	incl   -0x10(%ebp)
  80009d:	83 7d f0 09          	cmpl   $0x9,-0x10(%ebp)
  8000a1:	7e e7                	jle    80008a <_main+0x52>
	
void
_main(void)
{	
	int i=28;
	for(;i<128; i++)
  8000a3:	ff 45 f4             	incl   -0xc(%ebp)
  8000a6:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
  8000aa:	7e 9b                	jle    800047 <_main+0xf>
		{
			cprintf("\b");
		}		
	}
	
	return;	
  8000ac:	90                   	nop
}
  8000ad:	c9                   	leave  
  8000ae:	c3                   	ret    

008000af <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000af:	55                   	push   %ebp
  8000b0:	89 e5                	mov    %esp,%ebp
  8000b2:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000b5:	e8 19 10 00 00       	call   8010d3 <sys_getenvindex>
  8000ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000bd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000c0:	89 d0                	mov    %edx,%eax
  8000c2:	c1 e0 03             	shl    $0x3,%eax
  8000c5:	01 d0                	add    %edx,%eax
  8000c7:	c1 e0 02             	shl    $0x2,%eax
  8000ca:	01 d0                	add    %edx,%eax
  8000cc:	c1 e0 06             	shl    $0x6,%eax
  8000cf:	29 d0                	sub    %edx,%eax
  8000d1:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8000d8:	01 c8                	add    %ecx,%eax
  8000da:	01 d0                	add    %edx,%eax
  8000dc:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000e1:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000e6:	a1 20 20 80 00       	mov    0x802020,%eax
  8000eb:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  8000f1:	84 c0                	test   %al,%al
  8000f3:	74 0f                	je     800104 <libmain+0x55>
		binaryname = myEnv->prog_name;
  8000f5:	a1 20 20 80 00       	mov    0x802020,%eax
  8000fa:	05 b0 52 00 00       	add    $0x52b0,%eax
  8000ff:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800104:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800108:	7e 0a                	jle    800114 <libmain+0x65>
		binaryname = argv[0];
  80010a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80010d:	8b 00                	mov    (%eax),%eax
  80010f:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800114:	83 ec 08             	sub    $0x8,%esp
  800117:	ff 75 0c             	pushl  0xc(%ebp)
  80011a:	ff 75 08             	pushl  0x8(%ebp)
  80011d:	e8 16 ff ff ff       	call   800038 <_main>
  800122:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800125:	e8 44 11 00 00       	call   80126e <sys_disable_interrupt>
	cprintf("**************************************\n");
  80012a:	83 ec 0c             	sub    $0xc,%esp
  80012d:	68 40 19 80 00       	push   $0x801940
  800132:	e8 71 01 00 00       	call   8002a8 <cprintf>
  800137:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80013a:	a1 20 20 80 00       	mov    0x802020,%eax
  80013f:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  800145:	a1 20 20 80 00       	mov    0x802020,%eax
  80014a:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  800150:	83 ec 04             	sub    $0x4,%esp
  800153:	52                   	push   %edx
  800154:	50                   	push   %eax
  800155:	68 68 19 80 00       	push   $0x801968
  80015a:	e8 49 01 00 00       	call   8002a8 <cprintf>
  80015f:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800162:	a1 20 20 80 00       	mov    0x802020,%eax
  800167:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  80016d:	a1 20 20 80 00       	mov    0x802020,%eax
  800172:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  800178:	a1 20 20 80 00       	mov    0x802020,%eax
  80017d:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  800183:	51                   	push   %ecx
  800184:	52                   	push   %edx
  800185:	50                   	push   %eax
  800186:	68 90 19 80 00       	push   $0x801990
  80018b:	e8 18 01 00 00       	call   8002a8 <cprintf>
  800190:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800193:	83 ec 0c             	sub    $0xc,%esp
  800196:	68 40 19 80 00       	push   $0x801940
  80019b:	e8 08 01 00 00       	call   8002a8 <cprintf>
  8001a0:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001a3:	e8 e0 10 00 00       	call   801288 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001a8:	e8 19 00 00 00       	call   8001c6 <exit>
}
  8001ad:	90                   	nop
  8001ae:	c9                   	leave  
  8001af:	c3                   	ret    

008001b0 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001b0:	55                   	push   %ebp
  8001b1:	89 e5                	mov    %esp,%ebp
  8001b3:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001b6:	83 ec 0c             	sub    $0xc,%esp
  8001b9:	6a 00                	push   $0x0
  8001bb:	e8 df 0e 00 00       	call   80109f <sys_env_destroy>
  8001c0:	83 c4 10             	add    $0x10,%esp
}
  8001c3:	90                   	nop
  8001c4:	c9                   	leave  
  8001c5:	c3                   	ret    

008001c6 <exit>:

void
exit(void)
{
  8001c6:	55                   	push   %ebp
  8001c7:	89 e5                	mov    %esp,%ebp
  8001c9:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001cc:	e8 34 0f 00 00       	call   801105 <sys_env_exit>
}
  8001d1:	90                   	nop
  8001d2:	c9                   	leave  
  8001d3:	c3                   	ret    

008001d4 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001d4:	55                   	push   %ebp
  8001d5:	89 e5                	mov    %esp,%ebp
  8001d7:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001dd:	8b 00                	mov    (%eax),%eax
  8001df:	8d 48 01             	lea    0x1(%eax),%ecx
  8001e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001e5:	89 0a                	mov    %ecx,(%edx)
  8001e7:	8b 55 08             	mov    0x8(%ebp),%edx
  8001ea:	88 d1                	mov    %dl,%cl
  8001ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001ef:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f6:	8b 00                	mov    (%eax),%eax
  8001f8:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001fd:	75 2c                	jne    80022b <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001ff:	a0 24 20 80 00       	mov    0x802024,%al
  800204:	0f b6 c0             	movzbl %al,%eax
  800207:	8b 55 0c             	mov    0xc(%ebp),%edx
  80020a:	8b 12                	mov    (%edx),%edx
  80020c:	89 d1                	mov    %edx,%ecx
  80020e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800211:	83 c2 08             	add    $0x8,%edx
  800214:	83 ec 04             	sub    $0x4,%esp
  800217:	50                   	push   %eax
  800218:	51                   	push   %ecx
  800219:	52                   	push   %edx
  80021a:	e8 3e 0e 00 00       	call   80105d <sys_cputs>
  80021f:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800222:	8b 45 0c             	mov    0xc(%ebp),%eax
  800225:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80022b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80022e:	8b 40 04             	mov    0x4(%eax),%eax
  800231:	8d 50 01             	lea    0x1(%eax),%edx
  800234:	8b 45 0c             	mov    0xc(%ebp),%eax
  800237:	89 50 04             	mov    %edx,0x4(%eax)
}
  80023a:	90                   	nop
  80023b:	c9                   	leave  
  80023c:	c3                   	ret    

0080023d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80023d:	55                   	push   %ebp
  80023e:	89 e5                	mov    %esp,%ebp
  800240:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800246:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80024d:	00 00 00 
	b.cnt = 0;
  800250:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800257:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80025a:	ff 75 0c             	pushl  0xc(%ebp)
  80025d:	ff 75 08             	pushl  0x8(%ebp)
  800260:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800266:	50                   	push   %eax
  800267:	68 d4 01 80 00       	push   $0x8001d4
  80026c:	e8 11 02 00 00       	call   800482 <vprintfmt>
  800271:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800274:	a0 24 20 80 00       	mov    0x802024,%al
  800279:	0f b6 c0             	movzbl %al,%eax
  80027c:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800282:	83 ec 04             	sub    $0x4,%esp
  800285:	50                   	push   %eax
  800286:	52                   	push   %edx
  800287:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80028d:	83 c0 08             	add    $0x8,%eax
  800290:	50                   	push   %eax
  800291:	e8 c7 0d 00 00       	call   80105d <sys_cputs>
  800296:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800299:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  8002a0:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002a6:	c9                   	leave  
  8002a7:	c3                   	ret    

008002a8 <cprintf>:

int cprintf(const char *fmt, ...) {
  8002a8:	55                   	push   %ebp
  8002a9:	89 e5                	mov    %esp,%ebp
  8002ab:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002ae:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  8002b5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8002be:	83 ec 08             	sub    $0x8,%esp
  8002c1:	ff 75 f4             	pushl  -0xc(%ebp)
  8002c4:	50                   	push   %eax
  8002c5:	e8 73 ff ff ff       	call   80023d <vcprintf>
  8002ca:	83 c4 10             	add    $0x10,%esp
  8002cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002d3:	c9                   	leave  
  8002d4:	c3                   	ret    

008002d5 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002d5:	55                   	push   %ebp
  8002d6:	89 e5                	mov    %esp,%ebp
  8002d8:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002db:	e8 8e 0f 00 00       	call   80126e <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002e0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e9:	83 ec 08             	sub    $0x8,%esp
  8002ec:	ff 75 f4             	pushl  -0xc(%ebp)
  8002ef:	50                   	push   %eax
  8002f0:	e8 48 ff ff ff       	call   80023d <vcprintf>
  8002f5:	83 c4 10             	add    $0x10,%esp
  8002f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002fb:	e8 88 0f 00 00       	call   801288 <sys_enable_interrupt>
	return cnt;
  800300:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800303:	c9                   	leave  
  800304:	c3                   	ret    

00800305 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800305:	55                   	push   %ebp
  800306:	89 e5                	mov    %esp,%ebp
  800308:	53                   	push   %ebx
  800309:	83 ec 14             	sub    $0x14,%esp
  80030c:	8b 45 10             	mov    0x10(%ebp),%eax
  80030f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800312:	8b 45 14             	mov    0x14(%ebp),%eax
  800315:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800318:	8b 45 18             	mov    0x18(%ebp),%eax
  80031b:	ba 00 00 00 00       	mov    $0x0,%edx
  800320:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800323:	77 55                	ja     80037a <printnum+0x75>
  800325:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800328:	72 05                	jb     80032f <printnum+0x2a>
  80032a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80032d:	77 4b                	ja     80037a <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80032f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800332:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800335:	8b 45 18             	mov    0x18(%ebp),%eax
  800338:	ba 00 00 00 00       	mov    $0x0,%edx
  80033d:	52                   	push   %edx
  80033e:	50                   	push   %eax
  80033f:	ff 75 f4             	pushl  -0xc(%ebp)
  800342:	ff 75 f0             	pushl  -0x10(%ebp)
  800345:	e8 62 13 00 00       	call   8016ac <__udivdi3>
  80034a:	83 c4 10             	add    $0x10,%esp
  80034d:	83 ec 04             	sub    $0x4,%esp
  800350:	ff 75 20             	pushl  0x20(%ebp)
  800353:	53                   	push   %ebx
  800354:	ff 75 18             	pushl  0x18(%ebp)
  800357:	52                   	push   %edx
  800358:	50                   	push   %eax
  800359:	ff 75 0c             	pushl  0xc(%ebp)
  80035c:	ff 75 08             	pushl  0x8(%ebp)
  80035f:	e8 a1 ff ff ff       	call   800305 <printnum>
  800364:	83 c4 20             	add    $0x20,%esp
  800367:	eb 1a                	jmp    800383 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800369:	83 ec 08             	sub    $0x8,%esp
  80036c:	ff 75 0c             	pushl  0xc(%ebp)
  80036f:	ff 75 20             	pushl  0x20(%ebp)
  800372:	8b 45 08             	mov    0x8(%ebp),%eax
  800375:	ff d0                	call   *%eax
  800377:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80037a:	ff 4d 1c             	decl   0x1c(%ebp)
  80037d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800381:	7f e6                	jg     800369 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800383:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800386:	bb 00 00 00 00       	mov    $0x0,%ebx
  80038b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80038e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800391:	53                   	push   %ebx
  800392:	51                   	push   %ecx
  800393:	52                   	push   %edx
  800394:	50                   	push   %eax
  800395:	e8 22 14 00 00       	call   8017bc <__umoddi3>
  80039a:	83 c4 10             	add    $0x10,%esp
  80039d:	05 14 1c 80 00       	add    $0x801c14,%eax
  8003a2:	8a 00                	mov    (%eax),%al
  8003a4:	0f be c0             	movsbl %al,%eax
  8003a7:	83 ec 08             	sub    $0x8,%esp
  8003aa:	ff 75 0c             	pushl  0xc(%ebp)
  8003ad:	50                   	push   %eax
  8003ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b1:	ff d0                	call   *%eax
  8003b3:	83 c4 10             	add    $0x10,%esp
}
  8003b6:	90                   	nop
  8003b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003ba:	c9                   	leave  
  8003bb:	c3                   	ret    

008003bc <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003bc:	55                   	push   %ebp
  8003bd:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003bf:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003c3:	7e 1c                	jle    8003e1 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c8:	8b 00                	mov    (%eax),%eax
  8003ca:	8d 50 08             	lea    0x8(%eax),%edx
  8003cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d0:	89 10                	mov    %edx,(%eax)
  8003d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d5:	8b 00                	mov    (%eax),%eax
  8003d7:	83 e8 08             	sub    $0x8,%eax
  8003da:	8b 50 04             	mov    0x4(%eax),%edx
  8003dd:	8b 00                	mov    (%eax),%eax
  8003df:	eb 40                	jmp    800421 <getuint+0x65>
	else if (lflag)
  8003e1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003e5:	74 1e                	je     800405 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ea:	8b 00                	mov    (%eax),%eax
  8003ec:	8d 50 04             	lea    0x4(%eax),%edx
  8003ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f2:	89 10                	mov    %edx,(%eax)
  8003f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f7:	8b 00                	mov    (%eax),%eax
  8003f9:	83 e8 04             	sub    $0x4,%eax
  8003fc:	8b 00                	mov    (%eax),%eax
  8003fe:	ba 00 00 00 00       	mov    $0x0,%edx
  800403:	eb 1c                	jmp    800421 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800405:	8b 45 08             	mov    0x8(%ebp),%eax
  800408:	8b 00                	mov    (%eax),%eax
  80040a:	8d 50 04             	lea    0x4(%eax),%edx
  80040d:	8b 45 08             	mov    0x8(%ebp),%eax
  800410:	89 10                	mov    %edx,(%eax)
  800412:	8b 45 08             	mov    0x8(%ebp),%eax
  800415:	8b 00                	mov    (%eax),%eax
  800417:	83 e8 04             	sub    $0x4,%eax
  80041a:	8b 00                	mov    (%eax),%eax
  80041c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800421:	5d                   	pop    %ebp
  800422:	c3                   	ret    

00800423 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800423:	55                   	push   %ebp
  800424:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800426:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80042a:	7e 1c                	jle    800448 <getint+0x25>
		return va_arg(*ap, long long);
  80042c:	8b 45 08             	mov    0x8(%ebp),%eax
  80042f:	8b 00                	mov    (%eax),%eax
  800431:	8d 50 08             	lea    0x8(%eax),%edx
  800434:	8b 45 08             	mov    0x8(%ebp),%eax
  800437:	89 10                	mov    %edx,(%eax)
  800439:	8b 45 08             	mov    0x8(%ebp),%eax
  80043c:	8b 00                	mov    (%eax),%eax
  80043e:	83 e8 08             	sub    $0x8,%eax
  800441:	8b 50 04             	mov    0x4(%eax),%edx
  800444:	8b 00                	mov    (%eax),%eax
  800446:	eb 38                	jmp    800480 <getint+0x5d>
	else if (lflag)
  800448:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80044c:	74 1a                	je     800468 <getint+0x45>
		return va_arg(*ap, long);
  80044e:	8b 45 08             	mov    0x8(%ebp),%eax
  800451:	8b 00                	mov    (%eax),%eax
  800453:	8d 50 04             	lea    0x4(%eax),%edx
  800456:	8b 45 08             	mov    0x8(%ebp),%eax
  800459:	89 10                	mov    %edx,(%eax)
  80045b:	8b 45 08             	mov    0x8(%ebp),%eax
  80045e:	8b 00                	mov    (%eax),%eax
  800460:	83 e8 04             	sub    $0x4,%eax
  800463:	8b 00                	mov    (%eax),%eax
  800465:	99                   	cltd   
  800466:	eb 18                	jmp    800480 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800468:	8b 45 08             	mov    0x8(%ebp),%eax
  80046b:	8b 00                	mov    (%eax),%eax
  80046d:	8d 50 04             	lea    0x4(%eax),%edx
  800470:	8b 45 08             	mov    0x8(%ebp),%eax
  800473:	89 10                	mov    %edx,(%eax)
  800475:	8b 45 08             	mov    0x8(%ebp),%eax
  800478:	8b 00                	mov    (%eax),%eax
  80047a:	83 e8 04             	sub    $0x4,%eax
  80047d:	8b 00                	mov    (%eax),%eax
  80047f:	99                   	cltd   
}
  800480:	5d                   	pop    %ebp
  800481:	c3                   	ret    

00800482 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800482:	55                   	push   %ebp
  800483:	89 e5                	mov    %esp,%ebp
  800485:	56                   	push   %esi
  800486:	53                   	push   %ebx
  800487:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80048a:	eb 17                	jmp    8004a3 <vprintfmt+0x21>
			if (ch == '\0')
  80048c:	85 db                	test   %ebx,%ebx
  80048e:	0f 84 af 03 00 00    	je     800843 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800494:	83 ec 08             	sub    $0x8,%esp
  800497:	ff 75 0c             	pushl  0xc(%ebp)
  80049a:	53                   	push   %ebx
  80049b:	8b 45 08             	mov    0x8(%ebp),%eax
  80049e:	ff d0                	call   *%eax
  8004a0:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8004a6:	8d 50 01             	lea    0x1(%eax),%edx
  8004a9:	89 55 10             	mov    %edx,0x10(%ebp)
  8004ac:	8a 00                	mov    (%eax),%al
  8004ae:	0f b6 d8             	movzbl %al,%ebx
  8004b1:	83 fb 25             	cmp    $0x25,%ebx
  8004b4:	75 d6                	jne    80048c <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004b6:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004ba:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004c1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004c8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004cf:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8004d9:	8d 50 01             	lea    0x1(%eax),%edx
  8004dc:	89 55 10             	mov    %edx,0x10(%ebp)
  8004df:	8a 00                	mov    (%eax),%al
  8004e1:	0f b6 d8             	movzbl %al,%ebx
  8004e4:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004e7:	83 f8 55             	cmp    $0x55,%eax
  8004ea:	0f 87 2b 03 00 00    	ja     80081b <vprintfmt+0x399>
  8004f0:	8b 04 85 38 1c 80 00 	mov    0x801c38(,%eax,4),%eax
  8004f7:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004f9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004fd:	eb d7                	jmp    8004d6 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004ff:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800503:	eb d1                	jmp    8004d6 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800505:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80050c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80050f:	89 d0                	mov    %edx,%eax
  800511:	c1 e0 02             	shl    $0x2,%eax
  800514:	01 d0                	add    %edx,%eax
  800516:	01 c0                	add    %eax,%eax
  800518:	01 d8                	add    %ebx,%eax
  80051a:	83 e8 30             	sub    $0x30,%eax
  80051d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800520:	8b 45 10             	mov    0x10(%ebp),%eax
  800523:	8a 00                	mov    (%eax),%al
  800525:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800528:	83 fb 2f             	cmp    $0x2f,%ebx
  80052b:	7e 3e                	jle    80056b <vprintfmt+0xe9>
  80052d:	83 fb 39             	cmp    $0x39,%ebx
  800530:	7f 39                	jg     80056b <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800532:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800535:	eb d5                	jmp    80050c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800537:	8b 45 14             	mov    0x14(%ebp),%eax
  80053a:	83 c0 04             	add    $0x4,%eax
  80053d:	89 45 14             	mov    %eax,0x14(%ebp)
  800540:	8b 45 14             	mov    0x14(%ebp),%eax
  800543:	83 e8 04             	sub    $0x4,%eax
  800546:	8b 00                	mov    (%eax),%eax
  800548:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80054b:	eb 1f                	jmp    80056c <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80054d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800551:	79 83                	jns    8004d6 <vprintfmt+0x54>
				width = 0;
  800553:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80055a:	e9 77 ff ff ff       	jmp    8004d6 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80055f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800566:	e9 6b ff ff ff       	jmp    8004d6 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80056b:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80056c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800570:	0f 89 60 ff ff ff    	jns    8004d6 <vprintfmt+0x54>
				width = precision, precision = -1;
  800576:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800579:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80057c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800583:	e9 4e ff ff ff       	jmp    8004d6 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800588:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80058b:	e9 46 ff ff ff       	jmp    8004d6 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800590:	8b 45 14             	mov    0x14(%ebp),%eax
  800593:	83 c0 04             	add    $0x4,%eax
  800596:	89 45 14             	mov    %eax,0x14(%ebp)
  800599:	8b 45 14             	mov    0x14(%ebp),%eax
  80059c:	83 e8 04             	sub    $0x4,%eax
  80059f:	8b 00                	mov    (%eax),%eax
  8005a1:	83 ec 08             	sub    $0x8,%esp
  8005a4:	ff 75 0c             	pushl  0xc(%ebp)
  8005a7:	50                   	push   %eax
  8005a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ab:	ff d0                	call   *%eax
  8005ad:	83 c4 10             	add    $0x10,%esp
			break;
  8005b0:	e9 89 02 00 00       	jmp    80083e <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b8:	83 c0 04             	add    $0x4,%eax
  8005bb:	89 45 14             	mov    %eax,0x14(%ebp)
  8005be:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c1:	83 e8 04             	sub    $0x4,%eax
  8005c4:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005c6:	85 db                	test   %ebx,%ebx
  8005c8:	79 02                	jns    8005cc <vprintfmt+0x14a>
				err = -err;
  8005ca:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005cc:	83 fb 64             	cmp    $0x64,%ebx
  8005cf:	7f 0b                	jg     8005dc <vprintfmt+0x15a>
  8005d1:	8b 34 9d 80 1a 80 00 	mov    0x801a80(,%ebx,4),%esi
  8005d8:	85 f6                	test   %esi,%esi
  8005da:	75 19                	jne    8005f5 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005dc:	53                   	push   %ebx
  8005dd:	68 25 1c 80 00       	push   $0x801c25
  8005e2:	ff 75 0c             	pushl  0xc(%ebp)
  8005e5:	ff 75 08             	pushl  0x8(%ebp)
  8005e8:	e8 5e 02 00 00       	call   80084b <printfmt>
  8005ed:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005f0:	e9 49 02 00 00       	jmp    80083e <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005f5:	56                   	push   %esi
  8005f6:	68 2e 1c 80 00       	push   $0x801c2e
  8005fb:	ff 75 0c             	pushl  0xc(%ebp)
  8005fe:	ff 75 08             	pushl  0x8(%ebp)
  800601:	e8 45 02 00 00       	call   80084b <printfmt>
  800606:	83 c4 10             	add    $0x10,%esp
			break;
  800609:	e9 30 02 00 00       	jmp    80083e <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80060e:	8b 45 14             	mov    0x14(%ebp),%eax
  800611:	83 c0 04             	add    $0x4,%eax
  800614:	89 45 14             	mov    %eax,0x14(%ebp)
  800617:	8b 45 14             	mov    0x14(%ebp),%eax
  80061a:	83 e8 04             	sub    $0x4,%eax
  80061d:	8b 30                	mov    (%eax),%esi
  80061f:	85 f6                	test   %esi,%esi
  800621:	75 05                	jne    800628 <vprintfmt+0x1a6>
				p = "(null)";
  800623:	be 31 1c 80 00       	mov    $0x801c31,%esi
			if (width > 0 && padc != '-')
  800628:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80062c:	7e 6d                	jle    80069b <vprintfmt+0x219>
  80062e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800632:	74 67                	je     80069b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800634:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800637:	83 ec 08             	sub    $0x8,%esp
  80063a:	50                   	push   %eax
  80063b:	56                   	push   %esi
  80063c:	e8 0c 03 00 00       	call   80094d <strnlen>
  800641:	83 c4 10             	add    $0x10,%esp
  800644:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800647:	eb 16                	jmp    80065f <vprintfmt+0x1dd>
					putch(padc, putdat);
  800649:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80064d:	83 ec 08             	sub    $0x8,%esp
  800650:	ff 75 0c             	pushl  0xc(%ebp)
  800653:	50                   	push   %eax
  800654:	8b 45 08             	mov    0x8(%ebp),%eax
  800657:	ff d0                	call   *%eax
  800659:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80065c:	ff 4d e4             	decl   -0x1c(%ebp)
  80065f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800663:	7f e4                	jg     800649 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800665:	eb 34                	jmp    80069b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800667:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80066b:	74 1c                	je     800689 <vprintfmt+0x207>
  80066d:	83 fb 1f             	cmp    $0x1f,%ebx
  800670:	7e 05                	jle    800677 <vprintfmt+0x1f5>
  800672:	83 fb 7e             	cmp    $0x7e,%ebx
  800675:	7e 12                	jle    800689 <vprintfmt+0x207>
					putch('?', putdat);
  800677:	83 ec 08             	sub    $0x8,%esp
  80067a:	ff 75 0c             	pushl  0xc(%ebp)
  80067d:	6a 3f                	push   $0x3f
  80067f:	8b 45 08             	mov    0x8(%ebp),%eax
  800682:	ff d0                	call   *%eax
  800684:	83 c4 10             	add    $0x10,%esp
  800687:	eb 0f                	jmp    800698 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800689:	83 ec 08             	sub    $0x8,%esp
  80068c:	ff 75 0c             	pushl  0xc(%ebp)
  80068f:	53                   	push   %ebx
  800690:	8b 45 08             	mov    0x8(%ebp),%eax
  800693:	ff d0                	call   *%eax
  800695:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800698:	ff 4d e4             	decl   -0x1c(%ebp)
  80069b:	89 f0                	mov    %esi,%eax
  80069d:	8d 70 01             	lea    0x1(%eax),%esi
  8006a0:	8a 00                	mov    (%eax),%al
  8006a2:	0f be d8             	movsbl %al,%ebx
  8006a5:	85 db                	test   %ebx,%ebx
  8006a7:	74 24                	je     8006cd <vprintfmt+0x24b>
  8006a9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006ad:	78 b8                	js     800667 <vprintfmt+0x1e5>
  8006af:	ff 4d e0             	decl   -0x20(%ebp)
  8006b2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006b6:	79 af                	jns    800667 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006b8:	eb 13                	jmp    8006cd <vprintfmt+0x24b>
				putch(' ', putdat);
  8006ba:	83 ec 08             	sub    $0x8,%esp
  8006bd:	ff 75 0c             	pushl  0xc(%ebp)
  8006c0:	6a 20                	push   $0x20
  8006c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c5:	ff d0                	call   *%eax
  8006c7:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006ca:	ff 4d e4             	decl   -0x1c(%ebp)
  8006cd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006d1:	7f e7                	jg     8006ba <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006d3:	e9 66 01 00 00       	jmp    80083e <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006d8:	83 ec 08             	sub    $0x8,%esp
  8006db:	ff 75 e8             	pushl  -0x18(%ebp)
  8006de:	8d 45 14             	lea    0x14(%ebp),%eax
  8006e1:	50                   	push   %eax
  8006e2:	e8 3c fd ff ff       	call   800423 <getint>
  8006e7:	83 c4 10             	add    $0x10,%esp
  8006ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006ed:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006f3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006f6:	85 d2                	test   %edx,%edx
  8006f8:	79 23                	jns    80071d <vprintfmt+0x29b>
				putch('-', putdat);
  8006fa:	83 ec 08             	sub    $0x8,%esp
  8006fd:	ff 75 0c             	pushl  0xc(%ebp)
  800700:	6a 2d                	push   $0x2d
  800702:	8b 45 08             	mov    0x8(%ebp),%eax
  800705:	ff d0                	call   *%eax
  800707:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80070a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80070d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800710:	f7 d8                	neg    %eax
  800712:	83 d2 00             	adc    $0x0,%edx
  800715:	f7 da                	neg    %edx
  800717:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80071a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80071d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800724:	e9 bc 00 00 00       	jmp    8007e5 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800729:	83 ec 08             	sub    $0x8,%esp
  80072c:	ff 75 e8             	pushl  -0x18(%ebp)
  80072f:	8d 45 14             	lea    0x14(%ebp),%eax
  800732:	50                   	push   %eax
  800733:	e8 84 fc ff ff       	call   8003bc <getuint>
  800738:	83 c4 10             	add    $0x10,%esp
  80073b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80073e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800741:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800748:	e9 98 00 00 00       	jmp    8007e5 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80074d:	83 ec 08             	sub    $0x8,%esp
  800750:	ff 75 0c             	pushl  0xc(%ebp)
  800753:	6a 58                	push   $0x58
  800755:	8b 45 08             	mov    0x8(%ebp),%eax
  800758:	ff d0                	call   *%eax
  80075a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80075d:	83 ec 08             	sub    $0x8,%esp
  800760:	ff 75 0c             	pushl  0xc(%ebp)
  800763:	6a 58                	push   $0x58
  800765:	8b 45 08             	mov    0x8(%ebp),%eax
  800768:	ff d0                	call   *%eax
  80076a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80076d:	83 ec 08             	sub    $0x8,%esp
  800770:	ff 75 0c             	pushl  0xc(%ebp)
  800773:	6a 58                	push   $0x58
  800775:	8b 45 08             	mov    0x8(%ebp),%eax
  800778:	ff d0                	call   *%eax
  80077a:	83 c4 10             	add    $0x10,%esp
			break;
  80077d:	e9 bc 00 00 00       	jmp    80083e <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800782:	83 ec 08             	sub    $0x8,%esp
  800785:	ff 75 0c             	pushl  0xc(%ebp)
  800788:	6a 30                	push   $0x30
  80078a:	8b 45 08             	mov    0x8(%ebp),%eax
  80078d:	ff d0                	call   *%eax
  80078f:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800792:	83 ec 08             	sub    $0x8,%esp
  800795:	ff 75 0c             	pushl  0xc(%ebp)
  800798:	6a 78                	push   $0x78
  80079a:	8b 45 08             	mov    0x8(%ebp),%eax
  80079d:	ff d0                	call   *%eax
  80079f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a5:	83 c0 04             	add    $0x4,%eax
  8007a8:	89 45 14             	mov    %eax,0x14(%ebp)
  8007ab:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ae:	83 e8 04             	sub    $0x4,%eax
  8007b1:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007bd:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007c4:	eb 1f                	jmp    8007e5 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007c6:	83 ec 08             	sub    $0x8,%esp
  8007c9:	ff 75 e8             	pushl  -0x18(%ebp)
  8007cc:	8d 45 14             	lea    0x14(%ebp),%eax
  8007cf:	50                   	push   %eax
  8007d0:	e8 e7 fb ff ff       	call   8003bc <getuint>
  8007d5:	83 c4 10             	add    $0x10,%esp
  8007d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007db:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007de:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007e5:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007ec:	83 ec 04             	sub    $0x4,%esp
  8007ef:	52                   	push   %edx
  8007f0:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007f3:	50                   	push   %eax
  8007f4:	ff 75 f4             	pushl  -0xc(%ebp)
  8007f7:	ff 75 f0             	pushl  -0x10(%ebp)
  8007fa:	ff 75 0c             	pushl  0xc(%ebp)
  8007fd:	ff 75 08             	pushl  0x8(%ebp)
  800800:	e8 00 fb ff ff       	call   800305 <printnum>
  800805:	83 c4 20             	add    $0x20,%esp
			break;
  800808:	eb 34                	jmp    80083e <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80080a:	83 ec 08             	sub    $0x8,%esp
  80080d:	ff 75 0c             	pushl  0xc(%ebp)
  800810:	53                   	push   %ebx
  800811:	8b 45 08             	mov    0x8(%ebp),%eax
  800814:	ff d0                	call   *%eax
  800816:	83 c4 10             	add    $0x10,%esp
			break;
  800819:	eb 23                	jmp    80083e <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80081b:	83 ec 08             	sub    $0x8,%esp
  80081e:	ff 75 0c             	pushl  0xc(%ebp)
  800821:	6a 25                	push   $0x25
  800823:	8b 45 08             	mov    0x8(%ebp),%eax
  800826:	ff d0                	call   *%eax
  800828:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80082b:	ff 4d 10             	decl   0x10(%ebp)
  80082e:	eb 03                	jmp    800833 <vprintfmt+0x3b1>
  800830:	ff 4d 10             	decl   0x10(%ebp)
  800833:	8b 45 10             	mov    0x10(%ebp),%eax
  800836:	48                   	dec    %eax
  800837:	8a 00                	mov    (%eax),%al
  800839:	3c 25                	cmp    $0x25,%al
  80083b:	75 f3                	jne    800830 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80083d:	90                   	nop
		}
	}
  80083e:	e9 47 fc ff ff       	jmp    80048a <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800843:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800844:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800847:	5b                   	pop    %ebx
  800848:	5e                   	pop    %esi
  800849:	5d                   	pop    %ebp
  80084a:	c3                   	ret    

0080084b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80084b:	55                   	push   %ebp
  80084c:	89 e5                	mov    %esp,%ebp
  80084e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800851:	8d 45 10             	lea    0x10(%ebp),%eax
  800854:	83 c0 04             	add    $0x4,%eax
  800857:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80085a:	8b 45 10             	mov    0x10(%ebp),%eax
  80085d:	ff 75 f4             	pushl  -0xc(%ebp)
  800860:	50                   	push   %eax
  800861:	ff 75 0c             	pushl  0xc(%ebp)
  800864:	ff 75 08             	pushl  0x8(%ebp)
  800867:	e8 16 fc ff ff       	call   800482 <vprintfmt>
  80086c:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80086f:	90                   	nop
  800870:	c9                   	leave  
  800871:	c3                   	ret    

00800872 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800872:	55                   	push   %ebp
  800873:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800875:	8b 45 0c             	mov    0xc(%ebp),%eax
  800878:	8b 40 08             	mov    0x8(%eax),%eax
  80087b:	8d 50 01             	lea    0x1(%eax),%edx
  80087e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800881:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800884:	8b 45 0c             	mov    0xc(%ebp),%eax
  800887:	8b 10                	mov    (%eax),%edx
  800889:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088c:	8b 40 04             	mov    0x4(%eax),%eax
  80088f:	39 c2                	cmp    %eax,%edx
  800891:	73 12                	jae    8008a5 <sprintputch+0x33>
		*b->buf++ = ch;
  800893:	8b 45 0c             	mov    0xc(%ebp),%eax
  800896:	8b 00                	mov    (%eax),%eax
  800898:	8d 48 01             	lea    0x1(%eax),%ecx
  80089b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80089e:	89 0a                	mov    %ecx,(%edx)
  8008a0:	8b 55 08             	mov    0x8(%ebp),%edx
  8008a3:	88 10                	mov    %dl,(%eax)
}
  8008a5:	90                   	nop
  8008a6:	5d                   	pop    %ebp
  8008a7:	c3                   	ret    

008008a8 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008a8:	55                   	push   %ebp
  8008a9:	89 e5                	mov    %esp,%ebp
  8008ab:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8008bd:	01 d0                	add    %edx,%eax
  8008bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008c9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008cd:	74 06                	je     8008d5 <vsnprintf+0x2d>
  8008cf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008d3:	7f 07                	jg     8008dc <vsnprintf+0x34>
		return -E_INVAL;
  8008d5:	b8 03 00 00 00       	mov    $0x3,%eax
  8008da:	eb 20                	jmp    8008fc <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008dc:	ff 75 14             	pushl  0x14(%ebp)
  8008df:	ff 75 10             	pushl  0x10(%ebp)
  8008e2:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008e5:	50                   	push   %eax
  8008e6:	68 72 08 80 00       	push   $0x800872
  8008eb:	e8 92 fb ff ff       	call   800482 <vprintfmt>
  8008f0:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008f6:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008fc:	c9                   	leave  
  8008fd:	c3                   	ret    

008008fe <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008fe:	55                   	push   %ebp
  8008ff:	89 e5                	mov    %esp,%ebp
  800901:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800904:	8d 45 10             	lea    0x10(%ebp),%eax
  800907:	83 c0 04             	add    $0x4,%eax
  80090a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80090d:	8b 45 10             	mov    0x10(%ebp),%eax
  800910:	ff 75 f4             	pushl  -0xc(%ebp)
  800913:	50                   	push   %eax
  800914:	ff 75 0c             	pushl  0xc(%ebp)
  800917:	ff 75 08             	pushl  0x8(%ebp)
  80091a:	e8 89 ff ff ff       	call   8008a8 <vsnprintf>
  80091f:	83 c4 10             	add    $0x10,%esp
  800922:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800925:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800928:	c9                   	leave  
  800929:	c3                   	ret    

0080092a <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80092a:	55                   	push   %ebp
  80092b:	89 e5                	mov    %esp,%ebp
  80092d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800930:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800937:	eb 06                	jmp    80093f <strlen+0x15>
		n++;
  800939:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80093c:	ff 45 08             	incl   0x8(%ebp)
  80093f:	8b 45 08             	mov    0x8(%ebp),%eax
  800942:	8a 00                	mov    (%eax),%al
  800944:	84 c0                	test   %al,%al
  800946:	75 f1                	jne    800939 <strlen+0xf>
		n++;
	return n;
  800948:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80094b:	c9                   	leave  
  80094c:	c3                   	ret    

0080094d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80094d:	55                   	push   %ebp
  80094e:	89 e5                	mov    %esp,%ebp
  800950:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800953:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80095a:	eb 09                	jmp    800965 <strnlen+0x18>
		n++;
  80095c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80095f:	ff 45 08             	incl   0x8(%ebp)
  800962:	ff 4d 0c             	decl   0xc(%ebp)
  800965:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800969:	74 09                	je     800974 <strnlen+0x27>
  80096b:	8b 45 08             	mov    0x8(%ebp),%eax
  80096e:	8a 00                	mov    (%eax),%al
  800970:	84 c0                	test   %al,%al
  800972:	75 e8                	jne    80095c <strnlen+0xf>
		n++;
	return n;
  800974:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800977:	c9                   	leave  
  800978:	c3                   	ret    

00800979 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800979:	55                   	push   %ebp
  80097a:	89 e5                	mov    %esp,%ebp
  80097c:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80097f:	8b 45 08             	mov    0x8(%ebp),%eax
  800982:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800985:	90                   	nop
  800986:	8b 45 08             	mov    0x8(%ebp),%eax
  800989:	8d 50 01             	lea    0x1(%eax),%edx
  80098c:	89 55 08             	mov    %edx,0x8(%ebp)
  80098f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800992:	8d 4a 01             	lea    0x1(%edx),%ecx
  800995:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800998:	8a 12                	mov    (%edx),%dl
  80099a:	88 10                	mov    %dl,(%eax)
  80099c:	8a 00                	mov    (%eax),%al
  80099e:	84 c0                	test   %al,%al
  8009a0:	75 e4                	jne    800986 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8009a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009a5:	c9                   	leave  
  8009a6:	c3                   	ret    

008009a7 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8009a7:	55                   	push   %ebp
  8009a8:	89 e5                	mov    %esp,%ebp
  8009aa:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8009ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009ba:	eb 1f                	jmp    8009db <strncpy+0x34>
		*dst++ = *src;
  8009bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bf:	8d 50 01             	lea    0x1(%eax),%edx
  8009c2:	89 55 08             	mov    %edx,0x8(%ebp)
  8009c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009c8:	8a 12                	mov    (%edx),%dl
  8009ca:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009cf:	8a 00                	mov    (%eax),%al
  8009d1:	84 c0                	test   %al,%al
  8009d3:	74 03                	je     8009d8 <strncpy+0x31>
			src++;
  8009d5:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009d8:	ff 45 fc             	incl   -0x4(%ebp)
  8009db:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009de:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009e1:	72 d9                	jb     8009bc <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009e6:	c9                   	leave  
  8009e7:	c3                   	ret    

008009e8 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009e8:	55                   	push   %ebp
  8009e9:	89 e5                	mov    %esp,%ebp
  8009eb:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009f4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009f8:	74 30                	je     800a2a <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009fa:	eb 16                	jmp    800a12 <strlcpy+0x2a>
			*dst++ = *src++;
  8009fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ff:	8d 50 01             	lea    0x1(%eax),%edx
  800a02:	89 55 08             	mov    %edx,0x8(%ebp)
  800a05:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a08:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a0b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a0e:	8a 12                	mov    (%edx),%dl
  800a10:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a12:	ff 4d 10             	decl   0x10(%ebp)
  800a15:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a19:	74 09                	je     800a24 <strlcpy+0x3c>
  800a1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a1e:	8a 00                	mov    (%eax),%al
  800a20:	84 c0                	test   %al,%al
  800a22:	75 d8                	jne    8009fc <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a24:	8b 45 08             	mov    0x8(%ebp),%eax
  800a27:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a2a:	8b 55 08             	mov    0x8(%ebp),%edx
  800a2d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a30:	29 c2                	sub    %eax,%edx
  800a32:	89 d0                	mov    %edx,%eax
}
  800a34:	c9                   	leave  
  800a35:	c3                   	ret    

00800a36 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a36:	55                   	push   %ebp
  800a37:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a39:	eb 06                	jmp    800a41 <strcmp+0xb>
		p++, q++;
  800a3b:	ff 45 08             	incl   0x8(%ebp)
  800a3e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a41:	8b 45 08             	mov    0x8(%ebp),%eax
  800a44:	8a 00                	mov    (%eax),%al
  800a46:	84 c0                	test   %al,%al
  800a48:	74 0e                	je     800a58 <strcmp+0x22>
  800a4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4d:	8a 10                	mov    (%eax),%dl
  800a4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a52:	8a 00                	mov    (%eax),%al
  800a54:	38 c2                	cmp    %al,%dl
  800a56:	74 e3                	je     800a3b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a58:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5b:	8a 00                	mov    (%eax),%al
  800a5d:	0f b6 d0             	movzbl %al,%edx
  800a60:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a63:	8a 00                	mov    (%eax),%al
  800a65:	0f b6 c0             	movzbl %al,%eax
  800a68:	29 c2                	sub    %eax,%edx
  800a6a:	89 d0                	mov    %edx,%eax
}
  800a6c:	5d                   	pop    %ebp
  800a6d:	c3                   	ret    

00800a6e <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a6e:	55                   	push   %ebp
  800a6f:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a71:	eb 09                	jmp    800a7c <strncmp+0xe>
		n--, p++, q++;
  800a73:	ff 4d 10             	decl   0x10(%ebp)
  800a76:	ff 45 08             	incl   0x8(%ebp)
  800a79:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a7c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a80:	74 17                	je     800a99 <strncmp+0x2b>
  800a82:	8b 45 08             	mov    0x8(%ebp),%eax
  800a85:	8a 00                	mov    (%eax),%al
  800a87:	84 c0                	test   %al,%al
  800a89:	74 0e                	je     800a99 <strncmp+0x2b>
  800a8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8e:	8a 10                	mov    (%eax),%dl
  800a90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a93:	8a 00                	mov    (%eax),%al
  800a95:	38 c2                	cmp    %al,%dl
  800a97:	74 da                	je     800a73 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a99:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a9d:	75 07                	jne    800aa6 <strncmp+0x38>
		return 0;
  800a9f:	b8 00 00 00 00       	mov    $0x0,%eax
  800aa4:	eb 14                	jmp    800aba <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800aa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa9:	8a 00                	mov    (%eax),%al
  800aab:	0f b6 d0             	movzbl %al,%edx
  800aae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab1:	8a 00                	mov    (%eax),%al
  800ab3:	0f b6 c0             	movzbl %al,%eax
  800ab6:	29 c2                	sub    %eax,%edx
  800ab8:	89 d0                	mov    %edx,%eax
}
  800aba:	5d                   	pop    %ebp
  800abb:	c3                   	ret    

00800abc <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800abc:	55                   	push   %ebp
  800abd:	89 e5                	mov    %esp,%ebp
  800abf:	83 ec 04             	sub    $0x4,%esp
  800ac2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ac8:	eb 12                	jmp    800adc <strchr+0x20>
		if (*s == c)
  800aca:	8b 45 08             	mov    0x8(%ebp),%eax
  800acd:	8a 00                	mov    (%eax),%al
  800acf:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ad2:	75 05                	jne    800ad9 <strchr+0x1d>
			return (char *) s;
  800ad4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad7:	eb 11                	jmp    800aea <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ad9:	ff 45 08             	incl   0x8(%ebp)
  800adc:	8b 45 08             	mov    0x8(%ebp),%eax
  800adf:	8a 00                	mov    (%eax),%al
  800ae1:	84 c0                	test   %al,%al
  800ae3:	75 e5                	jne    800aca <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ae5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800aea:	c9                   	leave  
  800aeb:	c3                   	ret    

00800aec <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800aec:	55                   	push   %ebp
  800aed:	89 e5                	mov    %esp,%ebp
  800aef:	83 ec 04             	sub    $0x4,%esp
  800af2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800af8:	eb 0d                	jmp    800b07 <strfind+0x1b>
		if (*s == c)
  800afa:	8b 45 08             	mov    0x8(%ebp),%eax
  800afd:	8a 00                	mov    (%eax),%al
  800aff:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b02:	74 0e                	je     800b12 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b04:	ff 45 08             	incl   0x8(%ebp)
  800b07:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0a:	8a 00                	mov    (%eax),%al
  800b0c:	84 c0                	test   %al,%al
  800b0e:	75 ea                	jne    800afa <strfind+0xe>
  800b10:	eb 01                	jmp    800b13 <strfind+0x27>
		if (*s == c)
			break;
  800b12:	90                   	nop
	return (char *) s;
  800b13:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b16:	c9                   	leave  
  800b17:	c3                   	ret    

00800b18 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b18:	55                   	push   %ebp
  800b19:	89 e5                	mov    %esp,%ebp
  800b1b:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b21:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b24:	8b 45 10             	mov    0x10(%ebp),%eax
  800b27:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b2a:	eb 0e                	jmp    800b3a <memset+0x22>
		*p++ = c;
  800b2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b2f:	8d 50 01             	lea    0x1(%eax),%edx
  800b32:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b35:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b38:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b3a:	ff 4d f8             	decl   -0x8(%ebp)
  800b3d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b41:	79 e9                	jns    800b2c <memset+0x14>
		*p++ = c;

	return v;
  800b43:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b46:	c9                   	leave  
  800b47:	c3                   	ret    

00800b48 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
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
	while (n-- > 0)
  800b5a:	eb 16                	jmp    800b72 <memcpy+0x2a>
		*d++ = *s++;
  800b5c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b5f:	8d 50 01             	lea    0x1(%eax),%edx
  800b62:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b65:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b68:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b6b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b6e:	8a 12                	mov    (%edx),%dl
  800b70:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b72:	8b 45 10             	mov    0x10(%ebp),%eax
  800b75:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b78:	89 55 10             	mov    %edx,0x10(%ebp)
  800b7b:	85 c0                	test   %eax,%eax
  800b7d:	75 dd                	jne    800b5c <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b82:	c9                   	leave  
  800b83:	c3                   	ret    

00800b84 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b84:	55                   	push   %ebp
  800b85:	89 e5                	mov    %esp,%ebp
  800b87:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b90:	8b 45 08             	mov    0x8(%ebp),%eax
  800b93:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b96:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b99:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b9c:	73 50                	jae    800bee <memmove+0x6a>
  800b9e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ba1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba4:	01 d0                	add    %edx,%eax
  800ba6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ba9:	76 43                	jbe    800bee <memmove+0x6a>
		s += n;
  800bab:	8b 45 10             	mov    0x10(%ebp),%eax
  800bae:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800bb1:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb4:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800bb7:	eb 10                	jmp    800bc9 <memmove+0x45>
			*--d = *--s;
  800bb9:	ff 4d f8             	decl   -0x8(%ebp)
  800bbc:	ff 4d fc             	decl   -0x4(%ebp)
  800bbf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bc2:	8a 10                	mov    (%eax),%dl
  800bc4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bc7:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bc9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bcc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bcf:	89 55 10             	mov    %edx,0x10(%ebp)
  800bd2:	85 c0                	test   %eax,%eax
  800bd4:	75 e3                	jne    800bb9 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bd6:	eb 23                	jmp    800bfb <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bd8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bdb:	8d 50 01             	lea    0x1(%eax),%edx
  800bde:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800be1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800be4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800be7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bea:	8a 12                	mov    (%edx),%dl
  800bec:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bee:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bf4:	89 55 10             	mov    %edx,0x10(%ebp)
  800bf7:	85 c0                	test   %eax,%eax
  800bf9:	75 dd                	jne    800bd8 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bfb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bfe:	c9                   	leave  
  800bff:	c3                   	ret    

00800c00 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c00:	55                   	push   %ebp
  800c01:	89 e5                	mov    %esp,%ebp
  800c03:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c06:	8b 45 08             	mov    0x8(%ebp),%eax
  800c09:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0f:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c12:	eb 2a                	jmp    800c3e <memcmp+0x3e>
		if (*s1 != *s2)
  800c14:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c17:	8a 10                	mov    (%eax),%dl
  800c19:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c1c:	8a 00                	mov    (%eax),%al
  800c1e:	38 c2                	cmp    %al,%dl
  800c20:	74 16                	je     800c38 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c22:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c25:	8a 00                	mov    (%eax),%al
  800c27:	0f b6 d0             	movzbl %al,%edx
  800c2a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c2d:	8a 00                	mov    (%eax),%al
  800c2f:	0f b6 c0             	movzbl %al,%eax
  800c32:	29 c2                	sub    %eax,%edx
  800c34:	89 d0                	mov    %edx,%eax
  800c36:	eb 18                	jmp    800c50 <memcmp+0x50>
		s1++, s2++;
  800c38:	ff 45 fc             	incl   -0x4(%ebp)
  800c3b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c3e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c41:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c44:	89 55 10             	mov    %edx,0x10(%ebp)
  800c47:	85 c0                	test   %eax,%eax
  800c49:	75 c9                	jne    800c14 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c4b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c50:	c9                   	leave  
  800c51:	c3                   	ret    

00800c52 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c52:	55                   	push   %ebp
  800c53:	89 e5                	mov    %esp,%ebp
  800c55:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c58:	8b 55 08             	mov    0x8(%ebp),%edx
  800c5b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c5e:	01 d0                	add    %edx,%eax
  800c60:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c63:	eb 15                	jmp    800c7a <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c65:	8b 45 08             	mov    0x8(%ebp),%eax
  800c68:	8a 00                	mov    (%eax),%al
  800c6a:	0f b6 d0             	movzbl %al,%edx
  800c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c70:	0f b6 c0             	movzbl %al,%eax
  800c73:	39 c2                	cmp    %eax,%edx
  800c75:	74 0d                	je     800c84 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c77:	ff 45 08             	incl   0x8(%ebp)
  800c7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c80:	72 e3                	jb     800c65 <memfind+0x13>
  800c82:	eb 01                	jmp    800c85 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c84:	90                   	nop
	return (void *) s;
  800c85:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c88:	c9                   	leave  
  800c89:	c3                   	ret    

00800c8a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c8a:	55                   	push   %ebp
  800c8b:	89 e5                	mov    %esp,%ebp
  800c8d:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c90:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c97:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c9e:	eb 03                	jmp    800ca3 <strtol+0x19>
		s++;
  800ca0:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ca3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca6:	8a 00                	mov    (%eax),%al
  800ca8:	3c 20                	cmp    $0x20,%al
  800caa:	74 f4                	je     800ca0 <strtol+0x16>
  800cac:	8b 45 08             	mov    0x8(%ebp),%eax
  800caf:	8a 00                	mov    (%eax),%al
  800cb1:	3c 09                	cmp    $0x9,%al
  800cb3:	74 eb                	je     800ca0 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb8:	8a 00                	mov    (%eax),%al
  800cba:	3c 2b                	cmp    $0x2b,%al
  800cbc:	75 05                	jne    800cc3 <strtol+0x39>
		s++;
  800cbe:	ff 45 08             	incl   0x8(%ebp)
  800cc1:	eb 13                	jmp    800cd6 <strtol+0x4c>
	else if (*s == '-')
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	8a 00                	mov    (%eax),%al
  800cc8:	3c 2d                	cmp    $0x2d,%al
  800cca:	75 0a                	jne    800cd6 <strtol+0x4c>
		s++, neg = 1;
  800ccc:	ff 45 08             	incl   0x8(%ebp)
  800ccf:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cd6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cda:	74 06                	je     800ce2 <strtol+0x58>
  800cdc:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ce0:	75 20                	jne    800d02 <strtol+0x78>
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	8a 00                	mov    (%eax),%al
  800ce7:	3c 30                	cmp    $0x30,%al
  800ce9:	75 17                	jne    800d02 <strtol+0x78>
  800ceb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cee:	40                   	inc    %eax
  800cef:	8a 00                	mov    (%eax),%al
  800cf1:	3c 78                	cmp    $0x78,%al
  800cf3:	75 0d                	jne    800d02 <strtol+0x78>
		s += 2, base = 16;
  800cf5:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cf9:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d00:	eb 28                	jmp    800d2a <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d02:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d06:	75 15                	jne    800d1d <strtol+0x93>
  800d08:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0b:	8a 00                	mov    (%eax),%al
  800d0d:	3c 30                	cmp    $0x30,%al
  800d0f:	75 0c                	jne    800d1d <strtol+0x93>
		s++, base = 8;
  800d11:	ff 45 08             	incl   0x8(%ebp)
  800d14:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d1b:	eb 0d                	jmp    800d2a <strtol+0xa0>
	else if (base == 0)
  800d1d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d21:	75 07                	jne    800d2a <strtol+0xa0>
		base = 10;
  800d23:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	8a 00                	mov    (%eax),%al
  800d2f:	3c 2f                	cmp    $0x2f,%al
  800d31:	7e 19                	jle    800d4c <strtol+0xc2>
  800d33:	8b 45 08             	mov    0x8(%ebp),%eax
  800d36:	8a 00                	mov    (%eax),%al
  800d38:	3c 39                	cmp    $0x39,%al
  800d3a:	7f 10                	jg     800d4c <strtol+0xc2>
			dig = *s - '0';
  800d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3f:	8a 00                	mov    (%eax),%al
  800d41:	0f be c0             	movsbl %al,%eax
  800d44:	83 e8 30             	sub    $0x30,%eax
  800d47:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d4a:	eb 42                	jmp    800d8e <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	8a 00                	mov    (%eax),%al
  800d51:	3c 60                	cmp    $0x60,%al
  800d53:	7e 19                	jle    800d6e <strtol+0xe4>
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
  800d58:	8a 00                	mov    (%eax),%al
  800d5a:	3c 7a                	cmp    $0x7a,%al
  800d5c:	7f 10                	jg     800d6e <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d61:	8a 00                	mov    (%eax),%al
  800d63:	0f be c0             	movsbl %al,%eax
  800d66:	83 e8 57             	sub    $0x57,%eax
  800d69:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d6c:	eb 20                	jmp    800d8e <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d71:	8a 00                	mov    (%eax),%al
  800d73:	3c 40                	cmp    $0x40,%al
  800d75:	7e 39                	jle    800db0 <strtol+0x126>
  800d77:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7a:	8a 00                	mov    (%eax),%al
  800d7c:	3c 5a                	cmp    $0x5a,%al
  800d7e:	7f 30                	jg     800db0 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d80:	8b 45 08             	mov    0x8(%ebp),%eax
  800d83:	8a 00                	mov    (%eax),%al
  800d85:	0f be c0             	movsbl %al,%eax
  800d88:	83 e8 37             	sub    $0x37,%eax
  800d8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d91:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d94:	7d 19                	jge    800daf <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d96:	ff 45 08             	incl   0x8(%ebp)
  800d99:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d9c:	0f af 45 10          	imul   0x10(%ebp),%eax
  800da0:	89 c2                	mov    %eax,%edx
  800da2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800da5:	01 d0                	add    %edx,%eax
  800da7:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800daa:	e9 7b ff ff ff       	jmp    800d2a <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800daf:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800db0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800db4:	74 08                	je     800dbe <strtol+0x134>
		*endptr = (char *) s;
  800db6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db9:	8b 55 08             	mov    0x8(%ebp),%edx
  800dbc:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800dbe:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800dc2:	74 07                	je     800dcb <strtol+0x141>
  800dc4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dc7:	f7 d8                	neg    %eax
  800dc9:	eb 03                	jmp    800dce <strtol+0x144>
  800dcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dce:	c9                   	leave  
  800dcf:	c3                   	ret    

00800dd0 <ltostr>:

void
ltostr(long value, char *str)
{
  800dd0:	55                   	push   %ebp
  800dd1:	89 e5                	mov    %esp,%ebp
  800dd3:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dd6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800ddd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800de4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800de8:	79 13                	jns    800dfd <ltostr+0x2d>
	{
		neg = 1;
  800dea:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800df1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df4:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800df7:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800dfa:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800dfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800e00:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e05:	99                   	cltd   
  800e06:	f7 f9                	idiv   %ecx
  800e08:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e0b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e0e:	8d 50 01             	lea    0x1(%eax),%edx
  800e11:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e14:	89 c2                	mov    %eax,%edx
  800e16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e19:	01 d0                	add    %edx,%eax
  800e1b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e1e:	83 c2 30             	add    $0x30,%edx
  800e21:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e23:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e26:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e2b:	f7 e9                	imul   %ecx
  800e2d:	c1 fa 02             	sar    $0x2,%edx
  800e30:	89 c8                	mov    %ecx,%eax
  800e32:	c1 f8 1f             	sar    $0x1f,%eax
  800e35:	29 c2                	sub    %eax,%edx
  800e37:	89 d0                	mov    %edx,%eax
  800e39:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e3c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e3f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e44:	f7 e9                	imul   %ecx
  800e46:	c1 fa 02             	sar    $0x2,%edx
  800e49:	89 c8                	mov    %ecx,%eax
  800e4b:	c1 f8 1f             	sar    $0x1f,%eax
  800e4e:	29 c2                	sub    %eax,%edx
  800e50:	89 d0                	mov    %edx,%eax
  800e52:	c1 e0 02             	shl    $0x2,%eax
  800e55:	01 d0                	add    %edx,%eax
  800e57:	01 c0                	add    %eax,%eax
  800e59:	29 c1                	sub    %eax,%ecx
  800e5b:	89 ca                	mov    %ecx,%edx
  800e5d:	85 d2                	test   %edx,%edx
  800e5f:	75 9c                	jne    800dfd <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e61:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e68:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e6b:	48                   	dec    %eax
  800e6c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e6f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e73:	74 3d                	je     800eb2 <ltostr+0xe2>
		start = 1 ;
  800e75:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e7c:	eb 34                	jmp    800eb2 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e7e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e84:	01 d0                	add    %edx,%eax
  800e86:	8a 00                	mov    (%eax),%al
  800e88:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e8b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e91:	01 c2                	add    %eax,%edx
  800e93:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e99:	01 c8                	add    %ecx,%eax
  800e9b:	8a 00                	mov    (%eax),%al
  800e9d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e9f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800ea2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea5:	01 c2                	add    %eax,%edx
  800ea7:	8a 45 eb             	mov    -0x15(%ebp),%al
  800eaa:	88 02                	mov    %al,(%edx)
		start++ ;
  800eac:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800eaf:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800eb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800eb5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800eb8:	7c c4                	jl     800e7e <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800eba:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ebd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec0:	01 d0                	add    %edx,%eax
  800ec2:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800ec5:	90                   	nop
  800ec6:	c9                   	leave  
  800ec7:	c3                   	ret    

00800ec8 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800ec8:	55                   	push   %ebp
  800ec9:	89 e5                	mov    %esp,%ebp
  800ecb:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ece:	ff 75 08             	pushl  0x8(%ebp)
  800ed1:	e8 54 fa ff ff       	call   80092a <strlen>
  800ed6:	83 c4 04             	add    $0x4,%esp
  800ed9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800edc:	ff 75 0c             	pushl  0xc(%ebp)
  800edf:	e8 46 fa ff ff       	call   80092a <strlen>
  800ee4:	83 c4 04             	add    $0x4,%esp
  800ee7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800eea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ef1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ef8:	eb 17                	jmp    800f11 <strcconcat+0x49>
		final[s] = str1[s] ;
  800efa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800efd:	8b 45 10             	mov    0x10(%ebp),%eax
  800f00:	01 c2                	add    %eax,%edx
  800f02:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f05:	8b 45 08             	mov    0x8(%ebp),%eax
  800f08:	01 c8                	add    %ecx,%eax
  800f0a:	8a 00                	mov    (%eax),%al
  800f0c:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f0e:	ff 45 fc             	incl   -0x4(%ebp)
  800f11:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f14:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f17:	7c e1                	jl     800efa <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f19:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f20:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f27:	eb 1f                	jmp    800f48 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f29:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f2c:	8d 50 01             	lea    0x1(%eax),%edx
  800f2f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f32:	89 c2                	mov    %eax,%edx
  800f34:	8b 45 10             	mov    0x10(%ebp),%eax
  800f37:	01 c2                	add    %eax,%edx
  800f39:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3f:	01 c8                	add    %ecx,%eax
  800f41:	8a 00                	mov    (%eax),%al
  800f43:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f45:	ff 45 f8             	incl   -0x8(%ebp)
  800f48:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f4b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f4e:	7c d9                	jl     800f29 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f50:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f53:	8b 45 10             	mov    0x10(%ebp),%eax
  800f56:	01 d0                	add    %edx,%eax
  800f58:	c6 00 00             	movb   $0x0,(%eax)
}
  800f5b:	90                   	nop
  800f5c:	c9                   	leave  
  800f5d:	c3                   	ret    

00800f5e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f5e:	55                   	push   %ebp
  800f5f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f61:	8b 45 14             	mov    0x14(%ebp),%eax
  800f64:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f6a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f6d:	8b 00                	mov    (%eax),%eax
  800f6f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f76:	8b 45 10             	mov    0x10(%ebp),%eax
  800f79:	01 d0                	add    %edx,%eax
  800f7b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f81:	eb 0c                	jmp    800f8f <strsplit+0x31>
			*string++ = 0;
  800f83:	8b 45 08             	mov    0x8(%ebp),%eax
  800f86:	8d 50 01             	lea    0x1(%eax),%edx
  800f89:	89 55 08             	mov    %edx,0x8(%ebp)
  800f8c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f92:	8a 00                	mov    (%eax),%al
  800f94:	84 c0                	test   %al,%al
  800f96:	74 18                	je     800fb0 <strsplit+0x52>
  800f98:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9b:	8a 00                	mov    (%eax),%al
  800f9d:	0f be c0             	movsbl %al,%eax
  800fa0:	50                   	push   %eax
  800fa1:	ff 75 0c             	pushl  0xc(%ebp)
  800fa4:	e8 13 fb ff ff       	call   800abc <strchr>
  800fa9:	83 c4 08             	add    $0x8,%esp
  800fac:	85 c0                	test   %eax,%eax
  800fae:	75 d3                	jne    800f83 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800fb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb3:	8a 00                	mov    (%eax),%al
  800fb5:	84 c0                	test   %al,%al
  800fb7:	74 5a                	je     801013 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800fb9:	8b 45 14             	mov    0x14(%ebp),%eax
  800fbc:	8b 00                	mov    (%eax),%eax
  800fbe:	83 f8 0f             	cmp    $0xf,%eax
  800fc1:	75 07                	jne    800fca <strsplit+0x6c>
		{
			return 0;
  800fc3:	b8 00 00 00 00       	mov    $0x0,%eax
  800fc8:	eb 66                	jmp    801030 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fca:	8b 45 14             	mov    0x14(%ebp),%eax
  800fcd:	8b 00                	mov    (%eax),%eax
  800fcf:	8d 48 01             	lea    0x1(%eax),%ecx
  800fd2:	8b 55 14             	mov    0x14(%ebp),%edx
  800fd5:	89 0a                	mov    %ecx,(%edx)
  800fd7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fde:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe1:	01 c2                	add    %eax,%edx
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fe8:	eb 03                	jmp    800fed <strsplit+0x8f>
			string++;
  800fea:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff0:	8a 00                	mov    (%eax),%al
  800ff2:	84 c0                	test   %al,%al
  800ff4:	74 8b                	je     800f81 <strsplit+0x23>
  800ff6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff9:	8a 00                	mov    (%eax),%al
  800ffb:	0f be c0             	movsbl %al,%eax
  800ffe:	50                   	push   %eax
  800fff:	ff 75 0c             	pushl  0xc(%ebp)
  801002:	e8 b5 fa ff ff       	call   800abc <strchr>
  801007:	83 c4 08             	add    $0x8,%esp
  80100a:	85 c0                	test   %eax,%eax
  80100c:	74 dc                	je     800fea <strsplit+0x8c>
			string++;
	}
  80100e:	e9 6e ff ff ff       	jmp    800f81 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801013:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801014:	8b 45 14             	mov    0x14(%ebp),%eax
  801017:	8b 00                	mov    (%eax),%eax
  801019:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801020:	8b 45 10             	mov    0x10(%ebp),%eax
  801023:	01 d0                	add    %edx,%eax
  801025:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80102b:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801030:	c9                   	leave  
  801031:	c3                   	ret    

00801032 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801032:	55                   	push   %ebp
  801033:	89 e5                	mov    %esp,%ebp
  801035:	57                   	push   %edi
  801036:	56                   	push   %esi
  801037:	53                   	push   %ebx
  801038:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80103b:	8b 45 08             	mov    0x8(%ebp),%eax
  80103e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801041:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801044:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801047:	8b 7d 18             	mov    0x18(%ebp),%edi
  80104a:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80104d:	cd 30                	int    $0x30
  80104f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801052:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801055:	83 c4 10             	add    $0x10,%esp
  801058:	5b                   	pop    %ebx
  801059:	5e                   	pop    %esi
  80105a:	5f                   	pop    %edi
  80105b:	5d                   	pop    %ebp
  80105c:	c3                   	ret    

0080105d <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80105d:	55                   	push   %ebp
  80105e:	89 e5                	mov    %esp,%ebp
  801060:	83 ec 04             	sub    $0x4,%esp
  801063:	8b 45 10             	mov    0x10(%ebp),%eax
  801066:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801069:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
  801070:	6a 00                	push   $0x0
  801072:	6a 00                	push   $0x0
  801074:	52                   	push   %edx
  801075:	ff 75 0c             	pushl  0xc(%ebp)
  801078:	50                   	push   %eax
  801079:	6a 00                	push   $0x0
  80107b:	e8 b2 ff ff ff       	call   801032 <syscall>
  801080:	83 c4 18             	add    $0x18,%esp
}
  801083:	90                   	nop
  801084:	c9                   	leave  
  801085:	c3                   	ret    

00801086 <sys_cgetc>:

int
sys_cgetc(void)
{
  801086:	55                   	push   %ebp
  801087:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801089:	6a 00                	push   $0x0
  80108b:	6a 00                	push   $0x0
  80108d:	6a 00                	push   $0x0
  80108f:	6a 00                	push   $0x0
  801091:	6a 00                	push   $0x0
  801093:	6a 01                	push   $0x1
  801095:	e8 98 ff ff ff       	call   801032 <syscall>
  80109a:	83 c4 18             	add    $0x18,%esp
}
  80109d:	c9                   	leave  
  80109e:	c3                   	ret    

0080109f <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80109f:	55                   	push   %ebp
  8010a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8010a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a5:	6a 00                	push   $0x0
  8010a7:	6a 00                	push   $0x0
  8010a9:	6a 00                	push   $0x0
  8010ab:	6a 00                	push   $0x0
  8010ad:	50                   	push   %eax
  8010ae:	6a 05                	push   $0x5
  8010b0:	e8 7d ff ff ff       	call   801032 <syscall>
  8010b5:	83 c4 18             	add    $0x18,%esp
}
  8010b8:	c9                   	leave  
  8010b9:	c3                   	ret    

008010ba <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010ba:	55                   	push   %ebp
  8010bb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010bd:	6a 00                	push   $0x0
  8010bf:	6a 00                	push   $0x0
  8010c1:	6a 00                	push   $0x0
  8010c3:	6a 00                	push   $0x0
  8010c5:	6a 00                	push   $0x0
  8010c7:	6a 02                	push   $0x2
  8010c9:	e8 64 ff ff ff       	call   801032 <syscall>
  8010ce:	83 c4 18             	add    $0x18,%esp
}
  8010d1:	c9                   	leave  
  8010d2:	c3                   	ret    

008010d3 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010d3:	55                   	push   %ebp
  8010d4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010d6:	6a 00                	push   $0x0
  8010d8:	6a 00                	push   $0x0
  8010da:	6a 00                	push   $0x0
  8010dc:	6a 00                	push   $0x0
  8010de:	6a 00                	push   $0x0
  8010e0:	6a 03                	push   $0x3
  8010e2:	e8 4b ff ff ff       	call   801032 <syscall>
  8010e7:	83 c4 18             	add    $0x18,%esp
}
  8010ea:	c9                   	leave  
  8010eb:	c3                   	ret    

008010ec <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010ec:	55                   	push   %ebp
  8010ed:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010ef:	6a 00                	push   $0x0
  8010f1:	6a 00                	push   $0x0
  8010f3:	6a 00                	push   $0x0
  8010f5:	6a 00                	push   $0x0
  8010f7:	6a 00                	push   $0x0
  8010f9:	6a 04                	push   $0x4
  8010fb:	e8 32 ff ff ff       	call   801032 <syscall>
  801100:	83 c4 18             	add    $0x18,%esp
}
  801103:	c9                   	leave  
  801104:	c3                   	ret    

00801105 <sys_env_exit>:


void sys_env_exit(void)
{
  801105:	55                   	push   %ebp
  801106:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801108:	6a 00                	push   $0x0
  80110a:	6a 00                	push   $0x0
  80110c:	6a 00                	push   $0x0
  80110e:	6a 00                	push   $0x0
  801110:	6a 00                	push   $0x0
  801112:	6a 06                	push   $0x6
  801114:	e8 19 ff ff ff       	call   801032 <syscall>
  801119:	83 c4 18             	add    $0x18,%esp
}
  80111c:	90                   	nop
  80111d:	c9                   	leave  
  80111e:	c3                   	ret    

0080111f <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80111f:	55                   	push   %ebp
  801120:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801122:	8b 55 0c             	mov    0xc(%ebp),%edx
  801125:	8b 45 08             	mov    0x8(%ebp),%eax
  801128:	6a 00                	push   $0x0
  80112a:	6a 00                	push   $0x0
  80112c:	6a 00                	push   $0x0
  80112e:	52                   	push   %edx
  80112f:	50                   	push   %eax
  801130:	6a 07                	push   $0x7
  801132:	e8 fb fe ff ff       	call   801032 <syscall>
  801137:	83 c4 18             	add    $0x18,%esp
}
  80113a:	c9                   	leave  
  80113b:	c3                   	ret    

0080113c <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80113c:	55                   	push   %ebp
  80113d:	89 e5                	mov    %esp,%ebp
  80113f:	56                   	push   %esi
  801140:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801141:	8b 75 18             	mov    0x18(%ebp),%esi
  801144:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801147:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80114a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80114d:	8b 45 08             	mov    0x8(%ebp),%eax
  801150:	56                   	push   %esi
  801151:	53                   	push   %ebx
  801152:	51                   	push   %ecx
  801153:	52                   	push   %edx
  801154:	50                   	push   %eax
  801155:	6a 08                	push   $0x8
  801157:	e8 d6 fe ff ff       	call   801032 <syscall>
  80115c:	83 c4 18             	add    $0x18,%esp
}
  80115f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801162:	5b                   	pop    %ebx
  801163:	5e                   	pop    %esi
  801164:	5d                   	pop    %ebp
  801165:	c3                   	ret    

00801166 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801166:	55                   	push   %ebp
  801167:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801169:	8b 55 0c             	mov    0xc(%ebp),%edx
  80116c:	8b 45 08             	mov    0x8(%ebp),%eax
  80116f:	6a 00                	push   $0x0
  801171:	6a 00                	push   $0x0
  801173:	6a 00                	push   $0x0
  801175:	52                   	push   %edx
  801176:	50                   	push   %eax
  801177:	6a 09                	push   $0x9
  801179:	e8 b4 fe ff ff       	call   801032 <syscall>
  80117e:	83 c4 18             	add    $0x18,%esp
}
  801181:	c9                   	leave  
  801182:	c3                   	ret    

00801183 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801183:	55                   	push   %ebp
  801184:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801186:	6a 00                	push   $0x0
  801188:	6a 00                	push   $0x0
  80118a:	6a 00                	push   $0x0
  80118c:	ff 75 0c             	pushl  0xc(%ebp)
  80118f:	ff 75 08             	pushl  0x8(%ebp)
  801192:	6a 0a                	push   $0xa
  801194:	e8 99 fe ff ff       	call   801032 <syscall>
  801199:	83 c4 18             	add    $0x18,%esp
}
  80119c:	c9                   	leave  
  80119d:	c3                   	ret    

0080119e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80119e:	55                   	push   %ebp
  80119f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8011a1:	6a 00                	push   $0x0
  8011a3:	6a 00                	push   $0x0
  8011a5:	6a 00                	push   $0x0
  8011a7:	6a 00                	push   $0x0
  8011a9:	6a 00                	push   $0x0
  8011ab:	6a 0b                	push   $0xb
  8011ad:	e8 80 fe ff ff       	call   801032 <syscall>
  8011b2:	83 c4 18             	add    $0x18,%esp
}
  8011b5:	c9                   	leave  
  8011b6:	c3                   	ret    

008011b7 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011b7:	55                   	push   %ebp
  8011b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011ba:	6a 00                	push   $0x0
  8011bc:	6a 00                	push   $0x0
  8011be:	6a 00                	push   $0x0
  8011c0:	6a 00                	push   $0x0
  8011c2:	6a 00                	push   $0x0
  8011c4:	6a 0c                	push   $0xc
  8011c6:	e8 67 fe ff ff       	call   801032 <syscall>
  8011cb:	83 c4 18             	add    $0x18,%esp
}
  8011ce:	c9                   	leave  
  8011cf:	c3                   	ret    

008011d0 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011d0:	55                   	push   %ebp
  8011d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011d3:	6a 00                	push   $0x0
  8011d5:	6a 00                	push   $0x0
  8011d7:	6a 00                	push   $0x0
  8011d9:	6a 00                	push   $0x0
  8011db:	6a 00                	push   $0x0
  8011dd:	6a 0d                	push   $0xd
  8011df:	e8 4e fe ff ff       	call   801032 <syscall>
  8011e4:	83 c4 18             	add    $0x18,%esp
}
  8011e7:	c9                   	leave  
  8011e8:	c3                   	ret    

008011e9 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011e9:	55                   	push   %ebp
  8011ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011ec:	6a 00                	push   $0x0
  8011ee:	6a 00                	push   $0x0
  8011f0:	6a 00                	push   $0x0
  8011f2:	ff 75 0c             	pushl  0xc(%ebp)
  8011f5:	ff 75 08             	pushl  0x8(%ebp)
  8011f8:	6a 11                	push   $0x11
  8011fa:	e8 33 fe ff ff       	call   801032 <syscall>
  8011ff:	83 c4 18             	add    $0x18,%esp
	return;
  801202:	90                   	nop
}
  801203:	c9                   	leave  
  801204:	c3                   	ret    

00801205 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801205:	55                   	push   %ebp
  801206:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801208:	6a 00                	push   $0x0
  80120a:	6a 00                	push   $0x0
  80120c:	6a 00                	push   $0x0
  80120e:	ff 75 0c             	pushl  0xc(%ebp)
  801211:	ff 75 08             	pushl  0x8(%ebp)
  801214:	6a 12                	push   $0x12
  801216:	e8 17 fe ff ff       	call   801032 <syscall>
  80121b:	83 c4 18             	add    $0x18,%esp
	return ;
  80121e:	90                   	nop
}
  80121f:	c9                   	leave  
  801220:	c3                   	ret    

00801221 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801221:	55                   	push   %ebp
  801222:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801224:	6a 00                	push   $0x0
  801226:	6a 00                	push   $0x0
  801228:	6a 00                	push   $0x0
  80122a:	6a 00                	push   $0x0
  80122c:	6a 00                	push   $0x0
  80122e:	6a 0e                	push   $0xe
  801230:	e8 fd fd ff ff       	call   801032 <syscall>
  801235:	83 c4 18             	add    $0x18,%esp
}
  801238:	c9                   	leave  
  801239:	c3                   	ret    

0080123a <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80123a:	55                   	push   %ebp
  80123b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80123d:	6a 00                	push   $0x0
  80123f:	6a 00                	push   $0x0
  801241:	6a 00                	push   $0x0
  801243:	6a 00                	push   $0x0
  801245:	ff 75 08             	pushl  0x8(%ebp)
  801248:	6a 0f                	push   $0xf
  80124a:	e8 e3 fd ff ff       	call   801032 <syscall>
  80124f:	83 c4 18             	add    $0x18,%esp
}
  801252:	c9                   	leave  
  801253:	c3                   	ret    

00801254 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801254:	55                   	push   %ebp
  801255:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801257:	6a 00                	push   $0x0
  801259:	6a 00                	push   $0x0
  80125b:	6a 00                	push   $0x0
  80125d:	6a 00                	push   $0x0
  80125f:	6a 00                	push   $0x0
  801261:	6a 10                	push   $0x10
  801263:	e8 ca fd ff ff       	call   801032 <syscall>
  801268:	83 c4 18             	add    $0x18,%esp
}
  80126b:	90                   	nop
  80126c:	c9                   	leave  
  80126d:	c3                   	ret    

0080126e <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80126e:	55                   	push   %ebp
  80126f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801271:	6a 00                	push   $0x0
  801273:	6a 00                	push   $0x0
  801275:	6a 00                	push   $0x0
  801277:	6a 00                	push   $0x0
  801279:	6a 00                	push   $0x0
  80127b:	6a 14                	push   $0x14
  80127d:	e8 b0 fd ff ff       	call   801032 <syscall>
  801282:	83 c4 18             	add    $0x18,%esp
}
  801285:	90                   	nop
  801286:	c9                   	leave  
  801287:	c3                   	ret    

00801288 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801288:	55                   	push   %ebp
  801289:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80128b:	6a 00                	push   $0x0
  80128d:	6a 00                	push   $0x0
  80128f:	6a 00                	push   $0x0
  801291:	6a 00                	push   $0x0
  801293:	6a 00                	push   $0x0
  801295:	6a 15                	push   $0x15
  801297:	e8 96 fd ff ff       	call   801032 <syscall>
  80129c:	83 c4 18             	add    $0x18,%esp
}
  80129f:	90                   	nop
  8012a0:	c9                   	leave  
  8012a1:	c3                   	ret    

008012a2 <sys_cputc>:


void
sys_cputc(const char c)
{
  8012a2:	55                   	push   %ebp
  8012a3:	89 e5                	mov    %esp,%ebp
  8012a5:	83 ec 04             	sub    $0x4,%esp
  8012a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ab:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8012ae:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012b2:	6a 00                	push   $0x0
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 00                	push   $0x0
  8012ba:	50                   	push   %eax
  8012bb:	6a 16                	push   $0x16
  8012bd:	e8 70 fd ff ff       	call   801032 <syscall>
  8012c2:	83 c4 18             	add    $0x18,%esp
}
  8012c5:	90                   	nop
  8012c6:	c9                   	leave  
  8012c7:	c3                   	ret    

008012c8 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012c8:	55                   	push   %ebp
  8012c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012cb:	6a 00                	push   $0x0
  8012cd:	6a 00                	push   $0x0
  8012cf:	6a 00                	push   $0x0
  8012d1:	6a 00                	push   $0x0
  8012d3:	6a 00                	push   $0x0
  8012d5:	6a 17                	push   $0x17
  8012d7:	e8 56 fd ff ff       	call   801032 <syscall>
  8012dc:	83 c4 18             	add    $0x18,%esp
}
  8012df:	90                   	nop
  8012e0:	c9                   	leave  
  8012e1:	c3                   	ret    

008012e2 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012e2:	55                   	push   %ebp
  8012e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e8:	6a 00                	push   $0x0
  8012ea:	6a 00                	push   $0x0
  8012ec:	6a 00                	push   $0x0
  8012ee:	ff 75 0c             	pushl  0xc(%ebp)
  8012f1:	50                   	push   %eax
  8012f2:	6a 18                	push   $0x18
  8012f4:	e8 39 fd ff ff       	call   801032 <syscall>
  8012f9:	83 c4 18             	add    $0x18,%esp
}
  8012fc:	c9                   	leave  
  8012fd:	c3                   	ret    

008012fe <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012fe:	55                   	push   %ebp
  8012ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801301:	8b 55 0c             	mov    0xc(%ebp),%edx
  801304:	8b 45 08             	mov    0x8(%ebp),%eax
  801307:	6a 00                	push   $0x0
  801309:	6a 00                	push   $0x0
  80130b:	6a 00                	push   $0x0
  80130d:	52                   	push   %edx
  80130e:	50                   	push   %eax
  80130f:	6a 1b                	push   $0x1b
  801311:	e8 1c fd ff ff       	call   801032 <syscall>
  801316:	83 c4 18             	add    $0x18,%esp
}
  801319:	c9                   	leave  
  80131a:	c3                   	ret    

0080131b <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80131b:	55                   	push   %ebp
  80131c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80131e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801321:	8b 45 08             	mov    0x8(%ebp),%eax
  801324:	6a 00                	push   $0x0
  801326:	6a 00                	push   $0x0
  801328:	6a 00                	push   $0x0
  80132a:	52                   	push   %edx
  80132b:	50                   	push   %eax
  80132c:	6a 19                	push   $0x19
  80132e:	e8 ff fc ff ff       	call   801032 <syscall>
  801333:	83 c4 18             	add    $0x18,%esp
}
  801336:	90                   	nop
  801337:	c9                   	leave  
  801338:	c3                   	ret    

00801339 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801339:	55                   	push   %ebp
  80133a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80133c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80133f:	8b 45 08             	mov    0x8(%ebp),%eax
  801342:	6a 00                	push   $0x0
  801344:	6a 00                	push   $0x0
  801346:	6a 00                	push   $0x0
  801348:	52                   	push   %edx
  801349:	50                   	push   %eax
  80134a:	6a 1a                	push   $0x1a
  80134c:	e8 e1 fc ff ff       	call   801032 <syscall>
  801351:	83 c4 18             	add    $0x18,%esp
}
  801354:	90                   	nop
  801355:	c9                   	leave  
  801356:	c3                   	ret    

00801357 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801357:	55                   	push   %ebp
  801358:	89 e5                	mov    %esp,%ebp
  80135a:	83 ec 04             	sub    $0x4,%esp
  80135d:	8b 45 10             	mov    0x10(%ebp),%eax
  801360:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801363:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801366:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80136a:	8b 45 08             	mov    0x8(%ebp),%eax
  80136d:	6a 00                	push   $0x0
  80136f:	51                   	push   %ecx
  801370:	52                   	push   %edx
  801371:	ff 75 0c             	pushl  0xc(%ebp)
  801374:	50                   	push   %eax
  801375:	6a 1c                	push   $0x1c
  801377:	e8 b6 fc ff ff       	call   801032 <syscall>
  80137c:	83 c4 18             	add    $0x18,%esp
}
  80137f:	c9                   	leave  
  801380:	c3                   	ret    

00801381 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801381:	55                   	push   %ebp
  801382:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801384:	8b 55 0c             	mov    0xc(%ebp),%edx
  801387:	8b 45 08             	mov    0x8(%ebp),%eax
  80138a:	6a 00                	push   $0x0
  80138c:	6a 00                	push   $0x0
  80138e:	6a 00                	push   $0x0
  801390:	52                   	push   %edx
  801391:	50                   	push   %eax
  801392:	6a 1d                	push   $0x1d
  801394:	e8 99 fc ff ff       	call   801032 <syscall>
  801399:	83 c4 18             	add    $0x18,%esp
}
  80139c:	c9                   	leave  
  80139d:	c3                   	ret    

0080139e <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80139e:	55                   	push   %ebp
  80139f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8013a1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013aa:	6a 00                	push   $0x0
  8013ac:	6a 00                	push   $0x0
  8013ae:	51                   	push   %ecx
  8013af:	52                   	push   %edx
  8013b0:	50                   	push   %eax
  8013b1:	6a 1e                	push   $0x1e
  8013b3:	e8 7a fc ff ff       	call   801032 <syscall>
  8013b8:	83 c4 18             	add    $0x18,%esp
}
  8013bb:	c9                   	leave  
  8013bc:	c3                   	ret    

008013bd <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013bd:	55                   	push   %ebp
  8013be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c6:	6a 00                	push   $0x0
  8013c8:	6a 00                	push   $0x0
  8013ca:	6a 00                	push   $0x0
  8013cc:	52                   	push   %edx
  8013cd:	50                   	push   %eax
  8013ce:	6a 1f                	push   $0x1f
  8013d0:	e8 5d fc ff ff       	call   801032 <syscall>
  8013d5:	83 c4 18             	add    $0x18,%esp
}
  8013d8:	c9                   	leave  
  8013d9:	c3                   	ret    

008013da <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013da:	55                   	push   %ebp
  8013db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013dd:	6a 00                	push   $0x0
  8013df:	6a 00                	push   $0x0
  8013e1:	6a 00                	push   $0x0
  8013e3:	6a 00                	push   $0x0
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 20                	push   $0x20
  8013e9:	e8 44 fc ff ff       	call   801032 <syscall>
  8013ee:	83 c4 18             	add    $0x18,%esp
}
  8013f1:	c9                   	leave  
  8013f2:	c3                   	ret    

008013f3 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8013f3:	55                   	push   %ebp
  8013f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8013f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f9:	6a 00                	push   $0x0
  8013fb:	ff 75 14             	pushl  0x14(%ebp)
  8013fe:	ff 75 10             	pushl  0x10(%ebp)
  801401:	ff 75 0c             	pushl  0xc(%ebp)
  801404:	50                   	push   %eax
  801405:	6a 21                	push   $0x21
  801407:	e8 26 fc ff ff       	call   801032 <syscall>
  80140c:	83 c4 18             	add    $0x18,%esp
}
  80140f:	c9                   	leave  
  801410:	c3                   	ret    

00801411 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801411:	55                   	push   %ebp
  801412:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801414:	8b 45 08             	mov    0x8(%ebp),%eax
  801417:	6a 00                	push   $0x0
  801419:	6a 00                	push   $0x0
  80141b:	6a 00                	push   $0x0
  80141d:	6a 00                	push   $0x0
  80141f:	50                   	push   %eax
  801420:	6a 22                	push   $0x22
  801422:	e8 0b fc ff ff       	call   801032 <syscall>
  801427:	83 c4 18             	add    $0x18,%esp
}
  80142a:	90                   	nop
  80142b:	c9                   	leave  
  80142c:	c3                   	ret    

0080142d <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80142d:	55                   	push   %ebp
  80142e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801430:	8b 45 08             	mov    0x8(%ebp),%eax
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	6a 00                	push   $0x0
  801439:	6a 00                	push   $0x0
  80143b:	50                   	push   %eax
  80143c:	6a 23                	push   $0x23
  80143e:	e8 ef fb ff ff       	call   801032 <syscall>
  801443:	83 c4 18             	add    $0x18,%esp
}
  801446:	90                   	nop
  801447:	c9                   	leave  
  801448:	c3                   	ret    

00801449 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801449:	55                   	push   %ebp
  80144a:	89 e5                	mov    %esp,%ebp
  80144c:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80144f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801452:	8d 50 04             	lea    0x4(%eax),%edx
  801455:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801458:	6a 00                	push   $0x0
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	52                   	push   %edx
  80145f:	50                   	push   %eax
  801460:	6a 24                	push   $0x24
  801462:	e8 cb fb ff ff       	call   801032 <syscall>
  801467:	83 c4 18             	add    $0x18,%esp
	return result;
  80146a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80146d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801470:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801473:	89 01                	mov    %eax,(%ecx)
  801475:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801478:	8b 45 08             	mov    0x8(%ebp),%eax
  80147b:	c9                   	leave  
  80147c:	c2 04 00             	ret    $0x4

0080147f <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80147f:	55                   	push   %ebp
  801480:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801482:	6a 00                	push   $0x0
  801484:	6a 00                	push   $0x0
  801486:	ff 75 10             	pushl  0x10(%ebp)
  801489:	ff 75 0c             	pushl  0xc(%ebp)
  80148c:	ff 75 08             	pushl  0x8(%ebp)
  80148f:	6a 13                	push   $0x13
  801491:	e8 9c fb ff ff       	call   801032 <syscall>
  801496:	83 c4 18             	add    $0x18,%esp
	return ;
  801499:	90                   	nop
}
  80149a:	c9                   	leave  
  80149b:	c3                   	ret    

0080149c <sys_rcr2>:
uint32 sys_rcr2()
{
  80149c:	55                   	push   %ebp
  80149d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 00                	push   $0x0
  8014a3:	6a 00                	push   $0x0
  8014a5:	6a 00                	push   $0x0
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 25                	push   $0x25
  8014ab:	e8 82 fb ff ff       	call   801032 <syscall>
  8014b0:	83 c4 18             	add    $0x18,%esp
}
  8014b3:	c9                   	leave  
  8014b4:	c3                   	ret    

008014b5 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014b5:	55                   	push   %ebp
  8014b6:	89 e5                	mov    %esp,%ebp
  8014b8:	83 ec 04             	sub    $0x4,%esp
  8014bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014be:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014c1:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 00                	push   $0x0
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	50                   	push   %eax
  8014ce:	6a 26                	push   $0x26
  8014d0:	e8 5d fb ff ff       	call   801032 <syscall>
  8014d5:	83 c4 18             	add    $0x18,%esp
	return ;
  8014d8:	90                   	nop
}
  8014d9:	c9                   	leave  
  8014da:	c3                   	ret    

008014db <rsttst>:
void rsttst()
{
  8014db:	55                   	push   %ebp
  8014dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 28                	push   $0x28
  8014ea:	e8 43 fb ff ff       	call   801032 <syscall>
  8014ef:	83 c4 18             	add    $0x18,%esp
	return ;
  8014f2:	90                   	nop
}
  8014f3:	c9                   	leave  
  8014f4:	c3                   	ret    

008014f5 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014f5:	55                   	push   %ebp
  8014f6:	89 e5                	mov    %esp,%ebp
  8014f8:	83 ec 04             	sub    $0x4,%esp
  8014fb:	8b 45 14             	mov    0x14(%ebp),%eax
  8014fe:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801501:	8b 55 18             	mov    0x18(%ebp),%edx
  801504:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801508:	52                   	push   %edx
  801509:	50                   	push   %eax
  80150a:	ff 75 10             	pushl  0x10(%ebp)
  80150d:	ff 75 0c             	pushl  0xc(%ebp)
  801510:	ff 75 08             	pushl  0x8(%ebp)
  801513:	6a 27                	push   $0x27
  801515:	e8 18 fb ff ff       	call   801032 <syscall>
  80151a:	83 c4 18             	add    $0x18,%esp
	return ;
  80151d:	90                   	nop
}
  80151e:	c9                   	leave  
  80151f:	c3                   	ret    

00801520 <chktst>:
void chktst(uint32 n)
{
  801520:	55                   	push   %ebp
  801521:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	ff 75 08             	pushl  0x8(%ebp)
  80152e:	6a 29                	push   $0x29
  801530:	e8 fd fa ff ff       	call   801032 <syscall>
  801535:	83 c4 18             	add    $0x18,%esp
	return ;
  801538:	90                   	nop
}
  801539:	c9                   	leave  
  80153a:	c3                   	ret    

0080153b <inctst>:

void inctst()
{
  80153b:	55                   	push   %ebp
  80153c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80153e:	6a 00                	push   $0x0
  801540:	6a 00                	push   $0x0
  801542:	6a 00                	push   $0x0
  801544:	6a 00                	push   $0x0
  801546:	6a 00                	push   $0x0
  801548:	6a 2a                	push   $0x2a
  80154a:	e8 e3 fa ff ff       	call   801032 <syscall>
  80154f:	83 c4 18             	add    $0x18,%esp
	return ;
  801552:	90                   	nop
}
  801553:	c9                   	leave  
  801554:	c3                   	ret    

00801555 <gettst>:
uint32 gettst()
{
  801555:	55                   	push   %ebp
  801556:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 00                	push   $0x0
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	6a 2b                	push   $0x2b
  801564:	e8 c9 fa ff ff       	call   801032 <syscall>
  801569:	83 c4 18             	add    $0x18,%esp
}
  80156c:	c9                   	leave  
  80156d:	c3                   	ret    

0080156e <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80156e:	55                   	push   %ebp
  80156f:	89 e5                	mov    %esp,%ebp
  801571:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801574:	6a 00                	push   $0x0
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	6a 00                	push   $0x0
  80157e:	6a 2c                	push   $0x2c
  801580:	e8 ad fa ff ff       	call   801032 <syscall>
  801585:	83 c4 18             	add    $0x18,%esp
  801588:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80158b:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80158f:	75 07                	jne    801598 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801591:	b8 01 00 00 00       	mov    $0x1,%eax
  801596:	eb 05                	jmp    80159d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801598:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80159d:	c9                   	leave  
  80159e:	c3                   	ret    

0080159f <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80159f:	55                   	push   %ebp
  8015a0:	89 e5                	mov    %esp,%ebp
  8015a2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 2c                	push   $0x2c
  8015b1:	e8 7c fa ff ff       	call   801032 <syscall>
  8015b6:	83 c4 18             	add    $0x18,%esp
  8015b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015bc:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015c0:	75 07                	jne    8015c9 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015c2:	b8 01 00 00 00       	mov    $0x1,%eax
  8015c7:	eb 05                	jmp    8015ce <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ce:	c9                   	leave  
  8015cf:	c3                   	ret    

008015d0 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015d0:	55                   	push   %ebp
  8015d1:	89 e5                	mov    %esp,%ebp
  8015d3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015d6:	6a 00                	push   $0x0
  8015d8:	6a 00                	push   $0x0
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 2c                	push   $0x2c
  8015e2:	e8 4b fa ff ff       	call   801032 <syscall>
  8015e7:	83 c4 18             	add    $0x18,%esp
  8015ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015ed:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015f1:	75 07                	jne    8015fa <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015f3:	b8 01 00 00 00       	mov    $0x1,%eax
  8015f8:	eb 05                	jmp    8015ff <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015fa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ff:	c9                   	leave  
  801600:	c3                   	ret    

00801601 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801601:	55                   	push   %ebp
  801602:	89 e5                	mov    %esp,%ebp
  801604:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801607:	6a 00                	push   $0x0
  801609:	6a 00                	push   $0x0
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 2c                	push   $0x2c
  801613:	e8 1a fa ff ff       	call   801032 <syscall>
  801618:	83 c4 18             	add    $0x18,%esp
  80161b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80161e:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801622:	75 07                	jne    80162b <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801624:	b8 01 00 00 00       	mov    $0x1,%eax
  801629:	eb 05                	jmp    801630 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80162b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801630:	c9                   	leave  
  801631:	c3                   	ret    

00801632 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801632:	55                   	push   %ebp
  801633:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	ff 75 08             	pushl  0x8(%ebp)
  801640:	6a 2d                	push   $0x2d
  801642:	e8 eb f9 ff ff       	call   801032 <syscall>
  801647:	83 c4 18             	add    $0x18,%esp
	return ;
  80164a:	90                   	nop
}
  80164b:	c9                   	leave  
  80164c:	c3                   	ret    

0080164d <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80164d:	55                   	push   %ebp
  80164e:	89 e5                	mov    %esp,%ebp
  801650:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801651:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801654:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801657:	8b 55 0c             	mov    0xc(%ebp),%edx
  80165a:	8b 45 08             	mov    0x8(%ebp),%eax
  80165d:	6a 00                	push   $0x0
  80165f:	53                   	push   %ebx
  801660:	51                   	push   %ecx
  801661:	52                   	push   %edx
  801662:	50                   	push   %eax
  801663:	6a 2e                	push   $0x2e
  801665:	e8 c8 f9 ff ff       	call   801032 <syscall>
  80166a:	83 c4 18             	add    $0x18,%esp
}
  80166d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801670:	c9                   	leave  
  801671:	c3                   	ret    

00801672 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801672:	55                   	push   %ebp
  801673:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801675:	8b 55 0c             	mov    0xc(%ebp),%edx
  801678:	8b 45 08             	mov    0x8(%ebp),%eax
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	52                   	push   %edx
  801682:	50                   	push   %eax
  801683:	6a 2f                	push   $0x2f
  801685:	e8 a8 f9 ff ff       	call   801032 <syscall>
  80168a:	83 c4 18             	add    $0x18,%esp
}
  80168d:	c9                   	leave  
  80168e:	c3                   	ret    

0080168f <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  80168f:	55                   	push   %ebp
  801690:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	6a 00                	push   $0x0
  801698:	ff 75 0c             	pushl  0xc(%ebp)
  80169b:	ff 75 08             	pushl  0x8(%ebp)
  80169e:	6a 30                	push   $0x30
  8016a0:	e8 8d f9 ff ff       	call   801032 <syscall>
  8016a5:	83 c4 18             	add    $0x18,%esp
	return ;
  8016a8:	90                   	nop
}
  8016a9:	c9                   	leave  
  8016aa:	c3                   	ret    
  8016ab:	90                   	nop

008016ac <__udivdi3>:
  8016ac:	55                   	push   %ebp
  8016ad:	57                   	push   %edi
  8016ae:	56                   	push   %esi
  8016af:	53                   	push   %ebx
  8016b0:	83 ec 1c             	sub    $0x1c,%esp
  8016b3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8016b7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8016bb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016bf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8016c3:	89 ca                	mov    %ecx,%edx
  8016c5:	89 f8                	mov    %edi,%eax
  8016c7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8016cb:	85 f6                	test   %esi,%esi
  8016cd:	75 2d                	jne    8016fc <__udivdi3+0x50>
  8016cf:	39 cf                	cmp    %ecx,%edi
  8016d1:	77 65                	ja     801738 <__udivdi3+0x8c>
  8016d3:	89 fd                	mov    %edi,%ebp
  8016d5:	85 ff                	test   %edi,%edi
  8016d7:	75 0b                	jne    8016e4 <__udivdi3+0x38>
  8016d9:	b8 01 00 00 00       	mov    $0x1,%eax
  8016de:	31 d2                	xor    %edx,%edx
  8016e0:	f7 f7                	div    %edi
  8016e2:	89 c5                	mov    %eax,%ebp
  8016e4:	31 d2                	xor    %edx,%edx
  8016e6:	89 c8                	mov    %ecx,%eax
  8016e8:	f7 f5                	div    %ebp
  8016ea:	89 c1                	mov    %eax,%ecx
  8016ec:	89 d8                	mov    %ebx,%eax
  8016ee:	f7 f5                	div    %ebp
  8016f0:	89 cf                	mov    %ecx,%edi
  8016f2:	89 fa                	mov    %edi,%edx
  8016f4:	83 c4 1c             	add    $0x1c,%esp
  8016f7:	5b                   	pop    %ebx
  8016f8:	5e                   	pop    %esi
  8016f9:	5f                   	pop    %edi
  8016fa:	5d                   	pop    %ebp
  8016fb:	c3                   	ret    
  8016fc:	39 ce                	cmp    %ecx,%esi
  8016fe:	77 28                	ja     801728 <__udivdi3+0x7c>
  801700:	0f bd fe             	bsr    %esi,%edi
  801703:	83 f7 1f             	xor    $0x1f,%edi
  801706:	75 40                	jne    801748 <__udivdi3+0x9c>
  801708:	39 ce                	cmp    %ecx,%esi
  80170a:	72 0a                	jb     801716 <__udivdi3+0x6a>
  80170c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801710:	0f 87 9e 00 00 00    	ja     8017b4 <__udivdi3+0x108>
  801716:	b8 01 00 00 00       	mov    $0x1,%eax
  80171b:	89 fa                	mov    %edi,%edx
  80171d:	83 c4 1c             	add    $0x1c,%esp
  801720:	5b                   	pop    %ebx
  801721:	5e                   	pop    %esi
  801722:	5f                   	pop    %edi
  801723:	5d                   	pop    %ebp
  801724:	c3                   	ret    
  801725:	8d 76 00             	lea    0x0(%esi),%esi
  801728:	31 ff                	xor    %edi,%edi
  80172a:	31 c0                	xor    %eax,%eax
  80172c:	89 fa                	mov    %edi,%edx
  80172e:	83 c4 1c             	add    $0x1c,%esp
  801731:	5b                   	pop    %ebx
  801732:	5e                   	pop    %esi
  801733:	5f                   	pop    %edi
  801734:	5d                   	pop    %ebp
  801735:	c3                   	ret    
  801736:	66 90                	xchg   %ax,%ax
  801738:	89 d8                	mov    %ebx,%eax
  80173a:	f7 f7                	div    %edi
  80173c:	31 ff                	xor    %edi,%edi
  80173e:	89 fa                	mov    %edi,%edx
  801740:	83 c4 1c             	add    $0x1c,%esp
  801743:	5b                   	pop    %ebx
  801744:	5e                   	pop    %esi
  801745:	5f                   	pop    %edi
  801746:	5d                   	pop    %ebp
  801747:	c3                   	ret    
  801748:	bd 20 00 00 00       	mov    $0x20,%ebp
  80174d:	89 eb                	mov    %ebp,%ebx
  80174f:	29 fb                	sub    %edi,%ebx
  801751:	89 f9                	mov    %edi,%ecx
  801753:	d3 e6                	shl    %cl,%esi
  801755:	89 c5                	mov    %eax,%ebp
  801757:	88 d9                	mov    %bl,%cl
  801759:	d3 ed                	shr    %cl,%ebp
  80175b:	89 e9                	mov    %ebp,%ecx
  80175d:	09 f1                	or     %esi,%ecx
  80175f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801763:	89 f9                	mov    %edi,%ecx
  801765:	d3 e0                	shl    %cl,%eax
  801767:	89 c5                	mov    %eax,%ebp
  801769:	89 d6                	mov    %edx,%esi
  80176b:	88 d9                	mov    %bl,%cl
  80176d:	d3 ee                	shr    %cl,%esi
  80176f:	89 f9                	mov    %edi,%ecx
  801771:	d3 e2                	shl    %cl,%edx
  801773:	8b 44 24 08          	mov    0x8(%esp),%eax
  801777:	88 d9                	mov    %bl,%cl
  801779:	d3 e8                	shr    %cl,%eax
  80177b:	09 c2                	or     %eax,%edx
  80177d:	89 d0                	mov    %edx,%eax
  80177f:	89 f2                	mov    %esi,%edx
  801781:	f7 74 24 0c          	divl   0xc(%esp)
  801785:	89 d6                	mov    %edx,%esi
  801787:	89 c3                	mov    %eax,%ebx
  801789:	f7 e5                	mul    %ebp
  80178b:	39 d6                	cmp    %edx,%esi
  80178d:	72 19                	jb     8017a8 <__udivdi3+0xfc>
  80178f:	74 0b                	je     80179c <__udivdi3+0xf0>
  801791:	89 d8                	mov    %ebx,%eax
  801793:	31 ff                	xor    %edi,%edi
  801795:	e9 58 ff ff ff       	jmp    8016f2 <__udivdi3+0x46>
  80179a:	66 90                	xchg   %ax,%ax
  80179c:	8b 54 24 08          	mov    0x8(%esp),%edx
  8017a0:	89 f9                	mov    %edi,%ecx
  8017a2:	d3 e2                	shl    %cl,%edx
  8017a4:	39 c2                	cmp    %eax,%edx
  8017a6:	73 e9                	jae    801791 <__udivdi3+0xe5>
  8017a8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8017ab:	31 ff                	xor    %edi,%edi
  8017ad:	e9 40 ff ff ff       	jmp    8016f2 <__udivdi3+0x46>
  8017b2:	66 90                	xchg   %ax,%ax
  8017b4:	31 c0                	xor    %eax,%eax
  8017b6:	e9 37 ff ff ff       	jmp    8016f2 <__udivdi3+0x46>
  8017bb:	90                   	nop

008017bc <__umoddi3>:
  8017bc:	55                   	push   %ebp
  8017bd:	57                   	push   %edi
  8017be:	56                   	push   %esi
  8017bf:	53                   	push   %ebx
  8017c0:	83 ec 1c             	sub    $0x1c,%esp
  8017c3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8017c7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8017cb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017cf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8017d3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8017d7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8017db:	89 f3                	mov    %esi,%ebx
  8017dd:	89 fa                	mov    %edi,%edx
  8017df:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8017e3:	89 34 24             	mov    %esi,(%esp)
  8017e6:	85 c0                	test   %eax,%eax
  8017e8:	75 1a                	jne    801804 <__umoddi3+0x48>
  8017ea:	39 f7                	cmp    %esi,%edi
  8017ec:	0f 86 a2 00 00 00    	jbe    801894 <__umoddi3+0xd8>
  8017f2:	89 c8                	mov    %ecx,%eax
  8017f4:	89 f2                	mov    %esi,%edx
  8017f6:	f7 f7                	div    %edi
  8017f8:	89 d0                	mov    %edx,%eax
  8017fa:	31 d2                	xor    %edx,%edx
  8017fc:	83 c4 1c             	add    $0x1c,%esp
  8017ff:	5b                   	pop    %ebx
  801800:	5e                   	pop    %esi
  801801:	5f                   	pop    %edi
  801802:	5d                   	pop    %ebp
  801803:	c3                   	ret    
  801804:	39 f0                	cmp    %esi,%eax
  801806:	0f 87 ac 00 00 00    	ja     8018b8 <__umoddi3+0xfc>
  80180c:	0f bd e8             	bsr    %eax,%ebp
  80180f:	83 f5 1f             	xor    $0x1f,%ebp
  801812:	0f 84 ac 00 00 00    	je     8018c4 <__umoddi3+0x108>
  801818:	bf 20 00 00 00       	mov    $0x20,%edi
  80181d:	29 ef                	sub    %ebp,%edi
  80181f:	89 fe                	mov    %edi,%esi
  801821:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801825:	89 e9                	mov    %ebp,%ecx
  801827:	d3 e0                	shl    %cl,%eax
  801829:	89 d7                	mov    %edx,%edi
  80182b:	89 f1                	mov    %esi,%ecx
  80182d:	d3 ef                	shr    %cl,%edi
  80182f:	09 c7                	or     %eax,%edi
  801831:	89 e9                	mov    %ebp,%ecx
  801833:	d3 e2                	shl    %cl,%edx
  801835:	89 14 24             	mov    %edx,(%esp)
  801838:	89 d8                	mov    %ebx,%eax
  80183a:	d3 e0                	shl    %cl,%eax
  80183c:	89 c2                	mov    %eax,%edx
  80183e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801842:	d3 e0                	shl    %cl,%eax
  801844:	89 44 24 04          	mov    %eax,0x4(%esp)
  801848:	8b 44 24 08          	mov    0x8(%esp),%eax
  80184c:	89 f1                	mov    %esi,%ecx
  80184e:	d3 e8                	shr    %cl,%eax
  801850:	09 d0                	or     %edx,%eax
  801852:	d3 eb                	shr    %cl,%ebx
  801854:	89 da                	mov    %ebx,%edx
  801856:	f7 f7                	div    %edi
  801858:	89 d3                	mov    %edx,%ebx
  80185a:	f7 24 24             	mull   (%esp)
  80185d:	89 c6                	mov    %eax,%esi
  80185f:	89 d1                	mov    %edx,%ecx
  801861:	39 d3                	cmp    %edx,%ebx
  801863:	0f 82 87 00 00 00    	jb     8018f0 <__umoddi3+0x134>
  801869:	0f 84 91 00 00 00    	je     801900 <__umoddi3+0x144>
  80186f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801873:	29 f2                	sub    %esi,%edx
  801875:	19 cb                	sbb    %ecx,%ebx
  801877:	89 d8                	mov    %ebx,%eax
  801879:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80187d:	d3 e0                	shl    %cl,%eax
  80187f:	89 e9                	mov    %ebp,%ecx
  801881:	d3 ea                	shr    %cl,%edx
  801883:	09 d0                	or     %edx,%eax
  801885:	89 e9                	mov    %ebp,%ecx
  801887:	d3 eb                	shr    %cl,%ebx
  801889:	89 da                	mov    %ebx,%edx
  80188b:	83 c4 1c             	add    $0x1c,%esp
  80188e:	5b                   	pop    %ebx
  80188f:	5e                   	pop    %esi
  801890:	5f                   	pop    %edi
  801891:	5d                   	pop    %ebp
  801892:	c3                   	ret    
  801893:	90                   	nop
  801894:	89 fd                	mov    %edi,%ebp
  801896:	85 ff                	test   %edi,%edi
  801898:	75 0b                	jne    8018a5 <__umoddi3+0xe9>
  80189a:	b8 01 00 00 00       	mov    $0x1,%eax
  80189f:	31 d2                	xor    %edx,%edx
  8018a1:	f7 f7                	div    %edi
  8018a3:	89 c5                	mov    %eax,%ebp
  8018a5:	89 f0                	mov    %esi,%eax
  8018a7:	31 d2                	xor    %edx,%edx
  8018a9:	f7 f5                	div    %ebp
  8018ab:	89 c8                	mov    %ecx,%eax
  8018ad:	f7 f5                	div    %ebp
  8018af:	89 d0                	mov    %edx,%eax
  8018b1:	e9 44 ff ff ff       	jmp    8017fa <__umoddi3+0x3e>
  8018b6:	66 90                	xchg   %ax,%ax
  8018b8:	89 c8                	mov    %ecx,%eax
  8018ba:	89 f2                	mov    %esi,%edx
  8018bc:	83 c4 1c             	add    $0x1c,%esp
  8018bf:	5b                   	pop    %ebx
  8018c0:	5e                   	pop    %esi
  8018c1:	5f                   	pop    %edi
  8018c2:	5d                   	pop    %ebp
  8018c3:	c3                   	ret    
  8018c4:	3b 04 24             	cmp    (%esp),%eax
  8018c7:	72 06                	jb     8018cf <__umoddi3+0x113>
  8018c9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8018cd:	77 0f                	ja     8018de <__umoddi3+0x122>
  8018cf:	89 f2                	mov    %esi,%edx
  8018d1:	29 f9                	sub    %edi,%ecx
  8018d3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8018d7:	89 14 24             	mov    %edx,(%esp)
  8018da:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018de:	8b 44 24 04          	mov    0x4(%esp),%eax
  8018e2:	8b 14 24             	mov    (%esp),%edx
  8018e5:	83 c4 1c             	add    $0x1c,%esp
  8018e8:	5b                   	pop    %ebx
  8018e9:	5e                   	pop    %esi
  8018ea:	5f                   	pop    %edi
  8018eb:	5d                   	pop    %ebp
  8018ec:	c3                   	ret    
  8018ed:	8d 76 00             	lea    0x0(%esi),%esi
  8018f0:	2b 04 24             	sub    (%esp),%eax
  8018f3:	19 fa                	sbb    %edi,%edx
  8018f5:	89 d1                	mov    %edx,%ecx
  8018f7:	89 c6                	mov    %eax,%esi
  8018f9:	e9 71 ff ff ff       	jmp    80186f <__umoddi3+0xb3>
  8018fe:	66 90                	xchg   %ax,%ax
  801900:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801904:	72 ea                	jb     8018f0 <__umoddi3+0x134>
  801906:	89 d9                	mov    %ebx,%ecx
  801908:	e9 62 ff ff ff       	jmp    80186f <__umoddi3+0xb3>
