
obj/user/sc_CPU_MLFQ_slave_1_1:     file format elf32-i386


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
  800031:	e8 32 01 00 00       	call   800168 <libmain>
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
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
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
  80006a:	68 80 1a 80 00       	push   $0x801a80
  80006f:	e8 58 14 00 00       	call   8014cc <sys_create_env>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 ec             	mov    %eax,-0x14(%ebp)
			sys_run_env(ID);
  80007a:	83 ec 0c             	sub    $0xc,%esp
  80007d:	ff 75 ec             	pushl  -0x14(%ebp)
  800080:	e8 65 14 00 00       	call   8014ea <sys_run_env>
  800085:	83 c4 10             	add    $0x10,%esp
#include <inc/lib.h>

void _main(void)
{
	int ID;
	for (int i = 0; i < 5; ++i) {
  800088:	ff 45 f4             	incl   -0xc(%ebp)
  80008b:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
  80008f:	7e b6                	jle    800047 <_main+0xf>
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
			sys_run_env(ID);
		}
	//cprintf("done\n");
	//env_sleep(5000);
	int x = busy_wait(1000000);
  800091:	83 ec 0c             	sub    $0xc,%esp
  800094:	68 40 42 0f 00       	push   $0xf4240
  800099:	e8 5f 17 00 00       	call   8017fd <busy_wait>
  80009e:	83 c4 10             	add    $0x10,%esp
  8000a1:	89 45 e8             	mov    %eax,-0x18(%ebp)

	for (int i = 0; i < 5; ++i) {
  8000a4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8000ab:	e9 98 00 00 00       	jmp    800148 <_main+0x110>
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000b0:	a1 20 20 80 00       	mov    0x802020,%eax
  8000b5:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8000bb:	a1 20 20 80 00       	mov    0x802020,%eax
  8000c0:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000c6:	89 c1                	mov    %eax,%ecx
  8000c8:	a1 20 20 80 00       	mov    0x802020,%eax
  8000cd:	8b 40 74             	mov    0x74(%eax),%eax
  8000d0:	52                   	push   %edx
  8000d1:	51                   	push   %ecx
  8000d2:	50                   	push   %eax
  8000d3:	68 80 1a 80 00       	push   $0x801a80
  8000d8:	e8 ef 13 00 00       	call   8014cc <sys_create_env>
  8000dd:	83 c4 10             	add    $0x10,%esp
  8000e0:	89 45 ec             	mov    %eax,-0x14(%ebp)
			sys_run_env(ID);
  8000e3:	83 ec 0c             	sub    $0xc,%esp
  8000e6:	ff 75 ec             	pushl  -0x14(%ebp)
  8000e9:	e8 fc 13 00 00       	call   8014ea <sys_run_env>
  8000ee:	83 c4 10             	add    $0x10,%esp
			x = busy_wait(10000);
  8000f1:	83 ec 0c             	sub    $0xc,%esp
  8000f4:	68 10 27 00 00       	push   $0x2710
  8000f9:	e8 ff 16 00 00       	call   8017fd <busy_wait>
  8000fe:	83 c4 10             	add    $0x10,%esp
  800101:	89 45 e8             	mov    %eax,-0x18(%ebp)
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  800104:	a1 20 20 80 00       	mov    0x802020,%eax
  800109:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  80010f:	a1 20 20 80 00       	mov    0x802020,%eax
  800114:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80011a:	89 c1                	mov    %eax,%ecx
  80011c:	a1 20 20 80 00       	mov    0x802020,%eax
  800121:	8b 40 74             	mov    0x74(%eax),%eax
  800124:	52                   	push   %edx
  800125:	51                   	push   %ecx
  800126:	50                   	push   %eax
  800127:	68 80 1a 80 00       	push   $0x801a80
  80012c:	e8 9b 13 00 00       	call   8014cc <sys_create_env>
  800131:	83 c4 10             	add    $0x10,%esp
  800134:	89 45 ec             	mov    %eax,-0x14(%ebp)
			sys_run_env(ID);
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	ff 75 ec             	pushl  -0x14(%ebp)
  80013d:	e8 a8 13 00 00       	call   8014ea <sys_run_env>
  800142:	83 c4 10             	add    $0x10,%esp
		}
	//cprintf("done\n");
	//env_sleep(5000);
	int x = busy_wait(1000000);

	for (int i = 0; i < 5; ++i) {
  800145:	ff 45 f0             	incl   -0x10(%ebp)
  800148:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
  80014c:	0f 8e 5e ff ff ff    	jle    8000b0 <_main+0x78>
			sys_run_env(ID);
			x = busy_wait(10000);
			ID = sys_create_env("tmlfq_2", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
			sys_run_env(ID);
		}
	x = busy_wait(1000000);
  800152:	83 ec 0c             	sub    $0xc,%esp
  800155:	68 40 42 0f 00       	push   $0xf4240
  80015a:	e8 9e 16 00 00       	call   8017fd <busy_wait>
  80015f:	83 c4 10             	add    $0x10,%esp
  800162:	89 45 e8             	mov    %eax,-0x18(%ebp)

}
  800165:	90                   	nop
  800166:	c9                   	leave  
  800167:	c3                   	ret    

00800168 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800168:	55                   	push   %ebp
  800169:	89 e5                	mov    %esp,%ebp
  80016b:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80016e:	e8 39 10 00 00       	call   8011ac <sys_getenvindex>
  800173:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800176:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800179:	89 d0                	mov    %edx,%eax
  80017b:	c1 e0 03             	shl    $0x3,%eax
  80017e:	01 d0                	add    %edx,%eax
  800180:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800187:	01 c8                	add    %ecx,%eax
  800189:	01 c0                	add    %eax,%eax
  80018b:	01 d0                	add    %edx,%eax
  80018d:	01 c0                	add    %eax,%eax
  80018f:	01 d0                	add    %edx,%eax
  800191:	89 c2                	mov    %eax,%edx
  800193:	c1 e2 05             	shl    $0x5,%edx
  800196:	29 c2                	sub    %eax,%edx
  800198:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80019f:	89 c2                	mov    %eax,%edx
  8001a1:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8001a7:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001ac:	a1 20 20 80 00       	mov    0x802020,%eax
  8001b1:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8001b7:	84 c0                	test   %al,%al
  8001b9:	74 0f                	je     8001ca <libmain+0x62>
		binaryname = myEnv->prog_name;
  8001bb:	a1 20 20 80 00       	mov    0x802020,%eax
  8001c0:	05 40 3c 01 00       	add    $0x13c40,%eax
  8001c5:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001ca:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001ce:	7e 0a                	jle    8001da <libmain+0x72>
		binaryname = argv[0];
  8001d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d3:	8b 00                	mov    (%eax),%eax
  8001d5:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8001da:	83 ec 08             	sub    $0x8,%esp
  8001dd:	ff 75 0c             	pushl  0xc(%ebp)
  8001e0:	ff 75 08             	pushl  0x8(%ebp)
  8001e3:	e8 50 fe ff ff       	call   800038 <_main>
  8001e8:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001eb:	e8 57 11 00 00       	call   801347 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001f0:	83 ec 0c             	sub    $0xc,%esp
  8001f3:	68 a0 1a 80 00       	push   $0x801aa0
  8001f8:	e8 84 01 00 00       	call   800381 <cprintf>
  8001fd:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800200:	a1 20 20 80 00       	mov    0x802020,%eax
  800205:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80020b:	a1 20 20 80 00       	mov    0x802020,%eax
  800210:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800216:	83 ec 04             	sub    $0x4,%esp
  800219:	52                   	push   %edx
  80021a:	50                   	push   %eax
  80021b:	68 c8 1a 80 00       	push   $0x801ac8
  800220:	e8 5c 01 00 00       	call   800381 <cprintf>
  800225:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800228:	a1 20 20 80 00       	mov    0x802020,%eax
  80022d:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800233:	a1 20 20 80 00       	mov    0x802020,%eax
  800238:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80023e:	83 ec 04             	sub    $0x4,%esp
  800241:	52                   	push   %edx
  800242:	50                   	push   %eax
  800243:	68 f0 1a 80 00       	push   $0x801af0
  800248:	e8 34 01 00 00       	call   800381 <cprintf>
  80024d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800250:	a1 20 20 80 00       	mov    0x802020,%eax
  800255:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80025b:	83 ec 08             	sub    $0x8,%esp
  80025e:	50                   	push   %eax
  80025f:	68 31 1b 80 00       	push   $0x801b31
  800264:	e8 18 01 00 00       	call   800381 <cprintf>
  800269:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80026c:	83 ec 0c             	sub    $0xc,%esp
  80026f:	68 a0 1a 80 00       	push   $0x801aa0
  800274:	e8 08 01 00 00       	call   800381 <cprintf>
  800279:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80027c:	e8 e0 10 00 00       	call   801361 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800281:	e8 19 00 00 00       	call   80029f <exit>
}
  800286:	90                   	nop
  800287:	c9                   	leave  
  800288:	c3                   	ret    

00800289 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800289:	55                   	push   %ebp
  80028a:	89 e5                	mov    %esp,%ebp
  80028c:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80028f:	83 ec 0c             	sub    $0xc,%esp
  800292:	6a 00                	push   $0x0
  800294:	e8 df 0e 00 00       	call   801178 <sys_env_destroy>
  800299:	83 c4 10             	add    $0x10,%esp
}
  80029c:	90                   	nop
  80029d:	c9                   	leave  
  80029e:	c3                   	ret    

0080029f <exit>:

void
exit(void)
{
  80029f:	55                   	push   %ebp
  8002a0:	89 e5                	mov    %esp,%ebp
  8002a2:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002a5:	e8 34 0f 00 00       	call   8011de <sys_env_exit>
}
  8002aa:	90                   	nop
  8002ab:	c9                   	leave  
  8002ac:	c3                   	ret    

008002ad <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8002ad:	55                   	push   %ebp
  8002ae:	89 e5                	mov    %esp,%ebp
  8002b0:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8002b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002b6:	8b 00                	mov    (%eax),%eax
  8002b8:	8d 48 01             	lea    0x1(%eax),%ecx
  8002bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002be:	89 0a                	mov    %ecx,(%edx)
  8002c0:	8b 55 08             	mov    0x8(%ebp),%edx
  8002c3:	88 d1                	mov    %dl,%cl
  8002c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002c8:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8002cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002cf:	8b 00                	mov    (%eax),%eax
  8002d1:	3d ff 00 00 00       	cmp    $0xff,%eax
  8002d6:	75 2c                	jne    800304 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8002d8:	a0 24 20 80 00       	mov    0x802024,%al
  8002dd:	0f b6 c0             	movzbl %al,%eax
  8002e0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002e3:	8b 12                	mov    (%edx),%edx
  8002e5:	89 d1                	mov    %edx,%ecx
  8002e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002ea:	83 c2 08             	add    $0x8,%edx
  8002ed:	83 ec 04             	sub    $0x4,%esp
  8002f0:	50                   	push   %eax
  8002f1:	51                   	push   %ecx
  8002f2:	52                   	push   %edx
  8002f3:	e8 3e 0e 00 00       	call   801136 <sys_cputs>
  8002f8:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8002fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002fe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800304:	8b 45 0c             	mov    0xc(%ebp),%eax
  800307:	8b 40 04             	mov    0x4(%eax),%eax
  80030a:	8d 50 01             	lea    0x1(%eax),%edx
  80030d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800310:	89 50 04             	mov    %edx,0x4(%eax)
}
  800313:	90                   	nop
  800314:	c9                   	leave  
  800315:	c3                   	ret    

00800316 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800316:	55                   	push   %ebp
  800317:	89 e5                	mov    %esp,%ebp
  800319:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80031f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800326:	00 00 00 
	b.cnt = 0;
  800329:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800330:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800333:	ff 75 0c             	pushl  0xc(%ebp)
  800336:	ff 75 08             	pushl  0x8(%ebp)
  800339:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80033f:	50                   	push   %eax
  800340:	68 ad 02 80 00       	push   $0x8002ad
  800345:	e8 11 02 00 00       	call   80055b <vprintfmt>
  80034a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80034d:	a0 24 20 80 00       	mov    0x802024,%al
  800352:	0f b6 c0             	movzbl %al,%eax
  800355:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80035b:	83 ec 04             	sub    $0x4,%esp
  80035e:	50                   	push   %eax
  80035f:	52                   	push   %edx
  800360:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800366:	83 c0 08             	add    $0x8,%eax
  800369:	50                   	push   %eax
  80036a:	e8 c7 0d 00 00       	call   801136 <sys_cputs>
  80036f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800372:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  800379:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80037f:	c9                   	leave  
  800380:	c3                   	ret    

00800381 <cprintf>:

int cprintf(const char *fmt, ...) {
  800381:	55                   	push   %ebp
  800382:	89 e5                	mov    %esp,%ebp
  800384:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800387:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  80038e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800391:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800394:	8b 45 08             	mov    0x8(%ebp),%eax
  800397:	83 ec 08             	sub    $0x8,%esp
  80039a:	ff 75 f4             	pushl  -0xc(%ebp)
  80039d:	50                   	push   %eax
  80039e:	e8 73 ff ff ff       	call   800316 <vcprintf>
  8003a3:	83 c4 10             	add    $0x10,%esp
  8003a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8003a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003ac:	c9                   	leave  
  8003ad:	c3                   	ret    

008003ae <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8003ae:	55                   	push   %ebp
  8003af:	89 e5                	mov    %esp,%ebp
  8003b1:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8003b4:	e8 8e 0f 00 00       	call   801347 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8003b9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c2:	83 ec 08             	sub    $0x8,%esp
  8003c5:	ff 75 f4             	pushl  -0xc(%ebp)
  8003c8:	50                   	push   %eax
  8003c9:	e8 48 ff ff ff       	call   800316 <vcprintf>
  8003ce:	83 c4 10             	add    $0x10,%esp
  8003d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8003d4:	e8 88 0f 00 00       	call   801361 <sys_enable_interrupt>
	return cnt;
  8003d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003dc:	c9                   	leave  
  8003dd:	c3                   	ret    

008003de <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8003de:	55                   	push   %ebp
  8003df:	89 e5                	mov    %esp,%ebp
  8003e1:	53                   	push   %ebx
  8003e2:	83 ec 14             	sub    $0x14,%esp
  8003e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8003e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8003eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8003ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8003f1:	8b 45 18             	mov    0x18(%ebp),%eax
  8003f4:	ba 00 00 00 00       	mov    $0x0,%edx
  8003f9:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003fc:	77 55                	ja     800453 <printnum+0x75>
  8003fe:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800401:	72 05                	jb     800408 <printnum+0x2a>
  800403:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800406:	77 4b                	ja     800453 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800408:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80040b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80040e:	8b 45 18             	mov    0x18(%ebp),%eax
  800411:	ba 00 00 00 00       	mov    $0x0,%edx
  800416:	52                   	push   %edx
  800417:	50                   	push   %eax
  800418:	ff 75 f4             	pushl  -0xc(%ebp)
  80041b:	ff 75 f0             	pushl  -0x10(%ebp)
  80041e:	e8 f9 13 00 00       	call   80181c <__udivdi3>
  800423:	83 c4 10             	add    $0x10,%esp
  800426:	83 ec 04             	sub    $0x4,%esp
  800429:	ff 75 20             	pushl  0x20(%ebp)
  80042c:	53                   	push   %ebx
  80042d:	ff 75 18             	pushl  0x18(%ebp)
  800430:	52                   	push   %edx
  800431:	50                   	push   %eax
  800432:	ff 75 0c             	pushl  0xc(%ebp)
  800435:	ff 75 08             	pushl  0x8(%ebp)
  800438:	e8 a1 ff ff ff       	call   8003de <printnum>
  80043d:	83 c4 20             	add    $0x20,%esp
  800440:	eb 1a                	jmp    80045c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800442:	83 ec 08             	sub    $0x8,%esp
  800445:	ff 75 0c             	pushl  0xc(%ebp)
  800448:	ff 75 20             	pushl  0x20(%ebp)
  80044b:	8b 45 08             	mov    0x8(%ebp),%eax
  80044e:	ff d0                	call   *%eax
  800450:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800453:	ff 4d 1c             	decl   0x1c(%ebp)
  800456:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80045a:	7f e6                	jg     800442 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80045c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80045f:	bb 00 00 00 00       	mov    $0x0,%ebx
  800464:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800467:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80046a:	53                   	push   %ebx
  80046b:	51                   	push   %ecx
  80046c:	52                   	push   %edx
  80046d:	50                   	push   %eax
  80046e:	e8 b9 14 00 00       	call   80192c <__umoddi3>
  800473:	83 c4 10             	add    $0x10,%esp
  800476:	05 74 1d 80 00       	add    $0x801d74,%eax
  80047b:	8a 00                	mov    (%eax),%al
  80047d:	0f be c0             	movsbl %al,%eax
  800480:	83 ec 08             	sub    $0x8,%esp
  800483:	ff 75 0c             	pushl  0xc(%ebp)
  800486:	50                   	push   %eax
  800487:	8b 45 08             	mov    0x8(%ebp),%eax
  80048a:	ff d0                	call   *%eax
  80048c:	83 c4 10             	add    $0x10,%esp
}
  80048f:	90                   	nop
  800490:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800493:	c9                   	leave  
  800494:	c3                   	ret    

00800495 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800495:	55                   	push   %ebp
  800496:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800498:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80049c:	7e 1c                	jle    8004ba <getuint+0x25>
		return va_arg(*ap, unsigned long long);
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
  8004b8:	eb 40                	jmp    8004fa <getuint+0x65>
	else if (lflag)
  8004ba:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004be:	74 1e                	je     8004de <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8004c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c3:	8b 00                	mov    (%eax),%eax
  8004c5:	8d 50 04             	lea    0x4(%eax),%edx
  8004c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004cb:	89 10                	mov    %edx,(%eax)
  8004cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d0:	8b 00                	mov    (%eax),%eax
  8004d2:	83 e8 04             	sub    $0x4,%eax
  8004d5:	8b 00                	mov    (%eax),%eax
  8004d7:	ba 00 00 00 00       	mov    $0x0,%edx
  8004dc:	eb 1c                	jmp    8004fa <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8004de:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e1:	8b 00                	mov    (%eax),%eax
  8004e3:	8d 50 04             	lea    0x4(%eax),%edx
  8004e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e9:	89 10                	mov    %edx,(%eax)
  8004eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ee:	8b 00                	mov    (%eax),%eax
  8004f0:	83 e8 04             	sub    $0x4,%eax
  8004f3:	8b 00                	mov    (%eax),%eax
  8004f5:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8004fa:	5d                   	pop    %ebp
  8004fb:	c3                   	ret    

008004fc <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8004fc:	55                   	push   %ebp
  8004fd:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004ff:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800503:	7e 1c                	jle    800521 <getint+0x25>
		return va_arg(*ap, long long);
  800505:	8b 45 08             	mov    0x8(%ebp),%eax
  800508:	8b 00                	mov    (%eax),%eax
  80050a:	8d 50 08             	lea    0x8(%eax),%edx
  80050d:	8b 45 08             	mov    0x8(%ebp),%eax
  800510:	89 10                	mov    %edx,(%eax)
  800512:	8b 45 08             	mov    0x8(%ebp),%eax
  800515:	8b 00                	mov    (%eax),%eax
  800517:	83 e8 08             	sub    $0x8,%eax
  80051a:	8b 50 04             	mov    0x4(%eax),%edx
  80051d:	8b 00                	mov    (%eax),%eax
  80051f:	eb 38                	jmp    800559 <getint+0x5d>
	else if (lflag)
  800521:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800525:	74 1a                	je     800541 <getint+0x45>
		return va_arg(*ap, long);
  800527:	8b 45 08             	mov    0x8(%ebp),%eax
  80052a:	8b 00                	mov    (%eax),%eax
  80052c:	8d 50 04             	lea    0x4(%eax),%edx
  80052f:	8b 45 08             	mov    0x8(%ebp),%eax
  800532:	89 10                	mov    %edx,(%eax)
  800534:	8b 45 08             	mov    0x8(%ebp),%eax
  800537:	8b 00                	mov    (%eax),%eax
  800539:	83 e8 04             	sub    $0x4,%eax
  80053c:	8b 00                	mov    (%eax),%eax
  80053e:	99                   	cltd   
  80053f:	eb 18                	jmp    800559 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800541:	8b 45 08             	mov    0x8(%ebp),%eax
  800544:	8b 00                	mov    (%eax),%eax
  800546:	8d 50 04             	lea    0x4(%eax),%edx
  800549:	8b 45 08             	mov    0x8(%ebp),%eax
  80054c:	89 10                	mov    %edx,(%eax)
  80054e:	8b 45 08             	mov    0x8(%ebp),%eax
  800551:	8b 00                	mov    (%eax),%eax
  800553:	83 e8 04             	sub    $0x4,%eax
  800556:	8b 00                	mov    (%eax),%eax
  800558:	99                   	cltd   
}
  800559:	5d                   	pop    %ebp
  80055a:	c3                   	ret    

0080055b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80055b:	55                   	push   %ebp
  80055c:	89 e5                	mov    %esp,%ebp
  80055e:	56                   	push   %esi
  80055f:	53                   	push   %ebx
  800560:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800563:	eb 17                	jmp    80057c <vprintfmt+0x21>
			if (ch == '\0')
  800565:	85 db                	test   %ebx,%ebx
  800567:	0f 84 af 03 00 00    	je     80091c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80056d:	83 ec 08             	sub    $0x8,%esp
  800570:	ff 75 0c             	pushl  0xc(%ebp)
  800573:	53                   	push   %ebx
  800574:	8b 45 08             	mov    0x8(%ebp),%eax
  800577:	ff d0                	call   *%eax
  800579:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80057c:	8b 45 10             	mov    0x10(%ebp),%eax
  80057f:	8d 50 01             	lea    0x1(%eax),%edx
  800582:	89 55 10             	mov    %edx,0x10(%ebp)
  800585:	8a 00                	mov    (%eax),%al
  800587:	0f b6 d8             	movzbl %al,%ebx
  80058a:	83 fb 25             	cmp    $0x25,%ebx
  80058d:	75 d6                	jne    800565 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80058f:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800593:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80059a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8005a1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8005a8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8005af:	8b 45 10             	mov    0x10(%ebp),%eax
  8005b2:	8d 50 01             	lea    0x1(%eax),%edx
  8005b5:	89 55 10             	mov    %edx,0x10(%ebp)
  8005b8:	8a 00                	mov    (%eax),%al
  8005ba:	0f b6 d8             	movzbl %al,%ebx
  8005bd:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8005c0:	83 f8 55             	cmp    $0x55,%eax
  8005c3:	0f 87 2b 03 00 00    	ja     8008f4 <vprintfmt+0x399>
  8005c9:	8b 04 85 98 1d 80 00 	mov    0x801d98(,%eax,4),%eax
  8005d0:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8005d2:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8005d6:	eb d7                	jmp    8005af <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8005d8:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8005dc:	eb d1                	jmp    8005af <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005de:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8005e5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005e8:	89 d0                	mov    %edx,%eax
  8005ea:	c1 e0 02             	shl    $0x2,%eax
  8005ed:	01 d0                	add    %edx,%eax
  8005ef:	01 c0                	add    %eax,%eax
  8005f1:	01 d8                	add    %ebx,%eax
  8005f3:	83 e8 30             	sub    $0x30,%eax
  8005f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8005f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8005fc:	8a 00                	mov    (%eax),%al
  8005fe:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800601:	83 fb 2f             	cmp    $0x2f,%ebx
  800604:	7e 3e                	jle    800644 <vprintfmt+0xe9>
  800606:	83 fb 39             	cmp    $0x39,%ebx
  800609:	7f 39                	jg     800644 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80060b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80060e:	eb d5                	jmp    8005e5 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800610:	8b 45 14             	mov    0x14(%ebp),%eax
  800613:	83 c0 04             	add    $0x4,%eax
  800616:	89 45 14             	mov    %eax,0x14(%ebp)
  800619:	8b 45 14             	mov    0x14(%ebp),%eax
  80061c:	83 e8 04             	sub    $0x4,%eax
  80061f:	8b 00                	mov    (%eax),%eax
  800621:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800624:	eb 1f                	jmp    800645 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800626:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80062a:	79 83                	jns    8005af <vprintfmt+0x54>
				width = 0;
  80062c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800633:	e9 77 ff ff ff       	jmp    8005af <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800638:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80063f:	e9 6b ff ff ff       	jmp    8005af <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800644:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800645:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800649:	0f 89 60 ff ff ff    	jns    8005af <vprintfmt+0x54>
				width = precision, precision = -1;
  80064f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800652:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800655:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80065c:	e9 4e ff ff ff       	jmp    8005af <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800661:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800664:	e9 46 ff ff ff       	jmp    8005af <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800669:	8b 45 14             	mov    0x14(%ebp),%eax
  80066c:	83 c0 04             	add    $0x4,%eax
  80066f:	89 45 14             	mov    %eax,0x14(%ebp)
  800672:	8b 45 14             	mov    0x14(%ebp),%eax
  800675:	83 e8 04             	sub    $0x4,%eax
  800678:	8b 00                	mov    (%eax),%eax
  80067a:	83 ec 08             	sub    $0x8,%esp
  80067d:	ff 75 0c             	pushl  0xc(%ebp)
  800680:	50                   	push   %eax
  800681:	8b 45 08             	mov    0x8(%ebp),%eax
  800684:	ff d0                	call   *%eax
  800686:	83 c4 10             	add    $0x10,%esp
			break;
  800689:	e9 89 02 00 00       	jmp    800917 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80068e:	8b 45 14             	mov    0x14(%ebp),%eax
  800691:	83 c0 04             	add    $0x4,%eax
  800694:	89 45 14             	mov    %eax,0x14(%ebp)
  800697:	8b 45 14             	mov    0x14(%ebp),%eax
  80069a:	83 e8 04             	sub    $0x4,%eax
  80069d:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80069f:	85 db                	test   %ebx,%ebx
  8006a1:	79 02                	jns    8006a5 <vprintfmt+0x14a>
				err = -err;
  8006a3:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8006a5:	83 fb 64             	cmp    $0x64,%ebx
  8006a8:	7f 0b                	jg     8006b5 <vprintfmt+0x15a>
  8006aa:	8b 34 9d e0 1b 80 00 	mov    0x801be0(,%ebx,4),%esi
  8006b1:	85 f6                	test   %esi,%esi
  8006b3:	75 19                	jne    8006ce <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8006b5:	53                   	push   %ebx
  8006b6:	68 85 1d 80 00       	push   $0x801d85
  8006bb:	ff 75 0c             	pushl  0xc(%ebp)
  8006be:	ff 75 08             	pushl  0x8(%ebp)
  8006c1:	e8 5e 02 00 00       	call   800924 <printfmt>
  8006c6:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8006c9:	e9 49 02 00 00       	jmp    800917 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8006ce:	56                   	push   %esi
  8006cf:	68 8e 1d 80 00       	push   $0x801d8e
  8006d4:	ff 75 0c             	pushl  0xc(%ebp)
  8006d7:	ff 75 08             	pushl  0x8(%ebp)
  8006da:	e8 45 02 00 00       	call   800924 <printfmt>
  8006df:	83 c4 10             	add    $0x10,%esp
			break;
  8006e2:	e9 30 02 00 00       	jmp    800917 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8006e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8006ea:	83 c0 04             	add    $0x4,%eax
  8006ed:	89 45 14             	mov    %eax,0x14(%ebp)
  8006f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8006f3:	83 e8 04             	sub    $0x4,%eax
  8006f6:	8b 30                	mov    (%eax),%esi
  8006f8:	85 f6                	test   %esi,%esi
  8006fa:	75 05                	jne    800701 <vprintfmt+0x1a6>
				p = "(null)";
  8006fc:	be 91 1d 80 00       	mov    $0x801d91,%esi
			if (width > 0 && padc != '-')
  800701:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800705:	7e 6d                	jle    800774 <vprintfmt+0x219>
  800707:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80070b:	74 67                	je     800774 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80070d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800710:	83 ec 08             	sub    $0x8,%esp
  800713:	50                   	push   %eax
  800714:	56                   	push   %esi
  800715:	e8 0c 03 00 00       	call   800a26 <strnlen>
  80071a:	83 c4 10             	add    $0x10,%esp
  80071d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800720:	eb 16                	jmp    800738 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800722:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800726:	83 ec 08             	sub    $0x8,%esp
  800729:	ff 75 0c             	pushl  0xc(%ebp)
  80072c:	50                   	push   %eax
  80072d:	8b 45 08             	mov    0x8(%ebp),%eax
  800730:	ff d0                	call   *%eax
  800732:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800735:	ff 4d e4             	decl   -0x1c(%ebp)
  800738:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80073c:	7f e4                	jg     800722 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80073e:	eb 34                	jmp    800774 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800740:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800744:	74 1c                	je     800762 <vprintfmt+0x207>
  800746:	83 fb 1f             	cmp    $0x1f,%ebx
  800749:	7e 05                	jle    800750 <vprintfmt+0x1f5>
  80074b:	83 fb 7e             	cmp    $0x7e,%ebx
  80074e:	7e 12                	jle    800762 <vprintfmt+0x207>
					putch('?', putdat);
  800750:	83 ec 08             	sub    $0x8,%esp
  800753:	ff 75 0c             	pushl  0xc(%ebp)
  800756:	6a 3f                	push   $0x3f
  800758:	8b 45 08             	mov    0x8(%ebp),%eax
  80075b:	ff d0                	call   *%eax
  80075d:	83 c4 10             	add    $0x10,%esp
  800760:	eb 0f                	jmp    800771 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800762:	83 ec 08             	sub    $0x8,%esp
  800765:	ff 75 0c             	pushl  0xc(%ebp)
  800768:	53                   	push   %ebx
  800769:	8b 45 08             	mov    0x8(%ebp),%eax
  80076c:	ff d0                	call   *%eax
  80076e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800771:	ff 4d e4             	decl   -0x1c(%ebp)
  800774:	89 f0                	mov    %esi,%eax
  800776:	8d 70 01             	lea    0x1(%eax),%esi
  800779:	8a 00                	mov    (%eax),%al
  80077b:	0f be d8             	movsbl %al,%ebx
  80077e:	85 db                	test   %ebx,%ebx
  800780:	74 24                	je     8007a6 <vprintfmt+0x24b>
  800782:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800786:	78 b8                	js     800740 <vprintfmt+0x1e5>
  800788:	ff 4d e0             	decl   -0x20(%ebp)
  80078b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80078f:	79 af                	jns    800740 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800791:	eb 13                	jmp    8007a6 <vprintfmt+0x24b>
				putch(' ', putdat);
  800793:	83 ec 08             	sub    $0x8,%esp
  800796:	ff 75 0c             	pushl  0xc(%ebp)
  800799:	6a 20                	push   $0x20
  80079b:	8b 45 08             	mov    0x8(%ebp),%eax
  80079e:	ff d0                	call   *%eax
  8007a0:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8007a3:	ff 4d e4             	decl   -0x1c(%ebp)
  8007a6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007aa:	7f e7                	jg     800793 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8007ac:	e9 66 01 00 00       	jmp    800917 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8007b1:	83 ec 08             	sub    $0x8,%esp
  8007b4:	ff 75 e8             	pushl  -0x18(%ebp)
  8007b7:	8d 45 14             	lea    0x14(%ebp),%eax
  8007ba:	50                   	push   %eax
  8007bb:	e8 3c fd ff ff       	call   8004fc <getint>
  8007c0:	83 c4 10             	add    $0x10,%esp
  8007c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007c6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8007c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007cf:	85 d2                	test   %edx,%edx
  8007d1:	79 23                	jns    8007f6 <vprintfmt+0x29b>
				putch('-', putdat);
  8007d3:	83 ec 08             	sub    $0x8,%esp
  8007d6:	ff 75 0c             	pushl  0xc(%ebp)
  8007d9:	6a 2d                	push   $0x2d
  8007db:	8b 45 08             	mov    0x8(%ebp),%eax
  8007de:	ff d0                	call   *%eax
  8007e0:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8007e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007e6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007e9:	f7 d8                	neg    %eax
  8007eb:	83 d2 00             	adc    $0x0,%edx
  8007ee:	f7 da                	neg    %edx
  8007f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007f3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8007f6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007fd:	e9 bc 00 00 00       	jmp    8008be <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800802:	83 ec 08             	sub    $0x8,%esp
  800805:	ff 75 e8             	pushl  -0x18(%ebp)
  800808:	8d 45 14             	lea    0x14(%ebp),%eax
  80080b:	50                   	push   %eax
  80080c:	e8 84 fc ff ff       	call   800495 <getuint>
  800811:	83 c4 10             	add    $0x10,%esp
  800814:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800817:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80081a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800821:	e9 98 00 00 00       	jmp    8008be <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800826:	83 ec 08             	sub    $0x8,%esp
  800829:	ff 75 0c             	pushl  0xc(%ebp)
  80082c:	6a 58                	push   $0x58
  80082e:	8b 45 08             	mov    0x8(%ebp),%eax
  800831:	ff d0                	call   *%eax
  800833:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800836:	83 ec 08             	sub    $0x8,%esp
  800839:	ff 75 0c             	pushl  0xc(%ebp)
  80083c:	6a 58                	push   $0x58
  80083e:	8b 45 08             	mov    0x8(%ebp),%eax
  800841:	ff d0                	call   *%eax
  800843:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800846:	83 ec 08             	sub    $0x8,%esp
  800849:	ff 75 0c             	pushl  0xc(%ebp)
  80084c:	6a 58                	push   $0x58
  80084e:	8b 45 08             	mov    0x8(%ebp),%eax
  800851:	ff d0                	call   *%eax
  800853:	83 c4 10             	add    $0x10,%esp
			break;
  800856:	e9 bc 00 00 00       	jmp    800917 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80085b:	83 ec 08             	sub    $0x8,%esp
  80085e:	ff 75 0c             	pushl  0xc(%ebp)
  800861:	6a 30                	push   $0x30
  800863:	8b 45 08             	mov    0x8(%ebp),%eax
  800866:	ff d0                	call   *%eax
  800868:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80086b:	83 ec 08             	sub    $0x8,%esp
  80086e:	ff 75 0c             	pushl  0xc(%ebp)
  800871:	6a 78                	push   $0x78
  800873:	8b 45 08             	mov    0x8(%ebp),%eax
  800876:	ff d0                	call   *%eax
  800878:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80087b:	8b 45 14             	mov    0x14(%ebp),%eax
  80087e:	83 c0 04             	add    $0x4,%eax
  800881:	89 45 14             	mov    %eax,0x14(%ebp)
  800884:	8b 45 14             	mov    0x14(%ebp),%eax
  800887:	83 e8 04             	sub    $0x4,%eax
  80088a:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80088c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80088f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800896:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80089d:	eb 1f                	jmp    8008be <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80089f:	83 ec 08             	sub    $0x8,%esp
  8008a2:	ff 75 e8             	pushl  -0x18(%ebp)
  8008a5:	8d 45 14             	lea    0x14(%ebp),%eax
  8008a8:	50                   	push   %eax
  8008a9:	e8 e7 fb ff ff       	call   800495 <getuint>
  8008ae:	83 c4 10             	add    $0x10,%esp
  8008b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008b4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8008b7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8008be:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8008c2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008c5:	83 ec 04             	sub    $0x4,%esp
  8008c8:	52                   	push   %edx
  8008c9:	ff 75 e4             	pushl  -0x1c(%ebp)
  8008cc:	50                   	push   %eax
  8008cd:	ff 75 f4             	pushl  -0xc(%ebp)
  8008d0:	ff 75 f0             	pushl  -0x10(%ebp)
  8008d3:	ff 75 0c             	pushl  0xc(%ebp)
  8008d6:	ff 75 08             	pushl  0x8(%ebp)
  8008d9:	e8 00 fb ff ff       	call   8003de <printnum>
  8008de:	83 c4 20             	add    $0x20,%esp
			break;
  8008e1:	eb 34                	jmp    800917 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8008e3:	83 ec 08             	sub    $0x8,%esp
  8008e6:	ff 75 0c             	pushl  0xc(%ebp)
  8008e9:	53                   	push   %ebx
  8008ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ed:	ff d0                	call   *%eax
  8008ef:	83 c4 10             	add    $0x10,%esp
			break;
  8008f2:	eb 23                	jmp    800917 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8008f4:	83 ec 08             	sub    $0x8,%esp
  8008f7:	ff 75 0c             	pushl  0xc(%ebp)
  8008fa:	6a 25                	push   $0x25
  8008fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ff:	ff d0                	call   *%eax
  800901:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800904:	ff 4d 10             	decl   0x10(%ebp)
  800907:	eb 03                	jmp    80090c <vprintfmt+0x3b1>
  800909:	ff 4d 10             	decl   0x10(%ebp)
  80090c:	8b 45 10             	mov    0x10(%ebp),%eax
  80090f:	48                   	dec    %eax
  800910:	8a 00                	mov    (%eax),%al
  800912:	3c 25                	cmp    $0x25,%al
  800914:	75 f3                	jne    800909 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800916:	90                   	nop
		}
	}
  800917:	e9 47 fc ff ff       	jmp    800563 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80091c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80091d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800920:	5b                   	pop    %ebx
  800921:	5e                   	pop    %esi
  800922:	5d                   	pop    %ebp
  800923:	c3                   	ret    

00800924 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800924:	55                   	push   %ebp
  800925:	89 e5                	mov    %esp,%ebp
  800927:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80092a:	8d 45 10             	lea    0x10(%ebp),%eax
  80092d:	83 c0 04             	add    $0x4,%eax
  800930:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800933:	8b 45 10             	mov    0x10(%ebp),%eax
  800936:	ff 75 f4             	pushl  -0xc(%ebp)
  800939:	50                   	push   %eax
  80093a:	ff 75 0c             	pushl  0xc(%ebp)
  80093d:	ff 75 08             	pushl  0x8(%ebp)
  800940:	e8 16 fc ff ff       	call   80055b <vprintfmt>
  800945:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800948:	90                   	nop
  800949:	c9                   	leave  
  80094a:	c3                   	ret    

0080094b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80094b:	55                   	push   %ebp
  80094c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80094e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800951:	8b 40 08             	mov    0x8(%eax),%eax
  800954:	8d 50 01             	lea    0x1(%eax),%edx
  800957:	8b 45 0c             	mov    0xc(%ebp),%eax
  80095a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80095d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800960:	8b 10                	mov    (%eax),%edx
  800962:	8b 45 0c             	mov    0xc(%ebp),%eax
  800965:	8b 40 04             	mov    0x4(%eax),%eax
  800968:	39 c2                	cmp    %eax,%edx
  80096a:	73 12                	jae    80097e <sprintputch+0x33>
		*b->buf++ = ch;
  80096c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80096f:	8b 00                	mov    (%eax),%eax
  800971:	8d 48 01             	lea    0x1(%eax),%ecx
  800974:	8b 55 0c             	mov    0xc(%ebp),%edx
  800977:	89 0a                	mov    %ecx,(%edx)
  800979:	8b 55 08             	mov    0x8(%ebp),%edx
  80097c:	88 10                	mov    %dl,(%eax)
}
  80097e:	90                   	nop
  80097f:	5d                   	pop    %ebp
  800980:	c3                   	ret    

00800981 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800981:	55                   	push   %ebp
  800982:	89 e5                	mov    %esp,%ebp
  800984:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800987:	8b 45 08             	mov    0x8(%ebp),%eax
  80098a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80098d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800990:	8d 50 ff             	lea    -0x1(%eax),%edx
  800993:	8b 45 08             	mov    0x8(%ebp),%eax
  800996:	01 d0                	add    %edx,%eax
  800998:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80099b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8009a2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8009a6:	74 06                	je     8009ae <vsnprintf+0x2d>
  8009a8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009ac:	7f 07                	jg     8009b5 <vsnprintf+0x34>
		return -E_INVAL;
  8009ae:	b8 03 00 00 00       	mov    $0x3,%eax
  8009b3:	eb 20                	jmp    8009d5 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8009b5:	ff 75 14             	pushl  0x14(%ebp)
  8009b8:	ff 75 10             	pushl  0x10(%ebp)
  8009bb:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8009be:	50                   	push   %eax
  8009bf:	68 4b 09 80 00       	push   $0x80094b
  8009c4:	e8 92 fb ff ff       	call   80055b <vprintfmt>
  8009c9:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8009cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009cf:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8009d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8009d5:	c9                   	leave  
  8009d6:	c3                   	ret    

008009d7 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8009d7:	55                   	push   %ebp
  8009d8:	89 e5                	mov    %esp,%ebp
  8009da:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8009dd:	8d 45 10             	lea    0x10(%ebp),%eax
  8009e0:	83 c0 04             	add    $0x4,%eax
  8009e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8009e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8009e9:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ec:	50                   	push   %eax
  8009ed:	ff 75 0c             	pushl  0xc(%ebp)
  8009f0:	ff 75 08             	pushl  0x8(%ebp)
  8009f3:	e8 89 ff ff ff       	call   800981 <vsnprintf>
  8009f8:	83 c4 10             	add    $0x10,%esp
  8009fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8009fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a01:	c9                   	leave  
  800a02:	c3                   	ret    

00800a03 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800a03:	55                   	push   %ebp
  800a04:	89 e5                	mov    %esp,%ebp
  800a06:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800a09:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a10:	eb 06                	jmp    800a18 <strlen+0x15>
		n++;
  800a12:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800a15:	ff 45 08             	incl   0x8(%ebp)
  800a18:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1b:	8a 00                	mov    (%eax),%al
  800a1d:	84 c0                	test   %al,%al
  800a1f:	75 f1                	jne    800a12 <strlen+0xf>
		n++;
	return n;
  800a21:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a24:	c9                   	leave  
  800a25:	c3                   	ret    

00800a26 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800a26:	55                   	push   %ebp
  800a27:	89 e5                	mov    %esp,%ebp
  800a29:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a2c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a33:	eb 09                	jmp    800a3e <strnlen+0x18>
		n++;
  800a35:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a38:	ff 45 08             	incl   0x8(%ebp)
  800a3b:	ff 4d 0c             	decl   0xc(%ebp)
  800a3e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a42:	74 09                	je     800a4d <strnlen+0x27>
  800a44:	8b 45 08             	mov    0x8(%ebp),%eax
  800a47:	8a 00                	mov    (%eax),%al
  800a49:	84 c0                	test   %al,%al
  800a4b:	75 e8                	jne    800a35 <strnlen+0xf>
		n++;
	return n;
  800a4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a50:	c9                   	leave  
  800a51:	c3                   	ret    

00800a52 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800a52:	55                   	push   %ebp
  800a53:	89 e5                	mov    %esp,%ebp
  800a55:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800a58:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800a5e:	90                   	nop
  800a5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a62:	8d 50 01             	lea    0x1(%eax),%edx
  800a65:	89 55 08             	mov    %edx,0x8(%ebp)
  800a68:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a6b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a6e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a71:	8a 12                	mov    (%edx),%dl
  800a73:	88 10                	mov    %dl,(%eax)
  800a75:	8a 00                	mov    (%eax),%al
  800a77:	84 c0                	test   %al,%al
  800a79:	75 e4                	jne    800a5f <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a7b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a7e:	c9                   	leave  
  800a7f:	c3                   	ret    

00800a80 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a80:	55                   	push   %ebp
  800a81:	89 e5                	mov    %esp,%ebp
  800a83:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a86:	8b 45 08             	mov    0x8(%ebp),%eax
  800a89:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a8c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a93:	eb 1f                	jmp    800ab4 <strncpy+0x34>
		*dst++ = *src;
  800a95:	8b 45 08             	mov    0x8(%ebp),%eax
  800a98:	8d 50 01             	lea    0x1(%eax),%edx
  800a9b:	89 55 08             	mov    %edx,0x8(%ebp)
  800a9e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aa1:	8a 12                	mov    (%edx),%dl
  800aa3:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800aa5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa8:	8a 00                	mov    (%eax),%al
  800aaa:	84 c0                	test   %al,%al
  800aac:	74 03                	je     800ab1 <strncpy+0x31>
			src++;
  800aae:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800ab1:	ff 45 fc             	incl   -0x4(%ebp)
  800ab4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ab7:	3b 45 10             	cmp    0x10(%ebp),%eax
  800aba:	72 d9                	jb     800a95 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800abc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800abf:	c9                   	leave  
  800ac0:	c3                   	ret    

00800ac1 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ac1:	55                   	push   %ebp
  800ac2:	89 e5                	mov    %esp,%ebp
  800ac4:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ac7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aca:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800acd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ad1:	74 30                	je     800b03 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800ad3:	eb 16                	jmp    800aeb <strlcpy+0x2a>
			*dst++ = *src++;
  800ad5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad8:	8d 50 01             	lea    0x1(%eax),%edx
  800adb:	89 55 08             	mov    %edx,0x8(%ebp)
  800ade:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ae4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ae7:	8a 12                	mov    (%edx),%dl
  800ae9:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800aeb:	ff 4d 10             	decl   0x10(%ebp)
  800aee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800af2:	74 09                	je     800afd <strlcpy+0x3c>
  800af4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af7:	8a 00                	mov    (%eax),%al
  800af9:	84 c0                	test   %al,%al
  800afb:	75 d8                	jne    800ad5 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800afd:	8b 45 08             	mov    0x8(%ebp),%eax
  800b00:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800b03:	8b 55 08             	mov    0x8(%ebp),%edx
  800b06:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b09:	29 c2                	sub    %eax,%edx
  800b0b:	89 d0                	mov    %edx,%eax
}
  800b0d:	c9                   	leave  
  800b0e:	c3                   	ret    

00800b0f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800b0f:	55                   	push   %ebp
  800b10:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800b12:	eb 06                	jmp    800b1a <strcmp+0xb>
		p++, q++;
  800b14:	ff 45 08             	incl   0x8(%ebp)
  800b17:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	8a 00                	mov    (%eax),%al
  800b1f:	84 c0                	test   %al,%al
  800b21:	74 0e                	je     800b31 <strcmp+0x22>
  800b23:	8b 45 08             	mov    0x8(%ebp),%eax
  800b26:	8a 10                	mov    (%eax),%dl
  800b28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2b:	8a 00                	mov    (%eax),%al
  800b2d:	38 c2                	cmp    %al,%dl
  800b2f:	74 e3                	je     800b14 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	8a 00                	mov    (%eax),%al
  800b36:	0f b6 d0             	movzbl %al,%edx
  800b39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3c:	8a 00                	mov    (%eax),%al
  800b3e:	0f b6 c0             	movzbl %al,%eax
  800b41:	29 c2                	sub    %eax,%edx
  800b43:	89 d0                	mov    %edx,%eax
}
  800b45:	5d                   	pop    %ebp
  800b46:	c3                   	ret    

00800b47 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800b47:	55                   	push   %ebp
  800b48:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800b4a:	eb 09                	jmp    800b55 <strncmp+0xe>
		n--, p++, q++;
  800b4c:	ff 4d 10             	decl   0x10(%ebp)
  800b4f:	ff 45 08             	incl   0x8(%ebp)
  800b52:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800b55:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b59:	74 17                	je     800b72 <strncmp+0x2b>
  800b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5e:	8a 00                	mov    (%eax),%al
  800b60:	84 c0                	test   %al,%al
  800b62:	74 0e                	je     800b72 <strncmp+0x2b>
  800b64:	8b 45 08             	mov    0x8(%ebp),%eax
  800b67:	8a 10                	mov    (%eax),%dl
  800b69:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6c:	8a 00                	mov    (%eax),%al
  800b6e:	38 c2                	cmp    %al,%dl
  800b70:	74 da                	je     800b4c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b72:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b76:	75 07                	jne    800b7f <strncmp+0x38>
		return 0;
  800b78:	b8 00 00 00 00       	mov    $0x0,%eax
  800b7d:	eb 14                	jmp    800b93 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b82:	8a 00                	mov    (%eax),%al
  800b84:	0f b6 d0             	movzbl %al,%edx
  800b87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8a:	8a 00                	mov    (%eax),%al
  800b8c:	0f b6 c0             	movzbl %al,%eax
  800b8f:	29 c2                	sub    %eax,%edx
  800b91:	89 d0                	mov    %edx,%eax
}
  800b93:	5d                   	pop    %ebp
  800b94:	c3                   	ret    

00800b95 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b95:	55                   	push   %ebp
  800b96:	89 e5                	mov    %esp,%ebp
  800b98:	83 ec 04             	sub    $0x4,%esp
  800b9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b9e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ba1:	eb 12                	jmp    800bb5 <strchr+0x20>
		if (*s == c)
  800ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba6:	8a 00                	mov    (%eax),%al
  800ba8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800bab:	75 05                	jne    800bb2 <strchr+0x1d>
			return (char *) s;
  800bad:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb0:	eb 11                	jmp    800bc3 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800bb2:	ff 45 08             	incl   0x8(%ebp)
  800bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb8:	8a 00                	mov    (%eax),%al
  800bba:	84 c0                	test   %al,%al
  800bbc:	75 e5                	jne    800ba3 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800bbe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800bc3:	c9                   	leave  
  800bc4:	c3                   	ret    

00800bc5 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800bc5:	55                   	push   %ebp
  800bc6:	89 e5                	mov    %esp,%ebp
  800bc8:	83 ec 04             	sub    $0x4,%esp
  800bcb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bce:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800bd1:	eb 0d                	jmp    800be0 <strfind+0x1b>
		if (*s == c)
  800bd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd6:	8a 00                	mov    (%eax),%al
  800bd8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800bdb:	74 0e                	je     800beb <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800bdd:	ff 45 08             	incl   0x8(%ebp)
  800be0:	8b 45 08             	mov    0x8(%ebp),%eax
  800be3:	8a 00                	mov    (%eax),%al
  800be5:	84 c0                	test   %al,%al
  800be7:	75 ea                	jne    800bd3 <strfind+0xe>
  800be9:	eb 01                	jmp    800bec <strfind+0x27>
		if (*s == c)
			break;
  800beb:	90                   	nop
	return (char *) s;
  800bec:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bef:	c9                   	leave  
  800bf0:	c3                   	ret    

00800bf1 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800bf1:	55                   	push   %ebp
  800bf2:	89 e5                	mov    %esp,%ebp
  800bf4:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800bf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800bfd:	8b 45 10             	mov    0x10(%ebp),%eax
  800c00:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800c03:	eb 0e                	jmp    800c13 <memset+0x22>
		*p++ = c;
  800c05:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c08:	8d 50 01             	lea    0x1(%eax),%edx
  800c0b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800c0e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c11:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800c13:	ff 4d f8             	decl   -0x8(%ebp)
  800c16:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800c1a:	79 e9                	jns    800c05 <memset+0x14>
		*p++ = c;

	return v;
  800c1c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c1f:	c9                   	leave  
  800c20:	c3                   	ret    

00800c21 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800c21:	55                   	push   %ebp
  800c22:	89 e5                	mov    %esp,%ebp
  800c24:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c2a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c30:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800c33:	eb 16                	jmp    800c4b <memcpy+0x2a>
		*d++ = *s++;
  800c35:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c38:	8d 50 01             	lea    0x1(%eax),%edx
  800c3b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c3e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c41:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c44:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c47:	8a 12                	mov    (%edx),%dl
  800c49:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800c4b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c4e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c51:	89 55 10             	mov    %edx,0x10(%ebp)
  800c54:	85 c0                	test   %eax,%eax
  800c56:	75 dd                	jne    800c35 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800c58:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c5b:	c9                   	leave  
  800c5c:	c3                   	ret    

00800c5d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800c5d:	55                   	push   %ebp
  800c5e:	89 e5                	mov    %esp,%ebp
  800c60:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c66:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c69:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c6f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c72:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c75:	73 50                	jae    800cc7 <memmove+0x6a>
  800c77:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c7a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c7d:	01 d0                	add    %edx,%eax
  800c7f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c82:	76 43                	jbe    800cc7 <memmove+0x6a>
		s += n;
  800c84:	8b 45 10             	mov    0x10(%ebp),%eax
  800c87:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c8a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c8d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c90:	eb 10                	jmp    800ca2 <memmove+0x45>
			*--d = *--s;
  800c92:	ff 4d f8             	decl   -0x8(%ebp)
  800c95:	ff 4d fc             	decl   -0x4(%ebp)
  800c98:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c9b:	8a 10                	mov    (%eax),%dl
  800c9d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ca0:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800ca2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ca8:	89 55 10             	mov    %edx,0x10(%ebp)
  800cab:	85 c0                	test   %eax,%eax
  800cad:	75 e3                	jne    800c92 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800caf:	eb 23                	jmp    800cd4 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800cb1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cb4:	8d 50 01             	lea    0x1(%eax),%edx
  800cb7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800cba:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800cbd:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cc0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800cc3:	8a 12                	mov    (%edx),%dl
  800cc5:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800cc7:	8b 45 10             	mov    0x10(%ebp),%eax
  800cca:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ccd:	89 55 10             	mov    %edx,0x10(%ebp)
  800cd0:	85 c0                	test   %eax,%eax
  800cd2:	75 dd                	jne    800cb1 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800cd4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cd7:	c9                   	leave  
  800cd8:	c3                   	ret    

00800cd9 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800cd9:	55                   	push   %ebp
  800cda:	89 e5                	mov    %esp,%ebp
  800cdc:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800cdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ce5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce8:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ceb:	eb 2a                	jmp    800d17 <memcmp+0x3e>
		if (*s1 != *s2)
  800ced:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cf0:	8a 10                	mov    (%eax),%dl
  800cf2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cf5:	8a 00                	mov    (%eax),%al
  800cf7:	38 c2                	cmp    %al,%dl
  800cf9:	74 16                	je     800d11 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800cfb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cfe:	8a 00                	mov    (%eax),%al
  800d00:	0f b6 d0             	movzbl %al,%edx
  800d03:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d06:	8a 00                	mov    (%eax),%al
  800d08:	0f b6 c0             	movzbl %al,%eax
  800d0b:	29 c2                	sub    %eax,%edx
  800d0d:	89 d0                	mov    %edx,%eax
  800d0f:	eb 18                	jmp    800d29 <memcmp+0x50>
		s1++, s2++;
  800d11:	ff 45 fc             	incl   -0x4(%ebp)
  800d14:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800d17:	8b 45 10             	mov    0x10(%ebp),%eax
  800d1a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d1d:	89 55 10             	mov    %edx,0x10(%ebp)
  800d20:	85 c0                	test   %eax,%eax
  800d22:	75 c9                	jne    800ced <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800d24:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d29:	c9                   	leave  
  800d2a:	c3                   	ret    

00800d2b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800d2b:	55                   	push   %ebp
  800d2c:	89 e5                	mov    %esp,%ebp
  800d2e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800d31:	8b 55 08             	mov    0x8(%ebp),%edx
  800d34:	8b 45 10             	mov    0x10(%ebp),%eax
  800d37:	01 d0                	add    %edx,%eax
  800d39:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800d3c:	eb 15                	jmp    800d53 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800d3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d41:	8a 00                	mov    (%eax),%al
  800d43:	0f b6 d0             	movzbl %al,%edx
  800d46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d49:	0f b6 c0             	movzbl %al,%eax
  800d4c:	39 c2                	cmp    %eax,%edx
  800d4e:	74 0d                	je     800d5d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800d50:	ff 45 08             	incl   0x8(%ebp)
  800d53:	8b 45 08             	mov    0x8(%ebp),%eax
  800d56:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800d59:	72 e3                	jb     800d3e <memfind+0x13>
  800d5b:	eb 01                	jmp    800d5e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800d5d:	90                   	nop
	return (void *) s;
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d61:	c9                   	leave  
  800d62:	c3                   	ret    

00800d63 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800d63:	55                   	push   %ebp
  800d64:	89 e5                	mov    %esp,%ebp
  800d66:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d69:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d70:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d77:	eb 03                	jmp    800d7c <strtol+0x19>
		s++;
  800d79:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7f:	8a 00                	mov    (%eax),%al
  800d81:	3c 20                	cmp    $0x20,%al
  800d83:	74 f4                	je     800d79 <strtol+0x16>
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	8a 00                	mov    (%eax),%al
  800d8a:	3c 09                	cmp    $0x9,%al
  800d8c:	74 eb                	je     800d79 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d91:	8a 00                	mov    (%eax),%al
  800d93:	3c 2b                	cmp    $0x2b,%al
  800d95:	75 05                	jne    800d9c <strtol+0x39>
		s++;
  800d97:	ff 45 08             	incl   0x8(%ebp)
  800d9a:	eb 13                	jmp    800daf <strtol+0x4c>
	else if (*s == '-')
  800d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9f:	8a 00                	mov    (%eax),%al
  800da1:	3c 2d                	cmp    $0x2d,%al
  800da3:	75 0a                	jne    800daf <strtol+0x4c>
		s++, neg = 1;
  800da5:	ff 45 08             	incl   0x8(%ebp)
  800da8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800daf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800db3:	74 06                	je     800dbb <strtol+0x58>
  800db5:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800db9:	75 20                	jne    800ddb <strtol+0x78>
  800dbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbe:	8a 00                	mov    (%eax),%al
  800dc0:	3c 30                	cmp    $0x30,%al
  800dc2:	75 17                	jne    800ddb <strtol+0x78>
  800dc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc7:	40                   	inc    %eax
  800dc8:	8a 00                	mov    (%eax),%al
  800dca:	3c 78                	cmp    $0x78,%al
  800dcc:	75 0d                	jne    800ddb <strtol+0x78>
		s += 2, base = 16;
  800dce:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800dd2:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800dd9:	eb 28                	jmp    800e03 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ddb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ddf:	75 15                	jne    800df6 <strtol+0x93>
  800de1:	8b 45 08             	mov    0x8(%ebp),%eax
  800de4:	8a 00                	mov    (%eax),%al
  800de6:	3c 30                	cmp    $0x30,%al
  800de8:	75 0c                	jne    800df6 <strtol+0x93>
		s++, base = 8;
  800dea:	ff 45 08             	incl   0x8(%ebp)
  800ded:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800df4:	eb 0d                	jmp    800e03 <strtol+0xa0>
	else if (base == 0)
  800df6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dfa:	75 07                	jne    800e03 <strtol+0xa0>
		base = 10;
  800dfc:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800e03:	8b 45 08             	mov    0x8(%ebp),%eax
  800e06:	8a 00                	mov    (%eax),%al
  800e08:	3c 2f                	cmp    $0x2f,%al
  800e0a:	7e 19                	jle    800e25 <strtol+0xc2>
  800e0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0f:	8a 00                	mov    (%eax),%al
  800e11:	3c 39                	cmp    $0x39,%al
  800e13:	7f 10                	jg     800e25 <strtol+0xc2>
			dig = *s - '0';
  800e15:	8b 45 08             	mov    0x8(%ebp),%eax
  800e18:	8a 00                	mov    (%eax),%al
  800e1a:	0f be c0             	movsbl %al,%eax
  800e1d:	83 e8 30             	sub    $0x30,%eax
  800e20:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e23:	eb 42                	jmp    800e67 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800e25:	8b 45 08             	mov    0x8(%ebp),%eax
  800e28:	8a 00                	mov    (%eax),%al
  800e2a:	3c 60                	cmp    $0x60,%al
  800e2c:	7e 19                	jle    800e47 <strtol+0xe4>
  800e2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e31:	8a 00                	mov    (%eax),%al
  800e33:	3c 7a                	cmp    $0x7a,%al
  800e35:	7f 10                	jg     800e47 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800e37:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3a:	8a 00                	mov    (%eax),%al
  800e3c:	0f be c0             	movsbl %al,%eax
  800e3f:	83 e8 57             	sub    $0x57,%eax
  800e42:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e45:	eb 20                	jmp    800e67 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800e47:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4a:	8a 00                	mov    (%eax),%al
  800e4c:	3c 40                	cmp    $0x40,%al
  800e4e:	7e 39                	jle    800e89 <strtol+0x126>
  800e50:	8b 45 08             	mov    0x8(%ebp),%eax
  800e53:	8a 00                	mov    (%eax),%al
  800e55:	3c 5a                	cmp    $0x5a,%al
  800e57:	7f 30                	jg     800e89 <strtol+0x126>
			dig = *s - 'A' + 10;
  800e59:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5c:	8a 00                	mov    (%eax),%al
  800e5e:	0f be c0             	movsbl %al,%eax
  800e61:	83 e8 37             	sub    $0x37,%eax
  800e64:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e67:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e6a:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e6d:	7d 19                	jge    800e88 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e6f:	ff 45 08             	incl   0x8(%ebp)
  800e72:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e75:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e79:	89 c2                	mov    %eax,%edx
  800e7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e7e:	01 d0                	add    %edx,%eax
  800e80:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e83:	e9 7b ff ff ff       	jmp    800e03 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e88:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e89:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e8d:	74 08                	je     800e97 <strtol+0x134>
		*endptr = (char *) s;
  800e8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e92:	8b 55 08             	mov    0x8(%ebp),%edx
  800e95:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e97:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e9b:	74 07                	je     800ea4 <strtol+0x141>
  800e9d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ea0:	f7 d8                	neg    %eax
  800ea2:	eb 03                	jmp    800ea7 <strtol+0x144>
  800ea4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ea7:	c9                   	leave  
  800ea8:	c3                   	ret    

00800ea9 <ltostr>:

void
ltostr(long value, char *str)
{
  800ea9:	55                   	push   %ebp
  800eaa:	89 e5                	mov    %esp,%ebp
  800eac:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800eaf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800eb6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800ebd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ec1:	79 13                	jns    800ed6 <ltostr+0x2d>
	{
		neg = 1;
  800ec3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800eca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ecd:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800ed0:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800ed3:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800ed6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed9:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800ede:	99                   	cltd   
  800edf:	f7 f9                	idiv   %ecx
  800ee1:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800ee4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ee7:	8d 50 01             	lea    0x1(%eax),%edx
  800eea:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800eed:	89 c2                	mov    %eax,%edx
  800eef:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef2:	01 d0                	add    %edx,%eax
  800ef4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ef7:	83 c2 30             	add    $0x30,%edx
  800efa:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800efc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800eff:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800f04:	f7 e9                	imul   %ecx
  800f06:	c1 fa 02             	sar    $0x2,%edx
  800f09:	89 c8                	mov    %ecx,%eax
  800f0b:	c1 f8 1f             	sar    $0x1f,%eax
  800f0e:	29 c2                	sub    %eax,%edx
  800f10:	89 d0                	mov    %edx,%eax
  800f12:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800f15:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800f18:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800f1d:	f7 e9                	imul   %ecx
  800f1f:	c1 fa 02             	sar    $0x2,%edx
  800f22:	89 c8                	mov    %ecx,%eax
  800f24:	c1 f8 1f             	sar    $0x1f,%eax
  800f27:	29 c2                	sub    %eax,%edx
  800f29:	89 d0                	mov    %edx,%eax
  800f2b:	c1 e0 02             	shl    $0x2,%eax
  800f2e:	01 d0                	add    %edx,%eax
  800f30:	01 c0                	add    %eax,%eax
  800f32:	29 c1                	sub    %eax,%ecx
  800f34:	89 ca                	mov    %ecx,%edx
  800f36:	85 d2                	test   %edx,%edx
  800f38:	75 9c                	jne    800ed6 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800f3a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800f41:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f44:	48                   	dec    %eax
  800f45:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800f48:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f4c:	74 3d                	je     800f8b <ltostr+0xe2>
		start = 1 ;
  800f4e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800f55:	eb 34                	jmp    800f8b <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800f57:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5d:	01 d0                	add    %edx,%eax
  800f5f:	8a 00                	mov    (%eax),%al
  800f61:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800f64:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6a:	01 c2                	add    %eax,%edx
  800f6c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f72:	01 c8                	add    %ecx,%eax
  800f74:	8a 00                	mov    (%eax),%al
  800f76:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f78:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7e:	01 c2                	add    %eax,%edx
  800f80:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f83:	88 02                	mov    %al,(%edx)
		start++ ;
  800f85:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f88:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f8e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f91:	7c c4                	jl     800f57 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f93:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f99:	01 d0                	add    %edx,%eax
  800f9b:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f9e:	90                   	nop
  800f9f:	c9                   	leave  
  800fa0:	c3                   	ret    

00800fa1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800fa1:	55                   	push   %ebp
  800fa2:	89 e5                	mov    %esp,%ebp
  800fa4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800fa7:	ff 75 08             	pushl  0x8(%ebp)
  800faa:	e8 54 fa ff ff       	call   800a03 <strlen>
  800faf:	83 c4 04             	add    $0x4,%esp
  800fb2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800fb5:	ff 75 0c             	pushl  0xc(%ebp)
  800fb8:	e8 46 fa ff ff       	call   800a03 <strlen>
  800fbd:	83 c4 04             	add    $0x4,%esp
  800fc0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800fc3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800fca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800fd1:	eb 17                	jmp    800fea <strcconcat+0x49>
		final[s] = str1[s] ;
  800fd3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fd6:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd9:	01 c2                	add    %eax,%edx
  800fdb:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800fde:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe1:	01 c8                	add    %ecx,%eax
  800fe3:	8a 00                	mov    (%eax),%al
  800fe5:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800fe7:	ff 45 fc             	incl   -0x4(%ebp)
  800fea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fed:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ff0:	7c e1                	jl     800fd3 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ff2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ff9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801000:	eb 1f                	jmp    801021 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801002:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801005:	8d 50 01             	lea    0x1(%eax),%edx
  801008:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80100b:	89 c2                	mov    %eax,%edx
  80100d:	8b 45 10             	mov    0x10(%ebp),%eax
  801010:	01 c2                	add    %eax,%edx
  801012:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801015:	8b 45 0c             	mov    0xc(%ebp),%eax
  801018:	01 c8                	add    %ecx,%eax
  80101a:	8a 00                	mov    (%eax),%al
  80101c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80101e:	ff 45 f8             	incl   -0x8(%ebp)
  801021:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801024:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801027:	7c d9                	jl     801002 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801029:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80102c:	8b 45 10             	mov    0x10(%ebp),%eax
  80102f:	01 d0                	add    %edx,%eax
  801031:	c6 00 00             	movb   $0x0,(%eax)
}
  801034:	90                   	nop
  801035:	c9                   	leave  
  801036:	c3                   	ret    

00801037 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801037:	55                   	push   %ebp
  801038:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80103a:	8b 45 14             	mov    0x14(%ebp),%eax
  80103d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801043:	8b 45 14             	mov    0x14(%ebp),%eax
  801046:	8b 00                	mov    (%eax),%eax
  801048:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80104f:	8b 45 10             	mov    0x10(%ebp),%eax
  801052:	01 d0                	add    %edx,%eax
  801054:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80105a:	eb 0c                	jmp    801068 <strsplit+0x31>
			*string++ = 0;
  80105c:	8b 45 08             	mov    0x8(%ebp),%eax
  80105f:	8d 50 01             	lea    0x1(%eax),%edx
  801062:	89 55 08             	mov    %edx,0x8(%ebp)
  801065:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801068:	8b 45 08             	mov    0x8(%ebp),%eax
  80106b:	8a 00                	mov    (%eax),%al
  80106d:	84 c0                	test   %al,%al
  80106f:	74 18                	je     801089 <strsplit+0x52>
  801071:	8b 45 08             	mov    0x8(%ebp),%eax
  801074:	8a 00                	mov    (%eax),%al
  801076:	0f be c0             	movsbl %al,%eax
  801079:	50                   	push   %eax
  80107a:	ff 75 0c             	pushl  0xc(%ebp)
  80107d:	e8 13 fb ff ff       	call   800b95 <strchr>
  801082:	83 c4 08             	add    $0x8,%esp
  801085:	85 c0                	test   %eax,%eax
  801087:	75 d3                	jne    80105c <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801089:	8b 45 08             	mov    0x8(%ebp),%eax
  80108c:	8a 00                	mov    (%eax),%al
  80108e:	84 c0                	test   %al,%al
  801090:	74 5a                	je     8010ec <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801092:	8b 45 14             	mov    0x14(%ebp),%eax
  801095:	8b 00                	mov    (%eax),%eax
  801097:	83 f8 0f             	cmp    $0xf,%eax
  80109a:	75 07                	jne    8010a3 <strsplit+0x6c>
		{
			return 0;
  80109c:	b8 00 00 00 00       	mov    $0x0,%eax
  8010a1:	eb 66                	jmp    801109 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8010a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8010a6:	8b 00                	mov    (%eax),%eax
  8010a8:	8d 48 01             	lea    0x1(%eax),%ecx
  8010ab:	8b 55 14             	mov    0x14(%ebp),%edx
  8010ae:	89 0a                	mov    %ecx,(%edx)
  8010b0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ba:	01 c2                	add    %eax,%edx
  8010bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bf:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8010c1:	eb 03                	jmp    8010c6 <strsplit+0x8f>
			string++;
  8010c3:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	8a 00                	mov    (%eax),%al
  8010cb:	84 c0                	test   %al,%al
  8010cd:	74 8b                	je     80105a <strsplit+0x23>
  8010cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d2:	8a 00                	mov    (%eax),%al
  8010d4:	0f be c0             	movsbl %al,%eax
  8010d7:	50                   	push   %eax
  8010d8:	ff 75 0c             	pushl  0xc(%ebp)
  8010db:	e8 b5 fa ff ff       	call   800b95 <strchr>
  8010e0:	83 c4 08             	add    $0x8,%esp
  8010e3:	85 c0                	test   %eax,%eax
  8010e5:	74 dc                	je     8010c3 <strsplit+0x8c>
			string++;
	}
  8010e7:	e9 6e ff ff ff       	jmp    80105a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8010ec:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8010ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8010f0:	8b 00                	mov    (%eax),%eax
  8010f2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8010fc:	01 d0                	add    %edx,%eax
  8010fe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801104:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801109:	c9                   	leave  
  80110a:	c3                   	ret    

0080110b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80110b:	55                   	push   %ebp
  80110c:	89 e5                	mov    %esp,%ebp
  80110e:	57                   	push   %edi
  80110f:	56                   	push   %esi
  801110:	53                   	push   %ebx
  801111:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801114:	8b 45 08             	mov    0x8(%ebp),%eax
  801117:	8b 55 0c             	mov    0xc(%ebp),%edx
  80111a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80111d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801120:	8b 7d 18             	mov    0x18(%ebp),%edi
  801123:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801126:	cd 30                	int    $0x30
  801128:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80112b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80112e:	83 c4 10             	add    $0x10,%esp
  801131:	5b                   	pop    %ebx
  801132:	5e                   	pop    %esi
  801133:	5f                   	pop    %edi
  801134:	5d                   	pop    %ebp
  801135:	c3                   	ret    

00801136 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801136:	55                   	push   %ebp
  801137:	89 e5                	mov    %esp,%ebp
  801139:	83 ec 04             	sub    $0x4,%esp
  80113c:	8b 45 10             	mov    0x10(%ebp),%eax
  80113f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801142:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801146:	8b 45 08             	mov    0x8(%ebp),%eax
  801149:	6a 00                	push   $0x0
  80114b:	6a 00                	push   $0x0
  80114d:	52                   	push   %edx
  80114e:	ff 75 0c             	pushl  0xc(%ebp)
  801151:	50                   	push   %eax
  801152:	6a 00                	push   $0x0
  801154:	e8 b2 ff ff ff       	call   80110b <syscall>
  801159:	83 c4 18             	add    $0x18,%esp
}
  80115c:	90                   	nop
  80115d:	c9                   	leave  
  80115e:	c3                   	ret    

0080115f <sys_cgetc>:

int
sys_cgetc(void)
{
  80115f:	55                   	push   %ebp
  801160:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801162:	6a 00                	push   $0x0
  801164:	6a 00                	push   $0x0
  801166:	6a 00                	push   $0x0
  801168:	6a 00                	push   $0x0
  80116a:	6a 00                	push   $0x0
  80116c:	6a 01                	push   $0x1
  80116e:	e8 98 ff ff ff       	call   80110b <syscall>
  801173:	83 c4 18             	add    $0x18,%esp
}
  801176:	c9                   	leave  
  801177:	c3                   	ret    

00801178 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801178:	55                   	push   %ebp
  801179:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80117b:	8b 45 08             	mov    0x8(%ebp),%eax
  80117e:	6a 00                	push   $0x0
  801180:	6a 00                	push   $0x0
  801182:	6a 00                	push   $0x0
  801184:	6a 00                	push   $0x0
  801186:	50                   	push   %eax
  801187:	6a 05                	push   $0x5
  801189:	e8 7d ff ff ff       	call   80110b <syscall>
  80118e:	83 c4 18             	add    $0x18,%esp
}
  801191:	c9                   	leave  
  801192:	c3                   	ret    

00801193 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801193:	55                   	push   %ebp
  801194:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801196:	6a 00                	push   $0x0
  801198:	6a 00                	push   $0x0
  80119a:	6a 00                	push   $0x0
  80119c:	6a 00                	push   $0x0
  80119e:	6a 00                	push   $0x0
  8011a0:	6a 02                	push   $0x2
  8011a2:	e8 64 ff ff ff       	call   80110b <syscall>
  8011a7:	83 c4 18             	add    $0x18,%esp
}
  8011aa:	c9                   	leave  
  8011ab:	c3                   	ret    

008011ac <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8011ac:	55                   	push   %ebp
  8011ad:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8011af:	6a 00                	push   $0x0
  8011b1:	6a 00                	push   $0x0
  8011b3:	6a 00                	push   $0x0
  8011b5:	6a 00                	push   $0x0
  8011b7:	6a 00                	push   $0x0
  8011b9:	6a 03                	push   $0x3
  8011bb:	e8 4b ff ff ff       	call   80110b <syscall>
  8011c0:	83 c4 18             	add    $0x18,%esp
}
  8011c3:	c9                   	leave  
  8011c4:	c3                   	ret    

008011c5 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8011c5:	55                   	push   %ebp
  8011c6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8011c8:	6a 00                	push   $0x0
  8011ca:	6a 00                	push   $0x0
  8011cc:	6a 00                	push   $0x0
  8011ce:	6a 00                	push   $0x0
  8011d0:	6a 00                	push   $0x0
  8011d2:	6a 04                	push   $0x4
  8011d4:	e8 32 ff ff ff       	call   80110b <syscall>
  8011d9:	83 c4 18             	add    $0x18,%esp
}
  8011dc:	c9                   	leave  
  8011dd:	c3                   	ret    

008011de <sys_env_exit>:


void sys_env_exit(void)
{
  8011de:	55                   	push   %ebp
  8011df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8011e1:	6a 00                	push   $0x0
  8011e3:	6a 00                	push   $0x0
  8011e5:	6a 00                	push   $0x0
  8011e7:	6a 00                	push   $0x0
  8011e9:	6a 00                	push   $0x0
  8011eb:	6a 06                	push   $0x6
  8011ed:	e8 19 ff ff ff       	call   80110b <syscall>
  8011f2:	83 c4 18             	add    $0x18,%esp
}
  8011f5:	90                   	nop
  8011f6:	c9                   	leave  
  8011f7:	c3                   	ret    

008011f8 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8011f8:	55                   	push   %ebp
  8011f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8011fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801201:	6a 00                	push   $0x0
  801203:	6a 00                	push   $0x0
  801205:	6a 00                	push   $0x0
  801207:	52                   	push   %edx
  801208:	50                   	push   %eax
  801209:	6a 07                	push   $0x7
  80120b:	e8 fb fe ff ff       	call   80110b <syscall>
  801210:	83 c4 18             	add    $0x18,%esp
}
  801213:	c9                   	leave  
  801214:	c3                   	ret    

00801215 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801215:	55                   	push   %ebp
  801216:	89 e5                	mov    %esp,%ebp
  801218:	56                   	push   %esi
  801219:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80121a:	8b 75 18             	mov    0x18(%ebp),%esi
  80121d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801220:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801223:	8b 55 0c             	mov    0xc(%ebp),%edx
  801226:	8b 45 08             	mov    0x8(%ebp),%eax
  801229:	56                   	push   %esi
  80122a:	53                   	push   %ebx
  80122b:	51                   	push   %ecx
  80122c:	52                   	push   %edx
  80122d:	50                   	push   %eax
  80122e:	6a 08                	push   $0x8
  801230:	e8 d6 fe ff ff       	call   80110b <syscall>
  801235:	83 c4 18             	add    $0x18,%esp
}
  801238:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80123b:	5b                   	pop    %ebx
  80123c:	5e                   	pop    %esi
  80123d:	5d                   	pop    %ebp
  80123e:	c3                   	ret    

0080123f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80123f:	55                   	push   %ebp
  801240:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801242:	8b 55 0c             	mov    0xc(%ebp),%edx
  801245:	8b 45 08             	mov    0x8(%ebp),%eax
  801248:	6a 00                	push   $0x0
  80124a:	6a 00                	push   $0x0
  80124c:	6a 00                	push   $0x0
  80124e:	52                   	push   %edx
  80124f:	50                   	push   %eax
  801250:	6a 09                	push   $0x9
  801252:	e8 b4 fe ff ff       	call   80110b <syscall>
  801257:	83 c4 18             	add    $0x18,%esp
}
  80125a:	c9                   	leave  
  80125b:	c3                   	ret    

0080125c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80125c:	55                   	push   %ebp
  80125d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80125f:	6a 00                	push   $0x0
  801261:	6a 00                	push   $0x0
  801263:	6a 00                	push   $0x0
  801265:	ff 75 0c             	pushl  0xc(%ebp)
  801268:	ff 75 08             	pushl  0x8(%ebp)
  80126b:	6a 0a                	push   $0xa
  80126d:	e8 99 fe ff ff       	call   80110b <syscall>
  801272:	83 c4 18             	add    $0x18,%esp
}
  801275:	c9                   	leave  
  801276:	c3                   	ret    

00801277 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801277:	55                   	push   %ebp
  801278:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80127a:	6a 00                	push   $0x0
  80127c:	6a 00                	push   $0x0
  80127e:	6a 00                	push   $0x0
  801280:	6a 00                	push   $0x0
  801282:	6a 00                	push   $0x0
  801284:	6a 0b                	push   $0xb
  801286:	e8 80 fe ff ff       	call   80110b <syscall>
  80128b:	83 c4 18             	add    $0x18,%esp
}
  80128e:	c9                   	leave  
  80128f:	c3                   	ret    

00801290 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801290:	55                   	push   %ebp
  801291:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801293:	6a 00                	push   $0x0
  801295:	6a 00                	push   $0x0
  801297:	6a 00                	push   $0x0
  801299:	6a 00                	push   $0x0
  80129b:	6a 00                	push   $0x0
  80129d:	6a 0c                	push   $0xc
  80129f:	e8 67 fe ff ff       	call   80110b <syscall>
  8012a4:	83 c4 18             	add    $0x18,%esp
}
  8012a7:	c9                   	leave  
  8012a8:	c3                   	ret    

008012a9 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8012a9:	55                   	push   %ebp
  8012aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8012ac:	6a 00                	push   $0x0
  8012ae:	6a 00                	push   $0x0
  8012b0:	6a 00                	push   $0x0
  8012b2:	6a 00                	push   $0x0
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 0d                	push   $0xd
  8012b8:	e8 4e fe ff ff       	call   80110b <syscall>
  8012bd:	83 c4 18             	add    $0x18,%esp
}
  8012c0:	c9                   	leave  
  8012c1:	c3                   	ret    

008012c2 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8012c2:	55                   	push   %ebp
  8012c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8012c5:	6a 00                	push   $0x0
  8012c7:	6a 00                	push   $0x0
  8012c9:	6a 00                	push   $0x0
  8012cb:	ff 75 0c             	pushl  0xc(%ebp)
  8012ce:	ff 75 08             	pushl  0x8(%ebp)
  8012d1:	6a 11                	push   $0x11
  8012d3:	e8 33 fe ff ff       	call   80110b <syscall>
  8012d8:	83 c4 18             	add    $0x18,%esp
	return;
  8012db:	90                   	nop
}
  8012dc:	c9                   	leave  
  8012dd:	c3                   	ret    

008012de <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8012de:	55                   	push   %ebp
  8012df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8012e1:	6a 00                	push   $0x0
  8012e3:	6a 00                	push   $0x0
  8012e5:	6a 00                	push   $0x0
  8012e7:	ff 75 0c             	pushl  0xc(%ebp)
  8012ea:	ff 75 08             	pushl  0x8(%ebp)
  8012ed:	6a 12                	push   $0x12
  8012ef:	e8 17 fe ff ff       	call   80110b <syscall>
  8012f4:	83 c4 18             	add    $0x18,%esp
	return ;
  8012f7:	90                   	nop
}
  8012f8:	c9                   	leave  
  8012f9:	c3                   	ret    

008012fa <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8012fa:	55                   	push   %ebp
  8012fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8012fd:	6a 00                	push   $0x0
  8012ff:	6a 00                	push   $0x0
  801301:	6a 00                	push   $0x0
  801303:	6a 00                	push   $0x0
  801305:	6a 00                	push   $0x0
  801307:	6a 0e                	push   $0xe
  801309:	e8 fd fd ff ff       	call   80110b <syscall>
  80130e:	83 c4 18             	add    $0x18,%esp
}
  801311:	c9                   	leave  
  801312:	c3                   	ret    

00801313 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801313:	55                   	push   %ebp
  801314:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801316:	6a 00                	push   $0x0
  801318:	6a 00                	push   $0x0
  80131a:	6a 00                	push   $0x0
  80131c:	6a 00                	push   $0x0
  80131e:	ff 75 08             	pushl  0x8(%ebp)
  801321:	6a 0f                	push   $0xf
  801323:	e8 e3 fd ff ff       	call   80110b <syscall>
  801328:	83 c4 18             	add    $0x18,%esp
}
  80132b:	c9                   	leave  
  80132c:	c3                   	ret    

0080132d <sys_scarce_memory>:

void sys_scarce_memory()
{
  80132d:	55                   	push   %ebp
  80132e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801330:	6a 00                	push   $0x0
  801332:	6a 00                	push   $0x0
  801334:	6a 00                	push   $0x0
  801336:	6a 00                	push   $0x0
  801338:	6a 00                	push   $0x0
  80133a:	6a 10                	push   $0x10
  80133c:	e8 ca fd ff ff       	call   80110b <syscall>
  801341:	83 c4 18             	add    $0x18,%esp
}
  801344:	90                   	nop
  801345:	c9                   	leave  
  801346:	c3                   	ret    

00801347 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801347:	55                   	push   %ebp
  801348:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80134a:	6a 00                	push   $0x0
  80134c:	6a 00                	push   $0x0
  80134e:	6a 00                	push   $0x0
  801350:	6a 00                	push   $0x0
  801352:	6a 00                	push   $0x0
  801354:	6a 14                	push   $0x14
  801356:	e8 b0 fd ff ff       	call   80110b <syscall>
  80135b:	83 c4 18             	add    $0x18,%esp
}
  80135e:	90                   	nop
  80135f:	c9                   	leave  
  801360:	c3                   	ret    

00801361 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801361:	55                   	push   %ebp
  801362:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801364:	6a 00                	push   $0x0
  801366:	6a 00                	push   $0x0
  801368:	6a 00                	push   $0x0
  80136a:	6a 00                	push   $0x0
  80136c:	6a 00                	push   $0x0
  80136e:	6a 15                	push   $0x15
  801370:	e8 96 fd ff ff       	call   80110b <syscall>
  801375:	83 c4 18             	add    $0x18,%esp
}
  801378:	90                   	nop
  801379:	c9                   	leave  
  80137a:	c3                   	ret    

0080137b <sys_cputc>:


void
sys_cputc(const char c)
{
  80137b:	55                   	push   %ebp
  80137c:	89 e5                	mov    %esp,%ebp
  80137e:	83 ec 04             	sub    $0x4,%esp
  801381:	8b 45 08             	mov    0x8(%ebp),%eax
  801384:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801387:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80138b:	6a 00                	push   $0x0
  80138d:	6a 00                	push   $0x0
  80138f:	6a 00                	push   $0x0
  801391:	6a 00                	push   $0x0
  801393:	50                   	push   %eax
  801394:	6a 16                	push   $0x16
  801396:	e8 70 fd ff ff       	call   80110b <syscall>
  80139b:	83 c4 18             	add    $0x18,%esp
}
  80139e:	90                   	nop
  80139f:	c9                   	leave  
  8013a0:	c3                   	ret    

008013a1 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8013a1:	55                   	push   %ebp
  8013a2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8013a4:	6a 00                	push   $0x0
  8013a6:	6a 00                	push   $0x0
  8013a8:	6a 00                	push   $0x0
  8013aa:	6a 00                	push   $0x0
  8013ac:	6a 00                	push   $0x0
  8013ae:	6a 17                	push   $0x17
  8013b0:	e8 56 fd ff ff       	call   80110b <syscall>
  8013b5:	83 c4 18             	add    $0x18,%esp
}
  8013b8:	90                   	nop
  8013b9:	c9                   	leave  
  8013ba:	c3                   	ret    

008013bb <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8013bb:	55                   	push   %ebp
  8013bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8013be:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c1:	6a 00                	push   $0x0
  8013c3:	6a 00                	push   $0x0
  8013c5:	6a 00                	push   $0x0
  8013c7:	ff 75 0c             	pushl  0xc(%ebp)
  8013ca:	50                   	push   %eax
  8013cb:	6a 18                	push   $0x18
  8013cd:	e8 39 fd ff ff       	call   80110b <syscall>
  8013d2:	83 c4 18             	add    $0x18,%esp
}
  8013d5:	c9                   	leave  
  8013d6:	c3                   	ret    

008013d7 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8013d7:	55                   	push   %ebp
  8013d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8013da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e0:	6a 00                	push   $0x0
  8013e2:	6a 00                	push   $0x0
  8013e4:	6a 00                	push   $0x0
  8013e6:	52                   	push   %edx
  8013e7:	50                   	push   %eax
  8013e8:	6a 1b                	push   $0x1b
  8013ea:	e8 1c fd ff ff       	call   80110b <syscall>
  8013ef:	83 c4 18             	add    $0x18,%esp
}
  8013f2:	c9                   	leave  
  8013f3:	c3                   	ret    

008013f4 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8013f4:	55                   	push   %ebp
  8013f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8013f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	52                   	push   %edx
  801404:	50                   	push   %eax
  801405:	6a 19                	push   $0x19
  801407:	e8 ff fc ff ff       	call   80110b <syscall>
  80140c:	83 c4 18             	add    $0x18,%esp
}
  80140f:	90                   	nop
  801410:	c9                   	leave  
  801411:	c3                   	ret    

00801412 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801412:	55                   	push   %ebp
  801413:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801415:	8b 55 0c             	mov    0xc(%ebp),%edx
  801418:	8b 45 08             	mov    0x8(%ebp),%eax
  80141b:	6a 00                	push   $0x0
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	52                   	push   %edx
  801422:	50                   	push   %eax
  801423:	6a 1a                	push   $0x1a
  801425:	e8 e1 fc ff ff       	call   80110b <syscall>
  80142a:	83 c4 18             	add    $0x18,%esp
}
  80142d:	90                   	nop
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
  801433:	83 ec 04             	sub    $0x4,%esp
  801436:	8b 45 10             	mov    0x10(%ebp),%eax
  801439:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80143c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80143f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801443:	8b 45 08             	mov    0x8(%ebp),%eax
  801446:	6a 00                	push   $0x0
  801448:	51                   	push   %ecx
  801449:	52                   	push   %edx
  80144a:	ff 75 0c             	pushl  0xc(%ebp)
  80144d:	50                   	push   %eax
  80144e:	6a 1c                	push   $0x1c
  801450:	e8 b6 fc ff ff       	call   80110b <syscall>
  801455:	83 c4 18             	add    $0x18,%esp
}
  801458:	c9                   	leave  
  801459:	c3                   	ret    

0080145a <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80145a:	55                   	push   %ebp
  80145b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80145d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801460:	8b 45 08             	mov    0x8(%ebp),%eax
  801463:	6a 00                	push   $0x0
  801465:	6a 00                	push   $0x0
  801467:	6a 00                	push   $0x0
  801469:	52                   	push   %edx
  80146a:	50                   	push   %eax
  80146b:	6a 1d                	push   $0x1d
  80146d:	e8 99 fc ff ff       	call   80110b <syscall>
  801472:	83 c4 18             	add    $0x18,%esp
}
  801475:	c9                   	leave  
  801476:	c3                   	ret    

00801477 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801477:	55                   	push   %ebp
  801478:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80147a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80147d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801480:	8b 45 08             	mov    0x8(%ebp),%eax
  801483:	6a 00                	push   $0x0
  801485:	6a 00                	push   $0x0
  801487:	51                   	push   %ecx
  801488:	52                   	push   %edx
  801489:	50                   	push   %eax
  80148a:	6a 1e                	push   $0x1e
  80148c:	e8 7a fc ff ff       	call   80110b <syscall>
  801491:	83 c4 18             	add    $0x18,%esp
}
  801494:	c9                   	leave  
  801495:	c3                   	ret    

00801496 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801496:	55                   	push   %ebp
  801497:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801499:	8b 55 0c             	mov    0xc(%ebp),%edx
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 00                	push   $0x0
  8014a3:	6a 00                	push   $0x0
  8014a5:	52                   	push   %edx
  8014a6:	50                   	push   %eax
  8014a7:	6a 1f                	push   $0x1f
  8014a9:	e8 5d fc ff ff       	call   80110b <syscall>
  8014ae:	83 c4 18             	add    $0x18,%esp
}
  8014b1:	c9                   	leave  
  8014b2:	c3                   	ret    

008014b3 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8014b3:	55                   	push   %ebp
  8014b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	6a 00                	push   $0x0
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 20                	push   $0x20
  8014c2:	e8 44 fc ff ff       	call   80110b <syscall>
  8014c7:	83 c4 18             	add    $0x18,%esp
}
  8014ca:	c9                   	leave  
  8014cb:	c3                   	ret    

008014cc <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8014cc:	55                   	push   %ebp
  8014cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8014cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d2:	6a 00                	push   $0x0
  8014d4:	ff 75 14             	pushl  0x14(%ebp)
  8014d7:	ff 75 10             	pushl  0x10(%ebp)
  8014da:	ff 75 0c             	pushl  0xc(%ebp)
  8014dd:	50                   	push   %eax
  8014de:	6a 21                	push   $0x21
  8014e0:	e8 26 fc ff ff       	call   80110b <syscall>
  8014e5:	83 c4 18             	add    $0x18,%esp
}
  8014e8:	c9                   	leave  
  8014e9:	c3                   	ret    

008014ea <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8014ea:	55                   	push   %ebp
  8014eb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8014ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	50                   	push   %eax
  8014f9:	6a 22                	push   $0x22
  8014fb:	e8 0b fc ff ff       	call   80110b <syscall>
  801500:	83 c4 18             	add    $0x18,%esp
}
  801503:	90                   	nop
  801504:	c9                   	leave  
  801505:	c3                   	ret    

00801506 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801506:	55                   	push   %ebp
  801507:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801509:	8b 45 08             	mov    0x8(%ebp),%eax
  80150c:	6a 00                	push   $0x0
  80150e:	6a 00                	push   $0x0
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	50                   	push   %eax
  801515:	6a 23                	push   $0x23
  801517:	e8 ef fb ff ff       	call   80110b <syscall>
  80151c:	83 c4 18             	add    $0x18,%esp
}
  80151f:	90                   	nop
  801520:	c9                   	leave  
  801521:	c3                   	ret    

00801522 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801522:	55                   	push   %ebp
  801523:	89 e5                	mov    %esp,%ebp
  801525:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801528:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80152b:	8d 50 04             	lea    0x4(%eax),%edx
  80152e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	6a 00                	push   $0x0
  801537:	52                   	push   %edx
  801538:	50                   	push   %eax
  801539:	6a 24                	push   $0x24
  80153b:	e8 cb fb ff ff       	call   80110b <syscall>
  801540:	83 c4 18             	add    $0x18,%esp
	return result;
  801543:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801546:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801549:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80154c:	89 01                	mov    %eax,(%ecx)
  80154e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801551:	8b 45 08             	mov    0x8(%ebp),%eax
  801554:	c9                   	leave  
  801555:	c2 04 00             	ret    $0x4

00801558 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801558:	55                   	push   %ebp
  801559:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80155b:	6a 00                	push   $0x0
  80155d:	6a 00                	push   $0x0
  80155f:	ff 75 10             	pushl  0x10(%ebp)
  801562:	ff 75 0c             	pushl  0xc(%ebp)
  801565:	ff 75 08             	pushl  0x8(%ebp)
  801568:	6a 13                	push   $0x13
  80156a:	e8 9c fb ff ff       	call   80110b <syscall>
  80156f:	83 c4 18             	add    $0x18,%esp
	return ;
  801572:	90                   	nop
}
  801573:	c9                   	leave  
  801574:	c3                   	ret    

00801575 <sys_rcr2>:
uint32 sys_rcr2()
{
  801575:	55                   	push   %ebp
  801576:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	6a 00                	push   $0x0
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	6a 25                	push   $0x25
  801584:	e8 82 fb ff ff       	call   80110b <syscall>
  801589:	83 c4 18             	add    $0x18,%esp
}
  80158c:	c9                   	leave  
  80158d:	c3                   	ret    

0080158e <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80158e:	55                   	push   %ebp
  80158f:	89 e5                	mov    %esp,%ebp
  801591:	83 ec 04             	sub    $0x4,%esp
  801594:	8b 45 08             	mov    0x8(%ebp),%eax
  801597:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80159a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80159e:	6a 00                	push   $0x0
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	50                   	push   %eax
  8015a7:	6a 26                	push   $0x26
  8015a9:	e8 5d fb ff ff       	call   80110b <syscall>
  8015ae:	83 c4 18             	add    $0x18,%esp
	return ;
  8015b1:	90                   	nop
}
  8015b2:	c9                   	leave  
  8015b3:	c3                   	ret    

008015b4 <rsttst>:
void rsttst()
{
  8015b4:	55                   	push   %ebp
  8015b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8015b7:	6a 00                	push   $0x0
  8015b9:	6a 00                	push   $0x0
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 28                	push   $0x28
  8015c3:	e8 43 fb ff ff       	call   80110b <syscall>
  8015c8:	83 c4 18             	add    $0x18,%esp
	return ;
  8015cb:	90                   	nop
}
  8015cc:	c9                   	leave  
  8015cd:	c3                   	ret    

008015ce <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8015ce:	55                   	push   %ebp
  8015cf:	89 e5                	mov    %esp,%ebp
  8015d1:	83 ec 04             	sub    $0x4,%esp
  8015d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8015d7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8015da:	8b 55 18             	mov    0x18(%ebp),%edx
  8015dd:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8015e1:	52                   	push   %edx
  8015e2:	50                   	push   %eax
  8015e3:	ff 75 10             	pushl  0x10(%ebp)
  8015e6:	ff 75 0c             	pushl  0xc(%ebp)
  8015e9:	ff 75 08             	pushl  0x8(%ebp)
  8015ec:	6a 27                	push   $0x27
  8015ee:	e8 18 fb ff ff       	call   80110b <syscall>
  8015f3:	83 c4 18             	add    $0x18,%esp
	return ;
  8015f6:	90                   	nop
}
  8015f7:	c9                   	leave  
  8015f8:	c3                   	ret    

008015f9 <chktst>:
void chktst(uint32 n)
{
  8015f9:	55                   	push   %ebp
  8015fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 00                	push   $0x0
  801600:	6a 00                	push   $0x0
  801602:	6a 00                	push   $0x0
  801604:	ff 75 08             	pushl  0x8(%ebp)
  801607:	6a 29                	push   $0x29
  801609:	e8 fd fa ff ff       	call   80110b <syscall>
  80160e:	83 c4 18             	add    $0x18,%esp
	return ;
  801611:	90                   	nop
}
  801612:	c9                   	leave  
  801613:	c3                   	ret    

00801614 <inctst>:

void inctst()
{
  801614:	55                   	push   %ebp
  801615:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	6a 00                	push   $0x0
  80161f:	6a 00                	push   $0x0
  801621:	6a 2a                	push   $0x2a
  801623:	e8 e3 fa ff ff       	call   80110b <syscall>
  801628:	83 c4 18             	add    $0x18,%esp
	return ;
  80162b:	90                   	nop
}
  80162c:	c9                   	leave  
  80162d:	c3                   	ret    

0080162e <gettst>:
uint32 gettst()
{
  80162e:	55                   	push   %ebp
  80162f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801631:	6a 00                	push   $0x0
  801633:	6a 00                	push   $0x0
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	6a 2b                	push   $0x2b
  80163d:	e8 c9 fa ff ff       	call   80110b <syscall>
  801642:	83 c4 18             	add    $0x18,%esp
}
  801645:	c9                   	leave  
  801646:	c3                   	ret    

00801647 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801647:	55                   	push   %ebp
  801648:	89 e5                	mov    %esp,%ebp
  80164a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	6a 00                	push   $0x0
  801655:	6a 00                	push   $0x0
  801657:	6a 2c                	push   $0x2c
  801659:	e8 ad fa ff ff       	call   80110b <syscall>
  80165e:	83 c4 18             	add    $0x18,%esp
  801661:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801664:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801668:	75 07                	jne    801671 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80166a:	b8 01 00 00 00       	mov    $0x1,%eax
  80166f:	eb 05                	jmp    801676 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801671:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801676:	c9                   	leave  
  801677:	c3                   	ret    

00801678 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801678:	55                   	push   %ebp
  801679:	89 e5                	mov    %esp,%ebp
  80167b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	6a 00                	push   $0x0
  801684:	6a 00                	push   $0x0
  801686:	6a 00                	push   $0x0
  801688:	6a 2c                	push   $0x2c
  80168a:	e8 7c fa ff ff       	call   80110b <syscall>
  80168f:	83 c4 18             	add    $0x18,%esp
  801692:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801695:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801699:	75 07                	jne    8016a2 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80169b:	b8 01 00 00 00       	mov    $0x1,%eax
  8016a0:	eb 05                	jmp    8016a7 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8016a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016a7:	c9                   	leave  
  8016a8:	c3                   	ret    

008016a9 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8016a9:	55                   	push   %ebp
  8016aa:	89 e5                	mov    %esp,%ebp
  8016ac:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016af:	6a 00                	push   $0x0
  8016b1:	6a 00                	push   $0x0
  8016b3:	6a 00                	push   $0x0
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 2c                	push   $0x2c
  8016bb:	e8 4b fa ff ff       	call   80110b <syscall>
  8016c0:	83 c4 18             	add    $0x18,%esp
  8016c3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8016c6:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8016ca:	75 07                	jne    8016d3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8016cc:	b8 01 00 00 00       	mov    $0x1,%eax
  8016d1:	eb 05                	jmp    8016d8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8016d3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016d8:	c9                   	leave  
  8016d9:	c3                   	ret    

008016da <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8016da:	55                   	push   %ebp
  8016db:	89 e5                	mov    %esp,%ebp
  8016dd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 00                	push   $0x0
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 2c                	push   $0x2c
  8016ec:	e8 1a fa ff ff       	call   80110b <syscall>
  8016f1:	83 c4 18             	add    $0x18,%esp
  8016f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8016f7:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8016fb:	75 07                	jne    801704 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8016fd:	b8 01 00 00 00       	mov    $0x1,%eax
  801702:	eb 05                	jmp    801709 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801704:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801709:	c9                   	leave  
  80170a:	c3                   	ret    

0080170b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80170b:	55                   	push   %ebp
  80170c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	6a 00                	push   $0x0
  801716:	ff 75 08             	pushl  0x8(%ebp)
  801719:	6a 2d                	push   $0x2d
  80171b:	e8 eb f9 ff ff       	call   80110b <syscall>
  801720:	83 c4 18             	add    $0x18,%esp
	return ;
  801723:	90                   	nop
}
  801724:	c9                   	leave  
  801725:	c3                   	ret    

00801726 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801726:	55                   	push   %ebp
  801727:	89 e5                	mov    %esp,%ebp
  801729:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80172a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80172d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801730:	8b 55 0c             	mov    0xc(%ebp),%edx
  801733:	8b 45 08             	mov    0x8(%ebp),%eax
  801736:	6a 00                	push   $0x0
  801738:	53                   	push   %ebx
  801739:	51                   	push   %ecx
  80173a:	52                   	push   %edx
  80173b:	50                   	push   %eax
  80173c:	6a 2e                	push   $0x2e
  80173e:	e8 c8 f9 ff ff       	call   80110b <syscall>
  801743:	83 c4 18             	add    $0x18,%esp
}
  801746:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801749:	c9                   	leave  
  80174a:	c3                   	ret    

0080174b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80174b:	55                   	push   %ebp
  80174c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80174e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801751:	8b 45 08             	mov    0x8(%ebp),%eax
  801754:	6a 00                	push   $0x0
  801756:	6a 00                	push   $0x0
  801758:	6a 00                	push   $0x0
  80175a:	52                   	push   %edx
  80175b:	50                   	push   %eax
  80175c:	6a 2f                	push   $0x2f
  80175e:	e8 a8 f9 ff ff       	call   80110b <syscall>
  801763:	83 c4 18             	add    $0x18,%esp
}
  801766:	c9                   	leave  
  801767:	c3                   	ret    

00801768 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801768:	55                   	push   %ebp
  801769:	89 e5                	mov    %esp,%ebp
  80176b:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  80176e:	8b 55 08             	mov    0x8(%ebp),%edx
  801771:	89 d0                	mov    %edx,%eax
  801773:	c1 e0 02             	shl    $0x2,%eax
  801776:	01 d0                	add    %edx,%eax
  801778:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80177f:	01 d0                	add    %edx,%eax
  801781:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801788:	01 d0                	add    %edx,%eax
  80178a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801791:	01 d0                	add    %edx,%eax
  801793:	c1 e0 04             	shl    $0x4,%eax
  801796:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801799:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8017a0:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8017a3:	83 ec 0c             	sub    $0xc,%esp
  8017a6:	50                   	push   %eax
  8017a7:	e8 76 fd ff ff       	call   801522 <sys_get_virtual_time>
  8017ac:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8017af:	eb 41                	jmp    8017f2 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8017b1:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8017b4:	83 ec 0c             	sub    $0xc,%esp
  8017b7:	50                   	push   %eax
  8017b8:	e8 65 fd ff ff       	call   801522 <sys_get_virtual_time>
  8017bd:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8017c0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8017c3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8017c6:	29 c2                	sub    %eax,%edx
  8017c8:	89 d0                	mov    %edx,%eax
  8017ca:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8017cd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8017d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8017d3:	89 d1                	mov    %edx,%ecx
  8017d5:	29 c1                	sub    %eax,%ecx
  8017d7:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8017da:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8017dd:	39 c2                	cmp    %eax,%edx
  8017df:	0f 97 c0             	seta   %al
  8017e2:	0f b6 c0             	movzbl %al,%eax
  8017e5:	29 c1                	sub    %eax,%ecx
  8017e7:	89 c8                	mov    %ecx,%eax
  8017e9:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8017ec:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8017ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  8017f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017f5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017f8:	72 b7                	jb     8017b1 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  8017fa:	90                   	nop
  8017fb:	c9                   	leave  
  8017fc:	c3                   	ret    

008017fd <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  8017fd:	55                   	push   %ebp
  8017fe:	89 e5                	mov    %esp,%ebp
  801800:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801803:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  80180a:	eb 03                	jmp    80180f <busy_wait+0x12>
  80180c:	ff 45 fc             	incl   -0x4(%ebp)
  80180f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801812:	3b 45 08             	cmp    0x8(%ebp),%eax
  801815:	72 f5                	jb     80180c <busy_wait+0xf>
	return i;
  801817:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80181a:	c9                   	leave  
  80181b:	c3                   	ret    

0080181c <__udivdi3>:
  80181c:	55                   	push   %ebp
  80181d:	57                   	push   %edi
  80181e:	56                   	push   %esi
  80181f:	53                   	push   %ebx
  801820:	83 ec 1c             	sub    $0x1c,%esp
  801823:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801827:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80182b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80182f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801833:	89 ca                	mov    %ecx,%edx
  801835:	89 f8                	mov    %edi,%eax
  801837:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80183b:	85 f6                	test   %esi,%esi
  80183d:	75 2d                	jne    80186c <__udivdi3+0x50>
  80183f:	39 cf                	cmp    %ecx,%edi
  801841:	77 65                	ja     8018a8 <__udivdi3+0x8c>
  801843:	89 fd                	mov    %edi,%ebp
  801845:	85 ff                	test   %edi,%edi
  801847:	75 0b                	jne    801854 <__udivdi3+0x38>
  801849:	b8 01 00 00 00       	mov    $0x1,%eax
  80184e:	31 d2                	xor    %edx,%edx
  801850:	f7 f7                	div    %edi
  801852:	89 c5                	mov    %eax,%ebp
  801854:	31 d2                	xor    %edx,%edx
  801856:	89 c8                	mov    %ecx,%eax
  801858:	f7 f5                	div    %ebp
  80185a:	89 c1                	mov    %eax,%ecx
  80185c:	89 d8                	mov    %ebx,%eax
  80185e:	f7 f5                	div    %ebp
  801860:	89 cf                	mov    %ecx,%edi
  801862:	89 fa                	mov    %edi,%edx
  801864:	83 c4 1c             	add    $0x1c,%esp
  801867:	5b                   	pop    %ebx
  801868:	5e                   	pop    %esi
  801869:	5f                   	pop    %edi
  80186a:	5d                   	pop    %ebp
  80186b:	c3                   	ret    
  80186c:	39 ce                	cmp    %ecx,%esi
  80186e:	77 28                	ja     801898 <__udivdi3+0x7c>
  801870:	0f bd fe             	bsr    %esi,%edi
  801873:	83 f7 1f             	xor    $0x1f,%edi
  801876:	75 40                	jne    8018b8 <__udivdi3+0x9c>
  801878:	39 ce                	cmp    %ecx,%esi
  80187a:	72 0a                	jb     801886 <__udivdi3+0x6a>
  80187c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801880:	0f 87 9e 00 00 00    	ja     801924 <__udivdi3+0x108>
  801886:	b8 01 00 00 00       	mov    $0x1,%eax
  80188b:	89 fa                	mov    %edi,%edx
  80188d:	83 c4 1c             	add    $0x1c,%esp
  801890:	5b                   	pop    %ebx
  801891:	5e                   	pop    %esi
  801892:	5f                   	pop    %edi
  801893:	5d                   	pop    %ebp
  801894:	c3                   	ret    
  801895:	8d 76 00             	lea    0x0(%esi),%esi
  801898:	31 ff                	xor    %edi,%edi
  80189a:	31 c0                	xor    %eax,%eax
  80189c:	89 fa                	mov    %edi,%edx
  80189e:	83 c4 1c             	add    $0x1c,%esp
  8018a1:	5b                   	pop    %ebx
  8018a2:	5e                   	pop    %esi
  8018a3:	5f                   	pop    %edi
  8018a4:	5d                   	pop    %ebp
  8018a5:	c3                   	ret    
  8018a6:	66 90                	xchg   %ax,%ax
  8018a8:	89 d8                	mov    %ebx,%eax
  8018aa:	f7 f7                	div    %edi
  8018ac:	31 ff                	xor    %edi,%edi
  8018ae:	89 fa                	mov    %edi,%edx
  8018b0:	83 c4 1c             	add    $0x1c,%esp
  8018b3:	5b                   	pop    %ebx
  8018b4:	5e                   	pop    %esi
  8018b5:	5f                   	pop    %edi
  8018b6:	5d                   	pop    %ebp
  8018b7:	c3                   	ret    
  8018b8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8018bd:	89 eb                	mov    %ebp,%ebx
  8018bf:	29 fb                	sub    %edi,%ebx
  8018c1:	89 f9                	mov    %edi,%ecx
  8018c3:	d3 e6                	shl    %cl,%esi
  8018c5:	89 c5                	mov    %eax,%ebp
  8018c7:	88 d9                	mov    %bl,%cl
  8018c9:	d3 ed                	shr    %cl,%ebp
  8018cb:	89 e9                	mov    %ebp,%ecx
  8018cd:	09 f1                	or     %esi,%ecx
  8018cf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8018d3:	89 f9                	mov    %edi,%ecx
  8018d5:	d3 e0                	shl    %cl,%eax
  8018d7:	89 c5                	mov    %eax,%ebp
  8018d9:	89 d6                	mov    %edx,%esi
  8018db:	88 d9                	mov    %bl,%cl
  8018dd:	d3 ee                	shr    %cl,%esi
  8018df:	89 f9                	mov    %edi,%ecx
  8018e1:	d3 e2                	shl    %cl,%edx
  8018e3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8018e7:	88 d9                	mov    %bl,%cl
  8018e9:	d3 e8                	shr    %cl,%eax
  8018eb:	09 c2                	or     %eax,%edx
  8018ed:	89 d0                	mov    %edx,%eax
  8018ef:	89 f2                	mov    %esi,%edx
  8018f1:	f7 74 24 0c          	divl   0xc(%esp)
  8018f5:	89 d6                	mov    %edx,%esi
  8018f7:	89 c3                	mov    %eax,%ebx
  8018f9:	f7 e5                	mul    %ebp
  8018fb:	39 d6                	cmp    %edx,%esi
  8018fd:	72 19                	jb     801918 <__udivdi3+0xfc>
  8018ff:	74 0b                	je     80190c <__udivdi3+0xf0>
  801901:	89 d8                	mov    %ebx,%eax
  801903:	31 ff                	xor    %edi,%edi
  801905:	e9 58 ff ff ff       	jmp    801862 <__udivdi3+0x46>
  80190a:	66 90                	xchg   %ax,%ax
  80190c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801910:	89 f9                	mov    %edi,%ecx
  801912:	d3 e2                	shl    %cl,%edx
  801914:	39 c2                	cmp    %eax,%edx
  801916:	73 e9                	jae    801901 <__udivdi3+0xe5>
  801918:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80191b:	31 ff                	xor    %edi,%edi
  80191d:	e9 40 ff ff ff       	jmp    801862 <__udivdi3+0x46>
  801922:	66 90                	xchg   %ax,%ax
  801924:	31 c0                	xor    %eax,%eax
  801926:	e9 37 ff ff ff       	jmp    801862 <__udivdi3+0x46>
  80192b:	90                   	nop

0080192c <__umoddi3>:
  80192c:	55                   	push   %ebp
  80192d:	57                   	push   %edi
  80192e:	56                   	push   %esi
  80192f:	53                   	push   %ebx
  801930:	83 ec 1c             	sub    $0x1c,%esp
  801933:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801937:	8b 74 24 34          	mov    0x34(%esp),%esi
  80193b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80193f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801943:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801947:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80194b:	89 f3                	mov    %esi,%ebx
  80194d:	89 fa                	mov    %edi,%edx
  80194f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801953:	89 34 24             	mov    %esi,(%esp)
  801956:	85 c0                	test   %eax,%eax
  801958:	75 1a                	jne    801974 <__umoddi3+0x48>
  80195a:	39 f7                	cmp    %esi,%edi
  80195c:	0f 86 a2 00 00 00    	jbe    801a04 <__umoddi3+0xd8>
  801962:	89 c8                	mov    %ecx,%eax
  801964:	89 f2                	mov    %esi,%edx
  801966:	f7 f7                	div    %edi
  801968:	89 d0                	mov    %edx,%eax
  80196a:	31 d2                	xor    %edx,%edx
  80196c:	83 c4 1c             	add    $0x1c,%esp
  80196f:	5b                   	pop    %ebx
  801970:	5e                   	pop    %esi
  801971:	5f                   	pop    %edi
  801972:	5d                   	pop    %ebp
  801973:	c3                   	ret    
  801974:	39 f0                	cmp    %esi,%eax
  801976:	0f 87 ac 00 00 00    	ja     801a28 <__umoddi3+0xfc>
  80197c:	0f bd e8             	bsr    %eax,%ebp
  80197f:	83 f5 1f             	xor    $0x1f,%ebp
  801982:	0f 84 ac 00 00 00    	je     801a34 <__umoddi3+0x108>
  801988:	bf 20 00 00 00       	mov    $0x20,%edi
  80198d:	29 ef                	sub    %ebp,%edi
  80198f:	89 fe                	mov    %edi,%esi
  801991:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801995:	89 e9                	mov    %ebp,%ecx
  801997:	d3 e0                	shl    %cl,%eax
  801999:	89 d7                	mov    %edx,%edi
  80199b:	89 f1                	mov    %esi,%ecx
  80199d:	d3 ef                	shr    %cl,%edi
  80199f:	09 c7                	or     %eax,%edi
  8019a1:	89 e9                	mov    %ebp,%ecx
  8019a3:	d3 e2                	shl    %cl,%edx
  8019a5:	89 14 24             	mov    %edx,(%esp)
  8019a8:	89 d8                	mov    %ebx,%eax
  8019aa:	d3 e0                	shl    %cl,%eax
  8019ac:	89 c2                	mov    %eax,%edx
  8019ae:	8b 44 24 08          	mov    0x8(%esp),%eax
  8019b2:	d3 e0                	shl    %cl,%eax
  8019b4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8019b8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8019bc:	89 f1                	mov    %esi,%ecx
  8019be:	d3 e8                	shr    %cl,%eax
  8019c0:	09 d0                	or     %edx,%eax
  8019c2:	d3 eb                	shr    %cl,%ebx
  8019c4:	89 da                	mov    %ebx,%edx
  8019c6:	f7 f7                	div    %edi
  8019c8:	89 d3                	mov    %edx,%ebx
  8019ca:	f7 24 24             	mull   (%esp)
  8019cd:	89 c6                	mov    %eax,%esi
  8019cf:	89 d1                	mov    %edx,%ecx
  8019d1:	39 d3                	cmp    %edx,%ebx
  8019d3:	0f 82 87 00 00 00    	jb     801a60 <__umoddi3+0x134>
  8019d9:	0f 84 91 00 00 00    	je     801a70 <__umoddi3+0x144>
  8019df:	8b 54 24 04          	mov    0x4(%esp),%edx
  8019e3:	29 f2                	sub    %esi,%edx
  8019e5:	19 cb                	sbb    %ecx,%ebx
  8019e7:	89 d8                	mov    %ebx,%eax
  8019e9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8019ed:	d3 e0                	shl    %cl,%eax
  8019ef:	89 e9                	mov    %ebp,%ecx
  8019f1:	d3 ea                	shr    %cl,%edx
  8019f3:	09 d0                	or     %edx,%eax
  8019f5:	89 e9                	mov    %ebp,%ecx
  8019f7:	d3 eb                	shr    %cl,%ebx
  8019f9:	89 da                	mov    %ebx,%edx
  8019fb:	83 c4 1c             	add    $0x1c,%esp
  8019fe:	5b                   	pop    %ebx
  8019ff:	5e                   	pop    %esi
  801a00:	5f                   	pop    %edi
  801a01:	5d                   	pop    %ebp
  801a02:	c3                   	ret    
  801a03:	90                   	nop
  801a04:	89 fd                	mov    %edi,%ebp
  801a06:	85 ff                	test   %edi,%edi
  801a08:	75 0b                	jne    801a15 <__umoddi3+0xe9>
  801a0a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a0f:	31 d2                	xor    %edx,%edx
  801a11:	f7 f7                	div    %edi
  801a13:	89 c5                	mov    %eax,%ebp
  801a15:	89 f0                	mov    %esi,%eax
  801a17:	31 d2                	xor    %edx,%edx
  801a19:	f7 f5                	div    %ebp
  801a1b:	89 c8                	mov    %ecx,%eax
  801a1d:	f7 f5                	div    %ebp
  801a1f:	89 d0                	mov    %edx,%eax
  801a21:	e9 44 ff ff ff       	jmp    80196a <__umoddi3+0x3e>
  801a26:	66 90                	xchg   %ax,%ax
  801a28:	89 c8                	mov    %ecx,%eax
  801a2a:	89 f2                	mov    %esi,%edx
  801a2c:	83 c4 1c             	add    $0x1c,%esp
  801a2f:	5b                   	pop    %ebx
  801a30:	5e                   	pop    %esi
  801a31:	5f                   	pop    %edi
  801a32:	5d                   	pop    %ebp
  801a33:	c3                   	ret    
  801a34:	3b 04 24             	cmp    (%esp),%eax
  801a37:	72 06                	jb     801a3f <__umoddi3+0x113>
  801a39:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801a3d:	77 0f                	ja     801a4e <__umoddi3+0x122>
  801a3f:	89 f2                	mov    %esi,%edx
  801a41:	29 f9                	sub    %edi,%ecx
  801a43:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801a47:	89 14 24             	mov    %edx,(%esp)
  801a4a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a4e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801a52:	8b 14 24             	mov    (%esp),%edx
  801a55:	83 c4 1c             	add    $0x1c,%esp
  801a58:	5b                   	pop    %ebx
  801a59:	5e                   	pop    %esi
  801a5a:	5f                   	pop    %edi
  801a5b:	5d                   	pop    %ebp
  801a5c:	c3                   	ret    
  801a5d:	8d 76 00             	lea    0x0(%esi),%esi
  801a60:	2b 04 24             	sub    (%esp),%eax
  801a63:	19 fa                	sbb    %edi,%edx
  801a65:	89 d1                	mov    %edx,%ecx
  801a67:	89 c6                	mov    %eax,%esi
  801a69:	e9 71 ff ff ff       	jmp    8019df <__umoddi3+0xb3>
  801a6e:	66 90                	xchg   %ax,%ax
  801a70:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801a74:	72 ea                	jb     801a60 <__umoddi3+0x134>
  801a76:	89 d9                	mov    %ebx,%ecx
  801a78:	e9 62 ff ff ff       	jmp    8019df <__umoddi3+0xb3>
