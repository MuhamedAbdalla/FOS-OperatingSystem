
obj/user/mergesort_noleakage:     file format elf32-i386


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
  800031:	e8 8f 07 00 00       	call   8007c5 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void Merge(int* A, int p, int q, int r);

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
  800041:	e8 17 1e 00 00       	call   801e5d <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 00 25 80 00       	push   $0x802500
  80004e:	e8 4e 0b 00 00       	call   800ba1 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 02 25 80 00       	push   $0x802502
  80005e:	e8 3e 0b 00 00       	call   800ba1 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 18 25 80 00       	push   $0x802518
  80006e:	e8 2e 0b 00 00       	call   800ba1 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 02 25 80 00       	push   $0x802502
  80007e:	e8 1e 0b 00 00       	call   800ba1 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 00 25 80 00       	push   $0x802500
  80008e:	e8 0e 0b 00 00       	call   800ba1 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 30 25 80 00       	push   $0x802530
  8000a5:	e8 79 11 00 00       	call   801223 <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 c9 16 00 00       	call   801789 <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 5c 1a 00 00       	call   801b31 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 50 25 80 00       	push   $0x802550
  8000e3:	e8 b9 0a 00 00       	call   800ba1 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 72 25 80 00       	push   $0x802572
  8000f3:	e8 a9 0a 00 00       	call   800ba1 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 80 25 80 00       	push   $0x802580
  800103:	e8 99 0a 00 00       	call   800ba1 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 8f 25 80 00       	push   $0x80258f
  800113:	e8 89 0a 00 00       	call   800ba1 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 9f 25 80 00       	push   $0x80259f
  800123:	e8 79 0a 00 00       	call   800ba1 <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 3d 06 00 00       	call   80076d <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 e5 05 00 00       	call   800725 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 d8 05 00 00       	call   800725 <cputchar>
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
  800162:	e8 10 1d 00 00       	call   801e77 <sys_enable_interrupt>

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
  800183:	e8 f4 01 00 00       	call   80037c <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f0             	pushl  -0x10(%ebp)
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	e8 12 02 00 00       	call   8003ad <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	e8 34 02 00 00       	call   8003e2 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	e8 21 02 00 00       	call   8003e2 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001c4:	83 ec 04             	sub    $0x4,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	6a 01                	push   $0x1
  8001cc:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cf:	e8 e0 02 00 00       	call   8004b4 <MSort>
  8001d4:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001d7:	e8 81 1c 00 00       	call   801e5d <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001dc:	83 ec 0c             	sub    $0xc,%esp
  8001df:	68 a8 25 80 00       	push   $0x8025a8
  8001e4:	e8 b8 09 00 00       	call   800ba1 <cprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ec:	e8 86 1c 00 00       	call   801e77 <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001f1:	83 ec 08             	sub    $0x8,%esp
  8001f4:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001fa:	e8 d3 00 00 00       	call   8002d2 <CheckSorted>
  8001ff:	83 c4 10             	add    $0x10,%esp
  800202:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800205:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800209:	75 14                	jne    80021f <_main+0x1e7>
  80020b:	83 ec 04             	sub    $0x4,%esp
  80020e:	68 dc 25 80 00       	push   $0x8025dc
  800213:	6a 4a                	push   $0x4a
  800215:	68 fe 25 80 00       	push   $0x8025fe
  80021a:	e8 cb 06 00 00       	call   8008ea <_panic>
		else
		{
			sys_disable_interrupt();
  80021f:	e8 39 1c 00 00       	call   801e5d <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	68 1c 26 80 00       	push   $0x80261c
  80022c:	e8 70 09 00 00       	call   800ba1 <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 50 26 80 00       	push   $0x802650
  80023c:	e8 60 09 00 00       	call   800ba1 <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	68 84 26 80 00       	push   $0x802684
  80024c:	e8 50 09 00 00       	call   800ba1 <cprintf>
  800251:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800254:	e8 1e 1c 00 00       	call   801e77 <sys_enable_interrupt>
		}

		free(Elements) ;
  800259:	83 ec 0c             	sub    $0xc,%esp
  80025c:	ff 75 ec             	pushl  -0x14(%ebp)
  80025f:	e8 e7 18 00 00       	call   801b4b <free>
  800264:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800267:	e8 f1 1b 00 00       	call   801e5d <sys_disable_interrupt>
			Chose = 0 ;
  80026c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800270:	eb 42                	jmp    8002b4 <_main+0x27c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	68 b6 26 80 00       	push   $0x8026b6
  80027a:	e8 22 09 00 00       	call   800ba1 <cprintf>
  80027f:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800282:	e8 e6 04 00 00       	call   80076d <getchar>
  800287:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80028a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80028e:	83 ec 0c             	sub    $0xc,%esp
  800291:	50                   	push   %eax
  800292:	e8 8e 04 00 00       	call   800725 <cputchar>
  800297:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80029a:	83 ec 0c             	sub    $0xc,%esp
  80029d:	6a 0a                	push   $0xa
  80029f:	e8 81 04 00 00       	call   800725 <cputchar>
  8002a4:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  8002a7:	83 ec 0c             	sub    $0xc,%esp
  8002aa:	6a 0a                	push   $0xa
  8002ac:	e8 74 04 00 00       	call   800725 <cputchar>
  8002b1:	83 c4 10             	add    $0x10,%esp

		free(Elements) ;

		sys_disable_interrupt();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002b4:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002b8:	74 06                	je     8002c0 <_main+0x288>
  8002ba:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002be:	75 b2                	jne    800272 <_main+0x23a>
				Chose = getchar() ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_enable_interrupt();
  8002c0:	e8 b2 1b 00 00       	call   801e77 <sys_enable_interrupt>

	} while (Chose == 'y');
  8002c5:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002c9:	0f 84 72 fd ff ff    	je     800041 <_main+0x9>

}
  8002cf:	90                   	nop
  8002d0:	c9                   	leave  
  8002d1:	c3                   	ret    

008002d2 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002d2:	55                   	push   %ebp
  8002d3:	89 e5                	mov    %esp,%ebp
  8002d5:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002d8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002df:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002e6:	eb 33                	jmp    80031b <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f5:	01 d0                	add    %edx,%eax
  8002f7:	8b 10                	mov    (%eax),%edx
  8002f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002fc:	40                   	inc    %eax
  8002fd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800304:	8b 45 08             	mov    0x8(%ebp),%eax
  800307:	01 c8                	add    %ecx,%eax
  800309:	8b 00                	mov    (%eax),%eax
  80030b:	39 c2                	cmp    %eax,%edx
  80030d:	7e 09                	jle    800318 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  80030f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800316:	eb 0c                	jmp    800324 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800318:	ff 45 f8             	incl   -0x8(%ebp)
  80031b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80031e:	48                   	dec    %eax
  80031f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800322:	7f c4                	jg     8002e8 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800324:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800327:	c9                   	leave  
  800328:	c3                   	ret    

00800329 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800329:	55                   	push   %ebp
  80032a:	89 e5                	mov    %esp,%ebp
  80032c:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  80032f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800332:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800339:	8b 45 08             	mov    0x8(%ebp),%eax
  80033c:	01 d0                	add    %edx,%eax
  80033e:	8b 00                	mov    (%eax),%eax
  800340:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800343:	8b 45 0c             	mov    0xc(%ebp),%eax
  800346:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80034d:	8b 45 08             	mov    0x8(%ebp),%eax
  800350:	01 c2                	add    %eax,%edx
  800352:	8b 45 10             	mov    0x10(%ebp),%eax
  800355:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80035c:	8b 45 08             	mov    0x8(%ebp),%eax
  80035f:	01 c8                	add    %ecx,%eax
  800361:	8b 00                	mov    (%eax),%eax
  800363:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800365:	8b 45 10             	mov    0x10(%ebp),%eax
  800368:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80036f:	8b 45 08             	mov    0x8(%ebp),%eax
  800372:	01 c2                	add    %eax,%edx
  800374:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800377:	89 02                	mov    %eax,(%edx)
}
  800379:	90                   	nop
  80037a:	c9                   	leave  
  80037b:	c3                   	ret    

0080037c <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80037c:	55                   	push   %ebp
  80037d:	89 e5                	mov    %esp,%ebp
  80037f:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800382:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800389:	eb 17                	jmp    8003a2 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80038b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80038e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800395:	8b 45 08             	mov    0x8(%ebp),%eax
  800398:	01 c2                	add    %eax,%edx
  80039a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80039d:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80039f:	ff 45 fc             	incl   -0x4(%ebp)
  8003a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003a5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003a8:	7c e1                	jl     80038b <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8003aa:	90                   	nop
  8003ab:	c9                   	leave  
  8003ac:	c3                   	ret    

008003ad <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8003ad:	55                   	push   %ebp
  8003ae:	89 e5                	mov    %esp,%ebp
  8003b0:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003ba:	eb 1b                	jmp    8003d7 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003bf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c9:	01 c2                	add    %eax,%edx
  8003cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ce:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003d1:	48                   	dec    %eax
  8003d2:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003d4:	ff 45 fc             	incl   -0x4(%ebp)
  8003d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003da:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003dd:	7c dd                	jl     8003bc <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003df:	90                   	nop
  8003e0:	c9                   	leave  
  8003e1:	c3                   	ret    

008003e2 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003e2:	55                   	push   %ebp
  8003e3:	89 e5                	mov    %esp,%ebp
  8003e5:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003e8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003eb:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003f0:	f7 e9                	imul   %ecx
  8003f2:	c1 f9 1f             	sar    $0x1f,%ecx
  8003f5:	89 d0                	mov    %edx,%eax
  8003f7:	29 c8                	sub    %ecx,%eax
  8003f9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8003fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800403:	eb 1e                	jmp    800423 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800405:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800408:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040f:	8b 45 08             	mov    0x8(%ebp),%eax
  800412:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800415:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800418:	99                   	cltd   
  800419:	f7 7d f8             	idivl  -0x8(%ebp)
  80041c:	89 d0                	mov    %edx,%eax
  80041e:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800420:	ff 45 fc             	incl   -0x4(%ebp)
  800423:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800426:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800429:	7c da                	jl     800405 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80042b:	90                   	nop
  80042c:	c9                   	leave  
  80042d:	c3                   	ret    

0080042e <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80042e:	55                   	push   %ebp
  80042f:	89 e5                	mov    %esp,%ebp
  800431:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800434:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80043b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800442:	eb 42                	jmp    800486 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800444:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800447:	99                   	cltd   
  800448:	f7 7d f0             	idivl  -0x10(%ebp)
  80044b:	89 d0                	mov    %edx,%eax
  80044d:	85 c0                	test   %eax,%eax
  80044f:	75 10                	jne    800461 <PrintElements+0x33>
			cprintf("\n");
  800451:	83 ec 0c             	sub    $0xc,%esp
  800454:	68 00 25 80 00       	push   $0x802500
  800459:	e8 43 07 00 00       	call   800ba1 <cprintf>
  80045e:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800461:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800464:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	01 d0                	add    %edx,%eax
  800470:	8b 00                	mov    (%eax),%eax
  800472:	83 ec 08             	sub    $0x8,%esp
  800475:	50                   	push   %eax
  800476:	68 d4 26 80 00       	push   $0x8026d4
  80047b:	e8 21 07 00 00       	call   800ba1 <cprintf>
  800480:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800483:	ff 45 f4             	incl   -0xc(%ebp)
  800486:	8b 45 0c             	mov    0xc(%ebp),%eax
  800489:	48                   	dec    %eax
  80048a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80048d:	7f b5                	jg     800444 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80048f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800492:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800499:	8b 45 08             	mov    0x8(%ebp),%eax
  80049c:	01 d0                	add    %edx,%eax
  80049e:	8b 00                	mov    (%eax),%eax
  8004a0:	83 ec 08             	sub    $0x8,%esp
  8004a3:	50                   	push   %eax
  8004a4:	68 d9 26 80 00       	push   $0x8026d9
  8004a9:	e8 f3 06 00 00       	call   800ba1 <cprintf>
  8004ae:	83 c4 10             	add    $0x10,%esp

}
  8004b1:	90                   	nop
  8004b2:	c9                   	leave  
  8004b3:	c3                   	ret    

008004b4 <MSort>:


void MSort(int* A, int p, int r)
{
  8004b4:	55                   	push   %ebp
  8004b5:	89 e5                	mov    %esp,%ebp
  8004b7:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004bd:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004c0:	7d 54                	jge    800516 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c8:	01 d0                	add    %edx,%eax
  8004ca:	89 c2                	mov    %eax,%edx
  8004cc:	c1 ea 1f             	shr    $0x1f,%edx
  8004cf:	01 d0                	add    %edx,%eax
  8004d1:	d1 f8                	sar    %eax
  8004d3:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004d6:	83 ec 04             	sub    $0x4,%esp
  8004d9:	ff 75 f4             	pushl  -0xc(%ebp)
  8004dc:	ff 75 0c             	pushl  0xc(%ebp)
  8004df:	ff 75 08             	pushl  0x8(%ebp)
  8004e2:	e8 cd ff ff ff       	call   8004b4 <MSort>
  8004e7:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004ed:	40                   	inc    %eax
  8004ee:	83 ec 04             	sub    $0x4,%esp
  8004f1:	ff 75 10             	pushl  0x10(%ebp)
  8004f4:	50                   	push   %eax
  8004f5:	ff 75 08             	pushl  0x8(%ebp)
  8004f8:	e8 b7 ff ff ff       	call   8004b4 <MSort>
  8004fd:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  800500:	ff 75 10             	pushl  0x10(%ebp)
  800503:	ff 75 f4             	pushl  -0xc(%ebp)
  800506:	ff 75 0c             	pushl  0xc(%ebp)
  800509:	ff 75 08             	pushl  0x8(%ebp)
  80050c:	e8 08 00 00 00       	call   800519 <Merge>
  800511:	83 c4 10             	add    $0x10,%esp
  800514:	eb 01                	jmp    800517 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800516:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  800517:	c9                   	leave  
  800518:	c3                   	ret    

00800519 <Merge>:

void Merge(int* A, int p, int q, int r)
{
  800519:	55                   	push   %ebp
  80051a:	89 e5                	mov    %esp,%ebp
  80051c:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  80051f:	8b 45 10             	mov    0x10(%ebp),%eax
  800522:	2b 45 0c             	sub    0xc(%ebp),%eax
  800525:	40                   	inc    %eax
  800526:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  800529:	8b 45 14             	mov    0x14(%ebp),%eax
  80052c:	2b 45 10             	sub    0x10(%ebp),%eax
  80052f:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800532:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  800539:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	//cprintf("allocate LEFT\n");
	int* Left = malloc(sizeof(int) * leftCapacity);
  800540:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800543:	c1 e0 02             	shl    $0x2,%eax
  800546:	83 ec 0c             	sub    $0xc,%esp
  800549:	50                   	push   %eax
  80054a:	e8 e2 15 00 00       	call   801b31 <malloc>
  80054f:	83 c4 10             	add    $0x10,%esp
  800552:	89 45 d8             	mov    %eax,-0x28(%ebp)

	//cprintf("allocate RIGHT\n");
	int* Right = malloc(sizeof(int) * rightCapacity);
  800555:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800558:	c1 e0 02             	shl    $0x2,%eax
  80055b:	83 ec 0c             	sub    $0xc,%esp
  80055e:	50                   	push   %eax
  80055f:	e8 cd 15 00 00       	call   801b31 <malloc>
  800564:	83 c4 10             	add    $0x10,%esp
  800567:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80056a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800571:	eb 2f                	jmp    8005a2 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  800573:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800576:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80057d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800580:	01 c2                	add    %eax,%edx
  800582:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800585:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800588:	01 c8                	add    %ecx,%eax
  80058a:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80058f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800596:	8b 45 08             	mov    0x8(%ebp),%eax
  800599:	01 c8                	add    %ecx,%eax
  80059b:	8b 00                	mov    (%eax),%eax
  80059d:	89 02                	mov    %eax,(%edx)

	//cprintf("allocate RIGHT\n");
	int* Right = malloc(sizeof(int) * rightCapacity);

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80059f:	ff 45 ec             	incl   -0x14(%ebp)
  8005a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005a5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005a8:	7c c9                	jl     800573 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005aa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005b1:	eb 2a                	jmp    8005dd <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005b6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005bd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005c0:	01 c2                	add    %eax,%edx
  8005c2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005c8:	01 c8                	add    %ecx,%eax
  8005ca:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d4:	01 c8                	add    %ecx,%eax
  8005d6:	8b 00                	mov    (%eax),%eax
  8005d8:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005da:	ff 45 e8             	incl   -0x18(%ebp)
  8005dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005e0:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005e3:	7c ce                	jl     8005b3 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005eb:	e9 0a 01 00 00       	jmp    8006fa <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005f3:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005f6:	0f 8d 95 00 00 00    	jge    800691 <Merge+0x178>
  8005fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005ff:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800602:	0f 8d 89 00 00 00    	jge    800691 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800608:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80060b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800612:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800615:	01 d0                	add    %edx,%eax
  800617:	8b 10                	mov    (%eax),%edx
  800619:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80061c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800623:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800626:	01 c8                	add    %ecx,%eax
  800628:	8b 00                	mov    (%eax),%eax
  80062a:	39 c2                	cmp    %eax,%edx
  80062c:	7d 33                	jge    800661 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  80062e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800631:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800636:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80063d:	8b 45 08             	mov    0x8(%ebp),%eax
  800640:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800643:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800646:	8d 50 01             	lea    0x1(%eax),%edx
  800649:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80064c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800653:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800656:	01 d0                	add    %edx,%eax
  800658:	8b 00                	mov    (%eax),%eax
  80065a:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80065c:	e9 96 00 00 00       	jmp    8006f7 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800661:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800664:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800669:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800670:	8b 45 08             	mov    0x8(%ebp),%eax
  800673:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800676:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800679:	8d 50 01             	lea    0x1(%eax),%edx
  80067c:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80067f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800686:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800689:	01 d0                	add    %edx,%eax
  80068b:	8b 00                	mov    (%eax),%eax
  80068d:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80068f:	eb 66                	jmp    8006f7 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800691:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800694:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800697:	7d 30                	jge    8006c9 <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  800699:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80069c:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006a1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ab:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006b1:	8d 50 01             	lea    0x1(%eax),%edx
  8006b4:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006be:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006c1:	01 d0                	add    %edx,%eax
  8006c3:	8b 00                	mov    (%eax),%eax
  8006c5:	89 01                	mov    %eax,(%ecx)
  8006c7:	eb 2e                	jmp    8006f7 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006c9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006cc:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006db:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006de:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006e1:	8d 50 01             	lea    0x1(%eax),%edx
  8006e4:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006e7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ee:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006f1:	01 d0                	add    %edx,%eax
  8006f3:	8b 00                	mov    (%eax),%eax
  8006f5:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006f7:	ff 45 e4             	incl   -0x1c(%ebp)
  8006fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006fd:	3b 45 14             	cmp    0x14(%ebp),%eax
  800700:	0f 8e ea fe ff ff    	jle    8005f0 <Merge+0xd7>
			A[k - 1] = Right[rightIndex++];
		}
	}

	//cprintf("free LEFT\n");
	free(Left);
  800706:	83 ec 0c             	sub    $0xc,%esp
  800709:	ff 75 d8             	pushl  -0x28(%ebp)
  80070c:	e8 3a 14 00 00       	call   801b4b <free>
  800711:	83 c4 10             	add    $0x10,%esp
	//cprintf("free RIGHT\n");
	free(Right);
  800714:	83 ec 0c             	sub    $0xc,%esp
  800717:	ff 75 d4             	pushl  -0x2c(%ebp)
  80071a:	e8 2c 14 00 00       	call   801b4b <free>
  80071f:	83 c4 10             	add    $0x10,%esp

}
  800722:	90                   	nop
  800723:	c9                   	leave  
  800724:	c3                   	ret    

00800725 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800725:	55                   	push   %ebp
  800726:	89 e5                	mov    %esp,%ebp
  800728:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80072b:	8b 45 08             	mov    0x8(%ebp),%eax
  80072e:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800731:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800735:	83 ec 0c             	sub    $0xc,%esp
  800738:	50                   	push   %eax
  800739:	e8 53 17 00 00       	call   801e91 <sys_cputc>
  80073e:	83 c4 10             	add    $0x10,%esp
}
  800741:	90                   	nop
  800742:	c9                   	leave  
  800743:	c3                   	ret    

00800744 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800744:	55                   	push   %ebp
  800745:	89 e5                	mov    %esp,%ebp
  800747:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80074a:	e8 0e 17 00 00       	call   801e5d <sys_disable_interrupt>
	char c = ch;
  80074f:	8b 45 08             	mov    0x8(%ebp),%eax
  800752:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800755:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800759:	83 ec 0c             	sub    $0xc,%esp
  80075c:	50                   	push   %eax
  80075d:	e8 2f 17 00 00       	call   801e91 <sys_cputc>
  800762:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800765:	e8 0d 17 00 00       	call   801e77 <sys_enable_interrupt>
}
  80076a:	90                   	nop
  80076b:	c9                   	leave  
  80076c:	c3                   	ret    

0080076d <getchar>:

int
getchar(void)
{
  80076d:	55                   	push   %ebp
  80076e:	89 e5                	mov    %esp,%ebp
  800770:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800773:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80077a:	eb 08                	jmp    800784 <getchar+0x17>
	{
		c = sys_cgetc();
  80077c:	e8 f4 14 00 00       	call   801c75 <sys_cgetc>
  800781:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800784:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800788:	74 f2                	je     80077c <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80078a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80078d:	c9                   	leave  
  80078e:	c3                   	ret    

0080078f <atomic_getchar>:

int
atomic_getchar(void)
{
  80078f:	55                   	push   %ebp
  800790:	89 e5                	mov    %esp,%ebp
  800792:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800795:	e8 c3 16 00 00       	call   801e5d <sys_disable_interrupt>
	int c=0;
  80079a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8007a1:	eb 08                	jmp    8007ab <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8007a3:	e8 cd 14 00 00       	call   801c75 <sys_cgetc>
  8007a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8007ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007af:	74 f2                	je     8007a3 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8007b1:	e8 c1 16 00 00       	call   801e77 <sys_enable_interrupt>
	return c;
  8007b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007b9:	c9                   	leave  
  8007ba:	c3                   	ret    

008007bb <iscons>:

int iscons(int fdnum)
{
  8007bb:	55                   	push   %ebp
  8007bc:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007be:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007c3:	5d                   	pop    %ebp
  8007c4:	c3                   	ret    

008007c5 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007c5:	55                   	push   %ebp
  8007c6:	89 e5                	mov    %esp,%ebp
  8007c8:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007cb:	e8 f2 14 00 00       	call   801cc2 <sys_getenvindex>
  8007d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007d6:	89 d0                	mov    %edx,%eax
  8007d8:	c1 e0 03             	shl    $0x3,%eax
  8007db:	01 d0                	add    %edx,%eax
  8007dd:	c1 e0 02             	shl    $0x2,%eax
  8007e0:	01 d0                	add    %edx,%eax
  8007e2:	c1 e0 06             	shl    $0x6,%eax
  8007e5:	29 d0                	sub    %edx,%eax
  8007e7:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8007ee:	01 c8                	add    %ecx,%eax
  8007f0:	01 d0                	add    %edx,%eax
  8007f2:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8007f7:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007fc:	a1 24 30 80 00       	mov    0x803024,%eax
  800801:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  800807:	84 c0                	test   %al,%al
  800809:	74 0f                	je     80081a <libmain+0x55>
		binaryname = myEnv->prog_name;
  80080b:	a1 24 30 80 00       	mov    0x803024,%eax
  800810:	05 b0 52 00 00       	add    $0x52b0,%eax
  800815:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80081a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80081e:	7e 0a                	jle    80082a <libmain+0x65>
		binaryname = argv[0];
  800820:	8b 45 0c             	mov    0xc(%ebp),%eax
  800823:	8b 00                	mov    (%eax),%eax
  800825:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80082a:	83 ec 08             	sub    $0x8,%esp
  80082d:	ff 75 0c             	pushl  0xc(%ebp)
  800830:	ff 75 08             	pushl  0x8(%ebp)
  800833:	e8 00 f8 ff ff       	call   800038 <_main>
  800838:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80083b:	e8 1d 16 00 00       	call   801e5d <sys_disable_interrupt>
	cprintf("**************************************\n");
  800840:	83 ec 0c             	sub    $0xc,%esp
  800843:	68 f8 26 80 00       	push   $0x8026f8
  800848:	e8 54 03 00 00       	call   800ba1 <cprintf>
  80084d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800850:	a1 24 30 80 00       	mov    0x803024,%eax
  800855:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  80085b:	a1 24 30 80 00       	mov    0x803024,%eax
  800860:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  800866:	83 ec 04             	sub    $0x4,%esp
  800869:	52                   	push   %edx
  80086a:	50                   	push   %eax
  80086b:	68 20 27 80 00       	push   $0x802720
  800870:	e8 2c 03 00 00       	call   800ba1 <cprintf>
  800875:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800878:	a1 24 30 80 00       	mov    0x803024,%eax
  80087d:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  800883:	a1 24 30 80 00       	mov    0x803024,%eax
  800888:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  80088e:	a1 24 30 80 00       	mov    0x803024,%eax
  800893:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  800899:	51                   	push   %ecx
  80089a:	52                   	push   %edx
  80089b:	50                   	push   %eax
  80089c:	68 48 27 80 00       	push   $0x802748
  8008a1:	e8 fb 02 00 00       	call   800ba1 <cprintf>
  8008a6:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8008a9:	83 ec 0c             	sub    $0xc,%esp
  8008ac:	68 f8 26 80 00       	push   $0x8026f8
  8008b1:	e8 eb 02 00 00       	call   800ba1 <cprintf>
  8008b6:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8008b9:	e8 b9 15 00 00       	call   801e77 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8008be:	e8 19 00 00 00       	call   8008dc <exit>
}
  8008c3:	90                   	nop
  8008c4:	c9                   	leave  
  8008c5:	c3                   	ret    

008008c6 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008c6:	55                   	push   %ebp
  8008c7:	89 e5                	mov    %esp,%ebp
  8008c9:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008cc:	83 ec 0c             	sub    $0xc,%esp
  8008cf:	6a 00                	push   $0x0
  8008d1:	e8 b8 13 00 00       	call   801c8e <sys_env_destroy>
  8008d6:	83 c4 10             	add    $0x10,%esp
}
  8008d9:	90                   	nop
  8008da:	c9                   	leave  
  8008db:	c3                   	ret    

008008dc <exit>:

void
exit(void)
{
  8008dc:	55                   	push   %ebp
  8008dd:	89 e5                	mov    %esp,%ebp
  8008df:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008e2:	e8 0d 14 00 00       	call   801cf4 <sys_env_exit>
}
  8008e7:	90                   	nop
  8008e8:	c9                   	leave  
  8008e9:	c3                   	ret    

008008ea <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008ea:	55                   	push   %ebp
  8008eb:	89 e5                	mov    %esp,%ebp
  8008ed:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008f0:	8d 45 10             	lea    0x10(%ebp),%eax
  8008f3:	83 c0 04             	add    $0x4,%eax
  8008f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008f9:	a1 18 31 80 00       	mov    0x803118,%eax
  8008fe:	85 c0                	test   %eax,%eax
  800900:	74 16                	je     800918 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800902:	a1 18 31 80 00       	mov    0x803118,%eax
  800907:	83 ec 08             	sub    $0x8,%esp
  80090a:	50                   	push   %eax
  80090b:	68 a0 27 80 00       	push   $0x8027a0
  800910:	e8 8c 02 00 00       	call   800ba1 <cprintf>
  800915:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800918:	a1 00 30 80 00       	mov    0x803000,%eax
  80091d:	ff 75 0c             	pushl  0xc(%ebp)
  800920:	ff 75 08             	pushl  0x8(%ebp)
  800923:	50                   	push   %eax
  800924:	68 a5 27 80 00       	push   $0x8027a5
  800929:	e8 73 02 00 00       	call   800ba1 <cprintf>
  80092e:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800931:	8b 45 10             	mov    0x10(%ebp),%eax
  800934:	83 ec 08             	sub    $0x8,%esp
  800937:	ff 75 f4             	pushl  -0xc(%ebp)
  80093a:	50                   	push   %eax
  80093b:	e8 f6 01 00 00       	call   800b36 <vcprintf>
  800940:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800943:	83 ec 08             	sub    $0x8,%esp
  800946:	6a 00                	push   $0x0
  800948:	68 c1 27 80 00       	push   $0x8027c1
  80094d:	e8 e4 01 00 00       	call   800b36 <vcprintf>
  800952:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800955:	e8 82 ff ff ff       	call   8008dc <exit>

	// should not return here
	while (1) ;
  80095a:	eb fe                	jmp    80095a <_panic+0x70>

0080095c <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80095c:	55                   	push   %ebp
  80095d:	89 e5                	mov    %esp,%ebp
  80095f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800962:	a1 24 30 80 00       	mov    0x803024,%eax
  800967:	8b 50 74             	mov    0x74(%eax),%edx
  80096a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80096d:	39 c2                	cmp    %eax,%edx
  80096f:	74 14                	je     800985 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800971:	83 ec 04             	sub    $0x4,%esp
  800974:	68 c4 27 80 00       	push   $0x8027c4
  800979:	6a 26                	push   $0x26
  80097b:	68 10 28 80 00       	push   $0x802810
  800980:	e8 65 ff ff ff       	call   8008ea <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800985:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80098c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800993:	e9 c4 00 00 00       	jmp    800a5c <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800998:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80099b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a5:	01 d0                	add    %edx,%eax
  8009a7:	8b 00                	mov    (%eax),%eax
  8009a9:	85 c0                	test   %eax,%eax
  8009ab:	75 08                	jne    8009b5 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8009ad:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8009b0:	e9 a4 00 00 00       	jmp    800a59 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8009b5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009bc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8009c3:	eb 6b                	jmp    800a30 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009c5:	a1 24 30 80 00       	mov    0x803024,%eax
  8009ca:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8009d0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009d3:	89 d0                	mov    %edx,%eax
  8009d5:	c1 e0 02             	shl    $0x2,%eax
  8009d8:	01 d0                	add    %edx,%eax
  8009da:	c1 e0 02             	shl    $0x2,%eax
  8009dd:	01 c8                	add    %ecx,%eax
  8009df:	8a 40 04             	mov    0x4(%eax),%al
  8009e2:	84 c0                	test   %al,%al
  8009e4:	75 47                	jne    800a2d <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009e6:	a1 24 30 80 00       	mov    0x803024,%eax
  8009eb:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8009f1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009f4:	89 d0                	mov    %edx,%eax
  8009f6:	c1 e0 02             	shl    $0x2,%eax
  8009f9:	01 d0                	add    %edx,%eax
  8009fb:	c1 e0 02             	shl    $0x2,%eax
  8009fe:	01 c8                	add    %ecx,%eax
  800a00:	8b 00                	mov    (%eax),%eax
  800a02:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800a05:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a08:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800a0d:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800a0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a12:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a19:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1c:	01 c8                	add    %ecx,%eax
  800a1e:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a20:	39 c2                	cmp    %eax,%edx
  800a22:	75 09                	jne    800a2d <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800a24:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a2b:	eb 12                	jmp    800a3f <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a2d:	ff 45 e8             	incl   -0x18(%ebp)
  800a30:	a1 24 30 80 00       	mov    0x803024,%eax
  800a35:	8b 50 74             	mov    0x74(%eax),%edx
  800a38:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a3b:	39 c2                	cmp    %eax,%edx
  800a3d:	77 86                	ja     8009c5 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a3f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a43:	75 14                	jne    800a59 <CheckWSWithoutLastIndex+0xfd>
			panic(
  800a45:	83 ec 04             	sub    $0x4,%esp
  800a48:	68 1c 28 80 00       	push   $0x80281c
  800a4d:	6a 3a                	push   $0x3a
  800a4f:	68 10 28 80 00       	push   $0x802810
  800a54:	e8 91 fe ff ff       	call   8008ea <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a59:	ff 45 f0             	incl   -0x10(%ebp)
  800a5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a5f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a62:	0f 8c 30 ff ff ff    	jl     800998 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a68:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a6f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a76:	eb 27                	jmp    800a9f <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a78:	a1 24 30 80 00       	mov    0x803024,%eax
  800a7d:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800a83:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a86:	89 d0                	mov    %edx,%eax
  800a88:	c1 e0 02             	shl    $0x2,%eax
  800a8b:	01 d0                	add    %edx,%eax
  800a8d:	c1 e0 02             	shl    $0x2,%eax
  800a90:	01 c8                	add    %ecx,%eax
  800a92:	8a 40 04             	mov    0x4(%eax),%al
  800a95:	3c 01                	cmp    $0x1,%al
  800a97:	75 03                	jne    800a9c <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800a99:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a9c:	ff 45 e0             	incl   -0x20(%ebp)
  800a9f:	a1 24 30 80 00       	mov    0x803024,%eax
  800aa4:	8b 50 74             	mov    0x74(%eax),%edx
  800aa7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800aaa:	39 c2                	cmp    %eax,%edx
  800aac:	77 ca                	ja     800a78 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800aae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ab1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800ab4:	74 14                	je     800aca <CheckWSWithoutLastIndex+0x16e>
		panic(
  800ab6:	83 ec 04             	sub    $0x4,%esp
  800ab9:	68 70 28 80 00       	push   $0x802870
  800abe:	6a 44                	push   $0x44
  800ac0:	68 10 28 80 00       	push   $0x802810
  800ac5:	e8 20 fe ff ff       	call   8008ea <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800aca:	90                   	nop
  800acb:	c9                   	leave  
  800acc:	c3                   	ret    

00800acd <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800acd:	55                   	push   %ebp
  800ace:	89 e5                	mov    %esp,%ebp
  800ad0:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800ad3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad6:	8b 00                	mov    (%eax),%eax
  800ad8:	8d 48 01             	lea    0x1(%eax),%ecx
  800adb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ade:	89 0a                	mov    %ecx,(%edx)
  800ae0:	8b 55 08             	mov    0x8(%ebp),%edx
  800ae3:	88 d1                	mov    %dl,%cl
  800ae5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae8:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800aec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aef:	8b 00                	mov    (%eax),%eax
  800af1:	3d ff 00 00 00       	cmp    $0xff,%eax
  800af6:	75 2c                	jne    800b24 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800af8:	a0 28 30 80 00       	mov    0x803028,%al
  800afd:	0f b6 c0             	movzbl %al,%eax
  800b00:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b03:	8b 12                	mov    (%edx),%edx
  800b05:	89 d1                	mov    %edx,%ecx
  800b07:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b0a:	83 c2 08             	add    $0x8,%edx
  800b0d:	83 ec 04             	sub    $0x4,%esp
  800b10:	50                   	push   %eax
  800b11:	51                   	push   %ecx
  800b12:	52                   	push   %edx
  800b13:	e8 34 11 00 00       	call   801c4c <sys_cputs>
  800b18:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800b1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b27:	8b 40 04             	mov    0x4(%eax),%eax
  800b2a:	8d 50 01             	lea    0x1(%eax),%edx
  800b2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b30:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b33:	90                   	nop
  800b34:	c9                   	leave  
  800b35:	c3                   	ret    

00800b36 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b36:	55                   	push   %ebp
  800b37:	89 e5                	mov    %esp,%ebp
  800b39:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b3f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b46:	00 00 00 
	b.cnt = 0;
  800b49:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b50:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b53:	ff 75 0c             	pushl  0xc(%ebp)
  800b56:	ff 75 08             	pushl  0x8(%ebp)
  800b59:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b5f:	50                   	push   %eax
  800b60:	68 cd 0a 80 00       	push   $0x800acd
  800b65:	e8 11 02 00 00       	call   800d7b <vprintfmt>
  800b6a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b6d:	a0 28 30 80 00       	mov    0x803028,%al
  800b72:	0f b6 c0             	movzbl %al,%eax
  800b75:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b7b:	83 ec 04             	sub    $0x4,%esp
  800b7e:	50                   	push   %eax
  800b7f:	52                   	push   %edx
  800b80:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b86:	83 c0 08             	add    $0x8,%eax
  800b89:	50                   	push   %eax
  800b8a:	e8 bd 10 00 00       	call   801c4c <sys_cputs>
  800b8f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b92:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b99:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b9f:	c9                   	leave  
  800ba0:	c3                   	ret    

00800ba1 <cprintf>:

int cprintf(const char *fmt, ...) {
  800ba1:	55                   	push   %ebp
  800ba2:	89 e5                	mov    %esp,%ebp
  800ba4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800ba7:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800bae:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bb1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb7:	83 ec 08             	sub    $0x8,%esp
  800bba:	ff 75 f4             	pushl  -0xc(%ebp)
  800bbd:	50                   	push   %eax
  800bbe:	e8 73 ff ff ff       	call   800b36 <vcprintf>
  800bc3:	83 c4 10             	add    $0x10,%esp
  800bc6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800bc9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bcc:	c9                   	leave  
  800bcd:	c3                   	ret    

00800bce <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800bce:	55                   	push   %ebp
  800bcf:	89 e5                	mov    %esp,%ebp
  800bd1:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bd4:	e8 84 12 00 00       	call   801e5d <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bd9:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bdc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800be2:	83 ec 08             	sub    $0x8,%esp
  800be5:	ff 75 f4             	pushl  -0xc(%ebp)
  800be8:	50                   	push   %eax
  800be9:	e8 48 ff ff ff       	call   800b36 <vcprintf>
  800bee:	83 c4 10             	add    $0x10,%esp
  800bf1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800bf4:	e8 7e 12 00 00       	call   801e77 <sys_enable_interrupt>
	return cnt;
  800bf9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bfc:	c9                   	leave  
  800bfd:	c3                   	ret    

00800bfe <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bfe:	55                   	push   %ebp
  800bff:	89 e5                	mov    %esp,%ebp
  800c01:	53                   	push   %ebx
  800c02:	83 ec 14             	sub    $0x14,%esp
  800c05:	8b 45 10             	mov    0x10(%ebp),%eax
  800c08:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c0b:	8b 45 14             	mov    0x14(%ebp),%eax
  800c0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800c11:	8b 45 18             	mov    0x18(%ebp),%eax
  800c14:	ba 00 00 00 00       	mov    $0x0,%edx
  800c19:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c1c:	77 55                	ja     800c73 <printnum+0x75>
  800c1e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c21:	72 05                	jb     800c28 <printnum+0x2a>
  800c23:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c26:	77 4b                	ja     800c73 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c28:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c2b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c2e:	8b 45 18             	mov    0x18(%ebp),%eax
  800c31:	ba 00 00 00 00       	mov    $0x0,%edx
  800c36:	52                   	push   %edx
  800c37:	50                   	push   %eax
  800c38:	ff 75 f4             	pushl  -0xc(%ebp)
  800c3b:	ff 75 f0             	pushl  -0x10(%ebp)
  800c3e:	e8 59 16 00 00       	call   80229c <__udivdi3>
  800c43:	83 c4 10             	add    $0x10,%esp
  800c46:	83 ec 04             	sub    $0x4,%esp
  800c49:	ff 75 20             	pushl  0x20(%ebp)
  800c4c:	53                   	push   %ebx
  800c4d:	ff 75 18             	pushl  0x18(%ebp)
  800c50:	52                   	push   %edx
  800c51:	50                   	push   %eax
  800c52:	ff 75 0c             	pushl  0xc(%ebp)
  800c55:	ff 75 08             	pushl  0x8(%ebp)
  800c58:	e8 a1 ff ff ff       	call   800bfe <printnum>
  800c5d:	83 c4 20             	add    $0x20,%esp
  800c60:	eb 1a                	jmp    800c7c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c62:	83 ec 08             	sub    $0x8,%esp
  800c65:	ff 75 0c             	pushl  0xc(%ebp)
  800c68:	ff 75 20             	pushl  0x20(%ebp)
  800c6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6e:	ff d0                	call   *%eax
  800c70:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c73:	ff 4d 1c             	decl   0x1c(%ebp)
  800c76:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c7a:	7f e6                	jg     800c62 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c7c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c7f:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c84:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c87:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c8a:	53                   	push   %ebx
  800c8b:	51                   	push   %ecx
  800c8c:	52                   	push   %edx
  800c8d:	50                   	push   %eax
  800c8e:	e8 19 17 00 00       	call   8023ac <__umoddi3>
  800c93:	83 c4 10             	add    $0x10,%esp
  800c96:	05 d4 2a 80 00       	add    $0x802ad4,%eax
  800c9b:	8a 00                	mov    (%eax),%al
  800c9d:	0f be c0             	movsbl %al,%eax
  800ca0:	83 ec 08             	sub    $0x8,%esp
  800ca3:	ff 75 0c             	pushl  0xc(%ebp)
  800ca6:	50                   	push   %eax
  800ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  800caa:	ff d0                	call   *%eax
  800cac:	83 c4 10             	add    $0x10,%esp
}
  800caf:	90                   	nop
  800cb0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800cb3:	c9                   	leave  
  800cb4:	c3                   	ret    

00800cb5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800cb5:	55                   	push   %ebp
  800cb6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cb8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cbc:	7e 1c                	jle    800cda <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc1:	8b 00                	mov    (%eax),%eax
  800cc3:	8d 50 08             	lea    0x8(%eax),%edx
  800cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc9:	89 10                	mov    %edx,(%eax)
  800ccb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cce:	8b 00                	mov    (%eax),%eax
  800cd0:	83 e8 08             	sub    $0x8,%eax
  800cd3:	8b 50 04             	mov    0x4(%eax),%edx
  800cd6:	8b 00                	mov    (%eax),%eax
  800cd8:	eb 40                	jmp    800d1a <getuint+0x65>
	else if (lflag)
  800cda:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cde:	74 1e                	je     800cfe <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce3:	8b 00                	mov    (%eax),%eax
  800ce5:	8d 50 04             	lea    0x4(%eax),%edx
  800ce8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ceb:	89 10                	mov    %edx,(%eax)
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	8b 00                	mov    (%eax),%eax
  800cf2:	83 e8 04             	sub    $0x4,%eax
  800cf5:	8b 00                	mov    (%eax),%eax
  800cf7:	ba 00 00 00 00       	mov    $0x0,%edx
  800cfc:	eb 1c                	jmp    800d1a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	8b 00                	mov    (%eax),%eax
  800d03:	8d 50 04             	lea    0x4(%eax),%edx
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	89 10                	mov    %edx,(%eax)
  800d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0e:	8b 00                	mov    (%eax),%eax
  800d10:	83 e8 04             	sub    $0x4,%eax
  800d13:	8b 00                	mov    (%eax),%eax
  800d15:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800d1a:	5d                   	pop    %ebp
  800d1b:	c3                   	ret    

00800d1c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d1c:	55                   	push   %ebp
  800d1d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d1f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d23:	7e 1c                	jle    800d41 <getint+0x25>
		return va_arg(*ap, long long);
  800d25:	8b 45 08             	mov    0x8(%ebp),%eax
  800d28:	8b 00                	mov    (%eax),%eax
  800d2a:	8d 50 08             	lea    0x8(%eax),%edx
  800d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d30:	89 10                	mov    %edx,(%eax)
  800d32:	8b 45 08             	mov    0x8(%ebp),%eax
  800d35:	8b 00                	mov    (%eax),%eax
  800d37:	83 e8 08             	sub    $0x8,%eax
  800d3a:	8b 50 04             	mov    0x4(%eax),%edx
  800d3d:	8b 00                	mov    (%eax),%eax
  800d3f:	eb 38                	jmp    800d79 <getint+0x5d>
	else if (lflag)
  800d41:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d45:	74 1a                	je     800d61 <getint+0x45>
		return va_arg(*ap, long);
  800d47:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4a:	8b 00                	mov    (%eax),%eax
  800d4c:	8d 50 04             	lea    0x4(%eax),%edx
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	89 10                	mov    %edx,(%eax)
  800d54:	8b 45 08             	mov    0x8(%ebp),%eax
  800d57:	8b 00                	mov    (%eax),%eax
  800d59:	83 e8 04             	sub    $0x4,%eax
  800d5c:	8b 00                	mov    (%eax),%eax
  800d5e:	99                   	cltd   
  800d5f:	eb 18                	jmp    800d79 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d61:	8b 45 08             	mov    0x8(%ebp),%eax
  800d64:	8b 00                	mov    (%eax),%eax
  800d66:	8d 50 04             	lea    0x4(%eax),%edx
  800d69:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6c:	89 10                	mov    %edx,(%eax)
  800d6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d71:	8b 00                	mov    (%eax),%eax
  800d73:	83 e8 04             	sub    $0x4,%eax
  800d76:	8b 00                	mov    (%eax),%eax
  800d78:	99                   	cltd   
}
  800d79:	5d                   	pop    %ebp
  800d7a:	c3                   	ret    

00800d7b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d7b:	55                   	push   %ebp
  800d7c:	89 e5                	mov    %esp,%ebp
  800d7e:	56                   	push   %esi
  800d7f:	53                   	push   %ebx
  800d80:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d83:	eb 17                	jmp    800d9c <vprintfmt+0x21>
			if (ch == '\0')
  800d85:	85 db                	test   %ebx,%ebx
  800d87:	0f 84 af 03 00 00    	je     80113c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d8d:	83 ec 08             	sub    $0x8,%esp
  800d90:	ff 75 0c             	pushl  0xc(%ebp)
  800d93:	53                   	push   %ebx
  800d94:	8b 45 08             	mov    0x8(%ebp),%eax
  800d97:	ff d0                	call   *%eax
  800d99:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d9c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d9f:	8d 50 01             	lea    0x1(%eax),%edx
  800da2:	89 55 10             	mov    %edx,0x10(%ebp)
  800da5:	8a 00                	mov    (%eax),%al
  800da7:	0f b6 d8             	movzbl %al,%ebx
  800daa:	83 fb 25             	cmp    $0x25,%ebx
  800dad:	75 d6                	jne    800d85 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800daf:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800db3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800dba:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800dc1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800dc8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800dcf:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd2:	8d 50 01             	lea    0x1(%eax),%edx
  800dd5:	89 55 10             	mov    %edx,0x10(%ebp)
  800dd8:	8a 00                	mov    (%eax),%al
  800dda:	0f b6 d8             	movzbl %al,%ebx
  800ddd:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800de0:	83 f8 55             	cmp    $0x55,%eax
  800de3:	0f 87 2b 03 00 00    	ja     801114 <vprintfmt+0x399>
  800de9:	8b 04 85 f8 2a 80 00 	mov    0x802af8(,%eax,4),%eax
  800df0:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800df2:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800df6:	eb d7                	jmp    800dcf <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800df8:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800dfc:	eb d1                	jmp    800dcf <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800dfe:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800e05:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e08:	89 d0                	mov    %edx,%eax
  800e0a:	c1 e0 02             	shl    $0x2,%eax
  800e0d:	01 d0                	add    %edx,%eax
  800e0f:	01 c0                	add    %eax,%eax
  800e11:	01 d8                	add    %ebx,%eax
  800e13:	83 e8 30             	sub    $0x30,%eax
  800e16:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800e19:	8b 45 10             	mov    0x10(%ebp),%eax
  800e1c:	8a 00                	mov    (%eax),%al
  800e1e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e21:	83 fb 2f             	cmp    $0x2f,%ebx
  800e24:	7e 3e                	jle    800e64 <vprintfmt+0xe9>
  800e26:	83 fb 39             	cmp    $0x39,%ebx
  800e29:	7f 39                	jg     800e64 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e2b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e2e:	eb d5                	jmp    800e05 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e30:	8b 45 14             	mov    0x14(%ebp),%eax
  800e33:	83 c0 04             	add    $0x4,%eax
  800e36:	89 45 14             	mov    %eax,0x14(%ebp)
  800e39:	8b 45 14             	mov    0x14(%ebp),%eax
  800e3c:	83 e8 04             	sub    $0x4,%eax
  800e3f:	8b 00                	mov    (%eax),%eax
  800e41:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e44:	eb 1f                	jmp    800e65 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e46:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e4a:	79 83                	jns    800dcf <vprintfmt+0x54>
				width = 0;
  800e4c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e53:	e9 77 ff ff ff       	jmp    800dcf <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e58:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e5f:	e9 6b ff ff ff       	jmp    800dcf <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e64:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e65:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e69:	0f 89 60 ff ff ff    	jns    800dcf <vprintfmt+0x54>
				width = precision, precision = -1;
  800e6f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e72:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e75:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e7c:	e9 4e ff ff ff       	jmp    800dcf <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e81:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e84:	e9 46 ff ff ff       	jmp    800dcf <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e89:	8b 45 14             	mov    0x14(%ebp),%eax
  800e8c:	83 c0 04             	add    $0x4,%eax
  800e8f:	89 45 14             	mov    %eax,0x14(%ebp)
  800e92:	8b 45 14             	mov    0x14(%ebp),%eax
  800e95:	83 e8 04             	sub    $0x4,%eax
  800e98:	8b 00                	mov    (%eax),%eax
  800e9a:	83 ec 08             	sub    $0x8,%esp
  800e9d:	ff 75 0c             	pushl  0xc(%ebp)
  800ea0:	50                   	push   %eax
  800ea1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea4:	ff d0                	call   *%eax
  800ea6:	83 c4 10             	add    $0x10,%esp
			break;
  800ea9:	e9 89 02 00 00       	jmp    801137 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800eae:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb1:	83 c0 04             	add    $0x4,%eax
  800eb4:	89 45 14             	mov    %eax,0x14(%ebp)
  800eb7:	8b 45 14             	mov    0x14(%ebp),%eax
  800eba:	83 e8 04             	sub    $0x4,%eax
  800ebd:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ebf:	85 db                	test   %ebx,%ebx
  800ec1:	79 02                	jns    800ec5 <vprintfmt+0x14a>
				err = -err;
  800ec3:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ec5:	83 fb 64             	cmp    $0x64,%ebx
  800ec8:	7f 0b                	jg     800ed5 <vprintfmt+0x15a>
  800eca:	8b 34 9d 40 29 80 00 	mov    0x802940(,%ebx,4),%esi
  800ed1:	85 f6                	test   %esi,%esi
  800ed3:	75 19                	jne    800eee <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ed5:	53                   	push   %ebx
  800ed6:	68 e5 2a 80 00       	push   $0x802ae5
  800edb:	ff 75 0c             	pushl  0xc(%ebp)
  800ede:	ff 75 08             	pushl  0x8(%ebp)
  800ee1:	e8 5e 02 00 00       	call   801144 <printfmt>
  800ee6:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ee9:	e9 49 02 00 00       	jmp    801137 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800eee:	56                   	push   %esi
  800eef:	68 ee 2a 80 00       	push   $0x802aee
  800ef4:	ff 75 0c             	pushl  0xc(%ebp)
  800ef7:	ff 75 08             	pushl  0x8(%ebp)
  800efa:	e8 45 02 00 00       	call   801144 <printfmt>
  800eff:	83 c4 10             	add    $0x10,%esp
			break;
  800f02:	e9 30 02 00 00       	jmp    801137 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800f07:	8b 45 14             	mov    0x14(%ebp),%eax
  800f0a:	83 c0 04             	add    $0x4,%eax
  800f0d:	89 45 14             	mov    %eax,0x14(%ebp)
  800f10:	8b 45 14             	mov    0x14(%ebp),%eax
  800f13:	83 e8 04             	sub    $0x4,%eax
  800f16:	8b 30                	mov    (%eax),%esi
  800f18:	85 f6                	test   %esi,%esi
  800f1a:	75 05                	jne    800f21 <vprintfmt+0x1a6>
				p = "(null)";
  800f1c:	be f1 2a 80 00       	mov    $0x802af1,%esi
			if (width > 0 && padc != '-')
  800f21:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f25:	7e 6d                	jle    800f94 <vprintfmt+0x219>
  800f27:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f2b:	74 67                	je     800f94 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f2d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f30:	83 ec 08             	sub    $0x8,%esp
  800f33:	50                   	push   %eax
  800f34:	56                   	push   %esi
  800f35:	e8 12 05 00 00       	call   80144c <strnlen>
  800f3a:	83 c4 10             	add    $0x10,%esp
  800f3d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f40:	eb 16                	jmp    800f58 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f42:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f46:	83 ec 08             	sub    $0x8,%esp
  800f49:	ff 75 0c             	pushl  0xc(%ebp)
  800f4c:	50                   	push   %eax
  800f4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f50:	ff d0                	call   *%eax
  800f52:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f55:	ff 4d e4             	decl   -0x1c(%ebp)
  800f58:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f5c:	7f e4                	jg     800f42 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f5e:	eb 34                	jmp    800f94 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f60:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f64:	74 1c                	je     800f82 <vprintfmt+0x207>
  800f66:	83 fb 1f             	cmp    $0x1f,%ebx
  800f69:	7e 05                	jle    800f70 <vprintfmt+0x1f5>
  800f6b:	83 fb 7e             	cmp    $0x7e,%ebx
  800f6e:	7e 12                	jle    800f82 <vprintfmt+0x207>
					putch('?', putdat);
  800f70:	83 ec 08             	sub    $0x8,%esp
  800f73:	ff 75 0c             	pushl  0xc(%ebp)
  800f76:	6a 3f                	push   $0x3f
  800f78:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7b:	ff d0                	call   *%eax
  800f7d:	83 c4 10             	add    $0x10,%esp
  800f80:	eb 0f                	jmp    800f91 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f82:	83 ec 08             	sub    $0x8,%esp
  800f85:	ff 75 0c             	pushl  0xc(%ebp)
  800f88:	53                   	push   %ebx
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	ff d0                	call   *%eax
  800f8e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f91:	ff 4d e4             	decl   -0x1c(%ebp)
  800f94:	89 f0                	mov    %esi,%eax
  800f96:	8d 70 01             	lea    0x1(%eax),%esi
  800f99:	8a 00                	mov    (%eax),%al
  800f9b:	0f be d8             	movsbl %al,%ebx
  800f9e:	85 db                	test   %ebx,%ebx
  800fa0:	74 24                	je     800fc6 <vprintfmt+0x24b>
  800fa2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800fa6:	78 b8                	js     800f60 <vprintfmt+0x1e5>
  800fa8:	ff 4d e0             	decl   -0x20(%ebp)
  800fab:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800faf:	79 af                	jns    800f60 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fb1:	eb 13                	jmp    800fc6 <vprintfmt+0x24b>
				putch(' ', putdat);
  800fb3:	83 ec 08             	sub    $0x8,%esp
  800fb6:	ff 75 0c             	pushl  0xc(%ebp)
  800fb9:	6a 20                	push   $0x20
  800fbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbe:	ff d0                	call   *%eax
  800fc0:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fc3:	ff 4d e4             	decl   -0x1c(%ebp)
  800fc6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fca:	7f e7                	jg     800fb3 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fcc:	e9 66 01 00 00       	jmp    801137 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fd1:	83 ec 08             	sub    $0x8,%esp
  800fd4:	ff 75 e8             	pushl  -0x18(%ebp)
  800fd7:	8d 45 14             	lea    0x14(%ebp),%eax
  800fda:	50                   	push   %eax
  800fdb:	e8 3c fd ff ff       	call   800d1c <getint>
  800fe0:	83 c4 10             	add    $0x10,%esp
  800fe3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fe9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fec:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fef:	85 d2                	test   %edx,%edx
  800ff1:	79 23                	jns    801016 <vprintfmt+0x29b>
				putch('-', putdat);
  800ff3:	83 ec 08             	sub    $0x8,%esp
  800ff6:	ff 75 0c             	pushl  0xc(%ebp)
  800ff9:	6a 2d                	push   $0x2d
  800ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffe:	ff d0                	call   *%eax
  801000:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801003:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801006:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801009:	f7 d8                	neg    %eax
  80100b:	83 d2 00             	adc    $0x0,%edx
  80100e:	f7 da                	neg    %edx
  801010:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801013:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801016:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80101d:	e9 bc 00 00 00       	jmp    8010de <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801022:	83 ec 08             	sub    $0x8,%esp
  801025:	ff 75 e8             	pushl  -0x18(%ebp)
  801028:	8d 45 14             	lea    0x14(%ebp),%eax
  80102b:	50                   	push   %eax
  80102c:	e8 84 fc ff ff       	call   800cb5 <getuint>
  801031:	83 c4 10             	add    $0x10,%esp
  801034:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801037:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80103a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801041:	e9 98 00 00 00       	jmp    8010de <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801046:	83 ec 08             	sub    $0x8,%esp
  801049:	ff 75 0c             	pushl  0xc(%ebp)
  80104c:	6a 58                	push   $0x58
  80104e:	8b 45 08             	mov    0x8(%ebp),%eax
  801051:	ff d0                	call   *%eax
  801053:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801056:	83 ec 08             	sub    $0x8,%esp
  801059:	ff 75 0c             	pushl  0xc(%ebp)
  80105c:	6a 58                	push   $0x58
  80105e:	8b 45 08             	mov    0x8(%ebp),%eax
  801061:	ff d0                	call   *%eax
  801063:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801066:	83 ec 08             	sub    $0x8,%esp
  801069:	ff 75 0c             	pushl  0xc(%ebp)
  80106c:	6a 58                	push   $0x58
  80106e:	8b 45 08             	mov    0x8(%ebp),%eax
  801071:	ff d0                	call   *%eax
  801073:	83 c4 10             	add    $0x10,%esp
			break;
  801076:	e9 bc 00 00 00       	jmp    801137 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80107b:	83 ec 08             	sub    $0x8,%esp
  80107e:	ff 75 0c             	pushl  0xc(%ebp)
  801081:	6a 30                	push   $0x30
  801083:	8b 45 08             	mov    0x8(%ebp),%eax
  801086:	ff d0                	call   *%eax
  801088:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80108b:	83 ec 08             	sub    $0x8,%esp
  80108e:	ff 75 0c             	pushl  0xc(%ebp)
  801091:	6a 78                	push   $0x78
  801093:	8b 45 08             	mov    0x8(%ebp),%eax
  801096:	ff d0                	call   *%eax
  801098:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80109b:	8b 45 14             	mov    0x14(%ebp),%eax
  80109e:	83 c0 04             	add    $0x4,%eax
  8010a1:	89 45 14             	mov    %eax,0x14(%ebp)
  8010a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8010a7:	83 e8 04             	sub    $0x4,%eax
  8010aa:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8010ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8010b6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8010bd:	eb 1f                	jmp    8010de <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010bf:	83 ec 08             	sub    $0x8,%esp
  8010c2:	ff 75 e8             	pushl  -0x18(%ebp)
  8010c5:	8d 45 14             	lea    0x14(%ebp),%eax
  8010c8:	50                   	push   %eax
  8010c9:	e8 e7 fb ff ff       	call   800cb5 <getuint>
  8010ce:	83 c4 10             	add    $0x10,%esp
  8010d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010d4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010d7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010de:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010e5:	83 ec 04             	sub    $0x4,%esp
  8010e8:	52                   	push   %edx
  8010e9:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010ec:	50                   	push   %eax
  8010ed:	ff 75 f4             	pushl  -0xc(%ebp)
  8010f0:	ff 75 f0             	pushl  -0x10(%ebp)
  8010f3:	ff 75 0c             	pushl  0xc(%ebp)
  8010f6:	ff 75 08             	pushl  0x8(%ebp)
  8010f9:	e8 00 fb ff ff       	call   800bfe <printnum>
  8010fe:	83 c4 20             	add    $0x20,%esp
			break;
  801101:	eb 34                	jmp    801137 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801103:	83 ec 08             	sub    $0x8,%esp
  801106:	ff 75 0c             	pushl  0xc(%ebp)
  801109:	53                   	push   %ebx
  80110a:	8b 45 08             	mov    0x8(%ebp),%eax
  80110d:	ff d0                	call   *%eax
  80110f:	83 c4 10             	add    $0x10,%esp
			break;
  801112:	eb 23                	jmp    801137 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801114:	83 ec 08             	sub    $0x8,%esp
  801117:	ff 75 0c             	pushl  0xc(%ebp)
  80111a:	6a 25                	push   $0x25
  80111c:	8b 45 08             	mov    0x8(%ebp),%eax
  80111f:	ff d0                	call   *%eax
  801121:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801124:	ff 4d 10             	decl   0x10(%ebp)
  801127:	eb 03                	jmp    80112c <vprintfmt+0x3b1>
  801129:	ff 4d 10             	decl   0x10(%ebp)
  80112c:	8b 45 10             	mov    0x10(%ebp),%eax
  80112f:	48                   	dec    %eax
  801130:	8a 00                	mov    (%eax),%al
  801132:	3c 25                	cmp    $0x25,%al
  801134:	75 f3                	jne    801129 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801136:	90                   	nop
		}
	}
  801137:	e9 47 fc ff ff       	jmp    800d83 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80113c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80113d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801140:	5b                   	pop    %ebx
  801141:	5e                   	pop    %esi
  801142:	5d                   	pop    %ebp
  801143:	c3                   	ret    

00801144 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801144:	55                   	push   %ebp
  801145:	89 e5                	mov    %esp,%ebp
  801147:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80114a:	8d 45 10             	lea    0x10(%ebp),%eax
  80114d:	83 c0 04             	add    $0x4,%eax
  801150:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801153:	8b 45 10             	mov    0x10(%ebp),%eax
  801156:	ff 75 f4             	pushl  -0xc(%ebp)
  801159:	50                   	push   %eax
  80115a:	ff 75 0c             	pushl  0xc(%ebp)
  80115d:	ff 75 08             	pushl  0x8(%ebp)
  801160:	e8 16 fc ff ff       	call   800d7b <vprintfmt>
  801165:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801168:	90                   	nop
  801169:	c9                   	leave  
  80116a:	c3                   	ret    

0080116b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80116b:	55                   	push   %ebp
  80116c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80116e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801171:	8b 40 08             	mov    0x8(%eax),%eax
  801174:	8d 50 01             	lea    0x1(%eax),%edx
  801177:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80117d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801180:	8b 10                	mov    (%eax),%edx
  801182:	8b 45 0c             	mov    0xc(%ebp),%eax
  801185:	8b 40 04             	mov    0x4(%eax),%eax
  801188:	39 c2                	cmp    %eax,%edx
  80118a:	73 12                	jae    80119e <sprintputch+0x33>
		*b->buf++ = ch;
  80118c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118f:	8b 00                	mov    (%eax),%eax
  801191:	8d 48 01             	lea    0x1(%eax),%ecx
  801194:	8b 55 0c             	mov    0xc(%ebp),%edx
  801197:	89 0a                	mov    %ecx,(%edx)
  801199:	8b 55 08             	mov    0x8(%ebp),%edx
  80119c:	88 10                	mov    %dl,(%eax)
}
  80119e:	90                   	nop
  80119f:	5d                   	pop    %ebp
  8011a0:	c3                   	ret    

008011a1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8011a1:	55                   	push   %ebp
  8011a2:	89 e5                	mov    %esp,%ebp
  8011a4:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8011a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8011ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b6:	01 d0                	add    %edx,%eax
  8011b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011c2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011c6:	74 06                	je     8011ce <vsnprintf+0x2d>
  8011c8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011cc:	7f 07                	jg     8011d5 <vsnprintf+0x34>
		return -E_INVAL;
  8011ce:	b8 03 00 00 00       	mov    $0x3,%eax
  8011d3:	eb 20                	jmp    8011f5 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011d5:	ff 75 14             	pushl  0x14(%ebp)
  8011d8:	ff 75 10             	pushl  0x10(%ebp)
  8011db:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011de:	50                   	push   %eax
  8011df:	68 6b 11 80 00       	push   $0x80116b
  8011e4:	e8 92 fb ff ff       	call   800d7b <vprintfmt>
  8011e9:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011ef:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011f5:	c9                   	leave  
  8011f6:	c3                   	ret    

008011f7 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011f7:	55                   	push   %ebp
  8011f8:	89 e5                	mov    %esp,%ebp
  8011fa:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011fd:	8d 45 10             	lea    0x10(%ebp),%eax
  801200:	83 c0 04             	add    $0x4,%eax
  801203:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801206:	8b 45 10             	mov    0x10(%ebp),%eax
  801209:	ff 75 f4             	pushl  -0xc(%ebp)
  80120c:	50                   	push   %eax
  80120d:	ff 75 0c             	pushl  0xc(%ebp)
  801210:	ff 75 08             	pushl  0x8(%ebp)
  801213:	e8 89 ff ff ff       	call   8011a1 <vsnprintf>
  801218:	83 c4 10             	add    $0x10,%esp
  80121b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80121e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801221:	c9                   	leave  
  801222:	c3                   	ret    

00801223 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801223:	55                   	push   %ebp
  801224:	89 e5                	mov    %esp,%ebp
  801226:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801229:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80122d:	74 13                	je     801242 <readline+0x1f>
		cprintf("%s", prompt);
  80122f:	83 ec 08             	sub    $0x8,%esp
  801232:	ff 75 08             	pushl  0x8(%ebp)
  801235:	68 50 2c 80 00       	push   $0x802c50
  80123a:	e8 62 f9 ff ff       	call   800ba1 <cprintf>
  80123f:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801242:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801249:	83 ec 0c             	sub    $0xc,%esp
  80124c:	6a 00                	push   $0x0
  80124e:	e8 68 f5 ff ff       	call   8007bb <iscons>
  801253:	83 c4 10             	add    $0x10,%esp
  801256:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801259:	e8 0f f5 ff ff       	call   80076d <getchar>
  80125e:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801261:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801265:	79 22                	jns    801289 <readline+0x66>
			if (c != -E_EOF)
  801267:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80126b:	0f 84 ad 00 00 00    	je     80131e <readline+0xfb>
				cprintf("read error: %e\n", c);
  801271:	83 ec 08             	sub    $0x8,%esp
  801274:	ff 75 ec             	pushl  -0x14(%ebp)
  801277:	68 53 2c 80 00       	push   $0x802c53
  80127c:	e8 20 f9 ff ff       	call   800ba1 <cprintf>
  801281:	83 c4 10             	add    $0x10,%esp
			return;
  801284:	e9 95 00 00 00       	jmp    80131e <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801289:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80128d:	7e 34                	jle    8012c3 <readline+0xa0>
  80128f:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801296:	7f 2b                	jg     8012c3 <readline+0xa0>
			if (echoing)
  801298:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80129c:	74 0e                	je     8012ac <readline+0x89>
				cputchar(c);
  80129e:	83 ec 0c             	sub    $0xc,%esp
  8012a1:	ff 75 ec             	pushl  -0x14(%ebp)
  8012a4:	e8 7c f4 ff ff       	call   800725 <cputchar>
  8012a9:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8012ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012af:	8d 50 01             	lea    0x1(%eax),%edx
  8012b2:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8012b5:	89 c2                	mov    %eax,%edx
  8012b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ba:	01 d0                	add    %edx,%eax
  8012bc:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012bf:	88 10                	mov    %dl,(%eax)
  8012c1:	eb 56                	jmp    801319 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8012c3:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012c7:	75 1f                	jne    8012e8 <readline+0xc5>
  8012c9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012cd:	7e 19                	jle    8012e8 <readline+0xc5>
			if (echoing)
  8012cf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012d3:	74 0e                	je     8012e3 <readline+0xc0>
				cputchar(c);
  8012d5:	83 ec 0c             	sub    $0xc,%esp
  8012d8:	ff 75 ec             	pushl  -0x14(%ebp)
  8012db:	e8 45 f4 ff ff       	call   800725 <cputchar>
  8012e0:	83 c4 10             	add    $0x10,%esp

			i--;
  8012e3:	ff 4d f4             	decl   -0xc(%ebp)
  8012e6:	eb 31                	jmp    801319 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8012e8:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012ec:	74 0a                	je     8012f8 <readline+0xd5>
  8012ee:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012f2:	0f 85 61 ff ff ff    	jne    801259 <readline+0x36>
			if (echoing)
  8012f8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012fc:	74 0e                	je     80130c <readline+0xe9>
				cputchar(c);
  8012fe:	83 ec 0c             	sub    $0xc,%esp
  801301:	ff 75 ec             	pushl  -0x14(%ebp)
  801304:	e8 1c f4 ff ff       	call   800725 <cputchar>
  801309:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80130c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80130f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801312:	01 d0                	add    %edx,%eax
  801314:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801317:	eb 06                	jmp    80131f <readline+0xfc>
		}
	}
  801319:	e9 3b ff ff ff       	jmp    801259 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  80131e:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  80131f:	c9                   	leave  
  801320:	c3                   	ret    

00801321 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801321:	55                   	push   %ebp
  801322:	89 e5                	mov    %esp,%ebp
  801324:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801327:	e8 31 0b 00 00       	call   801e5d <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80132c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801330:	74 13                	je     801345 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801332:	83 ec 08             	sub    $0x8,%esp
  801335:	ff 75 08             	pushl  0x8(%ebp)
  801338:	68 50 2c 80 00       	push   $0x802c50
  80133d:	e8 5f f8 ff ff       	call   800ba1 <cprintf>
  801342:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801345:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80134c:	83 ec 0c             	sub    $0xc,%esp
  80134f:	6a 00                	push   $0x0
  801351:	e8 65 f4 ff ff       	call   8007bb <iscons>
  801356:	83 c4 10             	add    $0x10,%esp
  801359:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80135c:	e8 0c f4 ff ff       	call   80076d <getchar>
  801361:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801364:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801368:	79 23                	jns    80138d <atomic_readline+0x6c>
			if (c != -E_EOF)
  80136a:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80136e:	74 13                	je     801383 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801370:	83 ec 08             	sub    $0x8,%esp
  801373:	ff 75 ec             	pushl  -0x14(%ebp)
  801376:	68 53 2c 80 00       	push   $0x802c53
  80137b:	e8 21 f8 ff ff       	call   800ba1 <cprintf>
  801380:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801383:	e8 ef 0a 00 00       	call   801e77 <sys_enable_interrupt>
			return;
  801388:	e9 9a 00 00 00       	jmp    801427 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80138d:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801391:	7e 34                	jle    8013c7 <atomic_readline+0xa6>
  801393:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80139a:	7f 2b                	jg     8013c7 <atomic_readline+0xa6>
			if (echoing)
  80139c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013a0:	74 0e                	je     8013b0 <atomic_readline+0x8f>
				cputchar(c);
  8013a2:	83 ec 0c             	sub    $0xc,%esp
  8013a5:	ff 75 ec             	pushl  -0x14(%ebp)
  8013a8:	e8 78 f3 ff ff       	call   800725 <cputchar>
  8013ad:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8013b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013b3:	8d 50 01             	lea    0x1(%eax),%edx
  8013b6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8013b9:	89 c2                	mov    %eax,%edx
  8013bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013be:	01 d0                	add    %edx,%eax
  8013c0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013c3:	88 10                	mov    %dl,(%eax)
  8013c5:	eb 5b                	jmp    801422 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8013c7:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8013cb:	75 1f                	jne    8013ec <atomic_readline+0xcb>
  8013cd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8013d1:	7e 19                	jle    8013ec <atomic_readline+0xcb>
			if (echoing)
  8013d3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013d7:	74 0e                	je     8013e7 <atomic_readline+0xc6>
				cputchar(c);
  8013d9:	83 ec 0c             	sub    $0xc,%esp
  8013dc:	ff 75 ec             	pushl  -0x14(%ebp)
  8013df:	e8 41 f3 ff ff       	call   800725 <cputchar>
  8013e4:	83 c4 10             	add    $0x10,%esp
			i--;
  8013e7:	ff 4d f4             	decl   -0xc(%ebp)
  8013ea:	eb 36                	jmp    801422 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8013ec:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8013f0:	74 0a                	je     8013fc <atomic_readline+0xdb>
  8013f2:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8013f6:	0f 85 60 ff ff ff    	jne    80135c <atomic_readline+0x3b>
			if (echoing)
  8013fc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801400:	74 0e                	je     801410 <atomic_readline+0xef>
				cputchar(c);
  801402:	83 ec 0c             	sub    $0xc,%esp
  801405:	ff 75 ec             	pushl  -0x14(%ebp)
  801408:	e8 18 f3 ff ff       	call   800725 <cputchar>
  80140d:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801410:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801413:	8b 45 0c             	mov    0xc(%ebp),%eax
  801416:	01 d0                	add    %edx,%eax
  801418:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80141b:	e8 57 0a 00 00       	call   801e77 <sys_enable_interrupt>
			return;
  801420:	eb 05                	jmp    801427 <atomic_readline+0x106>
		}
	}
  801422:	e9 35 ff ff ff       	jmp    80135c <atomic_readline+0x3b>
}
  801427:	c9                   	leave  
  801428:	c3                   	ret    

00801429 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801429:	55                   	push   %ebp
  80142a:	89 e5                	mov    %esp,%ebp
  80142c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80142f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801436:	eb 06                	jmp    80143e <strlen+0x15>
		n++;
  801438:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80143b:	ff 45 08             	incl   0x8(%ebp)
  80143e:	8b 45 08             	mov    0x8(%ebp),%eax
  801441:	8a 00                	mov    (%eax),%al
  801443:	84 c0                	test   %al,%al
  801445:	75 f1                	jne    801438 <strlen+0xf>
		n++;
	return n;
  801447:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80144a:	c9                   	leave  
  80144b:	c3                   	ret    

0080144c <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80144c:	55                   	push   %ebp
  80144d:	89 e5                	mov    %esp,%ebp
  80144f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801452:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801459:	eb 09                	jmp    801464 <strnlen+0x18>
		n++;
  80145b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80145e:	ff 45 08             	incl   0x8(%ebp)
  801461:	ff 4d 0c             	decl   0xc(%ebp)
  801464:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801468:	74 09                	je     801473 <strnlen+0x27>
  80146a:	8b 45 08             	mov    0x8(%ebp),%eax
  80146d:	8a 00                	mov    (%eax),%al
  80146f:	84 c0                	test   %al,%al
  801471:	75 e8                	jne    80145b <strnlen+0xf>
		n++;
	return n;
  801473:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801476:	c9                   	leave  
  801477:	c3                   	ret    

00801478 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801478:	55                   	push   %ebp
  801479:	89 e5                	mov    %esp,%ebp
  80147b:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80147e:	8b 45 08             	mov    0x8(%ebp),%eax
  801481:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801484:	90                   	nop
  801485:	8b 45 08             	mov    0x8(%ebp),%eax
  801488:	8d 50 01             	lea    0x1(%eax),%edx
  80148b:	89 55 08             	mov    %edx,0x8(%ebp)
  80148e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801491:	8d 4a 01             	lea    0x1(%edx),%ecx
  801494:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801497:	8a 12                	mov    (%edx),%dl
  801499:	88 10                	mov    %dl,(%eax)
  80149b:	8a 00                	mov    (%eax),%al
  80149d:	84 c0                	test   %al,%al
  80149f:	75 e4                	jne    801485 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8014a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8014a4:	c9                   	leave  
  8014a5:	c3                   	ret    

008014a6 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8014a6:	55                   	push   %ebp
  8014a7:	89 e5                	mov    %esp,%ebp
  8014a9:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8014ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8014af:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8014b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014b9:	eb 1f                	jmp    8014da <strncpy+0x34>
		*dst++ = *src;
  8014bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014be:	8d 50 01             	lea    0x1(%eax),%edx
  8014c1:	89 55 08             	mov    %edx,0x8(%ebp)
  8014c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014c7:	8a 12                	mov    (%edx),%dl
  8014c9:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ce:	8a 00                	mov    (%eax),%al
  8014d0:	84 c0                	test   %al,%al
  8014d2:	74 03                	je     8014d7 <strncpy+0x31>
			src++;
  8014d4:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014d7:	ff 45 fc             	incl   -0x4(%ebp)
  8014da:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014dd:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014e0:	72 d9                	jb     8014bb <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014e5:	c9                   	leave  
  8014e6:	c3                   	ret    

008014e7 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014e7:	55                   	push   %ebp
  8014e8:	89 e5                	mov    %esp,%ebp
  8014ea:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014f3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014f7:	74 30                	je     801529 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8014f9:	eb 16                	jmp    801511 <strlcpy+0x2a>
			*dst++ = *src++;
  8014fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fe:	8d 50 01             	lea    0x1(%eax),%edx
  801501:	89 55 08             	mov    %edx,0x8(%ebp)
  801504:	8b 55 0c             	mov    0xc(%ebp),%edx
  801507:	8d 4a 01             	lea    0x1(%edx),%ecx
  80150a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80150d:	8a 12                	mov    (%edx),%dl
  80150f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801511:	ff 4d 10             	decl   0x10(%ebp)
  801514:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801518:	74 09                	je     801523 <strlcpy+0x3c>
  80151a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151d:	8a 00                	mov    (%eax),%al
  80151f:	84 c0                	test   %al,%al
  801521:	75 d8                	jne    8014fb <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801523:	8b 45 08             	mov    0x8(%ebp),%eax
  801526:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801529:	8b 55 08             	mov    0x8(%ebp),%edx
  80152c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80152f:	29 c2                	sub    %eax,%edx
  801531:	89 d0                	mov    %edx,%eax
}
  801533:	c9                   	leave  
  801534:	c3                   	ret    

00801535 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801535:	55                   	push   %ebp
  801536:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801538:	eb 06                	jmp    801540 <strcmp+0xb>
		p++, q++;
  80153a:	ff 45 08             	incl   0x8(%ebp)
  80153d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801540:	8b 45 08             	mov    0x8(%ebp),%eax
  801543:	8a 00                	mov    (%eax),%al
  801545:	84 c0                	test   %al,%al
  801547:	74 0e                	je     801557 <strcmp+0x22>
  801549:	8b 45 08             	mov    0x8(%ebp),%eax
  80154c:	8a 10                	mov    (%eax),%dl
  80154e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801551:	8a 00                	mov    (%eax),%al
  801553:	38 c2                	cmp    %al,%dl
  801555:	74 e3                	je     80153a <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801557:	8b 45 08             	mov    0x8(%ebp),%eax
  80155a:	8a 00                	mov    (%eax),%al
  80155c:	0f b6 d0             	movzbl %al,%edx
  80155f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801562:	8a 00                	mov    (%eax),%al
  801564:	0f b6 c0             	movzbl %al,%eax
  801567:	29 c2                	sub    %eax,%edx
  801569:	89 d0                	mov    %edx,%eax
}
  80156b:	5d                   	pop    %ebp
  80156c:	c3                   	ret    

0080156d <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80156d:	55                   	push   %ebp
  80156e:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801570:	eb 09                	jmp    80157b <strncmp+0xe>
		n--, p++, q++;
  801572:	ff 4d 10             	decl   0x10(%ebp)
  801575:	ff 45 08             	incl   0x8(%ebp)
  801578:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80157b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80157f:	74 17                	je     801598 <strncmp+0x2b>
  801581:	8b 45 08             	mov    0x8(%ebp),%eax
  801584:	8a 00                	mov    (%eax),%al
  801586:	84 c0                	test   %al,%al
  801588:	74 0e                	je     801598 <strncmp+0x2b>
  80158a:	8b 45 08             	mov    0x8(%ebp),%eax
  80158d:	8a 10                	mov    (%eax),%dl
  80158f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801592:	8a 00                	mov    (%eax),%al
  801594:	38 c2                	cmp    %al,%dl
  801596:	74 da                	je     801572 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801598:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80159c:	75 07                	jne    8015a5 <strncmp+0x38>
		return 0;
  80159e:	b8 00 00 00 00       	mov    $0x0,%eax
  8015a3:	eb 14                	jmp    8015b9 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8015a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a8:	8a 00                	mov    (%eax),%al
  8015aa:	0f b6 d0             	movzbl %al,%edx
  8015ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b0:	8a 00                	mov    (%eax),%al
  8015b2:	0f b6 c0             	movzbl %al,%eax
  8015b5:	29 c2                	sub    %eax,%edx
  8015b7:	89 d0                	mov    %edx,%eax
}
  8015b9:	5d                   	pop    %ebp
  8015ba:	c3                   	ret    

008015bb <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8015bb:	55                   	push   %ebp
  8015bc:	89 e5                	mov    %esp,%ebp
  8015be:	83 ec 04             	sub    $0x4,%esp
  8015c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015c7:	eb 12                	jmp    8015db <strchr+0x20>
		if (*s == c)
  8015c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cc:	8a 00                	mov    (%eax),%al
  8015ce:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015d1:	75 05                	jne    8015d8 <strchr+0x1d>
			return (char *) s;
  8015d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d6:	eb 11                	jmp    8015e9 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015d8:	ff 45 08             	incl   0x8(%ebp)
  8015db:	8b 45 08             	mov    0x8(%ebp),%eax
  8015de:	8a 00                	mov    (%eax),%al
  8015e0:	84 c0                	test   %al,%al
  8015e2:	75 e5                	jne    8015c9 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015e9:	c9                   	leave  
  8015ea:	c3                   	ret    

008015eb <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015eb:	55                   	push   %ebp
  8015ec:	89 e5                	mov    %esp,%ebp
  8015ee:	83 ec 04             	sub    $0x4,%esp
  8015f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015f4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015f7:	eb 0d                	jmp    801606 <strfind+0x1b>
		if (*s == c)
  8015f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fc:	8a 00                	mov    (%eax),%al
  8015fe:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801601:	74 0e                	je     801611 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801603:	ff 45 08             	incl   0x8(%ebp)
  801606:	8b 45 08             	mov    0x8(%ebp),%eax
  801609:	8a 00                	mov    (%eax),%al
  80160b:	84 c0                	test   %al,%al
  80160d:	75 ea                	jne    8015f9 <strfind+0xe>
  80160f:	eb 01                	jmp    801612 <strfind+0x27>
		if (*s == c)
			break;
  801611:	90                   	nop
	return (char *) s;
  801612:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801615:	c9                   	leave  
  801616:	c3                   	ret    

00801617 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801617:	55                   	push   %ebp
  801618:	89 e5                	mov    %esp,%ebp
  80161a:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80161d:	8b 45 08             	mov    0x8(%ebp),%eax
  801620:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801623:	8b 45 10             	mov    0x10(%ebp),%eax
  801626:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801629:	eb 0e                	jmp    801639 <memset+0x22>
		*p++ = c;
  80162b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80162e:	8d 50 01             	lea    0x1(%eax),%edx
  801631:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801634:	8b 55 0c             	mov    0xc(%ebp),%edx
  801637:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801639:	ff 4d f8             	decl   -0x8(%ebp)
  80163c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801640:	79 e9                	jns    80162b <memset+0x14>
		*p++ = c;

	return v;
  801642:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801645:	c9                   	leave  
  801646:	c3                   	ret    

00801647 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801647:	55                   	push   %ebp
  801648:	89 e5                	mov    %esp,%ebp
  80164a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80164d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801650:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801653:	8b 45 08             	mov    0x8(%ebp),%eax
  801656:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801659:	eb 16                	jmp    801671 <memcpy+0x2a>
		*d++ = *s++;
  80165b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80165e:	8d 50 01             	lea    0x1(%eax),%edx
  801661:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801664:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801667:	8d 4a 01             	lea    0x1(%edx),%ecx
  80166a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80166d:	8a 12                	mov    (%edx),%dl
  80166f:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801671:	8b 45 10             	mov    0x10(%ebp),%eax
  801674:	8d 50 ff             	lea    -0x1(%eax),%edx
  801677:	89 55 10             	mov    %edx,0x10(%ebp)
  80167a:	85 c0                	test   %eax,%eax
  80167c:	75 dd                	jne    80165b <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80167e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801681:	c9                   	leave  
  801682:	c3                   	ret    

00801683 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801683:	55                   	push   %ebp
  801684:	89 e5                	mov    %esp,%ebp
  801686:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801689:	8b 45 0c             	mov    0xc(%ebp),%eax
  80168c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80168f:	8b 45 08             	mov    0x8(%ebp),%eax
  801692:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801695:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801698:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80169b:	73 50                	jae    8016ed <memmove+0x6a>
  80169d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a3:	01 d0                	add    %edx,%eax
  8016a5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8016a8:	76 43                	jbe    8016ed <memmove+0x6a>
		s += n;
  8016aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ad:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8016b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b3:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8016b6:	eb 10                	jmp    8016c8 <memmove+0x45>
			*--d = *--s;
  8016b8:	ff 4d f8             	decl   -0x8(%ebp)
  8016bb:	ff 4d fc             	decl   -0x4(%ebp)
  8016be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016c1:	8a 10                	mov    (%eax),%dl
  8016c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016c6:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8016cb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016ce:	89 55 10             	mov    %edx,0x10(%ebp)
  8016d1:	85 c0                	test   %eax,%eax
  8016d3:	75 e3                	jne    8016b8 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016d5:	eb 23                	jmp    8016fa <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016da:	8d 50 01             	lea    0x1(%eax),%edx
  8016dd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016e0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016e3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016e6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016e9:	8a 12                	mov    (%edx),%dl
  8016eb:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8016f0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016f3:	89 55 10             	mov    %edx,0x10(%ebp)
  8016f6:	85 c0                	test   %eax,%eax
  8016f8:	75 dd                	jne    8016d7 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016fa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016fd:	c9                   	leave  
  8016fe:	c3                   	ret    

008016ff <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8016ff:	55                   	push   %ebp
  801700:	89 e5                	mov    %esp,%ebp
  801702:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801705:	8b 45 08             	mov    0x8(%ebp),%eax
  801708:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80170b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80170e:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801711:	eb 2a                	jmp    80173d <memcmp+0x3e>
		if (*s1 != *s2)
  801713:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801716:	8a 10                	mov    (%eax),%dl
  801718:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80171b:	8a 00                	mov    (%eax),%al
  80171d:	38 c2                	cmp    %al,%dl
  80171f:	74 16                	je     801737 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801721:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801724:	8a 00                	mov    (%eax),%al
  801726:	0f b6 d0             	movzbl %al,%edx
  801729:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80172c:	8a 00                	mov    (%eax),%al
  80172e:	0f b6 c0             	movzbl %al,%eax
  801731:	29 c2                	sub    %eax,%edx
  801733:	89 d0                	mov    %edx,%eax
  801735:	eb 18                	jmp    80174f <memcmp+0x50>
		s1++, s2++;
  801737:	ff 45 fc             	incl   -0x4(%ebp)
  80173a:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80173d:	8b 45 10             	mov    0x10(%ebp),%eax
  801740:	8d 50 ff             	lea    -0x1(%eax),%edx
  801743:	89 55 10             	mov    %edx,0x10(%ebp)
  801746:	85 c0                	test   %eax,%eax
  801748:	75 c9                	jne    801713 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80174a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80174f:	c9                   	leave  
  801750:	c3                   	ret    

00801751 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801751:	55                   	push   %ebp
  801752:	89 e5                	mov    %esp,%ebp
  801754:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801757:	8b 55 08             	mov    0x8(%ebp),%edx
  80175a:	8b 45 10             	mov    0x10(%ebp),%eax
  80175d:	01 d0                	add    %edx,%eax
  80175f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801762:	eb 15                	jmp    801779 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801764:	8b 45 08             	mov    0x8(%ebp),%eax
  801767:	8a 00                	mov    (%eax),%al
  801769:	0f b6 d0             	movzbl %al,%edx
  80176c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80176f:	0f b6 c0             	movzbl %al,%eax
  801772:	39 c2                	cmp    %eax,%edx
  801774:	74 0d                	je     801783 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801776:	ff 45 08             	incl   0x8(%ebp)
  801779:	8b 45 08             	mov    0x8(%ebp),%eax
  80177c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80177f:	72 e3                	jb     801764 <memfind+0x13>
  801781:	eb 01                	jmp    801784 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801783:	90                   	nop
	return (void *) s;
  801784:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801787:	c9                   	leave  
  801788:	c3                   	ret    

00801789 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801789:	55                   	push   %ebp
  80178a:	89 e5                	mov    %esp,%ebp
  80178c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80178f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801796:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80179d:	eb 03                	jmp    8017a2 <strtol+0x19>
		s++;
  80179f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8017a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a5:	8a 00                	mov    (%eax),%al
  8017a7:	3c 20                	cmp    $0x20,%al
  8017a9:	74 f4                	je     80179f <strtol+0x16>
  8017ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ae:	8a 00                	mov    (%eax),%al
  8017b0:	3c 09                	cmp    $0x9,%al
  8017b2:	74 eb                	je     80179f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8017b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b7:	8a 00                	mov    (%eax),%al
  8017b9:	3c 2b                	cmp    $0x2b,%al
  8017bb:	75 05                	jne    8017c2 <strtol+0x39>
		s++;
  8017bd:	ff 45 08             	incl   0x8(%ebp)
  8017c0:	eb 13                	jmp    8017d5 <strtol+0x4c>
	else if (*s == '-')
  8017c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c5:	8a 00                	mov    (%eax),%al
  8017c7:	3c 2d                	cmp    $0x2d,%al
  8017c9:	75 0a                	jne    8017d5 <strtol+0x4c>
		s++, neg = 1;
  8017cb:	ff 45 08             	incl   0x8(%ebp)
  8017ce:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017d5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017d9:	74 06                	je     8017e1 <strtol+0x58>
  8017db:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017df:	75 20                	jne    801801 <strtol+0x78>
  8017e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e4:	8a 00                	mov    (%eax),%al
  8017e6:	3c 30                	cmp    $0x30,%al
  8017e8:	75 17                	jne    801801 <strtol+0x78>
  8017ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ed:	40                   	inc    %eax
  8017ee:	8a 00                	mov    (%eax),%al
  8017f0:	3c 78                	cmp    $0x78,%al
  8017f2:	75 0d                	jne    801801 <strtol+0x78>
		s += 2, base = 16;
  8017f4:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017f8:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8017ff:	eb 28                	jmp    801829 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801801:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801805:	75 15                	jne    80181c <strtol+0x93>
  801807:	8b 45 08             	mov    0x8(%ebp),%eax
  80180a:	8a 00                	mov    (%eax),%al
  80180c:	3c 30                	cmp    $0x30,%al
  80180e:	75 0c                	jne    80181c <strtol+0x93>
		s++, base = 8;
  801810:	ff 45 08             	incl   0x8(%ebp)
  801813:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80181a:	eb 0d                	jmp    801829 <strtol+0xa0>
	else if (base == 0)
  80181c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801820:	75 07                	jne    801829 <strtol+0xa0>
		base = 10;
  801822:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801829:	8b 45 08             	mov    0x8(%ebp),%eax
  80182c:	8a 00                	mov    (%eax),%al
  80182e:	3c 2f                	cmp    $0x2f,%al
  801830:	7e 19                	jle    80184b <strtol+0xc2>
  801832:	8b 45 08             	mov    0x8(%ebp),%eax
  801835:	8a 00                	mov    (%eax),%al
  801837:	3c 39                	cmp    $0x39,%al
  801839:	7f 10                	jg     80184b <strtol+0xc2>
			dig = *s - '0';
  80183b:	8b 45 08             	mov    0x8(%ebp),%eax
  80183e:	8a 00                	mov    (%eax),%al
  801840:	0f be c0             	movsbl %al,%eax
  801843:	83 e8 30             	sub    $0x30,%eax
  801846:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801849:	eb 42                	jmp    80188d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80184b:	8b 45 08             	mov    0x8(%ebp),%eax
  80184e:	8a 00                	mov    (%eax),%al
  801850:	3c 60                	cmp    $0x60,%al
  801852:	7e 19                	jle    80186d <strtol+0xe4>
  801854:	8b 45 08             	mov    0x8(%ebp),%eax
  801857:	8a 00                	mov    (%eax),%al
  801859:	3c 7a                	cmp    $0x7a,%al
  80185b:	7f 10                	jg     80186d <strtol+0xe4>
			dig = *s - 'a' + 10;
  80185d:	8b 45 08             	mov    0x8(%ebp),%eax
  801860:	8a 00                	mov    (%eax),%al
  801862:	0f be c0             	movsbl %al,%eax
  801865:	83 e8 57             	sub    $0x57,%eax
  801868:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80186b:	eb 20                	jmp    80188d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80186d:	8b 45 08             	mov    0x8(%ebp),%eax
  801870:	8a 00                	mov    (%eax),%al
  801872:	3c 40                	cmp    $0x40,%al
  801874:	7e 39                	jle    8018af <strtol+0x126>
  801876:	8b 45 08             	mov    0x8(%ebp),%eax
  801879:	8a 00                	mov    (%eax),%al
  80187b:	3c 5a                	cmp    $0x5a,%al
  80187d:	7f 30                	jg     8018af <strtol+0x126>
			dig = *s - 'A' + 10;
  80187f:	8b 45 08             	mov    0x8(%ebp),%eax
  801882:	8a 00                	mov    (%eax),%al
  801884:	0f be c0             	movsbl %al,%eax
  801887:	83 e8 37             	sub    $0x37,%eax
  80188a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80188d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801890:	3b 45 10             	cmp    0x10(%ebp),%eax
  801893:	7d 19                	jge    8018ae <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801895:	ff 45 08             	incl   0x8(%ebp)
  801898:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80189b:	0f af 45 10          	imul   0x10(%ebp),%eax
  80189f:	89 c2                	mov    %eax,%edx
  8018a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018a4:	01 d0                	add    %edx,%eax
  8018a6:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8018a9:	e9 7b ff ff ff       	jmp    801829 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8018ae:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8018af:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8018b3:	74 08                	je     8018bd <strtol+0x134>
		*endptr = (char *) s;
  8018b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b8:	8b 55 08             	mov    0x8(%ebp),%edx
  8018bb:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8018bd:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018c1:	74 07                	je     8018ca <strtol+0x141>
  8018c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018c6:	f7 d8                	neg    %eax
  8018c8:	eb 03                	jmp    8018cd <strtol+0x144>
  8018ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018cd:	c9                   	leave  
  8018ce:	c3                   	ret    

008018cf <ltostr>:

void
ltostr(long value, char *str)
{
  8018cf:	55                   	push   %ebp
  8018d0:	89 e5                	mov    %esp,%ebp
  8018d2:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018dc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018e3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018e7:	79 13                	jns    8018fc <ltostr+0x2d>
	{
		neg = 1;
  8018e9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018f3:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018f6:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018f9:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ff:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801904:	99                   	cltd   
  801905:	f7 f9                	idiv   %ecx
  801907:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80190a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80190d:	8d 50 01             	lea    0x1(%eax),%edx
  801910:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801913:	89 c2                	mov    %eax,%edx
  801915:	8b 45 0c             	mov    0xc(%ebp),%eax
  801918:	01 d0                	add    %edx,%eax
  80191a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80191d:	83 c2 30             	add    $0x30,%edx
  801920:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801922:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801925:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80192a:	f7 e9                	imul   %ecx
  80192c:	c1 fa 02             	sar    $0x2,%edx
  80192f:	89 c8                	mov    %ecx,%eax
  801931:	c1 f8 1f             	sar    $0x1f,%eax
  801934:	29 c2                	sub    %eax,%edx
  801936:	89 d0                	mov    %edx,%eax
  801938:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80193b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80193e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801943:	f7 e9                	imul   %ecx
  801945:	c1 fa 02             	sar    $0x2,%edx
  801948:	89 c8                	mov    %ecx,%eax
  80194a:	c1 f8 1f             	sar    $0x1f,%eax
  80194d:	29 c2                	sub    %eax,%edx
  80194f:	89 d0                	mov    %edx,%eax
  801951:	c1 e0 02             	shl    $0x2,%eax
  801954:	01 d0                	add    %edx,%eax
  801956:	01 c0                	add    %eax,%eax
  801958:	29 c1                	sub    %eax,%ecx
  80195a:	89 ca                	mov    %ecx,%edx
  80195c:	85 d2                	test   %edx,%edx
  80195e:	75 9c                	jne    8018fc <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801960:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801967:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80196a:	48                   	dec    %eax
  80196b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80196e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801972:	74 3d                	je     8019b1 <ltostr+0xe2>
		start = 1 ;
  801974:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80197b:	eb 34                	jmp    8019b1 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80197d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801980:	8b 45 0c             	mov    0xc(%ebp),%eax
  801983:	01 d0                	add    %edx,%eax
  801985:	8a 00                	mov    (%eax),%al
  801987:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80198a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80198d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801990:	01 c2                	add    %eax,%edx
  801992:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801995:	8b 45 0c             	mov    0xc(%ebp),%eax
  801998:	01 c8                	add    %ecx,%eax
  80199a:	8a 00                	mov    (%eax),%al
  80199c:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80199e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8019a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a4:	01 c2                	add    %eax,%edx
  8019a6:	8a 45 eb             	mov    -0x15(%ebp),%al
  8019a9:	88 02                	mov    %al,(%edx)
		start++ ;
  8019ab:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8019ae:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8019b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019b4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019b7:	7c c4                	jl     80197d <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8019b9:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8019bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019bf:	01 d0                	add    %edx,%eax
  8019c1:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8019c4:	90                   	nop
  8019c5:	c9                   	leave  
  8019c6:	c3                   	ret    

008019c7 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8019c7:	55                   	push   %ebp
  8019c8:	89 e5                	mov    %esp,%ebp
  8019ca:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8019cd:	ff 75 08             	pushl  0x8(%ebp)
  8019d0:	e8 54 fa ff ff       	call   801429 <strlen>
  8019d5:	83 c4 04             	add    $0x4,%esp
  8019d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019db:	ff 75 0c             	pushl  0xc(%ebp)
  8019de:	e8 46 fa ff ff       	call   801429 <strlen>
  8019e3:	83 c4 04             	add    $0x4,%esp
  8019e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019f7:	eb 17                	jmp    801a10 <strcconcat+0x49>
		final[s] = str1[s] ;
  8019f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ff:	01 c2                	add    %eax,%edx
  801a01:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a04:	8b 45 08             	mov    0x8(%ebp),%eax
  801a07:	01 c8                	add    %ecx,%eax
  801a09:	8a 00                	mov    (%eax),%al
  801a0b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801a0d:	ff 45 fc             	incl   -0x4(%ebp)
  801a10:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a13:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a16:	7c e1                	jl     8019f9 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801a18:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a1f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a26:	eb 1f                	jmp    801a47 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a28:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a2b:	8d 50 01             	lea    0x1(%eax),%edx
  801a2e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a31:	89 c2                	mov    %eax,%edx
  801a33:	8b 45 10             	mov    0x10(%ebp),%eax
  801a36:	01 c2                	add    %eax,%edx
  801a38:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a3e:	01 c8                	add    %ecx,%eax
  801a40:	8a 00                	mov    (%eax),%al
  801a42:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a44:	ff 45 f8             	incl   -0x8(%ebp)
  801a47:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a4a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a4d:	7c d9                	jl     801a28 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a4f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a52:	8b 45 10             	mov    0x10(%ebp),%eax
  801a55:	01 d0                	add    %edx,%eax
  801a57:	c6 00 00             	movb   $0x0,(%eax)
}
  801a5a:	90                   	nop
  801a5b:	c9                   	leave  
  801a5c:	c3                   	ret    

00801a5d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a5d:	55                   	push   %ebp
  801a5e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a60:	8b 45 14             	mov    0x14(%ebp),%eax
  801a63:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a69:	8b 45 14             	mov    0x14(%ebp),%eax
  801a6c:	8b 00                	mov    (%eax),%eax
  801a6e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a75:	8b 45 10             	mov    0x10(%ebp),%eax
  801a78:	01 d0                	add    %edx,%eax
  801a7a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a80:	eb 0c                	jmp    801a8e <strsplit+0x31>
			*string++ = 0;
  801a82:	8b 45 08             	mov    0x8(%ebp),%eax
  801a85:	8d 50 01             	lea    0x1(%eax),%edx
  801a88:	89 55 08             	mov    %edx,0x8(%ebp)
  801a8b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a91:	8a 00                	mov    (%eax),%al
  801a93:	84 c0                	test   %al,%al
  801a95:	74 18                	je     801aaf <strsplit+0x52>
  801a97:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9a:	8a 00                	mov    (%eax),%al
  801a9c:	0f be c0             	movsbl %al,%eax
  801a9f:	50                   	push   %eax
  801aa0:	ff 75 0c             	pushl  0xc(%ebp)
  801aa3:	e8 13 fb ff ff       	call   8015bb <strchr>
  801aa8:	83 c4 08             	add    $0x8,%esp
  801aab:	85 c0                	test   %eax,%eax
  801aad:	75 d3                	jne    801a82 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801aaf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab2:	8a 00                	mov    (%eax),%al
  801ab4:	84 c0                	test   %al,%al
  801ab6:	74 5a                	je     801b12 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801ab8:	8b 45 14             	mov    0x14(%ebp),%eax
  801abb:	8b 00                	mov    (%eax),%eax
  801abd:	83 f8 0f             	cmp    $0xf,%eax
  801ac0:	75 07                	jne    801ac9 <strsplit+0x6c>
		{
			return 0;
  801ac2:	b8 00 00 00 00       	mov    $0x0,%eax
  801ac7:	eb 66                	jmp    801b2f <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801ac9:	8b 45 14             	mov    0x14(%ebp),%eax
  801acc:	8b 00                	mov    (%eax),%eax
  801ace:	8d 48 01             	lea    0x1(%eax),%ecx
  801ad1:	8b 55 14             	mov    0x14(%ebp),%edx
  801ad4:	89 0a                	mov    %ecx,(%edx)
  801ad6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801add:	8b 45 10             	mov    0x10(%ebp),%eax
  801ae0:	01 c2                	add    %eax,%edx
  801ae2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae5:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ae7:	eb 03                	jmp    801aec <strsplit+0x8f>
			string++;
  801ae9:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801aec:	8b 45 08             	mov    0x8(%ebp),%eax
  801aef:	8a 00                	mov    (%eax),%al
  801af1:	84 c0                	test   %al,%al
  801af3:	74 8b                	je     801a80 <strsplit+0x23>
  801af5:	8b 45 08             	mov    0x8(%ebp),%eax
  801af8:	8a 00                	mov    (%eax),%al
  801afa:	0f be c0             	movsbl %al,%eax
  801afd:	50                   	push   %eax
  801afe:	ff 75 0c             	pushl  0xc(%ebp)
  801b01:	e8 b5 fa ff ff       	call   8015bb <strchr>
  801b06:	83 c4 08             	add    $0x8,%esp
  801b09:	85 c0                	test   %eax,%eax
  801b0b:	74 dc                	je     801ae9 <strsplit+0x8c>
			string++;
	}
  801b0d:	e9 6e ff ff ff       	jmp    801a80 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801b12:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801b13:	8b 45 14             	mov    0x14(%ebp),%eax
  801b16:	8b 00                	mov    (%eax),%eax
  801b18:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b1f:	8b 45 10             	mov    0x10(%ebp),%eax
  801b22:	01 d0                	add    %edx,%eax
  801b24:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b2a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b2f:	c9                   	leave  
  801b30:	c3                   	ret    

00801b31 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801b31:	55                   	push   %ebp
  801b32:	89 e5                	mov    %esp,%ebp
  801b34:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801b37:	83 ec 04             	sub    $0x4,%esp
  801b3a:	68 64 2c 80 00       	push   $0x802c64
  801b3f:	6a 15                	push   $0x15
  801b41:	68 89 2c 80 00       	push   $0x802c89
  801b46:	e8 9f ed ff ff       	call   8008ea <_panic>

00801b4b <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801b4b:	55                   	push   %ebp
  801b4c:	89 e5                	mov    %esp,%ebp
  801b4e:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801b51:	83 ec 04             	sub    $0x4,%esp
  801b54:	68 98 2c 80 00       	push   $0x802c98
  801b59:	6a 2e                	push   $0x2e
  801b5b:	68 89 2c 80 00       	push   $0x802c89
  801b60:	e8 85 ed ff ff       	call   8008ea <_panic>

00801b65 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801b65:	55                   	push   %ebp
  801b66:	89 e5                	mov    %esp,%ebp
  801b68:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b6b:	83 ec 04             	sub    $0x4,%esp
  801b6e:	68 bc 2c 80 00       	push   $0x802cbc
  801b73:	6a 4c                	push   $0x4c
  801b75:	68 89 2c 80 00       	push   $0x802c89
  801b7a:	e8 6b ed ff ff       	call   8008ea <_panic>

00801b7f <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801b7f:	55                   	push   %ebp
  801b80:	89 e5                	mov    %esp,%ebp
  801b82:	83 ec 18             	sub    $0x18,%esp
  801b85:	8b 45 10             	mov    0x10(%ebp),%eax
  801b88:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801b8b:	83 ec 04             	sub    $0x4,%esp
  801b8e:	68 bc 2c 80 00       	push   $0x802cbc
  801b93:	6a 57                	push   $0x57
  801b95:	68 89 2c 80 00       	push   $0x802c89
  801b9a:	e8 4b ed ff ff       	call   8008ea <_panic>

00801b9f <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801b9f:	55                   	push   %ebp
  801ba0:	89 e5                	mov    %esp,%ebp
  801ba2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ba5:	83 ec 04             	sub    $0x4,%esp
  801ba8:	68 bc 2c 80 00       	push   $0x802cbc
  801bad:	6a 5d                	push   $0x5d
  801baf:	68 89 2c 80 00       	push   $0x802c89
  801bb4:	e8 31 ed ff ff       	call   8008ea <_panic>

00801bb9 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801bb9:	55                   	push   %ebp
  801bba:	89 e5                	mov    %esp,%ebp
  801bbc:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bbf:	83 ec 04             	sub    $0x4,%esp
  801bc2:	68 bc 2c 80 00       	push   $0x802cbc
  801bc7:	6a 63                	push   $0x63
  801bc9:	68 89 2c 80 00       	push   $0x802c89
  801bce:	e8 17 ed ff ff       	call   8008ea <_panic>

00801bd3 <expand>:
}

void expand(uint32 newSize)
{
  801bd3:	55                   	push   %ebp
  801bd4:	89 e5                	mov    %esp,%ebp
  801bd6:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bd9:	83 ec 04             	sub    $0x4,%esp
  801bdc:	68 bc 2c 80 00       	push   $0x802cbc
  801be1:	6a 68                	push   $0x68
  801be3:	68 89 2c 80 00       	push   $0x802c89
  801be8:	e8 fd ec ff ff       	call   8008ea <_panic>

00801bed <shrink>:
}
void shrink(uint32 newSize)
{
  801bed:	55                   	push   %ebp
  801bee:	89 e5                	mov    %esp,%ebp
  801bf0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bf3:	83 ec 04             	sub    $0x4,%esp
  801bf6:	68 bc 2c 80 00       	push   $0x802cbc
  801bfb:	6a 6c                	push   $0x6c
  801bfd:	68 89 2c 80 00       	push   $0x802c89
  801c02:	e8 e3 ec ff ff       	call   8008ea <_panic>

00801c07 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801c07:	55                   	push   %ebp
  801c08:	89 e5                	mov    %esp,%ebp
  801c0a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c0d:	83 ec 04             	sub    $0x4,%esp
  801c10:	68 bc 2c 80 00       	push   $0x802cbc
  801c15:	6a 71                	push   $0x71
  801c17:	68 89 2c 80 00       	push   $0x802c89
  801c1c:	e8 c9 ec ff ff       	call   8008ea <_panic>

00801c21 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c21:	55                   	push   %ebp
  801c22:	89 e5                	mov    %esp,%ebp
  801c24:	57                   	push   %edi
  801c25:	56                   	push   %esi
  801c26:	53                   	push   %ebx
  801c27:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c30:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c33:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c36:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c39:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c3c:	cd 30                	int    $0x30
  801c3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c41:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c44:	83 c4 10             	add    $0x10,%esp
  801c47:	5b                   	pop    %ebx
  801c48:	5e                   	pop    %esi
  801c49:	5f                   	pop    %edi
  801c4a:	5d                   	pop    %ebp
  801c4b:	c3                   	ret    

00801c4c <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801c4c:	55                   	push   %ebp
  801c4d:	89 e5                	mov    %esp,%ebp
  801c4f:	83 ec 04             	sub    $0x4,%esp
  801c52:	8b 45 10             	mov    0x10(%ebp),%eax
  801c55:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c58:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5f:	6a 00                	push   $0x0
  801c61:	6a 00                	push   $0x0
  801c63:	52                   	push   %edx
  801c64:	ff 75 0c             	pushl  0xc(%ebp)
  801c67:	50                   	push   %eax
  801c68:	6a 00                	push   $0x0
  801c6a:	e8 b2 ff ff ff       	call   801c21 <syscall>
  801c6f:	83 c4 18             	add    $0x18,%esp
}
  801c72:	90                   	nop
  801c73:	c9                   	leave  
  801c74:	c3                   	ret    

00801c75 <sys_cgetc>:

int
sys_cgetc(void)
{
  801c75:	55                   	push   %ebp
  801c76:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 00                	push   $0x0
  801c80:	6a 00                	push   $0x0
  801c82:	6a 01                	push   $0x1
  801c84:	e8 98 ff ff ff       	call   801c21 <syscall>
  801c89:	83 c4 18             	add    $0x18,%esp
}
  801c8c:	c9                   	leave  
  801c8d:	c3                   	ret    

00801c8e <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c8e:	55                   	push   %ebp
  801c8f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801c91:	8b 45 08             	mov    0x8(%ebp),%eax
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	6a 00                	push   $0x0
  801c9a:	6a 00                	push   $0x0
  801c9c:	50                   	push   %eax
  801c9d:	6a 05                	push   $0x5
  801c9f:	e8 7d ff ff ff       	call   801c21 <syscall>
  801ca4:	83 c4 18             	add    $0x18,%esp
}
  801ca7:	c9                   	leave  
  801ca8:	c3                   	ret    

00801ca9 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801ca9:	55                   	push   %ebp
  801caa:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801cac:	6a 00                	push   $0x0
  801cae:	6a 00                	push   $0x0
  801cb0:	6a 00                	push   $0x0
  801cb2:	6a 00                	push   $0x0
  801cb4:	6a 00                	push   $0x0
  801cb6:	6a 02                	push   $0x2
  801cb8:	e8 64 ff ff ff       	call   801c21 <syscall>
  801cbd:	83 c4 18             	add    $0x18,%esp
}
  801cc0:	c9                   	leave  
  801cc1:	c3                   	ret    

00801cc2 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801cc2:	55                   	push   %ebp
  801cc3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801cc5:	6a 00                	push   $0x0
  801cc7:	6a 00                	push   $0x0
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 03                	push   $0x3
  801cd1:	e8 4b ff ff ff       	call   801c21 <syscall>
  801cd6:	83 c4 18             	add    $0x18,%esp
}
  801cd9:	c9                   	leave  
  801cda:	c3                   	ret    

00801cdb <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801cdb:	55                   	push   %ebp
  801cdc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801cde:	6a 00                	push   $0x0
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 04                	push   $0x4
  801cea:	e8 32 ff ff ff       	call   801c21 <syscall>
  801cef:	83 c4 18             	add    $0x18,%esp
}
  801cf2:	c9                   	leave  
  801cf3:	c3                   	ret    

00801cf4 <sys_env_exit>:


void sys_env_exit(void)
{
  801cf4:	55                   	push   %ebp
  801cf5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801cf7:	6a 00                	push   $0x0
  801cf9:	6a 00                	push   $0x0
  801cfb:	6a 00                	push   $0x0
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 00                	push   $0x0
  801d01:	6a 06                	push   $0x6
  801d03:	e8 19 ff ff ff       	call   801c21 <syscall>
  801d08:	83 c4 18             	add    $0x18,%esp
}
  801d0b:	90                   	nop
  801d0c:	c9                   	leave  
  801d0d:	c3                   	ret    

00801d0e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801d0e:	55                   	push   %ebp
  801d0f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d11:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d14:	8b 45 08             	mov    0x8(%ebp),%eax
  801d17:	6a 00                	push   $0x0
  801d19:	6a 00                	push   $0x0
  801d1b:	6a 00                	push   $0x0
  801d1d:	52                   	push   %edx
  801d1e:	50                   	push   %eax
  801d1f:	6a 07                	push   $0x7
  801d21:	e8 fb fe ff ff       	call   801c21 <syscall>
  801d26:	83 c4 18             	add    $0x18,%esp
}
  801d29:	c9                   	leave  
  801d2a:	c3                   	ret    

00801d2b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d2b:	55                   	push   %ebp
  801d2c:	89 e5                	mov    %esp,%ebp
  801d2e:	56                   	push   %esi
  801d2f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d30:	8b 75 18             	mov    0x18(%ebp),%esi
  801d33:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d36:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d39:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d3f:	56                   	push   %esi
  801d40:	53                   	push   %ebx
  801d41:	51                   	push   %ecx
  801d42:	52                   	push   %edx
  801d43:	50                   	push   %eax
  801d44:	6a 08                	push   $0x8
  801d46:	e8 d6 fe ff ff       	call   801c21 <syscall>
  801d4b:	83 c4 18             	add    $0x18,%esp
}
  801d4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d51:	5b                   	pop    %ebx
  801d52:	5e                   	pop    %esi
  801d53:	5d                   	pop    %ebp
  801d54:	c3                   	ret    

00801d55 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801d55:	55                   	push   %ebp
  801d56:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d58:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5e:	6a 00                	push   $0x0
  801d60:	6a 00                	push   $0x0
  801d62:	6a 00                	push   $0x0
  801d64:	52                   	push   %edx
  801d65:	50                   	push   %eax
  801d66:	6a 09                	push   $0x9
  801d68:	e8 b4 fe ff ff       	call   801c21 <syscall>
  801d6d:	83 c4 18             	add    $0x18,%esp
}
  801d70:	c9                   	leave  
  801d71:	c3                   	ret    

00801d72 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d72:	55                   	push   %ebp
  801d73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	6a 00                	push   $0x0
  801d7b:	ff 75 0c             	pushl  0xc(%ebp)
  801d7e:	ff 75 08             	pushl  0x8(%ebp)
  801d81:	6a 0a                	push   $0xa
  801d83:	e8 99 fe ff ff       	call   801c21 <syscall>
  801d88:	83 c4 18             	add    $0x18,%esp
}
  801d8b:	c9                   	leave  
  801d8c:	c3                   	ret    

00801d8d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d8d:	55                   	push   %ebp
  801d8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	6a 00                	push   $0x0
  801d96:	6a 00                	push   $0x0
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 0b                	push   $0xb
  801d9c:	e8 80 fe ff ff       	call   801c21 <syscall>
  801da1:	83 c4 18             	add    $0x18,%esp
}
  801da4:	c9                   	leave  
  801da5:	c3                   	ret    

00801da6 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801da6:	55                   	push   %ebp
  801da7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801da9:	6a 00                	push   $0x0
  801dab:	6a 00                	push   $0x0
  801dad:	6a 00                	push   $0x0
  801daf:	6a 00                	push   $0x0
  801db1:	6a 00                	push   $0x0
  801db3:	6a 0c                	push   $0xc
  801db5:	e8 67 fe ff ff       	call   801c21 <syscall>
  801dba:	83 c4 18             	add    $0x18,%esp
}
  801dbd:	c9                   	leave  
  801dbe:	c3                   	ret    

00801dbf <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801dbf:	55                   	push   %ebp
  801dc0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 00                	push   $0x0
  801dc6:	6a 00                	push   $0x0
  801dc8:	6a 00                	push   $0x0
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 0d                	push   $0xd
  801dce:	e8 4e fe ff ff       	call   801c21 <syscall>
  801dd3:	83 c4 18             	add    $0x18,%esp
}
  801dd6:	c9                   	leave  
  801dd7:	c3                   	ret    

00801dd8 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801dd8:	55                   	push   %ebp
  801dd9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 00                	push   $0x0
  801de1:	ff 75 0c             	pushl  0xc(%ebp)
  801de4:	ff 75 08             	pushl  0x8(%ebp)
  801de7:	6a 11                	push   $0x11
  801de9:	e8 33 fe ff ff       	call   801c21 <syscall>
  801dee:	83 c4 18             	add    $0x18,%esp
	return;
  801df1:	90                   	nop
}
  801df2:	c9                   	leave  
  801df3:	c3                   	ret    

00801df4 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801df4:	55                   	push   %ebp
  801df5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	ff 75 0c             	pushl  0xc(%ebp)
  801e00:	ff 75 08             	pushl  0x8(%ebp)
  801e03:	6a 12                	push   $0x12
  801e05:	e8 17 fe ff ff       	call   801c21 <syscall>
  801e0a:	83 c4 18             	add    $0x18,%esp
	return ;
  801e0d:	90                   	nop
}
  801e0e:	c9                   	leave  
  801e0f:	c3                   	ret    

00801e10 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e10:	55                   	push   %ebp
  801e11:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e13:	6a 00                	push   $0x0
  801e15:	6a 00                	push   $0x0
  801e17:	6a 00                	push   $0x0
  801e19:	6a 00                	push   $0x0
  801e1b:	6a 00                	push   $0x0
  801e1d:	6a 0e                	push   $0xe
  801e1f:	e8 fd fd ff ff       	call   801c21 <syscall>
  801e24:	83 c4 18             	add    $0x18,%esp
}
  801e27:	c9                   	leave  
  801e28:	c3                   	ret    

00801e29 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e29:	55                   	push   %ebp
  801e2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e2c:	6a 00                	push   $0x0
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	ff 75 08             	pushl  0x8(%ebp)
  801e37:	6a 0f                	push   $0xf
  801e39:	e8 e3 fd ff ff       	call   801c21 <syscall>
  801e3e:	83 c4 18             	add    $0x18,%esp
}
  801e41:	c9                   	leave  
  801e42:	c3                   	ret    

00801e43 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e43:	55                   	push   %ebp
  801e44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e46:	6a 00                	push   $0x0
  801e48:	6a 00                	push   $0x0
  801e4a:	6a 00                	push   $0x0
  801e4c:	6a 00                	push   $0x0
  801e4e:	6a 00                	push   $0x0
  801e50:	6a 10                	push   $0x10
  801e52:	e8 ca fd ff ff       	call   801c21 <syscall>
  801e57:	83 c4 18             	add    $0x18,%esp
}
  801e5a:	90                   	nop
  801e5b:	c9                   	leave  
  801e5c:	c3                   	ret    

00801e5d <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801e5d:	55                   	push   %ebp
  801e5e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801e60:	6a 00                	push   $0x0
  801e62:	6a 00                	push   $0x0
  801e64:	6a 00                	push   $0x0
  801e66:	6a 00                	push   $0x0
  801e68:	6a 00                	push   $0x0
  801e6a:	6a 14                	push   $0x14
  801e6c:	e8 b0 fd ff ff       	call   801c21 <syscall>
  801e71:	83 c4 18             	add    $0x18,%esp
}
  801e74:	90                   	nop
  801e75:	c9                   	leave  
  801e76:	c3                   	ret    

00801e77 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e77:	55                   	push   %ebp
  801e78:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 00                	push   $0x0
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 00                	push   $0x0
  801e82:	6a 00                	push   $0x0
  801e84:	6a 15                	push   $0x15
  801e86:	e8 96 fd ff ff       	call   801c21 <syscall>
  801e8b:	83 c4 18             	add    $0x18,%esp
}
  801e8e:	90                   	nop
  801e8f:	c9                   	leave  
  801e90:	c3                   	ret    

00801e91 <sys_cputc>:


void
sys_cputc(const char c)
{
  801e91:	55                   	push   %ebp
  801e92:	89 e5                	mov    %esp,%ebp
  801e94:	83 ec 04             	sub    $0x4,%esp
  801e97:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e9d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 00                	push   $0x0
  801ea5:	6a 00                	push   $0x0
  801ea7:	6a 00                	push   $0x0
  801ea9:	50                   	push   %eax
  801eaa:	6a 16                	push   $0x16
  801eac:	e8 70 fd ff ff       	call   801c21 <syscall>
  801eb1:	83 c4 18             	add    $0x18,%esp
}
  801eb4:	90                   	nop
  801eb5:	c9                   	leave  
  801eb6:	c3                   	ret    

00801eb7 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801eb7:	55                   	push   %ebp
  801eb8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 00                	push   $0x0
  801ec4:	6a 17                	push   $0x17
  801ec6:	e8 56 fd ff ff       	call   801c21 <syscall>
  801ecb:	83 c4 18             	add    $0x18,%esp
}
  801ece:	90                   	nop
  801ecf:	c9                   	leave  
  801ed0:	c3                   	ret    

00801ed1 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801ed1:	55                   	push   %ebp
  801ed2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ed4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed7:	6a 00                	push   $0x0
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	ff 75 0c             	pushl  0xc(%ebp)
  801ee0:	50                   	push   %eax
  801ee1:	6a 18                	push   $0x18
  801ee3:	e8 39 fd ff ff       	call   801c21 <syscall>
  801ee8:	83 c4 18             	add    $0x18,%esp
}
  801eeb:	c9                   	leave  
  801eec:	c3                   	ret    

00801eed <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801eed:	55                   	push   %ebp
  801eee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ef0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ef3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 00                	push   $0x0
  801efa:	6a 00                	push   $0x0
  801efc:	52                   	push   %edx
  801efd:	50                   	push   %eax
  801efe:	6a 1b                	push   $0x1b
  801f00:	e8 1c fd ff ff       	call   801c21 <syscall>
  801f05:	83 c4 18             	add    $0x18,%esp
}
  801f08:	c9                   	leave  
  801f09:	c3                   	ret    

00801f0a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f0a:	55                   	push   %ebp
  801f0b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f0d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f10:	8b 45 08             	mov    0x8(%ebp),%eax
  801f13:	6a 00                	push   $0x0
  801f15:	6a 00                	push   $0x0
  801f17:	6a 00                	push   $0x0
  801f19:	52                   	push   %edx
  801f1a:	50                   	push   %eax
  801f1b:	6a 19                	push   $0x19
  801f1d:	e8 ff fc ff ff       	call   801c21 <syscall>
  801f22:	83 c4 18             	add    $0x18,%esp
}
  801f25:	90                   	nop
  801f26:	c9                   	leave  
  801f27:	c3                   	ret    

00801f28 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f28:	55                   	push   %ebp
  801f29:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f2b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f31:	6a 00                	push   $0x0
  801f33:	6a 00                	push   $0x0
  801f35:	6a 00                	push   $0x0
  801f37:	52                   	push   %edx
  801f38:	50                   	push   %eax
  801f39:	6a 1a                	push   $0x1a
  801f3b:	e8 e1 fc ff ff       	call   801c21 <syscall>
  801f40:	83 c4 18             	add    $0x18,%esp
}
  801f43:	90                   	nop
  801f44:	c9                   	leave  
  801f45:	c3                   	ret    

00801f46 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801f46:	55                   	push   %ebp
  801f47:	89 e5                	mov    %esp,%ebp
  801f49:	83 ec 04             	sub    $0x4,%esp
  801f4c:	8b 45 10             	mov    0x10(%ebp),%eax
  801f4f:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801f52:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f55:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f59:	8b 45 08             	mov    0x8(%ebp),%eax
  801f5c:	6a 00                	push   $0x0
  801f5e:	51                   	push   %ecx
  801f5f:	52                   	push   %edx
  801f60:	ff 75 0c             	pushl  0xc(%ebp)
  801f63:	50                   	push   %eax
  801f64:	6a 1c                	push   $0x1c
  801f66:	e8 b6 fc ff ff       	call   801c21 <syscall>
  801f6b:	83 c4 18             	add    $0x18,%esp
}
  801f6e:	c9                   	leave  
  801f6f:	c3                   	ret    

00801f70 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801f70:	55                   	push   %ebp
  801f71:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f73:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f76:	8b 45 08             	mov    0x8(%ebp),%eax
  801f79:	6a 00                	push   $0x0
  801f7b:	6a 00                	push   $0x0
  801f7d:	6a 00                	push   $0x0
  801f7f:	52                   	push   %edx
  801f80:	50                   	push   %eax
  801f81:	6a 1d                	push   $0x1d
  801f83:	e8 99 fc ff ff       	call   801c21 <syscall>
  801f88:	83 c4 18             	add    $0x18,%esp
}
  801f8b:	c9                   	leave  
  801f8c:	c3                   	ret    

00801f8d <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f8d:	55                   	push   %ebp
  801f8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801f90:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f93:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f96:	8b 45 08             	mov    0x8(%ebp),%eax
  801f99:	6a 00                	push   $0x0
  801f9b:	6a 00                	push   $0x0
  801f9d:	51                   	push   %ecx
  801f9e:	52                   	push   %edx
  801f9f:	50                   	push   %eax
  801fa0:	6a 1e                	push   $0x1e
  801fa2:	e8 7a fc ff ff       	call   801c21 <syscall>
  801fa7:	83 c4 18             	add    $0x18,%esp
}
  801faa:	c9                   	leave  
  801fab:	c3                   	ret    

00801fac <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801fac:	55                   	push   %ebp
  801fad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801faf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fb2:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb5:	6a 00                	push   $0x0
  801fb7:	6a 00                	push   $0x0
  801fb9:	6a 00                	push   $0x0
  801fbb:	52                   	push   %edx
  801fbc:	50                   	push   %eax
  801fbd:	6a 1f                	push   $0x1f
  801fbf:	e8 5d fc ff ff       	call   801c21 <syscall>
  801fc4:	83 c4 18             	add    $0x18,%esp
}
  801fc7:	c9                   	leave  
  801fc8:	c3                   	ret    

00801fc9 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801fc9:	55                   	push   %ebp
  801fca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801fcc:	6a 00                	push   $0x0
  801fce:	6a 00                	push   $0x0
  801fd0:	6a 00                	push   $0x0
  801fd2:	6a 00                	push   $0x0
  801fd4:	6a 00                	push   $0x0
  801fd6:	6a 20                	push   $0x20
  801fd8:	e8 44 fc ff ff       	call   801c21 <syscall>
  801fdd:	83 c4 18             	add    $0x18,%esp
}
  801fe0:	c9                   	leave  
  801fe1:	c3                   	ret    

00801fe2 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801fe2:	55                   	push   %ebp
  801fe3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801fe5:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe8:	6a 00                	push   $0x0
  801fea:	ff 75 14             	pushl  0x14(%ebp)
  801fed:	ff 75 10             	pushl  0x10(%ebp)
  801ff0:	ff 75 0c             	pushl  0xc(%ebp)
  801ff3:	50                   	push   %eax
  801ff4:	6a 21                	push   $0x21
  801ff6:	e8 26 fc ff ff       	call   801c21 <syscall>
  801ffb:	83 c4 18             	add    $0x18,%esp
}
  801ffe:	c9                   	leave  
  801fff:	c3                   	ret    

00802000 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  802000:	55                   	push   %ebp
  802001:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802003:	8b 45 08             	mov    0x8(%ebp),%eax
  802006:	6a 00                	push   $0x0
  802008:	6a 00                	push   $0x0
  80200a:	6a 00                	push   $0x0
  80200c:	6a 00                	push   $0x0
  80200e:	50                   	push   %eax
  80200f:	6a 22                	push   $0x22
  802011:	e8 0b fc ff ff       	call   801c21 <syscall>
  802016:	83 c4 18             	add    $0x18,%esp
}
  802019:	90                   	nop
  80201a:	c9                   	leave  
  80201b:	c3                   	ret    

0080201c <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80201c:	55                   	push   %ebp
  80201d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80201f:	8b 45 08             	mov    0x8(%ebp),%eax
  802022:	6a 00                	push   $0x0
  802024:	6a 00                	push   $0x0
  802026:	6a 00                	push   $0x0
  802028:	6a 00                	push   $0x0
  80202a:	50                   	push   %eax
  80202b:	6a 23                	push   $0x23
  80202d:	e8 ef fb ff ff       	call   801c21 <syscall>
  802032:	83 c4 18             	add    $0x18,%esp
}
  802035:	90                   	nop
  802036:	c9                   	leave  
  802037:	c3                   	ret    

00802038 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802038:	55                   	push   %ebp
  802039:	89 e5                	mov    %esp,%ebp
  80203b:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80203e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802041:	8d 50 04             	lea    0x4(%eax),%edx
  802044:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802047:	6a 00                	push   $0x0
  802049:	6a 00                	push   $0x0
  80204b:	6a 00                	push   $0x0
  80204d:	52                   	push   %edx
  80204e:	50                   	push   %eax
  80204f:	6a 24                	push   $0x24
  802051:	e8 cb fb ff ff       	call   801c21 <syscall>
  802056:	83 c4 18             	add    $0x18,%esp
	return result;
  802059:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80205c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80205f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802062:	89 01                	mov    %eax,(%ecx)
  802064:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802067:	8b 45 08             	mov    0x8(%ebp),%eax
  80206a:	c9                   	leave  
  80206b:	c2 04 00             	ret    $0x4

0080206e <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80206e:	55                   	push   %ebp
  80206f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802071:	6a 00                	push   $0x0
  802073:	6a 00                	push   $0x0
  802075:	ff 75 10             	pushl  0x10(%ebp)
  802078:	ff 75 0c             	pushl  0xc(%ebp)
  80207b:	ff 75 08             	pushl  0x8(%ebp)
  80207e:	6a 13                	push   $0x13
  802080:	e8 9c fb ff ff       	call   801c21 <syscall>
  802085:	83 c4 18             	add    $0x18,%esp
	return ;
  802088:	90                   	nop
}
  802089:	c9                   	leave  
  80208a:	c3                   	ret    

0080208b <sys_rcr2>:
uint32 sys_rcr2()
{
  80208b:	55                   	push   %ebp
  80208c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80208e:	6a 00                	push   $0x0
  802090:	6a 00                	push   $0x0
  802092:	6a 00                	push   $0x0
  802094:	6a 00                	push   $0x0
  802096:	6a 00                	push   $0x0
  802098:	6a 25                	push   $0x25
  80209a:	e8 82 fb ff ff       	call   801c21 <syscall>
  80209f:	83 c4 18             	add    $0x18,%esp
}
  8020a2:	c9                   	leave  
  8020a3:	c3                   	ret    

008020a4 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8020a4:	55                   	push   %ebp
  8020a5:	89 e5                	mov    %esp,%ebp
  8020a7:	83 ec 04             	sub    $0x4,%esp
  8020aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ad:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8020b0:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8020b4:	6a 00                	push   $0x0
  8020b6:	6a 00                	push   $0x0
  8020b8:	6a 00                	push   $0x0
  8020ba:	6a 00                	push   $0x0
  8020bc:	50                   	push   %eax
  8020bd:	6a 26                	push   $0x26
  8020bf:	e8 5d fb ff ff       	call   801c21 <syscall>
  8020c4:	83 c4 18             	add    $0x18,%esp
	return ;
  8020c7:	90                   	nop
}
  8020c8:	c9                   	leave  
  8020c9:	c3                   	ret    

008020ca <rsttst>:
void rsttst()
{
  8020ca:	55                   	push   %ebp
  8020cb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8020cd:	6a 00                	push   $0x0
  8020cf:	6a 00                	push   $0x0
  8020d1:	6a 00                	push   $0x0
  8020d3:	6a 00                	push   $0x0
  8020d5:	6a 00                	push   $0x0
  8020d7:	6a 28                	push   $0x28
  8020d9:	e8 43 fb ff ff       	call   801c21 <syscall>
  8020de:	83 c4 18             	add    $0x18,%esp
	return ;
  8020e1:	90                   	nop
}
  8020e2:	c9                   	leave  
  8020e3:	c3                   	ret    

008020e4 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8020e4:	55                   	push   %ebp
  8020e5:	89 e5                	mov    %esp,%ebp
  8020e7:	83 ec 04             	sub    $0x4,%esp
  8020ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8020ed:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8020f0:	8b 55 18             	mov    0x18(%ebp),%edx
  8020f3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8020f7:	52                   	push   %edx
  8020f8:	50                   	push   %eax
  8020f9:	ff 75 10             	pushl  0x10(%ebp)
  8020fc:	ff 75 0c             	pushl  0xc(%ebp)
  8020ff:	ff 75 08             	pushl  0x8(%ebp)
  802102:	6a 27                	push   $0x27
  802104:	e8 18 fb ff ff       	call   801c21 <syscall>
  802109:	83 c4 18             	add    $0x18,%esp
	return ;
  80210c:	90                   	nop
}
  80210d:	c9                   	leave  
  80210e:	c3                   	ret    

0080210f <chktst>:
void chktst(uint32 n)
{
  80210f:	55                   	push   %ebp
  802110:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802112:	6a 00                	push   $0x0
  802114:	6a 00                	push   $0x0
  802116:	6a 00                	push   $0x0
  802118:	6a 00                	push   $0x0
  80211a:	ff 75 08             	pushl  0x8(%ebp)
  80211d:	6a 29                	push   $0x29
  80211f:	e8 fd fa ff ff       	call   801c21 <syscall>
  802124:	83 c4 18             	add    $0x18,%esp
	return ;
  802127:	90                   	nop
}
  802128:	c9                   	leave  
  802129:	c3                   	ret    

0080212a <inctst>:

void inctst()
{
  80212a:	55                   	push   %ebp
  80212b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80212d:	6a 00                	push   $0x0
  80212f:	6a 00                	push   $0x0
  802131:	6a 00                	push   $0x0
  802133:	6a 00                	push   $0x0
  802135:	6a 00                	push   $0x0
  802137:	6a 2a                	push   $0x2a
  802139:	e8 e3 fa ff ff       	call   801c21 <syscall>
  80213e:	83 c4 18             	add    $0x18,%esp
	return ;
  802141:	90                   	nop
}
  802142:	c9                   	leave  
  802143:	c3                   	ret    

00802144 <gettst>:
uint32 gettst()
{
  802144:	55                   	push   %ebp
  802145:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802147:	6a 00                	push   $0x0
  802149:	6a 00                	push   $0x0
  80214b:	6a 00                	push   $0x0
  80214d:	6a 00                	push   $0x0
  80214f:	6a 00                	push   $0x0
  802151:	6a 2b                	push   $0x2b
  802153:	e8 c9 fa ff ff       	call   801c21 <syscall>
  802158:	83 c4 18             	add    $0x18,%esp
}
  80215b:	c9                   	leave  
  80215c:	c3                   	ret    

0080215d <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80215d:	55                   	push   %ebp
  80215e:	89 e5                	mov    %esp,%ebp
  802160:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802163:	6a 00                	push   $0x0
  802165:	6a 00                	push   $0x0
  802167:	6a 00                	push   $0x0
  802169:	6a 00                	push   $0x0
  80216b:	6a 00                	push   $0x0
  80216d:	6a 2c                	push   $0x2c
  80216f:	e8 ad fa ff ff       	call   801c21 <syscall>
  802174:	83 c4 18             	add    $0x18,%esp
  802177:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80217a:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80217e:	75 07                	jne    802187 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802180:	b8 01 00 00 00       	mov    $0x1,%eax
  802185:	eb 05                	jmp    80218c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802187:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80218c:	c9                   	leave  
  80218d:	c3                   	ret    

0080218e <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80218e:	55                   	push   %ebp
  80218f:	89 e5                	mov    %esp,%ebp
  802191:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802194:	6a 00                	push   $0x0
  802196:	6a 00                	push   $0x0
  802198:	6a 00                	push   $0x0
  80219a:	6a 00                	push   $0x0
  80219c:	6a 00                	push   $0x0
  80219e:	6a 2c                	push   $0x2c
  8021a0:	e8 7c fa ff ff       	call   801c21 <syscall>
  8021a5:	83 c4 18             	add    $0x18,%esp
  8021a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8021ab:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8021af:	75 07                	jne    8021b8 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8021b1:	b8 01 00 00 00       	mov    $0x1,%eax
  8021b6:	eb 05                	jmp    8021bd <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8021b8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021bd:	c9                   	leave  
  8021be:	c3                   	ret    

008021bf <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8021bf:	55                   	push   %ebp
  8021c0:	89 e5                	mov    %esp,%ebp
  8021c2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021c5:	6a 00                	push   $0x0
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 00                	push   $0x0
  8021cb:	6a 00                	push   $0x0
  8021cd:	6a 00                	push   $0x0
  8021cf:	6a 2c                	push   $0x2c
  8021d1:	e8 4b fa ff ff       	call   801c21 <syscall>
  8021d6:	83 c4 18             	add    $0x18,%esp
  8021d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8021dc:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8021e0:	75 07                	jne    8021e9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8021e2:	b8 01 00 00 00       	mov    $0x1,%eax
  8021e7:	eb 05                	jmp    8021ee <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8021e9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021ee:	c9                   	leave  
  8021ef:	c3                   	ret    

008021f0 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
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
  802202:	e8 1a fa ff ff       	call   801c21 <syscall>
  802207:	83 c4 18             	add    $0x18,%esp
  80220a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80220d:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802211:	75 07                	jne    80221a <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802213:	b8 01 00 00 00       	mov    $0x1,%eax
  802218:	eb 05                	jmp    80221f <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80221a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80221f:	c9                   	leave  
  802220:	c3                   	ret    

00802221 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802221:	55                   	push   %ebp
  802222:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802224:	6a 00                	push   $0x0
  802226:	6a 00                	push   $0x0
  802228:	6a 00                	push   $0x0
  80222a:	6a 00                	push   $0x0
  80222c:	ff 75 08             	pushl  0x8(%ebp)
  80222f:	6a 2d                	push   $0x2d
  802231:	e8 eb f9 ff ff       	call   801c21 <syscall>
  802236:	83 c4 18             	add    $0x18,%esp
	return ;
  802239:	90                   	nop
}
  80223a:	c9                   	leave  
  80223b:	c3                   	ret    

0080223c <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80223c:	55                   	push   %ebp
  80223d:	89 e5                	mov    %esp,%ebp
  80223f:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802240:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802243:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802246:	8b 55 0c             	mov    0xc(%ebp),%edx
  802249:	8b 45 08             	mov    0x8(%ebp),%eax
  80224c:	6a 00                	push   $0x0
  80224e:	53                   	push   %ebx
  80224f:	51                   	push   %ecx
  802250:	52                   	push   %edx
  802251:	50                   	push   %eax
  802252:	6a 2e                	push   $0x2e
  802254:	e8 c8 f9 ff ff       	call   801c21 <syscall>
  802259:	83 c4 18             	add    $0x18,%esp
}
  80225c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80225f:	c9                   	leave  
  802260:	c3                   	ret    

00802261 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802261:	55                   	push   %ebp
  802262:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802264:	8b 55 0c             	mov    0xc(%ebp),%edx
  802267:	8b 45 08             	mov    0x8(%ebp),%eax
  80226a:	6a 00                	push   $0x0
  80226c:	6a 00                	push   $0x0
  80226e:	6a 00                	push   $0x0
  802270:	52                   	push   %edx
  802271:	50                   	push   %eax
  802272:	6a 2f                	push   $0x2f
  802274:	e8 a8 f9 ff ff       	call   801c21 <syscall>
  802279:	83 c4 18             	add    $0x18,%esp
}
  80227c:	c9                   	leave  
  80227d:	c3                   	ret    

0080227e <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  80227e:	55                   	push   %ebp
  80227f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  802281:	6a 00                	push   $0x0
  802283:	6a 00                	push   $0x0
  802285:	6a 00                	push   $0x0
  802287:	ff 75 0c             	pushl  0xc(%ebp)
  80228a:	ff 75 08             	pushl  0x8(%ebp)
  80228d:	6a 30                	push   $0x30
  80228f:	e8 8d f9 ff ff       	call   801c21 <syscall>
  802294:	83 c4 18             	add    $0x18,%esp
	return ;
  802297:	90                   	nop
}
  802298:	c9                   	leave  
  802299:	c3                   	ret    
  80229a:	66 90                	xchg   %ax,%ax

0080229c <__udivdi3>:
  80229c:	55                   	push   %ebp
  80229d:	57                   	push   %edi
  80229e:	56                   	push   %esi
  80229f:	53                   	push   %ebx
  8022a0:	83 ec 1c             	sub    $0x1c,%esp
  8022a3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8022a7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8022ab:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022af:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8022b3:	89 ca                	mov    %ecx,%edx
  8022b5:	89 f8                	mov    %edi,%eax
  8022b7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8022bb:	85 f6                	test   %esi,%esi
  8022bd:	75 2d                	jne    8022ec <__udivdi3+0x50>
  8022bf:	39 cf                	cmp    %ecx,%edi
  8022c1:	77 65                	ja     802328 <__udivdi3+0x8c>
  8022c3:	89 fd                	mov    %edi,%ebp
  8022c5:	85 ff                	test   %edi,%edi
  8022c7:	75 0b                	jne    8022d4 <__udivdi3+0x38>
  8022c9:	b8 01 00 00 00       	mov    $0x1,%eax
  8022ce:	31 d2                	xor    %edx,%edx
  8022d0:	f7 f7                	div    %edi
  8022d2:	89 c5                	mov    %eax,%ebp
  8022d4:	31 d2                	xor    %edx,%edx
  8022d6:	89 c8                	mov    %ecx,%eax
  8022d8:	f7 f5                	div    %ebp
  8022da:	89 c1                	mov    %eax,%ecx
  8022dc:	89 d8                	mov    %ebx,%eax
  8022de:	f7 f5                	div    %ebp
  8022e0:	89 cf                	mov    %ecx,%edi
  8022e2:	89 fa                	mov    %edi,%edx
  8022e4:	83 c4 1c             	add    $0x1c,%esp
  8022e7:	5b                   	pop    %ebx
  8022e8:	5e                   	pop    %esi
  8022e9:	5f                   	pop    %edi
  8022ea:	5d                   	pop    %ebp
  8022eb:	c3                   	ret    
  8022ec:	39 ce                	cmp    %ecx,%esi
  8022ee:	77 28                	ja     802318 <__udivdi3+0x7c>
  8022f0:	0f bd fe             	bsr    %esi,%edi
  8022f3:	83 f7 1f             	xor    $0x1f,%edi
  8022f6:	75 40                	jne    802338 <__udivdi3+0x9c>
  8022f8:	39 ce                	cmp    %ecx,%esi
  8022fa:	72 0a                	jb     802306 <__udivdi3+0x6a>
  8022fc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802300:	0f 87 9e 00 00 00    	ja     8023a4 <__udivdi3+0x108>
  802306:	b8 01 00 00 00       	mov    $0x1,%eax
  80230b:	89 fa                	mov    %edi,%edx
  80230d:	83 c4 1c             	add    $0x1c,%esp
  802310:	5b                   	pop    %ebx
  802311:	5e                   	pop    %esi
  802312:	5f                   	pop    %edi
  802313:	5d                   	pop    %ebp
  802314:	c3                   	ret    
  802315:	8d 76 00             	lea    0x0(%esi),%esi
  802318:	31 ff                	xor    %edi,%edi
  80231a:	31 c0                	xor    %eax,%eax
  80231c:	89 fa                	mov    %edi,%edx
  80231e:	83 c4 1c             	add    $0x1c,%esp
  802321:	5b                   	pop    %ebx
  802322:	5e                   	pop    %esi
  802323:	5f                   	pop    %edi
  802324:	5d                   	pop    %ebp
  802325:	c3                   	ret    
  802326:	66 90                	xchg   %ax,%ax
  802328:	89 d8                	mov    %ebx,%eax
  80232a:	f7 f7                	div    %edi
  80232c:	31 ff                	xor    %edi,%edi
  80232e:	89 fa                	mov    %edi,%edx
  802330:	83 c4 1c             	add    $0x1c,%esp
  802333:	5b                   	pop    %ebx
  802334:	5e                   	pop    %esi
  802335:	5f                   	pop    %edi
  802336:	5d                   	pop    %ebp
  802337:	c3                   	ret    
  802338:	bd 20 00 00 00       	mov    $0x20,%ebp
  80233d:	89 eb                	mov    %ebp,%ebx
  80233f:	29 fb                	sub    %edi,%ebx
  802341:	89 f9                	mov    %edi,%ecx
  802343:	d3 e6                	shl    %cl,%esi
  802345:	89 c5                	mov    %eax,%ebp
  802347:	88 d9                	mov    %bl,%cl
  802349:	d3 ed                	shr    %cl,%ebp
  80234b:	89 e9                	mov    %ebp,%ecx
  80234d:	09 f1                	or     %esi,%ecx
  80234f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802353:	89 f9                	mov    %edi,%ecx
  802355:	d3 e0                	shl    %cl,%eax
  802357:	89 c5                	mov    %eax,%ebp
  802359:	89 d6                	mov    %edx,%esi
  80235b:	88 d9                	mov    %bl,%cl
  80235d:	d3 ee                	shr    %cl,%esi
  80235f:	89 f9                	mov    %edi,%ecx
  802361:	d3 e2                	shl    %cl,%edx
  802363:	8b 44 24 08          	mov    0x8(%esp),%eax
  802367:	88 d9                	mov    %bl,%cl
  802369:	d3 e8                	shr    %cl,%eax
  80236b:	09 c2                	or     %eax,%edx
  80236d:	89 d0                	mov    %edx,%eax
  80236f:	89 f2                	mov    %esi,%edx
  802371:	f7 74 24 0c          	divl   0xc(%esp)
  802375:	89 d6                	mov    %edx,%esi
  802377:	89 c3                	mov    %eax,%ebx
  802379:	f7 e5                	mul    %ebp
  80237b:	39 d6                	cmp    %edx,%esi
  80237d:	72 19                	jb     802398 <__udivdi3+0xfc>
  80237f:	74 0b                	je     80238c <__udivdi3+0xf0>
  802381:	89 d8                	mov    %ebx,%eax
  802383:	31 ff                	xor    %edi,%edi
  802385:	e9 58 ff ff ff       	jmp    8022e2 <__udivdi3+0x46>
  80238a:	66 90                	xchg   %ax,%ax
  80238c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802390:	89 f9                	mov    %edi,%ecx
  802392:	d3 e2                	shl    %cl,%edx
  802394:	39 c2                	cmp    %eax,%edx
  802396:	73 e9                	jae    802381 <__udivdi3+0xe5>
  802398:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80239b:	31 ff                	xor    %edi,%edi
  80239d:	e9 40 ff ff ff       	jmp    8022e2 <__udivdi3+0x46>
  8023a2:	66 90                	xchg   %ax,%ax
  8023a4:	31 c0                	xor    %eax,%eax
  8023a6:	e9 37 ff ff ff       	jmp    8022e2 <__udivdi3+0x46>
  8023ab:	90                   	nop

008023ac <__umoddi3>:
  8023ac:	55                   	push   %ebp
  8023ad:	57                   	push   %edi
  8023ae:	56                   	push   %esi
  8023af:	53                   	push   %ebx
  8023b0:	83 ec 1c             	sub    $0x1c,%esp
  8023b3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8023b7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8023bb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023bf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8023c3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8023c7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8023cb:	89 f3                	mov    %esi,%ebx
  8023cd:	89 fa                	mov    %edi,%edx
  8023cf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023d3:	89 34 24             	mov    %esi,(%esp)
  8023d6:	85 c0                	test   %eax,%eax
  8023d8:	75 1a                	jne    8023f4 <__umoddi3+0x48>
  8023da:	39 f7                	cmp    %esi,%edi
  8023dc:	0f 86 a2 00 00 00    	jbe    802484 <__umoddi3+0xd8>
  8023e2:	89 c8                	mov    %ecx,%eax
  8023e4:	89 f2                	mov    %esi,%edx
  8023e6:	f7 f7                	div    %edi
  8023e8:	89 d0                	mov    %edx,%eax
  8023ea:	31 d2                	xor    %edx,%edx
  8023ec:	83 c4 1c             	add    $0x1c,%esp
  8023ef:	5b                   	pop    %ebx
  8023f0:	5e                   	pop    %esi
  8023f1:	5f                   	pop    %edi
  8023f2:	5d                   	pop    %ebp
  8023f3:	c3                   	ret    
  8023f4:	39 f0                	cmp    %esi,%eax
  8023f6:	0f 87 ac 00 00 00    	ja     8024a8 <__umoddi3+0xfc>
  8023fc:	0f bd e8             	bsr    %eax,%ebp
  8023ff:	83 f5 1f             	xor    $0x1f,%ebp
  802402:	0f 84 ac 00 00 00    	je     8024b4 <__umoddi3+0x108>
  802408:	bf 20 00 00 00       	mov    $0x20,%edi
  80240d:	29 ef                	sub    %ebp,%edi
  80240f:	89 fe                	mov    %edi,%esi
  802411:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802415:	89 e9                	mov    %ebp,%ecx
  802417:	d3 e0                	shl    %cl,%eax
  802419:	89 d7                	mov    %edx,%edi
  80241b:	89 f1                	mov    %esi,%ecx
  80241d:	d3 ef                	shr    %cl,%edi
  80241f:	09 c7                	or     %eax,%edi
  802421:	89 e9                	mov    %ebp,%ecx
  802423:	d3 e2                	shl    %cl,%edx
  802425:	89 14 24             	mov    %edx,(%esp)
  802428:	89 d8                	mov    %ebx,%eax
  80242a:	d3 e0                	shl    %cl,%eax
  80242c:	89 c2                	mov    %eax,%edx
  80242e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802432:	d3 e0                	shl    %cl,%eax
  802434:	89 44 24 04          	mov    %eax,0x4(%esp)
  802438:	8b 44 24 08          	mov    0x8(%esp),%eax
  80243c:	89 f1                	mov    %esi,%ecx
  80243e:	d3 e8                	shr    %cl,%eax
  802440:	09 d0                	or     %edx,%eax
  802442:	d3 eb                	shr    %cl,%ebx
  802444:	89 da                	mov    %ebx,%edx
  802446:	f7 f7                	div    %edi
  802448:	89 d3                	mov    %edx,%ebx
  80244a:	f7 24 24             	mull   (%esp)
  80244d:	89 c6                	mov    %eax,%esi
  80244f:	89 d1                	mov    %edx,%ecx
  802451:	39 d3                	cmp    %edx,%ebx
  802453:	0f 82 87 00 00 00    	jb     8024e0 <__umoddi3+0x134>
  802459:	0f 84 91 00 00 00    	je     8024f0 <__umoddi3+0x144>
  80245f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802463:	29 f2                	sub    %esi,%edx
  802465:	19 cb                	sbb    %ecx,%ebx
  802467:	89 d8                	mov    %ebx,%eax
  802469:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80246d:	d3 e0                	shl    %cl,%eax
  80246f:	89 e9                	mov    %ebp,%ecx
  802471:	d3 ea                	shr    %cl,%edx
  802473:	09 d0                	or     %edx,%eax
  802475:	89 e9                	mov    %ebp,%ecx
  802477:	d3 eb                	shr    %cl,%ebx
  802479:	89 da                	mov    %ebx,%edx
  80247b:	83 c4 1c             	add    $0x1c,%esp
  80247e:	5b                   	pop    %ebx
  80247f:	5e                   	pop    %esi
  802480:	5f                   	pop    %edi
  802481:	5d                   	pop    %ebp
  802482:	c3                   	ret    
  802483:	90                   	nop
  802484:	89 fd                	mov    %edi,%ebp
  802486:	85 ff                	test   %edi,%edi
  802488:	75 0b                	jne    802495 <__umoddi3+0xe9>
  80248a:	b8 01 00 00 00       	mov    $0x1,%eax
  80248f:	31 d2                	xor    %edx,%edx
  802491:	f7 f7                	div    %edi
  802493:	89 c5                	mov    %eax,%ebp
  802495:	89 f0                	mov    %esi,%eax
  802497:	31 d2                	xor    %edx,%edx
  802499:	f7 f5                	div    %ebp
  80249b:	89 c8                	mov    %ecx,%eax
  80249d:	f7 f5                	div    %ebp
  80249f:	89 d0                	mov    %edx,%eax
  8024a1:	e9 44 ff ff ff       	jmp    8023ea <__umoddi3+0x3e>
  8024a6:	66 90                	xchg   %ax,%ax
  8024a8:	89 c8                	mov    %ecx,%eax
  8024aa:	89 f2                	mov    %esi,%edx
  8024ac:	83 c4 1c             	add    $0x1c,%esp
  8024af:	5b                   	pop    %ebx
  8024b0:	5e                   	pop    %esi
  8024b1:	5f                   	pop    %edi
  8024b2:	5d                   	pop    %ebp
  8024b3:	c3                   	ret    
  8024b4:	3b 04 24             	cmp    (%esp),%eax
  8024b7:	72 06                	jb     8024bf <__umoddi3+0x113>
  8024b9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8024bd:	77 0f                	ja     8024ce <__umoddi3+0x122>
  8024bf:	89 f2                	mov    %esi,%edx
  8024c1:	29 f9                	sub    %edi,%ecx
  8024c3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8024c7:	89 14 24             	mov    %edx,(%esp)
  8024ca:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024ce:	8b 44 24 04          	mov    0x4(%esp),%eax
  8024d2:	8b 14 24             	mov    (%esp),%edx
  8024d5:	83 c4 1c             	add    $0x1c,%esp
  8024d8:	5b                   	pop    %ebx
  8024d9:	5e                   	pop    %esi
  8024da:	5f                   	pop    %edi
  8024db:	5d                   	pop    %ebp
  8024dc:	c3                   	ret    
  8024dd:	8d 76 00             	lea    0x0(%esi),%esi
  8024e0:	2b 04 24             	sub    (%esp),%eax
  8024e3:	19 fa                	sbb    %edi,%edx
  8024e5:	89 d1                	mov    %edx,%ecx
  8024e7:	89 c6                	mov    %eax,%esi
  8024e9:	e9 71 ff ff ff       	jmp    80245f <__umoddi3+0xb3>
  8024ee:	66 90                	xchg   %ax,%ax
  8024f0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8024f4:	72 ea                	jb     8024e0 <__umoddi3+0x134>
  8024f6:	89 d9                	mov    %ebx,%ecx
  8024f8:	e9 62 ff ff ff       	jmp    80245f <__umoddi3+0xb3>
