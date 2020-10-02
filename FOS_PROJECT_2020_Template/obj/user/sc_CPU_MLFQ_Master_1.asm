
obj/user/sc_CPU_MLFQ_Master_1:     file format elf32-i386


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
  800031:	e8 71 00 00 00       	call   8000a7 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// hello, world
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	int ID;
	for (int i = 0; i < 5; ++i) {
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800045:	eb 44                	jmp    80008b <_main+0x53>
			ID = sys_create_env("tmlfq_1", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  800047:	a1 20 20 80 00       	mov    0x802020,%eax
  80004c:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  800052:	a1 20 20 80 00       	mov    0x802020,%eax
  800057:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80005d:	89 c1                	mov    %eax,%ecx
  80005f:	a1 20 20 80 00       	mov    0x802020,%eax
  800064:	8b 40 74             	mov    0x74(%eax),%eax
  800067:	52                   	push   %edx
  800068:	51                   	push   %ecx
  800069:	50                   	push   %eax
  80006a:	68 c0 19 80 00       	push   $0x8019c0
  80006f:	e8 97 13 00 00       	call   80140b <sys_create_env>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 f0             	mov    %eax,-0x10(%ebp)
			sys_run_env(ID);
  80007a:	83 ec 0c             	sub    $0xc,%esp
  80007d:	ff 75 f0             	pushl  -0x10(%ebp)
  800080:	e8 a4 13 00 00       	call   801429 <sys_run_env>
  800085:	83 c4 10             	add    $0x10,%esp
#include <inc/lib.h>

void _main(void)
{
	int ID;
	for (int i = 0; i < 5; ++i) {
  800088:	ff 45 f4             	incl   -0xc(%ebp)
  80008b:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
  80008f:	7e b6                	jle    800047 <_main+0xf>
			ID = sys_create_env("tmlfq_1", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
			sys_run_env(ID);
		}

		//env_sleep(80000);
		int x = busy_wait(50000000);
  800091:	83 ec 0c             	sub    $0xc,%esp
  800094:	68 80 f0 fa 02       	push   $0x2faf080
  800099:	e8 9e 16 00 00       	call   80173c <busy_wait>
  80009e:	83 c4 10             	add    $0x10,%esp
  8000a1:	89 45 ec             	mov    %eax,-0x14(%ebp)

}
  8000a4:	90                   	nop
  8000a5:	c9                   	leave  
  8000a6:	c3                   	ret    

008000a7 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000a7:	55                   	push   %ebp
  8000a8:	89 e5                	mov    %esp,%ebp
  8000aa:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000ad:	e8 39 10 00 00       	call   8010eb <sys_getenvindex>
  8000b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000b8:	89 d0                	mov    %edx,%eax
  8000ba:	c1 e0 03             	shl    $0x3,%eax
  8000bd:	01 d0                	add    %edx,%eax
  8000bf:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8000c6:	01 c8                	add    %ecx,%eax
  8000c8:	01 c0                	add    %eax,%eax
  8000ca:	01 d0                	add    %edx,%eax
  8000cc:	01 c0                	add    %eax,%eax
  8000ce:	01 d0                	add    %edx,%eax
  8000d0:	89 c2                	mov    %eax,%edx
  8000d2:	c1 e2 05             	shl    $0x5,%edx
  8000d5:	29 c2                	sub    %eax,%edx
  8000d7:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8000de:	89 c2                	mov    %eax,%edx
  8000e0:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8000e6:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000eb:	a1 20 20 80 00       	mov    0x802020,%eax
  8000f0:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8000f6:	84 c0                	test   %al,%al
  8000f8:	74 0f                	je     800109 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8000fa:	a1 20 20 80 00       	mov    0x802020,%eax
  8000ff:	05 40 3c 01 00       	add    $0x13c40,%eax
  800104:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800109:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80010d:	7e 0a                	jle    800119 <libmain+0x72>
		binaryname = argv[0];
  80010f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800112:	8b 00                	mov    (%eax),%eax
  800114:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800119:	83 ec 08             	sub    $0x8,%esp
  80011c:	ff 75 0c             	pushl  0xc(%ebp)
  80011f:	ff 75 08             	pushl  0x8(%ebp)
  800122:	e8 11 ff ff ff       	call   800038 <_main>
  800127:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80012a:	e8 57 11 00 00       	call   801286 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80012f:	83 ec 0c             	sub    $0xc,%esp
  800132:	68 e0 19 80 00       	push   $0x8019e0
  800137:	e8 84 01 00 00       	call   8002c0 <cprintf>
  80013c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80013f:	a1 20 20 80 00       	mov    0x802020,%eax
  800144:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80014a:	a1 20 20 80 00       	mov    0x802020,%eax
  80014f:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800155:	83 ec 04             	sub    $0x4,%esp
  800158:	52                   	push   %edx
  800159:	50                   	push   %eax
  80015a:	68 08 1a 80 00       	push   $0x801a08
  80015f:	e8 5c 01 00 00       	call   8002c0 <cprintf>
  800164:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800167:	a1 20 20 80 00       	mov    0x802020,%eax
  80016c:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800172:	a1 20 20 80 00       	mov    0x802020,%eax
  800177:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80017d:	83 ec 04             	sub    $0x4,%esp
  800180:	52                   	push   %edx
  800181:	50                   	push   %eax
  800182:	68 30 1a 80 00       	push   $0x801a30
  800187:	e8 34 01 00 00       	call   8002c0 <cprintf>
  80018c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80018f:	a1 20 20 80 00       	mov    0x802020,%eax
  800194:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80019a:	83 ec 08             	sub    $0x8,%esp
  80019d:	50                   	push   %eax
  80019e:	68 71 1a 80 00       	push   $0x801a71
  8001a3:	e8 18 01 00 00       	call   8002c0 <cprintf>
  8001a8:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001ab:	83 ec 0c             	sub    $0xc,%esp
  8001ae:	68 e0 19 80 00       	push   $0x8019e0
  8001b3:	e8 08 01 00 00       	call   8002c0 <cprintf>
  8001b8:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001bb:	e8 e0 10 00 00       	call   8012a0 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001c0:	e8 19 00 00 00       	call   8001de <exit>
}
  8001c5:	90                   	nop
  8001c6:	c9                   	leave  
  8001c7:	c3                   	ret    

008001c8 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001c8:	55                   	push   %ebp
  8001c9:	89 e5                	mov    %esp,%ebp
  8001cb:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001ce:	83 ec 0c             	sub    $0xc,%esp
  8001d1:	6a 00                	push   $0x0
  8001d3:	e8 df 0e 00 00       	call   8010b7 <sys_env_destroy>
  8001d8:	83 c4 10             	add    $0x10,%esp
}
  8001db:	90                   	nop
  8001dc:	c9                   	leave  
  8001dd:	c3                   	ret    

008001de <exit>:

void
exit(void)
{
  8001de:	55                   	push   %ebp
  8001df:	89 e5                	mov    %esp,%ebp
  8001e1:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001e4:	e8 34 0f 00 00       	call   80111d <sys_env_exit>
}
  8001e9:	90                   	nop
  8001ea:	c9                   	leave  
  8001eb:	c3                   	ret    

008001ec <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001ec:	55                   	push   %ebp
  8001ed:	89 e5                	mov    %esp,%ebp
  8001ef:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f5:	8b 00                	mov    (%eax),%eax
  8001f7:	8d 48 01             	lea    0x1(%eax),%ecx
  8001fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001fd:	89 0a                	mov    %ecx,(%edx)
  8001ff:	8b 55 08             	mov    0x8(%ebp),%edx
  800202:	88 d1                	mov    %dl,%cl
  800204:	8b 55 0c             	mov    0xc(%ebp),%edx
  800207:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80020b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020e:	8b 00                	mov    (%eax),%eax
  800210:	3d ff 00 00 00       	cmp    $0xff,%eax
  800215:	75 2c                	jne    800243 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800217:	a0 24 20 80 00       	mov    0x802024,%al
  80021c:	0f b6 c0             	movzbl %al,%eax
  80021f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800222:	8b 12                	mov    (%edx),%edx
  800224:	89 d1                	mov    %edx,%ecx
  800226:	8b 55 0c             	mov    0xc(%ebp),%edx
  800229:	83 c2 08             	add    $0x8,%edx
  80022c:	83 ec 04             	sub    $0x4,%esp
  80022f:	50                   	push   %eax
  800230:	51                   	push   %ecx
  800231:	52                   	push   %edx
  800232:	e8 3e 0e 00 00       	call   801075 <sys_cputs>
  800237:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80023a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80023d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800243:	8b 45 0c             	mov    0xc(%ebp),%eax
  800246:	8b 40 04             	mov    0x4(%eax),%eax
  800249:	8d 50 01             	lea    0x1(%eax),%edx
  80024c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80024f:	89 50 04             	mov    %edx,0x4(%eax)
}
  800252:	90                   	nop
  800253:	c9                   	leave  
  800254:	c3                   	ret    

00800255 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800255:	55                   	push   %ebp
  800256:	89 e5                	mov    %esp,%ebp
  800258:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80025e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800265:	00 00 00 
	b.cnt = 0;
  800268:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80026f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800272:	ff 75 0c             	pushl  0xc(%ebp)
  800275:	ff 75 08             	pushl  0x8(%ebp)
  800278:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80027e:	50                   	push   %eax
  80027f:	68 ec 01 80 00       	push   $0x8001ec
  800284:	e8 11 02 00 00       	call   80049a <vprintfmt>
  800289:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80028c:	a0 24 20 80 00       	mov    0x802024,%al
  800291:	0f b6 c0             	movzbl %al,%eax
  800294:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80029a:	83 ec 04             	sub    $0x4,%esp
  80029d:	50                   	push   %eax
  80029e:	52                   	push   %edx
  80029f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002a5:	83 c0 08             	add    $0x8,%eax
  8002a8:	50                   	push   %eax
  8002a9:	e8 c7 0d 00 00       	call   801075 <sys_cputs>
  8002ae:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002b1:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  8002b8:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002be:	c9                   	leave  
  8002bf:	c3                   	ret    

008002c0 <cprintf>:

int cprintf(const char *fmt, ...) {
  8002c0:	55                   	push   %ebp
  8002c1:	89 e5                	mov    %esp,%ebp
  8002c3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002c6:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  8002cd:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d6:	83 ec 08             	sub    $0x8,%esp
  8002d9:	ff 75 f4             	pushl  -0xc(%ebp)
  8002dc:	50                   	push   %eax
  8002dd:	e8 73 ff ff ff       	call   800255 <vcprintf>
  8002e2:	83 c4 10             	add    $0x10,%esp
  8002e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002eb:	c9                   	leave  
  8002ec:	c3                   	ret    

008002ed <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002ed:	55                   	push   %ebp
  8002ee:	89 e5                	mov    %esp,%ebp
  8002f0:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002f3:	e8 8e 0f 00 00       	call   801286 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002f8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800301:	83 ec 08             	sub    $0x8,%esp
  800304:	ff 75 f4             	pushl  -0xc(%ebp)
  800307:	50                   	push   %eax
  800308:	e8 48 ff ff ff       	call   800255 <vcprintf>
  80030d:	83 c4 10             	add    $0x10,%esp
  800310:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800313:	e8 88 0f 00 00       	call   8012a0 <sys_enable_interrupt>
	return cnt;
  800318:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80031b:	c9                   	leave  
  80031c:	c3                   	ret    

0080031d <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80031d:	55                   	push   %ebp
  80031e:	89 e5                	mov    %esp,%ebp
  800320:	53                   	push   %ebx
  800321:	83 ec 14             	sub    $0x14,%esp
  800324:	8b 45 10             	mov    0x10(%ebp),%eax
  800327:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80032a:	8b 45 14             	mov    0x14(%ebp),%eax
  80032d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800330:	8b 45 18             	mov    0x18(%ebp),%eax
  800333:	ba 00 00 00 00       	mov    $0x0,%edx
  800338:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80033b:	77 55                	ja     800392 <printnum+0x75>
  80033d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800340:	72 05                	jb     800347 <printnum+0x2a>
  800342:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800345:	77 4b                	ja     800392 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800347:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80034a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80034d:	8b 45 18             	mov    0x18(%ebp),%eax
  800350:	ba 00 00 00 00       	mov    $0x0,%edx
  800355:	52                   	push   %edx
  800356:	50                   	push   %eax
  800357:	ff 75 f4             	pushl  -0xc(%ebp)
  80035a:	ff 75 f0             	pushl  -0x10(%ebp)
  80035d:	e8 fa 13 00 00       	call   80175c <__udivdi3>
  800362:	83 c4 10             	add    $0x10,%esp
  800365:	83 ec 04             	sub    $0x4,%esp
  800368:	ff 75 20             	pushl  0x20(%ebp)
  80036b:	53                   	push   %ebx
  80036c:	ff 75 18             	pushl  0x18(%ebp)
  80036f:	52                   	push   %edx
  800370:	50                   	push   %eax
  800371:	ff 75 0c             	pushl  0xc(%ebp)
  800374:	ff 75 08             	pushl  0x8(%ebp)
  800377:	e8 a1 ff ff ff       	call   80031d <printnum>
  80037c:	83 c4 20             	add    $0x20,%esp
  80037f:	eb 1a                	jmp    80039b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800381:	83 ec 08             	sub    $0x8,%esp
  800384:	ff 75 0c             	pushl  0xc(%ebp)
  800387:	ff 75 20             	pushl  0x20(%ebp)
  80038a:	8b 45 08             	mov    0x8(%ebp),%eax
  80038d:	ff d0                	call   *%eax
  80038f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800392:	ff 4d 1c             	decl   0x1c(%ebp)
  800395:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800399:	7f e6                	jg     800381 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80039b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80039e:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003a9:	53                   	push   %ebx
  8003aa:	51                   	push   %ecx
  8003ab:	52                   	push   %edx
  8003ac:	50                   	push   %eax
  8003ad:	e8 ba 14 00 00       	call   80186c <__umoddi3>
  8003b2:	83 c4 10             	add    $0x10,%esp
  8003b5:	05 b4 1c 80 00       	add    $0x801cb4,%eax
  8003ba:	8a 00                	mov    (%eax),%al
  8003bc:	0f be c0             	movsbl %al,%eax
  8003bf:	83 ec 08             	sub    $0x8,%esp
  8003c2:	ff 75 0c             	pushl  0xc(%ebp)
  8003c5:	50                   	push   %eax
  8003c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c9:	ff d0                	call   *%eax
  8003cb:	83 c4 10             	add    $0x10,%esp
}
  8003ce:	90                   	nop
  8003cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003d2:	c9                   	leave  
  8003d3:	c3                   	ret    

008003d4 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003d4:	55                   	push   %ebp
  8003d5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003d7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003db:	7e 1c                	jle    8003f9 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e0:	8b 00                	mov    (%eax),%eax
  8003e2:	8d 50 08             	lea    0x8(%eax),%edx
  8003e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e8:	89 10                	mov    %edx,(%eax)
  8003ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ed:	8b 00                	mov    (%eax),%eax
  8003ef:	83 e8 08             	sub    $0x8,%eax
  8003f2:	8b 50 04             	mov    0x4(%eax),%edx
  8003f5:	8b 00                	mov    (%eax),%eax
  8003f7:	eb 40                	jmp    800439 <getuint+0x65>
	else if (lflag)
  8003f9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003fd:	74 1e                	je     80041d <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800402:	8b 00                	mov    (%eax),%eax
  800404:	8d 50 04             	lea    0x4(%eax),%edx
  800407:	8b 45 08             	mov    0x8(%ebp),%eax
  80040a:	89 10                	mov    %edx,(%eax)
  80040c:	8b 45 08             	mov    0x8(%ebp),%eax
  80040f:	8b 00                	mov    (%eax),%eax
  800411:	83 e8 04             	sub    $0x4,%eax
  800414:	8b 00                	mov    (%eax),%eax
  800416:	ba 00 00 00 00       	mov    $0x0,%edx
  80041b:	eb 1c                	jmp    800439 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80041d:	8b 45 08             	mov    0x8(%ebp),%eax
  800420:	8b 00                	mov    (%eax),%eax
  800422:	8d 50 04             	lea    0x4(%eax),%edx
  800425:	8b 45 08             	mov    0x8(%ebp),%eax
  800428:	89 10                	mov    %edx,(%eax)
  80042a:	8b 45 08             	mov    0x8(%ebp),%eax
  80042d:	8b 00                	mov    (%eax),%eax
  80042f:	83 e8 04             	sub    $0x4,%eax
  800432:	8b 00                	mov    (%eax),%eax
  800434:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800439:	5d                   	pop    %ebp
  80043a:	c3                   	ret    

0080043b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80043b:	55                   	push   %ebp
  80043c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80043e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800442:	7e 1c                	jle    800460 <getint+0x25>
		return va_arg(*ap, long long);
  800444:	8b 45 08             	mov    0x8(%ebp),%eax
  800447:	8b 00                	mov    (%eax),%eax
  800449:	8d 50 08             	lea    0x8(%eax),%edx
  80044c:	8b 45 08             	mov    0x8(%ebp),%eax
  80044f:	89 10                	mov    %edx,(%eax)
  800451:	8b 45 08             	mov    0x8(%ebp),%eax
  800454:	8b 00                	mov    (%eax),%eax
  800456:	83 e8 08             	sub    $0x8,%eax
  800459:	8b 50 04             	mov    0x4(%eax),%edx
  80045c:	8b 00                	mov    (%eax),%eax
  80045e:	eb 38                	jmp    800498 <getint+0x5d>
	else if (lflag)
  800460:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800464:	74 1a                	je     800480 <getint+0x45>
		return va_arg(*ap, long);
  800466:	8b 45 08             	mov    0x8(%ebp),%eax
  800469:	8b 00                	mov    (%eax),%eax
  80046b:	8d 50 04             	lea    0x4(%eax),%edx
  80046e:	8b 45 08             	mov    0x8(%ebp),%eax
  800471:	89 10                	mov    %edx,(%eax)
  800473:	8b 45 08             	mov    0x8(%ebp),%eax
  800476:	8b 00                	mov    (%eax),%eax
  800478:	83 e8 04             	sub    $0x4,%eax
  80047b:	8b 00                	mov    (%eax),%eax
  80047d:	99                   	cltd   
  80047e:	eb 18                	jmp    800498 <getint+0x5d>
	else
		return va_arg(*ap, int);
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
}
  800498:	5d                   	pop    %ebp
  800499:	c3                   	ret    

0080049a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80049a:	55                   	push   %ebp
  80049b:	89 e5                	mov    %esp,%ebp
  80049d:	56                   	push   %esi
  80049e:	53                   	push   %ebx
  80049f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004a2:	eb 17                	jmp    8004bb <vprintfmt+0x21>
			if (ch == '\0')
  8004a4:	85 db                	test   %ebx,%ebx
  8004a6:	0f 84 af 03 00 00    	je     80085b <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004ac:	83 ec 08             	sub    $0x8,%esp
  8004af:	ff 75 0c             	pushl  0xc(%ebp)
  8004b2:	53                   	push   %ebx
  8004b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b6:	ff d0                	call   *%eax
  8004b8:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8004be:	8d 50 01             	lea    0x1(%eax),%edx
  8004c1:	89 55 10             	mov    %edx,0x10(%ebp)
  8004c4:	8a 00                	mov    (%eax),%al
  8004c6:	0f b6 d8             	movzbl %al,%ebx
  8004c9:	83 fb 25             	cmp    $0x25,%ebx
  8004cc:	75 d6                	jne    8004a4 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004ce:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004d2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004d9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004e0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004e7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8004f1:	8d 50 01             	lea    0x1(%eax),%edx
  8004f4:	89 55 10             	mov    %edx,0x10(%ebp)
  8004f7:	8a 00                	mov    (%eax),%al
  8004f9:	0f b6 d8             	movzbl %al,%ebx
  8004fc:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004ff:	83 f8 55             	cmp    $0x55,%eax
  800502:	0f 87 2b 03 00 00    	ja     800833 <vprintfmt+0x399>
  800508:	8b 04 85 d8 1c 80 00 	mov    0x801cd8(,%eax,4),%eax
  80050f:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800511:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800515:	eb d7                	jmp    8004ee <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800517:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80051b:	eb d1                	jmp    8004ee <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80051d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800524:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800527:	89 d0                	mov    %edx,%eax
  800529:	c1 e0 02             	shl    $0x2,%eax
  80052c:	01 d0                	add    %edx,%eax
  80052e:	01 c0                	add    %eax,%eax
  800530:	01 d8                	add    %ebx,%eax
  800532:	83 e8 30             	sub    $0x30,%eax
  800535:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800538:	8b 45 10             	mov    0x10(%ebp),%eax
  80053b:	8a 00                	mov    (%eax),%al
  80053d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800540:	83 fb 2f             	cmp    $0x2f,%ebx
  800543:	7e 3e                	jle    800583 <vprintfmt+0xe9>
  800545:	83 fb 39             	cmp    $0x39,%ebx
  800548:	7f 39                	jg     800583 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80054a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80054d:	eb d5                	jmp    800524 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80054f:	8b 45 14             	mov    0x14(%ebp),%eax
  800552:	83 c0 04             	add    $0x4,%eax
  800555:	89 45 14             	mov    %eax,0x14(%ebp)
  800558:	8b 45 14             	mov    0x14(%ebp),%eax
  80055b:	83 e8 04             	sub    $0x4,%eax
  80055e:	8b 00                	mov    (%eax),%eax
  800560:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800563:	eb 1f                	jmp    800584 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800565:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800569:	79 83                	jns    8004ee <vprintfmt+0x54>
				width = 0;
  80056b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800572:	e9 77 ff ff ff       	jmp    8004ee <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800577:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80057e:	e9 6b ff ff ff       	jmp    8004ee <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800583:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800584:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800588:	0f 89 60 ff ff ff    	jns    8004ee <vprintfmt+0x54>
				width = precision, precision = -1;
  80058e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800591:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800594:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80059b:	e9 4e ff ff ff       	jmp    8004ee <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005a0:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005a3:	e9 46 ff ff ff       	jmp    8004ee <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ab:	83 c0 04             	add    $0x4,%eax
  8005ae:	89 45 14             	mov    %eax,0x14(%ebp)
  8005b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b4:	83 e8 04             	sub    $0x4,%eax
  8005b7:	8b 00                	mov    (%eax),%eax
  8005b9:	83 ec 08             	sub    $0x8,%esp
  8005bc:	ff 75 0c             	pushl  0xc(%ebp)
  8005bf:	50                   	push   %eax
  8005c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c3:	ff d0                	call   *%eax
  8005c5:	83 c4 10             	add    $0x10,%esp
			break;
  8005c8:	e9 89 02 00 00       	jmp    800856 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d0:	83 c0 04             	add    $0x4,%eax
  8005d3:	89 45 14             	mov    %eax,0x14(%ebp)
  8005d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d9:	83 e8 04             	sub    $0x4,%eax
  8005dc:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005de:	85 db                	test   %ebx,%ebx
  8005e0:	79 02                	jns    8005e4 <vprintfmt+0x14a>
				err = -err;
  8005e2:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005e4:	83 fb 64             	cmp    $0x64,%ebx
  8005e7:	7f 0b                	jg     8005f4 <vprintfmt+0x15a>
  8005e9:	8b 34 9d 20 1b 80 00 	mov    0x801b20(,%ebx,4),%esi
  8005f0:	85 f6                	test   %esi,%esi
  8005f2:	75 19                	jne    80060d <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005f4:	53                   	push   %ebx
  8005f5:	68 c5 1c 80 00       	push   $0x801cc5
  8005fa:	ff 75 0c             	pushl  0xc(%ebp)
  8005fd:	ff 75 08             	pushl  0x8(%ebp)
  800600:	e8 5e 02 00 00       	call   800863 <printfmt>
  800605:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800608:	e9 49 02 00 00       	jmp    800856 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80060d:	56                   	push   %esi
  80060e:	68 ce 1c 80 00       	push   $0x801cce
  800613:	ff 75 0c             	pushl  0xc(%ebp)
  800616:	ff 75 08             	pushl  0x8(%ebp)
  800619:	e8 45 02 00 00       	call   800863 <printfmt>
  80061e:	83 c4 10             	add    $0x10,%esp
			break;
  800621:	e9 30 02 00 00       	jmp    800856 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800626:	8b 45 14             	mov    0x14(%ebp),%eax
  800629:	83 c0 04             	add    $0x4,%eax
  80062c:	89 45 14             	mov    %eax,0x14(%ebp)
  80062f:	8b 45 14             	mov    0x14(%ebp),%eax
  800632:	83 e8 04             	sub    $0x4,%eax
  800635:	8b 30                	mov    (%eax),%esi
  800637:	85 f6                	test   %esi,%esi
  800639:	75 05                	jne    800640 <vprintfmt+0x1a6>
				p = "(null)";
  80063b:	be d1 1c 80 00       	mov    $0x801cd1,%esi
			if (width > 0 && padc != '-')
  800640:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800644:	7e 6d                	jle    8006b3 <vprintfmt+0x219>
  800646:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80064a:	74 67                	je     8006b3 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80064c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80064f:	83 ec 08             	sub    $0x8,%esp
  800652:	50                   	push   %eax
  800653:	56                   	push   %esi
  800654:	e8 0c 03 00 00       	call   800965 <strnlen>
  800659:	83 c4 10             	add    $0x10,%esp
  80065c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80065f:	eb 16                	jmp    800677 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800661:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800665:	83 ec 08             	sub    $0x8,%esp
  800668:	ff 75 0c             	pushl  0xc(%ebp)
  80066b:	50                   	push   %eax
  80066c:	8b 45 08             	mov    0x8(%ebp),%eax
  80066f:	ff d0                	call   *%eax
  800671:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800674:	ff 4d e4             	decl   -0x1c(%ebp)
  800677:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80067b:	7f e4                	jg     800661 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80067d:	eb 34                	jmp    8006b3 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80067f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800683:	74 1c                	je     8006a1 <vprintfmt+0x207>
  800685:	83 fb 1f             	cmp    $0x1f,%ebx
  800688:	7e 05                	jle    80068f <vprintfmt+0x1f5>
  80068a:	83 fb 7e             	cmp    $0x7e,%ebx
  80068d:	7e 12                	jle    8006a1 <vprintfmt+0x207>
					putch('?', putdat);
  80068f:	83 ec 08             	sub    $0x8,%esp
  800692:	ff 75 0c             	pushl  0xc(%ebp)
  800695:	6a 3f                	push   $0x3f
  800697:	8b 45 08             	mov    0x8(%ebp),%eax
  80069a:	ff d0                	call   *%eax
  80069c:	83 c4 10             	add    $0x10,%esp
  80069f:	eb 0f                	jmp    8006b0 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006a1:	83 ec 08             	sub    $0x8,%esp
  8006a4:	ff 75 0c             	pushl  0xc(%ebp)
  8006a7:	53                   	push   %ebx
  8006a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ab:	ff d0                	call   *%eax
  8006ad:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006b0:	ff 4d e4             	decl   -0x1c(%ebp)
  8006b3:	89 f0                	mov    %esi,%eax
  8006b5:	8d 70 01             	lea    0x1(%eax),%esi
  8006b8:	8a 00                	mov    (%eax),%al
  8006ba:	0f be d8             	movsbl %al,%ebx
  8006bd:	85 db                	test   %ebx,%ebx
  8006bf:	74 24                	je     8006e5 <vprintfmt+0x24b>
  8006c1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006c5:	78 b8                	js     80067f <vprintfmt+0x1e5>
  8006c7:	ff 4d e0             	decl   -0x20(%ebp)
  8006ca:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006ce:	79 af                	jns    80067f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006d0:	eb 13                	jmp    8006e5 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006d2:	83 ec 08             	sub    $0x8,%esp
  8006d5:	ff 75 0c             	pushl  0xc(%ebp)
  8006d8:	6a 20                	push   $0x20
  8006da:	8b 45 08             	mov    0x8(%ebp),%eax
  8006dd:	ff d0                	call   *%eax
  8006df:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006e2:	ff 4d e4             	decl   -0x1c(%ebp)
  8006e5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006e9:	7f e7                	jg     8006d2 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006eb:	e9 66 01 00 00       	jmp    800856 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006f0:	83 ec 08             	sub    $0x8,%esp
  8006f3:	ff 75 e8             	pushl  -0x18(%ebp)
  8006f6:	8d 45 14             	lea    0x14(%ebp),%eax
  8006f9:	50                   	push   %eax
  8006fa:	e8 3c fd ff ff       	call   80043b <getint>
  8006ff:	83 c4 10             	add    $0x10,%esp
  800702:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800705:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800708:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80070b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80070e:	85 d2                	test   %edx,%edx
  800710:	79 23                	jns    800735 <vprintfmt+0x29b>
				putch('-', putdat);
  800712:	83 ec 08             	sub    $0x8,%esp
  800715:	ff 75 0c             	pushl  0xc(%ebp)
  800718:	6a 2d                	push   $0x2d
  80071a:	8b 45 08             	mov    0x8(%ebp),%eax
  80071d:	ff d0                	call   *%eax
  80071f:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800722:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800725:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800728:	f7 d8                	neg    %eax
  80072a:	83 d2 00             	adc    $0x0,%edx
  80072d:	f7 da                	neg    %edx
  80072f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800732:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800735:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80073c:	e9 bc 00 00 00       	jmp    8007fd <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800741:	83 ec 08             	sub    $0x8,%esp
  800744:	ff 75 e8             	pushl  -0x18(%ebp)
  800747:	8d 45 14             	lea    0x14(%ebp),%eax
  80074a:	50                   	push   %eax
  80074b:	e8 84 fc ff ff       	call   8003d4 <getuint>
  800750:	83 c4 10             	add    $0x10,%esp
  800753:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800756:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800759:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800760:	e9 98 00 00 00       	jmp    8007fd <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800765:	83 ec 08             	sub    $0x8,%esp
  800768:	ff 75 0c             	pushl  0xc(%ebp)
  80076b:	6a 58                	push   $0x58
  80076d:	8b 45 08             	mov    0x8(%ebp),%eax
  800770:	ff d0                	call   *%eax
  800772:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800775:	83 ec 08             	sub    $0x8,%esp
  800778:	ff 75 0c             	pushl  0xc(%ebp)
  80077b:	6a 58                	push   $0x58
  80077d:	8b 45 08             	mov    0x8(%ebp),%eax
  800780:	ff d0                	call   *%eax
  800782:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800785:	83 ec 08             	sub    $0x8,%esp
  800788:	ff 75 0c             	pushl  0xc(%ebp)
  80078b:	6a 58                	push   $0x58
  80078d:	8b 45 08             	mov    0x8(%ebp),%eax
  800790:	ff d0                	call   *%eax
  800792:	83 c4 10             	add    $0x10,%esp
			break;
  800795:	e9 bc 00 00 00       	jmp    800856 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80079a:	83 ec 08             	sub    $0x8,%esp
  80079d:	ff 75 0c             	pushl  0xc(%ebp)
  8007a0:	6a 30                	push   $0x30
  8007a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a5:	ff d0                	call   *%eax
  8007a7:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007aa:	83 ec 08             	sub    $0x8,%esp
  8007ad:	ff 75 0c             	pushl  0xc(%ebp)
  8007b0:	6a 78                	push   $0x78
  8007b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b5:	ff d0                	call   *%eax
  8007b7:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007ba:	8b 45 14             	mov    0x14(%ebp),%eax
  8007bd:	83 c0 04             	add    $0x4,%eax
  8007c0:	89 45 14             	mov    %eax,0x14(%ebp)
  8007c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c6:	83 e8 04             	sub    $0x4,%eax
  8007c9:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007d5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007dc:	eb 1f                	jmp    8007fd <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007de:	83 ec 08             	sub    $0x8,%esp
  8007e1:	ff 75 e8             	pushl  -0x18(%ebp)
  8007e4:	8d 45 14             	lea    0x14(%ebp),%eax
  8007e7:	50                   	push   %eax
  8007e8:	e8 e7 fb ff ff       	call   8003d4 <getuint>
  8007ed:	83 c4 10             	add    $0x10,%esp
  8007f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007f3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007f6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007fd:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800801:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800804:	83 ec 04             	sub    $0x4,%esp
  800807:	52                   	push   %edx
  800808:	ff 75 e4             	pushl  -0x1c(%ebp)
  80080b:	50                   	push   %eax
  80080c:	ff 75 f4             	pushl  -0xc(%ebp)
  80080f:	ff 75 f0             	pushl  -0x10(%ebp)
  800812:	ff 75 0c             	pushl  0xc(%ebp)
  800815:	ff 75 08             	pushl  0x8(%ebp)
  800818:	e8 00 fb ff ff       	call   80031d <printnum>
  80081d:	83 c4 20             	add    $0x20,%esp
			break;
  800820:	eb 34                	jmp    800856 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800822:	83 ec 08             	sub    $0x8,%esp
  800825:	ff 75 0c             	pushl  0xc(%ebp)
  800828:	53                   	push   %ebx
  800829:	8b 45 08             	mov    0x8(%ebp),%eax
  80082c:	ff d0                	call   *%eax
  80082e:	83 c4 10             	add    $0x10,%esp
			break;
  800831:	eb 23                	jmp    800856 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800833:	83 ec 08             	sub    $0x8,%esp
  800836:	ff 75 0c             	pushl  0xc(%ebp)
  800839:	6a 25                	push   $0x25
  80083b:	8b 45 08             	mov    0x8(%ebp),%eax
  80083e:	ff d0                	call   *%eax
  800840:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800843:	ff 4d 10             	decl   0x10(%ebp)
  800846:	eb 03                	jmp    80084b <vprintfmt+0x3b1>
  800848:	ff 4d 10             	decl   0x10(%ebp)
  80084b:	8b 45 10             	mov    0x10(%ebp),%eax
  80084e:	48                   	dec    %eax
  80084f:	8a 00                	mov    (%eax),%al
  800851:	3c 25                	cmp    $0x25,%al
  800853:	75 f3                	jne    800848 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800855:	90                   	nop
		}
	}
  800856:	e9 47 fc ff ff       	jmp    8004a2 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80085b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80085c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80085f:	5b                   	pop    %ebx
  800860:	5e                   	pop    %esi
  800861:	5d                   	pop    %ebp
  800862:	c3                   	ret    

00800863 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800863:	55                   	push   %ebp
  800864:	89 e5                	mov    %esp,%ebp
  800866:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800869:	8d 45 10             	lea    0x10(%ebp),%eax
  80086c:	83 c0 04             	add    $0x4,%eax
  80086f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800872:	8b 45 10             	mov    0x10(%ebp),%eax
  800875:	ff 75 f4             	pushl  -0xc(%ebp)
  800878:	50                   	push   %eax
  800879:	ff 75 0c             	pushl  0xc(%ebp)
  80087c:	ff 75 08             	pushl  0x8(%ebp)
  80087f:	e8 16 fc ff ff       	call   80049a <vprintfmt>
  800884:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800887:	90                   	nop
  800888:	c9                   	leave  
  800889:	c3                   	ret    

0080088a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80088a:	55                   	push   %ebp
  80088b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80088d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800890:	8b 40 08             	mov    0x8(%eax),%eax
  800893:	8d 50 01             	lea    0x1(%eax),%edx
  800896:	8b 45 0c             	mov    0xc(%ebp),%eax
  800899:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80089c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089f:	8b 10                	mov    (%eax),%edx
  8008a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a4:	8b 40 04             	mov    0x4(%eax),%eax
  8008a7:	39 c2                	cmp    %eax,%edx
  8008a9:	73 12                	jae    8008bd <sprintputch+0x33>
		*b->buf++ = ch;
  8008ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ae:	8b 00                	mov    (%eax),%eax
  8008b0:	8d 48 01             	lea    0x1(%eax),%ecx
  8008b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008b6:	89 0a                	mov    %ecx,(%edx)
  8008b8:	8b 55 08             	mov    0x8(%ebp),%edx
  8008bb:	88 10                	mov    %dl,(%eax)
}
  8008bd:	90                   	nop
  8008be:	5d                   	pop    %ebp
  8008bf:	c3                   	ret    

008008c0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008c0:	55                   	push   %ebp
  8008c1:	89 e5                	mov    %esp,%ebp
  8008c3:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008cf:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d5:	01 d0                	add    %edx,%eax
  8008d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008e1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008e5:	74 06                	je     8008ed <vsnprintf+0x2d>
  8008e7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008eb:	7f 07                	jg     8008f4 <vsnprintf+0x34>
		return -E_INVAL;
  8008ed:	b8 03 00 00 00       	mov    $0x3,%eax
  8008f2:	eb 20                	jmp    800914 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008f4:	ff 75 14             	pushl  0x14(%ebp)
  8008f7:	ff 75 10             	pushl  0x10(%ebp)
  8008fa:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008fd:	50                   	push   %eax
  8008fe:	68 8a 08 80 00       	push   $0x80088a
  800903:	e8 92 fb ff ff       	call   80049a <vprintfmt>
  800908:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80090b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80090e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800911:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800914:	c9                   	leave  
  800915:	c3                   	ret    

00800916 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800916:	55                   	push   %ebp
  800917:	89 e5                	mov    %esp,%ebp
  800919:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80091c:	8d 45 10             	lea    0x10(%ebp),%eax
  80091f:	83 c0 04             	add    $0x4,%eax
  800922:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800925:	8b 45 10             	mov    0x10(%ebp),%eax
  800928:	ff 75 f4             	pushl  -0xc(%ebp)
  80092b:	50                   	push   %eax
  80092c:	ff 75 0c             	pushl  0xc(%ebp)
  80092f:	ff 75 08             	pushl  0x8(%ebp)
  800932:	e8 89 ff ff ff       	call   8008c0 <vsnprintf>
  800937:	83 c4 10             	add    $0x10,%esp
  80093a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80093d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800940:	c9                   	leave  
  800941:	c3                   	ret    

00800942 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800942:	55                   	push   %ebp
  800943:	89 e5                	mov    %esp,%ebp
  800945:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800948:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80094f:	eb 06                	jmp    800957 <strlen+0x15>
		n++;
  800951:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800954:	ff 45 08             	incl   0x8(%ebp)
  800957:	8b 45 08             	mov    0x8(%ebp),%eax
  80095a:	8a 00                	mov    (%eax),%al
  80095c:	84 c0                	test   %al,%al
  80095e:	75 f1                	jne    800951 <strlen+0xf>
		n++;
	return n;
  800960:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800963:	c9                   	leave  
  800964:	c3                   	ret    

00800965 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800965:	55                   	push   %ebp
  800966:	89 e5                	mov    %esp,%ebp
  800968:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80096b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800972:	eb 09                	jmp    80097d <strnlen+0x18>
		n++;
  800974:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800977:	ff 45 08             	incl   0x8(%ebp)
  80097a:	ff 4d 0c             	decl   0xc(%ebp)
  80097d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800981:	74 09                	je     80098c <strnlen+0x27>
  800983:	8b 45 08             	mov    0x8(%ebp),%eax
  800986:	8a 00                	mov    (%eax),%al
  800988:	84 c0                	test   %al,%al
  80098a:	75 e8                	jne    800974 <strnlen+0xf>
		n++;
	return n;
  80098c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80098f:	c9                   	leave  
  800990:	c3                   	ret    

00800991 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800991:	55                   	push   %ebp
  800992:	89 e5                	mov    %esp,%ebp
  800994:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800997:	8b 45 08             	mov    0x8(%ebp),%eax
  80099a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80099d:	90                   	nop
  80099e:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a1:	8d 50 01             	lea    0x1(%eax),%edx
  8009a4:	89 55 08             	mov    %edx,0x8(%ebp)
  8009a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009aa:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009ad:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009b0:	8a 12                	mov    (%edx),%dl
  8009b2:	88 10                	mov    %dl,(%eax)
  8009b4:	8a 00                	mov    (%eax),%al
  8009b6:	84 c0                	test   %al,%al
  8009b8:	75 e4                	jne    80099e <strcpy+0xd>
		/* do nothing */;
	return ret;
  8009ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009bd:	c9                   	leave  
  8009be:	c3                   	ret    

008009bf <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8009bf:	55                   	push   %ebp
  8009c0:	89 e5                	mov    %esp,%ebp
  8009c2:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8009c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009cb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009d2:	eb 1f                	jmp    8009f3 <strncpy+0x34>
		*dst++ = *src;
  8009d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d7:	8d 50 01             	lea    0x1(%eax),%edx
  8009da:	89 55 08             	mov    %edx,0x8(%ebp)
  8009dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009e0:	8a 12                	mov    (%edx),%dl
  8009e2:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e7:	8a 00                	mov    (%eax),%al
  8009e9:	84 c0                	test   %al,%al
  8009eb:	74 03                	je     8009f0 <strncpy+0x31>
			src++;
  8009ed:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009f0:	ff 45 fc             	incl   -0x4(%ebp)
  8009f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009f6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009f9:	72 d9                	jb     8009d4 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009fe:	c9                   	leave  
  8009ff:	c3                   	ret    

00800a00 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a00:	55                   	push   %ebp
  800a01:	89 e5                	mov    %esp,%ebp
  800a03:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a06:	8b 45 08             	mov    0x8(%ebp),%eax
  800a09:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a0c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a10:	74 30                	je     800a42 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a12:	eb 16                	jmp    800a2a <strlcpy+0x2a>
			*dst++ = *src++;
  800a14:	8b 45 08             	mov    0x8(%ebp),%eax
  800a17:	8d 50 01             	lea    0x1(%eax),%edx
  800a1a:	89 55 08             	mov    %edx,0x8(%ebp)
  800a1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a20:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a23:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a26:	8a 12                	mov    (%edx),%dl
  800a28:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a2a:	ff 4d 10             	decl   0x10(%ebp)
  800a2d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a31:	74 09                	je     800a3c <strlcpy+0x3c>
  800a33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a36:	8a 00                	mov    (%eax),%al
  800a38:	84 c0                	test   %al,%al
  800a3a:	75 d8                	jne    800a14 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a42:	8b 55 08             	mov    0x8(%ebp),%edx
  800a45:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a48:	29 c2                	sub    %eax,%edx
  800a4a:	89 d0                	mov    %edx,%eax
}
  800a4c:	c9                   	leave  
  800a4d:	c3                   	ret    

00800a4e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a4e:	55                   	push   %ebp
  800a4f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a51:	eb 06                	jmp    800a59 <strcmp+0xb>
		p++, q++;
  800a53:	ff 45 08             	incl   0x8(%ebp)
  800a56:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a59:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5c:	8a 00                	mov    (%eax),%al
  800a5e:	84 c0                	test   %al,%al
  800a60:	74 0e                	je     800a70 <strcmp+0x22>
  800a62:	8b 45 08             	mov    0x8(%ebp),%eax
  800a65:	8a 10                	mov    (%eax),%dl
  800a67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6a:	8a 00                	mov    (%eax),%al
  800a6c:	38 c2                	cmp    %al,%dl
  800a6e:	74 e3                	je     800a53 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a70:	8b 45 08             	mov    0x8(%ebp),%eax
  800a73:	8a 00                	mov    (%eax),%al
  800a75:	0f b6 d0             	movzbl %al,%edx
  800a78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a7b:	8a 00                	mov    (%eax),%al
  800a7d:	0f b6 c0             	movzbl %al,%eax
  800a80:	29 c2                	sub    %eax,%edx
  800a82:	89 d0                	mov    %edx,%eax
}
  800a84:	5d                   	pop    %ebp
  800a85:	c3                   	ret    

00800a86 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a86:	55                   	push   %ebp
  800a87:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a89:	eb 09                	jmp    800a94 <strncmp+0xe>
		n--, p++, q++;
  800a8b:	ff 4d 10             	decl   0x10(%ebp)
  800a8e:	ff 45 08             	incl   0x8(%ebp)
  800a91:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a94:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a98:	74 17                	je     800ab1 <strncmp+0x2b>
  800a9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9d:	8a 00                	mov    (%eax),%al
  800a9f:	84 c0                	test   %al,%al
  800aa1:	74 0e                	je     800ab1 <strncmp+0x2b>
  800aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa6:	8a 10                	mov    (%eax),%dl
  800aa8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aab:	8a 00                	mov    (%eax),%al
  800aad:	38 c2                	cmp    %al,%dl
  800aaf:	74 da                	je     800a8b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ab1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ab5:	75 07                	jne    800abe <strncmp+0x38>
		return 0;
  800ab7:	b8 00 00 00 00       	mov    $0x0,%eax
  800abc:	eb 14                	jmp    800ad2 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800abe:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac1:	8a 00                	mov    (%eax),%al
  800ac3:	0f b6 d0             	movzbl %al,%edx
  800ac6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac9:	8a 00                	mov    (%eax),%al
  800acb:	0f b6 c0             	movzbl %al,%eax
  800ace:	29 c2                	sub    %eax,%edx
  800ad0:	89 d0                	mov    %edx,%eax
}
  800ad2:	5d                   	pop    %ebp
  800ad3:	c3                   	ret    

00800ad4 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ad4:	55                   	push   %ebp
  800ad5:	89 e5                	mov    %esp,%ebp
  800ad7:	83 ec 04             	sub    $0x4,%esp
  800ada:	8b 45 0c             	mov    0xc(%ebp),%eax
  800add:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ae0:	eb 12                	jmp    800af4 <strchr+0x20>
		if (*s == c)
  800ae2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae5:	8a 00                	mov    (%eax),%al
  800ae7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800aea:	75 05                	jne    800af1 <strchr+0x1d>
			return (char *) s;
  800aec:	8b 45 08             	mov    0x8(%ebp),%eax
  800aef:	eb 11                	jmp    800b02 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800af1:	ff 45 08             	incl   0x8(%ebp)
  800af4:	8b 45 08             	mov    0x8(%ebp),%eax
  800af7:	8a 00                	mov    (%eax),%al
  800af9:	84 c0                	test   %al,%al
  800afb:	75 e5                	jne    800ae2 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800afd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b02:	c9                   	leave  
  800b03:	c3                   	ret    

00800b04 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b04:	55                   	push   %ebp
  800b05:	89 e5                	mov    %esp,%ebp
  800b07:	83 ec 04             	sub    $0x4,%esp
  800b0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b10:	eb 0d                	jmp    800b1f <strfind+0x1b>
		if (*s == c)
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	8a 00                	mov    (%eax),%al
  800b17:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b1a:	74 0e                	je     800b2a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b1c:	ff 45 08             	incl   0x8(%ebp)
  800b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b22:	8a 00                	mov    (%eax),%al
  800b24:	84 c0                	test   %al,%al
  800b26:	75 ea                	jne    800b12 <strfind+0xe>
  800b28:	eb 01                	jmp    800b2b <strfind+0x27>
		if (*s == c)
			break;
  800b2a:	90                   	nop
	return (char *) s;
  800b2b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b2e:	c9                   	leave  
  800b2f:	c3                   	ret    

00800b30 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b30:	55                   	push   %ebp
  800b31:	89 e5                	mov    %esp,%ebp
  800b33:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b36:	8b 45 08             	mov    0x8(%ebp),%eax
  800b39:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b3c:	8b 45 10             	mov    0x10(%ebp),%eax
  800b3f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b42:	eb 0e                	jmp    800b52 <memset+0x22>
		*p++ = c;
  800b44:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b47:	8d 50 01             	lea    0x1(%eax),%edx
  800b4a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b4d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b50:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b52:	ff 4d f8             	decl   -0x8(%ebp)
  800b55:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b59:	79 e9                	jns    800b44 <memset+0x14>
		*p++ = c;

	return v;
  800b5b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b5e:	c9                   	leave  
  800b5f:	c3                   	ret    

00800b60 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b60:	55                   	push   %ebp
  800b61:	89 e5                	mov    %esp,%ebp
  800b63:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b69:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b72:	eb 16                	jmp    800b8a <memcpy+0x2a>
		*d++ = *s++;
  800b74:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b77:	8d 50 01             	lea    0x1(%eax),%edx
  800b7a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b7d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b80:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b83:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b86:	8a 12                	mov    (%edx),%dl
  800b88:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b8a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b90:	89 55 10             	mov    %edx,0x10(%ebp)
  800b93:	85 c0                	test   %eax,%eax
  800b95:	75 dd                	jne    800b74 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b97:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b9a:	c9                   	leave  
  800b9b:	c3                   	ret    

00800b9c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b9c:	55                   	push   %ebp
  800b9d:	89 e5                	mov    %esp,%ebp
  800b9f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ba2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ba8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bab:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800bae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bb1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bb4:	73 50                	jae    800c06 <memmove+0x6a>
  800bb6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bb9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbc:	01 d0                	add    %edx,%eax
  800bbe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bc1:	76 43                	jbe    800c06 <memmove+0x6a>
		s += n;
  800bc3:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc6:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800bc9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bcc:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800bcf:	eb 10                	jmp    800be1 <memmove+0x45>
			*--d = *--s;
  800bd1:	ff 4d f8             	decl   -0x8(%ebp)
  800bd4:	ff 4d fc             	decl   -0x4(%ebp)
  800bd7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bda:	8a 10                	mov    (%eax),%dl
  800bdc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bdf:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800be1:	8b 45 10             	mov    0x10(%ebp),%eax
  800be4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800be7:	89 55 10             	mov    %edx,0x10(%ebp)
  800bea:	85 c0                	test   %eax,%eax
  800bec:	75 e3                	jne    800bd1 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bee:	eb 23                	jmp    800c13 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bf0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bf3:	8d 50 01             	lea    0x1(%eax),%edx
  800bf6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bf9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bfc:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bff:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c02:	8a 12                	mov    (%edx),%dl
  800c04:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c06:	8b 45 10             	mov    0x10(%ebp),%eax
  800c09:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c0c:	89 55 10             	mov    %edx,0x10(%ebp)
  800c0f:	85 c0                	test   %eax,%eax
  800c11:	75 dd                	jne    800bf0 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c13:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c16:	c9                   	leave  
  800c17:	c3                   	ret    

00800c18 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c18:	55                   	push   %ebp
  800c19:	89 e5                	mov    %esp,%ebp
  800c1b:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c21:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c27:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c2a:	eb 2a                	jmp    800c56 <memcmp+0x3e>
		if (*s1 != *s2)
  800c2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c2f:	8a 10                	mov    (%eax),%dl
  800c31:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c34:	8a 00                	mov    (%eax),%al
  800c36:	38 c2                	cmp    %al,%dl
  800c38:	74 16                	je     800c50 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c3a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c3d:	8a 00                	mov    (%eax),%al
  800c3f:	0f b6 d0             	movzbl %al,%edx
  800c42:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c45:	8a 00                	mov    (%eax),%al
  800c47:	0f b6 c0             	movzbl %al,%eax
  800c4a:	29 c2                	sub    %eax,%edx
  800c4c:	89 d0                	mov    %edx,%eax
  800c4e:	eb 18                	jmp    800c68 <memcmp+0x50>
		s1++, s2++;
  800c50:	ff 45 fc             	incl   -0x4(%ebp)
  800c53:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c56:	8b 45 10             	mov    0x10(%ebp),%eax
  800c59:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c5c:	89 55 10             	mov    %edx,0x10(%ebp)
  800c5f:	85 c0                	test   %eax,%eax
  800c61:	75 c9                	jne    800c2c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c63:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c68:	c9                   	leave  
  800c69:	c3                   	ret    

00800c6a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c6a:	55                   	push   %ebp
  800c6b:	89 e5                	mov    %esp,%ebp
  800c6d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c70:	8b 55 08             	mov    0x8(%ebp),%edx
  800c73:	8b 45 10             	mov    0x10(%ebp),%eax
  800c76:	01 d0                	add    %edx,%eax
  800c78:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c7b:	eb 15                	jmp    800c92 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c80:	8a 00                	mov    (%eax),%al
  800c82:	0f b6 d0             	movzbl %al,%edx
  800c85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c88:	0f b6 c0             	movzbl %al,%eax
  800c8b:	39 c2                	cmp    %eax,%edx
  800c8d:	74 0d                	je     800c9c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c8f:	ff 45 08             	incl   0x8(%ebp)
  800c92:	8b 45 08             	mov    0x8(%ebp),%eax
  800c95:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c98:	72 e3                	jb     800c7d <memfind+0x13>
  800c9a:	eb 01                	jmp    800c9d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c9c:	90                   	nop
	return (void *) s;
  800c9d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ca0:	c9                   	leave  
  800ca1:	c3                   	ret    

00800ca2 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ca2:	55                   	push   %ebp
  800ca3:	89 e5                	mov    %esp,%ebp
  800ca5:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ca8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800caf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cb6:	eb 03                	jmp    800cbb <strtol+0x19>
		s++;
  800cb8:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbe:	8a 00                	mov    (%eax),%al
  800cc0:	3c 20                	cmp    $0x20,%al
  800cc2:	74 f4                	je     800cb8 <strtol+0x16>
  800cc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc7:	8a 00                	mov    (%eax),%al
  800cc9:	3c 09                	cmp    $0x9,%al
  800ccb:	74 eb                	je     800cb8 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ccd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd0:	8a 00                	mov    (%eax),%al
  800cd2:	3c 2b                	cmp    $0x2b,%al
  800cd4:	75 05                	jne    800cdb <strtol+0x39>
		s++;
  800cd6:	ff 45 08             	incl   0x8(%ebp)
  800cd9:	eb 13                	jmp    800cee <strtol+0x4c>
	else if (*s == '-')
  800cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cde:	8a 00                	mov    (%eax),%al
  800ce0:	3c 2d                	cmp    $0x2d,%al
  800ce2:	75 0a                	jne    800cee <strtol+0x4c>
		s++, neg = 1;
  800ce4:	ff 45 08             	incl   0x8(%ebp)
  800ce7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf2:	74 06                	je     800cfa <strtol+0x58>
  800cf4:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cf8:	75 20                	jne    800d1a <strtol+0x78>
  800cfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfd:	8a 00                	mov    (%eax),%al
  800cff:	3c 30                	cmp    $0x30,%al
  800d01:	75 17                	jne    800d1a <strtol+0x78>
  800d03:	8b 45 08             	mov    0x8(%ebp),%eax
  800d06:	40                   	inc    %eax
  800d07:	8a 00                	mov    (%eax),%al
  800d09:	3c 78                	cmp    $0x78,%al
  800d0b:	75 0d                	jne    800d1a <strtol+0x78>
		s += 2, base = 16;
  800d0d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d11:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d18:	eb 28                	jmp    800d42 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d1a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d1e:	75 15                	jne    800d35 <strtol+0x93>
  800d20:	8b 45 08             	mov    0x8(%ebp),%eax
  800d23:	8a 00                	mov    (%eax),%al
  800d25:	3c 30                	cmp    $0x30,%al
  800d27:	75 0c                	jne    800d35 <strtol+0x93>
		s++, base = 8;
  800d29:	ff 45 08             	incl   0x8(%ebp)
  800d2c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d33:	eb 0d                	jmp    800d42 <strtol+0xa0>
	else if (base == 0)
  800d35:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d39:	75 07                	jne    800d42 <strtol+0xa0>
		base = 10;
  800d3b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d42:	8b 45 08             	mov    0x8(%ebp),%eax
  800d45:	8a 00                	mov    (%eax),%al
  800d47:	3c 2f                	cmp    $0x2f,%al
  800d49:	7e 19                	jle    800d64 <strtol+0xc2>
  800d4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4e:	8a 00                	mov    (%eax),%al
  800d50:	3c 39                	cmp    $0x39,%al
  800d52:	7f 10                	jg     800d64 <strtol+0xc2>
			dig = *s - '0';
  800d54:	8b 45 08             	mov    0x8(%ebp),%eax
  800d57:	8a 00                	mov    (%eax),%al
  800d59:	0f be c0             	movsbl %al,%eax
  800d5c:	83 e8 30             	sub    $0x30,%eax
  800d5f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d62:	eb 42                	jmp    800da6 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d64:	8b 45 08             	mov    0x8(%ebp),%eax
  800d67:	8a 00                	mov    (%eax),%al
  800d69:	3c 60                	cmp    $0x60,%al
  800d6b:	7e 19                	jle    800d86 <strtol+0xe4>
  800d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d70:	8a 00                	mov    (%eax),%al
  800d72:	3c 7a                	cmp    $0x7a,%al
  800d74:	7f 10                	jg     800d86 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d76:	8b 45 08             	mov    0x8(%ebp),%eax
  800d79:	8a 00                	mov    (%eax),%al
  800d7b:	0f be c0             	movsbl %al,%eax
  800d7e:	83 e8 57             	sub    $0x57,%eax
  800d81:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d84:	eb 20                	jmp    800da6 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d86:	8b 45 08             	mov    0x8(%ebp),%eax
  800d89:	8a 00                	mov    (%eax),%al
  800d8b:	3c 40                	cmp    $0x40,%al
  800d8d:	7e 39                	jle    800dc8 <strtol+0x126>
  800d8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d92:	8a 00                	mov    (%eax),%al
  800d94:	3c 5a                	cmp    $0x5a,%al
  800d96:	7f 30                	jg     800dc8 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9b:	8a 00                	mov    (%eax),%al
  800d9d:	0f be c0             	movsbl %al,%eax
  800da0:	83 e8 37             	sub    $0x37,%eax
  800da3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800da6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800da9:	3b 45 10             	cmp    0x10(%ebp),%eax
  800dac:	7d 19                	jge    800dc7 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800dae:	ff 45 08             	incl   0x8(%ebp)
  800db1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db4:	0f af 45 10          	imul   0x10(%ebp),%eax
  800db8:	89 c2                	mov    %eax,%edx
  800dba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dbd:	01 d0                	add    %edx,%eax
  800dbf:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800dc2:	e9 7b ff ff ff       	jmp    800d42 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800dc7:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800dc8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dcc:	74 08                	je     800dd6 <strtol+0x134>
		*endptr = (char *) s;
  800dce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd1:	8b 55 08             	mov    0x8(%ebp),%edx
  800dd4:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800dd6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800dda:	74 07                	je     800de3 <strtol+0x141>
  800ddc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ddf:	f7 d8                	neg    %eax
  800de1:	eb 03                	jmp    800de6 <strtol+0x144>
  800de3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800de6:	c9                   	leave  
  800de7:	c3                   	ret    

00800de8 <ltostr>:

void
ltostr(long value, char *str)
{
  800de8:	55                   	push   %ebp
  800de9:	89 e5                	mov    %esp,%ebp
  800deb:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800df5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800dfc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e00:	79 13                	jns    800e15 <ltostr+0x2d>
	{
		neg = 1;
  800e02:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0c:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e0f:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e12:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e15:	8b 45 08             	mov    0x8(%ebp),%eax
  800e18:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e1d:	99                   	cltd   
  800e1e:	f7 f9                	idiv   %ecx
  800e20:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e23:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e26:	8d 50 01             	lea    0x1(%eax),%edx
  800e29:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e2c:	89 c2                	mov    %eax,%edx
  800e2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e31:	01 d0                	add    %edx,%eax
  800e33:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e36:	83 c2 30             	add    $0x30,%edx
  800e39:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e3b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e3e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e43:	f7 e9                	imul   %ecx
  800e45:	c1 fa 02             	sar    $0x2,%edx
  800e48:	89 c8                	mov    %ecx,%eax
  800e4a:	c1 f8 1f             	sar    $0x1f,%eax
  800e4d:	29 c2                	sub    %eax,%edx
  800e4f:	89 d0                	mov    %edx,%eax
  800e51:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e54:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e57:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e5c:	f7 e9                	imul   %ecx
  800e5e:	c1 fa 02             	sar    $0x2,%edx
  800e61:	89 c8                	mov    %ecx,%eax
  800e63:	c1 f8 1f             	sar    $0x1f,%eax
  800e66:	29 c2                	sub    %eax,%edx
  800e68:	89 d0                	mov    %edx,%eax
  800e6a:	c1 e0 02             	shl    $0x2,%eax
  800e6d:	01 d0                	add    %edx,%eax
  800e6f:	01 c0                	add    %eax,%eax
  800e71:	29 c1                	sub    %eax,%ecx
  800e73:	89 ca                	mov    %ecx,%edx
  800e75:	85 d2                	test   %edx,%edx
  800e77:	75 9c                	jne    800e15 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e79:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e80:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e83:	48                   	dec    %eax
  800e84:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e87:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e8b:	74 3d                	je     800eca <ltostr+0xe2>
		start = 1 ;
  800e8d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e94:	eb 34                	jmp    800eca <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e96:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9c:	01 d0                	add    %edx,%eax
  800e9e:	8a 00                	mov    (%eax),%al
  800ea0:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800ea3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ea6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea9:	01 c2                	add    %eax,%edx
  800eab:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800eae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb1:	01 c8                	add    %ecx,%eax
  800eb3:	8a 00                	mov    (%eax),%al
  800eb5:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800eb7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800eba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebd:	01 c2                	add    %eax,%edx
  800ebf:	8a 45 eb             	mov    -0x15(%ebp),%al
  800ec2:	88 02                	mov    %al,(%edx)
		start++ ;
  800ec4:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800ec7:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800eca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ecd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ed0:	7c c4                	jl     800e96 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800ed2:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ed5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed8:	01 d0                	add    %edx,%eax
  800eda:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800edd:	90                   	nop
  800ede:	c9                   	leave  
  800edf:	c3                   	ret    

00800ee0 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800ee0:	55                   	push   %ebp
  800ee1:	89 e5                	mov    %esp,%ebp
  800ee3:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ee6:	ff 75 08             	pushl  0x8(%ebp)
  800ee9:	e8 54 fa ff ff       	call   800942 <strlen>
  800eee:	83 c4 04             	add    $0x4,%esp
  800ef1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800ef4:	ff 75 0c             	pushl  0xc(%ebp)
  800ef7:	e8 46 fa ff ff       	call   800942 <strlen>
  800efc:	83 c4 04             	add    $0x4,%esp
  800eff:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f02:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f09:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f10:	eb 17                	jmp    800f29 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f12:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f15:	8b 45 10             	mov    0x10(%ebp),%eax
  800f18:	01 c2                	add    %eax,%edx
  800f1a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f20:	01 c8                	add    %ecx,%eax
  800f22:	8a 00                	mov    (%eax),%al
  800f24:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f26:	ff 45 fc             	incl   -0x4(%ebp)
  800f29:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f2c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f2f:	7c e1                	jl     800f12 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f31:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f38:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f3f:	eb 1f                	jmp    800f60 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f41:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f44:	8d 50 01             	lea    0x1(%eax),%edx
  800f47:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f4a:	89 c2                	mov    %eax,%edx
  800f4c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4f:	01 c2                	add    %eax,%edx
  800f51:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f57:	01 c8                	add    %ecx,%eax
  800f59:	8a 00                	mov    (%eax),%al
  800f5b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f5d:	ff 45 f8             	incl   -0x8(%ebp)
  800f60:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f63:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f66:	7c d9                	jl     800f41 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f68:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f6b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6e:	01 d0                	add    %edx,%eax
  800f70:	c6 00 00             	movb   $0x0,(%eax)
}
  800f73:	90                   	nop
  800f74:	c9                   	leave  
  800f75:	c3                   	ret    

00800f76 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f76:	55                   	push   %ebp
  800f77:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f79:	8b 45 14             	mov    0x14(%ebp),%eax
  800f7c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f82:	8b 45 14             	mov    0x14(%ebp),%eax
  800f85:	8b 00                	mov    (%eax),%eax
  800f87:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f8e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f91:	01 d0                	add    %edx,%eax
  800f93:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f99:	eb 0c                	jmp    800fa7 <strsplit+0x31>
			*string++ = 0;
  800f9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9e:	8d 50 01             	lea    0x1(%eax),%edx
  800fa1:	89 55 08             	mov    %edx,0x8(%ebp)
  800fa4:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	8a 00                	mov    (%eax),%al
  800fac:	84 c0                	test   %al,%al
  800fae:	74 18                	je     800fc8 <strsplit+0x52>
  800fb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb3:	8a 00                	mov    (%eax),%al
  800fb5:	0f be c0             	movsbl %al,%eax
  800fb8:	50                   	push   %eax
  800fb9:	ff 75 0c             	pushl  0xc(%ebp)
  800fbc:	e8 13 fb ff ff       	call   800ad4 <strchr>
  800fc1:	83 c4 08             	add    $0x8,%esp
  800fc4:	85 c0                	test   %eax,%eax
  800fc6:	75 d3                	jne    800f9b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800fc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcb:	8a 00                	mov    (%eax),%al
  800fcd:	84 c0                	test   %al,%al
  800fcf:	74 5a                	je     80102b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800fd1:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd4:	8b 00                	mov    (%eax),%eax
  800fd6:	83 f8 0f             	cmp    $0xf,%eax
  800fd9:	75 07                	jne    800fe2 <strsplit+0x6c>
		{
			return 0;
  800fdb:	b8 00 00 00 00       	mov    $0x0,%eax
  800fe0:	eb 66                	jmp    801048 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fe2:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe5:	8b 00                	mov    (%eax),%eax
  800fe7:	8d 48 01             	lea    0x1(%eax),%ecx
  800fea:	8b 55 14             	mov    0x14(%ebp),%edx
  800fed:	89 0a                	mov    %ecx,(%edx)
  800fef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ff6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff9:	01 c2                	add    %eax,%edx
  800ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffe:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801000:	eb 03                	jmp    801005 <strsplit+0x8f>
			string++;
  801002:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801005:	8b 45 08             	mov    0x8(%ebp),%eax
  801008:	8a 00                	mov    (%eax),%al
  80100a:	84 c0                	test   %al,%al
  80100c:	74 8b                	je     800f99 <strsplit+0x23>
  80100e:	8b 45 08             	mov    0x8(%ebp),%eax
  801011:	8a 00                	mov    (%eax),%al
  801013:	0f be c0             	movsbl %al,%eax
  801016:	50                   	push   %eax
  801017:	ff 75 0c             	pushl  0xc(%ebp)
  80101a:	e8 b5 fa ff ff       	call   800ad4 <strchr>
  80101f:	83 c4 08             	add    $0x8,%esp
  801022:	85 c0                	test   %eax,%eax
  801024:	74 dc                	je     801002 <strsplit+0x8c>
			string++;
	}
  801026:	e9 6e ff ff ff       	jmp    800f99 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80102b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80102c:	8b 45 14             	mov    0x14(%ebp),%eax
  80102f:	8b 00                	mov    (%eax),%eax
  801031:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801038:	8b 45 10             	mov    0x10(%ebp),%eax
  80103b:	01 d0                	add    %edx,%eax
  80103d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801043:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801048:	c9                   	leave  
  801049:	c3                   	ret    

0080104a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80104a:	55                   	push   %ebp
  80104b:	89 e5                	mov    %esp,%ebp
  80104d:	57                   	push   %edi
  80104e:	56                   	push   %esi
  80104f:	53                   	push   %ebx
  801050:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801053:	8b 45 08             	mov    0x8(%ebp),%eax
  801056:	8b 55 0c             	mov    0xc(%ebp),%edx
  801059:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80105c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80105f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801062:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801065:	cd 30                	int    $0x30
  801067:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80106a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80106d:	83 c4 10             	add    $0x10,%esp
  801070:	5b                   	pop    %ebx
  801071:	5e                   	pop    %esi
  801072:	5f                   	pop    %edi
  801073:	5d                   	pop    %ebp
  801074:	c3                   	ret    

00801075 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801075:	55                   	push   %ebp
  801076:	89 e5                	mov    %esp,%ebp
  801078:	83 ec 04             	sub    $0x4,%esp
  80107b:	8b 45 10             	mov    0x10(%ebp),%eax
  80107e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801081:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801085:	8b 45 08             	mov    0x8(%ebp),%eax
  801088:	6a 00                	push   $0x0
  80108a:	6a 00                	push   $0x0
  80108c:	52                   	push   %edx
  80108d:	ff 75 0c             	pushl  0xc(%ebp)
  801090:	50                   	push   %eax
  801091:	6a 00                	push   $0x0
  801093:	e8 b2 ff ff ff       	call   80104a <syscall>
  801098:	83 c4 18             	add    $0x18,%esp
}
  80109b:	90                   	nop
  80109c:	c9                   	leave  
  80109d:	c3                   	ret    

0080109e <sys_cgetc>:

int
sys_cgetc(void)
{
  80109e:	55                   	push   %ebp
  80109f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8010a1:	6a 00                	push   $0x0
  8010a3:	6a 00                	push   $0x0
  8010a5:	6a 00                	push   $0x0
  8010a7:	6a 00                	push   $0x0
  8010a9:	6a 00                	push   $0x0
  8010ab:	6a 01                	push   $0x1
  8010ad:	e8 98 ff ff ff       	call   80104a <syscall>
  8010b2:	83 c4 18             	add    $0x18,%esp
}
  8010b5:	c9                   	leave  
  8010b6:	c3                   	ret    

008010b7 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8010b7:	55                   	push   %ebp
  8010b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8010ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bd:	6a 00                	push   $0x0
  8010bf:	6a 00                	push   $0x0
  8010c1:	6a 00                	push   $0x0
  8010c3:	6a 00                	push   $0x0
  8010c5:	50                   	push   %eax
  8010c6:	6a 05                	push   $0x5
  8010c8:	e8 7d ff ff ff       	call   80104a <syscall>
  8010cd:	83 c4 18             	add    $0x18,%esp
}
  8010d0:	c9                   	leave  
  8010d1:	c3                   	ret    

008010d2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010d2:	55                   	push   %ebp
  8010d3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010d5:	6a 00                	push   $0x0
  8010d7:	6a 00                	push   $0x0
  8010d9:	6a 00                	push   $0x0
  8010db:	6a 00                	push   $0x0
  8010dd:	6a 00                	push   $0x0
  8010df:	6a 02                	push   $0x2
  8010e1:	e8 64 ff ff ff       	call   80104a <syscall>
  8010e6:	83 c4 18             	add    $0x18,%esp
}
  8010e9:	c9                   	leave  
  8010ea:	c3                   	ret    

008010eb <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010eb:	55                   	push   %ebp
  8010ec:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010ee:	6a 00                	push   $0x0
  8010f0:	6a 00                	push   $0x0
  8010f2:	6a 00                	push   $0x0
  8010f4:	6a 00                	push   $0x0
  8010f6:	6a 00                	push   $0x0
  8010f8:	6a 03                	push   $0x3
  8010fa:	e8 4b ff ff ff       	call   80104a <syscall>
  8010ff:	83 c4 18             	add    $0x18,%esp
}
  801102:	c9                   	leave  
  801103:	c3                   	ret    

00801104 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801104:	55                   	push   %ebp
  801105:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801107:	6a 00                	push   $0x0
  801109:	6a 00                	push   $0x0
  80110b:	6a 00                	push   $0x0
  80110d:	6a 00                	push   $0x0
  80110f:	6a 00                	push   $0x0
  801111:	6a 04                	push   $0x4
  801113:	e8 32 ff ff ff       	call   80104a <syscall>
  801118:	83 c4 18             	add    $0x18,%esp
}
  80111b:	c9                   	leave  
  80111c:	c3                   	ret    

0080111d <sys_env_exit>:


void sys_env_exit(void)
{
  80111d:	55                   	push   %ebp
  80111e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801120:	6a 00                	push   $0x0
  801122:	6a 00                	push   $0x0
  801124:	6a 00                	push   $0x0
  801126:	6a 00                	push   $0x0
  801128:	6a 00                	push   $0x0
  80112a:	6a 06                	push   $0x6
  80112c:	e8 19 ff ff ff       	call   80104a <syscall>
  801131:	83 c4 18             	add    $0x18,%esp
}
  801134:	90                   	nop
  801135:	c9                   	leave  
  801136:	c3                   	ret    

00801137 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801137:	55                   	push   %ebp
  801138:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80113a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80113d:	8b 45 08             	mov    0x8(%ebp),%eax
  801140:	6a 00                	push   $0x0
  801142:	6a 00                	push   $0x0
  801144:	6a 00                	push   $0x0
  801146:	52                   	push   %edx
  801147:	50                   	push   %eax
  801148:	6a 07                	push   $0x7
  80114a:	e8 fb fe ff ff       	call   80104a <syscall>
  80114f:	83 c4 18             	add    $0x18,%esp
}
  801152:	c9                   	leave  
  801153:	c3                   	ret    

00801154 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801154:	55                   	push   %ebp
  801155:	89 e5                	mov    %esp,%ebp
  801157:	56                   	push   %esi
  801158:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801159:	8b 75 18             	mov    0x18(%ebp),%esi
  80115c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80115f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801162:	8b 55 0c             	mov    0xc(%ebp),%edx
  801165:	8b 45 08             	mov    0x8(%ebp),%eax
  801168:	56                   	push   %esi
  801169:	53                   	push   %ebx
  80116a:	51                   	push   %ecx
  80116b:	52                   	push   %edx
  80116c:	50                   	push   %eax
  80116d:	6a 08                	push   $0x8
  80116f:	e8 d6 fe ff ff       	call   80104a <syscall>
  801174:	83 c4 18             	add    $0x18,%esp
}
  801177:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80117a:	5b                   	pop    %ebx
  80117b:	5e                   	pop    %esi
  80117c:	5d                   	pop    %ebp
  80117d:	c3                   	ret    

0080117e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80117e:	55                   	push   %ebp
  80117f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801181:	8b 55 0c             	mov    0xc(%ebp),%edx
  801184:	8b 45 08             	mov    0x8(%ebp),%eax
  801187:	6a 00                	push   $0x0
  801189:	6a 00                	push   $0x0
  80118b:	6a 00                	push   $0x0
  80118d:	52                   	push   %edx
  80118e:	50                   	push   %eax
  80118f:	6a 09                	push   $0x9
  801191:	e8 b4 fe ff ff       	call   80104a <syscall>
  801196:	83 c4 18             	add    $0x18,%esp
}
  801199:	c9                   	leave  
  80119a:	c3                   	ret    

0080119b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80119b:	55                   	push   %ebp
  80119c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80119e:	6a 00                	push   $0x0
  8011a0:	6a 00                	push   $0x0
  8011a2:	6a 00                	push   $0x0
  8011a4:	ff 75 0c             	pushl  0xc(%ebp)
  8011a7:	ff 75 08             	pushl  0x8(%ebp)
  8011aa:	6a 0a                	push   $0xa
  8011ac:	e8 99 fe ff ff       	call   80104a <syscall>
  8011b1:	83 c4 18             	add    $0x18,%esp
}
  8011b4:	c9                   	leave  
  8011b5:	c3                   	ret    

008011b6 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8011b6:	55                   	push   %ebp
  8011b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8011b9:	6a 00                	push   $0x0
  8011bb:	6a 00                	push   $0x0
  8011bd:	6a 00                	push   $0x0
  8011bf:	6a 00                	push   $0x0
  8011c1:	6a 00                	push   $0x0
  8011c3:	6a 0b                	push   $0xb
  8011c5:	e8 80 fe ff ff       	call   80104a <syscall>
  8011ca:	83 c4 18             	add    $0x18,%esp
}
  8011cd:	c9                   	leave  
  8011ce:	c3                   	ret    

008011cf <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011cf:	55                   	push   %ebp
  8011d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011d2:	6a 00                	push   $0x0
  8011d4:	6a 00                	push   $0x0
  8011d6:	6a 00                	push   $0x0
  8011d8:	6a 00                	push   $0x0
  8011da:	6a 00                	push   $0x0
  8011dc:	6a 0c                	push   $0xc
  8011de:	e8 67 fe ff ff       	call   80104a <syscall>
  8011e3:	83 c4 18             	add    $0x18,%esp
}
  8011e6:	c9                   	leave  
  8011e7:	c3                   	ret    

008011e8 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011e8:	55                   	push   %ebp
  8011e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011eb:	6a 00                	push   $0x0
  8011ed:	6a 00                	push   $0x0
  8011ef:	6a 00                	push   $0x0
  8011f1:	6a 00                	push   $0x0
  8011f3:	6a 00                	push   $0x0
  8011f5:	6a 0d                	push   $0xd
  8011f7:	e8 4e fe ff ff       	call   80104a <syscall>
  8011fc:	83 c4 18             	add    $0x18,%esp
}
  8011ff:	c9                   	leave  
  801200:	c3                   	ret    

00801201 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801201:	55                   	push   %ebp
  801202:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801204:	6a 00                	push   $0x0
  801206:	6a 00                	push   $0x0
  801208:	6a 00                	push   $0x0
  80120a:	ff 75 0c             	pushl  0xc(%ebp)
  80120d:	ff 75 08             	pushl  0x8(%ebp)
  801210:	6a 11                	push   $0x11
  801212:	e8 33 fe ff ff       	call   80104a <syscall>
  801217:	83 c4 18             	add    $0x18,%esp
	return;
  80121a:	90                   	nop
}
  80121b:	c9                   	leave  
  80121c:	c3                   	ret    

0080121d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80121d:	55                   	push   %ebp
  80121e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801220:	6a 00                	push   $0x0
  801222:	6a 00                	push   $0x0
  801224:	6a 00                	push   $0x0
  801226:	ff 75 0c             	pushl  0xc(%ebp)
  801229:	ff 75 08             	pushl  0x8(%ebp)
  80122c:	6a 12                	push   $0x12
  80122e:	e8 17 fe ff ff       	call   80104a <syscall>
  801233:	83 c4 18             	add    $0x18,%esp
	return ;
  801236:	90                   	nop
}
  801237:	c9                   	leave  
  801238:	c3                   	ret    

00801239 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801239:	55                   	push   %ebp
  80123a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80123c:	6a 00                	push   $0x0
  80123e:	6a 00                	push   $0x0
  801240:	6a 00                	push   $0x0
  801242:	6a 00                	push   $0x0
  801244:	6a 00                	push   $0x0
  801246:	6a 0e                	push   $0xe
  801248:	e8 fd fd ff ff       	call   80104a <syscall>
  80124d:	83 c4 18             	add    $0x18,%esp
}
  801250:	c9                   	leave  
  801251:	c3                   	ret    

00801252 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801252:	55                   	push   %ebp
  801253:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801255:	6a 00                	push   $0x0
  801257:	6a 00                	push   $0x0
  801259:	6a 00                	push   $0x0
  80125b:	6a 00                	push   $0x0
  80125d:	ff 75 08             	pushl  0x8(%ebp)
  801260:	6a 0f                	push   $0xf
  801262:	e8 e3 fd ff ff       	call   80104a <syscall>
  801267:	83 c4 18             	add    $0x18,%esp
}
  80126a:	c9                   	leave  
  80126b:	c3                   	ret    

0080126c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80126c:	55                   	push   %ebp
  80126d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80126f:	6a 00                	push   $0x0
  801271:	6a 00                	push   $0x0
  801273:	6a 00                	push   $0x0
  801275:	6a 00                	push   $0x0
  801277:	6a 00                	push   $0x0
  801279:	6a 10                	push   $0x10
  80127b:	e8 ca fd ff ff       	call   80104a <syscall>
  801280:	83 c4 18             	add    $0x18,%esp
}
  801283:	90                   	nop
  801284:	c9                   	leave  
  801285:	c3                   	ret    

00801286 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801286:	55                   	push   %ebp
  801287:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801289:	6a 00                	push   $0x0
  80128b:	6a 00                	push   $0x0
  80128d:	6a 00                	push   $0x0
  80128f:	6a 00                	push   $0x0
  801291:	6a 00                	push   $0x0
  801293:	6a 14                	push   $0x14
  801295:	e8 b0 fd ff ff       	call   80104a <syscall>
  80129a:	83 c4 18             	add    $0x18,%esp
}
  80129d:	90                   	nop
  80129e:	c9                   	leave  
  80129f:	c3                   	ret    

008012a0 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8012a0:	55                   	push   %ebp
  8012a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8012a3:	6a 00                	push   $0x0
  8012a5:	6a 00                	push   $0x0
  8012a7:	6a 00                	push   $0x0
  8012a9:	6a 00                	push   $0x0
  8012ab:	6a 00                	push   $0x0
  8012ad:	6a 15                	push   $0x15
  8012af:	e8 96 fd ff ff       	call   80104a <syscall>
  8012b4:	83 c4 18             	add    $0x18,%esp
}
  8012b7:	90                   	nop
  8012b8:	c9                   	leave  
  8012b9:	c3                   	ret    

008012ba <sys_cputc>:


void
sys_cputc(const char c)
{
  8012ba:	55                   	push   %ebp
  8012bb:	89 e5                	mov    %esp,%ebp
  8012bd:	83 ec 04             	sub    $0x4,%esp
  8012c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8012c6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012ca:	6a 00                	push   $0x0
  8012cc:	6a 00                	push   $0x0
  8012ce:	6a 00                	push   $0x0
  8012d0:	6a 00                	push   $0x0
  8012d2:	50                   	push   %eax
  8012d3:	6a 16                	push   $0x16
  8012d5:	e8 70 fd ff ff       	call   80104a <syscall>
  8012da:	83 c4 18             	add    $0x18,%esp
}
  8012dd:	90                   	nop
  8012de:	c9                   	leave  
  8012df:	c3                   	ret    

008012e0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012e0:	55                   	push   %ebp
  8012e1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012e3:	6a 00                	push   $0x0
  8012e5:	6a 00                	push   $0x0
  8012e7:	6a 00                	push   $0x0
  8012e9:	6a 00                	push   $0x0
  8012eb:	6a 00                	push   $0x0
  8012ed:	6a 17                	push   $0x17
  8012ef:	e8 56 fd ff ff       	call   80104a <syscall>
  8012f4:	83 c4 18             	add    $0x18,%esp
}
  8012f7:	90                   	nop
  8012f8:	c9                   	leave  
  8012f9:	c3                   	ret    

008012fa <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012fa:	55                   	push   %ebp
  8012fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801300:	6a 00                	push   $0x0
  801302:	6a 00                	push   $0x0
  801304:	6a 00                	push   $0x0
  801306:	ff 75 0c             	pushl  0xc(%ebp)
  801309:	50                   	push   %eax
  80130a:	6a 18                	push   $0x18
  80130c:	e8 39 fd ff ff       	call   80104a <syscall>
  801311:	83 c4 18             	add    $0x18,%esp
}
  801314:	c9                   	leave  
  801315:	c3                   	ret    

00801316 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801316:	55                   	push   %ebp
  801317:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801319:	8b 55 0c             	mov    0xc(%ebp),%edx
  80131c:	8b 45 08             	mov    0x8(%ebp),%eax
  80131f:	6a 00                	push   $0x0
  801321:	6a 00                	push   $0x0
  801323:	6a 00                	push   $0x0
  801325:	52                   	push   %edx
  801326:	50                   	push   %eax
  801327:	6a 1b                	push   $0x1b
  801329:	e8 1c fd ff ff       	call   80104a <syscall>
  80132e:	83 c4 18             	add    $0x18,%esp
}
  801331:	c9                   	leave  
  801332:	c3                   	ret    

00801333 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801333:	55                   	push   %ebp
  801334:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801336:	8b 55 0c             	mov    0xc(%ebp),%edx
  801339:	8b 45 08             	mov    0x8(%ebp),%eax
  80133c:	6a 00                	push   $0x0
  80133e:	6a 00                	push   $0x0
  801340:	6a 00                	push   $0x0
  801342:	52                   	push   %edx
  801343:	50                   	push   %eax
  801344:	6a 19                	push   $0x19
  801346:	e8 ff fc ff ff       	call   80104a <syscall>
  80134b:	83 c4 18             	add    $0x18,%esp
}
  80134e:	90                   	nop
  80134f:	c9                   	leave  
  801350:	c3                   	ret    

00801351 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801351:	55                   	push   %ebp
  801352:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801354:	8b 55 0c             	mov    0xc(%ebp),%edx
  801357:	8b 45 08             	mov    0x8(%ebp),%eax
  80135a:	6a 00                	push   $0x0
  80135c:	6a 00                	push   $0x0
  80135e:	6a 00                	push   $0x0
  801360:	52                   	push   %edx
  801361:	50                   	push   %eax
  801362:	6a 1a                	push   $0x1a
  801364:	e8 e1 fc ff ff       	call   80104a <syscall>
  801369:	83 c4 18             	add    $0x18,%esp
}
  80136c:	90                   	nop
  80136d:	c9                   	leave  
  80136e:	c3                   	ret    

0080136f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80136f:	55                   	push   %ebp
  801370:	89 e5                	mov    %esp,%ebp
  801372:	83 ec 04             	sub    $0x4,%esp
  801375:	8b 45 10             	mov    0x10(%ebp),%eax
  801378:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80137b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80137e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801382:	8b 45 08             	mov    0x8(%ebp),%eax
  801385:	6a 00                	push   $0x0
  801387:	51                   	push   %ecx
  801388:	52                   	push   %edx
  801389:	ff 75 0c             	pushl  0xc(%ebp)
  80138c:	50                   	push   %eax
  80138d:	6a 1c                	push   $0x1c
  80138f:	e8 b6 fc ff ff       	call   80104a <syscall>
  801394:	83 c4 18             	add    $0x18,%esp
}
  801397:	c9                   	leave  
  801398:	c3                   	ret    

00801399 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801399:	55                   	push   %ebp
  80139a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80139c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80139f:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a2:	6a 00                	push   $0x0
  8013a4:	6a 00                	push   $0x0
  8013a6:	6a 00                	push   $0x0
  8013a8:	52                   	push   %edx
  8013a9:	50                   	push   %eax
  8013aa:	6a 1d                	push   $0x1d
  8013ac:	e8 99 fc ff ff       	call   80104a <syscall>
  8013b1:	83 c4 18             	add    $0x18,%esp
}
  8013b4:	c9                   	leave  
  8013b5:	c3                   	ret    

008013b6 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8013b6:	55                   	push   %ebp
  8013b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8013b9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c2:	6a 00                	push   $0x0
  8013c4:	6a 00                	push   $0x0
  8013c6:	51                   	push   %ecx
  8013c7:	52                   	push   %edx
  8013c8:	50                   	push   %eax
  8013c9:	6a 1e                	push   $0x1e
  8013cb:	e8 7a fc ff ff       	call   80104a <syscall>
  8013d0:	83 c4 18             	add    $0x18,%esp
}
  8013d3:	c9                   	leave  
  8013d4:	c3                   	ret    

008013d5 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013d5:	55                   	push   %ebp
  8013d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013db:	8b 45 08             	mov    0x8(%ebp),%eax
  8013de:	6a 00                	push   $0x0
  8013e0:	6a 00                	push   $0x0
  8013e2:	6a 00                	push   $0x0
  8013e4:	52                   	push   %edx
  8013e5:	50                   	push   %eax
  8013e6:	6a 1f                	push   $0x1f
  8013e8:	e8 5d fc ff ff       	call   80104a <syscall>
  8013ed:	83 c4 18             	add    $0x18,%esp
}
  8013f0:	c9                   	leave  
  8013f1:	c3                   	ret    

008013f2 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013f2:	55                   	push   %ebp
  8013f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013f5:	6a 00                	push   $0x0
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 20                	push   $0x20
  801401:	e8 44 fc ff ff       	call   80104a <syscall>
  801406:	83 c4 18             	add    $0x18,%esp
}
  801409:	c9                   	leave  
  80140a:	c3                   	ret    

0080140b <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80140b:	55                   	push   %ebp
  80140c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80140e:	8b 45 08             	mov    0x8(%ebp),%eax
  801411:	6a 00                	push   $0x0
  801413:	ff 75 14             	pushl  0x14(%ebp)
  801416:	ff 75 10             	pushl  0x10(%ebp)
  801419:	ff 75 0c             	pushl  0xc(%ebp)
  80141c:	50                   	push   %eax
  80141d:	6a 21                	push   $0x21
  80141f:	e8 26 fc ff ff       	call   80104a <syscall>
  801424:	83 c4 18             	add    $0x18,%esp
}
  801427:	c9                   	leave  
  801428:	c3                   	ret    

00801429 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801429:	55                   	push   %ebp
  80142a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80142c:	8b 45 08             	mov    0x8(%ebp),%eax
  80142f:	6a 00                	push   $0x0
  801431:	6a 00                	push   $0x0
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	50                   	push   %eax
  801438:	6a 22                	push   $0x22
  80143a:	e8 0b fc ff ff       	call   80104a <syscall>
  80143f:	83 c4 18             	add    $0x18,%esp
}
  801442:	90                   	nop
  801443:	c9                   	leave  
  801444:	c3                   	ret    

00801445 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801445:	55                   	push   %ebp
  801446:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801448:	8b 45 08             	mov    0x8(%ebp),%eax
  80144b:	6a 00                	push   $0x0
  80144d:	6a 00                	push   $0x0
  80144f:	6a 00                	push   $0x0
  801451:	6a 00                	push   $0x0
  801453:	50                   	push   %eax
  801454:	6a 23                	push   $0x23
  801456:	e8 ef fb ff ff       	call   80104a <syscall>
  80145b:	83 c4 18             	add    $0x18,%esp
}
  80145e:	90                   	nop
  80145f:	c9                   	leave  
  801460:	c3                   	ret    

00801461 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801461:	55                   	push   %ebp
  801462:	89 e5                	mov    %esp,%ebp
  801464:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801467:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80146a:	8d 50 04             	lea    0x4(%eax),%edx
  80146d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801470:	6a 00                	push   $0x0
  801472:	6a 00                	push   $0x0
  801474:	6a 00                	push   $0x0
  801476:	52                   	push   %edx
  801477:	50                   	push   %eax
  801478:	6a 24                	push   $0x24
  80147a:	e8 cb fb ff ff       	call   80104a <syscall>
  80147f:	83 c4 18             	add    $0x18,%esp
	return result;
  801482:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801485:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801488:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80148b:	89 01                	mov    %eax,(%ecx)
  80148d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801490:	8b 45 08             	mov    0x8(%ebp),%eax
  801493:	c9                   	leave  
  801494:	c2 04 00             	ret    $0x4

00801497 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801497:	55                   	push   %ebp
  801498:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80149a:	6a 00                	push   $0x0
  80149c:	6a 00                	push   $0x0
  80149e:	ff 75 10             	pushl  0x10(%ebp)
  8014a1:	ff 75 0c             	pushl  0xc(%ebp)
  8014a4:	ff 75 08             	pushl  0x8(%ebp)
  8014a7:	6a 13                	push   $0x13
  8014a9:	e8 9c fb ff ff       	call   80104a <syscall>
  8014ae:	83 c4 18             	add    $0x18,%esp
	return ;
  8014b1:	90                   	nop
}
  8014b2:	c9                   	leave  
  8014b3:	c3                   	ret    

008014b4 <sys_rcr2>:
uint32 sys_rcr2()
{
  8014b4:	55                   	push   %ebp
  8014b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 25                	push   $0x25
  8014c3:	e8 82 fb ff ff       	call   80104a <syscall>
  8014c8:	83 c4 18             	add    $0x18,%esp
}
  8014cb:	c9                   	leave  
  8014cc:	c3                   	ret    

008014cd <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014cd:	55                   	push   %ebp
  8014ce:	89 e5                	mov    %esp,%ebp
  8014d0:	83 ec 04             	sub    $0x4,%esp
  8014d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014d9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	6a 00                	push   $0x0
  8014e5:	50                   	push   %eax
  8014e6:	6a 26                	push   $0x26
  8014e8:	e8 5d fb ff ff       	call   80104a <syscall>
  8014ed:	83 c4 18             	add    $0x18,%esp
	return ;
  8014f0:	90                   	nop
}
  8014f1:	c9                   	leave  
  8014f2:	c3                   	ret    

008014f3 <rsttst>:
void rsttst()
{
  8014f3:	55                   	push   %ebp
  8014f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 00                	push   $0x0
  801500:	6a 28                	push   $0x28
  801502:	e8 43 fb ff ff       	call   80104a <syscall>
  801507:	83 c4 18             	add    $0x18,%esp
	return ;
  80150a:	90                   	nop
}
  80150b:	c9                   	leave  
  80150c:	c3                   	ret    

0080150d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80150d:	55                   	push   %ebp
  80150e:	89 e5                	mov    %esp,%ebp
  801510:	83 ec 04             	sub    $0x4,%esp
  801513:	8b 45 14             	mov    0x14(%ebp),%eax
  801516:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801519:	8b 55 18             	mov    0x18(%ebp),%edx
  80151c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801520:	52                   	push   %edx
  801521:	50                   	push   %eax
  801522:	ff 75 10             	pushl  0x10(%ebp)
  801525:	ff 75 0c             	pushl  0xc(%ebp)
  801528:	ff 75 08             	pushl  0x8(%ebp)
  80152b:	6a 27                	push   $0x27
  80152d:	e8 18 fb ff ff       	call   80104a <syscall>
  801532:	83 c4 18             	add    $0x18,%esp
	return ;
  801535:	90                   	nop
}
  801536:	c9                   	leave  
  801537:	c3                   	ret    

00801538 <chktst>:
void chktst(uint32 n)
{
  801538:	55                   	push   %ebp
  801539:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80153b:	6a 00                	push   $0x0
  80153d:	6a 00                	push   $0x0
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	ff 75 08             	pushl  0x8(%ebp)
  801546:	6a 29                	push   $0x29
  801548:	e8 fd fa ff ff       	call   80104a <syscall>
  80154d:	83 c4 18             	add    $0x18,%esp
	return ;
  801550:	90                   	nop
}
  801551:	c9                   	leave  
  801552:	c3                   	ret    

00801553 <inctst>:

void inctst()
{
  801553:	55                   	push   %ebp
  801554:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 00                	push   $0x0
  80155e:	6a 00                	push   $0x0
  801560:	6a 2a                	push   $0x2a
  801562:	e8 e3 fa ff ff       	call   80104a <syscall>
  801567:	83 c4 18             	add    $0x18,%esp
	return ;
  80156a:	90                   	nop
}
  80156b:	c9                   	leave  
  80156c:	c3                   	ret    

0080156d <gettst>:
uint32 gettst()
{
  80156d:	55                   	push   %ebp
  80156e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801570:	6a 00                	push   $0x0
  801572:	6a 00                	push   $0x0
  801574:	6a 00                	push   $0x0
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 2b                	push   $0x2b
  80157c:	e8 c9 fa ff ff       	call   80104a <syscall>
  801581:	83 c4 18             	add    $0x18,%esp
}
  801584:	c9                   	leave  
  801585:	c3                   	ret    

00801586 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801586:	55                   	push   %ebp
  801587:	89 e5                	mov    %esp,%ebp
  801589:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 2c                	push   $0x2c
  801598:	e8 ad fa ff ff       	call   80104a <syscall>
  80159d:	83 c4 18             	add    $0x18,%esp
  8015a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8015a3:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8015a7:	75 07                	jne    8015b0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8015a9:	b8 01 00 00 00       	mov    $0x1,%eax
  8015ae:	eb 05                	jmp    8015b5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8015b0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015b5:	c9                   	leave  
  8015b6:	c3                   	ret    

008015b7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8015b7:	55                   	push   %ebp
  8015b8:	89 e5                	mov    %esp,%ebp
  8015ba:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	6a 2c                	push   $0x2c
  8015c9:	e8 7c fa ff ff       	call   80104a <syscall>
  8015ce:	83 c4 18             	add    $0x18,%esp
  8015d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015d4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015d8:	75 07                	jne    8015e1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015da:	b8 01 00 00 00       	mov    $0x1,%eax
  8015df:	eb 05                	jmp    8015e6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015e1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015e6:	c9                   	leave  
  8015e7:	c3                   	ret    

008015e8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015e8:	55                   	push   %ebp
  8015e9:	89 e5                	mov    %esp,%ebp
  8015eb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 2c                	push   $0x2c
  8015fa:	e8 4b fa ff ff       	call   80104a <syscall>
  8015ff:	83 c4 18             	add    $0x18,%esp
  801602:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801605:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801609:	75 07                	jne    801612 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80160b:	b8 01 00 00 00       	mov    $0x1,%eax
  801610:	eb 05                	jmp    801617 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801612:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801617:	c9                   	leave  
  801618:	c3                   	ret    

00801619 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801619:	55                   	push   %ebp
  80161a:	89 e5                	mov    %esp,%ebp
  80161c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80161f:	6a 00                	push   $0x0
  801621:	6a 00                	push   $0x0
  801623:	6a 00                	push   $0x0
  801625:	6a 00                	push   $0x0
  801627:	6a 00                	push   $0x0
  801629:	6a 2c                	push   $0x2c
  80162b:	e8 1a fa ff ff       	call   80104a <syscall>
  801630:	83 c4 18             	add    $0x18,%esp
  801633:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801636:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80163a:	75 07                	jne    801643 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80163c:	b8 01 00 00 00       	mov    $0x1,%eax
  801641:	eb 05                	jmp    801648 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801643:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801648:	c9                   	leave  
  801649:	c3                   	ret    

0080164a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80164a:	55                   	push   %ebp
  80164b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	6a 00                	push   $0x0
  801655:	ff 75 08             	pushl  0x8(%ebp)
  801658:	6a 2d                	push   $0x2d
  80165a:	e8 eb f9 ff ff       	call   80104a <syscall>
  80165f:	83 c4 18             	add    $0x18,%esp
	return ;
  801662:	90                   	nop
}
  801663:	c9                   	leave  
  801664:	c3                   	ret    

00801665 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801665:	55                   	push   %ebp
  801666:	89 e5                	mov    %esp,%ebp
  801668:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801669:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80166c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80166f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801672:	8b 45 08             	mov    0x8(%ebp),%eax
  801675:	6a 00                	push   $0x0
  801677:	53                   	push   %ebx
  801678:	51                   	push   %ecx
  801679:	52                   	push   %edx
  80167a:	50                   	push   %eax
  80167b:	6a 2e                	push   $0x2e
  80167d:	e8 c8 f9 ff ff       	call   80104a <syscall>
  801682:	83 c4 18             	add    $0x18,%esp
}
  801685:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801688:	c9                   	leave  
  801689:	c3                   	ret    

0080168a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80168a:	55                   	push   %ebp
  80168b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80168d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801690:	8b 45 08             	mov    0x8(%ebp),%eax
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	6a 00                	push   $0x0
  801699:	52                   	push   %edx
  80169a:	50                   	push   %eax
  80169b:	6a 2f                	push   $0x2f
  80169d:	e8 a8 f9 ff ff       	call   80104a <syscall>
  8016a2:	83 c4 18             	add    $0x18,%esp
}
  8016a5:	c9                   	leave  
  8016a6:	c3                   	ret    

008016a7 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8016a7:	55                   	push   %ebp
  8016a8:	89 e5                	mov    %esp,%ebp
  8016aa:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8016ad:	8b 55 08             	mov    0x8(%ebp),%edx
  8016b0:	89 d0                	mov    %edx,%eax
  8016b2:	c1 e0 02             	shl    $0x2,%eax
  8016b5:	01 d0                	add    %edx,%eax
  8016b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016be:	01 d0                	add    %edx,%eax
  8016c0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016c7:	01 d0                	add    %edx,%eax
  8016c9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016d0:	01 d0                	add    %edx,%eax
  8016d2:	c1 e0 04             	shl    $0x4,%eax
  8016d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8016d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8016df:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8016e2:	83 ec 0c             	sub    $0xc,%esp
  8016e5:	50                   	push   %eax
  8016e6:	e8 76 fd ff ff       	call   801461 <sys_get_virtual_time>
  8016eb:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8016ee:	eb 41                	jmp    801731 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8016f0:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8016f3:	83 ec 0c             	sub    $0xc,%esp
  8016f6:	50                   	push   %eax
  8016f7:	e8 65 fd ff ff       	call   801461 <sys_get_virtual_time>
  8016fc:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8016ff:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801702:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801705:	29 c2                	sub    %eax,%edx
  801707:	89 d0                	mov    %edx,%eax
  801709:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  80170c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80170f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801712:	89 d1                	mov    %edx,%ecx
  801714:	29 c1                	sub    %eax,%ecx
  801716:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801719:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80171c:	39 c2                	cmp    %eax,%edx
  80171e:	0f 97 c0             	seta   %al
  801721:	0f b6 c0             	movzbl %al,%eax
  801724:	29 c1                	sub    %eax,%ecx
  801726:	89 c8                	mov    %ecx,%eax
  801728:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  80172b:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80172e:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801731:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801734:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801737:	72 b7                	jb     8016f0 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801739:	90                   	nop
  80173a:	c9                   	leave  
  80173b:	c3                   	ret    

0080173c <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  80173c:	55                   	push   %ebp
  80173d:	89 e5                	mov    %esp,%ebp
  80173f:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801742:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801749:	eb 03                	jmp    80174e <busy_wait+0x12>
  80174b:	ff 45 fc             	incl   -0x4(%ebp)
  80174e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801751:	3b 45 08             	cmp    0x8(%ebp),%eax
  801754:	72 f5                	jb     80174b <busy_wait+0xf>
	return i;
  801756:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801759:	c9                   	leave  
  80175a:	c3                   	ret    
  80175b:	90                   	nop

0080175c <__udivdi3>:
  80175c:	55                   	push   %ebp
  80175d:	57                   	push   %edi
  80175e:	56                   	push   %esi
  80175f:	53                   	push   %ebx
  801760:	83 ec 1c             	sub    $0x1c,%esp
  801763:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801767:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80176b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80176f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801773:	89 ca                	mov    %ecx,%edx
  801775:	89 f8                	mov    %edi,%eax
  801777:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80177b:	85 f6                	test   %esi,%esi
  80177d:	75 2d                	jne    8017ac <__udivdi3+0x50>
  80177f:	39 cf                	cmp    %ecx,%edi
  801781:	77 65                	ja     8017e8 <__udivdi3+0x8c>
  801783:	89 fd                	mov    %edi,%ebp
  801785:	85 ff                	test   %edi,%edi
  801787:	75 0b                	jne    801794 <__udivdi3+0x38>
  801789:	b8 01 00 00 00       	mov    $0x1,%eax
  80178e:	31 d2                	xor    %edx,%edx
  801790:	f7 f7                	div    %edi
  801792:	89 c5                	mov    %eax,%ebp
  801794:	31 d2                	xor    %edx,%edx
  801796:	89 c8                	mov    %ecx,%eax
  801798:	f7 f5                	div    %ebp
  80179a:	89 c1                	mov    %eax,%ecx
  80179c:	89 d8                	mov    %ebx,%eax
  80179e:	f7 f5                	div    %ebp
  8017a0:	89 cf                	mov    %ecx,%edi
  8017a2:	89 fa                	mov    %edi,%edx
  8017a4:	83 c4 1c             	add    $0x1c,%esp
  8017a7:	5b                   	pop    %ebx
  8017a8:	5e                   	pop    %esi
  8017a9:	5f                   	pop    %edi
  8017aa:	5d                   	pop    %ebp
  8017ab:	c3                   	ret    
  8017ac:	39 ce                	cmp    %ecx,%esi
  8017ae:	77 28                	ja     8017d8 <__udivdi3+0x7c>
  8017b0:	0f bd fe             	bsr    %esi,%edi
  8017b3:	83 f7 1f             	xor    $0x1f,%edi
  8017b6:	75 40                	jne    8017f8 <__udivdi3+0x9c>
  8017b8:	39 ce                	cmp    %ecx,%esi
  8017ba:	72 0a                	jb     8017c6 <__udivdi3+0x6a>
  8017bc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8017c0:	0f 87 9e 00 00 00    	ja     801864 <__udivdi3+0x108>
  8017c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8017cb:	89 fa                	mov    %edi,%edx
  8017cd:	83 c4 1c             	add    $0x1c,%esp
  8017d0:	5b                   	pop    %ebx
  8017d1:	5e                   	pop    %esi
  8017d2:	5f                   	pop    %edi
  8017d3:	5d                   	pop    %ebp
  8017d4:	c3                   	ret    
  8017d5:	8d 76 00             	lea    0x0(%esi),%esi
  8017d8:	31 ff                	xor    %edi,%edi
  8017da:	31 c0                	xor    %eax,%eax
  8017dc:	89 fa                	mov    %edi,%edx
  8017de:	83 c4 1c             	add    $0x1c,%esp
  8017e1:	5b                   	pop    %ebx
  8017e2:	5e                   	pop    %esi
  8017e3:	5f                   	pop    %edi
  8017e4:	5d                   	pop    %ebp
  8017e5:	c3                   	ret    
  8017e6:	66 90                	xchg   %ax,%ax
  8017e8:	89 d8                	mov    %ebx,%eax
  8017ea:	f7 f7                	div    %edi
  8017ec:	31 ff                	xor    %edi,%edi
  8017ee:	89 fa                	mov    %edi,%edx
  8017f0:	83 c4 1c             	add    $0x1c,%esp
  8017f3:	5b                   	pop    %ebx
  8017f4:	5e                   	pop    %esi
  8017f5:	5f                   	pop    %edi
  8017f6:	5d                   	pop    %ebp
  8017f7:	c3                   	ret    
  8017f8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8017fd:	89 eb                	mov    %ebp,%ebx
  8017ff:	29 fb                	sub    %edi,%ebx
  801801:	89 f9                	mov    %edi,%ecx
  801803:	d3 e6                	shl    %cl,%esi
  801805:	89 c5                	mov    %eax,%ebp
  801807:	88 d9                	mov    %bl,%cl
  801809:	d3 ed                	shr    %cl,%ebp
  80180b:	89 e9                	mov    %ebp,%ecx
  80180d:	09 f1                	or     %esi,%ecx
  80180f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801813:	89 f9                	mov    %edi,%ecx
  801815:	d3 e0                	shl    %cl,%eax
  801817:	89 c5                	mov    %eax,%ebp
  801819:	89 d6                	mov    %edx,%esi
  80181b:	88 d9                	mov    %bl,%cl
  80181d:	d3 ee                	shr    %cl,%esi
  80181f:	89 f9                	mov    %edi,%ecx
  801821:	d3 e2                	shl    %cl,%edx
  801823:	8b 44 24 08          	mov    0x8(%esp),%eax
  801827:	88 d9                	mov    %bl,%cl
  801829:	d3 e8                	shr    %cl,%eax
  80182b:	09 c2                	or     %eax,%edx
  80182d:	89 d0                	mov    %edx,%eax
  80182f:	89 f2                	mov    %esi,%edx
  801831:	f7 74 24 0c          	divl   0xc(%esp)
  801835:	89 d6                	mov    %edx,%esi
  801837:	89 c3                	mov    %eax,%ebx
  801839:	f7 e5                	mul    %ebp
  80183b:	39 d6                	cmp    %edx,%esi
  80183d:	72 19                	jb     801858 <__udivdi3+0xfc>
  80183f:	74 0b                	je     80184c <__udivdi3+0xf0>
  801841:	89 d8                	mov    %ebx,%eax
  801843:	31 ff                	xor    %edi,%edi
  801845:	e9 58 ff ff ff       	jmp    8017a2 <__udivdi3+0x46>
  80184a:	66 90                	xchg   %ax,%ax
  80184c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801850:	89 f9                	mov    %edi,%ecx
  801852:	d3 e2                	shl    %cl,%edx
  801854:	39 c2                	cmp    %eax,%edx
  801856:	73 e9                	jae    801841 <__udivdi3+0xe5>
  801858:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80185b:	31 ff                	xor    %edi,%edi
  80185d:	e9 40 ff ff ff       	jmp    8017a2 <__udivdi3+0x46>
  801862:	66 90                	xchg   %ax,%ax
  801864:	31 c0                	xor    %eax,%eax
  801866:	e9 37 ff ff ff       	jmp    8017a2 <__udivdi3+0x46>
  80186b:	90                   	nop

0080186c <__umoddi3>:
  80186c:	55                   	push   %ebp
  80186d:	57                   	push   %edi
  80186e:	56                   	push   %esi
  80186f:	53                   	push   %ebx
  801870:	83 ec 1c             	sub    $0x1c,%esp
  801873:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801877:	8b 74 24 34          	mov    0x34(%esp),%esi
  80187b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80187f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801883:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801887:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80188b:	89 f3                	mov    %esi,%ebx
  80188d:	89 fa                	mov    %edi,%edx
  80188f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801893:	89 34 24             	mov    %esi,(%esp)
  801896:	85 c0                	test   %eax,%eax
  801898:	75 1a                	jne    8018b4 <__umoddi3+0x48>
  80189a:	39 f7                	cmp    %esi,%edi
  80189c:	0f 86 a2 00 00 00    	jbe    801944 <__umoddi3+0xd8>
  8018a2:	89 c8                	mov    %ecx,%eax
  8018a4:	89 f2                	mov    %esi,%edx
  8018a6:	f7 f7                	div    %edi
  8018a8:	89 d0                	mov    %edx,%eax
  8018aa:	31 d2                	xor    %edx,%edx
  8018ac:	83 c4 1c             	add    $0x1c,%esp
  8018af:	5b                   	pop    %ebx
  8018b0:	5e                   	pop    %esi
  8018b1:	5f                   	pop    %edi
  8018b2:	5d                   	pop    %ebp
  8018b3:	c3                   	ret    
  8018b4:	39 f0                	cmp    %esi,%eax
  8018b6:	0f 87 ac 00 00 00    	ja     801968 <__umoddi3+0xfc>
  8018bc:	0f bd e8             	bsr    %eax,%ebp
  8018bf:	83 f5 1f             	xor    $0x1f,%ebp
  8018c2:	0f 84 ac 00 00 00    	je     801974 <__umoddi3+0x108>
  8018c8:	bf 20 00 00 00       	mov    $0x20,%edi
  8018cd:	29 ef                	sub    %ebp,%edi
  8018cf:	89 fe                	mov    %edi,%esi
  8018d1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8018d5:	89 e9                	mov    %ebp,%ecx
  8018d7:	d3 e0                	shl    %cl,%eax
  8018d9:	89 d7                	mov    %edx,%edi
  8018db:	89 f1                	mov    %esi,%ecx
  8018dd:	d3 ef                	shr    %cl,%edi
  8018df:	09 c7                	or     %eax,%edi
  8018e1:	89 e9                	mov    %ebp,%ecx
  8018e3:	d3 e2                	shl    %cl,%edx
  8018e5:	89 14 24             	mov    %edx,(%esp)
  8018e8:	89 d8                	mov    %ebx,%eax
  8018ea:	d3 e0                	shl    %cl,%eax
  8018ec:	89 c2                	mov    %eax,%edx
  8018ee:	8b 44 24 08          	mov    0x8(%esp),%eax
  8018f2:	d3 e0                	shl    %cl,%eax
  8018f4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8018f8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8018fc:	89 f1                	mov    %esi,%ecx
  8018fe:	d3 e8                	shr    %cl,%eax
  801900:	09 d0                	or     %edx,%eax
  801902:	d3 eb                	shr    %cl,%ebx
  801904:	89 da                	mov    %ebx,%edx
  801906:	f7 f7                	div    %edi
  801908:	89 d3                	mov    %edx,%ebx
  80190a:	f7 24 24             	mull   (%esp)
  80190d:	89 c6                	mov    %eax,%esi
  80190f:	89 d1                	mov    %edx,%ecx
  801911:	39 d3                	cmp    %edx,%ebx
  801913:	0f 82 87 00 00 00    	jb     8019a0 <__umoddi3+0x134>
  801919:	0f 84 91 00 00 00    	je     8019b0 <__umoddi3+0x144>
  80191f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801923:	29 f2                	sub    %esi,%edx
  801925:	19 cb                	sbb    %ecx,%ebx
  801927:	89 d8                	mov    %ebx,%eax
  801929:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80192d:	d3 e0                	shl    %cl,%eax
  80192f:	89 e9                	mov    %ebp,%ecx
  801931:	d3 ea                	shr    %cl,%edx
  801933:	09 d0                	or     %edx,%eax
  801935:	89 e9                	mov    %ebp,%ecx
  801937:	d3 eb                	shr    %cl,%ebx
  801939:	89 da                	mov    %ebx,%edx
  80193b:	83 c4 1c             	add    $0x1c,%esp
  80193e:	5b                   	pop    %ebx
  80193f:	5e                   	pop    %esi
  801940:	5f                   	pop    %edi
  801941:	5d                   	pop    %ebp
  801942:	c3                   	ret    
  801943:	90                   	nop
  801944:	89 fd                	mov    %edi,%ebp
  801946:	85 ff                	test   %edi,%edi
  801948:	75 0b                	jne    801955 <__umoddi3+0xe9>
  80194a:	b8 01 00 00 00       	mov    $0x1,%eax
  80194f:	31 d2                	xor    %edx,%edx
  801951:	f7 f7                	div    %edi
  801953:	89 c5                	mov    %eax,%ebp
  801955:	89 f0                	mov    %esi,%eax
  801957:	31 d2                	xor    %edx,%edx
  801959:	f7 f5                	div    %ebp
  80195b:	89 c8                	mov    %ecx,%eax
  80195d:	f7 f5                	div    %ebp
  80195f:	89 d0                	mov    %edx,%eax
  801961:	e9 44 ff ff ff       	jmp    8018aa <__umoddi3+0x3e>
  801966:	66 90                	xchg   %ax,%ax
  801968:	89 c8                	mov    %ecx,%eax
  80196a:	89 f2                	mov    %esi,%edx
  80196c:	83 c4 1c             	add    $0x1c,%esp
  80196f:	5b                   	pop    %ebx
  801970:	5e                   	pop    %esi
  801971:	5f                   	pop    %edi
  801972:	5d                   	pop    %ebp
  801973:	c3                   	ret    
  801974:	3b 04 24             	cmp    (%esp),%eax
  801977:	72 06                	jb     80197f <__umoddi3+0x113>
  801979:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80197d:	77 0f                	ja     80198e <__umoddi3+0x122>
  80197f:	89 f2                	mov    %esi,%edx
  801981:	29 f9                	sub    %edi,%ecx
  801983:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801987:	89 14 24             	mov    %edx,(%esp)
  80198a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80198e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801992:	8b 14 24             	mov    (%esp),%edx
  801995:	83 c4 1c             	add    $0x1c,%esp
  801998:	5b                   	pop    %ebx
  801999:	5e                   	pop    %esi
  80199a:	5f                   	pop    %edi
  80199b:	5d                   	pop    %ebp
  80199c:	c3                   	ret    
  80199d:	8d 76 00             	lea    0x0(%esi),%esi
  8019a0:	2b 04 24             	sub    (%esp),%eax
  8019a3:	19 fa                	sbb    %edi,%edx
  8019a5:	89 d1                	mov    %edx,%ecx
  8019a7:	89 c6                	mov    %eax,%esi
  8019a9:	e9 71 ff ff ff       	jmp    80191f <__umoddi3+0xb3>
  8019ae:	66 90                	xchg   %ax,%ax
  8019b0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8019b4:	72 ea                	jb     8019a0 <__umoddi3+0x134>
  8019b6:	89 d9                	mov    %ebx,%ecx
  8019b8:	e9 62 ff ff ff       	jmp    80191f <__umoddi3+0xb3>
