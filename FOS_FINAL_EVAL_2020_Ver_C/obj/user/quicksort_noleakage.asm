
obj/user/quicksort_noleakage:     file format elf32-i386


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
  800031:	e8 0e 06 00 00       	call   800644 <libmain>
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
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	char Line[255] ;
	char Chose ;
	do
	{
		//2012: lock the interrupt
		sys_disable_interrupt();
  800041:	e8 b3 1f 00 00       	call   801ff9 <sys_disable_interrupt>
		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 a0 26 80 00       	push   $0x8026a0
  80004e:	e8 d0 09 00 00       	call   800a23 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 a2 26 80 00       	push   $0x8026a2
  80005e:	e8 c0 09 00 00       	call   800a23 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!   QUICK SORT    !!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 bb 26 80 00       	push   $0x8026bb
  80006e:	e8 b0 09 00 00       	call   800a23 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 a2 26 80 00       	push   $0x8026a2
  80007e:	e8 a0 09 00 00       	call   800a23 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 a0 26 80 00       	push   $0x8026a0
  80008e:	e8 90 09 00 00       	call   800a23 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp

		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 d4 26 80 00       	push   $0x8026d4
  8000a5:	e8 fb 0f 00 00       	call   8010a5 <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 4b 15 00 00       	call   80160b <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 de 18 00 00       	call   8019b3 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 f4 26 80 00       	push   $0x8026f4
  8000e3:	e8 3b 09 00 00       	call   800a23 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 16 27 80 00       	push   $0x802716
  8000f3:	e8 2b 09 00 00       	call   800a23 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 24 27 80 00       	push   $0x802724
  800103:	e8 1b 09 00 00       	call   800a23 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 33 27 80 00       	push   $0x802733
  800113:	e8 0b 09 00 00       	call   800a23 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 43 27 80 00       	push   $0x802743
  800123:	e8 fb 08 00 00       	call   800a23 <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 bc 04 00 00       	call   8005ec <getchar>
  800130:	88 45 ef             	mov    %al,-0x11(%ebp)
			cputchar(Chose);
  800133:	0f be 45 ef          	movsbl -0x11(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 64 04 00 00       	call   8005a4 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 57 04 00 00       	call   8005a4 <cputchar>
  80014d:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800150:	80 7d ef 61          	cmpb   $0x61,-0x11(%ebp)
  800154:	74 0c                	je     800162 <_main+0x12a>
  800156:	80 7d ef 62          	cmpb   $0x62,-0x11(%ebp)
  80015a:	74 06                	je     800162 <_main+0x12a>
  80015c:	80 7d ef 63          	cmpb   $0x63,-0x11(%ebp)
  800160:	75 b9                	jne    80011b <_main+0xe3>

		//2012: lock the interrupt
		sys_enable_interrupt();
  800162:	e8 ac 1e 00 00       	call   802013 <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  800167:	0f be 45 ef          	movsbl -0x11(%ebp),%eax
  80016b:	83 f8 62             	cmp    $0x62,%eax
  80016e:	74 1d                	je     80018d <_main+0x155>
  800170:	83 f8 63             	cmp    $0x63,%eax
  800173:	74 2b                	je     8001a0 <_main+0x168>
  800175:	83 f8 61             	cmp    $0x61,%eax
  800178:	75 39                	jne    8001b3 <_main+0x17b>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80017a:	83 ec 08             	sub    $0x8,%esp
  80017d:	ff 75 f4             	pushl  -0xc(%ebp)
  800180:	ff 75 f0             	pushl  -0x10(%ebp)
  800183:	e8 e4 02 00 00       	call   80046c <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f4             	pushl  -0xc(%ebp)
  800193:	ff 75 f0             	pushl  -0x10(%ebp)
  800196:	e8 02 03 00 00       	call   80049d <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f4             	pushl  -0xc(%ebp)
  8001a6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a9:	e8 24 03 00 00       	call   8004d2 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f4             	pushl  -0xc(%ebp)
  8001b9:	ff 75 f0             	pushl  -0x10(%ebp)
  8001bc:	e8 11 03 00 00       	call   8004d2 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	ff 75 f4             	pushl  -0xc(%ebp)
  8001ca:	ff 75 f0             	pushl  -0x10(%ebp)
  8001cd:	e8 df 00 00 00       	call   8002b1 <QuickSort>
  8001d2:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001d5:	e8 1f 1e 00 00       	call   801ff9 <sys_disable_interrupt>
			cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001da:	83 ec 0c             	sub    $0xc,%esp
  8001dd:	68 4c 27 80 00       	push   $0x80274c
  8001e2:	e8 3c 08 00 00       	call   800a23 <cprintf>
  8001e7:	83 c4 10             	add    $0x10,%esp
		//		PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ea:	e8 24 1e 00 00       	call   802013 <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001ef:	83 ec 08             	sub    $0x8,%esp
  8001f2:	ff 75 f4             	pushl  -0xc(%ebp)
  8001f5:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f8:	e8 c5 01 00 00       	call   8003c2 <CheckSorted>
  8001fd:	83 c4 10             	add    $0x10,%esp
  800200:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800203:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800207:	75 14                	jne    80021d <_main+0x1e5>
  800209:	83 ec 04             	sub    $0x4,%esp
  80020c:	68 80 27 80 00       	push   $0x802780
  800211:	6a 49                	push   $0x49
  800213:	68 a2 27 80 00       	push   $0x8027a2
  800218:	e8 4f 05 00 00       	call   80076c <_panic>
		else
		{
			sys_disable_interrupt();
  80021d:	e8 d7 1d 00 00       	call   801ff9 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800222:	83 ec 0c             	sub    $0xc,%esp
  800225:	68 c0 27 80 00       	push   $0x8027c0
  80022a:	e8 f4 07 00 00       	call   800a23 <cprintf>
  80022f:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800232:	83 ec 0c             	sub    $0xc,%esp
  800235:	68 f4 27 80 00       	push   $0x8027f4
  80023a:	e8 e4 07 00 00       	call   800a23 <cprintf>
  80023f:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800242:	83 ec 0c             	sub    $0xc,%esp
  800245:	68 28 28 80 00       	push   $0x802828
  80024a:	e8 d4 07 00 00       	call   800a23 <cprintf>
  80024f:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800252:	e8 bc 1d 00 00       	call   802013 <sys_enable_interrupt>

		}

		free(Elements) ;
  800257:	83 ec 0c             	sub    $0xc,%esp
  80025a:	ff 75 f0             	pushl  -0x10(%ebp)
  80025d:	e8 16 1a 00 00       	call   801c78 <free>
  800262:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800265:	e8 8f 1d 00 00       	call   801ff9 <sys_disable_interrupt>

		cprintf("Do you want to repeat (y/n): ") ;
  80026a:	83 ec 0c             	sub    $0xc,%esp
  80026d:	68 5a 28 80 00       	push   $0x80285a
  800272:	e8 ac 07 00 00       	call   800a23 <cprintf>
  800277:	83 c4 10             	add    $0x10,%esp
		Chose = getchar() ;
  80027a:	e8 6d 03 00 00       	call   8005ec <getchar>
  80027f:	88 45 ef             	mov    %al,-0x11(%ebp)
		cputchar(Chose);
  800282:	0f be 45 ef          	movsbl -0x11(%ebp),%eax
  800286:	83 ec 0c             	sub    $0xc,%esp
  800289:	50                   	push   %eax
  80028a:	e8 15 03 00 00       	call   8005a4 <cputchar>
  80028f:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800292:	83 ec 0c             	sub    $0xc,%esp
  800295:	6a 0a                	push   $0xa
  800297:	e8 08 03 00 00       	call   8005a4 <cputchar>
  80029c:	83 c4 10             	add    $0x10,%esp

		sys_enable_interrupt();
  80029f:	e8 6f 1d 00 00       	call   802013 <sys_enable_interrupt>

	} while (Chose == 'y');
  8002a4:	80 7d ef 79          	cmpb   $0x79,-0x11(%ebp)
  8002a8:	0f 84 93 fd ff ff    	je     800041 <_main+0x9>

}
  8002ae:	90                   	nop
  8002af:	c9                   	leave  
  8002b0:	c3                   	ret    

008002b1 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8002b1:	55                   	push   %ebp
  8002b2:	89 e5                	mov    %esp,%ebp
  8002b4:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8002b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ba:	48                   	dec    %eax
  8002bb:	50                   	push   %eax
  8002bc:	6a 00                	push   $0x0
  8002be:	ff 75 0c             	pushl  0xc(%ebp)
  8002c1:	ff 75 08             	pushl  0x8(%ebp)
  8002c4:	e8 06 00 00 00       	call   8002cf <QSort>
  8002c9:	83 c4 10             	add    $0x10,%esp
}
  8002cc:	90                   	nop
  8002cd:	c9                   	leave  
  8002ce:	c3                   	ret    

008002cf <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8002cf:	55                   	push   %ebp
  8002d0:	89 e5                	mov    %esp,%ebp
  8002d2:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8002d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8002d8:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002db:	0f 8d de 00 00 00    	jge    8003bf <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8002e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e4:	40                   	inc    %eax
  8002e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8002eb:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002ee:	e9 80 00 00 00       	jmp    800373 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8002f3:	ff 45 f4             	incl   -0xc(%ebp)
  8002f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002f9:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002fc:	7f 2b                	jg     800329 <QSort+0x5a>
  8002fe:	8b 45 10             	mov    0x10(%ebp),%eax
  800301:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800308:	8b 45 08             	mov    0x8(%ebp),%eax
  80030b:	01 d0                	add    %edx,%eax
  80030d:	8b 10                	mov    (%eax),%edx
  80030f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800312:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800319:	8b 45 08             	mov    0x8(%ebp),%eax
  80031c:	01 c8                	add    %ecx,%eax
  80031e:	8b 00                	mov    (%eax),%eax
  800320:	39 c2                	cmp    %eax,%edx
  800322:	7d cf                	jge    8002f3 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800324:	eb 03                	jmp    800329 <QSort+0x5a>
  800326:	ff 4d f0             	decl   -0x10(%ebp)
  800329:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80032c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80032f:	7e 26                	jle    800357 <QSort+0x88>
  800331:	8b 45 10             	mov    0x10(%ebp),%eax
  800334:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80033b:	8b 45 08             	mov    0x8(%ebp),%eax
  80033e:	01 d0                	add    %edx,%eax
  800340:	8b 10                	mov    (%eax),%edx
  800342:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800345:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80034c:	8b 45 08             	mov    0x8(%ebp),%eax
  80034f:	01 c8                	add    %ecx,%eax
  800351:	8b 00                	mov    (%eax),%eax
  800353:	39 c2                	cmp    %eax,%edx
  800355:	7e cf                	jle    800326 <QSort+0x57>

		if (i <= j)
  800357:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80035a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80035d:	7f 14                	jg     800373 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  80035f:	83 ec 04             	sub    $0x4,%esp
  800362:	ff 75 f0             	pushl  -0x10(%ebp)
  800365:	ff 75 f4             	pushl  -0xc(%ebp)
  800368:	ff 75 08             	pushl  0x8(%ebp)
  80036b:	e8 a9 00 00 00       	call   800419 <Swap>
  800370:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800373:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800376:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800379:	0f 8e 77 ff ff ff    	jle    8002f6 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  80037f:	83 ec 04             	sub    $0x4,%esp
  800382:	ff 75 f0             	pushl  -0x10(%ebp)
  800385:	ff 75 10             	pushl  0x10(%ebp)
  800388:	ff 75 08             	pushl  0x8(%ebp)
  80038b:	e8 89 00 00 00       	call   800419 <Swap>
  800390:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800393:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800396:	48                   	dec    %eax
  800397:	50                   	push   %eax
  800398:	ff 75 10             	pushl  0x10(%ebp)
  80039b:	ff 75 0c             	pushl  0xc(%ebp)
  80039e:	ff 75 08             	pushl  0x8(%ebp)
  8003a1:	e8 29 ff ff ff       	call   8002cf <QSort>
  8003a6:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8003a9:	ff 75 14             	pushl  0x14(%ebp)
  8003ac:	ff 75 f4             	pushl  -0xc(%ebp)
  8003af:	ff 75 0c             	pushl  0xc(%ebp)
  8003b2:	ff 75 08             	pushl  0x8(%ebp)
  8003b5:	e8 15 ff ff ff       	call   8002cf <QSort>
  8003ba:	83 c4 10             	add    $0x10,%esp
  8003bd:	eb 01                	jmp    8003c0 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8003bf:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  8003c0:	c9                   	leave  
  8003c1:	c3                   	ret    

008003c2 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8003c2:	55                   	push   %ebp
  8003c3:	89 e5                	mov    %esp,%ebp
  8003c5:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8003c8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003cf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8003d6:	eb 33                	jmp    80040b <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8003d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003db:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e5:	01 d0                	add    %edx,%eax
  8003e7:	8b 10                	mov    (%eax),%edx
  8003e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003ec:	40                   	inc    %eax
  8003ed:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f7:	01 c8                	add    %ecx,%eax
  8003f9:	8b 00                	mov    (%eax),%eax
  8003fb:	39 c2                	cmp    %eax,%edx
  8003fd:	7e 09                	jle    800408 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800406:	eb 0c                	jmp    800414 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800408:	ff 45 f8             	incl   -0x8(%ebp)
  80040b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80040e:	48                   	dec    %eax
  80040f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800412:	7f c4                	jg     8003d8 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800414:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800417:	c9                   	leave  
  800418:	c3                   	ret    

00800419 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800419:	55                   	push   %ebp
  80041a:	89 e5                	mov    %esp,%ebp
  80041c:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  80041f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800422:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800429:	8b 45 08             	mov    0x8(%ebp),%eax
  80042c:	01 d0                	add    %edx,%eax
  80042e:	8b 00                	mov    (%eax),%eax
  800430:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800433:	8b 45 0c             	mov    0xc(%ebp),%eax
  800436:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043d:	8b 45 08             	mov    0x8(%ebp),%eax
  800440:	01 c2                	add    %eax,%edx
  800442:	8b 45 10             	mov    0x10(%ebp),%eax
  800445:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80044c:	8b 45 08             	mov    0x8(%ebp),%eax
  80044f:	01 c8                	add    %ecx,%eax
  800451:	8b 00                	mov    (%eax),%eax
  800453:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800455:	8b 45 10             	mov    0x10(%ebp),%eax
  800458:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045f:	8b 45 08             	mov    0x8(%ebp),%eax
  800462:	01 c2                	add    %eax,%edx
  800464:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800467:	89 02                	mov    %eax,(%edx)
}
  800469:	90                   	nop
  80046a:	c9                   	leave  
  80046b:	c3                   	ret    

0080046c <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80046c:	55                   	push   %ebp
  80046d:	89 e5                	mov    %esp,%ebp
  80046f:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800472:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800479:	eb 17                	jmp    800492 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80047b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80047e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800485:	8b 45 08             	mov    0x8(%ebp),%eax
  800488:	01 c2                	add    %eax,%edx
  80048a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80048d:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80048f:	ff 45 fc             	incl   -0x4(%ebp)
  800492:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800495:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800498:	7c e1                	jl     80047b <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80049a:	90                   	nop
  80049b:	c9                   	leave  
  80049c:	c3                   	ret    

0080049d <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  80049d:	55                   	push   %ebp
  80049e:	89 e5                	mov    %esp,%ebp
  8004a0:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004aa:	eb 1b                	jmp    8004c7 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8004ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004af:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b9:	01 c2                	add    %eax,%edx
  8004bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004be:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8004c1:	48                   	dec    %eax
  8004c2:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004c4:	ff 45 fc             	incl   -0x4(%ebp)
  8004c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ca:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004cd:	7c dd                	jl     8004ac <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8004cf:	90                   	nop
  8004d0:	c9                   	leave  
  8004d1:	c3                   	ret    

008004d2 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8004d2:	55                   	push   %ebp
  8004d3:	89 e5                	mov    %esp,%ebp
  8004d5:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8004d8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004db:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8004e0:	f7 e9                	imul   %ecx
  8004e2:	c1 f9 1f             	sar    $0x1f,%ecx
  8004e5:	89 d0                	mov    %edx,%eax
  8004e7:	29 c8                	sub    %ecx,%eax
  8004e9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004f3:	eb 1e                	jmp    800513 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8004f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004f8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800502:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800505:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800508:	99                   	cltd   
  800509:	f7 7d f8             	idivl  -0x8(%ebp)
  80050c:	89 d0                	mov    %edx,%eax
  80050e:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800510:	ff 45 fc             	incl   -0x4(%ebp)
  800513:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800516:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800519:	7c da                	jl     8004f5 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80051b:	90                   	nop
  80051c:	c9                   	leave  
  80051d:	c3                   	ret    

0080051e <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80051e:	55                   	push   %ebp
  80051f:	89 e5                	mov    %esp,%ebp
  800521:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800524:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80052b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800532:	eb 42                	jmp    800576 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800534:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800537:	99                   	cltd   
  800538:	f7 7d f0             	idivl  -0x10(%ebp)
  80053b:	89 d0                	mov    %edx,%eax
  80053d:	85 c0                	test   %eax,%eax
  80053f:	75 10                	jne    800551 <PrintElements+0x33>
			cprintf("\n");
  800541:	83 ec 0c             	sub    $0xc,%esp
  800544:	68 a0 26 80 00       	push   $0x8026a0
  800549:	e8 d5 04 00 00       	call   800a23 <cprintf>
  80054e:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800551:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800554:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80055b:	8b 45 08             	mov    0x8(%ebp),%eax
  80055e:	01 d0                	add    %edx,%eax
  800560:	8b 00                	mov    (%eax),%eax
  800562:	83 ec 08             	sub    $0x8,%esp
  800565:	50                   	push   %eax
  800566:	68 78 28 80 00       	push   $0x802878
  80056b:	e8 b3 04 00 00       	call   800a23 <cprintf>
  800570:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800573:	ff 45 f4             	incl   -0xc(%ebp)
  800576:	8b 45 0c             	mov    0xc(%ebp),%eax
  800579:	48                   	dec    %eax
  80057a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80057d:	7f b5                	jg     800534 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80057f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800582:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800589:	8b 45 08             	mov    0x8(%ebp),%eax
  80058c:	01 d0                	add    %edx,%eax
  80058e:	8b 00                	mov    (%eax),%eax
  800590:	83 ec 08             	sub    $0x8,%esp
  800593:	50                   	push   %eax
  800594:	68 7d 28 80 00       	push   $0x80287d
  800599:	e8 85 04 00 00       	call   800a23 <cprintf>
  80059e:	83 c4 10             	add    $0x10,%esp

}
  8005a1:	90                   	nop
  8005a2:	c9                   	leave  
  8005a3:	c3                   	ret    

008005a4 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8005a4:	55                   	push   %ebp
  8005a5:	89 e5                	mov    %esp,%ebp
  8005a7:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8005aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ad:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005b0:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005b4:	83 ec 0c             	sub    $0xc,%esp
  8005b7:	50                   	push   %eax
  8005b8:	e8 70 1a 00 00       	call   80202d <sys_cputc>
  8005bd:	83 c4 10             	add    $0x10,%esp
}
  8005c0:	90                   	nop
  8005c1:	c9                   	leave  
  8005c2:	c3                   	ret    

008005c3 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8005c3:	55                   	push   %ebp
  8005c4:	89 e5                	mov    %esp,%ebp
  8005c6:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005c9:	e8 2b 1a 00 00       	call   801ff9 <sys_disable_interrupt>
	char c = ch;
  8005ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d1:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005d4:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005d8:	83 ec 0c             	sub    $0xc,%esp
  8005db:	50                   	push   %eax
  8005dc:	e8 4c 1a 00 00       	call   80202d <sys_cputc>
  8005e1:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8005e4:	e8 2a 1a 00 00       	call   802013 <sys_enable_interrupt>
}
  8005e9:	90                   	nop
  8005ea:	c9                   	leave  
  8005eb:	c3                   	ret    

008005ec <getchar>:

int
getchar(void)
{
  8005ec:	55                   	push   %ebp
  8005ed:	89 e5                	mov    %esp,%ebp
  8005ef:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8005f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005f9:	eb 08                	jmp    800603 <getchar+0x17>
	{
		c = sys_cgetc();
  8005fb:	e8 11 18 00 00       	call   801e11 <sys_cgetc>
  800600:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800603:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800607:	74 f2                	je     8005fb <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  800609:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80060c:	c9                   	leave  
  80060d:	c3                   	ret    

0080060e <atomic_getchar>:

int
atomic_getchar(void)
{
  80060e:	55                   	push   %ebp
  80060f:	89 e5                	mov    %esp,%ebp
  800611:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800614:	e8 e0 19 00 00       	call   801ff9 <sys_disable_interrupt>
	int c=0;
  800619:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800620:	eb 08                	jmp    80062a <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800622:	e8 ea 17 00 00       	call   801e11 <sys_cgetc>
  800627:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80062a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80062e:	74 f2                	je     800622 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800630:	e8 de 19 00 00       	call   802013 <sys_enable_interrupt>
	return c;
  800635:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800638:	c9                   	leave  
  800639:	c3                   	ret    

0080063a <iscons>:

int iscons(int fdnum)
{
  80063a:	55                   	push   %ebp
  80063b:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80063d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800642:	5d                   	pop    %ebp
  800643:	c3                   	ret    

00800644 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800644:	55                   	push   %ebp
  800645:	89 e5                	mov    %esp,%ebp
  800647:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80064a:	e8 0f 18 00 00       	call   801e5e <sys_getenvindex>
  80064f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800652:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800655:	89 d0                	mov    %edx,%eax
  800657:	01 c0                	add    %eax,%eax
  800659:	01 d0                	add    %edx,%eax
  80065b:	c1 e0 07             	shl    $0x7,%eax
  80065e:	29 d0                	sub    %edx,%eax
  800660:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800667:	01 c8                	add    %ecx,%eax
  800669:	01 c0                	add    %eax,%eax
  80066b:	01 d0                	add    %edx,%eax
  80066d:	01 c0                	add    %eax,%eax
  80066f:	01 d0                	add    %edx,%eax
  800671:	c1 e0 03             	shl    $0x3,%eax
  800674:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800679:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80067e:	a1 24 30 80 00       	mov    0x803024,%eax
  800683:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  800689:	84 c0                	test   %al,%al
  80068b:	74 0f                	je     80069c <libmain+0x58>
		binaryname = myEnv->prog_name;
  80068d:	a1 24 30 80 00       	mov    0x803024,%eax
  800692:	05 f0 ee 00 00       	add    $0xeef0,%eax
  800697:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80069c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8006a0:	7e 0a                	jle    8006ac <libmain+0x68>
		binaryname = argv[0];
  8006a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006a5:	8b 00                	mov    (%eax),%eax
  8006a7:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8006ac:	83 ec 08             	sub    $0x8,%esp
  8006af:	ff 75 0c             	pushl  0xc(%ebp)
  8006b2:	ff 75 08             	pushl  0x8(%ebp)
  8006b5:	e8 7e f9 ff ff       	call   800038 <_main>
  8006ba:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8006bd:	e8 37 19 00 00       	call   801ff9 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006c2:	83 ec 0c             	sub    $0xc,%esp
  8006c5:	68 9c 28 80 00       	push   $0x80289c
  8006ca:	e8 54 03 00 00       	call   800a23 <cprintf>
  8006cf:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006d2:	a1 24 30 80 00       	mov    0x803024,%eax
  8006d7:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  8006dd:	a1 24 30 80 00       	mov    0x803024,%eax
  8006e2:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  8006e8:	83 ec 04             	sub    $0x4,%esp
  8006eb:	52                   	push   %edx
  8006ec:	50                   	push   %eax
  8006ed:	68 c4 28 80 00       	push   $0x8028c4
  8006f2:	e8 2c 03 00 00       	call   800a23 <cprintf>
  8006f7:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8006fa:	a1 24 30 80 00       	mov    0x803024,%eax
  8006ff:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  800705:	a1 24 30 80 00       	mov    0x803024,%eax
  80070a:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  800710:	a1 24 30 80 00       	mov    0x803024,%eax
  800715:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  80071b:	51                   	push   %ecx
  80071c:	52                   	push   %edx
  80071d:	50                   	push   %eax
  80071e:	68 ec 28 80 00       	push   $0x8028ec
  800723:	e8 fb 02 00 00       	call   800a23 <cprintf>
  800728:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80072b:	83 ec 0c             	sub    $0xc,%esp
  80072e:	68 9c 28 80 00       	push   $0x80289c
  800733:	e8 eb 02 00 00       	call   800a23 <cprintf>
  800738:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80073b:	e8 d3 18 00 00       	call   802013 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800740:	e8 19 00 00 00       	call   80075e <exit>
}
  800745:	90                   	nop
  800746:	c9                   	leave  
  800747:	c3                   	ret    

00800748 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800748:	55                   	push   %ebp
  800749:	89 e5                	mov    %esp,%ebp
  80074b:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80074e:	83 ec 0c             	sub    $0xc,%esp
  800751:	6a 00                	push   $0x0
  800753:	e8 d2 16 00 00       	call   801e2a <sys_env_destroy>
  800758:	83 c4 10             	add    $0x10,%esp
}
  80075b:	90                   	nop
  80075c:	c9                   	leave  
  80075d:	c3                   	ret    

0080075e <exit>:

void
exit(void)
{
  80075e:	55                   	push   %ebp
  80075f:	89 e5                	mov    %esp,%ebp
  800761:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800764:	e8 27 17 00 00       	call   801e90 <sys_env_exit>
}
  800769:	90                   	nop
  80076a:	c9                   	leave  
  80076b:	c3                   	ret    

0080076c <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80076c:	55                   	push   %ebp
  80076d:	89 e5                	mov    %esp,%ebp
  80076f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800772:	8d 45 10             	lea    0x10(%ebp),%eax
  800775:	83 c0 04             	add    $0x4,%eax
  800778:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80077b:	a1 18 31 80 00       	mov    0x803118,%eax
  800780:	85 c0                	test   %eax,%eax
  800782:	74 16                	je     80079a <_panic+0x2e>
		cprintf("%s: ", argv0);
  800784:	a1 18 31 80 00       	mov    0x803118,%eax
  800789:	83 ec 08             	sub    $0x8,%esp
  80078c:	50                   	push   %eax
  80078d:	68 44 29 80 00       	push   $0x802944
  800792:	e8 8c 02 00 00       	call   800a23 <cprintf>
  800797:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80079a:	a1 00 30 80 00       	mov    0x803000,%eax
  80079f:	ff 75 0c             	pushl  0xc(%ebp)
  8007a2:	ff 75 08             	pushl  0x8(%ebp)
  8007a5:	50                   	push   %eax
  8007a6:	68 49 29 80 00       	push   $0x802949
  8007ab:	e8 73 02 00 00       	call   800a23 <cprintf>
  8007b0:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8007b6:	83 ec 08             	sub    $0x8,%esp
  8007b9:	ff 75 f4             	pushl  -0xc(%ebp)
  8007bc:	50                   	push   %eax
  8007bd:	e8 f6 01 00 00       	call   8009b8 <vcprintf>
  8007c2:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8007c5:	83 ec 08             	sub    $0x8,%esp
  8007c8:	6a 00                	push   $0x0
  8007ca:	68 65 29 80 00       	push   $0x802965
  8007cf:	e8 e4 01 00 00       	call   8009b8 <vcprintf>
  8007d4:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8007d7:	e8 82 ff ff ff       	call   80075e <exit>

	// should not return here
	while (1) ;
  8007dc:	eb fe                	jmp    8007dc <_panic+0x70>

008007de <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007de:	55                   	push   %ebp
  8007df:	89 e5                	mov    %esp,%ebp
  8007e1:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007e4:	a1 24 30 80 00       	mov    0x803024,%eax
  8007e9:	8b 50 74             	mov    0x74(%eax),%edx
  8007ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007ef:	39 c2                	cmp    %eax,%edx
  8007f1:	74 14                	je     800807 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007f3:	83 ec 04             	sub    $0x4,%esp
  8007f6:	68 68 29 80 00       	push   $0x802968
  8007fb:	6a 26                	push   $0x26
  8007fd:	68 b4 29 80 00       	push   $0x8029b4
  800802:	e8 65 ff ff ff       	call   80076c <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800807:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80080e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800815:	e9 c4 00 00 00       	jmp    8008de <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  80081a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80081d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800824:	8b 45 08             	mov    0x8(%ebp),%eax
  800827:	01 d0                	add    %edx,%eax
  800829:	8b 00                	mov    (%eax),%eax
  80082b:	85 c0                	test   %eax,%eax
  80082d:	75 08                	jne    800837 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80082f:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800832:	e9 a4 00 00 00       	jmp    8008db <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  800837:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80083e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800845:	eb 6b                	jmp    8008b2 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800847:	a1 24 30 80 00       	mov    0x803024,%eax
  80084c:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800852:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800855:	89 d0                	mov    %edx,%eax
  800857:	c1 e0 02             	shl    $0x2,%eax
  80085a:	01 d0                	add    %edx,%eax
  80085c:	c1 e0 02             	shl    $0x2,%eax
  80085f:	01 c8                	add    %ecx,%eax
  800861:	8a 40 04             	mov    0x4(%eax),%al
  800864:	84 c0                	test   %al,%al
  800866:	75 47                	jne    8008af <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800868:	a1 24 30 80 00       	mov    0x803024,%eax
  80086d:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800873:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800876:	89 d0                	mov    %edx,%eax
  800878:	c1 e0 02             	shl    $0x2,%eax
  80087b:	01 d0                	add    %edx,%eax
  80087d:	c1 e0 02             	shl    $0x2,%eax
  800880:	01 c8                	add    %ecx,%eax
  800882:	8b 00                	mov    (%eax),%eax
  800884:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800887:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80088a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80088f:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800891:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800894:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80089b:	8b 45 08             	mov    0x8(%ebp),%eax
  80089e:	01 c8                	add    %ecx,%eax
  8008a0:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008a2:	39 c2                	cmp    %eax,%edx
  8008a4:	75 09                	jne    8008af <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  8008a6:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008ad:	eb 12                	jmp    8008c1 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008af:	ff 45 e8             	incl   -0x18(%ebp)
  8008b2:	a1 24 30 80 00       	mov    0x803024,%eax
  8008b7:	8b 50 74             	mov    0x74(%eax),%edx
  8008ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008bd:	39 c2                	cmp    %eax,%edx
  8008bf:	77 86                	ja     800847 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008c1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8008c5:	75 14                	jne    8008db <CheckWSWithoutLastIndex+0xfd>
			panic(
  8008c7:	83 ec 04             	sub    $0x4,%esp
  8008ca:	68 c0 29 80 00       	push   $0x8029c0
  8008cf:	6a 3a                	push   $0x3a
  8008d1:	68 b4 29 80 00       	push   $0x8029b4
  8008d6:	e8 91 fe ff ff       	call   80076c <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8008db:	ff 45 f0             	incl   -0x10(%ebp)
  8008de:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008e1:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008e4:	0f 8c 30 ff ff ff    	jl     80081a <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008ea:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008f1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008f8:	eb 27                	jmp    800921 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008fa:	a1 24 30 80 00       	mov    0x803024,%eax
  8008ff:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800905:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800908:	89 d0                	mov    %edx,%eax
  80090a:	c1 e0 02             	shl    $0x2,%eax
  80090d:	01 d0                	add    %edx,%eax
  80090f:	c1 e0 02             	shl    $0x2,%eax
  800912:	01 c8                	add    %ecx,%eax
  800914:	8a 40 04             	mov    0x4(%eax),%al
  800917:	3c 01                	cmp    $0x1,%al
  800919:	75 03                	jne    80091e <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  80091b:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80091e:	ff 45 e0             	incl   -0x20(%ebp)
  800921:	a1 24 30 80 00       	mov    0x803024,%eax
  800926:	8b 50 74             	mov    0x74(%eax),%edx
  800929:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80092c:	39 c2                	cmp    %eax,%edx
  80092e:	77 ca                	ja     8008fa <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800930:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800933:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800936:	74 14                	je     80094c <CheckWSWithoutLastIndex+0x16e>
		panic(
  800938:	83 ec 04             	sub    $0x4,%esp
  80093b:	68 14 2a 80 00       	push   $0x802a14
  800940:	6a 44                	push   $0x44
  800942:	68 b4 29 80 00       	push   $0x8029b4
  800947:	e8 20 fe ff ff       	call   80076c <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80094c:	90                   	nop
  80094d:	c9                   	leave  
  80094e:	c3                   	ret    

0080094f <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80094f:	55                   	push   %ebp
  800950:	89 e5                	mov    %esp,%ebp
  800952:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800955:	8b 45 0c             	mov    0xc(%ebp),%eax
  800958:	8b 00                	mov    (%eax),%eax
  80095a:	8d 48 01             	lea    0x1(%eax),%ecx
  80095d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800960:	89 0a                	mov    %ecx,(%edx)
  800962:	8b 55 08             	mov    0x8(%ebp),%edx
  800965:	88 d1                	mov    %dl,%cl
  800967:	8b 55 0c             	mov    0xc(%ebp),%edx
  80096a:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80096e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800971:	8b 00                	mov    (%eax),%eax
  800973:	3d ff 00 00 00       	cmp    $0xff,%eax
  800978:	75 2c                	jne    8009a6 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80097a:	a0 28 30 80 00       	mov    0x803028,%al
  80097f:	0f b6 c0             	movzbl %al,%eax
  800982:	8b 55 0c             	mov    0xc(%ebp),%edx
  800985:	8b 12                	mov    (%edx),%edx
  800987:	89 d1                	mov    %edx,%ecx
  800989:	8b 55 0c             	mov    0xc(%ebp),%edx
  80098c:	83 c2 08             	add    $0x8,%edx
  80098f:	83 ec 04             	sub    $0x4,%esp
  800992:	50                   	push   %eax
  800993:	51                   	push   %ecx
  800994:	52                   	push   %edx
  800995:	e8 4e 14 00 00       	call   801de8 <sys_cputs>
  80099a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80099d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8009a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a9:	8b 40 04             	mov    0x4(%eax),%eax
  8009ac:	8d 50 01             	lea    0x1(%eax),%edx
  8009af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b2:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009b5:	90                   	nop
  8009b6:	c9                   	leave  
  8009b7:	c3                   	ret    

008009b8 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8009b8:	55                   	push   %ebp
  8009b9:	89 e5                	mov    %esp,%ebp
  8009bb:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009c1:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8009c8:	00 00 00 
	b.cnt = 0;
  8009cb:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8009d2:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8009d5:	ff 75 0c             	pushl  0xc(%ebp)
  8009d8:	ff 75 08             	pushl  0x8(%ebp)
  8009db:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009e1:	50                   	push   %eax
  8009e2:	68 4f 09 80 00       	push   $0x80094f
  8009e7:	e8 11 02 00 00       	call   800bfd <vprintfmt>
  8009ec:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009ef:	a0 28 30 80 00       	mov    0x803028,%al
  8009f4:	0f b6 c0             	movzbl %al,%eax
  8009f7:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009fd:	83 ec 04             	sub    $0x4,%esp
  800a00:	50                   	push   %eax
  800a01:	52                   	push   %edx
  800a02:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a08:	83 c0 08             	add    $0x8,%eax
  800a0b:	50                   	push   %eax
  800a0c:	e8 d7 13 00 00       	call   801de8 <sys_cputs>
  800a11:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a14:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800a1b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a21:	c9                   	leave  
  800a22:	c3                   	ret    

00800a23 <cprintf>:

int cprintf(const char *fmt, ...) {
  800a23:	55                   	push   %ebp
  800a24:	89 e5                	mov    %esp,%ebp
  800a26:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a29:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800a30:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a33:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a36:	8b 45 08             	mov    0x8(%ebp),%eax
  800a39:	83 ec 08             	sub    $0x8,%esp
  800a3c:	ff 75 f4             	pushl  -0xc(%ebp)
  800a3f:	50                   	push   %eax
  800a40:	e8 73 ff ff ff       	call   8009b8 <vcprintf>
  800a45:	83 c4 10             	add    $0x10,%esp
  800a48:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a4e:	c9                   	leave  
  800a4f:	c3                   	ret    

00800a50 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a50:	55                   	push   %ebp
  800a51:	89 e5                	mov    %esp,%ebp
  800a53:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a56:	e8 9e 15 00 00       	call   801ff9 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a5b:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a5e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a61:	8b 45 08             	mov    0x8(%ebp),%eax
  800a64:	83 ec 08             	sub    $0x8,%esp
  800a67:	ff 75 f4             	pushl  -0xc(%ebp)
  800a6a:	50                   	push   %eax
  800a6b:	e8 48 ff ff ff       	call   8009b8 <vcprintf>
  800a70:	83 c4 10             	add    $0x10,%esp
  800a73:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a76:	e8 98 15 00 00       	call   802013 <sys_enable_interrupt>
	return cnt;
  800a7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a7e:	c9                   	leave  
  800a7f:	c3                   	ret    

00800a80 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a80:	55                   	push   %ebp
  800a81:	89 e5                	mov    %esp,%ebp
  800a83:	53                   	push   %ebx
  800a84:	83 ec 14             	sub    $0x14,%esp
  800a87:	8b 45 10             	mov    0x10(%ebp),%eax
  800a8a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a8d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a90:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a93:	8b 45 18             	mov    0x18(%ebp),%eax
  800a96:	ba 00 00 00 00       	mov    $0x0,%edx
  800a9b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a9e:	77 55                	ja     800af5 <printnum+0x75>
  800aa0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800aa3:	72 05                	jb     800aaa <printnum+0x2a>
  800aa5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800aa8:	77 4b                	ja     800af5 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800aaa:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800aad:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800ab0:	8b 45 18             	mov    0x18(%ebp),%eax
  800ab3:	ba 00 00 00 00       	mov    $0x0,%edx
  800ab8:	52                   	push   %edx
  800ab9:	50                   	push   %eax
  800aba:	ff 75 f4             	pushl  -0xc(%ebp)
  800abd:	ff 75 f0             	pushl  -0x10(%ebp)
  800ac0:	e8 73 19 00 00       	call   802438 <__udivdi3>
  800ac5:	83 c4 10             	add    $0x10,%esp
  800ac8:	83 ec 04             	sub    $0x4,%esp
  800acb:	ff 75 20             	pushl  0x20(%ebp)
  800ace:	53                   	push   %ebx
  800acf:	ff 75 18             	pushl  0x18(%ebp)
  800ad2:	52                   	push   %edx
  800ad3:	50                   	push   %eax
  800ad4:	ff 75 0c             	pushl  0xc(%ebp)
  800ad7:	ff 75 08             	pushl  0x8(%ebp)
  800ada:	e8 a1 ff ff ff       	call   800a80 <printnum>
  800adf:	83 c4 20             	add    $0x20,%esp
  800ae2:	eb 1a                	jmp    800afe <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800ae4:	83 ec 08             	sub    $0x8,%esp
  800ae7:	ff 75 0c             	pushl  0xc(%ebp)
  800aea:	ff 75 20             	pushl  0x20(%ebp)
  800aed:	8b 45 08             	mov    0x8(%ebp),%eax
  800af0:	ff d0                	call   *%eax
  800af2:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800af5:	ff 4d 1c             	decl   0x1c(%ebp)
  800af8:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800afc:	7f e6                	jg     800ae4 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800afe:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b01:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b06:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b09:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b0c:	53                   	push   %ebx
  800b0d:	51                   	push   %ecx
  800b0e:	52                   	push   %edx
  800b0f:	50                   	push   %eax
  800b10:	e8 33 1a 00 00       	call   802548 <__umoddi3>
  800b15:	83 c4 10             	add    $0x10,%esp
  800b18:	05 74 2c 80 00       	add    $0x802c74,%eax
  800b1d:	8a 00                	mov    (%eax),%al
  800b1f:	0f be c0             	movsbl %al,%eax
  800b22:	83 ec 08             	sub    $0x8,%esp
  800b25:	ff 75 0c             	pushl  0xc(%ebp)
  800b28:	50                   	push   %eax
  800b29:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2c:	ff d0                	call   *%eax
  800b2e:	83 c4 10             	add    $0x10,%esp
}
  800b31:	90                   	nop
  800b32:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b35:	c9                   	leave  
  800b36:	c3                   	ret    

00800b37 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b37:	55                   	push   %ebp
  800b38:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b3a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b3e:	7e 1c                	jle    800b5c <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b40:	8b 45 08             	mov    0x8(%ebp),%eax
  800b43:	8b 00                	mov    (%eax),%eax
  800b45:	8d 50 08             	lea    0x8(%eax),%edx
  800b48:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4b:	89 10                	mov    %edx,(%eax)
  800b4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b50:	8b 00                	mov    (%eax),%eax
  800b52:	83 e8 08             	sub    $0x8,%eax
  800b55:	8b 50 04             	mov    0x4(%eax),%edx
  800b58:	8b 00                	mov    (%eax),%eax
  800b5a:	eb 40                	jmp    800b9c <getuint+0x65>
	else if (lflag)
  800b5c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b60:	74 1e                	je     800b80 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b62:	8b 45 08             	mov    0x8(%ebp),%eax
  800b65:	8b 00                	mov    (%eax),%eax
  800b67:	8d 50 04             	lea    0x4(%eax),%edx
  800b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6d:	89 10                	mov    %edx,(%eax)
  800b6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b72:	8b 00                	mov    (%eax),%eax
  800b74:	83 e8 04             	sub    $0x4,%eax
  800b77:	8b 00                	mov    (%eax),%eax
  800b79:	ba 00 00 00 00       	mov    $0x0,%edx
  800b7e:	eb 1c                	jmp    800b9c <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b80:	8b 45 08             	mov    0x8(%ebp),%eax
  800b83:	8b 00                	mov    (%eax),%eax
  800b85:	8d 50 04             	lea    0x4(%eax),%edx
  800b88:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8b:	89 10                	mov    %edx,(%eax)
  800b8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b90:	8b 00                	mov    (%eax),%eax
  800b92:	83 e8 04             	sub    $0x4,%eax
  800b95:	8b 00                	mov    (%eax),%eax
  800b97:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b9c:	5d                   	pop    %ebp
  800b9d:	c3                   	ret    

00800b9e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b9e:	55                   	push   %ebp
  800b9f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ba1:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ba5:	7e 1c                	jle    800bc3 <getint+0x25>
		return va_arg(*ap, long long);
  800ba7:	8b 45 08             	mov    0x8(%ebp),%eax
  800baa:	8b 00                	mov    (%eax),%eax
  800bac:	8d 50 08             	lea    0x8(%eax),%edx
  800baf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb2:	89 10                	mov    %edx,(%eax)
  800bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb7:	8b 00                	mov    (%eax),%eax
  800bb9:	83 e8 08             	sub    $0x8,%eax
  800bbc:	8b 50 04             	mov    0x4(%eax),%edx
  800bbf:	8b 00                	mov    (%eax),%eax
  800bc1:	eb 38                	jmp    800bfb <getint+0x5d>
	else if (lflag)
  800bc3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bc7:	74 1a                	je     800be3 <getint+0x45>
		return va_arg(*ap, long);
  800bc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcc:	8b 00                	mov    (%eax),%eax
  800bce:	8d 50 04             	lea    0x4(%eax),%edx
  800bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd4:	89 10                	mov    %edx,(%eax)
  800bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd9:	8b 00                	mov    (%eax),%eax
  800bdb:	83 e8 04             	sub    $0x4,%eax
  800bde:	8b 00                	mov    (%eax),%eax
  800be0:	99                   	cltd   
  800be1:	eb 18                	jmp    800bfb <getint+0x5d>
	else
		return va_arg(*ap, int);
  800be3:	8b 45 08             	mov    0x8(%ebp),%eax
  800be6:	8b 00                	mov    (%eax),%eax
  800be8:	8d 50 04             	lea    0x4(%eax),%edx
  800beb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bee:	89 10                	mov    %edx,(%eax)
  800bf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf3:	8b 00                	mov    (%eax),%eax
  800bf5:	83 e8 04             	sub    $0x4,%eax
  800bf8:	8b 00                	mov    (%eax),%eax
  800bfa:	99                   	cltd   
}
  800bfb:	5d                   	pop    %ebp
  800bfc:	c3                   	ret    

00800bfd <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bfd:	55                   	push   %ebp
  800bfe:	89 e5                	mov    %esp,%ebp
  800c00:	56                   	push   %esi
  800c01:	53                   	push   %ebx
  800c02:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c05:	eb 17                	jmp    800c1e <vprintfmt+0x21>
			if (ch == '\0')
  800c07:	85 db                	test   %ebx,%ebx
  800c09:	0f 84 af 03 00 00    	je     800fbe <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c0f:	83 ec 08             	sub    $0x8,%esp
  800c12:	ff 75 0c             	pushl  0xc(%ebp)
  800c15:	53                   	push   %ebx
  800c16:	8b 45 08             	mov    0x8(%ebp),%eax
  800c19:	ff d0                	call   *%eax
  800c1b:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c1e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c21:	8d 50 01             	lea    0x1(%eax),%edx
  800c24:	89 55 10             	mov    %edx,0x10(%ebp)
  800c27:	8a 00                	mov    (%eax),%al
  800c29:	0f b6 d8             	movzbl %al,%ebx
  800c2c:	83 fb 25             	cmp    $0x25,%ebx
  800c2f:	75 d6                	jne    800c07 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c31:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c35:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c3c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c43:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c4a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c51:	8b 45 10             	mov    0x10(%ebp),%eax
  800c54:	8d 50 01             	lea    0x1(%eax),%edx
  800c57:	89 55 10             	mov    %edx,0x10(%ebp)
  800c5a:	8a 00                	mov    (%eax),%al
  800c5c:	0f b6 d8             	movzbl %al,%ebx
  800c5f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c62:	83 f8 55             	cmp    $0x55,%eax
  800c65:	0f 87 2b 03 00 00    	ja     800f96 <vprintfmt+0x399>
  800c6b:	8b 04 85 98 2c 80 00 	mov    0x802c98(,%eax,4),%eax
  800c72:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c74:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c78:	eb d7                	jmp    800c51 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c7a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c7e:	eb d1                	jmp    800c51 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c80:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c87:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c8a:	89 d0                	mov    %edx,%eax
  800c8c:	c1 e0 02             	shl    $0x2,%eax
  800c8f:	01 d0                	add    %edx,%eax
  800c91:	01 c0                	add    %eax,%eax
  800c93:	01 d8                	add    %ebx,%eax
  800c95:	83 e8 30             	sub    $0x30,%eax
  800c98:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c9b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c9e:	8a 00                	mov    (%eax),%al
  800ca0:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ca3:	83 fb 2f             	cmp    $0x2f,%ebx
  800ca6:	7e 3e                	jle    800ce6 <vprintfmt+0xe9>
  800ca8:	83 fb 39             	cmp    $0x39,%ebx
  800cab:	7f 39                	jg     800ce6 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cad:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800cb0:	eb d5                	jmp    800c87 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800cb2:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb5:	83 c0 04             	add    $0x4,%eax
  800cb8:	89 45 14             	mov    %eax,0x14(%ebp)
  800cbb:	8b 45 14             	mov    0x14(%ebp),%eax
  800cbe:	83 e8 04             	sub    $0x4,%eax
  800cc1:	8b 00                	mov    (%eax),%eax
  800cc3:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800cc6:	eb 1f                	jmp    800ce7 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800cc8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ccc:	79 83                	jns    800c51 <vprintfmt+0x54>
				width = 0;
  800cce:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800cd5:	e9 77 ff ff ff       	jmp    800c51 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800cda:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800ce1:	e9 6b ff ff ff       	jmp    800c51 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ce6:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800ce7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ceb:	0f 89 60 ff ff ff    	jns    800c51 <vprintfmt+0x54>
				width = precision, precision = -1;
  800cf1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cf4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800cf7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cfe:	e9 4e ff ff ff       	jmp    800c51 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d03:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d06:	e9 46 ff ff ff       	jmp    800c51 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d0b:	8b 45 14             	mov    0x14(%ebp),%eax
  800d0e:	83 c0 04             	add    $0x4,%eax
  800d11:	89 45 14             	mov    %eax,0x14(%ebp)
  800d14:	8b 45 14             	mov    0x14(%ebp),%eax
  800d17:	83 e8 04             	sub    $0x4,%eax
  800d1a:	8b 00                	mov    (%eax),%eax
  800d1c:	83 ec 08             	sub    $0x8,%esp
  800d1f:	ff 75 0c             	pushl  0xc(%ebp)
  800d22:	50                   	push   %eax
  800d23:	8b 45 08             	mov    0x8(%ebp),%eax
  800d26:	ff d0                	call   *%eax
  800d28:	83 c4 10             	add    $0x10,%esp
			break;
  800d2b:	e9 89 02 00 00       	jmp    800fb9 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d30:	8b 45 14             	mov    0x14(%ebp),%eax
  800d33:	83 c0 04             	add    $0x4,%eax
  800d36:	89 45 14             	mov    %eax,0x14(%ebp)
  800d39:	8b 45 14             	mov    0x14(%ebp),%eax
  800d3c:	83 e8 04             	sub    $0x4,%eax
  800d3f:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d41:	85 db                	test   %ebx,%ebx
  800d43:	79 02                	jns    800d47 <vprintfmt+0x14a>
				err = -err;
  800d45:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d47:	83 fb 64             	cmp    $0x64,%ebx
  800d4a:	7f 0b                	jg     800d57 <vprintfmt+0x15a>
  800d4c:	8b 34 9d e0 2a 80 00 	mov    0x802ae0(,%ebx,4),%esi
  800d53:	85 f6                	test   %esi,%esi
  800d55:	75 19                	jne    800d70 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d57:	53                   	push   %ebx
  800d58:	68 85 2c 80 00       	push   $0x802c85
  800d5d:	ff 75 0c             	pushl  0xc(%ebp)
  800d60:	ff 75 08             	pushl  0x8(%ebp)
  800d63:	e8 5e 02 00 00       	call   800fc6 <printfmt>
  800d68:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d6b:	e9 49 02 00 00       	jmp    800fb9 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d70:	56                   	push   %esi
  800d71:	68 8e 2c 80 00       	push   $0x802c8e
  800d76:	ff 75 0c             	pushl  0xc(%ebp)
  800d79:	ff 75 08             	pushl  0x8(%ebp)
  800d7c:	e8 45 02 00 00       	call   800fc6 <printfmt>
  800d81:	83 c4 10             	add    $0x10,%esp
			break;
  800d84:	e9 30 02 00 00       	jmp    800fb9 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d89:	8b 45 14             	mov    0x14(%ebp),%eax
  800d8c:	83 c0 04             	add    $0x4,%eax
  800d8f:	89 45 14             	mov    %eax,0x14(%ebp)
  800d92:	8b 45 14             	mov    0x14(%ebp),%eax
  800d95:	83 e8 04             	sub    $0x4,%eax
  800d98:	8b 30                	mov    (%eax),%esi
  800d9a:	85 f6                	test   %esi,%esi
  800d9c:	75 05                	jne    800da3 <vprintfmt+0x1a6>
				p = "(null)";
  800d9e:	be 91 2c 80 00       	mov    $0x802c91,%esi
			if (width > 0 && padc != '-')
  800da3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800da7:	7e 6d                	jle    800e16 <vprintfmt+0x219>
  800da9:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800dad:	74 67                	je     800e16 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800daf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800db2:	83 ec 08             	sub    $0x8,%esp
  800db5:	50                   	push   %eax
  800db6:	56                   	push   %esi
  800db7:	e8 12 05 00 00       	call   8012ce <strnlen>
  800dbc:	83 c4 10             	add    $0x10,%esp
  800dbf:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800dc2:	eb 16                	jmp    800dda <vprintfmt+0x1dd>
					putch(padc, putdat);
  800dc4:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800dc8:	83 ec 08             	sub    $0x8,%esp
  800dcb:	ff 75 0c             	pushl  0xc(%ebp)
  800dce:	50                   	push   %eax
  800dcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd2:	ff d0                	call   *%eax
  800dd4:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800dd7:	ff 4d e4             	decl   -0x1c(%ebp)
  800dda:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dde:	7f e4                	jg     800dc4 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800de0:	eb 34                	jmp    800e16 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800de2:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800de6:	74 1c                	je     800e04 <vprintfmt+0x207>
  800de8:	83 fb 1f             	cmp    $0x1f,%ebx
  800deb:	7e 05                	jle    800df2 <vprintfmt+0x1f5>
  800ded:	83 fb 7e             	cmp    $0x7e,%ebx
  800df0:	7e 12                	jle    800e04 <vprintfmt+0x207>
					putch('?', putdat);
  800df2:	83 ec 08             	sub    $0x8,%esp
  800df5:	ff 75 0c             	pushl  0xc(%ebp)
  800df8:	6a 3f                	push   $0x3f
  800dfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfd:	ff d0                	call   *%eax
  800dff:	83 c4 10             	add    $0x10,%esp
  800e02:	eb 0f                	jmp    800e13 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e04:	83 ec 08             	sub    $0x8,%esp
  800e07:	ff 75 0c             	pushl  0xc(%ebp)
  800e0a:	53                   	push   %ebx
  800e0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0e:	ff d0                	call   *%eax
  800e10:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e13:	ff 4d e4             	decl   -0x1c(%ebp)
  800e16:	89 f0                	mov    %esi,%eax
  800e18:	8d 70 01             	lea    0x1(%eax),%esi
  800e1b:	8a 00                	mov    (%eax),%al
  800e1d:	0f be d8             	movsbl %al,%ebx
  800e20:	85 db                	test   %ebx,%ebx
  800e22:	74 24                	je     800e48 <vprintfmt+0x24b>
  800e24:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e28:	78 b8                	js     800de2 <vprintfmt+0x1e5>
  800e2a:	ff 4d e0             	decl   -0x20(%ebp)
  800e2d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e31:	79 af                	jns    800de2 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e33:	eb 13                	jmp    800e48 <vprintfmt+0x24b>
				putch(' ', putdat);
  800e35:	83 ec 08             	sub    $0x8,%esp
  800e38:	ff 75 0c             	pushl  0xc(%ebp)
  800e3b:	6a 20                	push   $0x20
  800e3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e40:	ff d0                	call   *%eax
  800e42:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e45:	ff 4d e4             	decl   -0x1c(%ebp)
  800e48:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e4c:	7f e7                	jg     800e35 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e4e:	e9 66 01 00 00       	jmp    800fb9 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e53:	83 ec 08             	sub    $0x8,%esp
  800e56:	ff 75 e8             	pushl  -0x18(%ebp)
  800e59:	8d 45 14             	lea    0x14(%ebp),%eax
  800e5c:	50                   	push   %eax
  800e5d:	e8 3c fd ff ff       	call   800b9e <getint>
  800e62:	83 c4 10             	add    $0x10,%esp
  800e65:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e68:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e6e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e71:	85 d2                	test   %edx,%edx
  800e73:	79 23                	jns    800e98 <vprintfmt+0x29b>
				putch('-', putdat);
  800e75:	83 ec 08             	sub    $0x8,%esp
  800e78:	ff 75 0c             	pushl  0xc(%ebp)
  800e7b:	6a 2d                	push   $0x2d
  800e7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e80:	ff d0                	call   *%eax
  800e82:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e85:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e88:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e8b:	f7 d8                	neg    %eax
  800e8d:	83 d2 00             	adc    $0x0,%edx
  800e90:	f7 da                	neg    %edx
  800e92:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e95:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e98:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e9f:	e9 bc 00 00 00       	jmp    800f60 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ea4:	83 ec 08             	sub    $0x8,%esp
  800ea7:	ff 75 e8             	pushl  -0x18(%ebp)
  800eaa:	8d 45 14             	lea    0x14(%ebp),%eax
  800ead:	50                   	push   %eax
  800eae:	e8 84 fc ff ff       	call   800b37 <getuint>
  800eb3:	83 c4 10             	add    $0x10,%esp
  800eb6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eb9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ebc:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ec3:	e9 98 00 00 00       	jmp    800f60 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ec8:	83 ec 08             	sub    $0x8,%esp
  800ecb:	ff 75 0c             	pushl  0xc(%ebp)
  800ece:	6a 58                	push   $0x58
  800ed0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed3:	ff d0                	call   *%eax
  800ed5:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ed8:	83 ec 08             	sub    $0x8,%esp
  800edb:	ff 75 0c             	pushl  0xc(%ebp)
  800ede:	6a 58                	push   $0x58
  800ee0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee3:	ff d0                	call   *%eax
  800ee5:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ee8:	83 ec 08             	sub    $0x8,%esp
  800eeb:	ff 75 0c             	pushl  0xc(%ebp)
  800eee:	6a 58                	push   $0x58
  800ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef3:	ff d0                	call   *%eax
  800ef5:	83 c4 10             	add    $0x10,%esp
			break;
  800ef8:	e9 bc 00 00 00       	jmp    800fb9 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800efd:	83 ec 08             	sub    $0x8,%esp
  800f00:	ff 75 0c             	pushl  0xc(%ebp)
  800f03:	6a 30                	push   $0x30
  800f05:	8b 45 08             	mov    0x8(%ebp),%eax
  800f08:	ff d0                	call   *%eax
  800f0a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f0d:	83 ec 08             	sub    $0x8,%esp
  800f10:	ff 75 0c             	pushl  0xc(%ebp)
  800f13:	6a 78                	push   $0x78
  800f15:	8b 45 08             	mov    0x8(%ebp),%eax
  800f18:	ff d0                	call   *%eax
  800f1a:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f1d:	8b 45 14             	mov    0x14(%ebp),%eax
  800f20:	83 c0 04             	add    $0x4,%eax
  800f23:	89 45 14             	mov    %eax,0x14(%ebp)
  800f26:	8b 45 14             	mov    0x14(%ebp),%eax
  800f29:	83 e8 04             	sub    $0x4,%eax
  800f2c:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f2e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f31:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f38:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f3f:	eb 1f                	jmp    800f60 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f41:	83 ec 08             	sub    $0x8,%esp
  800f44:	ff 75 e8             	pushl  -0x18(%ebp)
  800f47:	8d 45 14             	lea    0x14(%ebp),%eax
  800f4a:	50                   	push   %eax
  800f4b:	e8 e7 fb ff ff       	call   800b37 <getuint>
  800f50:	83 c4 10             	add    $0x10,%esp
  800f53:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f56:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f59:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f60:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f64:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f67:	83 ec 04             	sub    $0x4,%esp
  800f6a:	52                   	push   %edx
  800f6b:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f6e:	50                   	push   %eax
  800f6f:	ff 75 f4             	pushl  -0xc(%ebp)
  800f72:	ff 75 f0             	pushl  -0x10(%ebp)
  800f75:	ff 75 0c             	pushl  0xc(%ebp)
  800f78:	ff 75 08             	pushl  0x8(%ebp)
  800f7b:	e8 00 fb ff ff       	call   800a80 <printnum>
  800f80:	83 c4 20             	add    $0x20,%esp
			break;
  800f83:	eb 34                	jmp    800fb9 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f85:	83 ec 08             	sub    $0x8,%esp
  800f88:	ff 75 0c             	pushl  0xc(%ebp)
  800f8b:	53                   	push   %ebx
  800f8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8f:	ff d0                	call   *%eax
  800f91:	83 c4 10             	add    $0x10,%esp
			break;
  800f94:	eb 23                	jmp    800fb9 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f96:	83 ec 08             	sub    $0x8,%esp
  800f99:	ff 75 0c             	pushl  0xc(%ebp)
  800f9c:	6a 25                	push   $0x25
  800f9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa1:	ff d0                	call   *%eax
  800fa3:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800fa6:	ff 4d 10             	decl   0x10(%ebp)
  800fa9:	eb 03                	jmp    800fae <vprintfmt+0x3b1>
  800fab:	ff 4d 10             	decl   0x10(%ebp)
  800fae:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb1:	48                   	dec    %eax
  800fb2:	8a 00                	mov    (%eax),%al
  800fb4:	3c 25                	cmp    $0x25,%al
  800fb6:	75 f3                	jne    800fab <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800fb8:	90                   	nop
		}
	}
  800fb9:	e9 47 fc ff ff       	jmp    800c05 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800fbe:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800fbf:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800fc2:	5b                   	pop    %ebx
  800fc3:	5e                   	pop    %esi
  800fc4:	5d                   	pop    %ebp
  800fc5:	c3                   	ret    

00800fc6 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800fc6:	55                   	push   %ebp
  800fc7:	89 e5                	mov    %esp,%ebp
  800fc9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800fcc:	8d 45 10             	lea    0x10(%ebp),%eax
  800fcf:	83 c0 04             	add    $0x4,%eax
  800fd2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800fd5:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd8:	ff 75 f4             	pushl  -0xc(%ebp)
  800fdb:	50                   	push   %eax
  800fdc:	ff 75 0c             	pushl  0xc(%ebp)
  800fdf:	ff 75 08             	pushl  0x8(%ebp)
  800fe2:	e8 16 fc ff ff       	call   800bfd <vprintfmt>
  800fe7:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800fea:	90                   	nop
  800feb:	c9                   	leave  
  800fec:	c3                   	ret    

00800fed <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800fed:	55                   	push   %ebp
  800fee:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ff0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff3:	8b 40 08             	mov    0x8(%eax),%eax
  800ff6:	8d 50 01             	lea    0x1(%eax),%edx
  800ff9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffc:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801002:	8b 10                	mov    (%eax),%edx
  801004:	8b 45 0c             	mov    0xc(%ebp),%eax
  801007:	8b 40 04             	mov    0x4(%eax),%eax
  80100a:	39 c2                	cmp    %eax,%edx
  80100c:	73 12                	jae    801020 <sprintputch+0x33>
		*b->buf++ = ch;
  80100e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801011:	8b 00                	mov    (%eax),%eax
  801013:	8d 48 01             	lea    0x1(%eax),%ecx
  801016:	8b 55 0c             	mov    0xc(%ebp),%edx
  801019:	89 0a                	mov    %ecx,(%edx)
  80101b:	8b 55 08             	mov    0x8(%ebp),%edx
  80101e:	88 10                	mov    %dl,(%eax)
}
  801020:	90                   	nop
  801021:	5d                   	pop    %ebp
  801022:	c3                   	ret    

00801023 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801023:	55                   	push   %ebp
  801024:	89 e5                	mov    %esp,%ebp
  801026:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801029:	8b 45 08             	mov    0x8(%ebp),%eax
  80102c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80102f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801032:	8d 50 ff             	lea    -0x1(%eax),%edx
  801035:	8b 45 08             	mov    0x8(%ebp),%eax
  801038:	01 d0                	add    %edx,%eax
  80103a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80103d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801044:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801048:	74 06                	je     801050 <vsnprintf+0x2d>
  80104a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80104e:	7f 07                	jg     801057 <vsnprintf+0x34>
		return -E_INVAL;
  801050:	b8 03 00 00 00       	mov    $0x3,%eax
  801055:	eb 20                	jmp    801077 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801057:	ff 75 14             	pushl  0x14(%ebp)
  80105a:	ff 75 10             	pushl  0x10(%ebp)
  80105d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801060:	50                   	push   %eax
  801061:	68 ed 0f 80 00       	push   $0x800fed
  801066:	e8 92 fb ff ff       	call   800bfd <vprintfmt>
  80106b:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80106e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801071:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801074:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801077:	c9                   	leave  
  801078:	c3                   	ret    

00801079 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801079:	55                   	push   %ebp
  80107a:	89 e5                	mov    %esp,%ebp
  80107c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80107f:	8d 45 10             	lea    0x10(%ebp),%eax
  801082:	83 c0 04             	add    $0x4,%eax
  801085:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801088:	8b 45 10             	mov    0x10(%ebp),%eax
  80108b:	ff 75 f4             	pushl  -0xc(%ebp)
  80108e:	50                   	push   %eax
  80108f:	ff 75 0c             	pushl  0xc(%ebp)
  801092:	ff 75 08             	pushl  0x8(%ebp)
  801095:	e8 89 ff ff ff       	call   801023 <vsnprintf>
  80109a:	83 c4 10             	add    $0x10,%esp
  80109d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8010a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010a3:	c9                   	leave  
  8010a4:	c3                   	ret    

008010a5 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8010a5:	55                   	push   %ebp
  8010a6:	89 e5                	mov    %esp,%ebp
  8010a8:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8010ab:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010af:	74 13                	je     8010c4 <readline+0x1f>
		cprintf("%s", prompt);
  8010b1:	83 ec 08             	sub    $0x8,%esp
  8010b4:	ff 75 08             	pushl  0x8(%ebp)
  8010b7:	68 f0 2d 80 00       	push   $0x802df0
  8010bc:	e8 62 f9 ff ff       	call   800a23 <cprintf>
  8010c1:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8010c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8010cb:	83 ec 0c             	sub    $0xc,%esp
  8010ce:	6a 00                	push   $0x0
  8010d0:	e8 65 f5 ff ff       	call   80063a <iscons>
  8010d5:	83 c4 10             	add    $0x10,%esp
  8010d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8010db:	e8 0c f5 ff ff       	call   8005ec <getchar>
  8010e0:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8010e3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010e7:	79 22                	jns    80110b <readline+0x66>
			if (c != -E_EOF)
  8010e9:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8010ed:	0f 84 ad 00 00 00    	je     8011a0 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8010f3:	83 ec 08             	sub    $0x8,%esp
  8010f6:	ff 75 ec             	pushl  -0x14(%ebp)
  8010f9:	68 f3 2d 80 00       	push   $0x802df3
  8010fe:	e8 20 f9 ff ff       	call   800a23 <cprintf>
  801103:	83 c4 10             	add    $0x10,%esp
			return;
  801106:	e9 95 00 00 00       	jmp    8011a0 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80110b:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80110f:	7e 34                	jle    801145 <readline+0xa0>
  801111:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801118:	7f 2b                	jg     801145 <readline+0xa0>
			if (echoing)
  80111a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80111e:	74 0e                	je     80112e <readline+0x89>
				cputchar(c);
  801120:	83 ec 0c             	sub    $0xc,%esp
  801123:	ff 75 ec             	pushl  -0x14(%ebp)
  801126:	e8 79 f4 ff ff       	call   8005a4 <cputchar>
  80112b:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80112e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801131:	8d 50 01             	lea    0x1(%eax),%edx
  801134:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801137:	89 c2                	mov    %eax,%edx
  801139:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113c:	01 d0                	add    %edx,%eax
  80113e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801141:	88 10                	mov    %dl,(%eax)
  801143:	eb 56                	jmp    80119b <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801145:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801149:	75 1f                	jne    80116a <readline+0xc5>
  80114b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80114f:	7e 19                	jle    80116a <readline+0xc5>
			if (echoing)
  801151:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801155:	74 0e                	je     801165 <readline+0xc0>
				cputchar(c);
  801157:	83 ec 0c             	sub    $0xc,%esp
  80115a:	ff 75 ec             	pushl  -0x14(%ebp)
  80115d:	e8 42 f4 ff ff       	call   8005a4 <cputchar>
  801162:	83 c4 10             	add    $0x10,%esp

			i--;
  801165:	ff 4d f4             	decl   -0xc(%ebp)
  801168:	eb 31                	jmp    80119b <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  80116a:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80116e:	74 0a                	je     80117a <readline+0xd5>
  801170:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801174:	0f 85 61 ff ff ff    	jne    8010db <readline+0x36>
			if (echoing)
  80117a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80117e:	74 0e                	je     80118e <readline+0xe9>
				cputchar(c);
  801180:	83 ec 0c             	sub    $0xc,%esp
  801183:	ff 75 ec             	pushl  -0x14(%ebp)
  801186:	e8 19 f4 ff ff       	call   8005a4 <cputchar>
  80118b:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80118e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801191:	8b 45 0c             	mov    0xc(%ebp),%eax
  801194:	01 d0                	add    %edx,%eax
  801196:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801199:	eb 06                	jmp    8011a1 <readline+0xfc>
		}
	}
  80119b:	e9 3b ff ff ff       	jmp    8010db <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8011a0:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8011a1:	c9                   	leave  
  8011a2:	c3                   	ret    

008011a3 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8011a3:	55                   	push   %ebp
  8011a4:	89 e5                	mov    %esp,%ebp
  8011a6:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8011a9:	e8 4b 0e 00 00       	call   801ff9 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8011ae:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011b2:	74 13                	je     8011c7 <atomic_readline+0x24>
		cprintf("%s", prompt);
  8011b4:	83 ec 08             	sub    $0x8,%esp
  8011b7:	ff 75 08             	pushl  0x8(%ebp)
  8011ba:	68 f0 2d 80 00       	push   $0x802df0
  8011bf:	e8 5f f8 ff ff       	call   800a23 <cprintf>
  8011c4:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8011c7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8011ce:	83 ec 0c             	sub    $0xc,%esp
  8011d1:	6a 00                	push   $0x0
  8011d3:	e8 62 f4 ff ff       	call   80063a <iscons>
  8011d8:	83 c4 10             	add    $0x10,%esp
  8011db:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8011de:	e8 09 f4 ff ff       	call   8005ec <getchar>
  8011e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8011e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8011ea:	79 23                	jns    80120f <atomic_readline+0x6c>
			if (c != -E_EOF)
  8011ec:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8011f0:	74 13                	je     801205 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8011f2:	83 ec 08             	sub    $0x8,%esp
  8011f5:	ff 75 ec             	pushl  -0x14(%ebp)
  8011f8:	68 f3 2d 80 00       	push   $0x802df3
  8011fd:	e8 21 f8 ff ff       	call   800a23 <cprintf>
  801202:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801205:	e8 09 0e 00 00       	call   802013 <sys_enable_interrupt>
			return;
  80120a:	e9 9a 00 00 00       	jmp    8012a9 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80120f:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801213:	7e 34                	jle    801249 <atomic_readline+0xa6>
  801215:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80121c:	7f 2b                	jg     801249 <atomic_readline+0xa6>
			if (echoing)
  80121e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801222:	74 0e                	je     801232 <atomic_readline+0x8f>
				cputchar(c);
  801224:	83 ec 0c             	sub    $0xc,%esp
  801227:	ff 75 ec             	pushl  -0x14(%ebp)
  80122a:	e8 75 f3 ff ff       	call   8005a4 <cputchar>
  80122f:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801232:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801235:	8d 50 01             	lea    0x1(%eax),%edx
  801238:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80123b:	89 c2                	mov    %eax,%edx
  80123d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801240:	01 d0                	add    %edx,%eax
  801242:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801245:	88 10                	mov    %dl,(%eax)
  801247:	eb 5b                	jmp    8012a4 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  801249:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80124d:	75 1f                	jne    80126e <atomic_readline+0xcb>
  80124f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801253:	7e 19                	jle    80126e <atomic_readline+0xcb>
			if (echoing)
  801255:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801259:	74 0e                	je     801269 <atomic_readline+0xc6>
				cputchar(c);
  80125b:	83 ec 0c             	sub    $0xc,%esp
  80125e:	ff 75 ec             	pushl  -0x14(%ebp)
  801261:	e8 3e f3 ff ff       	call   8005a4 <cputchar>
  801266:	83 c4 10             	add    $0x10,%esp
			i--;
  801269:	ff 4d f4             	decl   -0xc(%ebp)
  80126c:	eb 36                	jmp    8012a4 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  80126e:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801272:	74 0a                	je     80127e <atomic_readline+0xdb>
  801274:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801278:	0f 85 60 ff ff ff    	jne    8011de <atomic_readline+0x3b>
			if (echoing)
  80127e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801282:	74 0e                	je     801292 <atomic_readline+0xef>
				cputchar(c);
  801284:	83 ec 0c             	sub    $0xc,%esp
  801287:	ff 75 ec             	pushl  -0x14(%ebp)
  80128a:	e8 15 f3 ff ff       	call   8005a4 <cputchar>
  80128f:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801292:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801295:	8b 45 0c             	mov    0xc(%ebp),%eax
  801298:	01 d0                	add    %edx,%eax
  80129a:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80129d:	e8 71 0d 00 00       	call   802013 <sys_enable_interrupt>
			return;
  8012a2:	eb 05                	jmp    8012a9 <atomic_readline+0x106>
		}
	}
  8012a4:	e9 35 ff ff ff       	jmp    8011de <atomic_readline+0x3b>
}
  8012a9:	c9                   	leave  
  8012aa:	c3                   	ret    

008012ab <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8012ab:	55                   	push   %ebp
  8012ac:	89 e5                	mov    %esp,%ebp
  8012ae:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8012b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012b8:	eb 06                	jmp    8012c0 <strlen+0x15>
		n++;
  8012ba:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8012bd:	ff 45 08             	incl   0x8(%ebp)
  8012c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c3:	8a 00                	mov    (%eax),%al
  8012c5:	84 c0                	test   %al,%al
  8012c7:	75 f1                	jne    8012ba <strlen+0xf>
		n++;
	return n;
  8012c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012cc:	c9                   	leave  
  8012cd:	c3                   	ret    

008012ce <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8012ce:	55                   	push   %ebp
  8012cf:	89 e5                	mov    %esp,%ebp
  8012d1:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012d4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012db:	eb 09                	jmp    8012e6 <strnlen+0x18>
		n++;
  8012dd:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012e0:	ff 45 08             	incl   0x8(%ebp)
  8012e3:	ff 4d 0c             	decl   0xc(%ebp)
  8012e6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012ea:	74 09                	je     8012f5 <strnlen+0x27>
  8012ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ef:	8a 00                	mov    (%eax),%al
  8012f1:	84 c0                	test   %al,%al
  8012f3:	75 e8                	jne    8012dd <strnlen+0xf>
		n++;
	return n;
  8012f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012f8:	c9                   	leave  
  8012f9:	c3                   	ret    

008012fa <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8012fa:	55                   	push   %ebp
  8012fb:	89 e5                	mov    %esp,%ebp
  8012fd:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801300:	8b 45 08             	mov    0x8(%ebp),%eax
  801303:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801306:	90                   	nop
  801307:	8b 45 08             	mov    0x8(%ebp),%eax
  80130a:	8d 50 01             	lea    0x1(%eax),%edx
  80130d:	89 55 08             	mov    %edx,0x8(%ebp)
  801310:	8b 55 0c             	mov    0xc(%ebp),%edx
  801313:	8d 4a 01             	lea    0x1(%edx),%ecx
  801316:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801319:	8a 12                	mov    (%edx),%dl
  80131b:	88 10                	mov    %dl,(%eax)
  80131d:	8a 00                	mov    (%eax),%al
  80131f:	84 c0                	test   %al,%al
  801321:	75 e4                	jne    801307 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801323:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801326:	c9                   	leave  
  801327:	c3                   	ret    

00801328 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801328:	55                   	push   %ebp
  801329:	89 e5                	mov    %esp,%ebp
  80132b:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80132e:	8b 45 08             	mov    0x8(%ebp),%eax
  801331:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801334:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80133b:	eb 1f                	jmp    80135c <strncpy+0x34>
		*dst++ = *src;
  80133d:	8b 45 08             	mov    0x8(%ebp),%eax
  801340:	8d 50 01             	lea    0x1(%eax),%edx
  801343:	89 55 08             	mov    %edx,0x8(%ebp)
  801346:	8b 55 0c             	mov    0xc(%ebp),%edx
  801349:	8a 12                	mov    (%edx),%dl
  80134b:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80134d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801350:	8a 00                	mov    (%eax),%al
  801352:	84 c0                	test   %al,%al
  801354:	74 03                	je     801359 <strncpy+0x31>
			src++;
  801356:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801359:	ff 45 fc             	incl   -0x4(%ebp)
  80135c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80135f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801362:	72 d9                	jb     80133d <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801364:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801367:	c9                   	leave  
  801368:	c3                   	ret    

00801369 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801369:	55                   	push   %ebp
  80136a:	89 e5                	mov    %esp,%ebp
  80136c:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80136f:	8b 45 08             	mov    0x8(%ebp),%eax
  801372:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801375:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801379:	74 30                	je     8013ab <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80137b:	eb 16                	jmp    801393 <strlcpy+0x2a>
			*dst++ = *src++;
  80137d:	8b 45 08             	mov    0x8(%ebp),%eax
  801380:	8d 50 01             	lea    0x1(%eax),%edx
  801383:	89 55 08             	mov    %edx,0x8(%ebp)
  801386:	8b 55 0c             	mov    0xc(%ebp),%edx
  801389:	8d 4a 01             	lea    0x1(%edx),%ecx
  80138c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80138f:	8a 12                	mov    (%edx),%dl
  801391:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801393:	ff 4d 10             	decl   0x10(%ebp)
  801396:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80139a:	74 09                	je     8013a5 <strlcpy+0x3c>
  80139c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139f:	8a 00                	mov    (%eax),%al
  8013a1:	84 c0                	test   %al,%al
  8013a3:	75 d8                	jne    80137d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8013a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a8:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8013ab:	8b 55 08             	mov    0x8(%ebp),%edx
  8013ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013b1:	29 c2                	sub    %eax,%edx
  8013b3:	89 d0                	mov    %edx,%eax
}
  8013b5:	c9                   	leave  
  8013b6:	c3                   	ret    

008013b7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8013b7:	55                   	push   %ebp
  8013b8:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8013ba:	eb 06                	jmp    8013c2 <strcmp+0xb>
		p++, q++;
  8013bc:	ff 45 08             	incl   0x8(%ebp)
  8013bf:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8013c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c5:	8a 00                	mov    (%eax),%al
  8013c7:	84 c0                	test   %al,%al
  8013c9:	74 0e                	je     8013d9 <strcmp+0x22>
  8013cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ce:	8a 10                	mov    (%eax),%dl
  8013d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d3:	8a 00                	mov    (%eax),%al
  8013d5:	38 c2                	cmp    %al,%dl
  8013d7:	74 e3                	je     8013bc <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8013d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013dc:	8a 00                	mov    (%eax),%al
  8013de:	0f b6 d0             	movzbl %al,%edx
  8013e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e4:	8a 00                	mov    (%eax),%al
  8013e6:	0f b6 c0             	movzbl %al,%eax
  8013e9:	29 c2                	sub    %eax,%edx
  8013eb:	89 d0                	mov    %edx,%eax
}
  8013ed:	5d                   	pop    %ebp
  8013ee:	c3                   	ret    

008013ef <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8013ef:	55                   	push   %ebp
  8013f0:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8013f2:	eb 09                	jmp    8013fd <strncmp+0xe>
		n--, p++, q++;
  8013f4:	ff 4d 10             	decl   0x10(%ebp)
  8013f7:	ff 45 08             	incl   0x8(%ebp)
  8013fa:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013fd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801401:	74 17                	je     80141a <strncmp+0x2b>
  801403:	8b 45 08             	mov    0x8(%ebp),%eax
  801406:	8a 00                	mov    (%eax),%al
  801408:	84 c0                	test   %al,%al
  80140a:	74 0e                	je     80141a <strncmp+0x2b>
  80140c:	8b 45 08             	mov    0x8(%ebp),%eax
  80140f:	8a 10                	mov    (%eax),%dl
  801411:	8b 45 0c             	mov    0xc(%ebp),%eax
  801414:	8a 00                	mov    (%eax),%al
  801416:	38 c2                	cmp    %al,%dl
  801418:	74 da                	je     8013f4 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80141a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80141e:	75 07                	jne    801427 <strncmp+0x38>
		return 0;
  801420:	b8 00 00 00 00       	mov    $0x0,%eax
  801425:	eb 14                	jmp    80143b <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801427:	8b 45 08             	mov    0x8(%ebp),%eax
  80142a:	8a 00                	mov    (%eax),%al
  80142c:	0f b6 d0             	movzbl %al,%edx
  80142f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801432:	8a 00                	mov    (%eax),%al
  801434:	0f b6 c0             	movzbl %al,%eax
  801437:	29 c2                	sub    %eax,%edx
  801439:	89 d0                	mov    %edx,%eax
}
  80143b:	5d                   	pop    %ebp
  80143c:	c3                   	ret    

0080143d <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80143d:	55                   	push   %ebp
  80143e:	89 e5                	mov    %esp,%ebp
  801440:	83 ec 04             	sub    $0x4,%esp
  801443:	8b 45 0c             	mov    0xc(%ebp),%eax
  801446:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801449:	eb 12                	jmp    80145d <strchr+0x20>
		if (*s == c)
  80144b:	8b 45 08             	mov    0x8(%ebp),%eax
  80144e:	8a 00                	mov    (%eax),%al
  801450:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801453:	75 05                	jne    80145a <strchr+0x1d>
			return (char *) s;
  801455:	8b 45 08             	mov    0x8(%ebp),%eax
  801458:	eb 11                	jmp    80146b <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80145a:	ff 45 08             	incl   0x8(%ebp)
  80145d:	8b 45 08             	mov    0x8(%ebp),%eax
  801460:	8a 00                	mov    (%eax),%al
  801462:	84 c0                	test   %al,%al
  801464:	75 e5                	jne    80144b <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801466:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80146b:	c9                   	leave  
  80146c:	c3                   	ret    

0080146d <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80146d:	55                   	push   %ebp
  80146e:	89 e5                	mov    %esp,%ebp
  801470:	83 ec 04             	sub    $0x4,%esp
  801473:	8b 45 0c             	mov    0xc(%ebp),%eax
  801476:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801479:	eb 0d                	jmp    801488 <strfind+0x1b>
		if (*s == c)
  80147b:	8b 45 08             	mov    0x8(%ebp),%eax
  80147e:	8a 00                	mov    (%eax),%al
  801480:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801483:	74 0e                	je     801493 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801485:	ff 45 08             	incl   0x8(%ebp)
  801488:	8b 45 08             	mov    0x8(%ebp),%eax
  80148b:	8a 00                	mov    (%eax),%al
  80148d:	84 c0                	test   %al,%al
  80148f:	75 ea                	jne    80147b <strfind+0xe>
  801491:	eb 01                	jmp    801494 <strfind+0x27>
		if (*s == c)
			break;
  801493:	90                   	nop
	return (char *) s;
  801494:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801497:	c9                   	leave  
  801498:	c3                   	ret    

00801499 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801499:	55                   	push   %ebp
  80149a:	89 e5                	mov    %esp,%ebp
  80149c:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80149f:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8014a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8014a8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8014ab:	eb 0e                	jmp    8014bb <memset+0x22>
		*p++ = c;
  8014ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014b0:	8d 50 01             	lea    0x1(%eax),%edx
  8014b3:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014b9:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8014bb:	ff 4d f8             	decl   -0x8(%ebp)
  8014be:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8014c2:	79 e9                	jns    8014ad <memset+0x14>
		*p++ = c;

	return v;
  8014c4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014c7:	c9                   	leave  
  8014c8:	c3                   	ret    

008014c9 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8014c9:	55                   	push   %ebp
  8014ca:	89 e5                	mov    %esp,%ebp
  8014cc:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8014db:	eb 16                	jmp    8014f3 <memcpy+0x2a>
		*d++ = *s++;
  8014dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014e0:	8d 50 01             	lea    0x1(%eax),%edx
  8014e3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014e6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014e9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014ec:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014ef:	8a 12                	mov    (%edx),%dl
  8014f1:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8014f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014f9:	89 55 10             	mov    %edx,0x10(%ebp)
  8014fc:	85 c0                	test   %eax,%eax
  8014fe:	75 dd                	jne    8014dd <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801500:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801503:	c9                   	leave  
  801504:	c3                   	ret    

00801505 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801505:	55                   	push   %ebp
  801506:	89 e5                	mov    %esp,%ebp
  801508:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80150b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80150e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801511:	8b 45 08             	mov    0x8(%ebp),%eax
  801514:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801517:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80151a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80151d:	73 50                	jae    80156f <memmove+0x6a>
  80151f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801522:	8b 45 10             	mov    0x10(%ebp),%eax
  801525:	01 d0                	add    %edx,%eax
  801527:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80152a:	76 43                	jbe    80156f <memmove+0x6a>
		s += n;
  80152c:	8b 45 10             	mov    0x10(%ebp),%eax
  80152f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801532:	8b 45 10             	mov    0x10(%ebp),%eax
  801535:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801538:	eb 10                	jmp    80154a <memmove+0x45>
			*--d = *--s;
  80153a:	ff 4d f8             	decl   -0x8(%ebp)
  80153d:	ff 4d fc             	decl   -0x4(%ebp)
  801540:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801543:	8a 10                	mov    (%eax),%dl
  801545:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801548:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80154a:	8b 45 10             	mov    0x10(%ebp),%eax
  80154d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801550:	89 55 10             	mov    %edx,0x10(%ebp)
  801553:	85 c0                	test   %eax,%eax
  801555:	75 e3                	jne    80153a <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801557:	eb 23                	jmp    80157c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801559:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80155c:	8d 50 01             	lea    0x1(%eax),%edx
  80155f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801562:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801565:	8d 4a 01             	lea    0x1(%edx),%ecx
  801568:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80156b:	8a 12                	mov    (%edx),%dl
  80156d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80156f:	8b 45 10             	mov    0x10(%ebp),%eax
  801572:	8d 50 ff             	lea    -0x1(%eax),%edx
  801575:	89 55 10             	mov    %edx,0x10(%ebp)
  801578:	85 c0                	test   %eax,%eax
  80157a:	75 dd                	jne    801559 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80157c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80157f:	c9                   	leave  
  801580:	c3                   	ret    

00801581 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801581:	55                   	push   %ebp
  801582:	89 e5                	mov    %esp,%ebp
  801584:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801587:	8b 45 08             	mov    0x8(%ebp),%eax
  80158a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80158d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801590:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801593:	eb 2a                	jmp    8015bf <memcmp+0x3e>
		if (*s1 != *s2)
  801595:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801598:	8a 10                	mov    (%eax),%dl
  80159a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80159d:	8a 00                	mov    (%eax),%al
  80159f:	38 c2                	cmp    %al,%dl
  8015a1:	74 16                	je     8015b9 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015a6:	8a 00                	mov    (%eax),%al
  8015a8:	0f b6 d0             	movzbl %al,%edx
  8015ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ae:	8a 00                	mov    (%eax),%al
  8015b0:	0f b6 c0             	movzbl %al,%eax
  8015b3:	29 c2                	sub    %eax,%edx
  8015b5:	89 d0                	mov    %edx,%eax
  8015b7:	eb 18                	jmp    8015d1 <memcmp+0x50>
		s1++, s2++;
  8015b9:	ff 45 fc             	incl   -0x4(%ebp)
  8015bc:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015c5:	89 55 10             	mov    %edx,0x10(%ebp)
  8015c8:	85 c0                	test   %eax,%eax
  8015ca:	75 c9                	jne    801595 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8015cc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d1:	c9                   	leave  
  8015d2:	c3                   	ret    

008015d3 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8015d3:	55                   	push   %ebp
  8015d4:	89 e5                	mov    %esp,%ebp
  8015d6:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8015d9:	8b 55 08             	mov    0x8(%ebp),%edx
  8015dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8015df:	01 d0                	add    %edx,%eax
  8015e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015e4:	eb 15                	jmp    8015fb <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e9:	8a 00                	mov    (%eax),%al
  8015eb:	0f b6 d0             	movzbl %al,%edx
  8015ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015f1:	0f b6 c0             	movzbl %al,%eax
  8015f4:	39 c2                	cmp    %eax,%edx
  8015f6:	74 0d                	je     801605 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015f8:	ff 45 08             	incl   0x8(%ebp)
  8015fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fe:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801601:	72 e3                	jb     8015e6 <memfind+0x13>
  801603:	eb 01                	jmp    801606 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801605:	90                   	nop
	return (void *) s;
  801606:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801609:	c9                   	leave  
  80160a:	c3                   	ret    

0080160b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80160b:	55                   	push   %ebp
  80160c:	89 e5                	mov    %esp,%ebp
  80160e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801611:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801618:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80161f:	eb 03                	jmp    801624 <strtol+0x19>
		s++;
  801621:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801624:	8b 45 08             	mov    0x8(%ebp),%eax
  801627:	8a 00                	mov    (%eax),%al
  801629:	3c 20                	cmp    $0x20,%al
  80162b:	74 f4                	je     801621 <strtol+0x16>
  80162d:	8b 45 08             	mov    0x8(%ebp),%eax
  801630:	8a 00                	mov    (%eax),%al
  801632:	3c 09                	cmp    $0x9,%al
  801634:	74 eb                	je     801621 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801636:	8b 45 08             	mov    0x8(%ebp),%eax
  801639:	8a 00                	mov    (%eax),%al
  80163b:	3c 2b                	cmp    $0x2b,%al
  80163d:	75 05                	jne    801644 <strtol+0x39>
		s++;
  80163f:	ff 45 08             	incl   0x8(%ebp)
  801642:	eb 13                	jmp    801657 <strtol+0x4c>
	else if (*s == '-')
  801644:	8b 45 08             	mov    0x8(%ebp),%eax
  801647:	8a 00                	mov    (%eax),%al
  801649:	3c 2d                	cmp    $0x2d,%al
  80164b:	75 0a                	jne    801657 <strtol+0x4c>
		s++, neg = 1;
  80164d:	ff 45 08             	incl   0x8(%ebp)
  801650:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801657:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80165b:	74 06                	je     801663 <strtol+0x58>
  80165d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801661:	75 20                	jne    801683 <strtol+0x78>
  801663:	8b 45 08             	mov    0x8(%ebp),%eax
  801666:	8a 00                	mov    (%eax),%al
  801668:	3c 30                	cmp    $0x30,%al
  80166a:	75 17                	jne    801683 <strtol+0x78>
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	40                   	inc    %eax
  801670:	8a 00                	mov    (%eax),%al
  801672:	3c 78                	cmp    $0x78,%al
  801674:	75 0d                	jne    801683 <strtol+0x78>
		s += 2, base = 16;
  801676:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80167a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801681:	eb 28                	jmp    8016ab <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801683:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801687:	75 15                	jne    80169e <strtol+0x93>
  801689:	8b 45 08             	mov    0x8(%ebp),%eax
  80168c:	8a 00                	mov    (%eax),%al
  80168e:	3c 30                	cmp    $0x30,%al
  801690:	75 0c                	jne    80169e <strtol+0x93>
		s++, base = 8;
  801692:	ff 45 08             	incl   0x8(%ebp)
  801695:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80169c:	eb 0d                	jmp    8016ab <strtol+0xa0>
	else if (base == 0)
  80169e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016a2:	75 07                	jne    8016ab <strtol+0xa0>
		base = 10;
  8016a4:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ae:	8a 00                	mov    (%eax),%al
  8016b0:	3c 2f                	cmp    $0x2f,%al
  8016b2:	7e 19                	jle    8016cd <strtol+0xc2>
  8016b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b7:	8a 00                	mov    (%eax),%al
  8016b9:	3c 39                	cmp    $0x39,%al
  8016bb:	7f 10                	jg     8016cd <strtol+0xc2>
			dig = *s - '0';
  8016bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c0:	8a 00                	mov    (%eax),%al
  8016c2:	0f be c0             	movsbl %al,%eax
  8016c5:	83 e8 30             	sub    $0x30,%eax
  8016c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016cb:	eb 42                	jmp    80170f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8016cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d0:	8a 00                	mov    (%eax),%al
  8016d2:	3c 60                	cmp    $0x60,%al
  8016d4:	7e 19                	jle    8016ef <strtol+0xe4>
  8016d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d9:	8a 00                	mov    (%eax),%al
  8016db:	3c 7a                	cmp    $0x7a,%al
  8016dd:	7f 10                	jg     8016ef <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016df:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e2:	8a 00                	mov    (%eax),%al
  8016e4:	0f be c0             	movsbl %al,%eax
  8016e7:	83 e8 57             	sub    $0x57,%eax
  8016ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016ed:	eb 20                	jmp    80170f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f2:	8a 00                	mov    (%eax),%al
  8016f4:	3c 40                	cmp    $0x40,%al
  8016f6:	7e 39                	jle    801731 <strtol+0x126>
  8016f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fb:	8a 00                	mov    (%eax),%al
  8016fd:	3c 5a                	cmp    $0x5a,%al
  8016ff:	7f 30                	jg     801731 <strtol+0x126>
			dig = *s - 'A' + 10;
  801701:	8b 45 08             	mov    0x8(%ebp),%eax
  801704:	8a 00                	mov    (%eax),%al
  801706:	0f be c0             	movsbl %al,%eax
  801709:	83 e8 37             	sub    $0x37,%eax
  80170c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80170f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801712:	3b 45 10             	cmp    0x10(%ebp),%eax
  801715:	7d 19                	jge    801730 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801717:	ff 45 08             	incl   0x8(%ebp)
  80171a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80171d:	0f af 45 10          	imul   0x10(%ebp),%eax
  801721:	89 c2                	mov    %eax,%edx
  801723:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801726:	01 d0                	add    %edx,%eax
  801728:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80172b:	e9 7b ff ff ff       	jmp    8016ab <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801730:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801731:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801735:	74 08                	je     80173f <strtol+0x134>
		*endptr = (char *) s;
  801737:	8b 45 0c             	mov    0xc(%ebp),%eax
  80173a:	8b 55 08             	mov    0x8(%ebp),%edx
  80173d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80173f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801743:	74 07                	je     80174c <strtol+0x141>
  801745:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801748:	f7 d8                	neg    %eax
  80174a:	eb 03                	jmp    80174f <strtol+0x144>
  80174c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80174f:	c9                   	leave  
  801750:	c3                   	ret    

00801751 <ltostr>:

void
ltostr(long value, char *str)
{
  801751:	55                   	push   %ebp
  801752:	89 e5                	mov    %esp,%ebp
  801754:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801757:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80175e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801765:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801769:	79 13                	jns    80177e <ltostr+0x2d>
	{
		neg = 1;
  80176b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801772:	8b 45 0c             	mov    0xc(%ebp),%eax
  801775:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801778:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80177b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80177e:	8b 45 08             	mov    0x8(%ebp),%eax
  801781:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801786:	99                   	cltd   
  801787:	f7 f9                	idiv   %ecx
  801789:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80178c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80178f:	8d 50 01             	lea    0x1(%eax),%edx
  801792:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801795:	89 c2                	mov    %eax,%edx
  801797:	8b 45 0c             	mov    0xc(%ebp),%eax
  80179a:	01 d0                	add    %edx,%eax
  80179c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80179f:	83 c2 30             	add    $0x30,%edx
  8017a2:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017a7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017ac:	f7 e9                	imul   %ecx
  8017ae:	c1 fa 02             	sar    $0x2,%edx
  8017b1:	89 c8                	mov    %ecx,%eax
  8017b3:	c1 f8 1f             	sar    $0x1f,%eax
  8017b6:	29 c2                	sub    %eax,%edx
  8017b8:	89 d0                	mov    %edx,%eax
  8017ba:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8017bd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017c0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017c5:	f7 e9                	imul   %ecx
  8017c7:	c1 fa 02             	sar    $0x2,%edx
  8017ca:	89 c8                	mov    %ecx,%eax
  8017cc:	c1 f8 1f             	sar    $0x1f,%eax
  8017cf:	29 c2                	sub    %eax,%edx
  8017d1:	89 d0                	mov    %edx,%eax
  8017d3:	c1 e0 02             	shl    $0x2,%eax
  8017d6:	01 d0                	add    %edx,%eax
  8017d8:	01 c0                	add    %eax,%eax
  8017da:	29 c1                	sub    %eax,%ecx
  8017dc:	89 ca                	mov    %ecx,%edx
  8017de:	85 d2                	test   %edx,%edx
  8017e0:	75 9c                	jne    80177e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8017e2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017ec:	48                   	dec    %eax
  8017ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017f0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017f4:	74 3d                	je     801833 <ltostr+0xe2>
		start = 1 ;
  8017f6:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017fd:	eb 34                	jmp    801833 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8017ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801802:	8b 45 0c             	mov    0xc(%ebp),%eax
  801805:	01 d0                	add    %edx,%eax
  801807:	8a 00                	mov    (%eax),%al
  801809:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80180c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80180f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801812:	01 c2                	add    %eax,%edx
  801814:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801817:	8b 45 0c             	mov    0xc(%ebp),%eax
  80181a:	01 c8                	add    %ecx,%eax
  80181c:	8a 00                	mov    (%eax),%al
  80181e:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801820:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801823:	8b 45 0c             	mov    0xc(%ebp),%eax
  801826:	01 c2                	add    %eax,%edx
  801828:	8a 45 eb             	mov    -0x15(%ebp),%al
  80182b:	88 02                	mov    %al,(%edx)
		start++ ;
  80182d:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801830:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801833:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801836:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801839:	7c c4                	jl     8017ff <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80183b:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80183e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801841:	01 d0                	add    %edx,%eax
  801843:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801846:	90                   	nop
  801847:	c9                   	leave  
  801848:	c3                   	ret    

00801849 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801849:	55                   	push   %ebp
  80184a:	89 e5                	mov    %esp,%ebp
  80184c:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80184f:	ff 75 08             	pushl  0x8(%ebp)
  801852:	e8 54 fa ff ff       	call   8012ab <strlen>
  801857:	83 c4 04             	add    $0x4,%esp
  80185a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80185d:	ff 75 0c             	pushl  0xc(%ebp)
  801860:	e8 46 fa ff ff       	call   8012ab <strlen>
  801865:	83 c4 04             	add    $0x4,%esp
  801868:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80186b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801872:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801879:	eb 17                	jmp    801892 <strcconcat+0x49>
		final[s] = str1[s] ;
  80187b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80187e:	8b 45 10             	mov    0x10(%ebp),%eax
  801881:	01 c2                	add    %eax,%edx
  801883:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801886:	8b 45 08             	mov    0x8(%ebp),%eax
  801889:	01 c8                	add    %ecx,%eax
  80188b:	8a 00                	mov    (%eax),%al
  80188d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80188f:	ff 45 fc             	incl   -0x4(%ebp)
  801892:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801895:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801898:	7c e1                	jl     80187b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80189a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8018a1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8018a8:	eb 1f                	jmp    8018c9 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8018aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018ad:	8d 50 01             	lea    0x1(%eax),%edx
  8018b0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018b3:	89 c2                	mov    %eax,%edx
  8018b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b8:	01 c2                	add    %eax,%edx
  8018ba:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018c0:	01 c8                	add    %ecx,%eax
  8018c2:	8a 00                	mov    (%eax),%al
  8018c4:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8018c6:	ff 45 f8             	incl   -0x8(%ebp)
  8018c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018cc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018cf:	7c d9                	jl     8018aa <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8018d1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8018d7:	01 d0                	add    %edx,%eax
  8018d9:	c6 00 00             	movb   $0x0,(%eax)
}
  8018dc:	90                   	nop
  8018dd:	c9                   	leave  
  8018de:	c3                   	ret    

008018df <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8018df:	55                   	push   %ebp
  8018e0:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8018e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8018e5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8018ee:	8b 00                	mov    (%eax),%eax
  8018f0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8018fa:	01 d0                	add    %edx,%eax
  8018fc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801902:	eb 0c                	jmp    801910 <strsplit+0x31>
			*string++ = 0;
  801904:	8b 45 08             	mov    0x8(%ebp),%eax
  801907:	8d 50 01             	lea    0x1(%eax),%edx
  80190a:	89 55 08             	mov    %edx,0x8(%ebp)
  80190d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801910:	8b 45 08             	mov    0x8(%ebp),%eax
  801913:	8a 00                	mov    (%eax),%al
  801915:	84 c0                	test   %al,%al
  801917:	74 18                	je     801931 <strsplit+0x52>
  801919:	8b 45 08             	mov    0x8(%ebp),%eax
  80191c:	8a 00                	mov    (%eax),%al
  80191e:	0f be c0             	movsbl %al,%eax
  801921:	50                   	push   %eax
  801922:	ff 75 0c             	pushl  0xc(%ebp)
  801925:	e8 13 fb ff ff       	call   80143d <strchr>
  80192a:	83 c4 08             	add    $0x8,%esp
  80192d:	85 c0                	test   %eax,%eax
  80192f:	75 d3                	jne    801904 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801931:	8b 45 08             	mov    0x8(%ebp),%eax
  801934:	8a 00                	mov    (%eax),%al
  801936:	84 c0                	test   %al,%al
  801938:	74 5a                	je     801994 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80193a:	8b 45 14             	mov    0x14(%ebp),%eax
  80193d:	8b 00                	mov    (%eax),%eax
  80193f:	83 f8 0f             	cmp    $0xf,%eax
  801942:	75 07                	jne    80194b <strsplit+0x6c>
		{
			return 0;
  801944:	b8 00 00 00 00       	mov    $0x0,%eax
  801949:	eb 66                	jmp    8019b1 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80194b:	8b 45 14             	mov    0x14(%ebp),%eax
  80194e:	8b 00                	mov    (%eax),%eax
  801950:	8d 48 01             	lea    0x1(%eax),%ecx
  801953:	8b 55 14             	mov    0x14(%ebp),%edx
  801956:	89 0a                	mov    %ecx,(%edx)
  801958:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80195f:	8b 45 10             	mov    0x10(%ebp),%eax
  801962:	01 c2                	add    %eax,%edx
  801964:	8b 45 08             	mov    0x8(%ebp),%eax
  801967:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801969:	eb 03                	jmp    80196e <strsplit+0x8f>
			string++;
  80196b:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80196e:	8b 45 08             	mov    0x8(%ebp),%eax
  801971:	8a 00                	mov    (%eax),%al
  801973:	84 c0                	test   %al,%al
  801975:	74 8b                	je     801902 <strsplit+0x23>
  801977:	8b 45 08             	mov    0x8(%ebp),%eax
  80197a:	8a 00                	mov    (%eax),%al
  80197c:	0f be c0             	movsbl %al,%eax
  80197f:	50                   	push   %eax
  801980:	ff 75 0c             	pushl  0xc(%ebp)
  801983:	e8 b5 fa ff ff       	call   80143d <strchr>
  801988:	83 c4 08             	add    $0x8,%esp
  80198b:	85 c0                	test   %eax,%eax
  80198d:	74 dc                	je     80196b <strsplit+0x8c>
			string++;
	}
  80198f:	e9 6e ff ff ff       	jmp    801902 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801994:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801995:	8b 45 14             	mov    0x14(%ebp),%eax
  801998:	8b 00                	mov    (%eax),%eax
  80199a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8019a4:	01 d0                	add    %edx,%eax
  8019a6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019ac:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019b1:	c9                   	leave  
  8019b2:	c3                   	ret    

008019b3 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  8019b3:	55                   	push   %ebp
  8019b4:	89 e5                	mov    %esp,%ebp
  8019b6:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  8019b9:	e8 3b 09 00 00       	call   8022f9 <sys_isUHeapPlacementStrategyFIRSTFIT>
  8019be:	85 c0                	test   %eax,%eax
  8019c0:	0f 84 3a 01 00 00    	je     801b00 <malloc+0x14d>

		if(pl == 0){
  8019c6:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019cb:	85 c0                	test   %eax,%eax
  8019cd:	75 24                	jne    8019f3 <malloc+0x40>
			for(int k = 0; k < Size; k++){
  8019cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8019d6:	eb 11                	jmp    8019e9 <malloc+0x36>
				arr[k] = -10000;
  8019d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019db:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  8019e2:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  8019e6:	ff 45 f4             	incl   -0xc(%ebp)
  8019e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019ec:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8019f1:	76 e5                	jbe    8019d8 <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  8019f3:	c7 05 2c 30 80 00 01 	movl   $0x1,0x80302c
  8019fa:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  8019fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801a00:	c1 e8 0c             	shr    $0xc,%eax
  801a03:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  801a06:	8b 45 08             	mov    0x8(%ebp),%eax
  801a09:	25 ff 0f 00 00       	and    $0xfff,%eax
  801a0e:	85 c0                	test   %eax,%eax
  801a10:	74 03                	je     801a15 <malloc+0x62>
			x++;
  801a12:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  801a15:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  801a1c:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801a23:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801a2a:	eb 66                	jmp    801a92 <malloc+0xdf>
			if( arr[k] == -10000){
  801a2c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a2f:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801a36:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801a3b:	75 52                	jne    801a8f <malloc+0xdc>
				uint32 w = 0 ;
  801a3d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  801a44:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a47:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  801a4a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a4d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801a50:	eb 09                	jmp    801a5b <malloc+0xa8>
  801a52:	ff 45 e0             	incl   -0x20(%ebp)
  801a55:	ff 45 dc             	incl   -0x24(%ebp)
  801a58:	ff 45 e4             	incl   -0x1c(%ebp)
  801a5b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801a5e:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801a63:	77 19                	ja     801a7e <malloc+0xcb>
  801a65:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801a68:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801a6f:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801a74:	75 08                	jne    801a7e <malloc+0xcb>
  801a76:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a79:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a7c:	72 d4                	jb     801a52 <malloc+0x9f>
				if(w >= x){
  801a7e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a81:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a84:	72 09                	jb     801a8f <malloc+0xdc>
					p = 1 ;
  801a86:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  801a8d:	eb 0d                	jmp    801a9c <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801a8f:	ff 45 e4             	incl   -0x1c(%ebp)
  801a92:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a95:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801a9a:	76 90                	jbe    801a2c <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  801a9c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801aa0:	75 0a                	jne    801aac <malloc+0xf9>
  801aa2:	b8 00 00 00 00       	mov    $0x0,%eax
  801aa7:	e9 ca 01 00 00       	jmp    801c76 <malloc+0x2c3>
		int q = idx;
  801aac:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801aaf:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  801ab2:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801ab9:	eb 16                	jmp    801ad1 <malloc+0x11e>
			arr[q++] = x;
  801abb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801abe:	8d 50 01             	lea    0x1(%eax),%edx
  801ac1:	89 55 d8             	mov    %edx,-0x28(%ebp)
  801ac4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801ac7:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  801ace:	ff 45 d4             	incl   -0x2c(%ebp)
  801ad1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801ad4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ad7:	72 e2                	jb     801abb <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801ad9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801adc:	05 00 00 08 00       	add    $0x80000,%eax
  801ae1:	c1 e0 0c             	shl    $0xc,%eax
  801ae4:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  801ae7:	83 ec 08             	sub    $0x8,%esp
  801aea:	ff 75 f0             	pushl  -0x10(%ebp)
  801aed:	ff 75 ac             	pushl  -0x54(%ebp)
  801af0:	e8 9b 04 00 00       	call   801f90 <sys_allocateMem>
  801af5:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801af8:	8b 45 ac             	mov    -0x54(%ebp),%eax
  801afb:	e9 76 01 00 00       	jmp    801c76 <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  801b00:	e8 25 08 00 00       	call   80232a <sys_isUHeapPlacementStrategyBESTFIT>
  801b05:	85 c0                	test   %eax,%eax
  801b07:	0f 84 64 01 00 00    	je     801c71 <malloc+0x2be>
		if(pl == 0){
  801b0d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b12:	85 c0                	test   %eax,%eax
  801b14:	75 24                	jne    801b3a <malloc+0x187>
			for(int k = 0; k < Size; k++){
  801b16:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  801b1d:	eb 11                	jmp    801b30 <malloc+0x17d>
				arr[k] = -10000;
  801b1f:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b22:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801b29:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801b2d:	ff 45 d0             	incl   -0x30(%ebp)
  801b30:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b33:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801b38:	76 e5                	jbe    801b1f <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801b3a:	c7 05 2c 30 80 00 01 	movl   $0x1,0x80302c
  801b41:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801b44:	8b 45 08             	mov    0x8(%ebp),%eax
  801b47:	c1 e8 0c             	shr    $0xc,%eax
  801b4a:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  801b4d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b50:	25 ff 0f 00 00       	and    $0xfff,%eax
  801b55:	85 c0                	test   %eax,%eax
  801b57:	74 03                	je     801b5c <malloc+0x1a9>
			x++;
  801b59:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  801b5c:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  801b63:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  801b6a:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  801b71:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  801b78:	e9 88 00 00 00       	jmp    801c05 <malloc+0x252>
			if(arr[k] == -10000){
  801b7d:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801b80:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801b87:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801b8c:	75 64                	jne    801bf2 <malloc+0x23f>
				uint32 w = 0 , i;
  801b8e:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  801b95:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801b98:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  801b9b:	eb 06                	jmp    801ba3 <malloc+0x1f0>
  801b9d:	ff 45 b8             	incl   -0x48(%ebp)
  801ba0:	ff 45 b4             	incl   -0x4c(%ebp)
  801ba3:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  801baa:	77 11                	ja     801bbd <malloc+0x20a>
  801bac:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801baf:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801bb6:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801bbb:	74 e0                	je     801b9d <malloc+0x1ea>
				if(w <q && w >= x){
  801bbd:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801bc0:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  801bc3:	73 24                	jae    801be9 <malloc+0x236>
  801bc5:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801bc8:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801bcb:	72 1c                	jb     801be9 <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  801bcd:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801bd0:	89 45 c8             	mov    %eax,-0x38(%ebp)
  801bd3:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  801bda:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801bdd:	89 45 c0             	mov    %eax,-0x40(%ebp)
  801be0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801be3:	48                   	dec    %eax
  801be4:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801be7:	eb 19                	jmp    801c02 <malloc+0x24f>
				}
				else {
					k = i - 1;
  801be9:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801bec:	48                   	dec    %eax
  801bed:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801bf0:	eb 10                	jmp    801c02 <malloc+0x24f>
				}
			} else {
				k += arr[k];
  801bf2:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801bf5:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801bfc:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  801bff:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  801c02:	ff 45 bc             	incl   -0x44(%ebp)
  801c05:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801c08:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801c0d:	0f 86 6a ff ff ff    	jbe    801b7d <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  801c13:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  801c17:	75 07                	jne    801c20 <malloc+0x26d>
  801c19:	b8 00 00 00 00       	mov    $0x0,%eax
  801c1e:	eb 56                	jmp    801c76 <malloc+0x2c3>
	    q = idx;
  801c20:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801c23:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  801c26:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  801c2d:	eb 16                	jmp    801c45 <malloc+0x292>
			arr[q++] = x;
  801c2f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801c32:	8d 50 01             	lea    0x1(%eax),%edx
  801c35:	89 55 c8             	mov    %edx,-0x38(%ebp)
  801c38:	8b 55 cc             	mov    -0x34(%ebp),%edx
  801c3b:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  801c42:	ff 45 b0             	incl   -0x50(%ebp)
  801c45:	8b 45 b0             	mov    -0x50(%ebp),%eax
  801c48:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801c4b:	72 e2                	jb     801c2f <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801c4d:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801c50:	05 00 00 08 00       	add    $0x80000,%eax
  801c55:	c1 e0 0c             	shl    $0xc,%eax
  801c58:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  801c5b:	83 ec 08             	sub    $0x8,%esp
  801c5e:	ff 75 cc             	pushl  -0x34(%ebp)
  801c61:	ff 75 a8             	pushl  -0x58(%ebp)
  801c64:	e8 27 03 00 00       	call   801f90 <sys_allocateMem>
  801c69:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801c6c:	8b 45 a8             	mov    -0x58(%ebp),%eax
  801c6f:	eb 05                	jmp    801c76 <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  801c71:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c76:	c9                   	leave  
  801c77:	c3                   	ret    

00801c78 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801c78:	55                   	push   %ebp
  801c79:	89 e5                	mov    %esp,%ebp
  801c7b:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  801c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c81:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801c84:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c87:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801c8c:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  801c8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c92:	05 00 00 00 80       	add    $0x80000000,%eax
  801c97:	c1 e8 0c             	shr    $0xc,%eax
  801c9a:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801ca1:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801ca4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801cab:	8b 45 08             	mov    0x8(%ebp),%eax
  801cae:	05 00 00 00 80       	add    $0x80000000,%eax
  801cb3:	c1 e8 0c             	shr    $0xc,%eax
  801cb6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801cb9:	eb 14                	jmp    801ccf <free+0x57>
		arr[j] = -10000;
  801cbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cbe:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801cc5:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801cc9:	ff 45 f4             	incl   -0xc(%ebp)
  801ccc:	ff 45 f0             	incl   -0x10(%ebp)
  801ccf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801cd2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801cd5:	72 e4                	jb     801cbb <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  801cd7:	8b 45 08             	mov    0x8(%ebp),%eax
  801cda:	83 ec 08             	sub    $0x8,%esp
  801cdd:	ff 75 e8             	pushl  -0x18(%ebp)
  801ce0:	50                   	push   %eax
  801ce1:	e8 8e 02 00 00       	call   801f74 <sys_freeMem>
  801ce6:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  801ce9:	90                   	nop
  801cea:	c9                   	leave  
  801ceb:	c3                   	ret    

00801cec <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801cec:	55                   	push   %ebp
  801ced:	89 e5                	mov    %esp,%ebp
  801cef:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801cf2:	83 ec 04             	sub    $0x4,%esp
  801cf5:	68 04 2e 80 00       	push   $0x802e04
  801cfa:	68 9e 00 00 00       	push   $0x9e
  801cff:	68 27 2e 80 00       	push   $0x802e27
  801d04:	e8 63 ea ff ff       	call   80076c <_panic>

00801d09 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801d09:	55                   	push   %ebp
  801d0a:	89 e5                	mov    %esp,%ebp
  801d0c:	83 ec 18             	sub    $0x18,%esp
  801d0f:	8b 45 10             	mov    0x10(%ebp),%eax
  801d12:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801d15:	83 ec 04             	sub    $0x4,%esp
  801d18:	68 04 2e 80 00       	push   $0x802e04
  801d1d:	68 a9 00 00 00       	push   $0xa9
  801d22:	68 27 2e 80 00       	push   $0x802e27
  801d27:	e8 40 ea ff ff       	call   80076c <_panic>

00801d2c <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801d2c:	55                   	push   %ebp
  801d2d:	89 e5                	mov    %esp,%ebp
  801d2f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d32:	83 ec 04             	sub    $0x4,%esp
  801d35:	68 04 2e 80 00       	push   $0x802e04
  801d3a:	68 af 00 00 00       	push   $0xaf
  801d3f:	68 27 2e 80 00       	push   $0x802e27
  801d44:	e8 23 ea ff ff       	call   80076c <_panic>

00801d49 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801d49:	55                   	push   %ebp
  801d4a:	89 e5                	mov    %esp,%ebp
  801d4c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d4f:	83 ec 04             	sub    $0x4,%esp
  801d52:	68 04 2e 80 00       	push   $0x802e04
  801d57:	68 b5 00 00 00       	push   $0xb5
  801d5c:	68 27 2e 80 00       	push   $0x802e27
  801d61:	e8 06 ea ff ff       	call   80076c <_panic>

00801d66 <expand>:
}

void expand(uint32 newSize)
{
  801d66:	55                   	push   %ebp
  801d67:	89 e5                	mov    %esp,%ebp
  801d69:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d6c:	83 ec 04             	sub    $0x4,%esp
  801d6f:	68 04 2e 80 00       	push   $0x802e04
  801d74:	68 ba 00 00 00       	push   $0xba
  801d79:	68 27 2e 80 00       	push   $0x802e27
  801d7e:	e8 e9 e9 ff ff       	call   80076c <_panic>

00801d83 <shrink>:
}
void shrink(uint32 newSize)
{
  801d83:	55                   	push   %ebp
  801d84:	89 e5                	mov    %esp,%ebp
  801d86:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d89:	83 ec 04             	sub    $0x4,%esp
  801d8c:	68 04 2e 80 00       	push   $0x802e04
  801d91:	68 be 00 00 00       	push   $0xbe
  801d96:	68 27 2e 80 00       	push   $0x802e27
  801d9b:	e8 cc e9 ff ff       	call   80076c <_panic>

00801da0 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801da0:	55                   	push   %ebp
  801da1:	89 e5                	mov    %esp,%ebp
  801da3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801da6:	83 ec 04             	sub    $0x4,%esp
  801da9:	68 04 2e 80 00       	push   $0x802e04
  801dae:	68 c3 00 00 00       	push   $0xc3
  801db3:	68 27 2e 80 00       	push   $0x802e27
  801db8:	e8 af e9 ff ff       	call   80076c <_panic>

00801dbd <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801dbd:	55                   	push   %ebp
  801dbe:	89 e5                	mov    %esp,%ebp
  801dc0:	57                   	push   %edi
  801dc1:	56                   	push   %esi
  801dc2:	53                   	push   %ebx
  801dc3:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801dc6:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dcc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801dcf:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801dd2:	8b 7d 18             	mov    0x18(%ebp),%edi
  801dd5:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801dd8:	cd 30                	int    $0x30
  801dda:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801ddd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801de0:	83 c4 10             	add    $0x10,%esp
  801de3:	5b                   	pop    %ebx
  801de4:	5e                   	pop    %esi
  801de5:	5f                   	pop    %edi
  801de6:	5d                   	pop    %ebp
  801de7:	c3                   	ret    

00801de8 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801de8:	55                   	push   %ebp
  801de9:	89 e5                	mov    %esp,%ebp
  801deb:	83 ec 04             	sub    $0x4,%esp
  801dee:	8b 45 10             	mov    0x10(%ebp),%eax
  801df1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801df4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801df8:	8b 45 08             	mov    0x8(%ebp),%eax
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 00                	push   $0x0
  801dff:	52                   	push   %edx
  801e00:	ff 75 0c             	pushl  0xc(%ebp)
  801e03:	50                   	push   %eax
  801e04:	6a 00                	push   $0x0
  801e06:	e8 b2 ff ff ff       	call   801dbd <syscall>
  801e0b:	83 c4 18             	add    $0x18,%esp
}
  801e0e:	90                   	nop
  801e0f:	c9                   	leave  
  801e10:	c3                   	ret    

00801e11 <sys_cgetc>:

int
sys_cgetc(void)
{
  801e11:	55                   	push   %ebp
  801e12:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801e14:	6a 00                	push   $0x0
  801e16:	6a 00                	push   $0x0
  801e18:	6a 00                	push   $0x0
  801e1a:	6a 00                	push   $0x0
  801e1c:	6a 00                	push   $0x0
  801e1e:	6a 01                	push   $0x1
  801e20:	e8 98 ff ff ff       	call   801dbd <syscall>
  801e25:	83 c4 18             	add    $0x18,%esp
}
  801e28:	c9                   	leave  
  801e29:	c3                   	ret    

00801e2a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801e2a:	55                   	push   %ebp
  801e2b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801e2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	6a 00                	push   $0x0
  801e38:	50                   	push   %eax
  801e39:	6a 05                	push   $0x5
  801e3b:	e8 7d ff ff ff       	call   801dbd <syscall>
  801e40:	83 c4 18             	add    $0x18,%esp
}
  801e43:	c9                   	leave  
  801e44:	c3                   	ret    

00801e45 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801e45:	55                   	push   %ebp
  801e46:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801e48:	6a 00                	push   $0x0
  801e4a:	6a 00                	push   $0x0
  801e4c:	6a 00                	push   $0x0
  801e4e:	6a 00                	push   $0x0
  801e50:	6a 00                	push   $0x0
  801e52:	6a 02                	push   $0x2
  801e54:	e8 64 ff ff ff       	call   801dbd <syscall>
  801e59:	83 c4 18             	add    $0x18,%esp
}
  801e5c:	c9                   	leave  
  801e5d:	c3                   	ret    

00801e5e <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801e5e:	55                   	push   %ebp
  801e5f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801e61:	6a 00                	push   $0x0
  801e63:	6a 00                	push   $0x0
  801e65:	6a 00                	push   $0x0
  801e67:	6a 00                	push   $0x0
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 03                	push   $0x3
  801e6d:	e8 4b ff ff ff       	call   801dbd <syscall>
  801e72:	83 c4 18             	add    $0x18,%esp
}
  801e75:	c9                   	leave  
  801e76:	c3                   	ret    

00801e77 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e77:	55                   	push   %ebp
  801e78:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 00                	push   $0x0
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 00                	push   $0x0
  801e82:	6a 00                	push   $0x0
  801e84:	6a 04                	push   $0x4
  801e86:	e8 32 ff ff ff       	call   801dbd <syscall>
  801e8b:	83 c4 18             	add    $0x18,%esp
}
  801e8e:	c9                   	leave  
  801e8f:	c3                   	ret    

00801e90 <sys_env_exit>:


void sys_env_exit(void)
{
  801e90:	55                   	push   %ebp
  801e91:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801e93:	6a 00                	push   $0x0
  801e95:	6a 00                	push   $0x0
  801e97:	6a 00                	push   $0x0
  801e99:	6a 00                	push   $0x0
  801e9b:	6a 00                	push   $0x0
  801e9d:	6a 06                	push   $0x6
  801e9f:	e8 19 ff ff ff       	call   801dbd <syscall>
  801ea4:	83 c4 18             	add    $0x18,%esp
}
  801ea7:	90                   	nop
  801ea8:	c9                   	leave  
  801ea9:	c3                   	ret    

00801eaa <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801eaa:	55                   	push   %ebp
  801eab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801ead:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eb0:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb3:	6a 00                	push   $0x0
  801eb5:	6a 00                	push   $0x0
  801eb7:	6a 00                	push   $0x0
  801eb9:	52                   	push   %edx
  801eba:	50                   	push   %eax
  801ebb:	6a 07                	push   $0x7
  801ebd:	e8 fb fe ff ff       	call   801dbd <syscall>
  801ec2:	83 c4 18             	add    $0x18,%esp
}
  801ec5:	c9                   	leave  
  801ec6:	c3                   	ret    

00801ec7 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801ec7:	55                   	push   %ebp
  801ec8:	89 e5                	mov    %esp,%ebp
  801eca:	56                   	push   %esi
  801ecb:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801ecc:	8b 75 18             	mov    0x18(%ebp),%esi
  801ecf:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ed2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ed5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  801edb:	56                   	push   %esi
  801edc:	53                   	push   %ebx
  801edd:	51                   	push   %ecx
  801ede:	52                   	push   %edx
  801edf:	50                   	push   %eax
  801ee0:	6a 08                	push   $0x8
  801ee2:	e8 d6 fe ff ff       	call   801dbd <syscall>
  801ee7:	83 c4 18             	add    $0x18,%esp
}
  801eea:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801eed:	5b                   	pop    %ebx
  801eee:	5e                   	pop    %esi
  801eef:	5d                   	pop    %ebp
  801ef0:	c3                   	ret    

00801ef1 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801ef1:	55                   	push   %ebp
  801ef2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801ef4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  801efa:	6a 00                	push   $0x0
  801efc:	6a 00                	push   $0x0
  801efe:	6a 00                	push   $0x0
  801f00:	52                   	push   %edx
  801f01:	50                   	push   %eax
  801f02:	6a 09                	push   $0x9
  801f04:	e8 b4 fe ff ff       	call   801dbd <syscall>
  801f09:	83 c4 18             	add    $0x18,%esp
}
  801f0c:	c9                   	leave  
  801f0d:	c3                   	ret    

00801f0e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801f0e:	55                   	push   %ebp
  801f0f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801f11:	6a 00                	push   $0x0
  801f13:	6a 00                	push   $0x0
  801f15:	6a 00                	push   $0x0
  801f17:	ff 75 0c             	pushl  0xc(%ebp)
  801f1a:	ff 75 08             	pushl  0x8(%ebp)
  801f1d:	6a 0a                	push   $0xa
  801f1f:	e8 99 fe ff ff       	call   801dbd <syscall>
  801f24:	83 c4 18             	add    $0x18,%esp
}
  801f27:	c9                   	leave  
  801f28:	c3                   	ret    

00801f29 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801f29:	55                   	push   %ebp
  801f2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801f2c:	6a 00                	push   $0x0
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 0b                	push   $0xb
  801f38:	e8 80 fe ff ff       	call   801dbd <syscall>
  801f3d:	83 c4 18             	add    $0x18,%esp
}
  801f40:	c9                   	leave  
  801f41:	c3                   	ret    

00801f42 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801f42:	55                   	push   %ebp
  801f43:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801f45:	6a 00                	push   $0x0
  801f47:	6a 00                	push   $0x0
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 0c                	push   $0xc
  801f51:	e8 67 fe ff ff       	call   801dbd <syscall>
  801f56:	83 c4 18             	add    $0x18,%esp
}
  801f59:	c9                   	leave  
  801f5a:	c3                   	ret    

00801f5b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801f5b:	55                   	push   %ebp
  801f5c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801f5e:	6a 00                	push   $0x0
  801f60:	6a 00                	push   $0x0
  801f62:	6a 00                	push   $0x0
  801f64:	6a 00                	push   $0x0
  801f66:	6a 00                	push   $0x0
  801f68:	6a 0d                	push   $0xd
  801f6a:	e8 4e fe ff ff       	call   801dbd <syscall>
  801f6f:	83 c4 18             	add    $0x18,%esp
}
  801f72:	c9                   	leave  
  801f73:	c3                   	ret    

00801f74 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801f74:	55                   	push   %ebp
  801f75:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801f77:	6a 00                	push   $0x0
  801f79:	6a 00                	push   $0x0
  801f7b:	6a 00                	push   $0x0
  801f7d:	ff 75 0c             	pushl  0xc(%ebp)
  801f80:	ff 75 08             	pushl  0x8(%ebp)
  801f83:	6a 11                	push   $0x11
  801f85:	e8 33 fe ff ff       	call   801dbd <syscall>
  801f8a:	83 c4 18             	add    $0x18,%esp
	return;
  801f8d:	90                   	nop
}
  801f8e:	c9                   	leave  
  801f8f:	c3                   	ret    

00801f90 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801f90:	55                   	push   %ebp
  801f91:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801f93:	6a 00                	push   $0x0
  801f95:	6a 00                	push   $0x0
  801f97:	6a 00                	push   $0x0
  801f99:	ff 75 0c             	pushl  0xc(%ebp)
  801f9c:	ff 75 08             	pushl  0x8(%ebp)
  801f9f:	6a 12                	push   $0x12
  801fa1:	e8 17 fe ff ff       	call   801dbd <syscall>
  801fa6:	83 c4 18             	add    $0x18,%esp
	return ;
  801fa9:	90                   	nop
}
  801faa:	c9                   	leave  
  801fab:	c3                   	ret    

00801fac <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801fac:	55                   	push   %ebp
  801fad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801faf:	6a 00                	push   $0x0
  801fb1:	6a 00                	push   $0x0
  801fb3:	6a 00                	push   $0x0
  801fb5:	6a 00                	push   $0x0
  801fb7:	6a 00                	push   $0x0
  801fb9:	6a 0e                	push   $0xe
  801fbb:	e8 fd fd ff ff       	call   801dbd <syscall>
  801fc0:	83 c4 18             	add    $0x18,%esp
}
  801fc3:	c9                   	leave  
  801fc4:	c3                   	ret    

00801fc5 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801fc5:	55                   	push   %ebp
  801fc6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801fc8:	6a 00                	push   $0x0
  801fca:	6a 00                	push   $0x0
  801fcc:	6a 00                	push   $0x0
  801fce:	6a 00                	push   $0x0
  801fd0:	ff 75 08             	pushl  0x8(%ebp)
  801fd3:	6a 0f                	push   $0xf
  801fd5:	e8 e3 fd ff ff       	call   801dbd <syscall>
  801fda:	83 c4 18             	add    $0x18,%esp
}
  801fdd:	c9                   	leave  
  801fde:	c3                   	ret    

00801fdf <sys_scarce_memory>:

void sys_scarce_memory()
{
  801fdf:	55                   	push   %ebp
  801fe0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801fe2:	6a 00                	push   $0x0
  801fe4:	6a 00                	push   $0x0
  801fe6:	6a 00                	push   $0x0
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 00                	push   $0x0
  801fec:	6a 10                	push   $0x10
  801fee:	e8 ca fd ff ff       	call   801dbd <syscall>
  801ff3:	83 c4 18             	add    $0x18,%esp
}
  801ff6:	90                   	nop
  801ff7:	c9                   	leave  
  801ff8:	c3                   	ret    

00801ff9 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801ff9:	55                   	push   %ebp
  801ffa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801ffc:	6a 00                	push   $0x0
  801ffe:	6a 00                	push   $0x0
  802000:	6a 00                	push   $0x0
  802002:	6a 00                	push   $0x0
  802004:	6a 00                	push   $0x0
  802006:	6a 14                	push   $0x14
  802008:	e8 b0 fd ff ff       	call   801dbd <syscall>
  80200d:	83 c4 18             	add    $0x18,%esp
}
  802010:	90                   	nop
  802011:	c9                   	leave  
  802012:	c3                   	ret    

00802013 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802013:	55                   	push   %ebp
  802014:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802016:	6a 00                	push   $0x0
  802018:	6a 00                	push   $0x0
  80201a:	6a 00                	push   $0x0
  80201c:	6a 00                	push   $0x0
  80201e:	6a 00                	push   $0x0
  802020:	6a 15                	push   $0x15
  802022:	e8 96 fd ff ff       	call   801dbd <syscall>
  802027:	83 c4 18             	add    $0x18,%esp
}
  80202a:	90                   	nop
  80202b:	c9                   	leave  
  80202c:	c3                   	ret    

0080202d <sys_cputc>:


void
sys_cputc(const char c)
{
  80202d:	55                   	push   %ebp
  80202e:	89 e5                	mov    %esp,%ebp
  802030:	83 ec 04             	sub    $0x4,%esp
  802033:	8b 45 08             	mov    0x8(%ebp),%eax
  802036:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802039:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80203d:	6a 00                	push   $0x0
  80203f:	6a 00                	push   $0x0
  802041:	6a 00                	push   $0x0
  802043:	6a 00                	push   $0x0
  802045:	50                   	push   %eax
  802046:	6a 16                	push   $0x16
  802048:	e8 70 fd ff ff       	call   801dbd <syscall>
  80204d:	83 c4 18             	add    $0x18,%esp
}
  802050:	90                   	nop
  802051:	c9                   	leave  
  802052:	c3                   	ret    

00802053 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802053:	55                   	push   %ebp
  802054:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802056:	6a 00                	push   $0x0
  802058:	6a 00                	push   $0x0
  80205a:	6a 00                	push   $0x0
  80205c:	6a 00                	push   $0x0
  80205e:	6a 00                	push   $0x0
  802060:	6a 17                	push   $0x17
  802062:	e8 56 fd ff ff       	call   801dbd <syscall>
  802067:	83 c4 18             	add    $0x18,%esp
}
  80206a:	90                   	nop
  80206b:	c9                   	leave  
  80206c:	c3                   	ret    

0080206d <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80206d:	55                   	push   %ebp
  80206e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802070:	8b 45 08             	mov    0x8(%ebp),%eax
  802073:	6a 00                	push   $0x0
  802075:	6a 00                	push   $0x0
  802077:	6a 00                	push   $0x0
  802079:	ff 75 0c             	pushl  0xc(%ebp)
  80207c:	50                   	push   %eax
  80207d:	6a 18                	push   $0x18
  80207f:	e8 39 fd ff ff       	call   801dbd <syscall>
  802084:	83 c4 18             	add    $0x18,%esp
}
  802087:	c9                   	leave  
  802088:	c3                   	ret    

00802089 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802089:	55                   	push   %ebp
  80208a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80208c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80208f:	8b 45 08             	mov    0x8(%ebp),%eax
  802092:	6a 00                	push   $0x0
  802094:	6a 00                	push   $0x0
  802096:	6a 00                	push   $0x0
  802098:	52                   	push   %edx
  802099:	50                   	push   %eax
  80209a:	6a 1b                	push   $0x1b
  80209c:	e8 1c fd ff ff       	call   801dbd <syscall>
  8020a1:	83 c4 18             	add    $0x18,%esp
}
  8020a4:	c9                   	leave  
  8020a5:	c3                   	ret    

008020a6 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8020a6:	55                   	push   %ebp
  8020a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8020af:	6a 00                	push   $0x0
  8020b1:	6a 00                	push   $0x0
  8020b3:	6a 00                	push   $0x0
  8020b5:	52                   	push   %edx
  8020b6:	50                   	push   %eax
  8020b7:	6a 19                	push   $0x19
  8020b9:	e8 ff fc ff ff       	call   801dbd <syscall>
  8020be:	83 c4 18             	add    $0x18,%esp
}
  8020c1:	90                   	nop
  8020c2:	c9                   	leave  
  8020c3:	c3                   	ret    

008020c4 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8020c4:	55                   	push   %ebp
  8020c5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8020cd:	6a 00                	push   $0x0
  8020cf:	6a 00                	push   $0x0
  8020d1:	6a 00                	push   $0x0
  8020d3:	52                   	push   %edx
  8020d4:	50                   	push   %eax
  8020d5:	6a 1a                	push   $0x1a
  8020d7:	e8 e1 fc ff ff       	call   801dbd <syscall>
  8020dc:	83 c4 18             	add    $0x18,%esp
}
  8020df:	90                   	nop
  8020e0:	c9                   	leave  
  8020e1:	c3                   	ret    

008020e2 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8020e2:	55                   	push   %ebp
  8020e3:	89 e5                	mov    %esp,%ebp
  8020e5:	83 ec 04             	sub    $0x4,%esp
  8020e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8020eb:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8020ee:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8020f1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8020f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f8:	6a 00                	push   $0x0
  8020fa:	51                   	push   %ecx
  8020fb:	52                   	push   %edx
  8020fc:	ff 75 0c             	pushl  0xc(%ebp)
  8020ff:	50                   	push   %eax
  802100:	6a 1c                	push   $0x1c
  802102:	e8 b6 fc ff ff       	call   801dbd <syscall>
  802107:	83 c4 18             	add    $0x18,%esp
}
  80210a:	c9                   	leave  
  80210b:	c3                   	ret    

0080210c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80210c:	55                   	push   %ebp
  80210d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80210f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802112:	8b 45 08             	mov    0x8(%ebp),%eax
  802115:	6a 00                	push   $0x0
  802117:	6a 00                	push   $0x0
  802119:	6a 00                	push   $0x0
  80211b:	52                   	push   %edx
  80211c:	50                   	push   %eax
  80211d:	6a 1d                	push   $0x1d
  80211f:	e8 99 fc ff ff       	call   801dbd <syscall>
  802124:	83 c4 18             	add    $0x18,%esp
}
  802127:	c9                   	leave  
  802128:	c3                   	ret    

00802129 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802129:	55                   	push   %ebp
  80212a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80212c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80212f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802132:	8b 45 08             	mov    0x8(%ebp),%eax
  802135:	6a 00                	push   $0x0
  802137:	6a 00                	push   $0x0
  802139:	51                   	push   %ecx
  80213a:	52                   	push   %edx
  80213b:	50                   	push   %eax
  80213c:	6a 1e                	push   $0x1e
  80213e:	e8 7a fc ff ff       	call   801dbd <syscall>
  802143:	83 c4 18             	add    $0x18,%esp
}
  802146:	c9                   	leave  
  802147:	c3                   	ret    

00802148 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802148:	55                   	push   %ebp
  802149:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80214b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80214e:	8b 45 08             	mov    0x8(%ebp),%eax
  802151:	6a 00                	push   $0x0
  802153:	6a 00                	push   $0x0
  802155:	6a 00                	push   $0x0
  802157:	52                   	push   %edx
  802158:	50                   	push   %eax
  802159:	6a 1f                	push   $0x1f
  80215b:	e8 5d fc ff ff       	call   801dbd <syscall>
  802160:	83 c4 18             	add    $0x18,%esp
}
  802163:	c9                   	leave  
  802164:	c3                   	ret    

00802165 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802165:	55                   	push   %ebp
  802166:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802168:	6a 00                	push   $0x0
  80216a:	6a 00                	push   $0x0
  80216c:	6a 00                	push   $0x0
  80216e:	6a 00                	push   $0x0
  802170:	6a 00                	push   $0x0
  802172:	6a 20                	push   $0x20
  802174:	e8 44 fc ff ff       	call   801dbd <syscall>
  802179:	83 c4 18             	add    $0x18,%esp
}
  80217c:	c9                   	leave  
  80217d:	c3                   	ret    

0080217e <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80217e:	55                   	push   %ebp
  80217f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802181:	8b 45 08             	mov    0x8(%ebp),%eax
  802184:	6a 00                	push   $0x0
  802186:	ff 75 14             	pushl  0x14(%ebp)
  802189:	ff 75 10             	pushl  0x10(%ebp)
  80218c:	ff 75 0c             	pushl  0xc(%ebp)
  80218f:	50                   	push   %eax
  802190:	6a 21                	push   $0x21
  802192:	e8 26 fc ff ff       	call   801dbd <syscall>
  802197:	83 c4 18             	add    $0x18,%esp
}
  80219a:	c9                   	leave  
  80219b:	c3                   	ret    

0080219c <sys_run_env>:


void
sys_run_env(int32 envId)
{
  80219c:	55                   	push   %ebp
  80219d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80219f:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a2:	6a 00                	push   $0x0
  8021a4:	6a 00                	push   $0x0
  8021a6:	6a 00                	push   $0x0
  8021a8:	6a 00                	push   $0x0
  8021aa:	50                   	push   %eax
  8021ab:	6a 22                	push   $0x22
  8021ad:	e8 0b fc ff ff       	call   801dbd <syscall>
  8021b2:	83 c4 18             	add    $0x18,%esp
}
  8021b5:	90                   	nop
  8021b6:	c9                   	leave  
  8021b7:	c3                   	ret    

008021b8 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8021b8:	55                   	push   %ebp
  8021b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8021bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8021be:	6a 00                	push   $0x0
  8021c0:	6a 00                	push   $0x0
  8021c2:	6a 00                	push   $0x0
  8021c4:	6a 00                	push   $0x0
  8021c6:	50                   	push   %eax
  8021c7:	6a 23                	push   $0x23
  8021c9:	e8 ef fb ff ff       	call   801dbd <syscall>
  8021ce:	83 c4 18             	add    $0x18,%esp
}
  8021d1:	90                   	nop
  8021d2:	c9                   	leave  
  8021d3:	c3                   	ret    

008021d4 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8021d4:	55                   	push   %ebp
  8021d5:	89 e5                	mov    %esp,%ebp
  8021d7:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8021da:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8021dd:	8d 50 04             	lea    0x4(%eax),%edx
  8021e0:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8021e3:	6a 00                	push   $0x0
  8021e5:	6a 00                	push   $0x0
  8021e7:	6a 00                	push   $0x0
  8021e9:	52                   	push   %edx
  8021ea:	50                   	push   %eax
  8021eb:	6a 24                	push   $0x24
  8021ed:	e8 cb fb ff ff       	call   801dbd <syscall>
  8021f2:	83 c4 18             	add    $0x18,%esp
	return result;
  8021f5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8021f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021fb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8021fe:	89 01                	mov    %eax,(%ecx)
  802200:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802203:	8b 45 08             	mov    0x8(%ebp),%eax
  802206:	c9                   	leave  
  802207:	c2 04 00             	ret    $0x4

0080220a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80220a:	55                   	push   %ebp
  80220b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80220d:	6a 00                	push   $0x0
  80220f:	6a 00                	push   $0x0
  802211:	ff 75 10             	pushl  0x10(%ebp)
  802214:	ff 75 0c             	pushl  0xc(%ebp)
  802217:	ff 75 08             	pushl  0x8(%ebp)
  80221a:	6a 13                	push   $0x13
  80221c:	e8 9c fb ff ff       	call   801dbd <syscall>
  802221:	83 c4 18             	add    $0x18,%esp
	return ;
  802224:	90                   	nop
}
  802225:	c9                   	leave  
  802226:	c3                   	ret    

00802227 <sys_rcr2>:
uint32 sys_rcr2()
{
  802227:	55                   	push   %ebp
  802228:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80222a:	6a 00                	push   $0x0
  80222c:	6a 00                	push   $0x0
  80222e:	6a 00                	push   $0x0
  802230:	6a 00                	push   $0x0
  802232:	6a 00                	push   $0x0
  802234:	6a 25                	push   $0x25
  802236:	e8 82 fb ff ff       	call   801dbd <syscall>
  80223b:	83 c4 18             	add    $0x18,%esp
}
  80223e:	c9                   	leave  
  80223f:	c3                   	ret    

00802240 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802240:	55                   	push   %ebp
  802241:	89 e5                	mov    %esp,%ebp
  802243:	83 ec 04             	sub    $0x4,%esp
  802246:	8b 45 08             	mov    0x8(%ebp),%eax
  802249:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80224c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802250:	6a 00                	push   $0x0
  802252:	6a 00                	push   $0x0
  802254:	6a 00                	push   $0x0
  802256:	6a 00                	push   $0x0
  802258:	50                   	push   %eax
  802259:	6a 26                	push   $0x26
  80225b:	e8 5d fb ff ff       	call   801dbd <syscall>
  802260:	83 c4 18             	add    $0x18,%esp
	return ;
  802263:	90                   	nop
}
  802264:	c9                   	leave  
  802265:	c3                   	ret    

00802266 <rsttst>:
void rsttst()
{
  802266:	55                   	push   %ebp
  802267:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802269:	6a 00                	push   $0x0
  80226b:	6a 00                	push   $0x0
  80226d:	6a 00                	push   $0x0
  80226f:	6a 00                	push   $0x0
  802271:	6a 00                	push   $0x0
  802273:	6a 28                	push   $0x28
  802275:	e8 43 fb ff ff       	call   801dbd <syscall>
  80227a:	83 c4 18             	add    $0x18,%esp
	return ;
  80227d:	90                   	nop
}
  80227e:	c9                   	leave  
  80227f:	c3                   	ret    

00802280 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802280:	55                   	push   %ebp
  802281:	89 e5                	mov    %esp,%ebp
  802283:	83 ec 04             	sub    $0x4,%esp
  802286:	8b 45 14             	mov    0x14(%ebp),%eax
  802289:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80228c:	8b 55 18             	mov    0x18(%ebp),%edx
  80228f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802293:	52                   	push   %edx
  802294:	50                   	push   %eax
  802295:	ff 75 10             	pushl  0x10(%ebp)
  802298:	ff 75 0c             	pushl  0xc(%ebp)
  80229b:	ff 75 08             	pushl  0x8(%ebp)
  80229e:	6a 27                	push   $0x27
  8022a0:	e8 18 fb ff ff       	call   801dbd <syscall>
  8022a5:	83 c4 18             	add    $0x18,%esp
	return ;
  8022a8:	90                   	nop
}
  8022a9:	c9                   	leave  
  8022aa:	c3                   	ret    

008022ab <chktst>:
void chktst(uint32 n)
{
  8022ab:	55                   	push   %ebp
  8022ac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8022ae:	6a 00                	push   $0x0
  8022b0:	6a 00                	push   $0x0
  8022b2:	6a 00                	push   $0x0
  8022b4:	6a 00                	push   $0x0
  8022b6:	ff 75 08             	pushl  0x8(%ebp)
  8022b9:	6a 29                	push   $0x29
  8022bb:	e8 fd fa ff ff       	call   801dbd <syscall>
  8022c0:	83 c4 18             	add    $0x18,%esp
	return ;
  8022c3:	90                   	nop
}
  8022c4:	c9                   	leave  
  8022c5:	c3                   	ret    

008022c6 <inctst>:

void inctst()
{
  8022c6:	55                   	push   %ebp
  8022c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8022c9:	6a 00                	push   $0x0
  8022cb:	6a 00                	push   $0x0
  8022cd:	6a 00                	push   $0x0
  8022cf:	6a 00                	push   $0x0
  8022d1:	6a 00                	push   $0x0
  8022d3:	6a 2a                	push   $0x2a
  8022d5:	e8 e3 fa ff ff       	call   801dbd <syscall>
  8022da:	83 c4 18             	add    $0x18,%esp
	return ;
  8022dd:	90                   	nop
}
  8022de:	c9                   	leave  
  8022df:	c3                   	ret    

008022e0 <gettst>:
uint32 gettst()
{
  8022e0:	55                   	push   %ebp
  8022e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8022e3:	6a 00                	push   $0x0
  8022e5:	6a 00                	push   $0x0
  8022e7:	6a 00                	push   $0x0
  8022e9:	6a 00                	push   $0x0
  8022eb:	6a 00                	push   $0x0
  8022ed:	6a 2b                	push   $0x2b
  8022ef:	e8 c9 fa ff ff       	call   801dbd <syscall>
  8022f4:	83 c4 18             	add    $0x18,%esp
}
  8022f7:	c9                   	leave  
  8022f8:	c3                   	ret    

008022f9 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8022f9:	55                   	push   %ebp
  8022fa:	89 e5                	mov    %esp,%ebp
  8022fc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022ff:	6a 00                	push   $0x0
  802301:	6a 00                	push   $0x0
  802303:	6a 00                	push   $0x0
  802305:	6a 00                	push   $0x0
  802307:	6a 00                	push   $0x0
  802309:	6a 2c                	push   $0x2c
  80230b:	e8 ad fa ff ff       	call   801dbd <syscall>
  802310:	83 c4 18             	add    $0x18,%esp
  802313:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802316:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80231a:	75 07                	jne    802323 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80231c:	b8 01 00 00 00       	mov    $0x1,%eax
  802321:	eb 05                	jmp    802328 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802323:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802328:	c9                   	leave  
  802329:	c3                   	ret    

0080232a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80232a:	55                   	push   %ebp
  80232b:	89 e5                	mov    %esp,%ebp
  80232d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802330:	6a 00                	push   $0x0
  802332:	6a 00                	push   $0x0
  802334:	6a 00                	push   $0x0
  802336:	6a 00                	push   $0x0
  802338:	6a 00                	push   $0x0
  80233a:	6a 2c                	push   $0x2c
  80233c:	e8 7c fa ff ff       	call   801dbd <syscall>
  802341:	83 c4 18             	add    $0x18,%esp
  802344:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802347:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80234b:	75 07                	jne    802354 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80234d:	b8 01 00 00 00       	mov    $0x1,%eax
  802352:	eb 05                	jmp    802359 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802354:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802359:	c9                   	leave  
  80235a:	c3                   	ret    

0080235b <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80235b:	55                   	push   %ebp
  80235c:	89 e5                	mov    %esp,%ebp
  80235e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802361:	6a 00                	push   $0x0
  802363:	6a 00                	push   $0x0
  802365:	6a 00                	push   $0x0
  802367:	6a 00                	push   $0x0
  802369:	6a 00                	push   $0x0
  80236b:	6a 2c                	push   $0x2c
  80236d:	e8 4b fa ff ff       	call   801dbd <syscall>
  802372:	83 c4 18             	add    $0x18,%esp
  802375:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802378:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80237c:	75 07                	jne    802385 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80237e:	b8 01 00 00 00       	mov    $0x1,%eax
  802383:	eb 05                	jmp    80238a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802385:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80238a:	c9                   	leave  
  80238b:	c3                   	ret    

0080238c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80238c:	55                   	push   %ebp
  80238d:	89 e5                	mov    %esp,%ebp
  80238f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802392:	6a 00                	push   $0x0
  802394:	6a 00                	push   $0x0
  802396:	6a 00                	push   $0x0
  802398:	6a 00                	push   $0x0
  80239a:	6a 00                	push   $0x0
  80239c:	6a 2c                	push   $0x2c
  80239e:	e8 1a fa ff ff       	call   801dbd <syscall>
  8023a3:	83 c4 18             	add    $0x18,%esp
  8023a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8023a9:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8023ad:	75 07                	jne    8023b6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8023af:	b8 01 00 00 00       	mov    $0x1,%eax
  8023b4:	eb 05                	jmp    8023bb <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8023b6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023bb:	c9                   	leave  
  8023bc:	c3                   	ret    

008023bd <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8023bd:	55                   	push   %ebp
  8023be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8023c0:	6a 00                	push   $0x0
  8023c2:	6a 00                	push   $0x0
  8023c4:	6a 00                	push   $0x0
  8023c6:	6a 00                	push   $0x0
  8023c8:	ff 75 08             	pushl  0x8(%ebp)
  8023cb:	6a 2d                	push   $0x2d
  8023cd:	e8 eb f9 ff ff       	call   801dbd <syscall>
  8023d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8023d5:	90                   	nop
}
  8023d6:	c9                   	leave  
  8023d7:	c3                   	ret    

008023d8 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8023d8:	55                   	push   %ebp
  8023d9:	89 e5                	mov    %esp,%ebp
  8023db:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8023dc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8023df:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8023e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8023e8:	6a 00                	push   $0x0
  8023ea:	53                   	push   %ebx
  8023eb:	51                   	push   %ecx
  8023ec:	52                   	push   %edx
  8023ed:	50                   	push   %eax
  8023ee:	6a 2e                	push   $0x2e
  8023f0:	e8 c8 f9 ff ff       	call   801dbd <syscall>
  8023f5:	83 c4 18             	add    $0x18,%esp
}
  8023f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8023fb:	c9                   	leave  
  8023fc:	c3                   	ret    

008023fd <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8023fd:	55                   	push   %ebp
  8023fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802400:	8b 55 0c             	mov    0xc(%ebp),%edx
  802403:	8b 45 08             	mov    0x8(%ebp),%eax
  802406:	6a 00                	push   $0x0
  802408:	6a 00                	push   $0x0
  80240a:	6a 00                	push   $0x0
  80240c:	52                   	push   %edx
  80240d:	50                   	push   %eax
  80240e:	6a 2f                	push   $0x2f
  802410:	e8 a8 f9 ff ff       	call   801dbd <syscall>
  802415:	83 c4 18             	add    $0x18,%esp
}
  802418:	c9                   	leave  
  802419:	c3                   	ret    

0080241a <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  80241a:	55                   	push   %ebp
  80241b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80241d:	6a 00                	push   $0x0
  80241f:	6a 00                	push   $0x0
  802421:	6a 00                	push   $0x0
  802423:	ff 75 0c             	pushl  0xc(%ebp)
  802426:	ff 75 08             	pushl  0x8(%ebp)
  802429:	6a 30                	push   $0x30
  80242b:	e8 8d f9 ff ff       	call   801dbd <syscall>
  802430:	83 c4 18             	add    $0x18,%esp
	return ;
  802433:	90                   	nop
}
  802434:	c9                   	leave  
  802435:	c3                   	ret    
  802436:	66 90                	xchg   %ax,%ax

00802438 <__udivdi3>:
  802438:	55                   	push   %ebp
  802439:	57                   	push   %edi
  80243a:	56                   	push   %esi
  80243b:	53                   	push   %ebx
  80243c:	83 ec 1c             	sub    $0x1c,%esp
  80243f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802443:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802447:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80244b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80244f:	89 ca                	mov    %ecx,%edx
  802451:	89 f8                	mov    %edi,%eax
  802453:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802457:	85 f6                	test   %esi,%esi
  802459:	75 2d                	jne    802488 <__udivdi3+0x50>
  80245b:	39 cf                	cmp    %ecx,%edi
  80245d:	77 65                	ja     8024c4 <__udivdi3+0x8c>
  80245f:	89 fd                	mov    %edi,%ebp
  802461:	85 ff                	test   %edi,%edi
  802463:	75 0b                	jne    802470 <__udivdi3+0x38>
  802465:	b8 01 00 00 00       	mov    $0x1,%eax
  80246a:	31 d2                	xor    %edx,%edx
  80246c:	f7 f7                	div    %edi
  80246e:	89 c5                	mov    %eax,%ebp
  802470:	31 d2                	xor    %edx,%edx
  802472:	89 c8                	mov    %ecx,%eax
  802474:	f7 f5                	div    %ebp
  802476:	89 c1                	mov    %eax,%ecx
  802478:	89 d8                	mov    %ebx,%eax
  80247a:	f7 f5                	div    %ebp
  80247c:	89 cf                	mov    %ecx,%edi
  80247e:	89 fa                	mov    %edi,%edx
  802480:	83 c4 1c             	add    $0x1c,%esp
  802483:	5b                   	pop    %ebx
  802484:	5e                   	pop    %esi
  802485:	5f                   	pop    %edi
  802486:	5d                   	pop    %ebp
  802487:	c3                   	ret    
  802488:	39 ce                	cmp    %ecx,%esi
  80248a:	77 28                	ja     8024b4 <__udivdi3+0x7c>
  80248c:	0f bd fe             	bsr    %esi,%edi
  80248f:	83 f7 1f             	xor    $0x1f,%edi
  802492:	75 40                	jne    8024d4 <__udivdi3+0x9c>
  802494:	39 ce                	cmp    %ecx,%esi
  802496:	72 0a                	jb     8024a2 <__udivdi3+0x6a>
  802498:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80249c:	0f 87 9e 00 00 00    	ja     802540 <__udivdi3+0x108>
  8024a2:	b8 01 00 00 00       	mov    $0x1,%eax
  8024a7:	89 fa                	mov    %edi,%edx
  8024a9:	83 c4 1c             	add    $0x1c,%esp
  8024ac:	5b                   	pop    %ebx
  8024ad:	5e                   	pop    %esi
  8024ae:	5f                   	pop    %edi
  8024af:	5d                   	pop    %ebp
  8024b0:	c3                   	ret    
  8024b1:	8d 76 00             	lea    0x0(%esi),%esi
  8024b4:	31 ff                	xor    %edi,%edi
  8024b6:	31 c0                	xor    %eax,%eax
  8024b8:	89 fa                	mov    %edi,%edx
  8024ba:	83 c4 1c             	add    $0x1c,%esp
  8024bd:	5b                   	pop    %ebx
  8024be:	5e                   	pop    %esi
  8024bf:	5f                   	pop    %edi
  8024c0:	5d                   	pop    %ebp
  8024c1:	c3                   	ret    
  8024c2:	66 90                	xchg   %ax,%ax
  8024c4:	89 d8                	mov    %ebx,%eax
  8024c6:	f7 f7                	div    %edi
  8024c8:	31 ff                	xor    %edi,%edi
  8024ca:	89 fa                	mov    %edi,%edx
  8024cc:	83 c4 1c             	add    $0x1c,%esp
  8024cf:	5b                   	pop    %ebx
  8024d0:	5e                   	pop    %esi
  8024d1:	5f                   	pop    %edi
  8024d2:	5d                   	pop    %ebp
  8024d3:	c3                   	ret    
  8024d4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8024d9:	89 eb                	mov    %ebp,%ebx
  8024db:	29 fb                	sub    %edi,%ebx
  8024dd:	89 f9                	mov    %edi,%ecx
  8024df:	d3 e6                	shl    %cl,%esi
  8024e1:	89 c5                	mov    %eax,%ebp
  8024e3:	88 d9                	mov    %bl,%cl
  8024e5:	d3 ed                	shr    %cl,%ebp
  8024e7:	89 e9                	mov    %ebp,%ecx
  8024e9:	09 f1                	or     %esi,%ecx
  8024eb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8024ef:	89 f9                	mov    %edi,%ecx
  8024f1:	d3 e0                	shl    %cl,%eax
  8024f3:	89 c5                	mov    %eax,%ebp
  8024f5:	89 d6                	mov    %edx,%esi
  8024f7:	88 d9                	mov    %bl,%cl
  8024f9:	d3 ee                	shr    %cl,%esi
  8024fb:	89 f9                	mov    %edi,%ecx
  8024fd:	d3 e2                	shl    %cl,%edx
  8024ff:	8b 44 24 08          	mov    0x8(%esp),%eax
  802503:	88 d9                	mov    %bl,%cl
  802505:	d3 e8                	shr    %cl,%eax
  802507:	09 c2                	or     %eax,%edx
  802509:	89 d0                	mov    %edx,%eax
  80250b:	89 f2                	mov    %esi,%edx
  80250d:	f7 74 24 0c          	divl   0xc(%esp)
  802511:	89 d6                	mov    %edx,%esi
  802513:	89 c3                	mov    %eax,%ebx
  802515:	f7 e5                	mul    %ebp
  802517:	39 d6                	cmp    %edx,%esi
  802519:	72 19                	jb     802534 <__udivdi3+0xfc>
  80251b:	74 0b                	je     802528 <__udivdi3+0xf0>
  80251d:	89 d8                	mov    %ebx,%eax
  80251f:	31 ff                	xor    %edi,%edi
  802521:	e9 58 ff ff ff       	jmp    80247e <__udivdi3+0x46>
  802526:	66 90                	xchg   %ax,%ax
  802528:	8b 54 24 08          	mov    0x8(%esp),%edx
  80252c:	89 f9                	mov    %edi,%ecx
  80252e:	d3 e2                	shl    %cl,%edx
  802530:	39 c2                	cmp    %eax,%edx
  802532:	73 e9                	jae    80251d <__udivdi3+0xe5>
  802534:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802537:	31 ff                	xor    %edi,%edi
  802539:	e9 40 ff ff ff       	jmp    80247e <__udivdi3+0x46>
  80253e:	66 90                	xchg   %ax,%ax
  802540:	31 c0                	xor    %eax,%eax
  802542:	e9 37 ff ff ff       	jmp    80247e <__udivdi3+0x46>
  802547:	90                   	nop

00802548 <__umoddi3>:
  802548:	55                   	push   %ebp
  802549:	57                   	push   %edi
  80254a:	56                   	push   %esi
  80254b:	53                   	push   %ebx
  80254c:	83 ec 1c             	sub    $0x1c,%esp
  80254f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802553:	8b 74 24 34          	mov    0x34(%esp),%esi
  802557:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80255b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80255f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802563:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802567:	89 f3                	mov    %esi,%ebx
  802569:	89 fa                	mov    %edi,%edx
  80256b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80256f:	89 34 24             	mov    %esi,(%esp)
  802572:	85 c0                	test   %eax,%eax
  802574:	75 1a                	jne    802590 <__umoddi3+0x48>
  802576:	39 f7                	cmp    %esi,%edi
  802578:	0f 86 a2 00 00 00    	jbe    802620 <__umoddi3+0xd8>
  80257e:	89 c8                	mov    %ecx,%eax
  802580:	89 f2                	mov    %esi,%edx
  802582:	f7 f7                	div    %edi
  802584:	89 d0                	mov    %edx,%eax
  802586:	31 d2                	xor    %edx,%edx
  802588:	83 c4 1c             	add    $0x1c,%esp
  80258b:	5b                   	pop    %ebx
  80258c:	5e                   	pop    %esi
  80258d:	5f                   	pop    %edi
  80258e:	5d                   	pop    %ebp
  80258f:	c3                   	ret    
  802590:	39 f0                	cmp    %esi,%eax
  802592:	0f 87 ac 00 00 00    	ja     802644 <__umoddi3+0xfc>
  802598:	0f bd e8             	bsr    %eax,%ebp
  80259b:	83 f5 1f             	xor    $0x1f,%ebp
  80259e:	0f 84 ac 00 00 00    	je     802650 <__umoddi3+0x108>
  8025a4:	bf 20 00 00 00       	mov    $0x20,%edi
  8025a9:	29 ef                	sub    %ebp,%edi
  8025ab:	89 fe                	mov    %edi,%esi
  8025ad:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8025b1:	89 e9                	mov    %ebp,%ecx
  8025b3:	d3 e0                	shl    %cl,%eax
  8025b5:	89 d7                	mov    %edx,%edi
  8025b7:	89 f1                	mov    %esi,%ecx
  8025b9:	d3 ef                	shr    %cl,%edi
  8025bb:	09 c7                	or     %eax,%edi
  8025bd:	89 e9                	mov    %ebp,%ecx
  8025bf:	d3 e2                	shl    %cl,%edx
  8025c1:	89 14 24             	mov    %edx,(%esp)
  8025c4:	89 d8                	mov    %ebx,%eax
  8025c6:	d3 e0                	shl    %cl,%eax
  8025c8:	89 c2                	mov    %eax,%edx
  8025ca:	8b 44 24 08          	mov    0x8(%esp),%eax
  8025ce:	d3 e0                	shl    %cl,%eax
  8025d0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8025d4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8025d8:	89 f1                	mov    %esi,%ecx
  8025da:	d3 e8                	shr    %cl,%eax
  8025dc:	09 d0                	or     %edx,%eax
  8025de:	d3 eb                	shr    %cl,%ebx
  8025e0:	89 da                	mov    %ebx,%edx
  8025e2:	f7 f7                	div    %edi
  8025e4:	89 d3                	mov    %edx,%ebx
  8025e6:	f7 24 24             	mull   (%esp)
  8025e9:	89 c6                	mov    %eax,%esi
  8025eb:	89 d1                	mov    %edx,%ecx
  8025ed:	39 d3                	cmp    %edx,%ebx
  8025ef:	0f 82 87 00 00 00    	jb     80267c <__umoddi3+0x134>
  8025f5:	0f 84 91 00 00 00    	je     80268c <__umoddi3+0x144>
  8025fb:	8b 54 24 04          	mov    0x4(%esp),%edx
  8025ff:	29 f2                	sub    %esi,%edx
  802601:	19 cb                	sbb    %ecx,%ebx
  802603:	89 d8                	mov    %ebx,%eax
  802605:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802609:	d3 e0                	shl    %cl,%eax
  80260b:	89 e9                	mov    %ebp,%ecx
  80260d:	d3 ea                	shr    %cl,%edx
  80260f:	09 d0                	or     %edx,%eax
  802611:	89 e9                	mov    %ebp,%ecx
  802613:	d3 eb                	shr    %cl,%ebx
  802615:	89 da                	mov    %ebx,%edx
  802617:	83 c4 1c             	add    $0x1c,%esp
  80261a:	5b                   	pop    %ebx
  80261b:	5e                   	pop    %esi
  80261c:	5f                   	pop    %edi
  80261d:	5d                   	pop    %ebp
  80261e:	c3                   	ret    
  80261f:	90                   	nop
  802620:	89 fd                	mov    %edi,%ebp
  802622:	85 ff                	test   %edi,%edi
  802624:	75 0b                	jne    802631 <__umoddi3+0xe9>
  802626:	b8 01 00 00 00       	mov    $0x1,%eax
  80262b:	31 d2                	xor    %edx,%edx
  80262d:	f7 f7                	div    %edi
  80262f:	89 c5                	mov    %eax,%ebp
  802631:	89 f0                	mov    %esi,%eax
  802633:	31 d2                	xor    %edx,%edx
  802635:	f7 f5                	div    %ebp
  802637:	89 c8                	mov    %ecx,%eax
  802639:	f7 f5                	div    %ebp
  80263b:	89 d0                	mov    %edx,%eax
  80263d:	e9 44 ff ff ff       	jmp    802586 <__umoddi3+0x3e>
  802642:	66 90                	xchg   %ax,%ax
  802644:	89 c8                	mov    %ecx,%eax
  802646:	89 f2                	mov    %esi,%edx
  802648:	83 c4 1c             	add    $0x1c,%esp
  80264b:	5b                   	pop    %ebx
  80264c:	5e                   	pop    %esi
  80264d:	5f                   	pop    %edi
  80264e:	5d                   	pop    %ebp
  80264f:	c3                   	ret    
  802650:	3b 04 24             	cmp    (%esp),%eax
  802653:	72 06                	jb     80265b <__umoddi3+0x113>
  802655:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802659:	77 0f                	ja     80266a <__umoddi3+0x122>
  80265b:	89 f2                	mov    %esi,%edx
  80265d:	29 f9                	sub    %edi,%ecx
  80265f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802663:	89 14 24             	mov    %edx,(%esp)
  802666:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80266a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80266e:	8b 14 24             	mov    (%esp),%edx
  802671:	83 c4 1c             	add    $0x1c,%esp
  802674:	5b                   	pop    %ebx
  802675:	5e                   	pop    %esi
  802676:	5f                   	pop    %edi
  802677:	5d                   	pop    %ebp
  802678:	c3                   	ret    
  802679:	8d 76 00             	lea    0x0(%esi),%esi
  80267c:	2b 04 24             	sub    (%esp),%eax
  80267f:	19 fa                	sbb    %edi,%edx
  802681:	89 d1                	mov    %edx,%ecx
  802683:	89 c6                	mov    %eax,%esi
  802685:	e9 71 ff ff ff       	jmp    8025fb <__umoddi3+0xb3>
  80268a:	66 90                	xchg   %ax,%ax
  80268c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802690:	72 ea                	jb     80267c <__umoddi3+0x134>
  802692:	89 d9                	mov    %ebx,%ecx
  802694:	e9 62 ff ff ff       	jmp    8025fb <__umoddi3+0xb3>
