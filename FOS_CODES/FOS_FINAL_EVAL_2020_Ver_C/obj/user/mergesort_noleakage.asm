
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
  800041:	e8 34 21 00 00       	call   80217a <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 20 28 80 00       	push   $0x802820
  80004e:	e8 51 0b 00 00       	call   800ba4 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 22 28 80 00       	push   $0x802822
  80005e:	e8 41 0b 00 00       	call   800ba4 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 38 28 80 00       	push   $0x802838
  80006e:	e8 31 0b 00 00       	call   800ba4 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 22 28 80 00       	push   $0x802822
  80007e:	e8 21 0b 00 00       	call   800ba4 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 20 28 80 00       	push   $0x802820
  80008e:	e8 11 0b 00 00       	call   800ba4 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 50 28 80 00       	push   $0x802850
  8000a5:	e8 7c 11 00 00       	call   801226 <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 cc 16 00 00       	call   80178c <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 5f 1a 00 00       	call   801b34 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 70 28 80 00       	push   $0x802870
  8000e3:	e8 bc 0a 00 00       	call   800ba4 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 92 28 80 00       	push   $0x802892
  8000f3:	e8 ac 0a 00 00       	call   800ba4 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 a0 28 80 00       	push   $0x8028a0
  800103:	e8 9c 0a 00 00       	call   800ba4 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 af 28 80 00       	push   $0x8028af
  800113:	e8 8c 0a 00 00       	call   800ba4 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 bf 28 80 00       	push   $0x8028bf
  800123:	e8 7c 0a 00 00       	call   800ba4 <cprintf>
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
  800162:	e8 2d 20 00 00       	call   802194 <sys_enable_interrupt>

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
  8001d7:	e8 9e 1f 00 00       	call   80217a <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001dc:	83 ec 0c             	sub    $0xc,%esp
  8001df:	68 c8 28 80 00       	push   $0x8028c8
  8001e4:	e8 bb 09 00 00       	call   800ba4 <cprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ec:	e8 a3 1f 00 00       	call   802194 <sys_enable_interrupt>

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
  80020e:	68 fc 28 80 00       	push   $0x8028fc
  800213:	6a 4a                	push   $0x4a
  800215:	68 1e 29 80 00       	push   $0x80291e
  80021a:	e8 ce 06 00 00       	call   8008ed <_panic>
		else
		{
			sys_disable_interrupt();
  80021f:	e8 56 1f 00 00       	call   80217a <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	68 3c 29 80 00       	push   $0x80293c
  80022c:	e8 73 09 00 00       	call   800ba4 <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 70 29 80 00       	push   $0x802970
  80023c:	e8 63 09 00 00       	call   800ba4 <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	68 a4 29 80 00       	push   $0x8029a4
  80024c:	e8 53 09 00 00       	call   800ba4 <cprintf>
  800251:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800254:	e8 3b 1f 00 00       	call   802194 <sys_enable_interrupt>
		}

		free(Elements) ;
  800259:	83 ec 0c             	sub    $0xc,%esp
  80025c:	ff 75 ec             	pushl  -0x14(%ebp)
  80025f:	e8 95 1b 00 00       	call   801df9 <free>
  800264:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800267:	e8 0e 1f 00 00       	call   80217a <sys_disable_interrupt>
			Chose = 0 ;
  80026c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800270:	eb 42                	jmp    8002b4 <_main+0x27c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	68 d6 29 80 00       	push   $0x8029d6
  80027a:	e8 25 09 00 00       	call   800ba4 <cprintf>
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
  8002c0:	e8 cf 1e 00 00       	call   802194 <sys_enable_interrupt>

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
  800454:	68 20 28 80 00       	push   $0x802820
  800459:	e8 46 07 00 00       	call   800ba4 <cprintf>
  80045e:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800461:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800464:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	01 d0                	add    %edx,%eax
  800470:	8b 00                	mov    (%eax),%eax
  800472:	83 ec 08             	sub    $0x8,%esp
  800475:	50                   	push   %eax
  800476:	68 f4 29 80 00       	push   $0x8029f4
  80047b:	e8 24 07 00 00       	call   800ba4 <cprintf>
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
  8004a4:	68 f9 29 80 00       	push   $0x8029f9
  8004a9:	e8 f6 06 00 00       	call   800ba4 <cprintf>
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
  80054a:	e8 e5 15 00 00       	call   801b34 <malloc>
  80054f:	83 c4 10             	add    $0x10,%esp
  800552:	89 45 d8             	mov    %eax,-0x28(%ebp)

	//cprintf("allocate RIGHT\n");
	int* Right = malloc(sizeof(int) * rightCapacity);
  800555:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800558:	c1 e0 02             	shl    $0x2,%eax
  80055b:	83 ec 0c             	sub    $0xc,%esp
  80055e:	50                   	push   %eax
  80055f:	e8 d0 15 00 00       	call   801b34 <malloc>
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
  80070c:	e8 e8 16 00 00       	call   801df9 <free>
  800711:	83 c4 10             	add    $0x10,%esp
	//cprintf("free RIGHT\n");
	free(Right);
  800714:	83 ec 0c             	sub    $0xc,%esp
  800717:	ff 75 d4             	pushl  -0x2c(%ebp)
  80071a:	e8 da 16 00 00       	call   801df9 <free>
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
  800739:	e8 70 1a 00 00       	call   8021ae <sys_cputc>
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
  80074a:	e8 2b 1a 00 00       	call   80217a <sys_disable_interrupt>
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
  80075d:	e8 4c 1a 00 00       	call   8021ae <sys_cputc>
  800762:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800765:	e8 2a 1a 00 00       	call   802194 <sys_enable_interrupt>
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
  80077c:	e8 11 18 00 00       	call   801f92 <sys_cgetc>
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
  800795:	e8 e0 19 00 00       	call   80217a <sys_disable_interrupt>
	int c=0;
  80079a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8007a1:	eb 08                	jmp    8007ab <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8007a3:	e8 ea 17 00 00       	call   801f92 <sys_cgetc>
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
  8007b1:	e8 de 19 00 00       	call   802194 <sys_enable_interrupt>
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
  8007cb:	e8 0f 18 00 00       	call   801fdf <sys_getenvindex>
  8007d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007d6:	89 d0                	mov    %edx,%eax
  8007d8:	01 c0                	add    %eax,%eax
  8007da:	01 d0                	add    %edx,%eax
  8007dc:	c1 e0 07             	shl    $0x7,%eax
  8007df:	29 d0                	sub    %edx,%eax
  8007e1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007e8:	01 c8                	add    %ecx,%eax
  8007ea:	01 c0                	add    %eax,%eax
  8007ec:	01 d0                	add    %edx,%eax
  8007ee:	01 c0                	add    %eax,%eax
  8007f0:	01 d0                	add    %edx,%eax
  8007f2:	c1 e0 03             	shl    $0x3,%eax
  8007f5:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8007fa:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007ff:	a1 24 30 80 00       	mov    0x803024,%eax
  800804:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  80080a:	84 c0                	test   %al,%al
  80080c:	74 0f                	je     80081d <libmain+0x58>
		binaryname = myEnv->prog_name;
  80080e:	a1 24 30 80 00       	mov    0x803024,%eax
  800813:	05 f0 ee 00 00       	add    $0xeef0,%eax
  800818:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80081d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800821:	7e 0a                	jle    80082d <libmain+0x68>
		binaryname = argv[0];
  800823:	8b 45 0c             	mov    0xc(%ebp),%eax
  800826:	8b 00                	mov    (%eax),%eax
  800828:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80082d:	83 ec 08             	sub    $0x8,%esp
  800830:	ff 75 0c             	pushl  0xc(%ebp)
  800833:	ff 75 08             	pushl  0x8(%ebp)
  800836:	e8 fd f7 ff ff       	call   800038 <_main>
  80083b:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80083e:	e8 37 19 00 00       	call   80217a <sys_disable_interrupt>
	cprintf("**************************************\n");
  800843:	83 ec 0c             	sub    $0xc,%esp
  800846:	68 18 2a 80 00       	push   $0x802a18
  80084b:	e8 54 03 00 00       	call   800ba4 <cprintf>
  800850:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800853:	a1 24 30 80 00       	mov    0x803024,%eax
  800858:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  80085e:	a1 24 30 80 00       	mov    0x803024,%eax
  800863:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  800869:	83 ec 04             	sub    $0x4,%esp
  80086c:	52                   	push   %edx
  80086d:	50                   	push   %eax
  80086e:	68 40 2a 80 00       	push   $0x802a40
  800873:	e8 2c 03 00 00       	call   800ba4 <cprintf>
  800878:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80087b:	a1 24 30 80 00       	mov    0x803024,%eax
  800880:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  800886:	a1 24 30 80 00       	mov    0x803024,%eax
  80088b:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  800891:	a1 24 30 80 00       	mov    0x803024,%eax
  800896:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  80089c:	51                   	push   %ecx
  80089d:	52                   	push   %edx
  80089e:	50                   	push   %eax
  80089f:	68 68 2a 80 00       	push   $0x802a68
  8008a4:	e8 fb 02 00 00       	call   800ba4 <cprintf>
  8008a9:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8008ac:	83 ec 0c             	sub    $0xc,%esp
  8008af:	68 18 2a 80 00       	push   $0x802a18
  8008b4:	e8 eb 02 00 00       	call   800ba4 <cprintf>
  8008b9:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8008bc:	e8 d3 18 00 00       	call   802194 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8008c1:	e8 19 00 00 00       	call   8008df <exit>
}
  8008c6:	90                   	nop
  8008c7:	c9                   	leave  
  8008c8:	c3                   	ret    

008008c9 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008c9:	55                   	push   %ebp
  8008ca:	89 e5                	mov    %esp,%ebp
  8008cc:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008cf:	83 ec 0c             	sub    $0xc,%esp
  8008d2:	6a 00                	push   $0x0
  8008d4:	e8 d2 16 00 00       	call   801fab <sys_env_destroy>
  8008d9:	83 c4 10             	add    $0x10,%esp
}
  8008dc:	90                   	nop
  8008dd:	c9                   	leave  
  8008de:	c3                   	ret    

008008df <exit>:

void
exit(void)
{
  8008df:	55                   	push   %ebp
  8008e0:	89 e5                	mov    %esp,%ebp
  8008e2:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008e5:	e8 27 17 00 00       	call   802011 <sys_env_exit>
}
  8008ea:	90                   	nop
  8008eb:	c9                   	leave  
  8008ec:	c3                   	ret    

008008ed <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008ed:	55                   	push   %ebp
  8008ee:	89 e5                	mov    %esp,%ebp
  8008f0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008f3:	8d 45 10             	lea    0x10(%ebp),%eax
  8008f6:	83 c0 04             	add    $0x4,%eax
  8008f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008fc:	a1 18 31 80 00       	mov    0x803118,%eax
  800901:	85 c0                	test   %eax,%eax
  800903:	74 16                	je     80091b <_panic+0x2e>
		cprintf("%s: ", argv0);
  800905:	a1 18 31 80 00       	mov    0x803118,%eax
  80090a:	83 ec 08             	sub    $0x8,%esp
  80090d:	50                   	push   %eax
  80090e:	68 c0 2a 80 00       	push   $0x802ac0
  800913:	e8 8c 02 00 00       	call   800ba4 <cprintf>
  800918:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80091b:	a1 00 30 80 00       	mov    0x803000,%eax
  800920:	ff 75 0c             	pushl  0xc(%ebp)
  800923:	ff 75 08             	pushl  0x8(%ebp)
  800926:	50                   	push   %eax
  800927:	68 c5 2a 80 00       	push   $0x802ac5
  80092c:	e8 73 02 00 00       	call   800ba4 <cprintf>
  800931:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800934:	8b 45 10             	mov    0x10(%ebp),%eax
  800937:	83 ec 08             	sub    $0x8,%esp
  80093a:	ff 75 f4             	pushl  -0xc(%ebp)
  80093d:	50                   	push   %eax
  80093e:	e8 f6 01 00 00       	call   800b39 <vcprintf>
  800943:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800946:	83 ec 08             	sub    $0x8,%esp
  800949:	6a 00                	push   $0x0
  80094b:	68 e1 2a 80 00       	push   $0x802ae1
  800950:	e8 e4 01 00 00       	call   800b39 <vcprintf>
  800955:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800958:	e8 82 ff ff ff       	call   8008df <exit>

	// should not return here
	while (1) ;
  80095d:	eb fe                	jmp    80095d <_panic+0x70>

0080095f <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80095f:	55                   	push   %ebp
  800960:	89 e5                	mov    %esp,%ebp
  800962:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800965:	a1 24 30 80 00       	mov    0x803024,%eax
  80096a:	8b 50 74             	mov    0x74(%eax),%edx
  80096d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800970:	39 c2                	cmp    %eax,%edx
  800972:	74 14                	je     800988 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800974:	83 ec 04             	sub    $0x4,%esp
  800977:	68 e4 2a 80 00       	push   $0x802ae4
  80097c:	6a 26                	push   $0x26
  80097e:	68 30 2b 80 00       	push   $0x802b30
  800983:	e8 65 ff ff ff       	call   8008ed <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800988:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80098f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800996:	e9 c4 00 00 00       	jmp    800a5f <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  80099b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80099e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a8:	01 d0                	add    %edx,%eax
  8009aa:	8b 00                	mov    (%eax),%eax
  8009ac:	85 c0                	test   %eax,%eax
  8009ae:	75 08                	jne    8009b8 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8009b0:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8009b3:	e9 a4 00 00 00       	jmp    800a5c <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8009b8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009bf:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8009c6:	eb 6b                	jmp    800a33 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009c8:	a1 24 30 80 00       	mov    0x803024,%eax
  8009cd:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8009d3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009d6:	89 d0                	mov    %edx,%eax
  8009d8:	c1 e0 02             	shl    $0x2,%eax
  8009db:	01 d0                	add    %edx,%eax
  8009dd:	c1 e0 02             	shl    $0x2,%eax
  8009e0:	01 c8                	add    %ecx,%eax
  8009e2:	8a 40 04             	mov    0x4(%eax),%al
  8009e5:	84 c0                	test   %al,%al
  8009e7:	75 47                	jne    800a30 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009e9:	a1 24 30 80 00       	mov    0x803024,%eax
  8009ee:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8009f4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009f7:	89 d0                	mov    %edx,%eax
  8009f9:	c1 e0 02             	shl    $0x2,%eax
  8009fc:	01 d0                	add    %edx,%eax
  8009fe:	c1 e0 02             	shl    $0x2,%eax
  800a01:	01 c8                	add    %ecx,%eax
  800a03:	8b 00                	mov    (%eax),%eax
  800a05:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800a08:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a0b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800a10:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800a12:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a15:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1f:	01 c8                	add    %ecx,%eax
  800a21:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a23:	39 c2                	cmp    %eax,%edx
  800a25:	75 09                	jne    800a30 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800a27:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a2e:	eb 12                	jmp    800a42 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a30:	ff 45 e8             	incl   -0x18(%ebp)
  800a33:	a1 24 30 80 00       	mov    0x803024,%eax
  800a38:	8b 50 74             	mov    0x74(%eax),%edx
  800a3b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a3e:	39 c2                	cmp    %eax,%edx
  800a40:	77 86                	ja     8009c8 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a42:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a46:	75 14                	jne    800a5c <CheckWSWithoutLastIndex+0xfd>
			panic(
  800a48:	83 ec 04             	sub    $0x4,%esp
  800a4b:	68 3c 2b 80 00       	push   $0x802b3c
  800a50:	6a 3a                	push   $0x3a
  800a52:	68 30 2b 80 00       	push   $0x802b30
  800a57:	e8 91 fe ff ff       	call   8008ed <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a5c:	ff 45 f0             	incl   -0x10(%ebp)
  800a5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a62:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a65:	0f 8c 30 ff ff ff    	jl     80099b <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a6b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a72:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a79:	eb 27                	jmp    800aa2 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a7b:	a1 24 30 80 00       	mov    0x803024,%eax
  800a80:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800a86:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a89:	89 d0                	mov    %edx,%eax
  800a8b:	c1 e0 02             	shl    $0x2,%eax
  800a8e:	01 d0                	add    %edx,%eax
  800a90:	c1 e0 02             	shl    $0x2,%eax
  800a93:	01 c8                	add    %ecx,%eax
  800a95:	8a 40 04             	mov    0x4(%eax),%al
  800a98:	3c 01                	cmp    $0x1,%al
  800a9a:	75 03                	jne    800a9f <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800a9c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a9f:	ff 45 e0             	incl   -0x20(%ebp)
  800aa2:	a1 24 30 80 00       	mov    0x803024,%eax
  800aa7:	8b 50 74             	mov    0x74(%eax),%edx
  800aaa:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800aad:	39 c2                	cmp    %eax,%edx
  800aaf:	77 ca                	ja     800a7b <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800ab1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ab4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800ab7:	74 14                	je     800acd <CheckWSWithoutLastIndex+0x16e>
		panic(
  800ab9:	83 ec 04             	sub    $0x4,%esp
  800abc:	68 90 2b 80 00       	push   $0x802b90
  800ac1:	6a 44                	push   $0x44
  800ac3:	68 30 2b 80 00       	push   $0x802b30
  800ac8:	e8 20 fe ff ff       	call   8008ed <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800acd:	90                   	nop
  800ace:	c9                   	leave  
  800acf:	c3                   	ret    

00800ad0 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800ad0:	55                   	push   %ebp
  800ad1:	89 e5                	mov    %esp,%ebp
  800ad3:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800ad6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad9:	8b 00                	mov    (%eax),%eax
  800adb:	8d 48 01             	lea    0x1(%eax),%ecx
  800ade:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae1:	89 0a                	mov    %ecx,(%edx)
  800ae3:	8b 55 08             	mov    0x8(%ebp),%edx
  800ae6:	88 d1                	mov    %dl,%cl
  800ae8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aeb:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800aef:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af2:	8b 00                	mov    (%eax),%eax
  800af4:	3d ff 00 00 00       	cmp    $0xff,%eax
  800af9:	75 2c                	jne    800b27 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800afb:	a0 28 30 80 00       	mov    0x803028,%al
  800b00:	0f b6 c0             	movzbl %al,%eax
  800b03:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b06:	8b 12                	mov    (%edx),%edx
  800b08:	89 d1                	mov    %edx,%ecx
  800b0a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b0d:	83 c2 08             	add    $0x8,%edx
  800b10:	83 ec 04             	sub    $0x4,%esp
  800b13:	50                   	push   %eax
  800b14:	51                   	push   %ecx
  800b15:	52                   	push   %edx
  800b16:	e8 4e 14 00 00       	call   801f69 <sys_cputs>
  800b1b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800b1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b21:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2a:	8b 40 04             	mov    0x4(%eax),%eax
  800b2d:	8d 50 01             	lea    0x1(%eax),%edx
  800b30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b33:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b36:	90                   	nop
  800b37:	c9                   	leave  
  800b38:	c3                   	ret    

00800b39 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b39:	55                   	push   %ebp
  800b3a:	89 e5                	mov    %esp,%ebp
  800b3c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b42:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b49:	00 00 00 
	b.cnt = 0;
  800b4c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b53:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b56:	ff 75 0c             	pushl  0xc(%ebp)
  800b59:	ff 75 08             	pushl  0x8(%ebp)
  800b5c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b62:	50                   	push   %eax
  800b63:	68 d0 0a 80 00       	push   $0x800ad0
  800b68:	e8 11 02 00 00       	call   800d7e <vprintfmt>
  800b6d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b70:	a0 28 30 80 00       	mov    0x803028,%al
  800b75:	0f b6 c0             	movzbl %al,%eax
  800b78:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b7e:	83 ec 04             	sub    $0x4,%esp
  800b81:	50                   	push   %eax
  800b82:	52                   	push   %edx
  800b83:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b89:	83 c0 08             	add    $0x8,%eax
  800b8c:	50                   	push   %eax
  800b8d:	e8 d7 13 00 00       	call   801f69 <sys_cputs>
  800b92:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b95:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b9c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800ba2:	c9                   	leave  
  800ba3:	c3                   	ret    

00800ba4 <cprintf>:

int cprintf(const char *fmt, ...) {
  800ba4:	55                   	push   %ebp
  800ba5:	89 e5                	mov    %esp,%ebp
  800ba7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800baa:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800bb1:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bb4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bba:	83 ec 08             	sub    $0x8,%esp
  800bbd:	ff 75 f4             	pushl  -0xc(%ebp)
  800bc0:	50                   	push   %eax
  800bc1:	e8 73 ff ff ff       	call   800b39 <vcprintf>
  800bc6:	83 c4 10             	add    $0x10,%esp
  800bc9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800bcc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bcf:	c9                   	leave  
  800bd0:	c3                   	ret    

00800bd1 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800bd1:	55                   	push   %ebp
  800bd2:	89 e5                	mov    %esp,%ebp
  800bd4:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bd7:	e8 9e 15 00 00       	call   80217a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bdc:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bdf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800be2:	8b 45 08             	mov    0x8(%ebp),%eax
  800be5:	83 ec 08             	sub    $0x8,%esp
  800be8:	ff 75 f4             	pushl  -0xc(%ebp)
  800beb:	50                   	push   %eax
  800bec:	e8 48 ff ff ff       	call   800b39 <vcprintf>
  800bf1:	83 c4 10             	add    $0x10,%esp
  800bf4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800bf7:	e8 98 15 00 00       	call   802194 <sys_enable_interrupt>
	return cnt;
  800bfc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bff:	c9                   	leave  
  800c00:	c3                   	ret    

00800c01 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800c01:	55                   	push   %ebp
  800c02:	89 e5                	mov    %esp,%ebp
  800c04:	53                   	push   %ebx
  800c05:	83 ec 14             	sub    $0x14,%esp
  800c08:	8b 45 10             	mov    0x10(%ebp),%eax
  800c0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c0e:	8b 45 14             	mov    0x14(%ebp),%eax
  800c11:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800c14:	8b 45 18             	mov    0x18(%ebp),%eax
  800c17:	ba 00 00 00 00       	mov    $0x0,%edx
  800c1c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c1f:	77 55                	ja     800c76 <printnum+0x75>
  800c21:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c24:	72 05                	jb     800c2b <printnum+0x2a>
  800c26:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c29:	77 4b                	ja     800c76 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c2b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c2e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c31:	8b 45 18             	mov    0x18(%ebp),%eax
  800c34:	ba 00 00 00 00       	mov    $0x0,%edx
  800c39:	52                   	push   %edx
  800c3a:	50                   	push   %eax
  800c3b:	ff 75 f4             	pushl  -0xc(%ebp)
  800c3e:	ff 75 f0             	pushl  -0x10(%ebp)
  800c41:	e8 72 19 00 00       	call   8025b8 <__udivdi3>
  800c46:	83 c4 10             	add    $0x10,%esp
  800c49:	83 ec 04             	sub    $0x4,%esp
  800c4c:	ff 75 20             	pushl  0x20(%ebp)
  800c4f:	53                   	push   %ebx
  800c50:	ff 75 18             	pushl  0x18(%ebp)
  800c53:	52                   	push   %edx
  800c54:	50                   	push   %eax
  800c55:	ff 75 0c             	pushl  0xc(%ebp)
  800c58:	ff 75 08             	pushl  0x8(%ebp)
  800c5b:	e8 a1 ff ff ff       	call   800c01 <printnum>
  800c60:	83 c4 20             	add    $0x20,%esp
  800c63:	eb 1a                	jmp    800c7f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c65:	83 ec 08             	sub    $0x8,%esp
  800c68:	ff 75 0c             	pushl  0xc(%ebp)
  800c6b:	ff 75 20             	pushl  0x20(%ebp)
  800c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c71:	ff d0                	call   *%eax
  800c73:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c76:	ff 4d 1c             	decl   0x1c(%ebp)
  800c79:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c7d:	7f e6                	jg     800c65 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c7f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c82:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c87:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c8a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c8d:	53                   	push   %ebx
  800c8e:	51                   	push   %ecx
  800c8f:	52                   	push   %edx
  800c90:	50                   	push   %eax
  800c91:	e8 32 1a 00 00       	call   8026c8 <__umoddi3>
  800c96:	83 c4 10             	add    $0x10,%esp
  800c99:	05 f4 2d 80 00       	add    $0x802df4,%eax
  800c9e:	8a 00                	mov    (%eax),%al
  800ca0:	0f be c0             	movsbl %al,%eax
  800ca3:	83 ec 08             	sub    $0x8,%esp
  800ca6:	ff 75 0c             	pushl  0xc(%ebp)
  800ca9:	50                   	push   %eax
  800caa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cad:	ff d0                	call   *%eax
  800caf:	83 c4 10             	add    $0x10,%esp
}
  800cb2:	90                   	nop
  800cb3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800cb6:	c9                   	leave  
  800cb7:	c3                   	ret    

00800cb8 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800cb8:	55                   	push   %ebp
  800cb9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cbb:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cbf:	7e 1c                	jle    800cdd <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc4:	8b 00                	mov    (%eax),%eax
  800cc6:	8d 50 08             	lea    0x8(%eax),%edx
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	89 10                	mov    %edx,(%eax)
  800cce:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd1:	8b 00                	mov    (%eax),%eax
  800cd3:	83 e8 08             	sub    $0x8,%eax
  800cd6:	8b 50 04             	mov    0x4(%eax),%edx
  800cd9:	8b 00                	mov    (%eax),%eax
  800cdb:	eb 40                	jmp    800d1d <getuint+0x65>
	else if (lflag)
  800cdd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ce1:	74 1e                	je     800d01 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce6:	8b 00                	mov    (%eax),%eax
  800ce8:	8d 50 04             	lea    0x4(%eax),%edx
  800ceb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cee:	89 10                	mov    %edx,(%eax)
  800cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf3:	8b 00                	mov    (%eax),%eax
  800cf5:	83 e8 04             	sub    $0x4,%eax
  800cf8:	8b 00                	mov    (%eax),%eax
  800cfa:	ba 00 00 00 00       	mov    $0x0,%edx
  800cff:	eb 1c                	jmp    800d1d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800d01:	8b 45 08             	mov    0x8(%ebp),%eax
  800d04:	8b 00                	mov    (%eax),%eax
  800d06:	8d 50 04             	lea    0x4(%eax),%edx
  800d09:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0c:	89 10                	mov    %edx,(%eax)
  800d0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d11:	8b 00                	mov    (%eax),%eax
  800d13:	83 e8 04             	sub    $0x4,%eax
  800d16:	8b 00                	mov    (%eax),%eax
  800d18:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800d1d:	5d                   	pop    %ebp
  800d1e:	c3                   	ret    

00800d1f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d1f:	55                   	push   %ebp
  800d20:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d22:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d26:	7e 1c                	jle    800d44 <getint+0x25>
		return va_arg(*ap, long long);
  800d28:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2b:	8b 00                	mov    (%eax),%eax
  800d2d:	8d 50 08             	lea    0x8(%eax),%edx
  800d30:	8b 45 08             	mov    0x8(%ebp),%eax
  800d33:	89 10                	mov    %edx,(%eax)
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	8b 00                	mov    (%eax),%eax
  800d3a:	83 e8 08             	sub    $0x8,%eax
  800d3d:	8b 50 04             	mov    0x4(%eax),%edx
  800d40:	8b 00                	mov    (%eax),%eax
  800d42:	eb 38                	jmp    800d7c <getint+0x5d>
	else if (lflag)
  800d44:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d48:	74 1a                	je     800d64 <getint+0x45>
		return va_arg(*ap, long);
  800d4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4d:	8b 00                	mov    (%eax),%eax
  800d4f:	8d 50 04             	lea    0x4(%eax),%edx
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
  800d55:	89 10                	mov    %edx,(%eax)
  800d57:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5a:	8b 00                	mov    (%eax),%eax
  800d5c:	83 e8 04             	sub    $0x4,%eax
  800d5f:	8b 00                	mov    (%eax),%eax
  800d61:	99                   	cltd   
  800d62:	eb 18                	jmp    800d7c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d64:	8b 45 08             	mov    0x8(%ebp),%eax
  800d67:	8b 00                	mov    (%eax),%eax
  800d69:	8d 50 04             	lea    0x4(%eax),%edx
  800d6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6f:	89 10                	mov    %edx,(%eax)
  800d71:	8b 45 08             	mov    0x8(%ebp),%eax
  800d74:	8b 00                	mov    (%eax),%eax
  800d76:	83 e8 04             	sub    $0x4,%eax
  800d79:	8b 00                	mov    (%eax),%eax
  800d7b:	99                   	cltd   
}
  800d7c:	5d                   	pop    %ebp
  800d7d:	c3                   	ret    

00800d7e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d7e:	55                   	push   %ebp
  800d7f:	89 e5                	mov    %esp,%ebp
  800d81:	56                   	push   %esi
  800d82:	53                   	push   %ebx
  800d83:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d86:	eb 17                	jmp    800d9f <vprintfmt+0x21>
			if (ch == '\0')
  800d88:	85 db                	test   %ebx,%ebx
  800d8a:	0f 84 af 03 00 00    	je     80113f <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d90:	83 ec 08             	sub    $0x8,%esp
  800d93:	ff 75 0c             	pushl  0xc(%ebp)
  800d96:	53                   	push   %ebx
  800d97:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9a:	ff d0                	call   *%eax
  800d9c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d9f:	8b 45 10             	mov    0x10(%ebp),%eax
  800da2:	8d 50 01             	lea    0x1(%eax),%edx
  800da5:	89 55 10             	mov    %edx,0x10(%ebp)
  800da8:	8a 00                	mov    (%eax),%al
  800daa:	0f b6 d8             	movzbl %al,%ebx
  800dad:	83 fb 25             	cmp    $0x25,%ebx
  800db0:	75 d6                	jne    800d88 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800db2:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800db6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800dbd:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800dc4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800dcb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800dd2:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd5:	8d 50 01             	lea    0x1(%eax),%edx
  800dd8:	89 55 10             	mov    %edx,0x10(%ebp)
  800ddb:	8a 00                	mov    (%eax),%al
  800ddd:	0f b6 d8             	movzbl %al,%ebx
  800de0:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800de3:	83 f8 55             	cmp    $0x55,%eax
  800de6:	0f 87 2b 03 00 00    	ja     801117 <vprintfmt+0x399>
  800dec:	8b 04 85 18 2e 80 00 	mov    0x802e18(,%eax,4),%eax
  800df3:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800df5:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800df9:	eb d7                	jmp    800dd2 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800dfb:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800dff:	eb d1                	jmp    800dd2 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e01:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800e08:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e0b:	89 d0                	mov    %edx,%eax
  800e0d:	c1 e0 02             	shl    $0x2,%eax
  800e10:	01 d0                	add    %edx,%eax
  800e12:	01 c0                	add    %eax,%eax
  800e14:	01 d8                	add    %ebx,%eax
  800e16:	83 e8 30             	sub    $0x30,%eax
  800e19:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800e1c:	8b 45 10             	mov    0x10(%ebp),%eax
  800e1f:	8a 00                	mov    (%eax),%al
  800e21:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e24:	83 fb 2f             	cmp    $0x2f,%ebx
  800e27:	7e 3e                	jle    800e67 <vprintfmt+0xe9>
  800e29:	83 fb 39             	cmp    $0x39,%ebx
  800e2c:	7f 39                	jg     800e67 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e2e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e31:	eb d5                	jmp    800e08 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e33:	8b 45 14             	mov    0x14(%ebp),%eax
  800e36:	83 c0 04             	add    $0x4,%eax
  800e39:	89 45 14             	mov    %eax,0x14(%ebp)
  800e3c:	8b 45 14             	mov    0x14(%ebp),%eax
  800e3f:	83 e8 04             	sub    $0x4,%eax
  800e42:	8b 00                	mov    (%eax),%eax
  800e44:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e47:	eb 1f                	jmp    800e68 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e49:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e4d:	79 83                	jns    800dd2 <vprintfmt+0x54>
				width = 0;
  800e4f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e56:	e9 77 ff ff ff       	jmp    800dd2 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e5b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e62:	e9 6b ff ff ff       	jmp    800dd2 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e67:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e68:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e6c:	0f 89 60 ff ff ff    	jns    800dd2 <vprintfmt+0x54>
				width = precision, precision = -1;
  800e72:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e75:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e78:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e7f:	e9 4e ff ff ff       	jmp    800dd2 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e84:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e87:	e9 46 ff ff ff       	jmp    800dd2 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e8c:	8b 45 14             	mov    0x14(%ebp),%eax
  800e8f:	83 c0 04             	add    $0x4,%eax
  800e92:	89 45 14             	mov    %eax,0x14(%ebp)
  800e95:	8b 45 14             	mov    0x14(%ebp),%eax
  800e98:	83 e8 04             	sub    $0x4,%eax
  800e9b:	8b 00                	mov    (%eax),%eax
  800e9d:	83 ec 08             	sub    $0x8,%esp
  800ea0:	ff 75 0c             	pushl  0xc(%ebp)
  800ea3:	50                   	push   %eax
  800ea4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea7:	ff d0                	call   *%eax
  800ea9:	83 c4 10             	add    $0x10,%esp
			break;
  800eac:	e9 89 02 00 00       	jmp    80113a <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800eb1:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb4:	83 c0 04             	add    $0x4,%eax
  800eb7:	89 45 14             	mov    %eax,0x14(%ebp)
  800eba:	8b 45 14             	mov    0x14(%ebp),%eax
  800ebd:	83 e8 04             	sub    $0x4,%eax
  800ec0:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ec2:	85 db                	test   %ebx,%ebx
  800ec4:	79 02                	jns    800ec8 <vprintfmt+0x14a>
				err = -err;
  800ec6:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ec8:	83 fb 64             	cmp    $0x64,%ebx
  800ecb:	7f 0b                	jg     800ed8 <vprintfmt+0x15a>
  800ecd:	8b 34 9d 60 2c 80 00 	mov    0x802c60(,%ebx,4),%esi
  800ed4:	85 f6                	test   %esi,%esi
  800ed6:	75 19                	jne    800ef1 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ed8:	53                   	push   %ebx
  800ed9:	68 05 2e 80 00       	push   $0x802e05
  800ede:	ff 75 0c             	pushl  0xc(%ebp)
  800ee1:	ff 75 08             	pushl  0x8(%ebp)
  800ee4:	e8 5e 02 00 00       	call   801147 <printfmt>
  800ee9:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800eec:	e9 49 02 00 00       	jmp    80113a <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ef1:	56                   	push   %esi
  800ef2:	68 0e 2e 80 00       	push   $0x802e0e
  800ef7:	ff 75 0c             	pushl  0xc(%ebp)
  800efa:	ff 75 08             	pushl  0x8(%ebp)
  800efd:	e8 45 02 00 00       	call   801147 <printfmt>
  800f02:	83 c4 10             	add    $0x10,%esp
			break;
  800f05:	e9 30 02 00 00       	jmp    80113a <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800f0a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f0d:	83 c0 04             	add    $0x4,%eax
  800f10:	89 45 14             	mov    %eax,0x14(%ebp)
  800f13:	8b 45 14             	mov    0x14(%ebp),%eax
  800f16:	83 e8 04             	sub    $0x4,%eax
  800f19:	8b 30                	mov    (%eax),%esi
  800f1b:	85 f6                	test   %esi,%esi
  800f1d:	75 05                	jne    800f24 <vprintfmt+0x1a6>
				p = "(null)";
  800f1f:	be 11 2e 80 00       	mov    $0x802e11,%esi
			if (width > 0 && padc != '-')
  800f24:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f28:	7e 6d                	jle    800f97 <vprintfmt+0x219>
  800f2a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f2e:	74 67                	je     800f97 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f30:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f33:	83 ec 08             	sub    $0x8,%esp
  800f36:	50                   	push   %eax
  800f37:	56                   	push   %esi
  800f38:	e8 12 05 00 00       	call   80144f <strnlen>
  800f3d:	83 c4 10             	add    $0x10,%esp
  800f40:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f43:	eb 16                	jmp    800f5b <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f45:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f49:	83 ec 08             	sub    $0x8,%esp
  800f4c:	ff 75 0c             	pushl  0xc(%ebp)
  800f4f:	50                   	push   %eax
  800f50:	8b 45 08             	mov    0x8(%ebp),%eax
  800f53:	ff d0                	call   *%eax
  800f55:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f58:	ff 4d e4             	decl   -0x1c(%ebp)
  800f5b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f5f:	7f e4                	jg     800f45 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f61:	eb 34                	jmp    800f97 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f63:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f67:	74 1c                	je     800f85 <vprintfmt+0x207>
  800f69:	83 fb 1f             	cmp    $0x1f,%ebx
  800f6c:	7e 05                	jle    800f73 <vprintfmt+0x1f5>
  800f6e:	83 fb 7e             	cmp    $0x7e,%ebx
  800f71:	7e 12                	jle    800f85 <vprintfmt+0x207>
					putch('?', putdat);
  800f73:	83 ec 08             	sub    $0x8,%esp
  800f76:	ff 75 0c             	pushl  0xc(%ebp)
  800f79:	6a 3f                	push   $0x3f
  800f7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7e:	ff d0                	call   *%eax
  800f80:	83 c4 10             	add    $0x10,%esp
  800f83:	eb 0f                	jmp    800f94 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f85:	83 ec 08             	sub    $0x8,%esp
  800f88:	ff 75 0c             	pushl  0xc(%ebp)
  800f8b:	53                   	push   %ebx
  800f8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8f:	ff d0                	call   *%eax
  800f91:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f94:	ff 4d e4             	decl   -0x1c(%ebp)
  800f97:	89 f0                	mov    %esi,%eax
  800f99:	8d 70 01             	lea    0x1(%eax),%esi
  800f9c:	8a 00                	mov    (%eax),%al
  800f9e:	0f be d8             	movsbl %al,%ebx
  800fa1:	85 db                	test   %ebx,%ebx
  800fa3:	74 24                	je     800fc9 <vprintfmt+0x24b>
  800fa5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800fa9:	78 b8                	js     800f63 <vprintfmt+0x1e5>
  800fab:	ff 4d e0             	decl   -0x20(%ebp)
  800fae:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800fb2:	79 af                	jns    800f63 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fb4:	eb 13                	jmp    800fc9 <vprintfmt+0x24b>
				putch(' ', putdat);
  800fb6:	83 ec 08             	sub    $0x8,%esp
  800fb9:	ff 75 0c             	pushl  0xc(%ebp)
  800fbc:	6a 20                	push   $0x20
  800fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc1:	ff d0                	call   *%eax
  800fc3:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fc6:	ff 4d e4             	decl   -0x1c(%ebp)
  800fc9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fcd:	7f e7                	jg     800fb6 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fcf:	e9 66 01 00 00       	jmp    80113a <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fd4:	83 ec 08             	sub    $0x8,%esp
  800fd7:	ff 75 e8             	pushl  -0x18(%ebp)
  800fda:	8d 45 14             	lea    0x14(%ebp),%eax
  800fdd:	50                   	push   %eax
  800fde:	e8 3c fd ff ff       	call   800d1f <getint>
  800fe3:	83 c4 10             	add    $0x10,%esp
  800fe6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fef:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ff2:	85 d2                	test   %edx,%edx
  800ff4:	79 23                	jns    801019 <vprintfmt+0x29b>
				putch('-', putdat);
  800ff6:	83 ec 08             	sub    $0x8,%esp
  800ff9:	ff 75 0c             	pushl  0xc(%ebp)
  800ffc:	6a 2d                	push   $0x2d
  800ffe:	8b 45 08             	mov    0x8(%ebp),%eax
  801001:	ff d0                	call   *%eax
  801003:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801006:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801009:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80100c:	f7 d8                	neg    %eax
  80100e:	83 d2 00             	adc    $0x0,%edx
  801011:	f7 da                	neg    %edx
  801013:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801016:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801019:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801020:	e9 bc 00 00 00       	jmp    8010e1 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801025:	83 ec 08             	sub    $0x8,%esp
  801028:	ff 75 e8             	pushl  -0x18(%ebp)
  80102b:	8d 45 14             	lea    0x14(%ebp),%eax
  80102e:	50                   	push   %eax
  80102f:	e8 84 fc ff ff       	call   800cb8 <getuint>
  801034:	83 c4 10             	add    $0x10,%esp
  801037:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80103a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80103d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801044:	e9 98 00 00 00       	jmp    8010e1 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801049:	83 ec 08             	sub    $0x8,%esp
  80104c:	ff 75 0c             	pushl  0xc(%ebp)
  80104f:	6a 58                	push   $0x58
  801051:	8b 45 08             	mov    0x8(%ebp),%eax
  801054:	ff d0                	call   *%eax
  801056:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801059:	83 ec 08             	sub    $0x8,%esp
  80105c:	ff 75 0c             	pushl  0xc(%ebp)
  80105f:	6a 58                	push   $0x58
  801061:	8b 45 08             	mov    0x8(%ebp),%eax
  801064:	ff d0                	call   *%eax
  801066:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801069:	83 ec 08             	sub    $0x8,%esp
  80106c:	ff 75 0c             	pushl  0xc(%ebp)
  80106f:	6a 58                	push   $0x58
  801071:	8b 45 08             	mov    0x8(%ebp),%eax
  801074:	ff d0                	call   *%eax
  801076:	83 c4 10             	add    $0x10,%esp
			break;
  801079:	e9 bc 00 00 00       	jmp    80113a <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80107e:	83 ec 08             	sub    $0x8,%esp
  801081:	ff 75 0c             	pushl  0xc(%ebp)
  801084:	6a 30                	push   $0x30
  801086:	8b 45 08             	mov    0x8(%ebp),%eax
  801089:	ff d0                	call   *%eax
  80108b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80108e:	83 ec 08             	sub    $0x8,%esp
  801091:	ff 75 0c             	pushl  0xc(%ebp)
  801094:	6a 78                	push   $0x78
  801096:	8b 45 08             	mov    0x8(%ebp),%eax
  801099:	ff d0                	call   *%eax
  80109b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80109e:	8b 45 14             	mov    0x14(%ebp),%eax
  8010a1:	83 c0 04             	add    $0x4,%eax
  8010a4:	89 45 14             	mov    %eax,0x14(%ebp)
  8010a7:	8b 45 14             	mov    0x14(%ebp),%eax
  8010aa:	83 e8 04             	sub    $0x4,%eax
  8010ad:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8010af:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010b2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8010b9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8010c0:	eb 1f                	jmp    8010e1 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010c2:	83 ec 08             	sub    $0x8,%esp
  8010c5:	ff 75 e8             	pushl  -0x18(%ebp)
  8010c8:	8d 45 14             	lea    0x14(%ebp),%eax
  8010cb:	50                   	push   %eax
  8010cc:	e8 e7 fb ff ff       	call   800cb8 <getuint>
  8010d1:	83 c4 10             	add    $0x10,%esp
  8010d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010d7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010da:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010e1:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010e8:	83 ec 04             	sub    $0x4,%esp
  8010eb:	52                   	push   %edx
  8010ec:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010ef:	50                   	push   %eax
  8010f0:	ff 75 f4             	pushl  -0xc(%ebp)
  8010f3:	ff 75 f0             	pushl  -0x10(%ebp)
  8010f6:	ff 75 0c             	pushl  0xc(%ebp)
  8010f9:	ff 75 08             	pushl  0x8(%ebp)
  8010fc:	e8 00 fb ff ff       	call   800c01 <printnum>
  801101:	83 c4 20             	add    $0x20,%esp
			break;
  801104:	eb 34                	jmp    80113a <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801106:	83 ec 08             	sub    $0x8,%esp
  801109:	ff 75 0c             	pushl  0xc(%ebp)
  80110c:	53                   	push   %ebx
  80110d:	8b 45 08             	mov    0x8(%ebp),%eax
  801110:	ff d0                	call   *%eax
  801112:	83 c4 10             	add    $0x10,%esp
			break;
  801115:	eb 23                	jmp    80113a <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801117:	83 ec 08             	sub    $0x8,%esp
  80111a:	ff 75 0c             	pushl  0xc(%ebp)
  80111d:	6a 25                	push   $0x25
  80111f:	8b 45 08             	mov    0x8(%ebp),%eax
  801122:	ff d0                	call   *%eax
  801124:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801127:	ff 4d 10             	decl   0x10(%ebp)
  80112a:	eb 03                	jmp    80112f <vprintfmt+0x3b1>
  80112c:	ff 4d 10             	decl   0x10(%ebp)
  80112f:	8b 45 10             	mov    0x10(%ebp),%eax
  801132:	48                   	dec    %eax
  801133:	8a 00                	mov    (%eax),%al
  801135:	3c 25                	cmp    $0x25,%al
  801137:	75 f3                	jne    80112c <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801139:	90                   	nop
		}
	}
  80113a:	e9 47 fc ff ff       	jmp    800d86 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80113f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801140:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801143:	5b                   	pop    %ebx
  801144:	5e                   	pop    %esi
  801145:	5d                   	pop    %ebp
  801146:	c3                   	ret    

00801147 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801147:	55                   	push   %ebp
  801148:	89 e5                	mov    %esp,%ebp
  80114a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80114d:	8d 45 10             	lea    0x10(%ebp),%eax
  801150:	83 c0 04             	add    $0x4,%eax
  801153:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801156:	8b 45 10             	mov    0x10(%ebp),%eax
  801159:	ff 75 f4             	pushl  -0xc(%ebp)
  80115c:	50                   	push   %eax
  80115d:	ff 75 0c             	pushl  0xc(%ebp)
  801160:	ff 75 08             	pushl  0x8(%ebp)
  801163:	e8 16 fc ff ff       	call   800d7e <vprintfmt>
  801168:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80116b:	90                   	nop
  80116c:	c9                   	leave  
  80116d:	c3                   	ret    

0080116e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80116e:	55                   	push   %ebp
  80116f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801171:	8b 45 0c             	mov    0xc(%ebp),%eax
  801174:	8b 40 08             	mov    0x8(%eax),%eax
  801177:	8d 50 01             	lea    0x1(%eax),%edx
  80117a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801180:	8b 45 0c             	mov    0xc(%ebp),%eax
  801183:	8b 10                	mov    (%eax),%edx
  801185:	8b 45 0c             	mov    0xc(%ebp),%eax
  801188:	8b 40 04             	mov    0x4(%eax),%eax
  80118b:	39 c2                	cmp    %eax,%edx
  80118d:	73 12                	jae    8011a1 <sprintputch+0x33>
		*b->buf++ = ch;
  80118f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801192:	8b 00                	mov    (%eax),%eax
  801194:	8d 48 01             	lea    0x1(%eax),%ecx
  801197:	8b 55 0c             	mov    0xc(%ebp),%edx
  80119a:	89 0a                	mov    %ecx,(%edx)
  80119c:	8b 55 08             	mov    0x8(%ebp),%edx
  80119f:	88 10                	mov    %dl,(%eax)
}
  8011a1:	90                   	nop
  8011a2:	5d                   	pop    %ebp
  8011a3:	c3                   	ret    

008011a4 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8011a4:	55                   	push   %ebp
  8011a5:	89 e5                	mov    %esp,%ebp
  8011a7:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8011aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ad:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8011b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b9:	01 d0                	add    %edx,%eax
  8011bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011be:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011c5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011c9:	74 06                	je     8011d1 <vsnprintf+0x2d>
  8011cb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011cf:	7f 07                	jg     8011d8 <vsnprintf+0x34>
		return -E_INVAL;
  8011d1:	b8 03 00 00 00       	mov    $0x3,%eax
  8011d6:	eb 20                	jmp    8011f8 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011d8:	ff 75 14             	pushl  0x14(%ebp)
  8011db:	ff 75 10             	pushl  0x10(%ebp)
  8011de:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011e1:	50                   	push   %eax
  8011e2:	68 6e 11 80 00       	push   $0x80116e
  8011e7:	e8 92 fb ff ff       	call   800d7e <vprintfmt>
  8011ec:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011f2:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011f8:	c9                   	leave  
  8011f9:	c3                   	ret    

008011fa <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011fa:	55                   	push   %ebp
  8011fb:	89 e5                	mov    %esp,%ebp
  8011fd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801200:	8d 45 10             	lea    0x10(%ebp),%eax
  801203:	83 c0 04             	add    $0x4,%eax
  801206:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801209:	8b 45 10             	mov    0x10(%ebp),%eax
  80120c:	ff 75 f4             	pushl  -0xc(%ebp)
  80120f:	50                   	push   %eax
  801210:	ff 75 0c             	pushl  0xc(%ebp)
  801213:	ff 75 08             	pushl  0x8(%ebp)
  801216:	e8 89 ff ff ff       	call   8011a4 <vsnprintf>
  80121b:	83 c4 10             	add    $0x10,%esp
  80121e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801221:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801224:	c9                   	leave  
  801225:	c3                   	ret    

00801226 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801226:	55                   	push   %ebp
  801227:	89 e5                	mov    %esp,%ebp
  801229:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80122c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801230:	74 13                	je     801245 <readline+0x1f>
		cprintf("%s", prompt);
  801232:	83 ec 08             	sub    $0x8,%esp
  801235:	ff 75 08             	pushl  0x8(%ebp)
  801238:	68 70 2f 80 00       	push   $0x802f70
  80123d:	e8 62 f9 ff ff       	call   800ba4 <cprintf>
  801242:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801245:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80124c:	83 ec 0c             	sub    $0xc,%esp
  80124f:	6a 00                	push   $0x0
  801251:	e8 65 f5 ff ff       	call   8007bb <iscons>
  801256:	83 c4 10             	add    $0x10,%esp
  801259:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80125c:	e8 0c f5 ff ff       	call   80076d <getchar>
  801261:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801264:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801268:	79 22                	jns    80128c <readline+0x66>
			if (c != -E_EOF)
  80126a:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80126e:	0f 84 ad 00 00 00    	je     801321 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801274:	83 ec 08             	sub    $0x8,%esp
  801277:	ff 75 ec             	pushl  -0x14(%ebp)
  80127a:	68 73 2f 80 00       	push   $0x802f73
  80127f:	e8 20 f9 ff ff       	call   800ba4 <cprintf>
  801284:	83 c4 10             	add    $0x10,%esp
			return;
  801287:	e9 95 00 00 00       	jmp    801321 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80128c:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801290:	7e 34                	jle    8012c6 <readline+0xa0>
  801292:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801299:	7f 2b                	jg     8012c6 <readline+0xa0>
			if (echoing)
  80129b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80129f:	74 0e                	je     8012af <readline+0x89>
				cputchar(c);
  8012a1:	83 ec 0c             	sub    $0xc,%esp
  8012a4:	ff 75 ec             	pushl  -0x14(%ebp)
  8012a7:	e8 79 f4 ff ff       	call   800725 <cputchar>
  8012ac:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8012af:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012b2:	8d 50 01             	lea    0x1(%eax),%edx
  8012b5:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8012b8:	89 c2                	mov    %eax,%edx
  8012ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012bd:	01 d0                	add    %edx,%eax
  8012bf:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012c2:	88 10                	mov    %dl,(%eax)
  8012c4:	eb 56                	jmp    80131c <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8012c6:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012ca:	75 1f                	jne    8012eb <readline+0xc5>
  8012cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012d0:	7e 19                	jle    8012eb <readline+0xc5>
			if (echoing)
  8012d2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012d6:	74 0e                	je     8012e6 <readline+0xc0>
				cputchar(c);
  8012d8:	83 ec 0c             	sub    $0xc,%esp
  8012db:	ff 75 ec             	pushl  -0x14(%ebp)
  8012de:	e8 42 f4 ff ff       	call   800725 <cputchar>
  8012e3:	83 c4 10             	add    $0x10,%esp

			i--;
  8012e6:	ff 4d f4             	decl   -0xc(%ebp)
  8012e9:	eb 31                	jmp    80131c <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8012eb:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012ef:	74 0a                	je     8012fb <readline+0xd5>
  8012f1:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012f5:	0f 85 61 ff ff ff    	jne    80125c <readline+0x36>
			if (echoing)
  8012fb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012ff:	74 0e                	je     80130f <readline+0xe9>
				cputchar(c);
  801301:	83 ec 0c             	sub    $0xc,%esp
  801304:	ff 75 ec             	pushl  -0x14(%ebp)
  801307:	e8 19 f4 ff ff       	call   800725 <cputchar>
  80130c:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80130f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801312:	8b 45 0c             	mov    0xc(%ebp),%eax
  801315:	01 d0                	add    %edx,%eax
  801317:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80131a:	eb 06                	jmp    801322 <readline+0xfc>
		}
	}
  80131c:	e9 3b ff ff ff       	jmp    80125c <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801321:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801322:	c9                   	leave  
  801323:	c3                   	ret    

00801324 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801324:	55                   	push   %ebp
  801325:	89 e5                	mov    %esp,%ebp
  801327:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80132a:	e8 4b 0e 00 00       	call   80217a <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80132f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801333:	74 13                	je     801348 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801335:	83 ec 08             	sub    $0x8,%esp
  801338:	ff 75 08             	pushl  0x8(%ebp)
  80133b:	68 70 2f 80 00       	push   $0x802f70
  801340:	e8 5f f8 ff ff       	call   800ba4 <cprintf>
  801345:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801348:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80134f:	83 ec 0c             	sub    $0xc,%esp
  801352:	6a 00                	push   $0x0
  801354:	e8 62 f4 ff ff       	call   8007bb <iscons>
  801359:	83 c4 10             	add    $0x10,%esp
  80135c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80135f:	e8 09 f4 ff ff       	call   80076d <getchar>
  801364:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801367:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80136b:	79 23                	jns    801390 <atomic_readline+0x6c>
			if (c != -E_EOF)
  80136d:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801371:	74 13                	je     801386 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801373:	83 ec 08             	sub    $0x8,%esp
  801376:	ff 75 ec             	pushl  -0x14(%ebp)
  801379:	68 73 2f 80 00       	push   $0x802f73
  80137e:	e8 21 f8 ff ff       	call   800ba4 <cprintf>
  801383:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801386:	e8 09 0e 00 00       	call   802194 <sys_enable_interrupt>
			return;
  80138b:	e9 9a 00 00 00       	jmp    80142a <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801390:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801394:	7e 34                	jle    8013ca <atomic_readline+0xa6>
  801396:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80139d:	7f 2b                	jg     8013ca <atomic_readline+0xa6>
			if (echoing)
  80139f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013a3:	74 0e                	je     8013b3 <atomic_readline+0x8f>
				cputchar(c);
  8013a5:	83 ec 0c             	sub    $0xc,%esp
  8013a8:	ff 75 ec             	pushl  -0x14(%ebp)
  8013ab:	e8 75 f3 ff ff       	call   800725 <cputchar>
  8013b0:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8013b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013b6:	8d 50 01             	lea    0x1(%eax),%edx
  8013b9:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8013bc:	89 c2                	mov    %eax,%edx
  8013be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c1:	01 d0                	add    %edx,%eax
  8013c3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013c6:	88 10                	mov    %dl,(%eax)
  8013c8:	eb 5b                	jmp    801425 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8013ca:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8013ce:	75 1f                	jne    8013ef <atomic_readline+0xcb>
  8013d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8013d4:	7e 19                	jle    8013ef <atomic_readline+0xcb>
			if (echoing)
  8013d6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013da:	74 0e                	je     8013ea <atomic_readline+0xc6>
				cputchar(c);
  8013dc:	83 ec 0c             	sub    $0xc,%esp
  8013df:	ff 75 ec             	pushl  -0x14(%ebp)
  8013e2:	e8 3e f3 ff ff       	call   800725 <cputchar>
  8013e7:	83 c4 10             	add    $0x10,%esp
			i--;
  8013ea:	ff 4d f4             	decl   -0xc(%ebp)
  8013ed:	eb 36                	jmp    801425 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8013ef:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8013f3:	74 0a                	je     8013ff <atomic_readline+0xdb>
  8013f5:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8013f9:	0f 85 60 ff ff ff    	jne    80135f <atomic_readline+0x3b>
			if (echoing)
  8013ff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801403:	74 0e                	je     801413 <atomic_readline+0xef>
				cputchar(c);
  801405:	83 ec 0c             	sub    $0xc,%esp
  801408:	ff 75 ec             	pushl  -0x14(%ebp)
  80140b:	e8 15 f3 ff ff       	call   800725 <cputchar>
  801410:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801413:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801416:	8b 45 0c             	mov    0xc(%ebp),%eax
  801419:	01 d0                	add    %edx,%eax
  80141b:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80141e:	e8 71 0d 00 00       	call   802194 <sys_enable_interrupt>
			return;
  801423:	eb 05                	jmp    80142a <atomic_readline+0x106>
		}
	}
  801425:	e9 35 ff ff ff       	jmp    80135f <atomic_readline+0x3b>
}
  80142a:	c9                   	leave  
  80142b:	c3                   	ret    

0080142c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80142c:	55                   	push   %ebp
  80142d:	89 e5                	mov    %esp,%ebp
  80142f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801432:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801439:	eb 06                	jmp    801441 <strlen+0x15>
		n++;
  80143b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80143e:	ff 45 08             	incl   0x8(%ebp)
  801441:	8b 45 08             	mov    0x8(%ebp),%eax
  801444:	8a 00                	mov    (%eax),%al
  801446:	84 c0                	test   %al,%al
  801448:	75 f1                	jne    80143b <strlen+0xf>
		n++;
	return n;
  80144a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80144d:	c9                   	leave  
  80144e:	c3                   	ret    

0080144f <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80144f:	55                   	push   %ebp
  801450:	89 e5                	mov    %esp,%ebp
  801452:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801455:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80145c:	eb 09                	jmp    801467 <strnlen+0x18>
		n++;
  80145e:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801461:	ff 45 08             	incl   0x8(%ebp)
  801464:	ff 4d 0c             	decl   0xc(%ebp)
  801467:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80146b:	74 09                	je     801476 <strnlen+0x27>
  80146d:	8b 45 08             	mov    0x8(%ebp),%eax
  801470:	8a 00                	mov    (%eax),%al
  801472:	84 c0                	test   %al,%al
  801474:	75 e8                	jne    80145e <strnlen+0xf>
		n++;
	return n;
  801476:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801479:	c9                   	leave  
  80147a:	c3                   	ret    

0080147b <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80147b:	55                   	push   %ebp
  80147c:	89 e5                	mov    %esp,%ebp
  80147e:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801481:	8b 45 08             	mov    0x8(%ebp),%eax
  801484:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801487:	90                   	nop
  801488:	8b 45 08             	mov    0x8(%ebp),%eax
  80148b:	8d 50 01             	lea    0x1(%eax),%edx
  80148e:	89 55 08             	mov    %edx,0x8(%ebp)
  801491:	8b 55 0c             	mov    0xc(%ebp),%edx
  801494:	8d 4a 01             	lea    0x1(%edx),%ecx
  801497:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80149a:	8a 12                	mov    (%edx),%dl
  80149c:	88 10                	mov    %dl,(%eax)
  80149e:	8a 00                	mov    (%eax),%al
  8014a0:	84 c0                	test   %al,%al
  8014a2:	75 e4                	jne    801488 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8014a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8014a7:	c9                   	leave  
  8014a8:	c3                   	ret    

008014a9 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8014a9:	55                   	push   %ebp
  8014aa:	89 e5                	mov    %esp,%ebp
  8014ac:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8014af:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8014b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014bc:	eb 1f                	jmp    8014dd <strncpy+0x34>
		*dst++ = *src;
  8014be:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c1:	8d 50 01             	lea    0x1(%eax),%edx
  8014c4:	89 55 08             	mov    %edx,0x8(%ebp)
  8014c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ca:	8a 12                	mov    (%edx),%dl
  8014cc:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d1:	8a 00                	mov    (%eax),%al
  8014d3:	84 c0                	test   %al,%al
  8014d5:	74 03                	je     8014da <strncpy+0x31>
			src++;
  8014d7:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014da:	ff 45 fc             	incl   -0x4(%ebp)
  8014dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014e0:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014e3:	72 d9                	jb     8014be <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014e8:	c9                   	leave  
  8014e9:	c3                   	ret    

008014ea <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014ea:	55                   	push   %ebp
  8014eb:	89 e5                	mov    %esp,%ebp
  8014ed:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014f6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014fa:	74 30                	je     80152c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8014fc:	eb 16                	jmp    801514 <strlcpy+0x2a>
			*dst++ = *src++;
  8014fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801501:	8d 50 01             	lea    0x1(%eax),%edx
  801504:	89 55 08             	mov    %edx,0x8(%ebp)
  801507:	8b 55 0c             	mov    0xc(%ebp),%edx
  80150a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80150d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801510:	8a 12                	mov    (%edx),%dl
  801512:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801514:	ff 4d 10             	decl   0x10(%ebp)
  801517:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80151b:	74 09                	je     801526 <strlcpy+0x3c>
  80151d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801520:	8a 00                	mov    (%eax),%al
  801522:	84 c0                	test   %al,%al
  801524:	75 d8                	jne    8014fe <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801526:	8b 45 08             	mov    0x8(%ebp),%eax
  801529:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80152c:	8b 55 08             	mov    0x8(%ebp),%edx
  80152f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801532:	29 c2                	sub    %eax,%edx
  801534:	89 d0                	mov    %edx,%eax
}
  801536:	c9                   	leave  
  801537:	c3                   	ret    

00801538 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801538:	55                   	push   %ebp
  801539:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80153b:	eb 06                	jmp    801543 <strcmp+0xb>
		p++, q++;
  80153d:	ff 45 08             	incl   0x8(%ebp)
  801540:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801543:	8b 45 08             	mov    0x8(%ebp),%eax
  801546:	8a 00                	mov    (%eax),%al
  801548:	84 c0                	test   %al,%al
  80154a:	74 0e                	je     80155a <strcmp+0x22>
  80154c:	8b 45 08             	mov    0x8(%ebp),%eax
  80154f:	8a 10                	mov    (%eax),%dl
  801551:	8b 45 0c             	mov    0xc(%ebp),%eax
  801554:	8a 00                	mov    (%eax),%al
  801556:	38 c2                	cmp    %al,%dl
  801558:	74 e3                	je     80153d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80155a:	8b 45 08             	mov    0x8(%ebp),%eax
  80155d:	8a 00                	mov    (%eax),%al
  80155f:	0f b6 d0             	movzbl %al,%edx
  801562:	8b 45 0c             	mov    0xc(%ebp),%eax
  801565:	8a 00                	mov    (%eax),%al
  801567:	0f b6 c0             	movzbl %al,%eax
  80156a:	29 c2                	sub    %eax,%edx
  80156c:	89 d0                	mov    %edx,%eax
}
  80156e:	5d                   	pop    %ebp
  80156f:	c3                   	ret    

00801570 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801570:	55                   	push   %ebp
  801571:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801573:	eb 09                	jmp    80157e <strncmp+0xe>
		n--, p++, q++;
  801575:	ff 4d 10             	decl   0x10(%ebp)
  801578:	ff 45 08             	incl   0x8(%ebp)
  80157b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80157e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801582:	74 17                	je     80159b <strncmp+0x2b>
  801584:	8b 45 08             	mov    0x8(%ebp),%eax
  801587:	8a 00                	mov    (%eax),%al
  801589:	84 c0                	test   %al,%al
  80158b:	74 0e                	je     80159b <strncmp+0x2b>
  80158d:	8b 45 08             	mov    0x8(%ebp),%eax
  801590:	8a 10                	mov    (%eax),%dl
  801592:	8b 45 0c             	mov    0xc(%ebp),%eax
  801595:	8a 00                	mov    (%eax),%al
  801597:	38 c2                	cmp    %al,%dl
  801599:	74 da                	je     801575 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80159b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80159f:	75 07                	jne    8015a8 <strncmp+0x38>
		return 0;
  8015a1:	b8 00 00 00 00       	mov    $0x0,%eax
  8015a6:	eb 14                	jmp    8015bc <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8015a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ab:	8a 00                	mov    (%eax),%al
  8015ad:	0f b6 d0             	movzbl %al,%edx
  8015b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b3:	8a 00                	mov    (%eax),%al
  8015b5:	0f b6 c0             	movzbl %al,%eax
  8015b8:	29 c2                	sub    %eax,%edx
  8015ba:	89 d0                	mov    %edx,%eax
}
  8015bc:	5d                   	pop    %ebp
  8015bd:	c3                   	ret    

008015be <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8015be:	55                   	push   %ebp
  8015bf:	89 e5                	mov    %esp,%ebp
  8015c1:	83 ec 04             	sub    $0x4,%esp
  8015c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015ca:	eb 12                	jmp    8015de <strchr+0x20>
		if (*s == c)
  8015cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cf:	8a 00                	mov    (%eax),%al
  8015d1:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015d4:	75 05                	jne    8015db <strchr+0x1d>
			return (char *) s;
  8015d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d9:	eb 11                	jmp    8015ec <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015db:	ff 45 08             	incl   0x8(%ebp)
  8015de:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e1:	8a 00                	mov    (%eax),%al
  8015e3:	84 c0                	test   %al,%al
  8015e5:	75 e5                	jne    8015cc <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015e7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ec:	c9                   	leave  
  8015ed:	c3                   	ret    

008015ee <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015ee:	55                   	push   %ebp
  8015ef:	89 e5                	mov    %esp,%ebp
  8015f1:	83 ec 04             	sub    $0x4,%esp
  8015f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015f7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015fa:	eb 0d                	jmp    801609 <strfind+0x1b>
		if (*s == c)
  8015fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ff:	8a 00                	mov    (%eax),%al
  801601:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801604:	74 0e                	je     801614 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801606:	ff 45 08             	incl   0x8(%ebp)
  801609:	8b 45 08             	mov    0x8(%ebp),%eax
  80160c:	8a 00                	mov    (%eax),%al
  80160e:	84 c0                	test   %al,%al
  801610:	75 ea                	jne    8015fc <strfind+0xe>
  801612:	eb 01                	jmp    801615 <strfind+0x27>
		if (*s == c)
			break;
  801614:	90                   	nop
	return (char *) s;
  801615:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801618:	c9                   	leave  
  801619:	c3                   	ret    

0080161a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80161a:	55                   	push   %ebp
  80161b:	89 e5                	mov    %esp,%ebp
  80161d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801620:	8b 45 08             	mov    0x8(%ebp),%eax
  801623:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801626:	8b 45 10             	mov    0x10(%ebp),%eax
  801629:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80162c:	eb 0e                	jmp    80163c <memset+0x22>
		*p++ = c;
  80162e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801631:	8d 50 01             	lea    0x1(%eax),%edx
  801634:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801637:	8b 55 0c             	mov    0xc(%ebp),%edx
  80163a:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80163c:	ff 4d f8             	decl   -0x8(%ebp)
  80163f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801643:	79 e9                	jns    80162e <memset+0x14>
		*p++ = c;

	return v;
  801645:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801648:	c9                   	leave  
  801649:	c3                   	ret    

0080164a <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80164a:	55                   	push   %ebp
  80164b:	89 e5                	mov    %esp,%ebp
  80164d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801650:	8b 45 0c             	mov    0xc(%ebp),%eax
  801653:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801656:	8b 45 08             	mov    0x8(%ebp),%eax
  801659:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80165c:	eb 16                	jmp    801674 <memcpy+0x2a>
		*d++ = *s++;
  80165e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801661:	8d 50 01             	lea    0x1(%eax),%edx
  801664:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801667:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80166a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80166d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801670:	8a 12                	mov    (%edx),%dl
  801672:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801674:	8b 45 10             	mov    0x10(%ebp),%eax
  801677:	8d 50 ff             	lea    -0x1(%eax),%edx
  80167a:	89 55 10             	mov    %edx,0x10(%ebp)
  80167d:	85 c0                	test   %eax,%eax
  80167f:	75 dd                	jne    80165e <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801681:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801684:	c9                   	leave  
  801685:	c3                   	ret    

00801686 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801686:	55                   	push   %ebp
  801687:	89 e5                	mov    %esp,%ebp
  801689:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80168c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80168f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801692:	8b 45 08             	mov    0x8(%ebp),%eax
  801695:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801698:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80169b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80169e:	73 50                	jae    8016f0 <memmove+0x6a>
  8016a0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a6:	01 d0                	add    %edx,%eax
  8016a8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8016ab:	76 43                	jbe    8016f0 <memmove+0x6a>
		s += n;
  8016ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b0:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8016b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b6:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8016b9:	eb 10                	jmp    8016cb <memmove+0x45>
			*--d = *--s;
  8016bb:	ff 4d f8             	decl   -0x8(%ebp)
  8016be:	ff 4d fc             	decl   -0x4(%ebp)
  8016c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016c4:	8a 10                	mov    (%eax),%dl
  8016c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016c9:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ce:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016d1:	89 55 10             	mov    %edx,0x10(%ebp)
  8016d4:	85 c0                	test   %eax,%eax
  8016d6:	75 e3                	jne    8016bb <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016d8:	eb 23                	jmp    8016fd <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016da:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016dd:	8d 50 01             	lea    0x1(%eax),%edx
  8016e0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016e3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016e6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016e9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016ec:	8a 12                	mov    (%edx),%dl
  8016ee:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8016f3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016f6:	89 55 10             	mov    %edx,0x10(%ebp)
  8016f9:	85 c0                	test   %eax,%eax
  8016fb:	75 dd                	jne    8016da <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016fd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801700:	c9                   	leave  
  801701:	c3                   	ret    

00801702 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801702:	55                   	push   %ebp
  801703:	89 e5                	mov    %esp,%ebp
  801705:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801708:	8b 45 08             	mov    0x8(%ebp),%eax
  80170b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80170e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801711:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801714:	eb 2a                	jmp    801740 <memcmp+0x3e>
		if (*s1 != *s2)
  801716:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801719:	8a 10                	mov    (%eax),%dl
  80171b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80171e:	8a 00                	mov    (%eax),%al
  801720:	38 c2                	cmp    %al,%dl
  801722:	74 16                	je     80173a <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801724:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801727:	8a 00                	mov    (%eax),%al
  801729:	0f b6 d0             	movzbl %al,%edx
  80172c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80172f:	8a 00                	mov    (%eax),%al
  801731:	0f b6 c0             	movzbl %al,%eax
  801734:	29 c2                	sub    %eax,%edx
  801736:	89 d0                	mov    %edx,%eax
  801738:	eb 18                	jmp    801752 <memcmp+0x50>
		s1++, s2++;
  80173a:	ff 45 fc             	incl   -0x4(%ebp)
  80173d:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801740:	8b 45 10             	mov    0x10(%ebp),%eax
  801743:	8d 50 ff             	lea    -0x1(%eax),%edx
  801746:	89 55 10             	mov    %edx,0x10(%ebp)
  801749:	85 c0                	test   %eax,%eax
  80174b:	75 c9                	jne    801716 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80174d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801752:	c9                   	leave  
  801753:	c3                   	ret    

00801754 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801754:	55                   	push   %ebp
  801755:	89 e5                	mov    %esp,%ebp
  801757:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80175a:	8b 55 08             	mov    0x8(%ebp),%edx
  80175d:	8b 45 10             	mov    0x10(%ebp),%eax
  801760:	01 d0                	add    %edx,%eax
  801762:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801765:	eb 15                	jmp    80177c <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801767:	8b 45 08             	mov    0x8(%ebp),%eax
  80176a:	8a 00                	mov    (%eax),%al
  80176c:	0f b6 d0             	movzbl %al,%edx
  80176f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801772:	0f b6 c0             	movzbl %al,%eax
  801775:	39 c2                	cmp    %eax,%edx
  801777:	74 0d                	je     801786 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801779:	ff 45 08             	incl   0x8(%ebp)
  80177c:	8b 45 08             	mov    0x8(%ebp),%eax
  80177f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801782:	72 e3                	jb     801767 <memfind+0x13>
  801784:	eb 01                	jmp    801787 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801786:	90                   	nop
	return (void *) s;
  801787:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80178a:	c9                   	leave  
  80178b:	c3                   	ret    

0080178c <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80178c:	55                   	push   %ebp
  80178d:	89 e5                	mov    %esp,%ebp
  80178f:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801792:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801799:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8017a0:	eb 03                	jmp    8017a5 <strtol+0x19>
		s++;
  8017a2:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8017a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a8:	8a 00                	mov    (%eax),%al
  8017aa:	3c 20                	cmp    $0x20,%al
  8017ac:	74 f4                	je     8017a2 <strtol+0x16>
  8017ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b1:	8a 00                	mov    (%eax),%al
  8017b3:	3c 09                	cmp    $0x9,%al
  8017b5:	74 eb                	je     8017a2 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8017b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ba:	8a 00                	mov    (%eax),%al
  8017bc:	3c 2b                	cmp    $0x2b,%al
  8017be:	75 05                	jne    8017c5 <strtol+0x39>
		s++;
  8017c0:	ff 45 08             	incl   0x8(%ebp)
  8017c3:	eb 13                	jmp    8017d8 <strtol+0x4c>
	else if (*s == '-')
  8017c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c8:	8a 00                	mov    (%eax),%al
  8017ca:	3c 2d                	cmp    $0x2d,%al
  8017cc:	75 0a                	jne    8017d8 <strtol+0x4c>
		s++, neg = 1;
  8017ce:	ff 45 08             	incl   0x8(%ebp)
  8017d1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017d8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017dc:	74 06                	je     8017e4 <strtol+0x58>
  8017de:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017e2:	75 20                	jne    801804 <strtol+0x78>
  8017e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e7:	8a 00                	mov    (%eax),%al
  8017e9:	3c 30                	cmp    $0x30,%al
  8017eb:	75 17                	jne    801804 <strtol+0x78>
  8017ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f0:	40                   	inc    %eax
  8017f1:	8a 00                	mov    (%eax),%al
  8017f3:	3c 78                	cmp    $0x78,%al
  8017f5:	75 0d                	jne    801804 <strtol+0x78>
		s += 2, base = 16;
  8017f7:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017fb:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801802:	eb 28                	jmp    80182c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801804:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801808:	75 15                	jne    80181f <strtol+0x93>
  80180a:	8b 45 08             	mov    0x8(%ebp),%eax
  80180d:	8a 00                	mov    (%eax),%al
  80180f:	3c 30                	cmp    $0x30,%al
  801811:	75 0c                	jne    80181f <strtol+0x93>
		s++, base = 8;
  801813:	ff 45 08             	incl   0x8(%ebp)
  801816:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80181d:	eb 0d                	jmp    80182c <strtol+0xa0>
	else if (base == 0)
  80181f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801823:	75 07                	jne    80182c <strtol+0xa0>
		base = 10;
  801825:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80182c:	8b 45 08             	mov    0x8(%ebp),%eax
  80182f:	8a 00                	mov    (%eax),%al
  801831:	3c 2f                	cmp    $0x2f,%al
  801833:	7e 19                	jle    80184e <strtol+0xc2>
  801835:	8b 45 08             	mov    0x8(%ebp),%eax
  801838:	8a 00                	mov    (%eax),%al
  80183a:	3c 39                	cmp    $0x39,%al
  80183c:	7f 10                	jg     80184e <strtol+0xc2>
			dig = *s - '0';
  80183e:	8b 45 08             	mov    0x8(%ebp),%eax
  801841:	8a 00                	mov    (%eax),%al
  801843:	0f be c0             	movsbl %al,%eax
  801846:	83 e8 30             	sub    $0x30,%eax
  801849:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80184c:	eb 42                	jmp    801890 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80184e:	8b 45 08             	mov    0x8(%ebp),%eax
  801851:	8a 00                	mov    (%eax),%al
  801853:	3c 60                	cmp    $0x60,%al
  801855:	7e 19                	jle    801870 <strtol+0xe4>
  801857:	8b 45 08             	mov    0x8(%ebp),%eax
  80185a:	8a 00                	mov    (%eax),%al
  80185c:	3c 7a                	cmp    $0x7a,%al
  80185e:	7f 10                	jg     801870 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801860:	8b 45 08             	mov    0x8(%ebp),%eax
  801863:	8a 00                	mov    (%eax),%al
  801865:	0f be c0             	movsbl %al,%eax
  801868:	83 e8 57             	sub    $0x57,%eax
  80186b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80186e:	eb 20                	jmp    801890 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801870:	8b 45 08             	mov    0x8(%ebp),%eax
  801873:	8a 00                	mov    (%eax),%al
  801875:	3c 40                	cmp    $0x40,%al
  801877:	7e 39                	jle    8018b2 <strtol+0x126>
  801879:	8b 45 08             	mov    0x8(%ebp),%eax
  80187c:	8a 00                	mov    (%eax),%al
  80187e:	3c 5a                	cmp    $0x5a,%al
  801880:	7f 30                	jg     8018b2 <strtol+0x126>
			dig = *s - 'A' + 10;
  801882:	8b 45 08             	mov    0x8(%ebp),%eax
  801885:	8a 00                	mov    (%eax),%al
  801887:	0f be c0             	movsbl %al,%eax
  80188a:	83 e8 37             	sub    $0x37,%eax
  80188d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801890:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801893:	3b 45 10             	cmp    0x10(%ebp),%eax
  801896:	7d 19                	jge    8018b1 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801898:	ff 45 08             	incl   0x8(%ebp)
  80189b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80189e:	0f af 45 10          	imul   0x10(%ebp),%eax
  8018a2:	89 c2                	mov    %eax,%edx
  8018a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018a7:	01 d0                	add    %edx,%eax
  8018a9:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8018ac:	e9 7b ff ff ff       	jmp    80182c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8018b1:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8018b2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8018b6:	74 08                	je     8018c0 <strtol+0x134>
		*endptr = (char *) s;
  8018b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018bb:	8b 55 08             	mov    0x8(%ebp),%edx
  8018be:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8018c0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018c4:	74 07                	je     8018cd <strtol+0x141>
  8018c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018c9:	f7 d8                	neg    %eax
  8018cb:	eb 03                	jmp    8018d0 <strtol+0x144>
  8018cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018d0:	c9                   	leave  
  8018d1:	c3                   	ret    

008018d2 <ltostr>:

void
ltostr(long value, char *str)
{
  8018d2:	55                   	push   %ebp
  8018d3:	89 e5                	mov    %esp,%ebp
  8018d5:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018df:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018e6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018ea:	79 13                	jns    8018ff <ltostr+0x2d>
	{
		neg = 1;
  8018ec:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018f6:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018f9:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018fc:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801902:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801907:	99                   	cltd   
  801908:	f7 f9                	idiv   %ecx
  80190a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80190d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801910:	8d 50 01             	lea    0x1(%eax),%edx
  801913:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801916:	89 c2                	mov    %eax,%edx
  801918:	8b 45 0c             	mov    0xc(%ebp),%eax
  80191b:	01 d0                	add    %edx,%eax
  80191d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801920:	83 c2 30             	add    $0x30,%edx
  801923:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801925:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801928:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80192d:	f7 e9                	imul   %ecx
  80192f:	c1 fa 02             	sar    $0x2,%edx
  801932:	89 c8                	mov    %ecx,%eax
  801934:	c1 f8 1f             	sar    $0x1f,%eax
  801937:	29 c2                	sub    %eax,%edx
  801939:	89 d0                	mov    %edx,%eax
  80193b:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80193e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801941:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801946:	f7 e9                	imul   %ecx
  801948:	c1 fa 02             	sar    $0x2,%edx
  80194b:	89 c8                	mov    %ecx,%eax
  80194d:	c1 f8 1f             	sar    $0x1f,%eax
  801950:	29 c2                	sub    %eax,%edx
  801952:	89 d0                	mov    %edx,%eax
  801954:	c1 e0 02             	shl    $0x2,%eax
  801957:	01 d0                	add    %edx,%eax
  801959:	01 c0                	add    %eax,%eax
  80195b:	29 c1                	sub    %eax,%ecx
  80195d:	89 ca                	mov    %ecx,%edx
  80195f:	85 d2                	test   %edx,%edx
  801961:	75 9c                	jne    8018ff <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801963:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80196a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80196d:	48                   	dec    %eax
  80196e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801971:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801975:	74 3d                	je     8019b4 <ltostr+0xe2>
		start = 1 ;
  801977:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80197e:	eb 34                	jmp    8019b4 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801980:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801983:	8b 45 0c             	mov    0xc(%ebp),%eax
  801986:	01 d0                	add    %edx,%eax
  801988:	8a 00                	mov    (%eax),%al
  80198a:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80198d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801990:	8b 45 0c             	mov    0xc(%ebp),%eax
  801993:	01 c2                	add    %eax,%edx
  801995:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801998:	8b 45 0c             	mov    0xc(%ebp),%eax
  80199b:	01 c8                	add    %ecx,%eax
  80199d:	8a 00                	mov    (%eax),%al
  80199f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8019a1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8019a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a7:	01 c2                	add    %eax,%edx
  8019a9:	8a 45 eb             	mov    -0x15(%ebp),%al
  8019ac:	88 02                	mov    %al,(%edx)
		start++ ;
  8019ae:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8019b1:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8019b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019b7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019ba:	7c c4                	jl     801980 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8019bc:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8019bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019c2:	01 d0                	add    %edx,%eax
  8019c4:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8019c7:	90                   	nop
  8019c8:	c9                   	leave  
  8019c9:	c3                   	ret    

008019ca <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8019ca:	55                   	push   %ebp
  8019cb:	89 e5                	mov    %esp,%ebp
  8019cd:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8019d0:	ff 75 08             	pushl  0x8(%ebp)
  8019d3:	e8 54 fa ff ff       	call   80142c <strlen>
  8019d8:	83 c4 04             	add    $0x4,%esp
  8019db:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019de:	ff 75 0c             	pushl  0xc(%ebp)
  8019e1:	e8 46 fa ff ff       	call   80142c <strlen>
  8019e6:	83 c4 04             	add    $0x4,%esp
  8019e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019fa:	eb 17                	jmp    801a13 <strcconcat+0x49>
		final[s] = str1[s] ;
  8019fc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801a02:	01 c2                	add    %eax,%edx
  801a04:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a07:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0a:	01 c8                	add    %ecx,%eax
  801a0c:	8a 00                	mov    (%eax),%al
  801a0e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801a10:	ff 45 fc             	incl   -0x4(%ebp)
  801a13:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a16:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a19:	7c e1                	jl     8019fc <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801a1b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a22:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a29:	eb 1f                	jmp    801a4a <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a2e:	8d 50 01             	lea    0x1(%eax),%edx
  801a31:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a34:	89 c2                	mov    %eax,%edx
  801a36:	8b 45 10             	mov    0x10(%ebp),%eax
  801a39:	01 c2                	add    %eax,%edx
  801a3b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a41:	01 c8                	add    %ecx,%eax
  801a43:	8a 00                	mov    (%eax),%al
  801a45:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a47:	ff 45 f8             	incl   -0x8(%ebp)
  801a4a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a4d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a50:	7c d9                	jl     801a2b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a52:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a55:	8b 45 10             	mov    0x10(%ebp),%eax
  801a58:	01 d0                	add    %edx,%eax
  801a5a:	c6 00 00             	movb   $0x0,(%eax)
}
  801a5d:	90                   	nop
  801a5e:	c9                   	leave  
  801a5f:	c3                   	ret    

00801a60 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a60:	55                   	push   %ebp
  801a61:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a63:	8b 45 14             	mov    0x14(%ebp),%eax
  801a66:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a6c:	8b 45 14             	mov    0x14(%ebp),%eax
  801a6f:	8b 00                	mov    (%eax),%eax
  801a71:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a78:	8b 45 10             	mov    0x10(%ebp),%eax
  801a7b:	01 d0                	add    %edx,%eax
  801a7d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a83:	eb 0c                	jmp    801a91 <strsplit+0x31>
			*string++ = 0;
  801a85:	8b 45 08             	mov    0x8(%ebp),%eax
  801a88:	8d 50 01             	lea    0x1(%eax),%edx
  801a8b:	89 55 08             	mov    %edx,0x8(%ebp)
  801a8e:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a91:	8b 45 08             	mov    0x8(%ebp),%eax
  801a94:	8a 00                	mov    (%eax),%al
  801a96:	84 c0                	test   %al,%al
  801a98:	74 18                	je     801ab2 <strsplit+0x52>
  801a9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9d:	8a 00                	mov    (%eax),%al
  801a9f:	0f be c0             	movsbl %al,%eax
  801aa2:	50                   	push   %eax
  801aa3:	ff 75 0c             	pushl  0xc(%ebp)
  801aa6:	e8 13 fb ff ff       	call   8015be <strchr>
  801aab:	83 c4 08             	add    $0x8,%esp
  801aae:	85 c0                	test   %eax,%eax
  801ab0:	75 d3                	jne    801a85 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801ab2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab5:	8a 00                	mov    (%eax),%al
  801ab7:	84 c0                	test   %al,%al
  801ab9:	74 5a                	je     801b15 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801abb:	8b 45 14             	mov    0x14(%ebp),%eax
  801abe:	8b 00                	mov    (%eax),%eax
  801ac0:	83 f8 0f             	cmp    $0xf,%eax
  801ac3:	75 07                	jne    801acc <strsplit+0x6c>
		{
			return 0;
  801ac5:	b8 00 00 00 00       	mov    $0x0,%eax
  801aca:	eb 66                	jmp    801b32 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801acc:	8b 45 14             	mov    0x14(%ebp),%eax
  801acf:	8b 00                	mov    (%eax),%eax
  801ad1:	8d 48 01             	lea    0x1(%eax),%ecx
  801ad4:	8b 55 14             	mov    0x14(%ebp),%edx
  801ad7:	89 0a                	mov    %ecx,(%edx)
  801ad9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ae0:	8b 45 10             	mov    0x10(%ebp),%eax
  801ae3:	01 c2                	add    %eax,%edx
  801ae5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae8:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801aea:	eb 03                	jmp    801aef <strsplit+0x8f>
			string++;
  801aec:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801aef:	8b 45 08             	mov    0x8(%ebp),%eax
  801af2:	8a 00                	mov    (%eax),%al
  801af4:	84 c0                	test   %al,%al
  801af6:	74 8b                	je     801a83 <strsplit+0x23>
  801af8:	8b 45 08             	mov    0x8(%ebp),%eax
  801afb:	8a 00                	mov    (%eax),%al
  801afd:	0f be c0             	movsbl %al,%eax
  801b00:	50                   	push   %eax
  801b01:	ff 75 0c             	pushl  0xc(%ebp)
  801b04:	e8 b5 fa ff ff       	call   8015be <strchr>
  801b09:	83 c4 08             	add    $0x8,%esp
  801b0c:	85 c0                	test   %eax,%eax
  801b0e:	74 dc                	je     801aec <strsplit+0x8c>
			string++;
	}
  801b10:	e9 6e ff ff ff       	jmp    801a83 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801b15:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801b16:	8b 45 14             	mov    0x14(%ebp),%eax
  801b19:	8b 00                	mov    (%eax),%eax
  801b1b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b22:	8b 45 10             	mov    0x10(%ebp),%eax
  801b25:	01 d0                	add    %edx,%eax
  801b27:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b2d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b32:	c9                   	leave  
  801b33:	c3                   	ret    

00801b34 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801b34:	55                   	push   %ebp
  801b35:	89 e5                	mov    %esp,%ebp
  801b37:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  801b3a:	e8 3b 09 00 00       	call   80247a <sys_isUHeapPlacementStrategyFIRSTFIT>
  801b3f:	85 c0                	test   %eax,%eax
  801b41:	0f 84 3a 01 00 00    	je     801c81 <malloc+0x14d>

		if(pl == 0){
  801b47:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b4c:	85 c0                	test   %eax,%eax
  801b4e:	75 24                	jne    801b74 <malloc+0x40>
			for(int k = 0; k < Size; k++){
  801b50:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801b57:	eb 11                	jmp    801b6a <malloc+0x36>
				arr[k] = -10000;
  801b59:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b5c:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801b63:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801b67:	ff 45 f4             	incl   -0xc(%ebp)
  801b6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b6d:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801b72:	76 e5                	jbe    801b59 <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801b74:	c7 05 2c 30 80 00 01 	movl   $0x1,0x80302c
  801b7b:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801b7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b81:	c1 e8 0c             	shr    $0xc,%eax
  801b84:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  801b87:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8a:	25 ff 0f 00 00       	and    $0xfff,%eax
  801b8f:	85 c0                	test   %eax,%eax
  801b91:	74 03                	je     801b96 <malloc+0x62>
			x++;
  801b93:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  801b96:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  801b9d:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801ba4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801bab:	eb 66                	jmp    801c13 <malloc+0xdf>
			if( arr[k] == -10000){
  801bad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801bb0:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801bb7:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801bbc:	75 52                	jne    801c10 <malloc+0xdc>
				uint32 w = 0 ;
  801bbe:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  801bc5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801bc8:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  801bcb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801bce:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801bd1:	eb 09                	jmp    801bdc <malloc+0xa8>
  801bd3:	ff 45 e0             	incl   -0x20(%ebp)
  801bd6:	ff 45 dc             	incl   -0x24(%ebp)
  801bd9:	ff 45 e4             	incl   -0x1c(%ebp)
  801bdc:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801bdf:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801be4:	77 19                	ja     801bff <malloc+0xcb>
  801be6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801be9:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801bf0:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801bf5:	75 08                	jne    801bff <malloc+0xcb>
  801bf7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801bfa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801bfd:	72 d4                	jb     801bd3 <malloc+0x9f>
				if(w >= x){
  801bff:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c02:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c05:	72 09                	jb     801c10 <malloc+0xdc>
					p = 1 ;
  801c07:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  801c0e:	eb 0d                	jmp    801c1d <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801c10:	ff 45 e4             	incl   -0x1c(%ebp)
  801c13:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801c16:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801c1b:	76 90                	jbe    801bad <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  801c1d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801c21:	75 0a                	jne    801c2d <malloc+0xf9>
  801c23:	b8 00 00 00 00       	mov    $0x0,%eax
  801c28:	e9 ca 01 00 00       	jmp    801df7 <malloc+0x2c3>
		int q = idx;
  801c2d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c30:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  801c33:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801c3a:	eb 16                	jmp    801c52 <malloc+0x11e>
			arr[q++] = x;
  801c3c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801c3f:	8d 50 01             	lea    0x1(%eax),%edx
  801c42:	89 55 d8             	mov    %edx,-0x28(%ebp)
  801c45:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801c48:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  801c4f:	ff 45 d4             	incl   -0x2c(%ebp)
  801c52:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801c55:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c58:	72 e2                	jb     801c3c <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801c5a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c5d:	05 00 00 08 00       	add    $0x80000,%eax
  801c62:	c1 e0 0c             	shl    $0xc,%eax
  801c65:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  801c68:	83 ec 08             	sub    $0x8,%esp
  801c6b:	ff 75 f0             	pushl  -0x10(%ebp)
  801c6e:	ff 75 ac             	pushl  -0x54(%ebp)
  801c71:	e8 9b 04 00 00       	call   802111 <sys_allocateMem>
  801c76:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801c79:	8b 45 ac             	mov    -0x54(%ebp),%eax
  801c7c:	e9 76 01 00 00       	jmp    801df7 <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  801c81:	e8 25 08 00 00       	call   8024ab <sys_isUHeapPlacementStrategyBESTFIT>
  801c86:	85 c0                	test   %eax,%eax
  801c88:	0f 84 64 01 00 00    	je     801df2 <malloc+0x2be>
		if(pl == 0){
  801c8e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801c93:	85 c0                	test   %eax,%eax
  801c95:	75 24                	jne    801cbb <malloc+0x187>
			for(int k = 0; k < Size; k++){
  801c97:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  801c9e:	eb 11                	jmp    801cb1 <malloc+0x17d>
				arr[k] = -10000;
  801ca0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ca3:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801caa:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801cae:	ff 45 d0             	incl   -0x30(%ebp)
  801cb1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801cb4:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801cb9:	76 e5                	jbe    801ca0 <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801cbb:	c7 05 2c 30 80 00 01 	movl   $0x1,0x80302c
  801cc2:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801cc5:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc8:	c1 e8 0c             	shr    $0xc,%eax
  801ccb:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  801cce:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd1:	25 ff 0f 00 00       	and    $0xfff,%eax
  801cd6:	85 c0                	test   %eax,%eax
  801cd8:	74 03                	je     801cdd <malloc+0x1a9>
			x++;
  801cda:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  801cdd:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  801ce4:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  801ceb:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  801cf2:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  801cf9:	e9 88 00 00 00       	jmp    801d86 <malloc+0x252>
			if(arr[k] == -10000){
  801cfe:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801d01:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801d08:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801d0d:	75 64                	jne    801d73 <malloc+0x23f>
				uint32 w = 0 , i;
  801d0f:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  801d16:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801d19:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  801d1c:	eb 06                	jmp    801d24 <malloc+0x1f0>
  801d1e:	ff 45 b8             	incl   -0x48(%ebp)
  801d21:	ff 45 b4             	incl   -0x4c(%ebp)
  801d24:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  801d2b:	77 11                	ja     801d3e <malloc+0x20a>
  801d2d:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801d30:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801d37:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801d3c:	74 e0                	je     801d1e <malloc+0x1ea>
				if(w <q && w >= x){
  801d3e:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801d41:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  801d44:	73 24                	jae    801d6a <malloc+0x236>
  801d46:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801d49:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801d4c:	72 1c                	jb     801d6a <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  801d4e:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801d51:	89 45 c8             	mov    %eax,-0x38(%ebp)
  801d54:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  801d5b:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801d5e:	89 45 c0             	mov    %eax,-0x40(%ebp)
  801d61:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801d64:	48                   	dec    %eax
  801d65:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801d68:	eb 19                	jmp    801d83 <malloc+0x24f>
				}
				else {
					k = i - 1;
  801d6a:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801d6d:	48                   	dec    %eax
  801d6e:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801d71:	eb 10                	jmp    801d83 <malloc+0x24f>
				}
			} else {
				k += arr[k];
  801d73:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801d76:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801d7d:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  801d80:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  801d83:	ff 45 bc             	incl   -0x44(%ebp)
  801d86:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801d89:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801d8e:	0f 86 6a ff ff ff    	jbe    801cfe <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  801d94:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  801d98:	75 07                	jne    801da1 <malloc+0x26d>
  801d9a:	b8 00 00 00 00       	mov    $0x0,%eax
  801d9f:	eb 56                	jmp    801df7 <malloc+0x2c3>
	    q = idx;
  801da1:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801da4:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  801da7:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  801dae:	eb 16                	jmp    801dc6 <malloc+0x292>
			arr[q++] = x;
  801db0:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801db3:	8d 50 01             	lea    0x1(%eax),%edx
  801db6:	89 55 c8             	mov    %edx,-0x38(%ebp)
  801db9:	8b 55 cc             	mov    -0x34(%ebp),%edx
  801dbc:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  801dc3:	ff 45 b0             	incl   -0x50(%ebp)
  801dc6:	8b 45 b0             	mov    -0x50(%ebp),%eax
  801dc9:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801dcc:	72 e2                	jb     801db0 <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801dce:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801dd1:	05 00 00 08 00       	add    $0x80000,%eax
  801dd6:	c1 e0 0c             	shl    $0xc,%eax
  801dd9:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  801ddc:	83 ec 08             	sub    $0x8,%esp
  801ddf:	ff 75 cc             	pushl  -0x34(%ebp)
  801de2:	ff 75 a8             	pushl  -0x58(%ebp)
  801de5:	e8 27 03 00 00       	call   802111 <sys_allocateMem>
  801dea:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801ded:	8b 45 a8             	mov    -0x58(%ebp),%eax
  801df0:	eb 05                	jmp    801df7 <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  801df2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801df7:	c9                   	leave  
  801df8:	c3                   	ret    

00801df9 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801df9:	55                   	push   %ebp
  801dfa:	89 e5                	mov    %esp,%ebp
  801dfc:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  801dff:	8b 45 08             	mov    0x8(%ebp),%eax
  801e02:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801e05:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e08:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801e0d:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  801e10:	8b 45 08             	mov    0x8(%ebp),%eax
  801e13:	05 00 00 00 80       	add    $0x80000000,%eax
  801e18:	c1 e8 0c             	shr    $0xc,%eax
  801e1b:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801e22:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801e25:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801e2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e2f:	05 00 00 00 80       	add    $0x80000000,%eax
  801e34:	c1 e8 0c             	shr    $0xc,%eax
  801e37:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801e3a:	eb 14                	jmp    801e50 <free+0x57>
		arr[j] = -10000;
  801e3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e3f:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801e46:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801e4a:	ff 45 f4             	incl   -0xc(%ebp)
  801e4d:	ff 45 f0             	incl   -0x10(%ebp)
  801e50:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e53:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801e56:	72 e4                	jb     801e3c <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  801e58:	8b 45 08             	mov    0x8(%ebp),%eax
  801e5b:	83 ec 08             	sub    $0x8,%esp
  801e5e:	ff 75 e8             	pushl  -0x18(%ebp)
  801e61:	50                   	push   %eax
  801e62:	e8 8e 02 00 00       	call   8020f5 <sys_freeMem>
  801e67:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  801e6a:	90                   	nop
  801e6b:	c9                   	leave  
  801e6c:	c3                   	ret    

00801e6d <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801e6d:	55                   	push   %ebp
  801e6e:	89 e5                	mov    %esp,%ebp
  801e70:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e73:	83 ec 04             	sub    $0x4,%esp
  801e76:	68 84 2f 80 00       	push   $0x802f84
  801e7b:	68 9e 00 00 00       	push   $0x9e
  801e80:	68 a7 2f 80 00       	push   $0x802fa7
  801e85:	e8 63 ea ff ff       	call   8008ed <_panic>

00801e8a <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801e8a:	55                   	push   %ebp
  801e8b:	89 e5                	mov    %esp,%ebp
  801e8d:	83 ec 18             	sub    $0x18,%esp
  801e90:	8b 45 10             	mov    0x10(%ebp),%eax
  801e93:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801e96:	83 ec 04             	sub    $0x4,%esp
  801e99:	68 84 2f 80 00       	push   $0x802f84
  801e9e:	68 a9 00 00 00       	push   $0xa9
  801ea3:	68 a7 2f 80 00       	push   $0x802fa7
  801ea8:	e8 40 ea ff ff       	call   8008ed <_panic>

00801ead <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801ead:	55                   	push   %ebp
  801eae:	89 e5                	mov    %esp,%ebp
  801eb0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801eb3:	83 ec 04             	sub    $0x4,%esp
  801eb6:	68 84 2f 80 00       	push   $0x802f84
  801ebb:	68 af 00 00 00       	push   $0xaf
  801ec0:	68 a7 2f 80 00       	push   $0x802fa7
  801ec5:	e8 23 ea ff ff       	call   8008ed <_panic>

00801eca <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801eca:	55                   	push   %ebp
  801ecb:	89 e5                	mov    %esp,%ebp
  801ecd:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ed0:	83 ec 04             	sub    $0x4,%esp
  801ed3:	68 84 2f 80 00       	push   $0x802f84
  801ed8:	68 b5 00 00 00       	push   $0xb5
  801edd:	68 a7 2f 80 00       	push   $0x802fa7
  801ee2:	e8 06 ea ff ff       	call   8008ed <_panic>

00801ee7 <expand>:
}

void expand(uint32 newSize)
{
  801ee7:	55                   	push   %ebp
  801ee8:	89 e5                	mov    %esp,%ebp
  801eea:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801eed:	83 ec 04             	sub    $0x4,%esp
  801ef0:	68 84 2f 80 00       	push   $0x802f84
  801ef5:	68 ba 00 00 00       	push   $0xba
  801efa:	68 a7 2f 80 00       	push   $0x802fa7
  801eff:	e8 e9 e9 ff ff       	call   8008ed <_panic>

00801f04 <shrink>:
}
void shrink(uint32 newSize)
{
  801f04:	55                   	push   %ebp
  801f05:	89 e5                	mov    %esp,%ebp
  801f07:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f0a:	83 ec 04             	sub    $0x4,%esp
  801f0d:	68 84 2f 80 00       	push   $0x802f84
  801f12:	68 be 00 00 00       	push   $0xbe
  801f17:	68 a7 2f 80 00       	push   $0x802fa7
  801f1c:	e8 cc e9 ff ff       	call   8008ed <_panic>

00801f21 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801f21:	55                   	push   %ebp
  801f22:	89 e5                	mov    %esp,%ebp
  801f24:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f27:	83 ec 04             	sub    $0x4,%esp
  801f2a:	68 84 2f 80 00       	push   $0x802f84
  801f2f:	68 c3 00 00 00       	push   $0xc3
  801f34:	68 a7 2f 80 00       	push   $0x802fa7
  801f39:	e8 af e9 ff ff       	call   8008ed <_panic>

00801f3e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801f3e:	55                   	push   %ebp
  801f3f:	89 e5                	mov    %esp,%ebp
  801f41:	57                   	push   %edi
  801f42:	56                   	push   %esi
  801f43:	53                   	push   %ebx
  801f44:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801f47:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f4d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f50:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f53:	8b 7d 18             	mov    0x18(%ebp),%edi
  801f56:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801f59:	cd 30                	int    $0x30
  801f5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801f5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801f61:	83 c4 10             	add    $0x10,%esp
  801f64:	5b                   	pop    %ebx
  801f65:	5e                   	pop    %esi
  801f66:	5f                   	pop    %edi
  801f67:	5d                   	pop    %ebp
  801f68:	c3                   	ret    

00801f69 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801f69:	55                   	push   %ebp
  801f6a:	89 e5                	mov    %esp,%ebp
  801f6c:	83 ec 04             	sub    $0x4,%esp
  801f6f:	8b 45 10             	mov    0x10(%ebp),%eax
  801f72:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801f75:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f79:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7c:	6a 00                	push   $0x0
  801f7e:	6a 00                	push   $0x0
  801f80:	52                   	push   %edx
  801f81:	ff 75 0c             	pushl  0xc(%ebp)
  801f84:	50                   	push   %eax
  801f85:	6a 00                	push   $0x0
  801f87:	e8 b2 ff ff ff       	call   801f3e <syscall>
  801f8c:	83 c4 18             	add    $0x18,%esp
}
  801f8f:	90                   	nop
  801f90:	c9                   	leave  
  801f91:	c3                   	ret    

00801f92 <sys_cgetc>:

int
sys_cgetc(void)
{
  801f92:	55                   	push   %ebp
  801f93:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801f95:	6a 00                	push   $0x0
  801f97:	6a 00                	push   $0x0
  801f99:	6a 00                	push   $0x0
  801f9b:	6a 00                	push   $0x0
  801f9d:	6a 00                	push   $0x0
  801f9f:	6a 01                	push   $0x1
  801fa1:	e8 98 ff ff ff       	call   801f3e <syscall>
  801fa6:	83 c4 18             	add    $0x18,%esp
}
  801fa9:	c9                   	leave  
  801faa:	c3                   	ret    

00801fab <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801fab:	55                   	push   %ebp
  801fac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801fae:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb1:	6a 00                	push   $0x0
  801fb3:	6a 00                	push   $0x0
  801fb5:	6a 00                	push   $0x0
  801fb7:	6a 00                	push   $0x0
  801fb9:	50                   	push   %eax
  801fba:	6a 05                	push   $0x5
  801fbc:	e8 7d ff ff ff       	call   801f3e <syscall>
  801fc1:	83 c4 18             	add    $0x18,%esp
}
  801fc4:	c9                   	leave  
  801fc5:	c3                   	ret    

00801fc6 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801fc6:	55                   	push   %ebp
  801fc7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 00                	push   $0x0
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	6a 02                	push   $0x2
  801fd5:	e8 64 ff ff ff       	call   801f3e <syscall>
  801fda:	83 c4 18             	add    $0x18,%esp
}
  801fdd:	c9                   	leave  
  801fde:	c3                   	ret    

00801fdf <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801fdf:	55                   	push   %ebp
  801fe0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801fe2:	6a 00                	push   $0x0
  801fe4:	6a 00                	push   $0x0
  801fe6:	6a 00                	push   $0x0
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 00                	push   $0x0
  801fec:	6a 03                	push   $0x3
  801fee:	e8 4b ff ff ff       	call   801f3e <syscall>
  801ff3:	83 c4 18             	add    $0x18,%esp
}
  801ff6:	c9                   	leave  
  801ff7:	c3                   	ret    

00801ff8 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801ff8:	55                   	push   %ebp
  801ff9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 00                	push   $0x0
  801fff:	6a 00                	push   $0x0
  802001:	6a 00                	push   $0x0
  802003:	6a 00                	push   $0x0
  802005:	6a 04                	push   $0x4
  802007:	e8 32 ff ff ff       	call   801f3e <syscall>
  80200c:	83 c4 18             	add    $0x18,%esp
}
  80200f:	c9                   	leave  
  802010:	c3                   	ret    

00802011 <sys_env_exit>:


void sys_env_exit(void)
{
  802011:	55                   	push   %ebp
  802012:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802014:	6a 00                	push   $0x0
  802016:	6a 00                	push   $0x0
  802018:	6a 00                	push   $0x0
  80201a:	6a 00                	push   $0x0
  80201c:	6a 00                	push   $0x0
  80201e:	6a 06                	push   $0x6
  802020:	e8 19 ff ff ff       	call   801f3e <syscall>
  802025:	83 c4 18             	add    $0x18,%esp
}
  802028:	90                   	nop
  802029:	c9                   	leave  
  80202a:	c3                   	ret    

0080202b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80202b:	55                   	push   %ebp
  80202c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80202e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802031:	8b 45 08             	mov    0x8(%ebp),%eax
  802034:	6a 00                	push   $0x0
  802036:	6a 00                	push   $0x0
  802038:	6a 00                	push   $0x0
  80203a:	52                   	push   %edx
  80203b:	50                   	push   %eax
  80203c:	6a 07                	push   $0x7
  80203e:	e8 fb fe ff ff       	call   801f3e <syscall>
  802043:	83 c4 18             	add    $0x18,%esp
}
  802046:	c9                   	leave  
  802047:	c3                   	ret    

00802048 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802048:	55                   	push   %ebp
  802049:	89 e5                	mov    %esp,%ebp
  80204b:	56                   	push   %esi
  80204c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80204d:	8b 75 18             	mov    0x18(%ebp),%esi
  802050:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802053:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802056:	8b 55 0c             	mov    0xc(%ebp),%edx
  802059:	8b 45 08             	mov    0x8(%ebp),%eax
  80205c:	56                   	push   %esi
  80205d:	53                   	push   %ebx
  80205e:	51                   	push   %ecx
  80205f:	52                   	push   %edx
  802060:	50                   	push   %eax
  802061:	6a 08                	push   $0x8
  802063:	e8 d6 fe ff ff       	call   801f3e <syscall>
  802068:	83 c4 18             	add    $0x18,%esp
}
  80206b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80206e:	5b                   	pop    %ebx
  80206f:	5e                   	pop    %esi
  802070:	5d                   	pop    %ebp
  802071:	c3                   	ret    

00802072 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802072:	55                   	push   %ebp
  802073:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802075:	8b 55 0c             	mov    0xc(%ebp),%edx
  802078:	8b 45 08             	mov    0x8(%ebp),%eax
  80207b:	6a 00                	push   $0x0
  80207d:	6a 00                	push   $0x0
  80207f:	6a 00                	push   $0x0
  802081:	52                   	push   %edx
  802082:	50                   	push   %eax
  802083:	6a 09                	push   $0x9
  802085:	e8 b4 fe ff ff       	call   801f3e <syscall>
  80208a:	83 c4 18             	add    $0x18,%esp
}
  80208d:	c9                   	leave  
  80208e:	c3                   	ret    

0080208f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80208f:	55                   	push   %ebp
  802090:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802092:	6a 00                	push   $0x0
  802094:	6a 00                	push   $0x0
  802096:	6a 00                	push   $0x0
  802098:	ff 75 0c             	pushl  0xc(%ebp)
  80209b:	ff 75 08             	pushl  0x8(%ebp)
  80209e:	6a 0a                	push   $0xa
  8020a0:	e8 99 fe ff ff       	call   801f3e <syscall>
  8020a5:	83 c4 18             	add    $0x18,%esp
}
  8020a8:	c9                   	leave  
  8020a9:	c3                   	ret    

008020aa <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8020aa:	55                   	push   %ebp
  8020ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8020ad:	6a 00                	push   $0x0
  8020af:	6a 00                	push   $0x0
  8020b1:	6a 00                	push   $0x0
  8020b3:	6a 00                	push   $0x0
  8020b5:	6a 00                	push   $0x0
  8020b7:	6a 0b                	push   $0xb
  8020b9:	e8 80 fe ff ff       	call   801f3e <syscall>
  8020be:	83 c4 18             	add    $0x18,%esp
}
  8020c1:	c9                   	leave  
  8020c2:	c3                   	ret    

008020c3 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8020c3:	55                   	push   %ebp
  8020c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8020c6:	6a 00                	push   $0x0
  8020c8:	6a 00                	push   $0x0
  8020ca:	6a 00                	push   $0x0
  8020cc:	6a 00                	push   $0x0
  8020ce:	6a 00                	push   $0x0
  8020d0:	6a 0c                	push   $0xc
  8020d2:	e8 67 fe ff ff       	call   801f3e <syscall>
  8020d7:	83 c4 18             	add    $0x18,%esp
}
  8020da:	c9                   	leave  
  8020db:	c3                   	ret    

008020dc <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8020dc:	55                   	push   %ebp
  8020dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8020df:	6a 00                	push   $0x0
  8020e1:	6a 00                	push   $0x0
  8020e3:	6a 00                	push   $0x0
  8020e5:	6a 00                	push   $0x0
  8020e7:	6a 00                	push   $0x0
  8020e9:	6a 0d                	push   $0xd
  8020eb:	e8 4e fe ff ff       	call   801f3e <syscall>
  8020f0:	83 c4 18             	add    $0x18,%esp
}
  8020f3:	c9                   	leave  
  8020f4:	c3                   	ret    

008020f5 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8020f5:	55                   	push   %ebp
  8020f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8020f8:	6a 00                	push   $0x0
  8020fa:	6a 00                	push   $0x0
  8020fc:	6a 00                	push   $0x0
  8020fe:	ff 75 0c             	pushl  0xc(%ebp)
  802101:	ff 75 08             	pushl  0x8(%ebp)
  802104:	6a 11                	push   $0x11
  802106:	e8 33 fe ff ff       	call   801f3e <syscall>
  80210b:	83 c4 18             	add    $0x18,%esp
	return;
  80210e:	90                   	nop
}
  80210f:	c9                   	leave  
  802110:	c3                   	ret    

00802111 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802111:	55                   	push   %ebp
  802112:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802114:	6a 00                	push   $0x0
  802116:	6a 00                	push   $0x0
  802118:	6a 00                	push   $0x0
  80211a:	ff 75 0c             	pushl  0xc(%ebp)
  80211d:	ff 75 08             	pushl  0x8(%ebp)
  802120:	6a 12                	push   $0x12
  802122:	e8 17 fe ff ff       	call   801f3e <syscall>
  802127:	83 c4 18             	add    $0x18,%esp
	return ;
  80212a:	90                   	nop
}
  80212b:	c9                   	leave  
  80212c:	c3                   	ret    

0080212d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80212d:	55                   	push   %ebp
  80212e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802130:	6a 00                	push   $0x0
  802132:	6a 00                	push   $0x0
  802134:	6a 00                	push   $0x0
  802136:	6a 00                	push   $0x0
  802138:	6a 00                	push   $0x0
  80213a:	6a 0e                	push   $0xe
  80213c:	e8 fd fd ff ff       	call   801f3e <syscall>
  802141:	83 c4 18             	add    $0x18,%esp
}
  802144:	c9                   	leave  
  802145:	c3                   	ret    

00802146 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802146:	55                   	push   %ebp
  802147:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802149:	6a 00                	push   $0x0
  80214b:	6a 00                	push   $0x0
  80214d:	6a 00                	push   $0x0
  80214f:	6a 00                	push   $0x0
  802151:	ff 75 08             	pushl  0x8(%ebp)
  802154:	6a 0f                	push   $0xf
  802156:	e8 e3 fd ff ff       	call   801f3e <syscall>
  80215b:	83 c4 18             	add    $0x18,%esp
}
  80215e:	c9                   	leave  
  80215f:	c3                   	ret    

00802160 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802160:	55                   	push   %ebp
  802161:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802163:	6a 00                	push   $0x0
  802165:	6a 00                	push   $0x0
  802167:	6a 00                	push   $0x0
  802169:	6a 00                	push   $0x0
  80216b:	6a 00                	push   $0x0
  80216d:	6a 10                	push   $0x10
  80216f:	e8 ca fd ff ff       	call   801f3e <syscall>
  802174:	83 c4 18             	add    $0x18,%esp
}
  802177:	90                   	nop
  802178:	c9                   	leave  
  802179:	c3                   	ret    

0080217a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80217a:	55                   	push   %ebp
  80217b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80217d:	6a 00                	push   $0x0
  80217f:	6a 00                	push   $0x0
  802181:	6a 00                	push   $0x0
  802183:	6a 00                	push   $0x0
  802185:	6a 00                	push   $0x0
  802187:	6a 14                	push   $0x14
  802189:	e8 b0 fd ff ff       	call   801f3e <syscall>
  80218e:	83 c4 18             	add    $0x18,%esp
}
  802191:	90                   	nop
  802192:	c9                   	leave  
  802193:	c3                   	ret    

00802194 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802194:	55                   	push   %ebp
  802195:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802197:	6a 00                	push   $0x0
  802199:	6a 00                	push   $0x0
  80219b:	6a 00                	push   $0x0
  80219d:	6a 00                	push   $0x0
  80219f:	6a 00                	push   $0x0
  8021a1:	6a 15                	push   $0x15
  8021a3:	e8 96 fd ff ff       	call   801f3e <syscall>
  8021a8:	83 c4 18             	add    $0x18,%esp
}
  8021ab:	90                   	nop
  8021ac:	c9                   	leave  
  8021ad:	c3                   	ret    

008021ae <sys_cputc>:


void
sys_cputc(const char c)
{
  8021ae:	55                   	push   %ebp
  8021af:	89 e5                	mov    %esp,%ebp
  8021b1:	83 ec 04             	sub    $0x4,%esp
  8021b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8021b7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8021ba:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8021be:	6a 00                	push   $0x0
  8021c0:	6a 00                	push   $0x0
  8021c2:	6a 00                	push   $0x0
  8021c4:	6a 00                	push   $0x0
  8021c6:	50                   	push   %eax
  8021c7:	6a 16                	push   $0x16
  8021c9:	e8 70 fd ff ff       	call   801f3e <syscall>
  8021ce:	83 c4 18             	add    $0x18,%esp
}
  8021d1:	90                   	nop
  8021d2:	c9                   	leave  
  8021d3:	c3                   	ret    

008021d4 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8021d4:	55                   	push   %ebp
  8021d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8021d7:	6a 00                	push   $0x0
  8021d9:	6a 00                	push   $0x0
  8021db:	6a 00                	push   $0x0
  8021dd:	6a 00                	push   $0x0
  8021df:	6a 00                	push   $0x0
  8021e1:	6a 17                	push   $0x17
  8021e3:	e8 56 fd ff ff       	call   801f3e <syscall>
  8021e8:	83 c4 18             	add    $0x18,%esp
}
  8021eb:	90                   	nop
  8021ec:	c9                   	leave  
  8021ed:	c3                   	ret    

008021ee <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8021ee:	55                   	push   %ebp
  8021ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8021f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8021f4:	6a 00                	push   $0x0
  8021f6:	6a 00                	push   $0x0
  8021f8:	6a 00                	push   $0x0
  8021fa:	ff 75 0c             	pushl  0xc(%ebp)
  8021fd:	50                   	push   %eax
  8021fe:	6a 18                	push   $0x18
  802200:	e8 39 fd ff ff       	call   801f3e <syscall>
  802205:	83 c4 18             	add    $0x18,%esp
}
  802208:	c9                   	leave  
  802209:	c3                   	ret    

0080220a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80220a:	55                   	push   %ebp
  80220b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80220d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802210:	8b 45 08             	mov    0x8(%ebp),%eax
  802213:	6a 00                	push   $0x0
  802215:	6a 00                	push   $0x0
  802217:	6a 00                	push   $0x0
  802219:	52                   	push   %edx
  80221a:	50                   	push   %eax
  80221b:	6a 1b                	push   $0x1b
  80221d:	e8 1c fd ff ff       	call   801f3e <syscall>
  802222:	83 c4 18             	add    $0x18,%esp
}
  802225:	c9                   	leave  
  802226:	c3                   	ret    

00802227 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802227:	55                   	push   %ebp
  802228:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80222a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80222d:	8b 45 08             	mov    0x8(%ebp),%eax
  802230:	6a 00                	push   $0x0
  802232:	6a 00                	push   $0x0
  802234:	6a 00                	push   $0x0
  802236:	52                   	push   %edx
  802237:	50                   	push   %eax
  802238:	6a 19                	push   $0x19
  80223a:	e8 ff fc ff ff       	call   801f3e <syscall>
  80223f:	83 c4 18             	add    $0x18,%esp
}
  802242:	90                   	nop
  802243:	c9                   	leave  
  802244:	c3                   	ret    

00802245 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802245:	55                   	push   %ebp
  802246:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802248:	8b 55 0c             	mov    0xc(%ebp),%edx
  80224b:	8b 45 08             	mov    0x8(%ebp),%eax
  80224e:	6a 00                	push   $0x0
  802250:	6a 00                	push   $0x0
  802252:	6a 00                	push   $0x0
  802254:	52                   	push   %edx
  802255:	50                   	push   %eax
  802256:	6a 1a                	push   $0x1a
  802258:	e8 e1 fc ff ff       	call   801f3e <syscall>
  80225d:	83 c4 18             	add    $0x18,%esp
}
  802260:	90                   	nop
  802261:	c9                   	leave  
  802262:	c3                   	ret    

00802263 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802263:	55                   	push   %ebp
  802264:	89 e5                	mov    %esp,%ebp
  802266:	83 ec 04             	sub    $0x4,%esp
  802269:	8b 45 10             	mov    0x10(%ebp),%eax
  80226c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80226f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802272:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802276:	8b 45 08             	mov    0x8(%ebp),%eax
  802279:	6a 00                	push   $0x0
  80227b:	51                   	push   %ecx
  80227c:	52                   	push   %edx
  80227d:	ff 75 0c             	pushl  0xc(%ebp)
  802280:	50                   	push   %eax
  802281:	6a 1c                	push   $0x1c
  802283:	e8 b6 fc ff ff       	call   801f3e <syscall>
  802288:	83 c4 18             	add    $0x18,%esp
}
  80228b:	c9                   	leave  
  80228c:	c3                   	ret    

0080228d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80228d:	55                   	push   %ebp
  80228e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802290:	8b 55 0c             	mov    0xc(%ebp),%edx
  802293:	8b 45 08             	mov    0x8(%ebp),%eax
  802296:	6a 00                	push   $0x0
  802298:	6a 00                	push   $0x0
  80229a:	6a 00                	push   $0x0
  80229c:	52                   	push   %edx
  80229d:	50                   	push   %eax
  80229e:	6a 1d                	push   $0x1d
  8022a0:	e8 99 fc ff ff       	call   801f3e <syscall>
  8022a5:	83 c4 18             	add    $0x18,%esp
}
  8022a8:	c9                   	leave  
  8022a9:	c3                   	ret    

008022aa <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8022aa:	55                   	push   %ebp
  8022ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8022ad:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8022b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8022b6:	6a 00                	push   $0x0
  8022b8:	6a 00                	push   $0x0
  8022ba:	51                   	push   %ecx
  8022bb:	52                   	push   %edx
  8022bc:	50                   	push   %eax
  8022bd:	6a 1e                	push   $0x1e
  8022bf:	e8 7a fc ff ff       	call   801f3e <syscall>
  8022c4:	83 c4 18             	add    $0x18,%esp
}
  8022c7:	c9                   	leave  
  8022c8:	c3                   	ret    

008022c9 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8022c9:	55                   	push   %ebp
  8022ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8022cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8022d2:	6a 00                	push   $0x0
  8022d4:	6a 00                	push   $0x0
  8022d6:	6a 00                	push   $0x0
  8022d8:	52                   	push   %edx
  8022d9:	50                   	push   %eax
  8022da:	6a 1f                	push   $0x1f
  8022dc:	e8 5d fc ff ff       	call   801f3e <syscall>
  8022e1:	83 c4 18             	add    $0x18,%esp
}
  8022e4:	c9                   	leave  
  8022e5:	c3                   	ret    

008022e6 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8022e6:	55                   	push   %ebp
  8022e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8022e9:	6a 00                	push   $0x0
  8022eb:	6a 00                	push   $0x0
  8022ed:	6a 00                	push   $0x0
  8022ef:	6a 00                	push   $0x0
  8022f1:	6a 00                	push   $0x0
  8022f3:	6a 20                	push   $0x20
  8022f5:	e8 44 fc ff ff       	call   801f3e <syscall>
  8022fa:	83 c4 18             	add    $0x18,%esp
}
  8022fd:	c9                   	leave  
  8022fe:	c3                   	ret    

008022ff <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8022ff:	55                   	push   %ebp
  802300:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802302:	8b 45 08             	mov    0x8(%ebp),%eax
  802305:	6a 00                	push   $0x0
  802307:	ff 75 14             	pushl  0x14(%ebp)
  80230a:	ff 75 10             	pushl  0x10(%ebp)
  80230d:	ff 75 0c             	pushl  0xc(%ebp)
  802310:	50                   	push   %eax
  802311:	6a 21                	push   $0x21
  802313:	e8 26 fc ff ff       	call   801f3e <syscall>
  802318:	83 c4 18             	add    $0x18,%esp
}
  80231b:	c9                   	leave  
  80231c:	c3                   	ret    

0080231d <sys_run_env>:


void
sys_run_env(int32 envId)
{
  80231d:	55                   	push   %ebp
  80231e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802320:	8b 45 08             	mov    0x8(%ebp),%eax
  802323:	6a 00                	push   $0x0
  802325:	6a 00                	push   $0x0
  802327:	6a 00                	push   $0x0
  802329:	6a 00                	push   $0x0
  80232b:	50                   	push   %eax
  80232c:	6a 22                	push   $0x22
  80232e:	e8 0b fc ff ff       	call   801f3e <syscall>
  802333:	83 c4 18             	add    $0x18,%esp
}
  802336:	90                   	nop
  802337:	c9                   	leave  
  802338:	c3                   	ret    

00802339 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802339:	55                   	push   %ebp
  80233a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80233c:	8b 45 08             	mov    0x8(%ebp),%eax
  80233f:	6a 00                	push   $0x0
  802341:	6a 00                	push   $0x0
  802343:	6a 00                	push   $0x0
  802345:	6a 00                	push   $0x0
  802347:	50                   	push   %eax
  802348:	6a 23                	push   $0x23
  80234a:	e8 ef fb ff ff       	call   801f3e <syscall>
  80234f:	83 c4 18             	add    $0x18,%esp
}
  802352:	90                   	nop
  802353:	c9                   	leave  
  802354:	c3                   	ret    

00802355 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802355:	55                   	push   %ebp
  802356:	89 e5                	mov    %esp,%ebp
  802358:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80235b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80235e:	8d 50 04             	lea    0x4(%eax),%edx
  802361:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802364:	6a 00                	push   $0x0
  802366:	6a 00                	push   $0x0
  802368:	6a 00                	push   $0x0
  80236a:	52                   	push   %edx
  80236b:	50                   	push   %eax
  80236c:	6a 24                	push   $0x24
  80236e:	e8 cb fb ff ff       	call   801f3e <syscall>
  802373:	83 c4 18             	add    $0x18,%esp
	return result;
  802376:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802379:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80237c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80237f:	89 01                	mov    %eax,(%ecx)
  802381:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802384:	8b 45 08             	mov    0x8(%ebp),%eax
  802387:	c9                   	leave  
  802388:	c2 04 00             	ret    $0x4

0080238b <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80238b:	55                   	push   %ebp
  80238c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80238e:	6a 00                	push   $0x0
  802390:	6a 00                	push   $0x0
  802392:	ff 75 10             	pushl  0x10(%ebp)
  802395:	ff 75 0c             	pushl  0xc(%ebp)
  802398:	ff 75 08             	pushl  0x8(%ebp)
  80239b:	6a 13                	push   $0x13
  80239d:	e8 9c fb ff ff       	call   801f3e <syscall>
  8023a2:	83 c4 18             	add    $0x18,%esp
	return ;
  8023a5:	90                   	nop
}
  8023a6:	c9                   	leave  
  8023a7:	c3                   	ret    

008023a8 <sys_rcr2>:
uint32 sys_rcr2()
{
  8023a8:	55                   	push   %ebp
  8023a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8023ab:	6a 00                	push   $0x0
  8023ad:	6a 00                	push   $0x0
  8023af:	6a 00                	push   $0x0
  8023b1:	6a 00                	push   $0x0
  8023b3:	6a 00                	push   $0x0
  8023b5:	6a 25                	push   $0x25
  8023b7:	e8 82 fb ff ff       	call   801f3e <syscall>
  8023bc:	83 c4 18             	add    $0x18,%esp
}
  8023bf:	c9                   	leave  
  8023c0:	c3                   	ret    

008023c1 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8023c1:	55                   	push   %ebp
  8023c2:	89 e5                	mov    %esp,%ebp
  8023c4:	83 ec 04             	sub    $0x4,%esp
  8023c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ca:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8023cd:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8023d1:	6a 00                	push   $0x0
  8023d3:	6a 00                	push   $0x0
  8023d5:	6a 00                	push   $0x0
  8023d7:	6a 00                	push   $0x0
  8023d9:	50                   	push   %eax
  8023da:	6a 26                	push   $0x26
  8023dc:	e8 5d fb ff ff       	call   801f3e <syscall>
  8023e1:	83 c4 18             	add    $0x18,%esp
	return ;
  8023e4:	90                   	nop
}
  8023e5:	c9                   	leave  
  8023e6:	c3                   	ret    

008023e7 <rsttst>:
void rsttst()
{
  8023e7:	55                   	push   %ebp
  8023e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8023ea:	6a 00                	push   $0x0
  8023ec:	6a 00                	push   $0x0
  8023ee:	6a 00                	push   $0x0
  8023f0:	6a 00                	push   $0x0
  8023f2:	6a 00                	push   $0x0
  8023f4:	6a 28                	push   $0x28
  8023f6:	e8 43 fb ff ff       	call   801f3e <syscall>
  8023fb:	83 c4 18             	add    $0x18,%esp
	return ;
  8023fe:	90                   	nop
}
  8023ff:	c9                   	leave  
  802400:	c3                   	ret    

00802401 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802401:	55                   	push   %ebp
  802402:	89 e5                	mov    %esp,%ebp
  802404:	83 ec 04             	sub    $0x4,%esp
  802407:	8b 45 14             	mov    0x14(%ebp),%eax
  80240a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80240d:	8b 55 18             	mov    0x18(%ebp),%edx
  802410:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802414:	52                   	push   %edx
  802415:	50                   	push   %eax
  802416:	ff 75 10             	pushl  0x10(%ebp)
  802419:	ff 75 0c             	pushl  0xc(%ebp)
  80241c:	ff 75 08             	pushl  0x8(%ebp)
  80241f:	6a 27                	push   $0x27
  802421:	e8 18 fb ff ff       	call   801f3e <syscall>
  802426:	83 c4 18             	add    $0x18,%esp
	return ;
  802429:	90                   	nop
}
  80242a:	c9                   	leave  
  80242b:	c3                   	ret    

0080242c <chktst>:
void chktst(uint32 n)
{
  80242c:	55                   	push   %ebp
  80242d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80242f:	6a 00                	push   $0x0
  802431:	6a 00                	push   $0x0
  802433:	6a 00                	push   $0x0
  802435:	6a 00                	push   $0x0
  802437:	ff 75 08             	pushl  0x8(%ebp)
  80243a:	6a 29                	push   $0x29
  80243c:	e8 fd fa ff ff       	call   801f3e <syscall>
  802441:	83 c4 18             	add    $0x18,%esp
	return ;
  802444:	90                   	nop
}
  802445:	c9                   	leave  
  802446:	c3                   	ret    

00802447 <inctst>:

void inctst()
{
  802447:	55                   	push   %ebp
  802448:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80244a:	6a 00                	push   $0x0
  80244c:	6a 00                	push   $0x0
  80244e:	6a 00                	push   $0x0
  802450:	6a 00                	push   $0x0
  802452:	6a 00                	push   $0x0
  802454:	6a 2a                	push   $0x2a
  802456:	e8 e3 fa ff ff       	call   801f3e <syscall>
  80245b:	83 c4 18             	add    $0x18,%esp
	return ;
  80245e:	90                   	nop
}
  80245f:	c9                   	leave  
  802460:	c3                   	ret    

00802461 <gettst>:
uint32 gettst()
{
  802461:	55                   	push   %ebp
  802462:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802464:	6a 00                	push   $0x0
  802466:	6a 00                	push   $0x0
  802468:	6a 00                	push   $0x0
  80246a:	6a 00                	push   $0x0
  80246c:	6a 00                	push   $0x0
  80246e:	6a 2b                	push   $0x2b
  802470:	e8 c9 fa ff ff       	call   801f3e <syscall>
  802475:	83 c4 18             	add    $0x18,%esp
}
  802478:	c9                   	leave  
  802479:	c3                   	ret    

0080247a <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80247a:	55                   	push   %ebp
  80247b:	89 e5                	mov    %esp,%ebp
  80247d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802480:	6a 00                	push   $0x0
  802482:	6a 00                	push   $0x0
  802484:	6a 00                	push   $0x0
  802486:	6a 00                	push   $0x0
  802488:	6a 00                	push   $0x0
  80248a:	6a 2c                	push   $0x2c
  80248c:	e8 ad fa ff ff       	call   801f3e <syscall>
  802491:	83 c4 18             	add    $0x18,%esp
  802494:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802497:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80249b:	75 07                	jne    8024a4 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80249d:	b8 01 00 00 00       	mov    $0x1,%eax
  8024a2:	eb 05                	jmp    8024a9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8024a4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024a9:	c9                   	leave  
  8024aa:	c3                   	ret    

008024ab <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8024ab:	55                   	push   %ebp
  8024ac:	89 e5                	mov    %esp,%ebp
  8024ae:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8024b1:	6a 00                	push   $0x0
  8024b3:	6a 00                	push   $0x0
  8024b5:	6a 00                	push   $0x0
  8024b7:	6a 00                	push   $0x0
  8024b9:	6a 00                	push   $0x0
  8024bb:	6a 2c                	push   $0x2c
  8024bd:	e8 7c fa ff ff       	call   801f3e <syscall>
  8024c2:	83 c4 18             	add    $0x18,%esp
  8024c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8024c8:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8024cc:	75 07                	jne    8024d5 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8024ce:	b8 01 00 00 00       	mov    $0x1,%eax
  8024d3:	eb 05                	jmp    8024da <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8024d5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024da:	c9                   	leave  
  8024db:	c3                   	ret    

008024dc <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8024dc:	55                   	push   %ebp
  8024dd:	89 e5                	mov    %esp,%ebp
  8024df:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8024e2:	6a 00                	push   $0x0
  8024e4:	6a 00                	push   $0x0
  8024e6:	6a 00                	push   $0x0
  8024e8:	6a 00                	push   $0x0
  8024ea:	6a 00                	push   $0x0
  8024ec:	6a 2c                	push   $0x2c
  8024ee:	e8 4b fa ff ff       	call   801f3e <syscall>
  8024f3:	83 c4 18             	add    $0x18,%esp
  8024f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8024f9:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8024fd:	75 07                	jne    802506 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8024ff:	b8 01 00 00 00       	mov    $0x1,%eax
  802504:	eb 05                	jmp    80250b <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802506:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80250b:	c9                   	leave  
  80250c:	c3                   	ret    

0080250d <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80250d:	55                   	push   %ebp
  80250e:	89 e5                	mov    %esp,%ebp
  802510:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802513:	6a 00                	push   $0x0
  802515:	6a 00                	push   $0x0
  802517:	6a 00                	push   $0x0
  802519:	6a 00                	push   $0x0
  80251b:	6a 00                	push   $0x0
  80251d:	6a 2c                	push   $0x2c
  80251f:	e8 1a fa ff ff       	call   801f3e <syscall>
  802524:	83 c4 18             	add    $0x18,%esp
  802527:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80252a:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80252e:	75 07                	jne    802537 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802530:	b8 01 00 00 00       	mov    $0x1,%eax
  802535:	eb 05                	jmp    80253c <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802537:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80253c:	c9                   	leave  
  80253d:	c3                   	ret    

0080253e <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80253e:	55                   	push   %ebp
  80253f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802541:	6a 00                	push   $0x0
  802543:	6a 00                	push   $0x0
  802545:	6a 00                	push   $0x0
  802547:	6a 00                	push   $0x0
  802549:	ff 75 08             	pushl  0x8(%ebp)
  80254c:	6a 2d                	push   $0x2d
  80254e:	e8 eb f9 ff ff       	call   801f3e <syscall>
  802553:	83 c4 18             	add    $0x18,%esp
	return ;
  802556:	90                   	nop
}
  802557:	c9                   	leave  
  802558:	c3                   	ret    

00802559 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802559:	55                   	push   %ebp
  80255a:	89 e5                	mov    %esp,%ebp
  80255c:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80255d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802560:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802563:	8b 55 0c             	mov    0xc(%ebp),%edx
  802566:	8b 45 08             	mov    0x8(%ebp),%eax
  802569:	6a 00                	push   $0x0
  80256b:	53                   	push   %ebx
  80256c:	51                   	push   %ecx
  80256d:	52                   	push   %edx
  80256e:	50                   	push   %eax
  80256f:	6a 2e                	push   $0x2e
  802571:	e8 c8 f9 ff ff       	call   801f3e <syscall>
  802576:	83 c4 18             	add    $0x18,%esp
}
  802579:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80257c:	c9                   	leave  
  80257d:	c3                   	ret    

0080257e <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80257e:	55                   	push   %ebp
  80257f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802581:	8b 55 0c             	mov    0xc(%ebp),%edx
  802584:	8b 45 08             	mov    0x8(%ebp),%eax
  802587:	6a 00                	push   $0x0
  802589:	6a 00                	push   $0x0
  80258b:	6a 00                	push   $0x0
  80258d:	52                   	push   %edx
  80258e:	50                   	push   %eax
  80258f:	6a 2f                	push   $0x2f
  802591:	e8 a8 f9 ff ff       	call   801f3e <syscall>
  802596:	83 c4 18             	add    $0x18,%esp
}
  802599:	c9                   	leave  
  80259a:	c3                   	ret    

0080259b <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  80259b:	55                   	push   %ebp
  80259c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80259e:	6a 00                	push   $0x0
  8025a0:	6a 00                	push   $0x0
  8025a2:	6a 00                	push   $0x0
  8025a4:	ff 75 0c             	pushl  0xc(%ebp)
  8025a7:	ff 75 08             	pushl  0x8(%ebp)
  8025aa:	6a 30                	push   $0x30
  8025ac:	e8 8d f9 ff ff       	call   801f3e <syscall>
  8025b1:	83 c4 18             	add    $0x18,%esp
	return ;
  8025b4:	90                   	nop
}
  8025b5:	c9                   	leave  
  8025b6:	c3                   	ret    
  8025b7:	90                   	nop

008025b8 <__udivdi3>:
  8025b8:	55                   	push   %ebp
  8025b9:	57                   	push   %edi
  8025ba:	56                   	push   %esi
  8025bb:	53                   	push   %ebx
  8025bc:	83 ec 1c             	sub    $0x1c,%esp
  8025bf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8025c3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8025c7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8025cb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8025cf:	89 ca                	mov    %ecx,%edx
  8025d1:	89 f8                	mov    %edi,%eax
  8025d3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8025d7:	85 f6                	test   %esi,%esi
  8025d9:	75 2d                	jne    802608 <__udivdi3+0x50>
  8025db:	39 cf                	cmp    %ecx,%edi
  8025dd:	77 65                	ja     802644 <__udivdi3+0x8c>
  8025df:	89 fd                	mov    %edi,%ebp
  8025e1:	85 ff                	test   %edi,%edi
  8025e3:	75 0b                	jne    8025f0 <__udivdi3+0x38>
  8025e5:	b8 01 00 00 00       	mov    $0x1,%eax
  8025ea:	31 d2                	xor    %edx,%edx
  8025ec:	f7 f7                	div    %edi
  8025ee:	89 c5                	mov    %eax,%ebp
  8025f0:	31 d2                	xor    %edx,%edx
  8025f2:	89 c8                	mov    %ecx,%eax
  8025f4:	f7 f5                	div    %ebp
  8025f6:	89 c1                	mov    %eax,%ecx
  8025f8:	89 d8                	mov    %ebx,%eax
  8025fa:	f7 f5                	div    %ebp
  8025fc:	89 cf                	mov    %ecx,%edi
  8025fe:	89 fa                	mov    %edi,%edx
  802600:	83 c4 1c             	add    $0x1c,%esp
  802603:	5b                   	pop    %ebx
  802604:	5e                   	pop    %esi
  802605:	5f                   	pop    %edi
  802606:	5d                   	pop    %ebp
  802607:	c3                   	ret    
  802608:	39 ce                	cmp    %ecx,%esi
  80260a:	77 28                	ja     802634 <__udivdi3+0x7c>
  80260c:	0f bd fe             	bsr    %esi,%edi
  80260f:	83 f7 1f             	xor    $0x1f,%edi
  802612:	75 40                	jne    802654 <__udivdi3+0x9c>
  802614:	39 ce                	cmp    %ecx,%esi
  802616:	72 0a                	jb     802622 <__udivdi3+0x6a>
  802618:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80261c:	0f 87 9e 00 00 00    	ja     8026c0 <__udivdi3+0x108>
  802622:	b8 01 00 00 00       	mov    $0x1,%eax
  802627:	89 fa                	mov    %edi,%edx
  802629:	83 c4 1c             	add    $0x1c,%esp
  80262c:	5b                   	pop    %ebx
  80262d:	5e                   	pop    %esi
  80262e:	5f                   	pop    %edi
  80262f:	5d                   	pop    %ebp
  802630:	c3                   	ret    
  802631:	8d 76 00             	lea    0x0(%esi),%esi
  802634:	31 ff                	xor    %edi,%edi
  802636:	31 c0                	xor    %eax,%eax
  802638:	89 fa                	mov    %edi,%edx
  80263a:	83 c4 1c             	add    $0x1c,%esp
  80263d:	5b                   	pop    %ebx
  80263e:	5e                   	pop    %esi
  80263f:	5f                   	pop    %edi
  802640:	5d                   	pop    %ebp
  802641:	c3                   	ret    
  802642:	66 90                	xchg   %ax,%ax
  802644:	89 d8                	mov    %ebx,%eax
  802646:	f7 f7                	div    %edi
  802648:	31 ff                	xor    %edi,%edi
  80264a:	89 fa                	mov    %edi,%edx
  80264c:	83 c4 1c             	add    $0x1c,%esp
  80264f:	5b                   	pop    %ebx
  802650:	5e                   	pop    %esi
  802651:	5f                   	pop    %edi
  802652:	5d                   	pop    %ebp
  802653:	c3                   	ret    
  802654:	bd 20 00 00 00       	mov    $0x20,%ebp
  802659:	89 eb                	mov    %ebp,%ebx
  80265b:	29 fb                	sub    %edi,%ebx
  80265d:	89 f9                	mov    %edi,%ecx
  80265f:	d3 e6                	shl    %cl,%esi
  802661:	89 c5                	mov    %eax,%ebp
  802663:	88 d9                	mov    %bl,%cl
  802665:	d3 ed                	shr    %cl,%ebp
  802667:	89 e9                	mov    %ebp,%ecx
  802669:	09 f1                	or     %esi,%ecx
  80266b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80266f:	89 f9                	mov    %edi,%ecx
  802671:	d3 e0                	shl    %cl,%eax
  802673:	89 c5                	mov    %eax,%ebp
  802675:	89 d6                	mov    %edx,%esi
  802677:	88 d9                	mov    %bl,%cl
  802679:	d3 ee                	shr    %cl,%esi
  80267b:	89 f9                	mov    %edi,%ecx
  80267d:	d3 e2                	shl    %cl,%edx
  80267f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802683:	88 d9                	mov    %bl,%cl
  802685:	d3 e8                	shr    %cl,%eax
  802687:	09 c2                	or     %eax,%edx
  802689:	89 d0                	mov    %edx,%eax
  80268b:	89 f2                	mov    %esi,%edx
  80268d:	f7 74 24 0c          	divl   0xc(%esp)
  802691:	89 d6                	mov    %edx,%esi
  802693:	89 c3                	mov    %eax,%ebx
  802695:	f7 e5                	mul    %ebp
  802697:	39 d6                	cmp    %edx,%esi
  802699:	72 19                	jb     8026b4 <__udivdi3+0xfc>
  80269b:	74 0b                	je     8026a8 <__udivdi3+0xf0>
  80269d:	89 d8                	mov    %ebx,%eax
  80269f:	31 ff                	xor    %edi,%edi
  8026a1:	e9 58 ff ff ff       	jmp    8025fe <__udivdi3+0x46>
  8026a6:	66 90                	xchg   %ax,%ax
  8026a8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8026ac:	89 f9                	mov    %edi,%ecx
  8026ae:	d3 e2                	shl    %cl,%edx
  8026b0:	39 c2                	cmp    %eax,%edx
  8026b2:	73 e9                	jae    80269d <__udivdi3+0xe5>
  8026b4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8026b7:	31 ff                	xor    %edi,%edi
  8026b9:	e9 40 ff ff ff       	jmp    8025fe <__udivdi3+0x46>
  8026be:	66 90                	xchg   %ax,%ax
  8026c0:	31 c0                	xor    %eax,%eax
  8026c2:	e9 37 ff ff ff       	jmp    8025fe <__udivdi3+0x46>
  8026c7:	90                   	nop

008026c8 <__umoddi3>:
  8026c8:	55                   	push   %ebp
  8026c9:	57                   	push   %edi
  8026ca:	56                   	push   %esi
  8026cb:	53                   	push   %ebx
  8026cc:	83 ec 1c             	sub    $0x1c,%esp
  8026cf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8026d3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8026d7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8026db:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8026df:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8026e3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8026e7:	89 f3                	mov    %esi,%ebx
  8026e9:	89 fa                	mov    %edi,%edx
  8026eb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8026ef:	89 34 24             	mov    %esi,(%esp)
  8026f2:	85 c0                	test   %eax,%eax
  8026f4:	75 1a                	jne    802710 <__umoddi3+0x48>
  8026f6:	39 f7                	cmp    %esi,%edi
  8026f8:	0f 86 a2 00 00 00    	jbe    8027a0 <__umoddi3+0xd8>
  8026fe:	89 c8                	mov    %ecx,%eax
  802700:	89 f2                	mov    %esi,%edx
  802702:	f7 f7                	div    %edi
  802704:	89 d0                	mov    %edx,%eax
  802706:	31 d2                	xor    %edx,%edx
  802708:	83 c4 1c             	add    $0x1c,%esp
  80270b:	5b                   	pop    %ebx
  80270c:	5e                   	pop    %esi
  80270d:	5f                   	pop    %edi
  80270e:	5d                   	pop    %ebp
  80270f:	c3                   	ret    
  802710:	39 f0                	cmp    %esi,%eax
  802712:	0f 87 ac 00 00 00    	ja     8027c4 <__umoddi3+0xfc>
  802718:	0f bd e8             	bsr    %eax,%ebp
  80271b:	83 f5 1f             	xor    $0x1f,%ebp
  80271e:	0f 84 ac 00 00 00    	je     8027d0 <__umoddi3+0x108>
  802724:	bf 20 00 00 00       	mov    $0x20,%edi
  802729:	29 ef                	sub    %ebp,%edi
  80272b:	89 fe                	mov    %edi,%esi
  80272d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802731:	89 e9                	mov    %ebp,%ecx
  802733:	d3 e0                	shl    %cl,%eax
  802735:	89 d7                	mov    %edx,%edi
  802737:	89 f1                	mov    %esi,%ecx
  802739:	d3 ef                	shr    %cl,%edi
  80273b:	09 c7                	or     %eax,%edi
  80273d:	89 e9                	mov    %ebp,%ecx
  80273f:	d3 e2                	shl    %cl,%edx
  802741:	89 14 24             	mov    %edx,(%esp)
  802744:	89 d8                	mov    %ebx,%eax
  802746:	d3 e0                	shl    %cl,%eax
  802748:	89 c2                	mov    %eax,%edx
  80274a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80274e:	d3 e0                	shl    %cl,%eax
  802750:	89 44 24 04          	mov    %eax,0x4(%esp)
  802754:	8b 44 24 08          	mov    0x8(%esp),%eax
  802758:	89 f1                	mov    %esi,%ecx
  80275a:	d3 e8                	shr    %cl,%eax
  80275c:	09 d0                	or     %edx,%eax
  80275e:	d3 eb                	shr    %cl,%ebx
  802760:	89 da                	mov    %ebx,%edx
  802762:	f7 f7                	div    %edi
  802764:	89 d3                	mov    %edx,%ebx
  802766:	f7 24 24             	mull   (%esp)
  802769:	89 c6                	mov    %eax,%esi
  80276b:	89 d1                	mov    %edx,%ecx
  80276d:	39 d3                	cmp    %edx,%ebx
  80276f:	0f 82 87 00 00 00    	jb     8027fc <__umoddi3+0x134>
  802775:	0f 84 91 00 00 00    	je     80280c <__umoddi3+0x144>
  80277b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80277f:	29 f2                	sub    %esi,%edx
  802781:	19 cb                	sbb    %ecx,%ebx
  802783:	89 d8                	mov    %ebx,%eax
  802785:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802789:	d3 e0                	shl    %cl,%eax
  80278b:	89 e9                	mov    %ebp,%ecx
  80278d:	d3 ea                	shr    %cl,%edx
  80278f:	09 d0                	or     %edx,%eax
  802791:	89 e9                	mov    %ebp,%ecx
  802793:	d3 eb                	shr    %cl,%ebx
  802795:	89 da                	mov    %ebx,%edx
  802797:	83 c4 1c             	add    $0x1c,%esp
  80279a:	5b                   	pop    %ebx
  80279b:	5e                   	pop    %esi
  80279c:	5f                   	pop    %edi
  80279d:	5d                   	pop    %ebp
  80279e:	c3                   	ret    
  80279f:	90                   	nop
  8027a0:	89 fd                	mov    %edi,%ebp
  8027a2:	85 ff                	test   %edi,%edi
  8027a4:	75 0b                	jne    8027b1 <__umoddi3+0xe9>
  8027a6:	b8 01 00 00 00       	mov    $0x1,%eax
  8027ab:	31 d2                	xor    %edx,%edx
  8027ad:	f7 f7                	div    %edi
  8027af:	89 c5                	mov    %eax,%ebp
  8027b1:	89 f0                	mov    %esi,%eax
  8027b3:	31 d2                	xor    %edx,%edx
  8027b5:	f7 f5                	div    %ebp
  8027b7:	89 c8                	mov    %ecx,%eax
  8027b9:	f7 f5                	div    %ebp
  8027bb:	89 d0                	mov    %edx,%eax
  8027bd:	e9 44 ff ff ff       	jmp    802706 <__umoddi3+0x3e>
  8027c2:	66 90                	xchg   %ax,%ax
  8027c4:	89 c8                	mov    %ecx,%eax
  8027c6:	89 f2                	mov    %esi,%edx
  8027c8:	83 c4 1c             	add    $0x1c,%esp
  8027cb:	5b                   	pop    %ebx
  8027cc:	5e                   	pop    %esi
  8027cd:	5f                   	pop    %edi
  8027ce:	5d                   	pop    %ebp
  8027cf:	c3                   	ret    
  8027d0:	3b 04 24             	cmp    (%esp),%eax
  8027d3:	72 06                	jb     8027db <__umoddi3+0x113>
  8027d5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8027d9:	77 0f                	ja     8027ea <__umoddi3+0x122>
  8027db:	89 f2                	mov    %esi,%edx
  8027dd:	29 f9                	sub    %edi,%ecx
  8027df:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8027e3:	89 14 24             	mov    %edx,(%esp)
  8027e6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8027ea:	8b 44 24 04          	mov    0x4(%esp),%eax
  8027ee:	8b 14 24             	mov    (%esp),%edx
  8027f1:	83 c4 1c             	add    $0x1c,%esp
  8027f4:	5b                   	pop    %ebx
  8027f5:	5e                   	pop    %esi
  8027f6:	5f                   	pop    %edi
  8027f7:	5d                   	pop    %ebp
  8027f8:	c3                   	ret    
  8027f9:	8d 76 00             	lea    0x0(%esi),%esi
  8027fc:	2b 04 24             	sub    (%esp),%eax
  8027ff:	19 fa                	sbb    %edi,%edx
  802801:	89 d1                	mov    %edx,%ecx
  802803:	89 c6                	mov    %eax,%esi
  802805:	e9 71 ff ff ff       	jmp    80277b <__umoddi3+0xb3>
  80280a:	66 90                	xchg   %ax,%ax
  80280c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802810:	72 ea                	jb     8027fc <__umoddi3+0x134>
  802812:	89 d9                	mov    %ebx,%ecx
  802814:	e9 62 ff ff ff       	jmp    80277b <__umoddi3+0xb3>
