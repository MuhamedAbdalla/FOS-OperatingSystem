
obj/user/quicksort:     file format elf32-i386


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
  800031:	e8 c2 05 00 00       	call   8005f8 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void QuickSort(int *Elements, int NumOfElements);
void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex);
uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 24 01 00 00    	sub    $0x124,%esp
	char Chose ;
	char Line[255] ;
	int Iteration = 0 ;
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800049:	e8 8f 1e 00 00       	call   801edd <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 a1 1e 00 00       	call   801ef6 <sys_calculate_modified_frames>
  800055:	01 d8                	add    %ebx,%eax
  800057:	89 45 f0             	mov    %eax,-0x10(%ebp)

		Iteration++ ;
  80005a:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();

			readline("Enter the number of elements: ", Line);
  80005d:	83 ec 08             	sub    $0x8,%esp
  800060:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800066:	50                   	push   %eax
  800067:	68 60 26 80 00       	push   $0x802660
  80006c:	e8 e8 0f 00 00       	call   801059 <readline>
  800071:	83 c4 10             	add    $0x10,%esp
			int NumOfElements = strtol(Line, NULL, 10) ;
  800074:	83 ec 04             	sub    $0x4,%esp
  800077:	6a 0a                	push   $0xa
  800079:	6a 00                	push   $0x0
  80007b:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800081:	50                   	push   %eax
  800082:	e8 38 15 00 00       	call   8015bf <strtol>
  800087:	83 c4 10             	add    $0x10,%esp
  80008a:	89 45 ec             	mov    %eax,-0x14(%ebp)
			int *Elements = malloc(sizeof(int) * NumOfElements) ;
  80008d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800090:	c1 e0 02             	shl    $0x2,%eax
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	50                   	push   %eax
  800097:	e8 cb 18 00 00       	call   801967 <malloc>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 45 e8             	mov    %eax,-0x18(%ebp)
			cprintf("Choose the initialization method:\n") ;
  8000a2:	83 ec 0c             	sub    $0xc,%esp
  8000a5:	68 80 26 80 00       	push   $0x802680
  8000aa:	e8 28 09 00 00       	call   8009d7 <cprintf>
  8000af:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	68 a3 26 80 00       	push   $0x8026a3
  8000ba:	e8 18 09 00 00       	call   8009d7 <cprintf>
  8000bf:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000c2:	83 ec 0c             	sub    $0xc,%esp
  8000c5:	68 b1 26 80 00       	push   $0x8026b1
  8000ca:	e8 08 09 00 00       	call   8009d7 <cprintf>
  8000cf:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\n");
  8000d2:	83 ec 0c             	sub    $0xc,%esp
  8000d5:	68 c0 26 80 00       	push   $0x8026c0
  8000da:	e8 f8 08 00 00       	call   8009d7 <cprintf>
  8000df:	83 c4 10             	add    $0x10,%esp
			do
			{
				cprintf("Select: ") ;
  8000e2:	83 ec 0c             	sub    $0xc,%esp
  8000e5:	68 d0 26 80 00       	push   $0x8026d0
  8000ea:	e8 e8 08 00 00       	call   8009d7 <cprintf>
  8000ef:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  8000f2:	e8 a9 04 00 00       	call   8005a0 <getchar>
  8000f7:	88 45 e7             	mov    %al,-0x19(%ebp)
				cputchar(Chose);
  8000fa:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  8000fe:	83 ec 0c             	sub    $0xc,%esp
  800101:	50                   	push   %eax
  800102:	e8 51 04 00 00       	call   800558 <cputchar>
  800107:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80010a:	83 ec 0c             	sub    $0xc,%esp
  80010d:	6a 0a                	push   $0xa
  80010f:	e8 44 04 00 00       	call   800558 <cputchar>
  800114:	83 c4 10             	add    $0x10,%esp
			} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800117:	80 7d e7 61          	cmpb   $0x61,-0x19(%ebp)
  80011b:	74 0c                	je     800129 <_main+0xf1>
  80011d:	80 7d e7 62          	cmpb   $0x62,-0x19(%ebp)
  800121:	74 06                	je     800129 <_main+0xf1>
  800123:	80 7d e7 63          	cmpb   $0x63,-0x19(%ebp)
  800127:	75 b9                	jne    8000e2 <_main+0xaa>

		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  800129:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  80012d:	83 f8 62             	cmp    $0x62,%eax
  800130:	74 1d                	je     80014f <_main+0x117>
  800132:	83 f8 63             	cmp    $0x63,%eax
  800135:	74 2b                	je     800162 <_main+0x12a>
  800137:	83 f8 61             	cmp    $0x61,%eax
  80013a:	75 39                	jne    800175 <_main+0x13d>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80013c:	83 ec 08             	sub    $0x8,%esp
  80013f:	ff 75 ec             	pushl  -0x14(%ebp)
  800142:	ff 75 e8             	pushl  -0x18(%ebp)
  800145:	e8 d6 02 00 00       	call   800420 <InitializeAscending>
  80014a:	83 c4 10             	add    $0x10,%esp
			break ;
  80014d:	eb 37                	jmp    800186 <_main+0x14e>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80014f:	83 ec 08             	sub    $0x8,%esp
  800152:	ff 75 ec             	pushl  -0x14(%ebp)
  800155:	ff 75 e8             	pushl  -0x18(%ebp)
  800158:	e8 f4 02 00 00       	call   800451 <InitializeDescending>
  80015d:	83 c4 10             	add    $0x10,%esp
			break ;
  800160:	eb 24                	jmp    800186 <_main+0x14e>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800162:	83 ec 08             	sub    $0x8,%esp
  800165:	ff 75 ec             	pushl  -0x14(%ebp)
  800168:	ff 75 e8             	pushl  -0x18(%ebp)
  80016b:	e8 16 03 00 00       	call   800486 <InitializeSemiRandom>
  800170:	83 c4 10             	add    $0x10,%esp
			break ;
  800173:	eb 11                	jmp    800186 <_main+0x14e>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800175:	83 ec 08             	sub    $0x8,%esp
  800178:	ff 75 ec             	pushl  -0x14(%ebp)
  80017b:	ff 75 e8             	pushl  -0x18(%ebp)
  80017e:	e8 03 03 00 00       	call   800486 <InitializeSemiRandom>
  800183:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  800186:	83 ec 08             	sub    $0x8,%esp
  800189:	ff 75 ec             	pushl  -0x14(%ebp)
  80018c:	ff 75 e8             	pushl  -0x18(%ebp)
  80018f:	e8 d1 00 00 00       	call   800265 <QuickSort>
  800194:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800197:	83 ec 08             	sub    $0x8,%esp
  80019a:	ff 75 ec             	pushl  -0x14(%ebp)
  80019d:	ff 75 e8             	pushl  -0x18(%ebp)
  8001a0:	e8 d1 01 00 00       	call   800376 <CheckSorted>
  8001a5:	83 c4 10             	add    $0x10,%esp
  8001a8:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001ab:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8001af:	75 14                	jne    8001c5 <_main+0x18d>
  8001b1:	83 ec 04             	sub    $0x4,%esp
  8001b4:	68 dc 26 80 00       	push   $0x8026dc
  8001b9:	6a 46                	push   $0x46
  8001bb:	68 fe 26 80 00       	push   $0x8026fe
  8001c0:	e8 5b 05 00 00       	call   800720 <_panic>
		else
		{ 
				cprintf("\n===============================================\n") ;
  8001c5:	83 ec 0c             	sub    $0xc,%esp
  8001c8:	68 10 27 80 00       	push   $0x802710
  8001cd:	e8 05 08 00 00       	call   8009d7 <cprintf>
  8001d2:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001d5:	83 ec 0c             	sub    $0xc,%esp
  8001d8:	68 44 27 80 00       	push   $0x802744
  8001dd:	e8 f5 07 00 00       	call   8009d7 <cprintf>
  8001e2:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  8001e5:	83 ec 0c             	sub    $0xc,%esp
  8001e8:	68 78 27 80 00       	push   $0x802778
  8001ed:	e8 e5 07 00 00       	call   8009d7 <cprintf>
  8001f2:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

			cprintf("Freeing the Heap...\n\n") ;
  8001f5:	83 ec 0c             	sub    $0xc,%esp
  8001f8:	68 aa 27 80 00       	push   $0x8027aa
  8001fd:	e8 d5 07 00 00       	call   8009d7 <cprintf>
  800202:	83 c4 10             	add    $0x10,%esp

			free(Elements) ;
  800205:	83 ec 0c             	sub    $0xc,%esp
  800208:	ff 75 e8             	pushl  -0x18(%ebp)
  80020b:	e8 1c 1a 00 00       	call   801c2c <free>
  800210:	83 c4 10             	add    $0x10,%esp


		///========================================================================
	//sys_disable_interrupt();
			cprintf("Do you want to repeat (y/n): ") ;
  800213:	83 ec 0c             	sub    $0xc,%esp
  800216:	68 c0 27 80 00       	push   $0x8027c0
  80021b:	e8 b7 07 00 00       	call   8009d7 <cprintf>
  800220:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800223:	e8 78 03 00 00       	call   8005a0 <getchar>
  800228:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  80022b:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  80022f:	83 ec 0c             	sub    $0xc,%esp
  800232:	50                   	push   %eax
  800233:	e8 20 03 00 00       	call   800558 <cputchar>
  800238:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80023b:	83 ec 0c             	sub    $0xc,%esp
  80023e:	6a 0a                	push   $0xa
  800240:	e8 13 03 00 00       	call   800558 <cputchar>
  800245:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800248:	83 ec 0c             	sub    $0xc,%esp
  80024b:	6a 0a                	push   $0xa
  80024d:	e8 06 03 00 00       	call   800558 <cputchar>
  800252:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();

	} while (Chose == 'y');
  800255:	80 7d e7 79          	cmpb   $0x79,-0x19(%ebp)
  800259:	0f 84 ea fd ff ff    	je     800049 <_main+0x11>

}
  80025f:	90                   	nop
  800260:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800263:	c9                   	leave  
  800264:	c3                   	ret    

00800265 <QuickSort>:

///Quick sort 
void QuickSort(int *Elements, int NumOfElements)
{
  800265:	55                   	push   %ebp
  800266:	89 e5                	mov    %esp,%ebp
  800268:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  80026b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80026e:	48                   	dec    %eax
  80026f:	50                   	push   %eax
  800270:	6a 00                	push   $0x0
  800272:	ff 75 0c             	pushl  0xc(%ebp)
  800275:	ff 75 08             	pushl  0x8(%ebp)
  800278:	e8 06 00 00 00       	call   800283 <QSort>
  80027d:	83 c4 10             	add    $0x10,%esp
}
  800280:	90                   	nop
  800281:	c9                   	leave  
  800282:	c3                   	ret    

00800283 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800283:	55                   	push   %ebp
  800284:	89 e5                	mov    %esp,%ebp
  800286:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  800289:	8b 45 10             	mov    0x10(%ebp),%eax
  80028c:	3b 45 14             	cmp    0x14(%ebp),%eax
  80028f:	0f 8d de 00 00 00    	jge    800373 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800295:	8b 45 10             	mov    0x10(%ebp),%eax
  800298:	40                   	inc    %eax
  800299:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80029c:	8b 45 14             	mov    0x14(%ebp),%eax
  80029f:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002a2:	e9 80 00 00 00       	jmp    800327 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8002a7:	ff 45 f4             	incl   -0xc(%ebp)
  8002aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002ad:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002b0:	7f 2b                	jg     8002dd <QSort+0x5a>
  8002b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8002b5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8002bf:	01 d0                	add    %edx,%eax
  8002c1:	8b 10                	mov    (%eax),%edx
  8002c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002c6:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d0:	01 c8                	add    %ecx,%eax
  8002d2:	8b 00                	mov    (%eax),%eax
  8002d4:	39 c2                	cmp    %eax,%edx
  8002d6:	7d cf                	jge    8002a7 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002d8:	eb 03                	jmp    8002dd <QSort+0x5a>
  8002da:	ff 4d f0             	decl   -0x10(%ebp)
  8002dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002e0:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002e3:	7e 26                	jle    80030b <QSort+0x88>
  8002e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f2:	01 d0                	add    %edx,%eax
  8002f4:	8b 10                	mov    (%eax),%edx
  8002f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002f9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800300:	8b 45 08             	mov    0x8(%ebp),%eax
  800303:	01 c8                	add    %ecx,%eax
  800305:	8b 00                	mov    (%eax),%eax
  800307:	39 c2                	cmp    %eax,%edx
  800309:	7e cf                	jle    8002da <QSort+0x57>

		if (i <= j)
  80030b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80030e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800311:	7f 14                	jg     800327 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800313:	83 ec 04             	sub    $0x4,%esp
  800316:	ff 75 f0             	pushl  -0x10(%ebp)
  800319:	ff 75 f4             	pushl  -0xc(%ebp)
  80031c:	ff 75 08             	pushl  0x8(%ebp)
  80031f:	e8 a9 00 00 00       	call   8003cd <Swap>
  800324:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800327:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80032a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80032d:	0f 8e 77 ff ff ff    	jle    8002aa <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800333:	83 ec 04             	sub    $0x4,%esp
  800336:	ff 75 f0             	pushl  -0x10(%ebp)
  800339:	ff 75 10             	pushl  0x10(%ebp)
  80033c:	ff 75 08             	pushl  0x8(%ebp)
  80033f:	e8 89 00 00 00       	call   8003cd <Swap>
  800344:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800347:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80034a:	48                   	dec    %eax
  80034b:	50                   	push   %eax
  80034c:	ff 75 10             	pushl  0x10(%ebp)
  80034f:	ff 75 0c             	pushl  0xc(%ebp)
  800352:	ff 75 08             	pushl  0x8(%ebp)
  800355:	e8 29 ff ff ff       	call   800283 <QSort>
  80035a:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  80035d:	ff 75 14             	pushl  0x14(%ebp)
  800360:	ff 75 f4             	pushl  -0xc(%ebp)
  800363:	ff 75 0c             	pushl  0xc(%ebp)
  800366:	ff 75 08             	pushl  0x8(%ebp)
  800369:	e8 15 ff ff ff       	call   800283 <QSort>
  80036e:	83 c4 10             	add    $0x10,%esp
  800371:	eb 01                	jmp    800374 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800373:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800374:	c9                   	leave  
  800375:	c3                   	ret    

00800376 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800376:	55                   	push   %ebp
  800377:	89 e5                	mov    %esp,%ebp
  800379:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  80037c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800383:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80038a:	eb 33                	jmp    8003bf <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80038c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80038f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800396:	8b 45 08             	mov    0x8(%ebp),%eax
  800399:	01 d0                	add    %edx,%eax
  80039b:	8b 10                	mov    (%eax),%edx
  80039d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003a0:	40                   	inc    %eax
  8003a1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ab:	01 c8                	add    %ecx,%eax
  8003ad:	8b 00                	mov    (%eax),%eax
  8003af:	39 c2                	cmp    %eax,%edx
  8003b1:	7e 09                	jle    8003bc <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003ba:	eb 0c                	jmp    8003c8 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003bc:	ff 45 f8             	incl   -0x8(%ebp)
  8003bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c2:	48                   	dec    %eax
  8003c3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003c6:	7f c4                	jg     80038c <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003cb:	c9                   	leave  
  8003cc:	c3                   	ret    

008003cd <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003cd:	55                   	push   %ebp
  8003ce:	89 e5                	mov    %esp,%ebp
  8003d0:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003d6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e0:	01 d0                	add    %edx,%eax
  8003e2:	8b 00                	mov    (%eax),%eax
  8003e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8003e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f4:	01 c2                	add    %eax,%edx
  8003f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8003f9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800400:	8b 45 08             	mov    0x8(%ebp),%eax
  800403:	01 c8                	add    %ecx,%eax
  800405:	8b 00                	mov    (%eax),%eax
  800407:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800409:	8b 45 10             	mov    0x10(%ebp),%eax
  80040c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800413:	8b 45 08             	mov    0x8(%ebp),%eax
  800416:	01 c2                	add    %eax,%edx
  800418:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80041b:	89 02                	mov    %eax,(%edx)
}
  80041d:	90                   	nop
  80041e:	c9                   	leave  
  80041f:	c3                   	ret    

00800420 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800420:	55                   	push   %ebp
  800421:	89 e5                	mov    %esp,%ebp
  800423:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800426:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80042d:	eb 17                	jmp    800446 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80042f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800432:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800439:	8b 45 08             	mov    0x8(%ebp),%eax
  80043c:	01 c2                	add    %eax,%edx
  80043e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800441:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800443:	ff 45 fc             	incl   -0x4(%ebp)
  800446:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800449:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80044c:	7c e1                	jl     80042f <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80044e:	90                   	nop
  80044f:	c9                   	leave  
  800450:	c3                   	ret    

00800451 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800451:	55                   	push   %ebp
  800452:	89 e5                	mov    %esp,%ebp
  800454:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800457:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80045e:	eb 1b                	jmp    80047b <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800460:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800463:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046a:	8b 45 08             	mov    0x8(%ebp),%eax
  80046d:	01 c2                	add    %eax,%edx
  80046f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800472:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800475:	48                   	dec    %eax
  800476:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800478:	ff 45 fc             	incl   -0x4(%ebp)
  80047b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80047e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800481:	7c dd                	jl     800460 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800483:	90                   	nop
  800484:	c9                   	leave  
  800485:	c3                   	ret    

00800486 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800486:	55                   	push   %ebp
  800487:	89 e5                	mov    %esp,%ebp
  800489:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80048c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80048f:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800494:	f7 e9                	imul   %ecx
  800496:	c1 f9 1f             	sar    $0x1f,%ecx
  800499:	89 d0                	mov    %edx,%eax
  80049b:	29 c8                	sub    %ecx,%eax
  80049d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004a7:	eb 1e                	jmp    8004c7 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8004a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ac:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b6:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8004b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004bc:	99                   	cltd   
  8004bd:	f7 7d f8             	idivl  -0x8(%ebp)
  8004c0:	89 d0                	mov    %edx,%eax
  8004c2:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004c4:	ff 45 fc             	incl   -0x4(%ebp)
  8004c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ca:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004cd:	7c da                	jl     8004a9 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8004cf:	90                   	nop
  8004d0:	c9                   	leave  
  8004d1:	c3                   	ret    

008004d2 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004d2:	55                   	push   %ebp
  8004d3:	89 e5                	mov    %esp,%ebp
  8004d5:	83 ec 18             	sub    $0x18,%esp
		int i ;
		int NumsPerLine = 20 ;
  8004d8:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
		for (i = 0 ; i < NumOfElements-1 ; i++)
  8004df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004e6:	eb 42                	jmp    80052a <PrintElements+0x58>
		{
			if (i%NumsPerLine == 0)
  8004e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004eb:	99                   	cltd   
  8004ec:	f7 7d f0             	idivl  -0x10(%ebp)
  8004ef:	89 d0                	mov    %edx,%eax
  8004f1:	85 c0                	test   %eax,%eax
  8004f3:	75 10                	jne    800505 <PrintElements+0x33>
				cprintf("\n");
  8004f5:	83 ec 0c             	sub    $0xc,%esp
  8004f8:	68 de 27 80 00       	push   $0x8027de
  8004fd:	e8 d5 04 00 00       	call   8009d7 <cprintf>
  800502:	83 c4 10             	add    $0x10,%esp
			cprintf("%d, ",Elements[i]);
  800505:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800508:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80050f:	8b 45 08             	mov    0x8(%ebp),%eax
  800512:	01 d0                	add    %edx,%eax
  800514:	8b 00                	mov    (%eax),%eax
  800516:	83 ec 08             	sub    $0x8,%esp
  800519:	50                   	push   %eax
  80051a:	68 e0 27 80 00       	push   $0x8027e0
  80051f:	e8 b3 04 00 00       	call   8009d7 <cprintf>
  800524:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
		int i ;
		int NumsPerLine = 20 ;
		for (i = 0 ; i < NumOfElements-1 ; i++)
  800527:	ff 45 f4             	incl   -0xc(%ebp)
  80052a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80052d:	48                   	dec    %eax
  80052e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800531:	7f b5                	jg     8004e8 <PrintElements+0x16>
		{
			if (i%NumsPerLine == 0)
				cprintf("\n");
			cprintf("%d, ",Elements[i]);
		}
		cprintf("%d\n",Elements[i]);
  800533:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800536:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80053d:	8b 45 08             	mov    0x8(%ebp),%eax
  800540:	01 d0                	add    %edx,%eax
  800542:	8b 00                	mov    (%eax),%eax
  800544:	83 ec 08             	sub    $0x8,%esp
  800547:	50                   	push   %eax
  800548:	68 e5 27 80 00       	push   $0x8027e5
  80054d:	e8 85 04 00 00       	call   8009d7 <cprintf>
  800552:	83 c4 10             	add    $0x10,%esp
}
  800555:	90                   	nop
  800556:	c9                   	leave  
  800557:	c3                   	ret    

00800558 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800558:	55                   	push   %ebp
  800559:	89 e5                	mov    %esp,%ebp
  80055b:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80055e:	8b 45 08             	mov    0x8(%ebp),%eax
  800561:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800564:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800568:	83 ec 0c             	sub    $0xc,%esp
  80056b:	50                   	push   %eax
  80056c:	e8 70 1a 00 00       	call   801fe1 <sys_cputc>
  800571:	83 c4 10             	add    $0x10,%esp
}
  800574:	90                   	nop
  800575:	c9                   	leave  
  800576:	c3                   	ret    

00800577 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800577:	55                   	push   %ebp
  800578:	89 e5                	mov    %esp,%ebp
  80057a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80057d:	e8 2b 1a 00 00       	call   801fad <sys_disable_interrupt>
	char c = ch;
  800582:	8b 45 08             	mov    0x8(%ebp),%eax
  800585:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800588:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80058c:	83 ec 0c             	sub    $0xc,%esp
  80058f:	50                   	push   %eax
  800590:	e8 4c 1a 00 00       	call   801fe1 <sys_cputc>
  800595:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800598:	e8 2a 1a 00 00       	call   801fc7 <sys_enable_interrupt>
}
  80059d:	90                   	nop
  80059e:	c9                   	leave  
  80059f:	c3                   	ret    

008005a0 <getchar>:

int
getchar(void)
{
  8005a0:	55                   	push   %ebp
  8005a1:	89 e5                	mov    %esp,%ebp
  8005a3:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8005a6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005ad:	eb 08                	jmp    8005b7 <getchar+0x17>
	{
		c = sys_cgetc();
  8005af:	e8 11 18 00 00       	call   801dc5 <sys_cgetc>
  8005b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8005b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005bb:	74 f2                	je     8005af <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8005bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005c0:	c9                   	leave  
  8005c1:	c3                   	ret    

008005c2 <atomic_getchar>:

int
atomic_getchar(void)
{
  8005c2:	55                   	push   %ebp
  8005c3:	89 e5                	mov    %esp,%ebp
  8005c5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005c8:	e8 e0 19 00 00       	call   801fad <sys_disable_interrupt>
	int c=0;
  8005cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005d4:	eb 08                	jmp    8005de <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005d6:	e8 ea 17 00 00       	call   801dc5 <sys_cgetc>
  8005db:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8005de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005e2:	74 f2                	je     8005d6 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8005e4:	e8 de 19 00 00       	call   801fc7 <sys_enable_interrupt>
	return c;
  8005e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005ec:	c9                   	leave  
  8005ed:	c3                   	ret    

008005ee <iscons>:

int iscons(int fdnum)
{
  8005ee:	55                   	push   %ebp
  8005ef:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005f1:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005f6:	5d                   	pop    %ebp
  8005f7:	c3                   	ret    

008005f8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005f8:	55                   	push   %ebp
  8005f9:	89 e5                	mov    %esp,%ebp
  8005fb:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005fe:	e8 0f 18 00 00       	call   801e12 <sys_getenvindex>
  800603:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800606:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800609:	89 d0                	mov    %edx,%eax
  80060b:	01 c0                	add    %eax,%eax
  80060d:	01 d0                	add    %edx,%eax
  80060f:	c1 e0 07             	shl    $0x7,%eax
  800612:	29 d0                	sub    %edx,%eax
  800614:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80061b:	01 c8                	add    %ecx,%eax
  80061d:	01 c0                	add    %eax,%eax
  80061f:	01 d0                	add    %edx,%eax
  800621:	01 c0                	add    %eax,%eax
  800623:	01 d0                	add    %edx,%eax
  800625:	c1 e0 03             	shl    $0x3,%eax
  800628:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80062d:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800632:	a1 24 30 80 00       	mov    0x803024,%eax
  800637:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  80063d:	84 c0                	test   %al,%al
  80063f:	74 0f                	je     800650 <libmain+0x58>
		binaryname = myEnv->prog_name;
  800641:	a1 24 30 80 00       	mov    0x803024,%eax
  800646:	05 f0 ee 00 00       	add    $0xeef0,%eax
  80064b:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800650:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800654:	7e 0a                	jle    800660 <libmain+0x68>
		binaryname = argv[0];
  800656:	8b 45 0c             	mov    0xc(%ebp),%eax
  800659:	8b 00                	mov    (%eax),%eax
  80065b:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800660:	83 ec 08             	sub    $0x8,%esp
  800663:	ff 75 0c             	pushl  0xc(%ebp)
  800666:	ff 75 08             	pushl  0x8(%ebp)
  800669:	e8 ca f9 ff ff       	call   800038 <_main>
  80066e:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800671:	e8 37 19 00 00       	call   801fad <sys_disable_interrupt>
	cprintf("**************************************\n");
  800676:	83 ec 0c             	sub    $0xc,%esp
  800679:	68 04 28 80 00       	push   $0x802804
  80067e:	e8 54 03 00 00       	call   8009d7 <cprintf>
  800683:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800686:	a1 24 30 80 00       	mov    0x803024,%eax
  80068b:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  800691:	a1 24 30 80 00       	mov    0x803024,%eax
  800696:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  80069c:	83 ec 04             	sub    $0x4,%esp
  80069f:	52                   	push   %edx
  8006a0:	50                   	push   %eax
  8006a1:	68 2c 28 80 00       	push   $0x80282c
  8006a6:	e8 2c 03 00 00       	call   8009d7 <cprintf>
  8006ab:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8006ae:	a1 24 30 80 00       	mov    0x803024,%eax
  8006b3:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  8006b9:	a1 24 30 80 00       	mov    0x803024,%eax
  8006be:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  8006c4:	a1 24 30 80 00       	mov    0x803024,%eax
  8006c9:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  8006cf:	51                   	push   %ecx
  8006d0:	52                   	push   %edx
  8006d1:	50                   	push   %eax
  8006d2:	68 54 28 80 00       	push   $0x802854
  8006d7:	e8 fb 02 00 00       	call   8009d7 <cprintf>
  8006dc:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8006df:	83 ec 0c             	sub    $0xc,%esp
  8006e2:	68 04 28 80 00       	push   $0x802804
  8006e7:	e8 eb 02 00 00       	call   8009d7 <cprintf>
  8006ec:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006ef:	e8 d3 18 00 00       	call   801fc7 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006f4:	e8 19 00 00 00       	call   800712 <exit>
}
  8006f9:	90                   	nop
  8006fa:	c9                   	leave  
  8006fb:	c3                   	ret    

008006fc <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006fc:	55                   	push   %ebp
  8006fd:	89 e5                	mov    %esp,%ebp
  8006ff:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800702:	83 ec 0c             	sub    $0xc,%esp
  800705:	6a 00                	push   $0x0
  800707:	e8 d2 16 00 00       	call   801dde <sys_env_destroy>
  80070c:	83 c4 10             	add    $0x10,%esp
}
  80070f:	90                   	nop
  800710:	c9                   	leave  
  800711:	c3                   	ret    

00800712 <exit>:

void
exit(void)
{
  800712:	55                   	push   %ebp
  800713:	89 e5                	mov    %esp,%ebp
  800715:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800718:	e8 27 17 00 00       	call   801e44 <sys_env_exit>
}
  80071d:	90                   	nop
  80071e:	c9                   	leave  
  80071f:	c3                   	ret    

00800720 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800720:	55                   	push   %ebp
  800721:	89 e5                	mov    %esp,%ebp
  800723:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800726:	8d 45 10             	lea    0x10(%ebp),%eax
  800729:	83 c0 04             	add    $0x4,%eax
  80072c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80072f:	a1 18 31 80 00       	mov    0x803118,%eax
  800734:	85 c0                	test   %eax,%eax
  800736:	74 16                	je     80074e <_panic+0x2e>
		cprintf("%s: ", argv0);
  800738:	a1 18 31 80 00       	mov    0x803118,%eax
  80073d:	83 ec 08             	sub    $0x8,%esp
  800740:	50                   	push   %eax
  800741:	68 ac 28 80 00       	push   $0x8028ac
  800746:	e8 8c 02 00 00       	call   8009d7 <cprintf>
  80074b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80074e:	a1 00 30 80 00       	mov    0x803000,%eax
  800753:	ff 75 0c             	pushl  0xc(%ebp)
  800756:	ff 75 08             	pushl  0x8(%ebp)
  800759:	50                   	push   %eax
  80075a:	68 b1 28 80 00       	push   $0x8028b1
  80075f:	e8 73 02 00 00       	call   8009d7 <cprintf>
  800764:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800767:	8b 45 10             	mov    0x10(%ebp),%eax
  80076a:	83 ec 08             	sub    $0x8,%esp
  80076d:	ff 75 f4             	pushl  -0xc(%ebp)
  800770:	50                   	push   %eax
  800771:	e8 f6 01 00 00       	call   80096c <vcprintf>
  800776:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800779:	83 ec 08             	sub    $0x8,%esp
  80077c:	6a 00                	push   $0x0
  80077e:	68 cd 28 80 00       	push   $0x8028cd
  800783:	e8 e4 01 00 00       	call   80096c <vcprintf>
  800788:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80078b:	e8 82 ff ff ff       	call   800712 <exit>

	// should not return here
	while (1) ;
  800790:	eb fe                	jmp    800790 <_panic+0x70>

00800792 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800792:	55                   	push   %ebp
  800793:	89 e5                	mov    %esp,%ebp
  800795:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800798:	a1 24 30 80 00       	mov    0x803024,%eax
  80079d:	8b 50 74             	mov    0x74(%eax),%edx
  8007a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007a3:	39 c2                	cmp    %eax,%edx
  8007a5:	74 14                	je     8007bb <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007a7:	83 ec 04             	sub    $0x4,%esp
  8007aa:	68 d0 28 80 00       	push   $0x8028d0
  8007af:	6a 26                	push   $0x26
  8007b1:	68 1c 29 80 00       	push   $0x80291c
  8007b6:	e8 65 ff ff ff       	call   800720 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007c2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007c9:	e9 c4 00 00 00       	jmp    800892 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  8007ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007db:	01 d0                	add    %edx,%eax
  8007dd:	8b 00                	mov    (%eax),%eax
  8007df:	85 c0                	test   %eax,%eax
  8007e1:	75 08                	jne    8007eb <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007e3:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007e6:	e9 a4 00 00 00       	jmp    80088f <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8007eb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007f2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007f9:	eb 6b                	jmp    800866 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007fb:	a1 24 30 80 00       	mov    0x803024,%eax
  800800:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800806:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800809:	89 d0                	mov    %edx,%eax
  80080b:	c1 e0 02             	shl    $0x2,%eax
  80080e:	01 d0                	add    %edx,%eax
  800810:	c1 e0 02             	shl    $0x2,%eax
  800813:	01 c8                	add    %ecx,%eax
  800815:	8a 40 04             	mov    0x4(%eax),%al
  800818:	84 c0                	test   %al,%al
  80081a:	75 47                	jne    800863 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80081c:	a1 24 30 80 00       	mov    0x803024,%eax
  800821:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800827:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80082a:	89 d0                	mov    %edx,%eax
  80082c:	c1 e0 02             	shl    $0x2,%eax
  80082f:	01 d0                	add    %edx,%eax
  800831:	c1 e0 02             	shl    $0x2,%eax
  800834:	01 c8                	add    %ecx,%eax
  800836:	8b 00                	mov    (%eax),%eax
  800838:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80083b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80083e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800843:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800845:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800848:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80084f:	8b 45 08             	mov    0x8(%ebp),%eax
  800852:	01 c8                	add    %ecx,%eax
  800854:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800856:	39 c2                	cmp    %eax,%edx
  800858:	75 09                	jne    800863 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  80085a:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800861:	eb 12                	jmp    800875 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800863:	ff 45 e8             	incl   -0x18(%ebp)
  800866:	a1 24 30 80 00       	mov    0x803024,%eax
  80086b:	8b 50 74             	mov    0x74(%eax),%edx
  80086e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800871:	39 c2                	cmp    %eax,%edx
  800873:	77 86                	ja     8007fb <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800875:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800879:	75 14                	jne    80088f <CheckWSWithoutLastIndex+0xfd>
			panic(
  80087b:	83 ec 04             	sub    $0x4,%esp
  80087e:	68 28 29 80 00       	push   $0x802928
  800883:	6a 3a                	push   $0x3a
  800885:	68 1c 29 80 00       	push   $0x80291c
  80088a:	e8 91 fe ff ff       	call   800720 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80088f:	ff 45 f0             	incl   -0x10(%ebp)
  800892:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800895:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800898:	0f 8c 30 ff ff ff    	jl     8007ce <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80089e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008a5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008ac:	eb 27                	jmp    8008d5 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008ae:	a1 24 30 80 00       	mov    0x803024,%eax
  8008b3:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8008b9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008bc:	89 d0                	mov    %edx,%eax
  8008be:	c1 e0 02             	shl    $0x2,%eax
  8008c1:	01 d0                	add    %edx,%eax
  8008c3:	c1 e0 02             	shl    $0x2,%eax
  8008c6:	01 c8                	add    %ecx,%eax
  8008c8:	8a 40 04             	mov    0x4(%eax),%al
  8008cb:	3c 01                	cmp    $0x1,%al
  8008cd:	75 03                	jne    8008d2 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  8008cf:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008d2:	ff 45 e0             	incl   -0x20(%ebp)
  8008d5:	a1 24 30 80 00       	mov    0x803024,%eax
  8008da:	8b 50 74             	mov    0x74(%eax),%edx
  8008dd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008e0:	39 c2                	cmp    %eax,%edx
  8008e2:	77 ca                	ja     8008ae <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008e7:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008ea:	74 14                	je     800900 <CheckWSWithoutLastIndex+0x16e>
		panic(
  8008ec:	83 ec 04             	sub    $0x4,%esp
  8008ef:	68 7c 29 80 00       	push   $0x80297c
  8008f4:	6a 44                	push   $0x44
  8008f6:	68 1c 29 80 00       	push   $0x80291c
  8008fb:	e8 20 fe ff ff       	call   800720 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800900:	90                   	nop
  800901:	c9                   	leave  
  800902:	c3                   	ret    

00800903 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800903:	55                   	push   %ebp
  800904:	89 e5                	mov    %esp,%ebp
  800906:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800909:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090c:	8b 00                	mov    (%eax),%eax
  80090e:	8d 48 01             	lea    0x1(%eax),%ecx
  800911:	8b 55 0c             	mov    0xc(%ebp),%edx
  800914:	89 0a                	mov    %ecx,(%edx)
  800916:	8b 55 08             	mov    0x8(%ebp),%edx
  800919:	88 d1                	mov    %dl,%cl
  80091b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80091e:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800922:	8b 45 0c             	mov    0xc(%ebp),%eax
  800925:	8b 00                	mov    (%eax),%eax
  800927:	3d ff 00 00 00       	cmp    $0xff,%eax
  80092c:	75 2c                	jne    80095a <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80092e:	a0 28 30 80 00       	mov    0x803028,%al
  800933:	0f b6 c0             	movzbl %al,%eax
  800936:	8b 55 0c             	mov    0xc(%ebp),%edx
  800939:	8b 12                	mov    (%edx),%edx
  80093b:	89 d1                	mov    %edx,%ecx
  80093d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800940:	83 c2 08             	add    $0x8,%edx
  800943:	83 ec 04             	sub    $0x4,%esp
  800946:	50                   	push   %eax
  800947:	51                   	push   %ecx
  800948:	52                   	push   %edx
  800949:	e8 4e 14 00 00       	call   801d9c <sys_cputs>
  80094e:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800951:	8b 45 0c             	mov    0xc(%ebp),%eax
  800954:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80095a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80095d:	8b 40 04             	mov    0x4(%eax),%eax
  800960:	8d 50 01             	lea    0x1(%eax),%edx
  800963:	8b 45 0c             	mov    0xc(%ebp),%eax
  800966:	89 50 04             	mov    %edx,0x4(%eax)
}
  800969:	90                   	nop
  80096a:	c9                   	leave  
  80096b:	c3                   	ret    

0080096c <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80096c:	55                   	push   %ebp
  80096d:	89 e5                	mov    %esp,%ebp
  80096f:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800975:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80097c:	00 00 00 
	b.cnt = 0;
  80097f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800986:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800989:	ff 75 0c             	pushl  0xc(%ebp)
  80098c:	ff 75 08             	pushl  0x8(%ebp)
  80098f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800995:	50                   	push   %eax
  800996:	68 03 09 80 00       	push   $0x800903
  80099b:	e8 11 02 00 00       	call   800bb1 <vprintfmt>
  8009a0:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009a3:	a0 28 30 80 00       	mov    0x803028,%al
  8009a8:	0f b6 c0             	movzbl %al,%eax
  8009ab:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009b1:	83 ec 04             	sub    $0x4,%esp
  8009b4:	50                   	push   %eax
  8009b5:	52                   	push   %edx
  8009b6:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009bc:	83 c0 08             	add    $0x8,%eax
  8009bf:	50                   	push   %eax
  8009c0:	e8 d7 13 00 00       	call   801d9c <sys_cputs>
  8009c5:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009c8:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  8009cf:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009d5:	c9                   	leave  
  8009d6:	c3                   	ret    

008009d7 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009d7:	55                   	push   %ebp
  8009d8:	89 e5                	mov    %esp,%ebp
  8009da:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009dd:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  8009e4:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ed:	83 ec 08             	sub    $0x8,%esp
  8009f0:	ff 75 f4             	pushl  -0xc(%ebp)
  8009f3:	50                   	push   %eax
  8009f4:	e8 73 ff ff ff       	call   80096c <vcprintf>
  8009f9:	83 c4 10             	add    $0x10,%esp
  8009fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a02:	c9                   	leave  
  800a03:	c3                   	ret    

00800a04 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a04:	55                   	push   %ebp
  800a05:	89 e5                	mov    %esp,%ebp
  800a07:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a0a:	e8 9e 15 00 00       	call   801fad <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a0f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a12:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a15:	8b 45 08             	mov    0x8(%ebp),%eax
  800a18:	83 ec 08             	sub    $0x8,%esp
  800a1b:	ff 75 f4             	pushl  -0xc(%ebp)
  800a1e:	50                   	push   %eax
  800a1f:	e8 48 ff ff ff       	call   80096c <vcprintf>
  800a24:	83 c4 10             	add    $0x10,%esp
  800a27:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a2a:	e8 98 15 00 00       	call   801fc7 <sys_enable_interrupt>
	return cnt;
  800a2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a32:	c9                   	leave  
  800a33:	c3                   	ret    

00800a34 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a34:	55                   	push   %ebp
  800a35:	89 e5                	mov    %esp,%ebp
  800a37:	53                   	push   %ebx
  800a38:	83 ec 14             	sub    $0x14,%esp
  800a3b:	8b 45 10             	mov    0x10(%ebp),%eax
  800a3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a41:	8b 45 14             	mov    0x14(%ebp),%eax
  800a44:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a47:	8b 45 18             	mov    0x18(%ebp),%eax
  800a4a:	ba 00 00 00 00       	mov    $0x0,%edx
  800a4f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a52:	77 55                	ja     800aa9 <printnum+0x75>
  800a54:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a57:	72 05                	jb     800a5e <printnum+0x2a>
  800a59:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a5c:	77 4b                	ja     800aa9 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a5e:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a61:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a64:	8b 45 18             	mov    0x18(%ebp),%eax
  800a67:	ba 00 00 00 00       	mov    $0x0,%edx
  800a6c:	52                   	push   %edx
  800a6d:	50                   	push   %eax
  800a6e:	ff 75 f4             	pushl  -0xc(%ebp)
  800a71:	ff 75 f0             	pushl  -0x10(%ebp)
  800a74:	e8 73 19 00 00       	call   8023ec <__udivdi3>
  800a79:	83 c4 10             	add    $0x10,%esp
  800a7c:	83 ec 04             	sub    $0x4,%esp
  800a7f:	ff 75 20             	pushl  0x20(%ebp)
  800a82:	53                   	push   %ebx
  800a83:	ff 75 18             	pushl  0x18(%ebp)
  800a86:	52                   	push   %edx
  800a87:	50                   	push   %eax
  800a88:	ff 75 0c             	pushl  0xc(%ebp)
  800a8b:	ff 75 08             	pushl  0x8(%ebp)
  800a8e:	e8 a1 ff ff ff       	call   800a34 <printnum>
  800a93:	83 c4 20             	add    $0x20,%esp
  800a96:	eb 1a                	jmp    800ab2 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a98:	83 ec 08             	sub    $0x8,%esp
  800a9b:	ff 75 0c             	pushl  0xc(%ebp)
  800a9e:	ff 75 20             	pushl  0x20(%ebp)
  800aa1:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa4:	ff d0                	call   *%eax
  800aa6:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800aa9:	ff 4d 1c             	decl   0x1c(%ebp)
  800aac:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800ab0:	7f e6                	jg     800a98 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800ab2:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800ab5:	bb 00 00 00 00       	mov    $0x0,%ebx
  800aba:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800abd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ac0:	53                   	push   %ebx
  800ac1:	51                   	push   %ecx
  800ac2:	52                   	push   %edx
  800ac3:	50                   	push   %eax
  800ac4:	e8 33 1a 00 00       	call   8024fc <__umoddi3>
  800ac9:	83 c4 10             	add    $0x10,%esp
  800acc:	05 f4 2b 80 00       	add    $0x802bf4,%eax
  800ad1:	8a 00                	mov    (%eax),%al
  800ad3:	0f be c0             	movsbl %al,%eax
  800ad6:	83 ec 08             	sub    $0x8,%esp
  800ad9:	ff 75 0c             	pushl  0xc(%ebp)
  800adc:	50                   	push   %eax
  800add:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae0:	ff d0                	call   *%eax
  800ae2:	83 c4 10             	add    $0x10,%esp
}
  800ae5:	90                   	nop
  800ae6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ae9:	c9                   	leave  
  800aea:	c3                   	ret    

00800aeb <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800aeb:	55                   	push   %ebp
  800aec:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800aee:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800af2:	7e 1c                	jle    800b10 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800af4:	8b 45 08             	mov    0x8(%ebp),%eax
  800af7:	8b 00                	mov    (%eax),%eax
  800af9:	8d 50 08             	lea    0x8(%eax),%edx
  800afc:	8b 45 08             	mov    0x8(%ebp),%eax
  800aff:	89 10                	mov    %edx,(%eax)
  800b01:	8b 45 08             	mov    0x8(%ebp),%eax
  800b04:	8b 00                	mov    (%eax),%eax
  800b06:	83 e8 08             	sub    $0x8,%eax
  800b09:	8b 50 04             	mov    0x4(%eax),%edx
  800b0c:	8b 00                	mov    (%eax),%eax
  800b0e:	eb 40                	jmp    800b50 <getuint+0x65>
	else if (lflag)
  800b10:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b14:	74 1e                	je     800b34 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b16:	8b 45 08             	mov    0x8(%ebp),%eax
  800b19:	8b 00                	mov    (%eax),%eax
  800b1b:	8d 50 04             	lea    0x4(%eax),%edx
  800b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b21:	89 10                	mov    %edx,(%eax)
  800b23:	8b 45 08             	mov    0x8(%ebp),%eax
  800b26:	8b 00                	mov    (%eax),%eax
  800b28:	83 e8 04             	sub    $0x4,%eax
  800b2b:	8b 00                	mov    (%eax),%eax
  800b2d:	ba 00 00 00 00       	mov    $0x0,%edx
  800b32:	eb 1c                	jmp    800b50 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b34:	8b 45 08             	mov    0x8(%ebp),%eax
  800b37:	8b 00                	mov    (%eax),%eax
  800b39:	8d 50 04             	lea    0x4(%eax),%edx
  800b3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3f:	89 10                	mov    %edx,(%eax)
  800b41:	8b 45 08             	mov    0x8(%ebp),%eax
  800b44:	8b 00                	mov    (%eax),%eax
  800b46:	83 e8 04             	sub    $0x4,%eax
  800b49:	8b 00                	mov    (%eax),%eax
  800b4b:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b50:	5d                   	pop    %ebp
  800b51:	c3                   	ret    

00800b52 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b52:	55                   	push   %ebp
  800b53:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b55:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b59:	7e 1c                	jle    800b77 <getint+0x25>
		return va_arg(*ap, long long);
  800b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5e:	8b 00                	mov    (%eax),%eax
  800b60:	8d 50 08             	lea    0x8(%eax),%edx
  800b63:	8b 45 08             	mov    0x8(%ebp),%eax
  800b66:	89 10                	mov    %edx,(%eax)
  800b68:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6b:	8b 00                	mov    (%eax),%eax
  800b6d:	83 e8 08             	sub    $0x8,%eax
  800b70:	8b 50 04             	mov    0x4(%eax),%edx
  800b73:	8b 00                	mov    (%eax),%eax
  800b75:	eb 38                	jmp    800baf <getint+0x5d>
	else if (lflag)
  800b77:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b7b:	74 1a                	je     800b97 <getint+0x45>
		return va_arg(*ap, long);
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	8b 00                	mov    (%eax),%eax
  800b82:	8d 50 04             	lea    0x4(%eax),%edx
  800b85:	8b 45 08             	mov    0x8(%ebp),%eax
  800b88:	89 10                	mov    %edx,(%eax)
  800b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8d:	8b 00                	mov    (%eax),%eax
  800b8f:	83 e8 04             	sub    $0x4,%eax
  800b92:	8b 00                	mov    (%eax),%eax
  800b94:	99                   	cltd   
  800b95:	eb 18                	jmp    800baf <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b97:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9a:	8b 00                	mov    (%eax),%eax
  800b9c:	8d 50 04             	lea    0x4(%eax),%edx
  800b9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba2:	89 10                	mov    %edx,(%eax)
  800ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba7:	8b 00                	mov    (%eax),%eax
  800ba9:	83 e8 04             	sub    $0x4,%eax
  800bac:	8b 00                	mov    (%eax),%eax
  800bae:	99                   	cltd   
}
  800baf:	5d                   	pop    %ebp
  800bb0:	c3                   	ret    

00800bb1 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bb1:	55                   	push   %ebp
  800bb2:	89 e5                	mov    %esp,%ebp
  800bb4:	56                   	push   %esi
  800bb5:	53                   	push   %ebx
  800bb6:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bb9:	eb 17                	jmp    800bd2 <vprintfmt+0x21>
			if (ch == '\0')
  800bbb:	85 db                	test   %ebx,%ebx
  800bbd:	0f 84 af 03 00 00    	je     800f72 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bc3:	83 ec 08             	sub    $0x8,%esp
  800bc6:	ff 75 0c             	pushl  0xc(%ebp)
  800bc9:	53                   	push   %ebx
  800bca:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcd:	ff d0                	call   *%eax
  800bcf:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bd2:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd5:	8d 50 01             	lea    0x1(%eax),%edx
  800bd8:	89 55 10             	mov    %edx,0x10(%ebp)
  800bdb:	8a 00                	mov    (%eax),%al
  800bdd:	0f b6 d8             	movzbl %al,%ebx
  800be0:	83 fb 25             	cmp    $0x25,%ebx
  800be3:	75 d6                	jne    800bbb <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800be5:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800be9:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bf0:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bf7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bfe:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c05:	8b 45 10             	mov    0x10(%ebp),%eax
  800c08:	8d 50 01             	lea    0x1(%eax),%edx
  800c0b:	89 55 10             	mov    %edx,0x10(%ebp)
  800c0e:	8a 00                	mov    (%eax),%al
  800c10:	0f b6 d8             	movzbl %al,%ebx
  800c13:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c16:	83 f8 55             	cmp    $0x55,%eax
  800c19:	0f 87 2b 03 00 00    	ja     800f4a <vprintfmt+0x399>
  800c1f:	8b 04 85 18 2c 80 00 	mov    0x802c18(,%eax,4),%eax
  800c26:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c28:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c2c:	eb d7                	jmp    800c05 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c2e:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c32:	eb d1                	jmp    800c05 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c34:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c3b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c3e:	89 d0                	mov    %edx,%eax
  800c40:	c1 e0 02             	shl    $0x2,%eax
  800c43:	01 d0                	add    %edx,%eax
  800c45:	01 c0                	add    %eax,%eax
  800c47:	01 d8                	add    %ebx,%eax
  800c49:	83 e8 30             	sub    $0x30,%eax
  800c4c:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c4f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c52:	8a 00                	mov    (%eax),%al
  800c54:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c57:	83 fb 2f             	cmp    $0x2f,%ebx
  800c5a:	7e 3e                	jle    800c9a <vprintfmt+0xe9>
  800c5c:	83 fb 39             	cmp    $0x39,%ebx
  800c5f:	7f 39                	jg     800c9a <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c61:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c64:	eb d5                	jmp    800c3b <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c66:	8b 45 14             	mov    0x14(%ebp),%eax
  800c69:	83 c0 04             	add    $0x4,%eax
  800c6c:	89 45 14             	mov    %eax,0x14(%ebp)
  800c6f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c72:	83 e8 04             	sub    $0x4,%eax
  800c75:	8b 00                	mov    (%eax),%eax
  800c77:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c7a:	eb 1f                	jmp    800c9b <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c7c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c80:	79 83                	jns    800c05 <vprintfmt+0x54>
				width = 0;
  800c82:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c89:	e9 77 ff ff ff       	jmp    800c05 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c8e:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c95:	e9 6b ff ff ff       	jmp    800c05 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c9a:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c9b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c9f:	0f 89 60 ff ff ff    	jns    800c05 <vprintfmt+0x54>
				width = precision, precision = -1;
  800ca5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ca8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800cab:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cb2:	e9 4e ff ff ff       	jmp    800c05 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800cb7:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800cba:	e9 46 ff ff ff       	jmp    800c05 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cbf:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc2:	83 c0 04             	add    $0x4,%eax
  800cc5:	89 45 14             	mov    %eax,0x14(%ebp)
  800cc8:	8b 45 14             	mov    0x14(%ebp),%eax
  800ccb:	83 e8 04             	sub    $0x4,%eax
  800cce:	8b 00                	mov    (%eax),%eax
  800cd0:	83 ec 08             	sub    $0x8,%esp
  800cd3:	ff 75 0c             	pushl  0xc(%ebp)
  800cd6:	50                   	push   %eax
  800cd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cda:	ff d0                	call   *%eax
  800cdc:	83 c4 10             	add    $0x10,%esp
			break;
  800cdf:	e9 89 02 00 00       	jmp    800f6d <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800ce4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce7:	83 c0 04             	add    $0x4,%eax
  800cea:	89 45 14             	mov    %eax,0x14(%ebp)
  800ced:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf0:	83 e8 04             	sub    $0x4,%eax
  800cf3:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cf5:	85 db                	test   %ebx,%ebx
  800cf7:	79 02                	jns    800cfb <vprintfmt+0x14a>
				err = -err;
  800cf9:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cfb:	83 fb 64             	cmp    $0x64,%ebx
  800cfe:	7f 0b                	jg     800d0b <vprintfmt+0x15a>
  800d00:	8b 34 9d 60 2a 80 00 	mov    0x802a60(,%ebx,4),%esi
  800d07:	85 f6                	test   %esi,%esi
  800d09:	75 19                	jne    800d24 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d0b:	53                   	push   %ebx
  800d0c:	68 05 2c 80 00       	push   $0x802c05
  800d11:	ff 75 0c             	pushl  0xc(%ebp)
  800d14:	ff 75 08             	pushl  0x8(%ebp)
  800d17:	e8 5e 02 00 00       	call   800f7a <printfmt>
  800d1c:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d1f:	e9 49 02 00 00       	jmp    800f6d <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d24:	56                   	push   %esi
  800d25:	68 0e 2c 80 00       	push   $0x802c0e
  800d2a:	ff 75 0c             	pushl  0xc(%ebp)
  800d2d:	ff 75 08             	pushl  0x8(%ebp)
  800d30:	e8 45 02 00 00       	call   800f7a <printfmt>
  800d35:	83 c4 10             	add    $0x10,%esp
			break;
  800d38:	e9 30 02 00 00       	jmp    800f6d <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d3d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d40:	83 c0 04             	add    $0x4,%eax
  800d43:	89 45 14             	mov    %eax,0x14(%ebp)
  800d46:	8b 45 14             	mov    0x14(%ebp),%eax
  800d49:	83 e8 04             	sub    $0x4,%eax
  800d4c:	8b 30                	mov    (%eax),%esi
  800d4e:	85 f6                	test   %esi,%esi
  800d50:	75 05                	jne    800d57 <vprintfmt+0x1a6>
				p = "(null)";
  800d52:	be 11 2c 80 00       	mov    $0x802c11,%esi
			if (width > 0 && padc != '-')
  800d57:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d5b:	7e 6d                	jle    800dca <vprintfmt+0x219>
  800d5d:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d61:	74 67                	je     800dca <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d63:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d66:	83 ec 08             	sub    $0x8,%esp
  800d69:	50                   	push   %eax
  800d6a:	56                   	push   %esi
  800d6b:	e8 12 05 00 00       	call   801282 <strnlen>
  800d70:	83 c4 10             	add    $0x10,%esp
  800d73:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d76:	eb 16                	jmp    800d8e <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d78:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d7c:	83 ec 08             	sub    $0x8,%esp
  800d7f:	ff 75 0c             	pushl  0xc(%ebp)
  800d82:	50                   	push   %eax
  800d83:	8b 45 08             	mov    0x8(%ebp),%eax
  800d86:	ff d0                	call   *%eax
  800d88:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d8b:	ff 4d e4             	decl   -0x1c(%ebp)
  800d8e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d92:	7f e4                	jg     800d78 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d94:	eb 34                	jmp    800dca <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d96:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d9a:	74 1c                	je     800db8 <vprintfmt+0x207>
  800d9c:	83 fb 1f             	cmp    $0x1f,%ebx
  800d9f:	7e 05                	jle    800da6 <vprintfmt+0x1f5>
  800da1:	83 fb 7e             	cmp    $0x7e,%ebx
  800da4:	7e 12                	jle    800db8 <vprintfmt+0x207>
					putch('?', putdat);
  800da6:	83 ec 08             	sub    $0x8,%esp
  800da9:	ff 75 0c             	pushl  0xc(%ebp)
  800dac:	6a 3f                	push   $0x3f
  800dae:	8b 45 08             	mov    0x8(%ebp),%eax
  800db1:	ff d0                	call   *%eax
  800db3:	83 c4 10             	add    $0x10,%esp
  800db6:	eb 0f                	jmp    800dc7 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800db8:	83 ec 08             	sub    $0x8,%esp
  800dbb:	ff 75 0c             	pushl  0xc(%ebp)
  800dbe:	53                   	push   %ebx
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc2:	ff d0                	call   *%eax
  800dc4:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dc7:	ff 4d e4             	decl   -0x1c(%ebp)
  800dca:	89 f0                	mov    %esi,%eax
  800dcc:	8d 70 01             	lea    0x1(%eax),%esi
  800dcf:	8a 00                	mov    (%eax),%al
  800dd1:	0f be d8             	movsbl %al,%ebx
  800dd4:	85 db                	test   %ebx,%ebx
  800dd6:	74 24                	je     800dfc <vprintfmt+0x24b>
  800dd8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ddc:	78 b8                	js     800d96 <vprintfmt+0x1e5>
  800dde:	ff 4d e0             	decl   -0x20(%ebp)
  800de1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800de5:	79 af                	jns    800d96 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800de7:	eb 13                	jmp    800dfc <vprintfmt+0x24b>
				putch(' ', putdat);
  800de9:	83 ec 08             	sub    $0x8,%esp
  800dec:	ff 75 0c             	pushl  0xc(%ebp)
  800def:	6a 20                	push   $0x20
  800df1:	8b 45 08             	mov    0x8(%ebp),%eax
  800df4:	ff d0                	call   *%eax
  800df6:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800df9:	ff 4d e4             	decl   -0x1c(%ebp)
  800dfc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e00:	7f e7                	jg     800de9 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e02:	e9 66 01 00 00       	jmp    800f6d <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e07:	83 ec 08             	sub    $0x8,%esp
  800e0a:	ff 75 e8             	pushl  -0x18(%ebp)
  800e0d:	8d 45 14             	lea    0x14(%ebp),%eax
  800e10:	50                   	push   %eax
  800e11:	e8 3c fd ff ff       	call   800b52 <getint>
  800e16:	83 c4 10             	add    $0x10,%esp
  800e19:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e1c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e22:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e25:	85 d2                	test   %edx,%edx
  800e27:	79 23                	jns    800e4c <vprintfmt+0x29b>
				putch('-', putdat);
  800e29:	83 ec 08             	sub    $0x8,%esp
  800e2c:	ff 75 0c             	pushl  0xc(%ebp)
  800e2f:	6a 2d                	push   $0x2d
  800e31:	8b 45 08             	mov    0x8(%ebp),%eax
  800e34:	ff d0                	call   *%eax
  800e36:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e39:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e3c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e3f:	f7 d8                	neg    %eax
  800e41:	83 d2 00             	adc    $0x0,%edx
  800e44:	f7 da                	neg    %edx
  800e46:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e49:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e4c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e53:	e9 bc 00 00 00       	jmp    800f14 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e58:	83 ec 08             	sub    $0x8,%esp
  800e5b:	ff 75 e8             	pushl  -0x18(%ebp)
  800e5e:	8d 45 14             	lea    0x14(%ebp),%eax
  800e61:	50                   	push   %eax
  800e62:	e8 84 fc ff ff       	call   800aeb <getuint>
  800e67:	83 c4 10             	add    $0x10,%esp
  800e6a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e6d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e70:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e77:	e9 98 00 00 00       	jmp    800f14 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e7c:	83 ec 08             	sub    $0x8,%esp
  800e7f:	ff 75 0c             	pushl  0xc(%ebp)
  800e82:	6a 58                	push   $0x58
  800e84:	8b 45 08             	mov    0x8(%ebp),%eax
  800e87:	ff d0                	call   *%eax
  800e89:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e8c:	83 ec 08             	sub    $0x8,%esp
  800e8f:	ff 75 0c             	pushl  0xc(%ebp)
  800e92:	6a 58                	push   $0x58
  800e94:	8b 45 08             	mov    0x8(%ebp),%eax
  800e97:	ff d0                	call   *%eax
  800e99:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e9c:	83 ec 08             	sub    $0x8,%esp
  800e9f:	ff 75 0c             	pushl  0xc(%ebp)
  800ea2:	6a 58                	push   $0x58
  800ea4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea7:	ff d0                	call   *%eax
  800ea9:	83 c4 10             	add    $0x10,%esp
			break;
  800eac:	e9 bc 00 00 00       	jmp    800f6d <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800eb1:	83 ec 08             	sub    $0x8,%esp
  800eb4:	ff 75 0c             	pushl  0xc(%ebp)
  800eb7:	6a 30                	push   $0x30
  800eb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebc:	ff d0                	call   *%eax
  800ebe:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ec1:	83 ec 08             	sub    $0x8,%esp
  800ec4:	ff 75 0c             	pushl  0xc(%ebp)
  800ec7:	6a 78                	push   $0x78
  800ec9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecc:	ff d0                	call   *%eax
  800ece:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ed1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ed4:	83 c0 04             	add    $0x4,%eax
  800ed7:	89 45 14             	mov    %eax,0x14(%ebp)
  800eda:	8b 45 14             	mov    0x14(%ebp),%eax
  800edd:	83 e8 04             	sub    $0x4,%eax
  800ee0:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ee2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ee5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800eec:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ef3:	eb 1f                	jmp    800f14 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ef5:	83 ec 08             	sub    $0x8,%esp
  800ef8:	ff 75 e8             	pushl  -0x18(%ebp)
  800efb:	8d 45 14             	lea    0x14(%ebp),%eax
  800efe:	50                   	push   %eax
  800eff:	e8 e7 fb ff ff       	call   800aeb <getuint>
  800f04:	83 c4 10             	add    $0x10,%esp
  800f07:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f0a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f0d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f14:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f18:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f1b:	83 ec 04             	sub    $0x4,%esp
  800f1e:	52                   	push   %edx
  800f1f:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f22:	50                   	push   %eax
  800f23:	ff 75 f4             	pushl  -0xc(%ebp)
  800f26:	ff 75 f0             	pushl  -0x10(%ebp)
  800f29:	ff 75 0c             	pushl  0xc(%ebp)
  800f2c:	ff 75 08             	pushl  0x8(%ebp)
  800f2f:	e8 00 fb ff ff       	call   800a34 <printnum>
  800f34:	83 c4 20             	add    $0x20,%esp
			break;
  800f37:	eb 34                	jmp    800f6d <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f39:	83 ec 08             	sub    $0x8,%esp
  800f3c:	ff 75 0c             	pushl  0xc(%ebp)
  800f3f:	53                   	push   %ebx
  800f40:	8b 45 08             	mov    0x8(%ebp),%eax
  800f43:	ff d0                	call   *%eax
  800f45:	83 c4 10             	add    $0x10,%esp
			break;
  800f48:	eb 23                	jmp    800f6d <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f4a:	83 ec 08             	sub    $0x8,%esp
  800f4d:	ff 75 0c             	pushl  0xc(%ebp)
  800f50:	6a 25                	push   $0x25
  800f52:	8b 45 08             	mov    0x8(%ebp),%eax
  800f55:	ff d0                	call   *%eax
  800f57:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f5a:	ff 4d 10             	decl   0x10(%ebp)
  800f5d:	eb 03                	jmp    800f62 <vprintfmt+0x3b1>
  800f5f:	ff 4d 10             	decl   0x10(%ebp)
  800f62:	8b 45 10             	mov    0x10(%ebp),%eax
  800f65:	48                   	dec    %eax
  800f66:	8a 00                	mov    (%eax),%al
  800f68:	3c 25                	cmp    $0x25,%al
  800f6a:	75 f3                	jne    800f5f <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f6c:	90                   	nop
		}
	}
  800f6d:	e9 47 fc ff ff       	jmp    800bb9 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f72:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f73:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f76:	5b                   	pop    %ebx
  800f77:	5e                   	pop    %esi
  800f78:	5d                   	pop    %ebp
  800f79:	c3                   	ret    

00800f7a <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f7a:	55                   	push   %ebp
  800f7b:	89 e5                	mov    %esp,%ebp
  800f7d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f80:	8d 45 10             	lea    0x10(%ebp),%eax
  800f83:	83 c0 04             	add    $0x4,%eax
  800f86:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f89:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8c:	ff 75 f4             	pushl  -0xc(%ebp)
  800f8f:	50                   	push   %eax
  800f90:	ff 75 0c             	pushl  0xc(%ebp)
  800f93:	ff 75 08             	pushl  0x8(%ebp)
  800f96:	e8 16 fc ff ff       	call   800bb1 <vprintfmt>
  800f9b:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f9e:	90                   	nop
  800f9f:	c9                   	leave  
  800fa0:	c3                   	ret    

00800fa1 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800fa1:	55                   	push   %ebp
  800fa2:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fa4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa7:	8b 40 08             	mov    0x8(%eax),%eax
  800faa:	8d 50 01             	lea    0x1(%eax),%edx
  800fad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb0:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fb3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb6:	8b 10                	mov    (%eax),%edx
  800fb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbb:	8b 40 04             	mov    0x4(%eax),%eax
  800fbe:	39 c2                	cmp    %eax,%edx
  800fc0:	73 12                	jae    800fd4 <sprintputch+0x33>
		*b->buf++ = ch;
  800fc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc5:	8b 00                	mov    (%eax),%eax
  800fc7:	8d 48 01             	lea    0x1(%eax),%ecx
  800fca:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fcd:	89 0a                	mov    %ecx,(%edx)
  800fcf:	8b 55 08             	mov    0x8(%ebp),%edx
  800fd2:	88 10                	mov    %dl,(%eax)
}
  800fd4:	90                   	nop
  800fd5:	5d                   	pop    %ebp
  800fd6:	c3                   	ret    

00800fd7 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fd7:	55                   	push   %ebp
  800fd8:	89 e5                	mov    %esp,%ebp
  800fda:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fe3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fe9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fec:	01 d0                	add    %edx,%eax
  800fee:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ff1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800ff8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ffc:	74 06                	je     801004 <vsnprintf+0x2d>
  800ffe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801002:	7f 07                	jg     80100b <vsnprintf+0x34>
		return -E_INVAL;
  801004:	b8 03 00 00 00       	mov    $0x3,%eax
  801009:	eb 20                	jmp    80102b <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80100b:	ff 75 14             	pushl  0x14(%ebp)
  80100e:	ff 75 10             	pushl  0x10(%ebp)
  801011:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801014:	50                   	push   %eax
  801015:	68 a1 0f 80 00       	push   $0x800fa1
  80101a:	e8 92 fb ff ff       	call   800bb1 <vprintfmt>
  80101f:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801022:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801025:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801028:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80102b:	c9                   	leave  
  80102c:	c3                   	ret    

0080102d <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80102d:	55                   	push   %ebp
  80102e:	89 e5                	mov    %esp,%ebp
  801030:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801033:	8d 45 10             	lea    0x10(%ebp),%eax
  801036:	83 c0 04             	add    $0x4,%eax
  801039:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80103c:	8b 45 10             	mov    0x10(%ebp),%eax
  80103f:	ff 75 f4             	pushl  -0xc(%ebp)
  801042:	50                   	push   %eax
  801043:	ff 75 0c             	pushl  0xc(%ebp)
  801046:	ff 75 08             	pushl  0x8(%ebp)
  801049:	e8 89 ff ff ff       	call   800fd7 <vsnprintf>
  80104e:	83 c4 10             	add    $0x10,%esp
  801051:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801054:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801057:	c9                   	leave  
  801058:	c3                   	ret    

00801059 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801059:	55                   	push   %ebp
  80105a:	89 e5                	mov    %esp,%ebp
  80105c:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80105f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801063:	74 13                	je     801078 <readline+0x1f>
		cprintf("%s", prompt);
  801065:	83 ec 08             	sub    $0x8,%esp
  801068:	ff 75 08             	pushl  0x8(%ebp)
  80106b:	68 70 2d 80 00       	push   $0x802d70
  801070:	e8 62 f9 ff ff       	call   8009d7 <cprintf>
  801075:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801078:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80107f:	83 ec 0c             	sub    $0xc,%esp
  801082:	6a 00                	push   $0x0
  801084:	e8 65 f5 ff ff       	call   8005ee <iscons>
  801089:	83 c4 10             	add    $0x10,%esp
  80108c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80108f:	e8 0c f5 ff ff       	call   8005a0 <getchar>
  801094:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801097:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80109b:	79 22                	jns    8010bf <readline+0x66>
			if (c != -E_EOF)
  80109d:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8010a1:	0f 84 ad 00 00 00    	je     801154 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8010a7:	83 ec 08             	sub    $0x8,%esp
  8010aa:	ff 75 ec             	pushl  -0x14(%ebp)
  8010ad:	68 73 2d 80 00       	push   $0x802d73
  8010b2:	e8 20 f9 ff ff       	call   8009d7 <cprintf>
  8010b7:	83 c4 10             	add    $0x10,%esp
			return;
  8010ba:	e9 95 00 00 00       	jmp    801154 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8010bf:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8010c3:	7e 34                	jle    8010f9 <readline+0xa0>
  8010c5:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8010cc:	7f 2b                	jg     8010f9 <readline+0xa0>
			if (echoing)
  8010ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010d2:	74 0e                	je     8010e2 <readline+0x89>
				cputchar(c);
  8010d4:	83 ec 0c             	sub    $0xc,%esp
  8010d7:	ff 75 ec             	pushl  -0x14(%ebp)
  8010da:	e8 79 f4 ff ff       	call   800558 <cputchar>
  8010df:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8010e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010e5:	8d 50 01             	lea    0x1(%eax),%edx
  8010e8:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8010eb:	89 c2                	mov    %eax,%edx
  8010ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f0:	01 d0                	add    %edx,%eax
  8010f2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010f5:	88 10                	mov    %dl,(%eax)
  8010f7:	eb 56                	jmp    80114f <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8010f9:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8010fd:	75 1f                	jne    80111e <readline+0xc5>
  8010ff:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801103:	7e 19                	jle    80111e <readline+0xc5>
			if (echoing)
  801105:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801109:	74 0e                	je     801119 <readline+0xc0>
				cputchar(c);
  80110b:	83 ec 0c             	sub    $0xc,%esp
  80110e:	ff 75 ec             	pushl  -0x14(%ebp)
  801111:	e8 42 f4 ff ff       	call   800558 <cputchar>
  801116:	83 c4 10             	add    $0x10,%esp

			i--;
  801119:	ff 4d f4             	decl   -0xc(%ebp)
  80111c:	eb 31                	jmp    80114f <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  80111e:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801122:	74 0a                	je     80112e <readline+0xd5>
  801124:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801128:	0f 85 61 ff ff ff    	jne    80108f <readline+0x36>
			if (echoing)
  80112e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801132:	74 0e                	je     801142 <readline+0xe9>
				cputchar(c);
  801134:	83 ec 0c             	sub    $0xc,%esp
  801137:	ff 75 ec             	pushl  -0x14(%ebp)
  80113a:	e8 19 f4 ff ff       	call   800558 <cputchar>
  80113f:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801142:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801145:	8b 45 0c             	mov    0xc(%ebp),%eax
  801148:	01 d0                	add    %edx,%eax
  80114a:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80114d:	eb 06                	jmp    801155 <readline+0xfc>
		}
	}
  80114f:	e9 3b ff ff ff       	jmp    80108f <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801154:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801155:	c9                   	leave  
  801156:	c3                   	ret    

00801157 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801157:	55                   	push   %ebp
  801158:	89 e5                	mov    %esp,%ebp
  80115a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80115d:	e8 4b 0e 00 00       	call   801fad <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801162:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801166:	74 13                	je     80117b <atomic_readline+0x24>
		cprintf("%s", prompt);
  801168:	83 ec 08             	sub    $0x8,%esp
  80116b:	ff 75 08             	pushl  0x8(%ebp)
  80116e:	68 70 2d 80 00       	push   $0x802d70
  801173:	e8 5f f8 ff ff       	call   8009d7 <cprintf>
  801178:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80117b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801182:	83 ec 0c             	sub    $0xc,%esp
  801185:	6a 00                	push   $0x0
  801187:	e8 62 f4 ff ff       	call   8005ee <iscons>
  80118c:	83 c4 10             	add    $0x10,%esp
  80118f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801192:	e8 09 f4 ff ff       	call   8005a0 <getchar>
  801197:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80119a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80119e:	79 23                	jns    8011c3 <atomic_readline+0x6c>
			if (c != -E_EOF)
  8011a0:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8011a4:	74 13                	je     8011b9 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8011a6:	83 ec 08             	sub    $0x8,%esp
  8011a9:	ff 75 ec             	pushl  -0x14(%ebp)
  8011ac:	68 73 2d 80 00       	push   $0x802d73
  8011b1:	e8 21 f8 ff ff       	call   8009d7 <cprintf>
  8011b6:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011b9:	e8 09 0e 00 00       	call   801fc7 <sys_enable_interrupt>
			return;
  8011be:	e9 9a 00 00 00       	jmp    80125d <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011c3:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011c7:	7e 34                	jle    8011fd <atomic_readline+0xa6>
  8011c9:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011d0:	7f 2b                	jg     8011fd <atomic_readline+0xa6>
			if (echoing)
  8011d2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011d6:	74 0e                	je     8011e6 <atomic_readline+0x8f>
				cputchar(c);
  8011d8:	83 ec 0c             	sub    $0xc,%esp
  8011db:	ff 75 ec             	pushl  -0x14(%ebp)
  8011de:	e8 75 f3 ff ff       	call   800558 <cputchar>
  8011e3:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011e9:	8d 50 01             	lea    0x1(%eax),%edx
  8011ec:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011ef:	89 c2                	mov    %eax,%edx
  8011f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f4:	01 d0                	add    %edx,%eax
  8011f6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011f9:	88 10                	mov    %dl,(%eax)
  8011fb:	eb 5b                	jmp    801258 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8011fd:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801201:	75 1f                	jne    801222 <atomic_readline+0xcb>
  801203:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801207:	7e 19                	jle    801222 <atomic_readline+0xcb>
			if (echoing)
  801209:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80120d:	74 0e                	je     80121d <atomic_readline+0xc6>
				cputchar(c);
  80120f:	83 ec 0c             	sub    $0xc,%esp
  801212:	ff 75 ec             	pushl  -0x14(%ebp)
  801215:	e8 3e f3 ff ff       	call   800558 <cputchar>
  80121a:	83 c4 10             	add    $0x10,%esp
			i--;
  80121d:	ff 4d f4             	decl   -0xc(%ebp)
  801220:	eb 36                	jmp    801258 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801222:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801226:	74 0a                	je     801232 <atomic_readline+0xdb>
  801228:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80122c:	0f 85 60 ff ff ff    	jne    801192 <atomic_readline+0x3b>
			if (echoing)
  801232:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801236:	74 0e                	je     801246 <atomic_readline+0xef>
				cputchar(c);
  801238:	83 ec 0c             	sub    $0xc,%esp
  80123b:	ff 75 ec             	pushl  -0x14(%ebp)
  80123e:	e8 15 f3 ff ff       	call   800558 <cputchar>
  801243:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801246:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801249:	8b 45 0c             	mov    0xc(%ebp),%eax
  80124c:	01 d0                	add    %edx,%eax
  80124e:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801251:	e8 71 0d 00 00       	call   801fc7 <sys_enable_interrupt>
			return;
  801256:	eb 05                	jmp    80125d <atomic_readline+0x106>
		}
	}
  801258:	e9 35 ff ff ff       	jmp    801192 <atomic_readline+0x3b>
}
  80125d:	c9                   	leave  
  80125e:	c3                   	ret    

0080125f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80125f:	55                   	push   %ebp
  801260:	89 e5                	mov    %esp,%ebp
  801262:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801265:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80126c:	eb 06                	jmp    801274 <strlen+0x15>
		n++;
  80126e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801271:	ff 45 08             	incl   0x8(%ebp)
  801274:	8b 45 08             	mov    0x8(%ebp),%eax
  801277:	8a 00                	mov    (%eax),%al
  801279:	84 c0                	test   %al,%al
  80127b:	75 f1                	jne    80126e <strlen+0xf>
		n++;
	return n;
  80127d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801280:	c9                   	leave  
  801281:	c3                   	ret    

00801282 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801282:	55                   	push   %ebp
  801283:	89 e5                	mov    %esp,%ebp
  801285:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801288:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80128f:	eb 09                	jmp    80129a <strnlen+0x18>
		n++;
  801291:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801294:	ff 45 08             	incl   0x8(%ebp)
  801297:	ff 4d 0c             	decl   0xc(%ebp)
  80129a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80129e:	74 09                	je     8012a9 <strnlen+0x27>
  8012a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a3:	8a 00                	mov    (%eax),%al
  8012a5:	84 c0                	test   %al,%al
  8012a7:	75 e8                	jne    801291 <strnlen+0xf>
		n++;
	return n;
  8012a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012ac:	c9                   	leave  
  8012ad:	c3                   	ret    

008012ae <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8012ae:	55                   	push   %ebp
  8012af:	89 e5                	mov    %esp,%ebp
  8012b1:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8012b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012ba:	90                   	nop
  8012bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012be:	8d 50 01             	lea    0x1(%eax),%edx
  8012c1:	89 55 08             	mov    %edx,0x8(%ebp)
  8012c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012c7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012ca:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012cd:	8a 12                	mov    (%edx),%dl
  8012cf:	88 10                	mov    %dl,(%eax)
  8012d1:	8a 00                	mov    (%eax),%al
  8012d3:	84 c0                	test   %al,%al
  8012d5:	75 e4                	jne    8012bb <strcpy+0xd>
		/* do nothing */;
	return ret;
  8012d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012da:	c9                   	leave  
  8012db:	c3                   	ret    

008012dc <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012dc:	55                   	push   %ebp
  8012dd:	89 e5                	mov    %esp,%ebp
  8012df:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012e8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012ef:	eb 1f                	jmp    801310 <strncpy+0x34>
		*dst++ = *src;
  8012f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f4:	8d 50 01             	lea    0x1(%eax),%edx
  8012f7:	89 55 08             	mov    %edx,0x8(%ebp)
  8012fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012fd:	8a 12                	mov    (%edx),%dl
  8012ff:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801301:	8b 45 0c             	mov    0xc(%ebp),%eax
  801304:	8a 00                	mov    (%eax),%al
  801306:	84 c0                	test   %al,%al
  801308:	74 03                	je     80130d <strncpy+0x31>
			src++;
  80130a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80130d:	ff 45 fc             	incl   -0x4(%ebp)
  801310:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801313:	3b 45 10             	cmp    0x10(%ebp),%eax
  801316:	72 d9                	jb     8012f1 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801318:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80131b:	c9                   	leave  
  80131c:	c3                   	ret    

0080131d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80131d:	55                   	push   %ebp
  80131e:	89 e5                	mov    %esp,%ebp
  801320:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801323:	8b 45 08             	mov    0x8(%ebp),%eax
  801326:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801329:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80132d:	74 30                	je     80135f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80132f:	eb 16                	jmp    801347 <strlcpy+0x2a>
			*dst++ = *src++;
  801331:	8b 45 08             	mov    0x8(%ebp),%eax
  801334:	8d 50 01             	lea    0x1(%eax),%edx
  801337:	89 55 08             	mov    %edx,0x8(%ebp)
  80133a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80133d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801340:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801343:	8a 12                	mov    (%edx),%dl
  801345:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801347:	ff 4d 10             	decl   0x10(%ebp)
  80134a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80134e:	74 09                	je     801359 <strlcpy+0x3c>
  801350:	8b 45 0c             	mov    0xc(%ebp),%eax
  801353:	8a 00                	mov    (%eax),%al
  801355:	84 c0                	test   %al,%al
  801357:	75 d8                	jne    801331 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801359:	8b 45 08             	mov    0x8(%ebp),%eax
  80135c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80135f:	8b 55 08             	mov    0x8(%ebp),%edx
  801362:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801365:	29 c2                	sub    %eax,%edx
  801367:	89 d0                	mov    %edx,%eax
}
  801369:	c9                   	leave  
  80136a:	c3                   	ret    

0080136b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80136b:	55                   	push   %ebp
  80136c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80136e:	eb 06                	jmp    801376 <strcmp+0xb>
		p++, q++;
  801370:	ff 45 08             	incl   0x8(%ebp)
  801373:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801376:	8b 45 08             	mov    0x8(%ebp),%eax
  801379:	8a 00                	mov    (%eax),%al
  80137b:	84 c0                	test   %al,%al
  80137d:	74 0e                	je     80138d <strcmp+0x22>
  80137f:	8b 45 08             	mov    0x8(%ebp),%eax
  801382:	8a 10                	mov    (%eax),%dl
  801384:	8b 45 0c             	mov    0xc(%ebp),%eax
  801387:	8a 00                	mov    (%eax),%al
  801389:	38 c2                	cmp    %al,%dl
  80138b:	74 e3                	je     801370 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80138d:	8b 45 08             	mov    0x8(%ebp),%eax
  801390:	8a 00                	mov    (%eax),%al
  801392:	0f b6 d0             	movzbl %al,%edx
  801395:	8b 45 0c             	mov    0xc(%ebp),%eax
  801398:	8a 00                	mov    (%eax),%al
  80139a:	0f b6 c0             	movzbl %al,%eax
  80139d:	29 c2                	sub    %eax,%edx
  80139f:	89 d0                	mov    %edx,%eax
}
  8013a1:	5d                   	pop    %ebp
  8013a2:	c3                   	ret    

008013a3 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8013a3:	55                   	push   %ebp
  8013a4:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8013a6:	eb 09                	jmp    8013b1 <strncmp+0xe>
		n--, p++, q++;
  8013a8:	ff 4d 10             	decl   0x10(%ebp)
  8013ab:	ff 45 08             	incl   0x8(%ebp)
  8013ae:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013b1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013b5:	74 17                	je     8013ce <strncmp+0x2b>
  8013b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ba:	8a 00                	mov    (%eax),%al
  8013bc:	84 c0                	test   %al,%al
  8013be:	74 0e                	je     8013ce <strncmp+0x2b>
  8013c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c3:	8a 10                	mov    (%eax),%dl
  8013c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c8:	8a 00                	mov    (%eax),%al
  8013ca:	38 c2                	cmp    %al,%dl
  8013cc:	74 da                	je     8013a8 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013ce:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013d2:	75 07                	jne    8013db <strncmp+0x38>
		return 0;
  8013d4:	b8 00 00 00 00       	mov    $0x0,%eax
  8013d9:	eb 14                	jmp    8013ef <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8013db:	8b 45 08             	mov    0x8(%ebp),%eax
  8013de:	8a 00                	mov    (%eax),%al
  8013e0:	0f b6 d0             	movzbl %al,%edx
  8013e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e6:	8a 00                	mov    (%eax),%al
  8013e8:	0f b6 c0             	movzbl %al,%eax
  8013eb:	29 c2                	sub    %eax,%edx
  8013ed:	89 d0                	mov    %edx,%eax
}
  8013ef:	5d                   	pop    %ebp
  8013f0:	c3                   	ret    

008013f1 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013f1:	55                   	push   %ebp
  8013f2:	89 e5                	mov    %esp,%ebp
  8013f4:	83 ec 04             	sub    $0x4,%esp
  8013f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013fa:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013fd:	eb 12                	jmp    801411 <strchr+0x20>
		if (*s == c)
  8013ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801402:	8a 00                	mov    (%eax),%al
  801404:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801407:	75 05                	jne    80140e <strchr+0x1d>
			return (char *) s;
  801409:	8b 45 08             	mov    0x8(%ebp),%eax
  80140c:	eb 11                	jmp    80141f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80140e:	ff 45 08             	incl   0x8(%ebp)
  801411:	8b 45 08             	mov    0x8(%ebp),%eax
  801414:	8a 00                	mov    (%eax),%al
  801416:	84 c0                	test   %al,%al
  801418:	75 e5                	jne    8013ff <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80141a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80141f:	c9                   	leave  
  801420:	c3                   	ret    

00801421 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801421:	55                   	push   %ebp
  801422:	89 e5                	mov    %esp,%ebp
  801424:	83 ec 04             	sub    $0x4,%esp
  801427:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80142d:	eb 0d                	jmp    80143c <strfind+0x1b>
		if (*s == c)
  80142f:	8b 45 08             	mov    0x8(%ebp),%eax
  801432:	8a 00                	mov    (%eax),%al
  801434:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801437:	74 0e                	je     801447 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801439:	ff 45 08             	incl   0x8(%ebp)
  80143c:	8b 45 08             	mov    0x8(%ebp),%eax
  80143f:	8a 00                	mov    (%eax),%al
  801441:	84 c0                	test   %al,%al
  801443:	75 ea                	jne    80142f <strfind+0xe>
  801445:	eb 01                	jmp    801448 <strfind+0x27>
		if (*s == c)
			break;
  801447:	90                   	nop
	return (char *) s;
  801448:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80144b:	c9                   	leave  
  80144c:	c3                   	ret    

0080144d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80144d:	55                   	push   %ebp
  80144e:	89 e5                	mov    %esp,%ebp
  801450:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801453:	8b 45 08             	mov    0x8(%ebp),%eax
  801456:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801459:	8b 45 10             	mov    0x10(%ebp),%eax
  80145c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80145f:	eb 0e                	jmp    80146f <memset+0x22>
		*p++ = c;
  801461:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801464:	8d 50 01             	lea    0x1(%eax),%edx
  801467:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80146a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80146d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80146f:	ff 4d f8             	decl   -0x8(%ebp)
  801472:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801476:	79 e9                	jns    801461 <memset+0x14>
		*p++ = c;

	return v;
  801478:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80147b:	c9                   	leave  
  80147c:	c3                   	ret    

0080147d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80147d:	55                   	push   %ebp
  80147e:	89 e5                	mov    %esp,%ebp
  801480:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801483:	8b 45 0c             	mov    0xc(%ebp),%eax
  801486:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801489:	8b 45 08             	mov    0x8(%ebp),%eax
  80148c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80148f:	eb 16                	jmp    8014a7 <memcpy+0x2a>
		*d++ = *s++;
  801491:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801494:	8d 50 01             	lea    0x1(%eax),%edx
  801497:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80149a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80149d:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014a0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014a3:	8a 12                	mov    (%edx),%dl
  8014a5:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8014a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014aa:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014ad:	89 55 10             	mov    %edx,0x10(%ebp)
  8014b0:	85 c0                	test   %eax,%eax
  8014b2:	75 dd                	jne    801491 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8014b4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014b7:	c9                   	leave  
  8014b8:	c3                   	ret    

008014b9 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014b9:	55                   	push   %ebp
  8014ba:	89 e5                	mov    %esp,%ebp
  8014bc:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014ce:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014d1:	73 50                	jae    801523 <memmove+0x6a>
  8014d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d9:	01 d0                	add    %edx,%eax
  8014db:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014de:	76 43                	jbe    801523 <memmove+0x6a>
		s += n;
  8014e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e3:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e9:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014ec:	eb 10                	jmp    8014fe <memmove+0x45>
			*--d = *--s;
  8014ee:	ff 4d f8             	decl   -0x8(%ebp)
  8014f1:	ff 4d fc             	decl   -0x4(%ebp)
  8014f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014f7:	8a 10                	mov    (%eax),%dl
  8014f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014fc:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801501:	8d 50 ff             	lea    -0x1(%eax),%edx
  801504:	89 55 10             	mov    %edx,0x10(%ebp)
  801507:	85 c0                	test   %eax,%eax
  801509:	75 e3                	jne    8014ee <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80150b:	eb 23                	jmp    801530 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80150d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801510:	8d 50 01             	lea    0x1(%eax),%edx
  801513:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801516:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801519:	8d 4a 01             	lea    0x1(%edx),%ecx
  80151c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80151f:	8a 12                	mov    (%edx),%dl
  801521:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801523:	8b 45 10             	mov    0x10(%ebp),%eax
  801526:	8d 50 ff             	lea    -0x1(%eax),%edx
  801529:	89 55 10             	mov    %edx,0x10(%ebp)
  80152c:	85 c0                	test   %eax,%eax
  80152e:	75 dd                	jne    80150d <memmove+0x54>
			*d++ = *s++;

	return dst;
  801530:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801533:	c9                   	leave  
  801534:	c3                   	ret    

00801535 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801535:	55                   	push   %ebp
  801536:	89 e5                	mov    %esp,%ebp
  801538:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80153b:	8b 45 08             	mov    0x8(%ebp),%eax
  80153e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801541:	8b 45 0c             	mov    0xc(%ebp),%eax
  801544:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801547:	eb 2a                	jmp    801573 <memcmp+0x3e>
		if (*s1 != *s2)
  801549:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80154c:	8a 10                	mov    (%eax),%dl
  80154e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801551:	8a 00                	mov    (%eax),%al
  801553:	38 c2                	cmp    %al,%dl
  801555:	74 16                	je     80156d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801557:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80155a:	8a 00                	mov    (%eax),%al
  80155c:	0f b6 d0             	movzbl %al,%edx
  80155f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801562:	8a 00                	mov    (%eax),%al
  801564:	0f b6 c0             	movzbl %al,%eax
  801567:	29 c2                	sub    %eax,%edx
  801569:	89 d0                	mov    %edx,%eax
  80156b:	eb 18                	jmp    801585 <memcmp+0x50>
		s1++, s2++;
  80156d:	ff 45 fc             	incl   -0x4(%ebp)
  801570:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801573:	8b 45 10             	mov    0x10(%ebp),%eax
  801576:	8d 50 ff             	lea    -0x1(%eax),%edx
  801579:	89 55 10             	mov    %edx,0x10(%ebp)
  80157c:	85 c0                	test   %eax,%eax
  80157e:	75 c9                	jne    801549 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801580:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801585:	c9                   	leave  
  801586:	c3                   	ret    

00801587 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801587:	55                   	push   %ebp
  801588:	89 e5                	mov    %esp,%ebp
  80158a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80158d:	8b 55 08             	mov    0x8(%ebp),%edx
  801590:	8b 45 10             	mov    0x10(%ebp),%eax
  801593:	01 d0                	add    %edx,%eax
  801595:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801598:	eb 15                	jmp    8015af <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80159a:	8b 45 08             	mov    0x8(%ebp),%eax
  80159d:	8a 00                	mov    (%eax),%al
  80159f:	0f b6 d0             	movzbl %al,%edx
  8015a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a5:	0f b6 c0             	movzbl %al,%eax
  8015a8:	39 c2                	cmp    %eax,%edx
  8015aa:	74 0d                	je     8015b9 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015ac:	ff 45 08             	incl   0x8(%ebp)
  8015af:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015b5:	72 e3                	jb     80159a <memfind+0x13>
  8015b7:	eb 01                	jmp    8015ba <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015b9:	90                   	nop
	return (void *) s;
  8015ba:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015bd:	c9                   	leave  
  8015be:	c3                   	ret    

008015bf <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015bf:	55                   	push   %ebp
  8015c0:	89 e5                	mov    %esp,%ebp
  8015c2:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015c5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015cc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015d3:	eb 03                	jmp    8015d8 <strtol+0x19>
		s++;
  8015d5:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015db:	8a 00                	mov    (%eax),%al
  8015dd:	3c 20                	cmp    $0x20,%al
  8015df:	74 f4                	je     8015d5 <strtol+0x16>
  8015e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e4:	8a 00                	mov    (%eax),%al
  8015e6:	3c 09                	cmp    $0x9,%al
  8015e8:	74 eb                	je     8015d5 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ed:	8a 00                	mov    (%eax),%al
  8015ef:	3c 2b                	cmp    $0x2b,%al
  8015f1:	75 05                	jne    8015f8 <strtol+0x39>
		s++;
  8015f3:	ff 45 08             	incl   0x8(%ebp)
  8015f6:	eb 13                	jmp    80160b <strtol+0x4c>
	else if (*s == '-')
  8015f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fb:	8a 00                	mov    (%eax),%al
  8015fd:	3c 2d                	cmp    $0x2d,%al
  8015ff:	75 0a                	jne    80160b <strtol+0x4c>
		s++, neg = 1;
  801601:	ff 45 08             	incl   0x8(%ebp)
  801604:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80160b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80160f:	74 06                	je     801617 <strtol+0x58>
  801611:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801615:	75 20                	jne    801637 <strtol+0x78>
  801617:	8b 45 08             	mov    0x8(%ebp),%eax
  80161a:	8a 00                	mov    (%eax),%al
  80161c:	3c 30                	cmp    $0x30,%al
  80161e:	75 17                	jne    801637 <strtol+0x78>
  801620:	8b 45 08             	mov    0x8(%ebp),%eax
  801623:	40                   	inc    %eax
  801624:	8a 00                	mov    (%eax),%al
  801626:	3c 78                	cmp    $0x78,%al
  801628:	75 0d                	jne    801637 <strtol+0x78>
		s += 2, base = 16;
  80162a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80162e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801635:	eb 28                	jmp    80165f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801637:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80163b:	75 15                	jne    801652 <strtol+0x93>
  80163d:	8b 45 08             	mov    0x8(%ebp),%eax
  801640:	8a 00                	mov    (%eax),%al
  801642:	3c 30                	cmp    $0x30,%al
  801644:	75 0c                	jne    801652 <strtol+0x93>
		s++, base = 8;
  801646:	ff 45 08             	incl   0x8(%ebp)
  801649:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801650:	eb 0d                	jmp    80165f <strtol+0xa0>
	else if (base == 0)
  801652:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801656:	75 07                	jne    80165f <strtol+0xa0>
		base = 10;
  801658:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	8a 00                	mov    (%eax),%al
  801664:	3c 2f                	cmp    $0x2f,%al
  801666:	7e 19                	jle    801681 <strtol+0xc2>
  801668:	8b 45 08             	mov    0x8(%ebp),%eax
  80166b:	8a 00                	mov    (%eax),%al
  80166d:	3c 39                	cmp    $0x39,%al
  80166f:	7f 10                	jg     801681 <strtol+0xc2>
			dig = *s - '0';
  801671:	8b 45 08             	mov    0x8(%ebp),%eax
  801674:	8a 00                	mov    (%eax),%al
  801676:	0f be c0             	movsbl %al,%eax
  801679:	83 e8 30             	sub    $0x30,%eax
  80167c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80167f:	eb 42                	jmp    8016c3 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801681:	8b 45 08             	mov    0x8(%ebp),%eax
  801684:	8a 00                	mov    (%eax),%al
  801686:	3c 60                	cmp    $0x60,%al
  801688:	7e 19                	jle    8016a3 <strtol+0xe4>
  80168a:	8b 45 08             	mov    0x8(%ebp),%eax
  80168d:	8a 00                	mov    (%eax),%al
  80168f:	3c 7a                	cmp    $0x7a,%al
  801691:	7f 10                	jg     8016a3 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801693:	8b 45 08             	mov    0x8(%ebp),%eax
  801696:	8a 00                	mov    (%eax),%al
  801698:	0f be c0             	movsbl %al,%eax
  80169b:	83 e8 57             	sub    $0x57,%eax
  80169e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016a1:	eb 20                	jmp    8016c3 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a6:	8a 00                	mov    (%eax),%al
  8016a8:	3c 40                	cmp    $0x40,%al
  8016aa:	7e 39                	jle    8016e5 <strtol+0x126>
  8016ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8016af:	8a 00                	mov    (%eax),%al
  8016b1:	3c 5a                	cmp    $0x5a,%al
  8016b3:	7f 30                	jg     8016e5 <strtol+0x126>
			dig = *s - 'A' + 10;
  8016b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b8:	8a 00                	mov    (%eax),%al
  8016ba:	0f be c0             	movsbl %al,%eax
  8016bd:	83 e8 37             	sub    $0x37,%eax
  8016c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016c6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016c9:	7d 19                	jge    8016e4 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016cb:	ff 45 08             	incl   0x8(%ebp)
  8016ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016d1:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016d5:	89 c2                	mov    %eax,%edx
  8016d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016da:	01 d0                	add    %edx,%eax
  8016dc:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016df:	e9 7b ff ff ff       	jmp    80165f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016e4:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016e5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016e9:	74 08                	je     8016f3 <strtol+0x134>
		*endptr = (char *) s;
  8016eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ee:	8b 55 08             	mov    0x8(%ebp),%edx
  8016f1:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016f3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016f7:	74 07                	je     801700 <strtol+0x141>
  8016f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016fc:	f7 d8                	neg    %eax
  8016fe:	eb 03                	jmp    801703 <strtol+0x144>
  801700:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801703:	c9                   	leave  
  801704:	c3                   	ret    

00801705 <ltostr>:

void
ltostr(long value, char *str)
{
  801705:	55                   	push   %ebp
  801706:	89 e5                	mov    %esp,%ebp
  801708:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80170b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801712:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801719:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80171d:	79 13                	jns    801732 <ltostr+0x2d>
	{
		neg = 1;
  80171f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801726:	8b 45 0c             	mov    0xc(%ebp),%eax
  801729:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80172c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80172f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801732:	8b 45 08             	mov    0x8(%ebp),%eax
  801735:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80173a:	99                   	cltd   
  80173b:	f7 f9                	idiv   %ecx
  80173d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801740:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801743:	8d 50 01             	lea    0x1(%eax),%edx
  801746:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801749:	89 c2                	mov    %eax,%edx
  80174b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80174e:	01 d0                	add    %edx,%eax
  801750:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801753:	83 c2 30             	add    $0x30,%edx
  801756:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801758:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80175b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801760:	f7 e9                	imul   %ecx
  801762:	c1 fa 02             	sar    $0x2,%edx
  801765:	89 c8                	mov    %ecx,%eax
  801767:	c1 f8 1f             	sar    $0x1f,%eax
  80176a:	29 c2                	sub    %eax,%edx
  80176c:	89 d0                	mov    %edx,%eax
  80176e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801771:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801774:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801779:	f7 e9                	imul   %ecx
  80177b:	c1 fa 02             	sar    $0x2,%edx
  80177e:	89 c8                	mov    %ecx,%eax
  801780:	c1 f8 1f             	sar    $0x1f,%eax
  801783:	29 c2                	sub    %eax,%edx
  801785:	89 d0                	mov    %edx,%eax
  801787:	c1 e0 02             	shl    $0x2,%eax
  80178a:	01 d0                	add    %edx,%eax
  80178c:	01 c0                	add    %eax,%eax
  80178e:	29 c1                	sub    %eax,%ecx
  801790:	89 ca                	mov    %ecx,%edx
  801792:	85 d2                	test   %edx,%edx
  801794:	75 9c                	jne    801732 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801796:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80179d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017a0:	48                   	dec    %eax
  8017a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017a4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017a8:	74 3d                	je     8017e7 <ltostr+0xe2>
		start = 1 ;
  8017aa:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017b1:	eb 34                	jmp    8017e7 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8017b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b9:	01 d0                	add    %edx,%eax
  8017bb:	8a 00                	mov    (%eax),%al
  8017bd:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c6:	01 c2                	add    %eax,%edx
  8017c8:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ce:	01 c8                	add    %ecx,%eax
  8017d0:	8a 00                	mov    (%eax),%al
  8017d2:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017d4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017da:	01 c2                	add    %eax,%edx
  8017dc:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017df:	88 02                	mov    %al,(%edx)
		start++ ;
  8017e1:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017e4:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017ea:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017ed:	7c c4                	jl     8017b3 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017ef:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017f5:	01 d0                	add    %edx,%eax
  8017f7:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017fa:	90                   	nop
  8017fb:	c9                   	leave  
  8017fc:	c3                   	ret    

008017fd <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017fd:	55                   	push   %ebp
  8017fe:	89 e5                	mov    %esp,%ebp
  801800:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801803:	ff 75 08             	pushl  0x8(%ebp)
  801806:	e8 54 fa ff ff       	call   80125f <strlen>
  80180b:	83 c4 04             	add    $0x4,%esp
  80180e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801811:	ff 75 0c             	pushl  0xc(%ebp)
  801814:	e8 46 fa ff ff       	call   80125f <strlen>
  801819:	83 c4 04             	add    $0x4,%esp
  80181c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80181f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801826:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80182d:	eb 17                	jmp    801846 <strcconcat+0x49>
		final[s] = str1[s] ;
  80182f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801832:	8b 45 10             	mov    0x10(%ebp),%eax
  801835:	01 c2                	add    %eax,%edx
  801837:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80183a:	8b 45 08             	mov    0x8(%ebp),%eax
  80183d:	01 c8                	add    %ecx,%eax
  80183f:	8a 00                	mov    (%eax),%al
  801841:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801843:	ff 45 fc             	incl   -0x4(%ebp)
  801846:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801849:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80184c:	7c e1                	jl     80182f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80184e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801855:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80185c:	eb 1f                	jmp    80187d <strcconcat+0x80>
		final[s++] = str2[i] ;
  80185e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801861:	8d 50 01             	lea    0x1(%eax),%edx
  801864:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801867:	89 c2                	mov    %eax,%edx
  801869:	8b 45 10             	mov    0x10(%ebp),%eax
  80186c:	01 c2                	add    %eax,%edx
  80186e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801871:	8b 45 0c             	mov    0xc(%ebp),%eax
  801874:	01 c8                	add    %ecx,%eax
  801876:	8a 00                	mov    (%eax),%al
  801878:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80187a:	ff 45 f8             	incl   -0x8(%ebp)
  80187d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801880:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801883:	7c d9                	jl     80185e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801885:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801888:	8b 45 10             	mov    0x10(%ebp),%eax
  80188b:	01 d0                	add    %edx,%eax
  80188d:	c6 00 00             	movb   $0x0,(%eax)
}
  801890:	90                   	nop
  801891:	c9                   	leave  
  801892:	c3                   	ret    

00801893 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801893:	55                   	push   %ebp
  801894:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801896:	8b 45 14             	mov    0x14(%ebp),%eax
  801899:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80189f:	8b 45 14             	mov    0x14(%ebp),%eax
  8018a2:	8b 00                	mov    (%eax),%eax
  8018a4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ae:	01 d0                	add    %edx,%eax
  8018b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018b6:	eb 0c                	jmp    8018c4 <strsplit+0x31>
			*string++ = 0;
  8018b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bb:	8d 50 01             	lea    0x1(%eax),%edx
  8018be:	89 55 08             	mov    %edx,0x8(%ebp)
  8018c1:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c7:	8a 00                	mov    (%eax),%al
  8018c9:	84 c0                	test   %al,%al
  8018cb:	74 18                	je     8018e5 <strsplit+0x52>
  8018cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d0:	8a 00                	mov    (%eax),%al
  8018d2:	0f be c0             	movsbl %al,%eax
  8018d5:	50                   	push   %eax
  8018d6:	ff 75 0c             	pushl  0xc(%ebp)
  8018d9:	e8 13 fb ff ff       	call   8013f1 <strchr>
  8018de:	83 c4 08             	add    $0x8,%esp
  8018e1:	85 c0                	test   %eax,%eax
  8018e3:	75 d3                	jne    8018b8 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8018e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e8:	8a 00                	mov    (%eax),%al
  8018ea:	84 c0                	test   %al,%al
  8018ec:	74 5a                	je     801948 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8018ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8018f1:	8b 00                	mov    (%eax),%eax
  8018f3:	83 f8 0f             	cmp    $0xf,%eax
  8018f6:	75 07                	jne    8018ff <strsplit+0x6c>
		{
			return 0;
  8018f8:	b8 00 00 00 00       	mov    $0x0,%eax
  8018fd:	eb 66                	jmp    801965 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018ff:	8b 45 14             	mov    0x14(%ebp),%eax
  801902:	8b 00                	mov    (%eax),%eax
  801904:	8d 48 01             	lea    0x1(%eax),%ecx
  801907:	8b 55 14             	mov    0x14(%ebp),%edx
  80190a:	89 0a                	mov    %ecx,(%edx)
  80190c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801913:	8b 45 10             	mov    0x10(%ebp),%eax
  801916:	01 c2                	add    %eax,%edx
  801918:	8b 45 08             	mov    0x8(%ebp),%eax
  80191b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80191d:	eb 03                	jmp    801922 <strsplit+0x8f>
			string++;
  80191f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801922:	8b 45 08             	mov    0x8(%ebp),%eax
  801925:	8a 00                	mov    (%eax),%al
  801927:	84 c0                	test   %al,%al
  801929:	74 8b                	je     8018b6 <strsplit+0x23>
  80192b:	8b 45 08             	mov    0x8(%ebp),%eax
  80192e:	8a 00                	mov    (%eax),%al
  801930:	0f be c0             	movsbl %al,%eax
  801933:	50                   	push   %eax
  801934:	ff 75 0c             	pushl  0xc(%ebp)
  801937:	e8 b5 fa ff ff       	call   8013f1 <strchr>
  80193c:	83 c4 08             	add    $0x8,%esp
  80193f:	85 c0                	test   %eax,%eax
  801941:	74 dc                	je     80191f <strsplit+0x8c>
			string++;
	}
  801943:	e9 6e ff ff ff       	jmp    8018b6 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801948:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801949:	8b 45 14             	mov    0x14(%ebp),%eax
  80194c:	8b 00                	mov    (%eax),%eax
  80194e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801955:	8b 45 10             	mov    0x10(%ebp),%eax
  801958:	01 d0                	add    %edx,%eax
  80195a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801960:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801965:	c9                   	leave  
  801966:	c3                   	ret    

00801967 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801967:	55                   	push   %ebp
  801968:	89 e5                	mov    %esp,%ebp
  80196a:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  80196d:	e8 3b 09 00 00       	call   8022ad <sys_isUHeapPlacementStrategyFIRSTFIT>
  801972:	85 c0                	test   %eax,%eax
  801974:	0f 84 3a 01 00 00    	je     801ab4 <malloc+0x14d>

		if(pl == 0){
  80197a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80197f:	85 c0                	test   %eax,%eax
  801981:	75 24                	jne    8019a7 <malloc+0x40>
			for(int k = 0; k < Size; k++){
  801983:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80198a:	eb 11                	jmp    80199d <malloc+0x36>
				arr[k] = -10000;
  80198c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80198f:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801996:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  80199a:	ff 45 f4             	incl   -0xc(%ebp)
  80199d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019a0:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8019a5:	76 e5                	jbe    80198c <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  8019a7:	c7 05 2c 30 80 00 01 	movl   $0x1,0x80302c
  8019ae:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  8019b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b4:	c1 e8 0c             	shr    $0xc,%eax
  8019b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  8019ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bd:	25 ff 0f 00 00       	and    $0xfff,%eax
  8019c2:	85 c0                	test   %eax,%eax
  8019c4:	74 03                	je     8019c9 <malloc+0x62>
			x++;
  8019c6:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  8019c9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  8019d0:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  8019d7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8019de:	eb 66                	jmp    801a46 <malloc+0xdf>
			if( arr[k] == -10000){
  8019e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8019e3:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8019ea:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  8019ef:	75 52                	jne    801a43 <malloc+0xdc>
				uint32 w = 0 ;
  8019f1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  8019f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8019fb:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  8019fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a01:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801a04:	eb 09                	jmp    801a0f <malloc+0xa8>
  801a06:	ff 45 e0             	incl   -0x20(%ebp)
  801a09:	ff 45 dc             	incl   -0x24(%ebp)
  801a0c:	ff 45 e4             	incl   -0x1c(%ebp)
  801a0f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801a12:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801a17:	77 19                	ja     801a32 <malloc+0xcb>
  801a19:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801a1c:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801a23:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801a28:	75 08                	jne    801a32 <malloc+0xcb>
  801a2a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a2d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a30:	72 d4                	jb     801a06 <malloc+0x9f>
				if(w >= x){
  801a32:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a35:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a38:	72 09                	jb     801a43 <malloc+0xdc>
					p = 1 ;
  801a3a:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  801a41:	eb 0d                	jmp    801a50 <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801a43:	ff 45 e4             	incl   -0x1c(%ebp)
  801a46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a49:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801a4e:	76 90                	jbe    8019e0 <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  801a50:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801a54:	75 0a                	jne    801a60 <malloc+0xf9>
  801a56:	b8 00 00 00 00       	mov    $0x0,%eax
  801a5b:	e9 ca 01 00 00       	jmp    801c2a <malloc+0x2c3>
		int q = idx;
  801a60:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a63:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  801a66:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801a6d:	eb 16                	jmp    801a85 <malloc+0x11e>
			arr[q++] = x;
  801a6f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a72:	8d 50 01             	lea    0x1(%eax),%edx
  801a75:	89 55 d8             	mov    %edx,-0x28(%ebp)
  801a78:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a7b:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  801a82:	ff 45 d4             	incl   -0x2c(%ebp)
  801a85:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a88:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a8b:	72 e2                	jb     801a6f <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801a8d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a90:	05 00 00 08 00       	add    $0x80000,%eax
  801a95:	c1 e0 0c             	shl    $0xc,%eax
  801a98:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  801a9b:	83 ec 08             	sub    $0x8,%esp
  801a9e:	ff 75 f0             	pushl  -0x10(%ebp)
  801aa1:	ff 75 ac             	pushl  -0x54(%ebp)
  801aa4:	e8 9b 04 00 00       	call   801f44 <sys_allocateMem>
  801aa9:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801aac:	8b 45 ac             	mov    -0x54(%ebp),%eax
  801aaf:	e9 76 01 00 00       	jmp    801c2a <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  801ab4:	e8 25 08 00 00       	call   8022de <sys_isUHeapPlacementStrategyBESTFIT>
  801ab9:	85 c0                	test   %eax,%eax
  801abb:	0f 84 64 01 00 00    	je     801c25 <malloc+0x2be>
		if(pl == 0){
  801ac1:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801ac6:	85 c0                	test   %eax,%eax
  801ac8:	75 24                	jne    801aee <malloc+0x187>
			for(int k = 0; k < Size; k++){
  801aca:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  801ad1:	eb 11                	jmp    801ae4 <malloc+0x17d>
				arr[k] = -10000;
  801ad3:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ad6:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801add:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801ae1:	ff 45 d0             	incl   -0x30(%ebp)
  801ae4:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ae7:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801aec:	76 e5                	jbe    801ad3 <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801aee:	c7 05 2c 30 80 00 01 	movl   $0x1,0x80302c
  801af5:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801af8:	8b 45 08             	mov    0x8(%ebp),%eax
  801afb:	c1 e8 0c             	shr    $0xc,%eax
  801afe:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  801b01:	8b 45 08             	mov    0x8(%ebp),%eax
  801b04:	25 ff 0f 00 00       	and    $0xfff,%eax
  801b09:	85 c0                	test   %eax,%eax
  801b0b:	74 03                	je     801b10 <malloc+0x1a9>
			x++;
  801b0d:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  801b10:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  801b17:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  801b1e:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  801b25:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  801b2c:	e9 88 00 00 00       	jmp    801bb9 <malloc+0x252>
			if(arr[k] == -10000){
  801b31:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801b34:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801b3b:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801b40:	75 64                	jne    801ba6 <malloc+0x23f>
				uint32 w = 0 , i;
  801b42:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  801b49:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801b4c:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  801b4f:	eb 06                	jmp    801b57 <malloc+0x1f0>
  801b51:	ff 45 b8             	incl   -0x48(%ebp)
  801b54:	ff 45 b4             	incl   -0x4c(%ebp)
  801b57:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  801b5e:	77 11                	ja     801b71 <malloc+0x20a>
  801b60:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801b63:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801b6a:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801b6f:	74 e0                	je     801b51 <malloc+0x1ea>
				if(w <q && w >= x){
  801b71:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801b74:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  801b77:	73 24                	jae    801b9d <malloc+0x236>
  801b79:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801b7c:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801b7f:	72 1c                	jb     801b9d <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  801b81:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801b84:	89 45 c8             	mov    %eax,-0x38(%ebp)
  801b87:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  801b8e:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801b91:	89 45 c0             	mov    %eax,-0x40(%ebp)
  801b94:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801b97:	48                   	dec    %eax
  801b98:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801b9b:	eb 19                	jmp    801bb6 <malloc+0x24f>
				}
				else {
					k = i - 1;
  801b9d:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801ba0:	48                   	dec    %eax
  801ba1:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801ba4:	eb 10                	jmp    801bb6 <malloc+0x24f>
				}
			} else {
				k += arr[k];
  801ba6:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801ba9:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801bb0:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  801bb3:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  801bb6:	ff 45 bc             	incl   -0x44(%ebp)
  801bb9:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801bbc:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801bc1:	0f 86 6a ff ff ff    	jbe    801b31 <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  801bc7:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  801bcb:	75 07                	jne    801bd4 <malloc+0x26d>
  801bcd:	b8 00 00 00 00       	mov    $0x0,%eax
  801bd2:	eb 56                	jmp    801c2a <malloc+0x2c3>
	    q = idx;
  801bd4:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801bd7:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  801bda:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  801be1:	eb 16                	jmp    801bf9 <malloc+0x292>
			arr[q++] = x;
  801be3:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801be6:	8d 50 01             	lea    0x1(%eax),%edx
  801be9:	89 55 c8             	mov    %edx,-0x38(%ebp)
  801bec:	8b 55 cc             	mov    -0x34(%ebp),%edx
  801bef:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  801bf6:	ff 45 b0             	incl   -0x50(%ebp)
  801bf9:	8b 45 b0             	mov    -0x50(%ebp),%eax
  801bfc:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801bff:	72 e2                	jb     801be3 <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801c01:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801c04:	05 00 00 08 00       	add    $0x80000,%eax
  801c09:	c1 e0 0c             	shl    $0xc,%eax
  801c0c:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  801c0f:	83 ec 08             	sub    $0x8,%esp
  801c12:	ff 75 cc             	pushl  -0x34(%ebp)
  801c15:	ff 75 a8             	pushl  -0x58(%ebp)
  801c18:	e8 27 03 00 00       	call   801f44 <sys_allocateMem>
  801c1d:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801c20:	8b 45 a8             	mov    -0x58(%ebp),%eax
  801c23:	eb 05                	jmp    801c2a <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  801c25:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c2a:	c9                   	leave  
  801c2b:	c3                   	ret    

00801c2c <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801c2c:	55                   	push   %ebp
  801c2d:	89 e5                	mov    %esp,%ebp
  801c2f:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  801c32:	8b 45 08             	mov    0x8(%ebp),%eax
  801c35:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801c38:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c3b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801c40:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  801c43:	8b 45 08             	mov    0x8(%ebp),%eax
  801c46:	05 00 00 00 80       	add    $0x80000000,%eax
  801c4b:	c1 e8 0c             	shr    $0xc,%eax
  801c4e:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801c55:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801c58:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801c5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c62:	05 00 00 00 80       	add    $0x80000000,%eax
  801c67:	c1 e8 0c             	shr    $0xc,%eax
  801c6a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c6d:	eb 14                	jmp    801c83 <free+0x57>
		arr[j] = -10000;
  801c6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c72:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801c79:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801c7d:	ff 45 f4             	incl   -0xc(%ebp)
  801c80:	ff 45 f0             	incl   -0x10(%ebp)
  801c83:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c86:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801c89:	72 e4                	jb     801c6f <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  801c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c8e:	83 ec 08             	sub    $0x8,%esp
  801c91:	ff 75 e8             	pushl  -0x18(%ebp)
  801c94:	50                   	push   %eax
  801c95:	e8 8e 02 00 00       	call   801f28 <sys_freeMem>
  801c9a:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  801c9d:	90                   	nop
  801c9e:	c9                   	leave  
  801c9f:	c3                   	ret    

00801ca0 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801ca0:	55                   	push   %ebp
  801ca1:	89 e5                	mov    %esp,%ebp
  801ca3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ca6:	83 ec 04             	sub    $0x4,%esp
  801ca9:	68 84 2d 80 00       	push   $0x802d84
  801cae:	68 9e 00 00 00       	push   $0x9e
  801cb3:	68 a7 2d 80 00       	push   $0x802da7
  801cb8:	e8 63 ea ff ff       	call   800720 <_panic>

00801cbd <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801cbd:	55                   	push   %ebp
  801cbe:	89 e5                	mov    %esp,%ebp
  801cc0:	83 ec 18             	sub    $0x18,%esp
  801cc3:	8b 45 10             	mov    0x10(%ebp),%eax
  801cc6:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801cc9:	83 ec 04             	sub    $0x4,%esp
  801ccc:	68 84 2d 80 00       	push   $0x802d84
  801cd1:	68 a9 00 00 00       	push   $0xa9
  801cd6:	68 a7 2d 80 00       	push   $0x802da7
  801cdb:	e8 40 ea ff ff       	call   800720 <_panic>

00801ce0 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801ce0:	55                   	push   %ebp
  801ce1:	89 e5                	mov    %esp,%ebp
  801ce3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ce6:	83 ec 04             	sub    $0x4,%esp
  801ce9:	68 84 2d 80 00       	push   $0x802d84
  801cee:	68 af 00 00 00       	push   $0xaf
  801cf3:	68 a7 2d 80 00       	push   $0x802da7
  801cf8:	e8 23 ea ff ff       	call   800720 <_panic>

00801cfd <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801cfd:	55                   	push   %ebp
  801cfe:	89 e5                	mov    %esp,%ebp
  801d00:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d03:	83 ec 04             	sub    $0x4,%esp
  801d06:	68 84 2d 80 00       	push   $0x802d84
  801d0b:	68 b5 00 00 00       	push   $0xb5
  801d10:	68 a7 2d 80 00       	push   $0x802da7
  801d15:	e8 06 ea ff ff       	call   800720 <_panic>

00801d1a <expand>:
}

void expand(uint32 newSize)
{
  801d1a:	55                   	push   %ebp
  801d1b:	89 e5                	mov    %esp,%ebp
  801d1d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d20:	83 ec 04             	sub    $0x4,%esp
  801d23:	68 84 2d 80 00       	push   $0x802d84
  801d28:	68 ba 00 00 00       	push   $0xba
  801d2d:	68 a7 2d 80 00       	push   $0x802da7
  801d32:	e8 e9 e9 ff ff       	call   800720 <_panic>

00801d37 <shrink>:
}
void shrink(uint32 newSize)
{
  801d37:	55                   	push   %ebp
  801d38:	89 e5                	mov    %esp,%ebp
  801d3a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d3d:	83 ec 04             	sub    $0x4,%esp
  801d40:	68 84 2d 80 00       	push   $0x802d84
  801d45:	68 be 00 00 00       	push   $0xbe
  801d4a:	68 a7 2d 80 00       	push   $0x802da7
  801d4f:	e8 cc e9 ff ff       	call   800720 <_panic>

00801d54 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801d54:	55                   	push   %ebp
  801d55:	89 e5                	mov    %esp,%ebp
  801d57:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d5a:	83 ec 04             	sub    $0x4,%esp
  801d5d:	68 84 2d 80 00       	push   $0x802d84
  801d62:	68 c3 00 00 00       	push   $0xc3
  801d67:	68 a7 2d 80 00       	push   $0x802da7
  801d6c:	e8 af e9 ff ff       	call   800720 <_panic>

00801d71 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801d71:	55                   	push   %ebp
  801d72:	89 e5                	mov    %esp,%ebp
  801d74:	57                   	push   %edi
  801d75:	56                   	push   %esi
  801d76:	53                   	push   %ebx
  801d77:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d80:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d83:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d86:	8b 7d 18             	mov    0x18(%ebp),%edi
  801d89:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801d8c:	cd 30                	int    $0x30
  801d8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801d91:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d94:	83 c4 10             	add    $0x10,%esp
  801d97:	5b                   	pop    %ebx
  801d98:	5e                   	pop    %esi
  801d99:	5f                   	pop    %edi
  801d9a:	5d                   	pop    %ebp
  801d9b:	c3                   	ret    

00801d9c <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801d9c:	55                   	push   %ebp
  801d9d:	89 e5                	mov    %esp,%ebp
  801d9f:	83 ec 04             	sub    $0x4,%esp
  801da2:	8b 45 10             	mov    0x10(%ebp),%eax
  801da5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801da8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801dac:	8b 45 08             	mov    0x8(%ebp),%eax
  801daf:	6a 00                	push   $0x0
  801db1:	6a 00                	push   $0x0
  801db3:	52                   	push   %edx
  801db4:	ff 75 0c             	pushl  0xc(%ebp)
  801db7:	50                   	push   %eax
  801db8:	6a 00                	push   $0x0
  801dba:	e8 b2 ff ff ff       	call   801d71 <syscall>
  801dbf:	83 c4 18             	add    $0x18,%esp
}
  801dc2:	90                   	nop
  801dc3:	c9                   	leave  
  801dc4:	c3                   	ret    

00801dc5 <sys_cgetc>:

int
sys_cgetc(void)
{
  801dc5:	55                   	push   %ebp
  801dc6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801dc8:	6a 00                	push   $0x0
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	6a 00                	push   $0x0
  801dd2:	6a 01                	push   $0x1
  801dd4:	e8 98 ff ff ff       	call   801d71 <syscall>
  801dd9:	83 c4 18             	add    $0x18,%esp
}
  801ddc:	c9                   	leave  
  801ddd:	c3                   	ret    

00801dde <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801dde:	55                   	push   %ebp
  801ddf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801de1:	8b 45 08             	mov    0x8(%ebp),%eax
  801de4:	6a 00                	push   $0x0
  801de6:	6a 00                	push   $0x0
  801de8:	6a 00                	push   $0x0
  801dea:	6a 00                	push   $0x0
  801dec:	50                   	push   %eax
  801ded:	6a 05                	push   $0x5
  801def:	e8 7d ff ff ff       	call   801d71 <syscall>
  801df4:	83 c4 18             	add    $0x18,%esp
}
  801df7:	c9                   	leave  
  801df8:	c3                   	ret    

00801df9 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801df9:	55                   	push   %ebp
  801dfa:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801dfc:	6a 00                	push   $0x0
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 00                	push   $0x0
  801e04:	6a 00                	push   $0x0
  801e06:	6a 02                	push   $0x2
  801e08:	e8 64 ff ff ff       	call   801d71 <syscall>
  801e0d:	83 c4 18             	add    $0x18,%esp
}
  801e10:	c9                   	leave  
  801e11:	c3                   	ret    

00801e12 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801e12:	55                   	push   %ebp
  801e13:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801e15:	6a 00                	push   $0x0
  801e17:	6a 00                	push   $0x0
  801e19:	6a 00                	push   $0x0
  801e1b:	6a 00                	push   $0x0
  801e1d:	6a 00                	push   $0x0
  801e1f:	6a 03                	push   $0x3
  801e21:	e8 4b ff ff ff       	call   801d71 <syscall>
  801e26:	83 c4 18             	add    $0x18,%esp
}
  801e29:	c9                   	leave  
  801e2a:	c3                   	ret    

00801e2b <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e2b:	55                   	push   %ebp
  801e2c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	6a 00                	push   $0x0
  801e38:	6a 04                	push   $0x4
  801e3a:	e8 32 ff ff ff       	call   801d71 <syscall>
  801e3f:	83 c4 18             	add    $0x18,%esp
}
  801e42:	c9                   	leave  
  801e43:	c3                   	ret    

00801e44 <sys_env_exit>:


void sys_env_exit(void)
{
  801e44:	55                   	push   %ebp
  801e45:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801e47:	6a 00                	push   $0x0
  801e49:	6a 00                	push   $0x0
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 06                	push   $0x6
  801e53:	e8 19 ff ff ff       	call   801d71 <syscall>
  801e58:	83 c4 18             	add    $0x18,%esp
}
  801e5b:	90                   	nop
  801e5c:	c9                   	leave  
  801e5d:	c3                   	ret    

00801e5e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801e5e:	55                   	push   %ebp
  801e5f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801e61:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e64:	8b 45 08             	mov    0x8(%ebp),%eax
  801e67:	6a 00                	push   $0x0
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 00                	push   $0x0
  801e6d:	52                   	push   %edx
  801e6e:	50                   	push   %eax
  801e6f:	6a 07                	push   $0x7
  801e71:	e8 fb fe ff ff       	call   801d71 <syscall>
  801e76:	83 c4 18             	add    $0x18,%esp
}
  801e79:	c9                   	leave  
  801e7a:	c3                   	ret    

00801e7b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801e7b:	55                   	push   %ebp
  801e7c:	89 e5                	mov    %esp,%ebp
  801e7e:	56                   	push   %esi
  801e7f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801e80:	8b 75 18             	mov    0x18(%ebp),%esi
  801e83:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e86:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e89:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8f:	56                   	push   %esi
  801e90:	53                   	push   %ebx
  801e91:	51                   	push   %ecx
  801e92:	52                   	push   %edx
  801e93:	50                   	push   %eax
  801e94:	6a 08                	push   $0x8
  801e96:	e8 d6 fe ff ff       	call   801d71 <syscall>
  801e9b:	83 c4 18             	add    $0x18,%esp
}
  801e9e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ea1:	5b                   	pop    %ebx
  801ea2:	5e                   	pop    %esi
  801ea3:	5d                   	pop    %ebp
  801ea4:	c3                   	ret    

00801ea5 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801ea5:	55                   	push   %ebp
  801ea6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801ea8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eab:	8b 45 08             	mov    0x8(%ebp),%eax
  801eae:	6a 00                	push   $0x0
  801eb0:	6a 00                	push   $0x0
  801eb2:	6a 00                	push   $0x0
  801eb4:	52                   	push   %edx
  801eb5:	50                   	push   %eax
  801eb6:	6a 09                	push   $0x9
  801eb8:	e8 b4 fe ff ff       	call   801d71 <syscall>
  801ebd:	83 c4 18             	add    $0x18,%esp
}
  801ec0:	c9                   	leave  
  801ec1:	c3                   	ret    

00801ec2 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801ec2:	55                   	push   %ebp
  801ec3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801ec5:	6a 00                	push   $0x0
  801ec7:	6a 00                	push   $0x0
  801ec9:	6a 00                	push   $0x0
  801ecb:	ff 75 0c             	pushl  0xc(%ebp)
  801ece:	ff 75 08             	pushl  0x8(%ebp)
  801ed1:	6a 0a                	push   $0xa
  801ed3:	e8 99 fe ff ff       	call   801d71 <syscall>
  801ed8:	83 c4 18             	add    $0x18,%esp
}
  801edb:	c9                   	leave  
  801edc:	c3                   	ret    

00801edd <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801edd:	55                   	push   %ebp
  801ede:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801ee0:	6a 00                	push   $0x0
  801ee2:	6a 00                	push   $0x0
  801ee4:	6a 00                	push   $0x0
  801ee6:	6a 00                	push   $0x0
  801ee8:	6a 00                	push   $0x0
  801eea:	6a 0b                	push   $0xb
  801eec:	e8 80 fe ff ff       	call   801d71 <syscall>
  801ef1:	83 c4 18             	add    $0x18,%esp
}
  801ef4:	c9                   	leave  
  801ef5:	c3                   	ret    

00801ef6 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801ef6:	55                   	push   %ebp
  801ef7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801ef9:	6a 00                	push   $0x0
  801efb:	6a 00                	push   $0x0
  801efd:	6a 00                	push   $0x0
  801eff:	6a 00                	push   $0x0
  801f01:	6a 00                	push   $0x0
  801f03:	6a 0c                	push   $0xc
  801f05:	e8 67 fe ff ff       	call   801d71 <syscall>
  801f0a:	83 c4 18             	add    $0x18,%esp
}
  801f0d:	c9                   	leave  
  801f0e:	c3                   	ret    

00801f0f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801f0f:	55                   	push   %ebp
  801f10:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801f12:	6a 00                	push   $0x0
  801f14:	6a 00                	push   $0x0
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 0d                	push   $0xd
  801f1e:	e8 4e fe ff ff       	call   801d71 <syscall>
  801f23:	83 c4 18             	add    $0x18,%esp
}
  801f26:	c9                   	leave  
  801f27:	c3                   	ret    

00801f28 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801f28:	55                   	push   %ebp
  801f29:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801f2b:	6a 00                	push   $0x0
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 00                	push   $0x0
  801f31:	ff 75 0c             	pushl  0xc(%ebp)
  801f34:	ff 75 08             	pushl  0x8(%ebp)
  801f37:	6a 11                	push   $0x11
  801f39:	e8 33 fe ff ff       	call   801d71 <syscall>
  801f3e:	83 c4 18             	add    $0x18,%esp
	return;
  801f41:	90                   	nop
}
  801f42:	c9                   	leave  
  801f43:	c3                   	ret    

00801f44 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801f44:	55                   	push   %ebp
  801f45:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801f47:	6a 00                	push   $0x0
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	ff 75 0c             	pushl  0xc(%ebp)
  801f50:	ff 75 08             	pushl  0x8(%ebp)
  801f53:	6a 12                	push   $0x12
  801f55:	e8 17 fe ff ff       	call   801d71 <syscall>
  801f5a:	83 c4 18             	add    $0x18,%esp
	return ;
  801f5d:	90                   	nop
}
  801f5e:	c9                   	leave  
  801f5f:	c3                   	ret    

00801f60 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801f60:	55                   	push   %ebp
  801f61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801f63:	6a 00                	push   $0x0
  801f65:	6a 00                	push   $0x0
  801f67:	6a 00                	push   $0x0
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 00                	push   $0x0
  801f6d:	6a 0e                	push   $0xe
  801f6f:	e8 fd fd ff ff       	call   801d71 <syscall>
  801f74:	83 c4 18             	add    $0x18,%esp
}
  801f77:	c9                   	leave  
  801f78:	c3                   	ret    

00801f79 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801f79:	55                   	push   %ebp
  801f7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801f7c:	6a 00                	push   $0x0
  801f7e:	6a 00                	push   $0x0
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	ff 75 08             	pushl  0x8(%ebp)
  801f87:	6a 0f                	push   $0xf
  801f89:	e8 e3 fd ff ff       	call   801d71 <syscall>
  801f8e:	83 c4 18             	add    $0x18,%esp
}
  801f91:	c9                   	leave  
  801f92:	c3                   	ret    

00801f93 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801f93:	55                   	push   %ebp
  801f94:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801f96:	6a 00                	push   $0x0
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 00                	push   $0x0
  801f9c:	6a 00                	push   $0x0
  801f9e:	6a 00                	push   $0x0
  801fa0:	6a 10                	push   $0x10
  801fa2:	e8 ca fd ff ff       	call   801d71 <syscall>
  801fa7:	83 c4 18             	add    $0x18,%esp
}
  801faa:	90                   	nop
  801fab:	c9                   	leave  
  801fac:	c3                   	ret    

00801fad <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801fad:	55                   	push   %ebp
  801fae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801fb0:	6a 00                	push   $0x0
  801fb2:	6a 00                	push   $0x0
  801fb4:	6a 00                	push   $0x0
  801fb6:	6a 00                	push   $0x0
  801fb8:	6a 00                	push   $0x0
  801fba:	6a 14                	push   $0x14
  801fbc:	e8 b0 fd ff ff       	call   801d71 <syscall>
  801fc1:	83 c4 18             	add    $0x18,%esp
}
  801fc4:	90                   	nop
  801fc5:	c9                   	leave  
  801fc6:	c3                   	ret    

00801fc7 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801fc7:	55                   	push   %ebp
  801fc8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801fca:	6a 00                	push   $0x0
  801fcc:	6a 00                	push   $0x0
  801fce:	6a 00                	push   $0x0
  801fd0:	6a 00                	push   $0x0
  801fd2:	6a 00                	push   $0x0
  801fd4:	6a 15                	push   $0x15
  801fd6:	e8 96 fd ff ff       	call   801d71 <syscall>
  801fdb:	83 c4 18             	add    $0x18,%esp
}
  801fde:	90                   	nop
  801fdf:	c9                   	leave  
  801fe0:	c3                   	ret    

00801fe1 <sys_cputc>:


void
sys_cputc(const char c)
{
  801fe1:	55                   	push   %ebp
  801fe2:	89 e5                	mov    %esp,%ebp
  801fe4:	83 ec 04             	sub    $0x4,%esp
  801fe7:	8b 45 08             	mov    0x8(%ebp),%eax
  801fea:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801fed:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 00                	push   $0x0
  801ff7:	6a 00                	push   $0x0
  801ff9:	50                   	push   %eax
  801ffa:	6a 16                	push   $0x16
  801ffc:	e8 70 fd ff ff       	call   801d71 <syscall>
  802001:	83 c4 18             	add    $0x18,%esp
}
  802004:	90                   	nop
  802005:	c9                   	leave  
  802006:	c3                   	ret    

00802007 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802007:	55                   	push   %ebp
  802008:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80200a:	6a 00                	push   $0x0
  80200c:	6a 00                	push   $0x0
  80200e:	6a 00                	push   $0x0
  802010:	6a 00                	push   $0x0
  802012:	6a 00                	push   $0x0
  802014:	6a 17                	push   $0x17
  802016:	e8 56 fd ff ff       	call   801d71 <syscall>
  80201b:	83 c4 18             	add    $0x18,%esp
}
  80201e:	90                   	nop
  80201f:	c9                   	leave  
  802020:	c3                   	ret    

00802021 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802021:	55                   	push   %ebp
  802022:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802024:	8b 45 08             	mov    0x8(%ebp),%eax
  802027:	6a 00                	push   $0x0
  802029:	6a 00                	push   $0x0
  80202b:	6a 00                	push   $0x0
  80202d:	ff 75 0c             	pushl  0xc(%ebp)
  802030:	50                   	push   %eax
  802031:	6a 18                	push   $0x18
  802033:	e8 39 fd ff ff       	call   801d71 <syscall>
  802038:	83 c4 18             	add    $0x18,%esp
}
  80203b:	c9                   	leave  
  80203c:	c3                   	ret    

0080203d <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80203d:	55                   	push   %ebp
  80203e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802040:	8b 55 0c             	mov    0xc(%ebp),%edx
  802043:	8b 45 08             	mov    0x8(%ebp),%eax
  802046:	6a 00                	push   $0x0
  802048:	6a 00                	push   $0x0
  80204a:	6a 00                	push   $0x0
  80204c:	52                   	push   %edx
  80204d:	50                   	push   %eax
  80204e:	6a 1b                	push   $0x1b
  802050:	e8 1c fd ff ff       	call   801d71 <syscall>
  802055:	83 c4 18             	add    $0x18,%esp
}
  802058:	c9                   	leave  
  802059:	c3                   	ret    

0080205a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80205a:	55                   	push   %ebp
  80205b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80205d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802060:	8b 45 08             	mov    0x8(%ebp),%eax
  802063:	6a 00                	push   $0x0
  802065:	6a 00                	push   $0x0
  802067:	6a 00                	push   $0x0
  802069:	52                   	push   %edx
  80206a:	50                   	push   %eax
  80206b:	6a 19                	push   $0x19
  80206d:	e8 ff fc ff ff       	call   801d71 <syscall>
  802072:	83 c4 18             	add    $0x18,%esp
}
  802075:	90                   	nop
  802076:	c9                   	leave  
  802077:	c3                   	ret    

00802078 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802078:	55                   	push   %ebp
  802079:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80207b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80207e:	8b 45 08             	mov    0x8(%ebp),%eax
  802081:	6a 00                	push   $0x0
  802083:	6a 00                	push   $0x0
  802085:	6a 00                	push   $0x0
  802087:	52                   	push   %edx
  802088:	50                   	push   %eax
  802089:	6a 1a                	push   $0x1a
  80208b:	e8 e1 fc ff ff       	call   801d71 <syscall>
  802090:	83 c4 18             	add    $0x18,%esp
}
  802093:	90                   	nop
  802094:	c9                   	leave  
  802095:	c3                   	ret    

00802096 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802096:	55                   	push   %ebp
  802097:	89 e5                	mov    %esp,%ebp
  802099:	83 ec 04             	sub    $0x4,%esp
  80209c:	8b 45 10             	mov    0x10(%ebp),%eax
  80209f:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8020a2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8020a5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8020a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ac:	6a 00                	push   $0x0
  8020ae:	51                   	push   %ecx
  8020af:	52                   	push   %edx
  8020b0:	ff 75 0c             	pushl  0xc(%ebp)
  8020b3:	50                   	push   %eax
  8020b4:	6a 1c                	push   $0x1c
  8020b6:	e8 b6 fc ff ff       	call   801d71 <syscall>
  8020bb:	83 c4 18             	add    $0x18,%esp
}
  8020be:	c9                   	leave  
  8020bf:	c3                   	ret    

008020c0 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8020c0:	55                   	push   %ebp
  8020c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8020c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c9:	6a 00                	push   $0x0
  8020cb:	6a 00                	push   $0x0
  8020cd:	6a 00                	push   $0x0
  8020cf:	52                   	push   %edx
  8020d0:	50                   	push   %eax
  8020d1:	6a 1d                	push   $0x1d
  8020d3:	e8 99 fc ff ff       	call   801d71 <syscall>
  8020d8:	83 c4 18             	add    $0x18,%esp
}
  8020db:	c9                   	leave  
  8020dc:	c3                   	ret    

008020dd <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8020dd:	55                   	push   %ebp
  8020de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8020e0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 00                	push   $0x0
  8020ed:	51                   	push   %ecx
  8020ee:	52                   	push   %edx
  8020ef:	50                   	push   %eax
  8020f0:	6a 1e                	push   $0x1e
  8020f2:	e8 7a fc ff ff       	call   801d71 <syscall>
  8020f7:	83 c4 18             	add    $0x18,%esp
}
  8020fa:	c9                   	leave  
  8020fb:	c3                   	ret    

008020fc <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8020fc:	55                   	push   %ebp
  8020fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8020ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  802102:	8b 45 08             	mov    0x8(%ebp),%eax
  802105:	6a 00                	push   $0x0
  802107:	6a 00                	push   $0x0
  802109:	6a 00                	push   $0x0
  80210b:	52                   	push   %edx
  80210c:	50                   	push   %eax
  80210d:	6a 1f                	push   $0x1f
  80210f:	e8 5d fc ff ff       	call   801d71 <syscall>
  802114:	83 c4 18             	add    $0x18,%esp
}
  802117:	c9                   	leave  
  802118:	c3                   	ret    

00802119 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802119:	55                   	push   %ebp
  80211a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80211c:	6a 00                	push   $0x0
  80211e:	6a 00                	push   $0x0
  802120:	6a 00                	push   $0x0
  802122:	6a 00                	push   $0x0
  802124:	6a 00                	push   $0x0
  802126:	6a 20                	push   $0x20
  802128:	e8 44 fc ff ff       	call   801d71 <syscall>
  80212d:	83 c4 18             	add    $0x18,%esp
}
  802130:	c9                   	leave  
  802131:	c3                   	ret    

00802132 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802132:	55                   	push   %ebp
  802133:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802135:	8b 45 08             	mov    0x8(%ebp),%eax
  802138:	6a 00                	push   $0x0
  80213a:	ff 75 14             	pushl  0x14(%ebp)
  80213d:	ff 75 10             	pushl  0x10(%ebp)
  802140:	ff 75 0c             	pushl  0xc(%ebp)
  802143:	50                   	push   %eax
  802144:	6a 21                	push   $0x21
  802146:	e8 26 fc ff ff       	call   801d71 <syscall>
  80214b:	83 c4 18             	add    $0x18,%esp
}
  80214e:	c9                   	leave  
  80214f:	c3                   	ret    

00802150 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  802150:	55                   	push   %ebp
  802151:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802153:	8b 45 08             	mov    0x8(%ebp),%eax
  802156:	6a 00                	push   $0x0
  802158:	6a 00                	push   $0x0
  80215a:	6a 00                	push   $0x0
  80215c:	6a 00                	push   $0x0
  80215e:	50                   	push   %eax
  80215f:	6a 22                	push   $0x22
  802161:	e8 0b fc ff ff       	call   801d71 <syscall>
  802166:	83 c4 18             	add    $0x18,%esp
}
  802169:	90                   	nop
  80216a:	c9                   	leave  
  80216b:	c3                   	ret    

0080216c <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80216c:	55                   	push   %ebp
  80216d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80216f:	8b 45 08             	mov    0x8(%ebp),%eax
  802172:	6a 00                	push   $0x0
  802174:	6a 00                	push   $0x0
  802176:	6a 00                	push   $0x0
  802178:	6a 00                	push   $0x0
  80217a:	50                   	push   %eax
  80217b:	6a 23                	push   $0x23
  80217d:	e8 ef fb ff ff       	call   801d71 <syscall>
  802182:	83 c4 18             	add    $0x18,%esp
}
  802185:	90                   	nop
  802186:	c9                   	leave  
  802187:	c3                   	ret    

00802188 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802188:	55                   	push   %ebp
  802189:	89 e5                	mov    %esp,%ebp
  80218b:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80218e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802191:	8d 50 04             	lea    0x4(%eax),%edx
  802194:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802197:	6a 00                	push   $0x0
  802199:	6a 00                	push   $0x0
  80219b:	6a 00                	push   $0x0
  80219d:	52                   	push   %edx
  80219e:	50                   	push   %eax
  80219f:	6a 24                	push   $0x24
  8021a1:	e8 cb fb ff ff       	call   801d71 <syscall>
  8021a6:	83 c4 18             	add    $0x18,%esp
	return result;
  8021a9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8021ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021af:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8021b2:	89 01                	mov    %eax,(%ecx)
  8021b4:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8021b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ba:	c9                   	leave  
  8021bb:	c2 04 00             	ret    $0x4

008021be <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8021be:	55                   	push   %ebp
  8021bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8021c1:	6a 00                	push   $0x0
  8021c3:	6a 00                	push   $0x0
  8021c5:	ff 75 10             	pushl  0x10(%ebp)
  8021c8:	ff 75 0c             	pushl  0xc(%ebp)
  8021cb:	ff 75 08             	pushl  0x8(%ebp)
  8021ce:	6a 13                	push   $0x13
  8021d0:	e8 9c fb ff ff       	call   801d71 <syscall>
  8021d5:	83 c4 18             	add    $0x18,%esp
	return ;
  8021d8:	90                   	nop
}
  8021d9:	c9                   	leave  
  8021da:	c3                   	ret    

008021db <sys_rcr2>:
uint32 sys_rcr2()
{
  8021db:	55                   	push   %ebp
  8021dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8021de:	6a 00                	push   $0x0
  8021e0:	6a 00                	push   $0x0
  8021e2:	6a 00                	push   $0x0
  8021e4:	6a 00                	push   $0x0
  8021e6:	6a 00                	push   $0x0
  8021e8:	6a 25                	push   $0x25
  8021ea:	e8 82 fb ff ff       	call   801d71 <syscall>
  8021ef:	83 c4 18             	add    $0x18,%esp
}
  8021f2:	c9                   	leave  
  8021f3:	c3                   	ret    

008021f4 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8021f4:	55                   	push   %ebp
  8021f5:	89 e5                	mov    %esp,%ebp
  8021f7:	83 ec 04             	sub    $0x4,%esp
  8021fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8021fd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802200:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802204:	6a 00                	push   $0x0
  802206:	6a 00                	push   $0x0
  802208:	6a 00                	push   $0x0
  80220a:	6a 00                	push   $0x0
  80220c:	50                   	push   %eax
  80220d:	6a 26                	push   $0x26
  80220f:	e8 5d fb ff ff       	call   801d71 <syscall>
  802214:	83 c4 18             	add    $0x18,%esp
	return ;
  802217:	90                   	nop
}
  802218:	c9                   	leave  
  802219:	c3                   	ret    

0080221a <rsttst>:
void rsttst()
{
  80221a:	55                   	push   %ebp
  80221b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80221d:	6a 00                	push   $0x0
  80221f:	6a 00                	push   $0x0
  802221:	6a 00                	push   $0x0
  802223:	6a 00                	push   $0x0
  802225:	6a 00                	push   $0x0
  802227:	6a 28                	push   $0x28
  802229:	e8 43 fb ff ff       	call   801d71 <syscall>
  80222e:	83 c4 18             	add    $0x18,%esp
	return ;
  802231:	90                   	nop
}
  802232:	c9                   	leave  
  802233:	c3                   	ret    

00802234 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802234:	55                   	push   %ebp
  802235:	89 e5                	mov    %esp,%ebp
  802237:	83 ec 04             	sub    $0x4,%esp
  80223a:	8b 45 14             	mov    0x14(%ebp),%eax
  80223d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802240:	8b 55 18             	mov    0x18(%ebp),%edx
  802243:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802247:	52                   	push   %edx
  802248:	50                   	push   %eax
  802249:	ff 75 10             	pushl  0x10(%ebp)
  80224c:	ff 75 0c             	pushl  0xc(%ebp)
  80224f:	ff 75 08             	pushl  0x8(%ebp)
  802252:	6a 27                	push   $0x27
  802254:	e8 18 fb ff ff       	call   801d71 <syscall>
  802259:	83 c4 18             	add    $0x18,%esp
	return ;
  80225c:	90                   	nop
}
  80225d:	c9                   	leave  
  80225e:	c3                   	ret    

0080225f <chktst>:
void chktst(uint32 n)
{
  80225f:	55                   	push   %ebp
  802260:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802262:	6a 00                	push   $0x0
  802264:	6a 00                	push   $0x0
  802266:	6a 00                	push   $0x0
  802268:	6a 00                	push   $0x0
  80226a:	ff 75 08             	pushl  0x8(%ebp)
  80226d:	6a 29                	push   $0x29
  80226f:	e8 fd fa ff ff       	call   801d71 <syscall>
  802274:	83 c4 18             	add    $0x18,%esp
	return ;
  802277:	90                   	nop
}
  802278:	c9                   	leave  
  802279:	c3                   	ret    

0080227a <inctst>:

void inctst()
{
  80227a:	55                   	push   %ebp
  80227b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80227d:	6a 00                	push   $0x0
  80227f:	6a 00                	push   $0x0
  802281:	6a 00                	push   $0x0
  802283:	6a 00                	push   $0x0
  802285:	6a 00                	push   $0x0
  802287:	6a 2a                	push   $0x2a
  802289:	e8 e3 fa ff ff       	call   801d71 <syscall>
  80228e:	83 c4 18             	add    $0x18,%esp
	return ;
  802291:	90                   	nop
}
  802292:	c9                   	leave  
  802293:	c3                   	ret    

00802294 <gettst>:
uint32 gettst()
{
  802294:	55                   	push   %ebp
  802295:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802297:	6a 00                	push   $0x0
  802299:	6a 00                	push   $0x0
  80229b:	6a 00                	push   $0x0
  80229d:	6a 00                	push   $0x0
  80229f:	6a 00                	push   $0x0
  8022a1:	6a 2b                	push   $0x2b
  8022a3:	e8 c9 fa ff ff       	call   801d71 <syscall>
  8022a8:	83 c4 18             	add    $0x18,%esp
}
  8022ab:	c9                   	leave  
  8022ac:	c3                   	ret    

008022ad <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8022ad:	55                   	push   %ebp
  8022ae:	89 e5                	mov    %esp,%ebp
  8022b0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022b3:	6a 00                	push   $0x0
  8022b5:	6a 00                	push   $0x0
  8022b7:	6a 00                	push   $0x0
  8022b9:	6a 00                	push   $0x0
  8022bb:	6a 00                	push   $0x0
  8022bd:	6a 2c                	push   $0x2c
  8022bf:	e8 ad fa ff ff       	call   801d71 <syscall>
  8022c4:	83 c4 18             	add    $0x18,%esp
  8022c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8022ca:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8022ce:	75 07                	jne    8022d7 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8022d0:	b8 01 00 00 00       	mov    $0x1,%eax
  8022d5:	eb 05                	jmp    8022dc <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8022d7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022dc:	c9                   	leave  
  8022dd:	c3                   	ret    

008022de <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8022de:	55                   	push   %ebp
  8022df:	89 e5                	mov    %esp,%ebp
  8022e1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022e4:	6a 00                	push   $0x0
  8022e6:	6a 00                	push   $0x0
  8022e8:	6a 00                	push   $0x0
  8022ea:	6a 00                	push   $0x0
  8022ec:	6a 00                	push   $0x0
  8022ee:	6a 2c                	push   $0x2c
  8022f0:	e8 7c fa ff ff       	call   801d71 <syscall>
  8022f5:	83 c4 18             	add    $0x18,%esp
  8022f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8022fb:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8022ff:	75 07                	jne    802308 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802301:	b8 01 00 00 00       	mov    $0x1,%eax
  802306:	eb 05                	jmp    80230d <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802308:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80230d:	c9                   	leave  
  80230e:	c3                   	ret    

0080230f <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80230f:	55                   	push   %ebp
  802310:	89 e5                	mov    %esp,%ebp
  802312:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802315:	6a 00                	push   $0x0
  802317:	6a 00                	push   $0x0
  802319:	6a 00                	push   $0x0
  80231b:	6a 00                	push   $0x0
  80231d:	6a 00                	push   $0x0
  80231f:	6a 2c                	push   $0x2c
  802321:	e8 4b fa ff ff       	call   801d71 <syscall>
  802326:	83 c4 18             	add    $0x18,%esp
  802329:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80232c:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802330:	75 07                	jne    802339 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802332:	b8 01 00 00 00       	mov    $0x1,%eax
  802337:	eb 05                	jmp    80233e <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802339:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80233e:	c9                   	leave  
  80233f:	c3                   	ret    

00802340 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802340:	55                   	push   %ebp
  802341:	89 e5                	mov    %esp,%ebp
  802343:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802346:	6a 00                	push   $0x0
  802348:	6a 00                	push   $0x0
  80234a:	6a 00                	push   $0x0
  80234c:	6a 00                	push   $0x0
  80234e:	6a 00                	push   $0x0
  802350:	6a 2c                	push   $0x2c
  802352:	e8 1a fa ff ff       	call   801d71 <syscall>
  802357:	83 c4 18             	add    $0x18,%esp
  80235a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80235d:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802361:	75 07                	jne    80236a <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802363:	b8 01 00 00 00       	mov    $0x1,%eax
  802368:	eb 05                	jmp    80236f <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80236a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80236f:	c9                   	leave  
  802370:	c3                   	ret    

00802371 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802371:	55                   	push   %ebp
  802372:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802374:	6a 00                	push   $0x0
  802376:	6a 00                	push   $0x0
  802378:	6a 00                	push   $0x0
  80237a:	6a 00                	push   $0x0
  80237c:	ff 75 08             	pushl  0x8(%ebp)
  80237f:	6a 2d                	push   $0x2d
  802381:	e8 eb f9 ff ff       	call   801d71 <syscall>
  802386:	83 c4 18             	add    $0x18,%esp
	return ;
  802389:	90                   	nop
}
  80238a:	c9                   	leave  
  80238b:	c3                   	ret    

0080238c <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80238c:	55                   	push   %ebp
  80238d:	89 e5                	mov    %esp,%ebp
  80238f:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802390:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802393:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802396:	8b 55 0c             	mov    0xc(%ebp),%edx
  802399:	8b 45 08             	mov    0x8(%ebp),%eax
  80239c:	6a 00                	push   $0x0
  80239e:	53                   	push   %ebx
  80239f:	51                   	push   %ecx
  8023a0:	52                   	push   %edx
  8023a1:	50                   	push   %eax
  8023a2:	6a 2e                	push   $0x2e
  8023a4:	e8 c8 f9 ff ff       	call   801d71 <syscall>
  8023a9:	83 c4 18             	add    $0x18,%esp
}
  8023ac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8023af:	c9                   	leave  
  8023b0:	c3                   	ret    

008023b1 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8023b1:	55                   	push   %ebp
  8023b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8023b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ba:	6a 00                	push   $0x0
  8023bc:	6a 00                	push   $0x0
  8023be:	6a 00                	push   $0x0
  8023c0:	52                   	push   %edx
  8023c1:	50                   	push   %eax
  8023c2:	6a 2f                	push   $0x2f
  8023c4:	e8 a8 f9 ff ff       	call   801d71 <syscall>
  8023c9:	83 c4 18             	add    $0x18,%esp
}
  8023cc:	c9                   	leave  
  8023cd:	c3                   	ret    

008023ce <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8023ce:	55                   	push   %ebp
  8023cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8023d1:	6a 00                	push   $0x0
  8023d3:	6a 00                	push   $0x0
  8023d5:	6a 00                	push   $0x0
  8023d7:	ff 75 0c             	pushl  0xc(%ebp)
  8023da:	ff 75 08             	pushl  0x8(%ebp)
  8023dd:	6a 30                	push   $0x30
  8023df:	e8 8d f9 ff ff       	call   801d71 <syscall>
  8023e4:	83 c4 18             	add    $0x18,%esp
	return ;
  8023e7:	90                   	nop
}
  8023e8:	c9                   	leave  
  8023e9:	c3                   	ret    
  8023ea:	66 90                	xchg   %ax,%ax

008023ec <__udivdi3>:
  8023ec:	55                   	push   %ebp
  8023ed:	57                   	push   %edi
  8023ee:	56                   	push   %esi
  8023ef:	53                   	push   %ebx
  8023f0:	83 ec 1c             	sub    $0x1c,%esp
  8023f3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8023f7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8023fb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023ff:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802403:	89 ca                	mov    %ecx,%edx
  802405:	89 f8                	mov    %edi,%eax
  802407:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80240b:	85 f6                	test   %esi,%esi
  80240d:	75 2d                	jne    80243c <__udivdi3+0x50>
  80240f:	39 cf                	cmp    %ecx,%edi
  802411:	77 65                	ja     802478 <__udivdi3+0x8c>
  802413:	89 fd                	mov    %edi,%ebp
  802415:	85 ff                	test   %edi,%edi
  802417:	75 0b                	jne    802424 <__udivdi3+0x38>
  802419:	b8 01 00 00 00       	mov    $0x1,%eax
  80241e:	31 d2                	xor    %edx,%edx
  802420:	f7 f7                	div    %edi
  802422:	89 c5                	mov    %eax,%ebp
  802424:	31 d2                	xor    %edx,%edx
  802426:	89 c8                	mov    %ecx,%eax
  802428:	f7 f5                	div    %ebp
  80242a:	89 c1                	mov    %eax,%ecx
  80242c:	89 d8                	mov    %ebx,%eax
  80242e:	f7 f5                	div    %ebp
  802430:	89 cf                	mov    %ecx,%edi
  802432:	89 fa                	mov    %edi,%edx
  802434:	83 c4 1c             	add    $0x1c,%esp
  802437:	5b                   	pop    %ebx
  802438:	5e                   	pop    %esi
  802439:	5f                   	pop    %edi
  80243a:	5d                   	pop    %ebp
  80243b:	c3                   	ret    
  80243c:	39 ce                	cmp    %ecx,%esi
  80243e:	77 28                	ja     802468 <__udivdi3+0x7c>
  802440:	0f bd fe             	bsr    %esi,%edi
  802443:	83 f7 1f             	xor    $0x1f,%edi
  802446:	75 40                	jne    802488 <__udivdi3+0x9c>
  802448:	39 ce                	cmp    %ecx,%esi
  80244a:	72 0a                	jb     802456 <__udivdi3+0x6a>
  80244c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802450:	0f 87 9e 00 00 00    	ja     8024f4 <__udivdi3+0x108>
  802456:	b8 01 00 00 00       	mov    $0x1,%eax
  80245b:	89 fa                	mov    %edi,%edx
  80245d:	83 c4 1c             	add    $0x1c,%esp
  802460:	5b                   	pop    %ebx
  802461:	5e                   	pop    %esi
  802462:	5f                   	pop    %edi
  802463:	5d                   	pop    %ebp
  802464:	c3                   	ret    
  802465:	8d 76 00             	lea    0x0(%esi),%esi
  802468:	31 ff                	xor    %edi,%edi
  80246a:	31 c0                	xor    %eax,%eax
  80246c:	89 fa                	mov    %edi,%edx
  80246e:	83 c4 1c             	add    $0x1c,%esp
  802471:	5b                   	pop    %ebx
  802472:	5e                   	pop    %esi
  802473:	5f                   	pop    %edi
  802474:	5d                   	pop    %ebp
  802475:	c3                   	ret    
  802476:	66 90                	xchg   %ax,%ax
  802478:	89 d8                	mov    %ebx,%eax
  80247a:	f7 f7                	div    %edi
  80247c:	31 ff                	xor    %edi,%edi
  80247e:	89 fa                	mov    %edi,%edx
  802480:	83 c4 1c             	add    $0x1c,%esp
  802483:	5b                   	pop    %ebx
  802484:	5e                   	pop    %esi
  802485:	5f                   	pop    %edi
  802486:	5d                   	pop    %ebp
  802487:	c3                   	ret    
  802488:	bd 20 00 00 00       	mov    $0x20,%ebp
  80248d:	89 eb                	mov    %ebp,%ebx
  80248f:	29 fb                	sub    %edi,%ebx
  802491:	89 f9                	mov    %edi,%ecx
  802493:	d3 e6                	shl    %cl,%esi
  802495:	89 c5                	mov    %eax,%ebp
  802497:	88 d9                	mov    %bl,%cl
  802499:	d3 ed                	shr    %cl,%ebp
  80249b:	89 e9                	mov    %ebp,%ecx
  80249d:	09 f1                	or     %esi,%ecx
  80249f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8024a3:	89 f9                	mov    %edi,%ecx
  8024a5:	d3 e0                	shl    %cl,%eax
  8024a7:	89 c5                	mov    %eax,%ebp
  8024a9:	89 d6                	mov    %edx,%esi
  8024ab:	88 d9                	mov    %bl,%cl
  8024ad:	d3 ee                	shr    %cl,%esi
  8024af:	89 f9                	mov    %edi,%ecx
  8024b1:	d3 e2                	shl    %cl,%edx
  8024b3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024b7:	88 d9                	mov    %bl,%cl
  8024b9:	d3 e8                	shr    %cl,%eax
  8024bb:	09 c2                	or     %eax,%edx
  8024bd:	89 d0                	mov    %edx,%eax
  8024bf:	89 f2                	mov    %esi,%edx
  8024c1:	f7 74 24 0c          	divl   0xc(%esp)
  8024c5:	89 d6                	mov    %edx,%esi
  8024c7:	89 c3                	mov    %eax,%ebx
  8024c9:	f7 e5                	mul    %ebp
  8024cb:	39 d6                	cmp    %edx,%esi
  8024cd:	72 19                	jb     8024e8 <__udivdi3+0xfc>
  8024cf:	74 0b                	je     8024dc <__udivdi3+0xf0>
  8024d1:	89 d8                	mov    %ebx,%eax
  8024d3:	31 ff                	xor    %edi,%edi
  8024d5:	e9 58 ff ff ff       	jmp    802432 <__udivdi3+0x46>
  8024da:	66 90                	xchg   %ax,%ax
  8024dc:	8b 54 24 08          	mov    0x8(%esp),%edx
  8024e0:	89 f9                	mov    %edi,%ecx
  8024e2:	d3 e2                	shl    %cl,%edx
  8024e4:	39 c2                	cmp    %eax,%edx
  8024e6:	73 e9                	jae    8024d1 <__udivdi3+0xe5>
  8024e8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8024eb:	31 ff                	xor    %edi,%edi
  8024ed:	e9 40 ff ff ff       	jmp    802432 <__udivdi3+0x46>
  8024f2:	66 90                	xchg   %ax,%ax
  8024f4:	31 c0                	xor    %eax,%eax
  8024f6:	e9 37 ff ff ff       	jmp    802432 <__udivdi3+0x46>
  8024fb:	90                   	nop

008024fc <__umoddi3>:
  8024fc:	55                   	push   %ebp
  8024fd:	57                   	push   %edi
  8024fe:	56                   	push   %esi
  8024ff:	53                   	push   %ebx
  802500:	83 ec 1c             	sub    $0x1c,%esp
  802503:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802507:	8b 74 24 34          	mov    0x34(%esp),%esi
  80250b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80250f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802513:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802517:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80251b:	89 f3                	mov    %esi,%ebx
  80251d:	89 fa                	mov    %edi,%edx
  80251f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802523:	89 34 24             	mov    %esi,(%esp)
  802526:	85 c0                	test   %eax,%eax
  802528:	75 1a                	jne    802544 <__umoddi3+0x48>
  80252a:	39 f7                	cmp    %esi,%edi
  80252c:	0f 86 a2 00 00 00    	jbe    8025d4 <__umoddi3+0xd8>
  802532:	89 c8                	mov    %ecx,%eax
  802534:	89 f2                	mov    %esi,%edx
  802536:	f7 f7                	div    %edi
  802538:	89 d0                	mov    %edx,%eax
  80253a:	31 d2                	xor    %edx,%edx
  80253c:	83 c4 1c             	add    $0x1c,%esp
  80253f:	5b                   	pop    %ebx
  802540:	5e                   	pop    %esi
  802541:	5f                   	pop    %edi
  802542:	5d                   	pop    %ebp
  802543:	c3                   	ret    
  802544:	39 f0                	cmp    %esi,%eax
  802546:	0f 87 ac 00 00 00    	ja     8025f8 <__umoddi3+0xfc>
  80254c:	0f bd e8             	bsr    %eax,%ebp
  80254f:	83 f5 1f             	xor    $0x1f,%ebp
  802552:	0f 84 ac 00 00 00    	je     802604 <__umoddi3+0x108>
  802558:	bf 20 00 00 00       	mov    $0x20,%edi
  80255d:	29 ef                	sub    %ebp,%edi
  80255f:	89 fe                	mov    %edi,%esi
  802561:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802565:	89 e9                	mov    %ebp,%ecx
  802567:	d3 e0                	shl    %cl,%eax
  802569:	89 d7                	mov    %edx,%edi
  80256b:	89 f1                	mov    %esi,%ecx
  80256d:	d3 ef                	shr    %cl,%edi
  80256f:	09 c7                	or     %eax,%edi
  802571:	89 e9                	mov    %ebp,%ecx
  802573:	d3 e2                	shl    %cl,%edx
  802575:	89 14 24             	mov    %edx,(%esp)
  802578:	89 d8                	mov    %ebx,%eax
  80257a:	d3 e0                	shl    %cl,%eax
  80257c:	89 c2                	mov    %eax,%edx
  80257e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802582:	d3 e0                	shl    %cl,%eax
  802584:	89 44 24 04          	mov    %eax,0x4(%esp)
  802588:	8b 44 24 08          	mov    0x8(%esp),%eax
  80258c:	89 f1                	mov    %esi,%ecx
  80258e:	d3 e8                	shr    %cl,%eax
  802590:	09 d0                	or     %edx,%eax
  802592:	d3 eb                	shr    %cl,%ebx
  802594:	89 da                	mov    %ebx,%edx
  802596:	f7 f7                	div    %edi
  802598:	89 d3                	mov    %edx,%ebx
  80259a:	f7 24 24             	mull   (%esp)
  80259d:	89 c6                	mov    %eax,%esi
  80259f:	89 d1                	mov    %edx,%ecx
  8025a1:	39 d3                	cmp    %edx,%ebx
  8025a3:	0f 82 87 00 00 00    	jb     802630 <__umoddi3+0x134>
  8025a9:	0f 84 91 00 00 00    	je     802640 <__umoddi3+0x144>
  8025af:	8b 54 24 04          	mov    0x4(%esp),%edx
  8025b3:	29 f2                	sub    %esi,%edx
  8025b5:	19 cb                	sbb    %ecx,%ebx
  8025b7:	89 d8                	mov    %ebx,%eax
  8025b9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8025bd:	d3 e0                	shl    %cl,%eax
  8025bf:	89 e9                	mov    %ebp,%ecx
  8025c1:	d3 ea                	shr    %cl,%edx
  8025c3:	09 d0                	or     %edx,%eax
  8025c5:	89 e9                	mov    %ebp,%ecx
  8025c7:	d3 eb                	shr    %cl,%ebx
  8025c9:	89 da                	mov    %ebx,%edx
  8025cb:	83 c4 1c             	add    $0x1c,%esp
  8025ce:	5b                   	pop    %ebx
  8025cf:	5e                   	pop    %esi
  8025d0:	5f                   	pop    %edi
  8025d1:	5d                   	pop    %ebp
  8025d2:	c3                   	ret    
  8025d3:	90                   	nop
  8025d4:	89 fd                	mov    %edi,%ebp
  8025d6:	85 ff                	test   %edi,%edi
  8025d8:	75 0b                	jne    8025e5 <__umoddi3+0xe9>
  8025da:	b8 01 00 00 00       	mov    $0x1,%eax
  8025df:	31 d2                	xor    %edx,%edx
  8025e1:	f7 f7                	div    %edi
  8025e3:	89 c5                	mov    %eax,%ebp
  8025e5:	89 f0                	mov    %esi,%eax
  8025e7:	31 d2                	xor    %edx,%edx
  8025e9:	f7 f5                	div    %ebp
  8025eb:	89 c8                	mov    %ecx,%eax
  8025ed:	f7 f5                	div    %ebp
  8025ef:	89 d0                	mov    %edx,%eax
  8025f1:	e9 44 ff ff ff       	jmp    80253a <__umoddi3+0x3e>
  8025f6:	66 90                	xchg   %ax,%ax
  8025f8:	89 c8                	mov    %ecx,%eax
  8025fa:	89 f2                	mov    %esi,%edx
  8025fc:	83 c4 1c             	add    $0x1c,%esp
  8025ff:	5b                   	pop    %ebx
  802600:	5e                   	pop    %esi
  802601:	5f                   	pop    %edi
  802602:	5d                   	pop    %ebp
  802603:	c3                   	ret    
  802604:	3b 04 24             	cmp    (%esp),%eax
  802607:	72 06                	jb     80260f <__umoddi3+0x113>
  802609:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80260d:	77 0f                	ja     80261e <__umoddi3+0x122>
  80260f:	89 f2                	mov    %esi,%edx
  802611:	29 f9                	sub    %edi,%ecx
  802613:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802617:	89 14 24             	mov    %edx,(%esp)
  80261a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80261e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802622:	8b 14 24             	mov    (%esp),%edx
  802625:	83 c4 1c             	add    $0x1c,%esp
  802628:	5b                   	pop    %ebx
  802629:	5e                   	pop    %esi
  80262a:	5f                   	pop    %edi
  80262b:	5d                   	pop    %ebp
  80262c:	c3                   	ret    
  80262d:	8d 76 00             	lea    0x0(%esi),%esi
  802630:	2b 04 24             	sub    (%esp),%eax
  802633:	19 fa                	sbb    %edi,%edx
  802635:	89 d1                	mov    %edx,%ecx
  802637:	89 c6                	mov    %eax,%esi
  802639:	e9 71 ff ff ff       	jmp    8025af <__umoddi3+0xb3>
  80263e:	66 90                	xchg   %ax,%ax
  802640:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802644:	72 ea                	jb     802630 <__umoddi3+0x134>
  802646:	89 d9                	mov    %ebx,%ecx
  802648:	e9 62 ff ff ff       	jmp    8025af <__umoddi3+0xb3>
