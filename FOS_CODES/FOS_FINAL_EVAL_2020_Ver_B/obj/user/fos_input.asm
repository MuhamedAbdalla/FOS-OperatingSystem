
obj/user/fos_input:     file format elf32-i386


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
  800031:	e8 a5 00 00 00       	call   8000db <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void
_main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 04 00 00    	sub    $0x418,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int i2=0;
  800048:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	char buff1[512];
	char buff2[512];


	atomic_readline("Please enter first number :", buff1);
  80004f:	83 ec 08             	sub    $0x8,%esp
  800052:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  800058:	50                   	push   %eax
  800059:	68 a0 1c 80 00       	push   $0x801ca0
  80005e:	e8 f1 09 00 00       	call   800a54 <atomic_readline>
  800063:	83 c4 10             	add    $0x10,%esp
	i1 = strtol(buff1, NULL, 10);
  800066:	83 ec 04             	sub    $0x4,%esp
  800069:	6a 0a                	push   $0xa
  80006b:	6a 00                	push   $0x0
  80006d:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  800073:	50                   	push   %eax
  800074:	e8 43 0e 00 00       	call   800ebc <strtol>
  800079:	83 c4 10             	add    $0x10,%esp
  80007c:	89 45 f4             	mov    %eax,-0xc(%ebp)

	//sleep
	env_sleep(2800);
  80007f:	83 ec 0c             	sub    $0xc,%esp
  800082:	68 f0 0a 00 00       	push   $0xaf0
  800087:	e8 51 18 00 00       	call   8018dd <env_sleep>
  80008c:	83 c4 10             	add    $0x10,%esp

	atomic_readline("Please enter second number :", buff2);
  80008f:	83 ec 08             	sub    $0x8,%esp
  800092:	8d 85 f0 fb ff ff    	lea    -0x410(%ebp),%eax
  800098:	50                   	push   %eax
  800099:	68 bc 1c 80 00       	push   $0x801cbc
  80009e:	e8 b1 09 00 00       	call   800a54 <atomic_readline>
  8000a3:	83 c4 10             	add    $0x10,%esp
	
	i2 = strtol(buff2, NULL, 10);
  8000a6:	83 ec 04             	sub    $0x4,%esp
  8000a9:	6a 0a                	push   $0xa
  8000ab:	6a 00                	push   $0x0
  8000ad:	8d 85 f0 fb ff ff    	lea    -0x410(%ebp),%eax
  8000b3:	50                   	push   %eax
  8000b4:	e8 03 0e 00 00       	call   800ebc <strtol>
  8000b9:	83 c4 10             	add    $0x10,%esp
  8000bc:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("number 1 + number 2 = %d\n",i1+i2);
  8000bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c5:	01 d0                	add    %edx,%eax
  8000c7:	83 ec 08             	sub    $0x8,%esp
  8000ca:	50                   	push   %eax
  8000cb:	68 d9 1c 80 00       	push   $0x801cd9
  8000d0:	e8 2c 02 00 00       	call   800301 <atomic_cprintf>
  8000d5:	83 c4 10             	add    $0x10,%esp
	return;	
  8000d8:	90                   	nop
}
  8000d9:	c9                   	leave  
  8000da:	c3                   	ret    

008000db <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000db:	55                   	push   %ebp
  8000dc:	89 e5                	mov    %esp,%ebp
  8000de:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000e1:	e8 1f 12 00 00       	call   801305 <sys_getenvindex>
  8000e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000ec:	89 d0                	mov    %edx,%eax
  8000ee:	c1 e0 03             	shl    $0x3,%eax
  8000f1:	01 d0                	add    %edx,%eax
  8000f3:	c1 e0 02             	shl    $0x2,%eax
  8000f6:	01 d0                	add    %edx,%eax
  8000f8:	c1 e0 06             	shl    $0x6,%eax
  8000fb:	29 d0                	sub    %edx,%eax
  8000fd:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800104:	01 c8                	add    %ecx,%eax
  800106:	01 d0                	add    %edx,%eax
  800108:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80010d:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800112:	a1 20 30 80 00       	mov    0x803020,%eax
  800117:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  80011d:	84 c0                	test   %al,%al
  80011f:	74 0f                	je     800130 <libmain+0x55>
		binaryname = myEnv->prog_name;
  800121:	a1 20 30 80 00       	mov    0x803020,%eax
  800126:	05 b0 52 00 00       	add    $0x52b0,%eax
  80012b:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800130:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800134:	7e 0a                	jle    800140 <libmain+0x65>
		binaryname = argv[0];
  800136:	8b 45 0c             	mov    0xc(%ebp),%eax
  800139:	8b 00                	mov    (%eax),%eax
  80013b:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800140:	83 ec 08             	sub    $0x8,%esp
  800143:	ff 75 0c             	pushl  0xc(%ebp)
  800146:	ff 75 08             	pushl  0x8(%ebp)
  800149:	e8 ea fe ff ff       	call   800038 <_main>
  80014e:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800151:	e8 4a 13 00 00       	call   8014a0 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800156:	83 ec 0c             	sub    $0xc,%esp
  800159:	68 0c 1d 80 00       	push   $0x801d0c
  80015e:	e8 71 01 00 00       	call   8002d4 <cprintf>
  800163:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800166:	a1 20 30 80 00       	mov    0x803020,%eax
  80016b:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  800171:	a1 20 30 80 00       	mov    0x803020,%eax
  800176:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  80017c:	83 ec 04             	sub    $0x4,%esp
  80017f:	52                   	push   %edx
  800180:	50                   	push   %eax
  800181:	68 34 1d 80 00       	push   $0x801d34
  800186:	e8 49 01 00 00       	call   8002d4 <cprintf>
  80018b:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80018e:	a1 20 30 80 00       	mov    0x803020,%eax
  800193:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  800199:	a1 20 30 80 00       	mov    0x803020,%eax
  80019e:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  8001a4:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a9:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  8001af:	51                   	push   %ecx
  8001b0:	52                   	push   %edx
  8001b1:	50                   	push   %eax
  8001b2:	68 5c 1d 80 00       	push   $0x801d5c
  8001b7:	e8 18 01 00 00       	call   8002d4 <cprintf>
  8001bc:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8001bf:	83 ec 0c             	sub    $0xc,%esp
  8001c2:	68 0c 1d 80 00       	push   $0x801d0c
  8001c7:	e8 08 01 00 00       	call   8002d4 <cprintf>
  8001cc:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001cf:	e8 e6 12 00 00       	call   8014ba <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001d4:	e8 19 00 00 00       	call   8001f2 <exit>
}
  8001d9:	90                   	nop
  8001da:	c9                   	leave  
  8001db:	c3                   	ret    

008001dc <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001dc:	55                   	push   %ebp
  8001dd:	89 e5                	mov    %esp,%ebp
  8001df:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001e2:	83 ec 0c             	sub    $0xc,%esp
  8001e5:	6a 00                	push   $0x0
  8001e7:	e8 e5 10 00 00       	call   8012d1 <sys_env_destroy>
  8001ec:	83 c4 10             	add    $0x10,%esp
}
  8001ef:	90                   	nop
  8001f0:	c9                   	leave  
  8001f1:	c3                   	ret    

008001f2 <exit>:

void
exit(void)
{
  8001f2:	55                   	push   %ebp
  8001f3:	89 e5                	mov    %esp,%ebp
  8001f5:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001f8:	e8 3a 11 00 00       	call   801337 <sys_env_exit>
}
  8001fd:	90                   	nop
  8001fe:	c9                   	leave  
  8001ff:	c3                   	ret    

00800200 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800200:	55                   	push   %ebp
  800201:	89 e5                	mov    %esp,%ebp
  800203:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800206:	8b 45 0c             	mov    0xc(%ebp),%eax
  800209:	8b 00                	mov    (%eax),%eax
  80020b:	8d 48 01             	lea    0x1(%eax),%ecx
  80020e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800211:	89 0a                	mov    %ecx,(%edx)
  800213:	8b 55 08             	mov    0x8(%ebp),%edx
  800216:	88 d1                	mov    %dl,%cl
  800218:	8b 55 0c             	mov    0xc(%ebp),%edx
  80021b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80021f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800222:	8b 00                	mov    (%eax),%eax
  800224:	3d ff 00 00 00       	cmp    $0xff,%eax
  800229:	75 2c                	jne    800257 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80022b:	a0 24 30 80 00       	mov    0x803024,%al
  800230:	0f b6 c0             	movzbl %al,%eax
  800233:	8b 55 0c             	mov    0xc(%ebp),%edx
  800236:	8b 12                	mov    (%edx),%edx
  800238:	89 d1                	mov    %edx,%ecx
  80023a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80023d:	83 c2 08             	add    $0x8,%edx
  800240:	83 ec 04             	sub    $0x4,%esp
  800243:	50                   	push   %eax
  800244:	51                   	push   %ecx
  800245:	52                   	push   %edx
  800246:	e8 44 10 00 00       	call   80128f <sys_cputs>
  80024b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80024e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800251:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800257:	8b 45 0c             	mov    0xc(%ebp),%eax
  80025a:	8b 40 04             	mov    0x4(%eax),%eax
  80025d:	8d 50 01             	lea    0x1(%eax),%edx
  800260:	8b 45 0c             	mov    0xc(%ebp),%eax
  800263:	89 50 04             	mov    %edx,0x4(%eax)
}
  800266:	90                   	nop
  800267:	c9                   	leave  
  800268:	c3                   	ret    

00800269 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800269:	55                   	push   %ebp
  80026a:	89 e5                	mov    %esp,%ebp
  80026c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800272:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800279:	00 00 00 
	b.cnt = 0;
  80027c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800283:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800286:	ff 75 0c             	pushl  0xc(%ebp)
  800289:	ff 75 08             	pushl  0x8(%ebp)
  80028c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800292:	50                   	push   %eax
  800293:	68 00 02 80 00       	push   $0x800200
  800298:	e8 11 02 00 00       	call   8004ae <vprintfmt>
  80029d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002a0:	a0 24 30 80 00       	mov    0x803024,%al
  8002a5:	0f b6 c0             	movzbl %al,%eax
  8002a8:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002ae:	83 ec 04             	sub    $0x4,%esp
  8002b1:	50                   	push   %eax
  8002b2:	52                   	push   %edx
  8002b3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002b9:	83 c0 08             	add    $0x8,%eax
  8002bc:	50                   	push   %eax
  8002bd:	e8 cd 0f 00 00       	call   80128f <sys_cputs>
  8002c2:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002c5:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8002cc:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002d2:	c9                   	leave  
  8002d3:	c3                   	ret    

008002d4 <cprintf>:

int cprintf(const char *fmt, ...) {
  8002d4:	55                   	push   %ebp
  8002d5:	89 e5                	mov    %esp,%ebp
  8002d7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002da:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8002e1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ea:	83 ec 08             	sub    $0x8,%esp
  8002ed:	ff 75 f4             	pushl  -0xc(%ebp)
  8002f0:	50                   	push   %eax
  8002f1:	e8 73 ff ff ff       	call   800269 <vcprintf>
  8002f6:	83 c4 10             	add    $0x10,%esp
  8002f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002ff:	c9                   	leave  
  800300:	c3                   	ret    

00800301 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800301:	55                   	push   %ebp
  800302:	89 e5                	mov    %esp,%ebp
  800304:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800307:	e8 94 11 00 00       	call   8014a0 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80030c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80030f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800312:	8b 45 08             	mov    0x8(%ebp),%eax
  800315:	83 ec 08             	sub    $0x8,%esp
  800318:	ff 75 f4             	pushl  -0xc(%ebp)
  80031b:	50                   	push   %eax
  80031c:	e8 48 ff ff ff       	call   800269 <vcprintf>
  800321:	83 c4 10             	add    $0x10,%esp
  800324:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800327:	e8 8e 11 00 00       	call   8014ba <sys_enable_interrupt>
	return cnt;
  80032c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80032f:	c9                   	leave  
  800330:	c3                   	ret    

00800331 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800331:	55                   	push   %ebp
  800332:	89 e5                	mov    %esp,%ebp
  800334:	53                   	push   %ebx
  800335:	83 ec 14             	sub    $0x14,%esp
  800338:	8b 45 10             	mov    0x10(%ebp),%eax
  80033b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80033e:	8b 45 14             	mov    0x14(%ebp),%eax
  800341:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800344:	8b 45 18             	mov    0x18(%ebp),%eax
  800347:	ba 00 00 00 00       	mov    $0x0,%edx
  80034c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80034f:	77 55                	ja     8003a6 <printnum+0x75>
  800351:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800354:	72 05                	jb     80035b <printnum+0x2a>
  800356:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800359:	77 4b                	ja     8003a6 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80035b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80035e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800361:	8b 45 18             	mov    0x18(%ebp),%eax
  800364:	ba 00 00 00 00       	mov    $0x0,%edx
  800369:	52                   	push   %edx
  80036a:	50                   	push   %eax
  80036b:	ff 75 f4             	pushl  -0xc(%ebp)
  80036e:	ff 75 f0             	pushl  -0x10(%ebp)
  800371:	e8 be 16 00 00       	call   801a34 <__udivdi3>
  800376:	83 c4 10             	add    $0x10,%esp
  800379:	83 ec 04             	sub    $0x4,%esp
  80037c:	ff 75 20             	pushl  0x20(%ebp)
  80037f:	53                   	push   %ebx
  800380:	ff 75 18             	pushl  0x18(%ebp)
  800383:	52                   	push   %edx
  800384:	50                   	push   %eax
  800385:	ff 75 0c             	pushl  0xc(%ebp)
  800388:	ff 75 08             	pushl  0x8(%ebp)
  80038b:	e8 a1 ff ff ff       	call   800331 <printnum>
  800390:	83 c4 20             	add    $0x20,%esp
  800393:	eb 1a                	jmp    8003af <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800395:	83 ec 08             	sub    $0x8,%esp
  800398:	ff 75 0c             	pushl  0xc(%ebp)
  80039b:	ff 75 20             	pushl  0x20(%ebp)
  80039e:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a1:	ff d0                	call   *%eax
  8003a3:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003a6:	ff 4d 1c             	decl   0x1c(%ebp)
  8003a9:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003ad:	7f e6                	jg     800395 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003af:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003b2:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003bd:	53                   	push   %ebx
  8003be:	51                   	push   %ecx
  8003bf:	52                   	push   %edx
  8003c0:	50                   	push   %eax
  8003c1:	e8 7e 17 00 00       	call   801b44 <__umoddi3>
  8003c6:	83 c4 10             	add    $0x10,%esp
  8003c9:	05 d4 1f 80 00       	add    $0x801fd4,%eax
  8003ce:	8a 00                	mov    (%eax),%al
  8003d0:	0f be c0             	movsbl %al,%eax
  8003d3:	83 ec 08             	sub    $0x8,%esp
  8003d6:	ff 75 0c             	pushl  0xc(%ebp)
  8003d9:	50                   	push   %eax
  8003da:	8b 45 08             	mov    0x8(%ebp),%eax
  8003dd:	ff d0                	call   *%eax
  8003df:	83 c4 10             	add    $0x10,%esp
}
  8003e2:	90                   	nop
  8003e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003e6:	c9                   	leave  
  8003e7:	c3                   	ret    

008003e8 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003e8:	55                   	push   %ebp
  8003e9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003eb:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003ef:	7e 1c                	jle    80040d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f4:	8b 00                	mov    (%eax),%eax
  8003f6:	8d 50 08             	lea    0x8(%eax),%edx
  8003f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fc:	89 10                	mov    %edx,(%eax)
  8003fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800401:	8b 00                	mov    (%eax),%eax
  800403:	83 e8 08             	sub    $0x8,%eax
  800406:	8b 50 04             	mov    0x4(%eax),%edx
  800409:	8b 00                	mov    (%eax),%eax
  80040b:	eb 40                	jmp    80044d <getuint+0x65>
	else if (lflag)
  80040d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800411:	74 1e                	je     800431 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800413:	8b 45 08             	mov    0x8(%ebp),%eax
  800416:	8b 00                	mov    (%eax),%eax
  800418:	8d 50 04             	lea    0x4(%eax),%edx
  80041b:	8b 45 08             	mov    0x8(%ebp),%eax
  80041e:	89 10                	mov    %edx,(%eax)
  800420:	8b 45 08             	mov    0x8(%ebp),%eax
  800423:	8b 00                	mov    (%eax),%eax
  800425:	83 e8 04             	sub    $0x4,%eax
  800428:	8b 00                	mov    (%eax),%eax
  80042a:	ba 00 00 00 00       	mov    $0x0,%edx
  80042f:	eb 1c                	jmp    80044d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800431:	8b 45 08             	mov    0x8(%ebp),%eax
  800434:	8b 00                	mov    (%eax),%eax
  800436:	8d 50 04             	lea    0x4(%eax),%edx
  800439:	8b 45 08             	mov    0x8(%ebp),%eax
  80043c:	89 10                	mov    %edx,(%eax)
  80043e:	8b 45 08             	mov    0x8(%ebp),%eax
  800441:	8b 00                	mov    (%eax),%eax
  800443:	83 e8 04             	sub    $0x4,%eax
  800446:	8b 00                	mov    (%eax),%eax
  800448:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80044d:	5d                   	pop    %ebp
  80044e:	c3                   	ret    

0080044f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80044f:	55                   	push   %ebp
  800450:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800452:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800456:	7e 1c                	jle    800474 <getint+0x25>
		return va_arg(*ap, long long);
  800458:	8b 45 08             	mov    0x8(%ebp),%eax
  80045b:	8b 00                	mov    (%eax),%eax
  80045d:	8d 50 08             	lea    0x8(%eax),%edx
  800460:	8b 45 08             	mov    0x8(%ebp),%eax
  800463:	89 10                	mov    %edx,(%eax)
  800465:	8b 45 08             	mov    0x8(%ebp),%eax
  800468:	8b 00                	mov    (%eax),%eax
  80046a:	83 e8 08             	sub    $0x8,%eax
  80046d:	8b 50 04             	mov    0x4(%eax),%edx
  800470:	8b 00                	mov    (%eax),%eax
  800472:	eb 38                	jmp    8004ac <getint+0x5d>
	else if (lflag)
  800474:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800478:	74 1a                	je     800494 <getint+0x45>
		return va_arg(*ap, long);
  80047a:	8b 45 08             	mov    0x8(%ebp),%eax
  80047d:	8b 00                	mov    (%eax),%eax
  80047f:	8d 50 04             	lea    0x4(%eax),%edx
  800482:	8b 45 08             	mov    0x8(%ebp),%eax
  800485:	89 10                	mov    %edx,(%eax)
  800487:	8b 45 08             	mov    0x8(%ebp),%eax
  80048a:	8b 00                	mov    (%eax),%eax
  80048c:	83 e8 04             	sub    $0x4,%eax
  80048f:	8b 00                	mov    (%eax),%eax
  800491:	99                   	cltd   
  800492:	eb 18                	jmp    8004ac <getint+0x5d>
	else
		return va_arg(*ap, int);
  800494:	8b 45 08             	mov    0x8(%ebp),%eax
  800497:	8b 00                	mov    (%eax),%eax
  800499:	8d 50 04             	lea    0x4(%eax),%edx
  80049c:	8b 45 08             	mov    0x8(%ebp),%eax
  80049f:	89 10                	mov    %edx,(%eax)
  8004a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a4:	8b 00                	mov    (%eax),%eax
  8004a6:	83 e8 04             	sub    $0x4,%eax
  8004a9:	8b 00                	mov    (%eax),%eax
  8004ab:	99                   	cltd   
}
  8004ac:	5d                   	pop    %ebp
  8004ad:	c3                   	ret    

008004ae <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004ae:	55                   	push   %ebp
  8004af:	89 e5                	mov    %esp,%ebp
  8004b1:	56                   	push   %esi
  8004b2:	53                   	push   %ebx
  8004b3:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004b6:	eb 17                	jmp    8004cf <vprintfmt+0x21>
			if (ch == '\0')
  8004b8:	85 db                	test   %ebx,%ebx
  8004ba:	0f 84 af 03 00 00    	je     80086f <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004c0:	83 ec 08             	sub    $0x8,%esp
  8004c3:	ff 75 0c             	pushl  0xc(%ebp)
  8004c6:	53                   	push   %ebx
  8004c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ca:	ff d0                	call   *%eax
  8004cc:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8004d2:	8d 50 01             	lea    0x1(%eax),%edx
  8004d5:	89 55 10             	mov    %edx,0x10(%ebp)
  8004d8:	8a 00                	mov    (%eax),%al
  8004da:	0f b6 d8             	movzbl %al,%ebx
  8004dd:	83 fb 25             	cmp    $0x25,%ebx
  8004e0:	75 d6                	jne    8004b8 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004e2:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004e6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004ed:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004f4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004fb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800502:	8b 45 10             	mov    0x10(%ebp),%eax
  800505:	8d 50 01             	lea    0x1(%eax),%edx
  800508:	89 55 10             	mov    %edx,0x10(%ebp)
  80050b:	8a 00                	mov    (%eax),%al
  80050d:	0f b6 d8             	movzbl %al,%ebx
  800510:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800513:	83 f8 55             	cmp    $0x55,%eax
  800516:	0f 87 2b 03 00 00    	ja     800847 <vprintfmt+0x399>
  80051c:	8b 04 85 f8 1f 80 00 	mov    0x801ff8(,%eax,4),%eax
  800523:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800525:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800529:	eb d7                	jmp    800502 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80052b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80052f:	eb d1                	jmp    800502 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800531:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800538:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80053b:	89 d0                	mov    %edx,%eax
  80053d:	c1 e0 02             	shl    $0x2,%eax
  800540:	01 d0                	add    %edx,%eax
  800542:	01 c0                	add    %eax,%eax
  800544:	01 d8                	add    %ebx,%eax
  800546:	83 e8 30             	sub    $0x30,%eax
  800549:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80054c:	8b 45 10             	mov    0x10(%ebp),%eax
  80054f:	8a 00                	mov    (%eax),%al
  800551:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800554:	83 fb 2f             	cmp    $0x2f,%ebx
  800557:	7e 3e                	jle    800597 <vprintfmt+0xe9>
  800559:	83 fb 39             	cmp    $0x39,%ebx
  80055c:	7f 39                	jg     800597 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80055e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800561:	eb d5                	jmp    800538 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800563:	8b 45 14             	mov    0x14(%ebp),%eax
  800566:	83 c0 04             	add    $0x4,%eax
  800569:	89 45 14             	mov    %eax,0x14(%ebp)
  80056c:	8b 45 14             	mov    0x14(%ebp),%eax
  80056f:	83 e8 04             	sub    $0x4,%eax
  800572:	8b 00                	mov    (%eax),%eax
  800574:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800577:	eb 1f                	jmp    800598 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800579:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80057d:	79 83                	jns    800502 <vprintfmt+0x54>
				width = 0;
  80057f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800586:	e9 77 ff ff ff       	jmp    800502 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80058b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800592:	e9 6b ff ff ff       	jmp    800502 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800597:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800598:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80059c:	0f 89 60 ff ff ff    	jns    800502 <vprintfmt+0x54>
				width = precision, precision = -1;
  8005a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005a8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005af:	e9 4e ff ff ff       	jmp    800502 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005b4:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005b7:	e9 46 ff ff ff       	jmp    800502 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8005bf:	83 c0 04             	add    $0x4,%eax
  8005c2:	89 45 14             	mov    %eax,0x14(%ebp)
  8005c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c8:	83 e8 04             	sub    $0x4,%eax
  8005cb:	8b 00                	mov    (%eax),%eax
  8005cd:	83 ec 08             	sub    $0x8,%esp
  8005d0:	ff 75 0c             	pushl  0xc(%ebp)
  8005d3:	50                   	push   %eax
  8005d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d7:	ff d0                	call   *%eax
  8005d9:	83 c4 10             	add    $0x10,%esp
			break;
  8005dc:	e9 89 02 00 00       	jmp    80086a <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005e1:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e4:	83 c0 04             	add    $0x4,%eax
  8005e7:	89 45 14             	mov    %eax,0x14(%ebp)
  8005ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ed:	83 e8 04             	sub    $0x4,%eax
  8005f0:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005f2:	85 db                	test   %ebx,%ebx
  8005f4:	79 02                	jns    8005f8 <vprintfmt+0x14a>
				err = -err;
  8005f6:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005f8:	83 fb 64             	cmp    $0x64,%ebx
  8005fb:	7f 0b                	jg     800608 <vprintfmt+0x15a>
  8005fd:	8b 34 9d 40 1e 80 00 	mov    0x801e40(,%ebx,4),%esi
  800604:	85 f6                	test   %esi,%esi
  800606:	75 19                	jne    800621 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800608:	53                   	push   %ebx
  800609:	68 e5 1f 80 00       	push   $0x801fe5
  80060e:	ff 75 0c             	pushl  0xc(%ebp)
  800611:	ff 75 08             	pushl  0x8(%ebp)
  800614:	e8 5e 02 00 00       	call   800877 <printfmt>
  800619:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80061c:	e9 49 02 00 00       	jmp    80086a <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800621:	56                   	push   %esi
  800622:	68 ee 1f 80 00       	push   $0x801fee
  800627:	ff 75 0c             	pushl  0xc(%ebp)
  80062a:	ff 75 08             	pushl  0x8(%ebp)
  80062d:	e8 45 02 00 00       	call   800877 <printfmt>
  800632:	83 c4 10             	add    $0x10,%esp
			break;
  800635:	e9 30 02 00 00       	jmp    80086a <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80063a:	8b 45 14             	mov    0x14(%ebp),%eax
  80063d:	83 c0 04             	add    $0x4,%eax
  800640:	89 45 14             	mov    %eax,0x14(%ebp)
  800643:	8b 45 14             	mov    0x14(%ebp),%eax
  800646:	83 e8 04             	sub    $0x4,%eax
  800649:	8b 30                	mov    (%eax),%esi
  80064b:	85 f6                	test   %esi,%esi
  80064d:	75 05                	jne    800654 <vprintfmt+0x1a6>
				p = "(null)";
  80064f:	be f1 1f 80 00       	mov    $0x801ff1,%esi
			if (width > 0 && padc != '-')
  800654:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800658:	7e 6d                	jle    8006c7 <vprintfmt+0x219>
  80065a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80065e:	74 67                	je     8006c7 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800660:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800663:	83 ec 08             	sub    $0x8,%esp
  800666:	50                   	push   %eax
  800667:	56                   	push   %esi
  800668:	e8 12 05 00 00       	call   800b7f <strnlen>
  80066d:	83 c4 10             	add    $0x10,%esp
  800670:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800673:	eb 16                	jmp    80068b <vprintfmt+0x1dd>
					putch(padc, putdat);
  800675:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800679:	83 ec 08             	sub    $0x8,%esp
  80067c:	ff 75 0c             	pushl  0xc(%ebp)
  80067f:	50                   	push   %eax
  800680:	8b 45 08             	mov    0x8(%ebp),%eax
  800683:	ff d0                	call   *%eax
  800685:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800688:	ff 4d e4             	decl   -0x1c(%ebp)
  80068b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80068f:	7f e4                	jg     800675 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800691:	eb 34                	jmp    8006c7 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800693:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800697:	74 1c                	je     8006b5 <vprintfmt+0x207>
  800699:	83 fb 1f             	cmp    $0x1f,%ebx
  80069c:	7e 05                	jle    8006a3 <vprintfmt+0x1f5>
  80069e:	83 fb 7e             	cmp    $0x7e,%ebx
  8006a1:	7e 12                	jle    8006b5 <vprintfmt+0x207>
					putch('?', putdat);
  8006a3:	83 ec 08             	sub    $0x8,%esp
  8006a6:	ff 75 0c             	pushl  0xc(%ebp)
  8006a9:	6a 3f                	push   $0x3f
  8006ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ae:	ff d0                	call   *%eax
  8006b0:	83 c4 10             	add    $0x10,%esp
  8006b3:	eb 0f                	jmp    8006c4 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006b5:	83 ec 08             	sub    $0x8,%esp
  8006b8:	ff 75 0c             	pushl  0xc(%ebp)
  8006bb:	53                   	push   %ebx
  8006bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bf:	ff d0                	call   *%eax
  8006c1:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006c4:	ff 4d e4             	decl   -0x1c(%ebp)
  8006c7:	89 f0                	mov    %esi,%eax
  8006c9:	8d 70 01             	lea    0x1(%eax),%esi
  8006cc:	8a 00                	mov    (%eax),%al
  8006ce:	0f be d8             	movsbl %al,%ebx
  8006d1:	85 db                	test   %ebx,%ebx
  8006d3:	74 24                	je     8006f9 <vprintfmt+0x24b>
  8006d5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006d9:	78 b8                	js     800693 <vprintfmt+0x1e5>
  8006db:	ff 4d e0             	decl   -0x20(%ebp)
  8006de:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006e2:	79 af                	jns    800693 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006e4:	eb 13                	jmp    8006f9 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006e6:	83 ec 08             	sub    $0x8,%esp
  8006e9:	ff 75 0c             	pushl  0xc(%ebp)
  8006ec:	6a 20                	push   $0x20
  8006ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f1:	ff d0                	call   *%eax
  8006f3:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006f6:	ff 4d e4             	decl   -0x1c(%ebp)
  8006f9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006fd:	7f e7                	jg     8006e6 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006ff:	e9 66 01 00 00       	jmp    80086a <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800704:	83 ec 08             	sub    $0x8,%esp
  800707:	ff 75 e8             	pushl  -0x18(%ebp)
  80070a:	8d 45 14             	lea    0x14(%ebp),%eax
  80070d:	50                   	push   %eax
  80070e:	e8 3c fd ff ff       	call   80044f <getint>
  800713:	83 c4 10             	add    $0x10,%esp
  800716:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800719:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80071c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80071f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800722:	85 d2                	test   %edx,%edx
  800724:	79 23                	jns    800749 <vprintfmt+0x29b>
				putch('-', putdat);
  800726:	83 ec 08             	sub    $0x8,%esp
  800729:	ff 75 0c             	pushl  0xc(%ebp)
  80072c:	6a 2d                	push   $0x2d
  80072e:	8b 45 08             	mov    0x8(%ebp),%eax
  800731:	ff d0                	call   *%eax
  800733:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800736:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800739:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80073c:	f7 d8                	neg    %eax
  80073e:	83 d2 00             	adc    $0x0,%edx
  800741:	f7 da                	neg    %edx
  800743:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800746:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800749:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800750:	e9 bc 00 00 00       	jmp    800811 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800755:	83 ec 08             	sub    $0x8,%esp
  800758:	ff 75 e8             	pushl  -0x18(%ebp)
  80075b:	8d 45 14             	lea    0x14(%ebp),%eax
  80075e:	50                   	push   %eax
  80075f:	e8 84 fc ff ff       	call   8003e8 <getuint>
  800764:	83 c4 10             	add    $0x10,%esp
  800767:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80076a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80076d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800774:	e9 98 00 00 00       	jmp    800811 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800779:	83 ec 08             	sub    $0x8,%esp
  80077c:	ff 75 0c             	pushl  0xc(%ebp)
  80077f:	6a 58                	push   $0x58
  800781:	8b 45 08             	mov    0x8(%ebp),%eax
  800784:	ff d0                	call   *%eax
  800786:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800789:	83 ec 08             	sub    $0x8,%esp
  80078c:	ff 75 0c             	pushl  0xc(%ebp)
  80078f:	6a 58                	push   $0x58
  800791:	8b 45 08             	mov    0x8(%ebp),%eax
  800794:	ff d0                	call   *%eax
  800796:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800799:	83 ec 08             	sub    $0x8,%esp
  80079c:	ff 75 0c             	pushl  0xc(%ebp)
  80079f:	6a 58                	push   $0x58
  8007a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a4:	ff d0                	call   *%eax
  8007a6:	83 c4 10             	add    $0x10,%esp
			break;
  8007a9:	e9 bc 00 00 00       	jmp    80086a <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007ae:	83 ec 08             	sub    $0x8,%esp
  8007b1:	ff 75 0c             	pushl  0xc(%ebp)
  8007b4:	6a 30                	push   $0x30
  8007b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b9:	ff d0                	call   *%eax
  8007bb:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007be:	83 ec 08             	sub    $0x8,%esp
  8007c1:	ff 75 0c             	pushl  0xc(%ebp)
  8007c4:	6a 78                	push   $0x78
  8007c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c9:	ff d0                	call   *%eax
  8007cb:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d1:	83 c0 04             	add    $0x4,%eax
  8007d4:	89 45 14             	mov    %eax,0x14(%ebp)
  8007d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8007da:	83 e8 04             	sub    $0x4,%eax
  8007dd:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007e2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007e9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007f0:	eb 1f                	jmp    800811 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007f2:	83 ec 08             	sub    $0x8,%esp
  8007f5:	ff 75 e8             	pushl  -0x18(%ebp)
  8007f8:	8d 45 14             	lea    0x14(%ebp),%eax
  8007fb:	50                   	push   %eax
  8007fc:	e8 e7 fb ff ff       	call   8003e8 <getuint>
  800801:	83 c4 10             	add    $0x10,%esp
  800804:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800807:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80080a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800811:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800815:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800818:	83 ec 04             	sub    $0x4,%esp
  80081b:	52                   	push   %edx
  80081c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80081f:	50                   	push   %eax
  800820:	ff 75 f4             	pushl  -0xc(%ebp)
  800823:	ff 75 f0             	pushl  -0x10(%ebp)
  800826:	ff 75 0c             	pushl  0xc(%ebp)
  800829:	ff 75 08             	pushl  0x8(%ebp)
  80082c:	e8 00 fb ff ff       	call   800331 <printnum>
  800831:	83 c4 20             	add    $0x20,%esp
			break;
  800834:	eb 34                	jmp    80086a <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800836:	83 ec 08             	sub    $0x8,%esp
  800839:	ff 75 0c             	pushl  0xc(%ebp)
  80083c:	53                   	push   %ebx
  80083d:	8b 45 08             	mov    0x8(%ebp),%eax
  800840:	ff d0                	call   *%eax
  800842:	83 c4 10             	add    $0x10,%esp
			break;
  800845:	eb 23                	jmp    80086a <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800847:	83 ec 08             	sub    $0x8,%esp
  80084a:	ff 75 0c             	pushl  0xc(%ebp)
  80084d:	6a 25                	push   $0x25
  80084f:	8b 45 08             	mov    0x8(%ebp),%eax
  800852:	ff d0                	call   *%eax
  800854:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800857:	ff 4d 10             	decl   0x10(%ebp)
  80085a:	eb 03                	jmp    80085f <vprintfmt+0x3b1>
  80085c:	ff 4d 10             	decl   0x10(%ebp)
  80085f:	8b 45 10             	mov    0x10(%ebp),%eax
  800862:	48                   	dec    %eax
  800863:	8a 00                	mov    (%eax),%al
  800865:	3c 25                	cmp    $0x25,%al
  800867:	75 f3                	jne    80085c <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800869:	90                   	nop
		}
	}
  80086a:	e9 47 fc ff ff       	jmp    8004b6 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80086f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800870:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800873:	5b                   	pop    %ebx
  800874:	5e                   	pop    %esi
  800875:	5d                   	pop    %ebp
  800876:	c3                   	ret    

00800877 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800877:	55                   	push   %ebp
  800878:	89 e5                	mov    %esp,%ebp
  80087a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80087d:	8d 45 10             	lea    0x10(%ebp),%eax
  800880:	83 c0 04             	add    $0x4,%eax
  800883:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800886:	8b 45 10             	mov    0x10(%ebp),%eax
  800889:	ff 75 f4             	pushl  -0xc(%ebp)
  80088c:	50                   	push   %eax
  80088d:	ff 75 0c             	pushl  0xc(%ebp)
  800890:	ff 75 08             	pushl  0x8(%ebp)
  800893:	e8 16 fc ff ff       	call   8004ae <vprintfmt>
  800898:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80089b:	90                   	nop
  80089c:	c9                   	leave  
  80089d:	c3                   	ret    

0080089e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80089e:	55                   	push   %ebp
  80089f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a4:	8b 40 08             	mov    0x8(%eax),%eax
  8008a7:	8d 50 01             	lea    0x1(%eax),%edx
  8008aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ad:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b3:	8b 10                	mov    (%eax),%edx
  8008b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b8:	8b 40 04             	mov    0x4(%eax),%eax
  8008bb:	39 c2                	cmp    %eax,%edx
  8008bd:	73 12                	jae    8008d1 <sprintputch+0x33>
		*b->buf++ = ch;
  8008bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c2:	8b 00                	mov    (%eax),%eax
  8008c4:	8d 48 01             	lea    0x1(%eax),%ecx
  8008c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ca:	89 0a                	mov    %ecx,(%edx)
  8008cc:	8b 55 08             	mov    0x8(%ebp),%edx
  8008cf:	88 10                	mov    %dl,(%eax)
}
  8008d1:	90                   	nop
  8008d2:	5d                   	pop    %ebp
  8008d3:	c3                   	ret    

008008d4 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008d4:	55                   	push   %ebp
  8008d5:	89 e5                	mov    %esp,%ebp
  8008d7:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008da:	8b 45 08             	mov    0x8(%ebp),%eax
  8008dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e9:	01 d0                	add    %edx,%eax
  8008eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008ee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008f5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008f9:	74 06                	je     800901 <vsnprintf+0x2d>
  8008fb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008ff:	7f 07                	jg     800908 <vsnprintf+0x34>
		return -E_INVAL;
  800901:	b8 03 00 00 00       	mov    $0x3,%eax
  800906:	eb 20                	jmp    800928 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800908:	ff 75 14             	pushl  0x14(%ebp)
  80090b:	ff 75 10             	pushl  0x10(%ebp)
  80090e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800911:	50                   	push   %eax
  800912:	68 9e 08 80 00       	push   $0x80089e
  800917:	e8 92 fb ff ff       	call   8004ae <vprintfmt>
  80091c:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80091f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800922:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800925:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800928:	c9                   	leave  
  800929:	c3                   	ret    

0080092a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80092a:	55                   	push   %ebp
  80092b:	89 e5                	mov    %esp,%ebp
  80092d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800930:	8d 45 10             	lea    0x10(%ebp),%eax
  800933:	83 c0 04             	add    $0x4,%eax
  800936:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800939:	8b 45 10             	mov    0x10(%ebp),%eax
  80093c:	ff 75 f4             	pushl  -0xc(%ebp)
  80093f:	50                   	push   %eax
  800940:	ff 75 0c             	pushl  0xc(%ebp)
  800943:	ff 75 08             	pushl  0x8(%ebp)
  800946:	e8 89 ff ff ff       	call   8008d4 <vsnprintf>
  80094b:	83 c4 10             	add    $0x10,%esp
  80094e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800951:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800954:	c9                   	leave  
  800955:	c3                   	ret    

00800956 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800956:	55                   	push   %ebp
  800957:	89 e5                	mov    %esp,%ebp
  800959:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80095c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800960:	74 13                	je     800975 <readline+0x1f>
		cprintf("%s", prompt);
  800962:	83 ec 08             	sub    $0x8,%esp
  800965:	ff 75 08             	pushl  0x8(%ebp)
  800968:	68 50 21 80 00       	push   $0x802150
  80096d:	e8 62 f9 ff ff       	call   8002d4 <cprintf>
  800972:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800975:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80097c:	83 ec 0c             	sub    $0xc,%esp
  80097f:	6a 00                	push   $0x0
  800981:	e8 a1 10 00 00       	call   801a27 <iscons>
  800986:	83 c4 10             	add    $0x10,%esp
  800989:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80098c:	e8 48 10 00 00       	call   8019d9 <getchar>
  800991:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800994:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800998:	79 22                	jns    8009bc <readline+0x66>
			if (c != -E_EOF)
  80099a:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80099e:	0f 84 ad 00 00 00    	je     800a51 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8009a4:	83 ec 08             	sub    $0x8,%esp
  8009a7:	ff 75 ec             	pushl  -0x14(%ebp)
  8009aa:	68 53 21 80 00       	push   $0x802153
  8009af:	e8 20 f9 ff ff       	call   8002d4 <cprintf>
  8009b4:	83 c4 10             	add    $0x10,%esp
			return;
  8009b7:	e9 95 00 00 00       	jmp    800a51 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8009bc:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8009c0:	7e 34                	jle    8009f6 <readline+0xa0>
  8009c2:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8009c9:	7f 2b                	jg     8009f6 <readline+0xa0>
			if (echoing)
  8009cb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009cf:	74 0e                	je     8009df <readline+0x89>
				cputchar(c);
  8009d1:	83 ec 0c             	sub    $0xc,%esp
  8009d4:	ff 75 ec             	pushl  -0x14(%ebp)
  8009d7:	e8 b5 0f 00 00       	call   801991 <cputchar>
  8009dc:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8009df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009e2:	8d 50 01             	lea    0x1(%eax),%edx
  8009e5:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8009e8:	89 c2                	mov    %eax,%edx
  8009ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ed:	01 d0                	add    %edx,%eax
  8009ef:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8009f2:	88 10                	mov    %dl,(%eax)
  8009f4:	eb 56                	jmp    800a4c <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8009f6:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8009fa:	75 1f                	jne    800a1b <readline+0xc5>
  8009fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800a00:	7e 19                	jle    800a1b <readline+0xc5>
			if (echoing)
  800a02:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a06:	74 0e                	je     800a16 <readline+0xc0>
				cputchar(c);
  800a08:	83 ec 0c             	sub    $0xc,%esp
  800a0b:	ff 75 ec             	pushl  -0x14(%ebp)
  800a0e:	e8 7e 0f 00 00       	call   801991 <cputchar>
  800a13:	83 c4 10             	add    $0x10,%esp

			i--;
  800a16:	ff 4d f4             	decl   -0xc(%ebp)
  800a19:	eb 31                	jmp    800a4c <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800a1b:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800a1f:	74 0a                	je     800a2b <readline+0xd5>
  800a21:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800a25:	0f 85 61 ff ff ff    	jne    80098c <readline+0x36>
			if (echoing)
  800a2b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a2f:	74 0e                	je     800a3f <readline+0xe9>
				cputchar(c);
  800a31:	83 ec 0c             	sub    $0xc,%esp
  800a34:	ff 75 ec             	pushl  -0x14(%ebp)
  800a37:	e8 55 0f 00 00       	call   801991 <cputchar>
  800a3c:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800a3f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a42:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a45:	01 d0                	add    %edx,%eax
  800a47:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800a4a:	eb 06                	jmp    800a52 <readline+0xfc>
		}
	}
  800a4c:	e9 3b ff ff ff       	jmp    80098c <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800a51:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800a52:	c9                   	leave  
  800a53:	c3                   	ret    

00800a54 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800a54:	55                   	push   %ebp
  800a55:	89 e5                	mov    %esp,%ebp
  800a57:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a5a:	e8 41 0a 00 00       	call   8014a0 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800a5f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a63:	74 13                	je     800a78 <atomic_readline+0x24>
		cprintf("%s", prompt);
  800a65:	83 ec 08             	sub    $0x8,%esp
  800a68:	ff 75 08             	pushl  0x8(%ebp)
  800a6b:	68 50 21 80 00       	push   $0x802150
  800a70:	e8 5f f8 ff ff       	call   8002d4 <cprintf>
  800a75:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800a78:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800a7f:	83 ec 0c             	sub    $0xc,%esp
  800a82:	6a 00                	push   $0x0
  800a84:	e8 9e 0f 00 00       	call   801a27 <iscons>
  800a89:	83 c4 10             	add    $0x10,%esp
  800a8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800a8f:	e8 45 0f 00 00       	call   8019d9 <getchar>
  800a94:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800a97:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a9b:	79 23                	jns    800ac0 <atomic_readline+0x6c>
			if (c != -E_EOF)
  800a9d:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800aa1:	74 13                	je     800ab6 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800aa3:	83 ec 08             	sub    $0x8,%esp
  800aa6:	ff 75 ec             	pushl  -0x14(%ebp)
  800aa9:	68 53 21 80 00       	push   $0x802153
  800aae:	e8 21 f8 ff ff       	call   8002d4 <cprintf>
  800ab3:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800ab6:	e8 ff 09 00 00       	call   8014ba <sys_enable_interrupt>
			return;
  800abb:	e9 9a 00 00 00       	jmp    800b5a <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800ac0:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800ac4:	7e 34                	jle    800afa <atomic_readline+0xa6>
  800ac6:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800acd:	7f 2b                	jg     800afa <atomic_readline+0xa6>
			if (echoing)
  800acf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800ad3:	74 0e                	je     800ae3 <atomic_readline+0x8f>
				cputchar(c);
  800ad5:	83 ec 0c             	sub    $0xc,%esp
  800ad8:	ff 75 ec             	pushl  -0x14(%ebp)
  800adb:	e8 b1 0e 00 00       	call   801991 <cputchar>
  800ae0:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800ae3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ae6:	8d 50 01             	lea    0x1(%eax),%edx
  800ae9:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800aec:	89 c2                	mov    %eax,%edx
  800aee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af1:	01 d0                	add    %edx,%eax
  800af3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800af6:	88 10                	mov    %dl,(%eax)
  800af8:	eb 5b                	jmp    800b55 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800afa:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800afe:	75 1f                	jne    800b1f <atomic_readline+0xcb>
  800b00:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800b04:	7e 19                	jle    800b1f <atomic_readline+0xcb>
			if (echoing)
  800b06:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b0a:	74 0e                	je     800b1a <atomic_readline+0xc6>
				cputchar(c);
  800b0c:	83 ec 0c             	sub    $0xc,%esp
  800b0f:	ff 75 ec             	pushl  -0x14(%ebp)
  800b12:	e8 7a 0e 00 00       	call   801991 <cputchar>
  800b17:	83 c4 10             	add    $0x10,%esp
			i--;
  800b1a:	ff 4d f4             	decl   -0xc(%ebp)
  800b1d:	eb 36                	jmp    800b55 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800b1f:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800b23:	74 0a                	je     800b2f <atomic_readline+0xdb>
  800b25:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800b29:	0f 85 60 ff ff ff    	jne    800a8f <atomic_readline+0x3b>
			if (echoing)
  800b2f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b33:	74 0e                	je     800b43 <atomic_readline+0xef>
				cputchar(c);
  800b35:	83 ec 0c             	sub    $0xc,%esp
  800b38:	ff 75 ec             	pushl  -0x14(%ebp)
  800b3b:	e8 51 0e 00 00       	call   801991 <cputchar>
  800b40:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800b43:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b49:	01 d0                	add    %edx,%eax
  800b4b:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800b4e:	e8 67 09 00 00       	call   8014ba <sys_enable_interrupt>
			return;
  800b53:	eb 05                	jmp    800b5a <atomic_readline+0x106>
		}
	}
  800b55:	e9 35 ff ff ff       	jmp    800a8f <atomic_readline+0x3b>
}
  800b5a:	c9                   	leave  
  800b5b:	c3                   	ret    

00800b5c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b5c:	55                   	push   %ebp
  800b5d:	89 e5                	mov    %esp,%ebp
  800b5f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b62:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b69:	eb 06                	jmp    800b71 <strlen+0x15>
		n++;
  800b6b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b6e:	ff 45 08             	incl   0x8(%ebp)
  800b71:	8b 45 08             	mov    0x8(%ebp),%eax
  800b74:	8a 00                	mov    (%eax),%al
  800b76:	84 c0                	test   %al,%al
  800b78:	75 f1                	jne    800b6b <strlen+0xf>
		n++;
	return n;
  800b7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b7d:	c9                   	leave  
  800b7e:	c3                   	ret    

00800b7f <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b7f:	55                   	push   %ebp
  800b80:	89 e5                	mov    %esp,%ebp
  800b82:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b85:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b8c:	eb 09                	jmp    800b97 <strnlen+0x18>
		n++;
  800b8e:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b91:	ff 45 08             	incl   0x8(%ebp)
  800b94:	ff 4d 0c             	decl   0xc(%ebp)
  800b97:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b9b:	74 09                	je     800ba6 <strnlen+0x27>
  800b9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba0:	8a 00                	mov    (%eax),%al
  800ba2:	84 c0                	test   %al,%al
  800ba4:	75 e8                	jne    800b8e <strnlen+0xf>
		n++;
	return n;
  800ba6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ba9:	c9                   	leave  
  800baa:	c3                   	ret    

00800bab <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bab:	55                   	push   %ebp
  800bac:	89 e5                	mov    %esp,%ebp
  800bae:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bb7:	90                   	nop
  800bb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbb:	8d 50 01             	lea    0x1(%eax),%edx
  800bbe:	89 55 08             	mov    %edx,0x8(%ebp)
  800bc1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bc7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bca:	8a 12                	mov    (%edx),%dl
  800bcc:	88 10                	mov    %dl,(%eax)
  800bce:	8a 00                	mov    (%eax),%al
  800bd0:	84 c0                	test   %al,%al
  800bd2:	75 e4                	jne    800bb8 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bd4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bd7:	c9                   	leave  
  800bd8:	c3                   	ret    

00800bd9 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bd9:	55                   	push   %ebp
  800bda:	89 e5                	mov    %esp,%ebp
  800bdc:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800be2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800be5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bec:	eb 1f                	jmp    800c0d <strncpy+0x34>
		*dst++ = *src;
  800bee:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf1:	8d 50 01             	lea    0x1(%eax),%edx
  800bf4:	89 55 08             	mov    %edx,0x8(%ebp)
  800bf7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bfa:	8a 12                	mov    (%edx),%dl
  800bfc:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800bfe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c01:	8a 00                	mov    (%eax),%al
  800c03:	84 c0                	test   %al,%al
  800c05:	74 03                	je     800c0a <strncpy+0x31>
			src++;
  800c07:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c0a:	ff 45 fc             	incl   -0x4(%ebp)
  800c0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c10:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c13:	72 d9                	jb     800bee <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c15:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c18:	c9                   	leave  
  800c19:	c3                   	ret    

00800c1a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c1a:	55                   	push   %ebp
  800c1b:	89 e5                	mov    %esp,%ebp
  800c1d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c20:	8b 45 08             	mov    0x8(%ebp),%eax
  800c23:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c26:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c2a:	74 30                	je     800c5c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c2c:	eb 16                	jmp    800c44 <strlcpy+0x2a>
			*dst++ = *src++;
  800c2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c31:	8d 50 01             	lea    0x1(%eax),%edx
  800c34:	89 55 08             	mov    %edx,0x8(%ebp)
  800c37:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c3a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c3d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c40:	8a 12                	mov    (%edx),%dl
  800c42:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c44:	ff 4d 10             	decl   0x10(%ebp)
  800c47:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c4b:	74 09                	je     800c56 <strlcpy+0x3c>
  800c4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c50:	8a 00                	mov    (%eax),%al
  800c52:	84 c0                	test   %al,%al
  800c54:	75 d8                	jne    800c2e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c56:	8b 45 08             	mov    0x8(%ebp),%eax
  800c59:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c5c:	8b 55 08             	mov    0x8(%ebp),%edx
  800c5f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c62:	29 c2                	sub    %eax,%edx
  800c64:	89 d0                	mov    %edx,%eax
}
  800c66:	c9                   	leave  
  800c67:	c3                   	ret    

00800c68 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c68:	55                   	push   %ebp
  800c69:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c6b:	eb 06                	jmp    800c73 <strcmp+0xb>
		p++, q++;
  800c6d:	ff 45 08             	incl   0x8(%ebp)
  800c70:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c73:	8b 45 08             	mov    0x8(%ebp),%eax
  800c76:	8a 00                	mov    (%eax),%al
  800c78:	84 c0                	test   %al,%al
  800c7a:	74 0e                	je     800c8a <strcmp+0x22>
  800c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7f:	8a 10                	mov    (%eax),%dl
  800c81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c84:	8a 00                	mov    (%eax),%al
  800c86:	38 c2                	cmp    %al,%dl
  800c88:	74 e3                	je     800c6d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8d:	8a 00                	mov    (%eax),%al
  800c8f:	0f b6 d0             	movzbl %al,%edx
  800c92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c95:	8a 00                	mov    (%eax),%al
  800c97:	0f b6 c0             	movzbl %al,%eax
  800c9a:	29 c2                	sub    %eax,%edx
  800c9c:	89 d0                	mov    %edx,%eax
}
  800c9e:	5d                   	pop    %ebp
  800c9f:	c3                   	ret    

00800ca0 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ca0:	55                   	push   %ebp
  800ca1:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ca3:	eb 09                	jmp    800cae <strncmp+0xe>
		n--, p++, q++;
  800ca5:	ff 4d 10             	decl   0x10(%ebp)
  800ca8:	ff 45 08             	incl   0x8(%ebp)
  800cab:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cb2:	74 17                	je     800ccb <strncmp+0x2b>
  800cb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb7:	8a 00                	mov    (%eax),%al
  800cb9:	84 c0                	test   %al,%al
  800cbb:	74 0e                	je     800ccb <strncmp+0x2b>
  800cbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc0:	8a 10                	mov    (%eax),%dl
  800cc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc5:	8a 00                	mov    (%eax),%al
  800cc7:	38 c2                	cmp    %al,%dl
  800cc9:	74 da                	je     800ca5 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ccb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ccf:	75 07                	jne    800cd8 <strncmp+0x38>
		return 0;
  800cd1:	b8 00 00 00 00       	mov    $0x0,%eax
  800cd6:	eb 14                	jmp    800cec <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdb:	8a 00                	mov    (%eax),%al
  800cdd:	0f b6 d0             	movzbl %al,%edx
  800ce0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce3:	8a 00                	mov    (%eax),%al
  800ce5:	0f b6 c0             	movzbl %al,%eax
  800ce8:	29 c2                	sub    %eax,%edx
  800cea:	89 d0                	mov    %edx,%eax
}
  800cec:	5d                   	pop    %ebp
  800ced:	c3                   	ret    

00800cee <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800cee:	55                   	push   %ebp
  800cef:	89 e5                	mov    %esp,%ebp
  800cf1:	83 ec 04             	sub    $0x4,%esp
  800cf4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cfa:	eb 12                	jmp    800d0e <strchr+0x20>
		if (*s == c)
  800cfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cff:	8a 00                	mov    (%eax),%al
  800d01:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d04:	75 05                	jne    800d0b <strchr+0x1d>
			return (char *) s;
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	eb 11                	jmp    800d1c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d0b:	ff 45 08             	incl   0x8(%ebp)
  800d0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d11:	8a 00                	mov    (%eax),%al
  800d13:	84 c0                	test   %al,%al
  800d15:	75 e5                	jne    800cfc <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d17:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d1c:	c9                   	leave  
  800d1d:	c3                   	ret    

00800d1e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d1e:	55                   	push   %ebp
  800d1f:	89 e5                	mov    %esp,%ebp
  800d21:	83 ec 04             	sub    $0x4,%esp
  800d24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d27:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d2a:	eb 0d                	jmp    800d39 <strfind+0x1b>
		if (*s == c)
  800d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2f:	8a 00                	mov    (%eax),%al
  800d31:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d34:	74 0e                	je     800d44 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d36:	ff 45 08             	incl   0x8(%ebp)
  800d39:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3c:	8a 00                	mov    (%eax),%al
  800d3e:	84 c0                	test   %al,%al
  800d40:	75 ea                	jne    800d2c <strfind+0xe>
  800d42:	eb 01                	jmp    800d45 <strfind+0x27>
		if (*s == c)
			break;
  800d44:	90                   	nop
	return (char *) s;
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d48:	c9                   	leave  
  800d49:	c3                   	ret    

00800d4a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d4a:	55                   	push   %ebp
  800d4b:	89 e5                	mov    %esp,%ebp
  800d4d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d50:	8b 45 08             	mov    0x8(%ebp),%eax
  800d53:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d56:	8b 45 10             	mov    0x10(%ebp),%eax
  800d59:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d5c:	eb 0e                	jmp    800d6c <memset+0x22>
		*p++ = c;
  800d5e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d61:	8d 50 01             	lea    0x1(%eax),%edx
  800d64:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d67:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d6a:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d6c:	ff 4d f8             	decl   -0x8(%ebp)
  800d6f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d73:	79 e9                	jns    800d5e <memset+0x14>
		*p++ = c;

	return v;
  800d75:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d78:	c9                   	leave  
  800d79:	c3                   	ret    

00800d7a <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d7a:	55                   	push   %ebp
  800d7b:	89 e5                	mov    %esp,%ebp
  800d7d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d83:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d86:	8b 45 08             	mov    0x8(%ebp),%eax
  800d89:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d8c:	eb 16                	jmp    800da4 <memcpy+0x2a>
		*d++ = *s++;
  800d8e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d91:	8d 50 01             	lea    0x1(%eax),%edx
  800d94:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d97:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d9a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d9d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800da0:	8a 12                	mov    (%edx),%dl
  800da2:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800da4:	8b 45 10             	mov    0x10(%ebp),%eax
  800da7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800daa:	89 55 10             	mov    %edx,0x10(%ebp)
  800dad:	85 c0                	test   %eax,%eax
  800daf:	75 dd                	jne    800d8e <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800db1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800db4:	c9                   	leave  
  800db5:	c3                   	ret    

00800db6 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800db6:	55                   	push   %ebp
  800db7:	89 e5                	mov    %esp,%ebp
  800db9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800dc8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dcb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dce:	73 50                	jae    800e20 <memmove+0x6a>
  800dd0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dd3:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd6:	01 d0                	add    %edx,%eax
  800dd8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ddb:	76 43                	jbe    800e20 <memmove+0x6a>
		s += n;
  800ddd:	8b 45 10             	mov    0x10(%ebp),%eax
  800de0:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800de3:	8b 45 10             	mov    0x10(%ebp),%eax
  800de6:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800de9:	eb 10                	jmp    800dfb <memmove+0x45>
			*--d = *--s;
  800deb:	ff 4d f8             	decl   -0x8(%ebp)
  800dee:	ff 4d fc             	decl   -0x4(%ebp)
  800df1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800df4:	8a 10                	mov    (%eax),%dl
  800df6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df9:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800dfb:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfe:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e01:	89 55 10             	mov    %edx,0x10(%ebp)
  800e04:	85 c0                	test   %eax,%eax
  800e06:	75 e3                	jne    800deb <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e08:	eb 23                	jmp    800e2d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e0a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e0d:	8d 50 01             	lea    0x1(%eax),%edx
  800e10:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e13:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e16:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e19:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e1c:	8a 12                	mov    (%edx),%dl
  800e1e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e20:	8b 45 10             	mov    0x10(%ebp),%eax
  800e23:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e26:	89 55 10             	mov    %edx,0x10(%ebp)
  800e29:	85 c0                	test   %eax,%eax
  800e2b:	75 dd                	jne    800e0a <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e2d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e30:	c9                   	leave  
  800e31:	c3                   	ret    

00800e32 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e32:	55                   	push   %ebp
  800e33:	89 e5                	mov    %esp,%ebp
  800e35:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e38:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e41:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e44:	eb 2a                	jmp    800e70 <memcmp+0x3e>
		if (*s1 != *s2)
  800e46:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e49:	8a 10                	mov    (%eax),%dl
  800e4b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e4e:	8a 00                	mov    (%eax),%al
  800e50:	38 c2                	cmp    %al,%dl
  800e52:	74 16                	je     800e6a <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e54:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e57:	8a 00                	mov    (%eax),%al
  800e59:	0f b6 d0             	movzbl %al,%edx
  800e5c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e5f:	8a 00                	mov    (%eax),%al
  800e61:	0f b6 c0             	movzbl %al,%eax
  800e64:	29 c2                	sub    %eax,%edx
  800e66:	89 d0                	mov    %edx,%eax
  800e68:	eb 18                	jmp    800e82 <memcmp+0x50>
		s1++, s2++;
  800e6a:	ff 45 fc             	incl   -0x4(%ebp)
  800e6d:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e70:	8b 45 10             	mov    0x10(%ebp),%eax
  800e73:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e76:	89 55 10             	mov    %edx,0x10(%ebp)
  800e79:	85 c0                	test   %eax,%eax
  800e7b:	75 c9                	jne    800e46 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e7d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e82:	c9                   	leave  
  800e83:	c3                   	ret    

00800e84 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e84:	55                   	push   %ebp
  800e85:	89 e5                	mov    %esp,%ebp
  800e87:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e8a:	8b 55 08             	mov    0x8(%ebp),%edx
  800e8d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e90:	01 d0                	add    %edx,%eax
  800e92:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e95:	eb 15                	jmp    800eac <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e97:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9a:	8a 00                	mov    (%eax),%al
  800e9c:	0f b6 d0             	movzbl %al,%edx
  800e9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea2:	0f b6 c0             	movzbl %al,%eax
  800ea5:	39 c2                	cmp    %eax,%edx
  800ea7:	74 0d                	je     800eb6 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ea9:	ff 45 08             	incl   0x8(%ebp)
  800eac:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaf:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800eb2:	72 e3                	jb     800e97 <memfind+0x13>
  800eb4:	eb 01                	jmp    800eb7 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800eb6:	90                   	nop
	return (void *) s;
  800eb7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eba:	c9                   	leave  
  800ebb:	c3                   	ret    

00800ebc <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ebc:	55                   	push   %ebp
  800ebd:	89 e5                	mov    %esp,%ebp
  800ebf:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ec2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ec9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ed0:	eb 03                	jmp    800ed5 <strtol+0x19>
		s++;
  800ed2:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ed5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed8:	8a 00                	mov    (%eax),%al
  800eda:	3c 20                	cmp    $0x20,%al
  800edc:	74 f4                	je     800ed2 <strtol+0x16>
  800ede:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee1:	8a 00                	mov    (%eax),%al
  800ee3:	3c 09                	cmp    $0x9,%al
  800ee5:	74 eb                	je     800ed2 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ee7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eea:	8a 00                	mov    (%eax),%al
  800eec:	3c 2b                	cmp    $0x2b,%al
  800eee:	75 05                	jne    800ef5 <strtol+0x39>
		s++;
  800ef0:	ff 45 08             	incl   0x8(%ebp)
  800ef3:	eb 13                	jmp    800f08 <strtol+0x4c>
	else if (*s == '-')
  800ef5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef8:	8a 00                	mov    (%eax),%al
  800efa:	3c 2d                	cmp    $0x2d,%al
  800efc:	75 0a                	jne    800f08 <strtol+0x4c>
		s++, neg = 1;
  800efe:	ff 45 08             	incl   0x8(%ebp)
  800f01:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f08:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f0c:	74 06                	je     800f14 <strtol+0x58>
  800f0e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f12:	75 20                	jne    800f34 <strtol+0x78>
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
  800f17:	8a 00                	mov    (%eax),%al
  800f19:	3c 30                	cmp    $0x30,%al
  800f1b:	75 17                	jne    800f34 <strtol+0x78>
  800f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f20:	40                   	inc    %eax
  800f21:	8a 00                	mov    (%eax),%al
  800f23:	3c 78                	cmp    $0x78,%al
  800f25:	75 0d                	jne    800f34 <strtol+0x78>
		s += 2, base = 16;
  800f27:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f2b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f32:	eb 28                	jmp    800f5c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f34:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f38:	75 15                	jne    800f4f <strtol+0x93>
  800f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3d:	8a 00                	mov    (%eax),%al
  800f3f:	3c 30                	cmp    $0x30,%al
  800f41:	75 0c                	jne    800f4f <strtol+0x93>
		s++, base = 8;
  800f43:	ff 45 08             	incl   0x8(%ebp)
  800f46:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f4d:	eb 0d                	jmp    800f5c <strtol+0xa0>
	else if (base == 0)
  800f4f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f53:	75 07                	jne    800f5c <strtol+0xa0>
		base = 10;
  800f55:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5f:	8a 00                	mov    (%eax),%al
  800f61:	3c 2f                	cmp    $0x2f,%al
  800f63:	7e 19                	jle    800f7e <strtol+0xc2>
  800f65:	8b 45 08             	mov    0x8(%ebp),%eax
  800f68:	8a 00                	mov    (%eax),%al
  800f6a:	3c 39                	cmp    $0x39,%al
  800f6c:	7f 10                	jg     800f7e <strtol+0xc2>
			dig = *s - '0';
  800f6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f71:	8a 00                	mov    (%eax),%al
  800f73:	0f be c0             	movsbl %al,%eax
  800f76:	83 e8 30             	sub    $0x30,%eax
  800f79:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f7c:	eb 42                	jmp    800fc0 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f81:	8a 00                	mov    (%eax),%al
  800f83:	3c 60                	cmp    $0x60,%al
  800f85:	7e 19                	jle    800fa0 <strtol+0xe4>
  800f87:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8a:	8a 00                	mov    (%eax),%al
  800f8c:	3c 7a                	cmp    $0x7a,%al
  800f8e:	7f 10                	jg     800fa0 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f90:	8b 45 08             	mov    0x8(%ebp),%eax
  800f93:	8a 00                	mov    (%eax),%al
  800f95:	0f be c0             	movsbl %al,%eax
  800f98:	83 e8 57             	sub    $0x57,%eax
  800f9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f9e:	eb 20                	jmp    800fc0 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fa0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa3:	8a 00                	mov    (%eax),%al
  800fa5:	3c 40                	cmp    $0x40,%al
  800fa7:	7e 39                	jle    800fe2 <strtol+0x126>
  800fa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fac:	8a 00                	mov    (%eax),%al
  800fae:	3c 5a                	cmp    $0x5a,%al
  800fb0:	7f 30                	jg     800fe2 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb5:	8a 00                	mov    (%eax),%al
  800fb7:	0f be c0             	movsbl %al,%eax
  800fba:	83 e8 37             	sub    $0x37,%eax
  800fbd:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fc3:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fc6:	7d 19                	jge    800fe1 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fc8:	ff 45 08             	incl   0x8(%ebp)
  800fcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fce:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fd2:	89 c2                	mov    %eax,%edx
  800fd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fd7:	01 d0                	add    %edx,%eax
  800fd9:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fdc:	e9 7b ff ff ff       	jmp    800f5c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fe1:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fe2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fe6:	74 08                	je     800ff0 <strtol+0x134>
		*endptr = (char *) s;
  800fe8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800feb:	8b 55 08             	mov    0x8(%ebp),%edx
  800fee:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800ff0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ff4:	74 07                	je     800ffd <strtol+0x141>
  800ff6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff9:	f7 d8                	neg    %eax
  800ffb:	eb 03                	jmp    801000 <strtol+0x144>
  800ffd:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801000:	c9                   	leave  
  801001:	c3                   	ret    

00801002 <ltostr>:

void
ltostr(long value, char *str)
{
  801002:	55                   	push   %ebp
  801003:	89 e5                	mov    %esp,%ebp
  801005:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801008:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80100f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801016:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80101a:	79 13                	jns    80102f <ltostr+0x2d>
	{
		neg = 1;
  80101c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801023:	8b 45 0c             	mov    0xc(%ebp),%eax
  801026:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801029:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80102c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80102f:	8b 45 08             	mov    0x8(%ebp),%eax
  801032:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801037:	99                   	cltd   
  801038:	f7 f9                	idiv   %ecx
  80103a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80103d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801040:	8d 50 01             	lea    0x1(%eax),%edx
  801043:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801046:	89 c2                	mov    %eax,%edx
  801048:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104b:	01 d0                	add    %edx,%eax
  80104d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801050:	83 c2 30             	add    $0x30,%edx
  801053:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801055:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801058:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80105d:	f7 e9                	imul   %ecx
  80105f:	c1 fa 02             	sar    $0x2,%edx
  801062:	89 c8                	mov    %ecx,%eax
  801064:	c1 f8 1f             	sar    $0x1f,%eax
  801067:	29 c2                	sub    %eax,%edx
  801069:	89 d0                	mov    %edx,%eax
  80106b:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80106e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801071:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801076:	f7 e9                	imul   %ecx
  801078:	c1 fa 02             	sar    $0x2,%edx
  80107b:	89 c8                	mov    %ecx,%eax
  80107d:	c1 f8 1f             	sar    $0x1f,%eax
  801080:	29 c2                	sub    %eax,%edx
  801082:	89 d0                	mov    %edx,%eax
  801084:	c1 e0 02             	shl    $0x2,%eax
  801087:	01 d0                	add    %edx,%eax
  801089:	01 c0                	add    %eax,%eax
  80108b:	29 c1                	sub    %eax,%ecx
  80108d:	89 ca                	mov    %ecx,%edx
  80108f:	85 d2                	test   %edx,%edx
  801091:	75 9c                	jne    80102f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801093:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80109a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80109d:	48                   	dec    %eax
  80109e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010a1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010a5:	74 3d                	je     8010e4 <ltostr+0xe2>
		start = 1 ;
  8010a7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010ae:	eb 34                	jmp    8010e4 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b6:	01 d0                	add    %edx,%eax
  8010b8:	8a 00                	mov    (%eax),%al
  8010ba:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010bd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c3:	01 c2                	add    %eax,%edx
  8010c5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010cb:	01 c8                	add    %ecx,%eax
  8010cd:	8a 00                	mov    (%eax),%al
  8010cf:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010d1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d7:	01 c2                	add    %eax,%edx
  8010d9:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010dc:	88 02                	mov    %al,(%edx)
		start++ ;
  8010de:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010e1:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010e7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010ea:	7c c4                	jl     8010b0 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010ec:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f2:	01 d0                	add    %edx,%eax
  8010f4:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010f7:	90                   	nop
  8010f8:	c9                   	leave  
  8010f9:	c3                   	ret    

008010fa <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010fa:	55                   	push   %ebp
  8010fb:	89 e5                	mov    %esp,%ebp
  8010fd:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801100:	ff 75 08             	pushl  0x8(%ebp)
  801103:	e8 54 fa ff ff       	call   800b5c <strlen>
  801108:	83 c4 04             	add    $0x4,%esp
  80110b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80110e:	ff 75 0c             	pushl  0xc(%ebp)
  801111:	e8 46 fa ff ff       	call   800b5c <strlen>
  801116:	83 c4 04             	add    $0x4,%esp
  801119:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80111c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801123:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80112a:	eb 17                	jmp    801143 <strcconcat+0x49>
		final[s] = str1[s] ;
  80112c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80112f:	8b 45 10             	mov    0x10(%ebp),%eax
  801132:	01 c2                	add    %eax,%edx
  801134:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801137:	8b 45 08             	mov    0x8(%ebp),%eax
  80113a:	01 c8                	add    %ecx,%eax
  80113c:	8a 00                	mov    (%eax),%al
  80113e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801140:	ff 45 fc             	incl   -0x4(%ebp)
  801143:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801146:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801149:	7c e1                	jl     80112c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80114b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801152:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801159:	eb 1f                	jmp    80117a <strcconcat+0x80>
		final[s++] = str2[i] ;
  80115b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80115e:	8d 50 01             	lea    0x1(%eax),%edx
  801161:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801164:	89 c2                	mov    %eax,%edx
  801166:	8b 45 10             	mov    0x10(%ebp),%eax
  801169:	01 c2                	add    %eax,%edx
  80116b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80116e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801171:	01 c8                	add    %ecx,%eax
  801173:	8a 00                	mov    (%eax),%al
  801175:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801177:	ff 45 f8             	incl   -0x8(%ebp)
  80117a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80117d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801180:	7c d9                	jl     80115b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801182:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801185:	8b 45 10             	mov    0x10(%ebp),%eax
  801188:	01 d0                	add    %edx,%eax
  80118a:	c6 00 00             	movb   $0x0,(%eax)
}
  80118d:	90                   	nop
  80118e:	c9                   	leave  
  80118f:	c3                   	ret    

00801190 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801190:	55                   	push   %ebp
  801191:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801193:	8b 45 14             	mov    0x14(%ebp),%eax
  801196:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80119c:	8b 45 14             	mov    0x14(%ebp),%eax
  80119f:	8b 00                	mov    (%eax),%eax
  8011a1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ab:	01 d0                	add    %edx,%eax
  8011ad:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011b3:	eb 0c                	jmp    8011c1 <strsplit+0x31>
			*string++ = 0;
  8011b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b8:	8d 50 01             	lea    0x1(%eax),%edx
  8011bb:	89 55 08             	mov    %edx,0x8(%ebp)
  8011be:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c4:	8a 00                	mov    (%eax),%al
  8011c6:	84 c0                	test   %al,%al
  8011c8:	74 18                	je     8011e2 <strsplit+0x52>
  8011ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cd:	8a 00                	mov    (%eax),%al
  8011cf:	0f be c0             	movsbl %al,%eax
  8011d2:	50                   	push   %eax
  8011d3:	ff 75 0c             	pushl  0xc(%ebp)
  8011d6:	e8 13 fb ff ff       	call   800cee <strchr>
  8011db:	83 c4 08             	add    $0x8,%esp
  8011de:	85 c0                	test   %eax,%eax
  8011e0:	75 d3                	jne    8011b5 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8011e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e5:	8a 00                	mov    (%eax),%al
  8011e7:	84 c0                	test   %al,%al
  8011e9:	74 5a                	je     801245 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8011eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ee:	8b 00                	mov    (%eax),%eax
  8011f0:	83 f8 0f             	cmp    $0xf,%eax
  8011f3:	75 07                	jne    8011fc <strsplit+0x6c>
		{
			return 0;
  8011f5:	b8 00 00 00 00       	mov    $0x0,%eax
  8011fa:	eb 66                	jmp    801262 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8011ff:	8b 00                	mov    (%eax),%eax
  801201:	8d 48 01             	lea    0x1(%eax),%ecx
  801204:	8b 55 14             	mov    0x14(%ebp),%edx
  801207:	89 0a                	mov    %ecx,(%edx)
  801209:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801210:	8b 45 10             	mov    0x10(%ebp),%eax
  801213:	01 c2                	add    %eax,%edx
  801215:	8b 45 08             	mov    0x8(%ebp),%eax
  801218:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80121a:	eb 03                	jmp    80121f <strsplit+0x8f>
			string++;
  80121c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80121f:	8b 45 08             	mov    0x8(%ebp),%eax
  801222:	8a 00                	mov    (%eax),%al
  801224:	84 c0                	test   %al,%al
  801226:	74 8b                	je     8011b3 <strsplit+0x23>
  801228:	8b 45 08             	mov    0x8(%ebp),%eax
  80122b:	8a 00                	mov    (%eax),%al
  80122d:	0f be c0             	movsbl %al,%eax
  801230:	50                   	push   %eax
  801231:	ff 75 0c             	pushl  0xc(%ebp)
  801234:	e8 b5 fa ff ff       	call   800cee <strchr>
  801239:	83 c4 08             	add    $0x8,%esp
  80123c:	85 c0                	test   %eax,%eax
  80123e:	74 dc                	je     80121c <strsplit+0x8c>
			string++;
	}
  801240:	e9 6e ff ff ff       	jmp    8011b3 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801245:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801246:	8b 45 14             	mov    0x14(%ebp),%eax
  801249:	8b 00                	mov    (%eax),%eax
  80124b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801252:	8b 45 10             	mov    0x10(%ebp),%eax
  801255:	01 d0                	add    %edx,%eax
  801257:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80125d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801262:	c9                   	leave  
  801263:	c3                   	ret    

00801264 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801264:	55                   	push   %ebp
  801265:	89 e5                	mov    %esp,%ebp
  801267:	57                   	push   %edi
  801268:	56                   	push   %esi
  801269:	53                   	push   %ebx
  80126a:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80126d:	8b 45 08             	mov    0x8(%ebp),%eax
  801270:	8b 55 0c             	mov    0xc(%ebp),%edx
  801273:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801276:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801279:	8b 7d 18             	mov    0x18(%ebp),%edi
  80127c:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80127f:	cd 30                	int    $0x30
  801281:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801284:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801287:	83 c4 10             	add    $0x10,%esp
  80128a:	5b                   	pop    %ebx
  80128b:	5e                   	pop    %esi
  80128c:	5f                   	pop    %edi
  80128d:	5d                   	pop    %ebp
  80128e:	c3                   	ret    

0080128f <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80128f:	55                   	push   %ebp
  801290:	89 e5                	mov    %esp,%ebp
  801292:	83 ec 04             	sub    $0x4,%esp
  801295:	8b 45 10             	mov    0x10(%ebp),%eax
  801298:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80129b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80129f:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a2:	6a 00                	push   $0x0
  8012a4:	6a 00                	push   $0x0
  8012a6:	52                   	push   %edx
  8012a7:	ff 75 0c             	pushl  0xc(%ebp)
  8012aa:	50                   	push   %eax
  8012ab:	6a 00                	push   $0x0
  8012ad:	e8 b2 ff ff ff       	call   801264 <syscall>
  8012b2:	83 c4 18             	add    $0x18,%esp
}
  8012b5:	90                   	nop
  8012b6:	c9                   	leave  
  8012b7:	c3                   	ret    

008012b8 <sys_cgetc>:

int
sys_cgetc(void)
{
  8012b8:	55                   	push   %ebp
  8012b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012bb:	6a 00                	push   $0x0
  8012bd:	6a 00                	push   $0x0
  8012bf:	6a 00                	push   $0x0
  8012c1:	6a 00                	push   $0x0
  8012c3:	6a 00                	push   $0x0
  8012c5:	6a 01                	push   $0x1
  8012c7:	e8 98 ff ff ff       	call   801264 <syscall>
  8012cc:	83 c4 18             	add    $0x18,%esp
}
  8012cf:	c9                   	leave  
  8012d0:	c3                   	ret    

008012d1 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012d1:	55                   	push   %ebp
  8012d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d7:	6a 00                	push   $0x0
  8012d9:	6a 00                	push   $0x0
  8012db:	6a 00                	push   $0x0
  8012dd:	6a 00                	push   $0x0
  8012df:	50                   	push   %eax
  8012e0:	6a 05                	push   $0x5
  8012e2:	e8 7d ff ff ff       	call   801264 <syscall>
  8012e7:	83 c4 18             	add    $0x18,%esp
}
  8012ea:	c9                   	leave  
  8012eb:	c3                   	ret    

008012ec <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012ec:	55                   	push   %ebp
  8012ed:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012ef:	6a 00                	push   $0x0
  8012f1:	6a 00                	push   $0x0
  8012f3:	6a 00                	push   $0x0
  8012f5:	6a 00                	push   $0x0
  8012f7:	6a 00                	push   $0x0
  8012f9:	6a 02                	push   $0x2
  8012fb:	e8 64 ff ff ff       	call   801264 <syscall>
  801300:	83 c4 18             	add    $0x18,%esp
}
  801303:	c9                   	leave  
  801304:	c3                   	ret    

00801305 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801305:	55                   	push   %ebp
  801306:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801308:	6a 00                	push   $0x0
  80130a:	6a 00                	push   $0x0
  80130c:	6a 00                	push   $0x0
  80130e:	6a 00                	push   $0x0
  801310:	6a 00                	push   $0x0
  801312:	6a 03                	push   $0x3
  801314:	e8 4b ff ff ff       	call   801264 <syscall>
  801319:	83 c4 18             	add    $0x18,%esp
}
  80131c:	c9                   	leave  
  80131d:	c3                   	ret    

0080131e <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80131e:	55                   	push   %ebp
  80131f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801321:	6a 00                	push   $0x0
  801323:	6a 00                	push   $0x0
  801325:	6a 00                	push   $0x0
  801327:	6a 00                	push   $0x0
  801329:	6a 00                	push   $0x0
  80132b:	6a 04                	push   $0x4
  80132d:	e8 32 ff ff ff       	call   801264 <syscall>
  801332:	83 c4 18             	add    $0x18,%esp
}
  801335:	c9                   	leave  
  801336:	c3                   	ret    

00801337 <sys_env_exit>:


void sys_env_exit(void)
{
  801337:	55                   	push   %ebp
  801338:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80133a:	6a 00                	push   $0x0
  80133c:	6a 00                	push   $0x0
  80133e:	6a 00                	push   $0x0
  801340:	6a 00                	push   $0x0
  801342:	6a 00                	push   $0x0
  801344:	6a 06                	push   $0x6
  801346:	e8 19 ff ff ff       	call   801264 <syscall>
  80134b:	83 c4 18             	add    $0x18,%esp
}
  80134e:	90                   	nop
  80134f:	c9                   	leave  
  801350:	c3                   	ret    

00801351 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801351:	55                   	push   %ebp
  801352:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801354:	8b 55 0c             	mov    0xc(%ebp),%edx
  801357:	8b 45 08             	mov    0x8(%ebp),%eax
  80135a:	6a 00                	push   $0x0
  80135c:	6a 00                	push   $0x0
  80135e:	6a 00                	push   $0x0
  801360:	52                   	push   %edx
  801361:	50                   	push   %eax
  801362:	6a 07                	push   $0x7
  801364:	e8 fb fe ff ff       	call   801264 <syscall>
  801369:	83 c4 18             	add    $0x18,%esp
}
  80136c:	c9                   	leave  
  80136d:	c3                   	ret    

0080136e <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80136e:	55                   	push   %ebp
  80136f:	89 e5                	mov    %esp,%ebp
  801371:	56                   	push   %esi
  801372:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801373:	8b 75 18             	mov    0x18(%ebp),%esi
  801376:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801379:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80137c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137f:	8b 45 08             	mov    0x8(%ebp),%eax
  801382:	56                   	push   %esi
  801383:	53                   	push   %ebx
  801384:	51                   	push   %ecx
  801385:	52                   	push   %edx
  801386:	50                   	push   %eax
  801387:	6a 08                	push   $0x8
  801389:	e8 d6 fe ff ff       	call   801264 <syscall>
  80138e:	83 c4 18             	add    $0x18,%esp
}
  801391:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801394:	5b                   	pop    %ebx
  801395:	5e                   	pop    %esi
  801396:	5d                   	pop    %ebp
  801397:	c3                   	ret    

00801398 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801398:	55                   	push   %ebp
  801399:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80139b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80139e:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a1:	6a 00                	push   $0x0
  8013a3:	6a 00                	push   $0x0
  8013a5:	6a 00                	push   $0x0
  8013a7:	52                   	push   %edx
  8013a8:	50                   	push   %eax
  8013a9:	6a 09                	push   $0x9
  8013ab:	e8 b4 fe ff ff       	call   801264 <syscall>
  8013b0:	83 c4 18             	add    $0x18,%esp
}
  8013b3:	c9                   	leave  
  8013b4:	c3                   	ret    

008013b5 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013b5:	55                   	push   %ebp
  8013b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013b8:	6a 00                	push   $0x0
  8013ba:	6a 00                	push   $0x0
  8013bc:	6a 00                	push   $0x0
  8013be:	ff 75 0c             	pushl  0xc(%ebp)
  8013c1:	ff 75 08             	pushl  0x8(%ebp)
  8013c4:	6a 0a                	push   $0xa
  8013c6:	e8 99 fe ff ff       	call   801264 <syscall>
  8013cb:	83 c4 18             	add    $0x18,%esp
}
  8013ce:	c9                   	leave  
  8013cf:	c3                   	ret    

008013d0 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013d0:	55                   	push   %ebp
  8013d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013d3:	6a 00                	push   $0x0
  8013d5:	6a 00                	push   $0x0
  8013d7:	6a 00                	push   $0x0
  8013d9:	6a 00                	push   $0x0
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 0b                	push   $0xb
  8013df:	e8 80 fe ff ff       	call   801264 <syscall>
  8013e4:	83 c4 18             	add    $0x18,%esp
}
  8013e7:	c9                   	leave  
  8013e8:	c3                   	ret    

008013e9 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013e9:	55                   	push   %ebp
  8013ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013ec:	6a 00                	push   $0x0
  8013ee:	6a 00                	push   $0x0
  8013f0:	6a 00                	push   $0x0
  8013f2:	6a 00                	push   $0x0
  8013f4:	6a 00                	push   $0x0
  8013f6:	6a 0c                	push   $0xc
  8013f8:	e8 67 fe ff ff       	call   801264 <syscall>
  8013fd:	83 c4 18             	add    $0x18,%esp
}
  801400:	c9                   	leave  
  801401:	c3                   	ret    

00801402 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801402:	55                   	push   %ebp
  801403:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801405:	6a 00                	push   $0x0
  801407:	6a 00                	push   $0x0
  801409:	6a 00                	push   $0x0
  80140b:	6a 00                	push   $0x0
  80140d:	6a 00                	push   $0x0
  80140f:	6a 0d                	push   $0xd
  801411:	e8 4e fe ff ff       	call   801264 <syscall>
  801416:	83 c4 18             	add    $0x18,%esp
}
  801419:	c9                   	leave  
  80141a:	c3                   	ret    

0080141b <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80141b:	55                   	push   %ebp
  80141c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	6a 00                	push   $0x0
  801424:	ff 75 0c             	pushl  0xc(%ebp)
  801427:	ff 75 08             	pushl  0x8(%ebp)
  80142a:	6a 11                	push   $0x11
  80142c:	e8 33 fe ff ff       	call   801264 <syscall>
  801431:	83 c4 18             	add    $0x18,%esp
	return;
  801434:	90                   	nop
}
  801435:	c9                   	leave  
  801436:	c3                   	ret    

00801437 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801437:	55                   	push   %ebp
  801438:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80143a:	6a 00                	push   $0x0
  80143c:	6a 00                	push   $0x0
  80143e:	6a 00                	push   $0x0
  801440:	ff 75 0c             	pushl  0xc(%ebp)
  801443:	ff 75 08             	pushl  0x8(%ebp)
  801446:	6a 12                	push   $0x12
  801448:	e8 17 fe ff ff       	call   801264 <syscall>
  80144d:	83 c4 18             	add    $0x18,%esp
	return ;
  801450:	90                   	nop
}
  801451:	c9                   	leave  
  801452:	c3                   	ret    

00801453 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801453:	55                   	push   %ebp
  801454:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801456:	6a 00                	push   $0x0
  801458:	6a 00                	push   $0x0
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	6a 0e                	push   $0xe
  801462:	e8 fd fd ff ff       	call   801264 <syscall>
  801467:	83 c4 18             	add    $0x18,%esp
}
  80146a:	c9                   	leave  
  80146b:	c3                   	ret    

0080146c <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80146c:	55                   	push   %ebp
  80146d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80146f:	6a 00                	push   $0x0
  801471:	6a 00                	push   $0x0
  801473:	6a 00                	push   $0x0
  801475:	6a 00                	push   $0x0
  801477:	ff 75 08             	pushl  0x8(%ebp)
  80147a:	6a 0f                	push   $0xf
  80147c:	e8 e3 fd ff ff       	call   801264 <syscall>
  801481:	83 c4 18             	add    $0x18,%esp
}
  801484:	c9                   	leave  
  801485:	c3                   	ret    

00801486 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801486:	55                   	push   %ebp
  801487:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801489:	6a 00                	push   $0x0
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	6a 10                	push   $0x10
  801495:	e8 ca fd ff ff       	call   801264 <syscall>
  80149a:	83 c4 18             	add    $0x18,%esp
}
  80149d:	90                   	nop
  80149e:	c9                   	leave  
  80149f:	c3                   	ret    

008014a0 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014a0:	55                   	push   %ebp
  8014a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014a3:	6a 00                	push   $0x0
  8014a5:	6a 00                	push   $0x0
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 14                	push   $0x14
  8014af:	e8 b0 fd ff ff       	call   801264 <syscall>
  8014b4:	83 c4 18             	add    $0x18,%esp
}
  8014b7:	90                   	nop
  8014b8:	c9                   	leave  
  8014b9:	c3                   	ret    

008014ba <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014ba:	55                   	push   %ebp
  8014bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 00                	push   $0x0
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 15                	push   $0x15
  8014c9:	e8 96 fd ff ff       	call   801264 <syscall>
  8014ce:	83 c4 18             	add    $0x18,%esp
}
  8014d1:	90                   	nop
  8014d2:	c9                   	leave  
  8014d3:	c3                   	ret    

008014d4 <sys_cputc>:


void
sys_cputc(const char c)
{
  8014d4:	55                   	push   %ebp
  8014d5:	89 e5                	mov    %esp,%ebp
  8014d7:	83 ec 04             	sub    $0x4,%esp
  8014da:	8b 45 08             	mov    0x8(%ebp),%eax
  8014dd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014e0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	50                   	push   %eax
  8014ed:	6a 16                	push   $0x16
  8014ef:	e8 70 fd ff ff       	call   801264 <syscall>
  8014f4:	83 c4 18             	add    $0x18,%esp
}
  8014f7:	90                   	nop
  8014f8:	c9                   	leave  
  8014f9:	c3                   	ret    

008014fa <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014fa:	55                   	push   %ebp
  8014fb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	6a 00                	push   $0x0
  801503:	6a 00                	push   $0x0
  801505:	6a 00                	push   $0x0
  801507:	6a 17                	push   $0x17
  801509:	e8 56 fd ff ff       	call   801264 <syscall>
  80150e:	83 c4 18             	add    $0x18,%esp
}
  801511:	90                   	nop
  801512:	c9                   	leave  
  801513:	c3                   	ret    

00801514 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801514:	55                   	push   %ebp
  801515:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801517:	8b 45 08             	mov    0x8(%ebp),%eax
  80151a:	6a 00                	push   $0x0
  80151c:	6a 00                	push   $0x0
  80151e:	6a 00                	push   $0x0
  801520:	ff 75 0c             	pushl  0xc(%ebp)
  801523:	50                   	push   %eax
  801524:	6a 18                	push   $0x18
  801526:	e8 39 fd ff ff       	call   801264 <syscall>
  80152b:	83 c4 18             	add    $0x18,%esp
}
  80152e:	c9                   	leave  
  80152f:	c3                   	ret    

00801530 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801530:	55                   	push   %ebp
  801531:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801533:	8b 55 0c             	mov    0xc(%ebp),%edx
  801536:	8b 45 08             	mov    0x8(%ebp),%eax
  801539:	6a 00                	push   $0x0
  80153b:	6a 00                	push   $0x0
  80153d:	6a 00                	push   $0x0
  80153f:	52                   	push   %edx
  801540:	50                   	push   %eax
  801541:	6a 1b                	push   $0x1b
  801543:	e8 1c fd ff ff       	call   801264 <syscall>
  801548:	83 c4 18             	add    $0x18,%esp
}
  80154b:	c9                   	leave  
  80154c:	c3                   	ret    

0080154d <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80154d:	55                   	push   %ebp
  80154e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801550:	8b 55 0c             	mov    0xc(%ebp),%edx
  801553:	8b 45 08             	mov    0x8(%ebp),%eax
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	52                   	push   %edx
  80155d:	50                   	push   %eax
  80155e:	6a 19                	push   $0x19
  801560:	e8 ff fc ff ff       	call   801264 <syscall>
  801565:	83 c4 18             	add    $0x18,%esp
}
  801568:	90                   	nop
  801569:	c9                   	leave  
  80156a:	c3                   	ret    

0080156b <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80156b:	55                   	push   %ebp
  80156c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80156e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801571:	8b 45 08             	mov    0x8(%ebp),%eax
  801574:	6a 00                	push   $0x0
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	52                   	push   %edx
  80157b:	50                   	push   %eax
  80157c:	6a 1a                	push   $0x1a
  80157e:	e8 e1 fc ff ff       	call   801264 <syscall>
  801583:	83 c4 18             	add    $0x18,%esp
}
  801586:	90                   	nop
  801587:	c9                   	leave  
  801588:	c3                   	ret    

00801589 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801589:	55                   	push   %ebp
  80158a:	89 e5                	mov    %esp,%ebp
  80158c:	83 ec 04             	sub    $0x4,%esp
  80158f:	8b 45 10             	mov    0x10(%ebp),%eax
  801592:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801595:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801598:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80159c:	8b 45 08             	mov    0x8(%ebp),%eax
  80159f:	6a 00                	push   $0x0
  8015a1:	51                   	push   %ecx
  8015a2:	52                   	push   %edx
  8015a3:	ff 75 0c             	pushl  0xc(%ebp)
  8015a6:	50                   	push   %eax
  8015a7:	6a 1c                	push   $0x1c
  8015a9:	e8 b6 fc ff ff       	call   801264 <syscall>
  8015ae:	83 c4 18             	add    $0x18,%esp
}
  8015b1:	c9                   	leave  
  8015b2:	c3                   	ret    

008015b3 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015b3:	55                   	push   %ebp
  8015b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bc:	6a 00                	push   $0x0
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 00                	push   $0x0
  8015c2:	52                   	push   %edx
  8015c3:	50                   	push   %eax
  8015c4:	6a 1d                	push   $0x1d
  8015c6:	e8 99 fc ff ff       	call   801264 <syscall>
  8015cb:	83 c4 18             	add    $0x18,%esp
}
  8015ce:	c9                   	leave  
  8015cf:	c3                   	ret    

008015d0 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015d0:	55                   	push   %ebp
  8015d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015d3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	51                   	push   %ecx
  8015e1:	52                   	push   %edx
  8015e2:	50                   	push   %eax
  8015e3:	6a 1e                	push   $0x1e
  8015e5:	e8 7a fc ff ff       	call   801264 <syscall>
  8015ea:	83 c4 18             	add    $0x18,%esp
}
  8015ed:	c9                   	leave  
  8015ee:	c3                   	ret    

008015ef <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015ef:	55                   	push   %ebp
  8015f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	52                   	push   %edx
  8015ff:	50                   	push   %eax
  801600:	6a 1f                	push   $0x1f
  801602:	e8 5d fc ff ff       	call   801264 <syscall>
  801607:	83 c4 18             	add    $0x18,%esp
}
  80160a:	c9                   	leave  
  80160b:	c3                   	ret    

0080160c <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80160c:	55                   	push   %ebp
  80160d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	6a 20                	push   $0x20
  80161b:	e8 44 fc ff ff       	call   801264 <syscall>
  801620:	83 c4 18             	add    $0x18,%esp
}
  801623:	c9                   	leave  
  801624:	c3                   	ret    

00801625 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801625:	55                   	push   %ebp
  801626:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801628:	8b 45 08             	mov    0x8(%ebp),%eax
  80162b:	6a 00                	push   $0x0
  80162d:	ff 75 14             	pushl  0x14(%ebp)
  801630:	ff 75 10             	pushl  0x10(%ebp)
  801633:	ff 75 0c             	pushl  0xc(%ebp)
  801636:	50                   	push   %eax
  801637:	6a 21                	push   $0x21
  801639:	e8 26 fc ff ff       	call   801264 <syscall>
  80163e:	83 c4 18             	add    $0x18,%esp
}
  801641:	c9                   	leave  
  801642:	c3                   	ret    

00801643 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801643:	55                   	push   %ebp
  801644:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801646:	8b 45 08             	mov    0x8(%ebp),%eax
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	50                   	push   %eax
  801652:	6a 22                	push   $0x22
  801654:	e8 0b fc ff ff       	call   801264 <syscall>
  801659:	83 c4 18             	add    $0x18,%esp
}
  80165c:	90                   	nop
  80165d:	c9                   	leave  
  80165e:	c3                   	ret    

0080165f <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80165f:	55                   	push   %ebp
  801660:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801662:	8b 45 08             	mov    0x8(%ebp),%eax
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	50                   	push   %eax
  80166e:	6a 23                	push   $0x23
  801670:	e8 ef fb ff ff       	call   801264 <syscall>
  801675:	83 c4 18             	add    $0x18,%esp
}
  801678:	90                   	nop
  801679:	c9                   	leave  
  80167a:	c3                   	ret    

0080167b <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80167b:	55                   	push   %ebp
  80167c:	89 e5                	mov    %esp,%ebp
  80167e:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801681:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801684:	8d 50 04             	lea    0x4(%eax),%edx
  801687:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80168a:	6a 00                	push   $0x0
  80168c:	6a 00                	push   $0x0
  80168e:	6a 00                	push   $0x0
  801690:	52                   	push   %edx
  801691:	50                   	push   %eax
  801692:	6a 24                	push   $0x24
  801694:	e8 cb fb ff ff       	call   801264 <syscall>
  801699:	83 c4 18             	add    $0x18,%esp
	return result;
  80169c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80169f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016a2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016a5:	89 01                	mov    %eax,(%ecx)
  8016a7:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ad:	c9                   	leave  
  8016ae:	c2 04 00             	ret    $0x4

008016b1 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016b1:	55                   	push   %ebp
  8016b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016b4:	6a 00                	push   $0x0
  8016b6:	6a 00                	push   $0x0
  8016b8:	ff 75 10             	pushl  0x10(%ebp)
  8016bb:	ff 75 0c             	pushl  0xc(%ebp)
  8016be:	ff 75 08             	pushl  0x8(%ebp)
  8016c1:	6a 13                	push   $0x13
  8016c3:	e8 9c fb ff ff       	call   801264 <syscall>
  8016c8:	83 c4 18             	add    $0x18,%esp
	return ;
  8016cb:	90                   	nop
}
  8016cc:	c9                   	leave  
  8016cd:	c3                   	ret    

008016ce <sys_rcr2>:
uint32 sys_rcr2()
{
  8016ce:	55                   	push   %ebp
  8016cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016d1:	6a 00                	push   $0x0
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 25                	push   $0x25
  8016dd:	e8 82 fb ff ff       	call   801264 <syscall>
  8016e2:	83 c4 18             	add    $0x18,%esp
}
  8016e5:	c9                   	leave  
  8016e6:	c3                   	ret    

008016e7 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016e7:	55                   	push   %ebp
  8016e8:	89 e5                	mov    %esp,%ebp
  8016ea:	83 ec 04             	sub    $0x4,%esp
  8016ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016f3:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 00                	push   $0x0
  8016ff:	50                   	push   %eax
  801700:	6a 26                	push   $0x26
  801702:	e8 5d fb ff ff       	call   801264 <syscall>
  801707:	83 c4 18             	add    $0x18,%esp
	return ;
  80170a:	90                   	nop
}
  80170b:	c9                   	leave  
  80170c:	c3                   	ret    

0080170d <rsttst>:
void rsttst()
{
  80170d:	55                   	push   %ebp
  80170e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	6a 00                	push   $0x0
  801716:	6a 00                	push   $0x0
  801718:	6a 00                	push   $0x0
  80171a:	6a 28                	push   $0x28
  80171c:	e8 43 fb ff ff       	call   801264 <syscall>
  801721:	83 c4 18             	add    $0x18,%esp
	return ;
  801724:	90                   	nop
}
  801725:	c9                   	leave  
  801726:	c3                   	ret    

00801727 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801727:	55                   	push   %ebp
  801728:	89 e5                	mov    %esp,%ebp
  80172a:	83 ec 04             	sub    $0x4,%esp
  80172d:	8b 45 14             	mov    0x14(%ebp),%eax
  801730:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801733:	8b 55 18             	mov    0x18(%ebp),%edx
  801736:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80173a:	52                   	push   %edx
  80173b:	50                   	push   %eax
  80173c:	ff 75 10             	pushl  0x10(%ebp)
  80173f:	ff 75 0c             	pushl  0xc(%ebp)
  801742:	ff 75 08             	pushl  0x8(%ebp)
  801745:	6a 27                	push   $0x27
  801747:	e8 18 fb ff ff       	call   801264 <syscall>
  80174c:	83 c4 18             	add    $0x18,%esp
	return ;
  80174f:	90                   	nop
}
  801750:	c9                   	leave  
  801751:	c3                   	ret    

00801752 <chktst>:
void chktst(uint32 n)
{
  801752:	55                   	push   %ebp
  801753:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801755:	6a 00                	push   $0x0
  801757:	6a 00                	push   $0x0
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	ff 75 08             	pushl  0x8(%ebp)
  801760:	6a 29                	push   $0x29
  801762:	e8 fd fa ff ff       	call   801264 <syscall>
  801767:	83 c4 18             	add    $0x18,%esp
	return ;
  80176a:	90                   	nop
}
  80176b:	c9                   	leave  
  80176c:	c3                   	ret    

0080176d <inctst>:

void inctst()
{
  80176d:	55                   	push   %ebp
  80176e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801770:	6a 00                	push   $0x0
  801772:	6a 00                	push   $0x0
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	6a 2a                	push   $0x2a
  80177c:	e8 e3 fa ff ff       	call   801264 <syscall>
  801781:	83 c4 18             	add    $0x18,%esp
	return ;
  801784:	90                   	nop
}
  801785:	c9                   	leave  
  801786:	c3                   	ret    

00801787 <gettst>:
uint32 gettst()
{
  801787:	55                   	push   %ebp
  801788:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 2b                	push   $0x2b
  801796:	e8 c9 fa ff ff       	call   801264 <syscall>
  80179b:	83 c4 18             	add    $0x18,%esp
}
  80179e:	c9                   	leave  
  80179f:	c3                   	ret    

008017a0 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017a0:	55                   	push   %ebp
  8017a1:	89 e5                	mov    %esp,%ebp
  8017a3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 2c                	push   $0x2c
  8017b2:	e8 ad fa ff ff       	call   801264 <syscall>
  8017b7:	83 c4 18             	add    $0x18,%esp
  8017ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017bd:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017c1:	75 07                	jne    8017ca <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017c3:	b8 01 00 00 00       	mov    $0x1,%eax
  8017c8:	eb 05                	jmp    8017cf <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017ca:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017cf:	c9                   	leave  
  8017d0:	c3                   	ret    

008017d1 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017d1:	55                   	push   %ebp
  8017d2:	89 e5                	mov    %esp,%ebp
  8017d4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 2c                	push   $0x2c
  8017e3:	e8 7c fa ff ff       	call   801264 <syscall>
  8017e8:	83 c4 18             	add    $0x18,%esp
  8017eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017ee:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017f2:	75 07                	jne    8017fb <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017f4:	b8 01 00 00 00       	mov    $0x1,%eax
  8017f9:	eb 05                	jmp    801800 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801800:	c9                   	leave  
  801801:	c3                   	ret    

00801802 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801802:	55                   	push   %ebp
  801803:	89 e5                	mov    %esp,%ebp
  801805:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801808:	6a 00                	push   $0x0
  80180a:	6a 00                	push   $0x0
  80180c:	6a 00                	push   $0x0
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	6a 2c                	push   $0x2c
  801814:	e8 4b fa ff ff       	call   801264 <syscall>
  801819:	83 c4 18             	add    $0x18,%esp
  80181c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80181f:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801823:	75 07                	jne    80182c <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801825:	b8 01 00 00 00       	mov    $0x1,%eax
  80182a:	eb 05                	jmp    801831 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80182c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801831:	c9                   	leave  
  801832:	c3                   	ret    

00801833 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801833:	55                   	push   %ebp
  801834:	89 e5                	mov    %esp,%ebp
  801836:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 2c                	push   $0x2c
  801845:	e8 1a fa ff ff       	call   801264 <syscall>
  80184a:	83 c4 18             	add    $0x18,%esp
  80184d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801850:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801854:	75 07                	jne    80185d <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801856:	b8 01 00 00 00       	mov    $0x1,%eax
  80185b:	eb 05                	jmp    801862 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80185d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801862:	c9                   	leave  
  801863:	c3                   	ret    

00801864 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801864:	55                   	push   %ebp
  801865:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801867:	6a 00                	push   $0x0
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	6a 00                	push   $0x0
  80186f:	ff 75 08             	pushl  0x8(%ebp)
  801872:	6a 2d                	push   $0x2d
  801874:	e8 eb f9 ff ff       	call   801264 <syscall>
  801879:	83 c4 18             	add    $0x18,%esp
	return ;
  80187c:	90                   	nop
}
  80187d:	c9                   	leave  
  80187e:	c3                   	ret    

0080187f <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80187f:	55                   	push   %ebp
  801880:	89 e5                	mov    %esp,%ebp
  801882:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801883:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801886:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801889:	8b 55 0c             	mov    0xc(%ebp),%edx
  80188c:	8b 45 08             	mov    0x8(%ebp),%eax
  80188f:	6a 00                	push   $0x0
  801891:	53                   	push   %ebx
  801892:	51                   	push   %ecx
  801893:	52                   	push   %edx
  801894:	50                   	push   %eax
  801895:	6a 2e                	push   $0x2e
  801897:	e8 c8 f9 ff ff       	call   801264 <syscall>
  80189c:	83 c4 18             	add    $0x18,%esp
}
  80189f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8018a2:	c9                   	leave  
  8018a3:	c3                   	ret    

008018a4 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8018a4:	55                   	push   %ebp
  8018a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8018a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 00                	push   $0x0
  8018b1:	6a 00                	push   $0x0
  8018b3:	52                   	push   %edx
  8018b4:	50                   	push   %eax
  8018b5:	6a 2f                	push   $0x2f
  8018b7:	e8 a8 f9 ff ff       	call   801264 <syscall>
  8018bc:	83 c4 18             	add    $0x18,%esp
}
  8018bf:	c9                   	leave  
  8018c0:	c3                   	ret    

008018c1 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8018c1:	55                   	push   %ebp
  8018c2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 00                	push   $0x0
  8018c8:	6a 00                	push   $0x0
  8018ca:	ff 75 0c             	pushl  0xc(%ebp)
  8018cd:	ff 75 08             	pushl  0x8(%ebp)
  8018d0:	6a 30                	push   $0x30
  8018d2:	e8 8d f9 ff ff       	call   801264 <syscall>
  8018d7:	83 c4 18             	add    $0x18,%esp
	return ;
  8018da:	90                   	nop
}
  8018db:	c9                   	leave  
  8018dc:	c3                   	ret    

008018dd <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8018dd:	55                   	push   %ebp
  8018de:	89 e5                	mov    %esp,%ebp
  8018e0:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8018e3:	8b 55 08             	mov    0x8(%ebp),%edx
  8018e6:	89 d0                	mov    %edx,%eax
  8018e8:	c1 e0 02             	shl    $0x2,%eax
  8018eb:	01 d0                	add    %edx,%eax
  8018ed:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018f4:	01 d0                	add    %edx,%eax
  8018f6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018fd:	01 d0                	add    %edx,%eax
  8018ff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801906:	01 d0                	add    %edx,%eax
  801908:	c1 e0 04             	shl    $0x4,%eax
  80190b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  80190e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801915:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801918:	83 ec 0c             	sub    $0xc,%esp
  80191b:	50                   	push   %eax
  80191c:	e8 5a fd ff ff       	call   80167b <sys_get_virtual_time>
  801921:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801924:	eb 41                	jmp    801967 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801926:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801929:	83 ec 0c             	sub    $0xc,%esp
  80192c:	50                   	push   %eax
  80192d:	e8 49 fd ff ff       	call   80167b <sys_get_virtual_time>
  801932:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801935:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801938:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80193b:	29 c2                	sub    %eax,%edx
  80193d:	89 d0                	mov    %edx,%eax
  80193f:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801942:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801945:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801948:	89 d1                	mov    %edx,%ecx
  80194a:	29 c1                	sub    %eax,%ecx
  80194c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80194f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801952:	39 c2                	cmp    %eax,%edx
  801954:	0f 97 c0             	seta   %al
  801957:	0f b6 c0             	movzbl %al,%eax
  80195a:	29 c1                	sub    %eax,%ecx
  80195c:	89 c8                	mov    %ecx,%eax
  80195e:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801961:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801964:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801967:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80196a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80196d:	72 b7                	jb     801926 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  80196f:	90                   	nop
  801970:	c9                   	leave  
  801971:	c3                   	ret    

00801972 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801972:	55                   	push   %ebp
  801973:	89 e5                	mov    %esp,%ebp
  801975:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801978:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  80197f:	eb 03                	jmp    801984 <busy_wait+0x12>
  801981:	ff 45 fc             	incl   -0x4(%ebp)
  801984:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801987:	3b 45 08             	cmp    0x8(%ebp),%eax
  80198a:	72 f5                	jb     801981 <busy_wait+0xf>
	return i;
  80198c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80198f:	c9                   	leave  
  801990:	c3                   	ret    

00801991 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  801991:	55                   	push   %ebp
  801992:	89 e5                	mov    %esp,%ebp
  801994:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  801997:	8b 45 08             	mov    0x8(%ebp),%eax
  80199a:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80199d:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8019a1:	83 ec 0c             	sub    $0xc,%esp
  8019a4:	50                   	push   %eax
  8019a5:	e8 2a fb ff ff       	call   8014d4 <sys_cputc>
  8019aa:	83 c4 10             	add    $0x10,%esp
}
  8019ad:	90                   	nop
  8019ae:	c9                   	leave  
  8019af:	c3                   	ret    

008019b0 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8019b0:	55                   	push   %ebp
  8019b1:	89 e5                	mov    %esp,%ebp
  8019b3:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8019b6:	e8 e5 fa ff ff       	call   8014a0 <sys_disable_interrupt>
	char c = ch;
  8019bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019be:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8019c1:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8019c5:	83 ec 0c             	sub    $0xc,%esp
  8019c8:	50                   	push   %eax
  8019c9:	e8 06 fb ff ff       	call   8014d4 <sys_cputc>
  8019ce:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8019d1:	e8 e4 fa ff ff       	call   8014ba <sys_enable_interrupt>
}
  8019d6:	90                   	nop
  8019d7:	c9                   	leave  
  8019d8:	c3                   	ret    

008019d9 <getchar>:

int
getchar(void)
{
  8019d9:	55                   	push   %ebp
  8019da:	89 e5                	mov    %esp,%ebp
  8019dc:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8019df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8019e6:	eb 08                	jmp    8019f0 <getchar+0x17>
	{
		c = sys_cgetc();
  8019e8:	e8 cb f8 ff ff       	call   8012b8 <sys_cgetc>
  8019ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8019f0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8019f4:	74 f2                	je     8019e8 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8019f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8019f9:	c9                   	leave  
  8019fa:	c3                   	ret    

008019fb <atomic_getchar>:

int
atomic_getchar(void)
{
  8019fb:	55                   	push   %ebp
  8019fc:	89 e5                	mov    %esp,%ebp
  8019fe:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801a01:	e8 9a fa ff ff       	call   8014a0 <sys_disable_interrupt>
	int c=0;
  801a06:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801a0d:	eb 08                	jmp    801a17 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  801a0f:	e8 a4 f8 ff ff       	call   8012b8 <sys_cgetc>
  801a14:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  801a17:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801a1b:	74 f2                	je     801a0f <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  801a1d:	e8 98 fa ff ff       	call   8014ba <sys_enable_interrupt>
	return c;
  801a22:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801a25:	c9                   	leave  
  801a26:	c3                   	ret    

00801a27 <iscons>:

int iscons(int fdnum)
{
  801a27:	55                   	push   %ebp
  801a28:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  801a2a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a2f:	5d                   	pop    %ebp
  801a30:	c3                   	ret    
  801a31:	66 90                	xchg   %ax,%ax
  801a33:	90                   	nop

00801a34 <__udivdi3>:
  801a34:	55                   	push   %ebp
  801a35:	57                   	push   %edi
  801a36:	56                   	push   %esi
  801a37:	53                   	push   %ebx
  801a38:	83 ec 1c             	sub    $0x1c,%esp
  801a3b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a3f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a47:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a4b:	89 ca                	mov    %ecx,%edx
  801a4d:	89 f8                	mov    %edi,%eax
  801a4f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a53:	85 f6                	test   %esi,%esi
  801a55:	75 2d                	jne    801a84 <__udivdi3+0x50>
  801a57:	39 cf                	cmp    %ecx,%edi
  801a59:	77 65                	ja     801ac0 <__udivdi3+0x8c>
  801a5b:	89 fd                	mov    %edi,%ebp
  801a5d:	85 ff                	test   %edi,%edi
  801a5f:	75 0b                	jne    801a6c <__udivdi3+0x38>
  801a61:	b8 01 00 00 00       	mov    $0x1,%eax
  801a66:	31 d2                	xor    %edx,%edx
  801a68:	f7 f7                	div    %edi
  801a6a:	89 c5                	mov    %eax,%ebp
  801a6c:	31 d2                	xor    %edx,%edx
  801a6e:	89 c8                	mov    %ecx,%eax
  801a70:	f7 f5                	div    %ebp
  801a72:	89 c1                	mov    %eax,%ecx
  801a74:	89 d8                	mov    %ebx,%eax
  801a76:	f7 f5                	div    %ebp
  801a78:	89 cf                	mov    %ecx,%edi
  801a7a:	89 fa                	mov    %edi,%edx
  801a7c:	83 c4 1c             	add    $0x1c,%esp
  801a7f:	5b                   	pop    %ebx
  801a80:	5e                   	pop    %esi
  801a81:	5f                   	pop    %edi
  801a82:	5d                   	pop    %ebp
  801a83:	c3                   	ret    
  801a84:	39 ce                	cmp    %ecx,%esi
  801a86:	77 28                	ja     801ab0 <__udivdi3+0x7c>
  801a88:	0f bd fe             	bsr    %esi,%edi
  801a8b:	83 f7 1f             	xor    $0x1f,%edi
  801a8e:	75 40                	jne    801ad0 <__udivdi3+0x9c>
  801a90:	39 ce                	cmp    %ecx,%esi
  801a92:	72 0a                	jb     801a9e <__udivdi3+0x6a>
  801a94:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a98:	0f 87 9e 00 00 00    	ja     801b3c <__udivdi3+0x108>
  801a9e:	b8 01 00 00 00       	mov    $0x1,%eax
  801aa3:	89 fa                	mov    %edi,%edx
  801aa5:	83 c4 1c             	add    $0x1c,%esp
  801aa8:	5b                   	pop    %ebx
  801aa9:	5e                   	pop    %esi
  801aaa:	5f                   	pop    %edi
  801aab:	5d                   	pop    %ebp
  801aac:	c3                   	ret    
  801aad:	8d 76 00             	lea    0x0(%esi),%esi
  801ab0:	31 ff                	xor    %edi,%edi
  801ab2:	31 c0                	xor    %eax,%eax
  801ab4:	89 fa                	mov    %edi,%edx
  801ab6:	83 c4 1c             	add    $0x1c,%esp
  801ab9:	5b                   	pop    %ebx
  801aba:	5e                   	pop    %esi
  801abb:	5f                   	pop    %edi
  801abc:	5d                   	pop    %ebp
  801abd:	c3                   	ret    
  801abe:	66 90                	xchg   %ax,%ax
  801ac0:	89 d8                	mov    %ebx,%eax
  801ac2:	f7 f7                	div    %edi
  801ac4:	31 ff                	xor    %edi,%edi
  801ac6:	89 fa                	mov    %edi,%edx
  801ac8:	83 c4 1c             	add    $0x1c,%esp
  801acb:	5b                   	pop    %ebx
  801acc:	5e                   	pop    %esi
  801acd:	5f                   	pop    %edi
  801ace:	5d                   	pop    %ebp
  801acf:	c3                   	ret    
  801ad0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ad5:	89 eb                	mov    %ebp,%ebx
  801ad7:	29 fb                	sub    %edi,%ebx
  801ad9:	89 f9                	mov    %edi,%ecx
  801adb:	d3 e6                	shl    %cl,%esi
  801add:	89 c5                	mov    %eax,%ebp
  801adf:	88 d9                	mov    %bl,%cl
  801ae1:	d3 ed                	shr    %cl,%ebp
  801ae3:	89 e9                	mov    %ebp,%ecx
  801ae5:	09 f1                	or     %esi,%ecx
  801ae7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801aeb:	89 f9                	mov    %edi,%ecx
  801aed:	d3 e0                	shl    %cl,%eax
  801aef:	89 c5                	mov    %eax,%ebp
  801af1:	89 d6                	mov    %edx,%esi
  801af3:	88 d9                	mov    %bl,%cl
  801af5:	d3 ee                	shr    %cl,%esi
  801af7:	89 f9                	mov    %edi,%ecx
  801af9:	d3 e2                	shl    %cl,%edx
  801afb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801aff:	88 d9                	mov    %bl,%cl
  801b01:	d3 e8                	shr    %cl,%eax
  801b03:	09 c2                	or     %eax,%edx
  801b05:	89 d0                	mov    %edx,%eax
  801b07:	89 f2                	mov    %esi,%edx
  801b09:	f7 74 24 0c          	divl   0xc(%esp)
  801b0d:	89 d6                	mov    %edx,%esi
  801b0f:	89 c3                	mov    %eax,%ebx
  801b11:	f7 e5                	mul    %ebp
  801b13:	39 d6                	cmp    %edx,%esi
  801b15:	72 19                	jb     801b30 <__udivdi3+0xfc>
  801b17:	74 0b                	je     801b24 <__udivdi3+0xf0>
  801b19:	89 d8                	mov    %ebx,%eax
  801b1b:	31 ff                	xor    %edi,%edi
  801b1d:	e9 58 ff ff ff       	jmp    801a7a <__udivdi3+0x46>
  801b22:	66 90                	xchg   %ax,%ax
  801b24:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b28:	89 f9                	mov    %edi,%ecx
  801b2a:	d3 e2                	shl    %cl,%edx
  801b2c:	39 c2                	cmp    %eax,%edx
  801b2e:	73 e9                	jae    801b19 <__udivdi3+0xe5>
  801b30:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b33:	31 ff                	xor    %edi,%edi
  801b35:	e9 40 ff ff ff       	jmp    801a7a <__udivdi3+0x46>
  801b3a:	66 90                	xchg   %ax,%ax
  801b3c:	31 c0                	xor    %eax,%eax
  801b3e:	e9 37 ff ff ff       	jmp    801a7a <__udivdi3+0x46>
  801b43:	90                   	nop

00801b44 <__umoddi3>:
  801b44:	55                   	push   %ebp
  801b45:	57                   	push   %edi
  801b46:	56                   	push   %esi
  801b47:	53                   	push   %ebx
  801b48:	83 ec 1c             	sub    $0x1c,%esp
  801b4b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b4f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b53:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b57:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b5b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b5f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b63:	89 f3                	mov    %esi,%ebx
  801b65:	89 fa                	mov    %edi,%edx
  801b67:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b6b:	89 34 24             	mov    %esi,(%esp)
  801b6e:	85 c0                	test   %eax,%eax
  801b70:	75 1a                	jne    801b8c <__umoddi3+0x48>
  801b72:	39 f7                	cmp    %esi,%edi
  801b74:	0f 86 a2 00 00 00    	jbe    801c1c <__umoddi3+0xd8>
  801b7a:	89 c8                	mov    %ecx,%eax
  801b7c:	89 f2                	mov    %esi,%edx
  801b7e:	f7 f7                	div    %edi
  801b80:	89 d0                	mov    %edx,%eax
  801b82:	31 d2                	xor    %edx,%edx
  801b84:	83 c4 1c             	add    $0x1c,%esp
  801b87:	5b                   	pop    %ebx
  801b88:	5e                   	pop    %esi
  801b89:	5f                   	pop    %edi
  801b8a:	5d                   	pop    %ebp
  801b8b:	c3                   	ret    
  801b8c:	39 f0                	cmp    %esi,%eax
  801b8e:	0f 87 ac 00 00 00    	ja     801c40 <__umoddi3+0xfc>
  801b94:	0f bd e8             	bsr    %eax,%ebp
  801b97:	83 f5 1f             	xor    $0x1f,%ebp
  801b9a:	0f 84 ac 00 00 00    	je     801c4c <__umoddi3+0x108>
  801ba0:	bf 20 00 00 00       	mov    $0x20,%edi
  801ba5:	29 ef                	sub    %ebp,%edi
  801ba7:	89 fe                	mov    %edi,%esi
  801ba9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801bad:	89 e9                	mov    %ebp,%ecx
  801baf:	d3 e0                	shl    %cl,%eax
  801bb1:	89 d7                	mov    %edx,%edi
  801bb3:	89 f1                	mov    %esi,%ecx
  801bb5:	d3 ef                	shr    %cl,%edi
  801bb7:	09 c7                	or     %eax,%edi
  801bb9:	89 e9                	mov    %ebp,%ecx
  801bbb:	d3 e2                	shl    %cl,%edx
  801bbd:	89 14 24             	mov    %edx,(%esp)
  801bc0:	89 d8                	mov    %ebx,%eax
  801bc2:	d3 e0                	shl    %cl,%eax
  801bc4:	89 c2                	mov    %eax,%edx
  801bc6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bca:	d3 e0                	shl    %cl,%eax
  801bcc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bd0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bd4:	89 f1                	mov    %esi,%ecx
  801bd6:	d3 e8                	shr    %cl,%eax
  801bd8:	09 d0                	or     %edx,%eax
  801bda:	d3 eb                	shr    %cl,%ebx
  801bdc:	89 da                	mov    %ebx,%edx
  801bde:	f7 f7                	div    %edi
  801be0:	89 d3                	mov    %edx,%ebx
  801be2:	f7 24 24             	mull   (%esp)
  801be5:	89 c6                	mov    %eax,%esi
  801be7:	89 d1                	mov    %edx,%ecx
  801be9:	39 d3                	cmp    %edx,%ebx
  801beb:	0f 82 87 00 00 00    	jb     801c78 <__umoddi3+0x134>
  801bf1:	0f 84 91 00 00 00    	je     801c88 <__umoddi3+0x144>
  801bf7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bfb:	29 f2                	sub    %esi,%edx
  801bfd:	19 cb                	sbb    %ecx,%ebx
  801bff:	89 d8                	mov    %ebx,%eax
  801c01:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c05:	d3 e0                	shl    %cl,%eax
  801c07:	89 e9                	mov    %ebp,%ecx
  801c09:	d3 ea                	shr    %cl,%edx
  801c0b:	09 d0                	or     %edx,%eax
  801c0d:	89 e9                	mov    %ebp,%ecx
  801c0f:	d3 eb                	shr    %cl,%ebx
  801c11:	89 da                	mov    %ebx,%edx
  801c13:	83 c4 1c             	add    $0x1c,%esp
  801c16:	5b                   	pop    %ebx
  801c17:	5e                   	pop    %esi
  801c18:	5f                   	pop    %edi
  801c19:	5d                   	pop    %ebp
  801c1a:	c3                   	ret    
  801c1b:	90                   	nop
  801c1c:	89 fd                	mov    %edi,%ebp
  801c1e:	85 ff                	test   %edi,%edi
  801c20:	75 0b                	jne    801c2d <__umoddi3+0xe9>
  801c22:	b8 01 00 00 00       	mov    $0x1,%eax
  801c27:	31 d2                	xor    %edx,%edx
  801c29:	f7 f7                	div    %edi
  801c2b:	89 c5                	mov    %eax,%ebp
  801c2d:	89 f0                	mov    %esi,%eax
  801c2f:	31 d2                	xor    %edx,%edx
  801c31:	f7 f5                	div    %ebp
  801c33:	89 c8                	mov    %ecx,%eax
  801c35:	f7 f5                	div    %ebp
  801c37:	89 d0                	mov    %edx,%eax
  801c39:	e9 44 ff ff ff       	jmp    801b82 <__umoddi3+0x3e>
  801c3e:	66 90                	xchg   %ax,%ax
  801c40:	89 c8                	mov    %ecx,%eax
  801c42:	89 f2                	mov    %esi,%edx
  801c44:	83 c4 1c             	add    $0x1c,%esp
  801c47:	5b                   	pop    %ebx
  801c48:	5e                   	pop    %esi
  801c49:	5f                   	pop    %edi
  801c4a:	5d                   	pop    %ebp
  801c4b:	c3                   	ret    
  801c4c:	3b 04 24             	cmp    (%esp),%eax
  801c4f:	72 06                	jb     801c57 <__umoddi3+0x113>
  801c51:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c55:	77 0f                	ja     801c66 <__umoddi3+0x122>
  801c57:	89 f2                	mov    %esi,%edx
  801c59:	29 f9                	sub    %edi,%ecx
  801c5b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c5f:	89 14 24             	mov    %edx,(%esp)
  801c62:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c66:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c6a:	8b 14 24             	mov    (%esp),%edx
  801c6d:	83 c4 1c             	add    $0x1c,%esp
  801c70:	5b                   	pop    %ebx
  801c71:	5e                   	pop    %esi
  801c72:	5f                   	pop    %edi
  801c73:	5d                   	pop    %ebp
  801c74:	c3                   	ret    
  801c75:	8d 76 00             	lea    0x0(%esi),%esi
  801c78:	2b 04 24             	sub    (%esp),%eax
  801c7b:	19 fa                	sbb    %edi,%edx
  801c7d:	89 d1                	mov    %edx,%ecx
  801c7f:	89 c6                	mov    %eax,%esi
  801c81:	e9 71 ff ff ff       	jmp    801bf7 <__umoddi3+0xb3>
  801c86:	66 90                	xchg   %ax,%ax
  801c88:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c8c:	72 ea                	jb     801c78 <__umoddi3+0x134>
  801c8e:	89 d9                	mov    %ebx,%ecx
  801c90:	e9 62 ff ff ff       	jmp    801bf7 <__umoddi3+0xb3>
