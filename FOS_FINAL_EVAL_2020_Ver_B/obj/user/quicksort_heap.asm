
obj/user/quicksort_heap:     file format elf32-i386


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
  800031:	e8 1f 06 00 00       	call   800655 <libmain>
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
  800041:	e8 68 1d 00 00       	call   801dae <sys_disable_interrupt>
		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 60 24 80 00       	push   $0x802460
  80004e:	e8 de 09 00 00       	call   800a31 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 62 24 80 00       	push   $0x802462
  80005e:	e8 ce 09 00 00       	call   800a31 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!   QUICK SORT   !!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 7b 24 80 00       	push   $0x80247b
  80006e:	e8 be 09 00 00       	call   800a31 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 62 24 80 00       	push   $0x802462
  80007e:	e8 ae 09 00 00       	call   800a31 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 60 24 80 00       	push   $0x802460
  80008e:	e8 9e 09 00 00       	call   800a31 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp

		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 94 24 80 00       	push   $0x802494
  8000a5:	e8 09 10 00 00       	call   8010b3 <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 59 15 00 00       	call   801619 <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = __new(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 42 1a 00 00       	call   801b17 <__new>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 b4 24 80 00       	push   $0x8024b4
  8000e3:	e8 49 09 00 00       	call   800a31 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 d6 24 80 00       	push   $0x8024d6
  8000f3:	e8 39 09 00 00       	call   800a31 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 e4 24 80 00       	push   $0x8024e4
  800103:	e8 29 09 00 00       	call   800a31 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 f3 24 80 00       	push   $0x8024f3
  800113:	e8 19 09 00 00       	call   800a31 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 03 25 80 00       	push   $0x802503
  800123:	e8 09 09 00 00       	call   800a31 <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 cd 04 00 00       	call   8005fd <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 75 04 00 00       	call   8005b5 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 68 04 00 00       	call   8005b5 <cputchar>
  80014d:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800150:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800154:	74 0c                	je     800162 <_main+0x12a>
  800156:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  80015a:	74 06                	je     800162 <_main+0x12a>
  80015c:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800160:	75 b9                	jne    80011b <_main+0xe3>
		//2012: lock the interrupt
		sys_enable_interrupt();
  800162:	e8 61 1c 00 00       	call   801dc8 <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  800167:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
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
  80017d:	ff 75 f0             	pushl  -0x10(%ebp)
  800180:	ff 75 ec             	pushl  -0x14(%ebp)
  800183:	e8 f5 02 00 00       	call   80047d <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f0             	pushl  -0x10(%ebp)
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	e8 13 03 00 00       	call   8004ae <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	e8 35 03 00 00       	call   8004e3 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	e8 22 03 00 00       	call   8004e3 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cd:	e8 f0 00 00 00       	call   8002c2 <QuickSort>
  8001d2:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001d5:	e8 d4 1b 00 00       	call   801dae <sys_disable_interrupt>
			cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001da:	83 ec 0c             	sub    $0xc,%esp
  8001dd:	68 0c 25 80 00       	push   $0x80250c
  8001e2:	e8 4a 08 00 00       	call   800a31 <cprintf>
  8001e7:	83 c4 10             	add    $0x10,%esp
		//		PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ea:	e8 d9 1b 00 00       	call   801dc8 <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001ef:	83 ec 08             	sub    $0x8,%esp
  8001f2:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f5:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f8:	e8 d6 01 00 00       	call   8003d3 <CheckSorted>
  8001fd:	83 c4 10             	add    $0x10,%esp
  800200:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800203:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800207:	75 14                	jne    80021d <_main+0x1e5>
  800209:	83 ec 04             	sub    $0x4,%esp
  80020c:	68 40 25 80 00       	push   $0x802540
  800211:	6a 48                	push   $0x48
  800213:	68 62 25 80 00       	push   $0x802562
  800218:	e8 5d 05 00 00       	call   80077a <_panic>
		else
		{
			sys_disable_interrupt();
  80021d:	e8 8c 1b 00 00       	call   801dae <sys_disable_interrupt>
			cprintf("\n===============================================\n") ;
  800222:	83 ec 0c             	sub    $0xc,%esp
  800225:	68 78 25 80 00       	push   $0x802578
  80022a:	e8 02 08 00 00       	call   800a31 <cprintf>
  80022f:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800232:	83 ec 0c             	sub    $0xc,%esp
  800235:	68 ac 25 80 00       	push   $0x8025ac
  80023a:	e8 f2 07 00 00       	call   800a31 <cprintf>
  80023f:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800242:	83 ec 0c             	sub    $0xc,%esp
  800245:	68 e0 25 80 00       	push   $0x8025e0
  80024a:	e8 e2 07 00 00       	call   800a31 <cprintf>
  80024f:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800252:	e8 71 1b 00 00       	call   801dc8 <sys_enable_interrupt>
		}

		sys_disable_interrupt();
  800257:	e8 52 1b 00 00       	call   801dae <sys_disable_interrupt>
			Chose = 0 ;
  80025c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800260:	eb 42                	jmp    8002a4 <_main+0x26c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800262:	83 ec 0c             	sub    $0xc,%esp
  800265:	68 12 26 80 00       	push   $0x802612
  80026a:	e8 c2 07 00 00       	call   800a31 <cprintf>
  80026f:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800272:	e8 86 03 00 00       	call   8005fd <getchar>
  800277:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80027a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80027e:	83 ec 0c             	sub    $0xc,%esp
  800281:	50                   	push   %eax
  800282:	e8 2e 03 00 00       	call   8005b5 <cputchar>
  800287:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80028a:	83 ec 0c             	sub    $0xc,%esp
  80028d:	6a 0a                	push   $0xa
  80028f:	e8 21 03 00 00       	call   8005b5 <cputchar>
  800294:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800297:	83 ec 0c             	sub    $0xc,%esp
  80029a:	6a 0a                	push   $0xa
  80029c:	e8 14 03 00 00       	call   8005b5 <cputchar>
  8002a1:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
		}

		sys_disable_interrupt();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002a4:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002a8:	74 06                	je     8002b0 <_main+0x278>
  8002aa:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002ae:	75 b2                	jne    800262 <_main+0x22a>
				Chose = getchar() ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_enable_interrupt();
  8002b0:	e8 13 1b 00 00       	call   801dc8 <sys_enable_interrupt>

	} while (Chose == 'y');
  8002b5:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002b9:	0f 84 82 fd ff ff    	je     800041 <_main+0x9>

}
  8002bf:	90                   	nop
  8002c0:	c9                   	leave  
  8002c1:	c3                   	ret    

008002c2 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8002c2:	55                   	push   %ebp
  8002c3:	89 e5                	mov    %esp,%ebp
  8002c5:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8002c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002cb:	48                   	dec    %eax
  8002cc:	50                   	push   %eax
  8002cd:	6a 00                	push   $0x0
  8002cf:	ff 75 0c             	pushl  0xc(%ebp)
  8002d2:	ff 75 08             	pushl  0x8(%ebp)
  8002d5:	e8 06 00 00 00       	call   8002e0 <QSort>
  8002da:	83 c4 10             	add    $0x10,%esp
}
  8002dd:	90                   	nop
  8002de:	c9                   	leave  
  8002df:	c3                   	ret    

008002e0 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8002e0:	55                   	push   %ebp
  8002e1:	89 e5                	mov    %esp,%ebp
  8002e3:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8002e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e9:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002ec:	0f 8d de 00 00 00    	jge    8003d0 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8002f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8002f5:	40                   	inc    %eax
  8002f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8002fc:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002ff:	e9 80 00 00 00       	jmp    800384 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800304:	ff 45 f4             	incl   -0xc(%ebp)
  800307:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80030a:	3b 45 14             	cmp    0x14(%ebp),%eax
  80030d:	7f 2b                	jg     80033a <QSort+0x5a>
  80030f:	8b 45 10             	mov    0x10(%ebp),%eax
  800312:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800319:	8b 45 08             	mov    0x8(%ebp),%eax
  80031c:	01 d0                	add    %edx,%eax
  80031e:	8b 10                	mov    (%eax),%edx
  800320:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800323:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80032a:	8b 45 08             	mov    0x8(%ebp),%eax
  80032d:	01 c8                	add    %ecx,%eax
  80032f:	8b 00                	mov    (%eax),%eax
  800331:	39 c2                	cmp    %eax,%edx
  800333:	7d cf                	jge    800304 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800335:	eb 03                	jmp    80033a <QSort+0x5a>
  800337:	ff 4d f0             	decl   -0x10(%ebp)
  80033a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80033d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800340:	7e 26                	jle    800368 <QSort+0x88>
  800342:	8b 45 10             	mov    0x10(%ebp),%eax
  800345:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80034c:	8b 45 08             	mov    0x8(%ebp),%eax
  80034f:	01 d0                	add    %edx,%eax
  800351:	8b 10                	mov    (%eax),%edx
  800353:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800356:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80035d:	8b 45 08             	mov    0x8(%ebp),%eax
  800360:	01 c8                	add    %ecx,%eax
  800362:	8b 00                	mov    (%eax),%eax
  800364:	39 c2                	cmp    %eax,%edx
  800366:	7e cf                	jle    800337 <QSort+0x57>

		if (i <= j)
  800368:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80036b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80036e:	7f 14                	jg     800384 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800370:	83 ec 04             	sub    $0x4,%esp
  800373:	ff 75 f0             	pushl  -0x10(%ebp)
  800376:	ff 75 f4             	pushl  -0xc(%ebp)
  800379:	ff 75 08             	pushl  0x8(%ebp)
  80037c:	e8 a9 00 00 00       	call   80042a <Swap>
  800381:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800384:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800387:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80038a:	0f 8e 77 ff ff ff    	jle    800307 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800390:	83 ec 04             	sub    $0x4,%esp
  800393:	ff 75 f0             	pushl  -0x10(%ebp)
  800396:	ff 75 10             	pushl  0x10(%ebp)
  800399:	ff 75 08             	pushl  0x8(%ebp)
  80039c:	e8 89 00 00 00       	call   80042a <Swap>
  8003a1:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8003a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a7:	48                   	dec    %eax
  8003a8:	50                   	push   %eax
  8003a9:	ff 75 10             	pushl  0x10(%ebp)
  8003ac:	ff 75 0c             	pushl  0xc(%ebp)
  8003af:	ff 75 08             	pushl  0x8(%ebp)
  8003b2:	e8 29 ff ff ff       	call   8002e0 <QSort>
  8003b7:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8003ba:	ff 75 14             	pushl  0x14(%ebp)
  8003bd:	ff 75 f4             	pushl  -0xc(%ebp)
  8003c0:	ff 75 0c             	pushl  0xc(%ebp)
  8003c3:	ff 75 08             	pushl  0x8(%ebp)
  8003c6:	e8 15 ff ff ff       	call   8002e0 <QSort>
  8003cb:	83 c4 10             	add    $0x10,%esp
  8003ce:	eb 01                	jmp    8003d1 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8003d0:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  8003d1:	c9                   	leave  
  8003d2:	c3                   	ret    

008003d3 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8003d3:	55                   	push   %ebp
  8003d4:	89 e5                	mov    %esp,%ebp
  8003d6:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8003d9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003e0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8003e7:	eb 33                	jmp    80041c <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8003e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f6:	01 d0                	add    %edx,%eax
  8003f8:	8b 10                	mov    (%eax),%edx
  8003fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003fd:	40                   	inc    %eax
  8003fe:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800405:	8b 45 08             	mov    0x8(%ebp),%eax
  800408:	01 c8                	add    %ecx,%eax
  80040a:	8b 00                	mov    (%eax),%eax
  80040c:	39 c2                	cmp    %eax,%edx
  80040e:	7e 09                	jle    800419 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800410:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800417:	eb 0c                	jmp    800425 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800419:	ff 45 f8             	incl   -0x8(%ebp)
  80041c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80041f:	48                   	dec    %eax
  800420:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800423:	7f c4                	jg     8003e9 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800425:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800428:	c9                   	leave  
  800429:	c3                   	ret    

0080042a <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80042a:	55                   	push   %ebp
  80042b:	89 e5                	mov    %esp,%ebp
  80042d:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800430:	8b 45 0c             	mov    0xc(%ebp),%eax
  800433:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043a:	8b 45 08             	mov    0x8(%ebp),%eax
  80043d:	01 d0                	add    %edx,%eax
  80043f:	8b 00                	mov    (%eax),%eax
  800441:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800444:	8b 45 0c             	mov    0xc(%ebp),%eax
  800447:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80044e:	8b 45 08             	mov    0x8(%ebp),%eax
  800451:	01 c2                	add    %eax,%edx
  800453:	8b 45 10             	mov    0x10(%ebp),%eax
  800456:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	01 c8                	add    %ecx,%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800466:	8b 45 10             	mov    0x10(%ebp),%eax
  800469:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800470:	8b 45 08             	mov    0x8(%ebp),%eax
  800473:	01 c2                	add    %eax,%edx
  800475:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800478:	89 02                	mov    %eax,(%edx)
}
  80047a:	90                   	nop
  80047b:	c9                   	leave  
  80047c:	c3                   	ret    

0080047d <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80047d:	55                   	push   %ebp
  80047e:	89 e5                	mov    %esp,%ebp
  800480:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800483:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80048a:	eb 17                	jmp    8004a3 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80048c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80048f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800496:	8b 45 08             	mov    0x8(%ebp),%eax
  800499:	01 c2                	add    %eax,%edx
  80049b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049e:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004a0:	ff 45 fc             	incl   -0x4(%ebp)
  8004a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004a6:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004a9:	7c e1                	jl     80048c <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8004ab:	90                   	nop
  8004ac:	c9                   	leave  
  8004ad:	c3                   	ret    

008004ae <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8004ae:	55                   	push   %ebp
  8004af:	89 e5                	mov    %esp,%ebp
  8004b1:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004bb:	eb 1b                	jmp    8004d8 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8004bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004c0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ca:	01 c2                	add    %eax,%edx
  8004cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004cf:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8004d2:	48                   	dec    %eax
  8004d3:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004d5:	ff 45 fc             	incl   -0x4(%ebp)
  8004d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004db:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004de:	7c dd                	jl     8004bd <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8004e0:	90                   	nop
  8004e1:	c9                   	leave  
  8004e2:	c3                   	ret    

008004e3 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8004e3:	55                   	push   %ebp
  8004e4:	89 e5                	mov    %esp,%ebp
  8004e6:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8004e9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004ec:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8004f1:	f7 e9                	imul   %ecx
  8004f3:	c1 f9 1f             	sar    $0x1f,%ecx
  8004f6:	89 d0                	mov    %edx,%eax
  8004f8:	29 c8                	sub    %ecx,%eax
  8004fa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800504:	eb 1e                	jmp    800524 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800506:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800509:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800510:	8b 45 08             	mov    0x8(%ebp),%eax
  800513:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800516:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800519:	99                   	cltd   
  80051a:	f7 7d f8             	idivl  -0x8(%ebp)
  80051d:	89 d0                	mov    %edx,%eax
  80051f:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800521:	ff 45 fc             	incl   -0x4(%ebp)
  800524:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800527:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80052a:	7c da                	jl     800506 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80052c:	90                   	nop
  80052d:	c9                   	leave  
  80052e:	c3                   	ret    

0080052f <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80052f:	55                   	push   %ebp
  800530:	89 e5                	mov    %esp,%ebp
  800532:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800535:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80053c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800543:	eb 42                	jmp    800587 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800545:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800548:	99                   	cltd   
  800549:	f7 7d f0             	idivl  -0x10(%ebp)
  80054c:	89 d0                	mov    %edx,%eax
  80054e:	85 c0                	test   %eax,%eax
  800550:	75 10                	jne    800562 <PrintElements+0x33>
			cprintf("\n");
  800552:	83 ec 0c             	sub    $0xc,%esp
  800555:	68 60 24 80 00       	push   $0x802460
  80055a:	e8 d2 04 00 00       	call   800a31 <cprintf>
  80055f:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800562:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800565:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80056c:	8b 45 08             	mov    0x8(%ebp),%eax
  80056f:	01 d0                	add    %edx,%eax
  800571:	8b 00                	mov    (%eax),%eax
  800573:	83 ec 08             	sub    $0x8,%esp
  800576:	50                   	push   %eax
  800577:	68 30 26 80 00       	push   $0x802630
  80057c:	e8 b0 04 00 00       	call   800a31 <cprintf>
  800581:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800584:	ff 45 f4             	incl   -0xc(%ebp)
  800587:	8b 45 0c             	mov    0xc(%ebp),%eax
  80058a:	48                   	dec    %eax
  80058b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80058e:	7f b5                	jg     800545 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800590:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800593:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80059a:	8b 45 08             	mov    0x8(%ebp),%eax
  80059d:	01 d0                	add    %edx,%eax
  80059f:	8b 00                	mov    (%eax),%eax
  8005a1:	83 ec 08             	sub    $0x8,%esp
  8005a4:	50                   	push   %eax
  8005a5:	68 35 26 80 00       	push   $0x802635
  8005aa:	e8 82 04 00 00       	call   800a31 <cprintf>
  8005af:	83 c4 10             	add    $0x10,%esp

}
  8005b2:	90                   	nop
  8005b3:	c9                   	leave  
  8005b4:	c3                   	ret    

008005b5 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8005b5:	55                   	push   %ebp
  8005b6:	89 e5                	mov    %esp,%ebp
  8005b8:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8005bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005be:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005c1:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005c5:	83 ec 0c             	sub    $0xc,%esp
  8005c8:	50                   	push   %eax
  8005c9:	e8 14 18 00 00       	call   801de2 <sys_cputc>
  8005ce:	83 c4 10             	add    $0x10,%esp
}
  8005d1:	90                   	nop
  8005d2:	c9                   	leave  
  8005d3:	c3                   	ret    

008005d4 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8005d4:	55                   	push   %ebp
  8005d5:	89 e5                	mov    %esp,%ebp
  8005d7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005da:	e8 cf 17 00 00       	call   801dae <sys_disable_interrupt>
	char c = ch;
  8005df:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e2:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005e5:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005e9:	83 ec 0c             	sub    $0xc,%esp
  8005ec:	50                   	push   %eax
  8005ed:	e8 f0 17 00 00       	call   801de2 <sys_cputc>
  8005f2:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8005f5:	e8 ce 17 00 00       	call   801dc8 <sys_enable_interrupt>
}
  8005fa:	90                   	nop
  8005fb:	c9                   	leave  
  8005fc:	c3                   	ret    

008005fd <getchar>:

int
getchar(void)
{
  8005fd:	55                   	push   %ebp
  8005fe:	89 e5                	mov    %esp,%ebp
  800600:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800603:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80060a:	eb 08                	jmp    800614 <getchar+0x17>
	{
		c = sys_cgetc();
  80060c:	e8 b5 15 00 00       	call   801bc6 <sys_cgetc>
  800611:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800614:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800618:	74 f2                	je     80060c <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80061a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80061d:	c9                   	leave  
  80061e:	c3                   	ret    

0080061f <atomic_getchar>:

int
atomic_getchar(void)
{
  80061f:	55                   	push   %ebp
  800620:	89 e5                	mov    %esp,%ebp
  800622:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800625:	e8 84 17 00 00       	call   801dae <sys_disable_interrupt>
	int c=0;
  80062a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800631:	eb 08                	jmp    80063b <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800633:	e8 8e 15 00 00       	call   801bc6 <sys_cgetc>
  800638:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80063b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80063f:	74 f2                	je     800633 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800641:	e8 82 17 00 00       	call   801dc8 <sys_enable_interrupt>
	return c;
  800646:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800649:	c9                   	leave  
  80064a:	c3                   	ret    

0080064b <iscons>:

int iscons(int fdnum)
{
  80064b:	55                   	push   %ebp
  80064c:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80064e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800653:	5d                   	pop    %ebp
  800654:	c3                   	ret    

00800655 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800655:	55                   	push   %ebp
  800656:	89 e5                	mov    %esp,%ebp
  800658:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80065b:	e8 b3 15 00 00       	call   801c13 <sys_getenvindex>
  800660:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800663:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800666:	89 d0                	mov    %edx,%eax
  800668:	c1 e0 03             	shl    $0x3,%eax
  80066b:	01 d0                	add    %edx,%eax
  80066d:	c1 e0 02             	shl    $0x2,%eax
  800670:	01 d0                	add    %edx,%eax
  800672:	c1 e0 06             	shl    $0x6,%eax
  800675:	29 d0                	sub    %edx,%eax
  800677:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80067e:	01 c8                	add    %ecx,%eax
  800680:	01 d0                	add    %edx,%eax
  800682:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800687:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80068c:	a1 24 30 80 00       	mov    0x803024,%eax
  800691:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  800697:	84 c0                	test   %al,%al
  800699:	74 0f                	je     8006aa <libmain+0x55>
		binaryname = myEnv->prog_name;
  80069b:	a1 24 30 80 00       	mov    0x803024,%eax
  8006a0:	05 b0 52 00 00       	add    $0x52b0,%eax
  8006a5:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006aa:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8006ae:	7e 0a                	jle    8006ba <libmain+0x65>
		binaryname = argv[0];
  8006b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006b3:	8b 00                	mov    (%eax),%eax
  8006b5:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8006ba:	83 ec 08             	sub    $0x8,%esp
  8006bd:	ff 75 0c             	pushl  0xc(%ebp)
  8006c0:	ff 75 08             	pushl  0x8(%ebp)
  8006c3:	e8 70 f9 ff ff       	call   800038 <_main>
  8006c8:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8006cb:	e8 de 16 00 00       	call   801dae <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006d0:	83 ec 0c             	sub    $0xc,%esp
  8006d3:	68 54 26 80 00       	push   $0x802654
  8006d8:	e8 54 03 00 00       	call   800a31 <cprintf>
  8006dd:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006e0:	a1 24 30 80 00       	mov    0x803024,%eax
  8006e5:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  8006eb:	a1 24 30 80 00       	mov    0x803024,%eax
  8006f0:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  8006f6:	83 ec 04             	sub    $0x4,%esp
  8006f9:	52                   	push   %edx
  8006fa:	50                   	push   %eax
  8006fb:	68 7c 26 80 00       	push   $0x80267c
  800700:	e8 2c 03 00 00       	call   800a31 <cprintf>
  800705:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800708:	a1 24 30 80 00       	mov    0x803024,%eax
  80070d:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  800713:	a1 24 30 80 00       	mov    0x803024,%eax
  800718:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  80071e:	a1 24 30 80 00       	mov    0x803024,%eax
  800723:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  800729:	51                   	push   %ecx
  80072a:	52                   	push   %edx
  80072b:	50                   	push   %eax
  80072c:	68 a4 26 80 00       	push   $0x8026a4
  800731:	e8 fb 02 00 00       	call   800a31 <cprintf>
  800736:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800739:	83 ec 0c             	sub    $0xc,%esp
  80073c:	68 54 26 80 00       	push   $0x802654
  800741:	e8 eb 02 00 00       	call   800a31 <cprintf>
  800746:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800749:	e8 7a 16 00 00       	call   801dc8 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80074e:	e8 19 00 00 00       	call   80076c <exit>
}
  800753:	90                   	nop
  800754:	c9                   	leave  
  800755:	c3                   	ret    

00800756 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800756:	55                   	push   %ebp
  800757:	89 e5                	mov    %esp,%ebp
  800759:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80075c:	83 ec 0c             	sub    $0xc,%esp
  80075f:	6a 00                	push   $0x0
  800761:	e8 79 14 00 00       	call   801bdf <sys_env_destroy>
  800766:	83 c4 10             	add    $0x10,%esp
}
  800769:	90                   	nop
  80076a:	c9                   	leave  
  80076b:	c3                   	ret    

0080076c <exit>:

void
exit(void)
{
  80076c:	55                   	push   %ebp
  80076d:	89 e5                	mov    %esp,%ebp
  80076f:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800772:	e8 ce 14 00 00       	call   801c45 <sys_env_exit>
}
  800777:	90                   	nop
  800778:	c9                   	leave  
  800779:	c3                   	ret    

0080077a <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80077a:	55                   	push   %ebp
  80077b:	89 e5                	mov    %esp,%ebp
  80077d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800780:	8d 45 10             	lea    0x10(%ebp),%eax
  800783:	83 c0 04             	add    $0x4,%eax
  800786:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800789:	a1 18 31 80 00       	mov    0x803118,%eax
  80078e:	85 c0                	test   %eax,%eax
  800790:	74 16                	je     8007a8 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800792:	a1 18 31 80 00       	mov    0x803118,%eax
  800797:	83 ec 08             	sub    $0x8,%esp
  80079a:	50                   	push   %eax
  80079b:	68 fc 26 80 00       	push   $0x8026fc
  8007a0:	e8 8c 02 00 00       	call   800a31 <cprintf>
  8007a5:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8007a8:	a1 00 30 80 00       	mov    0x803000,%eax
  8007ad:	ff 75 0c             	pushl  0xc(%ebp)
  8007b0:	ff 75 08             	pushl  0x8(%ebp)
  8007b3:	50                   	push   %eax
  8007b4:	68 01 27 80 00       	push   $0x802701
  8007b9:	e8 73 02 00 00       	call   800a31 <cprintf>
  8007be:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8007c4:	83 ec 08             	sub    $0x8,%esp
  8007c7:	ff 75 f4             	pushl  -0xc(%ebp)
  8007ca:	50                   	push   %eax
  8007cb:	e8 f6 01 00 00       	call   8009c6 <vcprintf>
  8007d0:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8007d3:	83 ec 08             	sub    $0x8,%esp
  8007d6:	6a 00                	push   $0x0
  8007d8:	68 1d 27 80 00       	push   $0x80271d
  8007dd:	e8 e4 01 00 00       	call   8009c6 <vcprintf>
  8007e2:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8007e5:	e8 82 ff ff ff       	call   80076c <exit>

	// should not return here
	while (1) ;
  8007ea:	eb fe                	jmp    8007ea <_panic+0x70>

008007ec <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007ec:	55                   	push   %ebp
  8007ed:	89 e5                	mov    %esp,%ebp
  8007ef:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007f2:	a1 24 30 80 00       	mov    0x803024,%eax
  8007f7:	8b 50 74             	mov    0x74(%eax),%edx
  8007fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007fd:	39 c2                	cmp    %eax,%edx
  8007ff:	74 14                	je     800815 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800801:	83 ec 04             	sub    $0x4,%esp
  800804:	68 20 27 80 00       	push   $0x802720
  800809:	6a 26                	push   $0x26
  80080b:	68 6c 27 80 00       	push   $0x80276c
  800810:	e8 65 ff ff ff       	call   80077a <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800815:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80081c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800823:	e9 c4 00 00 00       	jmp    8008ec <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800828:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80082b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800832:	8b 45 08             	mov    0x8(%ebp),%eax
  800835:	01 d0                	add    %edx,%eax
  800837:	8b 00                	mov    (%eax),%eax
  800839:	85 c0                	test   %eax,%eax
  80083b:	75 08                	jne    800845 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80083d:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800840:	e9 a4 00 00 00       	jmp    8008e9 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  800845:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80084c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800853:	eb 6b                	jmp    8008c0 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800855:	a1 24 30 80 00       	mov    0x803024,%eax
  80085a:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800860:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800863:	89 d0                	mov    %edx,%eax
  800865:	c1 e0 02             	shl    $0x2,%eax
  800868:	01 d0                	add    %edx,%eax
  80086a:	c1 e0 02             	shl    $0x2,%eax
  80086d:	01 c8                	add    %ecx,%eax
  80086f:	8a 40 04             	mov    0x4(%eax),%al
  800872:	84 c0                	test   %al,%al
  800874:	75 47                	jne    8008bd <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800876:	a1 24 30 80 00       	mov    0x803024,%eax
  80087b:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800881:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800884:	89 d0                	mov    %edx,%eax
  800886:	c1 e0 02             	shl    $0x2,%eax
  800889:	01 d0                	add    %edx,%eax
  80088b:	c1 e0 02             	shl    $0x2,%eax
  80088e:	01 c8                	add    %ecx,%eax
  800890:	8b 00                	mov    (%eax),%eax
  800892:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800895:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800898:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80089d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80089f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008a2:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8008a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ac:	01 c8                	add    %ecx,%eax
  8008ae:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008b0:	39 c2                	cmp    %eax,%edx
  8008b2:	75 09                	jne    8008bd <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  8008b4:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008bb:	eb 12                	jmp    8008cf <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008bd:	ff 45 e8             	incl   -0x18(%ebp)
  8008c0:	a1 24 30 80 00       	mov    0x803024,%eax
  8008c5:	8b 50 74             	mov    0x74(%eax),%edx
  8008c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008cb:	39 c2                	cmp    %eax,%edx
  8008cd:	77 86                	ja     800855 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008cf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8008d3:	75 14                	jne    8008e9 <CheckWSWithoutLastIndex+0xfd>
			panic(
  8008d5:	83 ec 04             	sub    $0x4,%esp
  8008d8:	68 78 27 80 00       	push   $0x802778
  8008dd:	6a 3a                	push   $0x3a
  8008df:	68 6c 27 80 00       	push   $0x80276c
  8008e4:	e8 91 fe ff ff       	call   80077a <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8008e9:	ff 45 f0             	incl   -0x10(%ebp)
  8008ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008ef:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008f2:	0f 8c 30 ff ff ff    	jl     800828 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008f8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008ff:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800906:	eb 27                	jmp    80092f <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800908:	a1 24 30 80 00       	mov    0x803024,%eax
  80090d:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800913:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800916:	89 d0                	mov    %edx,%eax
  800918:	c1 e0 02             	shl    $0x2,%eax
  80091b:	01 d0                	add    %edx,%eax
  80091d:	c1 e0 02             	shl    $0x2,%eax
  800920:	01 c8                	add    %ecx,%eax
  800922:	8a 40 04             	mov    0x4(%eax),%al
  800925:	3c 01                	cmp    $0x1,%al
  800927:	75 03                	jne    80092c <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800929:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80092c:	ff 45 e0             	incl   -0x20(%ebp)
  80092f:	a1 24 30 80 00       	mov    0x803024,%eax
  800934:	8b 50 74             	mov    0x74(%eax),%edx
  800937:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80093a:	39 c2                	cmp    %eax,%edx
  80093c:	77 ca                	ja     800908 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80093e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800941:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800944:	74 14                	je     80095a <CheckWSWithoutLastIndex+0x16e>
		panic(
  800946:	83 ec 04             	sub    $0x4,%esp
  800949:	68 cc 27 80 00       	push   $0x8027cc
  80094e:	6a 44                	push   $0x44
  800950:	68 6c 27 80 00       	push   $0x80276c
  800955:	e8 20 fe ff ff       	call   80077a <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80095a:	90                   	nop
  80095b:	c9                   	leave  
  80095c:	c3                   	ret    

0080095d <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80095d:	55                   	push   %ebp
  80095e:	89 e5                	mov    %esp,%ebp
  800960:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800963:	8b 45 0c             	mov    0xc(%ebp),%eax
  800966:	8b 00                	mov    (%eax),%eax
  800968:	8d 48 01             	lea    0x1(%eax),%ecx
  80096b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80096e:	89 0a                	mov    %ecx,(%edx)
  800970:	8b 55 08             	mov    0x8(%ebp),%edx
  800973:	88 d1                	mov    %dl,%cl
  800975:	8b 55 0c             	mov    0xc(%ebp),%edx
  800978:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80097c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80097f:	8b 00                	mov    (%eax),%eax
  800981:	3d ff 00 00 00       	cmp    $0xff,%eax
  800986:	75 2c                	jne    8009b4 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800988:	a0 28 30 80 00       	mov    0x803028,%al
  80098d:	0f b6 c0             	movzbl %al,%eax
  800990:	8b 55 0c             	mov    0xc(%ebp),%edx
  800993:	8b 12                	mov    (%edx),%edx
  800995:	89 d1                	mov    %edx,%ecx
  800997:	8b 55 0c             	mov    0xc(%ebp),%edx
  80099a:	83 c2 08             	add    $0x8,%edx
  80099d:	83 ec 04             	sub    $0x4,%esp
  8009a0:	50                   	push   %eax
  8009a1:	51                   	push   %ecx
  8009a2:	52                   	push   %edx
  8009a3:	e8 f5 11 00 00       	call   801b9d <sys_cputs>
  8009a8:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8009ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ae:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8009b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b7:	8b 40 04             	mov    0x4(%eax),%eax
  8009ba:	8d 50 01             	lea    0x1(%eax),%edx
  8009bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c0:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009c3:	90                   	nop
  8009c4:	c9                   	leave  
  8009c5:	c3                   	ret    

008009c6 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8009c6:	55                   	push   %ebp
  8009c7:	89 e5                	mov    %esp,%ebp
  8009c9:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009cf:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8009d6:	00 00 00 
	b.cnt = 0;
  8009d9:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8009e0:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8009e3:	ff 75 0c             	pushl  0xc(%ebp)
  8009e6:	ff 75 08             	pushl  0x8(%ebp)
  8009e9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009ef:	50                   	push   %eax
  8009f0:	68 5d 09 80 00       	push   $0x80095d
  8009f5:	e8 11 02 00 00       	call   800c0b <vprintfmt>
  8009fa:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009fd:	a0 28 30 80 00       	mov    0x803028,%al
  800a02:	0f b6 c0             	movzbl %al,%eax
  800a05:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a0b:	83 ec 04             	sub    $0x4,%esp
  800a0e:	50                   	push   %eax
  800a0f:	52                   	push   %edx
  800a10:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a16:	83 c0 08             	add    $0x8,%eax
  800a19:	50                   	push   %eax
  800a1a:	e8 7e 11 00 00       	call   801b9d <sys_cputs>
  800a1f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a22:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800a29:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a2f:	c9                   	leave  
  800a30:	c3                   	ret    

00800a31 <cprintf>:

int cprintf(const char *fmt, ...) {
  800a31:	55                   	push   %ebp
  800a32:	89 e5                	mov    %esp,%ebp
  800a34:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a37:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800a3e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a41:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a44:	8b 45 08             	mov    0x8(%ebp),%eax
  800a47:	83 ec 08             	sub    $0x8,%esp
  800a4a:	ff 75 f4             	pushl  -0xc(%ebp)
  800a4d:	50                   	push   %eax
  800a4e:	e8 73 ff ff ff       	call   8009c6 <vcprintf>
  800a53:	83 c4 10             	add    $0x10,%esp
  800a56:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a59:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a5c:	c9                   	leave  
  800a5d:	c3                   	ret    

00800a5e <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a5e:	55                   	push   %ebp
  800a5f:	89 e5                	mov    %esp,%ebp
  800a61:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a64:	e8 45 13 00 00       	call   801dae <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a69:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a72:	83 ec 08             	sub    $0x8,%esp
  800a75:	ff 75 f4             	pushl  -0xc(%ebp)
  800a78:	50                   	push   %eax
  800a79:	e8 48 ff ff ff       	call   8009c6 <vcprintf>
  800a7e:	83 c4 10             	add    $0x10,%esp
  800a81:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a84:	e8 3f 13 00 00       	call   801dc8 <sys_enable_interrupt>
	return cnt;
  800a89:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a8c:	c9                   	leave  
  800a8d:	c3                   	ret    

00800a8e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a8e:	55                   	push   %ebp
  800a8f:	89 e5                	mov    %esp,%ebp
  800a91:	53                   	push   %ebx
  800a92:	83 ec 14             	sub    $0x14,%esp
  800a95:	8b 45 10             	mov    0x10(%ebp),%eax
  800a98:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a9b:	8b 45 14             	mov    0x14(%ebp),%eax
  800a9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800aa1:	8b 45 18             	mov    0x18(%ebp),%eax
  800aa4:	ba 00 00 00 00       	mov    $0x0,%edx
  800aa9:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800aac:	77 55                	ja     800b03 <printnum+0x75>
  800aae:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ab1:	72 05                	jb     800ab8 <printnum+0x2a>
  800ab3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ab6:	77 4b                	ja     800b03 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800ab8:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800abb:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800abe:	8b 45 18             	mov    0x18(%ebp),%eax
  800ac1:	ba 00 00 00 00       	mov    $0x0,%edx
  800ac6:	52                   	push   %edx
  800ac7:	50                   	push   %eax
  800ac8:	ff 75 f4             	pushl  -0xc(%ebp)
  800acb:	ff 75 f0             	pushl  -0x10(%ebp)
  800ace:	e8 19 17 00 00       	call   8021ec <__udivdi3>
  800ad3:	83 c4 10             	add    $0x10,%esp
  800ad6:	83 ec 04             	sub    $0x4,%esp
  800ad9:	ff 75 20             	pushl  0x20(%ebp)
  800adc:	53                   	push   %ebx
  800add:	ff 75 18             	pushl  0x18(%ebp)
  800ae0:	52                   	push   %edx
  800ae1:	50                   	push   %eax
  800ae2:	ff 75 0c             	pushl  0xc(%ebp)
  800ae5:	ff 75 08             	pushl  0x8(%ebp)
  800ae8:	e8 a1 ff ff ff       	call   800a8e <printnum>
  800aed:	83 c4 20             	add    $0x20,%esp
  800af0:	eb 1a                	jmp    800b0c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800af2:	83 ec 08             	sub    $0x8,%esp
  800af5:	ff 75 0c             	pushl  0xc(%ebp)
  800af8:	ff 75 20             	pushl  0x20(%ebp)
  800afb:	8b 45 08             	mov    0x8(%ebp),%eax
  800afe:	ff d0                	call   *%eax
  800b00:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b03:	ff 4d 1c             	decl   0x1c(%ebp)
  800b06:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b0a:	7f e6                	jg     800af2 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b0c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b0f:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b14:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b17:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b1a:	53                   	push   %ebx
  800b1b:	51                   	push   %ecx
  800b1c:	52                   	push   %edx
  800b1d:	50                   	push   %eax
  800b1e:	e8 d9 17 00 00       	call   8022fc <__umoddi3>
  800b23:	83 c4 10             	add    $0x10,%esp
  800b26:	05 34 2a 80 00       	add    $0x802a34,%eax
  800b2b:	8a 00                	mov    (%eax),%al
  800b2d:	0f be c0             	movsbl %al,%eax
  800b30:	83 ec 08             	sub    $0x8,%esp
  800b33:	ff 75 0c             	pushl  0xc(%ebp)
  800b36:	50                   	push   %eax
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3a:	ff d0                	call   *%eax
  800b3c:	83 c4 10             	add    $0x10,%esp
}
  800b3f:	90                   	nop
  800b40:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b43:	c9                   	leave  
  800b44:	c3                   	ret    

00800b45 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b45:	55                   	push   %ebp
  800b46:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b48:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b4c:	7e 1c                	jle    800b6a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b51:	8b 00                	mov    (%eax),%eax
  800b53:	8d 50 08             	lea    0x8(%eax),%edx
  800b56:	8b 45 08             	mov    0x8(%ebp),%eax
  800b59:	89 10                	mov    %edx,(%eax)
  800b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5e:	8b 00                	mov    (%eax),%eax
  800b60:	83 e8 08             	sub    $0x8,%eax
  800b63:	8b 50 04             	mov    0x4(%eax),%edx
  800b66:	8b 00                	mov    (%eax),%eax
  800b68:	eb 40                	jmp    800baa <getuint+0x65>
	else if (lflag)
  800b6a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b6e:	74 1e                	je     800b8e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b70:	8b 45 08             	mov    0x8(%ebp),%eax
  800b73:	8b 00                	mov    (%eax),%eax
  800b75:	8d 50 04             	lea    0x4(%eax),%edx
  800b78:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7b:	89 10                	mov    %edx,(%eax)
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	8b 00                	mov    (%eax),%eax
  800b82:	83 e8 04             	sub    $0x4,%eax
  800b85:	8b 00                	mov    (%eax),%eax
  800b87:	ba 00 00 00 00       	mov    $0x0,%edx
  800b8c:	eb 1c                	jmp    800baa <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b91:	8b 00                	mov    (%eax),%eax
  800b93:	8d 50 04             	lea    0x4(%eax),%edx
  800b96:	8b 45 08             	mov    0x8(%ebp),%eax
  800b99:	89 10                	mov    %edx,(%eax)
  800b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9e:	8b 00                	mov    (%eax),%eax
  800ba0:	83 e8 04             	sub    $0x4,%eax
  800ba3:	8b 00                	mov    (%eax),%eax
  800ba5:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800baa:	5d                   	pop    %ebp
  800bab:	c3                   	ret    

00800bac <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800bac:	55                   	push   %ebp
  800bad:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800baf:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bb3:	7e 1c                	jle    800bd1 <getint+0x25>
		return va_arg(*ap, long long);
  800bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb8:	8b 00                	mov    (%eax),%eax
  800bba:	8d 50 08             	lea    0x8(%eax),%edx
  800bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc0:	89 10                	mov    %edx,(%eax)
  800bc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc5:	8b 00                	mov    (%eax),%eax
  800bc7:	83 e8 08             	sub    $0x8,%eax
  800bca:	8b 50 04             	mov    0x4(%eax),%edx
  800bcd:	8b 00                	mov    (%eax),%eax
  800bcf:	eb 38                	jmp    800c09 <getint+0x5d>
	else if (lflag)
  800bd1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bd5:	74 1a                	je     800bf1 <getint+0x45>
		return va_arg(*ap, long);
  800bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bda:	8b 00                	mov    (%eax),%eax
  800bdc:	8d 50 04             	lea    0x4(%eax),%edx
  800bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800be2:	89 10                	mov    %edx,(%eax)
  800be4:	8b 45 08             	mov    0x8(%ebp),%eax
  800be7:	8b 00                	mov    (%eax),%eax
  800be9:	83 e8 04             	sub    $0x4,%eax
  800bec:	8b 00                	mov    (%eax),%eax
  800bee:	99                   	cltd   
  800bef:	eb 18                	jmp    800c09 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800bf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf4:	8b 00                	mov    (%eax),%eax
  800bf6:	8d 50 04             	lea    0x4(%eax),%edx
  800bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfc:	89 10                	mov    %edx,(%eax)
  800bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800c01:	8b 00                	mov    (%eax),%eax
  800c03:	83 e8 04             	sub    $0x4,%eax
  800c06:	8b 00                	mov    (%eax),%eax
  800c08:	99                   	cltd   
}
  800c09:	5d                   	pop    %ebp
  800c0a:	c3                   	ret    

00800c0b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c0b:	55                   	push   %ebp
  800c0c:	89 e5                	mov    %esp,%ebp
  800c0e:	56                   	push   %esi
  800c0f:	53                   	push   %ebx
  800c10:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c13:	eb 17                	jmp    800c2c <vprintfmt+0x21>
			if (ch == '\0')
  800c15:	85 db                	test   %ebx,%ebx
  800c17:	0f 84 af 03 00 00    	je     800fcc <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c1d:	83 ec 08             	sub    $0x8,%esp
  800c20:	ff 75 0c             	pushl  0xc(%ebp)
  800c23:	53                   	push   %ebx
  800c24:	8b 45 08             	mov    0x8(%ebp),%eax
  800c27:	ff d0                	call   *%eax
  800c29:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c2c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c2f:	8d 50 01             	lea    0x1(%eax),%edx
  800c32:	89 55 10             	mov    %edx,0x10(%ebp)
  800c35:	8a 00                	mov    (%eax),%al
  800c37:	0f b6 d8             	movzbl %al,%ebx
  800c3a:	83 fb 25             	cmp    $0x25,%ebx
  800c3d:	75 d6                	jne    800c15 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c3f:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c43:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c4a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c51:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c58:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c5f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c62:	8d 50 01             	lea    0x1(%eax),%edx
  800c65:	89 55 10             	mov    %edx,0x10(%ebp)
  800c68:	8a 00                	mov    (%eax),%al
  800c6a:	0f b6 d8             	movzbl %al,%ebx
  800c6d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c70:	83 f8 55             	cmp    $0x55,%eax
  800c73:	0f 87 2b 03 00 00    	ja     800fa4 <vprintfmt+0x399>
  800c79:	8b 04 85 58 2a 80 00 	mov    0x802a58(,%eax,4),%eax
  800c80:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c82:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c86:	eb d7                	jmp    800c5f <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c88:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c8c:	eb d1                	jmp    800c5f <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c8e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c95:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c98:	89 d0                	mov    %edx,%eax
  800c9a:	c1 e0 02             	shl    $0x2,%eax
  800c9d:	01 d0                	add    %edx,%eax
  800c9f:	01 c0                	add    %eax,%eax
  800ca1:	01 d8                	add    %ebx,%eax
  800ca3:	83 e8 30             	sub    $0x30,%eax
  800ca6:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800ca9:	8b 45 10             	mov    0x10(%ebp),%eax
  800cac:	8a 00                	mov    (%eax),%al
  800cae:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800cb1:	83 fb 2f             	cmp    $0x2f,%ebx
  800cb4:	7e 3e                	jle    800cf4 <vprintfmt+0xe9>
  800cb6:	83 fb 39             	cmp    $0x39,%ebx
  800cb9:	7f 39                	jg     800cf4 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cbb:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800cbe:	eb d5                	jmp    800c95 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800cc0:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc3:	83 c0 04             	add    $0x4,%eax
  800cc6:	89 45 14             	mov    %eax,0x14(%ebp)
  800cc9:	8b 45 14             	mov    0x14(%ebp),%eax
  800ccc:	83 e8 04             	sub    $0x4,%eax
  800ccf:	8b 00                	mov    (%eax),%eax
  800cd1:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800cd4:	eb 1f                	jmp    800cf5 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800cd6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cda:	79 83                	jns    800c5f <vprintfmt+0x54>
				width = 0;
  800cdc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800ce3:	e9 77 ff ff ff       	jmp    800c5f <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800ce8:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800cef:	e9 6b ff ff ff       	jmp    800c5f <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800cf4:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800cf5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cf9:	0f 89 60 ff ff ff    	jns    800c5f <vprintfmt+0x54>
				width = precision, precision = -1;
  800cff:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d02:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d05:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d0c:	e9 4e ff ff ff       	jmp    800c5f <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d11:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d14:	e9 46 ff ff ff       	jmp    800c5f <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d19:	8b 45 14             	mov    0x14(%ebp),%eax
  800d1c:	83 c0 04             	add    $0x4,%eax
  800d1f:	89 45 14             	mov    %eax,0x14(%ebp)
  800d22:	8b 45 14             	mov    0x14(%ebp),%eax
  800d25:	83 e8 04             	sub    $0x4,%eax
  800d28:	8b 00                	mov    (%eax),%eax
  800d2a:	83 ec 08             	sub    $0x8,%esp
  800d2d:	ff 75 0c             	pushl  0xc(%ebp)
  800d30:	50                   	push   %eax
  800d31:	8b 45 08             	mov    0x8(%ebp),%eax
  800d34:	ff d0                	call   *%eax
  800d36:	83 c4 10             	add    $0x10,%esp
			break;
  800d39:	e9 89 02 00 00       	jmp    800fc7 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d3e:	8b 45 14             	mov    0x14(%ebp),%eax
  800d41:	83 c0 04             	add    $0x4,%eax
  800d44:	89 45 14             	mov    %eax,0x14(%ebp)
  800d47:	8b 45 14             	mov    0x14(%ebp),%eax
  800d4a:	83 e8 04             	sub    $0x4,%eax
  800d4d:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d4f:	85 db                	test   %ebx,%ebx
  800d51:	79 02                	jns    800d55 <vprintfmt+0x14a>
				err = -err;
  800d53:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d55:	83 fb 64             	cmp    $0x64,%ebx
  800d58:	7f 0b                	jg     800d65 <vprintfmt+0x15a>
  800d5a:	8b 34 9d a0 28 80 00 	mov    0x8028a0(,%ebx,4),%esi
  800d61:	85 f6                	test   %esi,%esi
  800d63:	75 19                	jne    800d7e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d65:	53                   	push   %ebx
  800d66:	68 45 2a 80 00       	push   $0x802a45
  800d6b:	ff 75 0c             	pushl  0xc(%ebp)
  800d6e:	ff 75 08             	pushl  0x8(%ebp)
  800d71:	e8 5e 02 00 00       	call   800fd4 <printfmt>
  800d76:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d79:	e9 49 02 00 00       	jmp    800fc7 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d7e:	56                   	push   %esi
  800d7f:	68 4e 2a 80 00       	push   $0x802a4e
  800d84:	ff 75 0c             	pushl  0xc(%ebp)
  800d87:	ff 75 08             	pushl  0x8(%ebp)
  800d8a:	e8 45 02 00 00       	call   800fd4 <printfmt>
  800d8f:	83 c4 10             	add    $0x10,%esp
			break;
  800d92:	e9 30 02 00 00       	jmp    800fc7 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d97:	8b 45 14             	mov    0x14(%ebp),%eax
  800d9a:	83 c0 04             	add    $0x4,%eax
  800d9d:	89 45 14             	mov    %eax,0x14(%ebp)
  800da0:	8b 45 14             	mov    0x14(%ebp),%eax
  800da3:	83 e8 04             	sub    $0x4,%eax
  800da6:	8b 30                	mov    (%eax),%esi
  800da8:	85 f6                	test   %esi,%esi
  800daa:	75 05                	jne    800db1 <vprintfmt+0x1a6>
				p = "(null)";
  800dac:	be 51 2a 80 00       	mov    $0x802a51,%esi
			if (width > 0 && padc != '-')
  800db1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800db5:	7e 6d                	jle    800e24 <vprintfmt+0x219>
  800db7:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800dbb:	74 67                	je     800e24 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800dbd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800dc0:	83 ec 08             	sub    $0x8,%esp
  800dc3:	50                   	push   %eax
  800dc4:	56                   	push   %esi
  800dc5:	e8 12 05 00 00       	call   8012dc <strnlen>
  800dca:	83 c4 10             	add    $0x10,%esp
  800dcd:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800dd0:	eb 16                	jmp    800de8 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800dd2:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800dd6:	83 ec 08             	sub    $0x8,%esp
  800dd9:	ff 75 0c             	pushl  0xc(%ebp)
  800ddc:	50                   	push   %eax
  800ddd:	8b 45 08             	mov    0x8(%ebp),%eax
  800de0:	ff d0                	call   *%eax
  800de2:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800de5:	ff 4d e4             	decl   -0x1c(%ebp)
  800de8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dec:	7f e4                	jg     800dd2 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dee:	eb 34                	jmp    800e24 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800df0:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800df4:	74 1c                	je     800e12 <vprintfmt+0x207>
  800df6:	83 fb 1f             	cmp    $0x1f,%ebx
  800df9:	7e 05                	jle    800e00 <vprintfmt+0x1f5>
  800dfb:	83 fb 7e             	cmp    $0x7e,%ebx
  800dfe:	7e 12                	jle    800e12 <vprintfmt+0x207>
					putch('?', putdat);
  800e00:	83 ec 08             	sub    $0x8,%esp
  800e03:	ff 75 0c             	pushl  0xc(%ebp)
  800e06:	6a 3f                	push   $0x3f
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	ff d0                	call   *%eax
  800e0d:	83 c4 10             	add    $0x10,%esp
  800e10:	eb 0f                	jmp    800e21 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e12:	83 ec 08             	sub    $0x8,%esp
  800e15:	ff 75 0c             	pushl  0xc(%ebp)
  800e18:	53                   	push   %ebx
  800e19:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1c:	ff d0                	call   *%eax
  800e1e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e21:	ff 4d e4             	decl   -0x1c(%ebp)
  800e24:	89 f0                	mov    %esi,%eax
  800e26:	8d 70 01             	lea    0x1(%eax),%esi
  800e29:	8a 00                	mov    (%eax),%al
  800e2b:	0f be d8             	movsbl %al,%ebx
  800e2e:	85 db                	test   %ebx,%ebx
  800e30:	74 24                	je     800e56 <vprintfmt+0x24b>
  800e32:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e36:	78 b8                	js     800df0 <vprintfmt+0x1e5>
  800e38:	ff 4d e0             	decl   -0x20(%ebp)
  800e3b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e3f:	79 af                	jns    800df0 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e41:	eb 13                	jmp    800e56 <vprintfmt+0x24b>
				putch(' ', putdat);
  800e43:	83 ec 08             	sub    $0x8,%esp
  800e46:	ff 75 0c             	pushl  0xc(%ebp)
  800e49:	6a 20                	push   $0x20
  800e4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4e:	ff d0                	call   *%eax
  800e50:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e53:	ff 4d e4             	decl   -0x1c(%ebp)
  800e56:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e5a:	7f e7                	jg     800e43 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e5c:	e9 66 01 00 00       	jmp    800fc7 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e61:	83 ec 08             	sub    $0x8,%esp
  800e64:	ff 75 e8             	pushl  -0x18(%ebp)
  800e67:	8d 45 14             	lea    0x14(%ebp),%eax
  800e6a:	50                   	push   %eax
  800e6b:	e8 3c fd ff ff       	call   800bac <getint>
  800e70:	83 c4 10             	add    $0x10,%esp
  800e73:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e76:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e79:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e7c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e7f:	85 d2                	test   %edx,%edx
  800e81:	79 23                	jns    800ea6 <vprintfmt+0x29b>
				putch('-', putdat);
  800e83:	83 ec 08             	sub    $0x8,%esp
  800e86:	ff 75 0c             	pushl  0xc(%ebp)
  800e89:	6a 2d                	push   $0x2d
  800e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8e:	ff d0                	call   *%eax
  800e90:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e93:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e96:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e99:	f7 d8                	neg    %eax
  800e9b:	83 d2 00             	adc    $0x0,%edx
  800e9e:	f7 da                	neg    %edx
  800ea0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ea3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ea6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ead:	e9 bc 00 00 00       	jmp    800f6e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800eb2:	83 ec 08             	sub    $0x8,%esp
  800eb5:	ff 75 e8             	pushl  -0x18(%ebp)
  800eb8:	8d 45 14             	lea    0x14(%ebp),%eax
  800ebb:	50                   	push   %eax
  800ebc:	e8 84 fc ff ff       	call   800b45 <getuint>
  800ec1:	83 c4 10             	add    $0x10,%esp
  800ec4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ec7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800eca:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ed1:	e9 98 00 00 00       	jmp    800f6e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ed6:	83 ec 08             	sub    $0x8,%esp
  800ed9:	ff 75 0c             	pushl  0xc(%ebp)
  800edc:	6a 58                	push   $0x58
  800ede:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee1:	ff d0                	call   *%eax
  800ee3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ee6:	83 ec 08             	sub    $0x8,%esp
  800ee9:	ff 75 0c             	pushl  0xc(%ebp)
  800eec:	6a 58                	push   $0x58
  800eee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef1:	ff d0                	call   *%eax
  800ef3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ef6:	83 ec 08             	sub    $0x8,%esp
  800ef9:	ff 75 0c             	pushl  0xc(%ebp)
  800efc:	6a 58                	push   $0x58
  800efe:	8b 45 08             	mov    0x8(%ebp),%eax
  800f01:	ff d0                	call   *%eax
  800f03:	83 c4 10             	add    $0x10,%esp
			break;
  800f06:	e9 bc 00 00 00       	jmp    800fc7 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f0b:	83 ec 08             	sub    $0x8,%esp
  800f0e:	ff 75 0c             	pushl  0xc(%ebp)
  800f11:	6a 30                	push   $0x30
  800f13:	8b 45 08             	mov    0x8(%ebp),%eax
  800f16:	ff d0                	call   *%eax
  800f18:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f1b:	83 ec 08             	sub    $0x8,%esp
  800f1e:	ff 75 0c             	pushl  0xc(%ebp)
  800f21:	6a 78                	push   $0x78
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
  800f26:	ff d0                	call   *%eax
  800f28:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f2b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f2e:	83 c0 04             	add    $0x4,%eax
  800f31:	89 45 14             	mov    %eax,0x14(%ebp)
  800f34:	8b 45 14             	mov    0x14(%ebp),%eax
  800f37:	83 e8 04             	sub    $0x4,%eax
  800f3a:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f3f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f46:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f4d:	eb 1f                	jmp    800f6e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f4f:	83 ec 08             	sub    $0x8,%esp
  800f52:	ff 75 e8             	pushl  -0x18(%ebp)
  800f55:	8d 45 14             	lea    0x14(%ebp),%eax
  800f58:	50                   	push   %eax
  800f59:	e8 e7 fb ff ff       	call   800b45 <getuint>
  800f5e:	83 c4 10             	add    $0x10,%esp
  800f61:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f64:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f67:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f6e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f72:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f75:	83 ec 04             	sub    $0x4,%esp
  800f78:	52                   	push   %edx
  800f79:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f7c:	50                   	push   %eax
  800f7d:	ff 75 f4             	pushl  -0xc(%ebp)
  800f80:	ff 75 f0             	pushl  -0x10(%ebp)
  800f83:	ff 75 0c             	pushl  0xc(%ebp)
  800f86:	ff 75 08             	pushl  0x8(%ebp)
  800f89:	e8 00 fb ff ff       	call   800a8e <printnum>
  800f8e:	83 c4 20             	add    $0x20,%esp
			break;
  800f91:	eb 34                	jmp    800fc7 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f93:	83 ec 08             	sub    $0x8,%esp
  800f96:	ff 75 0c             	pushl  0xc(%ebp)
  800f99:	53                   	push   %ebx
  800f9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9d:	ff d0                	call   *%eax
  800f9f:	83 c4 10             	add    $0x10,%esp
			break;
  800fa2:	eb 23                	jmp    800fc7 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800fa4:	83 ec 08             	sub    $0x8,%esp
  800fa7:	ff 75 0c             	pushl  0xc(%ebp)
  800faa:	6a 25                	push   $0x25
  800fac:	8b 45 08             	mov    0x8(%ebp),%eax
  800faf:	ff d0                	call   *%eax
  800fb1:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800fb4:	ff 4d 10             	decl   0x10(%ebp)
  800fb7:	eb 03                	jmp    800fbc <vprintfmt+0x3b1>
  800fb9:	ff 4d 10             	decl   0x10(%ebp)
  800fbc:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbf:	48                   	dec    %eax
  800fc0:	8a 00                	mov    (%eax),%al
  800fc2:	3c 25                	cmp    $0x25,%al
  800fc4:	75 f3                	jne    800fb9 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800fc6:	90                   	nop
		}
	}
  800fc7:	e9 47 fc ff ff       	jmp    800c13 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800fcc:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800fcd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800fd0:	5b                   	pop    %ebx
  800fd1:	5e                   	pop    %esi
  800fd2:	5d                   	pop    %ebp
  800fd3:	c3                   	ret    

00800fd4 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800fd4:	55                   	push   %ebp
  800fd5:	89 e5                	mov    %esp,%ebp
  800fd7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800fda:	8d 45 10             	lea    0x10(%ebp),%eax
  800fdd:	83 c0 04             	add    $0x4,%eax
  800fe0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800fe3:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe6:	ff 75 f4             	pushl  -0xc(%ebp)
  800fe9:	50                   	push   %eax
  800fea:	ff 75 0c             	pushl  0xc(%ebp)
  800fed:	ff 75 08             	pushl  0x8(%ebp)
  800ff0:	e8 16 fc ff ff       	call   800c0b <vprintfmt>
  800ff5:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ff8:	90                   	nop
  800ff9:	c9                   	leave  
  800ffa:	c3                   	ret    

00800ffb <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ffb:	55                   	push   %ebp
  800ffc:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ffe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801001:	8b 40 08             	mov    0x8(%eax),%eax
  801004:	8d 50 01             	lea    0x1(%eax),%edx
  801007:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80100d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801010:	8b 10                	mov    (%eax),%edx
  801012:	8b 45 0c             	mov    0xc(%ebp),%eax
  801015:	8b 40 04             	mov    0x4(%eax),%eax
  801018:	39 c2                	cmp    %eax,%edx
  80101a:	73 12                	jae    80102e <sprintputch+0x33>
		*b->buf++ = ch;
  80101c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101f:	8b 00                	mov    (%eax),%eax
  801021:	8d 48 01             	lea    0x1(%eax),%ecx
  801024:	8b 55 0c             	mov    0xc(%ebp),%edx
  801027:	89 0a                	mov    %ecx,(%edx)
  801029:	8b 55 08             	mov    0x8(%ebp),%edx
  80102c:	88 10                	mov    %dl,(%eax)
}
  80102e:	90                   	nop
  80102f:	5d                   	pop    %ebp
  801030:	c3                   	ret    

00801031 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801031:	55                   	push   %ebp
  801032:	89 e5                	mov    %esp,%ebp
  801034:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801037:	8b 45 08             	mov    0x8(%ebp),%eax
  80103a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80103d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801040:	8d 50 ff             	lea    -0x1(%eax),%edx
  801043:	8b 45 08             	mov    0x8(%ebp),%eax
  801046:	01 d0                	add    %edx,%eax
  801048:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80104b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801052:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801056:	74 06                	je     80105e <vsnprintf+0x2d>
  801058:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80105c:	7f 07                	jg     801065 <vsnprintf+0x34>
		return -E_INVAL;
  80105e:	b8 03 00 00 00       	mov    $0x3,%eax
  801063:	eb 20                	jmp    801085 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801065:	ff 75 14             	pushl  0x14(%ebp)
  801068:	ff 75 10             	pushl  0x10(%ebp)
  80106b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80106e:	50                   	push   %eax
  80106f:	68 fb 0f 80 00       	push   $0x800ffb
  801074:	e8 92 fb ff ff       	call   800c0b <vprintfmt>
  801079:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80107c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80107f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801082:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801085:	c9                   	leave  
  801086:	c3                   	ret    

00801087 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801087:	55                   	push   %ebp
  801088:	89 e5                	mov    %esp,%ebp
  80108a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80108d:	8d 45 10             	lea    0x10(%ebp),%eax
  801090:	83 c0 04             	add    $0x4,%eax
  801093:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801096:	8b 45 10             	mov    0x10(%ebp),%eax
  801099:	ff 75 f4             	pushl  -0xc(%ebp)
  80109c:	50                   	push   %eax
  80109d:	ff 75 0c             	pushl  0xc(%ebp)
  8010a0:	ff 75 08             	pushl  0x8(%ebp)
  8010a3:	e8 89 ff ff ff       	call   801031 <vsnprintf>
  8010a8:	83 c4 10             	add    $0x10,%esp
  8010ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8010ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010b1:	c9                   	leave  
  8010b2:	c3                   	ret    

008010b3 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8010b3:	55                   	push   %ebp
  8010b4:	89 e5                	mov    %esp,%ebp
  8010b6:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8010b9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010bd:	74 13                	je     8010d2 <readline+0x1f>
		cprintf("%s", prompt);
  8010bf:	83 ec 08             	sub    $0x8,%esp
  8010c2:	ff 75 08             	pushl  0x8(%ebp)
  8010c5:	68 b0 2b 80 00       	push   $0x802bb0
  8010ca:	e8 62 f9 ff ff       	call   800a31 <cprintf>
  8010cf:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8010d2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8010d9:	83 ec 0c             	sub    $0xc,%esp
  8010dc:	6a 00                	push   $0x0
  8010de:	e8 68 f5 ff ff       	call   80064b <iscons>
  8010e3:	83 c4 10             	add    $0x10,%esp
  8010e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8010e9:	e8 0f f5 ff ff       	call   8005fd <getchar>
  8010ee:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8010f1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010f5:	79 22                	jns    801119 <readline+0x66>
			if (c != -E_EOF)
  8010f7:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8010fb:	0f 84 ad 00 00 00    	je     8011ae <readline+0xfb>
				cprintf("read error: %e\n", c);
  801101:	83 ec 08             	sub    $0x8,%esp
  801104:	ff 75 ec             	pushl  -0x14(%ebp)
  801107:	68 b3 2b 80 00       	push   $0x802bb3
  80110c:	e8 20 f9 ff ff       	call   800a31 <cprintf>
  801111:	83 c4 10             	add    $0x10,%esp
			return;
  801114:	e9 95 00 00 00       	jmp    8011ae <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801119:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80111d:	7e 34                	jle    801153 <readline+0xa0>
  80111f:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801126:	7f 2b                	jg     801153 <readline+0xa0>
			if (echoing)
  801128:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80112c:	74 0e                	je     80113c <readline+0x89>
				cputchar(c);
  80112e:	83 ec 0c             	sub    $0xc,%esp
  801131:	ff 75 ec             	pushl  -0x14(%ebp)
  801134:	e8 7c f4 ff ff       	call   8005b5 <cputchar>
  801139:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80113c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80113f:	8d 50 01             	lea    0x1(%eax),%edx
  801142:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801145:	89 c2                	mov    %eax,%edx
  801147:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114a:	01 d0                	add    %edx,%eax
  80114c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80114f:	88 10                	mov    %dl,(%eax)
  801151:	eb 56                	jmp    8011a9 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801153:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801157:	75 1f                	jne    801178 <readline+0xc5>
  801159:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80115d:	7e 19                	jle    801178 <readline+0xc5>
			if (echoing)
  80115f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801163:	74 0e                	je     801173 <readline+0xc0>
				cputchar(c);
  801165:	83 ec 0c             	sub    $0xc,%esp
  801168:	ff 75 ec             	pushl  -0x14(%ebp)
  80116b:	e8 45 f4 ff ff       	call   8005b5 <cputchar>
  801170:	83 c4 10             	add    $0x10,%esp

			i--;
  801173:	ff 4d f4             	decl   -0xc(%ebp)
  801176:	eb 31                	jmp    8011a9 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  801178:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80117c:	74 0a                	je     801188 <readline+0xd5>
  80117e:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801182:	0f 85 61 ff ff ff    	jne    8010e9 <readline+0x36>
			if (echoing)
  801188:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80118c:	74 0e                	je     80119c <readline+0xe9>
				cputchar(c);
  80118e:	83 ec 0c             	sub    $0xc,%esp
  801191:	ff 75 ec             	pushl  -0x14(%ebp)
  801194:	e8 1c f4 ff ff       	call   8005b5 <cputchar>
  801199:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80119c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80119f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a2:	01 d0                	add    %edx,%eax
  8011a4:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8011a7:	eb 06                	jmp    8011af <readline+0xfc>
		}
	}
  8011a9:	e9 3b ff ff ff       	jmp    8010e9 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8011ae:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8011af:	c9                   	leave  
  8011b0:	c3                   	ret    

008011b1 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8011b1:	55                   	push   %ebp
  8011b2:	89 e5                	mov    %esp,%ebp
  8011b4:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8011b7:	e8 f2 0b 00 00       	call   801dae <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8011bc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011c0:	74 13                	je     8011d5 <atomic_readline+0x24>
		cprintf("%s", prompt);
  8011c2:	83 ec 08             	sub    $0x8,%esp
  8011c5:	ff 75 08             	pushl  0x8(%ebp)
  8011c8:	68 b0 2b 80 00       	push   $0x802bb0
  8011cd:	e8 5f f8 ff ff       	call   800a31 <cprintf>
  8011d2:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8011d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8011dc:	83 ec 0c             	sub    $0xc,%esp
  8011df:	6a 00                	push   $0x0
  8011e1:	e8 65 f4 ff ff       	call   80064b <iscons>
  8011e6:	83 c4 10             	add    $0x10,%esp
  8011e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8011ec:	e8 0c f4 ff ff       	call   8005fd <getchar>
  8011f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8011f4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8011f8:	79 23                	jns    80121d <atomic_readline+0x6c>
			if (c != -E_EOF)
  8011fa:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8011fe:	74 13                	je     801213 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801200:	83 ec 08             	sub    $0x8,%esp
  801203:	ff 75 ec             	pushl  -0x14(%ebp)
  801206:	68 b3 2b 80 00       	push   $0x802bb3
  80120b:	e8 21 f8 ff ff       	call   800a31 <cprintf>
  801210:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801213:	e8 b0 0b 00 00       	call   801dc8 <sys_enable_interrupt>
			return;
  801218:	e9 9a 00 00 00       	jmp    8012b7 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80121d:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801221:	7e 34                	jle    801257 <atomic_readline+0xa6>
  801223:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80122a:	7f 2b                	jg     801257 <atomic_readline+0xa6>
			if (echoing)
  80122c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801230:	74 0e                	je     801240 <atomic_readline+0x8f>
				cputchar(c);
  801232:	83 ec 0c             	sub    $0xc,%esp
  801235:	ff 75 ec             	pushl  -0x14(%ebp)
  801238:	e8 78 f3 ff ff       	call   8005b5 <cputchar>
  80123d:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801240:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801243:	8d 50 01             	lea    0x1(%eax),%edx
  801246:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801249:	89 c2                	mov    %eax,%edx
  80124b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80124e:	01 d0                	add    %edx,%eax
  801250:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801253:	88 10                	mov    %dl,(%eax)
  801255:	eb 5b                	jmp    8012b2 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  801257:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80125b:	75 1f                	jne    80127c <atomic_readline+0xcb>
  80125d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801261:	7e 19                	jle    80127c <atomic_readline+0xcb>
			if (echoing)
  801263:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801267:	74 0e                	je     801277 <atomic_readline+0xc6>
				cputchar(c);
  801269:	83 ec 0c             	sub    $0xc,%esp
  80126c:	ff 75 ec             	pushl  -0x14(%ebp)
  80126f:	e8 41 f3 ff ff       	call   8005b5 <cputchar>
  801274:	83 c4 10             	add    $0x10,%esp
			i--;
  801277:	ff 4d f4             	decl   -0xc(%ebp)
  80127a:	eb 36                	jmp    8012b2 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  80127c:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801280:	74 0a                	je     80128c <atomic_readline+0xdb>
  801282:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801286:	0f 85 60 ff ff ff    	jne    8011ec <atomic_readline+0x3b>
			if (echoing)
  80128c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801290:	74 0e                	je     8012a0 <atomic_readline+0xef>
				cputchar(c);
  801292:	83 ec 0c             	sub    $0xc,%esp
  801295:	ff 75 ec             	pushl  -0x14(%ebp)
  801298:	e8 18 f3 ff ff       	call   8005b5 <cputchar>
  80129d:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8012a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a6:	01 d0                	add    %edx,%eax
  8012a8:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8012ab:	e8 18 0b 00 00       	call   801dc8 <sys_enable_interrupt>
			return;
  8012b0:	eb 05                	jmp    8012b7 <atomic_readline+0x106>
		}
	}
  8012b2:	e9 35 ff ff ff       	jmp    8011ec <atomic_readline+0x3b>
}
  8012b7:	c9                   	leave  
  8012b8:	c3                   	ret    

008012b9 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8012b9:	55                   	push   %ebp
  8012ba:	89 e5                	mov    %esp,%ebp
  8012bc:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8012bf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012c6:	eb 06                	jmp    8012ce <strlen+0x15>
		n++;
  8012c8:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8012cb:	ff 45 08             	incl   0x8(%ebp)
  8012ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d1:	8a 00                	mov    (%eax),%al
  8012d3:	84 c0                	test   %al,%al
  8012d5:	75 f1                	jne    8012c8 <strlen+0xf>
		n++;
	return n;
  8012d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012da:	c9                   	leave  
  8012db:	c3                   	ret    

008012dc <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8012dc:	55                   	push   %ebp
  8012dd:	89 e5                	mov    %esp,%ebp
  8012df:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012e9:	eb 09                	jmp    8012f4 <strnlen+0x18>
		n++;
  8012eb:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012ee:	ff 45 08             	incl   0x8(%ebp)
  8012f1:	ff 4d 0c             	decl   0xc(%ebp)
  8012f4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012f8:	74 09                	je     801303 <strnlen+0x27>
  8012fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fd:	8a 00                	mov    (%eax),%al
  8012ff:	84 c0                	test   %al,%al
  801301:	75 e8                	jne    8012eb <strnlen+0xf>
		n++;
	return n;
  801303:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801306:	c9                   	leave  
  801307:	c3                   	ret    

00801308 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801308:	55                   	push   %ebp
  801309:	89 e5                	mov    %esp,%ebp
  80130b:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80130e:	8b 45 08             	mov    0x8(%ebp),%eax
  801311:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801314:	90                   	nop
  801315:	8b 45 08             	mov    0x8(%ebp),%eax
  801318:	8d 50 01             	lea    0x1(%eax),%edx
  80131b:	89 55 08             	mov    %edx,0x8(%ebp)
  80131e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801321:	8d 4a 01             	lea    0x1(%edx),%ecx
  801324:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801327:	8a 12                	mov    (%edx),%dl
  801329:	88 10                	mov    %dl,(%eax)
  80132b:	8a 00                	mov    (%eax),%al
  80132d:	84 c0                	test   %al,%al
  80132f:	75 e4                	jne    801315 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801331:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801334:	c9                   	leave  
  801335:	c3                   	ret    

00801336 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801336:	55                   	push   %ebp
  801337:	89 e5                	mov    %esp,%ebp
  801339:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80133c:	8b 45 08             	mov    0x8(%ebp),%eax
  80133f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801342:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801349:	eb 1f                	jmp    80136a <strncpy+0x34>
		*dst++ = *src;
  80134b:	8b 45 08             	mov    0x8(%ebp),%eax
  80134e:	8d 50 01             	lea    0x1(%eax),%edx
  801351:	89 55 08             	mov    %edx,0x8(%ebp)
  801354:	8b 55 0c             	mov    0xc(%ebp),%edx
  801357:	8a 12                	mov    (%edx),%dl
  801359:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80135b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80135e:	8a 00                	mov    (%eax),%al
  801360:	84 c0                	test   %al,%al
  801362:	74 03                	je     801367 <strncpy+0x31>
			src++;
  801364:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801367:	ff 45 fc             	incl   -0x4(%ebp)
  80136a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80136d:	3b 45 10             	cmp    0x10(%ebp),%eax
  801370:	72 d9                	jb     80134b <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801372:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801375:	c9                   	leave  
  801376:	c3                   	ret    

00801377 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801377:	55                   	push   %ebp
  801378:	89 e5                	mov    %esp,%ebp
  80137a:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80137d:	8b 45 08             	mov    0x8(%ebp),%eax
  801380:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801383:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801387:	74 30                	je     8013b9 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801389:	eb 16                	jmp    8013a1 <strlcpy+0x2a>
			*dst++ = *src++;
  80138b:	8b 45 08             	mov    0x8(%ebp),%eax
  80138e:	8d 50 01             	lea    0x1(%eax),%edx
  801391:	89 55 08             	mov    %edx,0x8(%ebp)
  801394:	8b 55 0c             	mov    0xc(%ebp),%edx
  801397:	8d 4a 01             	lea    0x1(%edx),%ecx
  80139a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80139d:	8a 12                	mov    (%edx),%dl
  80139f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8013a1:	ff 4d 10             	decl   0x10(%ebp)
  8013a4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013a8:	74 09                	je     8013b3 <strlcpy+0x3c>
  8013aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ad:	8a 00                	mov    (%eax),%al
  8013af:	84 c0                	test   %al,%al
  8013b1:	75 d8                	jne    80138b <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8013b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b6:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8013b9:	8b 55 08             	mov    0x8(%ebp),%edx
  8013bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013bf:	29 c2                	sub    %eax,%edx
  8013c1:	89 d0                	mov    %edx,%eax
}
  8013c3:	c9                   	leave  
  8013c4:	c3                   	ret    

008013c5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8013c5:	55                   	push   %ebp
  8013c6:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8013c8:	eb 06                	jmp    8013d0 <strcmp+0xb>
		p++, q++;
  8013ca:	ff 45 08             	incl   0x8(%ebp)
  8013cd:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8013d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d3:	8a 00                	mov    (%eax),%al
  8013d5:	84 c0                	test   %al,%al
  8013d7:	74 0e                	je     8013e7 <strcmp+0x22>
  8013d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013dc:	8a 10                	mov    (%eax),%dl
  8013de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e1:	8a 00                	mov    (%eax),%al
  8013e3:	38 c2                	cmp    %al,%dl
  8013e5:	74 e3                	je     8013ca <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8013e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ea:	8a 00                	mov    (%eax),%al
  8013ec:	0f b6 d0             	movzbl %al,%edx
  8013ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f2:	8a 00                	mov    (%eax),%al
  8013f4:	0f b6 c0             	movzbl %al,%eax
  8013f7:	29 c2                	sub    %eax,%edx
  8013f9:	89 d0                	mov    %edx,%eax
}
  8013fb:	5d                   	pop    %ebp
  8013fc:	c3                   	ret    

008013fd <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8013fd:	55                   	push   %ebp
  8013fe:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801400:	eb 09                	jmp    80140b <strncmp+0xe>
		n--, p++, q++;
  801402:	ff 4d 10             	decl   0x10(%ebp)
  801405:	ff 45 08             	incl   0x8(%ebp)
  801408:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80140b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80140f:	74 17                	je     801428 <strncmp+0x2b>
  801411:	8b 45 08             	mov    0x8(%ebp),%eax
  801414:	8a 00                	mov    (%eax),%al
  801416:	84 c0                	test   %al,%al
  801418:	74 0e                	je     801428 <strncmp+0x2b>
  80141a:	8b 45 08             	mov    0x8(%ebp),%eax
  80141d:	8a 10                	mov    (%eax),%dl
  80141f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801422:	8a 00                	mov    (%eax),%al
  801424:	38 c2                	cmp    %al,%dl
  801426:	74 da                	je     801402 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801428:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80142c:	75 07                	jne    801435 <strncmp+0x38>
		return 0;
  80142e:	b8 00 00 00 00       	mov    $0x0,%eax
  801433:	eb 14                	jmp    801449 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801435:	8b 45 08             	mov    0x8(%ebp),%eax
  801438:	8a 00                	mov    (%eax),%al
  80143a:	0f b6 d0             	movzbl %al,%edx
  80143d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801440:	8a 00                	mov    (%eax),%al
  801442:	0f b6 c0             	movzbl %al,%eax
  801445:	29 c2                	sub    %eax,%edx
  801447:	89 d0                	mov    %edx,%eax
}
  801449:	5d                   	pop    %ebp
  80144a:	c3                   	ret    

0080144b <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80144b:	55                   	push   %ebp
  80144c:	89 e5                	mov    %esp,%ebp
  80144e:	83 ec 04             	sub    $0x4,%esp
  801451:	8b 45 0c             	mov    0xc(%ebp),%eax
  801454:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801457:	eb 12                	jmp    80146b <strchr+0x20>
		if (*s == c)
  801459:	8b 45 08             	mov    0x8(%ebp),%eax
  80145c:	8a 00                	mov    (%eax),%al
  80145e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801461:	75 05                	jne    801468 <strchr+0x1d>
			return (char *) s;
  801463:	8b 45 08             	mov    0x8(%ebp),%eax
  801466:	eb 11                	jmp    801479 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801468:	ff 45 08             	incl   0x8(%ebp)
  80146b:	8b 45 08             	mov    0x8(%ebp),%eax
  80146e:	8a 00                	mov    (%eax),%al
  801470:	84 c0                	test   %al,%al
  801472:	75 e5                	jne    801459 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801474:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801479:	c9                   	leave  
  80147a:	c3                   	ret    

0080147b <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80147b:	55                   	push   %ebp
  80147c:	89 e5                	mov    %esp,%ebp
  80147e:	83 ec 04             	sub    $0x4,%esp
  801481:	8b 45 0c             	mov    0xc(%ebp),%eax
  801484:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801487:	eb 0d                	jmp    801496 <strfind+0x1b>
		if (*s == c)
  801489:	8b 45 08             	mov    0x8(%ebp),%eax
  80148c:	8a 00                	mov    (%eax),%al
  80148e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801491:	74 0e                	je     8014a1 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801493:	ff 45 08             	incl   0x8(%ebp)
  801496:	8b 45 08             	mov    0x8(%ebp),%eax
  801499:	8a 00                	mov    (%eax),%al
  80149b:	84 c0                	test   %al,%al
  80149d:	75 ea                	jne    801489 <strfind+0xe>
  80149f:	eb 01                	jmp    8014a2 <strfind+0x27>
		if (*s == c)
			break;
  8014a1:	90                   	nop
	return (char *) s;
  8014a2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014a5:	c9                   	leave  
  8014a6:	c3                   	ret    

008014a7 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8014a7:	55                   	push   %ebp
  8014a8:	89 e5                	mov    %esp,%ebp
  8014aa:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8014ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8014b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8014b9:	eb 0e                	jmp    8014c9 <memset+0x22>
		*p++ = c;
  8014bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014be:	8d 50 01             	lea    0x1(%eax),%edx
  8014c1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014c7:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8014c9:	ff 4d f8             	decl   -0x8(%ebp)
  8014cc:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8014d0:	79 e9                	jns    8014bb <memset+0x14>
		*p++ = c;

	return v;
  8014d2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014d5:	c9                   	leave  
  8014d6:	c3                   	ret    

008014d7 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8014d7:	55                   	push   %ebp
  8014d8:	89 e5                	mov    %esp,%ebp
  8014da:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8014e9:	eb 16                	jmp    801501 <memcpy+0x2a>
		*d++ = *s++;
  8014eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ee:	8d 50 01             	lea    0x1(%eax),%edx
  8014f1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014f7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014fa:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014fd:	8a 12                	mov    (%edx),%dl
  8014ff:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801501:	8b 45 10             	mov    0x10(%ebp),%eax
  801504:	8d 50 ff             	lea    -0x1(%eax),%edx
  801507:	89 55 10             	mov    %edx,0x10(%ebp)
  80150a:	85 c0                	test   %eax,%eax
  80150c:	75 dd                	jne    8014eb <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80150e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801511:	c9                   	leave  
  801512:	c3                   	ret    

00801513 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801513:	55                   	push   %ebp
  801514:	89 e5                	mov    %esp,%ebp
  801516:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801519:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80151f:	8b 45 08             	mov    0x8(%ebp),%eax
  801522:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801525:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801528:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80152b:	73 50                	jae    80157d <memmove+0x6a>
  80152d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801530:	8b 45 10             	mov    0x10(%ebp),%eax
  801533:	01 d0                	add    %edx,%eax
  801535:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801538:	76 43                	jbe    80157d <memmove+0x6a>
		s += n;
  80153a:	8b 45 10             	mov    0x10(%ebp),%eax
  80153d:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801540:	8b 45 10             	mov    0x10(%ebp),%eax
  801543:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801546:	eb 10                	jmp    801558 <memmove+0x45>
			*--d = *--s;
  801548:	ff 4d f8             	decl   -0x8(%ebp)
  80154b:	ff 4d fc             	decl   -0x4(%ebp)
  80154e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801551:	8a 10                	mov    (%eax),%dl
  801553:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801556:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801558:	8b 45 10             	mov    0x10(%ebp),%eax
  80155b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80155e:	89 55 10             	mov    %edx,0x10(%ebp)
  801561:	85 c0                	test   %eax,%eax
  801563:	75 e3                	jne    801548 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801565:	eb 23                	jmp    80158a <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801567:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80156a:	8d 50 01             	lea    0x1(%eax),%edx
  80156d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801570:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801573:	8d 4a 01             	lea    0x1(%edx),%ecx
  801576:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801579:	8a 12                	mov    (%edx),%dl
  80157b:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80157d:	8b 45 10             	mov    0x10(%ebp),%eax
  801580:	8d 50 ff             	lea    -0x1(%eax),%edx
  801583:	89 55 10             	mov    %edx,0x10(%ebp)
  801586:	85 c0                	test   %eax,%eax
  801588:	75 dd                	jne    801567 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80158a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80158d:	c9                   	leave  
  80158e:	c3                   	ret    

0080158f <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80158f:	55                   	push   %ebp
  801590:	89 e5                	mov    %esp,%ebp
  801592:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801595:	8b 45 08             	mov    0x8(%ebp),%eax
  801598:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80159b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159e:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8015a1:	eb 2a                	jmp    8015cd <memcmp+0x3e>
		if (*s1 != *s2)
  8015a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015a6:	8a 10                	mov    (%eax),%dl
  8015a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ab:	8a 00                	mov    (%eax),%al
  8015ad:	38 c2                	cmp    %al,%dl
  8015af:	74 16                	je     8015c7 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015b4:	8a 00                	mov    (%eax),%al
  8015b6:	0f b6 d0             	movzbl %al,%edx
  8015b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015bc:	8a 00                	mov    (%eax),%al
  8015be:	0f b6 c0             	movzbl %al,%eax
  8015c1:	29 c2                	sub    %eax,%edx
  8015c3:	89 d0                	mov    %edx,%eax
  8015c5:	eb 18                	jmp    8015df <memcmp+0x50>
		s1++, s2++;
  8015c7:	ff 45 fc             	incl   -0x4(%ebp)
  8015ca:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015d3:	89 55 10             	mov    %edx,0x10(%ebp)
  8015d6:	85 c0                	test   %eax,%eax
  8015d8:	75 c9                	jne    8015a3 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8015da:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015df:	c9                   	leave  
  8015e0:	c3                   	ret    

008015e1 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8015e1:	55                   	push   %ebp
  8015e2:	89 e5                	mov    %esp,%ebp
  8015e4:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8015e7:	8b 55 08             	mov    0x8(%ebp),%edx
  8015ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ed:	01 d0                	add    %edx,%eax
  8015ef:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015f2:	eb 15                	jmp    801609 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f7:	8a 00                	mov    (%eax),%al
  8015f9:	0f b6 d0             	movzbl %al,%edx
  8015fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ff:	0f b6 c0             	movzbl %al,%eax
  801602:	39 c2                	cmp    %eax,%edx
  801604:	74 0d                	je     801613 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801606:	ff 45 08             	incl   0x8(%ebp)
  801609:	8b 45 08             	mov    0x8(%ebp),%eax
  80160c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80160f:	72 e3                	jb     8015f4 <memfind+0x13>
  801611:	eb 01                	jmp    801614 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801613:	90                   	nop
	return (void *) s;
  801614:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801617:	c9                   	leave  
  801618:	c3                   	ret    

00801619 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801619:	55                   	push   %ebp
  80161a:	89 e5                	mov    %esp,%ebp
  80161c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80161f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801626:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80162d:	eb 03                	jmp    801632 <strtol+0x19>
		s++;
  80162f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801632:	8b 45 08             	mov    0x8(%ebp),%eax
  801635:	8a 00                	mov    (%eax),%al
  801637:	3c 20                	cmp    $0x20,%al
  801639:	74 f4                	je     80162f <strtol+0x16>
  80163b:	8b 45 08             	mov    0x8(%ebp),%eax
  80163e:	8a 00                	mov    (%eax),%al
  801640:	3c 09                	cmp    $0x9,%al
  801642:	74 eb                	je     80162f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801644:	8b 45 08             	mov    0x8(%ebp),%eax
  801647:	8a 00                	mov    (%eax),%al
  801649:	3c 2b                	cmp    $0x2b,%al
  80164b:	75 05                	jne    801652 <strtol+0x39>
		s++;
  80164d:	ff 45 08             	incl   0x8(%ebp)
  801650:	eb 13                	jmp    801665 <strtol+0x4c>
	else if (*s == '-')
  801652:	8b 45 08             	mov    0x8(%ebp),%eax
  801655:	8a 00                	mov    (%eax),%al
  801657:	3c 2d                	cmp    $0x2d,%al
  801659:	75 0a                	jne    801665 <strtol+0x4c>
		s++, neg = 1;
  80165b:	ff 45 08             	incl   0x8(%ebp)
  80165e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801665:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801669:	74 06                	je     801671 <strtol+0x58>
  80166b:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80166f:	75 20                	jne    801691 <strtol+0x78>
  801671:	8b 45 08             	mov    0x8(%ebp),%eax
  801674:	8a 00                	mov    (%eax),%al
  801676:	3c 30                	cmp    $0x30,%al
  801678:	75 17                	jne    801691 <strtol+0x78>
  80167a:	8b 45 08             	mov    0x8(%ebp),%eax
  80167d:	40                   	inc    %eax
  80167e:	8a 00                	mov    (%eax),%al
  801680:	3c 78                	cmp    $0x78,%al
  801682:	75 0d                	jne    801691 <strtol+0x78>
		s += 2, base = 16;
  801684:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801688:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80168f:	eb 28                	jmp    8016b9 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801691:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801695:	75 15                	jne    8016ac <strtol+0x93>
  801697:	8b 45 08             	mov    0x8(%ebp),%eax
  80169a:	8a 00                	mov    (%eax),%al
  80169c:	3c 30                	cmp    $0x30,%al
  80169e:	75 0c                	jne    8016ac <strtol+0x93>
		s++, base = 8;
  8016a0:	ff 45 08             	incl   0x8(%ebp)
  8016a3:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8016aa:	eb 0d                	jmp    8016b9 <strtol+0xa0>
	else if (base == 0)
  8016ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016b0:	75 07                	jne    8016b9 <strtol+0xa0>
		base = 10;
  8016b2:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bc:	8a 00                	mov    (%eax),%al
  8016be:	3c 2f                	cmp    $0x2f,%al
  8016c0:	7e 19                	jle    8016db <strtol+0xc2>
  8016c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c5:	8a 00                	mov    (%eax),%al
  8016c7:	3c 39                	cmp    $0x39,%al
  8016c9:	7f 10                	jg     8016db <strtol+0xc2>
			dig = *s - '0';
  8016cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ce:	8a 00                	mov    (%eax),%al
  8016d0:	0f be c0             	movsbl %al,%eax
  8016d3:	83 e8 30             	sub    $0x30,%eax
  8016d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016d9:	eb 42                	jmp    80171d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8016db:	8b 45 08             	mov    0x8(%ebp),%eax
  8016de:	8a 00                	mov    (%eax),%al
  8016e0:	3c 60                	cmp    $0x60,%al
  8016e2:	7e 19                	jle    8016fd <strtol+0xe4>
  8016e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e7:	8a 00                	mov    (%eax),%al
  8016e9:	3c 7a                	cmp    $0x7a,%al
  8016eb:	7f 10                	jg     8016fd <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f0:	8a 00                	mov    (%eax),%al
  8016f2:	0f be c0             	movsbl %al,%eax
  8016f5:	83 e8 57             	sub    $0x57,%eax
  8016f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016fb:	eb 20                	jmp    80171d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801700:	8a 00                	mov    (%eax),%al
  801702:	3c 40                	cmp    $0x40,%al
  801704:	7e 39                	jle    80173f <strtol+0x126>
  801706:	8b 45 08             	mov    0x8(%ebp),%eax
  801709:	8a 00                	mov    (%eax),%al
  80170b:	3c 5a                	cmp    $0x5a,%al
  80170d:	7f 30                	jg     80173f <strtol+0x126>
			dig = *s - 'A' + 10;
  80170f:	8b 45 08             	mov    0x8(%ebp),%eax
  801712:	8a 00                	mov    (%eax),%al
  801714:	0f be c0             	movsbl %al,%eax
  801717:	83 e8 37             	sub    $0x37,%eax
  80171a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80171d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801720:	3b 45 10             	cmp    0x10(%ebp),%eax
  801723:	7d 19                	jge    80173e <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801725:	ff 45 08             	incl   0x8(%ebp)
  801728:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80172b:	0f af 45 10          	imul   0x10(%ebp),%eax
  80172f:	89 c2                	mov    %eax,%edx
  801731:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801734:	01 d0                	add    %edx,%eax
  801736:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801739:	e9 7b ff ff ff       	jmp    8016b9 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80173e:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80173f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801743:	74 08                	je     80174d <strtol+0x134>
		*endptr = (char *) s;
  801745:	8b 45 0c             	mov    0xc(%ebp),%eax
  801748:	8b 55 08             	mov    0x8(%ebp),%edx
  80174b:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80174d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801751:	74 07                	je     80175a <strtol+0x141>
  801753:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801756:	f7 d8                	neg    %eax
  801758:	eb 03                	jmp    80175d <strtol+0x144>
  80175a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80175d:	c9                   	leave  
  80175e:	c3                   	ret    

0080175f <ltostr>:

void
ltostr(long value, char *str)
{
  80175f:	55                   	push   %ebp
  801760:	89 e5                	mov    %esp,%ebp
  801762:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801765:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80176c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801773:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801777:	79 13                	jns    80178c <ltostr+0x2d>
	{
		neg = 1;
  801779:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801780:	8b 45 0c             	mov    0xc(%ebp),%eax
  801783:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801786:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801789:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80178c:	8b 45 08             	mov    0x8(%ebp),%eax
  80178f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801794:	99                   	cltd   
  801795:	f7 f9                	idiv   %ecx
  801797:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80179a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80179d:	8d 50 01             	lea    0x1(%eax),%edx
  8017a0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017a3:	89 c2                	mov    %eax,%edx
  8017a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a8:	01 d0                	add    %edx,%eax
  8017aa:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017ad:	83 c2 30             	add    $0x30,%edx
  8017b0:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017b2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017b5:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017ba:	f7 e9                	imul   %ecx
  8017bc:	c1 fa 02             	sar    $0x2,%edx
  8017bf:	89 c8                	mov    %ecx,%eax
  8017c1:	c1 f8 1f             	sar    $0x1f,%eax
  8017c4:	29 c2                	sub    %eax,%edx
  8017c6:	89 d0                	mov    %edx,%eax
  8017c8:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8017cb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017ce:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017d3:	f7 e9                	imul   %ecx
  8017d5:	c1 fa 02             	sar    $0x2,%edx
  8017d8:	89 c8                	mov    %ecx,%eax
  8017da:	c1 f8 1f             	sar    $0x1f,%eax
  8017dd:	29 c2                	sub    %eax,%edx
  8017df:	89 d0                	mov    %edx,%eax
  8017e1:	c1 e0 02             	shl    $0x2,%eax
  8017e4:	01 d0                	add    %edx,%eax
  8017e6:	01 c0                	add    %eax,%eax
  8017e8:	29 c1                	sub    %eax,%ecx
  8017ea:	89 ca                	mov    %ecx,%edx
  8017ec:	85 d2                	test   %edx,%edx
  8017ee:	75 9c                	jne    80178c <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8017f0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017fa:	48                   	dec    %eax
  8017fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017fe:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801802:	74 3d                	je     801841 <ltostr+0xe2>
		start = 1 ;
  801804:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80180b:	eb 34                	jmp    801841 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80180d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801810:	8b 45 0c             	mov    0xc(%ebp),%eax
  801813:	01 d0                	add    %edx,%eax
  801815:	8a 00                	mov    (%eax),%al
  801817:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80181a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80181d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801820:	01 c2                	add    %eax,%edx
  801822:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801825:	8b 45 0c             	mov    0xc(%ebp),%eax
  801828:	01 c8                	add    %ecx,%eax
  80182a:	8a 00                	mov    (%eax),%al
  80182c:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80182e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801831:	8b 45 0c             	mov    0xc(%ebp),%eax
  801834:	01 c2                	add    %eax,%edx
  801836:	8a 45 eb             	mov    -0x15(%ebp),%al
  801839:	88 02                	mov    %al,(%edx)
		start++ ;
  80183b:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80183e:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801841:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801844:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801847:	7c c4                	jl     80180d <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801849:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80184c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80184f:	01 d0                	add    %edx,%eax
  801851:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801854:	90                   	nop
  801855:	c9                   	leave  
  801856:	c3                   	ret    

00801857 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801857:	55                   	push   %ebp
  801858:	89 e5                	mov    %esp,%ebp
  80185a:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80185d:	ff 75 08             	pushl  0x8(%ebp)
  801860:	e8 54 fa ff ff       	call   8012b9 <strlen>
  801865:	83 c4 04             	add    $0x4,%esp
  801868:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80186b:	ff 75 0c             	pushl  0xc(%ebp)
  80186e:	e8 46 fa ff ff       	call   8012b9 <strlen>
  801873:	83 c4 04             	add    $0x4,%esp
  801876:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801879:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801880:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801887:	eb 17                	jmp    8018a0 <strcconcat+0x49>
		final[s] = str1[s] ;
  801889:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80188c:	8b 45 10             	mov    0x10(%ebp),%eax
  80188f:	01 c2                	add    %eax,%edx
  801891:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801894:	8b 45 08             	mov    0x8(%ebp),%eax
  801897:	01 c8                	add    %ecx,%eax
  801899:	8a 00                	mov    (%eax),%al
  80189b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80189d:	ff 45 fc             	incl   -0x4(%ebp)
  8018a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018a3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018a6:	7c e1                	jl     801889 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8018a8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8018af:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8018b6:	eb 1f                	jmp    8018d7 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8018b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018bb:	8d 50 01             	lea    0x1(%eax),%edx
  8018be:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018c1:	89 c2                	mov    %eax,%edx
  8018c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8018c6:	01 c2                	add    %eax,%edx
  8018c8:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ce:	01 c8                	add    %ecx,%eax
  8018d0:	8a 00                	mov    (%eax),%al
  8018d2:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8018d4:	ff 45 f8             	incl   -0x8(%ebp)
  8018d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018da:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018dd:	7c d9                	jl     8018b8 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8018df:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8018e5:	01 d0                	add    %edx,%eax
  8018e7:	c6 00 00             	movb   $0x0,(%eax)
}
  8018ea:	90                   	nop
  8018eb:	c9                   	leave  
  8018ec:	c3                   	ret    

008018ed <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8018ed:	55                   	push   %ebp
  8018ee:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8018f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8018f3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8018fc:	8b 00                	mov    (%eax),%eax
  8018fe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801905:	8b 45 10             	mov    0x10(%ebp),%eax
  801908:	01 d0                	add    %edx,%eax
  80190a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801910:	eb 0c                	jmp    80191e <strsplit+0x31>
			*string++ = 0;
  801912:	8b 45 08             	mov    0x8(%ebp),%eax
  801915:	8d 50 01             	lea    0x1(%eax),%edx
  801918:	89 55 08             	mov    %edx,0x8(%ebp)
  80191b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80191e:	8b 45 08             	mov    0x8(%ebp),%eax
  801921:	8a 00                	mov    (%eax),%al
  801923:	84 c0                	test   %al,%al
  801925:	74 18                	je     80193f <strsplit+0x52>
  801927:	8b 45 08             	mov    0x8(%ebp),%eax
  80192a:	8a 00                	mov    (%eax),%al
  80192c:	0f be c0             	movsbl %al,%eax
  80192f:	50                   	push   %eax
  801930:	ff 75 0c             	pushl  0xc(%ebp)
  801933:	e8 13 fb ff ff       	call   80144b <strchr>
  801938:	83 c4 08             	add    $0x8,%esp
  80193b:	85 c0                	test   %eax,%eax
  80193d:	75 d3                	jne    801912 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80193f:	8b 45 08             	mov    0x8(%ebp),%eax
  801942:	8a 00                	mov    (%eax),%al
  801944:	84 c0                	test   %al,%al
  801946:	74 5a                	je     8019a2 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801948:	8b 45 14             	mov    0x14(%ebp),%eax
  80194b:	8b 00                	mov    (%eax),%eax
  80194d:	83 f8 0f             	cmp    $0xf,%eax
  801950:	75 07                	jne    801959 <strsplit+0x6c>
		{
			return 0;
  801952:	b8 00 00 00 00       	mov    $0x0,%eax
  801957:	eb 66                	jmp    8019bf <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801959:	8b 45 14             	mov    0x14(%ebp),%eax
  80195c:	8b 00                	mov    (%eax),%eax
  80195e:	8d 48 01             	lea    0x1(%eax),%ecx
  801961:	8b 55 14             	mov    0x14(%ebp),%edx
  801964:	89 0a                	mov    %ecx,(%edx)
  801966:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80196d:	8b 45 10             	mov    0x10(%ebp),%eax
  801970:	01 c2                	add    %eax,%edx
  801972:	8b 45 08             	mov    0x8(%ebp),%eax
  801975:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801977:	eb 03                	jmp    80197c <strsplit+0x8f>
			string++;
  801979:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80197c:	8b 45 08             	mov    0x8(%ebp),%eax
  80197f:	8a 00                	mov    (%eax),%al
  801981:	84 c0                	test   %al,%al
  801983:	74 8b                	je     801910 <strsplit+0x23>
  801985:	8b 45 08             	mov    0x8(%ebp),%eax
  801988:	8a 00                	mov    (%eax),%al
  80198a:	0f be c0             	movsbl %al,%eax
  80198d:	50                   	push   %eax
  80198e:	ff 75 0c             	pushl  0xc(%ebp)
  801991:	e8 b5 fa ff ff       	call   80144b <strchr>
  801996:	83 c4 08             	add    $0x8,%esp
  801999:	85 c0                	test   %eax,%eax
  80199b:	74 dc                	je     801979 <strsplit+0x8c>
			string++;
	}
  80199d:	e9 6e ff ff ff       	jmp    801910 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8019a2:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8019a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8019a6:	8b 00                	mov    (%eax),%eax
  8019a8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019af:	8b 45 10             	mov    0x10(%ebp),%eax
  8019b2:	01 d0                	add    %edx,%eax
  8019b4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019ba:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019bf:	c9                   	leave  
  8019c0:	c3                   	ret    

008019c1 <ClearNodeData>:
 * inside the user heap
 */

struct BuddyNode FreeNodes[BUDDY_NUM_FREE_NODES];
void ClearNodeData(struct BuddyNode* node)
{
  8019c1:	55                   	push   %ebp
  8019c2:	89 e5                	mov    %esp,%ebp
	node->level = 0;
  8019c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c7:	c6 40 11 00          	movb   $0x0,0x11(%eax)
	node->status = FREE;
  8019cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ce:	c6 40 10 00          	movb   $0x0,0x10(%eax)
	node->va = 0;
  8019d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d5:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
	node->parent = NULL;
  8019dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019df:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
	node->myBuddy = NULL;
  8019e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e9:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
}
  8019f0:	90                   	nop
  8019f1:	5d                   	pop    %ebp
  8019f2:	c3                   	ret    

008019f3 <initialize_buddy>:

void initialize_buddy()
{
  8019f3:	55                   	push   %ebp
  8019f4:	89 e5                	mov    %esp,%ebp
  8019f6:	83 ec 10             	sub    $0x10,%esp
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  8019f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801a00:	e9 b7 00 00 00       	jmp    801abc <initialize_buddy+0xc9>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
  801a05:	8b 15 04 31 80 00    	mov    0x803104,%edx
  801a0b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a0e:	89 c8                	mov    %ecx,%eax
  801a10:	01 c0                	add    %eax,%eax
  801a12:	01 c8                	add    %ecx,%eax
  801a14:	c1 e0 03             	shl    $0x3,%eax
  801a17:	05 1c 31 80 00       	add    $0x80311c,%eax
  801a1c:	89 10                	mov    %edx,(%eax)
  801a1e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a21:	89 d0                	mov    %edx,%eax
  801a23:	01 c0                	add    %eax,%eax
  801a25:	01 d0                	add    %edx,%eax
  801a27:	c1 e0 03             	shl    $0x3,%eax
  801a2a:	05 1c 31 80 00       	add    $0x80311c,%eax
  801a2f:	8b 00                	mov    (%eax),%eax
  801a31:	85 c0                	test   %eax,%eax
  801a33:	74 1c                	je     801a51 <initialize_buddy+0x5e>
  801a35:	8b 15 04 31 80 00    	mov    0x803104,%edx
  801a3b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a3e:	89 c8                	mov    %ecx,%eax
  801a40:	01 c0                	add    %eax,%eax
  801a42:	01 c8                	add    %ecx,%eax
  801a44:	c1 e0 03             	shl    $0x3,%eax
  801a47:	05 1c 31 80 00       	add    $0x80311c,%eax
  801a4c:	89 42 04             	mov    %eax,0x4(%edx)
  801a4f:	eb 16                	jmp    801a67 <initialize_buddy+0x74>
  801a51:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a54:	89 d0                	mov    %edx,%eax
  801a56:	01 c0                	add    %eax,%eax
  801a58:	01 d0                	add    %edx,%eax
  801a5a:	c1 e0 03             	shl    $0x3,%eax
  801a5d:	05 1c 31 80 00       	add    $0x80311c,%eax
  801a62:	a3 08 31 80 00       	mov    %eax,0x803108
  801a67:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a6a:	89 d0                	mov    %edx,%eax
  801a6c:	01 c0                	add    %eax,%eax
  801a6e:	01 d0                	add    %edx,%eax
  801a70:	c1 e0 03             	shl    $0x3,%eax
  801a73:	05 1c 31 80 00       	add    $0x80311c,%eax
  801a78:	a3 04 31 80 00       	mov    %eax,0x803104
  801a7d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a80:	89 d0                	mov    %edx,%eax
  801a82:	01 c0                	add    %eax,%eax
  801a84:	01 d0                	add    %edx,%eax
  801a86:	c1 e0 03             	shl    $0x3,%eax
  801a89:	05 20 31 80 00       	add    $0x803120,%eax
  801a8e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801a94:	a1 10 31 80 00       	mov    0x803110,%eax
  801a99:	40                   	inc    %eax
  801a9a:	a3 10 31 80 00       	mov    %eax,0x803110
		ClearNodeData(&(FreeNodes[i]));
  801a9f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801aa2:	89 d0                	mov    %edx,%eax
  801aa4:	01 c0                	add    %eax,%eax
  801aa6:	01 d0                	add    %edx,%eax
  801aa8:	c1 e0 03             	shl    $0x3,%eax
  801aab:	05 1c 31 80 00       	add    $0x80311c,%eax
  801ab0:	50                   	push   %eax
  801ab1:	e8 0b ff ff ff       	call   8019c1 <ClearNodeData>
  801ab6:	83 c4 04             	add    $0x4,%esp
	node->myBuddy = NULL;
}

void initialize_buddy()
{
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  801ab9:	ff 45 fc             	incl   -0x4(%ebp)
  801abc:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801ac0:	0f 8e 3f ff ff ff    	jle    801a05 <initialize_buddy+0x12>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
		ClearNodeData(&(FreeNodes[i]));
	}
}
  801ac6:	90                   	nop
  801ac7:	c9                   	leave  
  801ac8:	c3                   	ret    

00801ac9 <CreateNewBuddySpace>:

/*===============================================================*/

void CreateNewBuddySpace()
{
  801ac9:	55                   	push   %ebp
  801aca:	89 e5                	mov    %esp,%ebp
  801acc:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("CreateNewBuddySpace() is not implemented yet...!!");
  801acf:	83 ec 04             	sub    $0x4,%esp
  801ad2:	68 c4 2b 80 00       	push   $0x802bc4
  801ad7:	6a 1f                	push   $0x1f
  801ad9:	68 f6 2b 80 00       	push   $0x802bf6
  801ade:	e8 97 ec ff ff       	call   80077a <_panic>

00801ae3 <FindAllocationUsingBuddy>:

}

void* FindAllocationUsingBuddy(int size)
{
  801ae3:	55                   	push   %ebp
  801ae4:	89 e5                	mov    %esp,%ebp
  801ae6:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("FindAllocationUsingBuddy() is not implemented yet...!!");
  801ae9:	83 ec 04             	sub    $0x4,%esp
  801aec:	68 04 2c 80 00       	push   $0x802c04
  801af1:	6a 26                	push   $0x26
  801af3:	68 f6 2b 80 00       	push   $0x802bf6
  801af8:	e8 7d ec ff ff       	call   80077a <_panic>

00801afd <FreeAllocationUsingBuddy>:
}

void FreeAllocationUsingBuddy(uint32 va)
{
  801afd:	55                   	push   %ebp
  801afe:	89 e5                	mov    %esp,%ebp
  801b00:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("FreeAllocationUsingBuddy() is not implemented yet...!!");
  801b03:	83 ec 04             	sub    $0x4,%esp
  801b06:	68 3c 2c 80 00       	push   $0x802c3c
  801b0b:	6a 2c                	push   $0x2c
  801b0d:	68 f6 2b 80 00       	push   $0x802bf6
  801b12:	e8 63 ec ff ff       	call   80077a <_panic>

00801b17 <__new>:

}
/*===============================================================*/
void* lastAlloc = (void*) USER_HEAP_START ;
void* __new(uint32 size)
{
  801b17:	55                   	push   %ebp
  801b18:	89 e5                	mov    %esp,%ebp
  801b1a:	83 ec 18             	sub    $0x18,%esp
	void* va = lastAlloc;
  801b1d:	a1 04 30 80 00       	mov    0x803004,%eax
  801b22:	89 45 f4             	mov    %eax,-0xc(%ebp)
	size = ROUNDUP(size, PAGE_SIZE) ;
  801b25:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
  801b2c:	8b 55 08             	mov    0x8(%ebp),%edx
  801b2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b32:	01 d0                	add    %edx,%eax
  801b34:	48                   	dec    %eax
  801b35:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801b38:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b3b:	ba 00 00 00 00       	mov    $0x0,%edx
  801b40:	f7 75 f0             	divl   -0x10(%ebp)
  801b43:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b46:	29 d0                	sub    %edx,%eax
  801b48:	89 45 08             	mov    %eax,0x8(%ebp)
	sys_new((uint32)va, size) ;
  801b4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b4e:	83 ec 08             	sub    $0x8,%esp
  801b51:	ff 75 08             	pushl  0x8(%ebp)
  801b54:	50                   	push   %eax
  801b55:	e8 75 06 00 00       	call   8021cf <sys_new>
  801b5a:	83 c4 10             	add    $0x10,%esp
	lastAlloc += size ;
  801b5d:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801b63:	8b 45 08             	mov    0x8(%ebp),%eax
  801b66:	01 d0                	add    %edx,%eax
  801b68:	a3 04 30 80 00       	mov    %eax,0x803004
	return va ;
  801b6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801b70:	c9                   	leave  
  801b71:	c3                   	ret    

00801b72 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b72:	55                   	push   %ebp
  801b73:	89 e5                	mov    %esp,%ebp
  801b75:	57                   	push   %edi
  801b76:	56                   	push   %esi
  801b77:	53                   	push   %ebx
  801b78:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801b7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b81:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b84:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b87:	8b 7d 18             	mov    0x18(%ebp),%edi
  801b8a:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801b8d:	cd 30                	int    $0x30
  801b8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801b92:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b95:	83 c4 10             	add    $0x10,%esp
  801b98:	5b                   	pop    %ebx
  801b99:	5e                   	pop    %esi
  801b9a:	5f                   	pop    %edi
  801b9b:	5d                   	pop    %ebp
  801b9c:	c3                   	ret    

00801b9d <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801b9d:	55                   	push   %ebp
  801b9e:	89 e5                	mov    %esp,%ebp
  801ba0:	83 ec 04             	sub    $0x4,%esp
  801ba3:	8b 45 10             	mov    0x10(%ebp),%eax
  801ba6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801ba9:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801bad:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 00                	push   $0x0
  801bb4:	52                   	push   %edx
  801bb5:	ff 75 0c             	pushl  0xc(%ebp)
  801bb8:	50                   	push   %eax
  801bb9:	6a 00                	push   $0x0
  801bbb:	e8 b2 ff ff ff       	call   801b72 <syscall>
  801bc0:	83 c4 18             	add    $0x18,%esp
}
  801bc3:	90                   	nop
  801bc4:	c9                   	leave  
  801bc5:	c3                   	ret    

00801bc6 <sys_cgetc>:

int
sys_cgetc(void)
{
  801bc6:	55                   	push   %ebp
  801bc7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801bc9:	6a 00                	push   $0x0
  801bcb:	6a 00                	push   $0x0
  801bcd:	6a 00                	push   $0x0
  801bcf:	6a 00                	push   $0x0
  801bd1:	6a 00                	push   $0x0
  801bd3:	6a 01                	push   $0x1
  801bd5:	e8 98 ff ff ff       	call   801b72 <syscall>
  801bda:	83 c4 18             	add    $0x18,%esp
}
  801bdd:	c9                   	leave  
  801bde:	c3                   	ret    

00801bdf <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801bdf:	55                   	push   %ebp
  801be0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801be2:	8b 45 08             	mov    0x8(%ebp),%eax
  801be5:	6a 00                	push   $0x0
  801be7:	6a 00                	push   $0x0
  801be9:	6a 00                	push   $0x0
  801beb:	6a 00                	push   $0x0
  801bed:	50                   	push   %eax
  801bee:	6a 05                	push   $0x5
  801bf0:	e8 7d ff ff ff       	call   801b72 <syscall>
  801bf5:	83 c4 18             	add    $0x18,%esp
}
  801bf8:	c9                   	leave  
  801bf9:	c3                   	ret    

00801bfa <sys_getenvid>:

int32 sys_getenvid(void)
{
  801bfa:	55                   	push   %ebp
  801bfb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	6a 02                	push   $0x2
  801c09:	e8 64 ff ff ff       	call   801b72 <syscall>
  801c0e:	83 c4 18             	add    $0x18,%esp
}
  801c11:	c9                   	leave  
  801c12:	c3                   	ret    

00801c13 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801c13:	55                   	push   %ebp
  801c14:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 00                	push   $0x0
  801c20:	6a 03                	push   $0x3
  801c22:	e8 4b ff ff ff       	call   801b72 <syscall>
  801c27:	83 c4 18             	add    $0x18,%esp
}
  801c2a:	c9                   	leave  
  801c2b:	c3                   	ret    

00801c2c <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801c2c:	55                   	push   %ebp
  801c2d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 00                	push   $0x0
  801c33:	6a 00                	push   $0x0
  801c35:	6a 00                	push   $0x0
  801c37:	6a 00                	push   $0x0
  801c39:	6a 04                	push   $0x4
  801c3b:	e8 32 ff ff ff       	call   801b72 <syscall>
  801c40:	83 c4 18             	add    $0x18,%esp
}
  801c43:	c9                   	leave  
  801c44:	c3                   	ret    

00801c45 <sys_env_exit>:


void sys_env_exit(void)
{
  801c45:	55                   	push   %ebp
  801c46:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 00                	push   $0x0
  801c52:	6a 06                	push   $0x6
  801c54:	e8 19 ff ff ff       	call   801b72 <syscall>
  801c59:	83 c4 18             	add    $0x18,%esp
}
  801c5c:	90                   	nop
  801c5d:	c9                   	leave  
  801c5e:	c3                   	ret    

00801c5f <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801c5f:	55                   	push   %ebp
  801c60:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801c62:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c65:	8b 45 08             	mov    0x8(%ebp),%eax
  801c68:	6a 00                	push   $0x0
  801c6a:	6a 00                	push   $0x0
  801c6c:	6a 00                	push   $0x0
  801c6e:	52                   	push   %edx
  801c6f:	50                   	push   %eax
  801c70:	6a 07                	push   $0x7
  801c72:	e8 fb fe ff ff       	call   801b72 <syscall>
  801c77:	83 c4 18             	add    $0x18,%esp
}
  801c7a:	c9                   	leave  
  801c7b:	c3                   	ret    

00801c7c <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801c7c:	55                   	push   %ebp
  801c7d:	89 e5                	mov    %esp,%ebp
  801c7f:	56                   	push   %esi
  801c80:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801c81:	8b 75 18             	mov    0x18(%ebp),%esi
  801c84:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c87:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c90:	56                   	push   %esi
  801c91:	53                   	push   %ebx
  801c92:	51                   	push   %ecx
  801c93:	52                   	push   %edx
  801c94:	50                   	push   %eax
  801c95:	6a 08                	push   $0x8
  801c97:	e8 d6 fe ff ff       	call   801b72 <syscall>
  801c9c:	83 c4 18             	add    $0x18,%esp
}
  801c9f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ca2:	5b                   	pop    %ebx
  801ca3:	5e                   	pop    %esi
  801ca4:	5d                   	pop    %ebp
  801ca5:	c3                   	ret    

00801ca6 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801ca6:	55                   	push   %ebp
  801ca7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801ca9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cac:	8b 45 08             	mov    0x8(%ebp),%eax
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	52                   	push   %edx
  801cb6:	50                   	push   %eax
  801cb7:	6a 09                	push   $0x9
  801cb9:	e8 b4 fe ff ff       	call   801b72 <syscall>
  801cbe:	83 c4 18             	add    $0x18,%esp
}
  801cc1:	c9                   	leave  
  801cc2:	c3                   	ret    

00801cc3 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801cc3:	55                   	push   %ebp
  801cc4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	ff 75 0c             	pushl  0xc(%ebp)
  801ccf:	ff 75 08             	pushl  0x8(%ebp)
  801cd2:	6a 0a                	push   $0xa
  801cd4:	e8 99 fe ff ff       	call   801b72 <syscall>
  801cd9:	83 c4 18             	add    $0x18,%esp
}
  801cdc:	c9                   	leave  
  801cdd:	c3                   	ret    

00801cde <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801cde:	55                   	push   %ebp
  801cdf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 00                	push   $0x0
  801ceb:	6a 0b                	push   $0xb
  801ced:	e8 80 fe ff ff       	call   801b72 <syscall>
  801cf2:	83 c4 18             	add    $0x18,%esp
}
  801cf5:	c9                   	leave  
  801cf6:	c3                   	ret    

00801cf7 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801cf7:	55                   	push   %ebp
  801cf8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801cfa:	6a 00                	push   $0x0
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	6a 00                	push   $0x0
  801d04:	6a 0c                	push   $0xc
  801d06:	e8 67 fe ff ff       	call   801b72 <syscall>
  801d0b:	83 c4 18             	add    $0x18,%esp
}
  801d0e:	c9                   	leave  
  801d0f:	c3                   	ret    

00801d10 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801d10:	55                   	push   %ebp
  801d11:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801d13:	6a 00                	push   $0x0
  801d15:	6a 00                	push   $0x0
  801d17:	6a 00                	push   $0x0
  801d19:	6a 00                	push   $0x0
  801d1b:	6a 00                	push   $0x0
  801d1d:	6a 0d                	push   $0xd
  801d1f:	e8 4e fe ff ff       	call   801b72 <syscall>
  801d24:	83 c4 18             	add    $0x18,%esp
}
  801d27:	c9                   	leave  
  801d28:	c3                   	ret    

00801d29 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801d29:	55                   	push   %ebp
  801d2a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 00                	push   $0x0
  801d32:	ff 75 0c             	pushl  0xc(%ebp)
  801d35:	ff 75 08             	pushl  0x8(%ebp)
  801d38:	6a 11                	push   $0x11
  801d3a:	e8 33 fe ff ff       	call   801b72 <syscall>
  801d3f:	83 c4 18             	add    $0x18,%esp
	return;
  801d42:	90                   	nop
}
  801d43:	c9                   	leave  
  801d44:	c3                   	ret    

00801d45 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801d45:	55                   	push   %ebp
  801d46:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801d48:	6a 00                	push   $0x0
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	ff 75 0c             	pushl  0xc(%ebp)
  801d51:	ff 75 08             	pushl  0x8(%ebp)
  801d54:	6a 12                	push   $0x12
  801d56:	e8 17 fe ff ff       	call   801b72 <syscall>
  801d5b:	83 c4 18             	add    $0x18,%esp
	return ;
  801d5e:	90                   	nop
}
  801d5f:	c9                   	leave  
  801d60:	c3                   	ret    

00801d61 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801d61:	55                   	push   %ebp
  801d62:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801d64:	6a 00                	push   $0x0
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 00                	push   $0x0
  801d6c:	6a 00                	push   $0x0
  801d6e:	6a 0e                	push   $0xe
  801d70:	e8 fd fd ff ff       	call   801b72 <syscall>
  801d75:	83 c4 18             	add    $0x18,%esp
}
  801d78:	c9                   	leave  
  801d79:	c3                   	ret    

00801d7a <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801d7a:	55                   	push   %ebp
  801d7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	ff 75 08             	pushl  0x8(%ebp)
  801d88:	6a 0f                	push   $0xf
  801d8a:	e8 e3 fd ff ff       	call   801b72 <syscall>
  801d8f:	83 c4 18             	add    $0x18,%esp
}
  801d92:	c9                   	leave  
  801d93:	c3                   	ret    

00801d94 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801d94:	55                   	push   %ebp
  801d95:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801d97:	6a 00                	push   $0x0
  801d99:	6a 00                	push   $0x0
  801d9b:	6a 00                	push   $0x0
  801d9d:	6a 00                	push   $0x0
  801d9f:	6a 00                	push   $0x0
  801da1:	6a 10                	push   $0x10
  801da3:	e8 ca fd ff ff       	call   801b72 <syscall>
  801da8:	83 c4 18             	add    $0x18,%esp
}
  801dab:	90                   	nop
  801dac:	c9                   	leave  
  801dad:	c3                   	ret    

00801dae <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801dae:	55                   	push   %ebp
  801daf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801db1:	6a 00                	push   $0x0
  801db3:	6a 00                	push   $0x0
  801db5:	6a 00                	push   $0x0
  801db7:	6a 00                	push   $0x0
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 14                	push   $0x14
  801dbd:	e8 b0 fd ff ff       	call   801b72 <syscall>
  801dc2:	83 c4 18             	add    $0x18,%esp
}
  801dc5:	90                   	nop
  801dc6:	c9                   	leave  
  801dc7:	c3                   	ret    

00801dc8 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801dc8:	55                   	push   %ebp
  801dc9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801dcb:	6a 00                	push   $0x0
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 00                	push   $0x0
  801dd1:	6a 00                	push   $0x0
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 15                	push   $0x15
  801dd7:	e8 96 fd ff ff       	call   801b72 <syscall>
  801ddc:	83 c4 18             	add    $0x18,%esp
}
  801ddf:	90                   	nop
  801de0:	c9                   	leave  
  801de1:	c3                   	ret    

00801de2 <sys_cputc>:


void
sys_cputc(const char c)
{
  801de2:	55                   	push   %ebp
  801de3:	89 e5                	mov    %esp,%ebp
  801de5:	83 ec 04             	sub    $0x4,%esp
  801de8:	8b 45 08             	mov    0x8(%ebp),%eax
  801deb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801dee:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801df2:	6a 00                	push   $0x0
  801df4:	6a 00                	push   $0x0
  801df6:	6a 00                	push   $0x0
  801df8:	6a 00                	push   $0x0
  801dfa:	50                   	push   %eax
  801dfb:	6a 16                	push   $0x16
  801dfd:	e8 70 fd ff ff       	call   801b72 <syscall>
  801e02:	83 c4 18             	add    $0x18,%esp
}
  801e05:	90                   	nop
  801e06:	c9                   	leave  
  801e07:	c3                   	ret    

00801e08 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e08:	55                   	push   %ebp
  801e09:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e0b:	6a 00                	push   $0x0
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 00                	push   $0x0
  801e11:	6a 00                	push   $0x0
  801e13:	6a 00                	push   $0x0
  801e15:	6a 17                	push   $0x17
  801e17:	e8 56 fd ff ff       	call   801b72 <syscall>
  801e1c:	83 c4 18             	add    $0x18,%esp
}
  801e1f:	90                   	nop
  801e20:	c9                   	leave  
  801e21:	c3                   	ret    

00801e22 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801e22:	55                   	push   %ebp
  801e23:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801e25:	8b 45 08             	mov    0x8(%ebp),%eax
  801e28:	6a 00                	push   $0x0
  801e2a:	6a 00                	push   $0x0
  801e2c:	6a 00                	push   $0x0
  801e2e:	ff 75 0c             	pushl  0xc(%ebp)
  801e31:	50                   	push   %eax
  801e32:	6a 18                	push   $0x18
  801e34:	e8 39 fd ff ff       	call   801b72 <syscall>
  801e39:	83 c4 18             	add    $0x18,%esp
}
  801e3c:	c9                   	leave  
  801e3d:	c3                   	ret    

00801e3e <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e3e:	55                   	push   %ebp
  801e3f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e41:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e44:	8b 45 08             	mov    0x8(%ebp),%eax
  801e47:	6a 00                	push   $0x0
  801e49:	6a 00                	push   $0x0
  801e4b:	6a 00                	push   $0x0
  801e4d:	52                   	push   %edx
  801e4e:	50                   	push   %eax
  801e4f:	6a 1b                	push   $0x1b
  801e51:	e8 1c fd ff ff       	call   801b72 <syscall>
  801e56:	83 c4 18             	add    $0x18,%esp
}
  801e59:	c9                   	leave  
  801e5a:	c3                   	ret    

00801e5b <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e5b:	55                   	push   %ebp
  801e5c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e61:	8b 45 08             	mov    0x8(%ebp),%eax
  801e64:	6a 00                	push   $0x0
  801e66:	6a 00                	push   $0x0
  801e68:	6a 00                	push   $0x0
  801e6a:	52                   	push   %edx
  801e6b:	50                   	push   %eax
  801e6c:	6a 19                	push   $0x19
  801e6e:	e8 ff fc ff ff       	call   801b72 <syscall>
  801e73:	83 c4 18             	add    $0x18,%esp
}
  801e76:	90                   	nop
  801e77:	c9                   	leave  
  801e78:	c3                   	ret    

00801e79 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e79:	55                   	push   %ebp
  801e7a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e82:	6a 00                	push   $0x0
  801e84:	6a 00                	push   $0x0
  801e86:	6a 00                	push   $0x0
  801e88:	52                   	push   %edx
  801e89:	50                   	push   %eax
  801e8a:	6a 1a                	push   $0x1a
  801e8c:	e8 e1 fc ff ff       	call   801b72 <syscall>
  801e91:	83 c4 18             	add    $0x18,%esp
}
  801e94:	90                   	nop
  801e95:	c9                   	leave  
  801e96:	c3                   	ret    

00801e97 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801e97:	55                   	push   %ebp
  801e98:	89 e5                	mov    %esp,%ebp
  801e9a:	83 ec 04             	sub    $0x4,%esp
  801e9d:	8b 45 10             	mov    0x10(%ebp),%eax
  801ea0:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801ea3:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ea6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801eaa:	8b 45 08             	mov    0x8(%ebp),%eax
  801ead:	6a 00                	push   $0x0
  801eaf:	51                   	push   %ecx
  801eb0:	52                   	push   %edx
  801eb1:	ff 75 0c             	pushl  0xc(%ebp)
  801eb4:	50                   	push   %eax
  801eb5:	6a 1c                	push   $0x1c
  801eb7:	e8 b6 fc ff ff       	call   801b72 <syscall>
  801ebc:	83 c4 18             	add    $0x18,%esp
}
  801ebf:	c9                   	leave  
  801ec0:	c3                   	ret    

00801ec1 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801ec1:	55                   	push   %ebp
  801ec2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801ec4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ec7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eca:	6a 00                	push   $0x0
  801ecc:	6a 00                	push   $0x0
  801ece:	6a 00                	push   $0x0
  801ed0:	52                   	push   %edx
  801ed1:	50                   	push   %eax
  801ed2:	6a 1d                	push   $0x1d
  801ed4:	e8 99 fc ff ff       	call   801b72 <syscall>
  801ed9:	83 c4 18             	add    $0x18,%esp
}
  801edc:	c9                   	leave  
  801edd:	c3                   	ret    

00801ede <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801ede:	55                   	push   %ebp
  801edf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801ee1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ee4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ee7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eea:	6a 00                	push   $0x0
  801eec:	6a 00                	push   $0x0
  801eee:	51                   	push   %ecx
  801eef:	52                   	push   %edx
  801ef0:	50                   	push   %eax
  801ef1:	6a 1e                	push   $0x1e
  801ef3:	e8 7a fc ff ff       	call   801b72 <syscall>
  801ef8:	83 c4 18             	add    $0x18,%esp
}
  801efb:	c9                   	leave  
  801efc:	c3                   	ret    

00801efd <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801efd:	55                   	push   %ebp
  801efe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f00:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f03:	8b 45 08             	mov    0x8(%ebp),%eax
  801f06:	6a 00                	push   $0x0
  801f08:	6a 00                	push   $0x0
  801f0a:	6a 00                	push   $0x0
  801f0c:	52                   	push   %edx
  801f0d:	50                   	push   %eax
  801f0e:	6a 1f                	push   $0x1f
  801f10:	e8 5d fc ff ff       	call   801b72 <syscall>
  801f15:	83 c4 18             	add    $0x18,%esp
}
  801f18:	c9                   	leave  
  801f19:	c3                   	ret    

00801f1a <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801f1a:	55                   	push   %ebp
  801f1b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801f1d:	6a 00                	push   $0x0
  801f1f:	6a 00                	push   $0x0
  801f21:	6a 00                	push   $0x0
  801f23:	6a 00                	push   $0x0
  801f25:	6a 00                	push   $0x0
  801f27:	6a 20                	push   $0x20
  801f29:	e8 44 fc ff ff       	call   801b72 <syscall>
  801f2e:	83 c4 18             	add    $0x18,%esp
}
  801f31:	c9                   	leave  
  801f32:	c3                   	ret    

00801f33 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801f33:	55                   	push   %ebp
  801f34:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801f36:	8b 45 08             	mov    0x8(%ebp),%eax
  801f39:	6a 00                	push   $0x0
  801f3b:	ff 75 14             	pushl  0x14(%ebp)
  801f3e:	ff 75 10             	pushl  0x10(%ebp)
  801f41:	ff 75 0c             	pushl  0xc(%ebp)
  801f44:	50                   	push   %eax
  801f45:	6a 21                	push   $0x21
  801f47:	e8 26 fc ff ff       	call   801b72 <syscall>
  801f4c:	83 c4 18             	add    $0x18,%esp
}
  801f4f:	c9                   	leave  
  801f50:	c3                   	ret    

00801f51 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801f51:	55                   	push   %ebp
  801f52:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f54:	8b 45 08             	mov    0x8(%ebp),%eax
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	6a 00                	push   $0x0
  801f5d:	6a 00                	push   $0x0
  801f5f:	50                   	push   %eax
  801f60:	6a 22                	push   $0x22
  801f62:	e8 0b fc ff ff       	call   801b72 <syscall>
  801f67:	83 c4 18             	add    $0x18,%esp
}
  801f6a:	90                   	nop
  801f6b:	c9                   	leave  
  801f6c:	c3                   	ret    

00801f6d <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801f6d:	55                   	push   %ebp
  801f6e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801f70:	8b 45 08             	mov    0x8(%ebp),%eax
  801f73:	6a 00                	push   $0x0
  801f75:	6a 00                	push   $0x0
  801f77:	6a 00                	push   $0x0
  801f79:	6a 00                	push   $0x0
  801f7b:	50                   	push   %eax
  801f7c:	6a 23                	push   $0x23
  801f7e:	e8 ef fb ff ff       	call   801b72 <syscall>
  801f83:	83 c4 18             	add    $0x18,%esp
}
  801f86:	90                   	nop
  801f87:	c9                   	leave  
  801f88:	c3                   	ret    

00801f89 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801f89:	55                   	push   %ebp
  801f8a:	89 e5                	mov    %esp,%ebp
  801f8c:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801f8f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f92:	8d 50 04             	lea    0x4(%eax),%edx
  801f95:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 00                	push   $0x0
  801f9c:	6a 00                	push   $0x0
  801f9e:	52                   	push   %edx
  801f9f:	50                   	push   %eax
  801fa0:	6a 24                	push   $0x24
  801fa2:	e8 cb fb ff ff       	call   801b72 <syscall>
  801fa7:	83 c4 18             	add    $0x18,%esp
	return result;
  801faa:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801fad:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801fb0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801fb3:	89 01                	mov    %eax,(%ecx)
  801fb5:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  801fbb:	c9                   	leave  
  801fbc:	c2 04 00             	ret    $0x4

00801fbf <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801fbf:	55                   	push   %ebp
  801fc0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801fc2:	6a 00                	push   $0x0
  801fc4:	6a 00                	push   $0x0
  801fc6:	ff 75 10             	pushl  0x10(%ebp)
  801fc9:	ff 75 0c             	pushl  0xc(%ebp)
  801fcc:	ff 75 08             	pushl  0x8(%ebp)
  801fcf:	6a 13                	push   $0x13
  801fd1:	e8 9c fb ff ff       	call   801b72 <syscall>
  801fd6:	83 c4 18             	add    $0x18,%esp
	return ;
  801fd9:	90                   	nop
}
  801fda:	c9                   	leave  
  801fdb:	c3                   	ret    

00801fdc <sys_rcr2>:
uint32 sys_rcr2()
{
  801fdc:	55                   	push   %ebp
  801fdd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801fdf:	6a 00                	push   $0x0
  801fe1:	6a 00                	push   $0x0
  801fe3:	6a 00                	push   $0x0
  801fe5:	6a 00                	push   $0x0
  801fe7:	6a 00                	push   $0x0
  801fe9:	6a 25                	push   $0x25
  801feb:	e8 82 fb ff ff       	call   801b72 <syscall>
  801ff0:	83 c4 18             	add    $0x18,%esp
}
  801ff3:	c9                   	leave  
  801ff4:	c3                   	ret    

00801ff5 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801ff5:	55                   	push   %ebp
  801ff6:	89 e5                	mov    %esp,%ebp
  801ff8:	83 ec 04             	sub    $0x4,%esp
  801ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ffe:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802001:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802005:	6a 00                	push   $0x0
  802007:	6a 00                	push   $0x0
  802009:	6a 00                	push   $0x0
  80200b:	6a 00                	push   $0x0
  80200d:	50                   	push   %eax
  80200e:	6a 26                	push   $0x26
  802010:	e8 5d fb ff ff       	call   801b72 <syscall>
  802015:	83 c4 18             	add    $0x18,%esp
	return ;
  802018:	90                   	nop
}
  802019:	c9                   	leave  
  80201a:	c3                   	ret    

0080201b <rsttst>:
void rsttst()
{
  80201b:	55                   	push   %ebp
  80201c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80201e:	6a 00                	push   $0x0
  802020:	6a 00                	push   $0x0
  802022:	6a 00                	push   $0x0
  802024:	6a 00                	push   $0x0
  802026:	6a 00                	push   $0x0
  802028:	6a 28                	push   $0x28
  80202a:	e8 43 fb ff ff       	call   801b72 <syscall>
  80202f:	83 c4 18             	add    $0x18,%esp
	return ;
  802032:	90                   	nop
}
  802033:	c9                   	leave  
  802034:	c3                   	ret    

00802035 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802035:	55                   	push   %ebp
  802036:	89 e5                	mov    %esp,%ebp
  802038:	83 ec 04             	sub    $0x4,%esp
  80203b:	8b 45 14             	mov    0x14(%ebp),%eax
  80203e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802041:	8b 55 18             	mov    0x18(%ebp),%edx
  802044:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802048:	52                   	push   %edx
  802049:	50                   	push   %eax
  80204a:	ff 75 10             	pushl  0x10(%ebp)
  80204d:	ff 75 0c             	pushl  0xc(%ebp)
  802050:	ff 75 08             	pushl  0x8(%ebp)
  802053:	6a 27                	push   $0x27
  802055:	e8 18 fb ff ff       	call   801b72 <syscall>
  80205a:	83 c4 18             	add    $0x18,%esp
	return ;
  80205d:	90                   	nop
}
  80205e:	c9                   	leave  
  80205f:	c3                   	ret    

00802060 <chktst>:
void chktst(uint32 n)
{
  802060:	55                   	push   %ebp
  802061:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802063:	6a 00                	push   $0x0
  802065:	6a 00                	push   $0x0
  802067:	6a 00                	push   $0x0
  802069:	6a 00                	push   $0x0
  80206b:	ff 75 08             	pushl  0x8(%ebp)
  80206e:	6a 29                	push   $0x29
  802070:	e8 fd fa ff ff       	call   801b72 <syscall>
  802075:	83 c4 18             	add    $0x18,%esp
	return ;
  802078:	90                   	nop
}
  802079:	c9                   	leave  
  80207a:	c3                   	ret    

0080207b <inctst>:

void inctst()
{
  80207b:	55                   	push   %ebp
  80207c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80207e:	6a 00                	push   $0x0
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	6a 00                	push   $0x0
  802088:	6a 2a                	push   $0x2a
  80208a:	e8 e3 fa ff ff       	call   801b72 <syscall>
  80208f:	83 c4 18             	add    $0x18,%esp
	return ;
  802092:	90                   	nop
}
  802093:	c9                   	leave  
  802094:	c3                   	ret    

00802095 <gettst>:
uint32 gettst()
{
  802095:	55                   	push   %ebp
  802096:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802098:	6a 00                	push   $0x0
  80209a:	6a 00                	push   $0x0
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 2b                	push   $0x2b
  8020a4:	e8 c9 fa ff ff       	call   801b72 <syscall>
  8020a9:	83 c4 18             	add    $0x18,%esp
}
  8020ac:	c9                   	leave  
  8020ad:	c3                   	ret    

008020ae <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8020ae:	55                   	push   %ebp
  8020af:	89 e5                	mov    %esp,%ebp
  8020b1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020b4:	6a 00                	push   $0x0
  8020b6:	6a 00                	push   $0x0
  8020b8:	6a 00                	push   $0x0
  8020ba:	6a 00                	push   $0x0
  8020bc:	6a 00                	push   $0x0
  8020be:	6a 2c                	push   $0x2c
  8020c0:	e8 ad fa ff ff       	call   801b72 <syscall>
  8020c5:	83 c4 18             	add    $0x18,%esp
  8020c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8020cb:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8020cf:	75 07                	jne    8020d8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8020d1:	b8 01 00 00 00       	mov    $0x1,%eax
  8020d6:	eb 05                	jmp    8020dd <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8020d8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020dd:	c9                   	leave  
  8020de:	c3                   	ret    

008020df <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8020df:	55                   	push   %ebp
  8020e0:	89 e5                	mov    %esp,%ebp
  8020e2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020e5:	6a 00                	push   $0x0
  8020e7:	6a 00                	push   $0x0
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 00                	push   $0x0
  8020ef:	6a 2c                	push   $0x2c
  8020f1:	e8 7c fa ff ff       	call   801b72 <syscall>
  8020f6:	83 c4 18             	add    $0x18,%esp
  8020f9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8020fc:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802100:	75 07                	jne    802109 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802102:	b8 01 00 00 00       	mov    $0x1,%eax
  802107:	eb 05                	jmp    80210e <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802109:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80210e:	c9                   	leave  
  80210f:	c3                   	ret    

00802110 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802110:	55                   	push   %ebp
  802111:	89 e5                	mov    %esp,%ebp
  802113:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802116:	6a 00                	push   $0x0
  802118:	6a 00                	push   $0x0
  80211a:	6a 00                	push   $0x0
  80211c:	6a 00                	push   $0x0
  80211e:	6a 00                	push   $0x0
  802120:	6a 2c                	push   $0x2c
  802122:	e8 4b fa ff ff       	call   801b72 <syscall>
  802127:	83 c4 18             	add    $0x18,%esp
  80212a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80212d:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802131:	75 07                	jne    80213a <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802133:	b8 01 00 00 00       	mov    $0x1,%eax
  802138:	eb 05                	jmp    80213f <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80213a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80213f:	c9                   	leave  
  802140:	c3                   	ret    

00802141 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802141:	55                   	push   %ebp
  802142:	89 e5                	mov    %esp,%ebp
  802144:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802147:	6a 00                	push   $0x0
  802149:	6a 00                	push   $0x0
  80214b:	6a 00                	push   $0x0
  80214d:	6a 00                	push   $0x0
  80214f:	6a 00                	push   $0x0
  802151:	6a 2c                	push   $0x2c
  802153:	e8 1a fa ff ff       	call   801b72 <syscall>
  802158:	83 c4 18             	add    $0x18,%esp
  80215b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80215e:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802162:	75 07                	jne    80216b <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802164:	b8 01 00 00 00       	mov    $0x1,%eax
  802169:	eb 05                	jmp    802170 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80216b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802170:	c9                   	leave  
  802171:	c3                   	ret    

00802172 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802172:	55                   	push   %ebp
  802173:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802175:	6a 00                	push   $0x0
  802177:	6a 00                	push   $0x0
  802179:	6a 00                	push   $0x0
  80217b:	6a 00                	push   $0x0
  80217d:	ff 75 08             	pushl  0x8(%ebp)
  802180:	6a 2d                	push   $0x2d
  802182:	e8 eb f9 ff ff       	call   801b72 <syscall>
  802187:	83 c4 18             	add    $0x18,%esp
	return ;
  80218a:	90                   	nop
}
  80218b:	c9                   	leave  
  80218c:	c3                   	ret    

0080218d <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80218d:	55                   	push   %ebp
  80218e:	89 e5                	mov    %esp,%ebp
  802190:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802191:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802194:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802197:	8b 55 0c             	mov    0xc(%ebp),%edx
  80219a:	8b 45 08             	mov    0x8(%ebp),%eax
  80219d:	6a 00                	push   $0x0
  80219f:	53                   	push   %ebx
  8021a0:	51                   	push   %ecx
  8021a1:	52                   	push   %edx
  8021a2:	50                   	push   %eax
  8021a3:	6a 2e                	push   $0x2e
  8021a5:	e8 c8 f9 ff ff       	call   801b72 <syscall>
  8021aa:	83 c4 18             	add    $0x18,%esp
}
  8021ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8021b0:	c9                   	leave  
  8021b1:	c3                   	ret    

008021b2 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8021b2:	55                   	push   %ebp
  8021b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8021b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8021bb:	6a 00                	push   $0x0
  8021bd:	6a 00                	push   $0x0
  8021bf:	6a 00                	push   $0x0
  8021c1:	52                   	push   %edx
  8021c2:	50                   	push   %eax
  8021c3:	6a 2f                	push   $0x2f
  8021c5:	e8 a8 f9 ff ff       	call   801b72 <syscall>
  8021ca:	83 c4 18             	add    $0x18,%esp
}
  8021cd:	c9                   	leave  
  8021ce:	c3                   	ret    

008021cf <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8021cf:	55                   	push   %ebp
  8021d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8021d2:	6a 00                	push   $0x0
  8021d4:	6a 00                	push   $0x0
  8021d6:	6a 00                	push   $0x0
  8021d8:	ff 75 0c             	pushl  0xc(%ebp)
  8021db:	ff 75 08             	pushl  0x8(%ebp)
  8021de:	6a 30                	push   $0x30
  8021e0:	e8 8d f9 ff ff       	call   801b72 <syscall>
  8021e5:	83 c4 18             	add    $0x18,%esp
	return ;
  8021e8:	90                   	nop
}
  8021e9:	c9                   	leave  
  8021ea:	c3                   	ret    
  8021eb:	90                   	nop

008021ec <__udivdi3>:
  8021ec:	55                   	push   %ebp
  8021ed:	57                   	push   %edi
  8021ee:	56                   	push   %esi
  8021ef:	53                   	push   %ebx
  8021f0:	83 ec 1c             	sub    $0x1c,%esp
  8021f3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8021f7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8021fb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021ff:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802203:	89 ca                	mov    %ecx,%edx
  802205:	89 f8                	mov    %edi,%eax
  802207:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80220b:	85 f6                	test   %esi,%esi
  80220d:	75 2d                	jne    80223c <__udivdi3+0x50>
  80220f:	39 cf                	cmp    %ecx,%edi
  802211:	77 65                	ja     802278 <__udivdi3+0x8c>
  802213:	89 fd                	mov    %edi,%ebp
  802215:	85 ff                	test   %edi,%edi
  802217:	75 0b                	jne    802224 <__udivdi3+0x38>
  802219:	b8 01 00 00 00       	mov    $0x1,%eax
  80221e:	31 d2                	xor    %edx,%edx
  802220:	f7 f7                	div    %edi
  802222:	89 c5                	mov    %eax,%ebp
  802224:	31 d2                	xor    %edx,%edx
  802226:	89 c8                	mov    %ecx,%eax
  802228:	f7 f5                	div    %ebp
  80222a:	89 c1                	mov    %eax,%ecx
  80222c:	89 d8                	mov    %ebx,%eax
  80222e:	f7 f5                	div    %ebp
  802230:	89 cf                	mov    %ecx,%edi
  802232:	89 fa                	mov    %edi,%edx
  802234:	83 c4 1c             	add    $0x1c,%esp
  802237:	5b                   	pop    %ebx
  802238:	5e                   	pop    %esi
  802239:	5f                   	pop    %edi
  80223a:	5d                   	pop    %ebp
  80223b:	c3                   	ret    
  80223c:	39 ce                	cmp    %ecx,%esi
  80223e:	77 28                	ja     802268 <__udivdi3+0x7c>
  802240:	0f bd fe             	bsr    %esi,%edi
  802243:	83 f7 1f             	xor    $0x1f,%edi
  802246:	75 40                	jne    802288 <__udivdi3+0x9c>
  802248:	39 ce                	cmp    %ecx,%esi
  80224a:	72 0a                	jb     802256 <__udivdi3+0x6a>
  80224c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802250:	0f 87 9e 00 00 00    	ja     8022f4 <__udivdi3+0x108>
  802256:	b8 01 00 00 00       	mov    $0x1,%eax
  80225b:	89 fa                	mov    %edi,%edx
  80225d:	83 c4 1c             	add    $0x1c,%esp
  802260:	5b                   	pop    %ebx
  802261:	5e                   	pop    %esi
  802262:	5f                   	pop    %edi
  802263:	5d                   	pop    %ebp
  802264:	c3                   	ret    
  802265:	8d 76 00             	lea    0x0(%esi),%esi
  802268:	31 ff                	xor    %edi,%edi
  80226a:	31 c0                	xor    %eax,%eax
  80226c:	89 fa                	mov    %edi,%edx
  80226e:	83 c4 1c             	add    $0x1c,%esp
  802271:	5b                   	pop    %ebx
  802272:	5e                   	pop    %esi
  802273:	5f                   	pop    %edi
  802274:	5d                   	pop    %ebp
  802275:	c3                   	ret    
  802276:	66 90                	xchg   %ax,%ax
  802278:	89 d8                	mov    %ebx,%eax
  80227a:	f7 f7                	div    %edi
  80227c:	31 ff                	xor    %edi,%edi
  80227e:	89 fa                	mov    %edi,%edx
  802280:	83 c4 1c             	add    $0x1c,%esp
  802283:	5b                   	pop    %ebx
  802284:	5e                   	pop    %esi
  802285:	5f                   	pop    %edi
  802286:	5d                   	pop    %ebp
  802287:	c3                   	ret    
  802288:	bd 20 00 00 00       	mov    $0x20,%ebp
  80228d:	89 eb                	mov    %ebp,%ebx
  80228f:	29 fb                	sub    %edi,%ebx
  802291:	89 f9                	mov    %edi,%ecx
  802293:	d3 e6                	shl    %cl,%esi
  802295:	89 c5                	mov    %eax,%ebp
  802297:	88 d9                	mov    %bl,%cl
  802299:	d3 ed                	shr    %cl,%ebp
  80229b:	89 e9                	mov    %ebp,%ecx
  80229d:	09 f1                	or     %esi,%ecx
  80229f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8022a3:	89 f9                	mov    %edi,%ecx
  8022a5:	d3 e0                	shl    %cl,%eax
  8022a7:	89 c5                	mov    %eax,%ebp
  8022a9:	89 d6                	mov    %edx,%esi
  8022ab:	88 d9                	mov    %bl,%cl
  8022ad:	d3 ee                	shr    %cl,%esi
  8022af:	89 f9                	mov    %edi,%ecx
  8022b1:	d3 e2                	shl    %cl,%edx
  8022b3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022b7:	88 d9                	mov    %bl,%cl
  8022b9:	d3 e8                	shr    %cl,%eax
  8022bb:	09 c2                	or     %eax,%edx
  8022bd:	89 d0                	mov    %edx,%eax
  8022bf:	89 f2                	mov    %esi,%edx
  8022c1:	f7 74 24 0c          	divl   0xc(%esp)
  8022c5:	89 d6                	mov    %edx,%esi
  8022c7:	89 c3                	mov    %eax,%ebx
  8022c9:	f7 e5                	mul    %ebp
  8022cb:	39 d6                	cmp    %edx,%esi
  8022cd:	72 19                	jb     8022e8 <__udivdi3+0xfc>
  8022cf:	74 0b                	je     8022dc <__udivdi3+0xf0>
  8022d1:	89 d8                	mov    %ebx,%eax
  8022d3:	31 ff                	xor    %edi,%edi
  8022d5:	e9 58 ff ff ff       	jmp    802232 <__udivdi3+0x46>
  8022da:	66 90                	xchg   %ax,%ax
  8022dc:	8b 54 24 08          	mov    0x8(%esp),%edx
  8022e0:	89 f9                	mov    %edi,%ecx
  8022e2:	d3 e2                	shl    %cl,%edx
  8022e4:	39 c2                	cmp    %eax,%edx
  8022e6:	73 e9                	jae    8022d1 <__udivdi3+0xe5>
  8022e8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8022eb:	31 ff                	xor    %edi,%edi
  8022ed:	e9 40 ff ff ff       	jmp    802232 <__udivdi3+0x46>
  8022f2:	66 90                	xchg   %ax,%ax
  8022f4:	31 c0                	xor    %eax,%eax
  8022f6:	e9 37 ff ff ff       	jmp    802232 <__udivdi3+0x46>
  8022fb:	90                   	nop

008022fc <__umoddi3>:
  8022fc:	55                   	push   %ebp
  8022fd:	57                   	push   %edi
  8022fe:	56                   	push   %esi
  8022ff:	53                   	push   %ebx
  802300:	83 ec 1c             	sub    $0x1c,%esp
  802303:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802307:	8b 74 24 34          	mov    0x34(%esp),%esi
  80230b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80230f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802313:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802317:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80231b:	89 f3                	mov    %esi,%ebx
  80231d:	89 fa                	mov    %edi,%edx
  80231f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802323:	89 34 24             	mov    %esi,(%esp)
  802326:	85 c0                	test   %eax,%eax
  802328:	75 1a                	jne    802344 <__umoddi3+0x48>
  80232a:	39 f7                	cmp    %esi,%edi
  80232c:	0f 86 a2 00 00 00    	jbe    8023d4 <__umoddi3+0xd8>
  802332:	89 c8                	mov    %ecx,%eax
  802334:	89 f2                	mov    %esi,%edx
  802336:	f7 f7                	div    %edi
  802338:	89 d0                	mov    %edx,%eax
  80233a:	31 d2                	xor    %edx,%edx
  80233c:	83 c4 1c             	add    $0x1c,%esp
  80233f:	5b                   	pop    %ebx
  802340:	5e                   	pop    %esi
  802341:	5f                   	pop    %edi
  802342:	5d                   	pop    %ebp
  802343:	c3                   	ret    
  802344:	39 f0                	cmp    %esi,%eax
  802346:	0f 87 ac 00 00 00    	ja     8023f8 <__umoddi3+0xfc>
  80234c:	0f bd e8             	bsr    %eax,%ebp
  80234f:	83 f5 1f             	xor    $0x1f,%ebp
  802352:	0f 84 ac 00 00 00    	je     802404 <__umoddi3+0x108>
  802358:	bf 20 00 00 00       	mov    $0x20,%edi
  80235d:	29 ef                	sub    %ebp,%edi
  80235f:	89 fe                	mov    %edi,%esi
  802361:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802365:	89 e9                	mov    %ebp,%ecx
  802367:	d3 e0                	shl    %cl,%eax
  802369:	89 d7                	mov    %edx,%edi
  80236b:	89 f1                	mov    %esi,%ecx
  80236d:	d3 ef                	shr    %cl,%edi
  80236f:	09 c7                	or     %eax,%edi
  802371:	89 e9                	mov    %ebp,%ecx
  802373:	d3 e2                	shl    %cl,%edx
  802375:	89 14 24             	mov    %edx,(%esp)
  802378:	89 d8                	mov    %ebx,%eax
  80237a:	d3 e0                	shl    %cl,%eax
  80237c:	89 c2                	mov    %eax,%edx
  80237e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802382:	d3 e0                	shl    %cl,%eax
  802384:	89 44 24 04          	mov    %eax,0x4(%esp)
  802388:	8b 44 24 08          	mov    0x8(%esp),%eax
  80238c:	89 f1                	mov    %esi,%ecx
  80238e:	d3 e8                	shr    %cl,%eax
  802390:	09 d0                	or     %edx,%eax
  802392:	d3 eb                	shr    %cl,%ebx
  802394:	89 da                	mov    %ebx,%edx
  802396:	f7 f7                	div    %edi
  802398:	89 d3                	mov    %edx,%ebx
  80239a:	f7 24 24             	mull   (%esp)
  80239d:	89 c6                	mov    %eax,%esi
  80239f:	89 d1                	mov    %edx,%ecx
  8023a1:	39 d3                	cmp    %edx,%ebx
  8023a3:	0f 82 87 00 00 00    	jb     802430 <__umoddi3+0x134>
  8023a9:	0f 84 91 00 00 00    	je     802440 <__umoddi3+0x144>
  8023af:	8b 54 24 04          	mov    0x4(%esp),%edx
  8023b3:	29 f2                	sub    %esi,%edx
  8023b5:	19 cb                	sbb    %ecx,%ebx
  8023b7:	89 d8                	mov    %ebx,%eax
  8023b9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8023bd:	d3 e0                	shl    %cl,%eax
  8023bf:	89 e9                	mov    %ebp,%ecx
  8023c1:	d3 ea                	shr    %cl,%edx
  8023c3:	09 d0                	or     %edx,%eax
  8023c5:	89 e9                	mov    %ebp,%ecx
  8023c7:	d3 eb                	shr    %cl,%ebx
  8023c9:	89 da                	mov    %ebx,%edx
  8023cb:	83 c4 1c             	add    $0x1c,%esp
  8023ce:	5b                   	pop    %ebx
  8023cf:	5e                   	pop    %esi
  8023d0:	5f                   	pop    %edi
  8023d1:	5d                   	pop    %ebp
  8023d2:	c3                   	ret    
  8023d3:	90                   	nop
  8023d4:	89 fd                	mov    %edi,%ebp
  8023d6:	85 ff                	test   %edi,%edi
  8023d8:	75 0b                	jne    8023e5 <__umoddi3+0xe9>
  8023da:	b8 01 00 00 00       	mov    $0x1,%eax
  8023df:	31 d2                	xor    %edx,%edx
  8023e1:	f7 f7                	div    %edi
  8023e3:	89 c5                	mov    %eax,%ebp
  8023e5:	89 f0                	mov    %esi,%eax
  8023e7:	31 d2                	xor    %edx,%edx
  8023e9:	f7 f5                	div    %ebp
  8023eb:	89 c8                	mov    %ecx,%eax
  8023ed:	f7 f5                	div    %ebp
  8023ef:	89 d0                	mov    %edx,%eax
  8023f1:	e9 44 ff ff ff       	jmp    80233a <__umoddi3+0x3e>
  8023f6:	66 90                	xchg   %ax,%ax
  8023f8:	89 c8                	mov    %ecx,%eax
  8023fa:	89 f2                	mov    %esi,%edx
  8023fc:	83 c4 1c             	add    $0x1c,%esp
  8023ff:	5b                   	pop    %ebx
  802400:	5e                   	pop    %esi
  802401:	5f                   	pop    %edi
  802402:	5d                   	pop    %ebp
  802403:	c3                   	ret    
  802404:	3b 04 24             	cmp    (%esp),%eax
  802407:	72 06                	jb     80240f <__umoddi3+0x113>
  802409:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80240d:	77 0f                	ja     80241e <__umoddi3+0x122>
  80240f:	89 f2                	mov    %esi,%edx
  802411:	29 f9                	sub    %edi,%ecx
  802413:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802417:	89 14 24             	mov    %edx,(%esp)
  80241a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80241e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802422:	8b 14 24             	mov    (%esp),%edx
  802425:	83 c4 1c             	add    $0x1c,%esp
  802428:	5b                   	pop    %ebx
  802429:	5e                   	pop    %esi
  80242a:	5f                   	pop    %edi
  80242b:	5d                   	pop    %ebp
  80242c:	c3                   	ret    
  80242d:	8d 76 00             	lea    0x0(%esi),%esi
  802430:	2b 04 24             	sub    (%esp),%eax
  802433:	19 fa                	sbb    %edi,%edx
  802435:	89 d1                	mov    %edx,%ecx
  802437:	89 c6                	mov    %eax,%esi
  802439:	e9 71 ff ff ff       	jmp    8023af <__umoddi3+0xb3>
  80243e:	66 90                	xchg   %ax,%ax
  802440:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802444:	72 ea                	jb     802430 <__umoddi3+0x134>
  802446:	89 d9                	mov    %ebx,%ecx
  802448:	e9 62 ff ff ff       	jmp    8023af <__umoddi3+0xb3>
