
obj/user/mergesort_leakage:     file format elf32-i386


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
  800031:	e8 73 07 00 00       	call   8007a9 <libmain>
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
  800041:	e8 fb 1d 00 00       	call   801e41 <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 00 25 80 00       	push   $0x802500
  80004e:	e8 32 0b 00 00       	call   800b85 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 02 25 80 00       	push   $0x802502
  80005e:	e8 22 0b 00 00       	call   800b85 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 18 25 80 00       	push   $0x802518
  80006e:	e8 12 0b 00 00       	call   800b85 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 02 25 80 00       	push   $0x802502
  80007e:	e8 02 0b 00 00       	call   800b85 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 00 25 80 00       	push   $0x802500
  80008e:	e8 f2 0a 00 00       	call   800b85 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 30 25 80 00       	push   $0x802530
  8000a5:	e8 5d 11 00 00       	call   801207 <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 ad 16 00 00       	call   80176d <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 40 1a 00 00       	call   801b15 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 50 25 80 00       	push   $0x802550
  8000e3:	e8 9d 0a 00 00       	call   800b85 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 72 25 80 00       	push   $0x802572
  8000f3:	e8 8d 0a 00 00       	call   800b85 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 80 25 80 00       	push   $0x802580
  800103:	e8 7d 0a 00 00       	call   800b85 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 8f 25 80 00       	push   $0x80258f
  800113:	e8 6d 0a 00 00       	call   800b85 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 9f 25 80 00       	push   $0x80259f
  800123:	e8 5d 0a 00 00       	call   800b85 <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 21 06 00 00       	call   800751 <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 c9 05 00 00       	call   800709 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 bc 05 00 00       	call   800709 <cputchar>
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
  800162:	e8 f4 1c 00 00       	call   801e5b <sys_enable_interrupt>

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
  8001d7:	e8 65 1c 00 00       	call   801e41 <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001dc:	83 ec 0c             	sub    $0xc,%esp
  8001df:	68 a8 25 80 00       	push   $0x8025a8
  8001e4:	e8 9c 09 00 00       	call   800b85 <cprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ec:	e8 6a 1c 00 00       	call   801e5b <sys_enable_interrupt>

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
  80021a:	e8 af 06 00 00       	call   8008ce <_panic>
		else
		{
			sys_disable_interrupt();
  80021f:	e8 1d 1c 00 00       	call   801e41 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	68 18 26 80 00       	push   $0x802618
  80022c:	e8 54 09 00 00       	call   800b85 <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 4c 26 80 00       	push   $0x80264c
  80023c:	e8 44 09 00 00       	call   800b85 <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	68 80 26 80 00       	push   $0x802680
  80024c:	e8 34 09 00 00       	call   800b85 <cprintf>
  800251:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800254:	e8 02 1c 00 00       	call   801e5b <sys_enable_interrupt>
		}

		free(Elements) ;
  800259:	83 ec 0c             	sub    $0xc,%esp
  80025c:	ff 75 ec             	pushl  -0x14(%ebp)
  80025f:	e8 cb 18 00 00       	call   801b2f <free>
  800264:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800267:	e8 d5 1b 00 00       	call   801e41 <sys_disable_interrupt>
			Chose = 0 ;
  80026c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800270:	eb 42                	jmp    8002b4 <_main+0x27c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	68 b2 26 80 00       	push   $0x8026b2
  80027a:	e8 06 09 00 00       	call   800b85 <cprintf>
  80027f:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800282:	e8 ca 04 00 00       	call   800751 <getchar>
  800287:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80028a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80028e:	83 ec 0c             	sub    $0xc,%esp
  800291:	50                   	push   %eax
  800292:	e8 72 04 00 00       	call   800709 <cputchar>
  800297:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80029a:	83 ec 0c             	sub    $0xc,%esp
  80029d:	6a 0a                	push   $0xa
  80029f:	e8 65 04 00 00       	call   800709 <cputchar>
  8002a4:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  8002a7:	83 ec 0c             	sub    $0xc,%esp
  8002aa:	6a 0a                	push   $0xa
  8002ac:	e8 58 04 00 00       	call   800709 <cputchar>
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
  8002c0:	e8 96 1b 00 00       	call   801e5b <sys_enable_interrupt>

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
  800459:	e8 27 07 00 00       	call   800b85 <cprintf>
  80045e:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800461:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800464:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	01 d0                	add    %edx,%eax
  800470:	8b 00                	mov    (%eax),%eax
  800472:	83 ec 08             	sub    $0x8,%esp
  800475:	50                   	push   %eax
  800476:	68 d0 26 80 00       	push   $0x8026d0
  80047b:	e8 05 07 00 00       	call   800b85 <cprintf>
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
  8004a4:	68 d5 26 80 00       	push   $0x8026d5
  8004a9:	e8 d7 06 00 00       	call   800b85 <cprintf>
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

	int* Left = malloc(sizeof(int) * leftCapacity);
  800540:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800543:	c1 e0 02             	shl    $0x2,%eax
  800546:	83 ec 0c             	sub    $0xc,%esp
  800549:	50                   	push   %eax
  80054a:	e8 c6 15 00 00       	call   801b15 <malloc>
  80054f:	83 c4 10             	add    $0x10,%esp
  800552:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  800555:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800558:	c1 e0 02             	shl    $0x2,%eax
  80055b:	83 ec 0c             	sub    $0xc,%esp
  80055e:	50                   	push   %eax
  80055f:	e8 b1 15 00 00       	call   801b15 <malloc>
  800564:	83 c4 10             	add    $0x10,%esp
  800567:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

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

	//	int Left[5000] ;
	//	int Right[5000] ;

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
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  800706:	90                   	nop
  800707:	c9                   	leave  
  800708:	c3                   	ret    

00800709 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800709:	55                   	push   %ebp
  80070a:	89 e5                	mov    %esp,%ebp
  80070c:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80070f:	8b 45 08             	mov    0x8(%ebp),%eax
  800712:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800715:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800719:	83 ec 0c             	sub    $0xc,%esp
  80071c:	50                   	push   %eax
  80071d:	e8 53 17 00 00       	call   801e75 <sys_cputc>
  800722:	83 c4 10             	add    $0x10,%esp
}
  800725:	90                   	nop
  800726:	c9                   	leave  
  800727:	c3                   	ret    

00800728 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800728:	55                   	push   %ebp
  800729:	89 e5                	mov    %esp,%ebp
  80072b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80072e:	e8 0e 17 00 00       	call   801e41 <sys_disable_interrupt>
	char c = ch;
  800733:	8b 45 08             	mov    0x8(%ebp),%eax
  800736:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800739:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80073d:	83 ec 0c             	sub    $0xc,%esp
  800740:	50                   	push   %eax
  800741:	e8 2f 17 00 00       	call   801e75 <sys_cputc>
  800746:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800749:	e8 0d 17 00 00       	call   801e5b <sys_enable_interrupt>
}
  80074e:	90                   	nop
  80074f:	c9                   	leave  
  800750:	c3                   	ret    

00800751 <getchar>:

int
getchar(void)
{
  800751:	55                   	push   %ebp
  800752:	89 e5                	mov    %esp,%ebp
  800754:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800757:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80075e:	eb 08                	jmp    800768 <getchar+0x17>
	{
		c = sys_cgetc();
  800760:	e8 f4 14 00 00       	call   801c59 <sys_cgetc>
  800765:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800768:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80076c:	74 f2                	je     800760 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80076e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800771:	c9                   	leave  
  800772:	c3                   	ret    

00800773 <atomic_getchar>:

int
atomic_getchar(void)
{
  800773:	55                   	push   %ebp
  800774:	89 e5                	mov    %esp,%ebp
  800776:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800779:	e8 c3 16 00 00       	call   801e41 <sys_disable_interrupt>
	int c=0;
  80077e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800785:	eb 08                	jmp    80078f <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800787:	e8 cd 14 00 00       	call   801c59 <sys_cgetc>
  80078c:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80078f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800793:	74 f2                	je     800787 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800795:	e8 c1 16 00 00       	call   801e5b <sys_enable_interrupt>
	return c;
  80079a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80079d:	c9                   	leave  
  80079e:	c3                   	ret    

0080079f <iscons>:

int iscons(int fdnum)
{
  80079f:	55                   	push   %ebp
  8007a0:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007a2:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007a7:	5d                   	pop    %ebp
  8007a8:	c3                   	ret    

008007a9 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007a9:	55                   	push   %ebp
  8007aa:	89 e5                	mov    %esp,%ebp
  8007ac:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007af:	e8 f2 14 00 00       	call   801ca6 <sys_getenvindex>
  8007b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007ba:	89 d0                	mov    %edx,%eax
  8007bc:	c1 e0 03             	shl    $0x3,%eax
  8007bf:	01 d0                	add    %edx,%eax
  8007c1:	c1 e0 02             	shl    $0x2,%eax
  8007c4:	01 d0                	add    %edx,%eax
  8007c6:	c1 e0 06             	shl    $0x6,%eax
  8007c9:	29 d0                	sub    %edx,%eax
  8007cb:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8007d2:	01 c8                	add    %ecx,%eax
  8007d4:	01 d0                	add    %edx,%eax
  8007d6:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8007db:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007e0:	a1 24 30 80 00       	mov    0x803024,%eax
  8007e5:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  8007eb:	84 c0                	test   %al,%al
  8007ed:	74 0f                	je     8007fe <libmain+0x55>
		binaryname = myEnv->prog_name;
  8007ef:	a1 24 30 80 00       	mov    0x803024,%eax
  8007f4:	05 b0 52 00 00       	add    $0x52b0,%eax
  8007f9:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8007fe:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800802:	7e 0a                	jle    80080e <libmain+0x65>
		binaryname = argv[0];
  800804:	8b 45 0c             	mov    0xc(%ebp),%eax
  800807:	8b 00                	mov    (%eax),%eax
  800809:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80080e:	83 ec 08             	sub    $0x8,%esp
  800811:	ff 75 0c             	pushl  0xc(%ebp)
  800814:	ff 75 08             	pushl  0x8(%ebp)
  800817:	e8 1c f8 ff ff       	call   800038 <_main>
  80081c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80081f:	e8 1d 16 00 00       	call   801e41 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800824:	83 ec 0c             	sub    $0xc,%esp
  800827:	68 f4 26 80 00       	push   $0x8026f4
  80082c:	e8 54 03 00 00       	call   800b85 <cprintf>
  800831:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800834:	a1 24 30 80 00       	mov    0x803024,%eax
  800839:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  80083f:	a1 24 30 80 00       	mov    0x803024,%eax
  800844:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  80084a:	83 ec 04             	sub    $0x4,%esp
  80084d:	52                   	push   %edx
  80084e:	50                   	push   %eax
  80084f:	68 1c 27 80 00       	push   $0x80271c
  800854:	e8 2c 03 00 00       	call   800b85 <cprintf>
  800859:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80085c:	a1 24 30 80 00       	mov    0x803024,%eax
  800861:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  800867:	a1 24 30 80 00       	mov    0x803024,%eax
  80086c:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  800872:	a1 24 30 80 00       	mov    0x803024,%eax
  800877:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  80087d:	51                   	push   %ecx
  80087e:	52                   	push   %edx
  80087f:	50                   	push   %eax
  800880:	68 44 27 80 00       	push   $0x802744
  800885:	e8 fb 02 00 00       	call   800b85 <cprintf>
  80088a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80088d:	83 ec 0c             	sub    $0xc,%esp
  800890:	68 f4 26 80 00       	push   $0x8026f4
  800895:	e8 eb 02 00 00       	call   800b85 <cprintf>
  80089a:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80089d:	e8 b9 15 00 00       	call   801e5b <sys_enable_interrupt>

	// exit gracefully
	exit();
  8008a2:	e8 19 00 00 00       	call   8008c0 <exit>
}
  8008a7:	90                   	nop
  8008a8:	c9                   	leave  
  8008a9:	c3                   	ret    

008008aa <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008aa:	55                   	push   %ebp
  8008ab:	89 e5                	mov    %esp,%ebp
  8008ad:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008b0:	83 ec 0c             	sub    $0xc,%esp
  8008b3:	6a 00                	push   $0x0
  8008b5:	e8 b8 13 00 00       	call   801c72 <sys_env_destroy>
  8008ba:	83 c4 10             	add    $0x10,%esp
}
  8008bd:	90                   	nop
  8008be:	c9                   	leave  
  8008bf:	c3                   	ret    

008008c0 <exit>:

void
exit(void)
{
  8008c0:	55                   	push   %ebp
  8008c1:	89 e5                	mov    %esp,%ebp
  8008c3:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008c6:	e8 0d 14 00 00       	call   801cd8 <sys_env_exit>
}
  8008cb:	90                   	nop
  8008cc:	c9                   	leave  
  8008cd:	c3                   	ret    

008008ce <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008ce:	55                   	push   %ebp
  8008cf:	89 e5                	mov    %esp,%ebp
  8008d1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008d4:	8d 45 10             	lea    0x10(%ebp),%eax
  8008d7:	83 c0 04             	add    $0x4,%eax
  8008da:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008dd:	a1 18 31 80 00       	mov    0x803118,%eax
  8008e2:	85 c0                	test   %eax,%eax
  8008e4:	74 16                	je     8008fc <_panic+0x2e>
		cprintf("%s: ", argv0);
  8008e6:	a1 18 31 80 00       	mov    0x803118,%eax
  8008eb:	83 ec 08             	sub    $0x8,%esp
  8008ee:	50                   	push   %eax
  8008ef:	68 9c 27 80 00       	push   $0x80279c
  8008f4:	e8 8c 02 00 00       	call   800b85 <cprintf>
  8008f9:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8008fc:	a1 00 30 80 00       	mov    0x803000,%eax
  800901:	ff 75 0c             	pushl  0xc(%ebp)
  800904:	ff 75 08             	pushl  0x8(%ebp)
  800907:	50                   	push   %eax
  800908:	68 a1 27 80 00       	push   $0x8027a1
  80090d:	e8 73 02 00 00       	call   800b85 <cprintf>
  800912:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800915:	8b 45 10             	mov    0x10(%ebp),%eax
  800918:	83 ec 08             	sub    $0x8,%esp
  80091b:	ff 75 f4             	pushl  -0xc(%ebp)
  80091e:	50                   	push   %eax
  80091f:	e8 f6 01 00 00       	call   800b1a <vcprintf>
  800924:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800927:	83 ec 08             	sub    $0x8,%esp
  80092a:	6a 00                	push   $0x0
  80092c:	68 bd 27 80 00       	push   $0x8027bd
  800931:	e8 e4 01 00 00       	call   800b1a <vcprintf>
  800936:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800939:	e8 82 ff ff ff       	call   8008c0 <exit>

	// should not return here
	while (1) ;
  80093e:	eb fe                	jmp    80093e <_panic+0x70>

00800940 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800940:	55                   	push   %ebp
  800941:	89 e5                	mov    %esp,%ebp
  800943:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800946:	a1 24 30 80 00       	mov    0x803024,%eax
  80094b:	8b 50 74             	mov    0x74(%eax),%edx
  80094e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800951:	39 c2                	cmp    %eax,%edx
  800953:	74 14                	je     800969 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800955:	83 ec 04             	sub    $0x4,%esp
  800958:	68 c0 27 80 00       	push   $0x8027c0
  80095d:	6a 26                	push   $0x26
  80095f:	68 0c 28 80 00       	push   $0x80280c
  800964:	e8 65 ff ff ff       	call   8008ce <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800969:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800970:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800977:	e9 c4 00 00 00       	jmp    800a40 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  80097c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80097f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800986:	8b 45 08             	mov    0x8(%ebp),%eax
  800989:	01 d0                	add    %edx,%eax
  80098b:	8b 00                	mov    (%eax),%eax
  80098d:	85 c0                	test   %eax,%eax
  80098f:	75 08                	jne    800999 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800991:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800994:	e9 a4 00 00 00       	jmp    800a3d <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  800999:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009a0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8009a7:	eb 6b                	jmp    800a14 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009a9:	a1 24 30 80 00       	mov    0x803024,%eax
  8009ae:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8009b4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009b7:	89 d0                	mov    %edx,%eax
  8009b9:	c1 e0 02             	shl    $0x2,%eax
  8009bc:	01 d0                	add    %edx,%eax
  8009be:	c1 e0 02             	shl    $0x2,%eax
  8009c1:	01 c8                	add    %ecx,%eax
  8009c3:	8a 40 04             	mov    0x4(%eax),%al
  8009c6:	84 c0                	test   %al,%al
  8009c8:	75 47                	jne    800a11 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009ca:	a1 24 30 80 00       	mov    0x803024,%eax
  8009cf:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8009d5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009d8:	89 d0                	mov    %edx,%eax
  8009da:	c1 e0 02             	shl    $0x2,%eax
  8009dd:	01 d0                	add    %edx,%eax
  8009df:	c1 e0 02             	shl    $0x2,%eax
  8009e2:	01 c8                	add    %ecx,%eax
  8009e4:	8b 00                	mov    (%eax),%eax
  8009e6:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8009e9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009ec:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009f1:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8009f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009f6:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8009fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800a00:	01 c8                	add    %ecx,%eax
  800a02:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a04:	39 c2                	cmp    %eax,%edx
  800a06:	75 09                	jne    800a11 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800a08:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a0f:	eb 12                	jmp    800a23 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a11:	ff 45 e8             	incl   -0x18(%ebp)
  800a14:	a1 24 30 80 00       	mov    0x803024,%eax
  800a19:	8b 50 74             	mov    0x74(%eax),%edx
  800a1c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a1f:	39 c2                	cmp    %eax,%edx
  800a21:	77 86                	ja     8009a9 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a23:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a27:	75 14                	jne    800a3d <CheckWSWithoutLastIndex+0xfd>
			panic(
  800a29:	83 ec 04             	sub    $0x4,%esp
  800a2c:	68 18 28 80 00       	push   $0x802818
  800a31:	6a 3a                	push   $0x3a
  800a33:	68 0c 28 80 00       	push   $0x80280c
  800a38:	e8 91 fe ff ff       	call   8008ce <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a3d:	ff 45 f0             	incl   -0x10(%ebp)
  800a40:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a43:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a46:	0f 8c 30 ff ff ff    	jl     80097c <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a4c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a53:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a5a:	eb 27                	jmp    800a83 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a5c:	a1 24 30 80 00       	mov    0x803024,%eax
  800a61:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800a67:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a6a:	89 d0                	mov    %edx,%eax
  800a6c:	c1 e0 02             	shl    $0x2,%eax
  800a6f:	01 d0                	add    %edx,%eax
  800a71:	c1 e0 02             	shl    $0x2,%eax
  800a74:	01 c8                	add    %ecx,%eax
  800a76:	8a 40 04             	mov    0x4(%eax),%al
  800a79:	3c 01                	cmp    $0x1,%al
  800a7b:	75 03                	jne    800a80 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800a7d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a80:	ff 45 e0             	incl   -0x20(%ebp)
  800a83:	a1 24 30 80 00       	mov    0x803024,%eax
  800a88:	8b 50 74             	mov    0x74(%eax),%edx
  800a8b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a8e:	39 c2                	cmp    %eax,%edx
  800a90:	77 ca                	ja     800a5c <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a92:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a95:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a98:	74 14                	je     800aae <CheckWSWithoutLastIndex+0x16e>
		panic(
  800a9a:	83 ec 04             	sub    $0x4,%esp
  800a9d:	68 6c 28 80 00       	push   $0x80286c
  800aa2:	6a 44                	push   $0x44
  800aa4:	68 0c 28 80 00       	push   $0x80280c
  800aa9:	e8 20 fe ff ff       	call   8008ce <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800aae:	90                   	nop
  800aaf:	c9                   	leave  
  800ab0:	c3                   	ret    

00800ab1 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800ab1:	55                   	push   %ebp
  800ab2:	89 e5                	mov    %esp,%ebp
  800ab4:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800ab7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aba:	8b 00                	mov    (%eax),%eax
  800abc:	8d 48 01             	lea    0x1(%eax),%ecx
  800abf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ac2:	89 0a                	mov    %ecx,(%edx)
  800ac4:	8b 55 08             	mov    0x8(%ebp),%edx
  800ac7:	88 d1                	mov    %dl,%cl
  800ac9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800acc:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800ad0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad3:	8b 00                	mov    (%eax),%eax
  800ad5:	3d ff 00 00 00       	cmp    $0xff,%eax
  800ada:	75 2c                	jne    800b08 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800adc:	a0 28 30 80 00       	mov    0x803028,%al
  800ae1:	0f b6 c0             	movzbl %al,%eax
  800ae4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae7:	8b 12                	mov    (%edx),%edx
  800ae9:	89 d1                	mov    %edx,%ecx
  800aeb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aee:	83 c2 08             	add    $0x8,%edx
  800af1:	83 ec 04             	sub    $0x4,%esp
  800af4:	50                   	push   %eax
  800af5:	51                   	push   %ecx
  800af6:	52                   	push   %edx
  800af7:	e8 34 11 00 00       	call   801c30 <sys_cputs>
  800afc:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800aff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b02:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b08:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0b:	8b 40 04             	mov    0x4(%eax),%eax
  800b0e:	8d 50 01             	lea    0x1(%eax),%edx
  800b11:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b14:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b17:	90                   	nop
  800b18:	c9                   	leave  
  800b19:	c3                   	ret    

00800b1a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b1a:	55                   	push   %ebp
  800b1b:	89 e5                	mov    %esp,%ebp
  800b1d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b23:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b2a:	00 00 00 
	b.cnt = 0;
  800b2d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b34:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b37:	ff 75 0c             	pushl  0xc(%ebp)
  800b3a:	ff 75 08             	pushl  0x8(%ebp)
  800b3d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b43:	50                   	push   %eax
  800b44:	68 b1 0a 80 00       	push   $0x800ab1
  800b49:	e8 11 02 00 00       	call   800d5f <vprintfmt>
  800b4e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b51:	a0 28 30 80 00       	mov    0x803028,%al
  800b56:	0f b6 c0             	movzbl %al,%eax
  800b59:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b5f:	83 ec 04             	sub    $0x4,%esp
  800b62:	50                   	push   %eax
  800b63:	52                   	push   %edx
  800b64:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b6a:	83 c0 08             	add    $0x8,%eax
  800b6d:	50                   	push   %eax
  800b6e:	e8 bd 10 00 00       	call   801c30 <sys_cputs>
  800b73:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b76:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b7d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b83:	c9                   	leave  
  800b84:	c3                   	ret    

00800b85 <cprintf>:

int cprintf(const char *fmt, ...) {
  800b85:	55                   	push   %ebp
  800b86:	89 e5                	mov    %esp,%ebp
  800b88:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b8b:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800b92:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b95:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b98:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9b:	83 ec 08             	sub    $0x8,%esp
  800b9e:	ff 75 f4             	pushl  -0xc(%ebp)
  800ba1:	50                   	push   %eax
  800ba2:	e8 73 ff ff ff       	call   800b1a <vcprintf>
  800ba7:	83 c4 10             	add    $0x10,%esp
  800baa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800bad:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bb0:	c9                   	leave  
  800bb1:	c3                   	ret    

00800bb2 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800bb2:	55                   	push   %ebp
  800bb3:	89 e5                	mov    %esp,%ebp
  800bb5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bb8:	e8 84 12 00 00       	call   801e41 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bbd:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bc0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc6:	83 ec 08             	sub    $0x8,%esp
  800bc9:	ff 75 f4             	pushl  -0xc(%ebp)
  800bcc:	50                   	push   %eax
  800bcd:	e8 48 ff ff ff       	call   800b1a <vcprintf>
  800bd2:	83 c4 10             	add    $0x10,%esp
  800bd5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800bd8:	e8 7e 12 00 00       	call   801e5b <sys_enable_interrupt>
	return cnt;
  800bdd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800be0:	c9                   	leave  
  800be1:	c3                   	ret    

00800be2 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800be2:	55                   	push   %ebp
  800be3:	89 e5                	mov    %esp,%ebp
  800be5:	53                   	push   %ebx
  800be6:	83 ec 14             	sub    $0x14,%esp
  800be9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bef:	8b 45 14             	mov    0x14(%ebp),%eax
  800bf2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800bf5:	8b 45 18             	mov    0x18(%ebp),%eax
  800bf8:	ba 00 00 00 00       	mov    $0x0,%edx
  800bfd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c00:	77 55                	ja     800c57 <printnum+0x75>
  800c02:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c05:	72 05                	jb     800c0c <printnum+0x2a>
  800c07:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c0a:	77 4b                	ja     800c57 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c0c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c0f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c12:	8b 45 18             	mov    0x18(%ebp),%eax
  800c15:	ba 00 00 00 00       	mov    $0x0,%edx
  800c1a:	52                   	push   %edx
  800c1b:	50                   	push   %eax
  800c1c:	ff 75 f4             	pushl  -0xc(%ebp)
  800c1f:	ff 75 f0             	pushl  -0x10(%ebp)
  800c22:	e8 59 16 00 00       	call   802280 <__udivdi3>
  800c27:	83 c4 10             	add    $0x10,%esp
  800c2a:	83 ec 04             	sub    $0x4,%esp
  800c2d:	ff 75 20             	pushl  0x20(%ebp)
  800c30:	53                   	push   %ebx
  800c31:	ff 75 18             	pushl  0x18(%ebp)
  800c34:	52                   	push   %edx
  800c35:	50                   	push   %eax
  800c36:	ff 75 0c             	pushl  0xc(%ebp)
  800c39:	ff 75 08             	pushl  0x8(%ebp)
  800c3c:	e8 a1 ff ff ff       	call   800be2 <printnum>
  800c41:	83 c4 20             	add    $0x20,%esp
  800c44:	eb 1a                	jmp    800c60 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c46:	83 ec 08             	sub    $0x8,%esp
  800c49:	ff 75 0c             	pushl  0xc(%ebp)
  800c4c:	ff 75 20             	pushl  0x20(%ebp)
  800c4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c52:	ff d0                	call   *%eax
  800c54:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c57:	ff 4d 1c             	decl   0x1c(%ebp)
  800c5a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c5e:	7f e6                	jg     800c46 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c60:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c63:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c68:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c6b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c6e:	53                   	push   %ebx
  800c6f:	51                   	push   %ecx
  800c70:	52                   	push   %edx
  800c71:	50                   	push   %eax
  800c72:	e8 19 17 00 00       	call   802390 <__umoddi3>
  800c77:	83 c4 10             	add    $0x10,%esp
  800c7a:	05 d4 2a 80 00       	add    $0x802ad4,%eax
  800c7f:	8a 00                	mov    (%eax),%al
  800c81:	0f be c0             	movsbl %al,%eax
  800c84:	83 ec 08             	sub    $0x8,%esp
  800c87:	ff 75 0c             	pushl  0xc(%ebp)
  800c8a:	50                   	push   %eax
  800c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8e:	ff d0                	call   *%eax
  800c90:	83 c4 10             	add    $0x10,%esp
}
  800c93:	90                   	nop
  800c94:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c97:	c9                   	leave  
  800c98:	c3                   	ret    

00800c99 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c99:	55                   	push   %ebp
  800c9a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c9c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ca0:	7e 1c                	jle    800cbe <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca5:	8b 00                	mov    (%eax),%eax
  800ca7:	8d 50 08             	lea    0x8(%eax),%edx
  800caa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cad:	89 10                	mov    %edx,(%eax)
  800caf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb2:	8b 00                	mov    (%eax),%eax
  800cb4:	83 e8 08             	sub    $0x8,%eax
  800cb7:	8b 50 04             	mov    0x4(%eax),%edx
  800cba:	8b 00                	mov    (%eax),%eax
  800cbc:	eb 40                	jmp    800cfe <getuint+0x65>
	else if (lflag)
  800cbe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cc2:	74 1e                	je     800ce2 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc7:	8b 00                	mov    (%eax),%eax
  800cc9:	8d 50 04             	lea    0x4(%eax),%edx
  800ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccf:	89 10                	mov    %edx,(%eax)
  800cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd4:	8b 00                	mov    (%eax),%eax
  800cd6:	83 e8 04             	sub    $0x4,%eax
  800cd9:	8b 00                	mov    (%eax),%eax
  800cdb:	ba 00 00 00 00       	mov    $0x0,%edx
  800ce0:	eb 1c                	jmp    800cfe <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	8b 00                	mov    (%eax),%eax
  800ce7:	8d 50 04             	lea    0x4(%eax),%edx
  800cea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ced:	89 10                	mov    %edx,(%eax)
  800cef:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf2:	8b 00                	mov    (%eax),%eax
  800cf4:	83 e8 04             	sub    $0x4,%eax
  800cf7:	8b 00                	mov    (%eax),%eax
  800cf9:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800cfe:	5d                   	pop    %ebp
  800cff:	c3                   	ret    

00800d00 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d00:	55                   	push   %ebp
  800d01:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d03:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d07:	7e 1c                	jle    800d25 <getint+0x25>
		return va_arg(*ap, long long);
  800d09:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0c:	8b 00                	mov    (%eax),%eax
  800d0e:	8d 50 08             	lea    0x8(%eax),%edx
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
  800d14:	89 10                	mov    %edx,(%eax)
  800d16:	8b 45 08             	mov    0x8(%ebp),%eax
  800d19:	8b 00                	mov    (%eax),%eax
  800d1b:	83 e8 08             	sub    $0x8,%eax
  800d1e:	8b 50 04             	mov    0x4(%eax),%edx
  800d21:	8b 00                	mov    (%eax),%eax
  800d23:	eb 38                	jmp    800d5d <getint+0x5d>
	else if (lflag)
  800d25:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d29:	74 1a                	je     800d45 <getint+0x45>
		return va_arg(*ap, long);
  800d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2e:	8b 00                	mov    (%eax),%eax
  800d30:	8d 50 04             	lea    0x4(%eax),%edx
  800d33:	8b 45 08             	mov    0x8(%ebp),%eax
  800d36:	89 10                	mov    %edx,(%eax)
  800d38:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3b:	8b 00                	mov    (%eax),%eax
  800d3d:	83 e8 04             	sub    $0x4,%eax
  800d40:	8b 00                	mov    (%eax),%eax
  800d42:	99                   	cltd   
  800d43:	eb 18                	jmp    800d5d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
  800d48:	8b 00                	mov    (%eax),%eax
  800d4a:	8d 50 04             	lea    0x4(%eax),%edx
  800d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d50:	89 10                	mov    %edx,(%eax)
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
  800d55:	8b 00                	mov    (%eax),%eax
  800d57:	83 e8 04             	sub    $0x4,%eax
  800d5a:	8b 00                	mov    (%eax),%eax
  800d5c:	99                   	cltd   
}
  800d5d:	5d                   	pop    %ebp
  800d5e:	c3                   	ret    

00800d5f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d5f:	55                   	push   %ebp
  800d60:	89 e5                	mov    %esp,%ebp
  800d62:	56                   	push   %esi
  800d63:	53                   	push   %ebx
  800d64:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d67:	eb 17                	jmp    800d80 <vprintfmt+0x21>
			if (ch == '\0')
  800d69:	85 db                	test   %ebx,%ebx
  800d6b:	0f 84 af 03 00 00    	je     801120 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d71:	83 ec 08             	sub    $0x8,%esp
  800d74:	ff 75 0c             	pushl  0xc(%ebp)
  800d77:	53                   	push   %ebx
  800d78:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7b:	ff d0                	call   *%eax
  800d7d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d80:	8b 45 10             	mov    0x10(%ebp),%eax
  800d83:	8d 50 01             	lea    0x1(%eax),%edx
  800d86:	89 55 10             	mov    %edx,0x10(%ebp)
  800d89:	8a 00                	mov    (%eax),%al
  800d8b:	0f b6 d8             	movzbl %al,%ebx
  800d8e:	83 fb 25             	cmp    $0x25,%ebx
  800d91:	75 d6                	jne    800d69 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d93:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d97:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d9e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800da5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800dac:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800db3:	8b 45 10             	mov    0x10(%ebp),%eax
  800db6:	8d 50 01             	lea    0x1(%eax),%edx
  800db9:	89 55 10             	mov    %edx,0x10(%ebp)
  800dbc:	8a 00                	mov    (%eax),%al
  800dbe:	0f b6 d8             	movzbl %al,%ebx
  800dc1:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800dc4:	83 f8 55             	cmp    $0x55,%eax
  800dc7:	0f 87 2b 03 00 00    	ja     8010f8 <vprintfmt+0x399>
  800dcd:	8b 04 85 f8 2a 80 00 	mov    0x802af8(,%eax,4),%eax
  800dd4:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800dd6:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800dda:	eb d7                	jmp    800db3 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800ddc:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800de0:	eb d1                	jmp    800db3 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800de2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800de9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800dec:	89 d0                	mov    %edx,%eax
  800dee:	c1 e0 02             	shl    $0x2,%eax
  800df1:	01 d0                	add    %edx,%eax
  800df3:	01 c0                	add    %eax,%eax
  800df5:	01 d8                	add    %ebx,%eax
  800df7:	83 e8 30             	sub    $0x30,%eax
  800dfa:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800dfd:	8b 45 10             	mov    0x10(%ebp),%eax
  800e00:	8a 00                	mov    (%eax),%al
  800e02:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e05:	83 fb 2f             	cmp    $0x2f,%ebx
  800e08:	7e 3e                	jle    800e48 <vprintfmt+0xe9>
  800e0a:	83 fb 39             	cmp    $0x39,%ebx
  800e0d:	7f 39                	jg     800e48 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e0f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e12:	eb d5                	jmp    800de9 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e14:	8b 45 14             	mov    0x14(%ebp),%eax
  800e17:	83 c0 04             	add    $0x4,%eax
  800e1a:	89 45 14             	mov    %eax,0x14(%ebp)
  800e1d:	8b 45 14             	mov    0x14(%ebp),%eax
  800e20:	83 e8 04             	sub    $0x4,%eax
  800e23:	8b 00                	mov    (%eax),%eax
  800e25:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e28:	eb 1f                	jmp    800e49 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e2a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e2e:	79 83                	jns    800db3 <vprintfmt+0x54>
				width = 0;
  800e30:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e37:	e9 77 ff ff ff       	jmp    800db3 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e3c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e43:	e9 6b ff ff ff       	jmp    800db3 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e48:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e49:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e4d:	0f 89 60 ff ff ff    	jns    800db3 <vprintfmt+0x54>
				width = precision, precision = -1;
  800e53:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e56:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e59:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e60:	e9 4e ff ff ff       	jmp    800db3 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e65:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e68:	e9 46 ff ff ff       	jmp    800db3 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e6d:	8b 45 14             	mov    0x14(%ebp),%eax
  800e70:	83 c0 04             	add    $0x4,%eax
  800e73:	89 45 14             	mov    %eax,0x14(%ebp)
  800e76:	8b 45 14             	mov    0x14(%ebp),%eax
  800e79:	83 e8 04             	sub    $0x4,%eax
  800e7c:	8b 00                	mov    (%eax),%eax
  800e7e:	83 ec 08             	sub    $0x8,%esp
  800e81:	ff 75 0c             	pushl  0xc(%ebp)
  800e84:	50                   	push   %eax
  800e85:	8b 45 08             	mov    0x8(%ebp),%eax
  800e88:	ff d0                	call   *%eax
  800e8a:	83 c4 10             	add    $0x10,%esp
			break;
  800e8d:	e9 89 02 00 00       	jmp    80111b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e92:	8b 45 14             	mov    0x14(%ebp),%eax
  800e95:	83 c0 04             	add    $0x4,%eax
  800e98:	89 45 14             	mov    %eax,0x14(%ebp)
  800e9b:	8b 45 14             	mov    0x14(%ebp),%eax
  800e9e:	83 e8 04             	sub    $0x4,%eax
  800ea1:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ea3:	85 db                	test   %ebx,%ebx
  800ea5:	79 02                	jns    800ea9 <vprintfmt+0x14a>
				err = -err;
  800ea7:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ea9:	83 fb 64             	cmp    $0x64,%ebx
  800eac:	7f 0b                	jg     800eb9 <vprintfmt+0x15a>
  800eae:	8b 34 9d 40 29 80 00 	mov    0x802940(,%ebx,4),%esi
  800eb5:	85 f6                	test   %esi,%esi
  800eb7:	75 19                	jne    800ed2 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800eb9:	53                   	push   %ebx
  800eba:	68 e5 2a 80 00       	push   $0x802ae5
  800ebf:	ff 75 0c             	pushl  0xc(%ebp)
  800ec2:	ff 75 08             	pushl  0x8(%ebp)
  800ec5:	e8 5e 02 00 00       	call   801128 <printfmt>
  800eca:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ecd:	e9 49 02 00 00       	jmp    80111b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ed2:	56                   	push   %esi
  800ed3:	68 ee 2a 80 00       	push   $0x802aee
  800ed8:	ff 75 0c             	pushl  0xc(%ebp)
  800edb:	ff 75 08             	pushl  0x8(%ebp)
  800ede:	e8 45 02 00 00       	call   801128 <printfmt>
  800ee3:	83 c4 10             	add    $0x10,%esp
			break;
  800ee6:	e9 30 02 00 00       	jmp    80111b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800eeb:	8b 45 14             	mov    0x14(%ebp),%eax
  800eee:	83 c0 04             	add    $0x4,%eax
  800ef1:	89 45 14             	mov    %eax,0x14(%ebp)
  800ef4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef7:	83 e8 04             	sub    $0x4,%eax
  800efa:	8b 30                	mov    (%eax),%esi
  800efc:	85 f6                	test   %esi,%esi
  800efe:	75 05                	jne    800f05 <vprintfmt+0x1a6>
				p = "(null)";
  800f00:	be f1 2a 80 00       	mov    $0x802af1,%esi
			if (width > 0 && padc != '-')
  800f05:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f09:	7e 6d                	jle    800f78 <vprintfmt+0x219>
  800f0b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f0f:	74 67                	je     800f78 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f11:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f14:	83 ec 08             	sub    $0x8,%esp
  800f17:	50                   	push   %eax
  800f18:	56                   	push   %esi
  800f19:	e8 12 05 00 00       	call   801430 <strnlen>
  800f1e:	83 c4 10             	add    $0x10,%esp
  800f21:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f24:	eb 16                	jmp    800f3c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f26:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f2a:	83 ec 08             	sub    $0x8,%esp
  800f2d:	ff 75 0c             	pushl  0xc(%ebp)
  800f30:	50                   	push   %eax
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	ff d0                	call   *%eax
  800f36:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f39:	ff 4d e4             	decl   -0x1c(%ebp)
  800f3c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f40:	7f e4                	jg     800f26 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f42:	eb 34                	jmp    800f78 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f44:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f48:	74 1c                	je     800f66 <vprintfmt+0x207>
  800f4a:	83 fb 1f             	cmp    $0x1f,%ebx
  800f4d:	7e 05                	jle    800f54 <vprintfmt+0x1f5>
  800f4f:	83 fb 7e             	cmp    $0x7e,%ebx
  800f52:	7e 12                	jle    800f66 <vprintfmt+0x207>
					putch('?', putdat);
  800f54:	83 ec 08             	sub    $0x8,%esp
  800f57:	ff 75 0c             	pushl  0xc(%ebp)
  800f5a:	6a 3f                	push   $0x3f
  800f5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5f:	ff d0                	call   *%eax
  800f61:	83 c4 10             	add    $0x10,%esp
  800f64:	eb 0f                	jmp    800f75 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f66:	83 ec 08             	sub    $0x8,%esp
  800f69:	ff 75 0c             	pushl  0xc(%ebp)
  800f6c:	53                   	push   %ebx
  800f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f70:	ff d0                	call   *%eax
  800f72:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f75:	ff 4d e4             	decl   -0x1c(%ebp)
  800f78:	89 f0                	mov    %esi,%eax
  800f7a:	8d 70 01             	lea    0x1(%eax),%esi
  800f7d:	8a 00                	mov    (%eax),%al
  800f7f:	0f be d8             	movsbl %al,%ebx
  800f82:	85 db                	test   %ebx,%ebx
  800f84:	74 24                	je     800faa <vprintfmt+0x24b>
  800f86:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f8a:	78 b8                	js     800f44 <vprintfmt+0x1e5>
  800f8c:	ff 4d e0             	decl   -0x20(%ebp)
  800f8f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f93:	79 af                	jns    800f44 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f95:	eb 13                	jmp    800faa <vprintfmt+0x24b>
				putch(' ', putdat);
  800f97:	83 ec 08             	sub    $0x8,%esp
  800f9a:	ff 75 0c             	pushl  0xc(%ebp)
  800f9d:	6a 20                	push   $0x20
  800f9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa2:	ff d0                	call   *%eax
  800fa4:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fa7:	ff 4d e4             	decl   -0x1c(%ebp)
  800faa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fae:	7f e7                	jg     800f97 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fb0:	e9 66 01 00 00       	jmp    80111b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fb5:	83 ec 08             	sub    $0x8,%esp
  800fb8:	ff 75 e8             	pushl  -0x18(%ebp)
  800fbb:	8d 45 14             	lea    0x14(%ebp),%eax
  800fbe:	50                   	push   %eax
  800fbf:	e8 3c fd ff ff       	call   800d00 <getint>
  800fc4:	83 c4 10             	add    $0x10,%esp
  800fc7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fca:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fcd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fd0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fd3:	85 d2                	test   %edx,%edx
  800fd5:	79 23                	jns    800ffa <vprintfmt+0x29b>
				putch('-', putdat);
  800fd7:	83 ec 08             	sub    $0x8,%esp
  800fda:	ff 75 0c             	pushl  0xc(%ebp)
  800fdd:	6a 2d                	push   $0x2d
  800fdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe2:	ff d0                	call   *%eax
  800fe4:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fe7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fea:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fed:	f7 d8                	neg    %eax
  800fef:	83 d2 00             	adc    $0x0,%edx
  800ff2:	f7 da                	neg    %edx
  800ff4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ff7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ffa:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801001:	e9 bc 00 00 00       	jmp    8010c2 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801006:	83 ec 08             	sub    $0x8,%esp
  801009:	ff 75 e8             	pushl  -0x18(%ebp)
  80100c:	8d 45 14             	lea    0x14(%ebp),%eax
  80100f:	50                   	push   %eax
  801010:	e8 84 fc ff ff       	call   800c99 <getuint>
  801015:	83 c4 10             	add    $0x10,%esp
  801018:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80101b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80101e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801025:	e9 98 00 00 00       	jmp    8010c2 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80102a:	83 ec 08             	sub    $0x8,%esp
  80102d:	ff 75 0c             	pushl  0xc(%ebp)
  801030:	6a 58                	push   $0x58
  801032:	8b 45 08             	mov    0x8(%ebp),%eax
  801035:	ff d0                	call   *%eax
  801037:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80103a:	83 ec 08             	sub    $0x8,%esp
  80103d:	ff 75 0c             	pushl  0xc(%ebp)
  801040:	6a 58                	push   $0x58
  801042:	8b 45 08             	mov    0x8(%ebp),%eax
  801045:	ff d0                	call   *%eax
  801047:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80104a:	83 ec 08             	sub    $0x8,%esp
  80104d:	ff 75 0c             	pushl  0xc(%ebp)
  801050:	6a 58                	push   $0x58
  801052:	8b 45 08             	mov    0x8(%ebp),%eax
  801055:	ff d0                	call   *%eax
  801057:	83 c4 10             	add    $0x10,%esp
			break;
  80105a:	e9 bc 00 00 00       	jmp    80111b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80105f:	83 ec 08             	sub    $0x8,%esp
  801062:	ff 75 0c             	pushl  0xc(%ebp)
  801065:	6a 30                	push   $0x30
  801067:	8b 45 08             	mov    0x8(%ebp),%eax
  80106a:	ff d0                	call   *%eax
  80106c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80106f:	83 ec 08             	sub    $0x8,%esp
  801072:	ff 75 0c             	pushl  0xc(%ebp)
  801075:	6a 78                	push   $0x78
  801077:	8b 45 08             	mov    0x8(%ebp),%eax
  80107a:	ff d0                	call   *%eax
  80107c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80107f:	8b 45 14             	mov    0x14(%ebp),%eax
  801082:	83 c0 04             	add    $0x4,%eax
  801085:	89 45 14             	mov    %eax,0x14(%ebp)
  801088:	8b 45 14             	mov    0x14(%ebp),%eax
  80108b:	83 e8 04             	sub    $0x4,%eax
  80108e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801090:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801093:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80109a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8010a1:	eb 1f                	jmp    8010c2 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010a3:	83 ec 08             	sub    $0x8,%esp
  8010a6:	ff 75 e8             	pushl  -0x18(%ebp)
  8010a9:	8d 45 14             	lea    0x14(%ebp),%eax
  8010ac:	50                   	push   %eax
  8010ad:	e8 e7 fb ff ff       	call   800c99 <getuint>
  8010b2:	83 c4 10             	add    $0x10,%esp
  8010b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010b8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010bb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010c2:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010c6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010c9:	83 ec 04             	sub    $0x4,%esp
  8010cc:	52                   	push   %edx
  8010cd:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010d0:	50                   	push   %eax
  8010d1:	ff 75 f4             	pushl  -0xc(%ebp)
  8010d4:	ff 75 f0             	pushl  -0x10(%ebp)
  8010d7:	ff 75 0c             	pushl  0xc(%ebp)
  8010da:	ff 75 08             	pushl  0x8(%ebp)
  8010dd:	e8 00 fb ff ff       	call   800be2 <printnum>
  8010e2:	83 c4 20             	add    $0x20,%esp
			break;
  8010e5:	eb 34                	jmp    80111b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010e7:	83 ec 08             	sub    $0x8,%esp
  8010ea:	ff 75 0c             	pushl  0xc(%ebp)
  8010ed:	53                   	push   %ebx
  8010ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f1:	ff d0                	call   *%eax
  8010f3:	83 c4 10             	add    $0x10,%esp
			break;
  8010f6:	eb 23                	jmp    80111b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8010f8:	83 ec 08             	sub    $0x8,%esp
  8010fb:	ff 75 0c             	pushl  0xc(%ebp)
  8010fe:	6a 25                	push   $0x25
  801100:	8b 45 08             	mov    0x8(%ebp),%eax
  801103:	ff d0                	call   *%eax
  801105:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801108:	ff 4d 10             	decl   0x10(%ebp)
  80110b:	eb 03                	jmp    801110 <vprintfmt+0x3b1>
  80110d:	ff 4d 10             	decl   0x10(%ebp)
  801110:	8b 45 10             	mov    0x10(%ebp),%eax
  801113:	48                   	dec    %eax
  801114:	8a 00                	mov    (%eax),%al
  801116:	3c 25                	cmp    $0x25,%al
  801118:	75 f3                	jne    80110d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80111a:	90                   	nop
		}
	}
  80111b:	e9 47 fc ff ff       	jmp    800d67 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801120:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801121:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801124:	5b                   	pop    %ebx
  801125:	5e                   	pop    %esi
  801126:	5d                   	pop    %ebp
  801127:	c3                   	ret    

00801128 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801128:	55                   	push   %ebp
  801129:	89 e5                	mov    %esp,%ebp
  80112b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80112e:	8d 45 10             	lea    0x10(%ebp),%eax
  801131:	83 c0 04             	add    $0x4,%eax
  801134:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801137:	8b 45 10             	mov    0x10(%ebp),%eax
  80113a:	ff 75 f4             	pushl  -0xc(%ebp)
  80113d:	50                   	push   %eax
  80113e:	ff 75 0c             	pushl  0xc(%ebp)
  801141:	ff 75 08             	pushl  0x8(%ebp)
  801144:	e8 16 fc ff ff       	call   800d5f <vprintfmt>
  801149:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80114c:	90                   	nop
  80114d:	c9                   	leave  
  80114e:	c3                   	ret    

0080114f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80114f:	55                   	push   %ebp
  801150:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801152:	8b 45 0c             	mov    0xc(%ebp),%eax
  801155:	8b 40 08             	mov    0x8(%eax),%eax
  801158:	8d 50 01             	lea    0x1(%eax),%edx
  80115b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801161:	8b 45 0c             	mov    0xc(%ebp),%eax
  801164:	8b 10                	mov    (%eax),%edx
  801166:	8b 45 0c             	mov    0xc(%ebp),%eax
  801169:	8b 40 04             	mov    0x4(%eax),%eax
  80116c:	39 c2                	cmp    %eax,%edx
  80116e:	73 12                	jae    801182 <sprintputch+0x33>
		*b->buf++ = ch;
  801170:	8b 45 0c             	mov    0xc(%ebp),%eax
  801173:	8b 00                	mov    (%eax),%eax
  801175:	8d 48 01             	lea    0x1(%eax),%ecx
  801178:	8b 55 0c             	mov    0xc(%ebp),%edx
  80117b:	89 0a                	mov    %ecx,(%edx)
  80117d:	8b 55 08             	mov    0x8(%ebp),%edx
  801180:	88 10                	mov    %dl,(%eax)
}
  801182:	90                   	nop
  801183:	5d                   	pop    %ebp
  801184:	c3                   	ret    

00801185 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801185:	55                   	push   %ebp
  801186:	89 e5                	mov    %esp,%ebp
  801188:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80118b:	8b 45 08             	mov    0x8(%ebp),%eax
  80118e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801191:	8b 45 0c             	mov    0xc(%ebp),%eax
  801194:	8d 50 ff             	lea    -0x1(%eax),%edx
  801197:	8b 45 08             	mov    0x8(%ebp),%eax
  80119a:	01 d0                	add    %edx,%eax
  80119c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80119f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011a6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011aa:	74 06                	je     8011b2 <vsnprintf+0x2d>
  8011ac:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011b0:	7f 07                	jg     8011b9 <vsnprintf+0x34>
		return -E_INVAL;
  8011b2:	b8 03 00 00 00       	mov    $0x3,%eax
  8011b7:	eb 20                	jmp    8011d9 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011b9:	ff 75 14             	pushl  0x14(%ebp)
  8011bc:	ff 75 10             	pushl  0x10(%ebp)
  8011bf:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011c2:	50                   	push   %eax
  8011c3:	68 4f 11 80 00       	push   $0x80114f
  8011c8:	e8 92 fb ff ff       	call   800d5f <vprintfmt>
  8011cd:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011d3:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011d9:	c9                   	leave  
  8011da:	c3                   	ret    

008011db <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011db:	55                   	push   %ebp
  8011dc:	89 e5                	mov    %esp,%ebp
  8011de:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011e1:	8d 45 10             	lea    0x10(%ebp),%eax
  8011e4:	83 c0 04             	add    $0x4,%eax
  8011e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ed:	ff 75 f4             	pushl  -0xc(%ebp)
  8011f0:	50                   	push   %eax
  8011f1:	ff 75 0c             	pushl  0xc(%ebp)
  8011f4:	ff 75 08             	pushl  0x8(%ebp)
  8011f7:	e8 89 ff ff ff       	call   801185 <vsnprintf>
  8011fc:	83 c4 10             	add    $0x10,%esp
  8011ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801202:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801205:	c9                   	leave  
  801206:	c3                   	ret    

00801207 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801207:	55                   	push   %ebp
  801208:	89 e5                	mov    %esp,%ebp
  80120a:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80120d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801211:	74 13                	je     801226 <readline+0x1f>
		cprintf("%s", prompt);
  801213:	83 ec 08             	sub    $0x8,%esp
  801216:	ff 75 08             	pushl  0x8(%ebp)
  801219:	68 50 2c 80 00       	push   $0x802c50
  80121e:	e8 62 f9 ff ff       	call   800b85 <cprintf>
  801223:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801226:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80122d:	83 ec 0c             	sub    $0xc,%esp
  801230:	6a 00                	push   $0x0
  801232:	e8 68 f5 ff ff       	call   80079f <iscons>
  801237:	83 c4 10             	add    $0x10,%esp
  80123a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80123d:	e8 0f f5 ff ff       	call   800751 <getchar>
  801242:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801245:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801249:	79 22                	jns    80126d <readline+0x66>
			if (c != -E_EOF)
  80124b:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80124f:	0f 84 ad 00 00 00    	je     801302 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801255:	83 ec 08             	sub    $0x8,%esp
  801258:	ff 75 ec             	pushl  -0x14(%ebp)
  80125b:	68 53 2c 80 00       	push   $0x802c53
  801260:	e8 20 f9 ff ff       	call   800b85 <cprintf>
  801265:	83 c4 10             	add    $0x10,%esp
			return;
  801268:	e9 95 00 00 00       	jmp    801302 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80126d:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801271:	7e 34                	jle    8012a7 <readline+0xa0>
  801273:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80127a:	7f 2b                	jg     8012a7 <readline+0xa0>
			if (echoing)
  80127c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801280:	74 0e                	je     801290 <readline+0x89>
				cputchar(c);
  801282:	83 ec 0c             	sub    $0xc,%esp
  801285:	ff 75 ec             	pushl  -0x14(%ebp)
  801288:	e8 7c f4 ff ff       	call   800709 <cputchar>
  80128d:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801290:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801293:	8d 50 01             	lea    0x1(%eax),%edx
  801296:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801299:	89 c2                	mov    %eax,%edx
  80129b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129e:	01 d0                	add    %edx,%eax
  8012a0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012a3:	88 10                	mov    %dl,(%eax)
  8012a5:	eb 56                	jmp    8012fd <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8012a7:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012ab:	75 1f                	jne    8012cc <readline+0xc5>
  8012ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012b1:	7e 19                	jle    8012cc <readline+0xc5>
			if (echoing)
  8012b3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012b7:	74 0e                	je     8012c7 <readline+0xc0>
				cputchar(c);
  8012b9:	83 ec 0c             	sub    $0xc,%esp
  8012bc:	ff 75 ec             	pushl  -0x14(%ebp)
  8012bf:	e8 45 f4 ff ff       	call   800709 <cputchar>
  8012c4:	83 c4 10             	add    $0x10,%esp

			i--;
  8012c7:	ff 4d f4             	decl   -0xc(%ebp)
  8012ca:	eb 31                	jmp    8012fd <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8012cc:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012d0:	74 0a                	je     8012dc <readline+0xd5>
  8012d2:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012d6:	0f 85 61 ff ff ff    	jne    80123d <readline+0x36>
			if (echoing)
  8012dc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012e0:	74 0e                	je     8012f0 <readline+0xe9>
				cputchar(c);
  8012e2:	83 ec 0c             	sub    $0xc,%esp
  8012e5:	ff 75 ec             	pushl  -0x14(%ebp)
  8012e8:	e8 1c f4 ff ff       	call   800709 <cputchar>
  8012ed:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8012f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f6:	01 d0                	add    %edx,%eax
  8012f8:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8012fb:	eb 06                	jmp    801303 <readline+0xfc>
		}
	}
  8012fd:	e9 3b ff ff ff       	jmp    80123d <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801302:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801303:	c9                   	leave  
  801304:	c3                   	ret    

00801305 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801305:	55                   	push   %ebp
  801306:	89 e5                	mov    %esp,%ebp
  801308:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80130b:	e8 31 0b 00 00       	call   801e41 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801310:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801314:	74 13                	je     801329 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801316:	83 ec 08             	sub    $0x8,%esp
  801319:	ff 75 08             	pushl  0x8(%ebp)
  80131c:	68 50 2c 80 00       	push   $0x802c50
  801321:	e8 5f f8 ff ff       	call   800b85 <cprintf>
  801326:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801329:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801330:	83 ec 0c             	sub    $0xc,%esp
  801333:	6a 00                	push   $0x0
  801335:	e8 65 f4 ff ff       	call   80079f <iscons>
  80133a:	83 c4 10             	add    $0x10,%esp
  80133d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801340:	e8 0c f4 ff ff       	call   800751 <getchar>
  801345:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801348:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80134c:	79 23                	jns    801371 <atomic_readline+0x6c>
			if (c != -E_EOF)
  80134e:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801352:	74 13                	je     801367 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801354:	83 ec 08             	sub    $0x8,%esp
  801357:	ff 75 ec             	pushl  -0x14(%ebp)
  80135a:	68 53 2c 80 00       	push   $0x802c53
  80135f:	e8 21 f8 ff ff       	call   800b85 <cprintf>
  801364:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801367:	e8 ef 0a 00 00       	call   801e5b <sys_enable_interrupt>
			return;
  80136c:	e9 9a 00 00 00       	jmp    80140b <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801371:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801375:	7e 34                	jle    8013ab <atomic_readline+0xa6>
  801377:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80137e:	7f 2b                	jg     8013ab <atomic_readline+0xa6>
			if (echoing)
  801380:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801384:	74 0e                	je     801394 <atomic_readline+0x8f>
				cputchar(c);
  801386:	83 ec 0c             	sub    $0xc,%esp
  801389:	ff 75 ec             	pushl  -0x14(%ebp)
  80138c:	e8 78 f3 ff ff       	call   800709 <cputchar>
  801391:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801394:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801397:	8d 50 01             	lea    0x1(%eax),%edx
  80139a:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80139d:	89 c2                	mov    %eax,%edx
  80139f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a2:	01 d0                	add    %edx,%eax
  8013a4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013a7:	88 10                	mov    %dl,(%eax)
  8013a9:	eb 5b                	jmp    801406 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8013ab:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8013af:	75 1f                	jne    8013d0 <atomic_readline+0xcb>
  8013b1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8013b5:	7e 19                	jle    8013d0 <atomic_readline+0xcb>
			if (echoing)
  8013b7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013bb:	74 0e                	je     8013cb <atomic_readline+0xc6>
				cputchar(c);
  8013bd:	83 ec 0c             	sub    $0xc,%esp
  8013c0:	ff 75 ec             	pushl  -0x14(%ebp)
  8013c3:	e8 41 f3 ff ff       	call   800709 <cputchar>
  8013c8:	83 c4 10             	add    $0x10,%esp
			i--;
  8013cb:	ff 4d f4             	decl   -0xc(%ebp)
  8013ce:	eb 36                	jmp    801406 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8013d0:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8013d4:	74 0a                	je     8013e0 <atomic_readline+0xdb>
  8013d6:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8013da:	0f 85 60 ff ff ff    	jne    801340 <atomic_readline+0x3b>
			if (echoing)
  8013e0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013e4:	74 0e                	je     8013f4 <atomic_readline+0xef>
				cputchar(c);
  8013e6:	83 ec 0c             	sub    $0xc,%esp
  8013e9:	ff 75 ec             	pushl  -0x14(%ebp)
  8013ec:	e8 18 f3 ff ff       	call   800709 <cputchar>
  8013f1:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8013f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013fa:	01 d0                	add    %edx,%eax
  8013fc:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8013ff:	e8 57 0a 00 00       	call   801e5b <sys_enable_interrupt>
			return;
  801404:	eb 05                	jmp    80140b <atomic_readline+0x106>
		}
	}
  801406:	e9 35 ff ff ff       	jmp    801340 <atomic_readline+0x3b>
}
  80140b:	c9                   	leave  
  80140c:	c3                   	ret    

0080140d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80140d:	55                   	push   %ebp
  80140e:	89 e5                	mov    %esp,%ebp
  801410:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801413:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80141a:	eb 06                	jmp    801422 <strlen+0x15>
		n++;
  80141c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80141f:	ff 45 08             	incl   0x8(%ebp)
  801422:	8b 45 08             	mov    0x8(%ebp),%eax
  801425:	8a 00                	mov    (%eax),%al
  801427:	84 c0                	test   %al,%al
  801429:	75 f1                	jne    80141c <strlen+0xf>
		n++;
	return n;
  80142b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
  801433:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801436:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80143d:	eb 09                	jmp    801448 <strnlen+0x18>
		n++;
  80143f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801442:	ff 45 08             	incl   0x8(%ebp)
  801445:	ff 4d 0c             	decl   0xc(%ebp)
  801448:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80144c:	74 09                	je     801457 <strnlen+0x27>
  80144e:	8b 45 08             	mov    0x8(%ebp),%eax
  801451:	8a 00                	mov    (%eax),%al
  801453:	84 c0                	test   %al,%al
  801455:	75 e8                	jne    80143f <strnlen+0xf>
		n++;
	return n;
  801457:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80145a:	c9                   	leave  
  80145b:	c3                   	ret    

0080145c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80145c:	55                   	push   %ebp
  80145d:	89 e5                	mov    %esp,%ebp
  80145f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801462:	8b 45 08             	mov    0x8(%ebp),%eax
  801465:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801468:	90                   	nop
  801469:	8b 45 08             	mov    0x8(%ebp),%eax
  80146c:	8d 50 01             	lea    0x1(%eax),%edx
  80146f:	89 55 08             	mov    %edx,0x8(%ebp)
  801472:	8b 55 0c             	mov    0xc(%ebp),%edx
  801475:	8d 4a 01             	lea    0x1(%edx),%ecx
  801478:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80147b:	8a 12                	mov    (%edx),%dl
  80147d:	88 10                	mov    %dl,(%eax)
  80147f:	8a 00                	mov    (%eax),%al
  801481:	84 c0                	test   %al,%al
  801483:	75 e4                	jne    801469 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801485:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801488:	c9                   	leave  
  801489:	c3                   	ret    

0080148a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80148a:	55                   	push   %ebp
  80148b:	89 e5                	mov    %esp,%ebp
  80148d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801490:	8b 45 08             	mov    0x8(%ebp),%eax
  801493:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801496:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80149d:	eb 1f                	jmp    8014be <strncpy+0x34>
		*dst++ = *src;
  80149f:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a2:	8d 50 01             	lea    0x1(%eax),%edx
  8014a5:	89 55 08             	mov    %edx,0x8(%ebp)
  8014a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ab:	8a 12                	mov    (%edx),%dl
  8014ad:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b2:	8a 00                	mov    (%eax),%al
  8014b4:	84 c0                	test   %al,%al
  8014b6:	74 03                	je     8014bb <strncpy+0x31>
			src++;
  8014b8:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014bb:	ff 45 fc             	incl   -0x4(%ebp)
  8014be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014c1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014c4:	72 d9                	jb     80149f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014c9:	c9                   	leave  
  8014ca:	c3                   	ret    

008014cb <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014cb:	55                   	push   %ebp
  8014cc:	89 e5                	mov    %esp,%ebp
  8014ce:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014d7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014db:	74 30                	je     80150d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8014dd:	eb 16                	jmp    8014f5 <strlcpy+0x2a>
			*dst++ = *src++;
  8014df:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e2:	8d 50 01             	lea    0x1(%eax),%edx
  8014e5:	89 55 08             	mov    %edx,0x8(%ebp)
  8014e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014eb:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014ee:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8014f1:	8a 12                	mov    (%edx),%dl
  8014f3:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8014f5:	ff 4d 10             	decl   0x10(%ebp)
  8014f8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014fc:	74 09                	je     801507 <strlcpy+0x3c>
  8014fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801501:	8a 00                	mov    (%eax),%al
  801503:	84 c0                	test   %al,%al
  801505:	75 d8                	jne    8014df <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801507:	8b 45 08             	mov    0x8(%ebp),%eax
  80150a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80150d:	8b 55 08             	mov    0x8(%ebp),%edx
  801510:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801513:	29 c2                	sub    %eax,%edx
  801515:	89 d0                	mov    %edx,%eax
}
  801517:	c9                   	leave  
  801518:	c3                   	ret    

00801519 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801519:	55                   	push   %ebp
  80151a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80151c:	eb 06                	jmp    801524 <strcmp+0xb>
		p++, q++;
  80151e:	ff 45 08             	incl   0x8(%ebp)
  801521:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801524:	8b 45 08             	mov    0x8(%ebp),%eax
  801527:	8a 00                	mov    (%eax),%al
  801529:	84 c0                	test   %al,%al
  80152b:	74 0e                	je     80153b <strcmp+0x22>
  80152d:	8b 45 08             	mov    0x8(%ebp),%eax
  801530:	8a 10                	mov    (%eax),%dl
  801532:	8b 45 0c             	mov    0xc(%ebp),%eax
  801535:	8a 00                	mov    (%eax),%al
  801537:	38 c2                	cmp    %al,%dl
  801539:	74 e3                	je     80151e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80153b:	8b 45 08             	mov    0x8(%ebp),%eax
  80153e:	8a 00                	mov    (%eax),%al
  801540:	0f b6 d0             	movzbl %al,%edx
  801543:	8b 45 0c             	mov    0xc(%ebp),%eax
  801546:	8a 00                	mov    (%eax),%al
  801548:	0f b6 c0             	movzbl %al,%eax
  80154b:	29 c2                	sub    %eax,%edx
  80154d:	89 d0                	mov    %edx,%eax
}
  80154f:	5d                   	pop    %ebp
  801550:	c3                   	ret    

00801551 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801551:	55                   	push   %ebp
  801552:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801554:	eb 09                	jmp    80155f <strncmp+0xe>
		n--, p++, q++;
  801556:	ff 4d 10             	decl   0x10(%ebp)
  801559:	ff 45 08             	incl   0x8(%ebp)
  80155c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80155f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801563:	74 17                	je     80157c <strncmp+0x2b>
  801565:	8b 45 08             	mov    0x8(%ebp),%eax
  801568:	8a 00                	mov    (%eax),%al
  80156a:	84 c0                	test   %al,%al
  80156c:	74 0e                	je     80157c <strncmp+0x2b>
  80156e:	8b 45 08             	mov    0x8(%ebp),%eax
  801571:	8a 10                	mov    (%eax),%dl
  801573:	8b 45 0c             	mov    0xc(%ebp),%eax
  801576:	8a 00                	mov    (%eax),%al
  801578:	38 c2                	cmp    %al,%dl
  80157a:	74 da                	je     801556 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80157c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801580:	75 07                	jne    801589 <strncmp+0x38>
		return 0;
  801582:	b8 00 00 00 00       	mov    $0x0,%eax
  801587:	eb 14                	jmp    80159d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801589:	8b 45 08             	mov    0x8(%ebp),%eax
  80158c:	8a 00                	mov    (%eax),%al
  80158e:	0f b6 d0             	movzbl %al,%edx
  801591:	8b 45 0c             	mov    0xc(%ebp),%eax
  801594:	8a 00                	mov    (%eax),%al
  801596:	0f b6 c0             	movzbl %al,%eax
  801599:	29 c2                	sub    %eax,%edx
  80159b:	89 d0                	mov    %edx,%eax
}
  80159d:	5d                   	pop    %ebp
  80159e:	c3                   	ret    

0080159f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80159f:	55                   	push   %ebp
  8015a0:	89 e5                	mov    %esp,%ebp
  8015a2:	83 ec 04             	sub    $0x4,%esp
  8015a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015ab:	eb 12                	jmp    8015bf <strchr+0x20>
		if (*s == c)
  8015ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b0:	8a 00                	mov    (%eax),%al
  8015b2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015b5:	75 05                	jne    8015bc <strchr+0x1d>
			return (char *) s;
  8015b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ba:	eb 11                	jmp    8015cd <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015bc:	ff 45 08             	incl   0x8(%ebp)
  8015bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c2:	8a 00                	mov    (%eax),%al
  8015c4:	84 c0                	test   %al,%al
  8015c6:	75 e5                	jne    8015ad <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015c8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015cd:	c9                   	leave  
  8015ce:	c3                   	ret    

008015cf <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015cf:	55                   	push   %ebp
  8015d0:	89 e5                	mov    %esp,%ebp
  8015d2:	83 ec 04             	sub    $0x4,%esp
  8015d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015db:	eb 0d                	jmp    8015ea <strfind+0x1b>
		if (*s == c)
  8015dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e0:	8a 00                	mov    (%eax),%al
  8015e2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015e5:	74 0e                	je     8015f5 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8015e7:	ff 45 08             	incl   0x8(%ebp)
  8015ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ed:	8a 00                	mov    (%eax),%al
  8015ef:	84 c0                	test   %al,%al
  8015f1:	75 ea                	jne    8015dd <strfind+0xe>
  8015f3:	eb 01                	jmp    8015f6 <strfind+0x27>
		if (*s == c)
			break;
  8015f5:	90                   	nop
	return (char *) s;
  8015f6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015f9:	c9                   	leave  
  8015fa:	c3                   	ret    

008015fb <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8015fb:	55                   	push   %ebp
  8015fc:	89 e5                	mov    %esp,%ebp
  8015fe:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801601:	8b 45 08             	mov    0x8(%ebp),%eax
  801604:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801607:	8b 45 10             	mov    0x10(%ebp),%eax
  80160a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80160d:	eb 0e                	jmp    80161d <memset+0x22>
		*p++ = c;
  80160f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801612:	8d 50 01             	lea    0x1(%eax),%edx
  801615:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801618:	8b 55 0c             	mov    0xc(%ebp),%edx
  80161b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80161d:	ff 4d f8             	decl   -0x8(%ebp)
  801620:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801624:	79 e9                	jns    80160f <memset+0x14>
		*p++ = c;

	return v;
  801626:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801629:	c9                   	leave  
  80162a:	c3                   	ret    

0080162b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80162b:	55                   	push   %ebp
  80162c:	89 e5                	mov    %esp,%ebp
  80162e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801631:	8b 45 0c             	mov    0xc(%ebp),%eax
  801634:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801637:	8b 45 08             	mov    0x8(%ebp),%eax
  80163a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80163d:	eb 16                	jmp    801655 <memcpy+0x2a>
		*d++ = *s++;
  80163f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801642:	8d 50 01             	lea    0x1(%eax),%edx
  801645:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801648:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80164b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80164e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801651:	8a 12                	mov    (%edx),%dl
  801653:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801655:	8b 45 10             	mov    0x10(%ebp),%eax
  801658:	8d 50 ff             	lea    -0x1(%eax),%edx
  80165b:	89 55 10             	mov    %edx,0x10(%ebp)
  80165e:	85 c0                	test   %eax,%eax
  801660:	75 dd                	jne    80163f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801662:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801665:	c9                   	leave  
  801666:	c3                   	ret    

00801667 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801667:	55                   	push   %ebp
  801668:	89 e5                	mov    %esp,%ebp
  80166a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80166d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801670:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801673:	8b 45 08             	mov    0x8(%ebp),%eax
  801676:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801679:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80167c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80167f:	73 50                	jae    8016d1 <memmove+0x6a>
  801681:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801684:	8b 45 10             	mov    0x10(%ebp),%eax
  801687:	01 d0                	add    %edx,%eax
  801689:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80168c:	76 43                	jbe    8016d1 <memmove+0x6a>
		s += n;
  80168e:	8b 45 10             	mov    0x10(%ebp),%eax
  801691:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801694:	8b 45 10             	mov    0x10(%ebp),%eax
  801697:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80169a:	eb 10                	jmp    8016ac <memmove+0x45>
			*--d = *--s;
  80169c:	ff 4d f8             	decl   -0x8(%ebp)
  80169f:	ff 4d fc             	decl   -0x4(%ebp)
  8016a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016a5:	8a 10                	mov    (%eax),%dl
  8016a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016aa:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8016af:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016b2:	89 55 10             	mov    %edx,0x10(%ebp)
  8016b5:	85 c0                	test   %eax,%eax
  8016b7:	75 e3                	jne    80169c <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016b9:	eb 23                	jmp    8016de <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016be:	8d 50 01             	lea    0x1(%eax),%edx
  8016c1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016c4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016c7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016ca:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016cd:	8a 12                	mov    (%edx),%dl
  8016cf:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016d7:	89 55 10             	mov    %edx,0x10(%ebp)
  8016da:	85 c0                	test   %eax,%eax
  8016dc:	75 dd                	jne    8016bb <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016de:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016e1:	c9                   	leave  
  8016e2:	c3                   	ret    

008016e3 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8016e3:	55                   	push   %ebp
  8016e4:	89 e5                	mov    %esp,%ebp
  8016e6:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8016e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8016ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f2:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8016f5:	eb 2a                	jmp    801721 <memcmp+0x3e>
		if (*s1 != *s2)
  8016f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016fa:	8a 10                	mov    (%eax),%dl
  8016fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ff:	8a 00                	mov    (%eax),%al
  801701:	38 c2                	cmp    %al,%dl
  801703:	74 16                	je     80171b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801705:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801708:	8a 00                	mov    (%eax),%al
  80170a:	0f b6 d0             	movzbl %al,%edx
  80170d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801710:	8a 00                	mov    (%eax),%al
  801712:	0f b6 c0             	movzbl %al,%eax
  801715:	29 c2                	sub    %eax,%edx
  801717:	89 d0                	mov    %edx,%eax
  801719:	eb 18                	jmp    801733 <memcmp+0x50>
		s1++, s2++;
  80171b:	ff 45 fc             	incl   -0x4(%ebp)
  80171e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801721:	8b 45 10             	mov    0x10(%ebp),%eax
  801724:	8d 50 ff             	lea    -0x1(%eax),%edx
  801727:	89 55 10             	mov    %edx,0x10(%ebp)
  80172a:	85 c0                	test   %eax,%eax
  80172c:	75 c9                	jne    8016f7 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80172e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801733:	c9                   	leave  
  801734:	c3                   	ret    

00801735 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801735:	55                   	push   %ebp
  801736:	89 e5                	mov    %esp,%ebp
  801738:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80173b:	8b 55 08             	mov    0x8(%ebp),%edx
  80173e:	8b 45 10             	mov    0x10(%ebp),%eax
  801741:	01 d0                	add    %edx,%eax
  801743:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801746:	eb 15                	jmp    80175d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801748:	8b 45 08             	mov    0x8(%ebp),%eax
  80174b:	8a 00                	mov    (%eax),%al
  80174d:	0f b6 d0             	movzbl %al,%edx
  801750:	8b 45 0c             	mov    0xc(%ebp),%eax
  801753:	0f b6 c0             	movzbl %al,%eax
  801756:	39 c2                	cmp    %eax,%edx
  801758:	74 0d                	je     801767 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80175a:	ff 45 08             	incl   0x8(%ebp)
  80175d:	8b 45 08             	mov    0x8(%ebp),%eax
  801760:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801763:	72 e3                	jb     801748 <memfind+0x13>
  801765:	eb 01                	jmp    801768 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801767:	90                   	nop
	return (void *) s;
  801768:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80176b:	c9                   	leave  
  80176c:	c3                   	ret    

0080176d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80176d:	55                   	push   %ebp
  80176e:	89 e5                	mov    %esp,%ebp
  801770:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801773:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80177a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801781:	eb 03                	jmp    801786 <strtol+0x19>
		s++;
  801783:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801786:	8b 45 08             	mov    0x8(%ebp),%eax
  801789:	8a 00                	mov    (%eax),%al
  80178b:	3c 20                	cmp    $0x20,%al
  80178d:	74 f4                	je     801783 <strtol+0x16>
  80178f:	8b 45 08             	mov    0x8(%ebp),%eax
  801792:	8a 00                	mov    (%eax),%al
  801794:	3c 09                	cmp    $0x9,%al
  801796:	74 eb                	je     801783 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801798:	8b 45 08             	mov    0x8(%ebp),%eax
  80179b:	8a 00                	mov    (%eax),%al
  80179d:	3c 2b                	cmp    $0x2b,%al
  80179f:	75 05                	jne    8017a6 <strtol+0x39>
		s++;
  8017a1:	ff 45 08             	incl   0x8(%ebp)
  8017a4:	eb 13                	jmp    8017b9 <strtol+0x4c>
	else if (*s == '-')
  8017a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a9:	8a 00                	mov    (%eax),%al
  8017ab:	3c 2d                	cmp    $0x2d,%al
  8017ad:	75 0a                	jne    8017b9 <strtol+0x4c>
		s++, neg = 1;
  8017af:	ff 45 08             	incl   0x8(%ebp)
  8017b2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017b9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017bd:	74 06                	je     8017c5 <strtol+0x58>
  8017bf:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017c3:	75 20                	jne    8017e5 <strtol+0x78>
  8017c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c8:	8a 00                	mov    (%eax),%al
  8017ca:	3c 30                	cmp    $0x30,%al
  8017cc:	75 17                	jne    8017e5 <strtol+0x78>
  8017ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d1:	40                   	inc    %eax
  8017d2:	8a 00                	mov    (%eax),%al
  8017d4:	3c 78                	cmp    $0x78,%al
  8017d6:	75 0d                	jne    8017e5 <strtol+0x78>
		s += 2, base = 16;
  8017d8:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017dc:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8017e3:	eb 28                	jmp    80180d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8017e5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017e9:	75 15                	jne    801800 <strtol+0x93>
  8017eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ee:	8a 00                	mov    (%eax),%al
  8017f0:	3c 30                	cmp    $0x30,%al
  8017f2:	75 0c                	jne    801800 <strtol+0x93>
		s++, base = 8;
  8017f4:	ff 45 08             	incl   0x8(%ebp)
  8017f7:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8017fe:	eb 0d                	jmp    80180d <strtol+0xa0>
	else if (base == 0)
  801800:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801804:	75 07                	jne    80180d <strtol+0xa0>
		base = 10;
  801806:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80180d:	8b 45 08             	mov    0x8(%ebp),%eax
  801810:	8a 00                	mov    (%eax),%al
  801812:	3c 2f                	cmp    $0x2f,%al
  801814:	7e 19                	jle    80182f <strtol+0xc2>
  801816:	8b 45 08             	mov    0x8(%ebp),%eax
  801819:	8a 00                	mov    (%eax),%al
  80181b:	3c 39                	cmp    $0x39,%al
  80181d:	7f 10                	jg     80182f <strtol+0xc2>
			dig = *s - '0';
  80181f:	8b 45 08             	mov    0x8(%ebp),%eax
  801822:	8a 00                	mov    (%eax),%al
  801824:	0f be c0             	movsbl %al,%eax
  801827:	83 e8 30             	sub    $0x30,%eax
  80182a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80182d:	eb 42                	jmp    801871 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80182f:	8b 45 08             	mov    0x8(%ebp),%eax
  801832:	8a 00                	mov    (%eax),%al
  801834:	3c 60                	cmp    $0x60,%al
  801836:	7e 19                	jle    801851 <strtol+0xe4>
  801838:	8b 45 08             	mov    0x8(%ebp),%eax
  80183b:	8a 00                	mov    (%eax),%al
  80183d:	3c 7a                	cmp    $0x7a,%al
  80183f:	7f 10                	jg     801851 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801841:	8b 45 08             	mov    0x8(%ebp),%eax
  801844:	8a 00                	mov    (%eax),%al
  801846:	0f be c0             	movsbl %al,%eax
  801849:	83 e8 57             	sub    $0x57,%eax
  80184c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80184f:	eb 20                	jmp    801871 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801851:	8b 45 08             	mov    0x8(%ebp),%eax
  801854:	8a 00                	mov    (%eax),%al
  801856:	3c 40                	cmp    $0x40,%al
  801858:	7e 39                	jle    801893 <strtol+0x126>
  80185a:	8b 45 08             	mov    0x8(%ebp),%eax
  80185d:	8a 00                	mov    (%eax),%al
  80185f:	3c 5a                	cmp    $0x5a,%al
  801861:	7f 30                	jg     801893 <strtol+0x126>
			dig = *s - 'A' + 10;
  801863:	8b 45 08             	mov    0x8(%ebp),%eax
  801866:	8a 00                	mov    (%eax),%al
  801868:	0f be c0             	movsbl %al,%eax
  80186b:	83 e8 37             	sub    $0x37,%eax
  80186e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801871:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801874:	3b 45 10             	cmp    0x10(%ebp),%eax
  801877:	7d 19                	jge    801892 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801879:	ff 45 08             	incl   0x8(%ebp)
  80187c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80187f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801883:	89 c2                	mov    %eax,%edx
  801885:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801888:	01 d0                	add    %edx,%eax
  80188a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80188d:	e9 7b ff ff ff       	jmp    80180d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801892:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801893:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801897:	74 08                	je     8018a1 <strtol+0x134>
		*endptr = (char *) s;
  801899:	8b 45 0c             	mov    0xc(%ebp),%eax
  80189c:	8b 55 08             	mov    0x8(%ebp),%edx
  80189f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8018a1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018a5:	74 07                	je     8018ae <strtol+0x141>
  8018a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018aa:	f7 d8                	neg    %eax
  8018ac:	eb 03                	jmp    8018b1 <strtol+0x144>
  8018ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018b1:	c9                   	leave  
  8018b2:	c3                   	ret    

008018b3 <ltostr>:

void
ltostr(long value, char *str)
{
  8018b3:	55                   	push   %ebp
  8018b4:	89 e5                	mov    %esp,%ebp
  8018b6:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018c0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018c7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018cb:	79 13                	jns    8018e0 <ltostr+0x2d>
	{
		neg = 1;
  8018cd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d7:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018da:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018dd:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e3:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8018e8:	99                   	cltd   
  8018e9:	f7 f9                	idiv   %ecx
  8018eb:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8018ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018f1:	8d 50 01             	lea    0x1(%eax),%edx
  8018f4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018f7:	89 c2                	mov    %eax,%edx
  8018f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018fc:	01 d0                	add    %edx,%eax
  8018fe:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801901:	83 c2 30             	add    $0x30,%edx
  801904:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801906:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801909:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80190e:	f7 e9                	imul   %ecx
  801910:	c1 fa 02             	sar    $0x2,%edx
  801913:	89 c8                	mov    %ecx,%eax
  801915:	c1 f8 1f             	sar    $0x1f,%eax
  801918:	29 c2                	sub    %eax,%edx
  80191a:	89 d0                	mov    %edx,%eax
  80191c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80191f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801922:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801927:	f7 e9                	imul   %ecx
  801929:	c1 fa 02             	sar    $0x2,%edx
  80192c:	89 c8                	mov    %ecx,%eax
  80192e:	c1 f8 1f             	sar    $0x1f,%eax
  801931:	29 c2                	sub    %eax,%edx
  801933:	89 d0                	mov    %edx,%eax
  801935:	c1 e0 02             	shl    $0x2,%eax
  801938:	01 d0                	add    %edx,%eax
  80193a:	01 c0                	add    %eax,%eax
  80193c:	29 c1                	sub    %eax,%ecx
  80193e:	89 ca                	mov    %ecx,%edx
  801940:	85 d2                	test   %edx,%edx
  801942:	75 9c                	jne    8018e0 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801944:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80194b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80194e:	48                   	dec    %eax
  80194f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801952:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801956:	74 3d                	je     801995 <ltostr+0xe2>
		start = 1 ;
  801958:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80195f:	eb 34                	jmp    801995 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801961:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801964:	8b 45 0c             	mov    0xc(%ebp),%eax
  801967:	01 d0                	add    %edx,%eax
  801969:	8a 00                	mov    (%eax),%al
  80196b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80196e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801971:	8b 45 0c             	mov    0xc(%ebp),%eax
  801974:	01 c2                	add    %eax,%edx
  801976:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801979:	8b 45 0c             	mov    0xc(%ebp),%eax
  80197c:	01 c8                	add    %ecx,%eax
  80197e:	8a 00                	mov    (%eax),%al
  801980:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801982:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801985:	8b 45 0c             	mov    0xc(%ebp),%eax
  801988:	01 c2                	add    %eax,%edx
  80198a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80198d:	88 02                	mov    %al,(%edx)
		start++ ;
  80198f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801992:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801995:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801998:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80199b:	7c c4                	jl     801961 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80199d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8019a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a3:	01 d0                	add    %edx,%eax
  8019a5:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8019a8:	90                   	nop
  8019a9:	c9                   	leave  
  8019aa:	c3                   	ret    

008019ab <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8019ab:	55                   	push   %ebp
  8019ac:	89 e5                	mov    %esp,%ebp
  8019ae:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8019b1:	ff 75 08             	pushl  0x8(%ebp)
  8019b4:	e8 54 fa ff ff       	call   80140d <strlen>
  8019b9:	83 c4 04             	add    $0x4,%esp
  8019bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019bf:	ff 75 0c             	pushl  0xc(%ebp)
  8019c2:	e8 46 fa ff ff       	call   80140d <strlen>
  8019c7:	83 c4 04             	add    $0x4,%esp
  8019ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019d4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019db:	eb 17                	jmp    8019f4 <strcconcat+0x49>
		final[s] = str1[s] ;
  8019dd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8019e3:	01 c2                	add    %eax,%edx
  8019e5:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019eb:	01 c8                	add    %ecx,%eax
  8019ed:	8a 00                	mov    (%eax),%al
  8019ef:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8019f1:	ff 45 fc             	incl   -0x4(%ebp)
  8019f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019f7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8019fa:	7c e1                	jl     8019dd <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8019fc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a03:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a0a:	eb 1f                	jmp    801a2b <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a0c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a0f:	8d 50 01             	lea    0x1(%eax),%edx
  801a12:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a15:	89 c2                	mov    %eax,%edx
  801a17:	8b 45 10             	mov    0x10(%ebp),%eax
  801a1a:	01 c2                	add    %eax,%edx
  801a1c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a22:	01 c8                	add    %ecx,%eax
  801a24:	8a 00                	mov    (%eax),%al
  801a26:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a28:	ff 45 f8             	incl   -0x8(%ebp)
  801a2b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a2e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a31:	7c d9                	jl     801a0c <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a33:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a36:	8b 45 10             	mov    0x10(%ebp),%eax
  801a39:	01 d0                	add    %edx,%eax
  801a3b:	c6 00 00             	movb   $0x0,(%eax)
}
  801a3e:	90                   	nop
  801a3f:	c9                   	leave  
  801a40:	c3                   	ret    

00801a41 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a41:	55                   	push   %ebp
  801a42:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a44:	8b 45 14             	mov    0x14(%ebp),%eax
  801a47:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a4d:	8b 45 14             	mov    0x14(%ebp),%eax
  801a50:	8b 00                	mov    (%eax),%eax
  801a52:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a59:	8b 45 10             	mov    0x10(%ebp),%eax
  801a5c:	01 d0                	add    %edx,%eax
  801a5e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a64:	eb 0c                	jmp    801a72 <strsplit+0x31>
			*string++ = 0;
  801a66:	8b 45 08             	mov    0x8(%ebp),%eax
  801a69:	8d 50 01             	lea    0x1(%eax),%edx
  801a6c:	89 55 08             	mov    %edx,0x8(%ebp)
  801a6f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a72:	8b 45 08             	mov    0x8(%ebp),%eax
  801a75:	8a 00                	mov    (%eax),%al
  801a77:	84 c0                	test   %al,%al
  801a79:	74 18                	je     801a93 <strsplit+0x52>
  801a7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7e:	8a 00                	mov    (%eax),%al
  801a80:	0f be c0             	movsbl %al,%eax
  801a83:	50                   	push   %eax
  801a84:	ff 75 0c             	pushl  0xc(%ebp)
  801a87:	e8 13 fb ff ff       	call   80159f <strchr>
  801a8c:	83 c4 08             	add    $0x8,%esp
  801a8f:	85 c0                	test   %eax,%eax
  801a91:	75 d3                	jne    801a66 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801a93:	8b 45 08             	mov    0x8(%ebp),%eax
  801a96:	8a 00                	mov    (%eax),%al
  801a98:	84 c0                	test   %al,%al
  801a9a:	74 5a                	je     801af6 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801a9c:	8b 45 14             	mov    0x14(%ebp),%eax
  801a9f:	8b 00                	mov    (%eax),%eax
  801aa1:	83 f8 0f             	cmp    $0xf,%eax
  801aa4:	75 07                	jne    801aad <strsplit+0x6c>
		{
			return 0;
  801aa6:	b8 00 00 00 00       	mov    $0x0,%eax
  801aab:	eb 66                	jmp    801b13 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801aad:	8b 45 14             	mov    0x14(%ebp),%eax
  801ab0:	8b 00                	mov    (%eax),%eax
  801ab2:	8d 48 01             	lea    0x1(%eax),%ecx
  801ab5:	8b 55 14             	mov    0x14(%ebp),%edx
  801ab8:	89 0a                	mov    %ecx,(%edx)
  801aba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ac1:	8b 45 10             	mov    0x10(%ebp),%eax
  801ac4:	01 c2                	add    %eax,%edx
  801ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac9:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801acb:	eb 03                	jmp    801ad0 <strsplit+0x8f>
			string++;
  801acd:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ad0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad3:	8a 00                	mov    (%eax),%al
  801ad5:	84 c0                	test   %al,%al
  801ad7:	74 8b                	je     801a64 <strsplit+0x23>
  801ad9:	8b 45 08             	mov    0x8(%ebp),%eax
  801adc:	8a 00                	mov    (%eax),%al
  801ade:	0f be c0             	movsbl %al,%eax
  801ae1:	50                   	push   %eax
  801ae2:	ff 75 0c             	pushl  0xc(%ebp)
  801ae5:	e8 b5 fa ff ff       	call   80159f <strchr>
  801aea:	83 c4 08             	add    $0x8,%esp
  801aed:	85 c0                	test   %eax,%eax
  801aef:	74 dc                	je     801acd <strsplit+0x8c>
			string++;
	}
  801af1:	e9 6e ff ff ff       	jmp    801a64 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801af6:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801af7:	8b 45 14             	mov    0x14(%ebp),%eax
  801afa:	8b 00                	mov    (%eax),%eax
  801afc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b03:	8b 45 10             	mov    0x10(%ebp),%eax
  801b06:	01 d0                	add    %edx,%eax
  801b08:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b0e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b13:	c9                   	leave  
  801b14:	c3                   	ret    

00801b15 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801b15:	55                   	push   %ebp
  801b16:	89 e5                	mov    %esp,%ebp
  801b18:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801b1b:	83 ec 04             	sub    $0x4,%esp
  801b1e:	68 64 2c 80 00       	push   $0x802c64
  801b23:	6a 15                	push   $0x15
  801b25:	68 89 2c 80 00       	push   $0x802c89
  801b2a:	e8 9f ed ff ff       	call   8008ce <_panic>

00801b2f <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801b2f:	55                   	push   %ebp
  801b30:	89 e5                	mov    %esp,%ebp
  801b32:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801b35:	83 ec 04             	sub    $0x4,%esp
  801b38:	68 98 2c 80 00       	push   $0x802c98
  801b3d:	6a 2e                	push   $0x2e
  801b3f:	68 89 2c 80 00       	push   $0x802c89
  801b44:	e8 85 ed ff ff       	call   8008ce <_panic>

00801b49 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801b49:	55                   	push   %ebp
  801b4a:	89 e5                	mov    %esp,%ebp
  801b4c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b4f:	83 ec 04             	sub    $0x4,%esp
  801b52:	68 bc 2c 80 00       	push   $0x802cbc
  801b57:	6a 4c                	push   $0x4c
  801b59:	68 89 2c 80 00       	push   $0x802c89
  801b5e:	e8 6b ed ff ff       	call   8008ce <_panic>

00801b63 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801b63:	55                   	push   %ebp
  801b64:	89 e5                	mov    %esp,%ebp
  801b66:	83 ec 18             	sub    $0x18,%esp
  801b69:	8b 45 10             	mov    0x10(%ebp),%eax
  801b6c:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801b6f:	83 ec 04             	sub    $0x4,%esp
  801b72:	68 bc 2c 80 00       	push   $0x802cbc
  801b77:	6a 57                	push   $0x57
  801b79:	68 89 2c 80 00       	push   $0x802c89
  801b7e:	e8 4b ed ff ff       	call   8008ce <_panic>

00801b83 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801b83:	55                   	push   %ebp
  801b84:	89 e5                	mov    %esp,%ebp
  801b86:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b89:	83 ec 04             	sub    $0x4,%esp
  801b8c:	68 bc 2c 80 00       	push   $0x802cbc
  801b91:	6a 5d                	push   $0x5d
  801b93:	68 89 2c 80 00       	push   $0x802c89
  801b98:	e8 31 ed ff ff       	call   8008ce <_panic>

00801b9d <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801b9d:	55                   	push   %ebp
  801b9e:	89 e5                	mov    %esp,%ebp
  801ba0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ba3:	83 ec 04             	sub    $0x4,%esp
  801ba6:	68 bc 2c 80 00       	push   $0x802cbc
  801bab:	6a 63                	push   $0x63
  801bad:	68 89 2c 80 00       	push   $0x802c89
  801bb2:	e8 17 ed ff ff       	call   8008ce <_panic>

00801bb7 <expand>:
}

void expand(uint32 newSize)
{
  801bb7:	55                   	push   %ebp
  801bb8:	89 e5                	mov    %esp,%ebp
  801bba:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bbd:	83 ec 04             	sub    $0x4,%esp
  801bc0:	68 bc 2c 80 00       	push   $0x802cbc
  801bc5:	6a 68                	push   $0x68
  801bc7:	68 89 2c 80 00       	push   $0x802c89
  801bcc:	e8 fd ec ff ff       	call   8008ce <_panic>

00801bd1 <shrink>:
}
void shrink(uint32 newSize)
{
  801bd1:	55                   	push   %ebp
  801bd2:	89 e5                	mov    %esp,%ebp
  801bd4:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bd7:	83 ec 04             	sub    $0x4,%esp
  801bda:	68 bc 2c 80 00       	push   $0x802cbc
  801bdf:	6a 6c                	push   $0x6c
  801be1:	68 89 2c 80 00       	push   $0x802c89
  801be6:	e8 e3 ec ff ff       	call   8008ce <_panic>

00801beb <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801beb:	55                   	push   %ebp
  801bec:	89 e5                	mov    %esp,%ebp
  801bee:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bf1:	83 ec 04             	sub    $0x4,%esp
  801bf4:	68 bc 2c 80 00       	push   $0x802cbc
  801bf9:	6a 71                	push   $0x71
  801bfb:	68 89 2c 80 00       	push   $0x802c89
  801c00:	e8 c9 ec ff ff       	call   8008ce <_panic>

00801c05 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c05:	55                   	push   %ebp
  801c06:	89 e5                	mov    %esp,%ebp
  801c08:	57                   	push   %edi
  801c09:	56                   	push   %esi
  801c0a:	53                   	push   %ebx
  801c0b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c11:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c14:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c17:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c1a:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c1d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c20:	cd 30                	int    $0x30
  801c22:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c25:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c28:	83 c4 10             	add    $0x10,%esp
  801c2b:	5b                   	pop    %ebx
  801c2c:	5e                   	pop    %esi
  801c2d:	5f                   	pop    %edi
  801c2e:	5d                   	pop    %ebp
  801c2f:	c3                   	ret    

00801c30 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801c30:	55                   	push   %ebp
  801c31:	89 e5                	mov    %esp,%ebp
  801c33:	83 ec 04             	sub    $0x4,%esp
  801c36:	8b 45 10             	mov    0x10(%ebp),%eax
  801c39:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c3c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c40:	8b 45 08             	mov    0x8(%ebp),%eax
  801c43:	6a 00                	push   $0x0
  801c45:	6a 00                	push   $0x0
  801c47:	52                   	push   %edx
  801c48:	ff 75 0c             	pushl  0xc(%ebp)
  801c4b:	50                   	push   %eax
  801c4c:	6a 00                	push   $0x0
  801c4e:	e8 b2 ff ff ff       	call   801c05 <syscall>
  801c53:	83 c4 18             	add    $0x18,%esp
}
  801c56:	90                   	nop
  801c57:	c9                   	leave  
  801c58:	c3                   	ret    

00801c59 <sys_cgetc>:

int
sys_cgetc(void)
{
  801c59:	55                   	push   %ebp
  801c5a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c5c:	6a 00                	push   $0x0
  801c5e:	6a 00                	push   $0x0
  801c60:	6a 00                	push   $0x0
  801c62:	6a 00                	push   $0x0
  801c64:	6a 00                	push   $0x0
  801c66:	6a 01                	push   $0x1
  801c68:	e8 98 ff ff ff       	call   801c05 <syscall>
  801c6d:	83 c4 18             	add    $0x18,%esp
}
  801c70:	c9                   	leave  
  801c71:	c3                   	ret    

00801c72 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c72:	55                   	push   %ebp
  801c73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801c75:	8b 45 08             	mov    0x8(%ebp),%eax
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 00                	push   $0x0
  801c80:	50                   	push   %eax
  801c81:	6a 05                	push   $0x5
  801c83:	e8 7d ff ff ff       	call   801c05 <syscall>
  801c88:	83 c4 18             	add    $0x18,%esp
}
  801c8b:	c9                   	leave  
  801c8c:	c3                   	ret    

00801c8d <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c8d:	55                   	push   %ebp
  801c8e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801c90:	6a 00                	push   $0x0
  801c92:	6a 00                	push   $0x0
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	6a 00                	push   $0x0
  801c9a:	6a 02                	push   $0x2
  801c9c:	e8 64 ff ff ff       	call   801c05 <syscall>
  801ca1:	83 c4 18             	add    $0x18,%esp
}
  801ca4:	c9                   	leave  
  801ca5:	c3                   	ret    

00801ca6 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ca6:	55                   	push   %ebp
  801ca7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801ca9:	6a 00                	push   $0x0
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 03                	push   $0x3
  801cb5:	e8 4b ff ff ff       	call   801c05 <syscall>
  801cba:	83 c4 18             	add    $0x18,%esp
}
  801cbd:	c9                   	leave  
  801cbe:	c3                   	ret    

00801cbf <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801cbf:	55                   	push   %ebp
  801cc0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 04                	push   $0x4
  801cce:	e8 32 ff ff ff       	call   801c05 <syscall>
  801cd3:	83 c4 18             	add    $0x18,%esp
}
  801cd6:	c9                   	leave  
  801cd7:	c3                   	ret    

00801cd8 <sys_env_exit>:


void sys_env_exit(void)
{
  801cd8:	55                   	push   %ebp
  801cd9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 06                	push   $0x6
  801ce7:	e8 19 ff ff ff       	call   801c05 <syscall>
  801cec:	83 c4 18             	add    $0x18,%esp
}
  801cef:	90                   	nop
  801cf0:	c9                   	leave  
  801cf1:	c3                   	ret    

00801cf2 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801cf2:	55                   	push   %ebp
  801cf3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801cf5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cf8:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfb:	6a 00                	push   $0x0
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 00                	push   $0x0
  801d01:	52                   	push   %edx
  801d02:	50                   	push   %eax
  801d03:	6a 07                	push   $0x7
  801d05:	e8 fb fe ff ff       	call   801c05 <syscall>
  801d0a:	83 c4 18             	add    $0x18,%esp
}
  801d0d:	c9                   	leave  
  801d0e:	c3                   	ret    

00801d0f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d0f:	55                   	push   %ebp
  801d10:	89 e5                	mov    %esp,%ebp
  801d12:	56                   	push   %esi
  801d13:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d14:	8b 75 18             	mov    0x18(%ebp),%esi
  801d17:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d1a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d20:	8b 45 08             	mov    0x8(%ebp),%eax
  801d23:	56                   	push   %esi
  801d24:	53                   	push   %ebx
  801d25:	51                   	push   %ecx
  801d26:	52                   	push   %edx
  801d27:	50                   	push   %eax
  801d28:	6a 08                	push   $0x8
  801d2a:	e8 d6 fe ff ff       	call   801c05 <syscall>
  801d2f:	83 c4 18             	add    $0x18,%esp
}
  801d32:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d35:	5b                   	pop    %ebx
  801d36:	5e                   	pop    %esi
  801d37:	5d                   	pop    %ebp
  801d38:	c3                   	ret    

00801d39 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801d39:	55                   	push   %ebp
  801d3a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d3c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d42:	6a 00                	push   $0x0
  801d44:	6a 00                	push   $0x0
  801d46:	6a 00                	push   $0x0
  801d48:	52                   	push   %edx
  801d49:	50                   	push   %eax
  801d4a:	6a 09                	push   $0x9
  801d4c:	e8 b4 fe ff ff       	call   801c05 <syscall>
  801d51:	83 c4 18             	add    $0x18,%esp
}
  801d54:	c9                   	leave  
  801d55:	c3                   	ret    

00801d56 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d56:	55                   	push   %ebp
  801d57:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d59:	6a 00                	push   $0x0
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 00                	push   $0x0
  801d5f:	ff 75 0c             	pushl  0xc(%ebp)
  801d62:	ff 75 08             	pushl  0x8(%ebp)
  801d65:	6a 0a                	push   $0xa
  801d67:	e8 99 fe ff ff       	call   801c05 <syscall>
  801d6c:	83 c4 18             	add    $0x18,%esp
}
  801d6f:	c9                   	leave  
  801d70:	c3                   	ret    

00801d71 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d71:	55                   	push   %ebp
  801d72:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d74:	6a 00                	push   $0x0
  801d76:	6a 00                	push   $0x0
  801d78:	6a 00                	push   $0x0
  801d7a:	6a 00                	push   $0x0
  801d7c:	6a 00                	push   $0x0
  801d7e:	6a 0b                	push   $0xb
  801d80:	e8 80 fe ff ff       	call   801c05 <syscall>
  801d85:	83 c4 18             	add    $0x18,%esp
}
  801d88:	c9                   	leave  
  801d89:	c3                   	ret    

00801d8a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d8a:	55                   	push   %ebp
  801d8b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d8d:	6a 00                	push   $0x0
  801d8f:	6a 00                	push   $0x0
  801d91:	6a 00                	push   $0x0
  801d93:	6a 00                	push   $0x0
  801d95:	6a 00                	push   $0x0
  801d97:	6a 0c                	push   $0xc
  801d99:	e8 67 fe ff ff       	call   801c05 <syscall>
  801d9e:	83 c4 18             	add    $0x18,%esp
}
  801da1:	c9                   	leave  
  801da2:	c3                   	ret    

00801da3 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801da3:	55                   	push   %ebp
  801da4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801da6:	6a 00                	push   $0x0
  801da8:	6a 00                	push   $0x0
  801daa:	6a 00                	push   $0x0
  801dac:	6a 00                	push   $0x0
  801dae:	6a 00                	push   $0x0
  801db0:	6a 0d                	push   $0xd
  801db2:	e8 4e fe ff ff       	call   801c05 <syscall>
  801db7:	83 c4 18             	add    $0x18,%esp
}
  801dba:	c9                   	leave  
  801dbb:	c3                   	ret    

00801dbc <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801dbc:	55                   	push   %ebp
  801dbd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801dbf:	6a 00                	push   $0x0
  801dc1:	6a 00                	push   $0x0
  801dc3:	6a 00                	push   $0x0
  801dc5:	ff 75 0c             	pushl  0xc(%ebp)
  801dc8:	ff 75 08             	pushl  0x8(%ebp)
  801dcb:	6a 11                	push   $0x11
  801dcd:	e8 33 fe ff ff       	call   801c05 <syscall>
  801dd2:	83 c4 18             	add    $0x18,%esp
	return;
  801dd5:	90                   	nop
}
  801dd6:	c9                   	leave  
  801dd7:	c3                   	ret    

00801dd8 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801dd8:	55                   	push   %ebp
  801dd9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 00                	push   $0x0
  801de1:	ff 75 0c             	pushl  0xc(%ebp)
  801de4:	ff 75 08             	pushl  0x8(%ebp)
  801de7:	6a 12                	push   $0x12
  801de9:	e8 17 fe ff ff       	call   801c05 <syscall>
  801dee:	83 c4 18             	add    $0x18,%esp
	return ;
  801df1:	90                   	nop
}
  801df2:	c9                   	leave  
  801df3:	c3                   	ret    

00801df4 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801df4:	55                   	push   %ebp
  801df5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 00                	push   $0x0
  801dff:	6a 00                	push   $0x0
  801e01:	6a 0e                	push   $0xe
  801e03:	e8 fd fd ff ff       	call   801c05 <syscall>
  801e08:	83 c4 18             	add    $0x18,%esp
}
  801e0b:	c9                   	leave  
  801e0c:	c3                   	ret    

00801e0d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e0d:	55                   	push   %ebp
  801e0e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e10:	6a 00                	push   $0x0
  801e12:	6a 00                	push   $0x0
  801e14:	6a 00                	push   $0x0
  801e16:	6a 00                	push   $0x0
  801e18:	ff 75 08             	pushl  0x8(%ebp)
  801e1b:	6a 0f                	push   $0xf
  801e1d:	e8 e3 fd ff ff       	call   801c05 <syscall>
  801e22:	83 c4 18             	add    $0x18,%esp
}
  801e25:	c9                   	leave  
  801e26:	c3                   	ret    

00801e27 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e27:	55                   	push   %ebp
  801e28:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e2a:	6a 00                	push   $0x0
  801e2c:	6a 00                	push   $0x0
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 10                	push   $0x10
  801e36:	e8 ca fd ff ff       	call   801c05 <syscall>
  801e3b:	83 c4 18             	add    $0x18,%esp
}
  801e3e:	90                   	nop
  801e3f:	c9                   	leave  
  801e40:	c3                   	ret    

00801e41 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801e41:	55                   	push   %ebp
  801e42:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801e44:	6a 00                	push   $0x0
  801e46:	6a 00                	push   $0x0
  801e48:	6a 00                	push   $0x0
  801e4a:	6a 00                	push   $0x0
  801e4c:	6a 00                	push   $0x0
  801e4e:	6a 14                	push   $0x14
  801e50:	e8 b0 fd ff ff       	call   801c05 <syscall>
  801e55:	83 c4 18             	add    $0x18,%esp
}
  801e58:	90                   	nop
  801e59:	c9                   	leave  
  801e5a:	c3                   	ret    

00801e5b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e5b:	55                   	push   %ebp
  801e5c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e5e:	6a 00                	push   $0x0
  801e60:	6a 00                	push   $0x0
  801e62:	6a 00                	push   $0x0
  801e64:	6a 00                	push   $0x0
  801e66:	6a 00                	push   $0x0
  801e68:	6a 15                	push   $0x15
  801e6a:	e8 96 fd ff ff       	call   801c05 <syscall>
  801e6f:	83 c4 18             	add    $0x18,%esp
}
  801e72:	90                   	nop
  801e73:	c9                   	leave  
  801e74:	c3                   	ret    

00801e75 <sys_cputc>:


void
sys_cputc(const char c)
{
  801e75:	55                   	push   %ebp
  801e76:	89 e5                	mov    %esp,%ebp
  801e78:	83 ec 04             	sub    $0x4,%esp
  801e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e7e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e81:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e85:	6a 00                	push   $0x0
  801e87:	6a 00                	push   $0x0
  801e89:	6a 00                	push   $0x0
  801e8b:	6a 00                	push   $0x0
  801e8d:	50                   	push   %eax
  801e8e:	6a 16                	push   $0x16
  801e90:	e8 70 fd ff ff       	call   801c05 <syscall>
  801e95:	83 c4 18             	add    $0x18,%esp
}
  801e98:	90                   	nop
  801e99:	c9                   	leave  
  801e9a:	c3                   	ret    

00801e9b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e9b:	55                   	push   %ebp
  801e9c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e9e:	6a 00                	push   $0x0
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	6a 00                	push   $0x0
  801ea6:	6a 00                	push   $0x0
  801ea8:	6a 17                	push   $0x17
  801eaa:	e8 56 fd ff ff       	call   801c05 <syscall>
  801eaf:	83 c4 18             	add    $0x18,%esp
}
  801eb2:	90                   	nop
  801eb3:	c9                   	leave  
  801eb4:	c3                   	ret    

00801eb5 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801eb5:	55                   	push   %ebp
  801eb6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  801ebb:	6a 00                	push   $0x0
  801ebd:	6a 00                	push   $0x0
  801ebf:	6a 00                	push   $0x0
  801ec1:	ff 75 0c             	pushl  0xc(%ebp)
  801ec4:	50                   	push   %eax
  801ec5:	6a 18                	push   $0x18
  801ec7:	e8 39 fd ff ff       	call   801c05 <syscall>
  801ecc:	83 c4 18             	add    $0x18,%esp
}
  801ecf:	c9                   	leave  
  801ed0:	c3                   	ret    

00801ed1 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801ed1:	55                   	push   %ebp
  801ed2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ed4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ed7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eda:	6a 00                	push   $0x0
  801edc:	6a 00                	push   $0x0
  801ede:	6a 00                	push   $0x0
  801ee0:	52                   	push   %edx
  801ee1:	50                   	push   %eax
  801ee2:	6a 1b                	push   $0x1b
  801ee4:	e8 1c fd ff ff       	call   801c05 <syscall>
  801ee9:	83 c4 18             	add    $0x18,%esp
}
  801eec:	c9                   	leave  
  801eed:	c3                   	ret    

00801eee <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801eee:	55                   	push   %ebp
  801eef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ef1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ef4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef7:	6a 00                	push   $0x0
  801ef9:	6a 00                	push   $0x0
  801efb:	6a 00                	push   $0x0
  801efd:	52                   	push   %edx
  801efe:	50                   	push   %eax
  801eff:	6a 19                	push   $0x19
  801f01:	e8 ff fc ff ff       	call   801c05 <syscall>
  801f06:	83 c4 18             	add    $0x18,%esp
}
  801f09:	90                   	nop
  801f0a:	c9                   	leave  
  801f0b:	c3                   	ret    

00801f0c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f0c:	55                   	push   %ebp
  801f0d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f12:	8b 45 08             	mov    0x8(%ebp),%eax
  801f15:	6a 00                	push   $0x0
  801f17:	6a 00                	push   $0x0
  801f19:	6a 00                	push   $0x0
  801f1b:	52                   	push   %edx
  801f1c:	50                   	push   %eax
  801f1d:	6a 1a                	push   $0x1a
  801f1f:	e8 e1 fc ff ff       	call   801c05 <syscall>
  801f24:	83 c4 18             	add    $0x18,%esp
}
  801f27:	90                   	nop
  801f28:	c9                   	leave  
  801f29:	c3                   	ret    

00801f2a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801f2a:	55                   	push   %ebp
  801f2b:	89 e5                	mov    %esp,%ebp
  801f2d:	83 ec 04             	sub    $0x4,%esp
  801f30:	8b 45 10             	mov    0x10(%ebp),%eax
  801f33:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801f36:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f39:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f3d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f40:	6a 00                	push   $0x0
  801f42:	51                   	push   %ecx
  801f43:	52                   	push   %edx
  801f44:	ff 75 0c             	pushl  0xc(%ebp)
  801f47:	50                   	push   %eax
  801f48:	6a 1c                	push   $0x1c
  801f4a:	e8 b6 fc ff ff       	call   801c05 <syscall>
  801f4f:	83 c4 18             	add    $0x18,%esp
}
  801f52:	c9                   	leave  
  801f53:	c3                   	ret    

00801f54 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801f54:	55                   	push   %ebp
  801f55:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f57:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f5d:	6a 00                	push   $0x0
  801f5f:	6a 00                	push   $0x0
  801f61:	6a 00                	push   $0x0
  801f63:	52                   	push   %edx
  801f64:	50                   	push   %eax
  801f65:	6a 1d                	push   $0x1d
  801f67:	e8 99 fc ff ff       	call   801c05 <syscall>
  801f6c:	83 c4 18             	add    $0x18,%esp
}
  801f6f:	c9                   	leave  
  801f70:	c3                   	ret    

00801f71 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f71:	55                   	push   %ebp
  801f72:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801f74:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f77:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7d:	6a 00                	push   $0x0
  801f7f:	6a 00                	push   $0x0
  801f81:	51                   	push   %ecx
  801f82:	52                   	push   %edx
  801f83:	50                   	push   %eax
  801f84:	6a 1e                	push   $0x1e
  801f86:	e8 7a fc ff ff       	call   801c05 <syscall>
  801f8b:	83 c4 18             	add    $0x18,%esp
}
  801f8e:	c9                   	leave  
  801f8f:	c3                   	ret    

00801f90 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801f90:	55                   	push   %ebp
  801f91:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f93:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f96:	8b 45 08             	mov    0x8(%ebp),%eax
  801f99:	6a 00                	push   $0x0
  801f9b:	6a 00                	push   $0x0
  801f9d:	6a 00                	push   $0x0
  801f9f:	52                   	push   %edx
  801fa0:	50                   	push   %eax
  801fa1:	6a 1f                	push   $0x1f
  801fa3:	e8 5d fc ff ff       	call   801c05 <syscall>
  801fa8:	83 c4 18             	add    $0x18,%esp
}
  801fab:	c9                   	leave  
  801fac:	c3                   	ret    

00801fad <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801fad:	55                   	push   %ebp
  801fae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801fb0:	6a 00                	push   $0x0
  801fb2:	6a 00                	push   $0x0
  801fb4:	6a 00                	push   $0x0
  801fb6:	6a 00                	push   $0x0
  801fb8:	6a 00                	push   $0x0
  801fba:	6a 20                	push   $0x20
  801fbc:	e8 44 fc ff ff       	call   801c05 <syscall>
  801fc1:	83 c4 18             	add    $0x18,%esp
}
  801fc4:	c9                   	leave  
  801fc5:	c3                   	ret    

00801fc6 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801fc6:	55                   	push   %ebp
  801fc7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801fc9:	8b 45 08             	mov    0x8(%ebp),%eax
  801fcc:	6a 00                	push   $0x0
  801fce:	ff 75 14             	pushl  0x14(%ebp)
  801fd1:	ff 75 10             	pushl  0x10(%ebp)
  801fd4:	ff 75 0c             	pushl  0xc(%ebp)
  801fd7:	50                   	push   %eax
  801fd8:	6a 21                	push   $0x21
  801fda:	e8 26 fc ff ff       	call   801c05 <syscall>
  801fdf:	83 c4 18             	add    $0x18,%esp
}
  801fe2:	c9                   	leave  
  801fe3:	c3                   	ret    

00801fe4 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801fe4:	55                   	push   %ebp
  801fe5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801fe7:	8b 45 08             	mov    0x8(%ebp),%eax
  801fea:	6a 00                	push   $0x0
  801fec:	6a 00                	push   $0x0
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 00                	push   $0x0
  801ff2:	50                   	push   %eax
  801ff3:	6a 22                	push   $0x22
  801ff5:	e8 0b fc ff ff       	call   801c05 <syscall>
  801ffa:	83 c4 18             	add    $0x18,%esp
}
  801ffd:	90                   	nop
  801ffe:	c9                   	leave  
  801fff:	c3                   	ret    

00802000 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802000:	55                   	push   %ebp
  802001:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802003:	8b 45 08             	mov    0x8(%ebp),%eax
  802006:	6a 00                	push   $0x0
  802008:	6a 00                	push   $0x0
  80200a:	6a 00                	push   $0x0
  80200c:	6a 00                	push   $0x0
  80200e:	50                   	push   %eax
  80200f:	6a 23                	push   $0x23
  802011:	e8 ef fb ff ff       	call   801c05 <syscall>
  802016:	83 c4 18             	add    $0x18,%esp
}
  802019:	90                   	nop
  80201a:	c9                   	leave  
  80201b:	c3                   	ret    

0080201c <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80201c:	55                   	push   %ebp
  80201d:	89 e5                	mov    %esp,%ebp
  80201f:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802022:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802025:	8d 50 04             	lea    0x4(%eax),%edx
  802028:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80202b:	6a 00                	push   $0x0
  80202d:	6a 00                	push   $0x0
  80202f:	6a 00                	push   $0x0
  802031:	52                   	push   %edx
  802032:	50                   	push   %eax
  802033:	6a 24                	push   $0x24
  802035:	e8 cb fb ff ff       	call   801c05 <syscall>
  80203a:	83 c4 18             	add    $0x18,%esp
	return result;
  80203d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802040:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802043:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802046:	89 01                	mov    %eax,(%ecx)
  802048:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80204b:	8b 45 08             	mov    0x8(%ebp),%eax
  80204e:	c9                   	leave  
  80204f:	c2 04 00             	ret    $0x4

00802052 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802052:	55                   	push   %ebp
  802053:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802055:	6a 00                	push   $0x0
  802057:	6a 00                	push   $0x0
  802059:	ff 75 10             	pushl  0x10(%ebp)
  80205c:	ff 75 0c             	pushl  0xc(%ebp)
  80205f:	ff 75 08             	pushl  0x8(%ebp)
  802062:	6a 13                	push   $0x13
  802064:	e8 9c fb ff ff       	call   801c05 <syscall>
  802069:	83 c4 18             	add    $0x18,%esp
	return ;
  80206c:	90                   	nop
}
  80206d:	c9                   	leave  
  80206e:	c3                   	ret    

0080206f <sys_rcr2>:
uint32 sys_rcr2()
{
  80206f:	55                   	push   %ebp
  802070:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802072:	6a 00                	push   $0x0
  802074:	6a 00                	push   $0x0
  802076:	6a 00                	push   $0x0
  802078:	6a 00                	push   $0x0
  80207a:	6a 00                	push   $0x0
  80207c:	6a 25                	push   $0x25
  80207e:	e8 82 fb ff ff       	call   801c05 <syscall>
  802083:	83 c4 18             	add    $0x18,%esp
}
  802086:	c9                   	leave  
  802087:	c3                   	ret    

00802088 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802088:	55                   	push   %ebp
  802089:	89 e5                	mov    %esp,%ebp
  80208b:	83 ec 04             	sub    $0x4,%esp
  80208e:	8b 45 08             	mov    0x8(%ebp),%eax
  802091:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802094:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802098:	6a 00                	push   $0x0
  80209a:	6a 00                	push   $0x0
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	50                   	push   %eax
  8020a1:	6a 26                	push   $0x26
  8020a3:	e8 5d fb ff ff       	call   801c05 <syscall>
  8020a8:	83 c4 18             	add    $0x18,%esp
	return ;
  8020ab:	90                   	nop
}
  8020ac:	c9                   	leave  
  8020ad:	c3                   	ret    

008020ae <rsttst>:
void rsttst()
{
  8020ae:	55                   	push   %ebp
  8020af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8020b1:	6a 00                	push   $0x0
  8020b3:	6a 00                	push   $0x0
  8020b5:	6a 00                	push   $0x0
  8020b7:	6a 00                	push   $0x0
  8020b9:	6a 00                	push   $0x0
  8020bb:	6a 28                	push   $0x28
  8020bd:	e8 43 fb ff ff       	call   801c05 <syscall>
  8020c2:	83 c4 18             	add    $0x18,%esp
	return ;
  8020c5:	90                   	nop
}
  8020c6:	c9                   	leave  
  8020c7:	c3                   	ret    

008020c8 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8020c8:	55                   	push   %ebp
  8020c9:	89 e5                	mov    %esp,%ebp
  8020cb:	83 ec 04             	sub    $0x4,%esp
  8020ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8020d1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8020d4:	8b 55 18             	mov    0x18(%ebp),%edx
  8020d7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8020db:	52                   	push   %edx
  8020dc:	50                   	push   %eax
  8020dd:	ff 75 10             	pushl  0x10(%ebp)
  8020e0:	ff 75 0c             	pushl  0xc(%ebp)
  8020e3:	ff 75 08             	pushl  0x8(%ebp)
  8020e6:	6a 27                	push   $0x27
  8020e8:	e8 18 fb ff ff       	call   801c05 <syscall>
  8020ed:	83 c4 18             	add    $0x18,%esp
	return ;
  8020f0:	90                   	nop
}
  8020f1:	c9                   	leave  
  8020f2:	c3                   	ret    

008020f3 <chktst>:
void chktst(uint32 n)
{
  8020f3:	55                   	push   %ebp
  8020f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8020f6:	6a 00                	push   $0x0
  8020f8:	6a 00                	push   $0x0
  8020fa:	6a 00                	push   $0x0
  8020fc:	6a 00                	push   $0x0
  8020fe:	ff 75 08             	pushl  0x8(%ebp)
  802101:	6a 29                	push   $0x29
  802103:	e8 fd fa ff ff       	call   801c05 <syscall>
  802108:	83 c4 18             	add    $0x18,%esp
	return ;
  80210b:	90                   	nop
}
  80210c:	c9                   	leave  
  80210d:	c3                   	ret    

0080210e <inctst>:

void inctst()
{
  80210e:	55                   	push   %ebp
  80210f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802111:	6a 00                	push   $0x0
  802113:	6a 00                	push   $0x0
  802115:	6a 00                	push   $0x0
  802117:	6a 00                	push   $0x0
  802119:	6a 00                	push   $0x0
  80211b:	6a 2a                	push   $0x2a
  80211d:	e8 e3 fa ff ff       	call   801c05 <syscall>
  802122:	83 c4 18             	add    $0x18,%esp
	return ;
  802125:	90                   	nop
}
  802126:	c9                   	leave  
  802127:	c3                   	ret    

00802128 <gettst>:
uint32 gettst()
{
  802128:	55                   	push   %ebp
  802129:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80212b:	6a 00                	push   $0x0
  80212d:	6a 00                	push   $0x0
  80212f:	6a 00                	push   $0x0
  802131:	6a 00                	push   $0x0
  802133:	6a 00                	push   $0x0
  802135:	6a 2b                	push   $0x2b
  802137:	e8 c9 fa ff ff       	call   801c05 <syscall>
  80213c:	83 c4 18             	add    $0x18,%esp
}
  80213f:	c9                   	leave  
  802140:	c3                   	ret    

00802141 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
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
  802153:	e8 ad fa ff ff       	call   801c05 <syscall>
  802158:	83 c4 18             	add    $0x18,%esp
  80215b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80215e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802162:	75 07                	jne    80216b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802164:	b8 01 00 00 00       	mov    $0x1,%eax
  802169:	eb 05                	jmp    802170 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80216b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802170:	c9                   	leave  
  802171:	c3                   	ret    

00802172 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802172:	55                   	push   %ebp
  802173:	89 e5                	mov    %esp,%ebp
  802175:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802178:	6a 00                	push   $0x0
  80217a:	6a 00                	push   $0x0
  80217c:	6a 00                	push   $0x0
  80217e:	6a 00                	push   $0x0
  802180:	6a 00                	push   $0x0
  802182:	6a 2c                	push   $0x2c
  802184:	e8 7c fa ff ff       	call   801c05 <syscall>
  802189:	83 c4 18             	add    $0x18,%esp
  80218c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80218f:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802193:	75 07                	jne    80219c <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802195:	b8 01 00 00 00       	mov    $0x1,%eax
  80219a:	eb 05                	jmp    8021a1 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80219c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021a1:	c9                   	leave  
  8021a2:	c3                   	ret    

008021a3 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8021a3:	55                   	push   %ebp
  8021a4:	89 e5                	mov    %esp,%ebp
  8021a6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	6a 00                	push   $0x0
  8021af:	6a 00                	push   $0x0
  8021b1:	6a 00                	push   $0x0
  8021b3:	6a 2c                	push   $0x2c
  8021b5:	e8 4b fa ff ff       	call   801c05 <syscall>
  8021ba:	83 c4 18             	add    $0x18,%esp
  8021bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8021c0:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8021c4:	75 07                	jne    8021cd <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8021c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8021cb:	eb 05                	jmp    8021d2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8021cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021d2:	c9                   	leave  
  8021d3:	c3                   	ret    

008021d4 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8021d4:	55                   	push   %ebp
  8021d5:	89 e5                	mov    %esp,%ebp
  8021d7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021da:	6a 00                	push   $0x0
  8021dc:	6a 00                	push   $0x0
  8021de:	6a 00                	push   $0x0
  8021e0:	6a 00                	push   $0x0
  8021e2:	6a 00                	push   $0x0
  8021e4:	6a 2c                	push   $0x2c
  8021e6:	e8 1a fa ff ff       	call   801c05 <syscall>
  8021eb:	83 c4 18             	add    $0x18,%esp
  8021ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8021f1:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8021f5:	75 07                	jne    8021fe <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8021f7:	b8 01 00 00 00       	mov    $0x1,%eax
  8021fc:	eb 05                	jmp    802203 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8021fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802203:	c9                   	leave  
  802204:	c3                   	ret    

00802205 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802205:	55                   	push   %ebp
  802206:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802208:	6a 00                	push   $0x0
  80220a:	6a 00                	push   $0x0
  80220c:	6a 00                	push   $0x0
  80220e:	6a 00                	push   $0x0
  802210:	ff 75 08             	pushl  0x8(%ebp)
  802213:	6a 2d                	push   $0x2d
  802215:	e8 eb f9 ff ff       	call   801c05 <syscall>
  80221a:	83 c4 18             	add    $0x18,%esp
	return ;
  80221d:	90                   	nop
}
  80221e:	c9                   	leave  
  80221f:	c3                   	ret    

00802220 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802220:	55                   	push   %ebp
  802221:	89 e5                	mov    %esp,%ebp
  802223:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802224:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802227:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80222a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80222d:	8b 45 08             	mov    0x8(%ebp),%eax
  802230:	6a 00                	push   $0x0
  802232:	53                   	push   %ebx
  802233:	51                   	push   %ecx
  802234:	52                   	push   %edx
  802235:	50                   	push   %eax
  802236:	6a 2e                	push   $0x2e
  802238:	e8 c8 f9 ff ff       	call   801c05 <syscall>
  80223d:	83 c4 18             	add    $0x18,%esp
}
  802240:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802243:	c9                   	leave  
  802244:	c3                   	ret    

00802245 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802245:	55                   	push   %ebp
  802246:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802248:	8b 55 0c             	mov    0xc(%ebp),%edx
  80224b:	8b 45 08             	mov    0x8(%ebp),%eax
  80224e:	6a 00                	push   $0x0
  802250:	6a 00                	push   $0x0
  802252:	6a 00                	push   $0x0
  802254:	52                   	push   %edx
  802255:	50                   	push   %eax
  802256:	6a 2f                	push   $0x2f
  802258:	e8 a8 f9 ff ff       	call   801c05 <syscall>
  80225d:	83 c4 18             	add    $0x18,%esp
}
  802260:	c9                   	leave  
  802261:	c3                   	ret    

00802262 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  802262:	55                   	push   %ebp
  802263:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  802265:	6a 00                	push   $0x0
  802267:	6a 00                	push   $0x0
  802269:	6a 00                	push   $0x0
  80226b:	ff 75 0c             	pushl  0xc(%ebp)
  80226e:	ff 75 08             	pushl  0x8(%ebp)
  802271:	6a 30                	push   $0x30
  802273:	e8 8d f9 ff ff       	call   801c05 <syscall>
  802278:	83 c4 18             	add    $0x18,%esp
	return ;
  80227b:	90                   	nop
}
  80227c:	c9                   	leave  
  80227d:	c3                   	ret    
  80227e:	66 90                	xchg   %ax,%ax

00802280 <__udivdi3>:
  802280:	55                   	push   %ebp
  802281:	57                   	push   %edi
  802282:	56                   	push   %esi
  802283:	53                   	push   %ebx
  802284:	83 ec 1c             	sub    $0x1c,%esp
  802287:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80228b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80228f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802293:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802297:	89 ca                	mov    %ecx,%edx
  802299:	89 f8                	mov    %edi,%eax
  80229b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80229f:	85 f6                	test   %esi,%esi
  8022a1:	75 2d                	jne    8022d0 <__udivdi3+0x50>
  8022a3:	39 cf                	cmp    %ecx,%edi
  8022a5:	77 65                	ja     80230c <__udivdi3+0x8c>
  8022a7:	89 fd                	mov    %edi,%ebp
  8022a9:	85 ff                	test   %edi,%edi
  8022ab:	75 0b                	jne    8022b8 <__udivdi3+0x38>
  8022ad:	b8 01 00 00 00       	mov    $0x1,%eax
  8022b2:	31 d2                	xor    %edx,%edx
  8022b4:	f7 f7                	div    %edi
  8022b6:	89 c5                	mov    %eax,%ebp
  8022b8:	31 d2                	xor    %edx,%edx
  8022ba:	89 c8                	mov    %ecx,%eax
  8022bc:	f7 f5                	div    %ebp
  8022be:	89 c1                	mov    %eax,%ecx
  8022c0:	89 d8                	mov    %ebx,%eax
  8022c2:	f7 f5                	div    %ebp
  8022c4:	89 cf                	mov    %ecx,%edi
  8022c6:	89 fa                	mov    %edi,%edx
  8022c8:	83 c4 1c             	add    $0x1c,%esp
  8022cb:	5b                   	pop    %ebx
  8022cc:	5e                   	pop    %esi
  8022cd:	5f                   	pop    %edi
  8022ce:	5d                   	pop    %ebp
  8022cf:	c3                   	ret    
  8022d0:	39 ce                	cmp    %ecx,%esi
  8022d2:	77 28                	ja     8022fc <__udivdi3+0x7c>
  8022d4:	0f bd fe             	bsr    %esi,%edi
  8022d7:	83 f7 1f             	xor    $0x1f,%edi
  8022da:	75 40                	jne    80231c <__udivdi3+0x9c>
  8022dc:	39 ce                	cmp    %ecx,%esi
  8022de:	72 0a                	jb     8022ea <__udivdi3+0x6a>
  8022e0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8022e4:	0f 87 9e 00 00 00    	ja     802388 <__udivdi3+0x108>
  8022ea:	b8 01 00 00 00       	mov    $0x1,%eax
  8022ef:	89 fa                	mov    %edi,%edx
  8022f1:	83 c4 1c             	add    $0x1c,%esp
  8022f4:	5b                   	pop    %ebx
  8022f5:	5e                   	pop    %esi
  8022f6:	5f                   	pop    %edi
  8022f7:	5d                   	pop    %ebp
  8022f8:	c3                   	ret    
  8022f9:	8d 76 00             	lea    0x0(%esi),%esi
  8022fc:	31 ff                	xor    %edi,%edi
  8022fe:	31 c0                	xor    %eax,%eax
  802300:	89 fa                	mov    %edi,%edx
  802302:	83 c4 1c             	add    $0x1c,%esp
  802305:	5b                   	pop    %ebx
  802306:	5e                   	pop    %esi
  802307:	5f                   	pop    %edi
  802308:	5d                   	pop    %ebp
  802309:	c3                   	ret    
  80230a:	66 90                	xchg   %ax,%ax
  80230c:	89 d8                	mov    %ebx,%eax
  80230e:	f7 f7                	div    %edi
  802310:	31 ff                	xor    %edi,%edi
  802312:	89 fa                	mov    %edi,%edx
  802314:	83 c4 1c             	add    $0x1c,%esp
  802317:	5b                   	pop    %ebx
  802318:	5e                   	pop    %esi
  802319:	5f                   	pop    %edi
  80231a:	5d                   	pop    %ebp
  80231b:	c3                   	ret    
  80231c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802321:	89 eb                	mov    %ebp,%ebx
  802323:	29 fb                	sub    %edi,%ebx
  802325:	89 f9                	mov    %edi,%ecx
  802327:	d3 e6                	shl    %cl,%esi
  802329:	89 c5                	mov    %eax,%ebp
  80232b:	88 d9                	mov    %bl,%cl
  80232d:	d3 ed                	shr    %cl,%ebp
  80232f:	89 e9                	mov    %ebp,%ecx
  802331:	09 f1                	or     %esi,%ecx
  802333:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802337:	89 f9                	mov    %edi,%ecx
  802339:	d3 e0                	shl    %cl,%eax
  80233b:	89 c5                	mov    %eax,%ebp
  80233d:	89 d6                	mov    %edx,%esi
  80233f:	88 d9                	mov    %bl,%cl
  802341:	d3 ee                	shr    %cl,%esi
  802343:	89 f9                	mov    %edi,%ecx
  802345:	d3 e2                	shl    %cl,%edx
  802347:	8b 44 24 08          	mov    0x8(%esp),%eax
  80234b:	88 d9                	mov    %bl,%cl
  80234d:	d3 e8                	shr    %cl,%eax
  80234f:	09 c2                	or     %eax,%edx
  802351:	89 d0                	mov    %edx,%eax
  802353:	89 f2                	mov    %esi,%edx
  802355:	f7 74 24 0c          	divl   0xc(%esp)
  802359:	89 d6                	mov    %edx,%esi
  80235b:	89 c3                	mov    %eax,%ebx
  80235d:	f7 e5                	mul    %ebp
  80235f:	39 d6                	cmp    %edx,%esi
  802361:	72 19                	jb     80237c <__udivdi3+0xfc>
  802363:	74 0b                	je     802370 <__udivdi3+0xf0>
  802365:	89 d8                	mov    %ebx,%eax
  802367:	31 ff                	xor    %edi,%edi
  802369:	e9 58 ff ff ff       	jmp    8022c6 <__udivdi3+0x46>
  80236e:	66 90                	xchg   %ax,%ax
  802370:	8b 54 24 08          	mov    0x8(%esp),%edx
  802374:	89 f9                	mov    %edi,%ecx
  802376:	d3 e2                	shl    %cl,%edx
  802378:	39 c2                	cmp    %eax,%edx
  80237a:	73 e9                	jae    802365 <__udivdi3+0xe5>
  80237c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80237f:	31 ff                	xor    %edi,%edi
  802381:	e9 40 ff ff ff       	jmp    8022c6 <__udivdi3+0x46>
  802386:	66 90                	xchg   %ax,%ax
  802388:	31 c0                	xor    %eax,%eax
  80238a:	e9 37 ff ff ff       	jmp    8022c6 <__udivdi3+0x46>
  80238f:	90                   	nop

00802390 <__umoddi3>:
  802390:	55                   	push   %ebp
  802391:	57                   	push   %edi
  802392:	56                   	push   %esi
  802393:	53                   	push   %ebx
  802394:	83 ec 1c             	sub    $0x1c,%esp
  802397:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80239b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80239f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023a3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8023a7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8023ab:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8023af:	89 f3                	mov    %esi,%ebx
  8023b1:	89 fa                	mov    %edi,%edx
  8023b3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023b7:	89 34 24             	mov    %esi,(%esp)
  8023ba:	85 c0                	test   %eax,%eax
  8023bc:	75 1a                	jne    8023d8 <__umoddi3+0x48>
  8023be:	39 f7                	cmp    %esi,%edi
  8023c0:	0f 86 a2 00 00 00    	jbe    802468 <__umoddi3+0xd8>
  8023c6:	89 c8                	mov    %ecx,%eax
  8023c8:	89 f2                	mov    %esi,%edx
  8023ca:	f7 f7                	div    %edi
  8023cc:	89 d0                	mov    %edx,%eax
  8023ce:	31 d2                	xor    %edx,%edx
  8023d0:	83 c4 1c             	add    $0x1c,%esp
  8023d3:	5b                   	pop    %ebx
  8023d4:	5e                   	pop    %esi
  8023d5:	5f                   	pop    %edi
  8023d6:	5d                   	pop    %ebp
  8023d7:	c3                   	ret    
  8023d8:	39 f0                	cmp    %esi,%eax
  8023da:	0f 87 ac 00 00 00    	ja     80248c <__umoddi3+0xfc>
  8023e0:	0f bd e8             	bsr    %eax,%ebp
  8023e3:	83 f5 1f             	xor    $0x1f,%ebp
  8023e6:	0f 84 ac 00 00 00    	je     802498 <__umoddi3+0x108>
  8023ec:	bf 20 00 00 00       	mov    $0x20,%edi
  8023f1:	29 ef                	sub    %ebp,%edi
  8023f3:	89 fe                	mov    %edi,%esi
  8023f5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8023f9:	89 e9                	mov    %ebp,%ecx
  8023fb:	d3 e0                	shl    %cl,%eax
  8023fd:	89 d7                	mov    %edx,%edi
  8023ff:	89 f1                	mov    %esi,%ecx
  802401:	d3 ef                	shr    %cl,%edi
  802403:	09 c7                	or     %eax,%edi
  802405:	89 e9                	mov    %ebp,%ecx
  802407:	d3 e2                	shl    %cl,%edx
  802409:	89 14 24             	mov    %edx,(%esp)
  80240c:	89 d8                	mov    %ebx,%eax
  80240e:	d3 e0                	shl    %cl,%eax
  802410:	89 c2                	mov    %eax,%edx
  802412:	8b 44 24 08          	mov    0x8(%esp),%eax
  802416:	d3 e0                	shl    %cl,%eax
  802418:	89 44 24 04          	mov    %eax,0x4(%esp)
  80241c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802420:	89 f1                	mov    %esi,%ecx
  802422:	d3 e8                	shr    %cl,%eax
  802424:	09 d0                	or     %edx,%eax
  802426:	d3 eb                	shr    %cl,%ebx
  802428:	89 da                	mov    %ebx,%edx
  80242a:	f7 f7                	div    %edi
  80242c:	89 d3                	mov    %edx,%ebx
  80242e:	f7 24 24             	mull   (%esp)
  802431:	89 c6                	mov    %eax,%esi
  802433:	89 d1                	mov    %edx,%ecx
  802435:	39 d3                	cmp    %edx,%ebx
  802437:	0f 82 87 00 00 00    	jb     8024c4 <__umoddi3+0x134>
  80243d:	0f 84 91 00 00 00    	je     8024d4 <__umoddi3+0x144>
  802443:	8b 54 24 04          	mov    0x4(%esp),%edx
  802447:	29 f2                	sub    %esi,%edx
  802449:	19 cb                	sbb    %ecx,%ebx
  80244b:	89 d8                	mov    %ebx,%eax
  80244d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802451:	d3 e0                	shl    %cl,%eax
  802453:	89 e9                	mov    %ebp,%ecx
  802455:	d3 ea                	shr    %cl,%edx
  802457:	09 d0                	or     %edx,%eax
  802459:	89 e9                	mov    %ebp,%ecx
  80245b:	d3 eb                	shr    %cl,%ebx
  80245d:	89 da                	mov    %ebx,%edx
  80245f:	83 c4 1c             	add    $0x1c,%esp
  802462:	5b                   	pop    %ebx
  802463:	5e                   	pop    %esi
  802464:	5f                   	pop    %edi
  802465:	5d                   	pop    %ebp
  802466:	c3                   	ret    
  802467:	90                   	nop
  802468:	89 fd                	mov    %edi,%ebp
  80246a:	85 ff                	test   %edi,%edi
  80246c:	75 0b                	jne    802479 <__umoddi3+0xe9>
  80246e:	b8 01 00 00 00       	mov    $0x1,%eax
  802473:	31 d2                	xor    %edx,%edx
  802475:	f7 f7                	div    %edi
  802477:	89 c5                	mov    %eax,%ebp
  802479:	89 f0                	mov    %esi,%eax
  80247b:	31 d2                	xor    %edx,%edx
  80247d:	f7 f5                	div    %ebp
  80247f:	89 c8                	mov    %ecx,%eax
  802481:	f7 f5                	div    %ebp
  802483:	89 d0                	mov    %edx,%eax
  802485:	e9 44 ff ff ff       	jmp    8023ce <__umoddi3+0x3e>
  80248a:	66 90                	xchg   %ax,%ax
  80248c:	89 c8                	mov    %ecx,%eax
  80248e:	89 f2                	mov    %esi,%edx
  802490:	83 c4 1c             	add    $0x1c,%esp
  802493:	5b                   	pop    %ebx
  802494:	5e                   	pop    %esi
  802495:	5f                   	pop    %edi
  802496:	5d                   	pop    %ebp
  802497:	c3                   	ret    
  802498:	3b 04 24             	cmp    (%esp),%eax
  80249b:	72 06                	jb     8024a3 <__umoddi3+0x113>
  80249d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8024a1:	77 0f                	ja     8024b2 <__umoddi3+0x122>
  8024a3:	89 f2                	mov    %esi,%edx
  8024a5:	29 f9                	sub    %edi,%ecx
  8024a7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8024ab:	89 14 24             	mov    %edx,(%esp)
  8024ae:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024b2:	8b 44 24 04          	mov    0x4(%esp),%eax
  8024b6:	8b 14 24             	mov    (%esp),%edx
  8024b9:	83 c4 1c             	add    $0x1c,%esp
  8024bc:	5b                   	pop    %ebx
  8024bd:	5e                   	pop    %esi
  8024be:	5f                   	pop    %edi
  8024bf:	5d                   	pop    %ebp
  8024c0:	c3                   	ret    
  8024c1:	8d 76 00             	lea    0x0(%esi),%esi
  8024c4:	2b 04 24             	sub    (%esp),%eax
  8024c7:	19 fa                	sbb    %edi,%edx
  8024c9:	89 d1                	mov    %edx,%ecx
  8024cb:	89 c6                	mov    %eax,%esi
  8024cd:	e9 71 ff ff ff       	jmp    802443 <__umoddi3+0xb3>
  8024d2:	66 90                	xchg   %ax,%ax
  8024d4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8024d8:	72 ea                	jb     8024c4 <__umoddi3+0x134>
  8024da:	89 d9                	mov    %ebx,%ecx
  8024dc:	e9 62 ff ff ff       	jmp    802443 <__umoddi3+0xb3>
