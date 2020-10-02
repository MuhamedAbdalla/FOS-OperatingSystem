
obj/user/arrayOperations_Master:     file format elf32-i386


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
  800031:	e8 05 07 00 00       	call   80073b <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
uint32 CheckSorted(int *Elements, int NumOfElements);
void ArrayStats(int *Elements, int NumOfElements, int *mean, int *var);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 88 00 00 00    	sub    $0x88,%esp
	/*[1] CREATE SHARED ARRAY*/
	int ret;
	char Chose;
	char Line[30];
	//2012: lock the interrupt
	sys_disable_interrupt();
  800041:	e8 87 20 00 00       	call   8020cd <sys_disable_interrupt>
		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 60 27 80 00       	push   $0x802760
  80004e:	e8 cf 0a 00 00       	call   800b22 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 62 27 80 00       	push   $0x802762
  80005e:	e8 bf 0a 00 00       	call   800b22 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!   ARRAY OOERATIONS   !!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 80 27 80 00       	push   $0x802780
  80006e:	e8 af 0a 00 00       	call   800b22 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 62 27 80 00       	push   $0x802762
  80007e:	e8 9f 0a 00 00       	call   800b22 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 60 27 80 00       	push   $0x802760
  80008e:	e8 8f 0a 00 00       	call   800b22 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp

		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 45 82             	lea    -0x7e(%ebp),%eax
  80009c:	50                   	push   %eax
  80009d:	68 a0 27 80 00       	push   $0x8027a0
  8000a2:	e8 fd 10 00 00       	call   8011a4 <readline>
  8000a7:	83 c4 10             	add    $0x10,%esp

		//Create the shared array & its size
		int *arrSize = smalloc("arrSize", sizeof(int) , 0) ;
  8000aa:	83 ec 04             	sub    $0x4,%esp
  8000ad:	6a 00                	push   $0x0
  8000af:	6a 04                	push   $0x4
  8000b1:	68 bf 27 80 00       	push   $0x8027bf
  8000b6:	e8 c9 1b 00 00       	call   801c84 <smalloc>
  8000bb:	83 c4 10             	add    $0x10,%esp
  8000be:	89 45 f4             	mov    %eax,-0xc(%ebp)
		*arrSize = strtol(Line, NULL, 10) ;
  8000c1:	83 ec 04             	sub    $0x4,%esp
  8000c4:	6a 0a                	push   $0xa
  8000c6:	6a 00                	push   $0x0
  8000c8:	8d 45 82             	lea    -0x7e(%ebp),%eax
  8000cb:	50                   	push   %eax
  8000cc:	e8 39 16 00 00       	call   80170a <strtol>
  8000d1:	83 c4 10             	add    $0x10,%esp
  8000d4:	89 c2                	mov    %eax,%edx
  8000d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000d9:	89 10                	mov    %edx,(%eax)
		int NumOfElements = *arrSize;
  8000db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000de:	8b 00                	mov    (%eax),%eax
  8000e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = smalloc("arr", sizeof(int) * NumOfElements , 0) ;
  8000e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000e6:	c1 e0 02             	shl    $0x2,%eax
  8000e9:	83 ec 04             	sub    $0x4,%esp
  8000ec:	6a 00                	push   $0x0
  8000ee:	50                   	push   %eax
  8000ef:	68 c7 27 80 00       	push   $0x8027c7
  8000f4:	e8 8b 1b 00 00       	call   801c84 <smalloc>
  8000f9:	83 c4 10             	add    $0x10,%esp
  8000fc:	89 45 ec             	mov    %eax,-0x14(%ebp)

		cprintf("Chose the initialization method:\n") ;
  8000ff:	83 ec 0c             	sub    $0xc,%esp
  800102:	68 cc 27 80 00       	push   $0x8027cc
  800107:	e8 16 0a 00 00       	call   800b22 <cprintf>
  80010c:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  80010f:	83 ec 0c             	sub    $0xc,%esp
  800112:	68 ee 27 80 00       	push   $0x8027ee
  800117:	e8 06 0a 00 00       	call   800b22 <cprintf>
  80011c:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  80011f:	83 ec 0c             	sub    $0xc,%esp
  800122:	68 fc 27 80 00       	push   $0x8027fc
  800127:	e8 f6 09 00 00       	call   800b22 <cprintf>
  80012c:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80012f:	83 ec 0c             	sub    $0xc,%esp
  800132:	68 0b 28 80 00       	push   $0x80280b
  800137:	e8 e6 09 00 00       	call   800b22 <cprintf>
  80013c:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80013f:	83 ec 0c             	sub    $0xc,%esp
  800142:	68 1b 28 80 00       	push   $0x80281b
  800147:	e8 d6 09 00 00       	call   800b22 <cprintf>
  80014c:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80014f:	e8 8f 05 00 00       	call   8006e3 <getchar>
  800154:	88 45 eb             	mov    %al,-0x15(%ebp)
			cputchar(Chose);
  800157:	0f be 45 eb          	movsbl -0x15(%ebp),%eax
  80015b:	83 ec 0c             	sub    $0xc,%esp
  80015e:	50                   	push   %eax
  80015f:	e8 37 05 00 00       	call   80069b <cputchar>
  800164:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800167:	83 ec 0c             	sub    $0xc,%esp
  80016a:	6a 0a                	push   $0xa
  80016c:	e8 2a 05 00 00       	call   80069b <cputchar>
  800171:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800174:	80 7d eb 61          	cmpb   $0x61,-0x15(%ebp)
  800178:	74 0c                	je     800186 <_main+0x14e>
  80017a:	80 7d eb 62          	cmpb   $0x62,-0x15(%ebp)
  80017e:	74 06                	je     800186 <_main+0x14e>
  800180:	80 7d eb 63          	cmpb   $0x63,-0x15(%ebp)
  800184:	75 b9                	jne    80013f <_main+0x107>

	//2012: unlock the interrupt
	sys_enable_interrupt();
  800186:	e8 5c 1f 00 00       	call   8020e7 <sys_enable_interrupt>

	int  i ;
	switch (Chose)
  80018b:	0f be 45 eb          	movsbl -0x15(%ebp),%eax
  80018f:	83 f8 62             	cmp    $0x62,%eax
  800192:	74 1d                	je     8001b1 <_main+0x179>
  800194:	83 f8 63             	cmp    $0x63,%eax
  800197:	74 2b                	je     8001c4 <_main+0x18c>
  800199:	83 f8 61             	cmp    $0x61,%eax
  80019c:	75 39                	jne    8001d7 <_main+0x19f>
	{
	case 'a':
		InitializeAscending(Elements, NumOfElements);
  80019e:	83 ec 08             	sub    $0x8,%esp
  8001a1:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a4:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a7:	e8 75 03 00 00       	call   800521 <InitializeAscending>
  8001ac:	83 c4 10             	add    $0x10,%esp
		break ;
  8001af:	eb 37                	jmp    8001e8 <_main+0x1b0>
	case 'b':
		InitializeDescending(Elements, NumOfElements);
  8001b1:	83 ec 08             	sub    $0x8,%esp
  8001b4:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001ba:	e8 93 03 00 00       	call   800552 <InitializeDescending>
  8001bf:	83 c4 10             	add    $0x10,%esp
		break ;
  8001c2:	eb 24                	jmp    8001e8 <_main+0x1b0>
	case 'c':
		InitializeSemiRandom(Elements, NumOfElements);
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cd:	e8 b5 03 00 00       	call   800587 <InitializeSemiRandom>
  8001d2:	83 c4 10             	add    $0x10,%esp
		break ;
  8001d5:	eb 11                	jmp    8001e8 <_main+0x1b0>
	default:
		InitializeSemiRandom(Elements, NumOfElements);
  8001d7:	83 ec 08             	sub    $0x8,%esp
  8001da:	ff 75 f0             	pushl  -0x10(%ebp)
  8001dd:	ff 75 ec             	pushl  -0x14(%ebp)
  8001e0:	e8 a2 03 00 00       	call   800587 <InitializeSemiRandom>
  8001e5:	83 c4 10             	add    $0x10,%esp
	}

	//Create the check-finishing counter
	int numOfSlaveProgs = 3 ;
  8001e8:	c7 45 e4 03 00 00 00 	movl   $0x3,-0x1c(%ebp)
	int *numOfFinished = smalloc("finishedCount", sizeof(int), 1) ;
  8001ef:	83 ec 04             	sub    $0x4,%esp
  8001f2:	6a 01                	push   $0x1
  8001f4:	6a 04                	push   $0x4
  8001f6:	68 24 28 80 00       	push   $0x802824
  8001fb:	e8 84 1a 00 00       	call   801c84 <smalloc>
  800200:	83 c4 10             	add    $0x10,%esp
  800203:	89 45 e0             	mov    %eax,-0x20(%ebp)
	*numOfFinished = 0 ;
  800206:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800209:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	/*[2] RUN THE SLAVES PROGRAMS*/
	int32 envIdQuickSort = sys_create_env("slave_qs", (myEnv->page_WS_max_size),(myEnv->SecondListSize) ,(myEnv->percentage_of_WS_pages_to_be_removed));
  80020f:	a1 20 40 80 00       	mov    0x804020,%eax
  800214:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  80021a:	a1 20 40 80 00       	mov    0x804020,%eax
  80021f:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800225:	89 c1                	mov    %eax,%ecx
  800227:	a1 20 40 80 00       	mov    0x804020,%eax
  80022c:	8b 40 74             	mov    0x74(%eax),%eax
  80022f:	52                   	push   %edx
  800230:	51                   	push   %ecx
  800231:	50                   	push   %eax
  800232:	68 32 28 80 00       	push   $0x802832
  800237:	e8 16 20 00 00       	call   802252 <sys_create_env>
  80023c:	83 c4 10             	add    $0x10,%esp
  80023f:	89 45 dc             	mov    %eax,-0x24(%ebp)
	int32 envIdMergeSort = sys_create_env("slave_ms", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  800242:	a1 20 40 80 00       	mov    0x804020,%eax
  800247:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  80024d:	a1 20 40 80 00       	mov    0x804020,%eax
  800252:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800258:	89 c1                	mov    %eax,%ecx
  80025a:	a1 20 40 80 00       	mov    0x804020,%eax
  80025f:	8b 40 74             	mov    0x74(%eax),%eax
  800262:	52                   	push   %edx
  800263:	51                   	push   %ecx
  800264:	50                   	push   %eax
  800265:	68 3b 28 80 00       	push   $0x80283b
  80026a:	e8 e3 1f 00 00       	call   802252 <sys_create_env>
  80026f:	83 c4 10             	add    $0x10,%esp
  800272:	89 45 d8             	mov    %eax,-0x28(%ebp)
	int32 envIdStats = sys_create_env("slave_stats", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  800275:	a1 20 40 80 00       	mov    0x804020,%eax
  80027a:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  800280:	a1 20 40 80 00       	mov    0x804020,%eax
  800285:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80028b:	89 c1                	mov    %eax,%ecx
  80028d:	a1 20 40 80 00       	mov    0x804020,%eax
  800292:	8b 40 74             	mov    0x74(%eax),%eax
  800295:	52                   	push   %edx
  800296:	51                   	push   %ecx
  800297:	50                   	push   %eax
  800298:	68 44 28 80 00       	push   $0x802844
  80029d:	e8 b0 1f 00 00       	call   802252 <sys_create_env>
  8002a2:	83 c4 10             	add    $0x10,%esp
  8002a5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	sys_run_env(envIdQuickSort);
  8002a8:	83 ec 0c             	sub    $0xc,%esp
  8002ab:	ff 75 dc             	pushl  -0x24(%ebp)
  8002ae:	e8 bd 1f 00 00       	call   802270 <sys_run_env>
  8002b3:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdMergeSort);
  8002b6:	83 ec 0c             	sub    $0xc,%esp
  8002b9:	ff 75 d8             	pushl  -0x28(%ebp)
  8002bc:	e8 af 1f 00 00       	call   802270 <sys_run_env>
  8002c1:	83 c4 10             	add    $0x10,%esp
	sys_run_env(envIdStats);
  8002c4:	83 ec 0c             	sub    $0xc,%esp
  8002c7:	ff 75 d4             	pushl  -0x2c(%ebp)
  8002ca:	e8 a1 1f 00 00       	call   802270 <sys_run_env>
  8002cf:	83 c4 10             	add    $0x10,%esp

	/*[3] BUSY-WAIT TILL FINISHING THEM*/
	while (*numOfFinished != numOfSlaveProgs) ;
  8002d2:	90                   	nop
  8002d3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002d6:	8b 00                	mov    (%eax),%eax
  8002d8:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8002db:	75 f6                	jne    8002d3 <_main+0x29b>

	/*[4] GET THEIR RESULTS*/
	int *quicksortedArr = NULL;
  8002dd:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
	int *mergesortedArr = NULL;
  8002e4:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
	int *mean = NULL;
  8002eb:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
	int *var = NULL;
  8002f2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
	int *min = NULL;
  8002f9:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
	int *max = NULL;
  800300:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
	int *med = NULL;
  800307:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
	quicksortedArr = sget(envIdQuickSort, "quicksortedArr") ;
  80030e:	83 ec 08             	sub    $0x8,%esp
  800311:	68 50 28 80 00       	push   $0x802850
  800316:	ff 75 dc             	pushl  -0x24(%ebp)
  800319:	e8 89 19 00 00       	call   801ca7 <sget>
  80031e:	83 c4 10             	add    $0x10,%esp
  800321:	89 45 d0             	mov    %eax,-0x30(%ebp)
	mergesortedArr = sget(envIdMergeSort, "mergesortedArr") ;
  800324:	83 ec 08             	sub    $0x8,%esp
  800327:	68 5f 28 80 00       	push   $0x80285f
  80032c:	ff 75 d8             	pushl  -0x28(%ebp)
  80032f:	e8 73 19 00 00       	call   801ca7 <sget>
  800334:	83 c4 10             	add    $0x10,%esp
  800337:	89 45 cc             	mov    %eax,-0x34(%ebp)
	mean = sget(envIdStats, "mean") ;
  80033a:	83 ec 08             	sub    $0x8,%esp
  80033d:	68 6e 28 80 00       	push   $0x80286e
  800342:	ff 75 d4             	pushl  -0x2c(%ebp)
  800345:	e8 5d 19 00 00       	call   801ca7 <sget>
  80034a:	83 c4 10             	add    $0x10,%esp
  80034d:	89 45 c8             	mov    %eax,-0x38(%ebp)
	var = sget(envIdStats,"var") ;
  800350:	83 ec 08             	sub    $0x8,%esp
  800353:	68 73 28 80 00       	push   $0x802873
  800358:	ff 75 d4             	pushl  -0x2c(%ebp)
  80035b:	e8 47 19 00 00       	call   801ca7 <sget>
  800360:	83 c4 10             	add    $0x10,%esp
  800363:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	min = sget(envIdStats,"min") ;
  800366:	83 ec 08             	sub    $0x8,%esp
  800369:	68 77 28 80 00       	push   $0x802877
  80036e:	ff 75 d4             	pushl  -0x2c(%ebp)
  800371:	e8 31 19 00 00       	call   801ca7 <sget>
  800376:	83 c4 10             	add    $0x10,%esp
  800379:	89 45 c0             	mov    %eax,-0x40(%ebp)
	max = sget(envIdStats,"max") ;
  80037c:	83 ec 08             	sub    $0x8,%esp
  80037f:	68 7b 28 80 00       	push   $0x80287b
  800384:	ff 75 d4             	pushl  -0x2c(%ebp)
  800387:	e8 1b 19 00 00       	call   801ca7 <sget>
  80038c:	83 c4 10             	add    $0x10,%esp
  80038f:	89 45 bc             	mov    %eax,-0x44(%ebp)
	med = sget(envIdStats,"med") ;
  800392:	83 ec 08             	sub    $0x8,%esp
  800395:	68 7f 28 80 00       	push   $0x80287f
  80039a:	ff 75 d4             	pushl  -0x2c(%ebp)
  80039d:	e8 05 19 00 00       	call   801ca7 <sget>
  8003a2:	83 c4 10             	add    $0x10,%esp
  8003a5:	89 45 b8             	mov    %eax,-0x48(%ebp)

	/*[5] VALIDATE THE RESULTS*/
	uint32 sorted = CheckSorted(quicksortedArr, NumOfElements);
  8003a8:	83 ec 08             	sub    $0x8,%esp
  8003ab:	ff 75 f0             	pushl  -0x10(%ebp)
  8003ae:	ff 75 d0             	pushl  -0x30(%ebp)
  8003b1:	e8 14 01 00 00       	call   8004ca <CheckSorted>
  8003b6:	83 c4 10             	add    $0x10,%esp
  8003b9:	89 45 b4             	mov    %eax,-0x4c(%ebp)
	if(sorted == 0) panic("The array is NOT quick-sorted correctly") ;
  8003bc:	83 7d b4 00          	cmpl   $0x0,-0x4c(%ebp)
  8003c0:	75 14                	jne    8003d6 <_main+0x39e>
  8003c2:	83 ec 04             	sub    $0x4,%esp
  8003c5:	68 84 28 80 00       	push   $0x802884
  8003ca:	6a 62                	push   $0x62
  8003cc:	68 ac 28 80 00       	push   $0x8028ac
  8003d1:	e8 aa 04 00 00       	call   800880 <_panic>
	sorted = CheckSorted(mergesortedArr, NumOfElements);
  8003d6:	83 ec 08             	sub    $0x8,%esp
  8003d9:	ff 75 f0             	pushl  -0x10(%ebp)
  8003dc:	ff 75 cc             	pushl  -0x34(%ebp)
  8003df:	e8 e6 00 00 00       	call   8004ca <CheckSorted>
  8003e4:	83 c4 10             	add    $0x10,%esp
  8003e7:	89 45 b4             	mov    %eax,-0x4c(%ebp)
	if(sorted == 0) panic("The array is NOT merge-sorted correctly") ;
  8003ea:	83 7d b4 00          	cmpl   $0x0,-0x4c(%ebp)
  8003ee:	75 14                	jne    800404 <_main+0x3cc>
  8003f0:	83 ec 04             	sub    $0x4,%esp
  8003f3:	68 cc 28 80 00       	push   $0x8028cc
  8003f8:	6a 64                	push   $0x64
  8003fa:	68 ac 28 80 00       	push   $0x8028ac
  8003ff:	e8 7c 04 00 00       	call   800880 <_panic>
	int correctMean, correctVar ;
	ArrayStats(Elements, NumOfElements, &correctMean , &correctVar);
  800404:	8d 85 78 ff ff ff    	lea    -0x88(%ebp),%eax
  80040a:	50                   	push   %eax
  80040b:	8d 85 7c ff ff ff    	lea    -0x84(%ebp),%eax
  800411:	50                   	push   %eax
  800412:	ff 75 f0             	pushl  -0x10(%ebp)
  800415:	ff 75 ec             	pushl  -0x14(%ebp)
  800418:	e8 b6 01 00 00       	call   8005d3 <ArrayStats>
  80041d:	83 c4 10             	add    $0x10,%esp
	int correctMin = quicksortedArr[0];
  800420:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800423:	8b 00                	mov    (%eax),%eax
  800425:	89 45 b0             	mov    %eax,-0x50(%ebp)
	int last = NumOfElements-1;
  800428:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80042b:	48                   	dec    %eax
  80042c:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int middle = (NumOfElements-1)/2;
  80042f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800432:	48                   	dec    %eax
  800433:	89 c2                	mov    %eax,%edx
  800435:	c1 ea 1f             	shr    $0x1f,%edx
  800438:	01 d0                	add    %edx,%eax
  80043a:	d1 f8                	sar    %eax
  80043c:	89 45 a8             	mov    %eax,-0x58(%ebp)
	int correctMax = quicksortedArr[last];
  80043f:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800442:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800449:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80044c:	01 d0                	add    %edx,%eax
  80044e:	8b 00                	mov    (%eax),%eax
  800450:	89 45 a4             	mov    %eax,-0x5c(%ebp)
	int correctMed = quicksortedArr[middle];
  800453:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800456:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800460:	01 d0                	add    %edx,%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	89 45 a0             	mov    %eax,-0x60(%ebp)
	//cprintf("Array is correctly sorted\n");
	//cprintf("mean = %d, var = %d\nmin = %d, max = %d, med = %d\n", *mean, *var, *min, *max, *med);
	//cprintf("mean = %d, var = %d\nmin = %d, max = %d, med = %d\n", correctMean, correctVar, correctMin, correctMax, correctMed);

	if(*mean != correctMean || *var != correctVar|| *min != correctMin || *max != correctMax || *med != correctMed)
  800467:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80046a:	8b 10                	mov    (%eax),%edx
  80046c:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800472:	39 c2                	cmp    %eax,%edx
  800474:	75 2d                	jne    8004a3 <_main+0x46b>
  800476:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800479:	8b 10                	mov    (%eax),%edx
  80047b:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800481:	39 c2                	cmp    %eax,%edx
  800483:	75 1e                	jne    8004a3 <_main+0x46b>
  800485:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800488:	8b 00                	mov    (%eax),%eax
  80048a:	3b 45 b0             	cmp    -0x50(%ebp),%eax
  80048d:	75 14                	jne    8004a3 <_main+0x46b>
  80048f:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800492:	8b 00                	mov    (%eax),%eax
  800494:	3b 45 a4             	cmp    -0x5c(%ebp),%eax
  800497:	75 0a                	jne    8004a3 <_main+0x46b>
  800499:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80049c:	8b 00                	mov    (%eax),%eax
  80049e:	3b 45 a0             	cmp    -0x60(%ebp),%eax
  8004a1:	74 14                	je     8004b7 <_main+0x47f>
		panic("The array STATS are NOT calculated correctly") ;
  8004a3:	83 ec 04             	sub    $0x4,%esp
  8004a6:	68 f4 28 80 00       	push   $0x8028f4
  8004ab:	6a 71                	push   $0x71
  8004ad:	68 ac 28 80 00       	push   $0x8028ac
  8004b2:	e8 c9 03 00 00       	call   800880 <_panic>

	cprintf("Congratulations!! Scenario of Using the Shared Variables [Create & Get] completed successfully!!\n\n\n");
  8004b7:	83 ec 0c             	sub    $0xc,%esp
  8004ba:	68 24 29 80 00       	push   $0x802924
  8004bf:	e8 5e 06 00 00       	call   800b22 <cprintf>
  8004c4:	83 c4 10             	add    $0x10,%esp

	return;
  8004c7:	90                   	nop
}
  8004c8:	c9                   	leave  
  8004c9:	c3                   	ret    

008004ca <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8004ca:	55                   	push   %ebp
  8004cb:	89 e5                	mov    %esp,%ebp
  8004cd:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8004d0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8004d7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8004de:	eb 33                	jmp    800513 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8004e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8004e3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ed:	01 d0                	add    %edx,%eax
  8004ef:	8b 10                	mov    (%eax),%edx
  8004f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8004f4:	40                   	inc    %eax
  8004f5:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ff:	01 c8                	add    %ecx,%eax
  800501:	8b 00                	mov    (%eax),%eax
  800503:	39 c2                	cmp    %eax,%edx
  800505:	7e 09                	jle    800510 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800507:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80050e:	eb 0c                	jmp    80051c <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800510:	ff 45 f8             	incl   -0x8(%ebp)
  800513:	8b 45 0c             	mov    0xc(%ebp),%eax
  800516:	48                   	dec    %eax
  800517:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80051a:	7f c4                	jg     8004e0 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  80051c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80051f:	c9                   	leave  
  800520:	c3                   	ret    

00800521 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800521:	55                   	push   %ebp
  800522:	89 e5                	mov    %esp,%ebp
  800524:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800527:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80052e:	eb 17                	jmp    800547 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800530:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800533:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80053a:	8b 45 08             	mov    0x8(%ebp),%eax
  80053d:	01 c2                	add    %eax,%edx
  80053f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800542:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800544:	ff 45 fc             	incl   -0x4(%ebp)
  800547:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80054a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80054d:	7c e1                	jl     800530 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80054f:	90                   	nop
  800550:	c9                   	leave  
  800551:	c3                   	ret    

00800552 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800552:	55                   	push   %ebp
  800553:	89 e5                	mov    %esp,%ebp
  800555:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800558:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80055f:	eb 1b                	jmp    80057c <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800561:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800564:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80056b:	8b 45 08             	mov    0x8(%ebp),%eax
  80056e:	01 c2                	add    %eax,%edx
  800570:	8b 45 0c             	mov    0xc(%ebp),%eax
  800573:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800576:	48                   	dec    %eax
  800577:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800579:	ff 45 fc             	incl   -0x4(%ebp)
  80057c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80057f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800582:	7c dd                	jl     800561 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800584:	90                   	nop
  800585:	c9                   	leave  
  800586:	c3                   	ret    

00800587 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800587:	55                   	push   %ebp
  800588:	89 e5                	mov    %esp,%ebp
  80058a:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80058d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800590:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800595:	f7 e9                	imul   %ecx
  800597:	c1 f9 1f             	sar    $0x1f,%ecx
  80059a:	89 d0                	mov    %edx,%eax
  80059c:	29 c8                	sub    %ecx,%eax
  80059e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8005a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8005a8:	eb 1e                	jmp    8005c8 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8005aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8005ad:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b7:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8005ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8005bd:	99                   	cltd   
  8005be:	f7 7d f8             	idivl  -0x8(%ebp)
  8005c1:	89 d0                	mov    %edx,%eax
  8005c3:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8005c5:	ff 45 fc             	incl   -0x4(%ebp)
  8005c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8005cb:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005ce:	7c da                	jl     8005aa <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//cprintf("Elements[%d] = %d\n",i, Elements[i]);
	}

}
  8005d0:	90                   	nop
  8005d1:	c9                   	leave  
  8005d2:	c3                   	ret    

008005d3 <ArrayStats>:

void ArrayStats(int *Elements, int NumOfElements, int *mean, int *var)
{
  8005d3:	55                   	push   %ebp
  8005d4:	89 e5                	mov    %esp,%ebp
  8005d6:	53                   	push   %ebx
  8005d7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	*mean =0 ;
  8005da:	8b 45 10             	mov    0x10(%ebp),%eax
  8005dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	for (i = 0 ; i < NumOfElements ; i++)
  8005e3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8005ea:	eb 20                	jmp    80060c <ArrayStats+0x39>
	{
		*mean += Elements[i];
  8005ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8005ef:	8b 10                	mov    (%eax),%edx
  8005f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8005f4:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fe:	01 c8                	add    %ecx,%eax
  800600:	8b 00                	mov    (%eax),%eax
  800602:	01 c2                	add    %eax,%edx
  800604:	8b 45 10             	mov    0x10(%ebp),%eax
  800607:	89 10                	mov    %edx,(%eax)

void ArrayStats(int *Elements, int NumOfElements, int *mean, int *var)
{
	int i ;
	*mean =0 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800609:	ff 45 f8             	incl   -0x8(%ebp)
  80060c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80060f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800612:	7c d8                	jl     8005ec <ArrayStats+0x19>
	{
		*mean += Elements[i];
	}
	*mean /= NumOfElements;
  800614:	8b 45 10             	mov    0x10(%ebp),%eax
  800617:	8b 00                	mov    (%eax),%eax
  800619:	99                   	cltd   
  80061a:	f7 7d 0c             	idivl  0xc(%ebp)
  80061d:	89 c2                	mov    %eax,%edx
  80061f:	8b 45 10             	mov    0x10(%ebp),%eax
  800622:	89 10                	mov    %edx,(%eax)
	*var = 0;
  800624:	8b 45 14             	mov    0x14(%ebp),%eax
  800627:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	for (i = 0 ; i < NumOfElements ; i++)
  80062d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800634:	eb 46                	jmp    80067c <ArrayStats+0xa9>
	{
		*var += (Elements[i] - *mean)*(Elements[i] - *mean);
  800636:	8b 45 14             	mov    0x14(%ebp),%eax
  800639:	8b 10                	mov    (%eax),%edx
  80063b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80063e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800645:	8b 45 08             	mov    0x8(%ebp),%eax
  800648:	01 c8                	add    %ecx,%eax
  80064a:	8b 08                	mov    (%eax),%ecx
  80064c:	8b 45 10             	mov    0x10(%ebp),%eax
  80064f:	8b 00                	mov    (%eax),%eax
  800651:	89 cb                	mov    %ecx,%ebx
  800653:	29 c3                	sub    %eax,%ebx
  800655:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800658:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80065f:	8b 45 08             	mov    0x8(%ebp),%eax
  800662:	01 c8                	add    %ecx,%eax
  800664:	8b 08                	mov    (%eax),%ecx
  800666:	8b 45 10             	mov    0x10(%ebp),%eax
  800669:	8b 00                	mov    (%eax),%eax
  80066b:	29 c1                	sub    %eax,%ecx
  80066d:	89 c8                	mov    %ecx,%eax
  80066f:	0f af c3             	imul   %ebx,%eax
  800672:	01 c2                	add    %eax,%edx
  800674:	8b 45 14             	mov    0x14(%ebp),%eax
  800677:	89 10                	mov    %edx,(%eax)
	{
		*mean += Elements[i];
	}
	*mean /= NumOfElements;
	*var = 0;
	for (i = 0 ; i < NumOfElements ; i++)
  800679:	ff 45 f8             	incl   -0x8(%ebp)
  80067c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80067f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800682:	7c b2                	jl     800636 <ArrayStats+0x63>
	{
		*var += (Elements[i] - *mean)*(Elements[i] - *mean);
	}
	*var /= NumOfElements;
  800684:	8b 45 14             	mov    0x14(%ebp),%eax
  800687:	8b 00                	mov    (%eax),%eax
  800689:	99                   	cltd   
  80068a:	f7 7d 0c             	idivl  0xc(%ebp)
  80068d:	89 c2                	mov    %eax,%edx
  80068f:	8b 45 14             	mov    0x14(%ebp),%eax
  800692:	89 10                	mov    %edx,(%eax)
}
  800694:	90                   	nop
  800695:	83 c4 10             	add    $0x10,%esp
  800698:	5b                   	pop    %ebx
  800699:	5d                   	pop    %ebp
  80069a:	c3                   	ret    

0080069b <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80069b:	55                   	push   %ebp
  80069c:	89 e5                	mov    %esp,%ebp
  80069e:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8006a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a4:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8006a7:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8006ab:	83 ec 0c             	sub    $0xc,%esp
  8006ae:	50                   	push   %eax
  8006af:	e8 4d 1a 00 00       	call   802101 <sys_cputc>
  8006b4:	83 c4 10             	add    $0x10,%esp
}
  8006b7:	90                   	nop
  8006b8:	c9                   	leave  
  8006b9:	c3                   	ret    

008006ba <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8006ba:	55                   	push   %ebp
  8006bb:	89 e5                	mov    %esp,%ebp
  8006bd:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8006c0:	e8 08 1a 00 00       	call   8020cd <sys_disable_interrupt>
	char c = ch;
  8006c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c8:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8006cb:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8006cf:	83 ec 0c             	sub    $0xc,%esp
  8006d2:	50                   	push   %eax
  8006d3:	e8 29 1a 00 00       	call   802101 <sys_cputc>
  8006d8:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006db:	e8 07 1a 00 00       	call   8020e7 <sys_enable_interrupt>
}
  8006e0:	90                   	nop
  8006e1:	c9                   	leave  
  8006e2:	c3                   	ret    

008006e3 <getchar>:

int
getchar(void)
{
  8006e3:	55                   	push   %ebp
  8006e4:	89 e5                	mov    %esp,%ebp
  8006e6:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8006e9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8006f0:	eb 08                	jmp    8006fa <getchar+0x17>
	{
		c = sys_cgetc();
  8006f2:	e8 ee 17 00 00       	call   801ee5 <sys_cgetc>
  8006f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8006fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8006fe:	74 f2                	je     8006f2 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  800700:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800703:	c9                   	leave  
  800704:	c3                   	ret    

00800705 <atomic_getchar>:

int
atomic_getchar(void)
{
  800705:	55                   	push   %ebp
  800706:	89 e5                	mov    %esp,%ebp
  800708:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80070b:	e8 bd 19 00 00       	call   8020cd <sys_disable_interrupt>
	int c=0;
  800710:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800717:	eb 08                	jmp    800721 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800719:	e8 c7 17 00 00       	call   801ee5 <sys_cgetc>
  80071e:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  800721:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800725:	74 f2                	je     800719 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800727:	e8 bb 19 00 00       	call   8020e7 <sys_enable_interrupt>
	return c;
  80072c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80072f:	c9                   	leave  
  800730:	c3                   	ret    

00800731 <iscons>:

int iscons(int fdnum)
{
  800731:	55                   	push   %ebp
  800732:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800734:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800739:	5d                   	pop    %ebp
  80073a:	c3                   	ret    

0080073b <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80073b:	55                   	push   %ebp
  80073c:	89 e5                	mov    %esp,%ebp
  80073e:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800741:	e8 ec 17 00 00       	call   801f32 <sys_getenvindex>
  800746:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800749:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80074c:	89 d0                	mov    %edx,%eax
  80074e:	c1 e0 03             	shl    $0x3,%eax
  800751:	01 d0                	add    %edx,%eax
  800753:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80075a:	01 c8                	add    %ecx,%eax
  80075c:	01 c0                	add    %eax,%eax
  80075e:	01 d0                	add    %edx,%eax
  800760:	01 c0                	add    %eax,%eax
  800762:	01 d0                	add    %edx,%eax
  800764:	89 c2                	mov    %eax,%edx
  800766:	c1 e2 05             	shl    $0x5,%edx
  800769:	29 c2                	sub    %eax,%edx
  80076b:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800772:	89 c2                	mov    %eax,%edx
  800774:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80077a:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80077f:	a1 20 40 80 00       	mov    0x804020,%eax
  800784:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80078a:	84 c0                	test   %al,%al
  80078c:	74 0f                	je     80079d <libmain+0x62>
		binaryname = myEnv->prog_name;
  80078e:	a1 20 40 80 00       	mov    0x804020,%eax
  800793:	05 40 3c 01 00       	add    $0x13c40,%eax
  800798:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80079d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8007a1:	7e 0a                	jle    8007ad <libmain+0x72>
		binaryname = argv[0];
  8007a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007a6:	8b 00                	mov    (%eax),%eax
  8007a8:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  8007ad:	83 ec 08             	sub    $0x8,%esp
  8007b0:	ff 75 0c             	pushl  0xc(%ebp)
  8007b3:	ff 75 08             	pushl  0x8(%ebp)
  8007b6:	e8 7d f8 ff ff       	call   800038 <_main>
  8007bb:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8007be:	e8 0a 19 00 00       	call   8020cd <sys_disable_interrupt>
	cprintf("**************************************\n");
  8007c3:	83 ec 0c             	sub    $0xc,%esp
  8007c6:	68 a0 29 80 00       	push   $0x8029a0
  8007cb:	e8 52 03 00 00       	call   800b22 <cprintf>
  8007d0:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8007d3:	a1 20 40 80 00       	mov    0x804020,%eax
  8007d8:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8007de:	a1 20 40 80 00       	mov    0x804020,%eax
  8007e3:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8007e9:	83 ec 04             	sub    $0x4,%esp
  8007ec:	52                   	push   %edx
  8007ed:	50                   	push   %eax
  8007ee:	68 c8 29 80 00       	push   $0x8029c8
  8007f3:	e8 2a 03 00 00       	call   800b22 <cprintf>
  8007f8:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8007fb:	a1 20 40 80 00       	mov    0x804020,%eax
  800800:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800806:	a1 20 40 80 00       	mov    0x804020,%eax
  80080b:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800811:	83 ec 04             	sub    $0x4,%esp
  800814:	52                   	push   %edx
  800815:	50                   	push   %eax
  800816:	68 f0 29 80 00       	push   $0x8029f0
  80081b:	e8 02 03 00 00       	call   800b22 <cprintf>
  800820:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800823:	a1 20 40 80 00       	mov    0x804020,%eax
  800828:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80082e:	83 ec 08             	sub    $0x8,%esp
  800831:	50                   	push   %eax
  800832:	68 31 2a 80 00       	push   $0x802a31
  800837:	e8 e6 02 00 00       	call   800b22 <cprintf>
  80083c:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80083f:	83 ec 0c             	sub    $0xc,%esp
  800842:	68 a0 29 80 00       	push   $0x8029a0
  800847:	e8 d6 02 00 00       	call   800b22 <cprintf>
  80084c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80084f:	e8 93 18 00 00       	call   8020e7 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800854:	e8 19 00 00 00       	call   800872 <exit>
}
  800859:	90                   	nop
  80085a:	c9                   	leave  
  80085b:	c3                   	ret    

0080085c <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80085c:	55                   	push   %ebp
  80085d:	89 e5                	mov    %esp,%ebp
  80085f:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800862:	83 ec 0c             	sub    $0xc,%esp
  800865:	6a 00                	push   $0x0
  800867:	e8 92 16 00 00       	call   801efe <sys_env_destroy>
  80086c:	83 c4 10             	add    $0x10,%esp
}
  80086f:	90                   	nop
  800870:	c9                   	leave  
  800871:	c3                   	ret    

00800872 <exit>:

void
exit(void)
{
  800872:	55                   	push   %ebp
  800873:	89 e5                	mov    %esp,%ebp
  800875:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800878:	e8 e7 16 00 00       	call   801f64 <sys_env_exit>
}
  80087d:	90                   	nop
  80087e:	c9                   	leave  
  80087f:	c3                   	ret    

00800880 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800880:	55                   	push   %ebp
  800881:	89 e5                	mov    %esp,%ebp
  800883:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800886:	8d 45 10             	lea    0x10(%ebp),%eax
  800889:	83 c0 04             	add    $0x4,%eax
  80088c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80088f:	a1 18 41 80 00       	mov    0x804118,%eax
  800894:	85 c0                	test   %eax,%eax
  800896:	74 16                	je     8008ae <_panic+0x2e>
		cprintf("%s: ", argv0);
  800898:	a1 18 41 80 00       	mov    0x804118,%eax
  80089d:	83 ec 08             	sub    $0x8,%esp
  8008a0:	50                   	push   %eax
  8008a1:	68 48 2a 80 00       	push   $0x802a48
  8008a6:	e8 77 02 00 00       	call   800b22 <cprintf>
  8008ab:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8008ae:	a1 00 40 80 00       	mov    0x804000,%eax
  8008b3:	ff 75 0c             	pushl  0xc(%ebp)
  8008b6:	ff 75 08             	pushl  0x8(%ebp)
  8008b9:	50                   	push   %eax
  8008ba:	68 4d 2a 80 00       	push   $0x802a4d
  8008bf:	e8 5e 02 00 00       	call   800b22 <cprintf>
  8008c4:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8008c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8008ca:	83 ec 08             	sub    $0x8,%esp
  8008cd:	ff 75 f4             	pushl  -0xc(%ebp)
  8008d0:	50                   	push   %eax
  8008d1:	e8 e1 01 00 00       	call   800ab7 <vcprintf>
  8008d6:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8008d9:	83 ec 08             	sub    $0x8,%esp
  8008dc:	6a 00                	push   $0x0
  8008de:	68 69 2a 80 00       	push   $0x802a69
  8008e3:	e8 cf 01 00 00       	call   800ab7 <vcprintf>
  8008e8:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8008eb:	e8 82 ff ff ff       	call   800872 <exit>

	// should not return here
	while (1) ;
  8008f0:	eb fe                	jmp    8008f0 <_panic+0x70>

008008f2 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8008f2:	55                   	push   %ebp
  8008f3:	89 e5                	mov    %esp,%ebp
  8008f5:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8008f8:	a1 20 40 80 00       	mov    0x804020,%eax
  8008fd:	8b 50 74             	mov    0x74(%eax),%edx
  800900:	8b 45 0c             	mov    0xc(%ebp),%eax
  800903:	39 c2                	cmp    %eax,%edx
  800905:	74 14                	je     80091b <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800907:	83 ec 04             	sub    $0x4,%esp
  80090a:	68 6c 2a 80 00       	push   $0x802a6c
  80090f:	6a 26                	push   $0x26
  800911:	68 b8 2a 80 00       	push   $0x802ab8
  800916:	e8 65 ff ff ff       	call   800880 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80091b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800922:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800929:	e9 b6 00 00 00       	jmp    8009e4 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80092e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800931:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800938:	8b 45 08             	mov    0x8(%ebp),%eax
  80093b:	01 d0                	add    %edx,%eax
  80093d:	8b 00                	mov    (%eax),%eax
  80093f:	85 c0                	test   %eax,%eax
  800941:	75 08                	jne    80094b <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800943:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800946:	e9 96 00 00 00       	jmp    8009e1 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80094b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800952:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800959:	eb 5d                	jmp    8009b8 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80095b:	a1 20 40 80 00       	mov    0x804020,%eax
  800960:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800966:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800969:	c1 e2 04             	shl    $0x4,%edx
  80096c:	01 d0                	add    %edx,%eax
  80096e:	8a 40 04             	mov    0x4(%eax),%al
  800971:	84 c0                	test   %al,%al
  800973:	75 40                	jne    8009b5 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800975:	a1 20 40 80 00       	mov    0x804020,%eax
  80097a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800980:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800983:	c1 e2 04             	shl    $0x4,%edx
  800986:	01 d0                	add    %edx,%eax
  800988:	8b 00                	mov    (%eax),%eax
  80098a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80098d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800990:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800995:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800997:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80099a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8009a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a4:	01 c8                	add    %ecx,%eax
  8009a6:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009a8:	39 c2                	cmp    %eax,%edx
  8009aa:	75 09                	jne    8009b5 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8009ac:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8009b3:	eb 12                	jmp    8009c7 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009b5:	ff 45 e8             	incl   -0x18(%ebp)
  8009b8:	a1 20 40 80 00       	mov    0x804020,%eax
  8009bd:	8b 50 74             	mov    0x74(%eax),%edx
  8009c0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8009c3:	39 c2                	cmp    %eax,%edx
  8009c5:	77 94                	ja     80095b <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8009c7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8009cb:	75 14                	jne    8009e1 <CheckWSWithoutLastIndex+0xef>
			panic(
  8009cd:	83 ec 04             	sub    $0x4,%esp
  8009d0:	68 c4 2a 80 00       	push   $0x802ac4
  8009d5:	6a 3a                	push   $0x3a
  8009d7:	68 b8 2a 80 00       	push   $0x802ab8
  8009dc:	e8 9f fe ff ff       	call   800880 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8009e1:	ff 45 f0             	incl   -0x10(%ebp)
  8009e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009e7:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8009ea:	0f 8c 3e ff ff ff    	jl     80092e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8009f0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009f7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8009fe:	eb 20                	jmp    800a20 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a00:	a1 20 40 80 00       	mov    0x804020,%eax
  800a05:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800a0b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a0e:	c1 e2 04             	shl    $0x4,%edx
  800a11:	01 d0                	add    %edx,%eax
  800a13:	8a 40 04             	mov    0x4(%eax),%al
  800a16:	3c 01                	cmp    $0x1,%al
  800a18:	75 03                	jne    800a1d <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800a1a:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a1d:	ff 45 e0             	incl   -0x20(%ebp)
  800a20:	a1 20 40 80 00       	mov    0x804020,%eax
  800a25:	8b 50 74             	mov    0x74(%eax),%edx
  800a28:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a2b:	39 c2                	cmp    %eax,%edx
  800a2d:	77 d1                	ja     800a00 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a32:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a35:	74 14                	je     800a4b <CheckWSWithoutLastIndex+0x159>
		panic(
  800a37:	83 ec 04             	sub    $0x4,%esp
  800a3a:	68 18 2b 80 00       	push   $0x802b18
  800a3f:	6a 44                	push   $0x44
  800a41:	68 b8 2a 80 00       	push   $0x802ab8
  800a46:	e8 35 fe ff ff       	call   800880 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800a4b:	90                   	nop
  800a4c:	c9                   	leave  
  800a4d:	c3                   	ret    

00800a4e <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800a4e:	55                   	push   %ebp
  800a4f:	89 e5                	mov    %esp,%ebp
  800a51:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800a54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a57:	8b 00                	mov    (%eax),%eax
  800a59:	8d 48 01             	lea    0x1(%eax),%ecx
  800a5c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a5f:	89 0a                	mov    %ecx,(%edx)
  800a61:	8b 55 08             	mov    0x8(%ebp),%edx
  800a64:	88 d1                	mov    %dl,%cl
  800a66:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a69:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800a6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a70:	8b 00                	mov    (%eax),%eax
  800a72:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a77:	75 2c                	jne    800aa5 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800a79:	a0 24 40 80 00       	mov    0x804024,%al
  800a7e:	0f b6 c0             	movzbl %al,%eax
  800a81:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a84:	8b 12                	mov    (%edx),%edx
  800a86:	89 d1                	mov    %edx,%ecx
  800a88:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a8b:	83 c2 08             	add    $0x8,%edx
  800a8e:	83 ec 04             	sub    $0x4,%esp
  800a91:	50                   	push   %eax
  800a92:	51                   	push   %ecx
  800a93:	52                   	push   %edx
  800a94:	e8 23 14 00 00       	call   801ebc <sys_cputs>
  800a99:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800aa5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa8:	8b 40 04             	mov    0x4(%eax),%eax
  800aab:	8d 50 01             	lea    0x1(%eax),%edx
  800aae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab1:	89 50 04             	mov    %edx,0x4(%eax)
}
  800ab4:	90                   	nop
  800ab5:	c9                   	leave  
  800ab6:	c3                   	ret    

00800ab7 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800ab7:	55                   	push   %ebp
  800ab8:	89 e5                	mov    %esp,%ebp
  800aba:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800ac0:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800ac7:	00 00 00 
	b.cnt = 0;
  800aca:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800ad1:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800ad4:	ff 75 0c             	pushl  0xc(%ebp)
  800ad7:	ff 75 08             	pushl  0x8(%ebp)
  800ada:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ae0:	50                   	push   %eax
  800ae1:	68 4e 0a 80 00       	push   $0x800a4e
  800ae6:	e8 11 02 00 00       	call   800cfc <vprintfmt>
  800aeb:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800aee:	a0 24 40 80 00       	mov    0x804024,%al
  800af3:	0f b6 c0             	movzbl %al,%eax
  800af6:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800afc:	83 ec 04             	sub    $0x4,%esp
  800aff:	50                   	push   %eax
  800b00:	52                   	push   %edx
  800b01:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b07:	83 c0 08             	add    $0x8,%eax
  800b0a:	50                   	push   %eax
  800b0b:	e8 ac 13 00 00       	call   801ebc <sys_cputs>
  800b10:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b13:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  800b1a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b20:	c9                   	leave  
  800b21:	c3                   	ret    

00800b22 <cprintf>:

int cprintf(const char *fmt, ...) {
  800b22:	55                   	push   %ebp
  800b23:	89 e5                	mov    %esp,%ebp
  800b25:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b28:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  800b2f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b32:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b35:	8b 45 08             	mov    0x8(%ebp),%eax
  800b38:	83 ec 08             	sub    $0x8,%esp
  800b3b:	ff 75 f4             	pushl  -0xc(%ebp)
  800b3e:	50                   	push   %eax
  800b3f:	e8 73 ff ff ff       	call   800ab7 <vcprintf>
  800b44:	83 c4 10             	add    $0x10,%esp
  800b47:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800b4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b4d:	c9                   	leave  
  800b4e:	c3                   	ret    

00800b4f <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800b4f:	55                   	push   %ebp
  800b50:	89 e5                	mov    %esp,%ebp
  800b52:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800b55:	e8 73 15 00 00       	call   8020cd <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800b5a:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b5d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b60:	8b 45 08             	mov    0x8(%ebp),%eax
  800b63:	83 ec 08             	sub    $0x8,%esp
  800b66:	ff 75 f4             	pushl  -0xc(%ebp)
  800b69:	50                   	push   %eax
  800b6a:	e8 48 ff ff ff       	call   800ab7 <vcprintf>
  800b6f:	83 c4 10             	add    $0x10,%esp
  800b72:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800b75:	e8 6d 15 00 00       	call   8020e7 <sys_enable_interrupt>
	return cnt;
  800b7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b7d:	c9                   	leave  
  800b7e:	c3                   	ret    

00800b7f <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800b7f:	55                   	push   %ebp
  800b80:	89 e5                	mov    %esp,%ebp
  800b82:	53                   	push   %ebx
  800b83:	83 ec 14             	sub    $0x14,%esp
  800b86:	8b 45 10             	mov    0x10(%ebp),%eax
  800b89:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b8c:	8b 45 14             	mov    0x14(%ebp),%eax
  800b8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800b92:	8b 45 18             	mov    0x18(%ebp),%eax
  800b95:	ba 00 00 00 00       	mov    $0x0,%edx
  800b9a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b9d:	77 55                	ja     800bf4 <printnum+0x75>
  800b9f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ba2:	72 05                	jb     800ba9 <printnum+0x2a>
  800ba4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ba7:	77 4b                	ja     800bf4 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800ba9:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800bac:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800baf:	8b 45 18             	mov    0x18(%ebp),%eax
  800bb2:	ba 00 00 00 00       	mov    $0x0,%edx
  800bb7:	52                   	push   %edx
  800bb8:	50                   	push   %eax
  800bb9:	ff 75 f4             	pushl  -0xc(%ebp)
  800bbc:	ff 75 f0             	pushl  -0x10(%ebp)
  800bbf:	e8 2c 19 00 00       	call   8024f0 <__udivdi3>
  800bc4:	83 c4 10             	add    $0x10,%esp
  800bc7:	83 ec 04             	sub    $0x4,%esp
  800bca:	ff 75 20             	pushl  0x20(%ebp)
  800bcd:	53                   	push   %ebx
  800bce:	ff 75 18             	pushl  0x18(%ebp)
  800bd1:	52                   	push   %edx
  800bd2:	50                   	push   %eax
  800bd3:	ff 75 0c             	pushl  0xc(%ebp)
  800bd6:	ff 75 08             	pushl  0x8(%ebp)
  800bd9:	e8 a1 ff ff ff       	call   800b7f <printnum>
  800bde:	83 c4 20             	add    $0x20,%esp
  800be1:	eb 1a                	jmp    800bfd <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800be3:	83 ec 08             	sub    $0x8,%esp
  800be6:	ff 75 0c             	pushl  0xc(%ebp)
  800be9:	ff 75 20             	pushl  0x20(%ebp)
  800bec:	8b 45 08             	mov    0x8(%ebp),%eax
  800bef:	ff d0                	call   *%eax
  800bf1:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800bf4:	ff 4d 1c             	decl   0x1c(%ebp)
  800bf7:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800bfb:	7f e6                	jg     800be3 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800bfd:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c00:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c05:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c08:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c0b:	53                   	push   %ebx
  800c0c:	51                   	push   %ecx
  800c0d:	52                   	push   %edx
  800c0e:	50                   	push   %eax
  800c0f:	e8 ec 19 00 00       	call   802600 <__umoddi3>
  800c14:	83 c4 10             	add    $0x10,%esp
  800c17:	05 94 2d 80 00       	add    $0x802d94,%eax
  800c1c:	8a 00                	mov    (%eax),%al
  800c1e:	0f be c0             	movsbl %al,%eax
  800c21:	83 ec 08             	sub    $0x8,%esp
  800c24:	ff 75 0c             	pushl  0xc(%ebp)
  800c27:	50                   	push   %eax
  800c28:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2b:	ff d0                	call   *%eax
  800c2d:	83 c4 10             	add    $0x10,%esp
}
  800c30:	90                   	nop
  800c31:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c34:	c9                   	leave  
  800c35:	c3                   	ret    

00800c36 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c36:	55                   	push   %ebp
  800c37:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c39:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c3d:	7e 1c                	jle    800c5b <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c42:	8b 00                	mov    (%eax),%eax
  800c44:	8d 50 08             	lea    0x8(%eax),%edx
  800c47:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4a:	89 10                	mov    %edx,(%eax)
  800c4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4f:	8b 00                	mov    (%eax),%eax
  800c51:	83 e8 08             	sub    $0x8,%eax
  800c54:	8b 50 04             	mov    0x4(%eax),%edx
  800c57:	8b 00                	mov    (%eax),%eax
  800c59:	eb 40                	jmp    800c9b <getuint+0x65>
	else if (lflag)
  800c5b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c5f:	74 1e                	je     800c7f <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800c61:	8b 45 08             	mov    0x8(%ebp),%eax
  800c64:	8b 00                	mov    (%eax),%eax
  800c66:	8d 50 04             	lea    0x4(%eax),%edx
  800c69:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6c:	89 10                	mov    %edx,(%eax)
  800c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c71:	8b 00                	mov    (%eax),%eax
  800c73:	83 e8 04             	sub    $0x4,%eax
  800c76:	8b 00                	mov    (%eax),%eax
  800c78:	ba 00 00 00 00       	mov    $0x0,%edx
  800c7d:	eb 1c                	jmp    800c9b <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c82:	8b 00                	mov    (%eax),%eax
  800c84:	8d 50 04             	lea    0x4(%eax),%edx
  800c87:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8a:	89 10                	mov    %edx,(%eax)
  800c8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8f:	8b 00                	mov    (%eax),%eax
  800c91:	83 e8 04             	sub    $0x4,%eax
  800c94:	8b 00                	mov    (%eax),%eax
  800c96:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800c9b:	5d                   	pop    %ebp
  800c9c:	c3                   	ret    

00800c9d <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800c9d:	55                   	push   %ebp
  800c9e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ca0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ca4:	7e 1c                	jle    800cc2 <getint+0x25>
		return va_arg(*ap, long long);
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	8b 00                	mov    (%eax),%eax
  800cab:	8d 50 08             	lea    0x8(%eax),%edx
  800cae:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb1:	89 10                	mov    %edx,(%eax)
  800cb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb6:	8b 00                	mov    (%eax),%eax
  800cb8:	83 e8 08             	sub    $0x8,%eax
  800cbb:	8b 50 04             	mov    0x4(%eax),%edx
  800cbe:	8b 00                	mov    (%eax),%eax
  800cc0:	eb 38                	jmp    800cfa <getint+0x5d>
	else if (lflag)
  800cc2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cc6:	74 1a                	je     800ce2 <getint+0x45>
		return va_arg(*ap, long);
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	8b 00                	mov    (%eax),%eax
  800ccd:	8d 50 04             	lea    0x4(%eax),%edx
  800cd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd3:	89 10                	mov    %edx,(%eax)
  800cd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd8:	8b 00                	mov    (%eax),%eax
  800cda:	83 e8 04             	sub    $0x4,%eax
  800cdd:	8b 00                	mov    (%eax),%eax
  800cdf:	99                   	cltd   
  800ce0:	eb 18                	jmp    800cfa <getint+0x5d>
	else
		return va_arg(*ap, int);
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	8b 00                	mov    (%eax),%eax
  800ce7:	8d 50 04             	lea    0x4(%eax),%edx
  800cea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ced:	89 10                	mov    %edx,(%eax)
  800cef:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf2:	8b 00                	mov    (%eax),%eax
  800cf4:	83 e8 04             	sub    $0x4,%eax
  800cf7:	8b 00                	mov    (%eax),%eax
  800cf9:	99                   	cltd   
}
  800cfa:	5d                   	pop    %ebp
  800cfb:	c3                   	ret    

00800cfc <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800cfc:	55                   	push   %ebp
  800cfd:	89 e5                	mov    %esp,%ebp
  800cff:	56                   	push   %esi
  800d00:	53                   	push   %ebx
  800d01:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d04:	eb 17                	jmp    800d1d <vprintfmt+0x21>
			if (ch == '\0')
  800d06:	85 db                	test   %ebx,%ebx
  800d08:	0f 84 af 03 00 00    	je     8010bd <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d0e:	83 ec 08             	sub    $0x8,%esp
  800d11:	ff 75 0c             	pushl  0xc(%ebp)
  800d14:	53                   	push   %ebx
  800d15:	8b 45 08             	mov    0x8(%ebp),%eax
  800d18:	ff d0                	call   *%eax
  800d1a:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d1d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d20:	8d 50 01             	lea    0x1(%eax),%edx
  800d23:	89 55 10             	mov    %edx,0x10(%ebp)
  800d26:	8a 00                	mov    (%eax),%al
  800d28:	0f b6 d8             	movzbl %al,%ebx
  800d2b:	83 fb 25             	cmp    $0x25,%ebx
  800d2e:	75 d6                	jne    800d06 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d30:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d34:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d3b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800d42:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800d49:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800d50:	8b 45 10             	mov    0x10(%ebp),%eax
  800d53:	8d 50 01             	lea    0x1(%eax),%edx
  800d56:	89 55 10             	mov    %edx,0x10(%ebp)
  800d59:	8a 00                	mov    (%eax),%al
  800d5b:	0f b6 d8             	movzbl %al,%ebx
  800d5e:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800d61:	83 f8 55             	cmp    $0x55,%eax
  800d64:	0f 87 2b 03 00 00    	ja     801095 <vprintfmt+0x399>
  800d6a:	8b 04 85 b8 2d 80 00 	mov    0x802db8(,%eax,4),%eax
  800d71:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800d73:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800d77:	eb d7                	jmp    800d50 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800d79:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800d7d:	eb d1                	jmp    800d50 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d7f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800d86:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d89:	89 d0                	mov    %edx,%eax
  800d8b:	c1 e0 02             	shl    $0x2,%eax
  800d8e:	01 d0                	add    %edx,%eax
  800d90:	01 c0                	add    %eax,%eax
  800d92:	01 d8                	add    %ebx,%eax
  800d94:	83 e8 30             	sub    $0x30,%eax
  800d97:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800d9a:	8b 45 10             	mov    0x10(%ebp),%eax
  800d9d:	8a 00                	mov    (%eax),%al
  800d9f:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800da2:	83 fb 2f             	cmp    $0x2f,%ebx
  800da5:	7e 3e                	jle    800de5 <vprintfmt+0xe9>
  800da7:	83 fb 39             	cmp    $0x39,%ebx
  800daa:	7f 39                	jg     800de5 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800dac:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800daf:	eb d5                	jmp    800d86 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800db1:	8b 45 14             	mov    0x14(%ebp),%eax
  800db4:	83 c0 04             	add    $0x4,%eax
  800db7:	89 45 14             	mov    %eax,0x14(%ebp)
  800dba:	8b 45 14             	mov    0x14(%ebp),%eax
  800dbd:	83 e8 04             	sub    $0x4,%eax
  800dc0:	8b 00                	mov    (%eax),%eax
  800dc2:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800dc5:	eb 1f                	jmp    800de6 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800dc7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dcb:	79 83                	jns    800d50 <vprintfmt+0x54>
				width = 0;
  800dcd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800dd4:	e9 77 ff ff ff       	jmp    800d50 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800dd9:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800de0:	e9 6b ff ff ff       	jmp    800d50 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800de5:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800de6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dea:	0f 89 60 ff ff ff    	jns    800d50 <vprintfmt+0x54>
				width = precision, precision = -1;
  800df0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800df3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800df6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800dfd:	e9 4e ff ff ff       	jmp    800d50 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e02:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e05:	e9 46 ff ff ff       	jmp    800d50 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e0a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e0d:	83 c0 04             	add    $0x4,%eax
  800e10:	89 45 14             	mov    %eax,0x14(%ebp)
  800e13:	8b 45 14             	mov    0x14(%ebp),%eax
  800e16:	83 e8 04             	sub    $0x4,%eax
  800e19:	8b 00                	mov    (%eax),%eax
  800e1b:	83 ec 08             	sub    $0x8,%esp
  800e1e:	ff 75 0c             	pushl  0xc(%ebp)
  800e21:	50                   	push   %eax
  800e22:	8b 45 08             	mov    0x8(%ebp),%eax
  800e25:	ff d0                	call   *%eax
  800e27:	83 c4 10             	add    $0x10,%esp
			break;
  800e2a:	e9 89 02 00 00       	jmp    8010b8 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e2f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e32:	83 c0 04             	add    $0x4,%eax
  800e35:	89 45 14             	mov    %eax,0x14(%ebp)
  800e38:	8b 45 14             	mov    0x14(%ebp),%eax
  800e3b:	83 e8 04             	sub    $0x4,%eax
  800e3e:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800e40:	85 db                	test   %ebx,%ebx
  800e42:	79 02                	jns    800e46 <vprintfmt+0x14a>
				err = -err;
  800e44:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800e46:	83 fb 64             	cmp    $0x64,%ebx
  800e49:	7f 0b                	jg     800e56 <vprintfmt+0x15a>
  800e4b:	8b 34 9d 00 2c 80 00 	mov    0x802c00(,%ebx,4),%esi
  800e52:	85 f6                	test   %esi,%esi
  800e54:	75 19                	jne    800e6f <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800e56:	53                   	push   %ebx
  800e57:	68 a5 2d 80 00       	push   $0x802da5
  800e5c:	ff 75 0c             	pushl  0xc(%ebp)
  800e5f:	ff 75 08             	pushl  0x8(%ebp)
  800e62:	e8 5e 02 00 00       	call   8010c5 <printfmt>
  800e67:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800e6a:	e9 49 02 00 00       	jmp    8010b8 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800e6f:	56                   	push   %esi
  800e70:	68 ae 2d 80 00       	push   $0x802dae
  800e75:	ff 75 0c             	pushl  0xc(%ebp)
  800e78:	ff 75 08             	pushl  0x8(%ebp)
  800e7b:	e8 45 02 00 00       	call   8010c5 <printfmt>
  800e80:	83 c4 10             	add    $0x10,%esp
			break;
  800e83:	e9 30 02 00 00       	jmp    8010b8 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800e88:	8b 45 14             	mov    0x14(%ebp),%eax
  800e8b:	83 c0 04             	add    $0x4,%eax
  800e8e:	89 45 14             	mov    %eax,0x14(%ebp)
  800e91:	8b 45 14             	mov    0x14(%ebp),%eax
  800e94:	83 e8 04             	sub    $0x4,%eax
  800e97:	8b 30                	mov    (%eax),%esi
  800e99:	85 f6                	test   %esi,%esi
  800e9b:	75 05                	jne    800ea2 <vprintfmt+0x1a6>
				p = "(null)";
  800e9d:	be b1 2d 80 00       	mov    $0x802db1,%esi
			if (width > 0 && padc != '-')
  800ea2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ea6:	7e 6d                	jle    800f15 <vprintfmt+0x219>
  800ea8:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800eac:	74 67                	je     800f15 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800eae:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800eb1:	83 ec 08             	sub    $0x8,%esp
  800eb4:	50                   	push   %eax
  800eb5:	56                   	push   %esi
  800eb6:	e8 12 05 00 00       	call   8013cd <strnlen>
  800ebb:	83 c4 10             	add    $0x10,%esp
  800ebe:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800ec1:	eb 16                	jmp    800ed9 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800ec3:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800ec7:	83 ec 08             	sub    $0x8,%esp
  800eca:	ff 75 0c             	pushl  0xc(%ebp)
  800ecd:	50                   	push   %eax
  800ece:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed1:	ff d0                	call   *%eax
  800ed3:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ed6:	ff 4d e4             	decl   -0x1c(%ebp)
  800ed9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800edd:	7f e4                	jg     800ec3 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800edf:	eb 34                	jmp    800f15 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800ee1:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800ee5:	74 1c                	je     800f03 <vprintfmt+0x207>
  800ee7:	83 fb 1f             	cmp    $0x1f,%ebx
  800eea:	7e 05                	jle    800ef1 <vprintfmt+0x1f5>
  800eec:	83 fb 7e             	cmp    $0x7e,%ebx
  800eef:	7e 12                	jle    800f03 <vprintfmt+0x207>
					putch('?', putdat);
  800ef1:	83 ec 08             	sub    $0x8,%esp
  800ef4:	ff 75 0c             	pushl  0xc(%ebp)
  800ef7:	6a 3f                	push   $0x3f
  800ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  800efc:	ff d0                	call   *%eax
  800efe:	83 c4 10             	add    $0x10,%esp
  800f01:	eb 0f                	jmp    800f12 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f03:	83 ec 08             	sub    $0x8,%esp
  800f06:	ff 75 0c             	pushl  0xc(%ebp)
  800f09:	53                   	push   %ebx
  800f0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0d:	ff d0                	call   *%eax
  800f0f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f12:	ff 4d e4             	decl   -0x1c(%ebp)
  800f15:	89 f0                	mov    %esi,%eax
  800f17:	8d 70 01             	lea    0x1(%eax),%esi
  800f1a:	8a 00                	mov    (%eax),%al
  800f1c:	0f be d8             	movsbl %al,%ebx
  800f1f:	85 db                	test   %ebx,%ebx
  800f21:	74 24                	je     800f47 <vprintfmt+0x24b>
  800f23:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f27:	78 b8                	js     800ee1 <vprintfmt+0x1e5>
  800f29:	ff 4d e0             	decl   -0x20(%ebp)
  800f2c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f30:	79 af                	jns    800ee1 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f32:	eb 13                	jmp    800f47 <vprintfmt+0x24b>
				putch(' ', putdat);
  800f34:	83 ec 08             	sub    $0x8,%esp
  800f37:	ff 75 0c             	pushl  0xc(%ebp)
  800f3a:	6a 20                	push   $0x20
  800f3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3f:	ff d0                	call   *%eax
  800f41:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f44:	ff 4d e4             	decl   -0x1c(%ebp)
  800f47:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f4b:	7f e7                	jg     800f34 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800f4d:	e9 66 01 00 00       	jmp    8010b8 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800f52:	83 ec 08             	sub    $0x8,%esp
  800f55:	ff 75 e8             	pushl  -0x18(%ebp)
  800f58:	8d 45 14             	lea    0x14(%ebp),%eax
  800f5b:	50                   	push   %eax
  800f5c:	e8 3c fd ff ff       	call   800c9d <getint>
  800f61:	83 c4 10             	add    $0x10,%esp
  800f64:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f67:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800f6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f6d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f70:	85 d2                	test   %edx,%edx
  800f72:	79 23                	jns    800f97 <vprintfmt+0x29b>
				putch('-', putdat);
  800f74:	83 ec 08             	sub    $0x8,%esp
  800f77:	ff 75 0c             	pushl  0xc(%ebp)
  800f7a:	6a 2d                	push   $0x2d
  800f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7f:	ff d0                	call   *%eax
  800f81:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800f84:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f87:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f8a:	f7 d8                	neg    %eax
  800f8c:	83 d2 00             	adc    $0x0,%edx
  800f8f:	f7 da                	neg    %edx
  800f91:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f94:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800f97:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f9e:	e9 bc 00 00 00       	jmp    80105f <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800fa3:	83 ec 08             	sub    $0x8,%esp
  800fa6:	ff 75 e8             	pushl  -0x18(%ebp)
  800fa9:	8d 45 14             	lea    0x14(%ebp),%eax
  800fac:	50                   	push   %eax
  800fad:	e8 84 fc ff ff       	call   800c36 <getuint>
  800fb2:	83 c4 10             	add    $0x10,%esp
  800fb5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fb8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800fbb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800fc2:	e9 98 00 00 00       	jmp    80105f <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800fc7:	83 ec 08             	sub    $0x8,%esp
  800fca:	ff 75 0c             	pushl  0xc(%ebp)
  800fcd:	6a 58                	push   $0x58
  800fcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd2:	ff d0                	call   *%eax
  800fd4:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800fd7:	83 ec 08             	sub    $0x8,%esp
  800fda:	ff 75 0c             	pushl  0xc(%ebp)
  800fdd:	6a 58                	push   $0x58
  800fdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe2:	ff d0                	call   *%eax
  800fe4:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800fe7:	83 ec 08             	sub    $0x8,%esp
  800fea:	ff 75 0c             	pushl  0xc(%ebp)
  800fed:	6a 58                	push   $0x58
  800fef:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff2:	ff d0                	call   *%eax
  800ff4:	83 c4 10             	add    $0x10,%esp
			break;
  800ff7:	e9 bc 00 00 00       	jmp    8010b8 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ffc:	83 ec 08             	sub    $0x8,%esp
  800fff:	ff 75 0c             	pushl  0xc(%ebp)
  801002:	6a 30                	push   $0x30
  801004:	8b 45 08             	mov    0x8(%ebp),%eax
  801007:	ff d0                	call   *%eax
  801009:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80100c:	83 ec 08             	sub    $0x8,%esp
  80100f:	ff 75 0c             	pushl  0xc(%ebp)
  801012:	6a 78                	push   $0x78
  801014:	8b 45 08             	mov    0x8(%ebp),%eax
  801017:	ff d0                	call   *%eax
  801019:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80101c:	8b 45 14             	mov    0x14(%ebp),%eax
  80101f:	83 c0 04             	add    $0x4,%eax
  801022:	89 45 14             	mov    %eax,0x14(%ebp)
  801025:	8b 45 14             	mov    0x14(%ebp),%eax
  801028:	83 e8 04             	sub    $0x4,%eax
  80102b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80102d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801030:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801037:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80103e:	eb 1f                	jmp    80105f <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801040:	83 ec 08             	sub    $0x8,%esp
  801043:	ff 75 e8             	pushl  -0x18(%ebp)
  801046:	8d 45 14             	lea    0x14(%ebp),%eax
  801049:	50                   	push   %eax
  80104a:	e8 e7 fb ff ff       	call   800c36 <getuint>
  80104f:	83 c4 10             	add    $0x10,%esp
  801052:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801055:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801058:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80105f:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801063:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801066:	83 ec 04             	sub    $0x4,%esp
  801069:	52                   	push   %edx
  80106a:	ff 75 e4             	pushl  -0x1c(%ebp)
  80106d:	50                   	push   %eax
  80106e:	ff 75 f4             	pushl  -0xc(%ebp)
  801071:	ff 75 f0             	pushl  -0x10(%ebp)
  801074:	ff 75 0c             	pushl  0xc(%ebp)
  801077:	ff 75 08             	pushl  0x8(%ebp)
  80107a:	e8 00 fb ff ff       	call   800b7f <printnum>
  80107f:	83 c4 20             	add    $0x20,%esp
			break;
  801082:	eb 34                	jmp    8010b8 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801084:	83 ec 08             	sub    $0x8,%esp
  801087:	ff 75 0c             	pushl  0xc(%ebp)
  80108a:	53                   	push   %ebx
  80108b:	8b 45 08             	mov    0x8(%ebp),%eax
  80108e:	ff d0                	call   *%eax
  801090:	83 c4 10             	add    $0x10,%esp
			break;
  801093:	eb 23                	jmp    8010b8 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801095:	83 ec 08             	sub    $0x8,%esp
  801098:	ff 75 0c             	pushl  0xc(%ebp)
  80109b:	6a 25                	push   $0x25
  80109d:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a0:	ff d0                	call   *%eax
  8010a2:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8010a5:	ff 4d 10             	decl   0x10(%ebp)
  8010a8:	eb 03                	jmp    8010ad <vprintfmt+0x3b1>
  8010aa:	ff 4d 10             	decl   0x10(%ebp)
  8010ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b0:	48                   	dec    %eax
  8010b1:	8a 00                	mov    (%eax),%al
  8010b3:	3c 25                	cmp    $0x25,%al
  8010b5:	75 f3                	jne    8010aa <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8010b7:	90                   	nop
		}
	}
  8010b8:	e9 47 fc ff ff       	jmp    800d04 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8010bd:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8010be:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8010c1:	5b                   	pop    %ebx
  8010c2:	5e                   	pop    %esi
  8010c3:	5d                   	pop    %ebp
  8010c4:	c3                   	ret    

008010c5 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8010c5:	55                   	push   %ebp
  8010c6:	89 e5                	mov    %esp,%ebp
  8010c8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8010cb:	8d 45 10             	lea    0x10(%ebp),%eax
  8010ce:	83 c0 04             	add    $0x4,%eax
  8010d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8010d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d7:	ff 75 f4             	pushl  -0xc(%ebp)
  8010da:	50                   	push   %eax
  8010db:	ff 75 0c             	pushl  0xc(%ebp)
  8010de:	ff 75 08             	pushl  0x8(%ebp)
  8010e1:	e8 16 fc ff ff       	call   800cfc <vprintfmt>
  8010e6:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8010e9:	90                   	nop
  8010ea:	c9                   	leave  
  8010eb:	c3                   	ret    

008010ec <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8010ec:	55                   	push   %ebp
  8010ed:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8010ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f2:	8b 40 08             	mov    0x8(%eax),%eax
  8010f5:	8d 50 01             	lea    0x1(%eax),%edx
  8010f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fb:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8010fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801101:	8b 10                	mov    (%eax),%edx
  801103:	8b 45 0c             	mov    0xc(%ebp),%eax
  801106:	8b 40 04             	mov    0x4(%eax),%eax
  801109:	39 c2                	cmp    %eax,%edx
  80110b:	73 12                	jae    80111f <sprintputch+0x33>
		*b->buf++ = ch;
  80110d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801110:	8b 00                	mov    (%eax),%eax
  801112:	8d 48 01             	lea    0x1(%eax),%ecx
  801115:	8b 55 0c             	mov    0xc(%ebp),%edx
  801118:	89 0a                	mov    %ecx,(%edx)
  80111a:	8b 55 08             	mov    0x8(%ebp),%edx
  80111d:	88 10                	mov    %dl,(%eax)
}
  80111f:	90                   	nop
  801120:	5d                   	pop    %ebp
  801121:	c3                   	ret    

00801122 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801122:	55                   	push   %ebp
  801123:	89 e5                	mov    %esp,%ebp
  801125:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801128:	8b 45 08             	mov    0x8(%ebp),%eax
  80112b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80112e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801131:	8d 50 ff             	lea    -0x1(%eax),%edx
  801134:	8b 45 08             	mov    0x8(%ebp),%eax
  801137:	01 d0                	add    %edx,%eax
  801139:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80113c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801143:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801147:	74 06                	je     80114f <vsnprintf+0x2d>
  801149:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80114d:	7f 07                	jg     801156 <vsnprintf+0x34>
		return -E_INVAL;
  80114f:	b8 03 00 00 00       	mov    $0x3,%eax
  801154:	eb 20                	jmp    801176 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801156:	ff 75 14             	pushl  0x14(%ebp)
  801159:	ff 75 10             	pushl  0x10(%ebp)
  80115c:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80115f:	50                   	push   %eax
  801160:	68 ec 10 80 00       	push   $0x8010ec
  801165:	e8 92 fb ff ff       	call   800cfc <vprintfmt>
  80116a:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80116d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801170:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801173:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801176:	c9                   	leave  
  801177:	c3                   	ret    

00801178 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801178:	55                   	push   %ebp
  801179:	89 e5                	mov    %esp,%ebp
  80117b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80117e:	8d 45 10             	lea    0x10(%ebp),%eax
  801181:	83 c0 04             	add    $0x4,%eax
  801184:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801187:	8b 45 10             	mov    0x10(%ebp),%eax
  80118a:	ff 75 f4             	pushl  -0xc(%ebp)
  80118d:	50                   	push   %eax
  80118e:	ff 75 0c             	pushl  0xc(%ebp)
  801191:	ff 75 08             	pushl  0x8(%ebp)
  801194:	e8 89 ff ff ff       	call   801122 <vsnprintf>
  801199:	83 c4 10             	add    $0x10,%esp
  80119c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80119f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011a2:	c9                   	leave  
  8011a3:	c3                   	ret    

008011a4 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8011a4:	55                   	push   %ebp
  8011a5:	89 e5                	mov    %esp,%ebp
  8011a7:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8011aa:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011ae:	74 13                	je     8011c3 <readline+0x1f>
		cprintf("%s", prompt);
  8011b0:	83 ec 08             	sub    $0x8,%esp
  8011b3:	ff 75 08             	pushl  0x8(%ebp)
  8011b6:	68 10 2f 80 00       	push   $0x802f10
  8011bb:	e8 62 f9 ff ff       	call   800b22 <cprintf>
  8011c0:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8011c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8011ca:	83 ec 0c             	sub    $0xc,%esp
  8011cd:	6a 00                	push   $0x0
  8011cf:	e8 5d f5 ff ff       	call   800731 <iscons>
  8011d4:	83 c4 10             	add    $0x10,%esp
  8011d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8011da:	e8 04 f5 ff ff       	call   8006e3 <getchar>
  8011df:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8011e2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8011e6:	79 22                	jns    80120a <readline+0x66>
			if (c != -E_EOF)
  8011e8:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8011ec:	0f 84 ad 00 00 00    	je     80129f <readline+0xfb>
				cprintf("read error: %e\n", c);
  8011f2:	83 ec 08             	sub    $0x8,%esp
  8011f5:	ff 75 ec             	pushl  -0x14(%ebp)
  8011f8:	68 13 2f 80 00       	push   $0x802f13
  8011fd:	e8 20 f9 ff ff       	call   800b22 <cprintf>
  801202:	83 c4 10             	add    $0x10,%esp
			return;
  801205:	e9 95 00 00 00       	jmp    80129f <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80120a:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80120e:	7e 34                	jle    801244 <readline+0xa0>
  801210:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801217:	7f 2b                	jg     801244 <readline+0xa0>
			if (echoing)
  801219:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80121d:	74 0e                	je     80122d <readline+0x89>
				cputchar(c);
  80121f:	83 ec 0c             	sub    $0xc,%esp
  801222:	ff 75 ec             	pushl  -0x14(%ebp)
  801225:	e8 71 f4 ff ff       	call   80069b <cputchar>
  80122a:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80122d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801230:	8d 50 01             	lea    0x1(%eax),%edx
  801233:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801236:	89 c2                	mov    %eax,%edx
  801238:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123b:	01 d0                	add    %edx,%eax
  80123d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801240:	88 10                	mov    %dl,(%eax)
  801242:	eb 56                	jmp    80129a <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801244:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801248:	75 1f                	jne    801269 <readline+0xc5>
  80124a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80124e:	7e 19                	jle    801269 <readline+0xc5>
			if (echoing)
  801250:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801254:	74 0e                	je     801264 <readline+0xc0>
				cputchar(c);
  801256:	83 ec 0c             	sub    $0xc,%esp
  801259:	ff 75 ec             	pushl  -0x14(%ebp)
  80125c:	e8 3a f4 ff ff       	call   80069b <cputchar>
  801261:	83 c4 10             	add    $0x10,%esp

			i--;
  801264:	ff 4d f4             	decl   -0xc(%ebp)
  801267:	eb 31                	jmp    80129a <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  801269:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80126d:	74 0a                	je     801279 <readline+0xd5>
  80126f:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801273:	0f 85 61 ff ff ff    	jne    8011da <readline+0x36>
			if (echoing)
  801279:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80127d:	74 0e                	je     80128d <readline+0xe9>
				cputchar(c);
  80127f:	83 ec 0c             	sub    $0xc,%esp
  801282:	ff 75 ec             	pushl  -0x14(%ebp)
  801285:	e8 11 f4 ff ff       	call   80069b <cputchar>
  80128a:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80128d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801290:	8b 45 0c             	mov    0xc(%ebp),%eax
  801293:	01 d0                	add    %edx,%eax
  801295:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801298:	eb 06                	jmp    8012a0 <readline+0xfc>
		}
	}
  80129a:	e9 3b ff ff ff       	jmp    8011da <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  80129f:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8012a0:	c9                   	leave  
  8012a1:	c3                   	ret    

008012a2 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8012a2:	55                   	push   %ebp
  8012a3:	89 e5                	mov    %esp,%ebp
  8012a5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8012a8:	e8 20 0e 00 00       	call   8020cd <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8012ad:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012b1:	74 13                	je     8012c6 <atomic_readline+0x24>
		cprintf("%s", prompt);
  8012b3:	83 ec 08             	sub    $0x8,%esp
  8012b6:	ff 75 08             	pushl  0x8(%ebp)
  8012b9:	68 10 2f 80 00       	push   $0x802f10
  8012be:	e8 5f f8 ff ff       	call   800b22 <cprintf>
  8012c3:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8012c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8012cd:	83 ec 0c             	sub    $0xc,%esp
  8012d0:	6a 00                	push   $0x0
  8012d2:	e8 5a f4 ff ff       	call   800731 <iscons>
  8012d7:	83 c4 10             	add    $0x10,%esp
  8012da:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8012dd:	e8 01 f4 ff ff       	call   8006e3 <getchar>
  8012e2:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8012e5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8012e9:	79 23                	jns    80130e <atomic_readline+0x6c>
			if (c != -E_EOF)
  8012eb:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8012ef:	74 13                	je     801304 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8012f1:	83 ec 08             	sub    $0x8,%esp
  8012f4:	ff 75 ec             	pushl  -0x14(%ebp)
  8012f7:	68 13 2f 80 00       	push   $0x802f13
  8012fc:	e8 21 f8 ff ff       	call   800b22 <cprintf>
  801301:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801304:	e8 de 0d 00 00       	call   8020e7 <sys_enable_interrupt>
			return;
  801309:	e9 9a 00 00 00       	jmp    8013a8 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80130e:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801312:	7e 34                	jle    801348 <atomic_readline+0xa6>
  801314:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80131b:	7f 2b                	jg     801348 <atomic_readline+0xa6>
			if (echoing)
  80131d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801321:	74 0e                	je     801331 <atomic_readline+0x8f>
				cputchar(c);
  801323:	83 ec 0c             	sub    $0xc,%esp
  801326:	ff 75 ec             	pushl  -0x14(%ebp)
  801329:	e8 6d f3 ff ff       	call   80069b <cputchar>
  80132e:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801331:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801334:	8d 50 01             	lea    0x1(%eax),%edx
  801337:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80133a:	89 c2                	mov    %eax,%edx
  80133c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133f:	01 d0                	add    %edx,%eax
  801341:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801344:	88 10                	mov    %dl,(%eax)
  801346:	eb 5b                	jmp    8013a3 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  801348:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80134c:	75 1f                	jne    80136d <atomic_readline+0xcb>
  80134e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801352:	7e 19                	jle    80136d <atomic_readline+0xcb>
			if (echoing)
  801354:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801358:	74 0e                	je     801368 <atomic_readline+0xc6>
				cputchar(c);
  80135a:	83 ec 0c             	sub    $0xc,%esp
  80135d:	ff 75 ec             	pushl  -0x14(%ebp)
  801360:	e8 36 f3 ff ff       	call   80069b <cputchar>
  801365:	83 c4 10             	add    $0x10,%esp
			i--;
  801368:	ff 4d f4             	decl   -0xc(%ebp)
  80136b:	eb 36                	jmp    8013a3 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  80136d:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801371:	74 0a                	je     80137d <atomic_readline+0xdb>
  801373:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801377:	0f 85 60 ff ff ff    	jne    8012dd <atomic_readline+0x3b>
			if (echoing)
  80137d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801381:	74 0e                	je     801391 <atomic_readline+0xef>
				cputchar(c);
  801383:	83 ec 0c             	sub    $0xc,%esp
  801386:	ff 75 ec             	pushl  -0x14(%ebp)
  801389:	e8 0d f3 ff ff       	call   80069b <cputchar>
  80138e:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801391:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801394:	8b 45 0c             	mov    0xc(%ebp),%eax
  801397:	01 d0                	add    %edx,%eax
  801399:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80139c:	e8 46 0d 00 00       	call   8020e7 <sys_enable_interrupt>
			return;
  8013a1:	eb 05                	jmp    8013a8 <atomic_readline+0x106>
		}
	}
  8013a3:	e9 35 ff ff ff       	jmp    8012dd <atomic_readline+0x3b>
}
  8013a8:	c9                   	leave  
  8013a9:	c3                   	ret    

008013aa <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8013aa:	55                   	push   %ebp
  8013ab:	89 e5                	mov    %esp,%ebp
  8013ad:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8013b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013b7:	eb 06                	jmp    8013bf <strlen+0x15>
		n++;
  8013b9:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8013bc:	ff 45 08             	incl   0x8(%ebp)
  8013bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c2:	8a 00                	mov    (%eax),%al
  8013c4:	84 c0                	test   %al,%al
  8013c6:	75 f1                	jne    8013b9 <strlen+0xf>
		n++;
	return n;
  8013c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013cb:	c9                   	leave  
  8013cc:	c3                   	ret    

008013cd <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8013cd:	55                   	push   %ebp
  8013ce:	89 e5                	mov    %esp,%ebp
  8013d0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8013d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013da:	eb 09                	jmp    8013e5 <strnlen+0x18>
		n++;
  8013dc:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8013df:	ff 45 08             	incl   0x8(%ebp)
  8013e2:	ff 4d 0c             	decl   0xc(%ebp)
  8013e5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013e9:	74 09                	je     8013f4 <strnlen+0x27>
  8013eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ee:	8a 00                	mov    (%eax),%al
  8013f0:	84 c0                	test   %al,%al
  8013f2:	75 e8                	jne    8013dc <strnlen+0xf>
		n++;
	return n;
  8013f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013f7:	c9                   	leave  
  8013f8:	c3                   	ret    

008013f9 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8013f9:	55                   	push   %ebp
  8013fa:	89 e5                	mov    %esp,%ebp
  8013fc:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8013ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801402:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801405:	90                   	nop
  801406:	8b 45 08             	mov    0x8(%ebp),%eax
  801409:	8d 50 01             	lea    0x1(%eax),%edx
  80140c:	89 55 08             	mov    %edx,0x8(%ebp)
  80140f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801412:	8d 4a 01             	lea    0x1(%edx),%ecx
  801415:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801418:	8a 12                	mov    (%edx),%dl
  80141a:	88 10                	mov    %dl,(%eax)
  80141c:	8a 00                	mov    (%eax),%al
  80141e:	84 c0                	test   %al,%al
  801420:	75 e4                	jne    801406 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801422:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801425:	c9                   	leave  
  801426:	c3                   	ret    

00801427 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801427:	55                   	push   %ebp
  801428:	89 e5                	mov    %esp,%ebp
  80142a:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80142d:	8b 45 08             	mov    0x8(%ebp),%eax
  801430:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801433:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80143a:	eb 1f                	jmp    80145b <strncpy+0x34>
		*dst++ = *src;
  80143c:	8b 45 08             	mov    0x8(%ebp),%eax
  80143f:	8d 50 01             	lea    0x1(%eax),%edx
  801442:	89 55 08             	mov    %edx,0x8(%ebp)
  801445:	8b 55 0c             	mov    0xc(%ebp),%edx
  801448:	8a 12                	mov    (%edx),%dl
  80144a:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80144c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80144f:	8a 00                	mov    (%eax),%al
  801451:	84 c0                	test   %al,%al
  801453:	74 03                	je     801458 <strncpy+0x31>
			src++;
  801455:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801458:	ff 45 fc             	incl   -0x4(%ebp)
  80145b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80145e:	3b 45 10             	cmp    0x10(%ebp),%eax
  801461:	72 d9                	jb     80143c <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801463:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801466:	c9                   	leave  
  801467:	c3                   	ret    

00801468 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801468:	55                   	push   %ebp
  801469:	89 e5                	mov    %esp,%ebp
  80146b:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80146e:	8b 45 08             	mov    0x8(%ebp),%eax
  801471:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801474:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801478:	74 30                	je     8014aa <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80147a:	eb 16                	jmp    801492 <strlcpy+0x2a>
			*dst++ = *src++;
  80147c:	8b 45 08             	mov    0x8(%ebp),%eax
  80147f:	8d 50 01             	lea    0x1(%eax),%edx
  801482:	89 55 08             	mov    %edx,0x8(%ebp)
  801485:	8b 55 0c             	mov    0xc(%ebp),%edx
  801488:	8d 4a 01             	lea    0x1(%edx),%ecx
  80148b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80148e:	8a 12                	mov    (%edx),%dl
  801490:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801492:	ff 4d 10             	decl   0x10(%ebp)
  801495:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801499:	74 09                	je     8014a4 <strlcpy+0x3c>
  80149b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149e:	8a 00                	mov    (%eax),%al
  8014a0:	84 c0                	test   %al,%al
  8014a2:	75 d8                	jne    80147c <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8014a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a7:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8014aa:	8b 55 08             	mov    0x8(%ebp),%edx
  8014ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014b0:	29 c2                	sub    %eax,%edx
  8014b2:	89 d0                	mov    %edx,%eax
}
  8014b4:	c9                   	leave  
  8014b5:	c3                   	ret    

008014b6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8014b6:	55                   	push   %ebp
  8014b7:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8014b9:	eb 06                	jmp    8014c1 <strcmp+0xb>
		p++, q++;
  8014bb:	ff 45 08             	incl   0x8(%ebp)
  8014be:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8014c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c4:	8a 00                	mov    (%eax),%al
  8014c6:	84 c0                	test   %al,%al
  8014c8:	74 0e                	je     8014d8 <strcmp+0x22>
  8014ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cd:	8a 10                	mov    (%eax),%dl
  8014cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d2:	8a 00                	mov    (%eax),%al
  8014d4:	38 c2                	cmp    %al,%dl
  8014d6:	74 e3                	je     8014bb <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8014d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014db:	8a 00                	mov    (%eax),%al
  8014dd:	0f b6 d0             	movzbl %al,%edx
  8014e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e3:	8a 00                	mov    (%eax),%al
  8014e5:	0f b6 c0             	movzbl %al,%eax
  8014e8:	29 c2                	sub    %eax,%edx
  8014ea:	89 d0                	mov    %edx,%eax
}
  8014ec:	5d                   	pop    %ebp
  8014ed:	c3                   	ret    

008014ee <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8014ee:	55                   	push   %ebp
  8014ef:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8014f1:	eb 09                	jmp    8014fc <strncmp+0xe>
		n--, p++, q++;
  8014f3:	ff 4d 10             	decl   0x10(%ebp)
  8014f6:	ff 45 08             	incl   0x8(%ebp)
  8014f9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8014fc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801500:	74 17                	je     801519 <strncmp+0x2b>
  801502:	8b 45 08             	mov    0x8(%ebp),%eax
  801505:	8a 00                	mov    (%eax),%al
  801507:	84 c0                	test   %al,%al
  801509:	74 0e                	je     801519 <strncmp+0x2b>
  80150b:	8b 45 08             	mov    0x8(%ebp),%eax
  80150e:	8a 10                	mov    (%eax),%dl
  801510:	8b 45 0c             	mov    0xc(%ebp),%eax
  801513:	8a 00                	mov    (%eax),%al
  801515:	38 c2                	cmp    %al,%dl
  801517:	74 da                	je     8014f3 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801519:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80151d:	75 07                	jne    801526 <strncmp+0x38>
		return 0;
  80151f:	b8 00 00 00 00       	mov    $0x0,%eax
  801524:	eb 14                	jmp    80153a <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801526:	8b 45 08             	mov    0x8(%ebp),%eax
  801529:	8a 00                	mov    (%eax),%al
  80152b:	0f b6 d0             	movzbl %al,%edx
  80152e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801531:	8a 00                	mov    (%eax),%al
  801533:	0f b6 c0             	movzbl %al,%eax
  801536:	29 c2                	sub    %eax,%edx
  801538:	89 d0                	mov    %edx,%eax
}
  80153a:	5d                   	pop    %ebp
  80153b:	c3                   	ret    

0080153c <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80153c:	55                   	push   %ebp
  80153d:	89 e5                	mov    %esp,%ebp
  80153f:	83 ec 04             	sub    $0x4,%esp
  801542:	8b 45 0c             	mov    0xc(%ebp),%eax
  801545:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801548:	eb 12                	jmp    80155c <strchr+0x20>
		if (*s == c)
  80154a:	8b 45 08             	mov    0x8(%ebp),%eax
  80154d:	8a 00                	mov    (%eax),%al
  80154f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801552:	75 05                	jne    801559 <strchr+0x1d>
			return (char *) s;
  801554:	8b 45 08             	mov    0x8(%ebp),%eax
  801557:	eb 11                	jmp    80156a <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801559:	ff 45 08             	incl   0x8(%ebp)
  80155c:	8b 45 08             	mov    0x8(%ebp),%eax
  80155f:	8a 00                	mov    (%eax),%al
  801561:	84 c0                	test   %al,%al
  801563:	75 e5                	jne    80154a <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801565:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80156a:	c9                   	leave  
  80156b:	c3                   	ret    

0080156c <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80156c:	55                   	push   %ebp
  80156d:	89 e5                	mov    %esp,%ebp
  80156f:	83 ec 04             	sub    $0x4,%esp
  801572:	8b 45 0c             	mov    0xc(%ebp),%eax
  801575:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801578:	eb 0d                	jmp    801587 <strfind+0x1b>
		if (*s == c)
  80157a:	8b 45 08             	mov    0x8(%ebp),%eax
  80157d:	8a 00                	mov    (%eax),%al
  80157f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801582:	74 0e                	je     801592 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801584:	ff 45 08             	incl   0x8(%ebp)
  801587:	8b 45 08             	mov    0x8(%ebp),%eax
  80158a:	8a 00                	mov    (%eax),%al
  80158c:	84 c0                	test   %al,%al
  80158e:	75 ea                	jne    80157a <strfind+0xe>
  801590:	eb 01                	jmp    801593 <strfind+0x27>
		if (*s == c)
			break;
  801592:	90                   	nop
	return (char *) s;
  801593:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801596:	c9                   	leave  
  801597:	c3                   	ret    

00801598 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801598:	55                   	push   %ebp
  801599:	89 e5                	mov    %esp,%ebp
  80159b:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80159e:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8015a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8015aa:	eb 0e                	jmp    8015ba <memset+0x22>
		*p++ = c;
  8015ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015af:	8d 50 01             	lea    0x1(%eax),%edx
  8015b2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8015b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015b8:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8015ba:	ff 4d f8             	decl   -0x8(%ebp)
  8015bd:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8015c1:	79 e9                	jns    8015ac <memset+0x14>
		*p++ = c;

	return v;
  8015c3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015c6:	c9                   	leave  
  8015c7:	c3                   	ret    

008015c8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8015c8:	55                   	push   %ebp
  8015c9:	89 e5                	mov    %esp,%ebp
  8015cb:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8015ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8015d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8015da:	eb 16                	jmp    8015f2 <memcpy+0x2a>
		*d++ = *s++;
  8015dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015df:	8d 50 01             	lea    0x1(%eax),%edx
  8015e2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015e5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015e8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015eb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015ee:	8a 12                	mov    (%edx),%dl
  8015f0:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8015f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015f8:	89 55 10             	mov    %edx,0x10(%ebp)
  8015fb:	85 c0                	test   %eax,%eax
  8015fd:	75 dd                	jne    8015dc <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8015ff:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801602:	c9                   	leave  
  801603:	c3                   	ret    

00801604 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801604:	55                   	push   %ebp
  801605:	89 e5                	mov    %esp,%ebp
  801607:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80160a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80160d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801610:	8b 45 08             	mov    0x8(%ebp),%eax
  801613:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801616:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801619:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80161c:	73 50                	jae    80166e <memmove+0x6a>
  80161e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801621:	8b 45 10             	mov    0x10(%ebp),%eax
  801624:	01 d0                	add    %edx,%eax
  801626:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801629:	76 43                	jbe    80166e <memmove+0x6a>
		s += n;
  80162b:	8b 45 10             	mov    0x10(%ebp),%eax
  80162e:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801631:	8b 45 10             	mov    0x10(%ebp),%eax
  801634:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801637:	eb 10                	jmp    801649 <memmove+0x45>
			*--d = *--s;
  801639:	ff 4d f8             	decl   -0x8(%ebp)
  80163c:	ff 4d fc             	decl   -0x4(%ebp)
  80163f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801642:	8a 10                	mov    (%eax),%dl
  801644:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801647:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801649:	8b 45 10             	mov    0x10(%ebp),%eax
  80164c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80164f:	89 55 10             	mov    %edx,0x10(%ebp)
  801652:	85 c0                	test   %eax,%eax
  801654:	75 e3                	jne    801639 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801656:	eb 23                	jmp    80167b <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801658:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80165b:	8d 50 01             	lea    0x1(%eax),%edx
  80165e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801661:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801664:	8d 4a 01             	lea    0x1(%edx),%ecx
  801667:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80166a:	8a 12                	mov    (%edx),%dl
  80166c:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80166e:	8b 45 10             	mov    0x10(%ebp),%eax
  801671:	8d 50 ff             	lea    -0x1(%eax),%edx
  801674:	89 55 10             	mov    %edx,0x10(%ebp)
  801677:	85 c0                	test   %eax,%eax
  801679:	75 dd                	jne    801658 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80167b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80167e:	c9                   	leave  
  80167f:	c3                   	ret    

00801680 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801680:	55                   	push   %ebp
  801681:	89 e5                	mov    %esp,%ebp
  801683:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801686:	8b 45 08             	mov    0x8(%ebp),%eax
  801689:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80168c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80168f:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801692:	eb 2a                	jmp    8016be <memcmp+0x3e>
		if (*s1 != *s2)
  801694:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801697:	8a 10                	mov    (%eax),%dl
  801699:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80169c:	8a 00                	mov    (%eax),%al
  80169e:	38 c2                	cmp    %al,%dl
  8016a0:	74 16                	je     8016b8 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8016a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016a5:	8a 00                	mov    (%eax),%al
  8016a7:	0f b6 d0             	movzbl %al,%edx
  8016aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ad:	8a 00                	mov    (%eax),%al
  8016af:	0f b6 c0             	movzbl %al,%eax
  8016b2:	29 c2                	sub    %eax,%edx
  8016b4:	89 d0                	mov    %edx,%eax
  8016b6:	eb 18                	jmp    8016d0 <memcmp+0x50>
		s1++, s2++;
  8016b8:	ff 45 fc             	incl   -0x4(%ebp)
  8016bb:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8016be:	8b 45 10             	mov    0x10(%ebp),%eax
  8016c1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016c4:	89 55 10             	mov    %edx,0x10(%ebp)
  8016c7:	85 c0                	test   %eax,%eax
  8016c9:	75 c9                	jne    801694 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8016cb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016d0:	c9                   	leave  
  8016d1:	c3                   	ret    

008016d2 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8016d2:	55                   	push   %ebp
  8016d3:	89 e5                	mov    %esp,%ebp
  8016d5:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8016d8:	8b 55 08             	mov    0x8(%ebp),%edx
  8016db:	8b 45 10             	mov    0x10(%ebp),%eax
  8016de:	01 d0                	add    %edx,%eax
  8016e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8016e3:	eb 15                	jmp    8016fa <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8016e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e8:	8a 00                	mov    (%eax),%al
  8016ea:	0f b6 d0             	movzbl %al,%edx
  8016ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f0:	0f b6 c0             	movzbl %al,%eax
  8016f3:	39 c2                	cmp    %eax,%edx
  8016f5:	74 0d                	je     801704 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8016f7:	ff 45 08             	incl   0x8(%ebp)
  8016fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801700:	72 e3                	jb     8016e5 <memfind+0x13>
  801702:	eb 01                	jmp    801705 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801704:	90                   	nop
	return (void *) s;
  801705:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801708:	c9                   	leave  
  801709:	c3                   	ret    

0080170a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80170a:	55                   	push   %ebp
  80170b:	89 e5                	mov    %esp,%ebp
  80170d:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801710:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801717:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80171e:	eb 03                	jmp    801723 <strtol+0x19>
		s++;
  801720:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801723:	8b 45 08             	mov    0x8(%ebp),%eax
  801726:	8a 00                	mov    (%eax),%al
  801728:	3c 20                	cmp    $0x20,%al
  80172a:	74 f4                	je     801720 <strtol+0x16>
  80172c:	8b 45 08             	mov    0x8(%ebp),%eax
  80172f:	8a 00                	mov    (%eax),%al
  801731:	3c 09                	cmp    $0x9,%al
  801733:	74 eb                	je     801720 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801735:	8b 45 08             	mov    0x8(%ebp),%eax
  801738:	8a 00                	mov    (%eax),%al
  80173a:	3c 2b                	cmp    $0x2b,%al
  80173c:	75 05                	jne    801743 <strtol+0x39>
		s++;
  80173e:	ff 45 08             	incl   0x8(%ebp)
  801741:	eb 13                	jmp    801756 <strtol+0x4c>
	else if (*s == '-')
  801743:	8b 45 08             	mov    0x8(%ebp),%eax
  801746:	8a 00                	mov    (%eax),%al
  801748:	3c 2d                	cmp    $0x2d,%al
  80174a:	75 0a                	jne    801756 <strtol+0x4c>
		s++, neg = 1;
  80174c:	ff 45 08             	incl   0x8(%ebp)
  80174f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801756:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80175a:	74 06                	je     801762 <strtol+0x58>
  80175c:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801760:	75 20                	jne    801782 <strtol+0x78>
  801762:	8b 45 08             	mov    0x8(%ebp),%eax
  801765:	8a 00                	mov    (%eax),%al
  801767:	3c 30                	cmp    $0x30,%al
  801769:	75 17                	jne    801782 <strtol+0x78>
  80176b:	8b 45 08             	mov    0x8(%ebp),%eax
  80176e:	40                   	inc    %eax
  80176f:	8a 00                	mov    (%eax),%al
  801771:	3c 78                	cmp    $0x78,%al
  801773:	75 0d                	jne    801782 <strtol+0x78>
		s += 2, base = 16;
  801775:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801779:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801780:	eb 28                	jmp    8017aa <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801782:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801786:	75 15                	jne    80179d <strtol+0x93>
  801788:	8b 45 08             	mov    0x8(%ebp),%eax
  80178b:	8a 00                	mov    (%eax),%al
  80178d:	3c 30                	cmp    $0x30,%al
  80178f:	75 0c                	jne    80179d <strtol+0x93>
		s++, base = 8;
  801791:	ff 45 08             	incl   0x8(%ebp)
  801794:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80179b:	eb 0d                	jmp    8017aa <strtol+0xa0>
	else if (base == 0)
  80179d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017a1:	75 07                	jne    8017aa <strtol+0xa0>
		base = 10;
  8017a3:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8017aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ad:	8a 00                	mov    (%eax),%al
  8017af:	3c 2f                	cmp    $0x2f,%al
  8017b1:	7e 19                	jle    8017cc <strtol+0xc2>
  8017b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b6:	8a 00                	mov    (%eax),%al
  8017b8:	3c 39                	cmp    $0x39,%al
  8017ba:	7f 10                	jg     8017cc <strtol+0xc2>
			dig = *s - '0';
  8017bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bf:	8a 00                	mov    (%eax),%al
  8017c1:	0f be c0             	movsbl %al,%eax
  8017c4:	83 e8 30             	sub    $0x30,%eax
  8017c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8017ca:	eb 42                	jmp    80180e <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8017cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cf:	8a 00                	mov    (%eax),%al
  8017d1:	3c 60                	cmp    $0x60,%al
  8017d3:	7e 19                	jle    8017ee <strtol+0xe4>
  8017d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d8:	8a 00                	mov    (%eax),%al
  8017da:	3c 7a                	cmp    $0x7a,%al
  8017dc:	7f 10                	jg     8017ee <strtol+0xe4>
			dig = *s - 'a' + 10;
  8017de:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e1:	8a 00                	mov    (%eax),%al
  8017e3:	0f be c0             	movsbl %al,%eax
  8017e6:	83 e8 57             	sub    $0x57,%eax
  8017e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8017ec:	eb 20                	jmp    80180e <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8017ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f1:	8a 00                	mov    (%eax),%al
  8017f3:	3c 40                	cmp    $0x40,%al
  8017f5:	7e 39                	jle    801830 <strtol+0x126>
  8017f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fa:	8a 00                	mov    (%eax),%al
  8017fc:	3c 5a                	cmp    $0x5a,%al
  8017fe:	7f 30                	jg     801830 <strtol+0x126>
			dig = *s - 'A' + 10;
  801800:	8b 45 08             	mov    0x8(%ebp),%eax
  801803:	8a 00                	mov    (%eax),%al
  801805:	0f be c0             	movsbl %al,%eax
  801808:	83 e8 37             	sub    $0x37,%eax
  80180b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80180e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801811:	3b 45 10             	cmp    0x10(%ebp),%eax
  801814:	7d 19                	jge    80182f <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801816:	ff 45 08             	incl   0x8(%ebp)
  801819:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80181c:	0f af 45 10          	imul   0x10(%ebp),%eax
  801820:	89 c2                	mov    %eax,%edx
  801822:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801825:	01 d0                	add    %edx,%eax
  801827:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80182a:	e9 7b ff ff ff       	jmp    8017aa <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80182f:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801830:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801834:	74 08                	je     80183e <strtol+0x134>
		*endptr = (char *) s;
  801836:	8b 45 0c             	mov    0xc(%ebp),%eax
  801839:	8b 55 08             	mov    0x8(%ebp),%edx
  80183c:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80183e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801842:	74 07                	je     80184b <strtol+0x141>
  801844:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801847:	f7 d8                	neg    %eax
  801849:	eb 03                	jmp    80184e <strtol+0x144>
  80184b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80184e:	c9                   	leave  
  80184f:	c3                   	ret    

00801850 <ltostr>:

void
ltostr(long value, char *str)
{
  801850:	55                   	push   %ebp
  801851:	89 e5                	mov    %esp,%ebp
  801853:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801856:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80185d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801864:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801868:	79 13                	jns    80187d <ltostr+0x2d>
	{
		neg = 1;
  80186a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801871:	8b 45 0c             	mov    0xc(%ebp),%eax
  801874:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801877:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80187a:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80187d:	8b 45 08             	mov    0x8(%ebp),%eax
  801880:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801885:	99                   	cltd   
  801886:	f7 f9                	idiv   %ecx
  801888:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80188b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80188e:	8d 50 01             	lea    0x1(%eax),%edx
  801891:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801894:	89 c2                	mov    %eax,%edx
  801896:	8b 45 0c             	mov    0xc(%ebp),%eax
  801899:	01 d0                	add    %edx,%eax
  80189b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80189e:	83 c2 30             	add    $0x30,%edx
  8018a1:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8018a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018a6:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8018ab:	f7 e9                	imul   %ecx
  8018ad:	c1 fa 02             	sar    $0x2,%edx
  8018b0:	89 c8                	mov    %ecx,%eax
  8018b2:	c1 f8 1f             	sar    $0x1f,%eax
  8018b5:	29 c2                	sub    %eax,%edx
  8018b7:	89 d0                	mov    %edx,%eax
  8018b9:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8018bc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018bf:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8018c4:	f7 e9                	imul   %ecx
  8018c6:	c1 fa 02             	sar    $0x2,%edx
  8018c9:	89 c8                	mov    %ecx,%eax
  8018cb:	c1 f8 1f             	sar    $0x1f,%eax
  8018ce:	29 c2                	sub    %eax,%edx
  8018d0:	89 d0                	mov    %edx,%eax
  8018d2:	c1 e0 02             	shl    $0x2,%eax
  8018d5:	01 d0                	add    %edx,%eax
  8018d7:	01 c0                	add    %eax,%eax
  8018d9:	29 c1                	sub    %eax,%ecx
  8018db:	89 ca                	mov    %ecx,%edx
  8018dd:	85 d2                	test   %edx,%edx
  8018df:	75 9c                	jne    80187d <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8018e1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8018e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018eb:	48                   	dec    %eax
  8018ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8018ef:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018f3:	74 3d                	je     801932 <ltostr+0xe2>
		start = 1 ;
  8018f5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8018fc:	eb 34                	jmp    801932 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8018fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801901:	8b 45 0c             	mov    0xc(%ebp),%eax
  801904:	01 d0                	add    %edx,%eax
  801906:	8a 00                	mov    (%eax),%al
  801908:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80190b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80190e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801911:	01 c2                	add    %eax,%edx
  801913:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801916:	8b 45 0c             	mov    0xc(%ebp),%eax
  801919:	01 c8                	add    %ecx,%eax
  80191b:	8a 00                	mov    (%eax),%al
  80191d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80191f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801922:	8b 45 0c             	mov    0xc(%ebp),%eax
  801925:	01 c2                	add    %eax,%edx
  801927:	8a 45 eb             	mov    -0x15(%ebp),%al
  80192a:	88 02                	mov    %al,(%edx)
		start++ ;
  80192c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80192f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801932:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801935:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801938:	7c c4                	jl     8018fe <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80193a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80193d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801940:	01 d0                	add    %edx,%eax
  801942:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801945:	90                   	nop
  801946:	c9                   	leave  
  801947:	c3                   	ret    

00801948 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801948:	55                   	push   %ebp
  801949:	89 e5                	mov    %esp,%ebp
  80194b:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80194e:	ff 75 08             	pushl  0x8(%ebp)
  801951:	e8 54 fa ff ff       	call   8013aa <strlen>
  801956:	83 c4 04             	add    $0x4,%esp
  801959:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80195c:	ff 75 0c             	pushl  0xc(%ebp)
  80195f:	e8 46 fa ff ff       	call   8013aa <strlen>
  801964:	83 c4 04             	add    $0x4,%esp
  801967:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80196a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801971:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801978:	eb 17                	jmp    801991 <strcconcat+0x49>
		final[s] = str1[s] ;
  80197a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80197d:	8b 45 10             	mov    0x10(%ebp),%eax
  801980:	01 c2                	add    %eax,%edx
  801982:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801985:	8b 45 08             	mov    0x8(%ebp),%eax
  801988:	01 c8                	add    %ecx,%eax
  80198a:	8a 00                	mov    (%eax),%al
  80198c:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80198e:	ff 45 fc             	incl   -0x4(%ebp)
  801991:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801994:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801997:	7c e1                	jl     80197a <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801999:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8019a0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8019a7:	eb 1f                	jmp    8019c8 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8019a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019ac:	8d 50 01             	lea    0x1(%eax),%edx
  8019af:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8019b2:	89 c2                	mov    %eax,%edx
  8019b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8019b7:	01 c2                	add    %eax,%edx
  8019b9:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8019bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019bf:	01 c8                	add    %ecx,%eax
  8019c1:	8a 00                	mov    (%eax),%al
  8019c3:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8019c5:	ff 45 f8             	incl   -0x8(%ebp)
  8019c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019cb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019ce:	7c d9                	jl     8019a9 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8019d0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8019d6:	01 d0                	add    %edx,%eax
  8019d8:	c6 00 00             	movb   $0x0,(%eax)
}
  8019db:	90                   	nop
  8019dc:	c9                   	leave  
  8019dd:	c3                   	ret    

008019de <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8019de:	55                   	push   %ebp
  8019df:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8019e1:	8b 45 14             	mov    0x14(%ebp),%eax
  8019e4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8019ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8019ed:	8b 00                	mov    (%eax),%eax
  8019ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f9:	01 d0                	add    %edx,%eax
  8019fb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a01:	eb 0c                	jmp    801a0f <strsplit+0x31>
			*string++ = 0;
  801a03:	8b 45 08             	mov    0x8(%ebp),%eax
  801a06:	8d 50 01             	lea    0x1(%eax),%edx
  801a09:	89 55 08             	mov    %edx,0x8(%ebp)
  801a0c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a12:	8a 00                	mov    (%eax),%al
  801a14:	84 c0                	test   %al,%al
  801a16:	74 18                	je     801a30 <strsplit+0x52>
  801a18:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1b:	8a 00                	mov    (%eax),%al
  801a1d:	0f be c0             	movsbl %al,%eax
  801a20:	50                   	push   %eax
  801a21:	ff 75 0c             	pushl  0xc(%ebp)
  801a24:	e8 13 fb ff ff       	call   80153c <strchr>
  801a29:	83 c4 08             	add    $0x8,%esp
  801a2c:	85 c0                	test   %eax,%eax
  801a2e:	75 d3                	jne    801a03 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801a30:	8b 45 08             	mov    0x8(%ebp),%eax
  801a33:	8a 00                	mov    (%eax),%al
  801a35:	84 c0                	test   %al,%al
  801a37:	74 5a                	je     801a93 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801a39:	8b 45 14             	mov    0x14(%ebp),%eax
  801a3c:	8b 00                	mov    (%eax),%eax
  801a3e:	83 f8 0f             	cmp    $0xf,%eax
  801a41:	75 07                	jne    801a4a <strsplit+0x6c>
		{
			return 0;
  801a43:	b8 00 00 00 00       	mov    $0x0,%eax
  801a48:	eb 66                	jmp    801ab0 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801a4a:	8b 45 14             	mov    0x14(%ebp),%eax
  801a4d:	8b 00                	mov    (%eax),%eax
  801a4f:	8d 48 01             	lea    0x1(%eax),%ecx
  801a52:	8b 55 14             	mov    0x14(%ebp),%edx
  801a55:	89 0a                	mov    %ecx,(%edx)
  801a57:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a5e:	8b 45 10             	mov    0x10(%ebp),%eax
  801a61:	01 c2                	add    %eax,%edx
  801a63:	8b 45 08             	mov    0x8(%ebp),%eax
  801a66:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a68:	eb 03                	jmp    801a6d <strsplit+0x8f>
			string++;
  801a6a:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801a6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a70:	8a 00                	mov    (%eax),%al
  801a72:	84 c0                	test   %al,%al
  801a74:	74 8b                	je     801a01 <strsplit+0x23>
  801a76:	8b 45 08             	mov    0x8(%ebp),%eax
  801a79:	8a 00                	mov    (%eax),%al
  801a7b:	0f be c0             	movsbl %al,%eax
  801a7e:	50                   	push   %eax
  801a7f:	ff 75 0c             	pushl  0xc(%ebp)
  801a82:	e8 b5 fa ff ff       	call   80153c <strchr>
  801a87:	83 c4 08             	add    $0x8,%esp
  801a8a:	85 c0                	test   %eax,%eax
  801a8c:	74 dc                	je     801a6a <strsplit+0x8c>
			string++;
	}
  801a8e:	e9 6e ff ff ff       	jmp    801a01 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801a93:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801a94:	8b 45 14             	mov    0x14(%ebp),%eax
  801a97:	8b 00                	mov    (%eax),%eax
  801a99:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801aa0:	8b 45 10             	mov    0x10(%ebp),%eax
  801aa3:	01 d0                	add    %edx,%eax
  801aa5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801aab:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801ab0:	c9                   	leave  
  801ab1:	c3                   	ret    

00801ab2 <malloc>:
//==================================================================================//
int FirstTimeFlag = 1;
int allocated[MAXN];

void* malloc(uint32 size)
{
  801ab2:	55                   	push   %ebp
  801ab3:	89 e5                	mov    %esp,%ebp
  801ab5:	83 ec 28             	sub    $0x28,%esp
	//DON'T CHANGE THIS CODE
	if(FirstTimeFlag)
  801ab8:	a1 04 40 80 00       	mov    0x804004,%eax
  801abd:	85 c0                	test   %eax,%eax
  801abf:	74 0f                	je     801ad0 <malloc+0x1e>
	{
		initialize_buddy();
  801ac1:	e8 a4 02 00 00       	call   801d6a <initialize_buddy>
		FirstTimeFlag = 0;
  801ac6:	c7 05 04 40 80 00 00 	movl   $0x0,0x804004
  801acd:	00 00 00 
	}
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
  801ad0:	81 7d 08 00 08 00 00 	cmpl   $0x800,0x8(%ebp)
  801ad7:	0f 86 0b 01 00 00    	jbe    801be8 <malloc+0x136>
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
  801add:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801ae4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae7:	c1 e8 0c             	shr    $0xc,%eax
  801aea:	89 c2                	mov    %eax,%edx
  801aec:	8b 45 08             	mov    0x8(%ebp),%eax
  801aef:	25 ff 0f 00 00       	and    $0xfff,%eax
  801af4:	85 c0                	test   %eax,%eax
  801af6:	74 07                	je     801aff <malloc+0x4d>
  801af8:	b8 01 00 00 00       	mov    $0x1,%eax
  801afd:	eb 05                	jmp    801b04 <malloc+0x52>
  801aff:	b8 00 00 00 00       	mov    $0x0,%eax
  801b04:	01 d0                	add    %edx,%eax
  801b06:	89 45 e8             	mov    %eax,-0x18(%ebp)
  801b09:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
  801b10:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
		for(i = 0; i < MAXN; i++) {
  801b17:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801b1e:	eb 5c                	jmp    801b7c <malloc+0xca>
			if(allocated[i] != 0) continue;
  801b20:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b23:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801b2a:	85 c0                	test   %eax,%eax
  801b2c:	75 4a                	jne    801b78 <malloc+0xc6>
			j = 1;
  801b2e:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
			i++;
  801b35:	ff 45 f4             	incl   -0xc(%ebp)
			while(i < MAXN && allocated[i] == 0 && j < sizeToPage) {
  801b38:	eb 06                	jmp    801b40 <malloc+0x8e>
				i++;
  801b3a:	ff 45 f4             	incl   -0xc(%ebp)
				j++;
  801b3d:	ff 45 ec             	incl   -0x14(%ebp)
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
			if(allocated[i] != 0) continue;
			j = 1;
			i++;
			while(i < MAXN && allocated[i] == 0 && j < sizeToPage) {
  801b40:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b43:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801b48:	77 16                	ja     801b60 <malloc+0xae>
  801b4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b4d:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801b54:	85 c0                	test   %eax,%eax
  801b56:	75 08                	jne    801b60 <malloc+0xae>
  801b58:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b5b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801b5e:	7c da                	jl     801b3a <malloc+0x88>
				i++;
				j++;
			}
			if(j == sizeToPage) {
  801b60:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b63:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801b66:	75 0b                	jne    801b73 <malloc+0xc1>
				indx = i - j;
  801b68:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b6b:	2b 45 ec             	sub    -0x14(%ebp),%eax
  801b6e:	89 45 f0             	mov    %eax,-0x10(%ebp)
				break;
  801b71:	eb 13                	jmp    801b86 <malloc+0xd4>
			}
			i--;
  801b73:	ff 4d f4             	decl   -0xc(%ebp)
  801b76:	eb 01                	jmp    801b79 <malloc+0xc7>
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
			if(allocated[i] != 0) continue;
  801b78:	90                   	nop
	}
	//TODO: [PROJECT 2020 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	if(size > PAGE_SIZE / 2) {
		int i = 0, sizeToPage = (size / PAGE_SIZE) + (size % PAGE_SIZE != 0 ? 1 : 0), indx = -1, j = 1;
		for(i = 0; i < MAXN; i++) {
  801b79:	ff 45 f4             	incl   -0xc(%ebp)
  801b7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b7f:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801b84:	76 9a                	jbe    801b20 <malloc+0x6e>
				indx = i - j;
				break;
			}
			i--;
		}
		if(indx == -1) {
  801b86:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
  801b8a:	75 07                	jne    801b93 <malloc+0xe1>
			return NULL;
  801b8c:	b8 00 00 00 00       	mov    $0x0,%eax
  801b91:	eb 5a                	jmp    801bed <malloc+0x13b>
		}
		i = indx;
  801b93:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b96:	89 45 f4             	mov    %eax,-0xc(%ebp)
		while(i < j + indx) {
  801b99:	eb 13                	jmp    801bae <malloc+0xfc>
			allocated[i++] = j;
  801b9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b9e:	8d 50 01             	lea    0x1(%eax),%edx
  801ba1:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801ba4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801ba7:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
		}
		if(indx == -1) {
			return NULL;
		}
		i = indx;
		while(i < j + indx) {
  801bae:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801bb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bb4:	01 d0                	add    %edx,%eax
  801bb6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801bb9:	7f e0                	jg     801b9b <malloc+0xe9>
			allocated[i++] = j;
		}
		uint32 *address = (uint32 *)(USER_HEAP_START + (indx * PAGE_SIZE));
  801bbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bbe:	c1 e0 0c             	shl    $0xc,%eax
  801bc1:	05 00 00 00 80       	add    $0x80000000,%eax
  801bc6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		sys_allocateMem(USER_HEAP_START + (indx * PAGE_SIZE), size);
  801bc9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bcc:	c1 e0 0c             	shl    $0xc,%eax
  801bcf:	05 00 00 00 80       	add    $0x80000000,%eax
  801bd4:	83 ec 08             	sub    $0x8,%esp
  801bd7:	ff 75 08             	pushl  0x8(%ebp)
  801bda:	50                   	push   %eax
  801bdb:	e8 84 04 00 00       	call   802064 <sys_allocateMem>
  801be0:	83 c4 10             	add    $0x10,%esp
		return address;
  801be3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801be6:	eb 05                	jmp    801bed <malloc+0x13b>
	//1) FIRST FIT strategy (if size > 2 KB)
	//2) Buddy System (if size <= 2 KB)

	//refer to the project presentation and documentation for details

	return NULL;
  801be8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bed:	c9                   	leave  
  801bee:	c3                   	ret    

00801bef <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801bef:	55                   	push   %ebp
  801bf0:	89 e5                	mov    %esp,%ebp
  801bf2:	83 ec 18             	sub    $0x18,%esp
	//TODO: [PROJECT 2020 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address, PAGE_SIZE);
  801bf5:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801bfb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801bfe:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801c03:	89 45 08             	mov    %eax,0x8(%ebp)
	int size = 0, indx = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE;
  801c06:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c10:	05 00 00 00 80       	add    $0x80000000,%eax
  801c15:	c1 e8 0c             	shr    $0xc,%eax
  801c18:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int removable_size = allocated[indx];
  801c1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c1e:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801c25:	89 45 e8             	mov    %eax,-0x18(%ebp)
	size = allocated[indx];
  801c28:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c2b:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801c32:	89 45 f4             	mov    %eax,-0xc(%ebp)
	while(size > 0) {
  801c35:	eb 17                	jmp    801c4e <free+0x5f>
		allocated[indx++] = 0;
  801c37:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c3a:	8d 50 01             	lea    0x1(%eax),%edx
  801c3d:	89 55 f0             	mov    %edx,-0x10(%ebp)
  801c40:	c7 04 85 20 41 80 00 	movl   $0x0,0x804120(,%eax,4)
  801c47:	00 00 00 00 
		size--;
  801c4b:	ff 4d f4             	decl   -0xc(%ebp)
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address, PAGE_SIZE);
	int size = 0, indx = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE;
	int removable_size = allocated[indx];
	size = allocated[indx];
	while(size > 0) {
  801c4e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801c52:	7f e3                	jg     801c37 <free+0x48>
		allocated[indx++] = 0;
		size--;
	}
	sys_freeMem((uint32)virtual_address, removable_size);
  801c54:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801c57:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5a:	83 ec 08             	sub    $0x8,%esp
  801c5d:	52                   	push   %edx
  801c5e:	50                   	push   %eax
  801c5f:	e8 e4 03 00 00       	call   802048 <sys_freeMem>
  801c64:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details

}
  801c67:	90                   	nop
  801c68:	c9                   	leave  
  801c69:	c3                   	ret    

00801c6a <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801c6a:	55                   	push   %ebp
  801c6b:	89 e5                	mov    %esp,%ebp
  801c6d:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - BONUS2] User Heap Realloc [User Side]
	// Write your code here, remove the panic and write your code
	panic("realloc() is not implemented yet...!!");
  801c70:	83 ec 04             	sub    $0x4,%esp
  801c73:	68 24 2f 80 00       	push   $0x802f24
  801c78:	6a 7a                	push   $0x7a
  801c7a:	68 4a 2f 80 00       	push   $0x802f4a
  801c7f:	e8 fc eb ff ff       	call   800880 <_panic>

00801c84 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801c84:	55                   	push   %ebp
  801c85:	89 e5                	mov    %esp,%ebp
  801c87:	83 ec 18             	sub    $0x18,%esp
  801c8a:	8b 45 10             	mov    0x10(%ebp),%eax
  801c8d:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801c90:	83 ec 04             	sub    $0x4,%esp
  801c93:	68 58 2f 80 00       	push   $0x802f58
  801c98:	68 84 00 00 00       	push   $0x84
  801c9d:	68 4a 2f 80 00       	push   $0x802f4a
  801ca2:	e8 d9 eb ff ff       	call   800880 <_panic>

00801ca7 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801ca7:	55                   	push   %ebp
  801ca8:	89 e5                	mov    %esp,%ebp
  801caa:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801cad:	83 ec 04             	sub    $0x4,%esp
  801cb0:	68 58 2f 80 00       	push   $0x802f58
  801cb5:	68 8a 00 00 00       	push   $0x8a
  801cba:	68 4a 2f 80 00       	push   $0x802f4a
  801cbf:	e8 bc eb ff ff       	call   800880 <_panic>

00801cc4 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801cc4:	55                   	push   %ebp
  801cc5:	89 e5                	mov    %esp,%ebp
  801cc7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801cca:	83 ec 04             	sub    $0x4,%esp
  801ccd:	68 58 2f 80 00       	push   $0x802f58
  801cd2:	68 90 00 00 00       	push   $0x90
  801cd7:	68 4a 2f 80 00       	push   $0x802f4a
  801cdc:	e8 9f eb ff ff       	call   800880 <_panic>

00801ce1 <expand>:
}

void expand(uint32 newSize)
{
  801ce1:	55                   	push   %ebp
  801ce2:	89 e5                	mov    %esp,%ebp
  801ce4:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ce7:	83 ec 04             	sub    $0x4,%esp
  801cea:	68 58 2f 80 00       	push   $0x802f58
  801cef:	68 95 00 00 00       	push   $0x95
  801cf4:	68 4a 2f 80 00       	push   $0x802f4a
  801cf9:	e8 82 eb ff ff       	call   800880 <_panic>

00801cfe <shrink>:
}
void shrink(uint32 newSize)
{
  801cfe:	55                   	push   %ebp
  801cff:	89 e5                	mov    %esp,%ebp
  801d01:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d04:	83 ec 04             	sub    $0x4,%esp
  801d07:	68 58 2f 80 00       	push   $0x802f58
  801d0c:	68 99 00 00 00       	push   $0x99
  801d11:	68 4a 2f 80 00       	push   $0x802f4a
  801d16:	e8 65 eb ff ff       	call   800880 <_panic>

00801d1b <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801d1b:	55                   	push   %ebp
  801d1c:	89 e5                	mov    %esp,%ebp
  801d1e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d21:	83 ec 04             	sub    $0x4,%esp
  801d24:	68 58 2f 80 00       	push   $0x802f58
  801d29:	68 9e 00 00 00       	push   $0x9e
  801d2e:	68 4a 2f 80 00       	push   $0x802f4a
  801d33:	e8 48 eb ff ff       	call   800880 <_panic>

00801d38 <ClearNodeData>:
 * inside the user heap
 */
 
struct BuddyNode FreeNodes[BUDDY_NUM_FREE_NODES];
void ClearNodeData(struct BuddyNode* node)
{
  801d38:	55                   	push   %ebp
  801d39:	89 e5                	mov    %esp,%ebp
	node->level = 0;
  801d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d3e:	c6 40 11 00          	movb   $0x0,0x11(%eax)
	node->status = FREE;
  801d42:	8b 45 08             	mov    0x8(%ebp),%eax
  801d45:	c6 40 10 00          	movb   $0x0,0x10(%eax)
	node->va = 0;
  801d49:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
	node->parent = NULL;
  801d53:	8b 45 08             	mov    0x8(%ebp),%eax
  801d56:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
	node->myBuddy = NULL;
  801d5d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d60:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
}
  801d67:	90                   	nop
  801d68:	5d                   	pop    %ebp
  801d69:	c3                   	ret    

00801d6a <initialize_buddy>:

void initialize_buddy()
{
  801d6a:	55                   	push   %ebp
  801d6b:	89 e5                	mov    %esp,%ebp
  801d6d:	83 ec 10             	sub    $0x10,%esp
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  801d70:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801d77:	e9 b7 00 00 00       	jmp    801e33 <initialize_buddy+0xc9>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
  801d7c:	8b 15 04 41 80 00    	mov    0x804104,%edx
  801d82:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801d85:	89 c8                	mov    %ecx,%eax
  801d87:	01 c0                	add    %eax,%eax
  801d89:	01 c8                	add    %ecx,%eax
  801d8b:	c1 e0 03             	shl    $0x3,%eax
  801d8e:	05 20 41 88 00       	add    $0x884120,%eax
  801d93:	89 10                	mov    %edx,(%eax)
  801d95:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801d98:	89 d0                	mov    %edx,%eax
  801d9a:	01 c0                	add    %eax,%eax
  801d9c:	01 d0                	add    %edx,%eax
  801d9e:	c1 e0 03             	shl    $0x3,%eax
  801da1:	05 20 41 88 00       	add    $0x884120,%eax
  801da6:	8b 00                	mov    (%eax),%eax
  801da8:	85 c0                	test   %eax,%eax
  801daa:	74 1c                	je     801dc8 <initialize_buddy+0x5e>
  801dac:	8b 15 04 41 80 00    	mov    0x804104,%edx
  801db2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801db5:	89 c8                	mov    %ecx,%eax
  801db7:	01 c0                	add    %eax,%eax
  801db9:	01 c8                	add    %ecx,%eax
  801dbb:	c1 e0 03             	shl    $0x3,%eax
  801dbe:	05 20 41 88 00       	add    $0x884120,%eax
  801dc3:	89 42 04             	mov    %eax,0x4(%edx)
  801dc6:	eb 16                	jmp    801dde <initialize_buddy+0x74>
  801dc8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801dcb:	89 d0                	mov    %edx,%eax
  801dcd:	01 c0                	add    %eax,%eax
  801dcf:	01 d0                	add    %edx,%eax
  801dd1:	c1 e0 03             	shl    $0x3,%eax
  801dd4:	05 20 41 88 00       	add    $0x884120,%eax
  801dd9:	a3 08 41 80 00       	mov    %eax,0x804108
  801dde:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801de1:	89 d0                	mov    %edx,%eax
  801de3:	01 c0                	add    %eax,%eax
  801de5:	01 d0                	add    %edx,%eax
  801de7:	c1 e0 03             	shl    $0x3,%eax
  801dea:	05 20 41 88 00       	add    $0x884120,%eax
  801def:	a3 04 41 80 00       	mov    %eax,0x804104
  801df4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801df7:	89 d0                	mov    %edx,%eax
  801df9:	01 c0                	add    %eax,%eax
  801dfb:	01 d0                	add    %edx,%eax
  801dfd:	c1 e0 03             	shl    $0x3,%eax
  801e00:	05 24 41 88 00       	add    $0x884124,%eax
  801e05:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801e0b:	a1 10 41 80 00       	mov    0x804110,%eax
  801e10:	40                   	inc    %eax
  801e11:	a3 10 41 80 00       	mov    %eax,0x804110
		ClearNodeData(&(FreeNodes[i]));
  801e16:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e19:	89 d0                	mov    %edx,%eax
  801e1b:	01 c0                	add    %eax,%eax
  801e1d:	01 d0                	add    %edx,%eax
  801e1f:	c1 e0 03             	shl    $0x3,%eax
  801e22:	05 20 41 88 00       	add    $0x884120,%eax
  801e27:	50                   	push   %eax
  801e28:	e8 0b ff ff ff       	call   801d38 <ClearNodeData>
  801e2d:	83 c4 04             	add    $0x4,%esp
	node->myBuddy = NULL;
}

void initialize_buddy()
{
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  801e30:	ff 45 fc             	incl   -0x4(%ebp)
  801e33:	81 7d fc 3f 9c 00 00 	cmpl   $0x9c3f,-0x4(%ebp)
  801e3a:	0f 8e 3c ff ff ff    	jle    801d7c <initialize_buddy+0x12>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
		ClearNodeData(&(FreeNodes[i]));
	}
}
  801e40:	90                   	nop
  801e41:	c9                   	leave  
  801e42:	c3                   	ret    

00801e43 <CreateNewBuddySpace>:
/*===============================================================*/

//TODO: [PROJECT 2020 - BONUS4] Expand Buddy Free Node List

void CreateNewBuddySpace()
{
  801e43:	55                   	push   %ebp
  801e44:	89 e5                	mov    %esp,%ebp
  801e46:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Create New Buddy Block]
	// Write your code here, remove the panic and write your code
	panic("CreateNewBuddySpace() is not implemented yet...!!");
  801e49:	83 ec 04             	sub    $0x4,%esp
  801e4c:	68 7c 2f 80 00       	push   $0x802f7c
  801e51:	6a 22                	push   $0x22
  801e53:	68 ae 2f 80 00       	push   $0x802fae
  801e58:	e8 23 ea ff ff       	call   800880 <_panic>

00801e5d <FindAllocationUsingBuddy>:

}

void* FindAllocationUsingBuddy(int size)
{
  801e5d:	55                   	push   %ebp
  801e5e:	89 e5                	mov    %esp,%ebp
  801e60:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Get Allocation]
	// Write your code here, remove the panic and write your code
	panic("FindAllocationUsingBuddy() is not implemented yet...!!");
  801e63:	83 ec 04             	sub    $0x4,%esp
  801e66:	68 bc 2f 80 00       	push   $0x802fbc
  801e6b:	6a 2a                	push   $0x2a
  801e6d:	68 ae 2f 80 00       	push   $0x802fae
  801e72:	e8 09 ea ff ff       	call   800880 <_panic>

00801e77 <FreeAllocationUsingBuddy>:
}

void FreeAllocationUsingBuddy(uint32 va)
{
  801e77:	55                   	push   %ebp
  801e78:	89 e5                	mov    %esp,%ebp
  801e7a:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2020 - [3] Buddy System: Free Allocation]
	// Write your code here, remove the panic and write your code
	panic("FreeAllocationUsingBuddy() is not implemented yet...!!");
  801e7d:	83 ec 04             	sub    $0x4,%esp
  801e80:	68 f4 2f 80 00       	push   $0x802ff4
  801e85:	6a 31                	push   $0x31
  801e87:	68 ae 2f 80 00       	push   $0x802fae
  801e8c:	e8 ef e9 ff ff       	call   800880 <_panic>

00801e91 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801e91:	55                   	push   %ebp
  801e92:	89 e5                	mov    %esp,%ebp
  801e94:	57                   	push   %edi
  801e95:	56                   	push   %esi
  801e96:	53                   	push   %ebx
  801e97:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801e9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ea0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ea3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ea6:	8b 7d 18             	mov    0x18(%ebp),%edi
  801ea9:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801eac:	cd 30                	int    $0x30
  801eae:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801eb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801eb4:	83 c4 10             	add    $0x10,%esp
  801eb7:	5b                   	pop    %ebx
  801eb8:	5e                   	pop    %esi
  801eb9:	5f                   	pop    %edi
  801eba:	5d                   	pop    %ebp
  801ebb:	c3                   	ret    

00801ebc <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801ebc:	55                   	push   %ebp
  801ebd:	89 e5                	mov    %esp,%ebp
  801ebf:	83 ec 04             	sub    $0x4,%esp
  801ec2:	8b 45 10             	mov    0x10(%ebp),%eax
  801ec5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801ec8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  801ecf:	6a 00                	push   $0x0
  801ed1:	6a 00                	push   $0x0
  801ed3:	52                   	push   %edx
  801ed4:	ff 75 0c             	pushl  0xc(%ebp)
  801ed7:	50                   	push   %eax
  801ed8:	6a 00                	push   $0x0
  801eda:	e8 b2 ff ff ff       	call   801e91 <syscall>
  801edf:	83 c4 18             	add    $0x18,%esp
}
  801ee2:	90                   	nop
  801ee3:	c9                   	leave  
  801ee4:	c3                   	ret    

00801ee5 <sys_cgetc>:

int
sys_cgetc(void)
{
  801ee5:	55                   	push   %ebp
  801ee6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801ee8:	6a 00                	push   $0x0
  801eea:	6a 00                	push   $0x0
  801eec:	6a 00                	push   $0x0
  801eee:	6a 00                	push   $0x0
  801ef0:	6a 00                	push   $0x0
  801ef2:	6a 01                	push   $0x1
  801ef4:	e8 98 ff ff ff       	call   801e91 <syscall>
  801ef9:	83 c4 18             	add    $0x18,%esp
}
  801efc:	c9                   	leave  
  801efd:	c3                   	ret    

00801efe <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801efe:	55                   	push   %ebp
  801eff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801f01:	8b 45 08             	mov    0x8(%ebp),%eax
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	6a 00                	push   $0x0
  801f0a:	6a 00                	push   $0x0
  801f0c:	50                   	push   %eax
  801f0d:	6a 05                	push   $0x5
  801f0f:	e8 7d ff ff ff       	call   801e91 <syscall>
  801f14:	83 c4 18             	add    $0x18,%esp
}
  801f17:	c9                   	leave  
  801f18:	c3                   	ret    

00801f19 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801f19:	55                   	push   %ebp
  801f1a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 00                	push   $0x0
  801f20:	6a 00                	push   $0x0
  801f22:	6a 00                	push   $0x0
  801f24:	6a 00                	push   $0x0
  801f26:	6a 02                	push   $0x2
  801f28:	e8 64 ff ff ff       	call   801e91 <syscall>
  801f2d:	83 c4 18             	add    $0x18,%esp
}
  801f30:	c9                   	leave  
  801f31:	c3                   	ret    

00801f32 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801f32:	55                   	push   %ebp
  801f33:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801f35:	6a 00                	push   $0x0
  801f37:	6a 00                	push   $0x0
  801f39:	6a 00                	push   $0x0
  801f3b:	6a 00                	push   $0x0
  801f3d:	6a 00                	push   $0x0
  801f3f:	6a 03                	push   $0x3
  801f41:	e8 4b ff ff ff       	call   801e91 <syscall>
  801f46:	83 c4 18             	add    $0x18,%esp
}
  801f49:	c9                   	leave  
  801f4a:	c3                   	ret    

00801f4b <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801f4b:	55                   	push   %ebp
  801f4c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801f4e:	6a 00                	push   $0x0
  801f50:	6a 00                	push   $0x0
  801f52:	6a 00                	push   $0x0
  801f54:	6a 00                	push   $0x0
  801f56:	6a 00                	push   $0x0
  801f58:	6a 04                	push   $0x4
  801f5a:	e8 32 ff ff ff       	call   801e91 <syscall>
  801f5f:	83 c4 18             	add    $0x18,%esp
}
  801f62:	c9                   	leave  
  801f63:	c3                   	ret    

00801f64 <sys_env_exit>:


void sys_env_exit(void)
{
  801f64:	55                   	push   %ebp
  801f65:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801f67:	6a 00                	push   $0x0
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 00                	push   $0x0
  801f6d:	6a 00                	push   $0x0
  801f6f:	6a 00                	push   $0x0
  801f71:	6a 06                	push   $0x6
  801f73:	e8 19 ff ff ff       	call   801e91 <syscall>
  801f78:	83 c4 18             	add    $0x18,%esp
}
  801f7b:	90                   	nop
  801f7c:	c9                   	leave  
  801f7d:	c3                   	ret    

00801f7e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801f7e:	55                   	push   %ebp
  801f7f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801f81:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f84:	8b 45 08             	mov    0x8(%ebp),%eax
  801f87:	6a 00                	push   $0x0
  801f89:	6a 00                	push   $0x0
  801f8b:	6a 00                	push   $0x0
  801f8d:	52                   	push   %edx
  801f8e:	50                   	push   %eax
  801f8f:	6a 07                	push   $0x7
  801f91:	e8 fb fe ff ff       	call   801e91 <syscall>
  801f96:	83 c4 18             	add    $0x18,%esp
}
  801f99:	c9                   	leave  
  801f9a:	c3                   	ret    

00801f9b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801f9b:	55                   	push   %ebp
  801f9c:	89 e5                	mov    %esp,%ebp
  801f9e:	56                   	push   %esi
  801f9f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801fa0:	8b 75 18             	mov    0x18(%ebp),%esi
  801fa3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801fa6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801fa9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fac:	8b 45 08             	mov    0x8(%ebp),%eax
  801faf:	56                   	push   %esi
  801fb0:	53                   	push   %ebx
  801fb1:	51                   	push   %ecx
  801fb2:	52                   	push   %edx
  801fb3:	50                   	push   %eax
  801fb4:	6a 08                	push   $0x8
  801fb6:	e8 d6 fe ff ff       	call   801e91 <syscall>
  801fbb:	83 c4 18             	add    $0x18,%esp
}
  801fbe:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801fc1:	5b                   	pop    %ebx
  801fc2:	5e                   	pop    %esi
  801fc3:	5d                   	pop    %ebp
  801fc4:	c3                   	ret    

00801fc5 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801fc5:	55                   	push   %ebp
  801fc6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801fc8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fcb:	8b 45 08             	mov    0x8(%ebp),%eax
  801fce:	6a 00                	push   $0x0
  801fd0:	6a 00                	push   $0x0
  801fd2:	6a 00                	push   $0x0
  801fd4:	52                   	push   %edx
  801fd5:	50                   	push   %eax
  801fd6:	6a 09                	push   $0x9
  801fd8:	e8 b4 fe ff ff       	call   801e91 <syscall>
  801fdd:	83 c4 18             	add    $0x18,%esp
}
  801fe0:	c9                   	leave  
  801fe1:	c3                   	ret    

00801fe2 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801fe2:	55                   	push   %ebp
  801fe3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801fe5:	6a 00                	push   $0x0
  801fe7:	6a 00                	push   $0x0
  801fe9:	6a 00                	push   $0x0
  801feb:	ff 75 0c             	pushl  0xc(%ebp)
  801fee:	ff 75 08             	pushl  0x8(%ebp)
  801ff1:	6a 0a                	push   $0xa
  801ff3:	e8 99 fe ff ff       	call   801e91 <syscall>
  801ff8:	83 c4 18             	add    $0x18,%esp
}
  801ffb:	c9                   	leave  
  801ffc:	c3                   	ret    

00801ffd <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801ffd:	55                   	push   %ebp
  801ffe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802000:	6a 00                	push   $0x0
  802002:	6a 00                	push   $0x0
  802004:	6a 00                	push   $0x0
  802006:	6a 00                	push   $0x0
  802008:	6a 00                	push   $0x0
  80200a:	6a 0b                	push   $0xb
  80200c:	e8 80 fe ff ff       	call   801e91 <syscall>
  802011:	83 c4 18             	add    $0x18,%esp
}
  802014:	c9                   	leave  
  802015:	c3                   	ret    

00802016 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802016:	55                   	push   %ebp
  802017:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802019:	6a 00                	push   $0x0
  80201b:	6a 00                	push   $0x0
  80201d:	6a 00                	push   $0x0
  80201f:	6a 00                	push   $0x0
  802021:	6a 00                	push   $0x0
  802023:	6a 0c                	push   $0xc
  802025:	e8 67 fe ff ff       	call   801e91 <syscall>
  80202a:	83 c4 18             	add    $0x18,%esp
}
  80202d:	c9                   	leave  
  80202e:	c3                   	ret    

0080202f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80202f:	55                   	push   %ebp
  802030:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802032:	6a 00                	push   $0x0
  802034:	6a 00                	push   $0x0
  802036:	6a 00                	push   $0x0
  802038:	6a 00                	push   $0x0
  80203a:	6a 00                	push   $0x0
  80203c:	6a 0d                	push   $0xd
  80203e:	e8 4e fe ff ff       	call   801e91 <syscall>
  802043:	83 c4 18             	add    $0x18,%esp
}
  802046:	c9                   	leave  
  802047:	c3                   	ret    

00802048 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802048:	55                   	push   %ebp
  802049:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80204b:	6a 00                	push   $0x0
  80204d:	6a 00                	push   $0x0
  80204f:	6a 00                	push   $0x0
  802051:	ff 75 0c             	pushl  0xc(%ebp)
  802054:	ff 75 08             	pushl  0x8(%ebp)
  802057:	6a 11                	push   $0x11
  802059:	e8 33 fe ff ff       	call   801e91 <syscall>
  80205e:	83 c4 18             	add    $0x18,%esp
	return;
  802061:	90                   	nop
}
  802062:	c9                   	leave  
  802063:	c3                   	ret    

00802064 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802064:	55                   	push   %ebp
  802065:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802067:	6a 00                	push   $0x0
  802069:	6a 00                	push   $0x0
  80206b:	6a 00                	push   $0x0
  80206d:	ff 75 0c             	pushl  0xc(%ebp)
  802070:	ff 75 08             	pushl  0x8(%ebp)
  802073:	6a 12                	push   $0x12
  802075:	e8 17 fe ff ff       	call   801e91 <syscall>
  80207a:	83 c4 18             	add    $0x18,%esp
	return ;
  80207d:	90                   	nop
}
  80207e:	c9                   	leave  
  80207f:	c3                   	ret    

00802080 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802080:	55                   	push   %ebp
  802081:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802083:	6a 00                	push   $0x0
  802085:	6a 00                	push   $0x0
  802087:	6a 00                	push   $0x0
  802089:	6a 00                	push   $0x0
  80208b:	6a 00                	push   $0x0
  80208d:	6a 0e                	push   $0xe
  80208f:	e8 fd fd ff ff       	call   801e91 <syscall>
  802094:	83 c4 18             	add    $0x18,%esp
}
  802097:	c9                   	leave  
  802098:	c3                   	ret    

00802099 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802099:	55                   	push   %ebp
  80209a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 00                	push   $0x0
  8020a4:	ff 75 08             	pushl  0x8(%ebp)
  8020a7:	6a 0f                	push   $0xf
  8020a9:	e8 e3 fd ff ff       	call   801e91 <syscall>
  8020ae:	83 c4 18             	add    $0x18,%esp
}
  8020b1:	c9                   	leave  
  8020b2:	c3                   	ret    

008020b3 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8020b3:	55                   	push   %ebp
  8020b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8020b6:	6a 00                	push   $0x0
  8020b8:	6a 00                	push   $0x0
  8020ba:	6a 00                	push   $0x0
  8020bc:	6a 00                	push   $0x0
  8020be:	6a 00                	push   $0x0
  8020c0:	6a 10                	push   $0x10
  8020c2:	e8 ca fd ff ff       	call   801e91 <syscall>
  8020c7:	83 c4 18             	add    $0x18,%esp
}
  8020ca:	90                   	nop
  8020cb:	c9                   	leave  
  8020cc:	c3                   	ret    

008020cd <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8020cd:	55                   	push   %ebp
  8020ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8020d0:	6a 00                	push   $0x0
  8020d2:	6a 00                	push   $0x0
  8020d4:	6a 00                	push   $0x0
  8020d6:	6a 00                	push   $0x0
  8020d8:	6a 00                	push   $0x0
  8020da:	6a 14                	push   $0x14
  8020dc:	e8 b0 fd ff ff       	call   801e91 <syscall>
  8020e1:	83 c4 18             	add    $0x18,%esp
}
  8020e4:	90                   	nop
  8020e5:	c9                   	leave  
  8020e6:	c3                   	ret    

008020e7 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8020e7:	55                   	push   %ebp
  8020e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8020ea:	6a 00                	push   $0x0
  8020ec:	6a 00                	push   $0x0
  8020ee:	6a 00                	push   $0x0
  8020f0:	6a 00                	push   $0x0
  8020f2:	6a 00                	push   $0x0
  8020f4:	6a 15                	push   $0x15
  8020f6:	e8 96 fd ff ff       	call   801e91 <syscall>
  8020fb:	83 c4 18             	add    $0x18,%esp
}
  8020fe:	90                   	nop
  8020ff:	c9                   	leave  
  802100:	c3                   	ret    

00802101 <sys_cputc>:


void
sys_cputc(const char c)
{
  802101:	55                   	push   %ebp
  802102:	89 e5                	mov    %esp,%ebp
  802104:	83 ec 04             	sub    $0x4,%esp
  802107:	8b 45 08             	mov    0x8(%ebp),%eax
  80210a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80210d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802111:	6a 00                	push   $0x0
  802113:	6a 00                	push   $0x0
  802115:	6a 00                	push   $0x0
  802117:	6a 00                	push   $0x0
  802119:	50                   	push   %eax
  80211a:	6a 16                	push   $0x16
  80211c:	e8 70 fd ff ff       	call   801e91 <syscall>
  802121:	83 c4 18             	add    $0x18,%esp
}
  802124:	90                   	nop
  802125:	c9                   	leave  
  802126:	c3                   	ret    

00802127 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802127:	55                   	push   %ebp
  802128:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80212a:	6a 00                	push   $0x0
  80212c:	6a 00                	push   $0x0
  80212e:	6a 00                	push   $0x0
  802130:	6a 00                	push   $0x0
  802132:	6a 00                	push   $0x0
  802134:	6a 17                	push   $0x17
  802136:	e8 56 fd ff ff       	call   801e91 <syscall>
  80213b:	83 c4 18             	add    $0x18,%esp
}
  80213e:	90                   	nop
  80213f:	c9                   	leave  
  802140:	c3                   	ret    

00802141 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802141:	55                   	push   %ebp
  802142:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802144:	8b 45 08             	mov    0x8(%ebp),%eax
  802147:	6a 00                	push   $0x0
  802149:	6a 00                	push   $0x0
  80214b:	6a 00                	push   $0x0
  80214d:	ff 75 0c             	pushl  0xc(%ebp)
  802150:	50                   	push   %eax
  802151:	6a 18                	push   $0x18
  802153:	e8 39 fd ff ff       	call   801e91 <syscall>
  802158:	83 c4 18             	add    $0x18,%esp
}
  80215b:	c9                   	leave  
  80215c:	c3                   	ret    

0080215d <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80215d:	55                   	push   %ebp
  80215e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802160:	8b 55 0c             	mov    0xc(%ebp),%edx
  802163:	8b 45 08             	mov    0x8(%ebp),%eax
  802166:	6a 00                	push   $0x0
  802168:	6a 00                	push   $0x0
  80216a:	6a 00                	push   $0x0
  80216c:	52                   	push   %edx
  80216d:	50                   	push   %eax
  80216e:	6a 1b                	push   $0x1b
  802170:	e8 1c fd ff ff       	call   801e91 <syscall>
  802175:	83 c4 18             	add    $0x18,%esp
}
  802178:	c9                   	leave  
  802179:	c3                   	ret    

0080217a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80217a:	55                   	push   %ebp
  80217b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80217d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802180:	8b 45 08             	mov    0x8(%ebp),%eax
  802183:	6a 00                	push   $0x0
  802185:	6a 00                	push   $0x0
  802187:	6a 00                	push   $0x0
  802189:	52                   	push   %edx
  80218a:	50                   	push   %eax
  80218b:	6a 19                	push   $0x19
  80218d:	e8 ff fc ff ff       	call   801e91 <syscall>
  802192:	83 c4 18             	add    $0x18,%esp
}
  802195:	90                   	nop
  802196:	c9                   	leave  
  802197:	c3                   	ret    

00802198 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802198:	55                   	push   %ebp
  802199:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80219b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80219e:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a1:	6a 00                	push   $0x0
  8021a3:	6a 00                	push   $0x0
  8021a5:	6a 00                	push   $0x0
  8021a7:	52                   	push   %edx
  8021a8:	50                   	push   %eax
  8021a9:	6a 1a                	push   $0x1a
  8021ab:	e8 e1 fc ff ff       	call   801e91 <syscall>
  8021b0:	83 c4 18             	add    $0x18,%esp
}
  8021b3:	90                   	nop
  8021b4:	c9                   	leave  
  8021b5:	c3                   	ret    

008021b6 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8021b6:	55                   	push   %ebp
  8021b7:	89 e5                	mov    %esp,%ebp
  8021b9:	83 ec 04             	sub    $0x4,%esp
  8021bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8021bf:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8021c2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8021c5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8021c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8021cc:	6a 00                	push   $0x0
  8021ce:	51                   	push   %ecx
  8021cf:	52                   	push   %edx
  8021d0:	ff 75 0c             	pushl  0xc(%ebp)
  8021d3:	50                   	push   %eax
  8021d4:	6a 1c                	push   $0x1c
  8021d6:	e8 b6 fc ff ff       	call   801e91 <syscall>
  8021db:	83 c4 18             	add    $0x18,%esp
}
  8021de:	c9                   	leave  
  8021df:	c3                   	ret    

008021e0 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8021e0:	55                   	push   %ebp
  8021e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8021e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8021e9:	6a 00                	push   $0x0
  8021eb:	6a 00                	push   $0x0
  8021ed:	6a 00                	push   $0x0
  8021ef:	52                   	push   %edx
  8021f0:	50                   	push   %eax
  8021f1:	6a 1d                	push   $0x1d
  8021f3:	e8 99 fc ff ff       	call   801e91 <syscall>
  8021f8:	83 c4 18             	add    $0x18,%esp
}
  8021fb:	c9                   	leave  
  8021fc:	c3                   	ret    

008021fd <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8021fd:	55                   	push   %ebp
  8021fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802200:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802203:	8b 55 0c             	mov    0xc(%ebp),%edx
  802206:	8b 45 08             	mov    0x8(%ebp),%eax
  802209:	6a 00                	push   $0x0
  80220b:	6a 00                	push   $0x0
  80220d:	51                   	push   %ecx
  80220e:	52                   	push   %edx
  80220f:	50                   	push   %eax
  802210:	6a 1e                	push   $0x1e
  802212:	e8 7a fc ff ff       	call   801e91 <syscall>
  802217:	83 c4 18             	add    $0x18,%esp
}
  80221a:	c9                   	leave  
  80221b:	c3                   	ret    

0080221c <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80221c:	55                   	push   %ebp
  80221d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80221f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802222:	8b 45 08             	mov    0x8(%ebp),%eax
  802225:	6a 00                	push   $0x0
  802227:	6a 00                	push   $0x0
  802229:	6a 00                	push   $0x0
  80222b:	52                   	push   %edx
  80222c:	50                   	push   %eax
  80222d:	6a 1f                	push   $0x1f
  80222f:	e8 5d fc ff ff       	call   801e91 <syscall>
  802234:	83 c4 18             	add    $0x18,%esp
}
  802237:	c9                   	leave  
  802238:	c3                   	ret    

00802239 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802239:	55                   	push   %ebp
  80223a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80223c:	6a 00                	push   $0x0
  80223e:	6a 00                	push   $0x0
  802240:	6a 00                	push   $0x0
  802242:	6a 00                	push   $0x0
  802244:	6a 00                	push   $0x0
  802246:	6a 20                	push   $0x20
  802248:	e8 44 fc ff ff       	call   801e91 <syscall>
  80224d:	83 c4 18             	add    $0x18,%esp
}
  802250:	c9                   	leave  
  802251:	c3                   	ret    

00802252 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802252:	55                   	push   %ebp
  802253:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802255:	8b 45 08             	mov    0x8(%ebp),%eax
  802258:	6a 00                	push   $0x0
  80225a:	ff 75 14             	pushl  0x14(%ebp)
  80225d:	ff 75 10             	pushl  0x10(%ebp)
  802260:	ff 75 0c             	pushl  0xc(%ebp)
  802263:	50                   	push   %eax
  802264:	6a 21                	push   $0x21
  802266:	e8 26 fc ff ff       	call   801e91 <syscall>
  80226b:	83 c4 18             	add    $0x18,%esp
}
  80226e:	c9                   	leave  
  80226f:	c3                   	ret    

00802270 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  802270:	55                   	push   %ebp
  802271:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802273:	8b 45 08             	mov    0x8(%ebp),%eax
  802276:	6a 00                	push   $0x0
  802278:	6a 00                	push   $0x0
  80227a:	6a 00                	push   $0x0
  80227c:	6a 00                	push   $0x0
  80227e:	50                   	push   %eax
  80227f:	6a 22                	push   $0x22
  802281:	e8 0b fc ff ff       	call   801e91 <syscall>
  802286:	83 c4 18             	add    $0x18,%esp
}
  802289:	90                   	nop
  80228a:	c9                   	leave  
  80228b:	c3                   	ret    

0080228c <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80228c:	55                   	push   %ebp
  80228d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80228f:	8b 45 08             	mov    0x8(%ebp),%eax
  802292:	6a 00                	push   $0x0
  802294:	6a 00                	push   $0x0
  802296:	6a 00                	push   $0x0
  802298:	6a 00                	push   $0x0
  80229a:	50                   	push   %eax
  80229b:	6a 23                	push   $0x23
  80229d:	e8 ef fb ff ff       	call   801e91 <syscall>
  8022a2:	83 c4 18             	add    $0x18,%esp
}
  8022a5:	90                   	nop
  8022a6:	c9                   	leave  
  8022a7:	c3                   	ret    

008022a8 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8022a8:	55                   	push   %ebp
  8022a9:	89 e5                	mov    %esp,%ebp
  8022ab:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8022ae:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8022b1:	8d 50 04             	lea    0x4(%eax),%edx
  8022b4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8022b7:	6a 00                	push   $0x0
  8022b9:	6a 00                	push   $0x0
  8022bb:	6a 00                	push   $0x0
  8022bd:	52                   	push   %edx
  8022be:	50                   	push   %eax
  8022bf:	6a 24                	push   $0x24
  8022c1:	e8 cb fb ff ff       	call   801e91 <syscall>
  8022c6:	83 c4 18             	add    $0x18,%esp
	return result;
  8022c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8022cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8022cf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8022d2:	89 01                	mov    %eax,(%ecx)
  8022d4:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8022d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8022da:	c9                   	leave  
  8022db:	c2 04 00             	ret    $0x4

008022de <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8022de:	55                   	push   %ebp
  8022df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8022e1:	6a 00                	push   $0x0
  8022e3:	6a 00                	push   $0x0
  8022e5:	ff 75 10             	pushl  0x10(%ebp)
  8022e8:	ff 75 0c             	pushl  0xc(%ebp)
  8022eb:	ff 75 08             	pushl  0x8(%ebp)
  8022ee:	6a 13                	push   $0x13
  8022f0:	e8 9c fb ff ff       	call   801e91 <syscall>
  8022f5:	83 c4 18             	add    $0x18,%esp
	return ;
  8022f8:	90                   	nop
}
  8022f9:	c9                   	leave  
  8022fa:	c3                   	ret    

008022fb <sys_rcr2>:
uint32 sys_rcr2()
{
  8022fb:	55                   	push   %ebp
  8022fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8022fe:	6a 00                	push   $0x0
  802300:	6a 00                	push   $0x0
  802302:	6a 00                	push   $0x0
  802304:	6a 00                	push   $0x0
  802306:	6a 00                	push   $0x0
  802308:	6a 25                	push   $0x25
  80230a:	e8 82 fb ff ff       	call   801e91 <syscall>
  80230f:	83 c4 18             	add    $0x18,%esp
}
  802312:	c9                   	leave  
  802313:	c3                   	ret    

00802314 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802314:	55                   	push   %ebp
  802315:	89 e5                	mov    %esp,%ebp
  802317:	83 ec 04             	sub    $0x4,%esp
  80231a:	8b 45 08             	mov    0x8(%ebp),%eax
  80231d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802320:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802324:	6a 00                	push   $0x0
  802326:	6a 00                	push   $0x0
  802328:	6a 00                	push   $0x0
  80232a:	6a 00                	push   $0x0
  80232c:	50                   	push   %eax
  80232d:	6a 26                	push   $0x26
  80232f:	e8 5d fb ff ff       	call   801e91 <syscall>
  802334:	83 c4 18             	add    $0x18,%esp
	return ;
  802337:	90                   	nop
}
  802338:	c9                   	leave  
  802339:	c3                   	ret    

0080233a <rsttst>:
void rsttst()
{
  80233a:	55                   	push   %ebp
  80233b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80233d:	6a 00                	push   $0x0
  80233f:	6a 00                	push   $0x0
  802341:	6a 00                	push   $0x0
  802343:	6a 00                	push   $0x0
  802345:	6a 00                	push   $0x0
  802347:	6a 28                	push   $0x28
  802349:	e8 43 fb ff ff       	call   801e91 <syscall>
  80234e:	83 c4 18             	add    $0x18,%esp
	return ;
  802351:	90                   	nop
}
  802352:	c9                   	leave  
  802353:	c3                   	ret    

00802354 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802354:	55                   	push   %ebp
  802355:	89 e5                	mov    %esp,%ebp
  802357:	83 ec 04             	sub    $0x4,%esp
  80235a:	8b 45 14             	mov    0x14(%ebp),%eax
  80235d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802360:	8b 55 18             	mov    0x18(%ebp),%edx
  802363:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802367:	52                   	push   %edx
  802368:	50                   	push   %eax
  802369:	ff 75 10             	pushl  0x10(%ebp)
  80236c:	ff 75 0c             	pushl  0xc(%ebp)
  80236f:	ff 75 08             	pushl  0x8(%ebp)
  802372:	6a 27                	push   $0x27
  802374:	e8 18 fb ff ff       	call   801e91 <syscall>
  802379:	83 c4 18             	add    $0x18,%esp
	return ;
  80237c:	90                   	nop
}
  80237d:	c9                   	leave  
  80237e:	c3                   	ret    

0080237f <chktst>:
void chktst(uint32 n)
{
  80237f:	55                   	push   %ebp
  802380:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802382:	6a 00                	push   $0x0
  802384:	6a 00                	push   $0x0
  802386:	6a 00                	push   $0x0
  802388:	6a 00                	push   $0x0
  80238a:	ff 75 08             	pushl  0x8(%ebp)
  80238d:	6a 29                	push   $0x29
  80238f:	e8 fd fa ff ff       	call   801e91 <syscall>
  802394:	83 c4 18             	add    $0x18,%esp
	return ;
  802397:	90                   	nop
}
  802398:	c9                   	leave  
  802399:	c3                   	ret    

0080239a <inctst>:

void inctst()
{
  80239a:	55                   	push   %ebp
  80239b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80239d:	6a 00                	push   $0x0
  80239f:	6a 00                	push   $0x0
  8023a1:	6a 00                	push   $0x0
  8023a3:	6a 00                	push   $0x0
  8023a5:	6a 00                	push   $0x0
  8023a7:	6a 2a                	push   $0x2a
  8023a9:	e8 e3 fa ff ff       	call   801e91 <syscall>
  8023ae:	83 c4 18             	add    $0x18,%esp
	return ;
  8023b1:	90                   	nop
}
  8023b2:	c9                   	leave  
  8023b3:	c3                   	ret    

008023b4 <gettst>:
uint32 gettst()
{
  8023b4:	55                   	push   %ebp
  8023b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8023b7:	6a 00                	push   $0x0
  8023b9:	6a 00                	push   $0x0
  8023bb:	6a 00                	push   $0x0
  8023bd:	6a 00                	push   $0x0
  8023bf:	6a 00                	push   $0x0
  8023c1:	6a 2b                	push   $0x2b
  8023c3:	e8 c9 fa ff ff       	call   801e91 <syscall>
  8023c8:	83 c4 18             	add    $0x18,%esp
}
  8023cb:	c9                   	leave  
  8023cc:	c3                   	ret    

008023cd <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8023cd:	55                   	push   %ebp
  8023ce:	89 e5                	mov    %esp,%ebp
  8023d0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023d3:	6a 00                	push   $0x0
  8023d5:	6a 00                	push   $0x0
  8023d7:	6a 00                	push   $0x0
  8023d9:	6a 00                	push   $0x0
  8023db:	6a 00                	push   $0x0
  8023dd:	6a 2c                	push   $0x2c
  8023df:	e8 ad fa ff ff       	call   801e91 <syscall>
  8023e4:	83 c4 18             	add    $0x18,%esp
  8023e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8023ea:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8023ee:	75 07                	jne    8023f7 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8023f0:	b8 01 00 00 00       	mov    $0x1,%eax
  8023f5:	eb 05                	jmp    8023fc <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8023f7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023fc:	c9                   	leave  
  8023fd:	c3                   	ret    

008023fe <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8023fe:	55                   	push   %ebp
  8023ff:	89 e5                	mov    %esp,%ebp
  802401:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802404:	6a 00                	push   $0x0
  802406:	6a 00                	push   $0x0
  802408:	6a 00                	push   $0x0
  80240a:	6a 00                	push   $0x0
  80240c:	6a 00                	push   $0x0
  80240e:	6a 2c                	push   $0x2c
  802410:	e8 7c fa ff ff       	call   801e91 <syscall>
  802415:	83 c4 18             	add    $0x18,%esp
  802418:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80241b:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80241f:	75 07                	jne    802428 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802421:	b8 01 00 00 00       	mov    $0x1,%eax
  802426:	eb 05                	jmp    80242d <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802428:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80242d:	c9                   	leave  
  80242e:	c3                   	ret    

0080242f <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80242f:	55                   	push   %ebp
  802430:	89 e5                	mov    %esp,%ebp
  802432:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802435:	6a 00                	push   $0x0
  802437:	6a 00                	push   $0x0
  802439:	6a 00                	push   $0x0
  80243b:	6a 00                	push   $0x0
  80243d:	6a 00                	push   $0x0
  80243f:	6a 2c                	push   $0x2c
  802441:	e8 4b fa ff ff       	call   801e91 <syscall>
  802446:	83 c4 18             	add    $0x18,%esp
  802449:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80244c:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802450:	75 07                	jne    802459 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802452:	b8 01 00 00 00       	mov    $0x1,%eax
  802457:	eb 05                	jmp    80245e <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802459:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80245e:	c9                   	leave  
  80245f:	c3                   	ret    

00802460 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802460:	55                   	push   %ebp
  802461:	89 e5                	mov    %esp,%ebp
  802463:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802466:	6a 00                	push   $0x0
  802468:	6a 00                	push   $0x0
  80246a:	6a 00                	push   $0x0
  80246c:	6a 00                	push   $0x0
  80246e:	6a 00                	push   $0x0
  802470:	6a 2c                	push   $0x2c
  802472:	e8 1a fa ff ff       	call   801e91 <syscall>
  802477:	83 c4 18             	add    $0x18,%esp
  80247a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80247d:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802481:	75 07                	jne    80248a <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802483:	b8 01 00 00 00       	mov    $0x1,%eax
  802488:	eb 05                	jmp    80248f <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80248a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80248f:	c9                   	leave  
  802490:	c3                   	ret    

00802491 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802491:	55                   	push   %ebp
  802492:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802494:	6a 00                	push   $0x0
  802496:	6a 00                	push   $0x0
  802498:	6a 00                	push   $0x0
  80249a:	6a 00                	push   $0x0
  80249c:	ff 75 08             	pushl  0x8(%ebp)
  80249f:	6a 2d                	push   $0x2d
  8024a1:	e8 eb f9 ff ff       	call   801e91 <syscall>
  8024a6:	83 c4 18             	add    $0x18,%esp
	return ;
  8024a9:	90                   	nop
}
  8024aa:	c9                   	leave  
  8024ab:	c3                   	ret    

008024ac <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8024ac:	55                   	push   %ebp
  8024ad:	89 e5                	mov    %esp,%ebp
  8024af:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8024b0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8024b3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8024b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8024bc:	6a 00                	push   $0x0
  8024be:	53                   	push   %ebx
  8024bf:	51                   	push   %ecx
  8024c0:	52                   	push   %edx
  8024c1:	50                   	push   %eax
  8024c2:	6a 2e                	push   $0x2e
  8024c4:	e8 c8 f9 ff ff       	call   801e91 <syscall>
  8024c9:	83 c4 18             	add    $0x18,%esp
}
  8024cc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8024cf:	c9                   	leave  
  8024d0:	c3                   	ret    

008024d1 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8024d1:	55                   	push   %ebp
  8024d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8024d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8024da:	6a 00                	push   $0x0
  8024dc:	6a 00                	push   $0x0
  8024de:	6a 00                	push   $0x0
  8024e0:	52                   	push   %edx
  8024e1:	50                   	push   %eax
  8024e2:	6a 2f                	push   $0x2f
  8024e4:	e8 a8 f9 ff ff       	call   801e91 <syscall>
  8024e9:	83 c4 18             	add    $0x18,%esp
}
  8024ec:	c9                   	leave  
  8024ed:	c3                   	ret    
  8024ee:	66 90                	xchg   %ax,%ax

008024f0 <__udivdi3>:
  8024f0:	55                   	push   %ebp
  8024f1:	57                   	push   %edi
  8024f2:	56                   	push   %esi
  8024f3:	53                   	push   %ebx
  8024f4:	83 ec 1c             	sub    $0x1c,%esp
  8024f7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8024fb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8024ff:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802503:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802507:	89 ca                	mov    %ecx,%edx
  802509:	89 f8                	mov    %edi,%eax
  80250b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80250f:	85 f6                	test   %esi,%esi
  802511:	75 2d                	jne    802540 <__udivdi3+0x50>
  802513:	39 cf                	cmp    %ecx,%edi
  802515:	77 65                	ja     80257c <__udivdi3+0x8c>
  802517:	89 fd                	mov    %edi,%ebp
  802519:	85 ff                	test   %edi,%edi
  80251b:	75 0b                	jne    802528 <__udivdi3+0x38>
  80251d:	b8 01 00 00 00       	mov    $0x1,%eax
  802522:	31 d2                	xor    %edx,%edx
  802524:	f7 f7                	div    %edi
  802526:	89 c5                	mov    %eax,%ebp
  802528:	31 d2                	xor    %edx,%edx
  80252a:	89 c8                	mov    %ecx,%eax
  80252c:	f7 f5                	div    %ebp
  80252e:	89 c1                	mov    %eax,%ecx
  802530:	89 d8                	mov    %ebx,%eax
  802532:	f7 f5                	div    %ebp
  802534:	89 cf                	mov    %ecx,%edi
  802536:	89 fa                	mov    %edi,%edx
  802538:	83 c4 1c             	add    $0x1c,%esp
  80253b:	5b                   	pop    %ebx
  80253c:	5e                   	pop    %esi
  80253d:	5f                   	pop    %edi
  80253e:	5d                   	pop    %ebp
  80253f:	c3                   	ret    
  802540:	39 ce                	cmp    %ecx,%esi
  802542:	77 28                	ja     80256c <__udivdi3+0x7c>
  802544:	0f bd fe             	bsr    %esi,%edi
  802547:	83 f7 1f             	xor    $0x1f,%edi
  80254a:	75 40                	jne    80258c <__udivdi3+0x9c>
  80254c:	39 ce                	cmp    %ecx,%esi
  80254e:	72 0a                	jb     80255a <__udivdi3+0x6a>
  802550:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802554:	0f 87 9e 00 00 00    	ja     8025f8 <__udivdi3+0x108>
  80255a:	b8 01 00 00 00       	mov    $0x1,%eax
  80255f:	89 fa                	mov    %edi,%edx
  802561:	83 c4 1c             	add    $0x1c,%esp
  802564:	5b                   	pop    %ebx
  802565:	5e                   	pop    %esi
  802566:	5f                   	pop    %edi
  802567:	5d                   	pop    %ebp
  802568:	c3                   	ret    
  802569:	8d 76 00             	lea    0x0(%esi),%esi
  80256c:	31 ff                	xor    %edi,%edi
  80256e:	31 c0                	xor    %eax,%eax
  802570:	89 fa                	mov    %edi,%edx
  802572:	83 c4 1c             	add    $0x1c,%esp
  802575:	5b                   	pop    %ebx
  802576:	5e                   	pop    %esi
  802577:	5f                   	pop    %edi
  802578:	5d                   	pop    %ebp
  802579:	c3                   	ret    
  80257a:	66 90                	xchg   %ax,%ax
  80257c:	89 d8                	mov    %ebx,%eax
  80257e:	f7 f7                	div    %edi
  802580:	31 ff                	xor    %edi,%edi
  802582:	89 fa                	mov    %edi,%edx
  802584:	83 c4 1c             	add    $0x1c,%esp
  802587:	5b                   	pop    %ebx
  802588:	5e                   	pop    %esi
  802589:	5f                   	pop    %edi
  80258a:	5d                   	pop    %ebp
  80258b:	c3                   	ret    
  80258c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802591:	89 eb                	mov    %ebp,%ebx
  802593:	29 fb                	sub    %edi,%ebx
  802595:	89 f9                	mov    %edi,%ecx
  802597:	d3 e6                	shl    %cl,%esi
  802599:	89 c5                	mov    %eax,%ebp
  80259b:	88 d9                	mov    %bl,%cl
  80259d:	d3 ed                	shr    %cl,%ebp
  80259f:	89 e9                	mov    %ebp,%ecx
  8025a1:	09 f1                	or     %esi,%ecx
  8025a3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8025a7:	89 f9                	mov    %edi,%ecx
  8025a9:	d3 e0                	shl    %cl,%eax
  8025ab:	89 c5                	mov    %eax,%ebp
  8025ad:	89 d6                	mov    %edx,%esi
  8025af:	88 d9                	mov    %bl,%cl
  8025b1:	d3 ee                	shr    %cl,%esi
  8025b3:	89 f9                	mov    %edi,%ecx
  8025b5:	d3 e2                	shl    %cl,%edx
  8025b7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8025bb:	88 d9                	mov    %bl,%cl
  8025bd:	d3 e8                	shr    %cl,%eax
  8025bf:	09 c2                	or     %eax,%edx
  8025c1:	89 d0                	mov    %edx,%eax
  8025c3:	89 f2                	mov    %esi,%edx
  8025c5:	f7 74 24 0c          	divl   0xc(%esp)
  8025c9:	89 d6                	mov    %edx,%esi
  8025cb:	89 c3                	mov    %eax,%ebx
  8025cd:	f7 e5                	mul    %ebp
  8025cf:	39 d6                	cmp    %edx,%esi
  8025d1:	72 19                	jb     8025ec <__udivdi3+0xfc>
  8025d3:	74 0b                	je     8025e0 <__udivdi3+0xf0>
  8025d5:	89 d8                	mov    %ebx,%eax
  8025d7:	31 ff                	xor    %edi,%edi
  8025d9:	e9 58 ff ff ff       	jmp    802536 <__udivdi3+0x46>
  8025de:	66 90                	xchg   %ax,%ax
  8025e0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8025e4:	89 f9                	mov    %edi,%ecx
  8025e6:	d3 e2                	shl    %cl,%edx
  8025e8:	39 c2                	cmp    %eax,%edx
  8025ea:	73 e9                	jae    8025d5 <__udivdi3+0xe5>
  8025ec:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8025ef:	31 ff                	xor    %edi,%edi
  8025f1:	e9 40 ff ff ff       	jmp    802536 <__udivdi3+0x46>
  8025f6:	66 90                	xchg   %ax,%ax
  8025f8:	31 c0                	xor    %eax,%eax
  8025fa:	e9 37 ff ff ff       	jmp    802536 <__udivdi3+0x46>
  8025ff:	90                   	nop

00802600 <__umoddi3>:
  802600:	55                   	push   %ebp
  802601:	57                   	push   %edi
  802602:	56                   	push   %esi
  802603:	53                   	push   %ebx
  802604:	83 ec 1c             	sub    $0x1c,%esp
  802607:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80260b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80260f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802613:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802617:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80261b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80261f:	89 f3                	mov    %esi,%ebx
  802621:	89 fa                	mov    %edi,%edx
  802623:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802627:	89 34 24             	mov    %esi,(%esp)
  80262a:	85 c0                	test   %eax,%eax
  80262c:	75 1a                	jne    802648 <__umoddi3+0x48>
  80262e:	39 f7                	cmp    %esi,%edi
  802630:	0f 86 a2 00 00 00    	jbe    8026d8 <__umoddi3+0xd8>
  802636:	89 c8                	mov    %ecx,%eax
  802638:	89 f2                	mov    %esi,%edx
  80263a:	f7 f7                	div    %edi
  80263c:	89 d0                	mov    %edx,%eax
  80263e:	31 d2                	xor    %edx,%edx
  802640:	83 c4 1c             	add    $0x1c,%esp
  802643:	5b                   	pop    %ebx
  802644:	5e                   	pop    %esi
  802645:	5f                   	pop    %edi
  802646:	5d                   	pop    %ebp
  802647:	c3                   	ret    
  802648:	39 f0                	cmp    %esi,%eax
  80264a:	0f 87 ac 00 00 00    	ja     8026fc <__umoddi3+0xfc>
  802650:	0f bd e8             	bsr    %eax,%ebp
  802653:	83 f5 1f             	xor    $0x1f,%ebp
  802656:	0f 84 ac 00 00 00    	je     802708 <__umoddi3+0x108>
  80265c:	bf 20 00 00 00       	mov    $0x20,%edi
  802661:	29 ef                	sub    %ebp,%edi
  802663:	89 fe                	mov    %edi,%esi
  802665:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802669:	89 e9                	mov    %ebp,%ecx
  80266b:	d3 e0                	shl    %cl,%eax
  80266d:	89 d7                	mov    %edx,%edi
  80266f:	89 f1                	mov    %esi,%ecx
  802671:	d3 ef                	shr    %cl,%edi
  802673:	09 c7                	or     %eax,%edi
  802675:	89 e9                	mov    %ebp,%ecx
  802677:	d3 e2                	shl    %cl,%edx
  802679:	89 14 24             	mov    %edx,(%esp)
  80267c:	89 d8                	mov    %ebx,%eax
  80267e:	d3 e0                	shl    %cl,%eax
  802680:	89 c2                	mov    %eax,%edx
  802682:	8b 44 24 08          	mov    0x8(%esp),%eax
  802686:	d3 e0                	shl    %cl,%eax
  802688:	89 44 24 04          	mov    %eax,0x4(%esp)
  80268c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802690:	89 f1                	mov    %esi,%ecx
  802692:	d3 e8                	shr    %cl,%eax
  802694:	09 d0                	or     %edx,%eax
  802696:	d3 eb                	shr    %cl,%ebx
  802698:	89 da                	mov    %ebx,%edx
  80269a:	f7 f7                	div    %edi
  80269c:	89 d3                	mov    %edx,%ebx
  80269e:	f7 24 24             	mull   (%esp)
  8026a1:	89 c6                	mov    %eax,%esi
  8026a3:	89 d1                	mov    %edx,%ecx
  8026a5:	39 d3                	cmp    %edx,%ebx
  8026a7:	0f 82 87 00 00 00    	jb     802734 <__umoddi3+0x134>
  8026ad:	0f 84 91 00 00 00    	je     802744 <__umoddi3+0x144>
  8026b3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8026b7:	29 f2                	sub    %esi,%edx
  8026b9:	19 cb                	sbb    %ecx,%ebx
  8026bb:	89 d8                	mov    %ebx,%eax
  8026bd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8026c1:	d3 e0                	shl    %cl,%eax
  8026c3:	89 e9                	mov    %ebp,%ecx
  8026c5:	d3 ea                	shr    %cl,%edx
  8026c7:	09 d0                	or     %edx,%eax
  8026c9:	89 e9                	mov    %ebp,%ecx
  8026cb:	d3 eb                	shr    %cl,%ebx
  8026cd:	89 da                	mov    %ebx,%edx
  8026cf:	83 c4 1c             	add    $0x1c,%esp
  8026d2:	5b                   	pop    %ebx
  8026d3:	5e                   	pop    %esi
  8026d4:	5f                   	pop    %edi
  8026d5:	5d                   	pop    %ebp
  8026d6:	c3                   	ret    
  8026d7:	90                   	nop
  8026d8:	89 fd                	mov    %edi,%ebp
  8026da:	85 ff                	test   %edi,%edi
  8026dc:	75 0b                	jne    8026e9 <__umoddi3+0xe9>
  8026de:	b8 01 00 00 00       	mov    $0x1,%eax
  8026e3:	31 d2                	xor    %edx,%edx
  8026e5:	f7 f7                	div    %edi
  8026e7:	89 c5                	mov    %eax,%ebp
  8026e9:	89 f0                	mov    %esi,%eax
  8026eb:	31 d2                	xor    %edx,%edx
  8026ed:	f7 f5                	div    %ebp
  8026ef:	89 c8                	mov    %ecx,%eax
  8026f1:	f7 f5                	div    %ebp
  8026f3:	89 d0                	mov    %edx,%eax
  8026f5:	e9 44 ff ff ff       	jmp    80263e <__umoddi3+0x3e>
  8026fa:	66 90                	xchg   %ax,%ax
  8026fc:	89 c8                	mov    %ecx,%eax
  8026fe:	89 f2                	mov    %esi,%edx
  802700:	83 c4 1c             	add    $0x1c,%esp
  802703:	5b                   	pop    %ebx
  802704:	5e                   	pop    %esi
  802705:	5f                   	pop    %edi
  802706:	5d                   	pop    %ebp
  802707:	c3                   	ret    
  802708:	3b 04 24             	cmp    (%esp),%eax
  80270b:	72 06                	jb     802713 <__umoddi3+0x113>
  80270d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802711:	77 0f                	ja     802722 <__umoddi3+0x122>
  802713:	89 f2                	mov    %esi,%edx
  802715:	29 f9                	sub    %edi,%ecx
  802717:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80271b:	89 14 24             	mov    %edx,(%esp)
  80271e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802722:	8b 44 24 04          	mov    0x4(%esp),%eax
  802726:	8b 14 24             	mov    (%esp),%edx
  802729:	83 c4 1c             	add    $0x1c,%esp
  80272c:	5b                   	pop    %ebx
  80272d:	5e                   	pop    %esi
  80272e:	5f                   	pop    %edi
  80272f:	5d                   	pop    %ebp
  802730:	c3                   	ret    
  802731:	8d 76 00             	lea    0x0(%esi),%esi
  802734:	2b 04 24             	sub    (%esp),%eax
  802737:	19 fa                	sbb    %edi,%edx
  802739:	89 d1                	mov    %edx,%ecx
  80273b:	89 c6                	mov    %eax,%esi
  80273d:	e9 71 ff ff ff       	jmp    8026b3 <__umoddi3+0xb3>
  802742:	66 90                	xchg   %ax,%ax
  802744:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802748:	72 ea                	jb     802734 <__umoddi3+0x134>
  80274a:	89 d9                	mov    %ebx,%ecx
  80274c:	e9 62 ff ff ff       	jmp    8026b3 <__umoddi3+0xb3>
