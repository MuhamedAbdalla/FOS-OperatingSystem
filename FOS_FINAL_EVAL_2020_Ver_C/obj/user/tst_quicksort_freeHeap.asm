
obj/user/tst_quicksort_freeHeap:     file format elf32-i386


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
  800031:	e8 22 08 00 00       	call   800858 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
uint32 CheckSorted(int *Elements, int NumOfElements);

int CheckAndCountEmptyLocInWS(volatile struct Env *myEnv);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 34 01 00 00    	sub    $0x134,%esp


	//int InitFreeFrames = sys_calculate_free_frames() ;
	char Line[255] ;
	char Chose ;
	int Iteration = 0 ;
  800042:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	do
	{

		Iteration++ ;
  800049:	ff 45 f0             	incl   -0x10(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

	sys_disable_interrupt();
  80004c:	e8 bc 21 00 00       	call   80220d <sys_disable_interrupt>
		readline("Enter the number of elements: ", Line);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	8d 85 c9 fe ff ff    	lea    -0x137(%ebp),%eax
  80005a:	50                   	push   %eax
  80005b:	68 c0 28 80 00       	push   $0x8028c0
  800060:	e8 54 12 00 00       	call   8012b9 <readline>
  800065:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  800068:	83 ec 04             	sub    $0x4,%esp
  80006b:	6a 0a                	push   $0xa
  80006d:	6a 00                	push   $0x0
  80006f:	8d 85 c9 fe ff ff    	lea    -0x137(%ebp),%eax
  800075:	50                   	push   %eax
  800076:	e8 a4 17 00 00       	call   80181f <strtol>
  80007b:	83 c4 10             	add    $0x10,%esp
  80007e:	89 45 ec             	mov    %eax,-0x14(%ebp)

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  800081:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800084:	c1 e0 02             	shl    $0x2,%eax
  800087:	83 ec 0c             	sub    $0xc,%esp
  80008a:	50                   	push   %eax
  80008b:	e8 37 1b 00 00       	call   801bc7 <malloc>
  800090:	83 c4 10             	add    $0x10,%esp
  800093:	89 45 e8             	mov    %eax,-0x18(%ebp)

		int numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  800096:	a1 24 40 80 00       	mov    0x804024,%eax
  80009b:	83 ec 0c             	sub    $0xc,%esp
  80009e:	50                   	push   %eax
  80009f:	e8 7f 03 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  8000a4:	83 c4 10             	add    $0x10,%esp
  8000a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS ;
  8000aa:	e8 8e 20 00 00       	call   80213d <sys_calculate_free_frames>
  8000af:	89 c3                	mov    %eax,%ebx
  8000b1:	e8 a0 20 00 00       	call   802156 <sys_calculate_modified_frames>
  8000b6:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  8000b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000bc:	29 c2                	sub    %eax,%edx
  8000be:	89 d0                	mov    %edx,%eax
  8000c0:	89 45 e0             	mov    %eax,-0x20(%ebp)

		Elements[NumOfElements] = 10 ;
  8000c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000d0:	01 d0                	add    %edx,%eax
  8000d2:	c7 00 0a 00 00 00    	movl   $0xa,(%eax)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000d8:	83 ec 0c             	sub    $0xc,%esp
  8000db:	68 e0 28 80 00       	push   $0x8028e0
  8000e0:	e8 52 0b 00 00       	call   800c37 <cprintf>
  8000e5:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000e8:	83 ec 0c             	sub    $0xc,%esp
  8000eb:	68 03 29 80 00       	push   $0x802903
  8000f0:	e8 42 0b 00 00       	call   800c37 <cprintf>
  8000f5:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000f8:	83 ec 0c             	sub    $0xc,%esp
  8000fb:	68 11 29 80 00       	push   $0x802911
  800100:	e8 32 0b 00 00       	call   800c37 <cprintf>
  800105:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n") ;
  800108:	83 ec 0c             	sub    $0xc,%esp
  80010b:	68 20 29 80 00       	push   $0x802920
  800110:	e8 22 0b 00 00       	call   800c37 <cprintf>
  800115:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800118:	83 ec 0c             	sub    $0xc,%esp
  80011b:	68 30 29 80 00       	push   $0x802930
  800120:	e8 12 0b 00 00       	call   800c37 <cprintf>
  800125:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800128:	e8 d3 06 00 00       	call   800800 <getchar>
  80012d:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800130:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800134:	83 ec 0c             	sub    $0xc,%esp
  800137:	50                   	push   %eax
  800138:	e8 7b 06 00 00       	call   8007b8 <cputchar>
  80013d:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800140:	83 ec 0c             	sub    $0xc,%esp
  800143:	6a 0a                	push   $0xa
  800145:	e8 6e 06 00 00       	call   8007b8 <cputchar>
  80014a:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  80014d:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800151:	74 0c                	je     80015f <_main+0x127>
  800153:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800157:	74 06                	je     80015f <_main+0x127>
  800159:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  80015d:	75 b9                	jne    800118 <_main+0xe0>
	sys_enable_interrupt();
  80015f:	e8 c3 20 00 00       	call   802227 <sys_enable_interrupt>
		int  i ;
		switch (Chose)
  800164:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800168:	83 f8 62             	cmp    $0x62,%eax
  80016b:	74 1d                	je     80018a <_main+0x152>
  80016d:	83 f8 63             	cmp    $0x63,%eax
  800170:	74 2b                	je     80019d <_main+0x165>
  800172:	83 f8 61             	cmp    $0x61,%eax
  800175:	75 39                	jne    8001b0 <_main+0x178>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800177:	83 ec 08             	sub    $0x8,%esp
  80017a:	ff 75 ec             	pushl  -0x14(%ebp)
  80017d:	ff 75 e8             	pushl  -0x18(%ebp)
  800180:	e8 fb 04 00 00       	call   800680 <InitializeAscending>
  800185:	83 c4 10             	add    $0x10,%esp
			break ;
  800188:	eb 37                	jmp    8001c1 <_main+0x189>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018a:	83 ec 08             	sub    $0x8,%esp
  80018d:	ff 75 ec             	pushl  -0x14(%ebp)
  800190:	ff 75 e8             	pushl  -0x18(%ebp)
  800193:	e8 19 05 00 00       	call   8006b1 <InitializeDescending>
  800198:	83 c4 10             	add    $0x10,%esp
			break ;
  80019b:	eb 24                	jmp    8001c1 <_main+0x189>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  80019d:	83 ec 08             	sub    $0x8,%esp
  8001a0:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a3:	ff 75 e8             	pushl  -0x18(%ebp)
  8001a6:	e8 3b 05 00 00       	call   8006e6 <InitializeSemiRandom>
  8001ab:	83 c4 10             	add    $0x10,%esp
			break ;
  8001ae:	eb 11                	jmp    8001c1 <_main+0x189>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b0:	83 ec 08             	sub    $0x8,%esp
  8001b3:	ff 75 ec             	pushl  -0x14(%ebp)
  8001b6:	ff 75 e8             	pushl  -0x18(%ebp)
  8001b9:	e8 28 05 00 00       	call   8006e6 <InitializeSemiRandom>
  8001be:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001c1:	83 ec 08             	sub    $0x8,%esp
  8001c4:	ff 75 ec             	pushl  -0x14(%ebp)
  8001c7:	ff 75 e8             	pushl  -0x18(%ebp)
  8001ca:	e8 f6 02 00 00       	call   8004c5 <QuickSort>
  8001cf:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001d2:	83 ec 08             	sub    $0x8,%esp
  8001d5:	ff 75 ec             	pushl  -0x14(%ebp)
  8001d8:	ff 75 e8             	pushl  -0x18(%ebp)
  8001db:	e8 f6 03 00 00       	call   8005d6 <CheckSorted>
  8001e0:	83 c4 10             	add    $0x10,%esp
  8001e3:	89 45 dc             	mov    %eax,-0x24(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001e6:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8001ea:	75 14                	jne    800200 <_main+0x1c8>
  8001ec:	83 ec 04             	sub    $0x4,%esp
  8001ef:	68 3c 29 80 00       	push   $0x80293c
  8001f4:	6a 57                	push   $0x57
  8001f6:	68 5e 29 80 00       	push   $0x80295e
  8001fb:	e8 80 07 00 00       	call   800980 <_panic>
		else
		{
			cprintf("===============================================\n") ;
  800200:	83 ec 0c             	sub    $0xc,%esp
  800203:	68 7c 29 80 00       	push   $0x80297c
  800208:	e8 2a 0a 00 00       	call   800c37 <cprintf>
  80020d:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800210:	83 ec 0c             	sub    $0xc,%esp
  800213:	68 b0 29 80 00       	push   $0x8029b0
  800218:	e8 1a 0a 00 00       	call   800c37 <cprintf>
  80021d:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800220:	83 ec 0c             	sub    $0xc,%esp
  800223:	68 e4 29 80 00       	push   $0x8029e4
  800228:	e8 0a 0a 00 00       	call   800c37 <cprintf>
  80022d:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		cprintf("Freeing the Heap...\n\n") ;
  800230:	83 ec 0c             	sub    $0xc,%esp
  800233:	68 16 2a 80 00       	push   $0x802a16
  800238:	e8 fa 09 00 00       	call   800c37 <cprintf>
  80023d:	83 c4 10             	add    $0x10,%esp
		free(Elements) ;
  800240:	83 ec 0c             	sub    $0xc,%esp
  800243:	ff 75 e8             	pushl  -0x18(%ebp)
  800246:	e8 41 1c 00 00       	call   801e8c <free>
  80024b:	83 c4 10             	add    $0x10,%esp


		///Testing the freeHeap according to the specified scenario
		if (Iteration == 1)
  80024e:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  800252:	75 72                	jne    8002c6 <_main+0x28e>
		{
			if (!(NumOfElements == 1000 && Chose == 'a'))
  800254:	81 7d ec e8 03 00 00 	cmpl   $0x3e8,-0x14(%ebp)
  80025b:	75 06                	jne    800263 <_main+0x22b>
  80025d:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800261:	74 14                	je     800277 <_main+0x23f>
				panic("Please ensure the number of elements and the initialization method of this test");
  800263:	83 ec 04             	sub    $0x4,%esp
  800266:	68 2c 2a 80 00       	push   $0x802a2c
  80026b:	6a 69                	push   $0x69
  80026d:	68 5e 29 80 00       	push   $0x80295e
  800272:	e8 09 07 00 00       	call   800980 <_panic>

			numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  800277:	a1 24 40 80 00       	mov    0x804024,%eax
  80027c:	83 ec 0c             	sub    $0xc,%esp
  80027f:	50                   	push   %eax
  800280:	e8 9e 01 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  800285:	83 c4 10             	add    $0x10,%esp
  800288:	89 45 e4             	mov    %eax,-0x1c(%ebp)
			int CurrFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS;
  80028b:	e8 ad 1e 00 00       	call   80213d <sys_calculate_free_frames>
  800290:	89 c3                	mov    %eax,%ebx
  800292:	e8 bf 1e 00 00       	call   802156 <sys_calculate_modified_frames>
  800297:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  80029a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80029d:	29 c2                	sub    %eax,%edx
  80029f:	89 d0                	mov    %edx,%eax
  8002a1:	89 45 d8             	mov    %eax,-0x28(%ebp)
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
  8002a4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002a7:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8002aa:	0f 84 05 01 00 00    	je     8003b5 <_main+0x37d>
  8002b0:	68 7c 2a 80 00       	push   $0x802a7c
  8002b5:	68 a1 2a 80 00       	push   $0x802aa1
  8002ba:	6a 6d                	push   $0x6d
  8002bc:	68 5e 29 80 00       	push   $0x80295e
  8002c1:	e8 ba 06 00 00       	call   800980 <_panic>
		}
		else if (Iteration == 2 )
  8002c6:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  8002ca:	75 72                	jne    80033e <_main+0x306>
		{
			if (!(NumOfElements == 5000 && Chose == 'b'))
  8002cc:	81 7d ec 88 13 00 00 	cmpl   $0x1388,-0x14(%ebp)
  8002d3:	75 06                	jne    8002db <_main+0x2a3>
  8002d5:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  8002d9:	74 14                	je     8002ef <_main+0x2b7>
				panic("Please ensure the number of elements and the initialization method of this test");
  8002db:	83 ec 04             	sub    $0x4,%esp
  8002de:	68 2c 2a 80 00       	push   $0x802a2c
  8002e3:	6a 72                	push   $0x72
  8002e5:	68 5e 29 80 00       	push   $0x80295e
  8002ea:	e8 91 06 00 00       	call   800980 <_panic>

			int numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  8002ef:	a1 24 40 80 00       	mov    0x804024,%eax
  8002f4:	83 ec 0c             	sub    $0xc,%esp
  8002f7:	50                   	push   %eax
  8002f8:	e8 26 01 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  8002fd:	83 c4 10             	add    $0x10,%esp
  800300:	89 45 d4             	mov    %eax,-0x2c(%ebp)
			int CurrFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS;
  800303:	e8 35 1e 00 00       	call   80213d <sys_calculate_free_frames>
  800308:	89 c3                	mov    %eax,%ebx
  80030a:	e8 47 1e 00 00       	call   802156 <sys_calculate_modified_frames>
  80030f:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  800312:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800315:	29 c2                	sub    %eax,%edx
  800317:	89 d0                	mov    %edx,%eax
  800319:	89 45 d0             	mov    %eax,-0x30(%ebp)
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
  80031c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80031f:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800322:	0f 84 8d 00 00 00    	je     8003b5 <_main+0x37d>
  800328:	68 7c 2a 80 00       	push   $0x802a7c
  80032d:	68 a1 2a 80 00       	push   $0x802aa1
  800332:	6a 76                	push   $0x76
  800334:	68 5e 29 80 00       	push   $0x80295e
  800339:	e8 42 06 00 00       	call   800980 <_panic>
		}
		else if (Iteration == 3 )
  80033e:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
  800342:	75 71                	jne    8003b5 <_main+0x37d>
		{
			if (!(NumOfElements == 300000 && Chose == 'c'))
  800344:	81 7d ec e0 93 04 00 	cmpl   $0x493e0,-0x14(%ebp)
  80034b:	75 06                	jne    800353 <_main+0x31b>
  80034d:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800351:	74 14                	je     800367 <_main+0x32f>
				panic("Please ensure the number of elements and the initialization method of this test");
  800353:	83 ec 04             	sub    $0x4,%esp
  800356:	68 2c 2a 80 00       	push   $0x802a2c
  80035b:	6a 7b                	push   $0x7b
  80035d:	68 5e 29 80 00       	push   $0x80295e
  800362:	e8 19 06 00 00       	call   800980 <_panic>

			int numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  800367:	a1 24 40 80 00       	mov    0x804024,%eax
  80036c:	83 ec 0c             	sub    $0xc,%esp
  80036f:	50                   	push   %eax
  800370:	e8 ae 00 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  800375:	83 c4 10             	add    $0x10,%esp
  800378:	89 45 cc             	mov    %eax,-0x34(%ebp)
			int CurrFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS;
  80037b:	e8 bd 1d 00 00       	call   80213d <sys_calculate_free_frames>
  800380:	89 c3                	mov    %eax,%ebx
  800382:	e8 cf 1d 00 00       	call   802156 <sys_calculate_modified_frames>
  800387:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  80038a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80038d:	29 c2                	sub    %eax,%edx
  80038f:	89 d0                	mov    %edx,%eax
  800391:	89 45 c8             	mov    %eax,-0x38(%ebp)
			//cprintf("numOFEmptyLocInWS = %d\n", numOFEmptyLocInWS );
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
  800394:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800397:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80039a:	74 19                	je     8003b5 <_main+0x37d>
  80039c:	68 7c 2a 80 00       	push   $0x802a7c
  8003a1:	68 a1 2a 80 00       	push   $0x802aa1
  8003a6:	68 80 00 00 00       	push   $0x80
  8003ab:	68 5e 29 80 00       	push   $0x80295e
  8003b0:	e8 cb 05 00 00       	call   800980 <_panic>
		}
		///========================================================================
	sys_disable_interrupt();
  8003b5:	e8 53 1e 00 00       	call   80220d <sys_disable_interrupt>
		Chose = 0 ;
  8003ba:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
		while (Chose != 'y' && Chose != 'n')
  8003be:	eb 42                	jmp    800402 <_main+0x3ca>
		{
			cprintf("Do you want to repeat (y/n): ") ;
  8003c0:	83 ec 0c             	sub    $0xc,%esp
  8003c3:	68 b6 2a 80 00       	push   $0x802ab6
  8003c8:	e8 6a 08 00 00       	call   800c37 <cprintf>
  8003cd:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  8003d0:	e8 2b 04 00 00       	call   800800 <getchar>
  8003d5:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  8003d8:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8003dc:	83 ec 0c             	sub    $0xc,%esp
  8003df:	50                   	push   %eax
  8003e0:	e8 d3 03 00 00       	call   8007b8 <cputchar>
  8003e5:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8003e8:	83 ec 0c             	sub    $0xc,%esp
  8003eb:	6a 0a                	push   $0xa
  8003ed:	e8 c6 03 00 00       	call   8007b8 <cputchar>
  8003f2:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8003f5:	83 ec 0c             	sub    $0xc,%esp
  8003f8:	6a 0a                	push   $0xa
  8003fa:	e8 b9 03 00 00       	call   8007b8 <cputchar>
  8003ff:	83 c4 10             	add    $0x10,%esp
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
		}
		///========================================================================
	sys_disable_interrupt();
		Chose = 0 ;
		while (Chose != 'y' && Chose != 'n')
  800402:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  800406:	74 06                	je     80040e <_main+0x3d6>
  800408:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  80040c:	75 b2                	jne    8003c0 <_main+0x388>
			Chose = getchar() ;
			cputchar(Chose);
			cputchar('\n');
			cputchar('\n');
		}
	sys_enable_interrupt();
  80040e:	e8 14 1e 00 00       	call   802227 <sys_enable_interrupt>

	} while (Chose == 'y');
  800413:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  800417:	0f 84 2c fc ff ff    	je     800049 <_main+0x11>
}
  80041d:	90                   	nop
  80041e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800421:	c9                   	leave  
  800422:	c3                   	ret    

00800423 <CheckAndCountEmptyLocInWS>:

int CheckAndCountEmptyLocInWS(volatile struct Env *myEnv)
{
  800423:	55                   	push   %ebp
  800424:	89 e5                	mov    %esp,%ebp
  800426:	83 ec 18             	sub    $0x18,%esp
	int numOFEmptyLocInWS = 0, i;
  800429:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
  800430:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800437:	eb 76                	jmp    8004af <CheckAndCountEmptyLocInWS+0x8c>
	{
		if (myEnv->__uptr_pws[i].empty)
  800439:	8b 45 08             	mov    0x8(%ebp),%eax
  80043c:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800442:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800445:	89 d0                	mov    %edx,%eax
  800447:	c1 e0 02             	shl    $0x2,%eax
  80044a:	01 d0                	add    %edx,%eax
  80044c:	c1 e0 02             	shl    $0x2,%eax
  80044f:	01 c8                	add    %ecx,%eax
  800451:	8a 40 04             	mov    0x4(%eax),%al
  800454:	84 c0                	test   %al,%al
  800456:	74 05                	je     80045d <CheckAndCountEmptyLocInWS+0x3a>
		{
			numOFEmptyLocInWS++;
  800458:	ff 45 f4             	incl   -0xc(%ebp)
  80045b:	eb 4f                	jmp    8004ac <CheckAndCountEmptyLocInWS+0x89>
		}
		else
		{
			uint32 va = ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) ;
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800466:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800469:	89 d0                	mov    %edx,%eax
  80046b:	c1 e0 02             	shl    $0x2,%eax
  80046e:	01 d0                	add    %edx,%eax
  800470:	c1 e0 02             	shl    $0x2,%eax
  800473:	01 c8                	add    %ecx,%eax
  800475:	8b 00                	mov    (%eax),%eax
  800477:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80047a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80047d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800482:	89 45 e8             	mov    %eax,-0x18(%ebp)
			if (va >= USER_HEAP_START && va < (USER_HEAP_MAX))
  800485:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800488:	85 c0                	test   %eax,%eax
  80048a:	79 20                	jns    8004ac <CheckAndCountEmptyLocInWS+0x89>
  80048c:	81 7d e8 ff ff ff 9f 	cmpl   $0x9fffffff,-0x18(%ebp)
  800493:	77 17                	ja     8004ac <CheckAndCountEmptyLocInWS+0x89>
				panic("freeMem didn't remove its page(s) from the WS");
  800495:	83 ec 04             	sub    $0x4,%esp
  800498:	68 d4 2a 80 00       	push   $0x802ad4
  80049d:	68 9f 00 00 00       	push   $0x9f
  8004a2:	68 5e 29 80 00       	push   $0x80295e
  8004a7:	e8 d4 04 00 00       	call   800980 <_panic>
}

int CheckAndCountEmptyLocInWS(volatile struct Env *myEnv)
{
	int numOFEmptyLocInWS = 0, i;
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
  8004ac:	ff 45 f0             	incl   -0x10(%ebp)
  8004af:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b2:	8b 50 74             	mov    0x74(%eax),%edx
  8004b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004b8:	39 c2                	cmp    %eax,%edx
  8004ba:	0f 87 79 ff ff ff    	ja     800439 <CheckAndCountEmptyLocInWS+0x16>
			uint32 va = ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) ;
			if (va >= USER_HEAP_START && va < (USER_HEAP_MAX))
				panic("freeMem didn't remove its page(s) from the WS");
		}
	}
	return numOFEmptyLocInWS;
  8004c0:	8b 45 f4             	mov    -0xc(%ebp),%eax

}
  8004c3:	c9                   	leave  
  8004c4:	c3                   	ret    

008004c5 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8004c5:	55                   	push   %ebp
  8004c6:	89 e5                	mov    %esp,%ebp
  8004c8:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8004cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ce:	48                   	dec    %eax
  8004cf:	50                   	push   %eax
  8004d0:	6a 00                	push   $0x0
  8004d2:	ff 75 0c             	pushl  0xc(%ebp)
  8004d5:	ff 75 08             	pushl  0x8(%ebp)
  8004d8:	e8 06 00 00 00       	call   8004e3 <QSort>
  8004dd:	83 c4 10             	add    $0x10,%esp
}
  8004e0:	90                   	nop
  8004e1:	c9                   	leave  
  8004e2:	c3                   	ret    

008004e3 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8004e3:	55                   	push   %ebp
  8004e4:	89 e5                	mov    %esp,%ebp
  8004e6:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8004e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ec:	3b 45 14             	cmp    0x14(%ebp),%eax
  8004ef:	0f 8d de 00 00 00    	jge    8005d3 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8004f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8004f8:	40                   	inc    %eax
  8004f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8004fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8004ff:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800502:	e9 80 00 00 00       	jmp    800587 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800507:	ff 45 f4             	incl   -0xc(%ebp)
  80050a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80050d:	3b 45 14             	cmp    0x14(%ebp),%eax
  800510:	7f 2b                	jg     80053d <QSort+0x5a>
  800512:	8b 45 10             	mov    0x10(%ebp),%eax
  800515:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80051c:	8b 45 08             	mov    0x8(%ebp),%eax
  80051f:	01 d0                	add    %edx,%eax
  800521:	8b 10                	mov    (%eax),%edx
  800523:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800526:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80052d:	8b 45 08             	mov    0x8(%ebp),%eax
  800530:	01 c8                	add    %ecx,%eax
  800532:	8b 00                	mov    (%eax),%eax
  800534:	39 c2                	cmp    %eax,%edx
  800536:	7d cf                	jge    800507 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800538:	eb 03                	jmp    80053d <QSort+0x5a>
  80053a:	ff 4d f0             	decl   -0x10(%ebp)
  80053d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800540:	3b 45 10             	cmp    0x10(%ebp),%eax
  800543:	7e 26                	jle    80056b <QSort+0x88>
  800545:	8b 45 10             	mov    0x10(%ebp),%eax
  800548:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80054f:	8b 45 08             	mov    0x8(%ebp),%eax
  800552:	01 d0                	add    %edx,%eax
  800554:	8b 10                	mov    (%eax),%edx
  800556:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800559:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800560:	8b 45 08             	mov    0x8(%ebp),%eax
  800563:	01 c8                	add    %ecx,%eax
  800565:	8b 00                	mov    (%eax),%eax
  800567:	39 c2                	cmp    %eax,%edx
  800569:	7e cf                	jle    80053a <QSort+0x57>

		if (i <= j)
  80056b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80056e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800571:	7f 14                	jg     800587 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800573:	83 ec 04             	sub    $0x4,%esp
  800576:	ff 75 f0             	pushl  -0x10(%ebp)
  800579:	ff 75 f4             	pushl  -0xc(%ebp)
  80057c:	ff 75 08             	pushl  0x8(%ebp)
  80057f:	e8 a9 00 00 00       	call   80062d <Swap>
  800584:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800587:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80058a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80058d:	0f 8e 77 ff ff ff    	jle    80050a <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800593:	83 ec 04             	sub    $0x4,%esp
  800596:	ff 75 f0             	pushl  -0x10(%ebp)
  800599:	ff 75 10             	pushl  0x10(%ebp)
  80059c:	ff 75 08             	pushl  0x8(%ebp)
  80059f:	e8 89 00 00 00       	call   80062d <Swap>
  8005a4:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8005a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005aa:	48                   	dec    %eax
  8005ab:	50                   	push   %eax
  8005ac:	ff 75 10             	pushl  0x10(%ebp)
  8005af:	ff 75 0c             	pushl  0xc(%ebp)
  8005b2:	ff 75 08             	pushl  0x8(%ebp)
  8005b5:	e8 29 ff ff ff       	call   8004e3 <QSort>
  8005ba:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8005bd:	ff 75 14             	pushl  0x14(%ebp)
  8005c0:	ff 75 f4             	pushl  -0xc(%ebp)
  8005c3:	ff 75 0c             	pushl  0xc(%ebp)
  8005c6:	ff 75 08             	pushl  0x8(%ebp)
  8005c9:	e8 15 ff ff ff       	call   8004e3 <QSort>
  8005ce:	83 c4 10             	add    $0x10,%esp
  8005d1:	eb 01                	jmp    8005d4 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8005d3:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  8005d4:	c9                   	leave  
  8005d5:	c3                   	ret    

008005d6 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8005d6:	55                   	push   %ebp
  8005d7:	89 e5                	mov    %esp,%ebp
  8005d9:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8005dc:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8005e3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8005ea:	eb 33                	jmp    80061f <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8005ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8005ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f9:	01 d0                	add    %edx,%eax
  8005fb:	8b 10                	mov    (%eax),%edx
  8005fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800600:	40                   	inc    %eax
  800601:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800608:	8b 45 08             	mov    0x8(%ebp),%eax
  80060b:	01 c8                	add    %ecx,%eax
  80060d:	8b 00                	mov    (%eax),%eax
  80060f:	39 c2                	cmp    %eax,%edx
  800611:	7e 09                	jle    80061c <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800613:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80061a:	eb 0c                	jmp    800628 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80061c:	ff 45 f8             	incl   -0x8(%ebp)
  80061f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800622:	48                   	dec    %eax
  800623:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800626:	7f c4                	jg     8005ec <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800628:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80062b:	c9                   	leave  
  80062c:	c3                   	ret    

0080062d <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80062d:	55                   	push   %ebp
  80062e:	89 e5                	mov    %esp,%ebp
  800630:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800633:	8b 45 0c             	mov    0xc(%ebp),%eax
  800636:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80063d:	8b 45 08             	mov    0x8(%ebp),%eax
  800640:	01 d0                	add    %edx,%eax
  800642:	8b 00                	mov    (%eax),%eax
  800644:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800647:	8b 45 0c             	mov    0xc(%ebp),%eax
  80064a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800651:	8b 45 08             	mov    0x8(%ebp),%eax
  800654:	01 c2                	add    %eax,%edx
  800656:	8b 45 10             	mov    0x10(%ebp),%eax
  800659:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800660:	8b 45 08             	mov    0x8(%ebp),%eax
  800663:	01 c8                	add    %ecx,%eax
  800665:	8b 00                	mov    (%eax),%eax
  800667:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800669:	8b 45 10             	mov    0x10(%ebp),%eax
  80066c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800673:	8b 45 08             	mov    0x8(%ebp),%eax
  800676:	01 c2                	add    %eax,%edx
  800678:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80067b:	89 02                	mov    %eax,(%edx)
}
  80067d:	90                   	nop
  80067e:	c9                   	leave  
  80067f:	c3                   	ret    

00800680 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800680:	55                   	push   %ebp
  800681:	89 e5                	mov    %esp,%ebp
  800683:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800686:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80068d:	eb 17                	jmp    8006a6 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80068f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800692:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800699:	8b 45 08             	mov    0x8(%ebp),%eax
  80069c:	01 c2                	add    %eax,%edx
  80069e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8006a1:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8006a3:	ff 45 fc             	incl   -0x4(%ebp)
  8006a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8006a9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8006ac:	7c e1                	jl     80068f <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8006ae:	90                   	nop
  8006af:	c9                   	leave  
  8006b0:	c3                   	ret    

008006b1 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8006b1:	55                   	push   %ebp
  8006b2:	89 e5                	mov    %esp,%ebp
  8006b4:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8006b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8006be:	eb 1b                	jmp    8006db <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8006c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8006c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cd:	01 c2                	add    %eax,%edx
  8006cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006d2:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8006d5:	48                   	dec    %eax
  8006d6:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8006d8:	ff 45 fc             	incl   -0x4(%ebp)
  8006db:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8006de:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8006e1:	7c dd                	jl     8006c0 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8006e3:	90                   	nop
  8006e4:	c9                   	leave  
  8006e5:	c3                   	ret    

008006e6 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8006e6:	55                   	push   %ebp
  8006e7:	89 e5                	mov    %esp,%ebp
  8006e9:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8006ec:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8006ef:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8006f4:	f7 e9                	imul   %ecx
  8006f6:	c1 f9 1f             	sar    $0x1f,%ecx
  8006f9:	89 d0                	mov    %edx,%eax
  8006fb:	29 c8                	sub    %ecx,%eax
  8006fd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800700:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800707:	eb 1e                	jmp    800727 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800709:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80070c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800713:	8b 45 08             	mov    0x8(%ebp),%eax
  800716:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800719:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80071c:	99                   	cltd   
  80071d:	f7 7d f8             	idivl  -0x8(%ebp)
  800720:	89 d0                	mov    %edx,%eax
  800722:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800724:	ff 45 fc             	incl   -0x4(%ebp)
  800727:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80072a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80072d:	7c da                	jl     800709 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  80072f:	90                   	nop
  800730:	c9                   	leave  
  800731:	c3                   	ret    

00800732 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800732:	55                   	push   %ebp
  800733:	89 e5                	mov    %esp,%ebp
  800735:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800738:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80073f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800746:	eb 42                	jmp    80078a <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800748:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80074b:	99                   	cltd   
  80074c:	f7 7d f0             	idivl  -0x10(%ebp)
  80074f:	89 d0                	mov    %edx,%eax
  800751:	85 c0                	test   %eax,%eax
  800753:	75 10                	jne    800765 <PrintElements+0x33>
			cprintf("\n");
  800755:	83 ec 0c             	sub    $0xc,%esp
  800758:	68 02 2b 80 00       	push   $0x802b02
  80075d:	e8 d5 04 00 00       	call   800c37 <cprintf>
  800762:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800765:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800768:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80076f:	8b 45 08             	mov    0x8(%ebp),%eax
  800772:	01 d0                	add    %edx,%eax
  800774:	8b 00                	mov    (%eax),%eax
  800776:	83 ec 08             	sub    $0x8,%esp
  800779:	50                   	push   %eax
  80077a:	68 04 2b 80 00       	push   $0x802b04
  80077f:	e8 b3 04 00 00       	call   800c37 <cprintf>
  800784:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800787:	ff 45 f4             	incl   -0xc(%ebp)
  80078a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80078d:	48                   	dec    %eax
  80078e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800791:	7f b5                	jg     800748 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800793:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800796:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80079d:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a0:	01 d0                	add    %edx,%eax
  8007a2:	8b 00                	mov    (%eax),%eax
  8007a4:	83 ec 08             	sub    $0x8,%esp
  8007a7:	50                   	push   %eax
  8007a8:	68 09 2b 80 00       	push   $0x802b09
  8007ad:	e8 85 04 00 00       	call   800c37 <cprintf>
  8007b2:	83 c4 10             	add    $0x10,%esp

}
  8007b5:	90                   	nop
  8007b6:	c9                   	leave  
  8007b7:	c3                   	ret    

008007b8 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8007b8:	55                   	push   %ebp
  8007b9:	89 e5                	mov    %esp,%ebp
  8007bb:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8007be:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c1:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8007c4:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8007c8:	83 ec 0c             	sub    $0xc,%esp
  8007cb:	50                   	push   %eax
  8007cc:	e8 70 1a 00 00       	call   802241 <sys_cputc>
  8007d1:	83 c4 10             	add    $0x10,%esp
}
  8007d4:	90                   	nop
  8007d5:	c9                   	leave  
  8007d6:	c3                   	ret    

008007d7 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8007d7:	55                   	push   %ebp
  8007d8:	89 e5                	mov    %esp,%ebp
  8007da:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8007dd:	e8 2b 1a 00 00       	call   80220d <sys_disable_interrupt>
	char c = ch;
  8007e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e5:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8007e8:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8007ec:	83 ec 0c             	sub    $0xc,%esp
  8007ef:	50                   	push   %eax
  8007f0:	e8 4c 1a 00 00       	call   802241 <sys_cputc>
  8007f5:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007f8:	e8 2a 1a 00 00       	call   802227 <sys_enable_interrupt>
}
  8007fd:	90                   	nop
  8007fe:	c9                   	leave  
  8007ff:	c3                   	ret    

00800800 <getchar>:

int
getchar(void)
{
  800800:	55                   	push   %ebp
  800801:	89 e5                	mov    %esp,%ebp
  800803:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800806:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80080d:	eb 08                	jmp    800817 <getchar+0x17>
	{
		c = sys_cgetc();
  80080f:	e8 11 18 00 00       	call   802025 <sys_cgetc>
  800814:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800817:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80081b:	74 f2                	je     80080f <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80081d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800820:	c9                   	leave  
  800821:	c3                   	ret    

00800822 <atomic_getchar>:

int
atomic_getchar(void)
{
  800822:	55                   	push   %ebp
  800823:	89 e5                	mov    %esp,%ebp
  800825:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800828:	e8 e0 19 00 00       	call   80220d <sys_disable_interrupt>
	int c=0;
  80082d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800834:	eb 08                	jmp    80083e <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800836:	e8 ea 17 00 00       	call   802025 <sys_cgetc>
  80083b:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80083e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800842:	74 f2                	je     800836 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800844:	e8 de 19 00 00       	call   802227 <sys_enable_interrupt>
	return c;
  800849:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80084c:	c9                   	leave  
  80084d:	c3                   	ret    

0080084e <iscons>:

int iscons(int fdnum)
{
  80084e:	55                   	push   %ebp
  80084f:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800851:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800856:	5d                   	pop    %ebp
  800857:	c3                   	ret    

00800858 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800858:	55                   	push   %ebp
  800859:	89 e5                	mov    %esp,%ebp
  80085b:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80085e:	e8 0f 18 00 00       	call   802072 <sys_getenvindex>
  800863:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800866:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800869:	89 d0                	mov    %edx,%eax
  80086b:	01 c0                	add    %eax,%eax
  80086d:	01 d0                	add    %edx,%eax
  80086f:	c1 e0 07             	shl    $0x7,%eax
  800872:	29 d0                	sub    %edx,%eax
  800874:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80087b:	01 c8                	add    %ecx,%eax
  80087d:	01 c0                	add    %eax,%eax
  80087f:	01 d0                	add    %edx,%eax
  800881:	01 c0                	add    %eax,%eax
  800883:	01 d0                	add    %edx,%eax
  800885:	c1 e0 03             	shl    $0x3,%eax
  800888:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80088d:	a3 24 40 80 00       	mov    %eax,0x804024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800892:	a1 24 40 80 00       	mov    0x804024,%eax
  800897:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  80089d:	84 c0                	test   %al,%al
  80089f:	74 0f                	je     8008b0 <libmain+0x58>
		binaryname = myEnv->prog_name;
  8008a1:	a1 24 40 80 00       	mov    0x804024,%eax
  8008a6:	05 f0 ee 00 00       	add    $0xeef0,%eax
  8008ab:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8008b0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008b4:	7e 0a                	jle    8008c0 <libmain+0x68>
		binaryname = argv[0];
  8008b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b9:	8b 00                	mov    (%eax),%eax
  8008bb:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  8008c0:	83 ec 08             	sub    $0x8,%esp
  8008c3:	ff 75 0c             	pushl  0xc(%ebp)
  8008c6:	ff 75 08             	pushl  0x8(%ebp)
  8008c9:	e8 6a f7 ff ff       	call   800038 <_main>
  8008ce:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8008d1:	e8 37 19 00 00       	call   80220d <sys_disable_interrupt>
	cprintf("**************************************\n");
  8008d6:	83 ec 0c             	sub    $0xc,%esp
  8008d9:	68 28 2b 80 00       	push   $0x802b28
  8008de:	e8 54 03 00 00       	call   800c37 <cprintf>
  8008e3:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8008e6:	a1 24 40 80 00       	mov    0x804024,%eax
  8008eb:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  8008f1:	a1 24 40 80 00       	mov    0x804024,%eax
  8008f6:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  8008fc:	83 ec 04             	sub    $0x4,%esp
  8008ff:	52                   	push   %edx
  800900:	50                   	push   %eax
  800901:	68 50 2b 80 00       	push   $0x802b50
  800906:	e8 2c 03 00 00       	call   800c37 <cprintf>
  80090b:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80090e:	a1 24 40 80 00       	mov    0x804024,%eax
  800913:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  800919:	a1 24 40 80 00       	mov    0x804024,%eax
  80091e:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  800924:	a1 24 40 80 00       	mov    0x804024,%eax
  800929:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  80092f:	51                   	push   %ecx
  800930:	52                   	push   %edx
  800931:	50                   	push   %eax
  800932:	68 78 2b 80 00       	push   $0x802b78
  800937:	e8 fb 02 00 00       	call   800c37 <cprintf>
  80093c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80093f:	83 ec 0c             	sub    $0xc,%esp
  800942:	68 28 2b 80 00       	push   $0x802b28
  800947:	e8 eb 02 00 00       	call   800c37 <cprintf>
  80094c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80094f:	e8 d3 18 00 00       	call   802227 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800954:	e8 19 00 00 00       	call   800972 <exit>
}
  800959:	90                   	nop
  80095a:	c9                   	leave  
  80095b:	c3                   	ret    

0080095c <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80095c:	55                   	push   %ebp
  80095d:	89 e5                	mov    %esp,%ebp
  80095f:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800962:	83 ec 0c             	sub    $0xc,%esp
  800965:	6a 00                	push   $0x0
  800967:	e8 d2 16 00 00       	call   80203e <sys_env_destroy>
  80096c:	83 c4 10             	add    $0x10,%esp
}
  80096f:	90                   	nop
  800970:	c9                   	leave  
  800971:	c3                   	ret    

00800972 <exit>:

void
exit(void)
{
  800972:	55                   	push   %ebp
  800973:	89 e5                	mov    %esp,%ebp
  800975:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800978:	e8 27 17 00 00       	call   8020a4 <sys_env_exit>
}
  80097d:	90                   	nop
  80097e:	c9                   	leave  
  80097f:	c3                   	ret    

00800980 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800980:	55                   	push   %ebp
  800981:	89 e5                	mov    %esp,%ebp
  800983:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800986:	8d 45 10             	lea    0x10(%ebp),%eax
  800989:	83 c0 04             	add    $0x4,%eax
  80098c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80098f:	a1 18 41 80 00       	mov    0x804118,%eax
  800994:	85 c0                	test   %eax,%eax
  800996:	74 16                	je     8009ae <_panic+0x2e>
		cprintf("%s: ", argv0);
  800998:	a1 18 41 80 00       	mov    0x804118,%eax
  80099d:	83 ec 08             	sub    $0x8,%esp
  8009a0:	50                   	push   %eax
  8009a1:	68 d0 2b 80 00       	push   $0x802bd0
  8009a6:	e8 8c 02 00 00       	call   800c37 <cprintf>
  8009ab:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8009ae:	a1 00 40 80 00       	mov    0x804000,%eax
  8009b3:	ff 75 0c             	pushl  0xc(%ebp)
  8009b6:	ff 75 08             	pushl  0x8(%ebp)
  8009b9:	50                   	push   %eax
  8009ba:	68 d5 2b 80 00       	push   $0x802bd5
  8009bf:	e8 73 02 00 00       	call   800c37 <cprintf>
  8009c4:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8009c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8009ca:	83 ec 08             	sub    $0x8,%esp
  8009cd:	ff 75 f4             	pushl  -0xc(%ebp)
  8009d0:	50                   	push   %eax
  8009d1:	e8 f6 01 00 00       	call   800bcc <vcprintf>
  8009d6:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8009d9:	83 ec 08             	sub    $0x8,%esp
  8009dc:	6a 00                	push   $0x0
  8009de:	68 f1 2b 80 00       	push   $0x802bf1
  8009e3:	e8 e4 01 00 00       	call   800bcc <vcprintf>
  8009e8:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8009eb:	e8 82 ff ff ff       	call   800972 <exit>

	// should not return here
	while (1) ;
  8009f0:	eb fe                	jmp    8009f0 <_panic+0x70>

008009f2 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8009f2:	55                   	push   %ebp
  8009f3:	89 e5                	mov    %esp,%ebp
  8009f5:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8009f8:	a1 24 40 80 00       	mov    0x804024,%eax
  8009fd:	8b 50 74             	mov    0x74(%eax),%edx
  800a00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a03:	39 c2                	cmp    %eax,%edx
  800a05:	74 14                	je     800a1b <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a07:	83 ec 04             	sub    $0x4,%esp
  800a0a:	68 f4 2b 80 00       	push   $0x802bf4
  800a0f:	6a 26                	push   $0x26
  800a11:	68 40 2c 80 00       	push   $0x802c40
  800a16:	e8 65 ff ff ff       	call   800980 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800a1b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800a22:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a29:	e9 c4 00 00 00       	jmp    800af2 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800a2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a31:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a38:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3b:	01 d0                	add    %edx,%eax
  800a3d:	8b 00                	mov    (%eax),%eax
  800a3f:	85 c0                	test   %eax,%eax
  800a41:	75 08                	jne    800a4b <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800a43:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800a46:	e9 a4 00 00 00       	jmp    800aef <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  800a4b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a52:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800a59:	eb 6b                	jmp    800ac6 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800a5b:	a1 24 40 80 00       	mov    0x804024,%eax
  800a60:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800a66:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a69:	89 d0                	mov    %edx,%eax
  800a6b:	c1 e0 02             	shl    $0x2,%eax
  800a6e:	01 d0                	add    %edx,%eax
  800a70:	c1 e0 02             	shl    $0x2,%eax
  800a73:	01 c8                	add    %ecx,%eax
  800a75:	8a 40 04             	mov    0x4(%eax),%al
  800a78:	84 c0                	test   %al,%al
  800a7a:	75 47                	jne    800ac3 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a7c:	a1 24 40 80 00       	mov    0x804024,%eax
  800a81:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800a87:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a8a:	89 d0                	mov    %edx,%eax
  800a8c:	c1 e0 02             	shl    $0x2,%eax
  800a8f:	01 d0                	add    %edx,%eax
  800a91:	c1 e0 02             	shl    $0x2,%eax
  800a94:	01 c8                	add    %ecx,%eax
  800a96:	8b 00                	mov    (%eax),%eax
  800a98:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800a9b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a9e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800aa3:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800aa5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aa8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800aaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab2:	01 c8                	add    %ecx,%eax
  800ab4:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800ab6:	39 c2                	cmp    %eax,%edx
  800ab8:	75 09                	jne    800ac3 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800aba:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800ac1:	eb 12                	jmp    800ad5 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ac3:	ff 45 e8             	incl   -0x18(%ebp)
  800ac6:	a1 24 40 80 00       	mov    0x804024,%eax
  800acb:	8b 50 74             	mov    0x74(%eax),%edx
  800ace:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800ad1:	39 c2                	cmp    %eax,%edx
  800ad3:	77 86                	ja     800a5b <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800ad5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800ad9:	75 14                	jne    800aef <CheckWSWithoutLastIndex+0xfd>
			panic(
  800adb:	83 ec 04             	sub    $0x4,%esp
  800ade:	68 4c 2c 80 00       	push   $0x802c4c
  800ae3:	6a 3a                	push   $0x3a
  800ae5:	68 40 2c 80 00       	push   $0x802c40
  800aea:	e8 91 fe ff ff       	call   800980 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800aef:	ff 45 f0             	incl   -0x10(%ebp)
  800af2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800af5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800af8:	0f 8c 30 ff ff ff    	jl     800a2e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800afe:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b05:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b0c:	eb 27                	jmp    800b35 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b0e:	a1 24 40 80 00       	mov    0x804024,%eax
  800b13:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800b19:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b1c:	89 d0                	mov    %edx,%eax
  800b1e:	c1 e0 02             	shl    $0x2,%eax
  800b21:	01 d0                	add    %edx,%eax
  800b23:	c1 e0 02             	shl    $0x2,%eax
  800b26:	01 c8                	add    %ecx,%eax
  800b28:	8a 40 04             	mov    0x4(%eax),%al
  800b2b:	3c 01                	cmp    $0x1,%al
  800b2d:	75 03                	jne    800b32 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800b2f:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b32:	ff 45 e0             	incl   -0x20(%ebp)
  800b35:	a1 24 40 80 00       	mov    0x804024,%eax
  800b3a:	8b 50 74             	mov    0x74(%eax),%edx
  800b3d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b40:	39 c2                	cmp    %eax,%edx
  800b42:	77 ca                	ja     800b0e <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800b44:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b47:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800b4a:	74 14                	je     800b60 <CheckWSWithoutLastIndex+0x16e>
		panic(
  800b4c:	83 ec 04             	sub    $0x4,%esp
  800b4f:	68 a0 2c 80 00       	push   $0x802ca0
  800b54:	6a 44                	push   $0x44
  800b56:	68 40 2c 80 00       	push   $0x802c40
  800b5b:	e8 20 fe ff ff       	call   800980 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800b60:	90                   	nop
  800b61:	c9                   	leave  
  800b62:	c3                   	ret    

00800b63 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800b63:	55                   	push   %ebp
  800b64:	89 e5                	mov    %esp,%ebp
  800b66:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800b69:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6c:	8b 00                	mov    (%eax),%eax
  800b6e:	8d 48 01             	lea    0x1(%eax),%ecx
  800b71:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b74:	89 0a                	mov    %ecx,(%edx)
  800b76:	8b 55 08             	mov    0x8(%ebp),%edx
  800b79:	88 d1                	mov    %dl,%cl
  800b7b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b7e:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800b82:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b85:	8b 00                	mov    (%eax),%eax
  800b87:	3d ff 00 00 00       	cmp    $0xff,%eax
  800b8c:	75 2c                	jne    800bba <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800b8e:	a0 28 40 80 00       	mov    0x804028,%al
  800b93:	0f b6 c0             	movzbl %al,%eax
  800b96:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b99:	8b 12                	mov    (%edx),%edx
  800b9b:	89 d1                	mov    %edx,%ecx
  800b9d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ba0:	83 c2 08             	add    $0x8,%edx
  800ba3:	83 ec 04             	sub    $0x4,%esp
  800ba6:	50                   	push   %eax
  800ba7:	51                   	push   %ecx
  800ba8:	52                   	push   %edx
  800ba9:	e8 4e 14 00 00       	call   801ffc <sys_cputs>
  800bae:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800bb1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800bba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bbd:	8b 40 04             	mov    0x4(%eax),%eax
  800bc0:	8d 50 01             	lea    0x1(%eax),%edx
  800bc3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc6:	89 50 04             	mov    %edx,0x4(%eax)
}
  800bc9:	90                   	nop
  800bca:	c9                   	leave  
  800bcb:	c3                   	ret    

00800bcc <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800bcc:	55                   	push   %ebp
  800bcd:	89 e5                	mov    %esp,%ebp
  800bcf:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800bd5:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800bdc:	00 00 00 
	b.cnt = 0;
  800bdf:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800be6:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800be9:	ff 75 0c             	pushl  0xc(%ebp)
  800bec:	ff 75 08             	pushl  0x8(%ebp)
  800bef:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800bf5:	50                   	push   %eax
  800bf6:	68 63 0b 80 00       	push   $0x800b63
  800bfb:	e8 11 02 00 00       	call   800e11 <vprintfmt>
  800c00:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800c03:	a0 28 40 80 00       	mov    0x804028,%al
  800c08:	0f b6 c0             	movzbl %al,%eax
  800c0b:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800c11:	83 ec 04             	sub    $0x4,%esp
  800c14:	50                   	push   %eax
  800c15:	52                   	push   %edx
  800c16:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c1c:	83 c0 08             	add    $0x8,%eax
  800c1f:	50                   	push   %eax
  800c20:	e8 d7 13 00 00       	call   801ffc <sys_cputs>
  800c25:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800c28:	c6 05 28 40 80 00 00 	movb   $0x0,0x804028
	return b.cnt;
  800c2f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800c35:	c9                   	leave  
  800c36:	c3                   	ret    

00800c37 <cprintf>:

int cprintf(const char *fmt, ...) {
  800c37:	55                   	push   %ebp
  800c38:	89 e5                	mov    %esp,%ebp
  800c3a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c3d:	c6 05 28 40 80 00 01 	movb   $0x1,0x804028
	va_start(ap, fmt);
  800c44:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c47:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4d:	83 ec 08             	sub    $0x8,%esp
  800c50:	ff 75 f4             	pushl  -0xc(%ebp)
  800c53:	50                   	push   %eax
  800c54:	e8 73 ff ff ff       	call   800bcc <vcprintf>
  800c59:	83 c4 10             	add    $0x10,%esp
  800c5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800c5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c62:	c9                   	leave  
  800c63:	c3                   	ret    

00800c64 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800c64:	55                   	push   %ebp
  800c65:	89 e5                	mov    %esp,%ebp
  800c67:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800c6a:	e8 9e 15 00 00       	call   80220d <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800c6f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c72:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c75:	8b 45 08             	mov    0x8(%ebp),%eax
  800c78:	83 ec 08             	sub    $0x8,%esp
  800c7b:	ff 75 f4             	pushl  -0xc(%ebp)
  800c7e:	50                   	push   %eax
  800c7f:	e8 48 ff ff ff       	call   800bcc <vcprintf>
  800c84:	83 c4 10             	add    $0x10,%esp
  800c87:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800c8a:	e8 98 15 00 00       	call   802227 <sys_enable_interrupt>
	return cnt;
  800c8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c92:	c9                   	leave  
  800c93:	c3                   	ret    

00800c94 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800c94:	55                   	push   %ebp
  800c95:	89 e5                	mov    %esp,%ebp
  800c97:	53                   	push   %ebx
  800c98:	83 ec 14             	sub    $0x14,%esp
  800c9b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ca1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800ca7:	8b 45 18             	mov    0x18(%ebp),%eax
  800caa:	ba 00 00 00 00       	mov    $0x0,%edx
  800caf:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800cb2:	77 55                	ja     800d09 <printnum+0x75>
  800cb4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800cb7:	72 05                	jb     800cbe <printnum+0x2a>
  800cb9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800cbc:	77 4b                	ja     800d09 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800cbe:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800cc1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800cc4:	8b 45 18             	mov    0x18(%ebp),%eax
  800cc7:	ba 00 00 00 00       	mov    $0x0,%edx
  800ccc:	52                   	push   %edx
  800ccd:	50                   	push   %eax
  800cce:	ff 75 f4             	pushl  -0xc(%ebp)
  800cd1:	ff 75 f0             	pushl  -0x10(%ebp)
  800cd4:	e8 73 19 00 00       	call   80264c <__udivdi3>
  800cd9:	83 c4 10             	add    $0x10,%esp
  800cdc:	83 ec 04             	sub    $0x4,%esp
  800cdf:	ff 75 20             	pushl  0x20(%ebp)
  800ce2:	53                   	push   %ebx
  800ce3:	ff 75 18             	pushl  0x18(%ebp)
  800ce6:	52                   	push   %edx
  800ce7:	50                   	push   %eax
  800ce8:	ff 75 0c             	pushl  0xc(%ebp)
  800ceb:	ff 75 08             	pushl  0x8(%ebp)
  800cee:	e8 a1 ff ff ff       	call   800c94 <printnum>
  800cf3:	83 c4 20             	add    $0x20,%esp
  800cf6:	eb 1a                	jmp    800d12 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800cf8:	83 ec 08             	sub    $0x8,%esp
  800cfb:	ff 75 0c             	pushl  0xc(%ebp)
  800cfe:	ff 75 20             	pushl  0x20(%ebp)
  800d01:	8b 45 08             	mov    0x8(%ebp),%eax
  800d04:	ff d0                	call   *%eax
  800d06:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800d09:	ff 4d 1c             	decl   0x1c(%ebp)
  800d0c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800d10:	7f e6                	jg     800cf8 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800d12:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800d15:	bb 00 00 00 00       	mov    $0x0,%ebx
  800d1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d1d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d20:	53                   	push   %ebx
  800d21:	51                   	push   %ecx
  800d22:	52                   	push   %edx
  800d23:	50                   	push   %eax
  800d24:	e8 33 1a 00 00       	call   80275c <__umoddi3>
  800d29:	83 c4 10             	add    $0x10,%esp
  800d2c:	05 14 2f 80 00       	add    $0x802f14,%eax
  800d31:	8a 00                	mov    (%eax),%al
  800d33:	0f be c0             	movsbl %al,%eax
  800d36:	83 ec 08             	sub    $0x8,%esp
  800d39:	ff 75 0c             	pushl  0xc(%ebp)
  800d3c:	50                   	push   %eax
  800d3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d40:	ff d0                	call   *%eax
  800d42:	83 c4 10             	add    $0x10,%esp
}
  800d45:	90                   	nop
  800d46:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800d49:	c9                   	leave  
  800d4a:	c3                   	ret    

00800d4b <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800d4b:	55                   	push   %ebp
  800d4c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d4e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d52:	7e 1c                	jle    800d70 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800d54:	8b 45 08             	mov    0x8(%ebp),%eax
  800d57:	8b 00                	mov    (%eax),%eax
  800d59:	8d 50 08             	lea    0x8(%eax),%edx
  800d5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5f:	89 10                	mov    %edx,(%eax)
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	8b 00                	mov    (%eax),%eax
  800d66:	83 e8 08             	sub    $0x8,%eax
  800d69:	8b 50 04             	mov    0x4(%eax),%edx
  800d6c:	8b 00                	mov    (%eax),%eax
  800d6e:	eb 40                	jmp    800db0 <getuint+0x65>
	else if (lflag)
  800d70:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d74:	74 1e                	je     800d94 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800d76:	8b 45 08             	mov    0x8(%ebp),%eax
  800d79:	8b 00                	mov    (%eax),%eax
  800d7b:	8d 50 04             	lea    0x4(%eax),%edx
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d81:	89 10                	mov    %edx,(%eax)
  800d83:	8b 45 08             	mov    0x8(%ebp),%eax
  800d86:	8b 00                	mov    (%eax),%eax
  800d88:	83 e8 04             	sub    $0x4,%eax
  800d8b:	8b 00                	mov    (%eax),%eax
  800d8d:	ba 00 00 00 00       	mov    $0x0,%edx
  800d92:	eb 1c                	jmp    800db0 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800d94:	8b 45 08             	mov    0x8(%ebp),%eax
  800d97:	8b 00                	mov    (%eax),%eax
  800d99:	8d 50 04             	lea    0x4(%eax),%edx
  800d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9f:	89 10                	mov    %edx,(%eax)
  800da1:	8b 45 08             	mov    0x8(%ebp),%eax
  800da4:	8b 00                	mov    (%eax),%eax
  800da6:	83 e8 04             	sub    $0x4,%eax
  800da9:	8b 00                	mov    (%eax),%eax
  800dab:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800db0:	5d                   	pop    %ebp
  800db1:	c3                   	ret    

00800db2 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800db2:	55                   	push   %ebp
  800db3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800db5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800db9:	7e 1c                	jle    800dd7 <getint+0x25>
		return va_arg(*ap, long long);
  800dbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbe:	8b 00                	mov    (%eax),%eax
  800dc0:	8d 50 08             	lea    0x8(%eax),%edx
  800dc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc6:	89 10                	mov    %edx,(%eax)
  800dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcb:	8b 00                	mov    (%eax),%eax
  800dcd:	83 e8 08             	sub    $0x8,%eax
  800dd0:	8b 50 04             	mov    0x4(%eax),%edx
  800dd3:	8b 00                	mov    (%eax),%eax
  800dd5:	eb 38                	jmp    800e0f <getint+0x5d>
	else if (lflag)
  800dd7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ddb:	74 1a                	je     800df7 <getint+0x45>
		return va_arg(*ap, long);
  800ddd:	8b 45 08             	mov    0x8(%ebp),%eax
  800de0:	8b 00                	mov    (%eax),%eax
  800de2:	8d 50 04             	lea    0x4(%eax),%edx
  800de5:	8b 45 08             	mov    0x8(%ebp),%eax
  800de8:	89 10                	mov    %edx,(%eax)
  800dea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ded:	8b 00                	mov    (%eax),%eax
  800def:	83 e8 04             	sub    $0x4,%eax
  800df2:	8b 00                	mov    (%eax),%eax
  800df4:	99                   	cltd   
  800df5:	eb 18                	jmp    800e0f <getint+0x5d>
	else
		return va_arg(*ap, int);
  800df7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfa:	8b 00                	mov    (%eax),%eax
  800dfc:	8d 50 04             	lea    0x4(%eax),%edx
  800dff:	8b 45 08             	mov    0x8(%ebp),%eax
  800e02:	89 10                	mov    %edx,(%eax)
  800e04:	8b 45 08             	mov    0x8(%ebp),%eax
  800e07:	8b 00                	mov    (%eax),%eax
  800e09:	83 e8 04             	sub    $0x4,%eax
  800e0c:	8b 00                	mov    (%eax),%eax
  800e0e:	99                   	cltd   
}
  800e0f:	5d                   	pop    %ebp
  800e10:	c3                   	ret    

00800e11 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800e11:	55                   	push   %ebp
  800e12:	89 e5                	mov    %esp,%ebp
  800e14:	56                   	push   %esi
  800e15:	53                   	push   %ebx
  800e16:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e19:	eb 17                	jmp    800e32 <vprintfmt+0x21>
			if (ch == '\0')
  800e1b:	85 db                	test   %ebx,%ebx
  800e1d:	0f 84 af 03 00 00    	je     8011d2 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800e23:	83 ec 08             	sub    $0x8,%esp
  800e26:	ff 75 0c             	pushl  0xc(%ebp)
  800e29:	53                   	push   %ebx
  800e2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2d:	ff d0                	call   *%eax
  800e2f:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e32:	8b 45 10             	mov    0x10(%ebp),%eax
  800e35:	8d 50 01             	lea    0x1(%eax),%edx
  800e38:	89 55 10             	mov    %edx,0x10(%ebp)
  800e3b:	8a 00                	mov    (%eax),%al
  800e3d:	0f b6 d8             	movzbl %al,%ebx
  800e40:	83 fb 25             	cmp    $0x25,%ebx
  800e43:	75 d6                	jne    800e1b <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800e45:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800e49:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800e50:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800e57:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800e5e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800e65:	8b 45 10             	mov    0x10(%ebp),%eax
  800e68:	8d 50 01             	lea    0x1(%eax),%edx
  800e6b:	89 55 10             	mov    %edx,0x10(%ebp)
  800e6e:	8a 00                	mov    (%eax),%al
  800e70:	0f b6 d8             	movzbl %al,%ebx
  800e73:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800e76:	83 f8 55             	cmp    $0x55,%eax
  800e79:	0f 87 2b 03 00 00    	ja     8011aa <vprintfmt+0x399>
  800e7f:	8b 04 85 38 2f 80 00 	mov    0x802f38(,%eax,4),%eax
  800e86:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800e88:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800e8c:	eb d7                	jmp    800e65 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800e8e:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800e92:	eb d1                	jmp    800e65 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e94:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800e9b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e9e:	89 d0                	mov    %edx,%eax
  800ea0:	c1 e0 02             	shl    $0x2,%eax
  800ea3:	01 d0                	add    %edx,%eax
  800ea5:	01 c0                	add    %eax,%eax
  800ea7:	01 d8                	add    %ebx,%eax
  800ea9:	83 e8 30             	sub    $0x30,%eax
  800eac:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800eaf:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb2:	8a 00                	mov    (%eax),%al
  800eb4:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800eb7:	83 fb 2f             	cmp    $0x2f,%ebx
  800eba:	7e 3e                	jle    800efa <vprintfmt+0xe9>
  800ebc:	83 fb 39             	cmp    $0x39,%ebx
  800ebf:	7f 39                	jg     800efa <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ec1:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ec4:	eb d5                	jmp    800e9b <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800ec6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec9:	83 c0 04             	add    $0x4,%eax
  800ecc:	89 45 14             	mov    %eax,0x14(%ebp)
  800ecf:	8b 45 14             	mov    0x14(%ebp),%eax
  800ed2:	83 e8 04             	sub    $0x4,%eax
  800ed5:	8b 00                	mov    (%eax),%eax
  800ed7:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800eda:	eb 1f                	jmp    800efb <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800edc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ee0:	79 83                	jns    800e65 <vprintfmt+0x54>
				width = 0;
  800ee2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800ee9:	e9 77 ff ff ff       	jmp    800e65 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800eee:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800ef5:	e9 6b ff ff ff       	jmp    800e65 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800efa:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800efb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800eff:	0f 89 60 ff ff ff    	jns    800e65 <vprintfmt+0x54>
				width = precision, precision = -1;
  800f05:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f08:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800f0b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800f12:	e9 4e ff ff ff       	jmp    800e65 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800f17:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800f1a:	e9 46 ff ff ff       	jmp    800e65 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800f1f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f22:	83 c0 04             	add    $0x4,%eax
  800f25:	89 45 14             	mov    %eax,0x14(%ebp)
  800f28:	8b 45 14             	mov    0x14(%ebp),%eax
  800f2b:	83 e8 04             	sub    $0x4,%eax
  800f2e:	8b 00                	mov    (%eax),%eax
  800f30:	83 ec 08             	sub    $0x8,%esp
  800f33:	ff 75 0c             	pushl  0xc(%ebp)
  800f36:	50                   	push   %eax
  800f37:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3a:	ff d0                	call   *%eax
  800f3c:	83 c4 10             	add    $0x10,%esp
			break;
  800f3f:	e9 89 02 00 00       	jmp    8011cd <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800f44:	8b 45 14             	mov    0x14(%ebp),%eax
  800f47:	83 c0 04             	add    $0x4,%eax
  800f4a:	89 45 14             	mov    %eax,0x14(%ebp)
  800f4d:	8b 45 14             	mov    0x14(%ebp),%eax
  800f50:	83 e8 04             	sub    $0x4,%eax
  800f53:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800f55:	85 db                	test   %ebx,%ebx
  800f57:	79 02                	jns    800f5b <vprintfmt+0x14a>
				err = -err;
  800f59:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800f5b:	83 fb 64             	cmp    $0x64,%ebx
  800f5e:	7f 0b                	jg     800f6b <vprintfmt+0x15a>
  800f60:	8b 34 9d 80 2d 80 00 	mov    0x802d80(,%ebx,4),%esi
  800f67:	85 f6                	test   %esi,%esi
  800f69:	75 19                	jne    800f84 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800f6b:	53                   	push   %ebx
  800f6c:	68 25 2f 80 00       	push   $0x802f25
  800f71:	ff 75 0c             	pushl  0xc(%ebp)
  800f74:	ff 75 08             	pushl  0x8(%ebp)
  800f77:	e8 5e 02 00 00       	call   8011da <printfmt>
  800f7c:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800f7f:	e9 49 02 00 00       	jmp    8011cd <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800f84:	56                   	push   %esi
  800f85:	68 2e 2f 80 00       	push   $0x802f2e
  800f8a:	ff 75 0c             	pushl  0xc(%ebp)
  800f8d:	ff 75 08             	pushl  0x8(%ebp)
  800f90:	e8 45 02 00 00       	call   8011da <printfmt>
  800f95:	83 c4 10             	add    $0x10,%esp
			break;
  800f98:	e9 30 02 00 00       	jmp    8011cd <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800f9d:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa0:	83 c0 04             	add    $0x4,%eax
  800fa3:	89 45 14             	mov    %eax,0x14(%ebp)
  800fa6:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa9:	83 e8 04             	sub    $0x4,%eax
  800fac:	8b 30                	mov    (%eax),%esi
  800fae:	85 f6                	test   %esi,%esi
  800fb0:	75 05                	jne    800fb7 <vprintfmt+0x1a6>
				p = "(null)";
  800fb2:	be 31 2f 80 00       	mov    $0x802f31,%esi
			if (width > 0 && padc != '-')
  800fb7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fbb:	7e 6d                	jle    80102a <vprintfmt+0x219>
  800fbd:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800fc1:	74 67                	je     80102a <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800fc3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800fc6:	83 ec 08             	sub    $0x8,%esp
  800fc9:	50                   	push   %eax
  800fca:	56                   	push   %esi
  800fcb:	e8 12 05 00 00       	call   8014e2 <strnlen>
  800fd0:	83 c4 10             	add    $0x10,%esp
  800fd3:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800fd6:	eb 16                	jmp    800fee <vprintfmt+0x1dd>
					putch(padc, putdat);
  800fd8:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800fdc:	83 ec 08             	sub    $0x8,%esp
  800fdf:	ff 75 0c             	pushl  0xc(%ebp)
  800fe2:	50                   	push   %eax
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	ff d0                	call   *%eax
  800fe8:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800feb:	ff 4d e4             	decl   -0x1c(%ebp)
  800fee:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ff2:	7f e4                	jg     800fd8 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ff4:	eb 34                	jmp    80102a <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800ff6:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800ffa:	74 1c                	je     801018 <vprintfmt+0x207>
  800ffc:	83 fb 1f             	cmp    $0x1f,%ebx
  800fff:	7e 05                	jle    801006 <vprintfmt+0x1f5>
  801001:	83 fb 7e             	cmp    $0x7e,%ebx
  801004:	7e 12                	jle    801018 <vprintfmt+0x207>
					putch('?', putdat);
  801006:	83 ec 08             	sub    $0x8,%esp
  801009:	ff 75 0c             	pushl  0xc(%ebp)
  80100c:	6a 3f                	push   $0x3f
  80100e:	8b 45 08             	mov    0x8(%ebp),%eax
  801011:	ff d0                	call   *%eax
  801013:	83 c4 10             	add    $0x10,%esp
  801016:	eb 0f                	jmp    801027 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801018:	83 ec 08             	sub    $0x8,%esp
  80101b:	ff 75 0c             	pushl  0xc(%ebp)
  80101e:	53                   	push   %ebx
  80101f:	8b 45 08             	mov    0x8(%ebp),%eax
  801022:	ff d0                	call   *%eax
  801024:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801027:	ff 4d e4             	decl   -0x1c(%ebp)
  80102a:	89 f0                	mov    %esi,%eax
  80102c:	8d 70 01             	lea    0x1(%eax),%esi
  80102f:	8a 00                	mov    (%eax),%al
  801031:	0f be d8             	movsbl %al,%ebx
  801034:	85 db                	test   %ebx,%ebx
  801036:	74 24                	je     80105c <vprintfmt+0x24b>
  801038:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80103c:	78 b8                	js     800ff6 <vprintfmt+0x1e5>
  80103e:	ff 4d e0             	decl   -0x20(%ebp)
  801041:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801045:	79 af                	jns    800ff6 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801047:	eb 13                	jmp    80105c <vprintfmt+0x24b>
				putch(' ', putdat);
  801049:	83 ec 08             	sub    $0x8,%esp
  80104c:	ff 75 0c             	pushl  0xc(%ebp)
  80104f:	6a 20                	push   $0x20
  801051:	8b 45 08             	mov    0x8(%ebp),%eax
  801054:	ff d0                	call   *%eax
  801056:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801059:	ff 4d e4             	decl   -0x1c(%ebp)
  80105c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801060:	7f e7                	jg     801049 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801062:	e9 66 01 00 00       	jmp    8011cd <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801067:	83 ec 08             	sub    $0x8,%esp
  80106a:	ff 75 e8             	pushl  -0x18(%ebp)
  80106d:	8d 45 14             	lea    0x14(%ebp),%eax
  801070:	50                   	push   %eax
  801071:	e8 3c fd ff ff       	call   800db2 <getint>
  801076:	83 c4 10             	add    $0x10,%esp
  801079:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80107c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80107f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801082:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801085:	85 d2                	test   %edx,%edx
  801087:	79 23                	jns    8010ac <vprintfmt+0x29b>
				putch('-', putdat);
  801089:	83 ec 08             	sub    $0x8,%esp
  80108c:	ff 75 0c             	pushl  0xc(%ebp)
  80108f:	6a 2d                	push   $0x2d
  801091:	8b 45 08             	mov    0x8(%ebp),%eax
  801094:	ff d0                	call   *%eax
  801096:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801099:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80109c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80109f:	f7 d8                	neg    %eax
  8010a1:	83 d2 00             	adc    $0x0,%edx
  8010a4:	f7 da                	neg    %edx
  8010a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010a9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8010ac:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8010b3:	e9 bc 00 00 00       	jmp    801174 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8010b8:	83 ec 08             	sub    $0x8,%esp
  8010bb:	ff 75 e8             	pushl  -0x18(%ebp)
  8010be:	8d 45 14             	lea    0x14(%ebp),%eax
  8010c1:	50                   	push   %eax
  8010c2:	e8 84 fc ff ff       	call   800d4b <getuint>
  8010c7:	83 c4 10             	add    $0x10,%esp
  8010ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010cd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8010d0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8010d7:	e9 98 00 00 00       	jmp    801174 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8010dc:	83 ec 08             	sub    $0x8,%esp
  8010df:	ff 75 0c             	pushl  0xc(%ebp)
  8010e2:	6a 58                	push   $0x58
  8010e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e7:	ff d0                	call   *%eax
  8010e9:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8010ec:	83 ec 08             	sub    $0x8,%esp
  8010ef:	ff 75 0c             	pushl  0xc(%ebp)
  8010f2:	6a 58                	push   $0x58
  8010f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f7:	ff d0                	call   *%eax
  8010f9:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8010fc:	83 ec 08             	sub    $0x8,%esp
  8010ff:	ff 75 0c             	pushl  0xc(%ebp)
  801102:	6a 58                	push   $0x58
  801104:	8b 45 08             	mov    0x8(%ebp),%eax
  801107:	ff d0                	call   *%eax
  801109:	83 c4 10             	add    $0x10,%esp
			break;
  80110c:	e9 bc 00 00 00       	jmp    8011cd <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801111:	83 ec 08             	sub    $0x8,%esp
  801114:	ff 75 0c             	pushl  0xc(%ebp)
  801117:	6a 30                	push   $0x30
  801119:	8b 45 08             	mov    0x8(%ebp),%eax
  80111c:	ff d0                	call   *%eax
  80111e:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801121:	83 ec 08             	sub    $0x8,%esp
  801124:	ff 75 0c             	pushl  0xc(%ebp)
  801127:	6a 78                	push   $0x78
  801129:	8b 45 08             	mov    0x8(%ebp),%eax
  80112c:	ff d0                	call   *%eax
  80112e:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801131:	8b 45 14             	mov    0x14(%ebp),%eax
  801134:	83 c0 04             	add    $0x4,%eax
  801137:	89 45 14             	mov    %eax,0x14(%ebp)
  80113a:	8b 45 14             	mov    0x14(%ebp),%eax
  80113d:	83 e8 04             	sub    $0x4,%eax
  801140:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801142:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801145:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80114c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801153:	eb 1f                	jmp    801174 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801155:	83 ec 08             	sub    $0x8,%esp
  801158:	ff 75 e8             	pushl  -0x18(%ebp)
  80115b:	8d 45 14             	lea    0x14(%ebp),%eax
  80115e:	50                   	push   %eax
  80115f:	e8 e7 fb ff ff       	call   800d4b <getuint>
  801164:	83 c4 10             	add    $0x10,%esp
  801167:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80116a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80116d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801174:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801178:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80117b:	83 ec 04             	sub    $0x4,%esp
  80117e:	52                   	push   %edx
  80117f:	ff 75 e4             	pushl  -0x1c(%ebp)
  801182:	50                   	push   %eax
  801183:	ff 75 f4             	pushl  -0xc(%ebp)
  801186:	ff 75 f0             	pushl  -0x10(%ebp)
  801189:	ff 75 0c             	pushl  0xc(%ebp)
  80118c:	ff 75 08             	pushl  0x8(%ebp)
  80118f:	e8 00 fb ff ff       	call   800c94 <printnum>
  801194:	83 c4 20             	add    $0x20,%esp
			break;
  801197:	eb 34                	jmp    8011cd <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801199:	83 ec 08             	sub    $0x8,%esp
  80119c:	ff 75 0c             	pushl  0xc(%ebp)
  80119f:	53                   	push   %ebx
  8011a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a3:	ff d0                	call   *%eax
  8011a5:	83 c4 10             	add    $0x10,%esp
			break;
  8011a8:	eb 23                	jmp    8011cd <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8011aa:	83 ec 08             	sub    $0x8,%esp
  8011ad:	ff 75 0c             	pushl  0xc(%ebp)
  8011b0:	6a 25                	push   $0x25
  8011b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b5:	ff d0                	call   *%eax
  8011b7:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8011ba:	ff 4d 10             	decl   0x10(%ebp)
  8011bd:	eb 03                	jmp    8011c2 <vprintfmt+0x3b1>
  8011bf:	ff 4d 10             	decl   0x10(%ebp)
  8011c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c5:	48                   	dec    %eax
  8011c6:	8a 00                	mov    (%eax),%al
  8011c8:	3c 25                	cmp    $0x25,%al
  8011ca:	75 f3                	jne    8011bf <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8011cc:	90                   	nop
		}
	}
  8011cd:	e9 47 fc ff ff       	jmp    800e19 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8011d2:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8011d3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8011d6:	5b                   	pop    %ebx
  8011d7:	5e                   	pop    %esi
  8011d8:	5d                   	pop    %ebp
  8011d9:	c3                   	ret    

008011da <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8011da:	55                   	push   %ebp
  8011db:	89 e5                	mov    %esp,%ebp
  8011dd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8011e0:	8d 45 10             	lea    0x10(%ebp),%eax
  8011e3:	83 c0 04             	add    $0x4,%eax
  8011e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8011e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ec:	ff 75 f4             	pushl  -0xc(%ebp)
  8011ef:	50                   	push   %eax
  8011f0:	ff 75 0c             	pushl  0xc(%ebp)
  8011f3:	ff 75 08             	pushl  0x8(%ebp)
  8011f6:	e8 16 fc ff ff       	call   800e11 <vprintfmt>
  8011fb:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8011fe:	90                   	nop
  8011ff:	c9                   	leave  
  801200:	c3                   	ret    

00801201 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801201:	55                   	push   %ebp
  801202:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801204:	8b 45 0c             	mov    0xc(%ebp),%eax
  801207:	8b 40 08             	mov    0x8(%eax),%eax
  80120a:	8d 50 01             	lea    0x1(%eax),%edx
  80120d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801210:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801213:	8b 45 0c             	mov    0xc(%ebp),%eax
  801216:	8b 10                	mov    (%eax),%edx
  801218:	8b 45 0c             	mov    0xc(%ebp),%eax
  80121b:	8b 40 04             	mov    0x4(%eax),%eax
  80121e:	39 c2                	cmp    %eax,%edx
  801220:	73 12                	jae    801234 <sprintputch+0x33>
		*b->buf++ = ch;
  801222:	8b 45 0c             	mov    0xc(%ebp),%eax
  801225:	8b 00                	mov    (%eax),%eax
  801227:	8d 48 01             	lea    0x1(%eax),%ecx
  80122a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80122d:	89 0a                	mov    %ecx,(%edx)
  80122f:	8b 55 08             	mov    0x8(%ebp),%edx
  801232:	88 10                	mov    %dl,(%eax)
}
  801234:	90                   	nop
  801235:	5d                   	pop    %ebp
  801236:	c3                   	ret    

00801237 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801237:	55                   	push   %ebp
  801238:	89 e5                	mov    %esp,%ebp
  80123a:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80123d:	8b 45 08             	mov    0x8(%ebp),%eax
  801240:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801243:	8b 45 0c             	mov    0xc(%ebp),%eax
  801246:	8d 50 ff             	lea    -0x1(%eax),%edx
  801249:	8b 45 08             	mov    0x8(%ebp),%eax
  80124c:	01 d0                	add    %edx,%eax
  80124e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801251:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801258:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80125c:	74 06                	je     801264 <vsnprintf+0x2d>
  80125e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801262:	7f 07                	jg     80126b <vsnprintf+0x34>
		return -E_INVAL;
  801264:	b8 03 00 00 00       	mov    $0x3,%eax
  801269:	eb 20                	jmp    80128b <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80126b:	ff 75 14             	pushl  0x14(%ebp)
  80126e:	ff 75 10             	pushl  0x10(%ebp)
  801271:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801274:	50                   	push   %eax
  801275:	68 01 12 80 00       	push   $0x801201
  80127a:	e8 92 fb ff ff       	call   800e11 <vprintfmt>
  80127f:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801282:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801285:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801288:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80128b:	c9                   	leave  
  80128c:	c3                   	ret    

0080128d <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80128d:	55                   	push   %ebp
  80128e:	89 e5                	mov    %esp,%ebp
  801290:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801293:	8d 45 10             	lea    0x10(%ebp),%eax
  801296:	83 c0 04             	add    $0x4,%eax
  801299:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80129c:	8b 45 10             	mov    0x10(%ebp),%eax
  80129f:	ff 75 f4             	pushl  -0xc(%ebp)
  8012a2:	50                   	push   %eax
  8012a3:	ff 75 0c             	pushl  0xc(%ebp)
  8012a6:	ff 75 08             	pushl  0x8(%ebp)
  8012a9:	e8 89 ff ff ff       	call   801237 <vsnprintf>
  8012ae:	83 c4 10             	add    $0x10,%esp
  8012b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8012b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012b7:	c9                   	leave  
  8012b8:	c3                   	ret    

008012b9 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8012b9:	55                   	push   %ebp
  8012ba:	89 e5                	mov    %esp,%ebp
  8012bc:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8012bf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012c3:	74 13                	je     8012d8 <readline+0x1f>
		cprintf("%s", prompt);
  8012c5:	83 ec 08             	sub    $0x8,%esp
  8012c8:	ff 75 08             	pushl  0x8(%ebp)
  8012cb:	68 90 30 80 00       	push   $0x803090
  8012d0:	e8 62 f9 ff ff       	call   800c37 <cprintf>
  8012d5:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8012d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8012df:	83 ec 0c             	sub    $0xc,%esp
  8012e2:	6a 00                	push   $0x0
  8012e4:	e8 65 f5 ff ff       	call   80084e <iscons>
  8012e9:	83 c4 10             	add    $0x10,%esp
  8012ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8012ef:	e8 0c f5 ff ff       	call   800800 <getchar>
  8012f4:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8012f7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8012fb:	79 22                	jns    80131f <readline+0x66>
			if (c != -E_EOF)
  8012fd:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801301:	0f 84 ad 00 00 00    	je     8013b4 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801307:	83 ec 08             	sub    $0x8,%esp
  80130a:	ff 75 ec             	pushl  -0x14(%ebp)
  80130d:	68 93 30 80 00       	push   $0x803093
  801312:	e8 20 f9 ff ff       	call   800c37 <cprintf>
  801317:	83 c4 10             	add    $0x10,%esp
			return;
  80131a:	e9 95 00 00 00       	jmp    8013b4 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80131f:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801323:	7e 34                	jle    801359 <readline+0xa0>
  801325:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80132c:	7f 2b                	jg     801359 <readline+0xa0>
			if (echoing)
  80132e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801332:	74 0e                	je     801342 <readline+0x89>
				cputchar(c);
  801334:	83 ec 0c             	sub    $0xc,%esp
  801337:	ff 75 ec             	pushl  -0x14(%ebp)
  80133a:	e8 79 f4 ff ff       	call   8007b8 <cputchar>
  80133f:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801342:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801345:	8d 50 01             	lea    0x1(%eax),%edx
  801348:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80134b:	89 c2                	mov    %eax,%edx
  80134d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801350:	01 d0                	add    %edx,%eax
  801352:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801355:	88 10                	mov    %dl,(%eax)
  801357:	eb 56                	jmp    8013af <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801359:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80135d:	75 1f                	jne    80137e <readline+0xc5>
  80135f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801363:	7e 19                	jle    80137e <readline+0xc5>
			if (echoing)
  801365:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801369:	74 0e                	je     801379 <readline+0xc0>
				cputchar(c);
  80136b:	83 ec 0c             	sub    $0xc,%esp
  80136e:	ff 75 ec             	pushl  -0x14(%ebp)
  801371:	e8 42 f4 ff ff       	call   8007b8 <cputchar>
  801376:	83 c4 10             	add    $0x10,%esp

			i--;
  801379:	ff 4d f4             	decl   -0xc(%ebp)
  80137c:	eb 31                	jmp    8013af <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  80137e:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801382:	74 0a                	je     80138e <readline+0xd5>
  801384:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801388:	0f 85 61 ff ff ff    	jne    8012ef <readline+0x36>
			if (echoing)
  80138e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801392:	74 0e                	je     8013a2 <readline+0xe9>
				cputchar(c);
  801394:	83 ec 0c             	sub    $0xc,%esp
  801397:	ff 75 ec             	pushl  -0x14(%ebp)
  80139a:	e8 19 f4 ff ff       	call   8007b8 <cputchar>
  80139f:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8013a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a8:	01 d0                	add    %edx,%eax
  8013aa:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8013ad:	eb 06                	jmp    8013b5 <readline+0xfc>
		}
	}
  8013af:	e9 3b ff ff ff       	jmp    8012ef <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8013b4:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8013b5:	c9                   	leave  
  8013b6:	c3                   	ret    

008013b7 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8013b7:	55                   	push   %ebp
  8013b8:	89 e5                	mov    %esp,%ebp
  8013ba:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8013bd:	e8 4b 0e 00 00       	call   80220d <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8013c2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013c6:	74 13                	je     8013db <atomic_readline+0x24>
		cprintf("%s", prompt);
  8013c8:	83 ec 08             	sub    $0x8,%esp
  8013cb:	ff 75 08             	pushl  0x8(%ebp)
  8013ce:	68 90 30 80 00       	push   $0x803090
  8013d3:	e8 5f f8 ff ff       	call   800c37 <cprintf>
  8013d8:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8013db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8013e2:	83 ec 0c             	sub    $0xc,%esp
  8013e5:	6a 00                	push   $0x0
  8013e7:	e8 62 f4 ff ff       	call   80084e <iscons>
  8013ec:	83 c4 10             	add    $0x10,%esp
  8013ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8013f2:	e8 09 f4 ff ff       	call   800800 <getchar>
  8013f7:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8013fa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8013fe:	79 23                	jns    801423 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801400:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801404:	74 13                	je     801419 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801406:	83 ec 08             	sub    $0x8,%esp
  801409:	ff 75 ec             	pushl  -0x14(%ebp)
  80140c:	68 93 30 80 00       	push   $0x803093
  801411:	e8 21 f8 ff ff       	call   800c37 <cprintf>
  801416:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801419:	e8 09 0e 00 00       	call   802227 <sys_enable_interrupt>
			return;
  80141e:	e9 9a 00 00 00       	jmp    8014bd <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801423:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801427:	7e 34                	jle    80145d <atomic_readline+0xa6>
  801429:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801430:	7f 2b                	jg     80145d <atomic_readline+0xa6>
			if (echoing)
  801432:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801436:	74 0e                	je     801446 <atomic_readline+0x8f>
				cputchar(c);
  801438:	83 ec 0c             	sub    $0xc,%esp
  80143b:	ff 75 ec             	pushl  -0x14(%ebp)
  80143e:	e8 75 f3 ff ff       	call   8007b8 <cputchar>
  801443:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801446:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801449:	8d 50 01             	lea    0x1(%eax),%edx
  80144c:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80144f:	89 c2                	mov    %eax,%edx
  801451:	8b 45 0c             	mov    0xc(%ebp),%eax
  801454:	01 d0                	add    %edx,%eax
  801456:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801459:	88 10                	mov    %dl,(%eax)
  80145b:	eb 5b                	jmp    8014b8 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  80145d:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801461:	75 1f                	jne    801482 <atomic_readline+0xcb>
  801463:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801467:	7e 19                	jle    801482 <atomic_readline+0xcb>
			if (echoing)
  801469:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80146d:	74 0e                	je     80147d <atomic_readline+0xc6>
				cputchar(c);
  80146f:	83 ec 0c             	sub    $0xc,%esp
  801472:	ff 75 ec             	pushl  -0x14(%ebp)
  801475:	e8 3e f3 ff ff       	call   8007b8 <cputchar>
  80147a:	83 c4 10             	add    $0x10,%esp
			i--;
  80147d:	ff 4d f4             	decl   -0xc(%ebp)
  801480:	eb 36                	jmp    8014b8 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801482:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801486:	74 0a                	je     801492 <atomic_readline+0xdb>
  801488:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80148c:	0f 85 60 ff ff ff    	jne    8013f2 <atomic_readline+0x3b>
			if (echoing)
  801492:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801496:	74 0e                	je     8014a6 <atomic_readline+0xef>
				cputchar(c);
  801498:	83 ec 0c             	sub    $0xc,%esp
  80149b:	ff 75 ec             	pushl  -0x14(%ebp)
  80149e:	e8 15 f3 ff ff       	call   8007b8 <cputchar>
  8014a3:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8014a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ac:	01 d0                	add    %edx,%eax
  8014ae:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8014b1:	e8 71 0d 00 00       	call   802227 <sys_enable_interrupt>
			return;
  8014b6:	eb 05                	jmp    8014bd <atomic_readline+0x106>
		}
	}
  8014b8:	e9 35 ff ff ff       	jmp    8013f2 <atomic_readline+0x3b>
}
  8014bd:	c9                   	leave  
  8014be:	c3                   	ret    

008014bf <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8014bf:	55                   	push   %ebp
  8014c0:	89 e5                	mov    %esp,%ebp
  8014c2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8014c5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014cc:	eb 06                	jmp    8014d4 <strlen+0x15>
		n++;
  8014ce:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8014d1:	ff 45 08             	incl   0x8(%ebp)
  8014d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d7:	8a 00                	mov    (%eax),%al
  8014d9:	84 c0                	test   %al,%al
  8014db:	75 f1                	jne    8014ce <strlen+0xf>
		n++;
	return n;
  8014dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8014e0:	c9                   	leave  
  8014e1:	c3                   	ret    

008014e2 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8014e2:	55                   	push   %ebp
  8014e3:	89 e5                	mov    %esp,%ebp
  8014e5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8014e8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014ef:	eb 09                	jmp    8014fa <strnlen+0x18>
		n++;
  8014f1:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8014f4:	ff 45 08             	incl   0x8(%ebp)
  8014f7:	ff 4d 0c             	decl   0xc(%ebp)
  8014fa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014fe:	74 09                	je     801509 <strnlen+0x27>
  801500:	8b 45 08             	mov    0x8(%ebp),%eax
  801503:	8a 00                	mov    (%eax),%al
  801505:	84 c0                	test   %al,%al
  801507:	75 e8                	jne    8014f1 <strnlen+0xf>
		n++;
	return n;
  801509:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80150c:	c9                   	leave  
  80150d:	c3                   	ret    

0080150e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80150e:	55                   	push   %ebp
  80150f:	89 e5                	mov    %esp,%ebp
  801511:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801514:	8b 45 08             	mov    0x8(%ebp),%eax
  801517:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80151a:	90                   	nop
  80151b:	8b 45 08             	mov    0x8(%ebp),%eax
  80151e:	8d 50 01             	lea    0x1(%eax),%edx
  801521:	89 55 08             	mov    %edx,0x8(%ebp)
  801524:	8b 55 0c             	mov    0xc(%ebp),%edx
  801527:	8d 4a 01             	lea    0x1(%edx),%ecx
  80152a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80152d:	8a 12                	mov    (%edx),%dl
  80152f:	88 10                	mov    %dl,(%eax)
  801531:	8a 00                	mov    (%eax),%al
  801533:	84 c0                	test   %al,%al
  801535:	75 e4                	jne    80151b <strcpy+0xd>
		/* do nothing */;
	return ret;
  801537:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80153a:	c9                   	leave  
  80153b:	c3                   	ret    

0080153c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80153c:	55                   	push   %ebp
  80153d:	89 e5                	mov    %esp,%ebp
  80153f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801542:	8b 45 08             	mov    0x8(%ebp),%eax
  801545:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801548:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80154f:	eb 1f                	jmp    801570 <strncpy+0x34>
		*dst++ = *src;
  801551:	8b 45 08             	mov    0x8(%ebp),%eax
  801554:	8d 50 01             	lea    0x1(%eax),%edx
  801557:	89 55 08             	mov    %edx,0x8(%ebp)
  80155a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80155d:	8a 12                	mov    (%edx),%dl
  80155f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801561:	8b 45 0c             	mov    0xc(%ebp),%eax
  801564:	8a 00                	mov    (%eax),%al
  801566:	84 c0                	test   %al,%al
  801568:	74 03                	je     80156d <strncpy+0x31>
			src++;
  80156a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80156d:	ff 45 fc             	incl   -0x4(%ebp)
  801570:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801573:	3b 45 10             	cmp    0x10(%ebp),%eax
  801576:	72 d9                	jb     801551 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801578:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80157b:	c9                   	leave  
  80157c:	c3                   	ret    

0080157d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80157d:	55                   	push   %ebp
  80157e:	89 e5                	mov    %esp,%ebp
  801580:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801583:	8b 45 08             	mov    0x8(%ebp),%eax
  801586:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801589:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80158d:	74 30                	je     8015bf <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80158f:	eb 16                	jmp    8015a7 <strlcpy+0x2a>
			*dst++ = *src++;
  801591:	8b 45 08             	mov    0x8(%ebp),%eax
  801594:	8d 50 01             	lea    0x1(%eax),%edx
  801597:	89 55 08             	mov    %edx,0x8(%ebp)
  80159a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80159d:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015a0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8015a3:	8a 12                	mov    (%edx),%dl
  8015a5:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8015a7:	ff 4d 10             	decl   0x10(%ebp)
  8015aa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015ae:	74 09                	je     8015b9 <strlcpy+0x3c>
  8015b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b3:	8a 00                	mov    (%eax),%al
  8015b5:	84 c0                	test   %al,%al
  8015b7:	75 d8                	jne    801591 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8015b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bc:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8015bf:	8b 55 08             	mov    0x8(%ebp),%edx
  8015c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015c5:	29 c2                	sub    %eax,%edx
  8015c7:	89 d0                	mov    %edx,%eax
}
  8015c9:	c9                   	leave  
  8015ca:	c3                   	ret    

008015cb <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8015cb:	55                   	push   %ebp
  8015cc:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8015ce:	eb 06                	jmp    8015d6 <strcmp+0xb>
		p++, q++;
  8015d0:	ff 45 08             	incl   0x8(%ebp)
  8015d3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8015d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d9:	8a 00                	mov    (%eax),%al
  8015db:	84 c0                	test   %al,%al
  8015dd:	74 0e                	je     8015ed <strcmp+0x22>
  8015df:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e2:	8a 10                	mov    (%eax),%dl
  8015e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e7:	8a 00                	mov    (%eax),%al
  8015e9:	38 c2                	cmp    %al,%dl
  8015eb:	74 e3                	je     8015d0 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8015ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f0:	8a 00                	mov    (%eax),%al
  8015f2:	0f b6 d0             	movzbl %al,%edx
  8015f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015f8:	8a 00                	mov    (%eax),%al
  8015fa:	0f b6 c0             	movzbl %al,%eax
  8015fd:	29 c2                	sub    %eax,%edx
  8015ff:	89 d0                	mov    %edx,%eax
}
  801601:	5d                   	pop    %ebp
  801602:	c3                   	ret    

00801603 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801603:	55                   	push   %ebp
  801604:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801606:	eb 09                	jmp    801611 <strncmp+0xe>
		n--, p++, q++;
  801608:	ff 4d 10             	decl   0x10(%ebp)
  80160b:	ff 45 08             	incl   0x8(%ebp)
  80160e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801611:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801615:	74 17                	je     80162e <strncmp+0x2b>
  801617:	8b 45 08             	mov    0x8(%ebp),%eax
  80161a:	8a 00                	mov    (%eax),%al
  80161c:	84 c0                	test   %al,%al
  80161e:	74 0e                	je     80162e <strncmp+0x2b>
  801620:	8b 45 08             	mov    0x8(%ebp),%eax
  801623:	8a 10                	mov    (%eax),%dl
  801625:	8b 45 0c             	mov    0xc(%ebp),%eax
  801628:	8a 00                	mov    (%eax),%al
  80162a:	38 c2                	cmp    %al,%dl
  80162c:	74 da                	je     801608 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80162e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801632:	75 07                	jne    80163b <strncmp+0x38>
		return 0;
  801634:	b8 00 00 00 00       	mov    $0x0,%eax
  801639:	eb 14                	jmp    80164f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80163b:	8b 45 08             	mov    0x8(%ebp),%eax
  80163e:	8a 00                	mov    (%eax),%al
  801640:	0f b6 d0             	movzbl %al,%edx
  801643:	8b 45 0c             	mov    0xc(%ebp),%eax
  801646:	8a 00                	mov    (%eax),%al
  801648:	0f b6 c0             	movzbl %al,%eax
  80164b:	29 c2                	sub    %eax,%edx
  80164d:	89 d0                	mov    %edx,%eax
}
  80164f:	5d                   	pop    %ebp
  801650:	c3                   	ret    

00801651 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801651:	55                   	push   %ebp
  801652:	89 e5                	mov    %esp,%ebp
  801654:	83 ec 04             	sub    $0x4,%esp
  801657:	8b 45 0c             	mov    0xc(%ebp),%eax
  80165a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80165d:	eb 12                	jmp    801671 <strchr+0x20>
		if (*s == c)
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	8a 00                	mov    (%eax),%al
  801664:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801667:	75 05                	jne    80166e <strchr+0x1d>
			return (char *) s;
  801669:	8b 45 08             	mov    0x8(%ebp),%eax
  80166c:	eb 11                	jmp    80167f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80166e:	ff 45 08             	incl   0x8(%ebp)
  801671:	8b 45 08             	mov    0x8(%ebp),%eax
  801674:	8a 00                	mov    (%eax),%al
  801676:	84 c0                	test   %al,%al
  801678:	75 e5                	jne    80165f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80167a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80167f:	c9                   	leave  
  801680:	c3                   	ret    

00801681 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801681:	55                   	push   %ebp
  801682:	89 e5                	mov    %esp,%ebp
  801684:	83 ec 04             	sub    $0x4,%esp
  801687:	8b 45 0c             	mov    0xc(%ebp),%eax
  80168a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80168d:	eb 0d                	jmp    80169c <strfind+0x1b>
		if (*s == c)
  80168f:	8b 45 08             	mov    0x8(%ebp),%eax
  801692:	8a 00                	mov    (%eax),%al
  801694:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801697:	74 0e                	je     8016a7 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801699:	ff 45 08             	incl   0x8(%ebp)
  80169c:	8b 45 08             	mov    0x8(%ebp),%eax
  80169f:	8a 00                	mov    (%eax),%al
  8016a1:	84 c0                	test   %al,%al
  8016a3:	75 ea                	jne    80168f <strfind+0xe>
  8016a5:	eb 01                	jmp    8016a8 <strfind+0x27>
		if (*s == c)
			break;
  8016a7:	90                   	nop
	return (char *) s;
  8016a8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016ab:	c9                   	leave  
  8016ac:	c3                   	ret    

008016ad <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8016ad:	55                   	push   %ebp
  8016ae:	89 e5                	mov    %esp,%ebp
  8016b0:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8016b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8016b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8016bc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8016bf:	eb 0e                	jmp    8016cf <memset+0x22>
		*p++ = c;
  8016c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016c4:	8d 50 01             	lea    0x1(%eax),%edx
  8016c7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8016ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016cd:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8016cf:	ff 4d f8             	decl   -0x8(%ebp)
  8016d2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8016d6:	79 e9                	jns    8016c1 <memset+0x14>
		*p++ = c;

	return v;
  8016d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016db:	c9                   	leave  
  8016dc:	c3                   	ret    

008016dd <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8016dd:	55                   	push   %ebp
  8016de:	89 e5                	mov    %esp,%ebp
  8016e0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8016e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8016e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8016ef:	eb 16                	jmp    801707 <memcpy+0x2a>
		*d++ = *s++;
  8016f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016f4:	8d 50 01             	lea    0x1(%eax),%edx
  8016f7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016fd:	8d 4a 01             	lea    0x1(%edx),%ecx
  801700:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801703:	8a 12                	mov    (%edx),%dl
  801705:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801707:	8b 45 10             	mov    0x10(%ebp),%eax
  80170a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80170d:	89 55 10             	mov    %edx,0x10(%ebp)
  801710:	85 c0                	test   %eax,%eax
  801712:	75 dd                	jne    8016f1 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801714:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801717:	c9                   	leave  
  801718:	c3                   	ret    

00801719 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801719:	55                   	push   %ebp
  80171a:	89 e5                	mov    %esp,%ebp
  80171c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80171f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801722:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801725:	8b 45 08             	mov    0x8(%ebp),%eax
  801728:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80172b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80172e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801731:	73 50                	jae    801783 <memmove+0x6a>
  801733:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801736:	8b 45 10             	mov    0x10(%ebp),%eax
  801739:	01 d0                	add    %edx,%eax
  80173b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80173e:	76 43                	jbe    801783 <memmove+0x6a>
		s += n;
  801740:	8b 45 10             	mov    0x10(%ebp),%eax
  801743:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801746:	8b 45 10             	mov    0x10(%ebp),%eax
  801749:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80174c:	eb 10                	jmp    80175e <memmove+0x45>
			*--d = *--s;
  80174e:	ff 4d f8             	decl   -0x8(%ebp)
  801751:	ff 4d fc             	decl   -0x4(%ebp)
  801754:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801757:	8a 10                	mov    (%eax),%dl
  801759:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80175c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80175e:	8b 45 10             	mov    0x10(%ebp),%eax
  801761:	8d 50 ff             	lea    -0x1(%eax),%edx
  801764:	89 55 10             	mov    %edx,0x10(%ebp)
  801767:	85 c0                	test   %eax,%eax
  801769:	75 e3                	jne    80174e <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80176b:	eb 23                	jmp    801790 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80176d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801770:	8d 50 01             	lea    0x1(%eax),%edx
  801773:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801776:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801779:	8d 4a 01             	lea    0x1(%edx),%ecx
  80177c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80177f:	8a 12                	mov    (%edx),%dl
  801781:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801783:	8b 45 10             	mov    0x10(%ebp),%eax
  801786:	8d 50 ff             	lea    -0x1(%eax),%edx
  801789:	89 55 10             	mov    %edx,0x10(%ebp)
  80178c:	85 c0                	test   %eax,%eax
  80178e:	75 dd                	jne    80176d <memmove+0x54>
			*d++ = *s++;

	return dst;
  801790:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801793:	c9                   	leave  
  801794:	c3                   	ret    

00801795 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801795:	55                   	push   %ebp
  801796:	89 e5                	mov    %esp,%ebp
  801798:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80179b:	8b 45 08             	mov    0x8(%ebp),%eax
  80179e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8017a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a4:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8017a7:	eb 2a                	jmp    8017d3 <memcmp+0x3e>
		if (*s1 != *s2)
  8017a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017ac:	8a 10                	mov    (%eax),%dl
  8017ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017b1:	8a 00                	mov    (%eax),%al
  8017b3:	38 c2                	cmp    %al,%dl
  8017b5:	74 16                	je     8017cd <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8017b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017ba:	8a 00                	mov    (%eax),%al
  8017bc:	0f b6 d0             	movzbl %al,%edx
  8017bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017c2:	8a 00                	mov    (%eax),%al
  8017c4:	0f b6 c0             	movzbl %al,%eax
  8017c7:	29 c2                	sub    %eax,%edx
  8017c9:	89 d0                	mov    %edx,%eax
  8017cb:	eb 18                	jmp    8017e5 <memcmp+0x50>
		s1++, s2++;
  8017cd:	ff 45 fc             	incl   -0x4(%ebp)
  8017d0:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8017d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8017d6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017d9:	89 55 10             	mov    %edx,0x10(%ebp)
  8017dc:	85 c0                	test   %eax,%eax
  8017de:	75 c9                	jne    8017a9 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8017e0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017e5:	c9                   	leave  
  8017e6:	c3                   	ret    

008017e7 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8017e7:	55                   	push   %ebp
  8017e8:	89 e5                	mov    %esp,%ebp
  8017ea:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8017ed:	8b 55 08             	mov    0x8(%ebp),%edx
  8017f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8017f3:	01 d0                	add    %edx,%eax
  8017f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8017f8:	eb 15                	jmp    80180f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8017fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fd:	8a 00                	mov    (%eax),%al
  8017ff:	0f b6 d0             	movzbl %al,%edx
  801802:	8b 45 0c             	mov    0xc(%ebp),%eax
  801805:	0f b6 c0             	movzbl %al,%eax
  801808:	39 c2                	cmp    %eax,%edx
  80180a:	74 0d                	je     801819 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80180c:	ff 45 08             	incl   0x8(%ebp)
  80180f:	8b 45 08             	mov    0x8(%ebp),%eax
  801812:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801815:	72 e3                	jb     8017fa <memfind+0x13>
  801817:	eb 01                	jmp    80181a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801819:	90                   	nop
	return (void *) s;
  80181a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80181d:	c9                   	leave  
  80181e:	c3                   	ret    

0080181f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80181f:	55                   	push   %ebp
  801820:	89 e5                	mov    %esp,%ebp
  801822:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801825:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80182c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801833:	eb 03                	jmp    801838 <strtol+0x19>
		s++;
  801835:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801838:	8b 45 08             	mov    0x8(%ebp),%eax
  80183b:	8a 00                	mov    (%eax),%al
  80183d:	3c 20                	cmp    $0x20,%al
  80183f:	74 f4                	je     801835 <strtol+0x16>
  801841:	8b 45 08             	mov    0x8(%ebp),%eax
  801844:	8a 00                	mov    (%eax),%al
  801846:	3c 09                	cmp    $0x9,%al
  801848:	74 eb                	je     801835 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80184a:	8b 45 08             	mov    0x8(%ebp),%eax
  80184d:	8a 00                	mov    (%eax),%al
  80184f:	3c 2b                	cmp    $0x2b,%al
  801851:	75 05                	jne    801858 <strtol+0x39>
		s++;
  801853:	ff 45 08             	incl   0x8(%ebp)
  801856:	eb 13                	jmp    80186b <strtol+0x4c>
	else if (*s == '-')
  801858:	8b 45 08             	mov    0x8(%ebp),%eax
  80185b:	8a 00                	mov    (%eax),%al
  80185d:	3c 2d                	cmp    $0x2d,%al
  80185f:	75 0a                	jne    80186b <strtol+0x4c>
		s++, neg = 1;
  801861:	ff 45 08             	incl   0x8(%ebp)
  801864:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80186b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80186f:	74 06                	je     801877 <strtol+0x58>
  801871:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801875:	75 20                	jne    801897 <strtol+0x78>
  801877:	8b 45 08             	mov    0x8(%ebp),%eax
  80187a:	8a 00                	mov    (%eax),%al
  80187c:	3c 30                	cmp    $0x30,%al
  80187e:	75 17                	jne    801897 <strtol+0x78>
  801880:	8b 45 08             	mov    0x8(%ebp),%eax
  801883:	40                   	inc    %eax
  801884:	8a 00                	mov    (%eax),%al
  801886:	3c 78                	cmp    $0x78,%al
  801888:	75 0d                	jne    801897 <strtol+0x78>
		s += 2, base = 16;
  80188a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80188e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801895:	eb 28                	jmp    8018bf <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801897:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80189b:	75 15                	jne    8018b2 <strtol+0x93>
  80189d:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a0:	8a 00                	mov    (%eax),%al
  8018a2:	3c 30                	cmp    $0x30,%al
  8018a4:	75 0c                	jne    8018b2 <strtol+0x93>
		s++, base = 8;
  8018a6:	ff 45 08             	incl   0x8(%ebp)
  8018a9:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8018b0:	eb 0d                	jmp    8018bf <strtol+0xa0>
	else if (base == 0)
  8018b2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018b6:	75 07                	jne    8018bf <strtol+0xa0>
		base = 10;
  8018b8:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8018bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c2:	8a 00                	mov    (%eax),%al
  8018c4:	3c 2f                	cmp    $0x2f,%al
  8018c6:	7e 19                	jle    8018e1 <strtol+0xc2>
  8018c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cb:	8a 00                	mov    (%eax),%al
  8018cd:	3c 39                	cmp    $0x39,%al
  8018cf:	7f 10                	jg     8018e1 <strtol+0xc2>
			dig = *s - '0';
  8018d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d4:	8a 00                	mov    (%eax),%al
  8018d6:	0f be c0             	movsbl %al,%eax
  8018d9:	83 e8 30             	sub    $0x30,%eax
  8018dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8018df:	eb 42                	jmp    801923 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8018e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e4:	8a 00                	mov    (%eax),%al
  8018e6:	3c 60                	cmp    $0x60,%al
  8018e8:	7e 19                	jle    801903 <strtol+0xe4>
  8018ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ed:	8a 00                	mov    (%eax),%al
  8018ef:	3c 7a                	cmp    $0x7a,%al
  8018f1:	7f 10                	jg     801903 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8018f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f6:	8a 00                	mov    (%eax),%al
  8018f8:	0f be c0             	movsbl %al,%eax
  8018fb:	83 e8 57             	sub    $0x57,%eax
  8018fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801901:	eb 20                	jmp    801923 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801903:	8b 45 08             	mov    0x8(%ebp),%eax
  801906:	8a 00                	mov    (%eax),%al
  801908:	3c 40                	cmp    $0x40,%al
  80190a:	7e 39                	jle    801945 <strtol+0x126>
  80190c:	8b 45 08             	mov    0x8(%ebp),%eax
  80190f:	8a 00                	mov    (%eax),%al
  801911:	3c 5a                	cmp    $0x5a,%al
  801913:	7f 30                	jg     801945 <strtol+0x126>
			dig = *s - 'A' + 10;
  801915:	8b 45 08             	mov    0x8(%ebp),%eax
  801918:	8a 00                	mov    (%eax),%al
  80191a:	0f be c0             	movsbl %al,%eax
  80191d:	83 e8 37             	sub    $0x37,%eax
  801920:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801923:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801926:	3b 45 10             	cmp    0x10(%ebp),%eax
  801929:	7d 19                	jge    801944 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80192b:	ff 45 08             	incl   0x8(%ebp)
  80192e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801931:	0f af 45 10          	imul   0x10(%ebp),%eax
  801935:	89 c2                	mov    %eax,%edx
  801937:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80193a:	01 d0                	add    %edx,%eax
  80193c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80193f:	e9 7b ff ff ff       	jmp    8018bf <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801944:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801945:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801949:	74 08                	je     801953 <strtol+0x134>
		*endptr = (char *) s;
  80194b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80194e:	8b 55 08             	mov    0x8(%ebp),%edx
  801951:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801953:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801957:	74 07                	je     801960 <strtol+0x141>
  801959:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80195c:	f7 d8                	neg    %eax
  80195e:	eb 03                	jmp    801963 <strtol+0x144>
  801960:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801963:	c9                   	leave  
  801964:	c3                   	ret    

00801965 <ltostr>:

void
ltostr(long value, char *str)
{
  801965:	55                   	push   %ebp
  801966:	89 e5                	mov    %esp,%ebp
  801968:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80196b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801972:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801979:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80197d:	79 13                	jns    801992 <ltostr+0x2d>
	{
		neg = 1;
  80197f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801986:	8b 45 0c             	mov    0xc(%ebp),%eax
  801989:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80198c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80198f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801992:	8b 45 08             	mov    0x8(%ebp),%eax
  801995:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80199a:	99                   	cltd   
  80199b:	f7 f9                	idiv   %ecx
  80199d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8019a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019a3:	8d 50 01             	lea    0x1(%eax),%edx
  8019a6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8019a9:	89 c2                	mov    %eax,%edx
  8019ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019ae:	01 d0                	add    %edx,%eax
  8019b0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8019b3:	83 c2 30             	add    $0x30,%edx
  8019b6:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8019b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019bb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8019c0:	f7 e9                	imul   %ecx
  8019c2:	c1 fa 02             	sar    $0x2,%edx
  8019c5:	89 c8                	mov    %ecx,%eax
  8019c7:	c1 f8 1f             	sar    $0x1f,%eax
  8019ca:	29 c2                	sub    %eax,%edx
  8019cc:	89 d0                	mov    %edx,%eax
  8019ce:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8019d1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019d4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8019d9:	f7 e9                	imul   %ecx
  8019db:	c1 fa 02             	sar    $0x2,%edx
  8019de:	89 c8                	mov    %ecx,%eax
  8019e0:	c1 f8 1f             	sar    $0x1f,%eax
  8019e3:	29 c2                	sub    %eax,%edx
  8019e5:	89 d0                	mov    %edx,%eax
  8019e7:	c1 e0 02             	shl    $0x2,%eax
  8019ea:	01 d0                	add    %edx,%eax
  8019ec:	01 c0                	add    %eax,%eax
  8019ee:	29 c1                	sub    %eax,%ecx
  8019f0:	89 ca                	mov    %ecx,%edx
  8019f2:	85 d2                	test   %edx,%edx
  8019f4:	75 9c                	jne    801992 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8019f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8019fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a00:	48                   	dec    %eax
  801a01:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801a04:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801a08:	74 3d                	je     801a47 <ltostr+0xe2>
		start = 1 ;
  801a0a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801a11:	eb 34                	jmp    801a47 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801a13:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a16:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a19:	01 d0                	add    %edx,%eax
  801a1b:	8a 00                	mov    (%eax),%al
  801a1d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801a20:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a23:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a26:	01 c2                	add    %eax,%edx
  801a28:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801a2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a2e:	01 c8                	add    %ecx,%eax
  801a30:	8a 00                	mov    (%eax),%al
  801a32:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801a34:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a37:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a3a:	01 c2                	add    %eax,%edx
  801a3c:	8a 45 eb             	mov    -0x15(%ebp),%al
  801a3f:	88 02                	mov    %al,(%edx)
		start++ ;
  801a41:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801a44:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801a47:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a4a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a4d:	7c c4                	jl     801a13 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801a4f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801a52:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a55:	01 d0                	add    %edx,%eax
  801a57:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801a5a:	90                   	nop
  801a5b:	c9                   	leave  
  801a5c:	c3                   	ret    

00801a5d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801a5d:	55                   	push   %ebp
  801a5e:	89 e5                	mov    %esp,%ebp
  801a60:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801a63:	ff 75 08             	pushl  0x8(%ebp)
  801a66:	e8 54 fa ff ff       	call   8014bf <strlen>
  801a6b:	83 c4 04             	add    $0x4,%esp
  801a6e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801a71:	ff 75 0c             	pushl  0xc(%ebp)
  801a74:	e8 46 fa ff ff       	call   8014bf <strlen>
  801a79:	83 c4 04             	add    $0x4,%esp
  801a7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801a7f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801a86:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801a8d:	eb 17                	jmp    801aa6 <strcconcat+0x49>
		final[s] = str1[s] ;
  801a8f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a92:	8b 45 10             	mov    0x10(%ebp),%eax
  801a95:	01 c2                	add    %eax,%edx
  801a97:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9d:	01 c8                	add    %ecx,%eax
  801a9f:	8a 00                	mov    (%eax),%al
  801aa1:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801aa3:	ff 45 fc             	incl   -0x4(%ebp)
  801aa6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801aa9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801aac:	7c e1                	jl     801a8f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801aae:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801ab5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801abc:	eb 1f                	jmp    801add <strcconcat+0x80>
		final[s++] = str2[i] ;
  801abe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ac1:	8d 50 01             	lea    0x1(%eax),%edx
  801ac4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801ac7:	89 c2                	mov    %eax,%edx
  801ac9:	8b 45 10             	mov    0x10(%ebp),%eax
  801acc:	01 c2                	add    %eax,%edx
  801ace:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801ad1:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ad4:	01 c8                	add    %ecx,%eax
  801ad6:	8a 00                	mov    (%eax),%al
  801ad8:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801ada:	ff 45 f8             	incl   -0x8(%ebp)
  801add:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ae0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ae3:	7c d9                	jl     801abe <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801ae5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ae8:	8b 45 10             	mov    0x10(%ebp),%eax
  801aeb:	01 d0                	add    %edx,%eax
  801aed:	c6 00 00             	movb   $0x0,(%eax)
}
  801af0:	90                   	nop
  801af1:	c9                   	leave  
  801af2:	c3                   	ret    

00801af3 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801af3:	55                   	push   %ebp
  801af4:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801af6:	8b 45 14             	mov    0x14(%ebp),%eax
  801af9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801aff:	8b 45 14             	mov    0x14(%ebp),%eax
  801b02:	8b 00                	mov    (%eax),%eax
  801b04:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b0b:	8b 45 10             	mov    0x10(%ebp),%eax
  801b0e:	01 d0                	add    %edx,%eax
  801b10:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801b16:	eb 0c                	jmp    801b24 <strsplit+0x31>
			*string++ = 0;
  801b18:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1b:	8d 50 01             	lea    0x1(%eax),%edx
  801b1e:	89 55 08             	mov    %edx,0x8(%ebp)
  801b21:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801b24:	8b 45 08             	mov    0x8(%ebp),%eax
  801b27:	8a 00                	mov    (%eax),%al
  801b29:	84 c0                	test   %al,%al
  801b2b:	74 18                	je     801b45 <strsplit+0x52>
  801b2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b30:	8a 00                	mov    (%eax),%al
  801b32:	0f be c0             	movsbl %al,%eax
  801b35:	50                   	push   %eax
  801b36:	ff 75 0c             	pushl  0xc(%ebp)
  801b39:	e8 13 fb ff ff       	call   801651 <strchr>
  801b3e:	83 c4 08             	add    $0x8,%esp
  801b41:	85 c0                	test   %eax,%eax
  801b43:	75 d3                	jne    801b18 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801b45:	8b 45 08             	mov    0x8(%ebp),%eax
  801b48:	8a 00                	mov    (%eax),%al
  801b4a:	84 c0                	test   %al,%al
  801b4c:	74 5a                	je     801ba8 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801b4e:	8b 45 14             	mov    0x14(%ebp),%eax
  801b51:	8b 00                	mov    (%eax),%eax
  801b53:	83 f8 0f             	cmp    $0xf,%eax
  801b56:	75 07                	jne    801b5f <strsplit+0x6c>
		{
			return 0;
  801b58:	b8 00 00 00 00       	mov    $0x0,%eax
  801b5d:	eb 66                	jmp    801bc5 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801b5f:	8b 45 14             	mov    0x14(%ebp),%eax
  801b62:	8b 00                	mov    (%eax),%eax
  801b64:	8d 48 01             	lea    0x1(%eax),%ecx
  801b67:	8b 55 14             	mov    0x14(%ebp),%edx
  801b6a:	89 0a                	mov    %ecx,(%edx)
  801b6c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b73:	8b 45 10             	mov    0x10(%ebp),%eax
  801b76:	01 c2                	add    %eax,%edx
  801b78:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b7d:	eb 03                	jmp    801b82 <strsplit+0x8f>
			string++;
  801b7f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b82:	8b 45 08             	mov    0x8(%ebp),%eax
  801b85:	8a 00                	mov    (%eax),%al
  801b87:	84 c0                	test   %al,%al
  801b89:	74 8b                	je     801b16 <strsplit+0x23>
  801b8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8e:	8a 00                	mov    (%eax),%al
  801b90:	0f be c0             	movsbl %al,%eax
  801b93:	50                   	push   %eax
  801b94:	ff 75 0c             	pushl  0xc(%ebp)
  801b97:	e8 b5 fa ff ff       	call   801651 <strchr>
  801b9c:	83 c4 08             	add    $0x8,%esp
  801b9f:	85 c0                	test   %eax,%eax
  801ba1:	74 dc                	je     801b7f <strsplit+0x8c>
			string++;
	}
  801ba3:	e9 6e ff ff ff       	jmp    801b16 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801ba8:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801ba9:	8b 45 14             	mov    0x14(%ebp),%eax
  801bac:	8b 00                	mov    (%eax),%eax
  801bae:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801bb5:	8b 45 10             	mov    0x10(%ebp),%eax
  801bb8:	01 d0                	add    %edx,%eax
  801bba:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801bc0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801bc5:	c9                   	leave  
  801bc6:	c3                   	ret    

00801bc7 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801bc7:	55                   	push   %ebp
  801bc8:	89 e5                	mov    %esp,%ebp
  801bca:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  801bcd:	e8 3b 09 00 00       	call   80250d <sys_isUHeapPlacementStrategyFIRSTFIT>
  801bd2:	85 c0                	test   %eax,%eax
  801bd4:	0f 84 3a 01 00 00    	je     801d14 <malloc+0x14d>

		if(pl == 0){
  801bda:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801bdf:	85 c0                	test   %eax,%eax
  801be1:	75 24                	jne    801c07 <malloc+0x40>
			for(int k = 0; k < Size; k++){
  801be3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801bea:	eb 11                	jmp    801bfd <malloc+0x36>
				arr[k] = -10000;
  801bec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bef:	c7 04 85 20 41 80 00 	movl   $0xffffd8f0,0x804120(,%eax,4)
  801bf6:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801bfa:	ff 45 f4             	incl   -0xc(%ebp)
  801bfd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c00:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801c05:	76 e5                	jbe    801bec <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801c07:	c7 05 2c 40 80 00 01 	movl   $0x1,0x80402c
  801c0e:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801c11:	8b 45 08             	mov    0x8(%ebp),%eax
  801c14:	c1 e8 0c             	shr    $0xc,%eax
  801c17:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  801c1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1d:	25 ff 0f 00 00       	and    $0xfff,%eax
  801c22:	85 c0                	test   %eax,%eax
  801c24:	74 03                	je     801c29 <malloc+0x62>
			x++;
  801c26:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  801c29:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  801c30:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801c37:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801c3e:	eb 66                	jmp    801ca6 <malloc+0xdf>
			if( arr[k] == -10000){
  801c40:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801c43:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801c4a:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801c4f:	75 52                	jne    801ca3 <malloc+0xdc>
				uint32 w = 0 ;
  801c51:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  801c58:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801c5b:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  801c5e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801c61:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801c64:	eb 09                	jmp    801c6f <malloc+0xa8>
  801c66:	ff 45 e0             	incl   -0x20(%ebp)
  801c69:	ff 45 dc             	incl   -0x24(%ebp)
  801c6c:	ff 45 e4             	incl   -0x1c(%ebp)
  801c6f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801c72:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801c77:	77 19                	ja     801c92 <malloc+0xcb>
  801c79:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801c7c:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801c83:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801c88:	75 08                	jne    801c92 <malloc+0xcb>
  801c8a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c8d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c90:	72 d4                	jb     801c66 <malloc+0x9f>
				if(w >= x){
  801c92:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c95:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c98:	72 09                	jb     801ca3 <malloc+0xdc>
					p = 1 ;
  801c9a:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  801ca1:	eb 0d                	jmp    801cb0 <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801ca3:	ff 45 e4             	incl   -0x1c(%ebp)
  801ca6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ca9:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801cae:	76 90                	jbe    801c40 <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  801cb0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801cb4:	75 0a                	jne    801cc0 <malloc+0xf9>
  801cb6:	b8 00 00 00 00       	mov    $0x0,%eax
  801cbb:	e9 ca 01 00 00       	jmp    801e8a <malloc+0x2c3>
		int q = idx;
  801cc0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801cc3:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  801cc6:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801ccd:	eb 16                	jmp    801ce5 <malloc+0x11e>
			arr[q++] = x;
  801ccf:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801cd2:	8d 50 01             	lea    0x1(%eax),%edx
  801cd5:	89 55 d8             	mov    %edx,-0x28(%ebp)
  801cd8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801cdb:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  801ce2:	ff 45 d4             	incl   -0x2c(%ebp)
  801ce5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801ce8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ceb:	72 e2                	jb     801ccf <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801ced:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801cf0:	05 00 00 08 00       	add    $0x80000,%eax
  801cf5:	c1 e0 0c             	shl    $0xc,%eax
  801cf8:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  801cfb:	83 ec 08             	sub    $0x8,%esp
  801cfe:	ff 75 f0             	pushl  -0x10(%ebp)
  801d01:	ff 75 ac             	pushl  -0x54(%ebp)
  801d04:	e8 9b 04 00 00       	call   8021a4 <sys_allocateMem>
  801d09:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801d0c:	8b 45 ac             	mov    -0x54(%ebp),%eax
  801d0f:	e9 76 01 00 00       	jmp    801e8a <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  801d14:	e8 25 08 00 00       	call   80253e <sys_isUHeapPlacementStrategyBESTFIT>
  801d19:	85 c0                	test   %eax,%eax
  801d1b:	0f 84 64 01 00 00    	je     801e85 <malloc+0x2be>
		if(pl == 0){
  801d21:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801d26:	85 c0                	test   %eax,%eax
  801d28:	75 24                	jne    801d4e <malloc+0x187>
			for(int k = 0; k < Size; k++){
  801d2a:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  801d31:	eb 11                	jmp    801d44 <malloc+0x17d>
				arr[k] = -10000;
  801d33:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801d36:	c7 04 85 20 41 80 00 	movl   $0xffffd8f0,0x804120(,%eax,4)
  801d3d:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801d41:	ff 45 d0             	incl   -0x30(%ebp)
  801d44:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801d47:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801d4c:	76 e5                	jbe    801d33 <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801d4e:	c7 05 2c 40 80 00 01 	movl   $0x1,0x80402c
  801d55:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801d58:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5b:	c1 e8 0c             	shr    $0xc,%eax
  801d5e:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  801d61:	8b 45 08             	mov    0x8(%ebp),%eax
  801d64:	25 ff 0f 00 00       	and    $0xfff,%eax
  801d69:	85 c0                	test   %eax,%eax
  801d6b:	74 03                	je     801d70 <malloc+0x1a9>
			x++;
  801d6d:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  801d70:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  801d77:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  801d7e:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  801d85:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  801d8c:	e9 88 00 00 00       	jmp    801e19 <malloc+0x252>
			if(arr[k] == -10000){
  801d91:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801d94:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801d9b:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801da0:	75 64                	jne    801e06 <malloc+0x23f>
				uint32 w = 0 , i;
  801da2:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  801da9:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801dac:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  801daf:	eb 06                	jmp    801db7 <malloc+0x1f0>
  801db1:	ff 45 b8             	incl   -0x48(%ebp)
  801db4:	ff 45 b4             	incl   -0x4c(%ebp)
  801db7:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  801dbe:	77 11                	ja     801dd1 <malloc+0x20a>
  801dc0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801dc3:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801dca:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801dcf:	74 e0                	je     801db1 <malloc+0x1ea>
				if(w <q && w >= x){
  801dd1:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801dd4:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  801dd7:	73 24                	jae    801dfd <malloc+0x236>
  801dd9:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801ddc:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801ddf:	72 1c                	jb     801dfd <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  801de1:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801de4:	89 45 c8             	mov    %eax,-0x38(%ebp)
  801de7:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  801dee:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801df1:	89 45 c0             	mov    %eax,-0x40(%ebp)
  801df4:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801df7:	48                   	dec    %eax
  801df8:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801dfb:	eb 19                	jmp    801e16 <malloc+0x24f>
				}
				else {
					k = i - 1;
  801dfd:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801e00:	48                   	dec    %eax
  801e01:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801e04:	eb 10                	jmp    801e16 <malloc+0x24f>
				}
			} else {
				k += arr[k];
  801e06:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801e09:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801e10:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  801e13:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  801e16:	ff 45 bc             	incl   -0x44(%ebp)
  801e19:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801e1c:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801e21:	0f 86 6a ff ff ff    	jbe    801d91 <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  801e27:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  801e2b:	75 07                	jne    801e34 <malloc+0x26d>
  801e2d:	b8 00 00 00 00       	mov    $0x0,%eax
  801e32:	eb 56                	jmp    801e8a <malloc+0x2c3>
	    q = idx;
  801e34:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801e37:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  801e3a:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  801e41:	eb 16                	jmp    801e59 <malloc+0x292>
			arr[q++] = x;
  801e43:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801e46:	8d 50 01             	lea    0x1(%eax),%edx
  801e49:	89 55 c8             	mov    %edx,-0x38(%ebp)
  801e4c:	8b 55 cc             	mov    -0x34(%ebp),%edx
  801e4f:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  801e56:	ff 45 b0             	incl   -0x50(%ebp)
  801e59:	8b 45 b0             	mov    -0x50(%ebp),%eax
  801e5c:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801e5f:	72 e2                	jb     801e43 <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801e61:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801e64:	05 00 00 08 00       	add    $0x80000,%eax
  801e69:	c1 e0 0c             	shl    $0xc,%eax
  801e6c:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  801e6f:	83 ec 08             	sub    $0x8,%esp
  801e72:	ff 75 cc             	pushl  -0x34(%ebp)
  801e75:	ff 75 a8             	pushl  -0x58(%ebp)
  801e78:	e8 27 03 00 00       	call   8021a4 <sys_allocateMem>
  801e7d:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801e80:	8b 45 a8             	mov    -0x58(%ebp),%eax
  801e83:	eb 05                	jmp    801e8a <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  801e85:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e8a:	c9                   	leave  
  801e8b:	c3                   	ret    

00801e8c <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801e8c:	55                   	push   %ebp
  801e8d:	89 e5                	mov    %esp,%ebp
  801e8f:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  801e92:	8b 45 08             	mov    0x8(%ebp),%eax
  801e95:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801e98:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e9b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801ea0:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  801ea3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea6:	05 00 00 00 80       	add    $0x80000000,%eax
  801eab:	c1 e8 0c             	shr    $0xc,%eax
  801eae:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801eb5:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801eb8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801ebf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec2:	05 00 00 00 80       	add    $0x80000000,%eax
  801ec7:	c1 e8 0c             	shr    $0xc,%eax
  801eca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801ecd:	eb 14                	jmp    801ee3 <free+0x57>
		arr[j] = -10000;
  801ecf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ed2:	c7 04 85 20 41 80 00 	movl   $0xffffd8f0,0x804120(,%eax,4)
  801ed9:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801edd:	ff 45 f4             	incl   -0xc(%ebp)
  801ee0:	ff 45 f0             	incl   -0x10(%ebp)
  801ee3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ee6:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801ee9:	72 e4                	jb     801ecf <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  801eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  801eee:	83 ec 08             	sub    $0x8,%esp
  801ef1:	ff 75 e8             	pushl  -0x18(%ebp)
  801ef4:	50                   	push   %eax
  801ef5:	e8 8e 02 00 00       	call   802188 <sys_freeMem>
  801efa:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  801efd:	90                   	nop
  801efe:	c9                   	leave  
  801eff:	c3                   	ret    

00801f00 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801f00:	55                   	push   %ebp
  801f01:	89 e5                	mov    %esp,%ebp
  801f03:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f06:	83 ec 04             	sub    $0x4,%esp
  801f09:	68 a4 30 80 00       	push   $0x8030a4
  801f0e:	68 9e 00 00 00       	push   $0x9e
  801f13:	68 c7 30 80 00       	push   $0x8030c7
  801f18:	e8 63 ea ff ff       	call   800980 <_panic>

00801f1d <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801f1d:	55                   	push   %ebp
  801f1e:	89 e5                	mov    %esp,%ebp
  801f20:	83 ec 18             	sub    $0x18,%esp
  801f23:	8b 45 10             	mov    0x10(%ebp),%eax
  801f26:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801f29:	83 ec 04             	sub    $0x4,%esp
  801f2c:	68 a4 30 80 00       	push   $0x8030a4
  801f31:	68 a9 00 00 00       	push   $0xa9
  801f36:	68 c7 30 80 00       	push   $0x8030c7
  801f3b:	e8 40 ea ff ff       	call   800980 <_panic>

00801f40 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801f40:	55                   	push   %ebp
  801f41:	89 e5                	mov    %esp,%ebp
  801f43:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f46:	83 ec 04             	sub    $0x4,%esp
  801f49:	68 a4 30 80 00       	push   $0x8030a4
  801f4e:	68 af 00 00 00       	push   $0xaf
  801f53:	68 c7 30 80 00       	push   $0x8030c7
  801f58:	e8 23 ea ff ff       	call   800980 <_panic>

00801f5d <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801f5d:	55                   	push   %ebp
  801f5e:	89 e5                	mov    %esp,%ebp
  801f60:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f63:	83 ec 04             	sub    $0x4,%esp
  801f66:	68 a4 30 80 00       	push   $0x8030a4
  801f6b:	68 b5 00 00 00       	push   $0xb5
  801f70:	68 c7 30 80 00       	push   $0x8030c7
  801f75:	e8 06 ea ff ff       	call   800980 <_panic>

00801f7a <expand>:
}

void expand(uint32 newSize)
{
  801f7a:	55                   	push   %ebp
  801f7b:	89 e5                	mov    %esp,%ebp
  801f7d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f80:	83 ec 04             	sub    $0x4,%esp
  801f83:	68 a4 30 80 00       	push   $0x8030a4
  801f88:	68 ba 00 00 00       	push   $0xba
  801f8d:	68 c7 30 80 00       	push   $0x8030c7
  801f92:	e8 e9 e9 ff ff       	call   800980 <_panic>

00801f97 <shrink>:
}
void shrink(uint32 newSize)
{
  801f97:	55                   	push   %ebp
  801f98:	89 e5                	mov    %esp,%ebp
  801f9a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f9d:	83 ec 04             	sub    $0x4,%esp
  801fa0:	68 a4 30 80 00       	push   $0x8030a4
  801fa5:	68 be 00 00 00       	push   $0xbe
  801faa:	68 c7 30 80 00       	push   $0x8030c7
  801faf:	e8 cc e9 ff ff       	call   800980 <_panic>

00801fb4 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801fb4:	55                   	push   %ebp
  801fb5:	89 e5                	mov    %esp,%ebp
  801fb7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801fba:	83 ec 04             	sub    $0x4,%esp
  801fbd:	68 a4 30 80 00       	push   $0x8030a4
  801fc2:	68 c3 00 00 00       	push   $0xc3
  801fc7:	68 c7 30 80 00       	push   $0x8030c7
  801fcc:	e8 af e9 ff ff       	call   800980 <_panic>

00801fd1 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801fd1:	55                   	push   %ebp
  801fd2:	89 e5                	mov    %esp,%ebp
  801fd4:	57                   	push   %edi
  801fd5:	56                   	push   %esi
  801fd6:	53                   	push   %ebx
  801fd7:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801fda:	8b 45 08             	mov    0x8(%ebp),%eax
  801fdd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fe0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801fe3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801fe6:	8b 7d 18             	mov    0x18(%ebp),%edi
  801fe9:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801fec:	cd 30                	int    $0x30
  801fee:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801ff1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ff4:	83 c4 10             	add    $0x10,%esp
  801ff7:	5b                   	pop    %ebx
  801ff8:	5e                   	pop    %esi
  801ff9:	5f                   	pop    %edi
  801ffa:	5d                   	pop    %ebp
  801ffb:	c3                   	ret    

00801ffc <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801ffc:	55                   	push   %ebp
  801ffd:	89 e5                	mov    %esp,%ebp
  801fff:	83 ec 04             	sub    $0x4,%esp
  802002:	8b 45 10             	mov    0x10(%ebp),%eax
  802005:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802008:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80200c:	8b 45 08             	mov    0x8(%ebp),%eax
  80200f:	6a 00                	push   $0x0
  802011:	6a 00                	push   $0x0
  802013:	52                   	push   %edx
  802014:	ff 75 0c             	pushl  0xc(%ebp)
  802017:	50                   	push   %eax
  802018:	6a 00                	push   $0x0
  80201a:	e8 b2 ff ff ff       	call   801fd1 <syscall>
  80201f:	83 c4 18             	add    $0x18,%esp
}
  802022:	90                   	nop
  802023:	c9                   	leave  
  802024:	c3                   	ret    

00802025 <sys_cgetc>:

int
sys_cgetc(void)
{
  802025:	55                   	push   %ebp
  802026:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802028:	6a 00                	push   $0x0
  80202a:	6a 00                	push   $0x0
  80202c:	6a 00                	push   $0x0
  80202e:	6a 00                	push   $0x0
  802030:	6a 00                	push   $0x0
  802032:	6a 01                	push   $0x1
  802034:	e8 98 ff ff ff       	call   801fd1 <syscall>
  802039:	83 c4 18             	add    $0x18,%esp
}
  80203c:	c9                   	leave  
  80203d:	c3                   	ret    

0080203e <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80203e:	55                   	push   %ebp
  80203f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802041:	8b 45 08             	mov    0x8(%ebp),%eax
  802044:	6a 00                	push   $0x0
  802046:	6a 00                	push   $0x0
  802048:	6a 00                	push   $0x0
  80204a:	6a 00                	push   $0x0
  80204c:	50                   	push   %eax
  80204d:	6a 05                	push   $0x5
  80204f:	e8 7d ff ff ff       	call   801fd1 <syscall>
  802054:	83 c4 18             	add    $0x18,%esp
}
  802057:	c9                   	leave  
  802058:	c3                   	ret    

00802059 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802059:	55                   	push   %ebp
  80205a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80205c:	6a 00                	push   $0x0
  80205e:	6a 00                	push   $0x0
  802060:	6a 00                	push   $0x0
  802062:	6a 00                	push   $0x0
  802064:	6a 00                	push   $0x0
  802066:	6a 02                	push   $0x2
  802068:	e8 64 ff ff ff       	call   801fd1 <syscall>
  80206d:	83 c4 18             	add    $0x18,%esp
}
  802070:	c9                   	leave  
  802071:	c3                   	ret    

00802072 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802072:	55                   	push   %ebp
  802073:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802075:	6a 00                	push   $0x0
  802077:	6a 00                	push   $0x0
  802079:	6a 00                	push   $0x0
  80207b:	6a 00                	push   $0x0
  80207d:	6a 00                	push   $0x0
  80207f:	6a 03                	push   $0x3
  802081:	e8 4b ff ff ff       	call   801fd1 <syscall>
  802086:	83 c4 18             	add    $0x18,%esp
}
  802089:	c9                   	leave  
  80208a:	c3                   	ret    

0080208b <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80208b:	55                   	push   %ebp
  80208c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80208e:	6a 00                	push   $0x0
  802090:	6a 00                	push   $0x0
  802092:	6a 00                	push   $0x0
  802094:	6a 00                	push   $0x0
  802096:	6a 00                	push   $0x0
  802098:	6a 04                	push   $0x4
  80209a:	e8 32 ff ff ff       	call   801fd1 <syscall>
  80209f:	83 c4 18             	add    $0x18,%esp
}
  8020a2:	c9                   	leave  
  8020a3:	c3                   	ret    

008020a4 <sys_env_exit>:


void sys_env_exit(void)
{
  8020a4:	55                   	push   %ebp
  8020a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8020a7:	6a 00                	push   $0x0
  8020a9:	6a 00                	push   $0x0
  8020ab:	6a 00                	push   $0x0
  8020ad:	6a 00                	push   $0x0
  8020af:	6a 00                	push   $0x0
  8020b1:	6a 06                	push   $0x6
  8020b3:	e8 19 ff ff ff       	call   801fd1 <syscall>
  8020b8:	83 c4 18             	add    $0x18,%esp
}
  8020bb:	90                   	nop
  8020bc:	c9                   	leave  
  8020bd:	c3                   	ret    

008020be <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8020be:	55                   	push   %ebp
  8020bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8020c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c7:	6a 00                	push   $0x0
  8020c9:	6a 00                	push   $0x0
  8020cb:	6a 00                	push   $0x0
  8020cd:	52                   	push   %edx
  8020ce:	50                   	push   %eax
  8020cf:	6a 07                	push   $0x7
  8020d1:	e8 fb fe ff ff       	call   801fd1 <syscall>
  8020d6:	83 c4 18             	add    $0x18,%esp
}
  8020d9:	c9                   	leave  
  8020da:	c3                   	ret    

008020db <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8020db:	55                   	push   %ebp
  8020dc:	89 e5                	mov    %esp,%ebp
  8020de:	56                   	push   %esi
  8020df:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8020e0:	8b 75 18             	mov    0x18(%ebp),%esi
  8020e3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8020e6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ef:	56                   	push   %esi
  8020f0:	53                   	push   %ebx
  8020f1:	51                   	push   %ecx
  8020f2:	52                   	push   %edx
  8020f3:	50                   	push   %eax
  8020f4:	6a 08                	push   $0x8
  8020f6:	e8 d6 fe ff ff       	call   801fd1 <syscall>
  8020fb:	83 c4 18             	add    $0x18,%esp
}
  8020fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802101:	5b                   	pop    %ebx
  802102:	5e                   	pop    %esi
  802103:	5d                   	pop    %ebp
  802104:	c3                   	ret    

00802105 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802105:	55                   	push   %ebp
  802106:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802108:	8b 55 0c             	mov    0xc(%ebp),%edx
  80210b:	8b 45 08             	mov    0x8(%ebp),%eax
  80210e:	6a 00                	push   $0x0
  802110:	6a 00                	push   $0x0
  802112:	6a 00                	push   $0x0
  802114:	52                   	push   %edx
  802115:	50                   	push   %eax
  802116:	6a 09                	push   $0x9
  802118:	e8 b4 fe ff ff       	call   801fd1 <syscall>
  80211d:	83 c4 18             	add    $0x18,%esp
}
  802120:	c9                   	leave  
  802121:	c3                   	ret    

00802122 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802122:	55                   	push   %ebp
  802123:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802125:	6a 00                	push   $0x0
  802127:	6a 00                	push   $0x0
  802129:	6a 00                	push   $0x0
  80212b:	ff 75 0c             	pushl  0xc(%ebp)
  80212e:	ff 75 08             	pushl  0x8(%ebp)
  802131:	6a 0a                	push   $0xa
  802133:	e8 99 fe ff ff       	call   801fd1 <syscall>
  802138:	83 c4 18             	add    $0x18,%esp
}
  80213b:	c9                   	leave  
  80213c:	c3                   	ret    

0080213d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80213d:	55                   	push   %ebp
  80213e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802140:	6a 00                	push   $0x0
  802142:	6a 00                	push   $0x0
  802144:	6a 00                	push   $0x0
  802146:	6a 00                	push   $0x0
  802148:	6a 00                	push   $0x0
  80214a:	6a 0b                	push   $0xb
  80214c:	e8 80 fe ff ff       	call   801fd1 <syscall>
  802151:	83 c4 18             	add    $0x18,%esp
}
  802154:	c9                   	leave  
  802155:	c3                   	ret    

00802156 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802156:	55                   	push   %ebp
  802157:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802159:	6a 00                	push   $0x0
  80215b:	6a 00                	push   $0x0
  80215d:	6a 00                	push   $0x0
  80215f:	6a 00                	push   $0x0
  802161:	6a 00                	push   $0x0
  802163:	6a 0c                	push   $0xc
  802165:	e8 67 fe ff ff       	call   801fd1 <syscall>
  80216a:	83 c4 18             	add    $0x18,%esp
}
  80216d:	c9                   	leave  
  80216e:	c3                   	ret    

0080216f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80216f:	55                   	push   %ebp
  802170:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802172:	6a 00                	push   $0x0
  802174:	6a 00                	push   $0x0
  802176:	6a 00                	push   $0x0
  802178:	6a 00                	push   $0x0
  80217a:	6a 00                	push   $0x0
  80217c:	6a 0d                	push   $0xd
  80217e:	e8 4e fe ff ff       	call   801fd1 <syscall>
  802183:	83 c4 18             	add    $0x18,%esp
}
  802186:	c9                   	leave  
  802187:	c3                   	ret    

00802188 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802188:	55                   	push   %ebp
  802189:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80218b:	6a 00                	push   $0x0
  80218d:	6a 00                	push   $0x0
  80218f:	6a 00                	push   $0x0
  802191:	ff 75 0c             	pushl  0xc(%ebp)
  802194:	ff 75 08             	pushl  0x8(%ebp)
  802197:	6a 11                	push   $0x11
  802199:	e8 33 fe ff ff       	call   801fd1 <syscall>
  80219e:	83 c4 18             	add    $0x18,%esp
	return;
  8021a1:	90                   	nop
}
  8021a2:	c9                   	leave  
  8021a3:	c3                   	ret    

008021a4 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8021a4:	55                   	push   %ebp
  8021a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8021a7:	6a 00                	push   $0x0
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	ff 75 0c             	pushl  0xc(%ebp)
  8021b0:	ff 75 08             	pushl  0x8(%ebp)
  8021b3:	6a 12                	push   $0x12
  8021b5:	e8 17 fe ff ff       	call   801fd1 <syscall>
  8021ba:	83 c4 18             	add    $0x18,%esp
	return ;
  8021bd:	90                   	nop
}
  8021be:	c9                   	leave  
  8021bf:	c3                   	ret    

008021c0 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8021c0:	55                   	push   %ebp
  8021c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8021c3:	6a 00                	push   $0x0
  8021c5:	6a 00                	push   $0x0
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 00                	push   $0x0
  8021cb:	6a 00                	push   $0x0
  8021cd:	6a 0e                	push   $0xe
  8021cf:	e8 fd fd ff ff       	call   801fd1 <syscall>
  8021d4:	83 c4 18             	add    $0x18,%esp
}
  8021d7:	c9                   	leave  
  8021d8:	c3                   	ret    

008021d9 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8021d9:	55                   	push   %ebp
  8021da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8021dc:	6a 00                	push   $0x0
  8021de:	6a 00                	push   $0x0
  8021e0:	6a 00                	push   $0x0
  8021e2:	6a 00                	push   $0x0
  8021e4:	ff 75 08             	pushl  0x8(%ebp)
  8021e7:	6a 0f                	push   $0xf
  8021e9:	e8 e3 fd ff ff       	call   801fd1 <syscall>
  8021ee:	83 c4 18             	add    $0x18,%esp
}
  8021f1:	c9                   	leave  
  8021f2:	c3                   	ret    

008021f3 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8021f3:	55                   	push   %ebp
  8021f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8021f6:	6a 00                	push   $0x0
  8021f8:	6a 00                	push   $0x0
  8021fa:	6a 00                	push   $0x0
  8021fc:	6a 00                	push   $0x0
  8021fe:	6a 00                	push   $0x0
  802200:	6a 10                	push   $0x10
  802202:	e8 ca fd ff ff       	call   801fd1 <syscall>
  802207:	83 c4 18             	add    $0x18,%esp
}
  80220a:	90                   	nop
  80220b:	c9                   	leave  
  80220c:	c3                   	ret    

0080220d <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80220d:	55                   	push   %ebp
  80220e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802210:	6a 00                	push   $0x0
  802212:	6a 00                	push   $0x0
  802214:	6a 00                	push   $0x0
  802216:	6a 00                	push   $0x0
  802218:	6a 00                	push   $0x0
  80221a:	6a 14                	push   $0x14
  80221c:	e8 b0 fd ff ff       	call   801fd1 <syscall>
  802221:	83 c4 18             	add    $0x18,%esp
}
  802224:	90                   	nop
  802225:	c9                   	leave  
  802226:	c3                   	ret    

00802227 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802227:	55                   	push   %ebp
  802228:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80222a:	6a 00                	push   $0x0
  80222c:	6a 00                	push   $0x0
  80222e:	6a 00                	push   $0x0
  802230:	6a 00                	push   $0x0
  802232:	6a 00                	push   $0x0
  802234:	6a 15                	push   $0x15
  802236:	e8 96 fd ff ff       	call   801fd1 <syscall>
  80223b:	83 c4 18             	add    $0x18,%esp
}
  80223e:	90                   	nop
  80223f:	c9                   	leave  
  802240:	c3                   	ret    

00802241 <sys_cputc>:


void
sys_cputc(const char c)
{
  802241:	55                   	push   %ebp
  802242:	89 e5                	mov    %esp,%ebp
  802244:	83 ec 04             	sub    $0x4,%esp
  802247:	8b 45 08             	mov    0x8(%ebp),%eax
  80224a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80224d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802251:	6a 00                	push   $0x0
  802253:	6a 00                	push   $0x0
  802255:	6a 00                	push   $0x0
  802257:	6a 00                	push   $0x0
  802259:	50                   	push   %eax
  80225a:	6a 16                	push   $0x16
  80225c:	e8 70 fd ff ff       	call   801fd1 <syscall>
  802261:	83 c4 18             	add    $0x18,%esp
}
  802264:	90                   	nop
  802265:	c9                   	leave  
  802266:	c3                   	ret    

00802267 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802267:	55                   	push   %ebp
  802268:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80226a:	6a 00                	push   $0x0
  80226c:	6a 00                	push   $0x0
  80226e:	6a 00                	push   $0x0
  802270:	6a 00                	push   $0x0
  802272:	6a 00                	push   $0x0
  802274:	6a 17                	push   $0x17
  802276:	e8 56 fd ff ff       	call   801fd1 <syscall>
  80227b:	83 c4 18             	add    $0x18,%esp
}
  80227e:	90                   	nop
  80227f:	c9                   	leave  
  802280:	c3                   	ret    

00802281 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802281:	55                   	push   %ebp
  802282:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802284:	8b 45 08             	mov    0x8(%ebp),%eax
  802287:	6a 00                	push   $0x0
  802289:	6a 00                	push   $0x0
  80228b:	6a 00                	push   $0x0
  80228d:	ff 75 0c             	pushl  0xc(%ebp)
  802290:	50                   	push   %eax
  802291:	6a 18                	push   $0x18
  802293:	e8 39 fd ff ff       	call   801fd1 <syscall>
  802298:	83 c4 18             	add    $0x18,%esp
}
  80229b:	c9                   	leave  
  80229c:	c3                   	ret    

0080229d <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80229d:	55                   	push   %ebp
  80229e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8022a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8022a6:	6a 00                	push   $0x0
  8022a8:	6a 00                	push   $0x0
  8022aa:	6a 00                	push   $0x0
  8022ac:	52                   	push   %edx
  8022ad:	50                   	push   %eax
  8022ae:	6a 1b                	push   $0x1b
  8022b0:	e8 1c fd ff ff       	call   801fd1 <syscall>
  8022b5:	83 c4 18             	add    $0x18,%esp
}
  8022b8:	c9                   	leave  
  8022b9:	c3                   	ret    

008022ba <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8022ba:	55                   	push   %ebp
  8022bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8022bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8022c3:	6a 00                	push   $0x0
  8022c5:	6a 00                	push   $0x0
  8022c7:	6a 00                	push   $0x0
  8022c9:	52                   	push   %edx
  8022ca:	50                   	push   %eax
  8022cb:	6a 19                	push   $0x19
  8022cd:	e8 ff fc ff ff       	call   801fd1 <syscall>
  8022d2:	83 c4 18             	add    $0x18,%esp
}
  8022d5:	90                   	nop
  8022d6:	c9                   	leave  
  8022d7:	c3                   	ret    

008022d8 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8022d8:	55                   	push   %ebp
  8022d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8022db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022de:	8b 45 08             	mov    0x8(%ebp),%eax
  8022e1:	6a 00                	push   $0x0
  8022e3:	6a 00                	push   $0x0
  8022e5:	6a 00                	push   $0x0
  8022e7:	52                   	push   %edx
  8022e8:	50                   	push   %eax
  8022e9:	6a 1a                	push   $0x1a
  8022eb:	e8 e1 fc ff ff       	call   801fd1 <syscall>
  8022f0:	83 c4 18             	add    $0x18,%esp
}
  8022f3:	90                   	nop
  8022f4:	c9                   	leave  
  8022f5:	c3                   	ret    

008022f6 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8022f6:	55                   	push   %ebp
  8022f7:	89 e5                	mov    %esp,%ebp
  8022f9:	83 ec 04             	sub    $0x4,%esp
  8022fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8022ff:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802302:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802305:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802309:	8b 45 08             	mov    0x8(%ebp),%eax
  80230c:	6a 00                	push   $0x0
  80230e:	51                   	push   %ecx
  80230f:	52                   	push   %edx
  802310:	ff 75 0c             	pushl  0xc(%ebp)
  802313:	50                   	push   %eax
  802314:	6a 1c                	push   $0x1c
  802316:	e8 b6 fc ff ff       	call   801fd1 <syscall>
  80231b:	83 c4 18             	add    $0x18,%esp
}
  80231e:	c9                   	leave  
  80231f:	c3                   	ret    

00802320 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802320:	55                   	push   %ebp
  802321:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802323:	8b 55 0c             	mov    0xc(%ebp),%edx
  802326:	8b 45 08             	mov    0x8(%ebp),%eax
  802329:	6a 00                	push   $0x0
  80232b:	6a 00                	push   $0x0
  80232d:	6a 00                	push   $0x0
  80232f:	52                   	push   %edx
  802330:	50                   	push   %eax
  802331:	6a 1d                	push   $0x1d
  802333:	e8 99 fc ff ff       	call   801fd1 <syscall>
  802338:	83 c4 18             	add    $0x18,%esp
}
  80233b:	c9                   	leave  
  80233c:	c3                   	ret    

0080233d <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80233d:	55                   	push   %ebp
  80233e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802340:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802343:	8b 55 0c             	mov    0xc(%ebp),%edx
  802346:	8b 45 08             	mov    0x8(%ebp),%eax
  802349:	6a 00                	push   $0x0
  80234b:	6a 00                	push   $0x0
  80234d:	51                   	push   %ecx
  80234e:	52                   	push   %edx
  80234f:	50                   	push   %eax
  802350:	6a 1e                	push   $0x1e
  802352:	e8 7a fc ff ff       	call   801fd1 <syscall>
  802357:	83 c4 18             	add    $0x18,%esp
}
  80235a:	c9                   	leave  
  80235b:	c3                   	ret    

0080235c <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80235c:	55                   	push   %ebp
  80235d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80235f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802362:	8b 45 08             	mov    0x8(%ebp),%eax
  802365:	6a 00                	push   $0x0
  802367:	6a 00                	push   $0x0
  802369:	6a 00                	push   $0x0
  80236b:	52                   	push   %edx
  80236c:	50                   	push   %eax
  80236d:	6a 1f                	push   $0x1f
  80236f:	e8 5d fc ff ff       	call   801fd1 <syscall>
  802374:	83 c4 18             	add    $0x18,%esp
}
  802377:	c9                   	leave  
  802378:	c3                   	ret    

00802379 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802379:	55                   	push   %ebp
  80237a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80237c:	6a 00                	push   $0x0
  80237e:	6a 00                	push   $0x0
  802380:	6a 00                	push   $0x0
  802382:	6a 00                	push   $0x0
  802384:	6a 00                	push   $0x0
  802386:	6a 20                	push   $0x20
  802388:	e8 44 fc ff ff       	call   801fd1 <syscall>
  80238d:	83 c4 18             	add    $0x18,%esp
}
  802390:	c9                   	leave  
  802391:	c3                   	ret    

00802392 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802392:	55                   	push   %ebp
  802393:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802395:	8b 45 08             	mov    0x8(%ebp),%eax
  802398:	6a 00                	push   $0x0
  80239a:	ff 75 14             	pushl  0x14(%ebp)
  80239d:	ff 75 10             	pushl  0x10(%ebp)
  8023a0:	ff 75 0c             	pushl  0xc(%ebp)
  8023a3:	50                   	push   %eax
  8023a4:	6a 21                	push   $0x21
  8023a6:	e8 26 fc ff ff       	call   801fd1 <syscall>
  8023ab:	83 c4 18             	add    $0x18,%esp
}
  8023ae:	c9                   	leave  
  8023af:	c3                   	ret    

008023b0 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8023b0:	55                   	push   %ebp
  8023b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8023b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8023b6:	6a 00                	push   $0x0
  8023b8:	6a 00                	push   $0x0
  8023ba:	6a 00                	push   $0x0
  8023bc:	6a 00                	push   $0x0
  8023be:	50                   	push   %eax
  8023bf:	6a 22                	push   $0x22
  8023c1:	e8 0b fc ff ff       	call   801fd1 <syscall>
  8023c6:	83 c4 18             	add    $0x18,%esp
}
  8023c9:	90                   	nop
  8023ca:	c9                   	leave  
  8023cb:	c3                   	ret    

008023cc <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8023cc:	55                   	push   %ebp
  8023cd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8023cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8023d2:	6a 00                	push   $0x0
  8023d4:	6a 00                	push   $0x0
  8023d6:	6a 00                	push   $0x0
  8023d8:	6a 00                	push   $0x0
  8023da:	50                   	push   %eax
  8023db:	6a 23                	push   $0x23
  8023dd:	e8 ef fb ff ff       	call   801fd1 <syscall>
  8023e2:	83 c4 18             	add    $0x18,%esp
}
  8023e5:	90                   	nop
  8023e6:	c9                   	leave  
  8023e7:	c3                   	ret    

008023e8 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8023e8:	55                   	push   %ebp
  8023e9:	89 e5                	mov    %esp,%ebp
  8023eb:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8023ee:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8023f1:	8d 50 04             	lea    0x4(%eax),%edx
  8023f4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8023f7:	6a 00                	push   $0x0
  8023f9:	6a 00                	push   $0x0
  8023fb:	6a 00                	push   $0x0
  8023fd:	52                   	push   %edx
  8023fe:	50                   	push   %eax
  8023ff:	6a 24                	push   $0x24
  802401:	e8 cb fb ff ff       	call   801fd1 <syscall>
  802406:	83 c4 18             	add    $0x18,%esp
	return result;
  802409:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80240c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80240f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802412:	89 01                	mov    %eax,(%ecx)
  802414:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802417:	8b 45 08             	mov    0x8(%ebp),%eax
  80241a:	c9                   	leave  
  80241b:	c2 04 00             	ret    $0x4

0080241e <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80241e:	55                   	push   %ebp
  80241f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802421:	6a 00                	push   $0x0
  802423:	6a 00                	push   $0x0
  802425:	ff 75 10             	pushl  0x10(%ebp)
  802428:	ff 75 0c             	pushl  0xc(%ebp)
  80242b:	ff 75 08             	pushl  0x8(%ebp)
  80242e:	6a 13                	push   $0x13
  802430:	e8 9c fb ff ff       	call   801fd1 <syscall>
  802435:	83 c4 18             	add    $0x18,%esp
	return ;
  802438:	90                   	nop
}
  802439:	c9                   	leave  
  80243a:	c3                   	ret    

0080243b <sys_rcr2>:
uint32 sys_rcr2()
{
  80243b:	55                   	push   %ebp
  80243c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80243e:	6a 00                	push   $0x0
  802440:	6a 00                	push   $0x0
  802442:	6a 00                	push   $0x0
  802444:	6a 00                	push   $0x0
  802446:	6a 00                	push   $0x0
  802448:	6a 25                	push   $0x25
  80244a:	e8 82 fb ff ff       	call   801fd1 <syscall>
  80244f:	83 c4 18             	add    $0x18,%esp
}
  802452:	c9                   	leave  
  802453:	c3                   	ret    

00802454 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802454:	55                   	push   %ebp
  802455:	89 e5                	mov    %esp,%ebp
  802457:	83 ec 04             	sub    $0x4,%esp
  80245a:	8b 45 08             	mov    0x8(%ebp),%eax
  80245d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802460:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802464:	6a 00                	push   $0x0
  802466:	6a 00                	push   $0x0
  802468:	6a 00                	push   $0x0
  80246a:	6a 00                	push   $0x0
  80246c:	50                   	push   %eax
  80246d:	6a 26                	push   $0x26
  80246f:	e8 5d fb ff ff       	call   801fd1 <syscall>
  802474:	83 c4 18             	add    $0x18,%esp
	return ;
  802477:	90                   	nop
}
  802478:	c9                   	leave  
  802479:	c3                   	ret    

0080247a <rsttst>:
void rsttst()
{
  80247a:	55                   	push   %ebp
  80247b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80247d:	6a 00                	push   $0x0
  80247f:	6a 00                	push   $0x0
  802481:	6a 00                	push   $0x0
  802483:	6a 00                	push   $0x0
  802485:	6a 00                	push   $0x0
  802487:	6a 28                	push   $0x28
  802489:	e8 43 fb ff ff       	call   801fd1 <syscall>
  80248e:	83 c4 18             	add    $0x18,%esp
	return ;
  802491:	90                   	nop
}
  802492:	c9                   	leave  
  802493:	c3                   	ret    

00802494 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802494:	55                   	push   %ebp
  802495:	89 e5                	mov    %esp,%ebp
  802497:	83 ec 04             	sub    $0x4,%esp
  80249a:	8b 45 14             	mov    0x14(%ebp),%eax
  80249d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8024a0:	8b 55 18             	mov    0x18(%ebp),%edx
  8024a3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8024a7:	52                   	push   %edx
  8024a8:	50                   	push   %eax
  8024a9:	ff 75 10             	pushl  0x10(%ebp)
  8024ac:	ff 75 0c             	pushl  0xc(%ebp)
  8024af:	ff 75 08             	pushl  0x8(%ebp)
  8024b2:	6a 27                	push   $0x27
  8024b4:	e8 18 fb ff ff       	call   801fd1 <syscall>
  8024b9:	83 c4 18             	add    $0x18,%esp
	return ;
  8024bc:	90                   	nop
}
  8024bd:	c9                   	leave  
  8024be:	c3                   	ret    

008024bf <chktst>:
void chktst(uint32 n)
{
  8024bf:	55                   	push   %ebp
  8024c0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8024c2:	6a 00                	push   $0x0
  8024c4:	6a 00                	push   $0x0
  8024c6:	6a 00                	push   $0x0
  8024c8:	6a 00                	push   $0x0
  8024ca:	ff 75 08             	pushl  0x8(%ebp)
  8024cd:	6a 29                	push   $0x29
  8024cf:	e8 fd fa ff ff       	call   801fd1 <syscall>
  8024d4:	83 c4 18             	add    $0x18,%esp
	return ;
  8024d7:	90                   	nop
}
  8024d8:	c9                   	leave  
  8024d9:	c3                   	ret    

008024da <inctst>:

void inctst()
{
  8024da:	55                   	push   %ebp
  8024db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8024dd:	6a 00                	push   $0x0
  8024df:	6a 00                	push   $0x0
  8024e1:	6a 00                	push   $0x0
  8024e3:	6a 00                	push   $0x0
  8024e5:	6a 00                	push   $0x0
  8024e7:	6a 2a                	push   $0x2a
  8024e9:	e8 e3 fa ff ff       	call   801fd1 <syscall>
  8024ee:	83 c4 18             	add    $0x18,%esp
	return ;
  8024f1:	90                   	nop
}
  8024f2:	c9                   	leave  
  8024f3:	c3                   	ret    

008024f4 <gettst>:
uint32 gettst()
{
  8024f4:	55                   	push   %ebp
  8024f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8024f7:	6a 00                	push   $0x0
  8024f9:	6a 00                	push   $0x0
  8024fb:	6a 00                	push   $0x0
  8024fd:	6a 00                	push   $0x0
  8024ff:	6a 00                	push   $0x0
  802501:	6a 2b                	push   $0x2b
  802503:	e8 c9 fa ff ff       	call   801fd1 <syscall>
  802508:	83 c4 18             	add    $0x18,%esp
}
  80250b:	c9                   	leave  
  80250c:	c3                   	ret    

0080250d <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80250d:	55                   	push   %ebp
  80250e:	89 e5                	mov    %esp,%ebp
  802510:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802513:	6a 00                	push   $0x0
  802515:	6a 00                	push   $0x0
  802517:	6a 00                	push   $0x0
  802519:	6a 00                	push   $0x0
  80251b:	6a 00                	push   $0x0
  80251d:	6a 2c                	push   $0x2c
  80251f:	e8 ad fa ff ff       	call   801fd1 <syscall>
  802524:	83 c4 18             	add    $0x18,%esp
  802527:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80252a:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80252e:	75 07                	jne    802537 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802530:	b8 01 00 00 00       	mov    $0x1,%eax
  802535:	eb 05                	jmp    80253c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802537:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80253c:	c9                   	leave  
  80253d:	c3                   	ret    

0080253e <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80253e:	55                   	push   %ebp
  80253f:	89 e5                	mov    %esp,%ebp
  802541:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802544:	6a 00                	push   $0x0
  802546:	6a 00                	push   $0x0
  802548:	6a 00                	push   $0x0
  80254a:	6a 00                	push   $0x0
  80254c:	6a 00                	push   $0x0
  80254e:	6a 2c                	push   $0x2c
  802550:	e8 7c fa ff ff       	call   801fd1 <syscall>
  802555:	83 c4 18             	add    $0x18,%esp
  802558:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80255b:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80255f:	75 07                	jne    802568 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802561:	b8 01 00 00 00       	mov    $0x1,%eax
  802566:	eb 05                	jmp    80256d <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802568:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80256d:	c9                   	leave  
  80256e:	c3                   	ret    

0080256f <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80256f:	55                   	push   %ebp
  802570:	89 e5                	mov    %esp,%ebp
  802572:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802575:	6a 00                	push   $0x0
  802577:	6a 00                	push   $0x0
  802579:	6a 00                	push   $0x0
  80257b:	6a 00                	push   $0x0
  80257d:	6a 00                	push   $0x0
  80257f:	6a 2c                	push   $0x2c
  802581:	e8 4b fa ff ff       	call   801fd1 <syscall>
  802586:	83 c4 18             	add    $0x18,%esp
  802589:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80258c:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802590:	75 07                	jne    802599 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802592:	b8 01 00 00 00       	mov    $0x1,%eax
  802597:	eb 05                	jmp    80259e <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802599:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80259e:	c9                   	leave  
  80259f:	c3                   	ret    

008025a0 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8025a0:	55                   	push   %ebp
  8025a1:	89 e5                	mov    %esp,%ebp
  8025a3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8025a6:	6a 00                	push   $0x0
  8025a8:	6a 00                	push   $0x0
  8025aa:	6a 00                	push   $0x0
  8025ac:	6a 00                	push   $0x0
  8025ae:	6a 00                	push   $0x0
  8025b0:	6a 2c                	push   $0x2c
  8025b2:	e8 1a fa ff ff       	call   801fd1 <syscall>
  8025b7:	83 c4 18             	add    $0x18,%esp
  8025ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8025bd:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8025c1:	75 07                	jne    8025ca <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8025c3:	b8 01 00 00 00       	mov    $0x1,%eax
  8025c8:	eb 05                	jmp    8025cf <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8025ca:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8025cf:	c9                   	leave  
  8025d0:	c3                   	ret    

008025d1 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8025d1:	55                   	push   %ebp
  8025d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8025d4:	6a 00                	push   $0x0
  8025d6:	6a 00                	push   $0x0
  8025d8:	6a 00                	push   $0x0
  8025da:	6a 00                	push   $0x0
  8025dc:	ff 75 08             	pushl  0x8(%ebp)
  8025df:	6a 2d                	push   $0x2d
  8025e1:	e8 eb f9 ff ff       	call   801fd1 <syscall>
  8025e6:	83 c4 18             	add    $0x18,%esp
	return ;
  8025e9:	90                   	nop
}
  8025ea:	c9                   	leave  
  8025eb:	c3                   	ret    

008025ec <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8025ec:	55                   	push   %ebp
  8025ed:	89 e5                	mov    %esp,%ebp
  8025ef:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8025f0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8025f3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8025f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8025f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8025fc:	6a 00                	push   $0x0
  8025fe:	53                   	push   %ebx
  8025ff:	51                   	push   %ecx
  802600:	52                   	push   %edx
  802601:	50                   	push   %eax
  802602:	6a 2e                	push   $0x2e
  802604:	e8 c8 f9 ff ff       	call   801fd1 <syscall>
  802609:	83 c4 18             	add    $0x18,%esp
}
  80260c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80260f:	c9                   	leave  
  802610:	c3                   	ret    

00802611 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802611:	55                   	push   %ebp
  802612:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802614:	8b 55 0c             	mov    0xc(%ebp),%edx
  802617:	8b 45 08             	mov    0x8(%ebp),%eax
  80261a:	6a 00                	push   $0x0
  80261c:	6a 00                	push   $0x0
  80261e:	6a 00                	push   $0x0
  802620:	52                   	push   %edx
  802621:	50                   	push   %eax
  802622:	6a 2f                	push   $0x2f
  802624:	e8 a8 f9 ff ff       	call   801fd1 <syscall>
  802629:	83 c4 18             	add    $0x18,%esp
}
  80262c:	c9                   	leave  
  80262d:	c3                   	ret    

0080262e <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  80262e:	55                   	push   %ebp
  80262f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  802631:	6a 00                	push   $0x0
  802633:	6a 00                	push   $0x0
  802635:	6a 00                	push   $0x0
  802637:	ff 75 0c             	pushl  0xc(%ebp)
  80263a:	ff 75 08             	pushl  0x8(%ebp)
  80263d:	6a 30                	push   $0x30
  80263f:	e8 8d f9 ff ff       	call   801fd1 <syscall>
  802644:	83 c4 18             	add    $0x18,%esp
	return ;
  802647:	90                   	nop
}
  802648:	c9                   	leave  
  802649:	c3                   	ret    
  80264a:	66 90                	xchg   %ax,%ax

0080264c <__udivdi3>:
  80264c:	55                   	push   %ebp
  80264d:	57                   	push   %edi
  80264e:	56                   	push   %esi
  80264f:	53                   	push   %ebx
  802650:	83 ec 1c             	sub    $0x1c,%esp
  802653:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802657:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80265b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80265f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802663:	89 ca                	mov    %ecx,%edx
  802665:	89 f8                	mov    %edi,%eax
  802667:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80266b:	85 f6                	test   %esi,%esi
  80266d:	75 2d                	jne    80269c <__udivdi3+0x50>
  80266f:	39 cf                	cmp    %ecx,%edi
  802671:	77 65                	ja     8026d8 <__udivdi3+0x8c>
  802673:	89 fd                	mov    %edi,%ebp
  802675:	85 ff                	test   %edi,%edi
  802677:	75 0b                	jne    802684 <__udivdi3+0x38>
  802679:	b8 01 00 00 00       	mov    $0x1,%eax
  80267e:	31 d2                	xor    %edx,%edx
  802680:	f7 f7                	div    %edi
  802682:	89 c5                	mov    %eax,%ebp
  802684:	31 d2                	xor    %edx,%edx
  802686:	89 c8                	mov    %ecx,%eax
  802688:	f7 f5                	div    %ebp
  80268a:	89 c1                	mov    %eax,%ecx
  80268c:	89 d8                	mov    %ebx,%eax
  80268e:	f7 f5                	div    %ebp
  802690:	89 cf                	mov    %ecx,%edi
  802692:	89 fa                	mov    %edi,%edx
  802694:	83 c4 1c             	add    $0x1c,%esp
  802697:	5b                   	pop    %ebx
  802698:	5e                   	pop    %esi
  802699:	5f                   	pop    %edi
  80269a:	5d                   	pop    %ebp
  80269b:	c3                   	ret    
  80269c:	39 ce                	cmp    %ecx,%esi
  80269e:	77 28                	ja     8026c8 <__udivdi3+0x7c>
  8026a0:	0f bd fe             	bsr    %esi,%edi
  8026a3:	83 f7 1f             	xor    $0x1f,%edi
  8026a6:	75 40                	jne    8026e8 <__udivdi3+0x9c>
  8026a8:	39 ce                	cmp    %ecx,%esi
  8026aa:	72 0a                	jb     8026b6 <__udivdi3+0x6a>
  8026ac:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8026b0:	0f 87 9e 00 00 00    	ja     802754 <__udivdi3+0x108>
  8026b6:	b8 01 00 00 00       	mov    $0x1,%eax
  8026bb:	89 fa                	mov    %edi,%edx
  8026bd:	83 c4 1c             	add    $0x1c,%esp
  8026c0:	5b                   	pop    %ebx
  8026c1:	5e                   	pop    %esi
  8026c2:	5f                   	pop    %edi
  8026c3:	5d                   	pop    %ebp
  8026c4:	c3                   	ret    
  8026c5:	8d 76 00             	lea    0x0(%esi),%esi
  8026c8:	31 ff                	xor    %edi,%edi
  8026ca:	31 c0                	xor    %eax,%eax
  8026cc:	89 fa                	mov    %edi,%edx
  8026ce:	83 c4 1c             	add    $0x1c,%esp
  8026d1:	5b                   	pop    %ebx
  8026d2:	5e                   	pop    %esi
  8026d3:	5f                   	pop    %edi
  8026d4:	5d                   	pop    %ebp
  8026d5:	c3                   	ret    
  8026d6:	66 90                	xchg   %ax,%ax
  8026d8:	89 d8                	mov    %ebx,%eax
  8026da:	f7 f7                	div    %edi
  8026dc:	31 ff                	xor    %edi,%edi
  8026de:	89 fa                	mov    %edi,%edx
  8026e0:	83 c4 1c             	add    $0x1c,%esp
  8026e3:	5b                   	pop    %ebx
  8026e4:	5e                   	pop    %esi
  8026e5:	5f                   	pop    %edi
  8026e6:	5d                   	pop    %ebp
  8026e7:	c3                   	ret    
  8026e8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8026ed:	89 eb                	mov    %ebp,%ebx
  8026ef:	29 fb                	sub    %edi,%ebx
  8026f1:	89 f9                	mov    %edi,%ecx
  8026f3:	d3 e6                	shl    %cl,%esi
  8026f5:	89 c5                	mov    %eax,%ebp
  8026f7:	88 d9                	mov    %bl,%cl
  8026f9:	d3 ed                	shr    %cl,%ebp
  8026fb:	89 e9                	mov    %ebp,%ecx
  8026fd:	09 f1                	or     %esi,%ecx
  8026ff:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802703:	89 f9                	mov    %edi,%ecx
  802705:	d3 e0                	shl    %cl,%eax
  802707:	89 c5                	mov    %eax,%ebp
  802709:	89 d6                	mov    %edx,%esi
  80270b:	88 d9                	mov    %bl,%cl
  80270d:	d3 ee                	shr    %cl,%esi
  80270f:	89 f9                	mov    %edi,%ecx
  802711:	d3 e2                	shl    %cl,%edx
  802713:	8b 44 24 08          	mov    0x8(%esp),%eax
  802717:	88 d9                	mov    %bl,%cl
  802719:	d3 e8                	shr    %cl,%eax
  80271b:	09 c2                	or     %eax,%edx
  80271d:	89 d0                	mov    %edx,%eax
  80271f:	89 f2                	mov    %esi,%edx
  802721:	f7 74 24 0c          	divl   0xc(%esp)
  802725:	89 d6                	mov    %edx,%esi
  802727:	89 c3                	mov    %eax,%ebx
  802729:	f7 e5                	mul    %ebp
  80272b:	39 d6                	cmp    %edx,%esi
  80272d:	72 19                	jb     802748 <__udivdi3+0xfc>
  80272f:	74 0b                	je     80273c <__udivdi3+0xf0>
  802731:	89 d8                	mov    %ebx,%eax
  802733:	31 ff                	xor    %edi,%edi
  802735:	e9 58 ff ff ff       	jmp    802692 <__udivdi3+0x46>
  80273a:	66 90                	xchg   %ax,%ax
  80273c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802740:	89 f9                	mov    %edi,%ecx
  802742:	d3 e2                	shl    %cl,%edx
  802744:	39 c2                	cmp    %eax,%edx
  802746:	73 e9                	jae    802731 <__udivdi3+0xe5>
  802748:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80274b:	31 ff                	xor    %edi,%edi
  80274d:	e9 40 ff ff ff       	jmp    802692 <__udivdi3+0x46>
  802752:	66 90                	xchg   %ax,%ax
  802754:	31 c0                	xor    %eax,%eax
  802756:	e9 37 ff ff ff       	jmp    802692 <__udivdi3+0x46>
  80275b:	90                   	nop

0080275c <__umoddi3>:
  80275c:	55                   	push   %ebp
  80275d:	57                   	push   %edi
  80275e:	56                   	push   %esi
  80275f:	53                   	push   %ebx
  802760:	83 ec 1c             	sub    $0x1c,%esp
  802763:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802767:	8b 74 24 34          	mov    0x34(%esp),%esi
  80276b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80276f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802773:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802777:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80277b:	89 f3                	mov    %esi,%ebx
  80277d:	89 fa                	mov    %edi,%edx
  80277f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802783:	89 34 24             	mov    %esi,(%esp)
  802786:	85 c0                	test   %eax,%eax
  802788:	75 1a                	jne    8027a4 <__umoddi3+0x48>
  80278a:	39 f7                	cmp    %esi,%edi
  80278c:	0f 86 a2 00 00 00    	jbe    802834 <__umoddi3+0xd8>
  802792:	89 c8                	mov    %ecx,%eax
  802794:	89 f2                	mov    %esi,%edx
  802796:	f7 f7                	div    %edi
  802798:	89 d0                	mov    %edx,%eax
  80279a:	31 d2                	xor    %edx,%edx
  80279c:	83 c4 1c             	add    $0x1c,%esp
  80279f:	5b                   	pop    %ebx
  8027a0:	5e                   	pop    %esi
  8027a1:	5f                   	pop    %edi
  8027a2:	5d                   	pop    %ebp
  8027a3:	c3                   	ret    
  8027a4:	39 f0                	cmp    %esi,%eax
  8027a6:	0f 87 ac 00 00 00    	ja     802858 <__umoddi3+0xfc>
  8027ac:	0f bd e8             	bsr    %eax,%ebp
  8027af:	83 f5 1f             	xor    $0x1f,%ebp
  8027b2:	0f 84 ac 00 00 00    	je     802864 <__umoddi3+0x108>
  8027b8:	bf 20 00 00 00       	mov    $0x20,%edi
  8027bd:	29 ef                	sub    %ebp,%edi
  8027bf:	89 fe                	mov    %edi,%esi
  8027c1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8027c5:	89 e9                	mov    %ebp,%ecx
  8027c7:	d3 e0                	shl    %cl,%eax
  8027c9:	89 d7                	mov    %edx,%edi
  8027cb:	89 f1                	mov    %esi,%ecx
  8027cd:	d3 ef                	shr    %cl,%edi
  8027cf:	09 c7                	or     %eax,%edi
  8027d1:	89 e9                	mov    %ebp,%ecx
  8027d3:	d3 e2                	shl    %cl,%edx
  8027d5:	89 14 24             	mov    %edx,(%esp)
  8027d8:	89 d8                	mov    %ebx,%eax
  8027da:	d3 e0                	shl    %cl,%eax
  8027dc:	89 c2                	mov    %eax,%edx
  8027de:	8b 44 24 08          	mov    0x8(%esp),%eax
  8027e2:	d3 e0                	shl    %cl,%eax
  8027e4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8027e8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8027ec:	89 f1                	mov    %esi,%ecx
  8027ee:	d3 e8                	shr    %cl,%eax
  8027f0:	09 d0                	or     %edx,%eax
  8027f2:	d3 eb                	shr    %cl,%ebx
  8027f4:	89 da                	mov    %ebx,%edx
  8027f6:	f7 f7                	div    %edi
  8027f8:	89 d3                	mov    %edx,%ebx
  8027fa:	f7 24 24             	mull   (%esp)
  8027fd:	89 c6                	mov    %eax,%esi
  8027ff:	89 d1                	mov    %edx,%ecx
  802801:	39 d3                	cmp    %edx,%ebx
  802803:	0f 82 87 00 00 00    	jb     802890 <__umoddi3+0x134>
  802809:	0f 84 91 00 00 00    	je     8028a0 <__umoddi3+0x144>
  80280f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802813:	29 f2                	sub    %esi,%edx
  802815:	19 cb                	sbb    %ecx,%ebx
  802817:	89 d8                	mov    %ebx,%eax
  802819:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80281d:	d3 e0                	shl    %cl,%eax
  80281f:	89 e9                	mov    %ebp,%ecx
  802821:	d3 ea                	shr    %cl,%edx
  802823:	09 d0                	or     %edx,%eax
  802825:	89 e9                	mov    %ebp,%ecx
  802827:	d3 eb                	shr    %cl,%ebx
  802829:	89 da                	mov    %ebx,%edx
  80282b:	83 c4 1c             	add    $0x1c,%esp
  80282e:	5b                   	pop    %ebx
  80282f:	5e                   	pop    %esi
  802830:	5f                   	pop    %edi
  802831:	5d                   	pop    %ebp
  802832:	c3                   	ret    
  802833:	90                   	nop
  802834:	89 fd                	mov    %edi,%ebp
  802836:	85 ff                	test   %edi,%edi
  802838:	75 0b                	jne    802845 <__umoddi3+0xe9>
  80283a:	b8 01 00 00 00       	mov    $0x1,%eax
  80283f:	31 d2                	xor    %edx,%edx
  802841:	f7 f7                	div    %edi
  802843:	89 c5                	mov    %eax,%ebp
  802845:	89 f0                	mov    %esi,%eax
  802847:	31 d2                	xor    %edx,%edx
  802849:	f7 f5                	div    %ebp
  80284b:	89 c8                	mov    %ecx,%eax
  80284d:	f7 f5                	div    %ebp
  80284f:	89 d0                	mov    %edx,%eax
  802851:	e9 44 ff ff ff       	jmp    80279a <__umoddi3+0x3e>
  802856:	66 90                	xchg   %ax,%ax
  802858:	89 c8                	mov    %ecx,%eax
  80285a:	89 f2                	mov    %esi,%edx
  80285c:	83 c4 1c             	add    $0x1c,%esp
  80285f:	5b                   	pop    %ebx
  802860:	5e                   	pop    %esi
  802861:	5f                   	pop    %edi
  802862:	5d                   	pop    %ebp
  802863:	c3                   	ret    
  802864:	3b 04 24             	cmp    (%esp),%eax
  802867:	72 06                	jb     80286f <__umoddi3+0x113>
  802869:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80286d:	77 0f                	ja     80287e <__umoddi3+0x122>
  80286f:	89 f2                	mov    %esi,%edx
  802871:	29 f9                	sub    %edi,%ecx
  802873:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802877:	89 14 24             	mov    %edx,(%esp)
  80287a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80287e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802882:	8b 14 24             	mov    (%esp),%edx
  802885:	83 c4 1c             	add    $0x1c,%esp
  802888:	5b                   	pop    %ebx
  802889:	5e                   	pop    %esi
  80288a:	5f                   	pop    %edi
  80288b:	5d                   	pop    %ebp
  80288c:	c3                   	ret    
  80288d:	8d 76 00             	lea    0x0(%esi),%esi
  802890:	2b 04 24             	sub    (%esp),%eax
  802893:	19 fa                	sbb    %edi,%edx
  802895:	89 d1                	mov    %edx,%ecx
  802897:	89 c6                	mov    %eax,%esi
  802899:	e9 71 ff ff ff       	jmp    80280f <__umoddi3+0xb3>
  80289e:	66 90                	xchg   %ax,%ax
  8028a0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8028a4:	72 ea                	jb     802890 <__umoddi3+0x134>
  8028a6:	89 d9                	mov    %ebx,%ecx
  8028a8:	e9 62 ff ff ff       	jmp    80280f <__umoddi3+0xb3>
