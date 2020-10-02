
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
  800041:	e8 96 1c 00 00       	call   801cdc <sys_disable_interrupt>
		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 80 23 80 00       	push   $0x802380
  80004e:	e8 cd 09 00 00       	call   800a20 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 82 23 80 00       	push   $0x802382
  80005e:	e8 bd 09 00 00       	call   800a20 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!   QUICK SORT    !!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 9b 23 80 00       	push   $0x80239b
  80006e:	e8 ad 09 00 00       	call   800a20 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 82 23 80 00       	push   $0x802382
  80007e:	e8 9d 09 00 00       	call   800a20 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 80 23 80 00       	push   $0x802380
  80008e:	e8 8d 09 00 00       	call   800a20 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp

		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 b4 23 80 00       	push   $0x8023b4
  8000a5:	e8 f8 0f 00 00       	call   8010a2 <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 48 15 00 00       	call   801608 <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 db 18 00 00       	call   8019b0 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 d4 23 80 00       	push   $0x8023d4
  8000e3:	e8 38 09 00 00       	call   800a20 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 f6 23 80 00       	push   $0x8023f6
  8000f3:	e8 28 09 00 00       	call   800a20 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 04 24 80 00       	push   $0x802404
  800103:	e8 18 09 00 00       	call   800a20 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 13 24 80 00       	push   $0x802413
  800113:	e8 08 09 00 00       	call   800a20 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 23 24 80 00       	push   $0x802423
  800123:	e8 f8 08 00 00       	call   800a20 <cprintf>
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
  800162:	e8 8f 1b 00 00       	call   801cf6 <sys_enable_interrupt>

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
  8001d5:	e8 02 1b 00 00       	call   801cdc <sys_disable_interrupt>
			cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001da:	83 ec 0c             	sub    $0xc,%esp
  8001dd:	68 2c 24 80 00       	push   $0x80242c
  8001e2:	e8 39 08 00 00       	call   800a20 <cprintf>
  8001e7:	83 c4 10             	add    $0x10,%esp
		//		PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ea:	e8 07 1b 00 00       	call   801cf6 <sys_enable_interrupt>

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
  80020c:	68 60 24 80 00       	push   $0x802460
  800211:	6a 49                	push   $0x49
  800213:	68 82 24 80 00       	push   $0x802482
  800218:	e8 4c 05 00 00       	call   800769 <_panic>
		else
		{
			sys_disable_interrupt();
  80021d:	e8 ba 1a 00 00       	call   801cdc <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800222:	83 ec 0c             	sub    $0xc,%esp
  800225:	68 a0 24 80 00       	push   $0x8024a0
  80022a:	e8 f1 07 00 00       	call   800a20 <cprintf>
  80022f:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800232:	83 ec 0c             	sub    $0xc,%esp
  800235:	68 d4 24 80 00       	push   $0x8024d4
  80023a:	e8 e1 07 00 00       	call   800a20 <cprintf>
  80023f:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800242:	83 ec 0c             	sub    $0xc,%esp
  800245:	68 08 25 80 00       	push   $0x802508
  80024a:	e8 d1 07 00 00       	call   800a20 <cprintf>
  80024f:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800252:	e8 9f 1a 00 00       	call   801cf6 <sys_enable_interrupt>

		}

		free(Elements) ;
  800257:	83 ec 0c             	sub    $0xc,%esp
  80025a:	ff 75 f0             	pushl  -0x10(%ebp)
  80025d:	e8 68 17 00 00       	call   8019ca <free>
  800262:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800265:	e8 72 1a 00 00       	call   801cdc <sys_disable_interrupt>

		cprintf("Do you want to repeat (y/n): ") ;
  80026a:	83 ec 0c             	sub    $0xc,%esp
  80026d:	68 3a 25 80 00       	push   $0x80253a
  800272:	e8 a9 07 00 00       	call   800a20 <cprintf>
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
  80029f:	e8 52 1a 00 00       	call   801cf6 <sys_enable_interrupt>

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
  800544:	68 80 23 80 00       	push   $0x802380
  800549:	e8 d2 04 00 00       	call   800a20 <cprintf>
  80054e:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800551:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800554:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80055b:	8b 45 08             	mov    0x8(%ebp),%eax
  80055e:	01 d0                	add    %edx,%eax
  800560:	8b 00                	mov    (%eax),%eax
  800562:	83 ec 08             	sub    $0x8,%esp
  800565:	50                   	push   %eax
  800566:	68 58 25 80 00       	push   $0x802558
  80056b:	e8 b0 04 00 00       	call   800a20 <cprintf>
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
  800594:	68 5d 25 80 00       	push   $0x80255d
  800599:	e8 82 04 00 00       	call   800a20 <cprintf>
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
  8005b8:	e8 53 17 00 00       	call   801d10 <sys_cputc>
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
  8005c9:	e8 0e 17 00 00       	call   801cdc <sys_disable_interrupt>
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
  8005dc:	e8 2f 17 00 00       	call   801d10 <sys_cputc>
  8005e1:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8005e4:	e8 0d 17 00 00       	call   801cf6 <sys_enable_interrupt>
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
  8005fb:	e8 f4 14 00 00       	call   801af4 <sys_cgetc>
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
  800614:	e8 c3 16 00 00       	call   801cdc <sys_disable_interrupt>
	int c=0;
  800619:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800620:	eb 08                	jmp    80062a <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800622:	e8 cd 14 00 00       	call   801af4 <sys_cgetc>
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
  800630:	e8 c1 16 00 00       	call   801cf6 <sys_enable_interrupt>
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
  80064a:	e8 f2 14 00 00       	call   801b41 <sys_getenvindex>
  80064f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800652:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800655:	89 d0                	mov    %edx,%eax
  800657:	c1 e0 03             	shl    $0x3,%eax
  80065a:	01 d0                	add    %edx,%eax
  80065c:	c1 e0 02             	shl    $0x2,%eax
  80065f:	01 d0                	add    %edx,%eax
  800661:	c1 e0 06             	shl    $0x6,%eax
  800664:	29 d0                	sub    %edx,%eax
  800666:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80066d:	01 c8                	add    %ecx,%eax
  80066f:	01 d0                	add    %edx,%eax
  800671:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800676:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80067b:	a1 24 30 80 00       	mov    0x803024,%eax
  800680:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  800686:	84 c0                	test   %al,%al
  800688:	74 0f                	je     800699 <libmain+0x55>
		binaryname = myEnv->prog_name;
  80068a:	a1 24 30 80 00       	mov    0x803024,%eax
  80068f:	05 b0 52 00 00       	add    $0x52b0,%eax
  800694:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800699:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80069d:	7e 0a                	jle    8006a9 <libmain+0x65>
		binaryname = argv[0];
  80069f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006a2:	8b 00                	mov    (%eax),%eax
  8006a4:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8006a9:	83 ec 08             	sub    $0x8,%esp
  8006ac:	ff 75 0c             	pushl  0xc(%ebp)
  8006af:	ff 75 08             	pushl  0x8(%ebp)
  8006b2:	e8 81 f9 ff ff       	call   800038 <_main>
  8006b7:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8006ba:	e8 1d 16 00 00       	call   801cdc <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006bf:	83 ec 0c             	sub    $0xc,%esp
  8006c2:	68 7c 25 80 00       	push   $0x80257c
  8006c7:	e8 54 03 00 00       	call   800a20 <cprintf>
  8006cc:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006cf:	a1 24 30 80 00       	mov    0x803024,%eax
  8006d4:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  8006da:	a1 24 30 80 00       	mov    0x803024,%eax
  8006df:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  8006e5:	83 ec 04             	sub    $0x4,%esp
  8006e8:	52                   	push   %edx
  8006e9:	50                   	push   %eax
  8006ea:	68 a4 25 80 00       	push   $0x8025a4
  8006ef:	e8 2c 03 00 00       	call   800a20 <cprintf>
  8006f4:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8006f7:	a1 24 30 80 00       	mov    0x803024,%eax
  8006fc:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  800702:	a1 24 30 80 00       	mov    0x803024,%eax
  800707:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  80070d:	a1 24 30 80 00       	mov    0x803024,%eax
  800712:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  800718:	51                   	push   %ecx
  800719:	52                   	push   %edx
  80071a:	50                   	push   %eax
  80071b:	68 cc 25 80 00       	push   $0x8025cc
  800720:	e8 fb 02 00 00       	call   800a20 <cprintf>
  800725:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800728:	83 ec 0c             	sub    $0xc,%esp
  80072b:	68 7c 25 80 00       	push   $0x80257c
  800730:	e8 eb 02 00 00       	call   800a20 <cprintf>
  800735:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800738:	e8 b9 15 00 00       	call   801cf6 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80073d:	e8 19 00 00 00       	call   80075b <exit>
}
  800742:	90                   	nop
  800743:	c9                   	leave  
  800744:	c3                   	ret    

00800745 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800745:	55                   	push   %ebp
  800746:	89 e5                	mov    %esp,%ebp
  800748:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80074b:	83 ec 0c             	sub    $0xc,%esp
  80074e:	6a 00                	push   $0x0
  800750:	e8 b8 13 00 00       	call   801b0d <sys_env_destroy>
  800755:	83 c4 10             	add    $0x10,%esp
}
  800758:	90                   	nop
  800759:	c9                   	leave  
  80075a:	c3                   	ret    

0080075b <exit>:

void
exit(void)
{
  80075b:	55                   	push   %ebp
  80075c:	89 e5                	mov    %esp,%ebp
  80075e:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800761:	e8 0d 14 00 00       	call   801b73 <sys_env_exit>
}
  800766:	90                   	nop
  800767:	c9                   	leave  
  800768:	c3                   	ret    

00800769 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800769:	55                   	push   %ebp
  80076a:	89 e5                	mov    %esp,%ebp
  80076c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80076f:	8d 45 10             	lea    0x10(%ebp),%eax
  800772:	83 c0 04             	add    $0x4,%eax
  800775:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800778:	a1 18 31 80 00       	mov    0x803118,%eax
  80077d:	85 c0                	test   %eax,%eax
  80077f:	74 16                	je     800797 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800781:	a1 18 31 80 00       	mov    0x803118,%eax
  800786:	83 ec 08             	sub    $0x8,%esp
  800789:	50                   	push   %eax
  80078a:	68 24 26 80 00       	push   $0x802624
  80078f:	e8 8c 02 00 00       	call   800a20 <cprintf>
  800794:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800797:	a1 00 30 80 00       	mov    0x803000,%eax
  80079c:	ff 75 0c             	pushl  0xc(%ebp)
  80079f:	ff 75 08             	pushl  0x8(%ebp)
  8007a2:	50                   	push   %eax
  8007a3:	68 29 26 80 00       	push   $0x802629
  8007a8:	e8 73 02 00 00       	call   800a20 <cprintf>
  8007ad:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8007b3:	83 ec 08             	sub    $0x8,%esp
  8007b6:	ff 75 f4             	pushl  -0xc(%ebp)
  8007b9:	50                   	push   %eax
  8007ba:	e8 f6 01 00 00       	call   8009b5 <vcprintf>
  8007bf:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8007c2:	83 ec 08             	sub    $0x8,%esp
  8007c5:	6a 00                	push   $0x0
  8007c7:	68 45 26 80 00       	push   $0x802645
  8007cc:	e8 e4 01 00 00       	call   8009b5 <vcprintf>
  8007d1:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8007d4:	e8 82 ff ff ff       	call   80075b <exit>

	// should not return here
	while (1) ;
  8007d9:	eb fe                	jmp    8007d9 <_panic+0x70>

008007db <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007db:	55                   	push   %ebp
  8007dc:	89 e5                	mov    %esp,%ebp
  8007de:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007e1:	a1 24 30 80 00       	mov    0x803024,%eax
  8007e6:	8b 50 74             	mov    0x74(%eax),%edx
  8007e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007ec:	39 c2                	cmp    %eax,%edx
  8007ee:	74 14                	je     800804 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007f0:	83 ec 04             	sub    $0x4,%esp
  8007f3:	68 48 26 80 00       	push   $0x802648
  8007f8:	6a 26                	push   $0x26
  8007fa:	68 94 26 80 00       	push   $0x802694
  8007ff:	e8 65 ff ff ff       	call   800769 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800804:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80080b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800812:	e9 c4 00 00 00       	jmp    8008db <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800817:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80081a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800821:	8b 45 08             	mov    0x8(%ebp),%eax
  800824:	01 d0                	add    %edx,%eax
  800826:	8b 00                	mov    (%eax),%eax
  800828:	85 c0                	test   %eax,%eax
  80082a:	75 08                	jne    800834 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80082c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80082f:	e9 a4 00 00 00       	jmp    8008d8 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  800834:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80083b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800842:	eb 6b                	jmp    8008af <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800844:	a1 24 30 80 00       	mov    0x803024,%eax
  800849:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  80084f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800852:	89 d0                	mov    %edx,%eax
  800854:	c1 e0 02             	shl    $0x2,%eax
  800857:	01 d0                	add    %edx,%eax
  800859:	c1 e0 02             	shl    $0x2,%eax
  80085c:	01 c8                	add    %ecx,%eax
  80085e:	8a 40 04             	mov    0x4(%eax),%al
  800861:	84 c0                	test   %al,%al
  800863:	75 47                	jne    8008ac <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800865:	a1 24 30 80 00       	mov    0x803024,%eax
  80086a:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800870:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800873:	89 d0                	mov    %edx,%eax
  800875:	c1 e0 02             	shl    $0x2,%eax
  800878:	01 d0                	add    %edx,%eax
  80087a:	c1 e0 02             	shl    $0x2,%eax
  80087d:	01 c8                	add    %ecx,%eax
  80087f:	8b 00                	mov    (%eax),%eax
  800881:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800884:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800887:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80088c:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80088e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800891:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800898:	8b 45 08             	mov    0x8(%ebp),%eax
  80089b:	01 c8                	add    %ecx,%eax
  80089d:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80089f:	39 c2                	cmp    %eax,%edx
  8008a1:	75 09                	jne    8008ac <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  8008a3:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008aa:	eb 12                	jmp    8008be <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008ac:	ff 45 e8             	incl   -0x18(%ebp)
  8008af:	a1 24 30 80 00       	mov    0x803024,%eax
  8008b4:	8b 50 74             	mov    0x74(%eax),%edx
  8008b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008ba:	39 c2                	cmp    %eax,%edx
  8008bc:	77 86                	ja     800844 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008be:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8008c2:	75 14                	jne    8008d8 <CheckWSWithoutLastIndex+0xfd>
			panic(
  8008c4:	83 ec 04             	sub    $0x4,%esp
  8008c7:	68 a0 26 80 00       	push   $0x8026a0
  8008cc:	6a 3a                	push   $0x3a
  8008ce:	68 94 26 80 00       	push   $0x802694
  8008d3:	e8 91 fe ff ff       	call   800769 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8008d8:	ff 45 f0             	incl   -0x10(%ebp)
  8008db:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008de:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008e1:	0f 8c 30 ff ff ff    	jl     800817 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008e7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008ee:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008f5:	eb 27                	jmp    80091e <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008f7:	a1 24 30 80 00       	mov    0x803024,%eax
  8008fc:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800902:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800905:	89 d0                	mov    %edx,%eax
  800907:	c1 e0 02             	shl    $0x2,%eax
  80090a:	01 d0                	add    %edx,%eax
  80090c:	c1 e0 02             	shl    $0x2,%eax
  80090f:	01 c8                	add    %ecx,%eax
  800911:	8a 40 04             	mov    0x4(%eax),%al
  800914:	3c 01                	cmp    $0x1,%al
  800916:	75 03                	jne    80091b <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800918:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80091b:	ff 45 e0             	incl   -0x20(%ebp)
  80091e:	a1 24 30 80 00       	mov    0x803024,%eax
  800923:	8b 50 74             	mov    0x74(%eax),%edx
  800926:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800929:	39 c2                	cmp    %eax,%edx
  80092b:	77 ca                	ja     8008f7 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80092d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800930:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800933:	74 14                	je     800949 <CheckWSWithoutLastIndex+0x16e>
		panic(
  800935:	83 ec 04             	sub    $0x4,%esp
  800938:	68 f4 26 80 00       	push   $0x8026f4
  80093d:	6a 44                	push   $0x44
  80093f:	68 94 26 80 00       	push   $0x802694
  800944:	e8 20 fe ff ff       	call   800769 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800949:	90                   	nop
  80094a:	c9                   	leave  
  80094b:	c3                   	ret    

0080094c <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80094c:	55                   	push   %ebp
  80094d:	89 e5                	mov    %esp,%ebp
  80094f:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800952:	8b 45 0c             	mov    0xc(%ebp),%eax
  800955:	8b 00                	mov    (%eax),%eax
  800957:	8d 48 01             	lea    0x1(%eax),%ecx
  80095a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80095d:	89 0a                	mov    %ecx,(%edx)
  80095f:	8b 55 08             	mov    0x8(%ebp),%edx
  800962:	88 d1                	mov    %dl,%cl
  800964:	8b 55 0c             	mov    0xc(%ebp),%edx
  800967:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80096b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80096e:	8b 00                	mov    (%eax),%eax
  800970:	3d ff 00 00 00       	cmp    $0xff,%eax
  800975:	75 2c                	jne    8009a3 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800977:	a0 28 30 80 00       	mov    0x803028,%al
  80097c:	0f b6 c0             	movzbl %al,%eax
  80097f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800982:	8b 12                	mov    (%edx),%edx
  800984:	89 d1                	mov    %edx,%ecx
  800986:	8b 55 0c             	mov    0xc(%ebp),%edx
  800989:	83 c2 08             	add    $0x8,%edx
  80098c:	83 ec 04             	sub    $0x4,%esp
  80098f:	50                   	push   %eax
  800990:	51                   	push   %ecx
  800991:	52                   	push   %edx
  800992:	e8 34 11 00 00       	call   801acb <sys_cputs>
  800997:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80099a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80099d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8009a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a6:	8b 40 04             	mov    0x4(%eax),%eax
  8009a9:	8d 50 01             	lea    0x1(%eax),%edx
  8009ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009af:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009b2:	90                   	nop
  8009b3:	c9                   	leave  
  8009b4:	c3                   	ret    

008009b5 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8009b5:	55                   	push   %ebp
  8009b6:	89 e5                	mov    %esp,%ebp
  8009b8:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009be:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8009c5:	00 00 00 
	b.cnt = 0;
  8009c8:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8009cf:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8009d2:	ff 75 0c             	pushl  0xc(%ebp)
  8009d5:	ff 75 08             	pushl  0x8(%ebp)
  8009d8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009de:	50                   	push   %eax
  8009df:	68 4c 09 80 00       	push   $0x80094c
  8009e4:	e8 11 02 00 00       	call   800bfa <vprintfmt>
  8009e9:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009ec:	a0 28 30 80 00       	mov    0x803028,%al
  8009f1:	0f b6 c0             	movzbl %al,%eax
  8009f4:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009fa:	83 ec 04             	sub    $0x4,%esp
  8009fd:	50                   	push   %eax
  8009fe:	52                   	push   %edx
  8009ff:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a05:	83 c0 08             	add    $0x8,%eax
  800a08:	50                   	push   %eax
  800a09:	e8 bd 10 00 00       	call   801acb <sys_cputs>
  800a0e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a11:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800a18:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a1e:	c9                   	leave  
  800a1f:	c3                   	ret    

00800a20 <cprintf>:

int cprintf(const char *fmt, ...) {
  800a20:	55                   	push   %ebp
  800a21:	89 e5                	mov    %esp,%ebp
  800a23:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a26:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800a2d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a30:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a33:	8b 45 08             	mov    0x8(%ebp),%eax
  800a36:	83 ec 08             	sub    $0x8,%esp
  800a39:	ff 75 f4             	pushl  -0xc(%ebp)
  800a3c:	50                   	push   %eax
  800a3d:	e8 73 ff ff ff       	call   8009b5 <vcprintf>
  800a42:	83 c4 10             	add    $0x10,%esp
  800a45:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a48:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a4b:	c9                   	leave  
  800a4c:	c3                   	ret    

00800a4d <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a4d:	55                   	push   %ebp
  800a4e:	89 e5                	mov    %esp,%ebp
  800a50:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a53:	e8 84 12 00 00       	call   801cdc <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a58:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a61:	83 ec 08             	sub    $0x8,%esp
  800a64:	ff 75 f4             	pushl  -0xc(%ebp)
  800a67:	50                   	push   %eax
  800a68:	e8 48 ff ff ff       	call   8009b5 <vcprintf>
  800a6d:	83 c4 10             	add    $0x10,%esp
  800a70:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a73:	e8 7e 12 00 00       	call   801cf6 <sys_enable_interrupt>
	return cnt;
  800a78:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a7b:	c9                   	leave  
  800a7c:	c3                   	ret    

00800a7d <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a7d:	55                   	push   %ebp
  800a7e:	89 e5                	mov    %esp,%ebp
  800a80:	53                   	push   %ebx
  800a81:	83 ec 14             	sub    $0x14,%esp
  800a84:	8b 45 10             	mov    0x10(%ebp),%eax
  800a87:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a8a:	8b 45 14             	mov    0x14(%ebp),%eax
  800a8d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a90:	8b 45 18             	mov    0x18(%ebp),%eax
  800a93:	ba 00 00 00 00       	mov    $0x0,%edx
  800a98:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a9b:	77 55                	ja     800af2 <printnum+0x75>
  800a9d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800aa0:	72 05                	jb     800aa7 <printnum+0x2a>
  800aa2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800aa5:	77 4b                	ja     800af2 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800aa7:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800aaa:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800aad:	8b 45 18             	mov    0x18(%ebp),%eax
  800ab0:	ba 00 00 00 00       	mov    $0x0,%edx
  800ab5:	52                   	push   %edx
  800ab6:	50                   	push   %eax
  800ab7:	ff 75 f4             	pushl  -0xc(%ebp)
  800aba:	ff 75 f0             	pushl  -0x10(%ebp)
  800abd:	e8 5a 16 00 00       	call   80211c <__udivdi3>
  800ac2:	83 c4 10             	add    $0x10,%esp
  800ac5:	83 ec 04             	sub    $0x4,%esp
  800ac8:	ff 75 20             	pushl  0x20(%ebp)
  800acb:	53                   	push   %ebx
  800acc:	ff 75 18             	pushl  0x18(%ebp)
  800acf:	52                   	push   %edx
  800ad0:	50                   	push   %eax
  800ad1:	ff 75 0c             	pushl  0xc(%ebp)
  800ad4:	ff 75 08             	pushl  0x8(%ebp)
  800ad7:	e8 a1 ff ff ff       	call   800a7d <printnum>
  800adc:	83 c4 20             	add    $0x20,%esp
  800adf:	eb 1a                	jmp    800afb <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800ae1:	83 ec 08             	sub    $0x8,%esp
  800ae4:	ff 75 0c             	pushl  0xc(%ebp)
  800ae7:	ff 75 20             	pushl  0x20(%ebp)
  800aea:	8b 45 08             	mov    0x8(%ebp),%eax
  800aed:	ff d0                	call   *%eax
  800aef:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800af2:	ff 4d 1c             	decl   0x1c(%ebp)
  800af5:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800af9:	7f e6                	jg     800ae1 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800afb:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800afe:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b03:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b06:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b09:	53                   	push   %ebx
  800b0a:	51                   	push   %ecx
  800b0b:	52                   	push   %edx
  800b0c:	50                   	push   %eax
  800b0d:	e8 1a 17 00 00       	call   80222c <__umoddi3>
  800b12:	83 c4 10             	add    $0x10,%esp
  800b15:	05 54 29 80 00       	add    $0x802954,%eax
  800b1a:	8a 00                	mov    (%eax),%al
  800b1c:	0f be c0             	movsbl %al,%eax
  800b1f:	83 ec 08             	sub    $0x8,%esp
  800b22:	ff 75 0c             	pushl  0xc(%ebp)
  800b25:	50                   	push   %eax
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	ff d0                	call   *%eax
  800b2b:	83 c4 10             	add    $0x10,%esp
}
  800b2e:	90                   	nop
  800b2f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b32:	c9                   	leave  
  800b33:	c3                   	ret    

00800b34 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b34:	55                   	push   %ebp
  800b35:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b37:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b3b:	7e 1c                	jle    800b59 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b40:	8b 00                	mov    (%eax),%eax
  800b42:	8d 50 08             	lea    0x8(%eax),%edx
  800b45:	8b 45 08             	mov    0x8(%ebp),%eax
  800b48:	89 10                	mov    %edx,(%eax)
  800b4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4d:	8b 00                	mov    (%eax),%eax
  800b4f:	83 e8 08             	sub    $0x8,%eax
  800b52:	8b 50 04             	mov    0x4(%eax),%edx
  800b55:	8b 00                	mov    (%eax),%eax
  800b57:	eb 40                	jmp    800b99 <getuint+0x65>
	else if (lflag)
  800b59:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b5d:	74 1e                	je     800b7d <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b62:	8b 00                	mov    (%eax),%eax
  800b64:	8d 50 04             	lea    0x4(%eax),%edx
  800b67:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6a:	89 10                	mov    %edx,(%eax)
  800b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6f:	8b 00                	mov    (%eax),%eax
  800b71:	83 e8 04             	sub    $0x4,%eax
  800b74:	8b 00                	mov    (%eax),%eax
  800b76:	ba 00 00 00 00       	mov    $0x0,%edx
  800b7b:	eb 1c                	jmp    800b99 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	8b 00                	mov    (%eax),%eax
  800b82:	8d 50 04             	lea    0x4(%eax),%edx
  800b85:	8b 45 08             	mov    0x8(%ebp),%eax
  800b88:	89 10                	mov    %edx,(%eax)
  800b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8d:	8b 00                	mov    (%eax),%eax
  800b8f:	83 e8 04             	sub    $0x4,%eax
  800b92:	8b 00                	mov    (%eax),%eax
  800b94:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b99:	5d                   	pop    %ebp
  800b9a:	c3                   	ret    

00800b9b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b9b:	55                   	push   %ebp
  800b9c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b9e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ba2:	7e 1c                	jle    800bc0 <getint+0x25>
		return va_arg(*ap, long long);
  800ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba7:	8b 00                	mov    (%eax),%eax
  800ba9:	8d 50 08             	lea    0x8(%eax),%edx
  800bac:	8b 45 08             	mov    0x8(%ebp),%eax
  800baf:	89 10                	mov    %edx,(%eax)
  800bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb4:	8b 00                	mov    (%eax),%eax
  800bb6:	83 e8 08             	sub    $0x8,%eax
  800bb9:	8b 50 04             	mov    0x4(%eax),%edx
  800bbc:	8b 00                	mov    (%eax),%eax
  800bbe:	eb 38                	jmp    800bf8 <getint+0x5d>
	else if (lflag)
  800bc0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bc4:	74 1a                	je     800be0 <getint+0x45>
		return va_arg(*ap, long);
  800bc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc9:	8b 00                	mov    (%eax),%eax
  800bcb:	8d 50 04             	lea    0x4(%eax),%edx
  800bce:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd1:	89 10                	mov    %edx,(%eax)
  800bd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd6:	8b 00                	mov    (%eax),%eax
  800bd8:	83 e8 04             	sub    $0x4,%eax
  800bdb:	8b 00                	mov    (%eax),%eax
  800bdd:	99                   	cltd   
  800bde:	eb 18                	jmp    800bf8 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800be0:	8b 45 08             	mov    0x8(%ebp),%eax
  800be3:	8b 00                	mov    (%eax),%eax
  800be5:	8d 50 04             	lea    0x4(%eax),%edx
  800be8:	8b 45 08             	mov    0x8(%ebp),%eax
  800beb:	89 10                	mov    %edx,(%eax)
  800bed:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf0:	8b 00                	mov    (%eax),%eax
  800bf2:	83 e8 04             	sub    $0x4,%eax
  800bf5:	8b 00                	mov    (%eax),%eax
  800bf7:	99                   	cltd   
}
  800bf8:	5d                   	pop    %ebp
  800bf9:	c3                   	ret    

00800bfa <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bfa:	55                   	push   %ebp
  800bfb:	89 e5                	mov    %esp,%ebp
  800bfd:	56                   	push   %esi
  800bfe:	53                   	push   %ebx
  800bff:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c02:	eb 17                	jmp    800c1b <vprintfmt+0x21>
			if (ch == '\0')
  800c04:	85 db                	test   %ebx,%ebx
  800c06:	0f 84 af 03 00 00    	je     800fbb <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c0c:	83 ec 08             	sub    $0x8,%esp
  800c0f:	ff 75 0c             	pushl  0xc(%ebp)
  800c12:	53                   	push   %ebx
  800c13:	8b 45 08             	mov    0x8(%ebp),%eax
  800c16:	ff d0                	call   *%eax
  800c18:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c1b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c1e:	8d 50 01             	lea    0x1(%eax),%edx
  800c21:	89 55 10             	mov    %edx,0x10(%ebp)
  800c24:	8a 00                	mov    (%eax),%al
  800c26:	0f b6 d8             	movzbl %al,%ebx
  800c29:	83 fb 25             	cmp    $0x25,%ebx
  800c2c:	75 d6                	jne    800c04 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c2e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c32:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c39:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c40:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c47:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c4e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c51:	8d 50 01             	lea    0x1(%eax),%edx
  800c54:	89 55 10             	mov    %edx,0x10(%ebp)
  800c57:	8a 00                	mov    (%eax),%al
  800c59:	0f b6 d8             	movzbl %al,%ebx
  800c5c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c5f:	83 f8 55             	cmp    $0x55,%eax
  800c62:	0f 87 2b 03 00 00    	ja     800f93 <vprintfmt+0x399>
  800c68:	8b 04 85 78 29 80 00 	mov    0x802978(,%eax,4),%eax
  800c6f:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c71:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c75:	eb d7                	jmp    800c4e <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c77:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c7b:	eb d1                	jmp    800c4e <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c7d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c84:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c87:	89 d0                	mov    %edx,%eax
  800c89:	c1 e0 02             	shl    $0x2,%eax
  800c8c:	01 d0                	add    %edx,%eax
  800c8e:	01 c0                	add    %eax,%eax
  800c90:	01 d8                	add    %ebx,%eax
  800c92:	83 e8 30             	sub    $0x30,%eax
  800c95:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c98:	8b 45 10             	mov    0x10(%ebp),%eax
  800c9b:	8a 00                	mov    (%eax),%al
  800c9d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ca0:	83 fb 2f             	cmp    $0x2f,%ebx
  800ca3:	7e 3e                	jle    800ce3 <vprintfmt+0xe9>
  800ca5:	83 fb 39             	cmp    $0x39,%ebx
  800ca8:	7f 39                	jg     800ce3 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800caa:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800cad:	eb d5                	jmp    800c84 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800caf:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb2:	83 c0 04             	add    $0x4,%eax
  800cb5:	89 45 14             	mov    %eax,0x14(%ebp)
  800cb8:	8b 45 14             	mov    0x14(%ebp),%eax
  800cbb:	83 e8 04             	sub    $0x4,%eax
  800cbe:	8b 00                	mov    (%eax),%eax
  800cc0:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800cc3:	eb 1f                	jmp    800ce4 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800cc5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cc9:	79 83                	jns    800c4e <vprintfmt+0x54>
				width = 0;
  800ccb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800cd2:	e9 77 ff ff ff       	jmp    800c4e <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800cd7:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800cde:	e9 6b ff ff ff       	jmp    800c4e <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ce3:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800ce4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ce8:	0f 89 60 ff ff ff    	jns    800c4e <vprintfmt+0x54>
				width = precision, precision = -1;
  800cee:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cf1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800cf4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cfb:	e9 4e ff ff ff       	jmp    800c4e <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d00:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d03:	e9 46 ff ff ff       	jmp    800c4e <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d08:	8b 45 14             	mov    0x14(%ebp),%eax
  800d0b:	83 c0 04             	add    $0x4,%eax
  800d0e:	89 45 14             	mov    %eax,0x14(%ebp)
  800d11:	8b 45 14             	mov    0x14(%ebp),%eax
  800d14:	83 e8 04             	sub    $0x4,%eax
  800d17:	8b 00                	mov    (%eax),%eax
  800d19:	83 ec 08             	sub    $0x8,%esp
  800d1c:	ff 75 0c             	pushl  0xc(%ebp)
  800d1f:	50                   	push   %eax
  800d20:	8b 45 08             	mov    0x8(%ebp),%eax
  800d23:	ff d0                	call   *%eax
  800d25:	83 c4 10             	add    $0x10,%esp
			break;
  800d28:	e9 89 02 00 00       	jmp    800fb6 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d2d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d30:	83 c0 04             	add    $0x4,%eax
  800d33:	89 45 14             	mov    %eax,0x14(%ebp)
  800d36:	8b 45 14             	mov    0x14(%ebp),%eax
  800d39:	83 e8 04             	sub    $0x4,%eax
  800d3c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d3e:	85 db                	test   %ebx,%ebx
  800d40:	79 02                	jns    800d44 <vprintfmt+0x14a>
				err = -err;
  800d42:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d44:	83 fb 64             	cmp    $0x64,%ebx
  800d47:	7f 0b                	jg     800d54 <vprintfmt+0x15a>
  800d49:	8b 34 9d c0 27 80 00 	mov    0x8027c0(,%ebx,4),%esi
  800d50:	85 f6                	test   %esi,%esi
  800d52:	75 19                	jne    800d6d <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d54:	53                   	push   %ebx
  800d55:	68 65 29 80 00       	push   $0x802965
  800d5a:	ff 75 0c             	pushl  0xc(%ebp)
  800d5d:	ff 75 08             	pushl  0x8(%ebp)
  800d60:	e8 5e 02 00 00       	call   800fc3 <printfmt>
  800d65:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d68:	e9 49 02 00 00       	jmp    800fb6 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d6d:	56                   	push   %esi
  800d6e:	68 6e 29 80 00       	push   $0x80296e
  800d73:	ff 75 0c             	pushl  0xc(%ebp)
  800d76:	ff 75 08             	pushl  0x8(%ebp)
  800d79:	e8 45 02 00 00       	call   800fc3 <printfmt>
  800d7e:	83 c4 10             	add    $0x10,%esp
			break;
  800d81:	e9 30 02 00 00       	jmp    800fb6 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d86:	8b 45 14             	mov    0x14(%ebp),%eax
  800d89:	83 c0 04             	add    $0x4,%eax
  800d8c:	89 45 14             	mov    %eax,0x14(%ebp)
  800d8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800d92:	83 e8 04             	sub    $0x4,%eax
  800d95:	8b 30                	mov    (%eax),%esi
  800d97:	85 f6                	test   %esi,%esi
  800d99:	75 05                	jne    800da0 <vprintfmt+0x1a6>
				p = "(null)";
  800d9b:	be 71 29 80 00       	mov    $0x802971,%esi
			if (width > 0 && padc != '-')
  800da0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800da4:	7e 6d                	jle    800e13 <vprintfmt+0x219>
  800da6:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800daa:	74 67                	je     800e13 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800dac:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800daf:	83 ec 08             	sub    $0x8,%esp
  800db2:	50                   	push   %eax
  800db3:	56                   	push   %esi
  800db4:	e8 12 05 00 00       	call   8012cb <strnlen>
  800db9:	83 c4 10             	add    $0x10,%esp
  800dbc:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800dbf:	eb 16                	jmp    800dd7 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800dc1:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800dc5:	83 ec 08             	sub    $0x8,%esp
  800dc8:	ff 75 0c             	pushl  0xc(%ebp)
  800dcb:	50                   	push   %eax
  800dcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcf:	ff d0                	call   *%eax
  800dd1:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800dd4:	ff 4d e4             	decl   -0x1c(%ebp)
  800dd7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ddb:	7f e4                	jg     800dc1 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ddd:	eb 34                	jmp    800e13 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800ddf:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800de3:	74 1c                	je     800e01 <vprintfmt+0x207>
  800de5:	83 fb 1f             	cmp    $0x1f,%ebx
  800de8:	7e 05                	jle    800def <vprintfmt+0x1f5>
  800dea:	83 fb 7e             	cmp    $0x7e,%ebx
  800ded:	7e 12                	jle    800e01 <vprintfmt+0x207>
					putch('?', putdat);
  800def:	83 ec 08             	sub    $0x8,%esp
  800df2:	ff 75 0c             	pushl  0xc(%ebp)
  800df5:	6a 3f                	push   $0x3f
  800df7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfa:	ff d0                	call   *%eax
  800dfc:	83 c4 10             	add    $0x10,%esp
  800dff:	eb 0f                	jmp    800e10 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e01:	83 ec 08             	sub    $0x8,%esp
  800e04:	ff 75 0c             	pushl  0xc(%ebp)
  800e07:	53                   	push   %ebx
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	ff d0                	call   *%eax
  800e0d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e10:	ff 4d e4             	decl   -0x1c(%ebp)
  800e13:	89 f0                	mov    %esi,%eax
  800e15:	8d 70 01             	lea    0x1(%eax),%esi
  800e18:	8a 00                	mov    (%eax),%al
  800e1a:	0f be d8             	movsbl %al,%ebx
  800e1d:	85 db                	test   %ebx,%ebx
  800e1f:	74 24                	je     800e45 <vprintfmt+0x24b>
  800e21:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e25:	78 b8                	js     800ddf <vprintfmt+0x1e5>
  800e27:	ff 4d e0             	decl   -0x20(%ebp)
  800e2a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e2e:	79 af                	jns    800ddf <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e30:	eb 13                	jmp    800e45 <vprintfmt+0x24b>
				putch(' ', putdat);
  800e32:	83 ec 08             	sub    $0x8,%esp
  800e35:	ff 75 0c             	pushl  0xc(%ebp)
  800e38:	6a 20                	push   $0x20
  800e3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3d:	ff d0                	call   *%eax
  800e3f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e42:	ff 4d e4             	decl   -0x1c(%ebp)
  800e45:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e49:	7f e7                	jg     800e32 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e4b:	e9 66 01 00 00       	jmp    800fb6 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e50:	83 ec 08             	sub    $0x8,%esp
  800e53:	ff 75 e8             	pushl  -0x18(%ebp)
  800e56:	8d 45 14             	lea    0x14(%ebp),%eax
  800e59:	50                   	push   %eax
  800e5a:	e8 3c fd ff ff       	call   800b9b <getint>
  800e5f:	83 c4 10             	add    $0x10,%esp
  800e62:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e65:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e68:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e6b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e6e:	85 d2                	test   %edx,%edx
  800e70:	79 23                	jns    800e95 <vprintfmt+0x29b>
				putch('-', putdat);
  800e72:	83 ec 08             	sub    $0x8,%esp
  800e75:	ff 75 0c             	pushl  0xc(%ebp)
  800e78:	6a 2d                	push   $0x2d
  800e7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7d:	ff d0                	call   *%eax
  800e7f:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e82:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e85:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e88:	f7 d8                	neg    %eax
  800e8a:	83 d2 00             	adc    $0x0,%edx
  800e8d:	f7 da                	neg    %edx
  800e8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e92:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e95:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e9c:	e9 bc 00 00 00       	jmp    800f5d <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ea1:	83 ec 08             	sub    $0x8,%esp
  800ea4:	ff 75 e8             	pushl  -0x18(%ebp)
  800ea7:	8d 45 14             	lea    0x14(%ebp),%eax
  800eaa:	50                   	push   %eax
  800eab:	e8 84 fc ff ff       	call   800b34 <getuint>
  800eb0:	83 c4 10             	add    $0x10,%esp
  800eb3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eb6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800eb9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ec0:	e9 98 00 00 00       	jmp    800f5d <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ec5:	83 ec 08             	sub    $0x8,%esp
  800ec8:	ff 75 0c             	pushl  0xc(%ebp)
  800ecb:	6a 58                	push   $0x58
  800ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed0:	ff d0                	call   *%eax
  800ed2:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ed5:	83 ec 08             	sub    $0x8,%esp
  800ed8:	ff 75 0c             	pushl  0xc(%ebp)
  800edb:	6a 58                	push   $0x58
  800edd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee0:	ff d0                	call   *%eax
  800ee2:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ee5:	83 ec 08             	sub    $0x8,%esp
  800ee8:	ff 75 0c             	pushl  0xc(%ebp)
  800eeb:	6a 58                	push   $0x58
  800eed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef0:	ff d0                	call   *%eax
  800ef2:	83 c4 10             	add    $0x10,%esp
			break;
  800ef5:	e9 bc 00 00 00       	jmp    800fb6 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800efa:	83 ec 08             	sub    $0x8,%esp
  800efd:	ff 75 0c             	pushl  0xc(%ebp)
  800f00:	6a 30                	push   $0x30
  800f02:	8b 45 08             	mov    0x8(%ebp),%eax
  800f05:	ff d0                	call   *%eax
  800f07:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f0a:	83 ec 08             	sub    $0x8,%esp
  800f0d:	ff 75 0c             	pushl  0xc(%ebp)
  800f10:	6a 78                	push   $0x78
  800f12:	8b 45 08             	mov    0x8(%ebp),%eax
  800f15:	ff d0                	call   *%eax
  800f17:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f1a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f1d:	83 c0 04             	add    $0x4,%eax
  800f20:	89 45 14             	mov    %eax,0x14(%ebp)
  800f23:	8b 45 14             	mov    0x14(%ebp),%eax
  800f26:	83 e8 04             	sub    $0x4,%eax
  800f29:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f2b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f2e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f35:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f3c:	eb 1f                	jmp    800f5d <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f3e:	83 ec 08             	sub    $0x8,%esp
  800f41:	ff 75 e8             	pushl  -0x18(%ebp)
  800f44:	8d 45 14             	lea    0x14(%ebp),%eax
  800f47:	50                   	push   %eax
  800f48:	e8 e7 fb ff ff       	call   800b34 <getuint>
  800f4d:	83 c4 10             	add    $0x10,%esp
  800f50:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f53:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f56:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f5d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f61:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f64:	83 ec 04             	sub    $0x4,%esp
  800f67:	52                   	push   %edx
  800f68:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f6b:	50                   	push   %eax
  800f6c:	ff 75 f4             	pushl  -0xc(%ebp)
  800f6f:	ff 75 f0             	pushl  -0x10(%ebp)
  800f72:	ff 75 0c             	pushl  0xc(%ebp)
  800f75:	ff 75 08             	pushl  0x8(%ebp)
  800f78:	e8 00 fb ff ff       	call   800a7d <printnum>
  800f7d:	83 c4 20             	add    $0x20,%esp
			break;
  800f80:	eb 34                	jmp    800fb6 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f82:	83 ec 08             	sub    $0x8,%esp
  800f85:	ff 75 0c             	pushl  0xc(%ebp)
  800f88:	53                   	push   %ebx
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	ff d0                	call   *%eax
  800f8e:	83 c4 10             	add    $0x10,%esp
			break;
  800f91:	eb 23                	jmp    800fb6 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f93:	83 ec 08             	sub    $0x8,%esp
  800f96:	ff 75 0c             	pushl  0xc(%ebp)
  800f99:	6a 25                	push   $0x25
  800f9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9e:	ff d0                	call   *%eax
  800fa0:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800fa3:	ff 4d 10             	decl   0x10(%ebp)
  800fa6:	eb 03                	jmp    800fab <vprintfmt+0x3b1>
  800fa8:	ff 4d 10             	decl   0x10(%ebp)
  800fab:	8b 45 10             	mov    0x10(%ebp),%eax
  800fae:	48                   	dec    %eax
  800faf:	8a 00                	mov    (%eax),%al
  800fb1:	3c 25                	cmp    $0x25,%al
  800fb3:	75 f3                	jne    800fa8 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800fb5:	90                   	nop
		}
	}
  800fb6:	e9 47 fc ff ff       	jmp    800c02 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800fbb:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800fbc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800fbf:	5b                   	pop    %ebx
  800fc0:	5e                   	pop    %esi
  800fc1:	5d                   	pop    %ebp
  800fc2:	c3                   	ret    

00800fc3 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800fc3:	55                   	push   %ebp
  800fc4:	89 e5                	mov    %esp,%ebp
  800fc6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800fc9:	8d 45 10             	lea    0x10(%ebp),%eax
  800fcc:	83 c0 04             	add    $0x4,%eax
  800fcf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800fd2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd5:	ff 75 f4             	pushl  -0xc(%ebp)
  800fd8:	50                   	push   %eax
  800fd9:	ff 75 0c             	pushl  0xc(%ebp)
  800fdc:	ff 75 08             	pushl  0x8(%ebp)
  800fdf:	e8 16 fc ff ff       	call   800bfa <vprintfmt>
  800fe4:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800fe7:	90                   	nop
  800fe8:	c9                   	leave  
  800fe9:	c3                   	ret    

00800fea <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800fea:	55                   	push   %ebp
  800feb:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fed:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff0:	8b 40 08             	mov    0x8(%eax),%eax
  800ff3:	8d 50 01             	lea    0x1(%eax),%edx
  800ff6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff9:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fff:	8b 10                	mov    (%eax),%edx
  801001:	8b 45 0c             	mov    0xc(%ebp),%eax
  801004:	8b 40 04             	mov    0x4(%eax),%eax
  801007:	39 c2                	cmp    %eax,%edx
  801009:	73 12                	jae    80101d <sprintputch+0x33>
		*b->buf++ = ch;
  80100b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100e:	8b 00                	mov    (%eax),%eax
  801010:	8d 48 01             	lea    0x1(%eax),%ecx
  801013:	8b 55 0c             	mov    0xc(%ebp),%edx
  801016:	89 0a                	mov    %ecx,(%edx)
  801018:	8b 55 08             	mov    0x8(%ebp),%edx
  80101b:	88 10                	mov    %dl,(%eax)
}
  80101d:	90                   	nop
  80101e:	5d                   	pop    %ebp
  80101f:	c3                   	ret    

00801020 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801020:	55                   	push   %ebp
  801021:	89 e5                	mov    %esp,%ebp
  801023:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801026:	8b 45 08             	mov    0x8(%ebp),%eax
  801029:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80102c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801032:	8b 45 08             	mov    0x8(%ebp),%eax
  801035:	01 d0                	add    %edx,%eax
  801037:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80103a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801041:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801045:	74 06                	je     80104d <vsnprintf+0x2d>
  801047:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80104b:	7f 07                	jg     801054 <vsnprintf+0x34>
		return -E_INVAL;
  80104d:	b8 03 00 00 00       	mov    $0x3,%eax
  801052:	eb 20                	jmp    801074 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801054:	ff 75 14             	pushl  0x14(%ebp)
  801057:	ff 75 10             	pushl  0x10(%ebp)
  80105a:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80105d:	50                   	push   %eax
  80105e:	68 ea 0f 80 00       	push   $0x800fea
  801063:	e8 92 fb ff ff       	call   800bfa <vprintfmt>
  801068:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80106b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80106e:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801071:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801074:	c9                   	leave  
  801075:	c3                   	ret    

00801076 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801076:	55                   	push   %ebp
  801077:	89 e5                	mov    %esp,%ebp
  801079:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80107c:	8d 45 10             	lea    0x10(%ebp),%eax
  80107f:	83 c0 04             	add    $0x4,%eax
  801082:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801085:	8b 45 10             	mov    0x10(%ebp),%eax
  801088:	ff 75 f4             	pushl  -0xc(%ebp)
  80108b:	50                   	push   %eax
  80108c:	ff 75 0c             	pushl  0xc(%ebp)
  80108f:	ff 75 08             	pushl  0x8(%ebp)
  801092:	e8 89 ff ff ff       	call   801020 <vsnprintf>
  801097:	83 c4 10             	add    $0x10,%esp
  80109a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80109d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010a0:	c9                   	leave  
  8010a1:	c3                   	ret    

008010a2 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8010a2:	55                   	push   %ebp
  8010a3:	89 e5                	mov    %esp,%ebp
  8010a5:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8010a8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010ac:	74 13                	je     8010c1 <readline+0x1f>
		cprintf("%s", prompt);
  8010ae:	83 ec 08             	sub    $0x8,%esp
  8010b1:	ff 75 08             	pushl  0x8(%ebp)
  8010b4:	68 d0 2a 80 00       	push   $0x802ad0
  8010b9:	e8 62 f9 ff ff       	call   800a20 <cprintf>
  8010be:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8010c1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8010c8:	83 ec 0c             	sub    $0xc,%esp
  8010cb:	6a 00                	push   $0x0
  8010cd:	e8 68 f5 ff ff       	call   80063a <iscons>
  8010d2:	83 c4 10             	add    $0x10,%esp
  8010d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8010d8:	e8 0f f5 ff ff       	call   8005ec <getchar>
  8010dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8010e0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010e4:	79 22                	jns    801108 <readline+0x66>
			if (c != -E_EOF)
  8010e6:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8010ea:	0f 84 ad 00 00 00    	je     80119d <readline+0xfb>
				cprintf("read error: %e\n", c);
  8010f0:	83 ec 08             	sub    $0x8,%esp
  8010f3:	ff 75 ec             	pushl  -0x14(%ebp)
  8010f6:	68 d3 2a 80 00       	push   $0x802ad3
  8010fb:	e8 20 f9 ff ff       	call   800a20 <cprintf>
  801100:	83 c4 10             	add    $0x10,%esp
			return;
  801103:	e9 95 00 00 00       	jmp    80119d <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801108:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80110c:	7e 34                	jle    801142 <readline+0xa0>
  80110e:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801115:	7f 2b                	jg     801142 <readline+0xa0>
			if (echoing)
  801117:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80111b:	74 0e                	je     80112b <readline+0x89>
				cputchar(c);
  80111d:	83 ec 0c             	sub    $0xc,%esp
  801120:	ff 75 ec             	pushl  -0x14(%ebp)
  801123:	e8 7c f4 ff ff       	call   8005a4 <cputchar>
  801128:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80112b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80112e:	8d 50 01             	lea    0x1(%eax),%edx
  801131:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801134:	89 c2                	mov    %eax,%edx
  801136:	8b 45 0c             	mov    0xc(%ebp),%eax
  801139:	01 d0                	add    %edx,%eax
  80113b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80113e:	88 10                	mov    %dl,(%eax)
  801140:	eb 56                	jmp    801198 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801142:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801146:	75 1f                	jne    801167 <readline+0xc5>
  801148:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80114c:	7e 19                	jle    801167 <readline+0xc5>
			if (echoing)
  80114e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801152:	74 0e                	je     801162 <readline+0xc0>
				cputchar(c);
  801154:	83 ec 0c             	sub    $0xc,%esp
  801157:	ff 75 ec             	pushl  -0x14(%ebp)
  80115a:	e8 45 f4 ff ff       	call   8005a4 <cputchar>
  80115f:	83 c4 10             	add    $0x10,%esp

			i--;
  801162:	ff 4d f4             	decl   -0xc(%ebp)
  801165:	eb 31                	jmp    801198 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  801167:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80116b:	74 0a                	je     801177 <readline+0xd5>
  80116d:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801171:	0f 85 61 ff ff ff    	jne    8010d8 <readline+0x36>
			if (echoing)
  801177:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80117b:	74 0e                	je     80118b <readline+0xe9>
				cputchar(c);
  80117d:	83 ec 0c             	sub    $0xc,%esp
  801180:	ff 75 ec             	pushl  -0x14(%ebp)
  801183:	e8 1c f4 ff ff       	call   8005a4 <cputchar>
  801188:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80118b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80118e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801191:	01 d0                	add    %edx,%eax
  801193:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801196:	eb 06                	jmp    80119e <readline+0xfc>
		}
	}
  801198:	e9 3b ff ff ff       	jmp    8010d8 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  80119d:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  80119e:	c9                   	leave  
  80119f:	c3                   	ret    

008011a0 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8011a0:	55                   	push   %ebp
  8011a1:	89 e5                	mov    %esp,%ebp
  8011a3:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8011a6:	e8 31 0b 00 00       	call   801cdc <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8011ab:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011af:	74 13                	je     8011c4 <atomic_readline+0x24>
		cprintf("%s", prompt);
  8011b1:	83 ec 08             	sub    $0x8,%esp
  8011b4:	ff 75 08             	pushl  0x8(%ebp)
  8011b7:	68 d0 2a 80 00       	push   $0x802ad0
  8011bc:	e8 5f f8 ff ff       	call   800a20 <cprintf>
  8011c1:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8011c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8011cb:	83 ec 0c             	sub    $0xc,%esp
  8011ce:	6a 00                	push   $0x0
  8011d0:	e8 65 f4 ff ff       	call   80063a <iscons>
  8011d5:	83 c4 10             	add    $0x10,%esp
  8011d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8011db:	e8 0c f4 ff ff       	call   8005ec <getchar>
  8011e0:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8011e3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8011e7:	79 23                	jns    80120c <atomic_readline+0x6c>
			if (c != -E_EOF)
  8011e9:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8011ed:	74 13                	je     801202 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8011ef:	83 ec 08             	sub    $0x8,%esp
  8011f2:	ff 75 ec             	pushl  -0x14(%ebp)
  8011f5:	68 d3 2a 80 00       	push   $0x802ad3
  8011fa:	e8 21 f8 ff ff       	call   800a20 <cprintf>
  8011ff:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801202:	e8 ef 0a 00 00       	call   801cf6 <sys_enable_interrupt>
			return;
  801207:	e9 9a 00 00 00       	jmp    8012a6 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80120c:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801210:	7e 34                	jle    801246 <atomic_readline+0xa6>
  801212:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801219:	7f 2b                	jg     801246 <atomic_readline+0xa6>
			if (echoing)
  80121b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80121f:	74 0e                	je     80122f <atomic_readline+0x8f>
				cputchar(c);
  801221:	83 ec 0c             	sub    $0xc,%esp
  801224:	ff 75 ec             	pushl  -0x14(%ebp)
  801227:	e8 78 f3 ff ff       	call   8005a4 <cputchar>
  80122c:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80122f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801232:	8d 50 01             	lea    0x1(%eax),%edx
  801235:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801238:	89 c2                	mov    %eax,%edx
  80123a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123d:	01 d0                	add    %edx,%eax
  80123f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801242:	88 10                	mov    %dl,(%eax)
  801244:	eb 5b                	jmp    8012a1 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  801246:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80124a:	75 1f                	jne    80126b <atomic_readline+0xcb>
  80124c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801250:	7e 19                	jle    80126b <atomic_readline+0xcb>
			if (echoing)
  801252:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801256:	74 0e                	je     801266 <atomic_readline+0xc6>
				cputchar(c);
  801258:	83 ec 0c             	sub    $0xc,%esp
  80125b:	ff 75 ec             	pushl  -0x14(%ebp)
  80125e:	e8 41 f3 ff ff       	call   8005a4 <cputchar>
  801263:	83 c4 10             	add    $0x10,%esp
			i--;
  801266:	ff 4d f4             	decl   -0xc(%ebp)
  801269:	eb 36                	jmp    8012a1 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  80126b:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80126f:	74 0a                	je     80127b <atomic_readline+0xdb>
  801271:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801275:	0f 85 60 ff ff ff    	jne    8011db <atomic_readline+0x3b>
			if (echoing)
  80127b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80127f:	74 0e                	je     80128f <atomic_readline+0xef>
				cputchar(c);
  801281:	83 ec 0c             	sub    $0xc,%esp
  801284:	ff 75 ec             	pushl  -0x14(%ebp)
  801287:	e8 18 f3 ff ff       	call   8005a4 <cputchar>
  80128c:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  80128f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801292:	8b 45 0c             	mov    0xc(%ebp),%eax
  801295:	01 d0                	add    %edx,%eax
  801297:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80129a:	e8 57 0a 00 00       	call   801cf6 <sys_enable_interrupt>
			return;
  80129f:	eb 05                	jmp    8012a6 <atomic_readline+0x106>
		}
	}
  8012a1:	e9 35 ff ff ff       	jmp    8011db <atomic_readline+0x3b>
}
  8012a6:	c9                   	leave  
  8012a7:	c3                   	ret    

008012a8 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8012a8:	55                   	push   %ebp
  8012a9:	89 e5                	mov    %esp,%ebp
  8012ab:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8012ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012b5:	eb 06                	jmp    8012bd <strlen+0x15>
		n++;
  8012b7:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8012ba:	ff 45 08             	incl   0x8(%ebp)
  8012bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c0:	8a 00                	mov    (%eax),%al
  8012c2:	84 c0                	test   %al,%al
  8012c4:	75 f1                	jne    8012b7 <strlen+0xf>
		n++;
	return n;
  8012c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012c9:	c9                   	leave  
  8012ca:	c3                   	ret    

008012cb <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8012cb:	55                   	push   %ebp
  8012cc:	89 e5                	mov    %esp,%ebp
  8012ce:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012d8:	eb 09                	jmp    8012e3 <strnlen+0x18>
		n++;
  8012da:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012dd:	ff 45 08             	incl   0x8(%ebp)
  8012e0:	ff 4d 0c             	decl   0xc(%ebp)
  8012e3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012e7:	74 09                	je     8012f2 <strnlen+0x27>
  8012e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ec:	8a 00                	mov    (%eax),%al
  8012ee:	84 c0                	test   %al,%al
  8012f0:	75 e8                	jne    8012da <strnlen+0xf>
		n++;
	return n;
  8012f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012f5:	c9                   	leave  
  8012f6:	c3                   	ret    

008012f7 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8012f7:	55                   	push   %ebp
  8012f8:	89 e5                	mov    %esp,%ebp
  8012fa:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8012fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801300:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801303:	90                   	nop
  801304:	8b 45 08             	mov    0x8(%ebp),%eax
  801307:	8d 50 01             	lea    0x1(%eax),%edx
  80130a:	89 55 08             	mov    %edx,0x8(%ebp)
  80130d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801310:	8d 4a 01             	lea    0x1(%edx),%ecx
  801313:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801316:	8a 12                	mov    (%edx),%dl
  801318:	88 10                	mov    %dl,(%eax)
  80131a:	8a 00                	mov    (%eax),%al
  80131c:	84 c0                	test   %al,%al
  80131e:	75 e4                	jne    801304 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801320:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801323:	c9                   	leave  
  801324:	c3                   	ret    

00801325 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801325:	55                   	push   %ebp
  801326:	89 e5                	mov    %esp,%ebp
  801328:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80132b:	8b 45 08             	mov    0x8(%ebp),%eax
  80132e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801331:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801338:	eb 1f                	jmp    801359 <strncpy+0x34>
		*dst++ = *src;
  80133a:	8b 45 08             	mov    0x8(%ebp),%eax
  80133d:	8d 50 01             	lea    0x1(%eax),%edx
  801340:	89 55 08             	mov    %edx,0x8(%ebp)
  801343:	8b 55 0c             	mov    0xc(%ebp),%edx
  801346:	8a 12                	mov    (%edx),%dl
  801348:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80134a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80134d:	8a 00                	mov    (%eax),%al
  80134f:	84 c0                	test   %al,%al
  801351:	74 03                	je     801356 <strncpy+0x31>
			src++;
  801353:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801356:	ff 45 fc             	incl   -0x4(%ebp)
  801359:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80135c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80135f:	72 d9                	jb     80133a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801361:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801364:	c9                   	leave  
  801365:	c3                   	ret    

00801366 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801366:	55                   	push   %ebp
  801367:	89 e5                	mov    %esp,%ebp
  801369:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80136c:	8b 45 08             	mov    0x8(%ebp),%eax
  80136f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801372:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801376:	74 30                	je     8013a8 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801378:	eb 16                	jmp    801390 <strlcpy+0x2a>
			*dst++ = *src++;
  80137a:	8b 45 08             	mov    0x8(%ebp),%eax
  80137d:	8d 50 01             	lea    0x1(%eax),%edx
  801380:	89 55 08             	mov    %edx,0x8(%ebp)
  801383:	8b 55 0c             	mov    0xc(%ebp),%edx
  801386:	8d 4a 01             	lea    0x1(%edx),%ecx
  801389:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80138c:	8a 12                	mov    (%edx),%dl
  80138e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801390:	ff 4d 10             	decl   0x10(%ebp)
  801393:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801397:	74 09                	je     8013a2 <strlcpy+0x3c>
  801399:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139c:	8a 00                	mov    (%eax),%al
  80139e:	84 c0                	test   %al,%al
  8013a0:	75 d8                	jne    80137a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8013a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a5:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8013a8:	8b 55 08             	mov    0x8(%ebp),%edx
  8013ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ae:	29 c2                	sub    %eax,%edx
  8013b0:	89 d0                	mov    %edx,%eax
}
  8013b2:	c9                   	leave  
  8013b3:	c3                   	ret    

008013b4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8013b4:	55                   	push   %ebp
  8013b5:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8013b7:	eb 06                	jmp    8013bf <strcmp+0xb>
		p++, q++;
  8013b9:	ff 45 08             	incl   0x8(%ebp)
  8013bc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8013bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c2:	8a 00                	mov    (%eax),%al
  8013c4:	84 c0                	test   %al,%al
  8013c6:	74 0e                	je     8013d6 <strcmp+0x22>
  8013c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cb:	8a 10                	mov    (%eax),%dl
  8013cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d0:	8a 00                	mov    (%eax),%al
  8013d2:	38 c2                	cmp    %al,%dl
  8013d4:	74 e3                	je     8013b9 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8013d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d9:	8a 00                	mov    (%eax),%al
  8013db:	0f b6 d0             	movzbl %al,%edx
  8013de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e1:	8a 00                	mov    (%eax),%al
  8013e3:	0f b6 c0             	movzbl %al,%eax
  8013e6:	29 c2                	sub    %eax,%edx
  8013e8:	89 d0                	mov    %edx,%eax
}
  8013ea:	5d                   	pop    %ebp
  8013eb:	c3                   	ret    

008013ec <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8013ec:	55                   	push   %ebp
  8013ed:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8013ef:	eb 09                	jmp    8013fa <strncmp+0xe>
		n--, p++, q++;
  8013f1:	ff 4d 10             	decl   0x10(%ebp)
  8013f4:	ff 45 08             	incl   0x8(%ebp)
  8013f7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013fa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013fe:	74 17                	je     801417 <strncmp+0x2b>
  801400:	8b 45 08             	mov    0x8(%ebp),%eax
  801403:	8a 00                	mov    (%eax),%al
  801405:	84 c0                	test   %al,%al
  801407:	74 0e                	je     801417 <strncmp+0x2b>
  801409:	8b 45 08             	mov    0x8(%ebp),%eax
  80140c:	8a 10                	mov    (%eax),%dl
  80140e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801411:	8a 00                	mov    (%eax),%al
  801413:	38 c2                	cmp    %al,%dl
  801415:	74 da                	je     8013f1 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801417:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80141b:	75 07                	jne    801424 <strncmp+0x38>
		return 0;
  80141d:	b8 00 00 00 00       	mov    $0x0,%eax
  801422:	eb 14                	jmp    801438 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801424:	8b 45 08             	mov    0x8(%ebp),%eax
  801427:	8a 00                	mov    (%eax),%al
  801429:	0f b6 d0             	movzbl %al,%edx
  80142c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142f:	8a 00                	mov    (%eax),%al
  801431:	0f b6 c0             	movzbl %al,%eax
  801434:	29 c2                	sub    %eax,%edx
  801436:	89 d0                	mov    %edx,%eax
}
  801438:	5d                   	pop    %ebp
  801439:	c3                   	ret    

0080143a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80143a:	55                   	push   %ebp
  80143b:	89 e5                	mov    %esp,%ebp
  80143d:	83 ec 04             	sub    $0x4,%esp
  801440:	8b 45 0c             	mov    0xc(%ebp),%eax
  801443:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801446:	eb 12                	jmp    80145a <strchr+0x20>
		if (*s == c)
  801448:	8b 45 08             	mov    0x8(%ebp),%eax
  80144b:	8a 00                	mov    (%eax),%al
  80144d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801450:	75 05                	jne    801457 <strchr+0x1d>
			return (char *) s;
  801452:	8b 45 08             	mov    0x8(%ebp),%eax
  801455:	eb 11                	jmp    801468 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801457:	ff 45 08             	incl   0x8(%ebp)
  80145a:	8b 45 08             	mov    0x8(%ebp),%eax
  80145d:	8a 00                	mov    (%eax),%al
  80145f:	84 c0                	test   %al,%al
  801461:	75 e5                	jne    801448 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801463:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801468:	c9                   	leave  
  801469:	c3                   	ret    

0080146a <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80146a:	55                   	push   %ebp
  80146b:	89 e5                	mov    %esp,%ebp
  80146d:	83 ec 04             	sub    $0x4,%esp
  801470:	8b 45 0c             	mov    0xc(%ebp),%eax
  801473:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801476:	eb 0d                	jmp    801485 <strfind+0x1b>
		if (*s == c)
  801478:	8b 45 08             	mov    0x8(%ebp),%eax
  80147b:	8a 00                	mov    (%eax),%al
  80147d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801480:	74 0e                	je     801490 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801482:	ff 45 08             	incl   0x8(%ebp)
  801485:	8b 45 08             	mov    0x8(%ebp),%eax
  801488:	8a 00                	mov    (%eax),%al
  80148a:	84 c0                	test   %al,%al
  80148c:	75 ea                	jne    801478 <strfind+0xe>
  80148e:	eb 01                	jmp    801491 <strfind+0x27>
		if (*s == c)
			break;
  801490:	90                   	nop
	return (char *) s;
  801491:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801494:	c9                   	leave  
  801495:	c3                   	ret    

00801496 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801496:	55                   	push   %ebp
  801497:	89 e5                	mov    %esp,%ebp
  801499:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
  80149f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8014a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8014a5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8014a8:	eb 0e                	jmp    8014b8 <memset+0x22>
		*p++ = c;
  8014aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014ad:	8d 50 01             	lea    0x1(%eax),%edx
  8014b0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014b6:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8014b8:	ff 4d f8             	decl   -0x8(%ebp)
  8014bb:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8014bf:	79 e9                	jns    8014aa <memset+0x14>
		*p++ = c;

	return v;
  8014c1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014c4:	c9                   	leave  
  8014c5:	c3                   	ret    

008014c6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8014c6:	55                   	push   %ebp
  8014c7:	89 e5                	mov    %esp,%ebp
  8014c9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8014d8:	eb 16                	jmp    8014f0 <memcpy+0x2a>
		*d++ = *s++;
  8014da:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014dd:	8d 50 01             	lea    0x1(%eax),%edx
  8014e0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014e3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014e6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014e9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014ec:	8a 12                	mov    (%edx),%dl
  8014ee:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8014f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014f6:	89 55 10             	mov    %edx,0x10(%ebp)
  8014f9:	85 c0                	test   %eax,%eax
  8014fb:	75 dd                	jne    8014da <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8014fd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801500:	c9                   	leave  
  801501:	c3                   	ret    

00801502 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801502:	55                   	push   %ebp
  801503:	89 e5                	mov    %esp,%ebp
  801505:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801508:	8b 45 0c             	mov    0xc(%ebp),%eax
  80150b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80150e:	8b 45 08             	mov    0x8(%ebp),%eax
  801511:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801514:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801517:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80151a:	73 50                	jae    80156c <memmove+0x6a>
  80151c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80151f:	8b 45 10             	mov    0x10(%ebp),%eax
  801522:	01 d0                	add    %edx,%eax
  801524:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801527:	76 43                	jbe    80156c <memmove+0x6a>
		s += n;
  801529:	8b 45 10             	mov    0x10(%ebp),%eax
  80152c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80152f:	8b 45 10             	mov    0x10(%ebp),%eax
  801532:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801535:	eb 10                	jmp    801547 <memmove+0x45>
			*--d = *--s;
  801537:	ff 4d f8             	decl   -0x8(%ebp)
  80153a:	ff 4d fc             	decl   -0x4(%ebp)
  80153d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801540:	8a 10                	mov    (%eax),%dl
  801542:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801545:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801547:	8b 45 10             	mov    0x10(%ebp),%eax
  80154a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80154d:	89 55 10             	mov    %edx,0x10(%ebp)
  801550:	85 c0                	test   %eax,%eax
  801552:	75 e3                	jne    801537 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801554:	eb 23                	jmp    801579 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801556:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801559:	8d 50 01             	lea    0x1(%eax),%edx
  80155c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80155f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801562:	8d 4a 01             	lea    0x1(%edx),%ecx
  801565:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801568:	8a 12                	mov    (%edx),%dl
  80156a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80156c:	8b 45 10             	mov    0x10(%ebp),%eax
  80156f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801572:	89 55 10             	mov    %edx,0x10(%ebp)
  801575:	85 c0                	test   %eax,%eax
  801577:	75 dd                	jne    801556 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801579:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80157c:	c9                   	leave  
  80157d:	c3                   	ret    

0080157e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80157e:	55                   	push   %ebp
  80157f:	89 e5                	mov    %esp,%ebp
  801581:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801584:	8b 45 08             	mov    0x8(%ebp),%eax
  801587:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80158a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801590:	eb 2a                	jmp    8015bc <memcmp+0x3e>
		if (*s1 != *s2)
  801592:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801595:	8a 10                	mov    (%eax),%dl
  801597:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80159a:	8a 00                	mov    (%eax),%al
  80159c:	38 c2                	cmp    %al,%dl
  80159e:	74 16                	je     8015b6 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015a3:	8a 00                	mov    (%eax),%al
  8015a5:	0f b6 d0             	movzbl %al,%edx
  8015a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ab:	8a 00                	mov    (%eax),%al
  8015ad:	0f b6 c0             	movzbl %al,%eax
  8015b0:	29 c2                	sub    %eax,%edx
  8015b2:	89 d0                	mov    %edx,%eax
  8015b4:	eb 18                	jmp    8015ce <memcmp+0x50>
		s1++, s2++;
  8015b6:	ff 45 fc             	incl   -0x4(%ebp)
  8015b9:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8015bf:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015c2:	89 55 10             	mov    %edx,0x10(%ebp)
  8015c5:	85 c0                	test   %eax,%eax
  8015c7:	75 c9                	jne    801592 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8015c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ce:	c9                   	leave  
  8015cf:	c3                   	ret    

008015d0 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8015d0:	55                   	push   %ebp
  8015d1:	89 e5                	mov    %esp,%ebp
  8015d3:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8015d6:	8b 55 08             	mov    0x8(%ebp),%edx
  8015d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8015dc:	01 d0                	add    %edx,%eax
  8015de:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015e1:	eb 15                	jmp    8015f8 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e6:	8a 00                	mov    (%eax),%al
  8015e8:	0f b6 d0             	movzbl %al,%edx
  8015eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ee:	0f b6 c0             	movzbl %al,%eax
  8015f1:	39 c2                	cmp    %eax,%edx
  8015f3:	74 0d                	je     801602 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015f5:	ff 45 08             	incl   0x8(%ebp)
  8015f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015fe:	72 e3                	jb     8015e3 <memfind+0x13>
  801600:	eb 01                	jmp    801603 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801602:	90                   	nop
	return (void *) s;
  801603:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801606:	c9                   	leave  
  801607:	c3                   	ret    

00801608 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801608:	55                   	push   %ebp
  801609:	89 e5                	mov    %esp,%ebp
  80160b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80160e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801615:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80161c:	eb 03                	jmp    801621 <strtol+0x19>
		s++;
  80161e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801621:	8b 45 08             	mov    0x8(%ebp),%eax
  801624:	8a 00                	mov    (%eax),%al
  801626:	3c 20                	cmp    $0x20,%al
  801628:	74 f4                	je     80161e <strtol+0x16>
  80162a:	8b 45 08             	mov    0x8(%ebp),%eax
  80162d:	8a 00                	mov    (%eax),%al
  80162f:	3c 09                	cmp    $0x9,%al
  801631:	74 eb                	je     80161e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801633:	8b 45 08             	mov    0x8(%ebp),%eax
  801636:	8a 00                	mov    (%eax),%al
  801638:	3c 2b                	cmp    $0x2b,%al
  80163a:	75 05                	jne    801641 <strtol+0x39>
		s++;
  80163c:	ff 45 08             	incl   0x8(%ebp)
  80163f:	eb 13                	jmp    801654 <strtol+0x4c>
	else if (*s == '-')
  801641:	8b 45 08             	mov    0x8(%ebp),%eax
  801644:	8a 00                	mov    (%eax),%al
  801646:	3c 2d                	cmp    $0x2d,%al
  801648:	75 0a                	jne    801654 <strtol+0x4c>
		s++, neg = 1;
  80164a:	ff 45 08             	incl   0x8(%ebp)
  80164d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801654:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801658:	74 06                	je     801660 <strtol+0x58>
  80165a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80165e:	75 20                	jne    801680 <strtol+0x78>
  801660:	8b 45 08             	mov    0x8(%ebp),%eax
  801663:	8a 00                	mov    (%eax),%al
  801665:	3c 30                	cmp    $0x30,%al
  801667:	75 17                	jne    801680 <strtol+0x78>
  801669:	8b 45 08             	mov    0x8(%ebp),%eax
  80166c:	40                   	inc    %eax
  80166d:	8a 00                	mov    (%eax),%al
  80166f:	3c 78                	cmp    $0x78,%al
  801671:	75 0d                	jne    801680 <strtol+0x78>
		s += 2, base = 16;
  801673:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801677:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80167e:	eb 28                	jmp    8016a8 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801680:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801684:	75 15                	jne    80169b <strtol+0x93>
  801686:	8b 45 08             	mov    0x8(%ebp),%eax
  801689:	8a 00                	mov    (%eax),%al
  80168b:	3c 30                	cmp    $0x30,%al
  80168d:	75 0c                	jne    80169b <strtol+0x93>
		s++, base = 8;
  80168f:	ff 45 08             	incl   0x8(%ebp)
  801692:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801699:	eb 0d                	jmp    8016a8 <strtol+0xa0>
	else if (base == 0)
  80169b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80169f:	75 07                	jne    8016a8 <strtol+0xa0>
		base = 10;
  8016a1:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ab:	8a 00                	mov    (%eax),%al
  8016ad:	3c 2f                	cmp    $0x2f,%al
  8016af:	7e 19                	jle    8016ca <strtol+0xc2>
  8016b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b4:	8a 00                	mov    (%eax),%al
  8016b6:	3c 39                	cmp    $0x39,%al
  8016b8:	7f 10                	jg     8016ca <strtol+0xc2>
			dig = *s - '0';
  8016ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bd:	8a 00                	mov    (%eax),%al
  8016bf:	0f be c0             	movsbl %al,%eax
  8016c2:	83 e8 30             	sub    $0x30,%eax
  8016c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016c8:	eb 42                	jmp    80170c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8016ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cd:	8a 00                	mov    (%eax),%al
  8016cf:	3c 60                	cmp    $0x60,%al
  8016d1:	7e 19                	jle    8016ec <strtol+0xe4>
  8016d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d6:	8a 00                	mov    (%eax),%al
  8016d8:	3c 7a                	cmp    $0x7a,%al
  8016da:	7f 10                	jg     8016ec <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016df:	8a 00                	mov    (%eax),%al
  8016e1:	0f be c0             	movsbl %al,%eax
  8016e4:	83 e8 57             	sub    $0x57,%eax
  8016e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016ea:	eb 20                	jmp    80170c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ef:	8a 00                	mov    (%eax),%al
  8016f1:	3c 40                	cmp    $0x40,%al
  8016f3:	7e 39                	jle    80172e <strtol+0x126>
  8016f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f8:	8a 00                	mov    (%eax),%al
  8016fa:	3c 5a                	cmp    $0x5a,%al
  8016fc:	7f 30                	jg     80172e <strtol+0x126>
			dig = *s - 'A' + 10;
  8016fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801701:	8a 00                	mov    (%eax),%al
  801703:	0f be c0             	movsbl %al,%eax
  801706:	83 e8 37             	sub    $0x37,%eax
  801709:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80170c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80170f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801712:	7d 19                	jge    80172d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801714:	ff 45 08             	incl   0x8(%ebp)
  801717:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80171a:	0f af 45 10          	imul   0x10(%ebp),%eax
  80171e:	89 c2                	mov    %eax,%edx
  801720:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801723:	01 d0                	add    %edx,%eax
  801725:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801728:	e9 7b ff ff ff       	jmp    8016a8 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80172d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80172e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801732:	74 08                	je     80173c <strtol+0x134>
		*endptr = (char *) s;
  801734:	8b 45 0c             	mov    0xc(%ebp),%eax
  801737:	8b 55 08             	mov    0x8(%ebp),%edx
  80173a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80173c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801740:	74 07                	je     801749 <strtol+0x141>
  801742:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801745:	f7 d8                	neg    %eax
  801747:	eb 03                	jmp    80174c <strtol+0x144>
  801749:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80174c:	c9                   	leave  
  80174d:	c3                   	ret    

0080174e <ltostr>:

void
ltostr(long value, char *str)
{
  80174e:	55                   	push   %ebp
  80174f:	89 e5                	mov    %esp,%ebp
  801751:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801754:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80175b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801762:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801766:	79 13                	jns    80177b <ltostr+0x2d>
	{
		neg = 1;
  801768:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80176f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801772:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801775:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801778:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80177b:	8b 45 08             	mov    0x8(%ebp),%eax
  80177e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801783:	99                   	cltd   
  801784:	f7 f9                	idiv   %ecx
  801786:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801789:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80178c:	8d 50 01             	lea    0x1(%eax),%edx
  80178f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801792:	89 c2                	mov    %eax,%edx
  801794:	8b 45 0c             	mov    0xc(%ebp),%eax
  801797:	01 d0                	add    %edx,%eax
  801799:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80179c:	83 c2 30             	add    $0x30,%edx
  80179f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017a1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017a4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017a9:	f7 e9                	imul   %ecx
  8017ab:	c1 fa 02             	sar    $0x2,%edx
  8017ae:	89 c8                	mov    %ecx,%eax
  8017b0:	c1 f8 1f             	sar    $0x1f,%eax
  8017b3:	29 c2                	sub    %eax,%edx
  8017b5:	89 d0                	mov    %edx,%eax
  8017b7:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8017ba:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017bd:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017c2:	f7 e9                	imul   %ecx
  8017c4:	c1 fa 02             	sar    $0x2,%edx
  8017c7:	89 c8                	mov    %ecx,%eax
  8017c9:	c1 f8 1f             	sar    $0x1f,%eax
  8017cc:	29 c2                	sub    %eax,%edx
  8017ce:	89 d0                	mov    %edx,%eax
  8017d0:	c1 e0 02             	shl    $0x2,%eax
  8017d3:	01 d0                	add    %edx,%eax
  8017d5:	01 c0                	add    %eax,%eax
  8017d7:	29 c1                	sub    %eax,%ecx
  8017d9:	89 ca                	mov    %ecx,%edx
  8017db:	85 d2                	test   %edx,%edx
  8017dd:	75 9c                	jne    80177b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8017df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017e9:	48                   	dec    %eax
  8017ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017ed:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017f1:	74 3d                	je     801830 <ltostr+0xe2>
		start = 1 ;
  8017f3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017fa:	eb 34                	jmp    801830 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8017fc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801802:	01 d0                	add    %edx,%eax
  801804:	8a 00                	mov    (%eax),%al
  801806:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801809:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80180c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80180f:	01 c2                	add    %eax,%edx
  801811:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801814:	8b 45 0c             	mov    0xc(%ebp),%eax
  801817:	01 c8                	add    %ecx,%eax
  801819:	8a 00                	mov    (%eax),%al
  80181b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80181d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801820:	8b 45 0c             	mov    0xc(%ebp),%eax
  801823:	01 c2                	add    %eax,%edx
  801825:	8a 45 eb             	mov    -0x15(%ebp),%al
  801828:	88 02                	mov    %al,(%edx)
		start++ ;
  80182a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80182d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801830:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801833:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801836:	7c c4                	jl     8017fc <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801838:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80183b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80183e:	01 d0                	add    %edx,%eax
  801840:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801843:	90                   	nop
  801844:	c9                   	leave  
  801845:	c3                   	ret    

00801846 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801846:	55                   	push   %ebp
  801847:	89 e5                	mov    %esp,%ebp
  801849:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80184c:	ff 75 08             	pushl  0x8(%ebp)
  80184f:	e8 54 fa ff ff       	call   8012a8 <strlen>
  801854:	83 c4 04             	add    $0x4,%esp
  801857:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80185a:	ff 75 0c             	pushl  0xc(%ebp)
  80185d:	e8 46 fa ff ff       	call   8012a8 <strlen>
  801862:	83 c4 04             	add    $0x4,%esp
  801865:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801868:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80186f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801876:	eb 17                	jmp    80188f <strcconcat+0x49>
		final[s] = str1[s] ;
  801878:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80187b:	8b 45 10             	mov    0x10(%ebp),%eax
  80187e:	01 c2                	add    %eax,%edx
  801880:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801883:	8b 45 08             	mov    0x8(%ebp),%eax
  801886:	01 c8                	add    %ecx,%eax
  801888:	8a 00                	mov    (%eax),%al
  80188a:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80188c:	ff 45 fc             	incl   -0x4(%ebp)
  80188f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801892:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801895:	7c e1                	jl     801878 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801897:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80189e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8018a5:	eb 1f                	jmp    8018c6 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8018a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018aa:	8d 50 01             	lea    0x1(%eax),%edx
  8018ad:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018b0:	89 c2                	mov    %eax,%edx
  8018b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b5:	01 c2                	add    %eax,%edx
  8018b7:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018bd:	01 c8                	add    %ecx,%eax
  8018bf:	8a 00                	mov    (%eax),%al
  8018c1:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8018c3:	ff 45 f8             	incl   -0x8(%ebp)
  8018c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018c9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018cc:	7c d9                	jl     8018a7 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8018ce:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8018d4:	01 d0                	add    %edx,%eax
  8018d6:	c6 00 00             	movb   $0x0,(%eax)
}
  8018d9:	90                   	nop
  8018da:	c9                   	leave  
  8018db:	c3                   	ret    

008018dc <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8018dc:	55                   	push   %ebp
  8018dd:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8018df:	8b 45 14             	mov    0x14(%ebp),%eax
  8018e2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8018eb:	8b 00                	mov    (%eax),%eax
  8018ed:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8018f7:	01 d0                	add    %edx,%eax
  8018f9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018ff:	eb 0c                	jmp    80190d <strsplit+0x31>
			*string++ = 0;
  801901:	8b 45 08             	mov    0x8(%ebp),%eax
  801904:	8d 50 01             	lea    0x1(%eax),%edx
  801907:	89 55 08             	mov    %edx,0x8(%ebp)
  80190a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80190d:	8b 45 08             	mov    0x8(%ebp),%eax
  801910:	8a 00                	mov    (%eax),%al
  801912:	84 c0                	test   %al,%al
  801914:	74 18                	je     80192e <strsplit+0x52>
  801916:	8b 45 08             	mov    0x8(%ebp),%eax
  801919:	8a 00                	mov    (%eax),%al
  80191b:	0f be c0             	movsbl %al,%eax
  80191e:	50                   	push   %eax
  80191f:	ff 75 0c             	pushl  0xc(%ebp)
  801922:	e8 13 fb ff ff       	call   80143a <strchr>
  801927:	83 c4 08             	add    $0x8,%esp
  80192a:	85 c0                	test   %eax,%eax
  80192c:	75 d3                	jne    801901 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80192e:	8b 45 08             	mov    0x8(%ebp),%eax
  801931:	8a 00                	mov    (%eax),%al
  801933:	84 c0                	test   %al,%al
  801935:	74 5a                	je     801991 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801937:	8b 45 14             	mov    0x14(%ebp),%eax
  80193a:	8b 00                	mov    (%eax),%eax
  80193c:	83 f8 0f             	cmp    $0xf,%eax
  80193f:	75 07                	jne    801948 <strsplit+0x6c>
		{
			return 0;
  801941:	b8 00 00 00 00       	mov    $0x0,%eax
  801946:	eb 66                	jmp    8019ae <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801948:	8b 45 14             	mov    0x14(%ebp),%eax
  80194b:	8b 00                	mov    (%eax),%eax
  80194d:	8d 48 01             	lea    0x1(%eax),%ecx
  801950:	8b 55 14             	mov    0x14(%ebp),%edx
  801953:	89 0a                	mov    %ecx,(%edx)
  801955:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80195c:	8b 45 10             	mov    0x10(%ebp),%eax
  80195f:	01 c2                	add    %eax,%edx
  801961:	8b 45 08             	mov    0x8(%ebp),%eax
  801964:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801966:	eb 03                	jmp    80196b <strsplit+0x8f>
			string++;
  801968:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80196b:	8b 45 08             	mov    0x8(%ebp),%eax
  80196e:	8a 00                	mov    (%eax),%al
  801970:	84 c0                	test   %al,%al
  801972:	74 8b                	je     8018ff <strsplit+0x23>
  801974:	8b 45 08             	mov    0x8(%ebp),%eax
  801977:	8a 00                	mov    (%eax),%al
  801979:	0f be c0             	movsbl %al,%eax
  80197c:	50                   	push   %eax
  80197d:	ff 75 0c             	pushl  0xc(%ebp)
  801980:	e8 b5 fa ff ff       	call   80143a <strchr>
  801985:	83 c4 08             	add    $0x8,%esp
  801988:	85 c0                	test   %eax,%eax
  80198a:	74 dc                	je     801968 <strsplit+0x8c>
			string++;
	}
  80198c:	e9 6e ff ff ff       	jmp    8018ff <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801991:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801992:	8b 45 14             	mov    0x14(%ebp),%eax
  801995:	8b 00                	mov    (%eax),%eax
  801997:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80199e:	8b 45 10             	mov    0x10(%ebp),%eax
  8019a1:	01 d0                	add    %edx,%eax
  8019a3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019a9:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019ae:	c9                   	leave  
  8019af:	c3                   	ret    

008019b0 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  8019b0:	55                   	push   %ebp
  8019b1:	89 e5                	mov    %esp,%ebp
  8019b3:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  8019b6:	83 ec 04             	sub    $0x4,%esp
  8019b9:	68 e4 2a 80 00       	push   $0x802ae4
  8019be:	6a 15                	push   $0x15
  8019c0:	68 09 2b 80 00       	push   $0x802b09
  8019c5:	e8 9f ed ff ff       	call   800769 <_panic>

008019ca <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8019ca:	55                   	push   %ebp
  8019cb:	89 e5                	mov    %esp,%ebp
  8019cd:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8019d0:	83 ec 04             	sub    $0x4,%esp
  8019d3:	68 18 2b 80 00       	push   $0x802b18
  8019d8:	6a 2e                	push   $0x2e
  8019da:	68 09 2b 80 00       	push   $0x802b09
  8019df:	e8 85 ed ff ff       	call   800769 <_panic>

008019e4 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8019e4:	55                   	push   %ebp
  8019e5:	89 e5                	mov    %esp,%ebp
  8019e7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019ea:	83 ec 04             	sub    $0x4,%esp
  8019ed:	68 3c 2b 80 00       	push   $0x802b3c
  8019f2:	6a 4c                	push   $0x4c
  8019f4:	68 09 2b 80 00       	push   $0x802b09
  8019f9:	e8 6b ed ff ff       	call   800769 <_panic>

008019fe <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8019fe:	55                   	push   %ebp
  8019ff:	89 e5                	mov    %esp,%ebp
  801a01:	83 ec 18             	sub    $0x18,%esp
  801a04:	8b 45 10             	mov    0x10(%ebp),%eax
  801a07:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801a0a:	83 ec 04             	sub    $0x4,%esp
  801a0d:	68 3c 2b 80 00       	push   $0x802b3c
  801a12:	6a 57                	push   $0x57
  801a14:	68 09 2b 80 00       	push   $0x802b09
  801a19:	e8 4b ed ff ff       	call   800769 <_panic>

00801a1e <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801a1e:	55                   	push   %ebp
  801a1f:	89 e5                	mov    %esp,%ebp
  801a21:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a24:	83 ec 04             	sub    $0x4,%esp
  801a27:	68 3c 2b 80 00       	push   $0x802b3c
  801a2c:	6a 5d                	push   $0x5d
  801a2e:	68 09 2b 80 00       	push   $0x802b09
  801a33:	e8 31 ed ff ff       	call   800769 <_panic>

00801a38 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801a38:	55                   	push   %ebp
  801a39:	89 e5                	mov    %esp,%ebp
  801a3b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a3e:	83 ec 04             	sub    $0x4,%esp
  801a41:	68 3c 2b 80 00       	push   $0x802b3c
  801a46:	6a 63                	push   $0x63
  801a48:	68 09 2b 80 00       	push   $0x802b09
  801a4d:	e8 17 ed ff ff       	call   800769 <_panic>

00801a52 <expand>:
}

void expand(uint32 newSize)
{
  801a52:	55                   	push   %ebp
  801a53:	89 e5                	mov    %esp,%ebp
  801a55:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a58:	83 ec 04             	sub    $0x4,%esp
  801a5b:	68 3c 2b 80 00       	push   $0x802b3c
  801a60:	6a 68                	push   $0x68
  801a62:	68 09 2b 80 00       	push   $0x802b09
  801a67:	e8 fd ec ff ff       	call   800769 <_panic>

00801a6c <shrink>:
}
void shrink(uint32 newSize)
{
  801a6c:	55                   	push   %ebp
  801a6d:	89 e5                	mov    %esp,%ebp
  801a6f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a72:	83 ec 04             	sub    $0x4,%esp
  801a75:	68 3c 2b 80 00       	push   $0x802b3c
  801a7a:	6a 6c                	push   $0x6c
  801a7c:	68 09 2b 80 00       	push   $0x802b09
  801a81:	e8 e3 ec ff ff       	call   800769 <_panic>

00801a86 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801a86:	55                   	push   %ebp
  801a87:	89 e5                	mov    %esp,%ebp
  801a89:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a8c:	83 ec 04             	sub    $0x4,%esp
  801a8f:	68 3c 2b 80 00       	push   $0x802b3c
  801a94:	6a 71                	push   $0x71
  801a96:	68 09 2b 80 00       	push   $0x802b09
  801a9b:	e8 c9 ec ff ff       	call   800769 <_panic>

00801aa0 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801aa0:	55                   	push   %ebp
  801aa1:	89 e5                	mov    %esp,%ebp
  801aa3:	57                   	push   %edi
  801aa4:	56                   	push   %esi
  801aa5:	53                   	push   %ebx
  801aa6:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  801aac:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aaf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ab2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ab5:	8b 7d 18             	mov    0x18(%ebp),%edi
  801ab8:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801abb:	cd 30                	int    $0x30
  801abd:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801ac0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ac3:	83 c4 10             	add    $0x10,%esp
  801ac6:	5b                   	pop    %ebx
  801ac7:	5e                   	pop    %esi
  801ac8:	5f                   	pop    %edi
  801ac9:	5d                   	pop    %ebp
  801aca:	c3                   	ret    

00801acb <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801acb:	55                   	push   %ebp
  801acc:	89 e5                	mov    %esp,%ebp
  801ace:	83 ec 04             	sub    $0x4,%esp
  801ad1:	8b 45 10             	mov    0x10(%ebp),%eax
  801ad4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801ad7:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801adb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ade:	6a 00                	push   $0x0
  801ae0:	6a 00                	push   $0x0
  801ae2:	52                   	push   %edx
  801ae3:	ff 75 0c             	pushl  0xc(%ebp)
  801ae6:	50                   	push   %eax
  801ae7:	6a 00                	push   $0x0
  801ae9:	e8 b2 ff ff ff       	call   801aa0 <syscall>
  801aee:	83 c4 18             	add    $0x18,%esp
}
  801af1:	90                   	nop
  801af2:	c9                   	leave  
  801af3:	c3                   	ret    

00801af4 <sys_cgetc>:

int
sys_cgetc(void)
{
  801af4:	55                   	push   %ebp
  801af5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801af7:	6a 00                	push   $0x0
  801af9:	6a 00                	push   $0x0
  801afb:	6a 00                	push   $0x0
  801afd:	6a 00                	push   $0x0
  801aff:	6a 00                	push   $0x0
  801b01:	6a 01                	push   $0x1
  801b03:	e8 98 ff ff ff       	call   801aa0 <syscall>
  801b08:	83 c4 18             	add    $0x18,%esp
}
  801b0b:	c9                   	leave  
  801b0c:	c3                   	ret    

00801b0d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801b0d:	55                   	push   %ebp
  801b0e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801b10:	8b 45 08             	mov    0x8(%ebp),%eax
  801b13:	6a 00                	push   $0x0
  801b15:	6a 00                	push   $0x0
  801b17:	6a 00                	push   $0x0
  801b19:	6a 00                	push   $0x0
  801b1b:	50                   	push   %eax
  801b1c:	6a 05                	push   $0x5
  801b1e:	e8 7d ff ff ff       	call   801aa0 <syscall>
  801b23:	83 c4 18             	add    $0x18,%esp
}
  801b26:	c9                   	leave  
  801b27:	c3                   	ret    

00801b28 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801b28:	55                   	push   %ebp
  801b29:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801b2b:	6a 00                	push   $0x0
  801b2d:	6a 00                	push   $0x0
  801b2f:	6a 00                	push   $0x0
  801b31:	6a 00                	push   $0x0
  801b33:	6a 00                	push   $0x0
  801b35:	6a 02                	push   $0x2
  801b37:	e8 64 ff ff ff       	call   801aa0 <syscall>
  801b3c:	83 c4 18             	add    $0x18,%esp
}
  801b3f:	c9                   	leave  
  801b40:	c3                   	ret    

00801b41 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801b41:	55                   	push   %ebp
  801b42:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801b44:	6a 00                	push   $0x0
  801b46:	6a 00                	push   $0x0
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 03                	push   $0x3
  801b50:	e8 4b ff ff ff       	call   801aa0 <syscall>
  801b55:	83 c4 18             	add    $0x18,%esp
}
  801b58:	c9                   	leave  
  801b59:	c3                   	ret    

00801b5a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b5a:	55                   	push   %ebp
  801b5b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b5d:	6a 00                	push   $0x0
  801b5f:	6a 00                	push   $0x0
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	6a 04                	push   $0x4
  801b69:	e8 32 ff ff ff       	call   801aa0 <syscall>
  801b6e:	83 c4 18             	add    $0x18,%esp
}
  801b71:	c9                   	leave  
  801b72:	c3                   	ret    

00801b73 <sys_env_exit>:


void sys_env_exit(void)
{
  801b73:	55                   	push   %ebp
  801b74:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801b76:	6a 00                	push   $0x0
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 06                	push   $0x6
  801b82:	e8 19 ff ff ff       	call   801aa0 <syscall>
  801b87:	83 c4 18             	add    $0x18,%esp
}
  801b8a:	90                   	nop
  801b8b:	c9                   	leave  
  801b8c:	c3                   	ret    

00801b8d <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801b8d:	55                   	push   %ebp
  801b8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801b90:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b93:	8b 45 08             	mov    0x8(%ebp),%eax
  801b96:	6a 00                	push   $0x0
  801b98:	6a 00                	push   $0x0
  801b9a:	6a 00                	push   $0x0
  801b9c:	52                   	push   %edx
  801b9d:	50                   	push   %eax
  801b9e:	6a 07                	push   $0x7
  801ba0:	e8 fb fe ff ff       	call   801aa0 <syscall>
  801ba5:	83 c4 18             	add    $0x18,%esp
}
  801ba8:	c9                   	leave  
  801ba9:	c3                   	ret    

00801baa <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801baa:	55                   	push   %ebp
  801bab:	89 e5                	mov    %esp,%ebp
  801bad:	56                   	push   %esi
  801bae:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801baf:	8b 75 18             	mov    0x18(%ebp),%esi
  801bb2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bb5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bb8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bbb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbe:	56                   	push   %esi
  801bbf:	53                   	push   %ebx
  801bc0:	51                   	push   %ecx
  801bc1:	52                   	push   %edx
  801bc2:	50                   	push   %eax
  801bc3:	6a 08                	push   $0x8
  801bc5:	e8 d6 fe ff ff       	call   801aa0 <syscall>
  801bca:	83 c4 18             	add    $0x18,%esp
}
  801bcd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801bd0:	5b                   	pop    %ebx
  801bd1:	5e                   	pop    %esi
  801bd2:	5d                   	pop    %ebp
  801bd3:	c3                   	ret    

00801bd4 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801bd4:	55                   	push   %ebp
  801bd5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801bd7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bda:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdd:	6a 00                	push   $0x0
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 00                	push   $0x0
  801be3:	52                   	push   %edx
  801be4:	50                   	push   %eax
  801be5:	6a 09                	push   $0x9
  801be7:	e8 b4 fe ff ff       	call   801aa0 <syscall>
  801bec:	83 c4 18             	add    $0x18,%esp
}
  801bef:	c9                   	leave  
  801bf0:	c3                   	ret    

00801bf1 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801bf1:	55                   	push   %ebp
  801bf2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801bf4:	6a 00                	push   $0x0
  801bf6:	6a 00                	push   $0x0
  801bf8:	6a 00                	push   $0x0
  801bfa:	ff 75 0c             	pushl  0xc(%ebp)
  801bfd:	ff 75 08             	pushl  0x8(%ebp)
  801c00:	6a 0a                	push   $0xa
  801c02:	e8 99 fe ff ff       	call   801aa0 <syscall>
  801c07:	83 c4 18             	add    $0x18,%esp
}
  801c0a:	c9                   	leave  
  801c0b:	c3                   	ret    

00801c0c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c0c:	55                   	push   %ebp
  801c0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 0b                	push   $0xb
  801c1b:	e8 80 fe ff ff       	call   801aa0 <syscall>
  801c20:	83 c4 18             	add    $0x18,%esp
}
  801c23:	c9                   	leave  
  801c24:	c3                   	ret    

00801c25 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c25:	55                   	push   %ebp
  801c26:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c28:	6a 00                	push   $0x0
  801c2a:	6a 00                	push   $0x0
  801c2c:	6a 00                	push   $0x0
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	6a 0c                	push   $0xc
  801c34:	e8 67 fe ff ff       	call   801aa0 <syscall>
  801c39:	83 c4 18             	add    $0x18,%esp
}
  801c3c:	c9                   	leave  
  801c3d:	c3                   	ret    

00801c3e <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801c3e:	55                   	push   %ebp
  801c3f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801c41:	6a 00                	push   $0x0
  801c43:	6a 00                	push   $0x0
  801c45:	6a 00                	push   $0x0
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 0d                	push   $0xd
  801c4d:	e8 4e fe ff ff       	call   801aa0 <syscall>
  801c52:	83 c4 18             	add    $0x18,%esp
}
  801c55:	c9                   	leave  
  801c56:	c3                   	ret    

00801c57 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801c57:	55                   	push   %ebp
  801c58:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c5a:	6a 00                	push   $0x0
  801c5c:	6a 00                	push   $0x0
  801c5e:	6a 00                	push   $0x0
  801c60:	ff 75 0c             	pushl  0xc(%ebp)
  801c63:	ff 75 08             	pushl  0x8(%ebp)
  801c66:	6a 11                	push   $0x11
  801c68:	e8 33 fe ff ff       	call   801aa0 <syscall>
  801c6d:	83 c4 18             	add    $0x18,%esp
	return;
  801c70:	90                   	nop
}
  801c71:	c9                   	leave  
  801c72:	c3                   	ret    

00801c73 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c73:	55                   	push   %ebp
  801c74:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801c76:	6a 00                	push   $0x0
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	ff 75 0c             	pushl  0xc(%ebp)
  801c7f:	ff 75 08             	pushl  0x8(%ebp)
  801c82:	6a 12                	push   $0x12
  801c84:	e8 17 fe ff ff       	call   801aa0 <syscall>
  801c89:	83 c4 18             	add    $0x18,%esp
	return ;
  801c8c:	90                   	nop
}
  801c8d:	c9                   	leave  
  801c8e:	c3                   	ret    

00801c8f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801c8f:	55                   	push   %ebp
  801c90:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801c92:	6a 00                	push   $0x0
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	6a 00                	push   $0x0
  801c9a:	6a 00                	push   $0x0
  801c9c:	6a 0e                	push   $0xe
  801c9e:	e8 fd fd ff ff       	call   801aa0 <syscall>
  801ca3:	83 c4 18             	add    $0x18,%esp
}
  801ca6:	c9                   	leave  
  801ca7:	c3                   	ret    

00801ca8 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801ca8:	55                   	push   %ebp
  801ca9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	ff 75 08             	pushl  0x8(%ebp)
  801cb6:	6a 0f                	push   $0xf
  801cb8:	e8 e3 fd ff ff       	call   801aa0 <syscall>
  801cbd:	83 c4 18             	add    $0x18,%esp
}
  801cc0:	c9                   	leave  
  801cc1:	c3                   	ret    

00801cc2 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801cc2:	55                   	push   %ebp
  801cc3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801cc5:	6a 00                	push   $0x0
  801cc7:	6a 00                	push   $0x0
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 10                	push   $0x10
  801cd1:	e8 ca fd ff ff       	call   801aa0 <syscall>
  801cd6:	83 c4 18             	add    $0x18,%esp
}
  801cd9:	90                   	nop
  801cda:	c9                   	leave  
  801cdb:	c3                   	ret    

00801cdc <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801cdc:	55                   	push   %ebp
  801cdd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 14                	push   $0x14
  801ceb:	e8 b0 fd ff ff       	call   801aa0 <syscall>
  801cf0:	83 c4 18             	add    $0x18,%esp
}
  801cf3:	90                   	nop
  801cf4:	c9                   	leave  
  801cf5:	c3                   	ret    

00801cf6 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801cf6:	55                   	push   %ebp
  801cf7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801cf9:	6a 00                	push   $0x0
  801cfb:	6a 00                	push   $0x0
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	6a 15                	push   $0x15
  801d05:	e8 96 fd ff ff       	call   801aa0 <syscall>
  801d0a:	83 c4 18             	add    $0x18,%esp
}
  801d0d:	90                   	nop
  801d0e:	c9                   	leave  
  801d0f:	c3                   	ret    

00801d10 <sys_cputc>:


void
sys_cputc(const char c)
{
  801d10:	55                   	push   %ebp
  801d11:	89 e5                	mov    %esp,%ebp
  801d13:	83 ec 04             	sub    $0x4,%esp
  801d16:	8b 45 08             	mov    0x8(%ebp),%eax
  801d19:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801d1c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d20:	6a 00                	push   $0x0
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	6a 00                	push   $0x0
  801d28:	50                   	push   %eax
  801d29:	6a 16                	push   $0x16
  801d2b:	e8 70 fd ff ff       	call   801aa0 <syscall>
  801d30:	83 c4 18             	add    $0x18,%esp
}
  801d33:	90                   	nop
  801d34:	c9                   	leave  
  801d35:	c3                   	ret    

00801d36 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801d36:	55                   	push   %ebp
  801d37:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 17                	push   $0x17
  801d45:	e8 56 fd ff ff       	call   801aa0 <syscall>
  801d4a:	83 c4 18             	add    $0x18,%esp
}
  801d4d:	90                   	nop
  801d4e:	c9                   	leave  
  801d4f:	c3                   	ret    

00801d50 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801d50:	55                   	push   %ebp
  801d51:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801d53:	8b 45 08             	mov    0x8(%ebp),%eax
  801d56:	6a 00                	push   $0x0
  801d58:	6a 00                	push   $0x0
  801d5a:	6a 00                	push   $0x0
  801d5c:	ff 75 0c             	pushl  0xc(%ebp)
  801d5f:	50                   	push   %eax
  801d60:	6a 18                	push   $0x18
  801d62:	e8 39 fd ff ff       	call   801aa0 <syscall>
  801d67:	83 c4 18             	add    $0x18,%esp
}
  801d6a:	c9                   	leave  
  801d6b:	c3                   	ret    

00801d6c <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d6c:	55                   	push   %ebp
  801d6d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d6f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d72:	8b 45 08             	mov    0x8(%ebp),%eax
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	6a 00                	push   $0x0
  801d7b:	52                   	push   %edx
  801d7c:	50                   	push   %eax
  801d7d:	6a 1b                	push   $0x1b
  801d7f:	e8 1c fd ff ff       	call   801aa0 <syscall>
  801d84:	83 c4 18             	add    $0x18,%esp
}
  801d87:	c9                   	leave  
  801d88:	c3                   	ret    

00801d89 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d89:	55                   	push   %ebp
  801d8a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d92:	6a 00                	push   $0x0
  801d94:	6a 00                	push   $0x0
  801d96:	6a 00                	push   $0x0
  801d98:	52                   	push   %edx
  801d99:	50                   	push   %eax
  801d9a:	6a 19                	push   $0x19
  801d9c:	e8 ff fc ff ff       	call   801aa0 <syscall>
  801da1:	83 c4 18             	add    $0x18,%esp
}
  801da4:	90                   	nop
  801da5:	c9                   	leave  
  801da6:	c3                   	ret    

00801da7 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801da7:	55                   	push   %ebp
  801da8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801daa:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dad:	8b 45 08             	mov    0x8(%ebp),%eax
  801db0:	6a 00                	push   $0x0
  801db2:	6a 00                	push   $0x0
  801db4:	6a 00                	push   $0x0
  801db6:	52                   	push   %edx
  801db7:	50                   	push   %eax
  801db8:	6a 1a                	push   $0x1a
  801dba:	e8 e1 fc ff ff       	call   801aa0 <syscall>
  801dbf:	83 c4 18             	add    $0x18,%esp
}
  801dc2:	90                   	nop
  801dc3:	c9                   	leave  
  801dc4:	c3                   	ret    

00801dc5 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801dc5:	55                   	push   %ebp
  801dc6:	89 e5                	mov    %esp,%ebp
  801dc8:	83 ec 04             	sub    $0x4,%esp
  801dcb:	8b 45 10             	mov    0x10(%ebp),%eax
  801dce:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801dd1:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801dd4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801dd8:	8b 45 08             	mov    0x8(%ebp),%eax
  801ddb:	6a 00                	push   $0x0
  801ddd:	51                   	push   %ecx
  801dde:	52                   	push   %edx
  801ddf:	ff 75 0c             	pushl  0xc(%ebp)
  801de2:	50                   	push   %eax
  801de3:	6a 1c                	push   $0x1c
  801de5:	e8 b6 fc ff ff       	call   801aa0 <syscall>
  801dea:	83 c4 18             	add    $0x18,%esp
}
  801ded:	c9                   	leave  
  801dee:	c3                   	ret    

00801def <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801def:	55                   	push   %ebp
  801df0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801df2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801df5:	8b 45 08             	mov    0x8(%ebp),%eax
  801df8:	6a 00                	push   $0x0
  801dfa:	6a 00                	push   $0x0
  801dfc:	6a 00                	push   $0x0
  801dfe:	52                   	push   %edx
  801dff:	50                   	push   %eax
  801e00:	6a 1d                	push   $0x1d
  801e02:	e8 99 fc ff ff       	call   801aa0 <syscall>
  801e07:	83 c4 18             	add    $0x18,%esp
}
  801e0a:	c9                   	leave  
  801e0b:	c3                   	ret    

00801e0c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801e0c:	55                   	push   %ebp
  801e0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801e0f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e12:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e15:	8b 45 08             	mov    0x8(%ebp),%eax
  801e18:	6a 00                	push   $0x0
  801e1a:	6a 00                	push   $0x0
  801e1c:	51                   	push   %ecx
  801e1d:	52                   	push   %edx
  801e1e:	50                   	push   %eax
  801e1f:	6a 1e                	push   $0x1e
  801e21:	e8 7a fc ff ff       	call   801aa0 <syscall>
  801e26:	83 c4 18             	add    $0x18,%esp
}
  801e29:	c9                   	leave  
  801e2a:	c3                   	ret    

00801e2b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801e2b:	55                   	push   %ebp
  801e2c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801e2e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e31:	8b 45 08             	mov    0x8(%ebp),%eax
  801e34:	6a 00                	push   $0x0
  801e36:	6a 00                	push   $0x0
  801e38:	6a 00                	push   $0x0
  801e3a:	52                   	push   %edx
  801e3b:	50                   	push   %eax
  801e3c:	6a 1f                	push   $0x1f
  801e3e:	e8 5d fc ff ff       	call   801aa0 <syscall>
  801e43:	83 c4 18             	add    $0x18,%esp
}
  801e46:	c9                   	leave  
  801e47:	c3                   	ret    

00801e48 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801e48:	55                   	push   %ebp
  801e49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 00                	push   $0x0
  801e53:	6a 00                	push   $0x0
  801e55:	6a 20                	push   $0x20
  801e57:	e8 44 fc ff ff       	call   801aa0 <syscall>
  801e5c:	83 c4 18             	add    $0x18,%esp
}
  801e5f:	c9                   	leave  
  801e60:	c3                   	ret    

00801e61 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801e61:	55                   	push   %ebp
  801e62:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801e64:	8b 45 08             	mov    0x8(%ebp),%eax
  801e67:	6a 00                	push   $0x0
  801e69:	ff 75 14             	pushl  0x14(%ebp)
  801e6c:	ff 75 10             	pushl  0x10(%ebp)
  801e6f:	ff 75 0c             	pushl  0xc(%ebp)
  801e72:	50                   	push   %eax
  801e73:	6a 21                	push   $0x21
  801e75:	e8 26 fc ff ff       	call   801aa0 <syscall>
  801e7a:	83 c4 18             	add    $0x18,%esp
}
  801e7d:	c9                   	leave  
  801e7e:	c3                   	ret    

00801e7f <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801e7f:	55                   	push   %ebp
  801e80:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801e82:	8b 45 08             	mov    0x8(%ebp),%eax
  801e85:	6a 00                	push   $0x0
  801e87:	6a 00                	push   $0x0
  801e89:	6a 00                	push   $0x0
  801e8b:	6a 00                	push   $0x0
  801e8d:	50                   	push   %eax
  801e8e:	6a 22                	push   $0x22
  801e90:	e8 0b fc ff ff       	call   801aa0 <syscall>
  801e95:	83 c4 18             	add    $0x18,%esp
}
  801e98:	90                   	nop
  801e99:	c9                   	leave  
  801e9a:	c3                   	ret    

00801e9b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801e9b:	55                   	push   %ebp
  801e9c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801e9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 00                	push   $0x0
  801ea5:	6a 00                	push   $0x0
  801ea7:	6a 00                	push   $0x0
  801ea9:	50                   	push   %eax
  801eaa:	6a 23                	push   $0x23
  801eac:	e8 ef fb ff ff       	call   801aa0 <syscall>
  801eb1:	83 c4 18             	add    $0x18,%esp
}
  801eb4:	90                   	nop
  801eb5:	c9                   	leave  
  801eb6:	c3                   	ret    

00801eb7 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801eb7:	55                   	push   %ebp
  801eb8:	89 e5                	mov    %esp,%ebp
  801eba:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801ebd:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ec0:	8d 50 04             	lea    0x4(%eax),%edx
  801ec3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 00                	push   $0x0
  801eca:	6a 00                	push   $0x0
  801ecc:	52                   	push   %edx
  801ecd:	50                   	push   %eax
  801ece:	6a 24                	push   $0x24
  801ed0:	e8 cb fb ff ff       	call   801aa0 <syscall>
  801ed5:	83 c4 18             	add    $0x18,%esp
	return result;
  801ed8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801edb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ede:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ee1:	89 01                	mov    %eax,(%ecx)
  801ee3:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801ee6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee9:	c9                   	leave  
  801eea:	c2 04 00             	ret    $0x4

00801eed <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801eed:	55                   	push   %ebp
  801eee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801ef0:	6a 00                	push   $0x0
  801ef2:	6a 00                	push   $0x0
  801ef4:	ff 75 10             	pushl  0x10(%ebp)
  801ef7:	ff 75 0c             	pushl  0xc(%ebp)
  801efa:	ff 75 08             	pushl  0x8(%ebp)
  801efd:	6a 13                	push   $0x13
  801eff:	e8 9c fb ff ff       	call   801aa0 <syscall>
  801f04:	83 c4 18             	add    $0x18,%esp
	return ;
  801f07:	90                   	nop
}
  801f08:	c9                   	leave  
  801f09:	c3                   	ret    

00801f0a <sys_rcr2>:
uint32 sys_rcr2()
{
  801f0a:	55                   	push   %ebp
  801f0b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801f0d:	6a 00                	push   $0x0
  801f0f:	6a 00                	push   $0x0
  801f11:	6a 00                	push   $0x0
  801f13:	6a 00                	push   $0x0
  801f15:	6a 00                	push   $0x0
  801f17:	6a 25                	push   $0x25
  801f19:	e8 82 fb ff ff       	call   801aa0 <syscall>
  801f1e:	83 c4 18             	add    $0x18,%esp
}
  801f21:	c9                   	leave  
  801f22:	c3                   	ret    

00801f23 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801f23:	55                   	push   %ebp
  801f24:	89 e5                	mov    %esp,%ebp
  801f26:	83 ec 04             	sub    $0x4,%esp
  801f29:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801f2f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801f33:	6a 00                	push   $0x0
  801f35:	6a 00                	push   $0x0
  801f37:	6a 00                	push   $0x0
  801f39:	6a 00                	push   $0x0
  801f3b:	50                   	push   %eax
  801f3c:	6a 26                	push   $0x26
  801f3e:	e8 5d fb ff ff       	call   801aa0 <syscall>
  801f43:	83 c4 18             	add    $0x18,%esp
	return ;
  801f46:	90                   	nop
}
  801f47:	c9                   	leave  
  801f48:	c3                   	ret    

00801f49 <rsttst>:
void rsttst()
{
  801f49:	55                   	push   %ebp
  801f4a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801f4c:	6a 00                	push   $0x0
  801f4e:	6a 00                	push   $0x0
  801f50:	6a 00                	push   $0x0
  801f52:	6a 00                	push   $0x0
  801f54:	6a 00                	push   $0x0
  801f56:	6a 28                	push   $0x28
  801f58:	e8 43 fb ff ff       	call   801aa0 <syscall>
  801f5d:	83 c4 18             	add    $0x18,%esp
	return ;
  801f60:	90                   	nop
}
  801f61:	c9                   	leave  
  801f62:	c3                   	ret    

00801f63 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f63:	55                   	push   %ebp
  801f64:	89 e5                	mov    %esp,%ebp
  801f66:	83 ec 04             	sub    $0x4,%esp
  801f69:	8b 45 14             	mov    0x14(%ebp),%eax
  801f6c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f6f:	8b 55 18             	mov    0x18(%ebp),%edx
  801f72:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f76:	52                   	push   %edx
  801f77:	50                   	push   %eax
  801f78:	ff 75 10             	pushl  0x10(%ebp)
  801f7b:	ff 75 0c             	pushl  0xc(%ebp)
  801f7e:	ff 75 08             	pushl  0x8(%ebp)
  801f81:	6a 27                	push   $0x27
  801f83:	e8 18 fb ff ff       	call   801aa0 <syscall>
  801f88:	83 c4 18             	add    $0x18,%esp
	return ;
  801f8b:	90                   	nop
}
  801f8c:	c9                   	leave  
  801f8d:	c3                   	ret    

00801f8e <chktst>:
void chktst(uint32 n)
{
  801f8e:	55                   	push   %ebp
  801f8f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801f91:	6a 00                	push   $0x0
  801f93:	6a 00                	push   $0x0
  801f95:	6a 00                	push   $0x0
  801f97:	6a 00                	push   $0x0
  801f99:	ff 75 08             	pushl  0x8(%ebp)
  801f9c:	6a 29                	push   $0x29
  801f9e:	e8 fd fa ff ff       	call   801aa0 <syscall>
  801fa3:	83 c4 18             	add    $0x18,%esp
	return ;
  801fa6:	90                   	nop
}
  801fa7:	c9                   	leave  
  801fa8:	c3                   	ret    

00801fa9 <inctst>:

void inctst()
{
  801fa9:	55                   	push   %ebp
  801faa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	6a 00                	push   $0x0
  801fb2:	6a 00                	push   $0x0
  801fb4:	6a 00                	push   $0x0
  801fb6:	6a 2a                	push   $0x2a
  801fb8:	e8 e3 fa ff ff       	call   801aa0 <syscall>
  801fbd:	83 c4 18             	add    $0x18,%esp
	return ;
  801fc0:	90                   	nop
}
  801fc1:	c9                   	leave  
  801fc2:	c3                   	ret    

00801fc3 <gettst>:
uint32 gettst()
{
  801fc3:	55                   	push   %ebp
  801fc4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801fc6:	6a 00                	push   $0x0
  801fc8:	6a 00                	push   $0x0
  801fca:	6a 00                	push   $0x0
  801fcc:	6a 00                	push   $0x0
  801fce:	6a 00                	push   $0x0
  801fd0:	6a 2b                	push   $0x2b
  801fd2:	e8 c9 fa ff ff       	call   801aa0 <syscall>
  801fd7:	83 c4 18             	add    $0x18,%esp
}
  801fda:	c9                   	leave  
  801fdb:	c3                   	ret    

00801fdc <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801fdc:	55                   	push   %ebp
  801fdd:	89 e5                	mov    %esp,%ebp
  801fdf:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fe2:	6a 00                	push   $0x0
  801fe4:	6a 00                	push   $0x0
  801fe6:	6a 00                	push   $0x0
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 00                	push   $0x0
  801fec:	6a 2c                	push   $0x2c
  801fee:	e8 ad fa ff ff       	call   801aa0 <syscall>
  801ff3:	83 c4 18             	add    $0x18,%esp
  801ff6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801ff9:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801ffd:	75 07                	jne    802006 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801fff:	b8 01 00 00 00       	mov    $0x1,%eax
  802004:	eb 05                	jmp    80200b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802006:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80200b:	c9                   	leave  
  80200c:	c3                   	ret    

0080200d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80200d:	55                   	push   %ebp
  80200e:	89 e5                	mov    %esp,%ebp
  802010:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802013:	6a 00                	push   $0x0
  802015:	6a 00                	push   $0x0
  802017:	6a 00                	push   $0x0
  802019:	6a 00                	push   $0x0
  80201b:	6a 00                	push   $0x0
  80201d:	6a 2c                	push   $0x2c
  80201f:	e8 7c fa ff ff       	call   801aa0 <syscall>
  802024:	83 c4 18             	add    $0x18,%esp
  802027:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80202a:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80202e:	75 07                	jne    802037 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802030:	b8 01 00 00 00       	mov    $0x1,%eax
  802035:	eb 05                	jmp    80203c <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802037:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80203c:	c9                   	leave  
  80203d:	c3                   	ret    

0080203e <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80203e:	55                   	push   %ebp
  80203f:	89 e5                	mov    %esp,%ebp
  802041:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802044:	6a 00                	push   $0x0
  802046:	6a 00                	push   $0x0
  802048:	6a 00                	push   $0x0
  80204a:	6a 00                	push   $0x0
  80204c:	6a 00                	push   $0x0
  80204e:	6a 2c                	push   $0x2c
  802050:	e8 4b fa ff ff       	call   801aa0 <syscall>
  802055:	83 c4 18             	add    $0x18,%esp
  802058:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80205b:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80205f:	75 07                	jne    802068 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802061:	b8 01 00 00 00       	mov    $0x1,%eax
  802066:	eb 05                	jmp    80206d <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802068:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80206d:	c9                   	leave  
  80206e:	c3                   	ret    

0080206f <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80206f:	55                   	push   %ebp
  802070:	89 e5                	mov    %esp,%ebp
  802072:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802075:	6a 00                	push   $0x0
  802077:	6a 00                	push   $0x0
  802079:	6a 00                	push   $0x0
  80207b:	6a 00                	push   $0x0
  80207d:	6a 00                	push   $0x0
  80207f:	6a 2c                	push   $0x2c
  802081:	e8 1a fa ff ff       	call   801aa0 <syscall>
  802086:	83 c4 18             	add    $0x18,%esp
  802089:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80208c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802090:	75 07                	jne    802099 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802092:	b8 01 00 00 00       	mov    $0x1,%eax
  802097:	eb 05                	jmp    80209e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802099:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80209e:	c9                   	leave  
  80209f:	c3                   	ret    

008020a0 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8020a0:	55                   	push   %ebp
  8020a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8020a3:	6a 00                	push   $0x0
  8020a5:	6a 00                	push   $0x0
  8020a7:	6a 00                	push   $0x0
  8020a9:	6a 00                	push   $0x0
  8020ab:	ff 75 08             	pushl  0x8(%ebp)
  8020ae:	6a 2d                	push   $0x2d
  8020b0:	e8 eb f9 ff ff       	call   801aa0 <syscall>
  8020b5:	83 c4 18             	add    $0x18,%esp
	return ;
  8020b8:	90                   	nop
}
  8020b9:	c9                   	leave  
  8020ba:	c3                   	ret    

008020bb <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8020bb:	55                   	push   %ebp
  8020bc:	89 e5                	mov    %esp,%ebp
  8020be:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8020bf:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8020c2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8020cb:	6a 00                	push   $0x0
  8020cd:	53                   	push   %ebx
  8020ce:	51                   	push   %ecx
  8020cf:	52                   	push   %edx
  8020d0:	50                   	push   %eax
  8020d1:	6a 2e                	push   $0x2e
  8020d3:	e8 c8 f9 ff ff       	call   801aa0 <syscall>
  8020d8:	83 c4 18             	add    $0x18,%esp
}
  8020db:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8020de:	c9                   	leave  
  8020df:	c3                   	ret    

008020e0 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8020e0:	55                   	push   %ebp
  8020e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8020e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 00                	push   $0x0
  8020ef:	52                   	push   %edx
  8020f0:	50                   	push   %eax
  8020f1:	6a 2f                	push   $0x2f
  8020f3:	e8 a8 f9 ff ff       	call   801aa0 <syscall>
  8020f8:	83 c4 18             	add    $0x18,%esp
}
  8020fb:	c9                   	leave  
  8020fc:	c3                   	ret    

008020fd <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8020fd:	55                   	push   %ebp
  8020fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  802100:	6a 00                	push   $0x0
  802102:	6a 00                	push   $0x0
  802104:	6a 00                	push   $0x0
  802106:	ff 75 0c             	pushl  0xc(%ebp)
  802109:	ff 75 08             	pushl  0x8(%ebp)
  80210c:	6a 30                	push   $0x30
  80210e:	e8 8d f9 ff ff       	call   801aa0 <syscall>
  802113:	83 c4 18             	add    $0x18,%esp
	return ;
  802116:	90                   	nop
}
  802117:	c9                   	leave  
  802118:	c3                   	ret    
  802119:	66 90                	xchg   %ax,%ax
  80211b:	90                   	nop

0080211c <__udivdi3>:
  80211c:	55                   	push   %ebp
  80211d:	57                   	push   %edi
  80211e:	56                   	push   %esi
  80211f:	53                   	push   %ebx
  802120:	83 ec 1c             	sub    $0x1c,%esp
  802123:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802127:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80212b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80212f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802133:	89 ca                	mov    %ecx,%edx
  802135:	89 f8                	mov    %edi,%eax
  802137:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80213b:	85 f6                	test   %esi,%esi
  80213d:	75 2d                	jne    80216c <__udivdi3+0x50>
  80213f:	39 cf                	cmp    %ecx,%edi
  802141:	77 65                	ja     8021a8 <__udivdi3+0x8c>
  802143:	89 fd                	mov    %edi,%ebp
  802145:	85 ff                	test   %edi,%edi
  802147:	75 0b                	jne    802154 <__udivdi3+0x38>
  802149:	b8 01 00 00 00       	mov    $0x1,%eax
  80214e:	31 d2                	xor    %edx,%edx
  802150:	f7 f7                	div    %edi
  802152:	89 c5                	mov    %eax,%ebp
  802154:	31 d2                	xor    %edx,%edx
  802156:	89 c8                	mov    %ecx,%eax
  802158:	f7 f5                	div    %ebp
  80215a:	89 c1                	mov    %eax,%ecx
  80215c:	89 d8                	mov    %ebx,%eax
  80215e:	f7 f5                	div    %ebp
  802160:	89 cf                	mov    %ecx,%edi
  802162:	89 fa                	mov    %edi,%edx
  802164:	83 c4 1c             	add    $0x1c,%esp
  802167:	5b                   	pop    %ebx
  802168:	5e                   	pop    %esi
  802169:	5f                   	pop    %edi
  80216a:	5d                   	pop    %ebp
  80216b:	c3                   	ret    
  80216c:	39 ce                	cmp    %ecx,%esi
  80216e:	77 28                	ja     802198 <__udivdi3+0x7c>
  802170:	0f bd fe             	bsr    %esi,%edi
  802173:	83 f7 1f             	xor    $0x1f,%edi
  802176:	75 40                	jne    8021b8 <__udivdi3+0x9c>
  802178:	39 ce                	cmp    %ecx,%esi
  80217a:	72 0a                	jb     802186 <__udivdi3+0x6a>
  80217c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802180:	0f 87 9e 00 00 00    	ja     802224 <__udivdi3+0x108>
  802186:	b8 01 00 00 00       	mov    $0x1,%eax
  80218b:	89 fa                	mov    %edi,%edx
  80218d:	83 c4 1c             	add    $0x1c,%esp
  802190:	5b                   	pop    %ebx
  802191:	5e                   	pop    %esi
  802192:	5f                   	pop    %edi
  802193:	5d                   	pop    %ebp
  802194:	c3                   	ret    
  802195:	8d 76 00             	lea    0x0(%esi),%esi
  802198:	31 ff                	xor    %edi,%edi
  80219a:	31 c0                	xor    %eax,%eax
  80219c:	89 fa                	mov    %edi,%edx
  80219e:	83 c4 1c             	add    $0x1c,%esp
  8021a1:	5b                   	pop    %ebx
  8021a2:	5e                   	pop    %esi
  8021a3:	5f                   	pop    %edi
  8021a4:	5d                   	pop    %ebp
  8021a5:	c3                   	ret    
  8021a6:	66 90                	xchg   %ax,%ax
  8021a8:	89 d8                	mov    %ebx,%eax
  8021aa:	f7 f7                	div    %edi
  8021ac:	31 ff                	xor    %edi,%edi
  8021ae:	89 fa                	mov    %edi,%edx
  8021b0:	83 c4 1c             	add    $0x1c,%esp
  8021b3:	5b                   	pop    %ebx
  8021b4:	5e                   	pop    %esi
  8021b5:	5f                   	pop    %edi
  8021b6:	5d                   	pop    %ebp
  8021b7:	c3                   	ret    
  8021b8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8021bd:	89 eb                	mov    %ebp,%ebx
  8021bf:	29 fb                	sub    %edi,%ebx
  8021c1:	89 f9                	mov    %edi,%ecx
  8021c3:	d3 e6                	shl    %cl,%esi
  8021c5:	89 c5                	mov    %eax,%ebp
  8021c7:	88 d9                	mov    %bl,%cl
  8021c9:	d3 ed                	shr    %cl,%ebp
  8021cb:	89 e9                	mov    %ebp,%ecx
  8021cd:	09 f1                	or     %esi,%ecx
  8021cf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8021d3:	89 f9                	mov    %edi,%ecx
  8021d5:	d3 e0                	shl    %cl,%eax
  8021d7:	89 c5                	mov    %eax,%ebp
  8021d9:	89 d6                	mov    %edx,%esi
  8021db:	88 d9                	mov    %bl,%cl
  8021dd:	d3 ee                	shr    %cl,%esi
  8021df:	89 f9                	mov    %edi,%ecx
  8021e1:	d3 e2                	shl    %cl,%edx
  8021e3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021e7:	88 d9                	mov    %bl,%cl
  8021e9:	d3 e8                	shr    %cl,%eax
  8021eb:	09 c2                	or     %eax,%edx
  8021ed:	89 d0                	mov    %edx,%eax
  8021ef:	89 f2                	mov    %esi,%edx
  8021f1:	f7 74 24 0c          	divl   0xc(%esp)
  8021f5:	89 d6                	mov    %edx,%esi
  8021f7:	89 c3                	mov    %eax,%ebx
  8021f9:	f7 e5                	mul    %ebp
  8021fb:	39 d6                	cmp    %edx,%esi
  8021fd:	72 19                	jb     802218 <__udivdi3+0xfc>
  8021ff:	74 0b                	je     80220c <__udivdi3+0xf0>
  802201:	89 d8                	mov    %ebx,%eax
  802203:	31 ff                	xor    %edi,%edi
  802205:	e9 58 ff ff ff       	jmp    802162 <__udivdi3+0x46>
  80220a:	66 90                	xchg   %ax,%ax
  80220c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802210:	89 f9                	mov    %edi,%ecx
  802212:	d3 e2                	shl    %cl,%edx
  802214:	39 c2                	cmp    %eax,%edx
  802216:	73 e9                	jae    802201 <__udivdi3+0xe5>
  802218:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80221b:	31 ff                	xor    %edi,%edi
  80221d:	e9 40 ff ff ff       	jmp    802162 <__udivdi3+0x46>
  802222:	66 90                	xchg   %ax,%ax
  802224:	31 c0                	xor    %eax,%eax
  802226:	e9 37 ff ff ff       	jmp    802162 <__udivdi3+0x46>
  80222b:	90                   	nop

0080222c <__umoddi3>:
  80222c:	55                   	push   %ebp
  80222d:	57                   	push   %edi
  80222e:	56                   	push   %esi
  80222f:	53                   	push   %ebx
  802230:	83 ec 1c             	sub    $0x1c,%esp
  802233:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802237:	8b 74 24 34          	mov    0x34(%esp),%esi
  80223b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80223f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802243:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802247:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80224b:	89 f3                	mov    %esi,%ebx
  80224d:	89 fa                	mov    %edi,%edx
  80224f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802253:	89 34 24             	mov    %esi,(%esp)
  802256:	85 c0                	test   %eax,%eax
  802258:	75 1a                	jne    802274 <__umoddi3+0x48>
  80225a:	39 f7                	cmp    %esi,%edi
  80225c:	0f 86 a2 00 00 00    	jbe    802304 <__umoddi3+0xd8>
  802262:	89 c8                	mov    %ecx,%eax
  802264:	89 f2                	mov    %esi,%edx
  802266:	f7 f7                	div    %edi
  802268:	89 d0                	mov    %edx,%eax
  80226a:	31 d2                	xor    %edx,%edx
  80226c:	83 c4 1c             	add    $0x1c,%esp
  80226f:	5b                   	pop    %ebx
  802270:	5e                   	pop    %esi
  802271:	5f                   	pop    %edi
  802272:	5d                   	pop    %ebp
  802273:	c3                   	ret    
  802274:	39 f0                	cmp    %esi,%eax
  802276:	0f 87 ac 00 00 00    	ja     802328 <__umoddi3+0xfc>
  80227c:	0f bd e8             	bsr    %eax,%ebp
  80227f:	83 f5 1f             	xor    $0x1f,%ebp
  802282:	0f 84 ac 00 00 00    	je     802334 <__umoddi3+0x108>
  802288:	bf 20 00 00 00       	mov    $0x20,%edi
  80228d:	29 ef                	sub    %ebp,%edi
  80228f:	89 fe                	mov    %edi,%esi
  802291:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802295:	89 e9                	mov    %ebp,%ecx
  802297:	d3 e0                	shl    %cl,%eax
  802299:	89 d7                	mov    %edx,%edi
  80229b:	89 f1                	mov    %esi,%ecx
  80229d:	d3 ef                	shr    %cl,%edi
  80229f:	09 c7                	or     %eax,%edi
  8022a1:	89 e9                	mov    %ebp,%ecx
  8022a3:	d3 e2                	shl    %cl,%edx
  8022a5:	89 14 24             	mov    %edx,(%esp)
  8022a8:	89 d8                	mov    %ebx,%eax
  8022aa:	d3 e0                	shl    %cl,%eax
  8022ac:	89 c2                	mov    %eax,%edx
  8022ae:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022b2:	d3 e0                	shl    %cl,%eax
  8022b4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8022b8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022bc:	89 f1                	mov    %esi,%ecx
  8022be:	d3 e8                	shr    %cl,%eax
  8022c0:	09 d0                	or     %edx,%eax
  8022c2:	d3 eb                	shr    %cl,%ebx
  8022c4:	89 da                	mov    %ebx,%edx
  8022c6:	f7 f7                	div    %edi
  8022c8:	89 d3                	mov    %edx,%ebx
  8022ca:	f7 24 24             	mull   (%esp)
  8022cd:	89 c6                	mov    %eax,%esi
  8022cf:	89 d1                	mov    %edx,%ecx
  8022d1:	39 d3                	cmp    %edx,%ebx
  8022d3:	0f 82 87 00 00 00    	jb     802360 <__umoddi3+0x134>
  8022d9:	0f 84 91 00 00 00    	je     802370 <__umoddi3+0x144>
  8022df:	8b 54 24 04          	mov    0x4(%esp),%edx
  8022e3:	29 f2                	sub    %esi,%edx
  8022e5:	19 cb                	sbb    %ecx,%ebx
  8022e7:	89 d8                	mov    %ebx,%eax
  8022e9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8022ed:	d3 e0                	shl    %cl,%eax
  8022ef:	89 e9                	mov    %ebp,%ecx
  8022f1:	d3 ea                	shr    %cl,%edx
  8022f3:	09 d0                	or     %edx,%eax
  8022f5:	89 e9                	mov    %ebp,%ecx
  8022f7:	d3 eb                	shr    %cl,%ebx
  8022f9:	89 da                	mov    %ebx,%edx
  8022fb:	83 c4 1c             	add    $0x1c,%esp
  8022fe:	5b                   	pop    %ebx
  8022ff:	5e                   	pop    %esi
  802300:	5f                   	pop    %edi
  802301:	5d                   	pop    %ebp
  802302:	c3                   	ret    
  802303:	90                   	nop
  802304:	89 fd                	mov    %edi,%ebp
  802306:	85 ff                	test   %edi,%edi
  802308:	75 0b                	jne    802315 <__umoddi3+0xe9>
  80230a:	b8 01 00 00 00       	mov    $0x1,%eax
  80230f:	31 d2                	xor    %edx,%edx
  802311:	f7 f7                	div    %edi
  802313:	89 c5                	mov    %eax,%ebp
  802315:	89 f0                	mov    %esi,%eax
  802317:	31 d2                	xor    %edx,%edx
  802319:	f7 f5                	div    %ebp
  80231b:	89 c8                	mov    %ecx,%eax
  80231d:	f7 f5                	div    %ebp
  80231f:	89 d0                	mov    %edx,%eax
  802321:	e9 44 ff ff ff       	jmp    80226a <__umoddi3+0x3e>
  802326:	66 90                	xchg   %ax,%ax
  802328:	89 c8                	mov    %ecx,%eax
  80232a:	89 f2                	mov    %esi,%edx
  80232c:	83 c4 1c             	add    $0x1c,%esp
  80232f:	5b                   	pop    %ebx
  802330:	5e                   	pop    %esi
  802331:	5f                   	pop    %edi
  802332:	5d                   	pop    %ebp
  802333:	c3                   	ret    
  802334:	3b 04 24             	cmp    (%esp),%eax
  802337:	72 06                	jb     80233f <__umoddi3+0x113>
  802339:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80233d:	77 0f                	ja     80234e <__umoddi3+0x122>
  80233f:	89 f2                	mov    %esi,%edx
  802341:	29 f9                	sub    %edi,%ecx
  802343:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802347:	89 14 24             	mov    %edx,(%esp)
  80234a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80234e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802352:	8b 14 24             	mov    (%esp),%edx
  802355:	83 c4 1c             	add    $0x1c,%esp
  802358:	5b                   	pop    %ebx
  802359:	5e                   	pop    %esi
  80235a:	5f                   	pop    %edi
  80235b:	5d                   	pop    %ebp
  80235c:	c3                   	ret    
  80235d:	8d 76 00             	lea    0x0(%esi),%esi
  802360:	2b 04 24             	sub    (%esp),%eax
  802363:	19 fa                	sbb    %edi,%edx
  802365:	89 d1                	mov    %edx,%ecx
  802367:	89 c6                	mov    %eax,%esi
  802369:	e9 71 ff ff ff       	jmp    8022df <__umoddi3+0xb3>
  80236e:	66 90                	xchg   %ax,%ax
  802370:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802374:	72 ea                	jb     802360 <__umoddi3+0x134>
  802376:	89 d9                	mov    %ebx,%ecx
  802378:	e9 62 ff ff ff       	jmp    8022df <__umoddi3+0xb3>
