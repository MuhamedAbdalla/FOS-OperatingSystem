
obj/user/quicksort_freeheap:     file format elf32-i386


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
  800031:	e8 b4 05 00 00       	call   8005ea <libmain>
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
  800049:	e8 64 1b 00 00       	call   801bb2 <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 76 1b 00 00       	call   801bcb <sys_calculate_modified_frames>
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
  80006c:	e8 d7 0f 00 00       	call   801048 <readline>
  800071:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  800074:	83 ec 04             	sub    $0x4,%esp
  800077:	6a 0a                	push   $0xa
  800079:	6a 00                	push   $0x0
  80007b:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800081:	50                   	push   %eax
  800082:	e8 27 15 00 00       	call   8015ae <strtol>
  800087:	83 c4 10             	add    $0x10,%esp
  80008a:	89 45 ec             	mov    %eax,-0x14(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  80008d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800090:	c1 e0 02             	shl    $0x2,%eax
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	50                   	push   %eax
  800097:	e8 ba 18 00 00       	call   801956 <malloc>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 45 e8             	mov    %eax,-0x18(%ebp)
		cprintf("Choose the initialization method:\n") ;
  8000a2:	83 ec 0c             	sub    $0xc,%esp
  8000a5:	68 60 23 80 00       	push   $0x802360
  8000aa:	e8 17 09 00 00       	call   8009c6 <cprintf>
  8000af:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	68 83 23 80 00       	push   $0x802383
  8000ba:	e8 07 09 00 00       	call   8009c6 <cprintf>
  8000bf:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000c2:	83 ec 0c             	sub    $0xc,%esp
  8000c5:	68 91 23 80 00       	push   $0x802391
  8000ca:	e8 f7 08 00 00       	call   8009c6 <cprintf>
  8000cf:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  8000d2:	83 ec 0c             	sub    $0xc,%esp
  8000d5:	68 a0 23 80 00       	push   $0x8023a0
  8000da:	e8 e7 08 00 00       	call   8009c6 <cprintf>
  8000df:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  8000e2:	83 ec 0c             	sub    $0xc,%esp
  8000e5:	68 b0 23 80 00       	push   $0x8023b0
  8000ea:	e8 d7 08 00 00       	call   8009c6 <cprintf>
  8000ef:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  8000f2:	e8 9b 04 00 00       	call   800592 <getchar>
  8000f7:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  8000fa:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  8000fe:	83 ec 0c             	sub    $0xc,%esp
  800101:	50                   	push   %eax
  800102:	e8 43 04 00 00       	call   80054a <cputchar>
  800107:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80010a:	83 ec 0c             	sub    $0xc,%esp
  80010d:	6a 0a                	push   $0xa
  80010f:	e8 36 04 00 00       	call   80054a <cputchar>
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
  800145:	e8 c8 02 00 00       	call   800412 <InitializeAscending>
  80014a:	83 c4 10             	add    $0x10,%esp
			break ;
  80014d:	eb 37                	jmp    800186 <_main+0x14e>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80014f:	83 ec 08             	sub    $0x8,%esp
  800152:	ff 75 ec             	pushl  -0x14(%ebp)
  800155:	ff 75 e8             	pushl  -0x18(%ebp)
  800158:	e8 e6 02 00 00       	call   800443 <InitializeDescending>
  80015d:	83 c4 10             	add    $0x10,%esp
			break ;
  800160:	eb 24                	jmp    800186 <_main+0x14e>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800162:	83 ec 08             	sub    $0x8,%esp
  800165:	ff 75 ec             	pushl  -0x14(%ebp)
  800168:	ff 75 e8             	pushl  -0x18(%ebp)
  80016b:	e8 08 03 00 00       	call   800478 <InitializeSemiRandom>
  800170:	83 c4 10             	add    $0x10,%esp
			break ;
  800173:	eb 11                	jmp    800186 <_main+0x14e>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800175:	83 ec 08             	sub    $0x8,%esp
  800178:	ff 75 ec             	pushl  -0x14(%ebp)
  80017b:	ff 75 e8             	pushl  -0x18(%ebp)
  80017e:	e8 f5 02 00 00       	call   800478 <InitializeSemiRandom>
  800183:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  800186:	83 ec 08             	sub    $0x8,%esp
  800189:	ff 75 ec             	pushl  -0x14(%ebp)
  80018c:	ff 75 e8             	pushl  -0x18(%ebp)
  80018f:	e8 c3 00 00 00       	call   800257 <QuickSort>
  800194:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800197:	83 ec 08             	sub    $0x8,%esp
  80019a:	ff 75 ec             	pushl  -0x14(%ebp)
  80019d:	ff 75 e8             	pushl  -0x18(%ebp)
  8001a0:	e8 c3 01 00 00       	call   800368 <CheckSorted>
  8001a5:	83 c4 10             	add    $0x10,%esp
  8001a8:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001ab:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8001af:	75 14                	jne    8001c5 <_main+0x18d>
  8001b1:	83 ec 04             	sub    $0x4,%esp
  8001b4:	68 bc 23 80 00       	push   $0x8023bc
  8001b9:	6a 45                	push   $0x45
  8001bb:	68 de 23 80 00       	push   $0x8023de
  8001c0:	e8 4a 05 00 00       	call   80070f <_panic>
		else
		{ 
			cprintf("===============================================\n") ;
  8001c5:	83 ec 0c             	sub    $0xc,%esp
  8001c8:	68 f8 23 80 00       	push   $0x8023f8
  8001cd:	e8 f4 07 00 00       	call   8009c6 <cprintf>
  8001d2:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001d5:	83 ec 0c             	sub    $0xc,%esp
  8001d8:	68 2c 24 80 00       	push   $0x80242c
  8001dd:	e8 e4 07 00 00       	call   8009c6 <cprintf>
  8001e2:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  8001e5:	83 ec 0c             	sub    $0xc,%esp
  8001e8:	68 60 24 80 00       	push   $0x802460
  8001ed:	e8 d4 07 00 00       	call   8009c6 <cprintf>
  8001f2:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		cprintf("Freeing the Heap...\n\n") ;
  8001f5:	83 ec 0c             	sub    $0xc,%esp
  8001f8:	68 92 24 80 00       	push   $0x802492
  8001fd:	e8 c4 07 00 00       	call   8009c6 <cprintf>
  800202:	83 c4 10             	add    $0x10,%esp

		//freeHeap() ;

		///========================================================================
		//sys_disable_interrupt();
		cprintf("Do you want to repeat (y/n): ") ;
  800205:	83 ec 0c             	sub    $0xc,%esp
  800208:	68 a8 24 80 00       	push   $0x8024a8
  80020d:	e8 b4 07 00 00       	call   8009c6 <cprintf>
  800212:	83 c4 10             	add    $0x10,%esp
		Chose = getchar() ;
  800215:	e8 78 03 00 00       	call   800592 <getchar>
  80021a:	88 45 e7             	mov    %al,-0x19(%ebp)
		cputchar(Chose);
  80021d:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800221:	83 ec 0c             	sub    $0xc,%esp
  800224:	50                   	push   %eax
  800225:	e8 20 03 00 00       	call   80054a <cputchar>
  80022a:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  80022d:	83 ec 0c             	sub    $0xc,%esp
  800230:	6a 0a                	push   $0xa
  800232:	e8 13 03 00 00       	call   80054a <cputchar>
  800237:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  80023a:	83 ec 0c             	sub    $0xc,%esp
  80023d:	6a 0a                	push   $0xa
  80023f:	e8 06 03 00 00       	call   80054a <cputchar>
  800244:	83 c4 10             	add    $0x10,%esp
		//sys_enable_interrupt();

	} while (Chose == 'y');
  800247:	80 7d e7 79          	cmpb   $0x79,-0x19(%ebp)
  80024b:	0f 84 f8 fd ff ff    	je     800049 <_main+0x11>

}
  800251:	90                   	nop
  800252:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800255:	c9                   	leave  
  800256:	c3                   	ret    

00800257 <QuickSort>:

///Quick sort 
void QuickSort(int *Elements, int NumOfElements)
{
  800257:	55                   	push   %ebp
  800258:	89 e5                	mov    %esp,%ebp
  80025a:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  80025d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800260:	48                   	dec    %eax
  800261:	50                   	push   %eax
  800262:	6a 00                	push   $0x0
  800264:	ff 75 0c             	pushl  0xc(%ebp)
  800267:	ff 75 08             	pushl  0x8(%ebp)
  80026a:	e8 06 00 00 00       	call   800275 <QSort>
  80026f:	83 c4 10             	add    $0x10,%esp
}
  800272:	90                   	nop
  800273:	c9                   	leave  
  800274:	c3                   	ret    

00800275 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800275:	55                   	push   %ebp
  800276:	89 e5                	mov    %esp,%ebp
  800278:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  80027b:	8b 45 10             	mov    0x10(%ebp),%eax
  80027e:	3b 45 14             	cmp    0x14(%ebp),%eax
  800281:	0f 8d de 00 00 00    	jge    800365 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800287:	8b 45 10             	mov    0x10(%ebp),%eax
  80028a:	40                   	inc    %eax
  80028b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80028e:	8b 45 14             	mov    0x14(%ebp),%eax
  800291:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800294:	e9 80 00 00 00       	jmp    800319 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800299:	ff 45 f4             	incl   -0xc(%ebp)
  80029c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80029f:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002a2:	7f 2b                	jg     8002cf <QSort+0x5a>
  8002a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8002a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8002b1:	01 d0                	add    %edx,%eax
  8002b3:	8b 10                	mov    (%eax),%edx
  8002b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002b8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c2:	01 c8                	add    %ecx,%eax
  8002c4:	8b 00                	mov    (%eax),%eax
  8002c6:	39 c2                	cmp    %eax,%edx
  8002c8:	7d cf                	jge    800299 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002ca:	eb 03                	jmp    8002cf <QSort+0x5a>
  8002cc:	ff 4d f0             	decl   -0x10(%ebp)
  8002cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002d2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002d5:	7e 26                	jle    8002fd <QSort+0x88>
  8002d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8002da:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e4:	01 d0                	add    %edx,%eax
  8002e6:	8b 10                	mov    (%eax),%edx
  8002e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002eb:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f5:	01 c8                	add    %ecx,%eax
  8002f7:	8b 00                	mov    (%eax),%eax
  8002f9:	39 c2                	cmp    %eax,%edx
  8002fb:	7e cf                	jle    8002cc <QSort+0x57>

		if (i <= j)
  8002fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800300:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800303:	7f 14                	jg     800319 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800305:	83 ec 04             	sub    $0x4,%esp
  800308:	ff 75 f0             	pushl  -0x10(%ebp)
  80030b:	ff 75 f4             	pushl  -0xc(%ebp)
  80030e:	ff 75 08             	pushl  0x8(%ebp)
  800311:	e8 a9 00 00 00       	call   8003bf <Swap>
  800316:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800319:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80031c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80031f:	0f 8e 77 ff ff ff    	jle    80029c <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800325:	83 ec 04             	sub    $0x4,%esp
  800328:	ff 75 f0             	pushl  -0x10(%ebp)
  80032b:	ff 75 10             	pushl  0x10(%ebp)
  80032e:	ff 75 08             	pushl  0x8(%ebp)
  800331:	e8 89 00 00 00       	call   8003bf <Swap>
  800336:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800339:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80033c:	48                   	dec    %eax
  80033d:	50                   	push   %eax
  80033e:	ff 75 10             	pushl  0x10(%ebp)
  800341:	ff 75 0c             	pushl  0xc(%ebp)
  800344:	ff 75 08             	pushl  0x8(%ebp)
  800347:	e8 29 ff ff ff       	call   800275 <QSort>
  80034c:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  80034f:	ff 75 14             	pushl  0x14(%ebp)
  800352:	ff 75 f4             	pushl  -0xc(%ebp)
  800355:	ff 75 0c             	pushl  0xc(%ebp)
  800358:	ff 75 08             	pushl  0x8(%ebp)
  80035b:	e8 15 ff ff ff       	call   800275 <QSort>
  800360:	83 c4 10             	add    $0x10,%esp
  800363:	eb 01                	jmp    800366 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800365:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800366:	c9                   	leave  
  800367:	c3                   	ret    

00800368 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800368:	55                   	push   %ebp
  800369:	89 e5                	mov    %esp,%ebp
  80036b:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  80036e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800375:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80037c:	eb 33                	jmp    8003b1 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80037e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800381:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800388:	8b 45 08             	mov    0x8(%ebp),%eax
  80038b:	01 d0                	add    %edx,%eax
  80038d:	8b 10                	mov    (%eax),%edx
  80038f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800392:	40                   	inc    %eax
  800393:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80039a:	8b 45 08             	mov    0x8(%ebp),%eax
  80039d:	01 c8                	add    %ecx,%eax
  80039f:	8b 00                	mov    (%eax),%eax
  8003a1:	39 c2                	cmp    %eax,%edx
  8003a3:	7e 09                	jle    8003ae <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003ac:	eb 0c                	jmp    8003ba <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003ae:	ff 45 f8             	incl   -0x8(%ebp)
  8003b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b4:	48                   	dec    %eax
  8003b5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003b8:	7f c4                	jg     80037e <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003bd:	c9                   	leave  
  8003be:	c3                   	ret    

008003bf <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003bf:	55                   	push   %ebp
  8003c0:	89 e5                	mov    %esp,%ebp
  8003c2:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d2:	01 d0                	add    %edx,%eax
  8003d4:	8b 00                	mov    (%eax),%eax
  8003d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8003d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e6:	01 c2                	add    %eax,%edx
  8003e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8003eb:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f5:	01 c8                	add    %ecx,%eax
  8003f7:	8b 00                	mov    (%eax),%eax
  8003f9:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8003fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8003fe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800405:	8b 45 08             	mov    0x8(%ebp),%eax
  800408:	01 c2                	add    %eax,%edx
  80040a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040d:	89 02                	mov    %eax,(%edx)
}
  80040f:	90                   	nop
  800410:	c9                   	leave  
  800411:	c3                   	ret    

00800412 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800412:	55                   	push   %ebp
  800413:	89 e5                	mov    %esp,%ebp
  800415:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800418:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80041f:	eb 17                	jmp    800438 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800421:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800424:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80042b:	8b 45 08             	mov    0x8(%ebp),%eax
  80042e:	01 c2                	add    %eax,%edx
  800430:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800433:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800435:	ff 45 fc             	incl   -0x4(%ebp)
  800438:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80043b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80043e:	7c e1                	jl     800421 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800440:	90                   	nop
  800441:	c9                   	leave  
  800442:	c3                   	ret    

00800443 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800443:	55                   	push   %ebp
  800444:	89 e5                	mov    %esp,%ebp
  800446:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800449:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800450:	eb 1b                	jmp    80046d <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800452:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800455:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045c:	8b 45 08             	mov    0x8(%ebp),%eax
  80045f:	01 c2                	add    %eax,%edx
  800461:	8b 45 0c             	mov    0xc(%ebp),%eax
  800464:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800467:	48                   	dec    %eax
  800468:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80046a:	ff 45 fc             	incl   -0x4(%ebp)
  80046d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800470:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800473:	7c dd                	jl     800452 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800475:	90                   	nop
  800476:	c9                   	leave  
  800477:	c3                   	ret    

00800478 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800478:	55                   	push   %ebp
  800479:	89 e5                	mov    %esp,%ebp
  80047b:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80047e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800481:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800486:	f7 e9                	imul   %ecx
  800488:	c1 f9 1f             	sar    $0x1f,%ecx
  80048b:	89 d0                	mov    %edx,%eax
  80048d:	29 c8                	sub    %ecx,%eax
  80048f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800492:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800499:	eb 1e                	jmp    8004b9 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  80049b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a8:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8004ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ae:	99                   	cltd   
  8004af:	f7 7d f8             	idivl  -0x8(%ebp)
  8004b2:	89 d0                	mov    %edx,%eax
  8004b4:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004b6:	ff 45 fc             	incl   -0x4(%ebp)
  8004b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004bc:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004bf:	7c da                	jl     80049b <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8004c1:	90                   	nop
  8004c2:	c9                   	leave  
  8004c3:	c3                   	ret    

008004c4 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004c4:	55                   	push   %ebp
  8004c5:	89 e5                	mov    %esp,%ebp
  8004c7:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  8004ca:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8004d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004d8:	eb 42                	jmp    80051c <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  8004da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004dd:	99                   	cltd   
  8004de:	f7 7d f0             	idivl  -0x10(%ebp)
  8004e1:	89 d0                	mov    %edx,%eax
  8004e3:	85 c0                	test   %eax,%eax
  8004e5:	75 10                	jne    8004f7 <PrintElements+0x33>
			cprintf("\n");
  8004e7:	83 ec 0c             	sub    $0xc,%esp
  8004ea:	68 c6 24 80 00       	push   $0x8024c6
  8004ef:	e8 d2 04 00 00       	call   8009c6 <cprintf>
  8004f4:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  8004f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800501:	8b 45 08             	mov    0x8(%ebp),%eax
  800504:	01 d0                	add    %edx,%eax
  800506:	8b 00                	mov    (%eax),%eax
  800508:	83 ec 08             	sub    $0x8,%esp
  80050b:	50                   	push   %eax
  80050c:	68 c8 24 80 00       	push   $0x8024c8
  800511:	e8 b0 04 00 00       	call   8009c6 <cprintf>
  800516:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800519:	ff 45 f4             	incl   -0xc(%ebp)
  80051c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80051f:	48                   	dec    %eax
  800520:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800523:	7f b5                	jg     8004da <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800525:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800528:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80052f:	8b 45 08             	mov    0x8(%ebp),%eax
  800532:	01 d0                	add    %edx,%eax
  800534:	8b 00                	mov    (%eax),%eax
  800536:	83 ec 08             	sub    $0x8,%esp
  800539:	50                   	push   %eax
  80053a:	68 cd 24 80 00       	push   $0x8024cd
  80053f:	e8 82 04 00 00       	call   8009c6 <cprintf>
  800544:	83 c4 10             	add    $0x10,%esp
}
  800547:	90                   	nop
  800548:	c9                   	leave  
  800549:	c3                   	ret    

0080054a <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80054a:	55                   	push   %ebp
  80054b:	89 e5                	mov    %esp,%ebp
  80054d:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800550:	8b 45 08             	mov    0x8(%ebp),%eax
  800553:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800556:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80055a:	83 ec 0c             	sub    $0xc,%esp
  80055d:	50                   	push   %eax
  80055e:	e8 53 17 00 00       	call   801cb6 <sys_cputc>
  800563:	83 c4 10             	add    $0x10,%esp
}
  800566:	90                   	nop
  800567:	c9                   	leave  
  800568:	c3                   	ret    

00800569 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800569:	55                   	push   %ebp
  80056a:	89 e5                	mov    %esp,%ebp
  80056c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80056f:	e8 0e 17 00 00       	call   801c82 <sys_disable_interrupt>
	char c = ch;
  800574:	8b 45 08             	mov    0x8(%ebp),%eax
  800577:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80057a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80057e:	83 ec 0c             	sub    $0xc,%esp
  800581:	50                   	push   %eax
  800582:	e8 2f 17 00 00       	call   801cb6 <sys_cputc>
  800587:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80058a:	e8 0d 17 00 00       	call   801c9c <sys_enable_interrupt>
}
  80058f:	90                   	nop
  800590:	c9                   	leave  
  800591:	c3                   	ret    

00800592 <getchar>:

int
getchar(void)
{
  800592:	55                   	push   %ebp
  800593:	89 e5                	mov    %esp,%ebp
  800595:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800598:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80059f:	eb 08                	jmp    8005a9 <getchar+0x17>
	{
		c = sys_cgetc();
  8005a1:	e8 f4 14 00 00       	call   801a9a <sys_cgetc>
  8005a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8005a9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005ad:	74 f2                	je     8005a1 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8005af:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005b2:	c9                   	leave  
  8005b3:	c3                   	ret    

008005b4 <atomic_getchar>:

int
atomic_getchar(void)
{
  8005b4:	55                   	push   %ebp
  8005b5:	89 e5                	mov    %esp,%ebp
  8005b7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005ba:	e8 c3 16 00 00       	call   801c82 <sys_disable_interrupt>
	int c=0;
  8005bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005c6:	eb 08                	jmp    8005d0 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005c8:	e8 cd 14 00 00       	call   801a9a <sys_cgetc>
  8005cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8005d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005d4:	74 f2                	je     8005c8 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8005d6:	e8 c1 16 00 00       	call   801c9c <sys_enable_interrupt>
	return c;
  8005db:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005de:	c9                   	leave  
  8005df:	c3                   	ret    

008005e0 <iscons>:

int iscons(int fdnum)
{
  8005e0:	55                   	push   %ebp
  8005e1:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005e3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005e8:	5d                   	pop    %ebp
  8005e9:	c3                   	ret    

008005ea <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005ea:	55                   	push   %ebp
  8005eb:	89 e5                	mov    %esp,%ebp
  8005ed:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005f0:	e8 f2 14 00 00       	call   801ae7 <sys_getenvindex>
  8005f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005fb:	89 d0                	mov    %edx,%eax
  8005fd:	c1 e0 03             	shl    $0x3,%eax
  800600:	01 d0                	add    %edx,%eax
  800602:	c1 e0 02             	shl    $0x2,%eax
  800605:	01 d0                	add    %edx,%eax
  800607:	c1 e0 06             	shl    $0x6,%eax
  80060a:	29 d0                	sub    %edx,%eax
  80060c:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800613:	01 c8                	add    %ecx,%eax
  800615:	01 d0                	add    %edx,%eax
  800617:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80061c:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800621:	a1 24 30 80 00       	mov    0x803024,%eax
  800626:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  80062c:	84 c0                	test   %al,%al
  80062e:	74 0f                	je     80063f <libmain+0x55>
		binaryname = myEnv->prog_name;
  800630:	a1 24 30 80 00       	mov    0x803024,%eax
  800635:	05 b0 52 00 00       	add    $0x52b0,%eax
  80063a:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80063f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800643:	7e 0a                	jle    80064f <libmain+0x65>
		binaryname = argv[0];
  800645:	8b 45 0c             	mov    0xc(%ebp),%eax
  800648:	8b 00                	mov    (%eax),%eax
  80064a:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80064f:	83 ec 08             	sub    $0x8,%esp
  800652:	ff 75 0c             	pushl  0xc(%ebp)
  800655:	ff 75 08             	pushl  0x8(%ebp)
  800658:	e8 db f9 ff ff       	call   800038 <_main>
  80065d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800660:	e8 1d 16 00 00       	call   801c82 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800665:	83 ec 0c             	sub    $0xc,%esp
  800668:	68 ec 24 80 00       	push   $0x8024ec
  80066d:	e8 54 03 00 00       	call   8009c6 <cprintf>
  800672:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800675:	a1 24 30 80 00       	mov    0x803024,%eax
  80067a:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  800680:	a1 24 30 80 00       	mov    0x803024,%eax
  800685:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  80068b:	83 ec 04             	sub    $0x4,%esp
  80068e:	52                   	push   %edx
  80068f:	50                   	push   %eax
  800690:	68 14 25 80 00       	push   $0x802514
  800695:	e8 2c 03 00 00       	call   8009c6 <cprintf>
  80069a:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80069d:	a1 24 30 80 00       	mov    0x803024,%eax
  8006a2:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  8006a8:	a1 24 30 80 00       	mov    0x803024,%eax
  8006ad:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  8006b3:	a1 24 30 80 00       	mov    0x803024,%eax
  8006b8:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  8006be:	51                   	push   %ecx
  8006bf:	52                   	push   %edx
  8006c0:	50                   	push   %eax
  8006c1:	68 3c 25 80 00       	push   $0x80253c
  8006c6:	e8 fb 02 00 00       	call   8009c6 <cprintf>
  8006cb:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8006ce:	83 ec 0c             	sub    $0xc,%esp
  8006d1:	68 ec 24 80 00       	push   $0x8024ec
  8006d6:	e8 eb 02 00 00       	call   8009c6 <cprintf>
  8006db:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006de:	e8 b9 15 00 00       	call   801c9c <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006e3:	e8 19 00 00 00       	call   800701 <exit>
}
  8006e8:	90                   	nop
  8006e9:	c9                   	leave  
  8006ea:	c3                   	ret    

008006eb <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006eb:	55                   	push   %ebp
  8006ec:	89 e5                	mov    %esp,%ebp
  8006ee:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006f1:	83 ec 0c             	sub    $0xc,%esp
  8006f4:	6a 00                	push   $0x0
  8006f6:	e8 b8 13 00 00       	call   801ab3 <sys_env_destroy>
  8006fb:	83 c4 10             	add    $0x10,%esp
}
  8006fe:	90                   	nop
  8006ff:	c9                   	leave  
  800700:	c3                   	ret    

00800701 <exit>:

void
exit(void)
{
  800701:	55                   	push   %ebp
  800702:	89 e5                	mov    %esp,%ebp
  800704:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800707:	e8 0d 14 00 00       	call   801b19 <sys_env_exit>
}
  80070c:	90                   	nop
  80070d:	c9                   	leave  
  80070e:	c3                   	ret    

0080070f <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80070f:	55                   	push   %ebp
  800710:	89 e5                	mov    %esp,%ebp
  800712:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800715:	8d 45 10             	lea    0x10(%ebp),%eax
  800718:	83 c0 04             	add    $0x4,%eax
  80071b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80071e:	a1 18 31 80 00       	mov    0x803118,%eax
  800723:	85 c0                	test   %eax,%eax
  800725:	74 16                	je     80073d <_panic+0x2e>
		cprintf("%s: ", argv0);
  800727:	a1 18 31 80 00       	mov    0x803118,%eax
  80072c:	83 ec 08             	sub    $0x8,%esp
  80072f:	50                   	push   %eax
  800730:	68 94 25 80 00       	push   $0x802594
  800735:	e8 8c 02 00 00       	call   8009c6 <cprintf>
  80073a:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80073d:	a1 00 30 80 00       	mov    0x803000,%eax
  800742:	ff 75 0c             	pushl  0xc(%ebp)
  800745:	ff 75 08             	pushl  0x8(%ebp)
  800748:	50                   	push   %eax
  800749:	68 99 25 80 00       	push   $0x802599
  80074e:	e8 73 02 00 00       	call   8009c6 <cprintf>
  800753:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800756:	8b 45 10             	mov    0x10(%ebp),%eax
  800759:	83 ec 08             	sub    $0x8,%esp
  80075c:	ff 75 f4             	pushl  -0xc(%ebp)
  80075f:	50                   	push   %eax
  800760:	e8 f6 01 00 00       	call   80095b <vcprintf>
  800765:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800768:	83 ec 08             	sub    $0x8,%esp
  80076b:	6a 00                	push   $0x0
  80076d:	68 b5 25 80 00       	push   $0x8025b5
  800772:	e8 e4 01 00 00       	call   80095b <vcprintf>
  800777:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80077a:	e8 82 ff ff ff       	call   800701 <exit>

	// should not return here
	while (1) ;
  80077f:	eb fe                	jmp    80077f <_panic+0x70>

00800781 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800781:	55                   	push   %ebp
  800782:	89 e5                	mov    %esp,%ebp
  800784:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800787:	a1 24 30 80 00       	mov    0x803024,%eax
  80078c:	8b 50 74             	mov    0x74(%eax),%edx
  80078f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800792:	39 c2                	cmp    %eax,%edx
  800794:	74 14                	je     8007aa <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800796:	83 ec 04             	sub    $0x4,%esp
  800799:	68 b8 25 80 00       	push   $0x8025b8
  80079e:	6a 26                	push   $0x26
  8007a0:	68 04 26 80 00       	push   $0x802604
  8007a5:	e8 65 ff ff ff       	call   80070f <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007aa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007b1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007b8:	e9 c4 00 00 00       	jmp    800881 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  8007bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007c0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ca:	01 d0                	add    %edx,%eax
  8007cc:	8b 00                	mov    (%eax),%eax
  8007ce:	85 c0                	test   %eax,%eax
  8007d0:	75 08                	jne    8007da <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007d2:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007d5:	e9 a4 00 00 00       	jmp    80087e <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8007da:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007e1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007e8:	eb 6b                	jmp    800855 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007ea:	a1 24 30 80 00       	mov    0x803024,%eax
  8007ef:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8007f5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007f8:	89 d0                	mov    %edx,%eax
  8007fa:	c1 e0 02             	shl    $0x2,%eax
  8007fd:	01 d0                	add    %edx,%eax
  8007ff:	c1 e0 02             	shl    $0x2,%eax
  800802:	01 c8                	add    %ecx,%eax
  800804:	8a 40 04             	mov    0x4(%eax),%al
  800807:	84 c0                	test   %al,%al
  800809:	75 47                	jne    800852 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80080b:	a1 24 30 80 00       	mov    0x803024,%eax
  800810:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800816:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800819:	89 d0                	mov    %edx,%eax
  80081b:	c1 e0 02             	shl    $0x2,%eax
  80081e:	01 d0                	add    %edx,%eax
  800820:	c1 e0 02             	shl    $0x2,%eax
  800823:	01 c8                	add    %ecx,%eax
  800825:	8b 00                	mov    (%eax),%eax
  800827:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80082a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80082d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800832:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800834:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800837:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80083e:	8b 45 08             	mov    0x8(%ebp),%eax
  800841:	01 c8                	add    %ecx,%eax
  800843:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800845:	39 c2                	cmp    %eax,%edx
  800847:	75 09                	jne    800852 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800849:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800850:	eb 12                	jmp    800864 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800852:	ff 45 e8             	incl   -0x18(%ebp)
  800855:	a1 24 30 80 00       	mov    0x803024,%eax
  80085a:	8b 50 74             	mov    0x74(%eax),%edx
  80085d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800860:	39 c2                	cmp    %eax,%edx
  800862:	77 86                	ja     8007ea <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800864:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800868:	75 14                	jne    80087e <CheckWSWithoutLastIndex+0xfd>
			panic(
  80086a:	83 ec 04             	sub    $0x4,%esp
  80086d:	68 10 26 80 00       	push   $0x802610
  800872:	6a 3a                	push   $0x3a
  800874:	68 04 26 80 00       	push   $0x802604
  800879:	e8 91 fe ff ff       	call   80070f <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80087e:	ff 45 f0             	incl   -0x10(%ebp)
  800881:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800884:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800887:	0f 8c 30 ff ff ff    	jl     8007bd <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80088d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800894:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80089b:	eb 27                	jmp    8008c4 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80089d:	a1 24 30 80 00       	mov    0x803024,%eax
  8008a2:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8008a8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008ab:	89 d0                	mov    %edx,%eax
  8008ad:	c1 e0 02             	shl    $0x2,%eax
  8008b0:	01 d0                	add    %edx,%eax
  8008b2:	c1 e0 02             	shl    $0x2,%eax
  8008b5:	01 c8                	add    %ecx,%eax
  8008b7:	8a 40 04             	mov    0x4(%eax),%al
  8008ba:	3c 01                	cmp    $0x1,%al
  8008bc:	75 03                	jne    8008c1 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  8008be:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008c1:	ff 45 e0             	incl   -0x20(%ebp)
  8008c4:	a1 24 30 80 00       	mov    0x803024,%eax
  8008c9:	8b 50 74             	mov    0x74(%eax),%edx
  8008cc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008cf:	39 c2                	cmp    %eax,%edx
  8008d1:	77 ca                	ja     80089d <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008d6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008d9:	74 14                	je     8008ef <CheckWSWithoutLastIndex+0x16e>
		panic(
  8008db:	83 ec 04             	sub    $0x4,%esp
  8008de:	68 64 26 80 00       	push   $0x802664
  8008e3:	6a 44                	push   $0x44
  8008e5:	68 04 26 80 00       	push   $0x802604
  8008ea:	e8 20 fe ff ff       	call   80070f <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008ef:	90                   	nop
  8008f0:	c9                   	leave  
  8008f1:	c3                   	ret    

008008f2 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008f2:	55                   	push   %ebp
  8008f3:	89 e5                	mov    %esp,%ebp
  8008f5:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fb:	8b 00                	mov    (%eax),%eax
  8008fd:	8d 48 01             	lea    0x1(%eax),%ecx
  800900:	8b 55 0c             	mov    0xc(%ebp),%edx
  800903:	89 0a                	mov    %ecx,(%edx)
  800905:	8b 55 08             	mov    0x8(%ebp),%edx
  800908:	88 d1                	mov    %dl,%cl
  80090a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80090d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800911:	8b 45 0c             	mov    0xc(%ebp),%eax
  800914:	8b 00                	mov    (%eax),%eax
  800916:	3d ff 00 00 00       	cmp    $0xff,%eax
  80091b:	75 2c                	jne    800949 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80091d:	a0 28 30 80 00       	mov    0x803028,%al
  800922:	0f b6 c0             	movzbl %al,%eax
  800925:	8b 55 0c             	mov    0xc(%ebp),%edx
  800928:	8b 12                	mov    (%edx),%edx
  80092a:	89 d1                	mov    %edx,%ecx
  80092c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80092f:	83 c2 08             	add    $0x8,%edx
  800932:	83 ec 04             	sub    $0x4,%esp
  800935:	50                   	push   %eax
  800936:	51                   	push   %ecx
  800937:	52                   	push   %edx
  800938:	e8 34 11 00 00       	call   801a71 <sys_cputs>
  80093d:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800940:	8b 45 0c             	mov    0xc(%ebp),%eax
  800943:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800949:	8b 45 0c             	mov    0xc(%ebp),%eax
  80094c:	8b 40 04             	mov    0x4(%eax),%eax
  80094f:	8d 50 01             	lea    0x1(%eax),%edx
  800952:	8b 45 0c             	mov    0xc(%ebp),%eax
  800955:	89 50 04             	mov    %edx,0x4(%eax)
}
  800958:	90                   	nop
  800959:	c9                   	leave  
  80095a:	c3                   	ret    

0080095b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80095b:	55                   	push   %ebp
  80095c:	89 e5                	mov    %esp,%ebp
  80095e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800964:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80096b:	00 00 00 
	b.cnt = 0;
  80096e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800975:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800978:	ff 75 0c             	pushl  0xc(%ebp)
  80097b:	ff 75 08             	pushl  0x8(%ebp)
  80097e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800984:	50                   	push   %eax
  800985:	68 f2 08 80 00       	push   $0x8008f2
  80098a:	e8 11 02 00 00       	call   800ba0 <vprintfmt>
  80098f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800992:	a0 28 30 80 00       	mov    0x803028,%al
  800997:	0f b6 c0             	movzbl %al,%eax
  80099a:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009a0:	83 ec 04             	sub    $0x4,%esp
  8009a3:	50                   	push   %eax
  8009a4:	52                   	push   %edx
  8009a5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009ab:	83 c0 08             	add    $0x8,%eax
  8009ae:	50                   	push   %eax
  8009af:	e8 bd 10 00 00       	call   801a71 <sys_cputs>
  8009b4:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009b7:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  8009be:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009c4:	c9                   	leave  
  8009c5:	c3                   	ret    

008009c6 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009c6:	55                   	push   %ebp
  8009c7:	89 e5                	mov    %esp,%ebp
  8009c9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009cc:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  8009d3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009dc:	83 ec 08             	sub    $0x8,%esp
  8009df:	ff 75 f4             	pushl  -0xc(%ebp)
  8009e2:	50                   	push   %eax
  8009e3:	e8 73 ff ff ff       	call   80095b <vcprintf>
  8009e8:	83 c4 10             	add    $0x10,%esp
  8009eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009f1:	c9                   	leave  
  8009f2:	c3                   	ret    

008009f3 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009f3:	55                   	push   %ebp
  8009f4:	89 e5                	mov    %esp,%ebp
  8009f6:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009f9:	e8 84 12 00 00       	call   801c82 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009fe:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a01:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a04:	8b 45 08             	mov    0x8(%ebp),%eax
  800a07:	83 ec 08             	sub    $0x8,%esp
  800a0a:	ff 75 f4             	pushl  -0xc(%ebp)
  800a0d:	50                   	push   %eax
  800a0e:	e8 48 ff ff ff       	call   80095b <vcprintf>
  800a13:	83 c4 10             	add    $0x10,%esp
  800a16:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a19:	e8 7e 12 00 00       	call   801c9c <sys_enable_interrupt>
	return cnt;
  800a1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a21:	c9                   	leave  
  800a22:	c3                   	ret    

00800a23 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a23:	55                   	push   %ebp
  800a24:	89 e5                	mov    %esp,%ebp
  800a26:	53                   	push   %ebx
  800a27:	83 ec 14             	sub    $0x14,%esp
  800a2a:	8b 45 10             	mov    0x10(%ebp),%eax
  800a2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a30:	8b 45 14             	mov    0x14(%ebp),%eax
  800a33:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a36:	8b 45 18             	mov    0x18(%ebp),%eax
  800a39:	ba 00 00 00 00       	mov    $0x0,%edx
  800a3e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a41:	77 55                	ja     800a98 <printnum+0x75>
  800a43:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a46:	72 05                	jb     800a4d <printnum+0x2a>
  800a48:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a4b:	77 4b                	ja     800a98 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a4d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a50:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a53:	8b 45 18             	mov    0x18(%ebp),%eax
  800a56:	ba 00 00 00 00       	mov    $0x0,%edx
  800a5b:	52                   	push   %edx
  800a5c:	50                   	push   %eax
  800a5d:	ff 75 f4             	pushl  -0xc(%ebp)
  800a60:	ff 75 f0             	pushl  -0x10(%ebp)
  800a63:	e8 58 16 00 00       	call   8020c0 <__udivdi3>
  800a68:	83 c4 10             	add    $0x10,%esp
  800a6b:	83 ec 04             	sub    $0x4,%esp
  800a6e:	ff 75 20             	pushl  0x20(%ebp)
  800a71:	53                   	push   %ebx
  800a72:	ff 75 18             	pushl  0x18(%ebp)
  800a75:	52                   	push   %edx
  800a76:	50                   	push   %eax
  800a77:	ff 75 0c             	pushl  0xc(%ebp)
  800a7a:	ff 75 08             	pushl  0x8(%ebp)
  800a7d:	e8 a1 ff ff ff       	call   800a23 <printnum>
  800a82:	83 c4 20             	add    $0x20,%esp
  800a85:	eb 1a                	jmp    800aa1 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a87:	83 ec 08             	sub    $0x8,%esp
  800a8a:	ff 75 0c             	pushl  0xc(%ebp)
  800a8d:	ff 75 20             	pushl  0x20(%ebp)
  800a90:	8b 45 08             	mov    0x8(%ebp),%eax
  800a93:	ff d0                	call   *%eax
  800a95:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a98:	ff 4d 1c             	decl   0x1c(%ebp)
  800a9b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a9f:	7f e6                	jg     800a87 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800aa1:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800aa4:	bb 00 00 00 00       	mov    $0x0,%ebx
  800aa9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aac:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800aaf:	53                   	push   %ebx
  800ab0:	51                   	push   %ecx
  800ab1:	52                   	push   %edx
  800ab2:	50                   	push   %eax
  800ab3:	e8 18 17 00 00       	call   8021d0 <__umoddi3>
  800ab8:	83 c4 10             	add    $0x10,%esp
  800abb:	05 d4 28 80 00       	add    $0x8028d4,%eax
  800ac0:	8a 00                	mov    (%eax),%al
  800ac2:	0f be c0             	movsbl %al,%eax
  800ac5:	83 ec 08             	sub    $0x8,%esp
  800ac8:	ff 75 0c             	pushl  0xc(%ebp)
  800acb:	50                   	push   %eax
  800acc:	8b 45 08             	mov    0x8(%ebp),%eax
  800acf:	ff d0                	call   *%eax
  800ad1:	83 c4 10             	add    $0x10,%esp
}
  800ad4:	90                   	nop
  800ad5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ad8:	c9                   	leave  
  800ad9:	c3                   	ret    

00800ada <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ada:	55                   	push   %ebp
  800adb:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800add:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ae1:	7e 1c                	jle    800aff <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae6:	8b 00                	mov    (%eax),%eax
  800ae8:	8d 50 08             	lea    0x8(%eax),%edx
  800aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800aee:	89 10                	mov    %edx,(%eax)
  800af0:	8b 45 08             	mov    0x8(%ebp),%eax
  800af3:	8b 00                	mov    (%eax),%eax
  800af5:	83 e8 08             	sub    $0x8,%eax
  800af8:	8b 50 04             	mov    0x4(%eax),%edx
  800afb:	8b 00                	mov    (%eax),%eax
  800afd:	eb 40                	jmp    800b3f <getuint+0x65>
	else if (lflag)
  800aff:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b03:	74 1e                	je     800b23 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b05:	8b 45 08             	mov    0x8(%ebp),%eax
  800b08:	8b 00                	mov    (%eax),%eax
  800b0a:	8d 50 04             	lea    0x4(%eax),%edx
  800b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b10:	89 10                	mov    %edx,(%eax)
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	8b 00                	mov    (%eax),%eax
  800b17:	83 e8 04             	sub    $0x4,%eax
  800b1a:	8b 00                	mov    (%eax),%eax
  800b1c:	ba 00 00 00 00       	mov    $0x0,%edx
  800b21:	eb 1c                	jmp    800b3f <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b23:	8b 45 08             	mov    0x8(%ebp),%eax
  800b26:	8b 00                	mov    (%eax),%eax
  800b28:	8d 50 04             	lea    0x4(%eax),%edx
  800b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2e:	89 10                	mov    %edx,(%eax)
  800b30:	8b 45 08             	mov    0x8(%ebp),%eax
  800b33:	8b 00                	mov    (%eax),%eax
  800b35:	83 e8 04             	sub    $0x4,%eax
  800b38:	8b 00                	mov    (%eax),%eax
  800b3a:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b3f:	5d                   	pop    %ebp
  800b40:	c3                   	ret    

00800b41 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b41:	55                   	push   %ebp
  800b42:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b44:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b48:	7e 1c                	jle    800b66 <getint+0x25>
		return va_arg(*ap, long long);
  800b4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4d:	8b 00                	mov    (%eax),%eax
  800b4f:	8d 50 08             	lea    0x8(%eax),%edx
  800b52:	8b 45 08             	mov    0x8(%ebp),%eax
  800b55:	89 10                	mov    %edx,(%eax)
  800b57:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5a:	8b 00                	mov    (%eax),%eax
  800b5c:	83 e8 08             	sub    $0x8,%eax
  800b5f:	8b 50 04             	mov    0x4(%eax),%edx
  800b62:	8b 00                	mov    (%eax),%eax
  800b64:	eb 38                	jmp    800b9e <getint+0x5d>
	else if (lflag)
  800b66:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b6a:	74 1a                	je     800b86 <getint+0x45>
		return va_arg(*ap, long);
  800b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6f:	8b 00                	mov    (%eax),%eax
  800b71:	8d 50 04             	lea    0x4(%eax),%edx
  800b74:	8b 45 08             	mov    0x8(%ebp),%eax
  800b77:	89 10                	mov    %edx,(%eax)
  800b79:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7c:	8b 00                	mov    (%eax),%eax
  800b7e:	83 e8 04             	sub    $0x4,%eax
  800b81:	8b 00                	mov    (%eax),%eax
  800b83:	99                   	cltd   
  800b84:	eb 18                	jmp    800b9e <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b86:	8b 45 08             	mov    0x8(%ebp),%eax
  800b89:	8b 00                	mov    (%eax),%eax
  800b8b:	8d 50 04             	lea    0x4(%eax),%edx
  800b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b91:	89 10                	mov    %edx,(%eax)
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
  800b96:	8b 00                	mov    (%eax),%eax
  800b98:	83 e8 04             	sub    $0x4,%eax
  800b9b:	8b 00                	mov    (%eax),%eax
  800b9d:	99                   	cltd   
}
  800b9e:	5d                   	pop    %ebp
  800b9f:	c3                   	ret    

00800ba0 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800ba0:	55                   	push   %ebp
  800ba1:	89 e5                	mov    %esp,%ebp
  800ba3:	56                   	push   %esi
  800ba4:	53                   	push   %ebx
  800ba5:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ba8:	eb 17                	jmp    800bc1 <vprintfmt+0x21>
			if (ch == '\0')
  800baa:	85 db                	test   %ebx,%ebx
  800bac:	0f 84 af 03 00 00    	je     800f61 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bb2:	83 ec 08             	sub    $0x8,%esp
  800bb5:	ff 75 0c             	pushl  0xc(%ebp)
  800bb8:	53                   	push   %ebx
  800bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbc:	ff d0                	call   *%eax
  800bbe:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bc1:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc4:	8d 50 01             	lea    0x1(%eax),%edx
  800bc7:	89 55 10             	mov    %edx,0x10(%ebp)
  800bca:	8a 00                	mov    (%eax),%al
  800bcc:	0f b6 d8             	movzbl %al,%ebx
  800bcf:	83 fb 25             	cmp    $0x25,%ebx
  800bd2:	75 d6                	jne    800baa <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bd4:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bd8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bdf:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800be6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bed:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bf4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf7:	8d 50 01             	lea    0x1(%eax),%edx
  800bfa:	89 55 10             	mov    %edx,0x10(%ebp)
  800bfd:	8a 00                	mov    (%eax),%al
  800bff:	0f b6 d8             	movzbl %al,%ebx
  800c02:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c05:	83 f8 55             	cmp    $0x55,%eax
  800c08:	0f 87 2b 03 00 00    	ja     800f39 <vprintfmt+0x399>
  800c0e:	8b 04 85 f8 28 80 00 	mov    0x8028f8(,%eax,4),%eax
  800c15:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c17:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c1b:	eb d7                	jmp    800bf4 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c1d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c21:	eb d1                	jmp    800bf4 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c23:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c2a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c2d:	89 d0                	mov    %edx,%eax
  800c2f:	c1 e0 02             	shl    $0x2,%eax
  800c32:	01 d0                	add    %edx,%eax
  800c34:	01 c0                	add    %eax,%eax
  800c36:	01 d8                	add    %ebx,%eax
  800c38:	83 e8 30             	sub    $0x30,%eax
  800c3b:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c3e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c41:	8a 00                	mov    (%eax),%al
  800c43:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c46:	83 fb 2f             	cmp    $0x2f,%ebx
  800c49:	7e 3e                	jle    800c89 <vprintfmt+0xe9>
  800c4b:	83 fb 39             	cmp    $0x39,%ebx
  800c4e:	7f 39                	jg     800c89 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c50:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c53:	eb d5                	jmp    800c2a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c55:	8b 45 14             	mov    0x14(%ebp),%eax
  800c58:	83 c0 04             	add    $0x4,%eax
  800c5b:	89 45 14             	mov    %eax,0x14(%ebp)
  800c5e:	8b 45 14             	mov    0x14(%ebp),%eax
  800c61:	83 e8 04             	sub    $0x4,%eax
  800c64:	8b 00                	mov    (%eax),%eax
  800c66:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c69:	eb 1f                	jmp    800c8a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c6b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c6f:	79 83                	jns    800bf4 <vprintfmt+0x54>
				width = 0;
  800c71:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c78:	e9 77 ff ff ff       	jmp    800bf4 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c7d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c84:	e9 6b ff ff ff       	jmp    800bf4 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c89:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c8a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c8e:	0f 89 60 ff ff ff    	jns    800bf4 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c94:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c97:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c9a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800ca1:	e9 4e ff ff ff       	jmp    800bf4 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ca6:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800ca9:	e9 46 ff ff ff       	jmp    800bf4 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cae:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb1:	83 c0 04             	add    $0x4,%eax
  800cb4:	89 45 14             	mov    %eax,0x14(%ebp)
  800cb7:	8b 45 14             	mov    0x14(%ebp),%eax
  800cba:	83 e8 04             	sub    $0x4,%eax
  800cbd:	8b 00                	mov    (%eax),%eax
  800cbf:	83 ec 08             	sub    $0x8,%esp
  800cc2:	ff 75 0c             	pushl  0xc(%ebp)
  800cc5:	50                   	push   %eax
  800cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc9:	ff d0                	call   *%eax
  800ccb:	83 c4 10             	add    $0x10,%esp
			break;
  800cce:	e9 89 02 00 00       	jmp    800f5c <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cd3:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd6:	83 c0 04             	add    $0x4,%eax
  800cd9:	89 45 14             	mov    %eax,0x14(%ebp)
  800cdc:	8b 45 14             	mov    0x14(%ebp),%eax
  800cdf:	83 e8 04             	sub    $0x4,%eax
  800ce2:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ce4:	85 db                	test   %ebx,%ebx
  800ce6:	79 02                	jns    800cea <vprintfmt+0x14a>
				err = -err;
  800ce8:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cea:	83 fb 64             	cmp    $0x64,%ebx
  800ced:	7f 0b                	jg     800cfa <vprintfmt+0x15a>
  800cef:	8b 34 9d 40 27 80 00 	mov    0x802740(,%ebx,4),%esi
  800cf6:	85 f6                	test   %esi,%esi
  800cf8:	75 19                	jne    800d13 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cfa:	53                   	push   %ebx
  800cfb:	68 e5 28 80 00       	push   $0x8028e5
  800d00:	ff 75 0c             	pushl  0xc(%ebp)
  800d03:	ff 75 08             	pushl  0x8(%ebp)
  800d06:	e8 5e 02 00 00       	call   800f69 <printfmt>
  800d0b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d0e:	e9 49 02 00 00       	jmp    800f5c <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d13:	56                   	push   %esi
  800d14:	68 ee 28 80 00       	push   $0x8028ee
  800d19:	ff 75 0c             	pushl  0xc(%ebp)
  800d1c:	ff 75 08             	pushl  0x8(%ebp)
  800d1f:	e8 45 02 00 00       	call   800f69 <printfmt>
  800d24:	83 c4 10             	add    $0x10,%esp
			break;
  800d27:	e9 30 02 00 00       	jmp    800f5c <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d2c:	8b 45 14             	mov    0x14(%ebp),%eax
  800d2f:	83 c0 04             	add    $0x4,%eax
  800d32:	89 45 14             	mov    %eax,0x14(%ebp)
  800d35:	8b 45 14             	mov    0x14(%ebp),%eax
  800d38:	83 e8 04             	sub    $0x4,%eax
  800d3b:	8b 30                	mov    (%eax),%esi
  800d3d:	85 f6                	test   %esi,%esi
  800d3f:	75 05                	jne    800d46 <vprintfmt+0x1a6>
				p = "(null)";
  800d41:	be f1 28 80 00       	mov    $0x8028f1,%esi
			if (width > 0 && padc != '-')
  800d46:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d4a:	7e 6d                	jle    800db9 <vprintfmt+0x219>
  800d4c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d50:	74 67                	je     800db9 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d52:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d55:	83 ec 08             	sub    $0x8,%esp
  800d58:	50                   	push   %eax
  800d59:	56                   	push   %esi
  800d5a:	e8 12 05 00 00       	call   801271 <strnlen>
  800d5f:	83 c4 10             	add    $0x10,%esp
  800d62:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d65:	eb 16                	jmp    800d7d <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d67:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d6b:	83 ec 08             	sub    $0x8,%esp
  800d6e:	ff 75 0c             	pushl  0xc(%ebp)
  800d71:	50                   	push   %eax
  800d72:	8b 45 08             	mov    0x8(%ebp),%eax
  800d75:	ff d0                	call   *%eax
  800d77:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d7a:	ff 4d e4             	decl   -0x1c(%ebp)
  800d7d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d81:	7f e4                	jg     800d67 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d83:	eb 34                	jmp    800db9 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d85:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d89:	74 1c                	je     800da7 <vprintfmt+0x207>
  800d8b:	83 fb 1f             	cmp    $0x1f,%ebx
  800d8e:	7e 05                	jle    800d95 <vprintfmt+0x1f5>
  800d90:	83 fb 7e             	cmp    $0x7e,%ebx
  800d93:	7e 12                	jle    800da7 <vprintfmt+0x207>
					putch('?', putdat);
  800d95:	83 ec 08             	sub    $0x8,%esp
  800d98:	ff 75 0c             	pushl  0xc(%ebp)
  800d9b:	6a 3f                	push   $0x3f
  800d9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800da0:	ff d0                	call   *%eax
  800da2:	83 c4 10             	add    $0x10,%esp
  800da5:	eb 0f                	jmp    800db6 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800da7:	83 ec 08             	sub    $0x8,%esp
  800daa:	ff 75 0c             	pushl  0xc(%ebp)
  800dad:	53                   	push   %ebx
  800dae:	8b 45 08             	mov    0x8(%ebp),%eax
  800db1:	ff d0                	call   *%eax
  800db3:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800db6:	ff 4d e4             	decl   -0x1c(%ebp)
  800db9:	89 f0                	mov    %esi,%eax
  800dbb:	8d 70 01             	lea    0x1(%eax),%esi
  800dbe:	8a 00                	mov    (%eax),%al
  800dc0:	0f be d8             	movsbl %al,%ebx
  800dc3:	85 db                	test   %ebx,%ebx
  800dc5:	74 24                	je     800deb <vprintfmt+0x24b>
  800dc7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dcb:	78 b8                	js     800d85 <vprintfmt+0x1e5>
  800dcd:	ff 4d e0             	decl   -0x20(%ebp)
  800dd0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dd4:	79 af                	jns    800d85 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dd6:	eb 13                	jmp    800deb <vprintfmt+0x24b>
				putch(' ', putdat);
  800dd8:	83 ec 08             	sub    $0x8,%esp
  800ddb:	ff 75 0c             	pushl  0xc(%ebp)
  800dde:	6a 20                	push   $0x20
  800de0:	8b 45 08             	mov    0x8(%ebp),%eax
  800de3:	ff d0                	call   *%eax
  800de5:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800de8:	ff 4d e4             	decl   -0x1c(%ebp)
  800deb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800def:	7f e7                	jg     800dd8 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800df1:	e9 66 01 00 00       	jmp    800f5c <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800df6:	83 ec 08             	sub    $0x8,%esp
  800df9:	ff 75 e8             	pushl  -0x18(%ebp)
  800dfc:	8d 45 14             	lea    0x14(%ebp),%eax
  800dff:	50                   	push   %eax
  800e00:	e8 3c fd ff ff       	call   800b41 <getint>
  800e05:	83 c4 10             	add    $0x10,%esp
  800e08:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e0b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e11:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e14:	85 d2                	test   %edx,%edx
  800e16:	79 23                	jns    800e3b <vprintfmt+0x29b>
				putch('-', putdat);
  800e18:	83 ec 08             	sub    $0x8,%esp
  800e1b:	ff 75 0c             	pushl  0xc(%ebp)
  800e1e:	6a 2d                	push   $0x2d
  800e20:	8b 45 08             	mov    0x8(%ebp),%eax
  800e23:	ff d0                	call   *%eax
  800e25:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e28:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e2b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e2e:	f7 d8                	neg    %eax
  800e30:	83 d2 00             	adc    $0x0,%edx
  800e33:	f7 da                	neg    %edx
  800e35:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e38:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e3b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e42:	e9 bc 00 00 00       	jmp    800f03 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e47:	83 ec 08             	sub    $0x8,%esp
  800e4a:	ff 75 e8             	pushl  -0x18(%ebp)
  800e4d:	8d 45 14             	lea    0x14(%ebp),%eax
  800e50:	50                   	push   %eax
  800e51:	e8 84 fc ff ff       	call   800ada <getuint>
  800e56:	83 c4 10             	add    $0x10,%esp
  800e59:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e5c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e5f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e66:	e9 98 00 00 00       	jmp    800f03 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e6b:	83 ec 08             	sub    $0x8,%esp
  800e6e:	ff 75 0c             	pushl  0xc(%ebp)
  800e71:	6a 58                	push   $0x58
  800e73:	8b 45 08             	mov    0x8(%ebp),%eax
  800e76:	ff d0                	call   *%eax
  800e78:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e7b:	83 ec 08             	sub    $0x8,%esp
  800e7e:	ff 75 0c             	pushl  0xc(%ebp)
  800e81:	6a 58                	push   $0x58
  800e83:	8b 45 08             	mov    0x8(%ebp),%eax
  800e86:	ff d0                	call   *%eax
  800e88:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e8b:	83 ec 08             	sub    $0x8,%esp
  800e8e:	ff 75 0c             	pushl  0xc(%ebp)
  800e91:	6a 58                	push   $0x58
  800e93:	8b 45 08             	mov    0x8(%ebp),%eax
  800e96:	ff d0                	call   *%eax
  800e98:	83 c4 10             	add    $0x10,%esp
			break;
  800e9b:	e9 bc 00 00 00       	jmp    800f5c <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ea0:	83 ec 08             	sub    $0x8,%esp
  800ea3:	ff 75 0c             	pushl  0xc(%ebp)
  800ea6:	6a 30                	push   $0x30
  800ea8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eab:	ff d0                	call   *%eax
  800ead:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800eb0:	83 ec 08             	sub    $0x8,%esp
  800eb3:	ff 75 0c             	pushl  0xc(%ebp)
  800eb6:	6a 78                	push   $0x78
  800eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebb:	ff d0                	call   *%eax
  800ebd:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ec0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec3:	83 c0 04             	add    $0x4,%eax
  800ec6:	89 45 14             	mov    %eax,0x14(%ebp)
  800ec9:	8b 45 14             	mov    0x14(%ebp),%eax
  800ecc:	83 e8 04             	sub    $0x4,%eax
  800ecf:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ed1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ed4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800edb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ee2:	eb 1f                	jmp    800f03 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ee4:	83 ec 08             	sub    $0x8,%esp
  800ee7:	ff 75 e8             	pushl  -0x18(%ebp)
  800eea:	8d 45 14             	lea    0x14(%ebp),%eax
  800eed:	50                   	push   %eax
  800eee:	e8 e7 fb ff ff       	call   800ada <getuint>
  800ef3:	83 c4 10             	add    $0x10,%esp
  800ef6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ef9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800efc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f03:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f07:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f0a:	83 ec 04             	sub    $0x4,%esp
  800f0d:	52                   	push   %edx
  800f0e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f11:	50                   	push   %eax
  800f12:	ff 75 f4             	pushl  -0xc(%ebp)
  800f15:	ff 75 f0             	pushl  -0x10(%ebp)
  800f18:	ff 75 0c             	pushl  0xc(%ebp)
  800f1b:	ff 75 08             	pushl  0x8(%ebp)
  800f1e:	e8 00 fb ff ff       	call   800a23 <printnum>
  800f23:	83 c4 20             	add    $0x20,%esp
			break;
  800f26:	eb 34                	jmp    800f5c <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f28:	83 ec 08             	sub    $0x8,%esp
  800f2b:	ff 75 0c             	pushl  0xc(%ebp)
  800f2e:	53                   	push   %ebx
  800f2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f32:	ff d0                	call   *%eax
  800f34:	83 c4 10             	add    $0x10,%esp
			break;
  800f37:	eb 23                	jmp    800f5c <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f39:	83 ec 08             	sub    $0x8,%esp
  800f3c:	ff 75 0c             	pushl  0xc(%ebp)
  800f3f:	6a 25                	push   $0x25
  800f41:	8b 45 08             	mov    0x8(%ebp),%eax
  800f44:	ff d0                	call   *%eax
  800f46:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f49:	ff 4d 10             	decl   0x10(%ebp)
  800f4c:	eb 03                	jmp    800f51 <vprintfmt+0x3b1>
  800f4e:	ff 4d 10             	decl   0x10(%ebp)
  800f51:	8b 45 10             	mov    0x10(%ebp),%eax
  800f54:	48                   	dec    %eax
  800f55:	8a 00                	mov    (%eax),%al
  800f57:	3c 25                	cmp    $0x25,%al
  800f59:	75 f3                	jne    800f4e <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f5b:	90                   	nop
		}
	}
  800f5c:	e9 47 fc ff ff       	jmp    800ba8 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f61:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f62:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f65:	5b                   	pop    %ebx
  800f66:	5e                   	pop    %esi
  800f67:	5d                   	pop    %ebp
  800f68:	c3                   	ret    

00800f69 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f69:	55                   	push   %ebp
  800f6a:	89 e5                	mov    %esp,%ebp
  800f6c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f6f:	8d 45 10             	lea    0x10(%ebp),%eax
  800f72:	83 c0 04             	add    $0x4,%eax
  800f75:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f78:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7b:	ff 75 f4             	pushl  -0xc(%ebp)
  800f7e:	50                   	push   %eax
  800f7f:	ff 75 0c             	pushl  0xc(%ebp)
  800f82:	ff 75 08             	pushl  0x8(%ebp)
  800f85:	e8 16 fc ff ff       	call   800ba0 <vprintfmt>
  800f8a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f8d:	90                   	nop
  800f8e:	c9                   	leave  
  800f8f:	c3                   	ret    

00800f90 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f90:	55                   	push   %ebp
  800f91:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f96:	8b 40 08             	mov    0x8(%eax),%eax
  800f99:	8d 50 01             	lea    0x1(%eax),%edx
  800f9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fa2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa5:	8b 10                	mov    (%eax),%edx
  800fa7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800faa:	8b 40 04             	mov    0x4(%eax),%eax
  800fad:	39 c2                	cmp    %eax,%edx
  800faf:	73 12                	jae    800fc3 <sprintputch+0x33>
		*b->buf++ = ch;
  800fb1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb4:	8b 00                	mov    (%eax),%eax
  800fb6:	8d 48 01             	lea    0x1(%eax),%ecx
  800fb9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fbc:	89 0a                	mov    %ecx,(%edx)
  800fbe:	8b 55 08             	mov    0x8(%ebp),%edx
  800fc1:	88 10                	mov    %dl,(%eax)
}
  800fc3:	90                   	nop
  800fc4:	5d                   	pop    %ebp
  800fc5:	c3                   	ret    

00800fc6 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fc6:	55                   	push   %ebp
  800fc7:	89 e5                	mov    %esp,%ebp
  800fc9:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcf:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fd2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdb:	01 d0                	add    %edx,%eax
  800fdd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fe7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800feb:	74 06                	je     800ff3 <vsnprintf+0x2d>
  800fed:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ff1:	7f 07                	jg     800ffa <vsnprintf+0x34>
		return -E_INVAL;
  800ff3:	b8 03 00 00 00       	mov    $0x3,%eax
  800ff8:	eb 20                	jmp    80101a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ffa:	ff 75 14             	pushl  0x14(%ebp)
  800ffd:	ff 75 10             	pushl  0x10(%ebp)
  801000:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801003:	50                   	push   %eax
  801004:	68 90 0f 80 00       	push   $0x800f90
  801009:	e8 92 fb ff ff       	call   800ba0 <vprintfmt>
  80100e:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801011:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801014:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801017:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80101a:	c9                   	leave  
  80101b:	c3                   	ret    

0080101c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80101c:	55                   	push   %ebp
  80101d:	89 e5                	mov    %esp,%ebp
  80101f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801022:	8d 45 10             	lea    0x10(%ebp),%eax
  801025:	83 c0 04             	add    $0x4,%eax
  801028:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80102b:	8b 45 10             	mov    0x10(%ebp),%eax
  80102e:	ff 75 f4             	pushl  -0xc(%ebp)
  801031:	50                   	push   %eax
  801032:	ff 75 0c             	pushl  0xc(%ebp)
  801035:	ff 75 08             	pushl  0x8(%ebp)
  801038:	e8 89 ff ff ff       	call   800fc6 <vsnprintf>
  80103d:	83 c4 10             	add    $0x10,%esp
  801040:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801043:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801046:	c9                   	leave  
  801047:	c3                   	ret    

00801048 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801048:	55                   	push   %ebp
  801049:	89 e5                	mov    %esp,%ebp
  80104b:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80104e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801052:	74 13                	je     801067 <readline+0x1f>
		cprintf("%s", prompt);
  801054:	83 ec 08             	sub    $0x8,%esp
  801057:	ff 75 08             	pushl  0x8(%ebp)
  80105a:	68 50 2a 80 00       	push   $0x802a50
  80105f:	e8 62 f9 ff ff       	call   8009c6 <cprintf>
  801064:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801067:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80106e:	83 ec 0c             	sub    $0xc,%esp
  801071:	6a 00                	push   $0x0
  801073:	e8 68 f5 ff ff       	call   8005e0 <iscons>
  801078:	83 c4 10             	add    $0x10,%esp
  80107b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80107e:	e8 0f f5 ff ff       	call   800592 <getchar>
  801083:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801086:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80108a:	79 22                	jns    8010ae <readline+0x66>
			if (c != -E_EOF)
  80108c:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801090:	0f 84 ad 00 00 00    	je     801143 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801096:	83 ec 08             	sub    $0x8,%esp
  801099:	ff 75 ec             	pushl  -0x14(%ebp)
  80109c:	68 53 2a 80 00       	push   $0x802a53
  8010a1:	e8 20 f9 ff ff       	call   8009c6 <cprintf>
  8010a6:	83 c4 10             	add    $0x10,%esp
			return;
  8010a9:	e9 95 00 00 00       	jmp    801143 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8010ae:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8010b2:	7e 34                	jle    8010e8 <readline+0xa0>
  8010b4:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8010bb:	7f 2b                	jg     8010e8 <readline+0xa0>
			if (echoing)
  8010bd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010c1:	74 0e                	je     8010d1 <readline+0x89>
				cputchar(c);
  8010c3:	83 ec 0c             	sub    $0xc,%esp
  8010c6:	ff 75 ec             	pushl  -0x14(%ebp)
  8010c9:	e8 7c f4 ff ff       	call   80054a <cputchar>
  8010ce:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8010d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010d4:	8d 50 01             	lea    0x1(%eax),%edx
  8010d7:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8010da:	89 c2                	mov    %eax,%edx
  8010dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010df:	01 d0                	add    %edx,%eax
  8010e1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010e4:	88 10                	mov    %dl,(%eax)
  8010e6:	eb 56                	jmp    80113e <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8010e8:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8010ec:	75 1f                	jne    80110d <readline+0xc5>
  8010ee:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8010f2:	7e 19                	jle    80110d <readline+0xc5>
			if (echoing)
  8010f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010f8:	74 0e                	je     801108 <readline+0xc0>
				cputchar(c);
  8010fa:	83 ec 0c             	sub    $0xc,%esp
  8010fd:	ff 75 ec             	pushl  -0x14(%ebp)
  801100:	e8 45 f4 ff ff       	call   80054a <cputchar>
  801105:	83 c4 10             	add    $0x10,%esp

			i--;
  801108:	ff 4d f4             	decl   -0xc(%ebp)
  80110b:	eb 31                	jmp    80113e <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  80110d:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801111:	74 0a                	je     80111d <readline+0xd5>
  801113:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801117:	0f 85 61 ff ff ff    	jne    80107e <readline+0x36>
			if (echoing)
  80111d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801121:	74 0e                	je     801131 <readline+0xe9>
				cputchar(c);
  801123:	83 ec 0c             	sub    $0xc,%esp
  801126:	ff 75 ec             	pushl  -0x14(%ebp)
  801129:	e8 1c f4 ff ff       	call   80054a <cputchar>
  80112e:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801131:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801134:	8b 45 0c             	mov    0xc(%ebp),%eax
  801137:	01 d0                	add    %edx,%eax
  801139:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80113c:	eb 06                	jmp    801144 <readline+0xfc>
		}
	}
  80113e:	e9 3b ff ff ff       	jmp    80107e <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801143:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801144:	c9                   	leave  
  801145:	c3                   	ret    

00801146 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801146:	55                   	push   %ebp
  801147:	89 e5                	mov    %esp,%ebp
  801149:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80114c:	e8 31 0b 00 00       	call   801c82 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801151:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801155:	74 13                	je     80116a <atomic_readline+0x24>
		cprintf("%s", prompt);
  801157:	83 ec 08             	sub    $0x8,%esp
  80115a:	ff 75 08             	pushl  0x8(%ebp)
  80115d:	68 50 2a 80 00       	push   $0x802a50
  801162:	e8 5f f8 ff ff       	call   8009c6 <cprintf>
  801167:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80116a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801171:	83 ec 0c             	sub    $0xc,%esp
  801174:	6a 00                	push   $0x0
  801176:	e8 65 f4 ff ff       	call   8005e0 <iscons>
  80117b:	83 c4 10             	add    $0x10,%esp
  80117e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801181:	e8 0c f4 ff ff       	call   800592 <getchar>
  801186:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801189:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80118d:	79 23                	jns    8011b2 <atomic_readline+0x6c>
			if (c != -E_EOF)
  80118f:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801193:	74 13                	je     8011a8 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801195:	83 ec 08             	sub    $0x8,%esp
  801198:	ff 75 ec             	pushl  -0x14(%ebp)
  80119b:	68 53 2a 80 00       	push   $0x802a53
  8011a0:	e8 21 f8 ff ff       	call   8009c6 <cprintf>
  8011a5:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011a8:	e8 ef 0a 00 00       	call   801c9c <sys_enable_interrupt>
			return;
  8011ad:	e9 9a 00 00 00       	jmp    80124c <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011b2:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011b6:	7e 34                	jle    8011ec <atomic_readline+0xa6>
  8011b8:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011bf:	7f 2b                	jg     8011ec <atomic_readline+0xa6>
			if (echoing)
  8011c1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011c5:	74 0e                	je     8011d5 <atomic_readline+0x8f>
				cputchar(c);
  8011c7:	83 ec 0c             	sub    $0xc,%esp
  8011ca:	ff 75 ec             	pushl  -0x14(%ebp)
  8011cd:	e8 78 f3 ff ff       	call   80054a <cputchar>
  8011d2:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011d8:	8d 50 01             	lea    0x1(%eax),%edx
  8011db:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011de:	89 c2                	mov    %eax,%edx
  8011e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e3:	01 d0                	add    %edx,%eax
  8011e5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011e8:	88 10                	mov    %dl,(%eax)
  8011ea:	eb 5b                	jmp    801247 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8011ec:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011f0:	75 1f                	jne    801211 <atomic_readline+0xcb>
  8011f2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011f6:	7e 19                	jle    801211 <atomic_readline+0xcb>
			if (echoing)
  8011f8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011fc:	74 0e                	je     80120c <atomic_readline+0xc6>
				cputchar(c);
  8011fe:	83 ec 0c             	sub    $0xc,%esp
  801201:	ff 75 ec             	pushl  -0x14(%ebp)
  801204:	e8 41 f3 ff ff       	call   80054a <cputchar>
  801209:	83 c4 10             	add    $0x10,%esp
			i--;
  80120c:	ff 4d f4             	decl   -0xc(%ebp)
  80120f:	eb 36                	jmp    801247 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801211:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801215:	74 0a                	je     801221 <atomic_readline+0xdb>
  801217:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80121b:	0f 85 60 ff ff ff    	jne    801181 <atomic_readline+0x3b>
			if (echoing)
  801221:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801225:	74 0e                	je     801235 <atomic_readline+0xef>
				cputchar(c);
  801227:	83 ec 0c             	sub    $0xc,%esp
  80122a:	ff 75 ec             	pushl  -0x14(%ebp)
  80122d:	e8 18 f3 ff ff       	call   80054a <cputchar>
  801232:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801235:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801238:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123b:	01 d0                	add    %edx,%eax
  80123d:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801240:	e8 57 0a 00 00       	call   801c9c <sys_enable_interrupt>
			return;
  801245:	eb 05                	jmp    80124c <atomic_readline+0x106>
		}
	}
  801247:	e9 35 ff ff ff       	jmp    801181 <atomic_readline+0x3b>
}
  80124c:	c9                   	leave  
  80124d:	c3                   	ret    

0080124e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80124e:	55                   	push   %ebp
  80124f:	89 e5                	mov    %esp,%ebp
  801251:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801254:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80125b:	eb 06                	jmp    801263 <strlen+0x15>
		n++;
  80125d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801260:	ff 45 08             	incl   0x8(%ebp)
  801263:	8b 45 08             	mov    0x8(%ebp),%eax
  801266:	8a 00                	mov    (%eax),%al
  801268:	84 c0                	test   %al,%al
  80126a:	75 f1                	jne    80125d <strlen+0xf>
		n++;
	return n;
  80126c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80126f:	c9                   	leave  
  801270:	c3                   	ret    

00801271 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801271:	55                   	push   %ebp
  801272:	89 e5                	mov    %esp,%ebp
  801274:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801277:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80127e:	eb 09                	jmp    801289 <strnlen+0x18>
		n++;
  801280:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801283:	ff 45 08             	incl   0x8(%ebp)
  801286:	ff 4d 0c             	decl   0xc(%ebp)
  801289:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80128d:	74 09                	je     801298 <strnlen+0x27>
  80128f:	8b 45 08             	mov    0x8(%ebp),%eax
  801292:	8a 00                	mov    (%eax),%al
  801294:	84 c0                	test   %al,%al
  801296:	75 e8                	jne    801280 <strnlen+0xf>
		n++;
	return n;
  801298:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80129b:	c9                   	leave  
  80129c:	c3                   	ret    

0080129d <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80129d:	55                   	push   %ebp
  80129e:	89 e5                	mov    %esp,%ebp
  8012a0:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8012a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012a9:	90                   	nop
  8012aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ad:	8d 50 01             	lea    0x1(%eax),%edx
  8012b0:	89 55 08             	mov    %edx,0x8(%ebp)
  8012b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012b9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012bc:	8a 12                	mov    (%edx),%dl
  8012be:	88 10                	mov    %dl,(%eax)
  8012c0:	8a 00                	mov    (%eax),%al
  8012c2:	84 c0                	test   %al,%al
  8012c4:	75 e4                	jne    8012aa <strcpy+0xd>
		/* do nothing */;
	return ret;
  8012c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012c9:	c9                   	leave  
  8012ca:	c3                   	ret    

008012cb <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012cb:	55                   	push   %ebp
  8012cc:	89 e5                	mov    %esp,%ebp
  8012ce:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012d7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012de:	eb 1f                	jmp    8012ff <strncpy+0x34>
		*dst++ = *src;
  8012e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e3:	8d 50 01             	lea    0x1(%eax),%edx
  8012e6:	89 55 08             	mov    %edx,0x8(%ebp)
  8012e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ec:	8a 12                	mov    (%edx),%dl
  8012ee:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f3:	8a 00                	mov    (%eax),%al
  8012f5:	84 c0                	test   %al,%al
  8012f7:	74 03                	je     8012fc <strncpy+0x31>
			src++;
  8012f9:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012fc:	ff 45 fc             	incl   -0x4(%ebp)
  8012ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801302:	3b 45 10             	cmp    0x10(%ebp),%eax
  801305:	72 d9                	jb     8012e0 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801307:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80130a:	c9                   	leave  
  80130b:	c3                   	ret    

0080130c <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80130c:	55                   	push   %ebp
  80130d:	89 e5                	mov    %esp,%ebp
  80130f:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801312:	8b 45 08             	mov    0x8(%ebp),%eax
  801315:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801318:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80131c:	74 30                	je     80134e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80131e:	eb 16                	jmp    801336 <strlcpy+0x2a>
			*dst++ = *src++;
  801320:	8b 45 08             	mov    0x8(%ebp),%eax
  801323:	8d 50 01             	lea    0x1(%eax),%edx
  801326:	89 55 08             	mov    %edx,0x8(%ebp)
  801329:	8b 55 0c             	mov    0xc(%ebp),%edx
  80132c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80132f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801332:	8a 12                	mov    (%edx),%dl
  801334:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801336:	ff 4d 10             	decl   0x10(%ebp)
  801339:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80133d:	74 09                	je     801348 <strlcpy+0x3c>
  80133f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801342:	8a 00                	mov    (%eax),%al
  801344:	84 c0                	test   %al,%al
  801346:	75 d8                	jne    801320 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801348:	8b 45 08             	mov    0x8(%ebp),%eax
  80134b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80134e:	8b 55 08             	mov    0x8(%ebp),%edx
  801351:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801354:	29 c2                	sub    %eax,%edx
  801356:	89 d0                	mov    %edx,%eax
}
  801358:	c9                   	leave  
  801359:	c3                   	ret    

0080135a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80135a:	55                   	push   %ebp
  80135b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80135d:	eb 06                	jmp    801365 <strcmp+0xb>
		p++, q++;
  80135f:	ff 45 08             	incl   0x8(%ebp)
  801362:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801365:	8b 45 08             	mov    0x8(%ebp),%eax
  801368:	8a 00                	mov    (%eax),%al
  80136a:	84 c0                	test   %al,%al
  80136c:	74 0e                	je     80137c <strcmp+0x22>
  80136e:	8b 45 08             	mov    0x8(%ebp),%eax
  801371:	8a 10                	mov    (%eax),%dl
  801373:	8b 45 0c             	mov    0xc(%ebp),%eax
  801376:	8a 00                	mov    (%eax),%al
  801378:	38 c2                	cmp    %al,%dl
  80137a:	74 e3                	je     80135f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80137c:	8b 45 08             	mov    0x8(%ebp),%eax
  80137f:	8a 00                	mov    (%eax),%al
  801381:	0f b6 d0             	movzbl %al,%edx
  801384:	8b 45 0c             	mov    0xc(%ebp),%eax
  801387:	8a 00                	mov    (%eax),%al
  801389:	0f b6 c0             	movzbl %al,%eax
  80138c:	29 c2                	sub    %eax,%edx
  80138e:	89 d0                	mov    %edx,%eax
}
  801390:	5d                   	pop    %ebp
  801391:	c3                   	ret    

00801392 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801392:	55                   	push   %ebp
  801393:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801395:	eb 09                	jmp    8013a0 <strncmp+0xe>
		n--, p++, q++;
  801397:	ff 4d 10             	decl   0x10(%ebp)
  80139a:	ff 45 08             	incl   0x8(%ebp)
  80139d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013a0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013a4:	74 17                	je     8013bd <strncmp+0x2b>
  8013a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a9:	8a 00                	mov    (%eax),%al
  8013ab:	84 c0                	test   %al,%al
  8013ad:	74 0e                	je     8013bd <strncmp+0x2b>
  8013af:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b2:	8a 10                	mov    (%eax),%dl
  8013b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b7:	8a 00                	mov    (%eax),%al
  8013b9:	38 c2                	cmp    %al,%dl
  8013bb:	74 da                	je     801397 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013bd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013c1:	75 07                	jne    8013ca <strncmp+0x38>
		return 0;
  8013c3:	b8 00 00 00 00       	mov    $0x0,%eax
  8013c8:	eb 14                	jmp    8013de <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	8a 00                	mov    (%eax),%al
  8013cf:	0f b6 d0             	movzbl %al,%edx
  8013d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d5:	8a 00                	mov    (%eax),%al
  8013d7:	0f b6 c0             	movzbl %al,%eax
  8013da:	29 c2                	sub    %eax,%edx
  8013dc:	89 d0                	mov    %edx,%eax
}
  8013de:	5d                   	pop    %ebp
  8013df:	c3                   	ret    

008013e0 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013e0:	55                   	push   %ebp
  8013e1:	89 e5                	mov    %esp,%ebp
  8013e3:	83 ec 04             	sub    $0x4,%esp
  8013e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e9:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013ec:	eb 12                	jmp    801400 <strchr+0x20>
		if (*s == c)
  8013ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f1:	8a 00                	mov    (%eax),%al
  8013f3:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013f6:	75 05                	jne    8013fd <strchr+0x1d>
			return (char *) s;
  8013f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fb:	eb 11                	jmp    80140e <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013fd:	ff 45 08             	incl   0x8(%ebp)
  801400:	8b 45 08             	mov    0x8(%ebp),%eax
  801403:	8a 00                	mov    (%eax),%al
  801405:	84 c0                	test   %al,%al
  801407:	75 e5                	jne    8013ee <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801409:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80140e:	c9                   	leave  
  80140f:	c3                   	ret    

00801410 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801410:	55                   	push   %ebp
  801411:	89 e5                	mov    %esp,%ebp
  801413:	83 ec 04             	sub    $0x4,%esp
  801416:	8b 45 0c             	mov    0xc(%ebp),%eax
  801419:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80141c:	eb 0d                	jmp    80142b <strfind+0x1b>
		if (*s == c)
  80141e:	8b 45 08             	mov    0x8(%ebp),%eax
  801421:	8a 00                	mov    (%eax),%al
  801423:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801426:	74 0e                	je     801436 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801428:	ff 45 08             	incl   0x8(%ebp)
  80142b:	8b 45 08             	mov    0x8(%ebp),%eax
  80142e:	8a 00                	mov    (%eax),%al
  801430:	84 c0                	test   %al,%al
  801432:	75 ea                	jne    80141e <strfind+0xe>
  801434:	eb 01                	jmp    801437 <strfind+0x27>
		if (*s == c)
			break;
  801436:	90                   	nop
	return (char *) s;
  801437:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80143a:	c9                   	leave  
  80143b:	c3                   	ret    

0080143c <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80143c:	55                   	push   %ebp
  80143d:	89 e5                	mov    %esp,%ebp
  80143f:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801442:	8b 45 08             	mov    0x8(%ebp),%eax
  801445:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801448:	8b 45 10             	mov    0x10(%ebp),%eax
  80144b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80144e:	eb 0e                	jmp    80145e <memset+0x22>
		*p++ = c;
  801450:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801453:	8d 50 01             	lea    0x1(%eax),%edx
  801456:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801459:	8b 55 0c             	mov    0xc(%ebp),%edx
  80145c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80145e:	ff 4d f8             	decl   -0x8(%ebp)
  801461:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801465:	79 e9                	jns    801450 <memset+0x14>
		*p++ = c;

	return v;
  801467:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80146a:	c9                   	leave  
  80146b:	c3                   	ret    

0080146c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80146c:	55                   	push   %ebp
  80146d:	89 e5                	mov    %esp,%ebp
  80146f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801472:	8b 45 0c             	mov    0xc(%ebp),%eax
  801475:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801478:	8b 45 08             	mov    0x8(%ebp),%eax
  80147b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80147e:	eb 16                	jmp    801496 <memcpy+0x2a>
		*d++ = *s++;
  801480:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801483:	8d 50 01             	lea    0x1(%eax),%edx
  801486:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801489:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80148c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80148f:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801492:	8a 12                	mov    (%edx),%dl
  801494:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801496:	8b 45 10             	mov    0x10(%ebp),%eax
  801499:	8d 50 ff             	lea    -0x1(%eax),%edx
  80149c:	89 55 10             	mov    %edx,0x10(%ebp)
  80149f:	85 c0                	test   %eax,%eax
  8014a1:	75 dd                	jne    801480 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8014a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014a6:	c9                   	leave  
  8014a7:	c3                   	ret    

008014a8 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014a8:	55                   	push   %ebp
  8014a9:	89 e5                	mov    %esp,%ebp
  8014ab:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014bd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014c0:	73 50                	jae    801512 <memmove+0x6a>
  8014c2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c8:	01 d0                	add    %edx,%eax
  8014ca:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014cd:	76 43                	jbe    801512 <memmove+0x6a>
		s += n;
  8014cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d2:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d8:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014db:	eb 10                	jmp    8014ed <memmove+0x45>
			*--d = *--s;
  8014dd:	ff 4d f8             	decl   -0x8(%ebp)
  8014e0:	ff 4d fc             	decl   -0x4(%ebp)
  8014e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014e6:	8a 10                	mov    (%eax),%dl
  8014e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014eb:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014f3:	89 55 10             	mov    %edx,0x10(%ebp)
  8014f6:	85 c0                	test   %eax,%eax
  8014f8:	75 e3                	jne    8014dd <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014fa:	eb 23                	jmp    80151f <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ff:	8d 50 01             	lea    0x1(%eax),%edx
  801502:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801505:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801508:	8d 4a 01             	lea    0x1(%edx),%ecx
  80150b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80150e:	8a 12                	mov    (%edx),%dl
  801510:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801512:	8b 45 10             	mov    0x10(%ebp),%eax
  801515:	8d 50 ff             	lea    -0x1(%eax),%edx
  801518:	89 55 10             	mov    %edx,0x10(%ebp)
  80151b:	85 c0                	test   %eax,%eax
  80151d:	75 dd                	jne    8014fc <memmove+0x54>
			*d++ = *s++;

	return dst;
  80151f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801522:	c9                   	leave  
  801523:	c3                   	ret    

00801524 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801524:	55                   	push   %ebp
  801525:	89 e5                	mov    %esp,%ebp
  801527:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80152a:	8b 45 08             	mov    0x8(%ebp),%eax
  80152d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801530:	8b 45 0c             	mov    0xc(%ebp),%eax
  801533:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801536:	eb 2a                	jmp    801562 <memcmp+0x3e>
		if (*s1 != *s2)
  801538:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80153b:	8a 10                	mov    (%eax),%dl
  80153d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801540:	8a 00                	mov    (%eax),%al
  801542:	38 c2                	cmp    %al,%dl
  801544:	74 16                	je     80155c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801546:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801549:	8a 00                	mov    (%eax),%al
  80154b:	0f b6 d0             	movzbl %al,%edx
  80154e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801551:	8a 00                	mov    (%eax),%al
  801553:	0f b6 c0             	movzbl %al,%eax
  801556:	29 c2                	sub    %eax,%edx
  801558:	89 d0                	mov    %edx,%eax
  80155a:	eb 18                	jmp    801574 <memcmp+0x50>
		s1++, s2++;
  80155c:	ff 45 fc             	incl   -0x4(%ebp)
  80155f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801562:	8b 45 10             	mov    0x10(%ebp),%eax
  801565:	8d 50 ff             	lea    -0x1(%eax),%edx
  801568:	89 55 10             	mov    %edx,0x10(%ebp)
  80156b:	85 c0                	test   %eax,%eax
  80156d:	75 c9                	jne    801538 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80156f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801574:	c9                   	leave  
  801575:	c3                   	ret    

00801576 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801576:	55                   	push   %ebp
  801577:	89 e5                	mov    %esp,%ebp
  801579:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80157c:	8b 55 08             	mov    0x8(%ebp),%edx
  80157f:	8b 45 10             	mov    0x10(%ebp),%eax
  801582:	01 d0                	add    %edx,%eax
  801584:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801587:	eb 15                	jmp    80159e <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801589:	8b 45 08             	mov    0x8(%ebp),%eax
  80158c:	8a 00                	mov    (%eax),%al
  80158e:	0f b6 d0             	movzbl %al,%edx
  801591:	8b 45 0c             	mov    0xc(%ebp),%eax
  801594:	0f b6 c0             	movzbl %al,%eax
  801597:	39 c2                	cmp    %eax,%edx
  801599:	74 0d                	je     8015a8 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80159b:	ff 45 08             	incl   0x8(%ebp)
  80159e:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015a4:	72 e3                	jb     801589 <memfind+0x13>
  8015a6:	eb 01                	jmp    8015a9 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015a8:	90                   	nop
	return (void *) s;
  8015a9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015ac:	c9                   	leave  
  8015ad:	c3                   	ret    

008015ae <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015ae:	55                   	push   %ebp
  8015af:	89 e5                	mov    %esp,%ebp
  8015b1:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015bb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015c2:	eb 03                	jmp    8015c7 <strtol+0x19>
		s++;
  8015c4:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ca:	8a 00                	mov    (%eax),%al
  8015cc:	3c 20                	cmp    $0x20,%al
  8015ce:	74 f4                	je     8015c4 <strtol+0x16>
  8015d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d3:	8a 00                	mov    (%eax),%al
  8015d5:	3c 09                	cmp    $0x9,%al
  8015d7:	74 eb                	je     8015c4 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015dc:	8a 00                	mov    (%eax),%al
  8015de:	3c 2b                	cmp    $0x2b,%al
  8015e0:	75 05                	jne    8015e7 <strtol+0x39>
		s++;
  8015e2:	ff 45 08             	incl   0x8(%ebp)
  8015e5:	eb 13                	jmp    8015fa <strtol+0x4c>
	else if (*s == '-')
  8015e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ea:	8a 00                	mov    (%eax),%al
  8015ec:	3c 2d                	cmp    $0x2d,%al
  8015ee:	75 0a                	jne    8015fa <strtol+0x4c>
		s++, neg = 1;
  8015f0:	ff 45 08             	incl   0x8(%ebp)
  8015f3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015fa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015fe:	74 06                	je     801606 <strtol+0x58>
  801600:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801604:	75 20                	jne    801626 <strtol+0x78>
  801606:	8b 45 08             	mov    0x8(%ebp),%eax
  801609:	8a 00                	mov    (%eax),%al
  80160b:	3c 30                	cmp    $0x30,%al
  80160d:	75 17                	jne    801626 <strtol+0x78>
  80160f:	8b 45 08             	mov    0x8(%ebp),%eax
  801612:	40                   	inc    %eax
  801613:	8a 00                	mov    (%eax),%al
  801615:	3c 78                	cmp    $0x78,%al
  801617:	75 0d                	jne    801626 <strtol+0x78>
		s += 2, base = 16;
  801619:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80161d:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801624:	eb 28                	jmp    80164e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801626:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80162a:	75 15                	jne    801641 <strtol+0x93>
  80162c:	8b 45 08             	mov    0x8(%ebp),%eax
  80162f:	8a 00                	mov    (%eax),%al
  801631:	3c 30                	cmp    $0x30,%al
  801633:	75 0c                	jne    801641 <strtol+0x93>
		s++, base = 8;
  801635:	ff 45 08             	incl   0x8(%ebp)
  801638:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80163f:	eb 0d                	jmp    80164e <strtol+0xa0>
	else if (base == 0)
  801641:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801645:	75 07                	jne    80164e <strtol+0xa0>
		base = 10;
  801647:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80164e:	8b 45 08             	mov    0x8(%ebp),%eax
  801651:	8a 00                	mov    (%eax),%al
  801653:	3c 2f                	cmp    $0x2f,%al
  801655:	7e 19                	jle    801670 <strtol+0xc2>
  801657:	8b 45 08             	mov    0x8(%ebp),%eax
  80165a:	8a 00                	mov    (%eax),%al
  80165c:	3c 39                	cmp    $0x39,%al
  80165e:	7f 10                	jg     801670 <strtol+0xc2>
			dig = *s - '0';
  801660:	8b 45 08             	mov    0x8(%ebp),%eax
  801663:	8a 00                	mov    (%eax),%al
  801665:	0f be c0             	movsbl %al,%eax
  801668:	83 e8 30             	sub    $0x30,%eax
  80166b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80166e:	eb 42                	jmp    8016b2 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801670:	8b 45 08             	mov    0x8(%ebp),%eax
  801673:	8a 00                	mov    (%eax),%al
  801675:	3c 60                	cmp    $0x60,%al
  801677:	7e 19                	jle    801692 <strtol+0xe4>
  801679:	8b 45 08             	mov    0x8(%ebp),%eax
  80167c:	8a 00                	mov    (%eax),%al
  80167e:	3c 7a                	cmp    $0x7a,%al
  801680:	7f 10                	jg     801692 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801682:	8b 45 08             	mov    0x8(%ebp),%eax
  801685:	8a 00                	mov    (%eax),%al
  801687:	0f be c0             	movsbl %al,%eax
  80168a:	83 e8 57             	sub    $0x57,%eax
  80168d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801690:	eb 20                	jmp    8016b2 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801692:	8b 45 08             	mov    0x8(%ebp),%eax
  801695:	8a 00                	mov    (%eax),%al
  801697:	3c 40                	cmp    $0x40,%al
  801699:	7e 39                	jle    8016d4 <strtol+0x126>
  80169b:	8b 45 08             	mov    0x8(%ebp),%eax
  80169e:	8a 00                	mov    (%eax),%al
  8016a0:	3c 5a                	cmp    $0x5a,%al
  8016a2:	7f 30                	jg     8016d4 <strtol+0x126>
			dig = *s - 'A' + 10;
  8016a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a7:	8a 00                	mov    (%eax),%al
  8016a9:	0f be c0             	movsbl %al,%eax
  8016ac:	83 e8 37             	sub    $0x37,%eax
  8016af:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016b5:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016b8:	7d 19                	jge    8016d3 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016ba:	ff 45 08             	incl   0x8(%ebp)
  8016bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016c0:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016c4:	89 c2                	mov    %eax,%edx
  8016c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016c9:	01 d0                	add    %edx,%eax
  8016cb:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016ce:	e9 7b ff ff ff       	jmp    80164e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016d3:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016d4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016d8:	74 08                	je     8016e2 <strtol+0x134>
		*endptr = (char *) s;
  8016da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016dd:	8b 55 08             	mov    0x8(%ebp),%edx
  8016e0:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016e2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016e6:	74 07                	je     8016ef <strtol+0x141>
  8016e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016eb:	f7 d8                	neg    %eax
  8016ed:	eb 03                	jmp    8016f2 <strtol+0x144>
  8016ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016f2:	c9                   	leave  
  8016f3:	c3                   	ret    

008016f4 <ltostr>:

void
ltostr(long value, char *str)
{
  8016f4:	55                   	push   %ebp
  8016f5:	89 e5                	mov    %esp,%ebp
  8016f7:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801701:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801708:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80170c:	79 13                	jns    801721 <ltostr+0x2d>
	{
		neg = 1;
  80170e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801715:	8b 45 0c             	mov    0xc(%ebp),%eax
  801718:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80171b:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80171e:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801721:	8b 45 08             	mov    0x8(%ebp),%eax
  801724:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801729:	99                   	cltd   
  80172a:	f7 f9                	idiv   %ecx
  80172c:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80172f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801732:	8d 50 01             	lea    0x1(%eax),%edx
  801735:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801738:	89 c2                	mov    %eax,%edx
  80173a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80173d:	01 d0                	add    %edx,%eax
  80173f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801742:	83 c2 30             	add    $0x30,%edx
  801745:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801747:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80174a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80174f:	f7 e9                	imul   %ecx
  801751:	c1 fa 02             	sar    $0x2,%edx
  801754:	89 c8                	mov    %ecx,%eax
  801756:	c1 f8 1f             	sar    $0x1f,%eax
  801759:	29 c2                	sub    %eax,%edx
  80175b:	89 d0                	mov    %edx,%eax
  80175d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801760:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801763:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801768:	f7 e9                	imul   %ecx
  80176a:	c1 fa 02             	sar    $0x2,%edx
  80176d:	89 c8                	mov    %ecx,%eax
  80176f:	c1 f8 1f             	sar    $0x1f,%eax
  801772:	29 c2                	sub    %eax,%edx
  801774:	89 d0                	mov    %edx,%eax
  801776:	c1 e0 02             	shl    $0x2,%eax
  801779:	01 d0                	add    %edx,%eax
  80177b:	01 c0                	add    %eax,%eax
  80177d:	29 c1                	sub    %eax,%ecx
  80177f:	89 ca                	mov    %ecx,%edx
  801781:	85 d2                	test   %edx,%edx
  801783:	75 9c                	jne    801721 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801785:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80178c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80178f:	48                   	dec    %eax
  801790:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801793:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801797:	74 3d                	je     8017d6 <ltostr+0xe2>
		start = 1 ;
  801799:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017a0:	eb 34                	jmp    8017d6 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8017a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a8:	01 d0                	add    %edx,%eax
  8017aa:	8a 00                	mov    (%eax),%al
  8017ac:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017af:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b5:	01 c2                	add    %eax,%edx
  8017b7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017bd:	01 c8                	add    %ecx,%eax
  8017bf:	8a 00                	mov    (%eax),%al
  8017c1:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017c3:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c9:	01 c2                	add    %eax,%edx
  8017cb:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017ce:	88 02                	mov    %al,(%edx)
		start++ ;
  8017d0:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017d3:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017d9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017dc:	7c c4                	jl     8017a2 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017de:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e4:	01 d0                	add    %edx,%eax
  8017e6:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017e9:	90                   	nop
  8017ea:	c9                   	leave  
  8017eb:	c3                   	ret    

008017ec <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017ec:	55                   	push   %ebp
  8017ed:	89 e5                	mov    %esp,%ebp
  8017ef:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017f2:	ff 75 08             	pushl  0x8(%ebp)
  8017f5:	e8 54 fa ff ff       	call   80124e <strlen>
  8017fa:	83 c4 04             	add    $0x4,%esp
  8017fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801800:	ff 75 0c             	pushl  0xc(%ebp)
  801803:	e8 46 fa ff ff       	call   80124e <strlen>
  801808:	83 c4 04             	add    $0x4,%esp
  80180b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80180e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801815:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80181c:	eb 17                	jmp    801835 <strcconcat+0x49>
		final[s] = str1[s] ;
  80181e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801821:	8b 45 10             	mov    0x10(%ebp),%eax
  801824:	01 c2                	add    %eax,%edx
  801826:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801829:	8b 45 08             	mov    0x8(%ebp),%eax
  80182c:	01 c8                	add    %ecx,%eax
  80182e:	8a 00                	mov    (%eax),%al
  801830:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801832:	ff 45 fc             	incl   -0x4(%ebp)
  801835:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801838:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80183b:	7c e1                	jl     80181e <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80183d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801844:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80184b:	eb 1f                	jmp    80186c <strcconcat+0x80>
		final[s++] = str2[i] ;
  80184d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801850:	8d 50 01             	lea    0x1(%eax),%edx
  801853:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801856:	89 c2                	mov    %eax,%edx
  801858:	8b 45 10             	mov    0x10(%ebp),%eax
  80185b:	01 c2                	add    %eax,%edx
  80185d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801860:	8b 45 0c             	mov    0xc(%ebp),%eax
  801863:	01 c8                	add    %ecx,%eax
  801865:	8a 00                	mov    (%eax),%al
  801867:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801869:	ff 45 f8             	incl   -0x8(%ebp)
  80186c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80186f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801872:	7c d9                	jl     80184d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801874:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801877:	8b 45 10             	mov    0x10(%ebp),%eax
  80187a:	01 d0                	add    %edx,%eax
  80187c:	c6 00 00             	movb   $0x0,(%eax)
}
  80187f:	90                   	nop
  801880:	c9                   	leave  
  801881:	c3                   	ret    

00801882 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801882:	55                   	push   %ebp
  801883:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801885:	8b 45 14             	mov    0x14(%ebp),%eax
  801888:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80188e:	8b 45 14             	mov    0x14(%ebp),%eax
  801891:	8b 00                	mov    (%eax),%eax
  801893:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80189a:	8b 45 10             	mov    0x10(%ebp),%eax
  80189d:	01 d0                	add    %edx,%eax
  80189f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018a5:	eb 0c                	jmp    8018b3 <strsplit+0x31>
			*string++ = 0;
  8018a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018aa:	8d 50 01             	lea    0x1(%eax),%edx
  8018ad:	89 55 08             	mov    %edx,0x8(%ebp)
  8018b0:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b6:	8a 00                	mov    (%eax),%al
  8018b8:	84 c0                	test   %al,%al
  8018ba:	74 18                	je     8018d4 <strsplit+0x52>
  8018bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bf:	8a 00                	mov    (%eax),%al
  8018c1:	0f be c0             	movsbl %al,%eax
  8018c4:	50                   	push   %eax
  8018c5:	ff 75 0c             	pushl  0xc(%ebp)
  8018c8:	e8 13 fb ff ff       	call   8013e0 <strchr>
  8018cd:	83 c4 08             	add    $0x8,%esp
  8018d0:	85 c0                	test   %eax,%eax
  8018d2:	75 d3                	jne    8018a7 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8018d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d7:	8a 00                	mov    (%eax),%al
  8018d9:	84 c0                	test   %al,%al
  8018db:	74 5a                	je     801937 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8018dd:	8b 45 14             	mov    0x14(%ebp),%eax
  8018e0:	8b 00                	mov    (%eax),%eax
  8018e2:	83 f8 0f             	cmp    $0xf,%eax
  8018e5:	75 07                	jne    8018ee <strsplit+0x6c>
		{
			return 0;
  8018e7:	b8 00 00 00 00       	mov    $0x0,%eax
  8018ec:	eb 66                	jmp    801954 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8018f1:	8b 00                	mov    (%eax),%eax
  8018f3:	8d 48 01             	lea    0x1(%eax),%ecx
  8018f6:	8b 55 14             	mov    0x14(%ebp),%edx
  8018f9:	89 0a                	mov    %ecx,(%edx)
  8018fb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801902:	8b 45 10             	mov    0x10(%ebp),%eax
  801905:	01 c2                	add    %eax,%edx
  801907:	8b 45 08             	mov    0x8(%ebp),%eax
  80190a:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80190c:	eb 03                	jmp    801911 <strsplit+0x8f>
			string++;
  80190e:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801911:	8b 45 08             	mov    0x8(%ebp),%eax
  801914:	8a 00                	mov    (%eax),%al
  801916:	84 c0                	test   %al,%al
  801918:	74 8b                	je     8018a5 <strsplit+0x23>
  80191a:	8b 45 08             	mov    0x8(%ebp),%eax
  80191d:	8a 00                	mov    (%eax),%al
  80191f:	0f be c0             	movsbl %al,%eax
  801922:	50                   	push   %eax
  801923:	ff 75 0c             	pushl  0xc(%ebp)
  801926:	e8 b5 fa ff ff       	call   8013e0 <strchr>
  80192b:	83 c4 08             	add    $0x8,%esp
  80192e:	85 c0                	test   %eax,%eax
  801930:	74 dc                	je     80190e <strsplit+0x8c>
			string++;
	}
  801932:	e9 6e ff ff ff       	jmp    8018a5 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801937:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801938:	8b 45 14             	mov    0x14(%ebp),%eax
  80193b:	8b 00                	mov    (%eax),%eax
  80193d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801944:	8b 45 10             	mov    0x10(%ebp),%eax
  801947:	01 d0                	add    %edx,%eax
  801949:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80194f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801954:	c9                   	leave  
  801955:	c3                   	ret    

00801956 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801956:	55                   	push   %ebp
  801957:	89 e5                	mov    %esp,%ebp
  801959:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  80195c:	83 ec 04             	sub    $0x4,%esp
  80195f:	68 64 2a 80 00       	push   $0x802a64
  801964:	6a 15                	push   $0x15
  801966:	68 89 2a 80 00       	push   $0x802a89
  80196b:	e8 9f ed ff ff       	call   80070f <_panic>

00801970 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801970:	55                   	push   %ebp
  801971:	89 e5                	mov    %esp,%ebp
  801973:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801976:	83 ec 04             	sub    $0x4,%esp
  801979:	68 98 2a 80 00       	push   $0x802a98
  80197e:	6a 2e                	push   $0x2e
  801980:	68 89 2a 80 00       	push   $0x802a89
  801985:	e8 85 ed ff ff       	call   80070f <_panic>

0080198a <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  80198a:	55                   	push   %ebp
  80198b:	89 e5                	mov    %esp,%ebp
  80198d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801990:	83 ec 04             	sub    $0x4,%esp
  801993:	68 bc 2a 80 00       	push   $0x802abc
  801998:	6a 4c                	push   $0x4c
  80199a:	68 89 2a 80 00       	push   $0x802a89
  80199f:	e8 6b ed ff ff       	call   80070f <_panic>

008019a4 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8019a4:	55                   	push   %ebp
  8019a5:	89 e5                	mov    %esp,%ebp
  8019a7:	83 ec 18             	sub    $0x18,%esp
  8019aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ad:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8019b0:	83 ec 04             	sub    $0x4,%esp
  8019b3:	68 bc 2a 80 00       	push   $0x802abc
  8019b8:	6a 57                	push   $0x57
  8019ba:	68 89 2a 80 00       	push   $0x802a89
  8019bf:	e8 4b ed ff ff       	call   80070f <_panic>

008019c4 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8019c4:	55                   	push   %ebp
  8019c5:	89 e5                	mov    %esp,%ebp
  8019c7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019ca:	83 ec 04             	sub    $0x4,%esp
  8019cd:	68 bc 2a 80 00       	push   $0x802abc
  8019d2:	6a 5d                	push   $0x5d
  8019d4:	68 89 2a 80 00       	push   $0x802a89
  8019d9:	e8 31 ed ff ff       	call   80070f <_panic>

008019de <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8019de:	55                   	push   %ebp
  8019df:	89 e5                	mov    %esp,%ebp
  8019e1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019e4:	83 ec 04             	sub    $0x4,%esp
  8019e7:	68 bc 2a 80 00       	push   $0x802abc
  8019ec:	6a 63                	push   $0x63
  8019ee:	68 89 2a 80 00       	push   $0x802a89
  8019f3:	e8 17 ed ff ff       	call   80070f <_panic>

008019f8 <expand>:
}

void expand(uint32 newSize)
{
  8019f8:	55                   	push   %ebp
  8019f9:	89 e5                	mov    %esp,%ebp
  8019fb:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019fe:	83 ec 04             	sub    $0x4,%esp
  801a01:	68 bc 2a 80 00       	push   $0x802abc
  801a06:	6a 68                	push   $0x68
  801a08:	68 89 2a 80 00       	push   $0x802a89
  801a0d:	e8 fd ec ff ff       	call   80070f <_panic>

00801a12 <shrink>:
}
void shrink(uint32 newSize)
{
  801a12:	55                   	push   %ebp
  801a13:	89 e5                	mov    %esp,%ebp
  801a15:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a18:	83 ec 04             	sub    $0x4,%esp
  801a1b:	68 bc 2a 80 00       	push   $0x802abc
  801a20:	6a 6c                	push   $0x6c
  801a22:	68 89 2a 80 00       	push   $0x802a89
  801a27:	e8 e3 ec ff ff       	call   80070f <_panic>

00801a2c <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801a2c:	55                   	push   %ebp
  801a2d:	89 e5                	mov    %esp,%ebp
  801a2f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a32:	83 ec 04             	sub    $0x4,%esp
  801a35:	68 bc 2a 80 00       	push   $0x802abc
  801a3a:	6a 71                	push   $0x71
  801a3c:	68 89 2a 80 00       	push   $0x802a89
  801a41:	e8 c9 ec ff ff       	call   80070f <_panic>

00801a46 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801a46:	55                   	push   %ebp
  801a47:	89 e5                	mov    %esp,%ebp
  801a49:	57                   	push   %edi
  801a4a:	56                   	push   %esi
  801a4b:	53                   	push   %ebx
  801a4c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801a4f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a52:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a55:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a58:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a5b:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a5e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a61:	cd 30                	int    $0x30
  801a63:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a66:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a69:	83 c4 10             	add    $0x10,%esp
  801a6c:	5b                   	pop    %ebx
  801a6d:	5e                   	pop    %esi
  801a6e:	5f                   	pop    %edi
  801a6f:	5d                   	pop    %ebp
  801a70:	c3                   	ret    

00801a71 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801a71:	55                   	push   %ebp
  801a72:	89 e5                	mov    %esp,%ebp
  801a74:	83 ec 04             	sub    $0x4,%esp
  801a77:	8b 45 10             	mov    0x10(%ebp),%eax
  801a7a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801a7d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a81:	8b 45 08             	mov    0x8(%ebp),%eax
  801a84:	6a 00                	push   $0x0
  801a86:	6a 00                	push   $0x0
  801a88:	52                   	push   %edx
  801a89:	ff 75 0c             	pushl  0xc(%ebp)
  801a8c:	50                   	push   %eax
  801a8d:	6a 00                	push   $0x0
  801a8f:	e8 b2 ff ff ff       	call   801a46 <syscall>
  801a94:	83 c4 18             	add    $0x18,%esp
}
  801a97:	90                   	nop
  801a98:	c9                   	leave  
  801a99:	c3                   	ret    

00801a9a <sys_cgetc>:

int
sys_cgetc(void)
{
  801a9a:	55                   	push   %ebp
  801a9b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 01                	push   $0x1
  801aa9:	e8 98 ff ff ff       	call   801a46 <syscall>
  801aae:	83 c4 18             	add    $0x18,%esp
}
  801ab1:	c9                   	leave  
  801ab2:	c3                   	ret    

00801ab3 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801ab3:	55                   	push   %ebp
  801ab4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 00                	push   $0x0
  801abd:	6a 00                	push   $0x0
  801abf:	6a 00                	push   $0x0
  801ac1:	50                   	push   %eax
  801ac2:	6a 05                	push   $0x5
  801ac4:	e8 7d ff ff ff       	call   801a46 <syscall>
  801ac9:	83 c4 18             	add    $0x18,%esp
}
  801acc:	c9                   	leave  
  801acd:	c3                   	ret    

00801ace <sys_getenvid>:

int32 sys_getenvid(void)
{
  801ace:	55                   	push   %ebp
  801acf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801ad1:	6a 00                	push   $0x0
  801ad3:	6a 00                	push   $0x0
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	6a 00                	push   $0x0
  801adb:	6a 02                	push   $0x2
  801add:	e8 64 ff ff ff       	call   801a46 <syscall>
  801ae2:	83 c4 18             	add    $0x18,%esp
}
  801ae5:	c9                   	leave  
  801ae6:	c3                   	ret    

00801ae7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ae7:	55                   	push   %ebp
  801ae8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801aea:	6a 00                	push   $0x0
  801aec:	6a 00                	push   $0x0
  801aee:	6a 00                	push   $0x0
  801af0:	6a 00                	push   $0x0
  801af2:	6a 00                	push   $0x0
  801af4:	6a 03                	push   $0x3
  801af6:	e8 4b ff ff ff       	call   801a46 <syscall>
  801afb:	83 c4 18             	add    $0x18,%esp
}
  801afe:	c9                   	leave  
  801aff:	c3                   	ret    

00801b00 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b00:	55                   	push   %ebp
  801b01:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b03:	6a 00                	push   $0x0
  801b05:	6a 00                	push   $0x0
  801b07:	6a 00                	push   $0x0
  801b09:	6a 00                	push   $0x0
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 04                	push   $0x4
  801b0f:	e8 32 ff ff ff       	call   801a46 <syscall>
  801b14:	83 c4 18             	add    $0x18,%esp
}
  801b17:	c9                   	leave  
  801b18:	c3                   	ret    

00801b19 <sys_env_exit>:


void sys_env_exit(void)
{
  801b19:	55                   	push   %ebp
  801b1a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801b1c:	6a 00                	push   $0x0
  801b1e:	6a 00                	push   $0x0
  801b20:	6a 00                	push   $0x0
  801b22:	6a 00                	push   $0x0
  801b24:	6a 00                	push   $0x0
  801b26:	6a 06                	push   $0x6
  801b28:	e8 19 ff ff ff       	call   801a46 <syscall>
  801b2d:	83 c4 18             	add    $0x18,%esp
}
  801b30:	90                   	nop
  801b31:	c9                   	leave  
  801b32:	c3                   	ret    

00801b33 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801b33:	55                   	push   %ebp
  801b34:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801b36:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b39:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3c:	6a 00                	push   $0x0
  801b3e:	6a 00                	push   $0x0
  801b40:	6a 00                	push   $0x0
  801b42:	52                   	push   %edx
  801b43:	50                   	push   %eax
  801b44:	6a 07                	push   $0x7
  801b46:	e8 fb fe ff ff       	call   801a46 <syscall>
  801b4b:	83 c4 18             	add    $0x18,%esp
}
  801b4e:	c9                   	leave  
  801b4f:	c3                   	ret    

00801b50 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801b50:	55                   	push   %ebp
  801b51:	89 e5                	mov    %esp,%ebp
  801b53:	56                   	push   %esi
  801b54:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801b55:	8b 75 18             	mov    0x18(%ebp),%esi
  801b58:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b5b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b61:	8b 45 08             	mov    0x8(%ebp),%eax
  801b64:	56                   	push   %esi
  801b65:	53                   	push   %ebx
  801b66:	51                   	push   %ecx
  801b67:	52                   	push   %edx
  801b68:	50                   	push   %eax
  801b69:	6a 08                	push   $0x8
  801b6b:	e8 d6 fe ff ff       	call   801a46 <syscall>
  801b70:	83 c4 18             	add    $0x18,%esp
}
  801b73:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b76:	5b                   	pop    %ebx
  801b77:	5e                   	pop    %esi
  801b78:	5d                   	pop    %ebp
  801b79:	c3                   	ret    

00801b7a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801b7a:	55                   	push   %ebp
  801b7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801b7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b80:	8b 45 08             	mov    0x8(%ebp),%eax
  801b83:	6a 00                	push   $0x0
  801b85:	6a 00                	push   $0x0
  801b87:	6a 00                	push   $0x0
  801b89:	52                   	push   %edx
  801b8a:	50                   	push   %eax
  801b8b:	6a 09                	push   $0x9
  801b8d:	e8 b4 fe ff ff       	call   801a46 <syscall>
  801b92:	83 c4 18             	add    $0x18,%esp
}
  801b95:	c9                   	leave  
  801b96:	c3                   	ret    

00801b97 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b97:	55                   	push   %ebp
  801b98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b9a:	6a 00                	push   $0x0
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 00                	push   $0x0
  801ba0:	ff 75 0c             	pushl  0xc(%ebp)
  801ba3:	ff 75 08             	pushl  0x8(%ebp)
  801ba6:	6a 0a                	push   $0xa
  801ba8:	e8 99 fe ff ff       	call   801a46 <syscall>
  801bad:	83 c4 18             	add    $0x18,%esp
}
  801bb0:	c9                   	leave  
  801bb1:	c3                   	ret    

00801bb2 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801bb2:	55                   	push   %ebp
  801bb3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 00                	push   $0x0
  801bb9:	6a 00                	push   $0x0
  801bbb:	6a 00                	push   $0x0
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 0b                	push   $0xb
  801bc1:	e8 80 fe ff ff       	call   801a46 <syscall>
  801bc6:	83 c4 18             	add    $0x18,%esp
}
  801bc9:	c9                   	leave  
  801bca:	c3                   	ret    

00801bcb <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801bcb:	55                   	push   %ebp
  801bcc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801bce:	6a 00                	push   $0x0
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 00                	push   $0x0
  801bd4:	6a 00                	push   $0x0
  801bd6:	6a 00                	push   $0x0
  801bd8:	6a 0c                	push   $0xc
  801bda:	e8 67 fe ff ff       	call   801a46 <syscall>
  801bdf:	83 c4 18             	add    $0x18,%esp
}
  801be2:	c9                   	leave  
  801be3:	c3                   	ret    

00801be4 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801be4:	55                   	push   %ebp
  801be5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801be7:	6a 00                	push   $0x0
  801be9:	6a 00                	push   $0x0
  801beb:	6a 00                	push   $0x0
  801bed:	6a 00                	push   $0x0
  801bef:	6a 00                	push   $0x0
  801bf1:	6a 0d                	push   $0xd
  801bf3:	e8 4e fe ff ff       	call   801a46 <syscall>
  801bf8:	83 c4 18             	add    $0x18,%esp
}
  801bfb:	c9                   	leave  
  801bfc:	c3                   	ret    

00801bfd <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801bfd:	55                   	push   %ebp
  801bfe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c00:	6a 00                	push   $0x0
  801c02:	6a 00                	push   $0x0
  801c04:	6a 00                	push   $0x0
  801c06:	ff 75 0c             	pushl  0xc(%ebp)
  801c09:	ff 75 08             	pushl  0x8(%ebp)
  801c0c:	6a 11                	push   $0x11
  801c0e:	e8 33 fe ff ff       	call   801a46 <syscall>
  801c13:	83 c4 18             	add    $0x18,%esp
	return;
  801c16:	90                   	nop
}
  801c17:	c9                   	leave  
  801c18:	c3                   	ret    

00801c19 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c19:	55                   	push   %ebp
  801c1a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 00                	push   $0x0
  801c20:	6a 00                	push   $0x0
  801c22:	ff 75 0c             	pushl  0xc(%ebp)
  801c25:	ff 75 08             	pushl  0x8(%ebp)
  801c28:	6a 12                	push   $0x12
  801c2a:	e8 17 fe ff ff       	call   801a46 <syscall>
  801c2f:	83 c4 18             	add    $0x18,%esp
	return ;
  801c32:	90                   	nop
}
  801c33:	c9                   	leave  
  801c34:	c3                   	ret    

00801c35 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801c35:	55                   	push   %ebp
  801c36:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801c38:	6a 00                	push   $0x0
  801c3a:	6a 00                	push   $0x0
  801c3c:	6a 00                	push   $0x0
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 00                	push   $0x0
  801c42:	6a 0e                	push   $0xe
  801c44:	e8 fd fd ff ff       	call   801a46 <syscall>
  801c49:	83 c4 18             	add    $0x18,%esp
}
  801c4c:	c9                   	leave  
  801c4d:	c3                   	ret    

00801c4e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801c4e:	55                   	push   %ebp
  801c4f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801c51:	6a 00                	push   $0x0
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	ff 75 08             	pushl  0x8(%ebp)
  801c5c:	6a 0f                	push   $0xf
  801c5e:	e8 e3 fd ff ff       	call   801a46 <syscall>
  801c63:	83 c4 18             	add    $0x18,%esp
}
  801c66:	c9                   	leave  
  801c67:	c3                   	ret    

00801c68 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801c68:	55                   	push   %ebp
  801c69:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801c6b:	6a 00                	push   $0x0
  801c6d:	6a 00                	push   $0x0
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	6a 10                	push   $0x10
  801c77:	e8 ca fd ff ff       	call   801a46 <syscall>
  801c7c:	83 c4 18             	add    $0x18,%esp
}
  801c7f:	90                   	nop
  801c80:	c9                   	leave  
  801c81:	c3                   	ret    

00801c82 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801c82:	55                   	push   %ebp
  801c83:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801c85:	6a 00                	push   $0x0
  801c87:	6a 00                	push   $0x0
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 14                	push   $0x14
  801c91:	e8 b0 fd ff ff       	call   801a46 <syscall>
  801c96:	83 c4 18             	add    $0x18,%esp
}
  801c99:	90                   	nop
  801c9a:	c9                   	leave  
  801c9b:	c3                   	ret    

00801c9c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c9c:	55                   	push   %ebp
  801c9d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801c9f:	6a 00                	push   $0x0
  801ca1:	6a 00                	push   $0x0
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 00                	push   $0x0
  801ca9:	6a 15                	push   $0x15
  801cab:	e8 96 fd ff ff       	call   801a46 <syscall>
  801cb0:	83 c4 18             	add    $0x18,%esp
}
  801cb3:	90                   	nop
  801cb4:	c9                   	leave  
  801cb5:	c3                   	ret    

00801cb6 <sys_cputc>:


void
sys_cputc(const char c)
{
  801cb6:	55                   	push   %ebp
  801cb7:	89 e5                	mov    %esp,%ebp
  801cb9:	83 ec 04             	sub    $0x4,%esp
  801cbc:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801cc2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	50                   	push   %eax
  801ccf:	6a 16                	push   $0x16
  801cd1:	e8 70 fd ff ff       	call   801a46 <syscall>
  801cd6:	83 c4 18             	add    $0x18,%esp
}
  801cd9:	90                   	nop
  801cda:	c9                   	leave  
  801cdb:	c3                   	ret    

00801cdc <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801cdc:	55                   	push   %ebp
  801cdd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 17                	push   $0x17
  801ceb:	e8 56 fd ff ff       	call   801a46 <syscall>
  801cf0:	83 c4 18             	add    $0x18,%esp
}
  801cf3:	90                   	nop
  801cf4:	c9                   	leave  
  801cf5:	c3                   	ret    

00801cf6 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801cf6:	55                   	push   %ebp
  801cf7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	ff 75 0c             	pushl  0xc(%ebp)
  801d05:	50                   	push   %eax
  801d06:	6a 18                	push   $0x18
  801d08:	e8 39 fd ff ff       	call   801a46 <syscall>
  801d0d:	83 c4 18             	add    $0x18,%esp
}
  801d10:	c9                   	leave  
  801d11:	c3                   	ret    

00801d12 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d12:	55                   	push   %ebp
  801d13:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d15:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d18:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1b:	6a 00                	push   $0x0
  801d1d:	6a 00                	push   $0x0
  801d1f:	6a 00                	push   $0x0
  801d21:	52                   	push   %edx
  801d22:	50                   	push   %eax
  801d23:	6a 1b                	push   $0x1b
  801d25:	e8 1c fd ff ff       	call   801a46 <syscall>
  801d2a:	83 c4 18             	add    $0x18,%esp
}
  801d2d:	c9                   	leave  
  801d2e:	c3                   	ret    

00801d2f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d2f:	55                   	push   %ebp
  801d30:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d32:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d35:	8b 45 08             	mov    0x8(%ebp),%eax
  801d38:	6a 00                	push   $0x0
  801d3a:	6a 00                	push   $0x0
  801d3c:	6a 00                	push   $0x0
  801d3e:	52                   	push   %edx
  801d3f:	50                   	push   %eax
  801d40:	6a 19                	push   $0x19
  801d42:	e8 ff fc ff ff       	call   801a46 <syscall>
  801d47:	83 c4 18             	add    $0x18,%esp
}
  801d4a:	90                   	nop
  801d4b:	c9                   	leave  
  801d4c:	c3                   	ret    

00801d4d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d4d:	55                   	push   %ebp
  801d4e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d50:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d53:	8b 45 08             	mov    0x8(%ebp),%eax
  801d56:	6a 00                	push   $0x0
  801d58:	6a 00                	push   $0x0
  801d5a:	6a 00                	push   $0x0
  801d5c:	52                   	push   %edx
  801d5d:	50                   	push   %eax
  801d5e:	6a 1a                	push   $0x1a
  801d60:	e8 e1 fc ff ff       	call   801a46 <syscall>
  801d65:	83 c4 18             	add    $0x18,%esp
}
  801d68:	90                   	nop
  801d69:	c9                   	leave  
  801d6a:	c3                   	ret    

00801d6b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801d6b:	55                   	push   %ebp
  801d6c:	89 e5                	mov    %esp,%ebp
  801d6e:	83 ec 04             	sub    $0x4,%esp
  801d71:	8b 45 10             	mov    0x10(%ebp),%eax
  801d74:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801d77:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d7a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d81:	6a 00                	push   $0x0
  801d83:	51                   	push   %ecx
  801d84:	52                   	push   %edx
  801d85:	ff 75 0c             	pushl  0xc(%ebp)
  801d88:	50                   	push   %eax
  801d89:	6a 1c                	push   $0x1c
  801d8b:	e8 b6 fc ff ff       	call   801a46 <syscall>
  801d90:	83 c4 18             	add    $0x18,%esp
}
  801d93:	c9                   	leave  
  801d94:	c3                   	ret    

00801d95 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d95:	55                   	push   %ebp
  801d96:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d98:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d9b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	52                   	push   %edx
  801da5:	50                   	push   %eax
  801da6:	6a 1d                	push   $0x1d
  801da8:	e8 99 fc ff ff       	call   801a46 <syscall>
  801dad:	83 c4 18             	add    $0x18,%esp
}
  801db0:	c9                   	leave  
  801db1:	c3                   	ret    

00801db2 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801db2:	55                   	push   %ebp
  801db3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801db5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801db8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dbb:	8b 45 08             	mov    0x8(%ebp),%eax
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	51                   	push   %ecx
  801dc3:	52                   	push   %edx
  801dc4:	50                   	push   %eax
  801dc5:	6a 1e                	push   $0x1e
  801dc7:	e8 7a fc ff ff       	call   801a46 <syscall>
  801dcc:	83 c4 18             	add    $0x18,%esp
}
  801dcf:	c9                   	leave  
  801dd0:	c3                   	ret    

00801dd1 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801dd1:	55                   	push   %ebp
  801dd2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801dd4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dd7:	8b 45 08             	mov    0x8(%ebp),%eax
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 00                	push   $0x0
  801dde:	6a 00                	push   $0x0
  801de0:	52                   	push   %edx
  801de1:	50                   	push   %eax
  801de2:	6a 1f                	push   $0x1f
  801de4:	e8 5d fc ff ff       	call   801a46 <syscall>
  801de9:	83 c4 18             	add    $0x18,%esp
}
  801dec:	c9                   	leave  
  801ded:	c3                   	ret    

00801dee <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801dee:	55                   	push   %ebp
  801def:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 20                	push   $0x20
  801dfd:	e8 44 fc ff ff       	call   801a46 <syscall>
  801e02:	83 c4 18             	add    $0x18,%esp
}
  801e05:	c9                   	leave  
  801e06:	c3                   	ret    

00801e07 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801e07:	55                   	push   %ebp
  801e08:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0d:	6a 00                	push   $0x0
  801e0f:	ff 75 14             	pushl  0x14(%ebp)
  801e12:	ff 75 10             	pushl  0x10(%ebp)
  801e15:	ff 75 0c             	pushl  0xc(%ebp)
  801e18:	50                   	push   %eax
  801e19:	6a 21                	push   $0x21
  801e1b:	e8 26 fc ff ff       	call   801a46 <syscall>
  801e20:	83 c4 18             	add    $0x18,%esp
}
  801e23:	c9                   	leave  
  801e24:	c3                   	ret    

00801e25 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801e25:	55                   	push   %ebp
  801e26:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801e28:	8b 45 08             	mov    0x8(%ebp),%eax
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 00                	push   $0x0
  801e2f:	6a 00                	push   $0x0
  801e31:	6a 00                	push   $0x0
  801e33:	50                   	push   %eax
  801e34:	6a 22                	push   $0x22
  801e36:	e8 0b fc ff ff       	call   801a46 <syscall>
  801e3b:	83 c4 18             	add    $0x18,%esp
}
  801e3e:	90                   	nop
  801e3f:	c9                   	leave  
  801e40:	c3                   	ret    

00801e41 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801e41:	55                   	push   %ebp
  801e42:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801e44:	8b 45 08             	mov    0x8(%ebp),%eax
  801e47:	6a 00                	push   $0x0
  801e49:	6a 00                	push   $0x0
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 00                	push   $0x0
  801e4f:	50                   	push   %eax
  801e50:	6a 23                	push   $0x23
  801e52:	e8 ef fb ff ff       	call   801a46 <syscall>
  801e57:	83 c4 18             	add    $0x18,%esp
}
  801e5a:	90                   	nop
  801e5b:	c9                   	leave  
  801e5c:	c3                   	ret    

00801e5d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801e5d:	55                   	push   %ebp
  801e5e:	89 e5                	mov    %esp,%ebp
  801e60:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801e63:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e66:	8d 50 04             	lea    0x4(%eax),%edx
  801e69:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e6c:	6a 00                	push   $0x0
  801e6e:	6a 00                	push   $0x0
  801e70:	6a 00                	push   $0x0
  801e72:	52                   	push   %edx
  801e73:	50                   	push   %eax
  801e74:	6a 24                	push   $0x24
  801e76:	e8 cb fb ff ff       	call   801a46 <syscall>
  801e7b:	83 c4 18             	add    $0x18,%esp
	return result;
  801e7e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801e81:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e84:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e87:	89 01                	mov    %eax,(%ecx)
  801e89:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8f:	c9                   	leave  
  801e90:	c2 04 00             	ret    $0x4

00801e93 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e93:	55                   	push   %ebp
  801e94:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e96:	6a 00                	push   $0x0
  801e98:	6a 00                	push   $0x0
  801e9a:	ff 75 10             	pushl  0x10(%ebp)
  801e9d:	ff 75 0c             	pushl  0xc(%ebp)
  801ea0:	ff 75 08             	pushl  0x8(%ebp)
  801ea3:	6a 13                	push   $0x13
  801ea5:	e8 9c fb ff ff       	call   801a46 <syscall>
  801eaa:	83 c4 18             	add    $0x18,%esp
	return ;
  801ead:	90                   	nop
}
  801eae:	c9                   	leave  
  801eaf:	c3                   	ret    

00801eb0 <sys_rcr2>:
uint32 sys_rcr2()
{
  801eb0:	55                   	push   %ebp
  801eb1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801eb3:	6a 00                	push   $0x0
  801eb5:	6a 00                	push   $0x0
  801eb7:	6a 00                	push   $0x0
  801eb9:	6a 00                	push   $0x0
  801ebb:	6a 00                	push   $0x0
  801ebd:	6a 25                	push   $0x25
  801ebf:	e8 82 fb ff ff       	call   801a46 <syscall>
  801ec4:	83 c4 18             	add    $0x18,%esp
}
  801ec7:	c9                   	leave  
  801ec8:	c3                   	ret    

00801ec9 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801ec9:	55                   	push   %ebp
  801eca:	89 e5                	mov    %esp,%ebp
  801ecc:	83 ec 04             	sub    $0x4,%esp
  801ecf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801ed5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	50                   	push   %eax
  801ee2:	6a 26                	push   $0x26
  801ee4:	e8 5d fb ff ff       	call   801a46 <syscall>
  801ee9:	83 c4 18             	add    $0x18,%esp
	return ;
  801eec:	90                   	nop
}
  801eed:	c9                   	leave  
  801eee:	c3                   	ret    

00801eef <rsttst>:
void rsttst()
{
  801eef:	55                   	push   %ebp
  801ef0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ef2:	6a 00                	push   $0x0
  801ef4:	6a 00                	push   $0x0
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 00                	push   $0x0
  801efa:	6a 00                	push   $0x0
  801efc:	6a 28                	push   $0x28
  801efe:	e8 43 fb ff ff       	call   801a46 <syscall>
  801f03:	83 c4 18             	add    $0x18,%esp
	return ;
  801f06:	90                   	nop
}
  801f07:	c9                   	leave  
  801f08:	c3                   	ret    

00801f09 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f09:	55                   	push   %ebp
  801f0a:	89 e5                	mov    %esp,%ebp
  801f0c:	83 ec 04             	sub    $0x4,%esp
  801f0f:	8b 45 14             	mov    0x14(%ebp),%eax
  801f12:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f15:	8b 55 18             	mov    0x18(%ebp),%edx
  801f18:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f1c:	52                   	push   %edx
  801f1d:	50                   	push   %eax
  801f1e:	ff 75 10             	pushl  0x10(%ebp)
  801f21:	ff 75 0c             	pushl  0xc(%ebp)
  801f24:	ff 75 08             	pushl  0x8(%ebp)
  801f27:	6a 27                	push   $0x27
  801f29:	e8 18 fb ff ff       	call   801a46 <syscall>
  801f2e:	83 c4 18             	add    $0x18,%esp
	return ;
  801f31:	90                   	nop
}
  801f32:	c9                   	leave  
  801f33:	c3                   	ret    

00801f34 <chktst>:
void chktst(uint32 n)
{
  801f34:	55                   	push   %ebp
  801f35:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801f37:	6a 00                	push   $0x0
  801f39:	6a 00                	push   $0x0
  801f3b:	6a 00                	push   $0x0
  801f3d:	6a 00                	push   $0x0
  801f3f:	ff 75 08             	pushl  0x8(%ebp)
  801f42:	6a 29                	push   $0x29
  801f44:	e8 fd fa ff ff       	call   801a46 <syscall>
  801f49:	83 c4 18             	add    $0x18,%esp
	return ;
  801f4c:	90                   	nop
}
  801f4d:	c9                   	leave  
  801f4e:	c3                   	ret    

00801f4f <inctst>:

void inctst()
{
  801f4f:	55                   	push   %ebp
  801f50:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801f52:	6a 00                	push   $0x0
  801f54:	6a 00                	push   $0x0
  801f56:	6a 00                	push   $0x0
  801f58:	6a 00                	push   $0x0
  801f5a:	6a 00                	push   $0x0
  801f5c:	6a 2a                	push   $0x2a
  801f5e:	e8 e3 fa ff ff       	call   801a46 <syscall>
  801f63:	83 c4 18             	add    $0x18,%esp
	return ;
  801f66:	90                   	nop
}
  801f67:	c9                   	leave  
  801f68:	c3                   	ret    

00801f69 <gettst>:
uint32 gettst()
{
  801f69:	55                   	push   %ebp
  801f6a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f6c:	6a 00                	push   $0x0
  801f6e:	6a 00                	push   $0x0
  801f70:	6a 00                	push   $0x0
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	6a 2b                	push   $0x2b
  801f78:	e8 c9 fa ff ff       	call   801a46 <syscall>
  801f7d:	83 c4 18             	add    $0x18,%esp
}
  801f80:	c9                   	leave  
  801f81:	c3                   	ret    

00801f82 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801f82:	55                   	push   %ebp
  801f83:	89 e5                	mov    %esp,%ebp
  801f85:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f88:	6a 00                	push   $0x0
  801f8a:	6a 00                	push   $0x0
  801f8c:	6a 00                	push   $0x0
  801f8e:	6a 00                	push   $0x0
  801f90:	6a 00                	push   $0x0
  801f92:	6a 2c                	push   $0x2c
  801f94:	e8 ad fa ff ff       	call   801a46 <syscall>
  801f99:	83 c4 18             	add    $0x18,%esp
  801f9c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801f9f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801fa3:	75 07                	jne    801fac <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801fa5:	b8 01 00 00 00       	mov    $0x1,%eax
  801faa:	eb 05                	jmp    801fb1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801fac:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fb1:	c9                   	leave  
  801fb2:	c3                   	ret    

00801fb3 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801fb3:	55                   	push   %ebp
  801fb4:	89 e5                	mov    %esp,%ebp
  801fb6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fb9:	6a 00                	push   $0x0
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 2c                	push   $0x2c
  801fc5:	e8 7c fa ff ff       	call   801a46 <syscall>
  801fca:	83 c4 18             	add    $0x18,%esp
  801fcd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801fd0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801fd4:	75 07                	jne    801fdd <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801fd6:	b8 01 00 00 00       	mov    $0x1,%eax
  801fdb:	eb 05                	jmp    801fe2 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801fdd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fe2:	c9                   	leave  
  801fe3:	c3                   	ret    

00801fe4 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801fe4:	55                   	push   %ebp
  801fe5:	89 e5                	mov    %esp,%ebp
  801fe7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fea:	6a 00                	push   $0x0
  801fec:	6a 00                	push   $0x0
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 00                	push   $0x0
  801ff2:	6a 00                	push   $0x0
  801ff4:	6a 2c                	push   $0x2c
  801ff6:	e8 4b fa ff ff       	call   801a46 <syscall>
  801ffb:	83 c4 18             	add    $0x18,%esp
  801ffe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802001:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802005:	75 07                	jne    80200e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802007:	b8 01 00 00 00       	mov    $0x1,%eax
  80200c:	eb 05                	jmp    802013 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80200e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802013:	c9                   	leave  
  802014:	c3                   	ret    

00802015 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802015:	55                   	push   %ebp
  802016:	89 e5                	mov    %esp,%ebp
  802018:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80201b:	6a 00                	push   $0x0
  80201d:	6a 00                	push   $0x0
  80201f:	6a 00                	push   $0x0
  802021:	6a 00                	push   $0x0
  802023:	6a 00                	push   $0x0
  802025:	6a 2c                	push   $0x2c
  802027:	e8 1a fa ff ff       	call   801a46 <syscall>
  80202c:	83 c4 18             	add    $0x18,%esp
  80202f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802032:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802036:	75 07                	jne    80203f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802038:	b8 01 00 00 00       	mov    $0x1,%eax
  80203d:	eb 05                	jmp    802044 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80203f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802044:	c9                   	leave  
  802045:	c3                   	ret    

00802046 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802046:	55                   	push   %ebp
  802047:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802049:	6a 00                	push   $0x0
  80204b:	6a 00                	push   $0x0
  80204d:	6a 00                	push   $0x0
  80204f:	6a 00                	push   $0x0
  802051:	ff 75 08             	pushl  0x8(%ebp)
  802054:	6a 2d                	push   $0x2d
  802056:	e8 eb f9 ff ff       	call   801a46 <syscall>
  80205b:	83 c4 18             	add    $0x18,%esp
	return ;
  80205e:	90                   	nop
}
  80205f:	c9                   	leave  
  802060:	c3                   	ret    

00802061 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802061:	55                   	push   %ebp
  802062:	89 e5                	mov    %esp,%ebp
  802064:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802065:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802068:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80206b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80206e:	8b 45 08             	mov    0x8(%ebp),%eax
  802071:	6a 00                	push   $0x0
  802073:	53                   	push   %ebx
  802074:	51                   	push   %ecx
  802075:	52                   	push   %edx
  802076:	50                   	push   %eax
  802077:	6a 2e                	push   $0x2e
  802079:	e8 c8 f9 ff ff       	call   801a46 <syscall>
  80207e:	83 c4 18             	add    $0x18,%esp
}
  802081:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802084:	c9                   	leave  
  802085:	c3                   	ret    

00802086 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802086:	55                   	push   %ebp
  802087:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802089:	8b 55 0c             	mov    0xc(%ebp),%edx
  80208c:	8b 45 08             	mov    0x8(%ebp),%eax
  80208f:	6a 00                	push   $0x0
  802091:	6a 00                	push   $0x0
  802093:	6a 00                	push   $0x0
  802095:	52                   	push   %edx
  802096:	50                   	push   %eax
  802097:	6a 2f                	push   $0x2f
  802099:	e8 a8 f9 ff ff       	call   801a46 <syscall>
  80209e:	83 c4 18             	add    $0x18,%esp
}
  8020a1:	c9                   	leave  
  8020a2:	c3                   	ret    

008020a3 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8020a3:	55                   	push   %ebp
  8020a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8020a6:	6a 00                	push   $0x0
  8020a8:	6a 00                	push   $0x0
  8020aa:	6a 00                	push   $0x0
  8020ac:	ff 75 0c             	pushl  0xc(%ebp)
  8020af:	ff 75 08             	pushl  0x8(%ebp)
  8020b2:	6a 30                	push   $0x30
  8020b4:	e8 8d f9 ff ff       	call   801a46 <syscall>
  8020b9:	83 c4 18             	add    $0x18,%esp
	return ;
  8020bc:	90                   	nop
}
  8020bd:	c9                   	leave  
  8020be:	c3                   	ret    
  8020bf:	90                   	nop

008020c0 <__udivdi3>:
  8020c0:	55                   	push   %ebp
  8020c1:	57                   	push   %edi
  8020c2:	56                   	push   %esi
  8020c3:	53                   	push   %ebx
  8020c4:	83 ec 1c             	sub    $0x1c,%esp
  8020c7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8020cb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8020cf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020d3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8020d7:	89 ca                	mov    %ecx,%edx
  8020d9:	89 f8                	mov    %edi,%eax
  8020db:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8020df:	85 f6                	test   %esi,%esi
  8020e1:	75 2d                	jne    802110 <__udivdi3+0x50>
  8020e3:	39 cf                	cmp    %ecx,%edi
  8020e5:	77 65                	ja     80214c <__udivdi3+0x8c>
  8020e7:	89 fd                	mov    %edi,%ebp
  8020e9:	85 ff                	test   %edi,%edi
  8020eb:	75 0b                	jne    8020f8 <__udivdi3+0x38>
  8020ed:	b8 01 00 00 00       	mov    $0x1,%eax
  8020f2:	31 d2                	xor    %edx,%edx
  8020f4:	f7 f7                	div    %edi
  8020f6:	89 c5                	mov    %eax,%ebp
  8020f8:	31 d2                	xor    %edx,%edx
  8020fa:	89 c8                	mov    %ecx,%eax
  8020fc:	f7 f5                	div    %ebp
  8020fe:	89 c1                	mov    %eax,%ecx
  802100:	89 d8                	mov    %ebx,%eax
  802102:	f7 f5                	div    %ebp
  802104:	89 cf                	mov    %ecx,%edi
  802106:	89 fa                	mov    %edi,%edx
  802108:	83 c4 1c             	add    $0x1c,%esp
  80210b:	5b                   	pop    %ebx
  80210c:	5e                   	pop    %esi
  80210d:	5f                   	pop    %edi
  80210e:	5d                   	pop    %ebp
  80210f:	c3                   	ret    
  802110:	39 ce                	cmp    %ecx,%esi
  802112:	77 28                	ja     80213c <__udivdi3+0x7c>
  802114:	0f bd fe             	bsr    %esi,%edi
  802117:	83 f7 1f             	xor    $0x1f,%edi
  80211a:	75 40                	jne    80215c <__udivdi3+0x9c>
  80211c:	39 ce                	cmp    %ecx,%esi
  80211e:	72 0a                	jb     80212a <__udivdi3+0x6a>
  802120:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802124:	0f 87 9e 00 00 00    	ja     8021c8 <__udivdi3+0x108>
  80212a:	b8 01 00 00 00       	mov    $0x1,%eax
  80212f:	89 fa                	mov    %edi,%edx
  802131:	83 c4 1c             	add    $0x1c,%esp
  802134:	5b                   	pop    %ebx
  802135:	5e                   	pop    %esi
  802136:	5f                   	pop    %edi
  802137:	5d                   	pop    %ebp
  802138:	c3                   	ret    
  802139:	8d 76 00             	lea    0x0(%esi),%esi
  80213c:	31 ff                	xor    %edi,%edi
  80213e:	31 c0                	xor    %eax,%eax
  802140:	89 fa                	mov    %edi,%edx
  802142:	83 c4 1c             	add    $0x1c,%esp
  802145:	5b                   	pop    %ebx
  802146:	5e                   	pop    %esi
  802147:	5f                   	pop    %edi
  802148:	5d                   	pop    %ebp
  802149:	c3                   	ret    
  80214a:	66 90                	xchg   %ax,%ax
  80214c:	89 d8                	mov    %ebx,%eax
  80214e:	f7 f7                	div    %edi
  802150:	31 ff                	xor    %edi,%edi
  802152:	89 fa                	mov    %edi,%edx
  802154:	83 c4 1c             	add    $0x1c,%esp
  802157:	5b                   	pop    %ebx
  802158:	5e                   	pop    %esi
  802159:	5f                   	pop    %edi
  80215a:	5d                   	pop    %ebp
  80215b:	c3                   	ret    
  80215c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802161:	89 eb                	mov    %ebp,%ebx
  802163:	29 fb                	sub    %edi,%ebx
  802165:	89 f9                	mov    %edi,%ecx
  802167:	d3 e6                	shl    %cl,%esi
  802169:	89 c5                	mov    %eax,%ebp
  80216b:	88 d9                	mov    %bl,%cl
  80216d:	d3 ed                	shr    %cl,%ebp
  80216f:	89 e9                	mov    %ebp,%ecx
  802171:	09 f1                	or     %esi,%ecx
  802173:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802177:	89 f9                	mov    %edi,%ecx
  802179:	d3 e0                	shl    %cl,%eax
  80217b:	89 c5                	mov    %eax,%ebp
  80217d:	89 d6                	mov    %edx,%esi
  80217f:	88 d9                	mov    %bl,%cl
  802181:	d3 ee                	shr    %cl,%esi
  802183:	89 f9                	mov    %edi,%ecx
  802185:	d3 e2                	shl    %cl,%edx
  802187:	8b 44 24 08          	mov    0x8(%esp),%eax
  80218b:	88 d9                	mov    %bl,%cl
  80218d:	d3 e8                	shr    %cl,%eax
  80218f:	09 c2                	or     %eax,%edx
  802191:	89 d0                	mov    %edx,%eax
  802193:	89 f2                	mov    %esi,%edx
  802195:	f7 74 24 0c          	divl   0xc(%esp)
  802199:	89 d6                	mov    %edx,%esi
  80219b:	89 c3                	mov    %eax,%ebx
  80219d:	f7 e5                	mul    %ebp
  80219f:	39 d6                	cmp    %edx,%esi
  8021a1:	72 19                	jb     8021bc <__udivdi3+0xfc>
  8021a3:	74 0b                	je     8021b0 <__udivdi3+0xf0>
  8021a5:	89 d8                	mov    %ebx,%eax
  8021a7:	31 ff                	xor    %edi,%edi
  8021a9:	e9 58 ff ff ff       	jmp    802106 <__udivdi3+0x46>
  8021ae:	66 90                	xchg   %ax,%ax
  8021b0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8021b4:	89 f9                	mov    %edi,%ecx
  8021b6:	d3 e2                	shl    %cl,%edx
  8021b8:	39 c2                	cmp    %eax,%edx
  8021ba:	73 e9                	jae    8021a5 <__udivdi3+0xe5>
  8021bc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8021bf:	31 ff                	xor    %edi,%edi
  8021c1:	e9 40 ff ff ff       	jmp    802106 <__udivdi3+0x46>
  8021c6:	66 90                	xchg   %ax,%ax
  8021c8:	31 c0                	xor    %eax,%eax
  8021ca:	e9 37 ff ff ff       	jmp    802106 <__udivdi3+0x46>
  8021cf:	90                   	nop

008021d0 <__umoddi3>:
  8021d0:	55                   	push   %ebp
  8021d1:	57                   	push   %edi
  8021d2:	56                   	push   %esi
  8021d3:	53                   	push   %ebx
  8021d4:	83 ec 1c             	sub    $0x1c,%esp
  8021d7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8021db:	8b 74 24 34          	mov    0x34(%esp),%esi
  8021df:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021e3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8021e7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8021eb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8021ef:	89 f3                	mov    %esi,%ebx
  8021f1:	89 fa                	mov    %edi,%edx
  8021f3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8021f7:	89 34 24             	mov    %esi,(%esp)
  8021fa:	85 c0                	test   %eax,%eax
  8021fc:	75 1a                	jne    802218 <__umoddi3+0x48>
  8021fe:	39 f7                	cmp    %esi,%edi
  802200:	0f 86 a2 00 00 00    	jbe    8022a8 <__umoddi3+0xd8>
  802206:	89 c8                	mov    %ecx,%eax
  802208:	89 f2                	mov    %esi,%edx
  80220a:	f7 f7                	div    %edi
  80220c:	89 d0                	mov    %edx,%eax
  80220e:	31 d2                	xor    %edx,%edx
  802210:	83 c4 1c             	add    $0x1c,%esp
  802213:	5b                   	pop    %ebx
  802214:	5e                   	pop    %esi
  802215:	5f                   	pop    %edi
  802216:	5d                   	pop    %ebp
  802217:	c3                   	ret    
  802218:	39 f0                	cmp    %esi,%eax
  80221a:	0f 87 ac 00 00 00    	ja     8022cc <__umoddi3+0xfc>
  802220:	0f bd e8             	bsr    %eax,%ebp
  802223:	83 f5 1f             	xor    $0x1f,%ebp
  802226:	0f 84 ac 00 00 00    	je     8022d8 <__umoddi3+0x108>
  80222c:	bf 20 00 00 00       	mov    $0x20,%edi
  802231:	29 ef                	sub    %ebp,%edi
  802233:	89 fe                	mov    %edi,%esi
  802235:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802239:	89 e9                	mov    %ebp,%ecx
  80223b:	d3 e0                	shl    %cl,%eax
  80223d:	89 d7                	mov    %edx,%edi
  80223f:	89 f1                	mov    %esi,%ecx
  802241:	d3 ef                	shr    %cl,%edi
  802243:	09 c7                	or     %eax,%edi
  802245:	89 e9                	mov    %ebp,%ecx
  802247:	d3 e2                	shl    %cl,%edx
  802249:	89 14 24             	mov    %edx,(%esp)
  80224c:	89 d8                	mov    %ebx,%eax
  80224e:	d3 e0                	shl    %cl,%eax
  802250:	89 c2                	mov    %eax,%edx
  802252:	8b 44 24 08          	mov    0x8(%esp),%eax
  802256:	d3 e0                	shl    %cl,%eax
  802258:	89 44 24 04          	mov    %eax,0x4(%esp)
  80225c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802260:	89 f1                	mov    %esi,%ecx
  802262:	d3 e8                	shr    %cl,%eax
  802264:	09 d0                	or     %edx,%eax
  802266:	d3 eb                	shr    %cl,%ebx
  802268:	89 da                	mov    %ebx,%edx
  80226a:	f7 f7                	div    %edi
  80226c:	89 d3                	mov    %edx,%ebx
  80226e:	f7 24 24             	mull   (%esp)
  802271:	89 c6                	mov    %eax,%esi
  802273:	89 d1                	mov    %edx,%ecx
  802275:	39 d3                	cmp    %edx,%ebx
  802277:	0f 82 87 00 00 00    	jb     802304 <__umoddi3+0x134>
  80227d:	0f 84 91 00 00 00    	je     802314 <__umoddi3+0x144>
  802283:	8b 54 24 04          	mov    0x4(%esp),%edx
  802287:	29 f2                	sub    %esi,%edx
  802289:	19 cb                	sbb    %ecx,%ebx
  80228b:	89 d8                	mov    %ebx,%eax
  80228d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802291:	d3 e0                	shl    %cl,%eax
  802293:	89 e9                	mov    %ebp,%ecx
  802295:	d3 ea                	shr    %cl,%edx
  802297:	09 d0                	or     %edx,%eax
  802299:	89 e9                	mov    %ebp,%ecx
  80229b:	d3 eb                	shr    %cl,%ebx
  80229d:	89 da                	mov    %ebx,%edx
  80229f:	83 c4 1c             	add    $0x1c,%esp
  8022a2:	5b                   	pop    %ebx
  8022a3:	5e                   	pop    %esi
  8022a4:	5f                   	pop    %edi
  8022a5:	5d                   	pop    %ebp
  8022a6:	c3                   	ret    
  8022a7:	90                   	nop
  8022a8:	89 fd                	mov    %edi,%ebp
  8022aa:	85 ff                	test   %edi,%edi
  8022ac:	75 0b                	jne    8022b9 <__umoddi3+0xe9>
  8022ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8022b3:	31 d2                	xor    %edx,%edx
  8022b5:	f7 f7                	div    %edi
  8022b7:	89 c5                	mov    %eax,%ebp
  8022b9:	89 f0                	mov    %esi,%eax
  8022bb:	31 d2                	xor    %edx,%edx
  8022bd:	f7 f5                	div    %ebp
  8022bf:	89 c8                	mov    %ecx,%eax
  8022c1:	f7 f5                	div    %ebp
  8022c3:	89 d0                	mov    %edx,%eax
  8022c5:	e9 44 ff ff ff       	jmp    80220e <__umoddi3+0x3e>
  8022ca:	66 90                	xchg   %ax,%ax
  8022cc:	89 c8                	mov    %ecx,%eax
  8022ce:	89 f2                	mov    %esi,%edx
  8022d0:	83 c4 1c             	add    $0x1c,%esp
  8022d3:	5b                   	pop    %ebx
  8022d4:	5e                   	pop    %esi
  8022d5:	5f                   	pop    %edi
  8022d6:	5d                   	pop    %ebp
  8022d7:	c3                   	ret    
  8022d8:	3b 04 24             	cmp    (%esp),%eax
  8022db:	72 06                	jb     8022e3 <__umoddi3+0x113>
  8022dd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8022e1:	77 0f                	ja     8022f2 <__umoddi3+0x122>
  8022e3:	89 f2                	mov    %esi,%edx
  8022e5:	29 f9                	sub    %edi,%ecx
  8022e7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8022eb:	89 14 24             	mov    %edx,(%esp)
  8022ee:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022f2:	8b 44 24 04          	mov    0x4(%esp),%eax
  8022f6:	8b 14 24             	mov    (%esp),%edx
  8022f9:	83 c4 1c             	add    $0x1c,%esp
  8022fc:	5b                   	pop    %ebx
  8022fd:	5e                   	pop    %esi
  8022fe:	5f                   	pop    %edi
  8022ff:	5d                   	pop    %ebp
  802300:	c3                   	ret    
  802301:	8d 76 00             	lea    0x0(%esi),%esi
  802304:	2b 04 24             	sub    (%esp),%eax
  802307:	19 fa                	sbb    %edi,%edx
  802309:	89 d1                	mov    %edx,%ecx
  80230b:	89 c6                	mov    %eax,%esi
  80230d:	e9 71 ff ff ff       	jmp    802283 <__umoddi3+0xb3>
  802312:	66 90                	xchg   %ax,%ax
  802314:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802318:	72 ea                	jb     802304 <__umoddi3+0x134>
  80231a:	89 d9                	mov    %ebx,%ecx
  80231c:	e9 62 ff ff ff       	jmp    802283 <__umoddi3+0xb3>
