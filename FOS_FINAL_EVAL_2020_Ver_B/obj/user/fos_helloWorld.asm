
obj/user/fos_helloWorld:     file format elf32-i386


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
  800031:	e8 31 00 00 00       	call   800067 <libmain>
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
  80003b:	83 ec 08             	sub    $0x8,%esp
	extern unsigned char * etext;
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D %d\n",4);		
	atomic_cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D \n");
  80003e:	83 ec 0c             	sub    $0xc,%esp
  800041:	68 e0 18 80 00       	push   $0x8018e0
  800046:	e8 42 02 00 00       	call   80028d <atomic_cprintf>
  80004b:	83 c4 10             	add    $0x10,%esp
	atomic_cprintf("end of code = %x\n",etext);
  80004e:	a1 c5 18 80 00       	mov    0x8018c5,%eax
  800053:	83 ec 08             	sub    $0x8,%esp
  800056:	50                   	push   %eax
  800057:	68 08 19 80 00       	push   $0x801908
  80005c:	e8 2c 02 00 00       	call   80028d <atomic_cprintf>
  800061:	83 c4 10             	add    $0x10,%esp
}
  800064:	90                   	nop
  800065:	c9                   	leave  
  800066:	c3                   	ret    

00800067 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800067:	55                   	push   %ebp
  800068:	89 e5                	mov    %esp,%ebp
  80006a:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80006d:	e8 19 10 00 00       	call   80108b <sys_getenvindex>
  800072:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800075:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800078:	89 d0                	mov    %edx,%eax
  80007a:	c1 e0 03             	shl    $0x3,%eax
  80007d:	01 d0                	add    %edx,%eax
  80007f:	c1 e0 02             	shl    $0x2,%eax
  800082:	01 d0                	add    %edx,%eax
  800084:	c1 e0 06             	shl    $0x6,%eax
  800087:	29 d0                	sub    %edx,%eax
  800089:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800090:	01 c8                	add    %ecx,%eax
  800092:	01 d0                	add    %edx,%eax
  800094:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800099:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80009e:	a1 20 20 80 00       	mov    0x802020,%eax
  8000a3:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  8000a9:	84 c0                	test   %al,%al
  8000ab:	74 0f                	je     8000bc <libmain+0x55>
		binaryname = myEnv->prog_name;
  8000ad:	a1 20 20 80 00       	mov    0x802020,%eax
  8000b2:	05 b0 52 00 00       	add    $0x52b0,%eax
  8000b7:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000bc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000c0:	7e 0a                	jle    8000cc <libmain+0x65>
		binaryname = argv[0];
  8000c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000c5:	8b 00                	mov    (%eax),%eax
  8000c7:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000cc:	83 ec 08             	sub    $0x8,%esp
  8000cf:	ff 75 0c             	pushl  0xc(%ebp)
  8000d2:	ff 75 08             	pushl  0x8(%ebp)
  8000d5:	e8 5e ff ff ff       	call   800038 <_main>
  8000da:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000dd:	e8 44 11 00 00       	call   801226 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000e2:	83 ec 0c             	sub    $0xc,%esp
  8000e5:	68 34 19 80 00       	push   $0x801934
  8000ea:	e8 71 01 00 00       	call   800260 <cprintf>
  8000ef:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8000f2:	a1 20 20 80 00       	mov    0x802020,%eax
  8000f7:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  8000fd:	a1 20 20 80 00       	mov    0x802020,%eax
  800102:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  800108:	83 ec 04             	sub    $0x4,%esp
  80010b:	52                   	push   %edx
  80010c:	50                   	push   %eax
  80010d:	68 5c 19 80 00       	push   $0x80195c
  800112:	e8 49 01 00 00       	call   800260 <cprintf>
  800117:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80011a:	a1 20 20 80 00       	mov    0x802020,%eax
  80011f:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  800125:	a1 20 20 80 00       	mov    0x802020,%eax
  80012a:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  800130:	a1 20 20 80 00       	mov    0x802020,%eax
  800135:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  80013b:	51                   	push   %ecx
  80013c:	52                   	push   %edx
  80013d:	50                   	push   %eax
  80013e:	68 84 19 80 00       	push   $0x801984
  800143:	e8 18 01 00 00       	call   800260 <cprintf>
  800148:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80014b:	83 ec 0c             	sub    $0xc,%esp
  80014e:	68 34 19 80 00       	push   $0x801934
  800153:	e8 08 01 00 00       	call   800260 <cprintf>
  800158:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80015b:	e8 e0 10 00 00       	call   801240 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800160:	e8 19 00 00 00       	call   80017e <exit>
}
  800165:	90                   	nop
  800166:	c9                   	leave  
  800167:	c3                   	ret    

00800168 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800168:	55                   	push   %ebp
  800169:	89 e5                	mov    %esp,%ebp
  80016b:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80016e:	83 ec 0c             	sub    $0xc,%esp
  800171:	6a 00                	push   $0x0
  800173:	e8 df 0e 00 00       	call   801057 <sys_env_destroy>
  800178:	83 c4 10             	add    $0x10,%esp
}
  80017b:	90                   	nop
  80017c:	c9                   	leave  
  80017d:	c3                   	ret    

0080017e <exit>:

void
exit(void)
{
  80017e:	55                   	push   %ebp
  80017f:	89 e5                	mov    %esp,%ebp
  800181:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800184:	e8 34 0f 00 00       	call   8010bd <sys_env_exit>
}
  800189:	90                   	nop
  80018a:	c9                   	leave  
  80018b:	c3                   	ret    

0080018c <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80018c:	55                   	push   %ebp
  80018d:	89 e5                	mov    %esp,%ebp
  80018f:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800192:	8b 45 0c             	mov    0xc(%ebp),%eax
  800195:	8b 00                	mov    (%eax),%eax
  800197:	8d 48 01             	lea    0x1(%eax),%ecx
  80019a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80019d:	89 0a                	mov    %ecx,(%edx)
  80019f:	8b 55 08             	mov    0x8(%ebp),%edx
  8001a2:	88 d1                	mov    %dl,%cl
  8001a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001a7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ae:	8b 00                	mov    (%eax),%eax
  8001b0:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001b5:	75 2c                	jne    8001e3 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001b7:	a0 24 20 80 00       	mov    0x802024,%al
  8001bc:	0f b6 c0             	movzbl %al,%eax
  8001bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001c2:	8b 12                	mov    (%edx),%edx
  8001c4:	89 d1                	mov    %edx,%ecx
  8001c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001c9:	83 c2 08             	add    $0x8,%edx
  8001cc:	83 ec 04             	sub    $0x4,%esp
  8001cf:	50                   	push   %eax
  8001d0:	51                   	push   %ecx
  8001d1:	52                   	push   %edx
  8001d2:	e8 3e 0e 00 00       	call   801015 <sys_cputs>
  8001d7:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001e6:	8b 40 04             	mov    0x4(%eax),%eax
  8001e9:	8d 50 01             	lea    0x1(%eax),%edx
  8001ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ef:	89 50 04             	mov    %edx,0x4(%eax)
}
  8001f2:	90                   	nop
  8001f3:	c9                   	leave  
  8001f4:	c3                   	ret    

008001f5 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8001f5:	55                   	push   %ebp
  8001f6:	89 e5                	mov    %esp,%ebp
  8001f8:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8001fe:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800205:	00 00 00 
	b.cnt = 0;
  800208:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80020f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800212:	ff 75 0c             	pushl  0xc(%ebp)
  800215:	ff 75 08             	pushl  0x8(%ebp)
  800218:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80021e:	50                   	push   %eax
  80021f:	68 8c 01 80 00       	push   $0x80018c
  800224:	e8 11 02 00 00       	call   80043a <vprintfmt>
  800229:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80022c:	a0 24 20 80 00       	mov    0x802024,%al
  800231:	0f b6 c0             	movzbl %al,%eax
  800234:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80023a:	83 ec 04             	sub    $0x4,%esp
  80023d:	50                   	push   %eax
  80023e:	52                   	push   %edx
  80023f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800245:	83 c0 08             	add    $0x8,%eax
  800248:	50                   	push   %eax
  800249:	e8 c7 0d 00 00       	call   801015 <sys_cputs>
  80024e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800251:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  800258:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80025e:	c9                   	leave  
  80025f:	c3                   	ret    

00800260 <cprintf>:

int cprintf(const char *fmt, ...) {
  800260:	55                   	push   %ebp
  800261:	89 e5                	mov    %esp,%ebp
  800263:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800266:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  80026d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800270:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800273:	8b 45 08             	mov    0x8(%ebp),%eax
  800276:	83 ec 08             	sub    $0x8,%esp
  800279:	ff 75 f4             	pushl  -0xc(%ebp)
  80027c:	50                   	push   %eax
  80027d:	e8 73 ff ff ff       	call   8001f5 <vcprintf>
  800282:	83 c4 10             	add    $0x10,%esp
  800285:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800288:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80028b:	c9                   	leave  
  80028c:	c3                   	ret    

0080028d <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80028d:	55                   	push   %ebp
  80028e:	89 e5                	mov    %esp,%ebp
  800290:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800293:	e8 8e 0f 00 00       	call   801226 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800298:	8d 45 0c             	lea    0xc(%ebp),%eax
  80029b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80029e:	8b 45 08             	mov    0x8(%ebp),%eax
  8002a1:	83 ec 08             	sub    $0x8,%esp
  8002a4:	ff 75 f4             	pushl  -0xc(%ebp)
  8002a7:	50                   	push   %eax
  8002a8:	e8 48 ff ff ff       	call   8001f5 <vcprintf>
  8002ad:	83 c4 10             	add    $0x10,%esp
  8002b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002b3:	e8 88 0f 00 00       	call   801240 <sys_enable_interrupt>
	return cnt;
  8002b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002bb:	c9                   	leave  
  8002bc:	c3                   	ret    

008002bd <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002bd:	55                   	push   %ebp
  8002be:	89 e5                	mov    %esp,%ebp
  8002c0:	53                   	push   %ebx
  8002c1:	83 ec 14             	sub    $0x14,%esp
  8002c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8002c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8002cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002d0:	8b 45 18             	mov    0x18(%ebp),%eax
  8002d3:	ba 00 00 00 00       	mov    $0x0,%edx
  8002d8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002db:	77 55                	ja     800332 <printnum+0x75>
  8002dd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002e0:	72 05                	jb     8002e7 <printnum+0x2a>
  8002e2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002e5:	77 4b                	ja     800332 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8002e7:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8002ea:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8002ed:	8b 45 18             	mov    0x18(%ebp),%eax
  8002f0:	ba 00 00 00 00       	mov    $0x0,%edx
  8002f5:	52                   	push   %edx
  8002f6:	50                   	push   %eax
  8002f7:	ff 75 f4             	pushl  -0xc(%ebp)
  8002fa:	ff 75 f0             	pushl  -0x10(%ebp)
  8002fd:	e8 62 13 00 00       	call   801664 <__udivdi3>
  800302:	83 c4 10             	add    $0x10,%esp
  800305:	83 ec 04             	sub    $0x4,%esp
  800308:	ff 75 20             	pushl  0x20(%ebp)
  80030b:	53                   	push   %ebx
  80030c:	ff 75 18             	pushl  0x18(%ebp)
  80030f:	52                   	push   %edx
  800310:	50                   	push   %eax
  800311:	ff 75 0c             	pushl  0xc(%ebp)
  800314:	ff 75 08             	pushl  0x8(%ebp)
  800317:	e8 a1 ff ff ff       	call   8002bd <printnum>
  80031c:	83 c4 20             	add    $0x20,%esp
  80031f:	eb 1a                	jmp    80033b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800321:	83 ec 08             	sub    $0x8,%esp
  800324:	ff 75 0c             	pushl  0xc(%ebp)
  800327:	ff 75 20             	pushl  0x20(%ebp)
  80032a:	8b 45 08             	mov    0x8(%ebp),%eax
  80032d:	ff d0                	call   *%eax
  80032f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800332:	ff 4d 1c             	decl   0x1c(%ebp)
  800335:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800339:	7f e6                	jg     800321 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80033b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80033e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800343:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800346:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800349:	53                   	push   %ebx
  80034a:	51                   	push   %ecx
  80034b:	52                   	push   %edx
  80034c:	50                   	push   %eax
  80034d:	e8 22 14 00 00       	call   801774 <__umoddi3>
  800352:	83 c4 10             	add    $0x10,%esp
  800355:	05 f4 1b 80 00       	add    $0x801bf4,%eax
  80035a:	8a 00                	mov    (%eax),%al
  80035c:	0f be c0             	movsbl %al,%eax
  80035f:	83 ec 08             	sub    $0x8,%esp
  800362:	ff 75 0c             	pushl  0xc(%ebp)
  800365:	50                   	push   %eax
  800366:	8b 45 08             	mov    0x8(%ebp),%eax
  800369:	ff d0                	call   *%eax
  80036b:	83 c4 10             	add    $0x10,%esp
}
  80036e:	90                   	nop
  80036f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800372:	c9                   	leave  
  800373:	c3                   	ret    

00800374 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800374:	55                   	push   %ebp
  800375:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800377:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80037b:	7e 1c                	jle    800399 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80037d:	8b 45 08             	mov    0x8(%ebp),%eax
  800380:	8b 00                	mov    (%eax),%eax
  800382:	8d 50 08             	lea    0x8(%eax),%edx
  800385:	8b 45 08             	mov    0x8(%ebp),%eax
  800388:	89 10                	mov    %edx,(%eax)
  80038a:	8b 45 08             	mov    0x8(%ebp),%eax
  80038d:	8b 00                	mov    (%eax),%eax
  80038f:	83 e8 08             	sub    $0x8,%eax
  800392:	8b 50 04             	mov    0x4(%eax),%edx
  800395:	8b 00                	mov    (%eax),%eax
  800397:	eb 40                	jmp    8003d9 <getuint+0x65>
	else if (lflag)
  800399:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80039d:	74 1e                	je     8003bd <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80039f:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a2:	8b 00                	mov    (%eax),%eax
  8003a4:	8d 50 04             	lea    0x4(%eax),%edx
  8003a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003aa:	89 10                	mov    %edx,(%eax)
  8003ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8003af:	8b 00                	mov    (%eax),%eax
  8003b1:	83 e8 04             	sub    $0x4,%eax
  8003b4:	8b 00                	mov    (%eax),%eax
  8003b6:	ba 00 00 00 00       	mov    $0x0,%edx
  8003bb:	eb 1c                	jmp    8003d9 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c0:	8b 00                	mov    (%eax),%eax
  8003c2:	8d 50 04             	lea    0x4(%eax),%edx
  8003c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c8:	89 10                	mov    %edx,(%eax)
  8003ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cd:	8b 00                	mov    (%eax),%eax
  8003cf:	83 e8 04             	sub    $0x4,%eax
  8003d2:	8b 00                	mov    (%eax),%eax
  8003d4:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003d9:	5d                   	pop    %ebp
  8003da:	c3                   	ret    

008003db <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003db:	55                   	push   %ebp
  8003dc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003de:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003e2:	7e 1c                	jle    800400 <getint+0x25>
		return va_arg(*ap, long long);
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
  8003fe:	eb 38                	jmp    800438 <getint+0x5d>
	else if (lflag)
  800400:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800404:	74 1a                	je     800420 <getint+0x45>
		return va_arg(*ap, long);
  800406:	8b 45 08             	mov    0x8(%ebp),%eax
  800409:	8b 00                	mov    (%eax),%eax
  80040b:	8d 50 04             	lea    0x4(%eax),%edx
  80040e:	8b 45 08             	mov    0x8(%ebp),%eax
  800411:	89 10                	mov    %edx,(%eax)
  800413:	8b 45 08             	mov    0x8(%ebp),%eax
  800416:	8b 00                	mov    (%eax),%eax
  800418:	83 e8 04             	sub    $0x4,%eax
  80041b:	8b 00                	mov    (%eax),%eax
  80041d:	99                   	cltd   
  80041e:	eb 18                	jmp    800438 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800420:	8b 45 08             	mov    0x8(%ebp),%eax
  800423:	8b 00                	mov    (%eax),%eax
  800425:	8d 50 04             	lea    0x4(%eax),%edx
  800428:	8b 45 08             	mov    0x8(%ebp),%eax
  80042b:	89 10                	mov    %edx,(%eax)
  80042d:	8b 45 08             	mov    0x8(%ebp),%eax
  800430:	8b 00                	mov    (%eax),%eax
  800432:	83 e8 04             	sub    $0x4,%eax
  800435:	8b 00                	mov    (%eax),%eax
  800437:	99                   	cltd   
}
  800438:	5d                   	pop    %ebp
  800439:	c3                   	ret    

0080043a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80043a:	55                   	push   %ebp
  80043b:	89 e5                	mov    %esp,%ebp
  80043d:	56                   	push   %esi
  80043e:	53                   	push   %ebx
  80043f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800442:	eb 17                	jmp    80045b <vprintfmt+0x21>
			if (ch == '\0')
  800444:	85 db                	test   %ebx,%ebx
  800446:	0f 84 af 03 00 00    	je     8007fb <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80044c:	83 ec 08             	sub    $0x8,%esp
  80044f:	ff 75 0c             	pushl  0xc(%ebp)
  800452:	53                   	push   %ebx
  800453:	8b 45 08             	mov    0x8(%ebp),%eax
  800456:	ff d0                	call   *%eax
  800458:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80045b:	8b 45 10             	mov    0x10(%ebp),%eax
  80045e:	8d 50 01             	lea    0x1(%eax),%edx
  800461:	89 55 10             	mov    %edx,0x10(%ebp)
  800464:	8a 00                	mov    (%eax),%al
  800466:	0f b6 d8             	movzbl %al,%ebx
  800469:	83 fb 25             	cmp    $0x25,%ebx
  80046c:	75 d6                	jne    800444 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80046e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800472:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800479:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800480:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800487:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80048e:	8b 45 10             	mov    0x10(%ebp),%eax
  800491:	8d 50 01             	lea    0x1(%eax),%edx
  800494:	89 55 10             	mov    %edx,0x10(%ebp)
  800497:	8a 00                	mov    (%eax),%al
  800499:	0f b6 d8             	movzbl %al,%ebx
  80049c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80049f:	83 f8 55             	cmp    $0x55,%eax
  8004a2:	0f 87 2b 03 00 00    	ja     8007d3 <vprintfmt+0x399>
  8004a8:	8b 04 85 18 1c 80 00 	mov    0x801c18(,%eax,4),%eax
  8004af:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004b1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004b5:	eb d7                	jmp    80048e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004b7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004bb:	eb d1                	jmp    80048e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004bd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004c4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004c7:	89 d0                	mov    %edx,%eax
  8004c9:	c1 e0 02             	shl    $0x2,%eax
  8004cc:	01 d0                	add    %edx,%eax
  8004ce:	01 c0                	add    %eax,%eax
  8004d0:	01 d8                	add    %ebx,%eax
  8004d2:	83 e8 30             	sub    $0x30,%eax
  8004d5:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8004db:	8a 00                	mov    (%eax),%al
  8004dd:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004e0:	83 fb 2f             	cmp    $0x2f,%ebx
  8004e3:	7e 3e                	jle    800523 <vprintfmt+0xe9>
  8004e5:	83 fb 39             	cmp    $0x39,%ebx
  8004e8:	7f 39                	jg     800523 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004ea:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8004ed:	eb d5                	jmp    8004c4 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8004ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8004f2:	83 c0 04             	add    $0x4,%eax
  8004f5:	89 45 14             	mov    %eax,0x14(%ebp)
  8004f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8004fb:	83 e8 04             	sub    $0x4,%eax
  8004fe:	8b 00                	mov    (%eax),%eax
  800500:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800503:	eb 1f                	jmp    800524 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800505:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800509:	79 83                	jns    80048e <vprintfmt+0x54>
				width = 0;
  80050b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800512:	e9 77 ff ff ff       	jmp    80048e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800517:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80051e:	e9 6b ff ff ff       	jmp    80048e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800523:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800524:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800528:	0f 89 60 ff ff ff    	jns    80048e <vprintfmt+0x54>
				width = precision, precision = -1;
  80052e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800531:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800534:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80053b:	e9 4e ff ff ff       	jmp    80048e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800540:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800543:	e9 46 ff ff ff       	jmp    80048e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800548:	8b 45 14             	mov    0x14(%ebp),%eax
  80054b:	83 c0 04             	add    $0x4,%eax
  80054e:	89 45 14             	mov    %eax,0x14(%ebp)
  800551:	8b 45 14             	mov    0x14(%ebp),%eax
  800554:	83 e8 04             	sub    $0x4,%eax
  800557:	8b 00                	mov    (%eax),%eax
  800559:	83 ec 08             	sub    $0x8,%esp
  80055c:	ff 75 0c             	pushl  0xc(%ebp)
  80055f:	50                   	push   %eax
  800560:	8b 45 08             	mov    0x8(%ebp),%eax
  800563:	ff d0                	call   *%eax
  800565:	83 c4 10             	add    $0x10,%esp
			break;
  800568:	e9 89 02 00 00       	jmp    8007f6 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80056d:	8b 45 14             	mov    0x14(%ebp),%eax
  800570:	83 c0 04             	add    $0x4,%eax
  800573:	89 45 14             	mov    %eax,0x14(%ebp)
  800576:	8b 45 14             	mov    0x14(%ebp),%eax
  800579:	83 e8 04             	sub    $0x4,%eax
  80057c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80057e:	85 db                	test   %ebx,%ebx
  800580:	79 02                	jns    800584 <vprintfmt+0x14a>
				err = -err;
  800582:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800584:	83 fb 64             	cmp    $0x64,%ebx
  800587:	7f 0b                	jg     800594 <vprintfmt+0x15a>
  800589:	8b 34 9d 60 1a 80 00 	mov    0x801a60(,%ebx,4),%esi
  800590:	85 f6                	test   %esi,%esi
  800592:	75 19                	jne    8005ad <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800594:	53                   	push   %ebx
  800595:	68 05 1c 80 00       	push   $0x801c05
  80059a:	ff 75 0c             	pushl  0xc(%ebp)
  80059d:	ff 75 08             	pushl  0x8(%ebp)
  8005a0:	e8 5e 02 00 00       	call   800803 <printfmt>
  8005a5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005a8:	e9 49 02 00 00       	jmp    8007f6 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005ad:	56                   	push   %esi
  8005ae:	68 0e 1c 80 00       	push   $0x801c0e
  8005b3:	ff 75 0c             	pushl  0xc(%ebp)
  8005b6:	ff 75 08             	pushl  0x8(%ebp)
  8005b9:	e8 45 02 00 00       	call   800803 <printfmt>
  8005be:	83 c4 10             	add    $0x10,%esp
			break;
  8005c1:	e9 30 02 00 00       	jmp    8007f6 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c9:	83 c0 04             	add    $0x4,%eax
  8005cc:	89 45 14             	mov    %eax,0x14(%ebp)
  8005cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d2:	83 e8 04             	sub    $0x4,%eax
  8005d5:	8b 30                	mov    (%eax),%esi
  8005d7:	85 f6                	test   %esi,%esi
  8005d9:	75 05                	jne    8005e0 <vprintfmt+0x1a6>
				p = "(null)";
  8005db:	be 11 1c 80 00       	mov    $0x801c11,%esi
			if (width > 0 && padc != '-')
  8005e0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005e4:	7e 6d                	jle    800653 <vprintfmt+0x219>
  8005e6:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8005ea:	74 67                	je     800653 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8005ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005ef:	83 ec 08             	sub    $0x8,%esp
  8005f2:	50                   	push   %eax
  8005f3:	56                   	push   %esi
  8005f4:	e8 0c 03 00 00       	call   800905 <strnlen>
  8005f9:	83 c4 10             	add    $0x10,%esp
  8005fc:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8005ff:	eb 16                	jmp    800617 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800601:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800605:	83 ec 08             	sub    $0x8,%esp
  800608:	ff 75 0c             	pushl  0xc(%ebp)
  80060b:	50                   	push   %eax
  80060c:	8b 45 08             	mov    0x8(%ebp),%eax
  80060f:	ff d0                	call   *%eax
  800611:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800614:	ff 4d e4             	decl   -0x1c(%ebp)
  800617:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80061b:	7f e4                	jg     800601 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80061d:	eb 34                	jmp    800653 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80061f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800623:	74 1c                	je     800641 <vprintfmt+0x207>
  800625:	83 fb 1f             	cmp    $0x1f,%ebx
  800628:	7e 05                	jle    80062f <vprintfmt+0x1f5>
  80062a:	83 fb 7e             	cmp    $0x7e,%ebx
  80062d:	7e 12                	jle    800641 <vprintfmt+0x207>
					putch('?', putdat);
  80062f:	83 ec 08             	sub    $0x8,%esp
  800632:	ff 75 0c             	pushl  0xc(%ebp)
  800635:	6a 3f                	push   $0x3f
  800637:	8b 45 08             	mov    0x8(%ebp),%eax
  80063a:	ff d0                	call   *%eax
  80063c:	83 c4 10             	add    $0x10,%esp
  80063f:	eb 0f                	jmp    800650 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800641:	83 ec 08             	sub    $0x8,%esp
  800644:	ff 75 0c             	pushl  0xc(%ebp)
  800647:	53                   	push   %ebx
  800648:	8b 45 08             	mov    0x8(%ebp),%eax
  80064b:	ff d0                	call   *%eax
  80064d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800650:	ff 4d e4             	decl   -0x1c(%ebp)
  800653:	89 f0                	mov    %esi,%eax
  800655:	8d 70 01             	lea    0x1(%eax),%esi
  800658:	8a 00                	mov    (%eax),%al
  80065a:	0f be d8             	movsbl %al,%ebx
  80065d:	85 db                	test   %ebx,%ebx
  80065f:	74 24                	je     800685 <vprintfmt+0x24b>
  800661:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800665:	78 b8                	js     80061f <vprintfmt+0x1e5>
  800667:	ff 4d e0             	decl   -0x20(%ebp)
  80066a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80066e:	79 af                	jns    80061f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800670:	eb 13                	jmp    800685 <vprintfmt+0x24b>
				putch(' ', putdat);
  800672:	83 ec 08             	sub    $0x8,%esp
  800675:	ff 75 0c             	pushl  0xc(%ebp)
  800678:	6a 20                	push   $0x20
  80067a:	8b 45 08             	mov    0x8(%ebp),%eax
  80067d:	ff d0                	call   *%eax
  80067f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800682:	ff 4d e4             	decl   -0x1c(%ebp)
  800685:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800689:	7f e7                	jg     800672 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80068b:	e9 66 01 00 00       	jmp    8007f6 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800690:	83 ec 08             	sub    $0x8,%esp
  800693:	ff 75 e8             	pushl  -0x18(%ebp)
  800696:	8d 45 14             	lea    0x14(%ebp),%eax
  800699:	50                   	push   %eax
  80069a:	e8 3c fd ff ff       	call   8003db <getint>
  80069f:	83 c4 10             	add    $0x10,%esp
  8006a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006a5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006ae:	85 d2                	test   %edx,%edx
  8006b0:	79 23                	jns    8006d5 <vprintfmt+0x29b>
				putch('-', putdat);
  8006b2:	83 ec 08             	sub    $0x8,%esp
  8006b5:	ff 75 0c             	pushl  0xc(%ebp)
  8006b8:	6a 2d                	push   $0x2d
  8006ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bd:	ff d0                	call   *%eax
  8006bf:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006c8:	f7 d8                	neg    %eax
  8006ca:	83 d2 00             	adc    $0x0,%edx
  8006cd:	f7 da                	neg    %edx
  8006cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006d2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006d5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006dc:	e9 bc 00 00 00       	jmp    80079d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006e1:	83 ec 08             	sub    $0x8,%esp
  8006e4:	ff 75 e8             	pushl  -0x18(%ebp)
  8006e7:	8d 45 14             	lea    0x14(%ebp),%eax
  8006ea:	50                   	push   %eax
  8006eb:	e8 84 fc ff ff       	call   800374 <getuint>
  8006f0:	83 c4 10             	add    $0x10,%esp
  8006f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006f6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8006f9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800700:	e9 98 00 00 00       	jmp    80079d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
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
			putch('X', putdat);
  800725:	83 ec 08             	sub    $0x8,%esp
  800728:	ff 75 0c             	pushl  0xc(%ebp)
  80072b:	6a 58                	push   $0x58
  80072d:	8b 45 08             	mov    0x8(%ebp),%eax
  800730:	ff d0                	call   *%eax
  800732:	83 c4 10             	add    $0x10,%esp
			break;
  800735:	e9 bc 00 00 00       	jmp    8007f6 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80073a:	83 ec 08             	sub    $0x8,%esp
  80073d:	ff 75 0c             	pushl  0xc(%ebp)
  800740:	6a 30                	push   $0x30
  800742:	8b 45 08             	mov    0x8(%ebp),%eax
  800745:	ff d0                	call   *%eax
  800747:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80074a:	83 ec 08             	sub    $0x8,%esp
  80074d:	ff 75 0c             	pushl  0xc(%ebp)
  800750:	6a 78                	push   $0x78
  800752:	8b 45 08             	mov    0x8(%ebp),%eax
  800755:	ff d0                	call   *%eax
  800757:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80075a:	8b 45 14             	mov    0x14(%ebp),%eax
  80075d:	83 c0 04             	add    $0x4,%eax
  800760:	89 45 14             	mov    %eax,0x14(%ebp)
  800763:	8b 45 14             	mov    0x14(%ebp),%eax
  800766:	83 e8 04             	sub    $0x4,%eax
  800769:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80076b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80076e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800775:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80077c:	eb 1f                	jmp    80079d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80077e:	83 ec 08             	sub    $0x8,%esp
  800781:	ff 75 e8             	pushl  -0x18(%ebp)
  800784:	8d 45 14             	lea    0x14(%ebp),%eax
  800787:	50                   	push   %eax
  800788:	e8 e7 fb ff ff       	call   800374 <getuint>
  80078d:	83 c4 10             	add    $0x10,%esp
  800790:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800793:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800796:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80079d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007a4:	83 ec 04             	sub    $0x4,%esp
  8007a7:	52                   	push   %edx
  8007a8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007ab:	50                   	push   %eax
  8007ac:	ff 75 f4             	pushl  -0xc(%ebp)
  8007af:	ff 75 f0             	pushl  -0x10(%ebp)
  8007b2:	ff 75 0c             	pushl  0xc(%ebp)
  8007b5:	ff 75 08             	pushl  0x8(%ebp)
  8007b8:	e8 00 fb ff ff       	call   8002bd <printnum>
  8007bd:	83 c4 20             	add    $0x20,%esp
			break;
  8007c0:	eb 34                	jmp    8007f6 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007c2:	83 ec 08             	sub    $0x8,%esp
  8007c5:	ff 75 0c             	pushl  0xc(%ebp)
  8007c8:	53                   	push   %ebx
  8007c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cc:	ff d0                	call   *%eax
  8007ce:	83 c4 10             	add    $0x10,%esp
			break;
  8007d1:	eb 23                	jmp    8007f6 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007d3:	83 ec 08             	sub    $0x8,%esp
  8007d6:	ff 75 0c             	pushl  0xc(%ebp)
  8007d9:	6a 25                	push   $0x25
  8007db:	8b 45 08             	mov    0x8(%ebp),%eax
  8007de:	ff d0                	call   *%eax
  8007e0:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007e3:	ff 4d 10             	decl   0x10(%ebp)
  8007e6:	eb 03                	jmp    8007eb <vprintfmt+0x3b1>
  8007e8:	ff 4d 10             	decl   0x10(%ebp)
  8007eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ee:	48                   	dec    %eax
  8007ef:	8a 00                	mov    (%eax),%al
  8007f1:	3c 25                	cmp    $0x25,%al
  8007f3:	75 f3                	jne    8007e8 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8007f5:	90                   	nop
		}
	}
  8007f6:	e9 47 fc ff ff       	jmp    800442 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8007fb:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8007fc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8007ff:	5b                   	pop    %ebx
  800800:	5e                   	pop    %esi
  800801:	5d                   	pop    %ebp
  800802:	c3                   	ret    

00800803 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800803:	55                   	push   %ebp
  800804:	89 e5                	mov    %esp,%ebp
  800806:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800809:	8d 45 10             	lea    0x10(%ebp),%eax
  80080c:	83 c0 04             	add    $0x4,%eax
  80080f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800812:	8b 45 10             	mov    0x10(%ebp),%eax
  800815:	ff 75 f4             	pushl  -0xc(%ebp)
  800818:	50                   	push   %eax
  800819:	ff 75 0c             	pushl  0xc(%ebp)
  80081c:	ff 75 08             	pushl  0x8(%ebp)
  80081f:	e8 16 fc ff ff       	call   80043a <vprintfmt>
  800824:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800827:	90                   	nop
  800828:	c9                   	leave  
  800829:	c3                   	ret    

0080082a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80082a:	55                   	push   %ebp
  80082b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80082d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800830:	8b 40 08             	mov    0x8(%eax),%eax
  800833:	8d 50 01             	lea    0x1(%eax),%edx
  800836:	8b 45 0c             	mov    0xc(%ebp),%eax
  800839:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80083c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80083f:	8b 10                	mov    (%eax),%edx
  800841:	8b 45 0c             	mov    0xc(%ebp),%eax
  800844:	8b 40 04             	mov    0x4(%eax),%eax
  800847:	39 c2                	cmp    %eax,%edx
  800849:	73 12                	jae    80085d <sprintputch+0x33>
		*b->buf++ = ch;
  80084b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80084e:	8b 00                	mov    (%eax),%eax
  800850:	8d 48 01             	lea    0x1(%eax),%ecx
  800853:	8b 55 0c             	mov    0xc(%ebp),%edx
  800856:	89 0a                	mov    %ecx,(%edx)
  800858:	8b 55 08             	mov    0x8(%ebp),%edx
  80085b:	88 10                	mov    %dl,(%eax)
}
  80085d:	90                   	nop
  80085e:	5d                   	pop    %ebp
  80085f:	c3                   	ret    

00800860 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800860:	55                   	push   %ebp
  800861:	89 e5                	mov    %esp,%ebp
  800863:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800866:	8b 45 08             	mov    0x8(%ebp),%eax
  800869:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80086c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80086f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800872:	8b 45 08             	mov    0x8(%ebp),%eax
  800875:	01 d0                	add    %edx,%eax
  800877:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80087a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800881:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800885:	74 06                	je     80088d <vsnprintf+0x2d>
  800887:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80088b:	7f 07                	jg     800894 <vsnprintf+0x34>
		return -E_INVAL;
  80088d:	b8 03 00 00 00       	mov    $0x3,%eax
  800892:	eb 20                	jmp    8008b4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800894:	ff 75 14             	pushl  0x14(%ebp)
  800897:	ff 75 10             	pushl  0x10(%ebp)
  80089a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80089d:	50                   	push   %eax
  80089e:	68 2a 08 80 00       	push   $0x80082a
  8008a3:	e8 92 fb ff ff       	call   80043a <vprintfmt>
  8008a8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008ae:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008b4:	c9                   	leave  
  8008b5:	c3                   	ret    

008008b6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008b6:	55                   	push   %ebp
  8008b7:	89 e5                	mov    %esp,%ebp
  8008b9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008bc:	8d 45 10             	lea    0x10(%ebp),%eax
  8008bf:	83 c0 04             	add    $0x4,%eax
  8008c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8008c8:	ff 75 f4             	pushl  -0xc(%ebp)
  8008cb:	50                   	push   %eax
  8008cc:	ff 75 0c             	pushl  0xc(%ebp)
  8008cf:	ff 75 08             	pushl  0x8(%ebp)
  8008d2:	e8 89 ff ff ff       	call   800860 <vsnprintf>
  8008d7:	83 c4 10             	add    $0x10,%esp
  8008da:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008e0:	c9                   	leave  
  8008e1:	c3                   	ret    

008008e2 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008e2:	55                   	push   %ebp
  8008e3:	89 e5                	mov    %esp,%ebp
  8008e5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8008e8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008ef:	eb 06                	jmp    8008f7 <strlen+0x15>
		n++;
  8008f1:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8008f4:	ff 45 08             	incl   0x8(%ebp)
  8008f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fa:	8a 00                	mov    (%eax),%al
  8008fc:	84 c0                	test   %al,%al
  8008fe:	75 f1                	jne    8008f1 <strlen+0xf>
		n++;
	return n;
  800900:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800903:	c9                   	leave  
  800904:	c3                   	ret    

00800905 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800905:	55                   	push   %ebp
  800906:	89 e5                	mov    %esp,%ebp
  800908:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80090b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800912:	eb 09                	jmp    80091d <strnlen+0x18>
		n++;
  800914:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800917:	ff 45 08             	incl   0x8(%ebp)
  80091a:	ff 4d 0c             	decl   0xc(%ebp)
  80091d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800921:	74 09                	je     80092c <strnlen+0x27>
  800923:	8b 45 08             	mov    0x8(%ebp),%eax
  800926:	8a 00                	mov    (%eax),%al
  800928:	84 c0                	test   %al,%al
  80092a:	75 e8                	jne    800914 <strnlen+0xf>
		n++;
	return n;
  80092c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80092f:	c9                   	leave  
  800930:	c3                   	ret    

00800931 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800931:	55                   	push   %ebp
  800932:	89 e5                	mov    %esp,%ebp
  800934:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800937:	8b 45 08             	mov    0x8(%ebp),%eax
  80093a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80093d:	90                   	nop
  80093e:	8b 45 08             	mov    0x8(%ebp),%eax
  800941:	8d 50 01             	lea    0x1(%eax),%edx
  800944:	89 55 08             	mov    %edx,0x8(%ebp)
  800947:	8b 55 0c             	mov    0xc(%ebp),%edx
  80094a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80094d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800950:	8a 12                	mov    (%edx),%dl
  800952:	88 10                	mov    %dl,(%eax)
  800954:	8a 00                	mov    (%eax),%al
  800956:	84 c0                	test   %al,%al
  800958:	75 e4                	jne    80093e <strcpy+0xd>
		/* do nothing */;
	return ret;
  80095a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80095d:	c9                   	leave  
  80095e:	c3                   	ret    

0080095f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80095f:	55                   	push   %ebp
  800960:	89 e5                	mov    %esp,%ebp
  800962:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800965:	8b 45 08             	mov    0x8(%ebp),%eax
  800968:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80096b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800972:	eb 1f                	jmp    800993 <strncpy+0x34>
		*dst++ = *src;
  800974:	8b 45 08             	mov    0x8(%ebp),%eax
  800977:	8d 50 01             	lea    0x1(%eax),%edx
  80097a:	89 55 08             	mov    %edx,0x8(%ebp)
  80097d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800980:	8a 12                	mov    (%edx),%dl
  800982:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800984:	8b 45 0c             	mov    0xc(%ebp),%eax
  800987:	8a 00                	mov    (%eax),%al
  800989:	84 c0                	test   %al,%al
  80098b:	74 03                	je     800990 <strncpy+0x31>
			src++;
  80098d:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800990:	ff 45 fc             	incl   -0x4(%ebp)
  800993:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800996:	3b 45 10             	cmp    0x10(%ebp),%eax
  800999:	72 d9                	jb     800974 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80099b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80099e:	c9                   	leave  
  80099f:	c3                   	ret    

008009a0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009a0:	55                   	push   %ebp
  8009a1:	89 e5                	mov    %esp,%ebp
  8009a3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009b0:	74 30                	je     8009e2 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009b2:	eb 16                	jmp    8009ca <strlcpy+0x2a>
			*dst++ = *src++;
  8009b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b7:	8d 50 01             	lea    0x1(%eax),%edx
  8009ba:	89 55 08             	mov    %edx,0x8(%ebp)
  8009bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009c0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009c3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009c6:	8a 12                	mov    (%edx),%dl
  8009c8:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009ca:	ff 4d 10             	decl   0x10(%ebp)
  8009cd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009d1:	74 09                	je     8009dc <strlcpy+0x3c>
  8009d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d6:	8a 00                	mov    (%eax),%al
  8009d8:	84 c0                	test   %al,%al
  8009da:	75 d8                	jne    8009b4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009df:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009e2:	8b 55 08             	mov    0x8(%ebp),%edx
  8009e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009e8:	29 c2                	sub    %eax,%edx
  8009ea:	89 d0                	mov    %edx,%eax
}
  8009ec:	c9                   	leave  
  8009ed:	c3                   	ret    

008009ee <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8009ee:	55                   	push   %ebp
  8009ef:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8009f1:	eb 06                	jmp    8009f9 <strcmp+0xb>
		p++, q++;
  8009f3:	ff 45 08             	incl   0x8(%ebp)
  8009f6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8009f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fc:	8a 00                	mov    (%eax),%al
  8009fe:	84 c0                	test   %al,%al
  800a00:	74 0e                	je     800a10 <strcmp+0x22>
  800a02:	8b 45 08             	mov    0x8(%ebp),%eax
  800a05:	8a 10                	mov    (%eax),%dl
  800a07:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a0a:	8a 00                	mov    (%eax),%al
  800a0c:	38 c2                	cmp    %al,%dl
  800a0e:	74 e3                	je     8009f3 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a10:	8b 45 08             	mov    0x8(%ebp),%eax
  800a13:	8a 00                	mov    (%eax),%al
  800a15:	0f b6 d0             	movzbl %al,%edx
  800a18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a1b:	8a 00                	mov    (%eax),%al
  800a1d:	0f b6 c0             	movzbl %al,%eax
  800a20:	29 c2                	sub    %eax,%edx
  800a22:	89 d0                	mov    %edx,%eax
}
  800a24:	5d                   	pop    %ebp
  800a25:	c3                   	ret    

00800a26 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a26:	55                   	push   %ebp
  800a27:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a29:	eb 09                	jmp    800a34 <strncmp+0xe>
		n--, p++, q++;
  800a2b:	ff 4d 10             	decl   0x10(%ebp)
  800a2e:	ff 45 08             	incl   0x8(%ebp)
  800a31:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a34:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a38:	74 17                	je     800a51 <strncmp+0x2b>
  800a3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3d:	8a 00                	mov    (%eax),%al
  800a3f:	84 c0                	test   %al,%al
  800a41:	74 0e                	je     800a51 <strncmp+0x2b>
  800a43:	8b 45 08             	mov    0x8(%ebp),%eax
  800a46:	8a 10                	mov    (%eax),%dl
  800a48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4b:	8a 00                	mov    (%eax),%al
  800a4d:	38 c2                	cmp    %al,%dl
  800a4f:	74 da                	je     800a2b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a51:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a55:	75 07                	jne    800a5e <strncmp+0x38>
		return 0;
  800a57:	b8 00 00 00 00       	mov    $0x0,%eax
  800a5c:	eb 14                	jmp    800a72 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a61:	8a 00                	mov    (%eax),%al
  800a63:	0f b6 d0             	movzbl %al,%edx
  800a66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a69:	8a 00                	mov    (%eax),%al
  800a6b:	0f b6 c0             	movzbl %al,%eax
  800a6e:	29 c2                	sub    %eax,%edx
  800a70:	89 d0                	mov    %edx,%eax
}
  800a72:	5d                   	pop    %ebp
  800a73:	c3                   	ret    

00800a74 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a74:	55                   	push   %ebp
  800a75:	89 e5                	mov    %esp,%ebp
  800a77:	83 ec 04             	sub    $0x4,%esp
  800a7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a7d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a80:	eb 12                	jmp    800a94 <strchr+0x20>
		if (*s == c)
  800a82:	8b 45 08             	mov    0x8(%ebp),%eax
  800a85:	8a 00                	mov    (%eax),%al
  800a87:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a8a:	75 05                	jne    800a91 <strchr+0x1d>
			return (char *) s;
  800a8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8f:	eb 11                	jmp    800aa2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800a91:	ff 45 08             	incl   0x8(%ebp)
  800a94:	8b 45 08             	mov    0x8(%ebp),%eax
  800a97:	8a 00                	mov    (%eax),%al
  800a99:	84 c0                	test   %al,%al
  800a9b:	75 e5                	jne    800a82 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800a9d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800aa2:	c9                   	leave  
  800aa3:	c3                   	ret    

00800aa4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800aa4:	55                   	push   %ebp
  800aa5:	89 e5                	mov    %esp,%ebp
  800aa7:	83 ec 04             	sub    $0x4,%esp
  800aaa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aad:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ab0:	eb 0d                	jmp    800abf <strfind+0x1b>
		if (*s == c)
  800ab2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab5:	8a 00                	mov    (%eax),%al
  800ab7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800aba:	74 0e                	je     800aca <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800abc:	ff 45 08             	incl   0x8(%ebp)
  800abf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac2:	8a 00                	mov    (%eax),%al
  800ac4:	84 c0                	test   %al,%al
  800ac6:	75 ea                	jne    800ab2 <strfind+0xe>
  800ac8:	eb 01                	jmp    800acb <strfind+0x27>
		if (*s == c)
			break;
  800aca:	90                   	nop
	return (char *) s;
  800acb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ace:	c9                   	leave  
  800acf:	c3                   	ret    

00800ad0 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ad0:	55                   	push   %ebp
  800ad1:	89 e5                	mov    %esp,%ebp
  800ad3:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800adc:	8b 45 10             	mov    0x10(%ebp),%eax
  800adf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ae2:	eb 0e                	jmp    800af2 <memset+0x22>
		*p++ = c;
  800ae4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ae7:	8d 50 01             	lea    0x1(%eax),%edx
  800aea:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800aed:	8b 55 0c             	mov    0xc(%ebp),%edx
  800af0:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800af2:	ff 4d f8             	decl   -0x8(%ebp)
  800af5:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800af9:	79 e9                	jns    800ae4 <memset+0x14>
		*p++ = c;

	return v;
  800afb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800afe:	c9                   	leave  
  800aff:	c3                   	ret    

00800b00 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b00:	55                   	push   %ebp
  800b01:	89 e5                	mov    %esp,%ebp
  800b03:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b09:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b12:	eb 16                	jmp    800b2a <memcpy+0x2a>
		*d++ = *s++;
  800b14:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b17:	8d 50 01             	lea    0x1(%eax),%edx
  800b1a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b1d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b20:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b23:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b26:	8a 12                	mov    (%edx),%dl
  800b28:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b2a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b2d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b30:	89 55 10             	mov    %edx,0x10(%ebp)
  800b33:	85 c0                	test   %eax,%eax
  800b35:	75 dd                	jne    800b14 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b3a:	c9                   	leave  
  800b3b:	c3                   	ret    

00800b3c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b3c:	55                   	push   %ebp
  800b3d:	89 e5                	mov    %esp,%ebp
  800b3f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b42:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b45:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b48:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b51:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b54:	73 50                	jae    800ba6 <memmove+0x6a>
  800b56:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b59:	8b 45 10             	mov    0x10(%ebp),%eax
  800b5c:	01 d0                	add    %edx,%eax
  800b5e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b61:	76 43                	jbe    800ba6 <memmove+0x6a>
		s += n;
  800b63:	8b 45 10             	mov    0x10(%ebp),%eax
  800b66:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b69:	8b 45 10             	mov    0x10(%ebp),%eax
  800b6c:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b6f:	eb 10                	jmp    800b81 <memmove+0x45>
			*--d = *--s;
  800b71:	ff 4d f8             	decl   -0x8(%ebp)
  800b74:	ff 4d fc             	decl   -0x4(%ebp)
  800b77:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b7a:	8a 10                	mov    (%eax),%dl
  800b7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b7f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b81:	8b 45 10             	mov    0x10(%ebp),%eax
  800b84:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b87:	89 55 10             	mov    %edx,0x10(%ebp)
  800b8a:	85 c0                	test   %eax,%eax
  800b8c:	75 e3                	jne    800b71 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800b8e:	eb 23                	jmp    800bb3 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800b90:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b93:	8d 50 01             	lea    0x1(%eax),%edx
  800b96:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b99:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b9c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b9f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ba2:	8a 12                	mov    (%edx),%dl
  800ba4:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ba6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bac:	89 55 10             	mov    %edx,0x10(%ebp)
  800baf:	85 c0                	test   %eax,%eax
  800bb1:	75 dd                	jne    800b90 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bb3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bb6:	c9                   	leave  
  800bb7:	c3                   	ret    

00800bb8 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bb8:	55                   	push   %ebp
  800bb9:	89 e5                	mov    %esp,%ebp
  800bbb:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc7:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bca:	eb 2a                	jmp    800bf6 <memcmp+0x3e>
		if (*s1 != *s2)
  800bcc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bcf:	8a 10                	mov    (%eax),%dl
  800bd1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bd4:	8a 00                	mov    (%eax),%al
  800bd6:	38 c2                	cmp    %al,%dl
  800bd8:	74 16                	je     800bf0 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bda:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bdd:	8a 00                	mov    (%eax),%al
  800bdf:	0f b6 d0             	movzbl %al,%edx
  800be2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800be5:	8a 00                	mov    (%eax),%al
  800be7:	0f b6 c0             	movzbl %al,%eax
  800bea:	29 c2                	sub    %eax,%edx
  800bec:	89 d0                	mov    %edx,%eax
  800bee:	eb 18                	jmp    800c08 <memcmp+0x50>
		s1++, s2++;
  800bf0:	ff 45 fc             	incl   -0x4(%ebp)
  800bf3:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800bf6:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bfc:	89 55 10             	mov    %edx,0x10(%ebp)
  800bff:	85 c0                	test   %eax,%eax
  800c01:	75 c9                	jne    800bcc <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c03:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c08:	c9                   	leave  
  800c09:	c3                   	ret    

00800c0a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c0a:	55                   	push   %ebp
  800c0b:	89 e5                	mov    %esp,%ebp
  800c0d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c10:	8b 55 08             	mov    0x8(%ebp),%edx
  800c13:	8b 45 10             	mov    0x10(%ebp),%eax
  800c16:	01 d0                	add    %edx,%eax
  800c18:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c1b:	eb 15                	jmp    800c32 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c20:	8a 00                	mov    (%eax),%al
  800c22:	0f b6 d0             	movzbl %al,%edx
  800c25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c28:	0f b6 c0             	movzbl %al,%eax
  800c2b:	39 c2                	cmp    %eax,%edx
  800c2d:	74 0d                	je     800c3c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c2f:	ff 45 08             	incl   0x8(%ebp)
  800c32:	8b 45 08             	mov    0x8(%ebp),%eax
  800c35:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c38:	72 e3                	jb     800c1d <memfind+0x13>
  800c3a:	eb 01                	jmp    800c3d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c3c:	90                   	nop
	return (void *) s;
  800c3d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c40:	c9                   	leave  
  800c41:	c3                   	ret    

00800c42 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c42:	55                   	push   %ebp
  800c43:	89 e5                	mov    %esp,%ebp
  800c45:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c48:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c4f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c56:	eb 03                	jmp    800c5b <strtol+0x19>
		s++;
  800c58:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5e:	8a 00                	mov    (%eax),%al
  800c60:	3c 20                	cmp    $0x20,%al
  800c62:	74 f4                	je     800c58 <strtol+0x16>
  800c64:	8b 45 08             	mov    0x8(%ebp),%eax
  800c67:	8a 00                	mov    (%eax),%al
  800c69:	3c 09                	cmp    $0x9,%al
  800c6b:	74 eb                	je     800c58 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c70:	8a 00                	mov    (%eax),%al
  800c72:	3c 2b                	cmp    $0x2b,%al
  800c74:	75 05                	jne    800c7b <strtol+0x39>
		s++;
  800c76:	ff 45 08             	incl   0x8(%ebp)
  800c79:	eb 13                	jmp    800c8e <strtol+0x4c>
	else if (*s == '-')
  800c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7e:	8a 00                	mov    (%eax),%al
  800c80:	3c 2d                	cmp    $0x2d,%al
  800c82:	75 0a                	jne    800c8e <strtol+0x4c>
		s++, neg = 1;
  800c84:	ff 45 08             	incl   0x8(%ebp)
  800c87:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800c8e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c92:	74 06                	je     800c9a <strtol+0x58>
  800c94:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800c98:	75 20                	jne    800cba <strtol+0x78>
  800c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9d:	8a 00                	mov    (%eax),%al
  800c9f:	3c 30                	cmp    $0x30,%al
  800ca1:	75 17                	jne    800cba <strtol+0x78>
  800ca3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca6:	40                   	inc    %eax
  800ca7:	8a 00                	mov    (%eax),%al
  800ca9:	3c 78                	cmp    $0x78,%al
  800cab:	75 0d                	jne    800cba <strtol+0x78>
		s += 2, base = 16;
  800cad:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cb1:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cb8:	eb 28                	jmp    800ce2 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800cba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cbe:	75 15                	jne    800cd5 <strtol+0x93>
  800cc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc3:	8a 00                	mov    (%eax),%al
  800cc5:	3c 30                	cmp    $0x30,%al
  800cc7:	75 0c                	jne    800cd5 <strtol+0x93>
		s++, base = 8;
  800cc9:	ff 45 08             	incl   0x8(%ebp)
  800ccc:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cd3:	eb 0d                	jmp    800ce2 <strtol+0xa0>
	else if (base == 0)
  800cd5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd9:	75 07                	jne    800ce2 <strtol+0xa0>
		base = 10;
  800cdb:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	8a 00                	mov    (%eax),%al
  800ce7:	3c 2f                	cmp    $0x2f,%al
  800ce9:	7e 19                	jle    800d04 <strtol+0xc2>
  800ceb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cee:	8a 00                	mov    (%eax),%al
  800cf0:	3c 39                	cmp    $0x39,%al
  800cf2:	7f 10                	jg     800d04 <strtol+0xc2>
			dig = *s - '0';
  800cf4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf7:	8a 00                	mov    (%eax),%al
  800cf9:	0f be c0             	movsbl %al,%eax
  800cfc:	83 e8 30             	sub    $0x30,%eax
  800cff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d02:	eb 42                	jmp    800d46 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d04:	8b 45 08             	mov    0x8(%ebp),%eax
  800d07:	8a 00                	mov    (%eax),%al
  800d09:	3c 60                	cmp    $0x60,%al
  800d0b:	7e 19                	jle    800d26 <strtol+0xe4>
  800d0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d10:	8a 00                	mov    (%eax),%al
  800d12:	3c 7a                	cmp    $0x7a,%al
  800d14:	7f 10                	jg     800d26 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d16:	8b 45 08             	mov    0x8(%ebp),%eax
  800d19:	8a 00                	mov    (%eax),%al
  800d1b:	0f be c0             	movsbl %al,%eax
  800d1e:	83 e8 57             	sub    $0x57,%eax
  800d21:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d24:	eb 20                	jmp    800d46 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d26:	8b 45 08             	mov    0x8(%ebp),%eax
  800d29:	8a 00                	mov    (%eax),%al
  800d2b:	3c 40                	cmp    $0x40,%al
  800d2d:	7e 39                	jle    800d68 <strtol+0x126>
  800d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d32:	8a 00                	mov    (%eax),%al
  800d34:	3c 5a                	cmp    $0x5a,%al
  800d36:	7f 30                	jg     800d68 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d38:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3b:	8a 00                	mov    (%eax),%al
  800d3d:	0f be c0             	movsbl %al,%eax
  800d40:	83 e8 37             	sub    $0x37,%eax
  800d43:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d46:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d49:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d4c:	7d 19                	jge    800d67 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d4e:	ff 45 08             	incl   0x8(%ebp)
  800d51:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d54:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d58:	89 c2                	mov    %eax,%edx
  800d5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d5d:	01 d0                	add    %edx,%eax
  800d5f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d62:	e9 7b ff ff ff       	jmp    800ce2 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d67:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d68:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d6c:	74 08                	je     800d76 <strtol+0x134>
		*endptr = (char *) s;
  800d6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d71:	8b 55 08             	mov    0x8(%ebp),%edx
  800d74:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d76:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d7a:	74 07                	je     800d83 <strtol+0x141>
  800d7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d7f:	f7 d8                	neg    %eax
  800d81:	eb 03                	jmp    800d86 <strtol+0x144>
  800d83:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d86:	c9                   	leave  
  800d87:	c3                   	ret    

00800d88 <ltostr>:

void
ltostr(long value, char *str)
{
  800d88:	55                   	push   %ebp
  800d89:	89 e5                	mov    %esp,%ebp
  800d8b:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800d8e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800d95:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800d9c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800da0:	79 13                	jns    800db5 <ltostr+0x2d>
	{
		neg = 1;
  800da2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800da9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dac:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800daf:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800db2:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800db5:	8b 45 08             	mov    0x8(%ebp),%eax
  800db8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800dbd:	99                   	cltd   
  800dbe:	f7 f9                	idiv   %ecx
  800dc0:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800dc3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dc6:	8d 50 01             	lea    0x1(%eax),%edx
  800dc9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dcc:	89 c2                	mov    %eax,%edx
  800dce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd1:	01 d0                	add    %edx,%eax
  800dd3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dd6:	83 c2 30             	add    $0x30,%edx
  800dd9:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800ddb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dde:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800de3:	f7 e9                	imul   %ecx
  800de5:	c1 fa 02             	sar    $0x2,%edx
  800de8:	89 c8                	mov    %ecx,%eax
  800dea:	c1 f8 1f             	sar    $0x1f,%eax
  800ded:	29 c2                	sub    %eax,%edx
  800def:	89 d0                	mov    %edx,%eax
  800df1:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800df4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800df7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dfc:	f7 e9                	imul   %ecx
  800dfe:	c1 fa 02             	sar    $0x2,%edx
  800e01:	89 c8                	mov    %ecx,%eax
  800e03:	c1 f8 1f             	sar    $0x1f,%eax
  800e06:	29 c2                	sub    %eax,%edx
  800e08:	89 d0                	mov    %edx,%eax
  800e0a:	c1 e0 02             	shl    $0x2,%eax
  800e0d:	01 d0                	add    %edx,%eax
  800e0f:	01 c0                	add    %eax,%eax
  800e11:	29 c1                	sub    %eax,%ecx
  800e13:	89 ca                	mov    %ecx,%edx
  800e15:	85 d2                	test   %edx,%edx
  800e17:	75 9c                	jne    800db5 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e19:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e20:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e23:	48                   	dec    %eax
  800e24:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e27:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e2b:	74 3d                	je     800e6a <ltostr+0xe2>
		start = 1 ;
  800e2d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e34:	eb 34                	jmp    800e6a <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e36:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3c:	01 d0                	add    %edx,%eax
  800e3e:	8a 00                	mov    (%eax),%al
  800e40:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e43:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e49:	01 c2                	add    %eax,%edx
  800e4b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e51:	01 c8                	add    %ecx,%eax
  800e53:	8a 00                	mov    (%eax),%al
  800e55:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e57:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5d:	01 c2                	add    %eax,%edx
  800e5f:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e62:	88 02                	mov    %al,(%edx)
		start++ ;
  800e64:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e67:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e6d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e70:	7c c4                	jl     800e36 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e72:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e78:	01 d0                	add    %edx,%eax
  800e7a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e7d:	90                   	nop
  800e7e:	c9                   	leave  
  800e7f:	c3                   	ret    

00800e80 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e80:	55                   	push   %ebp
  800e81:	89 e5                	mov    %esp,%ebp
  800e83:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e86:	ff 75 08             	pushl  0x8(%ebp)
  800e89:	e8 54 fa ff ff       	call   8008e2 <strlen>
  800e8e:	83 c4 04             	add    $0x4,%esp
  800e91:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800e94:	ff 75 0c             	pushl  0xc(%ebp)
  800e97:	e8 46 fa ff ff       	call   8008e2 <strlen>
  800e9c:	83 c4 04             	add    $0x4,%esp
  800e9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ea2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ea9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800eb0:	eb 17                	jmp    800ec9 <strcconcat+0x49>
		final[s] = str1[s] ;
  800eb2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eb5:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb8:	01 c2                	add    %eax,%edx
  800eba:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ebd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec0:	01 c8                	add    %ecx,%eax
  800ec2:	8a 00                	mov    (%eax),%al
  800ec4:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800ec6:	ff 45 fc             	incl   -0x4(%ebp)
  800ec9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ecc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ecf:	7c e1                	jl     800eb2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ed1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ed8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800edf:	eb 1f                	jmp    800f00 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800ee1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ee4:	8d 50 01             	lea    0x1(%eax),%edx
  800ee7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800eea:	89 c2                	mov    %eax,%edx
  800eec:	8b 45 10             	mov    0x10(%ebp),%eax
  800eef:	01 c2                	add    %eax,%edx
  800ef1:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800ef4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef7:	01 c8                	add    %ecx,%eax
  800ef9:	8a 00                	mov    (%eax),%al
  800efb:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800efd:	ff 45 f8             	incl   -0x8(%ebp)
  800f00:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f03:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f06:	7c d9                	jl     800ee1 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f08:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f0b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0e:	01 d0                	add    %edx,%eax
  800f10:	c6 00 00             	movb   $0x0,(%eax)
}
  800f13:	90                   	nop
  800f14:	c9                   	leave  
  800f15:	c3                   	ret    

00800f16 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f16:	55                   	push   %ebp
  800f17:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f19:	8b 45 14             	mov    0x14(%ebp),%eax
  800f1c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f22:	8b 45 14             	mov    0x14(%ebp),%eax
  800f25:	8b 00                	mov    (%eax),%eax
  800f27:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f2e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f31:	01 d0                	add    %edx,%eax
  800f33:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f39:	eb 0c                	jmp    800f47 <strsplit+0x31>
			*string++ = 0;
  800f3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3e:	8d 50 01             	lea    0x1(%eax),%edx
  800f41:	89 55 08             	mov    %edx,0x8(%ebp)
  800f44:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f47:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4a:	8a 00                	mov    (%eax),%al
  800f4c:	84 c0                	test   %al,%al
  800f4e:	74 18                	je     800f68 <strsplit+0x52>
  800f50:	8b 45 08             	mov    0x8(%ebp),%eax
  800f53:	8a 00                	mov    (%eax),%al
  800f55:	0f be c0             	movsbl %al,%eax
  800f58:	50                   	push   %eax
  800f59:	ff 75 0c             	pushl  0xc(%ebp)
  800f5c:	e8 13 fb ff ff       	call   800a74 <strchr>
  800f61:	83 c4 08             	add    $0x8,%esp
  800f64:	85 c0                	test   %eax,%eax
  800f66:	75 d3                	jne    800f3b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800f68:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6b:	8a 00                	mov    (%eax),%al
  800f6d:	84 c0                	test   %al,%al
  800f6f:	74 5a                	je     800fcb <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800f71:	8b 45 14             	mov    0x14(%ebp),%eax
  800f74:	8b 00                	mov    (%eax),%eax
  800f76:	83 f8 0f             	cmp    $0xf,%eax
  800f79:	75 07                	jne    800f82 <strsplit+0x6c>
		{
			return 0;
  800f7b:	b8 00 00 00 00       	mov    $0x0,%eax
  800f80:	eb 66                	jmp    800fe8 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f82:	8b 45 14             	mov    0x14(%ebp),%eax
  800f85:	8b 00                	mov    (%eax),%eax
  800f87:	8d 48 01             	lea    0x1(%eax),%ecx
  800f8a:	8b 55 14             	mov    0x14(%ebp),%edx
  800f8d:	89 0a                	mov    %ecx,(%edx)
  800f8f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f96:	8b 45 10             	mov    0x10(%ebp),%eax
  800f99:	01 c2                	add    %eax,%edx
  800f9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9e:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fa0:	eb 03                	jmp    800fa5 <strsplit+0x8f>
			string++;
  800fa2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa8:	8a 00                	mov    (%eax),%al
  800faa:	84 c0                	test   %al,%al
  800fac:	74 8b                	je     800f39 <strsplit+0x23>
  800fae:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb1:	8a 00                	mov    (%eax),%al
  800fb3:	0f be c0             	movsbl %al,%eax
  800fb6:	50                   	push   %eax
  800fb7:	ff 75 0c             	pushl  0xc(%ebp)
  800fba:	e8 b5 fa ff ff       	call   800a74 <strchr>
  800fbf:	83 c4 08             	add    $0x8,%esp
  800fc2:	85 c0                	test   %eax,%eax
  800fc4:	74 dc                	je     800fa2 <strsplit+0x8c>
			string++;
	}
  800fc6:	e9 6e ff ff ff       	jmp    800f39 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800fcb:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fcc:	8b 45 14             	mov    0x14(%ebp),%eax
  800fcf:	8b 00                	mov    (%eax),%eax
  800fd1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fd8:	8b 45 10             	mov    0x10(%ebp),%eax
  800fdb:	01 d0                	add    %edx,%eax
  800fdd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800fe3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800fe8:	c9                   	leave  
  800fe9:	c3                   	ret    

00800fea <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  800fea:	55                   	push   %ebp
  800feb:	89 e5                	mov    %esp,%ebp
  800fed:	57                   	push   %edi
  800fee:	56                   	push   %esi
  800fef:	53                   	push   %ebx
  800ff0:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800ff3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ff9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800ffc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  800fff:	8b 7d 18             	mov    0x18(%ebp),%edi
  801002:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801005:	cd 30                	int    $0x30
  801007:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80100a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80100d:	83 c4 10             	add    $0x10,%esp
  801010:	5b                   	pop    %ebx
  801011:	5e                   	pop    %esi
  801012:	5f                   	pop    %edi
  801013:	5d                   	pop    %ebp
  801014:	c3                   	ret    

00801015 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801015:	55                   	push   %ebp
  801016:	89 e5                	mov    %esp,%ebp
  801018:	83 ec 04             	sub    $0x4,%esp
  80101b:	8b 45 10             	mov    0x10(%ebp),%eax
  80101e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801021:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801025:	8b 45 08             	mov    0x8(%ebp),%eax
  801028:	6a 00                	push   $0x0
  80102a:	6a 00                	push   $0x0
  80102c:	52                   	push   %edx
  80102d:	ff 75 0c             	pushl  0xc(%ebp)
  801030:	50                   	push   %eax
  801031:	6a 00                	push   $0x0
  801033:	e8 b2 ff ff ff       	call   800fea <syscall>
  801038:	83 c4 18             	add    $0x18,%esp
}
  80103b:	90                   	nop
  80103c:	c9                   	leave  
  80103d:	c3                   	ret    

0080103e <sys_cgetc>:

int
sys_cgetc(void)
{
  80103e:	55                   	push   %ebp
  80103f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801041:	6a 00                	push   $0x0
  801043:	6a 00                	push   $0x0
  801045:	6a 00                	push   $0x0
  801047:	6a 00                	push   $0x0
  801049:	6a 00                	push   $0x0
  80104b:	6a 01                	push   $0x1
  80104d:	e8 98 ff ff ff       	call   800fea <syscall>
  801052:	83 c4 18             	add    $0x18,%esp
}
  801055:	c9                   	leave  
  801056:	c3                   	ret    

00801057 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801057:	55                   	push   %ebp
  801058:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80105a:	8b 45 08             	mov    0x8(%ebp),%eax
  80105d:	6a 00                	push   $0x0
  80105f:	6a 00                	push   $0x0
  801061:	6a 00                	push   $0x0
  801063:	6a 00                	push   $0x0
  801065:	50                   	push   %eax
  801066:	6a 05                	push   $0x5
  801068:	e8 7d ff ff ff       	call   800fea <syscall>
  80106d:	83 c4 18             	add    $0x18,%esp
}
  801070:	c9                   	leave  
  801071:	c3                   	ret    

00801072 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801072:	55                   	push   %ebp
  801073:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801075:	6a 00                	push   $0x0
  801077:	6a 00                	push   $0x0
  801079:	6a 00                	push   $0x0
  80107b:	6a 00                	push   $0x0
  80107d:	6a 00                	push   $0x0
  80107f:	6a 02                	push   $0x2
  801081:	e8 64 ff ff ff       	call   800fea <syscall>
  801086:	83 c4 18             	add    $0x18,%esp
}
  801089:	c9                   	leave  
  80108a:	c3                   	ret    

0080108b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80108b:	55                   	push   %ebp
  80108c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80108e:	6a 00                	push   $0x0
  801090:	6a 00                	push   $0x0
  801092:	6a 00                	push   $0x0
  801094:	6a 00                	push   $0x0
  801096:	6a 00                	push   $0x0
  801098:	6a 03                	push   $0x3
  80109a:	e8 4b ff ff ff       	call   800fea <syscall>
  80109f:	83 c4 18             	add    $0x18,%esp
}
  8010a2:	c9                   	leave  
  8010a3:	c3                   	ret    

008010a4 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010a4:	55                   	push   %ebp
  8010a5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010a7:	6a 00                	push   $0x0
  8010a9:	6a 00                	push   $0x0
  8010ab:	6a 00                	push   $0x0
  8010ad:	6a 00                	push   $0x0
  8010af:	6a 00                	push   $0x0
  8010b1:	6a 04                	push   $0x4
  8010b3:	e8 32 ff ff ff       	call   800fea <syscall>
  8010b8:	83 c4 18             	add    $0x18,%esp
}
  8010bb:	c9                   	leave  
  8010bc:	c3                   	ret    

008010bd <sys_env_exit>:


void sys_env_exit(void)
{
  8010bd:	55                   	push   %ebp
  8010be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010c0:	6a 00                	push   $0x0
  8010c2:	6a 00                	push   $0x0
  8010c4:	6a 00                	push   $0x0
  8010c6:	6a 00                	push   $0x0
  8010c8:	6a 00                	push   $0x0
  8010ca:	6a 06                	push   $0x6
  8010cc:	e8 19 ff ff ff       	call   800fea <syscall>
  8010d1:	83 c4 18             	add    $0x18,%esp
}
  8010d4:	90                   	nop
  8010d5:	c9                   	leave  
  8010d6:	c3                   	ret    

008010d7 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010d7:	55                   	push   %ebp
  8010d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e0:	6a 00                	push   $0x0
  8010e2:	6a 00                	push   $0x0
  8010e4:	6a 00                	push   $0x0
  8010e6:	52                   	push   %edx
  8010e7:	50                   	push   %eax
  8010e8:	6a 07                	push   $0x7
  8010ea:	e8 fb fe ff ff       	call   800fea <syscall>
  8010ef:	83 c4 18             	add    $0x18,%esp
}
  8010f2:	c9                   	leave  
  8010f3:	c3                   	ret    

008010f4 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8010f4:	55                   	push   %ebp
  8010f5:	89 e5                	mov    %esp,%ebp
  8010f7:	56                   	push   %esi
  8010f8:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8010f9:	8b 75 18             	mov    0x18(%ebp),%esi
  8010fc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010ff:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801102:	8b 55 0c             	mov    0xc(%ebp),%edx
  801105:	8b 45 08             	mov    0x8(%ebp),%eax
  801108:	56                   	push   %esi
  801109:	53                   	push   %ebx
  80110a:	51                   	push   %ecx
  80110b:	52                   	push   %edx
  80110c:	50                   	push   %eax
  80110d:	6a 08                	push   $0x8
  80110f:	e8 d6 fe ff ff       	call   800fea <syscall>
  801114:	83 c4 18             	add    $0x18,%esp
}
  801117:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80111a:	5b                   	pop    %ebx
  80111b:	5e                   	pop    %esi
  80111c:	5d                   	pop    %ebp
  80111d:	c3                   	ret    

0080111e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80111e:	55                   	push   %ebp
  80111f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801121:	8b 55 0c             	mov    0xc(%ebp),%edx
  801124:	8b 45 08             	mov    0x8(%ebp),%eax
  801127:	6a 00                	push   $0x0
  801129:	6a 00                	push   $0x0
  80112b:	6a 00                	push   $0x0
  80112d:	52                   	push   %edx
  80112e:	50                   	push   %eax
  80112f:	6a 09                	push   $0x9
  801131:	e8 b4 fe ff ff       	call   800fea <syscall>
  801136:	83 c4 18             	add    $0x18,%esp
}
  801139:	c9                   	leave  
  80113a:	c3                   	ret    

0080113b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80113b:	55                   	push   %ebp
  80113c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80113e:	6a 00                	push   $0x0
  801140:	6a 00                	push   $0x0
  801142:	6a 00                	push   $0x0
  801144:	ff 75 0c             	pushl  0xc(%ebp)
  801147:	ff 75 08             	pushl  0x8(%ebp)
  80114a:	6a 0a                	push   $0xa
  80114c:	e8 99 fe ff ff       	call   800fea <syscall>
  801151:	83 c4 18             	add    $0x18,%esp
}
  801154:	c9                   	leave  
  801155:	c3                   	ret    

00801156 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801156:	55                   	push   %ebp
  801157:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801159:	6a 00                	push   $0x0
  80115b:	6a 00                	push   $0x0
  80115d:	6a 00                	push   $0x0
  80115f:	6a 00                	push   $0x0
  801161:	6a 00                	push   $0x0
  801163:	6a 0b                	push   $0xb
  801165:	e8 80 fe ff ff       	call   800fea <syscall>
  80116a:	83 c4 18             	add    $0x18,%esp
}
  80116d:	c9                   	leave  
  80116e:	c3                   	ret    

0080116f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80116f:	55                   	push   %ebp
  801170:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801172:	6a 00                	push   $0x0
  801174:	6a 00                	push   $0x0
  801176:	6a 00                	push   $0x0
  801178:	6a 00                	push   $0x0
  80117a:	6a 00                	push   $0x0
  80117c:	6a 0c                	push   $0xc
  80117e:	e8 67 fe ff ff       	call   800fea <syscall>
  801183:	83 c4 18             	add    $0x18,%esp
}
  801186:	c9                   	leave  
  801187:	c3                   	ret    

00801188 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801188:	55                   	push   %ebp
  801189:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80118b:	6a 00                	push   $0x0
  80118d:	6a 00                	push   $0x0
  80118f:	6a 00                	push   $0x0
  801191:	6a 00                	push   $0x0
  801193:	6a 00                	push   $0x0
  801195:	6a 0d                	push   $0xd
  801197:	e8 4e fe ff ff       	call   800fea <syscall>
  80119c:	83 c4 18             	add    $0x18,%esp
}
  80119f:	c9                   	leave  
  8011a0:	c3                   	ret    

008011a1 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011a1:	55                   	push   %ebp
  8011a2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011a4:	6a 00                	push   $0x0
  8011a6:	6a 00                	push   $0x0
  8011a8:	6a 00                	push   $0x0
  8011aa:	ff 75 0c             	pushl  0xc(%ebp)
  8011ad:	ff 75 08             	pushl  0x8(%ebp)
  8011b0:	6a 11                	push   $0x11
  8011b2:	e8 33 fe ff ff       	call   800fea <syscall>
  8011b7:	83 c4 18             	add    $0x18,%esp
	return;
  8011ba:	90                   	nop
}
  8011bb:	c9                   	leave  
  8011bc:	c3                   	ret    

008011bd <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011bd:	55                   	push   %ebp
  8011be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011c0:	6a 00                	push   $0x0
  8011c2:	6a 00                	push   $0x0
  8011c4:	6a 00                	push   $0x0
  8011c6:	ff 75 0c             	pushl  0xc(%ebp)
  8011c9:	ff 75 08             	pushl  0x8(%ebp)
  8011cc:	6a 12                	push   $0x12
  8011ce:	e8 17 fe ff ff       	call   800fea <syscall>
  8011d3:	83 c4 18             	add    $0x18,%esp
	return ;
  8011d6:	90                   	nop
}
  8011d7:	c9                   	leave  
  8011d8:	c3                   	ret    

008011d9 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011d9:	55                   	push   %ebp
  8011da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011dc:	6a 00                	push   $0x0
  8011de:	6a 00                	push   $0x0
  8011e0:	6a 00                	push   $0x0
  8011e2:	6a 00                	push   $0x0
  8011e4:	6a 00                	push   $0x0
  8011e6:	6a 0e                	push   $0xe
  8011e8:	e8 fd fd ff ff       	call   800fea <syscall>
  8011ed:	83 c4 18             	add    $0x18,%esp
}
  8011f0:	c9                   	leave  
  8011f1:	c3                   	ret    

008011f2 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8011f2:	55                   	push   %ebp
  8011f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8011f5:	6a 00                	push   $0x0
  8011f7:	6a 00                	push   $0x0
  8011f9:	6a 00                	push   $0x0
  8011fb:	6a 00                	push   $0x0
  8011fd:	ff 75 08             	pushl  0x8(%ebp)
  801200:	6a 0f                	push   $0xf
  801202:	e8 e3 fd ff ff       	call   800fea <syscall>
  801207:	83 c4 18             	add    $0x18,%esp
}
  80120a:	c9                   	leave  
  80120b:	c3                   	ret    

0080120c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80120c:	55                   	push   %ebp
  80120d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80120f:	6a 00                	push   $0x0
  801211:	6a 00                	push   $0x0
  801213:	6a 00                	push   $0x0
  801215:	6a 00                	push   $0x0
  801217:	6a 00                	push   $0x0
  801219:	6a 10                	push   $0x10
  80121b:	e8 ca fd ff ff       	call   800fea <syscall>
  801220:	83 c4 18             	add    $0x18,%esp
}
  801223:	90                   	nop
  801224:	c9                   	leave  
  801225:	c3                   	ret    

00801226 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801226:	55                   	push   %ebp
  801227:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801229:	6a 00                	push   $0x0
  80122b:	6a 00                	push   $0x0
  80122d:	6a 00                	push   $0x0
  80122f:	6a 00                	push   $0x0
  801231:	6a 00                	push   $0x0
  801233:	6a 14                	push   $0x14
  801235:	e8 b0 fd ff ff       	call   800fea <syscall>
  80123a:	83 c4 18             	add    $0x18,%esp
}
  80123d:	90                   	nop
  80123e:	c9                   	leave  
  80123f:	c3                   	ret    

00801240 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801240:	55                   	push   %ebp
  801241:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801243:	6a 00                	push   $0x0
  801245:	6a 00                	push   $0x0
  801247:	6a 00                	push   $0x0
  801249:	6a 00                	push   $0x0
  80124b:	6a 00                	push   $0x0
  80124d:	6a 15                	push   $0x15
  80124f:	e8 96 fd ff ff       	call   800fea <syscall>
  801254:	83 c4 18             	add    $0x18,%esp
}
  801257:	90                   	nop
  801258:	c9                   	leave  
  801259:	c3                   	ret    

0080125a <sys_cputc>:


void
sys_cputc(const char c)
{
  80125a:	55                   	push   %ebp
  80125b:	89 e5                	mov    %esp,%ebp
  80125d:	83 ec 04             	sub    $0x4,%esp
  801260:	8b 45 08             	mov    0x8(%ebp),%eax
  801263:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801266:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80126a:	6a 00                	push   $0x0
  80126c:	6a 00                	push   $0x0
  80126e:	6a 00                	push   $0x0
  801270:	6a 00                	push   $0x0
  801272:	50                   	push   %eax
  801273:	6a 16                	push   $0x16
  801275:	e8 70 fd ff ff       	call   800fea <syscall>
  80127a:	83 c4 18             	add    $0x18,%esp
}
  80127d:	90                   	nop
  80127e:	c9                   	leave  
  80127f:	c3                   	ret    

00801280 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801280:	55                   	push   %ebp
  801281:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801283:	6a 00                	push   $0x0
  801285:	6a 00                	push   $0x0
  801287:	6a 00                	push   $0x0
  801289:	6a 00                	push   $0x0
  80128b:	6a 00                	push   $0x0
  80128d:	6a 17                	push   $0x17
  80128f:	e8 56 fd ff ff       	call   800fea <syscall>
  801294:	83 c4 18             	add    $0x18,%esp
}
  801297:	90                   	nop
  801298:	c9                   	leave  
  801299:	c3                   	ret    

0080129a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80129a:	55                   	push   %ebp
  80129b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80129d:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a0:	6a 00                	push   $0x0
  8012a2:	6a 00                	push   $0x0
  8012a4:	6a 00                	push   $0x0
  8012a6:	ff 75 0c             	pushl  0xc(%ebp)
  8012a9:	50                   	push   %eax
  8012aa:	6a 18                	push   $0x18
  8012ac:	e8 39 fd ff ff       	call   800fea <syscall>
  8012b1:	83 c4 18             	add    $0x18,%esp
}
  8012b4:	c9                   	leave  
  8012b5:	c3                   	ret    

008012b6 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012b6:	55                   	push   %ebp
  8012b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bf:	6a 00                	push   $0x0
  8012c1:	6a 00                	push   $0x0
  8012c3:	6a 00                	push   $0x0
  8012c5:	52                   	push   %edx
  8012c6:	50                   	push   %eax
  8012c7:	6a 1b                	push   $0x1b
  8012c9:	e8 1c fd ff ff       	call   800fea <syscall>
  8012ce:	83 c4 18             	add    $0x18,%esp
}
  8012d1:	c9                   	leave  
  8012d2:	c3                   	ret    

008012d3 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012d3:	55                   	push   %ebp
  8012d4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dc:	6a 00                	push   $0x0
  8012de:	6a 00                	push   $0x0
  8012e0:	6a 00                	push   $0x0
  8012e2:	52                   	push   %edx
  8012e3:	50                   	push   %eax
  8012e4:	6a 19                	push   $0x19
  8012e6:	e8 ff fc ff ff       	call   800fea <syscall>
  8012eb:	83 c4 18             	add    $0x18,%esp
}
  8012ee:	90                   	nop
  8012ef:	c9                   	leave  
  8012f0:	c3                   	ret    

008012f1 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012f1:	55                   	push   %ebp
  8012f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fa:	6a 00                	push   $0x0
  8012fc:	6a 00                	push   $0x0
  8012fe:	6a 00                	push   $0x0
  801300:	52                   	push   %edx
  801301:	50                   	push   %eax
  801302:	6a 1a                	push   $0x1a
  801304:	e8 e1 fc ff ff       	call   800fea <syscall>
  801309:	83 c4 18             	add    $0x18,%esp
}
  80130c:	90                   	nop
  80130d:	c9                   	leave  
  80130e:	c3                   	ret    

0080130f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80130f:	55                   	push   %ebp
  801310:	89 e5                	mov    %esp,%ebp
  801312:	83 ec 04             	sub    $0x4,%esp
  801315:	8b 45 10             	mov    0x10(%ebp),%eax
  801318:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80131b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80131e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801322:	8b 45 08             	mov    0x8(%ebp),%eax
  801325:	6a 00                	push   $0x0
  801327:	51                   	push   %ecx
  801328:	52                   	push   %edx
  801329:	ff 75 0c             	pushl  0xc(%ebp)
  80132c:	50                   	push   %eax
  80132d:	6a 1c                	push   $0x1c
  80132f:	e8 b6 fc ff ff       	call   800fea <syscall>
  801334:	83 c4 18             	add    $0x18,%esp
}
  801337:	c9                   	leave  
  801338:	c3                   	ret    

00801339 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801339:	55                   	push   %ebp
  80133a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80133c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80133f:	8b 45 08             	mov    0x8(%ebp),%eax
  801342:	6a 00                	push   $0x0
  801344:	6a 00                	push   $0x0
  801346:	6a 00                	push   $0x0
  801348:	52                   	push   %edx
  801349:	50                   	push   %eax
  80134a:	6a 1d                	push   $0x1d
  80134c:	e8 99 fc ff ff       	call   800fea <syscall>
  801351:	83 c4 18             	add    $0x18,%esp
}
  801354:	c9                   	leave  
  801355:	c3                   	ret    

00801356 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801356:	55                   	push   %ebp
  801357:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801359:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80135c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80135f:	8b 45 08             	mov    0x8(%ebp),%eax
  801362:	6a 00                	push   $0x0
  801364:	6a 00                	push   $0x0
  801366:	51                   	push   %ecx
  801367:	52                   	push   %edx
  801368:	50                   	push   %eax
  801369:	6a 1e                	push   $0x1e
  80136b:	e8 7a fc ff ff       	call   800fea <syscall>
  801370:	83 c4 18             	add    $0x18,%esp
}
  801373:	c9                   	leave  
  801374:	c3                   	ret    

00801375 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801375:	55                   	push   %ebp
  801376:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801378:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137b:	8b 45 08             	mov    0x8(%ebp),%eax
  80137e:	6a 00                	push   $0x0
  801380:	6a 00                	push   $0x0
  801382:	6a 00                	push   $0x0
  801384:	52                   	push   %edx
  801385:	50                   	push   %eax
  801386:	6a 1f                	push   $0x1f
  801388:	e8 5d fc ff ff       	call   800fea <syscall>
  80138d:	83 c4 18             	add    $0x18,%esp
}
  801390:	c9                   	leave  
  801391:	c3                   	ret    

00801392 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801392:	55                   	push   %ebp
  801393:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801395:	6a 00                	push   $0x0
  801397:	6a 00                	push   $0x0
  801399:	6a 00                	push   $0x0
  80139b:	6a 00                	push   $0x0
  80139d:	6a 00                	push   $0x0
  80139f:	6a 20                	push   $0x20
  8013a1:	e8 44 fc ff ff       	call   800fea <syscall>
  8013a6:	83 c4 18             	add    $0x18,%esp
}
  8013a9:	c9                   	leave  
  8013aa:	c3                   	ret    

008013ab <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8013ab:	55                   	push   %ebp
  8013ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8013ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b1:	6a 00                	push   $0x0
  8013b3:	ff 75 14             	pushl  0x14(%ebp)
  8013b6:	ff 75 10             	pushl  0x10(%ebp)
  8013b9:	ff 75 0c             	pushl  0xc(%ebp)
  8013bc:	50                   	push   %eax
  8013bd:	6a 21                	push   $0x21
  8013bf:	e8 26 fc ff ff       	call   800fea <syscall>
  8013c4:	83 c4 18             	add    $0x18,%esp
}
  8013c7:	c9                   	leave  
  8013c8:	c3                   	ret    

008013c9 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8013c9:	55                   	push   %ebp
  8013ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 00                	push   $0x0
  8013d3:	6a 00                	push   $0x0
  8013d5:	6a 00                	push   $0x0
  8013d7:	50                   	push   %eax
  8013d8:	6a 22                	push   $0x22
  8013da:	e8 0b fc ff ff       	call   800fea <syscall>
  8013df:	83 c4 18             	add    $0x18,%esp
}
  8013e2:	90                   	nop
  8013e3:	c9                   	leave  
  8013e4:	c3                   	ret    

008013e5 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013e5:	55                   	push   %ebp
  8013e6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8013e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 00                	push   $0x0
  8013f1:	6a 00                	push   $0x0
  8013f3:	50                   	push   %eax
  8013f4:	6a 23                	push   $0x23
  8013f6:	e8 ef fb ff ff       	call   800fea <syscall>
  8013fb:	83 c4 18             	add    $0x18,%esp
}
  8013fe:	90                   	nop
  8013ff:	c9                   	leave  
  801400:	c3                   	ret    

00801401 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801401:	55                   	push   %ebp
  801402:	89 e5                	mov    %esp,%ebp
  801404:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801407:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80140a:	8d 50 04             	lea    0x4(%eax),%edx
  80140d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801410:	6a 00                	push   $0x0
  801412:	6a 00                	push   $0x0
  801414:	6a 00                	push   $0x0
  801416:	52                   	push   %edx
  801417:	50                   	push   %eax
  801418:	6a 24                	push   $0x24
  80141a:	e8 cb fb ff ff       	call   800fea <syscall>
  80141f:	83 c4 18             	add    $0x18,%esp
	return result;
  801422:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801425:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801428:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80142b:	89 01                	mov    %eax,(%ecx)
  80142d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801430:	8b 45 08             	mov    0x8(%ebp),%eax
  801433:	c9                   	leave  
  801434:	c2 04 00             	ret    $0x4

00801437 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801437:	55                   	push   %ebp
  801438:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80143a:	6a 00                	push   $0x0
  80143c:	6a 00                	push   $0x0
  80143e:	ff 75 10             	pushl  0x10(%ebp)
  801441:	ff 75 0c             	pushl  0xc(%ebp)
  801444:	ff 75 08             	pushl  0x8(%ebp)
  801447:	6a 13                	push   $0x13
  801449:	e8 9c fb ff ff       	call   800fea <syscall>
  80144e:	83 c4 18             	add    $0x18,%esp
	return ;
  801451:	90                   	nop
}
  801452:	c9                   	leave  
  801453:	c3                   	ret    

00801454 <sys_rcr2>:
uint32 sys_rcr2()
{
  801454:	55                   	push   %ebp
  801455:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801457:	6a 00                	push   $0x0
  801459:	6a 00                	push   $0x0
  80145b:	6a 00                	push   $0x0
  80145d:	6a 00                	push   $0x0
  80145f:	6a 00                	push   $0x0
  801461:	6a 25                	push   $0x25
  801463:	e8 82 fb ff ff       	call   800fea <syscall>
  801468:	83 c4 18             	add    $0x18,%esp
}
  80146b:	c9                   	leave  
  80146c:	c3                   	ret    

0080146d <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80146d:	55                   	push   %ebp
  80146e:	89 e5                	mov    %esp,%ebp
  801470:	83 ec 04             	sub    $0x4,%esp
  801473:	8b 45 08             	mov    0x8(%ebp),%eax
  801476:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801479:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80147d:	6a 00                	push   $0x0
  80147f:	6a 00                	push   $0x0
  801481:	6a 00                	push   $0x0
  801483:	6a 00                	push   $0x0
  801485:	50                   	push   %eax
  801486:	6a 26                	push   $0x26
  801488:	e8 5d fb ff ff       	call   800fea <syscall>
  80148d:	83 c4 18             	add    $0x18,%esp
	return ;
  801490:	90                   	nop
}
  801491:	c9                   	leave  
  801492:	c3                   	ret    

00801493 <rsttst>:
void rsttst()
{
  801493:	55                   	push   %ebp
  801494:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	6a 00                	push   $0x0
  80149e:	6a 00                	push   $0x0
  8014a0:	6a 28                	push   $0x28
  8014a2:	e8 43 fb ff ff       	call   800fea <syscall>
  8014a7:	83 c4 18             	add    $0x18,%esp
	return ;
  8014aa:	90                   	nop
}
  8014ab:	c9                   	leave  
  8014ac:	c3                   	ret    

008014ad <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014ad:	55                   	push   %ebp
  8014ae:	89 e5                	mov    %esp,%ebp
  8014b0:	83 ec 04             	sub    $0x4,%esp
  8014b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8014b6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014b9:	8b 55 18             	mov    0x18(%ebp),%edx
  8014bc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014c0:	52                   	push   %edx
  8014c1:	50                   	push   %eax
  8014c2:	ff 75 10             	pushl  0x10(%ebp)
  8014c5:	ff 75 0c             	pushl  0xc(%ebp)
  8014c8:	ff 75 08             	pushl  0x8(%ebp)
  8014cb:	6a 27                	push   $0x27
  8014cd:	e8 18 fb ff ff       	call   800fea <syscall>
  8014d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8014d5:	90                   	nop
}
  8014d6:	c9                   	leave  
  8014d7:	c3                   	ret    

008014d8 <chktst>:
void chktst(uint32 n)
{
  8014d8:	55                   	push   %ebp
  8014d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	ff 75 08             	pushl  0x8(%ebp)
  8014e6:	6a 29                	push   $0x29
  8014e8:	e8 fd fa ff ff       	call   800fea <syscall>
  8014ed:	83 c4 18             	add    $0x18,%esp
	return ;
  8014f0:	90                   	nop
}
  8014f1:	c9                   	leave  
  8014f2:	c3                   	ret    

008014f3 <inctst>:

void inctst()
{
  8014f3:	55                   	push   %ebp
  8014f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 00                	push   $0x0
  801500:	6a 2a                	push   $0x2a
  801502:	e8 e3 fa ff ff       	call   800fea <syscall>
  801507:	83 c4 18             	add    $0x18,%esp
	return ;
  80150a:	90                   	nop
}
  80150b:	c9                   	leave  
  80150c:	c3                   	ret    

0080150d <gettst>:
uint32 gettst()
{
  80150d:	55                   	push   %ebp
  80150e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	6a 2b                	push   $0x2b
  80151c:	e8 c9 fa ff ff       	call   800fea <syscall>
  801521:	83 c4 18             	add    $0x18,%esp
}
  801524:	c9                   	leave  
  801525:	c3                   	ret    

00801526 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801526:	55                   	push   %ebp
  801527:	89 e5                	mov    %esp,%ebp
  801529:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80152c:	6a 00                	push   $0x0
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 2c                	push   $0x2c
  801538:	e8 ad fa ff ff       	call   800fea <syscall>
  80153d:	83 c4 18             	add    $0x18,%esp
  801540:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801543:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801547:	75 07                	jne    801550 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801549:	b8 01 00 00 00       	mov    $0x1,%eax
  80154e:	eb 05                	jmp    801555 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801550:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801555:	c9                   	leave  
  801556:	c3                   	ret    

00801557 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801557:	55                   	push   %ebp
  801558:	89 e5                	mov    %esp,%ebp
  80155a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80155d:	6a 00                	push   $0x0
  80155f:	6a 00                	push   $0x0
  801561:	6a 00                	push   $0x0
  801563:	6a 00                	push   $0x0
  801565:	6a 00                	push   $0x0
  801567:	6a 2c                	push   $0x2c
  801569:	e8 7c fa ff ff       	call   800fea <syscall>
  80156e:	83 c4 18             	add    $0x18,%esp
  801571:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801574:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801578:	75 07                	jne    801581 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80157a:	b8 01 00 00 00       	mov    $0x1,%eax
  80157f:	eb 05                	jmp    801586 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801581:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801586:	c9                   	leave  
  801587:	c3                   	ret    

00801588 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801588:	55                   	push   %ebp
  801589:	89 e5                	mov    %esp,%ebp
  80158b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 2c                	push   $0x2c
  80159a:	e8 4b fa ff ff       	call   800fea <syscall>
  80159f:	83 c4 18             	add    $0x18,%esp
  8015a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015a5:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015a9:	75 07                	jne    8015b2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015ab:	b8 01 00 00 00       	mov    $0x1,%eax
  8015b0:	eb 05                	jmp    8015b7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015b2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015b7:	c9                   	leave  
  8015b8:	c3                   	ret    

008015b9 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015b9:	55                   	push   %ebp
  8015ba:	89 e5                	mov    %esp,%ebp
  8015bc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 2c                	push   $0x2c
  8015cb:	e8 1a fa ff ff       	call   800fea <syscall>
  8015d0:	83 c4 18             	add    $0x18,%esp
  8015d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015d6:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015da:	75 07                	jne    8015e3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015dc:	b8 01 00 00 00       	mov    $0x1,%eax
  8015e1:	eb 05                	jmp    8015e8 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015e3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015e8:	c9                   	leave  
  8015e9:	c3                   	ret    

008015ea <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8015ea:	55                   	push   %ebp
  8015eb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8015ed:	6a 00                	push   $0x0
  8015ef:	6a 00                	push   $0x0
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 00                	push   $0x0
  8015f5:	ff 75 08             	pushl  0x8(%ebp)
  8015f8:	6a 2d                	push   $0x2d
  8015fa:	e8 eb f9 ff ff       	call   800fea <syscall>
  8015ff:	83 c4 18             	add    $0x18,%esp
	return ;
  801602:	90                   	nop
}
  801603:	c9                   	leave  
  801604:	c3                   	ret    

00801605 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801605:	55                   	push   %ebp
  801606:	89 e5                	mov    %esp,%ebp
  801608:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801609:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80160c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80160f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801612:	8b 45 08             	mov    0x8(%ebp),%eax
  801615:	6a 00                	push   $0x0
  801617:	53                   	push   %ebx
  801618:	51                   	push   %ecx
  801619:	52                   	push   %edx
  80161a:	50                   	push   %eax
  80161b:	6a 2e                	push   $0x2e
  80161d:	e8 c8 f9 ff ff       	call   800fea <syscall>
  801622:	83 c4 18             	add    $0x18,%esp
}
  801625:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801628:	c9                   	leave  
  801629:	c3                   	ret    

0080162a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80162a:	55                   	push   %ebp
  80162b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80162d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801630:	8b 45 08             	mov    0x8(%ebp),%eax
  801633:	6a 00                	push   $0x0
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	52                   	push   %edx
  80163a:	50                   	push   %eax
  80163b:	6a 2f                	push   $0x2f
  80163d:	e8 a8 f9 ff ff       	call   800fea <syscall>
  801642:	83 c4 18             	add    $0x18,%esp
}
  801645:	c9                   	leave  
  801646:	c3                   	ret    

00801647 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801647:	55                   	push   %ebp
  801648:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80164a:	6a 00                	push   $0x0
  80164c:	6a 00                	push   $0x0
  80164e:	6a 00                	push   $0x0
  801650:	ff 75 0c             	pushl  0xc(%ebp)
  801653:	ff 75 08             	pushl  0x8(%ebp)
  801656:	6a 30                	push   $0x30
  801658:	e8 8d f9 ff ff       	call   800fea <syscall>
  80165d:	83 c4 18             	add    $0x18,%esp
	return ;
  801660:	90                   	nop
}
  801661:	c9                   	leave  
  801662:	c3                   	ret    
  801663:	90                   	nop

00801664 <__udivdi3>:
  801664:	55                   	push   %ebp
  801665:	57                   	push   %edi
  801666:	56                   	push   %esi
  801667:	53                   	push   %ebx
  801668:	83 ec 1c             	sub    $0x1c,%esp
  80166b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80166f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801673:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801677:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80167b:	89 ca                	mov    %ecx,%edx
  80167d:	89 f8                	mov    %edi,%eax
  80167f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801683:	85 f6                	test   %esi,%esi
  801685:	75 2d                	jne    8016b4 <__udivdi3+0x50>
  801687:	39 cf                	cmp    %ecx,%edi
  801689:	77 65                	ja     8016f0 <__udivdi3+0x8c>
  80168b:	89 fd                	mov    %edi,%ebp
  80168d:	85 ff                	test   %edi,%edi
  80168f:	75 0b                	jne    80169c <__udivdi3+0x38>
  801691:	b8 01 00 00 00       	mov    $0x1,%eax
  801696:	31 d2                	xor    %edx,%edx
  801698:	f7 f7                	div    %edi
  80169a:	89 c5                	mov    %eax,%ebp
  80169c:	31 d2                	xor    %edx,%edx
  80169e:	89 c8                	mov    %ecx,%eax
  8016a0:	f7 f5                	div    %ebp
  8016a2:	89 c1                	mov    %eax,%ecx
  8016a4:	89 d8                	mov    %ebx,%eax
  8016a6:	f7 f5                	div    %ebp
  8016a8:	89 cf                	mov    %ecx,%edi
  8016aa:	89 fa                	mov    %edi,%edx
  8016ac:	83 c4 1c             	add    $0x1c,%esp
  8016af:	5b                   	pop    %ebx
  8016b0:	5e                   	pop    %esi
  8016b1:	5f                   	pop    %edi
  8016b2:	5d                   	pop    %ebp
  8016b3:	c3                   	ret    
  8016b4:	39 ce                	cmp    %ecx,%esi
  8016b6:	77 28                	ja     8016e0 <__udivdi3+0x7c>
  8016b8:	0f bd fe             	bsr    %esi,%edi
  8016bb:	83 f7 1f             	xor    $0x1f,%edi
  8016be:	75 40                	jne    801700 <__udivdi3+0x9c>
  8016c0:	39 ce                	cmp    %ecx,%esi
  8016c2:	72 0a                	jb     8016ce <__udivdi3+0x6a>
  8016c4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8016c8:	0f 87 9e 00 00 00    	ja     80176c <__udivdi3+0x108>
  8016ce:	b8 01 00 00 00       	mov    $0x1,%eax
  8016d3:	89 fa                	mov    %edi,%edx
  8016d5:	83 c4 1c             	add    $0x1c,%esp
  8016d8:	5b                   	pop    %ebx
  8016d9:	5e                   	pop    %esi
  8016da:	5f                   	pop    %edi
  8016db:	5d                   	pop    %ebp
  8016dc:	c3                   	ret    
  8016dd:	8d 76 00             	lea    0x0(%esi),%esi
  8016e0:	31 ff                	xor    %edi,%edi
  8016e2:	31 c0                	xor    %eax,%eax
  8016e4:	89 fa                	mov    %edi,%edx
  8016e6:	83 c4 1c             	add    $0x1c,%esp
  8016e9:	5b                   	pop    %ebx
  8016ea:	5e                   	pop    %esi
  8016eb:	5f                   	pop    %edi
  8016ec:	5d                   	pop    %ebp
  8016ed:	c3                   	ret    
  8016ee:	66 90                	xchg   %ax,%ax
  8016f0:	89 d8                	mov    %ebx,%eax
  8016f2:	f7 f7                	div    %edi
  8016f4:	31 ff                	xor    %edi,%edi
  8016f6:	89 fa                	mov    %edi,%edx
  8016f8:	83 c4 1c             	add    $0x1c,%esp
  8016fb:	5b                   	pop    %ebx
  8016fc:	5e                   	pop    %esi
  8016fd:	5f                   	pop    %edi
  8016fe:	5d                   	pop    %ebp
  8016ff:	c3                   	ret    
  801700:	bd 20 00 00 00       	mov    $0x20,%ebp
  801705:	89 eb                	mov    %ebp,%ebx
  801707:	29 fb                	sub    %edi,%ebx
  801709:	89 f9                	mov    %edi,%ecx
  80170b:	d3 e6                	shl    %cl,%esi
  80170d:	89 c5                	mov    %eax,%ebp
  80170f:	88 d9                	mov    %bl,%cl
  801711:	d3 ed                	shr    %cl,%ebp
  801713:	89 e9                	mov    %ebp,%ecx
  801715:	09 f1                	or     %esi,%ecx
  801717:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80171b:	89 f9                	mov    %edi,%ecx
  80171d:	d3 e0                	shl    %cl,%eax
  80171f:	89 c5                	mov    %eax,%ebp
  801721:	89 d6                	mov    %edx,%esi
  801723:	88 d9                	mov    %bl,%cl
  801725:	d3 ee                	shr    %cl,%esi
  801727:	89 f9                	mov    %edi,%ecx
  801729:	d3 e2                	shl    %cl,%edx
  80172b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80172f:	88 d9                	mov    %bl,%cl
  801731:	d3 e8                	shr    %cl,%eax
  801733:	09 c2                	or     %eax,%edx
  801735:	89 d0                	mov    %edx,%eax
  801737:	89 f2                	mov    %esi,%edx
  801739:	f7 74 24 0c          	divl   0xc(%esp)
  80173d:	89 d6                	mov    %edx,%esi
  80173f:	89 c3                	mov    %eax,%ebx
  801741:	f7 e5                	mul    %ebp
  801743:	39 d6                	cmp    %edx,%esi
  801745:	72 19                	jb     801760 <__udivdi3+0xfc>
  801747:	74 0b                	je     801754 <__udivdi3+0xf0>
  801749:	89 d8                	mov    %ebx,%eax
  80174b:	31 ff                	xor    %edi,%edi
  80174d:	e9 58 ff ff ff       	jmp    8016aa <__udivdi3+0x46>
  801752:	66 90                	xchg   %ax,%ax
  801754:	8b 54 24 08          	mov    0x8(%esp),%edx
  801758:	89 f9                	mov    %edi,%ecx
  80175a:	d3 e2                	shl    %cl,%edx
  80175c:	39 c2                	cmp    %eax,%edx
  80175e:	73 e9                	jae    801749 <__udivdi3+0xe5>
  801760:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801763:	31 ff                	xor    %edi,%edi
  801765:	e9 40 ff ff ff       	jmp    8016aa <__udivdi3+0x46>
  80176a:	66 90                	xchg   %ax,%ax
  80176c:	31 c0                	xor    %eax,%eax
  80176e:	e9 37 ff ff ff       	jmp    8016aa <__udivdi3+0x46>
  801773:	90                   	nop

00801774 <__umoddi3>:
  801774:	55                   	push   %ebp
  801775:	57                   	push   %edi
  801776:	56                   	push   %esi
  801777:	53                   	push   %ebx
  801778:	83 ec 1c             	sub    $0x1c,%esp
  80177b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80177f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801783:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801787:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80178b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80178f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801793:	89 f3                	mov    %esi,%ebx
  801795:	89 fa                	mov    %edi,%edx
  801797:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80179b:	89 34 24             	mov    %esi,(%esp)
  80179e:	85 c0                	test   %eax,%eax
  8017a0:	75 1a                	jne    8017bc <__umoddi3+0x48>
  8017a2:	39 f7                	cmp    %esi,%edi
  8017a4:	0f 86 a2 00 00 00    	jbe    80184c <__umoddi3+0xd8>
  8017aa:	89 c8                	mov    %ecx,%eax
  8017ac:	89 f2                	mov    %esi,%edx
  8017ae:	f7 f7                	div    %edi
  8017b0:	89 d0                	mov    %edx,%eax
  8017b2:	31 d2                	xor    %edx,%edx
  8017b4:	83 c4 1c             	add    $0x1c,%esp
  8017b7:	5b                   	pop    %ebx
  8017b8:	5e                   	pop    %esi
  8017b9:	5f                   	pop    %edi
  8017ba:	5d                   	pop    %ebp
  8017bb:	c3                   	ret    
  8017bc:	39 f0                	cmp    %esi,%eax
  8017be:	0f 87 ac 00 00 00    	ja     801870 <__umoddi3+0xfc>
  8017c4:	0f bd e8             	bsr    %eax,%ebp
  8017c7:	83 f5 1f             	xor    $0x1f,%ebp
  8017ca:	0f 84 ac 00 00 00    	je     80187c <__umoddi3+0x108>
  8017d0:	bf 20 00 00 00       	mov    $0x20,%edi
  8017d5:	29 ef                	sub    %ebp,%edi
  8017d7:	89 fe                	mov    %edi,%esi
  8017d9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8017dd:	89 e9                	mov    %ebp,%ecx
  8017df:	d3 e0                	shl    %cl,%eax
  8017e1:	89 d7                	mov    %edx,%edi
  8017e3:	89 f1                	mov    %esi,%ecx
  8017e5:	d3 ef                	shr    %cl,%edi
  8017e7:	09 c7                	or     %eax,%edi
  8017e9:	89 e9                	mov    %ebp,%ecx
  8017eb:	d3 e2                	shl    %cl,%edx
  8017ed:	89 14 24             	mov    %edx,(%esp)
  8017f0:	89 d8                	mov    %ebx,%eax
  8017f2:	d3 e0                	shl    %cl,%eax
  8017f4:	89 c2                	mov    %eax,%edx
  8017f6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017fa:	d3 e0                	shl    %cl,%eax
  8017fc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801800:	8b 44 24 08          	mov    0x8(%esp),%eax
  801804:	89 f1                	mov    %esi,%ecx
  801806:	d3 e8                	shr    %cl,%eax
  801808:	09 d0                	or     %edx,%eax
  80180a:	d3 eb                	shr    %cl,%ebx
  80180c:	89 da                	mov    %ebx,%edx
  80180e:	f7 f7                	div    %edi
  801810:	89 d3                	mov    %edx,%ebx
  801812:	f7 24 24             	mull   (%esp)
  801815:	89 c6                	mov    %eax,%esi
  801817:	89 d1                	mov    %edx,%ecx
  801819:	39 d3                	cmp    %edx,%ebx
  80181b:	0f 82 87 00 00 00    	jb     8018a8 <__umoddi3+0x134>
  801821:	0f 84 91 00 00 00    	je     8018b8 <__umoddi3+0x144>
  801827:	8b 54 24 04          	mov    0x4(%esp),%edx
  80182b:	29 f2                	sub    %esi,%edx
  80182d:	19 cb                	sbb    %ecx,%ebx
  80182f:	89 d8                	mov    %ebx,%eax
  801831:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801835:	d3 e0                	shl    %cl,%eax
  801837:	89 e9                	mov    %ebp,%ecx
  801839:	d3 ea                	shr    %cl,%edx
  80183b:	09 d0                	or     %edx,%eax
  80183d:	89 e9                	mov    %ebp,%ecx
  80183f:	d3 eb                	shr    %cl,%ebx
  801841:	89 da                	mov    %ebx,%edx
  801843:	83 c4 1c             	add    $0x1c,%esp
  801846:	5b                   	pop    %ebx
  801847:	5e                   	pop    %esi
  801848:	5f                   	pop    %edi
  801849:	5d                   	pop    %ebp
  80184a:	c3                   	ret    
  80184b:	90                   	nop
  80184c:	89 fd                	mov    %edi,%ebp
  80184e:	85 ff                	test   %edi,%edi
  801850:	75 0b                	jne    80185d <__umoddi3+0xe9>
  801852:	b8 01 00 00 00       	mov    $0x1,%eax
  801857:	31 d2                	xor    %edx,%edx
  801859:	f7 f7                	div    %edi
  80185b:	89 c5                	mov    %eax,%ebp
  80185d:	89 f0                	mov    %esi,%eax
  80185f:	31 d2                	xor    %edx,%edx
  801861:	f7 f5                	div    %ebp
  801863:	89 c8                	mov    %ecx,%eax
  801865:	f7 f5                	div    %ebp
  801867:	89 d0                	mov    %edx,%eax
  801869:	e9 44 ff ff ff       	jmp    8017b2 <__umoddi3+0x3e>
  80186e:	66 90                	xchg   %ax,%ax
  801870:	89 c8                	mov    %ecx,%eax
  801872:	89 f2                	mov    %esi,%edx
  801874:	83 c4 1c             	add    $0x1c,%esp
  801877:	5b                   	pop    %ebx
  801878:	5e                   	pop    %esi
  801879:	5f                   	pop    %edi
  80187a:	5d                   	pop    %ebp
  80187b:	c3                   	ret    
  80187c:	3b 04 24             	cmp    (%esp),%eax
  80187f:	72 06                	jb     801887 <__umoddi3+0x113>
  801881:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801885:	77 0f                	ja     801896 <__umoddi3+0x122>
  801887:	89 f2                	mov    %esi,%edx
  801889:	29 f9                	sub    %edi,%ecx
  80188b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80188f:	89 14 24             	mov    %edx,(%esp)
  801892:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801896:	8b 44 24 04          	mov    0x4(%esp),%eax
  80189a:	8b 14 24             	mov    (%esp),%edx
  80189d:	83 c4 1c             	add    $0x1c,%esp
  8018a0:	5b                   	pop    %ebx
  8018a1:	5e                   	pop    %esi
  8018a2:	5f                   	pop    %edi
  8018a3:	5d                   	pop    %ebp
  8018a4:	c3                   	ret    
  8018a5:	8d 76 00             	lea    0x0(%esi),%esi
  8018a8:	2b 04 24             	sub    (%esp),%eax
  8018ab:	19 fa                	sbb    %edi,%edx
  8018ad:	89 d1                	mov    %edx,%ecx
  8018af:	89 c6                	mov    %eax,%esi
  8018b1:	e9 71 ff ff ff       	jmp    801827 <__umoddi3+0xb3>
  8018b6:	66 90                	xchg   %ax,%ax
  8018b8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8018bc:	72 ea                	jb     8018a8 <__umoddi3+0x134>
  8018be:	89 d9                	mov    %ebx,%ecx
  8018c0:	e9 62 ff ff ff       	jmp    801827 <__umoddi3+0xb3>
