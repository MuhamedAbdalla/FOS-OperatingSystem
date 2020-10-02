
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
  800058:	e8 17 0c 00 00       	call   800c74 <strtol>
  80005d:	83 c4 10             	add    $0x10,%esp
  800060:	89 45 f4             	mov    %eax,-0xc(%ebp)
	i2 = strtol("2", NULL, 10);
  800063:	83 ec 04             	sub    $0x4,%esp
  800066:	6a 0a                	push   $0xa
  800068:	6a 00                	push   $0x0
  80006a:	68 02 19 80 00       	push   $0x801902
  80006f:	e8 00 0c 00 00       	call   800c74 <strtol>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("number 1 + number 2 = %d\n",i1+i2);
  80007a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80007d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800080:	01 d0                	add    %edx,%eax
  800082:	83 ec 08             	sub    $0x8,%esp
  800085:	50                   	push   %eax
  800086:	68 04 19 80 00       	push   $0x801904
  80008b:	e8 2f 02 00 00       	call   8002bf <atomic_cprintf>
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
  80009c:	e8 1c 10 00 00       	call   8010bd <sys_getenvindex>
  8000a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000a7:	89 d0                	mov    %edx,%eax
  8000a9:	01 c0                	add    %eax,%eax
  8000ab:	01 d0                	add    %edx,%eax
  8000ad:	c1 e0 07             	shl    $0x7,%eax
  8000b0:	29 d0                	sub    %edx,%eax
  8000b2:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8000b9:	01 c8                	add    %ecx,%eax
  8000bb:	01 c0                	add    %eax,%eax
  8000bd:	01 d0                	add    %edx,%eax
  8000bf:	01 c0                	add    %eax,%eax
  8000c1:	01 d0                	add    %edx,%eax
  8000c3:	c1 e0 03             	shl    $0x3,%eax
  8000c6:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000cb:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000d0:	a1 20 20 80 00       	mov    0x802020,%eax
  8000d5:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  8000db:	84 c0                	test   %al,%al
  8000dd:	74 0f                	je     8000ee <libmain+0x58>
		binaryname = myEnv->prog_name;
  8000df:	a1 20 20 80 00       	mov    0x802020,%eax
  8000e4:	05 f0 ee 00 00       	add    $0xeef0,%eax
  8000e9:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000ee:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000f2:	7e 0a                	jle    8000fe <libmain+0x68>
		binaryname = argv[0];
  8000f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000f7:	8b 00                	mov    (%eax),%eax
  8000f9:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000fe:	83 ec 08             	sub    $0x8,%esp
  800101:	ff 75 0c             	pushl  0xc(%ebp)
  800104:	ff 75 08             	pushl  0x8(%ebp)
  800107:	e8 2c ff ff ff       	call   800038 <_main>
  80010c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80010f:	e8 44 11 00 00       	call   801258 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800114:	83 ec 0c             	sub    $0xc,%esp
  800117:	68 38 19 80 00       	push   $0x801938
  80011c:	e8 71 01 00 00       	call   800292 <cprintf>
  800121:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800124:	a1 20 20 80 00       	mov    0x802020,%eax
  800129:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  80012f:	a1 20 20 80 00       	mov    0x802020,%eax
  800134:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  80013a:	83 ec 04             	sub    $0x4,%esp
  80013d:	52                   	push   %edx
  80013e:	50                   	push   %eax
  80013f:	68 60 19 80 00       	push   $0x801960
  800144:	e8 49 01 00 00       	call   800292 <cprintf>
  800149:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80014c:	a1 20 20 80 00       	mov    0x802020,%eax
  800151:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  800157:	a1 20 20 80 00       	mov    0x802020,%eax
  80015c:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  800162:	a1 20 20 80 00       	mov    0x802020,%eax
  800167:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  80016d:	51                   	push   %ecx
  80016e:	52                   	push   %edx
  80016f:	50                   	push   %eax
  800170:	68 88 19 80 00       	push   $0x801988
  800175:	e8 18 01 00 00       	call   800292 <cprintf>
  80017a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80017d:	83 ec 0c             	sub    $0xc,%esp
  800180:	68 38 19 80 00       	push   $0x801938
  800185:	e8 08 01 00 00       	call   800292 <cprintf>
  80018a:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80018d:	e8 e0 10 00 00       	call   801272 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800192:	e8 19 00 00 00       	call   8001b0 <exit>
}
  800197:	90                   	nop
  800198:	c9                   	leave  
  800199:	c3                   	ret    

0080019a <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80019a:	55                   	push   %ebp
  80019b:	89 e5                	mov    %esp,%ebp
  80019d:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001a0:	83 ec 0c             	sub    $0xc,%esp
  8001a3:	6a 00                	push   $0x0
  8001a5:	e8 df 0e 00 00       	call   801089 <sys_env_destroy>
  8001aa:	83 c4 10             	add    $0x10,%esp
}
  8001ad:	90                   	nop
  8001ae:	c9                   	leave  
  8001af:	c3                   	ret    

008001b0 <exit>:

void
exit(void)
{
  8001b0:	55                   	push   %ebp
  8001b1:	89 e5                	mov    %esp,%ebp
  8001b3:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001b6:	e8 34 0f 00 00       	call   8010ef <sys_env_exit>
}
  8001bb:	90                   	nop
  8001bc:	c9                   	leave  
  8001bd:	c3                   	ret    

008001be <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001be:	55                   	push   %ebp
  8001bf:	89 e5                	mov    %esp,%ebp
  8001c1:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c7:	8b 00                	mov    (%eax),%eax
  8001c9:	8d 48 01             	lea    0x1(%eax),%ecx
  8001cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001cf:	89 0a                	mov    %ecx,(%edx)
  8001d1:	8b 55 08             	mov    0x8(%ebp),%edx
  8001d4:	88 d1                	mov    %dl,%cl
  8001d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001d9:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001e0:	8b 00                	mov    (%eax),%eax
  8001e2:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001e7:	75 2c                	jne    800215 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001e9:	a0 24 20 80 00       	mov    0x802024,%al
  8001ee:	0f b6 c0             	movzbl %al,%eax
  8001f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001f4:	8b 12                	mov    (%edx),%edx
  8001f6:	89 d1                	mov    %edx,%ecx
  8001f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001fb:	83 c2 08             	add    $0x8,%edx
  8001fe:	83 ec 04             	sub    $0x4,%esp
  800201:	50                   	push   %eax
  800202:	51                   	push   %ecx
  800203:	52                   	push   %edx
  800204:	e8 3e 0e 00 00       	call   801047 <sys_cputs>
  800209:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80020c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800215:	8b 45 0c             	mov    0xc(%ebp),%eax
  800218:	8b 40 04             	mov    0x4(%eax),%eax
  80021b:	8d 50 01             	lea    0x1(%eax),%edx
  80021e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800221:	89 50 04             	mov    %edx,0x4(%eax)
}
  800224:	90                   	nop
  800225:	c9                   	leave  
  800226:	c3                   	ret    

00800227 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800227:	55                   	push   %ebp
  800228:	89 e5                	mov    %esp,%ebp
  80022a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800230:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800237:	00 00 00 
	b.cnt = 0;
  80023a:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800241:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800244:	ff 75 0c             	pushl  0xc(%ebp)
  800247:	ff 75 08             	pushl  0x8(%ebp)
  80024a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800250:	50                   	push   %eax
  800251:	68 be 01 80 00       	push   $0x8001be
  800256:	e8 11 02 00 00       	call   80046c <vprintfmt>
  80025b:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80025e:	a0 24 20 80 00       	mov    0x802024,%al
  800263:	0f b6 c0             	movzbl %al,%eax
  800266:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80026c:	83 ec 04             	sub    $0x4,%esp
  80026f:	50                   	push   %eax
  800270:	52                   	push   %edx
  800271:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800277:	83 c0 08             	add    $0x8,%eax
  80027a:	50                   	push   %eax
  80027b:	e8 c7 0d 00 00       	call   801047 <sys_cputs>
  800280:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800283:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  80028a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800290:	c9                   	leave  
  800291:	c3                   	ret    

00800292 <cprintf>:

int cprintf(const char *fmt, ...) {
  800292:	55                   	push   %ebp
  800293:	89 e5                	mov    %esp,%ebp
  800295:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800298:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  80029f:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8002a8:	83 ec 08             	sub    $0x8,%esp
  8002ab:	ff 75 f4             	pushl  -0xc(%ebp)
  8002ae:	50                   	push   %eax
  8002af:	e8 73 ff ff ff       	call   800227 <vcprintf>
  8002b4:	83 c4 10             	add    $0x10,%esp
  8002b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002bd:	c9                   	leave  
  8002be:	c3                   	ret    

008002bf <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002bf:	55                   	push   %ebp
  8002c0:	89 e5                	mov    %esp,%ebp
  8002c2:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002c5:	e8 8e 0f 00 00       	call   801258 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002ca:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d3:	83 ec 08             	sub    $0x8,%esp
  8002d6:	ff 75 f4             	pushl  -0xc(%ebp)
  8002d9:	50                   	push   %eax
  8002da:	e8 48 ff ff ff       	call   800227 <vcprintf>
  8002df:	83 c4 10             	add    $0x10,%esp
  8002e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002e5:	e8 88 0f 00 00       	call   801272 <sys_enable_interrupt>
	return cnt;
  8002ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002ed:	c9                   	leave  
  8002ee:	c3                   	ret    

008002ef <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002ef:	55                   	push   %ebp
  8002f0:	89 e5                	mov    %esp,%ebp
  8002f2:	53                   	push   %ebx
  8002f3:	83 ec 14             	sub    $0x14,%esp
  8002f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8002f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8002ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800302:	8b 45 18             	mov    0x18(%ebp),%eax
  800305:	ba 00 00 00 00       	mov    $0x0,%edx
  80030a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80030d:	77 55                	ja     800364 <printnum+0x75>
  80030f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800312:	72 05                	jb     800319 <printnum+0x2a>
  800314:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800317:	77 4b                	ja     800364 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800319:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80031c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80031f:	8b 45 18             	mov    0x18(%ebp),%eax
  800322:	ba 00 00 00 00       	mov    $0x0,%edx
  800327:	52                   	push   %edx
  800328:	50                   	push   %eax
  800329:	ff 75 f4             	pushl  -0xc(%ebp)
  80032c:	ff 75 f0             	pushl  -0x10(%ebp)
  80032f:	e8 64 13 00 00       	call   801698 <__udivdi3>
  800334:	83 c4 10             	add    $0x10,%esp
  800337:	83 ec 04             	sub    $0x4,%esp
  80033a:	ff 75 20             	pushl  0x20(%ebp)
  80033d:	53                   	push   %ebx
  80033e:	ff 75 18             	pushl  0x18(%ebp)
  800341:	52                   	push   %edx
  800342:	50                   	push   %eax
  800343:	ff 75 0c             	pushl  0xc(%ebp)
  800346:	ff 75 08             	pushl  0x8(%ebp)
  800349:	e8 a1 ff ff ff       	call   8002ef <printnum>
  80034e:	83 c4 20             	add    $0x20,%esp
  800351:	eb 1a                	jmp    80036d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800353:	83 ec 08             	sub    $0x8,%esp
  800356:	ff 75 0c             	pushl  0xc(%ebp)
  800359:	ff 75 20             	pushl  0x20(%ebp)
  80035c:	8b 45 08             	mov    0x8(%ebp),%eax
  80035f:	ff d0                	call   *%eax
  800361:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800364:	ff 4d 1c             	decl   0x1c(%ebp)
  800367:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80036b:	7f e6                	jg     800353 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80036d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800370:	bb 00 00 00 00       	mov    $0x0,%ebx
  800375:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800378:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80037b:	53                   	push   %ebx
  80037c:	51                   	push   %ecx
  80037d:	52                   	push   %edx
  80037e:	50                   	push   %eax
  80037f:	e8 24 14 00 00       	call   8017a8 <__umoddi3>
  800384:	83 c4 10             	add    $0x10,%esp
  800387:	05 f4 1b 80 00       	add    $0x801bf4,%eax
  80038c:	8a 00                	mov    (%eax),%al
  80038e:	0f be c0             	movsbl %al,%eax
  800391:	83 ec 08             	sub    $0x8,%esp
  800394:	ff 75 0c             	pushl  0xc(%ebp)
  800397:	50                   	push   %eax
  800398:	8b 45 08             	mov    0x8(%ebp),%eax
  80039b:	ff d0                	call   *%eax
  80039d:	83 c4 10             	add    $0x10,%esp
}
  8003a0:	90                   	nop
  8003a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003a4:	c9                   	leave  
  8003a5:	c3                   	ret    

008003a6 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003a6:	55                   	push   %ebp
  8003a7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003a9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003ad:	7e 1c                	jle    8003cb <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003af:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b2:	8b 00                	mov    (%eax),%eax
  8003b4:	8d 50 08             	lea    0x8(%eax),%edx
  8003b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ba:	89 10                	mov    %edx,(%eax)
  8003bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bf:	8b 00                	mov    (%eax),%eax
  8003c1:	83 e8 08             	sub    $0x8,%eax
  8003c4:	8b 50 04             	mov    0x4(%eax),%edx
  8003c7:	8b 00                	mov    (%eax),%eax
  8003c9:	eb 40                	jmp    80040b <getuint+0x65>
	else if (lflag)
  8003cb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003cf:	74 1e                	je     8003ef <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d4:	8b 00                	mov    (%eax),%eax
  8003d6:	8d 50 04             	lea    0x4(%eax),%edx
  8003d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003dc:	89 10                	mov    %edx,(%eax)
  8003de:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e1:	8b 00                	mov    (%eax),%eax
  8003e3:	83 e8 04             	sub    $0x4,%eax
  8003e6:	8b 00                	mov    (%eax),%eax
  8003e8:	ba 00 00 00 00       	mov    $0x0,%edx
  8003ed:	eb 1c                	jmp    80040b <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f2:	8b 00                	mov    (%eax),%eax
  8003f4:	8d 50 04             	lea    0x4(%eax),%edx
  8003f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fa:	89 10                	mov    %edx,(%eax)
  8003fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ff:	8b 00                	mov    (%eax),%eax
  800401:	83 e8 04             	sub    $0x4,%eax
  800404:	8b 00                	mov    (%eax),%eax
  800406:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80040b:	5d                   	pop    %ebp
  80040c:	c3                   	ret    

0080040d <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80040d:	55                   	push   %ebp
  80040e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800410:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800414:	7e 1c                	jle    800432 <getint+0x25>
		return va_arg(*ap, long long);
  800416:	8b 45 08             	mov    0x8(%ebp),%eax
  800419:	8b 00                	mov    (%eax),%eax
  80041b:	8d 50 08             	lea    0x8(%eax),%edx
  80041e:	8b 45 08             	mov    0x8(%ebp),%eax
  800421:	89 10                	mov    %edx,(%eax)
  800423:	8b 45 08             	mov    0x8(%ebp),%eax
  800426:	8b 00                	mov    (%eax),%eax
  800428:	83 e8 08             	sub    $0x8,%eax
  80042b:	8b 50 04             	mov    0x4(%eax),%edx
  80042e:	8b 00                	mov    (%eax),%eax
  800430:	eb 38                	jmp    80046a <getint+0x5d>
	else if (lflag)
  800432:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800436:	74 1a                	je     800452 <getint+0x45>
		return va_arg(*ap, long);
  800438:	8b 45 08             	mov    0x8(%ebp),%eax
  80043b:	8b 00                	mov    (%eax),%eax
  80043d:	8d 50 04             	lea    0x4(%eax),%edx
  800440:	8b 45 08             	mov    0x8(%ebp),%eax
  800443:	89 10                	mov    %edx,(%eax)
  800445:	8b 45 08             	mov    0x8(%ebp),%eax
  800448:	8b 00                	mov    (%eax),%eax
  80044a:	83 e8 04             	sub    $0x4,%eax
  80044d:	8b 00                	mov    (%eax),%eax
  80044f:	99                   	cltd   
  800450:	eb 18                	jmp    80046a <getint+0x5d>
	else
		return va_arg(*ap, int);
  800452:	8b 45 08             	mov    0x8(%ebp),%eax
  800455:	8b 00                	mov    (%eax),%eax
  800457:	8d 50 04             	lea    0x4(%eax),%edx
  80045a:	8b 45 08             	mov    0x8(%ebp),%eax
  80045d:	89 10                	mov    %edx,(%eax)
  80045f:	8b 45 08             	mov    0x8(%ebp),%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	83 e8 04             	sub    $0x4,%eax
  800467:	8b 00                	mov    (%eax),%eax
  800469:	99                   	cltd   
}
  80046a:	5d                   	pop    %ebp
  80046b:	c3                   	ret    

0080046c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80046c:	55                   	push   %ebp
  80046d:	89 e5                	mov    %esp,%ebp
  80046f:	56                   	push   %esi
  800470:	53                   	push   %ebx
  800471:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800474:	eb 17                	jmp    80048d <vprintfmt+0x21>
			if (ch == '\0')
  800476:	85 db                	test   %ebx,%ebx
  800478:	0f 84 af 03 00 00    	je     80082d <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80047e:	83 ec 08             	sub    $0x8,%esp
  800481:	ff 75 0c             	pushl  0xc(%ebp)
  800484:	53                   	push   %ebx
  800485:	8b 45 08             	mov    0x8(%ebp),%eax
  800488:	ff d0                	call   *%eax
  80048a:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80048d:	8b 45 10             	mov    0x10(%ebp),%eax
  800490:	8d 50 01             	lea    0x1(%eax),%edx
  800493:	89 55 10             	mov    %edx,0x10(%ebp)
  800496:	8a 00                	mov    (%eax),%al
  800498:	0f b6 d8             	movzbl %al,%ebx
  80049b:	83 fb 25             	cmp    $0x25,%ebx
  80049e:	75 d6                	jne    800476 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004a0:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004a4:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004ab:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004b2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004b9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c3:	8d 50 01             	lea    0x1(%eax),%edx
  8004c6:	89 55 10             	mov    %edx,0x10(%ebp)
  8004c9:	8a 00                	mov    (%eax),%al
  8004cb:	0f b6 d8             	movzbl %al,%ebx
  8004ce:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004d1:	83 f8 55             	cmp    $0x55,%eax
  8004d4:	0f 87 2b 03 00 00    	ja     800805 <vprintfmt+0x399>
  8004da:	8b 04 85 18 1c 80 00 	mov    0x801c18(,%eax,4),%eax
  8004e1:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004e3:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004e7:	eb d7                	jmp    8004c0 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004e9:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004ed:	eb d1                	jmp    8004c0 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004ef:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004f6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004f9:	89 d0                	mov    %edx,%eax
  8004fb:	c1 e0 02             	shl    $0x2,%eax
  8004fe:	01 d0                	add    %edx,%eax
  800500:	01 c0                	add    %eax,%eax
  800502:	01 d8                	add    %ebx,%eax
  800504:	83 e8 30             	sub    $0x30,%eax
  800507:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80050a:	8b 45 10             	mov    0x10(%ebp),%eax
  80050d:	8a 00                	mov    (%eax),%al
  80050f:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800512:	83 fb 2f             	cmp    $0x2f,%ebx
  800515:	7e 3e                	jle    800555 <vprintfmt+0xe9>
  800517:	83 fb 39             	cmp    $0x39,%ebx
  80051a:	7f 39                	jg     800555 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80051c:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80051f:	eb d5                	jmp    8004f6 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800521:	8b 45 14             	mov    0x14(%ebp),%eax
  800524:	83 c0 04             	add    $0x4,%eax
  800527:	89 45 14             	mov    %eax,0x14(%ebp)
  80052a:	8b 45 14             	mov    0x14(%ebp),%eax
  80052d:	83 e8 04             	sub    $0x4,%eax
  800530:	8b 00                	mov    (%eax),%eax
  800532:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800535:	eb 1f                	jmp    800556 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800537:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80053b:	79 83                	jns    8004c0 <vprintfmt+0x54>
				width = 0;
  80053d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800544:	e9 77 ff ff ff       	jmp    8004c0 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800549:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800550:	e9 6b ff ff ff       	jmp    8004c0 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800555:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800556:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80055a:	0f 89 60 ff ff ff    	jns    8004c0 <vprintfmt+0x54>
				width = precision, precision = -1;
  800560:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800563:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800566:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80056d:	e9 4e ff ff ff       	jmp    8004c0 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800572:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800575:	e9 46 ff ff ff       	jmp    8004c0 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80057a:	8b 45 14             	mov    0x14(%ebp),%eax
  80057d:	83 c0 04             	add    $0x4,%eax
  800580:	89 45 14             	mov    %eax,0x14(%ebp)
  800583:	8b 45 14             	mov    0x14(%ebp),%eax
  800586:	83 e8 04             	sub    $0x4,%eax
  800589:	8b 00                	mov    (%eax),%eax
  80058b:	83 ec 08             	sub    $0x8,%esp
  80058e:	ff 75 0c             	pushl  0xc(%ebp)
  800591:	50                   	push   %eax
  800592:	8b 45 08             	mov    0x8(%ebp),%eax
  800595:	ff d0                	call   *%eax
  800597:	83 c4 10             	add    $0x10,%esp
			break;
  80059a:	e9 89 02 00 00       	jmp    800828 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80059f:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a2:	83 c0 04             	add    $0x4,%eax
  8005a5:	89 45 14             	mov    %eax,0x14(%ebp)
  8005a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ab:	83 e8 04             	sub    $0x4,%eax
  8005ae:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005b0:	85 db                	test   %ebx,%ebx
  8005b2:	79 02                	jns    8005b6 <vprintfmt+0x14a>
				err = -err;
  8005b4:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005b6:	83 fb 64             	cmp    $0x64,%ebx
  8005b9:	7f 0b                	jg     8005c6 <vprintfmt+0x15a>
  8005bb:	8b 34 9d 60 1a 80 00 	mov    0x801a60(,%ebx,4),%esi
  8005c2:	85 f6                	test   %esi,%esi
  8005c4:	75 19                	jne    8005df <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005c6:	53                   	push   %ebx
  8005c7:	68 05 1c 80 00       	push   $0x801c05
  8005cc:	ff 75 0c             	pushl  0xc(%ebp)
  8005cf:	ff 75 08             	pushl  0x8(%ebp)
  8005d2:	e8 5e 02 00 00       	call   800835 <printfmt>
  8005d7:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005da:	e9 49 02 00 00       	jmp    800828 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005df:	56                   	push   %esi
  8005e0:	68 0e 1c 80 00       	push   $0x801c0e
  8005e5:	ff 75 0c             	pushl  0xc(%ebp)
  8005e8:	ff 75 08             	pushl  0x8(%ebp)
  8005eb:	e8 45 02 00 00       	call   800835 <printfmt>
  8005f0:	83 c4 10             	add    $0x10,%esp
			break;
  8005f3:	e9 30 02 00 00       	jmp    800828 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8005fb:	83 c0 04             	add    $0x4,%eax
  8005fe:	89 45 14             	mov    %eax,0x14(%ebp)
  800601:	8b 45 14             	mov    0x14(%ebp),%eax
  800604:	83 e8 04             	sub    $0x4,%eax
  800607:	8b 30                	mov    (%eax),%esi
  800609:	85 f6                	test   %esi,%esi
  80060b:	75 05                	jne    800612 <vprintfmt+0x1a6>
				p = "(null)";
  80060d:	be 11 1c 80 00       	mov    $0x801c11,%esi
			if (width > 0 && padc != '-')
  800612:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800616:	7e 6d                	jle    800685 <vprintfmt+0x219>
  800618:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80061c:	74 67                	je     800685 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80061e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800621:	83 ec 08             	sub    $0x8,%esp
  800624:	50                   	push   %eax
  800625:	56                   	push   %esi
  800626:	e8 0c 03 00 00       	call   800937 <strnlen>
  80062b:	83 c4 10             	add    $0x10,%esp
  80062e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800631:	eb 16                	jmp    800649 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800633:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800637:	83 ec 08             	sub    $0x8,%esp
  80063a:	ff 75 0c             	pushl  0xc(%ebp)
  80063d:	50                   	push   %eax
  80063e:	8b 45 08             	mov    0x8(%ebp),%eax
  800641:	ff d0                	call   *%eax
  800643:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800646:	ff 4d e4             	decl   -0x1c(%ebp)
  800649:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80064d:	7f e4                	jg     800633 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80064f:	eb 34                	jmp    800685 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800651:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800655:	74 1c                	je     800673 <vprintfmt+0x207>
  800657:	83 fb 1f             	cmp    $0x1f,%ebx
  80065a:	7e 05                	jle    800661 <vprintfmt+0x1f5>
  80065c:	83 fb 7e             	cmp    $0x7e,%ebx
  80065f:	7e 12                	jle    800673 <vprintfmt+0x207>
					putch('?', putdat);
  800661:	83 ec 08             	sub    $0x8,%esp
  800664:	ff 75 0c             	pushl  0xc(%ebp)
  800667:	6a 3f                	push   $0x3f
  800669:	8b 45 08             	mov    0x8(%ebp),%eax
  80066c:	ff d0                	call   *%eax
  80066e:	83 c4 10             	add    $0x10,%esp
  800671:	eb 0f                	jmp    800682 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800673:	83 ec 08             	sub    $0x8,%esp
  800676:	ff 75 0c             	pushl  0xc(%ebp)
  800679:	53                   	push   %ebx
  80067a:	8b 45 08             	mov    0x8(%ebp),%eax
  80067d:	ff d0                	call   *%eax
  80067f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800682:	ff 4d e4             	decl   -0x1c(%ebp)
  800685:	89 f0                	mov    %esi,%eax
  800687:	8d 70 01             	lea    0x1(%eax),%esi
  80068a:	8a 00                	mov    (%eax),%al
  80068c:	0f be d8             	movsbl %al,%ebx
  80068f:	85 db                	test   %ebx,%ebx
  800691:	74 24                	je     8006b7 <vprintfmt+0x24b>
  800693:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800697:	78 b8                	js     800651 <vprintfmt+0x1e5>
  800699:	ff 4d e0             	decl   -0x20(%ebp)
  80069c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006a0:	79 af                	jns    800651 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006a2:	eb 13                	jmp    8006b7 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006a4:	83 ec 08             	sub    $0x8,%esp
  8006a7:	ff 75 0c             	pushl  0xc(%ebp)
  8006aa:	6a 20                	push   $0x20
  8006ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8006af:	ff d0                	call   *%eax
  8006b1:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006b4:	ff 4d e4             	decl   -0x1c(%ebp)
  8006b7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006bb:	7f e7                	jg     8006a4 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006bd:	e9 66 01 00 00       	jmp    800828 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006c2:	83 ec 08             	sub    $0x8,%esp
  8006c5:	ff 75 e8             	pushl  -0x18(%ebp)
  8006c8:	8d 45 14             	lea    0x14(%ebp),%eax
  8006cb:	50                   	push   %eax
  8006cc:	e8 3c fd ff ff       	call   80040d <getint>
  8006d1:	83 c4 10             	add    $0x10,%esp
  8006d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006d7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006dd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006e0:	85 d2                	test   %edx,%edx
  8006e2:	79 23                	jns    800707 <vprintfmt+0x29b>
				putch('-', putdat);
  8006e4:	83 ec 08             	sub    $0x8,%esp
  8006e7:	ff 75 0c             	pushl  0xc(%ebp)
  8006ea:	6a 2d                	push   $0x2d
  8006ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ef:	ff d0                	call   *%eax
  8006f1:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006f7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006fa:	f7 d8                	neg    %eax
  8006fc:	83 d2 00             	adc    $0x0,%edx
  8006ff:	f7 da                	neg    %edx
  800701:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800704:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800707:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80070e:	e9 bc 00 00 00       	jmp    8007cf <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800713:	83 ec 08             	sub    $0x8,%esp
  800716:	ff 75 e8             	pushl  -0x18(%ebp)
  800719:	8d 45 14             	lea    0x14(%ebp),%eax
  80071c:	50                   	push   %eax
  80071d:	e8 84 fc ff ff       	call   8003a6 <getuint>
  800722:	83 c4 10             	add    $0x10,%esp
  800725:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800728:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80072b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800732:	e9 98 00 00 00       	jmp    8007cf <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800737:	83 ec 08             	sub    $0x8,%esp
  80073a:	ff 75 0c             	pushl  0xc(%ebp)
  80073d:	6a 58                	push   $0x58
  80073f:	8b 45 08             	mov    0x8(%ebp),%eax
  800742:	ff d0                	call   *%eax
  800744:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800747:	83 ec 08             	sub    $0x8,%esp
  80074a:	ff 75 0c             	pushl  0xc(%ebp)
  80074d:	6a 58                	push   $0x58
  80074f:	8b 45 08             	mov    0x8(%ebp),%eax
  800752:	ff d0                	call   *%eax
  800754:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800757:	83 ec 08             	sub    $0x8,%esp
  80075a:	ff 75 0c             	pushl  0xc(%ebp)
  80075d:	6a 58                	push   $0x58
  80075f:	8b 45 08             	mov    0x8(%ebp),%eax
  800762:	ff d0                	call   *%eax
  800764:	83 c4 10             	add    $0x10,%esp
			break;
  800767:	e9 bc 00 00 00       	jmp    800828 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80076c:	83 ec 08             	sub    $0x8,%esp
  80076f:	ff 75 0c             	pushl  0xc(%ebp)
  800772:	6a 30                	push   $0x30
  800774:	8b 45 08             	mov    0x8(%ebp),%eax
  800777:	ff d0                	call   *%eax
  800779:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80077c:	83 ec 08             	sub    $0x8,%esp
  80077f:	ff 75 0c             	pushl  0xc(%ebp)
  800782:	6a 78                	push   $0x78
  800784:	8b 45 08             	mov    0x8(%ebp),%eax
  800787:	ff d0                	call   *%eax
  800789:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80078c:	8b 45 14             	mov    0x14(%ebp),%eax
  80078f:	83 c0 04             	add    $0x4,%eax
  800792:	89 45 14             	mov    %eax,0x14(%ebp)
  800795:	8b 45 14             	mov    0x14(%ebp),%eax
  800798:	83 e8 04             	sub    $0x4,%eax
  80079b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80079d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007a7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007ae:	eb 1f                	jmp    8007cf <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007b0:	83 ec 08             	sub    $0x8,%esp
  8007b3:	ff 75 e8             	pushl  -0x18(%ebp)
  8007b6:	8d 45 14             	lea    0x14(%ebp),%eax
  8007b9:	50                   	push   %eax
  8007ba:	e8 e7 fb ff ff       	call   8003a6 <getuint>
  8007bf:	83 c4 10             	add    $0x10,%esp
  8007c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007c5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007c8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007cf:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007d6:	83 ec 04             	sub    $0x4,%esp
  8007d9:	52                   	push   %edx
  8007da:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007dd:	50                   	push   %eax
  8007de:	ff 75 f4             	pushl  -0xc(%ebp)
  8007e1:	ff 75 f0             	pushl  -0x10(%ebp)
  8007e4:	ff 75 0c             	pushl  0xc(%ebp)
  8007e7:	ff 75 08             	pushl  0x8(%ebp)
  8007ea:	e8 00 fb ff ff       	call   8002ef <printnum>
  8007ef:	83 c4 20             	add    $0x20,%esp
			break;
  8007f2:	eb 34                	jmp    800828 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007f4:	83 ec 08             	sub    $0x8,%esp
  8007f7:	ff 75 0c             	pushl  0xc(%ebp)
  8007fa:	53                   	push   %ebx
  8007fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fe:	ff d0                	call   *%eax
  800800:	83 c4 10             	add    $0x10,%esp
			break;
  800803:	eb 23                	jmp    800828 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800805:	83 ec 08             	sub    $0x8,%esp
  800808:	ff 75 0c             	pushl  0xc(%ebp)
  80080b:	6a 25                	push   $0x25
  80080d:	8b 45 08             	mov    0x8(%ebp),%eax
  800810:	ff d0                	call   *%eax
  800812:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800815:	ff 4d 10             	decl   0x10(%ebp)
  800818:	eb 03                	jmp    80081d <vprintfmt+0x3b1>
  80081a:	ff 4d 10             	decl   0x10(%ebp)
  80081d:	8b 45 10             	mov    0x10(%ebp),%eax
  800820:	48                   	dec    %eax
  800821:	8a 00                	mov    (%eax),%al
  800823:	3c 25                	cmp    $0x25,%al
  800825:	75 f3                	jne    80081a <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800827:	90                   	nop
		}
	}
  800828:	e9 47 fc ff ff       	jmp    800474 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80082d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80082e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800831:	5b                   	pop    %ebx
  800832:	5e                   	pop    %esi
  800833:	5d                   	pop    %ebp
  800834:	c3                   	ret    

00800835 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800835:	55                   	push   %ebp
  800836:	89 e5                	mov    %esp,%ebp
  800838:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80083b:	8d 45 10             	lea    0x10(%ebp),%eax
  80083e:	83 c0 04             	add    $0x4,%eax
  800841:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800844:	8b 45 10             	mov    0x10(%ebp),%eax
  800847:	ff 75 f4             	pushl  -0xc(%ebp)
  80084a:	50                   	push   %eax
  80084b:	ff 75 0c             	pushl  0xc(%ebp)
  80084e:	ff 75 08             	pushl  0x8(%ebp)
  800851:	e8 16 fc ff ff       	call   80046c <vprintfmt>
  800856:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800859:	90                   	nop
  80085a:	c9                   	leave  
  80085b:	c3                   	ret    

0080085c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80085c:	55                   	push   %ebp
  80085d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80085f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800862:	8b 40 08             	mov    0x8(%eax),%eax
  800865:	8d 50 01             	lea    0x1(%eax),%edx
  800868:	8b 45 0c             	mov    0xc(%ebp),%eax
  80086b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80086e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800871:	8b 10                	mov    (%eax),%edx
  800873:	8b 45 0c             	mov    0xc(%ebp),%eax
  800876:	8b 40 04             	mov    0x4(%eax),%eax
  800879:	39 c2                	cmp    %eax,%edx
  80087b:	73 12                	jae    80088f <sprintputch+0x33>
		*b->buf++ = ch;
  80087d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800880:	8b 00                	mov    (%eax),%eax
  800882:	8d 48 01             	lea    0x1(%eax),%ecx
  800885:	8b 55 0c             	mov    0xc(%ebp),%edx
  800888:	89 0a                	mov    %ecx,(%edx)
  80088a:	8b 55 08             	mov    0x8(%ebp),%edx
  80088d:	88 10                	mov    %dl,(%eax)
}
  80088f:	90                   	nop
  800890:	5d                   	pop    %ebp
  800891:	c3                   	ret    

00800892 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800892:	55                   	push   %ebp
  800893:	89 e5                	mov    %esp,%ebp
  800895:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800898:	8b 45 08             	mov    0x8(%ebp),%eax
  80089b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80089e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a7:	01 d0                	add    %edx,%eax
  8008a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008b3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008b7:	74 06                	je     8008bf <vsnprintf+0x2d>
  8008b9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008bd:	7f 07                	jg     8008c6 <vsnprintf+0x34>
		return -E_INVAL;
  8008bf:	b8 03 00 00 00       	mov    $0x3,%eax
  8008c4:	eb 20                	jmp    8008e6 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008c6:	ff 75 14             	pushl  0x14(%ebp)
  8008c9:	ff 75 10             	pushl  0x10(%ebp)
  8008cc:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008cf:	50                   	push   %eax
  8008d0:	68 5c 08 80 00       	push   $0x80085c
  8008d5:	e8 92 fb ff ff       	call   80046c <vprintfmt>
  8008da:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008e0:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008e6:	c9                   	leave  
  8008e7:	c3                   	ret    

008008e8 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008e8:	55                   	push   %ebp
  8008e9:	89 e5                	mov    %esp,%ebp
  8008eb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008ee:	8d 45 10             	lea    0x10(%ebp),%eax
  8008f1:	83 c0 04             	add    $0x4,%eax
  8008f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8008fa:	ff 75 f4             	pushl  -0xc(%ebp)
  8008fd:	50                   	push   %eax
  8008fe:	ff 75 0c             	pushl  0xc(%ebp)
  800901:	ff 75 08             	pushl  0x8(%ebp)
  800904:	e8 89 ff ff ff       	call   800892 <vsnprintf>
  800909:	83 c4 10             	add    $0x10,%esp
  80090c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80090f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800912:	c9                   	leave  
  800913:	c3                   	ret    

00800914 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800914:	55                   	push   %ebp
  800915:	89 e5                	mov    %esp,%ebp
  800917:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80091a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800921:	eb 06                	jmp    800929 <strlen+0x15>
		n++;
  800923:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800926:	ff 45 08             	incl   0x8(%ebp)
  800929:	8b 45 08             	mov    0x8(%ebp),%eax
  80092c:	8a 00                	mov    (%eax),%al
  80092e:	84 c0                	test   %al,%al
  800930:	75 f1                	jne    800923 <strlen+0xf>
		n++;
	return n;
  800932:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800935:	c9                   	leave  
  800936:	c3                   	ret    

00800937 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800937:	55                   	push   %ebp
  800938:	89 e5                	mov    %esp,%ebp
  80093a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80093d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800944:	eb 09                	jmp    80094f <strnlen+0x18>
		n++;
  800946:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800949:	ff 45 08             	incl   0x8(%ebp)
  80094c:	ff 4d 0c             	decl   0xc(%ebp)
  80094f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800953:	74 09                	je     80095e <strnlen+0x27>
  800955:	8b 45 08             	mov    0x8(%ebp),%eax
  800958:	8a 00                	mov    (%eax),%al
  80095a:	84 c0                	test   %al,%al
  80095c:	75 e8                	jne    800946 <strnlen+0xf>
		n++;
	return n;
  80095e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800961:	c9                   	leave  
  800962:	c3                   	ret    

00800963 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800963:	55                   	push   %ebp
  800964:	89 e5                	mov    %esp,%ebp
  800966:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800969:	8b 45 08             	mov    0x8(%ebp),%eax
  80096c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80096f:	90                   	nop
  800970:	8b 45 08             	mov    0x8(%ebp),%eax
  800973:	8d 50 01             	lea    0x1(%eax),%edx
  800976:	89 55 08             	mov    %edx,0x8(%ebp)
  800979:	8b 55 0c             	mov    0xc(%ebp),%edx
  80097c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80097f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800982:	8a 12                	mov    (%edx),%dl
  800984:	88 10                	mov    %dl,(%eax)
  800986:	8a 00                	mov    (%eax),%al
  800988:	84 c0                	test   %al,%al
  80098a:	75 e4                	jne    800970 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80098c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80098f:	c9                   	leave  
  800990:	c3                   	ret    

00800991 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800991:	55                   	push   %ebp
  800992:	89 e5                	mov    %esp,%ebp
  800994:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800997:	8b 45 08             	mov    0x8(%ebp),%eax
  80099a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80099d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009a4:	eb 1f                	jmp    8009c5 <strncpy+0x34>
		*dst++ = *src;
  8009a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a9:	8d 50 01             	lea    0x1(%eax),%edx
  8009ac:	89 55 08             	mov    %edx,0x8(%ebp)
  8009af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009b2:	8a 12                	mov    (%edx),%dl
  8009b4:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b9:	8a 00                	mov    (%eax),%al
  8009bb:	84 c0                	test   %al,%al
  8009bd:	74 03                	je     8009c2 <strncpy+0x31>
			src++;
  8009bf:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009c2:	ff 45 fc             	incl   -0x4(%ebp)
  8009c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009c8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009cb:	72 d9                	jb     8009a6 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009d0:	c9                   	leave  
  8009d1:	c3                   	ret    

008009d2 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009d2:	55                   	push   %ebp
  8009d3:	89 e5                	mov    %esp,%ebp
  8009d5:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009db:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009de:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009e2:	74 30                	je     800a14 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009e4:	eb 16                	jmp    8009fc <strlcpy+0x2a>
			*dst++ = *src++;
  8009e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e9:	8d 50 01             	lea    0x1(%eax),%edx
  8009ec:	89 55 08             	mov    %edx,0x8(%ebp)
  8009ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009f2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009f5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009f8:	8a 12                	mov    (%edx),%dl
  8009fa:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009fc:	ff 4d 10             	decl   0x10(%ebp)
  8009ff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a03:	74 09                	je     800a0e <strlcpy+0x3c>
  800a05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a08:	8a 00                	mov    (%eax),%al
  800a0a:	84 c0                	test   %al,%al
  800a0c:	75 d8                	jne    8009e6 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a11:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a14:	8b 55 08             	mov    0x8(%ebp),%edx
  800a17:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a1a:	29 c2                	sub    %eax,%edx
  800a1c:	89 d0                	mov    %edx,%eax
}
  800a1e:	c9                   	leave  
  800a1f:	c3                   	ret    

00800a20 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a20:	55                   	push   %ebp
  800a21:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a23:	eb 06                	jmp    800a2b <strcmp+0xb>
		p++, q++;
  800a25:	ff 45 08             	incl   0x8(%ebp)
  800a28:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2e:	8a 00                	mov    (%eax),%al
  800a30:	84 c0                	test   %al,%al
  800a32:	74 0e                	je     800a42 <strcmp+0x22>
  800a34:	8b 45 08             	mov    0x8(%ebp),%eax
  800a37:	8a 10                	mov    (%eax),%dl
  800a39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3c:	8a 00                	mov    (%eax),%al
  800a3e:	38 c2                	cmp    %al,%dl
  800a40:	74 e3                	je     800a25 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a42:	8b 45 08             	mov    0x8(%ebp),%eax
  800a45:	8a 00                	mov    (%eax),%al
  800a47:	0f b6 d0             	movzbl %al,%edx
  800a4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4d:	8a 00                	mov    (%eax),%al
  800a4f:	0f b6 c0             	movzbl %al,%eax
  800a52:	29 c2                	sub    %eax,%edx
  800a54:	89 d0                	mov    %edx,%eax
}
  800a56:	5d                   	pop    %ebp
  800a57:	c3                   	ret    

00800a58 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a58:	55                   	push   %ebp
  800a59:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a5b:	eb 09                	jmp    800a66 <strncmp+0xe>
		n--, p++, q++;
  800a5d:	ff 4d 10             	decl   0x10(%ebp)
  800a60:	ff 45 08             	incl   0x8(%ebp)
  800a63:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a66:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a6a:	74 17                	je     800a83 <strncmp+0x2b>
  800a6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6f:	8a 00                	mov    (%eax),%al
  800a71:	84 c0                	test   %al,%al
  800a73:	74 0e                	je     800a83 <strncmp+0x2b>
  800a75:	8b 45 08             	mov    0x8(%ebp),%eax
  800a78:	8a 10                	mov    (%eax),%dl
  800a7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a7d:	8a 00                	mov    (%eax),%al
  800a7f:	38 c2                	cmp    %al,%dl
  800a81:	74 da                	je     800a5d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a83:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a87:	75 07                	jne    800a90 <strncmp+0x38>
		return 0;
  800a89:	b8 00 00 00 00       	mov    $0x0,%eax
  800a8e:	eb 14                	jmp    800aa4 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a90:	8b 45 08             	mov    0x8(%ebp),%eax
  800a93:	8a 00                	mov    (%eax),%al
  800a95:	0f b6 d0             	movzbl %al,%edx
  800a98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9b:	8a 00                	mov    (%eax),%al
  800a9d:	0f b6 c0             	movzbl %al,%eax
  800aa0:	29 c2                	sub    %eax,%edx
  800aa2:	89 d0                	mov    %edx,%eax
}
  800aa4:	5d                   	pop    %ebp
  800aa5:	c3                   	ret    

00800aa6 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800aa6:	55                   	push   %ebp
  800aa7:	89 e5                	mov    %esp,%ebp
  800aa9:	83 ec 04             	sub    $0x4,%esp
  800aac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aaf:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ab2:	eb 12                	jmp    800ac6 <strchr+0x20>
		if (*s == c)
  800ab4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab7:	8a 00                	mov    (%eax),%al
  800ab9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800abc:	75 05                	jne    800ac3 <strchr+0x1d>
			return (char *) s;
  800abe:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac1:	eb 11                	jmp    800ad4 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ac3:	ff 45 08             	incl   0x8(%ebp)
  800ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac9:	8a 00                	mov    (%eax),%al
  800acb:	84 c0                	test   %al,%al
  800acd:	75 e5                	jne    800ab4 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800acf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ad4:	c9                   	leave  
  800ad5:	c3                   	ret    

00800ad6 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ad6:	55                   	push   %ebp
  800ad7:	89 e5                	mov    %esp,%ebp
  800ad9:	83 ec 04             	sub    $0x4,%esp
  800adc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800adf:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ae2:	eb 0d                	jmp    800af1 <strfind+0x1b>
		if (*s == c)
  800ae4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae7:	8a 00                	mov    (%eax),%al
  800ae9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800aec:	74 0e                	je     800afc <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800aee:	ff 45 08             	incl   0x8(%ebp)
  800af1:	8b 45 08             	mov    0x8(%ebp),%eax
  800af4:	8a 00                	mov    (%eax),%al
  800af6:	84 c0                	test   %al,%al
  800af8:	75 ea                	jne    800ae4 <strfind+0xe>
  800afa:	eb 01                	jmp    800afd <strfind+0x27>
		if (*s == c)
			break;
  800afc:	90                   	nop
	return (char *) s;
  800afd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b00:	c9                   	leave  
  800b01:	c3                   	ret    

00800b02 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b02:	55                   	push   %ebp
  800b03:	89 e5                	mov    %esp,%ebp
  800b05:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b08:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b0e:	8b 45 10             	mov    0x10(%ebp),%eax
  800b11:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b14:	eb 0e                	jmp    800b24 <memset+0x22>
		*p++ = c;
  800b16:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b19:	8d 50 01             	lea    0x1(%eax),%edx
  800b1c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b1f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b22:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b24:	ff 4d f8             	decl   -0x8(%ebp)
  800b27:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b2b:	79 e9                	jns    800b16 <memset+0x14>
		*p++ = c;

	return v;
  800b2d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b30:	c9                   	leave  
  800b31:	c3                   	ret    

00800b32 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b32:	55                   	push   %ebp
  800b33:	89 e5                	mov    %esp,%ebp
  800b35:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b38:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b41:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b44:	eb 16                	jmp    800b5c <memcpy+0x2a>
		*d++ = *s++;
  800b46:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b49:	8d 50 01             	lea    0x1(%eax),%edx
  800b4c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b4f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b52:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b55:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b58:	8a 12                	mov    (%edx),%dl
  800b5a:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b5c:	8b 45 10             	mov    0x10(%ebp),%eax
  800b5f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b62:	89 55 10             	mov    %edx,0x10(%ebp)
  800b65:	85 c0                	test   %eax,%eax
  800b67:	75 dd                	jne    800b46 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b69:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b6c:	c9                   	leave  
  800b6d:	c3                   	ret    

00800b6e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b6e:	55                   	push   %ebp
  800b6f:	89 e5                	mov    %esp,%ebp
  800b71:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b77:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b80:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b83:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b86:	73 50                	jae    800bd8 <memmove+0x6a>
  800b88:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b8b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8e:	01 d0                	add    %edx,%eax
  800b90:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b93:	76 43                	jbe    800bd8 <memmove+0x6a>
		s += n;
  800b95:	8b 45 10             	mov    0x10(%ebp),%eax
  800b98:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b9b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b9e:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ba1:	eb 10                	jmp    800bb3 <memmove+0x45>
			*--d = *--s;
  800ba3:	ff 4d f8             	decl   -0x8(%ebp)
  800ba6:	ff 4d fc             	decl   -0x4(%ebp)
  800ba9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bac:	8a 10                	mov    (%eax),%dl
  800bae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bb1:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bb3:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bb9:	89 55 10             	mov    %edx,0x10(%ebp)
  800bbc:	85 c0                	test   %eax,%eax
  800bbe:	75 e3                	jne    800ba3 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bc0:	eb 23                	jmp    800be5 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bc2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bc5:	8d 50 01             	lea    0x1(%eax),%edx
  800bc8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bcb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bce:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bd1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bd4:	8a 12                	mov    (%edx),%dl
  800bd6:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bd8:	8b 45 10             	mov    0x10(%ebp),%eax
  800bdb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bde:	89 55 10             	mov    %edx,0x10(%ebp)
  800be1:	85 c0                	test   %eax,%eax
  800be3:	75 dd                	jne    800bc2 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800be5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800be8:	c9                   	leave  
  800be9:	c3                   	ret    

00800bea <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bea:	55                   	push   %ebp
  800beb:	89 e5                	mov    %esp,%ebp
  800bed:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bf6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf9:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bfc:	eb 2a                	jmp    800c28 <memcmp+0x3e>
		if (*s1 != *s2)
  800bfe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c01:	8a 10                	mov    (%eax),%dl
  800c03:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c06:	8a 00                	mov    (%eax),%al
  800c08:	38 c2                	cmp    %al,%dl
  800c0a:	74 16                	je     800c22 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c0c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c0f:	8a 00                	mov    (%eax),%al
  800c11:	0f b6 d0             	movzbl %al,%edx
  800c14:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c17:	8a 00                	mov    (%eax),%al
  800c19:	0f b6 c0             	movzbl %al,%eax
  800c1c:	29 c2                	sub    %eax,%edx
  800c1e:	89 d0                	mov    %edx,%eax
  800c20:	eb 18                	jmp    800c3a <memcmp+0x50>
		s1++, s2++;
  800c22:	ff 45 fc             	incl   -0x4(%ebp)
  800c25:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c28:	8b 45 10             	mov    0x10(%ebp),%eax
  800c2b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c2e:	89 55 10             	mov    %edx,0x10(%ebp)
  800c31:	85 c0                	test   %eax,%eax
  800c33:	75 c9                	jne    800bfe <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c35:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c3a:	c9                   	leave  
  800c3b:	c3                   	ret    

00800c3c <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c3c:	55                   	push   %ebp
  800c3d:	89 e5                	mov    %esp,%ebp
  800c3f:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c42:	8b 55 08             	mov    0x8(%ebp),%edx
  800c45:	8b 45 10             	mov    0x10(%ebp),%eax
  800c48:	01 d0                	add    %edx,%eax
  800c4a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c4d:	eb 15                	jmp    800c64 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c52:	8a 00                	mov    (%eax),%al
  800c54:	0f b6 d0             	movzbl %al,%edx
  800c57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5a:	0f b6 c0             	movzbl %al,%eax
  800c5d:	39 c2                	cmp    %eax,%edx
  800c5f:	74 0d                	je     800c6e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c61:	ff 45 08             	incl   0x8(%ebp)
  800c64:	8b 45 08             	mov    0x8(%ebp),%eax
  800c67:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c6a:	72 e3                	jb     800c4f <memfind+0x13>
  800c6c:	eb 01                	jmp    800c6f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c6e:	90                   	nop
	return (void *) s;
  800c6f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c72:	c9                   	leave  
  800c73:	c3                   	ret    

00800c74 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c74:	55                   	push   %ebp
  800c75:	89 e5                	mov    %esp,%ebp
  800c77:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c7a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c81:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c88:	eb 03                	jmp    800c8d <strtol+0x19>
		s++;
  800c8a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c90:	8a 00                	mov    (%eax),%al
  800c92:	3c 20                	cmp    $0x20,%al
  800c94:	74 f4                	je     800c8a <strtol+0x16>
  800c96:	8b 45 08             	mov    0x8(%ebp),%eax
  800c99:	8a 00                	mov    (%eax),%al
  800c9b:	3c 09                	cmp    $0x9,%al
  800c9d:	74 eb                	je     800c8a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca2:	8a 00                	mov    (%eax),%al
  800ca4:	3c 2b                	cmp    $0x2b,%al
  800ca6:	75 05                	jne    800cad <strtol+0x39>
		s++;
  800ca8:	ff 45 08             	incl   0x8(%ebp)
  800cab:	eb 13                	jmp    800cc0 <strtol+0x4c>
	else if (*s == '-')
  800cad:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb0:	8a 00                	mov    (%eax),%al
  800cb2:	3c 2d                	cmp    $0x2d,%al
  800cb4:	75 0a                	jne    800cc0 <strtol+0x4c>
		s++, neg = 1;
  800cb6:	ff 45 08             	incl   0x8(%ebp)
  800cb9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cc0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc4:	74 06                	je     800ccc <strtol+0x58>
  800cc6:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cca:	75 20                	jne    800cec <strtol+0x78>
  800ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccf:	8a 00                	mov    (%eax),%al
  800cd1:	3c 30                	cmp    $0x30,%al
  800cd3:	75 17                	jne    800cec <strtol+0x78>
  800cd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd8:	40                   	inc    %eax
  800cd9:	8a 00                	mov    (%eax),%al
  800cdb:	3c 78                	cmp    $0x78,%al
  800cdd:	75 0d                	jne    800cec <strtol+0x78>
		s += 2, base = 16;
  800cdf:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800ce3:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cea:	eb 28                	jmp    800d14 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800cec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf0:	75 15                	jne    800d07 <strtol+0x93>
  800cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf5:	8a 00                	mov    (%eax),%al
  800cf7:	3c 30                	cmp    $0x30,%al
  800cf9:	75 0c                	jne    800d07 <strtol+0x93>
		s++, base = 8;
  800cfb:	ff 45 08             	incl   0x8(%ebp)
  800cfe:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d05:	eb 0d                	jmp    800d14 <strtol+0xa0>
	else if (base == 0)
  800d07:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d0b:	75 07                	jne    800d14 <strtol+0xa0>
		base = 10;
  800d0d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d14:	8b 45 08             	mov    0x8(%ebp),%eax
  800d17:	8a 00                	mov    (%eax),%al
  800d19:	3c 2f                	cmp    $0x2f,%al
  800d1b:	7e 19                	jle    800d36 <strtol+0xc2>
  800d1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d20:	8a 00                	mov    (%eax),%al
  800d22:	3c 39                	cmp    $0x39,%al
  800d24:	7f 10                	jg     800d36 <strtol+0xc2>
			dig = *s - '0';
  800d26:	8b 45 08             	mov    0x8(%ebp),%eax
  800d29:	8a 00                	mov    (%eax),%al
  800d2b:	0f be c0             	movsbl %al,%eax
  800d2e:	83 e8 30             	sub    $0x30,%eax
  800d31:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d34:	eb 42                	jmp    800d78 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d36:	8b 45 08             	mov    0x8(%ebp),%eax
  800d39:	8a 00                	mov    (%eax),%al
  800d3b:	3c 60                	cmp    $0x60,%al
  800d3d:	7e 19                	jle    800d58 <strtol+0xe4>
  800d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d42:	8a 00                	mov    (%eax),%al
  800d44:	3c 7a                	cmp    $0x7a,%al
  800d46:	7f 10                	jg     800d58 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d48:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4b:	8a 00                	mov    (%eax),%al
  800d4d:	0f be c0             	movsbl %al,%eax
  800d50:	83 e8 57             	sub    $0x57,%eax
  800d53:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d56:	eb 20                	jmp    800d78 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d58:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5b:	8a 00                	mov    (%eax),%al
  800d5d:	3c 40                	cmp    $0x40,%al
  800d5f:	7e 39                	jle    800d9a <strtol+0x126>
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	8a 00                	mov    (%eax),%al
  800d66:	3c 5a                	cmp    $0x5a,%al
  800d68:	7f 30                	jg     800d9a <strtol+0x126>
			dig = *s - 'A' + 10;
  800d6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6d:	8a 00                	mov    (%eax),%al
  800d6f:	0f be c0             	movsbl %al,%eax
  800d72:	83 e8 37             	sub    $0x37,%eax
  800d75:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d78:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d7b:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d7e:	7d 19                	jge    800d99 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d80:	ff 45 08             	incl   0x8(%ebp)
  800d83:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d86:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d8a:	89 c2                	mov    %eax,%edx
  800d8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d8f:	01 d0                	add    %edx,%eax
  800d91:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d94:	e9 7b ff ff ff       	jmp    800d14 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d99:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d9a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d9e:	74 08                	je     800da8 <strtol+0x134>
		*endptr = (char *) s;
  800da0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da3:	8b 55 08             	mov    0x8(%ebp),%edx
  800da6:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800da8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800dac:	74 07                	je     800db5 <strtol+0x141>
  800dae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db1:	f7 d8                	neg    %eax
  800db3:	eb 03                	jmp    800db8 <strtol+0x144>
  800db5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800db8:	c9                   	leave  
  800db9:	c3                   	ret    

00800dba <ltostr>:

void
ltostr(long value, char *str)
{
  800dba:	55                   	push   %ebp
  800dbb:	89 e5                	mov    %esp,%ebp
  800dbd:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dc0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800dc7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800dce:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dd2:	79 13                	jns    800de7 <ltostr+0x2d>
	{
		neg = 1;
  800dd4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800ddb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dde:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800de1:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800de4:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800de7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dea:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800def:	99                   	cltd   
  800df0:	f7 f9                	idiv   %ecx
  800df2:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800df5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df8:	8d 50 01             	lea    0x1(%eax),%edx
  800dfb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dfe:	89 c2                	mov    %eax,%edx
  800e00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e03:	01 d0                	add    %edx,%eax
  800e05:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e08:	83 c2 30             	add    $0x30,%edx
  800e0b:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e0d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e10:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e15:	f7 e9                	imul   %ecx
  800e17:	c1 fa 02             	sar    $0x2,%edx
  800e1a:	89 c8                	mov    %ecx,%eax
  800e1c:	c1 f8 1f             	sar    $0x1f,%eax
  800e1f:	29 c2                	sub    %eax,%edx
  800e21:	89 d0                	mov    %edx,%eax
  800e23:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e26:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e29:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e2e:	f7 e9                	imul   %ecx
  800e30:	c1 fa 02             	sar    $0x2,%edx
  800e33:	89 c8                	mov    %ecx,%eax
  800e35:	c1 f8 1f             	sar    $0x1f,%eax
  800e38:	29 c2                	sub    %eax,%edx
  800e3a:	89 d0                	mov    %edx,%eax
  800e3c:	c1 e0 02             	shl    $0x2,%eax
  800e3f:	01 d0                	add    %edx,%eax
  800e41:	01 c0                	add    %eax,%eax
  800e43:	29 c1                	sub    %eax,%ecx
  800e45:	89 ca                	mov    %ecx,%edx
  800e47:	85 d2                	test   %edx,%edx
  800e49:	75 9c                	jne    800de7 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e4b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e52:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e55:	48                   	dec    %eax
  800e56:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e59:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e5d:	74 3d                	je     800e9c <ltostr+0xe2>
		start = 1 ;
  800e5f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e66:	eb 34                	jmp    800e9c <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e68:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6e:	01 d0                	add    %edx,%eax
  800e70:	8a 00                	mov    (%eax),%al
  800e72:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e75:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7b:	01 c2                	add    %eax,%edx
  800e7d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e83:	01 c8                	add    %ecx,%eax
  800e85:	8a 00                	mov    (%eax),%al
  800e87:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e89:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8f:	01 c2                	add    %eax,%edx
  800e91:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e94:	88 02                	mov    %al,(%edx)
		start++ ;
  800e96:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e99:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e9f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ea2:	7c c4                	jl     800e68 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800ea4:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ea7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eaa:	01 d0                	add    %edx,%eax
  800eac:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800eaf:	90                   	nop
  800eb0:	c9                   	leave  
  800eb1:	c3                   	ret    

00800eb2 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800eb2:	55                   	push   %ebp
  800eb3:	89 e5                	mov    %esp,%ebp
  800eb5:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800eb8:	ff 75 08             	pushl  0x8(%ebp)
  800ebb:	e8 54 fa ff ff       	call   800914 <strlen>
  800ec0:	83 c4 04             	add    $0x4,%esp
  800ec3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800ec6:	ff 75 0c             	pushl  0xc(%ebp)
  800ec9:	e8 46 fa ff ff       	call   800914 <strlen>
  800ece:	83 c4 04             	add    $0x4,%esp
  800ed1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ed4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800edb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ee2:	eb 17                	jmp    800efb <strcconcat+0x49>
		final[s] = str1[s] ;
  800ee4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ee7:	8b 45 10             	mov    0x10(%ebp),%eax
  800eea:	01 c2                	add    %eax,%edx
  800eec:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800eef:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef2:	01 c8                	add    %ecx,%eax
  800ef4:	8a 00                	mov    (%eax),%al
  800ef6:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800ef8:	ff 45 fc             	incl   -0x4(%ebp)
  800efb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800efe:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f01:	7c e1                	jl     800ee4 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f03:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f0a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f11:	eb 1f                	jmp    800f32 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f13:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f16:	8d 50 01             	lea    0x1(%eax),%edx
  800f19:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f1c:	89 c2                	mov    %eax,%edx
  800f1e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f21:	01 c2                	add    %eax,%edx
  800f23:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f29:	01 c8                	add    %ecx,%eax
  800f2b:	8a 00                	mov    (%eax),%al
  800f2d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f2f:	ff 45 f8             	incl   -0x8(%ebp)
  800f32:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f35:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f38:	7c d9                	jl     800f13 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f3a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f3d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f40:	01 d0                	add    %edx,%eax
  800f42:	c6 00 00             	movb   $0x0,(%eax)
}
  800f45:	90                   	nop
  800f46:	c9                   	leave  
  800f47:	c3                   	ret    

00800f48 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f48:	55                   	push   %ebp
  800f49:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f4b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f4e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f54:	8b 45 14             	mov    0x14(%ebp),%eax
  800f57:	8b 00                	mov    (%eax),%eax
  800f59:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f60:	8b 45 10             	mov    0x10(%ebp),%eax
  800f63:	01 d0                	add    %edx,%eax
  800f65:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f6b:	eb 0c                	jmp    800f79 <strsplit+0x31>
			*string++ = 0;
  800f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f70:	8d 50 01             	lea    0x1(%eax),%edx
  800f73:	89 55 08             	mov    %edx,0x8(%ebp)
  800f76:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7c:	8a 00                	mov    (%eax),%al
  800f7e:	84 c0                	test   %al,%al
  800f80:	74 18                	je     800f9a <strsplit+0x52>
  800f82:	8b 45 08             	mov    0x8(%ebp),%eax
  800f85:	8a 00                	mov    (%eax),%al
  800f87:	0f be c0             	movsbl %al,%eax
  800f8a:	50                   	push   %eax
  800f8b:	ff 75 0c             	pushl  0xc(%ebp)
  800f8e:	e8 13 fb ff ff       	call   800aa6 <strchr>
  800f93:	83 c4 08             	add    $0x8,%esp
  800f96:	85 c0                	test   %eax,%eax
  800f98:	75 d3                	jne    800f6d <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800f9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9d:	8a 00                	mov    (%eax),%al
  800f9f:	84 c0                	test   %al,%al
  800fa1:	74 5a                	je     800ffd <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800fa3:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa6:	8b 00                	mov    (%eax),%eax
  800fa8:	83 f8 0f             	cmp    $0xf,%eax
  800fab:	75 07                	jne    800fb4 <strsplit+0x6c>
		{
			return 0;
  800fad:	b8 00 00 00 00       	mov    $0x0,%eax
  800fb2:	eb 66                	jmp    80101a <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fb4:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb7:	8b 00                	mov    (%eax),%eax
  800fb9:	8d 48 01             	lea    0x1(%eax),%ecx
  800fbc:	8b 55 14             	mov    0x14(%ebp),%edx
  800fbf:	89 0a                	mov    %ecx,(%edx)
  800fc1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fc8:	8b 45 10             	mov    0x10(%ebp),%eax
  800fcb:	01 c2                	add    %eax,%edx
  800fcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd0:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fd2:	eb 03                	jmp    800fd7 <strsplit+0x8f>
			string++;
  800fd4:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fda:	8a 00                	mov    (%eax),%al
  800fdc:	84 c0                	test   %al,%al
  800fde:	74 8b                	je     800f6b <strsplit+0x23>
  800fe0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe3:	8a 00                	mov    (%eax),%al
  800fe5:	0f be c0             	movsbl %al,%eax
  800fe8:	50                   	push   %eax
  800fe9:	ff 75 0c             	pushl  0xc(%ebp)
  800fec:	e8 b5 fa ff ff       	call   800aa6 <strchr>
  800ff1:	83 c4 08             	add    $0x8,%esp
  800ff4:	85 c0                	test   %eax,%eax
  800ff6:	74 dc                	je     800fd4 <strsplit+0x8c>
			string++;
	}
  800ff8:	e9 6e ff ff ff       	jmp    800f6b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800ffd:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800ffe:	8b 45 14             	mov    0x14(%ebp),%eax
  801001:	8b 00                	mov    (%eax),%eax
  801003:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80100a:	8b 45 10             	mov    0x10(%ebp),%eax
  80100d:	01 d0                	add    %edx,%eax
  80100f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801015:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80101a:	c9                   	leave  
  80101b:	c3                   	ret    

0080101c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80101c:	55                   	push   %ebp
  80101d:	89 e5                	mov    %esp,%ebp
  80101f:	57                   	push   %edi
  801020:	56                   	push   %esi
  801021:	53                   	push   %ebx
  801022:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801025:	8b 45 08             	mov    0x8(%ebp),%eax
  801028:	8b 55 0c             	mov    0xc(%ebp),%edx
  80102b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80102e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801031:	8b 7d 18             	mov    0x18(%ebp),%edi
  801034:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801037:	cd 30                	int    $0x30
  801039:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80103c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80103f:	83 c4 10             	add    $0x10,%esp
  801042:	5b                   	pop    %ebx
  801043:	5e                   	pop    %esi
  801044:	5f                   	pop    %edi
  801045:	5d                   	pop    %ebp
  801046:	c3                   	ret    

00801047 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801047:	55                   	push   %ebp
  801048:	89 e5                	mov    %esp,%ebp
  80104a:	83 ec 04             	sub    $0x4,%esp
  80104d:	8b 45 10             	mov    0x10(%ebp),%eax
  801050:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801053:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801057:	8b 45 08             	mov    0x8(%ebp),%eax
  80105a:	6a 00                	push   $0x0
  80105c:	6a 00                	push   $0x0
  80105e:	52                   	push   %edx
  80105f:	ff 75 0c             	pushl  0xc(%ebp)
  801062:	50                   	push   %eax
  801063:	6a 00                	push   $0x0
  801065:	e8 b2 ff ff ff       	call   80101c <syscall>
  80106a:	83 c4 18             	add    $0x18,%esp
}
  80106d:	90                   	nop
  80106e:	c9                   	leave  
  80106f:	c3                   	ret    

00801070 <sys_cgetc>:

int
sys_cgetc(void)
{
  801070:	55                   	push   %ebp
  801071:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801073:	6a 00                	push   $0x0
  801075:	6a 00                	push   $0x0
  801077:	6a 00                	push   $0x0
  801079:	6a 00                	push   $0x0
  80107b:	6a 00                	push   $0x0
  80107d:	6a 01                	push   $0x1
  80107f:	e8 98 ff ff ff       	call   80101c <syscall>
  801084:	83 c4 18             	add    $0x18,%esp
}
  801087:	c9                   	leave  
  801088:	c3                   	ret    

00801089 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801089:	55                   	push   %ebp
  80108a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80108c:	8b 45 08             	mov    0x8(%ebp),%eax
  80108f:	6a 00                	push   $0x0
  801091:	6a 00                	push   $0x0
  801093:	6a 00                	push   $0x0
  801095:	6a 00                	push   $0x0
  801097:	50                   	push   %eax
  801098:	6a 05                	push   $0x5
  80109a:	e8 7d ff ff ff       	call   80101c <syscall>
  80109f:	83 c4 18             	add    $0x18,%esp
}
  8010a2:	c9                   	leave  
  8010a3:	c3                   	ret    

008010a4 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010a4:	55                   	push   %ebp
  8010a5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010a7:	6a 00                	push   $0x0
  8010a9:	6a 00                	push   $0x0
  8010ab:	6a 00                	push   $0x0
  8010ad:	6a 00                	push   $0x0
  8010af:	6a 00                	push   $0x0
  8010b1:	6a 02                	push   $0x2
  8010b3:	e8 64 ff ff ff       	call   80101c <syscall>
  8010b8:	83 c4 18             	add    $0x18,%esp
}
  8010bb:	c9                   	leave  
  8010bc:	c3                   	ret    

008010bd <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010bd:	55                   	push   %ebp
  8010be:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010c0:	6a 00                	push   $0x0
  8010c2:	6a 00                	push   $0x0
  8010c4:	6a 00                	push   $0x0
  8010c6:	6a 00                	push   $0x0
  8010c8:	6a 00                	push   $0x0
  8010ca:	6a 03                	push   $0x3
  8010cc:	e8 4b ff ff ff       	call   80101c <syscall>
  8010d1:	83 c4 18             	add    $0x18,%esp
}
  8010d4:	c9                   	leave  
  8010d5:	c3                   	ret    

008010d6 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010d6:	55                   	push   %ebp
  8010d7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010d9:	6a 00                	push   $0x0
  8010db:	6a 00                	push   $0x0
  8010dd:	6a 00                	push   $0x0
  8010df:	6a 00                	push   $0x0
  8010e1:	6a 00                	push   $0x0
  8010e3:	6a 04                	push   $0x4
  8010e5:	e8 32 ff ff ff       	call   80101c <syscall>
  8010ea:	83 c4 18             	add    $0x18,%esp
}
  8010ed:	c9                   	leave  
  8010ee:	c3                   	ret    

008010ef <sys_env_exit>:


void sys_env_exit(void)
{
  8010ef:	55                   	push   %ebp
  8010f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010f2:	6a 00                	push   $0x0
  8010f4:	6a 00                	push   $0x0
  8010f6:	6a 00                	push   $0x0
  8010f8:	6a 00                	push   $0x0
  8010fa:	6a 00                	push   $0x0
  8010fc:	6a 06                	push   $0x6
  8010fe:	e8 19 ff ff ff       	call   80101c <syscall>
  801103:	83 c4 18             	add    $0x18,%esp
}
  801106:	90                   	nop
  801107:	c9                   	leave  
  801108:	c3                   	ret    

00801109 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801109:	55                   	push   %ebp
  80110a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80110c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80110f:	8b 45 08             	mov    0x8(%ebp),%eax
  801112:	6a 00                	push   $0x0
  801114:	6a 00                	push   $0x0
  801116:	6a 00                	push   $0x0
  801118:	52                   	push   %edx
  801119:	50                   	push   %eax
  80111a:	6a 07                	push   $0x7
  80111c:	e8 fb fe ff ff       	call   80101c <syscall>
  801121:	83 c4 18             	add    $0x18,%esp
}
  801124:	c9                   	leave  
  801125:	c3                   	ret    

00801126 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801126:	55                   	push   %ebp
  801127:	89 e5                	mov    %esp,%ebp
  801129:	56                   	push   %esi
  80112a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80112b:	8b 75 18             	mov    0x18(%ebp),%esi
  80112e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801131:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801134:	8b 55 0c             	mov    0xc(%ebp),%edx
  801137:	8b 45 08             	mov    0x8(%ebp),%eax
  80113a:	56                   	push   %esi
  80113b:	53                   	push   %ebx
  80113c:	51                   	push   %ecx
  80113d:	52                   	push   %edx
  80113e:	50                   	push   %eax
  80113f:	6a 08                	push   $0x8
  801141:	e8 d6 fe ff ff       	call   80101c <syscall>
  801146:	83 c4 18             	add    $0x18,%esp
}
  801149:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80114c:	5b                   	pop    %ebx
  80114d:	5e                   	pop    %esi
  80114e:	5d                   	pop    %ebp
  80114f:	c3                   	ret    

00801150 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801150:	55                   	push   %ebp
  801151:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801153:	8b 55 0c             	mov    0xc(%ebp),%edx
  801156:	8b 45 08             	mov    0x8(%ebp),%eax
  801159:	6a 00                	push   $0x0
  80115b:	6a 00                	push   $0x0
  80115d:	6a 00                	push   $0x0
  80115f:	52                   	push   %edx
  801160:	50                   	push   %eax
  801161:	6a 09                	push   $0x9
  801163:	e8 b4 fe ff ff       	call   80101c <syscall>
  801168:	83 c4 18             	add    $0x18,%esp
}
  80116b:	c9                   	leave  
  80116c:	c3                   	ret    

0080116d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80116d:	55                   	push   %ebp
  80116e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801170:	6a 00                	push   $0x0
  801172:	6a 00                	push   $0x0
  801174:	6a 00                	push   $0x0
  801176:	ff 75 0c             	pushl  0xc(%ebp)
  801179:	ff 75 08             	pushl  0x8(%ebp)
  80117c:	6a 0a                	push   $0xa
  80117e:	e8 99 fe ff ff       	call   80101c <syscall>
  801183:	83 c4 18             	add    $0x18,%esp
}
  801186:	c9                   	leave  
  801187:	c3                   	ret    

00801188 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801188:	55                   	push   %ebp
  801189:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80118b:	6a 00                	push   $0x0
  80118d:	6a 00                	push   $0x0
  80118f:	6a 00                	push   $0x0
  801191:	6a 00                	push   $0x0
  801193:	6a 00                	push   $0x0
  801195:	6a 0b                	push   $0xb
  801197:	e8 80 fe ff ff       	call   80101c <syscall>
  80119c:	83 c4 18             	add    $0x18,%esp
}
  80119f:	c9                   	leave  
  8011a0:	c3                   	ret    

008011a1 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011a1:	55                   	push   %ebp
  8011a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011a4:	6a 00                	push   $0x0
  8011a6:	6a 00                	push   $0x0
  8011a8:	6a 00                	push   $0x0
  8011aa:	6a 00                	push   $0x0
  8011ac:	6a 00                	push   $0x0
  8011ae:	6a 0c                	push   $0xc
  8011b0:	e8 67 fe ff ff       	call   80101c <syscall>
  8011b5:	83 c4 18             	add    $0x18,%esp
}
  8011b8:	c9                   	leave  
  8011b9:	c3                   	ret    

008011ba <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011ba:	55                   	push   %ebp
  8011bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011bd:	6a 00                	push   $0x0
  8011bf:	6a 00                	push   $0x0
  8011c1:	6a 00                	push   $0x0
  8011c3:	6a 00                	push   $0x0
  8011c5:	6a 00                	push   $0x0
  8011c7:	6a 0d                	push   $0xd
  8011c9:	e8 4e fe ff ff       	call   80101c <syscall>
  8011ce:	83 c4 18             	add    $0x18,%esp
}
  8011d1:	c9                   	leave  
  8011d2:	c3                   	ret    

008011d3 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011d3:	55                   	push   %ebp
  8011d4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011d6:	6a 00                	push   $0x0
  8011d8:	6a 00                	push   $0x0
  8011da:	6a 00                	push   $0x0
  8011dc:	ff 75 0c             	pushl  0xc(%ebp)
  8011df:	ff 75 08             	pushl  0x8(%ebp)
  8011e2:	6a 11                	push   $0x11
  8011e4:	e8 33 fe ff ff       	call   80101c <syscall>
  8011e9:	83 c4 18             	add    $0x18,%esp
	return;
  8011ec:	90                   	nop
}
  8011ed:	c9                   	leave  
  8011ee:	c3                   	ret    

008011ef <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011ef:	55                   	push   %ebp
  8011f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011f2:	6a 00                	push   $0x0
  8011f4:	6a 00                	push   $0x0
  8011f6:	6a 00                	push   $0x0
  8011f8:	ff 75 0c             	pushl  0xc(%ebp)
  8011fb:	ff 75 08             	pushl  0x8(%ebp)
  8011fe:	6a 12                	push   $0x12
  801200:	e8 17 fe ff ff       	call   80101c <syscall>
  801205:	83 c4 18             	add    $0x18,%esp
	return ;
  801208:	90                   	nop
}
  801209:	c9                   	leave  
  80120a:	c3                   	ret    

0080120b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80120b:	55                   	push   %ebp
  80120c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80120e:	6a 00                	push   $0x0
  801210:	6a 00                	push   $0x0
  801212:	6a 00                	push   $0x0
  801214:	6a 00                	push   $0x0
  801216:	6a 00                	push   $0x0
  801218:	6a 0e                	push   $0xe
  80121a:	e8 fd fd ff ff       	call   80101c <syscall>
  80121f:	83 c4 18             	add    $0x18,%esp
}
  801222:	c9                   	leave  
  801223:	c3                   	ret    

00801224 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801224:	55                   	push   %ebp
  801225:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801227:	6a 00                	push   $0x0
  801229:	6a 00                	push   $0x0
  80122b:	6a 00                	push   $0x0
  80122d:	6a 00                	push   $0x0
  80122f:	ff 75 08             	pushl  0x8(%ebp)
  801232:	6a 0f                	push   $0xf
  801234:	e8 e3 fd ff ff       	call   80101c <syscall>
  801239:	83 c4 18             	add    $0x18,%esp
}
  80123c:	c9                   	leave  
  80123d:	c3                   	ret    

0080123e <sys_scarce_memory>:

void sys_scarce_memory()
{
  80123e:	55                   	push   %ebp
  80123f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801241:	6a 00                	push   $0x0
  801243:	6a 00                	push   $0x0
  801245:	6a 00                	push   $0x0
  801247:	6a 00                	push   $0x0
  801249:	6a 00                	push   $0x0
  80124b:	6a 10                	push   $0x10
  80124d:	e8 ca fd ff ff       	call   80101c <syscall>
  801252:	83 c4 18             	add    $0x18,%esp
}
  801255:	90                   	nop
  801256:	c9                   	leave  
  801257:	c3                   	ret    

00801258 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801258:	55                   	push   %ebp
  801259:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80125b:	6a 00                	push   $0x0
  80125d:	6a 00                	push   $0x0
  80125f:	6a 00                	push   $0x0
  801261:	6a 00                	push   $0x0
  801263:	6a 00                	push   $0x0
  801265:	6a 14                	push   $0x14
  801267:	e8 b0 fd ff ff       	call   80101c <syscall>
  80126c:	83 c4 18             	add    $0x18,%esp
}
  80126f:	90                   	nop
  801270:	c9                   	leave  
  801271:	c3                   	ret    

00801272 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801272:	55                   	push   %ebp
  801273:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801275:	6a 00                	push   $0x0
  801277:	6a 00                	push   $0x0
  801279:	6a 00                	push   $0x0
  80127b:	6a 00                	push   $0x0
  80127d:	6a 00                	push   $0x0
  80127f:	6a 15                	push   $0x15
  801281:	e8 96 fd ff ff       	call   80101c <syscall>
  801286:	83 c4 18             	add    $0x18,%esp
}
  801289:	90                   	nop
  80128a:	c9                   	leave  
  80128b:	c3                   	ret    

0080128c <sys_cputc>:


void
sys_cputc(const char c)
{
  80128c:	55                   	push   %ebp
  80128d:	89 e5                	mov    %esp,%ebp
  80128f:	83 ec 04             	sub    $0x4,%esp
  801292:	8b 45 08             	mov    0x8(%ebp),%eax
  801295:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801298:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80129c:	6a 00                	push   $0x0
  80129e:	6a 00                	push   $0x0
  8012a0:	6a 00                	push   $0x0
  8012a2:	6a 00                	push   $0x0
  8012a4:	50                   	push   %eax
  8012a5:	6a 16                	push   $0x16
  8012a7:	e8 70 fd ff ff       	call   80101c <syscall>
  8012ac:	83 c4 18             	add    $0x18,%esp
}
  8012af:	90                   	nop
  8012b0:	c9                   	leave  
  8012b1:	c3                   	ret    

008012b2 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012b2:	55                   	push   %ebp
  8012b3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012b5:	6a 00                	push   $0x0
  8012b7:	6a 00                	push   $0x0
  8012b9:	6a 00                	push   $0x0
  8012bb:	6a 00                	push   $0x0
  8012bd:	6a 00                	push   $0x0
  8012bf:	6a 17                	push   $0x17
  8012c1:	e8 56 fd ff ff       	call   80101c <syscall>
  8012c6:	83 c4 18             	add    $0x18,%esp
}
  8012c9:	90                   	nop
  8012ca:	c9                   	leave  
  8012cb:	c3                   	ret    

008012cc <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012cc:	55                   	push   %ebp
  8012cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d2:	6a 00                	push   $0x0
  8012d4:	6a 00                	push   $0x0
  8012d6:	6a 00                	push   $0x0
  8012d8:	ff 75 0c             	pushl  0xc(%ebp)
  8012db:	50                   	push   %eax
  8012dc:	6a 18                	push   $0x18
  8012de:	e8 39 fd ff ff       	call   80101c <syscall>
  8012e3:	83 c4 18             	add    $0x18,%esp
}
  8012e6:	c9                   	leave  
  8012e7:	c3                   	ret    

008012e8 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012e8:	55                   	push   %ebp
  8012e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f1:	6a 00                	push   $0x0
  8012f3:	6a 00                	push   $0x0
  8012f5:	6a 00                	push   $0x0
  8012f7:	52                   	push   %edx
  8012f8:	50                   	push   %eax
  8012f9:	6a 1b                	push   $0x1b
  8012fb:	e8 1c fd ff ff       	call   80101c <syscall>
  801300:	83 c4 18             	add    $0x18,%esp
}
  801303:	c9                   	leave  
  801304:	c3                   	ret    

00801305 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801305:	55                   	push   %ebp
  801306:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801308:	8b 55 0c             	mov    0xc(%ebp),%edx
  80130b:	8b 45 08             	mov    0x8(%ebp),%eax
  80130e:	6a 00                	push   $0x0
  801310:	6a 00                	push   $0x0
  801312:	6a 00                	push   $0x0
  801314:	52                   	push   %edx
  801315:	50                   	push   %eax
  801316:	6a 19                	push   $0x19
  801318:	e8 ff fc ff ff       	call   80101c <syscall>
  80131d:	83 c4 18             	add    $0x18,%esp
}
  801320:	90                   	nop
  801321:	c9                   	leave  
  801322:	c3                   	ret    

00801323 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801323:	55                   	push   %ebp
  801324:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801326:	8b 55 0c             	mov    0xc(%ebp),%edx
  801329:	8b 45 08             	mov    0x8(%ebp),%eax
  80132c:	6a 00                	push   $0x0
  80132e:	6a 00                	push   $0x0
  801330:	6a 00                	push   $0x0
  801332:	52                   	push   %edx
  801333:	50                   	push   %eax
  801334:	6a 1a                	push   $0x1a
  801336:	e8 e1 fc ff ff       	call   80101c <syscall>
  80133b:	83 c4 18             	add    $0x18,%esp
}
  80133e:	90                   	nop
  80133f:	c9                   	leave  
  801340:	c3                   	ret    

00801341 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801341:	55                   	push   %ebp
  801342:	89 e5                	mov    %esp,%ebp
  801344:	83 ec 04             	sub    $0x4,%esp
  801347:	8b 45 10             	mov    0x10(%ebp),%eax
  80134a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80134d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801350:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801354:	8b 45 08             	mov    0x8(%ebp),%eax
  801357:	6a 00                	push   $0x0
  801359:	51                   	push   %ecx
  80135a:	52                   	push   %edx
  80135b:	ff 75 0c             	pushl  0xc(%ebp)
  80135e:	50                   	push   %eax
  80135f:	6a 1c                	push   $0x1c
  801361:	e8 b6 fc ff ff       	call   80101c <syscall>
  801366:	83 c4 18             	add    $0x18,%esp
}
  801369:	c9                   	leave  
  80136a:	c3                   	ret    

0080136b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80136b:	55                   	push   %ebp
  80136c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80136e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801371:	8b 45 08             	mov    0x8(%ebp),%eax
  801374:	6a 00                	push   $0x0
  801376:	6a 00                	push   $0x0
  801378:	6a 00                	push   $0x0
  80137a:	52                   	push   %edx
  80137b:	50                   	push   %eax
  80137c:	6a 1d                	push   $0x1d
  80137e:	e8 99 fc ff ff       	call   80101c <syscall>
  801383:	83 c4 18             	add    $0x18,%esp
}
  801386:	c9                   	leave  
  801387:	c3                   	ret    

00801388 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801388:	55                   	push   %ebp
  801389:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80138b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80138e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801391:	8b 45 08             	mov    0x8(%ebp),%eax
  801394:	6a 00                	push   $0x0
  801396:	6a 00                	push   $0x0
  801398:	51                   	push   %ecx
  801399:	52                   	push   %edx
  80139a:	50                   	push   %eax
  80139b:	6a 1e                	push   $0x1e
  80139d:	e8 7a fc ff ff       	call   80101c <syscall>
  8013a2:	83 c4 18             	add    $0x18,%esp
}
  8013a5:	c9                   	leave  
  8013a6:	c3                   	ret    

008013a7 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013a7:	55                   	push   %ebp
  8013a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b0:	6a 00                	push   $0x0
  8013b2:	6a 00                	push   $0x0
  8013b4:	6a 00                	push   $0x0
  8013b6:	52                   	push   %edx
  8013b7:	50                   	push   %eax
  8013b8:	6a 1f                	push   $0x1f
  8013ba:	e8 5d fc ff ff       	call   80101c <syscall>
  8013bf:	83 c4 18             	add    $0x18,%esp
}
  8013c2:	c9                   	leave  
  8013c3:	c3                   	ret    

008013c4 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013c4:	55                   	push   %ebp
  8013c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013c7:	6a 00                	push   $0x0
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 00                	push   $0x0
  8013cd:	6a 00                	push   $0x0
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 20                	push   $0x20
  8013d3:	e8 44 fc ff ff       	call   80101c <syscall>
  8013d8:	83 c4 18             	add    $0x18,%esp
}
  8013db:	c9                   	leave  
  8013dc:	c3                   	ret    

008013dd <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8013dd:	55                   	push   %ebp
  8013de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8013e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e3:	6a 00                	push   $0x0
  8013e5:	ff 75 14             	pushl  0x14(%ebp)
  8013e8:	ff 75 10             	pushl  0x10(%ebp)
  8013eb:	ff 75 0c             	pushl  0xc(%ebp)
  8013ee:	50                   	push   %eax
  8013ef:	6a 21                	push   $0x21
  8013f1:	e8 26 fc ff ff       	call   80101c <syscall>
  8013f6:	83 c4 18             	add    $0x18,%esp
}
  8013f9:	c9                   	leave  
  8013fa:	c3                   	ret    

008013fb <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8013fb:	55                   	push   %ebp
  8013fc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	6a 00                	push   $0x0
  801407:	6a 00                	push   $0x0
  801409:	50                   	push   %eax
  80140a:	6a 22                	push   $0x22
  80140c:	e8 0b fc ff ff       	call   80101c <syscall>
  801411:	83 c4 18             	add    $0x18,%esp
}
  801414:	90                   	nop
  801415:	c9                   	leave  
  801416:	c3                   	ret    

00801417 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801417:	55                   	push   %ebp
  801418:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80141a:	8b 45 08             	mov    0x8(%ebp),%eax
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	6a 00                	push   $0x0
  801425:	50                   	push   %eax
  801426:	6a 23                	push   $0x23
  801428:	e8 ef fb ff ff       	call   80101c <syscall>
  80142d:	83 c4 18             	add    $0x18,%esp
}
  801430:	90                   	nop
  801431:	c9                   	leave  
  801432:	c3                   	ret    

00801433 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801433:	55                   	push   %ebp
  801434:	89 e5                	mov    %esp,%ebp
  801436:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801439:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80143c:	8d 50 04             	lea    0x4(%eax),%edx
  80143f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801442:	6a 00                	push   $0x0
  801444:	6a 00                	push   $0x0
  801446:	6a 00                	push   $0x0
  801448:	52                   	push   %edx
  801449:	50                   	push   %eax
  80144a:	6a 24                	push   $0x24
  80144c:	e8 cb fb ff ff       	call   80101c <syscall>
  801451:	83 c4 18             	add    $0x18,%esp
	return result;
  801454:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801457:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80145a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80145d:	89 01                	mov    %eax,(%ecx)
  80145f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801462:	8b 45 08             	mov    0x8(%ebp),%eax
  801465:	c9                   	leave  
  801466:	c2 04 00             	ret    $0x4

00801469 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801469:	55                   	push   %ebp
  80146a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80146c:	6a 00                	push   $0x0
  80146e:	6a 00                	push   $0x0
  801470:	ff 75 10             	pushl  0x10(%ebp)
  801473:	ff 75 0c             	pushl  0xc(%ebp)
  801476:	ff 75 08             	pushl  0x8(%ebp)
  801479:	6a 13                	push   $0x13
  80147b:	e8 9c fb ff ff       	call   80101c <syscall>
  801480:	83 c4 18             	add    $0x18,%esp
	return ;
  801483:	90                   	nop
}
  801484:	c9                   	leave  
  801485:	c3                   	ret    

00801486 <sys_rcr2>:
uint32 sys_rcr2()
{
  801486:	55                   	push   %ebp
  801487:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801489:	6a 00                	push   $0x0
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	6a 25                	push   $0x25
  801495:	e8 82 fb ff ff       	call   80101c <syscall>
  80149a:	83 c4 18             	add    $0x18,%esp
}
  80149d:	c9                   	leave  
  80149e:	c3                   	ret    

0080149f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80149f:	55                   	push   %ebp
  8014a0:	89 e5                	mov    %esp,%ebp
  8014a2:	83 ec 04             	sub    $0x4,%esp
  8014a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014ab:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	50                   	push   %eax
  8014b8:	6a 26                	push   $0x26
  8014ba:	e8 5d fb ff ff       	call   80101c <syscall>
  8014bf:	83 c4 18             	add    $0x18,%esp
	return ;
  8014c2:	90                   	nop
}
  8014c3:	c9                   	leave  
  8014c4:	c3                   	ret    

008014c5 <rsttst>:
void rsttst()
{
  8014c5:	55                   	push   %ebp
  8014c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 28                	push   $0x28
  8014d4:	e8 43 fb ff ff       	call   80101c <syscall>
  8014d9:	83 c4 18             	add    $0x18,%esp
	return ;
  8014dc:	90                   	nop
}
  8014dd:	c9                   	leave  
  8014de:	c3                   	ret    

008014df <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014df:	55                   	push   %ebp
  8014e0:	89 e5                	mov    %esp,%ebp
  8014e2:	83 ec 04             	sub    $0x4,%esp
  8014e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8014e8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014eb:	8b 55 18             	mov    0x18(%ebp),%edx
  8014ee:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014f2:	52                   	push   %edx
  8014f3:	50                   	push   %eax
  8014f4:	ff 75 10             	pushl  0x10(%ebp)
  8014f7:	ff 75 0c             	pushl  0xc(%ebp)
  8014fa:	ff 75 08             	pushl  0x8(%ebp)
  8014fd:	6a 27                	push   $0x27
  8014ff:	e8 18 fb ff ff       	call   80101c <syscall>
  801504:	83 c4 18             	add    $0x18,%esp
	return ;
  801507:	90                   	nop
}
  801508:	c9                   	leave  
  801509:	c3                   	ret    

0080150a <chktst>:
void chktst(uint32 n)
{
  80150a:	55                   	push   %ebp
  80150b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80150d:	6a 00                	push   $0x0
  80150f:	6a 00                	push   $0x0
  801511:	6a 00                	push   $0x0
  801513:	6a 00                	push   $0x0
  801515:	ff 75 08             	pushl  0x8(%ebp)
  801518:	6a 29                	push   $0x29
  80151a:	e8 fd fa ff ff       	call   80101c <syscall>
  80151f:	83 c4 18             	add    $0x18,%esp
	return ;
  801522:	90                   	nop
}
  801523:	c9                   	leave  
  801524:	c3                   	ret    

00801525 <inctst>:

void inctst()
{
  801525:	55                   	push   %ebp
  801526:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801528:	6a 00                	push   $0x0
  80152a:	6a 00                	push   $0x0
  80152c:	6a 00                	push   $0x0
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	6a 2a                	push   $0x2a
  801534:	e8 e3 fa ff ff       	call   80101c <syscall>
  801539:	83 c4 18             	add    $0x18,%esp
	return ;
  80153c:	90                   	nop
}
  80153d:	c9                   	leave  
  80153e:	c3                   	ret    

0080153f <gettst>:
uint32 gettst()
{
  80153f:	55                   	push   %ebp
  801540:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801542:	6a 00                	push   $0x0
  801544:	6a 00                	push   $0x0
  801546:	6a 00                	push   $0x0
  801548:	6a 00                	push   $0x0
  80154a:	6a 00                	push   $0x0
  80154c:	6a 2b                	push   $0x2b
  80154e:	e8 c9 fa ff ff       	call   80101c <syscall>
  801553:	83 c4 18             	add    $0x18,%esp
}
  801556:	c9                   	leave  
  801557:	c3                   	ret    

00801558 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801558:	55                   	push   %ebp
  801559:	89 e5                	mov    %esp,%ebp
  80155b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	6a 00                	push   $0x0
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 2c                	push   $0x2c
  80156a:	e8 ad fa ff ff       	call   80101c <syscall>
  80156f:	83 c4 18             	add    $0x18,%esp
  801572:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801575:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801579:	75 07                	jne    801582 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80157b:	b8 01 00 00 00       	mov    $0x1,%eax
  801580:	eb 05                	jmp    801587 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801582:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801587:	c9                   	leave  
  801588:	c3                   	ret    

00801589 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801589:	55                   	push   %ebp
  80158a:	89 e5                	mov    %esp,%ebp
  80158c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80158f:	6a 00                	push   $0x0
  801591:	6a 00                	push   $0x0
  801593:	6a 00                	push   $0x0
  801595:	6a 00                	push   $0x0
  801597:	6a 00                	push   $0x0
  801599:	6a 2c                	push   $0x2c
  80159b:	e8 7c fa ff ff       	call   80101c <syscall>
  8015a0:	83 c4 18             	add    $0x18,%esp
  8015a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015a6:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015aa:	75 07                	jne    8015b3 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015ac:	b8 01 00 00 00       	mov    $0x1,%eax
  8015b1:	eb 05                	jmp    8015b8 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015b8:	c9                   	leave  
  8015b9:	c3                   	ret    

008015ba <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015ba:	55                   	push   %ebp
  8015bb:	89 e5                	mov    %esp,%ebp
  8015bd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015c0:	6a 00                	push   $0x0
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 2c                	push   $0x2c
  8015cc:	e8 4b fa ff ff       	call   80101c <syscall>
  8015d1:	83 c4 18             	add    $0x18,%esp
  8015d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015d7:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015db:	75 07                	jne    8015e4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015dd:	b8 01 00 00 00       	mov    $0x1,%eax
  8015e2:	eb 05                	jmp    8015e9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015e9:	c9                   	leave  
  8015ea:	c3                   	ret    

008015eb <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015eb:	55                   	push   %ebp
  8015ec:	89 e5                	mov    %esp,%ebp
  8015ee:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 00                	push   $0x0
  8015f5:	6a 00                	push   $0x0
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 2c                	push   $0x2c
  8015fd:	e8 1a fa ff ff       	call   80101c <syscall>
  801602:	83 c4 18             	add    $0x18,%esp
  801605:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801608:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80160c:	75 07                	jne    801615 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80160e:	b8 01 00 00 00       	mov    $0x1,%eax
  801613:	eb 05                	jmp    80161a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801615:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80161a:	c9                   	leave  
  80161b:	c3                   	ret    

0080161c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80161c:	55                   	push   %ebp
  80161d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80161f:	6a 00                	push   $0x0
  801621:	6a 00                	push   $0x0
  801623:	6a 00                	push   $0x0
  801625:	6a 00                	push   $0x0
  801627:	ff 75 08             	pushl  0x8(%ebp)
  80162a:	6a 2d                	push   $0x2d
  80162c:	e8 eb f9 ff ff       	call   80101c <syscall>
  801631:	83 c4 18             	add    $0x18,%esp
	return ;
  801634:	90                   	nop
}
  801635:	c9                   	leave  
  801636:	c3                   	ret    

00801637 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801637:	55                   	push   %ebp
  801638:	89 e5                	mov    %esp,%ebp
  80163a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80163b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80163e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801641:	8b 55 0c             	mov    0xc(%ebp),%edx
  801644:	8b 45 08             	mov    0x8(%ebp),%eax
  801647:	6a 00                	push   $0x0
  801649:	53                   	push   %ebx
  80164a:	51                   	push   %ecx
  80164b:	52                   	push   %edx
  80164c:	50                   	push   %eax
  80164d:	6a 2e                	push   $0x2e
  80164f:	e8 c8 f9 ff ff       	call   80101c <syscall>
  801654:	83 c4 18             	add    $0x18,%esp
}
  801657:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80165a:	c9                   	leave  
  80165b:	c3                   	ret    

0080165c <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80165c:	55                   	push   %ebp
  80165d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80165f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801662:	8b 45 08             	mov    0x8(%ebp),%eax
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	6a 00                	push   $0x0
  80166b:	52                   	push   %edx
  80166c:	50                   	push   %eax
  80166d:	6a 2f                	push   $0x2f
  80166f:	e8 a8 f9 ff ff       	call   80101c <syscall>
  801674:	83 c4 18             	add    $0x18,%esp
}
  801677:	c9                   	leave  
  801678:	c3                   	ret    

00801679 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801679:	55                   	push   %ebp
  80167a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80167c:	6a 00                	push   $0x0
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	ff 75 0c             	pushl  0xc(%ebp)
  801685:	ff 75 08             	pushl  0x8(%ebp)
  801688:	6a 30                	push   $0x30
  80168a:	e8 8d f9 ff ff       	call   80101c <syscall>
  80168f:	83 c4 18             	add    $0x18,%esp
	return ;
  801692:	90                   	nop
}
  801693:	c9                   	leave  
  801694:	c3                   	ret    
  801695:	66 90                	xchg   %ax,%ax
  801697:	90                   	nop

00801698 <__udivdi3>:
  801698:	55                   	push   %ebp
  801699:	57                   	push   %edi
  80169a:	56                   	push   %esi
  80169b:	53                   	push   %ebx
  80169c:	83 ec 1c             	sub    $0x1c,%esp
  80169f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8016a3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8016a7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016ab:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8016af:	89 ca                	mov    %ecx,%edx
  8016b1:	89 f8                	mov    %edi,%eax
  8016b3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8016b7:	85 f6                	test   %esi,%esi
  8016b9:	75 2d                	jne    8016e8 <__udivdi3+0x50>
  8016bb:	39 cf                	cmp    %ecx,%edi
  8016bd:	77 65                	ja     801724 <__udivdi3+0x8c>
  8016bf:	89 fd                	mov    %edi,%ebp
  8016c1:	85 ff                	test   %edi,%edi
  8016c3:	75 0b                	jne    8016d0 <__udivdi3+0x38>
  8016c5:	b8 01 00 00 00       	mov    $0x1,%eax
  8016ca:	31 d2                	xor    %edx,%edx
  8016cc:	f7 f7                	div    %edi
  8016ce:	89 c5                	mov    %eax,%ebp
  8016d0:	31 d2                	xor    %edx,%edx
  8016d2:	89 c8                	mov    %ecx,%eax
  8016d4:	f7 f5                	div    %ebp
  8016d6:	89 c1                	mov    %eax,%ecx
  8016d8:	89 d8                	mov    %ebx,%eax
  8016da:	f7 f5                	div    %ebp
  8016dc:	89 cf                	mov    %ecx,%edi
  8016de:	89 fa                	mov    %edi,%edx
  8016e0:	83 c4 1c             	add    $0x1c,%esp
  8016e3:	5b                   	pop    %ebx
  8016e4:	5e                   	pop    %esi
  8016e5:	5f                   	pop    %edi
  8016e6:	5d                   	pop    %ebp
  8016e7:	c3                   	ret    
  8016e8:	39 ce                	cmp    %ecx,%esi
  8016ea:	77 28                	ja     801714 <__udivdi3+0x7c>
  8016ec:	0f bd fe             	bsr    %esi,%edi
  8016ef:	83 f7 1f             	xor    $0x1f,%edi
  8016f2:	75 40                	jne    801734 <__udivdi3+0x9c>
  8016f4:	39 ce                	cmp    %ecx,%esi
  8016f6:	72 0a                	jb     801702 <__udivdi3+0x6a>
  8016f8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8016fc:	0f 87 9e 00 00 00    	ja     8017a0 <__udivdi3+0x108>
  801702:	b8 01 00 00 00       	mov    $0x1,%eax
  801707:	89 fa                	mov    %edi,%edx
  801709:	83 c4 1c             	add    $0x1c,%esp
  80170c:	5b                   	pop    %ebx
  80170d:	5e                   	pop    %esi
  80170e:	5f                   	pop    %edi
  80170f:	5d                   	pop    %ebp
  801710:	c3                   	ret    
  801711:	8d 76 00             	lea    0x0(%esi),%esi
  801714:	31 ff                	xor    %edi,%edi
  801716:	31 c0                	xor    %eax,%eax
  801718:	89 fa                	mov    %edi,%edx
  80171a:	83 c4 1c             	add    $0x1c,%esp
  80171d:	5b                   	pop    %ebx
  80171e:	5e                   	pop    %esi
  80171f:	5f                   	pop    %edi
  801720:	5d                   	pop    %ebp
  801721:	c3                   	ret    
  801722:	66 90                	xchg   %ax,%ax
  801724:	89 d8                	mov    %ebx,%eax
  801726:	f7 f7                	div    %edi
  801728:	31 ff                	xor    %edi,%edi
  80172a:	89 fa                	mov    %edi,%edx
  80172c:	83 c4 1c             	add    $0x1c,%esp
  80172f:	5b                   	pop    %ebx
  801730:	5e                   	pop    %esi
  801731:	5f                   	pop    %edi
  801732:	5d                   	pop    %ebp
  801733:	c3                   	ret    
  801734:	bd 20 00 00 00       	mov    $0x20,%ebp
  801739:	89 eb                	mov    %ebp,%ebx
  80173b:	29 fb                	sub    %edi,%ebx
  80173d:	89 f9                	mov    %edi,%ecx
  80173f:	d3 e6                	shl    %cl,%esi
  801741:	89 c5                	mov    %eax,%ebp
  801743:	88 d9                	mov    %bl,%cl
  801745:	d3 ed                	shr    %cl,%ebp
  801747:	89 e9                	mov    %ebp,%ecx
  801749:	09 f1                	or     %esi,%ecx
  80174b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80174f:	89 f9                	mov    %edi,%ecx
  801751:	d3 e0                	shl    %cl,%eax
  801753:	89 c5                	mov    %eax,%ebp
  801755:	89 d6                	mov    %edx,%esi
  801757:	88 d9                	mov    %bl,%cl
  801759:	d3 ee                	shr    %cl,%esi
  80175b:	89 f9                	mov    %edi,%ecx
  80175d:	d3 e2                	shl    %cl,%edx
  80175f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801763:	88 d9                	mov    %bl,%cl
  801765:	d3 e8                	shr    %cl,%eax
  801767:	09 c2                	or     %eax,%edx
  801769:	89 d0                	mov    %edx,%eax
  80176b:	89 f2                	mov    %esi,%edx
  80176d:	f7 74 24 0c          	divl   0xc(%esp)
  801771:	89 d6                	mov    %edx,%esi
  801773:	89 c3                	mov    %eax,%ebx
  801775:	f7 e5                	mul    %ebp
  801777:	39 d6                	cmp    %edx,%esi
  801779:	72 19                	jb     801794 <__udivdi3+0xfc>
  80177b:	74 0b                	je     801788 <__udivdi3+0xf0>
  80177d:	89 d8                	mov    %ebx,%eax
  80177f:	31 ff                	xor    %edi,%edi
  801781:	e9 58 ff ff ff       	jmp    8016de <__udivdi3+0x46>
  801786:	66 90                	xchg   %ax,%ax
  801788:	8b 54 24 08          	mov    0x8(%esp),%edx
  80178c:	89 f9                	mov    %edi,%ecx
  80178e:	d3 e2                	shl    %cl,%edx
  801790:	39 c2                	cmp    %eax,%edx
  801792:	73 e9                	jae    80177d <__udivdi3+0xe5>
  801794:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801797:	31 ff                	xor    %edi,%edi
  801799:	e9 40 ff ff ff       	jmp    8016de <__udivdi3+0x46>
  80179e:	66 90                	xchg   %ax,%ax
  8017a0:	31 c0                	xor    %eax,%eax
  8017a2:	e9 37 ff ff ff       	jmp    8016de <__udivdi3+0x46>
  8017a7:	90                   	nop

008017a8 <__umoddi3>:
  8017a8:	55                   	push   %ebp
  8017a9:	57                   	push   %edi
  8017aa:	56                   	push   %esi
  8017ab:	53                   	push   %ebx
  8017ac:	83 ec 1c             	sub    $0x1c,%esp
  8017af:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8017b3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8017b7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017bb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8017bf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8017c3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8017c7:	89 f3                	mov    %esi,%ebx
  8017c9:	89 fa                	mov    %edi,%edx
  8017cb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8017cf:	89 34 24             	mov    %esi,(%esp)
  8017d2:	85 c0                	test   %eax,%eax
  8017d4:	75 1a                	jne    8017f0 <__umoddi3+0x48>
  8017d6:	39 f7                	cmp    %esi,%edi
  8017d8:	0f 86 a2 00 00 00    	jbe    801880 <__umoddi3+0xd8>
  8017de:	89 c8                	mov    %ecx,%eax
  8017e0:	89 f2                	mov    %esi,%edx
  8017e2:	f7 f7                	div    %edi
  8017e4:	89 d0                	mov    %edx,%eax
  8017e6:	31 d2                	xor    %edx,%edx
  8017e8:	83 c4 1c             	add    $0x1c,%esp
  8017eb:	5b                   	pop    %ebx
  8017ec:	5e                   	pop    %esi
  8017ed:	5f                   	pop    %edi
  8017ee:	5d                   	pop    %ebp
  8017ef:	c3                   	ret    
  8017f0:	39 f0                	cmp    %esi,%eax
  8017f2:	0f 87 ac 00 00 00    	ja     8018a4 <__umoddi3+0xfc>
  8017f8:	0f bd e8             	bsr    %eax,%ebp
  8017fb:	83 f5 1f             	xor    $0x1f,%ebp
  8017fe:	0f 84 ac 00 00 00    	je     8018b0 <__umoddi3+0x108>
  801804:	bf 20 00 00 00       	mov    $0x20,%edi
  801809:	29 ef                	sub    %ebp,%edi
  80180b:	89 fe                	mov    %edi,%esi
  80180d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801811:	89 e9                	mov    %ebp,%ecx
  801813:	d3 e0                	shl    %cl,%eax
  801815:	89 d7                	mov    %edx,%edi
  801817:	89 f1                	mov    %esi,%ecx
  801819:	d3 ef                	shr    %cl,%edi
  80181b:	09 c7                	or     %eax,%edi
  80181d:	89 e9                	mov    %ebp,%ecx
  80181f:	d3 e2                	shl    %cl,%edx
  801821:	89 14 24             	mov    %edx,(%esp)
  801824:	89 d8                	mov    %ebx,%eax
  801826:	d3 e0                	shl    %cl,%eax
  801828:	89 c2                	mov    %eax,%edx
  80182a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80182e:	d3 e0                	shl    %cl,%eax
  801830:	89 44 24 04          	mov    %eax,0x4(%esp)
  801834:	8b 44 24 08          	mov    0x8(%esp),%eax
  801838:	89 f1                	mov    %esi,%ecx
  80183a:	d3 e8                	shr    %cl,%eax
  80183c:	09 d0                	or     %edx,%eax
  80183e:	d3 eb                	shr    %cl,%ebx
  801840:	89 da                	mov    %ebx,%edx
  801842:	f7 f7                	div    %edi
  801844:	89 d3                	mov    %edx,%ebx
  801846:	f7 24 24             	mull   (%esp)
  801849:	89 c6                	mov    %eax,%esi
  80184b:	89 d1                	mov    %edx,%ecx
  80184d:	39 d3                	cmp    %edx,%ebx
  80184f:	0f 82 87 00 00 00    	jb     8018dc <__umoddi3+0x134>
  801855:	0f 84 91 00 00 00    	je     8018ec <__umoddi3+0x144>
  80185b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80185f:	29 f2                	sub    %esi,%edx
  801861:	19 cb                	sbb    %ecx,%ebx
  801863:	89 d8                	mov    %ebx,%eax
  801865:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801869:	d3 e0                	shl    %cl,%eax
  80186b:	89 e9                	mov    %ebp,%ecx
  80186d:	d3 ea                	shr    %cl,%edx
  80186f:	09 d0                	or     %edx,%eax
  801871:	89 e9                	mov    %ebp,%ecx
  801873:	d3 eb                	shr    %cl,%ebx
  801875:	89 da                	mov    %ebx,%edx
  801877:	83 c4 1c             	add    $0x1c,%esp
  80187a:	5b                   	pop    %ebx
  80187b:	5e                   	pop    %esi
  80187c:	5f                   	pop    %edi
  80187d:	5d                   	pop    %ebp
  80187e:	c3                   	ret    
  80187f:	90                   	nop
  801880:	89 fd                	mov    %edi,%ebp
  801882:	85 ff                	test   %edi,%edi
  801884:	75 0b                	jne    801891 <__umoddi3+0xe9>
  801886:	b8 01 00 00 00       	mov    $0x1,%eax
  80188b:	31 d2                	xor    %edx,%edx
  80188d:	f7 f7                	div    %edi
  80188f:	89 c5                	mov    %eax,%ebp
  801891:	89 f0                	mov    %esi,%eax
  801893:	31 d2                	xor    %edx,%edx
  801895:	f7 f5                	div    %ebp
  801897:	89 c8                	mov    %ecx,%eax
  801899:	f7 f5                	div    %ebp
  80189b:	89 d0                	mov    %edx,%eax
  80189d:	e9 44 ff ff ff       	jmp    8017e6 <__umoddi3+0x3e>
  8018a2:	66 90                	xchg   %ax,%ax
  8018a4:	89 c8                	mov    %ecx,%eax
  8018a6:	89 f2                	mov    %esi,%edx
  8018a8:	83 c4 1c             	add    $0x1c,%esp
  8018ab:	5b                   	pop    %ebx
  8018ac:	5e                   	pop    %esi
  8018ad:	5f                   	pop    %edi
  8018ae:	5d                   	pop    %ebp
  8018af:	c3                   	ret    
  8018b0:	3b 04 24             	cmp    (%esp),%eax
  8018b3:	72 06                	jb     8018bb <__umoddi3+0x113>
  8018b5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8018b9:	77 0f                	ja     8018ca <__umoddi3+0x122>
  8018bb:	89 f2                	mov    %esi,%edx
  8018bd:	29 f9                	sub    %edi,%ecx
  8018bf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8018c3:	89 14 24             	mov    %edx,(%esp)
  8018c6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018ca:	8b 44 24 04          	mov    0x4(%esp),%eax
  8018ce:	8b 14 24             	mov    (%esp),%edx
  8018d1:	83 c4 1c             	add    $0x1c,%esp
  8018d4:	5b                   	pop    %ebx
  8018d5:	5e                   	pop    %esi
  8018d6:	5f                   	pop    %edi
  8018d7:	5d                   	pop    %ebp
  8018d8:	c3                   	ret    
  8018d9:	8d 76 00             	lea    0x0(%esi),%esi
  8018dc:	2b 04 24             	sub    (%esp),%eax
  8018df:	19 fa                	sbb    %edi,%edx
  8018e1:	89 d1                	mov    %edx,%ecx
  8018e3:	89 c6                	mov    %eax,%esi
  8018e5:	e9 71 ff ff ff       	jmp    80185b <__umoddi3+0xb3>
  8018ea:	66 90                	xchg   %ax,%ax
  8018ec:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8018f0:	72 ea                	jb     8018dc <__umoddi3+0x134>
  8018f2:	89 d9                	mov    %ebx,%ecx
  8018f4:	e9 62 ff ff ff       	jmp    80185b <__umoddi3+0xb3>
