
obj/user/tst_semaphore_2master:     file format elf32-i386


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
  800031:	e8 74 01 00 00       	call   8001aa <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Master program: take user input, create the semaphores, run slaves and wait them to finish
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 28 01 00 00    	sub    $0x128,%esp
	int envID = sys_getenvid();
  800041:	e8 95 13 00 00       	call   8013db <sys_getenvid>
  800046:	89 45 f0             	mov    %eax,-0x10(%ebp)
	char line[256] ;
	readline("Enter total number of customers: ", line) ;
  800049:	83 ec 08             	sub    $0x8,%esp
  80004c:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  800052:	50                   	push   %eax
  800053:	68 c0 1c 80 00       	push   $0x801cc0
  800058:	e8 e8 09 00 00       	call   800a45 <readline>
  80005d:	83 c4 10             	add    $0x10,%esp
	int totalNumOfCusts = strtol(line, NULL, 10);
  800060:	83 ec 04             	sub    $0x4,%esp
  800063:	6a 0a                	push   $0xa
  800065:	6a 00                	push   $0x0
  800067:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  80006d:	50                   	push   %eax
  80006e:	e8 38 0f 00 00       	call   800fab <strtol>
  800073:	83 c4 10             	add    $0x10,%esp
  800076:	89 45 ec             	mov    %eax,-0x14(%ebp)
	readline("Enter shop capacity: ", line) ;
  800079:	83 ec 08             	sub    $0x8,%esp
  80007c:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  800082:	50                   	push   %eax
  800083:	68 e2 1c 80 00       	push   $0x801ce2
  800088:	e8 b8 09 00 00       	call   800a45 <readline>
  80008d:	83 c4 10             	add    $0x10,%esp
	int shopCapacity = strtol(line, NULL, 10);
  800090:	83 ec 04             	sub    $0x4,%esp
  800093:	6a 0a                	push   $0xa
  800095:	6a 00                	push   $0x0
  800097:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  80009d:	50                   	push   %eax
  80009e:	e8 08 0f 00 00       	call   800fab <strtol>
  8000a3:	83 c4 10             	add    $0x10,%esp
  8000a6:	89 45 e8             	mov    %eax,-0x18(%ebp)

	sys_createSemaphore("shopCapacity", shopCapacity);
  8000a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000ac:	83 ec 08             	sub    $0x8,%esp
  8000af:	50                   	push   %eax
  8000b0:	68 f8 1c 80 00       	push   $0x801cf8
  8000b5:	e8 49 15 00 00       	call   801603 <sys_createSemaphore>
  8000ba:	83 c4 10             	add    $0x10,%esp
	sys_createSemaphore("depend", 0);
  8000bd:	83 ec 08             	sub    $0x8,%esp
  8000c0:	6a 00                	push   $0x0
  8000c2:	68 05 1d 80 00       	push   $0x801d05
  8000c7:	e8 37 15 00 00       	call   801603 <sys_createSemaphore>
  8000cc:	83 c4 10             	add    $0x10,%esp

	int i = 0 ;
  8000cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int id ;
	for (; i<totalNumOfCusts; i++)
  8000d6:	eb 44                	jmp    80011c <_main+0xe4>
	{
		id = sys_create_env("sem2Slave", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  8000d8:	a1 20 30 80 00       	mov    0x803020,%eax
  8000dd:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8000e3:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e8:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000ee:	89 c1                	mov    %eax,%ecx
  8000f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000f5:	8b 40 74             	mov    0x74(%eax),%eax
  8000f8:	52                   	push   %edx
  8000f9:	51                   	push   %ecx
  8000fa:	50                   	push   %eax
  8000fb:	68 0c 1d 80 00       	push   $0x801d0c
  800100:	e8 0f 16 00 00       	call   801714 <sys_create_env>
  800105:	83 c4 10             	add    $0x10,%esp
  800108:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		sys_run_env(id) ;
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800111:	e8 1c 16 00 00       	call   801732 <sys_run_env>
  800116:	83 c4 10             	add    $0x10,%esp
	sys_createSemaphore("shopCapacity", shopCapacity);
	sys_createSemaphore("depend", 0);

	int i = 0 ;
	int id ;
	for (; i<totalNumOfCusts; i++)
  800119:	ff 45 f4             	incl   -0xc(%ebp)
  80011c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80011f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  800122:	7c b4                	jl     8000d8 <_main+0xa0>
	{
		id = sys_create_env("sem2Slave", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(id) ;
	}

	for (i = 0 ; i<totalNumOfCusts; i++)
  800124:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80012b:	eb 16                	jmp    800143 <_main+0x10b>
	{
		sys_waitSemaphore(envID, "depend") ;
  80012d:	83 ec 08             	sub    $0x8,%esp
  800130:	68 05 1d 80 00       	push   $0x801d05
  800135:	ff 75 f0             	pushl  -0x10(%ebp)
  800138:	e8 ff 14 00 00       	call   80163c <sys_waitSemaphore>
  80013d:	83 c4 10             	add    $0x10,%esp
	{
		id = sys_create_env("sem2Slave", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(id) ;
	}

	for (i = 0 ; i<totalNumOfCusts; i++)
  800140:	ff 45 f4             	incl   -0xc(%ebp)
  800143:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800146:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  800149:	7c e2                	jl     80012d <_main+0xf5>
	{
		sys_waitSemaphore(envID, "depend") ;
	}
	int sem1val = sys_getSemaphoreValue(envID, "shopCapacity");
  80014b:	83 ec 08             	sub    $0x8,%esp
  80014e:	68 f8 1c 80 00       	push   $0x801cf8
  800153:	ff 75 f0             	pushl  -0x10(%ebp)
  800156:	e8 c4 14 00 00       	call   80161f <sys_getSemaphoreValue>
  80015b:	83 c4 10             	add    $0x10,%esp
  80015e:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int sem2val = sys_getSemaphoreValue(envID, "depend");
  800161:	83 ec 08             	sub    $0x8,%esp
  800164:	68 05 1d 80 00       	push   $0x801d05
  800169:	ff 75 f0             	pushl  -0x10(%ebp)
  80016c:	e8 ae 14 00 00       	call   80161f <sys_getSemaphoreValue>
  800171:	83 c4 10             	add    $0x10,%esp
  800174:	89 45 dc             	mov    %eax,-0x24(%ebp)
	if (sem2val == 0 && sem1val == shopCapacity)
  800177:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80017b:	75 1a                	jne    800197 <_main+0x15f>
  80017d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800180:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  800183:	75 12                	jne    800197 <_main+0x15f>
		cprintf("Congratulations!! Test of Semaphores [2] completed successfully!!\n\n\n");
  800185:	83 ec 0c             	sub    $0xc,%esp
  800188:	68 18 1d 80 00       	push   $0x801d18
  80018d:	e8 31 02 00 00       	call   8003c3 <cprintf>
  800192:	83 c4 10             	add    $0x10,%esp
  800195:	eb 10                	jmp    8001a7 <_main+0x16f>
	else
		cprintf("Error: wrong semaphore value... please review your semaphore code again...");
  800197:	83 ec 0c             	sub    $0xc,%esp
  80019a:	68 60 1d 80 00       	push   $0x801d60
  80019f:	e8 1f 02 00 00       	call   8003c3 <cprintf>
  8001a4:	83 c4 10             	add    $0x10,%esp

	return;
  8001a7:	90                   	nop
}
  8001a8:	c9                   	leave  
  8001a9:	c3                   	ret    

008001aa <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001aa:	55                   	push   %ebp
  8001ab:	89 e5                	mov    %esp,%ebp
  8001ad:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001b0:	e8 3f 12 00 00       	call   8013f4 <sys_getenvindex>
  8001b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001b8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001bb:	89 d0                	mov    %edx,%eax
  8001bd:	c1 e0 03             	shl    $0x3,%eax
  8001c0:	01 d0                	add    %edx,%eax
  8001c2:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8001c9:	01 c8                	add    %ecx,%eax
  8001cb:	01 c0                	add    %eax,%eax
  8001cd:	01 d0                	add    %edx,%eax
  8001cf:	01 c0                	add    %eax,%eax
  8001d1:	01 d0                	add    %edx,%eax
  8001d3:	89 c2                	mov    %eax,%edx
  8001d5:	c1 e2 05             	shl    $0x5,%edx
  8001d8:	29 c2                	sub    %eax,%edx
  8001da:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8001e1:	89 c2                	mov    %eax,%edx
  8001e3:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8001e9:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f3:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8001f9:	84 c0                	test   %al,%al
  8001fb:	74 0f                	je     80020c <libmain+0x62>
		binaryname = myEnv->prog_name;
  8001fd:	a1 20 30 80 00       	mov    0x803020,%eax
  800202:	05 40 3c 01 00       	add    $0x13c40,%eax
  800207:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80020c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800210:	7e 0a                	jle    80021c <libmain+0x72>
		binaryname = argv[0];
  800212:	8b 45 0c             	mov    0xc(%ebp),%eax
  800215:	8b 00                	mov    (%eax),%eax
  800217:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80021c:	83 ec 08             	sub    $0x8,%esp
  80021f:	ff 75 0c             	pushl  0xc(%ebp)
  800222:	ff 75 08             	pushl  0x8(%ebp)
  800225:	e8 0e fe ff ff       	call   800038 <_main>
  80022a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80022d:	e8 5d 13 00 00       	call   80158f <sys_disable_interrupt>
	cprintf("**************************************\n");
  800232:	83 ec 0c             	sub    $0xc,%esp
  800235:	68 c4 1d 80 00       	push   $0x801dc4
  80023a:	e8 84 01 00 00       	call   8003c3 <cprintf>
  80023f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800242:	a1 20 30 80 00       	mov    0x803020,%eax
  800247:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80024d:	a1 20 30 80 00       	mov    0x803020,%eax
  800252:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800258:	83 ec 04             	sub    $0x4,%esp
  80025b:	52                   	push   %edx
  80025c:	50                   	push   %eax
  80025d:	68 ec 1d 80 00       	push   $0x801dec
  800262:	e8 5c 01 00 00       	call   8003c3 <cprintf>
  800267:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80026a:	a1 20 30 80 00       	mov    0x803020,%eax
  80026f:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800275:	a1 20 30 80 00       	mov    0x803020,%eax
  80027a:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800280:	83 ec 04             	sub    $0x4,%esp
  800283:	52                   	push   %edx
  800284:	50                   	push   %eax
  800285:	68 14 1e 80 00       	push   $0x801e14
  80028a:	e8 34 01 00 00       	call   8003c3 <cprintf>
  80028f:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800292:	a1 20 30 80 00       	mov    0x803020,%eax
  800297:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80029d:	83 ec 08             	sub    $0x8,%esp
  8002a0:	50                   	push   %eax
  8002a1:	68 55 1e 80 00       	push   $0x801e55
  8002a6:	e8 18 01 00 00       	call   8003c3 <cprintf>
  8002ab:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002ae:	83 ec 0c             	sub    $0xc,%esp
  8002b1:	68 c4 1d 80 00       	push   $0x801dc4
  8002b6:	e8 08 01 00 00       	call   8003c3 <cprintf>
  8002bb:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002be:	e8 e6 12 00 00       	call   8015a9 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002c3:	e8 19 00 00 00       	call   8002e1 <exit>
}
  8002c8:	90                   	nop
  8002c9:	c9                   	leave  
  8002ca:	c3                   	ret    

008002cb <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002cb:	55                   	push   %ebp
  8002cc:	89 e5                	mov    %esp,%ebp
  8002ce:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002d1:	83 ec 0c             	sub    $0xc,%esp
  8002d4:	6a 00                	push   $0x0
  8002d6:	e8 e5 10 00 00       	call   8013c0 <sys_env_destroy>
  8002db:	83 c4 10             	add    $0x10,%esp
}
  8002de:	90                   	nop
  8002df:	c9                   	leave  
  8002e0:	c3                   	ret    

008002e1 <exit>:

void
exit(void)
{
  8002e1:	55                   	push   %ebp
  8002e2:	89 e5                	mov    %esp,%ebp
  8002e4:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002e7:	e8 3a 11 00 00       	call   801426 <sys_env_exit>
}
  8002ec:	90                   	nop
  8002ed:	c9                   	leave  
  8002ee:	c3                   	ret    

008002ef <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8002ef:	55                   	push   %ebp
  8002f0:	89 e5                	mov    %esp,%ebp
  8002f2:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8002f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002f8:	8b 00                	mov    (%eax),%eax
  8002fa:	8d 48 01             	lea    0x1(%eax),%ecx
  8002fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800300:	89 0a                	mov    %ecx,(%edx)
  800302:	8b 55 08             	mov    0x8(%ebp),%edx
  800305:	88 d1                	mov    %dl,%cl
  800307:	8b 55 0c             	mov    0xc(%ebp),%edx
  80030a:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80030e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800311:	8b 00                	mov    (%eax),%eax
  800313:	3d ff 00 00 00       	cmp    $0xff,%eax
  800318:	75 2c                	jne    800346 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80031a:	a0 24 30 80 00       	mov    0x803024,%al
  80031f:	0f b6 c0             	movzbl %al,%eax
  800322:	8b 55 0c             	mov    0xc(%ebp),%edx
  800325:	8b 12                	mov    (%edx),%edx
  800327:	89 d1                	mov    %edx,%ecx
  800329:	8b 55 0c             	mov    0xc(%ebp),%edx
  80032c:	83 c2 08             	add    $0x8,%edx
  80032f:	83 ec 04             	sub    $0x4,%esp
  800332:	50                   	push   %eax
  800333:	51                   	push   %ecx
  800334:	52                   	push   %edx
  800335:	e8 44 10 00 00       	call   80137e <sys_cputs>
  80033a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80033d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800340:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800346:	8b 45 0c             	mov    0xc(%ebp),%eax
  800349:	8b 40 04             	mov    0x4(%eax),%eax
  80034c:	8d 50 01             	lea    0x1(%eax),%edx
  80034f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800352:	89 50 04             	mov    %edx,0x4(%eax)
}
  800355:	90                   	nop
  800356:	c9                   	leave  
  800357:	c3                   	ret    

00800358 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800358:	55                   	push   %ebp
  800359:	89 e5                	mov    %esp,%ebp
  80035b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800361:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800368:	00 00 00 
	b.cnt = 0;
  80036b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800372:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800375:	ff 75 0c             	pushl  0xc(%ebp)
  800378:	ff 75 08             	pushl  0x8(%ebp)
  80037b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800381:	50                   	push   %eax
  800382:	68 ef 02 80 00       	push   $0x8002ef
  800387:	e8 11 02 00 00       	call   80059d <vprintfmt>
  80038c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80038f:	a0 24 30 80 00       	mov    0x803024,%al
  800394:	0f b6 c0             	movzbl %al,%eax
  800397:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80039d:	83 ec 04             	sub    $0x4,%esp
  8003a0:	50                   	push   %eax
  8003a1:	52                   	push   %edx
  8003a2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8003a8:	83 c0 08             	add    $0x8,%eax
  8003ab:	50                   	push   %eax
  8003ac:	e8 cd 0f 00 00       	call   80137e <sys_cputs>
  8003b1:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8003b4:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8003bb:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8003c1:	c9                   	leave  
  8003c2:	c3                   	ret    

008003c3 <cprintf>:

int cprintf(const char *fmt, ...) {
  8003c3:	55                   	push   %ebp
  8003c4:	89 e5                	mov    %esp,%ebp
  8003c6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8003c9:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8003d0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d9:	83 ec 08             	sub    $0x8,%esp
  8003dc:	ff 75 f4             	pushl  -0xc(%ebp)
  8003df:	50                   	push   %eax
  8003e0:	e8 73 ff ff ff       	call   800358 <vcprintf>
  8003e5:	83 c4 10             	add    $0x10,%esp
  8003e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8003eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003ee:	c9                   	leave  
  8003ef:	c3                   	ret    

008003f0 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8003f0:	55                   	push   %ebp
  8003f1:	89 e5                	mov    %esp,%ebp
  8003f3:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8003f6:	e8 94 11 00 00       	call   80158f <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8003fb:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800401:	8b 45 08             	mov    0x8(%ebp),%eax
  800404:	83 ec 08             	sub    $0x8,%esp
  800407:	ff 75 f4             	pushl  -0xc(%ebp)
  80040a:	50                   	push   %eax
  80040b:	e8 48 ff ff ff       	call   800358 <vcprintf>
  800410:	83 c4 10             	add    $0x10,%esp
  800413:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800416:	e8 8e 11 00 00       	call   8015a9 <sys_enable_interrupt>
	return cnt;
  80041b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80041e:	c9                   	leave  
  80041f:	c3                   	ret    

00800420 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800420:	55                   	push   %ebp
  800421:	89 e5                	mov    %esp,%ebp
  800423:	53                   	push   %ebx
  800424:	83 ec 14             	sub    $0x14,%esp
  800427:	8b 45 10             	mov    0x10(%ebp),%eax
  80042a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80042d:	8b 45 14             	mov    0x14(%ebp),%eax
  800430:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800433:	8b 45 18             	mov    0x18(%ebp),%eax
  800436:	ba 00 00 00 00       	mov    $0x0,%edx
  80043b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80043e:	77 55                	ja     800495 <printnum+0x75>
  800440:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800443:	72 05                	jb     80044a <printnum+0x2a>
  800445:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800448:	77 4b                	ja     800495 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80044a:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80044d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800450:	8b 45 18             	mov    0x18(%ebp),%eax
  800453:	ba 00 00 00 00       	mov    $0x0,%edx
  800458:	52                   	push   %edx
  800459:	50                   	push   %eax
  80045a:	ff 75 f4             	pushl  -0xc(%ebp)
  80045d:	ff 75 f0             	pushl  -0x10(%ebp)
  800460:	e8 eb 15 00 00       	call   801a50 <__udivdi3>
  800465:	83 c4 10             	add    $0x10,%esp
  800468:	83 ec 04             	sub    $0x4,%esp
  80046b:	ff 75 20             	pushl  0x20(%ebp)
  80046e:	53                   	push   %ebx
  80046f:	ff 75 18             	pushl  0x18(%ebp)
  800472:	52                   	push   %edx
  800473:	50                   	push   %eax
  800474:	ff 75 0c             	pushl  0xc(%ebp)
  800477:	ff 75 08             	pushl  0x8(%ebp)
  80047a:	e8 a1 ff ff ff       	call   800420 <printnum>
  80047f:	83 c4 20             	add    $0x20,%esp
  800482:	eb 1a                	jmp    80049e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800484:	83 ec 08             	sub    $0x8,%esp
  800487:	ff 75 0c             	pushl  0xc(%ebp)
  80048a:	ff 75 20             	pushl  0x20(%ebp)
  80048d:	8b 45 08             	mov    0x8(%ebp),%eax
  800490:	ff d0                	call   *%eax
  800492:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800495:	ff 4d 1c             	decl   0x1c(%ebp)
  800498:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80049c:	7f e6                	jg     800484 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80049e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8004a1:	bb 00 00 00 00       	mov    $0x0,%ebx
  8004a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8004ac:	53                   	push   %ebx
  8004ad:	51                   	push   %ecx
  8004ae:	52                   	push   %edx
  8004af:	50                   	push   %eax
  8004b0:	e8 ab 16 00 00       	call   801b60 <__umoddi3>
  8004b5:	83 c4 10             	add    $0x10,%esp
  8004b8:	05 94 20 80 00       	add    $0x802094,%eax
  8004bd:	8a 00                	mov    (%eax),%al
  8004bf:	0f be c0             	movsbl %al,%eax
  8004c2:	83 ec 08             	sub    $0x8,%esp
  8004c5:	ff 75 0c             	pushl  0xc(%ebp)
  8004c8:	50                   	push   %eax
  8004c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004cc:	ff d0                	call   *%eax
  8004ce:	83 c4 10             	add    $0x10,%esp
}
  8004d1:	90                   	nop
  8004d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8004d5:	c9                   	leave  
  8004d6:	c3                   	ret    

008004d7 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8004d7:	55                   	push   %ebp
  8004d8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004da:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004de:	7e 1c                	jle    8004fc <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8004e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e3:	8b 00                	mov    (%eax),%eax
  8004e5:	8d 50 08             	lea    0x8(%eax),%edx
  8004e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004eb:	89 10                	mov    %edx,(%eax)
  8004ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f0:	8b 00                	mov    (%eax),%eax
  8004f2:	83 e8 08             	sub    $0x8,%eax
  8004f5:	8b 50 04             	mov    0x4(%eax),%edx
  8004f8:	8b 00                	mov    (%eax),%eax
  8004fa:	eb 40                	jmp    80053c <getuint+0x65>
	else if (lflag)
  8004fc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800500:	74 1e                	je     800520 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800502:	8b 45 08             	mov    0x8(%ebp),%eax
  800505:	8b 00                	mov    (%eax),%eax
  800507:	8d 50 04             	lea    0x4(%eax),%edx
  80050a:	8b 45 08             	mov    0x8(%ebp),%eax
  80050d:	89 10                	mov    %edx,(%eax)
  80050f:	8b 45 08             	mov    0x8(%ebp),%eax
  800512:	8b 00                	mov    (%eax),%eax
  800514:	83 e8 04             	sub    $0x4,%eax
  800517:	8b 00                	mov    (%eax),%eax
  800519:	ba 00 00 00 00       	mov    $0x0,%edx
  80051e:	eb 1c                	jmp    80053c <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800520:	8b 45 08             	mov    0x8(%ebp),%eax
  800523:	8b 00                	mov    (%eax),%eax
  800525:	8d 50 04             	lea    0x4(%eax),%edx
  800528:	8b 45 08             	mov    0x8(%ebp),%eax
  80052b:	89 10                	mov    %edx,(%eax)
  80052d:	8b 45 08             	mov    0x8(%ebp),%eax
  800530:	8b 00                	mov    (%eax),%eax
  800532:	83 e8 04             	sub    $0x4,%eax
  800535:	8b 00                	mov    (%eax),%eax
  800537:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80053c:	5d                   	pop    %ebp
  80053d:	c3                   	ret    

0080053e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80053e:	55                   	push   %ebp
  80053f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800541:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800545:	7e 1c                	jle    800563 <getint+0x25>
		return va_arg(*ap, long long);
  800547:	8b 45 08             	mov    0x8(%ebp),%eax
  80054a:	8b 00                	mov    (%eax),%eax
  80054c:	8d 50 08             	lea    0x8(%eax),%edx
  80054f:	8b 45 08             	mov    0x8(%ebp),%eax
  800552:	89 10                	mov    %edx,(%eax)
  800554:	8b 45 08             	mov    0x8(%ebp),%eax
  800557:	8b 00                	mov    (%eax),%eax
  800559:	83 e8 08             	sub    $0x8,%eax
  80055c:	8b 50 04             	mov    0x4(%eax),%edx
  80055f:	8b 00                	mov    (%eax),%eax
  800561:	eb 38                	jmp    80059b <getint+0x5d>
	else if (lflag)
  800563:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800567:	74 1a                	je     800583 <getint+0x45>
		return va_arg(*ap, long);
  800569:	8b 45 08             	mov    0x8(%ebp),%eax
  80056c:	8b 00                	mov    (%eax),%eax
  80056e:	8d 50 04             	lea    0x4(%eax),%edx
  800571:	8b 45 08             	mov    0x8(%ebp),%eax
  800574:	89 10                	mov    %edx,(%eax)
  800576:	8b 45 08             	mov    0x8(%ebp),%eax
  800579:	8b 00                	mov    (%eax),%eax
  80057b:	83 e8 04             	sub    $0x4,%eax
  80057e:	8b 00                	mov    (%eax),%eax
  800580:	99                   	cltd   
  800581:	eb 18                	jmp    80059b <getint+0x5d>
	else
		return va_arg(*ap, int);
  800583:	8b 45 08             	mov    0x8(%ebp),%eax
  800586:	8b 00                	mov    (%eax),%eax
  800588:	8d 50 04             	lea    0x4(%eax),%edx
  80058b:	8b 45 08             	mov    0x8(%ebp),%eax
  80058e:	89 10                	mov    %edx,(%eax)
  800590:	8b 45 08             	mov    0x8(%ebp),%eax
  800593:	8b 00                	mov    (%eax),%eax
  800595:	83 e8 04             	sub    $0x4,%eax
  800598:	8b 00                	mov    (%eax),%eax
  80059a:	99                   	cltd   
}
  80059b:	5d                   	pop    %ebp
  80059c:	c3                   	ret    

0080059d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80059d:	55                   	push   %ebp
  80059e:	89 e5                	mov    %esp,%ebp
  8005a0:	56                   	push   %esi
  8005a1:	53                   	push   %ebx
  8005a2:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8005a5:	eb 17                	jmp    8005be <vprintfmt+0x21>
			if (ch == '\0')
  8005a7:	85 db                	test   %ebx,%ebx
  8005a9:	0f 84 af 03 00 00    	je     80095e <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8005af:	83 ec 08             	sub    $0x8,%esp
  8005b2:	ff 75 0c             	pushl  0xc(%ebp)
  8005b5:	53                   	push   %ebx
  8005b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b9:	ff d0                	call   *%eax
  8005bb:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8005be:	8b 45 10             	mov    0x10(%ebp),%eax
  8005c1:	8d 50 01             	lea    0x1(%eax),%edx
  8005c4:	89 55 10             	mov    %edx,0x10(%ebp)
  8005c7:	8a 00                	mov    (%eax),%al
  8005c9:	0f b6 d8             	movzbl %al,%ebx
  8005cc:	83 fb 25             	cmp    $0x25,%ebx
  8005cf:	75 d6                	jne    8005a7 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8005d1:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8005d5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8005dc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8005e3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8005ea:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8005f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8005f4:	8d 50 01             	lea    0x1(%eax),%edx
  8005f7:	89 55 10             	mov    %edx,0x10(%ebp)
  8005fa:	8a 00                	mov    (%eax),%al
  8005fc:	0f b6 d8             	movzbl %al,%ebx
  8005ff:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800602:	83 f8 55             	cmp    $0x55,%eax
  800605:	0f 87 2b 03 00 00    	ja     800936 <vprintfmt+0x399>
  80060b:	8b 04 85 b8 20 80 00 	mov    0x8020b8(,%eax,4),%eax
  800612:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800614:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800618:	eb d7                	jmp    8005f1 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80061a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80061e:	eb d1                	jmp    8005f1 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800620:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800627:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80062a:	89 d0                	mov    %edx,%eax
  80062c:	c1 e0 02             	shl    $0x2,%eax
  80062f:	01 d0                	add    %edx,%eax
  800631:	01 c0                	add    %eax,%eax
  800633:	01 d8                	add    %ebx,%eax
  800635:	83 e8 30             	sub    $0x30,%eax
  800638:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80063b:	8b 45 10             	mov    0x10(%ebp),%eax
  80063e:	8a 00                	mov    (%eax),%al
  800640:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800643:	83 fb 2f             	cmp    $0x2f,%ebx
  800646:	7e 3e                	jle    800686 <vprintfmt+0xe9>
  800648:	83 fb 39             	cmp    $0x39,%ebx
  80064b:	7f 39                	jg     800686 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80064d:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800650:	eb d5                	jmp    800627 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800652:	8b 45 14             	mov    0x14(%ebp),%eax
  800655:	83 c0 04             	add    $0x4,%eax
  800658:	89 45 14             	mov    %eax,0x14(%ebp)
  80065b:	8b 45 14             	mov    0x14(%ebp),%eax
  80065e:	83 e8 04             	sub    $0x4,%eax
  800661:	8b 00                	mov    (%eax),%eax
  800663:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800666:	eb 1f                	jmp    800687 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800668:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80066c:	79 83                	jns    8005f1 <vprintfmt+0x54>
				width = 0;
  80066e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800675:	e9 77 ff ff ff       	jmp    8005f1 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80067a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800681:	e9 6b ff ff ff       	jmp    8005f1 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800686:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800687:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80068b:	0f 89 60 ff ff ff    	jns    8005f1 <vprintfmt+0x54>
				width = precision, precision = -1;
  800691:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800694:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800697:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80069e:	e9 4e ff ff ff       	jmp    8005f1 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8006a3:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8006a6:	e9 46 ff ff ff       	jmp    8005f1 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8006ab:	8b 45 14             	mov    0x14(%ebp),%eax
  8006ae:	83 c0 04             	add    $0x4,%eax
  8006b1:	89 45 14             	mov    %eax,0x14(%ebp)
  8006b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8006b7:	83 e8 04             	sub    $0x4,%eax
  8006ba:	8b 00                	mov    (%eax),%eax
  8006bc:	83 ec 08             	sub    $0x8,%esp
  8006bf:	ff 75 0c             	pushl  0xc(%ebp)
  8006c2:	50                   	push   %eax
  8006c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c6:	ff d0                	call   *%eax
  8006c8:	83 c4 10             	add    $0x10,%esp
			break;
  8006cb:	e9 89 02 00 00       	jmp    800959 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8006d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8006d3:	83 c0 04             	add    $0x4,%eax
  8006d6:	89 45 14             	mov    %eax,0x14(%ebp)
  8006d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8006dc:	83 e8 04             	sub    $0x4,%eax
  8006df:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8006e1:	85 db                	test   %ebx,%ebx
  8006e3:	79 02                	jns    8006e7 <vprintfmt+0x14a>
				err = -err;
  8006e5:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8006e7:	83 fb 64             	cmp    $0x64,%ebx
  8006ea:	7f 0b                	jg     8006f7 <vprintfmt+0x15a>
  8006ec:	8b 34 9d 00 1f 80 00 	mov    0x801f00(,%ebx,4),%esi
  8006f3:	85 f6                	test   %esi,%esi
  8006f5:	75 19                	jne    800710 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8006f7:	53                   	push   %ebx
  8006f8:	68 a5 20 80 00       	push   $0x8020a5
  8006fd:	ff 75 0c             	pushl  0xc(%ebp)
  800700:	ff 75 08             	pushl  0x8(%ebp)
  800703:	e8 5e 02 00 00       	call   800966 <printfmt>
  800708:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80070b:	e9 49 02 00 00       	jmp    800959 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800710:	56                   	push   %esi
  800711:	68 ae 20 80 00       	push   $0x8020ae
  800716:	ff 75 0c             	pushl  0xc(%ebp)
  800719:	ff 75 08             	pushl  0x8(%ebp)
  80071c:	e8 45 02 00 00       	call   800966 <printfmt>
  800721:	83 c4 10             	add    $0x10,%esp
			break;
  800724:	e9 30 02 00 00       	jmp    800959 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800729:	8b 45 14             	mov    0x14(%ebp),%eax
  80072c:	83 c0 04             	add    $0x4,%eax
  80072f:	89 45 14             	mov    %eax,0x14(%ebp)
  800732:	8b 45 14             	mov    0x14(%ebp),%eax
  800735:	83 e8 04             	sub    $0x4,%eax
  800738:	8b 30                	mov    (%eax),%esi
  80073a:	85 f6                	test   %esi,%esi
  80073c:	75 05                	jne    800743 <vprintfmt+0x1a6>
				p = "(null)";
  80073e:	be b1 20 80 00       	mov    $0x8020b1,%esi
			if (width > 0 && padc != '-')
  800743:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800747:	7e 6d                	jle    8007b6 <vprintfmt+0x219>
  800749:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80074d:	74 67                	je     8007b6 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80074f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800752:	83 ec 08             	sub    $0x8,%esp
  800755:	50                   	push   %eax
  800756:	56                   	push   %esi
  800757:	e8 12 05 00 00       	call   800c6e <strnlen>
  80075c:	83 c4 10             	add    $0x10,%esp
  80075f:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800762:	eb 16                	jmp    80077a <vprintfmt+0x1dd>
					putch(padc, putdat);
  800764:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800768:	83 ec 08             	sub    $0x8,%esp
  80076b:	ff 75 0c             	pushl  0xc(%ebp)
  80076e:	50                   	push   %eax
  80076f:	8b 45 08             	mov    0x8(%ebp),%eax
  800772:	ff d0                	call   *%eax
  800774:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800777:	ff 4d e4             	decl   -0x1c(%ebp)
  80077a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80077e:	7f e4                	jg     800764 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800780:	eb 34                	jmp    8007b6 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800782:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800786:	74 1c                	je     8007a4 <vprintfmt+0x207>
  800788:	83 fb 1f             	cmp    $0x1f,%ebx
  80078b:	7e 05                	jle    800792 <vprintfmt+0x1f5>
  80078d:	83 fb 7e             	cmp    $0x7e,%ebx
  800790:	7e 12                	jle    8007a4 <vprintfmt+0x207>
					putch('?', putdat);
  800792:	83 ec 08             	sub    $0x8,%esp
  800795:	ff 75 0c             	pushl  0xc(%ebp)
  800798:	6a 3f                	push   $0x3f
  80079a:	8b 45 08             	mov    0x8(%ebp),%eax
  80079d:	ff d0                	call   *%eax
  80079f:	83 c4 10             	add    $0x10,%esp
  8007a2:	eb 0f                	jmp    8007b3 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8007a4:	83 ec 08             	sub    $0x8,%esp
  8007a7:	ff 75 0c             	pushl  0xc(%ebp)
  8007aa:	53                   	push   %ebx
  8007ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ae:	ff d0                	call   *%eax
  8007b0:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8007b3:	ff 4d e4             	decl   -0x1c(%ebp)
  8007b6:	89 f0                	mov    %esi,%eax
  8007b8:	8d 70 01             	lea    0x1(%eax),%esi
  8007bb:	8a 00                	mov    (%eax),%al
  8007bd:	0f be d8             	movsbl %al,%ebx
  8007c0:	85 db                	test   %ebx,%ebx
  8007c2:	74 24                	je     8007e8 <vprintfmt+0x24b>
  8007c4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007c8:	78 b8                	js     800782 <vprintfmt+0x1e5>
  8007ca:	ff 4d e0             	decl   -0x20(%ebp)
  8007cd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007d1:	79 af                	jns    800782 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8007d3:	eb 13                	jmp    8007e8 <vprintfmt+0x24b>
				putch(' ', putdat);
  8007d5:	83 ec 08             	sub    $0x8,%esp
  8007d8:	ff 75 0c             	pushl  0xc(%ebp)
  8007db:	6a 20                	push   $0x20
  8007dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e0:	ff d0                	call   *%eax
  8007e2:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8007e5:	ff 4d e4             	decl   -0x1c(%ebp)
  8007e8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007ec:	7f e7                	jg     8007d5 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8007ee:	e9 66 01 00 00       	jmp    800959 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8007f3:	83 ec 08             	sub    $0x8,%esp
  8007f6:	ff 75 e8             	pushl  -0x18(%ebp)
  8007f9:	8d 45 14             	lea    0x14(%ebp),%eax
  8007fc:	50                   	push   %eax
  8007fd:	e8 3c fd ff ff       	call   80053e <getint>
  800802:	83 c4 10             	add    $0x10,%esp
  800805:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800808:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80080b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80080e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800811:	85 d2                	test   %edx,%edx
  800813:	79 23                	jns    800838 <vprintfmt+0x29b>
				putch('-', putdat);
  800815:	83 ec 08             	sub    $0x8,%esp
  800818:	ff 75 0c             	pushl  0xc(%ebp)
  80081b:	6a 2d                	push   $0x2d
  80081d:	8b 45 08             	mov    0x8(%ebp),%eax
  800820:	ff d0                	call   *%eax
  800822:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800825:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800828:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80082b:	f7 d8                	neg    %eax
  80082d:	83 d2 00             	adc    $0x0,%edx
  800830:	f7 da                	neg    %edx
  800832:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800835:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800838:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80083f:	e9 bc 00 00 00       	jmp    800900 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800844:	83 ec 08             	sub    $0x8,%esp
  800847:	ff 75 e8             	pushl  -0x18(%ebp)
  80084a:	8d 45 14             	lea    0x14(%ebp),%eax
  80084d:	50                   	push   %eax
  80084e:	e8 84 fc ff ff       	call   8004d7 <getuint>
  800853:	83 c4 10             	add    $0x10,%esp
  800856:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800859:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80085c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800863:	e9 98 00 00 00       	jmp    800900 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800868:	83 ec 08             	sub    $0x8,%esp
  80086b:	ff 75 0c             	pushl  0xc(%ebp)
  80086e:	6a 58                	push   $0x58
  800870:	8b 45 08             	mov    0x8(%ebp),%eax
  800873:	ff d0                	call   *%eax
  800875:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800878:	83 ec 08             	sub    $0x8,%esp
  80087b:	ff 75 0c             	pushl  0xc(%ebp)
  80087e:	6a 58                	push   $0x58
  800880:	8b 45 08             	mov    0x8(%ebp),%eax
  800883:	ff d0                	call   *%eax
  800885:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800888:	83 ec 08             	sub    $0x8,%esp
  80088b:	ff 75 0c             	pushl  0xc(%ebp)
  80088e:	6a 58                	push   $0x58
  800890:	8b 45 08             	mov    0x8(%ebp),%eax
  800893:	ff d0                	call   *%eax
  800895:	83 c4 10             	add    $0x10,%esp
			break;
  800898:	e9 bc 00 00 00       	jmp    800959 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80089d:	83 ec 08             	sub    $0x8,%esp
  8008a0:	ff 75 0c             	pushl  0xc(%ebp)
  8008a3:	6a 30                	push   $0x30
  8008a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a8:	ff d0                	call   *%eax
  8008aa:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8008ad:	83 ec 08             	sub    $0x8,%esp
  8008b0:	ff 75 0c             	pushl  0xc(%ebp)
  8008b3:	6a 78                	push   $0x78
  8008b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b8:	ff d0                	call   *%eax
  8008ba:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8008bd:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c0:	83 c0 04             	add    $0x4,%eax
  8008c3:	89 45 14             	mov    %eax,0x14(%ebp)
  8008c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c9:	83 e8 04             	sub    $0x4,%eax
  8008cc:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8008ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8008d8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8008df:	eb 1f                	jmp    800900 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8008e1:	83 ec 08             	sub    $0x8,%esp
  8008e4:	ff 75 e8             	pushl  -0x18(%ebp)
  8008e7:	8d 45 14             	lea    0x14(%ebp),%eax
  8008ea:	50                   	push   %eax
  8008eb:	e8 e7 fb ff ff       	call   8004d7 <getuint>
  8008f0:	83 c4 10             	add    $0x10,%esp
  8008f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008f6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8008f9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800900:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800904:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800907:	83 ec 04             	sub    $0x4,%esp
  80090a:	52                   	push   %edx
  80090b:	ff 75 e4             	pushl  -0x1c(%ebp)
  80090e:	50                   	push   %eax
  80090f:	ff 75 f4             	pushl  -0xc(%ebp)
  800912:	ff 75 f0             	pushl  -0x10(%ebp)
  800915:	ff 75 0c             	pushl  0xc(%ebp)
  800918:	ff 75 08             	pushl  0x8(%ebp)
  80091b:	e8 00 fb ff ff       	call   800420 <printnum>
  800920:	83 c4 20             	add    $0x20,%esp
			break;
  800923:	eb 34                	jmp    800959 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800925:	83 ec 08             	sub    $0x8,%esp
  800928:	ff 75 0c             	pushl  0xc(%ebp)
  80092b:	53                   	push   %ebx
  80092c:	8b 45 08             	mov    0x8(%ebp),%eax
  80092f:	ff d0                	call   *%eax
  800931:	83 c4 10             	add    $0x10,%esp
			break;
  800934:	eb 23                	jmp    800959 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800936:	83 ec 08             	sub    $0x8,%esp
  800939:	ff 75 0c             	pushl  0xc(%ebp)
  80093c:	6a 25                	push   $0x25
  80093e:	8b 45 08             	mov    0x8(%ebp),%eax
  800941:	ff d0                	call   *%eax
  800943:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800946:	ff 4d 10             	decl   0x10(%ebp)
  800949:	eb 03                	jmp    80094e <vprintfmt+0x3b1>
  80094b:	ff 4d 10             	decl   0x10(%ebp)
  80094e:	8b 45 10             	mov    0x10(%ebp),%eax
  800951:	48                   	dec    %eax
  800952:	8a 00                	mov    (%eax),%al
  800954:	3c 25                	cmp    $0x25,%al
  800956:	75 f3                	jne    80094b <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800958:	90                   	nop
		}
	}
  800959:	e9 47 fc ff ff       	jmp    8005a5 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80095e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80095f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800962:	5b                   	pop    %ebx
  800963:	5e                   	pop    %esi
  800964:	5d                   	pop    %ebp
  800965:	c3                   	ret    

00800966 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800966:	55                   	push   %ebp
  800967:	89 e5                	mov    %esp,%ebp
  800969:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80096c:	8d 45 10             	lea    0x10(%ebp),%eax
  80096f:	83 c0 04             	add    $0x4,%eax
  800972:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800975:	8b 45 10             	mov    0x10(%ebp),%eax
  800978:	ff 75 f4             	pushl  -0xc(%ebp)
  80097b:	50                   	push   %eax
  80097c:	ff 75 0c             	pushl  0xc(%ebp)
  80097f:	ff 75 08             	pushl  0x8(%ebp)
  800982:	e8 16 fc ff ff       	call   80059d <vprintfmt>
  800987:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80098a:	90                   	nop
  80098b:	c9                   	leave  
  80098c:	c3                   	ret    

0080098d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80098d:	55                   	push   %ebp
  80098e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800990:	8b 45 0c             	mov    0xc(%ebp),%eax
  800993:	8b 40 08             	mov    0x8(%eax),%eax
  800996:	8d 50 01             	lea    0x1(%eax),%edx
  800999:	8b 45 0c             	mov    0xc(%ebp),%eax
  80099c:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80099f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a2:	8b 10                	mov    (%eax),%edx
  8009a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a7:	8b 40 04             	mov    0x4(%eax),%eax
  8009aa:	39 c2                	cmp    %eax,%edx
  8009ac:	73 12                	jae    8009c0 <sprintputch+0x33>
		*b->buf++ = ch;
  8009ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b1:	8b 00                	mov    (%eax),%eax
  8009b3:	8d 48 01             	lea    0x1(%eax),%ecx
  8009b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009b9:	89 0a                	mov    %ecx,(%edx)
  8009bb:	8b 55 08             	mov    0x8(%ebp),%edx
  8009be:	88 10                	mov    %dl,(%eax)
}
  8009c0:	90                   	nop
  8009c1:	5d                   	pop    %ebp
  8009c2:	c3                   	ret    

008009c3 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8009c3:	55                   	push   %ebp
  8009c4:	89 e5                	mov    %esp,%ebp
  8009c6:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8009c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8009cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8009d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d8:	01 d0                	add    %edx,%eax
  8009da:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8009e4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8009e8:	74 06                	je     8009f0 <vsnprintf+0x2d>
  8009ea:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009ee:	7f 07                	jg     8009f7 <vsnprintf+0x34>
		return -E_INVAL;
  8009f0:	b8 03 00 00 00       	mov    $0x3,%eax
  8009f5:	eb 20                	jmp    800a17 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8009f7:	ff 75 14             	pushl  0x14(%ebp)
  8009fa:	ff 75 10             	pushl  0x10(%ebp)
  8009fd:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800a00:	50                   	push   %eax
  800a01:	68 8d 09 80 00       	push   $0x80098d
  800a06:	e8 92 fb ff ff       	call   80059d <vprintfmt>
  800a0b:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800a0e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a11:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800a14:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800a17:	c9                   	leave  
  800a18:	c3                   	ret    

00800a19 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800a19:	55                   	push   %ebp
  800a1a:	89 e5                	mov    %esp,%ebp
  800a1c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800a1f:	8d 45 10             	lea    0x10(%ebp),%eax
  800a22:	83 c0 04             	add    $0x4,%eax
  800a25:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800a28:	8b 45 10             	mov    0x10(%ebp),%eax
  800a2b:	ff 75 f4             	pushl  -0xc(%ebp)
  800a2e:	50                   	push   %eax
  800a2f:	ff 75 0c             	pushl  0xc(%ebp)
  800a32:	ff 75 08             	pushl  0x8(%ebp)
  800a35:	e8 89 ff ff ff       	call   8009c3 <vsnprintf>
  800a3a:	83 c4 10             	add    $0x10,%esp
  800a3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800a40:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a43:	c9                   	leave  
  800a44:	c3                   	ret    

00800a45 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800a45:	55                   	push   %ebp
  800a46:	89 e5                	mov    %esp,%ebp
  800a48:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  800a4b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a4f:	74 13                	je     800a64 <readline+0x1f>
		cprintf("%s", prompt);
  800a51:	83 ec 08             	sub    $0x8,%esp
  800a54:	ff 75 08             	pushl  0x8(%ebp)
  800a57:	68 10 22 80 00       	push   $0x802210
  800a5c:	e8 62 f9 ff ff       	call   8003c3 <cprintf>
  800a61:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800a64:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800a6b:	83 ec 0c             	sub    $0xc,%esp
  800a6e:	6a 00                	push   $0x0
  800a70:	e8 d1 0f 00 00       	call   801a46 <iscons>
  800a75:	83 c4 10             	add    $0x10,%esp
  800a78:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800a7b:	e8 78 0f 00 00       	call   8019f8 <getchar>
  800a80:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800a83:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a87:	79 22                	jns    800aab <readline+0x66>
			if (c != -E_EOF)
  800a89:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800a8d:	0f 84 ad 00 00 00    	je     800b40 <readline+0xfb>
				cprintf("read error: %e\n", c);
  800a93:	83 ec 08             	sub    $0x8,%esp
  800a96:	ff 75 ec             	pushl  -0x14(%ebp)
  800a99:	68 13 22 80 00       	push   $0x802213
  800a9e:	e8 20 f9 ff ff       	call   8003c3 <cprintf>
  800aa3:	83 c4 10             	add    $0x10,%esp
			return;
  800aa6:	e9 95 00 00 00       	jmp    800b40 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800aab:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800aaf:	7e 34                	jle    800ae5 <readline+0xa0>
  800ab1:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800ab8:	7f 2b                	jg     800ae5 <readline+0xa0>
			if (echoing)
  800aba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800abe:	74 0e                	je     800ace <readline+0x89>
				cputchar(c);
  800ac0:	83 ec 0c             	sub    $0xc,%esp
  800ac3:	ff 75 ec             	pushl  -0x14(%ebp)
  800ac6:	e8 e5 0e 00 00       	call   8019b0 <cputchar>
  800acb:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800ace:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ad1:	8d 50 01             	lea    0x1(%eax),%edx
  800ad4:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800ad7:	89 c2                	mov    %eax,%edx
  800ad9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800adc:	01 d0                	add    %edx,%eax
  800ade:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ae1:	88 10                	mov    %dl,(%eax)
  800ae3:	eb 56                	jmp    800b3b <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  800ae5:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800ae9:	75 1f                	jne    800b0a <readline+0xc5>
  800aeb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800aef:	7e 19                	jle    800b0a <readline+0xc5>
			if (echoing)
  800af1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800af5:	74 0e                	je     800b05 <readline+0xc0>
				cputchar(c);
  800af7:	83 ec 0c             	sub    $0xc,%esp
  800afa:	ff 75 ec             	pushl  -0x14(%ebp)
  800afd:	e8 ae 0e 00 00       	call   8019b0 <cputchar>
  800b02:	83 c4 10             	add    $0x10,%esp

			i--;
  800b05:	ff 4d f4             	decl   -0xc(%ebp)
  800b08:	eb 31                	jmp    800b3b <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800b0a:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800b0e:	74 0a                	je     800b1a <readline+0xd5>
  800b10:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800b14:	0f 85 61 ff ff ff    	jne    800a7b <readline+0x36>
			if (echoing)
  800b1a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b1e:	74 0e                	je     800b2e <readline+0xe9>
				cputchar(c);
  800b20:	83 ec 0c             	sub    $0xc,%esp
  800b23:	ff 75 ec             	pushl  -0x14(%ebp)
  800b26:	e8 85 0e 00 00       	call   8019b0 <cputchar>
  800b2b:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800b2e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b34:	01 d0                	add    %edx,%eax
  800b36:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800b39:	eb 06                	jmp    800b41 <readline+0xfc>
		}
	}
  800b3b:	e9 3b ff ff ff       	jmp    800a7b <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800b40:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800b41:	c9                   	leave  
  800b42:	c3                   	ret    

00800b43 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800b43:	55                   	push   %ebp
  800b44:	89 e5                	mov    %esp,%ebp
  800b46:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800b49:	e8 41 0a 00 00       	call   80158f <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800b4e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b52:	74 13                	je     800b67 <atomic_readline+0x24>
		cprintf("%s", prompt);
  800b54:	83 ec 08             	sub    $0x8,%esp
  800b57:	ff 75 08             	pushl  0x8(%ebp)
  800b5a:	68 10 22 80 00       	push   $0x802210
  800b5f:	e8 5f f8 ff ff       	call   8003c3 <cprintf>
  800b64:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800b67:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800b6e:	83 ec 0c             	sub    $0xc,%esp
  800b71:	6a 00                	push   $0x0
  800b73:	e8 ce 0e 00 00       	call   801a46 <iscons>
  800b78:	83 c4 10             	add    $0x10,%esp
  800b7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800b7e:	e8 75 0e 00 00       	call   8019f8 <getchar>
  800b83:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800b86:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800b8a:	79 23                	jns    800baf <atomic_readline+0x6c>
			if (c != -E_EOF)
  800b8c:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800b90:	74 13                	je     800ba5 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800b92:	83 ec 08             	sub    $0x8,%esp
  800b95:	ff 75 ec             	pushl  -0x14(%ebp)
  800b98:	68 13 22 80 00       	push   $0x802213
  800b9d:	e8 21 f8 ff ff       	call   8003c3 <cprintf>
  800ba2:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800ba5:	e8 ff 09 00 00       	call   8015a9 <sys_enable_interrupt>
			return;
  800baa:	e9 9a 00 00 00       	jmp    800c49 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800baf:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800bb3:	7e 34                	jle    800be9 <atomic_readline+0xa6>
  800bb5:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800bbc:	7f 2b                	jg     800be9 <atomic_readline+0xa6>
			if (echoing)
  800bbe:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800bc2:	74 0e                	je     800bd2 <atomic_readline+0x8f>
				cputchar(c);
  800bc4:	83 ec 0c             	sub    $0xc,%esp
  800bc7:	ff 75 ec             	pushl  -0x14(%ebp)
  800bca:	e8 e1 0d 00 00       	call   8019b0 <cputchar>
  800bcf:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800bd2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800bd5:	8d 50 01             	lea    0x1(%eax),%edx
  800bd8:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800bdb:	89 c2                	mov    %eax,%edx
  800bdd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be0:	01 d0                	add    %edx,%eax
  800be2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800be5:	88 10                	mov    %dl,(%eax)
  800be7:	eb 5b                	jmp    800c44 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800be9:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800bed:	75 1f                	jne    800c0e <atomic_readline+0xcb>
  800bef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800bf3:	7e 19                	jle    800c0e <atomic_readline+0xcb>
			if (echoing)
  800bf5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800bf9:	74 0e                	je     800c09 <atomic_readline+0xc6>
				cputchar(c);
  800bfb:	83 ec 0c             	sub    $0xc,%esp
  800bfe:	ff 75 ec             	pushl  -0x14(%ebp)
  800c01:	e8 aa 0d 00 00       	call   8019b0 <cputchar>
  800c06:	83 c4 10             	add    $0x10,%esp
			i--;
  800c09:	ff 4d f4             	decl   -0xc(%ebp)
  800c0c:	eb 36                	jmp    800c44 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800c0e:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800c12:	74 0a                	je     800c1e <atomic_readline+0xdb>
  800c14:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800c18:	0f 85 60 ff ff ff    	jne    800b7e <atomic_readline+0x3b>
			if (echoing)
  800c1e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800c22:	74 0e                	je     800c32 <atomic_readline+0xef>
				cputchar(c);
  800c24:	83 ec 0c             	sub    $0xc,%esp
  800c27:	ff 75 ec             	pushl  -0x14(%ebp)
  800c2a:	e8 81 0d 00 00       	call   8019b0 <cputchar>
  800c2f:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800c32:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c38:	01 d0                	add    %edx,%eax
  800c3a:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800c3d:	e8 67 09 00 00       	call   8015a9 <sys_enable_interrupt>
			return;
  800c42:	eb 05                	jmp    800c49 <atomic_readline+0x106>
		}
	}
  800c44:	e9 35 ff ff ff       	jmp    800b7e <atomic_readline+0x3b>
}
  800c49:	c9                   	leave  
  800c4a:	c3                   	ret    

00800c4b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c4b:	55                   	push   %ebp
  800c4c:	89 e5                	mov    %esp,%ebp
  800c4e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c51:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c58:	eb 06                	jmp    800c60 <strlen+0x15>
		n++;
  800c5a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c5d:	ff 45 08             	incl   0x8(%ebp)
  800c60:	8b 45 08             	mov    0x8(%ebp),%eax
  800c63:	8a 00                	mov    (%eax),%al
  800c65:	84 c0                	test   %al,%al
  800c67:	75 f1                	jne    800c5a <strlen+0xf>
		n++;
	return n;
  800c69:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c6c:	c9                   	leave  
  800c6d:	c3                   	ret    

00800c6e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c6e:	55                   	push   %ebp
  800c6f:	89 e5                	mov    %esp,%ebp
  800c71:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c74:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c7b:	eb 09                	jmp    800c86 <strnlen+0x18>
		n++;
  800c7d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c80:	ff 45 08             	incl   0x8(%ebp)
  800c83:	ff 4d 0c             	decl   0xc(%ebp)
  800c86:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c8a:	74 09                	je     800c95 <strnlen+0x27>
  800c8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8f:	8a 00                	mov    (%eax),%al
  800c91:	84 c0                	test   %al,%al
  800c93:	75 e8                	jne    800c7d <strnlen+0xf>
		n++;
	return n;
  800c95:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c98:	c9                   	leave  
  800c99:	c3                   	ret    

00800c9a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c9a:	55                   	push   %ebp
  800c9b:	89 e5                	mov    %esp,%ebp
  800c9d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ca6:	90                   	nop
  800ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  800caa:	8d 50 01             	lea    0x1(%eax),%edx
  800cad:	89 55 08             	mov    %edx,0x8(%ebp)
  800cb0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cb3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cb6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cb9:	8a 12                	mov    (%edx),%dl
  800cbb:	88 10                	mov    %dl,(%eax)
  800cbd:	8a 00                	mov    (%eax),%al
  800cbf:	84 c0                	test   %al,%al
  800cc1:	75 e4                	jne    800ca7 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800cc3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cc6:	c9                   	leave  
  800cc7:	c3                   	ret    

00800cc8 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800cc8:	55                   	push   %ebp
  800cc9:	89 e5                	mov    %esp,%ebp
  800ccb:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800cce:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800cd4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cdb:	eb 1f                	jmp    800cfc <strncpy+0x34>
		*dst++ = *src;
  800cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce0:	8d 50 01             	lea    0x1(%eax),%edx
  800ce3:	89 55 08             	mov    %edx,0x8(%ebp)
  800ce6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ce9:	8a 12                	mov    (%edx),%dl
  800ceb:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800ced:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf0:	8a 00                	mov    (%eax),%al
  800cf2:	84 c0                	test   %al,%al
  800cf4:	74 03                	je     800cf9 <strncpy+0x31>
			src++;
  800cf6:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800cf9:	ff 45 fc             	incl   -0x4(%ebp)
  800cfc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cff:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d02:	72 d9                	jb     800cdd <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d04:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d07:	c9                   	leave  
  800d08:	c3                   	ret    

00800d09 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d09:	55                   	push   %ebp
  800d0a:	89 e5                	mov    %esp,%ebp
  800d0c:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d12:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d15:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d19:	74 30                	je     800d4b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d1b:	eb 16                	jmp    800d33 <strlcpy+0x2a>
			*dst++ = *src++;
  800d1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d20:	8d 50 01             	lea    0x1(%eax),%edx
  800d23:	89 55 08             	mov    %edx,0x8(%ebp)
  800d26:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d29:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d2c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d2f:	8a 12                	mov    (%edx),%dl
  800d31:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d33:	ff 4d 10             	decl   0x10(%ebp)
  800d36:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d3a:	74 09                	je     800d45 <strlcpy+0x3c>
  800d3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d3f:	8a 00                	mov    (%eax),%al
  800d41:	84 c0                	test   %al,%al
  800d43:	75 d8                	jne    800d1d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
  800d48:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d4b:	8b 55 08             	mov    0x8(%ebp),%edx
  800d4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d51:	29 c2                	sub    %eax,%edx
  800d53:	89 d0                	mov    %edx,%eax
}
  800d55:	c9                   	leave  
  800d56:	c3                   	ret    

00800d57 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d57:	55                   	push   %ebp
  800d58:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d5a:	eb 06                	jmp    800d62 <strcmp+0xb>
		p++, q++;
  800d5c:	ff 45 08             	incl   0x8(%ebp)
  800d5f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d62:	8b 45 08             	mov    0x8(%ebp),%eax
  800d65:	8a 00                	mov    (%eax),%al
  800d67:	84 c0                	test   %al,%al
  800d69:	74 0e                	je     800d79 <strcmp+0x22>
  800d6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6e:	8a 10                	mov    (%eax),%dl
  800d70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d73:	8a 00                	mov    (%eax),%al
  800d75:	38 c2                	cmp    %al,%dl
  800d77:	74 e3                	je     800d5c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d79:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7c:	8a 00                	mov    (%eax),%al
  800d7e:	0f b6 d0             	movzbl %al,%edx
  800d81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d84:	8a 00                	mov    (%eax),%al
  800d86:	0f b6 c0             	movzbl %al,%eax
  800d89:	29 c2                	sub    %eax,%edx
  800d8b:	89 d0                	mov    %edx,%eax
}
  800d8d:	5d                   	pop    %ebp
  800d8e:	c3                   	ret    

00800d8f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d8f:	55                   	push   %ebp
  800d90:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d92:	eb 09                	jmp    800d9d <strncmp+0xe>
		n--, p++, q++;
  800d94:	ff 4d 10             	decl   0x10(%ebp)
  800d97:	ff 45 08             	incl   0x8(%ebp)
  800d9a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d9d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800da1:	74 17                	je     800dba <strncmp+0x2b>
  800da3:	8b 45 08             	mov    0x8(%ebp),%eax
  800da6:	8a 00                	mov    (%eax),%al
  800da8:	84 c0                	test   %al,%al
  800daa:	74 0e                	je     800dba <strncmp+0x2b>
  800dac:	8b 45 08             	mov    0x8(%ebp),%eax
  800daf:	8a 10                	mov    (%eax),%dl
  800db1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db4:	8a 00                	mov    (%eax),%al
  800db6:	38 c2                	cmp    %al,%dl
  800db8:	74 da                	je     800d94 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800dba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dbe:	75 07                	jne    800dc7 <strncmp+0x38>
		return 0;
  800dc0:	b8 00 00 00 00       	mov    $0x0,%eax
  800dc5:	eb 14                	jmp    800ddb <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dca:	8a 00                	mov    (%eax),%al
  800dcc:	0f b6 d0             	movzbl %al,%edx
  800dcf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd2:	8a 00                	mov    (%eax),%al
  800dd4:	0f b6 c0             	movzbl %al,%eax
  800dd7:	29 c2                	sub    %eax,%edx
  800dd9:	89 d0                	mov    %edx,%eax
}
  800ddb:	5d                   	pop    %ebp
  800ddc:	c3                   	ret    

00800ddd <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ddd:	55                   	push   %ebp
  800dde:	89 e5                	mov    %esp,%ebp
  800de0:	83 ec 04             	sub    $0x4,%esp
  800de3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800de9:	eb 12                	jmp    800dfd <strchr+0x20>
		if (*s == c)
  800deb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dee:	8a 00                	mov    (%eax),%al
  800df0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800df3:	75 05                	jne    800dfa <strchr+0x1d>
			return (char *) s;
  800df5:	8b 45 08             	mov    0x8(%ebp),%eax
  800df8:	eb 11                	jmp    800e0b <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800dfa:	ff 45 08             	incl   0x8(%ebp)
  800dfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800e00:	8a 00                	mov    (%eax),%al
  800e02:	84 c0                	test   %al,%al
  800e04:	75 e5                	jne    800deb <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e06:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e0b:	c9                   	leave  
  800e0c:	c3                   	ret    

00800e0d <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e0d:	55                   	push   %ebp
  800e0e:	89 e5                	mov    %esp,%ebp
  800e10:	83 ec 04             	sub    $0x4,%esp
  800e13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e16:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e19:	eb 0d                	jmp    800e28 <strfind+0x1b>
		if (*s == c)
  800e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1e:	8a 00                	mov    (%eax),%al
  800e20:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e23:	74 0e                	je     800e33 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e25:	ff 45 08             	incl   0x8(%ebp)
  800e28:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2b:	8a 00                	mov    (%eax),%al
  800e2d:	84 c0                	test   %al,%al
  800e2f:	75 ea                	jne    800e1b <strfind+0xe>
  800e31:	eb 01                	jmp    800e34 <strfind+0x27>
		if (*s == c)
			break;
  800e33:	90                   	nop
	return (char *) s;
  800e34:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e37:	c9                   	leave  
  800e38:	c3                   	ret    

00800e39 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e39:	55                   	push   %ebp
  800e3a:	89 e5                	mov    %esp,%ebp
  800e3c:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e42:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e45:	8b 45 10             	mov    0x10(%ebp),%eax
  800e48:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e4b:	eb 0e                	jmp    800e5b <memset+0x22>
		*p++ = c;
  800e4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e50:	8d 50 01             	lea    0x1(%eax),%edx
  800e53:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e56:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e59:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e5b:	ff 4d f8             	decl   -0x8(%ebp)
  800e5e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e62:	79 e9                	jns    800e4d <memset+0x14>
		*p++ = c;

	return v;
  800e64:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e67:	c9                   	leave  
  800e68:	c3                   	ret    

00800e69 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e69:	55                   	push   %ebp
  800e6a:	89 e5                	mov    %esp,%ebp
  800e6c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e72:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e75:	8b 45 08             	mov    0x8(%ebp),%eax
  800e78:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e7b:	eb 16                	jmp    800e93 <memcpy+0x2a>
		*d++ = *s++;
  800e7d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e80:	8d 50 01             	lea    0x1(%eax),%edx
  800e83:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e86:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e89:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e8c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e8f:	8a 12                	mov    (%edx),%dl
  800e91:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e93:	8b 45 10             	mov    0x10(%ebp),%eax
  800e96:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e99:	89 55 10             	mov    %edx,0x10(%ebp)
  800e9c:	85 c0                	test   %eax,%eax
  800e9e:	75 dd                	jne    800e7d <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ea0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ea3:	c9                   	leave  
  800ea4:	c3                   	ret    

00800ea5 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ea5:	55                   	push   %ebp
  800ea6:	89 e5                	mov    %esp,%ebp
  800ea8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800eab:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800eb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800eb7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ebd:	73 50                	jae    800f0f <memmove+0x6a>
  800ebf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ec2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec5:	01 d0                	add    %edx,%eax
  800ec7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800eca:	76 43                	jbe    800f0f <memmove+0x6a>
		s += n;
  800ecc:	8b 45 10             	mov    0x10(%ebp),%eax
  800ecf:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ed2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed5:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ed8:	eb 10                	jmp    800eea <memmove+0x45>
			*--d = *--s;
  800eda:	ff 4d f8             	decl   -0x8(%ebp)
  800edd:	ff 4d fc             	decl   -0x4(%ebp)
  800ee0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ee3:	8a 10                	mov    (%eax),%dl
  800ee5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ee8:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800eea:	8b 45 10             	mov    0x10(%ebp),%eax
  800eed:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ef0:	89 55 10             	mov    %edx,0x10(%ebp)
  800ef3:	85 c0                	test   %eax,%eax
  800ef5:	75 e3                	jne    800eda <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ef7:	eb 23                	jmp    800f1c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ef9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800efc:	8d 50 01             	lea    0x1(%eax),%edx
  800eff:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f02:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f05:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f08:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f0b:	8a 12                	mov    (%edx),%dl
  800f0d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800f0f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f12:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f15:	89 55 10             	mov    %edx,0x10(%ebp)
  800f18:	85 c0                	test   %eax,%eax
  800f1a:	75 dd                	jne    800ef9 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f1c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f1f:	c9                   	leave  
  800f20:	c3                   	ret    

00800f21 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800f21:	55                   	push   %ebp
  800f22:	89 e5                	mov    %esp,%ebp
  800f24:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f27:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f30:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f33:	eb 2a                	jmp    800f5f <memcmp+0x3e>
		if (*s1 != *s2)
  800f35:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f38:	8a 10                	mov    (%eax),%dl
  800f3a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f3d:	8a 00                	mov    (%eax),%al
  800f3f:	38 c2                	cmp    %al,%dl
  800f41:	74 16                	je     800f59 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f43:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f46:	8a 00                	mov    (%eax),%al
  800f48:	0f b6 d0             	movzbl %al,%edx
  800f4b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f4e:	8a 00                	mov    (%eax),%al
  800f50:	0f b6 c0             	movzbl %al,%eax
  800f53:	29 c2                	sub    %eax,%edx
  800f55:	89 d0                	mov    %edx,%eax
  800f57:	eb 18                	jmp    800f71 <memcmp+0x50>
		s1++, s2++;
  800f59:	ff 45 fc             	incl   -0x4(%ebp)
  800f5c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f5f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f62:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f65:	89 55 10             	mov    %edx,0x10(%ebp)
  800f68:	85 c0                	test   %eax,%eax
  800f6a:	75 c9                	jne    800f35 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f6c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f71:	c9                   	leave  
  800f72:	c3                   	ret    

00800f73 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f73:	55                   	push   %ebp
  800f74:	89 e5                	mov    %esp,%ebp
  800f76:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f79:	8b 55 08             	mov    0x8(%ebp),%edx
  800f7c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7f:	01 d0                	add    %edx,%eax
  800f81:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f84:	eb 15                	jmp    800f9b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
  800f89:	8a 00                	mov    (%eax),%al
  800f8b:	0f b6 d0             	movzbl %al,%edx
  800f8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f91:	0f b6 c0             	movzbl %al,%eax
  800f94:	39 c2                	cmp    %eax,%edx
  800f96:	74 0d                	je     800fa5 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f98:	ff 45 08             	incl   0x8(%ebp)
  800f9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800fa1:	72 e3                	jb     800f86 <memfind+0x13>
  800fa3:	eb 01                	jmp    800fa6 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800fa5:	90                   	nop
	return (void *) s;
  800fa6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fa9:	c9                   	leave  
  800faa:	c3                   	ret    

00800fab <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800fab:	55                   	push   %ebp
  800fac:	89 e5                	mov    %esp,%ebp
  800fae:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800fb1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800fb8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fbf:	eb 03                	jmp    800fc4 <strtol+0x19>
		s++;
  800fc1:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc7:	8a 00                	mov    (%eax),%al
  800fc9:	3c 20                	cmp    $0x20,%al
  800fcb:	74 f4                	je     800fc1 <strtol+0x16>
  800fcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd0:	8a 00                	mov    (%eax),%al
  800fd2:	3c 09                	cmp    $0x9,%al
  800fd4:	74 eb                	je     800fc1 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800fd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd9:	8a 00                	mov    (%eax),%al
  800fdb:	3c 2b                	cmp    $0x2b,%al
  800fdd:	75 05                	jne    800fe4 <strtol+0x39>
		s++;
  800fdf:	ff 45 08             	incl   0x8(%ebp)
  800fe2:	eb 13                	jmp    800ff7 <strtol+0x4c>
	else if (*s == '-')
  800fe4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe7:	8a 00                	mov    (%eax),%al
  800fe9:	3c 2d                	cmp    $0x2d,%al
  800feb:	75 0a                	jne    800ff7 <strtol+0x4c>
		s++, neg = 1;
  800fed:	ff 45 08             	incl   0x8(%ebp)
  800ff0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ff7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ffb:	74 06                	je     801003 <strtol+0x58>
  800ffd:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801001:	75 20                	jne    801023 <strtol+0x78>
  801003:	8b 45 08             	mov    0x8(%ebp),%eax
  801006:	8a 00                	mov    (%eax),%al
  801008:	3c 30                	cmp    $0x30,%al
  80100a:	75 17                	jne    801023 <strtol+0x78>
  80100c:	8b 45 08             	mov    0x8(%ebp),%eax
  80100f:	40                   	inc    %eax
  801010:	8a 00                	mov    (%eax),%al
  801012:	3c 78                	cmp    $0x78,%al
  801014:	75 0d                	jne    801023 <strtol+0x78>
		s += 2, base = 16;
  801016:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80101a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801021:	eb 28                	jmp    80104b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801023:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801027:	75 15                	jne    80103e <strtol+0x93>
  801029:	8b 45 08             	mov    0x8(%ebp),%eax
  80102c:	8a 00                	mov    (%eax),%al
  80102e:	3c 30                	cmp    $0x30,%al
  801030:	75 0c                	jne    80103e <strtol+0x93>
		s++, base = 8;
  801032:	ff 45 08             	incl   0x8(%ebp)
  801035:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80103c:	eb 0d                	jmp    80104b <strtol+0xa0>
	else if (base == 0)
  80103e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801042:	75 07                	jne    80104b <strtol+0xa0>
		base = 10;
  801044:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80104b:	8b 45 08             	mov    0x8(%ebp),%eax
  80104e:	8a 00                	mov    (%eax),%al
  801050:	3c 2f                	cmp    $0x2f,%al
  801052:	7e 19                	jle    80106d <strtol+0xc2>
  801054:	8b 45 08             	mov    0x8(%ebp),%eax
  801057:	8a 00                	mov    (%eax),%al
  801059:	3c 39                	cmp    $0x39,%al
  80105b:	7f 10                	jg     80106d <strtol+0xc2>
			dig = *s - '0';
  80105d:	8b 45 08             	mov    0x8(%ebp),%eax
  801060:	8a 00                	mov    (%eax),%al
  801062:	0f be c0             	movsbl %al,%eax
  801065:	83 e8 30             	sub    $0x30,%eax
  801068:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80106b:	eb 42                	jmp    8010af <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
  801070:	8a 00                	mov    (%eax),%al
  801072:	3c 60                	cmp    $0x60,%al
  801074:	7e 19                	jle    80108f <strtol+0xe4>
  801076:	8b 45 08             	mov    0x8(%ebp),%eax
  801079:	8a 00                	mov    (%eax),%al
  80107b:	3c 7a                	cmp    $0x7a,%al
  80107d:	7f 10                	jg     80108f <strtol+0xe4>
			dig = *s - 'a' + 10;
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	8a 00                	mov    (%eax),%al
  801084:	0f be c0             	movsbl %al,%eax
  801087:	83 e8 57             	sub    $0x57,%eax
  80108a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80108d:	eb 20                	jmp    8010af <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80108f:	8b 45 08             	mov    0x8(%ebp),%eax
  801092:	8a 00                	mov    (%eax),%al
  801094:	3c 40                	cmp    $0x40,%al
  801096:	7e 39                	jle    8010d1 <strtol+0x126>
  801098:	8b 45 08             	mov    0x8(%ebp),%eax
  80109b:	8a 00                	mov    (%eax),%al
  80109d:	3c 5a                	cmp    $0x5a,%al
  80109f:	7f 30                	jg     8010d1 <strtol+0x126>
			dig = *s - 'A' + 10;
  8010a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a4:	8a 00                	mov    (%eax),%al
  8010a6:	0f be c0             	movsbl %al,%eax
  8010a9:	83 e8 37             	sub    $0x37,%eax
  8010ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8010af:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010b2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010b5:	7d 19                	jge    8010d0 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8010b7:	ff 45 08             	incl   0x8(%ebp)
  8010ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010bd:	0f af 45 10          	imul   0x10(%ebp),%eax
  8010c1:	89 c2                	mov    %eax,%edx
  8010c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010c6:	01 d0                	add    %edx,%eax
  8010c8:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8010cb:	e9 7b ff ff ff       	jmp    80104b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8010d0:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8010d1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010d5:	74 08                	je     8010df <strtol+0x134>
		*endptr = (char *) s;
  8010d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010da:	8b 55 08             	mov    0x8(%ebp),%edx
  8010dd:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8010df:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010e3:	74 07                	je     8010ec <strtol+0x141>
  8010e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010e8:	f7 d8                	neg    %eax
  8010ea:	eb 03                	jmp    8010ef <strtol+0x144>
  8010ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010ef:	c9                   	leave  
  8010f0:	c3                   	ret    

008010f1 <ltostr>:

void
ltostr(long value, char *str)
{
  8010f1:	55                   	push   %ebp
  8010f2:	89 e5                	mov    %esp,%ebp
  8010f4:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8010f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8010fe:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801105:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801109:	79 13                	jns    80111e <ltostr+0x2d>
	{
		neg = 1;
  80110b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801112:	8b 45 0c             	mov    0xc(%ebp),%eax
  801115:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801118:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80111b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80111e:	8b 45 08             	mov    0x8(%ebp),%eax
  801121:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801126:	99                   	cltd   
  801127:	f7 f9                	idiv   %ecx
  801129:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80112c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80112f:	8d 50 01             	lea    0x1(%eax),%edx
  801132:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801135:	89 c2                	mov    %eax,%edx
  801137:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113a:	01 d0                	add    %edx,%eax
  80113c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80113f:	83 c2 30             	add    $0x30,%edx
  801142:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801144:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801147:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80114c:	f7 e9                	imul   %ecx
  80114e:	c1 fa 02             	sar    $0x2,%edx
  801151:	89 c8                	mov    %ecx,%eax
  801153:	c1 f8 1f             	sar    $0x1f,%eax
  801156:	29 c2                	sub    %eax,%edx
  801158:	89 d0                	mov    %edx,%eax
  80115a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80115d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801160:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801165:	f7 e9                	imul   %ecx
  801167:	c1 fa 02             	sar    $0x2,%edx
  80116a:	89 c8                	mov    %ecx,%eax
  80116c:	c1 f8 1f             	sar    $0x1f,%eax
  80116f:	29 c2                	sub    %eax,%edx
  801171:	89 d0                	mov    %edx,%eax
  801173:	c1 e0 02             	shl    $0x2,%eax
  801176:	01 d0                	add    %edx,%eax
  801178:	01 c0                	add    %eax,%eax
  80117a:	29 c1                	sub    %eax,%ecx
  80117c:	89 ca                	mov    %ecx,%edx
  80117e:	85 d2                	test   %edx,%edx
  801180:	75 9c                	jne    80111e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801182:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801189:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80118c:	48                   	dec    %eax
  80118d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801190:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801194:	74 3d                	je     8011d3 <ltostr+0xe2>
		start = 1 ;
  801196:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80119d:	eb 34                	jmp    8011d3 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80119f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a5:	01 d0                	add    %edx,%eax
  8011a7:	8a 00                	mov    (%eax),%al
  8011a9:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8011ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b2:	01 c2                	add    %eax,%edx
  8011b4:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8011b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ba:	01 c8                	add    %ecx,%eax
  8011bc:	8a 00                	mov    (%eax),%al
  8011be:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8011c0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8011c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c6:	01 c2                	add    %eax,%edx
  8011c8:	8a 45 eb             	mov    -0x15(%ebp),%al
  8011cb:	88 02                	mov    %al,(%edx)
		start++ ;
  8011cd:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8011d0:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8011d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011d6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011d9:	7c c4                	jl     80119f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8011db:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8011de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e1:	01 d0                	add    %edx,%eax
  8011e3:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8011e6:	90                   	nop
  8011e7:	c9                   	leave  
  8011e8:	c3                   	ret    

008011e9 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8011e9:	55                   	push   %ebp
  8011ea:	89 e5                	mov    %esp,%ebp
  8011ec:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8011ef:	ff 75 08             	pushl  0x8(%ebp)
  8011f2:	e8 54 fa ff ff       	call   800c4b <strlen>
  8011f7:	83 c4 04             	add    $0x4,%esp
  8011fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8011fd:	ff 75 0c             	pushl  0xc(%ebp)
  801200:	e8 46 fa ff ff       	call   800c4b <strlen>
  801205:	83 c4 04             	add    $0x4,%esp
  801208:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80120b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801212:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801219:	eb 17                	jmp    801232 <strcconcat+0x49>
		final[s] = str1[s] ;
  80121b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80121e:	8b 45 10             	mov    0x10(%ebp),%eax
  801221:	01 c2                	add    %eax,%edx
  801223:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801226:	8b 45 08             	mov    0x8(%ebp),%eax
  801229:	01 c8                	add    %ecx,%eax
  80122b:	8a 00                	mov    (%eax),%al
  80122d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80122f:	ff 45 fc             	incl   -0x4(%ebp)
  801232:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801235:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801238:	7c e1                	jl     80121b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80123a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801241:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801248:	eb 1f                	jmp    801269 <strcconcat+0x80>
		final[s++] = str2[i] ;
  80124a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80124d:	8d 50 01             	lea    0x1(%eax),%edx
  801250:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801253:	89 c2                	mov    %eax,%edx
  801255:	8b 45 10             	mov    0x10(%ebp),%eax
  801258:	01 c2                	add    %eax,%edx
  80125a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80125d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801260:	01 c8                	add    %ecx,%eax
  801262:	8a 00                	mov    (%eax),%al
  801264:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801266:	ff 45 f8             	incl   -0x8(%ebp)
  801269:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80126c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80126f:	7c d9                	jl     80124a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801271:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801274:	8b 45 10             	mov    0x10(%ebp),%eax
  801277:	01 d0                	add    %edx,%eax
  801279:	c6 00 00             	movb   $0x0,(%eax)
}
  80127c:	90                   	nop
  80127d:	c9                   	leave  
  80127e:	c3                   	ret    

0080127f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80127f:	55                   	push   %ebp
  801280:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801282:	8b 45 14             	mov    0x14(%ebp),%eax
  801285:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80128b:	8b 45 14             	mov    0x14(%ebp),%eax
  80128e:	8b 00                	mov    (%eax),%eax
  801290:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801297:	8b 45 10             	mov    0x10(%ebp),%eax
  80129a:	01 d0                	add    %edx,%eax
  80129c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012a2:	eb 0c                	jmp    8012b0 <strsplit+0x31>
			*string++ = 0;
  8012a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a7:	8d 50 01             	lea    0x1(%eax),%edx
  8012aa:	89 55 08             	mov    %edx,0x8(%ebp)
  8012ad:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b3:	8a 00                	mov    (%eax),%al
  8012b5:	84 c0                	test   %al,%al
  8012b7:	74 18                	je     8012d1 <strsplit+0x52>
  8012b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bc:	8a 00                	mov    (%eax),%al
  8012be:	0f be c0             	movsbl %al,%eax
  8012c1:	50                   	push   %eax
  8012c2:	ff 75 0c             	pushl  0xc(%ebp)
  8012c5:	e8 13 fb ff ff       	call   800ddd <strchr>
  8012ca:	83 c4 08             	add    $0x8,%esp
  8012cd:	85 c0                	test   %eax,%eax
  8012cf:	75 d3                	jne    8012a4 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8012d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d4:	8a 00                	mov    (%eax),%al
  8012d6:	84 c0                	test   %al,%al
  8012d8:	74 5a                	je     801334 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8012da:	8b 45 14             	mov    0x14(%ebp),%eax
  8012dd:	8b 00                	mov    (%eax),%eax
  8012df:	83 f8 0f             	cmp    $0xf,%eax
  8012e2:	75 07                	jne    8012eb <strsplit+0x6c>
		{
			return 0;
  8012e4:	b8 00 00 00 00       	mov    $0x0,%eax
  8012e9:	eb 66                	jmp    801351 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8012eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8012ee:	8b 00                	mov    (%eax),%eax
  8012f0:	8d 48 01             	lea    0x1(%eax),%ecx
  8012f3:	8b 55 14             	mov    0x14(%ebp),%edx
  8012f6:	89 0a                	mov    %ecx,(%edx)
  8012f8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801302:	01 c2                	add    %eax,%edx
  801304:	8b 45 08             	mov    0x8(%ebp),%eax
  801307:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801309:	eb 03                	jmp    80130e <strsplit+0x8f>
			string++;
  80130b:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80130e:	8b 45 08             	mov    0x8(%ebp),%eax
  801311:	8a 00                	mov    (%eax),%al
  801313:	84 c0                	test   %al,%al
  801315:	74 8b                	je     8012a2 <strsplit+0x23>
  801317:	8b 45 08             	mov    0x8(%ebp),%eax
  80131a:	8a 00                	mov    (%eax),%al
  80131c:	0f be c0             	movsbl %al,%eax
  80131f:	50                   	push   %eax
  801320:	ff 75 0c             	pushl  0xc(%ebp)
  801323:	e8 b5 fa ff ff       	call   800ddd <strchr>
  801328:	83 c4 08             	add    $0x8,%esp
  80132b:	85 c0                	test   %eax,%eax
  80132d:	74 dc                	je     80130b <strsplit+0x8c>
			string++;
	}
  80132f:	e9 6e ff ff ff       	jmp    8012a2 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801334:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801335:	8b 45 14             	mov    0x14(%ebp),%eax
  801338:	8b 00                	mov    (%eax),%eax
  80133a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801341:	8b 45 10             	mov    0x10(%ebp),%eax
  801344:	01 d0                	add    %edx,%eax
  801346:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80134c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801351:	c9                   	leave  
  801352:	c3                   	ret    

00801353 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801353:	55                   	push   %ebp
  801354:	89 e5                	mov    %esp,%ebp
  801356:	57                   	push   %edi
  801357:	56                   	push   %esi
  801358:	53                   	push   %ebx
  801359:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80135c:	8b 45 08             	mov    0x8(%ebp),%eax
  80135f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801362:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801365:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801368:	8b 7d 18             	mov    0x18(%ebp),%edi
  80136b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80136e:	cd 30                	int    $0x30
  801370:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801373:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801376:	83 c4 10             	add    $0x10,%esp
  801379:	5b                   	pop    %ebx
  80137a:	5e                   	pop    %esi
  80137b:	5f                   	pop    %edi
  80137c:	5d                   	pop    %ebp
  80137d:	c3                   	ret    

0080137e <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80137e:	55                   	push   %ebp
  80137f:	89 e5                	mov    %esp,%ebp
  801381:	83 ec 04             	sub    $0x4,%esp
  801384:	8b 45 10             	mov    0x10(%ebp),%eax
  801387:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80138a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	6a 00                	push   $0x0
  801393:	6a 00                	push   $0x0
  801395:	52                   	push   %edx
  801396:	ff 75 0c             	pushl  0xc(%ebp)
  801399:	50                   	push   %eax
  80139a:	6a 00                	push   $0x0
  80139c:	e8 b2 ff ff ff       	call   801353 <syscall>
  8013a1:	83 c4 18             	add    $0x18,%esp
}
  8013a4:	90                   	nop
  8013a5:	c9                   	leave  
  8013a6:	c3                   	ret    

008013a7 <sys_cgetc>:

int
sys_cgetc(void)
{
  8013a7:	55                   	push   %ebp
  8013a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8013aa:	6a 00                	push   $0x0
  8013ac:	6a 00                	push   $0x0
  8013ae:	6a 00                	push   $0x0
  8013b0:	6a 00                	push   $0x0
  8013b2:	6a 00                	push   $0x0
  8013b4:	6a 01                	push   $0x1
  8013b6:	e8 98 ff ff ff       	call   801353 <syscall>
  8013bb:	83 c4 18             	add    $0x18,%esp
}
  8013be:	c9                   	leave  
  8013bf:	c3                   	ret    

008013c0 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8013c0:	55                   	push   %ebp
  8013c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8013c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c6:	6a 00                	push   $0x0
  8013c8:	6a 00                	push   $0x0
  8013ca:	6a 00                	push   $0x0
  8013cc:	6a 00                	push   $0x0
  8013ce:	50                   	push   %eax
  8013cf:	6a 05                	push   $0x5
  8013d1:	e8 7d ff ff ff       	call   801353 <syscall>
  8013d6:	83 c4 18             	add    $0x18,%esp
}
  8013d9:	c9                   	leave  
  8013da:	c3                   	ret    

008013db <sys_getenvid>:

int32 sys_getenvid(void)
{
  8013db:	55                   	push   %ebp
  8013dc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8013de:	6a 00                	push   $0x0
  8013e0:	6a 00                	push   $0x0
  8013e2:	6a 00                	push   $0x0
  8013e4:	6a 00                	push   $0x0
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 02                	push   $0x2
  8013ea:	e8 64 ff ff ff       	call   801353 <syscall>
  8013ef:	83 c4 18             	add    $0x18,%esp
}
  8013f2:	c9                   	leave  
  8013f3:	c3                   	ret    

008013f4 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8013f4:	55                   	push   %ebp
  8013f5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 00                	push   $0x0
  801401:	6a 03                	push   $0x3
  801403:	e8 4b ff ff ff       	call   801353 <syscall>
  801408:	83 c4 18             	add    $0x18,%esp
}
  80140b:	c9                   	leave  
  80140c:	c3                   	ret    

0080140d <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80140d:	55                   	push   %ebp
  80140e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801410:	6a 00                	push   $0x0
  801412:	6a 00                	push   $0x0
  801414:	6a 00                	push   $0x0
  801416:	6a 00                	push   $0x0
  801418:	6a 00                	push   $0x0
  80141a:	6a 04                	push   $0x4
  80141c:	e8 32 ff ff ff       	call   801353 <syscall>
  801421:	83 c4 18             	add    $0x18,%esp
}
  801424:	c9                   	leave  
  801425:	c3                   	ret    

00801426 <sys_env_exit>:


void sys_env_exit(void)
{
  801426:	55                   	push   %ebp
  801427:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801429:	6a 00                	push   $0x0
  80142b:	6a 00                	push   $0x0
  80142d:	6a 00                	push   $0x0
  80142f:	6a 00                	push   $0x0
  801431:	6a 00                	push   $0x0
  801433:	6a 06                	push   $0x6
  801435:	e8 19 ff ff ff       	call   801353 <syscall>
  80143a:	83 c4 18             	add    $0x18,%esp
}
  80143d:	90                   	nop
  80143e:	c9                   	leave  
  80143f:	c3                   	ret    

00801440 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801440:	55                   	push   %ebp
  801441:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801443:	8b 55 0c             	mov    0xc(%ebp),%edx
  801446:	8b 45 08             	mov    0x8(%ebp),%eax
  801449:	6a 00                	push   $0x0
  80144b:	6a 00                	push   $0x0
  80144d:	6a 00                	push   $0x0
  80144f:	52                   	push   %edx
  801450:	50                   	push   %eax
  801451:	6a 07                	push   $0x7
  801453:	e8 fb fe ff ff       	call   801353 <syscall>
  801458:	83 c4 18             	add    $0x18,%esp
}
  80145b:	c9                   	leave  
  80145c:	c3                   	ret    

0080145d <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80145d:	55                   	push   %ebp
  80145e:	89 e5                	mov    %esp,%ebp
  801460:	56                   	push   %esi
  801461:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801462:	8b 75 18             	mov    0x18(%ebp),%esi
  801465:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801468:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80146b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80146e:	8b 45 08             	mov    0x8(%ebp),%eax
  801471:	56                   	push   %esi
  801472:	53                   	push   %ebx
  801473:	51                   	push   %ecx
  801474:	52                   	push   %edx
  801475:	50                   	push   %eax
  801476:	6a 08                	push   $0x8
  801478:	e8 d6 fe ff ff       	call   801353 <syscall>
  80147d:	83 c4 18             	add    $0x18,%esp
}
  801480:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801483:	5b                   	pop    %ebx
  801484:	5e                   	pop    %esi
  801485:	5d                   	pop    %ebp
  801486:	c3                   	ret    

00801487 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801487:	55                   	push   %ebp
  801488:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80148a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80148d:	8b 45 08             	mov    0x8(%ebp),%eax
  801490:	6a 00                	push   $0x0
  801492:	6a 00                	push   $0x0
  801494:	6a 00                	push   $0x0
  801496:	52                   	push   %edx
  801497:	50                   	push   %eax
  801498:	6a 09                	push   $0x9
  80149a:	e8 b4 fe ff ff       	call   801353 <syscall>
  80149f:	83 c4 18             	add    $0x18,%esp
}
  8014a2:	c9                   	leave  
  8014a3:	c3                   	ret    

008014a4 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8014a4:	55                   	push   %ebp
  8014a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	ff 75 0c             	pushl  0xc(%ebp)
  8014b0:	ff 75 08             	pushl  0x8(%ebp)
  8014b3:	6a 0a                	push   $0xa
  8014b5:	e8 99 fe ff ff       	call   801353 <syscall>
  8014ba:	83 c4 18             	add    $0x18,%esp
}
  8014bd:	c9                   	leave  
  8014be:	c3                   	ret    

008014bf <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8014bf:	55                   	push   %ebp
  8014c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 00                	push   $0x0
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 0b                	push   $0xb
  8014ce:	e8 80 fe ff ff       	call   801353 <syscall>
  8014d3:	83 c4 18             	add    $0x18,%esp
}
  8014d6:	c9                   	leave  
  8014d7:	c3                   	ret    

008014d8 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8014d8:	55                   	push   %ebp
  8014d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	6a 00                	push   $0x0
  8014e5:	6a 0c                	push   $0xc
  8014e7:	e8 67 fe ff ff       	call   801353 <syscall>
  8014ec:	83 c4 18             	add    $0x18,%esp
}
  8014ef:	c9                   	leave  
  8014f0:	c3                   	ret    

008014f1 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8014f1:	55                   	push   %ebp
  8014f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 0d                	push   $0xd
  801500:	e8 4e fe ff ff       	call   801353 <syscall>
  801505:	83 c4 18             	add    $0x18,%esp
}
  801508:	c9                   	leave  
  801509:	c3                   	ret    

0080150a <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80150a:	55                   	push   %ebp
  80150b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80150d:	6a 00                	push   $0x0
  80150f:	6a 00                	push   $0x0
  801511:	6a 00                	push   $0x0
  801513:	ff 75 0c             	pushl  0xc(%ebp)
  801516:	ff 75 08             	pushl  0x8(%ebp)
  801519:	6a 11                	push   $0x11
  80151b:	e8 33 fe ff ff       	call   801353 <syscall>
  801520:	83 c4 18             	add    $0x18,%esp
	return;
  801523:	90                   	nop
}
  801524:	c9                   	leave  
  801525:	c3                   	ret    

00801526 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801526:	55                   	push   %ebp
  801527:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	6a 00                	push   $0x0
  80152f:	ff 75 0c             	pushl  0xc(%ebp)
  801532:	ff 75 08             	pushl  0x8(%ebp)
  801535:	6a 12                	push   $0x12
  801537:	e8 17 fe ff ff       	call   801353 <syscall>
  80153c:	83 c4 18             	add    $0x18,%esp
	return ;
  80153f:	90                   	nop
}
  801540:	c9                   	leave  
  801541:	c3                   	ret    

00801542 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801542:	55                   	push   %ebp
  801543:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801545:	6a 00                	push   $0x0
  801547:	6a 00                	push   $0x0
  801549:	6a 00                	push   $0x0
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	6a 0e                	push   $0xe
  801551:	e8 fd fd ff ff       	call   801353 <syscall>
  801556:	83 c4 18             	add    $0x18,%esp
}
  801559:	c9                   	leave  
  80155a:	c3                   	ret    

0080155b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80155b:	55                   	push   %ebp
  80155c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	6a 00                	push   $0x0
  801564:	6a 00                	push   $0x0
  801566:	ff 75 08             	pushl  0x8(%ebp)
  801569:	6a 0f                	push   $0xf
  80156b:	e8 e3 fd ff ff       	call   801353 <syscall>
  801570:	83 c4 18             	add    $0x18,%esp
}
  801573:	c9                   	leave  
  801574:	c3                   	ret    

00801575 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801575:	55                   	push   %ebp
  801576:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	6a 00                	push   $0x0
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	6a 10                	push   $0x10
  801584:	e8 ca fd ff ff       	call   801353 <syscall>
  801589:	83 c4 18             	add    $0x18,%esp
}
  80158c:	90                   	nop
  80158d:	c9                   	leave  
  80158e:	c3                   	ret    

0080158f <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80158f:	55                   	push   %ebp
  801590:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	6a 00                	push   $0x0
  80159c:	6a 14                	push   $0x14
  80159e:	e8 b0 fd ff ff       	call   801353 <syscall>
  8015a3:	83 c4 18             	add    $0x18,%esp
}
  8015a6:	90                   	nop
  8015a7:	c9                   	leave  
  8015a8:	c3                   	ret    

008015a9 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8015a9:	55                   	push   %ebp
  8015aa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 15                	push   $0x15
  8015b8:	e8 96 fd ff ff       	call   801353 <syscall>
  8015bd:	83 c4 18             	add    $0x18,%esp
}
  8015c0:	90                   	nop
  8015c1:	c9                   	leave  
  8015c2:	c3                   	ret    

008015c3 <sys_cputc>:


void
sys_cputc(const char c)
{
  8015c3:	55                   	push   %ebp
  8015c4:	89 e5                	mov    %esp,%ebp
  8015c6:	83 ec 04             	sub    $0x4,%esp
  8015c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8015cf:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 00                	push   $0x0
  8015db:	50                   	push   %eax
  8015dc:	6a 16                	push   $0x16
  8015de:	e8 70 fd ff ff       	call   801353 <syscall>
  8015e3:	83 c4 18             	add    $0x18,%esp
}
  8015e6:	90                   	nop
  8015e7:	c9                   	leave  
  8015e8:	c3                   	ret    

008015e9 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8015e9:	55                   	push   %ebp
  8015ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 00                	push   $0x0
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 17                	push   $0x17
  8015f8:	e8 56 fd ff ff       	call   801353 <syscall>
  8015fd:	83 c4 18             	add    $0x18,%esp
}
  801600:	90                   	nop
  801601:	c9                   	leave  
  801602:	c3                   	ret    

00801603 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801603:	55                   	push   %ebp
  801604:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801606:	8b 45 08             	mov    0x8(%ebp),%eax
  801609:	6a 00                	push   $0x0
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	ff 75 0c             	pushl  0xc(%ebp)
  801612:	50                   	push   %eax
  801613:	6a 18                	push   $0x18
  801615:	e8 39 fd ff ff       	call   801353 <syscall>
  80161a:	83 c4 18             	add    $0x18,%esp
}
  80161d:	c9                   	leave  
  80161e:	c3                   	ret    

0080161f <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80161f:	55                   	push   %ebp
  801620:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801622:	8b 55 0c             	mov    0xc(%ebp),%edx
  801625:	8b 45 08             	mov    0x8(%ebp),%eax
  801628:	6a 00                	push   $0x0
  80162a:	6a 00                	push   $0x0
  80162c:	6a 00                	push   $0x0
  80162e:	52                   	push   %edx
  80162f:	50                   	push   %eax
  801630:	6a 1b                	push   $0x1b
  801632:	e8 1c fd ff ff       	call   801353 <syscall>
  801637:	83 c4 18             	add    $0x18,%esp
}
  80163a:	c9                   	leave  
  80163b:	c3                   	ret    

0080163c <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80163c:	55                   	push   %ebp
  80163d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80163f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801642:	8b 45 08             	mov    0x8(%ebp),%eax
  801645:	6a 00                	push   $0x0
  801647:	6a 00                	push   $0x0
  801649:	6a 00                	push   $0x0
  80164b:	52                   	push   %edx
  80164c:	50                   	push   %eax
  80164d:	6a 19                	push   $0x19
  80164f:	e8 ff fc ff ff       	call   801353 <syscall>
  801654:	83 c4 18             	add    $0x18,%esp
}
  801657:	90                   	nop
  801658:	c9                   	leave  
  801659:	c3                   	ret    

0080165a <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80165a:	55                   	push   %ebp
  80165b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80165d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801660:	8b 45 08             	mov    0x8(%ebp),%eax
  801663:	6a 00                	push   $0x0
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	52                   	push   %edx
  80166a:	50                   	push   %eax
  80166b:	6a 1a                	push   $0x1a
  80166d:	e8 e1 fc ff ff       	call   801353 <syscall>
  801672:	83 c4 18             	add    $0x18,%esp
}
  801675:	90                   	nop
  801676:	c9                   	leave  
  801677:	c3                   	ret    

00801678 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801678:	55                   	push   %ebp
  801679:	89 e5                	mov    %esp,%ebp
  80167b:	83 ec 04             	sub    $0x4,%esp
  80167e:	8b 45 10             	mov    0x10(%ebp),%eax
  801681:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801684:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801687:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80168b:	8b 45 08             	mov    0x8(%ebp),%eax
  80168e:	6a 00                	push   $0x0
  801690:	51                   	push   %ecx
  801691:	52                   	push   %edx
  801692:	ff 75 0c             	pushl  0xc(%ebp)
  801695:	50                   	push   %eax
  801696:	6a 1c                	push   $0x1c
  801698:	e8 b6 fc ff ff       	call   801353 <syscall>
  80169d:	83 c4 18             	add    $0x18,%esp
}
  8016a0:	c9                   	leave  
  8016a1:	c3                   	ret    

008016a2 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8016a2:	55                   	push   %ebp
  8016a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8016a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 00                	push   $0x0
  8016b1:	52                   	push   %edx
  8016b2:	50                   	push   %eax
  8016b3:	6a 1d                	push   $0x1d
  8016b5:	e8 99 fc ff ff       	call   801353 <syscall>
  8016ba:	83 c4 18             	add    $0x18,%esp
}
  8016bd:	c9                   	leave  
  8016be:	c3                   	ret    

008016bf <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8016bf:	55                   	push   %ebp
  8016c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8016c2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cb:	6a 00                	push   $0x0
  8016cd:	6a 00                	push   $0x0
  8016cf:	51                   	push   %ecx
  8016d0:	52                   	push   %edx
  8016d1:	50                   	push   %eax
  8016d2:	6a 1e                	push   $0x1e
  8016d4:	e8 7a fc ff ff       	call   801353 <syscall>
  8016d9:	83 c4 18             	add    $0x18,%esp
}
  8016dc:	c9                   	leave  
  8016dd:	c3                   	ret    

008016de <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8016de:	55                   	push   %ebp
  8016df:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8016e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 00                	push   $0x0
  8016ed:	52                   	push   %edx
  8016ee:	50                   	push   %eax
  8016ef:	6a 1f                	push   $0x1f
  8016f1:	e8 5d fc ff ff       	call   801353 <syscall>
  8016f6:	83 c4 18             	add    $0x18,%esp
}
  8016f9:	c9                   	leave  
  8016fa:	c3                   	ret    

008016fb <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8016fb:	55                   	push   %ebp
  8016fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	6a 00                	push   $0x0
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 20                	push   $0x20
  80170a:	e8 44 fc ff ff       	call   801353 <syscall>
  80170f:	83 c4 18             	add    $0x18,%esp
}
  801712:	c9                   	leave  
  801713:	c3                   	ret    

00801714 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801714:	55                   	push   %ebp
  801715:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
  80171a:	6a 00                	push   $0x0
  80171c:	ff 75 14             	pushl  0x14(%ebp)
  80171f:	ff 75 10             	pushl  0x10(%ebp)
  801722:	ff 75 0c             	pushl  0xc(%ebp)
  801725:	50                   	push   %eax
  801726:	6a 21                	push   $0x21
  801728:	e8 26 fc ff ff       	call   801353 <syscall>
  80172d:	83 c4 18             	add    $0x18,%esp
}
  801730:	c9                   	leave  
  801731:	c3                   	ret    

00801732 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801732:	55                   	push   %ebp
  801733:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801735:	8b 45 08             	mov    0x8(%ebp),%eax
  801738:	6a 00                	push   $0x0
  80173a:	6a 00                	push   $0x0
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	50                   	push   %eax
  801741:	6a 22                	push   $0x22
  801743:	e8 0b fc ff ff       	call   801353 <syscall>
  801748:	83 c4 18             	add    $0x18,%esp
}
  80174b:	90                   	nop
  80174c:	c9                   	leave  
  80174d:	c3                   	ret    

0080174e <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80174e:	55                   	push   %ebp
  80174f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801751:	8b 45 08             	mov    0x8(%ebp),%eax
  801754:	6a 00                	push   $0x0
  801756:	6a 00                	push   $0x0
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	50                   	push   %eax
  80175d:	6a 23                	push   $0x23
  80175f:	e8 ef fb ff ff       	call   801353 <syscall>
  801764:	83 c4 18             	add    $0x18,%esp
}
  801767:	90                   	nop
  801768:	c9                   	leave  
  801769:	c3                   	ret    

0080176a <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
  80176d:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801770:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801773:	8d 50 04             	lea    0x4(%eax),%edx
  801776:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	52                   	push   %edx
  801780:	50                   	push   %eax
  801781:	6a 24                	push   $0x24
  801783:	e8 cb fb ff ff       	call   801353 <syscall>
  801788:	83 c4 18             	add    $0x18,%esp
	return result;
  80178b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80178e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801791:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801794:	89 01                	mov    %eax,(%ecx)
  801796:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801799:	8b 45 08             	mov    0x8(%ebp),%eax
  80179c:	c9                   	leave  
  80179d:	c2 04 00             	ret    $0x4

008017a0 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8017a0:	55                   	push   %ebp
  8017a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	ff 75 10             	pushl  0x10(%ebp)
  8017aa:	ff 75 0c             	pushl  0xc(%ebp)
  8017ad:	ff 75 08             	pushl  0x8(%ebp)
  8017b0:	6a 13                	push   $0x13
  8017b2:	e8 9c fb ff ff       	call   801353 <syscall>
  8017b7:	83 c4 18             	add    $0x18,%esp
	return ;
  8017ba:	90                   	nop
}
  8017bb:	c9                   	leave  
  8017bc:	c3                   	ret    

008017bd <sys_rcr2>:
uint32 sys_rcr2()
{
  8017bd:	55                   	push   %ebp
  8017be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 25                	push   $0x25
  8017cc:	e8 82 fb ff ff       	call   801353 <syscall>
  8017d1:	83 c4 18             	add    $0x18,%esp
}
  8017d4:	c9                   	leave  
  8017d5:	c3                   	ret    

008017d6 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8017d6:	55                   	push   %ebp
  8017d7:	89 e5                	mov    %esp,%ebp
  8017d9:	83 ec 04             	sub    $0x4,%esp
  8017dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017df:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017e2:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 00                	push   $0x0
  8017ee:	50                   	push   %eax
  8017ef:	6a 26                	push   $0x26
  8017f1:	e8 5d fb ff ff       	call   801353 <syscall>
  8017f6:	83 c4 18             	add    $0x18,%esp
	return ;
  8017f9:	90                   	nop
}
  8017fa:	c9                   	leave  
  8017fb:	c3                   	ret    

008017fc <rsttst>:
void rsttst()
{
  8017fc:	55                   	push   %ebp
  8017fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	6a 00                	push   $0x0
  801807:	6a 00                	push   $0x0
  801809:	6a 28                	push   $0x28
  80180b:	e8 43 fb ff ff       	call   801353 <syscall>
  801810:	83 c4 18             	add    $0x18,%esp
	return ;
  801813:	90                   	nop
}
  801814:	c9                   	leave  
  801815:	c3                   	ret    

00801816 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801816:	55                   	push   %ebp
  801817:	89 e5                	mov    %esp,%ebp
  801819:	83 ec 04             	sub    $0x4,%esp
  80181c:	8b 45 14             	mov    0x14(%ebp),%eax
  80181f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801822:	8b 55 18             	mov    0x18(%ebp),%edx
  801825:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801829:	52                   	push   %edx
  80182a:	50                   	push   %eax
  80182b:	ff 75 10             	pushl  0x10(%ebp)
  80182e:	ff 75 0c             	pushl  0xc(%ebp)
  801831:	ff 75 08             	pushl  0x8(%ebp)
  801834:	6a 27                	push   $0x27
  801836:	e8 18 fb ff ff       	call   801353 <syscall>
  80183b:	83 c4 18             	add    $0x18,%esp
	return ;
  80183e:	90                   	nop
}
  80183f:	c9                   	leave  
  801840:	c3                   	ret    

00801841 <chktst>:
void chktst(uint32 n)
{
  801841:	55                   	push   %ebp
  801842:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	ff 75 08             	pushl  0x8(%ebp)
  80184f:	6a 29                	push   $0x29
  801851:	e8 fd fa ff ff       	call   801353 <syscall>
  801856:	83 c4 18             	add    $0x18,%esp
	return ;
  801859:	90                   	nop
}
  80185a:	c9                   	leave  
  80185b:	c3                   	ret    

0080185c <inctst>:

void inctst()
{
  80185c:	55                   	push   %ebp
  80185d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	6a 00                	push   $0x0
  801867:	6a 00                	push   $0x0
  801869:	6a 2a                	push   $0x2a
  80186b:	e8 e3 fa ff ff       	call   801353 <syscall>
  801870:	83 c4 18             	add    $0x18,%esp
	return ;
  801873:	90                   	nop
}
  801874:	c9                   	leave  
  801875:	c3                   	ret    

00801876 <gettst>:
uint32 gettst()
{
  801876:	55                   	push   %ebp
  801877:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	6a 00                	push   $0x0
  801883:	6a 2b                	push   $0x2b
  801885:	e8 c9 fa ff ff       	call   801353 <syscall>
  80188a:	83 c4 18             	add    $0x18,%esp
}
  80188d:	c9                   	leave  
  80188e:	c3                   	ret    

0080188f <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80188f:	55                   	push   %ebp
  801890:	89 e5                	mov    %esp,%ebp
  801892:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 2c                	push   $0x2c
  8018a1:	e8 ad fa ff ff       	call   801353 <syscall>
  8018a6:	83 c4 18             	add    $0x18,%esp
  8018a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8018ac:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8018b0:	75 07                	jne    8018b9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8018b2:	b8 01 00 00 00       	mov    $0x1,%eax
  8018b7:	eb 05                	jmp    8018be <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8018b9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018be:	c9                   	leave  
  8018bf:	c3                   	ret    

008018c0 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8018c0:	55                   	push   %ebp
  8018c1:	89 e5                	mov    %esp,%ebp
  8018c3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018c6:	6a 00                	push   $0x0
  8018c8:	6a 00                	push   $0x0
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 00                	push   $0x0
  8018d0:	6a 2c                	push   $0x2c
  8018d2:	e8 7c fa ff ff       	call   801353 <syscall>
  8018d7:	83 c4 18             	add    $0x18,%esp
  8018da:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8018dd:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8018e1:	75 07                	jne    8018ea <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8018e3:	b8 01 00 00 00       	mov    $0x1,%eax
  8018e8:	eb 05                	jmp    8018ef <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8018ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018ef:	c9                   	leave  
  8018f0:	c3                   	ret    

008018f1 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8018f1:	55                   	push   %ebp
  8018f2:	89 e5                	mov    %esp,%ebp
  8018f4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018f7:	6a 00                	push   $0x0
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	6a 2c                	push   $0x2c
  801903:	e8 4b fa ff ff       	call   801353 <syscall>
  801908:	83 c4 18             	add    $0x18,%esp
  80190b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80190e:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801912:	75 07                	jne    80191b <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801914:	b8 01 00 00 00       	mov    $0x1,%eax
  801919:	eb 05                	jmp    801920 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80191b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801920:	c9                   	leave  
  801921:	c3                   	ret    

00801922 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801922:	55                   	push   %ebp
  801923:	89 e5                	mov    %esp,%ebp
  801925:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801928:	6a 00                	push   $0x0
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	6a 2c                	push   $0x2c
  801934:	e8 1a fa ff ff       	call   801353 <syscall>
  801939:	83 c4 18             	add    $0x18,%esp
  80193c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80193f:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801943:	75 07                	jne    80194c <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801945:	b8 01 00 00 00       	mov    $0x1,%eax
  80194a:	eb 05                	jmp    801951 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80194c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801951:	c9                   	leave  
  801952:	c3                   	ret    

00801953 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801953:	55                   	push   %ebp
  801954:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	6a 00                	push   $0x0
  80195c:	6a 00                	push   $0x0
  80195e:	ff 75 08             	pushl  0x8(%ebp)
  801961:	6a 2d                	push   $0x2d
  801963:	e8 eb f9 ff ff       	call   801353 <syscall>
  801968:	83 c4 18             	add    $0x18,%esp
	return ;
  80196b:	90                   	nop
}
  80196c:	c9                   	leave  
  80196d:	c3                   	ret    

0080196e <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80196e:	55                   	push   %ebp
  80196f:	89 e5                	mov    %esp,%ebp
  801971:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801972:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801975:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801978:	8b 55 0c             	mov    0xc(%ebp),%edx
  80197b:	8b 45 08             	mov    0x8(%ebp),%eax
  80197e:	6a 00                	push   $0x0
  801980:	53                   	push   %ebx
  801981:	51                   	push   %ecx
  801982:	52                   	push   %edx
  801983:	50                   	push   %eax
  801984:	6a 2e                	push   $0x2e
  801986:	e8 c8 f9 ff ff       	call   801353 <syscall>
  80198b:	83 c4 18             	add    $0x18,%esp
}
  80198e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801991:	c9                   	leave  
  801992:	c3                   	ret    

00801993 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801993:	55                   	push   %ebp
  801994:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801996:	8b 55 0c             	mov    0xc(%ebp),%edx
  801999:	8b 45 08             	mov    0x8(%ebp),%eax
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	52                   	push   %edx
  8019a3:	50                   	push   %eax
  8019a4:	6a 2f                	push   $0x2f
  8019a6:	e8 a8 f9 ff ff       	call   801353 <syscall>
  8019ab:	83 c4 18             	add    $0x18,%esp
}
  8019ae:	c9                   	leave  
  8019af:	c3                   	ret    

008019b0 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8019b0:	55                   	push   %ebp
  8019b1:	89 e5                	mov    %esp,%ebp
  8019b3:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8019b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b9:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8019bc:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8019c0:	83 ec 0c             	sub    $0xc,%esp
  8019c3:	50                   	push   %eax
  8019c4:	e8 fa fb ff ff       	call   8015c3 <sys_cputc>
  8019c9:	83 c4 10             	add    $0x10,%esp
}
  8019cc:	90                   	nop
  8019cd:	c9                   	leave  
  8019ce:	c3                   	ret    

008019cf <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8019cf:	55                   	push   %ebp
  8019d0:	89 e5                	mov    %esp,%ebp
  8019d2:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8019d5:	e8 b5 fb ff ff       	call   80158f <sys_disable_interrupt>
	char c = ch;
  8019da:	8b 45 08             	mov    0x8(%ebp),%eax
  8019dd:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8019e0:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8019e4:	83 ec 0c             	sub    $0xc,%esp
  8019e7:	50                   	push   %eax
  8019e8:	e8 d6 fb ff ff       	call   8015c3 <sys_cputc>
  8019ed:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8019f0:	e8 b4 fb ff ff       	call   8015a9 <sys_enable_interrupt>
}
  8019f5:	90                   	nop
  8019f6:	c9                   	leave  
  8019f7:	c3                   	ret    

008019f8 <getchar>:

int
getchar(void)
{
  8019f8:	55                   	push   %ebp
  8019f9:	89 e5                	mov    %esp,%ebp
  8019fb:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8019fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801a05:	eb 08                	jmp    801a0f <getchar+0x17>
	{
		c = sys_cgetc();
  801a07:	e8 9b f9 ff ff       	call   8013a7 <sys_cgetc>
  801a0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  801a0f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801a13:	74 f2                	je     801a07 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  801a15:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801a18:	c9                   	leave  
  801a19:	c3                   	ret    

00801a1a <atomic_getchar>:

int
atomic_getchar(void)
{
  801a1a:	55                   	push   %ebp
  801a1b:	89 e5                	mov    %esp,%ebp
  801a1d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801a20:	e8 6a fb ff ff       	call   80158f <sys_disable_interrupt>
	int c=0;
  801a25:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801a2c:	eb 08                	jmp    801a36 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  801a2e:	e8 74 f9 ff ff       	call   8013a7 <sys_cgetc>
  801a33:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  801a36:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801a3a:	74 f2                	je     801a2e <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  801a3c:	e8 68 fb ff ff       	call   8015a9 <sys_enable_interrupt>
	return c;
  801a41:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801a44:	c9                   	leave  
  801a45:	c3                   	ret    

00801a46 <iscons>:

int iscons(int fdnum)
{
  801a46:	55                   	push   %ebp
  801a47:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  801a49:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a4e:	5d                   	pop    %ebp
  801a4f:	c3                   	ret    

00801a50 <__udivdi3>:
  801a50:	55                   	push   %ebp
  801a51:	57                   	push   %edi
  801a52:	56                   	push   %esi
  801a53:	53                   	push   %ebx
  801a54:	83 ec 1c             	sub    $0x1c,%esp
  801a57:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a5b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a5f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a63:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a67:	89 ca                	mov    %ecx,%edx
  801a69:	89 f8                	mov    %edi,%eax
  801a6b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a6f:	85 f6                	test   %esi,%esi
  801a71:	75 2d                	jne    801aa0 <__udivdi3+0x50>
  801a73:	39 cf                	cmp    %ecx,%edi
  801a75:	77 65                	ja     801adc <__udivdi3+0x8c>
  801a77:	89 fd                	mov    %edi,%ebp
  801a79:	85 ff                	test   %edi,%edi
  801a7b:	75 0b                	jne    801a88 <__udivdi3+0x38>
  801a7d:	b8 01 00 00 00       	mov    $0x1,%eax
  801a82:	31 d2                	xor    %edx,%edx
  801a84:	f7 f7                	div    %edi
  801a86:	89 c5                	mov    %eax,%ebp
  801a88:	31 d2                	xor    %edx,%edx
  801a8a:	89 c8                	mov    %ecx,%eax
  801a8c:	f7 f5                	div    %ebp
  801a8e:	89 c1                	mov    %eax,%ecx
  801a90:	89 d8                	mov    %ebx,%eax
  801a92:	f7 f5                	div    %ebp
  801a94:	89 cf                	mov    %ecx,%edi
  801a96:	89 fa                	mov    %edi,%edx
  801a98:	83 c4 1c             	add    $0x1c,%esp
  801a9b:	5b                   	pop    %ebx
  801a9c:	5e                   	pop    %esi
  801a9d:	5f                   	pop    %edi
  801a9e:	5d                   	pop    %ebp
  801a9f:	c3                   	ret    
  801aa0:	39 ce                	cmp    %ecx,%esi
  801aa2:	77 28                	ja     801acc <__udivdi3+0x7c>
  801aa4:	0f bd fe             	bsr    %esi,%edi
  801aa7:	83 f7 1f             	xor    $0x1f,%edi
  801aaa:	75 40                	jne    801aec <__udivdi3+0x9c>
  801aac:	39 ce                	cmp    %ecx,%esi
  801aae:	72 0a                	jb     801aba <__udivdi3+0x6a>
  801ab0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ab4:	0f 87 9e 00 00 00    	ja     801b58 <__udivdi3+0x108>
  801aba:	b8 01 00 00 00       	mov    $0x1,%eax
  801abf:	89 fa                	mov    %edi,%edx
  801ac1:	83 c4 1c             	add    $0x1c,%esp
  801ac4:	5b                   	pop    %ebx
  801ac5:	5e                   	pop    %esi
  801ac6:	5f                   	pop    %edi
  801ac7:	5d                   	pop    %ebp
  801ac8:	c3                   	ret    
  801ac9:	8d 76 00             	lea    0x0(%esi),%esi
  801acc:	31 ff                	xor    %edi,%edi
  801ace:	31 c0                	xor    %eax,%eax
  801ad0:	89 fa                	mov    %edi,%edx
  801ad2:	83 c4 1c             	add    $0x1c,%esp
  801ad5:	5b                   	pop    %ebx
  801ad6:	5e                   	pop    %esi
  801ad7:	5f                   	pop    %edi
  801ad8:	5d                   	pop    %ebp
  801ad9:	c3                   	ret    
  801ada:	66 90                	xchg   %ax,%ax
  801adc:	89 d8                	mov    %ebx,%eax
  801ade:	f7 f7                	div    %edi
  801ae0:	31 ff                	xor    %edi,%edi
  801ae2:	89 fa                	mov    %edi,%edx
  801ae4:	83 c4 1c             	add    $0x1c,%esp
  801ae7:	5b                   	pop    %ebx
  801ae8:	5e                   	pop    %esi
  801ae9:	5f                   	pop    %edi
  801aea:	5d                   	pop    %ebp
  801aeb:	c3                   	ret    
  801aec:	bd 20 00 00 00       	mov    $0x20,%ebp
  801af1:	89 eb                	mov    %ebp,%ebx
  801af3:	29 fb                	sub    %edi,%ebx
  801af5:	89 f9                	mov    %edi,%ecx
  801af7:	d3 e6                	shl    %cl,%esi
  801af9:	89 c5                	mov    %eax,%ebp
  801afb:	88 d9                	mov    %bl,%cl
  801afd:	d3 ed                	shr    %cl,%ebp
  801aff:	89 e9                	mov    %ebp,%ecx
  801b01:	09 f1                	or     %esi,%ecx
  801b03:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b07:	89 f9                	mov    %edi,%ecx
  801b09:	d3 e0                	shl    %cl,%eax
  801b0b:	89 c5                	mov    %eax,%ebp
  801b0d:	89 d6                	mov    %edx,%esi
  801b0f:	88 d9                	mov    %bl,%cl
  801b11:	d3 ee                	shr    %cl,%esi
  801b13:	89 f9                	mov    %edi,%ecx
  801b15:	d3 e2                	shl    %cl,%edx
  801b17:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b1b:	88 d9                	mov    %bl,%cl
  801b1d:	d3 e8                	shr    %cl,%eax
  801b1f:	09 c2                	or     %eax,%edx
  801b21:	89 d0                	mov    %edx,%eax
  801b23:	89 f2                	mov    %esi,%edx
  801b25:	f7 74 24 0c          	divl   0xc(%esp)
  801b29:	89 d6                	mov    %edx,%esi
  801b2b:	89 c3                	mov    %eax,%ebx
  801b2d:	f7 e5                	mul    %ebp
  801b2f:	39 d6                	cmp    %edx,%esi
  801b31:	72 19                	jb     801b4c <__udivdi3+0xfc>
  801b33:	74 0b                	je     801b40 <__udivdi3+0xf0>
  801b35:	89 d8                	mov    %ebx,%eax
  801b37:	31 ff                	xor    %edi,%edi
  801b39:	e9 58 ff ff ff       	jmp    801a96 <__udivdi3+0x46>
  801b3e:	66 90                	xchg   %ax,%ax
  801b40:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b44:	89 f9                	mov    %edi,%ecx
  801b46:	d3 e2                	shl    %cl,%edx
  801b48:	39 c2                	cmp    %eax,%edx
  801b4a:	73 e9                	jae    801b35 <__udivdi3+0xe5>
  801b4c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b4f:	31 ff                	xor    %edi,%edi
  801b51:	e9 40 ff ff ff       	jmp    801a96 <__udivdi3+0x46>
  801b56:	66 90                	xchg   %ax,%ax
  801b58:	31 c0                	xor    %eax,%eax
  801b5a:	e9 37 ff ff ff       	jmp    801a96 <__udivdi3+0x46>
  801b5f:	90                   	nop

00801b60 <__umoddi3>:
  801b60:	55                   	push   %ebp
  801b61:	57                   	push   %edi
  801b62:	56                   	push   %esi
  801b63:	53                   	push   %ebx
  801b64:	83 ec 1c             	sub    $0x1c,%esp
  801b67:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b6b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b6f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b73:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b77:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b7b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b7f:	89 f3                	mov    %esi,%ebx
  801b81:	89 fa                	mov    %edi,%edx
  801b83:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b87:	89 34 24             	mov    %esi,(%esp)
  801b8a:	85 c0                	test   %eax,%eax
  801b8c:	75 1a                	jne    801ba8 <__umoddi3+0x48>
  801b8e:	39 f7                	cmp    %esi,%edi
  801b90:	0f 86 a2 00 00 00    	jbe    801c38 <__umoddi3+0xd8>
  801b96:	89 c8                	mov    %ecx,%eax
  801b98:	89 f2                	mov    %esi,%edx
  801b9a:	f7 f7                	div    %edi
  801b9c:	89 d0                	mov    %edx,%eax
  801b9e:	31 d2                	xor    %edx,%edx
  801ba0:	83 c4 1c             	add    $0x1c,%esp
  801ba3:	5b                   	pop    %ebx
  801ba4:	5e                   	pop    %esi
  801ba5:	5f                   	pop    %edi
  801ba6:	5d                   	pop    %ebp
  801ba7:	c3                   	ret    
  801ba8:	39 f0                	cmp    %esi,%eax
  801baa:	0f 87 ac 00 00 00    	ja     801c5c <__umoddi3+0xfc>
  801bb0:	0f bd e8             	bsr    %eax,%ebp
  801bb3:	83 f5 1f             	xor    $0x1f,%ebp
  801bb6:	0f 84 ac 00 00 00    	je     801c68 <__umoddi3+0x108>
  801bbc:	bf 20 00 00 00       	mov    $0x20,%edi
  801bc1:	29 ef                	sub    %ebp,%edi
  801bc3:	89 fe                	mov    %edi,%esi
  801bc5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801bc9:	89 e9                	mov    %ebp,%ecx
  801bcb:	d3 e0                	shl    %cl,%eax
  801bcd:	89 d7                	mov    %edx,%edi
  801bcf:	89 f1                	mov    %esi,%ecx
  801bd1:	d3 ef                	shr    %cl,%edi
  801bd3:	09 c7                	or     %eax,%edi
  801bd5:	89 e9                	mov    %ebp,%ecx
  801bd7:	d3 e2                	shl    %cl,%edx
  801bd9:	89 14 24             	mov    %edx,(%esp)
  801bdc:	89 d8                	mov    %ebx,%eax
  801bde:	d3 e0                	shl    %cl,%eax
  801be0:	89 c2                	mov    %eax,%edx
  801be2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801be6:	d3 e0                	shl    %cl,%eax
  801be8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bec:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bf0:	89 f1                	mov    %esi,%ecx
  801bf2:	d3 e8                	shr    %cl,%eax
  801bf4:	09 d0                	or     %edx,%eax
  801bf6:	d3 eb                	shr    %cl,%ebx
  801bf8:	89 da                	mov    %ebx,%edx
  801bfa:	f7 f7                	div    %edi
  801bfc:	89 d3                	mov    %edx,%ebx
  801bfe:	f7 24 24             	mull   (%esp)
  801c01:	89 c6                	mov    %eax,%esi
  801c03:	89 d1                	mov    %edx,%ecx
  801c05:	39 d3                	cmp    %edx,%ebx
  801c07:	0f 82 87 00 00 00    	jb     801c94 <__umoddi3+0x134>
  801c0d:	0f 84 91 00 00 00    	je     801ca4 <__umoddi3+0x144>
  801c13:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c17:	29 f2                	sub    %esi,%edx
  801c19:	19 cb                	sbb    %ecx,%ebx
  801c1b:	89 d8                	mov    %ebx,%eax
  801c1d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c21:	d3 e0                	shl    %cl,%eax
  801c23:	89 e9                	mov    %ebp,%ecx
  801c25:	d3 ea                	shr    %cl,%edx
  801c27:	09 d0                	or     %edx,%eax
  801c29:	89 e9                	mov    %ebp,%ecx
  801c2b:	d3 eb                	shr    %cl,%ebx
  801c2d:	89 da                	mov    %ebx,%edx
  801c2f:	83 c4 1c             	add    $0x1c,%esp
  801c32:	5b                   	pop    %ebx
  801c33:	5e                   	pop    %esi
  801c34:	5f                   	pop    %edi
  801c35:	5d                   	pop    %ebp
  801c36:	c3                   	ret    
  801c37:	90                   	nop
  801c38:	89 fd                	mov    %edi,%ebp
  801c3a:	85 ff                	test   %edi,%edi
  801c3c:	75 0b                	jne    801c49 <__umoddi3+0xe9>
  801c3e:	b8 01 00 00 00       	mov    $0x1,%eax
  801c43:	31 d2                	xor    %edx,%edx
  801c45:	f7 f7                	div    %edi
  801c47:	89 c5                	mov    %eax,%ebp
  801c49:	89 f0                	mov    %esi,%eax
  801c4b:	31 d2                	xor    %edx,%edx
  801c4d:	f7 f5                	div    %ebp
  801c4f:	89 c8                	mov    %ecx,%eax
  801c51:	f7 f5                	div    %ebp
  801c53:	89 d0                	mov    %edx,%eax
  801c55:	e9 44 ff ff ff       	jmp    801b9e <__umoddi3+0x3e>
  801c5a:	66 90                	xchg   %ax,%ax
  801c5c:	89 c8                	mov    %ecx,%eax
  801c5e:	89 f2                	mov    %esi,%edx
  801c60:	83 c4 1c             	add    $0x1c,%esp
  801c63:	5b                   	pop    %ebx
  801c64:	5e                   	pop    %esi
  801c65:	5f                   	pop    %edi
  801c66:	5d                   	pop    %ebp
  801c67:	c3                   	ret    
  801c68:	3b 04 24             	cmp    (%esp),%eax
  801c6b:	72 06                	jb     801c73 <__umoddi3+0x113>
  801c6d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c71:	77 0f                	ja     801c82 <__umoddi3+0x122>
  801c73:	89 f2                	mov    %esi,%edx
  801c75:	29 f9                	sub    %edi,%ecx
  801c77:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c7b:	89 14 24             	mov    %edx,(%esp)
  801c7e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c82:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c86:	8b 14 24             	mov    (%esp),%edx
  801c89:	83 c4 1c             	add    $0x1c,%esp
  801c8c:	5b                   	pop    %ebx
  801c8d:	5e                   	pop    %esi
  801c8e:	5f                   	pop    %edi
  801c8f:	5d                   	pop    %ebp
  801c90:	c3                   	ret    
  801c91:	8d 76 00             	lea    0x0(%esi),%esi
  801c94:	2b 04 24             	sub    (%esp),%eax
  801c97:	19 fa                	sbb    %edi,%edx
  801c99:	89 d1                	mov    %edx,%ecx
  801c9b:	89 c6                	mov    %eax,%esi
  801c9d:	e9 71 ff ff ff       	jmp    801c13 <__umoddi3+0xb3>
  801ca2:	66 90                	xchg   %ax,%ax
  801ca4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ca8:	72 ea                	jb     801c94 <__umoddi3+0x134>
  801caa:	89 d9                	mov    %ebx,%ecx
  801cac:	e9 62 ff ff ff       	jmp    801c13 <__umoddi3+0xb3>
