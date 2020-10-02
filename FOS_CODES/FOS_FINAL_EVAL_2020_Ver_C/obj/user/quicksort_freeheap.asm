
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
  800049:	e8 81 1e 00 00       	call   801ecf <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 93 1e 00 00       	call   801ee8 <sys_calculate_modified_frames>
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
  800067:	68 40 26 80 00       	push   $0x802640
  80006c:	e8 da 0f 00 00       	call   80104b <readline>
  800071:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  800074:	83 ec 04             	sub    $0x4,%esp
  800077:	6a 0a                	push   $0xa
  800079:	6a 00                	push   $0x0
  80007b:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800081:	50                   	push   %eax
  800082:	e8 2a 15 00 00       	call   8015b1 <strtol>
  800087:	83 c4 10             	add    $0x10,%esp
  80008a:	89 45 ec             	mov    %eax,-0x14(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  80008d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800090:	c1 e0 02             	shl    $0x2,%eax
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	50                   	push   %eax
  800097:	e8 bd 18 00 00       	call   801959 <malloc>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 45 e8             	mov    %eax,-0x18(%ebp)
		cprintf("Choose the initialization method:\n") ;
  8000a2:	83 ec 0c             	sub    $0xc,%esp
  8000a5:	68 60 26 80 00       	push   $0x802660
  8000aa:	e8 1a 09 00 00       	call   8009c9 <cprintf>
  8000af:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	68 83 26 80 00       	push   $0x802683
  8000ba:	e8 0a 09 00 00       	call   8009c9 <cprintf>
  8000bf:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000c2:	83 ec 0c             	sub    $0xc,%esp
  8000c5:	68 91 26 80 00       	push   $0x802691
  8000ca:	e8 fa 08 00 00       	call   8009c9 <cprintf>
  8000cf:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  8000d2:	83 ec 0c             	sub    $0xc,%esp
  8000d5:	68 a0 26 80 00       	push   $0x8026a0
  8000da:	e8 ea 08 00 00       	call   8009c9 <cprintf>
  8000df:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  8000e2:	83 ec 0c             	sub    $0xc,%esp
  8000e5:	68 b0 26 80 00       	push   $0x8026b0
  8000ea:	e8 da 08 00 00       	call   8009c9 <cprintf>
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
  8001b4:	68 bc 26 80 00       	push   $0x8026bc
  8001b9:	6a 45                	push   $0x45
  8001bb:	68 de 26 80 00       	push   $0x8026de
  8001c0:	e8 4d 05 00 00       	call   800712 <_panic>
		else
		{ 
			cprintf("===============================================\n") ;
  8001c5:	83 ec 0c             	sub    $0xc,%esp
  8001c8:	68 f8 26 80 00       	push   $0x8026f8
  8001cd:	e8 f7 07 00 00       	call   8009c9 <cprintf>
  8001d2:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001d5:	83 ec 0c             	sub    $0xc,%esp
  8001d8:	68 2c 27 80 00       	push   $0x80272c
  8001dd:	e8 e7 07 00 00       	call   8009c9 <cprintf>
  8001e2:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  8001e5:	83 ec 0c             	sub    $0xc,%esp
  8001e8:	68 60 27 80 00       	push   $0x802760
  8001ed:	e8 d7 07 00 00       	call   8009c9 <cprintf>
  8001f2:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		cprintf("Freeing the Heap...\n\n") ;
  8001f5:	83 ec 0c             	sub    $0xc,%esp
  8001f8:	68 92 27 80 00       	push   $0x802792
  8001fd:	e8 c7 07 00 00       	call   8009c9 <cprintf>
  800202:	83 c4 10             	add    $0x10,%esp

		//freeHeap() ;

		///========================================================================
		//sys_disable_interrupt();
		cprintf("Do you want to repeat (y/n): ") ;
  800205:	83 ec 0c             	sub    $0xc,%esp
  800208:	68 a8 27 80 00       	push   $0x8027a8
  80020d:	e8 b7 07 00 00       	call   8009c9 <cprintf>
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
  8004ea:	68 c6 27 80 00       	push   $0x8027c6
  8004ef:	e8 d5 04 00 00       	call   8009c9 <cprintf>
  8004f4:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  8004f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800501:	8b 45 08             	mov    0x8(%ebp),%eax
  800504:	01 d0                	add    %edx,%eax
  800506:	8b 00                	mov    (%eax),%eax
  800508:	83 ec 08             	sub    $0x8,%esp
  80050b:	50                   	push   %eax
  80050c:	68 c8 27 80 00       	push   $0x8027c8
  800511:	e8 b3 04 00 00       	call   8009c9 <cprintf>
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
  80053a:	68 cd 27 80 00       	push   $0x8027cd
  80053f:	e8 85 04 00 00       	call   8009c9 <cprintf>
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
  80055e:	e8 70 1a 00 00       	call   801fd3 <sys_cputc>
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
  80056f:	e8 2b 1a 00 00       	call   801f9f <sys_disable_interrupt>
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
  800582:	e8 4c 1a 00 00       	call   801fd3 <sys_cputc>
  800587:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80058a:	e8 2a 1a 00 00       	call   801fb9 <sys_enable_interrupt>
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
  8005a1:	e8 11 18 00 00       	call   801db7 <sys_cgetc>
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
  8005ba:	e8 e0 19 00 00       	call   801f9f <sys_disable_interrupt>
	int c=0;
  8005bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005c6:	eb 08                	jmp    8005d0 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005c8:	e8 ea 17 00 00       	call   801db7 <sys_cgetc>
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
  8005d6:	e8 de 19 00 00       	call   801fb9 <sys_enable_interrupt>
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
  8005f0:	e8 0f 18 00 00       	call   801e04 <sys_getenvindex>
  8005f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005fb:	89 d0                	mov    %edx,%eax
  8005fd:	01 c0                	add    %eax,%eax
  8005ff:	01 d0                	add    %edx,%eax
  800601:	c1 e0 07             	shl    $0x7,%eax
  800604:	29 d0                	sub    %edx,%eax
  800606:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80060d:	01 c8                	add    %ecx,%eax
  80060f:	01 c0                	add    %eax,%eax
  800611:	01 d0                	add    %edx,%eax
  800613:	01 c0                	add    %eax,%eax
  800615:	01 d0                	add    %edx,%eax
  800617:	c1 e0 03             	shl    $0x3,%eax
  80061a:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80061f:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800624:	a1 24 30 80 00       	mov    0x803024,%eax
  800629:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  80062f:	84 c0                	test   %al,%al
  800631:	74 0f                	je     800642 <libmain+0x58>
		binaryname = myEnv->prog_name;
  800633:	a1 24 30 80 00       	mov    0x803024,%eax
  800638:	05 f0 ee 00 00       	add    $0xeef0,%eax
  80063d:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800642:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800646:	7e 0a                	jle    800652 <libmain+0x68>
		binaryname = argv[0];
  800648:	8b 45 0c             	mov    0xc(%ebp),%eax
  80064b:	8b 00                	mov    (%eax),%eax
  80064d:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800652:	83 ec 08             	sub    $0x8,%esp
  800655:	ff 75 0c             	pushl  0xc(%ebp)
  800658:	ff 75 08             	pushl  0x8(%ebp)
  80065b:	e8 d8 f9 ff ff       	call   800038 <_main>
  800660:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800663:	e8 37 19 00 00       	call   801f9f <sys_disable_interrupt>
	cprintf("**************************************\n");
  800668:	83 ec 0c             	sub    $0xc,%esp
  80066b:	68 ec 27 80 00       	push   $0x8027ec
  800670:	e8 54 03 00 00       	call   8009c9 <cprintf>
  800675:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800678:	a1 24 30 80 00       	mov    0x803024,%eax
  80067d:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  800683:	a1 24 30 80 00       	mov    0x803024,%eax
  800688:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  80068e:	83 ec 04             	sub    $0x4,%esp
  800691:	52                   	push   %edx
  800692:	50                   	push   %eax
  800693:	68 14 28 80 00       	push   $0x802814
  800698:	e8 2c 03 00 00       	call   8009c9 <cprintf>
  80069d:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8006a0:	a1 24 30 80 00       	mov    0x803024,%eax
  8006a5:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  8006ab:	a1 24 30 80 00       	mov    0x803024,%eax
  8006b0:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  8006b6:	a1 24 30 80 00       	mov    0x803024,%eax
  8006bb:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  8006c1:	51                   	push   %ecx
  8006c2:	52                   	push   %edx
  8006c3:	50                   	push   %eax
  8006c4:	68 3c 28 80 00       	push   $0x80283c
  8006c9:	e8 fb 02 00 00       	call   8009c9 <cprintf>
  8006ce:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8006d1:	83 ec 0c             	sub    $0xc,%esp
  8006d4:	68 ec 27 80 00       	push   $0x8027ec
  8006d9:	e8 eb 02 00 00       	call   8009c9 <cprintf>
  8006de:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006e1:	e8 d3 18 00 00       	call   801fb9 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006e6:	e8 19 00 00 00       	call   800704 <exit>
}
  8006eb:	90                   	nop
  8006ec:	c9                   	leave  
  8006ed:	c3                   	ret    

008006ee <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006ee:	55                   	push   %ebp
  8006ef:	89 e5                	mov    %esp,%ebp
  8006f1:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006f4:	83 ec 0c             	sub    $0xc,%esp
  8006f7:	6a 00                	push   $0x0
  8006f9:	e8 d2 16 00 00       	call   801dd0 <sys_env_destroy>
  8006fe:	83 c4 10             	add    $0x10,%esp
}
  800701:	90                   	nop
  800702:	c9                   	leave  
  800703:	c3                   	ret    

00800704 <exit>:

void
exit(void)
{
  800704:	55                   	push   %ebp
  800705:	89 e5                	mov    %esp,%ebp
  800707:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80070a:	e8 27 17 00 00       	call   801e36 <sys_env_exit>
}
  80070f:	90                   	nop
  800710:	c9                   	leave  
  800711:	c3                   	ret    

00800712 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800712:	55                   	push   %ebp
  800713:	89 e5                	mov    %esp,%ebp
  800715:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800718:	8d 45 10             	lea    0x10(%ebp),%eax
  80071b:	83 c0 04             	add    $0x4,%eax
  80071e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800721:	a1 18 31 80 00       	mov    0x803118,%eax
  800726:	85 c0                	test   %eax,%eax
  800728:	74 16                	je     800740 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80072a:	a1 18 31 80 00       	mov    0x803118,%eax
  80072f:	83 ec 08             	sub    $0x8,%esp
  800732:	50                   	push   %eax
  800733:	68 94 28 80 00       	push   $0x802894
  800738:	e8 8c 02 00 00       	call   8009c9 <cprintf>
  80073d:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800740:	a1 00 30 80 00       	mov    0x803000,%eax
  800745:	ff 75 0c             	pushl  0xc(%ebp)
  800748:	ff 75 08             	pushl  0x8(%ebp)
  80074b:	50                   	push   %eax
  80074c:	68 99 28 80 00       	push   $0x802899
  800751:	e8 73 02 00 00       	call   8009c9 <cprintf>
  800756:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800759:	8b 45 10             	mov    0x10(%ebp),%eax
  80075c:	83 ec 08             	sub    $0x8,%esp
  80075f:	ff 75 f4             	pushl  -0xc(%ebp)
  800762:	50                   	push   %eax
  800763:	e8 f6 01 00 00       	call   80095e <vcprintf>
  800768:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80076b:	83 ec 08             	sub    $0x8,%esp
  80076e:	6a 00                	push   $0x0
  800770:	68 b5 28 80 00       	push   $0x8028b5
  800775:	e8 e4 01 00 00       	call   80095e <vcprintf>
  80077a:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80077d:	e8 82 ff ff ff       	call   800704 <exit>

	// should not return here
	while (1) ;
  800782:	eb fe                	jmp    800782 <_panic+0x70>

00800784 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800784:	55                   	push   %ebp
  800785:	89 e5                	mov    %esp,%ebp
  800787:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80078a:	a1 24 30 80 00       	mov    0x803024,%eax
  80078f:	8b 50 74             	mov    0x74(%eax),%edx
  800792:	8b 45 0c             	mov    0xc(%ebp),%eax
  800795:	39 c2                	cmp    %eax,%edx
  800797:	74 14                	je     8007ad <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800799:	83 ec 04             	sub    $0x4,%esp
  80079c:	68 b8 28 80 00       	push   $0x8028b8
  8007a1:	6a 26                	push   $0x26
  8007a3:	68 04 29 80 00       	push   $0x802904
  8007a8:	e8 65 ff ff ff       	call   800712 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007ad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007b4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007bb:	e9 c4 00 00 00       	jmp    800884 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  8007c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cd:	01 d0                	add    %edx,%eax
  8007cf:	8b 00                	mov    (%eax),%eax
  8007d1:	85 c0                	test   %eax,%eax
  8007d3:	75 08                	jne    8007dd <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007d5:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007d8:	e9 a4 00 00 00       	jmp    800881 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8007dd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007e4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007eb:	eb 6b                	jmp    800858 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007ed:	a1 24 30 80 00       	mov    0x803024,%eax
  8007f2:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8007f8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007fb:	89 d0                	mov    %edx,%eax
  8007fd:	c1 e0 02             	shl    $0x2,%eax
  800800:	01 d0                	add    %edx,%eax
  800802:	c1 e0 02             	shl    $0x2,%eax
  800805:	01 c8                	add    %ecx,%eax
  800807:	8a 40 04             	mov    0x4(%eax),%al
  80080a:	84 c0                	test   %al,%al
  80080c:	75 47                	jne    800855 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80080e:	a1 24 30 80 00       	mov    0x803024,%eax
  800813:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800819:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80081c:	89 d0                	mov    %edx,%eax
  80081e:	c1 e0 02             	shl    $0x2,%eax
  800821:	01 d0                	add    %edx,%eax
  800823:	c1 e0 02             	shl    $0x2,%eax
  800826:	01 c8                	add    %ecx,%eax
  800828:	8b 00                	mov    (%eax),%eax
  80082a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80082d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800830:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800835:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800837:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80083a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800841:	8b 45 08             	mov    0x8(%ebp),%eax
  800844:	01 c8                	add    %ecx,%eax
  800846:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800848:	39 c2                	cmp    %eax,%edx
  80084a:	75 09                	jne    800855 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  80084c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800853:	eb 12                	jmp    800867 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800855:	ff 45 e8             	incl   -0x18(%ebp)
  800858:	a1 24 30 80 00       	mov    0x803024,%eax
  80085d:	8b 50 74             	mov    0x74(%eax),%edx
  800860:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800863:	39 c2                	cmp    %eax,%edx
  800865:	77 86                	ja     8007ed <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800867:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80086b:	75 14                	jne    800881 <CheckWSWithoutLastIndex+0xfd>
			panic(
  80086d:	83 ec 04             	sub    $0x4,%esp
  800870:	68 10 29 80 00       	push   $0x802910
  800875:	6a 3a                	push   $0x3a
  800877:	68 04 29 80 00       	push   $0x802904
  80087c:	e8 91 fe ff ff       	call   800712 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800881:	ff 45 f0             	incl   -0x10(%ebp)
  800884:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800887:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80088a:	0f 8c 30 ff ff ff    	jl     8007c0 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800890:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800897:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80089e:	eb 27                	jmp    8008c7 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008a0:	a1 24 30 80 00       	mov    0x803024,%eax
  8008a5:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8008ab:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008ae:	89 d0                	mov    %edx,%eax
  8008b0:	c1 e0 02             	shl    $0x2,%eax
  8008b3:	01 d0                	add    %edx,%eax
  8008b5:	c1 e0 02             	shl    $0x2,%eax
  8008b8:	01 c8                	add    %ecx,%eax
  8008ba:	8a 40 04             	mov    0x4(%eax),%al
  8008bd:	3c 01                	cmp    $0x1,%al
  8008bf:	75 03                	jne    8008c4 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  8008c1:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008c4:	ff 45 e0             	incl   -0x20(%ebp)
  8008c7:	a1 24 30 80 00       	mov    0x803024,%eax
  8008cc:	8b 50 74             	mov    0x74(%eax),%edx
  8008cf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008d2:	39 c2                	cmp    %eax,%edx
  8008d4:	77 ca                	ja     8008a0 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008d9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008dc:	74 14                	je     8008f2 <CheckWSWithoutLastIndex+0x16e>
		panic(
  8008de:	83 ec 04             	sub    $0x4,%esp
  8008e1:	68 64 29 80 00       	push   $0x802964
  8008e6:	6a 44                	push   $0x44
  8008e8:	68 04 29 80 00       	push   $0x802904
  8008ed:	e8 20 fe ff ff       	call   800712 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008f2:	90                   	nop
  8008f3:	c9                   	leave  
  8008f4:	c3                   	ret    

008008f5 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008f5:	55                   	push   %ebp
  8008f6:	89 e5                	mov    %esp,%ebp
  8008f8:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fe:	8b 00                	mov    (%eax),%eax
  800900:	8d 48 01             	lea    0x1(%eax),%ecx
  800903:	8b 55 0c             	mov    0xc(%ebp),%edx
  800906:	89 0a                	mov    %ecx,(%edx)
  800908:	8b 55 08             	mov    0x8(%ebp),%edx
  80090b:	88 d1                	mov    %dl,%cl
  80090d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800910:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800914:	8b 45 0c             	mov    0xc(%ebp),%eax
  800917:	8b 00                	mov    (%eax),%eax
  800919:	3d ff 00 00 00       	cmp    $0xff,%eax
  80091e:	75 2c                	jne    80094c <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800920:	a0 28 30 80 00       	mov    0x803028,%al
  800925:	0f b6 c0             	movzbl %al,%eax
  800928:	8b 55 0c             	mov    0xc(%ebp),%edx
  80092b:	8b 12                	mov    (%edx),%edx
  80092d:	89 d1                	mov    %edx,%ecx
  80092f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800932:	83 c2 08             	add    $0x8,%edx
  800935:	83 ec 04             	sub    $0x4,%esp
  800938:	50                   	push   %eax
  800939:	51                   	push   %ecx
  80093a:	52                   	push   %edx
  80093b:	e8 4e 14 00 00       	call   801d8e <sys_cputs>
  800940:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800943:	8b 45 0c             	mov    0xc(%ebp),%eax
  800946:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80094c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80094f:	8b 40 04             	mov    0x4(%eax),%eax
  800952:	8d 50 01             	lea    0x1(%eax),%edx
  800955:	8b 45 0c             	mov    0xc(%ebp),%eax
  800958:	89 50 04             	mov    %edx,0x4(%eax)
}
  80095b:	90                   	nop
  80095c:	c9                   	leave  
  80095d:	c3                   	ret    

0080095e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80095e:	55                   	push   %ebp
  80095f:	89 e5                	mov    %esp,%ebp
  800961:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800967:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80096e:	00 00 00 
	b.cnt = 0;
  800971:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800978:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80097b:	ff 75 0c             	pushl  0xc(%ebp)
  80097e:	ff 75 08             	pushl  0x8(%ebp)
  800981:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800987:	50                   	push   %eax
  800988:	68 f5 08 80 00       	push   $0x8008f5
  80098d:	e8 11 02 00 00       	call   800ba3 <vprintfmt>
  800992:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800995:	a0 28 30 80 00       	mov    0x803028,%al
  80099a:	0f b6 c0             	movzbl %al,%eax
  80099d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009a3:	83 ec 04             	sub    $0x4,%esp
  8009a6:	50                   	push   %eax
  8009a7:	52                   	push   %edx
  8009a8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009ae:	83 c0 08             	add    $0x8,%eax
  8009b1:	50                   	push   %eax
  8009b2:	e8 d7 13 00 00       	call   801d8e <sys_cputs>
  8009b7:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009ba:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  8009c1:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009c7:	c9                   	leave  
  8009c8:	c3                   	ret    

008009c9 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009c9:	55                   	push   %ebp
  8009ca:	89 e5                	mov    %esp,%ebp
  8009cc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009cf:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  8009d6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009df:	83 ec 08             	sub    $0x8,%esp
  8009e2:	ff 75 f4             	pushl  -0xc(%ebp)
  8009e5:	50                   	push   %eax
  8009e6:	e8 73 ff ff ff       	call   80095e <vcprintf>
  8009eb:	83 c4 10             	add    $0x10,%esp
  8009ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009f4:	c9                   	leave  
  8009f5:	c3                   	ret    

008009f6 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009f6:	55                   	push   %ebp
  8009f7:	89 e5                	mov    %esp,%ebp
  8009f9:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009fc:	e8 9e 15 00 00       	call   801f9f <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a01:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a04:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a07:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0a:	83 ec 08             	sub    $0x8,%esp
  800a0d:	ff 75 f4             	pushl  -0xc(%ebp)
  800a10:	50                   	push   %eax
  800a11:	e8 48 ff ff ff       	call   80095e <vcprintf>
  800a16:	83 c4 10             	add    $0x10,%esp
  800a19:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a1c:	e8 98 15 00 00       	call   801fb9 <sys_enable_interrupt>
	return cnt;
  800a21:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a24:	c9                   	leave  
  800a25:	c3                   	ret    

00800a26 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a26:	55                   	push   %ebp
  800a27:	89 e5                	mov    %esp,%ebp
  800a29:	53                   	push   %ebx
  800a2a:	83 ec 14             	sub    $0x14,%esp
  800a2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800a30:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a33:	8b 45 14             	mov    0x14(%ebp),%eax
  800a36:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a39:	8b 45 18             	mov    0x18(%ebp),%eax
  800a3c:	ba 00 00 00 00       	mov    $0x0,%edx
  800a41:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a44:	77 55                	ja     800a9b <printnum+0x75>
  800a46:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a49:	72 05                	jb     800a50 <printnum+0x2a>
  800a4b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a4e:	77 4b                	ja     800a9b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a50:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a53:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a56:	8b 45 18             	mov    0x18(%ebp),%eax
  800a59:	ba 00 00 00 00       	mov    $0x0,%edx
  800a5e:	52                   	push   %edx
  800a5f:	50                   	push   %eax
  800a60:	ff 75 f4             	pushl  -0xc(%ebp)
  800a63:	ff 75 f0             	pushl  -0x10(%ebp)
  800a66:	e8 71 19 00 00       	call   8023dc <__udivdi3>
  800a6b:	83 c4 10             	add    $0x10,%esp
  800a6e:	83 ec 04             	sub    $0x4,%esp
  800a71:	ff 75 20             	pushl  0x20(%ebp)
  800a74:	53                   	push   %ebx
  800a75:	ff 75 18             	pushl  0x18(%ebp)
  800a78:	52                   	push   %edx
  800a79:	50                   	push   %eax
  800a7a:	ff 75 0c             	pushl  0xc(%ebp)
  800a7d:	ff 75 08             	pushl  0x8(%ebp)
  800a80:	e8 a1 ff ff ff       	call   800a26 <printnum>
  800a85:	83 c4 20             	add    $0x20,%esp
  800a88:	eb 1a                	jmp    800aa4 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a8a:	83 ec 08             	sub    $0x8,%esp
  800a8d:	ff 75 0c             	pushl  0xc(%ebp)
  800a90:	ff 75 20             	pushl  0x20(%ebp)
  800a93:	8b 45 08             	mov    0x8(%ebp),%eax
  800a96:	ff d0                	call   *%eax
  800a98:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a9b:	ff 4d 1c             	decl   0x1c(%ebp)
  800a9e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800aa2:	7f e6                	jg     800a8a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800aa4:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800aa7:	bb 00 00 00 00       	mov    $0x0,%ebx
  800aac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aaf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ab2:	53                   	push   %ebx
  800ab3:	51                   	push   %ecx
  800ab4:	52                   	push   %edx
  800ab5:	50                   	push   %eax
  800ab6:	e8 31 1a 00 00       	call   8024ec <__umoddi3>
  800abb:	83 c4 10             	add    $0x10,%esp
  800abe:	05 d4 2b 80 00       	add    $0x802bd4,%eax
  800ac3:	8a 00                	mov    (%eax),%al
  800ac5:	0f be c0             	movsbl %al,%eax
  800ac8:	83 ec 08             	sub    $0x8,%esp
  800acb:	ff 75 0c             	pushl  0xc(%ebp)
  800ace:	50                   	push   %eax
  800acf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad2:	ff d0                	call   *%eax
  800ad4:	83 c4 10             	add    $0x10,%esp
}
  800ad7:	90                   	nop
  800ad8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800adb:	c9                   	leave  
  800adc:	c3                   	ret    

00800add <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800add:	55                   	push   %ebp
  800ade:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ae0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ae4:	7e 1c                	jle    800b02 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae9:	8b 00                	mov    (%eax),%eax
  800aeb:	8d 50 08             	lea    0x8(%eax),%edx
  800aee:	8b 45 08             	mov    0x8(%ebp),%eax
  800af1:	89 10                	mov    %edx,(%eax)
  800af3:	8b 45 08             	mov    0x8(%ebp),%eax
  800af6:	8b 00                	mov    (%eax),%eax
  800af8:	83 e8 08             	sub    $0x8,%eax
  800afb:	8b 50 04             	mov    0x4(%eax),%edx
  800afe:	8b 00                	mov    (%eax),%eax
  800b00:	eb 40                	jmp    800b42 <getuint+0x65>
	else if (lflag)
  800b02:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b06:	74 1e                	je     800b26 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b08:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0b:	8b 00                	mov    (%eax),%eax
  800b0d:	8d 50 04             	lea    0x4(%eax),%edx
  800b10:	8b 45 08             	mov    0x8(%ebp),%eax
  800b13:	89 10                	mov    %edx,(%eax)
  800b15:	8b 45 08             	mov    0x8(%ebp),%eax
  800b18:	8b 00                	mov    (%eax),%eax
  800b1a:	83 e8 04             	sub    $0x4,%eax
  800b1d:	8b 00                	mov    (%eax),%eax
  800b1f:	ba 00 00 00 00       	mov    $0x0,%edx
  800b24:	eb 1c                	jmp    800b42 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	8b 00                	mov    (%eax),%eax
  800b2b:	8d 50 04             	lea    0x4(%eax),%edx
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b31:	89 10                	mov    %edx,(%eax)
  800b33:	8b 45 08             	mov    0x8(%ebp),%eax
  800b36:	8b 00                	mov    (%eax),%eax
  800b38:	83 e8 04             	sub    $0x4,%eax
  800b3b:	8b 00                	mov    (%eax),%eax
  800b3d:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b42:	5d                   	pop    %ebp
  800b43:	c3                   	ret    

00800b44 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b44:	55                   	push   %ebp
  800b45:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b47:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b4b:	7e 1c                	jle    800b69 <getint+0x25>
		return va_arg(*ap, long long);
  800b4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b50:	8b 00                	mov    (%eax),%eax
  800b52:	8d 50 08             	lea    0x8(%eax),%edx
  800b55:	8b 45 08             	mov    0x8(%ebp),%eax
  800b58:	89 10                	mov    %edx,(%eax)
  800b5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5d:	8b 00                	mov    (%eax),%eax
  800b5f:	83 e8 08             	sub    $0x8,%eax
  800b62:	8b 50 04             	mov    0x4(%eax),%edx
  800b65:	8b 00                	mov    (%eax),%eax
  800b67:	eb 38                	jmp    800ba1 <getint+0x5d>
	else if (lflag)
  800b69:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b6d:	74 1a                	je     800b89 <getint+0x45>
		return va_arg(*ap, long);
  800b6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b72:	8b 00                	mov    (%eax),%eax
  800b74:	8d 50 04             	lea    0x4(%eax),%edx
  800b77:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7a:	89 10                	mov    %edx,(%eax)
  800b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7f:	8b 00                	mov    (%eax),%eax
  800b81:	83 e8 04             	sub    $0x4,%eax
  800b84:	8b 00                	mov    (%eax),%eax
  800b86:	99                   	cltd   
  800b87:	eb 18                	jmp    800ba1 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b89:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8c:	8b 00                	mov    (%eax),%eax
  800b8e:	8d 50 04             	lea    0x4(%eax),%edx
  800b91:	8b 45 08             	mov    0x8(%ebp),%eax
  800b94:	89 10                	mov    %edx,(%eax)
  800b96:	8b 45 08             	mov    0x8(%ebp),%eax
  800b99:	8b 00                	mov    (%eax),%eax
  800b9b:	83 e8 04             	sub    $0x4,%eax
  800b9e:	8b 00                	mov    (%eax),%eax
  800ba0:	99                   	cltd   
}
  800ba1:	5d                   	pop    %ebp
  800ba2:	c3                   	ret    

00800ba3 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800ba3:	55                   	push   %ebp
  800ba4:	89 e5                	mov    %esp,%ebp
  800ba6:	56                   	push   %esi
  800ba7:	53                   	push   %ebx
  800ba8:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bab:	eb 17                	jmp    800bc4 <vprintfmt+0x21>
			if (ch == '\0')
  800bad:	85 db                	test   %ebx,%ebx
  800baf:	0f 84 af 03 00 00    	je     800f64 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bb5:	83 ec 08             	sub    $0x8,%esp
  800bb8:	ff 75 0c             	pushl  0xc(%ebp)
  800bbb:	53                   	push   %ebx
  800bbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbf:	ff d0                	call   *%eax
  800bc1:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bc4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc7:	8d 50 01             	lea    0x1(%eax),%edx
  800bca:	89 55 10             	mov    %edx,0x10(%ebp)
  800bcd:	8a 00                	mov    (%eax),%al
  800bcf:	0f b6 d8             	movzbl %al,%ebx
  800bd2:	83 fb 25             	cmp    $0x25,%ebx
  800bd5:	75 d6                	jne    800bad <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bd7:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bdb:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800be2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800be9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bf0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bf7:	8b 45 10             	mov    0x10(%ebp),%eax
  800bfa:	8d 50 01             	lea    0x1(%eax),%edx
  800bfd:	89 55 10             	mov    %edx,0x10(%ebp)
  800c00:	8a 00                	mov    (%eax),%al
  800c02:	0f b6 d8             	movzbl %al,%ebx
  800c05:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c08:	83 f8 55             	cmp    $0x55,%eax
  800c0b:	0f 87 2b 03 00 00    	ja     800f3c <vprintfmt+0x399>
  800c11:	8b 04 85 f8 2b 80 00 	mov    0x802bf8(,%eax,4),%eax
  800c18:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c1a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c1e:	eb d7                	jmp    800bf7 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c20:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c24:	eb d1                	jmp    800bf7 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c26:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c2d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c30:	89 d0                	mov    %edx,%eax
  800c32:	c1 e0 02             	shl    $0x2,%eax
  800c35:	01 d0                	add    %edx,%eax
  800c37:	01 c0                	add    %eax,%eax
  800c39:	01 d8                	add    %ebx,%eax
  800c3b:	83 e8 30             	sub    $0x30,%eax
  800c3e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c41:	8b 45 10             	mov    0x10(%ebp),%eax
  800c44:	8a 00                	mov    (%eax),%al
  800c46:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c49:	83 fb 2f             	cmp    $0x2f,%ebx
  800c4c:	7e 3e                	jle    800c8c <vprintfmt+0xe9>
  800c4e:	83 fb 39             	cmp    $0x39,%ebx
  800c51:	7f 39                	jg     800c8c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c53:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c56:	eb d5                	jmp    800c2d <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c58:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5b:	83 c0 04             	add    $0x4,%eax
  800c5e:	89 45 14             	mov    %eax,0x14(%ebp)
  800c61:	8b 45 14             	mov    0x14(%ebp),%eax
  800c64:	83 e8 04             	sub    $0x4,%eax
  800c67:	8b 00                	mov    (%eax),%eax
  800c69:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c6c:	eb 1f                	jmp    800c8d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c6e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c72:	79 83                	jns    800bf7 <vprintfmt+0x54>
				width = 0;
  800c74:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c7b:	e9 77 ff ff ff       	jmp    800bf7 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c80:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c87:	e9 6b ff ff ff       	jmp    800bf7 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c8c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c8d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c91:	0f 89 60 ff ff ff    	jns    800bf7 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c97:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c9a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c9d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800ca4:	e9 4e ff ff ff       	jmp    800bf7 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ca9:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800cac:	e9 46 ff ff ff       	jmp    800bf7 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cb1:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb4:	83 c0 04             	add    $0x4,%eax
  800cb7:	89 45 14             	mov    %eax,0x14(%ebp)
  800cba:	8b 45 14             	mov    0x14(%ebp),%eax
  800cbd:	83 e8 04             	sub    $0x4,%eax
  800cc0:	8b 00                	mov    (%eax),%eax
  800cc2:	83 ec 08             	sub    $0x8,%esp
  800cc5:	ff 75 0c             	pushl  0xc(%ebp)
  800cc8:	50                   	push   %eax
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	ff d0                	call   *%eax
  800cce:	83 c4 10             	add    $0x10,%esp
			break;
  800cd1:	e9 89 02 00 00       	jmp    800f5f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cd6:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd9:	83 c0 04             	add    $0x4,%eax
  800cdc:	89 45 14             	mov    %eax,0x14(%ebp)
  800cdf:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce2:	83 e8 04             	sub    $0x4,%eax
  800ce5:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ce7:	85 db                	test   %ebx,%ebx
  800ce9:	79 02                	jns    800ced <vprintfmt+0x14a>
				err = -err;
  800ceb:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ced:	83 fb 64             	cmp    $0x64,%ebx
  800cf0:	7f 0b                	jg     800cfd <vprintfmt+0x15a>
  800cf2:	8b 34 9d 40 2a 80 00 	mov    0x802a40(,%ebx,4),%esi
  800cf9:	85 f6                	test   %esi,%esi
  800cfb:	75 19                	jne    800d16 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cfd:	53                   	push   %ebx
  800cfe:	68 e5 2b 80 00       	push   $0x802be5
  800d03:	ff 75 0c             	pushl  0xc(%ebp)
  800d06:	ff 75 08             	pushl  0x8(%ebp)
  800d09:	e8 5e 02 00 00       	call   800f6c <printfmt>
  800d0e:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d11:	e9 49 02 00 00       	jmp    800f5f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d16:	56                   	push   %esi
  800d17:	68 ee 2b 80 00       	push   $0x802bee
  800d1c:	ff 75 0c             	pushl  0xc(%ebp)
  800d1f:	ff 75 08             	pushl  0x8(%ebp)
  800d22:	e8 45 02 00 00       	call   800f6c <printfmt>
  800d27:	83 c4 10             	add    $0x10,%esp
			break;
  800d2a:	e9 30 02 00 00       	jmp    800f5f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d2f:	8b 45 14             	mov    0x14(%ebp),%eax
  800d32:	83 c0 04             	add    $0x4,%eax
  800d35:	89 45 14             	mov    %eax,0x14(%ebp)
  800d38:	8b 45 14             	mov    0x14(%ebp),%eax
  800d3b:	83 e8 04             	sub    $0x4,%eax
  800d3e:	8b 30                	mov    (%eax),%esi
  800d40:	85 f6                	test   %esi,%esi
  800d42:	75 05                	jne    800d49 <vprintfmt+0x1a6>
				p = "(null)";
  800d44:	be f1 2b 80 00       	mov    $0x802bf1,%esi
			if (width > 0 && padc != '-')
  800d49:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d4d:	7e 6d                	jle    800dbc <vprintfmt+0x219>
  800d4f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d53:	74 67                	je     800dbc <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d55:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d58:	83 ec 08             	sub    $0x8,%esp
  800d5b:	50                   	push   %eax
  800d5c:	56                   	push   %esi
  800d5d:	e8 12 05 00 00       	call   801274 <strnlen>
  800d62:	83 c4 10             	add    $0x10,%esp
  800d65:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d68:	eb 16                	jmp    800d80 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d6a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d6e:	83 ec 08             	sub    $0x8,%esp
  800d71:	ff 75 0c             	pushl  0xc(%ebp)
  800d74:	50                   	push   %eax
  800d75:	8b 45 08             	mov    0x8(%ebp),%eax
  800d78:	ff d0                	call   *%eax
  800d7a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d7d:	ff 4d e4             	decl   -0x1c(%ebp)
  800d80:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d84:	7f e4                	jg     800d6a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d86:	eb 34                	jmp    800dbc <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d88:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d8c:	74 1c                	je     800daa <vprintfmt+0x207>
  800d8e:	83 fb 1f             	cmp    $0x1f,%ebx
  800d91:	7e 05                	jle    800d98 <vprintfmt+0x1f5>
  800d93:	83 fb 7e             	cmp    $0x7e,%ebx
  800d96:	7e 12                	jle    800daa <vprintfmt+0x207>
					putch('?', putdat);
  800d98:	83 ec 08             	sub    $0x8,%esp
  800d9b:	ff 75 0c             	pushl  0xc(%ebp)
  800d9e:	6a 3f                	push   $0x3f
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
  800da3:	ff d0                	call   *%eax
  800da5:	83 c4 10             	add    $0x10,%esp
  800da8:	eb 0f                	jmp    800db9 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800daa:	83 ec 08             	sub    $0x8,%esp
  800dad:	ff 75 0c             	pushl  0xc(%ebp)
  800db0:	53                   	push   %ebx
  800db1:	8b 45 08             	mov    0x8(%ebp),%eax
  800db4:	ff d0                	call   *%eax
  800db6:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800db9:	ff 4d e4             	decl   -0x1c(%ebp)
  800dbc:	89 f0                	mov    %esi,%eax
  800dbe:	8d 70 01             	lea    0x1(%eax),%esi
  800dc1:	8a 00                	mov    (%eax),%al
  800dc3:	0f be d8             	movsbl %al,%ebx
  800dc6:	85 db                	test   %ebx,%ebx
  800dc8:	74 24                	je     800dee <vprintfmt+0x24b>
  800dca:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dce:	78 b8                	js     800d88 <vprintfmt+0x1e5>
  800dd0:	ff 4d e0             	decl   -0x20(%ebp)
  800dd3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dd7:	79 af                	jns    800d88 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dd9:	eb 13                	jmp    800dee <vprintfmt+0x24b>
				putch(' ', putdat);
  800ddb:	83 ec 08             	sub    $0x8,%esp
  800dde:	ff 75 0c             	pushl  0xc(%ebp)
  800de1:	6a 20                	push   $0x20
  800de3:	8b 45 08             	mov    0x8(%ebp),%eax
  800de6:	ff d0                	call   *%eax
  800de8:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800deb:	ff 4d e4             	decl   -0x1c(%ebp)
  800dee:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800df2:	7f e7                	jg     800ddb <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800df4:	e9 66 01 00 00       	jmp    800f5f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800df9:	83 ec 08             	sub    $0x8,%esp
  800dfc:	ff 75 e8             	pushl  -0x18(%ebp)
  800dff:	8d 45 14             	lea    0x14(%ebp),%eax
  800e02:	50                   	push   %eax
  800e03:	e8 3c fd ff ff       	call   800b44 <getint>
  800e08:	83 c4 10             	add    $0x10,%esp
  800e0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e0e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e11:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e14:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e17:	85 d2                	test   %edx,%edx
  800e19:	79 23                	jns    800e3e <vprintfmt+0x29b>
				putch('-', putdat);
  800e1b:	83 ec 08             	sub    $0x8,%esp
  800e1e:	ff 75 0c             	pushl  0xc(%ebp)
  800e21:	6a 2d                	push   $0x2d
  800e23:	8b 45 08             	mov    0x8(%ebp),%eax
  800e26:	ff d0                	call   *%eax
  800e28:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e2e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e31:	f7 d8                	neg    %eax
  800e33:	83 d2 00             	adc    $0x0,%edx
  800e36:	f7 da                	neg    %edx
  800e38:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e3b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e3e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e45:	e9 bc 00 00 00       	jmp    800f06 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e4a:	83 ec 08             	sub    $0x8,%esp
  800e4d:	ff 75 e8             	pushl  -0x18(%ebp)
  800e50:	8d 45 14             	lea    0x14(%ebp),%eax
  800e53:	50                   	push   %eax
  800e54:	e8 84 fc ff ff       	call   800add <getuint>
  800e59:	83 c4 10             	add    $0x10,%esp
  800e5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e5f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e62:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e69:	e9 98 00 00 00       	jmp    800f06 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e6e:	83 ec 08             	sub    $0x8,%esp
  800e71:	ff 75 0c             	pushl  0xc(%ebp)
  800e74:	6a 58                	push   $0x58
  800e76:	8b 45 08             	mov    0x8(%ebp),%eax
  800e79:	ff d0                	call   *%eax
  800e7b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e7e:	83 ec 08             	sub    $0x8,%esp
  800e81:	ff 75 0c             	pushl  0xc(%ebp)
  800e84:	6a 58                	push   $0x58
  800e86:	8b 45 08             	mov    0x8(%ebp),%eax
  800e89:	ff d0                	call   *%eax
  800e8b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e8e:	83 ec 08             	sub    $0x8,%esp
  800e91:	ff 75 0c             	pushl  0xc(%ebp)
  800e94:	6a 58                	push   $0x58
  800e96:	8b 45 08             	mov    0x8(%ebp),%eax
  800e99:	ff d0                	call   *%eax
  800e9b:	83 c4 10             	add    $0x10,%esp
			break;
  800e9e:	e9 bc 00 00 00       	jmp    800f5f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ea3:	83 ec 08             	sub    $0x8,%esp
  800ea6:	ff 75 0c             	pushl  0xc(%ebp)
  800ea9:	6a 30                	push   $0x30
  800eab:	8b 45 08             	mov    0x8(%ebp),%eax
  800eae:	ff d0                	call   *%eax
  800eb0:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800eb3:	83 ec 08             	sub    $0x8,%esp
  800eb6:	ff 75 0c             	pushl  0xc(%ebp)
  800eb9:	6a 78                	push   $0x78
  800ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebe:	ff d0                	call   *%eax
  800ec0:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ec3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec6:	83 c0 04             	add    $0x4,%eax
  800ec9:	89 45 14             	mov    %eax,0x14(%ebp)
  800ecc:	8b 45 14             	mov    0x14(%ebp),%eax
  800ecf:	83 e8 04             	sub    $0x4,%eax
  800ed2:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ed4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ed7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ede:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ee5:	eb 1f                	jmp    800f06 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ee7:	83 ec 08             	sub    $0x8,%esp
  800eea:	ff 75 e8             	pushl  -0x18(%ebp)
  800eed:	8d 45 14             	lea    0x14(%ebp),%eax
  800ef0:	50                   	push   %eax
  800ef1:	e8 e7 fb ff ff       	call   800add <getuint>
  800ef6:	83 c4 10             	add    $0x10,%esp
  800ef9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800efc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800eff:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f06:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f0a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f0d:	83 ec 04             	sub    $0x4,%esp
  800f10:	52                   	push   %edx
  800f11:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f14:	50                   	push   %eax
  800f15:	ff 75 f4             	pushl  -0xc(%ebp)
  800f18:	ff 75 f0             	pushl  -0x10(%ebp)
  800f1b:	ff 75 0c             	pushl  0xc(%ebp)
  800f1e:	ff 75 08             	pushl  0x8(%ebp)
  800f21:	e8 00 fb ff ff       	call   800a26 <printnum>
  800f26:	83 c4 20             	add    $0x20,%esp
			break;
  800f29:	eb 34                	jmp    800f5f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f2b:	83 ec 08             	sub    $0x8,%esp
  800f2e:	ff 75 0c             	pushl  0xc(%ebp)
  800f31:	53                   	push   %ebx
  800f32:	8b 45 08             	mov    0x8(%ebp),%eax
  800f35:	ff d0                	call   *%eax
  800f37:	83 c4 10             	add    $0x10,%esp
			break;
  800f3a:	eb 23                	jmp    800f5f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f3c:	83 ec 08             	sub    $0x8,%esp
  800f3f:	ff 75 0c             	pushl  0xc(%ebp)
  800f42:	6a 25                	push   $0x25
  800f44:	8b 45 08             	mov    0x8(%ebp),%eax
  800f47:	ff d0                	call   *%eax
  800f49:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f4c:	ff 4d 10             	decl   0x10(%ebp)
  800f4f:	eb 03                	jmp    800f54 <vprintfmt+0x3b1>
  800f51:	ff 4d 10             	decl   0x10(%ebp)
  800f54:	8b 45 10             	mov    0x10(%ebp),%eax
  800f57:	48                   	dec    %eax
  800f58:	8a 00                	mov    (%eax),%al
  800f5a:	3c 25                	cmp    $0x25,%al
  800f5c:	75 f3                	jne    800f51 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f5e:	90                   	nop
		}
	}
  800f5f:	e9 47 fc ff ff       	jmp    800bab <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f64:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f65:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f68:	5b                   	pop    %ebx
  800f69:	5e                   	pop    %esi
  800f6a:	5d                   	pop    %ebp
  800f6b:	c3                   	ret    

00800f6c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f6c:	55                   	push   %ebp
  800f6d:	89 e5                	mov    %esp,%ebp
  800f6f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f72:	8d 45 10             	lea    0x10(%ebp),%eax
  800f75:	83 c0 04             	add    $0x4,%eax
  800f78:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f7b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7e:	ff 75 f4             	pushl  -0xc(%ebp)
  800f81:	50                   	push   %eax
  800f82:	ff 75 0c             	pushl  0xc(%ebp)
  800f85:	ff 75 08             	pushl  0x8(%ebp)
  800f88:	e8 16 fc ff ff       	call   800ba3 <vprintfmt>
  800f8d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f90:	90                   	nop
  800f91:	c9                   	leave  
  800f92:	c3                   	ret    

00800f93 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f93:	55                   	push   %ebp
  800f94:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f99:	8b 40 08             	mov    0x8(%eax),%eax
  800f9c:	8d 50 01             	lea    0x1(%eax),%edx
  800f9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa2:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fa5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa8:	8b 10                	mov    (%eax),%edx
  800faa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fad:	8b 40 04             	mov    0x4(%eax),%eax
  800fb0:	39 c2                	cmp    %eax,%edx
  800fb2:	73 12                	jae    800fc6 <sprintputch+0x33>
		*b->buf++ = ch;
  800fb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb7:	8b 00                	mov    (%eax),%eax
  800fb9:	8d 48 01             	lea    0x1(%eax),%ecx
  800fbc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fbf:	89 0a                	mov    %ecx,(%edx)
  800fc1:	8b 55 08             	mov    0x8(%ebp),%edx
  800fc4:	88 10                	mov    %dl,(%eax)
}
  800fc6:	90                   	nop
  800fc7:	5d                   	pop    %ebp
  800fc8:	c3                   	ret    

00800fc9 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fc9:	55                   	push   %ebp
  800fca:	89 e5                	mov    %esp,%ebp
  800fcc:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fd5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fde:	01 d0                	add    %edx,%eax
  800fe0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fea:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fee:	74 06                	je     800ff6 <vsnprintf+0x2d>
  800ff0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ff4:	7f 07                	jg     800ffd <vsnprintf+0x34>
		return -E_INVAL;
  800ff6:	b8 03 00 00 00       	mov    $0x3,%eax
  800ffb:	eb 20                	jmp    80101d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ffd:	ff 75 14             	pushl  0x14(%ebp)
  801000:	ff 75 10             	pushl  0x10(%ebp)
  801003:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801006:	50                   	push   %eax
  801007:	68 93 0f 80 00       	push   $0x800f93
  80100c:	e8 92 fb ff ff       	call   800ba3 <vprintfmt>
  801011:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801014:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801017:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80101a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80101d:	c9                   	leave  
  80101e:	c3                   	ret    

0080101f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80101f:	55                   	push   %ebp
  801020:	89 e5                	mov    %esp,%ebp
  801022:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801025:	8d 45 10             	lea    0x10(%ebp),%eax
  801028:	83 c0 04             	add    $0x4,%eax
  80102b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80102e:	8b 45 10             	mov    0x10(%ebp),%eax
  801031:	ff 75 f4             	pushl  -0xc(%ebp)
  801034:	50                   	push   %eax
  801035:	ff 75 0c             	pushl  0xc(%ebp)
  801038:	ff 75 08             	pushl  0x8(%ebp)
  80103b:	e8 89 ff ff ff       	call   800fc9 <vsnprintf>
  801040:	83 c4 10             	add    $0x10,%esp
  801043:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801046:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801049:	c9                   	leave  
  80104a:	c3                   	ret    

0080104b <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80104b:	55                   	push   %ebp
  80104c:	89 e5                	mov    %esp,%ebp
  80104e:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801051:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801055:	74 13                	je     80106a <readline+0x1f>
		cprintf("%s", prompt);
  801057:	83 ec 08             	sub    $0x8,%esp
  80105a:	ff 75 08             	pushl  0x8(%ebp)
  80105d:	68 50 2d 80 00       	push   $0x802d50
  801062:	e8 62 f9 ff ff       	call   8009c9 <cprintf>
  801067:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80106a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801071:	83 ec 0c             	sub    $0xc,%esp
  801074:	6a 00                	push   $0x0
  801076:	e8 65 f5 ff ff       	call   8005e0 <iscons>
  80107b:	83 c4 10             	add    $0x10,%esp
  80107e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801081:	e8 0c f5 ff ff       	call   800592 <getchar>
  801086:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801089:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80108d:	79 22                	jns    8010b1 <readline+0x66>
			if (c != -E_EOF)
  80108f:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801093:	0f 84 ad 00 00 00    	je     801146 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801099:	83 ec 08             	sub    $0x8,%esp
  80109c:	ff 75 ec             	pushl  -0x14(%ebp)
  80109f:	68 53 2d 80 00       	push   $0x802d53
  8010a4:	e8 20 f9 ff ff       	call   8009c9 <cprintf>
  8010a9:	83 c4 10             	add    $0x10,%esp
			return;
  8010ac:	e9 95 00 00 00       	jmp    801146 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8010b1:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8010b5:	7e 34                	jle    8010eb <readline+0xa0>
  8010b7:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8010be:	7f 2b                	jg     8010eb <readline+0xa0>
			if (echoing)
  8010c0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010c4:	74 0e                	je     8010d4 <readline+0x89>
				cputchar(c);
  8010c6:	83 ec 0c             	sub    $0xc,%esp
  8010c9:	ff 75 ec             	pushl  -0x14(%ebp)
  8010cc:	e8 79 f4 ff ff       	call   80054a <cputchar>
  8010d1:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8010d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010d7:	8d 50 01             	lea    0x1(%eax),%edx
  8010da:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8010dd:	89 c2                	mov    %eax,%edx
  8010df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e2:	01 d0                	add    %edx,%eax
  8010e4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010e7:	88 10                	mov    %dl,(%eax)
  8010e9:	eb 56                	jmp    801141 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8010eb:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8010ef:	75 1f                	jne    801110 <readline+0xc5>
  8010f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8010f5:	7e 19                	jle    801110 <readline+0xc5>
			if (echoing)
  8010f7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010fb:	74 0e                	je     80110b <readline+0xc0>
				cputchar(c);
  8010fd:	83 ec 0c             	sub    $0xc,%esp
  801100:	ff 75 ec             	pushl  -0x14(%ebp)
  801103:	e8 42 f4 ff ff       	call   80054a <cputchar>
  801108:	83 c4 10             	add    $0x10,%esp

			i--;
  80110b:	ff 4d f4             	decl   -0xc(%ebp)
  80110e:	eb 31                	jmp    801141 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  801110:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801114:	74 0a                	je     801120 <readline+0xd5>
  801116:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80111a:	0f 85 61 ff ff ff    	jne    801081 <readline+0x36>
			if (echoing)
  801120:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801124:	74 0e                	je     801134 <readline+0xe9>
				cputchar(c);
  801126:	83 ec 0c             	sub    $0xc,%esp
  801129:	ff 75 ec             	pushl  -0x14(%ebp)
  80112c:	e8 19 f4 ff ff       	call   80054a <cputchar>
  801131:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801134:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801137:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113a:	01 d0                	add    %edx,%eax
  80113c:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80113f:	eb 06                	jmp    801147 <readline+0xfc>
		}
	}
  801141:	e9 3b ff ff ff       	jmp    801081 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801146:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801147:	c9                   	leave  
  801148:	c3                   	ret    

00801149 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801149:	55                   	push   %ebp
  80114a:	89 e5                	mov    %esp,%ebp
  80114c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80114f:	e8 4b 0e 00 00       	call   801f9f <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801154:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801158:	74 13                	je     80116d <atomic_readline+0x24>
		cprintf("%s", prompt);
  80115a:	83 ec 08             	sub    $0x8,%esp
  80115d:	ff 75 08             	pushl  0x8(%ebp)
  801160:	68 50 2d 80 00       	push   $0x802d50
  801165:	e8 5f f8 ff ff       	call   8009c9 <cprintf>
  80116a:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80116d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801174:	83 ec 0c             	sub    $0xc,%esp
  801177:	6a 00                	push   $0x0
  801179:	e8 62 f4 ff ff       	call   8005e0 <iscons>
  80117e:	83 c4 10             	add    $0x10,%esp
  801181:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801184:	e8 09 f4 ff ff       	call   800592 <getchar>
  801189:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80118c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801190:	79 23                	jns    8011b5 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801192:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801196:	74 13                	je     8011ab <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801198:	83 ec 08             	sub    $0x8,%esp
  80119b:	ff 75 ec             	pushl  -0x14(%ebp)
  80119e:	68 53 2d 80 00       	push   $0x802d53
  8011a3:	e8 21 f8 ff ff       	call   8009c9 <cprintf>
  8011a8:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011ab:	e8 09 0e 00 00       	call   801fb9 <sys_enable_interrupt>
			return;
  8011b0:	e9 9a 00 00 00       	jmp    80124f <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011b5:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011b9:	7e 34                	jle    8011ef <atomic_readline+0xa6>
  8011bb:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011c2:	7f 2b                	jg     8011ef <atomic_readline+0xa6>
			if (echoing)
  8011c4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011c8:	74 0e                	je     8011d8 <atomic_readline+0x8f>
				cputchar(c);
  8011ca:	83 ec 0c             	sub    $0xc,%esp
  8011cd:	ff 75 ec             	pushl  -0x14(%ebp)
  8011d0:	e8 75 f3 ff ff       	call   80054a <cputchar>
  8011d5:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011db:	8d 50 01             	lea    0x1(%eax),%edx
  8011de:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011e1:	89 c2                	mov    %eax,%edx
  8011e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e6:	01 d0                	add    %edx,%eax
  8011e8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011eb:	88 10                	mov    %dl,(%eax)
  8011ed:	eb 5b                	jmp    80124a <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8011ef:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011f3:	75 1f                	jne    801214 <atomic_readline+0xcb>
  8011f5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011f9:	7e 19                	jle    801214 <atomic_readline+0xcb>
			if (echoing)
  8011fb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011ff:	74 0e                	je     80120f <atomic_readline+0xc6>
				cputchar(c);
  801201:	83 ec 0c             	sub    $0xc,%esp
  801204:	ff 75 ec             	pushl  -0x14(%ebp)
  801207:	e8 3e f3 ff ff       	call   80054a <cputchar>
  80120c:	83 c4 10             	add    $0x10,%esp
			i--;
  80120f:	ff 4d f4             	decl   -0xc(%ebp)
  801212:	eb 36                	jmp    80124a <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801214:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801218:	74 0a                	je     801224 <atomic_readline+0xdb>
  80121a:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80121e:	0f 85 60 ff ff ff    	jne    801184 <atomic_readline+0x3b>
			if (echoing)
  801224:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801228:	74 0e                	je     801238 <atomic_readline+0xef>
				cputchar(c);
  80122a:	83 ec 0c             	sub    $0xc,%esp
  80122d:	ff 75 ec             	pushl  -0x14(%ebp)
  801230:	e8 15 f3 ff ff       	call   80054a <cputchar>
  801235:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801238:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80123b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123e:	01 d0                	add    %edx,%eax
  801240:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801243:	e8 71 0d 00 00       	call   801fb9 <sys_enable_interrupt>
			return;
  801248:	eb 05                	jmp    80124f <atomic_readline+0x106>
		}
	}
  80124a:	e9 35 ff ff ff       	jmp    801184 <atomic_readline+0x3b>
}
  80124f:	c9                   	leave  
  801250:	c3                   	ret    

00801251 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801251:	55                   	push   %ebp
  801252:	89 e5                	mov    %esp,%ebp
  801254:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801257:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80125e:	eb 06                	jmp    801266 <strlen+0x15>
		n++;
  801260:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801263:	ff 45 08             	incl   0x8(%ebp)
  801266:	8b 45 08             	mov    0x8(%ebp),%eax
  801269:	8a 00                	mov    (%eax),%al
  80126b:	84 c0                	test   %al,%al
  80126d:	75 f1                	jne    801260 <strlen+0xf>
		n++;
	return n;
  80126f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801272:	c9                   	leave  
  801273:	c3                   	ret    

00801274 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801274:	55                   	push   %ebp
  801275:	89 e5                	mov    %esp,%ebp
  801277:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80127a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801281:	eb 09                	jmp    80128c <strnlen+0x18>
		n++;
  801283:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801286:	ff 45 08             	incl   0x8(%ebp)
  801289:	ff 4d 0c             	decl   0xc(%ebp)
  80128c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801290:	74 09                	je     80129b <strnlen+0x27>
  801292:	8b 45 08             	mov    0x8(%ebp),%eax
  801295:	8a 00                	mov    (%eax),%al
  801297:	84 c0                	test   %al,%al
  801299:	75 e8                	jne    801283 <strnlen+0xf>
		n++;
	return n;
  80129b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80129e:	c9                   	leave  
  80129f:	c3                   	ret    

008012a0 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8012a0:	55                   	push   %ebp
  8012a1:	89 e5                	mov    %esp,%ebp
  8012a3:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8012a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012ac:	90                   	nop
  8012ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b0:	8d 50 01             	lea    0x1(%eax),%edx
  8012b3:	89 55 08             	mov    %edx,0x8(%ebp)
  8012b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012bc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012bf:	8a 12                	mov    (%edx),%dl
  8012c1:	88 10                	mov    %dl,(%eax)
  8012c3:	8a 00                	mov    (%eax),%al
  8012c5:	84 c0                	test   %al,%al
  8012c7:	75 e4                	jne    8012ad <strcpy+0xd>
		/* do nothing */;
	return ret;
  8012c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012cc:	c9                   	leave  
  8012cd:	c3                   	ret    

008012ce <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012ce:	55                   	push   %ebp
  8012cf:	89 e5                	mov    %esp,%ebp
  8012d1:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012e1:	eb 1f                	jmp    801302 <strncpy+0x34>
		*dst++ = *src;
  8012e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e6:	8d 50 01             	lea    0x1(%eax),%edx
  8012e9:	89 55 08             	mov    %edx,0x8(%ebp)
  8012ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ef:	8a 12                	mov    (%edx),%dl
  8012f1:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f6:	8a 00                	mov    (%eax),%al
  8012f8:	84 c0                	test   %al,%al
  8012fa:	74 03                	je     8012ff <strncpy+0x31>
			src++;
  8012fc:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012ff:	ff 45 fc             	incl   -0x4(%ebp)
  801302:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801305:	3b 45 10             	cmp    0x10(%ebp),%eax
  801308:	72 d9                	jb     8012e3 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80130a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80130d:	c9                   	leave  
  80130e:	c3                   	ret    

0080130f <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80130f:	55                   	push   %ebp
  801310:	89 e5                	mov    %esp,%ebp
  801312:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801315:	8b 45 08             	mov    0x8(%ebp),%eax
  801318:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80131b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80131f:	74 30                	je     801351 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801321:	eb 16                	jmp    801339 <strlcpy+0x2a>
			*dst++ = *src++;
  801323:	8b 45 08             	mov    0x8(%ebp),%eax
  801326:	8d 50 01             	lea    0x1(%eax),%edx
  801329:	89 55 08             	mov    %edx,0x8(%ebp)
  80132c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80132f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801332:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801335:	8a 12                	mov    (%edx),%dl
  801337:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801339:	ff 4d 10             	decl   0x10(%ebp)
  80133c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801340:	74 09                	je     80134b <strlcpy+0x3c>
  801342:	8b 45 0c             	mov    0xc(%ebp),%eax
  801345:	8a 00                	mov    (%eax),%al
  801347:	84 c0                	test   %al,%al
  801349:	75 d8                	jne    801323 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80134b:	8b 45 08             	mov    0x8(%ebp),%eax
  80134e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801351:	8b 55 08             	mov    0x8(%ebp),%edx
  801354:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801357:	29 c2                	sub    %eax,%edx
  801359:	89 d0                	mov    %edx,%eax
}
  80135b:	c9                   	leave  
  80135c:	c3                   	ret    

0080135d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80135d:	55                   	push   %ebp
  80135e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801360:	eb 06                	jmp    801368 <strcmp+0xb>
		p++, q++;
  801362:	ff 45 08             	incl   0x8(%ebp)
  801365:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801368:	8b 45 08             	mov    0x8(%ebp),%eax
  80136b:	8a 00                	mov    (%eax),%al
  80136d:	84 c0                	test   %al,%al
  80136f:	74 0e                	je     80137f <strcmp+0x22>
  801371:	8b 45 08             	mov    0x8(%ebp),%eax
  801374:	8a 10                	mov    (%eax),%dl
  801376:	8b 45 0c             	mov    0xc(%ebp),%eax
  801379:	8a 00                	mov    (%eax),%al
  80137b:	38 c2                	cmp    %al,%dl
  80137d:	74 e3                	je     801362 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80137f:	8b 45 08             	mov    0x8(%ebp),%eax
  801382:	8a 00                	mov    (%eax),%al
  801384:	0f b6 d0             	movzbl %al,%edx
  801387:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138a:	8a 00                	mov    (%eax),%al
  80138c:	0f b6 c0             	movzbl %al,%eax
  80138f:	29 c2                	sub    %eax,%edx
  801391:	89 d0                	mov    %edx,%eax
}
  801393:	5d                   	pop    %ebp
  801394:	c3                   	ret    

00801395 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801395:	55                   	push   %ebp
  801396:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801398:	eb 09                	jmp    8013a3 <strncmp+0xe>
		n--, p++, q++;
  80139a:	ff 4d 10             	decl   0x10(%ebp)
  80139d:	ff 45 08             	incl   0x8(%ebp)
  8013a0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013a3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013a7:	74 17                	je     8013c0 <strncmp+0x2b>
  8013a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ac:	8a 00                	mov    (%eax),%al
  8013ae:	84 c0                	test   %al,%al
  8013b0:	74 0e                	je     8013c0 <strncmp+0x2b>
  8013b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b5:	8a 10                	mov    (%eax),%dl
  8013b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ba:	8a 00                	mov    (%eax),%al
  8013bc:	38 c2                	cmp    %al,%dl
  8013be:	74 da                	je     80139a <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013c0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013c4:	75 07                	jne    8013cd <strncmp+0x38>
		return 0;
  8013c6:	b8 00 00 00 00       	mov    $0x0,%eax
  8013cb:	eb 14                	jmp    8013e1 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8013cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d0:	8a 00                	mov    (%eax),%al
  8013d2:	0f b6 d0             	movzbl %al,%edx
  8013d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d8:	8a 00                	mov    (%eax),%al
  8013da:	0f b6 c0             	movzbl %al,%eax
  8013dd:	29 c2                	sub    %eax,%edx
  8013df:	89 d0                	mov    %edx,%eax
}
  8013e1:	5d                   	pop    %ebp
  8013e2:	c3                   	ret    

008013e3 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013e3:	55                   	push   %ebp
  8013e4:	89 e5                	mov    %esp,%ebp
  8013e6:	83 ec 04             	sub    $0x4,%esp
  8013e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ec:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013ef:	eb 12                	jmp    801403 <strchr+0x20>
		if (*s == c)
  8013f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f4:	8a 00                	mov    (%eax),%al
  8013f6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013f9:	75 05                	jne    801400 <strchr+0x1d>
			return (char *) s;
  8013fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fe:	eb 11                	jmp    801411 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801400:	ff 45 08             	incl   0x8(%ebp)
  801403:	8b 45 08             	mov    0x8(%ebp),%eax
  801406:	8a 00                	mov    (%eax),%al
  801408:	84 c0                	test   %al,%al
  80140a:	75 e5                	jne    8013f1 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80140c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801411:	c9                   	leave  
  801412:	c3                   	ret    

00801413 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801413:	55                   	push   %ebp
  801414:	89 e5                	mov    %esp,%ebp
  801416:	83 ec 04             	sub    $0x4,%esp
  801419:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80141f:	eb 0d                	jmp    80142e <strfind+0x1b>
		if (*s == c)
  801421:	8b 45 08             	mov    0x8(%ebp),%eax
  801424:	8a 00                	mov    (%eax),%al
  801426:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801429:	74 0e                	je     801439 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80142b:	ff 45 08             	incl   0x8(%ebp)
  80142e:	8b 45 08             	mov    0x8(%ebp),%eax
  801431:	8a 00                	mov    (%eax),%al
  801433:	84 c0                	test   %al,%al
  801435:	75 ea                	jne    801421 <strfind+0xe>
  801437:	eb 01                	jmp    80143a <strfind+0x27>
		if (*s == c)
			break;
  801439:	90                   	nop
	return (char *) s;
  80143a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80143d:	c9                   	leave  
  80143e:	c3                   	ret    

0080143f <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80143f:	55                   	push   %ebp
  801440:	89 e5                	mov    %esp,%ebp
  801442:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801445:	8b 45 08             	mov    0x8(%ebp),%eax
  801448:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80144b:	8b 45 10             	mov    0x10(%ebp),%eax
  80144e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801451:	eb 0e                	jmp    801461 <memset+0x22>
		*p++ = c;
  801453:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801456:	8d 50 01             	lea    0x1(%eax),%edx
  801459:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80145c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80145f:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801461:	ff 4d f8             	decl   -0x8(%ebp)
  801464:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801468:	79 e9                	jns    801453 <memset+0x14>
		*p++ = c;

	return v;
  80146a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80146d:	c9                   	leave  
  80146e:	c3                   	ret    

0080146f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80146f:	55                   	push   %ebp
  801470:	89 e5                	mov    %esp,%ebp
  801472:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801475:	8b 45 0c             	mov    0xc(%ebp),%eax
  801478:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80147b:	8b 45 08             	mov    0x8(%ebp),%eax
  80147e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801481:	eb 16                	jmp    801499 <memcpy+0x2a>
		*d++ = *s++;
  801483:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801486:	8d 50 01             	lea    0x1(%eax),%edx
  801489:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80148c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80148f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801492:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801495:	8a 12                	mov    (%edx),%dl
  801497:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801499:	8b 45 10             	mov    0x10(%ebp),%eax
  80149c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80149f:	89 55 10             	mov    %edx,0x10(%ebp)
  8014a2:	85 c0                	test   %eax,%eax
  8014a4:	75 dd                	jne    801483 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8014a6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014a9:	c9                   	leave  
  8014aa:	c3                   	ret    

008014ab <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014ab:	55                   	push   %ebp
  8014ac:	89 e5                	mov    %esp,%ebp
  8014ae:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ba:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014c0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014c3:	73 50                	jae    801515 <memmove+0x6a>
  8014c5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8014cb:	01 d0                	add    %edx,%eax
  8014cd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014d0:	76 43                	jbe    801515 <memmove+0x6a>
		s += n;
  8014d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d5:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8014db:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014de:	eb 10                	jmp    8014f0 <memmove+0x45>
			*--d = *--s;
  8014e0:	ff 4d f8             	decl   -0x8(%ebp)
  8014e3:	ff 4d fc             	decl   -0x4(%ebp)
  8014e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014e9:	8a 10                	mov    (%eax),%dl
  8014eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ee:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014f6:	89 55 10             	mov    %edx,0x10(%ebp)
  8014f9:	85 c0                	test   %eax,%eax
  8014fb:	75 e3                	jne    8014e0 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014fd:	eb 23                	jmp    801522 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801502:	8d 50 01             	lea    0x1(%eax),%edx
  801505:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801508:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80150b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80150e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801511:	8a 12                	mov    (%edx),%dl
  801513:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801515:	8b 45 10             	mov    0x10(%ebp),%eax
  801518:	8d 50 ff             	lea    -0x1(%eax),%edx
  80151b:	89 55 10             	mov    %edx,0x10(%ebp)
  80151e:	85 c0                	test   %eax,%eax
  801520:	75 dd                	jne    8014ff <memmove+0x54>
			*d++ = *s++;

	return dst;
  801522:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801525:	c9                   	leave  
  801526:	c3                   	ret    

00801527 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801527:	55                   	push   %ebp
  801528:	89 e5                	mov    %esp,%ebp
  80152a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80152d:	8b 45 08             	mov    0x8(%ebp),%eax
  801530:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801533:	8b 45 0c             	mov    0xc(%ebp),%eax
  801536:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801539:	eb 2a                	jmp    801565 <memcmp+0x3e>
		if (*s1 != *s2)
  80153b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80153e:	8a 10                	mov    (%eax),%dl
  801540:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801543:	8a 00                	mov    (%eax),%al
  801545:	38 c2                	cmp    %al,%dl
  801547:	74 16                	je     80155f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801549:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80154c:	8a 00                	mov    (%eax),%al
  80154e:	0f b6 d0             	movzbl %al,%edx
  801551:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801554:	8a 00                	mov    (%eax),%al
  801556:	0f b6 c0             	movzbl %al,%eax
  801559:	29 c2                	sub    %eax,%edx
  80155b:	89 d0                	mov    %edx,%eax
  80155d:	eb 18                	jmp    801577 <memcmp+0x50>
		s1++, s2++;
  80155f:	ff 45 fc             	incl   -0x4(%ebp)
  801562:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801565:	8b 45 10             	mov    0x10(%ebp),%eax
  801568:	8d 50 ff             	lea    -0x1(%eax),%edx
  80156b:	89 55 10             	mov    %edx,0x10(%ebp)
  80156e:	85 c0                	test   %eax,%eax
  801570:	75 c9                	jne    80153b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801572:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801577:	c9                   	leave  
  801578:	c3                   	ret    

00801579 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801579:	55                   	push   %ebp
  80157a:	89 e5                	mov    %esp,%ebp
  80157c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80157f:	8b 55 08             	mov    0x8(%ebp),%edx
  801582:	8b 45 10             	mov    0x10(%ebp),%eax
  801585:	01 d0                	add    %edx,%eax
  801587:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80158a:	eb 15                	jmp    8015a1 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80158c:	8b 45 08             	mov    0x8(%ebp),%eax
  80158f:	8a 00                	mov    (%eax),%al
  801591:	0f b6 d0             	movzbl %al,%edx
  801594:	8b 45 0c             	mov    0xc(%ebp),%eax
  801597:	0f b6 c0             	movzbl %al,%eax
  80159a:	39 c2                	cmp    %eax,%edx
  80159c:	74 0d                	je     8015ab <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80159e:	ff 45 08             	incl   0x8(%ebp)
  8015a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015a7:	72 e3                	jb     80158c <memfind+0x13>
  8015a9:	eb 01                	jmp    8015ac <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015ab:	90                   	nop
	return (void *) s;
  8015ac:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015af:	c9                   	leave  
  8015b0:	c3                   	ret    

008015b1 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015b1:	55                   	push   %ebp
  8015b2:	89 e5                	mov    %esp,%ebp
  8015b4:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015be:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015c5:	eb 03                	jmp    8015ca <strtol+0x19>
		s++;
  8015c7:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cd:	8a 00                	mov    (%eax),%al
  8015cf:	3c 20                	cmp    $0x20,%al
  8015d1:	74 f4                	je     8015c7 <strtol+0x16>
  8015d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d6:	8a 00                	mov    (%eax),%al
  8015d8:	3c 09                	cmp    $0x9,%al
  8015da:	74 eb                	je     8015c7 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015df:	8a 00                	mov    (%eax),%al
  8015e1:	3c 2b                	cmp    $0x2b,%al
  8015e3:	75 05                	jne    8015ea <strtol+0x39>
		s++;
  8015e5:	ff 45 08             	incl   0x8(%ebp)
  8015e8:	eb 13                	jmp    8015fd <strtol+0x4c>
	else if (*s == '-')
  8015ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ed:	8a 00                	mov    (%eax),%al
  8015ef:	3c 2d                	cmp    $0x2d,%al
  8015f1:	75 0a                	jne    8015fd <strtol+0x4c>
		s++, neg = 1;
  8015f3:	ff 45 08             	incl   0x8(%ebp)
  8015f6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015fd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801601:	74 06                	je     801609 <strtol+0x58>
  801603:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801607:	75 20                	jne    801629 <strtol+0x78>
  801609:	8b 45 08             	mov    0x8(%ebp),%eax
  80160c:	8a 00                	mov    (%eax),%al
  80160e:	3c 30                	cmp    $0x30,%al
  801610:	75 17                	jne    801629 <strtol+0x78>
  801612:	8b 45 08             	mov    0x8(%ebp),%eax
  801615:	40                   	inc    %eax
  801616:	8a 00                	mov    (%eax),%al
  801618:	3c 78                	cmp    $0x78,%al
  80161a:	75 0d                	jne    801629 <strtol+0x78>
		s += 2, base = 16;
  80161c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801620:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801627:	eb 28                	jmp    801651 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801629:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80162d:	75 15                	jne    801644 <strtol+0x93>
  80162f:	8b 45 08             	mov    0x8(%ebp),%eax
  801632:	8a 00                	mov    (%eax),%al
  801634:	3c 30                	cmp    $0x30,%al
  801636:	75 0c                	jne    801644 <strtol+0x93>
		s++, base = 8;
  801638:	ff 45 08             	incl   0x8(%ebp)
  80163b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801642:	eb 0d                	jmp    801651 <strtol+0xa0>
	else if (base == 0)
  801644:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801648:	75 07                	jne    801651 <strtol+0xa0>
		base = 10;
  80164a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801651:	8b 45 08             	mov    0x8(%ebp),%eax
  801654:	8a 00                	mov    (%eax),%al
  801656:	3c 2f                	cmp    $0x2f,%al
  801658:	7e 19                	jle    801673 <strtol+0xc2>
  80165a:	8b 45 08             	mov    0x8(%ebp),%eax
  80165d:	8a 00                	mov    (%eax),%al
  80165f:	3c 39                	cmp    $0x39,%al
  801661:	7f 10                	jg     801673 <strtol+0xc2>
			dig = *s - '0';
  801663:	8b 45 08             	mov    0x8(%ebp),%eax
  801666:	8a 00                	mov    (%eax),%al
  801668:	0f be c0             	movsbl %al,%eax
  80166b:	83 e8 30             	sub    $0x30,%eax
  80166e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801671:	eb 42                	jmp    8016b5 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801673:	8b 45 08             	mov    0x8(%ebp),%eax
  801676:	8a 00                	mov    (%eax),%al
  801678:	3c 60                	cmp    $0x60,%al
  80167a:	7e 19                	jle    801695 <strtol+0xe4>
  80167c:	8b 45 08             	mov    0x8(%ebp),%eax
  80167f:	8a 00                	mov    (%eax),%al
  801681:	3c 7a                	cmp    $0x7a,%al
  801683:	7f 10                	jg     801695 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801685:	8b 45 08             	mov    0x8(%ebp),%eax
  801688:	8a 00                	mov    (%eax),%al
  80168a:	0f be c0             	movsbl %al,%eax
  80168d:	83 e8 57             	sub    $0x57,%eax
  801690:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801693:	eb 20                	jmp    8016b5 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801695:	8b 45 08             	mov    0x8(%ebp),%eax
  801698:	8a 00                	mov    (%eax),%al
  80169a:	3c 40                	cmp    $0x40,%al
  80169c:	7e 39                	jle    8016d7 <strtol+0x126>
  80169e:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a1:	8a 00                	mov    (%eax),%al
  8016a3:	3c 5a                	cmp    $0x5a,%al
  8016a5:	7f 30                	jg     8016d7 <strtol+0x126>
			dig = *s - 'A' + 10;
  8016a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016aa:	8a 00                	mov    (%eax),%al
  8016ac:	0f be c0             	movsbl %al,%eax
  8016af:	83 e8 37             	sub    $0x37,%eax
  8016b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016b8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016bb:	7d 19                	jge    8016d6 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016bd:	ff 45 08             	incl   0x8(%ebp)
  8016c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016c3:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016c7:	89 c2                	mov    %eax,%edx
  8016c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016cc:	01 d0                	add    %edx,%eax
  8016ce:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016d1:	e9 7b ff ff ff       	jmp    801651 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016d6:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016d7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016db:	74 08                	je     8016e5 <strtol+0x134>
		*endptr = (char *) s;
  8016dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e0:	8b 55 08             	mov    0x8(%ebp),%edx
  8016e3:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016e5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016e9:	74 07                	je     8016f2 <strtol+0x141>
  8016eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ee:	f7 d8                	neg    %eax
  8016f0:	eb 03                	jmp    8016f5 <strtol+0x144>
  8016f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016f5:	c9                   	leave  
  8016f6:	c3                   	ret    

008016f7 <ltostr>:

void
ltostr(long value, char *str)
{
  8016f7:	55                   	push   %ebp
  8016f8:	89 e5                	mov    %esp,%ebp
  8016fa:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801704:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80170b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80170f:	79 13                	jns    801724 <ltostr+0x2d>
	{
		neg = 1;
  801711:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801718:	8b 45 0c             	mov    0xc(%ebp),%eax
  80171b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80171e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801721:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801724:	8b 45 08             	mov    0x8(%ebp),%eax
  801727:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80172c:	99                   	cltd   
  80172d:	f7 f9                	idiv   %ecx
  80172f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801732:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801735:	8d 50 01             	lea    0x1(%eax),%edx
  801738:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80173b:	89 c2                	mov    %eax,%edx
  80173d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801740:	01 d0                	add    %edx,%eax
  801742:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801745:	83 c2 30             	add    $0x30,%edx
  801748:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80174a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80174d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801752:	f7 e9                	imul   %ecx
  801754:	c1 fa 02             	sar    $0x2,%edx
  801757:	89 c8                	mov    %ecx,%eax
  801759:	c1 f8 1f             	sar    $0x1f,%eax
  80175c:	29 c2                	sub    %eax,%edx
  80175e:	89 d0                	mov    %edx,%eax
  801760:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801763:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801766:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80176b:	f7 e9                	imul   %ecx
  80176d:	c1 fa 02             	sar    $0x2,%edx
  801770:	89 c8                	mov    %ecx,%eax
  801772:	c1 f8 1f             	sar    $0x1f,%eax
  801775:	29 c2                	sub    %eax,%edx
  801777:	89 d0                	mov    %edx,%eax
  801779:	c1 e0 02             	shl    $0x2,%eax
  80177c:	01 d0                	add    %edx,%eax
  80177e:	01 c0                	add    %eax,%eax
  801780:	29 c1                	sub    %eax,%ecx
  801782:	89 ca                	mov    %ecx,%edx
  801784:	85 d2                	test   %edx,%edx
  801786:	75 9c                	jne    801724 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801788:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80178f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801792:	48                   	dec    %eax
  801793:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801796:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80179a:	74 3d                	je     8017d9 <ltostr+0xe2>
		start = 1 ;
  80179c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017a3:	eb 34                	jmp    8017d9 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8017a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ab:	01 d0                	add    %edx,%eax
  8017ad:	8a 00                	mov    (%eax),%al
  8017af:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017b2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b8:	01 c2                	add    %eax,%edx
  8017ba:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c0:	01 c8                	add    %ecx,%eax
  8017c2:	8a 00                	mov    (%eax),%al
  8017c4:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017c6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017cc:	01 c2                	add    %eax,%edx
  8017ce:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017d1:	88 02                	mov    %al,(%edx)
		start++ ;
  8017d3:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017d6:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017dc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017df:	7c c4                	jl     8017a5 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017e1:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e7:	01 d0                	add    %edx,%eax
  8017e9:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017ec:	90                   	nop
  8017ed:	c9                   	leave  
  8017ee:	c3                   	ret    

008017ef <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017ef:	55                   	push   %ebp
  8017f0:	89 e5                	mov    %esp,%ebp
  8017f2:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017f5:	ff 75 08             	pushl  0x8(%ebp)
  8017f8:	e8 54 fa ff ff       	call   801251 <strlen>
  8017fd:	83 c4 04             	add    $0x4,%esp
  801800:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801803:	ff 75 0c             	pushl  0xc(%ebp)
  801806:	e8 46 fa ff ff       	call   801251 <strlen>
  80180b:	83 c4 04             	add    $0x4,%esp
  80180e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801811:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801818:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80181f:	eb 17                	jmp    801838 <strcconcat+0x49>
		final[s] = str1[s] ;
  801821:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801824:	8b 45 10             	mov    0x10(%ebp),%eax
  801827:	01 c2                	add    %eax,%edx
  801829:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80182c:	8b 45 08             	mov    0x8(%ebp),%eax
  80182f:	01 c8                	add    %ecx,%eax
  801831:	8a 00                	mov    (%eax),%al
  801833:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801835:	ff 45 fc             	incl   -0x4(%ebp)
  801838:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80183b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80183e:	7c e1                	jl     801821 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801840:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801847:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80184e:	eb 1f                	jmp    80186f <strcconcat+0x80>
		final[s++] = str2[i] ;
  801850:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801853:	8d 50 01             	lea    0x1(%eax),%edx
  801856:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801859:	89 c2                	mov    %eax,%edx
  80185b:	8b 45 10             	mov    0x10(%ebp),%eax
  80185e:	01 c2                	add    %eax,%edx
  801860:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801863:	8b 45 0c             	mov    0xc(%ebp),%eax
  801866:	01 c8                	add    %ecx,%eax
  801868:	8a 00                	mov    (%eax),%al
  80186a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80186c:	ff 45 f8             	incl   -0x8(%ebp)
  80186f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801872:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801875:	7c d9                	jl     801850 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801877:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80187a:	8b 45 10             	mov    0x10(%ebp),%eax
  80187d:	01 d0                	add    %edx,%eax
  80187f:	c6 00 00             	movb   $0x0,(%eax)
}
  801882:	90                   	nop
  801883:	c9                   	leave  
  801884:	c3                   	ret    

00801885 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801885:	55                   	push   %ebp
  801886:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801888:	8b 45 14             	mov    0x14(%ebp),%eax
  80188b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801891:	8b 45 14             	mov    0x14(%ebp),%eax
  801894:	8b 00                	mov    (%eax),%eax
  801896:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80189d:	8b 45 10             	mov    0x10(%ebp),%eax
  8018a0:	01 d0                	add    %edx,%eax
  8018a2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018a8:	eb 0c                	jmp    8018b6 <strsplit+0x31>
			*string++ = 0;
  8018aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ad:	8d 50 01             	lea    0x1(%eax),%edx
  8018b0:	89 55 08             	mov    %edx,0x8(%ebp)
  8018b3:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b9:	8a 00                	mov    (%eax),%al
  8018bb:	84 c0                	test   %al,%al
  8018bd:	74 18                	je     8018d7 <strsplit+0x52>
  8018bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c2:	8a 00                	mov    (%eax),%al
  8018c4:	0f be c0             	movsbl %al,%eax
  8018c7:	50                   	push   %eax
  8018c8:	ff 75 0c             	pushl  0xc(%ebp)
  8018cb:	e8 13 fb ff ff       	call   8013e3 <strchr>
  8018d0:	83 c4 08             	add    $0x8,%esp
  8018d3:	85 c0                	test   %eax,%eax
  8018d5:	75 d3                	jne    8018aa <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8018d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018da:	8a 00                	mov    (%eax),%al
  8018dc:	84 c0                	test   %al,%al
  8018de:	74 5a                	je     80193a <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8018e0:	8b 45 14             	mov    0x14(%ebp),%eax
  8018e3:	8b 00                	mov    (%eax),%eax
  8018e5:	83 f8 0f             	cmp    $0xf,%eax
  8018e8:	75 07                	jne    8018f1 <strsplit+0x6c>
		{
			return 0;
  8018ea:	b8 00 00 00 00       	mov    $0x0,%eax
  8018ef:	eb 66                	jmp    801957 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018f1:	8b 45 14             	mov    0x14(%ebp),%eax
  8018f4:	8b 00                	mov    (%eax),%eax
  8018f6:	8d 48 01             	lea    0x1(%eax),%ecx
  8018f9:	8b 55 14             	mov    0x14(%ebp),%edx
  8018fc:	89 0a                	mov    %ecx,(%edx)
  8018fe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801905:	8b 45 10             	mov    0x10(%ebp),%eax
  801908:	01 c2                	add    %eax,%edx
  80190a:	8b 45 08             	mov    0x8(%ebp),%eax
  80190d:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80190f:	eb 03                	jmp    801914 <strsplit+0x8f>
			string++;
  801911:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801914:	8b 45 08             	mov    0x8(%ebp),%eax
  801917:	8a 00                	mov    (%eax),%al
  801919:	84 c0                	test   %al,%al
  80191b:	74 8b                	je     8018a8 <strsplit+0x23>
  80191d:	8b 45 08             	mov    0x8(%ebp),%eax
  801920:	8a 00                	mov    (%eax),%al
  801922:	0f be c0             	movsbl %al,%eax
  801925:	50                   	push   %eax
  801926:	ff 75 0c             	pushl  0xc(%ebp)
  801929:	e8 b5 fa ff ff       	call   8013e3 <strchr>
  80192e:	83 c4 08             	add    $0x8,%esp
  801931:	85 c0                	test   %eax,%eax
  801933:	74 dc                	je     801911 <strsplit+0x8c>
			string++;
	}
  801935:	e9 6e ff ff ff       	jmp    8018a8 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80193a:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80193b:	8b 45 14             	mov    0x14(%ebp),%eax
  80193e:	8b 00                	mov    (%eax),%eax
  801940:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801947:	8b 45 10             	mov    0x10(%ebp),%eax
  80194a:	01 d0                	add    %edx,%eax
  80194c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801952:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801957:	c9                   	leave  
  801958:	c3                   	ret    

00801959 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801959:	55                   	push   %ebp
  80195a:	89 e5                	mov    %esp,%ebp
  80195c:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  80195f:	e8 3b 09 00 00       	call   80229f <sys_isUHeapPlacementStrategyFIRSTFIT>
  801964:	85 c0                	test   %eax,%eax
  801966:	0f 84 3a 01 00 00    	je     801aa6 <malloc+0x14d>

		if(pl == 0){
  80196c:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801971:	85 c0                	test   %eax,%eax
  801973:	75 24                	jne    801999 <malloc+0x40>
			for(int k = 0; k < Size; k++){
  801975:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80197c:	eb 11                	jmp    80198f <malloc+0x36>
				arr[k] = -10000;
  80197e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801981:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801988:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  80198c:	ff 45 f4             	incl   -0xc(%ebp)
  80198f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801992:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801997:	76 e5                	jbe    80197e <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801999:	c7 05 2c 30 80 00 01 	movl   $0x1,0x80302c
  8019a0:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  8019a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a6:	c1 e8 0c             	shr    $0xc,%eax
  8019a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  8019ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8019af:	25 ff 0f 00 00       	and    $0xfff,%eax
  8019b4:	85 c0                	test   %eax,%eax
  8019b6:	74 03                	je     8019bb <malloc+0x62>
			x++;
  8019b8:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  8019bb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  8019c2:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  8019c9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8019d0:	eb 66                	jmp    801a38 <malloc+0xdf>
			if( arr[k] == -10000){
  8019d2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8019d5:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8019dc:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  8019e1:	75 52                	jne    801a35 <malloc+0xdc>
				uint32 w = 0 ;
  8019e3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  8019ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8019ed:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  8019f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8019f3:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8019f6:	eb 09                	jmp    801a01 <malloc+0xa8>
  8019f8:	ff 45 e0             	incl   -0x20(%ebp)
  8019fb:	ff 45 dc             	incl   -0x24(%ebp)
  8019fe:	ff 45 e4             	incl   -0x1c(%ebp)
  801a01:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801a04:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801a09:	77 19                	ja     801a24 <malloc+0xcb>
  801a0b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801a0e:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801a15:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801a1a:	75 08                	jne    801a24 <malloc+0xcb>
  801a1c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a1f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a22:	72 d4                	jb     8019f8 <malloc+0x9f>
				if(w >= x){
  801a24:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a27:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a2a:	72 09                	jb     801a35 <malloc+0xdc>
					p = 1 ;
  801a2c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  801a33:	eb 0d                	jmp    801a42 <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801a35:	ff 45 e4             	incl   -0x1c(%ebp)
  801a38:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a3b:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801a40:	76 90                	jbe    8019d2 <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  801a42:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801a46:	75 0a                	jne    801a52 <malloc+0xf9>
  801a48:	b8 00 00 00 00       	mov    $0x0,%eax
  801a4d:	e9 ca 01 00 00       	jmp    801c1c <malloc+0x2c3>
		int q = idx;
  801a52:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a55:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  801a58:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801a5f:	eb 16                	jmp    801a77 <malloc+0x11e>
			arr[q++] = x;
  801a61:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a64:	8d 50 01             	lea    0x1(%eax),%edx
  801a67:	89 55 d8             	mov    %edx,-0x28(%ebp)
  801a6a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a6d:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  801a74:	ff 45 d4             	incl   -0x2c(%ebp)
  801a77:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a7a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a7d:	72 e2                	jb     801a61 <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801a7f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801a82:	05 00 00 08 00       	add    $0x80000,%eax
  801a87:	c1 e0 0c             	shl    $0xc,%eax
  801a8a:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  801a8d:	83 ec 08             	sub    $0x8,%esp
  801a90:	ff 75 f0             	pushl  -0x10(%ebp)
  801a93:	ff 75 ac             	pushl  -0x54(%ebp)
  801a96:	e8 9b 04 00 00       	call   801f36 <sys_allocateMem>
  801a9b:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801a9e:	8b 45 ac             	mov    -0x54(%ebp),%eax
  801aa1:	e9 76 01 00 00       	jmp    801c1c <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  801aa6:	e8 25 08 00 00       	call   8022d0 <sys_isUHeapPlacementStrategyBESTFIT>
  801aab:	85 c0                	test   %eax,%eax
  801aad:	0f 84 64 01 00 00    	je     801c17 <malloc+0x2be>
		if(pl == 0){
  801ab3:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801ab8:	85 c0                	test   %eax,%eax
  801aba:	75 24                	jne    801ae0 <malloc+0x187>
			for(int k = 0; k < Size; k++){
  801abc:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  801ac3:	eb 11                	jmp    801ad6 <malloc+0x17d>
				arr[k] = -10000;
  801ac5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ac8:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801acf:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801ad3:	ff 45 d0             	incl   -0x30(%ebp)
  801ad6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ad9:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801ade:	76 e5                	jbe    801ac5 <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801ae0:	c7 05 2c 30 80 00 01 	movl   $0x1,0x80302c
  801ae7:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801aea:	8b 45 08             	mov    0x8(%ebp),%eax
  801aed:	c1 e8 0c             	shr    $0xc,%eax
  801af0:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  801af3:	8b 45 08             	mov    0x8(%ebp),%eax
  801af6:	25 ff 0f 00 00       	and    $0xfff,%eax
  801afb:	85 c0                	test   %eax,%eax
  801afd:	74 03                	je     801b02 <malloc+0x1a9>
			x++;
  801aff:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  801b02:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  801b09:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  801b10:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  801b17:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  801b1e:	e9 88 00 00 00       	jmp    801bab <malloc+0x252>
			if(arr[k] == -10000){
  801b23:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801b26:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801b2d:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801b32:	75 64                	jne    801b98 <malloc+0x23f>
				uint32 w = 0 , i;
  801b34:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  801b3b:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801b3e:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  801b41:	eb 06                	jmp    801b49 <malloc+0x1f0>
  801b43:	ff 45 b8             	incl   -0x48(%ebp)
  801b46:	ff 45 b4             	incl   -0x4c(%ebp)
  801b49:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  801b50:	77 11                	ja     801b63 <malloc+0x20a>
  801b52:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801b55:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801b5c:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801b61:	74 e0                	je     801b43 <malloc+0x1ea>
				if(w <q && w >= x){
  801b63:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801b66:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  801b69:	73 24                	jae    801b8f <malloc+0x236>
  801b6b:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801b6e:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801b71:	72 1c                	jb     801b8f <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  801b73:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801b76:	89 45 c8             	mov    %eax,-0x38(%ebp)
  801b79:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  801b80:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801b83:	89 45 c0             	mov    %eax,-0x40(%ebp)
  801b86:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801b89:	48                   	dec    %eax
  801b8a:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801b8d:	eb 19                	jmp    801ba8 <malloc+0x24f>
				}
				else {
					k = i - 1;
  801b8f:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801b92:	48                   	dec    %eax
  801b93:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801b96:	eb 10                	jmp    801ba8 <malloc+0x24f>
				}
			} else {
				k += arr[k];
  801b98:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801b9b:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801ba2:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  801ba5:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  801ba8:	ff 45 bc             	incl   -0x44(%ebp)
  801bab:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801bae:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801bb3:	0f 86 6a ff ff ff    	jbe    801b23 <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  801bb9:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  801bbd:	75 07                	jne    801bc6 <malloc+0x26d>
  801bbf:	b8 00 00 00 00       	mov    $0x0,%eax
  801bc4:	eb 56                	jmp    801c1c <malloc+0x2c3>
	    q = idx;
  801bc6:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801bc9:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  801bcc:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  801bd3:	eb 16                	jmp    801beb <malloc+0x292>
			arr[q++] = x;
  801bd5:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801bd8:	8d 50 01             	lea    0x1(%eax),%edx
  801bdb:	89 55 c8             	mov    %edx,-0x38(%ebp)
  801bde:	8b 55 cc             	mov    -0x34(%ebp),%edx
  801be1:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  801be8:	ff 45 b0             	incl   -0x50(%ebp)
  801beb:	8b 45 b0             	mov    -0x50(%ebp),%eax
  801bee:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801bf1:	72 e2                	jb     801bd5 <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801bf3:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801bf6:	05 00 00 08 00       	add    $0x80000,%eax
  801bfb:	c1 e0 0c             	shl    $0xc,%eax
  801bfe:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  801c01:	83 ec 08             	sub    $0x8,%esp
  801c04:	ff 75 cc             	pushl  -0x34(%ebp)
  801c07:	ff 75 a8             	pushl  -0x58(%ebp)
  801c0a:	e8 27 03 00 00       	call   801f36 <sys_allocateMem>
  801c0f:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801c12:	8b 45 a8             	mov    -0x58(%ebp),%eax
  801c15:	eb 05                	jmp    801c1c <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  801c17:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c1c:	c9                   	leave  
  801c1d:	c3                   	ret    

00801c1e <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801c1e:	55                   	push   %ebp
  801c1f:	89 e5                	mov    %esp,%ebp
  801c21:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  801c24:	8b 45 08             	mov    0x8(%ebp),%eax
  801c27:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801c2a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c2d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801c32:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  801c35:	8b 45 08             	mov    0x8(%ebp),%eax
  801c38:	05 00 00 00 80       	add    $0x80000000,%eax
  801c3d:	c1 e8 0c             	shr    $0xc,%eax
  801c40:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801c47:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801c4a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801c51:	8b 45 08             	mov    0x8(%ebp),%eax
  801c54:	05 00 00 00 80       	add    $0x80000000,%eax
  801c59:	c1 e8 0c             	shr    $0xc,%eax
  801c5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c5f:	eb 14                	jmp    801c75 <free+0x57>
		arr[j] = -10000;
  801c61:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c64:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801c6b:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801c6f:	ff 45 f4             	incl   -0xc(%ebp)
  801c72:	ff 45 f0             	incl   -0x10(%ebp)
  801c75:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c78:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801c7b:	72 e4                	jb     801c61 <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  801c7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c80:	83 ec 08             	sub    $0x8,%esp
  801c83:	ff 75 e8             	pushl  -0x18(%ebp)
  801c86:	50                   	push   %eax
  801c87:	e8 8e 02 00 00       	call   801f1a <sys_freeMem>
  801c8c:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  801c8f:	90                   	nop
  801c90:	c9                   	leave  
  801c91:	c3                   	ret    

00801c92 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801c92:	55                   	push   %ebp
  801c93:	89 e5                	mov    %esp,%ebp
  801c95:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c98:	83 ec 04             	sub    $0x4,%esp
  801c9b:	68 64 2d 80 00       	push   $0x802d64
  801ca0:	68 9e 00 00 00       	push   $0x9e
  801ca5:	68 87 2d 80 00       	push   $0x802d87
  801caa:	e8 63 ea ff ff       	call   800712 <_panic>

00801caf <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801caf:	55                   	push   %ebp
  801cb0:	89 e5                	mov    %esp,%ebp
  801cb2:	83 ec 18             	sub    $0x18,%esp
  801cb5:	8b 45 10             	mov    0x10(%ebp),%eax
  801cb8:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801cbb:	83 ec 04             	sub    $0x4,%esp
  801cbe:	68 64 2d 80 00       	push   $0x802d64
  801cc3:	68 a9 00 00 00       	push   $0xa9
  801cc8:	68 87 2d 80 00       	push   $0x802d87
  801ccd:	e8 40 ea ff ff       	call   800712 <_panic>

00801cd2 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801cd2:	55                   	push   %ebp
  801cd3:	89 e5                	mov    %esp,%ebp
  801cd5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801cd8:	83 ec 04             	sub    $0x4,%esp
  801cdb:	68 64 2d 80 00       	push   $0x802d64
  801ce0:	68 af 00 00 00       	push   $0xaf
  801ce5:	68 87 2d 80 00       	push   $0x802d87
  801cea:	e8 23 ea ff ff       	call   800712 <_panic>

00801cef <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801cef:	55                   	push   %ebp
  801cf0:	89 e5                	mov    %esp,%ebp
  801cf2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801cf5:	83 ec 04             	sub    $0x4,%esp
  801cf8:	68 64 2d 80 00       	push   $0x802d64
  801cfd:	68 b5 00 00 00       	push   $0xb5
  801d02:	68 87 2d 80 00       	push   $0x802d87
  801d07:	e8 06 ea ff ff       	call   800712 <_panic>

00801d0c <expand>:
}

void expand(uint32 newSize)
{
  801d0c:	55                   	push   %ebp
  801d0d:	89 e5                	mov    %esp,%ebp
  801d0f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d12:	83 ec 04             	sub    $0x4,%esp
  801d15:	68 64 2d 80 00       	push   $0x802d64
  801d1a:	68 ba 00 00 00       	push   $0xba
  801d1f:	68 87 2d 80 00       	push   $0x802d87
  801d24:	e8 e9 e9 ff ff       	call   800712 <_panic>

00801d29 <shrink>:
}
void shrink(uint32 newSize)
{
  801d29:	55                   	push   %ebp
  801d2a:	89 e5                	mov    %esp,%ebp
  801d2c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d2f:	83 ec 04             	sub    $0x4,%esp
  801d32:	68 64 2d 80 00       	push   $0x802d64
  801d37:	68 be 00 00 00       	push   $0xbe
  801d3c:	68 87 2d 80 00       	push   $0x802d87
  801d41:	e8 cc e9 ff ff       	call   800712 <_panic>

00801d46 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801d46:	55                   	push   %ebp
  801d47:	89 e5                	mov    %esp,%ebp
  801d49:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d4c:	83 ec 04             	sub    $0x4,%esp
  801d4f:	68 64 2d 80 00       	push   $0x802d64
  801d54:	68 c3 00 00 00       	push   $0xc3
  801d59:	68 87 2d 80 00       	push   $0x802d87
  801d5e:	e8 af e9 ff ff       	call   800712 <_panic>

00801d63 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801d63:	55                   	push   %ebp
  801d64:	89 e5                	mov    %esp,%ebp
  801d66:	57                   	push   %edi
  801d67:	56                   	push   %esi
  801d68:	53                   	push   %ebx
  801d69:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801d6c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d6f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d72:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d75:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d78:	8b 7d 18             	mov    0x18(%ebp),%edi
  801d7b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801d7e:	cd 30                	int    $0x30
  801d80:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801d83:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d86:	83 c4 10             	add    $0x10,%esp
  801d89:	5b                   	pop    %ebx
  801d8a:	5e                   	pop    %esi
  801d8b:	5f                   	pop    %edi
  801d8c:	5d                   	pop    %ebp
  801d8d:	c3                   	ret    

00801d8e <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801d8e:	55                   	push   %ebp
  801d8f:	89 e5                	mov    %esp,%ebp
  801d91:	83 ec 04             	sub    $0x4,%esp
  801d94:	8b 45 10             	mov    0x10(%ebp),%eax
  801d97:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801d9a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801da1:	6a 00                	push   $0x0
  801da3:	6a 00                	push   $0x0
  801da5:	52                   	push   %edx
  801da6:	ff 75 0c             	pushl  0xc(%ebp)
  801da9:	50                   	push   %eax
  801daa:	6a 00                	push   $0x0
  801dac:	e8 b2 ff ff ff       	call   801d63 <syscall>
  801db1:	83 c4 18             	add    $0x18,%esp
}
  801db4:	90                   	nop
  801db5:	c9                   	leave  
  801db6:	c3                   	ret    

00801db7 <sys_cgetc>:

int
sys_cgetc(void)
{
  801db7:	55                   	push   %ebp
  801db8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801dba:	6a 00                	push   $0x0
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 01                	push   $0x1
  801dc6:	e8 98 ff ff ff       	call   801d63 <syscall>
  801dcb:	83 c4 18             	add    $0x18,%esp
}
  801dce:	c9                   	leave  
  801dcf:	c3                   	ret    

00801dd0 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801dd0:	55                   	push   %ebp
  801dd1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd6:	6a 00                	push   $0x0
  801dd8:	6a 00                	push   $0x0
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 00                	push   $0x0
  801dde:	50                   	push   %eax
  801ddf:	6a 05                	push   $0x5
  801de1:	e8 7d ff ff ff       	call   801d63 <syscall>
  801de6:	83 c4 18             	add    $0x18,%esp
}
  801de9:	c9                   	leave  
  801dea:	c3                   	ret    

00801deb <sys_getenvid>:

int32 sys_getenvid(void)
{
  801deb:	55                   	push   %ebp
  801dec:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801dee:	6a 00                	push   $0x0
  801df0:	6a 00                	push   $0x0
  801df2:	6a 00                	push   $0x0
  801df4:	6a 00                	push   $0x0
  801df6:	6a 00                	push   $0x0
  801df8:	6a 02                	push   $0x2
  801dfa:	e8 64 ff ff ff       	call   801d63 <syscall>
  801dff:	83 c4 18             	add    $0x18,%esp
}
  801e02:	c9                   	leave  
  801e03:	c3                   	ret    

00801e04 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801e04:	55                   	push   %ebp
  801e05:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801e07:	6a 00                	push   $0x0
  801e09:	6a 00                	push   $0x0
  801e0b:	6a 00                	push   $0x0
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 00                	push   $0x0
  801e11:	6a 03                	push   $0x3
  801e13:	e8 4b ff ff ff       	call   801d63 <syscall>
  801e18:	83 c4 18             	add    $0x18,%esp
}
  801e1b:	c9                   	leave  
  801e1c:	c3                   	ret    

00801e1d <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e1d:	55                   	push   %ebp
  801e1e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e20:	6a 00                	push   $0x0
  801e22:	6a 00                	push   $0x0
  801e24:	6a 00                	push   $0x0
  801e26:	6a 00                	push   $0x0
  801e28:	6a 00                	push   $0x0
  801e2a:	6a 04                	push   $0x4
  801e2c:	e8 32 ff ff ff       	call   801d63 <syscall>
  801e31:	83 c4 18             	add    $0x18,%esp
}
  801e34:	c9                   	leave  
  801e35:	c3                   	ret    

00801e36 <sys_env_exit>:


void sys_env_exit(void)
{
  801e36:	55                   	push   %ebp
  801e37:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801e39:	6a 00                	push   $0x0
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 00                	push   $0x0
  801e43:	6a 06                	push   $0x6
  801e45:	e8 19 ff ff ff       	call   801d63 <syscall>
  801e4a:	83 c4 18             	add    $0x18,%esp
}
  801e4d:	90                   	nop
  801e4e:	c9                   	leave  
  801e4f:	c3                   	ret    

00801e50 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801e50:	55                   	push   %ebp
  801e51:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801e53:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e56:	8b 45 08             	mov    0x8(%ebp),%eax
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 00                	push   $0x0
  801e5f:	52                   	push   %edx
  801e60:	50                   	push   %eax
  801e61:	6a 07                	push   $0x7
  801e63:	e8 fb fe ff ff       	call   801d63 <syscall>
  801e68:	83 c4 18             	add    $0x18,%esp
}
  801e6b:	c9                   	leave  
  801e6c:	c3                   	ret    

00801e6d <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801e6d:	55                   	push   %ebp
  801e6e:	89 e5                	mov    %esp,%ebp
  801e70:	56                   	push   %esi
  801e71:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801e72:	8b 75 18             	mov    0x18(%ebp),%esi
  801e75:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e78:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e7b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e81:	56                   	push   %esi
  801e82:	53                   	push   %ebx
  801e83:	51                   	push   %ecx
  801e84:	52                   	push   %edx
  801e85:	50                   	push   %eax
  801e86:	6a 08                	push   $0x8
  801e88:	e8 d6 fe ff ff       	call   801d63 <syscall>
  801e8d:	83 c4 18             	add    $0x18,%esp
}
  801e90:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801e93:	5b                   	pop    %ebx
  801e94:	5e                   	pop    %esi
  801e95:	5d                   	pop    %ebp
  801e96:	c3                   	ret    

00801e97 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801e97:	55                   	push   %ebp
  801e98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801e9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	6a 00                	push   $0x0
  801ea6:	52                   	push   %edx
  801ea7:	50                   	push   %eax
  801ea8:	6a 09                	push   $0x9
  801eaa:	e8 b4 fe ff ff       	call   801d63 <syscall>
  801eaf:	83 c4 18             	add    $0x18,%esp
}
  801eb2:	c9                   	leave  
  801eb3:	c3                   	ret    

00801eb4 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801eb4:	55                   	push   %ebp
  801eb5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801eb7:	6a 00                	push   $0x0
  801eb9:	6a 00                	push   $0x0
  801ebb:	6a 00                	push   $0x0
  801ebd:	ff 75 0c             	pushl  0xc(%ebp)
  801ec0:	ff 75 08             	pushl  0x8(%ebp)
  801ec3:	6a 0a                	push   $0xa
  801ec5:	e8 99 fe ff ff       	call   801d63 <syscall>
  801eca:	83 c4 18             	add    $0x18,%esp
}
  801ecd:	c9                   	leave  
  801ece:	c3                   	ret    

00801ecf <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801ecf:	55                   	push   %ebp
  801ed0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801ed2:	6a 00                	push   $0x0
  801ed4:	6a 00                	push   $0x0
  801ed6:	6a 00                	push   $0x0
  801ed8:	6a 00                	push   $0x0
  801eda:	6a 00                	push   $0x0
  801edc:	6a 0b                	push   $0xb
  801ede:	e8 80 fe ff ff       	call   801d63 <syscall>
  801ee3:	83 c4 18             	add    $0x18,%esp
}
  801ee6:	c9                   	leave  
  801ee7:	c3                   	ret    

00801ee8 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801ee8:	55                   	push   %ebp
  801ee9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801eeb:	6a 00                	push   $0x0
  801eed:	6a 00                	push   $0x0
  801eef:	6a 00                	push   $0x0
  801ef1:	6a 00                	push   $0x0
  801ef3:	6a 00                	push   $0x0
  801ef5:	6a 0c                	push   $0xc
  801ef7:	e8 67 fe ff ff       	call   801d63 <syscall>
  801efc:	83 c4 18             	add    $0x18,%esp
}
  801eff:	c9                   	leave  
  801f00:	c3                   	ret    

00801f01 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801f01:	55                   	push   %ebp
  801f02:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	6a 00                	push   $0x0
  801f0a:	6a 00                	push   $0x0
  801f0c:	6a 00                	push   $0x0
  801f0e:	6a 0d                	push   $0xd
  801f10:	e8 4e fe ff ff       	call   801d63 <syscall>
  801f15:	83 c4 18             	add    $0x18,%esp
}
  801f18:	c9                   	leave  
  801f19:	c3                   	ret    

00801f1a <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801f1a:	55                   	push   %ebp
  801f1b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801f1d:	6a 00                	push   $0x0
  801f1f:	6a 00                	push   $0x0
  801f21:	6a 00                	push   $0x0
  801f23:	ff 75 0c             	pushl  0xc(%ebp)
  801f26:	ff 75 08             	pushl  0x8(%ebp)
  801f29:	6a 11                	push   $0x11
  801f2b:	e8 33 fe ff ff       	call   801d63 <syscall>
  801f30:	83 c4 18             	add    $0x18,%esp
	return;
  801f33:	90                   	nop
}
  801f34:	c9                   	leave  
  801f35:	c3                   	ret    

00801f36 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801f36:	55                   	push   %ebp
  801f37:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801f39:	6a 00                	push   $0x0
  801f3b:	6a 00                	push   $0x0
  801f3d:	6a 00                	push   $0x0
  801f3f:	ff 75 0c             	pushl  0xc(%ebp)
  801f42:	ff 75 08             	pushl  0x8(%ebp)
  801f45:	6a 12                	push   $0x12
  801f47:	e8 17 fe ff ff       	call   801d63 <syscall>
  801f4c:	83 c4 18             	add    $0x18,%esp
	return ;
  801f4f:	90                   	nop
}
  801f50:	c9                   	leave  
  801f51:	c3                   	ret    

00801f52 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801f52:	55                   	push   %ebp
  801f53:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801f55:	6a 00                	push   $0x0
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	6a 00                	push   $0x0
  801f5d:	6a 00                	push   $0x0
  801f5f:	6a 0e                	push   $0xe
  801f61:	e8 fd fd ff ff       	call   801d63 <syscall>
  801f66:	83 c4 18             	add    $0x18,%esp
}
  801f69:	c9                   	leave  
  801f6a:	c3                   	ret    

00801f6b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801f6b:	55                   	push   %ebp
  801f6c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801f6e:	6a 00                	push   $0x0
  801f70:	6a 00                	push   $0x0
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	ff 75 08             	pushl  0x8(%ebp)
  801f79:	6a 0f                	push   $0xf
  801f7b:	e8 e3 fd ff ff       	call   801d63 <syscall>
  801f80:	83 c4 18             	add    $0x18,%esp
}
  801f83:	c9                   	leave  
  801f84:	c3                   	ret    

00801f85 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801f85:	55                   	push   %ebp
  801f86:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801f88:	6a 00                	push   $0x0
  801f8a:	6a 00                	push   $0x0
  801f8c:	6a 00                	push   $0x0
  801f8e:	6a 00                	push   $0x0
  801f90:	6a 00                	push   $0x0
  801f92:	6a 10                	push   $0x10
  801f94:	e8 ca fd ff ff       	call   801d63 <syscall>
  801f99:	83 c4 18             	add    $0x18,%esp
}
  801f9c:	90                   	nop
  801f9d:	c9                   	leave  
  801f9e:	c3                   	ret    

00801f9f <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801f9f:	55                   	push   %ebp
  801fa0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801fa2:	6a 00                	push   $0x0
  801fa4:	6a 00                	push   $0x0
  801fa6:	6a 00                	push   $0x0
  801fa8:	6a 00                	push   $0x0
  801faa:	6a 00                	push   $0x0
  801fac:	6a 14                	push   $0x14
  801fae:	e8 b0 fd ff ff       	call   801d63 <syscall>
  801fb3:	83 c4 18             	add    $0x18,%esp
}
  801fb6:	90                   	nop
  801fb7:	c9                   	leave  
  801fb8:	c3                   	ret    

00801fb9 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801fb9:	55                   	push   %ebp
  801fba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801fbc:	6a 00                	push   $0x0
  801fbe:	6a 00                	push   $0x0
  801fc0:	6a 00                	push   $0x0
  801fc2:	6a 00                	push   $0x0
  801fc4:	6a 00                	push   $0x0
  801fc6:	6a 15                	push   $0x15
  801fc8:	e8 96 fd ff ff       	call   801d63 <syscall>
  801fcd:	83 c4 18             	add    $0x18,%esp
}
  801fd0:	90                   	nop
  801fd1:	c9                   	leave  
  801fd2:	c3                   	ret    

00801fd3 <sys_cputc>:


void
sys_cputc(const char c)
{
  801fd3:	55                   	push   %ebp
  801fd4:	89 e5                	mov    %esp,%ebp
  801fd6:	83 ec 04             	sub    $0x4,%esp
  801fd9:	8b 45 08             	mov    0x8(%ebp),%eax
  801fdc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801fdf:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801fe3:	6a 00                	push   $0x0
  801fe5:	6a 00                	push   $0x0
  801fe7:	6a 00                	push   $0x0
  801fe9:	6a 00                	push   $0x0
  801feb:	50                   	push   %eax
  801fec:	6a 16                	push   $0x16
  801fee:	e8 70 fd ff ff       	call   801d63 <syscall>
  801ff3:	83 c4 18             	add    $0x18,%esp
}
  801ff6:	90                   	nop
  801ff7:	c9                   	leave  
  801ff8:	c3                   	ret    

00801ff9 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ff9:	55                   	push   %ebp
  801ffa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ffc:	6a 00                	push   $0x0
  801ffe:	6a 00                	push   $0x0
  802000:	6a 00                	push   $0x0
  802002:	6a 00                	push   $0x0
  802004:	6a 00                	push   $0x0
  802006:	6a 17                	push   $0x17
  802008:	e8 56 fd ff ff       	call   801d63 <syscall>
  80200d:	83 c4 18             	add    $0x18,%esp
}
  802010:	90                   	nop
  802011:	c9                   	leave  
  802012:	c3                   	ret    

00802013 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802013:	55                   	push   %ebp
  802014:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802016:	8b 45 08             	mov    0x8(%ebp),%eax
  802019:	6a 00                	push   $0x0
  80201b:	6a 00                	push   $0x0
  80201d:	6a 00                	push   $0x0
  80201f:	ff 75 0c             	pushl  0xc(%ebp)
  802022:	50                   	push   %eax
  802023:	6a 18                	push   $0x18
  802025:	e8 39 fd ff ff       	call   801d63 <syscall>
  80202a:	83 c4 18             	add    $0x18,%esp
}
  80202d:	c9                   	leave  
  80202e:	c3                   	ret    

0080202f <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80202f:	55                   	push   %ebp
  802030:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802032:	8b 55 0c             	mov    0xc(%ebp),%edx
  802035:	8b 45 08             	mov    0x8(%ebp),%eax
  802038:	6a 00                	push   $0x0
  80203a:	6a 00                	push   $0x0
  80203c:	6a 00                	push   $0x0
  80203e:	52                   	push   %edx
  80203f:	50                   	push   %eax
  802040:	6a 1b                	push   $0x1b
  802042:	e8 1c fd ff ff       	call   801d63 <syscall>
  802047:	83 c4 18             	add    $0x18,%esp
}
  80204a:	c9                   	leave  
  80204b:	c3                   	ret    

0080204c <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80204c:	55                   	push   %ebp
  80204d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80204f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802052:	8b 45 08             	mov    0x8(%ebp),%eax
  802055:	6a 00                	push   $0x0
  802057:	6a 00                	push   $0x0
  802059:	6a 00                	push   $0x0
  80205b:	52                   	push   %edx
  80205c:	50                   	push   %eax
  80205d:	6a 19                	push   $0x19
  80205f:	e8 ff fc ff ff       	call   801d63 <syscall>
  802064:	83 c4 18             	add    $0x18,%esp
}
  802067:	90                   	nop
  802068:	c9                   	leave  
  802069:	c3                   	ret    

0080206a <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80206a:	55                   	push   %ebp
  80206b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80206d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802070:	8b 45 08             	mov    0x8(%ebp),%eax
  802073:	6a 00                	push   $0x0
  802075:	6a 00                	push   $0x0
  802077:	6a 00                	push   $0x0
  802079:	52                   	push   %edx
  80207a:	50                   	push   %eax
  80207b:	6a 1a                	push   $0x1a
  80207d:	e8 e1 fc ff ff       	call   801d63 <syscall>
  802082:	83 c4 18             	add    $0x18,%esp
}
  802085:	90                   	nop
  802086:	c9                   	leave  
  802087:	c3                   	ret    

00802088 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802088:	55                   	push   %ebp
  802089:	89 e5                	mov    %esp,%ebp
  80208b:	83 ec 04             	sub    $0x4,%esp
  80208e:	8b 45 10             	mov    0x10(%ebp),%eax
  802091:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802094:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802097:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80209b:	8b 45 08             	mov    0x8(%ebp),%eax
  80209e:	6a 00                	push   $0x0
  8020a0:	51                   	push   %ecx
  8020a1:	52                   	push   %edx
  8020a2:	ff 75 0c             	pushl  0xc(%ebp)
  8020a5:	50                   	push   %eax
  8020a6:	6a 1c                	push   $0x1c
  8020a8:	e8 b6 fc ff ff       	call   801d63 <syscall>
  8020ad:	83 c4 18             	add    $0x18,%esp
}
  8020b0:	c9                   	leave  
  8020b1:	c3                   	ret    

008020b2 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8020b2:	55                   	push   %ebp
  8020b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8020b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8020bb:	6a 00                	push   $0x0
  8020bd:	6a 00                	push   $0x0
  8020bf:	6a 00                	push   $0x0
  8020c1:	52                   	push   %edx
  8020c2:	50                   	push   %eax
  8020c3:	6a 1d                	push   $0x1d
  8020c5:	e8 99 fc ff ff       	call   801d63 <syscall>
  8020ca:	83 c4 18             	add    $0x18,%esp
}
  8020cd:	c9                   	leave  
  8020ce:	c3                   	ret    

008020cf <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8020cf:	55                   	push   %ebp
  8020d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8020d2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8020db:	6a 00                	push   $0x0
  8020dd:	6a 00                	push   $0x0
  8020df:	51                   	push   %ecx
  8020e0:	52                   	push   %edx
  8020e1:	50                   	push   %eax
  8020e2:	6a 1e                	push   $0x1e
  8020e4:	e8 7a fc ff ff       	call   801d63 <syscall>
  8020e9:	83 c4 18             	add    $0x18,%esp
}
  8020ec:	c9                   	leave  
  8020ed:	c3                   	ret    

008020ee <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8020ee:	55                   	push   %ebp
  8020ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8020f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f7:	6a 00                	push   $0x0
  8020f9:	6a 00                	push   $0x0
  8020fb:	6a 00                	push   $0x0
  8020fd:	52                   	push   %edx
  8020fe:	50                   	push   %eax
  8020ff:	6a 1f                	push   $0x1f
  802101:	e8 5d fc ff ff       	call   801d63 <syscall>
  802106:	83 c4 18             	add    $0x18,%esp
}
  802109:	c9                   	leave  
  80210a:	c3                   	ret    

0080210b <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80210b:	55                   	push   %ebp
  80210c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80210e:	6a 00                	push   $0x0
  802110:	6a 00                	push   $0x0
  802112:	6a 00                	push   $0x0
  802114:	6a 00                	push   $0x0
  802116:	6a 00                	push   $0x0
  802118:	6a 20                	push   $0x20
  80211a:	e8 44 fc ff ff       	call   801d63 <syscall>
  80211f:	83 c4 18             	add    $0x18,%esp
}
  802122:	c9                   	leave  
  802123:	c3                   	ret    

00802124 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802124:	55                   	push   %ebp
  802125:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802127:	8b 45 08             	mov    0x8(%ebp),%eax
  80212a:	6a 00                	push   $0x0
  80212c:	ff 75 14             	pushl  0x14(%ebp)
  80212f:	ff 75 10             	pushl  0x10(%ebp)
  802132:	ff 75 0c             	pushl  0xc(%ebp)
  802135:	50                   	push   %eax
  802136:	6a 21                	push   $0x21
  802138:	e8 26 fc ff ff       	call   801d63 <syscall>
  80213d:	83 c4 18             	add    $0x18,%esp
}
  802140:	c9                   	leave  
  802141:	c3                   	ret    

00802142 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  802142:	55                   	push   %ebp
  802143:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802145:	8b 45 08             	mov    0x8(%ebp),%eax
  802148:	6a 00                	push   $0x0
  80214a:	6a 00                	push   $0x0
  80214c:	6a 00                	push   $0x0
  80214e:	6a 00                	push   $0x0
  802150:	50                   	push   %eax
  802151:	6a 22                	push   $0x22
  802153:	e8 0b fc ff ff       	call   801d63 <syscall>
  802158:	83 c4 18             	add    $0x18,%esp
}
  80215b:	90                   	nop
  80215c:	c9                   	leave  
  80215d:	c3                   	ret    

0080215e <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80215e:	55                   	push   %ebp
  80215f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802161:	8b 45 08             	mov    0x8(%ebp),%eax
  802164:	6a 00                	push   $0x0
  802166:	6a 00                	push   $0x0
  802168:	6a 00                	push   $0x0
  80216a:	6a 00                	push   $0x0
  80216c:	50                   	push   %eax
  80216d:	6a 23                	push   $0x23
  80216f:	e8 ef fb ff ff       	call   801d63 <syscall>
  802174:	83 c4 18             	add    $0x18,%esp
}
  802177:	90                   	nop
  802178:	c9                   	leave  
  802179:	c3                   	ret    

0080217a <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80217a:	55                   	push   %ebp
  80217b:	89 e5                	mov    %esp,%ebp
  80217d:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802180:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802183:	8d 50 04             	lea    0x4(%eax),%edx
  802186:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802189:	6a 00                	push   $0x0
  80218b:	6a 00                	push   $0x0
  80218d:	6a 00                	push   $0x0
  80218f:	52                   	push   %edx
  802190:	50                   	push   %eax
  802191:	6a 24                	push   $0x24
  802193:	e8 cb fb ff ff       	call   801d63 <syscall>
  802198:	83 c4 18             	add    $0x18,%esp
	return result;
  80219b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80219e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021a1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8021a4:	89 01                	mov    %eax,(%ecx)
  8021a6:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8021a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ac:	c9                   	leave  
  8021ad:	c2 04 00             	ret    $0x4

008021b0 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8021b0:	55                   	push   %ebp
  8021b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8021b3:	6a 00                	push   $0x0
  8021b5:	6a 00                	push   $0x0
  8021b7:	ff 75 10             	pushl  0x10(%ebp)
  8021ba:	ff 75 0c             	pushl  0xc(%ebp)
  8021bd:	ff 75 08             	pushl  0x8(%ebp)
  8021c0:	6a 13                	push   $0x13
  8021c2:	e8 9c fb ff ff       	call   801d63 <syscall>
  8021c7:	83 c4 18             	add    $0x18,%esp
	return ;
  8021ca:	90                   	nop
}
  8021cb:	c9                   	leave  
  8021cc:	c3                   	ret    

008021cd <sys_rcr2>:
uint32 sys_rcr2()
{
  8021cd:	55                   	push   %ebp
  8021ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8021d0:	6a 00                	push   $0x0
  8021d2:	6a 00                	push   $0x0
  8021d4:	6a 00                	push   $0x0
  8021d6:	6a 00                	push   $0x0
  8021d8:	6a 00                	push   $0x0
  8021da:	6a 25                	push   $0x25
  8021dc:	e8 82 fb ff ff       	call   801d63 <syscall>
  8021e1:	83 c4 18             	add    $0x18,%esp
}
  8021e4:	c9                   	leave  
  8021e5:	c3                   	ret    

008021e6 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8021e6:	55                   	push   %ebp
  8021e7:	89 e5                	mov    %esp,%ebp
  8021e9:	83 ec 04             	sub    $0x4,%esp
  8021ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ef:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8021f2:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8021f6:	6a 00                	push   $0x0
  8021f8:	6a 00                	push   $0x0
  8021fa:	6a 00                	push   $0x0
  8021fc:	6a 00                	push   $0x0
  8021fe:	50                   	push   %eax
  8021ff:	6a 26                	push   $0x26
  802201:	e8 5d fb ff ff       	call   801d63 <syscall>
  802206:	83 c4 18             	add    $0x18,%esp
	return ;
  802209:	90                   	nop
}
  80220a:	c9                   	leave  
  80220b:	c3                   	ret    

0080220c <rsttst>:
void rsttst()
{
  80220c:	55                   	push   %ebp
  80220d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80220f:	6a 00                	push   $0x0
  802211:	6a 00                	push   $0x0
  802213:	6a 00                	push   $0x0
  802215:	6a 00                	push   $0x0
  802217:	6a 00                	push   $0x0
  802219:	6a 28                	push   $0x28
  80221b:	e8 43 fb ff ff       	call   801d63 <syscall>
  802220:	83 c4 18             	add    $0x18,%esp
	return ;
  802223:	90                   	nop
}
  802224:	c9                   	leave  
  802225:	c3                   	ret    

00802226 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802226:	55                   	push   %ebp
  802227:	89 e5                	mov    %esp,%ebp
  802229:	83 ec 04             	sub    $0x4,%esp
  80222c:	8b 45 14             	mov    0x14(%ebp),%eax
  80222f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802232:	8b 55 18             	mov    0x18(%ebp),%edx
  802235:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802239:	52                   	push   %edx
  80223a:	50                   	push   %eax
  80223b:	ff 75 10             	pushl  0x10(%ebp)
  80223e:	ff 75 0c             	pushl  0xc(%ebp)
  802241:	ff 75 08             	pushl  0x8(%ebp)
  802244:	6a 27                	push   $0x27
  802246:	e8 18 fb ff ff       	call   801d63 <syscall>
  80224b:	83 c4 18             	add    $0x18,%esp
	return ;
  80224e:	90                   	nop
}
  80224f:	c9                   	leave  
  802250:	c3                   	ret    

00802251 <chktst>:
void chktst(uint32 n)
{
  802251:	55                   	push   %ebp
  802252:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802254:	6a 00                	push   $0x0
  802256:	6a 00                	push   $0x0
  802258:	6a 00                	push   $0x0
  80225a:	6a 00                	push   $0x0
  80225c:	ff 75 08             	pushl  0x8(%ebp)
  80225f:	6a 29                	push   $0x29
  802261:	e8 fd fa ff ff       	call   801d63 <syscall>
  802266:	83 c4 18             	add    $0x18,%esp
	return ;
  802269:	90                   	nop
}
  80226a:	c9                   	leave  
  80226b:	c3                   	ret    

0080226c <inctst>:

void inctst()
{
  80226c:	55                   	push   %ebp
  80226d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80226f:	6a 00                	push   $0x0
  802271:	6a 00                	push   $0x0
  802273:	6a 00                	push   $0x0
  802275:	6a 00                	push   $0x0
  802277:	6a 00                	push   $0x0
  802279:	6a 2a                	push   $0x2a
  80227b:	e8 e3 fa ff ff       	call   801d63 <syscall>
  802280:	83 c4 18             	add    $0x18,%esp
	return ;
  802283:	90                   	nop
}
  802284:	c9                   	leave  
  802285:	c3                   	ret    

00802286 <gettst>:
uint32 gettst()
{
  802286:	55                   	push   %ebp
  802287:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802289:	6a 00                	push   $0x0
  80228b:	6a 00                	push   $0x0
  80228d:	6a 00                	push   $0x0
  80228f:	6a 00                	push   $0x0
  802291:	6a 00                	push   $0x0
  802293:	6a 2b                	push   $0x2b
  802295:	e8 c9 fa ff ff       	call   801d63 <syscall>
  80229a:	83 c4 18             	add    $0x18,%esp
}
  80229d:	c9                   	leave  
  80229e:	c3                   	ret    

0080229f <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80229f:	55                   	push   %ebp
  8022a0:	89 e5                	mov    %esp,%ebp
  8022a2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022a5:	6a 00                	push   $0x0
  8022a7:	6a 00                	push   $0x0
  8022a9:	6a 00                	push   $0x0
  8022ab:	6a 00                	push   $0x0
  8022ad:	6a 00                	push   $0x0
  8022af:	6a 2c                	push   $0x2c
  8022b1:	e8 ad fa ff ff       	call   801d63 <syscall>
  8022b6:	83 c4 18             	add    $0x18,%esp
  8022b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8022bc:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8022c0:	75 07                	jne    8022c9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8022c2:	b8 01 00 00 00       	mov    $0x1,%eax
  8022c7:	eb 05                	jmp    8022ce <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8022c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022ce:	c9                   	leave  
  8022cf:	c3                   	ret    

008022d0 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8022d0:	55                   	push   %ebp
  8022d1:	89 e5                	mov    %esp,%ebp
  8022d3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022d6:	6a 00                	push   $0x0
  8022d8:	6a 00                	push   $0x0
  8022da:	6a 00                	push   $0x0
  8022dc:	6a 00                	push   $0x0
  8022de:	6a 00                	push   $0x0
  8022e0:	6a 2c                	push   $0x2c
  8022e2:	e8 7c fa ff ff       	call   801d63 <syscall>
  8022e7:	83 c4 18             	add    $0x18,%esp
  8022ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8022ed:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8022f1:	75 07                	jne    8022fa <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8022f3:	b8 01 00 00 00       	mov    $0x1,%eax
  8022f8:	eb 05                	jmp    8022ff <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8022fa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022ff:	c9                   	leave  
  802300:	c3                   	ret    

00802301 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802301:	55                   	push   %ebp
  802302:	89 e5                	mov    %esp,%ebp
  802304:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802307:	6a 00                	push   $0x0
  802309:	6a 00                	push   $0x0
  80230b:	6a 00                	push   $0x0
  80230d:	6a 00                	push   $0x0
  80230f:	6a 00                	push   $0x0
  802311:	6a 2c                	push   $0x2c
  802313:	e8 4b fa ff ff       	call   801d63 <syscall>
  802318:	83 c4 18             	add    $0x18,%esp
  80231b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80231e:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802322:	75 07                	jne    80232b <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802324:	b8 01 00 00 00       	mov    $0x1,%eax
  802329:	eb 05                	jmp    802330 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80232b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802330:	c9                   	leave  
  802331:	c3                   	ret    

00802332 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802332:	55                   	push   %ebp
  802333:	89 e5                	mov    %esp,%ebp
  802335:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802338:	6a 00                	push   $0x0
  80233a:	6a 00                	push   $0x0
  80233c:	6a 00                	push   $0x0
  80233e:	6a 00                	push   $0x0
  802340:	6a 00                	push   $0x0
  802342:	6a 2c                	push   $0x2c
  802344:	e8 1a fa ff ff       	call   801d63 <syscall>
  802349:	83 c4 18             	add    $0x18,%esp
  80234c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80234f:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802353:	75 07                	jne    80235c <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802355:	b8 01 00 00 00       	mov    $0x1,%eax
  80235a:	eb 05                	jmp    802361 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80235c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802361:	c9                   	leave  
  802362:	c3                   	ret    

00802363 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802363:	55                   	push   %ebp
  802364:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802366:	6a 00                	push   $0x0
  802368:	6a 00                	push   $0x0
  80236a:	6a 00                	push   $0x0
  80236c:	6a 00                	push   $0x0
  80236e:	ff 75 08             	pushl  0x8(%ebp)
  802371:	6a 2d                	push   $0x2d
  802373:	e8 eb f9 ff ff       	call   801d63 <syscall>
  802378:	83 c4 18             	add    $0x18,%esp
	return ;
  80237b:	90                   	nop
}
  80237c:	c9                   	leave  
  80237d:	c3                   	ret    

0080237e <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80237e:	55                   	push   %ebp
  80237f:	89 e5                	mov    %esp,%ebp
  802381:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802382:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802385:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802388:	8b 55 0c             	mov    0xc(%ebp),%edx
  80238b:	8b 45 08             	mov    0x8(%ebp),%eax
  80238e:	6a 00                	push   $0x0
  802390:	53                   	push   %ebx
  802391:	51                   	push   %ecx
  802392:	52                   	push   %edx
  802393:	50                   	push   %eax
  802394:	6a 2e                	push   $0x2e
  802396:	e8 c8 f9 ff ff       	call   801d63 <syscall>
  80239b:	83 c4 18             	add    $0x18,%esp
}
  80239e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8023a1:	c9                   	leave  
  8023a2:	c3                   	ret    

008023a3 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8023a3:	55                   	push   %ebp
  8023a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8023a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ac:	6a 00                	push   $0x0
  8023ae:	6a 00                	push   $0x0
  8023b0:	6a 00                	push   $0x0
  8023b2:	52                   	push   %edx
  8023b3:	50                   	push   %eax
  8023b4:	6a 2f                	push   $0x2f
  8023b6:	e8 a8 f9 ff ff       	call   801d63 <syscall>
  8023bb:	83 c4 18             	add    $0x18,%esp
}
  8023be:	c9                   	leave  
  8023bf:	c3                   	ret    

008023c0 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8023c0:	55                   	push   %ebp
  8023c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8023c3:	6a 00                	push   $0x0
  8023c5:	6a 00                	push   $0x0
  8023c7:	6a 00                	push   $0x0
  8023c9:	ff 75 0c             	pushl  0xc(%ebp)
  8023cc:	ff 75 08             	pushl  0x8(%ebp)
  8023cf:	6a 30                	push   $0x30
  8023d1:	e8 8d f9 ff ff       	call   801d63 <syscall>
  8023d6:	83 c4 18             	add    $0x18,%esp
	return ;
  8023d9:	90                   	nop
}
  8023da:	c9                   	leave  
  8023db:	c3                   	ret    

008023dc <__udivdi3>:
  8023dc:	55                   	push   %ebp
  8023dd:	57                   	push   %edi
  8023de:	56                   	push   %esi
  8023df:	53                   	push   %ebx
  8023e0:	83 ec 1c             	sub    $0x1c,%esp
  8023e3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8023e7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8023eb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023ef:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8023f3:	89 ca                	mov    %ecx,%edx
  8023f5:	89 f8                	mov    %edi,%eax
  8023f7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8023fb:	85 f6                	test   %esi,%esi
  8023fd:	75 2d                	jne    80242c <__udivdi3+0x50>
  8023ff:	39 cf                	cmp    %ecx,%edi
  802401:	77 65                	ja     802468 <__udivdi3+0x8c>
  802403:	89 fd                	mov    %edi,%ebp
  802405:	85 ff                	test   %edi,%edi
  802407:	75 0b                	jne    802414 <__udivdi3+0x38>
  802409:	b8 01 00 00 00       	mov    $0x1,%eax
  80240e:	31 d2                	xor    %edx,%edx
  802410:	f7 f7                	div    %edi
  802412:	89 c5                	mov    %eax,%ebp
  802414:	31 d2                	xor    %edx,%edx
  802416:	89 c8                	mov    %ecx,%eax
  802418:	f7 f5                	div    %ebp
  80241a:	89 c1                	mov    %eax,%ecx
  80241c:	89 d8                	mov    %ebx,%eax
  80241e:	f7 f5                	div    %ebp
  802420:	89 cf                	mov    %ecx,%edi
  802422:	89 fa                	mov    %edi,%edx
  802424:	83 c4 1c             	add    $0x1c,%esp
  802427:	5b                   	pop    %ebx
  802428:	5e                   	pop    %esi
  802429:	5f                   	pop    %edi
  80242a:	5d                   	pop    %ebp
  80242b:	c3                   	ret    
  80242c:	39 ce                	cmp    %ecx,%esi
  80242e:	77 28                	ja     802458 <__udivdi3+0x7c>
  802430:	0f bd fe             	bsr    %esi,%edi
  802433:	83 f7 1f             	xor    $0x1f,%edi
  802436:	75 40                	jne    802478 <__udivdi3+0x9c>
  802438:	39 ce                	cmp    %ecx,%esi
  80243a:	72 0a                	jb     802446 <__udivdi3+0x6a>
  80243c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802440:	0f 87 9e 00 00 00    	ja     8024e4 <__udivdi3+0x108>
  802446:	b8 01 00 00 00       	mov    $0x1,%eax
  80244b:	89 fa                	mov    %edi,%edx
  80244d:	83 c4 1c             	add    $0x1c,%esp
  802450:	5b                   	pop    %ebx
  802451:	5e                   	pop    %esi
  802452:	5f                   	pop    %edi
  802453:	5d                   	pop    %ebp
  802454:	c3                   	ret    
  802455:	8d 76 00             	lea    0x0(%esi),%esi
  802458:	31 ff                	xor    %edi,%edi
  80245a:	31 c0                	xor    %eax,%eax
  80245c:	89 fa                	mov    %edi,%edx
  80245e:	83 c4 1c             	add    $0x1c,%esp
  802461:	5b                   	pop    %ebx
  802462:	5e                   	pop    %esi
  802463:	5f                   	pop    %edi
  802464:	5d                   	pop    %ebp
  802465:	c3                   	ret    
  802466:	66 90                	xchg   %ax,%ax
  802468:	89 d8                	mov    %ebx,%eax
  80246a:	f7 f7                	div    %edi
  80246c:	31 ff                	xor    %edi,%edi
  80246e:	89 fa                	mov    %edi,%edx
  802470:	83 c4 1c             	add    $0x1c,%esp
  802473:	5b                   	pop    %ebx
  802474:	5e                   	pop    %esi
  802475:	5f                   	pop    %edi
  802476:	5d                   	pop    %ebp
  802477:	c3                   	ret    
  802478:	bd 20 00 00 00       	mov    $0x20,%ebp
  80247d:	89 eb                	mov    %ebp,%ebx
  80247f:	29 fb                	sub    %edi,%ebx
  802481:	89 f9                	mov    %edi,%ecx
  802483:	d3 e6                	shl    %cl,%esi
  802485:	89 c5                	mov    %eax,%ebp
  802487:	88 d9                	mov    %bl,%cl
  802489:	d3 ed                	shr    %cl,%ebp
  80248b:	89 e9                	mov    %ebp,%ecx
  80248d:	09 f1                	or     %esi,%ecx
  80248f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802493:	89 f9                	mov    %edi,%ecx
  802495:	d3 e0                	shl    %cl,%eax
  802497:	89 c5                	mov    %eax,%ebp
  802499:	89 d6                	mov    %edx,%esi
  80249b:	88 d9                	mov    %bl,%cl
  80249d:	d3 ee                	shr    %cl,%esi
  80249f:	89 f9                	mov    %edi,%ecx
  8024a1:	d3 e2                	shl    %cl,%edx
  8024a3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024a7:	88 d9                	mov    %bl,%cl
  8024a9:	d3 e8                	shr    %cl,%eax
  8024ab:	09 c2                	or     %eax,%edx
  8024ad:	89 d0                	mov    %edx,%eax
  8024af:	89 f2                	mov    %esi,%edx
  8024b1:	f7 74 24 0c          	divl   0xc(%esp)
  8024b5:	89 d6                	mov    %edx,%esi
  8024b7:	89 c3                	mov    %eax,%ebx
  8024b9:	f7 e5                	mul    %ebp
  8024bb:	39 d6                	cmp    %edx,%esi
  8024bd:	72 19                	jb     8024d8 <__udivdi3+0xfc>
  8024bf:	74 0b                	je     8024cc <__udivdi3+0xf0>
  8024c1:	89 d8                	mov    %ebx,%eax
  8024c3:	31 ff                	xor    %edi,%edi
  8024c5:	e9 58 ff ff ff       	jmp    802422 <__udivdi3+0x46>
  8024ca:	66 90                	xchg   %ax,%ax
  8024cc:	8b 54 24 08          	mov    0x8(%esp),%edx
  8024d0:	89 f9                	mov    %edi,%ecx
  8024d2:	d3 e2                	shl    %cl,%edx
  8024d4:	39 c2                	cmp    %eax,%edx
  8024d6:	73 e9                	jae    8024c1 <__udivdi3+0xe5>
  8024d8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8024db:	31 ff                	xor    %edi,%edi
  8024dd:	e9 40 ff ff ff       	jmp    802422 <__udivdi3+0x46>
  8024e2:	66 90                	xchg   %ax,%ax
  8024e4:	31 c0                	xor    %eax,%eax
  8024e6:	e9 37 ff ff ff       	jmp    802422 <__udivdi3+0x46>
  8024eb:	90                   	nop

008024ec <__umoddi3>:
  8024ec:	55                   	push   %ebp
  8024ed:	57                   	push   %edi
  8024ee:	56                   	push   %esi
  8024ef:	53                   	push   %ebx
  8024f0:	83 ec 1c             	sub    $0x1c,%esp
  8024f3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8024f7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8024fb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024ff:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802503:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802507:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80250b:	89 f3                	mov    %esi,%ebx
  80250d:	89 fa                	mov    %edi,%edx
  80250f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802513:	89 34 24             	mov    %esi,(%esp)
  802516:	85 c0                	test   %eax,%eax
  802518:	75 1a                	jne    802534 <__umoddi3+0x48>
  80251a:	39 f7                	cmp    %esi,%edi
  80251c:	0f 86 a2 00 00 00    	jbe    8025c4 <__umoddi3+0xd8>
  802522:	89 c8                	mov    %ecx,%eax
  802524:	89 f2                	mov    %esi,%edx
  802526:	f7 f7                	div    %edi
  802528:	89 d0                	mov    %edx,%eax
  80252a:	31 d2                	xor    %edx,%edx
  80252c:	83 c4 1c             	add    $0x1c,%esp
  80252f:	5b                   	pop    %ebx
  802530:	5e                   	pop    %esi
  802531:	5f                   	pop    %edi
  802532:	5d                   	pop    %ebp
  802533:	c3                   	ret    
  802534:	39 f0                	cmp    %esi,%eax
  802536:	0f 87 ac 00 00 00    	ja     8025e8 <__umoddi3+0xfc>
  80253c:	0f bd e8             	bsr    %eax,%ebp
  80253f:	83 f5 1f             	xor    $0x1f,%ebp
  802542:	0f 84 ac 00 00 00    	je     8025f4 <__umoddi3+0x108>
  802548:	bf 20 00 00 00       	mov    $0x20,%edi
  80254d:	29 ef                	sub    %ebp,%edi
  80254f:	89 fe                	mov    %edi,%esi
  802551:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802555:	89 e9                	mov    %ebp,%ecx
  802557:	d3 e0                	shl    %cl,%eax
  802559:	89 d7                	mov    %edx,%edi
  80255b:	89 f1                	mov    %esi,%ecx
  80255d:	d3 ef                	shr    %cl,%edi
  80255f:	09 c7                	or     %eax,%edi
  802561:	89 e9                	mov    %ebp,%ecx
  802563:	d3 e2                	shl    %cl,%edx
  802565:	89 14 24             	mov    %edx,(%esp)
  802568:	89 d8                	mov    %ebx,%eax
  80256a:	d3 e0                	shl    %cl,%eax
  80256c:	89 c2                	mov    %eax,%edx
  80256e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802572:	d3 e0                	shl    %cl,%eax
  802574:	89 44 24 04          	mov    %eax,0x4(%esp)
  802578:	8b 44 24 08          	mov    0x8(%esp),%eax
  80257c:	89 f1                	mov    %esi,%ecx
  80257e:	d3 e8                	shr    %cl,%eax
  802580:	09 d0                	or     %edx,%eax
  802582:	d3 eb                	shr    %cl,%ebx
  802584:	89 da                	mov    %ebx,%edx
  802586:	f7 f7                	div    %edi
  802588:	89 d3                	mov    %edx,%ebx
  80258a:	f7 24 24             	mull   (%esp)
  80258d:	89 c6                	mov    %eax,%esi
  80258f:	89 d1                	mov    %edx,%ecx
  802591:	39 d3                	cmp    %edx,%ebx
  802593:	0f 82 87 00 00 00    	jb     802620 <__umoddi3+0x134>
  802599:	0f 84 91 00 00 00    	je     802630 <__umoddi3+0x144>
  80259f:	8b 54 24 04          	mov    0x4(%esp),%edx
  8025a3:	29 f2                	sub    %esi,%edx
  8025a5:	19 cb                	sbb    %ecx,%ebx
  8025a7:	89 d8                	mov    %ebx,%eax
  8025a9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8025ad:	d3 e0                	shl    %cl,%eax
  8025af:	89 e9                	mov    %ebp,%ecx
  8025b1:	d3 ea                	shr    %cl,%edx
  8025b3:	09 d0                	or     %edx,%eax
  8025b5:	89 e9                	mov    %ebp,%ecx
  8025b7:	d3 eb                	shr    %cl,%ebx
  8025b9:	89 da                	mov    %ebx,%edx
  8025bb:	83 c4 1c             	add    $0x1c,%esp
  8025be:	5b                   	pop    %ebx
  8025bf:	5e                   	pop    %esi
  8025c0:	5f                   	pop    %edi
  8025c1:	5d                   	pop    %ebp
  8025c2:	c3                   	ret    
  8025c3:	90                   	nop
  8025c4:	89 fd                	mov    %edi,%ebp
  8025c6:	85 ff                	test   %edi,%edi
  8025c8:	75 0b                	jne    8025d5 <__umoddi3+0xe9>
  8025ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8025cf:	31 d2                	xor    %edx,%edx
  8025d1:	f7 f7                	div    %edi
  8025d3:	89 c5                	mov    %eax,%ebp
  8025d5:	89 f0                	mov    %esi,%eax
  8025d7:	31 d2                	xor    %edx,%edx
  8025d9:	f7 f5                	div    %ebp
  8025db:	89 c8                	mov    %ecx,%eax
  8025dd:	f7 f5                	div    %ebp
  8025df:	89 d0                	mov    %edx,%eax
  8025e1:	e9 44 ff ff ff       	jmp    80252a <__umoddi3+0x3e>
  8025e6:	66 90                	xchg   %ax,%ax
  8025e8:	89 c8                	mov    %ecx,%eax
  8025ea:	89 f2                	mov    %esi,%edx
  8025ec:	83 c4 1c             	add    $0x1c,%esp
  8025ef:	5b                   	pop    %ebx
  8025f0:	5e                   	pop    %esi
  8025f1:	5f                   	pop    %edi
  8025f2:	5d                   	pop    %ebp
  8025f3:	c3                   	ret    
  8025f4:	3b 04 24             	cmp    (%esp),%eax
  8025f7:	72 06                	jb     8025ff <__umoddi3+0x113>
  8025f9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8025fd:	77 0f                	ja     80260e <__umoddi3+0x122>
  8025ff:	89 f2                	mov    %esi,%edx
  802601:	29 f9                	sub    %edi,%ecx
  802603:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802607:	89 14 24             	mov    %edx,(%esp)
  80260a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80260e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802612:	8b 14 24             	mov    (%esp),%edx
  802615:	83 c4 1c             	add    $0x1c,%esp
  802618:	5b                   	pop    %ebx
  802619:	5e                   	pop    %esi
  80261a:	5f                   	pop    %edi
  80261b:	5d                   	pop    %ebp
  80261c:	c3                   	ret    
  80261d:	8d 76 00             	lea    0x0(%esi),%esi
  802620:	2b 04 24             	sub    (%esp),%eax
  802623:	19 fa                	sbb    %edi,%edx
  802625:	89 d1                	mov    %edx,%ecx
  802627:	89 c6                	mov    %eax,%esi
  802629:	e9 71 ff ff ff       	jmp    80259f <__umoddi3+0xb3>
  80262e:	66 90                	xchg   %ax,%ax
  802630:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802634:	72 ea                	jb     802620 <__umoddi3+0x134>
  802636:	89 d9                	mov    %ebx,%ecx
  802638:	e9 62 ff ff ff       	jmp    80259f <__umoddi3+0xb3>
