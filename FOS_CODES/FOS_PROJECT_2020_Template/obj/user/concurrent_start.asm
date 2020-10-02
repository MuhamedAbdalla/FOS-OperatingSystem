
obj/user/concurrent_start:     file format elf32-i386


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
  800031:	e8 cb 00 00 00       	call   800101 <libmain>
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
	char *str ;
	sys_createSharedObject("cnc1", 512, 1, (void*) &str);
  80003e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800041:	50                   	push   %eax
  800042:	6a 01                	push   $0x1
  800044:	68 00 02 00 00       	push   $0x200
  800049:	68 80 19 80 00       	push   $0x801980
  80004e:	e8 76 13 00 00       	call   8013c9 <sys_createSharedObject>
  800053:	83 c4 10             	add    $0x10,%esp
	sys_createSemaphore("cnc1", 1);
  800056:	83 ec 08             	sub    $0x8,%esp
  800059:	6a 01                	push   $0x1
  80005b:	68 80 19 80 00       	push   $0x801980
  800060:	e8 ef 12 00 00       	call   801354 <sys_createSemaphore>
  800065:	83 c4 10             	add    $0x10,%esp

	sys_createSemaphore("depend1", 0);
  800068:	83 ec 08             	sub    $0x8,%esp
  80006b:	6a 00                	push   $0x0
  80006d:	68 85 19 80 00       	push   $0x801985
  800072:	e8 dd 12 00 00       	call   801354 <sys_createSemaphore>
  800077:	83 c4 10             	add    $0x10,%esp

	uint32 id1, id2;
	id2 = sys_create_env("qs2", (myEnv->page_WS_max_size), (myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  80007a:	a1 20 20 80 00       	mov    0x802020,%eax
  80007f:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  800085:	a1 20 20 80 00       	mov    0x802020,%eax
  80008a:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800090:	89 c1                	mov    %eax,%ecx
  800092:	a1 20 20 80 00       	mov    0x802020,%eax
  800097:	8b 40 74             	mov    0x74(%eax),%eax
  80009a:	52                   	push   %edx
  80009b:	51                   	push   %ecx
  80009c:	50                   	push   %eax
  80009d:	68 8d 19 80 00       	push   $0x80198d
  8000a2:	e8 be 13 00 00       	call   801465 <sys_create_env>
  8000a7:	83 c4 10             	add    $0x10,%esp
  8000aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	id1 = sys_create_env("qs1", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000ad:	a1 20 20 80 00       	mov    0x802020,%eax
  8000b2:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8000b8:	a1 20 20 80 00       	mov    0x802020,%eax
  8000bd:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000c3:	89 c1                	mov    %eax,%ecx
  8000c5:	a1 20 20 80 00       	mov    0x802020,%eax
  8000ca:	8b 40 74             	mov    0x74(%eax),%eax
  8000cd:	52                   	push   %edx
  8000ce:	51                   	push   %ecx
  8000cf:	50                   	push   %eax
  8000d0:	68 91 19 80 00       	push   $0x801991
  8000d5:	e8 8b 13 00 00       	call   801465 <sys_create_env>
  8000da:	83 c4 10             	add    $0x10,%esp
  8000dd:	89 45 f0             	mov    %eax,-0x10(%ebp)

	sys_run_env(id2);
  8000e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000e3:	83 ec 0c             	sub    $0xc,%esp
  8000e6:	50                   	push   %eax
  8000e7:	e8 97 13 00 00       	call   801483 <sys_run_env>
  8000ec:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id1);
  8000ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000f2:	83 ec 0c             	sub    $0xc,%esp
  8000f5:	50                   	push   %eax
  8000f6:	e8 88 13 00 00       	call   801483 <sys_run_env>
  8000fb:	83 c4 10             	add    $0x10,%esp

	return;
  8000fe:	90                   	nop
}
  8000ff:	c9                   	leave  
  800100:	c3                   	ret    

00800101 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800101:	55                   	push   %ebp
  800102:	89 e5                	mov    %esp,%ebp
  800104:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800107:	e8 39 10 00 00       	call   801145 <sys_getenvindex>
  80010c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80010f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800112:	89 d0                	mov    %edx,%eax
  800114:	c1 e0 03             	shl    $0x3,%eax
  800117:	01 d0                	add    %edx,%eax
  800119:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800120:	01 c8                	add    %ecx,%eax
  800122:	01 c0                	add    %eax,%eax
  800124:	01 d0                	add    %edx,%eax
  800126:	01 c0                	add    %eax,%eax
  800128:	01 d0                	add    %edx,%eax
  80012a:	89 c2                	mov    %eax,%edx
  80012c:	c1 e2 05             	shl    $0x5,%edx
  80012f:	29 c2                	sub    %eax,%edx
  800131:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800138:	89 c2                	mov    %eax,%edx
  80013a:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800140:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800145:	a1 20 20 80 00       	mov    0x802020,%eax
  80014a:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800150:	84 c0                	test   %al,%al
  800152:	74 0f                	je     800163 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800154:	a1 20 20 80 00       	mov    0x802020,%eax
  800159:	05 40 3c 01 00       	add    $0x13c40,%eax
  80015e:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800163:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800167:	7e 0a                	jle    800173 <libmain+0x72>
		binaryname = argv[0];
  800169:	8b 45 0c             	mov    0xc(%ebp),%eax
  80016c:	8b 00                	mov    (%eax),%eax
  80016e:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800173:	83 ec 08             	sub    $0x8,%esp
  800176:	ff 75 0c             	pushl  0xc(%ebp)
  800179:	ff 75 08             	pushl  0x8(%ebp)
  80017c:	e8 b7 fe ff ff       	call   800038 <_main>
  800181:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800184:	e8 57 11 00 00       	call   8012e0 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800189:	83 ec 0c             	sub    $0xc,%esp
  80018c:	68 b0 19 80 00       	push   $0x8019b0
  800191:	e8 84 01 00 00       	call   80031a <cprintf>
  800196:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800199:	a1 20 20 80 00       	mov    0x802020,%eax
  80019e:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8001a4:	a1 20 20 80 00       	mov    0x802020,%eax
  8001a9:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8001af:	83 ec 04             	sub    $0x4,%esp
  8001b2:	52                   	push   %edx
  8001b3:	50                   	push   %eax
  8001b4:	68 d8 19 80 00       	push   $0x8019d8
  8001b9:	e8 5c 01 00 00       	call   80031a <cprintf>
  8001be:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8001c1:	a1 20 20 80 00       	mov    0x802020,%eax
  8001c6:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8001cc:	a1 20 20 80 00       	mov    0x802020,%eax
  8001d1:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8001d7:	83 ec 04             	sub    $0x4,%esp
  8001da:	52                   	push   %edx
  8001db:	50                   	push   %eax
  8001dc:	68 00 1a 80 00       	push   $0x801a00
  8001e1:	e8 34 01 00 00       	call   80031a <cprintf>
  8001e6:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001e9:	a1 20 20 80 00       	mov    0x802020,%eax
  8001ee:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8001f4:	83 ec 08             	sub    $0x8,%esp
  8001f7:	50                   	push   %eax
  8001f8:	68 41 1a 80 00       	push   $0x801a41
  8001fd:	e8 18 01 00 00       	call   80031a <cprintf>
  800202:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800205:	83 ec 0c             	sub    $0xc,%esp
  800208:	68 b0 19 80 00       	push   $0x8019b0
  80020d:	e8 08 01 00 00       	call   80031a <cprintf>
  800212:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800215:	e8 e0 10 00 00       	call   8012fa <sys_enable_interrupt>

	// exit gracefully
	exit();
  80021a:	e8 19 00 00 00       	call   800238 <exit>
}
  80021f:	90                   	nop
  800220:	c9                   	leave  
  800221:	c3                   	ret    

00800222 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800222:	55                   	push   %ebp
  800223:	89 e5                	mov    %esp,%ebp
  800225:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800228:	83 ec 0c             	sub    $0xc,%esp
  80022b:	6a 00                	push   $0x0
  80022d:	e8 df 0e 00 00       	call   801111 <sys_env_destroy>
  800232:	83 c4 10             	add    $0x10,%esp
}
  800235:	90                   	nop
  800236:	c9                   	leave  
  800237:	c3                   	ret    

00800238 <exit>:

void
exit(void)
{
  800238:	55                   	push   %ebp
  800239:	89 e5                	mov    %esp,%ebp
  80023b:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80023e:	e8 34 0f 00 00       	call   801177 <sys_env_exit>
}
  800243:	90                   	nop
  800244:	c9                   	leave  
  800245:	c3                   	ret    

00800246 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800246:	55                   	push   %ebp
  800247:	89 e5                	mov    %esp,%ebp
  800249:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80024c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80024f:	8b 00                	mov    (%eax),%eax
  800251:	8d 48 01             	lea    0x1(%eax),%ecx
  800254:	8b 55 0c             	mov    0xc(%ebp),%edx
  800257:	89 0a                	mov    %ecx,(%edx)
  800259:	8b 55 08             	mov    0x8(%ebp),%edx
  80025c:	88 d1                	mov    %dl,%cl
  80025e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800261:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800265:	8b 45 0c             	mov    0xc(%ebp),%eax
  800268:	8b 00                	mov    (%eax),%eax
  80026a:	3d ff 00 00 00       	cmp    $0xff,%eax
  80026f:	75 2c                	jne    80029d <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800271:	a0 24 20 80 00       	mov    0x802024,%al
  800276:	0f b6 c0             	movzbl %al,%eax
  800279:	8b 55 0c             	mov    0xc(%ebp),%edx
  80027c:	8b 12                	mov    (%edx),%edx
  80027e:	89 d1                	mov    %edx,%ecx
  800280:	8b 55 0c             	mov    0xc(%ebp),%edx
  800283:	83 c2 08             	add    $0x8,%edx
  800286:	83 ec 04             	sub    $0x4,%esp
  800289:	50                   	push   %eax
  80028a:	51                   	push   %ecx
  80028b:	52                   	push   %edx
  80028c:	e8 3e 0e 00 00       	call   8010cf <sys_cputs>
  800291:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800294:	8b 45 0c             	mov    0xc(%ebp),%eax
  800297:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80029d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002a0:	8b 40 04             	mov    0x4(%eax),%eax
  8002a3:	8d 50 01             	lea    0x1(%eax),%edx
  8002a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002a9:	89 50 04             	mov    %edx,0x4(%eax)
}
  8002ac:	90                   	nop
  8002ad:	c9                   	leave  
  8002ae:	c3                   	ret    

008002af <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8002af:	55                   	push   %ebp
  8002b0:	89 e5                	mov    %esp,%ebp
  8002b2:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8002b8:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8002bf:	00 00 00 
	b.cnt = 0;
  8002c2:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8002c9:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002cc:	ff 75 0c             	pushl  0xc(%ebp)
  8002cf:	ff 75 08             	pushl  0x8(%ebp)
  8002d2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002d8:	50                   	push   %eax
  8002d9:	68 46 02 80 00       	push   $0x800246
  8002de:	e8 11 02 00 00       	call   8004f4 <vprintfmt>
  8002e3:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002e6:	a0 24 20 80 00       	mov    0x802024,%al
  8002eb:	0f b6 c0             	movzbl %al,%eax
  8002ee:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002f4:	83 ec 04             	sub    $0x4,%esp
  8002f7:	50                   	push   %eax
  8002f8:	52                   	push   %edx
  8002f9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002ff:	83 c0 08             	add    $0x8,%eax
  800302:	50                   	push   %eax
  800303:	e8 c7 0d 00 00       	call   8010cf <sys_cputs>
  800308:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80030b:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  800312:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800318:	c9                   	leave  
  800319:	c3                   	ret    

0080031a <cprintf>:

int cprintf(const char *fmt, ...) {
  80031a:	55                   	push   %ebp
  80031b:	89 e5                	mov    %esp,%ebp
  80031d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800320:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  800327:	8d 45 0c             	lea    0xc(%ebp),%eax
  80032a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80032d:	8b 45 08             	mov    0x8(%ebp),%eax
  800330:	83 ec 08             	sub    $0x8,%esp
  800333:	ff 75 f4             	pushl  -0xc(%ebp)
  800336:	50                   	push   %eax
  800337:	e8 73 ff ff ff       	call   8002af <vcprintf>
  80033c:	83 c4 10             	add    $0x10,%esp
  80033f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800342:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800345:	c9                   	leave  
  800346:	c3                   	ret    

00800347 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800347:	55                   	push   %ebp
  800348:	89 e5                	mov    %esp,%ebp
  80034a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80034d:	e8 8e 0f 00 00       	call   8012e0 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800352:	8d 45 0c             	lea    0xc(%ebp),%eax
  800355:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800358:	8b 45 08             	mov    0x8(%ebp),%eax
  80035b:	83 ec 08             	sub    $0x8,%esp
  80035e:	ff 75 f4             	pushl  -0xc(%ebp)
  800361:	50                   	push   %eax
  800362:	e8 48 ff ff ff       	call   8002af <vcprintf>
  800367:	83 c4 10             	add    $0x10,%esp
  80036a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80036d:	e8 88 0f 00 00       	call   8012fa <sys_enable_interrupt>
	return cnt;
  800372:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800375:	c9                   	leave  
  800376:	c3                   	ret    

00800377 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800377:	55                   	push   %ebp
  800378:	89 e5                	mov    %esp,%ebp
  80037a:	53                   	push   %ebx
  80037b:	83 ec 14             	sub    $0x14,%esp
  80037e:	8b 45 10             	mov    0x10(%ebp),%eax
  800381:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800384:	8b 45 14             	mov    0x14(%ebp),%eax
  800387:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80038a:	8b 45 18             	mov    0x18(%ebp),%eax
  80038d:	ba 00 00 00 00       	mov    $0x0,%edx
  800392:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800395:	77 55                	ja     8003ec <printnum+0x75>
  800397:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80039a:	72 05                	jb     8003a1 <printnum+0x2a>
  80039c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80039f:	77 4b                	ja     8003ec <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8003a1:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8003a4:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8003a7:	8b 45 18             	mov    0x18(%ebp),%eax
  8003aa:	ba 00 00 00 00       	mov    $0x0,%edx
  8003af:	52                   	push   %edx
  8003b0:	50                   	push   %eax
  8003b1:	ff 75 f4             	pushl  -0xc(%ebp)
  8003b4:	ff 75 f0             	pushl  -0x10(%ebp)
  8003b7:	e8 48 13 00 00       	call   801704 <__udivdi3>
  8003bc:	83 c4 10             	add    $0x10,%esp
  8003bf:	83 ec 04             	sub    $0x4,%esp
  8003c2:	ff 75 20             	pushl  0x20(%ebp)
  8003c5:	53                   	push   %ebx
  8003c6:	ff 75 18             	pushl  0x18(%ebp)
  8003c9:	52                   	push   %edx
  8003ca:	50                   	push   %eax
  8003cb:	ff 75 0c             	pushl  0xc(%ebp)
  8003ce:	ff 75 08             	pushl  0x8(%ebp)
  8003d1:	e8 a1 ff ff ff       	call   800377 <printnum>
  8003d6:	83 c4 20             	add    $0x20,%esp
  8003d9:	eb 1a                	jmp    8003f5 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8003db:	83 ec 08             	sub    $0x8,%esp
  8003de:	ff 75 0c             	pushl  0xc(%ebp)
  8003e1:	ff 75 20             	pushl  0x20(%ebp)
  8003e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e7:	ff d0                	call   *%eax
  8003e9:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003ec:	ff 4d 1c             	decl   0x1c(%ebp)
  8003ef:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003f3:	7f e6                	jg     8003db <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003f5:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003f8:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800400:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800403:	53                   	push   %ebx
  800404:	51                   	push   %ecx
  800405:	52                   	push   %edx
  800406:	50                   	push   %eax
  800407:	e8 08 14 00 00       	call   801814 <__umoddi3>
  80040c:	83 c4 10             	add    $0x10,%esp
  80040f:	05 74 1c 80 00       	add    $0x801c74,%eax
  800414:	8a 00                	mov    (%eax),%al
  800416:	0f be c0             	movsbl %al,%eax
  800419:	83 ec 08             	sub    $0x8,%esp
  80041c:	ff 75 0c             	pushl  0xc(%ebp)
  80041f:	50                   	push   %eax
  800420:	8b 45 08             	mov    0x8(%ebp),%eax
  800423:	ff d0                	call   *%eax
  800425:	83 c4 10             	add    $0x10,%esp
}
  800428:	90                   	nop
  800429:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80042c:	c9                   	leave  
  80042d:	c3                   	ret    

0080042e <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80042e:	55                   	push   %ebp
  80042f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800431:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800435:	7e 1c                	jle    800453 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800437:	8b 45 08             	mov    0x8(%ebp),%eax
  80043a:	8b 00                	mov    (%eax),%eax
  80043c:	8d 50 08             	lea    0x8(%eax),%edx
  80043f:	8b 45 08             	mov    0x8(%ebp),%eax
  800442:	89 10                	mov    %edx,(%eax)
  800444:	8b 45 08             	mov    0x8(%ebp),%eax
  800447:	8b 00                	mov    (%eax),%eax
  800449:	83 e8 08             	sub    $0x8,%eax
  80044c:	8b 50 04             	mov    0x4(%eax),%edx
  80044f:	8b 00                	mov    (%eax),%eax
  800451:	eb 40                	jmp    800493 <getuint+0x65>
	else if (lflag)
  800453:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800457:	74 1e                	je     800477 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800459:	8b 45 08             	mov    0x8(%ebp),%eax
  80045c:	8b 00                	mov    (%eax),%eax
  80045e:	8d 50 04             	lea    0x4(%eax),%edx
  800461:	8b 45 08             	mov    0x8(%ebp),%eax
  800464:	89 10                	mov    %edx,(%eax)
  800466:	8b 45 08             	mov    0x8(%ebp),%eax
  800469:	8b 00                	mov    (%eax),%eax
  80046b:	83 e8 04             	sub    $0x4,%eax
  80046e:	8b 00                	mov    (%eax),%eax
  800470:	ba 00 00 00 00       	mov    $0x0,%edx
  800475:	eb 1c                	jmp    800493 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800477:	8b 45 08             	mov    0x8(%ebp),%eax
  80047a:	8b 00                	mov    (%eax),%eax
  80047c:	8d 50 04             	lea    0x4(%eax),%edx
  80047f:	8b 45 08             	mov    0x8(%ebp),%eax
  800482:	89 10                	mov    %edx,(%eax)
  800484:	8b 45 08             	mov    0x8(%ebp),%eax
  800487:	8b 00                	mov    (%eax),%eax
  800489:	83 e8 04             	sub    $0x4,%eax
  80048c:	8b 00                	mov    (%eax),%eax
  80048e:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800493:	5d                   	pop    %ebp
  800494:	c3                   	ret    

00800495 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800495:	55                   	push   %ebp
  800496:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800498:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80049c:	7e 1c                	jle    8004ba <getint+0x25>
		return va_arg(*ap, long long);
  80049e:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a1:	8b 00                	mov    (%eax),%eax
  8004a3:	8d 50 08             	lea    0x8(%eax),%edx
  8004a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a9:	89 10                	mov    %edx,(%eax)
  8004ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ae:	8b 00                	mov    (%eax),%eax
  8004b0:	83 e8 08             	sub    $0x8,%eax
  8004b3:	8b 50 04             	mov    0x4(%eax),%edx
  8004b6:	8b 00                	mov    (%eax),%eax
  8004b8:	eb 38                	jmp    8004f2 <getint+0x5d>
	else if (lflag)
  8004ba:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004be:	74 1a                	je     8004da <getint+0x45>
		return va_arg(*ap, long);
  8004c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c3:	8b 00                	mov    (%eax),%eax
  8004c5:	8d 50 04             	lea    0x4(%eax),%edx
  8004c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004cb:	89 10                	mov    %edx,(%eax)
  8004cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d0:	8b 00                	mov    (%eax),%eax
  8004d2:	83 e8 04             	sub    $0x4,%eax
  8004d5:	8b 00                	mov    (%eax),%eax
  8004d7:	99                   	cltd   
  8004d8:	eb 18                	jmp    8004f2 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8004da:	8b 45 08             	mov    0x8(%ebp),%eax
  8004dd:	8b 00                	mov    (%eax),%eax
  8004df:	8d 50 04             	lea    0x4(%eax),%edx
  8004e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e5:	89 10                	mov    %edx,(%eax)
  8004e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ea:	8b 00                	mov    (%eax),%eax
  8004ec:	83 e8 04             	sub    $0x4,%eax
  8004ef:	8b 00                	mov    (%eax),%eax
  8004f1:	99                   	cltd   
}
  8004f2:	5d                   	pop    %ebp
  8004f3:	c3                   	ret    

008004f4 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004f4:	55                   	push   %ebp
  8004f5:	89 e5                	mov    %esp,%ebp
  8004f7:	56                   	push   %esi
  8004f8:	53                   	push   %ebx
  8004f9:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004fc:	eb 17                	jmp    800515 <vprintfmt+0x21>
			if (ch == '\0')
  8004fe:	85 db                	test   %ebx,%ebx
  800500:	0f 84 af 03 00 00    	je     8008b5 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800506:	83 ec 08             	sub    $0x8,%esp
  800509:	ff 75 0c             	pushl  0xc(%ebp)
  80050c:	53                   	push   %ebx
  80050d:	8b 45 08             	mov    0x8(%ebp),%eax
  800510:	ff d0                	call   *%eax
  800512:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800515:	8b 45 10             	mov    0x10(%ebp),%eax
  800518:	8d 50 01             	lea    0x1(%eax),%edx
  80051b:	89 55 10             	mov    %edx,0x10(%ebp)
  80051e:	8a 00                	mov    (%eax),%al
  800520:	0f b6 d8             	movzbl %al,%ebx
  800523:	83 fb 25             	cmp    $0x25,%ebx
  800526:	75 d6                	jne    8004fe <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800528:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80052c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800533:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80053a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800541:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800548:	8b 45 10             	mov    0x10(%ebp),%eax
  80054b:	8d 50 01             	lea    0x1(%eax),%edx
  80054e:	89 55 10             	mov    %edx,0x10(%ebp)
  800551:	8a 00                	mov    (%eax),%al
  800553:	0f b6 d8             	movzbl %al,%ebx
  800556:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800559:	83 f8 55             	cmp    $0x55,%eax
  80055c:	0f 87 2b 03 00 00    	ja     80088d <vprintfmt+0x399>
  800562:	8b 04 85 98 1c 80 00 	mov    0x801c98(,%eax,4),%eax
  800569:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80056b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80056f:	eb d7                	jmp    800548 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800571:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800575:	eb d1                	jmp    800548 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800577:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80057e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800581:	89 d0                	mov    %edx,%eax
  800583:	c1 e0 02             	shl    $0x2,%eax
  800586:	01 d0                	add    %edx,%eax
  800588:	01 c0                	add    %eax,%eax
  80058a:	01 d8                	add    %ebx,%eax
  80058c:	83 e8 30             	sub    $0x30,%eax
  80058f:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800592:	8b 45 10             	mov    0x10(%ebp),%eax
  800595:	8a 00                	mov    (%eax),%al
  800597:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80059a:	83 fb 2f             	cmp    $0x2f,%ebx
  80059d:	7e 3e                	jle    8005dd <vprintfmt+0xe9>
  80059f:	83 fb 39             	cmp    $0x39,%ebx
  8005a2:	7f 39                	jg     8005dd <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005a4:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8005a7:	eb d5                	jmp    80057e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8005a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ac:	83 c0 04             	add    $0x4,%eax
  8005af:	89 45 14             	mov    %eax,0x14(%ebp)
  8005b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b5:	83 e8 04             	sub    $0x4,%eax
  8005b8:	8b 00                	mov    (%eax),%eax
  8005ba:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8005bd:	eb 1f                	jmp    8005de <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8005bf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005c3:	79 83                	jns    800548 <vprintfmt+0x54>
				width = 0;
  8005c5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005cc:	e9 77 ff ff ff       	jmp    800548 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005d1:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8005d8:	e9 6b ff ff ff       	jmp    800548 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8005dd:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005de:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005e2:	0f 89 60 ff ff ff    	jns    800548 <vprintfmt+0x54>
				width = precision, precision = -1;
  8005e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005ee:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005f5:	e9 4e ff ff ff       	jmp    800548 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005fa:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005fd:	e9 46 ff ff ff       	jmp    800548 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800602:	8b 45 14             	mov    0x14(%ebp),%eax
  800605:	83 c0 04             	add    $0x4,%eax
  800608:	89 45 14             	mov    %eax,0x14(%ebp)
  80060b:	8b 45 14             	mov    0x14(%ebp),%eax
  80060e:	83 e8 04             	sub    $0x4,%eax
  800611:	8b 00                	mov    (%eax),%eax
  800613:	83 ec 08             	sub    $0x8,%esp
  800616:	ff 75 0c             	pushl  0xc(%ebp)
  800619:	50                   	push   %eax
  80061a:	8b 45 08             	mov    0x8(%ebp),%eax
  80061d:	ff d0                	call   *%eax
  80061f:	83 c4 10             	add    $0x10,%esp
			break;
  800622:	e9 89 02 00 00       	jmp    8008b0 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800627:	8b 45 14             	mov    0x14(%ebp),%eax
  80062a:	83 c0 04             	add    $0x4,%eax
  80062d:	89 45 14             	mov    %eax,0x14(%ebp)
  800630:	8b 45 14             	mov    0x14(%ebp),%eax
  800633:	83 e8 04             	sub    $0x4,%eax
  800636:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800638:	85 db                	test   %ebx,%ebx
  80063a:	79 02                	jns    80063e <vprintfmt+0x14a>
				err = -err;
  80063c:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80063e:	83 fb 64             	cmp    $0x64,%ebx
  800641:	7f 0b                	jg     80064e <vprintfmt+0x15a>
  800643:	8b 34 9d e0 1a 80 00 	mov    0x801ae0(,%ebx,4),%esi
  80064a:	85 f6                	test   %esi,%esi
  80064c:	75 19                	jne    800667 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80064e:	53                   	push   %ebx
  80064f:	68 85 1c 80 00       	push   $0x801c85
  800654:	ff 75 0c             	pushl  0xc(%ebp)
  800657:	ff 75 08             	pushl  0x8(%ebp)
  80065a:	e8 5e 02 00 00       	call   8008bd <printfmt>
  80065f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800662:	e9 49 02 00 00       	jmp    8008b0 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800667:	56                   	push   %esi
  800668:	68 8e 1c 80 00       	push   $0x801c8e
  80066d:	ff 75 0c             	pushl  0xc(%ebp)
  800670:	ff 75 08             	pushl  0x8(%ebp)
  800673:	e8 45 02 00 00       	call   8008bd <printfmt>
  800678:	83 c4 10             	add    $0x10,%esp
			break;
  80067b:	e9 30 02 00 00       	jmp    8008b0 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800680:	8b 45 14             	mov    0x14(%ebp),%eax
  800683:	83 c0 04             	add    $0x4,%eax
  800686:	89 45 14             	mov    %eax,0x14(%ebp)
  800689:	8b 45 14             	mov    0x14(%ebp),%eax
  80068c:	83 e8 04             	sub    $0x4,%eax
  80068f:	8b 30                	mov    (%eax),%esi
  800691:	85 f6                	test   %esi,%esi
  800693:	75 05                	jne    80069a <vprintfmt+0x1a6>
				p = "(null)";
  800695:	be 91 1c 80 00       	mov    $0x801c91,%esi
			if (width > 0 && padc != '-')
  80069a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80069e:	7e 6d                	jle    80070d <vprintfmt+0x219>
  8006a0:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8006a4:	74 67                	je     80070d <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8006a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006a9:	83 ec 08             	sub    $0x8,%esp
  8006ac:	50                   	push   %eax
  8006ad:	56                   	push   %esi
  8006ae:	e8 0c 03 00 00       	call   8009bf <strnlen>
  8006b3:	83 c4 10             	add    $0x10,%esp
  8006b6:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8006b9:	eb 16                	jmp    8006d1 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8006bb:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8006bf:	83 ec 08             	sub    $0x8,%esp
  8006c2:	ff 75 0c             	pushl  0xc(%ebp)
  8006c5:	50                   	push   %eax
  8006c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c9:	ff d0                	call   *%eax
  8006cb:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006ce:	ff 4d e4             	decl   -0x1c(%ebp)
  8006d1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006d5:	7f e4                	jg     8006bb <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006d7:	eb 34                	jmp    80070d <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8006d9:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8006dd:	74 1c                	je     8006fb <vprintfmt+0x207>
  8006df:	83 fb 1f             	cmp    $0x1f,%ebx
  8006e2:	7e 05                	jle    8006e9 <vprintfmt+0x1f5>
  8006e4:	83 fb 7e             	cmp    $0x7e,%ebx
  8006e7:	7e 12                	jle    8006fb <vprintfmt+0x207>
					putch('?', putdat);
  8006e9:	83 ec 08             	sub    $0x8,%esp
  8006ec:	ff 75 0c             	pushl  0xc(%ebp)
  8006ef:	6a 3f                	push   $0x3f
  8006f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f4:	ff d0                	call   *%eax
  8006f6:	83 c4 10             	add    $0x10,%esp
  8006f9:	eb 0f                	jmp    80070a <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006fb:	83 ec 08             	sub    $0x8,%esp
  8006fe:	ff 75 0c             	pushl  0xc(%ebp)
  800701:	53                   	push   %ebx
  800702:	8b 45 08             	mov    0x8(%ebp),%eax
  800705:	ff d0                	call   *%eax
  800707:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80070a:	ff 4d e4             	decl   -0x1c(%ebp)
  80070d:	89 f0                	mov    %esi,%eax
  80070f:	8d 70 01             	lea    0x1(%eax),%esi
  800712:	8a 00                	mov    (%eax),%al
  800714:	0f be d8             	movsbl %al,%ebx
  800717:	85 db                	test   %ebx,%ebx
  800719:	74 24                	je     80073f <vprintfmt+0x24b>
  80071b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80071f:	78 b8                	js     8006d9 <vprintfmt+0x1e5>
  800721:	ff 4d e0             	decl   -0x20(%ebp)
  800724:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800728:	79 af                	jns    8006d9 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80072a:	eb 13                	jmp    80073f <vprintfmt+0x24b>
				putch(' ', putdat);
  80072c:	83 ec 08             	sub    $0x8,%esp
  80072f:	ff 75 0c             	pushl  0xc(%ebp)
  800732:	6a 20                	push   $0x20
  800734:	8b 45 08             	mov    0x8(%ebp),%eax
  800737:	ff d0                	call   *%eax
  800739:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80073c:	ff 4d e4             	decl   -0x1c(%ebp)
  80073f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800743:	7f e7                	jg     80072c <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800745:	e9 66 01 00 00       	jmp    8008b0 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80074a:	83 ec 08             	sub    $0x8,%esp
  80074d:	ff 75 e8             	pushl  -0x18(%ebp)
  800750:	8d 45 14             	lea    0x14(%ebp),%eax
  800753:	50                   	push   %eax
  800754:	e8 3c fd ff ff       	call   800495 <getint>
  800759:	83 c4 10             	add    $0x10,%esp
  80075c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80075f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800762:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800765:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800768:	85 d2                	test   %edx,%edx
  80076a:	79 23                	jns    80078f <vprintfmt+0x29b>
				putch('-', putdat);
  80076c:	83 ec 08             	sub    $0x8,%esp
  80076f:	ff 75 0c             	pushl  0xc(%ebp)
  800772:	6a 2d                	push   $0x2d
  800774:	8b 45 08             	mov    0x8(%ebp),%eax
  800777:	ff d0                	call   *%eax
  800779:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80077c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80077f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800782:	f7 d8                	neg    %eax
  800784:	83 d2 00             	adc    $0x0,%edx
  800787:	f7 da                	neg    %edx
  800789:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80078c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80078f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800796:	e9 bc 00 00 00       	jmp    800857 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80079b:	83 ec 08             	sub    $0x8,%esp
  80079e:	ff 75 e8             	pushl  -0x18(%ebp)
  8007a1:	8d 45 14             	lea    0x14(%ebp),%eax
  8007a4:	50                   	push   %eax
  8007a5:	e8 84 fc ff ff       	call   80042e <getuint>
  8007aa:	83 c4 10             	add    $0x10,%esp
  8007ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007b0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8007b3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007ba:	e9 98 00 00 00       	jmp    800857 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8007bf:	83 ec 08             	sub    $0x8,%esp
  8007c2:	ff 75 0c             	pushl  0xc(%ebp)
  8007c5:	6a 58                	push   $0x58
  8007c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ca:	ff d0                	call   *%eax
  8007cc:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007cf:	83 ec 08             	sub    $0x8,%esp
  8007d2:	ff 75 0c             	pushl  0xc(%ebp)
  8007d5:	6a 58                	push   $0x58
  8007d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007da:	ff d0                	call   *%eax
  8007dc:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007df:	83 ec 08             	sub    $0x8,%esp
  8007e2:	ff 75 0c             	pushl  0xc(%ebp)
  8007e5:	6a 58                	push   $0x58
  8007e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ea:	ff d0                	call   *%eax
  8007ec:	83 c4 10             	add    $0x10,%esp
			break;
  8007ef:	e9 bc 00 00 00       	jmp    8008b0 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007f4:	83 ec 08             	sub    $0x8,%esp
  8007f7:	ff 75 0c             	pushl  0xc(%ebp)
  8007fa:	6a 30                	push   $0x30
  8007fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ff:	ff d0                	call   *%eax
  800801:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800804:	83 ec 08             	sub    $0x8,%esp
  800807:	ff 75 0c             	pushl  0xc(%ebp)
  80080a:	6a 78                	push   $0x78
  80080c:	8b 45 08             	mov    0x8(%ebp),%eax
  80080f:	ff d0                	call   *%eax
  800811:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800814:	8b 45 14             	mov    0x14(%ebp),%eax
  800817:	83 c0 04             	add    $0x4,%eax
  80081a:	89 45 14             	mov    %eax,0x14(%ebp)
  80081d:	8b 45 14             	mov    0x14(%ebp),%eax
  800820:	83 e8 04             	sub    $0x4,%eax
  800823:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800825:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800828:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80082f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800836:	eb 1f                	jmp    800857 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800838:	83 ec 08             	sub    $0x8,%esp
  80083b:	ff 75 e8             	pushl  -0x18(%ebp)
  80083e:	8d 45 14             	lea    0x14(%ebp),%eax
  800841:	50                   	push   %eax
  800842:	e8 e7 fb ff ff       	call   80042e <getuint>
  800847:	83 c4 10             	add    $0x10,%esp
  80084a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80084d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800850:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800857:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80085b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80085e:	83 ec 04             	sub    $0x4,%esp
  800861:	52                   	push   %edx
  800862:	ff 75 e4             	pushl  -0x1c(%ebp)
  800865:	50                   	push   %eax
  800866:	ff 75 f4             	pushl  -0xc(%ebp)
  800869:	ff 75 f0             	pushl  -0x10(%ebp)
  80086c:	ff 75 0c             	pushl  0xc(%ebp)
  80086f:	ff 75 08             	pushl  0x8(%ebp)
  800872:	e8 00 fb ff ff       	call   800377 <printnum>
  800877:	83 c4 20             	add    $0x20,%esp
			break;
  80087a:	eb 34                	jmp    8008b0 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80087c:	83 ec 08             	sub    $0x8,%esp
  80087f:	ff 75 0c             	pushl  0xc(%ebp)
  800882:	53                   	push   %ebx
  800883:	8b 45 08             	mov    0x8(%ebp),%eax
  800886:	ff d0                	call   *%eax
  800888:	83 c4 10             	add    $0x10,%esp
			break;
  80088b:	eb 23                	jmp    8008b0 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80088d:	83 ec 08             	sub    $0x8,%esp
  800890:	ff 75 0c             	pushl  0xc(%ebp)
  800893:	6a 25                	push   $0x25
  800895:	8b 45 08             	mov    0x8(%ebp),%eax
  800898:	ff d0                	call   *%eax
  80089a:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80089d:	ff 4d 10             	decl   0x10(%ebp)
  8008a0:	eb 03                	jmp    8008a5 <vprintfmt+0x3b1>
  8008a2:	ff 4d 10             	decl   0x10(%ebp)
  8008a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8008a8:	48                   	dec    %eax
  8008a9:	8a 00                	mov    (%eax),%al
  8008ab:	3c 25                	cmp    $0x25,%al
  8008ad:	75 f3                	jne    8008a2 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8008af:	90                   	nop
		}
	}
  8008b0:	e9 47 fc ff ff       	jmp    8004fc <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8008b5:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8008b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008b9:	5b                   	pop    %ebx
  8008ba:	5e                   	pop    %esi
  8008bb:	5d                   	pop    %ebp
  8008bc:	c3                   	ret    

008008bd <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8008bd:	55                   	push   %ebp
  8008be:	89 e5                	mov    %esp,%ebp
  8008c0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8008c3:	8d 45 10             	lea    0x10(%ebp),%eax
  8008c6:	83 c0 04             	add    $0x4,%eax
  8008c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8008cf:	ff 75 f4             	pushl  -0xc(%ebp)
  8008d2:	50                   	push   %eax
  8008d3:	ff 75 0c             	pushl  0xc(%ebp)
  8008d6:	ff 75 08             	pushl  0x8(%ebp)
  8008d9:	e8 16 fc ff ff       	call   8004f4 <vprintfmt>
  8008de:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008e1:	90                   	nop
  8008e2:	c9                   	leave  
  8008e3:	c3                   	ret    

008008e4 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008e4:	55                   	push   %ebp
  8008e5:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ea:	8b 40 08             	mov    0x8(%eax),%eax
  8008ed:	8d 50 01             	lea    0x1(%eax),%edx
  8008f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f3:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f9:	8b 10                	mov    (%eax),%edx
  8008fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fe:	8b 40 04             	mov    0x4(%eax),%eax
  800901:	39 c2                	cmp    %eax,%edx
  800903:	73 12                	jae    800917 <sprintputch+0x33>
		*b->buf++ = ch;
  800905:	8b 45 0c             	mov    0xc(%ebp),%eax
  800908:	8b 00                	mov    (%eax),%eax
  80090a:	8d 48 01             	lea    0x1(%eax),%ecx
  80090d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800910:	89 0a                	mov    %ecx,(%edx)
  800912:	8b 55 08             	mov    0x8(%ebp),%edx
  800915:	88 10                	mov    %dl,(%eax)
}
  800917:	90                   	nop
  800918:	5d                   	pop    %ebp
  800919:	c3                   	ret    

0080091a <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80091a:	55                   	push   %ebp
  80091b:	89 e5                	mov    %esp,%ebp
  80091d:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800920:	8b 45 08             	mov    0x8(%ebp),%eax
  800923:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800926:	8b 45 0c             	mov    0xc(%ebp),%eax
  800929:	8d 50 ff             	lea    -0x1(%eax),%edx
  80092c:	8b 45 08             	mov    0x8(%ebp),%eax
  80092f:	01 d0                	add    %edx,%eax
  800931:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800934:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80093b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80093f:	74 06                	je     800947 <vsnprintf+0x2d>
  800941:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800945:	7f 07                	jg     80094e <vsnprintf+0x34>
		return -E_INVAL;
  800947:	b8 03 00 00 00       	mov    $0x3,%eax
  80094c:	eb 20                	jmp    80096e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80094e:	ff 75 14             	pushl  0x14(%ebp)
  800951:	ff 75 10             	pushl  0x10(%ebp)
  800954:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800957:	50                   	push   %eax
  800958:	68 e4 08 80 00       	push   $0x8008e4
  80095d:	e8 92 fb ff ff       	call   8004f4 <vprintfmt>
  800962:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800965:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800968:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80096b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80096e:	c9                   	leave  
  80096f:	c3                   	ret    

00800970 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800970:	55                   	push   %ebp
  800971:	89 e5                	mov    %esp,%ebp
  800973:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800976:	8d 45 10             	lea    0x10(%ebp),%eax
  800979:	83 c0 04             	add    $0x4,%eax
  80097c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80097f:	8b 45 10             	mov    0x10(%ebp),%eax
  800982:	ff 75 f4             	pushl  -0xc(%ebp)
  800985:	50                   	push   %eax
  800986:	ff 75 0c             	pushl  0xc(%ebp)
  800989:	ff 75 08             	pushl  0x8(%ebp)
  80098c:	e8 89 ff ff ff       	call   80091a <vsnprintf>
  800991:	83 c4 10             	add    $0x10,%esp
  800994:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800997:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80099a:	c9                   	leave  
  80099b:	c3                   	ret    

0080099c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80099c:	55                   	push   %ebp
  80099d:	89 e5                	mov    %esp,%ebp
  80099f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8009a2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009a9:	eb 06                	jmp    8009b1 <strlen+0x15>
		n++;
  8009ab:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8009ae:	ff 45 08             	incl   0x8(%ebp)
  8009b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b4:	8a 00                	mov    (%eax),%al
  8009b6:	84 c0                	test   %al,%al
  8009b8:	75 f1                	jne    8009ab <strlen+0xf>
		n++;
	return n;
  8009ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009bd:	c9                   	leave  
  8009be:	c3                   	ret    

008009bf <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8009bf:	55                   	push   %ebp
  8009c0:	89 e5                	mov    %esp,%ebp
  8009c2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009c5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009cc:	eb 09                	jmp    8009d7 <strnlen+0x18>
		n++;
  8009ce:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009d1:	ff 45 08             	incl   0x8(%ebp)
  8009d4:	ff 4d 0c             	decl   0xc(%ebp)
  8009d7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009db:	74 09                	je     8009e6 <strnlen+0x27>
  8009dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e0:	8a 00                	mov    (%eax),%al
  8009e2:	84 c0                	test   %al,%al
  8009e4:	75 e8                	jne    8009ce <strnlen+0xf>
		n++;
	return n;
  8009e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009e9:	c9                   	leave  
  8009ea:	c3                   	ret    

008009eb <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8009eb:	55                   	push   %ebp
  8009ec:	89 e5                	mov    %esp,%ebp
  8009ee:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8009f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8009f7:	90                   	nop
  8009f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fb:	8d 50 01             	lea    0x1(%eax),%edx
  8009fe:	89 55 08             	mov    %edx,0x8(%ebp)
  800a01:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a04:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a07:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a0a:	8a 12                	mov    (%edx),%dl
  800a0c:	88 10                	mov    %dl,(%eax)
  800a0e:	8a 00                	mov    (%eax),%al
  800a10:	84 c0                	test   %al,%al
  800a12:	75 e4                	jne    8009f8 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a14:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a17:	c9                   	leave  
  800a18:	c3                   	ret    

00800a19 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a19:	55                   	push   %ebp
  800a1a:	89 e5                	mov    %esp,%ebp
  800a1c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a22:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a25:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a2c:	eb 1f                	jmp    800a4d <strncpy+0x34>
		*dst++ = *src;
  800a2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a31:	8d 50 01             	lea    0x1(%eax),%edx
  800a34:	89 55 08             	mov    %edx,0x8(%ebp)
  800a37:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a3a:	8a 12                	mov    (%edx),%dl
  800a3c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a41:	8a 00                	mov    (%eax),%al
  800a43:	84 c0                	test   %al,%al
  800a45:	74 03                	je     800a4a <strncpy+0x31>
			src++;
  800a47:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a4a:	ff 45 fc             	incl   -0x4(%ebp)
  800a4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a50:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a53:	72 d9                	jb     800a2e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a55:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a58:	c9                   	leave  
  800a59:	c3                   	ret    

00800a5a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a5a:	55                   	push   %ebp
  800a5b:	89 e5                	mov    %esp,%ebp
  800a5d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a60:	8b 45 08             	mov    0x8(%ebp),%eax
  800a63:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a66:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a6a:	74 30                	je     800a9c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a6c:	eb 16                	jmp    800a84 <strlcpy+0x2a>
			*dst++ = *src++;
  800a6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a71:	8d 50 01             	lea    0x1(%eax),%edx
  800a74:	89 55 08             	mov    %edx,0x8(%ebp)
  800a77:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a7a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a7d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a80:	8a 12                	mov    (%edx),%dl
  800a82:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a84:	ff 4d 10             	decl   0x10(%ebp)
  800a87:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a8b:	74 09                	je     800a96 <strlcpy+0x3c>
  800a8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a90:	8a 00                	mov    (%eax),%al
  800a92:	84 c0                	test   %al,%al
  800a94:	75 d8                	jne    800a6e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a96:	8b 45 08             	mov    0x8(%ebp),%eax
  800a99:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a9c:	8b 55 08             	mov    0x8(%ebp),%edx
  800a9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800aa2:	29 c2                	sub    %eax,%edx
  800aa4:	89 d0                	mov    %edx,%eax
}
  800aa6:	c9                   	leave  
  800aa7:	c3                   	ret    

00800aa8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800aa8:	55                   	push   %ebp
  800aa9:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800aab:	eb 06                	jmp    800ab3 <strcmp+0xb>
		p++, q++;
  800aad:	ff 45 08             	incl   0x8(%ebp)
  800ab0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ab3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab6:	8a 00                	mov    (%eax),%al
  800ab8:	84 c0                	test   %al,%al
  800aba:	74 0e                	je     800aca <strcmp+0x22>
  800abc:	8b 45 08             	mov    0x8(%ebp),%eax
  800abf:	8a 10                	mov    (%eax),%dl
  800ac1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac4:	8a 00                	mov    (%eax),%al
  800ac6:	38 c2                	cmp    %al,%dl
  800ac8:	74 e3                	je     800aad <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800aca:	8b 45 08             	mov    0x8(%ebp),%eax
  800acd:	8a 00                	mov    (%eax),%al
  800acf:	0f b6 d0             	movzbl %al,%edx
  800ad2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad5:	8a 00                	mov    (%eax),%al
  800ad7:	0f b6 c0             	movzbl %al,%eax
  800ada:	29 c2                	sub    %eax,%edx
  800adc:	89 d0                	mov    %edx,%eax
}
  800ade:	5d                   	pop    %ebp
  800adf:	c3                   	ret    

00800ae0 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ae0:	55                   	push   %ebp
  800ae1:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ae3:	eb 09                	jmp    800aee <strncmp+0xe>
		n--, p++, q++;
  800ae5:	ff 4d 10             	decl   0x10(%ebp)
  800ae8:	ff 45 08             	incl   0x8(%ebp)
  800aeb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800aee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800af2:	74 17                	je     800b0b <strncmp+0x2b>
  800af4:	8b 45 08             	mov    0x8(%ebp),%eax
  800af7:	8a 00                	mov    (%eax),%al
  800af9:	84 c0                	test   %al,%al
  800afb:	74 0e                	je     800b0b <strncmp+0x2b>
  800afd:	8b 45 08             	mov    0x8(%ebp),%eax
  800b00:	8a 10                	mov    (%eax),%dl
  800b02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b05:	8a 00                	mov    (%eax),%al
  800b07:	38 c2                	cmp    %al,%dl
  800b09:	74 da                	je     800ae5 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b0b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b0f:	75 07                	jne    800b18 <strncmp+0x38>
		return 0;
  800b11:	b8 00 00 00 00       	mov    $0x0,%eax
  800b16:	eb 14                	jmp    800b2c <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b18:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1b:	8a 00                	mov    (%eax),%al
  800b1d:	0f b6 d0             	movzbl %al,%edx
  800b20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b23:	8a 00                	mov    (%eax),%al
  800b25:	0f b6 c0             	movzbl %al,%eax
  800b28:	29 c2                	sub    %eax,%edx
  800b2a:	89 d0                	mov    %edx,%eax
}
  800b2c:	5d                   	pop    %ebp
  800b2d:	c3                   	ret    

00800b2e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b2e:	55                   	push   %ebp
  800b2f:	89 e5                	mov    %esp,%ebp
  800b31:	83 ec 04             	sub    $0x4,%esp
  800b34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b37:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b3a:	eb 12                	jmp    800b4e <strchr+0x20>
		if (*s == c)
  800b3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3f:	8a 00                	mov    (%eax),%al
  800b41:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b44:	75 05                	jne    800b4b <strchr+0x1d>
			return (char *) s;
  800b46:	8b 45 08             	mov    0x8(%ebp),%eax
  800b49:	eb 11                	jmp    800b5c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b4b:	ff 45 08             	incl   0x8(%ebp)
  800b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b51:	8a 00                	mov    (%eax),%al
  800b53:	84 c0                	test   %al,%al
  800b55:	75 e5                	jne    800b3c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b57:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b5c:	c9                   	leave  
  800b5d:	c3                   	ret    

00800b5e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b5e:	55                   	push   %ebp
  800b5f:	89 e5                	mov    %esp,%ebp
  800b61:	83 ec 04             	sub    $0x4,%esp
  800b64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b67:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b6a:	eb 0d                	jmp    800b79 <strfind+0x1b>
		if (*s == c)
  800b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6f:	8a 00                	mov    (%eax),%al
  800b71:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b74:	74 0e                	je     800b84 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b76:	ff 45 08             	incl   0x8(%ebp)
  800b79:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7c:	8a 00                	mov    (%eax),%al
  800b7e:	84 c0                	test   %al,%al
  800b80:	75 ea                	jne    800b6c <strfind+0xe>
  800b82:	eb 01                	jmp    800b85 <strfind+0x27>
		if (*s == c)
			break;
  800b84:	90                   	nop
	return (char *) s;
  800b85:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b88:	c9                   	leave  
  800b89:	c3                   	ret    

00800b8a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b8a:	55                   	push   %ebp
  800b8b:	89 e5                	mov    %esp,%ebp
  800b8d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b90:	8b 45 08             	mov    0x8(%ebp),%eax
  800b93:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b96:	8b 45 10             	mov    0x10(%ebp),%eax
  800b99:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b9c:	eb 0e                	jmp    800bac <memset+0x22>
		*p++ = c;
  800b9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ba1:	8d 50 01             	lea    0x1(%eax),%edx
  800ba4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ba7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800baa:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800bac:	ff 4d f8             	decl   -0x8(%ebp)
  800baf:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800bb3:	79 e9                	jns    800b9e <memset+0x14>
		*p++ = c;

	return v;
  800bb5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bb8:	c9                   	leave  
  800bb9:	c3                   	ret    

00800bba <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800bba:	55                   	push   %ebp
  800bbb:	89 e5                	mov    %esp,%ebp
  800bbd:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800bc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800bcc:	eb 16                	jmp    800be4 <memcpy+0x2a>
		*d++ = *s++;
  800bce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bd1:	8d 50 01             	lea    0x1(%eax),%edx
  800bd4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bd7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bda:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bdd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800be0:	8a 12                	mov    (%edx),%dl
  800be2:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800be4:	8b 45 10             	mov    0x10(%ebp),%eax
  800be7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bea:	89 55 10             	mov    %edx,0x10(%ebp)
  800bed:	85 c0                	test   %eax,%eax
  800bef:	75 dd                	jne    800bce <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800bf1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bf4:	c9                   	leave  
  800bf5:	c3                   	ret    

00800bf6 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800bf6:	55                   	push   %ebp
  800bf7:	89 e5                	mov    %esp,%ebp
  800bf9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800bfc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c02:	8b 45 08             	mov    0x8(%ebp),%eax
  800c05:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c08:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c0b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c0e:	73 50                	jae    800c60 <memmove+0x6a>
  800c10:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c13:	8b 45 10             	mov    0x10(%ebp),%eax
  800c16:	01 d0                	add    %edx,%eax
  800c18:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c1b:	76 43                	jbe    800c60 <memmove+0x6a>
		s += n;
  800c1d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c20:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c23:	8b 45 10             	mov    0x10(%ebp),%eax
  800c26:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c29:	eb 10                	jmp    800c3b <memmove+0x45>
			*--d = *--s;
  800c2b:	ff 4d f8             	decl   -0x8(%ebp)
  800c2e:	ff 4d fc             	decl   -0x4(%ebp)
  800c31:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c34:	8a 10                	mov    (%eax),%dl
  800c36:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c39:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c3b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c41:	89 55 10             	mov    %edx,0x10(%ebp)
  800c44:	85 c0                	test   %eax,%eax
  800c46:	75 e3                	jne    800c2b <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c48:	eb 23                	jmp    800c6d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c4a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c4d:	8d 50 01             	lea    0x1(%eax),%edx
  800c50:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c53:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c56:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c59:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c5c:	8a 12                	mov    (%edx),%dl
  800c5e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c60:	8b 45 10             	mov    0x10(%ebp),%eax
  800c63:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c66:	89 55 10             	mov    %edx,0x10(%ebp)
  800c69:	85 c0                	test   %eax,%eax
  800c6b:	75 dd                	jne    800c4a <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c6d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c70:	c9                   	leave  
  800c71:	c3                   	ret    

00800c72 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c72:	55                   	push   %ebp
  800c73:	89 e5                	mov    %esp,%ebp
  800c75:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c78:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c81:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c84:	eb 2a                	jmp    800cb0 <memcmp+0x3e>
		if (*s1 != *s2)
  800c86:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c89:	8a 10                	mov    (%eax),%dl
  800c8b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c8e:	8a 00                	mov    (%eax),%al
  800c90:	38 c2                	cmp    %al,%dl
  800c92:	74 16                	je     800caa <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c94:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c97:	8a 00                	mov    (%eax),%al
  800c99:	0f b6 d0             	movzbl %al,%edx
  800c9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c9f:	8a 00                	mov    (%eax),%al
  800ca1:	0f b6 c0             	movzbl %al,%eax
  800ca4:	29 c2                	sub    %eax,%edx
  800ca6:	89 d0                	mov    %edx,%eax
  800ca8:	eb 18                	jmp    800cc2 <memcmp+0x50>
		s1++, s2++;
  800caa:	ff 45 fc             	incl   -0x4(%ebp)
  800cad:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800cb0:	8b 45 10             	mov    0x10(%ebp),%eax
  800cb3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cb6:	89 55 10             	mov    %edx,0x10(%ebp)
  800cb9:	85 c0                	test   %eax,%eax
  800cbb:	75 c9                	jne    800c86 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800cbd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cc2:	c9                   	leave  
  800cc3:	c3                   	ret    

00800cc4 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800cc4:	55                   	push   %ebp
  800cc5:	89 e5                	mov    %esp,%ebp
  800cc7:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800cca:	8b 55 08             	mov    0x8(%ebp),%edx
  800ccd:	8b 45 10             	mov    0x10(%ebp),%eax
  800cd0:	01 d0                	add    %edx,%eax
  800cd2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800cd5:	eb 15                	jmp    800cec <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800cd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cda:	8a 00                	mov    (%eax),%al
  800cdc:	0f b6 d0             	movzbl %al,%edx
  800cdf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce2:	0f b6 c0             	movzbl %al,%eax
  800ce5:	39 c2                	cmp    %eax,%edx
  800ce7:	74 0d                	je     800cf6 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ce9:	ff 45 08             	incl   0x8(%ebp)
  800cec:	8b 45 08             	mov    0x8(%ebp),%eax
  800cef:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800cf2:	72 e3                	jb     800cd7 <memfind+0x13>
  800cf4:	eb 01                	jmp    800cf7 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800cf6:	90                   	nop
	return (void *) s;
  800cf7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cfa:	c9                   	leave  
  800cfb:	c3                   	ret    

00800cfc <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800cfc:	55                   	push   %ebp
  800cfd:	89 e5                	mov    %esp,%ebp
  800cff:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d02:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d09:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d10:	eb 03                	jmp    800d15 <strtol+0x19>
		s++;
  800d12:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d15:	8b 45 08             	mov    0x8(%ebp),%eax
  800d18:	8a 00                	mov    (%eax),%al
  800d1a:	3c 20                	cmp    $0x20,%al
  800d1c:	74 f4                	je     800d12 <strtol+0x16>
  800d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d21:	8a 00                	mov    (%eax),%al
  800d23:	3c 09                	cmp    $0x9,%al
  800d25:	74 eb                	je     800d12 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d27:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2a:	8a 00                	mov    (%eax),%al
  800d2c:	3c 2b                	cmp    $0x2b,%al
  800d2e:	75 05                	jne    800d35 <strtol+0x39>
		s++;
  800d30:	ff 45 08             	incl   0x8(%ebp)
  800d33:	eb 13                	jmp    800d48 <strtol+0x4c>
	else if (*s == '-')
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	8a 00                	mov    (%eax),%al
  800d3a:	3c 2d                	cmp    $0x2d,%al
  800d3c:	75 0a                	jne    800d48 <strtol+0x4c>
		s++, neg = 1;
  800d3e:	ff 45 08             	incl   0x8(%ebp)
  800d41:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d48:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d4c:	74 06                	je     800d54 <strtol+0x58>
  800d4e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d52:	75 20                	jne    800d74 <strtol+0x78>
  800d54:	8b 45 08             	mov    0x8(%ebp),%eax
  800d57:	8a 00                	mov    (%eax),%al
  800d59:	3c 30                	cmp    $0x30,%al
  800d5b:	75 17                	jne    800d74 <strtol+0x78>
  800d5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d60:	40                   	inc    %eax
  800d61:	8a 00                	mov    (%eax),%al
  800d63:	3c 78                	cmp    $0x78,%al
  800d65:	75 0d                	jne    800d74 <strtol+0x78>
		s += 2, base = 16;
  800d67:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d6b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d72:	eb 28                	jmp    800d9c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d74:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d78:	75 15                	jne    800d8f <strtol+0x93>
  800d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7d:	8a 00                	mov    (%eax),%al
  800d7f:	3c 30                	cmp    $0x30,%al
  800d81:	75 0c                	jne    800d8f <strtol+0x93>
		s++, base = 8;
  800d83:	ff 45 08             	incl   0x8(%ebp)
  800d86:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d8d:	eb 0d                	jmp    800d9c <strtol+0xa0>
	else if (base == 0)
  800d8f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d93:	75 07                	jne    800d9c <strtol+0xa0>
		base = 10;
  800d95:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9f:	8a 00                	mov    (%eax),%al
  800da1:	3c 2f                	cmp    $0x2f,%al
  800da3:	7e 19                	jle    800dbe <strtol+0xc2>
  800da5:	8b 45 08             	mov    0x8(%ebp),%eax
  800da8:	8a 00                	mov    (%eax),%al
  800daa:	3c 39                	cmp    $0x39,%al
  800dac:	7f 10                	jg     800dbe <strtol+0xc2>
			dig = *s - '0';
  800dae:	8b 45 08             	mov    0x8(%ebp),%eax
  800db1:	8a 00                	mov    (%eax),%al
  800db3:	0f be c0             	movsbl %al,%eax
  800db6:	83 e8 30             	sub    $0x30,%eax
  800db9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dbc:	eb 42                	jmp    800e00 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800dbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc1:	8a 00                	mov    (%eax),%al
  800dc3:	3c 60                	cmp    $0x60,%al
  800dc5:	7e 19                	jle    800de0 <strtol+0xe4>
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dca:	8a 00                	mov    (%eax),%al
  800dcc:	3c 7a                	cmp    $0x7a,%al
  800dce:	7f 10                	jg     800de0 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800dd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd3:	8a 00                	mov    (%eax),%al
  800dd5:	0f be c0             	movsbl %al,%eax
  800dd8:	83 e8 57             	sub    $0x57,%eax
  800ddb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dde:	eb 20                	jmp    800e00 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800de0:	8b 45 08             	mov    0x8(%ebp),%eax
  800de3:	8a 00                	mov    (%eax),%al
  800de5:	3c 40                	cmp    $0x40,%al
  800de7:	7e 39                	jle    800e22 <strtol+0x126>
  800de9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dec:	8a 00                	mov    (%eax),%al
  800dee:	3c 5a                	cmp    $0x5a,%al
  800df0:	7f 30                	jg     800e22 <strtol+0x126>
			dig = *s - 'A' + 10;
  800df2:	8b 45 08             	mov    0x8(%ebp),%eax
  800df5:	8a 00                	mov    (%eax),%al
  800df7:	0f be c0             	movsbl %al,%eax
  800dfa:	83 e8 37             	sub    $0x37,%eax
  800dfd:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e00:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e03:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e06:	7d 19                	jge    800e21 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e08:	ff 45 08             	incl   0x8(%ebp)
  800e0b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e0e:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e12:	89 c2                	mov    %eax,%edx
  800e14:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e17:	01 d0                	add    %edx,%eax
  800e19:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e1c:	e9 7b ff ff ff       	jmp    800d9c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e21:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e22:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e26:	74 08                	je     800e30 <strtol+0x134>
		*endptr = (char *) s;
  800e28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2b:	8b 55 08             	mov    0x8(%ebp),%edx
  800e2e:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e30:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e34:	74 07                	je     800e3d <strtol+0x141>
  800e36:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e39:	f7 d8                	neg    %eax
  800e3b:	eb 03                	jmp    800e40 <strtol+0x144>
  800e3d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e40:	c9                   	leave  
  800e41:	c3                   	ret    

00800e42 <ltostr>:

void
ltostr(long value, char *str)
{
  800e42:	55                   	push   %ebp
  800e43:	89 e5                	mov    %esp,%ebp
  800e45:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e48:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e4f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e56:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e5a:	79 13                	jns    800e6f <ltostr+0x2d>
	{
		neg = 1;
  800e5c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e66:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e69:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e6c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e72:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e77:	99                   	cltd   
  800e78:	f7 f9                	idiv   %ecx
  800e7a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e7d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e80:	8d 50 01             	lea    0x1(%eax),%edx
  800e83:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e86:	89 c2                	mov    %eax,%edx
  800e88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8b:	01 d0                	add    %edx,%eax
  800e8d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e90:	83 c2 30             	add    $0x30,%edx
  800e93:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e95:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e98:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e9d:	f7 e9                	imul   %ecx
  800e9f:	c1 fa 02             	sar    $0x2,%edx
  800ea2:	89 c8                	mov    %ecx,%eax
  800ea4:	c1 f8 1f             	sar    $0x1f,%eax
  800ea7:	29 c2                	sub    %eax,%edx
  800ea9:	89 d0                	mov    %edx,%eax
  800eab:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800eae:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800eb1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800eb6:	f7 e9                	imul   %ecx
  800eb8:	c1 fa 02             	sar    $0x2,%edx
  800ebb:	89 c8                	mov    %ecx,%eax
  800ebd:	c1 f8 1f             	sar    $0x1f,%eax
  800ec0:	29 c2                	sub    %eax,%edx
  800ec2:	89 d0                	mov    %edx,%eax
  800ec4:	c1 e0 02             	shl    $0x2,%eax
  800ec7:	01 d0                	add    %edx,%eax
  800ec9:	01 c0                	add    %eax,%eax
  800ecb:	29 c1                	sub    %eax,%ecx
  800ecd:	89 ca                	mov    %ecx,%edx
  800ecf:	85 d2                	test   %edx,%edx
  800ed1:	75 9c                	jne    800e6f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800ed3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800eda:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800edd:	48                   	dec    %eax
  800ede:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800ee1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ee5:	74 3d                	je     800f24 <ltostr+0xe2>
		start = 1 ;
  800ee7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800eee:	eb 34                	jmp    800f24 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800ef0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ef3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef6:	01 d0                	add    %edx,%eax
  800ef8:	8a 00                	mov    (%eax),%al
  800efa:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800efd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f03:	01 c2                	add    %eax,%edx
  800f05:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f08:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0b:	01 c8                	add    %ecx,%eax
  800f0d:	8a 00                	mov    (%eax),%al
  800f0f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f11:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f17:	01 c2                	add    %eax,%edx
  800f19:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f1c:	88 02                	mov    %al,(%edx)
		start++ ;
  800f1e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f21:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f24:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f27:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f2a:	7c c4                	jl     800ef0 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f2c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f32:	01 d0                	add    %edx,%eax
  800f34:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f37:	90                   	nop
  800f38:	c9                   	leave  
  800f39:	c3                   	ret    

00800f3a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f3a:	55                   	push   %ebp
  800f3b:	89 e5                	mov    %esp,%ebp
  800f3d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f40:	ff 75 08             	pushl  0x8(%ebp)
  800f43:	e8 54 fa ff ff       	call   80099c <strlen>
  800f48:	83 c4 04             	add    $0x4,%esp
  800f4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f4e:	ff 75 0c             	pushl  0xc(%ebp)
  800f51:	e8 46 fa ff ff       	call   80099c <strlen>
  800f56:	83 c4 04             	add    $0x4,%esp
  800f59:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f5c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f63:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f6a:	eb 17                	jmp    800f83 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f6c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f6f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f72:	01 c2                	add    %eax,%edx
  800f74:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f77:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7a:	01 c8                	add    %ecx,%eax
  800f7c:	8a 00                	mov    (%eax),%al
  800f7e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f80:	ff 45 fc             	incl   -0x4(%ebp)
  800f83:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f86:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f89:	7c e1                	jl     800f6c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f8b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f92:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f99:	eb 1f                	jmp    800fba <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f9e:	8d 50 01             	lea    0x1(%eax),%edx
  800fa1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fa4:	89 c2                	mov    %eax,%edx
  800fa6:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa9:	01 c2                	add    %eax,%edx
  800fab:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800fae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb1:	01 c8                	add    %ecx,%eax
  800fb3:	8a 00                	mov    (%eax),%al
  800fb5:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800fb7:	ff 45 f8             	incl   -0x8(%ebp)
  800fba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fbd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fc0:	7c d9                	jl     800f9b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800fc2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fc5:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc8:	01 d0                	add    %edx,%eax
  800fca:	c6 00 00             	movb   $0x0,(%eax)
}
  800fcd:	90                   	nop
  800fce:	c9                   	leave  
  800fcf:	c3                   	ret    

00800fd0 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800fd0:	55                   	push   %ebp
  800fd1:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800fd3:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800fdc:	8b 45 14             	mov    0x14(%ebp),%eax
  800fdf:	8b 00                	mov    (%eax),%eax
  800fe1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fe8:	8b 45 10             	mov    0x10(%ebp),%eax
  800feb:	01 d0                	add    %edx,%eax
  800fed:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800ff3:	eb 0c                	jmp    801001 <strsplit+0x31>
			*string++ = 0;
  800ff5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff8:	8d 50 01             	lea    0x1(%eax),%edx
  800ffb:	89 55 08             	mov    %edx,0x8(%ebp)
  800ffe:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801001:	8b 45 08             	mov    0x8(%ebp),%eax
  801004:	8a 00                	mov    (%eax),%al
  801006:	84 c0                	test   %al,%al
  801008:	74 18                	je     801022 <strsplit+0x52>
  80100a:	8b 45 08             	mov    0x8(%ebp),%eax
  80100d:	8a 00                	mov    (%eax),%al
  80100f:	0f be c0             	movsbl %al,%eax
  801012:	50                   	push   %eax
  801013:	ff 75 0c             	pushl  0xc(%ebp)
  801016:	e8 13 fb ff ff       	call   800b2e <strchr>
  80101b:	83 c4 08             	add    $0x8,%esp
  80101e:	85 c0                	test   %eax,%eax
  801020:	75 d3                	jne    800ff5 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801022:	8b 45 08             	mov    0x8(%ebp),%eax
  801025:	8a 00                	mov    (%eax),%al
  801027:	84 c0                	test   %al,%al
  801029:	74 5a                	je     801085 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80102b:	8b 45 14             	mov    0x14(%ebp),%eax
  80102e:	8b 00                	mov    (%eax),%eax
  801030:	83 f8 0f             	cmp    $0xf,%eax
  801033:	75 07                	jne    80103c <strsplit+0x6c>
		{
			return 0;
  801035:	b8 00 00 00 00       	mov    $0x0,%eax
  80103a:	eb 66                	jmp    8010a2 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80103c:	8b 45 14             	mov    0x14(%ebp),%eax
  80103f:	8b 00                	mov    (%eax),%eax
  801041:	8d 48 01             	lea    0x1(%eax),%ecx
  801044:	8b 55 14             	mov    0x14(%ebp),%edx
  801047:	89 0a                	mov    %ecx,(%edx)
  801049:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801050:	8b 45 10             	mov    0x10(%ebp),%eax
  801053:	01 c2                	add    %eax,%edx
  801055:	8b 45 08             	mov    0x8(%ebp),%eax
  801058:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80105a:	eb 03                	jmp    80105f <strsplit+0x8f>
			string++;
  80105c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80105f:	8b 45 08             	mov    0x8(%ebp),%eax
  801062:	8a 00                	mov    (%eax),%al
  801064:	84 c0                	test   %al,%al
  801066:	74 8b                	je     800ff3 <strsplit+0x23>
  801068:	8b 45 08             	mov    0x8(%ebp),%eax
  80106b:	8a 00                	mov    (%eax),%al
  80106d:	0f be c0             	movsbl %al,%eax
  801070:	50                   	push   %eax
  801071:	ff 75 0c             	pushl  0xc(%ebp)
  801074:	e8 b5 fa ff ff       	call   800b2e <strchr>
  801079:	83 c4 08             	add    $0x8,%esp
  80107c:	85 c0                	test   %eax,%eax
  80107e:	74 dc                	je     80105c <strsplit+0x8c>
			string++;
	}
  801080:	e9 6e ff ff ff       	jmp    800ff3 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801085:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801086:	8b 45 14             	mov    0x14(%ebp),%eax
  801089:	8b 00                	mov    (%eax),%eax
  80108b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801092:	8b 45 10             	mov    0x10(%ebp),%eax
  801095:	01 d0                	add    %edx,%eax
  801097:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80109d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8010a2:	c9                   	leave  
  8010a3:	c3                   	ret    

008010a4 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8010a4:	55                   	push   %ebp
  8010a5:	89 e5                	mov    %esp,%ebp
  8010a7:	57                   	push   %edi
  8010a8:	56                   	push   %esi
  8010a9:	53                   	push   %ebx
  8010aa:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8010ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010b3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010b6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010b9:	8b 7d 18             	mov    0x18(%ebp),%edi
  8010bc:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8010bf:	cd 30                	int    $0x30
  8010c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8010c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010c7:	83 c4 10             	add    $0x10,%esp
  8010ca:	5b                   	pop    %ebx
  8010cb:	5e                   	pop    %esi
  8010cc:	5f                   	pop    %edi
  8010cd:	5d                   	pop    %ebp
  8010ce:	c3                   	ret    

008010cf <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8010cf:	55                   	push   %ebp
  8010d0:	89 e5                	mov    %esp,%ebp
  8010d2:	83 ec 04             	sub    $0x4,%esp
  8010d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8010db:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8010df:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e2:	6a 00                	push   $0x0
  8010e4:	6a 00                	push   $0x0
  8010e6:	52                   	push   %edx
  8010e7:	ff 75 0c             	pushl  0xc(%ebp)
  8010ea:	50                   	push   %eax
  8010eb:	6a 00                	push   $0x0
  8010ed:	e8 b2 ff ff ff       	call   8010a4 <syscall>
  8010f2:	83 c4 18             	add    $0x18,%esp
}
  8010f5:	90                   	nop
  8010f6:	c9                   	leave  
  8010f7:	c3                   	ret    

008010f8 <sys_cgetc>:

int
sys_cgetc(void)
{
  8010f8:	55                   	push   %ebp
  8010f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8010fb:	6a 00                	push   $0x0
  8010fd:	6a 00                	push   $0x0
  8010ff:	6a 00                	push   $0x0
  801101:	6a 00                	push   $0x0
  801103:	6a 00                	push   $0x0
  801105:	6a 01                	push   $0x1
  801107:	e8 98 ff ff ff       	call   8010a4 <syscall>
  80110c:	83 c4 18             	add    $0x18,%esp
}
  80110f:	c9                   	leave  
  801110:	c3                   	ret    

00801111 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801111:	55                   	push   %ebp
  801112:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801114:	8b 45 08             	mov    0x8(%ebp),%eax
  801117:	6a 00                	push   $0x0
  801119:	6a 00                	push   $0x0
  80111b:	6a 00                	push   $0x0
  80111d:	6a 00                	push   $0x0
  80111f:	50                   	push   %eax
  801120:	6a 05                	push   $0x5
  801122:	e8 7d ff ff ff       	call   8010a4 <syscall>
  801127:	83 c4 18             	add    $0x18,%esp
}
  80112a:	c9                   	leave  
  80112b:	c3                   	ret    

0080112c <sys_getenvid>:

int32 sys_getenvid(void)
{
  80112c:	55                   	push   %ebp
  80112d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80112f:	6a 00                	push   $0x0
  801131:	6a 00                	push   $0x0
  801133:	6a 00                	push   $0x0
  801135:	6a 00                	push   $0x0
  801137:	6a 00                	push   $0x0
  801139:	6a 02                	push   $0x2
  80113b:	e8 64 ff ff ff       	call   8010a4 <syscall>
  801140:	83 c4 18             	add    $0x18,%esp
}
  801143:	c9                   	leave  
  801144:	c3                   	ret    

00801145 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801145:	55                   	push   %ebp
  801146:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801148:	6a 00                	push   $0x0
  80114a:	6a 00                	push   $0x0
  80114c:	6a 00                	push   $0x0
  80114e:	6a 00                	push   $0x0
  801150:	6a 00                	push   $0x0
  801152:	6a 03                	push   $0x3
  801154:	e8 4b ff ff ff       	call   8010a4 <syscall>
  801159:	83 c4 18             	add    $0x18,%esp
}
  80115c:	c9                   	leave  
  80115d:	c3                   	ret    

0080115e <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80115e:	55                   	push   %ebp
  80115f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801161:	6a 00                	push   $0x0
  801163:	6a 00                	push   $0x0
  801165:	6a 00                	push   $0x0
  801167:	6a 00                	push   $0x0
  801169:	6a 00                	push   $0x0
  80116b:	6a 04                	push   $0x4
  80116d:	e8 32 ff ff ff       	call   8010a4 <syscall>
  801172:	83 c4 18             	add    $0x18,%esp
}
  801175:	c9                   	leave  
  801176:	c3                   	ret    

00801177 <sys_env_exit>:


void sys_env_exit(void)
{
  801177:	55                   	push   %ebp
  801178:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80117a:	6a 00                	push   $0x0
  80117c:	6a 00                	push   $0x0
  80117e:	6a 00                	push   $0x0
  801180:	6a 00                	push   $0x0
  801182:	6a 00                	push   $0x0
  801184:	6a 06                	push   $0x6
  801186:	e8 19 ff ff ff       	call   8010a4 <syscall>
  80118b:	83 c4 18             	add    $0x18,%esp
}
  80118e:	90                   	nop
  80118f:	c9                   	leave  
  801190:	c3                   	ret    

00801191 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801191:	55                   	push   %ebp
  801192:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801194:	8b 55 0c             	mov    0xc(%ebp),%edx
  801197:	8b 45 08             	mov    0x8(%ebp),%eax
  80119a:	6a 00                	push   $0x0
  80119c:	6a 00                	push   $0x0
  80119e:	6a 00                	push   $0x0
  8011a0:	52                   	push   %edx
  8011a1:	50                   	push   %eax
  8011a2:	6a 07                	push   $0x7
  8011a4:	e8 fb fe ff ff       	call   8010a4 <syscall>
  8011a9:	83 c4 18             	add    $0x18,%esp
}
  8011ac:	c9                   	leave  
  8011ad:	c3                   	ret    

008011ae <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8011ae:	55                   	push   %ebp
  8011af:	89 e5                	mov    %esp,%ebp
  8011b1:	56                   	push   %esi
  8011b2:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8011b3:	8b 75 18             	mov    0x18(%ebp),%esi
  8011b6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8011b9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8011bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c2:	56                   	push   %esi
  8011c3:	53                   	push   %ebx
  8011c4:	51                   	push   %ecx
  8011c5:	52                   	push   %edx
  8011c6:	50                   	push   %eax
  8011c7:	6a 08                	push   $0x8
  8011c9:	e8 d6 fe ff ff       	call   8010a4 <syscall>
  8011ce:	83 c4 18             	add    $0x18,%esp
}
  8011d1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8011d4:	5b                   	pop    %ebx
  8011d5:	5e                   	pop    %esi
  8011d6:	5d                   	pop    %ebp
  8011d7:	c3                   	ret    

008011d8 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8011d8:	55                   	push   %ebp
  8011d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8011db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011de:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e1:	6a 00                	push   $0x0
  8011e3:	6a 00                	push   $0x0
  8011e5:	6a 00                	push   $0x0
  8011e7:	52                   	push   %edx
  8011e8:	50                   	push   %eax
  8011e9:	6a 09                	push   $0x9
  8011eb:	e8 b4 fe ff ff       	call   8010a4 <syscall>
  8011f0:	83 c4 18             	add    $0x18,%esp
}
  8011f3:	c9                   	leave  
  8011f4:	c3                   	ret    

008011f5 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8011f5:	55                   	push   %ebp
  8011f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8011f8:	6a 00                	push   $0x0
  8011fa:	6a 00                	push   $0x0
  8011fc:	6a 00                	push   $0x0
  8011fe:	ff 75 0c             	pushl  0xc(%ebp)
  801201:	ff 75 08             	pushl  0x8(%ebp)
  801204:	6a 0a                	push   $0xa
  801206:	e8 99 fe ff ff       	call   8010a4 <syscall>
  80120b:	83 c4 18             	add    $0x18,%esp
}
  80120e:	c9                   	leave  
  80120f:	c3                   	ret    

00801210 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801210:	55                   	push   %ebp
  801211:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801213:	6a 00                	push   $0x0
  801215:	6a 00                	push   $0x0
  801217:	6a 00                	push   $0x0
  801219:	6a 00                	push   $0x0
  80121b:	6a 00                	push   $0x0
  80121d:	6a 0b                	push   $0xb
  80121f:	e8 80 fe ff ff       	call   8010a4 <syscall>
  801224:	83 c4 18             	add    $0x18,%esp
}
  801227:	c9                   	leave  
  801228:	c3                   	ret    

00801229 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801229:	55                   	push   %ebp
  80122a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80122c:	6a 00                	push   $0x0
  80122e:	6a 00                	push   $0x0
  801230:	6a 00                	push   $0x0
  801232:	6a 00                	push   $0x0
  801234:	6a 00                	push   $0x0
  801236:	6a 0c                	push   $0xc
  801238:	e8 67 fe ff ff       	call   8010a4 <syscall>
  80123d:	83 c4 18             	add    $0x18,%esp
}
  801240:	c9                   	leave  
  801241:	c3                   	ret    

00801242 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801242:	55                   	push   %ebp
  801243:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801245:	6a 00                	push   $0x0
  801247:	6a 00                	push   $0x0
  801249:	6a 00                	push   $0x0
  80124b:	6a 00                	push   $0x0
  80124d:	6a 00                	push   $0x0
  80124f:	6a 0d                	push   $0xd
  801251:	e8 4e fe ff ff       	call   8010a4 <syscall>
  801256:	83 c4 18             	add    $0x18,%esp
}
  801259:	c9                   	leave  
  80125a:	c3                   	ret    

0080125b <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80125b:	55                   	push   %ebp
  80125c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80125e:	6a 00                	push   $0x0
  801260:	6a 00                	push   $0x0
  801262:	6a 00                	push   $0x0
  801264:	ff 75 0c             	pushl  0xc(%ebp)
  801267:	ff 75 08             	pushl  0x8(%ebp)
  80126a:	6a 11                	push   $0x11
  80126c:	e8 33 fe ff ff       	call   8010a4 <syscall>
  801271:	83 c4 18             	add    $0x18,%esp
	return;
  801274:	90                   	nop
}
  801275:	c9                   	leave  
  801276:	c3                   	ret    

00801277 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801277:	55                   	push   %ebp
  801278:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80127a:	6a 00                	push   $0x0
  80127c:	6a 00                	push   $0x0
  80127e:	6a 00                	push   $0x0
  801280:	ff 75 0c             	pushl  0xc(%ebp)
  801283:	ff 75 08             	pushl  0x8(%ebp)
  801286:	6a 12                	push   $0x12
  801288:	e8 17 fe ff ff       	call   8010a4 <syscall>
  80128d:	83 c4 18             	add    $0x18,%esp
	return ;
  801290:	90                   	nop
}
  801291:	c9                   	leave  
  801292:	c3                   	ret    

00801293 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801293:	55                   	push   %ebp
  801294:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801296:	6a 00                	push   $0x0
  801298:	6a 00                	push   $0x0
  80129a:	6a 00                	push   $0x0
  80129c:	6a 00                	push   $0x0
  80129e:	6a 00                	push   $0x0
  8012a0:	6a 0e                	push   $0xe
  8012a2:	e8 fd fd ff ff       	call   8010a4 <syscall>
  8012a7:	83 c4 18             	add    $0x18,%esp
}
  8012aa:	c9                   	leave  
  8012ab:	c3                   	ret    

008012ac <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8012ac:	55                   	push   %ebp
  8012ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8012af:	6a 00                	push   $0x0
  8012b1:	6a 00                	push   $0x0
  8012b3:	6a 00                	push   $0x0
  8012b5:	6a 00                	push   $0x0
  8012b7:	ff 75 08             	pushl  0x8(%ebp)
  8012ba:	6a 0f                	push   $0xf
  8012bc:	e8 e3 fd ff ff       	call   8010a4 <syscall>
  8012c1:	83 c4 18             	add    $0x18,%esp
}
  8012c4:	c9                   	leave  
  8012c5:	c3                   	ret    

008012c6 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8012c6:	55                   	push   %ebp
  8012c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8012c9:	6a 00                	push   $0x0
  8012cb:	6a 00                	push   $0x0
  8012cd:	6a 00                	push   $0x0
  8012cf:	6a 00                	push   $0x0
  8012d1:	6a 00                	push   $0x0
  8012d3:	6a 10                	push   $0x10
  8012d5:	e8 ca fd ff ff       	call   8010a4 <syscall>
  8012da:	83 c4 18             	add    $0x18,%esp
}
  8012dd:	90                   	nop
  8012de:	c9                   	leave  
  8012df:	c3                   	ret    

008012e0 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8012e0:	55                   	push   %ebp
  8012e1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8012e3:	6a 00                	push   $0x0
  8012e5:	6a 00                	push   $0x0
  8012e7:	6a 00                	push   $0x0
  8012e9:	6a 00                	push   $0x0
  8012eb:	6a 00                	push   $0x0
  8012ed:	6a 14                	push   $0x14
  8012ef:	e8 b0 fd ff ff       	call   8010a4 <syscall>
  8012f4:	83 c4 18             	add    $0x18,%esp
}
  8012f7:	90                   	nop
  8012f8:	c9                   	leave  
  8012f9:	c3                   	ret    

008012fa <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8012fa:	55                   	push   %ebp
  8012fb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8012fd:	6a 00                	push   $0x0
  8012ff:	6a 00                	push   $0x0
  801301:	6a 00                	push   $0x0
  801303:	6a 00                	push   $0x0
  801305:	6a 00                	push   $0x0
  801307:	6a 15                	push   $0x15
  801309:	e8 96 fd ff ff       	call   8010a4 <syscall>
  80130e:	83 c4 18             	add    $0x18,%esp
}
  801311:	90                   	nop
  801312:	c9                   	leave  
  801313:	c3                   	ret    

00801314 <sys_cputc>:


void
sys_cputc(const char c)
{
  801314:	55                   	push   %ebp
  801315:	89 e5                	mov    %esp,%ebp
  801317:	83 ec 04             	sub    $0x4,%esp
  80131a:	8b 45 08             	mov    0x8(%ebp),%eax
  80131d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801320:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801324:	6a 00                	push   $0x0
  801326:	6a 00                	push   $0x0
  801328:	6a 00                	push   $0x0
  80132a:	6a 00                	push   $0x0
  80132c:	50                   	push   %eax
  80132d:	6a 16                	push   $0x16
  80132f:	e8 70 fd ff ff       	call   8010a4 <syscall>
  801334:	83 c4 18             	add    $0x18,%esp
}
  801337:	90                   	nop
  801338:	c9                   	leave  
  801339:	c3                   	ret    

0080133a <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80133a:	55                   	push   %ebp
  80133b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80133d:	6a 00                	push   $0x0
  80133f:	6a 00                	push   $0x0
  801341:	6a 00                	push   $0x0
  801343:	6a 00                	push   $0x0
  801345:	6a 00                	push   $0x0
  801347:	6a 17                	push   $0x17
  801349:	e8 56 fd ff ff       	call   8010a4 <syscall>
  80134e:	83 c4 18             	add    $0x18,%esp
}
  801351:	90                   	nop
  801352:	c9                   	leave  
  801353:	c3                   	ret    

00801354 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801354:	55                   	push   %ebp
  801355:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801357:	8b 45 08             	mov    0x8(%ebp),%eax
  80135a:	6a 00                	push   $0x0
  80135c:	6a 00                	push   $0x0
  80135e:	6a 00                	push   $0x0
  801360:	ff 75 0c             	pushl  0xc(%ebp)
  801363:	50                   	push   %eax
  801364:	6a 18                	push   $0x18
  801366:	e8 39 fd ff ff       	call   8010a4 <syscall>
  80136b:	83 c4 18             	add    $0x18,%esp
}
  80136e:	c9                   	leave  
  80136f:	c3                   	ret    

00801370 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801370:	55                   	push   %ebp
  801371:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801373:	8b 55 0c             	mov    0xc(%ebp),%edx
  801376:	8b 45 08             	mov    0x8(%ebp),%eax
  801379:	6a 00                	push   $0x0
  80137b:	6a 00                	push   $0x0
  80137d:	6a 00                	push   $0x0
  80137f:	52                   	push   %edx
  801380:	50                   	push   %eax
  801381:	6a 1b                	push   $0x1b
  801383:	e8 1c fd ff ff       	call   8010a4 <syscall>
  801388:	83 c4 18             	add    $0x18,%esp
}
  80138b:	c9                   	leave  
  80138c:	c3                   	ret    

0080138d <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80138d:	55                   	push   %ebp
  80138e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801390:	8b 55 0c             	mov    0xc(%ebp),%edx
  801393:	8b 45 08             	mov    0x8(%ebp),%eax
  801396:	6a 00                	push   $0x0
  801398:	6a 00                	push   $0x0
  80139a:	6a 00                	push   $0x0
  80139c:	52                   	push   %edx
  80139d:	50                   	push   %eax
  80139e:	6a 19                	push   $0x19
  8013a0:	e8 ff fc ff ff       	call   8010a4 <syscall>
  8013a5:	83 c4 18             	add    $0x18,%esp
}
  8013a8:	90                   	nop
  8013a9:	c9                   	leave  
  8013aa:	c3                   	ret    

008013ab <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8013ab:	55                   	push   %ebp
  8013ac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8013ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b4:	6a 00                	push   $0x0
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 00                	push   $0x0
  8013ba:	52                   	push   %edx
  8013bb:	50                   	push   %eax
  8013bc:	6a 1a                	push   $0x1a
  8013be:	e8 e1 fc ff ff       	call   8010a4 <syscall>
  8013c3:	83 c4 18             	add    $0x18,%esp
}
  8013c6:	90                   	nop
  8013c7:	c9                   	leave  
  8013c8:	c3                   	ret    

008013c9 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8013c9:	55                   	push   %ebp
  8013ca:	89 e5                	mov    %esp,%ebp
  8013cc:	83 ec 04             	sub    $0x4,%esp
  8013cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d2:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8013d5:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8013d8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8013dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013df:	6a 00                	push   $0x0
  8013e1:	51                   	push   %ecx
  8013e2:	52                   	push   %edx
  8013e3:	ff 75 0c             	pushl  0xc(%ebp)
  8013e6:	50                   	push   %eax
  8013e7:	6a 1c                	push   $0x1c
  8013e9:	e8 b6 fc ff ff       	call   8010a4 <syscall>
  8013ee:	83 c4 18             	add    $0x18,%esp
}
  8013f1:	c9                   	leave  
  8013f2:	c3                   	ret    

008013f3 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8013f3:	55                   	push   %ebp
  8013f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8013f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fc:	6a 00                	push   $0x0
  8013fe:	6a 00                	push   $0x0
  801400:	6a 00                	push   $0x0
  801402:	52                   	push   %edx
  801403:	50                   	push   %eax
  801404:	6a 1d                	push   $0x1d
  801406:	e8 99 fc ff ff       	call   8010a4 <syscall>
  80140b:	83 c4 18             	add    $0x18,%esp
}
  80140e:	c9                   	leave  
  80140f:	c3                   	ret    

00801410 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801410:	55                   	push   %ebp
  801411:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801413:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801416:	8b 55 0c             	mov    0xc(%ebp),%edx
  801419:	8b 45 08             	mov    0x8(%ebp),%eax
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	51                   	push   %ecx
  801421:	52                   	push   %edx
  801422:	50                   	push   %eax
  801423:	6a 1e                	push   $0x1e
  801425:	e8 7a fc ff ff       	call   8010a4 <syscall>
  80142a:	83 c4 18             	add    $0x18,%esp
}
  80142d:	c9                   	leave  
  80142e:	c3                   	ret    

0080142f <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80142f:	55                   	push   %ebp
  801430:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801432:	8b 55 0c             	mov    0xc(%ebp),%edx
  801435:	8b 45 08             	mov    0x8(%ebp),%eax
  801438:	6a 00                	push   $0x0
  80143a:	6a 00                	push   $0x0
  80143c:	6a 00                	push   $0x0
  80143e:	52                   	push   %edx
  80143f:	50                   	push   %eax
  801440:	6a 1f                	push   $0x1f
  801442:	e8 5d fc ff ff       	call   8010a4 <syscall>
  801447:	83 c4 18             	add    $0x18,%esp
}
  80144a:	c9                   	leave  
  80144b:	c3                   	ret    

0080144c <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80144c:	55                   	push   %ebp
  80144d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80144f:	6a 00                	push   $0x0
  801451:	6a 00                	push   $0x0
  801453:	6a 00                	push   $0x0
  801455:	6a 00                	push   $0x0
  801457:	6a 00                	push   $0x0
  801459:	6a 20                	push   $0x20
  80145b:	e8 44 fc ff ff       	call   8010a4 <syscall>
  801460:	83 c4 18             	add    $0x18,%esp
}
  801463:	c9                   	leave  
  801464:	c3                   	ret    

00801465 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801465:	55                   	push   %ebp
  801466:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801468:	8b 45 08             	mov    0x8(%ebp),%eax
  80146b:	6a 00                	push   $0x0
  80146d:	ff 75 14             	pushl  0x14(%ebp)
  801470:	ff 75 10             	pushl  0x10(%ebp)
  801473:	ff 75 0c             	pushl  0xc(%ebp)
  801476:	50                   	push   %eax
  801477:	6a 21                	push   $0x21
  801479:	e8 26 fc ff ff       	call   8010a4 <syscall>
  80147e:	83 c4 18             	add    $0x18,%esp
}
  801481:	c9                   	leave  
  801482:	c3                   	ret    

00801483 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801483:	55                   	push   %ebp
  801484:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801486:	8b 45 08             	mov    0x8(%ebp),%eax
  801489:	6a 00                	push   $0x0
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	50                   	push   %eax
  801492:	6a 22                	push   $0x22
  801494:	e8 0b fc ff ff       	call   8010a4 <syscall>
  801499:	83 c4 18             	add    $0x18,%esp
}
  80149c:	90                   	nop
  80149d:	c9                   	leave  
  80149e:	c3                   	ret    

0080149f <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80149f:	55                   	push   %ebp
  8014a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8014a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a5:	6a 00                	push   $0x0
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	50                   	push   %eax
  8014ae:	6a 23                	push   $0x23
  8014b0:	e8 ef fb ff ff       	call   8010a4 <syscall>
  8014b5:	83 c4 18             	add    $0x18,%esp
}
  8014b8:	90                   	nop
  8014b9:	c9                   	leave  
  8014ba:	c3                   	ret    

008014bb <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8014bb:	55                   	push   %ebp
  8014bc:	89 e5                	mov    %esp,%ebp
  8014be:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8014c1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8014c4:	8d 50 04             	lea    0x4(%eax),%edx
  8014c7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	52                   	push   %edx
  8014d1:	50                   	push   %eax
  8014d2:	6a 24                	push   $0x24
  8014d4:	e8 cb fb ff ff       	call   8010a4 <syscall>
  8014d9:	83 c4 18             	add    $0x18,%esp
	return result;
  8014dc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014df:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014e2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014e5:	89 01                	mov    %eax,(%ecx)
  8014e7:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8014ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ed:	c9                   	leave  
  8014ee:	c2 04 00             	ret    $0x4

008014f1 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8014f1:	55                   	push   %ebp
  8014f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	ff 75 10             	pushl  0x10(%ebp)
  8014fb:	ff 75 0c             	pushl  0xc(%ebp)
  8014fe:	ff 75 08             	pushl  0x8(%ebp)
  801501:	6a 13                	push   $0x13
  801503:	e8 9c fb ff ff       	call   8010a4 <syscall>
  801508:	83 c4 18             	add    $0x18,%esp
	return ;
  80150b:	90                   	nop
}
  80150c:	c9                   	leave  
  80150d:	c3                   	ret    

0080150e <sys_rcr2>:
uint32 sys_rcr2()
{
  80150e:	55                   	push   %ebp
  80150f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801511:	6a 00                	push   $0x0
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 25                	push   $0x25
  80151d:	e8 82 fb ff ff       	call   8010a4 <syscall>
  801522:	83 c4 18             	add    $0x18,%esp
}
  801525:	c9                   	leave  
  801526:	c3                   	ret    

00801527 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801527:	55                   	push   %ebp
  801528:	89 e5                	mov    %esp,%ebp
  80152a:	83 ec 04             	sub    $0x4,%esp
  80152d:	8b 45 08             	mov    0x8(%ebp),%eax
  801530:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801533:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801537:	6a 00                	push   $0x0
  801539:	6a 00                	push   $0x0
  80153b:	6a 00                	push   $0x0
  80153d:	6a 00                	push   $0x0
  80153f:	50                   	push   %eax
  801540:	6a 26                	push   $0x26
  801542:	e8 5d fb ff ff       	call   8010a4 <syscall>
  801547:	83 c4 18             	add    $0x18,%esp
	return ;
  80154a:	90                   	nop
}
  80154b:	c9                   	leave  
  80154c:	c3                   	ret    

0080154d <rsttst>:
void rsttst()
{
  80154d:	55                   	push   %ebp
  80154e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	6a 00                	push   $0x0
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 28                	push   $0x28
  80155c:	e8 43 fb ff ff       	call   8010a4 <syscall>
  801561:	83 c4 18             	add    $0x18,%esp
	return ;
  801564:	90                   	nop
}
  801565:	c9                   	leave  
  801566:	c3                   	ret    

00801567 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801567:	55                   	push   %ebp
  801568:	89 e5                	mov    %esp,%ebp
  80156a:	83 ec 04             	sub    $0x4,%esp
  80156d:	8b 45 14             	mov    0x14(%ebp),%eax
  801570:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801573:	8b 55 18             	mov    0x18(%ebp),%edx
  801576:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80157a:	52                   	push   %edx
  80157b:	50                   	push   %eax
  80157c:	ff 75 10             	pushl  0x10(%ebp)
  80157f:	ff 75 0c             	pushl  0xc(%ebp)
  801582:	ff 75 08             	pushl  0x8(%ebp)
  801585:	6a 27                	push   $0x27
  801587:	e8 18 fb ff ff       	call   8010a4 <syscall>
  80158c:	83 c4 18             	add    $0x18,%esp
	return ;
  80158f:	90                   	nop
}
  801590:	c9                   	leave  
  801591:	c3                   	ret    

00801592 <chktst>:
void chktst(uint32 n)
{
  801592:	55                   	push   %ebp
  801593:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801595:	6a 00                	push   $0x0
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	ff 75 08             	pushl  0x8(%ebp)
  8015a0:	6a 29                	push   $0x29
  8015a2:	e8 fd fa ff ff       	call   8010a4 <syscall>
  8015a7:	83 c4 18             	add    $0x18,%esp
	return ;
  8015aa:	90                   	nop
}
  8015ab:	c9                   	leave  
  8015ac:	c3                   	ret    

008015ad <inctst>:

void inctst()
{
  8015ad:	55                   	push   %ebp
  8015ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 2a                	push   $0x2a
  8015bc:	e8 e3 fa ff ff       	call   8010a4 <syscall>
  8015c1:	83 c4 18             	add    $0x18,%esp
	return ;
  8015c4:	90                   	nop
}
  8015c5:	c9                   	leave  
  8015c6:	c3                   	ret    

008015c7 <gettst>:
uint32 gettst()
{
  8015c7:	55                   	push   %ebp
  8015c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 00                	push   $0x0
  8015ce:	6a 00                	push   $0x0
  8015d0:	6a 00                	push   $0x0
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 2b                	push   $0x2b
  8015d6:	e8 c9 fa ff ff       	call   8010a4 <syscall>
  8015db:	83 c4 18             	add    $0x18,%esp
}
  8015de:	c9                   	leave  
  8015df:	c3                   	ret    

008015e0 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8015e0:	55                   	push   %ebp
  8015e1:	89 e5                	mov    %esp,%ebp
  8015e3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015e6:	6a 00                	push   $0x0
  8015e8:	6a 00                	push   $0x0
  8015ea:	6a 00                	push   $0x0
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 2c                	push   $0x2c
  8015f2:	e8 ad fa ff ff       	call   8010a4 <syscall>
  8015f7:	83 c4 18             	add    $0x18,%esp
  8015fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8015fd:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801601:	75 07                	jne    80160a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801603:	b8 01 00 00 00       	mov    $0x1,%eax
  801608:	eb 05                	jmp    80160f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80160a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80160f:	c9                   	leave  
  801610:	c3                   	ret    

00801611 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801611:	55                   	push   %ebp
  801612:	89 e5                	mov    %esp,%ebp
  801614:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	6a 00                	push   $0x0
  80161f:	6a 00                	push   $0x0
  801621:	6a 2c                	push   $0x2c
  801623:	e8 7c fa ff ff       	call   8010a4 <syscall>
  801628:	83 c4 18             	add    $0x18,%esp
  80162b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80162e:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801632:	75 07                	jne    80163b <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801634:	b8 01 00 00 00       	mov    $0x1,%eax
  801639:	eb 05                	jmp    801640 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80163b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801640:	c9                   	leave  
  801641:	c3                   	ret    

00801642 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801642:	55                   	push   %ebp
  801643:	89 e5                	mov    %esp,%ebp
  801645:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	6a 00                	push   $0x0
  80164e:	6a 00                	push   $0x0
  801650:	6a 00                	push   $0x0
  801652:	6a 2c                	push   $0x2c
  801654:	e8 4b fa ff ff       	call   8010a4 <syscall>
  801659:	83 c4 18             	add    $0x18,%esp
  80165c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80165f:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801663:	75 07                	jne    80166c <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801665:	b8 01 00 00 00       	mov    $0x1,%eax
  80166a:	eb 05                	jmp    801671 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80166c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801671:	c9                   	leave  
  801672:	c3                   	ret    

00801673 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801673:	55                   	push   %ebp
  801674:	89 e5                	mov    %esp,%ebp
  801676:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801679:	6a 00                	push   $0x0
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	6a 00                	push   $0x0
  801683:	6a 2c                	push   $0x2c
  801685:	e8 1a fa ff ff       	call   8010a4 <syscall>
  80168a:	83 c4 18             	add    $0x18,%esp
  80168d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801690:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801694:	75 07                	jne    80169d <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801696:	b8 01 00 00 00       	mov    $0x1,%eax
  80169b:	eb 05                	jmp    8016a2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80169d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016a2:	c9                   	leave  
  8016a3:	c3                   	ret    

008016a4 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8016a4:	55                   	push   %ebp
  8016a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	ff 75 08             	pushl  0x8(%ebp)
  8016b2:	6a 2d                	push   $0x2d
  8016b4:	e8 eb f9 ff ff       	call   8010a4 <syscall>
  8016b9:	83 c4 18             	add    $0x18,%esp
	return ;
  8016bc:	90                   	nop
}
  8016bd:	c9                   	leave  
  8016be:	c3                   	ret    

008016bf <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8016bf:	55                   	push   %ebp
  8016c0:	89 e5                	mov    %esp,%ebp
  8016c2:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8016c3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016c6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cf:	6a 00                	push   $0x0
  8016d1:	53                   	push   %ebx
  8016d2:	51                   	push   %ecx
  8016d3:	52                   	push   %edx
  8016d4:	50                   	push   %eax
  8016d5:	6a 2e                	push   $0x2e
  8016d7:	e8 c8 f9 ff ff       	call   8010a4 <syscall>
  8016dc:	83 c4 18             	add    $0x18,%esp
}
  8016df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8016e2:	c9                   	leave  
  8016e3:	c3                   	ret    

008016e4 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8016e4:	55                   	push   %ebp
  8016e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8016e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	52                   	push   %edx
  8016f4:	50                   	push   %eax
  8016f5:	6a 2f                	push   $0x2f
  8016f7:	e8 a8 f9 ff ff       	call   8010a4 <syscall>
  8016fc:	83 c4 18             	add    $0x18,%esp
}
  8016ff:	c9                   	leave  
  801700:	c3                   	ret    
  801701:	66 90                	xchg   %ax,%ax
  801703:	90                   	nop

00801704 <__udivdi3>:
  801704:	55                   	push   %ebp
  801705:	57                   	push   %edi
  801706:	56                   	push   %esi
  801707:	53                   	push   %ebx
  801708:	83 ec 1c             	sub    $0x1c,%esp
  80170b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80170f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801713:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801717:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80171b:	89 ca                	mov    %ecx,%edx
  80171d:	89 f8                	mov    %edi,%eax
  80171f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801723:	85 f6                	test   %esi,%esi
  801725:	75 2d                	jne    801754 <__udivdi3+0x50>
  801727:	39 cf                	cmp    %ecx,%edi
  801729:	77 65                	ja     801790 <__udivdi3+0x8c>
  80172b:	89 fd                	mov    %edi,%ebp
  80172d:	85 ff                	test   %edi,%edi
  80172f:	75 0b                	jne    80173c <__udivdi3+0x38>
  801731:	b8 01 00 00 00       	mov    $0x1,%eax
  801736:	31 d2                	xor    %edx,%edx
  801738:	f7 f7                	div    %edi
  80173a:	89 c5                	mov    %eax,%ebp
  80173c:	31 d2                	xor    %edx,%edx
  80173e:	89 c8                	mov    %ecx,%eax
  801740:	f7 f5                	div    %ebp
  801742:	89 c1                	mov    %eax,%ecx
  801744:	89 d8                	mov    %ebx,%eax
  801746:	f7 f5                	div    %ebp
  801748:	89 cf                	mov    %ecx,%edi
  80174a:	89 fa                	mov    %edi,%edx
  80174c:	83 c4 1c             	add    $0x1c,%esp
  80174f:	5b                   	pop    %ebx
  801750:	5e                   	pop    %esi
  801751:	5f                   	pop    %edi
  801752:	5d                   	pop    %ebp
  801753:	c3                   	ret    
  801754:	39 ce                	cmp    %ecx,%esi
  801756:	77 28                	ja     801780 <__udivdi3+0x7c>
  801758:	0f bd fe             	bsr    %esi,%edi
  80175b:	83 f7 1f             	xor    $0x1f,%edi
  80175e:	75 40                	jne    8017a0 <__udivdi3+0x9c>
  801760:	39 ce                	cmp    %ecx,%esi
  801762:	72 0a                	jb     80176e <__udivdi3+0x6a>
  801764:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801768:	0f 87 9e 00 00 00    	ja     80180c <__udivdi3+0x108>
  80176e:	b8 01 00 00 00       	mov    $0x1,%eax
  801773:	89 fa                	mov    %edi,%edx
  801775:	83 c4 1c             	add    $0x1c,%esp
  801778:	5b                   	pop    %ebx
  801779:	5e                   	pop    %esi
  80177a:	5f                   	pop    %edi
  80177b:	5d                   	pop    %ebp
  80177c:	c3                   	ret    
  80177d:	8d 76 00             	lea    0x0(%esi),%esi
  801780:	31 ff                	xor    %edi,%edi
  801782:	31 c0                	xor    %eax,%eax
  801784:	89 fa                	mov    %edi,%edx
  801786:	83 c4 1c             	add    $0x1c,%esp
  801789:	5b                   	pop    %ebx
  80178a:	5e                   	pop    %esi
  80178b:	5f                   	pop    %edi
  80178c:	5d                   	pop    %ebp
  80178d:	c3                   	ret    
  80178e:	66 90                	xchg   %ax,%ax
  801790:	89 d8                	mov    %ebx,%eax
  801792:	f7 f7                	div    %edi
  801794:	31 ff                	xor    %edi,%edi
  801796:	89 fa                	mov    %edi,%edx
  801798:	83 c4 1c             	add    $0x1c,%esp
  80179b:	5b                   	pop    %ebx
  80179c:	5e                   	pop    %esi
  80179d:	5f                   	pop    %edi
  80179e:	5d                   	pop    %ebp
  80179f:	c3                   	ret    
  8017a0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8017a5:	89 eb                	mov    %ebp,%ebx
  8017a7:	29 fb                	sub    %edi,%ebx
  8017a9:	89 f9                	mov    %edi,%ecx
  8017ab:	d3 e6                	shl    %cl,%esi
  8017ad:	89 c5                	mov    %eax,%ebp
  8017af:	88 d9                	mov    %bl,%cl
  8017b1:	d3 ed                	shr    %cl,%ebp
  8017b3:	89 e9                	mov    %ebp,%ecx
  8017b5:	09 f1                	or     %esi,%ecx
  8017b7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8017bb:	89 f9                	mov    %edi,%ecx
  8017bd:	d3 e0                	shl    %cl,%eax
  8017bf:	89 c5                	mov    %eax,%ebp
  8017c1:	89 d6                	mov    %edx,%esi
  8017c3:	88 d9                	mov    %bl,%cl
  8017c5:	d3 ee                	shr    %cl,%esi
  8017c7:	89 f9                	mov    %edi,%ecx
  8017c9:	d3 e2                	shl    %cl,%edx
  8017cb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017cf:	88 d9                	mov    %bl,%cl
  8017d1:	d3 e8                	shr    %cl,%eax
  8017d3:	09 c2                	or     %eax,%edx
  8017d5:	89 d0                	mov    %edx,%eax
  8017d7:	89 f2                	mov    %esi,%edx
  8017d9:	f7 74 24 0c          	divl   0xc(%esp)
  8017dd:	89 d6                	mov    %edx,%esi
  8017df:	89 c3                	mov    %eax,%ebx
  8017e1:	f7 e5                	mul    %ebp
  8017e3:	39 d6                	cmp    %edx,%esi
  8017e5:	72 19                	jb     801800 <__udivdi3+0xfc>
  8017e7:	74 0b                	je     8017f4 <__udivdi3+0xf0>
  8017e9:	89 d8                	mov    %ebx,%eax
  8017eb:	31 ff                	xor    %edi,%edi
  8017ed:	e9 58 ff ff ff       	jmp    80174a <__udivdi3+0x46>
  8017f2:	66 90                	xchg   %ax,%ax
  8017f4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8017f8:	89 f9                	mov    %edi,%ecx
  8017fa:	d3 e2                	shl    %cl,%edx
  8017fc:	39 c2                	cmp    %eax,%edx
  8017fe:	73 e9                	jae    8017e9 <__udivdi3+0xe5>
  801800:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801803:	31 ff                	xor    %edi,%edi
  801805:	e9 40 ff ff ff       	jmp    80174a <__udivdi3+0x46>
  80180a:	66 90                	xchg   %ax,%ax
  80180c:	31 c0                	xor    %eax,%eax
  80180e:	e9 37 ff ff ff       	jmp    80174a <__udivdi3+0x46>
  801813:	90                   	nop

00801814 <__umoddi3>:
  801814:	55                   	push   %ebp
  801815:	57                   	push   %edi
  801816:	56                   	push   %esi
  801817:	53                   	push   %ebx
  801818:	83 ec 1c             	sub    $0x1c,%esp
  80181b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80181f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801823:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801827:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80182b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80182f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801833:	89 f3                	mov    %esi,%ebx
  801835:	89 fa                	mov    %edi,%edx
  801837:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80183b:	89 34 24             	mov    %esi,(%esp)
  80183e:	85 c0                	test   %eax,%eax
  801840:	75 1a                	jne    80185c <__umoddi3+0x48>
  801842:	39 f7                	cmp    %esi,%edi
  801844:	0f 86 a2 00 00 00    	jbe    8018ec <__umoddi3+0xd8>
  80184a:	89 c8                	mov    %ecx,%eax
  80184c:	89 f2                	mov    %esi,%edx
  80184e:	f7 f7                	div    %edi
  801850:	89 d0                	mov    %edx,%eax
  801852:	31 d2                	xor    %edx,%edx
  801854:	83 c4 1c             	add    $0x1c,%esp
  801857:	5b                   	pop    %ebx
  801858:	5e                   	pop    %esi
  801859:	5f                   	pop    %edi
  80185a:	5d                   	pop    %ebp
  80185b:	c3                   	ret    
  80185c:	39 f0                	cmp    %esi,%eax
  80185e:	0f 87 ac 00 00 00    	ja     801910 <__umoddi3+0xfc>
  801864:	0f bd e8             	bsr    %eax,%ebp
  801867:	83 f5 1f             	xor    $0x1f,%ebp
  80186a:	0f 84 ac 00 00 00    	je     80191c <__umoddi3+0x108>
  801870:	bf 20 00 00 00       	mov    $0x20,%edi
  801875:	29 ef                	sub    %ebp,%edi
  801877:	89 fe                	mov    %edi,%esi
  801879:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80187d:	89 e9                	mov    %ebp,%ecx
  80187f:	d3 e0                	shl    %cl,%eax
  801881:	89 d7                	mov    %edx,%edi
  801883:	89 f1                	mov    %esi,%ecx
  801885:	d3 ef                	shr    %cl,%edi
  801887:	09 c7                	or     %eax,%edi
  801889:	89 e9                	mov    %ebp,%ecx
  80188b:	d3 e2                	shl    %cl,%edx
  80188d:	89 14 24             	mov    %edx,(%esp)
  801890:	89 d8                	mov    %ebx,%eax
  801892:	d3 e0                	shl    %cl,%eax
  801894:	89 c2                	mov    %eax,%edx
  801896:	8b 44 24 08          	mov    0x8(%esp),%eax
  80189a:	d3 e0                	shl    %cl,%eax
  80189c:	89 44 24 04          	mov    %eax,0x4(%esp)
  8018a0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8018a4:	89 f1                	mov    %esi,%ecx
  8018a6:	d3 e8                	shr    %cl,%eax
  8018a8:	09 d0                	or     %edx,%eax
  8018aa:	d3 eb                	shr    %cl,%ebx
  8018ac:	89 da                	mov    %ebx,%edx
  8018ae:	f7 f7                	div    %edi
  8018b0:	89 d3                	mov    %edx,%ebx
  8018b2:	f7 24 24             	mull   (%esp)
  8018b5:	89 c6                	mov    %eax,%esi
  8018b7:	89 d1                	mov    %edx,%ecx
  8018b9:	39 d3                	cmp    %edx,%ebx
  8018bb:	0f 82 87 00 00 00    	jb     801948 <__umoddi3+0x134>
  8018c1:	0f 84 91 00 00 00    	je     801958 <__umoddi3+0x144>
  8018c7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8018cb:	29 f2                	sub    %esi,%edx
  8018cd:	19 cb                	sbb    %ecx,%ebx
  8018cf:	89 d8                	mov    %ebx,%eax
  8018d1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8018d5:	d3 e0                	shl    %cl,%eax
  8018d7:	89 e9                	mov    %ebp,%ecx
  8018d9:	d3 ea                	shr    %cl,%edx
  8018db:	09 d0                	or     %edx,%eax
  8018dd:	89 e9                	mov    %ebp,%ecx
  8018df:	d3 eb                	shr    %cl,%ebx
  8018e1:	89 da                	mov    %ebx,%edx
  8018e3:	83 c4 1c             	add    $0x1c,%esp
  8018e6:	5b                   	pop    %ebx
  8018e7:	5e                   	pop    %esi
  8018e8:	5f                   	pop    %edi
  8018e9:	5d                   	pop    %ebp
  8018ea:	c3                   	ret    
  8018eb:	90                   	nop
  8018ec:	89 fd                	mov    %edi,%ebp
  8018ee:	85 ff                	test   %edi,%edi
  8018f0:	75 0b                	jne    8018fd <__umoddi3+0xe9>
  8018f2:	b8 01 00 00 00       	mov    $0x1,%eax
  8018f7:	31 d2                	xor    %edx,%edx
  8018f9:	f7 f7                	div    %edi
  8018fb:	89 c5                	mov    %eax,%ebp
  8018fd:	89 f0                	mov    %esi,%eax
  8018ff:	31 d2                	xor    %edx,%edx
  801901:	f7 f5                	div    %ebp
  801903:	89 c8                	mov    %ecx,%eax
  801905:	f7 f5                	div    %ebp
  801907:	89 d0                	mov    %edx,%eax
  801909:	e9 44 ff ff ff       	jmp    801852 <__umoddi3+0x3e>
  80190e:	66 90                	xchg   %ax,%ax
  801910:	89 c8                	mov    %ecx,%eax
  801912:	89 f2                	mov    %esi,%edx
  801914:	83 c4 1c             	add    $0x1c,%esp
  801917:	5b                   	pop    %ebx
  801918:	5e                   	pop    %esi
  801919:	5f                   	pop    %edi
  80191a:	5d                   	pop    %ebp
  80191b:	c3                   	ret    
  80191c:	3b 04 24             	cmp    (%esp),%eax
  80191f:	72 06                	jb     801927 <__umoddi3+0x113>
  801921:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801925:	77 0f                	ja     801936 <__umoddi3+0x122>
  801927:	89 f2                	mov    %esi,%edx
  801929:	29 f9                	sub    %edi,%ecx
  80192b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80192f:	89 14 24             	mov    %edx,(%esp)
  801932:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801936:	8b 44 24 04          	mov    0x4(%esp),%eax
  80193a:	8b 14 24             	mov    (%esp),%edx
  80193d:	83 c4 1c             	add    $0x1c,%esp
  801940:	5b                   	pop    %ebx
  801941:	5e                   	pop    %esi
  801942:	5f                   	pop    %edi
  801943:	5d                   	pop    %ebp
  801944:	c3                   	ret    
  801945:	8d 76 00             	lea    0x0(%esi),%esi
  801948:	2b 04 24             	sub    (%esp),%eax
  80194b:	19 fa                	sbb    %edi,%edx
  80194d:	89 d1                	mov    %edx,%ecx
  80194f:	89 c6                	mov    %eax,%esi
  801951:	e9 71 ff ff ff       	jmp    8018c7 <__umoddi3+0xb3>
  801956:	66 90                	xchg   %ax,%ax
  801958:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80195c:	72 ea                	jb     801948 <__umoddi3+0x134>
  80195e:	89 d9                	mov    %ebx,%ecx
  801960:	e9 62 ff ff ff       	jmp    8018c7 <__umoddi3+0xb3>
