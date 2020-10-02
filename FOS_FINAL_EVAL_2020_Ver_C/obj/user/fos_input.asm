
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
  80005e:	e8 f4 09 00 00       	call   800a57 <atomic_readline>
  800063:	83 c4 10             	add    $0x10,%esp
	i1 = strtol(buff1, NULL, 10);
  800066:	83 ec 04             	sub    $0x4,%esp
  800069:	6a 0a                	push   $0xa
  80006b:	6a 00                	push   $0x0
  80006d:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  800073:	50                   	push   %eax
  800074:	e8 46 0e 00 00       	call   800ebf <strtol>
  800079:	83 c4 10             	add    $0x10,%esp
  80007c:	89 45 f4             	mov    %eax,-0xc(%ebp)

	//sleep
	env_sleep(2800);
  80007f:	83 ec 0c             	sub    $0xc,%esp
  800082:	68 f0 0a 00 00       	push   $0xaf0
  800087:	e8 54 18 00 00       	call   8018e0 <env_sleep>
  80008c:	83 c4 10             	add    $0x10,%esp

	atomic_readline("Please enter second number :", buff2);
  80008f:	83 ec 08             	sub    $0x8,%esp
  800092:	8d 85 f0 fb ff ff    	lea    -0x410(%ebp),%eax
  800098:	50                   	push   %eax
  800099:	68 bc 1c 80 00       	push   $0x801cbc
  80009e:	e8 b4 09 00 00       	call   800a57 <atomic_readline>
  8000a3:	83 c4 10             	add    $0x10,%esp
	
	i2 = strtol(buff2, NULL, 10);
  8000a6:	83 ec 04             	sub    $0x4,%esp
  8000a9:	6a 0a                	push   $0xa
  8000ab:	6a 00                	push   $0x0
  8000ad:	8d 85 f0 fb ff ff    	lea    -0x410(%ebp),%eax
  8000b3:	50                   	push   %eax
  8000b4:	e8 06 0e 00 00       	call   800ebf <strtol>
  8000b9:	83 c4 10             	add    $0x10,%esp
  8000bc:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("number 1 + number 2 = %d\n",i1+i2);
  8000bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c5:	01 d0                	add    %edx,%eax
  8000c7:	83 ec 08             	sub    $0x8,%esp
  8000ca:	50                   	push   %eax
  8000cb:	68 d9 1c 80 00       	push   $0x801cd9
  8000d0:	e8 2f 02 00 00       	call   800304 <atomic_cprintf>
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
  8000e1:	e8 22 12 00 00       	call   801308 <sys_getenvindex>
  8000e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000ec:	89 d0                	mov    %edx,%eax
  8000ee:	01 c0                	add    %eax,%eax
  8000f0:	01 d0                	add    %edx,%eax
  8000f2:	c1 e0 07             	shl    $0x7,%eax
  8000f5:	29 d0                	sub    %edx,%eax
  8000f7:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8000fe:	01 c8                	add    %ecx,%eax
  800100:	01 c0                	add    %eax,%eax
  800102:	01 d0                	add    %edx,%eax
  800104:	01 c0                	add    %eax,%eax
  800106:	01 d0                	add    %edx,%eax
  800108:	c1 e0 03             	shl    $0x3,%eax
  80010b:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800110:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800115:	a1 20 30 80 00       	mov    0x803020,%eax
  80011a:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  800120:	84 c0                	test   %al,%al
  800122:	74 0f                	je     800133 <libmain+0x58>
		binaryname = myEnv->prog_name;
  800124:	a1 20 30 80 00       	mov    0x803020,%eax
  800129:	05 f0 ee 00 00       	add    $0xeef0,%eax
  80012e:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800133:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800137:	7e 0a                	jle    800143 <libmain+0x68>
		binaryname = argv[0];
  800139:	8b 45 0c             	mov    0xc(%ebp),%eax
  80013c:	8b 00                	mov    (%eax),%eax
  80013e:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800143:	83 ec 08             	sub    $0x8,%esp
  800146:	ff 75 0c             	pushl  0xc(%ebp)
  800149:	ff 75 08             	pushl  0x8(%ebp)
  80014c:	e8 e7 fe ff ff       	call   800038 <_main>
  800151:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800154:	e8 4a 13 00 00       	call   8014a3 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800159:	83 ec 0c             	sub    $0xc,%esp
  80015c:	68 0c 1d 80 00       	push   $0x801d0c
  800161:	e8 71 01 00 00       	call   8002d7 <cprintf>
  800166:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800169:	a1 20 30 80 00       	mov    0x803020,%eax
  80016e:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  800174:	a1 20 30 80 00       	mov    0x803020,%eax
  800179:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  80017f:	83 ec 04             	sub    $0x4,%esp
  800182:	52                   	push   %edx
  800183:	50                   	push   %eax
  800184:	68 34 1d 80 00       	push   $0x801d34
  800189:	e8 49 01 00 00       	call   8002d7 <cprintf>
  80018e:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800191:	a1 20 30 80 00       	mov    0x803020,%eax
  800196:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  80019c:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a1:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  8001a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ac:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  8001b2:	51                   	push   %ecx
  8001b3:	52                   	push   %edx
  8001b4:	50                   	push   %eax
  8001b5:	68 5c 1d 80 00       	push   $0x801d5c
  8001ba:	e8 18 01 00 00       	call   8002d7 <cprintf>
  8001bf:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8001c2:	83 ec 0c             	sub    $0xc,%esp
  8001c5:	68 0c 1d 80 00       	push   $0x801d0c
  8001ca:	e8 08 01 00 00       	call   8002d7 <cprintf>
  8001cf:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001d2:	e8 e6 12 00 00       	call   8014bd <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001d7:	e8 19 00 00 00       	call   8001f5 <exit>
}
  8001dc:	90                   	nop
  8001dd:	c9                   	leave  
  8001de:	c3                   	ret    

008001df <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001df:	55                   	push   %ebp
  8001e0:	89 e5                	mov    %esp,%ebp
  8001e2:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001e5:	83 ec 0c             	sub    $0xc,%esp
  8001e8:	6a 00                	push   $0x0
  8001ea:	e8 e5 10 00 00       	call   8012d4 <sys_env_destroy>
  8001ef:	83 c4 10             	add    $0x10,%esp
}
  8001f2:	90                   	nop
  8001f3:	c9                   	leave  
  8001f4:	c3                   	ret    

008001f5 <exit>:

void
exit(void)
{
  8001f5:	55                   	push   %ebp
  8001f6:	89 e5                	mov    %esp,%ebp
  8001f8:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001fb:	e8 3a 11 00 00       	call   80133a <sys_env_exit>
}
  800200:	90                   	nop
  800201:	c9                   	leave  
  800202:	c3                   	ret    

00800203 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800203:	55                   	push   %ebp
  800204:	89 e5                	mov    %esp,%ebp
  800206:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800209:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020c:	8b 00                	mov    (%eax),%eax
  80020e:	8d 48 01             	lea    0x1(%eax),%ecx
  800211:	8b 55 0c             	mov    0xc(%ebp),%edx
  800214:	89 0a                	mov    %ecx,(%edx)
  800216:	8b 55 08             	mov    0x8(%ebp),%edx
  800219:	88 d1                	mov    %dl,%cl
  80021b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80021e:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800222:	8b 45 0c             	mov    0xc(%ebp),%eax
  800225:	8b 00                	mov    (%eax),%eax
  800227:	3d ff 00 00 00       	cmp    $0xff,%eax
  80022c:	75 2c                	jne    80025a <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80022e:	a0 24 30 80 00       	mov    0x803024,%al
  800233:	0f b6 c0             	movzbl %al,%eax
  800236:	8b 55 0c             	mov    0xc(%ebp),%edx
  800239:	8b 12                	mov    (%edx),%edx
  80023b:	89 d1                	mov    %edx,%ecx
  80023d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800240:	83 c2 08             	add    $0x8,%edx
  800243:	83 ec 04             	sub    $0x4,%esp
  800246:	50                   	push   %eax
  800247:	51                   	push   %ecx
  800248:	52                   	push   %edx
  800249:	e8 44 10 00 00       	call   801292 <sys_cputs>
  80024e:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800251:	8b 45 0c             	mov    0xc(%ebp),%eax
  800254:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80025a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80025d:	8b 40 04             	mov    0x4(%eax),%eax
  800260:	8d 50 01             	lea    0x1(%eax),%edx
  800263:	8b 45 0c             	mov    0xc(%ebp),%eax
  800266:	89 50 04             	mov    %edx,0x4(%eax)
}
  800269:	90                   	nop
  80026a:	c9                   	leave  
  80026b:	c3                   	ret    

0080026c <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80026c:	55                   	push   %ebp
  80026d:	89 e5                	mov    %esp,%ebp
  80026f:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800275:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80027c:	00 00 00 
	b.cnt = 0;
  80027f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800286:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800289:	ff 75 0c             	pushl  0xc(%ebp)
  80028c:	ff 75 08             	pushl  0x8(%ebp)
  80028f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800295:	50                   	push   %eax
  800296:	68 03 02 80 00       	push   $0x800203
  80029b:	e8 11 02 00 00       	call   8004b1 <vprintfmt>
  8002a0:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002a3:	a0 24 30 80 00       	mov    0x803024,%al
  8002a8:	0f b6 c0             	movzbl %al,%eax
  8002ab:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002b1:	83 ec 04             	sub    $0x4,%esp
  8002b4:	50                   	push   %eax
  8002b5:	52                   	push   %edx
  8002b6:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002bc:	83 c0 08             	add    $0x8,%eax
  8002bf:	50                   	push   %eax
  8002c0:	e8 cd 0f 00 00       	call   801292 <sys_cputs>
  8002c5:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002c8:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8002cf:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002d5:	c9                   	leave  
  8002d6:	c3                   	ret    

008002d7 <cprintf>:

int cprintf(const char *fmt, ...) {
  8002d7:	55                   	push   %ebp
  8002d8:	89 e5                	mov    %esp,%ebp
  8002da:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002dd:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8002e4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ed:	83 ec 08             	sub    $0x8,%esp
  8002f0:	ff 75 f4             	pushl  -0xc(%ebp)
  8002f3:	50                   	push   %eax
  8002f4:	e8 73 ff ff ff       	call   80026c <vcprintf>
  8002f9:	83 c4 10             	add    $0x10,%esp
  8002fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800302:	c9                   	leave  
  800303:	c3                   	ret    

00800304 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800304:	55                   	push   %ebp
  800305:	89 e5                	mov    %esp,%ebp
  800307:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80030a:	e8 94 11 00 00       	call   8014a3 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80030f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800312:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800315:	8b 45 08             	mov    0x8(%ebp),%eax
  800318:	83 ec 08             	sub    $0x8,%esp
  80031b:	ff 75 f4             	pushl  -0xc(%ebp)
  80031e:	50                   	push   %eax
  80031f:	e8 48 ff ff ff       	call   80026c <vcprintf>
  800324:	83 c4 10             	add    $0x10,%esp
  800327:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80032a:	e8 8e 11 00 00       	call   8014bd <sys_enable_interrupt>
	return cnt;
  80032f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800332:	c9                   	leave  
  800333:	c3                   	ret    

00800334 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800334:	55                   	push   %ebp
  800335:	89 e5                	mov    %esp,%ebp
  800337:	53                   	push   %ebx
  800338:	83 ec 14             	sub    $0x14,%esp
  80033b:	8b 45 10             	mov    0x10(%ebp),%eax
  80033e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800341:	8b 45 14             	mov    0x14(%ebp),%eax
  800344:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800347:	8b 45 18             	mov    0x18(%ebp),%eax
  80034a:	ba 00 00 00 00       	mov    $0x0,%edx
  80034f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800352:	77 55                	ja     8003a9 <printnum+0x75>
  800354:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800357:	72 05                	jb     80035e <printnum+0x2a>
  800359:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80035c:	77 4b                	ja     8003a9 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80035e:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800361:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800364:	8b 45 18             	mov    0x18(%ebp),%eax
  800367:	ba 00 00 00 00       	mov    $0x0,%edx
  80036c:	52                   	push   %edx
  80036d:	50                   	push   %eax
  80036e:	ff 75 f4             	pushl  -0xc(%ebp)
  800371:	ff 75 f0             	pushl  -0x10(%ebp)
  800374:	e8 bb 16 00 00       	call   801a34 <__udivdi3>
  800379:	83 c4 10             	add    $0x10,%esp
  80037c:	83 ec 04             	sub    $0x4,%esp
  80037f:	ff 75 20             	pushl  0x20(%ebp)
  800382:	53                   	push   %ebx
  800383:	ff 75 18             	pushl  0x18(%ebp)
  800386:	52                   	push   %edx
  800387:	50                   	push   %eax
  800388:	ff 75 0c             	pushl  0xc(%ebp)
  80038b:	ff 75 08             	pushl  0x8(%ebp)
  80038e:	e8 a1 ff ff ff       	call   800334 <printnum>
  800393:	83 c4 20             	add    $0x20,%esp
  800396:	eb 1a                	jmp    8003b2 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800398:	83 ec 08             	sub    $0x8,%esp
  80039b:	ff 75 0c             	pushl  0xc(%ebp)
  80039e:	ff 75 20             	pushl  0x20(%ebp)
  8003a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a4:	ff d0                	call   *%eax
  8003a6:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003a9:	ff 4d 1c             	decl   0x1c(%ebp)
  8003ac:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003b0:	7f e6                	jg     800398 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003b2:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003b5:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003bd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003c0:	53                   	push   %ebx
  8003c1:	51                   	push   %ecx
  8003c2:	52                   	push   %edx
  8003c3:	50                   	push   %eax
  8003c4:	e8 7b 17 00 00       	call   801b44 <__umoddi3>
  8003c9:	83 c4 10             	add    $0x10,%esp
  8003cc:	05 d4 1f 80 00       	add    $0x801fd4,%eax
  8003d1:	8a 00                	mov    (%eax),%al
  8003d3:	0f be c0             	movsbl %al,%eax
  8003d6:	83 ec 08             	sub    $0x8,%esp
  8003d9:	ff 75 0c             	pushl  0xc(%ebp)
  8003dc:	50                   	push   %eax
  8003dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e0:	ff d0                	call   *%eax
  8003e2:	83 c4 10             	add    $0x10,%esp
}
  8003e5:	90                   	nop
  8003e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003e9:	c9                   	leave  
  8003ea:	c3                   	ret    

008003eb <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003eb:	55                   	push   %ebp
  8003ec:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003ee:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003f2:	7e 1c                	jle    800410 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f7:	8b 00                	mov    (%eax),%eax
  8003f9:	8d 50 08             	lea    0x8(%eax),%edx
  8003fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ff:	89 10                	mov    %edx,(%eax)
  800401:	8b 45 08             	mov    0x8(%ebp),%eax
  800404:	8b 00                	mov    (%eax),%eax
  800406:	83 e8 08             	sub    $0x8,%eax
  800409:	8b 50 04             	mov    0x4(%eax),%edx
  80040c:	8b 00                	mov    (%eax),%eax
  80040e:	eb 40                	jmp    800450 <getuint+0x65>
	else if (lflag)
  800410:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800414:	74 1e                	je     800434 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800416:	8b 45 08             	mov    0x8(%ebp),%eax
  800419:	8b 00                	mov    (%eax),%eax
  80041b:	8d 50 04             	lea    0x4(%eax),%edx
  80041e:	8b 45 08             	mov    0x8(%ebp),%eax
  800421:	89 10                	mov    %edx,(%eax)
  800423:	8b 45 08             	mov    0x8(%ebp),%eax
  800426:	8b 00                	mov    (%eax),%eax
  800428:	83 e8 04             	sub    $0x4,%eax
  80042b:	8b 00                	mov    (%eax),%eax
  80042d:	ba 00 00 00 00       	mov    $0x0,%edx
  800432:	eb 1c                	jmp    800450 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800434:	8b 45 08             	mov    0x8(%ebp),%eax
  800437:	8b 00                	mov    (%eax),%eax
  800439:	8d 50 04             	lea    0x4(%eax),%edx
  80043c:	8b 45 08             	mov    0x8(%ebp),%eax
  80043f:	89 10                	mov    %edx,(%eax)
  800441:	8b 45 08             	mov    0x8(%ebp),%eax
  800444:	8b 00                	mov    (%eax),%eax
  800446:	83 e8 04             	sub    $0x4,%eax
  800449:	8b 00                	mov    (%eax),%eax
  80044b:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800450:	5d                   	pop    %ebp
  800451:	c3                   	ret    

00800452 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800452:	55                   	push   %ebp
  800453:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800455:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800459:	7e 1c                	jle    800477 <getint+0x25>
		return va_arg(*ap, long long);
  80045b:	8b 45 08             	mov    0x8(%ebp),%eax
  80045e:	8b 00                	mov    (%eax),%eax
  800460:	8d 50 08             	lea    0x8(%eax),%edx
  800463:	8b 45 08             	mov    0x8(%ebp),%eax
  800466:	89 10                	mov    %edx,(%eax)
  800468:	8b 45 08             	mov    0x8(%ebp),%eax
  80046b:	8b 00                	mov    (%eax),%eax
  80046d:	83 e8 08             	sub    $0x8,%eax
  800470:	8b 50 04             	mov    0x4(%eax),%edx
  800473:	8b 00                	mov    (%eax),%eax
  800475:	eb 38                	jmp    8004af <getint+0x5d>
	else if (lflag)
  800477:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80047b:	74 1a                	je     800497 <getint+0x45>
		return va_arg(*ap, long);
  80047d:	8b 45 08             	mov    0x8(%ebp),%eax
  800480:	8b 00                	mov    (%eax),%eax
  800482:	8d 50 04             	lea    0x4(%eax),%edx
  800485:	8b 45 08             	mov    0x8(%ebp),%eax
  800488:	89 10                	mov    %edx,(%eax)
  80048a:	8b 45 08             	mov    0x8(%ebp),%eax
  80048d:	8b 00                	mov    (%eax),%eax
  80048f:	83 e8 04             	sub    $0x4,%eax
  800492:	8b 00                	mov    (%eax),%eax
  800494:	99                   	cltd   
  800495:	eb 18                	jmp    8004af <getint+0x5d>
	else
		return va_arg(*ap, int);
  800497:	8b 45 08             	mov    0x8(%ebp),%eax
  80049a:	8b 00                	mov    (%eax),%eax
  80049c:	8d 50 04             	lea    0x4(%eax),%edx
  80049f:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a2:	89 10                	mov    %edx,(%eax)
  8004a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a7:	8b 00                	mov    (%eax),%eax
  8004a9:	83 e8 04             	sub    $0x4,%eax
  8004ac:	8b 00                	mov    (%eax),%eax
  8004ae:	99                   	cltd   
}
  8004af:	5d                   	pop    %ebp
  8004b0:	c3                   	ret    

008004b1 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004b1:	55                   	push   %ebp
  8004b2:	89 e5                	mov    %esp,%ebp
  8004b4:	56                   	push   %esi
  8004b5:	53                   	push   %ebx
  8004b6:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004b9:	eb 17                	jmp    8004d2 <vprintfmt+0x21>
			if (ch == '\0')
  8004bb:	85 db                	test   %ebx,%ebx
  8004bd:	0f 84 af 03 00 00    	je     800872 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004c3:	83 ec 08             	sub    $0x8,%esp
  8004c6:	ff 75 0c             	pushl  0xc(%ebp)
  8004c9:	53                   	push   %ebx
  8004ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8004cd:	ff d0                	call   *%eax
  8004cf:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8004d5:	8d 50 01             	lea    0x1(%eax),%edx
  8004d8:	89 55 10             	mov    %edx,0x10(%ebp)
  8004db:	8a 00                	mov    (%eax),%al
  8004dd:	0f b6 d8             	movzbl %al,%ebx
  8004e0:	83 fb 25             	cmp    $0x25,%ebx
  8004e3:	75 d6                	jne    8004bb <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004e5:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004e9:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004f0:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004f7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004fe:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800505:	8b 45 10             	mov    0x10(%ebp),%eax
  800508:	8d 50 01             	lea    0x1(%eax),%edx
  80050b:	89 55 10             	mov    %edx,0x10(%ebp)
  80050e:	8a 00                	mov    (%eax),%al
  800510:	0f b6 d8             	movzbl %al,%ebx
  800513:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800516:	83 f8 55             	cmp    $0x55,%eax
  800519:	0f 87 2b 03 00 00    	ja     80084a <vprintfmt+0x399>
  80051f:	8b 04 85 f8 1f 80 00 	mov    0x801ff8(,%eax,4),%eax
  800526:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800528:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80052c:	eb d7                	jmp    800505 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80052e:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800532:	eb d1                	jmp    800505 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800534:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80053b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80053e:	89 d0                	mov    %edx,%eax
  800540:	c1 e0 02             	shl    $0x2,%eax
  800543:	01 d0                	add    %edx,%eax
  800545:	01 c0                	add    %eax,%eax
  800547:	01 d8                	add    %ebx,%eax
  800549:	83 e8 30             	sub    $0x30,%eax
  80054c:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80054f:	8b 45 10             	mov    0x10(%ebp),%eax
  800552:	8a 00                	mov    (%eax),%al
  800554:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800557:	83 fb 2f             	cmp    $0x2f,%ebx
  80055a:	7e 3e                	jle    80059a <vprintfmt+0xe9>
  80055c:	83 fb 39             	cmp    $0x39,%ebx
  80055f:	7f 39                	jg     80059a <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800561:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800564:	eb d5                	jmp    80053b <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800566:	8b 45 14             	mov    0x14(%ebp),%eax
  800569:	83 c0 04             	add    $0x4,%eax
  80056c:	89 45 14             	mov    %eax,0x14(%ebp)
  80056f:	8b 45 14             	mov    0x14(%ebp),%eax
  800572:	83 e8 04             	sub    $0x4,%eax
  800575:	8b 00                	mov    (%eax),%eax
  800577:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80057a:	eb 1f                	jmp    80059b <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80057c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800580:	79 83                	jns    800505 <vprintfmt+0x54>
				width = 0;
  800582:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800589:	e9 77 ff ff ff       	jmp    800505 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80058e:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800595:	e9 6b ff ff ff       	jmp    800505 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80059a:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80059b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80059f:	0f 89 60 ff ff ff    	jns    800505 <vprintfmt+0x54>
				width = precision, precision = -1;
  8005a5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005a8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005ab:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005b2:	e9 4e ff ff ff       	jmp    800505 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005b7:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005ba:	e9 46 ff ff ff       	jmp    800505 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c2:	83 c0 04             	add    $0x4,%eax
  8005c5:	89 45 14             	mov    %eax,0x14(%ebp)
  8005c8:	8b 45 14             	mov    0x14(%ebp),%eax
  8005cb:	83 e8 04             	sub    $0x4,%eax
  8005ce:	8b 00                	mov    (%eax),%eax
  8005d0:	83 ec 08             	sub    $0x8,%esp
  8005d3:	ff 75 0c             	pushl  0xc(%ebp)
  8005d6:	50                   	push   %eax
  8005d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005da:	ff d0                	call   *%eax
  8005dc:	83 c4 10             	add    $0x10,%esp
			break;
  8005df:	e9 89 02 00 00       	jmp    80086d <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e7:	83 c0 04             	add    $0x4,%eax
  8005ea:	89 45 14             	mov    %eax,0x14(%ebp)
  8005ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8005f0:	83 e8 04             	sub    $0x4,%eax
  8005f3:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005f5:	85 db                	test   %ebx,%ebx
  8005f7:	79 02                	jns    8005fb <vprintfmt+0x14a>
				err = -err;
  8005f9:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005fb:	83 fb 64             	cmp    $0x64,%ebx
  8005fe:	7f 0b                	jg     80060b <vprintfmt+0x15a>
  800600:	8b 34 9d 40 1e 80 00 	mov    0x801e40(,%ebx,4),%esi
  800607:	85 f6                	test   %esi,%esi
  800609:	75 19                	jne    800624 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80060b:	53                   	push   %ebx
  80060c:	68 e5 1f 80 00       	push   $0x801fe5
  800611:	ff 75 0c             	pushl  0xc(%ebp)
  800614:	ff 75 08             	pushl  0x8(%ebp)
  800617:	e8 5e 02 00 00       	call   80087a <printfmt>
  80061c:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80061f:	e9 49 02 00 00       	jmp    80086d <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800624:	56                   	push   %esi
  800625:	68 ee 1f 80 00       	push   $0x801fee
  80062a:	ff 75 0c             	pushl  0xc(%ebp)
  80062d:	ff 75 08             	pushl  0x8(%ebp)
  800630:	e8 45 02 00 00       	call   80087a <printfmt>
  800635:	83 c4 10             	add    $0x10,%esp
			break;
  800638:	e9 30 02 00 00       	jmp    80086d <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80063d:	8b 45 14             	mov    0x14(%ebp),%eax
  800640:	83 c0 04             	add    $0x4,%eax
  800643:	89 45 14             	mov    %eax,0x14(%ebp)
  800646:	8b 45 14             	mov    0x14(%ebp),%eax
  800649:	83 e8 04             	sub    $0x4,%eax
  80064c:	8b 30                	mov    (%eax),%esi
  80064e:	85 f6                	test   %esi,%esi
  800650:	75 05                	jne    800657 <vprintfmt+0x1a6>
				p = "(null)";
  800652:	be f1 1f 80 00       	mov    $0x801ff1,%esi
			if (width > 0 && padc != '-')
  800657:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80065b:	7e 6d                	jle    8006ca <vprintfmt+0x219>
  80065d:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800661:	74 67                	je     8006ca <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800663:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800666:	83 ec 08             	sub    $0x8,%esp
  800669:	50                   	push   %eax
  80066a:	56                   	push   %esi
  80066b:	e8 12 05 00 00       	call   800b82 <strnlen>
  800670:	83 c4 10             	add    $0x10,%esp
  800673:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800676:	eb 16                	jmp    80068e <vprintfmt+0x1dd>
					putch(padc, putdat);
  800678:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80067c:	83 ec 08             	sub    $0x8,%esp
  80067f:	ff 75 0c             	pushl  0xc(%ebp)
  800682:	50                   	push   %eax
  800683:	8b 45 08             	mov    0x8(%ebp),%eax
  800686:	ff d0                	call   *%eax
  800688:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80068b:	ff 4d e4             	decl   -0x1c(%ebp)
  80068e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800692:	7f e4                	jg     800678 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800694:	eb 34                	jmp    8006ca <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800696:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80069a:	74 1c                	je     8006b8 <vprintfmt+0x207>
  80069c:	83 fb 1f             	cmp    $0x1f,%ebx
  80069f:	7e 05                	jle    8006a6 <vprintfmt+0x1f5>
  8006a1:	83 fb 7e             	cmp    $0x7e,%ebx
  8006a4:	7e 12                	jle    8006b8 <vprintfmt+0x207>
					putch('?', putdat);
  8006a6:	83 ec 08             	sub    $0x8,%esp
  8006a9:	ff 75 0c             	pushl  0xc(%ebp)
  8006ac:	6a 3f                	push   $0x3f
  8006ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b1:	ff d0                	call   *%eax
  8006b3:	83 c4 10             	add    $0x10,%esp
  8006b6:	eb 0f                	jmp    8006c7 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006b8:	83 ec 08             	sub    $0x8,%esp
  8006bb:	ff 75 0c             	pushl  0xc(%ebp)
  8006be:	53                   	push   %ebx
  8006bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c2:	ff d0                	call   *%eax
  8006c4:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006c7:	ff 4d e4             	decl   -0x1c(%ebp)
  8006ca:	89 f0                	mov    %esi,%eax
  8006cc:	8d 70 01             	lea    0x1(%eax),%esi
  8006cf:	8a 00                	mov    (%eax),%al
  8006d1:	0f be d8             	movsbl %al,%ebx
  8006d4:	85 db                	test   %ebx,%ebx
  8006d6:	74 24                	je     8006fc <vprintfmt+0x24b>
  8006d8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006dc:	78 b8                	js     800696 <vprintfmt+0x1e5>
  8006de:	ff 4d e0             	decl   -0x20(%ebp)
  8006e1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006e5:	79 af                	jns    800696 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006e7:	eb 13                	jmp    8006fc <vprintfmt+0x24b>
				putch(' ', putdat);
  8006e9:	83 ec 08             	sub    $0x8,%esp
  8006ec:	ff 75 0c             	pushl  0xc(%ebp)
  8006ef:	6a 20                	push   $0x20
  8006f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f4:	ff d0                	call   *%eax
  8006f6:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006f9:	ff 4d e4             	decl   -0x1c(%ebp)
  8006fc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800700:	7f e7                	jg     8006e9 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800702:	e9 66 01 00 00       	jmp    80086d <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800707:	83 ec 08             	sub    $0x8,%esp
  80070a:	ff 75 e8             	pushl  -0x18(%ebp)
  80070d:	8d 45 14             	lea    0x14(%ebp),%eax
  800710:	50                   	push   %eax
  800711:	e8 3c fd ff ff       	call   800452 <getint>
  800716:	83 c4 10             	add    $0x10,%esp
  800719:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80071c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80071f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800722:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800725:	85 d2                	test   %edx,%edx
  800727:	79 23                	jns    80074c <vprintfmt+0x29b>
				putch('-', putdat);
  800729:	83 ec 08             	sub    $0x8,%esp
  80072c:	ff 75 0c             	pushl  0xc(%ebp)
  80072f:	6a 2d                	push   $0x2d
  800731:	8b 45 08             	mov    0x8(%ebp),%eax
  800734:	ff d0                	call   *%eax
  800736:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800739:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80073c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80073f:	f7 d8                	neg    %eax
  800741:	83 d2 00             	adc    $0x0,%edx
  800744:	f7 da                	neg    %edx
  800746:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800749:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80074c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800753:	e9 bc 00 00 00       	jmp    800814 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800758:	83 ec 08             	sub    $0x8,%esp
  80075b:	ff 75 e8             	pushl  -0x18(%ebp)
  80075e:	8d 45 14             	lea    0x14(%ebp),%eax
  800761:	50                   	push   %eax
  800762:	e8 84 fc ff ff       	call   8003eb <getuint>
  800767:	83 c4 10             	add    $0x10,%esp
  80076a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80076d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800770:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800777:	e9 98 00 00 00       	jmp    800814 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80077c:	83 ec 08             	sub    $0x8,%esp
  80077f:	ff 75 0c             	pushl  0xc(%ebp)
  800782:	6a 58                	push   $0x58
  800784:	8b 45 08             	mov    0x8(%ebp),%eax
  800787:	ff d0                	call   *%eax
  800789:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80078c:	83 ec 08             	sub    $0x8,%esp
  80078f:	ff 75 0c             	pushl  0xc(%ebp)
  800792:	6a 58                	push   $0x58
  800794:	8b 45 08             	mov    0x8(%ebp),%eax
  800797:	ff d0                	call   *%eax
  800799:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80079c:	83 ec 08             	sub    $0x8,%esp
  80079f:	ff 75 0c             	pushl  0xc(%ebp)
  8007a2:	6a 58                	push   $0x58
  8007a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a7:	ff d0                	call   *%eax
  8007a9:	83 c4 10             	add    $0x10,%esp
			break;
  8007ac:	e9 bc 00 00 00       	jmp    80086d <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007b1:	83 ec 08             	sub    $0x8,%esp
  8007b4:	ff 75 0c             	pushl  0xc(%ebp)
  8007b7:	6a 30                	push   $0x30
  8007b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bc:	ff d0                	call   *%eax
  8007be:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007c1:	83 ec 08             	sub    $0x8,%esp
  8007c4:	ff 75 0c             	pushl  0xc(%ebp)
  8007c7:	6a 78                	push   $0x78
  8007c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cc:	ff d0                	call   *%eax
  8007ce:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007d1:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d4:	83 c0 04             	add    $0x4,%eax
  8007d7:	89 45 14             	mov    %eax,0x14(%ebp)
  8007da:	8b 45 14             	mov    0x14(%ebp),%eax
  8007dd:	83 e8 04             	sub    $0x4,%eax
  8007e0:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007ec:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007f3:	eb 1f                	jmp    800814 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007f5:	83 ec 08             	sub    $0x8,%esp
  8007f8:	ff 75 e8             	pushl  -0x18(%ebp)
  8007fb:	8d 45 14             	lea    0x14(%ebp),%eax
  8007fe:	50                   	push   %eax
  8007ff:	e8 e7 fb ff ff       	call   8003eb <getuint>
  800804:	83 c4 10             	add    $0x10,%esp
  800807:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80080a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80080d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800814:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800818:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80081b:	83 ec 04             	sub    $0x4,%esp
  80081e:	52                   	push   %edx
  80081f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800822:	50                   	push   %eax
  800823:	ff 75 f4             	pushl  -0xc(%ebp)
  800826:	ff 75 f0             	pushl  -0x10(%ebp)
  800829:	ff 75 0c             	pushl  0xc(%ebp)
  80082c:	ff 75 08             	pushl  0x8(%ebp)
  80082f:	e8 00 fb ff ff       	call   800334 <printnum>
  800834:	83 c4 20             	add    $0x20,%esp
			break;
  800837:	eb 34                	jmp    80086d <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800839:	83 ec 08             	sub    $0x8,%esp
  80083c:	ff 75 0c             	pushl  0xc(%ebp)
  80083f:	53                   	push   %ebx
  800840:	8b 45 08             	mov    0x8(%ebp),%eax
  800843:	ff d0                	call   *%eax
  800845:	83 c4 10             	add    $0x10,%esp
			break;
  800848:	eb 23                	jmp    80086d <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80084a:	83 ec 08             	sub    $0x8,%esp
  80084d:	ff 75 0c             	pushl  0xc(%ebp)
  800850:	6a 25                	push   $0x25
  800852:	8b 45 08             	mov    0x8(%ebp),%eax
  800855:	ff d0                	call   *%eax
  800857:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80085a:	ff 4d 10             	decl   0x10(%ebp)
  80085d:	eb 03                	jmp    800862 <vprintfmt+0x3b1>
  80085f:	ff 4d 10             	decl   0x10(%ebp)
  800862:	8b 45 10             	mov    0x10(%ebp),%eax
  800865:	48                   	dec    %eax
  800866:	8a 00                	mov    (%eax),%al
  800868:	3c 25                	cmp    $0x25,%al
  80086a:	75 f3                	jne    80085f <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80086c:	90                   	nop
		}
	}
  80086d:	e9 47 fc ff ff       	jmp    8004b9 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800872:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800873:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800876:	5b                   	pop    %ebx
  800877:	5e                   	pop    %esi
  800878:	5d                   	pop    %ebp
  800879:	c3                   	ret    

0080087a <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80087a:	55                   	push   %ebp
  80087b:	89 e5                	mov    %esp,%ebp
  80087d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800880:	8d 45 10             	lea    0x10(%ebp),%eax
  800883:	83 c0 04             	add    $0x4,%eax
  800886:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800889:	8b 45 10             	mov    0x10(%ebp),%eax
  80088c:	ff 75 f4             	pushl  -0xc(%ebp)
  80088f:	50                   	push   %eax
  800890:	ff 75 0c             	pushl  0xc(%ebp)
  800893:	ff 75 08             	pushl  0x8(%ebp)
  800896:	e8 16 fc ff ff       	call   8004b1 <vprintfmt>
  80089b:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80089e:	90                   	nop
  80089f:	c9                   	leave  
  8008a0:	c3                   	ret    

008008a1 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008a1:	55                   	push   %ebp
  8008a2:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a7:	8b 40 08             	mov    0x8(%eax),%eax
  8008aa:	8d 50 01             	lea    0x1(%eax),%edx
  8008ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b0:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b6:	8b 10                	mov    (%eax),%edx
  8008b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008bb:	8b 40 04             	mov    0x4(%eax),%eax
  8008be:	39 c2                	cmp    %eax,%edx
  8008c0:	73 12                	jae    8008d4 <sprintputch+0x33>
		*b->buf++ = ch;
  8008c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c5:	8b 00                	mov    (%eax),%eax
  8008c7:	8d 48 01             	lea    0x1(%eax),%ecx
  8008ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008cd:	89 0a                	mov    %ecx,(%edx)
  8008cf:	8b 55 08             	mov    0x8(%ebp),%edx
  8008d2:	88 10                	mov    %dl,(%eax)
}
  8008d4:	90                   	nop
  8008d5:	5d                   	pop    %ebp
  8008d6:	c3                   	ret    

008008d7 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008d7:	55                   	push   %ebp
  8008d8:	89 e5                	mov    %esp,%ebp
  8008da:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ec:	01 d0                	add    %edx,%eax
  8008ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008f8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008fc:	74 06                	je     800904 <vsnprintf+0x2d>
  8008fe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800902:	7f 07                	jg     80090b <vsnprintf+0x34>
		return -E_INVAL;
  800904:	b8 03 00 00 00       	mov    $0x3,%eax
  800909:	eb 20                	jmp    80092b <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80090b:	ff 75 14             	pushl  0x14(%ebp)
  80090e:	ff 75 10             	pushl  0x10(%ebp)
  800911:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800914:	50                   	push   %eax
  800915:	68 a1 08 80 00       	push   $0x8008a1
  80091a:	e8 92 fb ff ff       	call   8004b1 <vprintfmt>
  80091f:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800922:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800925:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800928:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80092b:	c9                   	leave  
  80092c:	c3                   	ret    

0080092d <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80092d:	55                   	push   %ebp
  80092e:	89 e5                	mov    %esp,%ebp
  800930:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800933:	8d 45 10             	lea    0x10(%ebp),%eax
  800936:	83 c0 04             	add    $0x4,%eax
  800939:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80093c:	8b 45 10             	mov    0x10(%ebp),%eax
  80093f:	ff 75 f4             	pushl  -0xc(%ebp)
  800942:	50                   	push   %eax
  800943:	ff 75 0c             	pushl  0xc(%ebp)
  800946:	ff 75 08             	pushl  0x8(%ebp)
  800949:	e8 89 ff ff ff       	call   8008d7 <vsnprintf>
  80094e:	83 c4 10             	add    $0x10,%esp
  800951:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800954:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800957:	c9                   	leave  
  800958:	c3                   	ret    

00800959 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800959:	55                   	push   %ebp
  80095a:	89 e5                	mov    %esp,%ebp
  80095c:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80095f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800963:	74 13                	je     800978 <readline+0x1f>
		cprintf("%s", prompt);
  800965:	83 ec 08             	sub    $0x8,%esp
  800968:	ff 75 08             	pushl  0x8(%ebp)
  80096b:	68 50 21 80 00       	push   $0x802150
  800970:	e8 62 f9 ff ff       	call   8002d7 <cprintf>
  800975:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800978:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80097f:	83 ec 0c             	sub    $0xc,%esp
  800982:	6a 00                	push   $0x0
  800984:	e8 a1 10 00 00       	call   801a2a <iscons>
  800989:	83 c4 10             	add    $0x10,%esp
  80098c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80098f:	e8 48 10 00 00       	call   8019dc <getchar>
  800994:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800997:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80099b:	79 22                	jns    8009bf <readline+0x66>
			if (c != -E_EOF)
  80099d:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8009a1:	0f 84 ad 00 00 00    	je     800a54 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8009a7:	83 ec 08             	sub    $0x8,%esp
  8009aa:	ff 75 ec             	pushl  -0x14(%ebp)
  8009ad:	68 53 21 80 00       	push   $0x802153
  8009b2:	e8 20 f9 ff ff       	call   8002d7 <cprintf>
  8009b7:	83 c4 10             	add    $0x10,%esp
			return;
  8009ba:	e9 95 00 00 00       	jmp    800a54 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8009bf:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8009c3:	7e 34                	jle    8009f9 <readline+0xa0>
  8009c5:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8009cc:	7f 2b                	jg     8009f9 <readline+0xa0>
			if (echoing)
  8009ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009d2:	74 0e                	je     8009e2 <readline+0x89>
				cputchar(c);
  8009d4:	83 ec 0c             	sub    $0xc,%esp
  8009d7:	ff 75 ec             	pushl  -0x14(%ebp)
  8009da:	e8 b5 0f 00 00       	call   801994 <cputchar>
  8009df:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8009e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009e5:	8d 50 01             	lea    0x1(%eax),%edx
  8009e8:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8009eb:	89 c2                	mov    %eax,%edx
  8009ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f0:	01 d0                	add    %edx,%eax
  8009f2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8009f5:	88 10                	mov    %dl,(%eax)
  8009f7:	eb 56                	jmp    800a4f <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8009f9:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8009fd:	75 1f                	jne    800a1e <readline+0xc5>
  8009ff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800a03:	7e 19                	jle    800a1e <readline+0xc5>
			if (echoing)
  800a05:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a09:	74 0e                	je     800a19 <readline+0xc0>
				cputchar(c);
  800a0b:	83 ec 0c             	sub    $0xc,%esp
  800a0e:	ff 75 ec             	pushl  -0x14(%ebp)
  800a11:	e8 7e 0f 00 00       	call   801994 <cputchar>
  800a16:	83 c4 10             	add    $0x10,%esp

			i--;
  800a19:	ff 4d f4             	decl   -0xc(%ebp)
  800a1c:	eb 31                	jmp    800a4f <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800a1e:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800a22:	74 0a                	je     800a2e <readline+0xd5>
  800a24:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800a28:	0f 85 61 ff ff ff    	jne    80098f <readline+0x36>
			if (echoing)
  800a2e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a32:	74 0e                	je     800a42 <readline+0xe9>
				cputchar(c);
  800a34:	83 ec 0c             	sub    $0xc,%esp
  800a37:	ff 75 ec             	pushl  -0x14(%ebp)
  800a3a:	e8 55 0f 00 00       	call   801994 <cputchar>
  800a3f:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800a42:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a48:	01 d0                	add    %edx,%eax
  800a4a:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800a4d:	eb 06                	jmp    800a55 <readline+0xfc>
		}
	}
  800a4f:	e9 3b ff ff ff       	jmp    80098f <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800a54:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800a55:	c9                   	leave  
  800a56:	c3                   	ret    

00800a57 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800a57:	55                   	push   %ebp
  800a58:	89 e5                	mov    %esp,%ebp
  800a5a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a5d:	e8 41 0a 00 00       	call   8014a3 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800a62:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a66:	74 13                	je     800a7b <atomic_readline+0x24>
		cprintf("%s", prompt);
  800a68:	83 ec 08             	sub    $0x8,%esp
  800a6b:	ff 75 08             	pushl  0x8(%ebp)
  800a6e:	68 50 21 80 00       	push   $0x802150
  800a73:	e8 5f f8 ff ff       	call   8002d7 <cprintf>
  800a78:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800a7b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800a82:	83 ec 0c             	sub    $0xc,%esp
  800a85:	6a 00                	push   $0x0
  800a87:	e8 9e 0f 00 00       	call   801a2a <iscons>
  800a8c:	83 c4 10             	add    $0x10,%esp
  800a8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800a92:	e8 45 0f 00 00       	call   8019dc <getchar>
  800a97:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800a9a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a9e:	79 23                	jns    800ac3 <atomic_readline+0x6c>
			if (c != -E_EOF)
  800aa0:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800aa4:	74 13                	je     800ab9 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800aa6:	83 ec 08             	sub    $0x8,%esp
  800aa9:	ff 75 ec             	pushl  -0x14(%ebp)
  800aac:	68 53 21 80 00       	push   $0x802153
  800ab1:	e8 21 f8 ff ff       	call   8002d7 <cprintf>
  800ab6:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800ab9:	e8 ff 09 00 00       	call   8014bd <sys_enable_interrupt>
			return;
  800abe:	e9 9a 00 00 00       	jmp    800b5d <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800ac3:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800ac7:	7e 34                	jle    800afd <atomic_readline+0xa6>
  800ac9:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800ad0:	7f 2b                	jg     800afd <atomic_readline+0xa6>
			if (echoing)
  800ad2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800ad6:	74 0e                	je     800ae6 <atomic_readline+0x8f>
				cputchar(c);
  800ad8:	83 ec 0c             	sub    $0xc,%esp
  800adb:	ff 75 ec             	pushl  -0x14(%ebp)
  800ade:	e8 b1 0e 00 00       	call   801994 <cputchar>
  800ae3:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800ae6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ae9:	8d 50 01             	lea    0x1(%eax),%edx
  800aec:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800aef:	89 c2                	mov    %eax,%edx
  800af1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af4:	01 d0                	add    %edx,%eax
  800af6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800af9:	88 10                	mov    %dl,(%eax)
  800afb:	eb 5b                	jmp    800b58 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800afd:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800b01:	75 1f                	jne    800b22 <atomic_readline+0xcb>
  800b03:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800b07:	7e 19                	jle    800b22 <atomic_readline+0xcb>
			if (echoing)
  800b09:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b0d:	74 0e                	je     800b1d <atomic_readline+0xc6>
				cputchar(c);
  800b0f:	83 ec 0c             	sub    $0xc,%esp
  800b12:	ff 75 ec             	pushl  -0x14(%ebp)
  800b15:	e8 7a 0e 00 00       	call   801994 <cputchar>
  800b1a:	83 c4 10             	add    $0x10,%esp
			i--;
  800b1d:	ff 4d f4             	decl   -0xc(%ebp)
  800b20:	eb 36                	jmp    800b58 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800b22:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800b26:	74 0a                	je     800b32 <atomic_readline+0xdb>
  800b28:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800b2c:	0f 85 60 ff ff ff    	jne    800a92 <atomic_readline+0x3b>
			if (echoing)
  800b32:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b36:	74 0e                	je     800b46 <atomic_readline+0xef>
				cputchar(c);
  800b38:	83 ec 0c             	sub    $0xc,%esp
  800b3b:	ff 75 ec             	pushl  -0x14(%ebp)
  800b3e:	e8 51 0e 00 00       	call   801994 <cputchar>
  800b43:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800b46:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4c:	01 d0                	add    %edx,%eax
  800b4e:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800b51:	e8 67 09 00 00       	call   8014bd <sys_enable_interrupt>
			return;
  800b56:	eb 05                	jmp    800b5d <atomic_readline+0x106>
		}
	}
  800b58:	e9 35 ff ff ff       	jmp    800a92 <atomic_readline+0x3b>
}
  800b5d:	c9                   	leave  
  800b5e:	c3                   	ret    

00800b5f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b5f:	55                   	push   %ebp
  800b60:	89 e5                	mov    %esp,%ebp
  800b62:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b65:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b6c:	eb 06                	jmp    800b74 <strlen+0x15>
		n++;
  800b6e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b71:	ff 45 08             	incl   0x8(%ebp)
  800b74:	8b 45 08             	mov    0x8(%ebp),%eax
  800b77:	8a 00                	mov    (%eax),%al
  800b79:	84 c0                	test   %al,%al
  800b7b:	75 f1                	jne    800b6e <strlen+0xf>
		n++;
	return n;
  800b7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b80:	c9                   	leave  
  800b81:	c3                   	ret    

00800b82 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b82:	55                   	push   %ebp
  800b83:	89 e5                	mov    %esp,%ebp
  800b85:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b88:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b8f:	eb 09                	jmp    800b9a <strnlen+0x18>
		n++;
  800b91:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b94:	ff 45 08             	incl   0x8(%ebp)
  800b97:	ff 4d 0c             	decl   0xc(%ebp)
  800b9a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b9e:	74 09                	je     800ba9 <strnlen+0x27>
  800ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba3:	8a 00                	mov    (%eax),%al
  800ba5:	84 c0                	test   %al,%al
  800ba7:	75 e8                	jne    800b91 <strnlen+0xf>
		n++;
	return n;
  800ba9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bac:	c9                   	leave  
  800bad:	c3                   	ret    

00800bae <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bae:	55                   	push   %ebp
  800baf:	89 e5                	mov    %esp,%ebp
  800bb1:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bba:	90                   	nop
  800bbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbe:	8d 50 01             	lea    0x1(%eax),%edx
  800bc1:	89 55 08             	mov    %edx,0x8(%ebp)
  800bc4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc7:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bca:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bcd:	8a 12                	mov    (%edx),%dl
  800bcf:	88 10                	mov    %dl,(%eax)
  800bd1:	8a 00                	mov    (%eax),%al
  800bd3:	84 c0                	test   %al,%al
  800bd5:	75 e4                	jne    800bbb <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bd7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bda:	c9                   	leave  
  800bdb:	c3                   	ret    

00800bdc <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bdc:	55                   	push   %ebp
  800bdd:	89 e5                	mov    %esp,%ebp
  800bdf:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800be2:	8b 45 08             	mov    0x8(%ebp),%eax
  800be5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800be8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bef:	eb 1f                	jmp    800c10 <strncpy+0x34>
		*dst++ = *src;
  800bf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf4:	8d 50 01             	lea    0x1(%eax),%edx
  800bf7:	89 55 08             	mov    %edx,0x8(%ebp)
  800bfa:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bfd:	8a 12                	mov    (%edx),%dl
  800bff:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c01:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c04:	8a 00                	mov    (%eax),%al
  800c06:	84 c0                	test   %al,%al
  800c08:	74 03                	je     800c0d <strncpy+0x31>
			src++;
  800c0a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c0d:	ff 45 fc             	incl   -0x4(%ebp)
  800c10:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c13:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c16:	72 d9                	jb     800bf1 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c18:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c1b:	c9                   	leave  
  800c1c:	c3                   	ret    

00800c1d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c1d:	55                   	push   %ebp
  800c1e:	89 e5                	mov    %esp,%ebp
  800c20:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c23:	8b 45 08             	mov    0x8(%ebp),%eax
  800c26:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c29:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c2d:	74 30                	je     800c5f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c2f:	eb 16                	jmp    800c47 <strlcpy+0x2a>
			*dst++ = *src++;
  800c31:	8b 45 08             	mov    0x8(%ebp),%eax
  800c34:	8d 50 01             	lea    0x1(%eax),%edx
  800c37:	89 55 08             	mov    %edx,0x8(%ebp)
  800c3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c3d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c40:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c43:	8a 12                	mov    (%edx),%dl
  800c45:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c47:	ff 4d 10             	decl   0x10(%ebp)
  800c4a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c4e:	74 09                	je     800c59 <strlcpy+0x3c>
  800c50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c53:	8a 00                	mov    (%eax),%al
  800c55:	84 c0                	test   %al,%al
  800c57:	75 d8                	jne    800c31 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c59:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c5f:	8b 55 08             	mov    0x8(%ebp),%edx
  800c62:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c65:	29 c2                	sub    %eax,%edx
  800c67:	89 d0                	mov    %edx,%eax
}
  800c69:	c9                   	leave  
  800c6a:	c3                   	ret    

00800c6b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c6b:	55                   	push   %ebp
  800c6c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c6e:	eb 06                	jmp    800c76 <strcmp+0xb>
		p++, q++;
  800c70:	ff 45 08             	incl   0x8(%ebp)
  800c73:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c76:	8b 45 08             	mov    0x8(%ebp),%eax
  800c79:	8a 00                	mov    (%eax),%al
  800c7b:	84 c0                	test   %al,%al
  800c7d:	74 0e                	je     800c8d <strcmp+0x22>
  800c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c82:	8a 10                	mov    (%eax),%dl
  800c84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c87:	8a 00                	mov    (%eax),%al
  800c89:	38 c2                	cmp    %al,%dl
  800c8b:	74 e3                	je     800c70 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c90:	8a 00                	mov    (%eax),%al
  800c92:	0f b6 d0             	movzbl %al,%edx
  800c95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c98:	8a 00                	mov    (%eax),%al
  800c9a:	0f b6 c0             	movzbl %al,%eax
  800c9d:	29 c2                	sub    %eax,%edx
  800c9f:	89 d0                	mov    %edx,%eax
}
  800ca1:	5d                   	pop    %ebp
  800ca2:	c3                   	ret    

00800ca3 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ca3:	55                   	push   %ebp
  800ca4:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ca6:	eb 09                	jmp    800cb1 <strncmp+0xe>
		n--, p++, q++;
  800ca8:	ff 4d 10             	decl   0x10(%ebp)
  800cab:	ff 45 08             	incl   0x8(%ebp)
  800cae:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cb1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cb5:	74 17                	je     800cce <strncmp+0x2b>
  800cb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cba:	8a 00                	mov    (%eax),%al
  800cbc:	84 c0                	test   %al,%al
  800cbe:	74 0e                	je     800cce <strncmp+0x2b>
  800cc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc3:	8a 10                	mov    (%eax),%dl
  800cc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc8:	8a 00                	mov    (%eax),%al
  800cca:	38 c2                	cmp    %al,%dl
  800ccc:	74 da                	je     800ca8 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cce:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd2:	75 07                	jne    800cdb <strncmp+0x38>
		return 0;
  800cd4:	b8 00 00 00 00       	mov    $0x0,%eax
  800cd9:	eb 14                	jmp    800cef <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cde:	8a 00                	mov    (%eax),%al
  800ce0:	0f b6 d0             	movzbl %al,%edx
  800ce3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce6:	8a 00                	mov    (%eax),%al
  800ce8:	0f b6 c0             	movzbl %al,%eax
  800ceb:	29 c2                	sub    %eax,%edx
  800ced:	89 d0                	mov    %edx,%eax
}
  800cef:	5d                   	pop    %ebp
  800cf0:	c3                   	ret    

00800cf1 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800cf1:	55                   	push   %ebp
  800cf2:	89 e5                	mov    %esp,%ebp
  800cf4:	83 ec 04             	sub    $0x4,%esp
  800cf7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cfa:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cfd:	eb 12                	jmp    800d11 <strchr+0x20>
		if (*s == c)
  800cff:	8b 45 08             	mov    0x8(%ebp),%eax
  800d02:	8a 00                	mov    (%eax),%al
  800d04:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d07:	75 05                	jne    800d0e <strchr+0x1d>
			return (char *) s;
  800d09:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0c:	eb 11                	jmp    800d1f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d0e:	ff 45 08             	incl   0x8(%ebp)
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
  800d14:	8a 00                	mov    (%eax),%al
  800d16:	84 c0                	test   %al,%al
  800d18:	75 e5                	jne    800cff <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d1a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d1f:	c9                   	leave  
  800d20:	c3                   	ret    

00800d21 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d21:	55                   	push   %ebp
  800d22:	89 e5                	mov    %esp,%ebp
  800d24:	83 ec 04             	sub    $0x4,%esp
  800d27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d2d:	eb 0d                	jmp    800d3c <strfind+0x1b>
		if (*s == c)
  800d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d32:	8a 00                	mov    (%eax),%al
  800d34:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d37:	74 0e                	je     800d47 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d39:	ff 45 08             	incl   0x8(%ebp)
  800d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3f:	8a 00                	mov    (%eax),%al
  800d41:	84 c0                	test   %al,%al
  800d43:	75 ea                	jne    800d2f <strfind+0xe>
  800d45:	eb 01                	jmp    800d48 <strfind+0x27>
		if (*s == c)
			break;
  800d47:	90                   	nop
	return (char *) s;
  800d48:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d4b:	c9                   	leave  
  800d4c:	c3                   	ret    

00800d4d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d4d:	55                   	push   %ebp
  800d4e:	89 e5                	mov    %esp,%ebp
  800d50:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d53:	8b 45 08             	mov    0x8(%ebp),%eax
  800d56:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d59:	8b 45 10             	mov    0x10(%ebp),%eax
  800d5c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d5f:	eb 0e                	jmp    800d6f <memset+0x22>
		*p++ = c;
  800d61:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d64:	8d 50 01             	lea    0x1(%eax),%edx
  800d67:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d6d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d6f:	ff 4d f8             	decl   -0x8(%ebp)
  800d72:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d76:	79 e9                	jns    800d61 <memset+0x14>
		*p++ = c;

	return v;
  800d78:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d7b:	c9                   	leave  
  800d7c:	c3                   	ret    

00800d7d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d7d:	55                   	push   %ebp
  800d7e:	89 e5                	mov    %esp,%ebp
  800d80:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d83:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d86:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d89:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d8f:	eb 16                	jmp    800da7 <memcpy+0x2a>
		*d++ = *s++;
  800d91:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d94:	8d 50 01             	lea    0x1(%eax),%edx
  800d97:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d9a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d9d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800da0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800da3:	8a 12                	mov    (%edx),%dl
  800da5:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800da7:	8b 45 10             	mov    0x10(%ebp),%eax
  800daa:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dad:	89 55 10             	mov    %edx,0x10(%ebp)
  800db0:	85 c0                	test   %eax,%eax
  800db2:	75 dd                	jne    800d91 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800db4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800db7:	c9                   	leave  
  800db8:	c3                   	ret    

00800db9 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800db9:	55                   	push   %ebp
  800dba:	89 e5                	mov    %esp,%ebp
  800dbc:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800dbf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800dcb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dce:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dd1:	73 50                	jae    800e23 <memmove+0x6a>
  800dd3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dd6:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd9:	01 d0                	add    %edx,%eax
  800ddb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dde:	76 43                	jbe    800e23 <memmove+0x6a>
		s += n;
  800de0:	8b 45 10             	mov    0x10(%ebp),%eax
  800de3:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800de6:	8b 45 10             	mov    0x10(%ebp),%eax
  800de9:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800dec:	eb 10                	jmp    800dfe <memmove+0x45>
			*--d = *--s;
  800dee:	ff 4d f8             	decl   -0x8(%ebp)
  800df1:	ff 4d fc             	decl   -0x4(%ebp)
  800df4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800df7:	8a 10                	mov    (%eax),%dl
  800df9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dfc:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800dfe:	8b 45 10             	mov    0x10(%ebp),%eax
  800e01:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e04:	89 55 10             	mov    %edx,0x10(%ebp)
  800e07:	85 c0                	test   %eax,%eax
  800e09:	75 e3                	jne    800dee <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e0b:	eb 23                	jmp    800e30 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e0d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e10:	8d 50 01             	lea    0x1(%eax),%edx
  800e13:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e16:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e19:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e1c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e1f:	8a 12                	mov    (%edx),%dl
  800e21:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e23:	8b 45 10             	mov    0x10(%ebp),%eax
  800e26:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e29:	89 55 10             	mov    %edx,0x10(%ebp)
  800e2c:	85 c0                	test   %eax,%eax
  800e2e:	75 dd                	jne    800e0d <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e30:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e33:	c9                   	leave  
  800e34:	c3                   	ret    

00800e35 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e35:	55                   	push   %ebp
  800e36:	89 e5                	mov    %esp,%ebp
  800e38:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e44:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e47:	eb 2a                	jmp    800e73 <memcmp+0x3e>
		if (*s1 != *s2)
  800e49:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e4c:	8a 10                	mov    (%eax),%dl
  800e4e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e51:	8a 00                	mov    (%eax),%al
  800e53:	38 c2                	cmp    %al,%dl
  800e55:	74 16                	je     800e6d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e57:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e5a:	8a 00                	mov    (%eax),%al
  800e5c:	0f b6 d0             	movzbl %al,%edx
  800e5f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e62:	8a 00                	mov    (%eax),%al
  800e64:	0f b6 c0             	movzbl %al,%eax
  800e67:	29 c2                	sub    %eax,%edx
  800e69:	89 d0                	mov    %edx,%eax
  800e6b:	eb 18                	jmp    800e85 <memcmp+0x50>
		s1++, s2++;
  800e6d:	ff 45 fc             	incl   -0x4(%ebp)
  800e70:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e73:	8b 45 10             	mov    0x10(%ebp),%eax
  800e76:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e79:	89 55 10             	mov    %edx,0x10(%ebp)
  800e7c:	85 c0                	test   %eax,%eax
  800e7e:	75 c9                	jne    800e49 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e80:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e85:	c9                   	leave  
  800e86:	c3                   	ret    

00800e87 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e87:	55                   	push   %ebp
  800e88:	89 e5                	mov    %esp,%ebp
  800e8a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e8d:	8b 55 08             	mov    0x8(%ebp),%edx
  800e90:	8b 45 10             	mov    0x10(%ebp),%eax
  800e93:	01 d0                	add    %edx,%eax
  800e95:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e98:	eb 15                	jmp    800eaf <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9d:	8a 00                	mov    (%eax),%al
  800e9f:	0f b6 d0             	movzbl %al,%edx
  800ea2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea5:	0f b6 c0             	movzbl %al,%eax
  800ea8:	39 c2                	cmp    %eax,%edx
  800eaa:	74 0d                	je     800eb9 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800eac:	ff 45 08             	incl   0x8(%ebp)
  800eaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800eb5:	72 e3                	jb     800e9a <memfind+0x13>
  800eb7:	eb 01                	jmp    800eba <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800eb9:	90                   	nop
	return (void *) s;
  800eba:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ebd:	c9                   	leave  
  800ebe:	c3                   	ret    

00800ebf <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ebf:	55                   	push   %ebp
  800ec0:	89 e5                	mov    %esp,%ebp
  800ec2:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ec5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ecc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ed3:	eb 03                	jmp    800ed8 <strtol+0x19>
		s++;
  800ed5:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  800edb:	8a 00                	mov    (%eax),%al
  800edd:	3c 20                	cmp    $0x20,%al
  800edf:	74 f4                	je     800ed5 <strtol+0x16>
  800ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee4:	8a 00                	mov    (%eax),%al
  800ee6:	3c 09                	cmp    $0x9,%al
  800ee8:	74 eb                	je     800ed5 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800eea:	8b 45 08             	mov    0x8(%ebp),%eax
  800eed:	8a 00                	mov    (%eax),%al
  800eef:	3c 2b                	cmp    $0x2b,%al
  800ef1:	75 05                	jne    800ef8 <strtol+0x39>
		s++;
  800ef3:	ff 45 08             	incl   0x8(%ebp)
  800ef6:	eb 13                	jmp    800f0b <strtol+0x4c>
	else if (*s == '-')
  800ef8:	8b 45 08             	mov    0x8(%ebp),%eax
  800efb:	8a 00                	mov    (%eax),%al
  800efd:	3c 2d                	cmp    $0x2d,%al
  800eff:	75 0a                	jne    800f0b <strtol+0x4c>
		s++, neg = 1;
  800f01:	ff 45 08             	incl   0x8(%ebp)
  800f04:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f0b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f0f:	74 06                	je     800f17 <strtol+0x58>
  800f11:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f15:	75 20                	jne    800f37 <strtol+0x78>
  800f17:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1a:	8a 00                	mov    (%eax),%al
  800f1c:	3c 30                	cmp    $0x30,%al
  800f1e:	75 17                	jne    800f37 <strtol+0x78>
  800f20:	8b 45 08             	mov    0x8(%ebp),%eax
  800f23:	40                   	inc    %eax
  800f24:	8a 00                	mov    (%eax),%al
  800f26:	3c 78                	cmp    $0x78,%al
  800f28:	75 0d                	jne    800f37 <strtol+0x78>
		s += 2, base = 16;
  800f2a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f2e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f35:	eb 28                	jmp    800f5f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f37:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f3b:	75 15                	jne    800f52 <strtol+0x93>
  800f3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f40:	8a 00                	mov    (%eax),%al
  800f42:	3c 30                	cmp    $0x30,%al
  800f44:	75 0c                	jne    800f52 <strtol+0x93>
		s++, base = 8;
  800f46:	ff 45 08             	incl   0x8(%ebp)
  800f49:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f50:	eb 0d                	jmp    800f5f <strtol+0xa0>
	else if (base == 0)
  800f52:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f56:	75 07                	jne    800f5f <strtol+0xa0>
		base = 10;
  800f58:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	8a 00                	mov    (%eax),%al
  800f64:	3c 2f                	cmp    $0x2f,%al
  800f66:	7e 19                	jle    800f81 <strtol+0xc2>
  800f68:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6b:	8a 00                	mov    (%eax),%al
  800f6d:	3c 39                	cmp    $0x39,%al
  800f6f:	7f 10                	jg     800f81 <strtol+0xc2>
			dig = *s - '0';
  800f71:	8b 45 08             	mov    0x8(%ebp),%eax
  800f74:	8a 00                	mov    (%eax),%al
  800f76:	0f be c0             	movsbl %al,%eax
  800f79:	83 e8 30             	sub    $0x30,%eax
  800f7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f7f:	eb 42                	jmp    800fc3 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f81:	8b 45 08             	mov    0x8(%ebp),%eax
  800f84:	8a 00                	mov    (%eax),%al
  800f86:	3c 60                	cmp    $0x60,%al
  800f88:	7e 19                	jle    800fa3 <strtol+0xe4>
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	8a 00                	mov    (%eax),%al
  800f8f:	3c 7a                	cmp    $0x7a,%al
  800f91:	7f 10                	jg     800fa3 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f93:	8b 45 08             	mov    0x8(%ebp),%eax
  800f96:	8a 00                	mov    (%eax),%al
  800f98:	0f be c0             	movsbl %al,%eax
  800f9b:	83 e8 57             	sub    $0x57,%eax
  800f9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fa1:	eb 20                	jmp    800fc3 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa6:	8a 00                	mov    (%eax),%al
  800fa8:	3c 40                	cmp    $0x40,%al
  800faa:	7e 39                	jle    800fe5 <strtol+0x126>
  800fac:	8b 45 08             	mov    0x8(%ebp),%eax
  800faf:	8a 00                	mov    (%eax),%al
  800fb1:	3c 5a                	cmp    $0x5a,%al
  800fb3:	7f 30                	jg     800fe5 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb8:	8a 00                	mov    (%eax),%al
  800fba:	0f be c0             	movsbl %al,%eax
  800fbd:	83 e8 37             	sub    $0x37,%eax
  800fc0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fc6:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fc9:	7d 19                	jge    800fe4 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fcb:	ff 45 08             	incl   0x8(%ebp)
  800fce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd1:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fd5:	89 c2                	mov    %eax,%edx
  800fd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fda:	01 d0                	add    %edx,%eax
  800fdc:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fdf:	e9 7b ff ff ff       	jmp    800f5f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fe4:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fe5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fe9:	74 08                	je     800ff3 <strtol+0x134>
		*endptr = (char *) s;
  800feb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fee:	8b 55 08             	mov    0x8(%ebp),%edx
  800ff1:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800ff3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ff7:	74 07                	je     801000 <strtol+0x141>
  800ff9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ffc:	f7 d8                	neg    %eax
  800ffe:	eb 03                	jmp    801003 <strtol+0x144>
  801000:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801003:	c9                   	leave  
  801004:	c3                   	ret    

00801005 <ltostr>:

void
ltostr(long value, char *str)
{
  801005:	55                   	push   %ebp
  801006:	89 e5                	mov    %esp,%ebp
  801008:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80100b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801012:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801019:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80101d:	79 13                	jns    801032 <ltostr+0x2d>
	{
		neg = 1;
  80101f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801026:	8b 45 0c             	mov    0xc(%ebp),%eax
  801029:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80102c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80102f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801032:	8b 45 08             	mov    0x8(%ebp),%eax
  801035:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80103a:	99                   	cltd   
  80103b:	f7 f9                	idiv   %ecx
  80103d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801040:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801043:	8d 50 01             	lea    0x1(%eax),%edx
  801046:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801049:	89 c2                	mov    %eax,%edx
  80104b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104e:	01 d0                	add    %edx,%eax
  801050:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801053:	83 c2 30             	add    $0x30,%edx
  801056:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801058:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80105b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801060:	f7 e9                	imul   %ecx
  801062:	c1 fa 02             	sar    $0x2,%edx
  801065:	89 c8                	mov    %ecx,%eax
  801067:	c1 f8 1f             	sar    $0x1f,%eax
  80106a:	29 c2                	sub    %eax,%edx
  80106c:	89 d0                	mov    %edx,%eax
  80106e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801071:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801074:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801079:	f7 e9                	imul   %ecx
  80107b:	c1 fa 02             	sar    $0x2,%edx
  80107e:	89 c8                	mov    %ecx,%eax
  801080:	c1 f8 1f             	sar    $0x1f,%eax
  801083:	29 c2                	sub    %eax,%edx
  801085:	89 d0                	mov    %edx,%eax
  801087:	c1 e0 02             	shl    $0x2,%eax
  80108a:	01 d0                	add    %edx,%eax
  80108c:	01 c0                	add    %eax,%eax
  80108e:	29 c1                	sub    %eax,%ecx
  801090:	89 ca                	mov    %ecx,%edx
  801092:	85 d2                	test   %edx,%edx
  801094:	75 9c                	jne    801032 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801096:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80109d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010a0:	48                   	dec    %eax
  8010a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010a4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010a8:	74 3d                	je     8010e7 <ltostr+0xe2>
		start = 1 ;
  8010aa:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010b1:	eb 34                	jmp    8010e7 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b9:	01 d0                	add    %edx,%eax
  8010bb:	8a 00                	mov    (%eax),%al
  8010bd:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c6:	01 c2                	add    %eax,%edx
  8010c8:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ce:	01 c8                	add    %ecx,%eax
  8010d0:	8a 00                	mov    (%eax),%al
  8010d2:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010d4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010da:	01 c2                	add    %eax,%edx
  8010dc:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010df:	88 02                	mov    %al,(%edx)
		start++ ;
  8010e1:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010e4:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010ea:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010ed:	7c c4                	jl     8010b3 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010ef:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f5:	01 d0                	add    %edx,%eax
  8010f7:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010fa:	90                   	nop
  8010fb:	c9                   	leave  
  8010fc:	c3                   	ret    

008010fd <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010fd:	55                   	push   %ebp
  8010fe:	89 e5                	mov    %esp,%ebp
  801100:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801103:	ff 75 08             	pushl  0x8(%ebp)
  801106:	e8 54 fa ff ff       	call   800b5f <strlen>
  80110b:	83 c4 04             	add    $0x4,%esp
  80110e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801111:	ff 75 0c             	pushl  0xc(%ebp)
  801114:	e8 46 fa ff ff       	call   800b5f <strlen>
  801119:	83 c4 04             	add    $0x4,%esp
  80111c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80111f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801126:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80112d:	eb 17                	jmp    801146 <strcconcat+0x49>
		final[s] = str1[s] ;
  80112f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801132:	8b 45 10             	mov    0x10(%ebp),%eax
  801135:	01 c2                	add    %eax,%edx
  801137:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80113a:	8b 45 08             	mov    0x8(%ebp),%eax
  80113d:	01 c8                	add    %ecx,%eax
  80113f:	8a 00                	mov    (%eax),%al
  801141:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801143:	ff 45 fc             	incl   -0x4(%ebp)
  801146:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801149:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80114c:	7c e1                	jl     80112f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80114e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801155:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80115c:	eb 1f                	jmp    80117d <strcconcat+0x80>
		final[s++] = str2[i] ;
  80115e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801161:	8d 50 01             	lea    0x1(%eax),%edx
  801164:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801167:	89 c2                	mov    %eax,%edx
  801169:	8b 45 10             	mov    0x10(%ebp),%eax
  80116c:	01 c2                	add    %eax,%edx
  80116e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801171:	8b 45 0c             	mov    0xc(%ebp),%eax
  801174:	01 c8                	add    %ecx,%eax
  801176:	8a 00                	mov    (%eax),%al
  801178:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80117a:	ff 45 f8             	incl   -0x8(%ebp)
  80117d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801180:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801183:	7c d9                	jl     80115e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801185:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801188:	8b 45 10             	mov    0x10(%ebp),%eax
  80118b:	01 d0                	add    %edx,%eax
  80118d:	c6 00 00             	movb   $0x0,(%eax)
}
  801190:	90                   	nop
  801191:	c9                   	leave  
  801192:	c3                   	ret    

00801193 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801193:	55                   	push   %ebp
  801194:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801196:	8b 45 14             	mov    0x14(%ebp),%eax
  801199:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80119f:	8b 45 14             	mov    0x14(%ebp),%eax
  8011a2:	8b 00                	mov    (%eax),%eax
  8011a4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ae:	01 d0                	add    %edx,%eax
  8011b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011b6:	eb 0c                	jmp    8011c4 <strsplit+0x31>
			*string++ = 0;
  8011b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bb:	8d 50 01             	lea    0x1(%eax),%edx
  8011be:	89 55 08             	mov    %edx,0x8(%ebp)
  8011c1:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c7:	8a 00                	mov    (%eax),%al
  8011c9:	84 c0                	test   %al,%al
  8011cb:	74 18                	je     8011e5 <strsplit+0x52>
  8011cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d0:	8a 00                	mov    (%eax),%al
  8011d2:	0f be c0             	movsbl %al,%eax
  8011d5:	50                   	push   %eax
  8011d6:	ff 75 0c             	pushl  0xc(%ebp)
  8011d9:	e8 13 fb ff ff       	call   800cf1 <strchr>
  8011de:	83 c4 08             	add    $0x8,%esp
  8011e1:	85 c0                	test   %eax,%eax
  8011e3:	75 d3                	jne    8011b8 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8011e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e8:	8a 00                	mov    (%eax),%al
  8011ea:	84 c0                	test   %al,%al
  8011ec:	74 5a                	je     801248 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8011ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f1:	8b 00                	mov    (%eax),%eax
  8011f3:	83 f8 0f             	cmp    $0xf,%eax
  8011f6:	75 07                	jne    8011ff <strsplit+0x6c>
		{
			return 0;
  8011f8:	b8 00 00 00 00       	mov    $0x0,%eax
  8011fd:	eb 66                	jmp    801265 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011ff:	8b 45 14             	mov    0x14(%ebp),%eax
  801202:	8b 00                	mov    (%eax),%eax
  801204:	8d 48 01             	lea    0x1(%eax),%ecx
  801207:	8b 55 14             	mov    0x14(%ebp),%edx
  80120a:	89 0a                	mov    %ecx,(%edx)
  80120c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801213:	8b 45 10             	mov    0x10(%ebp),%eax
  801216:	01 c2                	add    %eax,%edx
  801218:	8b 45 08             	mov    0x8(%ebp),%eax
  80121b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80121d:	eb 03                	jmp    801222 <strsplit+0x8f>
			string++;
  80121f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801222:	8b 45 08             	mov    0x8(%ebp),%eax
  801225:	8a 00                	mov    (%eax),%al
  801227:	84 c0                	test   %al,%al
  801229:	74 8b                	je     8011b6 <strsplit+0x23>
  80122b:	8b 45 08             	mov    0x8(%ebp),%eax
  80122e:	8a 00                	mov    (%eax),%al
  801230:	0f be c0             	movsbl %al,%eax
  801233:	50                   	push   %eax
  801234:	ff 75 0c             	pushl  0xc(%ebp)
  801237:	e8 b5 fa ff ff       	call   800cf1 <strchr>
  80123c:	83 c4 08             	add    $0x8,%esp
  80123f:	85 c0                	test   %eax,%eax
  801241:	74 dc                	je     80121f <strsplit+0x8c>
			string++;
	}
  801243:	e9 6e ff ff ff       	jmp    8011b6 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801248:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801249:	8b 45 14             	mov    0x14(%ebp),%eax
  80124c:	8b 00                	mov    (%eax),%eax
  80124e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801255:	8b 45 10             	mov    0x10(%ebp),%eax
  801258:	01 d0                	add    %edx,%eax
  80125a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801260:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801265:	c9                   	leave  
  801266:	c3                   	ret    

00801267 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801267:	55                   	push   %ebp
  801268:	89 e5                	mov    %esp,%ebp
  80126a:	57                   	push   %edi
  80126b:	56                   	push   %esi
  80126c:	53                   	push   %ebx
  80126d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801270:	8b 45 08             	mov    0x8(%ebp),%eax
  801273:	8b 55 0c             	mov    0xc(%ebp),%edx
  801276:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801279:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80127c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80127f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801282:	cd 30                	int    $0x30
  801284:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801287:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80128a:	83 c4 10             	add    $0x10,%esp
  80128d:	5b                   	pop    %ebx
  80128e:	5e                   	pop    %esi
  80128f:	5f                   	pop    %edi
  801290:	5d                   	pop    %ebp
  801291:	c3                   	ret    

00801292 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801292:	55                   	push   %ebp
  801293:	89 e5                	mov    %esp,%ebp
  801295:	83 ec 04             	sub    $0x4,%esp
  801298:	8b 45 10             	mov    0x10(%ebp),%eax
  80129b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80129e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a5:	6a 00                	push   $0x0
  8012a7:	6a 00                	push   $0x0
  8012a9:	52                   	push   %edx
  8012aa:	ff 75 0c             	pushl  0xc(%ebp)
  8012ad:	50                   	push   %eax
  8012ae:	6a 00                	push   $0x0
  8012b0:	e8 b2 ff ff ff       	call   801267 <syscall>
  8012b5:	83 c4 18             	add    $0x18,%esp
}
  8012b8:	90                   	nop
  8012b9:	c9                   	leave  
  8012ba:	c3                   	ret    

008012bb <sys_cgetc>:

int
sys_cgetc(void)
{
  8012bb:	55                   	push   %ebp
  8012bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012be:	6a 00                	push   $0x0
  8012c0:	6a 00                	push   $0x0
  8012c2:	6a 00                	push   $0x0
  8012c4:	6a 00                	push   $0x0
  8012c6:	6a 00                	push   $0x0
  8012c8:	6a 01                	push   $0x1
  8012ca:	e8 98 ff ff ff       	call   801267 <syscall>
  8012cf:	83 c4 18             	add    $0x18,%esp
}
  8012d2:	c9                   	leave  
  8012d3:	c3                   	ret    

008012d4 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012d4:	55                   	push   %ebp
  8012d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012da:	6a 00                	push   $0x0
  8012dc:	6a 00                	push   $0x0
  8012de:	6a 00                	push   $0x0
  8012e0:	6a 00                	push   $0x0
  8012e2:	50                   	push   %eax
  8012e3:	6a 05                	push   $0x5
  8012e5:	e8 7d ff ff ff       	call   801267 <syscall>
  8012ea:	83 c4 18             	add    $0x18,%esp
}
  8012ed:	c9                   	leave  
  8012ee:	c3                   	ret    

008012ef <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012ef:	55                   	push   %ebp
  8012f0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012f2:	6a 00                	push   $0x0
  8012f4:	6a 00                	push   $0x0
  8012f6:	6a 00                	push   $0x0
  8012f8:	6a 00                	push   $0x0
  8012fa:	6a 00                	push   $0x0
  8012fc:	6a 02                	push   $0x2
  8012fe:	e8 64 ff ff ff       	call   801267 <syscall>
  801303:	83 c4 18             	add    $0x18,%esp
}
  801306:	c9                   	leave  
  801307:	c3                   	ret    

00801308 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801308:	55                   	push   %ebp
  801309:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80130b:	6a 00                	push   $0x0
  80130d:	6a 00                	push   $0x0
  80130f:	6a 00                	push   $0x0
  801311:	6a 00                	push   $0x0
  801313:	6a 00                	push   $0x0
  801315:	6a 03                	push   $0x3
  801317:	e8 4b ff ff ff       	call   801267 <syscall>
  80131c:	83 c4 18             	add    $0x18,%esp
}
  80131f:	c9                   	leave  
  801320:	c3                   	ret    

00801321 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801321:	55                   	push   %ebp
  801322:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801324:	6a 00                	push   $0x0
  801326:	6a 00                	push   $0x0
  801328:	6a 00                	push   $0x0
  80132a:	6a 00                	push   $0x0
  80132c:	6a 00                	push   $0x0
  80132e:	6a 04                	push   $0x4
  801330:	e8 32 ff ff ff       	call   801267 <syscall>
  801335:	83 c4 18             	add    $0x18,%esp
}
  801338:	c9                   	leave  
  801339:	c3                   	ret    

0080133a <sys_env_exit>:


void sys_env_exit(void)
{
  80133a:	55                   	push   %ebp
  80133b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80133d:	6a 00                	push   $0x0
  80133f:	6a 00                	push   $0x0
  801341:	6a 00                	push   $0x0
  801343:	6a 00                	push   $0x0
  801345:	6a 00                	push   $0x0
  801347:	6a 06                	push   $0x6
  801349:	e8 19 ff ff ff       	call   801267 <syscall>
  80134e:	83 c4 18             	add    $0x18,%esp
}
  801351:	90                   	nop
  801352:	c9                   	leave  
  801353:	c3                   	ret    

00801354 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801354:	55                   	push   %ebp
  801355:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801357:	8b 55 0c             	mov    0xc(%ebp),%edx
  80135a:	8b 45 08             	mov    0x8(%ebp),%eax
  80135d:	6a 00                	push   $0x0
  80135f:	6a 00                	push   $0x0
  801361:	6a 00                	push   $0x0
  801363:	52                   	push   %edx
  801364:	50                   	push   %eax
  801365:	6a 07                	push   $0x7
  801367:	e8 fb fe ff ff       	call   801267 <syscall>
  80136c:	83 c4 18             	add    $0x18,%esp
}
  80136f:	c9                   	leave  
  801370:	c3                   	ret    

00801371 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801371:	55                   	push   %ebp
  801372:	89 e5                	mov    %esp,%ebp
  801374:	56                   	push   %esi
  801375:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801376:	8b 75 18             	mov    0x18(%ebp),%esi
  801379:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80137c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80137f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801382:	8b 45 08             	mov    0x8(%ebp),%eax
  801385:	56                   	push   %esi
  801386:	53                   	push   %ebx
  801387:	51                   	push   %ecx
  801388:	52                   	push   %edx
  801389:	50                   	push   %eax
  80138a:	6a 08                	push   $0x8
  80138c:	e8 d6 fe ff ff       	call   801267 <syscall>
  801391:	83 c4 18             	add    $0x18,%esp
}
  801394:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801397:	5b                   	pop    %ebx
  801398:	5e                   	pop    %esi
  801399:	5d                   	pop    %ebp
  80139a:	c3                   	ret    

0080139b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80139b:	55                   	push   %ebp
  80139c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80139e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a4:	6a 00                	push   $0x0
  8013a6:	6a 00                	push   $0x0
  8013a8:	6a 00                	push   $0x0
  8013aa:	52                   	push   %edx
  8013ab:	50                   	push   %eax
  8013ac:	6a 09                	push   $0x9
  8013ae:	e8 b4 fe ff ff       	call   801267 <syscall>
  8013b3:	83 c4 18             	add    $0x18,%esp
}
  8013b6:	c9                   	leave  
  8013b7:	c3                   	ret    

008013b8 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013b8:	55                   	push   %ebp
  8013b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013bb:	6a 00                	push   $0x0
  8013bd:	6a 00                	push   $0x0
  8013bf:	6a 00                	push   $0x0
  8013c1:	ff 75 0c             	pushl  0xc(%ebp)
  8013c4:	ff 75 08             	pushl  0x8(%ebp)
  8013c7:	6a 0a                	push   $0xa
  8013c9:	e8 99 fe ff ff       	call   801267 <syscall>
  8013ce:	83 c4 18             	add    $0x18,%esp
}
  8013d1:	c9                   	leave  
  8013d2:	c3                   	ret    

008013d3 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013d3:	55                   	push   %ebp
  8013d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	6a 00                	push   $0x0
  8013dc:	6a 00                	push   $0x0
  8013de:	6a 00                	push   $0x0
  8013e0:	6a 0b                	push   $0xb
  8013e2:	e8 80 fe ff ff       	call   801267 <syscall>
  8013e7:	83 c4 18             	add    $0x18,%esp
}
  8013ea:	c9                   	leave  
  8013eb:	c3                   	ret    

008013ec <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013ec:	55                   	push   %ebp
  8013ed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013ef:	6a 00                	push   $0x0
  8013f1:	6a 00                	push   $0x0
  8013f3:	6a 00                	push   $0x0
  8013f5:	6a 00                	push   $0x0
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 0c                	push   $0xc
  8013fb:	e8 67 fe ff ff       	call   801267 <syscall>
  801400:	83 c4 18             	add    $0x18,%esp
}
  801403:	c9                   	leave  
  801404:	c3                   	ret    

00801405 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801405:	55                   	push   %ebp
  801406:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801408:	6a 00                	push   $0x0
  80140a:	6a 00                	push   $0x0
  80140c:	6a 00                	push   $0x0
  80140e:	6a 00                	push   $0x0
  801410:	6a 00                	push   $0x0
  801412:	6a 0d                	push   $0xd
  801414:	e8 4e fe ff ff       	call   801267 <syscall>
  801419:	83 c4 18             	add    $0x18,%esp
}
  80141c:	c9                   	leave  
  80141d:	c3                   	ret    

0080141e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80141e:	55                   	push   %ebp
  80141f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801421:	6a 00                	push   $0x0
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	ff 75 0c             	pushl  0xc(%ebp)
  80142a:	ff 75 08             	pushl  0x8(%ebp)
  80142d:	6a 11                	push   $0x11
  80142f:	e8 33 fe ff ff       	call   801267 <syscall>
  801434:	83 c4 18             	add    $0x18,%esp
	return;
  801437:	90                   	nop
}
  801438:	c9                   	leave  
  801439:	c3                   	ret    

0080143a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80143a:	55                   	push   %ebp
  80143b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80143d:	6a 00                	push   $0x0
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	ff 75 0c             	pushl  0xc(%ebp)
  801446:	ff 75 08             	pushl  0x8(%ebp)
  801449:	6a 12                	push   $0x12
  80144b:	e8 17 fe ff ff       	call   801267 <syscall>
  801450:	83 c4 18             	add    $0x18,%esp
	return ;
  801453:	90                   	nop
}
  801454:	c9                   	leave  
  801455:	c3                   	ret    

00801456 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801456:	55                   	push   %ebp
  801457:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801459:	6a 00                	push   $0x0
  80145b:	6a 00                	push   $0x0
  80145d:	6a 00                	push   $0x0
  80145f:	6a 00                	push   $0x0
  801461:	6a 00                	push   $0x0
  801463:	6a 0e                	push   $0xe
  801465:	e8 fd fd ff ff       	call   801267 <syscall>
  80146a:	83 c4 18             	add    $0x18,%esp
}
  80146d:	c9                   	leave  
  80146e:	c3                   	ret    

0080146f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80146f:	55                   	push   %ebp
  801470:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801472:	6a 00                	push   $0x0
  801474:	6a 00                	push   $0x0
  801476:	6a 00                	push   $0x0
  801478:	6a 00                	push   $0x0
  80147a:	ff 75 08             	pushl  0x8(%ebp)
  80147d:	6a 0f                	push   $0xf
  80147f:	e8 e3 fd ff ff       	call   801267 <syscall>
  801484:	83 c4 18             	add    $0x18,%esp
}
  801487:	c9                   	leave  
  801488:	c3                   	ret    

00801489 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801489:	55                   	push   %ebp
  80148a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80148c:	6a 00                	push   $0x0
  80148e:	6a 00                	push   $0x0
  801490:	6a 00                	push   $0x0
  801492:	6a 00                	push   $0x0
  801494:	6a 00                	push   $0x0
  801496:	6a 10                	push   $0x10
  801498:	e8 ca fd ff ff       	call   801267 <syscall>
  80149d:	83 c4 18             	add    $0x18,%esp
}
  8014a0:	90                   	nop
  8014a1:	c9                   	leave  
  8014a2:	c3                   	ret    

008014a3 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014a3:	55                   	push   %ebp
  8014a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 00                	push   $0x0
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 14                	push   $0x14
  8014b2:	e8 b0 fd ff ff       	call   801267 <syscall>
  8014b7:	83 c4 18             	add    $0x18,%esp
}
  8014ba:	90                   	nop
  8014bb:	c9                   	leave  
  8014bc:	c3                   	ret    

008014bd <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014bd:	55                   	push   %ebp
  8014be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 00                	push   $0x0
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 15                	push   $0x15
  8014cc:	e8 96 fd ff ff       	call   801267 <syscall>
  8014d1:	83 c4 18             	add    $0x18,%esp
}
  8014d4:	90                   	nop
  8014d5:	c9                   	leave  
  8014d6:	c3                   	ret    

008014d7 <sys_cputc>:


void
sys_cputc(const char c)
{
  8014d7:	55                   	push   %ebp
  8014d8:	89 e5                	mov    %esp,%ebp
  8014da:	83 ec 04             	sub    $0x4,%esp
  8014dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014e3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 00                	push   $0x0
  8014ef:	50                   	push   %eax
  8014f0:	6a 16                	push   $0x16
  8014f2:	e8 70 fd ff ff       	call   801267 <syscall>
  8014f7:	83 c4 18             	add    $0x18,%esp
}
  8014fa:	90                   	nop
  8014fb:	c9                   	leave  
  8014fc:	c3                   	ret    

008014fd <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014fd:	55                   	push   %ebp
  8014fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801500:	6a 00                	push   $0x0
  801502:	6a 00                	push   $0x0
  801504:	6a 00                	push   $0x0
  801506:	6a 00                	push   $0x0
  801508:	6a 00                	push   $0x0
  80150a:	6a 17                	push   $0x17
  80150c:	e8 56 fd ff ff       	call   801267 <syscall>
  801511:	83 c4 18             	add    $0x18,%esp
}
  801514:	90                   	nop
  801515:	c9                   	leave  
  801516:	c3                   	ret    

00801517 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801517:	55                   	push   %ebp
  801518:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80151a:	8b 45 08             	mov    0x8(%ebp),%eax
  80151d:	6a 00                	push   $0x0
  80151f:	6a 00                	push   $0x0
  801521:	6a 00                	push   $0x0
  801523:	ff 75 0c             	pushl  0xc(%ebp)
  801526:	50                   	push   %eax
  801527:	6a 18                	push   $0x18
  801529:	e8 39 fd ff ff       	call   801267 <syscall>
  80152e:	83 c4 18             	add    $0x18,%esp
}
  801531:	c9                   	leave  
  801532:	c3                   	ret    

00801533 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801533:	55                   	push   %ebp
  801534:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801536:	8b 55 0c             	mov    0xc(%ebp),%edx
  801539:	8b 45 08             	mov    0x8(%ebp),%eax
  80153c:	6a 00                	push   $0x0
  80153e:	6a 00                	push   $0x0
  801540:	6a 00                	push   $0x0
  801542:	52                   	push   %edx
  801543:	50                   	push   %eax
  801544:	6a 1b                	push   $0x1b
  801546:	e8 1c fd ff ff       	call   801267 <syscall>
  80154b:	83 c4 18             	add    $0x18,%esp
}
  80154e:	c9                   	leave  
  80154f:	c3                   	ret    

00801550 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801550:	55                   	push   %ebp
  801551:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801553:	8b 55 0c             	mov    0xc(%ebp),%edx
  801556:	8b 45 08             	mov    0x8(%ebp),%eax
  801559:	6a 00                	push   $0x0
  80155b:	6a 00                	push   $0x0
  80155d:	6a 00                	push   $0x0
  80155f:	52                   	push   %edx
  801560:	50                   	push   %eax
  801561:	6a 19                	push   $0x19
  801563:	e8 ff fc ff ff       	call   801267 <syscall>
  801568:	83 c4 18             	add    $0x18,%esp
}
  80156b:	90                   	nop
  80156c:	c9                   	leave  
  80156d:	c3                   	ret    

0080156e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80156e:	55                   	push   %ebp
  80156f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801571:	8b 55 0c             	mov    0xc(%ebp),%edx
  801574:	8b 45 08             	mov    0x8(%ebp),%eax
  801577:	6a 00                	push   $0x0
  801579:	6a 00                	push   $0x0
  80157b:	6a 00                	push   $0x0
  80157d:	52                   	push   %edx
  80157e:	50                   	push   %eax
  80157f:	6a 1a                	push   $0x1a
  801581:	e8 e1 fc ff ff       	call   801267 <syscall>
  801586:	83 c4 18             	add    $0x18,%esp
}
  801589:	90                   	nop
  80158a:	c9                   	leave  
  80158b:	c3                   	ret    

0080158c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80158c:	55                   	push   %ebp
  80158d:	89 e5                	mov    %esp,%ebp
  80158f:	83 ec 04             	sub    $0x4,%esp
  801592:	8b 45 10             	mov    0x10(%ebp),%eax
  801595:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801598:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80159b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80159f:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a2:	6a 00                	push   $0x0
  8015a4:	51                   	push   %ecx
  8015a5:	52                   	push   %edx
  8015a6:	ff 75 0c             	pushl  0xc(%ebp)
  8015a9:	50                   	push   %eax
  8015aa:	6a 1c                	push   $0x1c
  8015ac:	e8 b6 fc ff ff       	call   801267 <syscall>
  8015b1:	83 c4 18             	add    $0x18,%esp
}
  8015b4:	c9                   	leave  
  8015b5:	c3                   	ret    

008015b6 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015b6:	55                   	push   %ebp
  8015b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	52                   	push   %edx
  8015c6:	50                   	push   %eax
  8015c7:	6a 1d                	push   $0x1d
  8015c9:	e8 99 fc ff ff       	call   801267 <syscall>
  8015ce:	83 c4 18             	add    $0x18,%esp
}
  8015d1:	c9                   	leave  
  8015d2:	c3                   	ret    

008015d3 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015d3:	55                   	push   %ebp
  8015d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015d6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	51                   	push   %ecx
  8015e4:	52                   	push   %edx
  8015e5:	50                   	push   %eax
  8015e6:	6a 1e                	push   $0x1e
  8015e8:	e8 7a fc ff ff       	call   801267 <syscall>
  8015ed:	83 c4 18             	add    $0x18,%esp
}
  8015f0:	c9                   	leave  
  8015f1:	c3                   	ret    

008015f2 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015f2:	55                   	push   %ebp
  8015f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	52                   	push   %edx
  801602:	50                   	push   %eax
  801603:	6a 1f                	push   $0x1f
  801605:	e8 5d fc ff ff       	call   801267 <syscall>
  80160a:	83 c4 18             	add    $0x18,%esp
}
  80160d:	c9                   	leave  
  80160e:	c3                   	ret    

0080160f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80160f:	55                   	push   %ebp
  801610:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	6a 00                	push   $0x0
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 20                	push   $0x20
  80161e:	e8 44 fc ff ff       	call   801267 <syscall>
  801623:	83 c4 18             	add    $0x18,%esp
}
  801626:	c9                   	leave  
  801627:	c3                   	ret    

00801628 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801628:	55                   	push   %ebp
  801629:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80162b:	8b 45 08             	mov    0x8(%ebp),%eax
  80162e:	6a 00                	push   $0x0
  801630:	ff 75 14             	pushl  0x14(%ebp)
  801633:	ff 75 10             	pushl  0x10(%ebp)
  801636:	ff 75 0c             	pushl  0xc(%ebp)
  801639:	50                   	push   %eax
  80163a:	6a 21                	push   $0x21
  80163c:	e8 26 fc ff ff       	call   801267 <syscall>
  801641:	83 c4 18             	add    $0x18,%esp
}
  801644:	c9                   	leave  
  801645:	c3                   	ret    

00801646 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801646:	55                   	push   %ebp
  801647:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801649:	8b 45 08             	mov    0x8(%ebp),%eax
  80164c:	6a 00                	push   $0x0
  80164e:	6a 00                	push   $0x0
  801650:	6a 00                	push   $0x0
  801652:	6a 00                	push   $0x0
  801654:	50                   	push   %eax
  801655:	6a 22                	push   $0x22
  801657:	e8 0b fc ff ff       	call   801267 <syscall>
  80165c:	83 c4 18             	add    $0x18,%esp
}
  80165f:	90                   	nop
  801660:	c9                   	leave  
  801661:	c3                   	ret    

00801662 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801662:	55                   	push   %ebp
  801663:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801665:	8b 45 08             	mov    0x8(%ebp),%eax
  801668:	6a 00                	push   $0x0
  80166a:	6a 00                	push   $0x0
  80166c:	6a 00                	push   $0x0
  80166e:	6a 00                	push   $0x0
  801670:	50                   	push   %eax
  801671:	6a 23                	push   $0x23
  801673:	e8 ef fb ff ff       	call   801267 <syscall>
  801678:	83 c4 18             	add    $0x18,%esp
}
  80167b:	90                   	nop
  80167c:	c9                   	leave  
  80167d:	c3                   	ret    

0080167e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80167e:	55                   	push   %ebp
  80167f:	89 e5                	mov    %esp,%ebp
  801681:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801684:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801687:	8d 50 04             	lea    0x4(%eax),%edx
  80168a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	52                   	push   %edx
  801694:	50                   	push   %eax
  801695:	6a 24                	push   $0x24
  801697:	e8 cb fb ff ff       	call   801267 <syscall>
  80169c:	83 c4 18             	add    $0x18,%esp
	return result;
  80169f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016a8:	89 01                	mov    %eax,(%ecx)
  8016aa:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b0:	c9                   	leave  
  8016b1:	c2 04 00             	ret    $0x4

008016b4 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016b4:	55                   	push   %ebp
  8016b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 00                	push   $0x0
  8016bb:	ff 75 10             	pushl  0x10(%ebp)
  8016be:	ff 75 0c             	pushl  0xc(%ebp)
  8016c1:	ff 75 08             	pushl  0x8(%ebp)
  8016c4:	6a 13                	push   $0x13
  8016c6:	e8 9c fb ff ff       	call   801267 <syscall>
  8016cb:	83 c4 18             	add    $0x18,%esp
	return ;
  8016ce:	90                   	nop
}
  8016cf:	c9                   	leave  
  8016d0:	c3                   	ret    

008016d1 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016d1:	55                   	push   %ebp
  8016d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 00                	push   $0x0
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 25                	push   $0x25
  8016e0:	e8 82 fb ff ff       	call   801267 <syscall>
  8016e5:	83 c4 18             	add    $0x18,%esp
}
  8016e8:	c9                   	leave  
  8016e9:	c3                   	ret    

008016ea <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016ea:	55                   	push   %ebp
  8016eb:	89 e5                	mov    %esp,%ebp
  8016ed:	83 ec 04             	sub    $0x4,%esp
  8016f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016f6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	50                   	push   %eax
  801703:	6a 26                	push   $0x26
  801705:	e8 5d fb ff ff       	call   801267 <syscall>
  80170a:	83 c4 18             	add    $0x18,%esp
	return ;
  80170d:	90                   	nop
}
  80170e:	c9                   	leave  
  80170f:	c3                   	ret    

00801710 <rsttst>:
void rsttst()
{
  801710:	55                   	push   %ebp
  801711:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801713:	6a 00                	push   $0x0
  801715:	6a 00                	push   $0x0
  801717:	6a 00                	push   $0x0
  801719:	6a 00                	push   $0x0
  80171b:	6a 00                	push   $0x0
  80171d:	6a 28                	push   $0x28
  80171f:	e8 43 fb ff ff       	call   801267 <syscall>
  801724:	83 c4 18             	add    $0x18,%esp
	return ;
  801727:	90                   	nop
}
  801728:	c9                   	leave  
  801729:	c3                   	ret    

0080172a <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80172a:	55                   	push   %ebp
  80172b:	89 e5                	mov    %esp,%ebp
  80172d:	83 ec 04             	sub    $0x4,%esp
  801730:	8b 45 14             	mov    0x14(%ebp),%eax
  801733:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801736:	8b 55 18             	mov    0x18(%ebp),%edx
  801739:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80173d:	52                   	push   %edx
  80173e:	50                   	push   %eax
  80173f:	ff 75 10             	pushl  0x10(%ebp)
  801742:	ff 75 0c             	pushl  0xc(%ebp)
  801745:	ff 75 08             	pushl  0x8(%ebp)
  801748:	6a 27                	push   $0x27
  80174a:	e8 18 fb ff ff       	call   801267 <syscall>
  80174f:	83 c4 18             	add    $0x18,%esp
	return ;
  801752:	90                   	nop
}
  801753:	c9                   	leave  
  801754:	c3                   	ret    

00801755 <chktst>:
void chktst(uint32 n)
{
  801755:	55                   	push   %ebp
  801756:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	ff 75 08             	pushl  0x8(%ebp)
  801763:	6a 29                	push   $0x29
  801765:	e8 fd fa ff ff       	call   801267 <syscall>
  80176a:	83 c4 18             	add    $0x18,%esp
	return ;
  80176d:	90                   	nop
}
  80176e:	c9                   	leave  
  80176f:	c3                   	ret    

00801770 <inctst>:

void inctst()
{
  801770:	55                   	push   %ebp
  801771:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	6a 2a                	push   $0x2a
  80177f:	e8 e3 fa ff ff       	call   801267 <syscall>
  801784:	83 c4 18             	add    $0x18,%esp
	return ;
  801787:	90                   	nop
}
  801788:	c9                   	leave  
  801789:	c3                   	ret    

0080178a <gettst>:
uint32 gettst()
{
  80178a:	55                   	push   %ebp
  80178b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 2b                	push   $0x2b
  801799:	e8 c9 fa ff ff       	call   801267 <syscall>
  80179e:	83 c4 18             	add    $0x18,%esp
}
  8017a1:	c9                   	leave  
  8017a2:	c3                   	ret    

008017a3 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017a3:	55                   	push   %ebp
  8017a4:	89 e5                	mov    %esp,%ebp
  8017a6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 2c                	push   $0x2c
  8017b5:	e8 ad fa ff ff       	call   801267 <syscall>
  8017ba:	83 c4 18             	add    $0x18,%esp
  8017bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017c0:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017c4:	75 07                	jne    8017cd <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8017cb:	eb 05                	jmp    8017d2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017d2:	c9                   	leave  
  8017d3:	c3                   	ret    

008017d4 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017d4:	55                   	push   %ebp
  8017d5:	89 e5                	mov    %esp,%ebp
  8017d7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 2c                	push   $0x2c
  8017e6:	e8 7c fa ff ff       	call   801267 <syscall>
  8017eb:	83 c4 18             	add    $0x18,%esp
  8017ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017f1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017f5:	75 07                	jne    8017fe <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017f7:	b8 01 00 00 00       	mov    $0x1,%eax
  8017fc:	eb 05                	jmp    801803 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801803:	c9                   	leave  
  801804:	c3                   	ret    

00801805 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801805:	55                   	push   %ebp
  801806:	89 e5                	mov    %esp,%ebp
  801808:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	6a 2c                	push   $0x2c
  801817:	e8 4b fa ff ff       	call   801267 <syscall>
  80181c:	83 c4 18             	add    $0x18,%esp
  80181f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801822:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801826:	75 07                	jne    80182f <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801828:	b8 01 00 00 00       	mov    $0x1,%eax
  80182d:	eb 05                	jmp    801834 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80182f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801834:	c9                   	leave  
  801835:	c3                   	ret    

00801836 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801836:	55                   	push   %ebp
  801837:	89 e5                	mov    %esp,%ebp
  801839:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 00                	push   $0x0
  801842:	6a 00                	push   $0x0
  801844:	6a 00                	push   $0x0
  801846:	6a 2c                	push   $0x2c
  801848:	e8 1a fa ff ff       	call   801267 <syscall>
  80184d:	83 c4 18             	add    $0x18,%esp
  801850:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801853:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801857:	75 07                	jne    801860 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801859:	b8 01 00 00 00       	mov    $0x1,%eax
  80185e:	eb 05                	jmp    801865 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801860:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801865:	c9                   	leave  
  801866:	c3                   	ret    

00801867 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801867:	55                   	push   %ebp
  801868:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	ff 75 08             	pushl  0x8(%ebp)
  801875:	6a 2d                	push   $0x2d
  801877:	e8 eb f9 ff ff       	call   801267 <syscall>
  80187c:	83 c4 18             	add    $0x18,%esp
	return ;
  80187f:	90                   	nop
}
  801880:	c9                   	leave  
  801881:	c3                   	ret    

00801882 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801882:	55                   	push   %ebp
  801883:	89 e5                	mov    %esp,%ebp
  801885:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801886:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801889:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80188c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80188f:	8b 45 08             	mov    0x8(%ebp),%eax
  801892:	6a 00                	push   $0x0
  801894:	53                   	push   %ebx
  801895:	51                   	push   %ecx
  801896:	52                   	push   %edx
  801897:	50                   	push   %eax
  801898:	6a 2e                	push   $0x2e
  80189a:	e8 c8 f9 ff ff       	call   801267 <syscall>
  80189f:	83 c4 18             	add    $0x18,%esp
}
  8018a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8018a5:	c9                   	leave  
  8018a6:	c3                   	ret    

008018a7 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8018a7:	55                   	push   %ebp
  8018a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8018aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b0:	6a 00                	push   $0x0
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	52                   	push   %edx
  8018b7:	50                   	push   %eax
  8018b8:	6a 2f                	push   $0x2f
  8018ba:	e8 a8 f9 ff ff       	call   801267 <syscall>
  8018bf:	83 c4 18             	add    $0x18,%esp
}
  8018c2:	c9                   	leave  
  8018c3:	c3                   	ret    

008018c4 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8018c4:	55                   	push   %ebp
  8018c5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8018c7:	6a 00                	push   $0x0
  8018c9:	6a 00                	push   $0x0
  8018cb:	6a 00                	push   $0x0
  8018cd:	ff 75 0c             	pushl  0xc(%ebp)
  8018d0:	ff 75 08             	pushl  0x8(%ebp)
  8018d3:	6a 30                	push   $0x30
  8018d5:	e8 8d f9 ff ff       	call   801267 <syscall>
  8018da:	83 c4 18             	add    $0x18,%esp
	return ;
  8018dd:	90                   	nop
}
  8018de:	c9                   	leave  
  8018df:	c3                   	ret    

008018e0 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8018e0:	55                   	push   %ebp
  8018e1:	89 e5                	mov    %esp,%ebp
  8018e3:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8018e6:	8b 55 08             	mov    0x8(%ebp),%edx
  8018e9:	89 d0                	mov    %edx,%eax
  8018eb:	c1 e0 02             	shl    $0x2,%eax
  8018ee:	01 d0                	add    %edx,%eax
  8018f0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018f7:	01 d0                	add    %edx,%eax
  8018f9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801900:	01 d0                	add    %edx,%eax
  801902:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801909:	01 d0                	add    %edx,%eax
  80190b:	c1 e0 04             	shl    $0x4,%eax
  80190e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801911:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801918:	8d 45 e8             	lea    -0x18(%ebp),%eax
  80191b:	83 ec 0c             	sub    $0xc,%esp
  80191e:	50                   	push   %eax
  80191f:	e8 5a fd ff ff       	call   80167e <sys_get_virtual_time>
  801924:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801927:	eb 41                	jmp    80196a <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801929:	8d 45 e0             	lea    -0x20(%ebp),%eax
  80192c:	83 ec 0c             	sub    $0xc,%esp
  80192f:	50                   	push   %eax
  801930:	e8 49 fd ff ff       	call   80167e <sys_get_virtual_time>
  801935:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801938:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80193b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80193e:	29 c2                	sub    %eax,%edx
  801940:	89 d0                	mov    %edx,%eax
  801942:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801945:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801948:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80194b:	89 d1                	mov    %edx,%ecx
  80194d:	29 c1                	sub    %eax,%ecx
  80194f:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801952:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801955:	39 c2                	cmp    %eax,%edx
  801957:	0f 97 c0             	seta   %al
  80195a:	0f b6 c0             	movzbl %al,%eax
  80195d:	29 c1                	sub    %eax,%ecx
  80195f:	89 c8                	mov    %ecx,%eax
  801961:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801964:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801967:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  80196a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80196d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801970:	72 b7                	jb     801929 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801972:	90                   	nop
  801973:	c9                   	leave  
  801974:	c3                   	ret    

00801975 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801975:	55                   	push   %ebp
  801976:	89 e5                	mov    %esp,%ebp
  801978:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80197b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801982:	eb 03                	jmp    801987 <busy_wait+0x12>
  801984:	ff 45 fc             	incl   -0x4(%ebp)
  801987:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80198a:	3b 45 08             	cmp    0x8(%ebp),%eax
  80198d:	72 f5                	jb     801984 <busy_wait+0xf>
	return i;
  80198f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801992:	c9                   	leave  
  801993:	c3                   	ret    

00801994 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  801994:	55                   	push   %ebp
  801995:	89 e5                	mov    %esp,%ebp
  801997:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80199a:	8b 45 08             	mov    0x8(%ebp),%eax
  80199d:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8019a0:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8019a4:	83 ec 0c             	sub    $0xc,%esp
  8019a7:	50                   	push   %eax
  8019a8:	e8 2a fb ff ff       	call   8014d7 <sys_cputc>
  8019ad:	83 c4 10             	add    $0x10,%esp
}
  8019b0:	90                   	nop
  8019b1:	c9                   	leave  
  8019b2:	c3                   	ret    

008019b3 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8019b3:	55                   	push   %ebp
  8019b4:	89 e5                	mov    %esp,%ebp
  8019b6:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8019b9:	e8 e5 fa ff ff       	call   8014a3 <sys_disable_interrupt>
	char c = ch;
  8019be:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c1:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8019c4:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8019c8:	83 ec 0c             	sub    $0xc,%esp
  8019cb:	50                   	push   %eax
  8019cc:	e8 06 fb ff ff       	call   8014d7 <sys_cputc>
  8019d1:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8019d4:	e8 e4 fa ff ff       	call   8014bd <sys_enable_interrupt>
}
  8019d9:	90                   	nop
  8019da:	c9                   	leave  
  8019db:	c3                   	ret    

008019dc <getchar>:

int
getchar(void)
{
  8019dc:	55                   	push   %ebp
  8019dd:	89 e5                	mov    %esp,%ebp
  8019df:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8019e2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8019e9:	eb 08                	jmp    8019f3 <getchar+0x17>
	{
		c = sys_cgetc();
  8019eb:	e8 cb f8 ff ff       	call   8012bb <sys_cgetc>
  8019f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8019f3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8019f7:	74 f2                	je     8019eb <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8019f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8019fc:	c9                   	leave  
  8019fd:	c3                   	ret    

008019fe <atomic_getchar>:

int
atomic_getchar(void)
{
  8019fe:	55                   	push   %ebp
  8019ff:	89 e5                	mov    %esp,%ebp
  801a01:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801a04:	e8 9a fa ff ff       	call   8014a3 <sys_disable_interrupt>
	int c=0;
  801a09:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801a10:	eb 08                	jmp    801a1a <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  801a12:	e8 a4 f8 ff ff       	call   8012bb <sys_cgetc>
  801a17:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  801a1a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801a1e:	74 f2                	je     801a12 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  801a20:	e8 98 fa ff ff       	call   8014bd <sys_enable_interrupt>
	return c;
  801a25:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801a28:	c9                   	leave  
  801a29:	c3                   	ret    

00801a2a <iscons>:

int iscons(int fdnum)
{
  801a2a:	55                   	push   %ebp
  801a2b:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  801a2d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a32:	5d                   	pop    %ebp
  801a33:	c3                   	ret    

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
