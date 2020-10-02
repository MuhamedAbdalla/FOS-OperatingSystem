
obj/user/ef_MidTermEx_Master:     file format elf32-i386


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
  800031:	e8 94 01 00 00       	call   8001ca <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Scenario that tests the usage of shared variables
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	/*[1] CREATE SHARED VARIABLE & INITIALIZE IT*/
	int *X = smalloc("X", sizeof(int) , 1) ;
  80003e:	83 ec 04             	sub    $0x4,%esp
  800041:	6a 01                	push   $0x1
  800043:	6a 04                	push   $0x4
  800045:	68 a0 20 80 00       	push   $0x8020a0
  80004a:	e8 f0 12 00 00       	call   80133f <smalloc>
  80004f:	83 c4 10             	add    $0x10,%esp
  800052:	89 45 f4             	mov    %eax,-0xc(%ebp)
	*X = 5 ;
  800055:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800058:	c7 00 05 00 00 00    	movl   $0x5,(%eax)

	/*[2] SPECIFY WHETHER TO USE SEMAPHORE OR NOT*/
	//cprintf("Do you want to use semaphore (y/n)? ") ;
	//char select = getchar() ;
	char select = 'y';
  80005e:	c6 45 f3 79          	movb   $0x79,-0xd(%ebp)
	//cputchar(select);
	//cputchar('\n');

	/*[3] SHARE THIS SELECTION WITH OTHER PROCESSES*/
	int *useSem = smalloc("useSem", sizeof(int) , 0) ;
  800062:	83 ec 04             	sub    $0x4,%esp
  800065:	6a 00                	push   $0x0
  800067:	6a 04                	push   $0x4
  800069:	68 a2 20 80 00       	push   $0x8020a2
  80006e:	e8 cc 12 00 00       	call   80133f <smalloc>
  800073:	83 c4 10             	add    $0x10,%esp
  800076:	89 45 ec             	mov    %eax,-0x14(%ebp)
	*useSem = 0 ;
  800079:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80007c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	if (select == 'Y' || select == 'y')
  800082:	80 7d f3 59          	cmpb   $0x59,-0xd(%ebp)
  800086:	74 06                	je     80008e <_main+0x56>
  800088:	80 7d f3 79          	cmpb   $0x79,-0xd(%ebp)
  80008c:	75 09                	jne    800097 <_main+0x5f>
		*useSem = 1 ;
  80008e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800091:	c7 00 01 00 00 00    	movl   $0x1,(%eax)

	if (*useSem == 1)
  800097:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80009a:	8b 00                	mov    (%eax),%eax
  80009c:	83 f8 01             	cmp    $0x1,%eax
  80009f:	75 12                	jne    8000b3 <_main+0x7b>
	{
		sys_createSemaphore("T", 0);
  8000a1:	83 ec 08             	sub    $0x8,%esp
  8000a4:	6a 00                	push   $0x0
  8000a6:	68 a9 20 80 00       	push   $0x8020a9
  8000ab:	e8 4c 17 00 00       	call   8017fc <sys_createSemaphore>
  8000b0:	83 c4 10             	add    $0x10,%esp
	}

	/*[4] CREATE AND RUN ProcessA & ProcessB*/

	//Create the check-finishing counter
	int *numOfFinished = smalloc("finishedCount", sizeof(int), 1) ;
  8000b3:	83 ec 04             	sub    $0x4,%esp
  8000b6:	6a 01                	push   $0x1
  8000b8:	6a 04                	push   $0x4
  8000ba:	68 ab 20 80 00       	push   $0x8020ab
  8000bf:	e8 7b 12 00 00       	call   80133f <smalloc>
  8000c4:	83 c4 10             	add    $0x10,%esp
  8000c7:	89 45 e8             	mov    %eax,-0x18(%ebp)
	*numOfFinished = 0 ;
  8000ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000cd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	//Create the 2 processes
	int32 envIdProcessA = sys_create_env("midterm_a", (myEnv->page_WS_max_size),(myEnv->SecondListSize), 50);
  8000d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d8:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000de:	89 c2                	mov    %eax,%edx
  8000e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e5:	8b 40 74             	mov    0x74(%eax),%eax
  8000e8:	6a 32                	push   $0x32
  8000ea:	52                   	push   %edx
  8000eb:	50                   	push   %eax
  8000ec:	68 b9 20 80 00       	push   $0x8020b9
  8000f1:	e8 17 18 00 00       	call   80190d <sys_create_env>
  8000f6:	83 c4 10             	add    $0x10,%esp
  8000f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int32 envIdProcessB = sys_create_env("midterm_b", (myEnv->page_WS_max_size),(myEnv->SecondListSize), 50);
  8000fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800101:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800107:	89 c2                	mov    %eax,%edx
  800109:	a1 20 30 80 00       	mov    0x803020,%eax
  80010e:	8b 40 74             	mov    0x74(%eax),%eax
  800111:	6a 32                	push   $0x32
  800113:	52                   	push   %edx
  800114:	50                   	push   %eax
  800115:	68 c3 20 80 00       	push   $0x8020c3
  80011a:	e8 ee 17 00 00       	call   80190d <sys_create_env>
  80011f:	83 c4 10             	add    $0x10,%esp
  800122:	89 45 e0             	mov    %eax,-0x20(%ebp)

	//Run the 2 processes
	sys_run_env(envIdProcessA);
  800125:	83 ec 0c             	sub    $0xc,%esp
  800128:	ff 75 e4             	pushl  -0x1c(%ebp)
  80012b:	e8 fb 17 00 00       	call   80192b <sys_run_env>
  800130:	83 c4 10             	add    $0x10,%esp
	env_sleep(10000);
  800133:	83 ec 0c             	sub    $0xc,%esp
  800136:	68 10 27 00 00       	push   $0x2710
  80013b:	e8 69 1a 00 00       	call   801ba9 <env_sleep>
  800140:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdProcessB);
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	ff 75 e0             	pushl  -0x20(%ebp)
  800149:	e8 dd 17 00 00       	call   80192b <sys_run_env>
  80014e:	83 c4 10             	add    $0x10,%esp

	/*[5] BUSY-WAIT TILL FINISHING BOTH PROCESSES*/
	while (*numOfFinished != 2) ;
  800151:	90                   	nop
  800152:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800155:	8b 00                	mov    (%eax),%eax
  800157:	83 f8 02             	cmp    $0x2,%eax
  80015a:	75 f6                	jne    800152 <_main+0x11a>

	/*[6] PRINT X*/
	cprintf("Final value of X = %d\n", *X);
  80015c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80015f:	8b 00                	mov    (%eax),%eax
  800161:	83 ec 08             	sub    $0x8,%esp
  800164:	50                   	push   %eax
  800165:	68 cd 20 80 00       	push   $0x8020cd
  80016a:	e8 74 02 00 00       	call   8003e3 <cprintf>
  80016f:	83 c4 10             	add    $0x10,%esp

	int32 parentenvID = sys_getparentenvid();
  800172:	e8 8f 14 00 00       	call   801606 <sys_getparentenvid>
  800177:	89 45 dc             	mov    %eax,-0x24(%ebp)
	if(parentenvID > 0)
  80017a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80017e:	7e 47                	jle    8001c7 <_main+0x18f>
	{
		//Get the check-finishing counter
		int *AllFinish = NULL;
  800180:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		AllFinish = sget(parentenvID, "finishedCount") ;
  800187:	83 ec 08             	sub    $0x8,%esp
  80018a:	68 ab 20 80 00       	push   $0x8020ab
  80018f:	ff 75 dc             	pushl  -0x24(%ebp)
  800192:	e8 cb 11 00 00       	call   801362 <sget>
  800197:	83 c4 10             	add    $0x10,%esp
  80019a:	89 45 d8             	mov    %eax,-0x28(%ebp)
		sys_free_env(envIdProcessA);
  80019d:	83 ec 0c             	sub    $0xc,%esp
  8001a0:	ff 75 e4             	pushl  -0x1c(%ebp)
  8001a3:	e8 9f 17 00 00       	call   801947 <sys_free_env>
  8001a8:	83 c4 10             	add    $0x10,%esp
		sys_free_env(envIdProcessB);
  8001ab:	83 ec 0c             	sub    $0xc,%esp
  8001ae:	ff 75 e0             	pushl  -0x20(%ebp)
  8001b1:	e8 91 17 00 00       	call   801947 <sys_free_env>
  8001b6:	83 c4 10             	add    $0x10,%esp
		(*AllFinish)++ ;
  8001b9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001bc:	8b 00                	mov    (%eax),%eax
  8001be:	8d 50 01             	lea    0x1(%eax),%edx
  8001c1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001c4:	89 10                	mov    %edx,(%eax)
	}

	return;
  8001c6:	90                   	nop
  8001c7:	90                   	nop
}
  8001c8:	c9                   	leave  
  8001c9:	c3                   	ret    

008001ca <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001ca:	55                   	push   %ebp
  8001cb:	89 e5                	mov    %esp,%ebp
  8001cd:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001d0:	e8 18 14 00 00       	call   8015ed <sys_getenvindex>
  8001d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001db:	89 d0                	mov    %edx,%eax
  8001dd:	c1 e0 03             	shl    $0x3,%eax
  8001e0:	01 d0                	add    %edx,%eax
  8001e2:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8001e9:	01 c8                	add    %ecx,%eax
  8001eb:	01 c0                	add    %eax,%eax
  8001ed:	01 d0                	add    %edx,%eax
  8001ef:	01 c0                	add    %eax,%eax
  8001f1:	01 d0                	add    %edx,%eax
  8001f3:	89 c2                	mov    %eax,%edx
  8001f5:	c1 e2 05             	shl    $0x5,%edx
  8001f8:	29 c2                	sub    %eax,%edx
  8001fa:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800201:	89 c2                	mov    %eax,%edx
  800203:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800209:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80020e:	a1 20 30 80 00       	mov    0x803020,%eax
  800213:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800219:	84 c0                	test   %al,%al
  80021b:	74 0f                	je     80022c <libmain+0x62>
		binaryname = myEnv->prog_name;
  80021d:	a1 20 30 80 00       	mov    0x803020,%eax
  800222:	05 40 3c 01 00       	add    $0x13c40,%eax
  800227:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80022c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800230:	7e 0a                	jle    80023c <libmain+0x72>
		binaryname = argv[0];
  800232:	8b 45 0c             	mov    0xc(%ebp),%eax
  800235:	8b 00                	mov    (%eax),%eax
  800237:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80023c:	83 ec 08             	sub    $0x8,%esp
  80023f:	ff 75 0c             	pushl  0xc(%ebp)
  800242:	ff 75 08             	pushl  0x8(%ebp)
  800245:	e8 ee fd ff ff       	call   800038 <_main>
  80024a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80024d:	e8 36 15 00 00       	call   801788 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800252:	83 ec 0c             	sub    $0xc,%esp
  800255:	68 fc 20 80 00       	push   $0x8020fc
  80025a:	e8 84 01 00 00       	call   8003e3 <cprintf>
  80025f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800262:	a1 20 30 80 00       	mov    0x803020,%eax
  800267:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80026d:	a1 20 30 80 00       	mov    0x803020,%eax
  800272:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800278:	83 ec 04             	sub    $0x4,%esp
  80027b:	52                   	push   %edx
  80027c:	50                   	push   %eax
  80027d:	68 24 21 80 00       	push   $0x802124
  800282:	e8 5c 01 00 00       	call   8003e3 <cprintf>
  800287:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80028a:	a1 20 30 80 00       	mov    0x803020,%eax
  80028f:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800295:	a1 20 30 80 00       	mov    0x803020,%eax
  80029a:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8002a0:	83 ec 04             	sub    $0x4,%esp
  8002a3:	52                   	push   %edx
  8002a4:	50                   	push   %eax
  8002a5:	68 4c 21 80 00       	push   $0x80214c
  8002aa:	e8 34 01 00 00       	call   8003e3 <cprintf>
  8002af:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002b2:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b7:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8002bd:	83 ec 08             	sub    $0x8,%esp
  8002c0:	50                   	push   %eax
  8002c1:	68 8d 21 80 00       	push   $0x80218d
  8002c6:	e8 18 01 00 00       	call   8003e3 <cprintf>
  8002cb:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002ce:	83 ec 0c             	sub    $0xc,%esp
  8002d1:	68 fc 20 80 00       	push   $0x8020fc
  8002d6:	e8 08 01 00 00       	call   8003e3 <cprintf>
  8002db:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002de:	e8 bf 14 00 00       	call   8017a2 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002e3:	e8 19 00 00 00       	call   800301 <exit>
}
  8002e8:	90                   	nop
  8002e9:	c9                   	leave  
  8002ea:	c3                   	ret    

008002eb <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002eb:	55                   	push   %ebp
  8002ec:	89 e5                	mov    %esp,%ebp
  8002ee:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002f1:	83 ec 0c             	sub    $0xc,%esp
  8002f4:	6a 00                	push   $0x0
  8002f6:	e8 be 12 00 00       	call   8015b9 <sys_env_destroy>
  8002fb:	83 c4 10             	add    $0x10,%esp
}
  8002fe:	90                   	nop
  8002ff:	c9                   	leave  
  800300:	c3                   	ret    

00800301 <exit>:

void
exit(void)
{
  800301:	55                   	push   %ebp
  800302:	89 e5                	mov    %esp,%ebp
  800304:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800307:	e8 13 13 00 00       	call   80161f <sys_env_exit>
}
  80030c:	90                   	nop
  80030d:	c9                   	leave  
  80030e:	c3                   	ret    

0080030f <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80030f:	55                   	push   %ebp
  800310:	89 e5                	mov    %esp,%ebp
  800312:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800315:	8b 45 0c             	mov    0xc(%ebp),%eax
  800318:	8b 00                	mov    (%eax),%eax
  80031a:	8d 48 01             	lea    0x1(%eax),%ecx
  80031d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800320:	89 0a                	mov    %ecx,(%edx)
  800322:	8b 55 08             	mov    0x8(%ebp),%edx
  800325:	88 d1                	mov    %dl,%cl
  800327:	8b 55 0c             	mov    0xc(%ebp),%edx
  80032a:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80032e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800331:	8b 00                	mov    (%eax),%eax
  800333:	3d ff 00 00 00       	cmp    $0xff,%eax
  800338:	75 2c                	jne    800366 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80033a:	a0 24 30 80 00       	mov    0x803024,%al
  80033f:	0f b6 c0             	movzbl %al,%eax
  800342:	8b 55 0c             	mov    0xc(%ebp),%edx
  800345:	8b 12                	mov    (%edx),%edx
  800347:	89 d1                	mov    %edx,%ecx
  800349:	8b 55 0c             	mov    0xc(%ebp),%edx
  80034c:	83 c2 08             	add    $0x8,%edx
  80034f:	83 ec 04             	sub    $0x4,%esp
  800352:	50                   	push   %eax
  800353:	51                   	push   %ecx
  800354:	52                   	push   %edx
  800355:	e8 1d 12 00 00       	call   801577 <sys_cputs>
  80035a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80035d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800360:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800366:	8b 45 0c             	mov    0xc(%ebp),%eax
  800369:	8b 40 04             	mov    0x4(%eax),%eax
  80036c:	8d 50 01             	lea    0x1(%eax),%edx
  80036f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800372:	89 50 04             	mov    %edx,0x4(%eax)
}
  800375:	90                   	nop
  800376:	c9                   	leave  
  800377:	c3                   	ret    

00800378 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800378:	55                   	push   %ebp
  800379:	89 e5                	mov    %esp,%ebp
  80037b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800381:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800388:	00 00 00 
	b.cnt = 0;
  80038b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800392:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800395:	ff 75 0c             	pushl  0xc(%ebp)
  800398:	ff 75 08             	pushl  0x8(%ebp)
  80039b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003a1:	50                   	push   %eax
  8003a2:	68 0f 03 80 00       	push   $0x80030f
  8003a7:	e8 11 02 00 00       	call   8005bd <vprintfmt>
  8003ac:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8003af:	a0 24 30 80 00       	mov    0x803024,%al
  8003b4:	0f b6 c0             	movzbl %al,%eax
  8003b7:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8003bd:	83 ec 04             	sub    $0x4,%esp
  8003c0:	50                   	push   %eax
  8003c1:	52                   	push   %edx
  8003c2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003c8:	83 c0 08             	add    $0x8,%eax
  8003cb:	50                   	push   %eax
  8003cc:	e8 a6 11 00 00       	call   801577 <sys_cputs>
  8003d1:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8003d4:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8003db:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8003e1:	c9                   	leave  
  8003e2:	c3                   	ret    

008003e3 <cprintf>:

int cprintf(const char *fmt, ...) {
  8003e3:	55                   	push   %ebp
  8003e4:	89 e5                	mov    %esp,%ebp
  8003e6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8003e9:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8003f0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f9:	83 ec 08             	sub    $0x8,%esp
  8003fc:	ff 75 f4             	pushl  -0xc(%ebp)
  8003ff:	50                   	push   %eax
  800400:	e8 73 ff ff ff       	call   800378 <vcprintf>
  800405:	83 c4 10             	add    $0x10,%esp
  800408:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80040b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80040e:	c9                   	leave  
  80040f:	c3                   	ret    

00800410 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800410:	55                   	push   %ebp
  800411:	89 e5                	mov    %esp,%ebp
  800413:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800416:	e8 6d 13 00 00       	call   801788 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80041b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80041e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800421:	8b 45 08             	mov    0x8(%ebp),%eax
  800424:	83 ec 08             	sub    $0x8,%esp
  800427:	ff 75 f4             	pushl  -0xc(%ebp)
  80042a:	50                   	push   %eax
  80042b:	e8 48 ff ff ff       	call   800378 <vcprintf>
  800430:	83 c4 10             	add    $0x10,%esp
  800433:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800436:	e8 67 13 00 00       	call   8017a2 <sys_enable_interrupt>
	return cnt;
  80043b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80043e:	c9                   	leave  
  80043f:	c3                   	ret    

00800440 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800440:	55                   	push   %ebp
  800441:	89 e5                	mov    %esp,%ebp
  800443:	53                   	push   %ebx
  800444:	83 ec 14             	sub    $0x14,%esp
  800447:	8b 45 10             	mov    0x10(%ebp),%eax
  80044a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80044d:	8b 45 14             	mov    0x14(%ebp),%eax
  800450:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800453:	8b 45 18             	mov    0x18(%ebp),%eax
  800456:	ba 00 00 00 00       	mov    $0x0,%edx
  80045b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80045e:	77 55                	ja     8004b5 <printnum+0x75>
  800460:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800463:	72 05                	jb     80046a <printnum+0x2a>
  800465:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800468:	77 4b                	ja     8004b5 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80046a:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80046d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800470:	8b 45 18             	mov    0x18(%ebp),%eax
  800473:	ba 00 00 00 00       	mov    $0x0,%edx
  800478:	52                   	push   %edx
  800479:	50                   	push   %eax
  80047a:	ff 75 f4             	pushl  -0xc(%ebp)
  80047d:	ff 75 f0             	pushl  -0x10(%ebp)
  800480:	e8 a7 19 00 00       	call   801e2c <__udivdi3>
  800485:	83 c4 10             	add    $0x10,%esp
  800488:	83 ec 04             	sub    $0x4,%esp
  80048b:	ff 75 20             	pushl  0x20(%ebp)
  80048e:	53                   	push   %ebx
  80048f:	ff 75 18             	pushl  0x18(%ebp)
  800492:	52                   	push   %edx
  800493:	50                   	push   %eax
  800494:	ff 75 0c             	pushl  0xc(%ebp)
  800497:	ff 75 08             	pushl  0x8(%ebp)
  80049a:	e8 a1 ff ff ff       	call   800440 <printnum>
  80049f:	83 c4 20             	add    $0x20,%esp
  8004a2:	eb 1a                	jmp    8004be <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8004a4:	83 ec 08             	sub    $0x8,%esp
  8004a7:	ff 75 0c             	pushl  0xc(%ebp)
  8004aa:	ff 75 20             	pushl  0x20(%ebp)
  8004ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b0:	ff d0                	call   *%eax
  8004b2:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8004b5:	ff 4d 1c             	decl   0x1c(%ebp)
  8004b8:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8004bc:	7f e6                	jg     8004a4 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8004be:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8004c1:	bb 00 00 00 00       	mov    $0x0,%ebx
  8004c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8004cc:	53                   	push   %ebx
  8004cd:	51                   	push   %ecx
  8004ce:	52                   	push   %edx
  8004cf:	50                   	push   %eax
  8004d0:	e8 67 1a 00 00       	call   801f3c <__umoddi3>
  8004d5:	83 c4 10             	add    $0x10,%esp
  8004d8:	05 d4 23 80 00       	add    $0x8023d4,%eax
  8004dd:	8a 00                	mov    (%eax),%al
  8004df:	0f be c0             	movsbl %al,%eax
  8004e2:	83 ec 08             	sub    $0x8,%esp
  8004e5:	ff 75 0c             	pushl  0xc(%ebp)
  8004e8:	50                   	push   %eax
  8004e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ec:	ff d0                	call   *%eax
  8004ee:	83 c4 10             	add    $0x10,%esp
}
  8004f1:	90                   	nop
  8004f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8004f5:	c9                   	leave  
  8004f6:	c3                   	ret    

008004f7 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8004f7:	55                   	push   %ebp
  8004f8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004fa:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004fe:	7e 1c                	jle    80051c <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800500:	8b 45 08             	mov    0x8(%ebp),%eax
  800503:	8b 00                	mov    (%eax),%eax
  800505:	8d 50 08             	lea    0x8(%eax),%edx
  800508:	8b 45 08             	mov    0x8(%ebp),%eax
  80050b:	89 10                	mov    %edx,(%eax)
  80050d:	8b 45 08             	mov    0x8(%ebp),%eax
  800510:	8b 00                	mov    (%eax),%eax
  800512:	83 e8 08             	sub    $0x8,%eax
  800515:	8b 50 04             	mov    0x4(%eax),%edx
  800518:	8b 00                	mov    (%eax),%eax
  80051a:	eb 40                	jmp    80055c <getuint+0x65>
	else if (lflag)
  80051c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800520:	74 1e                	je     800540 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800522:	8b 45 08             	mov    0x8(%ebp),%eax
  800525:	8b 00                	mov    (%eax),%eax
  800527:	8d 50 04             	lea    0x4(%eax),%edx
  80052a:	8b 45 08             	mov    0x8(%ebp),%eax
  80052d:	89 10                	mov    %edx,(%eax)
  80052f:	8b 45 08             	mov    0x8(%ebp),%eax
  800532:	8b 00                	mov    (%eax),%eax
  800534:	83 e8 04             	sub    $0x4,%eax
  800537:	8b 00                	mov    (%eax),%eax
  800539:	ba 00 00 00 00       	mov    $0x0,%edx
  80053e:	eb 1c                	jmp    80055c <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800540:	8b 45 08             	mov    0x8(%ebp),%eax
  800543:	8b 00                	mov    (%eax),%eax
  800545:	8d 50 04             	lea    0x4(%eax),%edx
  800548:	8b 45 08             	mov    0x8(%ebp),%eax
  80054b:	89 10                	mov    %edx,(%eax)
  80054d:	8b 45 08             	mov    0x8(%ebp),%eax
  800550:	8b 00                	mov    (%eax),%eax
  800552:	83 e8 04             	sub    $0x4,%eax
  800555:	8b 00                	mov    (%eax),%eax
  800557:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80055c:	5d                   	pop    %ebp
  80055d:	c3                   	ret    

0080055e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80055e:	55                   	push   %ebp
  80055f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800561:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800565:	7e 1c                	jle    800583 <getint+0x25>
		return va_arg(*ap, long long);
  800567:	8b 45 08             	mov    0x8(%ebp),%eax
  80056a:	8b 00                	mov    (%eax),%eax
  80056c:	8d 50 08             	lea    0x8(%eax),%edx
  80056f:	8b 45 08             	mov    0x8(%ebp),%eax
  800572:	89 10                	mov    %edx,(%eax)
  800574:	8b 45 08             	mov    0x8(%ebp),%eax
  800577:	8b 00                	mov    (%eax),%eax
  800579:	83 e8 08             	sub    $0x8,%eax
  80057c:	8b 50 04             	mov    0x4(%eax),%edx
  80057f:	8b 00                	mov    (%eax),%eax
  800581:	eb 38                	jmp    8005bb <getint+0x5d>
	else if (lflag)
  800583:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800587:	74 1a                	je     8005a3 <getint+0x45>
		return va_arg(*ap, long);
  800589:	8b 45 08             	mov    0x8(%ebp),%eax
  80058c:	8b 00                	mov    (%eax),%eax
  80058e:	8d 50 04             	lea    0x4(%eax),%edx
  800591:	8b 45 08             	mov    0x8(%ebp),%eax
  800594:	89 10                	mov    %edx,(%eax)
  800596:	8b 45 08             	mov    0x8(%ebp),%eax
  800599:	8b 00                	mov    (%eax),%eax
  80059b:	83 e8 04             	sub    $0x4,%eax
  80059e:	8b 00                	mov    (%eax),%eax
  8005a0:	99                   	cltd   
  8005a1:	eb 18                	jmp    8005bb <getint+0x5d>
	else
		return va_arg(*ap, int);
  8005a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a6:	8b 00                	mov    (%eax),%eax
  8005a8:	8d 50 04             	lea    0x4(%eax),%edx
  8005ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ae:	89 10                	mov    %edx,(%eax)
  8005b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b3:	8b 00                	mov    (%eax),%eax
  8005b5:	83 e8 04             	sub    $0x4,%eax
  8005b8:	8b 00                	mov    (%eax),%eax
  8005ba:	99                   	cltd   
}
  8005bb:	5d                   	pop    %ebp
  8005bc:	c3                   	ret    

008005bd <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8005bd:	55                   	push   %ebp
  8005be:	89 e5                	mov    %esp,%ebp
  8005c0:	56                   	push   %esi
  8005c1:	53                   	push   %ebx
  8005c2:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8005c5:	eb 17                	jmp    8005de <vprintfmt+0x21>
			if (ch == '\0')
  8005c7:	85 db                	test   %ebx,%ebx
  8005c9:	0f 84 af 03 00 00    	je     80097e <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8005cf:	83 ec 08             	sub    $0x8,%esp
  8005d2:	ff 75 0c             	pushl  0xc(%ebp)
  8005d5:	53                   	push   %ebx
  8005d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d9:	ff d0                	call   *%eax
  8005db:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8005de:	8b 45 10             	mov    0x10(%ebp),%eax
  8005e1:	8d 50 01             	lea    0x1(%eax),%edx
  8005e4:	89 55 10             	mov    %edx,0x10(%ebp)
  8005e7:	8a 00                	mov    (%eax),%al
  8005e9:	0f b6 d8             	movzbl %al,%ebx
  8005ec:	83 fb 25             	cmp    $0x25,%ebx
  8005ef:	75 d6                	jne    8005c7 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8005f1:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8005f5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8005fc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800603:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80060a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800611:	8b 45 10             	mov    0x10(%ebp),%eax
  800614:	8d 50 01             	lea    0x1(%eax),%edx
  800617:	89 55 10             	mov    %edx,0x10(%ebp)
  80061a:	8a 00                	mov    (%eax),%al
  80061c:	0f b6 d8             	movzbl %al,%ebx
  80061f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800622:	83 f8 55             	cmp    $0x55,%eax
  800625:	0f 87 2b 03 00 00    	ja     800956 <vprintfmt+0x399>
  80062b:	8b 04 85 f8 23 80 00 	mov    0x8023f8(,%eax,4),%eax
  800632:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800634:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800638:	eb d7                	jmp    800611 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80063a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80063e:	eb d1                	jmp    800611 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800640:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800647:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80064a:	89 d0                	mov    %edx,%eax
  80064c:	c1 e0 02             	shl    $0x2,%eax
  80064f:	01 d0                	add    %edx,%eax
  800651:	01 c0                	add    %eax,%eax
  800653:	01 d8                	add    %ebx,%eax
  800655:	83 e8 30             	sub    $0x30,%eax
  800658:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80065b:	8b 45 10             	mov    0x10(%ebp),%eax
  80065e:	8a 00                	mov    (%eax),%al
  800660:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800663:	83 fb 2f             	cmp    $0x2f,%ebx
  800666:	7e 3e                	jle    8006a6 <vprintfmt+0xe9>
  800668:	83 fb 39             	cmp    $0x39,%ebx
  80066b:	7f 39                	jg     8006a6 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80066d:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800670:	eb d5                	jmp    800647 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800672:	8b 45 14             	mov    0x14(%ebp),%eax
  800675:	83 c0 04             	add    $0x4,%eax
  800678:	89 45 14             	mov    %eax,0x14(%ebp)
  80067b:	8b 45 14             	mov    0x14(%ebp),%eax
  80067e:	83 e8 04             	sub    $0x4,%eax
  800681:	8b 00                	mov    (%eax),%eax
  800683:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800686:	eb 1f                	jmp    8006a7 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800688:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80068c:	79 83                	jns    800611 <vprintfmt+0x54>
				width = 0;
  80068e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800695:	e9 77 ff ff ff       	jmp    800611 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80069a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8006a1:	e9 6b ff ff ff       	jmp    800611 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8006a6:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8006a7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006ab:	0f 89 60 ff ff ff    	jns    800611 <vprintfmt+0x54>
				width = precision, precision = -1;
  8006b1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006b4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8006b7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8006be:	e9 4e ff ff ff       	jmp    800611 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8006c3:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8006c6:	e9 46 ff ff ff       	jmp    800611 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8006cb:	8b 45 14             	mov    0x14(%ebp),%eax
  8006ce:	83 c0 04             	add    $0x4,%eax
  8006d1:	89 45 14             	mov    %eax,0x14(%ebp)
  8006d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8006d7:	83 e8 04             	sub    $0x4,%eax
  8006da:	8b 00                	mov    (%eax),%eax
  8006dc:	83 ec 08             	sub    $0x8,%esp
  8006df:	ff 75 0c             	pushl  0xc(%ebp)
  8006e2:	50                   	push   %eax
  8006e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e6:	ff d0                	call   *%eax
  8006e8:	83 c4 10             	add    $0x10,%esp
			break;
  8006eb:	e9 89 02 00 00       	jmp    800979 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8006f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8006f3:	83 c0 04             	add    $0x4,%eax
  8006f6:	89 45 14             	mov    %eax,0x14(%ebp)
  8006f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8006fc:	83 e8 04             	sub    $0x4,%eax
  8006ff:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800701:	85 db                	test   %ebx,%ebx
  800703:	79 02                	jns    800707 <vprintfmt+0x14a>
				err = -err;
  800705:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800707:	83 fb 64             	cmp    $0x64,%ebx
  80070a:	7f 0b                	jg     800717 <vprintfmt+0x15a>
  80070c:	8b 34 9d 40 22 80 00 	mov    0x802240(,%ebx,4),%esi
  800713:	85 f6                	test   %esi,%esi
  800715:	75 19                	jne    800730 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800717:	53                   	push   %ebx
  800718:	68 e5 23 80 00       	push   $0x8023e5
  80071d:	ff 75 0c             	pushl  0xc(%ebp)
  800720:	ff 75 08             	pushl  0x8(%ebp)
  800723:	e8 5e 02 00 00       	call   800986 <printfmt>
  800728:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80072b:	e9 49 02 00 00       	jmp    800979 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800730:	56                   	push   %esi
  800731:	68 ee 23 80 00       	push   $0x8023ee
  800736:	ff 75 0c             	pushl  0xc(%ebp)
  800739:	ff 75 08             	pushl  0x8(%ebp)
  80073c:	e8 45 02 00 00       	call   800986 <printfmt>
  800741:	83 c4 10             	add    $0x10,%esp
			break;
  800744:	e9 30 02 00 00       	jmp    800979 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800749:	8b 45 14             	mov    0x14(%ebp),%eax
  80074c:	83 c0 04             	add    $0x4,%eax
  80074f:	89 45 14             	mov    %eax,0x14(%ebp)
  800752:	8b 45 14             	mov    0x14(%ebp),%eax
  800755:	83 e8 04             	sub    $0x4,%eax
  800758:	8b 30                	mov    (%eax),%esi
  80075a:	85 f6                	test   %esi,%esi
  80075c:	75 05                	jne    800763 <vprintfmt+0x1a6>
				p = "(null)";
  80075e:	be f1 23 80 00       	mov    $0x8023f1,%esi
			if (width > 0 && padc != '-')
  800763:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800767:	7e 6d                	jle    8007d6 <vprintfmt+0x219>
  800769:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80076d:	74 67                	je     8007d6 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80076f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800772:	83 ec 08             	sub    $0x8,%esp
  800775:	50                   	push   %eax
  800776:	56                   	push   %esi
  800777:	e8 0c 03 00 00       	call   800a88 <strnlen>
  80077c:	83 c4 10             	add    $0x10,%esp
  80077f:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800782:	eb 16                	jmp    80079a <vprintfmt+0x1dd>
					putch(padc, putdat);
  800784:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800788:	83 ec 08             	sub    $0x8,%esp
  80078b:	ff 75 0c             	pushl  0xc(%ebp)
  80078e:	50                   	push   %eax
  80078f:	8b 45 08             	mov    0x8(%ebp),%eax
  800792:	ff d0                	call   *%eax
  800794:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800797:	ff 4d e4             	decl   -0x1c(%ebp)
  80079a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80079e:	7f e4                	jg     800784 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8007a0:	eb 34                	jmp    8007d6 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8007a2:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8007a6:	74 1c                	je     8007c4 <vprintfmt+0x207>
  8007a8:	83 fb 1f             	cmp    $0x1f,%ebx
  8007ab:	7e 05                	jle    8007b2 <vprintfmt+0x1f5>
  8007ad:	83 fb 7e             	cmp    $0x7e,%ebx
  8007b0:	7e 12                	jle    8007c4 <vprintfmt+0x207>
					putch('?', putdat);
  8007b2:	83 ec 08             	sub    $0x8,%esp
  8007b5:	ff 75 0c             	pushl  0xc(%ebp)
  8007b8:	6a 3f                	push   $0x3f
  8007ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bd:	ff d0                	call   *%eax
  8007bf:	83 c4 10             	add    $0x10,%esp
  8007c2:	eb 0f                	jmp    8007d3 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8007c4:	83 ec 08             	sub    $0x8,%esp
  8007c7:	ff 75 0c             	pushl  0xc(%ebp)
  8007ca:	53                   	push   %ebx
  8007cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ce:	ff d0                	call   *%eax
  8007d0:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8007d3:	ff 4d e4             	decl   -0x1c(%ebp)
  8007d6:	89 f0                	mov    %esi,%eax
  8007d8:	8d 70 01             	lea    0x1(%eax),%esi
  8007db:	8a 00                	mov    (%eax),%al
  8007dd:	0f be d8             	movsbl %al,%ebx
  8007e0:	85 db                	test   %ebx,%ebx
  8007e2:	74 24                	je     800808 <vprintfmt+0x24b>
  8007e4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007e8:	78 b8                	js     8007a2 <vprintfmt+0x1e5>
  8007ea:	ff 4d e0             	decl   -0x20(%ebp)
  8007ed:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007f1:	79 af                	jns    8007a2 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8007f3:	eb 13                	jmp    800808 <vprintfmt+0x24b>
				putch(' ', putdat);
  8007f5:	83 ec 08             	sub    $0x8,%esp
  8007f8:	ff 75 0c             	pushl  0xc(%ebp)
  8007fb:	6a 20                	push   $0x20
  8007fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800800:	ff d0                	call   *%eax
  800802:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800805:	ff 4d e4             	decl   -0x1c(%ebp)
  800808:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80080c:	7f e7                	jg     8007f5 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80080e:	e9 66 01 00 00       	jmp    800979 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800813:	83 ec 08             	sub    $0x8,%esp
  800816:	ff 75 e8             	pushl  -0x18(%ebp)
  800819:	8d 45 14             	lea    0x14(%ebp),%eax
  80081c:	50                   	push   %eax
  80081d:	e8 3c fd ff ff       	call   80055e <getint>
  800822:	83 c4 10             	add    $0x10,%esp
  800825:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800828:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80082b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80082e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800831:	85 d2                	test   %edx,%edx
  800833:	79 23                	jns    800858 <vprintfmt+0x29b>
				putch('-', putdat);
  800835:	83 ec 08             	sub    $0x8,%esp
  800838:	ff 75 0c             	pushl  0xc(%ebp)
  80083b:	6a 2d                	push   $0x2d
  80083d:	8b 45 08             	mov    0x8(%ebp),%eax
  800840:	ff d0                	call   *%eax
  800842:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800845:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800848:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80084b:	f7 d8                	neg    %eax
  80084d:	83 d2 00             	adc    $0x0,%edx
  800850:	f7 da                	neg    %edx
  800852:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800855:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800858:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80085f:	e9 bc 00 00 00       	jmp    800920 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800864:	83 ec 08             	sub    $0x8,%esp
  800867:	ff 75 e8             	pushl  -0x18(%ebp)
  80086a:	8d 45 14             	lea    0x14(%ebp),%eax
  80086d:	50                   	push   %eax
  80086e:	e8 84 fc ff ff       	call   8004f7 <getuint>
  800873:	83 c4 10             	add    $0x10,%esp
  800876:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800879:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80087c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800883:	e9 98 00 00 00       	jmp    800920 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800888:	83 ec 08             	sub    $0x8,%esp
  80088b:	ff 75 0c             	pushl  0xc(%ebp)
  80088e:	6a 58                	push   $0x58
  800890:	8b 45 08             	mov    0x8(%ebp),%eax
  800893:	ff d0                	call   *%eax
  800895:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800898:	83 ec 08             	sub    $0x8,%esp
  80089b:	ff 75 0c             	pushl  0xc(%ebp)
  80089e:	6a 58                	push   $0x58
  8008a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a3:	ff d0                	call   *%eax
  8008a5:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8008a8:	83 ec 08             	sub    $0x8,%esp
  8008ab:	ff 75 0c             	pushl  0xc(%ebp)
  8008ae:	6a 58                	push   $0x58
  8008b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b3:	ff d0                	call   *%eax
  8008b5:	83 c4 10             	add    $0x10,%esp
			break;
  8008b8:	e9 bc 00 00 00       	jmp    800979 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8008bd:	83 ec 08             	sub    $0x8,%esp
  8008c0:	ff 75 0c             	pushl  0xc(%ebp)
  8008c3:	6a 30                	push   $0x30
  8008c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c8:	ff d0                	call   *%eax
  8008ca:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8008cd:	83 ec 08             	sub    $0x8,%esp
  8008d0:	ff 75 0c             	pushl  0xc(%ebp)
  8008d3:	6a 78                	push   $0x78
  8008d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d8:	ff d0                	call   *%eax
  8008da:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8008dd:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e0:	83 c0 04             	add    $0x4,%eax
  8008e3:	89 45 14             	mov    %eax,0x14(%ebp)
  8008e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e9:	83 e8 04             	sub    $0x4,%eax
  8008ec:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8008ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8008f8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8008ff:	eb 1f                	jmp    800920 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800901:	83 ec 08             	sub    $0x8,%esp
  800904:	ff 75 e8             	pushl  -0x18(%ebp)
  800907:	8d 45 14             	lea    0x14(%ebp),%eax
  80090a:	50                   	push   %eax
  80090b:	e8 e7 fb ff ff       	call   8004f7 <getuint>
  800910:	83 c4 10             	add    $0x10,%esp
  800913:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800916:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800919:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800920:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800924:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800927:	83 ec 04             	sub    $0x4,%esp
  80092a:	52                   	push   %edx
  80092b:	ff 75 e4             	pushl  -0x1c(%ebp)
  80092e:	50                   	push   %eax
  80092f:	ff 75 f4             	pushl  -0xc(%ebp)
  800932:	ff 75 f0             	pushl  -0x10(%ebp)
  800935:	ff 75 0c             	pushl  0xc(%ebp)
  800938:	ff 75 08             	pushl  0x8(%ebp)
  80093b:	e8 00 fb ff ff       	call   800440 <printnum>
  800940:	83 c4 20             	add    $0x20,%esp
			break;
  800943:	eb 34                	jmp    800979 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800945:	83 ec 08             	sub    $0x8,%esp
  800948:	ff 75 0c             	pushl  0xc(%ebp)
  80094b:	53                   	push   %ebx
  80094c:	8b 45 08             	mov    0x8(%ebp),%eax
  80094f:	ff d0                	call   *%eax
  800951:	83 c4 10             	add    $0x10,%esp
			break;
  800954:	eb 23                	jmp    800979 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800956:	83 ec 08             	sub    $0x8,%esp
  800959:	ff 75 0c             	pushl  0xc(%ebp)
  80095c:	6a 25                	push   $0x25
  80095e:	8b 45 08             	mov    0x8(%ebp),%eax
  800961:	ff d0                	call   *%eax
  800963:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800966:	ff 4d 10             	decl   0x10(%ebp)
  800969:	eb 03                	jmp    80096e <vprintfmt+0x3b1>
  80096b:	ff 4d 10             	decl   0x10(%ebp)
  80096e:	8b 45 10             	mov    0x10(%ebp),%eax
  800971:	48                   	dec    %eax
  800972:	8a 00                	mov    (%eax),%al
  800974:	3c 25                	cmp    $0x25,%al
  800976:	75 f3                	jne    80096b <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800978:	90                   	nop
		}
	}
  800979:	e9 47 fc ff ff       	jmp    8005c5 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80097e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80097f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800982:	5b                   	pop    %ebx
  800983:	5e                   	pop    %esi
  800984:	5d                   	pop    %ebp
  800985:	c3                   	ret    

00800986 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800986:	55                   	push   %ebp
  800987:	89 e5                	mov    %esp,%ebp
  800989:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80098c:	8d 45 10             	lea    0x10(%ebp),%eax
  80098f:	83 c0 04             	add    $0x4,%eax
  800992:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800995:	8b 45 10             	mov    0x10(%ebp),%eax
  800998:	ff 75 f4             	pushl  -0xc(%ebp)
  80099b:	50                   	push   %eax
  80099c:	ff 75 0c             	pushl  0xc(%ebp)
  80099f:	ff 75 08             	pushl  0x8(%ebp)
  8009a2:	e8 16 fc ff ff       	call   8005bd <vprintfmt>
  8009a7:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8009aa:	90                   	nop
  8009ab:	c9                   	leave  
  8009ac:	c3                   	ret    

008009ad <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8009ad:	55                   	push   %ebp
  8009ae:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8009b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b3:	8b 40 08             	mov    0x8(%eax),%eax
  8009b6:	8d 50 01             	lea    0x1(%eax),%edx
  8009b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009bc:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8009bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c2:	8b 10                	mov    (%eax),%edx
  8009c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c7:	8b 40 04             	mov    0x4(%eax),%eax
  8009ca:	39 c2                	cmp    %eax,%edx
  8009cc:	73 12                	jae    8009e0 <sprintputch+0x33>
		*b->buf++ = ch;
  8009ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d1:	8b 00                	mov    (%eax),%eax
  8009d3:	8d 48 01             	lea    0x1(%eax),%ecx
  8009d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009d9:	89 0a                	mov    %ecx,(%edx)
  8009db:	8b 55 08             	mov    0x8(%ebp),%edx
  8009de:	88 10                	mov    %dl,(%eax)
}
  8009e0:	90                   	nop
  8009e1:	5d                   	pop    %ebp
  8009e2:	c3                   	ret    

008009e3 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8009e3:	55                   	push   %ebp
  8009e4:	89 e5                	mov    %esp,%ebp
  8009e6:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8009e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ec:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8009ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8009f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f8:	01 d0                	add    %edx,%eax
  8009fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009fd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a04:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a08:	74 06                	je     800a10 <vsnprintf+0x2d>
  800a0a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a0e:	7f 07                	jg     800a17 <vsnprintf+0x34>
		return -E_INVAL;
  800a10:	b8 03 00 00 00       	mov    $0x3,%eax
  800a15:	eb 20                	jmp    800a37 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a17:	ff 75 14             	pushl  0x14(%ebp)
  800a1a:	ff 75 10             	pushl  0x10(%ebp)
  800a1d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800a20:	50                   	push   %eax
  800a21:	68 ad 09 80 00       	push   $0x8009ad
  800a26:	e8 92 fb ff ff       	call   8005bd <vprintfmt>
  800a2b:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800a2e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a31:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800a34:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800a37:	c9                   	leave  
  800a38:	c3                   	ret    

00800a39 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800a39:	55                   	push   %ebp
  800a3a:	89 e5                	mov    %esp,%ebp
  800a3c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800a3f:	8d 45 10             	lea    0x10(%ebp),%eax
  800a42:	83 c0 04             	add    $0x4,%eax
  800a45:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800a48:	8b 45 10             	mov    0x10(%ebp),%eax
  800a4b:	ff 75 f4             	pushl  -0xc(%ebp)
  800a4e:	50                   	push   %eax
  800a4f:	ff 75 0c             	pushl  0xc(%ebp)
  800a52:	ff 75 08             	pushl  0x8(%ebp)
  800a55:	e8 89 ff ff ff       	call   8009e3 <vsnprintf>
  800a5a:	83 c4 10             	add    $0x10,%esp
  800a5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800a60:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a63:	c9                   	leave  
  800a64:	c3                   	ret    

00800a65 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800a65:	55                   	push   %ebp
  800a66:	89 e5                	mov    %esp,%ebp
  800a68:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800a6b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a72:	eb 06                	jmp    800a7a <strlen+0x15>
		n++;
  800a74:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800a77:	ff 45 08             	incl   0x8(%ebp)
  800a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7d:	8a 00                	mov    (%eax),%al
  800a7f:	84 c0                	test   %al,%al
  800a81:	75 f1                	jne    800a74 <strlen+0xf>
		n++;
	return n;
  800a83:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a86:	c9                   	leave  
  800a87:	c3                   	ret    

00800a88 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800a88:	55                   	push   %ebp
  800a89:	89 e5                	mov    %esp,%ebp
  800a8b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a8e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a95:	eb 09                	jmp    800aa0 <strnlen+0x18>
		n++;
  800a97:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a9a:	ff 45 08             	incl   0x8(%ebp)
  800a9d:	ff 4d 0c             	decl   0xc(%ebp)
  800aa0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800aa4:	74 09                	je     800aaf <strnlen+0x27>
  800aa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa9:	8a 00                	mov    (%eax),%al
  800aab:	84 c0                	test   %al,%al
  800aad:	75 e8                	jne    800a97 <strnlen+0xf>
		n++;
	return n;
  800aaf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ab2:	c9                   	leave  
  800ab3:	c3                   	ret    

00800ab4 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ab4:	55                   	push   %ebp
  800ab5:	89 e5                	mov    %esp,%ebp
  800ab7:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800aba:	8b 45 08             	mov    0x8(%ebp),%eax
  800abd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ac0:	90                   	nop
  800ac1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac4:	8d 50 01             	lea    0x1(%eax),%edx
  800ac7:	89 55 08             	mov    %edx,0x8(%ebp)
  800aca:	8b 55 0c             	mov    0xc(%ebp),%edx
  800acd:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ad0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ad3:	8a 12                	mov    (%edx),%dl
  800ad5:	88 10                	mov    %dl,(%eax)
  800ad7:	8a 00                	mov    (%eax),%al
  800ad9:	84 c0                	test   %al,%al
  800adb:	75 e4                	jne    800ac1 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800add:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ae0:	c9                   	leave  
  800ae1:	c3                   	ret    

00800ae2 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ae2:	55                   	push   %ebp
  800ae3:	89 e5                	mov    %esp,%ebp
  800ae5:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aeb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800aee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800af5:	eb 1f                	jmp    800b16 <strncpy+0x34>
		*dst++ = *src;
  800af7:	8b 45 08             	mov    0x8(%ebp),%eax
  800afa:	8d 50 01             	lea    0x1(%eax),%edx
  800afd:	89 55 08             	mov    %edx,0x8(%ebp)
  800b00:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b03:	8a 12                	mov    (%edx),%dl
  800b05:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b07:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0a:	8a 00                	mov    (%eax),%al
  800b0c:	84 c0                	test   %al,%al
  800b0e:	74 03                	je     800b13 <strncpy+0x31>
			src++;
  800b10:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b13:	ff 45 fc             	incl   -0x4(%ebp)
  800b16:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b19:	3b 45 10             	cmp    0x10(%ebp),%eax
  800b1c:	72 d9                	jb     800af7 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800b1e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800b21:	c9                   	leave  
  800b22:	c3                   	ret    

00800b23 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800b23:	55                   	push   %ebp
  800b24:	89 e5                	mov    %esp,%ebp
  800b26:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800b29:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800b2f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b33:	74 30                	je     800b65 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800b35:	eb 16                	jmp    800b4d <strlcpy+0x2a>
			*dst++ = *src++;
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3a:	8d 50 01             	lea    0x1(%eax),%edx
  800b3d:	89 55 08             	mov    %edx,0x8(%ebp)
  800b40:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b43:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b46:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b49:	8a 12                	mov    (%edx),%dl
  800b4b:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800b4d:	ff 4d 10             	decl   0x10(%ebp)
  800b50:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b54:	74 09                	je     800b5f <strlcpy+0x3c>
  800b56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b59:	8a 00                	mov    (%eax),%al
  800b5b:	84 c0                	test   %al,%al
  800b5d:	75 d8                	jne    800b37 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800b5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b62:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800b65:	8b 55 08             	mov    0x8(%ebp),%edx
  800b68:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b6b:	29 c2                	sub    %eax,%edx
  800b6d:	89 d0                	mov    %edx,%eax
}
  800b6f:	c9                   	leave  
  800b70:	c3                   	ret    

00800b71 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800b71:	55                   	push   %ebp
  800b72:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800b74:	eb 06                	jmp    800b7c <strcmp+0xb>
		p++, q++;
  800b76:	ff 45 08             	incl   0x8(%ebp)
  800b79:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7f:	8a 00                	mov    (%eax),%al
  800b81:	84 c0                	test   %al,%al
  800b83:	74 0e                	je     800b93 <strcmp+0x22>
  800b85:	8b 45 08             	mov    0x8(%ebp),%eax
  800b88:	8a 10                	mov    (%eax),%dl
  800b8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8d:	8a 00                	mov    (%eax),%al
  800b8f:	38 c2                	cmp    %al,%dl
  800b91:	74 e3                	je     800b76 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
  800b96:	8a 00                	mov    (%eax),%al
  800b98:	0f b6 d0             	movzbl %al,%edx
  800b9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b9e:	8a 00                	mov    (%eax),%al
  800ba0:	0f b6 c0             	movzbl %al,%eax
  800ba3:	29 c2                	sub    %eax,%edx
  800ba5:	89 d0                	mov    %edx,%eax
}
  800ba7:	5d                   	pop    %ebp
  800ba8:	c3                   	ret    

00800ba9 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ba9:	55                   	push   %ebp
  800baa:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800bac:	eb 09                	jmp    800bb7 <strncmp+0xe>
		n--, p++, q++;
  800bae:	ff 4d 10             	decl   0x10(%ebp)
  800bb1:	ff 45 08             	incl   0x8(%ebp)
  800bb4:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800bb7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bbb:	74 17                	je     800bd4 <strncmp+0x2b>
  800bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc0:	8a 00                	mov    (%eax),%al
  800bc2:	84 c0                	test   %al,%al
  800bc4:	74 0e                	je     800bd4 <strncmp+0x2b>
  800bc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc9:	8a 10                	mov    (%eax),%dl
  800bcb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bce:	8a 00                	mov    (%eax),%al
  800bd0:	38 c2                	cmp    %al,%dl
  800bd2:	74 da                	je     800bae <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800bd4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bd8:	75 07                	jne    800be1 <strncmp+0x38>
		return 0;
  800bda:	b8 00 00 00 00       	mov    $0x0,%eax
  800bdf:	eb 14                	jmp    800bf5 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800be1:	8b 45 08             	mov    0x8(%ebp),%eax
  800be4:	8a 00                	mov    (%eax),%al
  800be6:	0f b6 d0             	movzbl %al,%edx
  800be9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bec:	8a 00                	mov    (%eax),%al
  800bee:	0f b6 c0             	movzbl %al,%eax
  800bf1:	29 c2                	sub    %eax,%edx
  800bf3:	89 d0                	mov    %edx,%eax
}
  800bf5:	5d                   	pop    %ebp
  800bf6:	c3                   	ret    

00800bf7 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800bf7:	55                   	push   %ebp
  800bf8:	89 e5                	mov    %esp,%ebp
  800bfa:	83 ec 04             	sub    $0x4,%esp
  800bfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c00:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c03:	eb 12                	jmp    800c17 <strchr+0x20>
		if (*s == c)
  800c05:	8b 45 08             	mov    0x8(%ebp),%eax
  800c08:	8a 00                	mov    (%eax),%al
  800c0a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c0d:	75 05                	jne    800c14 <strchr+0x1d>
			return (char *) s;
  800c0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c12:	eb 11                	jmp    800c25 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c14:	ff 45 08             	incl   0x8(%ebp)
  800c17:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1a:	8a 00                	mov    (%eax),%al
  800c1c:	84 c0                	test   %al,%al
  800c1e:	75 e5                	jne    800c05 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800c20:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c25:	c9                   	leave  
  800c26:	c3                   	ret    

00800c27 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800c27:	55                   	push   %ebp
  800c28:	89 e5                	mov    %esp,%ebp
  800c2a:	83 ec 04             	sub    $0x4,%esp
  800c2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c30:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c33:	eb 0d                	jmp    800c42 <strfind+0x1b>
		if (*s == c)
  800c35:	8b 45 08             	mov    0x8(%ebp),%eax
  800c38:	8a 00                	mov    (%eax),%al
  800c3a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c3d:	74 0e                	je     800c4d <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800c3f:	ff 45 08             	incl   0x8(%ebp)
  800c42:	8b 45 08             	mov    0x8(%ebp),%eax
  800c45:	8a 00                	mov    (%eax),%al
  800c47:	84 c0                	test   %al,%al
  800c49:	75 ea                	jne    800c35 <strfind+0xe>
  800c4b:	eb 01                	jmp    800c4e <strfind+0x27>
		if (*s == c)
			break;
  800c4d:	90                   	nop
	return (char *) s;
  800c4e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c51:	c9                   	leave  
  800c52:	c3                   	ret    

00800c53 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800c53:	55                   	push   %ebp
  800c54:	89 e5                	mov    %esp,%ebp
  800c56:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800c59:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800c5f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c62:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800c65:	eb 0e                	jmp    800c75 <memset+0x22>
		*p++ = c;
  800c67:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c6a:	8d 50 01             	lea    0x1(%eax),%edx
  800c6d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800c70:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c73:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800c75:	ff 4d f8             	decl   -0x8(%ebp)
  800c78:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800c7c:	79 e9                	jns    800c67 <memset+0x14>
		*p++ = c;

	return v;
  800c7e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c81:	c9                   	leave  
  800c82:	c3                   	ret    

00800c83 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800c83:	55                   	push   %ebp
  800c84:	89 e5                	mov    %esp,%ebp
  800c86:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c92:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800c95:	eb 16                	jmp    800cad <memcpy+0x2a>
		*d++ = *s++;
  800c97:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c9a:	8d 50 01             	lea    0x1(%eax),%edx
  800c9d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ca0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ca3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ca6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ca9:	8a 12                	mov    (%edx),%dl
  800cab:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800cad:	8b 45 10             	mov    0x10(%ebp),%eax
  800cb0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cb3:	89 55 10             	mov    %edx,0x10(%ebp)
  800cb6:	85 c0                	test   %eax,%eax
  800cb8:	75 dd                	jne    800c97 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800cba:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cbd:	c9                   	leave  
  800cbe:	c3                   	ret    

00800cbf <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800cbf:	55                   	push   %ebp
  800cc0:	89 e5                	mov    %esp,%ebp
  800cc2:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800cc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ccb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cce:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800cd1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cd4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800cd7:	73 50                	jae    800d29 <memmove+0x6a>
  800cd9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800cdc:	8b 45 10             	mov    0x10(%ebp),%eax
  800cdf:	01 d0                	add    %edx,%eax
  800ce1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ce4:	76 43                	jbe    800d29 <memmove+0x6a>
		s += n;
  800ce6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce9:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800cec:	8b 45 10             	mov    0x10(%ebp),%eax
  800cef:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800cf2:	eb 10                	jmp    800d04 <memmove+0x45>
			*--d = *--s;
  800cf4:	ff 4d f8             	decl   -0x8(%ebp)
  800cf7:	ff 4d fc             	decl   -0x4(%ebp)
  800cfa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cfd:	8a 10                	mov    (%eax),%dl
  800cff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d02:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800d04:	8b 45 10             	mov    0x10(%ebp),%eax
  800d07:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d0a:	89 55 10             	mov    %edx,0x10(%ebp)
  800d0d:	85 c0                	test   %eax,%eax
  800d0f:	75 e3                	jne    800cf4 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800d11:	eb 23                	jmp    800d36 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800d13:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d16:	8d 50 01             	lea    0x1(%eax),%edx
  800d19:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d1c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d1f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d22:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d25:	8a 12                	mov    (%edx),%dl
  800d27:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800d29:	8b 45 10             	mov    0x10(%ebp),%eax
  800d2c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d2f:	89 55 10             	mov    %edx,0x10(%ebp)
  800d32:	85 c0                	test   %eax,%eax
  800d34:	75 dd                	jne    800d13 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800d36:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d39:	c9                   	leave  
  800d3a:	c3                   	ret    

00800d3b <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800d3b:	55                   	push   %ebp
  800d3c:	89 e5                	mov    %esp,%ebp
  800d3e:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800d41:	8b 45 08             	mov    0x8(%ebp),%eax
  800d44:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800d47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4a:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800d4d:	eb 2a                	jmp    800d79 <memcmp+0x3e>
		if (*s1 != *s2)
  800d4f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d52:	8a 10                	mov    (%eax),%dl
  800d54:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d57:	8a 00                	mov    (%eax),%al
  800d59:	38 c2                	cmp    %al,%dl
  800d5b:	74 16                	je     800d73 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800d5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d60:	8a 00                	mov    (%eax),%al
  800d62:	0f b6 d0             	movzbl %al,%edx
  800d65:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d68:	8a 00                	mov    (%eax),%al
  800d6a:	0f b6 c0             	movzbl %al,%eax
  800d6d:	29 c2                	sub    %eax,%edx
  800d6f:	89 d0                	mov    %edx,%eax
  800d71:	eb 18                	jmp    800d8b <memcmp+0x50>
		s1++, s2++;
  800d73:	ff 45 fc             	incl   -0x4(%ebp)
  800d76:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800d79:	8b 45 10             	mov    0x10(%ebp),%eax
  800d7c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d7f:	89 55 10             	mov    %edx,0x10(%ebp)
  800d82:	85 c0                	test   %eax,%eax
  800d84:	75 c9                	jne    800d4f <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800d86:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d8b:	c9                   	leave  
  800d8c:	c3                   	ret    

00800d8d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800d8d:	55                   	push   %ebp
  800d8e:	89 e5                	mov    %esp,%ebp
  800d90:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800d93:	8b 55 08             	mov    0x8(%ebp),%edx
  800d96:	8b 45 10             	mov    0x10(%ebp),%eax
  800d99:	01 d0                	add    %edx,%eax
  800d9b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800d9e:	eb 15                	jmp    800db5 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
  800da3:	8a 00                	mov    (%eax),%al
  800da5:	0f b6 d0             	movzbl %al,%edx
  800da8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dab:	0f b6 c0             	movzbl %al,%eax
  800dae:	39 c2                	cmp    %eax,%edx
  800db0:	74 0d                	je     800dbf <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800db2:	ff 45 08             	incl   0x8(%ebp)
  800db5:	8b 45 08             	mov    0x8(%ebp),%eax
  800db8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800dbb:	72 e3                	jb     800da0 <memfind+0x13>
  800dbd:	eb 01                	jmp    800dc0 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800dbf:	90                   	nop
	return (void *) s;
  800dc0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dc3:	c9                   	leave  
  800dc4:	c3                   	ret    

00800dc5 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800dc5:	55                   	push   %ebp
  800dc6:	89 e5                	mov    %esp,%ebp
  800dc8:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800dcb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800dd2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800dd9:	eb 03                	jmp    800dde <strtol+0x19>
		s++;
  800ddb:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800dde:	8b 45 08             	mov    0x8(%ebp),%eax
  800de1:	8a 00                	mov    (%eax),%al
  800de3:	3c 20                	cmp    $0x20,%al
  800de5:	74 f4                	je     800ddb <strtol+0x16>
  800de7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dea:	8a 00                	mov    (%eax),%al
  800dec:	3c 09                	cmp    $0x9,%al
  800dee:	74 eb                	je     800ddb <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800df0:	8b 45 08             	mov    0x8(%ebp),%eax
  800df3:	8a 00                	mov    (%eax),%al
  800df5:	3c 2b                	cmp    $0x2b,%al
  800df7:	75 05                	jne    800dfe <strtol+0x39>
		s++;
  800df9:	ff 45 08             	incl   0x8(%ebp)
  800dfc:	eb 13                	jmp    800e11 <strtol+0x4c>
	else if (*s == '-')
  800dfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800e01:	8a 00                	mov    (%eax),%al
  800e03:	3c 2d                	cmp    $0x2d,%al
  800e05:	75 0a                	jne    800e11 <strtol+0x4c>
		s++, neg = 1;
  800e07:	ff 45 08             	incl   0x8(%ebp)
  800e0a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800e11:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e15:	74 06                	je     800e1d <strtol+0x58>
  800e17:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800e1b:	75 20                	jne    800e3d <strtol+0x78>
  800e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e20:	8a 00                	mov    (%eax),%al
  800e22:	3c 30                	cmp    $0x30,%al
  800e24:	75 17                	jne    800e3d <strtol+0x78>
  800e26:	8b 45 08             	mov    0x8(%ebp),%eax
  800e29:	40                   	inc    %eax
  800e2a:	8a 00                	mov    (%eax),%al
  800e2c:	3c 78                	cmp    $0x78,%al
  800e2e:	75 0d                	jne    800e3d <strtol+0x78>
		s += 2, base = 16;
  800e30:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800e34:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800e3b:	eb 28                	jmp    800e65 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800e3d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e41:	75 15                	jne    800e58 <strtol+0x93>
  800e43:	8b 45 08             	mov    0x8(%ebp),%eax
  800e46:	8a 00                	mov    (%eax),%al
  800e48:	3c 30                	cmp    $0x30,%al
  800e4a:	75 0c                	jne    800e58 <strtol+0x93>
		s++, base = 8;
  800e4c:	ff 45 08             	incl   0x8(%ebp)
  800e4f:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800e56:	eb 0d                	jmp    800e65 <strtol+0xa0>
	else if (base == 0)
  800e58:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e5c:	75 07                	jne    800e65 <strtol+0xa0>
		base = 10;
  800e5e:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800e65:	8b 45 08             	mov    0x8(%ebp),%eax
  800e68:	8a 00                	mov    (%eax),%al
  800e6a:	3c 2f                	cmp    $0x2f,%al
  800e6c:	7e 19                	jle    800e87 <strtol+0xc2>
  800e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e71:	8a 00                	mov    (%eax),%al
  800e73:	3c 39                	cmp    $0x39,%al
  800e75:	7f 10                	jg     800e87 <strtol+0xc2>
			dig = *s - '0';
  800e77:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7a:	8a 00                	mov    (%eax),%al
  800e7c:	0f be c0             	movsbl %al,%eax
  800e7f:	83 e8 30             	sub    $0x30,%eax
  800e82:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e85:	eb 42                	jmp    800ec9 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800e87:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8a:	8a 00                	mov    (%eax),%al
  800e8c:	3c 60                	cmp    $0x60,%al
  800e8e:	7e 19                	jle    800ea9 <strtol+0xe4>
  800e90:	8b 45 08             	mov    0x8(%ebp),%eax
  800e93:	8a 00                	mov    (%eax),%al
  800e95:	3c 7a                	cmp    $0x7a,%al
  800e97:	7f 10                	jg     800ea9 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800e99:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9c:	8a 00                	mov    (%eax),%al
  800e9e:	0f be c0             	movsbl %al,%eax
  800ea1:	83 e8 57             	sub    $0x57,%eax
  800ea4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ea7:	eb 20                	jmp    800ec9 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800ea9:	8b 45 08             	mov    0x8(%ebp),%eax
  800eac:	8a 00                	mov    (%eax),%al
  800eae:	3c 40                	cmp    $0x40,%al
  800eb0:	7e 39                	jle    800eeb <strtol+0x126>
  800eb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb5:	8a 00                	mov    (%eax),%al
  800eb7:	3c 5a                	cmp    $0x5a,%al
  800eb9:	7f 30                	jg     800eeb <strtol+0x126>
			dig = *s - 'A' + 10;
  800ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebe:	8a 00                	mov    (%eax),%al
  800ec0:	0f be c0             	movsbl %al,%eax
  800ec3:	83 e8 37             	sub    $0x37,%eax
  800ec6:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800ec9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ecc:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ecf:	7d 19                	jge    800eea <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800ed1:	ff 45 08             	incl   0x8(%ebp)
  800ed4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ed7:	0f af 45 10          	imul   0x10(%ebp),%eax
  800edb:	89 c2                	mov    %eax,%edx
  800edd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ee0:	01 d0                	add    %edx,%eax
  800ee2:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800ee5:	e9 7b ff ff ff       	jmp    800e65 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800eea:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800eeb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800eef:	74 08                	je     800ef9 <strtol+0x134>
		*endptr = (char *) s;
  800ef1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef4:	8b 55 08             	mov    0x8(%ebp),%edx
  800ef7:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800ef9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800efd:	74 07                	je     800f06 <strtol+0x141>
  800eff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f02:	f7 d8                	neg    %eax
  800f04:	eb 03                	jmp    800f09 <strtol+0x144>
  800f06:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f09:	c9                   	leave  
  800f0a:	c3                   	ret    

00800f0b <ltostr>:

void
ltostr(long value, char *str)
{
  800f0b:	55                   	push   %ebp
  800f0c:	89 e5                	mov    %esp,%ebp
  800f0e:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800f11:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800f18:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800f1f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f23:	79 13                	jns    800f38 <ltostr+0x2d>
	{
		neg = 1;
  800f25:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800f2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2f:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800f32:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800f35:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800f38:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800f40:	99                   	cltd   
  800f41:	f7 f9                	idiv   %ecx
  800f43:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800f46:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f49:	8d 50 01             	lea    0x1(%eax),%edx
  800f4c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f4f:	89 c2                	mov    %eax,%edx
  800f51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f54:	01 d0                	add    %edx,%eax
  800f56:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800f59:	83 c2 30             	add    $0x30,%edx
  800f5c:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800f5e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800f61:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800f66:	f7 e9                	imul   %ecx
  800f68:	c1 fa 02             	sar    $0x2,%edx
  800f6b:	89 c8                	mov    %ecx,%eax
  800f6d:	c1 f8 1f             	sar    $0x1f,%eax
  800f70:	29 c2                	sub    %eax,%edx
  800f72:	89 d0                	mov    %edx,%eax
  800f74:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800f77:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800f7a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800f7f:	f7 e9                	imul   %ecx
  800f81:	c1 fa 02             	sar    $0x2,%edx
  800f84:	89 c8                	mov    %ecx,%eax
  800f86:	c1 f8 1f             	sar    $0x1f,%eax
  800f89:	29 c2                	sub    %eax,%edx
  800f8b:	89 d0                	mov    %edx,%eax
  800f8d:	c1 e0 02             	shl    $0x2,%eax
  800f90:	01 d0                	add    %edx,%eax
  800f92:	01 c0                	add    %eax,%eax
  800f94:	29 c1                	sub    %eax,%ecx
  800f96:	89 ca                	mov    %ecx,%edx
  800f98:	85 d2                	test   %edx,%edx
  800f9a:	75 9c                	jne    800f38 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800f9c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800fa3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fa6:	48                   	dec    %eax
  800fa7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800faa:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fae:	74 3d                	je     800fed <ltostr+0xe2>
		start = 1 ;
  800fb0:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800fb7:	eb 34                	jmp    800fed <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800fb9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbf:	01 d0                	add    %edx,%eax
  800fc1:	8a 00                	mov    (%eax),%al
  800fc3:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800fc6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fcc:	01 c2                	add    %eax,%edx
  800fce:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800fd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd4:	01 c8                	add    %ecx,%eax
  800fd6:	8a 00                	mov    (%eax),%al
  800fd8:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800fda:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800fdd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe0:	01 c2                	add    %eax,%edx
  800fe2:	8a 45 eb             	mov    -0x15(%ebp),%al
  800fe5:	88 02                	mov    %al,(%edx)
		start++ ;
  800fe7:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800fea:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800fed:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ff0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ff3:	7c c4                	jl     800fb9 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800ff5:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ff8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffb:	01 d0                	add    %edx,%eax
  800ffd:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801000:	90                   	nop
  801001:	c9                   	leave  
  801002:	c3                   	ret    

00801003 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801003:	55                   	push   %ebp
  801004:	89 e5                	mov    %esp,%ebp
  801006:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801009:	ff 75 08             	pushl  0x8(%ebp)
  80100c:	e8 54 fa ff ff       	call   800a65 <strlen>
  801011:	83 c4 04             	add    $0x4,%esp
  801014:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801017:	ff 75 0c             	pushl  0xc(%ebp)
  80101a:	e8 46 fa ff ff       	call   800a65 <strlen>
  80101f:	83 c4 04             	add    $0x4,%esp
  801022:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801025:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80102c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801033:	eb 17                	jmp    80104c <strcconcat+0x49>
		final[s] = str1[s] ;
  801035:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801038:	8b 45 10             	mov    0x10(%ebp),%eax
  80103b:	01 c2                	add    %eax,%edx
  80103d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801040:	8b 45 08             	mov    0x8(%ebp),%eax
  801043:	01 c8                	add    %ecx,%eax
  801045:	8a 00                	mov    (%eax),%al
  801047:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801049:	ff 45 fc             	incl   -0x4(%ebp)
  80104c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80104f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801052:	7c e1                	jl     801035 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801054:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80105b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801062:	eb 1f                	jmp    801083 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801064:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801067:	8d 50 01             	lea    0x1(%eax),%edx
  80106a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80106d:	89 c2                	mov    %eax,%edx
  80106f:	8b 45 10             	mov    0x10(%ebp),%eax
  801072:	01 c2                	add    %eax,%edx
  801074:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801077:	8b 45 0c             	mov    0xc(%ebp),%eax
  80107a:	01 c8                	add    %ecx,%eax
  80107c:	8a 00                	mov    (%eax),%al
  80107e:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801080:	ff 45 f8             	incl   -0x8(%ebp)
  801083:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801086:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801089:	7c d9                	jl     801064 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80108b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80108e:	8b 45 10             	mov    0x10(%ebp),%eax
  801091:	01 d0                	add    %edx,%eax
  801093:	c6 00 00             	movb   $0x0,(%eax)
}
  801096:	90                   	nop
  801097:	c9                   	leave  
  801098:	c3                   	ret    

00801099 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801099:	55                   	push   %ebp
  80109a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80109c:	8b 45 14             	mov    0x14(%ebp),%eax
  80109f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8010a5:	8b 45 14             	mov    0x14(%ebp),%eax
  8010a8:	8b 00                	mov    (%eax),%eax
  8010aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b4:	01 d0                	add    %edx,%eax
  8010b6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8010bc:	eb 0c                	jmp    8010ca <strsplit+0x31>
			*string++ = 0;
  8010be:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c1:	8d 50 01             	lea    0x1(%eax),%edx
  8010c4:	89 55 08             	mov    %edx,0x8(%ebp)
  8010c7:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8010ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cd:	8a 00                	mov    (%eax),%al
  8010cf:	84 c0                	test   %al,%al
  8010d1:	74 18                	je     8010eb <strsplit+0x52>
  8010d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d6:	8a 00                	mov    (%eax),%al
  8010d8:	0f be c0             	movsbl %al,%eax
  8010db:	50                   	push   %eax
  8010dc:	ff 75 0c             	pushl  0xc(%ebp)
  8010df:	e8 13 fb ff ff       	call   800bf7 <strchr>
  8010e4:	83 c4 08             	add    $0x8,%esp
  8010e7:	85 c0                	test   %eax,%eax
  8010e9:	75 d3                	jne    8010be <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8010eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ee:	8a 00                	mov    (%eax),%al
  8010f0:	84 c0                	test   %al,%al
  8010f2:	74 5a                	je     80114e <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8010f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8010f7:	8b 00                	mov    (%eax),%eax
  8010f9:	83 f8 0f             	cmp    $0xf,%eax
  8010fc:	75 07                	jne    801105 <strsplit+0x6c>
		{
			return 0;
  8010fe:	b8 00 00 00 00       	mov    $0x0,%eax
  801103:	eb 66                	jmp    80116b <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801105:	8b 45 14             	mov    0x14(%ebp),%eax
  801108:	8b 00                	mov    (%eax),%eax
  80110a:	8d 48 01             	lea    0x1(%eax),%ecx
  80110d:	8b 55 14             	mov    0x14(%ebp),%edx
  801110:	89 0a                	mov    %ecx,(%edx)
  801112:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801119:	8b 45 10             	mov    0x10(%ebp),%eax
  80111c:	01 c2                	add    %eax,%edx
  80111e:	8b 45 08             	mov    0x8(%ebp),%eax
  801121:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801123:	eb 03                	jmp    801128 <strsplit+0x8f>
			string++;
  801125:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801128:	8b 45 08             	mov    0x8(%ebp),%eax
  80112b:	8a 00                	mov    (%eax),%al
  80112d:	84 c0                	test   %al,%al
  80112f:	74 8b                	je     8010bc <strsplit+0x23>
  801131:	8b 45 08             	mov    0x8(%ebp),%eax
  801134:	8a 00                	mov    (%eax),%al
  801136:	0f be c0             	movsbl %al,%eax
  801139:	50                   	push   %eax
  80113a:	ff 75 0c             	pushl  0xc(%ebp)
  80113d:	e8 b5 fa ff ff       	call   800bf7 <strchr>
  801142:	83 c4 08             	add    $0x8,%esp
  801145:	85 c0                	test   %eax,%eax
  801147:	74 dc                	je     801125 <strsplit+0x8c>
			string++;
	}
  801149:	e9 6e ff ff ff       	jmp    8010bc <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80114e:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80114f:	8b 45 14             	mov    0x14(%ebp),%eax
  801152:	8b 00                	mov    (%eax),%eax
  801154:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80115b:	8b 45 10             	mov    0x10(%ebp),%eax
  80115e:	01 d0                	add    %edx,%eax
  801160:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801166:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80116b:	c9                   	leave  
  80116c:	c3                   	ret    

0080116d <malloc>:
//==================================================================================//
int FirstTimeFlag = 1;
int allocated[MAXN];

void* malloc(uint32 size)
{
  80116d:	55                   	push   %ebp
  80116e:	89 e5                	mov    %esp,%ebp
  801170:	83 ec 28             	sub    $0x28,%esp
	//DON'T CHANGE THIS CODE
	if(FirstTimeFlag)
  801173:	a1 04 30 80 00       	mov    0x803004,%eax
  801178:	85 c0                	test   %eax,%eax
  80117a:	74 0f                	je     80118b <malloc+0x1e>
	{
		initialize_buddy();
  80117c:	e8 a4 02 00 00       	call   801425 <initialize_buddy>
		FirstTimeFlag = 0;
  801181:	c7 05 04 30 80 00 00 	movl   $0x0,0x803004
  801188:	00 00 00 
	}
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
  80118b:	81 7d 08 00 08 00 00 	cmpl   $0x800,0x8(%ebp)
  801192:	0f 86 0b 01 00 00    	jbe    8012a3 <malloc+0x136>
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
  801198:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80119f:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a2:	c1 e8 0c             	shr    $0xc,%eax
  8011a5:	89 c2                	mov    %eax,%edx
  8011a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011aa:	25 ff 0f 00 00       	and    $0xfff,%eax
  8011af:	85 c0                	test   %eax,%eax
  8011b1:	74 07                	je     8011ba <malloc+0x4d>
  8011b3:	b8 01 00 00 00       	mov    $0x1,%eax
  8011b8:	eb 05                	jmp    8011bf <malloc+0x52>
  8011ba:	b8 00 00 00 00       	mov    $0x0,%eax
  8011bf:	01 d0                	add    %edx,%eax
  8011c1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8011c4:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
  8011cb:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
		for(i = 0; i < MAXN; i++) {
  8011d2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8011d9:	eb 5c                	jmp    801237 <malloc+0xca>
			if(allocated[i] != 0) continue;
  8011db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011de:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8011e5:	85 c0                	test   %eax,%eax
  8011e7:	75 4a                	jne    801233 <malloc+0xc6>
			j = 1;
  8011e9:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
			i++;
  8011f0:	ff 45 f4             	incl   -0xc(%ebp)
			while(i < MAXN && allocated[i] == 0 && j < sizeToPage) {
  8011f3:	eb 06                	jmp    8011fb <malloc+0x8e>
				i++;
  8011f5:	ff 45 f4             	incl   -0xc(%ebp)
				j++;
  8011f8:	ff 45 ec             	incl   -0x14(%ebp)
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
			if(allocated[i] != 0) continue;
			j = 1;
			i++;
			while(i < MAXN && allocated[i] == 0 && j < sizeToPage) {
  8011fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011fe:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801203:	77 16                	ja     80121b <malloc+0xae>
  801205:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801208:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  80120f:	85 c0                	test   %eax,%eax
  801211:	75 08                	jne    80121b <malloc+0xae>
  801213:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801216:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801219:	7c da                	jl     8011f5 <malloc+0x88>
				i++;
				j++;
			}
			if(j == sizeToPage) {
  80121b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80121e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801221:	75 0b                	jne    80122e <malloc+0xc1>
				indx = i - j;
  801223:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801226:	2b 45 ec             	sub    -0x14(%ebp),%eax
  801229:	89 45 f0             	mov    %eax,-0x10(%ebp)
				break;
  80122c:	eb 13                	jmp    801241 <malloc+0xd4>
			}
			i--;
  80122e:	ff 4d f4             	decl   -0xc(%ebp)
  801231:	eb 01                	jmp    801234 <malloc+0xc7>
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
			if(allocated[i] != 0) continue;
  801233:	90                   	nop
	}
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
  801234:	ff 45 f4             	incl   -0xc(%ebp)
  801237:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80123a:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  80123f:	76 9a                	jbe    8011db <malloc+0x6e>
				indx = i - j;
				break;
			}
			i--;
		}
		if(indx == -1) {
  801241:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
  801245:	75 07                	jne    80124e <malloc+0xe1>
			return NULL;
  801247:	b8 00 00 00 00       	mov    $0x0,%eax
  80124c:	eb 5a                	jmp    8012a8 <malloc+0x13b>
		}
		i = indx;
  80124e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801251:	89 45 f4             	mov    %eax,-0xc(%ebp)
		while(i < j + indx) {
  801254:	eb 13                	jmp    801269 <malloc+0xfc>
			allocated[i++] = j;
  801256:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801259:	8d 50 01             	lea    0x1(%eax),%edx
  80125c:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80125f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801262:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		}
		if(indx == -1) {
			return NULL;
		}
		i = indx;
		while(i < j + indx) {
  801269:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80126c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80126f:	01 d0                	add    %edx,%eax
  801271:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801274:	7f e0                	jg     801256 <malloc+0xe9>
			allocated[i++] = j;
		}
		uint32 *address = (uint32 *)(USER_HEAP_START + (indx * PAGE_SIZE));
  801276:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801279:	c1 e0 0c             	shl    $0xc,%eax
  80127c:	05 00 00 00 80       	add    $0x80000000,%eax
  801281:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		sys_allocateMem(USER_HEAP_START + (indx * PAGE_SIZE), size);
  801284:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801287:	c1 e0 0c             	shl    $0xc,%eax
  80128a:	05 00 00 00 80       	add    $0x80000000,%eax
  80128f:	83 ec 08             	sub    $0x8,%esp
  801292:	ff 75 08             	pushl  0x8(%ebp)
  801295:	50                   	push   %eax
  801296:	e8 84 04 00 00       	call   80171f <sys_allocateMem>
  80129b:	83 c4 10             	add    $0x10,%esp
		return address;
  80129e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8012a1:	eb 05                	jmp    8012a8 <malloc+0x13b>
	//1) FIRST FIT strategy (if size > 2 KB)
	//2) Buddy System (if size <= 2 KB)

	//refer to the project presentation and documentation for details

	return NULL;
  8012a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012a8:	c9                   	leave  
  8012a9:	c3                   	ret    

008012aa <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8012aa:	55                   	push   %ebp
  8012ab:	89 e5                	mov    %esp,%ebp
  8012ad:	83 ec 18             	sub    $0x18,%esp
	//TODO: [PROJECT 2020 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address, PAGE_SIZE);
  8012b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8012b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8012b9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8012be:	89 45 08             	mov    %eax,0x8(%ebp)
	int size = 0, indx = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE;
  8012c1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8012c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cb:	05 00 00 00 80       	add    $0x80000000,%eax
  8012d0:	c1 e8 0c             	shr    $0xc,%eax
  8012d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int removable_size = allocated[indx];
  8012d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8012d9:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8012e0:	89 45 e8             	mov    %eax,-0x18(%ebp)
	size = allocated[indx];
  8012e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8012e6:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8012ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while(size > 0) {
  8012f0:	eb 17                	jmp    801309 <free+0x5f>
		allocated[indx++] = 0;
  8012f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8012f5:	8d 50 01             	lea    0x1(%eax),%edx
  8012f8:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8012fb:	c7 04 85 20 31 80 00 	movl   $0x0,0x803120(,%eax,4)
  801302:	00 00 00 00 
		size--;
  801306:	ff 4d f4             	decl   -0xc(%ebp)
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address, PAGE_SIZE);
	int size = 0, indx = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE;
	int removable_size = allocated[indx];
	size = allocated[indx];
	while(size > 0) {
  801309:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80130d:	7f e3                	jg     8012f2 <free+0x48>
		allocated[indx++] = 0;
		size--;
	}
	sys_freeMem((uint32)virtual_address, removable_size);
  80130f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801312:	8b 45 08             	mov    0x8(%ebp),%eax
  801315:	83 ec 08             	sub    $0x8,%esp
  801318:	52                   	push   %edx
  801319:	50                   	push   %eax
  80131a:	e8 e4 03 00 00       	call   801703 <sys_freeMem>
  80131f:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details

}
  801322:	90                   	nop
  801323:	c9                   	leave  
  801324:	c3                   	ret    

00801325 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801325:	55                   	push   %ebp
  801326:	89 e5                	mov    %esp,%ebp
  801328:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - BONUS2] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  80132b:	83 ec 04             	sub    $0x4,%esp
  80132e:	68 50 25 80 00       	push   $0x802550
  801333:	6a 7a                	push   $0x7a
  801335:	68 76 25 80 00       	push   $0x802576
  80133a:	e8 1e 09 00 00       	call   801c5d <_panic>

0080133f <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80133f:	55                   	push   %ebp
  801340:	89 e5                	mov    %esp,%ebp
  801342:	83 ec 18             	sub    $0x18,%esp
  801345:	8b 45 10             	mov    0x10(%ebp),%eax
  801348:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  80134b:	83 ec 04             	sub    $0x4,%esp
  80134e:	68 84 25 80 00       	push   $0x802584
  801353:	68 84 00 00 00       	push   $0x84
  801358:	68 76 25 80 00       	push   $0x802576
  80135d:	e8 fb 08 00 00       	call   801c5d <_panic>

00801362 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801362:	55                   	push   %ebp
  801363:	89 e5                	mov    %esp,%ebp
  801365:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801368:	83 ec 04             	sub    $0x4,%esp
  80136b:	68 84 25 80 00       	push   $0x802584
  801370:	68 8a 00 00 00       	push   $0x8a
  801375:	68 76 25 80 00       	push   $0x802576
  80137a:	e8 de 08 00 00       	call   801c5d <_panic>

0080137f <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80137f:	55                   	push   %ebp
  801380:	89 e5                	mov    %esp,%ebp
  801382:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801385:	83 ec 04             	sub    $0x4,%esp
  801388:	68 84 25 80 00       	push   $0x802584
  80138d:	68 90 00 00 00       	push   $0x90
  801392:	68 76 25 80 00       	push   $0x802576
  801397:	e8 c1 08 00 00       	call   801c5d <_panic>

0080139c <expand>:
}

void expand(uint32 newSize)
{
  80139c:	55                   	push   %ebp
  80139d:	89 e5                	mov    %esp,%ebp
  80139f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013a2:	83 ec 04             	sub    $0x4,%esp
  8013a5:	68 84 25 80 00       	push   $0x802584
  8013aa:	68 95 00 00 00       	push   $0x95
  8013af:	68 76 25 80 00       	push   $0x802576
  8013b4:	e8 a4 08 00 00       	call   801c5d <_panic>

008013b9 <shrink>:
}
void shrink(uint32 newSize)
{
  8013b9:	55                   	push   %ebp
  8013ba:	89 e5                	mov    %esp,%ebp
  8013bc:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013bf:	83 ec 04             	sub    $0x4,%esp
  8013c2:	68 84 25 80 00       	push   $0x802584
  8013c7:	68 99 00 00 00       	push   $0x99
  8013cc:	68 76 25 80 00       	push   $0x802576
  8013d1:	e8 87 08 00 00       	call   801c5d <_panic>

008013d6 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8013d6:	55                   	push   %ebp
  8013d7:	89 e5                	mov    %esp,%ebp
  8013d9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013dc:	83 ec 04             	sub    $0x4,%esp
  8013df:	68 84 25 80 00       	push   $0x802584
  8013e4:	68 9e 00 00 00       	push   $0x9e
  8013e9:	68 76 25 80 00       	push   $0x802576
  8013ee:	e8 6a 08 00 00       	call   801c5d <_panic>

008013f3 <ClearNodeData>:
 * inside the user heap
 */
 
struct BuddyNode FreeNodes[BUDDY_NUM_FREE_NODES];
void ClearNodeData(struct BuddyNode* node)
{
  8013f3:	55                   	push   %ebp
  8013f4:	89 e5                	mov    %esp,%ebp
	node->level = 0;
  8013f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f9:	c6 40 11 00          	movb   $0x0,0x11(%eax)
	node->status = FREE;
  8013fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801400:	c6 40 10 00          	movb   $0x0,0x10(%eax)
	node->va = 0;
  801404:	8b 45 08             	mov    0x8(%ebp),%eax
  801407:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
	node->parent = NULL;
  80140e:	8b 45 08             	mov    0x8(%ebp),%eax
  801411:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
	node->myBuddy = NULL;
  801418:	8b 45 08             	mov    0x8(%ebp),%eax
  80141b:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
}
  801422:	90                   	nop
  801423:	5d                   	pop    %ebp
  801424:	c3                   	ret    

00801425 <initialize_buddy>:

void initialize_buddy()
{
  801425:	55                   	push   %ebp
  801426:	89 e5                	mov    %esp,%ebp
  801428:	83 ec 10             	sub    $0x10,%esp
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  80142b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801432:	e9 b7 00 00 00       	jmp    8014ee <initialize_buddy+0xc9>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
  801437:	8b 15 04 31 80 00    	mov    0x803104,%edx
  80143d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801440:	89 c8                	mov    %ecx,%eax
  801442:	01 c0                	add    %eax,%eax
  801444:	01 c8                	add    %ecx,%eax
  801446:	c1 e0 03             	shl    $0x3,%eax
  801449:	05 20 31 88 00       	add    $0x883120,%eax
  80144e:	89 10                	mov    %edx,(%eax)
  801450:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801453:	89 d0                	mov    %edx,%eax
  801455:	01 c0                	add    %eax,%eax
  801457:	01 d0                	add    %edx,%eax
  801459:	c1 e0 03             	shl    $0x3,%eax
  80145c:	05 20 31 88 00       	add    $0x883120,%eax
  801461:	8b 00                	mov    (%eax),%eax
  801463:	85 c0                	test   %eax,%eax
  801465:	74 1c                	je     801483 <initialize_buddy+0x5e>
  801467:	8b 15 04 31 80 00    	mov    0x803104,%edx
  80146d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801470:	89 c8                	mov    %ecx,%eax
  801472:	01 c0                	add    %eax,%eax
  801474:	01 c8                	add    %ecx,%eax
  801476:	c1 e0 03             	shl    $0x3,%eax
  801479:	05 20 31 88 00       	add    $0x883120,%eax
  80147e:	89 42 04             	mov    %eax,0x4(%edx)
  801481:	eb 16                	jmp    801499 <initialize_buddy+0x74>
  801483:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801486:	89 d0                	mov    %edx,%eax
  801488:	01 c0                	add    %eax,%eax
  80148a:	01 d0                	add    %edx,%eax
  80148c:	c1 e0 03             	shl    $0x3,%eax
  80148f:	05 20 31 88 00       	add    $0x883120,%eax
  801494:	a3 08 31 80 00       	mov    %eax,0x803108
  801499:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80149c:	89 d0                	mov    %edx,%eax
  80149e:	01 c0                	add    %eax,%eax
  8014a0:	01 d0                	add    %edx,%eax
  8014a2:	c1 e0 03             	shl    $0x3,%eax
  8014a5:	05 20 31 88 00       	add    $0x883120,%eax
  8014aa:	a3 04 31 80 00       	mov    %eax,0x803104
  8014af:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014b2:	89 d0                	mov    %edx,%eax
  8014b4:	01 c0                	add    %eax,%eax
  8014b6:	01 d0                	add    %edx,%eax
  8014b8:	c1 e0 03             	shl    $0x3,%eax
  8014bb:	05 24 31 88 00       	add    $0x883124,%eax
  8014c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  8014c6:	a1 10 31 80 00       	mov    0x803110,%eax
  8014cb:	40                   	inc    %eax
  8014cc:	a3 10 31 80 00       	mov    %eax,0x803110
		ClearNodeData(&(FreeNodes[i]));
  8014d1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014d4:	89 d0                	mov    %edx,%eax
  8014d6:	01 c0                	add    %eax,%eax
  8014d8:	01 d0                	add    %edx,%eax
  8014da:	c1 e0 03             	shl    $0x3,%eax
  8014dd:	05 20 31 88 00       	add    $0x883120,%eax
  8014e2:	50                   	push   %eax
  8014e3:	e8 0b ff ff ff       	call   8013f3 <ClearNodeData>
  8014e8:	83 c4 04             	add    $0x4,%esp
	node->myBuddy = NULL;
}

void initialize_buddy()
{
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  8014eb:	ff 45 fc             	incl   -0x4(%ebp)
  8014ee:	81 7d fc 3f 9c 00 00 	cmpl   $0x9c3f,-0x4(%ebp)
  8014f5:	0f 8e 3c ff ff ff    	jle    801437 <initialize_buddy+0x12>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
		ClearNodeData(&(FreeNodes[i]));
	}
}
  8014fb:	90                   	nop
  8014fc:	c9                   	leave  
  8014fd:	c3                   	ret    

008014fe <CreateNewBuddySpace>:
/*===============================================================*/

//TODO: [PROJECT 2020 - BONUS4] Expand Buddy Free Node List

void CreateNewBuddySpace()
{
  8014fe:	55                   	push   %ebp
  8014ff:	89 e5                	mov    %esp,%ebp
  801501:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Create New Buddy Block]
	// Write your code here, remove the panic and write your code
	panic("CreateNewBuddySpace() is not implemented yet...!!");
  801504:	83 ec 04             	sub    $0x4,%esp
  801507:	68 a8 25 80 00       	push   $0x8025a8
  80150c:	6a 22                	push   $0x22
  80150e:	68 da 25 80 00       	push   $0x8025da
  801513:	e8 45 07 00 00       	call   801c5d <_panic>

00801518 <FindAllocationUsingBuddy>:

}

void* FindAllocationUsingBuddy(int size)
{
  801518:	55                   	push   %ebp
  801519:	89 e5                	mov    %esp,%ebp
  80151b:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Get Allocation]
	// Write your code here, remove the panic and write your code
	panic("FindAllocationUsingBuddy() is not implemented yet...!!");
  80151e:	83 ec 04             	sub    $0x4,%esp
  801521:	68 e8 25 80 00       	push   $0x8025e8
  801526:	6a 2a                	push   $0x2a
  801528:	68 da 25 80 00       	push   $0x8025da
  80152d:	e8 2b 07 00 00       	call   801c5d <_panic>

00801532 <FreeAllocationUsingBuddy>:
}

void FreeAllocationUsingBuddy(uint32 va)
{
  801532:	55                   	push   %ebp
  801533:	89 e5                	mov    %esp,%ebp
  801535:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Free Allocation]
	// Write your code here, remove the panic and write your code
	panic("FreeAllocationUsingBuddy() is not implemented yet...!!");
  801538:	83 ec 04             	sub    $0x4,%esp
  80153b:	68 20 26 80 00       	push   $0x802620
  801540:	6a 31                	push   $0x31
  801542:	68 da 25 80 00       	push   $0x8025da
  801547:	e8 11 07 00 00       	call   801c5d <_panic>

0080154c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80154c:	55                   	push   %ebp
  80154d:	89 e5                	mov    %esp,%ebp
  80154f:	57                   	push   %edi
  801550:	56                   	push   %esi
  801551:	53                   	push   %ebx
  801552:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801555:	8b 45 08             	mov    0x8(%ebp),%eax
  801558:	8b 55 0c             	mov    0xc(%ebp),%edx
  80155b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80155e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801561:	8b 7d 18             	mov    0x18(%ebp),%edi
  801564:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801567:	cd 30                	int    $0x30
  801569:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80156c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80156f:	83 c4 10             	add    $0x10,%esp
  801572:	5b                   	pop    %ebx
  801573:	5e                   	pop    %esi
  801574:	5f                   	pop    %edi
  801575:	5d                   	pop    %ebp
  801576:	c3                   	ret    

00801577 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801577:	55                   	push   %ebp
  801578:	89 e5                	mov    %esp,%ebp
  80157a:	83 ec 04             	sub    $0x4,%esp
  80157d:	8b 45 10             	mov    0x10(%ebp),%eax
  801580:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801583:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801587:	8b 45 08             	mov    0x8(%ebp),%eax
  80158a:	6a 00                	push   $0x0
  80158c:	6a 00                	push   $0x0
  80158e:	52                   	push   %edx
  80158f:	ff 75 0c             	pushl  0xc(%ebp)
  801592:	50                   	push   %eax
  801593:	6a 00                	push   $0x0
  801595:	e8 b2 ff ff ff       	call   80154c <syscall>
  80159a:	83 c4 18             	add    $0x18,%esp
}
  80159d:	90                   	nop
  80159e:	c9                   	leave  
  80159f:	c3                   	ret    

008015a0 <sys_cgetc>:

int
sys_cgetc(void)
{
  8015a0:	55                   	push   %ebp
  8015a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 01                	push   $0x1
  8015af:	e8 98 ff ff ff       	call   80154c <syscall>
  8015b4:	83 c4 18             	add    $0x18,%esp
}
  8015b7:	c9                   	leave  
  8015b8:	c3                   	ret    

008015b9 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8015b9:	55                   	push   %ebp
  8015ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8015bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	50                   	push   %eax
  8015c8:	6a 05                	push   $0x5
  8015ca:	e8 7d ff ff ff       	call   80154c <syscall>
  8015cf:	83 c4 18             	add    $0x18,%esp
}
  8015d2:	c9                   	leave  
  8015d3:	c3                   	ret    

008015d4 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8015d4:	55                   	push   %ebp
  8015d5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 00                	push   $0x0
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 02                	push   $0x2
  8015e3:	e8 64 ff ff ff       	call   80154c <syscall>
  8015e8:	83 c4 18             	add    $0x18,%esp
}
  8015eb:	c9                   	leave  
  8015ec:	c3                   	ret    

008015ed <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8015ed:	55                   	push   %ebp
  8015ee:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 03                	push   $0x3
  8015fc:	e8 4b ff ff ff       	call   80154c <syscall>
  801601:	83 c4 18             	add    $0x18,%esp
}
  801604:	c9                   	leave  
  801605:	c3                   	ret    

00801606 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801606:	55                   	push   %ebp
  801607:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801609:	6a 00                	push   $0x0
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 04                	push   $0x4
  801615:	e8 32 ff ff ff       	call   80154c <syscall>
  80161a:	83 c4 18             	add    $0x18,%esp
}
  80161d:	c9                   	leave  
  80161e:	c3                   	ret    

0080161f <sys_env_exit>:


void sys_env_exit(void)
{
  80161f:	55                   	push   %ebp
  801620:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801622:	6a 00                	push   $0x0
  801624:	6a 00                	push   $0x0
  801626:	6a 00                	push   $0x0
  801628:	6a 00                	push   $0x0
  80162a:	6a 00                	push   $0x0
  80162c:	6a 06                	push   $0x6
  80162e:	e8 19 ff ff ff       	call   80154c <syscall>
  801633:	83 c4 18             	add    $0x18,%esp
}
  801636:	90                   	nop
  801637:	c9                   	leave  
  801638:	c3                   	ret    

00801639 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801639:	55                   	push   %ebp
  80163a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80163c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80163f:	8b 45 08             	mov    0x8(%ebp),%eax
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	52                   	push   %edx
  801649:	50                   	push   %eax
  80164a:	6a 07                	push   $0x7
  80164c:	e8 fb fe ff ff       	call   80154c <syscall>
  801651:	83 c4 18             	add    $0x18,%esp
}
  801654:	c9                   	leave  
  801655:	c3                   	ret    

00801656 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801656:	55                   	push   %ebp
  801657:	89 e5                	mov    %esp,%ebp
  801659:	56                   	push   %esi
  80165a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80165b:	8b 75 18             	mov    0x18(%ebp),%esi
  80165e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801661:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801664:	8b 55 0c             	mov    0xc(%ebp),%edx
  801667:	8b 45 08             	mov    0x8(%ebp),%eax
  80166a:	56                   	push   %esi
  80166b:	53                   	push   %ebx
  80166c:	51                   	push   %ecx
  80166d:	52                   	push   %edx
  80166e:	50                   	push   %eax
  80166f:	6a 08                	push   $0x8
  801671:	e8 d6 fe ff ff       	call   80154c <syscall>
  801676:	83 c4 18             	add    $0x18,%esp
}
  801679:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80167c:	5b                   	pop    %ebx
  80167d:	5e                   	pop    %esi
  80167e:	5d                   	pop    %ebp
  80167f:	c3                   	ret    

00801680 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801680:	55                   	push   %ebp
  801681:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801683:	8b 55 0c             	mov    0xc(%ebp),%edx
  801686:	8b 45 08             	mov    0x8(%ebp),%eax
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	52                   	push   %edx
  801690:	50                   	push   %eax
  801691:	6a 09                	push   $0x9
  801693:	e8 b4 fe ff ff       	call   80154c <syscall>
  801698:	83 c4 18             	add    $0x18,%esp
}
  80169b:	c9                   	leave  
  80169c:	c3                   	ret    

0080169d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80169d:	55                   	push   %ebp
  80169e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 00                	push   $0x0
  8016a4:	6a 00                	push   $0x0
  8016a6:	ff 75 0c             	pushl  0xc(%ebp)
  8016a9:	ff 75 08             	pushl  0x8(%ebp)
  8016ac:	6a 0a                	push   $0xa
  8016ae:	e8 99 fe ff ff       	call   80154c <syscall>
  8016b3:	83 c4 18             	add    $0x18,%esp
}
  8016b6:	c9                   	leave  
  8016b7:	c3                   	ret    

008016b8 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8016b8:	55                   	push   %ebp
  8016b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8016bb:	6a 00                	push   $0x0
  8016bd:	6a 00                	push   $0x0
  8016bf:	6a 00                	push   $0x0
  8016c1:	6a 00                	push   $0x0
  8016c3:	6a 00                	push   $0x0
  8016c5:	6a 0b                	push   $0xb
  8016c7:	e8 80 fe ff ff       	call   80154c <syscall>
  8016cc:	83 c4 18             	add    $0x18,%esp
}
  8016cf:	c9                   	leave  
  8016d0:	c3                   	ret    

008016d1 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8016d1:	55                   	push   %ebp
  8016d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 00                	push   $0x0
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 0c                	push   $0xc
  8016e0:	e8 67 fe ff ff       	call   80154c <syscall>
  8016e5:	83 c4 18             	add    $0x18,%esp
}
  8016e8:	c9                   	leave  
  8016e9:	c3                   	ret    

008016ea <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8016ea:	55                   	push   %ebp
  8016eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 00                	push   $0x0
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 0d                	push   $0xd
  8016f9:	e8 4e fe ff ff       	call   80154c <syscall>
  8016fe:	83 c4 18             	add    $0x18,%esp
}
  801701:	c9                   	leave  
  801702:	c3                   	ret    

00801703 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801703:	55                   	push   %ebp
  801704:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801706:	6a 00                	push   $0x0
  801708:	6a 00                	push   $0x0
  80170a:	6a 00                	push   $0x0
  80170c:	ff 75 0c             	pushl  0xc(%ebp)
  80170f:	ff 75 08             	pushl  0x8(%ebp)
  801712:	6a 11                	push   $0x11
  801714:	e8 33 fe ff ff       	call   80154c <syscall>
  801719:	83 c4 18             	add    $0x18,%esp
	return;
  80171c:	90                   	nop
}
  80171d:	c9                   	leave  
  80171e:	c3                   	ret    

0080171f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80171f:	55                   	push   %ebp
  801720:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801722:	6a 00                	push   $0x0
  801724:	6a 00                	push   $0x0
  801726:	6a 00                	push   $0x0
  801728:	ff 75 0c             	pushl  0xc(%ebp)
  80172b:	ff 75 08             	pushl  0x8(%ebp)
  80172e:	6a 12                	push   $0x12
  801730:	e8 17 fe ff ff       	call   80154c <syscall>
  801735:	83 c4 18             	add    $0x18,%esp
	return ;
  801738:	90                   	nop
}
  801739:	c9                   	leave  
  80173a:	c3                   	ret    

0080173b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80173b:	55                   	push   %ebp
  80173c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 0e                	push   $0xe
  80174a:	e8 fd fd ff ff       	call   80154c <syscall>
  80174f:	83 c4 18             	add    $0x18,%esp
}
  801752:	c9                   	leave  
  801753:	c3                   	ret    

00801754 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801754:	55                   	push   %ebp
  801755:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801757:	6a 00                	push   $0x0
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	ff 75 08             	pushl  0x8(%ebp)
  801762:	6a 0f                	push   $0xf
  801764:	e8 e3 fd ff ff       	call   80154c <syscall>
  801769:	83 c4 18             	add    $0x18,%esp
}
  80176c:	c9                   	leave  
  80176d:	c3                   	ret    

0080176e <sys_scarce_memory>:

void sys_scarce_memory()
{
  80176e:	55                   	push   %ebp
  80176f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801771:	6a 00                	push   $0x0
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 10                	push   $0x10
  80177d:	e8 ca fd ff ff       	call   80154c <syscall>
  801782:	83 c4 18             	add    $0x18,%esp
}
  801785:	90                   	nop
  801786:	c9                   	leave  
  801787:	c3                   	ret    

00801788 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801788:	55                   	push   %ebp
  801789:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80178b:	6a 00                	push   $0x0
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 14                	push   $0x14
  801797:	e8 b0 fd ff ff       	call   80154c <syscall>
  80179c:	83 c4 18             	add    $0x18,%esp
}
  80179f:	90                   	nop
  8017a0:	c9                   	leave  
  8017a1:	c3                   	ret    

008017a2 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8017a2:	55                   	push   %ebp
  8017a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 15                	push   $0x15
  8017b1:	e8 96 fd ff ff       	call   80154c <syscall>
  8017b6:	83 c4 18             	add    $0x18,%esp
}
  8017b9:	90                   	nop
  8017ba:	c9                   	leave  
  8017bb:	c3                   	ret    

008017bc <sys_cputc>:


void
sys_cputc(const char c)
{
  8017bc:	55                   	push   %ebp
  8017bd:	89 e5                	mov    %esp,%ebp
  8017bf:	83 ec 04             	sub    $0x4,%esp
  8017c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8017c8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	50                   	push   %eax
  8017d5:	6a 16                	push   $0x16
  8017d7:	e8 70 fd ff ff       	call   80154c <syscall>
  8017dc:	83 c4 18             	add    $0x18,%esp
}
  8017df:	90                   	nop
  8017e0:	c9                   	leave  
  8017e1:	c3                   	ret    

008017e2 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8017e2:	55                   	push   %ebp
  8017e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8017e5:	6a 00                	push   $0x0
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 00                	push   $0x0
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 17                	push   $0x17
  8017f1:	e8 56 fd ff ff       	call   80154c <syscall>
  8017f6:	83 c4 18             	add    $0x18,%esp
}
  8017f9:	90                   	nop
  8017fa:	c9                   	leave  
  8017fb:	c3                   	ret    

008017fc <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8017fc:	55                   	push   %ebp
  8017fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8017ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801802:	6a 00                	push   $0x0
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	ff 75 0c             	pushl  0xc(%ebp)
  80180b:	50                   	push   %eax
  80180c:	6a 18                	push   $0x18
  80180e:	e8 39 fd ff ff       	call   80154c <syscall>
  801813:	83 c4 18             	add    $0x18,%esp
}
  801816:	c9                   	leave  
  801817:	c3                   	ret    

00801818 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801818:	55                   	push   %ebp
  801819:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80181b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80181e:	8b 45 08             	mov    0x8(%ebp),%eax
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	6a 00                	push   $0x0
  801827:	52                   	push   %edx
  801828:	50                   	push   %eax
  801829:	6a 1b                	push   $0x1b
  80182b:	e8 1c fd ff ff       	call   80154c <syscall>
  801830:	83 c4 18             	add    $0x18,%esp
}
  801833:	c9                   	leave  
  801834:	c3                   	ret    

00801835 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801835:	55                   	push   %ebp
  801836:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801838:	8b 55 0c             	mov    0xc(%ebp),%edx
  80183b:	8b 45 08             	mov    0x8(%ebp),%eax
  80183e:	6a 00                	push   $0x0
  801840:	6a 00                	push   $0x0
  801842:	6a 00                	push   $0x0
  801844:	52                   	push   %edx
  801845:	50                   	push   %eax
  801846:	6a 19                	push   $0x19
  801848:	e8 ff fc ff ff       	call   80154c <syscall>
  80184d:	83 c4 18             	add    $0x18,%esp
}
  801850:	90                   	nop
  801851:	c9                   	leave  
  801852:	c3                   	ret    

00801853 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801853:	55                   	push   %ebp
  801854:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801856:	8b 55 0c             	mov    0xc(%ebp),%edx
  801859:	8b 45 08             	mov    0x8(%ebp),%eax
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	52                   	push   %edx
  801863:	50                   	push   %eax
  801864:	6a 1a                	push   $0x1a
  801866:	e8 e1 fc ff ff       	call   80154c <syscall>
  80186b:	83 c4 18             	add    $0x18,%esp
}
  80186e:	90                   	nop
  80186f:	c9                   	leave  
  801870:	c3                   	ret    

00801871 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801871:	55                   	push   %ebp
  801872:	89 e5                	mov    %esp,%ebp
  801874:	83 ec 04             	sub    $0x4,%esp
  801877:	8b 45 10             	mov    0x10(%ebp),%eax
  80187a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80187d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801880:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801884:	8b 45 08             	mov    0x8(%ebp),%eax
  801887:	6a 00                	push   $0x0
  801889:	51                   	push   %ecx
  80188a:	52                   	push   %edx
  80188b:	ff 75 0c             	pushl  0xc(%ebp)
  80188e:	50                   	push   %eax
  80188f:	6a 1c                	push   $0x1c
  801891:	e8 b6 fc ff ff       	call   80154c <syscall>
  801896:	83 c4 18             	add    $0x18,%esp
}
  801899:	c9                   	leave  
  80189a:	c3                   	ret    

0080189b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80189b:	55                   	push   %ebp
  80189c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80189e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	52                   	push   %edx
  8018ab:	50                   	push   %eax
  8018ac:	6a 1d                	push   $0x1d
  8018ae:	e8 99 fc ff ff       	call   80154c <syscall>
  8018b3:	83 c4 18             	add    $0x18,%esp
}
  8018b6:	c9                   	leave  
  8018b7:	c3                   	ret    

008018b8 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8018b8:	55                   	push   %ebp
  8018b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8018bb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 00                	push   $0x0
  8018c8:	51                   	push   %ecx
  8018c9:	52                   	push   %edx
  8018ca:	50                   	push   %eax
  8018cb:	6a 1e                	push   $0x1e
  8018cd:	e8 7a fc ff ff       	call   80154c <syscall>
  8018d2:	83 c4 18             	add    $0x18,%esp
}
  8018d5:	c9                   	leave  
  8018d6:	c3                   	ret    

008018d7 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8018d7:	55                   	push   %ebp
  8018d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8018da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e0:	6a 00                	push   $0x0
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 00                	push   $0x0
  8018e6:	52                   	push   %edx
  8018e7:	50                   	push   %eax
  8018e8:	6a 1f                	push   $0x1f
  8018ea:	e8 5d fc ff ff       	call   80154c <syscall>
  8018ef:	83 c4 18             	add    $0x18,%esp
}
  8018f2:	c9                   	leave  
  8018f3:	c3                   	ret    

008018f4 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8018f4:	55                   	push   %ebp
  8018f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	6a 20                	push   $0x20
  801903:	e8 44 fc ff ff       	call   80154c <syscall>
  801908:	83 c4 18             	add    $0x18,%esp
}
  80190b:	c9                   	leave  
  80190c:	c3                   	ret    

0080190d <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80190d:	55                   	push   %ebp
  80190e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801910:	8b 45 08             	mov    0x8(%ebp),%eax
  801913:	6a 00                	push   $0x0
  801915:	ff 75 14             	pushl  0x14(%ebp)
  801918:	ff 75 10             	pushl  0x10(%ebp)
  80191b:	ff 75 0c             	pushl  0xc(%ebp)
  80191e:	50                   	push   %eax
  80191f:	6a 21                	push   $0x21
  801921:	e8 26 fc ff ff       	call   80154c <syscall>
  801926:	83 c4 18             	add    $0x18,%esp
}
  801929:	c9                   	leave  
  80192a:	c3                   	ret    

0080192b <sys_run_env>:


void
sys_run_env(int32 envId)
{
  80192b:	55                   	push   %ebp
  80192c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80192e:	8b 45 08             	mov    0x8(%ebp),%eax
  801931:	6a 00                	push   $0x0
  801933:	6a 00                	push   $0x0
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	50                   	push   %eax
  80193a:	6a 22                	push   $0x22
  80193c:	e8 0b fc ff ff       	call   80154c <syscall>
  801941:	83 c4 18             	add    $0x18,%esp
}
  801944:	90                   	nop
  801945:	c9                   	leave  
  801946:	c3                   	ret    

00801947 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801947:	55                   	push   %ebp
  801948:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80194a:	8b 45 08             	mov    0x8(%ebp),%eax
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 00                	push   $0x0
  801953:	6a 00                	push   $0x0
  801955:	50                   	push   %eax
  801956:	6a 23                	push   $0x23
  801958:	e8 ef fb ff ff       	call   80154c <syscall>
  80195d:	83 c4 18             	add    $0x18,%esp
}
  801960:	90                   	nop
  801961:	c9                   	leave  
  801962:	c3                   	ret    

00801963 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801963:	55                   	push   %ebp
  801964:	89 e5                	mov    %esp,%ebp
  801966:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801969:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80196c:	8d 50 04             	lea    0x4(%eax),%edx
  80196f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801972:	6a 00                	push   $0x0
  801974:	6a 00                	push   $0x0
  801976:	6a 00                	push   $0x0
  801978:	52                   	push   %edx
  801979:	50                   	push   %eax
  80197a:	6a 24                	push   $0x24
  80197c:	e8 cb fb ff ff       	call   80154c <syscall>
  801981:	83 c4 18             	add    $0x18,%esp
	return result;
  801984:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801987:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80198a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80198d:	89 01                	mov    %eax,(%ecx)
  80198f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801992:	8b 45 08             	mov    0x8(%ebp),%eax
  801995:	c9                   	leave  
  801996:	c2 04 00             	ret    $0x4

00801999 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801999:	55                   	push   %ebp
  80199a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	ff 75 10             	pushl  0x10(%ebp)
  8019a3:	ff 75 0c             	pushl  0xc(%ebp)
  8019a6:	ff 75 08             	pushl  0x8(%ebp)
  8019a9:	6a 13                	push   $0x13
  8019ab:	e8 9c fb ff ff       	call   80154c <syscall>
  8019b0:	83 c4 18             	add    $0x18,%esp
	return ;
  8019b3:	90                   	nop
}
  8019b4:	c9                   	leave  
  8019b5:	c3                   	ret    

008019b6 <sys_rcr2>:
uint32 sys_rcr2()
{
  8019b6:	55                   	push   %ebp
  8019b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8019b9:	6a 00                	push   $0x0
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 25                	push   $0x25
  8019c5:	e8 82 fb ff ff       	call   80154c <syscall>
  8019ca:	83 c4 18             	add    $0x18,%esp
}
  8019cd:	c9                   	leave  
  8019ce:	c3                   	ret    

008019cf <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8019cf:	55                   	push   %ebp
  8019d0:	89 e5                	mov    %esp,%ebp
  8019d2:	83 ec 04             	sub    $0x4,%esp
  8019d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8019db:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	50                   	push   %eax
  8019e8:	6a 26                	push   $0x26
  8019ea:	e8 5d fb ff ff       	call   80154c <syscall>
  8019ef:	83 c4 18             	add    $0x18,%esp
	return ;
  8019f2:	90                   	nop
}
  8019f3:	c9                   	leave  
  8019f4:	c3                   	ret    

008019f5 <rsttst>:
void rsttst()
{
  8019f5:	55                   	push   %ebp
  8019f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8019f8:	6a 00                	push   $0x0
  8019fa:	6a 00                	push   $0x0
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 00                	push   $0x0
  801a00:	6a 00                	push   $0x0
  801a02:	6a 28                	push   $0x28
  801a04:	e8 43 fb ff ff       	call   80154c <syscall>
  801a09:	83 c4 18             	add    $0x18,%esp
	return ;
  801a0c:	90                   	nop
}
  801a0d:	c9                   	leave  
  801a0e:	c3                   	ret    

00801a0f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a0f:	55                   	push   %ebp
  801a10:	89 e5                	mov    %esp,%ebp
  801a12:	83 ec 04             	sub    $0x4,%esp
  801a15:	8b 45 14             	mov    0x14(%ebp),%eax
  801a18:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a1b:	8b 55 18             	mov    0x18(%ebp),%edx
  801a1e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a22:	52                   	push   %edx
  801a23:	50                   	push   %eax
  801a24:	ff 75 10             	pushl  0x10(%ebp)
  801a27:	ff 75 0c             	pushl  0xc(%ebp)
  801a2a:	ff 75 08             	pushl  0x8(%ebp)
  801a2d:	6a 27                	push   $0x27
  801a2f:	e8 18 fb ff ff       	call   80154c <syscall>
  801a34:	83 c4 18             	add    $0x18,%esp
	return ;
  801a37:	90                   	nop
}
  801a38:	c9                   	leave  
  801a39:	c3                   	ret    

00801a3a <chktst>:
void chktst(uint32 n)
{
  801a3a:	55                   	push   %ebp
  801a3b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 00                	push   $0x0
  801a43:	6a 00                	push   $0x0
  801a45:	ff 75 08             	pushl  0x8(%ebp)
  801a48:	6a 29                	push   $0x29
  801a4a:	e8 fd fa ff ff       	call   80154c <syscall>
  801a4f:	83 c4 18             	add    $0x18,%esp
	return ;
  801a52:	90                   	nop
}
  801a53:	c9                   	leave  
  801a54:	c3                   	ret    

00801a55 <inctst>:

void inctst()
{
  801a55:	55                   	push   %ebp
  801a56:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a58:	6a 00                	push   $0x0
  801a5a:	6a 00                	push   $0x0
  801a5c:	6a 00                	push   $0x0
  801a5e:	6a 00                	push   $0x0
  801a60:	6a 00                	push   $0x0
  801a62:	6a 2a                	push   $0x2a
  801a64:	e8 e3 fa ff ff       	call   80154c <syscall>
  801a69:	83 c4 18             	add    $0x18,%esp
	return ;
  801a6c:	90                   	nop
}
  801a6d:	c9                   	leave  
  801a6e:	c3                   	ret    

00801a6f <gettst>:
uint32 gettst()
{
  801a6f:	55                   	push   %ebp
  801a70:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a72:	6a 00                	push   $0x0
  801a74:	6a 00                	push   $0x0
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 2b                	push   $0x2b
  801a7e:	e8 c9 fa ff ff       	call   80154c <syscall>
  801a83:	83 c4 18             	add    $0x18,%esp
}
  801a86:	c9                   	leave  
  801a87:	c3                   	ret    

00801a88 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a88:	55                   	push   %ebp
  801a89:	89 e5                	mov    %esp,%ebp
  801a8b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a8e:	6a 00                	push   $0x0
  801a90:	6a 00                	push   $0x0
  801a92:	6a 00                	push   $0x0
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	6a 2c                	push   $0x2c
  801a9a:	e8 ad fa ff ff       	call   80154c <syscall>
  801a9f:	83 c4 18             	add    $0x18,%esp
  801aa2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801aa5:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801aa9:	75 07                	jne    801ab2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801aab:	b8 01 00 00 00       	mov    $0x1,%eax
  801ab0:	eb 05                	jmp    801ab7 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801ab2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ab7:	c9                   	leave  
  801ab8:	c3                   	ret    

00801ab9 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801ab9:	55                   	push   %ebp
  801aba:	89 e5                	mov    %esp,%ebp
  801abc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801abf:	6a 00                	push   $0x0
  801ac1:	6a 00                	push   $0x0
  801ac3:	6a 00                	push   $0x0
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 00                	push   $0x0
  801ac9:	6a 2c                	push   $0x2c
  801acb:	e8 7c fa ff ff       	call   80154c <syscall>
  801ad0:	83 c4 18             	add    $0x18,%esp
  801ad3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801ad6:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801ada:	75 07                	jne    801ae3 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801adc:	b8 01 00 00 00       	mov    $0x1,%eax
  801ae1:	eb 05                	jmp    801ae8 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801ae3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ae8:	c9                   	leave  
  801ae9:	c3                   	ret    

00801aea <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801aea:	55                   	push   %ebp
  801aeb:	89 e5                	mov    %esp,%ebp
  801aed:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801af0:	6a 00                	push   $0x0
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	6a 00                	push   $0x0
  801af8:	6a 00                	push   $0x0
  801afa:	6a 2c                	push   $0x2c
  801afc:	e8 4b fa ff ff       	call   80154c <syscall>
  801b01:	83 c4 18             	add    $0x18,%esp
  801b04:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801b07:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801b0b:	75 07                	jne    801b14 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801b0d:	b8 01 00 00 00       	mov    $0x1,%eax
  801b12:	eb 05                	jmp    801b19 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801b14:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b19:	c9                   	leave  
  801b1a:	c3                   	ret    

00801b1b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801b1b:	55                   	push   %ebp
  801b1c:	89 e5                	mov    %esp,%ebp
  801b1e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b21:	6a 00                	push   $0x0
  801b23:	6a 00                	push   $0x0
  801b25:	6a 00                	push   $0x0
  801b27:	6a 00                	push   $0x0
  801b29:	6a 00                	push   $0x0
  801b2b:	6a 2c                	push   $0x2c
  801b2d:	e8 1a fa ff ff       	call   80154c <syscall>
  801b32:	83 c4 18             	add    $0x18,%esp
  801b35:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801b38:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801b3c:	75 07                	jne    801b45 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801b3e:	b8 01 00 00 00       	mov    $0x1,%eax
  801b43:	eb 05                	jmp    801b4a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801b45:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b4a:	c9                   	leave  
  801b4b:	c3                   	ret    

00801b4c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b4c:	55                   	push   %ebp
  801b4d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b4f:	6a 00                	push   $0x0
  801b51:	6a 00                	push   $0x0
  801b53:	6a 00                	push   $0x0
  801b55:	6a 00                	push   $0x0
  801b57:	ff 75 08             	pushl  0x8(%ebp)
  801b5a:	6a 2d                	push   $0x2d
  801b5c:	e8 eb f9 ff ff       	call   80154c <syscall>
  801b61:	83 c4 18             	add    $0x18,%esp
	return ;
  801b64:	90                   	nop
}
  801b65:	c9                   	leave  
  801b66:	c3                   	ret    

00801b67 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b67:	55                   	push   %ebp
  801b68:	89 e5                	mov    %esp,%ebp
  801b6a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b6b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b6e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b71:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b74:	8b 45 08             	mov    0x8(%ebp),%eax
  801b77:	6a 00                	push   $0x0
  801b79:	53                   	push   %ebx
  801b7a:	51                   	push   %ecx
  801b7b:	52                   	push   %edx
  801b7c:	50                   	push   %eax
  801b7d:	6a 2e                	push   $0x2e
  801b7f:	e8 c8 f9 ff ff       	call   80154c <syscall>
  801b84:	83 c4 18             	add    $0x18,%esp
}
  801b87:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b8a:	c9                   	leave  
  801b8b:	c3                   	ret    

00801b8c <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b8c:	55                   	push   %ebp
  801b8d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b92:	8b 45 08             	mov    0x8(%ebp),%eax
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	52                   	push   %edx
  801b9c:	50                   	push   %eax
  801b9d:	6a 2f                	push   $0x2f
  801b9f:	e8 a8 f9 ff ff       	call   80154c <syscall>
  801ba4:	83 c4 18             	add    $0x18,%esp
}
  801ba7:	c9                   	leave  
  801ba8:	c3                   	ret    

00801ba9 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801ba9:	55                   	push   %ebp
  801baa:	89 e5                	mov    %esp,%ebp
  801bac:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801baf:	8b 55 08             	mov    0x8(%ebp),%edx
  801bb2:	89 d0                	mov    %edx,%eax
  801bb4:	c1 e0 02             	shl    $0x2,%eax
  801bb7:	01 d0                	add    %edx,%eax
  801bb9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801bc0:	01 d0                	add    %edx,%eax
  801bc2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801bc9:	01 d0                	add    %edx,%eax
  801bcb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801bd2:	01 d0                	add    %edx,%eax
  801bd4:	c1 e0 04             	shl    $0x4,%eax
  801bd7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801bda:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801be1:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801be4:	83 ec 0c             	sub    $0xc,%esp
  801be7:	50                   	push   %eax
  801be8:	e8 76 fd ff ff       	call   801963 <sys_get_virtual_time>
  801bed:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801bf0:	eb 41                	jmp    801c33 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801bf2:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801bf5:	83 ec 0c             	sub    $0xc,%esp
  801bf8:	50                   	push   %eax
  801bf9:	e8 65 fd ff ff       	call   801963 <sys_get_virtual_time>
  801bfe:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801c01:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801c04:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c07:	29 c2                	sub    %eax,%edx
  801c09:	89 d0                	mov    %edx,%eax
  801c0b:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801c0e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801c11:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c14:	89 d1                	mov    %edx,%ecx
  801c16:	29 c1                	sub    %eax,%ecx
  801c18:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801c1b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c1e:	39 c2                	cmp    %eax,%edx
  801c20:	0f 97 c0             	seta   %al
  801c23:	0f b6 c0             	movzbl %al,%eax
  801c26:	29 c1                	sub    %eax,%ecx
  801c28:	89 c8                	mov    %ecx,%eax
  801c2a:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801c2d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801c30:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801c33:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c36:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c39:	72 b7                	jb     801bf2 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801c3b:	90                   	nop
  801c3c:	c9                   	leave  
  801c3d:	c3                   	ret    

00801c3e <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801c3e:	55                   	push   %ebp
  801c3f:	89 e5                	mov    %esp,%ebp
  801c41:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801c44:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801c4b:	eb 03                	jmp    801c50 <busy_wait+0x12>
  801c4d:	ff 45 fc             	incl   -0x4(%ebp)
  801c50:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c53:	3b 45 08             	cmp    0x8(%ebp),%eax
  801c56:	72 f5                	jb     801c4d <busy_wait+0xf>
	return i;
  801c58:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801c5b:	c9                   	leave  
  801c5c:	c3                   	ret    

00801c5d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801c5d:	55                   	push   %ebp
  801c5e:	89 e5                	mov    %esp,%ebp
  801c60:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801c63:	8d 45 10             	lea    0x10(%ebp),%eax
  801c66:	83 c0 04             	add    $0x4,%eax
  801c69:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801c6c:	a1 20 d7 96 00       	mov    0x96d720,%eax
  801c71:	85 c0                	test   %eax,%eax
  801c73:	74 16                	je     801c8b <_panic+0x2e>
		cprintf("%s: ", argv0);
  801c75:	a1 20 d7 96 00       	mov    0x96d720,%eax
  801c7a:	83 ec 08             	sub    $0x8,%esp
  801c7d:	50                   	push   %eax
  801c7e:	68 58 26 80 00       	push   $0x802658
  801c83:	e8 5b e7 ff ff       	call   8003e3 <cprintf>
  801c88:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801c8b:	a1 00 30 80 00       	mov    0x803000,%eax
  801c90:	ff 75 0c             	pushl  0xc(%ebp)
  801c93:	ff 75 08             	pushl  0x8(%ebp)
  801c96:	50                   	push   %eax
  801c97:	68 5d 26 80 00       	push   $0x80265d
  801c9c:	e8 42 e7 ff ff       	call   8003e3 <cprintf>
  801ca1:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801ca4:	8b 45 10             	mov    0x10(%ebp),%eax
  801ca7:	83 ec 08             	sub    $0x8,%esp
  801caa:	ff 75 f4             	pushl  -0xc(%ebp)
  801cad:	50                   	push   %eax
  801cae:	e8 c5 e6 ff ff       	call   800378 <vcprintf>
  801cb3:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801cb6:	83 ec 08             	sub    $0x8,%esp
  801cb9:	6a 00                	push   $0x0
  801cbb:	68 79 26 80 00       	push   $0x802679
  801cc0:	e8 b3 e6 ff ff       	call   800378 <vcprintf>
  801cc5:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801cc8:	e8 34 e6 ff ff       	call   800301 <exit>

	// should not return here
	while (1) ;
  801ccd:	eb fe                	jmp    801ccd <_panic+0x70>

00801ccf <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801ccf:	55                   	push   %ebp
  801cd0:	89 e5                	mov    %esp,%ebp
  801cd2:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801cd5:	a1 20 30 80 00       	mov    0x803020,%eax
  801cda:	8b 50 74             	mov    0x74(%eax),%edx
  801cdd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ce0:	39 c2                	cmp    %eax,%edx
  801ce2:	74 14                	je     801cf8 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801ce4:	83 ec 04             	sub    $0x4,%esp
  801ce7:	68 7c 26 80 00       	push   $0x80267c
  801cec:	6a 26                	push   $0x26
  801cee:	68 c8 26 80 00       	push   $0x8026c8
  801cf3:	e8 65 ff ff ff       	call   801c5d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801cf8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801cff:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801d06:	e9 b6 00 00 00       	jmp    801dc1 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801d0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d0e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d15:	8b 45 08             	mov    0x8(%ebp),%eax
  801d18:	01 d0                	add    %edx,%eax
  801d1a:	8b 00                	mov    (%eax),%eax
  801d1c:	85 c0                	test   %eax,%eax
  801d1e:	75 08                	jne    801d28 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801d20:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801d23:	e9 96 00 00 00       	jmp    801dbe <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  801d28:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d2f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801d36:	eb 5d                	jmp    801d95 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801d38:	a1 20 30 80 00       	mov    0x803020,%eax
  801d3d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801d43:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801d46:	c1 e2 04             	shl    $0x4,%edx
  801d49:	01 d0                	add    %edx,%eax
  801d4b:	8a 40 04             	mov    0x4(%eax),%al
  801d4e:	84 c0                	test   %al,%al
  801d50:	75 40                	jne    801d92 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801d52:	a1 20 30 80 00       	mov    0x803020,%eax
  801d57:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801d5d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801d60:	c1 e2 04             	shl    $0x4,%edx
  801d63:	01 d0                	add    %edx,%eax
  801d65:	8b 00                	mov    (%eax),%eax
  801d67:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801d6a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801d6d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801d72:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801d74:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d77:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d81:	01 c8                	add    %ecx,%eax
  801d83:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801d85:	39 c2                	cmp    %eax,%edx
  801d87:	75 09                	jne    801d92 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801d89:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801d90:	eb 12                	jmp    801da4 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d92:	ff 45 e8             	incl   -0x18(%ebp)
  801d95:	a1 20 30 80 00       	mov    0x803020,%eax
  801d9a:	8b 50 74             	mov    0x74(%eax),%edx
  801d9d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801da0:	39 c2                	cmp    %eax,%edx
  801da2:	77 94                	ja     801d38 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801da4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801da8:	75 14                	jne    801dbe <CheckWSWithoutLastIndex+0xef>
			panic(
  801daa:	83 ec 04             	sub    $0x4,%esp
  801dad:	68 d4 26 80 00       	push   $0x8026d4
  801db2:	6a 3a                	push   $0x3a
  801db4:	68 c8 26 80 00       	push   $0x8026c8
  801db9:	e8 9f fe ff ff       	call   801c5d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801dbe:	ff 45 f0             	incl   -0x10(%ebp)
  801dc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801dc4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801dc7:	0f 8c 3e ff ff ff    	jl     801d0b <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801dcd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801dd4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801ddb:	eb 20                	jmp    801dfd <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801ddd:	a1 20 30 80 00       	mov    0x803020,%eax
  801de2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801de8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801deb:	c1 e2 04             	shl    $0x4,%edx
  801dee:	01 d0                	add    %edx,%eax
  801df0:	8a 40 04             	mov    0x4(%eax),%al
  801df3:	3c 01                	cmp    $0x1,%al
  801df5:	75 03                	jne    801dfa <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  801df7:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801dfa:	ff 45 e0             	incl   -0x20(%ebp)
  801dfd:	a1 20 30 80 00       	mov    0x803020,%eax
  801e02:	8b 50 74             	mov    0x74(%eax),%edx
  801e05:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e08:	39 c2                	cmp    %eax,%edx
  801e0a:	77 d1                	ja     801ddd <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801e0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e0f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801e12:	74 14                	je     801e28 <CheckWSWithoutLastIndex+0x159>
		panic(
  801e14:	83 ec 04             	sub    $0x4,%esp
  801e17:	68 28 27 80 00       	push   $0x802728
  801e1c:	6a 44                	push   $0x44
  801e1e:	68 c8 26 80 00       	push   $0x8026c8
  801e23:	e8 35 fe ff ff       	call   801c5d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801e28:	90                   	nop
  801e29:	c9                   	leave  
  801e2a:	c3                   	ret    
  801e2b:	90                   	nop

00801e2c <__udivdi3>:
  801e2c:	55                   	push   %ebp
  801e2d:	57                   	push   %edi
  801e2e:	56                   	push   %esi
  801e2f:	53                   	push   %ebx
  801e30:	83 ec 1c             	sub    $0x1c,%esp
  801e33:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801e37:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e3b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e3f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e43:	89 ca                	mov    %ecx,%edx
  801e45:	89 f8                	mov    %edi,%eax
  801e47:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e4b:	85 f6                	test   %esi,%esi
  801e4d:	75 2d                	jne    801e7c <__udivdi3+0x50>
  801e4f:	39 cf                	cmp    %ecx,%edi
  801e51:	77 65                	ja     801eb8 <__udivdi3+0x8c>
  801e53:	89 fd                	mov    %edi,%ebp
  801e55:	85 ff                	test   %edi,%edi
  801e57:	75 0b                	jne    801e64 <__udivdi3+0x38>
  801e59:	b8 01 00 00 00       	mov    $0x1,%eax
  801e5e:	31 d2                	xor    %edx,%edx
  801e60:	f7 f7                	div    %edi
  801e62:	89 c5                	mov    %eax,%ebp
  801e64:	31 d2                	xor    %edx,%edx
  801e66:	89 c8                	mov    %ecx,%eax
  801e68:	f7 f5                	div    %ebp
  801e6a:	89 c1                	mov    %eax,%ecx
  801e6c:	89 d8                	mov    %ebx,%eax
  801e6e:	f7 f5                	div    %ebp
  801e70:	89 cf                	mov    %ecx,%edi
  801e72:	89 fa                	mov    %edi,%edx
  801e74:	83 c4 1c             	add    $0x1c,%esp
  801e77:	5b                   	pop    %ebx
  801e78:	5e                   	pop    %esi
  801e79:	5f                   	pop    %edi
  801e7a:	5d                   	pop    %ebp
  801e7b:	c3                   	ret    
  801e7c:	39 ce                	cmp    %ecx,%esi
  801e7e:	77 28                	ja     801ea8 <__udivdi3+0x7c>
  801e80:	0f bd fe             	bsr    %esi,%edi
  801e83:	83 f7 1f             	xor    $0x1f,%edi
  801e86:	75 40                	jne    801ec8 <__udivdi3+0x9c>
  801e88:	39 ce                	cmp    %ecx,%esi
  801e8a:	72 0a                	jb     801e96 <__udivdi3+0x6a>
  801e8c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e90:	0f 87 9e 00 00 00    	ja     801f34 <__udivdi3+0x108>
  801e96:	b8 01 00 00 00       	mov    $0x1,%eax
  801e9b:	89 fa                	mov    %edi,%edx
  801e9d:	83 c4 1c             	add    $0x1c,%esp
  801ea0:	5b                   	pop    %ebx
  801ea1:	5e                   	pop    %esi
  801ea2:	5f                   	pop    %edi
  801ea3:	5d                   	pop    %ebp
  801ea4:	c3                   	ret    
  801ea5:	8d 76 00             	lea    0x0(%esi),%esi
  801ea8:	31 ff                	xor    %edi,%edi
  801eaa:	31 c0                	xor    %eax,%eax
  801eac:	89 fa                	mov    %edi,%edx
  801eae:	83 c4 1c             	add    $0x1c,%esp
  801eb1:	5b                   	pop    %ebx
  801eb2:	5e                   	pop    %esi
  801eb3:	5f                   	pop    %edi
  801eb4:	5d                   	pop    %ebp
  801eb5:	c3                   	ret    
  801eb6:	66 90                	xchg   %ax,%ax
  801eb8:	89 d8                	mov    %ebx,%eax
  801eba:	f7 f7                	div    %edi
  801ebc:	31 ff                	xor    %edi,%edi
  801ebe:	89 fa                	mov    %edi,%edx
  801ec0:	83 c4 1c             	add    $0x1c,%esp
  801ec3:	5b                   	pop    %ebx
  801ec4:	5e                   	pop    %esi
  801ec5:	5f                   	pop    %edi
  801ec6:	5d                   	pop    %ebp
  801ec7:	c3                   	ret    
  801ec8:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ecd:	89 eb                	mov    %ebp,%ebx
  801ecf:	29 fb                	sub    %edi,%ebx
  801ed1:	89 f9                	mov    %edi,%ecx
  801ed3:	d3 e6                	shl    %cl,%esi
  801ed5:	89 c5                	mov    %eax,%ebp
  801ed7:	88 d9                	mov    %bl,%cl
  801ed9:	d3 ed                	shr    %cl,%ebp
  801edb:	89 e9                	mov    %ebp,%ecx
  801edd:	09 f1                	or     %esi,%ecx
  801edf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ee3:	89 f9                	mov    %edi,%ecx
  801ee5:	d3 e0                	shl    %cl,%eax
  801ee7:	89 c5                	mov    %eax,%ebp
  801ee9:	89 d6                	mov    %edx,%esi
  801eeb:	88 d9                	mov    %bl,%cl
  801eed:	d3 ee                	shr    %cl,%esi
  801eef:	89 f9                	mov    %edi,%ecx
  801ef1:	d3 e2                	shl    %cl,%edx
  801ef3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ef7:	88 d9                	mov    %bl,%cl
  801ef9:	d3 e8                	shr    %cl,%eax
  801efb:	09 c2                	or     %eax,%edx
  801efd:	89 d0                	mov    %edx,%eax
  801eff:	89 f2                	mov    %esi,%edx
  801f01:	f7 74 24 0c          	divl   0xc(%esp)
  801f05:	89 d6                	mov    %edx,%esi
  801f07:	89 c3                	mov    %eax,%ebx
  801f09:	f7 e5                	mul    %ebp
  801f0b:	39 d6                	cmp    %edx,%esi
  801f0d:	72 19                	jb     801f28 <__udivdi3+0xfc>
  801f0f:	74 0b                	je     801f1c <__udivdi3+0xf0>
  801f11:	89 d8                	mov    %ebx,%eax
  801f13:	31 ff                	xor    %edi,%edi
  801f15:	e9 58 ff ff ff       	jmp    801e72 <__udivdi3+0x46>
  801f1a:	66 90                	xchg   %ax,%ax
  801f1c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801f20:	89 f9                	mov    %edi,%ecx
  801f22:	d3 e2                	shl    %cl,%edx
  801f24:	39 c2                	cmp    %eax,%edx
  801f26:	73 e9                	jae    801f11 <__udivdi3+0xe5>
  801f28:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801f2b:	31 ff                	xor    %edi,%edi
  801f2d:	e9 40 ff ff ff       	jmp    801e72 <__udivdi3+0x46>
  801f32:	66 90                	xchg   %ax,%ax
  801f34:	31 c0                	xor    %eax,%eax
  801f36:	e9 37 ff ff ff       	jmp    801e72 <__udivdi3+0x46>
  801f3b:	90                   	nop

00801f3c <__umoddi3>:
  801f3c:	55                   	push   %ebp
  801f3d:	57                   	push   %edi
  801f3e:	56                   	push   %esi
  801f3f:	53                   	push   %ebx
  801f40:	83 ec 1c             	sub    $0x1c,%esp
  801f43:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f47:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f4b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f4f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f53:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f57:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f5b:	89 f3                	mov    %esi,%ebx
  801f5d:	89 fa                	mov    %edi,%edx
  801f5f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f63:	89 34 24             	mov    %esi,(%esp)
  801f66:	85 c0                	test   %eax,%eax
  801f68:	75 1a                	jne    801f84 <__umoddi3+0x48>
  801f6a:	39 f7                	cmp    %esi,%edi
  801f6c:	0f 86 a2 00 00 00    	jbe    802014 <__umoddi3+0xd8>
  801f72:	89 c8                	mov    %ecx,%eax
  801f74:	89 f2                	mov    %esi,%edx
  801f76:	f7 f7                	div    %edi
  801f78:	89 d0                	mov    %edx,%eax
  801f7a:	31 d2                	xor    %edx,%edx
  801f7c:	83 c4 1c             	add    $0x1c,%esp
  801f7f:	5b                   	pop    %ebx
  801f80:	5e                   	pop    %esi
  801f81:	5f                   	pop    %edi
  801f82:	5d                   	pop    %ebp
  801f83:	c3                   	ret    
  801f84:	39 f0                	cmp    %esi,%eax
  801f86:	0f 87 ac 00 00 00    	ja     802038 <__umoddi3+0xfc>
  801f8c:	0f bd e8             	bsr    %eax,%ebp
  801f8f:	83 f5 1f             	xor    $0x1f,%ebp
  801f92:	0f 84 ac 00 00 00    	je     802044 <__umoddi3+0x108>
  801f98:	bf 20 00 00 00       	mov    $0x20,%edi
  801f9d:	29 ef                	sub    %ebp,%edi
  801f9f:	89 fe                	mov    %edi,%esi
  801fa1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801fa5:	89 e9                	mov    %ebp,%ecx
  801fa7:	d3 e0                	shl    %cl,%eax
  801fa9:	89 d7                	mov    %edx,%edi
  801fab:	89 f1                	mov    %esi,%ecx
  801fad:	d3 ef                	shr    %cl,%edi
  801faf:	09 c7                	or     %eax,%edi
  801fb1:	89 e9                	mov    %ebp,%ecx
  801fb3:	d3 e2                	shl    %cl,%edx
  801fb5:	89 14 24             	mov    %edx,(%esp)
  801fb8:	89 d8                	mov    %ebx,%eax
  801fba:	d3 e0                	shl    %cl,%eax
  801fbc:	89 c2                	mov    %eax,%edx
  801fbe:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fc2:	d3 e0                	shl    %cl,%eax
  801fc4:	89 44 24 04          	mov    %eax,0x4(%esp)
  801fc8:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fcc:	89 f1                	mov    %esi,%ecx
  801fce:	d3 e8                	shr    %cl,%eax
  801fd0:	09 d0                	or     %edx,%eax
  801fd2:	d3 eb                	shr    %cl,%ebx
  801fd4:	89 da                	mov    %ebx,%edx
  801fd6:	f7 f7                	div    %edi
  801fd8:	89 d3                	mov    %edx,%ebx
  801fda:	f7 24 24             	mull   (%esp)
  801fdd:	89 c6                	mov    %eax,%esi
  801fdf:	89 d1                	mov    %edx,%ecx
  801fe1:	39 d3                	cmp    %edx,%ebx
  801fe3:	0f 82 87 00 00 00    	jb     802070 <__umoddi3+0x134>
  801fe9:	0f 84 91 00 00 00    	je     802080 <__umoddi3+0x144>
  801fef:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ff3:	29 f2                	sub    %esi,%edx
  801ff5:	19 cb                	sbb    %ecx,%ebx
  801ff7:	89 d8                	mov    %ebx,%eax
  801ff9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ffd:	d3 e0                	shl    %cl,%eax
  801fff:	89 e9                	mov    %ebp,%ecx
  802001:	d3 ea                	shr    %cl,%edx
  802003:	09 d0                	or     %edx,%eax
  802005:	89 e9                	mov    %ebp,%ecx
  802007:	d3 eb                	shr    %cl,%ebx
  802009:	89 da                	mov    %ebx,%edx
  80200b:	83 c4 1c             	add    $0x1c,%esp
  80200e:	5b                   	pop    %ebx
  80200f:	5e                   	pop    %esi
  802010:	5f                   	pop    %edi
  802011:	5d                   	pop    %ebp
  802012:	c3                   	ret    
  802013:	90                   	nop
  802014:	89 fd                	mov    %edi,%ebp
  802016:	85 ff                	test   %edi,%edi
  802018:	75 0b                	jne    802025 <__umoddi3+0xe9>
  80201a:	b8 01 00 00 00       	mov    $0x1,%eax
  80201f:	31 d2                	xor    %edx,%edx
  802021:	f7 f7                	div    %edi
  802023:	89 c5                	mov    %eax,%ebp
  802025:	89 f0                	mov    %esi,%eax
  802027:	31 d2                	xor    %edx,%edx
  802029:	f7 f5                	div    %ebp
  80202b:	89 c8                	mov    %ecx,%eax
  80202d:	f7 f5                	div    %ebp
  80202f:	89 d0                	mov    %edx,%eax
  802031:	e9 44 ff ff ff       	jmp    801f7a <__umoddi3+0x3e>
  802036:	66 90                	xchg   %ax,%ax
  802038:	89 c8                	mov    %ecx,%eax
  80203a:	89 f2                	mov    %esi,%edx
  80203c:	83 c4 1c             	add    $0x1c,%esp
  80203f:	5b                   	pop    %ebx
  802040:	5e                   	pop    %esi
  802041:	5f                   	pop    %edi
  802042:	5d                   	pop    %ebp
  802043:	c3                   	ret    
  802044:	3b 04 24             	cmp    (%esp),%eax
  802047:	72 06                	jb     80204f <__umoddi3+0x113>
  802049:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80204d:	77 0f                	ja     80205e <__umoddi3+0x122>
  80204f:	89 f2                	mov    %esi,%edx
  802051:	29 f9                	sub    %edi,%ecx
  802053:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802057:	89 14 24             	mov    %edx,(%esp)
  80205a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80205e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802062:	8b 14 24             	mov    (%esp),%edx
  802065:	83 c4 1c             	add    $0x1c,%esp
  802068:	5b                   	pop    %ebx
  802069:	5e                   	pop    %esi
  80206a:	5f                   	pop    %edi
  80206b:	5d                   	pop    %ebp
  80206c:	c3                   	ret    
  80206d:	8d 76 00             	lea    0x0(%esi),%esi
  802070:	2b 04 24             	sub    (%esp),%eax
  802073:	19 fa                	sbb    %edi,%edx
  802075:	89 d1                	mov    %edx,%ecx
  802077:	89 c6                	mov    %eax,%esi
  802079:	e9 71 ff ff ff       	jmp    801fef <__umoddi3+0xb3>
  80207e:	66 90                	xchg   %ax,%ax
  802080:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802084:	72 ea                	jb     802070 <__umoddi3+0x134>
  802086:	89 d9                	mov    %ebx,%ecx
  802088:	e9 62 ff ff ff       	jmp    801fef <__umoddi3+0xb3>
