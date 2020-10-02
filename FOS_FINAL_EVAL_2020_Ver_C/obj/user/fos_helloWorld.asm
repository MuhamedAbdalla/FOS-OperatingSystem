
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
  800046:	e8 45 02 00 00       	call   800290 <atomic_cprintf>
  80004b:	83 c4 10             	add    $0x10,%esp
	atomic_cprintf("end of code = %x\n",etext);
  80004e:	a1 c9 18 80 00       	mov    0x8018c9,%eax
  800053:	83 ec 08             	sub    $0x8,%esp
  800056:	50                   	push   %eax
  800057:	68 08 19 80 00       	push   $0x801908
  80005c:	e8 2f 02 00 00       	call   800290 <atomic_cprintf>
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
  80006d:	e8 1c 10 00 00       	call   80108e <sys_getenvindex>
  800072:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800075:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800078:	89 d0                	mov    %edx,%eax
  80007a:	01 c0                	add    %eax,%eax
  80007c:	01 d0                	add    %edx,%eax
  80007e:	c1 e0 07             	shl    $0x7,%eax
  800081:	29 d0                	sub    %edx,%eax
  800083:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80008a:	01 c8                	add    %ecx,%eax
  80008c:	01 c0                	add    %eax,%eax
  80008e:	01 d0                	add    %edx,%eax
  800090:	01 c0                	add    %eax,%eax
  800092:	01 d0                	add    %edx,%eax
  800094:	c1 e0 03             	shl    $0x3,%eax
  800097:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80009c:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000a1:	a1 20 20 80 00       	mov    0x802020,%eax
  8000a6:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  8000ac:	84 c0                	test   %al,%al
  8000ae:	74 0f                	je     8000bf <libmain+0x58>
		binaryname = myEnv->prog_name;
  8000b0:	a1 20 20 80 00       	mov    0x802020,%eax
  8000b5:	05 f0 ee 00 00       	add    $0xeef0,%eax
  8000ba:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000bf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000c3:	7e 0a                	jle    8000cf <libmain+0x68>
		binaryname = argv[0];
  8000c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000c8:	8b 00                	mov    (%eax),%eax
  8000ca:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000cf:	83 ec 08             	sub    $0x8,%esp
  8000d2:	ff 75 0c             	pushl  0xc(%ebp)
  8000d5:	ff 75 08             	pushl  0x8(%ebp)
  8000d8:	e8 5b ff ff ff       	call   800038 <_main>
  8000dd:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000e0:	e8 44 11 00 00       	call   801229 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000e5:	83 ec 0c             	sub    $0xc,%esp
  8000e8:	68 34 19 80 00       	push   $0x801934
  8000ed:	e8 71 01 00 00       	call   800263 <cprintf>
  8000f2:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8000f5:	a1 20 20 80 00       	mov    0x802020,%eax
  8000fa:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  800100:	a1 20 20 80 00       	mov    0x802020,%eax
  800105:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  80010b:	83 ec 04             	sub    $0x4,%esp
  80010e:	52                   	push   %edx
  80010f:	50                   	push   %eax
  800110:	68 5c 19 80 00       	push   $0x80195c
  800115:	e8 49 01 00 00       	call   800263 <cprintf>
  80011a:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80011d:	a1 20 20 80 00       	mov    0x802020,%eax
  800122:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  800128:	a1 20 20 80 00       	mov    0x802020,%eax
  80012d:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  800133:	a1 20 20 80 00       	mov    0x802020,%eax
  800138:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  80013e:	51                   	push   %ecx
  80013f:	52                   	push   %edx
  800140:	50                   	push   %eax
  800141:	68 84 19 80 00       	push   $0x801984
  800146:	e8 18 01 00 00       	call   800263 <cprintf>
  80014b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80014e:	83 ec 0c             	sub    $0xc,%esp
  800151:	68 34 19 80 00       	push   $0x801934
  800156:	e8 08 01 00 00       	call   800263 <cprintf>
  80015b:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80015e:	e8 e0 10 00 00       	call   801243 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800163:	e8 19 00 00 00       	call   800181 <exit>
}
  800168:	90                   	nop
  800169:	c9                   	leave  
  80016a:	c3                   	ret    

0080016b <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80016b:	55                   	push   %ebp
  80016c:	89 e5                	mov    %esp,%ebp
  80016e:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800171:	83 ec 0c             	sub    $0xc,%esp
  800174:	6a 00                	push   $0x0
  800176:	e8 df 0e 00 00       	call   80105a <sys_env_destroy>
  80017b:	83 c4 10             	add    $0x10,%esp
}
  80017e:	90                   	nop
  80017f:	c9                   	leave  
  800180:	c3                   	ret    

00800181 <exit>:

void
exit(void)
{
  800181:	55                   	push   %ebp
  800182:	89 e5                	mov    %esp,%ebp
  800184:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800187:	e8 34 0f 00 00       	call   8010c0 <sys_env_exit>
}
  80018c:	90                   	nop
  80018d:	c9                   	leave  
  80018e:	c3                   	ret    

0080018f <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80018f:	55                   	push   %ebp
  800190:	89 e5                	mov    %esp,%ebp
  800192:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800195:	8b 45 0c             	mov    0xc(%ebp),%eax
  800198:	8b 00                	mov    (%eax),%eax
  80019a:	8d 48 01             	lea    0x1(%eax),%ecx
  80019d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001a0:	89 0a                	mov    %ecx,(%edx)
  8001a2:	8b 55 08             	mov    0x8(%ebp),%edx
  8001a5:	88 d1                	mov    %dl,%cl
  8001a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001aa:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001b1:	8b 00                	mov    (%eax),%eax
  8001b3:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001b8:	75 2c                	jne    8001e6 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001ba:	a0 24 20 80 00       	mov    0x802024,%al
  8001bf:	0f b6 c0             	movzbl %al,%eax
  8001c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001c5:	8b 12                	mov    (%edx),%edx
  8001c7:	89 d1                	mov    %edx,%ecx
  8001c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001cc:	83 c2 08             	add    $0x8,%edx
  8001cf:	83 ec 04             	sub    $0x4,%esp
  8001d2:	50                   	push   %eax
  8001d3:	51                   	push   %ecx
  8001d4:	52                   	push   %edx
  8001d5:	e8 3e 0e 00 00       	call   801018 <sys_cputs>
  8001da:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001e9:	8b 40 04             	mov    0x4(%eax),%eax
  8001ec:	8d 50 01             	lea    0x1(%eax),%edx
  8001ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f2:	89 50 04             	mov    %edx,0x4(%eax)
}
  8001f5:	90                   	nop
  8001f6:	c9                   	leave  
  8001f7:	c3                   	ret    

008001f8 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8001f8:	55                   	push   %ebp
  8001f9:	89 e5                	mov    %esp,%ebp
  8001fb:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800201:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800208:	00 00 00 
	b.cnt = 0;
  80020b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800212:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800215:	ff 75 0c             	pushl  0xc(%ebp)
  800218:	ff 75 08             	pushl  0x8(%ebp)
  80021b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800221:	50                   	push   %eax
  800222:	68 8f 01 80 00       	push   $0x80018f
  800227:	e8 11 02 00 00       	call   80043d <vprintfmt>
  80022c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80022f:	a0 24 20 80 00       	mov    0x802024,%al
  800234:	0f b6 c0             	movzbl %al,%eax
  800237:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80023d:	83 ec 04             	sub    $0x4,%esp
  800240:	50                   	push   %eax
  800241:	52                   	push   %edx
  800242:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800248:	83 c0 08             	add    $0x8,%eax
  80024b:	50                   	push   %eax
  80024c:	e8 c7 0d 00 00       	call   801018 <sys_cputs>
  800251:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800254:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  80025b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800261:	c9                   	leave  
  800262:	c3                   	ret    

00800263 <cprintf>:

int cprintf(const char *fmt, ...) {
  800263:	55                   	push   %ebp
  800264:	89 e5                	mov    %esp,%ebp
  800266:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800269:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  800270:	8d 45 0c             	lea    0xc(%ebp),%eax
  800273:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800276:	8b 45 08             	mov    0x8(%ebp),%eax
  800279:	83 ec 08             	sub    $0x8,%esp
  80027c:	ff 75 f4             	pushl  -0xc(%ebp)
  80027f:	50                   	push   %eax
  800280:	e8 73 ff ff ff       	call   8001f8 <vcprintf>
  800285:	83 c4 10             	add    $0x10,%esp
  800288:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80028b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80028e:	c9                   	leave  
  80028f:	c3                   	ret    

00800290 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800290:	55                   	push   %ebp
  800291:	89 e5                	mov    %esp,%ebp
  800293:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800296:	e8 8e 0f 00 00       	call   801229 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80029b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80029e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002a4:	83 ec 08             	sub    $0x8,%esp
  8002a7:	ff 75 f4             	pushl  -0xc(%ebp)
  8002aa:	50                   	push   %eax
  8002ab:	e8 48 ff ff ff       	call   8001f8 <vcprintf>
  8002b0:	83 c4 10             	add    $0x10,%esp
  8002b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002b6:	e8 88 0f 00 00       	call   801243 <sys_enable_interrupt>
	return cnt;
  8002bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002be:	c9                   	leave  
  8002bf:	c3                   	ret    

008002c0 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002c0:	55                   	push   %ebp
  8002c1:	89 e5                	mov    %esp,%ebp
  8002c3:	53                   	push   %ebx
  8002c4:	83 ec 14             	sub    $0x14,%esp
  8002c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8002ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8002d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002d3:	8b 45 18             	mov    0x18(%ebp),%eax
  8002d6:	ba 00 00 00 00       	mov    $0x0,%edx
  8002db:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002de:	77 55                	ja     800335 <printnum+0x75>
  8002e0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002e3:	72 05                	jb     8002ea <printnum+0x2a>
  8002e5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002e8:	77 4b                	ja     800335 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8002ea:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8002ed:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8002f0:	8b 45 18             	mov    0x18(%ebp),%eax
  8002f3:	ba 00 00 00 00       	mov    $0x0,%edx
  8002f8:	52                   	push   %edx
  8002f9:	50                   	push   %eax
  8002fa:	ff 75 f4             	pushl  -0xc(%ebp)
  8002fd:	ff 75 f0             	pushl  -0x10(%ebp)
  800300:	e8 63 13 00 00       	call   801668 <__udivdi3>
  800305:	83 c4 10             	add    $0x10,%esp
  800308:	83 ec 04             	sub    $0x4,%esp
  80030b:	ff 75 20             	pushl  0x20(%ebp)
  80030e:	53                   	push   %ebx
  80030f:	ff 75 18             	pushl  0x18(%ebp)
  800312:	52                   	push   %edx
  800313:	50                   	push   %eax
  800314:	ff 75 0c             	pushl  0xc(%ebp)
  800317:	ff 75 08             	pushl  0x8(%ebp)
  80031a:	e8 a1 ff ff ff       	call   8002c0 <printnum>
  80031f:	83 c4 20             	add    $0x20,%esp
  800322:	eb 1a                	jmp    80033e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800324:	83 ec 08             	sub    $0x8,%esp
  800327:	ff 75 0c             	pushl  0xc(%ebp)
  80032a:	ff 75 20             	pushl  0x20(%ebp)
  80032d:	8b 45 08             	mov    0x8(%ebp),%eax
  800330:	ff d0                	call   *%eax
  800332:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800335:	ff 4d 1c             	decl   0x1c(%ebp)
  800338:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80033c:	7f e6                	jg     800324 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80033e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800341:	bb 00 00 00 00       	mov    $0x0,%ebx
  800346:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800349:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80034c:	53                   	push   %ebx
  80034d:	51                   	push   %ecx
  80034e:	52                   	push   %edx
  80034f:	50                   	push   %eax
  800350:	e8 23 14 00 00       	call   801778 <__umoddi3>
  800355:	83 c4 10             	add    $0x10,%esp
  800358:	05 f4 1b 80 00       	add    $0x801bf4,%eax
  80035d:	8a 00                	mov    (%eax),%al
  80035f:	0f be c0             	movsbl %al,%eax
  800362:	83 ec 08             	sub    $0x8,%esp
  800365:	ff 75 0c             	pushl  0xc(%ebp)
  800368:	50                   	push   %eax
  800369:	8b 45 08             	mov    0x8(%ebp),%eax
  80036c:	ff d0                	call   *%eax
  80036e:	83 c4 10             	add    $0x10,%esp
}
  800371:	90                   	nop
  800372:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800375:	c9                   	leave  
  800376:	c3                   	ret    

00800377 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800377:	55                   	push   %ebp
  800378:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80037a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80037e:	7e 1c                	jle    80039c <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800380:	8b 45 08             	mov    0x8(%ebp),%eax
  800383:	8b 00                	mov    (%eax),%eax
  800385:	8d 50 08             	lea    0x8(%eax),%edx
  800388:	8b 45 08             	mov    0x8(%ebp),%eax
  80038b:	89 10                	mov    %edx,(%eax)
  80038d:	8b 45 08             	mov    0x8(%ebp),%eax
  800390:	8b 00                	mov    (%eax),%eax
  800392:	83 e8 08             	sub    $0x8,%eax
  800395:	8b 50 04             	mov    0x4(%eax),%edx
  800398:	8b 00                	mov    (%eax),%eax
  80039a:	eb 40                	jmp    8003dc <getuint+0x65>
	else if (lflag)
  80039c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003a0:	74 1e                	je     8003c0 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a5:	8b 00                	mov    (%eax),%eax
  8003a7:	8d 50 04             	lea    0x4(%eax),%edx
  8003aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ad:	89 10                	mov    %edx,(%eax)
  8003af:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b2:	8b 00                	mov    (%eax),%eax
  8003b4:	83 e8 04             	sub    $0x4,%eax
  8003b7:	8b 00                	mov    (%eax),%eax
  8003b9:	ba 00 00 00 00       	mov    $0x0,%edx
  8003be:	eb 1c                	jmp    8003dc <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c3:	8b 00                	mov    (%eax),%eax
  8003c5:	8d 50 04             	lea    0x4(%eax),%edx
  8003c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cb:	89 10                	mov    %edx,(%eax)
  8003cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d0:	8b 00                	mov    (%eax),%eax
  8003d2:	83 e8 04             	sub    $0x4,%eax
  8003d5:	8b 00                	mov    (%eax),%eax
  8003d7:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003dc:	5d                   	pop    %ebp
  8003dd:	c3                   	ret    

008003de <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003de:	55                   	push   %ebp
  8003df:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003e1:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003e5:	7e 1c                	jle    800403 <getint+0x25>
		return va_arg(*ap, long long);
  8003e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ea:	8b 00                	mov    (%eax),%eax
  8003ec:	8d 50 08             	lea    0x8(%eax),%edx
  8003ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f2:	89 10                	mov    %edx,(%eax)
  8003f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f7:	8b 00                	mov    (%eax),%eax
  8003f9:	83 e8 08             	sub    $0x8,%eax
  8003fc:	8b 50 04             	mov    0x4(%eax),%edx
  8003ff:	8b 00                	mov    (%eax),%eax
  800401:	eb 38                	jmp    80043b <getint+0x5d>
	else if (lflag)
  800403:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800407:	74 1a                	je     800423 <getint+0x45>
		return va_arg(*ap, long);
  800409:	8b 45 08             	mov    0x8(%ebp),%eax
  80040c:	8b 00                	mov    (%eax),%eax
  80040e:	8d 50 04             	lea    0x4(%eax),%edx
  800411:	8b 45 08             	mov    0x8(%ebp),%eax
  800414:	89 10                	mov    %edx,(%eax)
  800416:	8b 45 08             	mov    0x8(%ebp),%eax
  800419:	8b 00                	mov    (%eax),%eax
  80041b:	83 e8 04             	sub    $0x4,%eax
  80041e:	8b 00                	mov    (%eax),%eax
  800420:	99                   	cltd   
  800421:	eb 18                	jmp    80043b <getint+0x5d>
	else
		return va_arg(*ap, int);
  800423:	8b 45 08             	mov    0x8(%ebp),%eax
  800426:	8b 00                	mov    (%eax),%eax
  800428:	8d 50 04             	lea    0x4(%eax),%edx
  80042b:	8b 45 08             	mov    0x8(%ebp),%eax
  80042e:	89 10                	mov    %edx,(%eax)
  800430:	8b 45 08             	mov    0x8(%ebp),%eax
  800433:	8b 00                	mov    (%eax),%eax
  800435:	83 e8 04             	sub    $0x4,%eax
  800438:	8b 00                	mov    (%eax),%eax
  80043a:	99                   	cltd   
}
  80043b:	5d                   	pop    %ebp
  80043c:	c3                   	ret    

0080043d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80043d:	55                   	push   %ebp
  80043e:	89 e5                	mov    %esp,%ebp
  800440:	56                   	push   %esi
  800441:	53                   	push   %ebx
  800442:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800445:	eb 17                	jmp    80045e <vprintfmt+0x21>
			if (ch == '\0')
  800447:	85 db                	test   %ebx,%ebx
  800449:	0f 84 af 03 00 00    	je     8007fe <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80044f:	83 ec 08             	sub    $0x8,%esp
  800452:	ff 75 0c             	pushl  0xc(%ebp)
  800455:	53                   	push   %ebx
  800456:	8b 45 08             	mov    0x8(%ebp),%eax
  800459:	ff d0                	call   *%eax
  80045b:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80045e:	8b 45 10             	mov    0x10(%ebp),%eax
  800461:	8d 50 01             	lea    0x1(%eax),%edx
  800464:	89 55 10             	mov    %edx,0x10(%ebp)
  800467:	8a 00                	mov    (%eax),%al
  800469:	0f b6 d8             	movzbl %al,%ebx
  80046c:	83 fb 25             	cmp    $0x25,%ebx
  80046f:	75 d6                	jne    800447 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800471:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800475:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80047c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800483:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80048a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800491:	8b 45 10             	mov    0x10(%ebp),%eax
  800494:	8d 50 01             	lea    0x1(%eax),%edx
  800497:	89 55 10             	mov    %edx,0x10(%ebp)
  80049a:	8a 00                	mov    (%eax),%al
  80049c:	0f b6 d8             	movzbl %al,%ebx
  80049f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004a2:	83 f8 55             	cmp    $0x55,%eax
  8004a5:	0f 87 2b 03 00 00    	ja     8007d6 <vprintfmt+0x399>
  8004ab:	8b 04 85 18 1c 80 00 	mov    0x801c18(,%eax,4),%eax
  8004b2:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004b4:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004b8:	eb d7                	jmp    800491 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004ba:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004be:	eb d1                	jmp    800491 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004c0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004c7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004ca:	89 d0                	mov    %edx,%eax
  8004cc:	c1 e0 02             	shl    $0x2,%eax
  8004cf:	01 d0                	add    %edx,%eax
  8004d1:	01 c0                	add    %eax,%eax
  8004d3:	01 d8                	add    %ebx,%eax
  8004d5:	83 e8 30             	sub    $0x30,%eax
  8004d8:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004db:	8b 45 10             	mov    0x10(%ebp),%eax
  8004de:	8a 00                	mov    (%eax),%al
  8004e0:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004e3:	83 fb 2f             	cmp    $0x2f,%ebx
  8004e6:	7e 3e                	jle    800526 <vprintfmt+0xe9>
  8004e8:	83 fb 39             	cmp    $0x39,%ebx
  8004eb:	7f 39                	jg     800526 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004ed:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8004f0:	eb d5                	jmp    8004c7 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8004f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8004f5:	83 c0 04             	add    $0x4,%eax
  8004f8:	89 45 14             	mov    %eax,0x14(%ebp)
  8004fb:	8b 45 14             	mov    0x14(%ebp),%eax
  8004fe:	83 e8 04             	sub    $0x4,%eax
  800501:	8b 00                	mov    (%eax),%eax
  800503:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800506:	eb 1f                	jmp    800527 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800508:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80050c:	79 83                	jns    800491 <vprintfmt+0x54>
				width = 0;
  80050e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800515:	e9 77 ff ff ff       	jmp    800491 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80051a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800521:	e9 6b ff ff ff       	jmp    800491 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800526:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800527:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80052b:	0f 89 60 ff ff ff    	jns    800491 <vprintfmt+0x54>
				width = precision, precision = -1;
  800531:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800534:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800537:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80053e:	e9 4e ff ff ff       	jmp    800491 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800543:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800546:	e9 46 ff ff ff       	jmp    800491 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80054b:	8b 45 14             	mov    0x14(%ebp),%eax
  80054e:	83 c0 04             	add    $0x4,%eax
  800551:	89 45 14             	mov    %eax,0x14(%ebp)
  800554:	8b 45 14             	mov    0x14(%ebp),%eax
  800557:	83 e8 04             	sub    $0x4,%eax
  80055a:	8b 00                	mov    (%eax),%eax
  80055c:	83 ec 08             	sub    $0x8,%esp
  80055f:	ff 75 0c             	pushl  0xc(%ebp)
  800562:	50                   	push   %eax
  800563:	8b 45 08             	mov    0x8(%ebp),%eax
  800566:	ff d0                	call   *%eax
  800568:	83 c4 10             	add    $0x10,%esp
			break;
  80056b:	e9 89 02 00 00       	jmp    8007f9 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800570:	8b 45 14             	mov    0x14(%ebp),%eax
  800573:	83 c0 04             	add    $0x4,%eax
  800576:	89 45 14             	mov    %eax,0x14(%ebp)
  800579:	8b 45 14             	mov    0x14(%ebp),%eax
  80057c:	83 e8 04             	sub    $0x4,%eax
  80057f:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800581:	85 db                	test   %ebx,%ebx
  800583:	79 02                	jns    800587 <vprintfmt+0x14a>
				err = -err;
  800585:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800587:	83 fb 64             	cmp    $0x64,%ebx
  80058a:	7f 0b                	jg     800597 <vprintfmt+0x15a>
  80058c:	8b 34 9d 60 1a 80 00 	mov    0x801a60(,%ebx,4),%esi
  800593:	85 f6                	test   %esi,%esi
  800595:	75 19                	jne    8005b0 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800597:	53                   	push   %ebx
  800598:	68 05 1c 80 00       	push   $0x801c05
  80059d:	ff 75 0c             	pushl  0xc(%ebp)
  8005a0:	ff 75 08             	pushl  0x8(%ebp)
  8005a3:	e8 5e 02 00 00       	call   800806 <printfmt>
  8005a8:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005ab:	e9 49 02 00 00       	jmp    8007f9 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005b0:	56                   	push   %esi
  8005b1:	68 0e 1c 80 00       	push   $0x801c0e
  8005b6:	ff 75 0c             	pushl  0xc(%ebp)
  8005b9:	ff 75 08             	pushl  0x8(%ebp)
  8005bc:	e8 45 02 00 00       	call   800806 <printfmt>
  8005c1:	83 c4 10             	add    $0x10,%esp
			break;
  8005c4:	e9 30 02 00 00       	jmp    8007f9 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8005cc:	83 c0 04             	add    $0x4,%eax
  8005cf:	89 45 14             	mov    %eax,0x14(%ebp)
  8005d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d5:	83 e8 04             	sub    $0x4,%eax
  8005d8:	8b 30                	mov    (%eax),%esi
  8005da:	85 f6                	test   %esi,%esi
  8005dc:	75 05                	jne    8005e3 <vprintfmt+0x1a6>
				p = "(null)";
  8005de:	be 11 1c 80 00       	mov    $0x801c11,%esi
			if (width > 0 && padc != '-')
  8005e3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005e7:	7e 6d                	jle    800656 <vprintfmt+0x219>
  8005e9:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8005ed:	74 67                	je     800656 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8005ef:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005f2:	83 ec 08             	sub    $0x8,%esp
  8005f5:	50                   	push   %eax
  8005f6:	56                   	push   %esi
  8005f7:	e8 0c 03 00 00       	call   800908 <strnlen>
  8005fc:	83 c4 10             	add    $0x10,%esp
  8005ff:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800602:	eb 16                	jmp    80061a <vprintfmt+0x1dd>
					putch(padc, putdat);
  800604:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800608:	83 ec 08             	sub    $0x8,%esp
  80060b:	ff 75 0c             	pushl  0xc(%ebp)
  80060e:	50                   	push   %eax
  80060f:	8b 45 08             	mov    0x8(%ebp),%eax
  800612:	ff d0                	call   *%eax
  800614:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800617:	ff 4d e4             	decl   -0x1c(%ebp)
  80061a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80061e:	7f e4                	jg     800604 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800620:	eb 34                	jmp    800656 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800622:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800626:	74 1c                	je     800644 <vprintfmt+0x207>
  800628:	83 fb 1f             	cmp    $0x1f,%ebx
  80062b:	7e 05                	jle    800632 <vprintfmt+0x1f5>
  80062d:	83 fb 7e             	cmp    $0x7e,%ebx
  800630:	7e 12                	jle    800644 <vprintfmt+0x207>
					putch('?', putdat);
  800632:	83 ec 08             	sub    $0x8,%esp
  800635:	ff 75 0c             	pushl  0xc(%ebp)
  800638:	6a 3f                	push   $0x3f
  80063a:	8b 45 08             	mov    0x8(%ebp),%eax
  80063d:	ff d0                	call   *%eax
  80063f:	83 c4 10             	add    $0x10,%esp
  800642:	eb 0f                	jmp    800653 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800644:	83 ec 08             	sub    $0x8,%esp
  800647:	ff 75 0c             	pushl  0xc(%ebp)
  80064a:	53                   	push   %ebx
  80064b:	8b 45 08             	mov    0x8(%ebp),%eax
  80064e:	ff d0                	call   *%eax
  800650:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800653:	ff 4d e4             	decl   -0x1c(%ebp)
  800656:	89 f0                	mov    %esi,%eax
  800658:	8d 70 01             	lea    0x1(%eax),%esi
  80065b:	8a 00                	mov    (%eax),%al
  80065d:	0f be d8             	movsbl %al,%ebx
  800660:	85 db                	test   %ebx,%ebx
  800662:	74 24                	je     800688 <vprintfmt+0x24b>
  800664:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800668:	78 b8                	js     800622 <vprintfmt+0x1e5>
  80066a:	ff 4d e0             	decl   -0x20(%ebp)
  80066d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800671:	79 af                	jns    800622 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800673:	eb 13                	jmp    800688 <vprintfmt+0x24b>
				putch(' ', putdat);
  800675:	83 ec 08             	sub    $0x8,%esp
  800678:	ff 75 0c             	pushl  0xc(%ebp)
  80067b:	6a 20                	push   $0x20
  80067d:	8b 45 08             	mov    0x8(%ebp),%eax
  800680:	ff d0                	call   *%eax
  800682:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800685:	ff 4d e4             	decl   -0x1c(%ebp)
  800688:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80068c:	7f e7                	jg     800675 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80068e:	e9 66 01 00 00       	jmp    8007f9 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800693:	83 ec 08             	sub    $0x8,%esp
  800696:	ff 75 e8             	pushl  -0x18(%ebp)
  800699:	8d 45 14             	lea    0x14(%ebp),%eax
  80069c:	50                   	push   %eax
  80069d:	e8 3c fd ff ff       	call   8003de <getint>
  8006a2:	83 c4 10             	add    $0x10,%esp
  8006a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006a8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006b1:	85 d2                	test   %edx,%edx
  8006b3:	79 23                	jns    8006d8 <vprintfmt+0x29b>
				putch('-', putdat);
  8006b5:	83 ec 08             	sub    $0x8,%esp
  8006b8:	ff 75 0c             	pushl  0xc(%ebp)
  8006bb:	6a 2d                	push   $0x2d
  8006bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c0:	ff d0                	call   *%eax
  8006c2:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006c8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006cb:	f7 d8                	neg    %eax
  8006cd:	83 d2 00             	adc    $0x0,%edx
  8006d0:	f7 da                	neg    %edx
  8006d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006d5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006d8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006df:	e9 bc 00 00 00       	jmp    8007a0 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006e4:	83 ec 08             	sub    $0x8,%esp
  8006e7:	ff 75 e8             	pushl  -0x18(%ebp)
  8006ea:	8d 45 14             	lea    0x14(%ebp),%eax
  8006ed:	50                   	push   %eax
  8006ee:	e8 84 fc ff ff       	call   800377 <getuint>
  8006f3:	83 c4 10             	add    $0x10,%esp
  8006f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006f9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8006fc:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800703:	e9 98 00 00 00       	jmp    8007a0 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800708:	83 ec 08             	sub    $0x8,%esp
  80070b:	ff 75 0c             	pushl  0xc(%ebp)
  80070e:	6a 58                	push   $0x58
  800710:	8b 45 08             	mov    0x8(%ebp),%eax
  800713:	ff d0                	call   *%eax
  800715:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800718:	83 ec 08             	sub    $0x8,%esp
  80071b:	ff 75 0c             	pushl  0xc(%ebp)
  80071e:	6a 58                	push   $0x58
  800720:	8b 45 08             	mov    0x8(%ebp),%eax
  800723:	ff d0                	call   *%eax
  800725:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800728:	83 ec 08             	sub    $0x8,%esp
  80072b:	ff 75 0c             	pushl  0xc(%ebp)
  80072e:	6a 58                	push   $0x58
  800730:	8b 45 08             	mov    0x8(%ebp),%eax
  800733:	ff d0                	call   *%eax
  800735:	83 c4 10             	add    $0x10,%esp
			break;
  800738:	e9 bc 00 00 00       	jmp    8007f9 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80073d:	83 ec 08             	sub    $0x8,%esp
  800740:	ff 75 0c             	pushl  0xc(%ebp)
  800743:	6a 30                	push   $0x30
  800745:	8b 45 08             	mov    0x8(%ebp),%eax
  800748:	ff d0                	call   *%eax
  80074a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80074d:	83 ec 08             	sub    $0x8,%esp
  800750:	ff 75 0c             	pushl  0xc(%ebp)
  800753:	6a 78                	push   $0x78
  800755:	8b 45 08             	mov    0x8(%ebp),%eax
  800758:	ff d0                	call   *%eax
  80075a:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80075d:	8b 45 14             	mov    0x14(%ebp),%eax
  800760:	83 c0 04             	add    $0x4,%eax
  800763:	89 45 14             	mov    %eax,0x14(%ebp)
  800766:	8b 45 14             	mov    0x14(%ebp),%eax
  800769:	83 e8 04             	sub    $0x4,%eax
  80076c:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80076e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800771:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800778:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80077f:	eb 1f                	jmp    8007a0 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800781:	83 ec 08             	sub    $0x8,%esp
  800784:	ff 75 e8             	pushl  -0x18(%ebp)
  800787:	8d 45 14             	lea    0x14(%ebp),%eax
  80078a:	50                   	push   %eax
  80078b:	e8 e7 fb ff ff       	call   800377 <getuint>
  800790:	83 c4 10             	add    $0x10,%esp
  800793:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800796:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800799:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007a0:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007a7:	83 ec 04             	sub    $0x4,%esp
  8007aa:	52                   	push   %edx
  8007ab:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007ae:	50                   	push   %eax
  8007af:	ff 75 f4             	pushl  -0xc(%ebp)
  8007b2:	ff 75 f0             	pushl  -0x10(%ebp)
  8007b5:	ff 75 0c             	pushl  0xc(%ebp)
  8007b8:	ff 75 08             	pushl  0x8(%ebp)
  8007bb:	e8 00 fb ff ff       	call   8002c0 <printnum>
  8007c0:	83 c4 20             	add    $0x20,%esp
			break;
  8007c3:	eb 34                	jmp    8007f9 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007c5:	83 ec 08             	sub    $0x8,%esp
  8007c8:	ff 75 0c             	pushl  0xc(%ebp)
  8007cb:	53                   	push   %ebx
  8007cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cf:	ff d0                	call   *%eax
  8007d1:	83 c4 10             	add    $0x10,%esp
			break;
  8007d4:	eb 23                	jmp    8007f9 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007d6:	83 ec 08             	sub    $0x8,%esp
  8007d9:	ff 75 0c             	pushl  0xc(%ebp)
  8007dc:	6a 25                	push   $0x25
  8007de:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e1:	ff d0                	call   *%eax
  8007e3:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007e6:	ff 4d 10             	decl   0x10(%ebp)
  8007e9:	eb 03                	jmp    8007ee <vprintfmt+0x3b1>
  8007eb:	ff 4d 10             	decl   0x10(%ebp)
  8007ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8007f1:	48                   	dec    %eax
  8007f2:	8a 00                	mov    (%eax),%al
  8007f4:	3c 25                	cmp    $0x25,%al
  8007f6:	75 f3                	jne    8007eb <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8007f8:	90                   	nop
		}
	}
  8007f9:	e9 47 fc ff ff       	jmp    800445 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8007fe:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8007ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800802:	5b                   	pop    %ebx
  800803:	5e                   	pop    %esi
  800804:	5d                   	pop    %ebp
  800805:	c3                   	ret    

00800806 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800806:	55                   	push   %ebp
  800807:	89 e5                	mov    %esp,%ebp
  800809:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80080c:	8d 45 10             	lea    0x10(%ebp),%eax
  80080f:	83 c0 04             	add    $0x4,%eax
  800812:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800815:	8b 45 10             	mov    0x10(%ebp),%eax
  800818:	ff 75 f4             	pushl  -0xc(%ebp)
  80081b:	50                   	push   %eax
  80081c:	ff 75 0c             	pushl  0xc(%ebp)
  80081f:	ff 75 08             	pushl  0x8(%ebp)
  800822:	e8 16 fc ff ff       	call   80043d <vprintfmt>
  800827:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80082a:	90                   	nop
  80082b:	c9                   	leave  
  80082c:	c3                   	ret    

0080082d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80082d:	55                   	push   %ebp
  80082e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800830:	8b 45 0c             	mov    0xc(%ebp),%eax
  800833:	8b 40 08             	mov    0x8(%eax),%eax
  800836:	8d 50 01             	lea    0x1(%eax),%edx
  800839:	8b 45 0c             	mov    0xc(%ebp),%eax
  80083c:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80083f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800842:	8b 10                	mov    (%eax),%edx
  800844:	8b 45 0c             	mov    0xc(%ebp),%eax
  800847:	8b 40 04             	mov    0x4(%eax),%eax
  80084a:	39 c2                	cmp    %eax,%edx
  80084c:	73 12                	jae    800860 <sprintputch+0x33>
		*b->buf++ = ch;
  80084e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800851:	8b 00                	mov    (%eax),%eax
  800853:	8d 48 01             	lea    0x1(%eax),%ecx
  800856:	8b 55 0c             	mov    0xc(%ebp),%edx
  800859:	89 0a                	mov    %ecx,(%edx)
  80085b:	8b 55 08             	mov    0x8(%ebp),%edx
  80085e:	88 10                	mov    %dl,(%eax)
}
  800860:	90                   	nop
  800861:	5d                   	pop    %ebp
  800862:	c3                   	ret    

00800863 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800863:	55                   	push   %ebp
  800864:	89 e5                	mov    %esp,%ebp
  800866:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800869:	8b 45 08             	mov    0x8(%ebp),%eax
  80086c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80086f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800872:	8d 50 ff             	lea    -0x1(%eax),%edx
  800875:	8b 45 08             	mov    0x8(%ebp),%eax
  800878:	01 d0                	add    %edx,%eax
  80087a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80087d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800884:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800888:	74 06                	je     800890 <vsnprintf+0x2d>
  80088a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80088e:	7f 07                	jg     800897 <vsnprintf+0x34>
		return -E_INVAL;
  800890:	b8 03 00 00 00       	mov    $0x3,%eax
  800895:	eb 20                	jmp    8008b7 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800897:	ff 75 14             	pushl  0x14(%ebp)
  80089a:	ff 75 10             	pushl  0x10(%ebp)
  80089d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008a0:	50                   	push   %eax
  8008a1:	68 2d 08 80 00       	push   $0x80082d
  8008a6:	e8 92 fb ff ff       	call   80043d <vprintfmt>
  8008ab:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008b1:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008b7:	c9                   	leave  
  8008b8:	c3                   	ret    

008008b9 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008b9:	55                   	push   %ebp
  8008ba:	89 e5                	mov    %esp,%ebp
  8008bc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008bf:	8d 45 10             	lea    0x10(%ebp),%eax
  8008c2:	83 c0 04             	add    $0x4,%eax
  8008c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8008cb:	ff 75 f4             	pushl  -0xc(%ebp)
  8008ce:	50                   	push   %eax
  8008cf:	ff 75 0c             	pushl  0xc(%ebp)
  8008d2:	ff 75 08             	pushl  0x8(%ebp)
  8008d5:	e8 89 ff ff ff       	call   800863 <vsnprintf>
  8008da:	83 c4 10             	add    $0x10,%esp
  8008dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008e3:	c9                   	leave  
  8008e4:	c3                   	ret    

008008e5 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008e5:	55                   	push   %ebp
  8008e6:	89 e5                	mov    %esp,%ebp
  8008e8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8008eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008f2:	eb 06                	jmp    8008fa <strlen+0x15>
		n++;
  8008f4:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8008f7:	ff 45 08             	incl   0x8(%ebp)
  8008fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fd:	8a 00                	mov    (%eax),%al
  8008ff:	84 c0                	test   %al,%al
  800901:	75 f1                	jne    8008f4 <strlen+0xf>
		n++;
	return n;
  800903:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800906:	c9                   	leave  
  800907:	c3                   	ret    

00800908 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800908:	55                   	push   %ebp
  800909:	89 e5                	mov    %esp,%ebp
  80090b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80090e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800915:	eb 09                	jmp    800920 <strnlen+0x18>
		n++;
  800917:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80091a:	ff 45 08             	incl   0x8(%ebp)
  80091d:	ff 4d 0c             	decl   0xc(%ebp)
  800920:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800924:	74 09                	je     80092f <strnlen+0x27>
  800926:	8b 45 08             	mov    0x8(%ebp),%eax
  800929:	8a 00                	mov    (%eax),%al
  80092b:	84 c0                	test   %al,%al
  80092d:	75 e8                	jne    800917 <strnlen+0xf>
		n++;
	return n;
  80092f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800932:	c9                   	leave  
  800933:	c3                   	ret    

00800934 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800934:	55                   	push   %ebp
  800935:	89 e5                	mov    %esp,%ebp
  800937:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80093a:	8b 45 08             	mov    0x8(%ebp),%eax
  80093d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800940:	90                   	nop
  800941:	8b 45 08             	mov    0x8(%ebp),%eax
  800944:	8d 50 01             	lea    0x1(%eax),%edx
  800947:	89 55 08             	mov    %edx,0x8(%ebp)
  80094a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80094d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800950:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800953:	8a 12                	mov    (%edx),%dl
  800955:	88 10                	mov    %dl,(%eax)
  800957:	8a 00                	mov    (%eax),%al
  800959:	84 c0                	test   %al,%al
  80095b:	75 e4                	jne    800941 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80095d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800960:	c9                   	leave  
  800961:	c3                   	ret    

00800962 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800962:	55                   	push   %ebp
  800963:	89 e5                	mov    %esp,%ebp
  800965:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800968:	8b 45 08             	mov    0x8(%ebp),%eax
  80096b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80096e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800975:	eb 1f                	jmp    800996 <strncpy+0x34>
		*dst++ = *src;
  800977:	8b 45 08             	mov    0x8(%ebp),%eax
  80097a:	8d 50 01             	lea    0x1(%eax),%edx
  80097d:	89 55 08             	mov    %edx,0x8(%ebp)
  800980:	8b 55 0c             	mov    0xc(%ebp),%edx
  800983:	8a 12                	mov    (%edx),%dl
  800985:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800987:	8b 45 0c             	mov    0xc(%ebp),%eax
  80098a:	8a 00                	mov    (%eax),%al
  80098c:	84 c0                	test   %al,%al
  80098e:	74 03                	je     800993 <strncpy+0x31>
			src++;
  800990:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800993:	ff 45 fc             	incl   -0x4(%ebp)
  800996:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800999:	3b 45 10             	cmp    0x10(%ebp),%eax
  80099c:	72 d9                	jb     800977 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80099e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009a1:	c9                   	leave  
  8009a2:	c3                   	ret    

008009a3 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009a3:	55                   	push   %ebp
  8009a4:	89 e5                	mov    %esp,%ebp
  8009a6:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009af:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009b3:	74 30                	je     8009e5 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009b5:	eb 16                	jmp    8009cd <strlcpy+0x2a>
			*dst++ = *src++;
  8009b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ba:	8d 50 01             	lea    0x1(%eax),%edx
  8009bd:	89 55 08             	mov    %edx,0x8(%ebp)
  8009c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009c3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009c6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009c9:	8a 12                	mov    (%edx),%dl
  8009cb:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009cd:	ff 4d 10             	decl   0x10(%ebp)
  8009d0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009d4:	74 09                	je     8009df <strlcpy+0x3c>
  8009d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d9:	8a 00                	mov    (%eax),%al
  8009db:	84 c0                	test   %al,%al
  8009dd:	75 d8                	jne    8009b7 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009df:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e2:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009e5:	8b 55 08             	mov    0x8(%ebp),%edx
  8009e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009eb:	29 c2                	sub    %eax,%edx
  8009ed:	89 d0                	mov    %edx,%eax
}
  8009ef:	c9                   	leave  
  8009f0:	c3                   	ret    

008009f1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8009f1:	55                   	push   %ebp
  8009f2:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8009f4:	eb 06                	jmp    8009fc <strcmp+0xb>
		p++, q++;
  8009f6:	ff 45 08             	incl   0x8(%ebp)
  8009f9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8009fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ff:	8a 00                	mov    (%eax),%al
  800a01:	84 c0                	test   %al,%al
  800a03:	74 0e                	je     800a13 <strcmp+0x22>
  800a05:	8b 45 08             	mov    0x8(%ebp),%eax
  800a08:	8a 10                	mov    (%eax),%dl
  800a0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a0d:	8a 00                	mov    (%eax),%al
  800a0f:	38 c2                	cmp    %al,%dl
  800a11:	74 e3                	je     8009f6 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a13:	8b 45 08             	mov    0x8(%ebp),%eax
  800a16:	8a 00                	mov    (%eax),%al
  800a18:	0f b6 d0             	movzbl %al,%edx
  800a1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a1e:	8a 00                	mov    (%eax),%al
  800a20:	0f b6 c0             	movzbl %al,%eax
  800a23:	29 c2                	sub    %eax,%edx
  800a25:	89 d0                	mov    %edx,%eax
}
  800a27:	5d                   	pop    %ebp
  800a28:	c3                   	ret    

00800a29 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a29:	55                   	push   %ebp
  800a2a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a2c:	eb 09                	jmp    800a37 <strncmp+0xe>
		n--, p++, q++;
  800a2e:	ff 4d 10             	decl   0x10(%ebp)
  800a31:	ff 45 08             	incl   0x8(%ebp)
  800a34:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a37:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a3b:	74 17                	je     800a54 <strncmp+0x2b>
  800a3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a40:	8a 00                	mov    (%eax),%al
  800a42:	84 c0                	test   %al,%al
  800a44:	74 0e                	je     800a54 <strncmp+0x2b>
  800a46:	8b 45 08             	mov    0x8(%ebp),%eax
  800a49:	8a 10                	mov    (%eax),%dl
  800a4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4e:	8a 00                	mov    (%eax),%al
  800a50:	38 c2                	cmp    %al,%dl
  800a52:	74 da                	je     800a2e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a54:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a58:	75 07                	jne    800a61 <strncmp+0x38>
		return 0;
  800a5a:	b8 00 00 00 00       	mov    $0x0,%eax
  800a5f:	eb 14                	jmp    800a75 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a61:	8b 45 08             	mov    0x8(%ebp),%eax
  800a64:	8a 00                	mov    (%eax),%al
  800a66:	0f b6 d0             	movzbl %al,%edx
  800a69:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6c:	8a 00                	mov    (%eax),%al
  800a6e:	0f b6 c0             	movzbl %al,%eax
  800a71:	29 c2                	sub    %eax,%edx
  800a73:	89 d0                	mov    %edx,%eax
}
  800a75:	5d                   	pop    %ebp
  800a76:	c3                   	ret    

00800a77 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a77:	55                   	push   %ebp
  800a78:	89 e5                	mov    %esp,%ebp
  800a7a:	83 ec 04             	sub    $0x4,%esp
  800a7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a80:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a83:	eb 12                	jmp    800a97 <strchr+0x20>
		if (*s == c)
  800a85:	8b 45 08             	mov    0x8(%ebp),%eax
  800a88:	8a 00                	mov    (%eax),%al
  800a8a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a8d:	75 05                	jne    800a94 <strchr+0x1d>
			return (char *) s;
  800a8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a92:	eb 11                	jmp    800aa5 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800a94:	ff 45 08             	incl   0x8(%ebp)
  800a97:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9a:	8a 00                	mov    (%eax),%al
  800a9c:	84 c0                	test   %al,%al
  800a9e:	75 e5                	jne    800a85 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800aa0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800aa5:	c9                   	leave  
  800aa6:	c3                   	ret    

00800aa7 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800aa7:	55                   	push   %ebp
  800aa8:	89 e5                	mov    %esp,%ebp
  800aaa:	83 ec 04             	sub    $0x4,%esp
  800aad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ab3:	eb 0d                	jmp    800ac2 <strfind+0x1b>
		if (*s == c)
  800ab5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab8:	8a 00                	mov    (%eax),%al
  800aba:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800abd:	74 0e                	je     800acd <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800abf:	ff 45 08             	incl   0x8(%ebp)
  800ac2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac5:	8a 00                	mov    (%eax),%al
  800ac7:	84 c0                	test   %al,%al
  800ac9:	75 ea                	jne    800ab5 <strfind+0xe>
  800acb:	eb 01                	jmp    800ace <strfind+0x27>
		if (*s == c)
			break;
  800acd:	90                   	nop
	return (char *) s;
  800ace:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ad1:	c9                   	leave  
  800ad2:	c3                   	ret    

00800ad3 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ad3:	55                   	push   %ebp
  800ad4:	89 e5                	mov    %esp,%ebp
  800ad6:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ad9:	8b 45 08             	mov    0x8(%ebp),%eax
  800adc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800adf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ae2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ae5:	eb 0e                	jmp    800af5 <memset+0x22>
		*p++ = c;
  800ae7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800aea:	8d 50 01             	lea    0x1(%eax),%edx
  800aed:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800af0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800af3:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800af5:	ff 4d f8             	decl   -0x8(%ebp)
  800af8:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800afc:	79 e9                	jns    800ae7 <memset+0x14>
		*p++ = c;

	return v;
  800afe:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b01:	c9                   	leave  
  800b02:	c3                   	ret    

00800b03 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b03:	55                   	push   %ebp
  800b04:	89 e5                	mov    %esp,%ebp
  800b06:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b12:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b15:	eb 16                	jmp    800b2d <memcpy+0x2a>
		*d++ = *s++;
  800b17:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b1a:	8d 50 01             	lea    0x1(%eax),%edx
  800b1d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b20:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b23:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b26:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b29:	8a 12                	mov    (%edx),%dl
  800b2b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b30:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b33:	89 55 10             	mov    %edx,0x10(%ebp)
  800b36:	85 c0                	test   %eax,%eax
  800b38:	75 dd                	jne    800b17 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b3a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b3d:	c9                   	leave  
  800b3e:	c3                   	ret    

00800b3f <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b3f:	55                   	push   %ebp
  800b40:	89 e5                	mov    %esp,%ebp
  800b42:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b48:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b51:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b54:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b57:	73 50                	jae    800ba9 <memmove+0x6a>
  800b59:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b5c:	8b 45 10             	mov    0x10(%ebp),%eax
  800b5f:	01 d0                	add    %edx,%eax
  800b61:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b64:	76 43                	jbe    800ba9 <memmove+0x6a>
		s += n;
  800b66:	8b 45 10             	mov    0x10(%ebp),%eax
  800b69:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b6c:	8b 45 10             	mov    0x10(%ebp),%eax
  800b6f:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b72:	eb 10                	jmp    800b84 <memmove+0x45>
			*--d = *--s;
  800b74:	ff 4d f8             	decl   -0x8(%ebp)
  800b77:	ff 4d fc             	decl   -0x4(%ebp)
  800b7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b7d:	8a 10                	mov    (%eax),%dl
  800b7f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b82:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b84:	8b 45 10             	mov    0x10(%ebp),%eax
  800b87:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b8a:	89 55 10             	mov    %edx,0x10(%ebp)
  800b8d:	85 c0                	test   %eax,%eax
  800b8f:	75 e3                	jne    800b74 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800b91:	eb 23                	jmp    800bb6 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800b93:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b96:	8d 50 01             	lea    0x1(%eax),%edx
  800b99:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b9c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b9f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ba2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ba5:	8a 12                	mov    (%edx),%dl
  800ba7:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ba9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bac:	8d 50 ff             	lea    -0x1(%eax),%edx
  800baf:	89 55 10             	mov    %edx,0x10(%ebp)
  800bb2:	85 c0                	test   %eax,%eax
  800bb4:	75 dd                	jne    800b93 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bb6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bb9:	c9                   	leave  
  800bba:	c3                   	ret    

00800bbb <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bbb:	55                   	push   %ebp
  800bbc:	89 e5                	mov    %esp,%ebp
  800bbe:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bc7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bca:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bcd:	eb 2a                	jmp    800bf9 <memcmp+0x3e>
		if (*s1 != *s2)
  800bcf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bd2:	8a 10                	mov    (%eax),%dl
  800bd4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bd7:	8a 00                	mov    (%eax),%al
  800bd9:	38 c2                	cmp    %al,%dl
  800bdb:	74 16                	je     800bf3 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bdd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800be0:	8a 00                	mov    (%eax),%al
  800be2:	0f b6 d0             	movzbl %al,%edx
  800be5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800be8:	8a 00                	mov    (%eax),%al
  800bea:	0f b6 c0             	movzbl %al,%eax
  800bed:	29 c2                	sub    %eax,%edx
  800bef:	89 d0                	mov    %edx,%eax
  800bf1:	eb 18                	jmp    800c0b <memcmp+0x50>
		s1++, s2++;
  800bf3:	ff 45 fc             	incl   -0x4(%ebp)
  800bf6:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800bf9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bfc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bff:	89 55 10             	mov    %edx,0x10(%ebp)
  800c02:	85 c0                	test   %eax,%eax
  800c04:	75 c9                	jne    800bcf <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c06:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c0b:	c9                   	leave  
  800c0c:	c3                   	ret    

00800c0d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c0d:	55                   	push   %ebp
  800c0e:	89 e5                	mov    %esp,%ebp
  800c10:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c13:	8b 55 08             	mov    0x8(%ebp),%edx
  800c16:	8b 45 10             	mov    0x10(%ebp),%eax
  800c19:	01 d0                	add    %edx,%eax
  800c1b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c1e:	eb 15                	jmp    800c35 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c20:	8b 45 08             	mov    0x8(%ebp),%eax
  800c23:	8a 00                	mov    (%eax),%al
  800c25:	0f b6 d0             	movzbl %al,%edx
  800c28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c2b:	0f b6 c0             	movzbl %al,%eax
  800c2e:	39 c2                	cmp    %eax,%edx
  800c30:	74 0d                	je     800c3f <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c32:	ff 45 08             	incl   0x8(%ebp)
  800c35:	8b 45 08             	mov    0x8(%ebp),%eax
  800c38:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c3b:	72 e3                	jb     800c20 <memfind+0x13>
  800c3d:	eb 01                	jmp    800c40 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c3f:	90                   	nop
	return (void *) s;
  800c40:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c43:	c9                   	leave  
  800c44:	c3                   	ret    

00800c45 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c45:	55                   	push   %ebp
  800c46:	89 e5                	mov    %esp,%ebp
  800c48:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c4b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c52:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c59:	eb 03                	jmp    800c5e <strtol+0x19>
		s++;
  800c5b:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c61:	8a 00                	mov    (%eax),%al
  800c63:	3c 20                	cmp    $0x20,%al
  800c65:	74 f4                	je     800c5b <strtol+0x16>
  800c67:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6a:	8a 00                	mov    (%eax),%al
  800c6c:	3c 09                	cmp    $0x9,%al
  800c6e:	74 eb                	je     800c5b <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c70:	8b 45 08             	mov    0x8(%ebp),%eax
  800c73:	8a 00                	mov    (%eax),%al
  800c75:	3c 2b                	cmp    $0x2b,%al
  800c77:	75 05                	jne    800c7e <strtol+0x39>
		s++;
  800c79:	ff 45 08             	incl   0x8(%ebp)
  800c7c:	eb 13                	jmp    800c91 <strtol+0x4c>
	else if (*s == '-')
  800c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c81:	8a 00                	mov    (%eax),%al
  800c83:	3c 2d                	cmp    $0x2d,%al
  800c85:	75 0a                	jne    800c91 <strtol+0x4c>
		s++, neg = 1;
  800c87:	ff 45 08             	incl   0x8(%ebp)
  800c8a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800c91:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c95:	74 06                	je     800c9d <strtol+0x58>
  800c97:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800c9b:	75 20                	jne    800cbd <strtol+0x78>
  800c9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca0:	8a 00                	mov    (%eax),%al
  800ca2:	3c 30                	cmp    $0x30,%al
  800ca4:	75 17                	jne    800cbd <strtol+0x78>
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	40                   	inc    %eax
  800caa:	8a 00                	mov    (%eax),%al
  800cac:	3c 78                	cmp    $0x78,%al
  800cae:	75 0d                	jne    800cbd <strtol+0x78>
		s += 2, base = 16;
  800cb0:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cb4:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cbb:	eb 28                	jmp    800ce5 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800cbd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc1:	75 15                	jne    800cd8 <strtol+0x93>
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	8a 00                	mov    (%eax),%al
  800cc8:	3c 30                	cmp    $0x30,%al
  800cca:	75 0c                	jne    800cd8 <strtol+0x93>
		s++, base = 8;
  800ccc:	ff 45 08             	incl   0x8(%ebp)
  800ccf:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cd6:	eb 0d                	jmp    800ce5 <strtol+0xa0>
	else if (base == 0)
  800cd8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cdc:	75 07                	jne    800ce5 <strtol+0xa0>
		base = 10;
  800cde:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce8:	8a 00                	mov    (%eax),%al
  800cea:	3c 2f                	cmp    $0x2f,%al
  800cec:	7e 19                	jle    800d07 <strtol+0xc2>
  800cee:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf1:	8a 00                	mov    (%eax),%al
  800cf3:	3c 39                	cmp    $0x39,%al
  800cf5:	7f 10                	jg     800d07 <strtol+0xc2>
			dig = *s - '0';
  800cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfa:	8a 00                	mov    (%eax),%al
  800cfc:	0f be c0             	movsbl %al,%eax
  800cff:	83 e8 30             	sub    $0x30,%eax
  800d02:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d05:	eb 42                	jmp    800d49 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0a:	8a 00                	mov    (%eax),%al
  800d0c:	3c 60                	cmp    $0x60,%al
  800d0e:	7e 19                	jle    800d29 <strtol+0xe4>
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	8a 00                	mov    (%eax),%al
  800d15:	3c 7a                	cmp    $0x7a,%al
  800d17:	7f 10                	jg     800d29 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d19:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1c:	8a 00                	mov    (%eax),%al
  800d1e:	0f be c0             	movsbl %al,%eax
  800d21:	83 e8 57             	sub    $0x57,%eax
  800d24:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d27:	eb 20                	jmp    800d49 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d29:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2c:	8a 00                	mov    (%eax),%al
  800d2e:	3c 40                	cmp    $0x40,%al
  800d30:	7e 39                	jle    800d6b <strtol+0x126>
  800d32:	8b 45 08             	mov    0x8(%ebp),%eax
  800d35:	8a 00                	mov    (%eax),%al
  800d37:	3c 5a                	cmp    $0x5a,%al
  800d39:	7f 30                	jg     800d6b <strtol+0x126>
			dig = *s - 'A' + 10;
  800d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3e:	8a 00                	mov    (%eax),%al
  800d40:	0f be c0             	movsbl %al,%eax
  800d43:	83 e8 37             	sub    $0x37,%eax
  800d46:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d49:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d4c:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d4f:	7d 19                	jge    800d6a <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d51:	ff 45 08             	incl   0x8(%ebp)
  800d54:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d57:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d5b:	89 c2                	mov    %eax,%edx
  800d5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d60:	01 d0                	add    %edx,%eax
  800d62:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d65:	e9 7b ff ff ff       	jmp    800ce5 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d6a:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d6b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d6f:	74 08                	je     800d79 <strtol+0x134>
		*endptr = (char *) s;
  800d71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d74:	8b 55 08             	mov    0x8(%ebp),%edx
  800d77:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d79:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d7d:	74 07                	je     800d86 <strtol+0x141>
  800d7f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d82:	f7 d8                	neg    %eax
  800d84:	eb 03                	jmp    800d89 <strtol+0x144>
  800d86:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d89:	c9                   	leave  
  800d8a:	c3                   	ret    

00800d8b <ltostr>:

void
ltostr(long value, char *str)
{
  800d8b:	55                   	push   %ebp
  800d8c:	89 e5                	mov    %esp,%ebp
  800d8e:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800d91:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800d98:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800d9f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800da3:	79 13                	jns    800db8 <ltostr+0x2d>
	{
		neg = 1;
  800da5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800dac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800daf:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800db2:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800db5:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800db8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbb:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800dc0:	99                   	cltd   
  800dc1:	f7 f9                	idiv   %ecx
  800dc3:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800dc6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dc9:	8d 50 01             	lea    0x1(%eax),%edx
  800dcc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dcf:	89 c2                	mov    %eax,%edx
  800dd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd4:	01 d0                	add    %edx,%eax
  800dd6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dd9:	83 c2 30             	add    $0x30,%edx
  800ddc:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800dde:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800de1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800de6:	f7 e9                	imul   %ecx
  800de8:	c1 fa 02             	sar    $0x2,%edx
  800deb:	89 c8                	mov    %ecx,%eax
  800ded:	c1 f8 1f             	sar    $0x1f,%eax
  800df0:	29 c2                	sub    %eax,%edx
  800df2:	89 d0                	mov    %edx,%eax
  800df4:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800df7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dfa:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dff:	f7 e9                	imul   %ecx
  800e01:	c1 fa 02             	sar    $0x2,%edx
  800e04:	89 c8                	mov    %ecx,%eax
  800e06:	c1 f8 1f             	sar    $0x1f,%eax
  800e09:	29 c2                	sub    %eax,%edx
  800e0b:	89 d0                	mov    %edx,%eax
  800e0d:	c1 e0 02             	shl    $0x2,%eax
  800e10:	01 d0                	add    %edx,%eax
  800e12:	01 c0                	add    %eax,%eax
  800e14:	29 c1                	sub    %eax,%ecx
  800e16:	89 ca                	mov    %ecx,%edx
  800e18:	85 d2                	test   %edx,%edx
  800e1a:	75 9c                	jne    800db8 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e1c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e23:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e26:	48                   	dec    %eax
  800e27:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e2a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e2e:	74 3d                	je     800e6d <ltostr+0xe2>
		start = 1 ;
  800e30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e37:	eb 34                	jmp    800e6d <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e39:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3f:	01 d0                	add    %edx,%eax
  800e41:	8a 00                	mov    (%eax),%al
  800e43:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e46:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4c:	01 c2                	add    %eax,%edx
  800e4e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e54:	01 c8                	add    %ecx,%eax
  800e56:	8a 00                	mov    (%eax),%al
  800e58:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e5a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e60:	01 c2                	add    %eax,%edx
  800e62:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e65:	88 02                	mov    %al,(%edx)
		start++ ;
  800e67:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e6a:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e70:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e73:	7c c4                	jl     800e39 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e75:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7b:	01 d0                	add    %edx,%eax
  800e7d:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e80:	90                   	nop
  800e81:	c9                   	leave  
  800e82:	c3                   	ret    

00800e83 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e83:	55                   	push   %ebp
  800e84:	89 e5                	mov    %esp,%ebp
  800e86:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e89:	ff 75 08             	pushl  0x8(%ebp)
  800e8c:	e8 54 fa ff ff       	call   8008e5 <strlen>
  800e91:	83 c4 04             	add    $0x4,%esp
  800e94:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800e97:	ff 75 0c             	pushl  0xc(%ebp)
  800e9a:	e8 46 fa ff ff       	call   8008e5 <strlen>
  800e9f:	83 c4 04             	add    $0x4,%esp
  800ea2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ea5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800eac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800eb3:	eb 17                	jmp    800ecc <strcconcat+0x49>
		final[s] = str1[s] ;
  800eb5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eb8:	8b 45 10             	mov    0x10(%ebp),%eax
  800ebb:	01 c2                	add    %eax,%edx
  800ebd:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ec0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec3:	01 c8                	add    %ecx,%eax
  800ec5:	8a 00                	mov    (%eax),%al
  800ec7:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800ec9:	ff 45 fc             	incl   -0x4(%ebp)
  800ecc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ecf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ed2:	7c e1                	jl     800eb5 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ed4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800edb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800ee2:	eb 1f                	jmp    800f03 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800ee4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ee7:	8d 50 01             	lea    0x1(%eax),%edx
  800eea:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800eed:	89 c2                	mov    %eax,%edx
  800eef:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef2:	01 c2                	add    %eax,%edx
  800ef4:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800ef7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efa:	01 c8                	add    %ecx,%eax
  800efc:	8a 00                	mov    (%eax),%al
  800efe:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f00:	ff 45 f8             	incl   -0x8(%ebp)
  800f03:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f06:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f09:	7c d9                	jl     800ee4 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f0b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f0e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f11:	01 d0                	add    %edx,%eax
  800f13:	c6 00 00             	movb   $0x0,(%eax)
}
  800f16:	90                   	nop
  800f17:	c9                   	leave  
  800f18:	c3                   	ret    

00800f19 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f19:	55                   	push   %ebp
  800f1a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f1c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f1f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f25:	8b 45 14             	mov    0x14(%ebp),%eax
  800f28:	8b 00                	mov    (%eax),%eax
  800f2a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f31:	8b 45 10             	mov    0x10(%ebp),%eax
  800f34:	01 d0                	add    %edx,%eax
  800f36:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f3c:	eb 0c                	jmp    800f4a <strsplit+0x31>
			*string++ = 0;
  800f3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f41:	8d 50 01             	lea    0x1(%eax),%edx
  800f44:	89 55 08             	mov    %edx,0x8(%ebp)
  800f47:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4d:	8a 00                	mov    (%eax),%al
  800f4f:	84 c0                	test   %al,%al
  800f51:	74 18                	je     800f6b <strsplit+0x52>
  800f53:	8b 45 08             	mov    0x8(%ebp),%eax
  800f56:	8a 00                	mov    (%eax),%al
  800f58:	0f be c0             	movsbl %al,%eax
  800f5b:	50                   	push   %eax
  800f5c:	ff 75 0c             	pushl  0xc(%ebp)
  800f5f:	e8 13 fb ff ff       	call   800a77 <strchr>
  800f64:	83 c4 08             	add    $0x8,%esp
  800f67:	85 c0                	test   %eax,%eax
  800f69:	75 d3                	jne    800f3e <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6e:	8a 00                	mov    (%eax),%al
  800f70:	84 c0                	test   %al,%al
  800f72:	74 5a                	je     800fce <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800f74:	8b 45 14             	mov    0x14(%ebp),%eax
  800f77:	8b 00                	mov    (%eax),%eax
  800f79:	83 f8 0f             	cmp    $0xf,%eax
  800f7c:	75 07                	jne    800f85 <strsplit+0x6c>
		{
			return 0;
  800f7e:	b8 00 00 00 00       	mov    $0x0,%eax
  800f83:	eb 66                	jmp    800feb <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f85:	8b 45 14             	mov    0x14(%ebp),%eax
  800f88:	8b 00                	mov    (%eax),%eax
  800f8a:	8d 48 01             	lea    0x1(%eax),%ecx
  800f8d:	8b 55 14             	mov    0x14(%ebp),%edx
  800f90:	89 0a                	mov    %ecx,(%edx)
  800f92:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f99:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9c:	01 c2                	add    %eax,%edx
  800f9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa1:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fa3:	eb 03                	jmp    800fa8 <strsplit+0x8f>
			string++;
  800fa5:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fab:	8a 00                	mov    (%eax),%al
  800fad:	84 c0                	test   %al,%al
  800faf:	74 8b                	je     800f3c <strsplit+0x23>
  800fb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb4:	8a 00                	mov    (%eax),%al
  800fb6:	0f be c0             	movsbl %al,%eax
  800fb9:	50                   	push   %eax
  800fba:	ff 75 0c             	pushl  0xc(%ebp)
  800fbd:	e8 b5 fa ff ff       	call   800a77 <strchr>
  800fc2:	83 c4 08             	add    $0x8,%esp
  800fc5:	85 c0                	test   %eax,%eax
  800fc7:	74 dc                	je     800fa5 <strsplit+0x8c>
			string++;
	}
  800fc9:	e9 6e ff ff ff       	jmp    800f3c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800fce:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fcf:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd2:	8b 00                	mov    (%eax),%eax
  800fd4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fdb:	8b 45 10             	mov    0x10(%ebp),%eax
  800fde:	01 d0                	add    %edx,%eax
  800fe0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800fe6:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800feb:	c9                   	leave  
  800fec:	c3                   	ret    

00800fed <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  800fed:	55                   	push   %ebp
  800fee:	89 e5                	mov    %esp,%ebp
  800ff0:	57                   	push   %edi
  800ff1:	56                   	push   %esi
  800ff2:	53                   	push   %ebx
  800ff3:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800ff6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ffc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800fff:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801002:	8b 7d 18             	mov    0x18(%ebp),%edi
  801005:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801008:	cd 30                	int    $0x30
  80100a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80100d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801010:	83 c4 10             	add    $0x10,%esp
  801013:	5b                   	pop    %ebx
  801014:	5e                   	pop    %esi
  801015:	5f                   	pop    %edi
  801016:	5d                   	pop    %ebp
  801017:	c3                   	ret    

00801018 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801018:	55                   	push   %ebp
  801019:	89 e5                	mov    %esp,%ebp
  80101b:	83 ec 04             	sub    $0x4,%esp
  80101e:	8b 45 10             	mov    0x10(%ebp),%eax
  801021:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801024:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801028:	8b 45 08             	mov    0x8(%ebp),%eax
  80102b:	6a 00                	push   $0x0
  80102d:	6a 00                	push   $0x0
  80102f:	52                   	push   %edx
  801030:	ff 75 0c             	pushl  0xc(%ebp)
  801033:	50                   	push   %eax
  801034:	6a 00                	push   $0x0
  801036:	e8 b2 ff ff ff       	call   800fed <syscall>
  80103b:	83 c4 18             	add    $0x18,%esp
}
  80103e:	90                   	nop
  80103f:	c9                   	leave  
  801040:	c3                   	ret    

00801041 <sys_cgetc>:

int
sys_cgetc(void)
{
  801041:	55                   	push   %ebp
  801042:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801044:	6a 00                	push   $0x0
  801046:	6a 00                	push   $0x0
  801048:	6a 00                	push   $0x0
  80104a:	6a 00                	push   $0x0
  80104c:	6a 00                	push   $0x0
  80104e:	6a 01                	push   $0x1
  801050:	e8 98 ff ff ff       	call   800fed <syscall>
  801055:	83 c4 18             	add    $0x18,%esp
}
  801058:	c9                   	leave  
  801059:	c3                   	ret    

0080105a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80105a:	55                   	push   %ebp
  80105b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80105d:	8b 45 08             	mov    0x8(%ebp),%eax
  801060:	6a 00                	push   $0x0
  801062:	6a 00                	push   $0x0
  801064:	6a 00                	push   $0x0
  801066:	6a 00                	push   $0x0
  801068:	50                   	push   %eax
  801069:	6a 05                	push   $0x5
  80106b:	e8 7d ff ff ff       	call   800fed <syscall>
  801070:	83 c4 18             	add    $0x18,%esp
}
  801073:	c9                   	leave  
  801074:	c3                   	ret    

00801075 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801075:	55                   	push   %ebp
  801076:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801078:	6a 00                	push   $0x0
  80107a:	6a 00                	push   $0x0
  80107c:	6a 00                	push   $0x0
  80107e:	6a 00                	push   $0x0
  801080:	6a 00                	push   $0x0
  801082:	6a 02                	push   $0x2
  801084:	e8 64 ff ff ff       	call   800fed <syscall>
  801089:	83 c4 18             	add    $0x18,%esp
}
  80108c:	c9                   	leave  
  80108d:	c3                   	ret    

0080108e <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80108e:	55                   	push   %ebp
  80108f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801091:	6a 00                	push   $0x0
  801093:	6a 00                	push   $0x0
  801095:	6a 00                	push   $0x0
  801097:	6a 00                	push   $0x0
  801099:	6a 00                	push   $0x0
  80109b:	6a 03                	push   $0x3
  80109d:	e8 4b ff ff ff       	call   800fed <syscall>
  8010a2:	83 c4 18             	add    $0x18,%esp
}
  8010a5:	c9                   	leave  
  8010a6:	c3                   	ret    

008010a7 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010a7:	55                   	push   %ebp
  8010a8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010aa:	6a 00                	push   $0x0
  8010ac:	6a 00                	push   $0x0
  8010ae:	6a 00                	push   $0x0
  8010b0:	6a 00                	push   $0x0
  8010b2:	6a 00                	push   $0x0
  8010b4:	6a 04                	push   $0x4
  8010b6:	e8 32 ff ff ff       	call   800fed <syscall>
  8010bb:	83 c4 18             	add    $0x18,%esp
}
  8010be:	c9                   	leave  
  8010bf:	c3                   	ret    

008010c0 <sys_env_exit>:


void sys_env_exit(void)
{
  8010c0:	55                   	push   %ebp
  8010c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010c3:	6a 00                	push   $0x0
  8010c5:	6a 00                	push   $0x0
  8010c7:	6a 00                	push   $0x0
  8010c9:	6a 00                	push   $0x0
  8010cb:	6a 00                	push   $0x0
  8010cd:	6a 06                	push   $0x6
  8010cf:	e8 19 ff ff ff       	call   800fed <syscall>
  8010d4:	83 c4 18             	add    $0x18,%esp
}
  8010d7:	90                   	nop
  8010d8:	c9                   	leave  
  8010d9:	c3                   	ret    

008010da <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010da:	55                   	push   %ebp
  8010db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e3:	6a 00                	push   $0x0
  8010e5:	6a 00                	push   $0x0
  8010e7:	6a 00                	push   $0x0
  8010e9:	52                   	push   %edx
  8010ea:	50                   	push   %eax
  8010eb:	6a 07                	push   $0x7
  8010ed:	e8 fb fe ff ff       	call   800fed <syscall>
  8010f2:	83 c4 18             	add    $0x18,%esp
}
  8010f5:	c9                   	leave  
  8010f6:	c3                   	ret    

008010f7 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8010f7:	55                   	push   %ebp
  8010f8:	89 e5                	mov    %esp,%ebp
  8010fa:	56                   	push   %esi
  8010fb:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8010fc:	8b 75 18             	mov    0x18(%ebp),%esi
  8010ff:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801102:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801105:	8b 55 0c             	mov    0xc(%ebp),%edx
  801108:	8b 45 08             	mov    0x8(%ebp),%eax
  80110b:	56                   	push   %esi
  80110c:	53                   	push   %ebx
  80110d:	51                   	push   %ecx
  80110e:	52                   	push   %edx
  80110f:	50                   	push   %eax
  801110:	6a 08                	push   $0x8
  801112:	e8 d6 fe ff ff       	call   800fed <syscall>
  801117:	83 c4 18             	add    $0x18,%esp
}
  80111a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80111d:	5b                   	pop    %ebx
  80111e:	5e                   	pop    %esi
  80111f:	5d                   	pop    %ebp
  801120:	c3                   	ret    

00801121 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801121:	55                   	push   %ebp
  801122:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801124:	8b 55 0c             	mov    0xc(%ebp),%edx
  801127:	8b 45 08             	mov    0x8(%ebp),%eax
  80112a:	6a 00                	push   $0x0
  80112c:	6a 00                	push   $0x0
  80112e:	6a 00                	push   $0x0
  801130:	52                   	push   %edx
  801131:	50                   	push   %eax
  801132:	6a 09                	push   $0x9
  801134:	e8 b4 fe ff ff       	call   800fed <syscall>
  801139:	83 c4 18             	add    $0x18,%esp
}
  80113c:	c9                   	leave  
  80113d:	c3                   	ret    

0080113e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80113e:	55                   	push   %ebp
  80113f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801141:	6a 00                	push   $0x0
  801143:	6a 00                	push   $0x0
  801145:	6a 00                	push   $0x0
  801147:	ff 75 0c             	pushl  0xc(%ebp)
  80114a:	ff 75 08             	pushl  0x8(%ebp)
  80114d:	6a 0a                	push   $0xa
  80114f:	e8 99 fe ff ff       	call   800fed <syscall>
  801154:	83 c4 18             	add    $0x18,%esp
}
  801157:	c9                   	leave  
  801158:	c3                   	ret    

00801159 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801159:	55                   	push   %ebp
  80115a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80115c:	6a 00                	push   $0x0
  80115e:	6a 00                	push   $0x0
  801160:	6a 00                	push   $0x0
  801162:	6a 00                	push   $0x0
  801164:	6a 00                	push   $0x0
  801166:	6a 0b                	push   $0xb
  801168:	e8 80 fe ff ff       	call   800fed <syscall>
  80116d:	83 c4 18             	add    $0x18,%esp
}
  801170:	c9                   	leave  
  801171:	c3                   	ret    

00801172 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801172:	55                   	push   %ebp
  801173:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801175:	6a 00                	push   $0x0
  801177:	6a 00                	push   $0x0
  801179:	6a 00                	push   $0x0
  80117b:	6a 00                	push   $0x0
  80117d:	6a 00                	push   $0x0
  80117f:	6a 0c                	push   $0xc
  801181:	e8 67 fe ff ff       	call   800fed <syscall>
  801186:	83 c4 18             	add    $0x18,%esp
}
  801189:	c9                   	leave  
  80118a:	c3                   	ret    

0080118b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80118b:	55                   	push   %ebp
  80118c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80118e:	6a 00                	push   $0x0
  801190:	6a 00                	push   $0x0
  801192:	6a 00                	push   $0x0
  801194:	6a 00                	push   $0x0
  801196:	6a 00                	push   $0x0
  801198:	6a 0d                	push   $0xd
  80119a:	e8 4e fe ff ff       	call   800fed <syscall>
  80119f:	83 c4 18             	add    $0x18,%esp
}
  8011a2:	c9                   	leave  
  8011a3:	c3                   	ret    

008011a4 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011a4:	55                   	push   %ebp
  8011a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011a7:	6a 00                	push   $0x0
  8011a9:	6a 00                	push   $0x0
  8011ab:	6a 00                	push   $0x0
  8011ad:	ff 75 0c             	pushl  0xc(%ebp)
  8011b0:	ff 75 08             	pushl  0x8(%ebp)
  8011b3:	6a 11                	push   $0x11
  8011b5:	e8 33 fe ff ff       	call   800fed <syscall>
  8011ba:	83 c4 18             	add    $0x18,%esp
	return;
  8011bd:	90                   	nop
}
  8011be:	c9                   	leave  
  8011bf:	c3                   	ret    

008011c0 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011c0:	55                   	push   %ebp
  8011c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011c3:	6a 00                	push   $0x0
  8011c5:	6a 00                	push   $0x0
  8011c7:	6a 00                	push   $0x0
  8011c9:	ff 75 0c             	pushl  0xc(%ebp)
  8011cc:	ff 75 08             	pushl  0x8(%ebp)
  8011cf:	6a 12                	push   $0x12
  8011d1:	e8 17 fe ff ff       	call   800fed <syscall>
  8011d6:	83 c4 18             	add    $0x18,%esp
	return ;
  8011d9:	90                   	nop
}
  8011da:	c9                   	leave  
  8011db:	c3                   	ret    

008011dc <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011dc:	55                   	push   %ebp
  8011dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011df:	6a 00                	push   $0x0
  8011e1:	6a 00                	push   $0x0
  8011e3:	6a 00                	push   $0x0
  8011e5:	6a 00                	push   $0x0
  8011e7:	6a 00                	push   $0x0
  8011e9:	6a 0e                	push   $0xe
  8011eb:	e8 fd fd ff ff       	call   800fed <syscall>
  8011f0:	83 c4 18             	add    $0x18,%esp
}
  8011f3:	c9                   	leave  
  8011f4:	c3                   	ret    

008011f5 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8011f5:	55                   	push   %ebp
  8011f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8011f8:	6a 00                	push   $0x0
  8011fa:	6a 00                	push   $0x0
  8011fc:	6a 00                	push   $0x0
  8011fe:	6a 00                	push   $0x0
  801200:	ff 75 08             	pushl  0x8(%ebp)
  801203:	6a 0f                	push   $0xf
  801205:	e8 e3 fd ff ff       	call   800fed <syscall>
  80120a:	83 c4 18             	add    $0x18,%esp
}
  80120d:	c9                   	leave  
  80120e:	c3                   	ret    

0080120f <sys_scarce_memory>:

void sys_scarce_memory()
{
  80120f:	55                   	push   %ebp
  801210:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801212:	6a 00                	push   $0x0
  801214:	6a 00                	push   $0x0
  801216:	6a 00                	push   $0x0
  801218:	6a 00                	push   $0x0
  80121a:	6a 00                	push   $0x0
  80121c:	6a 10                	push   $0x10
  80121e:	e8 ca fd ff ff       	call   800fed <syscall>
  801223:	83 c4 18             	add    $0x18,%esp
}
  801226:	90                   	nop
  801227:	c9                   	leave  
  801228:	c3                   	ret    

00801229 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801229:	55                   	push   %ebp
  80122a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80122c:	6a 00                	push   $0x0
  80122e:	6a 00                	push   $0x0
  801230:	6a 00                	push   $0x0
  801232:	6a 00                	push   $0x0
  801234:	6a 00                	push   $0x0
  801236:	6a 14                	push   $0x14
  801238:	e8 b0 fd ff ff       	call   800fed <syscall>
  80123d:	83 c4 18             	add    $0x18,%esp
}
  801240:	90                   	nop
  801241:	c9                   	leave  
  801242:	c3                   	ret    

00801243 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801243:	55                   	push   %ebp
  801244:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801246:	6a 00                	push   $0x0
  801248:	6a 00                	push   $0x0
  80124a:	6a 00                	push   $0x0
  80124c:	6a 00                	push   $0x0
  80124e:	6a 00                	push   $0x0
  801250:	6a 15                	push   $0x15
  801252:	e8 96 fd ff ff       	call   800fed <syscall>
  801257:	83 c4 18             	add    $0x18,%esp
}
  80125a:	90                   	nop
  80125b:	c9                   	leave  
  80125c:	c3                   	ret    

0080125d <sys_cputc>:


void
sys_cputc(const char c)
{
  80125d:	55                   	push   %ebp
  80125e:	89 e5                	mov    %esp,%ebp
  801260:	83 ec 04             	sub    $0x4,%esp
  801263:	8b 45 08             	mov    0x8(%ebp),%eax
  801266:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801269:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80126d:	6a 00                	push   $0x0
  80126f:	6a 00                	push   $0x0
  801271:	6a 00                	push   $0x0
  801273:	6a 00                	push   $0x0
  801275:	50                   	push   %eax
  801276:	6a 16                	push   $0x16
  801278:	e8 70 fd ff ff       	call   800fed <syscall>
  80127d:	83 c4 18             	add    $0x18,%esp
}
  801280:	90                   	nop
  801281:	c9                   	leave  
  801282:	c3                   	ret    

00801283 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801283:	55                   	push   %ebp
  801284:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801286:	6a 00                	push   $0x0
  801288:	6a 00                	push   $0x0
  80128a:	6a 00                	push   $0x0
  80128c:	6a 00                	push   $0x0
  80128e:	6a 00                	push   $0x0
  801290:	6a 17                	push   $0x17
  801292:	e8 56 fd ff ff       	call   800fed <syscall>
  801297:	83 c4 18             	add    $0x18,%esp
}
  80129a:	90                   	nop
  80129b:	c9                   	leave  
  80129c:	c3                   	ret    

0080129d <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80129d:	55                   	push   %ebp
  80129e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a3:	6a 00                	push   $0x0
  8012a5:	6a 00                	push   $0x0
  8012a7:	6a 00                	push   $0x0
  8012a9:	ff 75 0c             	pushl  0xc(%ebp)
  8012ac:	50                   	push   %eax
  8012ad:	6a 18                	push   $0x18
  8012af:	e8 39 fd ff ff       	call   800fed <syscall>
  8012b4:	83 c4 18             	add    $0x18,%esp
}
  8012b7:	c9                   	leave  
  8012b8:	c3                   	ret    

008012b9 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012b9:	55                   	push   %ebp
  8012ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c2:	6a 00                	push   $0x0
  8012c4:	6a 00                	push   $0x0
  8012c6:	6a 00                	push   $0x0
  8012c8:	52                   	push   %edx
  8012c9:	50                   	push   %eax
  8012ca:	6a 1b                	push   $0x1b
  8012cc:	e8 1c fd ff ff       	call   800fed <syscall>
  8012d1:	83 c4 18             	add    $0x18,%esp
}
  8012d4:	c9                   	leave  
  8012d5:	c3                   	ret    

008012d6 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012d6:	55                   	push   %ebp
  8012d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012df:	6a 00                	push   $0x0
  8012e1:	6a 00                	push   $0x0
  8012e3:	6a 00                	push   $0x0
  8012e5:	52                   	push   %edx
  8012e6:	50                   	push   %eax
  8012e7:	6a 19                	push   $0x19
  8012e9:	e8 ff fc ff ff       	call   800fed <syscall>
  8012ee:	83 c4 18             	add    $0x18,%esp
}
  8012f1:	90                   	nop
  8012f2:	c9                   	leave  
  8012f3:	c3                   	ret    

008012f4 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012f4:	55                   	push   %ebp
  8012f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fd:	6a 00                	push   $0x0
  8012ff:	6a 00                	push   $0x0
  801301:	6a 00                	push   $0x0
  801303:	52                   	push   %edx
  801304:	50                   	push   %eax
  801305:	6a 1a                	push   $0x1a
  801307:	e8 e1 fc ff ff       	call   800fed <syscall>
  80130c:	83 c4 18             	add    $0x18,%esp
}
  80130f:	90                   	nop
  801310:	c9                   	leave  
  801311:	c3                   	ret    

00801312 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801312:	55                   	push   %ebp
  801313:	89 e5                	mov    %esp,%ebp
  801315:	83 ec 04             	sub    $0x4,%esp
  801318:	8b 45 10             	mov    0x10(%ebp),%eax
  80131b:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80131e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801321:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801325:	8b 45 08             	mov    0x8(%ebp),%eax
  801328:	6a 00                	push   $0x0
  80132a:	51                   	push   %ecx
  80132b:	52                   	push   %edx
  80132c:	ff 75 0c             	pushl  0xc(%ebp)
  80132f:	50                   	push   %eax
  801330:	6a 1c                	push   $0x1c
  801332:	e8 b6 fc ff ff       	call   800fed <syscall>
  801337:	83 c4 18             	add    $0x18,%esp
}
  80133a:	c9                   	leave  
  80133b:	c3                   	ret    

0080133c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80133c:	55                   	push   %ebp
  80133d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80133f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801342:	8b 45 08             	mov    0x8(%ebp),%eax
  801345:	6a 00                	push   $0x0
  801347:	6a 00                	push   $0x0
  801349:	6a 00                	push   $0x0
  80134b:	52                   	push   %edx
  80134c:	50                   	push   %eax
  80134d:	6a 1d                	push   $0x1d
  80134f:	e8 99 fc ff ff       	call   800fed <syscall>
  801354:	83 c4 18             	add    $0x18,%esp
}
  801357:	c9                   	leave  
  801358:	c3                   	ret    

00801359 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801359:	55                   	push   %ebp
  80135a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80135c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80135f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801362:	8b 45 08             	mov    0x8(%ebp),%eax
  801365:	6a 00                	push   $0x0
  801367:	6a 00                	push   $0x0
  801369:	51                   	push   %ecx
  80136a:	52                   	push   %edx
  80136b:	50                   	push   %eax
  80136c:	6a 1e                	push   $0x1e
  80136e:	e8 7a fc ff ff       	call   800fed <syscall>
  801373:	83 c4 18             	add    $0x18,%esp
}
  801376:	c9                   	leave  
  801377:	c3                   	ret    

00801378 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801378:	55                   	push   %ebp
  801379:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80137b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137e:	8b 45 08             	mov    0x8(%ebp),%eax
  801381:	6a 00                	push   $0x0
  801383:	6a 00                	push   $0x0
  801385:	6a 00                	push   $0x0
  801387:	52                   	push   %edx
  801388:	50                   	push   %eax
  801389:	6a 1f                	push   $0x1f
  80138b:	e8 5d fc ff ff       	call   800fed <syscall>
  801390:	83 c4 18             	add    $0x18,%esp
}
  801393:	c9                   	leave  
  801394:	c3                   	ret    

00801395 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801395:	55                   	push   %ebp
  801396:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801398:	6a 00                	push   $0x0
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	6a 00                	push   $0x0
  8013a0:	6a 00                	push   $0x0
  8013a2:	6a 20                	push   $0x20
  8013a4:	e8 44 fc ff ff       	call   800fed <syscall>
  8013a9:	83 c4 18             	add    $0x18,%esp
}
  8013ac:	c9                   	leave  
  8013ad:	c3                   	ret    

008013ae <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8013ae:	55                   	push   %ebp
  8013af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8013b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b4:	6a 00                	push   $0x0
  8013b6:	ff 75 14             	pushl  0x14(%ebp)
  8013b9:	ff 75 10             	pushl  0x10(%ebp)
  8013bc:	ff 75 0c             	pushl  0xc(%ebp)
  8013bf:	50                   	push   %eax
  8013c0:	6a 21                	push   $0x21
  8013c2:	e8 26 fc ff ff       	call   800fed <syscall>
  8013c7:	83 c4 18             	add    $0x18,%esp
}
  8013ca:	c9                   	leave  
  8013cb:	c3                   	ret    

008013cc <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8013cc:	55                   	push   %ebp
  8013cd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	50                   	push   %eax
  8013db:	6a 22                	push   $0x22
  8013dd:	e8 0b fc ff ff       	call   800fed <syscall>
  8013e2:	83 c4 18             	add    $0x18,%esp
}
  8013e5:	90                   	nop
  8013e6:	c9                   	leave  
  8013e7:	c3                   	ret    

008013e8 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013e8:	55                   	push   %ebp
  8013e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8013eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ee:	6a 00                	push   $0x0
  8013f0:	6a 00                	push   $0x0
  8013f2:	6a 00                	push   $0x0
  8013f4:	6a 00                	push   $0x0
  8013f6:	50                   	push   %eax
  8013f7:	6a 23                	push   $0x23
  8013f9:	e8 ef fb ff ff       	call   800fed <syscall>
  8013fe:	83 c4 18             	add    $0x18,%esp
}
  801401:	90                   	nop
  801402:	c9                   	leave  
  801403:	c3                   	ret    

00801404 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801404:	55                   	push   %ebp
  801405:	89 e5                	mov    %esp,%ebp
  801407:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80140a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80140d:	8d 50 04             	lea    0x4(%eax),%edx
  801410:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801413:	6a 00                	push   $0x0
  801415:	6a 00                	push   $0x0
  801417:	6a 00                	push   $0x0
  801419:	52                   	push   %edx
  80141a:	50                   	push   %eax
  80141b:	6a 24                	push   $0x24
  80141d:	e8 cb fb ff ff       	call   800fed <syscall>
  801422:	83 c4 18             	add    $0x18,%esp
	return result;
  801425:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801428:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80142b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80142e:	89 01                	mov    %eax,(%ecx)
  801430:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801433:	8b 45 08             	mov    0x8(%ebp),%eax
  801436:	c9                   	leave  
  801437:	c2 04 00             	ret    $0x4

0080143a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80143a:	55                   	push   %ebp
  80143b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80143d:	6a 00                	push   $0x0
  80143f:	6a 00                	push   $0x0
  801441:	ff 75 10             	pushl  0x10(%ebp)
  801444:	ff 75 0c             	pushl  0xc(%ebp)
  801447:	ff 75 08             	pushl  0x8(%ebp)
  80144a:	6a 13                	push   $0x13
  80144c:	e8 9c fb ff ff       	call   800fed <syscall>
  801451:	83 c4 18             	add    $0x18,%esp
	return ;
  801454:	90                   	nop
}
  801455:	c9                   	leave  
  801456:	c3                   	ret    

00801457 <sys_rcr2>:
uint32 sys_rcr2()
{
  801457:	55                   	push   %ebp
  801458:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	6a 00                	push   $0x0
  801462:	6a 00                	push   $0x0
  801464:	6a 25                	push   $0x25
  801466:	e8 82 fb ff ff       	call   800fed <syscall>
  80146b:	83 c4 18             	add    $0x18,%esp
}
  80146e:	c9                   	leave  
  80146f:	c3                   	ret    

00801470 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801470:	55                   	push   %ebp
  801471:	89 e5                	mov    %esp,%ebp
  801473:	83 ec 04             	sub    $0x4,%esp
  801476:	8b 45 08             	mov    0x8(%ebp),%eax
  801479:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80147c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801480:	6a 00                	push   $0x0
  801482:	6a 00                	push   $0x0
  801484:	6a 00                	push   $0x0
  801486:	6a 00                	push   $0x0
  801488:	50                   	push   %eax
  801489:	6a 26                	push   $0x26
  80148b:	e8 5d fb ff ff       	call   800fed <syscall>
  801490:	83 c4 18             	add    $0x18,%esp
	return ;
  801493:	90                   	nop
}
  801494:	c9                   	leave  
  801495:	c3                   	ret    

00801496 <rsttst>:
void rsttst()
{
  801496:	55                   	push   %ebp
  801497:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801499:	6a 00                	push   $0x0
  80149b:	6a 00                	push   $0x0
  80149d:	6a 00                	push   $0x0
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 00                	push   $0x0
  8014a3:	6a 28                	push   $0x28
  8014a5:	e8 43 fb ff ff       	call   800fed <syscall>
  8014aa:	83 c4 18             	add    $0x18,%esp
	return ;
  8014ad:	90                   	nop
}
  8014ae:	c9                   	leave  
  8014af:	c3                   	ret    

008014b0 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014b0:	55                   	push   %ebp
  8014b1:	89 e5                	mov    %esp,%ebp
  8014b3:	83 ec 04             	sub    $0x4,%esp
  8014b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8014b9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014bc:	8b 55 18             	mov    0x18(%ebp),%edx
  8014bf:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014c3:	52                   	push   %edx
  8014c4:	50                   	push   %eax
  8014c5:	ff 75 10             	pushl  0x10(%ebp)
  8014c8:	ff 75 0c             	pushl  0xc(%ebp)
  8014cb:	ff 75 08             	pushl  0x8(%ebp)
  8014ce:	6a 27                	push   $0x27
  8014d0:	e8 18 fb ff ff       	call   800fed <syscall>
  8014d5:	83 c4 18             	add    $0x18,%esp
	return ;
  8014d8:	90                   	nop
}
  8014d9:	c9                   	leave  
  8014da:	c3                   	ret    

008014db <chktst>:
void chktst(uint32 n)
{
  8014db:	55                   	push   %ebp
  8014dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 00                	push   $0x0
  8014e6:	ff 75 08             	pushl  0x8(%ebp)
  8014e9:	6a 29                	push   $0x29
  8014eb:	e8 fd fa ff ff       	call   800fed <syscall>
  8014f0:	83 c4 18             	add    $0x18,%esp
	return ;
  8014f3:	90                   	nop
}
  8014f4:	c9                   	leave  
  8014f5:	c3                   	ret    

008014f6 <inctst>:

void inctst()
{
  8014f6:	55                   	push   %ebp
  8014f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	6a 00                	push   $0x0
  801503:	6a 2a                	push   $0x2a
  801505:	e8 e3 fa ff ff       	call   800fed <syscall>
  80150a:	83 c4 18             	add    $0x18,%esp
	return ;
  80150d:	90                   	nop
}
  80150e:	c9                   	leave  
  80150f:	c3                   	ret    

00801510 <gettst>:
uint32 gettst()
{
  801510:	55                   	push   %ebp
  801511:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	6a 2b                	push   $0x2b
  80151f:	e8 c9 fa ff ff       	call   800fed <syscall>
  801524:	83 c4 18             	add    $0x18,%esp
}
  801527:	c9                   	leave  
  801528:	c3                   	ret    

00801529 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801529:	55                   	push   %ebp
  80152a:	89 e5                	mov    %esp,%ebp
  80152c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80152f:	6a 00                	push   $0x0
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	6a 00                	push   $0x0
  801537:	6a 00                	push   $0x0
  801539:	6a 2c                	push   $0x2c
  80153b:	e8 ad fa ff ff       	call   800fed <syscall>
  801540:	83 c4 18             	add    $0x18,%esp
  801543:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801546:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80154a:	75 07                	jne    801553 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80154c:	b8 01 00 00 00       	mov    $0x1,%eax
  801551:	eb 05                	jmp    801558 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801553:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801558:	c9                   	leave  
  801559:	c3                   	ret    

0080155a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80155a:	55                   	push   %ebp
  80155b:	89 e5                	mov    %esp,%ebp
  80155d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801560:	6a 00                	push   $0x0
  801562:	6a 00                	push   $0x0
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	6a 2c                	push   $0x2c
  80156c:	e8 7c fa ff ff       	call   800fed <syscall>
  801571:	83 c4 18             	add    $0x18,%esp
  801574:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801577:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80157b:	75 07                	jne    801584 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80157d:	b8 01 00 00 00       	mov    $0x1,%eax
  801582:	eb 05                	jmp    801589 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801584:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801589:	c9                   	leave  
  80158a:	c3                   	ret    

0080158b <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80158b:	55                   	push   %ebp
  80158c:	89 e5                	mov    %esp,%ebp
  80158e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801591:	6a 00                	push   $0x0
  801593:	6a 00                	push   $0x0
  801595:	6a 00                	push   $0x0
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 2c                	push   $0x2c
  80159d:	e8 4b fa ff ff       	call   800fed <syscall>
  8015a2:	83 c4 18             	add    $0x18,%esp
  8015a5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015a8:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015ac:	75 07                	jne    8015b5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8015b3:	eb 05                	jmp    8015ba <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ba:	c9                   	leave  
  8015bb:	c3                   	ret    

008015bc <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015bc:	55                   	push   %ebp
  8015bd:	89 e5                	mov    %esp,%ebp
  8015bf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 2c                	push   $0x2c
  8015ce:	e8 1a fa ff ff       	call   800fed <syscall>
  8015d3:	83 c4 18             	add    $0x18,%esp
  8015d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015d9:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015dd:	75 07                	jne    8015e6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015df:	b8 01 00 00 00       	mov    $0x1,%eax
  8015e4:	eb 05                	jmp    8015eb <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015e6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015eb:	c9                   	leave  
  8015ec:	c3                   	ret    

008015ed <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8015ed:	55                   	push   %ebp
  8015ee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	ff 75 08             	pushl  0x8(%ebp)
  8015fb:	6a 2d                	push   $0x2d
  8015fd:	e8 eb f9 ff ff       	call   800fed <syscall>
  801602:	83 c4 18             	add    $0x18,%esp
	return ;
  801605:	90                   	nop
}
  801606:	c9                   	leave  
  801607:	c3                   	ret    

00801608 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801608:	55                   	push   %ebp
  801609:	89 e5                	mov    %esp,%ebp
  80160b:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80160c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80160f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801612:	8b 55 0c             	mov    0xc(%ebp),%edx
  801615:	8b 45 08             	mov    0x8(%ebp),%eax
  801618:	6a 00                	push   $0x0
  80161a:	53                   	push   %ebx
  80161b:	51                   	push   %ecx
  80161c:	52                   	push   %edx
  80161d:	50                   	push   %eax
  80161e:	6a 2e                	push   $0x2e
  801620:	e8 c8 f9 ff ff       	call   800fed <syscall>
  801625:	83 c4 18             	add    $0x18,%esp
}
  801628:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80162b:	c9                   	leave  
  80162c:	c3                   	ret    

0080162d <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80162d:	55                   	push   %ebp
  80162e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801630:	8b 55 0c             	mov    0xc(%ebp),%edx
  801633:	8b 45 08             	mov    0x8(%ebp),%eax
  801636:	6a 00                	push   $0x0
  801638:	6a 00                	push   $0x0
  80163a:	6a 00                	push   $0x0
  80163c:	52                   	push   %edx
  80163d:	50                   	push   %eax
  80163e:	6a 2f                	push   $0x2f
  801640:	e8 a8 f9 ff ff       	call   800fed <syscall>
  801645:	83 c4 18             	add    $0x18,%esp
}
  801648:	c9                   	leave  
  801649:	c3                   	ret    

0080164a <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  80164a:	55                   	push   %ebp
  80164b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	ff 75 0c             	pushl  0xc(%ebp)
  801656:	ff 75 08             	pushl  0x8(%ebp)
  801659:	6a 30                	push   $0x30
  80165b:	e8 8d f9 ff ff       	call   800fed <syscall>
  801660:	83 c4 18             	add    $0x18,%esp
	return ;
  801663:	90                   	nop
}
  801664:	c9                   	leave  
  801665:	c3                   	ret    
  801666:	66 90                	xchg   %ax,%ax

00801668 <__udivdi3>:
  801668:	55                   	push   %ebp
  801669:	57                   	push   %edi
  80166a:	56                   	push   %esi
  80166b:	53                   	push   %ebx
  80166c:	83 ec 1c             	sub    $0x1c,%esp
  80166f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801673:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801677:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80167b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80167f:	89 ca                	mov    %ecx,%edx
  801681:	89 f8                	mov    %edi,%eax
  801683:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801687:	85 f6                	test   %esi,%esi
  801689:	75 2d                	jne    8016b8 <__udivdi3+0x50>
  80168b:	39 cf                	cmp    %ecx,%edi
  80168d:	77 65                	ja     8016f4 <__udivdi3+0x8c>
  80168f:	89 fd                	mov    %edi,%ebp
  801691:	85 ff                	test   %edi,%edi
  801693:	75 0b                	jne    8016a0 <__udivdi3+0x38>
  801695:	b8 01 00 00 00       	mov    $0x1,%eax
  80169a:	31 d2                	xor    %edx,%edx
  80169c:	f7 f7                	div    %edi
  80169e:	89 c5                	mov    %eax,%ebp
  8016a0:	31 d2                	xor    %edx,%edx
  8016a2:	89 c8                	mov    %ecx,%eax
  8016a4:	f7 f5                	div    %ebp
  8016a6:	89 c1                	mov    %eax,%ecx
  8016a8:	89 d8                	mov    %ebx,%eax
  8016aa:	f7 f5                	div    %ebp
  8016ac:	89 cf                	mov    %ecx,%edi
  8016ae:	89 fa                	mov    %edi,%edx
  8016b0:	83 c4 1c             	add    $0x1c,%esp
  8016b3:	5b                   	pop    %ebx
  8016b4:	5e                   	pop    %esi
  8016b5:	5f                   	pop    %edi
  8016b6:	5d                   	pop    %ebp
  8016b7:	c3                   	ret    
  8016b8:	39 ce                	cmp    %ecx,%esi
  8016ba:	77 28                	ja     8016e4 <__udivdi3+0x7c>
  8016bc:	0f bd fe             	bsr    %esi,%edi
  8016bf:	83 f7 1f             	xor    $0x1f,%edi
  8016c2:	75 40                	jne    801704 <__udivdi3+0x9c>
  8016c4:	39 ce                	cmp    %ecx,%esi
  8016c6:	72 0a                	jb     8016d2 <__udivdi3+0x6a>
  8016c8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8016cc:	0f 87 9e 00 00 00    	ja     801770 <__udivdi3+0x108>
  8016d2:	b8 01 00 00 00       	mov    $0x1,%eax
  8016d7:	89 fa                	mov    %edi,%edx
  8016d9:	83 c4 1c             	add    $0x1c,%esp
  8016dc:	5b                   	pop    %ebx
  8016dd:	5e                   	pop    %esi
  8016de:	5f                   	pop    %edi
  8016df:	5d                   	pop    %ebp
  8016e0:	c3                   	ret    
  8016e1:	8d 76 00             	lea    0x0(%esi),%esi
  8016e4:	31 ff                	xor    %edi,%edi
  8016e6:	31 c0                	xor    %eax,%eax
  8016e8:	89 fa                	mov    %edi,%edx
  8016ea:	83 c4 1c             	add    $0x1c,%esp
  8016ed:	5b                   	pop    %ebx
  8016ee:	5e                   	pop    %esi
  8016ef:	5f                   	pop    %edi
  8016f0:	5d                   	pop    %ebp
  8016f1:	c3                   	ret    
  8016f2:	66 90                	xchg   %ax,%ax
  8016f4:	89 d8                	mov    %ebx,%eax
  8016f6:	f7 f7                	div    %edi
  8016f8:	31 ff                	xor    %edi,%edi
  8016fa:	89 fa                	mov    %edi,%edx
  8016fc:	83 c4 1c             	add    $0x1c,%esp
  8016ff:	5b                   	pop    %ebx
  801700:	5e                   	pop    %esi
  801701:	5f                   	pop    %edi
  801702:	5d                   	pop    %ebp
  801703:	c3                   	ret    
  801704:	bd 20 00 00 00       	mov    $0x20,%ebp
  801709:	89 eb                	mov    %ebp,%ebx
  80170b:	29 fb                	sub    %edi,%ebx
  80170d:	89 f9                	mov    %edi,%ecx
  80170f:	d3 e6                	shl    %cl,%esi
  801711:	89 c5                	mov    %eax,%ebp
  801713:	88 d9                	mov    %bl,%cl
  801715:	d3 ed                	shr    %cl,%ebp
  801717:	89 e9                	mov    %ebp,%ecx
  801719:	09 f1                	or     %esi,%ecx
  80171b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80171f:	89 f9                	mov    %edi,%ecx
  801721:	d3 e0                	shl    %cl,%eax
  801723:	89 c5                	mov    %eax,%ebp
  801725:	89 d6                	mov    %edx,%esi
  801727:	88 d9                	mov    %bl,%cl
  801729:	d3 ee                	shr    %cl,%esi
  80172b:	89 f9                	mov    %edi,%ecx
  80172d:	d3 e2                	shl    %cl,%edx
  80172f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801733:	88 d9                	mov    %bl,%cl
  801735:	d3 e8                	shr    %cl,%eax
  801737:	09 c2                	or     %eax,%edx
  801739:	89 d0                	mov    %edx,%eax
  80173b:	89 f2                	mov    %esi,%edx
  80173d:	f7 74 24 0c          	divl   0xc(%esp)
  801741:	89 d6                	mov    %edx,%esi
  801743:	89 c3                	mov    %eax,%ebx
  801745:	f7 e5                	mul    %ebp
  801747:	39 d6                	cmp    %edx,%esi
  801749:	72 19                	jb     801764 <__udivdi3+0xfc>
  80174b:	74 0b                	je     801758 <__udivdi3+0xf0>
  80174d:	89 d8                	mov    %ebx,%eax
  80174f:	31 ff                	xor    %edi,%edi
  801751:	e9 58 ff ff ff       	jmp    8016ae <__udivdi3+0x46>
  801756:	66 90                	xchg   %ax,%ax
  801758:	8b 54 24 08          	mov    0x8(%esp),%edx
  80175c:	89 f9                	mov    %edi,%ecx
  80175e:	d3 e2                	shl    %cl,%edx
  801760:	39 c2                	cmp    %eax,%edx
  801762:	73 e9                	jae    80174d <__udivdi3+0xe5>
  801764:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801767:	31 ff                	xor    %edi,%edi
  801769:	e9 40 ff ff ff       	jmp    8016ae <__udivdi3+0x46>
  80176e:	66 90                	xchg   %ax,%ax
  801770:	31 c0                	xor    %eax,%eax
  801772:	e9 37 ff ff ff       	jmp    8016ae <__udivdi3+0x46>
  801777:	90                   	nop

00801778 <__umoddi3>:
  801778:	55                   	push   %ebp
  801779:	57                   	push   %edi
  80177a:	56                   	push   %esi
  80177b:	53                   	push   %ebx
  80177c:	83 ec 1c             	sub    $0x1c,%esp
  80177f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801783:	8b 74 24 34          	mov    0x34(%esp),%esi
  801787:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80178b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80178f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801793:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801797:	89 f3                	mov    %esi,%ebx
  801799:	89 fa                	mov    %edi,%edx
  80179b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80179f:	89 34 24             	mov    %esi,(%esp)
  8017a2:	85 c0                	test   %eax,%eax
  8017a4:	75 1a                	jne    8017c0 <__umoddi3+0x48>
  8017a6:	39 f7                	cmp    %esi,%edi
  8017a8:	0f 86 a2 00 00 00    	jbe    801850 <__umoddi3+0xd8>
  8017ae:	89 c8                	mov    %ecx,%eax
  8017b0:	89 f2                	mov    %esi,%edx
  8017b2:	f7 f7                	div    %edi
  8017b4:	89 d0                	mov    %edx,%eax
  8017b6:	31 d2                	xor    %edx,%edx
  8017b8:	83 c4 1c             	add    $0x1c,%esp
  8017bb:	5b                   	pop    %ebx
  8017bc:	5e                   	pop    %esi
  8017bd:	5f                   	pop    %edi
  8017be:	5d                   	pop    %ebp
  8017bf:	c3                   	ret    
  8017c0:	39 f0                	cmp    %esi,%eax
  8017c2:	0f 87 ac 00 00 00    	ja     801874 <__umoddi3+0xfc>
  8017c8:	0f bd e8             	bsr    %eax,%ebp
  8017cb:	83 f5 1f             	xor    $0x1f,%ebp
  8017ce:	0f 84 ac 00 00 00    	je     801880 <__umoddi3+0x108>
  8017d4:	bf 20 00 00 00       	mov    $0x20,%edi
  8017d9:	29 ef                	sub    %ebp,%edi
  8017db:	89 fe                	mov    %edi,%esi
  8017dd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8017e1:	89 e9                	mov    %ebp,%ecx
  8017e3:	d3 e0                	shl    %cl,%eax
  8017e5:	89 d7                	mov    %edx,%edi
  8017e7:	89 f1                	mov    %esi,%ecx
  8017e9:	d3 ef                	shr    %cl,%edi
  8017eb:	09 c7                	or     %eax,%edi
  8017ed:	89 e9                	mov    %ebp,%ecx
  8017ef:	d3 e2                	shl    %cl,%edx
  8017f1:	89 14 24             	mov    %edx,(%esp)
  8017f4:	89 d8                	mov    %ebx,%eax
  8017f6:	d3 e0                	shl    %cl,%eax
  8017f8:	89 c2                	mov    %eax,%edx
  8017fa:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017fe:	d3 e0                	shl    %cl,%eax
  801800:	89 44 24 04          	mov    %eax,0x4(%esp)
  801804:	8b 44 24 08          	mov    0x8(%esp),%eax
  801808:	89 f1                	mov    %esi,%ecx
  80180a:	d3 e8                	shr    %cl,%eax
  80180c:	09 d0                	or     %edx,%eax
  80180e:	d3 eb                	shr    %cl,%ebx
  801810:	89 da                	mov    %ebx,%edx
  801812:	f7 f7                	div    %edi
  801814:	89 d3                	mov    %edx,%ebx
  801816:	f7 24 24             	mull   (%esp)
  801819:	89 c6                	mov    %eax,%esi
  80181b:	89 d1                	mov    %edx,%ecx
  80181d:	39 d3                	cmp    %edx,%ebx
  80181f:	0f 82 87 00 00 00    	jb     8018ac <__umoddi3+0x134>
  801825:	0f 84 91 00 00 00    	je     8018bc <__umoddi3+0x144>
  80182b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80182f:	29 f2                	sub    %esi,%edx
  801831:	19 cb                	sbb    %ecx,%ebx
  801833:	89 d8                	mov    %ebx,%eax
  801835:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801839:	d3 e0                	shl    %cl,%eax
  80183b:	89 e9                	mov    %ebp,%ecx
  80183d:	d3 ea                	shr    %cl,%edx
  80183f:	09 d0                	or     %edx,%eax
  801841:	89 e9                	mov    %ebp,%ecx
  801843:	d3 eb                	shr    %cl,%ebx
  801845:	89 da                	mov    %ebx,%edx
  801847:	83 c4 1c             	add    $0x1c,%esp
  80184a:	5b                   	pop    %ebx
  80184b:	5e                   	pop    %esi
  80184c:	5f                   	pop    %edi
  80184d:	5d                   	pop    %ebp
  80184e:	c3                   	ret    
  80184f:	90                   	nop
  801850:	89 fd                	mov    %edi,%ebp
  801852:	85 ff                	test   %edi,%edi
  801854:	75 0b                	jne    801861 <__umoddi3+0xe9>
  801856:	b8 01 00 00 00       	mov    $0x1,%eax
  80185b:	31 d2                	xor    %edx,%edx
  80185d:	f7 f7                	div    %edi
  80185f:	89 c5                	mov    %eax,%ebp
  801861:	89 f0                	mov    %esi,%eax
  801863:	31 d2                	xor    %edx,%edx
  801865:	f7 f5                	div    %ebp
  801867:	89 c8                	mov    %ecx,%eax
  801869:	f7 f5                	div    %ebp
  80186b:	89 d0                	mov    %edx,%eax
  80186d:	e9 44 ff ff ff       	jmp    8017b6 <__umoddi3+0x3e>
  801872:	66 90                	xchg   %ax,%ax
  801874:	89 c8                	mov    %ecx,%eax
  801876:	89 f2                	mov    %esi,%edx
  801878:	83 c4 1c             	add    $0x1c,%esp
  80187b:	5b                   	pop    %ebx
  80187c:	5e                   	pop    %esi
  80187d:	5f                   	pop    %edi
  80187e:	5d                   	pop    %ebp
  80187f:	c3                   	ret    
  801880:	3b 04 24             	cmp    (%esp),%eax
  801883:	72 06                	jb     80188b <__umoddi3+0x113>
  801885:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801889:	77 0f                	ja     80189a <__umoddi3+0x122>
  80188b:	89 f2                	mov    %esi,%edx
  80188d:	29 f9                	sub    %edi,%ecx
  80188f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801893:	89 14 24             	mov    %edx,(%esp)
  801896:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80189a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80189e:	8b 14 24             	mov    (%esp),%edx
  8018a1:	83 c4 1c             	add    $0x1c,%esp
  8018a4:	5b                   	pop    %ebx
  8018a5:	5e                   	pop    %esi
  8018a6:	5f                   	pop    %edi
  8018a7:	5d                   	pop    %ebp
  8018a8:	c3                   	ret    
  8018a9:	8d 76 00             	lea    0x0(%esi),%esi
  8018ac:	2b 04 24             	sub    (%esp),%eax
  8018af:	19 fa                	sbb    %edi,%edx
  8018b1:	89 d1                	mov    %edx,%ecx
  8018b3:	89 c6                	mov    %eax,%esi
  8018b5:	e9 71 ff ff ff       	jmp    80182b <__umoddi3+0xb3>
  8018ba:	66 90                	xchg   %ax,%ax
  8018bc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8018c0:	72 ea                	jb     8018ac <__umoddi3+0x134>
  8018c2:	89 d9                	mov    %ebx,%ecx
  8018c4:	e9 62 ff ff ff       	jmp    80182b <__umoddi3+0xb3>
