
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
  800049:	e8 72 1b 00 00       	call   801bc0 <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 84 1b 00 00       	call   801bd9 <sys_calculate_modified_frames>
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
  800067:	68 40 23 80 00       	push   $0x802340
  80006c:	e8 e5 0f 00 00       	call   801056 <readline>
  800071:	83 c4 10             	add    $0x10,%esp
			int NumOfElements = strtol(Line, NULL, 10) ;
  800074:	83 ec 04             	sub    $0x4,%esp
  800077:	6a 0a                	push   $0xa
  800079:	6a 00                	push   $0x0
  80007b:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800081:	50                   	push   %eax
  800082:	e8 35 15 00 00       	call   8015bc <strtol>
  800087:	83 c4 10             	add    $0x10,%esp
  80008a:	89 45 ec             	mov    %eax,-0x14(%ebp)
			int *Elements = malloc(sizeof(int) * NumOfElements) ;
  80008d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800090:	c1 e0 02             	shl    $0x2,%eax
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	50                   	push   %eax
  800097:	e8 c8 18 00 00       	call   801964 <malloc>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 45 e8             	mov    %eax,-0x18(%ebp)
			cprintf("Choose the initialization method:\n") ;
  8000a2:	83 ec 0c             	sub    $0xc,%esp
  8000a5:	68 60 23 80 00       	push   $0x802360
  8000aa:	e8 25 09 00 00       	call   8009d4 <cprintf>
  8000af:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	68 83 23 80 00       	push   $0x802383
  8000ba:	e8 15 09 00 00       	call   8009d4 <cprintf>
  8000bf:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000c2:	83 ec 0c             	sub    $0xc,%esp
  8000c5:	68 91 23 80 00       	push   $0x802391
  8000ca:	e8 05 09 00 00       	call   8009d4 <cprintf>
  8000cf:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\n");
  8000d2:	83 ec 0c             	sub    $0xc,%esp
  8000d5:	68 a0 23 80 00       	push   $0x8023a0
  8000da:	e8 f5 08 00 00       	call   8009d4 <cprintf>
  8000df:	83 c4 10             	add    $0x10,%esp
			do
			{
				cprintf("Select: ") ;
  8000e2:	83 ec 0c             	sub    $0xc,%esp
  8000e5:	68 b0 23 80 00       	push   $0x8023b0
  8000ea:	e8 e5 08 00 00       	call   8009d4 <cprintf>
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
  8001b4:	68 bc 23 80 00       	push   $0x8023bc
  8001b9:	6a 46                	push   $0x46
  8001bb:	68 de 23 80 00       	push   $0x8023de
  8001c0:	e8 58 05 00 00       	call   80071d <_panic>
		else
		{ 
				cprintf("\n===============================================\n") ;
  8001c5:	83 ec 0c             	sub    $0xc,%esp
  8001c8:	68 f0 23 80 00       	push   $0x8023f0
  8001cd:	e8 02 08 00 00       	call   8009d4 <cprintf>
  8001d2:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001d5:	83 ec 0c             	sub    $0xc,%esp
  8001d8:	68 24 24 80 00       	push   $0x802424
  8001dd:	e8 f2 07 00 00       	call   8009d4 <cprintf>
  8001e2:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  8001e5:	83 ec 0c             	sub    $0xc,%esp
  8001e8:	68 58 24 80 00       	push   $0x802458
  8001ed:	e8 e2 07 00 00       	call   8009d4 <cprintf>
  8001f2:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

			cprintf("Freeing the Heap...\n\n") ;
  8001f5:	83 ec 0c             	sub    $0xc,%esp
  8001f8:	68 8a 24 80 00       	push   $0x80248a
  8001fd:	e8 d2 07 00 00       	call   8009d4 <cprintf>
  800202:	83 c4 10             	add    $0x10,%esp

			free(Elements) ;
  800205:	83 ec 0c             	sub    $0xc,%esp
  800208:	ff 75 e8             	pushl  -0x18(%ebp)
  80020b:	e8 6e 17 00 00       	call   80197e <free>
  800210:	83 c4 10             	add    $0x10,%esp


		///========================================================================
	//sys_disable_interrupt();
			cprintf("Do you want to repeat (y/n): ") ;
  800213:	83 ec 0c             	sub    $0xc,%esp
  800216:	68 a0 24 80 00       	push   $0x8024a0
  80021b:	e8 b4 07 00 00       	call   8009d4 <cprintf>
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
  8004f8:	68 be 24 80 00       	push   $0x8024be
  8004fd:	e8 d2 04 00 00       	call   8009d4 <cprintf>
  800502:	83 c4 10             	add    $0x10,%esp
			cprintf("%d, ",Elements[i]);
  800505:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800508:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80050f:	8b 45 08             	mov    0x8(%ebp),%eax
  800512:	01 d0                	add    %edx,%eax
  800514:	8b 00                	mov    (%eax),%eax
  800516:	83 ec 08             	sub    $0x8,%esp
  800519:	50                   	push   %eax
  80051a:	68 c0 24 80 00       	push   $0x8024c0
  80051f:	e8 b0 04 00 00       	call   8009d4 <cprintf>
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
  800548:	68 c5 24 80 00       	push   $0x8024c5
  80054d:	e8 82 04 00 00       	call   8009d4 <cprintf>
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
  80056c:	e8 53 17 00 00       	call   801cc4 <sys_cputc>
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
  80057d:	e8 0e 17 00 00       	call   801c90 <sys_disable_interrupt>
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
  800590:	e8 2f 17 00 00       	call   801cc4 <sys_cputc>
  800595:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800598:	e8 0d 17 00 00       	call   801caa <sys_enable_interrupt>
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
  8005af:	e8 f4 14 00 00       	call   801aa8 <sys_cgetc>
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
  8005c8:	e8 c3 16 00 00       	call   801c90 <sys_disable_interrupt>
	int c=0;
  8005cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005d4:	eb 08                	jmp    8005de <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005d6:	e8 cd 14 00 00       	call   801aa8 <sys_cgetc>
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
  8005e4:	e8 c1 16 00 00       	call   801caa <sys_enable_interrupt>
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
  8005fe:	e8 f2 14 00 00       	call   801af5 <sys_getenvindex>
  800603:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800606:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800609:	89 d0                	mov    %edx,%eax
  80060b:	c1 e0 03             	shl    $0x3,%eax
  80060e:	01 d0                	add    %edx,%eax
  800610:	c1 e0 02             	shl    $0x2,%eax
  800613:	01 d0                	add    %edx,%eax
  800615:	c1 e0 06             	shl    $0x6,%eax
  800618:	29 d0                	sub    %edx,%eax
  80061a:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800621:	01 c8                	add    %ecx,%eax
  800623:	01 d0                	add    %edx,%eax
  800625:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80062a:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80062f:	a1 24 30 80 00       	mov    0x803024,%eax
  800634:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  80063a:	84 c0                	test   %al,%al
  80063c:	74 0f                	je     80064d <libmain+0x55>
		binaryname = myEnv->prog_name;
  80063e:	a1 24 30 80 00       	mov    0x803024,%eax
  800643:	05 b0 52 00 00       	add    $0x52b0,%eax
  800648:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80064d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800651:	7e 0a                	jle    80065d <libmain+0x65>
		binaryname = argv[0];
  800653:	8b 45 0c             	mov    0xc(%ebp),%eax
  800656:	8b 00                	mov    (%eax),%eax
  800658:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80065d:	83 ec 08             	sub    $0x8,%esp
  800660:	ff 75 0c             	pushl  0xc(%ebp)
  800663:	ff 75 08             	pushl  0x8(%ebp)
  800666:	e8 cd f9 ff ff       	call   800038 <_main>
  80066b:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80066e:	e8 1d 16 00 00       	call   801c90 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800673:	83 ec 0c             	sub    $0xc,%esp
  800676:	68 e4 24 80 00       	push   $0x8024e4
  80067b:	e8 54 03 00 00       	call   8009d4 <cprintf>
  800680:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800683:	a1 24 30 80 00       	mov    0x803024,%eax
  800688:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  80068e:	a1 24 30 80 00       	mov    0x803024,%eax
  800693:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  800699:	83 ec 04             	sub    $0x4,%esp
  80069c:	52                   	push   %edx
  80069d:	50                   	push   %eax
  80069e:	68 0c 25 80 00       	push   $0x80250c
  8006a3:	e8 2c 03 00 00       	call   8009d4 <cprintf>
  8006a8:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8006ab:	a1 24 30 80 00       	mov    0x803024,%eax
  8006b0:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  8006b6:	a1 24 30 80 00       	mov    0x803024,%eax
  8006bb:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  8006c1:	a1 24 30 80 00       	mov    0x803024,%eax
  8006c6:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  8006cc:	51                   	push   %ecx
  8006cd:	52                   	push   %edx
  8006ce:	50                   	push   %eax
  8006cf:	68 34 25 80 00       	push   $0x802534
  8006d4:	e8 fb 02 00 00       	call   8009d4 <cprintf>
  8006d9:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8006dc:	83 ec 0c             	sub    $0xc,%esp
  8006df:	68 e4 24 80 00       	push   $0x8024e4
  8006e4:	e8 eb 02 00 00       	call   8009d4 <cprintf>
  8006e9:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006ec:	e8 b9 15 00 00       	call   801caa <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006f1:	e8 19 00 00 00       	call   80070f <exit>
}
  8006f6:	90                   	nop
  8006f7:	c9                   	leave  
  8006f8:	c3                   	ret    

008006f9 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006f9:	55                   	push   %ebp
  8006fa:	89 e5                	mov    %esp,%ebp
  8006fc:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006ff:	83 ec 0c             	sub    $0xc,%esp
  800702:	6a 00                	push   $0x0
  800704:	e8 b8 13 00 00       	call   801ac1 <sys_env_destroy>
  800709:	83 c4 10             	add    $0x10,%esp
}
  80070c:	90                   	nop
  80070d:	c9                   	leave  
  80070e:	c3                   	ret    

0080070f <exit>:

void
exit(void)
{
  80070f:	55                   	push   %ebp
  800710:	89 e5                	mov    %esp,%ebp
  800712:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800715:	e8 0d 14 00 00       	call   801b27 <sys_env_exit>
}
  80071a:	90                   	nop
  80071b:	c9                   	leave  
  80071c:	c3                   	ret    

0080071d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80071d:	55                   	push   %ebp
  80071e:	89 e5                	mov    %esp,%ebp
  800720:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800723:	8d 45 10             	lea    0x10(%ebp),%eax
  800726:	83 c0 04             	add    $0x4,%eax
  800729:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80072c:	a1 18 31 80 00       	mov    0x803118,%eax
  800731:	85 c0                	test   %eax,%eax
  800733:	74 16                	je     80074b <_panic+0x2e>
		cprintf("%s: ", argv0);
  800735:	a1 18 31 80 00       	mov    0x803118,%eax
  80073a:	83 ec 08             	sub    $0x8,%esp
  80073d:	50                   	push   %eax
  80073e:	68 8c 25 80 00       	push   $0x80258c
  800743:	e8 8c 02 00 00       	call   8009d4 <cprintf>
  800748:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80074b:	a1 00 30 80 00       	mov    0x803000,%eax
  800750:	ff 75 0c             	pushl  0xc(%ebp)
  800753:	ff 75 08             	pushl  0x8(%ebp)
  800756:	50                   	push   %eax
  800757:	68 91 25 80 00       	push   $0x802591
  80075c:	e8 73 02 00 00       	call   8009d4 <cprintf>
  800761:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800764:	8b 45 10             	mov    0x10(%ebp),%eax
  800767:	83 ec 08             	sub    $0x8,%esp
  80076a:	ff 75 f4             	pushl  -0xc(%ebp)
  80076d:	50                   	push   %eax
  80076e:	e8 f6 01 00 00       	call   800969 <vcprintf>
  800773:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800776:	83 ec 08             	sub    $0x8,%esp
  800779:	6a 00                	push   $0x0
  80077b:	68 ad 25 80 00       	push   $0x8025ad
  800780:	e8 e4 01 00 00       	call   800969 <vcprintf>
  800785:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800788:	e8 82 ff ff ff       	call   80070f <exit>

	// should not return here
	while (1) ;
  80078d:	eb fe                	jmp    80078d <_panic+0x70>

0080078f <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80078f:	55                   	push   %ebp
  800790:	89 e5                	mov    %esp,%ebp
  800792:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800795:	a1 24 30 80 00       	mov    0x803024,%eax
  80079a:	8b 50 74             	mov    0x74(%eax),%edx
  80079d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007a0:	39 c2                	cmp    %eax,%edx
  8007a2:	74 14                	je     8007b8 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007a4:	83 ec 04             	sub    $0x4,%esp
  8007a7:	68 b0 25 80 00       	push   $0x8025b0
  8007ac:	6a 26                	push   $0x26
  8007ae:	68 fc 25 80 00       	push   $0x8025fc
  8007b3:	e8 65 ff ff ff       	call   80071d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007b8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007bf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007c6:	e9 c4 00 00 00       	jmp    80088f <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  8007cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007ce:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d8:	01 d0                	add    %edx,%eax
  8007da:	8b 00                	mov    (%eax),%eax
  8007dc:	85 c0                	test   %eax,%eax
  8007de:	75 08                	jne    8007e8 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007e0:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007e3:	e9 a4 00 00 00       	jmp    80088c <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8007e8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007ef:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007f6:	eb 6b                	jmp    800863 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007f8:	a1 24 30 80 00       	mov    0x803024,%eax
  8007fd:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800803:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800806:	89 d0                	mov    %edx,%eax
  800808:	c1 e0 02             	shl    $0x2,%eax
  80080b:	01 d0                	add    %edx,%eax
  80080d:	c1 e0 02             	shl    $0x2,%eax
  800810:	01 c8                	add    %ecx,%eax
  800812:	8a 40 04             	mov    0x4(%eax),%al
  800815:	84 c0                	test   %al,%al
  800817:	75 47                	jne    800860 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800819:	a1 24 30 80 00       	mov    0x803024,%eax
  80081e:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800824:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800827:	89 d0                	mov    %edx,%eax
  800829:	c1 e0 02             	shl    $0x2,%eax
  80082c:	01 d0                	add    %edx,%eax
  80082e:	c1 e0 02             	shl    $0x2,%eax
  800831:	01 c8                	add    %ecx,%eax
  800833:	8b 00                	mov    (%eax),%eax
  800835:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800838:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80083b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800840:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800842:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800845:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80084c:	8b 45 08             	mov    0x8(%ebp),%eax
  80084f:	01 c8                	add    %ecx,%eax
  800851:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800853:	39 c2                	cmp    %eax,%edx
  800855:	75 09                	jne    800860 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800857:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80085e:	eb 12                	jmp    800872 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800860:	ff 45 e8             	incl   -0x18(%ebp)
  800863:	a1 24 30 80 00       	mov    0x803024,%eax
  800868:	8b 50 74             	mov    0x74(%eax),%edx
  80086b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80086e:	39 c2                	cmp    %eax,%edx
  800870:	77 86                	ja     8007f8 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800872:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800876:	75 14                	jne    80088c <CheckWSWithoutLastIndex+0xfd>
			panic(
  800878:	83 ec 04             	sub    $0x4,%esp
  80087b:	68 08 26 80 00       	push   $0x802608
  800880:	6a 3a                	push   $0x3a
  800882:	68 fc 25 80 00       	push   $0x8025fc
  800887:	e8 91 fe ff ff       	call   80071d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80088c:	ff 45 f0             	incl   -0x10(%ebp)
  80088f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800892:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800895:	0f 8c 30 ff ff ff    	jl     8007cb <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80089b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008a2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008a9:	eb 27                	jmp    8008d2 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008ab:	a1 24 30 80 00       	mov    0x803024,%eax
  8008b0:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8008b6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008b9:	89 d0                	mov    %edx,%eax
  8008bb:	c1 e0 02             	shl    $0x2,%eax
  8008be:	01 d0                	add    %edx,%eax
  8008c0:	c1 e0 02             	shl    $0x2,%eax
  8008c3:	01 c8                	add    %ecx,%eax
  8008c5:	8a 40 04             	mov    0x4(%eax),%al
  8008c8:	3c 01                	cmp    $0x1,%al
  8008ca:	75 03                	jne    8008cf <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  8008cc:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008cf:	ff 45 e0             	incl   -0x20(%ebp)
  8008d2:	a1 24 30 80 00       	mov    0x803024,%eax
  8008d7:	8b 50 74             	mov    0x74(%eax),%edx
  8008da:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008dd:	39 c2                	cmp    %eax,%edx
  8008df:	77 ca                	ja     8008ab <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008e4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008e7:	74 14                	je     8008fd <CheckWSWithoutLastIndex+0x16e>
		panic(
  8008e9:	83 ec 04             	sub    $0x4,%esp
  8008ec:	68 5c 26 80 00       	push   $0x80265c
  8008f1:	6a 44                	push   $0x44
  8008f3:	68 fc 25 80 00       	push   $0x8025fc
  8008f8:	e8 20 fe ff ff       	call   80071d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008fd:	90                   	nop
  8008fe:	c9                   	leave  
  8008ff:	c3                   	ret    

00800900 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800900:	55                   	push   %ebp
  800901:	89 e5                	mov    %esp,%ebp
  800903:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800906:	8b 45 0c             	mov    0xc(%ebp),%eax
  800909:	8b 00                	mov    (%eax),%eax
  80090b:	8d 48 01             	lea    0x1(%eax),%ecx
  80090e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800911:	89 0a                	mov    %ecx,(%edx)
  800913:	8b 55 08             	mov    0x8(%ebp),%edx
  800916:	88 d1                	mov    %dl,%cl
  800918:	8b 55 0c             	mov    0xc(%ebp),%edx
  80091b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80091f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800922:	8b 00                	mov    (%eax),%eax
  800924:	3d ff 00 00 00       	cmp    $0xff,%eax
  800929:	75 2c                	jne    800957 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80092b:	a0 28 30 80 00       	mov    0x803028,%al
  800930:	0f b6 c0             	movzbl %al,%eax
  800933:	8b 55 0c             	mov    0xc(%ebp),%edx
  800936:	8b 12                	mov    (%edx),%edx
  800938:	89 d1                	mov    %edx,%ecx
  80093a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80093d:	83 c2 08             	add    $0x8,%edx
  800940:	83 ec 04             	sub    $0x4,%esp
  800943:	50                   	push   %eax
  800944:	51                   	push   %ecx
  800945:	52                   	push   %edx
  800946:	e8 34 11 00 00       	call   801a7f <sys_cputs>
  80094b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80094e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800951:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800957:	8b 45 0c             	mov    0xc(%ebp),%eax
  80095a:	8b 40 04             	mov    0x4(%eax),%eax
  80095d:	8d 50 01             	lea    0x1(%eax),%edx
  800960:	8b 45 0c             	mov    0xc(%ebp),%eax
  800963:	89 50 04             	mov    %edx,0x4(%eax)
}
  800966:	90                   	nop
  800967:	c9                   	leave  
  800968:	c3                   	ret    

00800969 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800969:	55                   	push   %ebp
  80096a:	89 e5                	mov    %esp,%ebp
  80096c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800972:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800979:	00 00 00 
	b.cnt = 0;
  80097c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800983:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800986:	ff 75 0c             	pushl  0xc(%ebp)
  800989:	ff 75 08             	pushl  0x8(%ebp)
  80098c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800992:	50                   	push   %eax
  800993:	68 00 09 80 00       	push   $0x800900
  800998:	e8 11 02 00 00       	call   800bae <vprintfmt>
  80099d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009a0:	a0 28 30 80 00       	mov    0x803028,%al
  8009a5:	0f b6 c0             	movzbl %al,%eax
  8009a8:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009ae:	83 ec 04             	sub    $0x4,%esp
  8009b1:	50                   	push   %eax
  8009b2:	52                   	push   %edx
  8009b3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009b9:	83 c0 08             	add    $0x8,%eax
  8009bc:	50                   	push   %eax
  8009bd:	e8 bd 10 00 00       	call   801a7f <sys_cputs>
  8009c2:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009c5:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  8009cc:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009d2:	c9                   	leave  
  8009d3:	c3                   	ret    

008009d4 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009d4:	55                   	push   %ebp
  8009d5:	89 e5                	mov    %esp,%ebp
  8009d7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009da:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  8009e1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ea:	83 ec 08             	sub    $0x8,%esp
  8009ed:	ff 75 f4             	pushl  -0xc(%ebp)
  8009f0:	50                   	push   %eax
  8009f1:	e8 73 ff ff ff       	call   800969 <vcprintf>
  8009f6:	83 c4 10             	add    $0x10,%esp
  8009f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009ff:	c9                   	leave  
  800a00:	c3                   	ret    

00800a01 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a01:	55                   	push   %ebp
  800a02:	89 e5                	mov    %esp,%ebp
  800a04:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a07:	e8 84 12 00 00       	call   801c90 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a0c:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a12:	8b 45 08             	mov    0x8(%ebp),%eax
  800a15:	83 ec 08             	sub    $0x8,%esp
  800a18:	ff 75 f4             	pushl  -0xc(%ebp)
  800a1b:	50                   	push   %eax
  800a1c:	e8 48 ff ff ff       	call   800969 <vcprintf>
  800a21:	83 c4 10             	add    $0x10,%esp
  800a24:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a27:	e8 7e 12 00 00       	call   801caa <sys_enable_interrupt>
	return cnt;
  800a2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a2f:	c9                   	leave  
  800a30:	c3                   	ret    

00800a31 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a31:	55                   	push   %ebp
  800a32:	89 e5                	mov    %esp,%ebp
  800a34:	53                   	push   %ebx
  800a35:	83 ec 14             	sub    $0x14,%esp
  800a38:	8b 45 10             	mov    0x10(%ebp),%eax
  800a3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a3e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a41:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a44:	8b 45 18             	mov    0x18(%ebp),%eax
  800a47:	ba 00 00 00 00       	mov    $0x0,%edx
  800a4c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a4f:	77 55                	ja     800aa6 <printnum+0x75>
  800a51:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a54:	72 05                	jb     800a5b <printnum+0x2a>
  800a56:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a59:	77 4b                	ja     800aa6 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a5b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a5e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a61:	8b 45 18             	mov    0x18(%ebp),%eax
  800a64:	ba 00 00 00 00       	mov    $0x0,%edx
  800a69:	52                   	push   %edx
  800a6a:	50                   	push   %eax
  800a6b:	ff 75 f4             	pushl  -0xc(%ebp)
  800a6e:	ff 75 f0             	pushl  -0x10(%ebp)
  800a71:	e8 5a 16 00 00       	call   8020d0 <__udivdi3>
  800a76:	83 c4 10             	add    $0x10,%esp
  800a79:	83 ec 04             	sub    $0x4,%esp
  800a7c:	ff 75 20             	pushl  0x20(%ebp)
  800a7f:	53                   	push   %ebx
  800a80:	ff 75 18             	pushl  0x18(%ebp)
  800a83:	52                   	push   %edx
  800a84:	50                   	push   %eax
  800a85:	ff 75 0c             	pushl  0xc(%ebp)
  800a88:	ff 75 08             	pushl  0x8(%ebp)
  800a8b:	e8 a1 ff ff ff       	call   800a31 <printnum>
  800a90:	83 c4 20             	add    $0x20,%esp
  800a93:	eb 1a                	jmp    800aaf <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a95:	83 ec 08             	sub    $0x8,%esp
  800a98:	ff 75 0c             	pushl  0xc(%ebp)
  800a9b:	ff 75 20             	pushl  0x20(%ebp)
  800a9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa1:	ff d0                	call   *%eax
  800aa3:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800aa6:	ff 4d 1c             	decl   0x1c(%ebp)
  800aa9:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800aad:	7f e6                	jg     800a95 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800aaf:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800ab2:	bb 00 00 00 00       	mov    $0x0,%ebx
  800ab7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800abd:	53                   	push   %ebx
  800abe:	51                   	push   %ecx
  800abf:	52                   	push   %edx
  800ac0:	50                   	push   %eax
  800ac1:	e8 1a 17 00 00       	call   8021e0 <__umoddi3>
  800ac6:	83 c4 10             	add    $0x10,%esp
  800ac9:	05 d4 28 80 00       	add    $0x8028d4,%eax
  800ace:	8a 00                	mov    (%eax),%al
  800ad0:	0f be c0             	movsbl %al,%eax
  800ad3:	83 ec 08             	sub    $0x8,%esp
  800ad6:	ff 75 0c             	pushl  0xc(%ebp)
  800ad9:	50                   	push   %eax
  800ada:	8b 45 08             	mov    0x8(%ebp),%eax
  800add:	ff d0                	call   *%eax
  800adf:	83 c4 10             	add    $0x10,%esp
}
  800ae2:	90                   	nop
  800ae3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ae6:	c9                   	leave  
  800ae7:	c3                   	ret    

00800ae8 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ae8:	55                   	push   %ebp
  800ae9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800aeb:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800aef:	7e 1c                	jle    800b0d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800af1:	8b 45 08             	mov    0x8(%ebp),%eax
  800af4:	8b 00                	mov    (%eax),%eax
  800af6:	8d 50 08             	lea    0x8(%eax),%edx
  800af9:	8b 45 08             	mov    0x8(%ebp),%eax
  800afc:	89 10                	mov    %edx,(%eax)
  800afe:	8b 45 08             	mov    0x8(%ebp),%eax
  800b01:	8b 00                	mov    (%eax),%eax
  800b03:	83 e8 08             	sub    $0x8,%eax
  800b06:	8b 50 04             	mov    0x4(%eax),%edx
  800b09:	8b 00                	mov    (%eax),%eax
  800b0b:	eb 40                	jmp    800b4d <getuint+0x65>
	else if (lflag)
  800b0d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b11:	74 1e                	je     800b31 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b13:	8b 45 08             	mov    0x8(%ebp),%eax
  800b16:	8b 00                	mov    (%eax),%eax
  800b18:	8d 50 04             	lea    0x4(%eax),%edx
  800b1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1e:	89 10                	mov    %edx,(%eax)
  800b20:	8b 45 08             	mov    0x8(%ebp),%eax
  800b23:	8b 00                	mov    (%eax),%eax
  800b25:	83 e8 04             	sub    $0x4,%eax
  800b28:	8b 00                	mov    (%eax),%eax
  800b2a:	ba 00 00 00 00       	mov    $0x0,%edx
  800b2f:	eb 1c                	jmp    800b4d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	8b 00                	mov    (%eax),%eax
  800b36:	8d 50 04             	lea    0x4(%eax),%edx
  800b39:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3c:	89 10                	mov    %edx,(%eax)
  800b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b41:	8b 00                	mov    (%eax),%eax
  800b43:	83 e8 04             	sub    $0x4,%eax
  800b46:	8b 00                	mov    (%eax),%eax
  800b48:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b4d:	5d                   	pop    %ebp
  800b4e:	c3                   	ret    

00800b4f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b4f:	55                   	push   %ebp
  800b50:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b52:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b56:	7e 1c                	jle    800b74 <getint+0x25>
		return va_arg(*ap, long long);
  800b58:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5b:	8b 00                	mov    (%eax),%eax
  800b5d:	8d 50 08             	lea    0x8(%eax),%edx
  800b60:	8b 45 08             	mov    0x8(%ebp),%eax
  800b63:	89 10                	mov    %edx,(%eax)
  800b65:	8b 45 08             	mov    0x8(%ebp),%eax
  800b68:	8b 00                	mov    (%eax),%eax
  800b6a:	83 e8 08             	sub    $0x8,%eax
  800b6d:	8b 50 04             	mov    0x4(%eax),%edx
  800b70:	8b 00                	mov    (%eax),%eax
  800b72:	eb 38                	jmp    800bac <getint+0x5d>
	else if (lflag)
  800b74:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b78:	74 1a                	je     800b94 <getint+0x45>
		return va_arg(*ap, long);
  800b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7d:	8b 00                	mov    (%eax),%eax
  800b7f:	8d 50 04             	lea    0x4(%eax),%edx
  800b82:	8b 45 08             	mov    0x8(%ebp),%eax
  800b85:	89 10                	mov    %edx,(%eax)
  800b87:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8a:	8b 00                	mov    (%eax),%eax
  800b8c:	83 e8 04             	sub    $0x4,%eax
  800b8f:	8b 00                	mov    (%eax),%eax
  800b91:	99                   	cltd   
  800b92:	eb 18                	jmp    800bac <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b94:	8b 45 08             	mov    0x8(%ebp),%eax
  800b97:	8b 00                	mov    (%eax),%eax
  800b99:	8d 50 04             	lea    0x4(%eax),%edx
  800b9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9f:	89 10                	mov    %edx,(%eax)
  800ba1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba4:	8b 00                	mov    (%eax),%eax
  800ba6:	83 e8 04             	sub    $0x4,%eax
  800ba9:	8b 00                	mov    (%eax),%eax
  800bab:	99                   	cltd   
}
  800bac:	5d                   	pop    %ebp
  800bad:	c3                   	ret    

00800bae <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bae:	55                   	push   %ebp
  800baf:	89 e5                	mov    %esp,%ebp
  800bb1:	56                   	push   %esi
  800bb2:	53                   	push   %ebx
  800bb3:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bb6:	eb 17                	jmp    800bcf <vprintfmt+0x21>
			if (ch == '\0')
  800bb8:	85 db                	test   %ebx,%ebx
  800bba:	0f 84 af 03 00 00    	je     800f6f <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bc0:	83 ec 08             	sub    $0x8,%esp
  800bc3:	ff 75 0c             	pushl  0xc(%ebp)
  800bc6:	53                   	push   %ebx
  800bc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bca:	ff d0                	call   *%eax
  800bcc:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bcf:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd2:	8d 50 01             	lea    0x1(%eax),%edx
  800bd5:	89 55 10             	mov    %edx,0x10(%ebp)
  800bd8:	8a 00                	mov    (%eax),%al
  800bda:	0f b6 d8             	movzbl %al,%ebx
  800bdd:	83 fb 25             	cmp    $0x25,%ebx
  800be0:	75 d6                	jne    800bb8 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800be2:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800be6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bed:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bf4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bfb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c02:	8b 45 10             	mov    0x10(%ebp),%eax
  800c05:	8d 50 01             	lea    0x1(%eax),%edx
  800c08:	89 55 10             	mov    %edx,0x10(%ebp)
  800c0b:	8a 00                	mov    (%eax),%al
  800c0d:	0f b6 d8             	movzbl %al,%ebx
  800c10:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c13:	83 f8 55             	cmp    $0x55,%eax
  800c16:	0f 87 2b 03 00 00    	ja     800f47 <vprintfmt+0x399>
  800c1c:	8b 04 85 f8 28 80 00 	mov    0x8028f8(,%eax,4),%eax
  800c23:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c25:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c29:	eb d7                	jmp    800c02 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c2b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c2f:	eb d1                	jmp    800c02 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c31:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c38:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c3b:	89 d0                	mov    %edx,%eax
  800c3d:	c1 e0 02             	shl    $0x2,%eax
  800c40:	01 d0                	add    %edx,%eax
  800c42:	01 c0                	add    %eax,%eax
  800c44:	01 d8                	add    %ebx,%eax
  800c46:	83 e8 30             	sub    $0x30,%eax
  800c49:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c4c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c4f:	8a 00                	mov    (%eax),%al
  800c51:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c54:	83 fb 2f             	cmp    $0x2f,%ebx
  800c57:	7e 3e                	jle    800c97 <vprintfmt+0xe9>
  800c59:	83 fb 39             	cmp    $0x39,%ebx
  800c5c:	7f 39                	jg     800c97 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c5e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c61:	eb d5                	jmp    800c38 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c63:	8b 45 14             	mov    0x14(%ebp),%eax
  800c66:	83 c0 04             	add    $0x4,%eax
  800c69:	89 45 14             	mov    %eax,0x14(%ebp)
  800c6c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c6f:	83 e8 04             	sub    $0x4,%eax
  800c72:	8b 00                	mov    (%eax),%eax
  800c74:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c77:	eb 1f                	jmp    800c98 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c79:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c7d:	79 83                	jns    800c02 <vprintfmt+0x54>
				width = 0;
  800c7f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c86:	e9 77 ff ff ff       	jmp    800c02 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c8b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c92:	e9 6b ff ff ff       	jmp    800c02 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c97:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c98:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c9c:	0f 89 60 ff ff ff    	jns    800c02 <vprintfmt+0x54>
				width = precision, precision = -1;
  800ca2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ca5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800ca8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800caf:	e9 4e ff ff ff       	jmp    800c02 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800cb4:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800cb7:	e9 46 ff ff ff       	jmp    800c02 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cbc:	8b 45 14             	mov    0x14(%ebp),%eax
  800cbf:	83 c0 04             	add    $0x4,%eax
  800cc2:	89 45 14             	mov    %eax,0x14(%ebp)
  800cc5:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc8:	83 e8 04             	sub    $0x4,%eax
  800ccb:	8b 00                	mov    (%eax),%eax
  800ccd:	83 ec 08             	sub    $0x8,%esp
  800cd0:	ff 75 0c             	pushl  0xc(%ebp)
  800cd3:	50                   	push   %eax
  800cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd7:	ff d0                	call   *%eax
  800cd9:	83 c4 10             	add    $0x10,%esp
			break;
  800cdc:	e9 89 02 00 00       	jmp    800f6a <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800ce1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce4:	83 c0 04             	add    $0x4,%eax
  800ce7:	89 45 14             	mov    %eax,0x14(%ebp)
  800cea:	8b 45 14             	mov    0x14(%ebp),%eax
  800ced:	83 e8 04             	sub    $0x4,%eax
  800cf0:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cf2:	85 db                	test   %ebx,%ebx
  800cf4:	79 02                	jns    800cf8 <vprintfmt+0x14a>
				err = -err;
  800cf6:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cf8:	83 fb 64             	cmp    $0x64,%ebx
  800cfb:	7f 0b                	jg     800d08 <vprintfmt+0x15a>
  800cfd:	8b 34 9d 40 27 80 00 	mov    0x802740(,%ebx,4),%esi
  800d04:	85 f6                	test   %esi,%esi
  800d06:	75 19                	jne    800d21 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d08:	53                   	push   %ebx
  800d09:	68 e5 28 80 00       	push   $0x8028e5
  800d0e:	ff 75 0c             	pushl  0xc(%ebp)
  800d11:	ff 75 08             	pushl  0x8(%ebp)
  800d14:	e8 5e 02 00 00       	call   800f77 <printfmt>
  800d19:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d1c:	e9 49 02 00 00       	jmp    800f6a <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d21:	56                   	push   %esi
  800d22:	68 ee 28 80 00       	push   $0x8028ee
  800d27:	ff 75 0c             	pushl  0xc(%ebp)
  800d2a:	ff 75 08             	pushl  0x8(%ebp)
  800d2d:	e8 45 02 00 00       	call   800f77 <printfmt>
  800d32:	83 c4 10             	add    $0x10,%esp
			break;
  800d35:	e9 30 02 00 00       	jmp    800f6a <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d3a:	8b 45 14             	mov    0x14(%ebp),%eax
  800d3d:	83 c0 04             	add    $0x4,%eax
  800d40:	89 45 14             	mov    %eax,0x14(%ebp)
  800d43:	8b 45 14             	mov    0x14(%ebp),%eax
  800d46:	83 e8 04             	sub    $0x4,%eax
  800d49:	8b 30                	mov    (%eax),%esi
  800d4b:	85 f6                	test   %esi,%esi
  800d4d:	75 05                	jne    800d54 <vprintfmt+0x1a6>
				p = "(null)";
  800d4f:	be f1 28 80 00       	mov    $0x8028f1,%esi
			if (width > 0 && padc != '-')
  800d54:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d58:	7e 6d                	jle    800dc7 <vprintfmt+0x219>
  800d5a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d5e:	74 67                	je     800dc7 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d60:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d63:	83 ec 08             	sub    $0x8,%esp
  800d66:	50                   	push   %eax
  800d67:	56                   	push   %esi
  800d68:	e8 12 05 00 00       	call   80127f <strnlen>
  800d6d:	83 c4 10             	add    $0x10,%esp
  800d70:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d73:	eb 16                	jmp    800d8b <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d75:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d79:	83 ec 08             	sub    $0x8,%esp
  800d7c:	ff 75 0c             	pushl  0xc(%ebp)
  800d7f:	50                   	push   %eax
  800d80:	8b 45 08             	mov    0x8(%ebp),%eax
  800d83:	ff d0                	call   *%eax
  800d85:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d88:	ff 4d e4             	decl   -0x1c(%ebp)
  800d8b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d8f:	7f e4                	jg     800d75 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d91:	eb 34                	jmp    800dc7 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d93:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d97:	74 1c                	je     800db5 <vprintfmt+0x207>
  800d99:	83 fb 1f             	cmp    $0x1f,%ebx
  800d9c:	7e 05                	jle    800da3 <vprintfmt+0x1f5>
  800d9e:	83 fb 7e             	cmp    $0x7e,%ebx
  800da1:	7e 12                	jle    800db5 <vprintfmt+0x207>
					putch('?', putdat);
  800da3:	83 ec 08             	sub    $0x8,%esp
  800da6:	ff 75 0c             	pushl  0xc(%ebp)
  800da9:	6a 3f                	push   $0x3f
  800dab:	8b 45 08             	mov    0x8(%ebp),%eax
  800dae:	ff d0                	call   *%eax
  800db0:	83 c4 10             	add    $0x10,%esp
  800db3:	eb 0f                	jmp    800dc4 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800db5:	83 ec 08             	sub    $0x8,%esp
  800db8:	ff 75 0c             	pushl  0xc(%ebp)
  800dbb:	53                   	push   %ebx
  800dbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbf:	ff d0                	call   *%eax
  800dc1:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dc4:	ff 4d e4             	decl   -0x1c(%ebp)
  800dc7:	89 f0                	mov    %esi,%eax
  800dc9:	8d 70 01             	lea    0x1(%eax),%esi
  800dcc:	8a 00                	mov    (%eax),%al
  800dce:	0f be d8             	movsbl %al,%ebx
  800dd1:	85 db                	test   %ebx,%ebx
  800dd3:	74 24                	je     800df9 <vprintfmt+0x24b>
  800dd5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dd9:	78 b8                	js     800d93 <vprintfmt+0x1e5>
  800ddb:	ff 4d e0             	decl   -0x20(%ebp)
  800dde:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800de2:	79 af                	jns    800d93 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800de4:	eb 13                	jmp    800df9 <vprintfmt+0x24b>
				putch(' ', putdat);
  800de6:	83 ec 08             	sub    $0x8,%esp
  800de9:	ff 75 0c             	pushl  0xc(%ebp)
  800dec:	6a 20                	push   $0x20
  800dee:	8b 45 08             	mov    0x8(%ebp),%eax
  800df1:	ff d0                	call   *%eax
  800df3:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800df6:	ff 4d e4             	decl   -0x1c(%ebp)
  800df9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dfd:	7f e7                	jg     800de6 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800dff:	e9 66 01 00 00       	jmp    800f6a <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e04:	83 ec 08             	sub    $0x8,%esp
  800e07:	ff 75 e8             	pushl  -0x18(%ebp)
  800e0a:	8d 45 14             	lea    0x14(%ebp),%eax
  800e0d:	50                   	push   %eax
  800e0e:	e8 3c fd ff ff       	call   800b4f <getint>
  800e13:	83 c4 10             	add    $0x10,%esp
  800e16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e19:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e1f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e22:	85 d2                	test   %edx,%edx
  800e24:	79 23                	jns    800e49 <vprintfmt+0x29b>
				putch('-', putdat);
  800e26:	83 ec 08             	sub    $0x8,%esp
  800e29:	ff 75 0c             	pushl  0xc(%ebp)
  800e2c:	6a 2d                	push   $0x2d
  800e2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e31:	ff d0                	call   *%eax
  800e33:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e36:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e39:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e3c:	f7 d8                	neg    %eax
  800e3e:	83 d2 00             	adc    $0x0,%edx
  800e41:	f7 da                	neg    %edx
  800e43:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e46:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e49:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e50:	e9 bc 00 00 00       	jmp    800f11 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e55:	83 ec 08             	sub    $0x8,%esp
  800e58:	ff 75 e8             	pushl  -0x18(%ebp)
  800e5b:	8d 45 14             	lea    0x14(%ebp),%eax
  800e5e:	50                   	push   %eax
  800e5f:	e8 84 fc ff ff       	call   800ae8 <getuint>
  800e64:	83 c4 10             	add    $0x10,%esp
  800e67:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e6a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e6d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e74:	e9 98 00 00 00       	jmp    800f11 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e79:	83 ec 08             	sub    $0x8,%esp
  800e7c:	ff 75 0c             	pushl  0xc(%ebp)
  800e7f:	6a 58                	push   $0x58
  800e81:	8b 45 08             	mov    0x8(%ebp),%eax
  800e84:	ff d0                	call   *%eax
  800e86:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e89:	83 ec 08             	sub    $0x8,%esp
  800e8c:	ff 75 0c             	pushl  0xc(%ebp)
  800e8f:	6a 58                	push   $0x58
  800e91:	8b 45 08             	mov    0x8(%ebp),%eax
  800e94:	ff d0                	call   *%eax
  800e96:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e99:	83 ec 08             	sub    $0x8,%esp
  800e9c:	ff 75 0c             	pushl  0xc(%ebp)
  800e9f:	6a 58                	push   $0x58
  800ea1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea4:	ff d0                	call   *%eax
  800ea6:	83 c4 10             	add    $0x10,%esp
			break;
  800ea9:	e9 bc 00 00 00       	jmp    800f6a <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800eae:	83 ec 08             	sub    $0x8,%esp
  800eb1:	ff 75 0c             	pushl  0xc(%ebp)
  800eb4:	6a 30                	push   $0x30
  800eb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb9:	ff d0                	call   *%eax
  800ebb:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ebe:	83 ec 08             	sub    $0x8,%esp
  800ec1:	ff 75 0c             	pushl  0xc(%ebp)
  800ec4:	6a 78                	push   $0x78
  800ec6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec9:	ff d0                	call   *%eax
  800ecb:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ece:	8b 45 14             	mov    0x14(%ebp),%eax
  800ed1:	83 c0 04             	add    $0x4,%eax
  800ed4:	89 45 14             	mov    %eax,0x14(%ebp)
  800ed7:	8b 45 14             	mov    0x14(%ebp),%eax
  800eda:	83 e8 04             	sub    $0x4,%eax
  800edd:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800edf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ee2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ee9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ef0:	eb 1f                	jmp    800f11 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ef2:	83 ec 08             	sub    $0x8,%esp
  800ef5:	ff 75 e8             	pushl  -0x18(%ebp)
  800ef8:	8d 45 14             	lea    0x14(%ebp),%eax
  800efb:	50                   	push   %eax
  800efc:	e8 e7 fb ff ff       	call   800ae8 <getuint>
  800f01:	83 c4 10             	add    $0x10,%esp
  800f04:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f07:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f0a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f11:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f15:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f18:	83 ec 04             	sub    $0x4,%esp
  800f1b:	52                   	push   %edx
  800f1c:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f1f:	50                   	push   %eax
  800f20:	ff 75 f4             	pushl  -0xc(%ebp)
  800f23:	ff 75 f0             	pushl  -0x10(%ebp)
  800f26:	ff 75 0c             	pushl  0xc(%ebp)
  800f29:	ff 75 08             	pushl  0x8(%ebp)
  800f2c:	e8 00 fb ff ff       	call   800a31 <printnum>
  800f31:	83 c4 20             	add    $0x20,%esp
			break;
  800f34:	eb 34                	jmp    800f6a <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f36:	83 ec 08             	sub    $0x8,%esp
  800f39:	ff 75 0c             	pushl  0xc(%ebp)
  800f3c:	53                   	push   %ebx
  800f3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f40:	ff d0                	call   *%eax
  800f42:	83 c4 10             	add    $0x10,%esp
			break;
  800f45:	eb 23                	jmp    800f6a <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f47:	83 ec 08             	sub    $0x8,%esp
  800f4a:	ff 75 0c             	pushl  0xc(%ebp)
  800f4d:	6a 25                	push   $0x25
  800f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f52:	ff d0                	call   *%eax
  800f54:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f57:	ff 4d 10             	decl   0x10(%ebp)
  800f5a:	eb 03                	jmp    800f5f <vprintfmt+0x3b1>
  800f5c:	ff 4d 10             	decl   0x10(%ebp)
  800f5f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f62:	48                   	dec    %eax
  800f63:	8a 00                	mov    (%eax),%al
  800f65:	3c 25                	cmp    $0x25,%al
  800f67:	75 f3                	jne    800f5c <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f69:	90                   	nop
		}
	}
  800f6a:	e9 47 fc ff ff       	jmp    800bb6 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f6f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f70:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f73:	5b                   	pop    %ebx
  800f74:	5e                   	pop    %esi
  800f75:	5d                   	pop    %ebp
  800f76:	c3                   	ret    

00800f77 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f77:	55                   	push   %ebp
  800f78:	89 e5                	mov    %esp,%ebp
  800f7a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f7d:	8d 45 10             	lea    0x10(%ebp),%eax
  800f80:	83 c0 04             	add    $0x4,%eax
  800f83:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f86:	8b 45 10             	mov    0x10(%ebp),%eax
  800f89:	ff 75 f4             	pushl  -0xc(%ebp)
  800f8c:	50                   	push   %eax
  800f8d:	ff 75 0c             	pushl  0xc(%ebp)
  800f90:	ff 75 08             	pushl  0x8(%ebp)
  800f93:	e8 16 fc ff ff       	call   800bae <vprintfmt>
  800f98:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f9b:	90                   	nop
  800f9c:	c9                   	leave  
  800f9d:	c3                   	ret    

00800f9e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f9e:	55                   	push   %ebp
  800f9f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fa1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa4:	8b 40 08             	mov    0x8(%eax),%eax
  800fa7:	8d 50 01             	lea    0x1(%eax),%edx
  800faa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fad:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fb0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb3:	8b 10                	mov    (%eax),%edx
  800fb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb8:	8b 40 04             	mov    0x4(%eax),%eax
  800fbb:	39 c2                	cmp    %eax,%edx
  800fbd:	73 12                	jae    800fd1 <sprintputch+0x33>
		*b->buf++ = ch;
  800fbf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc2:	8b 00                	mov    (%eax),%eax
  800fc4:	8d 48 01             	lea    0x1(%eax),%ecx
  800fc7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fca:	89 0a                	mov    %ecx,(%edx)
  800fcc:	8b 55 08             	mov    0x8(%ebp),%edx
  800fcf:	88 10                	mov    %dl,(%eax)
}
  800fd1:	90                   	nop
  800fd2:	5d                   	pop    %ebp
  800fd3:	c3                   	ret    

00800fd4 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fd4:	55                   	push   %ebp
  800fd5:	89 e5                	mov    %esp,%ebp
  800fd7:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fe0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fe6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe9:	01 d0                	add    %edx,%eax
  800feb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800ff5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ff9:	74 06                	je     801001 <vsnprintf+0x2d>
  800ffb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fff:	7f 07                	jg     801008 <vsnprintf+0x34>
		return -E_INVAL;
  801001:	b8 03 00 00 00       	mov    $0x3,%eax
  801006:	eb 20                	jmp    801028 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801008:	ff 75 14             	pushl  0x14(%ebp)
  80100b:	ff 75 10             	pushl  0x10(%ebp)
  80100e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801011:	50                   	push   %eax
  801012:	68 9e 0f 80 00       	push   $0x800f9e
  801017:	e8 92 fb ff ff       	call   800bae <vprintfmt>
  80101c:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80101f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801022:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801025:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801028:	c9                   	leave  
  801029:	c3                   	ret    

0080102a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80102a:	55                   	push   %ebp
  80102b:	89 e5                	mov    %esp,%ebp
  80102d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801030:	8d 45 10             	lea    0x10(%ebp),%eax
  801033:	83 c0 04             	add    $0x4,%eax
  801036:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801039:	8b 45 10             	mov    0x10(%ebp),%eax
  80103c:	ff 75 f4             	pushl  -0xc(%ebp)
  80103f:	50                   	push   %eax
  801040:	ff 75 0c             	pushl  0xc(%ebp)
  801043:	ff 75 08             	pushl  0x8(%ebp)
  801046:	e8 89 ff ff ff       	call   800fd4 <vsnprintf>
  80104b:	83 c4 10             	add    $0x10,%esp
  80104e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801051:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801054:	c9                   	leave  
  801055:	c3                   	ret    

00801056 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801056:	55                   	push   %ebp
  801057:	89 e5                	mov    %esp,%ebp
  801059:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80105c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801060:	74 13                	je     801075 <readline+0x1f>
		cprintf("%s", prompt);
  801062:	83 ec 08             	sub    $0x8,%esp
  801065:	ff 75 08             	pushl  0x8(%ebp)
  801068:	68 50 2a 80 00       	push   $0x802a50
  80106d:	e8 62 f9 ff ff       	call   8009d4 <cprintf>
  801072:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801075:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80107c:	83 ec 0c             	sub    $0xc,%esp
  80107f:	6a 00                	push   $0x0
  801081:	e8 68 f5 ff ff       	call   8005ee <iscons>
  801086:	83 c4 10             	add    $0x10,%esp
  801089:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80108c:	e8 0f f5 ff ff       	call   8005a0 <getchar>
  801091:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801094:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801098:	79 22                	jns    8010bc <readline+0x66>
			if (c != -E_EOF)
  80109a:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80109e:	0f 84 ad 00 00 00    	je     801151 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8010a4:	83 ec 08             	sub    $0x8,%esp
  8010a7:	ff 75 ec             	pushl  -0x14(%ebp)
  8010aa:	68 53 2a 80 00       	push   $0x802a53
  8010af:	e8 20 f9 ff ff       	call   8009d4 <cprintf>
  8010b4:	83 c4 10             	add    $0x10,%esp
			return;
  8010b7:	e9 95 00 00 00       	jmp    801151 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8010bc:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8010c0:	7e 34                	jle    8010f6 <readline+0xa0>
  8010c2:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8010c9:	7f 2b                	jg     8010f6 <readline+0xa0>
			if (echoing)
  8010cb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010cf:	74 0e                	je     8010df <readline+0x89>
				cputchar(c);
  8010d1:	83 ec 0c             	sub    $0xc,%esp
  8010d4:	ff 75 ec             	pushl  -0x14(%ebp)
  8010d7:	e8 7c f4 ff ff       	call   800558 <cputchar>
  8010dc:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8010df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010e2:	8d 50 01             	lea    0x1(%eax),%edx
  8010e5:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8010e8:	89 c2                	mov    %eax,%edx
  8010ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ed:	01 d0                	add    %edx,%eax
  8010ef:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010f2:	88 10                	mov    %dl,(%eax)
  8010f4:	eb 56                	jmp    80114c <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8010f6:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8010fa:	75 1f                	jne    80111b <readline+0xc5>
  8010fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801100:	7e 19                	jle    80111b <readline+0xc5>
			if (echoing)
  801102:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801106:	74 0e                	je     801116 <readline+0xc0>
				cputchar(c);
  801108:	83 ec 0c             	sub    $0xc,%esp
  80110b:	ff 75 ec             	pushl  -0x14(%ebp)
  80110e:	e8 45 f4 ff ff       	call   800558 <cputchar>
  801113:	83 c4 10             	add    $0x10,%esp

			i--;
  801116:	ff 4d f4             	decl   -0xc(%ebp)
  801119:	eb 31                	jmp    80114c <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  80111b:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80111f:	74 0a                	je     80112b <readline+0xd5>
  801121:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801125:	0f 85 61 ff ff ff    	jne    80108c <readline+0x36>
			if (echoing)
  80112b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80112f:	74 0e                	je     80113f <readline+0xe9>
				cputchar(c);
  801131:	83 ec 0c             	sub    $0xc,%esp
  801134:	ff 75 ec             	pushl  -0x14(%ebp)
  801137:	e8 1c f4 ff ff       	call   800558 <cputchar>
  80113c:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80113f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801142:	8b 45 0c             	mov    0xc(%ebp),%eax
  801145:	01 d0                	add    %edx,%eax
  801147:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80114a:	eb 06                	jmp    801152 <readline+0xfc>
		}
	}
  80114c:	e9 3b ff ff ff       	jmp    80108c <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801151:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801152:	c9                   	leave  
  801153:	c3                   	ret    

00801154 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801154:	55                   	push   %ebp
  801155:	89 e5                	mov    %esp,%ebp
  801157:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80115a:	e8 31 0b 00 00       	call   801c90 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80115f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801163:	74 13                	je     801178 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801165:	83 ec 08             	sub    $0x8,%esp
  801168:	ff 75 08             	pushl  0x8(%ebp)
  80116b:	68 50 2a 80 00       	push   $0x802a50
  801170:	e8 5f f8 ff ff       	call   8009d4 <cprintf>
  801175:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801178:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80117f:	83 ec 0c             	sub    $0xc,%esp
  801182:	6a 00                	push   $0x0
  801184:	e8 65 f4 ff ff       	call   8005ee <iscons>
  801189:	83 c4 10             	add    $0x10,%esp
  80118c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80118f:	e8 0c f4 ff ff       	call   8005a0 <getchar>
  801194:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801197:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80119b:	79 23                	jns    8011c0 <atomic_readline+0x6c>
			if (c != -E_EOF)
  80119d:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8011a1:	74 13                	je     8011b6 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8011a3:	83 ec 08             	sub    $0x8,%esp
  8011a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8011a9:	68 53 2a 80 00       	push   $0x802a53
  8011ae:	e8 21 f8 ff ff       	call   8009d4 <cprintf>
  8011b3:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011b6:	e8 ef 0a 00 00       	call   801caa <sys_enable_interrupt>
			return;
  8011bb:	e9 9a 00 00 00       	jmp    80125a <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011c0:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011c4:	7e 34                	jle    8011fa <atomic_readline+0xa6>
  8011c6:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011cd:	7f 2b                	jg     8011fa <atomic_readline+0xa6>
			if (echoing)
  8011cf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011d3:	74 0e                	je     8011e3 <atomic_readline+0x8f>
				cputchar(c);
  8011d5:	83 ec 0c             	sub    $0xc,%esp
  8011d8:	ff 75 ec             	pushl  -0x14(%ebp)
  8011db:	e8 78 f3 ff ff       	call   800558 <cputchar>
  8011e0:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011e6:	8d 50 01             	lea    0x1(%eax),%edx
  8011e9:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011ec:	89 c2                	mov    %eax,%edx
  8011ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f1:	01 d0                	add    %edx,%eax
  8011f3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011f6:	88 10                	mov    %dl,(%eax)
  8011f8:	eb 5b                	jmp    801255 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8011fa:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011fe:	75 1f                	jne    80121f <atomic_readline+0xcb>
  801200:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801204:	7e 19                	jle    80121f <atomic_readline+0xcb>
			if (echoing)
  801206:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80120a:	74 0e                	je     80121a <atomic_readline+0xc6>
				cputchar(c);
  80120c:	83 ec 0c             	sub    $0xc,%esp
  80120f:	ff 75 ec             	pushl  -0x14(%ebp)
  801212:	e8 41 f3 ff ff       	call   800558 <cputchar>
  801217:	83 c4 10             	add    $0x10,%esp
			i--;
  80121a:	ff 4d f4             	decl   -0xc(%ebp)
  80121d:	eb 36                	jmp    801255 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  80121f:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801223:	74 0a                	je     80122f <atomic_readline+0xdb>
  801225:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801229:	0f 85 60 ff ff ff    	jne    80118f <atomic_readline+0x3b>
			if (echoing)
  80122f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801233:	74 0e                	je     801243 <atomic_readline+0xef>
				cputchar(c);
  801235:	83 ec 0c             	sub    $0xc,%esp
  801238:	ff 75 ec             	pushl  -0x14(%ebp)
  80123b:	e8 18 f3 ff ff       	call   800558 <cputchar>
  801240:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801243:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801246:	8b 45 0c             	mov    0xc(%ebp),%eax
  801249:	01 d0                	add    %edx,%eax
  80124b:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80124e:	e8 57 0a 00 00       	call   801caa <sys_enable_interrupt>
			return;
  801253:	eb 05                	jmp    80125a <atomic_readline+0x106>
		}
	}
  801255:	e9 35 ff ff ff       	jmp    80118f <atomic_readline+0x3b>
}
  80125a:	c9                   	leave  
  80125b:	c3                   	ret    

0080125c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80125c:	55                   	push   %ebp
  80125d:	89 e5                	mov    %esp,%ebp
  80125f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801262:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801269:	eb 06                	jmp    801271 <strlen+0x15>
		n++;
  80126b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80126e:	ff 45 08             	incl   0x8(%ebp)
  801271:	8b 45 08             	mov    0x8(%ebp),%eax
  801274:	8a 00                	mov    (%eax),%al
  801276:	84 c0                	test   %al,%al
  801278:	75 f1                	jne    80126b <strlen+0xf>
		n++;
	return n;
  80127a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80127d:	c9                   	leave  
  80127e:	c3                   	ret    

0080127f <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80127f:	55                   	push   %ebp
  801280:	89 e5                	mov    %esp,%ebp
  801282:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801285:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80128c:	eb 09                	jmp    801297 <strnlen+0x18>
		n++;
  80128e:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801291:	ff 45 08             	incl   0x8(%ebp)
  801294:	ff 4d 0c             	decl   0xc(%ebp)
  801297:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80129b:	74 09                	je     8012a6 <strnlen+0x27>
  80129d:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a0:	8a 00                	mov    (%eax),%al
  8012a2:	84 c0                	test   %al,%al
  8012a4:	75 e8                	jne    80128e <strnlen+0xf>
		n++;
	return n;
  8012a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012a9:	c9                   	leave  
  8012aa:	c3                   	ret    

008012ab <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8012ab:	55                   	push   %ebp
  8012ac:	89 e5                	mov    %esp,%ebp
  8012ae:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8012b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012b7:	90                   	nop
  8012b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bb:	8d 50 01             	lea    0x1(%eax),%edx
  8012be:	89 55 08             	mov    %edx,0x8(%ebp)
  8012c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012c4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012c7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012ca:	8a 12                	mov    (%edx),%dl
  8012cc:	88 10                	mov    %dl,(%eax)
  8012ce:	8a 00                	mov    (%eax),%al
  8012d0:	84 c0                	test   %al,%al
  8012d2:	75 e4                	jne    8012b8 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8012d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012d7:	c9                   	leave  
  8012d8:	c3                   	ret    

008012d9 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012d9:	55                   	push   %ebp
  8012da:	89 e5                	mov    %esp,%ebp
  8012dc:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012df:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012ec:	eb 1f                	jmp    80130d <strncpy+0x34>
		*dst++ = *src;
  8012ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f1:	8d 50 01             	lea    0x1(%eax),%edx
  8012f4:	89 55 08             	mov    %edx,0x8(%ebp)
  8012f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012fa:	8a 12                	mov    (%edx),%dl
  8012fc:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801301:	8a 00                	mov    (%eax),%al
  801303:	84 c0                	test   %al,%al
  801305:	74 03                	je     80130a <strncpy+0x31>
			src++;
  801307:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80130a:	ff 45 fc             	incl   -0x4(%ebp)
  80130d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801310:	3b 45 10             	cmp    0x10(%ebp),%eax
  801313:	72 d9                	jb     8012ee <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801315:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801318:	c9                   	leave  
  801319:	c3                   	ret    

0080131a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80131a:	55                   	push   %ebp
  80131b:	89 e5                	mov    %esp,%ebp
  80131d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801320:	8b 45 08             	mov    0x8(%ebp),%eax
  801323:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801326:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80132a:	74 30                	je     80135c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80132c:	eb 16                	jmp    801344 <strlcpy+0x2a>
			*dst++ = *src++;
  80132e:	8b 45 08             	mov    0x8(%ebp),%eax
  801331:	8d 50 01             	lea    0x1(%eax),%edx
  801334:	89 55 08             	mov    %edx,0x8(%ebp)
  801337:	8b 55 0c             	mov    0xc(%ebp),%edx
  80133a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80133d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801340:	8a 12                	mov    (%edx),%dl
  801342:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801344:	ff 4d 10             	decl   0x10(%ebp)
  801347:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80134b:	74 09                	je     801356 <strlcpy+0x3c>
  80134d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801350:	8a 00                	mov    (%eax),%al
  801352:	84 c0                	test   %al,%al
  801354:	75 d8                	jne    80132e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801356:	8b 45 08             	mov    0x8(%ebp),%eax
  801359:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80135c:	8b 55 08             	mov    0x8(%ebp),%edx
  80135f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801362:	29 c2                	sub    %eax,%edx
  801364:	89 d0                	mov    %edx,%eax
}
  801366:	c9                   	leave  
  801367:	c3                   	ret    

00801368 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801368:	55                   	push   %ebp
  801369:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80136b:	eb 06                	jmp    801373 <strcmp+0xb>
		p++, q++;
  80136d:	ff 45 08             	incl   0x8(%ebp)
  801370:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801373:	8b 45 08             	mov    0x8(%ebp),%eax
  801376:	8a 00                	mov    (%eax),%al
  801378:	84 c0                	test   %al,%al
  80137a:	74 0e                	je     80138a <strcmp+0x22>
  80137c:	8b 45 08             	mov    0x8(%ebp),%eax
  80137f:	8a 10                	mov    (%eax),%dl
  801381:	8b 45 0c             	mov    0xc(%ebp),%eax
  801384:	8a 00                	mov    (%eax),%al
  801386:	38 c2                	cmp    %al,%dl
  801388:	74 e3                	je     80136d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80138a:	8b 45 08             	mov    0x8(%ebp),%eax
  80138d:	8a 00                	mov    (%eax),%al
  80138f:	0f b6 d0             	movzbl %al,%edx
  801392:	8b 45 0c             	mov    0xc(%ebp),%eax
  801395:	8a 00                	mov    (%eax),%al
  801397:	0f b6 c0             	movzbl %al,%eax
  80139a:	29 c2                	sub    %eax,%edx
  80139c:	89 d0                	mov    %edx,%eax
}
  80139e:	5d                   	pop    %ebp
  80139f:	c3                   	ret    

008013a0 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8013a0:	55                   	push   %ebp
  8013a1:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8013a3:	eb 09                	jmp    8013ae <strncmp+0xe>
		n--, p++, q++;
  8013a5:	ff 4d 10             	decl   0x10(%ebp)
  8013a8:	ff 45 08             	incl   0x8(%ebp)
  8013ab:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013ae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013b2:	74 17                	je     8013cb <strncmp+0x2b>
  8013b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b7:	8a 00                	mov    (%eax),%al
  8013b9:	84 c0                	test   %al,%al
  8013bb:	74 0e                	je     8013cb <strncmp+0x2b>
  8013bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c0:	8a 10                	mov    (%eax),%dl
  8013c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c5:	8a 00                	mov    (%eax),%al
  8013c7:	38 c2                	cmp    %al,%dl
  8013c9:	74 da                	je     8013a5 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013cb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013cf:	75 07                	jne    8013d8 <strncmp+0x38>
		return 0;
  8013d1:	b8 00 00 00 00       	mov    $0x0,%eax
  8013d6:	eb 14                	jmp    8013ec <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8013d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013db:	8a 00                	mov    (%eax),%al
  8013dd:	0f b6 d0             	movzbl %al,%edx
  8013e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e3:	8a 00                	mov    (%eax),%al
  8013e5:	0f b6 c0             	movzbl %al,%eax
  8013e8:	29 c2                	sub    %eax,%edx
  8013ea:	89 d0                	mov    %edx,%eax
}
  8013ec:	5d                   	pop    %ebp
  8013ed:	c3                   	ret    

008013ee <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013ee:	55                   	push   %ebp
  8013ef:	89 e5                	mov    %esp,%ebp
  8013f1:	83 ec 04             	sub    $0x4,%esp
  8013f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013fa:	eb 12                	jmp    80140e <strchr+0x20>
		if (*s == c)
  8013fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ff:	8a 00                	mov    (%eax),%al
  801401:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801404:	75 05                	jne    80140b <strchr+0x1d>
			return (char *) s;
  801406:	8b 45 08             	mov    0x8(%ebp),%eax
  801409:	eb 11                	jmp    80141c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80140b:	ff 45 08             	incl   0x8(%ebp)
  80140e:	8b 45 08             	mov    0x8(%ebp),%eax
  801411:	8a 00                	mov    (%eax),%al
  801413:	84 c0                	test   %al,%al
  801415:	75 e5                	jne    8013fc <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801417:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80141c:	c9                   	leave  
  80141d:	c3                   	ret    

0080141e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80141e:	55                   	push   %ebp
  80141f:	89 e5                	mov    %esp,%ebp
  801421:	83 ec 04             	sub    $0x4,%esp
  801424:	8b 45 0c             	mov    0xc(%ebp),%eax
  801427:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80142a:	eb 0d                	jmp    801439 <strfind+0x1b>
		if (*s == c)
  80142c:	8b 45 08             	mov    0x8(%ebp),%eax
  80142f:	8a 00                	mov    (%eax),%al
  801431:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801434:	74 0e                	je     801444 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801436:	ff 45 08             	incl   0x8(%ebp)
  801439:	8b 45 08             	mov    0x8(%ebp),%eax
  80143c:	8a 00                	mov    (%eax),%al
  80143e:	84 c0                	test   %al,%al
  801440:	75 ea                	jne    80142c <strfind+0xe>
  801442:	eb 01                	jmp    801445 <strfind+0x27>
		if (*s == c)
			break;
  801444:	90                   	nop
	return (char *) s;
  801445:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801448:	c9                   	leave  
  801449:	c3                   	ret    

0080144a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80144a:	55                   	push   %ebp
  80144b:	89 e5                	mov    %esp,%ebp
  80144d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801450:	8b 45 08             	mov    0x8(%ebp),%eax
  801453:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801456:	8b 45 10             	mov    0x10(%ebp),%eax
  801459:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80145c:	eb 0e                	jmp    80146c <memset+0x22>
		*p++ = c;
  80145e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801461:	8d 50 01             	lea    0x1(%eax),%edx
  801464:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801467:	8b 55 0c             	mov    0xc(%ebp),%edx
  80146a:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80146c:	ff 4d f8             	decl   -0x8(%ebp)
  80146f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801473:	79 e9                	jns    80145e <memset+0x14>
		*p++ = c;

	return v;
  801475:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801478:	c9                   	leave  
  801479:	c3                   	ret    

0080147a <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80147a:	55                   	push   %ebp
  80147b:	89 e5                	mov    %esp,%ebp
  80147d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801480:	8b 45 0c             	mov    0xc(%ebp),%eax
  801483:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801486:	8b 45 08             	mov    0x8(%ebp),%eax
  801489:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80148c:	eb 16                	jmp    8014a4 <memcpy+0x2a>
		*d++ = *s++;
  80148e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801491:	8d 50 01             	lea    0x1(%eax),%edx
  801494:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801497:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80149a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80149d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014a0:	8a 12                	mov    (%edx),%dl
  8014a2:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8014a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8014a7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014aa:	89 55 10             	mov    %edx,0x10(%ebp)
  8014ad:	85 c0                	test   %eax,%eax
  8014af:	75 dd                	jne    80148e <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8014b1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014b4:	c9                   	leave  
  8014b5:	c3                   	ret    

008014b6 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014b6:	55                   	push   %ebp
  8014b7:	89 e5                	mov    %esp,%ebp
  8014b9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014cb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014ce:	73 50                	jae    801520 <memmove+0x6a>
  8014d0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d6:	01 d0                	add    %edx,%eax
  8014d8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014db:	76 43                	jbe    801520 <memmove+0x6a>
		s += n;
  8014dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e0:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e6:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014e9:	eb 10                	jmp    8014fb <memmove+0x45>
			*--d = *--s;
  8014eb:	ff 4d f8             	decl   -0x8(%ebp)
  8014ee:	ff 4d fc             	decl   -0x4(%ebp)
  8014f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014f4:	8a 10                	mov    (%eax),%dl
  8014f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014f9:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8014fe:	8d 50 ff             	lea    -0x1(%eax),%edx
  801501:	89 55 10             	mov    %edx,0x10(%ebp)
  801504:	85 c0                	test   %eax,%eax
  801506:	75 e3                	jne    8014eb <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801508:	eb 23                	jmp    80152d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80150a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80150d:	8d 50 01             	lea    0x1(%eax),%edx
  801510:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801513:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801516:	8d 4a 01             	lea    0x1(%edx),%ecx
  801519:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80151c:	8a 12                	mov    (%edx),%dl
  80151e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801520:	8b 45 10             	mov    0x10(%ebp),%eax
  801523:	8d 50 ff             	lea    -0x1(%eax),%edx
  801526:	89 55 10             	mov    %edx,0x10(%ebp)
  801529:	85 c0                	test   %eax,%eax
  80152b:	75 dd                	jne    80150a <memmove+0x54>
			*d++ = *s++;

	return dst;
  80152d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801530:	c9                   	leave  
  801531:	c3                   	ret    

00801532 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801532:	55                   	push   %ebp
  801533:	89 e5                	mov    %esp,%ebp
  801535:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801538:	8b 45 08             	mov    0x8(%ebp),%eax
  80153b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80153e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801541:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801544:	eb 2a                	jmp    801570 <memcmp+0x3e>
		if (*s1 != *s2)
  801546:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801549:	8a 10                	mov    (%eax),%dl
  80154b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80154e:	8a 00                	mov    (%eax),%al
  801550:	38 c2                	cmp    %al,%dl
  801552:	74 16                	je     80156a <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801554:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801557:	8a 00                	mov    (%eax),%al
  801559:	0f b6 d0             	movzbl %al,%edx
  80155c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80155f:	8a 00                	mov    (%eax),%al
  801561:	0f b6 c0             	movzbl %al,%eax
  801564:	29 c2                	sub    %eax,%edx
  801566:	89 d0                	mov    %edx,%eax
  801568:	eb 18                	jmp    801582 <memcmp+0x50>
		s1++, s2++;
  80156a:	ff 45 fc             	incl   -0x4(%ebp)
  80156d:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801570:	8b 45 10             	mov    0x10(%ebp),%eax
  801573:	8d 50 ff             	lea    -0x1(%eax),%edx
  801576:	89 55 10             	mov    %edx,0x10(%ebp)
  801579:	85 c0                	test   %eax,%eax
  80157b:	75 c9                	jne    801546 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80157d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801582:	c9                   	leave  
  801583:	c3                   	ret    

00801584 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801584:	55                   	push   %ebp
  801585:	89 e5                	mov    %esp,%ebp
  801587:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80158a:	8b 55 08             	mov    0x8(%ebp),%edx
  80158d:	8b 45 10             	mov    0x10(%ebp),%eax
  801590:	01 d0                	add    %edx,%eax
  801592:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801595:	eb 15                	jmp    8015ac <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801597:	8b 45 08             	mov    0x8(%ebp),%eax
  80159a:	8a 00                	mov    (%eax),%al
  80159c:	0f b6 d0             	movzbl %al,%edx
  80159f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a2:	0f b6 c0             	movzbl %al,%eax
  8015a5:	39 c2                	cmp    %eax,%edx
  8015a7:	74 0d                	je     8015b6 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015a9:	ff 45 08             	incl   0x8(%ebp)
  8015ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8015af:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015b2:	72 e3                	jb     801597 <memfind+0x13>
  8015b4:	eb 01                	jmp    8015b7 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015b6:	90                   	nop
	return (void *) s;
  8015b7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015ba:	c9                   	leave  
  8015bb:	c3                   	ret    

008015bc <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015bc:	55                   	push   %ebp
  8015bd:	89 e5                	mov    %esp,%ebp
  8015bf:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015c9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015d0:	eb 03                	jmp    8015d5 <strtol+0x19>
		s++;
  8015d2:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d8:	8a 00                	mov    (%eax),%al
  8015da:	3c 20                	cmp    $0x20,%al
  8015dc:	74 f4                	je     8015d2 <strtol+0x16>
  8015de:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e1:	8a 00                	mov    (%eax),%al
  8015e3:	3c 09                	cmp    $0x9,%al
  8015e5:	74 eb                	je     8015d2 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ea:	8a 00                	mov    (%eax),%al
  8015ec:	3c 2b                	cmp    $0x2b,%al
  8015ee:	75 05                	jne    8015f5 <strtol+0x39>
		s++;
  8015f0:	ff 45 08             	incl   0x8(%ebp)
  8015f3:	eb 13                	jmp    801608 <strtol+0x4c>
	else if (*s == '-')
  8015f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f8:	8a 00                	mov    (%eax),%al
  8015fa:	3c 2d                	cmp    $0x2d,%al
  8015fc:	75 0a                	jne    801608 <strtol+0x4c>
		s++, neg = 1;
  8015fe:	ff 45 08             	incl   0x8(%ebp)
  801601:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801608:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80160c:	74 06                	je     801614 <strtol+0x58>
  80160e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801612:	75 20                	jne    801634 <strtol+0x78>
  801614:	8b 45 08             	mov    0x8(%ebp),%eax
  801617:	8a 00                	mov    (%eax),%al
  801619:	3c 30                	cmp    $0x30,%al
  80161b:	75 17                	jne    801634 <strtol+0x78>
  80161d:	8b 45 08             	mov    0x8(%ebp),%eax
  801620:	40                   	inc    %eax
  801621:	8a 00                	mov    (%eax),%al
  801623:	3c 78                	cmp    $0x78,%al
  801625:	75 0d                	jne    801634 <strtol+0x78>
		s += 2, base = 16;
  801627:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80162b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801632:	eb 28                	jmp    80165c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801634:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801638:	75 15                	jne    80164f <strtol+0x93>
  80163a:	8b 45 08             	mov    0x8(%ebp),%eax
  80163d:	8a 00                	mov    (%eax),%al
  80163f:	3c 30                	cmp    $0x30,%al
  801641:	75 0c                	jne    80164f <strtol+0x93>
		s++, base = 8;
  801643:	ff 45 08             	incl   0x8(%ebp)
  801646:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80164d:	eb 0d                	jmp    80165c <strtol+0xa0>
	else if (base == 0)
  80164f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801653:	75 07                	jne    80165c <strtol+0xa0>
		base = 10;
  801655:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80165c:	8b 45 08             	mov    0x8(%ebp),%eax
  80165f:	8a 00                	mov    (%eax),%al
  801661:	3c 2f                	cmp    $0x2f,%al
  801663:	7e 19                	jle    80167e <strtol+0xc2>
  801665:	8b 45 08             	mov    0x8(%ebp),%eax
  801668:	8a 00                	mov    (%eax),%al
  80166a:	3c 39                	cmp    $0x39,%al
  80166c:	7f 10                	jg     80167e <strtol+0xc2>
			dig = *s - '0';
  80166e:	8b 45 08             	mov    0x8(%ebp),%eax
  801671:	8a 00                	mov    (%eax),%al
  801673:	0f be c0             	movsbl %al,%eax
  801676:	83 e8 30             	sub    $0x30,%eax
  801679:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80167c:	eb 42                	jmp    8016c0 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80167e:	8b 45 08             	mov    0x8(%ebp),%eax
  801681:	8a 00                	mov    (%eax),%al
  801683:	3c 60                	cmp    $0x60,%al
  801685:	7e 19                	jle    8016a0 <strtol+0xe4>
  801687:	8b 45 08             	mov    0x8(%ebp),%eax
  80168a:	8a 00                	mov    (%eax),%al
  80168c:	3c 7a                	cmp    $0x7a,%al
  80168e:	7f 10                	jg     8016a0 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801690:	8b 45 08             	mov    0x8(%ebp),%eax
  801693:	8a 00                	mov    (%eax),%al
  801695:	0f be c0             	movsbl %al,%eax
  801698:	83 e8 57             	sub    $0x57,%eax
  80169b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80169e:	eb 20                	jmp    8016c0 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a3:	8a 00                	mov    (%eax),%al
  8016a5:	3c 40                	cmp    $0x40,%al
  8016a7:	7e 39                	jle    8016e2 <strtol+0x126>
  8016a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ac:	8a 00                	mov    (%eax),%al
  8016ae:	3c 5a                	cmp    $0x5a,%al
  8016b0:	7f 30                	jg     8016e2 <strtol+0x126>
			dig = *s - 'A' + 10;
  8016b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b5:	8a 00                	mov    (%eax),%al
  8016b7:	0f be c0             	movsbl %al,%eax
  8016ba:	83 e8 37             	sub    $0x37,%eax
  8016bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016c3:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016c6:	7d 19                	jge    8016e1 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016c8:	ff 45 08             	incl   0x8(%ebp)
  8016cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ce:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016d2:	89 c2                	mov    %eax,%edx
  8016d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016d7:	01 d0                	add    %edx,%eax
  8016d9:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016dc:	e9 7b ff ff ff       	jmp    80165c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016e1:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016e2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016e6:	74 08                	je     8016f0 <strtol+0x134>
		*endptr = (char *) s;
  8016e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016eb:	8b 55 08             	mov    0x8(%ebp),%edx
  8016ee:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016f0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016f4:	74 07                	je     8016fd <strtol+0x141>
  8016f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016f9:	f7 d8                	neg    %eax
  8016fb:	eb 03                	jmp    801700 <strtol+0x144>
  8016fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801700:	c9                   	leave  
  801701:	c3                   	ret    

00801702 <ltostr>:

void
ltostr(long value, char *str)
{
  801702:	55                   	push   %ebp
  801703:	89 e5                	mov    %esp,%ebp
  801705:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801708:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80170f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801716:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80171a:	79 13                	jns    80172f <ltostr+0x2d>
	{
		neg = 1;
  80171c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801723:	8b 45 0c             	mov    0xc(%ebp),%eax
  801726:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801729:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80172c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80172f:	8b 45 08             	mov    0x8(%ebp),%eax
  801732:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801737:	99                   	cltd   
  801738:	f7 f9                	idiv   %ecx
  80173a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80173d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801740:	8d 50 01             	lea    0x1(%eax),%edx
  801743:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801746:	89 c2                	mov    %eax,%edx
  801748:	8b 45 0c             	mov    0xc(%ebp),%eax
  80174b:	01 d0                	add    %edx,%eax
  80174d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801750:	83 c2 30             	add    $0x30,%edx
  801753:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801755:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801758:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80175d:	f7 e9                	imul   %ecx
  80175f:	c1 fa 02             	sar    $0x2,%edx
  801762:	89 c8                	mov    %ecx,%eax
  801764:	c1 f8 1f             	sar    $0x1f,%eax
  801767:	29 c2                	sub    %eax,%edx
  801769:	89 d0                	mov    %edx,%eax
  80176b:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80176e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801771:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801776:	f7 e9                	imul   %ecx
  801778:	c1 fa 02             	sar    $0x2,%edx
  80177b:	89 c8                	mov    %ecx,%eax
  80177d:	c1 f8 1f             	sar    $0x1f,%eax
  801780:	29 c2                	sub    %eax,%edx
  801782:	89 d0                	mov    %edx,%eax
  801784:	c1 e0 02             	shl    $0x2,%eax
  801787:	01 d0                	add    %edx,%eax
  801789:	01 c0                	add    %eax,%eax
  80178b:	29 c1                	sub    %eax,%ecx
  80178d:	89 ca                	mov    %ecx,%edx
  80178f:	85 d2                	test   %edx,%edx
  801791:	75 9c                	jne    80172f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801793:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80179a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80179d:	48                   	dec    %eax
  80179e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017a1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017a5:	74 3d                	je     8017e4 <ltostr+0xe2>
		start = 1 ;
  8017a7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017ae:	eb 34                	jmp    8017e4 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8017b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b6:	01 d0                	add    %edx,%eax
  8017b8:	8a 00                	mov    (%eax),%al
  8017ba:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017bd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c3:	01 c2                	add    %eax,%edx
  8017c5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017cb:	01 c8                	add    %ecx,%eax
  8017cd:	8a 00                	mov    (%eax),%al
  8017cf:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017d1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d7:	01 c2                	add    %eax,%edx
  8017d9:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017dc:	88 02                	mov    %al,(%edx)
		start++ ;
  8017de:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017e1:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017e7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017ea:	7c c4                	jl     8017b0 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017ec:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017f2:	01 d0                	add    %edx,%eax
  8017f4:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017f7:	90                   	nop
  8017f8:	c9                   	leave  
  8017f9:	c3                   	ret    

008017fa <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017fa:	55                   	push   %ebp
  8017fb:	89 e5                	mov    %esp,%ebp
  8017fd:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801800:	ff 75 08             	pushl  0x8(%ebp)
  801803:	e8 54 fa ff ff       	call   80125c <strlen>
  801808:	83 c4 04             	add    $0x4,%esp
  80180b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80180e:	ff 75 0c             	pushl  0xc(%ebp)
  801811:	e8 46 fa ff ff       	call   80125c <strlen>
  801816:	83 c4 04             	add    $0x4,%esp
  801819:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80181c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801823:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80182a:	eb 17                	jmp    801843 <strcconcat+0x49>
		final[s] = str1[s] ;
  80182c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80182f:	8b 45 10             	mov    0x10(%ebp),%eax
  801832:	01 c2                	add    %eax,%edx
  801834:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801837:	8b 45 08             	mov    0x8(%ebp),%eax
  80183a:	01 c8                	add    %ecx,%eax
  80183c:	8a 00                	mov    (%eax),%al
  80183e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801840:	ff 45 fc             	incl   -0x4(%ebp)
  801843:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801846:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801849:	7c e1                	jl     80182c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80184b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801852:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801859:	eb 1f                	jmp    80187a <strcconcat+0x80>
		final[s++] = str2[i] ;
  80185b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80185e:	8d 50 01             	lea    0x1(%eax),%edx
  801861:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801864:	89 c2                	mov    %eax,%edx
  801866:	8b 45 10             	mov    0x10(%ebp),%eax
  801869:	01 c2                	add    %eax,%edx
  80186b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80186e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801871:	01 c8                	add    %ecx,%eax
  801873:	8a 00                	mov    (%eax),%al
  801875:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801877:	ff 45 f8             	incl   -0x8(%ebp)
  80187a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80187d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801880:	7c d9                	jl     80185b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801882:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801885:	8b 45 10             	mov    0x10(%ebp),%eax
  801888:	01 d0                	add    %edx,%eax
  80188a:	c6 00 00             	movb   $0x0,(%eax)
}
  80188d:	90                   	nop
  80188e:	c9                   	leave  
  80188f:	c3                   	ret    

00801890 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801890:	55                   	push   %ebp
  801891:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801893:	8b 45 14             	mov    0x14(%ebp),%eax
  801896:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80189c:	8b 45 14             	mov    0x14(%ebp),%eax
  80189f:	8b 00                	mov    (%eax),%eax
  8018a1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ab:	01 d0                	add    %edx,%eax
  8018ad:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018b3:	eb 0c                	jmp    8018c1 <strsplit+0x31>
			*string++ = 0;
  8018b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b8:	8d 50 01             	lea    0x1(%eax),%edx
  8018bb:	89 55 08             	mov    %edx,0x8(%ebp)
  8018be:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c4:	8a 00                	mov    (%eax),%al
  8018c6:	84 c0                	test   %al,%al
  8018c8:	74 18                	je     8018e2 <strsplit+0x52>
  8018ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cd:	8a 00                	mov    (%eax),%al
  8018cf:	0f be c0             	movsbl %al,%eax
  8018d2:	50                   	push   %eax
  8018d3:	ff 75 0c             	pushl  0xc(%ebp)
  8018d6:	e8 13 fb ff ff       	call   8013ee <strchr>
  8018db:	83 c4 08             	add    $0x8,%esp
  8018de:	85 c0                	test   %eax,%eax
  8018e0:	75 d3                	jne    8018b5 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8018e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e5:	8a 00                	mov    (%eax),%al
  8018e7:	84 c0                	test   %al,%al
  8018e9:	74 5a                	je     801945 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8018eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8018ee:	8b 00                	mov    (%eax),%eax
  8018f0:	83 f8 0f             	cmp    $0xf,%eax
  8018f3:	75 07                	jne    8018fc <strsplit+0x6c>
		{
			return 0;
  8018f5:	b8 00 00 00 00       	mov    $0x0,%eax
  8018fa:	eb 66                	jmp    801962 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8018ff:	8b 00                	mov    (%eax),%eax
  801901:	8d 48 01             	lea    0x1(%eax),%ecx
  801904:	8b 55 14             	mov    0x14(%ebp),%edx
  801907:	89 0a                	mov    %ecx,(%edx)
  801909:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801910:	8b 45 10             	mov    0x10(%ebp),%eax
  801913:	01 c2                	add    %eax,%edx
  801915:	8b 45 08             	mov    0x8(%ebp),%eax
  801918:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80191a:	eb 03                	jmp    80191f <strsplit+0x8f>
			string++;
  80191c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80191f:	8b 45 08             	mov    0x8(%ebp),%eax
  801922:	8a 00                	mov    (%eax),%al
  801924:	84 c0                	test   %al,%al
  801926:	74 8b                	je     8018b3 <strsplit+0x23>
  801928:	8b 45 08             	mov    0x8(%ebp),%eax
  80192b:	8a 00                	mov    (%eax),%al
  80192d:	0f be c0             	movsbl %al,%eax
  801930:	50                   	push   %eax
  801931:	ff 75 0c             	pushl  0xc(%ebp)
  801934:	e8 b5 fa ff ff       	call   8013ee <strchr>
  801939:	83 c4 08             	add    $0x8,%esp
  80193c:	85 c0                	test   %eax,%eax
  80193e:	74 dc                	je     80191c <strsplit+0x8c>
			string++;
	}
  801940:	e9 6e ff ff ff       	jmp    8018b3 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801945:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801946:	8b 45 14             	mov    0x14(%ebp),%eax
  801949:	8b 00                	mov    (%eax),%eax
  80194b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801952:	8b 45 10             	mov    0x10(%ebp),%eax
  801955:	01 d0                	add    %edx,%eax
  801957:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80195d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801962:	c9                   	leave  
  801963:	c3                   	ret    

00801964 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801964:	55                   	push   %ebp
  801965:	89 e5                	mov    %esp,%ebp
  801967:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  80196a:	83 ec 04             	sub    $0x4,%esp
  80196d:	68 64 2a 80 00       	push   $0x802a64
  801972:	6a 15                	push   $0x15
  801974:	68 89 2a 80 00       	push   $0x802a89
  801979:	e8 9f ed ff ff       	call   80071d <_panic>

0080197e <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  80197e:	55                   	push   %ebp
  80197f:	89 e5                	mov    %esp,%ebp
  801981:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801984:	83 ec 04             	sub    $0x4,%esp
  801987:	68 98 2a 80 00       	push   $0x802a98
  80198c:	6a 2e                	push   $0x2e
  80198e:	68 89 2a 80 00       	push   $0x802a89
  801993:	e8 85 ed ff ff       	call   80071d <_panic>

00801998 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801998:	55                   	push   %ebp
  801999:	89 e5                	mov    %esp,%ebp
  80199b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80199e:	83 ec 04             	sub    $0x4,%esp
  8019a1:	68 bc 2a 80 00       	push   $0x802abc
  8019a6:	6a 4c                	push   $0x4c
  8019a8:	68 89 2a 80 00       	push   $0x802a89
  8019ad:	e8 6b ed ff ff       	call   80071d <_panic>

008019b2 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8019b2:	55                   	push   %ebp
  8019b3:	89 e5                	mov    %esp,%ebp
  8019b5:	83 ec 18             	sub    $0x18,%esp
  8019b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8019bb:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8019be:	83 ec 04             	sub    $0x4,%esp
  8019c1:	68 bc 2a 80 00       	push   $0x802abc
  8019c6:	6a 57                	push   $0x57
  8019c8:	68 89 2a 80 00       	push   $0x802a89
  8019cd:	e8 4b ed ff ff       	call   80071d <_panic>

008019d2 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8019d2:	55                   	push   %ebp
  8019d3:	89 e5                	mov    %esp,%ebp
  8019d5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019d8:	83 ec 04             	sub    $0x4,%esp
  8019db:	68 bc 2a 80 00       	push   $0x802abc
  8019e0:	6a 5d                	push   $0x5d
  8019e2:	68 89 2a 80 00       	push   $0x802a89
  8019e7:	e8 31 ed ff ff       	call   80071d <_panic>

008019ec <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8019ec:	55                   	push   %ebp
  8019ed:	89 e5                	mov    %esp,%ebp
  8019ef:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019f2:	83 ec 04             	sub    $0x4,%esp
  8019f5:	68 bc 2a 80 00       	push   $0x802abc
  8019fa:	6a 63                	push   $0x63
  8019fc:	68 89 2a 80 00       	push   $0x802a89
  801a01:	e8 17 ed ff ff       	call   80071d <_panic>

00801a06 <expand>:
}

void expand(uint32 newSize)
{
  801a06:	55                   	push   %ebp
  801a07:	89 e5                	mov    %esp,%ebp
  801a09:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a0c:	83 ec 04             	sub    $0x4,%esp
  801a0f:	68 bc 2a 80 00       	push   $0x802abc
  801a14:	6a 68                	push   $0x68
  801a16:	68 89 2a 80 00       	push   $0x802a89
  801a1b:	e8 fd ec ff ff       	call   80071d <_panic>

00801a20 <shrink>:
}
void shrink(uint32 newSize)
{
  801a20:	55                   	push   %ebp
  801a21:	89 e5                	mov    %esp,%ebp
  801a23:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a26:	83 ec 04             	sub    $0x4,%esp
  801a29:	68 bc 2a 80 00       	push   $0x802abc
  801a2e:	6a 6c                	push   $0x6c
  801a30:	68 89 2a 80 00       	push   $0x802a89
  801a35:	e8 e3 ec ff ff       	call   80071d <_panic>

00801a3a <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801a3a:	55                   	push   %ebp
  801a3b:	89 e5                	mov    %esp,%ebp
  801a3d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a40:	83 ec 04             	sub    $0x4,%esp
  801a43:	68 bc 2a 80 00       	push   $0x802abc
  801a48:	6a 71                	push   $0x71
  801a4a:	68 89 2a 80 00       	push   $0x802a89
  801a4f:	e8 c9 ec ff ff       	call   80071d <_panic>

00801a54 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801a54:	55                   	push   %ebp
  801a55:	89 e5                	mov    %esp,%ebp
  801a57:	57                   	push   %edi
  801a58:	56                   	push   %esi
  801a59:	53                   	push   %ebx
  801a5a:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801a5d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a60:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a63:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a66:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a69:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a6c:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a6f:	cd 30                	int    $0x30
  801a71:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a74:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a77:	83 c4 10             	add    $0x10,%esp
  801a7a:	5b                   	pop    %ebx
  801a7b:	5e                   	pop    %esi
  801a7c:	5f                   	pop    %edi
  801a7d:	5d                   	pop    %ebp
  801a7e:	c3                   	ret    

00801a7f <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801a7f:	55                   	push   %ebp
  801a80:	89 e5                	mov    %esp,%ebp
  801a82:	83 ec 04             	sub    $0x4,%esp
  801a85:	8b 45 10             	mov    0x10(%ebp),%eax
  801a88:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801a8b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a92:	6a 00                	push   $0x0
  801a94:	6a 00                	push   $0x0
  801a96:	52                   	push   %edx
  801a97:	ff 75 0c             	pushl  0xc(%ebp)
  801a9a:	50                   	push   %eax
  801a9b:	6a 00                	push   $0x0
  801a9d:	e8 b2 ff ff ff       	call   801a54 <syscall>
  801aa2:	83 c4 18             	add    $0x18,%esp
}
  801aa5:	90                   	nop
  801aa6:	c9                   	leave  
  801aa7:	c3                   	ret    

00801aa8 <sys_cgetc>:

int
sys_cgetc(void)
{
  801aa8:	55                   	push   %ebp
  801aa9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801aab:	6a 00                	push   $0x0
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 01                	push   $0x1
  801ab7:	e8 98 ff ff ff       	call   801a54 <syscall>
  801abc:	83 c4 18             	add    $0x18,%esp
}
  801abf:	c9                   	leave  
  801ac0:	c3                   	ret    

00801ac1 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801ac1:	55                   	push   %ebp
  801ac2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801ac4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac7:	6a 00                	push   $0x0
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	50                   	push   %eax
  801ad0:	6a 05                	push   $0x5
  801ad2:	e8 7d ff ff ff       	call   801a54 <syscall>
  801ad7:	83 c4 18             	add    $0x18,%esp
}
  801ada:	c9                   	leave  
  801adb:	c3                   	ret    

00801adc <sys_getenvid>:

int32 sys_getenvid(void)
{
  801adc:	55                   	push   %ebp
  801add:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801adf:	6a 00                	push   $0x0
  801ae1:	6a 00                	push   $0x0
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 02                	push   $0x2
  801aeb:	e8 64 ff ff ff       	call   801a54 <syscall>
  801af0:	83 c4 18             	add    $0x18,%esp
}
  801af3:	c9                   	leave  
  801af4:	c3                   	ret    

00801af5 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801af5:	55                   	push   %ebp
  801af6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801af8:	6a 00                	push   $0x0
  801afa:	6a 00                	push   $0x0
  801afc:	6a 00                	push   $0x0
  801afe:	6a 00                	push   $0x0
  801b00:	6a 00                	push   $0x0
  801b02:	6a 03                	push   $0x3
  801b04:	e8 4b ff ff ff       	call   801a54 <syscall>
  801b09:	83 c4 18             	add    $0x18,%esp
}
  801b0c:	c9                   	leave  
  801b0d:	c3                   	ret    

00801b0e <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b0e:	55                   	push   %ebp
  801b0f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b11:	6a 00                	push   $0x0
  801b13:	6a 00                	push   $0x0
  801b15:	6a 00                	push   $0x0
  801b17:	6a 00                	push   $0x0
  801b19:	6a 00                	push   $0x0
  801b1b:	6a 04                	push   $0x4
  801b1d:	e8 32 ff ff ff       	call   801a54 <syscall>
  801b22:	83 c4 18             	add    $0x18,%esp
}
  801b25:	c9                   	leave  
  801b26:	c3                   	ret    

00801b27 <sys_env_exit>:


void sys_env_exit(void)
{
  801b27:	55                   	push   %ebp
  801b28:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801b2a:	6a 00                	push   $0x0
  801b2c:	6a 00                	push   $0x0
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	6a 06                	push   $0x6
  801b36:	e8 19 ff ff ff       	call   801a54 <syscall>
  801b3b:	83 c4 18             	add    $0x18,%esp
}
  801b3e:	90                   	nop
  801b3f:	c9                   	leave  
  801b40:	c3                   	ret    

00801b41 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801b41:	55                   	push   %ebp
  801b42:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801b44:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b47:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	52                   	push   %edx
  801b51:	50                   	push   %eax
  801b52:	6a 07                	push   $0x7
  801b54:	e8 fb fe ff ff       	call   801a54 <syscall>
  801b59:	83 c4 18             	add    $0x18,%esp
}
  801b5c:	c9                   	leave  
  801b5d:	c3                   	ret    

00801b5e <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801b5e:	55                   	push   %ebp
  801b5f:	89 e5                	mov    %esp,%ebp
  801b61:	56                   	push   %esi
  801b62:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801b63:	8b 75 18             	mov    0x18(%ebp),%esi
  801b66:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b69:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b6c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b72:	56                   	push   %esi
  801b73:	53                   	push   %ebx
  801b74:	51                   	push   %ecx
  801b75:	52                   	push   %edx
  801b76:	50                   	push   %eax
  801b77:	6a 08                	push   $0x8
  801b79:	e8 d6 fe ff ff       	call   801a54 <syscall>
  801b7e:	83 c4 18             	add    $0x18,%esp
}
  801b81:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b84:	5b                   	pop    %ebx
  801b85:	5e                   	pop    %esi
  801b86:	5d                   	pop    %ebp
  801b87:	c3                   	ret    

00801b88 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801b88:	55                   	push   %ebp
  801b89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801b8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	52                   	push   %edx
  801b98:	50                   	push   %eax
  801b99:	6a 09                	push   $0x9
  801b9b:	e8 b4 fe ff ff       	call   801a54 <syscall>
  801ba0:	83 c4 18             	add    $0x18,%esp
}
  801ba3:	c9                   	leave  
  801ba4:	c3                   	ret    

00801ba5 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801ba5:	55                   	push   %ebp
  801ba6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 00                	push   $0x0
  801bac:	6a 00                	push   $0x0
  801bae:	ff 75 0c             	pushl  0xc(%ebp)
  801bb1:	ff 75 08             	pushl  0x8(%ebp)
  801bb4:	6a 0a                	push   $0xa
  801bb6:	e8 99 fe ff ff       	call   801a54 <syscall>
  801bbb:	83 c4 18             	add    $0x18,%esp
}
  801bbe:	c9                   	leave  
  801bbf:	c3                   	ret    

00801bc0 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801bc0:	55                   	push   %ebp
  801bc1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 00                	push   $0x0
  801bc9:	6a 00                	push   $0x0
  801bcb:	6a 00                	push   $0x0
  801bcd:	6a 0b                	push   $0xb
  801bcf:	e8 80 fe ff ff       	call   801a54 <syscall>
  801bd4:	83 c4 18             	add    $0x18,%esp
}
  801bd7:	c9                   	leave  
  801bd8:	c3                   	ret    

00801bd9 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801bd9:	55                   	push   %ebp
  801bda:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	6a 0c                	push   $0xc
  801be8:	e8 67 fe ff ff       	call   801a54 <syscall>
  801bed:	83 c4 18             	add    $0x18,%esp
}
  801bf0:	c9                   	leave  
  801bf1:	c3                   	ret    

00801bf2 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801bf2:	55                   	push   %ebp
  801bf3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 0d                	push   $0xd
  801c01:	e8 4e fe ff ff       	call   801a54 <syscall>
  801c06:	83 c4 18             	add    $0x18,%esp
}
  801c09:	c9                   	leave  
  801c0a:	c3                   	ret    

00801c0b <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801c0b:	55                   	push   %ebp
  801c0c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c0e:	6a 00                	push   $0x0
  801c10:	6a 00                	push   $0x0
  801c12:	6a 00                	push   $0x0
  801c14:	ff 75 0c             	pushl  0xc(%ebp)
  801c17:	ff 75 08             	pushl  0x8(%ebp)
  801c1a:	6a 11                	push   $0x11
  801c1c:	e8 33 fe ff ff       	call   801a54 <syscall>
  801c21:	83 c4 18             	add    $0x18,%esp
	return;
  801c24:	90                   	nop
}
  801c25:	c9                   	leave  
  801c26:	c3                   	ret    

00801c27 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c27:	55                   	push   %ebp
  801c28:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801c2a:	6a 00                	push   $0x0
  801c2c:	6a 00                	push   $0x0
  801c2e:	6a 00                	push   $0x0
  801c30:	ff 75 0c             	pushl  0xc(%ebp)
  801c33:	ff 75 08             	pushl  0x8(%ebp)
  801c36:	6a 12                	push   $0x12
  801c38:	e8 17 fe ff ff       	call   801a54 <syscall>
  801c3d:	83 c4 18             	add    $0x18,%esp
	return ;
  801c40:	90                   	nop
}
  801c41:	c9                   	leave  
  801c42:	c3                   	ret    

00801c43 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801c43:	55                   	push   %ebp
  801c44:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 0e                	push   $0xe
  801c52:	e8 fd fd ff ff       	call   801a54 <syscall>
  801c57:	83 c4 18             	add    $0x18,%esp
}
  801c5a:	c9                   	leave  
  801c5b:	c3                   	ret    

00801c5c <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801c5c:	55                   	push   %ebp
  801c5d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801c5f:	6a 00                	push   $0x0
  801c61:	6a 00                	push   $0x0
  801c63:	6a 00                	push   $0x0
  801c65:	6a 00                	push   $0x0
  801c67:	ff 75 08             	pushl  0x8(%ebp)
  801c6a:	6a 0f                	push   $0xf
  801c6c:	e8 e3 fd ff ff       	call   801a54 <syscall>
  801c71:	83 c4 18             	add    $0x18,%esp
}
  801c74:	c9                   	leave  
  801c75:	c3                   	ret    

00801c76 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801c76:	55                   	push   %ebp
  801c77:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801c79:	6a 00                	push   $0x0
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 00                	push   $0x0
  801c7f:	6a 00                	push   $0x0
  801c81:	6a 00                	push   $0x0
  801c83:	6a 10                	push   $0x10
  801c85:	e8 ca fd ff ff       	call   801a54 <syscall>
  801c8a:	83 c4 18             	add    $0x18,%esp
}
  801c8d:	90                   	nop
  801c8e:	c9                   	leave  
  801c8f:	c3                   	ret    

00801c90 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801c90:	55                   	push   %ebp
  801c91:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801c93:	6a 00                	push   $0x0
  801c95:	6a 00                	push   $0x0
  801c97:	6a 00                	push   $0x0
  801c99:	6a 00                	push   $0x0
  801c9b:	6a 00                	push   $0x0
  801c9d:	6a 14                	push   $0x14
  801c9f:	e8 b0 fd ff ff       	call   801a54 <syscall>
  801ca4:	83 c4 18             	add    $0x18,%esp
}
  801ca7:	90                   	nop
  801ca8:	c9                   	leave  
  801ca9:	c3                   	ret    

00801caa <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801caa:	55                   	push   %ebp
  801cab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	6a 00                	push   $0x0
  801cb7:	6a 15                	push   $0x15
  801cb9:	e8 96 fd ff ff       	call   801a54 <syscall>
  801cbe:	83 c4 18             	add    $0x18,%esp
}
  801cc1:	90                   	nop
  801cc2:	c9                   	leave  
  801cc3:	c3                   	ret    

00801cc4 <sys_cputc>:


void
sys_cputc(const char c)
{
  801cc4:	55                   	push   %ebp
  801cc5:	89 e5                	mov    %esp,%ebp
  801cc7:	83 ec 04             	sub    $0x4,%esp
  801cca:	8b 45 08             	mov    0x8(%ebp),%eax
  801ccd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801cd0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801cd4:	6a 00                	push   $0x0
  801cd6:	6a 00                	push   $0x0
  801cd8:	6a 00                	push   $0x0
  801cda:	6a 00                	push   $0x0
  801cdc:	50                   	push   %eax
  801cdd:	6a 16                	push   $0x16
  801cdf:	e8 70 fd ff ff       	call   801a54 <syscall>
  801ce4:	83 c4 18             	add    $0x18,%esp
}
  801ce7:	90                   	nop
  801ce8:	c9                   	leave  
  801ce9:	c3                   	ret    

00801cea <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801cea:	55                   	push   %ebp
  801ceb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ced:	6a 00                	push   $0x0
  801cef:	6a 00                	push   $0x0
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 00                	push   $0x0
  801cf7:	6a 17                	push   $0x17
  801cf9:	e8 56 fd ff ff       	call   801a54 <syscall>
  801cfe:	83 c4 18             	add    $0x18,%esp
}
  801d01:	90                   	nop
  801d02:	c9                   	leave  
  801d03:	c3                   	ret    

00801d04 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801d04:	55                   	push   %ebp
  801d05:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801d07:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0a:	6a 00                	push   $0x0
  801d0c:	6a 00                	push   $0x0
  801d0e:	6a 00                	push   $0x0
  801d10:	ff 75 0c             	pushl  0xc(%ebp)
  801d13:	50                   	push   %eax
  801d14:	6a 18                	push   $0x18
  801d16:	e8 39 fd ff ff       	call   801a54 <syscall>
  801d1b:	83 c4 18             	add    $0x18,%esp
}
  801d1e:	c9                   	leave  
  801d1f:	c3                   	ret    

00801d20 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d20:	55                   	push   %ebp
  801d21:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d23:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d26:	8b 45 08             	mov    0x8(%ebp),%eax
  801d29:	6a 00                	push   $0x0
  801d2b:	6a 00                	push   $0x0
  801d2d:	6a 00                	push   $0x0
  801d2f:	52                   	push   %edx
  801d30:	50                   	push   %eax
  801d31:	6a 1b                	push   $0x1b
  801d33:	e8 1c fd ff ff       	call   801a54 <syscall>
  801d38:	83 c4 18             	add    $0x18,%esp
}
  801d3b:	c9                   	leave  
  801d3c:	c3                   	ret    

00801d3d <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d3d:	55                   	push   %ebp
  801d3e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d40:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d43:	8b 45 08             	mov    0x8(%ebp),%eax
  801d46:	6a 00                	push   $0x0
  801d48:	6a 00                	push   $0x0
  801d4a:	6a 00                	push   $0x0
  801d4c:	52                   	push   %edx
  801d4d:	50                   	push   %eax
  801d4e:	6a 19                	push   $0x19
  801d50:	e8 ff fc ff ff       	call   801a54 <syscall>
  801d55:	83 c4 18             	add    $0x18,%esp
}
  801d58:	90                   	nop
  801d59:	c9                   	leave  
  801d5a:	c3                   	ret    

00801d5b <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d5b:	55                   	push   %ebp
  801d5c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d61:	8b 45 08             	mov    0x8(%ebp),%eax
  801d64:	6a 00                	push   $0x0
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	52                   	push   %edx
  801d6b:	50                   	push   %eax
  801d6c:	6a 1a                	push   $0x1a
  801d6e:	e8 e1 fc ff ff       	call   801a54 <syscall>
  801d73:	83 c4 18             	add    $0x18,%esp
}
  801d76:	90                   	nop
  801d77:	c9                   	leave  
  801d78:	c3                   	ret    

00801d79 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801d79:	55                   	push   %ebp
  801d7a:	89 e5                	mov    %esp,%ebp
  801d7c:	83 ec 04             	sub    $0x4,%esp
  801d7f:	8b 45 10             	mov    0x10(%ebp),%eax
  801d82:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801d85:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d88:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d8f:	6a 00                	push   $0x0
  801d91:	51                   	push   %ecx
  801d92:	52                   	push   %edx
  801d93:	ff 75 0c             	pushl  0xc(%ebp)
  801d96:	50                   	push   %eax
  801d97:	6a 1c                	push   $0x1c
  801d99:	e8 b6 fc ff ff       	call   801a54 <syscall>
  801d9e:	83 c4 18             	add    $0x18,%esp
}
  801da1:	c9                   	leave  
  801da2:	c3                   	ret    

00801da3 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801da3:	55                   	push   %ebp
  801da4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801da6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801da9:	8b 45 08             	mov    0x8(%ebp),%eax
  801dac:	6a 00                	push   $0x0
  801dae:	6a 00                	push   $0x0
  801db0:	6a 00                	push   $0x0
  801db2:	52                   	push   %edx
  801db3:	50                   	push   %eax
  801db4:	6a 1d                	push   $0x1d
  801db6:	e8 99 fc ff ff       	call   801a54 <syscall>
  801dbb:	83 c4 18             	add    $0x18,%esp
}
  801dbe:	c9                   	leave  
  801dbf:	c3                   	ret    

00801dc0 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801dc0:	55                   	push   %ebp
  801dc1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801dc3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801dc6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dc9:	8b 45 08             	mov    0x8(%ebp),%eax
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	51                   	push   %ecx
  801dd1:	52                   	push   %edx
  801dd2:	50                   	push   %eax
  801dd3:	6a 1e                	push   $0x1e
  801dd5:	e8 7a fc ff ff       	call   801a54 <syscall>
  801dda:	83 c4 18             	add    $0x18,%esp
}
  801ddd:	c9                   	leave  
  801dde:	c3                   	ret    

00801ddf <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ddf:	55                   	push   %ebp
  801de0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801de2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801de5:	8b 45 08             	mov    0x8(%ebp),%eax
  801de8:	6a 00                	push   $0x0
  801dea:	6a 00                	push   $0x0
  801dec:	6a 00                	push   $0x0
  801dee:	52                   	push   %edx
  801def:	50                   	push   %eax
  801df0:	6a 1f                	push   $0x1f
  801df2:	e8 5d fc ff ff       	call   801a54 <syscall>
  801df7:	83 c4 18             	add    $0x18,%esp
}
  801dfa:	c9                   	leave  
  801dfb:	c3                   	ret    

00801dfc <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801dfc:	55                   	push   %ebp
  801dfd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801dff:	6a 00                	push   $0x0
  801e01:	6a 00                	push   $0x0
  801e03:	6a 00                	push   $0x0
  801e05:	6a 00                	push   $0x0
  801e07:	6a 00                	push   $0x0
  801e09:	6a 20                	push   $0x20
  801e0b:	e8 44 fc ff ff       	call   801a54 <syscall>
  801e10:	83 c4 18             	add    $0x18,%esp
}
  801e13:	c9                   	leave  
  801e14:	c3                   	ret    

00801e15 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801e15:	55                   	push   %ebp
  801e16:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801e18:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1b:	6a 00                	push   $0x0
  801e1d:	ff 75 14             	pushl  0x14(%ebp)
  801e20:	ff 75 10             	pushl  0x10(%ebp)
  801e23:	ff 75 0c             	pushl  0xc(%ebp)
  801e26:	50                   	push   %eax
  801e27:	6a 21                	push   $0x21
  801e29:	e8 26 fc ff ff       	call   801a54 <syscall>
  801e2e:	83 c4 18             	add    $0x18,%esp
}
  801e31:	c9                   	leave  
  801e32:	c3                   	ret    

00801e33 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801e33:	55                   	push   %ebp
  801e34:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801e36:	8b 45 08             	mov    0x8(%ebp),%eax
  801e39:	6a 00                	push   $0x0
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 00                	push   $0x0
  801e41:	50                   	push   %eax
  801e42:	6a 22                	push   $0x22
  801e44:	e8 0b fc ff ff       	call   801a54 <syscall>
  801e49:	83 c4 18             	add    $0x18,%esp
}
  801e4c:	90                   	nop
  801e4d:	c9                   	leave  
  801e4e:	c3                   	ret    

00801e4f <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801e4f:	55                   	push   %ebp
  801e50:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801e52:	8b 45 08             	mov    0x8(%ebp),%eax
  801e55:	6a 00                	push   $0x0
  801e57:	6a 00                	push   $0x0
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 00                	push   $0x0
  801e5d:	50                   	push   %eax
  801e5e:	6a 23                	push   $0x23
  801e60:	e8 ef fb ff ff       	call   801a54 <syscall>
  801e65:	83 c4 18             	add    $0x18,%esp
}
  801e68:	90                   	nop
  801e69:	c9                   	leave  
  801e6a:	c3                   	ret    

00801e6b <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801e6b:	55                   	push   %ebp
  801e6c:	89 e5                	mov    %esp,%ebp
  801e6e:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801e71:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e74:	8d 50 04             	lea    0x4(%eax),%edx
  801e77:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 00                	push   $0x0
  801e7e:	6a 00                	push   $0x0
  801e80:	52                   	push   %edx
  801e81:	50                   	push   %eax
  801e82:	6a 24                	push   $0x24
  801e84:	e8 cb fb ff ff       	call   801a54 <syscall>
  801e89:	83 c4 18             	add    $0x18,%esp
	return result;
  801e8c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801e8f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e92:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e95:	89 01                	mov    %eax,(%ecx)
  801e97:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9d:	c9                   	leave  
  801e9e:	c2 04 00             	ret    $0x4

00801ea1 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801ea1:	55                   	push   %ebp
  801ea2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801ea4:	6a 00                	push   $0x0
  801ea6:	6a 00                	push   $0x0
  801ea8:	ff 75 10             	pushl  0x10(%ebp)
  801eab:	ff 75 0c             	pushl  0xc(%ebp)
  801eae:	ff 75 08             	pushl  0x8(%ebp)
  801eb1:	6a 13                	push   $0x13
  801eb3:	e8 9c fb ff ff       	call   801a54 <syscall>
  801eb8:	83 c4 18             	add    $0x18,%esp
	return ;
  801ebb:	90                   	nop
}
  801ebc:	c9                   	leave  
  801ebd:	c3                   	ret    

00801ebe <sys_rcr2>:
uint32 sys_rcr2()
{
  801ebe:	55                   	push   %ebp
  801ebf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801ec1:	6a 00                	push   $0x0
  801ec3:	6a 00                	push   $0x0
  801ec5:	6a 00                	push   $0x0
  801ec7:	6a 00                	push   $0x0
  801ec9:	6a 00                	push   $0x0
  801ecb:	6a 25                	push   $0x25
  801ecd:	e8 82 fb ff ff       	call   801a54 <syscall>
  801ed2:	83 c4 18             	add    $0x18,%esp
}
  801ed5:	c9                   	leave  
  801ed6:	c3                   	ret    

00801ed7 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801ed7:	55                   	push   %ebp
  801ed8:	89 e5                	mov    %esp,%ebp
  801eda:	83 ec 04             	sub    $0x4,%esp
  801edd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801ee3:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801ee7:	6a 00                	push   $0x0
  801ee9:	6a 00                	push   $0x0
  801eeb:	6a 00                	push   $0x0
  801eed:	6a 00                	push   $0x0
  801eef:	50                   	push   %eax
  801ef0:	6a 26                	push   $0x26
  801ef2:	e8 5d fb ff ff       	call   801a54 <syscall>
  801ef7:	83 c4 18             	add    $0x18,%esp
	return ;
  801efa:	90                   	nop
}
  801efb:	c9                   	leave  
  801efc:	c3                   	ret    

00801efd <rsttst>:
void rsttst()
{
  801efd:	55                   	push   %ebp
  801efe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	6a 00                	push   $0x0
  801f0a:	6a 28                	push   $0x28
  801f0c:	e8 43 fb ff ff       	call   801a54 <syscall>
  801f11:	83 c4 18             	add    $0x18,%esp
	return ;
  801f14:	90                   	nop
}
  801f15:	c9                   	leave  
  801f16:	c3                   	ret    

00801f17 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f17:	55                   	push   %ebp
  801f18:	89 e5                	mov    %esp,%ebp
  801f1a:	83 ec 04             	sub    $0x4,%esp
  801f1d:	8b 45 14             	mov    0x14(%ebp),%eax
  801f20:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f23:	8b 55 18             	mov    0x18(%ebp),%edx
  801f26:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f2a:	52                   	push   %edx
  801f2b:	50                   	push   %eax
  801f2c:	ff 75 10             	pushl  0x10(%ebp)
  801f2f:	ff 75 0c             	pushl  0xc(%ebp)
  801f32:	ff 75 08             	pushl  0x8(%ebp)
  801f35:	6a 27                	push   $0x27
  801f37:	e8 18 fb ff ff       	call   801a54 <syscall>
  801f3c:	83 c4 18             	add    $0x18,%esp
	return ;
  801f3f:	90                   	nop
}
  801f40:	c9                   	leave  
  801f41:	c3                   	ret    

00801f42 <chktst>:
void chktst(uint32 n)
{
  801f42:	55                   	push   %ebp
  801f43:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801f45:	6a 00                	push   $0x0
  801f47:	6a 00                	push   $0x0
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	ff 75 08             	pushl  0x8(%ebp)
  801f50:	6a 29                	push   $0x29
  801f52:	e8 fd fa ff ff       	call   801a54 <syscall>
  801f57:	83 c4 18             	add    $0x18,%esp
	return ;
  801f5a:	90                   	nop
}
  801f5b:	c9                   	leave  
  801f5c:	c3                   	ret    

00801f5d <inctst>:

void inctst()
{
  801f5d:	55                   	push   %ebp
  801f5e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801f60:	6a 00                	push   $0x0
  801f62:	6a 00                	push   $0x0
  801f64:	6a 00                	push   $0x0
  801f66:	6a 00                	push   $0x0
  801f68:	6a 00                	push   $0x0
  801f6a:	6a 2a                	push   $0x2a
  801f6c:	e8 e3 fa ff ff       	call   801a54 <syscall>
  801f71:	83 c4 18             	add    $0x18,%esp
	return ;
  801f74:	90                   	nop
}
  801f75:	c9                   	leave  
  801f76:	c3                   	ret    

00801f77 <gettst>:
uint32 gettst()
{
  801f77:	55                   	push   %ebp
  801f78:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f7a:	6a 00                	push   $0x0
  801f7c:	6a 00                	push   $0x0
  801f7e:	6a 00                	push   $0x0
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	6a 2b                	push   $0x2b
  801f86:	e8 c9 fa ff ff       	call   801a54 <syscall>
  801f8b:	83 c4 18             	add    $0x18,%esp
}
  801f8e:	c9                   	leave  
  801f8f:	c3                   	ret    

00801f90 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801f90:	55                   	push   %ebp
  801f91:	89 e5                	mov    %esp,%ebp
  801f93:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f96:	6a 00                	push   $0x0
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 00                	push   $0x0
  801f9c:	6a 00                	push   $0x0
  801f9e:	6a 00                	push   $0x0
  801fa0:	6a 2c                	push   $0x2c
  801fa2:	e8 ad fa ff ff       	call   801a54 <syscall>
  801fa7:	83 c4 18             	add    $0x18,%esp
  801faa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801fad:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801fb1:	75 07                	jne    801fba <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801fb3:	b8 01 00 00 00       	mov    $0x1,%eax
  801fb8:	eb 05                	jmp    801fbf <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801fba:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fbf:	c9                   	leave  
  801fc0:	c3                   	ret    

00801fc1 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801fc1:	55                   	push   %ebp
  801fc2:	89 e5                	mov    %esp,%ebp
  801fc4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fc7:	6a 00                	push   $0x0
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 00                	push   $0x0
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 2c                	push   $0x2c
  801fd3:	e8 7c fa ff ff       	call   801a54 <syscall>
  801fd8:	83 c4 18             	add    $0x18,%esp
  801fdb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801fde:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801fe2:	75 07                	jne    801feb <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801fe4:	b8 01 00 00 00       	mov    $0x1,%eax
  801fe9:	eb 05                	jmp    801ff0 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801feb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ff0:	c9                   	leave  
  801ff1:	c3                   	ret    

00801ff2 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ff2:	55                   	push   %ebp
  801ff3:	89 e5                	mov    %esp,%ebp
  801ff5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ff8:	6a 00                	push   $0x0
  801ffa:	6a 00                	push   $0x0
  801ffc:	6a 00                	push   $0x0
  801ffe:	6a 00                	push   $0x0
  802000:	6a 00                	push   $0x0
  802002:	6a 2c                	push   $0x2c
  802004:	e8 4b fa ff ff       	call   801a54 <syscall>
  802009:	83 c4 18             	add    $0x18,%esp
  80200c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80200f:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802013:	75 07                	jne    80201c <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802015:	b8 01 00 00 00       	mov    $0x1,%eax
  80201a:	eb 05                	jmp    802021 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80201c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802021:	c9                   	leave  
  802022:	c3                   	ret    

00802023 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802023:	55                   	push   %ebp
  802024:	89 e5                	mov    %esp,%ebp
  802026:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802029:	6a 00                	push   $0x0
  80202b:	6a 00                	push   $0x0
  80202d:	6a 00                	push   $0x0
  80202f:	6a 00                	push   $0x0
  802031:	6a 00                	push   $0x0
  802033:	6a 2c                	push   $0x2c
  802035:	e8 1a fa ff ff       	call   801a54 <syscall>
  80203a:	83 c4 18             	add    $0x18,%esp
  80203d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802040:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802044:	75 07                	jne    80204d <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802046:	b8 01 00 00 00       	mov    $0x1,%eax
  80204b:	eb 05                	jmp    802052 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80204d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802052:	c9                   	leave  
  802053:	c3                   	ret    

00802054 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802054:	55                   	push   %ebp
  802055:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802057:	6a 00                	push   $0x0
  802059:	6a 00                	push   $0x0
  80205b:	6a 00                	push   $0x0
  80205d:	6a 00                	push   $0x0
  80205f:	ff 75 08             	pushl  0x8(%ebp)
  802062:	6a 2d                	push   $0x2d
  802064:	e8 eb f9 ff ff       	call   801a54 <syscall>
  802069:	83 c4 18             	add    $0x18,%esp
	return ;
  80206c:	90                   	nop
}
  80206d:	c9                   	leave  
  80206e:	c3                   	ret    

0080206f <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80206f:	55                   	push   %ebp
  802070:	89 e5                	mov    %esp,%ebp
  802072:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802073:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802076:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802079:	8b 55 0c             	mov    0xc(%ebp),%edx
  80207c:	8b 45 08             	mov    0x8(%ebp),%eax
  80207f:	6a 00                	push   $0x0
  802081:	53                   	push   %ebx
  802082:	51                   	push   %ecx
  802083:	52                   	push   %edx
  802084:	50                   	push   %eax
  802085:	6a 2e                	push   $0x2e
  802087:	e8 c8 f9 ff ff       	call   801a54 <syscall>
  80208c:	83 c4 18             	add    $0x18,%esp
}
  80208f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802092:	c9                   	leave  
  802093:	c3                   	ret    

00802094 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802094:	55                   	push   %ebp
  802095:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802097:	8b 55 0c             	mov    0xc(%ebp),%edx
  80209a:	8b 45 08             	mov    0x8(%ebp),%eax
  80209d:	6a 00                	push   $0x0
  80209f:	6a 00                	push   $0x0
  8020a1:	6a 00                	push   $0x0
  8020a3:	52                   	push   %edx
  8020a4:	50                   	push   %eax
  8020a5:	6a 2f                	push   $0x2f
  8020a7:	e8 a8 f9 ff ff       	call   801a54 <syscall>
  8020ac:	83 c4 18             	add    $0x18,%esp
}
  8020af:	c9                   	leave  
  8020b0:	c3                   	ret    

008020b1 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8020b1:	55                   	push   %ebp
  8020b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8020b4:	6a 00                	push   $0x0
  8020b6:	6a 00                	push   $0x0
  8020b8:	6a 00                	push   $0x0
  8020ba:	ff 75 0c             	pushl  0xc(%ebp)
  8020bd:	ff 75 08             	pushl  0x8(%ebp)
  8020c0:	6a 30                	push   $0x30
  8020c2:	e8 8d f9 ff ff       	call   801a54 <syscall>
  8020c7:	83 c4 18             	add    $0x18,%esp
	return ;
  8020ca:	90                   	nop
}
  8020cb:	c9                   	leave  
  8020cc:	c3                   	ret    
  8020cd:	66 90                	xchg   %ax,%ax
  8020cf:	90                   	nop

008020d0 <__udivdi3>:
  8020d0:	55                   	push   %ebp
  8020d1:	57                   	push   %edi
  8020d2:	56                   	push   %esi
  8020d3:	53                   	push   %ebx
  8020d4:	83 ec 1c             	sub    $0x1c,%esp
  8020d7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8020db:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8020df:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020e3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8020e7:	89 ca                	mov    %ecx,%edx
  8020e9:	89 f8                	mov    %edi,%eax
  8020eb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8020ef:	85 f6                	test   %esi,%esi
  8020f1:	75 2d                	jne    802120 <__udivdi3+0x50>
  8020f3:	39 cf                	cmp    %ecx,%edi
  8020f5:	77 65                	ja     80215c <__udivdi3+0x8c>
  8020f7:	89 fd                	mov    %edi,%ebp
  8020f9:	85 ff                	test   %edi,%edi
  8020fb:	75 0b                	jne    802108 <__udivdi3+0x38>
  8020fd:	b8 01 00 00 00       	mov    $0x1,%eax
  802102:	31 d2                	xor    %edx,%edx
  802104:	f7 f7                	div    %edi
  802106:	89 c5                	mov    %eax,%ebp
  802108:	31 d2                	xor    %edx,%edx
  80210a:	89 c8                	mov    %ecx,%eax
  80210c:	f7 f5                	div    %ebp
  80210e:	89 c1                	mov    %eax,%ecx
  802110:	89 d8                	mov    %ebx,%eax
  802112:	f7 f5                	div    %ebp
  802114:	89 cf                	mov    %ecx,%edi
  802116:	89 fa                	mov    %edi,%edx
  802118:	83 c4 1c             	add    $0x1c,%esp
  80211b:	5b                   	pop    %ebx
  80211c:	5e                   	pop    %esi
  80211d:	5f                   	pop    %edi
  80211e:	5d                   	pop    %ebp
  80211f:	c3                   	ret    
  802120:	39 ce                	cmp    %ecx,%esi
  802122:	77 28                	ja     80214c <__udivdi3+0x7c>
  802124:	0f bd fe             	bsr    %esi,%edi
  802127:	83 f7 1f             	xor    $0x1f,%edi
  80212a:	75 40                	jne    80216c <__udivdi3+0x9c>
  80212c:	39 ce                	cmp    %ecx,%esi
  80212e:	72 0a                	jb     80213a <__udivdi3+0x6a>
  802130:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802134:	0f 87 9e 00 00 00    	ja     8021d8 <__udivdi3+0x108>
  80213a:	b8 01 00 00 00       	mov    $0x1,%eax
  80213f:	89 fa                	mov    %edi,%edx
  802141:	83 c4 1c             	add    $0x1c,%esp
  802144:	5b                   	pop    %ebx
  802145:	5e                   	pop    %esi
  802146:	5f                   	pop    %edi
  802147:	5d                   	pop    %ebp
  802148:	c3                   	ret    
  802149:	8d 76 00             	lea    0x0(%esi),%esi
  80214c:	31 ff                	xor    %edi,%edi
  80214e:	31 c0                	xor    %eax,%eax
  802150:	89 fa                	mov    %edi,%edx
  802152:	83 c4 1c             	add    $0x1c,%esp
  802155:	5b                   	pop    %ebx
  802156:	5e                   	pop    %esi
  802157:	5f                   	pop    %edi
  802158:	5d                   	pop    %ebp
  802159:	c3                   	ret    
  80215a:	66 90                	xchg   %ax,%ax
  80215c:	89 d8                	mov    %ebx,%eax
  80215e:	f7 f7                	div    %edi
  802160:	31 ff                	xor    %edi,%edi
  802162:	89 fa                	mov    %edi,%edx
  802164:	83 c4 1c             	add    $0x1c,%esp
  802167:	5b                   	pop    %ebx
  802168:	5e                   	pop    %esi
  802169:	5f                   	pop    %edi
  80216a:	5d                   	pop    %ebp
  80216b:	c3                   	ret    
  80216c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802171:	89 eb                	mov    %ebp,%ebx
  802173:	29 fb                	sub    %edi,%ebx
  802175:	89 f9                	mov    %edi,%ecx
  802177:	d3 e6                	shl    %cl,%esi
  802179:	89 c5                	mov    %eax,%ebp
  80217b:	88 d9                	mov    %bl,%cl
  80217d:	d3 ed                	shr    %cl,%ebp
  80217f:	89 e9                	mov    %ebp,%ecx
  802181:	09 f1                	or     %esi,%ecx
  802183:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802187:	89 f9                	mov    %edi,%ecx
  802189:	d3 e0                	shl    %cl,%eax
  80218b:	89 c5                	mov    %eax,%ebp
  80218d:	89 d6                	mov    %edx,%esi
  80218f:	88 d9                	mov    %bl,%cl
  802191:	d3 ee                	shr    %cl,%esi
  802193:	89 f9                	mov    %edi,%ecx
  802195:	d3 e2                	shl    %cl,%edx
  802197:	8b 44 24 08          	mov    0x8(%esp),%eax
  80219b:	88 d9                	mov    %bl,%cl
  80219d:	d3 e8                	shr    %cl,%eax
  80219f:	09 c2                	or     %eax,%edx
  8021a1:	89 d0                	mov    %edx,%eax
  8021a3:	89 f2                	mov    %esi,%edx
  8021a5:	f7 74 24 0c          	divl   0xc(%esp)
  8021a9:	89 d6                	mov    %edx,%esi
  8021ab:	89 c3                	mov    %eax,%ebx
  8021ad:	f7 e5                	mul    %ebp
  8021af:	39 d6                	cmp    %edx,%esi
  8021b1:	72 19                	jb     8021cc <__udivdi3+0xfc>
  8021b3:	74 0b                	je     8021c0 <__udivdi3+0xf0>
  8021b5:	89 d8                	mov    %ebx,%eax
  8021b7:	31 ff                	xor    %edi,%edi
  8021b9:	e9 58 ff ff ff       	jmp    802116 <__udivdi3+0x46>
  8021be:	66 90                	xchg   %ax,%ax
  8021c0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8021c4:	89 f9                	mov    %edi,%ecx
  8021c6:	d3 e2                	shl    %cl,%edx
  8021c8:	39 c2                	cmp    %eax,%edx
  8021ca:	73 e9                	jae    8021b5 <__udivdi3+0xe5>
  8021cc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8021cf:	31 ff                	xor    %edi,%edi
  8021d1:	e9 40 ff ff ff       	jmp    802116 <__udivdi3+0x46>
  8021d6:	66 90                	xchg   %ax,%ax
  8021d8:	31 c0                	xor    %eax,%eax
  8021da:	e9 37 ff ff ff       	jmp    802116 <__udivdi3+0x46>
  8021df:	90                   	nop

008021e0 <__umoddi3>:
  8021e0:	55                   	push   %ebp
  8021e1:	57                   	push   %edi
  8021e2:	56                   	push   %esi
  8021e3:	53                   	push   %ebx
  8021e4:	83 ec 1c             	sub    $0x1c,%esp
  8021e7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8021eb:	8b 74 24 34          	mov    0x34(%esp),%esi
  8021ef:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021f3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8021f7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8021fb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8021ff:	89 f3                	mov    %esi,%ebx
  802201:	89 fa                	mov    %edi,%edx
  802203:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802207:	89 34 24             	mov    %esi,(%esp)
  80220a:	85 c0                	test   %eax,%eax
  80220c:	75 1a                	jne    802228 <__umoddi3+0x48>
  80220e:	39 f7                	cmp    %esi,%edi
  802210:	0f 86 a2 00 00 00    	jbe    8022b8 <__umoddi3+0xd8>
  802216:	89 c8                	mov    %ecx,%eax
  802218:	89 f2                	mov    %esi,%edx
  80221a:	f7 f7                	div    %edi
  80221c:	89 d0                	mov    %edx,%eax
  80221e:	31 d2                	xor    %edx,%edx
  802220:	83 c4 1c             	add    $0x1c,%esp
  802223:	5b                   	pop    %ebx
  802224:	5e                   	pop    %esi
  802225:	5f                   	pop    %edi
  802226:	5d                   	pop    %ebp
  802227:	c3                   	ret    
  802228:	39 f0                	cmp    %esi,%eax
  80222a:	0f 87 ac 00 00 00    	ja     8022dc <__umoddi3+0xfc>
  802230:	0f bd e8             	bsr    %eax,%ebp
  802233:	83 f5 1f             	xor    $0x1f,%ebp
  802236:	0f 84 ac 00 00 00    	je     8022e8 <__umoddi3+0x108>
  80223c:	bf 20 00 00 00       	mov    $0x20,%edi
  802241:	29 ef                	sub    %ebp,%edi
  802243:	89 fe                	mov    %edi,%esi
  802245:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802249:	89 e9                	mov    %ebp,%ecx
  80224b:	d3 e0                	shl    %cl,%eax
  80224d:	89 d7                	mov    %edx,%edi
  80224f:	89 f1                	mov    %esi,%ecx
  802251:	d3 ef                	shr    %cl,%edi
  802253:	09 c7                	or     %eax,%edi
  802255:	89 e9                	mov    %ebp,%ecx
  802257:	d3 e2                	shl    %cl,%edx
  802259:	89 14 24             	mov    %edx,(%esp)
  80225c:	89 d8                	mov    %ebx,%eax
  80225e:	d3 e0                	shl    %cl,%eax
  802260:	89 c2                	mov    %eax,%edx
  802262:	8b 44 24 08          	mov    0x8(%esp),%eax
  802266:	d3 e0                	shl    %cl,%eax
  802268:	89 44 24 04          	mov    %eax,0x4(%esp)
  80226c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802270:	89 f1                	mov    %esi,%ecx
  802272:	d3 e8                	shr    %cl,%eax
  802274:	09 d0                	or     %edx,%eax
  802276:	d3 eb                	shr    %cl,%ebx
  802278:	89 da                	mov    %ebx,%edx
  80227a:	f7 f7                	div    %edi
  80227c:	89 d3                	mov    %edx,%ebx
  80227e:	f7 24 24             	mull   (%esp)
  802281:	89 c6                	mov    %eax,%esi
  802283:	89 d1                	mov    %edx,%ecx
  802285:	39 d3                	cmp    %edx,%ebx
  802287:	0f 82 87 00 00 00    	jb     802314 <__umoddi3+0x134>
  80228d:	0f 84 91 00 00 00    	je     802324 <__umoddi3+0x144>
  802293:	8b 54 24 04          	mov    0x4(%esp),%edx
  802297:	29 f2                	sub    %esi,%edx
  802299:	19 cb                	sbb    %ecx,%ebx
  80229b:	89 d8                	mov    %ebx,%eax
  80229d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8022a1:	d3 e0                	shl    %cl,%eax
  8022a3:	89 e9                	mov    %ebp,%ecx
  8022a5:	d3 ea                	shr    %cl,%edx
  8022a7:	09 d0                	or     %edx,%eax
  8022a9:	89 e9                	mov    %ebp,%ecx
  8022ab:	d3 eb                	shr    %cl,%ebx
  8022ad:	89 da                	mov    %ebx,%edx
  8022af:	83 c4 1c             	add    $0x1c,%esp
  8022b2:	5b                   	pop    %ebx
  8022b3:	5e                   	pop    %esi
  8022b4:	5f                   	pop    %edi
  8022b5:	5d                   	pop    %ebp
  8022b6:	c3                   	ret    
  8022b7:	90                   	nop
  8022b8:	89 fd                	mov    %edi,%ebp
  8022ba:	85 ff                	test   %edi,%edi
  8022bc:	75 0b                	jne    8022c9 <__umoddi3+0xe9>
  8022be:	b8 01 00 00 00       	mov    $0x1,%eax
  8022c3:	31 d2                	xor    %edx,%edx
  8022c5:	f7 f7                	div    %edi
  8022c7:	89 c5                	mov    %eax,%ebp
  8022c9:	89 f0                	mov    %esi,%eax
  8022cb:	31 d2                	xor    %edx,%edx
  8022cd:	f7 f5                	div    %ebp
  8022cf:	89 c8                	mov    %ecx,%eax
  8022d1:	f7 f5                	div    %ebp
  8022d3:	89 d0                	mov    %edx,%eax
  8022d5:	e9 44 ff ff ff       	jmp    80221e <__umoddi3+0x3e>
  8022da:	66 90                	xchg   %ax,%ax
  8022dc:	89 c8                	mov    %ecx,%eax
  8022de:	89 f2                	mov    %esi,%edx
  8022e0:	83 c4 1c             	add    $0x1c,%esp
  8022e3:	5b                   	pop    %ebx
  8022e4:	5e                   	pop    %esi
  8022e5:	5f                   	pop    %edi
  8022e6:	5d                   	pop    %ebp
  8022e7:	c3                   	ret    
  8022e8:	3b 04 24             	cmp    (%esp),%eax
  8022eb:	72 06                	jb     8022f3 <__umoddi3+0x113>
  8022ed:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8022f1:	77 0f                	ja     802302 <__umoddi3+0x122>
  8022f3:	89 f2                	mov    %esi,%edx
  8022f5:	29 f9                	sub    %edi,%ecx
  8022f7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8022fb:	89 14 24             	mov    %edx,(%esp)
  8022fe:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802302:	8b 44 24 04          	mov    0x4(%esp),%eax
  802306:	8b 14 24             	mov    (%esp),%edx
  802309:	83 c4 1c             	add    $0x1c,%esp
  80230c:	5b                   	pop    %ebx
  80230d:	5e                   	pop    %esi
  80230e:	5f                   	pop    %edi
  80230f:	5d                   	pop    %ebp
  802310:	c3                   	ret    
  802311:	8d 76 00             	lea    0x0(%esi),%esi
  802314:	2b 04 24             	sub    (%esp),%eax
  802317:	19 fa                	sbb    %edi,%edx
  802319:	89 d1                	mov    %edx,%ecx
  80231b:	89 c6                	mov    %eax,%esi
  80231d:	e9 71 ff ff ff       	jmp    802293 <__umoddi3+0xb3>
  802322:	66 90                	xchg   %ax,%ax
  802324:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802328:	72 ea                	jb     802314 <__umoddi3+0x134>
  80232a:	89 d9                	mov    %ebx,%ecx
  80232c:	e9 62 ff ff ff       	jmp    802293 <__umoddi3+0xb3>
