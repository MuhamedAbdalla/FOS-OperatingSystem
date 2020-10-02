
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
  80004c:	e8 9f 1e 00 00       	call   801ef0 <sys_disable_interrupt>
		readline("Enter the number of elements: ", Line);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	8d 85 c9 fe ff ff    	lea    -0x137(%ebp),%eax
  80005a:	50                   	push   %eax
  80005b:	68 a0 25 80 00       	push   $0x8025a0
  800060:	e8 51 12 00 00       	call   8012b6 <readline>
  800065:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  800068:	83 ec 04             	sub    $0x4,%esp
  80006b:	6a 0a                	push   $0xa
  80006d:	6a 00                	push   $0x0
  80006f:	8d 85 c9 fe ff ff    	lea    -0x137(%ebp),%eax
  800075:	50                   	push   %eax
  800076:	e8 a1 17 00 00       	call   80181c <strtol>
  80007b:	83 c4 10             	add    $0x10,%esp
  80007e:	89 45 ec             	mov    %eax,-0x14(%ebp)

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  800081:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800084:	c1 e0 02             	shl    $0x2,%eax
  800087:	83 ec 0c             	sub    $0xc,%esp
  80008a:	50                   	push   %eax
  80008b:	e8 34 1b 00 00       	call   801bc4 <malloc>
  800090:	83 c4 10             	add    $0x10,%esp
  800093:	89 45 e8             	mov    %eax,-0x18(%ebp)

		int numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  800096:	a1 24 30 80 00       	mov    0x803024,%eax
  80009b:	83 ec 0c             	sub    $0xc,%esp
  80009e:	50                   	push   %eax
  80009f:	e8 7f 03 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  8000a4:	83 c4 10             	add    $0x10,%esp
  8000a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS ;
  8000aa:	e8 71 1d 00 00       	call   801e20 <sys_calculate_free_frames>
  8000af:	89 c3                	mov    %eax,%ebx
  8000b1:	e8 83 1d 00 00       	call   801e39 <sys_calculate_modified_frames>
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
  8000db:	68 c0 25 80 00       	push   $0x8025c0
  8000e0:	e8 4f 0b 00 00       	call   800c34 <cprintf>
  8000e5:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000e8:	83 ec 0c             	sub    $0xc,%esp
  8000eb:	68 e3 25 80 00       	push   $0x8025e3
  8000f0:	e8 3f 0b 00 00       	call   800c34 <cprintf>
  8000f5:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000f8:	83 ec 0c             	sub    $0xc,%esp
  8000fb:	68 f1 25 80 00       	push   $0x8025f1
  800100:	e8 2f 0b 00 00       	call   800c34 <cprintf>
  800105:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n") ;
  800108:	83 ec 0c             	sub    $0xc,%esp
  80010b:	68 00 26 80 00       	push   $0x802600
  800110:	e8 1f 0b 00 00       	call   800c34 <cprintf>
  800115:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800118:	83 ec 0c             	sub    $0xc,%esp
  80011b:	68 10 26 80 00       	push   $0x802610
  800120:	e8 0f 0b 00 00       	call   800c34 <cprintf>
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
  80015f:	e8 a6 1d 00 00       	call   801f0a <sys_enable_interrupt>
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
  8001ef:	68 1c 26 80 00       	push   $0x80261c
  8001f4:	6a 57                	push   $0x57
  8001f6:	68 3e 26 80 00       	push   $0x80263e
  8001fb:	e8 7d 07 00 00       	call   80097d <_panic>
		else
		{
			cprintf("===============================================\n") ;
  800200:	83 ec 0c             	sub    $0xc,%esp
  800203:	68 5c 26 80 00       	push   $0x80265c
  800208:	e8 27 0a 00 00       	call   800c34 <cprintf>
  80020d:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800210:	83 ec 0c             	sub    $0xc,%esp
  800213:	68 90 26 80 00       	push   $0x802690
  800218:	e8 17 0a 00 00       	call   800c34 <cprintf>
  80021d:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800220:	83 ec 0c             	sub    $0xc,%esp
  800223:	68 c4 26 80 00       	push   $0x8026c4
  800228:	e8 07 0a 00 00       	call   800c34 <cprintf>
  80022d:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		cprintf("Freeing the Heap...\n\n") ;
  800230:	83 ec 0c             	sub    $0xc,%esp
  800233:	68 f6 26 80 00       	push   $0x8026f6
  800238:	e8 f7 09 00 00       	call   800c34 <cprintf>
  80023d:	83 c4 10             	add    $0x10,%esp
		free(Elements) ;
  800240:	83 ec 0c             	sub    $0xc,%esp
  800243:	ff 75 e8             	pushl  -0x18(%ebp)
  800246:	e8 93 19 00 00       	call   801bde <free>
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
  800266:	68 0c 27 80 00       	push   $0x80270c
  80026b:	6a 69                	push   $0x69
  80026d:	68 3e 26 80 00       	push   $0x80263e
  800272:	e8 06 07 00 00       	call   80097d <_panic>

			numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  800277:	a1 24 30 80 00       	mov    0x803024,%eax
  80027c:	83 ec 0c             	sub    $0xc,%esp
  80027f:	50                   	push   %eax
  800280:	e8 9e 01 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  800285:	83 c4 10             	add    $0x10,%esp
  800288:	89 45 e4             	mov    %eax,-0x1c(%ebp)
			int CurrFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS;
  80028b:	e8 90 1b 00 00       	call   801e20 <sys_calculate_free_frames>
  800290:	89 c3                	mov    %eax,%ebx
  800292:	e8 a2 1b 00 00       	call   801e39 <sys_calculate_modified_frames>
  800297:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  80029a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80029d:	29 c2                	sub    %eax,%edx
  80029f:	89 d0                	mov    %edx,%eax
  8002a1:	89 45 d8             	mov    %eax,-0x28(%ebp)
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
  8002a4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002a7:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8002aa:	0f 84 05 01 00 00    	je     8003b5 <_main+0x37d>
  8002b0:	68 5c 27 80 00       	push   $0x80275c
  8002b5:	68 81 27 80 00       	push   $0x802781
  8002ba:	6a 6d                	push   $0x6d
  8002bc:	68 3e 26 80 00       	push   $0x80263e
  8002c1:	e8 b7 06 00 00       	call   80097d <_panic>
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
  8002de:	68 0c 27 80 00       	push   $0x80270c
  8002e3:	6a 72                	push   $0x72
  8002e5:	68 3e 26 80 00       	push   $0x80263e
  8002ea:	e8 8e 06 00 00       	call   80097d <_panic>

			int numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  8002ef:	a1 24 30 80 00       	mov    0x803024,%eax
  8002f4:	83 ec 0c             	sub    $0xc,%esp
  8002f7:	50                   	push   %eax
  8002f8:	e8 26 01 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  8002fd:	83 c4 10             	add    $0x10,%esp
  800300:	89 45 d4             	mov    %eax,-0x2c(%ebp)
			int CurrFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS;
  800303:	e8 18 1b 00 00       	call   801e20 <sys_calculate_free_frames>
  800308:	89 c3                	mov    %eax,%ebx
  80030a:	e8 2a 1b 00 00       	call   801e39 <sys_calculate_modified_frames>
  80030f:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  800312:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800315:	29 c2                	sub    %eax,%edx
  800317:	89 d0                	mov    %edx,%eax
  800319:	89 45 d0             	mov    %eax,-0x30(%ebp)
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
  80031c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80031f:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800322:	0f 84 8d 00 00 00    	je     8003b5 <_main+0x37d>
  800328:	68 5c 27 80 00       	push   $0x80275c
  80032d:	68 81 27 80 00       	push   $0x802781
  800332:	6a 76                	push   $0x76
  800334:	68 3e 26 80 00       	push   $0x80263e
  800339:	e8 3f 06 00 00       	call   80097d <_panic>
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
  800356:	68 0c 27 80 00       	push   $0x80270c
  80035b:	6a 7b                	push   $0x7b
  80035d:	68 3e 26 80 00       	push   $0x80263e
  800362:	e8 16 06 00 00       	call   80097d <_panic>

			int numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  800367:	a1 24 30 80 00       	mov    0x803024,%eax
  80036c:	83 ec 0c             	sub    $0xc,%esp
  80036f:	50                   	push   %eax
  800370:	e8 ae 00 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  800375:	83 c4 10             	add    $0x10,%esp
  800378:	89 45 cc             	mov    %eax,-0x34(%ebp)
			int CurrFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS;
  80037b:	e8 a0 1a 00 00       	call   801e20 <sys_calculate_free_frames>
  800380:	89 c3                	mov    %eax,%ebx
  800382:	e8 b2 1a 00 00       	call   801e39 <sys_calculate_modified_frames>
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
  80039c:	68 5c 27 80 00       	push   $0x80275c
  8003a1:	68 81 27 80 00       	push   $0x802781
  8003a6:	68 80 00 00 00       	push   $0x80
  8003ab:	68 3e 26 80 00       	push   $0x80263e
  8003b0:	e8 c8 05 00 00       	call   80097d <_panic>
		}
		///========================================================================
	sys_disable_interrupt();
  8003b5:	e8 36 1b 00 00       	call   801ef0 <sys_disable_interrupt>
		Chose = 0 ;
  8003ba:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
		while (Chose != 'y' && Chose != 'n')
  8003be:	eb 42                	jmp    800402 <_main+0x3ca>
		{
			cprintf("Do you want to repeat (y/n): ") ;
  8003c0:	83 ec 0c             	sub    $0xc,%esp
  8003c3:	68 96 27 80 00       	push   $0x802796
  8003c8:	e8 67 08 00 00       	call   800c34 <cprintf>
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
  80040e:	e8 f7 1a 00 00       	call   801f0a <sys_enable_interrupt>

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
  80043c:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
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
  800460:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
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
  800498:	68 b4 27 80 00       	push   $0x8027b4
  80049d:	68 9f 00 00 00       	push   $0x9f
  8004a2:	68 3e 26 80 00       	push   $0x80263e
  8004a7:	e8 d1 04 00 00       	call   80097d <_panic>
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
  800758:	68 e2 27 80 00       	push   $0x8027e2
  80075d:	e8 d2 04 00 00       	call   800c34 <cprintf>
  800762:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800765:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800768:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80076f:	8b 45 08             	mov    0x8(%ebp),%eax
  800772:	01 d0                	add    %edx,%eax
  800774:	8b 00                	mov    (%eax),%eax
  800776:	83 ec 08             	sub    $0x8,%esp
  800779:	50                   	push   %eax
  80077a:	68 e4 27 80 00       	push   $0x8027e4
  80077f:	e8 b0 04 00 00       	call   800c34 <cprintf>
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
  8007a8:	68 e9 27 80 00       	push   $0x8027e9
  8007ad:	e8 82 04 00 00       	call   800c34 <cprintf>
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
  8007cc:	e8 53 17 00 00       	call   801f24 <sys_cputc>
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
  8007dd:	e8 0e 17 00 00       	call   801ef0 <sys_disable_interrupt>
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
  8007f0:	e8 2f 17 00 00       	call   801f24 <sys_cputc>
  8007f5:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007f8:	e8 0d 17 00 00       	call   801f0a <sys_enable_interrupt>
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
  80080f:	e8 f4 14 00 00       	call   801d08 <sys_cgetc>
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
  800828:	e8 c3 16 00 00       	call   801ef0 <sys_disable_interrupt>
	int c=0;
  80082d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800834:	eb 08                	jmp    80083e <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800836:	e8 cd 14 00 00       	call   801d08 <sys_cgetc>
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
  800844:	e8 c1 16 00 00       	call   801f0a <sys_enable_interrupt>
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
  80085e:	e8 f2 14 00 00       	call   801d55 <sys_getenvindex>
  800863:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800866:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800869:	89 d0                	mov    %edx,%eax
  80086b:	c1 e0 03             	shl    $0x3,%eax
  80086e:	01 d0                	add    %edx,%eax
  800870:	c1 e0 02             	shl    $0x2,%eax
  800873:	01 d0                	add    %edx,%eax
  800875:	c1 e0 06             	shl    $0x6,%eax
  800878:	29 d0                	sub    %edx,%eax
  80087a:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800881:	01 c8                	add    %ecx,%eax
  800883:	01 d0                	add    %edx,%eax
  800885:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80088a:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80088f:	a1 24 30 80 00       	mov    0x803024,%eax
  800894:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  80089a:	84 c0                	test   %al,%al
  80089c:	74 0f                	je     8008ad <libmain+0x55>
		binaryname = myEnv->prog_name;
  80089e:	a1 24 30 80 00       	mov    0x803024,%eax
  8008a3:	05 b0 52 00 00       	add    $0x52b0,%eax
  8008a8:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8008ad:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008b1:	7e 0a                	jle    8008bd <libmain+0x65>
		binaryname = argv[0];
  8008b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b6:	8b 00                	mov    (%eax),%eax
  8008b8:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8008bd:	83 ec 08             	sub    $0x8,%esp
  8008c0:	ff 75 0c             	pushl  0xc(%ebp)
  8008c3:	ff 75 08             	pushl  0x8(%ebp)
  8008c6:	e8 6d f7 ff ff       	call   800038 <_main>
  8008cb:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8008ce:	e8 1d 16 00 00       	call   801ef0 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8008d3:	83 ec 0c             	sub    $0xc,%esp
  8008d6:	68 08 28 80 00       	push   $0x802808
  8008db:	e8 54 03 00 00       	call   800c34 <cprintf>
  8008e0:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8008e3:	a1 24 30 80 00       	mov    0x803024,%eax
  8008e8:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  8008ee:	a1 24 30 80 00       	mov    0x803024,%eax
  8008f3:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  8008f9:	83 ec 04             	sub    $0x4,%esp
  8008fc:	52                   	push   %edx
  8008fd:	50                   	push   %eax
  8008fe:	68 30 28 80 00       	push   $0x802830
  800903:	e8 2c 03 00 00       	call   800c34 <cprintf>
  800908:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80090b:	a1 24 30 80 00       	mov    0x803024,%eax
  800910:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  800916:	a1 24 30 80 00       	mov    0x803024,%eax
  80091b:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  800921:	a1 24 30 80 00       	mov    0x803024,%eax
  800926:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  80092c:	51                   	push   %ecx
  80092d:	52                   	push   %edx
  80092e:	50                   	push   %eax
  80092f:	68 58 28 80 00       	push   $0x802858
  800934:	e8 fb 02 00 00       	call   800c34 <cprintf>
  800939:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80093c:	83 ec 0c             	sub    $0xc,%esp
  80093f:	68 08 28 80 00       	push   $0x802808
  800944:	e8 eb 02 00 00       	call   800c34 <cprintf>
  800949:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80094c:	e8 b9 15 00 00       	call   801f0a <sys_enable_interrupt>

	// exit gracefully
	exit();
  800951:	e8 19 00 00 00       	call   80096f <exit>
}
  800956:	90                   	nop
  800957:	c9                   	leave  
  800958:	c3                   	ret    

00800959 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800959:	55                   	push   %ebp
  80095a:	89 e5                	mov    %esp,%ebp
  80095c:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80095f:	83 ec 0c             	sub    $0xc,%esp
  800962:	6a 00                	push   $0x0
  800964:	e8 b8 13 00 00       	call   801d21 <sys_env_destroy>
  800969:	83 c4 10             	add    $0x10,%esp
}
  80096c:	90                   	nop
  80096d:	c9                   	leave  
  80096e:	c3                   	ret    

0080096f <exit>:

void
exit(void)
{
  80096f:	55                   	push   %ebp
  800970:	89 e5                	mov    %esp,%ebp
  800972:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800975:	e8 0d 14 00 00       	call   801d87 <sys_env_exit>
}
  80097a:	90                   	nop
  80097b:	c9                   	leave  
  80097c:	c3                   	ret    

0080097d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80097d:	55                   	push   %ebp
  80097e:	89 e5                	mov    %esp,%ebp
  800980:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800983:	8d 45 10             	lea    0x10(%ebp),%eax
  800986:	83 c0 04             	add    $0x4,%eax
  800989:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80098c:	a1 18 31 80 00       	mov    0x803118,%eax
  800991:	85 c0                	test   %eax,%eax
  800993:	74 16                	je     8009ab <_panic+0x2e>
		cprintf("%s: ", argv0);
  800995:	a1 18 31 80 00       	mov    0x803118,%eax
  80099a:	83 ec 08             	sub    $0x8,%esp
  80099d:	50                   	push   %eax
  80099e:	68 b0 28 80 00       	push   $0x8028b0
  8009a3:	e8 8c 02 00 00       	call   800c34 <cprintf>
  8009a8:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8009ab:	a1 00 30 80 00       	mov    0x803000,%eax
  8009b0:	ff 75 0c             	pushl  0xc(%ebp)
  8009b3:	ff 75 08             	pushl  0x8(%ebp)
  8009b6:	50                   	push   %eax
  8009b7:	68 b5 28 80 00       	push   $0x8028b5
  8009bc:	e8 73 02 00 00       	call   800c34 <cprintf>
  8009c1:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8009c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8009c7:	83 ec 08             	sub    $0x8,%esp
  8009ca:	ff 75 f4             	pushl  -0xc(%ebp)
  8009cd:	50                   	push   %eax
  8009ce:	e8 f6 01 00 00       	call   800bc9 <vcprintf>
  8009d3:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8009d6:	83 ec 08             	sub    $0x8,%esp
  8009d9:	6a 00                	push   $0x0
  8009db:	68 d1 28 80 00       	push   $0x8028d1
  8009e0:	e8 e4 01 00 00       	call   800bc9 <vcprintf>
  8009e5:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8009e8:	e8 82 ff ff ff       	call   80096f <exit>

	// should not return here
	while (1) ;
  8009ed:	eb fe                	jmp    8009ed <_panic+0x70>

008009ef <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8009ef:	55                   	push   %ebp
  8009f0:	89 e5                	mov    %esp,%ebp
  8009f2:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8009f5:	a1 24 30 80 00       	mov    0x803024,%eax
  8009fa:	8b 50 74             	mov    0x74(%eax),%edx
  8009fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a00:	39 c2                	cmp    %eax,%edx
  800a02:	74 14                	je     800a18 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800a04:	83 ec 04             	sub    $0x4,%esp
  800a07:	68 d4 28 80 00       	push   $0x8028d4
  800a0c:	6a 26                	push   $0x26
  800a0e:	68 20 29 80 00       	push   $0x802920
  800a13:	e8 65 ff ff ff       	call   80097d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800a18:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800a1f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a26:	e9 c4 00 00 00       	jmp    800aef <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800a2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a2e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a35:	8b 45 08             	mov    0x8(%ebp),%eax
  800a38:	01 d0                	add    %edx,%eax
  800a3a:	8b 00                	mov    (%eax),%eax
  800a3c:	85 c0                	test   %eax,%eax
  800a3e:	75 08                	jne    800a48 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800a40:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800a43:	e9 a4 00 00 00       	jmp    800aec <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  800a48:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a4f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800a56:	eb 6b                	jmp    800ac3 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800a58:	a1 24 30 80 00       	mov    0x803024,%eax
  800a5d:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800a63:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a66:	89 d0                	mov    %edx,%eax
  800a68:	c1 e0 02             	shl    $0x2,%eax
  800a6b:	01 d0                	add    %edx,%eax
  800a6d:	c1 e0 02             	shl    $0x2,%eax
  800a70:	01 c8                	add    %ecx,%eax
  800a72:	8a 40 04             	mov    0x4(%eax),%al
  800a75:	84 c0                	test   %al,%al
  800a77:	75 47                	jne    800ac0 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a79:	a1 24 30 80 00       	mov    0x803024,%eax
  800a7e:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800a84:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a87:	89 d0                	mov    %edx,%eax
  800a89:	c1 e0 02             	shl    $0x2,%eax
  800a8c:	01 d0                	add    %edx,%eax
  800a8e:	c1 e0 02             	shl    $0x2,%eax
  800a91:	01 c8                	add    %ecx,%eax
  800a93:	8b 00                	mov    (%eax),%eax
  800a95:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800a98:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a9b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800aa0:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800aa2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aa5:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800aac:	8b 45 08             	mov    0x8(%ebp),%eax
  800aaf:	01 c8                	add    %ecx,%eax
  800ab1:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800ab3:	39 c2                	cmp    %eax,%edx
  800ab5:	75 09                	jne    800ac0 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800ab7:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800abe:	eb 12                	jmp    800ad2 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ac0:	ff 45 e8             	incl   -0x18(%ebp)
  800ac3:	a1 24 30 80 00       	mov    0x803024,%eax
  800ac8:	8b 50 74             	mov    0x74(%eax),%edx
  800acb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800ace:	39 c2                	cmp    %eax,%edx
  800ad0:	77 86                	ja     800a58 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800ad2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800ad6:	75 14                	jne    800aec <CheckWSWithoutLastIndex+0xfd>
			panic(
  800ad8:	83 ec 04             	sub    $0x4,%esp
  800adb:	68 2c 29 80 00       	push   $0x80292c
  800ae0:	6a 3a                	push   $0x3a
  800ae2:	68 20 29 80 00       	push   $0x802920
  800ae7:	e8 91 fe ff ff       	call   80097d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800aec:	ff 45 f0             	incl   -0x10(%ebp)
  800aef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800af2:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800af5:	0f 8c 30 ff ff ff    	jl     800a2b <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800afb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b02:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800b09:	eb 27                	jmp    800b32 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800b0b:	a1 24 30 80 00       	mov    0x803024,%eax
  800b10:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800b16:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b19:	89 d0                	mov    %edx,%eax
  800b1b:	c1 e0 02             	shl    $0x2,%eax
  800b1e:	01 d0                	add    %edx,%eax
  800b20:	c1 e0 02             	shl    $0x2,%eax
  800b23:	01 c8                	add    %ecx,%eax
  800b25:	8a 40 04             	mov    0x4(%eax),%al
  800b28:	3c 01                	cmp    $0x1,%al
  800b2a:	75 03                	jne    800b2f <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800b2c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b2f:	ff 45 e0             	incl   -0x20(%ebp)
  800b32:	a1 24 30 80 00       	mov    0x803024,%eax
  800b37:	8b 50 74             	mov    0x74(%eax),%edx
  800b3a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b3d:	39 c2                	cmp    %eax,%edx
  800b3f:	77 ca                	ja     800b0b <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800b41:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b44:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800b47:	74 14                	je     800b5d <CheckWSWithoutLastIndex+0x16e>
		panic(
  800b49:	83 ec 04             	sub    $0x4,%esp
  800b4c:	68 80 29 80 00       	push   $0x802980
  800b51:	6a 44                	push   $0x44
  800b53:	68 20 29 80 00       	push   $0x802920
  800b58:	e8 20 fe ff ff       	call   80097d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800b5d:	90                   	nop
  800b5e:	c9                   	leave  
  800b5f:	c3                   	ret    

00800b60 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800b60:	55                   	push   %ebp
  800b61:	89 e5                	mov    %esp,%ebp
  800b63:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800b66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b69:	8b 00                	mov    (%eax),%eax
  800b6b:	8d 48 01             	lea    0x1(%eax),%ecx
  800b6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b71:	89 0a                	mov    %ecx,(%edx)
  800b73:	8b 55 08             	mov    0x8(%ebp),%edx
  800b76:	88 d1                	mov    %dl,%cl
  800b78:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b7b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800b7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b82:	8b 00                	mov    (%eax),%eax
  800b84:	3d ff 00 00 00       	cmp    $0xff,%eax
  800b89:	75 2c                	jne    800bb7 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800b8b:	a0 28 30 80 00       	mov    0x803028,%al
  800b90:	0f b6 c0             	movzbl %al,%eax
  800b93:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b96:	8b 12                	mov    (%edx),%edx
  800b98:	89 d1                	mov    %edx,%ecx
  800b9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b9d:	83 c2 08             	add    $0x8,%edx
  800ba0:	83 ec 04             	sub    $0x4,%esp
  800ba3:	50                   	push   %eax
  800ba4:	51                   	push   %ecx
  800ba5:	52                   	push   %edx
  800ba6:	e8 34 11 00 00       	call   801cdf <sys_cputs>
  800bab:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800bae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800bb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bba:	8b 40 04             	mov    0x4(%eax),%eax
  800bbd:	8d 50 01             	lea    0x1(%eax),%edx
  800bc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc3:	89 50 04             	mov    %edx,0x4(%eax)
}
  800bc6:	90                   	nop
  800bc7:	c9                   	leave  
  800bc8:	c3                   	ret    

00800bc9 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800bc9:	55                   	push   %ebp
  800bca:	89 e5                	mov    %esp,%ebp
  800bcc:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800bd2:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800bd9:	00 00 00 
	b.cnt = 0;
  800bdc:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800be3:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800be6:	ff 75 0c             	pushl  0xc(%ebp)
  800be9:	ff 75 08             	pushl  0x8(%ebp)
  800bec:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800bf2:	50                   	push   %eax
  800bf3:	68 60 0b 80 00       	push   $0x800b60
  800bf8:	e8 11 02 00 00       	call   800e0e <vprintfmt>
  800bfd:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800c00:	a0 28 30 80 00       	mov    0x803028,%al
  800c05:	0f b6 c0             	movzbl %al,%eax
  800c08:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800c0e:	83 ec 04             	sub    $0x4,%esp
  800c11:	50                   	push   %eax
  800c12:	52                   	push   %edx
  800c13:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c19:	83 c0 08             	add    $0x8,%eax
  800c1c:	50                   	push   %eax
  800c1d:	e8 bd 10 00 00       	call   801cdf <sys_cputs>
  800c22:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800c25:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800c2c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800c32:	c9                   	leave  
  800c33:	c3                   	ret    

00800c34 <cprintf>:

int cprintf(const char *fmt, ...) {
  800c34:	55                   	push   %ebp
  800c35:	89 e5                	mov    %esp,%ebp
  800c37:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c3a:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800c41:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c44:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c47:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4a:	83 ec 08             	sub    $0x8,%esp
  800c4d:	ff 75 f4             	pushl  -0xc(%ebp)
  800c50:	50                   	push   %eax
  800c51:	e8 73 ff ff ff       	call   800bc9 <vcprintf>
  800c56:	83 c4 10             	add    $0x10,%esp
  800c59:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800c5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c5f:	c9                   	leave  
  800c60:	c3                   	ret    

00800c61 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800c61:	55                   	push   %ebp
  800c62:	89 e5                	mov    %esp,%ebp
  800c64:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800c67:	e8 84 12 00 00       	call   801ef0 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800c6c:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c72:	8b 45 08             	mov    0x8(%ebp),%eax
  800c75:	83 ec 08             	sub    $0x8,%esp
  800c78:	ff 75 f4             	pushl  -0xc(%ebp)
  800c7b:	50                   	push   %eax
  800c7c:	e8 48 ff ff ff       	call   800bc9 <vcprintf>
  800c81:	83 c4 10             	add    $0x10,%esp
  800c84:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800c87:	e8 7e 12 00 00       	call   801f0a <sys_enable_interrupt>
	return cnt;
  800c8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c8f:	c9                   	leave  
  800c90:	c3                   	ret    

00800c91 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800c91:	55                   	push   %ebp
  800c92:	89 e5                	mov    %esp,%ebp
  800c94:	53                   	push   %ebx
  800c95:	83 ec 14             	sub    $0x14,%esp
  800c98:	8b 45 10             	mov    0x10(%ebp),%eax
  800c9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c9e:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800ca4:	8b 45 18             	mov    0x18(%ebp),%eax
  800ca7:	ba 00 00 00 00       	mov    $0x0,%edx
  800cac:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800caf:	77 55                	ja     800d06 <printnum+0x75>
  800cb1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800cb4:	72 05                	jb     800cbb <printnum+0x2a>
  800cb6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800cb9:	77 4b                	ja     800d06 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800cbb:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800cbe:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800cc1:	8b 45 18             	mov    0x18(%ebp),%eax
  800cc4:	ba 00 00 00 00       	mov    $0x0,%edx
  800cc9:	52                   	push   %edx
  800cca:	50                   	push   %eax
  800ccb:	ff 75 f4             	pushl  -0xc(%ebp)
  800cce:	ff 75 f0             	pushl  -0x10(%ebp)
  800cd1:	e8 5a 16 00 00       	call   802330 <__udivdi3>
  800cd6:	83 c4 10             	add    $0x10,%esp
  800cd9:	83 ec 04             	sub    $0x4,%esp
  800cdc:	ff 75 20             	pushl  0x20(%ebp)
  800cdf:	53                   	push   %ebx
  800ce0:	ff 75 18             	pushl  0x18(%ebp)
  800ce3:	52                   	push   %edx
  800ce4:	50                   	push   %eax
  800ce5:	ff 75 0c             	pushl  0xc(%ebp)
  800ce8:	ff 75 08             	pushl  0x8(%ebp)
  800ceb:	e8 a1 ff ff ff       	call   800c91 <printnum>
  800cf0:	83 c4 20             	add    $0x20,%esp
  800cf3:	eb 1a                	jmp    800d0f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800cf5:	83 ec 08             	sub    $0x8,%esp
  800cf8:	ff 75 0c             	pushl  0xc(%ebp)
  800cfb:	ff 75 20             	pushl  0x20(%ebp)
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	ff d0                	call   *%eax
  800d03:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800d06:	ff 4d 1c             	decl   0x1c(%ebp)
  800d09:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800d0d:	7f e6                	jg     800cf5 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800d0f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800d12:	bb 00 00 00 00       	mov    $0x0,%ebx
  800d17:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d1a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d1d:	53                   	push   %ebx
  800d1e:	51                   	push   %ecx
  800d1f:	52                   	push   %edx
  800d20:	50                   	push   %eax
  800d21:	e8 1a 17 00 00       	call   802440 <__umoddi3>
  800d26:	83 c4 10             	add    $0x10,%esp
  800d29:	05 f4 2b 80 00       	add    $0x802bf4,%eax
  800d2e:	8a 00                	mov    (%eax),%al
  800d30:	0f be c0             	movsbl %al,%eax
  800d33:	83 ec 08             	sub    $0x8,%esp
  800d36:	ff 75 0c             	pushl  0xc(%ebp)
  800d39:	50                   	push   %eax
  800d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3d:	ff d0                	call   *%eax
  800d3f:	83 c4 10             	add    $0x10,%esp
}
  800d42:	90                   	nop
  800d43:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800d46:	c9                   	leave  
  800d47:	c3                   	ret    

00800d48 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800d48:	55                   	push   %ebp
  800d49:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d4b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d4f:	7e 1c                	jle    800d6d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800d51:	8b 45 08             	mov    0x8(%ebp),%eax
  800d54:	8b 00                	mov    (%eax),%eax
  800d56:	8d 50 08             	lea    0x8(%eax),%edx
  800d59:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5c:	89 10                	mov    %edx,(%eax)
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d61:	8b 00                	mov    (%eax),%eax
  800d63:	83 e8 08             	sub    $0x8,%eax
  800d66:	8b 50 04             	mov    0x4(%eax),%edx
  800d69:	8b 00                	mov    (%eax),%eax
  800d6b:	eb 40                	jmp    800dad <getuint+0x65>
	else if (lflag)
  800d6d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d71:	74 1e                	je     800d91 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800d73:	8b 45 08             	mov    0x8(%ebp),%eax
  800d76:	8b 00                	mov    (%eax),%eax
  800d78:	8d 50 04             	lea    0x4(%eax),%edx
  800d7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7e:	89 10                	mov    %edx,(%eax)
  800d80:	8b 45 08             	mov    0x8(%ebp),%eax
  800d83:	8b 00                	mov    (%eax),%eax
  800d85:	83 e8 04             	sub    $0x4,%eax
  800d88:	8b 00                	mov    (%eax),%eax
  800d8a:	ba 00 00 00 00       	mov    $0x0,%edx
  800d8f:	eb 1c                	jmp    800dad <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800d91:	8b 45 08             	mov    0x8(%ebp),%eax
  800d94:	8b 00                	mov    (%eax),%eax
  800d96:	8d 50 04             	lea    0x4(%eax),%edx
  800d99:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9c:	89 10                	mov    %edx,(%eax)
  800d9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800da1:	8b 00                	mov    (%eax),%eax
  800da3:	83 e8 04             	sub    $0x4,%eax
  800da6:	8b 00                	mov    (%eax),%eax
  800da8:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800dad:	5d                   	pop    %ebp
  800dae:	c3                   	ret    

00800daf <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800daf:	55                   	push   %ebp
  800db0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800db2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800db6:	7e 1c                	jle    800dd4 <getint+0x25>
		return va_arg(*ap, long long);
  800db8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbb:	8b 00                	mov    (%eax),%eax
  800dbd:	8d 50 08             	lea    0x8(%eax),%edx
  800dc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc3:	89 10                	mov    %edx,(%eax)
  800dc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc8:	8b 00                	mov    (%eax),%eax
  800dca:	83 e8 08             	sub    $0x8,%eax
  800dcd:	8b 50 04             	mov    0x4(%eax),%edx
  800dd0:	8b 00                	mov    (%eax),%eax
  800dd2:	eb 38                	jmp    800e0c <getint+0x5d>
	else if (lflag)
  800dd4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dd8:	74 1a                	je     800df4 <getint+0x45>
		return va_arg(*ap, long);
  800dda:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddd:	8b 00                	mov    (%eax),%eax
  800ddf:	8d 50 04             	lea    0x4(%eax),%edx
  800de2:	8b 45 08             	mov    0x8(%ebp),%eax
  800de5:	89 10                	mov    %edx,(%eax)
  800de7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dea:	8b 00                	mov    (%eax),%eax
  800dec:	83 e8 04             	sub    $0x4,%eax
  800def:	8b 00                	mov    (%eax),%eax
  800df1:	99                   	cltd   
  800df2:	eb 18                	jmp    800e0c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800df4:	8b 45 08             	mov    0x8(%ebp),%eax
  800df7:	8b 00                	mov    (%eax),%eax
  800df9:	8d 50 04             	lea    0x4(%eax),%edx
  800dfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dff:	89 10                	mov    %edx,(%eax)
  800e01:	8b 45 08             	mov    0x8(%ebp),%eax
  800e04:	8b 00                	mov    (%eax),%eax
  800e06:	83 e8 04             	sub    $0x4,%eax
  800e09:	8b 00                	mov    (%eax),%eax
  800e0b:	99                   	cltd   
}
  800e0c:	5d                   	pop    %ebp
  800e0d:	c3                   	ret    

00800e0e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800e0e:	55                   	push   %ebp
  800e0f:	89 e5                	mov    %esp,%ebp
  800e11:	56                   	push   %esi
  800e12:	53                   	push   %ebx
  800e13:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e16:	eb 17                	jmp    800e2f <vprintfmt+0x21>
			if (ch == '\0')
  800e18:	85 db                	test   %ebx,%ebx
  800e1a:	0f 84 af 03 00 00    	je     8011cf <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800e20:	83 ec 08             	sub    $0x8,%esp
  800e23:	ff 75 0c             	pushl  0xc(%ebp)
  800e26:	53                   	push   %ebx
  800e27:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2a:	ff d0                	call   *%eax
  800e2c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e2f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e32:	8d 50 01             	lea    0x1(%eax),%edx
  800e35:	89 55 10             	mov    %edx,0x10(%ebp)
  800e38:	8a 00                	mov    (%eax),%al
  800e3a:	0f b6 d8             	movzbl %al,%ebx
  800e3d:	83 fb 25             	cmp    $0x25,%ebx
  800e40:	75 d6                	jne    800e18 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800e42:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800e46:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800e4d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800e54:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800e5b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800e62:	8b 45 10             	mov    0x10(%ebp),%eax
  800e65:	8d 50 01             	lea    0x1(%eax),%edx
  800e68:	89 55 10             	mov    %edx,0x10(%ebp)
  800e6b:	8a 00                	mov    (%eax),%al
  800e6d:	0f b6 d8             	movzbl %al,%ebx
  800e70:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800e73:	83 f8 55             	cmp    $0x55,%eax
  800e76:	0f 87 2b 03 00 00    	ja     8011a7 <vprintfmt+0x399>
  800e7c:	8b 04 85 18 2c 80 00 	mov    0x802c18(,%eax,4),%eax
  800e83:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800e85:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800e89:	eb d7                	jmp    800e62 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800e8b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800e8f:	eb d1                	jmp    800e62 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e91:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800e98:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e9b:	89 d0                	mov    %edx,%eax
  800e9d:	c1 e0 02             	shl    $0x2,%eax
  800ea0:	01 d0                	add    %edx,%eax
  800ea2:	01 c0                	add    %eax,%eax
  800ea4:	01 d8                	add    %ebx,%eax
  800ea6:	83 e8 30             	sub    $0x30,%eax
  800ea9:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800eac:	8b 45 10             	mov    0x10(%ebp),%eax
  800eaf:	8a 00                	mov    (%eax),%al
  800eb1:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800eb4:	83 fb 2f             	cmp    $0x2f,%ebx
  800eb7:	7e 3e                	jle    800ef7 <vprintfmt+0xe9>
  800eb9:	83 fb 39             	cmp    $0x39,%ebx
  800ebc:	7f 39                	jg     800ef7 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ebe:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ec1:	eb d5                	jmp    800e98 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800ec3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec6:	83 c0 04             	add    $0x4,%eax
  800ec9:	89 45 14             	mov    %eax,0x14(%ebp)
  800ecc:	8b 45 14             	mov    0x14(%ebp),%eax
  800ecf:	83 e8 04             	sub    $0x4,%eax
  800ed2:	8b 00                	mov    (%eax),%eax
  800ed4:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800ed7:	eb 1f                	jmp    800ef8 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800ed9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800edd:	79 83                	jns    800e62 <vprintfmt+0x54>
				width = 0;
  800edf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800ee6:	e9 77 ff ff ff       	jmp    800e62 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800eeb:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800ef2:	e9 6b ff ff ff       	jmp    800e62 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ef7:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800ef8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800efc:	0f 89 60 ff ff ff    	jns    800e62 <vprintfmt+0x54>
				width = precision, precision = -1;
  800f02:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f05:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800f08:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800f0f:	e9 4e ff ff ff       	jmp    800e62 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800f14:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800f17:	e9 46 ff ff ff       	jmp    800e62 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800f1c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f1f:	83 c0 04             	add    $0x4,%eax
  800f22:	89 45 14             	mov    %eax,0x14(%ebp)
  800f25:	8b 45 14             	mov    0x14(%ebp),%eax
  800f28:	83 e8 04             	sub    $0x4,%eax
  800f2b:	8b 00                	mov    (%eax),%eax
  800f2d:	83 ec 08             	sub    $0x8,%esp
  800f30:	ff 75 0c             	pushl  0xc(%ebp)
  800f33:	50                   	push   %eax
  800f34:	8b 45 08             	mov    0x8(%ebp),%eax
  800f37:	ff d0                	call   *%eax
  800f39:	83 c4 10             	add    $0x10,%esp
			break;
  800f3c:	e9 89 02 00 00       	jmp    8011ca <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800f41:	8b 45 14             	mov    0x14(%ebp),%eax
  800f44:	83 c0 04             	add    $0x4,%eax
  800f47:	89 45 14             	mov    %eax,0x14(%ebp)
  800f4a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f4d:	83 e8 04             	sub    $0x4,%eax
  800f50:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800f52:	85 db                	test   %ebx,%ebx
  800f54:	79 02                	jns    800f58 <vprintfmt+0x14a>
				err = -err;
  800f56:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800f58:	83 fb 64             	cmp    $0x64,%ebx
  800f5b:	7f 0b                	jg     800f68 <vprintfmt+0x15a>
  800f5d:	8b 34 9d 60 2a 80 00 	mov    0x802a60(,%ebx,4),%esi
  800f64:	85 f6                	test   %esi,%esi
  800f66:	75 19                	jne    800f81 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800f68:	53                   	push   %ebx
  800f69:	68 05 2c 80 00       	push   $0x802c05
  800f6e:	ff 75 0c             	pushl  0xc(%ebp)
  800f71:	ff 75 08             	pushl  0x8(%ebp)
  800f74:	e8 5e 02 00 00       	call   8011d7 <printfmt>
  800f79:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800f7c:	e9 49 02 00 00       	jmp    8011ca <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800f81:	56                   	push   %esi
  800f82:	68 0e 2c 80 00       	push   $0x802c0e
  800f87:	ff 75 0c             	pushl  0xc(%ebp)
  800f8a:	ff 75 08             	pushl  0x8(%ebp)
  800f8d:	e8 45 02 00 00       	call   8011d7 <printfmt>
  800f92:	83 c4 10             	add    $0x10,%esp
			break;
  800f95:	e9 30 02 00 00       	jmp    8011ca <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800f9a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f9d:	83 c0 04             	add    $0x4,%eax
  800fa0:	89 45 14             	mov    %eax,0x14(%ebp)
  800fa3:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa6:	83 e8 04             	sub    $0x4,%eax
  800fa9:	8b 30                	mov    (%eax),%esi
  800fab:	85 f6                	test   %esi,%esi
  800fad:	75 05                	jne    800fb4 <vprintfmt+0x1a6>
				p = "(null)";
  800faf:	be 11 2c 80 00       	mov    $0x802c11,%esi
			if (width > 0 && padc != '-')
  800fb4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fb8:	7e 6d                	jle    801027 <vprintfmt+0x219>
  800fba:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800fbe:	74 67                	je     801027 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800fc0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800fc3:	83 ec 08             	sub    $0x8,%esp
  800fc6:	50                   	push   %eax
  800fc7:	56                   	push   %esi
  800fc8:	e8 12 05 00 00       	call   8014df <strnlen>
  800fcd:	83 c4 10             	add    $0x10,%esp
  800fd0:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800fd3:	eb 16                	jmp    800feb <vprintfmt+0x1dd>
					putch(padc, putdat);
  800fd5:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800fd9:	83 ec 08             	sub    $0x8,%esp
  800fdc:	ff 75 0c             	pushl  0xc(%ebp)
  800fdf:	50                   	push   %eax
  800fe0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe3:	ff d0                	call   *%eax
  800fe5:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800fe8:	ff 4d e4             	decl   -0x1c(%ebp)
  800feb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fef:	7f e4                	jg     800fd5 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ff1:	eb 34                	jmp    801027 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800ff3:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800ff7:	74 1c                	je     801015 <vprintfmt+0x207>
  800ff9:	83 fb 1f             	cmp    $0x1f,%ebx
  800ffc:	7e 05                	jle    801003 <vprintfmt+0x1f5>
  800ffe:	83 fb 7e             	cmp    $0x7e,%ebx
  801001:	7e 12                	jle    801015 <vprintfmt+0x207>
					putch('?', putdat);
  801003:	83 ec 08             	sub    $0x8,%esp
  801006:	ff 75 0c             	pushl  0xc(%ebp)
  801009:	6a 3f                	push   $0x3f
  80100b:	8b 45 08             	mov    0x8(%ebp),%eax
  80100e:	ff d0                	call   *%eax
  801010:	83 c4 10             	add    $0x10,%esp
  801013:	eb 0f                	jmp    801024 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801015:	83 ec 08             	sub    $0x8,%esp
  801018:	ff 75 0c             	pushl  0xc(%ebp)
  80101b:	53                   	push   %ebx
  80101c:	8b 45 08             	mov    0x8(%ebp),%eax
  80101f:	ff d0                	call   *%eax
  801021:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801024:	ff 4d e4             	decl   -0x1c(%ebp)
  801027:	89 f0                	mov    %esi,%eax
  801029:	8d 70 01             	lea    0x1(%eax),%esi
  80102c:	8a 00                	mov    (%eax),%al
  80102e:	0f be d8             	movsbl %al,%ebx
  801031:	85 db                	test   %ebx,%ebx
  801033:	74 24                	je     801059 <vprintfmt+0x24b>
  801035:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801039:	78 b8                	js     800ff3 <vprintfmt+0x1e5>
  80103b:	ff 4d e0             	decl   -0x20(%ebp)
  80103e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801042:	79 af                	jns    800ff3 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801044:	eb 13                	jmp    801059 <vprintfmt+0x24b>
				putch(' ', putdat);
  801046:	83 ec 08             	sub    $0x8,%esp
  801049:	ff 75 0c             	pushl  0xc(%ebp)
  80104c:	6a 20                	push   $0x20
  80104e:	8b 45 08             	mov    0x8(%ebp),%eax
  801051:	ff d0                	call   *%eax
  801053:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801056:	ff 4d e4             	decl   -0x1c(%ebp)
  801059:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80105d:	7f e7                	jg     801046 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80105f:	e9 66 01 00 00       	jmp    8011ca <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801064:	83 ec 08             	sub    $0x8,%esp
  801067:	ff 75 e8             	pushl  -0x18(%ebp)
  80106a:	8d 45 14             	lea    0x14(%ebp),%eax
  80106d:	50                   	push   %eax
  80106e:	e8 3c fd ff ff       	call   800daf <getint>
  801073:	83 c4 10             	add    $0x10,%esp
  801076:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801079:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80107c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80107f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801082:	85 d2                	test   %edx,%edx
  801084:	79 23                	jns    8010a9 <vprintfmt+0x29b>
				putch('-', putdat);
  801086:	83 ec 08             	sub    $0x8,%esp
  801089:	ff 75 0c             	pushl  0xc(%ebp)
  80108c:	6a 2d                	push   $0x2d
  80108e:	8b 45 08             	mov    0x8(%ebp),%eax
  801091:	ff d0                	call   *%eax
  801093:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801096:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801099:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80109c:	f7 d8                	neg    %eax
  80109e:	83 d2 00             	adc    $0x0,%edx
  8010a1:	f7 da                	neg    %edx
  8010a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8010a9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8010b0:	e9 bc 00 00 00       	jmp    801171 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8010b5:	83 ec 08             	sub    $0x8,%esp
  8010b8:	ff 75 e8             	pushl  -0x18(%ebp)
  8010bb:	8d 45 14             	lea    0x14(%ebp),%eax
  8010be:	50                   	push   %eax
  8010bf:	e8 84 fc ff ff       	call   800d48 <getuint>
  8010c4:	83 c4 10             	add    $0x10,%esp
  8010c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8010cd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8010d4:	e9 98 00 00 00       	jmp    801171 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8010d9:	83 ec 08             	sub    $0x8,%esp
  8010dc:	ff 75 0c             	pushl  0xc(%ebp)
  8010df:	6a 58                	push   $0x58
  8010e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e4:	ff d0                	call   *%eax
  8010e6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8010e9:	83 ec 08             	sub    $0x8,%esp
  8010ec:	ff 75 0c             	pushl  0xc(%ebp)
  8010ef:	6a 58                	push   $0x58
  8010f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f4:	ff d0                	call   *%eax
  8010f6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8010f9:	83 ec 08             	sub    $0x8,%esp
  8010fc:	ff 75 0c             	pushl  0xc(%ebp)
  8010ff:	6a 58                	push   $0x58
  801101:	8b 45 08             	mov    0x8(%ebp),%eax
  801104:	ff d0                	call   *%eax
  801106:	83 c4 10             	add    $0x10,%esp
			break;
  801109:	e9 bc 00 00 00       	jmp    8011ca <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80110e:	83 ec 08             	sub    $0x8,%esp
  801111:	ff 75 0c             	pushl  0xc(%ebp)
  801114:	6a 30                	push   $0x30
  801116:	8b 45 08             	mov    0x8(%ebp),%eax
  801119:	ff d0                	call   *%eax
  80111b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80111e:	83 ec 08             	sub    $0x8,%esp
  801121:	ff 75 0c             	pushl  0xc(%ebp)
  801124:	6a 78                	push   $0x78
  801126:	8b 45 08             	mov    0x8(%ebp),%eax
  801129:	ff d0                	call   *%eax
  80112b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80112e:	8b 45 14             	mov    0x14(%ebp),%eax
  801131:	83 c0 04             	add    $0x4,%eax
  801134:	89 45 14             	mov    %eax,0x14(%ebp)
  801137:	8b 45 14             	mov    0x14(%ebp),%eax
  80113a:	83 e8 04             	sub    $0x4,%eax
  80113d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80113f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801142:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801149:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801150:	eb 1f                	jmp    801171 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801152:	83 ec 08             	sub    $0x8,%esp
  801155:	ff 75 e8             	pushl  -0x18(%ebp)
  801158:	8d 45 14             	lea    0x14(%ebp),%eax
  80115b:	50                   	push   %eax
  80115c:	e8 e7 fb ff ff       	call   800d48 <getuint>
  801161:	83 c4 10             	add    $0x10,%esp
  801164:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801167:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80116a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801171:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801175:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801178:	83 ec 04             	sub    $0x4,%esp
  80117b:	52                   	push   %edx
  80117c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80117f:	50                   	push   %eax
  801180:	ff 75 f4             	pushl  -0xc(%ebp)
  801183:	ff 75 f0             	pushl  -0x10(%ebp)
  801186:	ff 75 0c             	pushl  0xc(%ebp)
  801189:	ff 75 08             	pushl  0x8(%ebp)
  80118c:	e8 00 fb ff ff       	call   800c91 <printnum>
  801191:	83 c4 20             	add    $0x20,%esp
			break;
  801194:	eb 34                	jmp    8011ca <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801196:	83 ec 08             	sub    $0x8,%esp
  801199:	ff 75 0c             	pushl  0xc(%ebp)
  80119c:	53                   	push   %ebx
  80119d:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a0:	ff d0                	call   *%eax
  8011a2:	83 c4 10             	add    $0x10,%esp
			break;
  8011a5:	eb 23                	jmp    8011ca <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8011a7:	83 ec 08             	sub    $0x8,%esp
  8011aa:	ff 75 0c             	pushl  0xc(%ebp)
  8011ad:	6a 25                	push   $0x25
  8011af:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b2:	ff d0                	call   *%eax
  8011b4:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8011b7:	ff 4d 10             	decl   0x10(%ebp)
  8011ba:	eb 03                	jmp    8011bf <vprintfmt+0x3b1>
  8011bc:	ff 4d 10             	decl   0x10(%ebp)
  8011bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c2:	48                   	dec    %eax
  8011c3:	8a 00                	mov    (%eax),%al
  8011c5:	3c 25                	cmp    $0x25,%al
  8011c7:	75 f3                	jne    8011bc <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8011c9:	90                   	nop
		}
	}
  8011ca:	e9 47 fc ff ff       	jmp    800e16 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8011cf:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8011d0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8011d3:	5b                   	pop    %ebx
  8011d4:	5e                   	pop    %esi
  8011d5:	5d                   	pop    %ebp
  8011d6:	c3                   	ret    

008011d7 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8011d7:	55                   	push   %ebp
  8011d8:	89 e5                	mov    %esp,%ebp
  8011da:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8011dd:	8d 45 10             	lea    0x10(%ebp),%eax
  8011e0:	83 c0 04             	add    $0x4,%eax
  8011e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8011e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e9:	ff 75 f4             	pushl  -0xc(%ebp)
  8011ec:	50                   	push   %eax
  8011ed:	ff 75 0c             	pushl  0xc(%ebp)
  8011f0:	ff 75 08             	pushl  0x8(%ebp)
  8011f3:	e8 16 fc ff ff       	call   800e0e <vprintfmt>
  8011f8:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8011fb:	90                   	nop
  8011fc:	c9                   	leave  
  8011fd:	c3                   	ret    

008011fe <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8011fe:	55                   	push   %ebp
  8011ff:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801201:	8b 45 0c             	mov    0xc(%ebp),%eax
  801204:	8b 40 08             	mov    0x8(%eax),%eax
  801207:	8d 50 01             	lea    0x1(%eax),%edx
  80120a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801210:	8b 45 0c             	mov    0xc(%ebp),%eax
  801213:	8b 10                	mov    (%eax),%edx
  801215:	8b 45 0c             	mov    0xc(%ebp),%eax
  801218:	8b 40 04             	mov    0x4(%eax),%eax
  80121b:	39 c2                	cmp    %eax,%edx
  80121d:	73 12                	jae    801231 <sprintputch+0x33>
		*b->buf++ = ch;
  80121f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801222:	8b 00                	mov    (%eax),%eax
  801224:	8d 48 01             	lea    0x1(%eax),%ecx
  801227:	8b 55 0c             	mov    0xc(%ebp),%edx
  80122a:	89 0a                	mov    %ecx,(%edx)
  80122c:	8b 55 08             	mov    0x8(%ebp),%edx
  80122f:	88 10                	mov    %dl,(%eax)
}
  801231:	90                   	nop
  801232:	5d                   	pop    %ebp
  801233:	c3                   	ret    

00801234 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801234:	55                   	push   %ebp
  801235:	89 e5                	mov    %esp,%ebp
  801237:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80123a:	8b 45 08             	mov    0x8(%ebp),%eax
  80123d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801240:	8b 45 0c             	mov    0xc(%ebp),%eax
  801243:	8d 50 ff             	lea    -0x1(%eax),%edx
  801246:	8b 45 08             	mov    0x8(%ebp),%eax
  801249:	01 d0                	add    %edx,%eax
  80124b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80124e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801255:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801259:	74 06                	je     801261 <vsnprintf+0x2d>
  80125b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80125f:	7f 07                	jg     801268 <vsnprintf+0x34>
		return -E_INVAL;
  801261:	b8 03 00 00 00       	mov    $0x3,%eax
  801266:	eb 20                	jmp    801288 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801268:	ff 75 14             	pushl  0x14(%ebp)
  80126b:	ff 75 10             	pushl  0x10(%ebp)
  80126e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801271:	50                   	push   %eax
  801272:	68 fe 11 80 00       	push   $0x8011fe
  801277:	e8 92 fb ff ff       	call   800e0e <vprintfmt>
  80127c:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80127f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801282:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801285:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801288:	c9                   	leave  
  801289:	c3                   	ret    

0080128a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80128a:	55                   	push   %ebp
  80128b:	89 e5                	mov    %esp,%ebp
  80128d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801290:	8d 45 10             	lea    0x10(%ebp),%eax
  801293:	83 c0 04             	add    $0x4,%eax
  801296:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801299:	8b 45 10             	mov    0x10(%ebp),%eax
  80129c:	ff 75 f4             	pushl  -0xc(%ebp)
  80129f:	50                   	push   %eax
  8012a0:	ff 75 0c             	pushl  0xc(%ebp)
  8012a3:	ff 75 08             	pushl  0x8(%ebp)
  8012a6:	e8 89 ff ff ff       	call   801234 <vsnprintf>
  8012ab:	83 c4 10             	add    $0x10,%esp
  8012ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8012b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012b4:	c9                   	leave  
  8012b5:	c3                   	ret    

008012b6 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8012b6:	55                   	push   %ebp
  8012b7:	89 e5                	mov    %esp,%ebp
  8012b9:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8012bc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012c0:	74 13                	je     8012d5 <readline+0x1f>
		cprintf("%s", prompt);
  8012c2:	83 ec 08             	sub    $0x8,%esp
  8012c5:	ff 75 08             	pushl  0x8(%ebp)
  8012c8:	68 70 2d 80 00       	push   $0x802d70
  8012cd:	e8 62 f9 ff ff       	call   800c34 <cprintf>
  8012d2:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8012d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8012dc:	83 ec 0c             	sub    $0xc,%esp
  8012df:	6a 00                	push   $0x0
  8012e1:	e8 68 f5 ff ff       	call   80084e <iscons>
  8012e6:	83 c4 10             	add    $0x10,%esp
  8012e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8012ec:	e8 0f f5 ff ff       	call   800800 <getchar>
  8012f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8012f4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8012f8:	79 22                	jns    80131c <readline+0x66>
			if (c != -E_EOF)
  8012fa:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8012fe:	0f 84 ad 00 00 00    	je     8013b1 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801304:	83 ec 08             	sub    $0x8,%esp
  801307:	ff 75 ec             	pushl  -0x14(%ebp)
  80130a:	68 73 2d 80 00       	push   $0x802d73
  80130f:	e8 20 f9 ff ff       	call   800c34 <cprintf>
  801314:	83 c4 10             	add    $0x10,%esp
			return;
  801317:	e9 95 00 00 00       	jmp    8013b1 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80131c:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801320:	7e 34                	jle    801356 <readline+0xa0>
  801322:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801329:	7f 2b                	jg     801356 <readline+0xa0>
			if (echoing)
  80132b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80132f:	74 0e                	je     80133f <readline+0x89>
				cputchar(c);
  801331:	83 ec 0c             	sub    $0xc,%esp
  801334:	ff 75 ec             	pushl  -0x14(%ebp)
  801337:	e8 7c f4 ff ff       	call   8007b8 <cputchar>
  80133c:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80133f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801342:	8d 50 01             	lea    0x1(%eax),%edx
  801345:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801348:	89 c2                	mov    %eax,%edx
  80134a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80134d:	01 d0                	add    %edx,%eax
  80134f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801352:	88 10                	mov    %dl,(%eax)
  801354:	eb 56                	jmp    8013ac <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801356:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80135a:	75 1f                	jne    80137b <readline+0xc5>
  80135c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801360:	7e 19                	jle    80137b <readline+0xc5>
			if (echoing)
  801362:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801366:	74 0e                	je     801376 <readline+0xc0>
				cputchar(c);
  801368:	83 ec 0c             	sub    $0xc,%esp
  80136b:	ff 75 ec             	pushl  -0x14(%ebp)
  80136e:	e8 45 f4 ff ff       	call   8007b8 <cputchar>
  801373:	83 c4 10             	add    $0x10,%esp

			i--;
  801376:	ff 4d f4             	decl   -0xc(%ebp)
  801379:	eb 31                	jmp    8013ac <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  80137b:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80137f:	74 0a                	je     80138b <readline+0xd5>
  801381:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801385:	0f 85 61 ff ff ff    	jne    8012ec <readline+0x36>
			if (echoing)
  80138b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80138f:	74 0e                	je     80139f <readline+0xe9>
				cputchar(c);
  801391:	83 ec 0c             	sub    $0xc,%esp
  801394:	ff 75 ec             	pushl  -0x14(%ebp)
  801397:	e8 1c f4 ff ff       	call   8007b8 <cputchar>
  80139c:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80139f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a5:	01 d0                	add    %edx,%eax
  8013a7:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8013aa:	eb 06                	jmp    8013b2 <readline+0xfc>
		}
	}
  8013ac:	e9 3b ff ff ff       	jmp    8012ec <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8013b1:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8013b2:	c9                   	leave  
  8013b3:	c3                   	ret    

008013b4 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8013b4:	55                   	push   %ebp
  8013b5:	89 e5                	mov    %esp,%ebp
  8013b7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8013ba:	e8 31 0b 00 00       	call   801ef0 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8013bf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013c3:	74 13                	je     8013d8 <atomic_readline+0x24>
		cprintf("%s", prompt);
  8013c5:	83 ec 08             	sub    $0x8,%esp
  8013c8:	ff 75 08             	pushl  0x8(%ebp)
  8013cb:	68 70 2d 80 00       	push   $0x802d70
  8013d0:	e8 5f f8 ff ff       	call   800c34 <cprintf>
  8013d5:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8013d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8013df:	83 ec 0c             	sub    $0xc,%esp
  8013e2:	6a 00                	push   $0x0
  8013e4:	e8 65 f4 ff ff       	call   80084e <iscons>
  8013e9:	83 c4 10             	add    $0x10,%esp
  8013ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8013ef:	e8 0c f4 ff ff       	call   800800 <getchar>
  8013f4:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8013f7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8013fb:	79 23                	jns    801420 <atomic_readline+0x6c>
			if (c != -E_EOF)
  8013fd:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801401:	74 13                	je     801416 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801403:	83 ec 08             	sub    $0x8,%esp
  801406:	ff 75 ec             	pushl  -0x14(%ebp)
  801409:	68 73 2d 80 00       	push   $0x802d73
  80140e:	e8 21 f8 ff ff       	call   800c34 <cprintf>
  801413:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801416:	e8 ef 0a 00 00       	call   801f0a <sys_enable_interrupt>
			return;
  80141b:	e9 9a 00 00 00       	jmp    8014ba <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801420:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801424:	7e 34                	jle    80145a <atomic_readline+0xa6>
  801426:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80142d:	7f 2b                	jg     80145a <atomic_readline+0xa6>
			if (echoing)
  80142f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801433:	74 0e                	je     801443 <atomic_readline+0x8f>
				cputchar(c);
  801435:	83 ec 0c             	sub    $0xc,%esp
  801438:	ff 75 ec             	pushl  -0x14(%ebp)
  80143b:	e8 78 f3 ff ff       	call   8007b8 <cputchar>
  801440:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801443:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801446:	8d 50 01             	lea    0x1(%eax),%edx
  801449:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80144c:	89 c2                	mov    %eax,%edx
  80144e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801451:	01 d0                	add    %edx,%eax
  801453:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801456:	88 10                	mov    %dl,(%eax)
  801458:	eb 5b                	jmp    8014b5 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  80145a:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80145e:	75 1f                	jne    80147f <atomic_readline+0xcb>
  801460:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801464:	7e 19                	jle    80147f <atomic_readline+0xcb>
			if (echoing)
  801466:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80146a:	74 0e                	je     80147a <atomic_readline+0xc6>
				cputchar(c);
  80146c:	83 ec 0c             	sub    $0xc,%esp
  80146f:	ff 75 ec             	pushl  -0x14(%ebp)
  801472:	e8 41 f3 ff ff       	call   8007b8 <cputchar>
  801477:	83 c4 10             	add    $0x10,%esp
			i--;
  80147a:	ff 4d f4             	decl   -0xc(%ebp)
  80147d:	eb 36                	jmp    8014b5 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  80147f:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801483:	74 0a                	je     80148f <atomic_readline+0xdb>
  801485:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801489:	0f 85 60 ff ff ff    	jne    8013ef <atomic_readline+0x3b>
			if (echoing)
  80148f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801493:	74 0e                	je     8014a3 <atomic_readline+0xef>
				cputchar(c);
  801495:	83 ec 0c             	sub    $0xc,%esp
  801498:	ff 75 ec             	pushl  -0x14(%ebp)
  80149b:	e8 18 f3 ff ff       	call   8007b8 <cputchar>
  8014a0:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8014a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a9:	01 d0                	add    %edx,%eax
  8014ab:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8014ae:	e8 57 0a 00 00       	call   801f0a <sys_enable_interrupt>
			return;
  8014b3:	eb 05                	jmp    8014ba <atomic_readline+0x106>
		}
	}
  8014b5:	e9 35 ff ff ff       	jmp    8013ef <atomic_readline+0x3b>
}
  8014ba:	c9                   	leave  
  8014bb:	c3                   	ret    

008014bc <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8014bc:	55                   	push   %ebp
  8014bd:	89 e5                	mov    %esp,%ebp
  8014bf:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8014c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014c9:	eb 06                	jmp    8014d1 <strlen+0x15>
		n++;
  8014cb:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8014ce:	ff 45 08             	incl   0x8(%ebp)
  8014d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d4:	8a 00                	mov    (%eax),%al
  8014d6:	84 c0                	test   %al,%al
  8014d8:	75 f1                	jne    8014cb <strlen+0xf>
		n++;
	return n;
  8014da:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8014dd:	c9                   	leave  
  8014de:	c3                   	ret    

008014df <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8014df:	55                   	push   %ebp
  8014e0:	89 e5                	mov    %esp,%ebp
  8014e2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8014e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014ec:	eb 09                	jmp    8014f7 <strnlen+0x18>
		n++;
  8014ee:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8014f1:	ff 45 08             	incl   0x8(%ebp)
  8014f4:	ff 4d 0c             	decl   0xc(%ebp)
  8014f7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014fb:	74 09                	je     801506 <strnlen+0x27>
  8014fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801500:	8a 00                	mov    (%eax),%al
  801502:	84 c0                	test   %al,%al
  801504:	75 e8                	jne    8014ee <strnlen+0xf>
		n++;
	return n;
  801506:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801509:	c9                   	leave  
  80150a:	c3                   	ret    

0080150b <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80150b:	55                   	push   %ebp
  80150c:	89 e5                	mov    %esp,%ebp
  80150e:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801511:	8b 45 08             	mov    0x8(%ebp),%eax
  801514:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801517:	90                   	nop
  801518:	8b 45 08             	mov    0x8(%ebp),%eax
  80151b:	8d 50 01             	lea    0x1(%eax),%edx
  80151e:	89 55 08             	mov    %edx,0x8(%ebp)
  801521:	8b 55 0c             	mov    0xc(%ebp),%edx
  801524:	8d 4a 01             	lea    0x1(%edx),%ecx
  801527:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80152a:	8a 12                	mov    (%edx),%dl
  80152c:	88 10                	mov    %dl,(%eax)
  80152e:	8a 00                	mov    (%eax),%al
  801530:	84 c0                	test   %al,%al
  801532:	75 e4                	jne    801518 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801534:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801537:	c9                   	leave  
  801538:	c3                   	ret    

00801539 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801539:	55                   	push   %ebp
  80153a:	89 e5                	mov    %esp,%ebp
  80153c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80153f:	8b 45 08             	mov    0x8(%ebp),%eax
  801542:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801545:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80154c:	eb 1f                	jmp    80156d <strncpy+0x34>
		*dst++ = *src;
  80154e:	8b 45 08             	mov    0x8(%ebp),%eax
  801551:	8d 50 01             	lea    0x1(%eax),%edx
  801554:	89 55 08             	mov    %edx,0x8(%ebp)
  801557:	8b 55 0c             	mov    0xc(%ebp),%edx
  80155a:	8a 12                	mov    (%edx),%dl
  80155c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80155e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801561:	8a 00                	mov    (%eax),%al
  801563:	84 c0                	test   %al,%al
  801565:	74 03                	je     80156a <strncpy+0x31>
			src++;
  801567:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80156a:	ff 45 fc             	incl   -0x4(%ebp)
  80156d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801570:	3b 45 10             	cmp    0x10(%ebp),%eax
  801573:	72 d9                	jb     80154e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801575:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801578:	c9                   	leave  
  801579:	c3                   	ret    

0080157a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80157a:	55                   	push   %ebp
  80157b:	89 e5                	mov    %esp,%ebp
  80157d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801580:	8b 45 08             	mov    0x8(%ebp),%eax
  801583:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801586:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80158a:	74 30                	je     8015bc <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80158c:	eb 16                	jmp    8015a4 <strlcpy+0x2a>
			*dst++ = *src++;
  80158e:	8b 45 08             	mov    0x8(%ebp),%eax
  801591:	8d 50 01             	lea    0x1(%eax),%edx
  801594:	89 55 08             	mov    %edx,0x8(%ebp)
  801597:	8b 55 0c             	mov    0xc(%ebp),%edx
  80159a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80159d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8015a0:	8a 12                	mov    (%edx),%dl
  8015a2:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8015a4:	ff 4d 10             	decl   0x10(%ebp)
  8015a7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015ab:	74 09                	je     8015b6 <strlcpy+0x3c>
  8015ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b0:	8a 00                	mov    (%eax),%al
  8015b2:	84 c0                	test   %al,%al
  8015b4:	75 d8                	jne    80158e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8015b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b9:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8015bc:	8b 55 08             	mov    0x8(%ebp),%edx
  8015bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015c2:	29 c2                	sub    %eax,%edx
  8015c4:	89 d0                	mov    %edx,%eax
}
  8015c6:	c9                   	leave  
  8015c7:	c3                   	ret    

008015c8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8015c8:	55                   	push   %ebp
  8015c9:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8015cb:	eb 06                	jmp    8015d3 <strcmp+0xb>
		p++, q++;
  8015cd:	ff 45 08             	incl   0x8(%ebp)
  8015d0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8015d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d6:	8a 00                	mov    (%eax),%al
  8015d8:	84 c0                	test   %al,%al
  8015da:	74 0e                	je     8015ea <strcmp+0x22>
  8015dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015df:	8a 10                	mov    (%eax),%dl
  8015e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e4:	8a 00                	mov    (%eax),%al
  8015e6:	38 c2                	cmp    %al,%dl
  8015e8:	74 e3                	je     8015cd <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8015ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ed:	8a 00                	mov    (%eax),%al
  8015ef:	0f b6 d0             	movzbl %al,%edx
  8015f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015f5:	8a 00                	mov    (%eax),%al
  8015f7:	0f b6 c0             	movzbl %al,%eax
  8015fa:	29 c2                	sub    %eax,%edx
  8015fc:	89 d0                	mov    %edx,%eax
}
  8015fe:	5d                   	pop    %ebp
  8015ff:	c3                   	ret    

00801600 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801600:	55                   	push   %ebp
  801601:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801603:	eb 09                	jmp    80160e <strncmp+0xe>
		n--, p++, q++;
  801605:	ff 4d 10             	decl   0x10(%ebp)
  801608:	ff 45 08             	incl   0x8(%ebp)
  80160b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80160e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801612:	74 17                	je     80162b <strncmp+0x2b>
  801614:	8b 45 08             	mov    0x8(%ebp),%eax
  801617:	8a 00                	mov    (%eax),%al
  801619:	84 c0                	test   %al,%al
  80161b:	74 0e                	je     80162b <strncmp+0x2b>
  80161d:	8b 45 08             	mov    0x8(%ebp),%eax
  801620:	8a 10                	mov    (%eax),%dl
  801622:	8b 45 0c             	mov    0xc(%ebp),%eax
  801625:	8a 00                	mov    (%eax),%al
  801627:	38 c2                	cmp    %al,%dl
  801629:	74 da                	je     801605 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80162b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80162f:	75 07                	jne    801638 <strncmp+0x38>
		return 0;
  801631:	b8 00 00 00 00       	mov    $0x0,%eax
  801636:	eb 14                	jmp    80164c <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801638:	8b 45 08             	mov    0x8(%ebp),%eax
  80163b:	8a 00                	mov    (%eax),%al
  80163d:	0f b6 d0             	movzbl %al,%edx
  801640:	8b 45 0c             	mov    0xc(%ebp),%eax
  801643:	8a 00                	mov    (%eax),%al
  801645:	0f b6 c0             	movzbl %al,%eax
  801648:	29 c2                	sub    %eax,%edx
  80164a:	89 d0                	mov    %edx,%eax
}
  80164c:	5d                   	pop    %ebp
  80164d:	c3                   	ret    

0080164e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80164e:	55                   	push   %ebp
  80164f:	89 e5                	mov    %esp,%ebp
  801651:	83 ec 04             	sub    $0x4,%esp
  801654:	8b 45 0c             	mov    0xc(%ebp),%eax
  801657:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80165a:	eb 12                	jmp    80166e <strchr+0x20>
		if (*s == c)
  80165c:	8b 45 08             	mov    0x8(%ebp),%eax
  80165f:	8a 00                	mov    (%eax),%al
  801661:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801664:	75 05                	jne    80166b <strchr+0x1d>
			return (char *) s;
  801666:	8b 45 08             	mov    0x8(%ebp),%eax
  801669:	eb 11                	jmp    80167c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80166b:	ff 45 08             	incl   0x8(%ebp)
  80166e:	8b 45 08             	mov    0x8(%ebp),%eax
  801671:	8a 00                	mov    (%eax),%al
  801673:	84 c0                	test   %al,%al
  801675:	75 e5                	jne    80165c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801677:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80167c:	c9                   	leave  
  80167d:	c3                   	ret    

0080167e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80167e:	55                   	push   %ebp
  80167f:	89 e5                	mov    %esp,%ebp
  801681:	83 ec 04             	sub    $0x4,%esp
  801684:	8b 45 0c             	mov    0xc(%ebp),%eax
  801687:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80168a:	eb 0d                	jmp    801699 <strfind+0x1b>
		if (*s == c)
  80168c:	8b 45 08             	mov    0x8(%ebp),%eax
  80168f:	8a 00                	mov    (%eax),%al
  801691:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801694:	74 0e                	je     8016a4 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801696:	ff 45 08             	incl   0x8(%ebp)
  801699:	8b 45 08             	mov    0x8(%ebp),%eax
  80169c:	8a 00                	mov    (%eax),%al
  80169e:	84 c0                	test   %al,%al
  8016a0:	75 ea                	jne    80168c <strfind+0xe>
  8016a2:	eb 01                	jmp    8016a5 <strfind+0x27>
		if (*s == c)
			break;
  8016a4:	90                   	nop
	return (char *) s;
  8016a5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016a8:	c9                   	leave  
  8016a9:	c3                   	ret    

008016aa <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8016aa:	55                   	push   %ebp
  8016ab:	89 e5                	mov    %esp,%ebp
  8016ad:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8016b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8016b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8016bc:	eb 0e                	jmp    8016cc <memset+0x22>
		*p++ = c;
  8016be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016c1:	8d 50 01             	lea    0x1(%eax),%edx
  8016c4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8016c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ca:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8016cc:	ff 4d f8             	decl   -0x8(%ebp)
  8016cf:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8016d3:	79 e9                	jns    8016be <memset+0x14>
		*p++ = c;

	return v;
  8016d5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016d8:	c9                   	leave  
  8016d9:	c3                   	ret    

008016da <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8016da:	55                   	push   %ebp
  8016db:	89 e5                	mov    %esp,%ebp
  8016dd:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8016e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8016e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8016ec:	eb 16                	jmp    801704 <memcpy+0x2a>
		*d++ = *s++;
  8016ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016f1:	8d 50 01             	lea    0x1(%eax),%edx
  8016f4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016f7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016fa:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016fd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801700:	8a 12                	mov    (%edx),%dl
  801702:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801704:	8b 45 10             	mov    0x10(%ebp),%eax
  801707:	8d 50 ff             	lea    -0x1(%eax),%edx
  80170a:	89 55 10             	mov    %edx,0x10(%ebp)
  80170d:	85 c0                	test   %eax,%eax
  80170f:	75 dd                	jne    8016ee <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801711:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801714:	c9                   	leave  
  801715:	c3                   	ret    

00801716 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801716:	55                   	push   %ebp
  801717:	89 e5                	mov    %esp,%ebp
  801719:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80171c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80171f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801722:	8b 45 08             	mov    0x8(%ebp),%eax
  801725:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801728:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80172b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80172e:	73 50                	jae    801780 <memmove+0x6a>
  801730:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801733:	8b 45 10             	mov    0x10(%ebp),%eax
  801736:	01 d0                	add    %edx,%eax
  801738:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80173b:	76 43                	jbe    801780 <memmove+0x6a>
		s += n;
  80173d:	8b 45 10             	mov    0x10(%ebp),%eax
  801740:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801743:	8b 45 10             	mov    0x10(%ebp),%eax
  801746:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801749:	eb 10                	jmp    80175b <memmove+0x45>
			*--d = *--s;
  80174b:	ff 4d f8             	decl   -0x8(%ebp)
  80174e:	ff 4d fc             	decl   -0x4(%ebp)
  801751:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801754:	8a 10                	mov    (%eax),%dl
  801756:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801759:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80175b:	8b 45 10             	mov    0x10(%ebp),%eax
  80175e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801761:	89 55 10             	mov    %edx,0x10(%ebp)
  801764:	85 c0                	test   %eax,%eax
  801766:	75 e3                	jne    80174b <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801768:	eb 23                	jmp    80178d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80176a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80176d:	8d 50 01             	lea    0x1(%eax),%edx
  801770:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801773:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801776:	8d 4a 01             	lea    0x1(%edx),%ecx
  801779:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80177c:	8a 12                	mov    (%edx),%dl
  80177e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801780:	8b 45 10             	mov    0x10(%ebp),%eax
  801783:	8d 50 ff             	lea    -0x1(%eax),%edx
  801786:	89 55 10             	mov    %edx,0x10(%ebp)
  801789:	85 c0                	test   %eax,%eax
  80178b:	75 dd                	jne    80176a <memmove+0x54>
			*d++ = *s++;

	return dst;
  80178d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801790:	c9                   	leave  
  801791:	c3                   	ret    

00801792 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801792:	55                   	push   %ebp
  801793:	89 e5                	mov    %esp,%ebp
  801795:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801798:	8b 45 08             	mov    0x8(%ebp),%eax
  80179b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80179e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a1:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8017a4:	eb 2a                	jmp    8017d0 <memcmp+0x3e>
		if (*s1 != *s2)
  8017a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017a9:	8a 10                	mov    (%eax),%dl
  8017ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017ae:	8a 00                	mov    (%eax),%al
  8017b0:	38 c2                	cmp    %al,%dl
  8017b2:	74 16                	je     8017ca <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8017b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017b7:	8a 00                	mov    (%eax),%al
  8017b9:	0f b6 d0             	movzbl %al,%edx
  8017bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017bf:	8a 00                	mov    (%eax),%al
  8017c1:	0f b6 c0             	movzbl %al,%eax
  8017c4:	29 c2                	sub    %eax,%edx
  8017c6:	89 d0                	mov    %edx,%eax
  8017c8:	eb 18                	jmp    8017e2 <memcmp+0x50>
		s1++, s2++;
  8017ca:	ff 45 fc             	incl   -0x4(%ebp)
  8017cd:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8017d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8017d3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017d6:	89 55 10             	mov    %edx,0x10(%ebp)
  8017d9:	85 c0                	test   %eax,%eax
  8017db:	75 c9                	jne    8017a6 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8017dd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017e2:	c9                   	leave  
  8017e3:	c3                   	ret    

008017e4 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8017e4:	55                   	push   %ebp
  8017e5:	89 e5                	mov    %esp,%ebp
  8017e7:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8017ea:	8b 55 08             	mov    0x8(%ebp),%edx
  8017ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8017f0:	01 d0                	add    %edx,%eax
  8017f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8017f5:	eb 15                	jmp    80180c <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8017f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fa:	8a 00                	mov    (%eax),%al
  8017fc:	0f b6 d0             	movzbl %al,%edx
  8017ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801802:	0f b6 c0             	movzbl %al,%eax
  801805:	39 c2                	cmp    %eax,%edx
  801807:	74 0d                	je     801816 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801809:	ff 45 08             	incl   0x8(%ebp)
  80180c:	8b 45 08             	mov    0x8(%ebp),%eax
  80180f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801812:	72 e3                	jb     8017f7 <memfind+0x13>
  801814:	eb 01                	jmp    801817 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801816:	90                   	nop
	return (void *) s;
  801817:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80181a:	c9                   	leave  
  80181b:	c3                   	ret    

0080181c <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80181c:	55                   	push   %ebp
  80181d:	89 e5                	mov    %esp,%ebp
  80181f:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801822:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801829:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801830:	eb 03                	jmp    801835 <strtol+0x19>
		s++;
  801832:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801835:	8b 45 08             	mov    0x8(%ebp),%eax
  801838:	8a 00                	mov    (%eax),%al
  80183a:	3c 20                	cmp    $0x20,%al
  80183c:	74 f4                	je     801832 <strtol+0x16>
  80183e:	8b 45 08             	mov    0x8(%ebp),%eax
  801841:	8a 00                	mov    (%eax),%al
  801843:	3c 09                	cmp    $0x9,%al
  801845:	74 eb                	je     801832 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801847:	8b 45 08             	mov    0x8(%ebp),%eax
  80184a:	8a 00                	mov    (%eax),%al
  80184c:	3c 2b                	cmp    $0x2b,%al
  80184e:	75 05                	jne    801855 <strtol+0x39>
		s++;
  801850:	ff 45 08             	incl   0x8(%ebp)
  801853:	eb 13                	jmp    801868 <strtol+0x4c>
	else if (*s == '-')
  801855:	8b 45 08             	mov    0x8(%ebp),%eax
  801858:	8a 00                	mov    (%eax),%al
  80185a:	3c 2d                	cmp    $0x2d,%al
  80185c:	75 0a                	jne    801868 <strtol+0x4c>
		s++, neg = 1;
  80185e:	ff 45 08             	incl   0x8(%ebp)
  801861:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801868:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80186c:	74 06                	je     801874 <strtol+0x58>
  80186e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801872:	75 20                	jne    801894 <strtol+0x78>
  801874:	8b 45 08             	mov    0x8(%ebp),%eax
  801877:	8a 00                	mov    (%eax),%al
  801879:	3c 30                	cmp    $0x30,%al
  80187b:	75 17                	jne    801894 <strtol+0x78>
  80187d:	8b 45 08             	mov    0x8(%ebp),%eax
  801880:	40                   	inc    %eax
  801881:	8a 00                	mov    (%eax),%al
  801883:	3c 78                	cmp    $0x78,%al
  801885:	75 0d                	jne    801894 <strtol+0x78>
		s += 2, base = 16;
  801887:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80188b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801892:	eb 28                	jmp    8018bc <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801894:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801898:	75 15                	jne    8018af <strtol+0x93>
  80189a:	8b 45 08             	mov    0x8(%ebp),%eax
  80189d:	8a 00                	mov    (%eax),%al
  80189f:	3c 30                	cmp    $0x30,%al
  8018a1:	75 0c                	jne    8018af <strtol+0x93>
		s++, base = 8;
  8018a3:	ff 45 08             	incl   0x8(%ebp)
  8018a6:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8018ad:	eb 0d                	jmp    8018bc <strtol+0xa0>
	else if (base == 0)
  8018af:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018b3:	75 07                	jne    8018bc <strtol+0xa0>
		base = 10;
  8018b5:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8018bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bf:	8a 00                	mov    (%eax),%al
  8018c1:	3c 2f                	cmp    $0x2f,%al
  8018c3:	7e 19                	jle    8018de <strtol+0xc2>
  8018c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c8:	8a 00                	mov    (%eax),%al
  8018ca:	3c 39                	cmp    $0x39,%al
  8018cc:	7f 10                	jg     8018de <strtol+0xc2>
			dig = *s - '0';
  8018ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d1:	8a 00                	mov    (%eax),%al
  8018d3:	0f be c0             	movsbl %al,%eax
  8018d6:	83 e8 30             	sub    $0x30,%eax
  8018d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8018dc:	eb 42                	jmp    801920 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8018de:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e1:	8a 00                	mov    (%eax),%al
  8018e3:	3c 60                	cmp    $0x60,%al
  8018e5:	7e 19                	jle    801900 <strtol+0xe4>
  8018e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ea:	8a 00                	mov    (%eax),%al
  8018ec:	3c 7a                	cmp    $0x7a,%al
  8018ee:	7f 10                	jg     801900 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8018f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f3:	8a 00                	mov    (%eax),%al
  8018f5:	0f be c0             	movsbl %al,%eax
  8018f8:	83 e8 57             	sub    $0x57,%eax
  8018fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8018fe:	eb 20                	jmp    801920 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801900:	8b 45 08             	mov    0x8(%ebp),%eax
  801903:	8a 00                	mov    (%eax),%al
  801905:	3c 40                	cmp    $0x40,%al
  801907:	7e 39                	jle    801942 <strtol+0x126>
  801909:	8b 45 08             	mov    0x8(%ebp),%eax
  80190c:	8a 00                	mov    (%eax),%al
  80190e:	3c 5a                	cmp    $0x5a,%al
  801910:	7f 30                	jg     801942 <strtol+0x126>
			dig = *s - 'A' + 10;
  801912:	8b 45 08             	mov    0x8(%ebp),%eax
  801915:	8a 00                	mov    (%eax),%al
  801917:	0f be c0             	movsbl %al,%eax
  80191a:	83 e8 37             	sub    $0x37,%eax
  80191d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801920:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801923:	3b 45 10             	cmp    0x10(%ebp),%eax
  801926:	7d 19                	jge    801941 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801928:	ff 45 08             	incl   0x8(%ebp)
  80192b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80192e:	0f af 45 10          	imul   0x10(%ebp),%eax
  801932:	89 c2                	mov    %eax,%edx
  801934:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801937:	01 d0                	add    %edx,%eax
  801939:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80193c:	e9 7b ff ff ff       	jmp    8018bc <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801941:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801942:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801946:	74 08                	je     801950 <strtol+0x134>
		*endptr = (char *) s;
  801948:	8b 45 0c             	mov    0xc(%ebp),%eax
  80194b:	8b 55 08             	mov    0x8(%ebp),%edx
  80194e:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801950:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801954:	74 07                	je     80195d <strtol+0x141>
  801956:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801959:	f7 d8                	neg    %eax
  80195b:	eb 03                	jmp    801960 <strtol+0x144>
  80195d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801960:	c9                   	leave  
  801961:	c3                   	ret    

00801962 <ltostr>:

void
ltostr(long value, char *str)
{
  801962:	55                   	push   %ebp
  801963:	89 e5                	mov    %esp,%ebp
  801965:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801968:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80196f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801976:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80197a:	79 13                	jns    80198f <ltostr+0x2d>
	{
		neg = 1;
  80197c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801983:	8b 45 0c             	mov    0xc(%ebp),%eax
  801986:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801989:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80198c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80198f:	8b 45 08             	mov    0x8(%ebp),%eax
  801992:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801997:	99                   	cltd   
  801998:	f7 f9                	idiv   %ecx
  80199a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80199d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019a0:	8d 50 01             	lea    0x1(%eax),%edx
  8019a3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8019a6:	89 c2                	mov    %eax,%edx
  8019a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019ab:	01 d0                	add    %edx,%eax
  8019ad:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8019b0:	83 c2 30             	add    $0x30,%edx
  8019b3:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8019b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019b8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8019bd:	f7 e9                	imul   %ecx
  8019bf:	c1 fa 02             	sar    $0x2,%edx
  8019c2:	89 c8                	mov    %ecx,%eax
  8019c4:	c1 f8 1f             	sar    $0x1f,%eax
  8019c7:	29 c2                	sub    %eax,%edx
  8019c9:	89 d0                	mov    %edx,%eax
  8019cb:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8019ce:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019d1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8019d6:	f7 e9                	imul   %ecx
  8019d8:	c1 fa 02             	sar    $0x2,%edx
  8019db:	89 c8                	mov    %ecx,%eax
  8019dd:	c1 f8 1f             	sar    $0x1f,%eax
  8019e0:	29 c2                	sub    %eax,%edx
  8019e2:	89 d0                	mov    %edx,%eax
  8019e4:	c1 e0 02             	shl    $0x2,%eax
  8019e7:	01 d0                	add    %edx,%eax
  8019e9:	01 c0                	add    %eax,%eax
  8019eb:	29 c1                	sub    %eax,%ecx
  8019ed:	89 ca                	mov    %ecx,%edx
  8019ef:	85 d2                	test   %edx,%edx
  8019f1:	75 9c                	jne    80198f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8019f3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8019fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019fd:	48                   	dec    %eax
  8019fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801a01:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801a05:	74 3d                	je     801a44 <ltostr+0xe2>
		start = 1 ;
  801a07:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801a0e:	eb 34                	jmp    801a44 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801a10:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a13:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a16:	01 d0                	add    %edx,%eax
  801a18:	8a 00                	mov    (%eax),%al
  801a1a:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801a1d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a20:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a23:	01 c2                	add    %eax,%edx
  801a25:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801a28:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a2b:	01 c8                	add    %ecx,%eax
  801a2d:	8a 00                	mov    (%eax),%al
  801a2f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801a31:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a34:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a37:	01 c2                	add    %eax,%edx
  801a39:	8a 45 eb             	mov    -0x15(%ebp),%al
  801a3c:	88 02                	mov    %al,(%edx)
		start++ ;
  801a3e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801a41:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801a44:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a47:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a4a:	7c c4                	jl     801a10 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801a4c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801a4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a52:	01 d0                	add    %edx,%eax
  801a54:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801a57:	90                   	nop
  801a58:	c9                   	leave  
  801a59:	c3                   	ret    

00801a5a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801a5a:	55                   	push   %ebp
  801a5b:	89 e5                	mov    %esp,%ebp
  801a5d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801a60:	ff 75 08             	pushl  0x8(%ebp)
  801a63:	e8 54 fa ff ff       	call   8014bc <strlen>
  801a68:	83 c4 04             	add    $0x4,%esp
  801a6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801a6e:	ff 75 0c             	pushl  0xc(%ebp)
  801a71:	e8 46 fa ff ff       	call   8014bc <strlen>
  801a76:	83 c4 04             	add    $0x4,%esp
  801a79:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801a7c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801a83:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801a8a:	eb 17                	jmp    801aa3 <strcconcat+0x49>
		final[s] = str1[s] ;
  801a8c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a8f:	8b 45 10             	mov    0x10(%ebp),%eax
  801a92:	01 c2                	add    %eax,%edx
  801a94:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a97:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9a:	01 c8                	add    %ecx,%eax
  801a9c:	8a 00                	mov    (%eax),%al
  801a9e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801aa0:	ff 45 fc             	incl   -0x4(%ebp)
  801aa3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801aa6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801aa9:	7c e1                	jl     801a8c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801aab:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801ab2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801ab9:	eb 1f                	jmp    801ada <strcconcat+0x80>
		final[s++] = str2[i] ;
  801abb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801abe:	8d 50 01             	lea    0x1(%eax),%edx
  801ac1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801ac4:	89 c2                	mov    %eax,%edx
  801ac6:	8b 45 10             	mov    0x10(%ebp),%eax
  801ac9:	01 c2                	add    %eax,%edx
  801acb:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801ace:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ad1:	01 c8                	add    %ecx,%eax
  801ad3:	8a 00                	mov    (%eax),%al
  801ad5:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801ad7:	ff 45 f8             	incl   -0x8(%ebp)
  801ada:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801add:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ae0:	7c d9                	jl     801abb <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801ae2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ae5:	8b 45 10             	mov    0x10(%ebp),%eax
  801ae8:	01 d0                	add    %edx,%eax
  801aea:	c6 00 00             	movb   $0x0,(%eax)
}
  801aed:	90                   	nop
  801aee:	c9                   	leave  
  801aef:	c3                   	ret    

00801af0 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801af0:	55                   	push   %ebp
  801af1:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801af3:	8b 45 14             	mov    0x14(%ebp),%eax
  801af6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801afc:	8b 45 14             	mov    0x14(%ebp),%eax
  801aff:	8b 00                	mov    (%eax),%eax
  801b01:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b08:	8b 45 10             	mov    0x10(%ebp),%eax
  801b0b:	01 d0                	add    %edx,%eax
  801b0d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801b13:	eb 0c                	jmp    801b21 <strsplit+0x31>
			*string++ = 0;
  801b15:	8b 45 08             	mov    0x8(%ebp),%eax
  801b18:	8d 50 01             	lea    0x1(%eax),%edx
  801b1b:	89 55 08             	mov    %edx,0x8(%ebp)
  801b1e:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801b21:	8b 45 08             	mov    0x8(%ebp),%eax
  801b24:	8a 00                	mov    (%eax),%al
  801b26:	84 c0                	test   %al,%al
  801b28:	74 18                	je     801b42 <strsplit+0x52>
  801b2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2d:	8a 00                	mov    (%eax),%al
  801b2f:	0f be c0             	movsbl %al,%eax
  801b32:	50                   	push   %eax
  801b33:	ff 75 0c             	pushl  0xc(%ebp)
  801b36:	e8 13 fb ff ff       	call   80164e <strchr>
  801b3b:	83 c4 08             	add    $0x8,%esp
  801b3e:	85 c0                	test   %eax,%eax
  801b40:	75 d3                	jne    801b15 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801b42:	8b 45 08             	mov    0x8(%ebp),%eax
  801b45:	8a 00                	mov    (%eax),%al
  801b47:	84 c0                	test   %al,%al
  801b49:	74 5a                	je     801ba5 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801b4b:	8b 45 14             	mov    0x14(%ebp),%eax
  801b4e:	8b 00                	mov    (%eax),%eax
  801b50:	83 f8 0f             	cmp    $0xf,%eax
  801b53:	75 07                	jne    801b5c <strsplit+0x6c>
		{
			return 0;
  801b55:	b8 00 00 00 00       	mov    $0x0,%eax
  801b5a:	eb 66                	jmp    801bc2 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801b5c:	8b 45 14             	mov    0x14(%ebp),%eax
  801b5f:	8b 00                	mov    (%eax),%eax
  801b61:	8d 48 01             	lea    0x1(%eax),%ecx
  801b64:	8b 55 14             	mov    0x14(%ebp),%edx
  801b67:	89 0a                	mov    %ecx,(%edx)
  801b69:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b70:	8b 45 10             	mov    0x10(%ebp),%eax
  801b73:	01 c2                	add    %eax,%edx
  801b75:	8b 45 08             	mov    0x8(%ebp),%eax
  801b78:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b7a:	eb 03                	jmp    801b7f <strsplit+0x8f>
			string++;
  801b7c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b82:	8a 00                	mov    (%eax),%al
  801b84:	84 c0                	test   %al,%al
  801b86:	74 8b                	je     801b13 <strsplit+0x23>
  801b88:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8b:	8a 00                	mov    (%eax),%al
  801b8d:	0f be c0             	movsbl %al,%eax
  801b90:	50                   	push   %eax
  801b91:	ff 75 0c             	pushl  0xc(%ebp)
  801b94:	e8 b5 fa ff ff       	call   80164e <strchr>
  801b99:	83 c4 08             	add    $0x8,%esp
  801b9c:	85 c0                	test   %eax,%eax
  801b9e:	74 dc                	je     801b7c <strsplit+0x8c>
			string++;
	}
  801ba0:	e9 6e ff ff ff       	jmp    801b13 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801ba5:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801ba6:	8b 45 14             	mov    0x14(%ebp),%eax
  801ba9:	8b 00                	mov    (%eax),%eax
  801bab:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801bb2:	8b 45 10             	mov    0x10(%ebp),%eax
  801bb5:	01 d0                	add    %edx,%eax
  801bb7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801bbd:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801bc2:	c9                   	leave  
  801bc3:	c3                   	ret    

00801bc4 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801bc4:	55                   	push   %ebp
  801bc5:	89 e5                	mov    %esp,%ebp
  801bc7:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801bca:	83 ec 04             	sub    $0x4,%esp
  801bcd:	68 84 2d 80 00       	push   $0x802d84
  801bd2:	6a 15                	push   $0x15
  801bd4:	68 a9 2d 80 00       	push   $0x802da9
  801bd9:	e8 9f ed ff ff       	call   80097d <_panic>

00801bde <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801bde:	55                   	push   %ebp
  801bdf:	89 e5                	mov    %esp,%ebp
  801be1:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801be4:	83 ec 04             	sub    $0x4,%esp
  801be7:	68 b8 2d 80 00       	push   $0x802db8
  801bec:	6a 2e                	push   $0x2e
  801bee:	68 a9 2d 80 00       	push   $0x802da9
  801bf3:	e8 85 ed ff ff       	call   80097d <_panic>

00801bf8 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801bf8:	55                   	push   %ebp
  801bf9:	89 e5                	mov    %esp,%ebp
  801bfb:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bfe:	83 ec 04             	sub    $0x4,%esp
  801c01:	68 dc 2d 80 00       	push   $0x802ddc
  801c06:	6a 4c                	push   $0x4c
  801c08:	68 a9 2d 80 00       	push   $0x802da9
  801c0d:	e8 6b ed ff ff       	call   80097d <_panic>

00801c12 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801c12:	55                   	push   %ebp
  801c13:	89 e5                	mov    %esp,%ebp
  801c15:	83 ec 18             	sub    $0x18,%esp
  801c18:	8b 45 10             	mov    0x10(%ebp),%eax
  801c1b:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801c1e:	83 ec 04             	sub    $0x4,%esp
  801c21:	68 dc 2d 80 00       	push   $0x802ddc
  801c26:	6a 57                	push   $0x57
  801c28:	68 a9 2d 80 00       	push   $0x802da9
  801c2d:	e8 4b ed ff ff       	call   80097d <_panic>

00801c32 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801c32:	55                   	push   %ebp
  801c33:	89 e5                	mov    %esp,%ebp
  801c35:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c38:	83 ec 04             	sub    $0x4,%esp
  801c3b:	68 dc 2d 80 00       	push   $0x802ddc
  801c40:	6a 5d                	push   $0x5d
  801c42:	68 a9 2d 80 00       	push   $0x802da9
  801c47:	e8 31 ed ff ff       	call   80097d <_panic>

00801c4c <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801c4c:	55                   	push   %ebp
  801c4d:	89 e5                	mov    %esp,%ebp
  801c4f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c52:	83 ec 04             	sub    $0x4,%esp
  801c55:	68 dc 2d 80 00       	push   $0x802ddc
  801c5a:	6a 63                	push   $0x63
  801c5c:	68 a9 2d 80 00       	push   $0x802da9
  801c61:	e8 17 ed ff ff       	call   80097d <_panic>

00801c66 <expand>:
}

void expand(uint32 newSize)
{
  801c66:	55                   	push   %ebp
  801c67:	89 e5                	mov    %esp,%ebp
  801c69:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c6c:	83 ec 04             	sub    $0x4,%esp
  801c6f:	68 dc 2d 80 00       	push   $0x802ddc
  801c74:	6a 68                	push   $0x68
  801c76:	68 a9 2d 80 00       	push   $0x802da9
  801c7b:	e8 fd ec ff ff       	call   80097d <_panic>

00801c80 <shrink>:
}
void shrink(uint32 newSize)
{
  801c80:	55                   	push   %ebp
  801c81:	89 e5                	mov    %esp,%ebp
  801c83:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c86:	83 ec 04             	sub    $0x4,%esp
  801c89:	68 dc 2d 80 00       	push   $0x802ddc
  801c8e:	6a 6c                	push   $0x6c
  801c90:	68 a9 2d 80 00       	push   $0x802da9
  801c95:	e8 e3 ec ff ff       	call   80097d <_panic>

00801c9a <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801c9a:	55                   	push   %ebp
  801c9b:	89 e5                	mov    %esp,%ebp
  801c9d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ca0:	83 ec 04             	sub    $0x4,%esp
  801ca3:	68 dc 2d 80 00       	push   $0x802ddc
  801ca8:	6a 71                	push   $0x71
  801caa:	68 a9 2d 80 00       	push   $0x802da9
  801caf:	e8 c9 ec ff ff       	call   80097d <_panic>

00801cb4 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801cb4:	55                   	push   %ebp
  801cb5:	89 e5                	mov    %esp,%ebp
  801cb7:	57                   	push   %edi
  801cb8:	56                   	push   %esi
  801cb9:	53                   	push   %ebx
  801cba:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801cbd:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cc3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801cc6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cc9:	8b 7d 18             	mov    0x18(%ebp),%edi
  801ccc:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801ccf:	cd 30                	int    $0x30
  801cd1:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801cd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801cd7:	83 c4 10             	add    $0x10,%esp
  801cda:	5b                   	pop    %ebx
  801cdb:	5e                   	pop    %esi
  801cdc:	5f                   	pop    %edi
  801cdd:	5d                   	pop    %ebp
  801cde:	c3                   	ret    

00801cdf <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801cdf:	55                   	push   %ebp
  801ce0:	89 e5                	mov    %esp,%ebp
  801ce2:	83 ec 04             	sub    $0x4,%esp
  801ce5:	8b 45 10             	mov    0x10(%ebp),%eax
  801ce8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801ceb:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801cef:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	52                   	push   %edx
  801cf7:	ff 75 0c             	pushl  0xc(%ebp)
  801cfa:	50                   	push   %eax
  801cfb:	6a 00                	push   $0x0
  801cfd:	e8 b2 ff ff ff       	call   801cb4 <syscall>
  801d02:	83 c4 18             	add    $0x18,%esp
}
  801d05:	90                   	nop
  801d06:	c9                   	leave  
  801d07:	c3                   	ret    

00801d08 <sys_cgetc>:

int
sys_cgetc(void)
{
  801d08:	55                   	push   %ebp
  801d09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	6a 00                	push   $0x0
  801d15:	6a 01                	push   $0x1
  801d17:	e8 98 ff ff ff       	call   801cb4 <syscall>
  801d1c:	83 c4 18             	add    $0x18,%esp
}
  801d1f:	c9                   	leave  
  801d20:	c3                   	ret    

00801d21 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801d21:	55                   	push   %ebp
  801d22:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801d24:	8b 45 08             	mov    0x8(%ebp),%eax
  801d27:	6a 00                	push   $0x0
  801d29:	6a 00                	push   $0x0
  801d2b:	6a 00                	push   $0x0
  801d2d:	6a 00                	push   $0x0
  801d2f:	50                   	push   %eax
  801d30:	6a 05                	push   $0x5
  801d32:	e8 7d ff ff ff       	call   801cb4 <syscall>
  801d37:	83 c4 18             	add    $0x18,%esp
}
  801d3a:	c9                   	leave  
  801d3b:	c3                   	ret    

00801d3c <sys_getenvid>:

int32 sys_getenvid(void)
{
  801d3c:	55                   	push   %ebp
  801d3d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	6a 00                	push   $0x0
  801d49:	6a 02                	push   $0x2
  801d4b:	e8 64 ff ff ff       	call   801cb4 <syscall>
  801d50:	83 c4 18             	add    $0x18,%esp
}
  801d53:	c9                   	leave  
  801d54:	c3                   	ret    

00801d55 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801d55:	55                   	push   %ebp
  801d56:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801d58:	6a 00                	push   $0x0
  801d5a:	6a 00                	push   $0x0
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 00                	push   $0x0
  801d60:	6a 00                	push   $0x0
  801d62:	6a 03                	push   $0x3
  801d64:	e8 4b ff ff ff       	call   801cb4 <syscall>
  801d69:	83 c4 18             	add    $0x18,%esp
}
  801d6c:	c9                   	leave  
  801d6d:	c3                   	ret    

00801d6e <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801d6e:	55                   	push   %ebp
  801d6f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801d71:	6a 00                	push   $0x0
  801d73:	6a 00                	push   $0x0
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 04                	push   $0x4
  801d7d:	e8 32 ff ff ff       	call   801cb4 <syscall>
  801d82:	83 c4 18             	add    $0x18,%esp
}
  801d85:	c9                   	leave  
  801d86:	c3                   	ret    

00801d87 <sys_env_exit>:


void sys_env_exit(void)
{
  801d87:	55                   	push   %ebp
  801d88:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801d8a:	6a 00                	push   $0x0
  801d8c:	6a 00                	push   $0x0
  801d8e:	6a 00                	push   $0x0
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	6a 06                	push   $0x6
  801d96:	e8 19 ff ff ff       	call   801cb4 <syscall>
  801d9b:	83 c4 18             	add    $0x18,%esp
}
  801d9e:	90                   	nop
  801d9f:	c9                   	leave  
  801da0:	c3                   	ret    

00801da1 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801da1:	55                   	push   %ebp
  801da2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801da4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801da7:	8b 45 08             	mov    0x8(%ebp),%eax
  801daa:	6a 00                	push   $0x0
  801dac:	6a 00                	push   $0x0
  801dae:	6a 00                	push   $0x0
  801db0:	52                   	push   %edx
  801db1:	50                   	push   %eax
  801db2:	6a 07                	push   $0x7
  801db4:	e8 fb fe ff ff       	call   801cb4 <syscall>
  801db9:	83 c4 18             	add    $0x18,%esp
}
  801dbc:	c9                   	leave  
  801dbd:	c3                   	ret    

00801dbe <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801dbe:	55                   	push   %ebp
  801dbf:	89 e5                	mov    %esp,%ebp
  801dc1:	56                   	push   %esi
  801dc2:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801dc3:	8b 75 18             	mov    0x18(%ebp),%esi
  801dc6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801dc9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801dcc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dcf:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd2:	56                   	push   %esi
  801dd3:	53                   	push   %ebx
  801dd4:	51                   	push   %ecx
  801dd5:	52                   	push   %edx
  801dd6:	50                   	push   %eax
  801dd7:	6a 08                	push   $0x8
  801dd9:	e8 d6 fe ff ff       	call   801cb4 <syscall>
  801dde:	83 c4 18             	add    $0x18,%esp
}
  801de1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801de4:	5b                   	pop    %ebx
  801de5:	5e                   	pop    %esi
  801de6:	5d                   	pop    %ebp
  801de7:	c3                   	ret    

00801de8 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801de8:	55                   	push   %ebp
  801de9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801deb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dee:	8b 45 08             	mov    0x8(%ebp),%eax
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	52                   	push   %edx
  801df8:	50                   	push   %eax
  801df9:	6a 09                	push   $0x9
  801dfb:	e8 b4 fe ff ff       	call   801cb4 <syscall>
  801e00:	83 c4 18             	add    $0x18,%esp
}
  801e03:	c9                   	leave  
  801e04:	c3                   	ret    

00801e05 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801e05:	55                   	push   %ebp
  801e06:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801e08:	6a 00                	push   $0x0
  801e0a:	6a 00                	push   $0x0
  801e0c:	6a 00                	push   $0x0
  801e0e:	ff 75 0c             	pushl  0xc(%ebp)
  801e11:	ff 75 08             	pushl  0x8(%ebp)
  801e14:	6a 0a                	push   $0xa
  801e16:	e8 99 fe ff ff       	call   801cb4 <syscall>
  801e1b:	83 c4 18             	add    $0x18,%esp
}
  801e1e:	c9                   	leave  
  801e1f:	c3                   	ret    

00801e20 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801e20:	55                   	push   %ebp
  801e21:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801e23:	6a 00                	push   $0x0
  801e25:	6a 00                	push   $0x0
  801e27:	6a 00                	push   $0x0
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 0b                	push   $0xb
  801e2f:	e8 80 fe ff ff       	call   801cb4 <syscall>
  801e34:	83 c4 18             	add    $0x18,%esp
}
  801e37:	c9                   	leave  
  801e38:	c3                   	ret    

00801e39 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801e39:	55                   	push   %ebp
  801e3a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 00                	push   $0x0
  801e40:	6a 00                	push   $0x0
  801e42:	6a 00                	push   $0x0
  801e44:	6a 00                	push   $0x0
  801e46:	6a 0c                	push   $0xc
  801e48:	e8 67 fe ff ff       	call   801cb4 <syscall>
  801e4d:	83 c4 18             	add    $0x18,%esp
}
  801e50:	c9                   	leave  
  801e51:	c3                   	ret    

00801e52 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801e52:	55                   	push   %ebp
  801e53:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801e55:	6a 00                	push   $0x0
  801e57:	6a 00                	push   $0x0
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 00                	push   $0x0
  801e5f:	6a 0d                	push   $0xd
  801e61:	e8 4e fe ff ff       	call   801cb4 <syscall>
  801e66:	83 c4 18             	add    $0x18,%esp
}
  801e69:	c9                   	leave  
  801e6a:	c3                   	ret    

00801e6b <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801e6b:	55                   	push   %ebp
  801e6c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801e6e:	6a 00                	push   $0x0
  801e70:	6a 00                	push   $0x0
  801e72:	6a 00                	push   $0x0
  801e74:	ff 75 0c             	pushl  0xc(%ebp)
  801e77:	ff 75 08             	pushl  0x8(%ebp)
  801e7a:	6a 11                	push   $0x11
  801e7c:	e8 33 fe ff ff       	call   801cb4 <syscall>
  801e81:	83 c4 18             	add    $0x18,%esp
	return;
  801e84:	90                   	nop
}
  801e85:	c9                   	leave  
  801e86:	c3                   	ret    

00801e87 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801e87:	55                   	push   %ebp
  801e88:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801e8a:	6a 00                	push   $0x0
  801e8c:	6a 00                	push   $0x0
  801e8e:	6a 00                	push   $0x0
  801e90:	ff 75 0c             	pushl  0xc(%ebp)
  801e93:	ff 75 08             	pushl  0x8(%ebp)
  801e96:	6a 12                	push   $0x12
  801e98:	e8 17 fe ff ff       	call   801cb4 <syscall>
  801e9d:	83 c4 18             	add    $0x18,%esp
	return ;
  801ea0:	90                   	nop
}
  801ea1:	c9                   	leave  
  801ea2:	c3                   	ret    

00801ea3 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801ea3:	55                   	push   %ebp
  801ea4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801ea6:	6a 00                	push   $0x0
  801ea8:	6a 00                	push   $0x0
  801eaa:	6a 00                	push   $0x0
  801eac:	6a 00                	push   $0x0
  801eae:	6a 00                	push   $0x0
  801eb0:	6a 0e                	push   $0xe
  801eb2:	e8 fd fd ff ff       	call   801cb4 <syscall>
  801eb7:	83 c4 18             	add    $0x18,%esp
}
  801eba:	c9                   	leave  
  801ebb:	c3                   	ret    

00801ebc <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801ebc:	55                   	push   %ebp
  801ebd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801ebf:	6a 00                	push   $0x0
  801ec1:	6a 00                	push   $0x0
  801ec3:	6a 00                	push   $0x0
  801ec5:	6a 00                	push   $0x0
  801ec7:	ff 75 08             	pushl  0x8(%ebp)
  801eca:	6a 0f                	push   $0xf
  801ecc:	e8 e3 fd ff ff       	call   801cb4 <syscall>
  801ed1:	83 c4 18             	add    $0x18,%esp
}
  801ed4:	c9                   	leave  
  801ed5:	c3                   	ret    

00801ed6 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801ed6:	55                   	push   %ebp
  801ed7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 10                	push   $0x10
  801ee5:	e8 ca fd ff ff       	call   801cb4 <syscall>
  801eea:	83 c4 18             	add    $0x18,%esp
}
  801eed:	90                   	nop
  801eee:	c9                   	leave  
  801eef:	c3                   	ret    

00801ef0 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801ef0:	55                   	push   %ebp
  801ef1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801ef3:	6a 00                	push   $0x0
  801ef5:	6a 00                	push   $0x0
  801ef7:	6a 00                	push   $0x0
  801ef9:	6a 00                	push   $0x0
  801efb:	6a 00                	push   $0x0
  801efd:	6a 14                	push   $0x14
  801eff:	e8 b0 fd ff ff       	call   801cb4 <syscall>
  801f04:	83 c4 18             	add    $0x18,%esp
}
  801f07:	90                   	nop
  801f08:	c9                   	leave  
  801f09:	c3                   	ret    

00801f0a <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801f0a:	55                   	push   %ebp
  801f0b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801f0d:	6a 00                	push   $0x0
  801f0f:	6a 00                	push   $0x0
  801f11:	6a 00                	push   $0x0
  801f13:	6a 00                	push   $0x0
  801f15:	6a 00                	push   $0x0
  801f17:	6a 15                	push   $0x15
  801f19:	e8 96 fd ff ff       	call   801cb4 <syscall>
  801f1e:	83 c4 18             	add    $0x18,%esp
}
  801f21:	90                   	nop
  801f22:	c9                   	leave  
  801f23:	c3                   	ret    

00801f24 <sys_cputc>:


void
sys_cputc(const char c)
{
  801f24:	55                   	push   %ebp
  801f25:	89 e5                	mov    %esp,%ebp
  801f27:	83 ec 04             	sub    $0x4,%esp
  801f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801f30:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 00                	push   $0x0
  801f3c:	50                   	push   %eax
  801f3d:	6a 16                	push   $0x16
  801f3f:	e8 70 fd ff ff       	call   801cb4 <syscall>
  801f44:	83 c4 18             	add    $0x18,%esp
}
  801f47:	90                   	nop
  801f48:	c9                   	leave  
  801f49:	c3                   	ret    

00801f4a <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801f4a:	55                   	push   %ebp
  801f4b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 00                	push   $0x0
  801f51:	6a 00                	push   $0x0
  801f53:	6a 00                	push   $0x0
  801f55:	6a 00                	push   $0x0
  801f57:	6a 17                	push   $0x17
  801f59:	e8 56 fd ff ff       	call   801cb4 <syscall>
  801f5e:	83 c4 18             	add    $0x18,%esp
}
  801f61:	90                   	nop
  801f62:	c9                   	leave  
  801f63:	c3                   	ret    

00801f64 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801f64:	55                   	push   %ebp
  801f65:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801f67:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6a:	6a 00                	push   $0x0
  801f6c:	6a 00                	push   $0x0
  801f6e:	6a 00                	push   $0x0
  801f70:	ff 75 0c             	pushl  0xc(%ebp)
  801f73:	50                   	push   %eax
  801f74:	6a 18                	push   $0x18
  801f76:	e8 39 fd ff ff       	call   801cb4 <syscall>
  801f7b:	83 c4 18             	add    $0x18,%esp
}
  801f7e:	c9                   	leave  
  801f7f:	c3                   	ret    

00801f80 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801f80:	55                   	push   %ebp
  801f81:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f83:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f86:	8b 45 08             	mov    0x8(%ebp),%eax
  801f89:	6a 00                	push   $0x0
  801f8b:	6a 00                	push   $0x0
  801f8d:	6a 00                	push   $0x0
  801f8f:	52                   	push   %edx
  801f90:	50                   	push   %eax
  801f91:	6a 1b                	push   $0x1b
  801f93:	e8 1c fd ff ff       	call   801cb4 <syscall>
  801f98:	83 c4 18             	add    $0x18,%esp
}
  801f9b:	c9                   	leave  
  801f9c:	c3                   	ret    

00801f9d <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f9d:	55                   	push   %ebp
  801f9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801fa0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa6:	6a 00                	push   $0x0
  801fa8:	6a 00                	push   $0x0
  801faa:	6a 00                	push   $0x0
  801fac:	52                   	push   %edx
  801fad:	50                   	push   %eax
  801fae:	6a 19                	push   $0x19
  801fb0:	e8 ff fc ff ff       	call   801cb4 <syscall>
  801fb5:	83 c4 18             	add    $0x18,%esp
}
  801fb8:	90                   	nop
  801fb9:	c9                   	leave  
  801fba:	c3                   	ret    

00801fbb <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801fbb:	55                   	push   %ebp
  801fbc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801fbe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fc1:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc4:	6a 00                	push   $0x0
  801fc6:	6a 00                	push   $0x0
  801fc8:	6a 00                	push   $0x0
  801fca:	52                   	push   %edx
  801fcb:	50                   	push   %eax
  801fcc:	6a 1a                	push   $0x1a
  801fce:	e8 e1 fc ff ff       	call   801cb4 <syscall>
  801fd3:	83 c4 18             	add    $0x18,%esp
}
  801fd6:	90                   	nop
  801fd7:	c9                   	leave  
  801fd8:	c3                   	ret    

00801fd9 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801fd9:	55                   	push   %ebp
  801fda:	89 e5                	mov    %esp,%ebp
  801fdc:	83 ec 04             	sub    $0x4,%esp
  801fdf:	8b 45 10             	mov    0x10(%ebp),%eax
  801fe2:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801fe5:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801fe8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801fec:	8b 45 08             	mov    0x8(%ebp),%eax
  801fef:	6a 00                	push   $0x0
  801ff1:	51                   	push   %ecx
  801ff2:	52                   	push   %edx
  801ff3:	ff 75 0c             	pushl  0xc(%ebp)
  801ff6:	50                   	push   %eax
  801ff7:	6a 1c                	push   $0x1c
  801ff9:	e8 b6 fc ff ff       	call   801cb4 <syscall>
  801ffe:	83 c4 18             	add    $0x18,%esp
}
  802001:	c9                   	leave  
  802002:	c3                   	ret    

00802003 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802003:	55                   	push   %ebp
  802004:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802006:	8b 55 0c             	mov    0xc(%ebp),%edx
  802009:	8b 45 08             	mov    0x8(%ebp),%eax
  80200c:	6a 00                	push   $0x0
  80200e:	6a 00                	push   $0x0
  802010:	6a 00                	push   $0x0
  802012:	52                   	push   %edx
  802013:	50                   	push   %eax
  802014:	6a 1d                	push   $0x1d
  802016:	e8 99 fc ff ff       	call   801cb4 <syscall>
  80201b:	83 c4 18             	add    $0x18,%esp
}
  80201e:	c9                   	leave  
  80201f:	c3                   	ret    

00802020 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802020:	55                   	push   %ebp
  802021:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802023:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802026:	8b 55 0c             	mov    0xc(%ebp),%edx
  802029:	8b 45 08             	mov    0x8(%ebp),%eax
  80202c:	6a 00                	push   $0x0
  80202e:	6a 00                	push   $0x0
  802030:	51                   	push   %ecx
  802031:	52                   	push   %edx
  802032:	50                   	push   %eax
  802033:	6a 1e                	push   $0x1e
  802035:	e8 7a fc ff ff       	call   801cb4 <syscall>
  80203a:	83 c4 18             	add    $0x18,%esp
}
  80203d:	c9                   	leave  
  80203e:	c3                   	ret    

0080203f <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80203f:	55                   	push   %ebp
  802040:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802042:	8b 55 0c             	mov    0xc(%ebp),%edx
  802045:	8b 45 08             	mov    0x8(%ebp),%eax
  802048:	6a 00                	push   $0x0
  80204a:	6a 00                	push   $0x0
  80204c:	6a 00                	push   $0x0
  80204e:	52                   	push   %edx
  80204f:	50                   	push   %eax
  802050:	6a 1f                	push   $0x1f
  802052:	e8 5d fc ff ff       	call   801cb4 <syscall>
  802057:	83 c4 18             	add    $0x18,%esp
}
  80205a:	c9                   	leave  
  80205b:	c3                   	ret    

0080205c <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80205c:	55                   	push   %ebp
  80205d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80205f:	6a 00                	push   $0x0
  802061:	6a 00                	push   $0x0
  802063:	6a 00                	push   $0x0
  802065:	6a 00                	push   $0x0
  802067:	6a 00                	push   $0x0
  802069:	6a 20                	push   $0x20
  80206b:	e8 44 fc ff ff       	call   801cb4 <syscall>
  802070:	83 c4 18             	add    $0x18,%esp
}
  802073:	c9                   	leave  
  802074:	c3                   	ret    

00802075 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802075:	55                   	push   %ebp
  802076:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802078:	8b 45 08             	mov    0x8(%ebp),%eax
  80207b:	6a 00                	push   $0x0
  80207d:	ff 75 14             	pushl  0x14(%ebp)
  802080:	ff 75 10             	pushl  0x10(%ebp)
  802083:	ff 75 0c             	pushl  0xc(%ebp)
  802086:	50                   	push   %eax
  802087:	6a 21                	push   $0x21
  802089:	e8 26 fc ff ff       	call   801cb4 <syscall>
  80208e:	83 c4 18             	add    $0x18,%esp
}
  802091:	c9                   	leave  
  802092:	c3                   	ret    

00802093 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  802093:	55                   	push   %ebp
  802094:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802096:	8b 45 08             	mov    0x8(%ebp),%eax
  802099:	6a 00                	push   $0x0
  80209b:	6a 00                	push   $0x0
  80209d:	6a 00                	push   $0x0
  80209f:	6a 00                	push   $0x0
  8020a1:	50                   	push   %eax
  8020a2:	6a 22                	push   $0x22
  8020a4:	e8 0b fc ff ff       	call   801cb4 <syscall>
  8020a9:	83 c4 18             	add    $0x18,%esp
}
  8020ac:	90                   	nop
  8020ad:	c9                   	leave  
  8020ae:	c3                   	ret    

008020af <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8020af:	55                   	push   %ebp
  8020b0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8020b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b5:	6a 00                	push   $0x0
  8020b7:	6a 00                	push   $0x0
  8020b9:	6a 00                	push   $0x0
  8020bb:	6a 00                	push   $0x0
  8020bd:	50                   	push   %eax
  8020be:	6a 23                	push   $0x23
  8020c0:	e8 ef fb ff ff       	call   801cb4 <syscall>
  8020c5:	83 c4 18             	add    $0x18,%esp
}
  8020c8:	90                   	nop
  8020c9:	c9                   	leave  
  8020ca:	c3                   	ret    

008020cb <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8020cb:	55                   	push   %ebp
  8020cc:	89 e5                	mov    %esp,%ebp
  8020ce:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8020d1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8020d4:	8d 50 04             	lea    0x4(%eax),%edx
  8020d7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8020da:	6a 00                	push   $0x0
  8020dc:	6a 00                	push   $0x0
  8020de:	6a 00                	push   $0x0
  8020e0:	52                   	push   %edx
  8020e1:	50                   	push   %eax
  8020e2:	6a 24                	push   $0x24
  8020e4:	e8 cb fb ff ff       	call   801cb4 <syscall>
  8020e9:	83 c4 18             	add    $0x18,%esp
	return result;
  8020ec:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8020ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020f2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8020f5:	89 01                	mov    %eax,(%ecx)
  8020f7:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8020fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8020fd:	c9                   	leave  
  8020fe:	c2 04 00             	ret    $0x4

00802101 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802101:	55                   	push   %ebp
  802102:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802104:	6a 00                	push   $0x0
  802106:	6a 00                	push   $0x0
  802108:	ff 75 10             	pushl  0x10(%ebp)
  80210b:	ff 75 0c             	pushl  0xc(%ebp)
  80210e:	ff 75 08             	pushl  0x8(%ebp)
  802111:	6a 13                	push   $0x13
  802113:	e8 9c fb ff ff       	call   801cb4 <syscall>
  802118:	83 c4 18             	add    $0x18,%esp
	return ;
  80211b:	90                   	nop
}
  80211c:	c9                   	leave  
  80211d:	c3                   	ret    

0080211e <sys_rcr2>:
uint32 sys_rcr2()
{
  80211e:	55                   	push   %ebp
  80211f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802121:	6a 00                	push   $0x0
  802123:	6a 00                	push   $0x0
  802125:	6a 00                	push   $0x0
  802127:	6a 00                	push   $0x0
  802129:	6a 00                	push   $0x0
  80212b:	6a 25                	push   $0x25
  80212d:	e8 82 fb ff ff       	call   801cb4 <syscall>
  802132:	83 c4 18             	add    $0x18,%esp
}
  802135:	c9                   	leave  
  802136:	c3                   	ret    

00802137 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802137:	55                   	push   %ebp
  802138:	89 e5                	mov    %esp,%ebp
  80213a:	83 ec 04             	sub    $0x4,%esp
  80213d:	8b 45 08             	mov    0x8(%ebp),%eax
  802140:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802143:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802147:	6a 00                	push   $0x0
  802149:	6a 00                	push   $0x0
  80214b:	6a 00                	push   $0x0
  80214d:	6a 00                	push   $0x0
  80214f:	50                   	push   %eax
  802150:	6a 26                	push   $0x26
  802152:	e8 5d fb ff ff       	call   801cb4 <syscall>
  802157:	83 c4 18             	add    $0x18,%esp
	return ;
  80215a:	90                   	nop
}
  80215b:	c9                   	leave  
  80215c:	c3                   	ret    

0080215d <rsttst>:
void rsttst()
{
  80215d:	55                   	push   %ebp
  80215e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802160:	6a 00                	push   $0x0
  802162:	6a 00                	push   $0x0
  802164:	6a 00                	push   $0x0
  802166:	6a 00                	push   $0x0
  802168:	6a 00                	push   $0x0
  80216a:	6a 28                	push   $0x28
  80216c:	e8 43 fb ff ff       	call   801cb4 <syscall>
  802171:	83 c4 18             	add    $0x18,%esp
	return ;
  802174:	90                   	nop
}
  802175:	c9                   	leave  
  802176:	c3                   	ret    

00802177 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802177:	55                   	push   %ebp
  802178:	89 e5                	mov    %esp,%ebp
  80217a:	83 ec 04             	sub    $0x4,%esp
  80217d:	8b 45 14             	mov    0x14(%ebp),%eax
  802180:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802183:	8b 55 18             	mov    0x18(%ebp),%edx
  802186:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80218a:	52                   	push   %edx
  80218b:	50                   	push   %eax
  80218c:	ff 75 10             	pushl  0x10(%ebp)
  80218f:	ff 75 0c             	pushl  0xc(%ebp)
  802192:	ff 75 08             	pushl  0x8(%ebp)
  802195:	6a 27                	push   $0x27
  802197:	e8 18 fb ff ff       	call   801cb4 <syscall>
  80219c:	83 c4 18             	add    $0x18,%esp
	return ;
  80219f:	90                   	nop
}
  8021a0:	c9                   	leave  
  8021a1:	c3                   	ret    

008021a2 <chktst>:
void chktst(uint32 n)
{
  8021a2:	55                   	push   %ebp
  8021a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8021a5:	6a 00                	push   $0x0
  8021a7:	6a 00                	push   $0x0
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	ff 75 08             	pushl  0x8(%ebp)
  8021b0:	6a 29                	push   $0x29
  8021b2:	e8 fd fa ff ff       	call   801cb4 <syscall>
  8021b7:	83 c4 18             	add    $0x18,%esp
	return ;
  8021ba:	90                   	nop
}
  8021bb:	c9                   	leave  
  8021bc:	c3                   	ret    

008021bd <inctst>:

void inctst()
{
  8021bd:	55                   	push   %ebp
  8021be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8021c0:	6a 00                	push   $0x0
  8021c2:	6a 00                	push   $0x0
  8021c4:	6a 00                	push   $0x0
  8021c6:	6a 00                	push   $0x0
  8021c8:	6a 00                	push   $0x0
  8021ca:	6a 2a                	push   $0x2a
  8021cc:	e8 e3 fa ff ff       	call   801cb4 <syscall>
  8021d1:	83 c4 18             	add    $0x18,%esp
	return ;
  8021d4:	90                   	nop
}
  8021d5:	c9                   	leave  
  8021d6:	c3                   	ret    

008021d7 <gettst>:
uint32 gettst()
{
  8021d7:	55                   	push   %ebp
  8021d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8021da:	6a 00                	push   $0x0
  8021dc:	6a 00                	push   $0x0
  8021de:	6a 00                	push   $0x0
  8021e0:	6a 00                	push   $0x0
  8021e2:	6a 00                	push   $0x0
  8021e4:	6a 2b                	push   $0x2b
  8021e6:	e8 c9 fa ff ff       	call   801cb4 <syscall>
  8021eb:	83 c4 18             	add    $0x18,%esp
}
  8021ee:	c9                   	leave  
  8021ef:	c3                   	ret    

008021f0 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8021f0:	55                   	push   %ebp
  8021f1:	89 e5                	mov    %esp,%ebp
  8021f3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021f6:	6a 00                	push   $0x0
  8021f8:	6a 00                	push   $0x0
  8021fa:	6a 00                	push   $0x0
  8021fc:	6a 00                	push   $0x0
  8021fe:	6a 00                	push   $0x0
  802200:	6a 2c                	push   $0x2c
  802202:	e8 ad fa ff ff       	call   801cb4 <syscall>
  802207:	83 c4 18             	add    $0x18,%esp
  80220a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80220d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802211:	75 07                	jne    80221a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802213:	b8 01 00 00 00       	mov    $0x1,%eax
  802218:	eb 05                	jmp    80221f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80221a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80221f:	c9                   	leave  
  802220:	c3                   	ret    

00802221 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802221:	55                   	push   %ebp
  802222:	89 e5                	mov    %esp,%ebp
  802224:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802227:	6a 00                	push   $0x0
  802229:	6a 00                	push   $0x0
  80222b:	6a 00                	push   $0x0
  80222d:	6a 00                	push   $0x0
  80222f:	6a 00                	push   $0x0
  802231:	6a 2c                	push   $0x2c
  802233:	e8 7c fa ff ff       	call   801cb4 <syscall>
  802238:	83 c4 18             	add    $0x18,%esp
  80223b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80223e:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802242:	75 07                	jne    80224b <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802244:	b8 01 00 00 00       	mov    $0x1,%eax
  802249:	eb 05                	jmp    802250 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80224b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802250:	c9                   	leave  
  802251:	c3                   	ret    

00802252 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802252:	55                   	push   %ebp
  802253:	89 e5                	mov    %esp,%ebp
  802255:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802258:	6a 00                	push   $0x0
  80225a:	6a 00                	push   $0x0
  80225c:	6a 00                	push   $0x0
  80225e:	6a 00                	push   $0x0
  802260:	6a 00                	push   $0x0
  802262:	6a 2c                	push   $0x2c
  802264:	e8 4b fa ff ff       	call   801cb4 <syscall>
  802269:	83 c4 18             	add    $0x18,%esp
  80226c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80226f:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802273:	75 07                	jne    80227c <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802275:	b8 01 00 00 00       	mov    $0x1,%eax
  80227a:	eb 05                	jmp    802281 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80227c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802281:	c9                   	leave  
  802282:	c3                   	ret    

00802283 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802283:	55                   	push   %ebp
  802284:	89 e5                	mov    %esp,%ebp
  802286:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802289:	6a 00                	push   $0x0
  80228b:	6a 00                	push   $0x0
  80228d:	6a 00                	push   $0x0
  80228f:	6a 00                	push   $0x0
  802291:	6a 00                	push   $0x0
  802293:	6a 2c                	push   $0x2c
  802295:	e8 1a fa ff ff       	call   801cb4 <syscall>
  80229a:	83 c4 18             	add    $0x18,%esp
  80229d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8022a0:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8022a4:	75 07                	jne    8022ad <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8022a6:	b8 01 00 00 00       	mov    $0x1,%eax
  8022ab:	eb 05                	jmp    8022b2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8022ad:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022b2:	c9                   	leave  
  8022b3:	c3                   	ret    

008022b4 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8022b4:	55                   	push   %ebp
  8022b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8022b7:	6a 00                	push   $0x0
  8022b9:	6a 00                	push   $0x0
  8022bb:	6a 00                	push   $0x0
  8022bd:	6a 00                	push   $0x0
  8022bf:	ff 75 08             	pushl  0x8(%ebp)
  8022c2:	6a 2d                	push   $0x2d
  8022c4:	e8 eb f9 ff ff       	call   801cb4 <syscall>
  8022c9:	83 c4 18             	add    $0x18,%esp
	return ;
  8022cc:	90                   	nop
}
  8022cd:	c9                   	leave  
  8022ce:	c3                   	ret    

008022cf <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8022cf:	55                   	push   %ebp
  8022d0:	89 e5                	mov    %esp,%ebp
  8022d2:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8022d3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8022d6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8022d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8022df:	6a 00                	push   $0x0
  8022e1:	53                   	push   %ebx
  8022e2:	51                   	push   %ecx
  8022e3:	52                   	push   %edx
  8022e4:	50                   	push   %eax
  8022e5:	6a 2e                	push   $0x2e
  8022e7:	e8 c8 f9 ff ff       	call   801cb4 <syscall>
  8022ec:	83 c4 18             	add    $0x18,%esp
}
  8022ef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8022f2:	c9                   	leave  
  8022f3:	c3                   	ret    

008022f4 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8022f4:	55                   	push   %ebp
  8022f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8022f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8022fd:	6a 00                	push   $0x0
  8022ff:	6a 00                	push   $0x0
  802301:	6a 00                	push   $0x0
  802303:	52                   	push   %edx
  802304:	50                   	push   %eax
  802305:	6a 2f                	push   $0x2f
  802307:	e8 a8 f9 ff ff       	call   801cb4 <syscall>
  80230c:	83 c4 18             	add    $0x18,%esp
}
  80230f:	c9                   	leave  
  802310:	c3                   	ret    

00802311 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  802311:	55                   	push   %ebp
  802312:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  802314:	6a 00                	push   $0x0
  802316:	6a 00                	push   $0x0
  802318:	6a 00                	push   $0x0
  80231a:	ff 75 0c             	pushl  0xc(%ebp)
  80231d:	ff 75 08             	pushl  0x8(%ebp)
  802320:	6a 30                	push   $0x30
  802322:	e8 8d f9 ff ff       	call   801cb4 <syscall>
  802327:	83 c4 18             	add    $0x18,%esp
	return ;
  80232a:	90                   	nop
}
  80232b:	c9                   	leave  
  80232c:	c3                   	ret    
  80232d:	66 90                	xchg   %ax,%ax
  80232f:	90                   	nop

00802330 <__udivdi3>:
  802330:	55                   	push   %ebp
  802331:	57                   	push   %edi
  802332:	56                   	push   %esi
  802333:	53                   	push   %ebx
  802334:	83 ec 1c             	sub    $0x1c,%esp
  802337:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80233b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80233f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802343:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802347:	89 ca                	mov    %ecx,%edx
  802349:	89 f8                	mov    %edi,%eax
  80234b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80234f:	85 f6                	test   %esi,%esi
  802351:	75 2d                	jne    802380 <__udivdi3+0x50>
  802353:	39 cf                	cmp    %ecx,%edi
  802355:	77 65                	ja     8023bc <__udivdi3+0x8c>
  802357:	89 fd                	mov    %edi,%ebp
  802359:	85 ff                	test   %edi,%edi
  80235b:	75 0b                	jne    802368 <__udivdi3+0x38>
  80235d:	b8 01 00 00 00       	mov    $0x1,%eax
  802362:	31 d2                	xor    %edx,%edx
  802364:	f7 f7                	div    %edi
  802366:	89 c5                	mov    %eax,%ebp
  802368:	31 d2                	xor    %edx,%edx
  80236a:	89 c8                	mov    %ecx,%eax
  80236c:	f7 f5                	div    %ebp
  80236e:	89 c1                	mov    %eax,%ecx
  802370:	89 d8                	mov    %ebx,%eax
  802372:	f7 f5                	div    %ebp
  802374:	89 cf                	mov    %ecx,%edi
  802376:	89 fa                	mov    %edi,%edx
  802378:	83 c4 1c             	add    $0x1c,%esp
  80237b:	5b                   	pop    %ebx
  80237c:	5e                   	pop    %esi
  80237d:	5f                   	pop    %edi
  80237e:	5d                   	pop    %ebp
  80237f:	c3                   	ret    
  802380:	39 ce                	cmp    %ecx,%esi
  802382:	77 28                	ja     8023ac <__udivdi3+0x7c>
  802384:	0f bd fe             	bsr    %esi,%edi
  802387:	83 f7 1f             	xor    $0x1f,%edi
  80238a:	75 40                	jne    8023cc <__udivdi3+0x9c>
  80238c:	39 ce                	cmp    %ecx,%esi
  80238e:	72 0a                	jb     80239a <__udivdi3+0x6a>
  802390:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802394:	0f 87 9e 00 00 00    	ja     802438 <__udivdi3+0x108>
  80239a:	b8 01 00 00 00       	mov    $0x1,%eax
  80239f:	89 fa                	mov    %edi,%edx
  8023a1:	83 c4 1c             	add    $0x1c,%esp
  8023a4:	5b                   	pop    %ebx
  8023a5:	5e                   	pop    %esi
  8023a6:	5f                   	pop    %edi
  8023a7:	5d                   	pop    %ebp
  8023a8:	c3                   	ret    
  8023a9:	8d 76 00             	lea    0x0(%esi),%esi
  8023ac:	31 ff                	xor    %edi,%edi
  8023ae:	31 c0                	xor    %eax,%eax
  8023b0:	89 fa                	mov    %edi,%edx
  8023b2:	83 c4 1c             	add    $0x1c,%esp
  8023b5:	5b                   	pop    %ebx
  8023b6:	5e                   	pop    %esi
  8023b7:	5f                   	pop    %edi
  8023b8:	5d                   	pop    %ebp
  8023b9:	c3                   	ret    
  8023ba:	66 90                	xchg   %ax,%ax
  8023bc:	89 d8                	mov    %ebx,%eax
  8023be:	f7 f7                	div    %edi
  8023c0:	31 ff                	xor    %edi,%edi
  8023c2:	89 fa                	mov    %edi,%edx
  8023c4:	83 c4 1c             	add    $0x1c,%esp
  8023c7:	5b                   	pop    %ebx
  8023c8:	5e                   	pop    %esi
  8023c9:	5f                   	pop    %edi
  8023ca:	5d                   	pop    %ebp
  8023cb:	c3                   	ret    
  8023cc:	bd 20 00 00 00       	mov    $0x20,%ebp
  8023d1:	89 eb                	mov    %ebp,%ebx
  8023d3:	29 fb                	sub    %edi,%ebx
  8023d5:	89 f9                	mov    %edi,%ecx
  8023d7:	d3 e6                	shl    %cl,%esi
  8023d9:	89 c5                	mov    %eax,%ebp
  8023db:	88 d9                	mov    %bl,%cl
  8023dd:	d3 ed                	shr    %cl,%ebp
  8023df:	89 e9                	mov    %ebp,%ecx
  8023e1:	09 f1                	or     %esi,%ecx
  8023e3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8023e7:	89 f9                	mov    %edi,%ecx
  8023e9:	d3 e0                	shl    %cl,%eax
  8023eb:	89 c5                	mov    %eax,%ebp
  8023ed:	89 d6                	mov    %edx,%esi
  8023ef:	88 d9                	mov    %bl,%cl
  8023f1:	d3 ee                	shr    %cl,%esi
  8023f3:	89 f9                	mov    %edi,%ecx
  8023f5:	d3 e2                	shl    %cl,%edx
  8023f7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023fb:	88 d9                	mov    %bl,%cl
  8023fd:	d3 e8                	shr    %cl,%eax
  8023ff:	09 c2                	or     %eax,%edx
  802401:	89 d0                	mov    %edx,%eax
  802403:	89 f2                	mov    %esi,%edx
  802405:	f7 74 24 0c          	divl   0xc(%esp)
  802409:	89 d6                	mov    %edx,%esi
  80240b:	89 c3                	mov    %eax,%ebx
  80240d:	f7 e5                	mul    %ebp
  80240f:	39 d6                	cmp    %edx,%esi
  802411:	72 19                	jb     80242c <__udivdi3+0xfc>
  802413:	74 0b                	je     802420 <__udivdi3+0xf0>
  802415:	89 d8                	mov    %ebx,%eax
  802417:	31 ff                	xor    %edi,%edi
  802419:	e9 58 ff ff ff       	jmp    802376 <__udivdi3+0x46>
  80241e:	66 90                	xchg   %ax,%ax
  802420:	8b 54 24 08          	mov    0x8(%esp),%edx
  802424:	89 f9                	mov    %edi,%ecx
  802426:	d3 e2                	shl    %cl,%edx
  802428:	39 c2                	cmp    %eax,%edx
  80242a:	73 e9                	jae    802415 <__udivdi3+0xe5>
  80242c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80242f:	31 ff                	xor    %edi,%edi
  802431:	e9 40 ff ff ff       	jmp    802376 <__udivdi3+0x46>
  802436:	66 90                	xchg   %ax,%ax
  802438:	31 c0                	xor    %eax,%eax
  80243a:	e9 37 ff ff ff       	jmp    802376 <__udivdi3+0x46>
  80243f:	90                   	nop

00802440 <__umoddi3>:
  802440:	55                   	push   %ebp
  802441:	57                   	push   %edi
  802442:	56                   	push   %esi
  802443:	53                   	push   %ebx
  802444:	83 ec 1c             	sub    $0x1c,%esp
  802447:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80244b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80244f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802453:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802457:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80245b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80245f:	89 f3                	mov    %esi,%ebx
  802461:	89 fa                	mov    %edi,%edx
  802463:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802467:	89 34 24             	mov    %esi,(%esp)
  80246a:	85 c0                	test   %eax,%eax
  80246c:	75 1a                	jne    802488 <__umoddi3+0x48>
  80246e:	39 f7                	cmp    %esi,%edi
  802470:	0f 86 a2 00 00 00    	jbe    802518 <__umoddi3+0xd8>
  802476:	89 c8                	mov    %ecx,%eax
  802478:	89 f2                	mov    %esi,%edx
  80247a:	f7 f7                	div    %edi
  80247c:	89 d0                	mov    %edx,%eax
  80247e:	31 d2                	xor    %edx,%edx
  802480:	83 c4 1c             	add    $0x1c,%esp
  802483:	5b                   	pop    %ebx
  802484:	5e                   	pop    %esi
  802485:	5f                   	pop    %edi
  802486:	5d                   	pop    %ebp
  802487:	c3                   	ret    
  802488:	39 f0                	cmp    %esi,%eax
  80248a:	0f 87 ac 00 00 00    	ja     80253c <__umoddi3+0xfc>
  802490:	0f bd e8             	bsr    %eax,%ebp
  802493:	83 f5 1f             	xor    $0x1f,%ebp
  802496:	0f 84 ac 00 00 00    	je     802548 <__umoddi3+0x108>
  80249c:	bf 20 00 00 00       	mov    $0x20,%edi
  8024a1:	29 ef                	sub    %ebp,%edi
  8024a3:	89 fe                	mov    %edi,%esi
  8024a5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8024a9:	89 e9                	mov    %ebp,%ecx
  8024ab:	d3 e0                	shl    %cl,%eax
  8024ad:	89 d7                	mov    %edx,%edi
  8024af:	89 f1                	mov    %esi,%ecx
  8024b1:	d3 ef                	shr    %cl,%edi
  8024b3:	09 c7                	or     %eax,%edi
  8024b5:	89 e9                	mov    %ebp,%ecx
  8024b7:	d3 e2                	shl    %cl,%edx
  8024b9:	89 14 24             	mov    %edx,(%esp)
  8024bc:	89 d8                	mov    %ebx,%eax
  8024be:	d3 e0                	shl    %cl,%eax
  8024c0:	89 c2                	mov    %eax,%edx
  8024c2:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024c6:	d3 e0                	shl    %cl,%eax
  8024c8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8024cc:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024d0:	89 f1                	mov    %esi,%ecx
  8024d2:	d3 e8                	shr    %cl,%eax
  8024d4:	09 d0                	or     %edx,%eax
  8024d6:	d3 eb                	shr    %cl,%ebx
  8024d8:	89 da                	mov    %ebx,%edx
  8024da:	f7 f7                	div    %edi
  8024dc:	89 d3                	mov    %edx,%ebx
  8024de:	f7 24 24             	mull   (%esp)
  8024e1:	89 c6                	mov    %eax,%esi
  8024e3:	89 d1                	mov    %edx,%ecx
  8024e5:	39 d3                	cmp    %edx,%ebx
  8024e7:	0f 82 87 00 00 00    	jb     802574 <__umoddi3+0x134>
  8024ed:	0f 84 91 00 00 00    	je     802584 <__umoddi3+0x144>
  8024f3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8024f7:	29 f2                	sub    %esi,%edx
  8024f9:	19 cb                	sbb    %ecx,%ebx
  8024fb:	89 d8                	mov    %ebx,%eax
  8024fd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802501:	d3 e0                	shl    %cl,%eax
  802503:	89 e9                	mov    %ebp,%ecx
  802505:	d3 ea                	shr    %cl,%edx
  802507:	09 d0                	or     %edx,%eax
  802509:	89 e9                	mov    %ebp,%ecx
  80250b:	d3 eb                	shr    %cl,%ebx
  80250d:	89 da                	mov    %ebx,%edx
  80250f:	83 c4 1c             	add    $0x1c,%esp
  802512:	5b                   	pop    %ebx
  802513:	5e                   	pop    %esi
  802514:	5f                   	pop    %edi
  802515:	5d                   	pop    %ebp
  802516:	c3                   	ret    
  802517:	90                   	nop
  802518:	89 fd                	mov    %edi,%ebp
  80251a:	85 ff                	test   %edi,%edi
  80251c:	75 0b                	jne    802529 <__umoddi3+0xe9>
  80251e:	b8 01 00 00 00       	mov    $0x1,%eax
  802523:	31 d2                	xor    %edx,%edx
  802525:	f7 f7                	div    %edi
  802527:	89 c5                	mov    %eax,%ebp
  802529:	89 f0                	mov    %esi,%eax
  80252b:	31 d2                	xor    %edx,%edx
  80252d:	f7 f5                	div    %ebp
  80252f:	89 c8                	mov    %ecx,%eax
  802531:	f7 f5                	div    %ebp
  802533:	89 d0                	mov    %edx,%eax
  802535:	e9 44 ff ff ff       	jmp    80247e <__umoddi3+0x3e>
  80253a:	66 90                	xchg   %ax,%ax
  80253c:	89 c8                	mov    %ecx,%eax
  80253e:	89 f2                	mov    %esi,%edx
  802540:	83 c4 1c             	add    $0x1c,%esp
  802543:	5b                   	pop    %ebx
  802544:	5e                   	pop    %esi
  802545:	5f                   	pop    %edi
  802546:	5d                   	pop    %ebp
  802547:	c3                   	ret    
  802548:	3b 04 24             	cmp    (%esp),%eax
  80254b:	72 06                	jb     802553 <__umoddi3+0x113>
  80254d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802551:	77 0f                	ja     802562 <__umoddi3+0x122>
  802553:	89 f2                	mov    %esi,%edx
  802555:	29 f9                	sub    %edi,%ecx
  802557:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80255b:	89 14 24             	mov    %edx,(%esp)
  80255e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802562:	8b 44 24 04          	mov    0x4(%esp),%eax
  802566:	8b 14 24             	mov    (%esp),%edx
  802569:	83 c4 1c             	add    $0x1c,%esp
  80256c:	5b                   	pop    %ebx
  80256d:	5e                   	pop    %esi
  80256e:	5f                   	pop    %edi
  80256f:	5d                   	pop    %ebp
  802570:	c3                   	ret    
  802571:	8d 76 00             	lea    0x0(%esi),%esi
  802574:	2b 04 24             	sub    (%esp),%eax
  802577:	19 fa                	sbb    %edi,%edx
  802579:	89 d1                	mov    %edx,%ecx
  80257b:	89 c6                	mov    %eax,%esi
  80257d:	e9 71 ff ff ff       	jmp    8024f3 <__umoddi3+0xb3>
  802582:	66 90                	xchg   %ax,%ax
  802584:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802588:	72 ea                	jb     802574 <__umoddi3+0x134>
  80258a:	89 d9                	mov    %ebx,%ecx
  80258c:	e9 62 ff ff ff       	jmp    8024f3 <__umoddi3+0xb3>
