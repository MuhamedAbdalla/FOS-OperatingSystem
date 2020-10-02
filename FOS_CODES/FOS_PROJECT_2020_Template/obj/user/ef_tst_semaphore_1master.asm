
obj/user/ef_tst_semaphore_1master:     file format elf32-i386


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
  800031:	e8 d2 01 00 00       	call   800208 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Master program: create the semaphores, run slaves and wait them to finish
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	int envID = sys_getenvid();
  80003e:	e8 cf 15 00 00       	call   801612 <sys_getenvid>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)

	sys_createSemaphore("cs1", 1);
  800046:	83 ec 08             	sub    $0x8,%esp
  800049:	6a 01                	push   $0x1
  80004b:	68 20 20 80 00       	push   $0x802020
  800050:	e8 e5 17 00 00       	call   80183a <sys_createSemaphore>
  800055:	83 c4 10             	add    $0x10,%esp

	sys_createSemaphore("depend1", 0);
  800058:	83 ec 08             	sub    $0x8,%esp
  80005b:	6a 00                	push   $0x0
  80005d:	68 24 20 80 00       	push   $0x802024
  800062:	e8 d3 17 00 00       	call   80183a <sys_createSemaphore>
  800067:	83 c4 10             	add    $0x10,%esp

	int id1, id2, id3;
	id1 = sys_create_env("ef_sem1Slave", (myEnv->page_WS_max_size),(myEnv->SecondListSize), 50);
  80006a:	a1 20 30 80 00       	mov    0x803020,%eax
  80006f:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800075:	89 c2                	mov    %eax,%edx
  800077:	a1 20 30 80 00       	mov    0x803020,%eax
  80007c:	8b 40 74             	mov    0x74(%eax),%eax
  80007f:	6a 32                	push   $0x32
  800081:	52                   	push   %edx
  800082:	50                   	push   %eax
  800083:	68 2c 20 80 00       	push   $0x80202c
  800088:	e8 be 18 00 00       	call   80194b <sys_create_env>
  80008d:	83 c4 10             	add    $0x10,%esp
  800090:	89 45 f0             	mov    %eax,-0x10(%ebp)
	id2 = sys_create_env("ef_sem1Slave", (myEnv->page_WS_max_size),(myEnv->SecondListSize), 50);
  800093:	a1 20 30 80 00       	mov    0x803020,%eax
  800098:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80009e:	89 c2                	mov    %eax,%edx
  8000a0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000a5:	8b 40 74             	mov    0x74(%eax),%eax
  8000a8:	6a 32                	push   $0x32
  8000aa:	52                   	push   %edx
  8000ab:	50                   	push   %eax
  8000ac:	68 2c 20 80 00       	push   $0x80202c
  8000b1:	e8 95 18 00 00       	call   80194b <sys_create_env>
  8000b6:	83 c4 10             	add    $0x10,%esp
  8000b9:	89 45 ec             	mov    %eax,-0x14(%ebp)
	id3 = sys_create_env("ef_sem1Slave", (myEnv->page_WS_max_size),(myEnv->SecondListSize), 50);
  8000bc:	a1 20 30 80 00       	mov    0x803020,%eax
  8000c1:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000c7:	89 c2                	mov    %eax,%edx
  8000c9:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ce:	8b 40 74             	mov    0x74(%eax),%eax
  8000d1:	6a 32                	push   $0x32
  8000d3:	52                   	push   %edx
  8000d4:	50                   	push   %eax
  8000d5:	68 2c 20 80 00       	push   $0x80202c
  8000da:	e8 6c 18 00 00       	call   80194b <sys_create_env>
  8000df:	83 c4 10             	add    $0x10,%esp
  8000e2:	89 45 e8             	mov    %eax,-0x18(%ebp)

	sys_run_env(id1);
  8000e5:	83 ec 0c             	sub    $0xc,%esp
  8000e8:	ff 75 f0             	pushl  -0x10(%ebp)
  8000eb:	e8 79 18 00 00       	call   801969 <sys_run_env>
  8000f0:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id2);
  8000f3:	83 ec 0c             	sub    $0xc,%esp
  8000f6:	ff 75 ec             	pushl  -0x14(%ebp)
  8000f9:	e8 6b 18 00 00       	call   801969 <sys_run_env>
  8000fe:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id3);
  800101:	83 ec 0c             	sub    $0xc,%esp
  800104:	ff 75 e8             	pushl  -0x18(%ebp)
  800107:	e8 5d 18 00 00       	call   801969 <sys_run_env>
  80010c:	83 c4 10             	add    $0x10,%esp

	sys_waitSemaphore(envID, "depend1") ;
  80010f:	83 ec 08             	sub    $0x8,%esp
  800112:	68 24 20 80 00       	push   $0x802024
  800117:	ff 75 f4             	pushl  -0xc(%ebp)
  80011a:	e8 54 17 00 00       	call   801873 <sys_waitSemaphore>
  80011f:	83 c4 10             	add    $0x10,%esp
	sys_waitSemaphore(envID, "depend1") ;
  800122:	83 ec 08             	sub    $0x8,%esp
  800125:	68 24 20 80 00       	push   $0x802024
  80012a:	ff 75 f4             	pushl  -0xc(%ebp)
  80012d:	e8 41 17 00 00       	call   801873 <sys_waitSemaphore>
  800132:	83 c4 10             	add    $0x10,%esp
	sys_waitSemaphore(envID, "depend1") ;
  800135:	83 ec 08             	sub    $0x8,%esp
  800138:	68 24 20 80 00       	push   $0x802024
  80013d:	ff 75 f4             	pushl  -0xc(%ebp)
  800140:	e8 2e 17 00 00       	call   801873 <sys_waitSemaphore>
  800145:	83 c4 10             	add    $0x10,%esp

	int sem1val = sys_getSemaphoreValue(envID, "cs1");
  800148:	83 ec 08             	sub    $0x8,%esp
  80014b:	68 20 20 80 00       	push   $0x802020
  800150:	ff 75 f4             	pushl  -0xc(%ebp)
  800153:	e8 fe 16 00 00       	call   801856 <sys_getSemaphoreValue>
  800158:	83 c4 10             	add    $0x10,%esp
  80015b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int sem2val = sys_getSemaphoreValue(envID, "depend1");
  80015e:	83 ec 08             	sub    $0x8,%esp
  800161:	68 24 20 80 00       	push   $0x802024
  800166:	ff 75 f4             	pushl  -0xc(%ebp)
  800169:	e8 e8 16 00 00       	call   801856 <sys_getSemaphoreValue>
  80016e:	83 c4 10             	add    $0x10,%esp
  800171:	89 45 e0             	mov    %eax,-0x20(%ebp)
	if (sem2val == 0 && sem1val == 1)
  800174:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800178:	75 18                	jne    800192 <_main+0x15a>
  80017a:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  80017e:	75 12                	jne    800192 <_main+0x15a>
		cprintf("Congratulations!! Test of Semaphores [1] completed successfully!!\n\n\n");
  800180:	83 ec 0c             	sub    $0xc,%esp
  800183:	68 3c 20 80 00       	push   $0x80203c
  800188:	e8 94 02 00 00       	call   800421 <cprintf>
  80018d:	83 c4 10             	add    $0x10,%esp
  800190:	eb 10                	jmp    8001a2 <_main+0x16a>
	else
		cprintf("Error: wrong semaphore value... please review your semaphore code again...");
  800192:	83 ec 0c             	sub    $0xc,%esp
  800195:	68 84 20 80 00       	push   $0x802084
  80019a:	e8 82 02 00 00       	call   800421 <cprintf>
  80019f:	83 c4 10             	add    $0x10,%esp

	int32 parentenvID = sys_getparentenvid();
  8001a2:	e8 9d 14 00 00       	call   801644 <sys_getparentenvid>
  8001a7:	89 45 dc             	mov    %eax,-0x24(%ebp)
	if(parentenvID > 0)
  8001aa:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8001ae:	7e 55                	jle    800205 <_main+0x1cd>
	{
		//Get the check-finishing counter
		int *finishedCount = NULL;
  8001b0:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		finishedCount = sget(parentenvID, "finishedCount") ;
  8001b7:	83 ec 08             	sub    $0x8,%esp
  8001ba:	68 cf 20 80 00       	push   $0x8020cf
  8001bf:	ff 75 dc             	pushl  -0x24(%ebp)
  8001c2:	e8 d9 11 00 00       	call   8013a0 <sget>
  8001c7:	83 c4 10             	add    $0x10,%esp
  8001ca:	89 45 d8             	mov    %eax,-0x28(%ebp)
		sys_free_env(id1);
  8001cd:	83 ec 0c             	sub    $0xc,%esp
  8001d0:	ff 75 f0             	pushl  -0x10(%ebp)
  8001d3:	e8 ad 17 00 00       	call   801985 <sys_free_env>
  8001d8:	83 c4 10             	add    $0x10,%esp
		sys_free_env(id2);
  8001db:	83 ec 0c             	sub    $0xc,%esp
  8001de:	ff 75 ec             	pushl  -0x14(%ebp)
  8001e1:	e8 9f 17 00 00       	call   801985 <sys_free_env>
  8001e6:	83 c4 10             	add    $0x10,%esp
		sys_free_env(id3);
  8001e9:	83 ec 0c             	sub    $0xc,%esp
  8001ec:	ff 75 e8             	pushl  -0x18(%ebp)
  8001ef:	e8 91 17 00 00       	call   801985 <sys_free_env>
  8001f4:	83 c4 10             	add    $0x10,%esp
		(*finishedCount)++ ;
  8001f7:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001fa:	8b 00                	mov    (%eax),%eax
  8001fc:	8d 50 01             	lea    0x1(%eax),%edx
  8001ff:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800202:	89 10                	mov    %edx,(%eax)
	}

	return;
  800204:	90                   	nop
  800205:	90                   	nop
}
  800206:	c9                   	leave  
  800207:	c3                   	ret    

00800208 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800208:	55                   	push   %ebp
  800209:	89 e5                	mov    %esp,%ebp
  80020b:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80020e:	e8 18 14 00 00       	call   80162b <sys_getenvindex>
  800213:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800216:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800219:	89 d0                	mov    %edx,%eax
  80021b:	c1 e0 03             	shl    $0x3,%eax
  80021e:	01 d0                	add    %edx,%eax
  800220:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800227:	01 c8                	add    %ecx,%eax
  800229:	01 c0                	add    %eax,%eax
  80022b:	01 d0                	add    %edx,%eax
  80022d:	01 c0                	add    %eax,%eax
  80022f:	01 d0                	add    %edx,%eax
  800231:	89 c2                	mov    %eax,%edx
  800233:	c1 e2 05             	shl    $0x5,%edx
  800236:	29 c2                	sub    %eax,%edx
  800238:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80023f:	89 c2                	mov    %eax,%edx
  800241:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800247:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80024c:	a1 20 30 80 00       	mov    0x803020,%eax
  800251:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800257:	84 c0                	test   %al,%al
  800259:	74 0f                	je     80026a <libmain+0x62>
		binaryname = myEnv->prog_name;
  80025b:	a1 20 30 80 00       	mov    0x803020,%eax
  800260:	05 40 3c 01 00       	add    $0x13c40,%eax
  800265:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80026a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80026e:	7e 0a                	jle    80027a <libmain+0x72>
		binaryname = argv[0];
  800270:	8b 45 0c             	mov    0xc(%ebp),%eax
  800273:	8b 00                	mov    (%eax),%eax
  800275:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80027a:	83 ec 08             	sub    $0x8,%esp
  80027d:	ff 75 0c             	pushl  0xc(%ebp)
  800280:	ff 75 08             	pushl  0x8(%ebp)
  800283:	e8 b0 fd ff ff       	call   800038 <_main>
  800288:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80028b:	e8 36 15 00 00       	call   8017c6 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800290:	83 ec 0c             	sub    $0xc,%esp
  800293:	68 f8 20 80 00       	push   $0x8020f8
  800298:	e8 84 01 00 00       	call   800421 <cprintf>
  80029d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8002a0:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a5:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8002ab:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b0:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8002b6:	83 ec 04             	sub    $0x4,%esp
  8002b9:	52                   	push   %edx
  8002ba:	50                   	push   %eax
  8002bb:	68 20 21 80 00       	push   $0x802120
  8002c0:	e8 5c 01 00 00       	call   800421 <cprintf>
  8002c5:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8002c8:	a1 20 30 80 00       	mov    0x803020,%eax
  8002cd:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8002d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d8:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8002de:	83 ec 04             	sub    $0x4,%esp
  8002e1:	52                   	push   %edx
  8002e2:	50                   	push   %eax
  8002e3:	68 48 21 80 00       	push   $0x802148
  8002e8:	e8 34 01 00 00       	call   800421 <cprintf>
  8002ed:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f5:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8002fb:	83 ec 08             	sub    $0x8,%esp
  8002fe:	50                   	push   %eax
  8002ff:	68 89 21 80 00       	push   $0x802189
  800304:	e8 18 01 00 00       	call   800421 <cprintf>
  800309:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80030c:	83 ec 0c             	sub    $0xc,%esp
  80030f:	68 f8 20 80 00       	push   $0x8020f8
  800314:	e8 08 01 00 00       	call   800421 <cprintf>
  800319:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80031c:	e8 bf 14 00 00       	call   8017e0 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800321:	e8 19 00 00 00       	call   80033f <exit>
}
  800326:	90                   	nop
  800327:	c9                   	leave  
  800328:	c3                   	ret    

00800329 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800329:	55                   	push   %ebp
  80032a:	89 e5                	mov    %esp,%ebp
  80032c:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80032f:	83 ec 0c             	sub    $0xc,%esp
  800332:	6a 00                	push   $0x0
  800334:	e8 be 12 00 00       	call   8015f7 <sys_env_destroy>
  800339:	83 c4 10             	add    $0x10,%esp
}
  80033c:	90                   	nop
  80033d:	c9                   	leave  
  80033e:	c3                   	ret    

0080033f <exit>:

void
exit(void)
{
  80033f:	55                   	push   %ebp
  800340:	89 e5                	mov    %esp,%ebp
  800342:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800345:	e8 13 13 00 00       	call   80165d <sys_env_exit>
}
  80034a:	90                   	nop
  80034b:	c9                   	leave  
  80034c:	c3                   	ret    

0080034d <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80034d:	55                   	push   %ebp
  80034e:	89 e5                	mov    %esp,%ebp
  800350:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800353:	8b 45 0c             	mov    0xc(%ebp),%eax
  800356:	8b 00                	mov    (%eax),%eax
  800358:	8d 48 01             	lea    0x1(%eax),%ecx
  80035b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80035e:	89 0a                	mov    %ecx,(%edx)
  800360:	8b 55 08             	mov    0x8(%ebp),%edx
  800363:	88 d1                	mov    %dl,%cl
  800365:	8b 55 0c             	mov    0xc(%ebp),%edx
  800368:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80036c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80036f:	8b 00                	mov    (%eax),%eax
  800371:	3d ff 00 00 00       	cmp    $0xff,%eax
  800376:	75 2c                	jne    8003a4 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800378:	a0 24 30 80 00       	mov    0x803024,%al
  80037d:	0f b6 c0             	movzbl %al,%eax
  800380:	8b 55 0c             	mov    0xc(%ebp),%edx
  800383:	8b 12                	mov    (%edx),%edx
  800385:	89 d1                	mov    %edx,%ecx
  800387:	8b 55 0c             	mov    0xc(%ebp),%edx
  80038a:	83 c2 08             	add    $0x8,%edx
  80038d:	83 ec 04             	sub    $0x4,%esp
  800390:	50                   	push   %eax
  800391:	51                   	push   %ecx
  800392:	52                   	push   %edx
  800393:	e8 1d 12 00 00       	call   8015b5 <sys_cputs>
  800398:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80039b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80039e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8003a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003a7:	8b 40 04             	mov    0x4(%eax),%eax
  8003aa:	8d 50 01             	lea    0x1(%eax),%edx
  8003ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b0:	89 50 04             	mov    %edx,0x4(%eax)
}
  8003b3:	90                   	nop
  8003b4:	c9                   	leave  
  8003b5:	c3                   	ret    

008003b6 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8003b6:	55                   	push   %ebp
  8003b7:	89 e5                	mov    %esp,%ebp
  8003b9:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8003bf:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8003c6:	00 00 00 
	b.cnt = 0;
  8003c9:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8003d0:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8003d3:	ff 75 0c             	pushl  0xc(%ebp)
  8003d6:	ff 75 08             	pushl  0x8(%ebp)
  8003d9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003df:	50                   	push   %eax
  8003e0:	68 4d 03 80 00       	push   $0x80034d
  8003e5:	e8 11 02 00 00       	call   8005fb <vprintfmt>
  8003ea:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8003ed:	a0 24 30 80 00       	mov    0x803024,%al
  8003f2:	0f b6 c0             	movzbl %al,%eax
  8003f5:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8003fb:	83 ec 04             	sub    $0x4,%esp
  8003fe:	50                   	push   %eax
  8003ff:	52                   	push   %edx
  800400:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800406:	83 c0 08             	add    $0x8,%eax
  800409:	50                   	push   %eax
  80040a:	e8 a6 11 00 00       	call   8015b5 <sys_cputs>
  80040f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800412:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800419:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80041f:	c9                   	leave  
  800420:	c3                   	ret    

00800421 <cprintf>:

int cprintf(const char *fmt, ...) {
  800421:	55                   	push   %ebp
  800422:	89 e5                	mov    %esp,%ebp
  800424:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800427:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80042e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800431:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800434:	8b 45 08             	mov    0x8(%ebp),%eax
  800437:	83 ec 08             	sub    $0x8,%esp
  80043a:	ff 75 f4             	pushl  -0xc(%ebp)
  80043d:	50                   	push   %eax
  80043e:	e8 73 ff ff ff       	call   8003b6 <vcprintf>
  800443:	83 c4 10             	add    $0x10,%esp
  800446:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800449:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80044c:	c9                   	leave  
  80044d:	c3                   	ret    

0080044e <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80044e:	55                   	push   %ebp
  80044f:	89 e5                	mov    %esp,%ebp
  800451:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800454:	e8 6d 13 00 00       	call   8017c6 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800459:	8d 45 0c             	lea    0xc(%ebp),%eax
  80045c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80045f:	8b 45 08             	mov    0x8(%ebp),%eax
  800462:	83 ec 08             	sub    $0x8,%esp
  800465:	ff 75 f4             	pushl  -0xc(%ebp)
  800468:	50                   	push   %eax
  800469:	e8 48 ff ff ff       	call   8003b6 <vcprintf>
  80046e:	83 c4 10             	add    $0x10,%esp
  800471:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800474:	e8 67 13 00 00       	call   8017e0 <sys_enable_interrupt>
	return cnt;
  800479:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80047c:	c9                   	leave  
  80047d:	c3                   	ret    

0080047e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80047e:	55                   	push   %ebp
  80047f:	89 e5                	mov    %esp,%ebp
  800481:	53                   	push   %ebx
  800482:	83 ec 14             	sub    $0x14,%esp
  800485:	8b 45 10             	mov    0x10(%ebp),%eax
  800488:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80048b:	8b 45 14             	mov    0x14(%ebp),%eax
  80048e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800491:	8b 45 18             	mov    0x18(%ebp),%eax
  800494:	ba 00 00 00 00       	mov    $0x0,%edx
  800499:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80049c:	77 55                	ja     8004f3 <printnum+0x75>
  80049e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004a1:	72 05                	jb     8004a8 <printnum+0x2a>
  8004a3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8004a6:	77 4b                	ja     8004f3 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8004a8:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8004ab:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8004ae:	8b 45 18             	mov    0x18(%ebp),%eax
  8004b1:	ba 00 00 00 00       	mov    $0x0,%edx
  8004b6:	52                   	push   %edx
  8004b7:	50                   	push   %eax
  8004b8:	ff 75 f4             	pushl  -0xc(%ebp)
  8004bb:	ff 75 f0             	pushl  -0x10(%ebp)
  8004be:	e8 f5 18 00 00       	call   801db8 <__udivdi3>
  8004c3:	83 c4 10             	add    $0x10,%esp
  8004c6:	83 ec 04             	sub    $0x4,%esp
  8004c9:	ff 75 20             	pushl  0x20(%ebp)
  8004cc:	53                   	push   %ebx
  8004cd:	ff 75 18             	pushl  0x18(%ebp)
  8004d0:	52                   	push   %edx
  8004d1:	50                   	push   %eax
  8004d2:	ff 75 0c             	pushl  0xc(%ebp)
  8004d5:	ff 75 08             	pushl  0x8(%ebp)
  8004d8:	e8 a1 ff ff ff       	call   80047e <printnum>
  8004dd:	83 c4 20             	add    $0x20,%esp
  8004e0:	eb 1a                	jmp    8004fc <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8004e2:	83 ec 08             	sub    $0x8,%esp
  8004e5:	ff 75 0c             	pushl  0xc(%ebp)
  8004e8:	ff 75 20             	pushl  0x20(%ebp)
  8004eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ee:	ff d0                	call   *%eax
  8004f0:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8004f3:	ff 4d 1c             	decl   0x1c(%ebp)
  8004f6:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8004fa:	7f e6                	jg     8004e2 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8004fc:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8004ff:	bb 00 00 00 00       	mov    $0x0,%ebx
  800504:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800507:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80050a:	53                   	push   %ebx
  80050b:	51                   	push   %ecx
  80050c:	52                   	push   %edx
  80050d:	50                   	push   %eax
  80050e:	e8 b5 19 00 00       	call   801ec8 <__umoddi3>
  800513:	83 c4 10             	add    $0x10,%esp
  800516:	05 b4 23 80 00       	add    $0x8023b4,%eax
  80051b:	8a 00                	mov    (%eax),%al
  80051d:	0f be c0             	movsbl %al,%eax
  800520:	83 ec 08             	sub    $0x8,%esp
  800523:	ff 75 0c             	pushl  0xc(%ebp)
  800526:	50                   	push   %eax
  800527:	8b 45 08             	mov    0x8(%ebp),%eax
  80052a:	ff d0                	call   *%eax
  80052c:	83 c4 10             	add    $0x10,%esp
}
  80052f:	90                   	nop
  800530:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800533:	c9                   	leave  
  800534:	c3                   	ret    

00800535 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800535:	55                   	push   %ebp
  800536:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800538:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80053c:	7e 1c                	jle    80055a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80053e:	8b 45 08             	mov    0x8(%ebp),%eax
  800541:	8b 00                	mov    (%eax),%eax
  800543:	8d 50 08             	lea    0x8(%eax),%edx
  800546:	8b 45 08             	mov    0x8(%ebp),%eax
  800549:	89 10                	mov    %edx,(%eax)
  80054b:	8b 45 08             	mov    0x8(%ebp),%eax
  80054e:	8b 00                	mov    (%eax),%eax
  800550:	83 e8 08             	sub    $0x8,%eax
  800553:	8b 50 04             	mov    0x4(%eax),%edx
  800556:	8b 00                	mov    (%eax),%eax
  800558:	eb 40                	jmp    80059a <getuint+0x65>
	else if (lflag)
  80055a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80055e:	74 1e                	je     80057e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800560:	8b 45 08             	mov    0x8(%ebp),%eax
  800563:	8b 00                	mov    (%eax),%eax
  800565:	8d 50 04             	lea    0x4(%eax),%edx
  800568:	8b 45 08             	mov    0x8(%ebp),%eax
  80056b:	89 10                	mov    %edx,(%eax)
  80056d:	8b 45 08             	mov    0x8(%ebp),%eax
  800570:	8b 00                	mov    (%eax),%eax
  800572:	83 e8 04             	sub    $0x4,%eax
  800575:	8b 00                	mov    (%eax),%eax
  800577:	ba 00 00 00 00       	mov    $0x0,%edx
  80057c:	eb 1c                	jmp    80059a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80057e:	8b 45 08             	mov    0x8(%ebp),%eax
  800581:	8b 00                	mov    (%eax),%eax
  800583:	8d 50 04             	lea    0x4(%eax),%edx
  800586:	8b 45 08             	mov    0x8(%ebp),%eax
  800589:	89 10                	mov    %edx,(%eax)
  80058b:	8b 45 08             	mov    0x8(%ebp),%eax
  80058e:	8b 00                	mov    (%eax),%eax
  800590:	83 e8 04             	sub    $0x4,%eax
  800593:	8b 00                	mov    (%eax),%eax
  800595:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80059a:	5d                   	pop    %ebp
  80059b:	c3                   	ret    

0080059c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80059c:	55                   	push   %ebp
  80059d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80059f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005a3:	7e 1c                	jle    8005c1 <getint+0x25>
		return va_arg(*ap, long long);
  8005a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a8:	8b 00                	mov    (%eax),%eax
  8005aa:	8d 50 08             	lea    0x8(%eax),%edx
  8005ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b0:	89 10                	mov    %edx,(%eax)
  8005b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b5:	8b 00                	mov    (%eax),%eax
  8005b7:	83 e8 08             	sub    $0x8,%eax
  8005ba:	8b 50 04             	mov    0x4(%eax),%edx
  8005bd:	8b 00                	mov    (%eax),%eax
  8005bf:	eb 38                	jmp    8005f9 <getint+0x5d>
	else if (lflag)
  8005c1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8005c5:	74 1a                	je     8005e1 <getint+0x45>
		return va_arg(*ap, long);
  8005c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ca:	8b 00                	mov    (%eax),%eax
  8005cc:	8d 50 04             	lea    0x4(%eax),%edx
  8005cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d2:	89 10                	mov    %edx,(%eax)
  8005d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d7:	8b 00                	mov    (%eax),%eax
  8005d9:	83 e8 04             	sub    $0x4,%eax
  8005dc:	8b 00                	mov    (%eax),%eax
  8005de:	99                   	cltd   
  8005df:	eb 18                	jmp    8005f9 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8005e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e4:	8b 00                	mov    (%eax),%eax
  8005e6:	8d 50 04             	lea    0x4(%eax),%edx
  8005e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ec:	89 10                	mov    %edx,(%eax)
  8005ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f1:	8b 00                	mov    (%eax),%eax
  8005f3:	83 e8 04             	sub    $0x4,%eax
  8005f6:	8b 00                	mov    (%eax),%eax
  8005f8:	99                   	cltd   
}
  8005f9:	5d                   	pop    %ebp
  8005fa:	c3                   	ret    

008005fb <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8005fb:	55                   	push   %ebp
  8005fc:	89 e5                	mov    %esp,%ebp
  8005fe:	56                   	push   %esi
  8005ff:	53                   	push   %ebx
  800600:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800603:	eb 17                	jmp    80061c <vprintfmt+0x21>
			if (ch == '\0')
  800605:	85 db                	test   %ebx,%ebx
  800607:	0f 84 af 03 00 00    	je     8009bc <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80060d:	83 ec 08             	sub    $0x8,%esp
  800610:	ff 75 0c             	pushl  0xc(%ebp)
  800613:	53                   	push   %ebx
  800614:	8b 45 08             	mov    0x8(%ebp),%eax
  800617:	ff d0                	call   *%eax
  800619:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80061c:	8b 45 10             	mov    0x10(%ebp),%eax
  80061f:	8d 50 01             	lea    0x1(%eax),%edx
  800622:	89 55 10             	mov    %edx,0x10(%ebp)
  800625:	8a 00                	mov    (%eax),%al
  800627:	0f b6 d8             	movzbl %al,%ebx
  80062a:	83 fb 25             	cmp    $0x25,%ebx
  80062d:	75 d6                	jne    800605 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80062f:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800633:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80063a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800641:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800648:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80064f:	8b 45 10             	mov    0x10(%ebp),%eax
  800652:	8d 50 01             	lea    0x1(%eax),%edx
  800655:	89 55 10             	mov    %edx,0x10(%ebp)
  800658:	8a 00                	mov    (%eax),%al
  80065a:	0f b6 d8             	movzbl %al,%ebx
  80065d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800660:	83 f8 55             	cmp    $0x55,%eax
  800663:	0f 87 2b 03 00 00    	ja     800994 <vprintfmt+0x399>
  800669:	8b 04 85 d8 23 80 00 	mov    0x8023d8(,%eax,4),%eax
  800670:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800672:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800676:	eb d7                	jmp    80064f <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800678:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80067c:	eb d1                	jmp    80064f <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80067e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800685:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800688:	89 d0                	mov    %edx,%eax
  80068a:	c1 e0 02             	shl    $0x2,%eax
  80068d:	01 d0                	add    %edx,%eax
  80068f:	01 c0                	add    %eax,%eax
  800691:	01 d8                	add    %ebx,%eax
  800693:	83 e8 30             	sub    $0x30,%eax
  800696:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800699:	8b 45 10             	mov    0x10(%ebp),%eax
  80069c:	8a 00                	mov    (%eax),%al
  80069e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8006a1:	83 fb 2f             	cmp    $0x2f,%ebx
  8006a4:	7e 3e                	jle    8006e4 <vprintfmt+0xe9>
  8006a6:	83 fb 39             	cmp    $0x39,%ebx
  8006a9:	7f 39                	jg     8006e4 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006ab:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8006ae:	eb d5                	jmp    800685 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8006b0:	8b 45 14             	mov    0x14(%ebp),%eax
  8006b3:	83 c0 04             	add    $0x4,%eax
  8006b6:	89 45 14             	mov    %eax,0x14(%ebp)
  8006b9:	8b 45 14             	mov    0x14(%ebp),%eax
  8006bc:	83 e8 04             	sub    $0x4,%eax
  8006bf:	8b 00                	mov    (%eax),%eax
  8006c1:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8006c4:	eb 1f                	jmp    8006e5 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8006c6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006ca:	79 83                	jns    80064f <vprintfmt+0x54>
				width = 0;
  8006cc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8006d3:	e9 77 ff ff ff       	jmp    80064f <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8006d8:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8006df:	e9 6b ff ff ff       	jmp    80064f <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8006e4:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8006e5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006e9:	0f 89 60 ff ff ff    	jns    80064f <vprintfmt+0x54>
				width = precision, precision = -1;
  8006ef:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8006f5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8006fc:	e9 4e ff ff ff       	jmp    80064f <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800701:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800704:	e9 46 ff ff ff       	jmp    80064f <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800709:	8b 45 14             	mov    0x14(%ebp),%eax
  80070c:	83 c0 04             	add    $0x4,%eax
  80070f:	89 45 14             	mov    %eax,0x14(%ebp)
  800712:	8b 45 14             	mov    0x14(%ebp),%eax
  800715:	83 e8 04             	sub    $0x4,%eax
  800718:	8b 00                	mov    (%eax),%eax
  80071a:	83 ec 08             	sub    $0x8,%esp
  80071d:	ff 75 0c             	pushl  0xc(%ebp)
  800720:	50                   	push   %eax
  800721:	8b 45 08             	mov    0x8(%ebp),%eax
  800724:	ff d0                	call   *%eax
  800726:	83 c4 10             	add    $0x10,%esp
			break;
  800729:	e9 89 02 00 00       	jmp    8009b7 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80072e:	8b 45 14             	mov    0x14(%ebp),%eax
  800731:	83 c0 04             	add    $0x4,%eax
  800734:	89 45 14             	mov    %eax,0x14(%ebp)
  800737:	8b 45 14             	mov    0x14(%ebp),%eax
  80073a:	83 e8 04             	sub    $0x4,%eax
  80073d:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80073f:	85 db                	test   %ebx,%ebx
  800741:	79 02                	jns    800745 <vprintfmt+0x14a>
				err = -err;
  800743:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800745:	83 fb 64             	cmp    $0x64,%ebx
  800748:	7f 0b                	jg     800755 <vprintfmt+0x15a>
  80074a:	8b 34 9d 20 22 80 00 	mov    0x802220(,%ebx,4),%esi
  800751:	85 f6                	test   %esi,%esi
  800753:	75 19                	jne    80076e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800755:	53                   	push   %ebx
  800756:	68 c5 23 80 00       	push   $0x8023c5
  80075b:	ff 75 0c             	pushl  0xc(%ebp)
  80075e:	ff 75 08             	pushl  0x8(%ebp)
  800761:	e8 5e 02 00 00       	call   8009c4 <printfmt>
  800766:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800769:	e9 49 02 00 00       	jmp    8009b7 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80076e:	56                   	push   %esi
  80076f:	68 ce 23 80 00       	push   $0x8023ce
  800774:	ff 75 0c             	pushl  0xc(%ebp)
  800777:	ff 75 08             	pushl  0x8(%ebp)
  80077a:	e8 45 02 00 00       	call   8009c4 <printfmt>
  80077f:	83 c4 10             	add    $0x10,%esp
			break;
  800782:	e9 30 02 00 00       	jmp    8009b7 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800787:	8b 45 14             	mov    0x14(%ebp),%eax
  80078a:	83 c0 04             	add    $0x4,%eax
  80078d:	89 45 14             	mov    %eax,0x14(%ebp)
  800790:	8b 45 14             	mov    0x14(%ebp),%eax
  800793:	83 e8 04             	sub    $0x4,%eax
  800796:	8b 30                	mov    (%eax),%esi
  800798:	85 f6                	test   %esi,%esi
  80079a:	75 05                	jne    8007a1 <vprintfmt+0x1a6>
				p = "(null)";
  80079c:	be d1 23 80 00       	mov    $0x8023d1,%esi
			if (width > 0 && padc != '-')
  8007a1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007a5:	7e 6d                	jle    800814 <vprintfmt+0x219>
  8007a7:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8007ab:	74 67                	je     800814 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8007ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007b0:	83 ec 08             	sub    $0x8,%esp
  8007b3:	50                   	push   %eax
  8007b4:	56                   	push   %esi
  8007b5:	e8 0c 03 00 00       	call   800ac6 <strnlen>
  8007ba:	83 c4 10             	add    $0x10,%esp
  8007bd:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8007c0:	eb 16                	jmp    8007d8 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8007c2:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8007c6:	83 ec 08             	sub    $0x8,%esp
  8007c9:	ff 75 0c             	pushl  0xc(%ebp)
  8007cc:	50                   	push   %eax
  8007cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d0:	ff d0                	call   *%eax
  8007d2:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8007d5:	ff 4d e4             	decl   -0x1c(%ebp)
  8007d8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007dc:	7f e4                	jg     8007c2 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8007de:	eb 34                	jmp    800814 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8007e0:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8007e4:	74 1c                	je     800802 <vprintfmt+0x207>
  8007e6:	83 fb 1f             	cmp    $0x1f,%ebx
  8007e9:	7e 05                	jle    8007f0 <vprintfmt+0x1f5>
  8007eb:	83 fb 7e             	cmp    $0x7e,%ebx
  8007ee:	7e 12                	jle    800802 <vprintfmt+0x207>
					putch('?', putdat);
  8007f0:	83 ec 08             	sub    $0x8,%esp
  8007f3:	ff 75 0c             	pushl  0xc(%ebp)
  8007f6:	6a 3f                	push   $0x3f
  8007f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fb:	ff d0                	call   *%eax
  8007fd:	83 c4 10             	add    $0x10,%esp
  800800:	eb 0f                	jmp    800811 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800802:	83 ec 08             	sub    $0x8,%esp
  800805:	ff 75 0c             	pushl  0xc(%ebp)
  800808:	53                   	push   %ebx
  800809:	8b 45 08             	mov    0x8(%ebp),%eax
  80080c:	ff d0                	call   *%eax
  80080e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800811:	ff 4d e4             	decl   -0x1c(%ebp)
  800814:	89 f0                	mov    %esi,%eax
  800816:	8d 70 01             	lea    0x1(%eax),%esi
  800819:	8a 00                	mov    (%eax),%al
  80081b:	0f be d8             	movsbl %al,%ebx
  80081e:	85 db                	test   %ebx,%ebx
  800820:	74 24                	je     800846 <vprintfmt+0x24b>
  800822:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800826:	78 b8                	js     8007e0 <vprintfmt+0x1e5>
  800828:	ff 4d e0             	decl   -0x20(%ebp)
  80082b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80082f:	79 af                	jns    8007e0 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800831:	eb 13                	jmp    800846 <vprintfmt+0x24b>
				putch(' ', putdat);
  800833:	83 ec 08             	sub    $0x8,%esp
  800836:	ff 75 0c             	pushl  0xc(%ebp)
  800839:	6a 20                	push   $0x20
  80083b:	8b 45 08             	mov    0x8(%ebp),%eax
  80083e:	ff d0                	call   *%eax
  800840:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800843:	ff 4d e4             	decl   -0x1c(%ebp)
  800846:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80084a:	7f e7                	jg     800833 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80084c:	e9 66 01 00 00       	jmp    8009b7 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800851:	83 ec 08             	sub    $0x8,%esp
  800854:	ff 75 e8             	pushl  -0x18(%ebp)
  800857:	8d 45 14             	lea    0x14(%ebp),%eax
  80085a:	50                   	push   %eax
  80085b:	e8 3c fd ff ff       	call   80059c <getint>
  800860:	83 c4 10             	add    $0x10,%esp
  800863:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800866:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800869:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80086c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80086f:	85 d2                	test   %edx,%edx
  800871:	79 23                	jns    800896 <vprintfmt+0x29b>
				putch('-', putdat);
  800873:	83 ec 08             	sub    $0x8,%esp
  800876:	ff 75 0c             	pushl  0xc(%ebp)
  800879:	6a 2d                	push   $0x2d
  80087b:	8b 45 08             	mov    0x8(%ebp),%eax
  80087e:	ff d0                	call   *%eax
  800880:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800883:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800886:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800889:	f7 d8                	neg    %eax
  80088b:	83 d2 00             	adc    $0x0,%edx
  80088e:	f7 da                	neg    %edx
  800890:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800893:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800896:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80089d:	e9 bc 00 00 00       	jmp    80095e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8008a2:	83 ec 08             	sub    $0x8,%esp
  8008a5:	ff 75 e8             	pushl  -0x18(%ebp)
  8008a8:	8d 45 14             	lea    0x14(%ebp),%eax
  8008ab:	50                   	push   %eax
  8008ac:	e8 84 fc ff ff       	call   800535 <getuint>
  8008b1:	83 c4 10             	add    $0x10,%esp
  8008b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008b7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8008ba:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008c1:	e9 98 00 00 00       	jmp    80095e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8008c6:	83 ec 08             	sub    $0x8,%esp
  8008c9:	ff 75 0c             	pushl  0xc(%ebp)
  8008cc:	6a 58                	push   $0x58
  8008ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d1:	ff d0                	call   *%eax
  8008d3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8008d6:	83 ec 08             	sub    $0x8,%esp
  8008d9:	ff 75 0c             	pushl  0xc(%ebp)
  8008dc:	6a 58                	push   $0x58
  8008de:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e1:	ff d0                	call   *%eax
  8008e3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8008e6:	83 ec 08             	sub    $0x8,%esp
  8008e9:	ff 75 0c             	pushl  0xc(%ebp)
  8008ec:	6a 58                	push   $0x58
  8008ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f1:	ff d0                	call   *%eax
  8008f3:	83 c4 10             	add    $0x10,%esp
			break;
  8008f6:	e9 bc 00 00 00       	jmp    8009b7 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8008fb:	83 ec 08             	sub    $0x8,%esp
  8008fe:	ff 75 0c             	pushl  0xc(%ebp)
  800901:	6a 30                	push   $0x30
  800903:	8b 45 08             	mov    0x8(%ebp),%eax
  800906:	ff d0                	call   *%eax
  800908:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80090b:	83 ec 08             	sub    $0x8,%esp
  80090e:	ff 75 0c             	pushl  0xc(%ebp)
  800911:	6a 78                	push   $0x78
  800913:	8b 45 08             	mov    0x8(%ebp),%eax
  800916:	ff d0                	call   *%eax
  800918:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80091b:	8b 45 14             	mov    0x14(%ebp),%eax
  80091e:	83 c0 04             	add    $0x4,%eax
  800921:	89 45 14             	mov    %eax,0x14(%ebp)
  800924:	8b 45 14             	mov    0x14(%ebp),%eax
  800927:	83 e8 04             	sub    $0x4,%eax
  80092a:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80092c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80092f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800936:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80093d:	eb 1f                	jmp    80095e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80093f:	83 ec 08             	sub    $0x8,%esp
  800942:	ff 75 e8             	pushl  -0x18(%ebp)
  800945:	8d 45 14             	lea    0x14(%ebp),%eax
  800948:	50                   	push   %eax
  800949:	e8 e7 fb ff ff       	call   800535 <getuint>
  80094e:	83 c4 10             	add    $0x10,%esp
  800951:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800954:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800957:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80095e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800962:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800965:	83 ec 04             	sub    $0x4,%esp
  800968:	52                   	push   %edx
  800969:	ff 75 e4             	pushl  -0x1c(%ebp)
  80096c:	50                   	push   %eax
  80096d:	ff 75 f4             	pushl  -0xc(%ebp)
  800970:	ff 75 f0             	pushl  -0x10(%ebp)
  800973:	ff 75 0c             	pushl  0xc(%ebp)
  800976:	ff 75 08             	pushl  0x8(%ebp)
  800979:	e8 00 fb ff ff       	call   80047e <printnum>
  80097e:	83 c4 20             	add    $0x20,%esp
			break;
  800981:	eb 34                	jmp    8009b7 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800983:	83 ec 08             	sub    $0x8,%esp
  800986:	ff 75 0c             	pushl  0xc(%ebp)
  800989:	53                   	push   %ebx
  80098a:	8b 45 08             	mov    0x8(%ebp),%eax
  80098d:	ff d0                	call   *%eax
  80098f:	83 c4 10             	add    $0x10,%esp
			break;
  800992:	eb 23                	jmp    8009b7 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800994:	83 ec 08             	sub    $0x8,%esp
  800997:	ff 75 0c             	pushl  0xc(%ebp)
  80099a:	6a 25                	push   $0x25
  80099c:	8b 45 08             	mov    0x8(%ebp),%eax
  80099f:	ff d0                	call   *%eax
  8009a1:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8009a4:	ff 4d 10             	decl   0x10(%ebp)
  8009a7:	eb 03                	jmp    8009ac <vprintfmt+0x3b1>
  8009a9:	ff 4d 10             	decl   0x10(%ebp)
  8009ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8009af:	48                   	dec    %eax
  8009b0:	8a 00                	mov    (%eax),%al
  8009b2:	3c 25                	cmp    $0x25,%al
  8009b4:	75 f3                	jne    8009a9 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8009b6:	90                   	nop
		}
	}
  8009b7:	e9 47 fc ff ff       	jmp    800603 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8009bc:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8009bd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8009c0:	5b                   	pop    %ebx
  8009c1:	5e                   	pop    %esi
  8009c2:	5d                   	pop    %ebp
  8009c3:	c3                   	ret    

008009c4 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8009c4:	55                   	push   %ebp
  8009c5:	89 e5                	mov    %esp,%ebp
  8009c7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8009ca:	8d 45 10             	lea    0x10(%ebp),%eax
  8009cd:	83 c0 04             	add    $0x4,%eax
  8009d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8009d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8009d6:	ff 75 f4             	pushl  -0xc(%ebp)
  8009d9:	50                   	push   %eax
  8009da:	ff 75 0c             	pushl  0xc(%ebp)
  8009dd:	ff 75 08             	pushl  0x8(%ebp)
  8009e0:	e8 16 fc ff ff       	call   8005fb <vprintfmt>
  8009e5:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8009e8:	90                   	nop
  8009e9:	c9                   	leave  
  8009ea:	c3                   	ret    

008009eb <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8009eb:	55                   	push   %ebp
  8009ec:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8009ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f1:	8b 40 08             	mov    0x8(%eax),%eax
  8009f4:	8d 50 01             	lea    0x1(%eax),%edx
  8009f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009fa:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8009fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a00:	8b 10                	mov    (%eax),%edx
  800a02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a05:	8b 40 04             	mov    0x4(%eax),%eax
  800a08:	39 c2                	cmp    %eax,%edx
  800a0a:	73 12                	jae    800a1e <sprintputch+0x33>
		*b->buf++ = ch;
  800a0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a0f:	8b 00                	mov    (%eax),%eax
  800a11:	8d 48 01             	lea    0x1(%eax),%ecx
  800a14:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a17:	89 0a                	mov    %ecx,(%edx)
  800a19:	8b 55 08             	mov    0x8(%ebp),%edx
  800a1c:	88 10                	mov    %dl,(%eax)
}
  800a1e:	90                   	nop
  800a1f:	5d                   	pop    %ebp
  800a20:	c3                   	ret    

00800a21 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a21:	55                   	push   %ebp
  800a22:	89 e5                	mov    %esp,%ebp
  800a24:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a27:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a30:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a33:	8b 45 08             	mov    0x8(%ebp),%eax
  800a36:	01 d0                	add    %edx,%eax
  800a38:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a3b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a42:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a46:	74 06                	je     800a4e <vsnprintf+0x2d>
  800a48:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a4c:	7f 07                	jg     800a55 <vsnprintf+0x34>
		return -E_INVAL;
  800a4e:	b8 03 00 00 00       	mov    $0x3,%eax
  800a53:	eb 20                	jmp    800a75 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a55:	ff 75 14             	pushl  0x14(%ebp)
  800a58:	ff 75 10             	pushl  0x10(%ebp)
  800a5b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800a5e:	50                   	push   %eax
  800a5f:	68 eb 09 80 00       	push   $0x8009eb
  800a64:	e8 92 fb ff ff       	call   8005fb <vprintfmt>
  800a69:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800a6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a6f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800a72:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800a75:	c9                   	leave  
  800a76:	c3                   	ret    

00800a77 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800a77:	55                   	push   %ebp
  800a78:	89 e5                	mov    %esp,%ebp
  800a7a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800a7d:	8d 45 10             	lea    0x10(%ebp),%eax
  800a80:	83 c0 04             	add    $0x4,%eax
  800a83:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800a86:	8b 45 10             	mov    0x10(%ebp),%eax
  800a89:	ff 75 f4             	pushl  -0xc(%ebp)
  800a8c:	50                   	push   %eax
  800a8d:	ff 75 0c             	pushl  0xc(%ebp)
  800a90:	ff 75 08             	pushl  0x8(%ebp)
  800a93:	e8 89 ff ff ff       	call   800a21 <vsnprintf>
  800a98:	83 c4 10             	add    $0x10,%esp
  800a9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800a9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800aa1:	c9                   	leave  
  800aa2:	c3                   	ret    

00800aa3 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800aa3:	55                   	push   %ebp
  800aa4:	89 e5                	mov    %esp,%ebp
  800aa6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800aa9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ab0:	eb 06                	jmp    800ab8 <strlen+0x15>
		n++;
  800ab2:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ab5:	ff 45 08             	incl   0x8(%ebp)
  800ab8:	8b 45 08             	mov    0x8(%ebp),%eax
  800abb:	8a 00                	mov    (%eax),%al
  800abd:	84 c0                	test   %al,%al
  800abf:	75 f1                	jne    800ab2 <strlen+0xf>
		n++;
	return n;
  800ac1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ac4:	c9                   	leave  
  800ac5:	c3                   	ret    

00800ac6 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ac6:	55                   	push   %ebp
  800ac7:	89 e5                	mov    %esp,%ebp
  800ac9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800acc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ad3:	eb 09                	jmp    800ade <strnlen+0x18>
		n++;
  800ad5:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ad8:	ff 45 08             	incl   0x8(%ebp)
  800adb:	ff 4d 0c             	decl   0xc(%ebp)
  800ade:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ae2:	74 09                	je     800aed <strnlen+0x27>
  800ae4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae7:	8a 00                	mov    (%eax),%al
  800ae9:	84 c0                	test   %al,%al
  800aeb:	75 e8                	jne    800ad5 <strnlen+0xf>
		n++;
	return n;
  800aed:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800af0:	c9                   	leave  
  800af1:	c3                   	ret    

00800af2 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800af2:	55                   	push   %ebp
  800af3:	89 e5                	mov    %esp,%ebp
  800af5:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800af8:	8b 45 08             	mov    0x8(%ebp),%eax
  800afb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800afe:	90                   	nop
  800aff:	8b 45 08             	mov    0x8(%ebp),%eax
  800b02:	8d 50 01             	lea    0x1(%eax),%edx
  800b05:	89 55 08             	mov    %edx,0x8(%ebp)
  800b08:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b0b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b0e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b11:	8a 12                	mov    (%edx),%dl
  800b13:	88 10                	mov    %dl,(%eax)
  800b15:	8a 00                	mov    (%eax),%al
  800b17:	84 c0                	test   %al,%al
  800b19:	75 e4                	jne    800aff <strcpy+0xd>
		/* do nothing */;
	return ret;
  800b1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b1e:	c9                   	leave  
  800b1f:	c3                   	ret    

00800b20 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b20:	55                   	push   %ebp
  800b21:	89 e5                	mov    %esp,%ebp
  800b23:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800b2c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b33:	eb 1f                	jmp    800b54 <strncpy+0x34>
		*dst++ = *src;
  800b35:	8b 45 08             	mov    0x8(%ebp),%eax
  800b38:	8d 50 01             	lea    0x1(%eax),%edx
  800b3b:	89 55 08             	mov    %edx,0x8(%ebp)
  800b3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b41:	8a 12                	mov    (%edx),%dl
  800b43:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b48:	8a 00                	mov    (%eax),%al
  800b4a:	84 c0                	test   %al,%al
  800b4c:	74 03                	je     800b51 <strncpy+0x31>
			src++;
  800b4e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b51:	ff 45 fc             	incl   -0x4(%ebp)
  800b54:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b57:	3b 45 10             	cmp    0x10(%ebp),%eax
  800b5a:	72 d9                	jb     800b35 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800b5c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800b5f:	c9                   	leave  
  800b60:	c3                   	ret    

00800b61 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800b61:	55                   	push   %ebp
  800b62:	89 e5                	mov    %esp,%ebp
  800b64:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800b67:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800b6d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b71:	74 30                	je     800ba3 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800b73:	eb 16                	jmp    800b8b <strlcpy+0x2a>
			*dst++ = *src++;
  800b75:	8b 45 08             	mov    0x8(%ebp),%eax
  800b78:	8d 50 01             	lea    0x1(%eax),%edx
  800b7b:	89 55 08             	mov    %edx,0x8(%ebp)
  800b7e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b81:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b84:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b87:	8a 12                	mov    (%edx),%dl
  800b89:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800b8b:	ff 4d 10             	decl   0x10(%ebp)
  800b8e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b92:	74 09                	je     800b9d <strlcpy+0x3c>
  800b94:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b97:	8a 00                	mov    (%eax),%al
  800b99:	84 c0                	test   %al,%al
  800b9b:	75 d8                	jne    800b75 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800b9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba0:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ba3:	8b 55 08             	mov    0x8(%ebp),%edx
  800ba6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ba9:	29 c2                	sub    %eax,%edx
  800bab:	89 d0                	mov    %edx,%eax
}
  800bad:	c9                   	leave  
  800bae:	c3                   	ret    

00800baf <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800baf:	55                   	push   %ebp
  800bb0:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800bb2:	eb 06                	jmp    800bba <strcmp+0xb>
		p++, q++;
  800bb4:	ff 45 08             	incl   0x8(%ebp)
  800bb7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800bba:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbd:	8a 00                	mov    (%eax),%al
  800bbf:	84 c0                	test   %al,%al
  800bc1:	74 0e                	je     800bd1 <strcmp+0x22>
  800bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc6:	8a 10                	mov    (%eax),%dl
  800bc8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bcb:	8a 00                	mov    (%eax),%al
  800bcd:	38 c2                	cmp    %al,%dl
  800bcf:	74 e3                	je     800bb4 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd4:	8a 00                	mov    (%eax),%al
  800bd6:	0f b6 d0             	movzbl %al,%edx
  800bd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdc:	8a 00                	mov    (%eax),%al
  800bde:	0f b6 c0             	movzbl %al,%eax
  800be1:	29 c2                	sub    %eax,%edx
  800be3:	89 d0                	mov    %edx,%eax
}
  800be5:	5d                   	pop    %ebp
  800be6:	c3                   	ret    

00800be7 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800be7:	55                   	push   %ebp
  800be8:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800bea:	eb 09                	jmp    800bf5 <strncmp+0xe>
		n--, p++, q++;
  800bec:	ff 4d 10             	decl   0x10(%ebp)
  800bef:	ff 45 08             	incl   0x8(%ebp)
  800bf2:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800bf5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bf9:	74 17                	je     800c12 <strncmp+0x2b>
  800bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfe:	8a 00                	mov    (%eax),%al
  800c00:	84 c0                	test   %al,%al
  800c02:	74 0e                	je     800c12 <strncmp+0x2b>
  800c04:	8b 45 08             	mov    0x8(%ebp),%eax
  800c07:	8a 10                	mov    (%eax),%dl
  800c09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0c:	8a 00                	mov    (%eax),%al
  800c0e:	38 c2                	cmp    %al,%dl
  800c10:	74 da                	je     800bec <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c12:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c16:	75 07                	jne    800c1f <strncmp+0x38>
		return 0;
  800c18:	b8 00 00 00 00       	mov    $0x0,%eax
  800c1d:	eb 14                	jmp    800c33 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c22:	8a 00                	mov    (%eax),%al
  800c24:	0f b6 d0             	movzbl %al,%edx
  800c27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c2a:	8a 00                	mov    (%eax),%al
  800c2c:	0f b6 c0             	movzbl %al,%eax
  800c2f:	29 c2                	sub    %eax,%edx
  800c31:	89 d0                	mov    %edx,%eax
}
  800c33:	5d                   	pop    %ebp
  800c34:	c3                   	ret    

00800c35 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800c35:	55                   	push   %ebp
  800c36:	89 e5                	mov    %esp,%ebp
  800c38:	83 ec 04             	sub    $0x4,%esp
  800c3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c3e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c41:	eb 12                	jmp    800c55 <strchr+0x20>
		if (*s == c)
  800c43:	8b 45 08             	mov    0x8(%ebp),%eax
  800c46:	8a 00                	mov    (%eax),%al
  800c48:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c4b:	75 05                	jne    800c52 <strchr+0x1d>
			return (char *) s;
  800c4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c50:	eb 11                	jmp    800c63 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c52:	ff 45 08             	incl   0x8(%ebp)
  800c55:	8b 45 08             	mov    0x8(%ebp),%eax
  800c58:	8a 00                	mov    (%eax),%al
  800c5a:	84 c0                	test   %al,%al
  800c5c:	75 e5                	jne    800c43 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800c5e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c63:	c9                   	leave  
  800c64:	c3                   	ret    

00800c65 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800c65:	55                   	push   %ebp
  800c66:	89 e5                	mov    %esp,%ebp
  800c68:	83 ec 04             	sub    $0x4,%esp
  800c6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c6e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c71:	eb 0d                	jmp    800c80 <strfind+0x1b>
		if (*s == c)
  800c73:	8b 45 08             	mov    0x8(%ebp),%eax
  800c76:	8a 00                	mov    (%eax),%al
  800c78:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c7b:	74 0e                	je     800c8b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800c7d:	ff 45 08             	incl   0x8(%ebp)
  800c80:	8b 45 08             	mov    0x8(%ebp),%eax
  800c83:	8a 00                	mov    (%eax),%al
  800c85:	84 c0                	test   %al,%al
  800c87:	75 ea                	jne    800c73 <strfind+0xe>
  800c89:	eb 01                	jmp    800c8c <strfind+0x27>
		if (*s == c)
			break;
  800c8b:	90                   	nop
	return (char *) s;
  800c8c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c8f:	c9                   	leave  
  800c90:	c3                   	ret    

00800c91 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800c91:	55                   	push   %ebp
  800c92:	89 e5                	mov    %esp,%ebp
  800c94:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800c97:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800c9d:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ca3:	eb 0e                	jmp    800cb3 <memset+0x22>
		*p++ = c;
  800ca5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ca8:	8d 50 01             	lea    0x1(%eax),%edx
  800cab:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800cae:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cb1:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800cb3:	ff 4d f8             	decl   -0x8(%ebp)
  800cb6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800cba:	79 e9                	jns    800ca5 <memset+0x14>
		*p++ = c;

	return v;
  800cbc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cbf:	c9                   	leave  
  800cc0:	c3                   	ret    

00800cc1 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800cc1:	55                   	push   %ebp
  800cc2:	89 e5                	mov    %esp,%ebp
  800cc4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800cc7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cca:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ccd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800cd3:	eb 16                	jmp    800ceb <memcpy+0x2a>
		*d++ = *s++;
  800cd5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cd8:	8d 50 01             	lea    0x1(%eax),%edx
  800cdb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800cde:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ce1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ce4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ce7:	8a 12                	mov    (%edx),%dl
  800ce9:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800ceb:	8b 45 10             	mov    0x10(%ebp),%eax
  800cee:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cf1:	89 55 10             	mov    %edx,0x10(%ebp)
  800cf4:	85 c0                	test   %eax,%eax
  800cf6:	75 dd                	jne    800cd5 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800cf8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cfb:	c9                   	leave  
  800cfc:	c3                   	ret    

00800cfd <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800cfd:	55                   	push   %ebp
  800cfe:	89 e5                	mov    %esp,%ebp
  800d00:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d03:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d06:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d09:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800d0f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d12:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d15:	73 50                	jae    800d67 <memmove+0x6a>
  800d17:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d1a:	8b 45 10             	mov    0x10(%ebp),%eax
  800d1d:	01 d0                	add    %edx,%eax
  800d1f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d22:	76 43                	jbe    800d67 <memmove+0x6a>
		s += n;
  800d24:	8b 45 10             	mov    0x10(%ebp),%eax
  800d27:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800d2a:	8b 45 10             	mov    0x10(%ebp),%eax
  800d2d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800d30:	eb 10                	jmp    800d42 <memmove+0x45>
			*--d = *--s;
  800d32:	ff 4d f8             	decl   -0x8(%ebp)
  800d35:	ff 4d fc             	decl   -0x4(%ebp)
  800d38:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d3b:	8a 10                	mov    (%eax),%dl
  800d3d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d40:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800d42:	8b 45 10             	mov    0x10(%ebp),%eax
  800d45:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d48:	89 55 10             	mov    %edx,0x10(%ebp)
  800d4b:	85 c0                	test   %eax,%eax
  800d4d:	75 e3                	jne    800d32 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800d4f:	eb 23                	jmp    800d74 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800d51:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d54:	8d 50 01             	lea    0x1(%eax),%edx
  800d57:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d5a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d5d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d60:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d63:	8a 12                	mov    (%edx),%dl
  800d65:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800d67:	8b 45 10             	mov    0x10(%ebp),%eax
  800d6a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d6d:	89 55 10             	mov    %edx,0x10(%ebp)
  800d70:	85 c0                	test   %eax,%eax
  800d72:	75 dd                	jne    800d51 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800d74:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d77:	c9                   	leave  
  800d78:	c3                   	ret    

00800d79 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800d79:	55                   	push   %ebp
  800d7a:	89 e5                	mov    %esp,%ebp
  800d7c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d82:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800d85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d88:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800d8b:	eb 2a                	jmp    800db7 <memcmp+0x3e>
		if (*s1 != *s2)
  800d8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d90:	8a 10                	mov    (%eax),%dl
  800d92:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d95:	8a 00                	mov    (%eax),%al
  800d97:	38 c2                	cmp    %al,%dl
  800d99:	74 16                	je     800db1 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800d9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d9e:	8a 00                	mov    (%eax),%al
  800da0:	0f b6 d0             	movzbl %al,%edx
  800da3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800da6:	8a 00                	mov    (%eax),%al
  800da8:	0f b6 c0             	movzbl %al,%eax
  800dab:	29 c2                	sub    %eax,%edx
  800dad:	89 d0                	mov    %edx,%eax
  800daf:	eb 18                	jmp    800dc9 <memcmp+0x50>
		s1++, s2++;
  800db1:	ff 45 fc             	incl   -0x4(%ebp)
  800db4:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800db7:	8b 45 10             	mov    0x10(%ebp),%eax
  800dba:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dbd:	89 55 10             	mov    %edx,0x10(%ebp)
  800dc0:	85 c0                	test   %eax,%eax
  800dc2:	75 c9                	jne    800d8d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800dc4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800dc9:	c9                   	leave  
  800dca:	c3                   	ret    

00800dcb <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800dcb:	55                   	push   %ebp
  800dcc:	89 e5                	mov    %esp,%ebp
  800dce:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800dd1:	8b 55 08             	mov    0x8(%ebp),%edx
  800dd4:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd7:	01 d0                	add    %edx,%eax
  800dd9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ddc:	eb 15                	jmp    800df3 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800dde:	8b 45 08             	mov    0x8(%ebp),%eax
  800de1:	8a 00                	mov    (%eax),%al
  800de3:	0f b6 d0             	movzbl %al,%edx
  800de6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de9:	0f b6 c0             	movzbl %al,%eax
  800dec:	39 c2                	cmp    %eax,%edx
  800dee:	74 0d                	je     800dfd <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800df0:	ff 45 08             	incl   0x8(%ebp)
  800df3:	8b 45 08             	mov    0x8(%ebp),%eax
  800df6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800df9:	72 e3                	jb     800dde <memfind+0x13>
  800dfb:	eb 01                	jmp    800dfe <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800dfd:	90                   	nop
	return (void *) s;
  800dfe:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e01:	c9                   	leave  
  800e02:	c3                   	ret    

00800e03 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e03:	55                   	push   %ebp
  800e04:	89 e5                	mov    %esp,%ebp
  800e06:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e09:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800e10:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e17:	eb 03                	jmp    800e1c <strtol+0x19>
		s++;
  800e19:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1f:	8a 00                	mov    (%eax),%al
  800e21:	3c 20                	cmp    $0x20,%al
  800e23:	74 f4                	je     800e19 <strtol+0x16>
  800e25:	8b 45 08             	mov    0x8(%ebp),%eax
  800e28:	8a 00                	mov    (%eax),%al
  800e2a:	3c 09                	cmp    $0x9,%al
  800e2c:	74 eb                	je     800e19 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800e2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e31:	8a 00                	mov    (%eax),%al
  800e33:	3c 2b                	cmp    $0x2b,%al
  800e35:	75 05                	jne    800e3c <strtol+0x39>
		s++;
  800e37:	ff 45 08             	incl   0x8(%ebp)
  800e3a:	eb 13                	jmp    800e4f <strtol+0x4c>
	else if (*s == '-')
  800e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3f:	8a 00                	mov    (%eax),%al
  800e41:	3c 2d                	cmp    $0x2d,%al
  800e43:	75 0a                	jne    800e4f <strtol+0x4c>
		s++, neg = 1;
  800e45:	ff 45 08             	incl   0x8(%ebp)
  800e48:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800e4f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e53:	74 06                	je     800e5b <strtol+0x58>
  800e55:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800e59:	75 20                	jne    800e7b <strtol+0x78>
  800e5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5e:	8a 00                	mov    (%eax),%al
  800e60:	3c 30                	cmp    $0x30,%al
  800e62:	75 17                	jne    800e7b <strtol+0x78>
  800e64:	8b 45 08             	mov    0x8(%ebp),%eax
  800e67:	40                   	inc    %eax
  800e68:	8a 00                	mov    (%eax),%al
  800e6a:	3c 78                	cmp    $0x78,%al
  800e6c:	75 0d                	jne    800e7b <strtol+0x78>
		s += 2, base = 16;
  800e6e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800e72:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800e79:	eb 28                	jmp    800ea3 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800e7b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e7f:	75 15                	jne    800e96 <strtol+0x93>
  800e81:	8b 45 08             	mov    0x8(%ebp),%eax
  800e84:	8a 00                	mov    (%eax),%al
  800e86:	3c 30                	cmp    $0x30,%al
  800e88:	75 0c                	jne    800e96 <strtol+0x93>
		s++, base = 8;
  800e8a:	ff 45 08             	incl   0x8(%ebp)
  800e8d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800e94:	eb 0d                	jmp    800ea3 <strtol+0xa0>
	else if (base == 0)
  800e96:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e9a:	75 07                	jne    800ea3 <strtol+0xa0>
		base = 10;
  800e9c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800ea3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea6:	8a 00                	mov    (%eax),%al
  800ea8:	3c 2f                	cmp    $0x2f,%al
  800eaa:	7e 19                	jle    800ec5 <strtol+0xc2>
  800eac:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaf:	8a 00                	mov    (%eax),%al
  800eb1:	3c 39                	cmp    $0x39,%al
  800eb3:	7f 10                	jg     800ec5 <strtol+0xc2>
			dig = *s - '0';
  800eb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb8:	8a 00                	mov    (%eax),%al
  800eba:	0f be c0             	movsbl %al,%eax
  800ebd:	83 e8 30             	sub    $0x30,%eax
  800ec0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ec3:	eb 42                	jmp    800f07 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	8a 00                	mov    (%eax),%al
  800eca:	3c 60                	cmp    $0x60,%al
  800ecc:	7e 19                	jle    800ee7 <strtol+0xe4>
  800ece:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed1:	8a 00                	mov    (%eax),%al
  800ed3:	3c 7a                	cmp    $0x7a,%al
  800ed5:	7f 10                	jg     800ee7 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800ed7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eda:	8a 00                	mov    (%eax),%al
  800edc:	0f be c0             	movsbl %al,%eax
  800edf:	83 e8 57             	sub    $0x57,%eax
  800ee2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ee5:	eb 20                	jmp    800f07 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800ee7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eea:	8a 00                	mov    (%eax),%al
  800eec:	3c 40                	cmp    $0x40,%al
  800eee:	7e 39                	jle    800f29 <strtol+0x126>
  800ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef3:	8a 00                	mov    (%eax),%al
  800ef5:	3c 5a                	cmp    $0x5a,%al
  800ef7:	7f 30                	jg     800f29 <strtol+0x126>
			dig = *s - 'A' + 10;
  800ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  800efc:	8a 00                	mov    (%eax),%al
  800efe:	0f be c0             	movsbl %al,%eax
  800f01:	83 e8 37             	sub    $0x37,%eax
  800f04:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f07:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f0a:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f0d:	7d 19                	jge    800f28 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800f0f:	ff 45 08             	incl   0x8(%ebp)
  800f12:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f15:	0f af 45 10          	imul   0x10(%ebp),%eax
  800f19:	89 c2                	mov    %eax,%edx
  800f1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f1e:	01 d0                	add    %edx,%eax
  800f20:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800f23:	e9 7b ff ff ff       	jmp    800ea3 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800f28:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800f29:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f2d:	74 08                	je     800f37 <strtol+0x134>
		*endptr = (char *) s;
  800f2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f32:	8b 55 08             	mov    0x8(%ebp),%edx
  800f35:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800f37:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f3b:	74 07                	je     800f44 <strtol+0x141>
  800f3d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f40:	f7 d8                	neg    %eax
  800f42:	eb 03                	jmp    800f47 <strtol+0x144>
  800f44:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f47:	c9                   	leave  
  800f48:	c3                   	ret    

00800f49 <ltostr>:

void
ltostr(long value, char *str)
{
  800f49:	55                   	push   %ebp
  800f4a:	89 e5                	mov    %esp,%ebp
  800f4c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800f4f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800f56:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800f5d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f61:	79 13                	jns    800f76 <ltostr+0x2d>
	{
		neg = 1;
  800f63:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800f6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800f70:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800f73:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800f76:	8b 45 08             	mov    0x8(%ebp),%eax
  800f79:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800f7e:	99                   	cltd   
  800f7f:	f7 f9                	idiv   %ecx
  800f81:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800f84:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f87:	8d 50 01             	lea    0x1(%eax),%edx
  800f8a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f8d:	89 c2                	mov    %eax,%edx
  800f8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f92:	01 d0                	add    %edx,%eax
  800f94:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800f97:	83 c2 30             	add    $0x30,%edx
  800f9a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800f9c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800f9f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800fa4:	f7 e9                	imul   %ecx
  800fa6:	c1 fa 02             	sar    $0x2,%edx
  800fa9:	89 c8                	mov    %ecx,%eax
  800fab:	c1 f8 1f             	sar    $0x1f,%eax
  800fae:	29 c2                	sub    %eax,%edx
  800fb0:	89 d0                	mov    %edx,%eax
  800fb2:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800fb5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800fb8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800fbd:	f7 e9                	imul   %ecx
  800fbf:	c1 fa 02             	sar    $0x2,%edx
  800fc2:	89 c8                	mov    %ecx,%eax
  800fc4:	c1 f8 1f             	sar    $0x1f,%eax
  800fc7:	29 c2                	sub    %eax,%edx
  800fc9:	89 d0                	mov    %edx,%eax
  800fcb:	c1 e0 02             	shl    $0x2,%eax
  800fce:	01 d0                	add    %edx,%eax
  800fd0:	01 c0                	add    %eax,%eax
  800fd2:	29 c1                	sub    %eax,%ecx
  800fd4:	89 ca                	mov    %ecx,%edx
  800fd6:	85 d2                	test   %edx,%edx
  800fd8:	75 9c                	jne    800f76 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800fda:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800fe1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe4:	48                   	dec    %eax
  800fe5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800fe8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fec:	74 3d                	je     80102b <ltostr+0xe2>
		start = 1 ;
  800fee:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800ff5:	eb 34                	jmp    80102b <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800ff7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ffa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffd:	01 d0                	add    %edx,%eax
  800fff:	8a 00                	mov    (%eax),%al
  801001:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801004:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801007:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100a:	01 c2                	add    %eax,%edx
  80100c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80100f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801012:	01 c8                	add    %ecx,%eax
  801014:	8a 00                	mov    (%eax),%al
  801016:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801018:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80101b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101e:	01 c2                	add    %eax,%edx
  801020:	8a 45 eb             	mov    -0x15(%ebp),%al
  801023:	88 02                	mov    %al,(%edx)
		start++ ;
  801025:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801028:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80102b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80102e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801031:	7c c4                	jl     800ff7 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801033:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801036:	8b 45 0c             	mov    0xc(%ebp),%eax
  801039:	01 d0                	add    %edx,%eax
  80103b:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80103e:	90                   	nop
  80103f:	c9                   	leave  
  801040:	c3                   	ret    

00801041 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801041:	55                   	push   %ebp
  801042:	89 e5                	mov    %esp,%ebp
  801044:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801047:	ff 75 08             	pushl  0x8(%ebp)
  80104a:	e8 54 fa ff ff       	call   800aa3 <strlen>
  80104f:	83 c4 04             	add    $0x4,%esp
  801052:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801055:	ff 75 0c             	pushl  0xc(%ebp)
  801058:	e8 46 fa ff ff       	call   800aa3 <strlen>
  80105d:	83 c4 04             	add    $0x4,%esp
  801060:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801063:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80106a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801071:	eb 17                	jmp    80108a <strcconcat+0x49>
		final[s] = str1[s] ;
  801073:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801076:	8b 45 10             	mov    0x10(%ebp),%eax
  801079:	01 c2                	add    %eax,%edx
  80107b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80107e:	8b 45 08             	mov    0x8(%ebp),%eax
  801081:	01 c8                	add    %ecx,%eax
  801083:	8a 00                	mov    (%eax),%al
  801085:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801087:	ff 45 fc             	incl   -0x4(%ebp)
  80108a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80108d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801090:	7c e1                	jl     801073 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801092:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801099:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8010a0:	eb 1f                	jmp    8010c1 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8010a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010a5:	8d 50 01             	lea    0x1(%eax),%edx
  8010a8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8010ab:	89 c2                	mov    %eax,%edx
  8010ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b0:	01 c2                	add    %eax,%edx
  8010b2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8010b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b8:	01 c8                	add    %ecx,%eax
  8010ba:	8a 00                	mov    (%eax),%al
  8010bc:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8010be:	ff 45 f8             	incl   -0x8(%ebp)
  8010c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010c7:	7c d9                	jl     8010a2 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8010c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8010cf:	01 d0                	add    %edx,%eax
  8010d1:	c6 00 00             	movb   $0x0,(%eax)
}
  8010d4:	90                   	nop
  8010d5:	c9                   	leave  
  8010d6:	c3                   	ret    

008010d7 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8010d7:	55                   	push   %ebp
  8010d8:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8010da:	8b 45 14             	mov    0x14(%ebp),%eax
  8010dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8010e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8010e6:	8b 00                	mov    (%eax),%eax
  8010e8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f2:	01 d0                	add    %edx,%eax
  8010f4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8010fa:	eb 0c                	jmp    801108 <strsplit+0x31>
			*string++ = 0;
  8010fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ff:	8d 50 01             	lea    0x1(%eax),%edx
  801102:	89 55 08             	mov    %edx,0x8(%ebp)
  801105:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801108:	8b 45 08             	mov    0x8(%ebp),%eax
  80110b:	8a 00                	mov    (%eax),%al
  80110d:	84 c0                	test   %al,%al
  80110f:	74 18                	je     801129 <strsplit+0x52>
  801111:	8b 45 08             	mov    0x8(%ebp),%eax
  801114:	8a 00                	mov    (%eax),%al
  801116:	0f be c0             	movsbl %al,%eax
  801119:	50                   	push   %eax
  80111a:	ff 75 0c             	pushl  0xc(%ebp)
  80111d:	e8 13 fb ff ff       	call   800c35 <strchr>
  801122:	83 c4 08             	add    $0x8,%esp
  801125:	85 c0                	test   %eax,%eax
  801127:	75 d3                	jne    8010fc <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801129:	8b 45 08             	mov    0x8(%ebp),%eax
  80112c:	8a 00                	mov    (%eax),%al
  80112e:	84 c0                	test   %al,%al
  801130:	74 5a                	je     80118c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801132:	8b 45 14             	mov    0x14(%ebp),%eax
  801135:	8b 00                	mov    (%eax),%eax
  801137:	83 f8 0f             	cmp    $0xf,%eax
  80113a:	75 07                	jne    801143 <strsplit+0x6c>
		{
			return 0;
  80113c:	b8 00 00 00 00       	mov    $0x0,%eax
  801141:	eb 66                	jmp    8011a9 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801143:	8b 45 14             	mov    0x14(%ebp),%eax
  801146:	8b 00                	mov    (%eax),%eax
  801148:	8d 48 01             	lea    0x1(%eax),%ecx
  80114b:	8b 55 14             	mov    0x14(%ebp),%edx
  80114e:	89 0a                	mov    %ecx,(%edx)
  801150:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801157:	8b 45 10             	mov    0x10(%ebp),%eax
  80115a:	01 c2                	add    %eax,%edx
  80115c:	8b 45 08             	mov    0x8(%ebp),%eax
  80115f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801161:	eb 03                	jmp    801166 <strsplit+0x8f>
			string++;
  801163:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801166:	8b 45 08             	mov    0x8(%ebp),%eax
  801169:	8a 00                	mov    (%eax),%al
  80116b:	84 c0                	test   %al,%al
  80116d:	74 8b                	je     8010fa <strsplit+0x23>
  80116f:	8b 45 08             	mov    0x8(%ebp),%eax
  801172:	8a 00                	mov    (%eax),%al
  801174:	0f be c0             	movsbl %al,%eax
  801177:	50                   	push   %eax
  801178:	ff 75 0c             	pushl  0xc(%ebp)
  80117b:	e8 b5 fa ff ff       	call   800c35 <strchr>
  801180:	83 c4 08             	add    $0x8,%esp
  801183:	85 c0                	test   %eax,%eax
  801185:	74 dc                	je     801163 <strsplit+0x8c>
			string++;
	}
  801187:	e9 6e ff ff ff       	jmp    8010fa <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80118c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80118d:	8b 45 14             	mov    0x14(%ebp),%eax
  801190:	8b 00                	mov    (%eax),%eax
  801192:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801199:	8b 45 10             	mov    0x10(%ebp),%eax
  80119c:	01 d0                	add    %edx,%eax
  80119e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8011a4:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8011a9:	c9                   	leave  
  8011aa:	c3                   	ret    

008011ab <malloc>:
//==================================================================================//
int FirstTimeFlag = 1;
int allocated[MAXN];

void* malloc(uint32 size)
{
  8011ab:	55                   	push   %ebp
  8011ac:	89 e5                	mov    %esp,%ebp
  8011ae:	83 ec 28             	sub    $0x28,%esp
	//DON'T CHANGE THIS CODE
	if(FirstTimeFlag)
  8011b1:	a1 04 30 80 00       	mov    0x803004,%eax
  8011b6:	85 c0                	test   %eax,%eax
  8011b8:	74 0f                	je     8011c9 <malloc+0x1e>
	{
		initialize_buddy();
  8011ba:	e8 a4 02 00 00       	call   801463 <initialize_buddy>
		FirstTimeFlag = 0;
  8011bf:	c7 05 04 30 80 00 00 	movl   $0x0,0x803004
  8011c6:	00 00 00 
	}
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
  8011c9:	81 7d 08 00 08 00 00 	cmpl   $0x800,0x8(%ebp)
  8011d0:	0f 86 0b 01 00 00    	jbe    8012e1 <malloc+0x136>
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
  8011d6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8011dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e0:	c1 e8 0c             	shr    $0xc,%eax
  8011e3:	89 c2                	mov    %eax,%edx
  8011e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e8:	25 ff 0f 00 00       	and    $0xfff,%eax
  8011ed:	85 c0                	test   %eax,%eax
  8011ef:	74 07                	je     8011f8 <malloc+0x4d>
  8011f1:	b8 01 00 00 00       	mov    $0x1,%eax
  8011f6:	eb 05                	jmp    8011fd <malloc+0x52>
  8011f8:	b8 00 00 00 00       	mov    $0x0,%eax
  8011fd:	01 d0                	add    %edx,%eax
  8011ff:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801202:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
  801209:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
		for(i = 0; i < MAXN; i++) {
  801210:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801217:	eb 5c                	jmp    801275 <malloc+0xca>
			if(allocated[i] != 0) continue;
  801219:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80121c:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801223:	85 c0                	test   %eax,%eax
  801225:	75 4a                	jne    801271 <malloc+0xc6>
			j = 1;
  801227:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
			i++;
  80122e:	ff 45 f4             	incl   -0xc(%ebp)
			while(i < MAXN && allocated[i] == 0 && j < sizeToPage) {
  801231:	eb 06                	jmp    801239 <malloc+0x8e>
				i++;
  801233:	ff 45 f4             	incl   -0xc(%ebp)
				j++;
  801236:	ff 45 ec             	incl   -0x14(%ebp)
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
			if(allocated[i] != 0) continue;
			j = 1;
			i++;
			while(i < MAXN && allocated[i] == 0 && j < sizeToPage) {
  801239:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80123c:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801241:	77 16                	ja     801259 <malloc+0xae>
  801243:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801246:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  80124d:	85 c0                	test   %eax,%eax
  80124f:	75 08                	jne    801259 <malloc+0xae>
  801251:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801254:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801257:	7c da                	jl     801233 <malloc+0x88>
				i++;
				j++;
			}
			if(j == sizeToPage) {
  801259:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80125c:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80125f:	75 0b                	jne    80126c <malloc+0xc1>
				indx = i - j;
  801261:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801264:	2b 45 ec             	sub    -0x14(%ebp),%eax
  801267:	89 45 f0             	mov    %eax,-0x10(%ebp)
				break;
  80126a:	eb 13                	jmp    80127f <malloc+0xd4>
			}
			i--;
  80126c:	ff 4d f4             	decl   -0xc(%ebp)
  80126f:	eb 01                	jmp    801272 <malloc+0xc7>
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
			if(allocated[i] != 0) continue;
  801271:	90                   	nop
	}
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
  801272:	ff 45 f4             	incl   -0xc(%ebp)
  801275:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801278:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  80127d:	76 9a                	jbe    801219 <malloc+0x6e>
				indx = i - j;
				break;
			}
			i--;
		}
		if(indx == -1) {
  80127f:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
  801283:	75 07                	jne    80128c <malloc+0xe1>
			return NULL;
  801285:	b8 00 00 00 00       	mov    $0x0,%eax
  80128a:	eb 5a                	jmp    8012e6 <malloc+0x13b>
		}
		i = indx;
  80128c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80128f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		while(i < j + indx) {
  801292:	eb 13                	jmp    8012a7 <malloc+0xfc>
			allocated[i++] = j;
  801294:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801297:	8d 50 01             	lea    0x1(%eax),%edx
  80129a:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80129d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012a0:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
		}
		if(indx == -1) {
			return NULL;
		}
		i = indx;
		while(i < j + indx) {
  8012a7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8012ad:	01 d0                	add    %edx,%eax
  8012af:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8012b2:	7f e0                	jg     801294 <malloc+0xe9>
			allocated[i++] = j;
		}
		uint32 *address = (uint32 *)(USER_HEAP_START + (indx * PAGE_SIZE));
  8012b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8012b7:	c1 e0 0c             	shl    $0xc,%eax
  8012ba:	05 00 00 00 80       	add    $0x80000000,%eax
  8012bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		sys_allocateMem(USER_HEAP_START + (indx * PAGE_SIZE), size);
  8012c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8012c5:	c1 e0 0c             	shl    $0xc,%eax
  8012c8:	05 00 00 00 80       	add    $0x80000000,%eax
  8012cd:	83 ec 08             	sub    $0x8,%esp
  8012d0:	ff 75 08             	pushl  0x8(%ebp)
  8012d3:	50                   	push   %eax
  8012d4:	e8 84 04 00 00       	call   80175d <sys_allocateMem>
  8012d9:	83 c4 10             	add    $0x10,%esp
		return address;
  8012dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8012df:	eb 05                	jmp    8012e6 <malloc+0x13b>
	//1) FIRST FIT strategy (if size > 2 KB)
	//2) Buddy System (if size <= 2 KB)

	//refer to the project presentation and documentation for details

	return NULL;
  8012e1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012e6:	c9                   	leave  
  8012e7:	c3                   	ret    

008012e8 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8012e8:	55                   	push   %ebp
  8012e9:	89 e5                	mov    %esp,%ebp
  8012eb:	83 ec 18             	sub    $0x18,%esp
	//TODO: [PROJECT 2020 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address, PAGE_SIZE);
  8012ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8012f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8012f7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8012fc:	89 45 08             	mov    %eax,0x8(%ebp)
	int size = 0, indx = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE;
  8012ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801306:	8b 45 08             	mov    0x8(%ebp),%eax
  801309:	05 00 00 00 80       	add    $0x80000000,%eax
  80130e:	c1 e8 0c             	shr    $0xc,%eax
  801311:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int removable_size = allocated[indx];
  801314:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801317:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  80131e:	89 45 e8             	mov    %eax,-0x18(%ebp)
	size = allocated[indx];
  801321:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801324:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  80132b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while(size > 0) {
  80132e:	eb 17                	jmp    801347 <free+0x5f>
		allocated[indx++] = 0;
  801330:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801333:	8d 50 01             	lea    0x1(%eax),%edx
  801336:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801339:	c7 04 85 20 31 80 00 	movl   $0x0,0x803120(,%eax,4)
  801340:	00 00 00 00 
		size--;
  801344:	ff 4d f4             	decl   -0xc(%ebp)
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address, PAGE_SIZE);
	int size = 0, indx = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE;
	int removable_size = allocated[indx];
	size = allocated[indx];
	while(size > 0) {
  801347:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80134b:	7f e3                	jg     801330 <free+0x48>
		allocated[indx++] = 0;
		size--;
	}
	sys_freeMem((uint32)virtual_address, removable_size);
  80134d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801350:	8b 45 08             	mov    0x8(%ebp),%eax
  801353:	83 ec 08             	sub    $0x8,%esp
  801356:	52                   	push   %edx
  801357:	50                   	push   %eax
  801358:	e8 e4 03 00 00       	call   801741 <sys_freeMem>
  80135d:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details

}
  801360:	90                   	nop
  801361:	c9                   	leave  
  801362:	c3                   	ret    

00801363 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801363:	55                   	push   %ebp
  801364:	89 e5                	mov    %esp,%ebp
  801366:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - BONUS2] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801369:	83 ec 04             	sub    $0x4,%esp
  80136c:	68 30 25 80 00       	push   $0x802530
  801371:	6a 7a                	push   $0x7a
  801373:	68 56 25 80 00       	push   $0x802556
  801378:	e8 6a 08 00 00       	call   801be7 <_panic>

0080137d <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80137d:	55                   	push   %ebp
  80137e:	89 e5                	mov    %esp,%ebp
  801380:	83 ec 18             	sub    $0x18,%esp
  801383:	8b 45 10             	mov    0x10(%ebp),%eax
  801386:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801389:	83 ec 04             	sub    $0x4,%esp
  80138c:	68 64 25 80 00       	push   $0x802564
  801391:	68 84 00 00 00       	push   $0x84
  801396:	68 56 25 80 00       	push   $0x802556
  80139b:	e8 47 08 00 00       	call   801be7 <_panic>

008013a0 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8013a0:	55                   	push   %ebp
  8013a1:	89 e5                	mov    %esp,%ebp
  8013a3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013a6:	83 ec 04             	sub    $0x4,%esp
  8013a9:	68 64 25 80 00       	push   $0x802564
  8013ae:	68 8a 00 00 00       	push   $0x8a
  8013b3:	68 56 25 80 00       	push   $0x802556
  8013b8:	e8 2a 08 00 00       	call   801be7 <_panic>

008013bd <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8013bd:	55                   	push   %ebp
  8013be:	89 e5                	mov    %esp,%ebp
  8013c0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013c3:	83 ec 04             	sub    $0x4,%esp
  8013c6:	68 64 25 80 00       	push   $0x802564
  8013cb:	68 90 00 00 00       	push   $0x90
  8013d0:	68 56 25 80 00       	push   $0x802556
  8013d5:	e8 0d 08 00 00       	call   801be7 <_panic>

008013da <expand>:
}

void expand(uint32 newSize)
{
  8013da:	55                   	push   %ebp
  8013db:	89 e5                	mov    %esp,%ebp
  8013dd:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013e0:	83 ec 04             	sub    $0x4,%esp
  8013e3:	68 64 25 80 00       	push   $0x802564
  8013e8:	68 95 00 00 00       	push   $0x95
  8013ed:	68 56 25 80 00       	push   $0x802556
  8013f2:	e8 f0 07 00 00       	call   801be7 <_panic>

008013f7 <shrink>:
}
void shrink(uint32 newSize)
{
  8013f7:	55                   	push   %ebp
  8013f8:	89 e5                	mov    %esp,%ebp
  8013fa:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013fd:	83 ec 04             	sub    $0x4,%esp
  801400:	68 64 25 80 00       	push   $0x802564
  801405:	68 99 00 00 00       	push   $0x99
  80140a:	68 56 25 80 00       	push   $0x802556
  80140f:	e8 d3 07 00 00       	call   801be7 <_panic>

00801414 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801414:	55                   	push   %ebp
  801415:	89 e5                	mov    %esp,%ebp
  801417:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80141a:	83 ec 04             	sub    $0x4,%esp
  80141d:	68 64 25 80 00       	push   $0x802564
  801422:	68 9e 00 00 00       	push   $0x9e
  801427:	68 56 25 80 00       	push   $0x802556
  80142c:	e8 b6 07 00 00       	call   801be7 <_panic>

00801431 <ClearNodeData>:
 * inside the user heap
 */
 
struct BuddyNode FreeNodes[BUDDY_NUM_FREE_NODES];
void ClearNodeData(struct BuddyNode* node)
{
  801431:	55                   	push   %ebp
  801432:	89 e5                	mov    %esp,%ebp
	node->level = 0;
  801434:	8b 45 08             	mov    0x8(%ebp),%eax
  801437:	c6 40 11 00          	movb   $0x0,0x11(%eax)
	node->status = FREE;
  80143b:	8b 45 08             	mov    0x8(%ebp),%eax
  80143e:	c6 40 10 00          	movb   $0x0,0x10(%eax)
	node->va = 0;
  801442:	8b 45 08             	mov    0x8(%ebp),%eax
  801445:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
	node->parent = NULL;
  80144c:	8b 45 08             	mov    0x8(%ebp),%eax
  80144f:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
	node->myBuddy = NULL;
  801456:	8b 45 08             	mov    0x8(%ebp),%eax
  801459:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
}
  801460:	90                   	nop
  801461:	5d                   	pop    %ebp
  801462:	c3                   	ret    

00801463 <initialize_buddy>:

void initialize_buddy()
{
  801463:	55                   	push   %ebp
  801464:	89 e5                	mov    %esp,%ebp
  801466:	83 ec 10             	sub    $0x10,%esp
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  801469:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801470:	e9 b7 00 00 00       	jmp    80152c <initialize_buddy+0xc9>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
  801475:	8b 15 04 31 80 00    	mov    0x803104,%edx
  80147b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80147e:	89 c8                	mov    %ecx,%eax
  801480:	01 c0                	add    %eax,%eax
  801482:	01 c8                	add    %ecx,%eax
  801484:	c1 e0 03             	shl    $0x3,%eax
  801487:	05 20 31 88 00       	add    $0x883120,%eax
  80148c:	89 10                	mov    %edx,(%eax)
  80148e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801491:	89 d0                	mov    %edx,%eax
  801493:	01 c0                	add    %eax,%eax
  801495:	01 d0                	add    %edx,%eax
  801497:	c1 e0 03             	shl    $0x3,%eax
  80149a:	05 20 31 88 00       	add    $0x883120,%eax
  80149f:	8b 00                	mov    (%eax),%eax
  8014a1:	85 c0                	test   %eax,%eax
  8014a3:	74 1c                	je     8014c1 <initialize_buddy+0x5e>
  8014a5:	8b 15 04 31 80 00    	mov    0x803104,%edx
  8014ab:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8014ae:	89 c8                	mov    %ecx,%eax
  8014b0:	01 c0                	add    %eax,%eax
  8014b2:	01 c8                	add    %ecx,%eax
  8014b4:	c1 e0 03             	shl    $0x3,%eax
  8014b7:	05 20 31 88 00       	add    $0x883120,%eax
  8014bc:	89 42 04             	mov    %eax,0x4(%edx)
  8014bf:	eb 16                	jmp    8014d7 <initialize_buddy+0x74>
  8014c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014c4:	89 d0                	mov    %edx,%eax
  8014c6:	01 c0                	add    %eax,%eax
  8014c8:	01 d0                	add    %edx,%eax
  8014ca:	c1 e0 03             	shl    $0x3,%eax
  8014cd:	05 20 31 88 00       	add    $0x883120,%eax
  8014d2:	a3 08 31 80 00       	mov    %eax,0x803108
  8014d7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014da:	89 d0                	mov    %edx,%eax
  8014dc:	01 c0                	add    %eax,%eax
  8014de:	01 d0                	add    %edx,%eax
  8014e0:	c1 e0 03             	shl    $0x3,%eax
  8014e3:	05 20 31 88 00       	add    $0x883120,%eax
  8014e8:	a3 04 31 80 00       	mov    %eax,0x803104
  8014ed:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014f0:	89 d0                	mov    %edx,%eax
  8014f2:	01 c0                	add    %eax,%eax
  8014f4:	01 d0                	add    %edx,%eax
  8014f6:	c1 e0 03             	shl    $0x3,%eax
  8014f9:	05 24 31 88 00       	add    $0x883124,%eax
  8014fe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801504:	a1 10 31 80 00       	mov    0x803110,%eax
  801509:	40                   	inc    %eax
  80150a:	a3 10 31 80 00       	mov    %eax,0x803110
		ClearNodeData(&(FreeNodes[i]));
  80150f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801512:	89 d0                	mov    %edx,%eax
  801514:	01 c0                	add    %eax,%eax
  801516:	01 d0                	add    %edx,%eax
  801518:	c1 e0 03             	shl    $0x3,%eax
  80151b:	05 20 31 88 00       	add    $0x883120,%eax
  801520:	50                   	push   %eax
  801521:	e8 0b ff ff ff       	call   801431 <ClearNodeData>
  801526:	83 c4 04             	add    $0x4,%esp
	node->myBuddy = NULL;
}

void initialize_buddy()
{
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  801529:	ff 45 fc             	incl   -0x4(%ebp)
  80152c:	81 7d fc 3f 9c 00 00 	cmpl   $0x9c3f,-0x4(%ebp)
  801533:	0f 8e 3c ff ff ff    	jle    801475 <initialize_buddy+0x12>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
		ClearNodeData(&(FreeNodes[i]));
	}
}
  801539:	90                   	nop
  80153a:	c9                   	leave  
  80153b:	c3                   	ret    

0080153c <CreateNewBuddySpace>:
/*===============================================================*/

//TODO: [PROJECT 2020 - BONUS4] Expand Buddy Free Node List

void CreateNewBuddySpace()
{
  80153c:	55                   	push   %ebp
  80153d:	89 e5                	mov    %esp,%ebp
  80153f:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Create New Buddy Block]
	// Write your code here, remove the panic and write your code
	panic("CreateNewBuddySpace() is not implemented yet...!!");
  801542:	83 ec 04             	sub    $0x4,%esp
  801545:	68 88 25 80 00       	push   $0x802588
  80154a:	6a 22                	push   $0x22
  80154c:	68 ba 25 80 00       	push   $0x8025ba
  801551:	e8 91 06 00 00       	call   801be7 <_panic>

00801556 <FindAllocationUsingBuddy>:

}

void* FindAllocationUsingBuddy(int size)
{
  801556:	55                   	push   %ebp
  801557:	89 e5                	mov    %esp,%ebp
  801559:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Get Allocation]
	// Write your code here, remove the panic and write your code
	panic("FindAllocationUsingBuddy() is not implemented yet...!!");
  80155c:	83 ec 04             	sub    $0x4,%esp
  80155f:	68 c8 25 80 00       	push   $0x8025c8
  801564:	6a 2a                	push   $0x2a
  801566:	68 ba 25 80 00       	push   $0x8025ba
  80156b:	e8 77 06 00 00       	call   801be7 <_panic>

00801570 <FreeAllocationUsingBuddy>:
}

void FreeAllocationUsingBuddy(uint32 va)
{
  801570:	55                   	push   %ebp
  801571:	89 e5                	mov    %esp,%ebp
  801573:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Free Allocation]
	// Write your code here, remove the panic and write your code
	panic("FreeAllocationUsingBuddy() is not implemented yet...!!");
  801576:	83 ec 04             	sub    $0x4,%esp
  801579:	68 00 26 80 00       	push   $0x802600
  80157e:	6a 31                	push   $0x31
  801580:	68 ba 25 80 00       	push   $0x8025ba
  801585:	e8 5d 06 00 00       	call   801be7 <_panic>

0080158a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80158a:	55                   	push   %ebp
  80158b:	89 e5                	mov    %esp,%ebp
  80158d:	57                   	push   %edi
  80158e:	56                   	push   %esi
  80158f:	53                   	push   %ebx
  801590:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801593:	8b 45 08             	mov    0x8(%ebp),%eax
  801596:	8b 55 0c             	mov    0xc(%ebp),%edx
  801599:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80159c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80159f:	8b 7d 18             	mov    0x18(%ebp),%edi
  8015a2:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8015a5:	cd 30                	int    $0x30
  8015a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8015aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8015ad:	83 c4 10             	add    $0x10,%esp
  8015b0:	5b                   	pop    %ebx
  8015b1:	5e                   	pop    %esi
  8015b2:	5f                   	pop    %edi
  8015b3:	5d                   	pop    %ebp
  8015b4:	c3                   	ret    

008015b5 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8015b5:	55                   	push   %ebp
  8015b6:	89 e5                	mov    %esp,%ebp
  8015b8:	83 ec 04             	sub    $0x4,%esp
  8015bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8015be:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8015c1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	52                   	push   %edx
  8015cd:	ff 75 0c             	pushl  0xc(%ebp)
  8015d0:	50                   	push   %eax
  8015d1:	6a 00                	push   $0x0
  8015d3:	e8 b2 ff ff ff       	call   80158a <syscall>
  8015d8:	83 c4 18             	add    $0x18,%esp
}
  8015db:	90                   	nop
  8015dc:	c9                   	leave  
  8015dd:	c3                   	ret    

008015de <sys_cgetc>:

int
sys_cgetc(void)
{
  8015de:	55                   	push   %ebp
  8015df:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 00                	push   $0x0
  8015eb:	6a 01                	push   $0x1
  8015ed:	e8 98 ff ff ff       	call   80158a <syscall>
  8015f2:	83 c4 18             	add    $0x18,%esp
}
  8015f5:	c9                   	leave  
  8015f6:	c3                   	ret    

008015f7 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8015f7:	55                   	push   %ebp
  8015f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8015fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	6a 00                	push   $0x0
  801603:	6a 00                	push   $0x0
  801605:	50                   	push   %eax
  801606:	6a 05                	push   $0x5
  801608:	e8 7d ff ff ff       	call   80158a <syscall>
  80160d:	83 c4 18             	add    $0x18,%esp
}
  801610:	c9                   	leave  
  801611:	c3                   	ret    

00801612 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801612:	55                   	push   %ebp
  801613:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	6a 00                	push   $0x0
  80161f:	6a 02                	push   $0x2
  801621:	e8 64 ff ff ff       	call   80158a <syscall>
  801626:	83 c4 18             	add    $0x18,%esp
}
  801629:	c9                   	leave  
  80162a:	c3                   	ret    

0080162b <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80162b:	55                   	push   %ebp
  80162c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80162e:	6a 00                	push   $0x0
  801630:	6a 00                	push   $0x0
  801632:	6a 00                	push   $0x0
  801634:	6a 00                	push   $0x0
  801636:	6a 00                	push   $0x0
  801638:	6a 03                	push   $0x3
  80163a:	e8 4b ff ff ff       	call   80158a <syscall>
  80163f:	83 c4 18             	add    $0x18,%esp
}
  801642:	c9                   	leave  
  801643:	c3                   	ret    

00801644 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801644:	55                   	push   %ebp
  801645:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801647:	6a 00                	push   $0x0
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 04                	push   $0x4
  801653:	e8 32 ff ff ff       	call   80158a <syscall>
  801658:	83 c4 18             	add    $0x18,%esp
}
  80165b:	c9                   	leave  
  80165c:	c3                   	ret    

0080165d <sys_env_exit>:


void sys_env_exit(void)
{
  80165d:	55                   	push   %ebp
  80165e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	6a 00                	push   $0x0
  80166a:	6a 06                	push   $0x6
  80166c:	e8 19 ff ff ff       	call   80158a <syscall>
  801671:	83 c4 18             	add    $0x18,%esp
}
  801674:	90                   	nop
  801675:	c9                   	leave  
  801676:	c3                   	ret    

00801677 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801677:	55                   	push   %ebp
  801678:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80167a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80167d:	8b 45 08             	mov    0x8(%ebp),%eax
  801680:	6a 00                	push   $0x0
  801682:	6a 00                	push   $0x0
  801684:	6a 00                	push   $0x0
  801686:	52                   	push   %edx
  801687:	50                   	push   %eax
  801688:	6a 07                	push   $0x7
  80168a:	e8 fb fe ff ff       	call   80158a <syscall>
  80168f:	83 c4 18             	add    $0x18,%esp
}
  801692:	c9                   	leave  
  801693:	c3                   	ret    

00801694 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801694:	55                   	push   %ebp
  801695:	89 e5                	mov    %esp,%ebp
  801697:	56                   	push   %esi
  801698:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801699:	8b 75 18             	mov    0x18(%ebp),%esi
  80169c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80169f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a8:	56                   	push   %esi
  8016a9:	53                   	push   %ebx
  8016aa:	51                   	push   %ecx
  8016ab:	52                   	push   %edx
  8016ac:	50                   	push   %eax
  8016ad:	6a 08                	push   $0x8
  8016af:	e8 d6 fe ff ff       	call   80158a <syscall>
  8016b4:	83 c4 18             	add    $0x18,%esp
}
  8016b7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8016ba:	5b                   	pop    %ebx
  8016bb:	5e                   	pop    %esi
  8016bc:	5d                   	pop    %ebp
  8016bd:	c3                   	ret    

008016be <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8016be:	55                   	push   %ebp
  8016bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8016c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 00                	push   $0x0
  8016cd:	52                   	push   %edx
  8016ce:	50                   	push   %eax
  8016cf:	6a 09                	push   $0x9
  8016d1:	e8 b4 fe ff ff       	call   80158a <syscall>
  8016d6:	83 c4 18             	add    $0x18,%esp
}
  8016d9:	c9                   	leave  
  8016da:	c3                   	ret    

008016db <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8016db:	55                   	push   %ebp
  8016dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	ff 75 0c             	pushl  0xc(%ebp)
  8016e7:	ff 75 08             	pushl  0x8(%ebp)
  8016ea:	6a 0a                	push   $0xa
  8016ec:	e8 99 fe ff ff       	call   80158a <syscall>
  8016f1:	83 c4 18             	add    $0x18,%esp
}
  8016f4:	c9                   	leave  
  8016f5:	c3                   	ret    

008016f6 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8016f6:	55                   	push   %ebp
  8016f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 00                	push   $0x0
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	6a 0b                	push   $0xb
  801705:	e8 80 fe ff ff       	call   80158a <syscall>
  80170a:	83 c4 18             	add    $0x18,%esp
}
  80170d:	c9                   	leave  
  80170e:	c3                   	ret    

0080170f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80170f:	55                   	push   %ebp
  801710:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801712:	6a 00                	push   $0x0
  801714:	6a 00                	push   $0x0
  801716:	6a 00                	push   $0x0
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	6a 0c                	push   $0xc
  80171e:	e8 67 fe ff ff       	call   80158a <syscall>
  801723:	83 c4 18             	add    $0x18,%esp
}
  801726:	c9                   	leave  
  801727:	c3                   	ret    

00801728 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801728:	55                   	push   %ebp
  801729:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	6a 00                	push   $0x0
  801731:	6a 00                	push   $0x0
  801733:	6a 00                	push   $0x0
  801735:	6a 0d                	push   $0xd
  801737:	e8 4e fe ff ff       	call   80158a <syscall>
  80173c:	83 c4 18             	add    $0x18,%esp
}
  80173f:	c9                   	leave  
  801740:	c3                   	ret    

00801741 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801741:	55                   	push   %ebp
  801742:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	ff 75 0c             	pushl  0xc(%ebp)
  80174d:	ff 75 08             	pushl  0x8(%ebp)
  801750:	6a 11                	push   $0x11
  801752:	e8 33 fe ff ff       	call   80158a <syscall>
  801757:	83 c4 18             	add    $0x18,%esp
	return;
  80175a:	90                   	nop
}
  80175b:	c9                   	leave  
  80175c:	c3                   	ret    

0080175d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80175d:	55                   	push   %ebp
  80175e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	6a 00                	push   $0x0
  801766:	ff 75 0c             	pushl  0xc(%ebp)
  801769:	ff 75 08             	pushl  0x8(%ebp)
  80176c:	6a 12                	push   $0x12
  80176e:	e8 17 fe ff ff       	call   80158a <syscall>
  801773:	83 c4 18             	add    $0x18,%esp
	return ;
  801776:	90                   	nop
}
  801777:	c9                   	leave  
  801778:	c3                   	ret    

00801779 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801779:	55                   	push   %ebp
  80177a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	6a 00                	push   $0x0
  801786:	6a 0e                	push   $0xe
  801788:	e8 fd fd ff ff       	call   80158a <syscall>
  80178d:	83 c4 18             	add    $0x18,%esp
}
  801790:	c9                   	leave  
  801791:	c3                   	ret    

00801792 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801792:	55                   	push   %ebp
  801793:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	ff 75 08             	pushl  0x8(%ebp)
  8017a0:	6a 0f                	push   $0xf
  8017a2:	e8 e3 fd ff ff       	call   80158a <syscall>
  8017a7:	83 c4 18             	add    $0x18,%esp
}
  8017aa:	c9                   	leave  
  8017ab:	c3                   	ret    

008017ac <sys_scarce_memory>:

void sys_scarce_memory()
{
  8017ac:	55                   	push   %ebp
  8017ad:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 00                	push   $0x0
  8017b5:	6a 00                	push   $0x0
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 10                	push   $0x10
  8017bb:	e8 ca fd ff ff       	call   80158a <syscall>
  8017c0:	83 c4 18             	add    $0x18,%esp
}
  8017c3:	90                   	nop
  8017c4:	c9                   	leave  
  8017c5:	c3                   	ret    

008017c6 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8017c6:	55                   	push   %ebp
  8017c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 14                	push   $0x14
  8017d5:	e8 b0 fd ff ff       	call   80158a <syscall>
  8017da:	83 c4 18             	add    $0x18,%esp
}
  8017dd:	90                   	nop
  8017de:	c9                   	leave  
  8017df:	c3                   	ret    

008017e0 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8017e0:	55                   	push   %ebp
  8017e1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8017e3:	6a 00                	push   $0x0
  8017e5:	6a 00                	push   $0x0
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 00                	push   $0x0
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 15                	push   $0x15
  8017ef:	e8 96 fd ff ff       	call   80158a <syscall>
  8017f4:	83 c4 18             	add    $0x18,%esp
}
  8017f7:	90                   	nop
  8017f8:	c9                   	leave  
  8017f9:	c3                   	ret    

008017fa <sys_cputc>:


void
sys_cputc(const char c)
{
  8017fa:	55                   	push   %ebp
  8017fb:	89 e5                	mov    %esp,%ebp
  8017fd:	83 ec 04             	sub    $0x4,%esp
  801800:	8b 45 08             	mov    0x8(%ebp),%eax
  801803:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801806:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80180a:	6a 00                	push   $0x0
  80180c:	6a 00                	push   $0x0
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	50                   	push   %eax
  801813:	6a 16                	push   $0x16
  801815:	e8 70 fd ff ff       	call   80158a <syscall>
  80181a:	83 c4 18             	add    $0x18,%esp
}
  80181d:	90                   	nop
  80181e:	c9                   	leave  
  80181f:	c3                   	ret    

00801820 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801820:	55                   	push   %ebp
  801821:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801823:	6a 00                	push   $0x0
  801825:	6a 00                	push   $0x0
  801827:	6a 00                	push   $0x0
  801829:	6a 00                	push   $0x0
  80182b:	6a 00                	push   $0x0
  80182d:	6a 17                	push   $0x17
  80182f:	e8 56 fd ff ff       	call   80158a <syscall>
  801834:	83 c4 18             	add    $0x18,%esp
}
  801837:	90                   	nop
  801838:	c9                   	leave  
  801839:	c3                   	ret    

0080183a <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80183a:	55                   	push   %ebp
  80183b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80183d:	8b 45 08             	mov    0x8(%ebp),%eax
  801840:	6a 00                	push   $0x0
  801842:	6a 00                	push   $0x0
  801844:	6a 00                	push   $0x0
  801846:	ff 75 0c             	pushl  0xc(%ebp)
  801849:	50                   	push   %eax
  80184a:	6a 18                	push   $0x18
  80184c:	e8 39 fd ff ff       	call   80158a <syscall>
  801851:	83 c4 18             	add    $0x18,%esp
}
  801854:	c9                   	leave  
  801855:	c3                   	ret    

00801856 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801856:	55                   	push   %ebp
  801857:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801859:	8b 55 0c             	mov    0xc(%ebp),%edx
  80185c:	8b 45 08             	mov    0x8(%ebp),%eax
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	52                   	push   %edx
  801866:	50                   	push   %eax
  801867:	6a 1b                	push   $0x1b
  801869:	e8 1c fd ff ff       	call   80158a <syscall>
  80186e:	83 c4 18             	add    $0x18,%esp
}
  801871:	c9                   	leave  
  801872:	c3                   	ret    

00801873 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801873:	55                   	push   %ebp
  801874:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801876:	8b 55 0c             	mov    0xc(%ebp),%edx
  801879:	8b 45 08             	mov    0x8(%ebp),%eax
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	52                   	push   %edx
  801883:	50                   	push   %eax
  801884:	6a 19                	push   $0x19
  801886:	e8 ff fc ff ff       	call   80158a <syscall>
  80188b:	83 c4 18             	add    $0x18,%esp
}
  80188e:	90                   	nop
  80188f:	c9                   	leave  
  801890:	c3                   	ret    

00801891 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801891:	55                   	push   %ebp
  801892:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801894:	8b 55 0c             	mov    0xc(%ebp),%edx
  801897:	8b 45 08             	mov    0x8(%ebp),%eax
  80189a:	6a 00                	push   $0x0
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	52                   	push   %edx
  8018a1:	50                   	push   %eax
  8018a2:	6a 1a                	push   $0x1a
  8018a4:	e8 e1 fc ff ff       	call   80158a <syscall>
  8018a9:	83 c4 18             	add    $0x18,%esp
}
  8018ac:	90                   	nop
  8018ad:	c9                   	leave  
  8018ae:	c3                   	ret    

008018af <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8018af:	55                   	push   %ebp
  8018b0:	89 e5                	mov    %esp,%ebp
  8018b2:	83 ec 04             	sub    $0x4,%esp
  8018b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b8:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8018bb:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8018be:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c5:	6a 00                	push   $0x0
  8018c7:	51                   	push   %ecx
  8018c8:	52                   	push   %edx
  8018c9:	ff 75 0c             	pushl  0xc(%ebp)
  8018cc:	50                   	push   %eax
  8018cd:	6a 1c                	push   $0x1c
  8018cf:	e8 b6 fc ff ff       	call   80158a <syscall>
  8018d4:	83 c4 18             	add    $0x18,%esp
}
  8018d7:	c9                   	leave  
  8018d8:	c3                   	ret    

008018d9 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8018d9:	55                   	push   %ebp
  8018da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8018dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018df:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 00                	push   $0x0
  8018e6:	6a 00                	push   $0x0
  8018e8:	52                   	push   %edx
  8018e9:	50                   	push   %eax
  8018ea:	6a 1d                	push   $0x1d
  8018ec:	e8 99 fc ff ff       	call   80158a <syscall>
  8018f1:	83 c4 18             	add    $0x18,%esp
}
  8018f4:	c9                   	leave  
  8018f5:	c3                   	ret    

008018f6 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8018f6:	55                   	push   %ebp
  8018f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8018f9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	51                   	push   %ecx
  801907:	52                   	push   %edx
  801908:	50                   	push   %eax
  801909:	6a 1e                	push   $0x1e
  80190b:	e8 7a fc ff ff       	call   80158a <syscall>
  801910:	83 c4 18             	add    $0x18,%esp
}
  801913:	c9                   	leave  
  801914:	c3                   	ret    

00801915 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801915:	55                   	push   %ebp
  801916:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801918:	8b 55 0c             	mov    0xc(%ebp),%edx
  80191b:	8b 45 08             	mov    0x8(%ebp),%eax
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	52                   	push   %edx
  801925:	50                   	push   %eax
  801926:	6a 1f                	push   $0x1f
  801928:	e8 5d fc ff ff       	call   80158a <syscall>
  80192d:	83 c4 18             	add    $0x18,%esp
}
  801930:	c9                   	leave  
  801931:	c3                   	ret    

00801932 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801932:	55                   	push   %ebp
  801933:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	6a 00                	push   $0x0
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	6a 20                	push   $0x20
  801941:	e8 44 fc ff ff       	call   80158a <syscall>
  801946:	83 c4 18             	add    $0x18,%esp
}
  801949:	c9                   	leave  
  80194a:	c3                   	ret    

0080194b <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80194b:	55                   	push   %ebp
  80194c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80194e:	8b 45 08             	mov    0x8(%ebp),%eax
  801951:	6a 00                	push   $0x0
  801953:	ff 75 14             	pushl  0x14(%ebp)
  801956:	ff 75 10             	pushl  0x10(%ebp)
  801959:	ff 75 0c             	pushl  0xc(%ebp)
  80195c:	50                   	push   %eax
  80195d:	6a 21                	push   $0x21
  80195f:	e8 26 fc ff ff       	call   80158a <syscall>
  801964:	83 c4 18             	add    $0x18,%esp
}
  801967:	c9                   	leave  
  801968:	c3                   	ret    

00801969 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801969:	55                   	push   %ebp
  80196a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80196c:	8b 45 08             	mov    0x8(%ebp),%eax
  80196f:	6a 00                	push   $0x0
  801971:	6a 00                	push   $0x0
  801973:	6a 00                	push   $0x0
  801975:	6a 00                	push   $0x0
  801977:	50                   	push   %eax
  801978:	6a 22                	push   $0x22
  80197a:	e8 0b fc ff ff       	call   80158a <syscall>
  80197f:	83 c4 18             	add    $0x18,%esp
}
  801982:	90                   	nop
  801983:	c9                   	leave  
  801984:	c3                   	ret    

00801985 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801985:	55                   	push   %ebp
  801986:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801988:	8b 45 08             	mov    0x8(%ebp),%eax
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	6a 00                	push   $0x0
  801993:	50                   	push   %eax
  801994:	6a 23                	push   $0x23
  801996:	e8 ef fb ff ff       	call   80158a <syscall>
  80199b:	83 c4 18             	add    $0x18,%esp
}
  80199e:	90                   	nop
  80199f:	c9                   	leave  
  8019a0:	c3                   	ret    

008019a1 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8019a1:	55                   	push   %ebp
  8019a2:	89 e5                	mov    %esp,%ebp
  8019a4:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8019a7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8019aa:	8d 50 04             	lea    0x4(%eax),%edx
  8019ad:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 00                	push   $0x0
  8019b6:	52                   	push   %edx
  8019b7:	50                   	push   %eax
  8019b8:	6a 24                	push   $0x24
  8019ba:	e8 cb fb ff ff       	call   80158a <syscall>
  8019bf:	83 c4 18             	add    $0x18,%esp
	return result;
  8019c2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019c8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019cb:	89 01                	mov    %eax,(%ecx)
  8019cd:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8019d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d3:	c9                   	leave  
  8019d4:	c2 04 00             	ret    $0x4

008019d7 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8019d7:	55                   	push   %ebp
  8019d8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8019da:	6a 00                	push   $0x0
  8019dc:	6a 00                	push   $0x0
  8019de:	ff 75 10             	pushl  0x10(%ebp)
  8019e1:	ff 75 0c             	pushl  0xc(%ebp)
  8019e4:	ff 75 08             	pushl  0x8(%ebp)
  8019e7:	6a 13                	push   $0x13
  8019e9:	e8 9c fb ff ff       	call   80158a <syscall>
  8019ee:	83 c4 18             	add    $0x18,%esp
	return ;
  8019f1:	90                   	nop
}
  8019f2:	c9                   	leave  
  8019f3:	c3                   	ret    

008019f4 <sys_rcr2>:
uint32 sys_rcr2()
{
  8019f4:	55                   	push   %ebp
  8019f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 00                	push   $0x0
  8019fb:	6a 00                	push   $0x0
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 00                	push   $0x0
  801a01:	6a 25                	push   $0x25
  801a03:	e8 82 fb ff ff       	call   80158a <syscall>
  801a08:	83 c4 18             	add    $0x18,%esp
}
  801a0b:	c9                   	leave  
  801a0c:	c3                   	ret    

00801a0d <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801a0d:	55                   	push   %ebp
  801a0e:	89 e5                	mov    %esp,%ebp
  801a10:	83 ec 04             	sub    $0x4,%esp
  801a13:	8b 45 08             	mov    0x8(%ebp),%eax
  801a16:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a19:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a1d:	6a 00                	push   $0x0
  801a1f:	6a 00                	push   $0x0
  801a21:	6a 00                	push   $0x0
  801a23:	6a 00                	push   $0x0
  801a25:	50                   	push   %eax
  801a26:	6a 26                	push   $0x26
  801a28:	e8 5d fb ff ff       	call   80158a <syscall>
  801a2d:	83 c4 18             	add    $0x18,%esp
	return ;
  801a30:	90                   	nop
}
  801a31:	c9                   	leave  
  801a32:	c3                   	ret    

00801a33 <rsttst>:
void rsttst()
{
  801a33:	55                   	push   %ebp
  801a34:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a36:	6a 00                	push   $0x0
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 00                	push   $0x0
  801a3c:	6a 00                	push   $0x0
  801a3e:	6a 00                	push   $0x0
  801a40:	6a 28                	push   $0x28
  801a42:	e8 43 fb ff ff       	call   80158a <syscall>
  801a47:	83 c4 18             	add    $0x18,%esp
	return ;
  801a4a:	90                   	nop
}
  801a4b:	c9                   	leave  
  801a4c:	c3                   	ret    

00801a4d <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a4d:	55                   	push   %ebp
  801a4e:	89 e5                	mov    %esp,%ebp
  801a50:	83 ec 04             	sub    $0x4,%esp
  801a53:	8b 45 14             	mov    0x14(%ebp),%eax
  801a56:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a59:	8b 55 18             	mov    0x18(%ebp),%edx
  801a5c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a60:	52                   	push   %edx
  801a61:	50                   	push   %eax
  801a62:	ff 75 10             	pushl  0x10(%ebp)
  801a65:	ff 75 0c             	pushl  0xc(%ebp)
  801a68:	ff 75 08             	pushl  0x8(%ebp)
  801a6b:	6a 27                	push   $0x27
  801a6d:	e8 18 fb ff ff       	call   80158a <syscall>
  801a72:	83 c4 18             	add    $0x18,%esp
	return ;
  801a75:	90                   	nop
}
  801a76:	c9                   	leave  
  801a77:	c3                   	ret    

00801a78 <chktst>:
void chktst(uint32 n)
{
  801a78:	55                   	push   %ebp
  801a79:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	6a 00                	push   $0x0
  801a83:	ff 75 08             	pushl  0x8(%ebp)
  801a86:	6a 29                	push   $0x29
  801a88:	e8 fd fa ff ff       	call   80158a <syscall>
  801a8d:	83 c4 18             	add    $0x18,%esp
	return ;
  801a90:	90                   	nop
}
  801a91:	c9                   	leave  
  801a92:	c3                   	ret    

00801a93 <inctst>:

void inctst()
{
  801a93:	55                   	push   %ebp
  801a94:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 00                	push   $0x0
  801aa0:	6a 2a                	push   $0x2a
  801aa2:	e8 e3 fa ff ff       	call   80158a <syscall>
  801aa7:	83 c4 18             	add    $0x18,%esp
	return ;
  801aaa:	90                   	nop
}
  801aab:	c9                   	leave  
  801aac:	c3                   	ret    

00801aad <gettst>:
uint32 gettst()
{
  801aad:	55                   	push   %ebp
  801aae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 2b                	push   $0x2b
  801abc:	e8 c9 fa ff ff       	call   80158a <syscall>
  801ac1:	83 c4 18             	add    $0x18,%esp
}
  801ac4:	c9                   	leave  
  801ac5:	c3                   	ret    

00801ac6 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801ac6:	55                   	push   %ebp
  801ac7:	89 e5                	mov    %esp,%ebp
  801ac9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 00                	push   $0x0
  801ad6:	6a 2c                	push   $0x2c
  801ad8:	e8 ad fa ff ff       	call   80158a <syscall>
  801add:	83 c4 18             	add    $0x18,%esp
  801ae0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801ae3:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801ae7:	75 07                	jne    801af0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801ae9:	b8 01 00 00 00       	mov    $0x1,%eax
  801aee:	eb 05                	jmp    801af5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801af0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801af5:	c9                   	leave  
  801af6:	c3                   	ret    

00801af7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801af7:	55                   	push   %ebp
  801af8:	89 e5                	mov    %esp,%ebp
  801afa:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801afd:	6a 00                	push   $0x0
  801aff:	6a 00                	push   $0x0
  801b01:	6a 00                	push   $0x0
  801b03:	6a 00                	push   $0x0
  801b05:	6a 00                	push   $0x0
  801b07:	6a 2c                	push   $0x2c
  801b09:	e8 7c fa ff ff       	call   80158a <syscall>
  801b0e:	83 c4 18             	add    $0x18,%esp
  801b11:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801b14:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801b18:	75 07                	jne    801b21 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801b1a:	b8 01 00 00 00       	mov    $0x1,%eax
  801b1f:	eb 05                	jmp    801b26 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801b21:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b26:	c9                   	leave  
  801b27:	c3                   	ret    

00801b28 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801b28:	55                   	push   %ebp
  801b29:	89 e5                	mov    %esp,%ebp
  801b2b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	6a 00                	push   $0x0
  801b36:	6a 00                	push   $0x0
  801b38:	6a 2c                	push   $0x2c
  801b3a:	e8 4b fa ff ff       	call   80158a <syscall>
  801b3f:	83 c4 18             	add    $0x18,%esp
  801b42:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801b45:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801b49:	75 07                	jne    801b52 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801b4b:	b8 01 00 00 00       	mov    $0x1,%eax
  801b50:	eb 05                	jmp    801b57 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801b52:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b57:	c9                   	leave  
  801b58:	c3                   	ret    

00801b59 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801b59:	55                   	push   %ebp
  801b5a:	89 e5                	mov    %esp,%ebp
  801b5c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b5f:	6a 00                	push   $0x0
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	6a 2c                	push   $0x2c
  801b6b:	e8 1a fa ff ff       	call   80158a <syscall>
  801b70:	83 c4 18             	add    $0x18,%esp
  801b73:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801b76:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801b7a:	75 07                	jne    801b83 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801b7c:	b8 01 00 00 00       	mov    $0x1,%eax
  801b81:	eb 05                	jmp    801b88 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801b83:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b88:	c9                   	leave  
  801b89:	c3                   	ret    

00801b8a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b8a:	55                   	push   %ebp
  801b8b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b8d:	6a 00                	push   $0x0
  801b8f:	6a 00                	push   $0x0
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	ff 75 08             	pushl  0x8(%ebp)
  801b98:	6a 2d                	push   $0x2d
  801b9a:	e8 eb f9 ff ff       	call   80158a <syscall>
  801b9f:	83 c4 18             	add    $0x18,%esp
	return ;
  801ba2:	90                   	nop
}
  801ba3:	c9                   	leave  
  801ba4:	c3                   	ret    

00801ba5 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801ba5:	55                   	push   %ebp
  801ba6:	89 e5                	mov    %esp,%ebp
  801ba8:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801ba9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bac:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801baf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bb2:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb5:	6a 00                	push   $0x0
  801bb7:	53                   	push   %ebx
  801bb8:	51                   	push   %ecx
  801bb9:	52                   	push   %edx
  801bba:	50                   	push   %eax
  801bbb:	6a 2e                	push   $0x2e
  801bbd:	e8 c8 f9 ff ff       	call   80158a <syscall>
  801bc2:	83 c4 18             	add    $0x18,%esp
}
  801bc5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801bc8:	c9                   	leave  
  801bc9:	c3                   	ret    

00801bca <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801bca:	55                   	push   %ebp
  801bcb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801bcd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd3:	6a 00                	push   $0x0
  801bd5:	6a 00                	push   $0x0
  801bd7:	6a 00                	push   $0x0
  801bd9:	52                   	push   %edx
  801bda:	50                   	push   %eax
  801bdb:	6a 2f                	push   $0x2f
  801bdd:	e8 a8 f9 ff ff       	call   80158a <syscall>
  801be2:	83 c4 18             	add    $0x18,%esp
}
  801be5:	c9                   	leave  
  801be6:	c3                   	ret    

00801be7 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801be7:	55                   	push   %ebp
  801be8:	89 e5                	mov    %esp,%ebp
  801bea:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801bed:	8d 45 10             	lea    0x10(%ebp),%eax
  801bf0:	83 c0 04             	add    $0x4,%eax
  801bf3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801bf6:	a1 20 d7 96 00       	mov    0x96d720,%eax
  801bfb:	85 c0                	test   %eax,%eax
  801bfd:	74 16                	je     801c15 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801bff:	a1 20 d7 96 00       	mov    0x96d720,%eax
  801c04:	83 ec 08             	sub    $0x8,%esp
  801c07:	50                   	push   %eax
  801c08:	68 38 26 80 00       	push   $0x802638
  801c0d:	e8 0f e8 ff ff       	call   800421 <cprintf>
  801c12:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801c15:	a1 00 30 80 00       	mov    0x803000,%eax
  801c1a:	ff 75 0c             	pushl  0xc(%ebp)
  801c1d:	ff 75 08             	pushl  0x8(%ebp)
  801c20:	50                   	push   %eax
  801c21:	68 3d 26 80 00       	push   $0x80263d
  801c26:	e8 f6 e7 ff ff       	call   800421 <cprintf>
  801c2b:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801c2e:	8b 45 10             	mov    0x10(%ebp),%eax
  801c31:	83 ec 08             	sub    $0x8,%esp
  801c34:	ff 75 f4             	pushl  -0xc(%ebp)
  801c37:	50                   	push   %eax
  801c38:	e8 79 e7 ff ff       	call   8003b6 <vcprintf>
  801c3d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801c40:	83 ec 08             	sub    $0x8,%esp
  801c43:	6a 00                	push   $0x0
  801c45:	68 59 26 80 00       	push   $0x802659
  801c4a:	e8 67 e7 ff ff       	call   8003b6 <vcprintf>
  801c4f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801c52:	e8 e8 e6 ff ff       	call   80033f <exit>

	// should not return here
	while (1) ;
  801c57:	eb fe                	jmp    801c57 <_panic+0x70>

00801c59 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801c59:	55                   	push   %ebp
  801c5a:	89 e5                	mov    %esp,%ebp
  801c5c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801c5f:	a1 20 30 80 00       	mov    0x803020,%eax
  801c64:	8b 50 74             	mov    0x74(%eax),%edx
  801c67:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c6a:	39 c2                	cmp    %eax,%edx
  801c6c:	74 14                	je     801c82 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801c6e:	83 ec 04             	sub    $0x4,%esp
  801c71:	68 5c 26 80 00       	push   $0x80265c
  801c76:	6a 26                	push   $0x26
  801c78:	68 a8 26 80 00       	push   $0x8026a8
  801c7d:	e8 65 ff ff ff       	call   801be7 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801c82:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801c89:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801c90:	e9 b6 00 00 00       	jmp    801d4b <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801c95:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c98:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca2:	01 d0                	add    %edx,%eax
  801ca4:	8b 00                	mov    (%eax),%eax
  801ca6:	85 c0                	test   %eax,%eax
  801ca8:	75 08                	jne    801cb2 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801caa:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801cad:	e9 96 00 00 00       	jmp    801d48 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  801cb2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801cb9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801cc0:	eb 5d                	jmp    801d1f <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801cc2:	a1 20 30 80 00       	mov    0x803020,%eax
  801cc7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801ccd:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801cd0:	c1 e2 04             	shl    $0x4,%edx
  801cd3:	01 d0                	add    %edx,%eax
  801cd5:	8a 40 04             	mov    0x4(%eax),%al
  801cd8:	84 c0                	test   %al,%al
  801cda:	75 40                	jne    801d1c <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801cdc:	a1 20 30 80 00       	mov    0x803020,%eax
  801ce1:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801ce7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801cea:	c1 e2 04             	shl    $0x4,%edx
  801ced:	01 d0                	add    %edx,%eax
  801cef:	8b 00                	mov    (%eax),%eax
  801cf1:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801cf4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801cf7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801cfc:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801cfe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d01:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801d08:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0b:	01 c8                	add    %ecx,%eax
  801d0d:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801d0f:	39 c2                	cmp    %eax,%edx
  801d11:	75 09                	jne    801d1c <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801d13:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801d1a:	eb 12                	jmp    801d2e <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d1c:	ff 45 e8             	incl   -0x18(%ebp)
  801d1f:	a1 20 30 80 00       	mov    0x803020,%eax
  801d24:	8b 50 74             	mov    0x74(%eax),%edx
  801d27:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801d2a:	39 c2                	cmp    %eax,%edx
  801d2c:	77 94                	ja     801cc2 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801d2e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801d32:	75 14                	jne    801d48 <CheckWSWithoutLastIndex+0xef>
			panic(
  801d34:	83 ec 04             	sub    $0x4,%esp
  801d37:	68 b4 26 80 00       	push   $0x8026b4
  801d3c:	6a 3a                	push   $0x3a
  801d3e:	68 a8 26 80 00       	push   $0x8026a8
  801d43:	e8 9f fe ff ff       	call   801be7 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801d48:	ff 45 f0             	incl   -0x10(%ebp)
  801d4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d4e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801d51:	0f 8c 3e ff ff ff    	jl     801c95 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801d57:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d5e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801d65:	eb 20                	jmp    801d87 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801d67:	a1 20 30 80 00       	mov    0x803020,%eax
  801d6c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801d72:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801d75:	c1 e2 04             	shl    $0x4,%edx
  801d78:	01 d0                	add    %edx,%eax
  801d7a:	8a 40 04             	mov    0x4(%eax),%al
  801d7d:	3c 01                	cmp    $0x1,%al
  801d7f:	75 03                	jne    801d84 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  801d81:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d84:	ff 45 e0             	incl   -0x20(%ebp)
  801d87:	a1 20 30 80 00       	mov    0x803020,%eax
  801d8c:	8b 50 74             	mov    0x74(%eax),%edx
  801d8f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d92:	39 c2                	cmp    %eax,%edx
  801d94:	77 d1                	ja     801d67 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801d96:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d99:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801d9c:	74 14                	je     801db2 <CheckWSWithoutLastIndex+0x159>
		panic(
  801d9e:	83 ec 04             	sub    $0x4,%esp
  801da1:	68 08 27 80 00       	push   $0x802708
  801da6:	6a 44                	push   $0x44
  801da8:	68 a8 26 80 00       	push   $0x8026a8
  801dad:	e8 35 fe ff ff       	call   801be7 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801db2:	90                   	nop
  801db3:	c9                   	leave  
  801db4:	c3                   	ret    
  801db5:	66 90                	xchg   %ax,%ax
  801db7:	90                   	nop

00801db8 <__udivdi3>:
  801db8:	55                   	push   %ebp
  801db9:	57                   	push   %edi
  801dba:	56                   	push   %esi
  801dbb:	53                   	push   %ebx
  801dbc:	83 ec 1c             	sub    $0x1c,%esp
  801dbf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801dc3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801dc7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801dcb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801dcf:	89 ca                	mov    %ecx,%edx
  801dd1:	89 f8                	mov    %edi,%eax
  801dd3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801dd7:	85 f6                	test   %esi,%esi
  801dd9:	75 2d                	jne    801e08 <__udivdi3+0x50>
  801ddb:	39 cf                	cmp    %ecx,%edi
  801ddd:	77 65                	ja     801e44 <__udivdi3+0x8c>
  801ddf:	89 fd                	mov    %edi,%ebp
  801de1:	85 ff                	test   %edi,%edi
  801de3:	75 0b                	jne    801df0 <__udivdi3+0x38>
  801de5:	b8 01 00 00 00       	mov    $0x1,%eax
  801dea:	31 d2                	xor    %edx,%edx
  801dec:	f7 f7                	div    %edi
  801dee:	89 c5                	mov    %eax,%ebp
  801df0:	31 d2                	xor    %edx,%edx
  801df2:	89 c8                	mov    %ecx,%eax
  801df4:	f7 f5                	div    %ebp
  801df6:	89 c1                	mov    %eax,%ecx
  801df8:	89 d8                	mov    %ebx,%eax
  801dfa:	f7 f5                	div    %ebp
  801dfc:	89 cf                	mov    %ecx,%edi
  801dfe:	89 fa                	mov    %edi,%edx
  801e00:	83 c4 1c             	add    $0x1c,%esp
  801e03:	5b                   	pop    %ebx
  801e04:	5e                   	pop    %esi
  801e05:	5f                   	pop    %edi
  801e06:	5d                   	pop    %ebp
  801e07:	c3                   	ret    
  801e08:	39 ce                	cmp    %ecx,%esi
  801e0a:	77 28                	ja     801e34 <__udivdi3+0x7c>
  801e0c:	0f bd fe             	bsr    %esi,%edi
  801e0f:	83 f7 1f             	xor    $0x1f,%edi
  801e12:	75 40                	jne    801e54 <__udivdi3+0x9c>
  801e14:	39 ce                	cmp    %ecx,%esi
  801e16:	72 0a                	jb     801e22 <__udivdi3+0x6a>
  801e18:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e1c:	0f 87 9e 00 00 00    	ja     801ec0 <__udivdi3+0x108>
  801e22:	b8 01 00 00 00       	mov    $0x1,%eax
  801e27:	89 fa                	mov    %edi,%edx
  801e29:	83 c4 1c             	add    $0x1c,%esp
  801e2c:	5b                   	pop    %ebx
  801e2d:	5e                   	pop    %esi
  801e2e:	5f                   	pop    %edi
  801e2f:	5d                   	pop    %ebp
  801e30:	c3                   	ret    
  801e31:	8d 76 00             	lea    0x0(%esi),%esi
  801e34:	31 ff                	xor    %edi,%edi
  801e36:	31 c0                	xor    %eax,%eax
  801e38:	89 fa                	mov    %edi,%edx
  801e3a:	83 c4 1c             	add    $0x1c,%esp
  801e3d:	5b                   	pop    %ebx
  801e3e:	5e                   	pop    %esi
  801e3f:	5f                   	pop    %edi
  801e40:	5d                   	pop    %ebp
  801e41:	c3                   	ret    
  801e42:	66 90                	xchg   %ax,%ax
  801e44:	89 d8                	mov    %ebx,%eax
  801e46:	f7 f7                	div    %edi
  801e48:	31 ff                	xor    %edi,%edi
  801e4a:	89 fa                	mov    %edi,%edx
  801e4c:	83 c4 1c             	add    $0x1c,%esp
  801e4f:	5b                   	pop    %ebx
  801e50:	5e                   	pop    %esi
  801e51:	5f                   	pop    %edi
  801e52:	5d                   	pop    %ebp
  801e53:	c3                   	ret    
  801e54:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e59:	89 eb                	mov    %ebp,%ebx
  801e5b:	29 fb                	sub    %edi,%ebx
  801e5d:	89 f9                	mov    %edi,%ecx
  801e5f:	d3 e6                	shl    %cl,%esi
  801e61:	89 c5                	mov    %eax,%ebp
  801e63:	88 d9                	mov    %bl,%cl
  801e65:	d3 ed                	shr    %cl,%ebp
  801e67:	89 e9                	mov    %ebp,%ecx
  801e69:	09 f1                	or     %esi,%ecx
  801e6b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e6f:	89 f9                	mov    %edi,%ecx
  801e71:	d3 e0                	shl    %cl,%eax
  801e73:	89 c5                	mov    %eax,%ebp
  801e75:	89 d6                	mov    %edx,%esi
  801e77:	88 d9                	mov    %bl,%cl
  801e79:	d3 ee                	shr    %cl,%esi
  801e7b:	89 f9                	mov    %edi,%ecx
  801e7d:	d3 e2                	shl    %cl,%edx
  801e7f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e83:	88 d9                	mov    %bl,%cl
  801e85:	d3 e8                	shr    %cl,%eax
  801e87:	09 c2                	or     %eax,%edx
  801e89:	89 d0                	mov    %edx,%eax
  801e8b:	89 f2                	mov    %esi,%edx
  801e8d:	f7 74 24 0c          	divl   0xc(%esp)
  801e91:	89 d6                	mov    %edx,%esi
  801e93:	89 c3                	mov    %eax,%ebx
  801e95:	f7 e5                	mul    %ebp
  801e97:	39 d6                	cmp    %edx,%esi
  801e99:	72 19                	jb     801eb4 <__udivdi3+0xfc>
  801e9b:	74 0b                	je     801ea8 <__udivdi3+0xf0>
  801e9d:	89 d8                	mov    %ebx,%eax
  801e9f:	31 ff                	xor    %edi,%edi
  801ea1:	e9 58 ff ff ff       	jmp    801dfe <__udivdi3+0x46>
  801ea6:	66 90                	xchg   %ax,%ax
  801ea8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801eac:	89 f9                	mov    %edi,%ecx
  801eae:	d3 e2                	shl    %cl,%edx
  801eb0:	39 c2                	cmp    %eax,%edx
  801eb2:	73 e9                	jae    801e9d <__udivdi3+0xe5>
  801eb4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801eb7:	31 ff                	xor    %edi,%edi
  801eb9:	e9 40 ff ff ff       	jmp    801dfe <__udivdi3+0x46>
  801ebe:	66 90                	xchg   %ax,%ax
  801ec0:	31 c0                	xor    %eax,%eax
  801ec2:	e9 37 ff ff ff       	jmp    801dfe <__udivdi3+0x46>
  801ec7:	90                   	nop

00801ec8 <__umoddi3>:
  801ec8:	55                   	push   %ebp
  801ec9:	57                   	push   %edi
  801eca:	56                   	push   %esi
  801ecb:	53                   	push   %ebx
  801ecc:	83 ec 1c             	sub    $0x1c,%esp
  801ecf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ed3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ed7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801edb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801edf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ee3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801ee7:	89 f3                	mov    %esi,%ebx
  801ee9:	89 fa                	mov    %edi,%edx
  801eeb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801eef:	89 34 24             	mov    %esi,(%esp)
  801ef2:	85 c0                	test   %eax,%eax
  801ef4:	75 1a                	jne    801f10 <__umoddi3+0x48>
  801ef6:	39 f7                	cmp    %esi,%edi
  801ef8:	0f 86 a2 00 00 00    	jbe    801fa0 <__umoddi3+0xd8>
  801efe:	89 c8                	mov    %ecx,%eax
  801f00:	89 f2                	mov    %esi,%edx
  801f02:	f7 f7                	div    %edi
  801f04:	89 d0                	mov    %edx,%eax
  801f06:	31 d2                	xor    %edx,%edx
  801f08:	83 c4 1c             	add    $0x1c,%esp
  801f0b:	5b                   	pop    %ebx
  801f0c:	5e                   	pop    %esi
  801f0d:	5f                   	pop    %edi
  801f0e:	5d                   	pop    %ebp
  801f0f:	c3                   	ret    
  801f10:	39 f0                	cmp    %esi,%eax
  801f12:	0f 87 ac 00 00 00    	ja     801fc4 <__umoddi3+0xfc>
  801f18:	0f bd e8             	bsr    %eax,%ebp
  801f1b:	83 f5 1f             	xor    $0x1f,%ebp
  801f1e:	0f 84 ac 00 00 00    	je     801fd0 <__umoddi3+0x108>
  801f24:	bf 20 00 00 00       	mov    $0x20,%edi
  801f29:	29 ef                	sub    %ebp,%edi
  801f2b:	89 fe                	mov    %edi,%esi
  801f2d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f31:	89 e9                	mov    %ebp,%ecx
  801f33:	d3 e0                	shl    %cl,%eax
  801f35:	89 d7                	mov    %edx,%edi
  801f37:	89 f1                	mov    %esi,%ecx
  801f39:	d3 ef                	shr    %cl,%edi
  801f3b:	09 c7                	or     %eax,%edi
  801f3d:	89 e9                	mov    %ebp,%ecx
  801f3f:	d3 e2                	shl    %cl,%edx
  801f41:	89 14 24             	mov    %edx,(%esp)
  801f44:	89 d8                	mov    %ebx,%eax
  801f46:	d3 e0                	shl    %cl,%eax
  801f48:	89 c2                	mov    %eax,%edx
  801f4a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f4e:	d3 e0                	shl    %cl,%eax
  801f50:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f54:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f58:	89 f1                	mov    %esi,%ecx
  801f5a:	d3 e8                	shr    %cl,%eax
  801f5c:	09 d0                	or     %edx,%eax
  801f5e:	d3 eb                	shr    %cl,%ebx
  801f60:	89 da                	mov    %ebx,%edx
  801f62:	f7 f7                	div    %edi
  801f64:	89 d3                	mov    %edx,%ebx
  801f66:	f7 24 24             	mull   (%esp)
  801f69:	89 c6                	mov    %eax,%esi
  801f6b:	89 d1                	mov    %edx,%ecx
  801f6d:	39 d3                	cmp    %edx,%ebx
  801f6f:	0f 82 87 00 00 00    	jb     801ffc <__umoddi3+0x134>
  801f75:	0f 84 91 00 00 00    	je     80200c <__umoddi3+0x144>
  801f7b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f7f:	29 f2                	sub    %esi,%edx
  801f81:	19 cb                	sbb    %ecx,%ebx
  801f83:	89 d8                	mov    %ebx,%eax
  801f85:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f89:	d3 e0                	shl    %cl,%eax
  801f8b:	89 e9                	mov    %ebp,%ecx
  801f8d:	d3 ea                	shr    %cl,%edx
  801f8f:	09 d0                	or     %edx,%eax
  801f91:	89 e9                	mov    %ebp,%ecx
  801f93:	d3 eb                	shr    %cl,%ebx
  801f95:	89 da                	mov    %ebx,%edx
  801f97:	83 c4 1c             	add    $0x1c,%esp
  801f9a:	5b                   	pop    %ebx
  801f9b:	5e                   	pop    %esi
  801f9c:	5f                   	pop    %edi
  801f9d:	5d                   	pop    %ebp
  801f9e:	c3                   	ret    
  801f9f:	90                   	nop
  801fa0:	89 fd                	mov    %edi,%ebp
  801fa2:	85 ff                	test   %edi,%edi
  801fa4:	75 0b                	jne    801fb1 <__umoddi3+0xe9>
  801fa6:	b8 01 00 00 00       	mov    $0x1,%eax
  801fab:	31 d2                	xor    %edx,%edx
  801fad:	f7 f7                	div    %edi
  801faf:	89 c5                	mov    %eax,%ebp
  801fb1:	89 f0                	mov    %esi,%eax
  801fb3:	31 d2                	xor    %edx,%edx
  801fb5:	f7 f5                	div    %ebp
  801fb7:	89 c8                	mov    %ecx,%eax
  801fb9:	f7 f5                	div    %ebp
  801fbb:	89 d0                	mov    %edx,%eax
  801fbd:	e9 44 ff ff ff       	jmp    801f06 <__umoddi3+0x3e>
  801fc2:	66 90                	xchg   %ax,%ax
  801fc4:	89 c8                	mov    %ecx,%eax
  801fc6:	89 f2                	mov    %esi,%edx
  801fc8:	83 c4 1c             	add    $0x1c,%esp
  801fcb:	5b                   	pop    %ebx
  801fcc:	5e                   	pop    %esi
  801fcd:	5f                   	pop    %edi
  801fce:	5d                   	pop    %ebp
  801fcf:	c3                   	ret    
  801fd0:	3b 04 24             	cmp    (%esp),%eax
  801fd3:	72 06                	jb     801fdb <__umoddi3+0x113>
  801fd5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801fd9:	77 0f                	ja     801fea <__umoddi3+0x122>
  801fdb:	89 f2                	mov    %esi,%edx
  801fdd:	29 f9                	sub    %edi,%ecx
  801fdf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801fe3:	89 14 24             	mov    %edx,(%esp)
  801fe6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801fea:	8b 44 24 04          	mov    0x4(%esp),%eax
  801fee:	8b 14 24             	mov    (%esp),%edx
  801ff1:	83 c4 1c             	add    $0x1c,%esp
  801ff4:	5b                   	pop    %ebx
  801ff5:	5e                   	pop    %esi
  801ff6:	5f                   	pop    %edi
  801ff7:	5d                   	pop    %ebp
  801ff8:	c3                   	ret    
  801ff9:	8d 76 00             	lea    0x0(%esi),%esi
  801ffc:	2b 04 24             	sub    (%esp),%eax
  801fff:	19 fa                	sbb    %edi,%edx
  802001:	89 d1                	mov    %edx,%ecx
  802003:	89 c6                	mov    %eax,%esi
  802005:	e9 71 ff ff ff       	jmp    801f7b <__umoddi3+0xb3>
  80200a:	66 90                	xchg   %ax,%ax
  80200c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802010:	72 ea                	jb     801ffc <__umoddi3+0x134>
  802012:	89 d9                	mov    %ebx,%ecx
  802014:	e9 62 ff ff ff       	jmp    801f7b <__umoddi3+0xb3>
