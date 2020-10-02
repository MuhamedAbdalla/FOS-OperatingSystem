
obj/user/dummy_process:     file format elf32-i386


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
  800031:	e8 8d 00 00 00       	call   8000c3 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void high_complexity_function();

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 08             	sub    $0x8,%esp
	high_complexity_function() ;
  80003e:	e8 03 00 00 00       	call   800046 <high_complexity_function>
	return;
  800043:	90                   	nop
}
  800044:	c9                   	leave  
  800045:	c3                   	ret    

00800046 <high_complexity_function>:

void high_complexity_function()
{
  800046:	55                   	push   %ebp
  800047:	89 e5                	mov    %esp,%ebp
  800049:	83 ec 38             	sub    $0x38,%esp
	uint32 end1 = RAND(0, 5000);
  80004c:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  80004f:	83 ec 0c             	sub    $0xc,%esp
  800052:	50                   	push   %eax
  800053:	e8 05 14 00 00       	call   80145d <sys_get_virtual_time>
  800058:	83 c4 0c             	add    $0xc,%esp
  80005b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80005e:	b9 88 13 00 00       	mov    $0x1388,%ecx
  800063:	ba 00 00 00 00       	mov    $0x0,%edx
  800068:	f7 f1                	div    %ecx
  80006a:	89 55 e8             	mov    %edx,-0x18(%ebp)
	uint32 end2 = RAND(0, 5000);
  80006d:	8d 45 dc             	lea    -0x24(%ebp),%eax
  800070:	83 ec 0c             	sub    $0xc,%esp
  800073:	50                   	push   %eax
  800074:	e8 e4 13 00 00       	call   80145d <sys_get_virtual_time>
  800079:	83 c4 0c             	add    $0xc,%esp
  80007c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80007f:	b9 88 13 00 00       	mov    $0x1388,%ecx
  800084:	ba 00 00 00 00       	mov    $0x0,%edx
  800089:	f7 f1                	div    %ecx
  80008b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
	int x = 10;
  80008e:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
	for(int i = 0; i <= end1; i++)
  800095:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80009c:	eb 1a                	jmp    8000b8 <high_complexity_function+0x72>
	{
		for(int i = 0; i <= end2; i++)
  80009e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8000a5:	eb 06                	jmp    8000ad <high_complexity_function+0x67>
		{
			{
				 x++;
  8000a7:	ff 45 f4             	incl   -0xc(%ebp)
	uint32 end1 = RAND(0, 5000);
	uint32 end2 = RAND(0, 5000);
	int x = 10;
	for(int i = 0; i <= end1; i++)
	{
		for(int i = 0; i <= end2; i++)
  8000aa:	ff 45 ec             	incl   -0x14(%ebp)
  8000ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000b0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8000b3:	76 f2                	jbe    8000a7 <high_complexity_function+0x61>
void high_complexity_function()
{
	uint32 end1 = RAND(0, 5000);
	uint32 end2 = RAND(0, 5000);
	int x = 10;
	for(int i = 0; i <= end1; i++)
  8000b5:	ff 45 f0             	incl   -0x10(%ebp)
  8000b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000bb:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8000be:	76 de                	jbe    80009e <high_complexity_function+0x58>
			{
				 x++;
			}
		}
	}
}
  8000c0:	90                   	nop
  8000c1:	c9                   	leave  
  8000c2:	c3                   	ret    

008000c3 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000c3:	55                   	push   %ebp
  8000c4:	89 e5                	mov    %esp,%ebp
  8000c6:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000c9:	e8 19 10 00 00       	call   8010e7 <sys_getenvindex>
  8000ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000d4:	89 d0                	mov    %edx,%eax
  8000d6:	c1 e0 03             	shl    $0x3,%eax
  8000d9:	01 d0                	add    %edx,%eax
  8000db:	c1 e0 02             	shl    $0x2,%eax
  8000de:	01 d0                	add    %edx,%eax
  8000e0:	c1 e0 06             	shl    $0x6,%eax
  8000e3:	29 d0                	sub    %edx,%eax
  8000e5:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8000ec:	01 c8                	add    %ecx,%eax
  8000ee:	01 d0                	add    %edx,%eax
  8000f0:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000f5:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000fa:	a1 20 20 80 00       	mov    0x802020,%eax
  8000ff:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  800105:	84 c0                	test   %al,%al
  800107:	74 0f                	je     800118 <libmain+0x55>
		binaryname = myEnv->prog_name;
  800109:	a1 20 20 80 00       	mov    0x802020,%eax
  80010e:	05 b0 52 00 00       	add    $0x52b0,%eax
  800113:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800118:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80011c:	7e 0a                	jle    800128 <libmain+0x65>
		binaryname = argv[0];
  80011e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800128:	83 ec 08             	sub    $0x8,%esp
  80012b:	ff 75 0c             	pushl  0xc(%ebp)
  80012e:	ff 75 08             	pushl  0x8(%ebp)
  800131:	e8 02 ff ff ff       	call   800038 <_main>
  800136:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800139:	e8 44 11 00 00       	call   801282 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80013e:	83 ec 0c             	sub    $0xc,%esp
  800141:	68 58 19 80 00       	push   $0x801958
  800146:	e8 71 01 00 00       	call   8002bc <cprintf>
  80014b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80014e:	a1 20 20 80 00       	mov    0x802020,%eax
  800153:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  800159:	a1 20 20 80 00       	mov    0x802020,%eax
  80015e:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  800164:	83 ec 04             	sub    $0x4,%esp
  800167:	52                   	push   %edx
  800168:	50                   	push   %eax
  800169:	68 80 19 80 00       	push   $0x801980
  80016e:	e8 49 01 00 00       	call   8002bc <cprintf>
  800173:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800176:	a1 20 20 80 00       	mov    0x802020,%eax
  80017b:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  800181:	a1 20 20 80 00       	mov    0x802020,%eax
  800186:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  80018c:	a1 20 20 80 00       	mov    0x802020,%eax
  800191:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  800197:	51                   	push   %ecx
  800198:	52                   	push   %edx
  800199:	50                   	push   %eax
  80019a:	68 a8 19 80 00       	push   $0x8019a8
  80019f:	e8 18 01 00 00       	call   8002bc <cprintf>
  8001a4:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8001a7:	83 ec 0c             	sub    $0xc,%esp
  8001aa:	68 58 19 80 00       	push   $0x801958
  8001af:	e8 08 01 00 00       	call   8002bc <cprintf>
  8001b4:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001b7:	e8 e0 10 00 00       	call   80129c <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001bc:	e8 19 00 00 00       	call   8001da <exit>
}
  8001c1:	90                   	nop
  8001c2:	c9                   	leave  
  8001c3:	c3                   	ret    

008001c4 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001c4:	55                   	push   %ebp
  8001c5:	89 e5                	mov    %esp,%ebp
  8001c7:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001ca:	83 ec 0c             	sub    $0xc,%esp
  8001cd:	6a 00                	push   $0x0
  8001cf:	e8 df 0e 00 00       	call   8010b3 <sys_env_destroy>
  8001d4:	83 c4 10             	add    $0x10,%esp
}
  8001d7:	90                   	nop
  8001d8:	c9                   	leave  
  8001d9:	c3                   	ret    

008001da <exit>:

void
exit(void)
{
  8001da:	55                   	push   %ebp
  8001db:	89 e5                	mov    %esp,%ebp
  8001dd:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001e0:	e8 34 0f 00 00       	call   801119 <sys_env_exit>
}
  8001e5:	90                   	nop
  8001e6:	c9                   	leave  
  8001e7:	c3                   	ret    

008001e8 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001e8:	55                   	push   %ebp
  8001e9:	89 e5                	mov    %esp,%ebp
  8001eb:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f1:	8b 00                	mov    (%eax),%eax
  8001f3:	8d 48 01             	lea    0x1(%eax),%ecx
  8001f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001f9:	89 0a                	mov    %ecx,(%edx)
  8001fb:	8b 55 08             	mov    0x8(%ebp),%edx
  8001fe:	88 d1                	mov    %dl,%cl
  800200:	8b 55 0c             	mov    0xc(%ebp),%edx
  800203:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800207:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020a:	8b 00                	mov    (%eax),%eax
  80020c:	3d ff 00 00 00       	cmp    $0xff,%eax
  800211:	75 2c                	jne    80023f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800213:	a0 24 20 80 00       	mov    0x802024,%al
  800218:	0f b6 c0             	movzbl %al,%eax
  80021b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80021e:	8b 12                	mov    (%edx),%edx
  800220:	89 d1                	mov    %edx,%ecx
  800222:	8b 55 0c             	mov    0xc(%ebp),%edx
  800225:	83 c2 08             	add    $0x8,%edx
  800228:	83 ec 04             	sub    $0x4,%esp
  80022b:	50                   	push   %eax
  80022c:	51                   	push   %ecx
  80022d:	52                   	push   %edx
  80022e:	e8 3e 0e 00 00       	call   801071 <sys_cputs>
  800233:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800236:	8b 45 0c             	mov    0xc(%ebp),%eax
  800239:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80023f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800242:	8b 40 04             	mov    0x4(%eax),%eax
  800245:	8d 50 01             	lea    0x1(%eax),%edx
  800248:	8b 45 0c             	mov    0xc(%ebp),%eax
  80024b:	89 50 04             	mov    %edx,0x4(%eax)
}
  80024e:	90                   	nop
  80024f:	c9                   	leave  
  800250:	c3                   	ret    

00800251 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800251:	55                   	push   %ebp
  800252:	89 e5                	mov    %esp,%ebp
  800254:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80025a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800261:	00 00 00 
	b.cnt = 0;
  800264:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80026b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80026e:	ff 75 0c             	pushl  0xc(%ebp)
  800271:	ff 75 08             	pushl  0x8(%ebp)
  800274:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80027a:	50                   	push   %eax
  80027b:	68 e8 01 80 00       	push   $0x8001e8
  800280:	e8 11 02 00 00       	call   800496 <vprintfmt>
  800285:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800288:	a0 24 20 80 00       	mov    0x802024,%al
  80028d:	0f b6 c0             	movzbl %al,%eax
  800290:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800296:	83 ec 04             	sub    $0x4,%esp
  800299:	50                   	push   %eax
  80029a:	52                   	push   %edx
  80029b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002a1:	83 c0 08             	add    $0x8,%eax
  8002a4:	50                   	push   %eax
  8002a5:	e8 c7 0d 00 00       	call   801071 <sys_cputs>
  8002aa:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002ad:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  8002b4:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002ba:	c9                   	leave  
  8002bb:	c3                   	ret    

008002bc <cprintf>:

int cprintf(const char *fmt, ...) {
  8002bc:	55                   	push   %ebp
  8002bd:	89 e5                	mov    %esp,%ebp
  8002bf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002c2:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  8002c9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d2:	83 ec 08             	sub    $0x8,%esp
  8002d5:	ff 75 f4             	pushl  -0xc(%ebp)
  8002d8:	50                   	push   %eax
  8002d9:	e8 73 ff ff ff       	call   800251 <vcprintf>
  8002de:	83 c4 10             	add    $0x10,%esp
  8002e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002e7:	c9                   	leave  
  8002e8:	c3                   	ret    

008002e9 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002e9:	55                   	push   %ebp
  8002ea:	89 e5                	mov    %esp,%ebp
  8002ec:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002ef:	e8 8e 0f 00 00       	call   801282 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002f4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8002fd:	83 ec 08             	sub    $0x8,%esp
  800300:	ff 75 f4             	pushl  -0xc(%ebp)
  800303:	50                   	push   %eax
  800304:	e8 48 ff ff ff       	call   800251 <vcprintf>
  800309:	83 c4 10             	add    $0x10,%esp
  80030c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80030f:	e8 88 0f 00 00       	call   80129c <sys_enable_interrupt>
	return cnt;
  800314:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800317:	c9                   	leave  
  800318:	c3                   	ret    

00800319 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800319:	55                   	push   %ebp
  80031a:	89 e5                	mov    %esp,%ebp
  80031c:	53                   	push   %ebx
  80031d:	83 ec 14             	sub    $0x14,%esp
  800320:	8b 45 10             	mov    0x10(%ebp),%eax
  800323:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800326:	8b 45 14             	mov    0x14(%ebp),%eax
  800329:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80032c:	8b 45 18             	mov    0x18(%ebp),%eax
  80032f:	ba 00 00 00 00       	mov    $0x0,%edx
  800334:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800337:	77 55                	ja     80038e <printnum+0x75>
  800339:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80033c:	72 05                	jb     800343 <printnum+0x2a>
  80033e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800341:	77 4b                	ja     80038e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800343:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800346:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800349:	8b 45 18             	mov    0x18(%ebp),%eax
  80034c:	ba 00 00 00 00       	mov    $0x0,%edx
  800351:	52                   	push   %edx
  800352:	50                   	push   %eax
  800353:	ff 75 f4             	pushl  -0xc(%ebp)
  800356:	ff 75 f0             	pushl  -0x10(%ebp)
  800359:	e8 62 13 00 00       	call   8016c0 <__udivdi3>
  80035e:	83 c4 10             	add    $0x10,%esp
  800361:	83 ec 04             	sub    $0x4,%esp
  800364:	ff 75 20             	pushl  0x20(%ebp)
  800367:	53                   	push   %ebx
  800368:	ff 75 18             	pushl  0x18(%ebp)
  80036b:	52                   	push   %edx
  80036c:	50                   	push   %eax
  80036d:	ff 75 0c             	pushl  0xc(%ebp)
  800370:	ff 75 08             	pushl  0x8(%ebp)
  800373:	e8 a1 ff ff ff       	call   800319 <printnum>
  800378:	83 c4 20             	add    $0x20,%esp
  80037b:	eb 1a                	jmp    800397 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80037d:	83 ec 08             	sub    $0x8,%esp
  800380:	ff 75 0c             	pushl  0xc(%ebp)
  800383:	ff 75 20             	pushl  0x20(%ebp)
  800386:	8b 45 08             	mov    0x8(%ebp),%eax
  800389:	ff d0                	call   *%eax
  80038b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80038e:	ff 4d 1c             	decl   0x1c(%ebp)
  800391:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800395:	7f e6                	jg     80037d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800397:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80039a:	bb 00 00 00 00       	mov    $0x0,%ebx
  80039f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003a5:	53                   	push   %ebx
  8003a6:	51                   	push   %ecx
  8003a7:	52                   	push   %edx
  8003a8:	50                   	push   %eax
  8003a9:	e8 22 14 00 00       	call   8017d0 <__umoddi3>
  8003ae:	83 c4 10             	add    $0x10,%esp
  8003b1:	05 14 1c 80 00       	add    $0x801c14,%eax
  8003b6:	8a 00                	mov    (%eax),%al
  8003b8:	0f be c0             	movsbl %al,%eax
  8003bb:	83 ec 08             	sub    $0x8,%esp
  8003be:	ff 75 0c             	pushl  0xc(%ebp)
  8003c1:	50                   	push   %eax
  8003c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c5:	ff d0                	call   *%eax
  8003c7:	83 c4 10             	add    $0x10,%esp
}
  8003ca:	90                   	nop
  8003cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003ce:	c9                   	leave  
  8003cf:	c3                   	ret    

008003d0 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003d0:	55                   	push   %ebp
  8003d1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003d3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003d7:	7e 1c                	jle    8003f5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003dc:	8b 00                	mov    (%eax),%eax
  8003de:	8d 50 08             	lea    0x8(%eax),%edx
  8003e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e4:	89 10                	mov    %edx,(%eax)
  8003e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e9:	8b 00                	mov    (%eax),%eax
  8003eb:	83 e8 08             	sub    $0x8,%eax
  8003ee:	8b 50 04             	mov    0x4(%eax),%edx
  8003f1:	8b 00                	mov    (%eax),%eax
  8003f3:	eb 40                	jmp    800435 <getuint+0x65>
	else if (lflag)
  8003f5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003f9:	74 1e                	je     800419 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fe:	8b 00                	mov    (%eax),%eax
  800400:	8d 50 04             	lea    0x4(%eax),%edx
  800403:	8b 45 08             	mov    0x8(%ebp),%eax
  800406:	89 10                	mov    %edx,(%eax)
  800408:	8b 45 08             	mov    0x8(%ebp),%eax
  80040b:	8b 00                	mov    (%eax),%eax
  80040d:	83 e8 04             	sub    $0x4,%eax
  800410:	8b 00                	mov    (%eax),%eax
  800412:	ba 00 00 00 00       	mov    $0x0,%edx
  800417:	eb 1c                	jmp    800435 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
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
}
  800435:	5d                   	pop    %ebp
  800436:	c3                   	ret    

00800437 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800437:	55                   	push   %ebp
  800438:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80043a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80043e:	7e 1c                	jle    80045c <getint+0x25>
		return va_arg(*ap, long long);
  800440:	8b 45 08             	mov    0x8(%ebp),%eax
  800443:	8b 00                	mov    (%eax),%eax
  800445:	8d 50 08             	lea    0x8(%eax),%edx
  800448:	8b 45 08             	mov    0x8(%ebp),%eax
  80044b:	89 10                	mov    %edx,(%eax)
  80044d:	8b 45 08             	mov    0x8(%ebp),%eax
  800450:	8b 00                	mov    (%eax),%eax
  800452:	83 e8 08             	sub    $0x8,%eax
  800455:	8b 50 04             	mov    0x4(%eax),%edx
  800458:	8b 00                	mov    (%eax),%eax
  80045a:	eb 38                	jmp    800494 <getint+0x5d>
	else if (lflag)
  80045c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800460:	74 1a                	je     80047c <getint+0x45>
		return va_arg(*ap, long);
  800462:	8b 45 08             	mov    0x8(%ebp),%eax
  800465:	8b 00                	mov    (%eax),%eax
  800467:	8d 50 04             	lea    0x4(%eax),%edx
  80046a:	8b 45 08             	mov    0x8(%ebp),%eax
  80046d:	89 10                	mov    %edx,(%eax)
  80046f:	8b 45 08             	mov    0x8(%ebp),%eax
  800472:	8b 00                	mov    (%eax),%eax
  800474:	83 e8 04             	sub    $0x4,%eax
  800477:	8b 00                	mov    (%eax),%eax
  800479:	99                   	cltd   
  80047a:	eb 18                	jmp    800494 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80047c:	8b 45 08             	mov    0x8(%ebp),%eax
  80047f:	8b 00                	mov    (%eax),%eax
  800481:	8d 50 04             	lea    0x4(%eax),%edx
  800484:	8b 45 08             	mov    0x8(%ebp),%eax
  800487:	89 10                	mov    %edx,(%eax)
  800489:	8b 45 08             	mov    0x8(%ebp),%eax
  80048c:	8b 00                	mov    (%eax),%eax
  80048e:	83 e8 04             	sub    $0x4,%eax
  800491:	8b 00                	mov    (%eax),%eax
  800493:	99                   	cltd   
}
  800494:	5d                   	pop    %ebp
  800495:	c3                   	ret    

00800496 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800496:	55                   	push   %ebp
  800497:	89 e5                	mov    %esp,%ebp
  800499:	56                   	push   %esi
  80049a:	53                   	push   %ebx
  80049b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80049e:	eb 17                	jmp    8004b7 <vprintfmt+0x21>
			if (ch == '\0')
  8004a0:	85 db                	test   %ebx,%ebx
  8004a2:	0f 84 af 03 00 00    	je     800857 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004a8:	83 ec 08             	sub    $0x8,%esp
  8004ab:	ff 75 0c             	pushl  0xc(%ebp)
  8004ae:	53                   	push   %ebx
  8004af:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b2:	ff d0                	call   *%eax
  8004b4:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ba:	8d 50 01             	lea    0x1(%eax),%edx
  8004bd:	89 55 10             	mov    %edx,0x10(%ebp)
  8004c0:	8a 00                	mov    (%eax),%al
  8004c2:	0f b6 d8             	movzbl %al,%ebx
  8004c5:	83 fb 25             	cmp    $0x25,%ebx
  8004c8:	75 d6                	jne    8004a0 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004ca:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004ce:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004d5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004dc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004e3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ed:	8d 50 01             	lea    0x1(%eax),%edx
  8004f0:	89 55 10             	mov    %edx,0x10(%ebp)
  8004f3:	8a 00                	mov    (%eax),%al
  8004f5:	0f b6 d8             	movzbl %al,%ebx
  8004f8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004fb:	83 f8 55             	cmp    $0x55,%eax
  8004fe:	0f 87 2b 03 00 00    	ja     80082f <vprintfmt+0x399>
  800504:	8b 04 85 38 1c 80 00 	mov    0x801c38(,%eax,4),%eax
  80050b:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80050d:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800511:	eb d7                	jmp    8004ea <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800513:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800517:	eb d1                	jmp    8004ea <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800519:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800520:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800523:	89 d0                	mov    %edx,%eax
  800525:	c1 e0 02             	shl    $0x2,%eax
  800528:	01 d0                	add    %edx,%eax
  80052a:	01 c0                	add    %eax,%eax
  80052c:	01 d8                	add    %ebx,%eax
  80052e:	83 e8 30             	sub    $0x30,%eax
  800531:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800534:	8b 45 10             	mov    0x10(%ebp),%eax
  800537:	8a 00                	mov    (%eax),%al
  800539:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80053c:	83 fb 2f             	cmp    $0x2f,%ebx
  80053f:	7e 3e                	jle    80057f <vprintfmt+0xe9>
  800541:	83 fb 39             	cmp    $0x39,%ebx
  800544:	7f 39                	jg     80057f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800546:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800549:	eb d5                	jmp    800520 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80054b:	8b 45 14             	mov    0x14(%ebp),%eax
  80054e:	83 c0 04             	add    $0x4,%eax
  800551:	89 45 14             	mov    %eax,0x14(%ebp)
  800554:	8b 45 14             	mov    0x14(%ebp),%eax
  800557:	83 e8 04             	sub    $0x4,%eax
  80055a:	8b 00                	mov    (%eax),%eax
  80055c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80055f:	eb 1f                	jmp    800580 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800561:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800565:	79 83                	jns    8004ea <vprintfmt+0x54>
				width = 0;
  800567:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80056e:	e9 77 ff ff ff       	jmp    8004ea <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800573:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80057a:	e9 6b ff ff ff       	jmp    8004ea <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80057f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800580:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800584:	0f 89 60 ff ff ff    	jns    8004ea <vprintfmt+0x54>
				width = precision, precision = -1;
  80058a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80058d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800590:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800597:	e9 4e ff ff ff       	jmp    8004ea <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80059c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80059f:	e9 46 ff ff ff       	jmp    8004ea <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a7:	83 c0 04             	add    $0x4,%eax
  8005aa:	89 45 14             	mov    %eax,0x14(%ebp)
  8005ad:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b0:	83 e8 04             	sub    $0x4,%eax
  8005b3:	8b 00                	mov    (%eax),%eax
  8005b5:	83 ec 08             	sub    $0x8,%esp
  8005b8:	ff 75 0c             	pushl  0xc(%ebp)
  8005bb:	50                   	push   %eax
  8005bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bf:	ff d0                	call   *%eax
  8005c1:	83 c4 10             	add    $0x10,%esp
			break;
  8005c4:	e9 89 02 00 00       	jmp    800852 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8005cc:	83 c0 04             	add    $0x4,%eax
  8005cf:	89 45 14             	mov    %eax,0x14(%ebp)
  8005d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d5:	83 e8 04             	sub    $0x4,%eax
  8005d8:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005da:	85 db                	test   %ebx,%ebx
  8005dc:	79 02                	jns    8005e0 <vprintfmt+0x14a>
				err = -err;
  8005de:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005e0:	83 fb 64             	cmp    $0x64,%ebx
  8005e3:	7f 0b                	jg     8005f0 <vprintfmt+0x15a>
  8005e5:	8b 34 9d 80 1a 80 00 	mov    0x801a80(,%ebx,4),%esi
  8005ec:	85 f6                	test   %esi,%esi
  8005ee:	75 19                	jne    800609 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005f0:	53                   	push   %ebx
  8005f1:	68 25 1c 80 00       	push   $0x801c25
  8005f6:	ff 75 0c             	pushl  0xc(%ebp)
  8005f9:	ff 75 08             	pushl  0x8(%ebp)
  8005fc:	e8 5e 02 00 00       	call   80085f <printfmt>
  800601:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800604:	e9 49 02 00 00       	jmp    800852 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800609:	56                   	push   %esi
  80060a:	68 2e 1c 80 00       	push   $0x801c2e
  80060f:	ff 75 0c             	pushl  0xc(%ebp)
  800612:	ff 75 08             	pushl  0x8(%ebp)
  800615:	e8 45 02 00 00       	call   80085f <printfmt>
  80061a:	83 c4 10             	add    $0x10,%esp
			break;
  80061d:	e9 30 02 00 00       	jmp    800852 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800622:	8b 45 14             	mov    0x14(%ebp),%eax
  800625:	83 c0 04             	add    $0x4,%eax
  800628:	89 45 14             	mov    %eax,0x14(%ebp)
  80062b:	8b 45 14             	mov    0x14(%ebp),%eax
  80062e:	83 e8 04             	sub    $0x4,%eax
  800631:	8b 30                	mov    (%eax),%esi
  800633:	85 f6                	test   %esi,%esi
  800635:	75 05                	jne    80063c <vprintfmt+0x1a6>
				p = "(null)";
  800637:	be 31 1c 80 00       	mov    $0x801c31,%esi
			if (width > 0 && padc != '-')
  80063c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800640:	7e 6d                	jle    8006af <vprintfmt+0x219>
  800642:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800646:	74 67                	je     8006af <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800648:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80064b:	83 ec 08             	sub    $0x8,%esp
  80064e:	50                   	push   %eax
  80064f:	56                   	push   %esi
  800650:	e8 0c 03 00 00       	call   800961 <strnlen>
  800655:	83 c4 10             	add    $0x10,%esp
  800658:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80065b:	eb 16                	jmp    800673 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80065d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800661:	83 ec 08             	sub    $0x8,%esp
  800664:	ff 75 0c             	pushl  0xc(%ebp)
  800667:	50                   	push   %eax
  800668:	8b 45 08             	mov    0x8(%ebp),%eax
  80066b:	ff d0                	call   *%eax
  80066d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800670:	ff 4d e4             	decl   -0x1c(%ebp)
  800673:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800677:	7f e4                	jg     80065d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800679:	eb 34                	jmp    8006af <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80067b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80067f:	74 1c                	je     80069d <vprintfmt+0x207>
  800681:	83 fb 1f             	cmp    $0x1f,%ebx
  800684:	7e 05                	jle    80068b <vprintfmt+0x1f5>
  800686:	83 fb 7e             	cmp    $0x7e,%ebx
  800689:	7e 12                	jle    80069d <vprintfmt+0x207>
					putch('?', putdat);
  80068b:	83 ec 08             	sub    $0x8,%esp
  80068e:	ff 75 0c             	pushl  0xc(%ebp)
  800691:	6a 3f                	push   $0x3f
  800693:	8b 45 08             	mov    0x8(%ebp),%eax
  800696:	ff d0                	call   *%eax
  800698:	83 c4 10             	add    $0x10,%esp
  80069b:	eb 0f                	jmp    8006ac <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80069d:	83 ec 08             	sub    $0x8,%esp
  8006a0:	ff 75 0c             	pushl  0xc(%ebp)
  8006a3:	53                   	push   %ebx
  8006a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a7:	ff d0                	call   *%eax
  8006a9:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006ac:	ff 4d e4             	decl   -0x1c(%ebp)
  8006af:	89 f0                	mov    %esi,%eax
  8006b1:	8d 70 01             	lea    0x1(%eax),%esi
  8006b4:	8a 00                	mov    (%eax),%al
  8006b6:	0f be d8             	movsbl %al,%ebx
  8006b9:	85 db                	test   %ebx,%ebx
  8006bb:	74 24                	je     8006e1 <vprintfmt+0x24b>
  8006bd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006c1:	78 b8                	js     80067b <vprintfmt+0x1e5>
  8006c3:	ff 4d e0             	decl   -0x20(%ebp)
  8006c6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006ca:	79 af                	jns    80067b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006cc:	eb 13                	jmp    8006e1 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006ce:	83 ec 08             	sub    $0x8,%esp
  8006d1:	ff 75 0c             	pushl  0xc(%ebp)
  8006d4:	6a 20                	push   $0x20
  8006d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d9:	ff d0                	call   *%eax
  8006db:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006de:	ff 4d e4             	decl   -0x1c(%ebp)
  8006e1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006e5:	7f e7                	jg     8006ce <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006e7:	e9 66 01 00 00       	jmp    800852 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006ec:	83 ec 08             	sub    $0x8,%esp
  8006ef:	ff 75 e8             	pushl  -0x18(%ebp)
  8006f2:	8d 45 14             	lea    0x14(%ebp),%eax
  8006f5:	50                   	push   %eax
  8006f6:	e8 3c fd ff ff       	call   800437 <getint>
  8006fb:	83 c4 10             	add    $0x10,%esp
  8006fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800701:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800704:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800707:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80070a:	85 d2                	test   %edx,%edx
  80070c:	79 23                	jns    800731 <vprintfmt+0x29b>
				putch('-', putdat);
  80070e:	83 ec 08             	sub    $0x8,%esp
  800711:	ff 75 0c             	pushl  0xc(%ebp)
  800714:	6a 2d                	push   $0x2d
  800716:	8b 45 08             	mov    0x8(%ebp),%eax
  800719:	ff d0                	call   *%eax
  80071b:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80071e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800721:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800724:	f7 d8                	neg    %eax
  800726:	83 d2 00             	adc    $0x0,%edx
  800729:	f7 da                	neg    %edx
  80072b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80072e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800731:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800738:	e9 bc 00 00 00       	jmp    8007f9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80073d:	83 ec 08             	sub    $0x8,%esp
  800740:	ff 75 e8             	pushl  -0x18(%ebp)
  800743:	8d 45 14             	lea    0x14(%ebp),%eax
  800746:	50                   	push   %eax
  800747:	e8 84 fc ff ff       	call   8003d0 <getuint>
  80074c:	83 c4 10             	add    $0x10,%esp
  80074f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800752:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800755:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80075c:	e9 98 00 00 00       	jmp    8007f9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800761:	83 ec 08             	sub    $0x8,%esp
  800764:	ff 75 0c             	pushl  0xc(%ebp)
  800767:	6a 58                	push   $0x58
  800769:	8b 45 08             	mov    0x8(%ebp),%eax
  80076c:	ff d0                	call   *%eax
  80076e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800771:	83 ec 08             	sub    $0x8,%esp
  800774:	ff 75 0c             	pushl  0xc(%ebp)
  800777:	6a 58                	push   $0x58
  800779:	8b 45 08             	mov    0x8(%ebp),%eax
  80077c:	ff d0                	call   *%eax
  80077e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800781:	83 ec 08             	sub    $0x8,%esp
  800784:	ff 75 0c             	pushl  0xc(%ebp)
  800787:	6a 58                	push   $0x58
  800789:	8b 45 08             	mov    0x8(%ebp),%eax
  80078c:	ff d0                	call   *%eax
  80078e:	83 c4 10             	add    $0x10,%esp
			break;
  800791:	e9 bc 00 00 00       	jmp    800852 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800796:	83 ec 08             	sub    $0x8,%esp
  800799:	ff 75 0c             	pushl  0xc(%ebp)
  80079c:	6a 30                	push   $0x30
  80079e:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a1:	ff d0                	call   *%eax
  8007a3:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007a6:	83 ec 08             	sub    $0x8,%esp
  8007a9:	ff 75 0c             	pushl  0xc(%ebp)
  8007ac:	6a 78                	push   $0x78
  8007ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b1:	ff d0                	call   *%eax
  8007b3:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b9:	83 c0 04             	add    $0x4,%eax
  8007bc:	89 45 14             	mov    %eax,0x14(%ebp)
  8007bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c2:	83 e8 04             	sub    $0x4,%eax
  8007c5:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007d1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007d8:	eb 1f                	jmp    8007f9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007da:	83 ec 08             	sub    $0x8,%esp
  8007dd:	ff 75 e8             	pushl  -0x18(%ebp)
  8007e0:	8d 45 14             	lea    0x14(%ebp),%eax
  8007e3:	50                   	push   %eax
  8007e4:	e8 e7 fb ff ff       	call   8003d0 <getuint>
  8007e9:	83 c4 10             	add    $0x10,%esp
  8007ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ef:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007f2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007f9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800800:	83 ec 04             	sub    $0x4,%esp
  800803:	52                   	push   %edx
  800804:	ff 75 e4             	pushl  -0x1c(%ebp)
  800807:	50                   	push   %eax
  800808:	ff 75 f4             	pushl  -0xc(%ebp)
  80080b:	ff 75 f0             	pushl  -0x10(%ebp)
  80080e:	ff 75 0c             	pushl  0xc(%ebp)
  800811:	ff 75 08             	pushl  0x8(%ebp)
  800814:	e8 00 fb ff ff       	call   800319 <printnum>
  800819:	83 c4 20             	add    $0x20,%esp
			break;
  80081c:	eb 34                	jmp    800852 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80081e:	83 ec 08             	sub    $0x8,%esp
  800821:	ff 75 0c             	pushl  0xc(%ebp)
  800824:	53                   	push   %ebx
  800825:	8b 45 08             	mov    0x8(%ebp),%eax
  800828:	ff d0                	call   *%eax
  80082a:	83 c4 10             	add    $0x10,%esp
			break;
  80082d:	eb 23                	jmp    800852 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80082f:	83 ec 08             	sub    $0x8,%esp
  800832:	ff 75 0c             	pushl  0xc(%ebp)
  800835:	6a 25                	push   $0x25
  800837:	8b 45 08             	mov    0x8(%ebp),%eax
  80083a:	ff d0                	call   *%eax
  80083c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80083f:	ff 4d 10             	decl   0x10(%ebp)
  800842:	eb 03                	jmp    800847 <vprintfmt+0x3b1>
  800844:	ff 4d 10             	decl   0x10(%ebp)
  800847:	8b 45 10             	mov    0x10(%ebp),%eax
  80084a:	48                   	dec    %eax
  80084b:	8a 00                	mov    (%eax),%al
  80084d:	3c 25                	cmp    $0x25,%al
  80084f:	75 f3                	jne    800844 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800851:	90                   	nop
		}
	}
  800852:	e9 47 fc ff ff       	jmp    80049e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800857:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800858:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80085b:	5b                   	pop    %ebx
  80085c:	5e                   	pop    %esi
  80085d:	5d                   	pop    %ebp
  80085e:	c3                   	ret    

0080085f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80085f:	55                   	push   %ebp
  800860:	89 e5                	mov    %esp,%ebp
  800862:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800865:	8d 45 10             	lea    0x10(%ebp),%eax
  800868:	83 c0 04             	add    $0x4,%eax
  80086b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80086e:	8b 45 10             	mov    0x10(%ebp),%eax
  800871:	ff 75 f4             	pushl  -0xc(%ebp)
  800874:	50                   	push   %eax
  800875:	ff 75 0c             	pushl  0xc(%ebp)
  800878:	ff 75 08             	pushl  0x8(%ebp)
  80087b:	e8 16 fc ff ff       	call   800496 <vprintfmt>
  800880:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800883:	90                   	nop
  800884:	c9                   	leave  
  800885:	c3                   	ret    

00800886 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800886:	55                   	push   %ebp
  800887:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800889:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088c:	8b 40 08             	mov    0x8(%eax),%eax
  80088f:	8d 50 01             	lea    0x1(%eax),%edx
  800892:	8b 45 0c             	mov    0xc(%ebp),%eax
  800895:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800898:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089b:	8b 10                	mov    (%eax),%edx
  80089d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a0:	8b 40 04             	mov    0x4(%eax),%eax
  8008a3:	39 c2                	cmp    %eax,%edx
  8008a5:	73 12                	jae    8008b9 <sprintputch+0x33>
		*b->buf++ = ch;
  8008a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008aa:	8b 00                	mov    (%eax),%eax
  8008ac:	8d 48 01             	lea    0x1(%eax),%ecx
  8008af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008b2:	89 0a                	mov    %ecx,(%edx)
  8008b4:	8b 55 08             	mov    0x8(%ebp),%edx
  8008b7:	88 10                	mov    %dl,(%eax)
}
  8008b9:	90                   	nop
  8008ba:	5d                   	pop    %ebp
  8008bb:	c3                   	ret    

008008bc <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008bc:	55                   	push   %ebp
  8008bd:	89 e5                	mov    %esp,%ebp
  8008bf:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008cb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d1:	01 d0                	add    %edx,%eax
  8008d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008d6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008dd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008e1:	74 06                	je     8008e9 <vsnprintf+0x2d>
  8008e3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008e7:	7f 07                	jg     8008f0 <vsnprintf+0x34>
		return -E_INVAL;
  8008e9:	b8 03 00 00 00       	mov    $0x3,%eax
  8008ee:	eb 20                	jmp    800910 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008f0:	ff 75 14             	pushl  0x14(%ebp)
  8008f3:	ff 75 10             	pushl  0x10(%ebp)
  8008f6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008f9:	50                   	push   %eax
  8008fa:	68 86 08 80 00       	push   $0x800886
  8008ff:	e8 92 fb ff ff       	call   800496 <vprintfmt>
  800904:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800907:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80090a:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80090d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800910:	c9                   	leave  
  800911:	c3                   	ret    

00800912 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800912:	55                   	push   %ebp
  800913:	89 e5                	mov    %esp,%ebp
  800915:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800918:	8d 45 10             	lea    0x10(%ebp),%eax
  80091b:	83 c0 04             	add    $0x4,%eax
  80091e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800921:	8b 45 10             	mov    0x10(%ebp),%eax
  800924:	ff 75 f4             	pushl  -0xc(%ebp)
  800927:	50                   	push   %eax
  800928:	ff 75 0c             	pushl  0xc(%ebp)
  80092b:	ff 75 08             	pushl  0x8(%ebp)
  80092e:	e8 89 ff ff ff       	call   8008bc <vsnprintf>
  800933:	83 c4 10             	add    $0x10,%esp
  800936:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800939:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80093c:	c9                   	leave  
  80093d:	c3                   	ret    

0080093e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80093e:	55                   	push   %ebp
  80093f:	89 e5                	mov    %esp,%ebp
  800941:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800944:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80094b:	eb 06                	jmp    800953 <strlen+0x15>
		n++;
  80094d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800950:	ff 45 08             	incl   0x8(%ebp)
  800953:	8b 45 08             	mov    0x8(%ebp),%eax
  800956:	8a 00                	mov    (%eax),%al
  800958:	84 c0                	test   %al,%al
  80095a:	75 f1                	jne    80094d <strlen+0xf>
		n++;
	return n;
  80095c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80095f:	c9                   	leave  
  800960:	c3                   	ret    

00800961 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800961:	55                   	push   %ebp
  800962:	89 e5                	mov    %esp,%ebp
  800964:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800967:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80096e:	eb 09                	jmp    800979 <strnlen+0x18>
		n++;
  800970:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800973:	ff 45 08             	incl   0x8(%ebp)
  800976:	ff 4d 0c             	decl   0xc(%ebp)
  800979:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80097d:	74 09                	je     800988 <strnlen+0x27>
  80097f:	8b 45 08             	mov    0x8(%ebp),%eax
  800982:	8a 00                	mov    (%eax),%al
  800984:	84 c0                	test   %al,%al
  800986:	75 e8                	jne    800970 <strnlen+0xf>
		n++;
	return n;
  800988:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80098b:	c9                   	leave  
  80098c:	c3                   	ret    

0080098d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80098d:	55                   	push   %ebp
  80098e:	89 e5                	mov    %esp,%ebp
  800990:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800993:	8b 45 08             	mov    0x8(%ebp),%eax
  800996:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800999:	90                   	nop
  80099a:	8b 45 08             	mov    0x8(%ebp),%eax
  80099d:	8d 50 01             	lea    0x1(%eax),%edx
  8009a0:	89 55 08             	mov    %edx,0x8(%ebp)
  8009a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009a6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009a9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009ac:	8a 12                	mov    (%edx),%dl
  8009ae:	88 10                	mov    %dl,(%eax)
  8009b0:	8a 00                	mov    (%eax),%al
  8009b2:	84 c0                	test   %al,%al
  8009b4:	75 e4                	jne    80099a <strcpy+0xd>
		/* do nothing */;
	return ret;
  8009b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009b9:	c9                   	leave  
  8009ba:	c3                   	ret    

008009bb <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8009bb:	55                   	push   %ebp
  8009bc:	89 e5                	mov    %esp,%ebp
  8009be:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8009c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009ce:	eb 1f                	jmp    8009ef <strncpy+0x34>
		*dst++ = *src;
  8009d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d3:	8d 50 01             	lea    0x1(%eax),%edx
  8009d6:	89 55 08             	mov    %edx,0x8(%ebp)
  8009d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009dc:	8a 12                	mov    (%edx),%dl
  8009de:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e3:	8a 00                	mov    (%eax),%al
  8009e5:	84 c0                	test   %al,%al
  8009e7:	74 03                	je     8009ec <strncpy+0x31>
			src++;
  8009e9:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009ec:	ff 45 fc             	incl   -0x4(%ebp)
  8009ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009f2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009f5:	72 d9                	jb     8009d0 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009fa:	c9                   	leave  
  8009fb:	c3                   	ret    

008009fc <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009fc:	55                   	push   %ebp
  8009fd:	89 e5                	mov    %esp,%ebp
  8009ff:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a02:	8b 45 08             	mov    0x8(%ebp),%eax
  800a05:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a08:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a0c:	74 30                	je     800a3e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a0e:	eb 16                	jmp    800a26 <strlcpy+0x2a>
			*dst++ = *src++;
  800a10:	8b 45 08             	mov    0x8(%ebp),%eax
  800a13:	8d 50 01             	lea    0x1(%eax),%edx
  800a16:	89 55 08             	mov    %edx,0x8(%ebp)
  800a19:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a1c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a1f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a22:	8a 12                	mov    (%edx),%dl
  800a24:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a26:	ff 4d 10             	decl   0x10(%ebp)
  800a29:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a2d:	74 09                	je     800a38 <strlcpy+0x3c>
  800a2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a32:	8a 00                	mov    (%eax),%al
  800a34:	84 c0                	test   %al,%al
  800a36:	75 d8                	jne    800a10 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a38:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a3e:	8b 55 08             	mov    0x8(%ebp),%edx
  800a41:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a44:	29 c2                	sub    %eax,%edx
  800a46:	89 d0                	mov    %edx,%eax
}
  800a48:	c9                   	leave  
  800a49:	c3                   	ret    

00800a4a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a4a:	55                   	push   %ebp
  800a4b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a4d:	eb 06                	jmp    800a55 <strcmp+0xb>
		p++, q++;
  800a4f:	ff 45 08             	incl   0x8(%ebp)
  800a52:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a55:	8b 45 08             	mov    0x8(%ebp),%eax
  800a58:	8a 00                	mov    (%eax),%al
  800a5a:	84 c0                	test   %al,%al
  800a5c:	74 0e                	je     800a6c <strcmp+0x22>
  800a5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a61:	8a 10                	mov    (%eax),%dl
  800a63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a66:	8a 00                	mov    (%eax),%al
  800a68:	38 c2                	cmp    %al,%dl
  800a6a:	74 e3                	je     800a4f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6f:	8a 00                	mov    (%eax),%al
  800a71:	0f b6 d0             	movzbl %al,%edx
  800a74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a77:	8a 00                	mov    (%eax),%al
  800a79:	0f b6 c0             	movzbl %al,%eax
  800a7c:	29 c2                	sub    %eax,%edx
  800a7e:	89 d0                	mov    %edx,%eax
}
  800a80:	5d                   	pop    %ebp
  800a81:	c3                   	ret    

00800a82 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a82:	55                   	push   %ebp
  800a83:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a85:	eb 09                	jmp    800a90 <strncmp+0xe>
		n--, p++, q++;
  800a87:	ff 4d 10             	decl   0x10(%ebp)
  800a8a:	ff 45 08             	incl   0x8(%ebp)
  800a8d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a90:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a94:	74 17                	je     800aad <strncmp+0x2b>
  800a96:	8b 45 08             	mov    0x8(%ebp),%eax
  800a99:	8a 00                	mov    (%eax),%al
  800a9b:	84 c0                	test   %al,%al
  800a9d:	74 0e                	je     800aad <strncmp+0x2b>
  800a9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa2:	8a 10                	mov    (%eax),%dl
  800aa4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa7:	8a 00                	mov    (%eax),%al
  800aa9:	38 c2                	cmp    %al,%dl
  800aab:	74 da                	je     800a87 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800aad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ab1:	75 07                	jne    800aba <strncmp+0x38>
		return 0;
  800ab3:	b8 00 00 00 00       	mov    $0x0,%eax
  800ab8:	eb 14                	jmp    800ace <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800aba:	8b 45 08             	mov    0x8(%ebp),%eax
  800abd:	8a 00                	mov    (%eax),%al
  800abf:	0f b6 d0             	movzbl %al,%edx
  800ac2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac5:	8a 00                	mov    (%eax),%al
  800ac7:	0f b6 c0             	movzbl %al,%eax
  800aca:	29 c2                	sub    %eax,%edx
  800acc:	89 d0                	mov    %edx,%eax
}
  800ace:	5d                   	pop    %ebp
  800acf:	c3                   	ret    

00800ad0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ad0:	55                   	push   %ebp
  800ad1:	89 e5                	mov    %esp,%ebp
  800ad3:	83 ec 04             	sub    $0x4,%esp
  800ad6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800adc:	eb 12                	jmp    800af0 <strchr+0x20>
		if (*s == c)
  800ade:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae1:	8a 00                	mov    (%eax),%al
  800ae3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ae6:	75 05                	jne    800aed <strchr+0x1d>
			return (char *) s;
  800ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aeb:	eb 11                	jmp    800afe <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800aed:	ff 45 08             	incl   0x8(%ebp)
  800af0:	8b 45 08             	mov    0x8(%ebp),%eax
  800af3:	8a 00                	mov    (%eax),%al
  800af5:	84 c0                	test   %al,%al
  800af7:	75 e5                	jne    800ade <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800af9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800afe:	c9                   	leave  
  800aff:	c3                   	ret    

00800b00 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b00:	55                   	push   %ebp
  800b01:	89 e5                	mov    %esp,%ebp
  800b03:	83 ec 04             	sub    $0x4,%esp
  800b06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b09:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b0c:	eb 0d                	jmp    800b1b <strfind+0x1b>
		if (*s == c)
  800b0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b11:	8a 00                	mov    (%eax),%al
  800b13:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b16:	74 0e                	je     800b26 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b18:	ff 45 08             	incl   0x8(%ebp)
  800b1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1e:	8a 00                	mov    (%eax),%al
  800b20:	84 c0                	test   %al,%al
  800b22:	75 ea                	jne    800b0e <strfind+0xe>
  800b24:	eb 01                	jmp    800b27 <strfind+0x27>
		if (*s == c)
			break;
  800b26:	90                   	nop
	return (char *) s;
  800b27:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b2a:	c9                   	leave  
  800b2b:	c3                   	ret    

00800b2c <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b2c:	55                   	push   %ebp
  800b2d:	89 e5                	mov    %esp,%ebp
  800b2f:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b32:	8b 45 08             	mov    0x8(%ebp),%eax
  800b35:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b38:	8b 45 10             	mov    0x10(%ebp),%eax
  800b3b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b3e:	eb 0e                	jmp    800b4e <memset+0x22>
		*p++ = c;
  800b40:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b43:	8d 50 01             	lea    0x1(%eax),%edx
  800b46:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b49:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b4c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b4e:	ff 4d f8             	decl   -0x8(%ebp)
  800b51:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b55:	79 e9                	jns    800b40 <memset+0x14>
		*p++ = c;

	return v;
  800b57:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b5a:	c9                   	leave  
  800b5b:	c3                   	ret    

00800b5c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b5c:	55                   	push   %ebp
  800b5d:	89 e5                	mov    %esp,%ebp
  800b5f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b65:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b68:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b6e:	eb 16                	jmp    800b86 <memcpy+0x2a>
		*d++ = *s++;
  800b70:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b73:	8d 50 01             	lea    0x1(%eax),%edx
  800b76:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b79:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b7c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b7f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b82:	8a 12                	mov    (%edx),%dl
  800b84:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b86:	8b 45 10             	mov    0x10(%ebp),%eax
  800b89:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b8c:	89 55 10             	mov    %edx,0x10(%ebp)
  800b8f:	85 c0                	test   %eax,%eax
  800b91:	75 dd                	jne    800b70 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b96:	c9                   	leave  
  800b97:	c3                   	ret    

00800b98 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b98:	55                   	push   %ebp
  800b99:	89 e5                	mov    %esp,%ebp
  800b9b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800baa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bad:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bb0:	73 50                	jae    800c02 <memmove+0x6a>
  800bb2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bb5:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb8:	01 d0                	add    %edx,%eax
  800bba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bbd:	76 43                	jbe    800c02 <memmove+0x6a>
		s += n;
  800bbf:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc2:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800bc5:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc8:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800bcb:	eb 10                	jmp    800bdd <memmove+0x45>
			*--d = *--s;
  800bcd:	ff 4d f8             	decl   -0x8(%ebp)
  800bd0:	ff 4d fc             	decl   -0x4(%ebp)
  800bd3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bd6:	8a 10                	mov    (%eax),%dl
  800bd8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bdb:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bdd:	8b 45 10             	mov    0x10(%ebp),%eax
  800be0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800be3:	89 55 10             	mov    %edx,0x10(%ebp)
  800be6:	85 c0                	test   %eax,%eax
  800be8:	75 e3                	jne    800bcd <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bea:	eb 23                	jmp    800c0f <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bef:	8d 50 01             	lea    0x1(%eax),%edx
  800bf2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bf5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bf8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bfb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bfe:	8a 12                	mov    (%edx),%dl
  800c00:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c02:	8b 45 10             	mov    0x10(%ebp),%eax
  800c05:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c08:	89 55 10             	mov    %edx,0x10(%ebp)
  800c0b:	85 c0                	test   %eax,%eax
  800c0d:	75 dd                	jne    800bec <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c0f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c12:	c9                   	leave  
  800c13:	c3                   	ret    

00800c14 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c14:	55                   	push   %ebp
  800c15:	89 e5                	mov    %esp,%ebp
  800c17:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c23:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c26:	eb 2a                	jmp    800c52 <memcmp+0x3e>
		if (*s1 != *s2)
  800c28:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c2b:	8a 10                	mov    (%eax),%dl
  800c2d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c30:	8a 00                	mov    (%eax),%al
  800c32:	38 c2                	cmp    %al,%dl
  800c34:	74 16                	je     800c4c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c36:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c39:	8a 00                	mov    (%eax),%al
  800c3b:	0f b6 d0             	movzbl %al,%edx
  800c3e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c41:	8a 00                	mov    (%eax),%al
  800c43:	0f b6 c0             	movzbl %al,%eax
  800c46:	29 c2                	sub    %eax,%edx
  800c48:	89 d0                	mov    %edx,%eax
  800c4a:	eb 18                	jmp    800c64 <memcmp+0x50>
		s1++, s2++;
  800c4c:	ff 45 fc             	incl   -0x4(%ebp)
  800c4f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c52:	8b 45 10             	mov    0x10(%ebp),%eax
  800c55:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c58:	89 55 10             	mov    %edx,0x10(%ebp)
  800c5b:	85 c0                	test   %eax,%eax
  800c5d:	75 c9                	jne    800c28 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c5f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c64:	c9                   	leave  
  800c65:	c3                   	ret    

00800c66 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c66:	55                   	push   %ebp
  800c67:	89 e5                	mov    %esp,%ebp
  800c69:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c6c:	8b 55 08             	mov    0x8(%ebp),%edx
  800c6f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c72:	01 d0                	add    %edx,%eax
  800c74:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c77:	eb 15                	jmp    800c8e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c79:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7c:	8a 00                	mov    (%eax),%al
  800c7e:	0f b6 d0             	movzbl %al,%edx
  800c81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c84:	0f b6 c0             	movzbl %al,%eax
  800c87:	39 c2                	cmp    %eax,%edx
  800c89:	74 0d                	je     800c98 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c8b:	ff 45 08             	incl   0x8(%ebp)
  800c8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c91:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c94:	72 e3                	jb     800c79 <memfind+0x13>
  800c96:	eb 01                	jmp    800c99 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c98:	90                   	nop
	return (void *) s;
  800c99:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c9c:	c9                   	leave  
  800c9d:	c3                   	ret    

00800c9e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c9e:	55                   	push   %ebp
  800c9f:	89 e5                	mov    %esp,%ebp
  800ca1:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ca4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800cab:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cb2:	eb 03                	jmp    800cb7 <strtol+0x19>
		s++;
  800cb4:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cba:	8a 00                	mov    (%eax),%al
  800cbc:	3c 20                	cmp    $0x20,%al
  800cbe:	74 f4                	je     800cb4 <strtol+0x16>
  800cc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc3:	8a 00                	mov    (%eax),%al
  800cc5:	3c 09                	cmp    $0x9,%al
  800cc7:	74 eb                	je     800cb4 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	8a 00                	mov    (%eax),%al
  800cce:	3c 2b                	cmp    $0x2b,%al
  800cd0:	75 05                	jne    800cd7 <strtol+0x39>
		s++;
  800cd2:	ff 45 08             	incl   0x8(%ebp)
  800cd5:	eb 13                	jmp    800cea <strtol+0x4c>
	else if (*s == '-')
  800cd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cda:	8a 00                	mov    (%eax),%al
  800cdc:	3c 2d                	cmp    $0x2d,%al
  800cde:	75 0a                	jne    800cea <strtol+0x4c>
		s++, neg = 1;
  800ce0:	ff 45 08             	incl   0x8(%ebp)
  800ce3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cea:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cee:	74 06                	je     800cf6 <strtol+0x58>
  800cf0:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cf4:	75 20                	jne    800d16 <strtol+0x78>
  800cf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf9:	8a 00                	mov    (%eax),%al
  800cfb:	3c 30                	cmp    $0x30,%al
  800cfd:	75 17                	jne    800d16 <strtol+0x78>
  800cff:	8b 45 08             	mov    0x8(%ebp),%eax
  800d02:	40                   	inc    %eax
  800d03:	8a 00                	mov    (%eax),%al
  800d05:	3c 78                	cmp    $0x78,%al
  800d07:	75 0d                	jne    800d16 <strtol+0x78>
		s += 2, base = 16;
  800d09:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d0d:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d14:	eb 28                	jmp    800d3e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d16:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d1a:	75 15                	jne    800d31 <strtol+0x93>
  800d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1f:	8a 00                	mov    (%eax),%al
  800d21:	3c 30                	cmp    $0x30,%al
  800d23:	75 0c                	jne    800d31 <strtol+0x93>
		s++, base = 8;
  800d25:	ff 45 08             	incl   0x8(%ebp)
  800d28:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d2f:	eb 0d                	jmp    800d3e <strtol+0xa0>
	else if (base == 0)
  800d31:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d35:	75 07                	jne    800d3e <strtol+0xa0>
		base = 10;
  800d37:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d41:	8a 00                	mov    (%eax),%al
  800d43:	3c 2f                	cmp    $0x2f,%al
  800d45:	7e 19                	jle    800d60 <strtol+0xc2>
  800d47:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4a:	8a 00                	mov    (%eax),%al
  800d4c:	3c 39                	cmp    $0x39,%al
  800d4e:	7f 10                	jg     800d60 <strtol+0xc2>
			dig = *s - '0';
  800d50:	8b 45 08             	mov    0x8(%ebp),%eax
  800d53:	8a 00                	mov    (%eax),%al
  800d55:	0f be c0             	movsbl %al,%eax
  800d58:	83 e8 30             	sub    $0x30,%eax
  800d5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d5e:	eb 42                	jmp    800da2 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d60:	8b 45 08             	mov    0x8(%ebp),%eax
  800d63:	8a 00                	mov    (%eax),%al
  800d65:	3c 60                	cmp    $0x60,%al
  800d67:	7e 19                	jle    800d82 <strtol+0xe4>
  800d69:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6c:	8a 00                	mov    (%eax),%al
  800d6e:	3c 7a                	cmp    $0x7a,%al
  800d70:	7f 10                	jg     800d82 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d72:	8b 45 08             	mov    0x8(%ebp),%eax
  800d75:	8a 00                	mov    (%eax),%al
  800d77:	0f be c0             	movsbl %al,%eax
  800d7a:	83 e8 57             	sub    $0x57,%eax
  800d7d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d80:	eb 20                	jmp    800da2 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d82:	8b 45 08             	mov    0x8(%ebp),%eax
  800d85:	8a 00                	mov    (%eax),%al
  800d87:	3c 40                	cmp    $0x40,%al
  800d89:	7e 39                	jle    800dc4 <strtol+0x126>
  800d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8e:	8a 00                	mov    (%eax),%al
  800d90:	3c 5a                	cmp    $0x5a,%al
  800d92:	7f 30                	jg     800dc4 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d94:	8b 45 08             	mov    0x8(%ebp),%eax
  800d97:	8a 00                	mov    (%eax),%al
  800d99:	0f be c0             	movsbl %al,%eax
  800d9c:	83 e8 37             	sub    $0x37,%eax
  800d9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800da2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800da5:	3b 45 10             	cmp    0x10(%ebp),%eax
  800da8:	7d 19                	jge    800dc3 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800daa:	ff 45 08             	incl   0x8(%ebp)
  800dad:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db0:	0f af 45 10          	imul   0x10(%ebp),%eax
  800db4:	89 c2                	mov    %eax,%edx
  800db6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800db9:	01 d0                	add    %edx,%eax
  800dbb:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800dbe:	e9 7b ff ff ff       	jmp    800d3e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800dc3:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800dc4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dc8:	74 08                	je     800dd2 <strtol+0x134>
		*endptr = (char *) s;
  800dca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dcd:	8b 55 08             	mov    0x8(%ebp),%edx
  800dd0:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800dd2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800dd6:	74 07                	je     800ddf <strtol+0x141>
  800dd8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ddb:	f7 d8                	neg    %eax
  800ddd:	eb 03                	jmp    800de2 <strtol+0x144>
  800ddf:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800de2:	c9                   	leave  
  800de3:	c3                   	ret    

00800de4 <ltostr>:

void
ltostr(long value, char *str)
{
  800de4:	55                   	push   %ebp
  800de5:	89 e5                	mov    %esp,%ebp
  800de7:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800df1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800df8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dfc:	79 13                	jns    800e11 <ltostr+0x2d>
	{
		neg = 1;
  800dfe:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e08:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e0b:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e0e:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e11:	8b 45 08             	mov    0x8(%ebp),%eax
  800e14:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e19:	99                   	cltd   
  800e1a:	f7 f9                	idiv   %ecx
  800e1c:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e1f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e22:	8d 50 01             	lea    0x1(%eax),%edx
  800e25:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e28:	89 c2                	mov    %eax,%edx
  800e2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2d:	01 d0                	add    %edx,%eax
  800e2f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e32:	83 c2 30             	add    $0x30,%edx
  800e35:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e37:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e3a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e3f:	f7 e9                	imul   %ecx
  800e41:	c1 fa 02             	sar    $0x2,%edx
  800e44:	89 c8                	mov    %ecx,%eax
  800e46:	c1 f8 1f             	sar    $0x1f,%eax
  800e49:	29 c2                	sub    %eax,%edx
  800e4b:	89 d0                	mov    %edx,%eax
  800e4d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e50:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e53:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e58:	f7 e9                	imul   %ecx
  800e5a:	c1 fa 02             	sar    $0x2,%edx
  800e5d:	89 c8                	mov    %ecx,%eax
  800e5f:	c1 f8 1f             	sar    $0x1f,%eax
  800e62:	29 c2                	sub    %eax,%edx
  800e64:	89 d0                	mov    %edx,%eax
  800e66:	c1 e0 02             	shl    $0x2,%eax
  800e69:	01 d0                	add    %edx,%eax
  800e6b:	01 c0                	add    %eax,%eax
  800e6d:	29 c1                	sub    %eax,%ecx
  800e6f:	89 ca                	mov    %ecx,%edx
  800e71:	85 d2                	test   %edx,%edx
  800e73:	75 9c                	jne    800e11 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e75:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e7f:	48                   	dec    %eax
  800e80:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e83:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e87:	74 3d                	je     800ec6 <ltostr+0xe2>
		start = 1 ;
  800e89:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e90:	eb 34                	jmp    800ec6 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e92:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e98:	01 d0                	add    %edx,%eax
  800e9a:	8a 00                	mov    (%eax),%al
  800e9c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e9f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ea2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea5:	01 c2                	add    %eax,%edx
  800ea7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800eaa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ead:	01 c8                	add    %ecx,%eax
  800eaf:	8a 00                	mov    (%eax),%al
  800eb1:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800eb3:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800eb6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb9:	01 c2                	add    %eax,%edx
  800ebb:	8a 45 eb             	mov    -0x15(%ebp),%al
  800ebe:	88 02                	mov    %al,(%edx)
		start++ ;
  800ec0:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800ec3:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800ec6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ec9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ecc:	7c c4                	jl     800e92 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800ece:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ed1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed4:	01 d0                	add    %edx,%eax
  800ed6:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800ed9:	90                   	nop
  800eda:	c9                   	leave  
  800edb:	c3                   	ret    

00800edc <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800edc:	55                   	push   %ebp
  800edd:	89 e5                	mov    %esp,%ebp
  800edf:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ee2:	ff 75 08             	pushl  0x8(%ebp)
  800ee5:	e8 54 fa ff ff       	call   80093e <strlen>
  800eea:	83 c4 04             	add    $0x4,%esp
  800eed:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800ef0:	ff 75 0c             	pushl  0xc(%ebp)
  800ef3:	e8 46 fa ff ff       	call   80093e <strlen>
  800ef8:	83 c4 04             	add    $0x4,%esp
  800efb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800efe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f05:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f0c:	eb 17                	jmp    800f25 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f0e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f11:	8b 45 10             	mov    0x10(%ebp),%eax
  800f14:	01 c2                	add    %eax,%edx
  800f16:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f19:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1c:	01 c8                	add    %ecx,%eax
  800f1e:	8a 00                	mov    (%eax),%al
  800f20:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f22:	ff 45 fc             	incl   -0x4(%ebp)
  800f25:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f28:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f2b:	7c e1                	jl     800f0e <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f2d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f34:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f3b:	eb 1f                	jmp    800f5c <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f40:	8d 50 01             	lea    0x1(%eax),%edx
  800f43:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f46:	89 c2                	mov    %eax,%edx
  800f48:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4b:	01 c2                	add    %eax,%edx
  800f4d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f53:	01 c8                	add    %ecx,%eax
  800f55:	8a 00                	mov    (%eax),%al
  800f57:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f59:	ff 45 f8             	incl   -0x8(%ebp)
  800f5c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f5f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f62:	7c d9                	jl     800f3d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f64:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f67:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6a:	01 d0                	add    %edx,%eax
  800f6c:	c6 00 00             	movb   $0x0,(%eax)
}
  800f6f:	90                   	nop
  800f70:	c9                   	leave  
  800f71:	c3                   	ret    

00800f72 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f72:	55                   	push   %ebp
  800f73:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f75:	8b 45 14             	mov    0x14(%ebp),%eax
  800f78:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f7e:	8b 45 14             	mov    0x14(%ebp),%eax
  800f81:	8b 00                	mov    (%eax),%eax
  800f83:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f8a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8d:	01 d0                	add    %edx,%eax
  800f8f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f95:	eb 0c                	jmp    800fa3 <strsplit+0x31>
			*string++ = 0;
  800f97:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9a:	8d 50 01             	lea    0x1(%eax),%edx
  800f9d:	89 55 08             	mov    %edx,0x8(%ebp)
  800fa0:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa6:	8a 00                	mov    (%eax),%al
  800fa8:	84 c0                	test   %al,%al
  800faa:	74 18                	je     800fc4 <strsplit+0x52>
  800fac:	8b 45 08             	mov    0x8(%ebp),%eax
  800faf:	8a 00                	mov    (%eax),%al
  800fb1:	0f be c0             	movsbl %al,%eax
  800fb4:	50                   	push   %eax
  800fb5:	ff 75 0c             	pushl  0xc(%ebp)
  800fb8:	e8 13 fb ff ff       	call   800ad0 <strchr>
  800fbd:	83 c4 08             	add    $0x8,%esp
  800fc0:	85 c0                	test   %eax,%eax
  800fc2:	75 d3                	jne    800f97 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800fc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc7:	8a 00                	mov    (%eax),%al
  800fc9:	84 c0                	test   %al,%al
  800fcb:	74 5a                	je     801027 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800fcd:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd0:	8b 00                	mov    (%eax),%eax
  800fd2:	83 f8 0f             	cmp    $0xf,%eax
  800fd5:	75 07                	jne    800fde <strsplit+0x6c>
		{
			return 0;
  800fd7:	b8 00 00 00 00       	mov    $0x0,%eax
  800fdc:	eb 66                	jmp    801044 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fde:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe1:	8b 00                	mov    (%eax),%eax
  800fe3:	8d 48 01             	lea    0x1(%eax),%ecx
  800fe6:	8b 55 14             	mov    0x14(%ebp),%edx
  800fe9:	89 0a                	mov    %ecx,(%edx)
  800feb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ff2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff5:	01 c2                	add    %eax,%edx
  800ff7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffa:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800ffc:	eb 03                	jmp    801001 <strsplit+0x8f>
			string++;
  800ffe:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801001:	8b 45 08             	mov    0x8(%ebp),%eax
  801004:	8a 00                	mov    (%eax),%al
  801006:	84 c0                	test   %al,%al
  801008:	74 8b                	je     800f95 <strsplit+0x23>
  80100a:	8b 45 08             	mov    0x8(%ebp),%eax
  80100d:	8a 00                	mov    (%eax),%al
  80100f:	0f be c0             	movsbl %al,%eax
  801012:	50                   	push   %eax
  801013:	ff 75 0c             	pushl  0xc(%ebp)
  801016:	e8 b5 fa ff ff       	call   800ad0 <strchr>
  80101b:	83 c4 08             	add    $0x8,%esp
  80101e:	85 c0                	test   %eax,%eax
  801020:	74 dc                	je     800ffe <strsplit+0x8c>
			string++;
	}
  801022:	e9 6e ff ff ff       	jmp    800f95 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801027:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801028:	8b 45 14             	mov    0x14(%ebp),%eax
  80102b:	8b 00                	mov    (%eax),%eax
  80102d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801034:	8b 45 10             	mov    0x10(%ebp),%eax
  801037:	01 d0                	add    %edx,%eax
  801039:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80103f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801044:	c9                   	leave  
  801045:	c3                   	ret    

00801046 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801046:	55                   	push   %ebp
  801047:	89 e5                	mov    %esp,%ebp
  801049:	57                   	push   %edi
  80104a:	56                   	push   %esi
  80104b:	53                   	push   %ebx
  80104c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80104f:	8b 45 08             	mov    0x8(%ebp),%eax
  801052:	8b 55 0c             	mov    0xc(%ebp),%edx
  801055:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801058:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80105b:	8b 7d 18             	mov    0x18(%ebp),%edi
  80105e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801061:	cd 30                	int    $0x30
  801063:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801066:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801069:	83 c4 10             	add    $0x10,%esp
  80106c:	5b                   	pop    %ebx
  80106d:	5e                   	pop    %esi
  80106e:	5f                   	pop    %edi
  80106f:	5d                   	pop    %ebp
  801070:	c3                   	ret    

00801071 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801071:	55                   	push   %ebp
  801072:	89 e5                	mov    %esp,%ebp
  801074:	83 ec 04             	sub    $0x4,%esp
  801077:	8b 45 10             	mov    0x10(%ebp),%eax
  80107a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80107d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801081:	8b 45 08             	mov    0x8(%ebp),%eax
  801084:	6a 00                	push   $0x0
  801086:	6a 00                	push   $0x0
  801088:	52                   	push   %edx
  801089:	ff 75 0c             	pushl  0xc(%ebp)
  80108c:	50                   	push   %eax
  80108d:	6a 00                	push   $0x0
  80108f:	e8 b2 ff ff ff       	call   801046 <syscall>
  801094:	83 c4 18             	add    $0x18,%esp
}
  801097:	90                   	nop
  801098:	c9                   	leave  
  801099:	c3                   	ret    

0080109a <sys_cgetc>:

int
sys_cgetc(void)
{
  80109a:	55                   	push   %ebp
  80109b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80109d:	6a 00                	push   $0x0
  80109f:	6a 00                	push   $0x0
  8010a1:	6a 00                	push   $0x0
  8010a3:	6a 00                	push   $0x0
  8010a5:	6a 00                	push   $0x0
  8010a7:	6a 01                	push   $0x1
  8010a9:	e8 98 ff ff ff       	call   801046 <syscall>
  8010ae:	83 c4 18             	add    $0x18,%esp
}
  8010b1:	c9                   	leave  
  8010b2:	c3                   	ret    

008010b3 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8010b3:	55                   	push   %ebp
  8010b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8010b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b9:	6a 00                	push   $0x0
  8010bb:	6a 00                	push   $0x0
  8010bd:	6a 00                	push   $0x0
  8010bf:	6a 00                	push   $0x0
  8010c1:	50                   	push   %eax
  8010c2:	6a 05                	push   $0x5
  8010c4:	e8 7d ff ff ff       	call   801046 <syscall>
  8010c9:	83 c4 18             	add    $0x18,%esp
}
  8010cc:	c9                   	leave  
  8010cd:	c3                   	ret    

008010ce <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010ce:	55                   	push   %ebp
  8010cf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010d1:	6a 00                	push   $0x0
  8010d3:	6a 00                	push   $0x0
  8010d5:	6a 00                	push   $0x0
  8010d7:	6a 00                	push   $0x0
  8010d9:	6a 00                	push   $0x0
  8010db:	6a 02                	push   $0x2
  8010dd:	e8 64 ff ff ff       	call   801046 <syscall>
  8010e2:	83 c4 18             	add    $0x18,%esp
}
  8010e5:	c9                   	leave  
  8010e6:	c3                   	ret    

008010e7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010e7:	55                   	push   %ebp
  8010e8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010ea:	6a 00                	push   $0x0
  8010ec:	6a 00                	push   $0x0
  8010ee:	6a 00                	push   $0x0
  8010f0:	6a 00                	push   $0x0
  8010f2:	6a 00                	push   $0x0
  8010f4:	6a 03                	push   $0x3
  8010f6:	e8 4b ff ff ff       	call   801046 <syscall>
  8010fb:	83 c4 18             	add    $0x18,%esp
}
  8010fe:	c9                   	leave  
  8010ff:	c3                   	ret    

00801100 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801100:	55                   	push   %ebp
  801101:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801103:	6a 00                	push   $0x0
  801105:	6a 00                	push   $0x0
  801107:	6a 00                	push   $0x0
  801109:	6a 00                	push   $0x0
  80110b:	6a 00                	push   $0x0
  80110d:	6a 04                	push   $0x4
  80110f:	e8 32 ff ff ff       	call   801046 <syscall>
  801114:	83 c4 18             	add    $0x18,%esp
}
  801117:	c9                   	leave  
  801118:	c3                   	ret    

00801119 <sys_env_exit>:


void sys_env_exit(void)
{
  801119:	55                   	push   %ebp
  80111a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80111c:	6a 00                	push   $0x0
  80111e:	6a 00                	push   $0x0
  801120:	6a 00                	push   $0x0
  801122:	6a 00                	push   $0x0
  801124:	6a 00                	push   $0x0
  801126:	6a 06                	push   $0x6
  801128:	e8 19 ff ff ff       	call   801046 <syscall>
  80112d:	83 c4 18             	add    $0x18,%esp
}
  801130:	90                   	nop
  801131:	c9                   	leave  
  801132:	c3                   	ret    

00801133 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801133:	55                   	push   %ebp
  801134:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801136:	8b 55 0c             	mov    0xc(%ebp),%edx
  801139:	8b 45 08             	mov    0x8(%ebp),%eax
  80113c:	6a 00                	push   $0x0
  80113e:	6a 00                	push   $0x0
  801140:	6a 00                	push   $0x0
  801142:	52                   	push   %edx
  801143:	50                   	push   %eax
  801144:	6a 07                	push   $0x7
  801146:	e8 fb fe ff ff       	call   801046 <syscall>
  80114b:	83 c4 18             	add    $0x18,%esp
}
  80114e:	c9                   	leave  
  80114f:	c3                   	ret    

00801150 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801150:	55                   	push   %ebp
  801151:	89 e5                	mov    %esp,%ebp
  801153:	56                   	push   %esi
  801154:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801155:	8b 75 18             	mov    0x18(%ebp),%esi
  801158:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80115b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80115e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801161:	8b 45 08             	mov    0x8(%ebp),%eax
  801164:	56                   	push   %esi
  801165:	53                   	push   %ebx
  801166:	51                   	push   %ecx
  801167:	52                   	push   %edx
  801168:	50                   	push   %eax
  801169:	6a 08                	push   $0x8
  80116b:	e8 d6 fe ff ff       	call   801046 <syscall>
  801170:	83 c4 18             	add    $0x18,%esp
}
  801173:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801176:	5b                   	pop    %ebx
  801177:	5e                   	pop    %esi
  801178:	5d                   	pop    %ebp
  801179:	c3                   	ret    

0080117a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80117a:	55                   	push   %ebp
  80117b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80117d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801180:	8b 45 08             	mov    0x8(%ebp),%eax
  801183:	6a 00                	push   $0x0
  801185:	6a 00                	push   $0x0
  801187:	6a 00                	push   $0x0
  801189:	52                   	push   %edx
  80118a:	50                   	push   %eax
  80118b:	6a 09                	push   $0x9
  80118d:	e8 b4 fe ff ff       	call   801046 <syscall>
  801192:	83 c4 18             	add    $0x18,%esp
}
  801195:	c9                   	leave  
  801196:	c3                   	ret    

00801197 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801197:	55                   	push   %ebp
  801198:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80119a:	6a 00                	push   $0x0
  80119c:	6a 00                	push   $0x0
  80119e:	6a 00                	push   $0x0
  8011a0:	ff 75 0c             	pushl  0xc(%ebp)
  8011a3:	ff 75 08             	pushl  0x8(%ebp)
  8011a6:	6a 0a                	push   $0xa
  8011a8:	e8 99 fe ff ff       	call   801046 <syscall>
  8011ad:	83 c4 18             	add    $0x18,%esp
}
  8011b0:	c9                   	leave  
  8011b1:	c3                   	ret    

008011b2 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8011b2:	55                   	push   %ebp
  8011b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8011b5:	6a 00                	push   $0x0
  8011b7:	6a 00                	push   $0x0
  8011b9:	6a 00                	push   $0x0
  8011bb:	6a 00                	push   $0x0
  8011bd:	6a 00                	push   $0x0
  8011bf:	6a 0b                	push   $0xb
  8011c1:	e8 80 fe ff ff       	call   801046 <syscall>
  8011c6:	83 c4 18             	add    $0x18,%esp
}
  8011c9:	c9                   	leave  
  8011ca:	c3                   	ret    

008011cb <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011cb:	55                   	push   %ebp
  8011cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011ce:	6a 00                	push   $0x0
  8011d0:	6a 00                	push   $0x0
  8011d2:	6a 00                	push   $0x0
  8011d4:	6a 00                	push   $0x0
  8011d6:	6a 00                	push   $0x0
  8011d8:	6a 0c                	push   $0xc
  8011da:	e8 67 fe ff ff       	call   801046 <syscall>
  8011df:	83 c4 18             	add    $0x18,%esp
}
  8011e2:	c9                   	leave  
  8011e3:	c3                   	ret    

008011e4 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011e4:	55                   	push   %ebp
  8011e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011e7:	6a 00                	push   $0x0
  8011e9:	6a 00                	push   $0x0
  8011eb:	6a 00                	push   $0x0
  8011ed:	6a 00                	push   $0x0
  8011ef:	6a 00                	push   $0x0
  8011f1:	6a 0d                	push   $0xd
  8011f3:	e8 4e fe ff ff       	call   801046 <syscall>
  8011f8:	83 c4 18             	add    $0x18,%esp
}
  8011fb:	c9                   	leave  
  8011fc:	c3                   	ret    

008011fd <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011fd:	55                   	push   %ebp
  8011fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801200:	6a 00                	push   $0x0
  801202:	6a 00                	push   $0x0
  801204:	6a 00                	push   $0x0
  801206:	ff 75 0c             	pushl  0xc(%ebp)
  801209:	ff 75 08             	pushl  0x8(%ebp)
  80120c:	6a 11                	push   $0x11
  80120e:	e8 33 fe ff ff       	call   801046 <syscall>
  801213:	83 c4 18             	add    $0x18,%esp
	return;
  801216:	90                   	nop
}
  801217:	c9                   	leave  
  801218:	c3                   	ret    

00801219 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801219:	55                   	push   %ebp
  80121a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80121c:	6a 00                	push   $0x0
  80121e:	6a 00                	push   $0x0
  801220:	6a 00                	push   $0x0
  801222:	ff 75 0c             	pushl  0xc(%ebp)
  801225:	ff 75 08             	pushl  0x8(%ebp)
  801228:	6a 12                	push   $0x12
  80122a:	e8 17 fe ff ff       	call   801046 <syscall>
  80122f:	83 c4 18             	add    $0x18,%esp
	return ;
  801232:	90                   	nop
}
  801233:	c9                   	leave  
  801234:	c3                   	ret    

00801235 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801235:	55                   	push   %ebp
  801236:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801238:	6a 00                	push   $0x0
  80123a:	6a 00                	push   $0x0
  80123c:	6a 00                	push   $0x0
  80123e:	6a 00                	push   $0x0
  801240:	6a 00                	push   $0x0
  801242:	6a 0e                	push   $0xe
  801244:	e8 fd fd ff ff       	call   801046 <syscall>
  801249:	83 c4 18             	add    $0x18,%esp
}
  80124c:	c9                   	leave  
  80124d:	c3                   	ret    

0080124e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80124e:	55                   	push   %ebp
  80124f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801251:	6a 00                	push   $0x0
  801253:	6a 00                	push   $0x0
  801255:	6a 00                	push   $0x0
  801257:	6a 00                	push   $0x0
  801259:	ff 75 08             	pushl  0x8(%ebp)
  80125c:	6a 0f                	push   $0xf
  80125e:	e8 e3 fd ff ff       	call   801046 <syscall>
  801263:	83 c4 18             	add    $0x18,%esp
}
  801266:	c9                   	leave  
  801267:	c3                   	ret    

00801268 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801268:	55                   	push   %ebp
  801269:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80126b:	6a 00                	push   $0x0
  80126d:	6a 00                	push   $0x0
  80126f:	6a 00                	push   $0x0
  801271:	6a 00                	push   $0x0
  801273:	6a 00                	push   $0x0
  801275:	6a 10                	push   $0x10
  801277:	e8 ca fd ff ff       	call   801046 <syscall>
  80127c:	83 c4 18             	add    $0x18,%esp
}
  80127f:	90                   	nop
  801280:	c9                   	leave  
  801281:	c3                   	ret    

00801282 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801282:	55                   	push   %ebp
  801283:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801285:	6a 00                	push   $0x0
  801287:	6a 00                	push   $0x0
  801289:	6a 00                	push   $0x0
  80128b:	6a 00                	push   $0x0
  80128d:	6a 00                	push   $0x0
  80128f:	6a 14                	push   $0x14
  801291:	e8 b0 fd ff ff       	call   801046 <syscall>
  801296:	83 c4 18             	add    $0x18,%esp
}
  801299:	90                   	nop
  80129a:	c9                   	leave  
  80129b:	c3                   	ret    

0080129c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80129c:	55                   	push   %ebp
  80129d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80129f:	6a 00                	push   $0x0
  8012a1:	6a 00                	push   $0x0
  8012a3:	6a 00                	push   $0x0
  8012a5:	6a 00                	push   $0x0
  8012a7:	6a 00                	push   $0x0
  8012a9:	6a 15                	push   $0x15
  8012ab:	e8 96 fd ff ff       	call   801046 <syscall>
  8012b0:	83 c4 18             	add    $0x18,%esp
}
  8012b3:	90                   	nop
  8012b4:	c9                   	leave  
  8012b5:	c3                   	ret    

008012b6 <sys_cputc>:


void
sys_cputc(const char c)
{
  8012b6:	55                   	push   %ebp
  8012b7:	89 e5                	mov    %esp,%ebp
  8012b9:	83 ec 04             	sub    $0x4,%esp
  8012bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8012c2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012c6:	6a 00                	push   $0x0
  8012c8:	6a 00                	push   $0x0
  8012ca:	6a 00                	push   $0x0
  8012cc:	6a 00                	push   $0x0
  8012ce:	50                   	push   %eax
  8012cf:	6a 16                	push   $0x16
  8012d1:	e8 70 fd ff ff       	call   801046 <syscall>
  8012d6:	83 c4 18             	add    $0x18,%esp
}
  8012d9:	90                   	nop
  8012da:	c9                   	leave  
  8012db:	c3                   	ret    

008012dc <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012dc:	55                   	push   %ebp
  8012dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012df:	6a 00                	push   $0x0
  8012e1:	6a 00                	push   $0x0
  8012e3:	6a 00                	push   $0x0
  8012e5:	6a 00                	push   $0x0
  8012e7:	6a 00                	push   $0x0
  8012e9:	6a 17                	push   $0x17
  8012eb:	e8 56 fd ff ff       	call   801046 <syscall>
  8012f0:	83 c4 18             	add    $0x18,%esp
}
  8012f3:	90                   	nop
  8012f4:	c9                   	leave  
  8012f5:	c3                   	ret    

008012f6 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012f6:	55                   	push   %ebp
  8012f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fc:	6a 00                	push   $0x0
  8012fe:	6a 00                	push   $0x0
  801300:	6a 00                	push   $0x0
  801302:	ff 75 0c             	pushl  0xc(%ebp)
  801305:	50                   	push   %eax
  801306:	6a 18                	push   $0x18
  801308:	e8 39 fd ff ff       	call   801046 <syscall>
  80130d:	83 c4 18             	add    $0x18,%esp
}
  801310:	c9                   	leave  
  801311:	c3                   	ret    

00801312 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801312:	55                   	push   %ebp
  801313:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801315:	8b 55 0c             	mov    0xc(%ebp),%edx
  801318:	8b 45 08             	mov    0x8(%ebp),%eax
  80131b:	6a 00                	push   $0x0
  80131d:	6a 00                	push   $0x0
  80131f:	6a 00                	push   $0x0
  801321:	52                   	push   %edx
  801322:	50                   	push   %eax
  801323:	6a 1b                	push   $0x1b
  801325:	e8 1c fd ff ff       	call   801046 <syscall>
  80132a:	83 c4 18             	add    $0x18,%esp
}
  80132d:	c9                   	leave  
  80132e:	c3                   	ret    

0080132f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80132f:	55                   	push   %ebp
  801330:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801332:	8b 55 0c             	mov    0xc(%ebp),%edx
  801335:	8b 45 08             	mov    0x8(%ebp),%eax
  801338:	6a 00                	push   $0x0
  80133a:	6a 00                	push   $0x0
  80133c:	6a 00                	push   $0x0
  80133e:	52                   	push   %edx
  80133f:	50                   	push   %eax
  801340:	6a 19                	push   $0x19
  801342:	e8 ff fc ff ff       	call   801046 <syscall>
  801347:	83 c4 18             	add    $0x18,%esp
}
  80134a:	90                   	nop
  80134b:	c9                   	leave  
  80134c:	c3                   	ret    

0080134d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80134d:	55                   	push   %ebp
  80134e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801350:	8b 55 0c             	mov    0xc(%ebp),%edx
  801353:	8b 45 08             	mov    0x8(%ebp),%eax
  801356:	6a 00                	push   $0x0
  801358:	6a 00                	push   $0x0
  80135a:	6a 00                	push   $0x0
  80135c:	52                   	push   %edx
  80135d:	50                   	push   %eax
  80135e:	6a 1a                	push   $0x1a
  801360:	e8 e1 fc ff ff       	call   801046 <syscall>
  801365:	83 c4 18             	add    $0x18,%esp
}
  801368:	90                   	nop
  801369:	c9                   	leave  
  80136a:	c3                   	ret    

0080136b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80136b:	55                   	push   %ebp
  80136c:	89 e5                	mov    %esp,%ebp
  80136e:	83 ec 04             	sub    $0x4,%esp
  801371:	8b 45 10             	mov    0x10(%ebp),%eax
  801374:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801377:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80137a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80137e:	8b 45 08             	mov    0x8(%ebp),%eax
  801381:	6a 00                	push   $0x0
  801383:	51                   	push   %ecx
  801384:	52                   	push   %edx
  801385:	ff 75 0c             	pushl  0xc(%ebp)
  801388:	50                   	push   %eax
  801389:	6a 1c                	push   $0x1c
  80138b:	e8 b6 fc ff ff       	call   801046 <syscall>
  801390:	83 c4 18             	add    $0x18,%esp
}
  801393:	c9                   	leave  
  801394:	c3                   	ret    

00801395 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801395:	55                   	push   %ebp
  801396:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801398:	8b 55 0c             	mov    0xc(%ebp),%edx
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	6a 00                	push   $0x0
  8013a0:	6a 00                	push   $0x0
  8013a2:	6a 00                	push   $0x0
  8013a4:	52                   	push   %edx
  8013a5:	50                   	push   %eax
  8013a6:	6a 1d                	push   $0x1d
  8013a8:	e8 99 fc ff ff       	call   801046 <syscall>
  8013ad:	83 c4 18             	add    $0x18,%esp
}
  8013b0:	c9                   	leave  
  8013b1:	c3                   	ret    

008013b2 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8013b2:	55                   	push   %ebp
  8013b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8013b5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013be:	6a 00                	push   $0x0
  8013c0:	6a 00                	push   $0x0
  8013c2:	51                   	push   %ecx
  8013c3:	52                   	push   %edx
  8013c4:	50                   	push   %eax
  8013c5:	6a 1e                	push   $0x1e
  8013c7:	e8 7a fc ff ff       	call   801046 <syscall>
  8013cc:	83 c4 18             	add    $0x18,%esp
}
  8013cf:	c9                   	leave  
  8013d0:	c3                   	ret    

008013d1 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013d1:	55                   	push   %ebp
  8013d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013da:	6a 00                	push   $0x0
  8013dc:	6a 00                	push   $0x0
  8013de:	6a 00                	push   $0x0
  8013e0:	52                   	push   %edx
  8013e1:	50                   	push   %eax
  8013e2:	6a 1f                	push   $0x1f
  8013e4:	e8 5d fc ff ff       	call   801046 <syscall>
  8013e9:	83 c4 18             	add    $0x18,%esp
}
  8013ec:	c9                   	leave  
  8013ed:	c3                   	ret    

008013ee <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013ee:	55                   	push   %ebp
  8013ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013f1:	6a 00                	push   $0x0
  8013f3:	6a 00                	push   $0x0
  8013f5:	6a 00                	push   $0x0
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 20                	push   $0x20
  8013fd:	e8 44 fc ff ff       	call   801046 <syscall>
  801402:	83 c4 18             	add    $0x18,%esp
}
  801405:	c9                   	leave  
  801406:	c3                   	ret    

00801407 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801407:	55                   	push   %ebp
  801408:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80140a:	8b 45 08             	mov    0x8(%ebp),%eax
  80140d:	6a 00                	push   $0x0
  80140f:	ff 75 14             	pushl  0x14(%ebp)
  801412:	ff 75 10             	pushl  0x10(%ebp)
  801415:	ff 75 0c             	pushl  0xc(%ebp)
  801418:	50                   	push   %eax
  801419:	6a 21                	push   $0x21
  80141b:	e8 26 fc ff ff       	call   801046 <syscall>
  801420:	83 c4 18             	add    $0x18,%esp
}
  801423:	c9                   	leave  
  801424:	c3                   	ret    

00801425 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801425:	55                   	push   %ebp
  801426:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801428:	8b 45 08             	mov    0x8(%ebp),%eax
  80142b:	6a 00                	push   $0x0
  80142d:	6a 00                	push   $0x0
  80142f:	6a 00                	push   $0x0
  801431:	6a 00                	push   $0x0
  801433:	50                   	push   %eax
  801434:	6a 22                	push   $0x22
  801436:	e8 0b fc ff ff       	call   801046 <syscall>
  80143b:	83 c4 18             	add    $0x18,%esp
}
  80143e:	90                   	nop
  80143f:	c9                   	leave  
  801440:	c3                   	ret    

00801441 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801441:	55                   	push   %ebp
  801442:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801444:	8b 45 08             	mov    0x8(%ebp),%eax
  801447:	6a 00                	push   $0x0
  801449:	6a 00                	push   $0x0
  80144b:	6a 00                	push   $0x0
  80144d:	6a 00                	push   $0x0
  80144f:	50                   	push   %eax
  801450:	6a 23                	push   $0x23
  801452:	e8 ef fb ff ff       	call   801046 <syscall>
  801457:	83 c4 18             	add    $0x18,%esp
}
  80145a:	90                   	nop
  80145b:	c9                   	leave  
  80145c:	c3                   	ret    

0080145d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80145d:	55                   	push   %ebp
  80145e:	89 e5                	mov    %esp,%ebp
  801460:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801463:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801466:	8d 50 04             	lea    0x4(%eax),%edx
  801469:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80146c:	6a 00                	push   $0x0
  80146e:	6a 00                	push   $0x0
  801470:	6a 00                	push   $0x0
  801472:	52                   	push   %edx
  801473:	50                   	push   %eax
  801474:	6a 24                	push   $0x24
  801476:	e8 cb fb ff ff       	call   801046 <syscall>
  80147b:	83 c4 18             	add    $0x18,%esp
	return result;
  80147e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801481:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801484:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801487:	89 01                	mov    %eax,(%ecx)
  801489:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80148c:	8b 45 08             	mov    0x8(%ebp),%eax
  80148f:	c9                   	leave  
  801490:	c2 04 00             	ret    $0x4

00801493 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801493:	55                   	push   %ebp
  801494:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	ff 75 10             	pushl  0x10(%ebp)
  80149d:	ff 75 0c             	pushl  0xc(%ebp)
  8014a0:	ff 75 08             	pushl  0x8(%ebp)
  8014a3:	6a 13                	push   $0x13
  8014a5:	e8 9c fb ff ff       	call   801046 <syscall>
  8014aa:	83 c4 18             	add    $0x18,%esp
	return ;
  8014ad:	90                   	nop
}
  8014ae:	c9                   	leave  
  8014af:	c3                   	ret    

008014b0 <sys_rcr2>:
uint32 sys_rcr2()
{
  8014b0:	55                   	push   %ebp
  8014b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 25                	push   $0x25
  8014bf:	e8 82 fb ff ff       	call   801046 <syscall>
  8014c4:	83 c4 18             	add    $0x18,%esp
}
  8014c7:	c9                   	leave  
  8014c8:	c3                   	ret    

008014c9 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014c9:	55                   	push   %ebp
  8014ca:	89 e5                	mov    %esp,%ebp
  8014cc:	83 ec 04             	sub    $0x4,%esp
  8014cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014d5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	50                   	push   %eax
  8014e2:	6a 26                	push   $0x26
  8014e4:	e8 5d fb ff ff       	call   801046 <syscall>
  8014e9:	83 c4 18             	add    $0x18,%esp
	return ;
  8014ec:	90                   	nop
}
  8014ed:	c9                   	leave  
  8014ee:	c3                   	ret    

008014ef <rsttst>:
void rsttst()
{
  8014ef:	55                   	push   %ebp
  8014f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 28                	push   $0x28
  8014fe:	e8 43 fb ff ff       	call   801046 <syscall>
  801503:	83 c4 18             	add    $0x18,%esp
	return ;
  801506:	90                   	nop
}
  801507:	c9                   	leave  
  801508:	c3                   	ret    

00801509 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801509:	55                   	push   %ebp
  80150a:	89 e5                	mov    %esp,%ebp
  80150c:	83 ec 04             	sub    $0x4,%esp
  80150f:	8b 45 14             	mov    0x14(%ebp),%eax
  801512:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801515:	8b 55 18             	mov    0x18(%ebp),%edx
  801518:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80151c:	52                   	push   %edx
  80151d:	50                   	push   %eax
  80151e:	ff 75 10             	pushl  0x10(%ebp)
  801521:	ff 75 0c             	pushl  0xc(%ebp)
  801524:	ff 75 08             	pushl  0x8(%ebp)
  801527:	6a 27                	push   $0x27
  801529:	e8 18 fb ff ff       	call   801046 <syscall>
  80152e:	83 c4 18             	add    $0x18,%esp
	return ;
  801531:	90                   	nop
}
  801532:	c9                   	leave  
  801533:	c3                   	ret    

00801534 <chktst>:
void chktst(uint32 n)
{
  801534:	55                   	push   %ebp
  801535:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801537:	6a 00                	push   $0x0
  801539:	6a 00                	push   $0x0
  80153b:	6a 00                	push   $0x0
  80153d:	6a 00                	push   $0x0
  80153f:	ff 75 08             	pushl  0x8(%ebp)
  801542:	6a 29                	push   $0x29
  801544:	e8 fd fa ff ff       	call   801046 <syscall>
  801549:	83 c4 18             	add    $0x18,%esp
	return ;
  80154c:	90                   	nop
}
  80154d:	c9                   	leave  
  80154e:	c3                   	ret    

0080154f <inctst>:

void inctst()
{
  80154f:	55                   	push   %ebp
  801550:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801552:	6a 00                	push   $0x0
  801554:	6a 00                	push   $0x0
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 2a                	push   $0x2a
  80155e:	e8 e3 fa ff ff       	call   801046 <syscall>
  801563:	83 c4 18             	add    $0x18,%esp
	return ;
  801566:	90                   	nop
}
  801567:	c9                   	leave  
  801568:	c3                   	ret    

00801569 <gettst>:
uint32 gettst()
{
  801569:	55                   	push   %ebp
  80156a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	6a 00                	push   $0x0
  801574:	6a 00                	push   $0x0
  801576:	6a 2b                	push   $0x2b
  801578:	e8 c9 fa ff ff       	call   801046 <syscall>
  80157d:	83 c4 18             	add    $0x18,%esp
}
  801580:	c9                   	leave  
  801581:	c3                   	ret    

00801582 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801582:	55                   	push   %ebp
  801583:	89 e5                	mov    %esp,%ebp
  801585:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801588:	6a 00                	push   $0x0
  80158a:	6a 00                	push   $0x0
  80158c:	6a 00                	push   $0x0
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	6a 2c                	push   $0x2c
  801594:	e8 ad fa ff ff       	call   801046 <syscall>
  801599:	83 c4 18             	add    $0x18,%esp
  80159c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80159f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8015a3:	75 07                	jne    8015ac <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8015a5:	b8 01 00 00 00       	mov    $0x1,%eax
  8015aa:	eb 05                	jmp    8015b1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8015ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015b1:	c9                   	leave  
  8015b2:	c3                   	ret    

008015b3 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8015b3:	55                   	push   %ebp
  8015b4:	89 e5                	mov    %esp,%ebp
  8015b6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015b9:	6a 00                	push   $0x0
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 2c                	push   $0x2c
  8015c5:	e8 7c fa ff ff       	call   801046 <syscall>
  8015ca:	83 c4 18             	add    $0x18,%esp
  8015cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015d0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015d4:	75 07                	jne    8015dd <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015d6:	b8 01 00 00 00       	mov    $0x1,%eax
  8015db:	eb 05                	jmp    8015e2 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015dd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015e2:	c9                   	leave  
  8015e3:	c3                   	ret    

008015e4 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015e4:	55                   	push   %ebp
  8015e5:	89 e5                	mov    %esp,%ebp
  8015e7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015ea:	6a 00                	push   $0x0
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 2c                	push   $0x2c
  8015f6:	e8 4b fa ff ff       	call   801046 <syscall>
  8015fb:	83 c4 18             	add    $0x18,%esp
  8015fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801601:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801605:	75 07                	jne    80160e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801607:	b8 01 00 00 00       	mov    $0x1,%eax
  80160c:	eb 05                	jmp    801613 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80160e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801613:	c9                   	leave  
  801614:	c3                   	ret    

00801615 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801615:	55                   	push   %ebp
  801616:	89 e5                	mov    %esp,%ebp
  801618:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80161b:	6a 00                	push   $0x0
  80161d:	6a 00                	push   $0x0
  80161f:	6a 00                	push   $0x0
  801621:	6a 00                	push   $0x0
  801623:	6a 00                	push   $0x0
  801625:	6a 2c                	push   $0x2c
  801627:	e8 1a fa ff ff       	call   801046 <syscall>
  80162c:	83 c4 18             	add    $0x18,%esp
  80162f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801632:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801636:	75 07                	jne    80163f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801638:	b8 01 00 00 00       	mov    $0x1,%eax
  80163d:	eb 05                	jmp    801644 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80163f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801644:	c9                   	leave  
  801645:	c3                   	ret    

00801646 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801646:	55                   	push   %ebp
  801647:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	ff 75 08             	pushl  0x8(%ebp)
  801654:	6a 2d                	push   $0x2d
  801656:	e8 eb f9 ff ff       	call   801046 <syscall>
  80165b:	83 c4 18             	add    $0x18,%esp
	return ;
  80165e:	90                   	nop
}
  80165f:	c9                   	leave  
  801660:	c3                   	ret    

00801661 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801661:	55                   	push   %ebp
  801662:	89 e5                	mov    %esp,%ebp
  801664:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801665:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801668:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80166b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80166e:	8b 45 08             	mov    0x8(%ebp),%eax
  801671:	6a 00                	push   $0x0
  801673:	53                   	push   %ebx
  801674:	51                   	push   %ecx
  801675:	52                   	push   %edx
  801676:	50                   	push   %eax
  801677:	6a 2e                	push   $0x2e
  801679:	e8 c8 f9 ff ff       	call   801046 <syscall>
  80167e:	83 c4 18             	add    $0x18,%esp
}
  801681:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801684:	c9                   	leave  
  801685:	c3                   	ret    

00801686 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801686:	55                   	push   %ebp
  801687:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801689:	8b 55 0c             	mov    0xc(%ebp),%edx
  80168c:	8b 45 08             	mov    0x8(%ebp),%eax
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	6a 00                	push   $0x0
  801695:	52                   	push   %edx
  801696:	50                   	push   %eax
  801697:	6a 2f                	push   $0x2f
  801699:	e8 a8 f9 ff ff       	call   801046 <syscall>
  80169e:	83 c4 18             	add    $0x18,%esp
}
  8016a1:	c9                   	leave  
  8016a2:	c3                   	ret    

008016a3 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8016a3:	55                   	push   %ebp
  8016a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8016a6:	6a 00                	push   $0x0
  8016a8:	6a 00                	push   $0x0
  8016aa:	6a 00                	push   $0x0
  8016ac:	ff 75 0c             	pushl  0xc(%ebp)
  8016af:	ff 75 08             	pushl  0x8(%ebp)
  8016b2:	6a 30                	push   $0x30
  8016b4:	e8 8d f9 ff ff       	call   801046 <syscall>
  8016b9:	83 c4 18             	add    $0x18,%esp
	return ;
  8016bc:	90                   	nop
}
  8016bd:	c9                   	leave  
  8016be:	c3                   	ret    
  8016bf:	90                   	nop

008016c0 <__udivdi3>:
  8016c0:	55                   	push   %ebp
  8016c1:	57                   	push   %edi
  8016c2:	56                   	push   %esi
  8016c3:	53                   	push   %ebx
  8016c4:	83 ec 1c             	sub    $0x1c,%esp
  8016c7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8016cb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8016cf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016d3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8016d7:	89 ca                	mov    %ecx,%edx
  8016d9:	89 f8                	mov    %edi,%eax
  8016db:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8016df:	85 f6                	test   %esi,%esi
  8016e1:	75 2d                	jne    801710 <__udivdi3+0x50>
  8016e3:	39 cf                	cmp    %ecx,%edi
  8016e5:	77 65                	ja     80174c <__udivdi3+0x8c>
  8016e7:	89 fd                	mov    %edi,%ebp
  8016e9:	85 ff                	test   %edi,%edi
  8016eb:	75 0b                	jne    8016f8 <__udivdi3+0x38>
  8016ed:	b8 01 00 00 00       	mov    $0x1,%eax
  8016f2:	31 d2                	xor    %edx,%edx
  8016f4:	f7 f7                	div    %edi
  8016f6:	89 c5                	mov    %eax,%ebp
  8016f8:	31 d2                	xor    %edx,%edx
  8016fa:	89 c8                	mov    %ecx,%eax
  8016fc:	f7 f5                	div    %ebp
  8016fe:	89 c1                	mov    %eax,%ecx
  801700:	89 d8                	mov    %ebx,%eax
  801702:	f7 f5                	div    %ebp
  801704:	89 cf                	mov    %ecx,%edi
  801706:	89 fa                	mov    %edi,%edx
  801708:	83 c4 1c             	add    $0x1c,%esp
  80170b:	5b                   	pop    %ebx
  80170c:	5e                   	pop    %esi
  80170d:	5f                   	pop    %edi
  80170e:	5d                   	pop    %ebp
  80170f:	c3                   	ret    
  801710:	39 ce                	cmp    %ecx,%esi
  801712:	77 28                	ja     80173c <__udivdi3+0x7c>
  801714:	0f bd fe             	bsr    %esi,%edi
  801717:	83 f7 1f             	xor    $0x1f,%edi
  80171a:	75 40                	jne    80175c <__udivdi3+0x9c>
  80171c:	39 ce                	cmp    %ecx,%esi
  80171e:	72 0a                	jb     80172a <__udivdi3+0x6a>
  801720:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801724:	0f 87 9e 00 00 00    	ja     8017c8 <__udivdi3+0x108>
  80172a:	b8 01 00 00 00       	mov    $0x1,%eax
  80172f:	89 fa                	mov    %edi,%edx
  801731:	83 c4 1c             	add    $0x1c,%esp
  801734:	5b                   	pop    %ebx
  801735:	5e                   	pop    %esi
  801736:	5f                   	pop    %edi
  801737:	5d                   	pop    %ebp
  801738:	c3                   	ret    
  801739:	8d 76 00             	lea    0x0(%esi),%esi
  80173c:	31 ff                	xor    %edi,%edi
  80173e:	31 c0                	xor    %eax,%eax
  801740:	89 fa                	mov    %edi,%edx
  801742:	83 c4 1c             	add    $0x1c,%esp
  801745:	5b                   	pop    %ebx
  801746:	5e                   	pop    %esi
  801747:	5f                   	pop    %edi
  801748:	5d                   	pop    %ebp
  801749:	c3                   	ret    
  80174a:	66 90                	xchg   %ax,%ax
  80174c:	89 d8                	mov    %ebx,%eax
  80174e:	f7 f7                	div    %edi
  801750:	31 ff                	xor    %edi,%edi
  801752:	89 fa                	mov    %edi,%edx
  801754:	83 c4 1c             	add    $0x1c,%esp
  801757:	5b                   	pop    %ebx
  801758:	5e                   	pop    %esi
  801759:	5f                   	pop    %edi
  80175a:	5d                   	pop    %ebp
  80175b:	c3                   	ret    
  80175c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801761:	89 eb                	mov    %ebp,%ebx
  801763:	29 fb                	sub    %edi,%ebx
  801765:	89 f9                	mov    %edi,%ecx
  801767:	d3 e6                	shl    %cl,%esi
  801769:	89 c5                	mov    %eax,%ebp
  80176b:	88 d9                	mov    %bl,%cl
  80176d:	d3 ed                	shr    %cl,%ebp
  80176f:	89 e9                	mov    %ebp,%ecx
  801771:	09 f1                	or     %esi,%ecx
  801773:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801777:	89 f9                	mov    %edi,%ecx
  801779:	d3 e0                	shl    %cl,%eax
  80177b:	89 c5                	mov    %eax,%ebp
  80177d:	89 d6                	mov    %edx,%esi
  80177f:	88 d9                	mov    %bl,%cl
  801781:	d3 ee                	shr    %cl,%esi
  801783:	89 f9                	mov    %edi,%ecx
  801785:	d3 e2                	shl    %cl,%edx
  801787:	8b 44 24 08          	mov    0x8(%esp),%eax
  80178b:	88 d9                	mov    %bl,%cl
  80178d:	d3 e8                	shr    %cl,%eax
  80178f:	09 c2                	or     %eax,%edx
  801791:	89 d0                	mov    %edx,%eax
  801793:	89 f2                	mov    %esi,%edx
  801795:	f7 74 24 0c          	divl   0xc(%esp)
  801799:	89 d6                	mov    %edx,%esi
  80179b:	89 c3                	mov    %eax,%ebx
  80179d:	f7 e5                	mul    %ebp
  80179f:	39 d6                	cmp    %edx,%esi
  8017a1:	72 19                	jb     8017bc <__udivdi3+0xfc>
  8017a3:	74 0b                	je     8017b0 <__udivdi3+0xf0>
  8017a5:	89 d8                	mov    %ebx,%eax
  8017a7:	31 ff                	xor    %edi,%edi
  8017a9:	e9 58 ff ff ff       	jmp    801706 <__udivdi3+0x46>
  8017ae:	66 90                	xchg   %ax,%ax
  8017b0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8017b4:	89 f9                	mov    %edi,%ecx
  8017b6:	d3 e2                	shl    %cl,%edx
  8017b8:	39 c2                	cmp    %eax,%edx
  8017ba:	73 e9                	jae    8017a5 <__udivdi3+0xe5>
  8017bc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8017bf:	31 ff                	xor    %edi,%edi
  8017c1:	e9 40 ff ff ff       	jmp    801706 <__udivdi3+0x46>
  8017c6:	66 90                	xchg   %ax,%ax
  8017c8:	31 c0                	xor    %eax,%eax
  8017ca:	e9 37 ff ff ff       	jmp    801706 <__udivdi3+0x46>
  8017cf:	90                   	nop

008017d0 <__umoddi3>:
  8017d0:	55                   	push   %ebp
  8017d1:	57                   	push   %edi
  8017d2:	56                   	push   %esi
  8017d3:	53                   	push   %ebx
  8017d4:	83 ec 1c             	sub    $0x1c,%esp
  8017d7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8017db:	8b 74 24 34          	mov    0x34(%esp),%esi
  8017df:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017e3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8017e7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8017eb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8017ef:	89 f3                	mov    %esi,%ebx
  8017f1:	89 fa                	mov    %edi,%edx
  8017f3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8017f7:	89 34 24             	mov    %esi,(%esp)
  8017fa:	85 c0                	test   %eax,%eax
  8017fc:	75 1a                	jne    801818 <__umoddi3+0x48>
  8017fe:	39 f7                	cmp    %esi,%edi
  801800:	0f 86 a2 00 00 00    	jbe    8018a8 <__umoddi3+0xd8>
  801806:	89 c8                	mov    %ecx,%eax
  801808:	89 f2                	mov    %esi,%edx
  80180a:	f7 f7                	div    %edi
  80180c:	89 d0                	mov    %edx,%eax
  80180e:	31 d2                	xor    %edx,%edx
  801810:	83 c4 1c             	add    $0x1c,%esp
  801813:	5b                   	pop    %ebx
  801814:	5e                   	pop    %esi
  801815:	5f                   	pop    %edi
  801816:	5d                   	pop    %ebp
  801817:	c3                   	ret    
  801818:	39 f0                	cmp    %esi,%eax
  80181a:	0f 87 ac 00 00 00    	ja     8018cc <__umoddi3+0xfc>
  801820:	0f bd e8             	bsr    %eax,%ebp
  801823:	83 f5 1f             	xor    $0x1f,%ebp
  801826:	0f 84 ac 00 00 00    	je     8018d8 <__umoddi3+0x108>
  80182c:	bf 20 00 00 00       	mov    $0x20,%edi
  801831:	29 ef                	sub    %ebp,%edi
  801833:	89 fe                	mov    %edi,%esi
  801835:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801839:	89 e9                	mov    %ebp,%ecx
  80183b:	d3 e0                	shl    %cl,%eax
  80183d:	89 d7                	mov    %edx,%edi
  80183f:	89 f1                	mov    %esi,%ecx
  801841:	d3 ef                	shr    %cl,%edi
  801843:	09 c7                	or     %eax,%edi
  801845:	89 e9                	mov    %ebp,%ecx
  801847:	d3 e2                	shl    %cl,%edx
  801849:	89 14 24             	mov    %edx,(%esp)
  80184c:	89 d8                	mov    %ebx,%eax
  80184e:	d3 e0                	shl    %cl,%eax
  801850:	89 c2                	mov    %eax,%edx
  801852:	8b 44 24 08          	mov    0x8(%esp),%eax
  801856:	d3 e0                	shl    %cl,%eax
  801858:	89 44 24 04          	mov    %eax,0x4(%esp)
  80185c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801860:	89 f1                	mov    %esi,%ecx
  801862:	d3 e8                	shr    %cl,%eax
  801864:	09 d0                	or     %edx,%eax
  801866:	d3 eb                	shr    %cl,%ebx
  801868:	89 da                	mov    %ebx,%edx
  80186a:	f7 f7                	div    %edi
  80186c:	89 d3                	mov    %edx,%ebx
  80186e:	f7 24 24             	mull   (%esp)
  801871:	89 c6                	mov    %eax,%esi
  801873:	89 d1                	mov    %edx,%ecx
  801875:	39 d3                	cmp    %edx,%ebx
  801877:	0f 82 87 00 00 00    	jb     801904 <__umoddi3+0x134>
  80187d:	0f 84 91 00 00 00    	je     801914 <__umoddi3+0x144>
  801883:	8b 54 24 04          	mov    0x4(%esp),%edx
  801887:	29 f2                	sub    %esi,%edx
  801889:	19 cb                	sbb    %ecx,%ebx
  80188b:	89 d8                	mov    %ebx,%eax
  80188d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801891:	d3 e0                	shl    %cl,%eax
  801893:	89 e9                	mov    %ebp,%ecx
  801895:	d3 ea                	shr    %cl,%edx
  801897:	09 d0                	or     %edx,%eax
  801899:	89 e9                	mov    %ebp,%ecx
  80189b:	d3 eb                	shr    %cl,%ebx
  80189d:	89 da                	mov    %ebx,%edx
  80189f:	83 c4 1c             	add    $0x1c,%esp
  8018a2:	5b                   	pop    %ebx
  8018a3:	5e                   	pop    %esi
  8018a4:	5f                   	pop    %edi
  8018a5:	5d                   	pop    %ebp
  8018a6:	c3                   	ret    
  8018a7:	90                   	nop
  8018a8:	89 fd                	mov    %edi,%ebp
  8018aa:	85 ff                	test   %edi,%edi
  8018ac:	75 0b                	jne    8018b9 <__umoddi3+0xe9>
  8018ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8018b3:	31 d2                	xor    %edx,%edx
  8018b5:	f7 f7                	div    %edi
  8018b7:	89 c5                	mov    %eax,%ebp
  8018b9:	89 f0                	mov    %esi,%eax
  8018bb:	31 d2                	xor    %edx,%edx
  8018bd:	f7 f5                	div    %ebp
  8018bf:	89 c8                	mov    %ecx,%eax
  8018c1:	f7 f5                	div    %ebp
  8018c3:	89 d0                	mov    %edx,%eax
  8018c5:	e9 44 ff ff ff       	jmp    80180e <__umoddi3+0x3e>
  8018ca:	66 90                	xchg   %ax,%ax
  8018cc:	89 c8                	mov    %ecx,%eax
  8018ce:	89 f2                	mov    %esi,%edx
  8018d0:	83 c4 1c             	add    $0x1c,%esp
  8018d3:	5b                   	pop    %ebx
  8018d4:	5e                   	pop    %esi
  8018d5:	5f                   	pop    %edi
  8018d6:	5d                   	pop    %ebp
  8018d7:	c3                   	ret    
  8018d8:	3b 04 24             	cmp    (%esp),%eax
  8018db:	72 06                	jb     8018e3 <__umoddi3+0x113>
  8018dd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8018e1:	77 0f                	ja     8018f2 <__umoddi3+0x122>
  8018e3:	89 f2                	mov    %esi,%edx
  8018e5:	29 f9                	sub    %edi,%ecx
  8018e7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8018eb:	89 14 24             	mov    %edx,(%esp)
  8018ee:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018f2:	8b 44 24 04          	mov    0x4(%esp),%eax
  8018f6:	8b 14 24             	mov    (%esp),%edx
  8018f9:	83 c4 1c             	add    $0x1c,%esp
  8018fc:	5b                   	pop    %ebx
  8018fd:	5e                   	pop    %esi
  8018fe:	5f                   	pop    %edi
  8018ff:	5d                   	pop    %ebp
  801900:	c3                   	ret    
  801901:	8d 76 00             	lea    0x0(%esi),%esi
  801904:	2b 04 24             	sub    (%esp),%eax
  801907:	19 fa                	sbb    %edi,%edx
  801909:	89 d1                	mov    %edx,%ecx
  80190b:	89 c6                	mov    %eax,%esi
  80190d:	e9 71 ff ff ff       	jmp    801883 <__umoddi3+0xb3>
  801912:	66 90                	xchg   %ax,%ax
  801914:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801918:	72 ea                	jb     801904 <__umoddi3+0x134>
  80191a:	89 d9                	mov    %ebx,%ecx
  80191c:	e9 62 ff ff ff       	jmp    801883 <__umoddi3+0xb3>
