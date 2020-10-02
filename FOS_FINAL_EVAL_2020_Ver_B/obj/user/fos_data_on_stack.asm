
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
  800049:	e8 2c 02 00 00       	call   80027a <atomic_cprintf>
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
  80005a:	e8 19 10 00 00       	call   801078 <sys_getenvindex>
  80005f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800062:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800065:	89 d0                	mov    %edx,%eax
  800067:	c1 e0 03             	shl    $0x3,%eax
  80006a:	01 d0                	add    %edx,%eax
  80006c:	c1 e0 02             	shl    $0x2,%eax
  80006f:	01 d0                	add    %edx,%eax
  800071:	c1 e0 06             	shl    $0x6,%eax
  800074:	29 d0                	sub    %edx,%eax
  800076:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80007d:	01 c8                	add    %ecx,%eax
  80007f:	01 d0                	add    %edx,%eax
  800081:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800086:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80008b:	a1 20 20 80 00       	mov    0x802020,%eax
  800090:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  800096:	84 c0                	test   %al,%al
  800098:	74 0f                	je     8000a9 <libmain+0x55>
		binaryname = myEnv->prog_name;
  80009a:	a1 20 20 80 00       	mov    0x802020,%eax
  80009f:	05 b0 52 00 00       	add    $0x52b0,%eax
  8000a4:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000a9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000ad:	7e 0a                	jle    8000b9 <libmain+0x65>
		binaryname = argv[0];
  8000af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000b2:	8b 00                	mov    (%eax),%eax
  8000b4:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000b9:	83 ec 08             	sub    $0x8,%esp
  8000bc:	ff 75 0c             	pushl  0xc(%ebp)
  8000bf:	ff 75 08             	pushl  0x8(%ebp)
  8000c2:	e8 71 ff ff ff       	call   800038 <_main>
  8000c7:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000ca:	e8 44 11 00 00       	call   801213 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	68 fc 18 80 00       	push   $0x8018fc
  8000d7:	e8 71 01 00 00       	call   80024d <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8000df:	a1 20 20 80 00       	mov    0x802020,%eax
  8000e4:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  8000ea:	a1 20 20 80 00       	mov    0x802020,%eax
  8000ef:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  8000f5:	83 ec 04             	sub    $0x4,%esp
  8000f8:	52                   	push   %edx
  8000f9:	50                   	push   %eax
  8000fa:	68 24 19 80 00       	push   $0x801924
  8000ff:	e8 49 01 00 00       	call   80024d <cprintf>
  800104:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800107:	a1 20 20 80 00       	mov    0x802020,%eax
  80010c:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  800112:	a1 20 20 80 00       	mov    0x802020,%eax
  800117:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  80011d:	a1 20 20 80 00       	mov    0x802020,%eax
  800122:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  800128:	51                   	push   %ecx
  800129:	52                   	push   %edx
  80012a:	50                   	push   %eax
  80012b:	68 4c 19 80 00       	push   $0x80194c
  800130:	e8 18 01 00 00       	call   80024d <cprintf>
  800135:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800138:	83 ec 0c             	sub    $0xc,%esp
  80013b:	68 fc 18 80 00       	push   $0x8018fc
  800140:	e8 08 01 00 00       	call   80024d <cprintf>
  800145:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800148:	e8 e0 10 00 00       	call   80122d <sys_enable_interrupt>

	// exit gracefully
	exit();
  80014d:	e8 19 00 00 00       	call   80016b <exit>
}
  800152:	90                   	nop
  800153:	c9                   	leave  
  800154:	c3                   	ret    

00800155 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800155:	55                   	push   %ebp
  800156:	89 e5                	mov    %esp,%ebp
  800158:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80015b:	83 ec 0c             	sub    $0xc,%esp
  80015e:	6a 00                	push   $0x0
  800160:	e8 df 0e 00 00       	call   801044 <sys_env_destroy>
  800165:	83 c4 10             	add    $0x10,%esp
}
  800168:	90                   	nop
  800169:	c9                   	leave  
  80016a:	c3                   	ret    

0080016b <exit>:

void
exit(void)
{
  80016b:	55                   	push   %ebp
  80016c:	89 e5                	mov    %esp,%ebp
  80016e:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800171:	e8 34 0f 00 00       	call   8010aa <sys_env_exit>
}
  800176:	90                   	nop
  800177:	c9                   	leave  
  800178:	c3                   	ret    

00800179 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800179:	55                   	push   %ebp
  80017a:	89 e5                	mov    %esp,%ebp
  80017c:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80017f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800182:	8b 00                	mov    (%eax),%eax
  800184:	8d 48 01             	lea    0x1(%eax),%ecx
  800187:	8b 55 0c             	mov    0xc(%ebp),%edx
  80018a:	89 0a                	mov    %ecx,(%edx)
  80018c:	8b 55 08             	mov    0x8(%ebp),%edx
  80018f:	88 d1                	mov    %dl,%cl
  800191:	8b 55 0c             	mov    0xc(%ebp),%edx
  800194:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800198:	8b 45 0c             	mov    0xc(%ebp),%eax
  80019b:	8b 00                	mov    (%eax),%eax
  80019d:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001a2:	75 2c                	jne    8001d0 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001a4:	a0 24 20 80 00       	mov    0x802024,%al
  8001a9:	0f b6 c0             	movzbl %al,%eax
  8001ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001af:	8b 12                	mov    (%edx),%edx
  8001b1:	89 d1                	mov    %edx,%ecx
  8001b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001b6:	83 c2 08             	add    $0x8,%edx
  8001b9:	83 ec 04             	sub    $0x4,%esp
  8001bc:	50                   	push   %eax
  8001bd:	51                   	push   %ecx
  8001be:	52                   	push   %edx
  8001bf:	e8 3e 0e 00 00       	call   801002 <sys_cputs>
  8001c4:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ca:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d3:	8b 40 04             	mov    0x4(%eax),%eax
  8001d6:	8d 50 01             	lea    0x1(%eax),%edx
  8001d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001dc:	89 50 04             	mov    %edx,0x4(%eax)
}
  8001df:	90                   	nop
  8001e0:	c9                   	leave  
  8001e1:	c3                   	ret    

008001e2 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8001e2:	55                   	push   %ebp
  8001e3:	89 e5                	mov    %esp,%ebp
  8001e5:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8001eb:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8001f2:	00 00 00 
	b.cnt = 0;
  8001f5:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8001fc:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8001ff:	ff 75 0c             	pushl  0xc(%ebp)
  800202:	ff 75 08             	pushl  0x8(%ebp)
  800205:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80020b:	50                   	push   %eax
  80020c:	68 79 01 80 00       	push   $0x800179
  800211:	e8 11 02 00 00       	call   800427 <vprintfmt>
  800216:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800219:	a0 24 20 80 00       	mov    0x802024,%al
  80021e:	0f b6 c0             	movzbl %al,%eax
  800221:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800227:	83 ec 04             	sub    $0x4,%esp
  80022a:	50                   	push   %eax
  80022b:	52                   	push   %edx
  80022c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800232:	83 c0 08             	add    $0x8,%eax
  800235:	50                   	push   %eax
  800236:	e8 c7 0d 00 00       	call   801002 <sys_cputs>
  80023b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80023e:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  800245:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80024b:	c9                   	leave  
  80024c:	c3                   	ret    

0080024d <cprintf>:

int cprintf(const char *fmt, ...) {
  80024d:	55                   	push   %ebp
  80024e:	89 e5                	mov    %esp,%ebp
  800250:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800253:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  80025a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80025d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800260:	8b 45 08             	mov    0x8(%ebp),%eax
  800263:	83 ec 08             	sub    $0x8,%esp
  800266:	ff 75 f4             	pushl  -0xc(%ebp)
  800269:	50                   	push   %eax
  80026a:	e8 73 ff ff ff       	call   8001e2 <vcprintf>
  80026f:	83 c4 10             	add    $0x10,%esp
  800272:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800275:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800278:	c9                   	leave  
  800279:	c3                   	ret    

0080027a <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80027a:	55                   	push   %ebp
  80027b:	89 e5                	mov    %esp,%ebp
  80027d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800280:	e8 8e 0f 00 00       	call   801213 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800285:	8d 45 0c             	lea    0xc(%ebp),%eax
  800288:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80028b:	8b 45 08             	mov    0x8(%ebp),%eax
  80028e:	83 ec 08             	sub    $0x8,%esp
  800291:	ff 75 f4             	pushl  -0xc(%ebp)
  800294:	50                   	push   %eax
  800295:	e8 48 ff ff ff       	call   8001e2 <vcprintf>
  80029a:	83 c4 10             	add    $0x10,%esp
  80029d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002a0:	e8 88 0f 00 00       	call   80122d <sys_enable_interrupt>
	return cnt;
  8002a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002a8:	c9                   	leave  
  8002a9:	c3                   	ret    

008002aa <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002aa:	55                   	push   %ebp
  8002ab:	89 e5                	mov    %esp,%ebp
  8002ad:	53                   	push   %ebx
  8002ae:	83 ec 14             	sub    $0x14,%esp
  8002b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8002b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8002ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002bd:	8b 45 18             	mov    0x18(%ebp),%eax
  8002c0:	ba 00 00 00 00       	mov    $0x0,%edx
  8002c5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002c8:	77 55                	ja     80031f <printnum+0x75>
  8002ca:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002cd:	72 05                	jb     8002d4 <printnum+0x2a>
  8002cf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002d2:	77 4b                	ja     80031f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8002d4:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8002d7:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8002da:	8b 45 18             	mov    0x18(%ebp),%eax
  8002dd:	ba 00 00 00 00       	mov    $0x0,%edx
  8002e2:	52                   	push   %edx
  8002e3:	50                   	push   %eax
  8002e4:	ff 75 f4             	pushl  -0xc(%ebp)
  8002e7:	ff 75 f0             	pushl  -0x10(%ebp)
  8002ea:	e8 61 13 00 00       	call   801650 <__udivdi3>
  8002ef:	83 c4 10             	add    $0x10,%esp
  8002f2:	83 ec 04             	sub    $0x4,%esp
  8002f5:	ff 75 20             	pushl  0x20(%ebp)
  8002f8:	53                   	push   %ebx
  8002f9:	ff 75 18             	pushl  0x18(%ebp)
  8002fc:	52                   	push   %edx
  8002fd:	50                   	push   %eax
  8002fe:	ff 75 0c             	pushl  0xc(%ebp)
  800301:	ff 75 08             	pushl  0x8(%ebp)
  800304:	e8 a1 ff ff ff       	call   8002aa <printnum>
  800309:	83 c4 20             	add    $0x20,%esp
  80030c:	eb 1a                	jmp    800328 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80030e:	83 ec 08             	sub    $0x8,%esp
  800311:	ff 75 0c             	pushl  0xc(%ebp)
  800314:	ff 75 20             	pushl  0x20(%ebp)
  800317:	8b 45 08             	mov    0x8(%ebp),%eax
  80031a:	ff d0                	call   *%eax
  80031c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80031f:	ff 4d 1c             	decl   0x1c(%ebp)
  800322:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800326:	7f e6                	jg     80030e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800328:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80032b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800330:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800333:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800336:	53                   	push   %ebx
  800337:	51                   	push   %ecx
  800338:	52                   	push   %edx
  800339:	50                   	push   %eax
  80033a:	e8 21 14 00 00       	call   801760 <__umoddi3>
  80033f:	83 c4 10             	add    $0x10,%esp
  800342:	05 d4 1b 80 00       	add    $0x801bd4,%eax
  800347:	8a 00                	mov    (%eax),%al
  800349:	0f be c0             	movsbl %al,%eax
  80034c:	83 ec 08             	sub    $0x8,%esp
  80034f:	ff 75 0c             	pushl  0xc(%ebp)
  800352:	50                   	push   %eax
  800353:	8b 45 08             	mov    0x8(%ebp),%eax
  800356:	ff d0                	call   *%eax
  800358:	83 c4 10             	add    $0x10,%esp
}
  80035b:	90                   	nop
  80035c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80035f:	c9                   	leave  
  800360:	c3                   	ret    

00800361 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800361:	55                   	push   %ebp
  800362:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800364:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800368:	7e 1c                	jle    800386 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80036a:	8b 45 08             	mov    0x8(%ebp),%eax
  80036d:	8b 00                	mov    (%eax),%eax
  80036f:	8d 50 08             	lea    0x8(%eax),%edx
  800372:	8b 45 08             	mov    0x8(%ebp),%eax
  800375:	89 10                	mov    %edx,(%eax)
  800377:	8b 45 08             	mov    0x8(%ebp),%eax
  80037a:	8b 00                	mov    (%eax),%eax
  80037c:	83 e8 08             	sub    $0x8,%eax
  80037f:	8b 50 04             	mov    0x4(%eax),%edx
  800382:	8b 00                	mov    (%eax),%eax
  800384:	eb 40                	jmp    8003c6 <getuint+0x65>
	else if (lflag)
  800386:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80038a:	74 1e                	je     8003aa <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80038c:	8b 45 08             	mov    0x8(%ebp),%eax
  80038f:	8b 00                	mov    (%eax),%eax
  800391:	8d 50 04             	lea    0x4(%eax),%edx
  800394:	8b 45 08             	mov    0x8(%ebp),%eax
  800397:	89 10                	mov    %edx,(%eax)
  800399:	8b 45 08             	mov    0x8(%ebp),%eax
  80039c:	8b 00                	mov    (%eax),%eax
  80039e:	83 e8 04             	sub    $0x4,%eax
  8003a1:	8b 00                	mov    (%eax),%eax
  8003a3:	ba 00 00 00 00       	mov    $0x0,%edx
  8003a8:	eb 1c                	jmp    8003c6 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ad:	8b 00                	mov    (%eax),%eax
  8003af:	8d 50 04             	lea    0x4(%eax),%edx
  8003b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b5:	89 10                	mov    %edx,(%eax)
  8003b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ba:	8b 00                	mov    (%eax),%eax
  8003bc:	83 e8 04             	sub    $0x4,%eax
  8003bf:	8b 00                	mov    (%eax),%eax
  8003c1:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003c6:	5d                   	pop    %ebp
  8003c7:	c3                   	ret    

008003c8 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003c8:	55                   	push   %ebp
  8003c9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003cb:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003cf:	7e 1c                	jle    8003ed <getint+0x25>
		return va_arg(*ap, long long);
  8003d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d4:	8b 00                	mov    (%eax),%eax
  8003d6:	8d 50 08             	lea    0x8(%eax),%edx
  8003d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003dc:	89 10                	mov    %edx,(%eax)
  8003de:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e1:	8b 00                	mov    (%eax),%eax
  8003e3:	83 e8 08             	sub    $0x8,%eax
  8003e6:	8b 50 04             	mov    0x4(%eax),%edx
  8003e9:	8b 00                	mov    (%eax),%eax
  8003eb:	eb 38                	jmp    800425 <getint+0x5d>
	else if (lflag)
  8003ed:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003f1:	74 1a                	je     80040d <getint+0x45>
		return va_arg(*ap, long);
  8003f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f6:	8b 00                	mov    (%eax),%eax
  8003f8:	8d 50 04             	lea    0x4(%eax),%edx
  8003fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fe:	89 10                	mov    %edx,(%eax)
  800400:	8b 45 08             	mov    0x8(%ebp),%eax
  800403:	8b 00                	mov    (%eax),%eax
  800405:	83 e8 04             	sub    $0x4,%eax
  800408:	8b 00                	mov    (%eax),%eax
  80040a:	99                   	cltd   
  80040b:	eb 18                	jmp    800425 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80040d:	8b 45 08             	mov    0x8(%ebp),%eax
  800410:	8b 00                	mov    (%eax),%eax
  800412:	8d 50 04             	lea    0x4(%eax),%edx
  800415:	8b 45 08             	mov    0x8(%ebp),%eax
  800418:	89 10                	mov    %edx,(%eax)
  80041a:	8b 45 08             	mov    0x8(%ebp),%eax
  80041d:	8b 00                	mov    (%eax),%eax
  80041f:	83 e8 04             	sub    $0x4,%eax
  800422:	8b 00                	mov    (%eax),%eax
  800424:	99                   	cltd   
}
  800425:	5d                   	pop    %ebp
  800426:	c3                   	ret    

00800427 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800427:	55                   	push   %ebp
  800428:	89 e5                	mov    %esp,%ebp
  80042a:	56                   	push   %esi
  80042b:	53                   	push   %ebx
  80042c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80042f:	eb 17                	jmp    800448 <vprintfmt+0x21>
			if (ch == '\0')
  800431:	85 db                	test   %ebx,%ebx
  800433:	0f 84 af 03 00 00    	je     8007e8 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800439:	83 ec 08             	sub    $0x8,%esp
  80043c:	ff 75 0c             	pushl  0xc(%ebp)
  80043f:	53                   	push   %ebx
  800440:	8b 45 08             	mov    0x8(%ebp),%eax
  800443:	ff d0                	call   *%eax
  800445:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800448:	8b 45 10             	mov    0x10(%ebp),%eax
  80044b:	8d 50 01             	lea    0x1(%eax),%edx
  80044e:	89 55 10             	mov    %edx,0x10(%ebp)
  800451:	8a 00                	mov    (%eax),%al
  800453:	0f b6 d8             	movzbl %al,%ebx
  800456:	83 fb 25             	cmp    $0x25,%ebx
  800459:	75 d6                	jne    800431 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80045b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80045f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800466:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80046d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800474:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80047b:	8b 45 10             	mov    0x10(%ebp),%eax
  80047e:	8d 50 01             	lea    0x1(%eax),%edx
  800481:	89 55 10             	mov    %edx,0x10(%ebp)
  800484:	8a 00                	mov    (%eax),%al
  800486:	0f b6 d8             	movzbl %al,%ebx
  800489:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80048c:	83 f8 55             	cmp    $0x55,%eax
  80048f:	0f 87 2b 03 00 00    	ja     8007c0 <vprintfmt+0x399>
  800495:	8b 04 85 f8 1b 80 00 	mov    0x801bf8(,%eax,4),%eax
  80049c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80049e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004a2:	eb d7                	jmp    80047b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004a4:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004a8:	eb d1                	jmp    80047b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004aa:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004b1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004b4:	89 d0                	mov    %edx,%eax
  8004b6:	c1 e0 02             	shl    $0x2,%eax
  8004b9:	01 d0                	add    %edx,%eax
  8004bb:	01 c0                	add    %eax,%eax
  8004bd:	01 d8                	add    %ebx,%eax
  8004bf:	83 e8 30             	sub    $0x30,%eax
  8004c2:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c8:	8a 00                	mov    (%eax),%al
  8004ca:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004cd:	83 fb 2f             	cmp    $0x2f,%ebx
  8004d0:	7e 3e                	jle    800510 <vprintfmt+0xe9>
  8004d2:	83 fb 39             	cmp    $0x39,%ebx
  8004d5:	7f 39                	jg     800510 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004d7:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8004da:	eb d5                	jmp    8004b1 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8004dc:	8b 45 14             	mov    0x14(%ebp),%eax
  8004df:	83 c0 04             	add    $0x4,%eax
  8004e2:	89 45 14             	mov    %eax,0x14(%ebp)
  8004e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8004e8:	83 e8 04             	sub    $0x4,%eax
  8004eb:	8b 00                	mov    (%eax),%eax
  8004ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8004f0:	eb 1f                	jmp    800511 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8004f2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8004f6:	79 83                	jns    80047b <vprintfmt+0x54>
				width = 0;
  8004f8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8004ff:	e9 77 ff ff ff       	jmp    80047b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800504:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80050b:	e9 6b ff ff ff       	jmp    80047b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800510:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800511:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800515:	0f 89 60 ff ff ff    	jns    80047b <vprintfmt+0x54>
				width = precision, precision = -1;
  80051b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80051e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800521:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800528:	e9 4e ff ff ff       	jmp    80047b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80052d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800530:	e9 46 ff ff ff       	jmp    80047b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800535:	8b 45 14             	mov    0x14(%ebp),%eax
  800538:	83 c0 04             	add    $0x4,%eax
  80053b:	89 45 14             	mov    %eax,0x14(%ebp)
  80053e:	8b 45 14             	mov    0x14(%ebp),%eax
  800541:	83 e8 04             	sub    $0x4,%eax
  800544:	8b 00                	mov    (%eax),%eax
  800546:	83 ec 08             	sub    $0x8,%esp
  800549:	ff 75 0c             	pushl  0xc(%ebp)
  80054c:	50                   	push   %eax
  80054d:	8b 45 08             	mov    0x8(%ebp),%eax
  800550:	ff d0                	call   *%eax
  800552:	83 c4 10             	add    $0x10,%esp
			break;
  800555:	e9 89 02 00 00       	jmp    8007e3 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80055a:	8b 45 14             	mov    0x14(%ebp),%eax
  80055d:	83 c0 04             	add    $0x4,%eax
  800560:	89 45 14             	mov    %eax,0x14(%ebp)
  800563:	8b 45 14             	mov    0x14(%ebp),%eax
  800566:	83 e8 04             	sub    $0x4,%eax
  800569:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80056b:	85 db                	test   %ebx,%ebx
  80056d:	79 02                	jns    800571 <vprintfmt+0x14a>
				err = -err;
  80056f:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800571:	83 fb 64             	cmp    $0x64,%ebx
  800574:	7f 0b                	jg     800581 <vprintfmt+0x15a>
  800576:	8b 34 9d 40 1a 80 00 	mov    0x801a40(,%ebx,4),%esi
  80057d:	85 f6                	test   %esi,%esi
  80057f:	75 19                	jne    80059a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800581:	53                   	push   %ebx
  800582:	68 e5 1b 80 00       	push   $0x801be5
  800587:	ff 75 0c             	pushl  0xc(%ebp)
  80058a:	ff 75 08             	pushl  0x8(%ebp)
  80058d:	e8 5e 02 00 00       	call   8007f0 <printfmt>
  800592:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800595:	e9 49 02 00 00       	jmp    8007e3 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80059a:	56                   	push   %esi
  80059b:	68 ee 1b 80 00       	push   $0x801bee
  8005a0:	ff 75 0c             	pushl  0xc(%ebp)
  8005a3:	ff 75 08             	pushl  0x8(%ebp)
  8005a6:	e8 45 02 00 00       	call   8007f0 <printfmt>
  8005ab:	83 c4 10             	add    $0x10,%esp
			break;
  8005ae:	e9 30 02 00 00       	jmp    8007e3 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b6:	83 c0 04             	add    $0x4,%eax
  8005b9:	89 45 14             	mov    %eax,0x14(%ebp)
  8005bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8005bf:	83 e8 04             	sub    $0x4,%eax
  8005c2:	8b 30                	mov    (%eax),%esi
  8005c4:	85 f6                	test   %esi,%esi
  8005c6:	75 05                	jne    8005cd <vprintfmt+0x1a6>
				p = "(null)";
  8005c8:	be f1 1b 80 00       	mov    $0x801bf1,%esi
			if (width > 0 && padc != '-')
  8005cd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005d1:	7e 6d                	jle    800640 <vprintfmt+0x219>
  8005d3:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8005d7:	74 67                	je     800640 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8005d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005dc:	83 ec 08             	sub    $0x8,%esp
  8005df:	50                   	push   %eax
  8005e0:	56                   	push   %esi
  8005e1:	e8 0c 03 00 00       	call   8008f2 <strnlen>
  8005e6:	83 c4 10             	add    $0x10,%esp
  8005e9:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8005ec:	eb 16                	jmp    800604 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8005ee:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8005f2:	83 ec 08             	sub    $0x8,%esp
  8005f5:	ff 75 0c             	pushl  0xc(%ebp)
  8005f8:	50                   	push   %eax
  8005f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fc:	ff d0                	call   *%eax
  8005fe:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800601:	ff 4d e4             	decl   -0x1c(%ebp)
  800604:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800608:	7f e4                	jg     8005ee <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80060a:	eb 34                	jmp    800640 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80060c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800610:	74 1c                	je     80062e <vprintfmt+0x207>
  800612:	83 fb 1f             	cmp    $0x1f,%ebx
  800615:	7e 05                	jle    80061c <vprintfmt+0x1f5>
  800617:	83 fb 7e             	cmp    $0x7e,%ebx
  80061a:	7e 12                	jle    80062e <vprintfmt+0x207>
					putch('?', putdat);
  80061c:	83 ec 08             	sub    $0x8,%esp
  80061f:	ff 75 0c             	pushl  0xc(%ebp)
  800622:	6a 3f                	push   $0x3f
  800624:	8b 45 08             	mov    0x8(%ebp),%eax
  800627:	ff d0                	call   *%eax
  800629:	83 c4 10             	add    $0x10,%esp
  80062c:	eb 0f                	jmp    80063d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80062e:	83 ec 08             	sub    $0x8,%esp
  800631:	ff 75 0c             	pushl  0xc(%ebp)
  800634:	53                   	push   %ebx
  800635:	8b 45 08             	mov    0x8(%ebp),%eax
  800638:	ff d0                	call   *%eax
  80063a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80063d:	ff 4d e4             	decl   -0x1c(%ebp)
  800640:	89 f0                	mov    %esi,%eax
  800642:	8d 70 01             	lea    0x1(%eax),%esi
  800645:	8a 00                	mov    (%eax),%al
  800647:	0f be d8             	movsbl %al,%ebx
  80064a:	85 db                	test   %ebx,%ebx
  80064c:	74 24                	je     800672 <vprintfmt+0x24b>
  80064e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800652:	78 b8                	js     80060c <vprintfmt+0x1e5>
  800654:	ff 4d e0             	decl   -0x20(%ebp)
  800657:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80065b:	79 af                	jns    80060c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80065d:	eb 13                	jmp    800672 <vprintfmt+0x24b>
				putch(' ', putdat);
  80065f:	83 ec 08             	sub    $0x8,%esp
  800662:	ff 75 0c             	pushl  0xc(%ebp)
  800665:	6a 20                	push   $0x20
  800667:	8b 45 08             	mov    0x8(%ebp),%eax
  80066a:	ff d0                	call   *%eax
  80066c:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80066f:	ff 4d e4             	decl   -0x1c(%ebp)
  800672:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800676:	7f e7                	jg     80065f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800678:	e9 66 01 00 00       	jmp    8007e3 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80067d:	83 ec 08             	sub    $0x8,%esp
  800680:	ff 75 e8             	pushl  -0x18(%ebp)
  800683:	8d 45 14             	lea    0x14(%ebp),%eax
  800686:	50                   	push   %eax
  800687:	e8 3c fd ff ff       	call   8003c8 <getint>
  80068c:	83 c4 10             	add    $0x10,%esp
  80068f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800692:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800695:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800698:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80069b:	85 d2                	test   %edx,%edx
  80069d:	79 23                	jns    8006c2 <vprintfmt+0x29b>
				putch('-', putdat);
  80069f:	83 ec 08             	sub    $0x8,%esp
  8006a2:	ff 75 0c             	pushl  0xc(%ebp)
  8006a5:	6a 2d                	push   $0x2d
  8006a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006aa:	ff d0                	call   *%eax
  8006ac:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006af:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006b2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006b5:	f7 d8                	neg    %eax
  8006b7:	83 d2 00             	adc    $0x0,%edx
  8006ba:	f7 da                	neg    %edx
  8006bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006bf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006c2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006c9:	e9 bc 00 00 00       	jmp    80078a <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006ce:	83 ec 08             	sub    $0x8,%esp
  8006d1:	ff 75 e8             	pushl  -0x18(%ebp)
  8006d4:	8d 45 14             	lea    0x14(%ebp),%eax
  8006d7:	50                   	push   %eax
  8006d8:	e8 84 fc ff ff       	call   800361 <getuint>
  8006dd:	83 c4 10             	add    $0x10,%esp
  8006e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006e3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8006e6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006ed:	e9 98 00 00 00       	jmp    80078a <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8006f2:	83 ec 08             	sub    $0x8,%esp
  8006f5:	ff 75 0c             	pushl  0xc(%ebp)
  8006f8:	6a 58                	push   $0x58
  8006fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fd:	ff d0                	call   *%eax
  8006ff:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800702:	83 ec 08             	sub    $0x8,%esp
  800705:	ff 75 0c             	pushl  0xc(%ebp)
  800708:	6a 58                	push   $0x58
  80070a:	8b 45 08             	mov    0x8(%ebp),%eax
  80070d:	ff d0                	call   *%eax
  80070f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800712:	83 ec 08             	sub    $0x8,%esp
  800715:	ff 75 0c             	pushl  0xc(%ebp)
  800718:	6a 58                	push   $0x58
  80071a:	8b 45 08             	mov    0x8(%ebp),%eax
  80071d:	ff d0                	call   *%eax
  80071f:	83 c4 10             	add    $0x10,%esp
			break;
  800722:	e9 bc 00 00 00       	jmp    8007e3 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800727:	83 ec 08             	sub    $0x8,%esp
  80072a:	ff 75 0c             	pushl  0xc(%ebp)
  80072d:	6a 30                	push   $0x30
  80072f:	8b 45 08             	mov    0x8(%ebp),%eax
  800732:	ff d0                	call   *%eax
  800734:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800737:	83 ec 08             	sub    $0x8,%esp
  80073a:	ff 75 0c             	pushl  0xc(%ebp)
  80073d:	6a 78                	push   $0x78
  80073f:	8b 45 08             	mov    0x8(%ebp),%eax
  800742:	ff d0                	call   *%eax
  800744:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800747:	8b 45 14             	mov    0x14(%ebp),%eax
  80074a:	83 c0 04             	add    $0x4,%eax
  80074d:	89 45 14             	mov    %eax,0x14(%ebp)
  800750:	8b 45 14             	mov    0x14(%ebp),%eax
  800753:	83 e8 04             	sub    $0x4,%eax
  800756:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800758:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80075b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800762:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800769:	eb 1f                	jmp    80078a <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80076b:	83 ec 08             	sub    $0x8,%esp
  80076e:	ff 75 e8             	pushl  -0x18(%ebp)
  800771:	8d 45 14             	lea    0x14(%ebp),%eax
  800774:	50                   	push   %eax
  800775:	e8 e7 fb ff ff       	call   800361 <getuint>
  80077a:	83 c4 10             	add    $0x10,%esp
  80077d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800780:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800783:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80078a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80078e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800791:	83 ec 04             	sub    $0x4,%esp
  800794:	52                   	push   %edx
  800795:	ff 75 e4             	pushl  -0x1c(%ebp)
  800798:	50                   	push   %eax
  800799:	ff 75 f4             	pushl  -0xc(%ebp)
  80079c:	ff 75 f0             	pushl  -0x10(%ebp)
  80079f:	ff 75 0c             	pushl  0xc(%ebp)
  8007a2:	ff 75 08             	pushl  0x8(%ebp)
  8007a5:	e8 00 fb ff ff       	call   8002aa <printnum>
  8007aa:	83 c4 20             	add    $0x20,%esp
			break;
  8007ad:	eb 34                	jmp    8007e3 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007af:	83 ec 08             	sub    $0x8,%esp
  8007b2:	ff 75 0c             	pushl  0xc(%ebp)
  8007b5:	53                   	push   %ebx
  8007b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b9:	ff d0                	call   *%eax
  8007bb:	83 c4 10             	add    $0x10,%esp
			break;
  8007be:	eb 23                	jmp    8007e3 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007c0:	83 ec 08             	sub    $0x8,%esp
  8007c3:	ff 75 0c             	pushl  0xc(%ebp)
  8007c6:	6a 25                	push   $0x25
  8007c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cb:	ff d0                	call   *%eax
  8007cd:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007d0:	ff 4d 10             	decl   0x10(%ebp)
  8007d3:	eb 03                	jmp    8007d8 <vprintfmt+0x3b1>
  8007d5:	ff 4d 10             	decl   0x10(%ebp)
  8007d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8007db:	48                   	dec    %eax
  8007dc:	8a 00                	mov    (%eax),%al
  8007de:	3c 25                	cmp    $0x25,%al
  8007e0:	75 f3                	jne    8007d5 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8007e2:	90                   	nop
		}
	}
  8007e3:	e9 47 fc ff ff       	jmp    80042f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8007e8:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8007e9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8007ec:	5b                   	pop    %ebx
  8007ed:	5e                   	pop    %esi
  8007ee:	5d                   	pop    %ebp
  8007ef:	c3                   	ret    

008007f0 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8007f0:	55                   	push   %ebp
  8007f1:	89 e5                	mov    %esp,%ebp
  8007f3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8007f6:	8d 45 10             	lea    0x10(%ebp),%eax
  8007f9:	83 c0 04             	add    $0x4,%eax
  8007fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8007ff:	8b 45 10             	mov    0x10(%ebp),%eax
  800802:	ff 75 f4             	pushl  -0xc(%ebp)
  800805:	50                   	push   %eax
  800806:	ff 75 0c             	pushl  0xc(%ebp)
  800809:	ff 75 08             	pushl  0x8(%ebp)
  80080c:	e8 16 fc ff ff       	call   800427 <vprintfmt>
  800811:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800814:	90                   	nop
  800815:	c9                   	leave  
  800816:	c3                   	ret    

00800817 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800817:	55                   	push   %ebp
  800818:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80081a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80081d:	8b 40 08             	mov    0x8(%eax),%eax
  800820:	8d 50 01             	lea    0x1(%eax),%edx
  800823:	8b 45 0c             	mov    0xc(%ebp),%eax
  800826:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800829:	8b 45 0c             	mov    0xc(%ebp),%eax
  80082c:	8b 10                	mov    (%eax),%edx
  80082e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800831:	8b 40 04             	mov    0x4(%eax),%eax
  800834:	39 c2                	cmp    %eax,%edx
  800836:	73 12                	jae    80084a <sprintputch+0x33>
		*b->buf++ = ch;
  800838:	8b 45 0c             	mov    0xc(%ebp),%eax
  80083b:	8b 00                	mov    (%eax),%eax
  80083d:	8d 48 01             	lea    0x1(%eax),%ecx
  800840:	8b 55 0c             	mov    0xc(%ebp),%edx
  800843:	89 0a                	mov    %ecx,(%edx)
  800845:	8b 55 08             	mov    0x8(%ebp),%edx
  800848:	88 10                	mov    %dl,(%eax)
}
  80084a:	90                   	nop
  80084b:	5d                   	pop    %ebp
  80084c:	c3                   	ret    

0080084d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80084d:	55                   	push   %ebp
  80084e:	89 e5                	mov    %esp,%ebp
  800850:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800853:	8b 45 08             	mov    0x8(%ebp),%eax
  800856:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800859:	8b 45 0c             	mov    0xc(%ebp),%eax
  80085c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80085f:	8b 45 08             	mov    0x8(%ebp),%eax
  800862:	01 d0                	add    %edx,%eax
  800864:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800867:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80086e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800872:	74 06                	je     80087a <vsnprintf+0x2d>
  800874:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800878:	7f 07                	jg     800881 <vsnprintf+0x34>
		return -E_INVAL;
  80087a:	b8 03 00 00 00       	mov    $0x3,%eax
  80087f:	eb 20                	jmp    8008a1 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800881:	ff 75 14             	pushl  0x14(%ebp)
  800884:	ff 75 10             	pushl  0x10(%ebp)
  800887:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80088a:	50                   	push   %eax
  80088b:	68 17 08 80 00       	push   $0x800817
  800890:	e8 92 fb ff ff       	call   800427 <vprintfmt>
  800895:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800898:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80089b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80089e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008a1:	c9                   	leave  
  8008a2:	c3                   	ret    

008008a3 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008a3:	55                   	push   %ebp
  8008a4:	89 e5                	mov    %esp,%ebp
  8008a6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008a9:	8d 45 10             	lea    0x10(%ebp),%eax
  8008ac:	83 c0 04             	add    $0x4,%eax
  8008af:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8008b5:	ff 75 f4             	pushl  -0xc(%ebp)
  8008b8:	50                   	push   %eax
  8008b9:	ff 75 0c             	pushl  0xc(%ebp)
  8008bc:	ff 75 08             	pushl  0x8(%ebp)
  8008bf:	e8 89 ff ff ff       	call   80084d <vsnprintf>
  8008c4:	83 c4 10             	add    $0x10,%esp
  8008c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008cd:	c9                   	leave  
  8008ce:	c3                   	ret    

008008cf <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008cf:	55                   	push   %ebp
  8008d0:	89 e5                	mov    %esp,%ebp
  8008d2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8008d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008dc:	eb 06                	jmp    8008e4 <strlen+0x15>
		n++;
  8008de:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8008e1:	ff 45 08             	incl   0x8(%ebp)
  8008e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e7:	8a 00                	mov    (%eax),%al
  8008e9:	84 c0                	test   %al,%al
  8008eb:	75 f1                	jne    8008de <strlen+0xf>
		n++;
	return n;
  8008ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8008f0:	c9                   	leave  
  8008f1:	c3                   	ret    

008008f2 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8008f2:	55                   	push   %ebp
  8008f3:	89 e5                	mov    %esp,%ebp
  8008f5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008ff:	eb 09                	jmp    80090a <strnlen+0x18>
		n++;
  800901:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800904:	ff 45 08             	incl   0x8(%ebp)
  800907:	ff 4d 0c             	decl   0xc(%ebp)
  80090a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80090e:	74 09                	je     800919 <strnlen+0x27>
  800910:	8b 45 08             	mov    0x8(%ebp),%eax
  800913:	8a 00                	mov    (%eax),%al
  800915:	84 c0                	test   %al,%al
  800917:	75 e8                	jne    800901 <strnlen+0xf>
		n++;
	return n;
  800919:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80091c:	c9                   	leave  
  80091d:	c3                   	ret    

0080091e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80091e:	55                   	push   %ebp
  80091f:	89 e5                	mov    %esp,%ebp
  800921:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800924:	8b 45 08             	mov    0x8(%ebp),%eax
  800927:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80092a:	90                   	nop
  80092b:	8b 45 08             	mov    0x8(%ebp),%eax
  80092e:	8d 50 01             	lea    0x1(%eax),%edx
  800931:	89 55 08             	mov    %edx,0x8(%ebp)
  800934:	8b 55 0c             	mov    0xc(%ebp),%edx
  800937:	8d 4a 01             	lea    0x1(%edx),%ecx
  80093a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80093d:	8a 12                	mov    (%edx),%dl
  80093f:	88 10                	mov    %dl,(%eax)
  800941:	8a 00                	mov    (%eax),%al
  800943:	84 c0                	test   %al,%al
  800945:	75 e4                	jne    80092b <strcpy+0xd>
		/* do nothing */;
	return ret;
  800947:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80094a:	c9                   	leave  
  80094b:	c3                   	ret    

0080094c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80094c:	55                   	push   %ebp
  80094d:	89 e5                	mov    %esp,%ebp
  80094f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800952:	8b 45 08             	mov    0x8(%ebp),%eax
  800955:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800958:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80095f:	eb 1f                	jmp    800980 <strncpy+0x34>
		*dst++ = *src;
  800961:	8b 45 08             	mov    0x8(%ebp),%eax
  800964:	8d 50 01             	lea    0x1(%eax),%edx
  800967:	89 55 08             	mov    %edx,0x8(%ebp)
  80096a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80096d:	8a 12                	mov    (%edx),%dl
  80096f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800971:	8b 45 0c             	mov    0xc(%ebp),%eax
  800974:	8a 00                	mov    (%eax),%al
  800976:	84 c0                	test   %al,%al
  800978:	74 03                	je     80097d <strncpy+0x31>
			src++;
  80097a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80097d:	ff 45 fc             	incl   -0x4(%ebp)
  800980:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800983:	3b 45 10             	cmp    0x10(%ebp),%eax
  800986:	72 d9                	jb     800961 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800988:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80098b:	c9                   	leave  
  80098c:	c3                   	ret    

0080098d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80098d:	55                   	push   %ebp
  80098e:	89 e5                	mov    %esp,%ebp
  800990:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800993:	8b 45 08             	mov    0x8(%ebp),%eax
  800996:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800999:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80099d:	74 30                	je     8009cf <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80099f:	eb 16                	jmp    8009b7 <strlcpy+0x2a>
			*dst++ = *src++;
  8009a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a4:	8d 50 01             	lea    0x1(%eax),%edx
  8009a7:	89 55 08             	mov    %edx,0x8(%ebp)
  8009aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009ad:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009b0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009b3:	8a 12                	mov    (%edx),%dl
  8009b5:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009b7:	ff 4d 10             	decl   0x10(%ebp)
  8009ba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009be:	74 09                	je     8009c9 <strlcpy+0x3c>
  8009c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c3:	8a 00                	mov    (%eax),%al
  8009c5:	84 c0                	test   %al,%al
  8009c7:	75 d8                	jne    8009a1 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cc:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009cf:	8b 55 08             	mov    0x8(%ebp),%edx
  8009d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009d5:	29 c2                	sub    %eax,%edx
  8009d7:	89 d0                	mov    %edx,%eax
}
  8009d9:	c9                   	leave  
  8009da:	c3                   	ret    

008009db <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8009db:	55                   	push   %ebp
  8009dc:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8009de:	eb 06                	jmp    8009e6 <strcmp+0xb>
		p++, q++;
  8009e0:	ff 45 08             	incl   0x8(%ebp)
  8009e3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8009e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e9:	8a 00                	mov    (%eax),%al
  8009eb:	84 c0                	test   %al,%al
  8009ed:	74 0e                	je     8009fd <strcmp+0x22>
  8009ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f2:	8a 10                	mov    (%eax),%dl
  8009f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f7:	8a 00                	mov    (%eax),%al
  8009f9:	38 c2                	cmp    %al,%dl
  8009fb:	74 e3                	je     8009e0 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8009fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800a00:	8a 00                	mov    (%eax),%al
  800a02:	0f b6 d0             	movzbl %al,%edx
  800a05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a08:	8a 00                	mov    (%eax),%al
  800a0a:	0f b6 c0             	movzbl %al,%eax
  800a0d:	29 c2                	sub    %eax,%edx
  800a0f:	89 d0                	mov    %edx,%eax
}
  800a11:	5d                   	pop    %ebp
  800a12:	c3                   	ret    

00800a13 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a13:	55                   	push   %ebp
  800a14:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a16:	eb 09                	jmp    800a21 <strncmp+0xe>
		n--, p++, q++;
  800a18:	ff 4d 10             	decl   0x10(%ebp)
  800a1b:	ff 45 08             	incl   0x8(%ebp)
  800a1e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a21:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a25:	74 17                	je     800a3e <strncmp+0x2b>
  800a27:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2a:	8a 00                	mov    (%eax),%al
  800a2c:	84 c0                	test   %al,%al
  800a2e:	74 0e                	je     800a3e <strncmp+0x2b>
  800a30:	8b 45 08             	mov    0x8(%ebp),%eax
  800a33:	8a 10                	mov    (%eax),%dl
  800a35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a38:	8a 00                	mov    (%eax),%al
  800a3a:	38 c2                	cmp    %al,%dl
  800a3c:	74 da                	je     800a18 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a3e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a42:	75 07                	jne    800a4b <strncmp+0x38>
		return 0;
  800a44:	b8 00 00 00 00       	mov    $0x0,%eax
  800a49:	eb 14                	jmp    800a5f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4e:	8a 00                	mov    (%eax),%al
  800a50:	0f b6 d0             	movzbl %al,%edx
  800a53:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a56:	8a 00                	mov    (%eax),%al
  800a58:	0f b6 c0             	movzbl %al,%eax
  800a5b:	29 c2                	sub    %eax,%edx
  800a5d:	89 d0                	mov    %edx,%eax
}
  800a5f:	5d                   	pop    %ebp
  800a60:	c3                   	ret    

00800a61 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a61:	55                   	push   %ebp
  800a62:	89 e5                	mov    %esp,%ebp
  800a64:	83 ec 04             	sub    $0x4,%esp
  800a67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a6d:	eb 12                	jmp    800a81 <strchr+0x20>
		if (*s == c)
  800a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a72:	8a 00                	mov    (%eax),%al
  800a74:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a77:	75 05                	jne    800a7e <strchr+0x1d>
			return (char *) s;
  800a79:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7c:	eb 11                	jmp    800a8f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800a7e:	ff 45 08             	incl   0x8(%ebp)
  800a81:	8b 45 08             	mov    0x8(%ebp),%eax
  800a84:	8a 00                	mov    (%eax),%al
  800a86:	84 c0                	test   %al,%al
  800a88:	75 e5                	jne    800a6f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800a8a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800a8f:	c9                   	leave  
  800a90:	c3                   	ret    

00800a91 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800a91:	55                   	push   %ebp
  800a92:	89 e5                	mov    %esp,%ebp
  800a94:	83 ec 04             	sub    $0x4,%esp
  800a97:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a9d:	eb 0d                	jmp    800aac <strfind+0x1b>
		if (*s == c)
  800a9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa2:	8a 00                	mov    (%eax),%al
  800aa4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800aa7:	74 0e                	je     800ab7 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800aa9:	ff 45 08             	incl   0x8(%ebp)
  800aac:	8b 45 08             	mov    0x8(%ebp),%eax
  800aaf:	8a 00                	mov    (%eax),%al
  800ab1:	84 c0                	test   %al,%al
  800ab3:	75 ea                	jne    800a9f <strfind+0xe>
  800ab5:	eb 01                	jmp    800ab8 <strfind+0x27>
		if (*s == c)
			break;
  800ab7:	90                   	nop
	return (char *) s;
  800ab8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800abb:	c9                   	leave  
  800abc:	c3                   	ret    

00800abd <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800abd:	55                   	push   %ebp
  800abe:	89 e5                	mov    %esp,%ebp
  800ac0:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ac9:	8b 45 10             	mov    0x10(%ebp),%eax
  800acc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800acf:	eb 0e                	jmp    800adf <memset+0x22>
		*p++ = c;
  800ad1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ad4:	8d 50 01             	lea    0x1(%eax),%edx
  800ad7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ada:	8b 55 0c             	mov    0xc(%ebp),%edx
  800add:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800adf:	ff 4d f8             	decl   -0x8(%ebp)
  800ae2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ae6:	79 e9                	jns    800ad1 <memset+0x14>
		*p++ = c;

	return v;
  800ae8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800aeb:	c9                   	leave  
  800aec:	c3                   	ret    

00800aed <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800aed:	55                   	push   %ebp
  800aee:	89 e5                	mov    %esp,%ebp
  800af0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800af3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800af9:	8b 45 08             	mov    0x8(%ebp),%eax
  800afc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800aff:	eb 16                	jmp    800b17 <memcpy+0x2a>
		*d++ = *s++;
  800b01:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b04:	8d 50 01             	lea    0x1(%eax),%edx
  800b07:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b0a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b0d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b10:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b13:	8a 12                	mov    (%edx),%dl
  800b15:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b17:	8b 45 10             	mov    0x10(%ebp),%eax
  800b1a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b1d:	89 55 10             	mov    %edx,0x10(%ebp)
  800b20:	85 c0                	test   %eax,%eax
  800b22:	75 dd                	jne    800b01 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b24:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b27:	c9                   	leave  
  800b28:	c3                   	ret    

00800b29 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b29:	55                   	push   %ebp
  800b2a:	89 e5                	mov    %esp,%ebp
  800b2c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b32:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b35:	8b 45 08             	mov    0x8(%ebp),%eax
  800b38:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b3b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b3e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b41:	73 50                	jae    800b93 <memmove+0x6a>
  800b43:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b46:	8b 45 10             	mov    0x10(%ebp),%eax
  800b49:	01 d0                	add    %edx,%eax
  800b4b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b4e:	76 43                	jbe    800b93 <memmove+0x6a>
		s += n;
  800b50:	8b 45 10             	mov    0x10(%ebp),%eax
  800b53:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b56:	8b 45 10             	mov    0x10(%ebp),%eax
  800b59:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b5c:	eb 10                	jmp    800b6e <memmove+0x45>
			*--d = *--s;
  800b5e:	ff 4d f8             	decl   -0x8(%ebp)
  800b61:	ff 4d fc             	decl   -0x4(%ebp)
  800b64:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b67:	8a 10                	mov    (%eax),%dl
  800b69:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b6c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b6e:	8b 45 10             	mov    0x10(%ebp),%eax
  800b71:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b74:	89 55 10             	mov    %edx,0x10(%ebp)
  800b77:	85 c0                	test   %eax,%eax
  800b79:	75 e3                	jne    800b5e <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800b7b:	eb 23                	jmp    800ba0 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800b7d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b80:	8d 50 01             	lea    0x1(%eax),%edx
  800b83:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b86:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b89:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b8c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b8f:	8a 12                	mov    (%edx),%dl
  800b91:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800b93:	8b 45 10             	mov    0x10(%ebp),%eax
  800b96:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b99:	89 55 10             	mov    %edx,0x10(%ebp)
  800b9c:	85 c0                	test   %eax,%eax
  800b9e:	75 dd                	jne    800b7d <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ba0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ba3:	c9                   	leave  
  800ba4:	c3                   	ret    

00800ba5 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ba5:	55                   	push   %ebp
  800ba6:	89 e5                	mov    %esp,%ebp
  800ba8:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bab:	8b 45 08             	mov    0x8(%ebp),%eax
  800bae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bb1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb4:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bb7:	eb 2a                	jmp    800be3 <memcmp+0x3e>
		if (*s1 != *s2)
  800bb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bbc:	8a 10                	mov    (%eax),%dl
  800bbe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bc1:	8a 00                	mov    (%eax),%al
  800bc3:	38 c2                	cmp    %al,%dl
  800bc5:	74 16                	je     800bdd <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bc7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bca:	8a 00                	mov    (%eax),%al
  800bcc:	0f b6 d0             	movzbl %al,%edx
  800bcf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bd2:	8a 00                	mov    (%eax),%al
  800bd4:	0f b6 c0             	movzbl %al,%eax
  800bd7:	29 c2                	sub    %eax,%edx
  800bd9:	89 d0                	mov    %edx,%eax
  800bdb:	eb 18                	jmp    800bf5 <memcmp+0x50>
		s1++, s2++;
  800bdd:	ff 45 fc             	incl   -0x4(%ebp)
  800be0:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800be3:	8b 45 10             	mov    0x10(%ebp),%eax
  800be6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800be9:	89 55 10             	mov    %edx,0x10(%ebp)
  800bec:	85 c0                	test   %eax,%eax
  800bee:	75 c9                	jne    800bb9 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800bf0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800bf5:	c9                   	leave  
  800bf6:	c3                   	ret    

00800bf7 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800bf7:	55                   	push   %ebp
  800bf8:	89 e5                	mov    %esp,%ebp
  800bfa:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800bfd:	8b 55 08             	mov    0x8(%ebp),%edx
  800c00:	8b 45 10             	mov    0x10(%ebp),%eax
  800c03:	01 d0                	add    %edx,%eax
  800c05:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c08:	eb 15                	jmp    800c1f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0d:	8a 00                	mov    (%eax),%al
  800c0f:	0f b6 d0             	movzbl %al,%edx
  800c12:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c15:	0f b6 c0             	movzbl %al,%eax
  800c18:	39 c2                	cmp    %eax,%edx
  800c1a:	74 0d                	je     800c29 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c1c:	ff 45 08             	incl   0x8(%ebp)
  800c1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c22:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c25:	72 e3                	jb     800c0a <memfind+0x13>
  800c27:	eb 01                	jmp    800c2a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c29:	90                   	nop
	return (void *) s;
  800c2a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c2d:	c9                   	leave  
  800c2e:	c3                   	ret    

00800c2f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c2f:	55                   	push   %ebp
  800c30:	89 e5                	mov    %esp,%ebp
  800c32:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c35:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c3c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c43:	eb 03                	jmp    800c48 <strtol+0x19>
		s++;
  800c45:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c48:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4b:	8a 00                	mov    (%eax),%al
  800c4d:	3c 20                	cmp    $0x20,%al
  800c4f:	74 f4                	je     800c45 <strtol+0x16>
  800c51:	8b 45 08             	mov    0x8(%ebp),%eax
  800c54:	8a 00                	mov    (%eax),%al
  800c56:	3c 09                	cmp    $0x9,%al
  800c58:	74 eb                	je     800c45 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5d:	8a 00                	mov    (%eax),%al
  800c5f:	3c 2b                	cmp    $0x2b,%al
  800c61:	75 05                	jne    800c68 <strtol+0x39>
		s++;
  800c63:	ff 45 08             	incl   0x8(%ebp)
  800c66:	eb 13                	jmp    800c7b <strtol+0x4c>
	else if (*s == '-')
  800c68:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6b:	8a 00                	mov    (%eax),%al
  800c6d:	3c 2d                	cmp    $0x2d,%al
  800c6f:	75 0a                	jne    800c7b <strtol+0x4c>
		s++, neg = 1;
  800c71:	ff 45 08             	incl   0x8(%ebp)
  800c74:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800c7b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c7f:	74 06                	je     800c87 <strtol+0x58>
  800c81:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800c85:	75 20                	jne    800ca7 <strtol+0x78>
  800c87:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8a:	8a 00                	mov    (%eax),%al
  800c8c:	3c 30                	cmp    $0x30,%al
  800c8e:	75 17                	jne    800ca7 <strtol+0x78>
  800c90:	8b 45 08             	mov    0x8(%ebp),%eax
  800c93:	40                   	inc    %eax
  800c94:	8a 00                	mov    (%eax),%al
  800c96:	3c 78                	cmp    $0x78,%al
  800c98:	75 0d                	jne    800ca7 <strtol+0x78>
		s += 2, base = 16;
  800c9a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800c9e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800ca5:	eb 28                	jmp    800ccf <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ca7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cab:	75 15                	jne    800cc2 <strtol+0x93>
  800cad:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb0:	8a 00                	mov    (%eax),%al
  800cb2:	3c 30                	cmp    $0x30,%al
  800cb4:	75 0c                	jne    800cc2 <strtol+0x93>
		s++, base = 8;
  800cb6:	ff 45 08             	incl   0x8(%ebp)
  800cb9:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cc0:	eb 0d                	jmp    800ccf <strtol+0xa0>
	else if (base == 0)
  800cc2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc6:	75 07                	jne    800ccf <strtol+0xa0>
		base = 10;
  800cc8:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd2:	8a 00                	mov    (%eax),%al
  800cd4:	3c 2f                	cmp    $0x2f,%al
  800cd6:	7e 19                	jle    800cf1 <strtol+0xc2>
  800cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdb:	8a 00                	mov    (%eax),%al
  800cdd:	3c 39                	cmp    $0x39,%al
  800cdf:	7f 10                	jg     800cf1 <strtol+0xc2>
			dig = *s - '0';
  800ce1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce4:	8a 00                	mov    (%eax),%al
  800ce6:	0f be c0             	movsbl %al,%eax
  800ce9:	83 e8 30             	sub    $0x30,%eax
  800cec:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800cef:	eb 42                	jmp    800d33 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf4:	8a 00                	mov    (%eax),%al
  800cf6:	3c 60                	cmp    $0x60,%al
  800cf8:	7e 19                	jle    800d13 <strtol+0xe4>
  800cfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfd:	8a 00                	mov    (%eax),%al
  800cff:	3c 7a                	cmp    $0x7a,%al
  800d01:	7f 10                	jg     800d13 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d03:	8b 45 08             	mov    0x8(%ebp),%eax
  800d06:	8a 00                	mov    (%eax),%al
  800d08:	0f be c0             	movsbl %al,%eax
  800d0b:	83 e8 57             	sub    $0x57,%eax
  800d0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d11:	eb 20                	jmp    800d33 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
  800d16:	8a 00                	mov    (%eax),%al
  800d18:	3c 40                	cmp    $0x40,%al
  800d1a:	7e 39                	jle    800d55 <strtol+0x126>
  800d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1f:	8a 00                	mov    (%eax),%al
  800d21:	3c 5a                	cmp    $0x5a,%al
  800d23:	7f 30                	jg     800d55 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d25:	8b 45 08             	mov    0x8(%ebp),%eax
  800d28:	8a 00                	mov    (%eax),%al
  800d2a:	0f be c0             	movsbl %al,%eax
  800d2d:	83 e8 37             	sub    $0x37,%eax
  800d30:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d33:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d36:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d39:	7d 19                	jge    800d54 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d3b:	ff 45 08             	incl   0x8(%ebp)
  800d3e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d41:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d45:	89 c2                	mov    %eax,%edx
  800d47:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d4a:	01 d0                	add    %edx,%eax
  800d4c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d4f:	e9 7b ff ff ff       	jmp    800ccf <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d54:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d55:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d59:	74 08                	je     800d63 <strtol+0x134>
		*endptr = (char *) s;
  800d5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5e:	8b 55 08             	mov    0x8(%ebp),%edx
  800d61:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d63:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d67:	74 07                	je     800d70 <strtol+0x141>
  800d69:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d6c:	f7 d8                	neg    %eax
  800d6e:	eb 03                	jmp    800d73 <strtol+0x144>
  800d70:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d73:	c9                   	leave  
  800d74:	c3                   	ret    

00800d75 <ltostr>:

void
ltostr(long value, char *str)
{
  800d75:	55                   	push   %ebp
  800d76:	89 e5                	mov    %esp,%ebp
  800d78:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800d7b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800d82:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800d89:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d8d:	79 13                	jns    800da2 <ltostr+0x2d>
	{
		neg = 1;
  800d8f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800d96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d99:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800d9c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800d9f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800da2:	8b 45 08             	mov    0x8(%ebp),%eax
  800da5:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800daa:	99                   	cltd   
  800dab:	f7 f9                	idiv   %ecx
  800dad:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800db0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db3:	8d 50 01             	lea    0x1(%eax),%edx
  800db6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800db9:	89 c2                	mov    %eax,%edx
  800dbb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbe:	01 d0                	add    %edx,%eax
  800dc0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dc3:	83 c2 30             	add    $0x30,%edx
  800dc6:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800dc8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dcb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dd0:	f7 e9                	imul   %ecx
  800dd2:	c1 fa 02             	sar    $0x2,%edx
  800dd5:	89 c8                	mov    %ecx,%eax
  800dd7:	c1 f8 1f             	sar    $0x1f,%eax
  800dda:	29 c2                	sub    %eax,%edx
  800ddc:	89 d0                	mov    %edx,%eax
  800dde:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800de1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800de4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800de9:	f7 e9                	imul   %ecx
  800deb:	c1 fa 02             	sar    $0x2,%edx
  800dee:	89 c8                	mov    %ecx,%eax
  800df0:	c1 f8 1f             	sar    $0x1f,%eax
  800df3:	29 c2                	sub    %eax,%edx
  800df5:	89 d0                	mov    %edx,%eax
  800df7:	c1 e0 02             	shl    $0x2,%eax
  800dfa:	01 d0                	add    %edx,%eax
  800dfc:	01 c0                	add    %eax,%eax
  800dfe:	29 c1                	sub    %eax,%ecx
  800e00:	89 ca                	mov    %ecx,%edx
  800e02:	85 d2                	test   %edx,%edx
  800e04:	75 9c                	jne    800da2 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e06:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e0d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e10:	48                   	dec    %eax
  800e11:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e14:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e18:	74 3d                	je     800e57 <ltostr+0xe2>
		start = 1 ;
  800e1a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e21:	eb 34                	jmp    800e57 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e23:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e29:	01 d0                	add    %edx,%eax
  800e2b:	8a 00                	mov    (%eax),%al
  800e2d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e30:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e36:	01 c2                	add    %eax,%edx
  800e38:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3e:	01 c8                	add    %ecx,%eax
  800e40:	8a 00                	mov    (%eax),%al
  800e42:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e44:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4a:	01 c2                	add    %eax,%edx
  800e4c:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e4f:	88 02                	mov    %al,(%edx)
		start++ ;
  800e51:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e54:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e57:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e5a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e5d:	7c c4                	jl     800e23 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e5f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e65:	01 d0                	add    %edx,%eax
  800e67:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e6a:	90                   	nop
  800e6b:	c9                   	leave  
  800e6c:	c3                   	ret    

00800e6d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e6d:	55                   	push   %ebp
  800e6e:	89 e5                	mov    %esp,%ebp
  800e70:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e73:	ff 75 08             	pushl  0x8(%ebp)
  800e76:	e8 54 fa ff ff       	call   8008cf <strlen>
  800e7b:	83 c4 04             	add    $0x4,%esp
  800e7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800e81:	ff 75 0c             	pushl  0xc(%ebp)
  800e84:	e8 46 fa ff ff       	call   8008cf <strlen>
  800e89:	83 c4 04             	add    $0x4,%esp
  800e8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800e8f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800e96:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e9d:	eb 17                	jmp    800eb6 <strcconcat+0x49>
		final[s] = str1[s] ;
  800e9f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ea2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea5:	01 c2                	add    %eax,%edx
  800ea7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800eaa:	8b 45 08             	mov    0x8(%ebp),%eax
  800ead:	01 c8                	add    %ecx,%eax
  800eaf:	8a 00                	mov    (%eax),%al
  800eb1:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800eb3:	ff 45 fc             	incl   -0x4(%ebp)
  800eb6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eb9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ebc:	7c e1                	jl     800e9f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ebe:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ec5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800ecc:	eb 1f                	jmp    800eed <strcconcat+0x80>
		final[s++] = str2[i] ;
  800ece:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ed1:	8d 50 01             	lea    0x1(%eax),%edx
  800ed4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ed7:	89 c2                	mov    %eax,%edx
  800ed9:	8b 45 10             	mov    0x10(%ebp),%eax
  800edc:	01 c2                	add    %eax,%edx
  800ede:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800ee1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee4:	01 c8                	add    %ecx,%eax
  800ee6:	8a 00                	mov    (%eax),%al
  800ee8:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800eea:	ff 45 f8             	incl   -0x8(%ebp)
  800eed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ef0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ef3:	7c d9                	jl     800ece <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800ef5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ef8:	8b 45 10             	mov    0x10(%ebp),%eax
  800efb:	01 d0                	add    %edx,%eax
  800efd:	c6 00 00             	movb   $0x0,(%eax)
}
  800f00:	90                   	nop
  800f01:	c9                   	leave  
  800f02:	c3                   	ret    

00800f03 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f03:	55                   	push   %ebp
  800f04:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f06:	8b 45 14             	mov    0x14(%ebp),%eax
  800f09:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f0f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f12:	8b 00                	mov    (%eax),%eax
  800f14:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f1b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1e:	01 d0                	add    %edx,%eax
  800f20:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f26:	eb 0c                	jmp    800f34 <strsplit+0x31>
			*string++ = 0;
  800f28:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2b:	8d 50 01             	lea    0x1(%eax),%edx
  800f2e:	89 55 08             	mov    %edx,0x8(%ebp)
  800f31:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f34:	8b 45 08             	mov    0x8(%ebp),%eax
  800f37:	8a 00                	mov    (%eax),%al
  800f39:	84 c0                	test   %al,%al
  800f3b:	74 18                	je     800f55 <strsplit+0x52>
  800f3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f40:	8a 00                	mov    (%eax),%al
  800f42:	0f be c0             	movsbl %al,%eax
  800f45:	50                   	push   %eax
  800f46:	ff 75 0c             	pushl  0xc(%ebp)
  800f49:	e8 13 fb ff ff       	call   800a61 <strchr>
  800f4e:	83 c4 08             	add    $0x8,%esp
  800f51:	85 c0                	test   %eax,%eax
  800f53:	75 d3                	jne    800f28 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800f55:	8b 45 08             	mov    0x8(%ebp),%eax
  800f58:	8a 00                	mov    (%eax),%al
  800f5a:	84 c0                	test   %al,%al
  800f5c:	74 5a                	je     800fb8 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800f5e:	8b 45 14             	mov    0x14(%ebp),%eax
  800f61:	8b 00                	mov    (%eax),%eax
  800f63:	83 f8 0f             	cmp    $0xf,%eax
  800f66:	75 07                	jne    800f6f <strsplit+0x6c>
		{
			return 0;
  800f68:	b8 00 00 00 00       	mov    $0x0,%eax
  800f6d:	eb 66                	jmp    800fd5 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f6f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f72:	8b 00                	mov    (%eax),%eax
  800f74:	8d 48 01             	lea    0x1(%eax),%ecx
  800f77:	8b 55 14             	mov    0x14(%ebp),%edx
  800f7a:	89 0a                	mov    %ecx,(%edx)
  800f7c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f83:	8b 45 10             	mov    0x10(%ebp),%eax
  800f86:	01 c2                	add    %eax,%edx
  800f88:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f8d:	eb 03                	jmp    800f92 <strsplit+0x8f>
			string++;
  800f8f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f92:	8b 45 08             	mov    0x8(%ebp),%eax
  800f95:	8a 00                	mov    (%eax),%al
  800f97:	84 c0                	test   %al,%al
  800f99:	74 8b                	je     800f26 <strsplit+0x23>
  800f9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9e:	8a 00                	mov    (%eax),%al
  800fa0:	0f be c0             	movsbl %al,%eax
  800fa3:	50                   	push   %eax
  800fa4:	ff 75 0c             	pushl  0xc(%ebp)
  800fa7:	e8 b5 fa ff ff       	call   800a61 <strchr>
  800fac:	83 c4 08             	add    $0x8,%esp
  800faf:	85 c0                	test   %eax,%eax
  800fb1:	74 dc                	je     800f8f <strsplit+0x8c>
			string++;
	}
  800fb3:	e9 6e ff ff ff       	jmp    800f26 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800fb8:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fb9:	8b 45 14             	mov    0x14(%ebp),%eax
  800fbc:	8b 00                	mov    (%eax),%eax
  800fbe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fc5:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc8:	01 d0                	add    %edx,%eax
  800fca:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800fd0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800fd5:	c9                   	leave  
  800fd6:	c3                   	ret    

00800fd7 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  800fd7:	55                   	push   %ebp
  800fd8:	89 e5                	mov    %esp,%ebp
  800fda:	57                   	push   %edi
  800fdb:	56                   	push   %esi
  800fdc:	53                   	push   %ebx
  800fdd:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800fe0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fe6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800fe9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  800fec:	8b 7d 18             	mov    0x18(%ebp),%edi
  800fef:	8b 75 1c             	mov    0x1c(%ebp),%esi
  800ff2:	cd 30                	int    $0x30
  800ff4:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  800ff7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ffa:	83 c4 10             	add    $0x10,%esp
  800ffd:	5b                   	pop    %ebx
  800ffe:	5e                   	pop    %esi
  800fff:	5f                   	pop    %edi
  801000:	5d                   	pop    %ebp
  801001:	c3                   	ret    

00801002 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801002:	55                   	push   %ebp
  801003:	89 e5                	mov    %esp,%ebp
  801005:	83 ec 04             	sub    $0x4,%esp
  801008:	8b 45 10             	mov    0x10(%ebp),%eax
  80100b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80100e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801012:	8b 45 08             	mov    0x8(%ebp),%eax
  801015:	6a 00                	push   $0x0
  801017:	6a 00                	push   $0x0
  801019:	52                   	push   %edx
  80101a:	ff 75 0c             	pushl  0xc(%ebp)
  80101d:	50                   	push   %eax
  80101e:	6a 00                	push   $0x0
  801020:	e8 b2 ff ff ff       	call   800fd7 <syscall>
  801025:	83 c4 18             	add    $0x18,%esp
}
  801028:	90                   	nop
  801029:	c9                   	leave  
  80102a:	c3                   	ret    

0080102b <sys_cgetc>:

int
sys_cgetc(void)
{
  80102b:	55                   	push   %ebp
  80102c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80102e:	6a 00                	push   $0x0
  801030:	6a 00                	push   $0x0
  801032:	6a 00                	push   $0x0
  801034:	6a 00                	push   $0x0
  801036:	6a 00                	push   $0x0
  801038:	6a 01                	push   $0x1
  80103a:	e8 98 ff ff ff       	call   800fd7 <syscall>
  80103f:	83 c4 18             	add    $0x18,%esp
}
  801042:	c9                   	leave  
  801043:	c3                   	ret    

00801044 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801044:	55                   	push   %ebp
  801045:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801047:	8b 45 08             	mov    0x8(%ebp),%eax
  80104a:	6a 00                	push   $0x0
  80104c:	6a 00                	push   $0x0
  80104e:	6a 00                	push   $0x0
  801050:	6a 00                	push   $0x0
  801052:	50                   	push   %eax
  801053:	6a 05                	push   $0x5
  801055:	e8 7d ff ff ff       	call   800fd7 <syscall>
  80105a:	83 c4 18             	add    $0x18,%esp
}
  80105d:	c9                   	leave  
  80105e:	c3                   	ret    

0080105f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80105f:	55                   	push   %ebp
  801060:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801062:	6a 00                	push   $0x0
  801064:	6a 00                	push   $0x0
  801066:	6a 00                	push   $0x0
  801068:	6a 00                	push   $0x0
  80106a:	6a 00                	push   $0x0
  80106c:	6a 02                	push   $0x2
  80106e:	e8 64 ff ff ff       	call   800fd7 <syscall>
  801073:	83 c4 18             	add    $0x18,%esp
}
  801076:	c9                   	leave  
  801077:	c3                   	ret    

00801078 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801078:	55                   	push   %ebp
  801079:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80107b:	6a 00                	push   $0x0
  80107d:	6a 00                	push   $0x0
  80107f:	6a 00                	push   $0x0
  801081:	6a 00                	push   $0x0
  801083:	6a 00                	push   $0x0
  801085:	6a 03                	push   $0x3
  801087:	e8 4b ff ff ff       	call   800fd7 <syscall>
  80108c:	83 c4 18             	add    $0x18,%esp
}
  80108f:	c9                   	leave  
  801090:	c3                   	ret    

00801091 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801091:	55                   	push   %ebp
  801092:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801094:	6a 00                	push   $0x0
  801096:	6a 00                	push   $0x0
  801098:	6a 00                	push   $0x0
  80109a:	6a 00                	push   $0x0
  80109c:	6a 00                	push   $0x0
  80109e:	6a 04                	push   $0x4
  8010a0:	e8 32 ff ff ff       	call   800fd7 <syscall>
  8010a5:	83 c4 18             	add    $0x18,%esp
}
  8010a8:	c9                   	leave  
  8010a9:	c3                   	ret    

008010aa <sys_env_exit>:


void sys_env_exit(void)
{
  8010aa:	55                   	push   %ebp
  8010ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010ad:	6a 00                	push   $0x0
  8010af:	6a 00                	push   $0x0
  8010b1:	6a 00                	push   $0x0
  8010b3:	6a 00                	push   $0x0
  8010b5:	6a 00                	push   $0x0
  8010b7:	6a 06                	push   $0x6
  8010b9:	e8 19 ff ff ff       	call   800fd7 <syscall>
  8010be:	83 c4 18             	add    $0x18,%esp
}
  8010c1:	90                   	nop
  8010c2:	c9                   	leave  
  8010c3:	c3                   	ret    

008010c4 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010c4:	55                   	push   %ebp
  8010c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cd:	6a 00                	push   $0x0
  8010cf:	6a 00                	push   $0x0
  8010d1:	6a 00                	push   $0x0
  8010d3:	52                   	push   %edx
  8010d4:	50                   	push   %eax
  8010d5:	6a 07                	push   $0x7
  8010d7:	e8 fb fe ff ff       	call   800fd7 <syscall>
  8010dc:	83 c4 18             	add    $0x18,%esp
}
  8010df:	c9                   	leave  
  8010e0:	c3                   	ret    

008010e1 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8010e1:	55                   	push   %ebp
  8010e2:	89 e5                	mov    %esp,%ebp
  8010e4:	56                   	push   %esi
  8010e5:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8010e6:	8b 75 18             	mov    0x18(%ebp),%esi
  8010e9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010ec:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f5:	56                   	push   %esi
  8010f6:	53                   	push   %ebx
  8010f7:	51                   	push   %ecx
  8010f8:	52                   	push   %edx
  8010f9:	50                   	push   %eax
  8010fa:	6a 08                	push   $0x8
  8010fc:	e8 d6 fe ff ff       	call   800fd7 <syscall>
  801101:	83 c4 18             	add    $0x18,%esp
}
  801104:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801107:	5b                   	pop    %ebx
  801108:	5e                   	pop    %esi
  801109:	5d                   	pop    %ebp
  80110a:	c3                   	ret    

0080110b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80110b:	55                   	push   %ebp
  80110c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80110e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801111:	8b 45 08             	mov    0x8(%ebp),%eax
  801114:	6a 00                	push   $0x0
  801116:	6a 00                	push   $0x0
  801118:	6a 00                	push   $0x0
  80111a:	52                   	push   %edx
  80111b:	50                   	push   %eax
  80111c:	6a 09                	push   $0x9
  80111e:	e8 b4 fe ff ff       	call   800fd7 <syscall>
  801123:	83 c4 18             	add    $0x18,%esp
}
  801126:	c9                   	leave  
  801127:	c3                   	ret    

00801128 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801128:	55                   	push   %ebp
  801129:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80112b:	6a 00                	push   $0x0
  80112d:	6a 00                	push   $0x0
  80112f:	6a 00                	push   $0x0
  801131:	ff 75 0c             	pushl  0xc(%ebp)
  801134:	ff 75 08             	pushl  0x8(%ebp)
  801137:	6a 0a                	push   $0xa
  801139:	e8 99 fe ff ff       	call   800fd7 <syscall>
  80113e:	83 c4 18             	add    $0x18,%esp
}
  801141:	c9                   	leave  
  801142:	c3                   	ret    

00801143 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801143:	55                   	push   %ebp
  801144:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801146:	6a 00                	push   $0x0
  801148:	6a 00                	push   $0x0
  80114a:	6a 00                	push   $0x0
  80114c:	6a 00                	push   $0x0
  80114e:	6a 00                	push   $0x0
  801150:	6a 0b                	push   $0xb
  801152:	e8 80 fe ff ff       	call   800fd7 <syscall>
  801157:	83 c4 18             	add    $0x18,%esp
}
  80115a:	c9                   	leave  
  80115b:	c3                   	ret    

0080115c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80115c:	55                   	push   %ebp
  80115d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80115f:	6a 00                	push   $0x0
  801161:	6a 00                	push   $0x0
  801163:	6a 00                	push   $0x0
  801165:	6a 00                	push   $0x0
  801167:	6a 00                	push   $0x0
  801169:	6a 0c                	push   $0xc
  80116b:	e8 67 fe ff ff       	call   800fd7 <syscall>
  801170:	83 c4 18             	add    $0x18,%esp
}
  801173:	c9                   	leave  
  801174:	c3                   	ret    

00801175 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801175:	55                   	push   %ebp
  801176:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801178:	6a 00                	push   $0x0
  80117a:	6a 00                	push   $0x0
  80117c:	6a 00                	push   $0x0
  80117e:	6a 00                	push   $0x0
  801180:	6a 00                	push   $0x0
  801182:	6a 0d                	push   $0xd
  801184:	e8 4e fe ff ff       	call   800fd7 <syscall>
  801189:	83 c4 18             	add    $0x18,%esp
}
  80118c:	c9                   	leave  
  80118d:	c3                   	ret    

0080118e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80118e:	55                   	push   %ebp
  80118f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801191:	6a 00                	push   $0x0
  801193:	6a 00                	push   $0x0
  801195:	6a 00                	push   $0x0
  801197:	ff 75 0c             	pushl  0xc(%ebp)
  80119a:	ff 75 08             	pushl  0x8(%ebp)
  80119d:	6a 11                	push   $0x11
  80119f:	e8 33 fe ff ff       	call   800fd7 <syscall>
  8011a4:	83 c4 18             	add    $0x18,%esp
	return;
  8011a7:	90                   	nop
}
  8011a8:	c9                   	leave  
  8011a9:	c3                   	ret    

008011aa <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011aa:	55                   	push   %ebp
  8011ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011ad:	6a 00                	push   $0x0
  8011af:	6a 00                	push   $0x0
  8011b1:	6a 00                	push   $0x0
  8011b3:	ff 75 0c             	pushl  0xc(%ebp)
  8011b6:	ff 75 08             	pushl  0x8(%ebp)
  8011b9:	6a 12                	push   $0x12
  8011bb:	e8 17 fe ff ff       	call   800fd7 <syscall>
  8011c0:	83 c4 18             	add    $0x18,%esp
	return ;
  8011c3:	90                   	nop
}
  8011c4:	c9                   	leave  
  8011c5:	c3                   	ret    

008011c6 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011c6:	55                   	push   %ebp
  8011c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011c9:	6a 00                	push   $0x0
  8011cb:	6a 00                	push   $0x0
  8011cd:	6a 00                	push   $0x0
  8011cf:	6a 00                	push   $0x0
  8011d1:	6a 00                	push   $0x0
  8011d3:	6a 0e                	push   $0xe
  8011d5:	e8 fd fd ff ff       	call   800fd7 <syscall>
  8011da:	83 c4 18             	add    $0x18,%esp
}
  8011dd:	c9                   	leave  
  8011de:	c3                   	ret    

008011df <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8011df:	55                   	push   %ebp
  8011e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8011e2:	6a 00                	push   $0x0
  8011e4:	6a 00                	push   $0x0
  8011e6:	6a 00                	push   $0x0
  8011e8:	6a 00                	push   $0x0
  8011ea:	ff 75 08             	pushl  0x8(%ebp)
  8011ed:	6a 0f                	push   $0xf
  8011ef:	e8 e3 fd ff ff       	call   800fd7 <syscall>
  8011f4:	83 c4 18             	add    $0x18,%esp
}
  8011f7:	c9                   	leave  
  8011f8:	c3                   	ret    

008011f9 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8011f9:	55                   	push   %ebp
  8011fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8011fc:	6a 00                	push   $0x0
  8011fe:	6a 00                	push   $0x0
  801200:	6a 00                	push   $0x0
  801202:	6a 00                	push   $0x0
  801204:	6a 00                	push   $0x0
  801206:	6a 10                	push   $0x10
  801208:	e8 ca fd ff ff       	call   800fd7 <syscall>
  80120d:	83 c4 18             	add    $0x18,%esp
}
  801210:	90                   	nop
  801211:	c9                   	leave  
  801212:	c3                   	ret    

00801213 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801213:	55                   	push   %ebp
  801214:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801216:	6a 00                	push   $0x0
  801218:	6a 00                	push   $0x0
  80121a:	6a 00                	push   $0x0
  80121c:	6a 00                	push   $0x0
  80121e:	6a 00                	push   $0x0
  801220:	6a 14                	push   $0x14
  801222:	e8 b0 fd ff ff       	call   800fd7 <syscall>
  801227:	83 c4 18             	add    $0x18,%esp
}
  80122a:	90                   	nop
  80122b:	c9                   	leave  
  80122c:	c3                   	ret    

0080122d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80122d:	55                   	push   %ebp
  80122e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801230:	6a 00                	push   $0x0
  801232:	6a 00                	push   $0x0
  801234:	6a 00                	push   $0x0
  801236:	6a 00                	push   $0x0
  801238:	6a 00                	push   $0x0
  80123a:	6a 15                	push   $0x15
  80123c:	e8 96 fd ff ff       	call   800fd7 <syscall>
  801241:	83 c4 18             	add    $0x18,%esp
}
  801244:	90                   	nop
  801245:	c9                   	leave  
  801246:	c3                   	ret    

00801247 <sys_cputc>:


void
sys_cputc(const char c)
{
  801247:	55                   	push   %ebp
  801248:	89 e5                	mov    %esp,%ebp
  80124a:	83 ec 04             	sub    $0x4,%esp
  80124d:	8b 45 08             	mov    0x8(%ebp),%eax
  801250:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801253:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801257:	6a 00                	push   $0x0
  801259:	6a 00                	push   $0x0
  80125b:	6a 00                	push   $0x0
  80125d:	6a 00                	push   $0x0
  80125f:	50                   	push   %eax
  801260:	6a 16                	push   $0x16
  801262:	e8 70 fd ff ff       	call   800fd7 <syscall>
  801267:	83 c4 18             	add    $0x18,%esp
}
  80126a:	90                   	nop
  80126b:	c9                   	leave  
  80126c:	c3                   	ret    

0080126d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80126d:	55                   	push   %ebp
  80126e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801270:	6a 00                	push   $0x0
  801272:	6a 00                	push   $0x0
  801274:	6a 00                	push   $0x0
  801276:	6a 00                	push   $0x0
  801278:	6a 00                	push   $0x0
  80127a:	6a 17                	push   $0x17
  80127c:	e8 56 fd ff ff       	call   800fd7 <syscall>
  801281:	83 c4 18             	add    $0x18,%esp
}
  801284:	90                   	nop
  801285:	c9                   	leave  
  801286:	c3                   	ret    

00801287 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801287:	55                   	push   %ebp
  801288:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80128a:	8b 45 08             	mov    0x8(%ebp),%eax
  80128d:	6a 00                	push   $0x0
  80128f:	6a 00                	push   $0x0
  801291:	6a 00                	push   $0x0
  801293:	ff 75 0c             	pushl  0xc(%ebp)
  801296:	50                   	push   %eax
  801297:	6a 18                	push   $0x18
  801299:	e8 39 fd ff ff       	call   800fd7 <syscall>
  80129e:	83 c4 18             	add    $0x18,%esp
}
  8012a1:	c9                   	leave  
  8012a2:	c3                   	ret    

008012a3 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012a3:	55                   	push   %ebp
  8012a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ac:	6a 00                	push   $0x0
  8012ae:	6a 00                	push   $0x0
  8012b0:	6a 00                	push   $0x0
  8012b2:	52                   	push   %edx
  8012b3:	50                   	push   %eax
  8012b4:	6a 1b                	push   $0x1b
  8012b6:	e8 1c fd ff ff       	call   800fd7 <syscall>
  8012bb:	83 c4 18             	add    $0x18,%esp
}
  8012be:	c9                   	leave  
  8012bf:	c3                   	ret    

008012c0 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012c0:	55                   	push   %ebp
  8012c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c9:	6a 00                	push   $0x0
  8012cb:	6a 00                	push   $0x0
  8012cd:	6a 00                	push   $0x0
  8012cf:	52                   	push   %edx
  8012d0:	50                   	push   %eax
  8012d1:	6a 19                	push   $0x19
  8012d3:	e8 ff fc ff ff       	call   800fd7 <syscall>
  8012d8:	83 c4 18             	add    $0x18,%esp
}
  8012db:	90                   	nop
  8012dc:	c9                   	leave  
  8012dd:	c3                   	ret    

008012de <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012de:	55                   	push   %ebp
  8012df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e7:	6a 00                	push   $0x0
  8012e9:	6a 00                	push   $0x0
  8012eb:	6a 00                	push   $0x0
  8012ed:	52                   	push   %edx
  8012ee:	50                   	push   %eax
  8012ef:	6a 1a                	push   $0x1a
  8012f1:	e8 e1 fc ff ff       	call   800fd7 <syscall>
  8012f6:	83 c4 18             	add    $0x18,%esp
}
  8012f9:	90                   	nop
  8012fa:	c9                   	leave  
  8012fb:	c3                   	ret    

008012fc <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8012fc:	55                   	push   %ebp
  8012fd:	89 e5                	mov    %esp,%ebp
  8012ff:	83 ec 04             	sub    $0x4,%esp
  801302:	8b 45 10             	mov    0x10(%ebp),%eax
  801305:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801308:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80130b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
  801312:	6a 00                	push   $0x0
  801314:	51                   	push   %ecx
  801315:	52                   	push   %edx
  801316:	ff 75 0c             	pushl  0xc(%ebp)
  801319:	50                   	push   %eax
  80131a:	6a 1c                	push   $0x1c
  80131c:	e8 b6 fc ff ff       	call   800fd7 <syscall>
  801321:	83 c4 18             	add    $0x18,%esp
}
  801324:	c9                   	leave  
  801325:	c3                   	ret    

00801326 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801326:	55                   	push   %ebp
  801327:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801329:	8b 55 0c             	mov    0xc(%ebp),%edx
  80132c:	8b 45 08             	mov    0x8(%ebp),%eax
  80132f:	6a 00                	push   $0x0
  801331:	6a 00                	push   $0x0
  801333:	6a 00                	push   $0x0
  801335:	52                   	push   %edx
  801336:	50                   	push   %eax
  801337:	6a 1d                	push   $0x1d
  801339:	e8 99 fc ff ff       	call   800fd7 <syscall>
  80133e:	83 c4 18             	add    $0x18,%esp
}
  801341:	c9                   	leave  
  801342:	c3                   	ret    

00801343 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801343:	55                   	push   %ebp
  801344:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801346:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801349:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134c:	8b 45 08             	mov    0x8(%ebp),%eax
  80134f:	6a 00                	push   $0x0
  801351:	6a 00                	push   $0x0
  801353:	51                   	push   %ecx
  801354:	52                   	push   %edx
  801355:	50                   	push   %eax
  801356:	6a 1e                	push   $0x1e
  801358:	e8 7a fc ff ff       	call   800fd7 <syscall>
  80135d:	83 c4 18             	add    $0x18,%esp
}
  801360:	c9                   	leave  
  801361:	c3                   	ret    

00801362 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801362:	55                   	push   %ebp
  801363:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801365:	8b 55 0c             	mov    0xc(%ebp),%edx
  801368:	8b 45 08             	mov    0x8(%ebp),%eax
  80136b:	6a 00                	push   $0x0
  80136d:	6a 00                	push   $0x0
  80136f:	6a 00                	push   $0x0
  801371:	52                   	push   %edx
  801372:	50                   	push   %eax
  801373:	6a 1f                	push   $0x1f
  801375:	e8 5d fc ff ff       	call   800fd7 <syscall>
  80137a:	83 c4 18             	add    $0x18,%esp
}
  80137d:	c9                   	leave  
  80137e:	c3                   	ret    

0080137f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80137f:	55                   	push   %ebp
  801380:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801382:	6a 00                	push   $0x0
  801384:	6a 00                	push   $0x0
  801386:	6a 00                	push   $0x0
  801388:	6a 00                	push   $0x0
  80138a:	6a 00                	push   $0x0
  80138c:	6a 20                	push   $0x20
  80138e:	e8 44 fc ff ff       	call   800fd7 <syscall>
  801393:	83 c4 18             	add    $0x18,%esp
}
  801396:	c9                   	leave  
  801397:	c3                   	ret    

00801398 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801398:	55                   	push   %ebp
  801399:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	6a 00                	push   $0x0
  8013a0:	ff 75 14             	pushl  0x14(%ebp)
  8013a3:	ff 75 10             	pushl  0x10(%ebp)
  8013a6:	ff 75 0c             	pushl  0xc(%ebp)
  8013a9:	50                   	push   %eax
  8013aa:	6a 21                	push   $0x21
  8013ac:	e8 26 fc ff ff       	call   800fd7 <syscall>
  8013b1:	83 c4 18             	add    $0x18,%esp
}
  8013b4:	c9                   	leave  
  8013b5:	c3                   	ret    

008013b6 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8013b6:	55                   	push   %ebp
  8013b7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bc:	6a 00                	push   $0x0
  8013be:	6a 00                	push   $0x0
  8013c0:	6a 00                	push   $0x0
  8013c2:	6a 00                	push   $0x0
  8013c4:	50                   	push   %eax
  8013c5:	6a 22                	push   $0x22
  8013c7:	e8 0b fc ff ff       	call   800fd7 <syscall>
  8013cc:	83 c4 18             	add    $0x18,%esp
}
  8013cf:	90                   	nop
  8013d0:	c9                   	leave  
  8013d1:	c3                   	ret    

008013d2 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013d2:	55                   	push   %ebp
  8013d3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8013d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d8:	6a 00                	push   $0x0
  8013da:	6a 00                	push   $0x0
  8013dc:	6a 00                	push   $0x0
  8013de:	6a 00                	push   $0x0
  8013e0:	50                   	push   %eax
  8013e1:	6a 23                	push   $0x23
  8013e3:	e8 ef fb ff ff       	call   800fd7 <syscall>
  8013e8:	83 c4 18             	add    $0x18,%esp
}
  8013eb:	90                   	nop
  8013ec:	c9                   	leave  
  8013ed:	c3                   	ret    

008013ee <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8013ee:	55                   	push   %ebp
  8013ef:	89 e5                	mov    %esp,%ebp
  8013f1:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8013f4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013f7:	8d 50 04             	lea    0x4(%eax),%edx
  8013fa:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	52                   	push   %edx
  801404:	50                   	push   %eax
  801405:	6a 24                	push   $0x24
  801407:	e8 cb fb ff ff       	call   800fd7 <syscall>
  80140c:	83 c4 18             	add    $0x18,%esp
	return result;
  80140f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801412:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801415:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801418:	89 01                	mov    %eax,(%ecx)
  80141a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80141d:	8b 45 08             	mov    0x8(%ebp),%eax
  801420:	c9                   	leave  
  801421:	c2 04 00             	ret    $0x4

00801424 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801424:	55                   	push   %ebp
  801425:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801427:	6a 00                	push   $0x0
  801429:	6a 00                	push   $0x0
  80142b:	ff 75 10             	pushl  0x10(%ebp)
  80142e:	ff 75 0c             	pushl  0xc(%ebp)
  801431:	ff 75 08             	pushl  0x8(%ebp)
  801434:	6a 13                	push   $0x13
  801436:	e8 9c fb ff ff       	call   800fd7 <syscall>
  80143b:	83 c4 18             	add    $0x18,%esp
	return ;
  80143e:	90                   	nop
}
  80143f:	c9                   	leave  
  801440:	c3                   	ret    

00801441 <sys_rcr2>:
uint32 sys_rcr2()
{
  801441:	55                   	push   %ebp
  801442:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801444:	6a 00                	push   $0x0
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	6a 00                	push   $0x0
  80144c:	6a 00                	push   $0x0
  80144e:	6a 25                	push   $0x25
  801450:	e8 82 fb ff ff       	call   800fd7 <syscall>
  801455:	83 c4 18             	add    $0x18,%esp
}
  801458:	c9                   	leave  
  801459:	c3                   	ret    

0080145a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80145a:	55                   	push   %ebp
  80145b:	89 e5                	mov    %esp,%ebp
  80145d:	83 ec 04             	sub    $0x4,%esp
  801460:	8b 45 08             	mov    0x8(%ebp),%eax
  801463:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801466:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80146a:	6a 00                	push   $0x0
  80146c:	6a 00                	push   $0x0
  80146e:	6a 00                	push   $0x0
  801470:	6a 00                	push   $0x0
  801472:	50                   	push   %eax
  801473:	6a 26                	push   $0x26
  801475:	e8 5d fb ff ff       	call   800fd7 <syscall>
  80147a:	83 c4 18             	add    $0x18,%esp
	return ;
  80147d:	90                   	nop
}
  80147e:	c9                   	leave  
  80147f:	c3                   	ret    

00801480 <rsttst>:
void rsttst()
{
  801480:	55                   	push   %ebp
  801481:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801483:	6a 00                	push   $0x0
  801485:	6a 00                	push   $0x0
  801487:	6a 00                	push   $0x0
  801489:	6a 00                	push   $0x0
  80148b:	6a 00                	push   $0x0
  80148d:	6a 28                	push   $0x28
  80148f:	e8 43 fb ff ff       	call   800fd7 <syscall>
  801494:	83 c4 18             	add    $0x18,%esp
	return ;
  801497:	90                   	nop
}
  801498:	c9                   	leave  
  801499:	c3                   	ret    

0080149a <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80149a:	55                   	push   %ebp
  80149b:	89 e5                	mov    %esp,%ebp
  80149d:	83 ec 04             	sub    $0x4,%esp
  8014a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8014a3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014a6:	8b 55 18             	mov    0x18(%ebp),%edx
  8014a9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014ad:	52                   	push   %edx
  8014ae:	50                   	push   %eax
  8014af:	ff 75 10             	pushl  0x10(%ebp)
  8014b2:	ff 75 0c             	pushl  0xc(%ebp)
  8014b5:	ff 75 08             	pushl  0x8(%ebp)
  8014b8:	6a 27                	push   $0x27
  8014ba:	e8 18 fb ff ff       	call   800fd7 <syscall>
  8014bf:	83 c4 18             	add    $0x18,%esp
	return ;
  8014c2:	90                   	nop
}
  8014c3:	c9                   	leave  
  8014c4:	c3                   	ret    

008014c5 <chktst>:
void chktst(uint32 n)
{
  8014c5:	55                   	push   %ebp
  8014c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	ff 75 08             	pushl  0x8(%ebp)
  8014d3:	6a 29                	push   $0x29
  8014d5:	e8 fd fa ff ff       	call   800fd7 <syscall>
  8014da:	83 c4 18             	add    $0x18,%esp
	return ;
  8014dd:	90                   	nop
}
  8014de:	c9                   	leave  
  8014df:	c3                   	ret    

008014e0 <inctst>:

void inctst()
{
  8014e0:	55                   	push   %ebp
  8014e1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8014e3:	6a 00                	push   $0x0
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 2a                	push   $0x2a
  8014ef:	e8 e3 fa ff ff       	call   800fd7 <syscall>
  8014f4:	83 c4 18             	add    $0x18,%esp
	return ;
  8014f7:	90                   	nop
}
  8014f8:	c9                   	leave  
  8014f9:	c3                   	ret    

008014fa <gettst>:
uint32 gettst()
{
  8014fa:	55                   	push   %ebp
  8014fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	6a 00                	push   $0x0
  801503:	6a 00                	push   $0x0
  801505:	6a 00                	push   $0x0
  801507:	6a 2b                	push   $0x2b
  801509:	e8 c9 fa ff ff       	call   800fd7 <syscall>
  80150e:	83 c4 18             	add    $0x18,%esp
}
  801511:	c9                   	leave  
  801512:	c3                   	ret    

00801513 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801513:	55                   	push   %ebp
  801514:	89 e5                	mov    %esp,%ebp
  801516:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	6a 00                	push   $0x0
  80151f:	6a 00                	push   $0x0
  801521:	6a 00                	push   $0x0
  801523:	6a 2c                	push   $0x2c
  801525:	e8 ad fa ff ff       	call   800fd7 <syscall>
  80152a:	83 c4 18             	add    $0x18,%esp
  80152d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801530:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801534:	75 07                	jne    80153d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801536:	b8 01 00 00 00       	mov    $0x1,%eax
  80153b:	eb 05                	jmp    801542 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80153d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801542:	c9                   	leave  
  801543:	c3                   	ret    

00801544 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801544:	55                   	push   %ebp
  801545:	89 e5                	mov    %esp,%ebp
  801547:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	6a 2c                	push   $0x2c
  801556:	e8 7c fa ff ff       	call   800fd7 <syscall>
  80155b:	83 c4 18             	add    $0x18,%esp
  80155e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801561:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801565:	75 07                	jne    80156e <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801567:	b8 01 00 00 00       	mov    $0x1,%eax
  80156c:	eb 05                	jmp    801573 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80156e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801573:	c9                   	leave  
  801574:	c3                   	ret    

00801575 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801575:	55                   	push   %ebp
  801576:	89 e5                	mov    %esp,%ebp
  801578:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 2c                	push   $0x2c
  801587:	e8 4b fa ff ff       	call   800fd7 <syscall>
  80158c:	83 c4 18             	add    $0x18,%esp
  80158f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801592:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801596:	75 07                	jne    80159f <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801598:	b8 01 00 00 00       	mov    $0x1,%eax
  80159d:	eb 05                	jmp    8015a4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80159f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015a4:	c9                   	leave  
  8015a5:	c3                   	ret    

008015a6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015a6:	55                   	push   %ebp
  8015a7:	89 e5                	mov    %esp,%ebp
  8015a9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 2c                	push   $0x2c
  8015b8:	e8 1a fa ff ff       	call   800fd7 <syscall>
  8015bd:	83 c4 18             	add    $0x18,%esp
  8015c0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015c3:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015c7:	75 07                	jne    8015d0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015c9:	b8 01 00 00 00       	mov    $0x1,%eax
  8015ce:	eb 05                	jmp    8015d5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015d0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d5:	c9                   	leave  
  8015d6:	c3                   	ret    

008015d7 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8015d7:	55                   	push   %ebp
  8015d8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	ff 75 08             	pushl  0x8(%ebp)
  8015e5:	6a 2d                	push   $0x2d
  8015e7:	e8 eb f9 ff ff       	call   800fd7 <syscall>
  8015ec:	83 c4 18             	add    $0x18,%esp
	return ;
  8015ef:	90                   	nop
}
  8015f0:	c9                   	leave  
  8015f1:	c3                   	ret    

008015f2 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8015f2:	55                   	push   %ebp
  8015f3:	89 e5                	mov    %esp,%ebp
  8015f5:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8015f6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015f9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801602:	6a 00                	push   $0x0
  801604:	53                   	push   %ebx
  801605:	51                   	push   %ecx
  801606:	52                   	push   %edx
  801607:	50                   	push   %eax
  801608:	6a 2e                	push   $0x2e
  80160a:	e8 c8 f9 ff ff       	call   800fd7 <syscall>
  80160f:	83 c4 18             	add    $0x18,%esp
}
  801612:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801615:	c9                   	leave  
  801616:	c3                   	ret    

00801617 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801617:	55                   	push   %ebp
  801618:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80161a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80161d:	8b 45 08             	mov    0x8(%ebp),%eax
  801620:	6a 00                	push   $0x0
  801622:	6a 00                	push   $0x0
  801624:	6a 00                	push   $0x0
  801626:	52                   	push   %edx
  801627:	50                   	push   %eax
  801628:	6a 2f                	push   $0x2f
  80162a:	e8 a8 f9 ff ff       	call   800fd7 <syscall>
  80162f:	83 c4 18             	add    $0x18,%esp
}
  801632:	c9                   	leave  
  801633:	c3                   	ret    

00801634 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801634:	55                   	push   %ebp
  801635:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	ff 75 0c             	pushl  0xc(%ebp)
  801640:	ff 75 08             	pushl  0x8(%ebp)
  801643:	6a 30                	push   $0x30
  801645:	e8 8d f9 ff ff       	call   800fd7 <syscall>
  80164a:	83 c4 18             	add    $0x18,%esp
	return ;
  80164d:	90                   	nop
}
  80164e:	c9                   	leave  
  80164f:	c3                   	ret    

00801650 <__udivdi3>:
  801650:	55                   	push   %ebp
  801651:	57                   	push   %edi
  801652:	56                   	push   %esi
  801653:	53                   	push   %ebx
  801654:	83 ec 1c             	sub    $0x1c,%esp
  801657:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80165b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80165f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801663:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801667:	89 ca                	mov    %ecx,%edx
  801669:	89 f8                	mov    %edi,%eax
  80166b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80166f:	85 f6                	test   %esi,%esi
  801671:	75 2d                	jne    8016a0 <__udivdi3+0x50>
  801673:	39 cf                	cmp    %ecx,%edi
  801675:	77 65                	ja     8016dc <__udivdi3+0x8c>
  801677:	89 fd                	mov    %edi,%ebp
  801679:	85 ff                	test   %edi,%edi
  80167b:	75 0b                	jne    801688 <__udivdi3+0x38>
  80167d:	b8 01 00 00 00       	mov    $0x1,%eax
  801682:	31 d2                	xor    %edx,%edx
  801684:	f7 f7                	div    %edi
  801686:	89 c5                	mov    %eax,%ebp
  801688:	31 d2                	xor    %edx,%edx
  80168a:	89 c8                	mov    %ecx,%eax
  80168c:	f7 f5                	div    %ebp
  80168e:	89 c1                	mov    %eax,%ecx
  801690:	89 d8                	mov    %ebx,%eax
  801692:	f7 f5                	div    %ebp
  801694:	89 cf                	mov    %ecx,%edi
  801696:	89 fa                	mov    %edi,%edx
  801698:	83 c4 1c             	add    $0x1c,%esp
  80169b:	5b                   	pop    %ebx
  80169c:	5e                   	pop    %esi
  80169d:	5f                   	pop    %edi
  80169e:	5d                   	pop    %ebp
  80169f:	c3                   	ret    
  8016a0:	39 ce                	cmp    %ecx,%esi
  8016a2:	77 28                	ja     8016cc <__udivdi3+0x7c>
  8016a4:	0f bd fe             	bsr    %esi,%edi
  8016a7:	83 f7 1f             	xor    $0x1f,%edi
  8016aa:	75 40                	jne    8016ec <__udivdi3+0x9c>
  8016ac:	39 ce                	cmp    %ecx,%esi
  8016ae:	72 0a                	jb     8016ba <__udivdi3+0x6a>
  8016b0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8016b4:	0f 87 9e 00 00 00    	ja     801758 <__udivdi3+0x108>
  8016ba:	b8 01 00 00 00       	mov    $0x1,%eax
  8016bf:	89 fa                	mov    %edi,%edx
  8016c1:	83 c4 1c             	add    $0x1c,%esp
  8016c4:	5b                   	pop    %ebx
  8016c5:	5e                   	pop    %esi
  8016c6:	5f                   	pop    %edi
  8016c7:	5d                   	pop    %ebp
  8016c8:	c3                   	ret    
  8016c9:	8d 76 00             	lea    0x0(%esi),%esi
  8016cc:	31 ff                	xor    %edi,%edi
  8016ce:	31 c0                	xor    %eax,%eax
  8016d0:	89 fa                	mov    %edi,%edx
  8016d2:	83 c4 1c             	add    $0x1c,%esp
  8016d5:	5b                   	pop    %ebx
  8016d6:	5e                   	pop    %esi
  8016d7:	5f                   	pop    %edi
  8016d8:	5d                   	pop    %ebp
  8016d9:	c3                   	ret    
  8016da:	66 90                	xchg   %ax,%ax
  8016dc:	89 d8                	mov    %ebx,%eax
  8016de:	f7 f7                	div    %edi
  8016e0:	31 ff                	xor    %edi,%edi
  8016e2:	89 fa                	mov    %edi,%edx
  8016e4:	83 c4 1c             	add    $0x1c,%esp
  8016e7:	5b                   	pop    %ebx
  8016e8:	5e                   	pop    %esi
  8016e9:	5f                   	pop    %edi
  8016ea:	5d                   	pop    %ebp
  8016eb:	c3                   	ret    
  8016ec:	bd 20 00 00 00       	mov    $0x20,%ebp
  8016f1:	89 eb                	mov    %ebp,%ebx
  8016f3:	29 fb                	sub    %edi,%ebx
  8016f5:	89 f9                	mov    %edi,%ecx
  8016f7:	d3 e6                	shl    %cl,%esi
  8016f9:	89 c5                	mov    %eax,%ebp
  8016fb:	88 d9                	mov    %bl,%cl
  8016fd:	d3 ed                	shr    %cl,%ebp
  8016ff:	89 e9                	mov    %ebp,%ecx
  801701:	09 f1                	or     %esi,%ecx
  801703:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801707:	89 f9                	mov    %edi,%ecx
  801709:	d3 e0                	shl    %cl,%eax
  80170b:	89 c5                	mov    %eax,%ebp
  80170d:	89 d6                	mov    %edx,%esi
  80170f:	88 d9                	mov    %bl,%cl
  801711:	d3 ee                	shr    %cl,%esi
  801713:	89 f9                	mov    %edi,%ecx
  801715:	d3 e2                	shl    %cl,%edx
  801717:	8b 44 24 08          	mov    0x8(%esp),%eax
  80171b:	88 d9                	mov    %bl,%cl
  80171d:	d3 e8                	shr    %cl,%eax
  80171f:	09 c2                	or     %eax,%edx
  801721:	89 d0                	mov    %edx,%eax
  801723:	89 f2                	mov    %esi,%edx
  801725:	f7 74 24 0c          	divl   0xc(%esp)
  801729:	89 d6                	mov    %edx,%esi
  80172b:	89 c3                	mov    %eax,%ebx
  80172d:	f7 e5                	mul    %ebp
  80172f:	39 d6                	cmp    %edx,%esi
  801731:	72 19                	jb     80174c <__udivdi3+0xfc>
  801733:	74 0b                	je     801740 <__udivdi3+0xf0>
  801735:	89 d8                	mov    %ebx,%eax
  801737:	31 ff                	xor    %edi,%edi
  801739:	e9 58 ff ff ff       	jmp    801696 <__udivdi3+0x46>
  80173e:	66 90                	xchg   %ax,%ax
  801740:	8b 54 24 08          	mov    0x8(%esp),%edx
  801744:	89 f9                	mov    %edi,%ecx
  801746:	d3 e2                	shl    %cl,%edx
  801748:	39 c2                	cmp    %eax,%edx
  80174a:	73 e9                	jae    801735 <__udivdi3+0xe5>
  80174c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80174f:	31 ff                	xor    %edi,%edi
  801751:	e9 40 ff ff ff       	jmp    801696 <__udivdi3+0x46>
  801756:	66 90                	xchg   %ax,%ax
  801758:	31 c0                	xor    %eax,%eax
  80175a:	e9 37 ff ff ff       	jmp    801696 <__udivdi3+0x46>
  80175f:	90                   	nop

00801760 <__umoddi3>:
  801760:	55                   	push   %ebp
  801761:	57                   	push   %edi
  801762:	56                   	push   %esi
  801763:	53                   	push   %ebx
  801764:	83 ec 1c             	sub    $0x1c,%esp
  801767:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80176b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80176f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801773:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801777:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80177b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80177f:	89 f3                	mov    %esi,%ebx
  801781:	89 fa                	mov    %edi,%edx
  801783:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801787:	89 34 24             	mov    %esi,(%esp)
  80178a:	85 c0                	test   %eax,%eax
  80178c:	75 1a                	jne    8017a8 <__umoddi3+0x48>
  80178e:	39 f7                	cmp    %esi,%edi
  801790:	0f 86 a2 00 00 00    	jbe    801838 <__umoddi3+0xd8>
  801796:	89 c8                	mov    %ecx,%eax
  801798:	89 f2                	mov    %esi,%edx
  80179a:	f7 f7                	div    %edi
  80179c:	89 d0                	mov    %edx,%eax
  80179e:	31 d2                	xor    %edx,%edx
  8017a0:	83 c4 1c             	add    $0x1c,%esp
  8017a3:	5b                   	pop    %ebx
  8017a4:	5e                   	pop    %esi
  8017a5:	5f                   	pop    %edi
  8017a6:	5d                   	pop    %ebp
  8017a7:	c3                   	ret    
  8017a8:	39 f0                	cmp    %esi,%eax
  8017aa:	0f 87 ac 00 00 00    	ja     80185c <__umoddi3+0xfc>
  8017b0:	0f bd e8             	bsr    %eax,%ebp
  8017b3:	83 f5 1f             	xor    $0x1f,%ebp
  8017b6:	0f 84 ac 00 00 00    	je     801868 <__umoddi3+0x108>
  8017bc:	bf 20 00 00 00       	mov    $0x20,%edi
  8017c1:	29 ef                	sub    %ebp,%edi
  8017c3:	89 fe                	mov    %edi,%esi
  8017c5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8017c9:	89 e9                	mov    %ebp,%ecx
  8017cb:	d3 e0                	shl    %cl,%eax
  8017cd:	89 d7                	mov    %edx,%edi
  8017cf:	89 f1                	mov    %esi,%ecx
  8017d1:	d3 ef                	shr    %cl,%edi
  8017d3:	09 c7                	or     %eax,%edi
  8017d5:	89 e9                	mov    %ebp,%ecx
  8017d7:	d3 e2                	shl    %cl,%edx
  8017d9:	89 14 24             	mov    %edx,(%esp)
  8017dc:	89 d8                	mov    %ebx,%eax
  8017de:	d3 e0                	shl    %cl,%eax
  8017e0:	89 c2                	mov    %eax,%edx
  8017e2:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017e6:	d3 e0                	shl    %cl,%eax
  8017e8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8017ec:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017f0:	89 f1                	mov    %esi,%ecx
  8017f2:	d3 e8                	shr    %cl,%eax
  8017f4:	09 d0                	or     %edx,%eax
  8017f6:	d3 eb                	shr    %cl,%ebx
  8017f8:	89 da                	mov    %ebx,%edx
  8017fa:	f7 f7                	div    %edi
  8017fc:	89 d3                	mov    %edx,%ebx
  8017fe:	f7 24 24             	mull   (%esp)
  801801:	89 c6                	mov    %eax,%esi
  801803:	89 d1                	mov    %edx,%ecx
  801805:	39 d3                	cmp    %edx,%ebx
  801807:	0f 82 87 00 00 00    	jb     801894 <__umoddi3+0x134>
  80180d:	0f 84 91 00 00 00    	je     8018a4 <__umoddi3+0x144>
  801813:	8b 54 24 04          	mov    0x4(%esp),%edx
  801817:	29 f2                	sub    %esi,%edx
  801819:	19 cb                	sbb    %ecx,%ebx
  80181b:	89 d8                	mov    %ebx,%eax
  80181d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801821:	d3 e0                	shl    %cl,%eax
  801823:	89 e9                	mov    %ebp,%ecx
  801825:	d3 ea                	shr    %cl,%edx
  801827:	09 d0                	or     %edx,%eax
  801829:	89 e9                	mov    %ebp,%ecx
  80182b:	d3 eb                	shr    %cl,%ebx
  80182d:	89 da                	mov    %ebx,%edx
  80182f:	83 c4 1c             	add    $0x1c,%esp
  801832:	5b                   	pop    %ebx
  801833:	5e                   	pop    %esi
  801834:	5f                   	pop    %edi
  801835:	5d                   	pop    %ebp
  801836:	c3                   	ret    
  801837:	90                   	nop
  801838:	89 fd                	mov    %edi,%ebp
  80183a:	85 ff                	test   %edi,%edi
  80183c:	75 0b                	jne    801849 <__umoddi3+0xe9>
  80183e:	b8 01 00 00 00       	mov    $0x1,%eax
  801843:	31 d2                	xor    %edx,%edx
  801845:	f7 f7                	div    %edi
  801847:	89 c5                	mov    %eax,%ebp
  801849:	89 f0                	mov    %esi,%eax
  80184b:	31 d2                	xor    %edx,%edx
  80184d:	f7 f5                	div    %ebp
  80184f:	89 c8                	mov    %ecx,%eax
  801851:	f7 f5                	div    %ebp
  801853:	89 d0                	mov    %edx,%eax
  801855:	e9 44 ff ff ff       	jmp    80179e <__umoddi3+0x3e>
  80185a:	66 90                	xchg   %ax,%ax
  80185c:	89 c8                	mov    %ecx,%eax
  80185e:	89 f2                	mov    %esi,%edx
  801860:	83 c4 1c             	add    $0x1c,%esp
  801863:	5b                   	pop    %ebx
  801864:	5e                   	pop    %esi
  801865:	5f                   	pop    %edi
  801866:	5d                   	pop    %ebp
  801867:	c3                   	ret    
  801868:	3b 04 24             	cmp    (%esp),%eax
  80186b:	72 06                	jb     801873 <__umoddi3+0x113>
  80186d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801871:	77 0f                	ja     801882 <__umoddi3+0x122>
  801873:	89 f2                	mov    %esi,%edx
  801875:	29 f9                	sub    %edi,%ecx
  801877:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80187b:	89 14 24             	mov    %edx,(%esp)
  80187e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801882:	8b 44 24 04          	mov    0x4(%esp),%eax
  801886:	8b 14 24             	mov    (%esp),%edx
  801889:	83 c4 1c             	add    $0x1c,%esp
  80188c:	5b                   	pop    %ebx
  80188d:	5e                   	pop    %esi
  80188e:	5f                   	pop    %edi
  80188f:	5d                   	pop    %ebp
  801890:	c3                   	ret    
  801891:	8d 76 00             	lea    0x0(%esi),%esi
  801894:	2b 04 24             	sub    (%esp),%eax
  801897:	19 fa                	sbb    %edi,%edx
  801899:	89 d1                	mov    %edx,%ecx
  80189b:	89 c6                	mov    %eax,%esi
  80189d:	e9 71 ff ff ff       	jmp    801813 <__umoddi3+0xb3>
  8018a2:	66 90                	xchg   %ax,%ax
  8018a4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8018a8:	72 ea                	jb     801894 <__umoddi3+0x134>
  8018aa:	89 d9                	mov    %ebx,%ecx
  8018ac:	e9 62 ff ff ff       	jmp    801813 <__umoddi3+0xb3>
