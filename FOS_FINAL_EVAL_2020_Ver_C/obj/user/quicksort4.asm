
obj/user/quicksort4:     file format elf32-i386


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
  800031:	e8 52 06 00 00       	call   800688 <libmain>
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
  80003c:	81 ec c4 63 00 00    	sub    $0x63c4,%esp
	//int InitFreeFrames = sys_calculate_free_frames() ;
	char Line[25500] ;
	char Chose ;
	int Iteration = 0 ;
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int32 envID = sys_getenvid();
  800049:	e8 3b 1e 00 00       	call   801e89 <sys_getenvid>
  80004e:	89 45 e8             	mov    %eax,-0x18(%ebp)
	sys_createSemaphore("cs1", 1);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	6a 01                	push   $0x1
  800056:	68 e0 26 80 00       	push   $0x8026e0
  80005b:	e8 51 20 00 00       	call   8020b1 <sys_createSemaphore>
  800060:	83 c4 10             	add    $0x10,%esp
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800063:	e8 05 1f 00 00       	call   801f6d <sys_calculate_free_frames>
  800068:	89 c3                	mov    %eax,%ebx
  80006a:	e8 17 1f 00 00       	call   801f86 <sys_calculate_modified_frames>
  80006f:	01 d8                	add    %ebx,%eax
  800071:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		Iteration++ ;
  800074:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();
		sys_waitSemaphore(envID, "cs1");
  800077:	83 ec 08             	sub    $0x8,%esp
  80007a:	68 e0 26 80 00       	push   $0x8026e0
  80007f:	ff 75 e8             	pushl  -0x18(%ebp)
  800082:	e8 63 20 00 00       	call   8020ea <sys_waitSemaphore>
  800087:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  80008a:	83 ec 08             	sub    $0x8,%esp
  80008d:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  800093:	50                   	push   %eax
  800094:	68 e4 26 80 00       	push   $0x8026e4
  800099:	e8 4b 10 00 00       	call   8010e9 <readline>
  80009e:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000a1:	83 ec 04             	sub    $0x4,%esp
  8000a4:	6a 0a                	push   $0xa
  8000a6:	6a 00                	push   $0x0
  8000a8:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  8000ae:	50                   	push   %eax
  8000af:	e8 9b 15 00 00       	call   80164f <strtol>
  8000b4:	83 c4 10             	add    $0x10,%esp
  8000b7:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000bd:	c1 e0 02             	shl    $0x2,%eax
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	50                   	push   %eax
  8000c4:	e8 2e 19 00 00       	call   8019f7 <malloc>
  8000c9:	83 c4 10             	add    $0x10,%esp
  8000cc:	89 45 dc             	mov    %eax,-0x24(%ebp)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	68 04 27 80 00       	push   $0x802704
  8000d7:	e8 8b 09 00 00       	call   800a67 <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	68 27 27 80 00       	push   $0x802727
  8000e7:	e8 7b 09 00 00       	call   800a67 <cprintf>
  8000ec:	83 c4 10             	add    $0x10,%esp
		int ii, j = 0 ;
  8000ef:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (ii = 0 ; ii < 100000; ii++)
  8000f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8000fd:	eb 09                	jmp    800108 <_main+0xd0>
		{
			j+= ii;
  8000ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800102:	01 45 ec             	add    %eax,-0x14(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
		cprintf("a) Ascending\n") ;
		int ii, j = 0 ;
		for (ii = 0 ; ii < 100000; ii++)
  800105:	ff 45 f0             	incl   -0x10(%ebp)
  800108:	81 7d f0 9f 86 01 00 	cmpl   $0x1869f,-0x10(%ebp)
  80010f:	7e ee                	jle    8000ff <_main+0xc7>
		{
			j+= ii;
		}
		cprintf("b) Descending\n") ;
  800111:	83 ec 0c             	sub    $0xc,%esp
  800114:	68 35 27 80 00       	push   $0x802735
  800119:	e8 49 09 00 00       	call   800a67 <cprintf>
  80011e:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800121:	83 ec 0c             	sub    $0xc,%esp
  800124:	68 44 27 80 00       	push   $0x802744
  800129:	e8 39 09 00 00       	call   800a67 <cprintf>
  80012e:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800131:	83 ec 0c             	sub    $0xc,%esp
  800134:	68 54 27 80 00       	push   $0x802754
  800139:	e8 29 09 00 00       	call   800a67 <cprintf>
  80013e:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800141:	e8 ea 04 00 00       	call   800630 <getchar>
  800146:	88 45 db             	mov    %al,-0x25(%ebp)
			cputchar(Chose);
  800149:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80014d:	83 ec 0c             	sub    $0xc,%esp
  800150:	50                   	push   %eax
  800151:	e8 92 04 00 00       	call   8005e8 <cputchar>
  800156:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800159:	83 ec 0c             	sub    $0xc,%esp
  80015c:	6a 0a                	push   $0xa
  80015e:	e8 85 04 00 00       	call   8005e8 <cputchar>
  800163:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800166:	80 7d db 61          	cmpb   $0x61,-0x25(%ebp)
  80016a:	74 0c                	je     800178 <_main+0x140>
  80016c:	80 7d db 62          	cmpb   $0x62,-0x25(%ebp)
  800170:	74 06                	je     800178 <_main+0x140>
  800172:	80 7d db 63          	cmpb   $0x63,-0x25(%ebp)
  800176:	75 b9                	jne    800131 <_main+0xf9>
		sys_signalSemaphore(envID, "cs1");
  800178:	83 ec 08             	sub    $0x8,%esp
  80017b:	68 e0 26 80 00       	push   $0x8026e0
  800180:	ff 75 e8             	pushl  -0x18(%ebp)
  800183:	e8 80 1f 00 00       	call   802108 <sys_signalSemaphore>
  800188:	83 c4 10             	add    $0x10,%esp
		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  80018b:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80018f:	83 f8 62             	cmp    $0x62,%eax
  800192:	74 1d                	je     8001b1 <_main+0x179>
  800194:	83 f8 63             	cmp    $0x63,%eax
  800197:	74 2b                	je     8001c4 <_main+0x18c>
  800199:	83 f8 61             	cmp    $0x61,%eax
  80019c:	75 39                	jne    8001d7 <_main+0x19f>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80019e:	83 ec 08             	sub    $0x8,%esp
  8001a1:	ff 75 e0             	pushl  -0x20(%ebp)
  8001a4:	ff 75 dc             	pushl  -0x24(%ebp)
  8001a7:	e8 04 03 00 00       	call   8004b0 <InitializeAscending>
  8001ac:	83 c4 10             	add    $0x10,%esp
			break ;
  8001af:	eb 37                	jmp    8001e8 <_main+0x1b0>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  8001b1:	83 ec 08             	sub    $0x8,%esp
  8001b4:	ff 75 e0             	pushl  -0x20(%ebp)
  8001b7:	ff 75 dc             	pushl  -0x24(%ebp)
  8001ba:	e8 22 03 00 00       	call   8004e1 <InitializeDescending>
  8001bf:	83 c4 10             	add    $0x10,%esp
			break ;
  8001c2:	eb 24                	jmp    8001e8 <_main+0x1b0>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ca:	ff 75 dc             	pushl  -0x24(%ebp)
  8001cd:	e8 44 03 00 00       	call   800516 <InitializeSemiRandom>
  8001d2:	83 c4 10             	add    $0x10,%esp
			break ;
  8001d5:	eb 11                	jmp    8001e8 <_main+0x1b0>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001d7:	83 ec 08             	sub    $0x8,%esp
  8001da:	ff 75 e0             	pushl  -0x20(%ebp)
  8001dd:	ff 75 dc             	pushl  -0x24(%ebp)
  8001e0:	e8 31 03 00 00       	call   800516 <InitializeSemiRandom>
  8001e5:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001e8:	83 ec 08             	sub    $0x8,%esp
  8001eb:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ee:	ff 75 dc             	pushl  -0x24(%ebp)
  8001f1:	e8 ff 00 00 00       	call   8002f5 <QuickSort>
  8001f6:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001f9:	83 ec 08             	sub    $0x8,%esp
  8001fc:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ff:	ff 75 dc             	pushl  -0x24(%ebp)
  800202:	e8 ff 01 00 00       	call   800406 <CheckSorted>
  800207:	83 c4 10             	add    $0x10,%esp
  80020a:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  80020d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  800211:	75 14                	jne    800227 <_main+0x1ef>
  800213:	83 ec 04             	sub    $0x4,%esp
  800216:	68 60 27 80 00       	push   $0x802760
  80021b:	6a 4f                	push   $0x4f
  80021d:	68 82 27 80 00       	push   $0x802782
  800222:	e8 89 05 00 00       	call   8007b0 <_panic>
		else
		{
			sys_waitSemaphore(envID, "cs1");
  800227:	83 ec 08             	sub    $0x8,%esp
  80022a:	68 e0 26 80 00       	push   $0x8026e0
  80022f:	ff 75 e8             	pushl  -0x18(%ebp)
  800232:	e8 b3 1e 00 00       	call   8020ea <sys_waitSemaphore>
  800237:	83 c4 10             	add    $0x10,%esp
			cprintf("\n===============================================\n") ;
  80023a:	83 ec 0c             	sub    $0xc,%esp
  80023d:	68 94 27 80 00       	push   $0x802794
  800242:	e8 20 08 00 00       	call   800a67 <cprintf>
  800247:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80024a:	83 ec 0c             	sub    $0xc,%esp
  80024d:	68 c8 27 80 00       	push   $0x8027c8
  800252:	e8 10 08 00 00       	call   800a67 <cprintf>
  800257:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80025a:	83 ec 0c             	sub    $0xc,%esp
  80025d:	68 fc 27 80 00       	push   $0x8027fc
  800262:	e8 00 08 00 00       	call   800a67 <cprintf>
  800267:	83 c4 10             	add    $0x10,%esp
			sys_signalSemaphore(envID, "cs1");
  80026a:	83 ec 08             	sub    $0x8,%esp
  80026d:	68 e0 26 80 00       	push   $0x8026e0
  800272:	ff 75 e8             	pushl  -0x18(%ebp)
  800275:	e8 8e 1e 00 00       	call   802108 <sys_signalSemaphore>
  80027a:	83 c4 10             	add    $0x10,%esp
//		free(Elements) ;


		///========================================================================
	//sys_disable_interrupt();
		sys_waitSemaphore(envID, "cs1");
  80027d:	83 ec 08             	sub    $0x8,%esp
  800280:	68 e0 26 80 00       	push   $0x8026e0
  800285:	ff 75 e8             	pushl  -0x18(%ebp)
  800288:	e8 5d 1e 00 00       	call   8020ea <sys_waitSemaphore>
  80028d:	83 c4 10             	add    $0x10,%esp
		cprintf("Do you want to repeat (y/n): ") ;
  800290:	83 ec 0c             	sub    $0xc,%esp
  800293:	68 2e 28 80 00       	push   $0x80282e
  800298:	e8 ca 07 00 00       	call   800a67 <cprintf>
  80029d:	83 c4 10             	add    $0x10,%esp

		Chose = getchar() ;
  8002a0:	e8 8b 03 00 00       	call   800630 <getchar>
  8002a5:	88 45 db             	mov    %al,-0x25(%ebp)
		cputchar(Chose);
  8002a8:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8002ac:	83 ec 0c             	sub    $0xc,%esp
  8002af:	50                   	push   %eax
  8002b0:	e8 33 03 00 00       	call   8005e8 <cputchar>
  8002b5:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  8002b8:	83 ec 0c             	sub    $0xc,%esp
  8002bb:	6a 0a                	push   $0xa
  8002bd:	e8 26 03 00 00       	call   8005e8 <cputchar>
  8002c2:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  8002c5:	83 ec 0c             	sub    $0xc,%esp
  8002c8:	6a 0a                	push   $0xa
  8002ca:	e8 19 03 00 00       	call   8005e8 <cputchar>
  8002cf:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();
		sys_signalSemaphore(envID,"cs1");
  8002d2:	83 ec 08             	sub    $0x8,%esp
  8002d5:	68 e0 26 80 00       	push   $0x8026e0
  8002da:	ff 75 e8             	pushl  -0x18(%ebp)
  8002dd:	e8 26 1e 00 00       	call   802108 <sys_signalSemaphore>
  8002e2:	83 c4 10             	add    $0x10,%esp

	} while (Chose == 'y');
  8002e5:	80 7d db 79          	cmpb   $0x79,-0x25(%ebp)
  8002e9:	0f 84 74 fd ff ff    	je     800063 <_main+0x2b>

}
  8002ef:	90                   	nop
  8002f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8002f3:	c9                   	leave  
  8002f4:	c3                   	ret    

008002f5 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8002f5:	55                   	push   %ebp
  8002f6:	89 e5                	mov    %esp,%ebp
  8002f8:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8002fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002fe:	48                   	dec    %eax
  8002ff:	50                   	push   %eax
  800300:	6a 00                	push   $0x0
  800302:	ff 75 0c             	pushl  0xc(%ebp)
  800305:	ff 75 08             	pushl  0x8(%ebp)
  800308:	e8 06 00 00 00       	call   800313 <QSort>
  80030d:	83 c4 10             	add    $0x10,%esp
}
  800310:	90                   	nop
  800311:	c9                   	leave  
  800312:	c3                   	ret    

00800313 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800313:	55                   	push   %ebp
  800314:	89 e5                	mov    %esp,%ebp
  800316:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  800319:	8b 45 10             	mov    0x10(%ebp),%eax
  80031c:	3b 45 14             	cmp    0x14(%ebp),%eax
  80031f:	0f 8d de 00 00 00    	jge    800403 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800325:	8b 45 10             	mov    0x10(%ebp),%eax
  800328:	40                   	inc    %eax
  800329:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80032c:	8b 45 14             	mov    0x14(%ebp),%eax
  80032f:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800332:	e9 80 00 00 00       	jmp    8003b7 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800337:	ff 45 f4             	incl   -0xc(%ebp)
  80033a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80033d:	3b 45 14             	cmp    0x14(%ebp),%eax
  800340:	7f 2b                	jg     80036d <QSort+0x5a>
  800342:	8b 45 10             	mov    0x10(%ebp),%eax
  800345:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80034c:	8b 45 08             	mov    0x8(%ebp),%eax
  80034f:	01 d0                	add    %edx,%eax
  800351:	8b 10                	mov    (%eax),%edx
  800353:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800356:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80035d:	8b 45 08             	mov    0x8(%ebp),%eax
  800360:	01 c8                	add    %ecx,%eax
  800362:	8b 00                	mov    (%eax),%eax
  800364:	39 c2                	cmp    %eax,%edx
  800366:	7d cf                	jge    800337 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800368:	eb 03                	jmp    80036d <QSort+0x5a>
  80036a:	ff 4d f0             	decl   -0x10(%ebp)
  80036d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800370:	3b 45 10             	cmp    0x10(%ebp),%eax
  800373:	7e 26                	jle    80039b <QSort+0x88>
  800375:	8b 45 10             	mov    0x10(%ebp),%eax
  800378:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80037f:	8b 45 08             	mov    0x8(%ebp),%eax
  800382:	01 d0                	add    %edx,%eax
  800384:	8b 10                	mov    (%eax),%edx
  800386:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800389:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800390:	8b 45 08             	mov    0x8(%ebp),%eax
  800393:	01 c8                	add    %ecx,%eax
  800395:	8b 00                	mov    (%eax),%eax
  800397:	39 c2                	cmp    %eax,%edx
  800399:	7e cf                	jle    80036a <QSort+0x57>

		if (i <= j)
  80039b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80039e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003a1:	7f 14                	jg     8003b7 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  8003a3:	83 ec 04             	sub    $0x4,%esp
  8003a6:	ff 75 f0             	pushl  -0x10(%ebp)
  8003a9:	ff 75 f4             	pushl  -0xc(%ebp)
  8003ac:	ff 75 08             	pushl  0x8(%ebp)
  8003af:	e8 a9 00 00 00       	call   80045d <Swap>
  8003b4:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  8003b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003ba:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003bd:	0f 8e 77 ff ff ff    	jle    80033a <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  8003c3:	83 ec 04             	sub    $0x4,%esp
  8003c6:	ff 75 f0             	pushl  -0x10(%ebp)
  8003c9:	ff 75 10             	pushl  0x10(%ebp)
  8003cc:	ff 75 08             	pushl  0x8(%ebp)
  8003cf:	e8 89 00 00 00       	call   80045d <Swap>
  8003d4:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8003d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003da:	48                   	dec    %eax
  8003db:	50                   	push   %eax
  8003dc:	ff 75 10             	pushl  0x10(%ebp)
  8003df:	ff 75 0c             	pushl  0xc(%ebp)
  8003e2:	ff 75 08             	pushl  0x8(%ebp)
  8003e5:	e8 29 ff ff ff       	call   800313 <QSort>
  8003ea:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8003ed:	ff 75 14             	pushl  0x14(%ebp)
  8003f0:	ff 75 f4             	pushl  -0xc(%ebp)
  8003f3:	ff 75 0c             	pushl  0xc(%ebp)
  8003f6:	ff 75 08             	pushl  0x8(%ebp)
  8003f9:	e8 15 ff ff ff       	call   800313 <QSort>
  8003fe:	83 c4 10             	add    $0x10,%esp
  800401:	eb 01                	jmp    800404 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800403:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800404:	c9                   	leave  
  800405:	c3                   	ret    

00800406 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800406:	55                   	push   %ebp
  800407:	89 e5                	mov    %esp,%ebp
  800409:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  80040c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800413:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80041a:	eb 33                	jmp    80044f <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80041c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80041f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800426:	8b 45 08             	mov    0x8(%ebp),%eax
  800429:	01 d0                	add    %edx,%eax
  80042b:	8b 10                	mov    (%eax),%edx
  80042d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800430:	40                   	inc    %eax
  800431:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800438:	8b 45 08             	mov    0x8(%ebp),%eax
  80043b:	01 c8                	add    %ecx,%eax
  80043d:	8b 00                	mov    (%eax),%eax
  80043f:	39 c2                	cmp    %eax,%edx
  800441:	7e 09                	jle    80044c <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800443:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80044a:	eb 0c                	jmp    800458 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80044c:	ff 45 f8             	incl   -0x8(%ebp)
  80044f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800452:	48                   	dec    %eax
  800453:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800456:	7f c4                	jg     80041c <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800458:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80045b:	c9                   	leave  
  80045c:	c3                   	ret    

0080045d <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80045d:	55                   	push   %ebp
  80045e:	89 e5                	mov    %esp,%ebp
  800460:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800463:	8b 45 0c             	mov    0xc(%ebp),%eax
  800466:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046d:	8b 45 08             	mov    0x8(%ebp),%eax
  800470:	01 d0                	add    %edx,%eax
  800472:	8b 00                	mov    (%eax),%eax
  800474:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800477:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800481:	8b 45 08             	mov    0x8(%ebp),%eax
  800484:	01 c2                	add    %eax,%edx
  800486:	8b 45 10             	mov    0x10(%ebp),%eax
  800489:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800490:	8b 45 08             	mov    0x8(%ebp),%eax
  800493:	01 c8                	add    %ecx,%eax
  800495:	8b 00                	mov    (%eax),%eax
  800497:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800499:	8b 45 10             	mov    0x10(%ebp),%eax
  80049c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a6:	01 c2                	add    %eax,%edx
  8004a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ab:	89 02                	mov    %eax,(%edx)
}
  8004ad:	90                   	nop
  8004ae:	c9                   	leave  
  8004af:	c3                   	ret    

008004b0 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8004b0:	55                   	push   %ebp
  8004b1:	89 e5                	mov    %esp,%ebp
  8004b3:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004bd:	eb 17                	jmp    8004d6 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  8004bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004c2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004cc:	01 c2                	add    %eax,%edx
  8004ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004d1:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004d3:	ff 45 fc             	incl   -0x4(%ebp)
  8004d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004d9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004dc:	7c e1                	jl     8004bf <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8004de:	90                   	nop
  8004df:	c9                   	leave  
  8004e0:	c3                   	ret    

008004e1 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8004e1:	55                   	push   %ebp
  8004e2:	89 e5                	mov    %esp,%ebp
  8004e4:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004ee:	eb 1b                	jmp    80050b <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8004f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004f3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8004fd:	01 c2                	add    %eax,%edx
  8004ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800502:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800505:	48                   	dec    %eax
  800506:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800508:	ff 45 fc             	incl   -0x4(%ebp)
  80050b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80050e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800511:	7c dd                	jl     8004f0 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800513:	90                   	nop
  800514:	c9                   	leave  
  800515:	c3                   	ret    

00800516 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800516:	55                   	push   %ebp
  800517:	89 e5                	mov    %esp,%ebp
  800519:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80051c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80051f:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800524:	f7 e9                	imul   %ecx
  800526:	c1 f9 1f             	sar    $0x1f,%ecx
  800529:	89 d0                	mov    %edx,%eax
  80052b:	29 c8                	sub    %ecx,%eax
  80052d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800530:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800537:	eb 1e                	jmp    800557 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800539:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80053c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800543:	8b 45 08             	mov    0x8(%ebp),%eax
  800546:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800549:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80054c:	99                   	cltd   
  80054d:	f7 7d f8             	idivl  -0x8(%ebp)
  800550:	89 d0                	mov    %edx,%eax
  800552:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800554:	ff 45 fc             	incl   -0x4(%ebp)
  800557:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80055a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80055d:	7c da                	jl     800539 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  80055f:	90                   	nop
  800560:	c9                   	leave  
  800561:	c3                   	ret    

00800562 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800562:	55                   	push   %ebp
  800563:	89 e5                	mov    %esp,%ebp
  800565:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800568:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80056f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800576:	eb 42                	jmp    8005ba <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800578:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80057b:	99                   	cltd   
  80057c:	f7 7d f0             	idivl  -0x10(%ebp)
  80057f:	89 d0                	mov    %edx,%eax
  800581:	85 c0                	test   %eax,%eax
  800583:	75 10                	jne    800595 <PrintElements+0x33>
			cprintf("\n");
  800585:	83 ec 0c             	sub    $0xc,%esp
  800588:	68 4c 28 80 00       	push   $0x80284c
  80058d:	e8 d5 04 00 00       	call   800a67 <cprintf>
  800592:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800595:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800598:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80059f:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a2:	01 d0                	add    %edx,%eax
  8005a4:	8b 00                	mov    (%eax),%eax
  8005a6:	83 ec 08             	sub    $0x8,%esp
  8005a9:	50                   	push   %eax
  8005aa:	68 4e 28 80 00       	push   $0x80284e
  8005af:	e8 b3 04 00 00       	call   800a67 <cprintf>
  8005b4:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8005b7:	ff 45 f4             	incl   -0xc(%ebp)
  8005ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005bd:	48                   	dec    %eax
  8005be:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8005c1:	7f b5                	jg     800578 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  8005c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d0:	01 d0                	add    %edx,%eax
  8005d2:	8b 00                	mov    (%eax),%eax
  8005d4:	83 ec 08             	sub    $0x8,%esp
  8005d7:	50                   	push   %eax
  8005d8:	68 53 28 80 00       	push   $0x802853
  8005dd:	e8 85 04 00 00       	call   800a67 <cprintf>
  8005e2:	83 c4 10             	add    $0x10,%esp

}
  8005e5:	90                   	nop
  8005e6:	c9                   	leave  
  8005e7:	c3                   	ret    

008005e8 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8005e8:	55                   	push   %ebp
  8005e9:	89 e5                	mov    %esp,%ebp
  8005eb:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8005ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f1:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005f4:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005f8:	83 ec 0c             	sub    $0xc,%esp
  8005fb:	50                   	push   %eax
  8005fc:	e8 70 1a 00 00       	call   802071 <sys_cputc>
  800601:	83 c4 10             	add    $0x10,%esp
}
  800604:	90                   	nop
  800605:	c9                   	leave  
  800606:	c3                   	ret    

00800607 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800607:	55                   	push   %ebp
  800608:	89 e5                	mov    %esp,%ebp
  80060a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80060d:	e8 2b 1a 00 00       	call   80203d <sys_disable_interrupt>
	char c = ch;
  800612:	8b 45 08             	mov    0x8(%ebp),%eax
  800615:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800618:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80061c:	83 ec 0c             	sub    $0xc,%esp
  80061f:	50                   	push   %eax
  800620:	e8 4c 1a 00 00       	call   802071 <sys_cputc>
  800625:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800628:	e8 2a 1a 00 00       	call   802057 <sys_enable_interrupt>
}
  80062d:	90                   	nop
  80062e:	c9                   	leave  
  80062f:	c3                   	ret    

00800630 <getchar>:

int
getchar(void)
{
  800630:	55                   	push   %ebp
  800631:	89 e5                	mov    %esp,%ebp
  800633:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800636:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80063d:	eb 08                	jmp    800647 <getchar+0x17>
	{
		c = sys_cgetc();
  80063f:	e8 11 18 00 00       	call   801e55 <sys_cgetc>
  800644:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800647:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80064b:	74 f2                	je     80063f <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80064d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800650:	c9                   	leave  
  800651:	c3                   	ret    

00800652 <atomic_getchar>:

int
atomic_getchar(void)
{
  800652:	55                   	push   %ebp
  800653:	89 e5                	mov    %esp,%ebp
  800655:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800658:	e8 e0 19 00 00       	call   80203d <sys_disable_interrupt>
	int c=0;
  80065d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800664:	eb 08                	jmp    80066e <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800666:	e8 ea 17 00 00       	call   801e55 <sys_cgetc>
  80066b:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80066e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800672:	74 f2                	je     800666 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800674:	e8 de 19 00 00       	call   802057 <sys_enable_interrupt>
	return c;
  800679:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80067c:	c9                   	leave  
  80067d:	c3                   	ret    

0080067e <iscons>:

int iscons(int fdnum)
{
  80067e:	55                   	push   %ebp
  80067f:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800681:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800686:	5d                   	pop    %ebp
  800687:	c3                   	ret    

00800688 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800688:	55                   	push   %ebp
  800689:	89 e5                	mov    %esp,%ebp
  80068b:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80068e:	e8 0f 18 00 00       	call   801ea2 <sys_getenvindex>
  800693:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800696:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800699:	89 d0                	mov    %edx,%eax
  80069b:	01 c0                	add    %eax,%eax
  80069d:	01 d0                	add    %edx,%eax
  80069f:	c1 e0 07             	shl    $0x7,%eax
  8006a2:	29 d0                	sub    %edx,%eax
  8006a4:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8006ab:	01 c8                	add    %ecx,%eax
  8006ad:	01 c0                	add    %eax,%eax
  8006af:	01 d0                	add    %edx,%eax
  8006b1:	01 c0                	add    %eax,%eax
  8006b3:	01 d0                	add    %edx,%eax
  8006b5:	c1 e0 03             	shl    $0x3,%eax
  8006b8:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8006bd:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8006c2:	a1 24 30 80 00       	mov    0x803024,%eax
  8006c7:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  8006cd:	84 c0                	test   %al,%al
  8006cf:	74 0f                	je     8006e0 <libmain+0x58>
		binaryname = myEnv->prog_name;
  8006d1:	a1 24 30 80 00       	mov    0x803024,%eax
  8006d6:	05 f0 ee 00 00       	add    $0xeef0,%eax
  8006db:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006e0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8006e4:	7e 0a                	jle    8006f0 <libmain+0x68>
		binaryname = argv[0];
  8006e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006e9:	8b 00                	mov    (%eax),%eax
  8006eb:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8006f0:	83 ec 08             	sub    $0x8,%esp
  8006f3:	ff 75 0c             	pushl  0xc(%ebp)
  8006f6:	ff 75 08             	pushl  0x8(%ebp)
  8006f9:	e8 3a f9 ff ff       	call   800038 <_main>
  8006fe:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800701:	e8 37 19 00 00       	call   80203d <sys_disable_interrupt>
	cprintf("**************************************\n");
  800706:	83 ec 0c             	sub    $0xc,%esp
  800709:	68 70 28 80 00       	push   $0x802870
  80070e:	e8 54 03 00 00       	call   800a67 <cprintf>
  800713:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800716:	a1 24 30 80 00       	mov    0x803024,%eax
  80071b:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  800721:	a1 24 30 80 00       	mov    0x803024,%eax
  800726:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  80072c:	83 ec 04             	sub    $0x4,%esp
  80072f:	52                   	push   %edx
  800730:	50                   	push   %eax
  800731:	68 98 28 80 00       	push   $0x802898
  800736:	e8 2c 03 00 00       	call   800a67 <cprintf>
  80073b:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80073e:	a1 24 30 80 00       	mov    0x803024,%eax
  800743:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  800749:	a1 24 30 80 00       	mov    0x803024,%eax
  80074e:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  800754:	a1 24 30 80 00       	mov    0x803024,%eax
  800759:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  80075f:	51                   	push   %ecx
  800760:	52                   	push   %edx
  800761:	50                   	push   %eax
  800762:	68 c0 28 80 00       	push   $0x8028c0
  800767:	e8 fb 02 00 00       	call   800a67 <cprintf>
  80076c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80076f:	83 ec 0c             	sub    $0xc,%esp
  800772:	68 70 28 80 00       	push   $0x802870
  800777:	e8 eb 02 00 00       	call   800a67 <cprintf>
  80077c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80077f:	e8 d3 18 00 00       	call   802057 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800784:	e8 19 00 00 00       	call   8007a2 <exit>
}
  800789:	90                   	nop
  80078a:	c9                   	leave  
  80078b:	c3                   	ret    

0080078c <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80078c:	55                   	push   %ebp
  80078d:	89 e5                	mov    %esp,%ebp
  80078f:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800792:	83 ec 0c             	sub    $0xc,%esp
  800795:	6a 00                	push   $0x0
  800797:	e8 d2 16 00 00       	call   801e6e <sys_env_destroy>
  80079c:	83 c4 10             	add    $0x10,%esp
}
  80079f:	90                   	nop
  8007a0:	c9                   	leave  
  8007a1:	c3                   	ret    

008007a2 <exit>:

void
exit(void)
{
  8007a2:	55                   	push   %ebp
  8007a3:	89 e5                	mov    %esp,%ebp
  8007a5:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8007a8:	e8 27 17 00 00       	call   801ed4 <sys_env_exit>
}
  8007ad:	90                   	nop
  8007ae:	c9                   	leave  
  8007af:	c3                   	ret    

008007b0 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8007b0:	55                   	push   %ebp
  8007b1:	89 e5                	mov    %esp,%ebp
  8007b3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8007b6:	8d 45 10             	lea    0x10(%ebp),%eax
  8007b9:	83 c0 04             	add    $0x4,%eax
  8007bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8007bf:	a1 18 31 80 00       	mov    0x803118,%eax
  8007c4:	85 c0                	test   %eax,%eax
  8007c6:	74 16                	je     8007de <_panic+0x2e>
		cprintf("%s: ", argv0);
  8007c8:	a1 18 31 80 00       	mov    0x803118,%eax
  8007cd:	83 ec 08             	sub    $0x8,%esp
  8007d0:	50                   	push   %eax
  8007d1:	68 18 29 80 00       	push   $0x802918
  8007d6:	e8 8c 02 00 00       	call   800a67 <cprintf>
  8007db:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8007de:	a1 00 30 80 00       	mov    0x803000,%eax
  8007e3:	ff 75 0c             	pushl  0xc(%ebp)
  8007e6:	ff 75 08             	pushl  0x8(%ebp)
  8007e9:	50                   	push   %eax
  8007ea:	68 1d 29 80 00       	push   $0x80291d
  8007ef:	e8 73 02 00 00       	call   800a67 <cprintf>
  8007f4:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8007fa:	83 ec 08             	sub    $0x8,%esp
  8007fd:	ff 75 f4             	pushl  -0xc(%ebp)
  800800:	50                   	push   %eax
  800801:	e8 f6 01 00 00       	call   8009fc <vcprintf>
  800806:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800809:	83 ec 08             	sub    $0x8,%esp
  80080c:	6a 00                	push   $0x0
  80080e:	68 39 29 80 00       	push   $0x802939
  800813:	e8 e4 01 00 00       	call   8009fc <vcprintf>
  800818:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80081b:	e8 82 ff ff ff       	call   8007a2 <exit>

	// should not return here
	while (1) ;
  800820:	eb fe                	jmp    800820 <_panic+0x70>

00800822 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800822:	55                   	push   %ebp
  800823:	89 e5                	mov    %esp,%ebp
  800825:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800828:	a1 24 30 80 00       	mov    0x803024,%eax
  80082d:	8b 50 74             	mov    0x74(%eax),%edx
  800830:	8b 45 0c             	mov    0xc(%ebp),%eax
  800833:	39 c2                	cmp    %eax,%edx
  800835:	74 14                	je     80084b <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800837:	83 ec 04             	sub    $0x4,%esp
  80083a:	68 3c 29 80 00       	push   $0x80293c
  80083f:	6a 26                	push   $0x26
  800841:	68 88 29 80 00       	push   $0x802988
  800846:	e8 65 ff ff ff       	call   8007b0 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80084b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800852:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800859:	e9 c4 00 00 00       	jmp    800922 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  80085e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800861:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800868:	8b 45 08             	mov    0x8(%ebp),%eax
  80086b:	01 d0                	add    %edx,%eax
  80086d:	8b 00                	mov    (%eax),%eax
  80086f:	85 c0                	test   %eax,%eax
  800871:	75 08                	jne    80087b <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800873:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800876:	e9 a4 00 00 00       	jmp    80091f <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  80087b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800882:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800889:	eb 6b                	jmp    8008f6 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80088b:	a1 24 30 80 00       	mov    0x803024,%eax
  800890:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800896:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800899:	89 d0                	mov    %edx,%eax
  80089b:	c1 e0 02             	shl    $0x2,%eax
  80089e:	01 d0                	add    %edx,%eax
  8008a0:	c1 e0 02             	shl    $0x2,%eax
  8008a3:	01 c8                	add    %ecx,%eax
  8008a5:	8a 40 04             	mov    0x4(%eax),%al
  8008a8:	84 c0                	test   %al,%al
  8008aa:	75 47                	jne    8008f3 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008ac:	a1 24 30 80 00       	mov    0x803024,%eax
  8008b1:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8008b7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008ba:	89 d0                	mov    %edx,%eax
  8008bc:	c1 e0 02             	shl    $0x2,%eax
  8008bf:	01 d0                	add    %edx,%eax
  8008c1:	c1 e0 02             	shl    $0x2,%eax
  8008c4:	01 c8                	add    %ecx,%eax
  8008c6:	8b 00                	mov    (%eax),%eax
  8008c8:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8008cb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008ce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8008d3:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8008d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008d8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8008df:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e2:	01 c8                	add    %ecx,%eax
  8008e4:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008e6:	39 c2                	cmp    %eax,%edx
  8008e8:	75 09                	jne    8008f3 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  8008ea:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008f1:	eb 12                	jmp    800905 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008f3:	ff 45 e8             	incl   -0x18(%ebp)
  8008f6:	a1 24 30 80 00       	mov    0x803024,%eax
  8008fb:	8b 50 74             	mov    0x74(%eax),%edx
  8008fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800901:	39 c2                	cmp    %eax,%edx
  800903:	77 86                	ja     80088b <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800905:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800909:	75 14                	jne    80091f <CheckWSWithoutLastIndex+0xfd>
			panic(
  80090b:	83 ec 04             	sub    $0x4,%esp
  80090e:	68 94 29 80 00       	push   $0x802994
  800913:	6a 3a                	push   $0x3a
  800915:	68 88 29 80 00       	push   $0x802988
  80091a:	e8 91 fe ff ff       	call   8007b0 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80091f:	ff 45 f0             	incl   -0x10(%ebp)
  800922:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800925:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800928:	0f 8c 30 ff ff ff    	jl     80085e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80092e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800935:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80093c:	eb 27                	jmp    800965 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80093e:	a1 24 30 80 00       	mov    0x803024,%eax
  800943:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800949:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80094c:	89 d0                	mov    %edx,%eax
  80094e:	c1 e0 02             	shl    $0x2,%eax
  800951:	01 d0                	add    %edx,%eax
  800953:	c1 e0 02             	shl    $0x2,%eax
  800956:	01 c8                	add    %ecx,%eax
  800958:	8a 40 04             	mov    0x4(%eax),%al
  80095b:	3c 01                	cmp    $0x1,%al
  80095d:	75 03                	jne    800962 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  80095f:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800962:	ff 45 e0             	incl   -0x20(%ebp)
  800965:	a1 24 30 80 00       	mov    0x803024,%eax
  80096a:	8b 50 74             	mov    0x74(%eax),%edx
  80096d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800970:	39 c2                	cmp    %eax,%edx
  800972:	77 ca                	ja     80093e <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800974:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800977:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80097a:	74 14                	je     800990 <CheckWSWithoutLastIndex+0x16e>
		panic(
  80097c:	83 ec 04             	sub    $0x4,%esp
  80097f:	68 e8 29 80 00       	push   $0x8029e8
  800984:	6a 44                	push   $0x44
  800986:	68 88 29 80 00       	push   $0x802988
  80098b:	e8 20 fe ff ff       	call   8007b0 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800990:	90                   	nop
  800991:	c9                   	leave  
  800992:	c3                   	ret    

00800993 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800993:	55                   	push   %ebp
  800994:	89 e5                	mov    %esp,%ebp
  800996:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800999:	8b 45 0c             	mov    0xc(%ebp),%eax
  80099c:	8b 00                	mov    (%eax),%eax
  80099e:	8d 48 01             	lea    0x1(%eax),%ecx
  8009a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009a4:	89 0a                	mov    %ecx,(%edx)
  8009a6:	8b 55 08             	mov    0x8(%ebp),%edx
  8009a9:	88 d1                	mov    %dl,%cl
  8009ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009ae:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b5:	8b 00                	mov    (%eax),%eax
  8009b7:	3d ff 00 00 00       	cmp    $0xff,%eax
  8009bc:	75 2c                	jne    8009ea <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8009be:	a0 28 30 80 00       	mov    0x803028,%al
  8009c3:	0f b6 c0             	movzbl %al,%eax
  8009c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009c9:	8b 12                	mov    (%edx),%edx
  8009cb:	89 d1                	mov    %edx,%ecx
  8009cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009d0:	83 c2 08             	add    $0x8,%edx
  8009d3:	83 ec 04             	sub    $0x4,%esp
  8009d6:	50                   	push   %eax
  8009d7:	51                   	push   %ecx
  8009d8:	52                   	push   %edx
  8009d9:	e8 4e 14 00 00       	call   801e2c <sys_cputs>
  8009de:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8009e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8009ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ed:	8b 40 04             	mov    0x4(%eax),%eax
  8009f0:	8d 50 01             	lea    0x1(%eax),%edx
  8009f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f6:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009f9:	90                   	nop
  8009fa:	c9                   	leave  
  8009fb:	c3                   	ret    

008009fc <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8009fc:	55                   	push   %ebp
  8009fd:	89 e5                	mov    %esp,%ebp
  8009ff:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a05:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a0c:	00 00 00 
	b.cnt = 0;
  800a0f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a16:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a19:	ff 75 0c             	pushl  0xc(%ebp)
  800a1c:	ff 75 08             	pushl  0x8(%ebp)
  800a1f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a25:	50                   	push   %eax
  800a26:	68 93 09 80 00       	push   $0x800993
  800a2b:	e8 11 02 00 00       	call   800c41 <vprintfmt>
  800a30:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a33:	a0 28 30 80 00       	mov    0x803028,%al
  800a38:	0f b6 c0             	movzbl %al,%eax
  800a3b:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a41:	83 ec 04             	sub    $0x4,%esp
  800a44:	50                   	push   %eax
  800a45:	52                   	push   %edx
  800a46:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a4c:	83 c0 08             	add    $0x8,%eax
  800a4f:	50                   	push   %eax
  800a50:	e8 d7 13 00 00       	call   801e2c <sys_cputs>
  800a55:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a58:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800a5f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a65:	c9                   	leave  
  800a66:	c3                   	ret    

00800a67 <cprintf>:

int cprintf(const char *fmt, ...) {
  800a67:	55                   	push   %ebp
  800a68:	89 e5                	mov    %esp,%ebp
  800a6a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a6d:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800a74:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a77:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7d:	83 ec 08             	sub    $0x8,%esp
  800a80:	ff 75 f4             	pushl  -0xc(%ebp)
  800a83:	50                   	push   %eax
  800a84:	e8 73 ff ff ff       	call   8009fc <vcprintf>
  800a89:	83 c4 10             	add    $0x10,%esp
  800a8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a92:	c9                   	leave  
  800a93:	c3                   	ret    

00800a94 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a94:	55                   	push   %ebp
  800a95:	89 e5                	mov    %esp,%ebp
  800a97:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a9a:	e8 9e 15 00 00       	call   80203d <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a9f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800aa2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800aa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa8:	83 ec 08             	sub    $0x8,%esp
  800aab:	ff 75 f4             	pushl  -0xc(%ebp)
  800aae:	50                   	push   %eax
  800aaf:	e8 48 ff ff ff       	call   8009fc <vcprintf>
  800ab4:	83 c4 10             	add    $0x10,%esp
  800ab7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800aba:	e8 98 15 00 00       	call   802057 <sys_enable_interrupt>
	return cnt;
  800abf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ac2:	c9                   	leave  
  800ac3:	c3                   	ret    

00800ac4 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800ac4:	55                   	push   %ebp
  800ac5:	89 e5                	mov    %esp,%ebp
  800ac7:	53                   	push   %ebx
  800ac8:	83 ec 14             	sub    $0x14,%esp
  800acb:	8b 45 10             	mov    0x10(%ebp),%eax
  800ace:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ad1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800ad7:	8b 45 18             	mov    0x18(%ebp),%eax
  800ada:	ba 00 00 00 00       	mov    $0x0,%edx
  800adf:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ae2:	77 55                	ja     800b39 <printnum+0x75>
  800ae4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ae7:	72 05                	jb     800aee <printnum+0x2a>
  800ae9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800aec:	77 4b                	ja     800b39 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800aee:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800af1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800af4:	8b 45 18             	mov    0x18(%ebp),%eax
  800af7:	ba 00 00 00 00       	mov    $0x0,%edx
  800afc:	52                   	push   %edx
  800afd:	50                   	push   %eax
  800afe:	ff 75 f4             	pushl  -0xc(%ebp)
  800b01:	ff 75 f0             	pushl  -0x10(%ebp)
  800b04:	e8 73 19 00 00       	call   80247c <__udivdi3>
  800b09:	83 c4 10             	add    $0x10,%esp
  800b0c:	83 ec 04             	sub    $0x4,%esp
  800b0f:	ff 75 20             	pushl  0x20(%ebp)
  800b12:	53                   	push   %ebx
  800b13:	ff 75 18             	pushl  0x18(%ebp)
  800b16:	52                   	push   %edx
  800b17:	50                   	push   %eax
  800b18:	ff 75 0c             	pushl  0xc(%ebp)
  800b1b:	ff 75 08             	pushl  0x8(%ebp)
  800b1e:	e8 a1 ff ff ff       	call   800ac4 <printnum>
  800b23:	83 c4 20             	add    $0x20,%esp
  800b26:	eb 1a                	jmp    800b42 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b28:	83 ec 08             	sub    $0x8,%esp
  800b2b:	ff 75 0c             	pushl  0xc(%ebp)
  800b2e:	ff 75 20             	pushl  0x20(%ebp)
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	ff d0                	call   *%eax
  800b36:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b39:	ff 4d 1c             	decl   0x1c(%ebp)
  800b3c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b40:	7f e6                	jg     800b28 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b42:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b45:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b4d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b50:	53                   	push   %ebx
  800b51:	51                   	push   %ecx
  800b52:	52                   	push   %edx
  800b53:	50                   	push   %eax
  800b54:	e8 33 1a 00 00       	call   80258c <__umoddi3>
  800b59:	83 c4 10             	add    $0x10,%esp
  800b5c:	05 54 2c 80 00       	add    $0x802c54,%eax
  800b61:	8a 00                	mov    (%eax),%al
  800b63:	0f be c0             	movsbl %al,%eax
  800b66:	83 ec 08             	sub    $0x8,%esp
  800b69:	ff 75 0c             	pushl  0xc(%ebp)
  800b6c:	50                   	push   %eax
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b70:	ff d0                	call   *%eax
  800b72:	83 c4 10             	add    $0x10,%esp
}
  800b75:	90                   	nop
  800b76:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b79:	c9                   	leave  
  800b7a:	c3                   	ret    

00800b7b <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b7b:	55                   	push   %ebp
  800b7c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b7e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b82:	7e 1c                	jle    800ba0 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b84:	8b 45 08             	mov    0x8(%ebp),%eax
  800b87:	8b 00                	mov    (%eax),%eax
  800b89:	8d 50 08             	lea    0x8(%eax),%edx
  800b8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8f:	89 10                	mov    %edx,(%eax)
  800b91:	8b 45 08             	mov    0x8(%ebp),%eax
  800b94:	8b 00                	mov    (%eax),%eax
  800b96:	83 e8 08             	sub    $0x8,%eax
  800b99:	8b 50 04             	mov    0x4(%eax),%edx
  800b9c:	8b 00                	mov    (%eax),%eax
  800b9e:	eb 40                	jmp    800be0 <getuint+0x65>
	else if (lflag)
  800ba0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ba4:	74 1e                	je     800bc4 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ba6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba9:	8b 00                	mov    (%eax),%eax
  800bab:	8d 50 04             	lea    0x4(%eax),%edx
  800bae:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb1:	89 10                	mov    %edx,(%eax)
  800bb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb6:	8b 00                	mov    (%eax),%eax
  800bb8:	83 e8 04             	sub    $0x4,%eax
  800bbb:	8b 00                	mov    (%eax),%eax
  800bbd:	ba 00 00 00 00       	mov    $0x0,%edx
  800bc2:	eb 1c                	jmp    800be0 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800bc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc7:	8b 00                	mov    (%eax),%eax
  800bc9:	8d 50 04             	lea    0x4(%eax),%edx
  800bcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcf:	89 10                	mov    %edx,(%eax)
  800bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd4:	8b 00                	mov    (%eax),%eax
  800bd6:	83 e8 04             	sub    $0x4,%eax
  800bd9:	8b 00                	mov    (%eax),%eax
  800bdb:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800be0:	5d                   	pop    %ebp
  800be1:	c3                   	ret    

00800be2 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800be2:	55                   	push   %ebp
  800be3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800be5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800be9:	7e 1c                	jle    800c07 <getint+0x25>
		return va_arg(*ap, long long);
  800beb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bee:	8b 00                	mov    (%eax),%eax
  800bf0:	8d 50 08             	lea    0x8(%eax),%edx
  800bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf6:	89 10                	mov    %edx,(%eax)
  800bf8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfb:	8b 00                	mov    (%eax),%eax
  800bfd:	83 e8 08             	sub    $0x8,%eax
  800c00:	8b 50 04             	mov    0x4(%eax),%edx
  800c03:	8b 00                	mov    (%eax),%eax
  800c05:	eb 38                	jmp    800c3f <getint+0x5d>
	else if (lflag)
  800c07:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c0b:	74 1a                	je     800c27 <getint+0x45>
		return va_arg(*ap, long);
  800c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c10:	8b 00                	mov    (%eax),%eax
  800c12:	8d 50 04             	lea    0x4(%eax),%edx
  800c15:	8b 45 08             	mov    0x8(%ebp),%eax
  800c18:	89 10                	mov    %edx,(%eax)
  800c1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1d:	8b 00                	mov    (%eax),%eax
  800c1f:	83 e8 04             	sub    $0x4,%eax
  800c22:	8b 00                	mov    (%eax),%eax
  800c24:	99                   	cltd   
  800c25:	eb 18                	jmp    800c3f <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c27:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2a:	8b 00                	mov    (%eax),%eax
  800c2c:	8d 50 04             	lea    0x4(%eax),%edx
  800c2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c32:	89 10                	mov    %edx,(%eax)
  800c34:	8b 45 08             	mov    0x8(%ebp),%eax
  800c37:	8b 00                	mov    (%eax),%eax
  800c39:	83 e8 04             	sub    $0x4,%eax
  800c3c:	8b 00                	mov    (%eax),%eax
  800c3e:	99                   	cltd   
}
  800c3f:	5d                   	pop    %ebp
  800c40:	c3                   	ret    

00800c41 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c41:	55                   	push   %ebp
  800c42:	89 e5                	mov    %esp,%ebp
  800c44:	56                   	push   %esi
  800c45:	53                   	push   %ebx
  800c46:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c49:	eb 17                	jmp    800c62 <vprintfmt+0x21>
			if (ch == '\0')
  800c4b:	85 db                	test   %ebx,%ebx
  800c4d:	0f 84 af 03 00 00    	je     801002 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c53:	83 ec 08             	sub    $0x8,%esp
  800c56:	ff 75 0c             	pushl  0xc(%ebp)
  800c59:	53                   	push   %ebx
  800c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5d:	ff d0                	call   *%eax
  800c5f:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c62:	8b 45 10             	mov    0x10(%ebp),%eax
  800c65:	8d 50 01             	lea    0x1(%eax),%edx
  800c68:	89 55 10             	mov    %edx,0x10(%ebp)
  800c6b:	8a 00                	mov    (%eax),%al
  800c6d:	0f b6 d8             	movzbl %al,%ebx
  800c70:	83 fb 25             	cmp    $0x25,%ebx
  800c73:	75 d6                	jne    800c4b <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c75:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c79:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c80:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c87:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c8e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c95:	8b 45 10             	mov    0x10(%ebp),%eax
  800c98:	8d 50 01             	lea    0x1(%eax),%edx
  800c9b:	89 55 10             	mov    %edx,0x10(%ebp)
  800c9e:	8a 00                	mov    (%eax),%al
  800ca0:	0f b6 d8             	movzbl %al,%ebx
  800ca3:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800ca6:	83 f8 55             	cmp    $0x55,%eax
  800ca9:	0f 87 2b 03 00 00    	ja     800fda <vprintfmt+0x399>
  800caf:	8b 04 85 78 2c 80 00 	mov    0x802c78(,%eax,4),%eax
  800cb6:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800cb8:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800cbc:	eb d7                	jmp    800c95 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800cbe:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800cc2:	eb d1                	jmp    800c95 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cc4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800ccb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800cce:	89 d0                	mov    %edx,%eax
  800cd0:	c1 e0 02             	shl    $0x2,%eax
  800cd3:	01 d0                	add    %edx,%eax
  800cd5:	01 c0                	add    %eax,%eax
  800cd7:	01 d8                	add    %ebx,%eax
  800cd9:	83 e8 30             	sub    $0x30,%eax
  800cdc:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800cdf:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce2:	8a 00                	mov    (%eax),%al
  800ce4:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ce7:	83 fb 2f             	cmp    $0x2f,%ebx
  800cea:	7e 3e                	jle    800d2a <vprintfmt+0xe9>
  800cec:	83 fb 39             	cmp    $0x39,%ebx
  800cef:	7f 39                	jg     800d2a <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cf1:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800cf4:	eb d5                	jmp    800ccb <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800cf6:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf9:	83 c0 04             	add    $0x4,%eax
  800cfc:	89 45 14             	mov    %eax,0x14(%ebp)
  800cff:	8b 45 14             	mov    0x14(%ebp),%eax
  800d02:	83 e8 04             	sub    $0x4,%eax
  800d05:	8b 00                	mov    (%eax),%eax
  800d07:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d0a:	eb 1f                	jmp    800d2b <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d0c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d10:	79 83                	jns    800c95 <vprintfmt+0x54>
				width = 0;
  800d12:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d19:	e9 77 ff ff ff       	jmp    800c95 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d1e:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d25:	e9 6b ff ff ff       	jmp    800c95 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d2a:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d2b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d2f:	0f 89 60 ff ff ff    	jns    800c95 <vprintfmt+0x54>
				width = precision, precision = -1;
  800d35:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d38:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d3b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d42:	e9 4e ff ff ff       	jmp    800c95 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d47:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d4a:	e9 46 ff ff ff       	jmp    800c95 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d4f:	8b 45 14             	mov    0x14(%ebp),%eax
  800d52:	83 c0 04             	add    $0x4,%eax
  800d55:	89 45 14             	mov    %eax,0x14(%ebp)
  800d58:	8b 45 14             	mov    0x14(%ebp),%eax
  800d5b:	83 e8 04             	sub    $0x4,%eax
  800d5e:	8b 00                	mov    (%eax),%eax
  800d60:	83 ec 08             	sub    $0x8,%esp
  800d63:	ff 75 0c             	pushl  0xc(%ebp)
  800d66:	50                   	push   %eax
  800d67:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6a:	ff d0                	call   *%eax
  800d6c:	83 c4 10             	add    $0x10,%esp
			break;
  800d6f:	e9 89 02 00 00       	jmp    800ffd <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d74:	8b 45 14             	mov    0x14(%ebp),%eax
  800d77:	83 c0 04             	add    $0x4,%eax
  800d7a:	89 45 14             	mov    %eax,0x14(%ebp)
  800d7d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d80:	83 e8 04             	sub    $0x4,%eax
  800d83:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d85:	85 db                	test   %ebx,%ebx
  800d87:	79 02                	jns    800d8b <vprintfmt+0x14a>
				err = -err;
  800d89:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d8b:	83 fb 64             	cmp    $0x64,%ebx
  800d8e:	7f 0b                	jg     800d9b <vprintfmt+0x15a>
  800d90:	8b 34 9d c0 2a 80 00 	mov    0x802ac0(,%ebx,4),%esi
  800d97:	85 f6                	test   %esi,%esi
  800d99:	75 19                	jne    800db4 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d9b:	53                   	push   %ebx
  800d9c:	68 65 2c 80 00       	push   $0x802c65
  800da1:	ff 75 0c             	pushl  0xc(%ebp)
  800da4:	ff 75 08             	pushl  0x8(%ebp)
  800da7:	e8 5e 02 00 00       	call   80100a <printfmt>
  800dac:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800daf:	e9 49 02 00 00       	jmp    800ffd <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800db4:	56                   	push   %esi
  800db5:	68 6e 2c 80 00       	push   $0x802c6e
  800dba:	ff 75 0c             	pushl  0xc(%ebp)
  800dbd:	ff 75 08             	pushl  0x8(%ebp)
  800dc0:	e8 45 02 00 00       	call   80100a <printfmt>
  800dc5:	83 c4 10             	add    $0x10,%esp
			break;
  800dc8:	e9 30 02 00 00       	jmp    800ffd <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800dcd:	8b 45 14             	mov    0x14(%ebp),%eax
  800dd0:	83 c0 04             	add    $0x4,%eax
  800dd3:	89 45 14             	mov    %eax,0x14(%ebp)
  800dd6:	8b 45 14             	mov    0x14(%ebp),%eax
  800dd9:	83 e8 04             	sub    $0x4,%eax
  800ddc:	8b 30                	mov    (%eax),%esi
  800dde:	85 f6                	test   %esi,%esi
  800de0:	75 05                	jne    800de7 <vprintfmt+0x1a6>
				p = "(null)";
  800de2:	be 71 2c 80 00       	mov    $0x802c71,%esi
			if (width > 0 && padc != '-')
  800de7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800deb:	7e 6d                	jle    800e5a <vprintfmt+0x219>
  800ded:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800df1:	74 67                	je     800e5a <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800df3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800df6:	83 ec 08             	sub    $0x8,%esp
  800df9:	50                   	push   %eax
  800dfa:	56                   	push   %esi
  800dfb:	e8 12 05 00 00       	call   801312 <strnlen>
  800e00:	83 c4 10             	add    $0x10,%esp
  800e03:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e06:	eb 16                	jmp    800e1e <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e08:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e0c:	83 ec 08             	sub    $0x8,%esp
  800e0f:	ff 75 0c             	pushl  0xc(%ebp)
  800e12:	50                   	push   %eax
  800e13:	8b 45 08             	mov    0x8(%ebp),%eax
  800e16:	ff d0                	call   *%eax
  800e18:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e1b:	ff 4d e4             	decl   -0x1c(%ebp)
  800e1e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e22:	7f e4                	jg     800e08 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e24:	eb 34                	jmp    800e5a <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e26:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e2a:	74 1c                	je     800e48 <vprintfmt+0x207>
  800e2c:	83 fb 1f             	cmp    $0x1f,%ebx
  800e2f:	7e 05                	jle    800e36 <vprintfmt+0x1f5>
  800e31:	83 fb 7e             	cmp    $0x7e,%ebx
  800e34:	7e 12                	jle    800e48 <vprintfmt+0x207>
					putch('?', putdat);
  800e36:	83 ec 08             	sub    $0x8,%esp
  800e39:	ff 75 0c             	pushl  0xc(%ebp)
  800e3c:	6a 3f                	push   $0x3f
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	ff d0                	call   *%eax
  800e43:	83 c4 10             	add    $0x10,%esp
  800e46:	eb 0f                	jmp    800e57 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e48:	83 ec 08             	sub    $0x8,%esp
  800e4b:	ff 75 0c             	pushl  0xc(%ebp)
  800e4e:	53                   	push   %ebx
  800e4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e52:	ff d0                	call   *%eax
  800e54:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e57:	ff 4d e4             	decl   -0x1c(%ebp)
  800e5a:	89 f0                	mov    %esi,%eax
  800e5c:	8d 70 01             	lea    0x1(%eax),%esi
  800e5f:	8a 00                	mov    (%eax),%al
  800e61:	0f be d8             	movsbl %al,%ebx
  800e64:	85 db                	test   %ebx,%ebx
  800e66:	74 24                	je     800e8c <vprintfmt+0x24b>
  800e68:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e6c:	78 b8                	js     800e26 <vprintfmt+0x1e5>
  800e6e:	ff 4d e0             	decl   -0x20(%ebp)
  800e71:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e75:	79 af                	jns    800e26 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e77:	eb 13                	jmp    800e8c <vprintfmt+0x24b>
				putch(' ', putdat);
  800e79:	83 ec 08             	sub    $0x8,%esp
  800e7c:	ff 75 0c             	pushl  0xc(%ebp)
  800e7f:	6a 20                	push   $0x20
  800e81:	8b 45 08             	mov    0x8(%ebp),%eax
  800e84:	ff d0                	call   *%eax
  800e86:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e89:	ff 4d e4             	decl   -0x1c(%ebp)
  800e8c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e90:	7f e7                	jg     800e79 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e92:	e9 66 01 00 00       	jmp    800ffd <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e97:	83 ec 08             	sub    $0x8,%esp
  800e9a:	ff 75 e8             	pushl  -0x18(%ebp)
  800e9d:	8d 45 14             	lea    0x14(%ebp),%eax
  800ea0:	50                   	push   %eax
  800ea1:	e8 3c fd ff ff       	call   800be2 <getint>
  800ea6:	83 c4 10             	add    $0x10,%esp
  800ea9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eac:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800eaf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800eb2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800eb5:	85 d2                	test   %edx,%edx
  800eb7:	79 23                	jns    800edc <vprintfmt+0x29b>
				putch('-', putdat);
  800eb9:	83 ec 08             	sub    $0x8,%esp
  800ebc:	ff 75 0c             	pushl  0xc(%ebp)
  800ebf:	6a 2d                	push   $0x2d
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec4:	ff d0                	call   *%eax
  800ec6:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ec9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ecc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ecf:	f7 d8                	neg    %eax
  800ed1:	83 d2 00             	adc    $0x0,%edx
  800ed4:	f7 da                	neg    %edx
  800ed6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ed9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800edc:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ee3:	e9 bc 00 00 00       	jmp    800fa4 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ee8:	83 ec 08             	sub    $0x8,%esp
  800eeb:	ff 75 e8             	pushl  -0x18(%ebp)
  800eee:	8d 45 14             	lea    0x14(%ebp),%eax
  800ef1:	50                   	push   %eax
  800ef2:	e8 84 fc ff ff       	call   800b7b <getuint>
  800ef7:	83 c4 10             	add    $0x10,%esp
  800efa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800efd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f00:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f07:	e9 98 00 00 00       	jmp    800fa4 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f0c:	83 ec 08             	sub    $0x8,%esp
  800f0f:	ff 75 0c             	pushl  0xc(%ebp)
  800f12:	6a 58                	push   $0x58
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
  800f17:	ff d0                	call   *%eax
  800f19:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f1c:	83 ec 08             	sub    $0x8,%esp
  800f1f:	ff 75 0c             	pushl  0xc(%ebp)
  800f22:	6a 58                	push   $0x58
  800f24:	8b 45 08             	mov    0x8(%ebp),%eax
  800f27:	ff d0                	call   *%eax
  800f29:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f2c:	83 ec 08             	sub    $0x8,%esp
  800f2f:	ff 75 0c             	pushl  0xc(%ebp)
  800f32:	6a 58                	push   $0x58
  800f34:	8b 45 08             	mov    0x8(%ebp),%eax
  800f37:	ff d0                	call   *%eax
  800f39:	83 c4 10             	add    $0x10,%esp
			break;
  800f3c:	e9 bc 00 00 00       	jmp    800ffd <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f41:	83 ec 08             	sub    $0x8,%esp
  800f44:	ff 75 0c             	pushl  0xc(%ebp)
  800f47:	6a 30                	push   $0x30
  800f49:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4c:	ff d0                	call   *%eax
  800f4e:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f51:	83 ec 08             	sub    $0x8,%esp
  800f54:	ff 75 0c             	pushl  0xc(%ebp)
  800f57:	6a 78                	push   $0x78
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5c:	ff d0                	call   *%eax
  800f5e:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f61:	8b 45 14             	mov    0x14(%ebp),%eax
  800f64:	83 c0 04             	add    $0x4,%eax
  800f67:	89 45 14             	mov    %eax,0x14(%ebp)
  800f6a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f6d:	83 e8 04             	sub    $0x4,%eax
  800f70:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f72:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f75:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f7c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f83:	eb 1f                	jmp    800fa4 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f85:	83 ec 08             	sub    $0x8,%esp
  800f88:	ff 75 e8             	pushl  -0x18(%ebp)
  800f8b:	8d 45 14             	lea    0x14(%ebp),%eax
  800f8e:	50                   	push   %eax
  800f8f:	e8 e7 fb ff ff       	call   800b7b <getuint>
  800f94:	83 c4 10             	add    $0x10,%esp
  800f97:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f9a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f9d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800fa4:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800fa8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fab:	83 ec 04             	sub    $0x4,%esp
  800fae:	52                   	push   %edx
  800faf:	ff 75 e4             	pushl  -0x1c(%ebp)
  800fb2:	50                   	push   %eax
  800fb3:	ff 75 f4             	pushl  -0xc(%ebp)
  800fb6:	ff 75 f0             	pushl  -0x10(%ebp)
  800fb9:	ff 75 0c             	pushl  0xc(%ebp)
  800fbc:	ff 75 08             	pushl  0x8(%ebp)
  800fbf:	e8 00 fb ff ff       	call   800ac4 <printnum>
  800fc4:	83 c4 20             	add    $0x20,%esp
			break;
  800fc7:	eb 34                	jmp    800ffd <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800fc9:	83 ec 08             	sub    $0x8,%esp
  800fcc:	ff 75 0c             	pushl  0xc(%ebp)
  800fcf:	53                   	push   %ebx
  800fd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd3:	ff d0                	call   *%eax
  800fd5:	83 c4 10             	add    $0x10,%esp
			break;
  800fd8:	eb 23                	jmp    800ffd <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800fda:	83 ec 08             	sub    $0x8,%esp
  800fdd:	ff 75 0c             	pushl  0xc(%ebp)
  800fe0:	6a 25                	push   $0x25
  800fe2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe5:	ff d0                	call   *%eax
  800fe7:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800fea:	ff 4d 10             	decl   0x10(%ebp)
  800fed:	eb 03                	jmp    800ff2 <vprintfmt+0x3b1>
  800fef:	ff 4d 10             	decl   0x10(%ebp)
  800ff2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff5:	48                   	dec    %eax
  800ff6:	8a 00                	mov    (%eax),%al
  800ff8:	3c 25                	cmp    $0x25,%al
  800ffa:	75 f3                	jne    800fef <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ffc:	90                   	nop
		}
	}
  800ffd:	e9 47 fc ff ff       	jmp    800c49 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801002:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801003:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801006:	5b                   	pop    %ebx
  801007:	5e                   	pop    %esi
  801008:	5d                   	pop    %ebp
  801009:	c3                   	ret    

0080100a <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80100a:	55                   	push   %ebp
  80100b:	89 e5                	mov    %esp,%ebp
  80100d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801010:	8d 45 10             	lea    0x10(%ebp),%eax
  801013:	83 c0 04             	add    $0x4,%eax
  801016:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801019:	8b 45 10             	mov    0x10(%ebp),%eax
  80101c:	ff 75 f4             	pushl  -0xc(%ebp)
  80101f:	50                   	push   %eax
  801020:	ff 75 0c             	pushl  0xc(%ebp)
  801023:	ff 75 08             	pushl  0x8(%ebp)
  801026:	e8 16 fc ff ff       	call   800c41 <vprintfmt>
  80102b:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80102e:	90                   	nop
  80102f:	c9                   	leave  
  801030:	c3                   	ret    

00801031 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801031:	55                   	push   %ebp
  801032:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801034:	8b 45 0c             	mov    0xc(%ebp),%eax
  801037:	8b 40 08             	mov    0x8(%eax),%eax
  80103a:	8d 50 01             	lea    0x1(%eax),%edx
  80103d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801040:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801043:	8b 45 0c             	mov    0xc(%ebp),%eax
  801046:	8b 10                	mov    (%eax),%edx
  801048:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104b:	8b 40 04             	mov    0x4(%eax),%eax
  80104e:	39 c2                	cmp    %eax,%edx
  801050:	73 12                	jae    801064 <sprintputch+0x33>
		*b->buf++ = ch;
  801052:	8b 45 0c             	mov    0xc(%ebp),%eax
  801055:	8b 00                	mov    (%eax),%eax
  801057:	8d 48 01             	lea    0x1(%eax),%ecx
  80105a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80105d:	89 0a                	mov    %ecx,(%edx)
  80105f:	8b 55 08             	mov    0x8(%ebp),%edx
  801062:	88 10                	mov    %dl,(%eax)
}
  801064:	90                   	nop
  801065:	5d                   	pop    %ebp
  801066:	c3                   	ret    

00801067 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801067:	55                   	push   %ebp
  801068:	89 e5                	mov    %esp,%ebp
  80106a:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
  801070:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801073:	8b 45 0c             	mov    0xc(%ebp),%eax
  801076:	8d 50 ff             	lea    -0x1(%eax),%edx
  801079:	8b 45 08             	mov    0x8(%ebp),%eax
  80107c:	01 d0                	add    %edx,%eax
  80107e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801081:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801088:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80108c:	74 06                	je     801094 <vsnprintf+0x2d>
  80108e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801092:	7f 07                	jg     80109b <vsnprintf+0x34>
		return -E_INVAL;
  801094:	b8 03 00 00 00       	mov    $0x3,%eax
  801099:	eb 20                	jmp    8010bb <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80109b:	ff 75 14             	pushl  0x14(%ebp)
  80109e:	ff 75 10             	pushl  0x10(%ebp)
  8010a1:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8010a4:	50                   	push   %eax
  8010a5:	68 31 10 80 00       	push   $0x801031
  8010aa:	e8 92 fb ff ff       	call   800c41 <vprintfmt>
  8010af:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010b5:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8010b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8010bb:	c9                   	leave  
  8010bc:	c3                   	ret    

008010bd <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8010bd:	55                   	push   %ebp
  8010be:	89 e5                	mov    %esp,%ebp
  8010c0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8010c3:	8d 45 10             	lea    0x10(%ebp),%eax
  8010c6:	83 c0 04             	add    $0x4,%eax
  8010c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8010cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8010cf:	ff 75 f4             	pushl  -0xc(%ebp)
  8010d2:	50                   	push   %eax
  8010d3:	ff 75 0c             	pushl  0xc(%ebp)
  8010d6:	ff 75 08             	pushl  0x8(%ebp)
  8010d9:	e8 89 ff ff ff       	call   801067 <vsnprintf>
  8010de:	83 c4 10             	add    $0x10,%esp
  8010e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8010e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010e7:	c9                   	leave  
  8010e8:	c3                   	ret    

008010e9 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8010e9:	55                   	push   %ebp
  8010ea:	89 e5                	mov    %esp,%ebp
  8010ec:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8010ef:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010f3:	74 13                	je     801108 <readline+0x1f>
		cprintf("%s", prompt);
  8010f5:	83 ec 08             	sub    $0x8,%esp
  8010f8:	ff 75 08             	pushl  0x8(%ebp)
  8010fb:	68 d0 2d 80 00       	push   $0x802dd0
  801100:	e8 62 f9 ff ff       	call   800a67 <cprintf>
  801105:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801108:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80110f:	83 ec 0c             	sub    $0xc,%esp
  801112:	6a 00                	push   $0x0
  801114:	e8 65 f5 ff ff       	call   80067e <iscons>
  801119:	83 c4 10             	add    $0x10,%esp
  80111c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80111f:	e8 0c f5 ff ff       	call   800630 <getchar>
  801124:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801127:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80112b:	79 22                	jns    80114f <readline+0x66>
			if (c != -E_EOF)
  80112d:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801131:	0f 84 ad 00 00 00    	je     8011e4 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801137:	83 ec 08             	sub    $0x8,%esp
  80113a:	ff 75 ec             	pushl  -0x14(%ebp)
  80113d:	68 d3 2d 80 00       	push   $0x802dd3
  801142:	e8 20 f9 ff ff       	call   800a67 <cprintf>
  801147:	83 c4 10             	add    $0x10,%esp
			return;
  80114a:	e9 95 00 00 00       	jmp    8011e4 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80114f:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801153:	7e 34                	jle    801189 <readline+0xa0>
  801155:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80115c:	7f 2b                	jg     801189 <readline+0xa0>
			if (echoing)
  80115e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801162:	74 0e                	je     801172 <readline+0x89>
				cputchar(c);
  801164:	83 ec 0c             	sub    $0xc,%esp
  801167:	ff 75 ec             	pushl  -0x14(%ebp)
  80116a:	e8 79 f4 ff ff       	call   8005e8 <cputchar>
  80116f:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801172:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801175:	8d 50 01             	lea    0x1(%eax),%edx
  801178:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80117b:	89 c2                	mov    %eax,%edx
  80117d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801180:	01 d0                	add    %edx,%eax
  801182:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801185:	88 10                	mov    %dl,(%eax)
  801187:	eb 56                	jmp    8011df <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801189:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80118d:	75 1f                	jne    8011ae <readline+0xc5>
  80118f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801193:	7e 19                	jle    8011ae <readline+0xc5>
			if (echoing)
  801195:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801199:	74 0e                	je     8011a9 <readline+0xc0>
				cputchar(c);
  80119b:	83 ec 0c             	sub    $0xc,%esp
  80119e:	ff 75 ec             	pushl  -0x14(%ebp)
  8011a1:	e8 42 f4 ff ff       	call   8005e8 <cputchar>
  8011a6:	83 c4 10             	add    $0x10,%esp

			i--;
  8011a9:	ff 4d f4             	decl   -0xc(%ebp)
  8011ac:	eb 31                	jmp    8011df <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8011ae:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011b2:	74 0a                	je     8011be <readline+0xd5>
  8011b4:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8011b8:	0f 85 61 ff ff ff    	jne    80111f <readline+0x36>
			if (echoing)
  8011be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011c2:	74 0e                	je     8011d2 <readline+0xe9>
				cputchar(c);
  8011c4:	83 ec 0c             	sub    $0xc,%esp
  8011c7:	ff 75 ec             	pushl  -0x14(%ebp)
  8011ca:	e8 19 f4 ff ff       	call   8005e8 <cputchar>
  8011cf:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8011d2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d8:	01 d0                	add    %edx,%eax
  8011da:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8011dd:	eb 06                	jmp    8011e5 <readline+0xfc>
		}
	}
  8011df:	e9 3b ff ff ff       	jmp    80111f <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8011e4:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8011e5:	c9                   	leave  
  8011e6:	c3                   	ret    

008011e7 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8011e7:	55                   	push   %ebp
  8011e8:	89 e5                	mov    %esp,%ebp
  8011ea:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8011ed:	e8 4b 0e 00 00       	call   80203d <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8011f2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011f6:	74 13                	je     80120b <atomic_readline+0x24>
		cprintf("%s", prompt);
  8011f8:	83 ec 08             	sub    $0x8,%esp
  8011fb:	ff 75 08             	pushl  0x8(%ebp)
  8011fe:	68 d0 2d 80 00       	push   $0x802dd0
  801203:	e8 5f f8 ff ff       	call   800a67 <cprintf>
  801208:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80120b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801212:	83 ec 0c             	sub    $0xc,%esp
  801215:	6a 00                	push   $0x0
  801217:	e8 62 f4 ff ff       	call   80067e <iscons>
  80121c:	83 c4 10             	add    $0x10,%esp
  80121f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801222:	e8 09 f4 ff ff       	call   800630 <getchar>
  801227:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80122a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80122e:	79 23                	jns    801253 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801230:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801234:	74 13                	je     801249 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801236:	83 ec 08             	sub    $0x8,%esp
  801239:	ff 75 ec             	pushl  -0x14(%ebp)
  80123c:	68 d3 2d 80 00       	push   $0x802dd3
  801241:	e8 21 f8 ff ff       	call   800a67 <cprintf>
  801246:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801249:	e8 09 0e 00 00       	call   802057 <sys_enable_interrupt>
			return;
  80124e:	e9 9a 00 00 00       	jmp    8012ed <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801253:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801257:	7e 34                	jle    80128d <atomic_readline+0xa6>
  801259:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801260:	7f 2b                	jg     80128d <atomic_readline+0xa6>
			if (echoing)
  801262:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801266:	74 0e                	je     801276 <atomic_readline+0x8f>
				cputchar(c);
  801268:	83 ec 0c             	sub    $0xc,%esp
  80126b:	ff 75 ec             	pushl  -0x14(%ebp)
  80126e:	e8 75 f3 ff ff       	call   8005e8 <cputchar>
  801273:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801276:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801279:	8d 50 01             	lea    0x1(%eax),%edx
  80127c:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80127f:	89 c2                	mov    %eax,%edx
  801281:	8b 45 0c             	mov    0xc(%ebp),%eax
  801284:	01 d0                	add    %edx,%eax
  801286:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801289:	88 10                	mov    %dl,(%eax)
  80128b:	eb 5b                	jmp    8012e8 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  80128d:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801291:	75 1f                	jne    8012b2 <atomic_readline+0xcb>
  801293:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801297:	7e 19                	jle    8012b2 <atomic_readline+0xcb>
			if (echoing)
  801299:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80129d:	74 0e                	je     8012ad <atomic_readline+0xc6>
				cputchar(c);
  80129f:	83 ec 0c             	sub    $0xc,%esp
  8012a2:	ff 75 ec             	pushl  -0x14(%ebp)
  8012a5:	e8 3e f3 ff ff       	call   8005e8 <cputchar>
  8012aa:	83 c4 10             	add    $0x10,%esp
			i--;
  8012ad:	ff 4d f4             	decl   -0xc(%ebp)
  8012b0:	eb 36                	jmp    8012e8 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8012b2:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012b6:	74 0a                	je     8012c2 <atomic_readline+0xdb>
  8012b8:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012bc:	0f 85 60 ff ff ff    	jne    801222 <atomic_readline+0x3b>
			if (echoing)
  8012c2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012c6:	74 0e                	je     8012d6 <atomic_readline+0xef>
				cputchar(c);
  8012c8:	83 ec 0c             	sub    $0xc,%esp
  8012cb:	ff 75 ec             	pushl  -0x14(%ebp)
  8012ce:	e8 15 f3 ff ff       	call   8005e8 <cputchar>
  8012d3:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8012d6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012dc:	01 d0                	add    %edx,%eax
  8012de:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8012e1:	e8 71 0d 00 00       	call   802057 <sys_enable_interrupt>
			return;
  8012e6:	eb 05                	jmp    8012ed <atomic_readline+0x106>
		}
	}
  8012e8:	e9 35 ff ff ff       	jmp    801222 <atomic_readline+0x3b>
}
  8012ed:	c9                   	leave  
  8012ee:	c3                   	ret    

008012ef <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8012ef:	55                   	push   %ebp
  8012f0:	89 e5                	mov    %esp,%ebp
  8012f2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8012f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012fc:	eb 06                	jmp    801304 <strlen+0x15>
		n++;
  8012fe:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801301:	ff 45 08             	incl   0x8(%ebp)
  801304:	8b 45 08             	mov    0x8(%ebp),%eax
  801307:	8a 00                	mov    (%eax),%al
  801309:	84 c0                	test   %al,%al
  80130b:	75 f1                	jne    8012fe <strlen+0xf>
		n++;
	return n;
  80130d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801310:	c9                   	leave  
  801311:	c3                   	ret    

00801312 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801312:	55                   	push   %ebp
  801313:	89 e5                	mov    %esp,%ebp
  801315:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801318:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80131f:	eb 09                	jmp    80132a <strnlen+0x18>
		n++;
  801321:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801324:	ff 45 08             	incl   0x8(%ebp)
  801327:	ff 4d 0c             	decl   0xc(%ebp)
  80132a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80132e:	74 09                	je     801339 <strnlen+0x27>
  801330:	8b 45 08             	mov    0x8(%ebp),%eax
  801333:	8a 00                	mov    (%eax),%al
  801335:	84 c0                	test   %al,%al
  801337:	75 e8                	jne    801321 <strnlen+0xf>
		n++;
	return n;
  801339:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80133c:	c9                   	leave  
  80133d:	c3                   	ret    

0080133e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80133e:	55                   	push   %ebp
  80133f:	89 e5                	mov    %esp,%ebp
  801341:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801344:	8b 45 08             	mov    0x8(%ebp),%eax
  801347:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80134a:	90                   	nop
  80134b:	8b 45 08             	mov    0x8(%ebp),%eax
  80134e:	8d 50 01             	lea    0x1(%eax),%edx
  801351:	89 55 08             	mov    %edx,0x8(%ebp)
  801354:	8b 55 0c             	mov    0xc(%ebp),%edx
  801357:	8d 4a 01             	lea    0x1(%edx),%ecx
  80135a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80135d:	8a 12                	mov    (%edx),%dl
  80135f:	88 10                	mov    %dl,(%eax)
  801361:	8a 00                	mov    (%eax),%al
  801363:	84 c0                	test   %al,%al
  801365:	75 e4                	jne    80134b <strcpy+0xd>
		/* do nothing */;
	return ret;
  801367:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80136a:	c9                   	leave  
  80136b:	c3                   	ret    

0080136c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80136c:	55                   	push   %ebp
  80136d:	89 e5                	mov    %esp,%ebp
  80136f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801372:	8b 45 08             	mov    0x8(%ebp),%eax
  801375:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801378:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80137f:	eb 1f                	jmp    8013a0 <strncpy+0x34>
		*dst++ = *src;
  801381:	8b 45 08             	mov    0x8(%ebp),%eax
  801384:	8d 50 01             	lea    0x1(%eax),%edx
  801387:	89 55 08             	mov    %edx,0x8(%ebp)
  80138a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80138d:	8a 12                	mov    (%edx),%dl
  80138f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801391:	8b 45 0c             	mov    0xc(%ebp),%eax
  801394:	8a 00                	mov    (%eax),%al
  801396:	84 c0                	test   %al,%al
  801398:	74 03                	je     80139d <strncpy+0x31>
			src++;
  80139a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80139d:	ff 45 fc             	incl   -0x4(%ebp)
  8013a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013a3:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013a6:	72 d9                	jb     801381 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013ab:	c9                   	leave  
  8013ac:	c3                   	ret    

008013ad <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013ad:	55                   	push   %ebp
  8013ae:	89 e5                	mov    %esp,%ebp
  8013b0:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8013b9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013bd:	74 30                	je     8013ef <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8013bf:	eb 16                	jmp    8013d7 <strlcpy+0x2a>
			*dst++ = *src++;
  8013c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c4:	8d 50 01             	lea    0x1(%eax),%edx
  8013c7:	89 55 08             	mov    %edx,0x8(%ebp)
  8013ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013cd:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013d0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013d3:	8a 12                	mov    (%edx),%dl
  8013d5:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8013d7:	ff 4d 10             	decl   0x10(%ebp)
  8013da:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013de:	74 09                	je     8013e9 <strlcpy+0x3c>
  8013e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e3:	8a 00                	mov    (%eax),%al
  8013e5:	84 c0                	test   %al,%al
  8013e7:	75 d8                	jne    8013c1 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8013e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ec:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8013ef:	8b 55 08             	mov    0x8(%ebp),%edx
  8013f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013f5:	29 c2                	sub    %eax,%edx
  8013f7:	89 d0                	mov    %edx,%eax
}
  8013f9:	c9                   	leave  
  8013fa:	c3                   	ret    

008013fb <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8013fb:	55                   	push   %ebp
  8013fc:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8013fe:	eb 06                	jmp    801406 <strcmp+0xb>
		p++, q++;
  801400:	ff 45 08             	incl   0x8(%ebp)
  801403:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801406:	8b 45 08             	mov    0x8(%ebp),%eax
  801409:	8a 00                	mov    (%eax),%al
  80140b:	84 c0                	test   %al,%al
  80140d:	74 0e                	je     80141d <strcmp+0x22>
  80140f:	8b 45 08             	mov    0x8(%ebp),%eax
  801412:	8a 10                	mov    (%eax),%dl
  801414:	8b 45 0c             	mov    0xc(%ebp),%eax
  801417:	8a 00                	mov    (%eax),%al
  801419:	38 c2                	cmp    %al,%dl
  80141b:	74 e3                	je     801400 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80141d:	8b 45 08             	mov    0x8(%ebp),%eax
  801420:	8a 00                	mov    (%eax),%al
  801422:	0f b6 d0             	movzbl %al,%edx
  801425:	8b 45 0c             	mov    0xc(%ebp),%eax
  801428:	8a 00                	mov    (%eax),%al
  80142a:	0f b6 c0             	movzbl %al,%eax
  80142d:	29 c2                	sub    %eax,%edx
  80142f:	89 d0                	mov    %edx,%eax
}
  801431:	5d                   	pop    %ebp
  801432:	c3                   	ret    

00801433 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801433:	55                   	push   %ebp
  801434:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801436:	eb 09                	jmp    801441 <strncmp+0xe>
		n--, p++, q++;
  801438:	ff 4d 10             	decl   0x10(%ebp)
  80143b:	ff 45 08             	incl   0x8(%ebp)
  80143e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801441:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801445:	74 17                	je     80145e <strncmp+0x2b>
  801447:	8b 45 08             	mov    0x8(%ebp),%eax
  80144a:	8a 00                	mov    (%eax),%al
  80144c:	84 c0                	test   %al,%al
  80144e:	74 0e                	je     80145e <strncmp+0x2b>
  801450:	8b 45 08             	mov    0x8(%ebp),%eax
  801453:	8a 10                	mov    (%eax),%dl
  801455:	8b 45 0c             	mov    0xc(%ebp),%eax
  801458:	8a 00                	mov    (%eax),%al
  80145a:	38 c2                	cmp    %al,%dl
  80145c:	74 da                	je     801438 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80145e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801462:	75 07                	jne    80146b <strncmp+0x38>
		return 0;
  801464:	b8 00 00 00 00       	mov    $0x0,%eax
  801469:	eb 14                	jmp    80147f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80146b:	8b 45 08             	mov    0x8(%ebp),%eax
  80146e:	8a 00                	mov    (%eax),%al
  801470:	0f b6 d0             	movzbl %al,%edx
  801473:	8b 45 0c             	mov    0xc(%ebp),%eax
  801476:	8a 00                	mov    (%eax),%al
  801478:	0f b6 c0             	movzbl %al,%eax
  80147b:	29 c2                	sub    %eax,%edx
  80147d:	89 d0                	mov    %edx,%eax
}
  80147f:	5d                   	pop    %ebp
  801480:	c3                   	ret    

00801481 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801481:	55                   	push   %ebp
  801482:	89 e5                	mov    %esp,%ebp
  801484:	83 ec 04             	sub    $0x4,%esp
  801487:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80148d:	eb 12                	jmp    8014a1 <strchr+0x20>
		if (*s == c)
  80148f:	8b 45 08             	mov    0x8(%ebp),%eax
  801492:	8a 00                	mov    (%eax),%al
  801494:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801497:	75 05                	jne    80149e <strchr+0x1d>
			return (char *) s;
  801499:	8b 45 08             	mov    0x8(%ebp),%eax
  80149c:	eb 11                	jmp    8014af <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80149e:	ff 45 08             	incl   0x8(%ebp)
  8014a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a4:	8a 00                	mov    (%eax),%al
  8014a6:	84 c0                	test   %al,%al
  8014a8:	75 e5                	jne    80148f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014aa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014af:	c9                   	leave  
  8014b0:	c3                   	ret    

008014b1 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014b1:	55                   	push   %ebp
  8014b2:	89 e5                	mov    %esp,%ebp
  8014b4:	83 ec 04             	sub    $0x4,%esp
  8014b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ba:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014bd:	eb 0d                	jmp    8014cc <strfind+0x1b>
		if (*s == c)
  8014bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c2:	8a 00                	mov    (%eax),%al
  8014c4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014c7:	74 0e                	je     8014d7 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8014c9:	ff 45 08             	incl   0x8(%ebp)
  8014cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cf:	8a 00                	mov    (%eax),%al
  8014d1:	84 c0                	test   %al,%al
  8014d3:	75 ea                	jne    8014bf <strfind+0xe>
  8014d5:	eb 01                	jmp    8014d8 <strfind+0x27>
		if (*s == c)
			break;
  8014d7:	90                   	nop
	return (char *) s;
  8014d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014db:	c9                   	leave  
  8014dc:	c3                   	ret    

008014dd <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8014dd:	55                   	push   %ebp
  8014de:	89 e5                	mov    %esp,%ebp
  8014e0:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8014e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8014e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8014ef:	eb 0e                	jmp    8014ff <memset+0x22>
		*p++ = c;
  8014f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014f4:	8d 50 01             	lea    0x1(%eax),%edx
  8014f7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014fd:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8014ff:	ff 4d f8             	decl   -0x8(%ebp)
  801502:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801506:	79 e9                	jns    8014f1 <memset+0x14>
		*p++ = c;

	return v;
  801508:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80150b:	c9                   	leave  
  80150c:	c3                   	ret    

0080150d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80150d:	55                   	push   %ebp
  80150e:	89 e5                	mov    %esp,%ebp
  801510:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801513:	8b 45 0c             	mov    0xc(%ebp),%eax
  801516:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801519:	8b 45 08             	mov    0x8(%ebp),%eax
  80151c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80151f:	eb 16                	jmp    801537 <memcpy+0x2a>
		*d++ = *s++;
  801521:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801524:	8d 50 01             	lea    0x1(%eax),%edx
  801527:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80152a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80152d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801530:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801533:	8a 12                	mov    (%edx),%dl
  801535:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801537:	8b 45 10             	mov    0x10(%ebp),%eax
  80153a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80153d:	89 55 10             	mov    %edx,0x10(%ebp)
  801540:	85 c0                	test   %eax,%eax
  801542:	75 dd                	jne    801521 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801544:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801547:	c9                   	leave  
  801548:	c3                   	ret    

00801549 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801549:	55                   	push   %ebp
  80154a:	89 e5                	mov    %esp,%ebp
  80154c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80154f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801552:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801555:	8b 45 08             	mov    0x8(%ebp),%eax
  801558:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80155b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80155e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801561:	73 50                	jae    8015b3 <memmove+0x6a>
  801563:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801566:	8b 45 10             	mov    0x10(%ebp),%eax
  801569:	01 d0                	add    %edx,%eax
  80156b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80156e:	76 43                	jbe    8015b3 <memmove+0x6a>
		s += n;
  801570:	8b 45 10             	mov    0x10(%ebp),%eax
  801573:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801576:	8b 45 10             	mov    0x10(%ebp),%eax
  801579:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80157c:	eb 10                	jmp    80158e <memmove+0x45>
			*--d = *--s;
  80157e:	ff 4d f8             	decl   -0x8(%ebp)
  801581:	ff 4d fc             	decl   -0x4(%ebp)
  801584:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801587:	8a 10                	mov    (%eax),%dl
  801589:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80158c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80158e:	8b 45 10             	mov    0x10(%ebp),%eax
  801591:	8d 50 ff             	lea    -0x1(%eax),%edx
  801594:	89 55 10             	mov    %edx,0x10(%ebp)
  801597:	85 c0                	test   %eax,%eax
  801599:	75 e3                	jne    80157e <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80159b:	eb 23                	jmp    8015c0 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80159d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015a0:	8d 50 01             	lea    0x1(%eax),%edx
  8015a3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015a6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015a9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015ac:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015af:	8a 12                	mov    (%edx),%dl
  8015b1:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015b9:	89 55 10             	mov    %edx,0x10(%ebp)
  8015bc:	85 c0                	test   %eax,%eax
  8015be:	75 dd                	jne    80159d <memmove+0x54>
			*d++ = *s++;

	return dst;
  8015c0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015c3:	c9                   	leave  
  8015c4:	c3                   	ret    

008015c5 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8015c5:	55                   	push   %ebp
  8015c6:	89 e5                	mov    %esp,%ebp
  8015c8:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8015cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8015d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d4:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8015d7:	eb 2a                	jmp    801603 <memcmp+0x3e>
		if (*s1 != *s2)
  8015d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015dc:	8a 10                	mov    (%eax),%dl
  8015de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e1:	8a 00                	mov    (%eax),%al
  8015e3:	38 c2                	cmp    %al,%dl
  8015e5:	74 16                	je     8015fd <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ea:	8a 00                	mov    (%eax),%al
  8015ec:	0f b6 d0             	movzbl %al,%edx
  8015ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015f2:	8a 00                	mov    (%eax),%al
  8015f4:	0f b6 c0             	movzbl %al,%eax
  8015f7:	29 c2                	sub    %eax,%edx
  8015f9:	89 d0                	mov    %edx,%eax
  8015fb:	eb 18                	jmp    801615 <memcmp+0x50>
		s1++, s2++;
  8015fd:	ff 45 fc             	incl   -0x4(%ebp)
  801600:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801603:	8b 45 10             	mov    0x10(%ebp),%eax
  801606:	8d 50 ff             	lea    -0x1(%eax),%edx
  801609:	89 55 10             	mov    %edx,0x10(%ebp)
  80160c:	85 c0                	test   %eax,%eax
  80160e:	75 c9                	jne    8015d9 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801610:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801615:	c9                   	leave  
  801616:	c3                   	ret    

00801617 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801617:	55                   	push   %ebp
  801618:	89 e5                	mov    %esp,%ebp
  80161a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80161d:	8b 55 08             	mov    0x8(%ebp),%edx
  801620:	8b 45 10             	mov    0x10(%ebp),%eax
  801623:	01 d0                	add    %edx,%eax
  801625:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801628:	eb 15                	jmp    80163f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80162a:	8b 45 08             	mov    0x8(%ebp),%eax
  80162d:	8a 00                	mov    (%eax),%al
  80162f:	0f b6 d0             	movzbl %al,%edx
  801632:	8b 45 0c             	mov    0xc(%ebp),%eax
  801635:	0f b6 c0             	movzbl %al,%eax
  801638:	39 c2                	cmp    %eax,%edx
  80163a:	74 0d                	je     801649 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80163c:	ff 45 08             	incl   0x8(%ebp)
  80163f:	8b 45 08             	mov    0x8(%ebp),%eax
  801642:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801645:	72 e3                	jb     80162a <memfind+0x13>
  801647:	eb 01                	jmp    80164a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801649:	90                   	nop
	return (void *) s;
  80164a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80164d:	c9                   	leave  
  80164e:	c3                   	ret    

0080164f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80164f:	55                   	push   %ebp
  801650:	89 e5                	mov    %esp,%ebp
  801652:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801655:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80165c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801663:	eb 03                	jmp    801668 <strtol+0x19>
		s++;
  801665:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801668:	8b 45 08             	mov    0x8(%ebp),%eax
  80166b:	8a 00                	mov    (%eax),%al
  80166d:	3c 20                	cmp    $0x20,%al
  80166f:	74 f4                	je     801665 <strtol+0x16>
  801671:	8b 45 08             	mov    0x8(%ebp),%eax
  801674:	8a 00                	mov    (%eax),%al
  801676:	3c 09                	cmp    $0x9,%al
  801678:	74 eb                	je     801665 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80167a:	8b 45 08             	mov    0x8(%ebp),%eax
  80167d:	8a 00                	mov    (%eax),%al
  80167f:	3c 2b                	cmp    $0x2b,%al
  801681:	75 05                	jne    801688 <strtol+0x39>
		s++;
  801683:	ff 45 08             	incl   0x8(%ebp)
  801686:	eb 13                	jmp    80169b <strtol+0x4c>
	else if (*s == '-')
  801688:	8b 45 08             	mov    0x8(%ebp),%eax
  80168b:	8a 00                	mov    (%eax),%al
  80168d:	3c 2d                	cmp    $0x2d,%al
  80168f:	75 0a                	jne    80169b <strtol+0x4c>
		s++, neg = 1;
  801691:	ff 45 08             	incl   0x8(%ebp)
  801694:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80169b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80169f:	74 06                	je     8016a7 <strtol+0x58>
  8016a1:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8016a5:	75 20                	jne    8016c7 <strtol+0x78>
  8016a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016aa:	8a 00                	mov    (%eax),%al
  8016ac:	3c 30                	cmp    $0x30,%al
  8016ae:	75 17                	jne    8016c7 <strtol+0x78>
  8016b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b3:	40                   	inc    %eax
  8016b4:	8a 00                	mov    (%eax),%al
  8016b6:	3c 78                	cmp    $0x78,%al
  8016b8:	75 0d                	jne    8016c7 <strtol+0x78>
		s += 2, base = 16;
  8016ba:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8016be:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8016c5:	eb 28                	jmp    8016ef <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8016c7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016cb:	75 15                	jne    8016e2 <strtol+0x93>
  8016cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d0:	8a 00                	mov    (%eax),%al
  8016d2:	3c 30                	cmp    $0x30,%al
  8016d4:	75 0c                	jne    8016e2 <strtol+0x93>
		s++, base = 8;
  8016d6:	ff 45 08             	incl   0x8(%ebp)
  8016d9:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8016e0:	eb 0d                	jmp    8016ef <strtol+0xa0>
	else if (base == 0)
  8016e2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016e6:	75 07                	jne    8016ef <strtol+0xa0>
		base = 10;
  8016e8:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f2:	8a 00                	mov    (%eax),%al
  8016f4:	3c 2f                	cmp    $0x2f,%al
  8016f6:	7e 19                	jle    801711 <strtol+0xc2>
  8016f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fb:	8a 00                	mov    (%eax),%al
  8016fd:	3c 39                	cmp    $0x39,%al
  8016ff:	7f 10                	jg     801711 <strtol+0xc2>
			dig = *s - '0';
  801701:	8b 45 08             	mov    0x8(%ebp),%eax
  801704:	8a 00                	mov    (%eax),%al
  801706:	0f be c0             	movsbl %al,%eax
  801709:	83 e8 30             	sub    $0x30,%eax
  80170c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80170f:	eb 42                	jmp    801753 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801711:	8b 45 08             	mov    0x8(%ebp),%eax
  801714:	8a 00                	mov    (%eax),%al
  801716:	3c 60                	cmp    $0x60,%al
  801718:	7e 19                	jle    801733 <strtol+0xe4>
  80171a:	8b 45 08             	mov    0x8(%ebp),%eax
  80171d:	8a 00                	mov    (%eax),%al
  80171f:	3c 7a                	cmp    $0x7a,%al
  801721:	7f 10                	jg     801733 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801723:	8b 45 08             	mov    0x8(%ebp),%eax
  801726:	8a 00                	mov    (%eax),%al
  801728:	0f be c0             	movsbl %al,%eax
  80172b:	83 e8 57             	sub    $0x57,%eax
  80172e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801731:	eb 20                	jmp    801753 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801733:	8b 45 08             	mov    0x8(%ebp),%eax
  801736:	8a 00                	mov    (%eax),%al
  801738:	3c 40                	cmp    $0x40,%al
  80173a:	7e 39                	jle    801775 <strtol+0x126>
  80173c:	8b 45 08             	mov    0x8(%ebp),%eax
  80173f:	8a 00                	mov    (%eax),%al
  801741:	3c 5a                	cmp    $0x5a,%al
  801743:	7f 30                	jg     801775 <strtol+0x126>
			dig = *s - 'A' + 10;
  801745:	8b 45 08             	mov    0x8(%ebp),%eax
  801748:	8a 00                	mov    (%eax),%al
  80174a:	0f be c0             	movsbl %al,%eax
  80174d:	83 e8 37             	sub    $0x37,%eax
  801750:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801753:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801756:	3b 45 10             	cmp    0x10(%ebp),%eax
  801759:	7d 19                	jge    801774 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80175b:	ff 45 08             	incl   0x8(%ebp)
  80175e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801761:	0f af 45 10          	imul   0x10(%ebp),%eax
  801765:	89 c2                	mov    %eax,%edx
  801767:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80176a:	01 d0                	add    %edx,%eax
  80176c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80176f:	e9 7b ff ff ff       	jmp    8016ef <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801774:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801775:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801779:	74 08                	je     801783 <strtol+0x134>
		*endptr = (char *) s;
  80177b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80177e:	8b 55 08             	mov    0x8(%ebp),%edx
  801781:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801783:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801787:	74 07                	je     801790 <strtol+0x141>
  801789:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80178c:	f7 d8                	neg    %eax
  80178e:	eb 03                	jmp    801793 <strtol+0x144>
  801790:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801793:	c9                   	leave  
  801794:	c3                   	ret    

00801795 <ltostr>:

void
ltostr(long value, char *str)
{
  801795:	55                   	push   %ebp
  801796:	89 e5                	mov    %esp,%ebp
  801798:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80179b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8017a2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017a9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017ad:	79 13                	jns    8017c2 <ltostr+0x2d>
	{
		neg = 1;
  8017af:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8017b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b9:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8017bc:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8017bf:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8017c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c5:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8017ca:	99                   	cltd   
  8017cb:	f7 f9                	idiv   %ecx
  8017cd:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8017d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017d3:	8d 50 01             	lea    0x1(%eax),%edx
  8017d6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017d9:	89 c2                	mov    %eax,%edx
  8017db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017de:	01 d0                	add    %edx,%eax
  8017e0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017e3:	83 c2 30             	add    $0x30,%edx
  8017e6:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017e8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017eb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017f0:	f7 e9                	imul   %ecx
  8017f2:	c1 fa 02             	sar    $0x2,%edx
  8017f5:	89 c8                	mov    %ecx,%eax
  8017f7:	c1 f8 1f             	sar    $0x1f,%eax
  8017fa:	29 c2                	sub    %eax,%edx
  8017fc:	89 d0                	mov    %edx,%eax
  8017fe:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801801:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801804:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801809:	f7 e9                	imul   %ecx
  80180b:	c1 fa 02             	sar    $0x2,%edx
  80180e:	89 c8                	mov    %ecx,%eax
  801810:	c1 f8 1f             	sar    $0x1f,%eax
  801813:	29 c2                	sub    %eax,%edx
  801815:	89 d0                	mov    %edx,%eax
  801817:	c1 e0 02             	shl    $0x2,%eax
  80181a:	01 d0                	add    %edx,%eax
  80181c:	01 c0                	add    %eax,%eax
  80181e:	29 c1                	sub    %eax,%ecx
  801820:	89 ca                	mov    %ecx,%edx
  801822:	85 d2                	test   %edx,%edx
  801824:	75 9c                	jne    8017c2 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801826:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80182d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801830:	48                   	dec    %eax
  801831:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801834:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801838:	74 3d                	je     801877 <ltostr+0xe2>
		start = 1 ;
  80183a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801841:	eb 34                	jmp    801877 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801843:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801846:	8b 45 0c             	mov    0xc(%ebp),%eax
  801849:	01 d0                	add    %edx,%eax
  80184b:	8a 00                	mov    (%eax),%al
  80184d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801850:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801853:	8b 45 0c             	mov    0xc(%ebp),%eax
  801856:	01 c2                	add    %eax,%edx
  801858:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80185b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80185e:	01 c8                	add    %ecx,%eax
  801860:	8a 00                	mov    (%eax),%al
  801862:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801864:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801867:	8b 45 0c             	mov    0xc(%ebp),%eax
  80186a:	01 c2                	add    %eax,%edx
  80186c:	8a 45 eb             	mov    -0x15(%ebp),%al
  80186f:	88 02                	mov    %al,(%edx)
		start++ ;
  801871:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801874:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801877:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80187a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80187d:	7c c4                	jl     801843 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80187f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801882:	8b 45 0c             	mov    0xc(%ebp),%eax
  801885:	01 d0                	add    %edx,%eax
  801887:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80188a:	90                   	nop
  80188b:	c9                   	leave  
  80188c:	c3                   	ret    

0080188d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80188d:	55                   	push   %ebp
  80188e:	89 e5                	mov    %esp,%ebp
  801890:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801893:	ff 75 08             	pushl  0x8(%ebp)
  801896:	e8 54 fa ff ff       	call   8012ef <strlen>
  80189b:	83 c4 04             	add    $0x4,%esp
  80189e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8018a1:	ff 75 0c             	pushl  0xc(%ebp)
  8018a4:	e8 46 fa ff ff       	call   8012ef <strlen>
  8018a9:	83 c4 04             	add    $0x4,%esp
  8018ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018af:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8018b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018bd:	eb 17                	jmp    8018d6 <strcconcat+0x49>
		final[s] = str1[s] ;
  8018bf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8018c5:	01 c2                	add    %eax,%edx
  8018c7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8018ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cd:	01 c8                	add    %ecx,%eax
  8018cf:	8a 00                	mov    (%eax),%al
  8018d1:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8018d3:	ff 45 fc             	incl   -0x4(%ebp)
  8018d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018d9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018dc:	7c e1                	jl     8018bf <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8018de:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8018e5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8018ec:	eb 1f                	jmp    80190d <strcconcat+0x80>
		final[s++] = str2[i] ;
  8018ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018f1:	8d 50 01             	lea    0x1(%eax),%edx
  8018f4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018f7:	89 c2                	mov    %eax,%edx
  8018f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8018fc:	01 c2                	add    %eax,%edx
  8018fe:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801901:	8b 45 0c             	mov    0xc(%ebp),%eax
  801904:	01 c8                	add    %ecx,%eax
  801906:	8a 00                	mov    (%eax),%al
  801908:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80190a:	ff 45 f8             	incl   -0x8(%ebp)
  80190d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801910:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801913:	7c d9                	jl     8018ee <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801915:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801918:	8b 45 10             	mov    0x10(%ebp),%eax
  80191b:	01 d0                	add    %edx,%eax
  80191d:	c6 00 00             	movb   $0x0,(%eax)
}
  801920:	90                   	nop
  801921:	c9                   	leave  
  801922:	c3                   	ret    

00801923 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801923:	55                   	push   %ebp
  801924:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801926:	8b 45 14             	mov    0x14(%ebp),%eax
  801929:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80192f:	8b 45 14             	mov    0x14(%ebp),%eax
  801932:	8b 00                	mov    (%eax),%eax
  801934:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80193b:	8b 45 10             	mov    0x10(%ebp),%eax
  80193e:	01 d0                	add    %edx,%eax
  801940:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801946:	eb 0c                	jmp    801954 <strsplit+0x31>
			*string++ = 0;
  801948:	8b 45 08             	mov    0x8(%ebp),%eax
  80194b:	8d 50 01             	lea    0x1(%eax),%edx
  80194e:	89 55 08             	mov    %edx,0x8(%ebp)
  801951:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801954:	8b 45 08             	mov    0x8(%ebp),%eax
  801957:	8a 00                	mov    (%eax),%al
  801959:	84 c0                	test   %al,%al
  80195b:	74 18                	je     801975 <strsplit+0x52>
  80195d:	8b 45 08             	mov    0x8(%ebp),%eax
  801960:	8a 00                	mov    (%eax),%al
  801962:	0f be c0             	movsbl %al,%eax
  801965:	50                   	push   %eax
  801966:	ff 75 0c             	pushl  0xc(%ebp)
  801969:	e8 13 fb ff ff       	call   801481 <strchr>
  80196e:	83 c4 08             	add    $0x8,%esp
  801971:	85 c0                	test   %eax,%eax
  801973:	75 d3                	jne    801948 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801975:	8b 45 08             	mov    0x8(%ebp),%eax
  801978:	8a 00                	mov    (%eax),%al
  80197a:	84 c0                	test   %al,%al
  80197c:	74 5a                	je     8019d8 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80197e:	8b 45 14             	mov    0x14(%ebp),%eax
  801981:	8b 00                	mov    (%eax),%eax
  801983:	83 f8 0f             	cmp    $0xf,%eax
  801986:	75 07                	jne    80198f <strsplit+0x6c>
		{
			return 0;
  801988:	b8 00 00 00 00       	mov    $0x0,%eax
  80198d:	eb 66                	jmp    8019f5 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80198f:	8b 45 14             	mov    0x14(%ebp),%eax
  801992:	8b 00                	mov    (%eax),%eax
  801994:	8d 48 01             	lea    0x1(%eax),%ecx
  801997:	8b 55 14             	mov    0x14(%ebp),%edx
  80199a:	89 0a                	mov    %ecx,(%edx)
  80199c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8019a6:	01 c2                	add    %eax,%edx
  8019a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ab:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019ad:	eb 03                	jmp    8019b2 <strsplit+0x8f>
			string++;
  8019af:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b5:	8a 00                	mov    (%eax),%al
  8019b7:	84 c0                	test   %al,%al
  8019b9:	74 8b                	je     801946 <strsplit+0x23>
  8019bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019be:	8a 00                	mov    (%eax),%al
  8019c0:	0f be c0             	movsbl %al,%eax
  8019c3:	50                   	push   %eax
  8019c4:	ff 75 0c             	pushl  0xc(%ebp)
  8019c7:	e8 b5 fa ff ff       	call   801481 <strchr>
  8019cc:	83 c4 08             	add    $0x8,%esp
  8019cf:	85 c0                	test   %eax,%eax
  8019d1:	74 dc                	je     8019af <strsplit+0x8c>
			string++;
	}
  8019d3:	e9 6e ff ff ff       	jmp    801946 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8019d8:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8019d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8019dc:	8b 00                	mov    (%eax),%eax
  8019de:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8019e8:	01 d0                	add    %edx,%eax
  8019ea:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019f0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019f5:	c9                   	leave  
  8019f6:	c3                   	ret    

008019f7 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  8019f7:	55                   	push   %ebp
  8019f8:	89 e5                	mov    %esp,%ebp
  8019fa:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  8019fd:	e8 3b 09 00 00       	call   80233d <sys_isUHeapPlacementStrategyFIRSTFIT>
  801a02:	85 c0                	test   %eax,%eax
  801a04:	0f 84 3a 01 00 00    	je     801b44 <malloc+0x14d>

		if(pl == 0){
  801a0a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a0f:	85 c0                	test   %eax,%eax
  801a11:	75 24                	jne    801a37 <malloc+0x40>
			for(int k = 0; k < Size; k++){
  801a13:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801a1a:	eb 11                	jmp    801a2d <malloc+0x36>
				arr[k] = -10000;
  801a1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a1f:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801a26:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801a2a:	ff 45 f4             	incl   -0xc(%ebp)
  801a2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a30:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801a35:	76 e5                	jbe    801a1c <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801a37:	c7 05 2c 30 80 00 01 	movl   $0x1,0x80302c
  801a3e:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801a41:	8b 45 08             	mov    0x8(%ebp),%eax
  801a44:	c1 e8 0c             	shr    $0xc,%eax
  801a47:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  801a4a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4d:	25 ff 0f 00 00       	and    $0xfff,%eax
  801a52:	85 c0                	test   %eax,%eax
  801a54:	74 03                	je     801a59 <malloc+0x62>
			x++;
  801a56:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  801a59:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  801a60:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801a67:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801a6e:	eb 66                	jmp    801ad6 <malloc+0xdf>
			if( arr[k] == -10000){
  801a70:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a73:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801a7a:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801a7f:	75 52                	jne    801ad3 <malloc+0xdc>
				uint32 w = 0 ;
  801a81:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  801a88:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a8b:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  801a8e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801a91:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801a94:	eb 09                	jmp    801a9f <malloc+0xa8>
  801a96:	ff 45 e0             	incl   -0x20(%ebp)
  801a99:	ff 45 dc             	incl   -0x24(%ebp)
  801a9c:	ff 45 e4             	incl   -0x1c(%ebp)
  801a9f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801aa2:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801aa7:	77 19                	ja     801ac2 <malloc+0xcb>
  801aa9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801aac:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801ab3:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801ab8:	75 08                	jne    801ac2 <malloc+0xcb>
  801aba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801abd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ac0:	72 d4                	jb     801a96 <malloc+0x9f>
				if(w >= x){
  801ac2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ac5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ac8:	72 09                	jb     801ad3 <malloc+0xdc>
					p = 1 ;
  801aca:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  801ad1:	eb 0d                	jmp    801ae0 <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801ad3:	ff 45 e4             	incl   -0x1c(%ebp)
  801ad6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ad9:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801ade:	76 90                	jbe    801a70 <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  801ae0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801ae4:	75 0a                	jne    801af0 <malloc+0xf9>
  801ae6:	b8 00 00 00 00       	mov    $0x0,%eax
  801aeb:	e9 ca 01 00 00       	jmp    801cba <malloc+0x2c3>
		int q = idx;
  801af0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801af3:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  801af6:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801afd:	eb 16                	jmp    801b15 <malloc+0x11e>
			arr[q++] = x;
  801aff:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801b02:	8d 50 01             	lea    0x1(%eax),%edx
  801b05:	89 55 d8             	mov    %edx,-0x28(%ebp)
  801b08:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801b0b:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  801b12:	ff 45 d4             	incl   -0x2c(%ebp)
  801b15:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801b18:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b1b:	72 e2                	jb     801aff <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801b1d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b20:	05 00 00 08 00       	add    $0x80000,%eax
  801b25:	c1 e0 0c             	shl    $0xc,%eax
  801b28:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  801b2b:	83 ec 08             	sub    $0x8,%esp
  801b2e:	ff 75 f0             	pushl  -0x10(%ebp)
  801b31:	ff 75 ac             	pushl  -0x54(%ebp)
  801b34:	e8 9b 04 00 00       	call   801fd4 <sys_allocateMem>
  801b39:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801b3c:	8b 45 ac             	mov    -0x54(%ebp),%eax
  801b3f:	e9 76 01 00 00       	jmp    801cba <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  801b44:	e8 25 08 00 00       	call   80236e <sys_isUHeapPlacementStrategyBESTFIT>
  801b49:	85 c0                	test   %eax,%eax
  801b4b:	0f 84 64 01 00 00    	je     801cb5 <malloc+0x2be>
		if(pl == 0){
  801b51:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b56:	85 c0                	test   %eax,%eax
  801b58:	75 24                	jne    801b7e <malloc+0x187>
			for(int k = 0; k < Size; k++){
  801b5a:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  801b61:	eb 11                	jmp    801b74 <malloc+0x17d>
				arr[k] = -10000;
  801b63:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b66:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801b6d:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801b71:	ff 45 d0             	incl   -0x30(%ebp)
  801b74:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b77:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801b7c:	76 e5                	jbe    801b63 <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801b7e:	c7 05 2c 30 80 00 01 	movl   $0x1,0x80302c
  801b85:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801b88:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8b:	c1 e8 0c             	shr    $0xc,%eax
  801b8e:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  801b91:	8b 45 08             	mov    0x8(%ebp),%eax
  801b94:	25 ff 0f 00 00       	and    $0xfff,%eax
  801b99:	85 c0                	test   %eax,%eax
  801b9b:	74 03                	je     801ba0 <malloc+0x1a9>
			x++;
  801b9d:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  801ba0:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  801ba7:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  801bae:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  801bb5:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  801bbc:	e9 88 00 00 00       	jmp    801c49 <malloc+0x252>
			if(arr[k] == -10000){
  801bc1:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801bc4:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801bcb:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801bd0:	75 64                	jne    801c36 <malloc+0x23f>
				uint32 w = 0 , i;
  801bd2:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  801bd9:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801bdc:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  801bdf:	eb 06                	jmp    801be7 <malloc+0x1f0>
  801be1:	ff 45 b8             	incl   -0x48(%ebp)
  801be4:	ff 45 b4             	incl   -0x4c(%ebp)
  801be7:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  801bee:	77 11                	ja     801c01 <malloc+0x20a>
  801bf0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801bf3:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801bfa:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801bff:	74 e0                	je     801be1 <malloc+0x1ea>
				if(w <q && w >= x){
  801c01:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801c04:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  801c07:	73 24                	jae    801c2d <malloc+0x236>
  801c09:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801c0c:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801c0f:	72 1c                	jb     801c2d <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  801c11:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801c14:	89 45 c8             	mov    %eax,-0x38(%ebp)
  801c17:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  801c1e:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801c21:	89 45 c0             	mov    %eax,-0x40(%ebp)
  801c24:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801c27:	48                   	dec    %eax
  801c28:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801c2b:	eb 19                	jmp    801c46 <malloc+0x24f>
				}
				else {
					k = i - 1;
  801c2d:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801c30:	48                   	dec    %eax
  801c31:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801c34:	eb 10                	jmp    801c46 <malloc+0x24f>
				}
			} else {
				k += arr[k];
  801c36:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801c39:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801c40:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  801c43:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  801c46:	ff 45 bc             	incl   -0x44(%ebp)
  801c49:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801c4c:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801c51:	0f 86 6a ff ff ff    	jbe    801bc1 <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  801c57:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  801c5b:	75 07                	jne    801c64 <malloc+0x26d>
  801c5d:	b8 00 00 00 00       	mov    $0x0,%eax
  801c62:	eb 56                	jmp    801cba <malloc+0x2c3>
	    q = idx;
  801c64:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801c67:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  801c6a:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  801c71:	eb 16                	jmp    801c89 <malloc+0x292>
			arr[q++] = x;
  801c73:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801c76:	8d 50 01             	lea    0x1(%eax),%edx
  801c79:	89 55 c8             	mov    %edx,-0x38(%ebp)
  801c7c:	8b 55 cc             	mov    -0x34(%ebp),%edx
  801c7f:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  801c86:	ff 45 b0             	incl   -0x50(%ebp)
  801c89:	8b 45 b0             	mov    -0x50(%ebp),%eax
  801c8c:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801c8f:	72 e2                	jb     801c73 <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801c91:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801c94:	05 00 00 08 00       	add    $0x80000,%eax
  801c99:	c1 e0 0c             	shl    $0xc,%eax
  801c9c:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  801c9f:	83 ec 08             	sub    $0x8,%esp
  801ca2:	ff 75 cc             	pushl  -0x34(%ebp)
  801ca5:	ff 75 a8             	pushl  -0x58(%ebp)
  801ca8:	e8 27 03 00 00       	call   801fd4 <sys_allocateMem>
  801cad:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801cb0:	8b 45 a8             	mov    -0x58(%ebp),%eax
  801cb3:	eb 05                	jmp    801cba <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  801cb5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cba:	c9                   	leave  
  801cbb:	c3                   	ret    

00801cbc <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801cbc:	55                   	push   %ebp
  801cbd:	89 e5                	mov    %esp,%ebp
  801cbf:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  801cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801cc8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801ccb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801cd0:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  801cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd6:	05 00 00 00 80       	add    $0x80000000,%eax
  801cdb:	c1 e8 0c             	shr    $0xc,%eax
  801cde:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801ce5:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801ce8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801cef:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf2:	05 00 00 00 80       	add    $0x80000000,%eax
  801cf7:	c1 e8 0c             	shr    $0xc,%eax
  801cfa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801cfd:	eb 14                	jmp    801d13 <free+0x57>
		arr[j] = -10000;
  801cff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d02:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801d09:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801d0d:	ff 45 f4             	incl   -0xc(%ebp)
  801d10:	ff 45 f0             	incl   -0x10(%ebp)
  801d13:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d16:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801d19:	72 e4                	jb     801cff <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  801d1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1e:	83 ec 08             	sub    $0x8,%esp
  801d21:	ff 75 e8             	pushl  -0x18(%ebp)
  801d24:	50                   	push   %eax
  801d25:	e8 8e 02 00 00       	call   801fb8 <sys_freeMem>
  801d2a:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  801d2d:	90                   	nop
  801d2e:	c9                   	leave  
  801d2f:	c3                   	ret    

00801d30 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801d30:	55                   	push   %ebp
  801d31:	89 e5                	mov    %esp,%ebp
  801d33:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d36:	83 ec 04             	sub    $0x4,%esp
  801d39:	68 e4 2d 80 00       	push   $0x802de4
  801d3e:	68 9e 00 00 00       	push   $0x9e
  801d43:	68 07 2e 80 00       	push   $0x802e07
  801d48:	e8 63 ea ff ff       	call   8007b0 <_panic>

00801d4d <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801d4d:	55                   	push   %ebp
  801d4e:	89 e5                	mov    %esp,%ebp
  801d50:	83 ec 18             	sub    $0x18,%esp
  801d53:	8b 45 10             	mov    0x10(%ebp),%eax
  801d56:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801d59:	83 ec 04             	sub    $0x4,%esp
  801d5c:	68 e4 2d 80 00       	push   $0x802de4
  801d61:	68 a9 00 00 00       	push   $0xa9
  801d66:	68 07 2e 80 00       	push   $0x802e07
  801d6b:	e8 40 ea ff ff       	call   8007b0 <_panic>

00801d70 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801d70:	55                   	push   %ebp
  801d71:	89 e5                	mov    %esp,%ebp
  801d73:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d76:	83 ec 04             	sub    $0x4,%esp
  801d79:	68 e4 2d 80 00       	push   $0x802de4
  801d7e:	68 af 00 00 00       	push   $0xaf
  801d83:	68 07 2e 80 00       	push   $0x802e07
  801d88:	e8 23 ea ff ff       	call   8007b0 <_panic>

00801d8d <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801d8d:	55                   	push   %ebp
  801d8e:	89 e5                	mov    %esp,%ebp
  801d90:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d93:	83 ec 04             	sub    $0x4,%esp
  801d96:	68 e4 2d 80 00       	push   $0x802de4
  801d9b:	68 b5 00 00 00       	push   $0xb5
  801da0:	68 07 2e 80 00       	push   $0x802e07
  801da5:	e8 06 ea ff ff       	call   8007b0 <_panic>

00801daa <expand>:
}

void expand(uint32 newSize)
{
  801daa:	55                   	push   %ebp
  801dab:	89 e5                	mov    %esp,%ebp
  801dad:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801db0:	83 ec 04             	sub    $0x4,%esp
  801db3:	68 e4 2d 80 00       	push   $0x802de4
  801db8:	68 ba 00 00 00       	push   $0xba
  801dbd:	68 07 2e 80 00       	push   $0x802e07
  801dc2:	e8 e9 e9 ff ff       	call   8007b0 <_panic>

00801dc7 <shrink>:
}
void shrink(uint32 newSize)
{
  801dc7:	55                   	push   %ebp
  801dc8:	89 e5                	mov    %esp,%ebp
  801dca:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801dcd:	83 ec 04             	sub    $0x4,%esp
  801dd0:	68 e4 2d 80 00       	push   $0x802de4
  801dd5:	68 be 00 00 00       	push   $0xbe
  801dda:	68 07 2e 80 00       	push   $0x802e07
  801ddf:	e8 cc e9 ff ff       	call   8007b0 <_panic>

00801de4 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801de4:	55                   	push   %ebp
  801de5:	89 e5                	mov    %esp,%ebp
  801de7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801dea:	83 ec 04             	sub    $0x4,%esp
  801ded:	68 e4 2d 80 00       	push   $0x802de4
  801df2:	68 c3 00 00 00       	push   $0xc3
  801df7:	68 07 2e 80 00       	push   $0x802e07
  801dfc:	e8 af e9 ff ff       	call   8007b0 <_panic>

00801e01 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801e01:	55                   	push   %ebp
  801e02:	89 e5                	mov    %esp,%ebp
  801e04:	57                   	push   %edi
  801e05:	56                   	push   %esi
  801e06:	53                   	push   %ebx
  801e07:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e10:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e13:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e16:	8b 7d 18             	mov    0x18(%ebp),%edi
  801e19:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801e1c:	cd 30                	int    $0x30
  801e1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801e21:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801e24:	83 c4 10             	add    $0x10,%esp
  801e27:	5b                   	pop    %ebx
  801e28:	5e                   	pop    %esi
  801e29:	5f                   	pop    %edi
  801e2a:	5d                   	pop    %ebp
  801e2b:	c3                   	ret    

00801e2c <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801e2c:	55                   	push   %ebp
  801e2d:	89 e5                	mov    %esp,%ebp
  801e2f:	83 ec 04             	sub    $0x4,%esp
  801e32:	8b 45 10             	mov    0x10(%ebp),%eax
  801e35:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801e38:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 00                	push   $0x0
  801e43:	52                   	push   %edx
  801e44:	ff 75 0c             	pushl  0xc(%ebp)
  801e47:	50                   	push   %eax
  801e48:	6a 00                	push   $0x0
  801e4a:	e8 b2 ff ff ff       	call   801e01 <syscall>
  801e4f:	83 c4 18             	add    $0x18,%esp
}
  801e52:	90                   	nop
  801e53:	c9                   	leave  
  801e54:	c3                   	ret    

00801e55 <sys_cgetc>:

int
sys_cgetc(void)
{
  801e55:	55                   	push   %ebp
  801e56:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801e58:	6a 00                	push   $0x0
  801e5a:	6a 00                	push   $0x0
  801e5c:	6a 00                	push   $0x0
  801e5e:	6a 00                	push   $0x0
  801e60:	6a 00                	push   $0x0
  801e62:	6a 01                	push   $0x1
  801e64:	e8 98 ff ff ff       	call   801e01 <syscall>
  801e69:	83 c4 18             	add    $0x18,%esp
}
  801e6c:	c9                   	leave  
  801e6d:	c3                   	ret    

00801e6e <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801e6e:	55                   	push   %ebp
  801e6f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801e71:	8b 45 08             	mov    0x8(%ebp),%eax
  801e74:	6a 00                	push   $0x0
  801e76:	6a 00                	push   $0x0
  801e78:	6a 00                	push   $0x0
  801e7a:	6a 00                	push   $0x0
  801e7c:	50                   	push   %eax
  801e7d:	6a 05                	push   $0x5
  801e7f:	e8 7d ff ff ff       	call   801e01 <syscall>
  801e84:	83 c4 18             	add    $0x18,%esp
}
  801e87:	c9                   	leave  
  801e88:	c3                   	ret    

00801e89 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801e89:	55                   	push   %ebp
  801e8a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801e8c:	6a 00                	push   $0x0
  801e8e:	6a 00                	push   $0x0
  801e90:	6a 00                	push   $0x0
  801e92:	6a 00                	push   $0x0
  801e94:	6a 00                	push   $0x0
  801e96:	6a 02                	push   $0x2
  801e98:	e8 64 ff ff ff       	call   801e01 <syscall>
  801e9d:	83 c4 18             	add    $0x18,%esp
}
  801ea0:	c9                   	leave  
  801ea1:	c3                   	ret    

00801ea2 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ea2:	55                   	push   %ebp
  801ea3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801ea5:	6a 00                	push   $0x0
  801ea7:	6a 00                	push   $0x0
  801ea9:	6a 00                	push   $0x0
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 03                	push   $0x3
  801eb1:	e8 4b ff ff ff       	call   801e01 <syscall>
  801eb6:	83 c4 18             	add    $0x18,%esp
}
  801eb9:	c9                   	leave  
  801eba:	c3                   	ret    

00801ebb <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801ebb:	55                   	push   %ebp
  801ebc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 00                	push   $0x0
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 04                	push   $0x4
  801eca:	e8 32 ff ff ff       	call   801e01 <syscall>
  801ecf:	83 c4 18             	add    $0x18,%esp
}
  801ed2:	c9                   	leave  
  801ed3:	c3                   	ret    

00801ed4 <sys_env_exit>:


void sys_env_exit(void)
{
  801ed4:	55                   	push   %ebp
  801ed5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801ed7:	6a 00                	push   $0x0
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 06                	push   $0x6
  801ee3:	e8 19 ff ff ff       	call   801e01 <syscall>
  801ee8:	83 c4 18             	add    $0x18,%esp
}
  801eeb:	90                   	nop
  801eec:	c9                   	leave  
  801eed:	c3                   	ret    

00801eee <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801eee:	55                   	push   %ebp
  801eef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801ef1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ef4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef7:	6a 00                	push   $0x0
  801ef9:	6a 00                	push   $0x0
  801efb:	6a 00                	push   $0x0
  801efd:	52                   	push   %edx
  801efe:	50                   	push   %eax
  801eff:	6a 07                	push   $0x7
  801f01:	e8 fb fe ff ff       	call   801e01 <syscall>
  801f06:	83 c4 18             	add    $0x18,%esp
}
  801f09:	c9                   	leave  
  801f0a:	c3                   	ret    

00801f0b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801f0b:	55                   	push   %ebp
  801f0c:	89 e5                	mov    %esp,%ebp
  801f0e:	56                   	push   %esi
  801f0f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801f10:	8b 75 18             	mov    0x18(%ebp),%esi
  801f13:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f16:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f19:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f1f:	56                   	push   %esi
  801f20:	53                   	push   %ebx
  801f21:	51                   	push   %ecx
  801f22:	52                   	push   %edx
  801f23:	50                   	push   %eax
  801f24:	6a 08                	push   $0x8
  801f26:	e8 d6 fe ff ff       	call   801e01 <syscall>
  801f2b:	83 c4 18             	add    $0x18,%esp
}
  801f2e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801f31:	5b                   	pop    %ebx
  801f32:	5e                   	pop    %esi
  801f33:	5d                   	pop    %ebp
  801f34:	c3                   	ret    

00801f35 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801f35:	55                   	push   %ebp
  801f36:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801f38:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f3e:	6a 00                	push   $0x0
  801f40:	6a 00                	push   $0x0
  801f42:	6a 00                	push   $0x0
  801f44:	52                   	push   %edx
  801f45:	50                   	push   %eax
  801f46:	6a 09                	push   $0x9
  801f48:	e8 b4 fe ff ff       	call   801e01 <syscall>
  801f4d:	83 c4 18             	add    $0x18,%esp
}
  801f50:	c9                   	leave  
  801f51:	c3                   	ret    

00801f52 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801f52:	55                   	push   %ebp
  801f53:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801f55:	6a 00                	push   $0x0
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	ff 75 0c             	pushl  0xc(%ebp)
  801f5e:	ff 75 08             	pushl  0x8(%ebp)
  801f61:	6a 0a                	push   $0xa
  801f63:	e8 99 fe ff ff       	call   801e01 <syscall>
  801f68:	83 c4 18             	add    $0x18,%esp
}
  801f6b:	c9                   	leave  
  801f6c:	c3                   	ret    

00801f6d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801f6d:	55                   	push   %ebp
  801f6e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801f70:	6a 00                	push   $0x0
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	6a 00                	push   $0x0
  801f78:	6a 00                	push   $0x0
  801f7a:	6a 0b                	push   $0xb
  801f7c:	e8 80 fe ff ff       	call   801e01 <syscall>
  801f81:	83 c4 18             	add    $0x18,%esp
}
  801f84:	c9                   	leave  
  801f85:	c3                   	ret    

00801f86 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801f86:	55                   	push   %ebp
  801f87:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801f89:	6a 00                	push   $0x0
  801f8b:	6a 00                	push   $0x0
  801f8d:	6a 00                	push   $0x0
  801f8f:	6a 00                	push   $0x0
  801f91:	6a 00                	push   $0x0
  801f93:	6a 0c                	push   $0xc
  801f95:	e8 67 fe ff ff       	call   801e01 <syscall>
  801f9a:	83 c4 18             	add    $0x18,%esp
}
  801f9d:	c9                   	leave  
  801f9e:	c3                   	ret    

00801f9f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801f9f:	55                   	push   %ebp
  801fa0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801fa2:	6a 00                	push   $0x0
  801fa4:	6a 00                	push   $0x0
  801fa6:	6a 00                	push   $0x0
  801fa8:	6a 00                	push   $0x0
  801faa:	6a 00                	push   $0x0
  801fac:	6a 0d                	push   $0xd
  801fae:	e8 4e fe ff ff       	call   801e01 <syscall>
  801fb3:	83 c4 18             	add    $0x18,%esp
}
  801fb6:	c9                   	leave  
  801fb7:	c3                   	ret    

00801fb8 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801fb8:	55                   	push   %ebp
  801fb9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	ff 75 0c             	pushl  0xc(%ebp)
  801fc4:	ff 75 08             	pushl  0x8(%ebp)
  801fc7:	6a 11                	push   $0x11
  801fc9:	e8 33 fe ff ff       	call   801e01 <syscall>
  801fce:	83 c4 18             	add    $0x18,%esp
	return;
  801fd1:	90                   	nop
}
  801fd2:	c9                   	leave  
  801fd3:	c3                   	ret    

00801fd4 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801fd4:	55                   	push   %ebp
  801fd5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801fd7:	6a 00                	push   $0x0
  801fd9:	6a 00                	push   $0x0
  801fdb:	6a 00                	push   $0x0
  801fdd:	ff 75 0c             	pushl  0xc(%ebp)
  801fe0:	ff 75 08             	pushl  0x8(%ebp)
  801fe3:	6a 12                	push   $0x12
  801fe5:	e8 17 fe ff ff       	call   801e01 <syscall>
  801fea:	83 c4 18             	add    $0x18,%esp
	return ;
  801fed:	90                   	nop
}
  801fee:	c9                   	leave  
  801fef:	c3                   	ret    

00801ff0 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801ff0:	55                   	push   %ebp
  801ff1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 00                	push   $0x0
  801ff7:	6a 00                	push   $0x0
  801ff9:	6a 00                	push   $0x0
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 0e                	push   $0xe
  801fff:	e8 fd fd ff ff       	call   801e01 <syscall>
  802004:	83 c4 18             	add    $0x18,%esp
}
  802007:	c9                   	leave  
  802008:	c3                   	ret    

00802009 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802009:	55                   	push   %ebp
  80200a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80200c:	6a 00                	push   $0x0
  80200e:	6a 00                	push   $0x0
  802010:	6a 00                	push   $0x0
  802012:	6a 00                	push   $0x0
  802014:	ff 75 08             	pushl  0x8(%ebp)
  802017:	6a 0f                	push   $0xf
  802019:	e8 e3 fd ff ff       	call   801e01 <syscall>
  80201e:	83 c4 18             	add    $0x18,%esp
}
  802021:	c9                   	leave  
  802022:	c3                   	ret    

00802023 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802023:	55                   	push   %ebp
  802024:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802026:	6a 00                	push   $0x0
  802028:	6a 00                	push   $0x0
  80202a:	6a 00                	push   $0x0
  80202c:	6a 00                	push   $0x0
  80202e:	6a 00                	push   $0x0
  802030:	6a 10                	push   $0x10
  802032:	e8 ca fd ff ff       	call   801e01 <syscall>
  802037:	83 c4 18             	add    $0x18,%esp
}
  80203a:	90                   	nop
  80203b:	c9                   	leave  
  80203c:	c3                   	ret    

0080203d <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80203d:	55                   	push   %ebp
  80203e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802040:	6a 00                	push   $0x0
  802042:	6a 00                	push   $0x0
  802044:	6a 00                	push   $0x0
  802046:	6a 00                	push   $0x0
  802048:	6a 00                	push   $0x0
  80204a:	6a 14                	push   $0x14
  80204c:	e8 b0 fd ff ff       	call   801e01 <syscall>
  802051:	83 c4 18             	add    $0x18,%esp
}
  802054:	90                   	nop
  802055:	c9                   	leave  
  802056:	c3                   	ret    

00802057 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802057:	55                   	push   %ebp
  802058:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80205a:	6a 00                	push   $0x0
  80205c:	6a 00                	push   $0x0
  80205e:	6a 00                	push   $0x0
  802060:	6a 00                	push   $0x0
  802062:	6a 00                	push   $0x0
  802064:	6a 15                	push   $0x15
  802066:	e8 96 fd ff ff       	call   801e01 <syscall>
  80206b:	83 c4 18             	add    $0x18,%esp
}
  80206e:	90                   	nop
  80206f:	c9                   	leave  
  802070:	c3                   	ret    

00802071 <sys_cputc>:


void
sys_cputc(const char c)
{
  802071:	55                   	push   %ebp
  802072:	89 e5                	mov    %esp,%ebp
  802074:	83 ec 04             	sub    $0x4,%esp
  802077:	8b 45 08             	mov    0x8(%ebp),%eax
  80207a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80207d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802081:	6a 00                	push   $0x0
  802083:	6a 00                	push   $0x0
  802085:	6a 00                	push   $0x0
  802087:	6a 00                	push   $0x0
  802089:	50                   	push   %eax
  80208a:	6a 16                	push   $0x16
  80208c:	e8 70 fd ff ff       	call   801e01 <syscall>
  802091:	83 c4 18             	add    $0x18,%esp
}
  802094:	90                   	nop
  802095:	c9                   	leave  
  802096:	c3                   	ret    

00802097 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802097:	55                   	push   %ebp
  802098:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80209a:	6a 00                	push   $0x0
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 00                	push   $0x0
  8020a4:	6a 17                	push   $0x17
  8020a6:	e8 56 fd ff ff       	call   801e01 <syscall>
  8020ab:	83 c4 18             	add    $0x18,%esp
}
  8020ae:	90                   	nop
  8020af:	c9                   	leave  
  8020b0:	c3                   	ret    

008020b1 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8020b1:	55                   	push   %ebp
  8020b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8020b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b7:	6a 00                	push   $0x0
  8020b9:	6a 00                	push   $0x0
  8020bb:	6a 00                	push   $0x0
  8020bd:	ff 75 0c             	pushl  0xc(%ebp)
  8020c0:	50                   	push   %eax
  8020c1:	6a 18                	push   $0x18
  8020c3:	e8 39 fd ff ff       	call   801e01 <syscall>
  8020c8:	83 c4 18             	add    $0x18,%esp
}
  8020cb:	c9                   	leave  
  8020cc:	c3                   	ret    

008020cd <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8020cd:	55                   	push   %ebp
  8020ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020d0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8020d6:	6a 00                	push   $0x0
  8020d8:	6a 00                	push   $0x0
  8020da:	6a 00                	push   $0x0
  8020dc:	52                   	push   %edx
  8020dd:	50                   	push   %eax
  8020de:	6a 1b                	push   $0x1b
  8020e0:	e8 1c fd ff ff       	call   801e01 <syscall>
  8020e5:	83 c4 18             	add    $0x18,%esp
}
  8020e8:	c9                   	leave  
  8020e9:	c3                   	ret    

008020ea <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8020ea:	55                   	push   %ebp
  8020eb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f3:	6a 00                	push   $0x0
  8020f5:	6a 00                	push   $0x0
  8020f7:	6a 00                	push   $0x0
  8020f9:	52                   	push   %edx
  8020fa:	50                   	push   %eax
  8020fb:	6a 19                	push   $0x19
  8020fd:	e8 ff fc ff ff       	call   801e01 <syscall>
  802102:	83 c4 18             	add    $0x18,%esp
}
  802105:	90                   	nop
  802106:	c9                   	leave  
  802107:	c3                   	ret    

00802108 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802108:	55                   	push   %ebp
  802109:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80210b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80210e:	8b 45 08             	mov    0x8(%ebp),%eax
  802111:	6a 00                	push   $0x0
  802113:	6a 00                	push   $0x0
  802115:	6a 00                	push   $0x0
  802117:	52                   	push   %edx
  802118:	50                   	push   %eax
  802119:	6a 1a                	push   $0x1a
  80211b:	e8 e1 fc ff ff       	call   801e01 <syscall>
  802120:	83 c4 18             	add    $0x18,%esp
}
  802123:	90                   	nop
  802124:	c9                   	leave  
  802125:	c3                   	ret    

00802126 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802126:	55                   	push   %ebp
  802127:	89 e5                	mov    %esp,%ebp
  802129:	83 ec 04             	sub    $0x4,%esp
  80212c:	8b 45 10             	mov    0x10(%ebp),%eax
  80212f:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802132:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802135:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802139:	8b 45 08             	mov    0x8(%ebp),%eax
  80213c:	6a 00                	push   $0x0
  80213e:	51                   	push   %ecx
  80213f:	52                   	push   %edx
  802140:	ff 75 0c             	pushl  0xc(%ebp)
  802143:	50                   	push   %eax
  802144:	6a 1c                	push   $0x1c
  802146:	e8 b6 fc ff ff       	call   801e01 <syscall>
  80214b:	83 c4 18             	add    $0x18,%esp
}
  80214e:	c9                   	leave  
  80214f:	c3                   	ret    

00802150 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802150:	55                   	push   %ebp
  802151:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802153:	8b 55 0c             	mov    0xc(%ebp),%edx
  802156:	8b 45 08             	mov    0x8(%ebp),%eax
  802159:	6a 00                	push   $0x0
  80215b:	6a 00                	push   $0x0
  80215d:	6a 00                	push   $0x0
  80215f:	52                   	push   %edx
  802160:	50                   	push   %eax
  802161:	6a 1d                	push   $0x1d
  802163:	e8 99 fc ff ff       	call   801e01 <syscall>
  802168:	83 c4 18             	add    $0x18,%esp
}
  80216b:	c9                   	leave  
  80216c:	c3                   	ret    

0080216d <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80216d:	55                   	push   %ebp
  80216e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802170:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802173:	8b 55 0c             	mov    0xc(%ebp),%edx
  802176:	8b 45 08             	mov    0x8(%ebp),%eax
  802179:	6a 00                	push   $0x0
  80217b:	6a 00                	push   $0x0
  80217d:	51                   	push   %ecx
  80217e:	52                   	push   %edx
  80217f:	50                   	push   %eax
  802180:	6a 1e                	push   $0x1e
  802182:	e8 7a fc ff ff       	call   801e01 <syscall>
  802187:	83 c4 18             	add    $0x18,%esp
}
  80218a:	c9                   	leave  
  80218b:	c3                   	ret    

0080218c <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80218c:	55                   	push   %ebp
  80218d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80218f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802192:	8b 45 08             	mov    0x8(%ebp),%eax
  802195:	6a 00                	push   $0x0
  802197:	6a 00                	push   $0x0
  802199:	6a 00                	push   $0x0
  80219b:	52                   	push   %edx
  80219c:	50                   	push   %eax
  80219d:	6a 1f                	push   $0x1f
  80219f:	e8 5d fc ff ff       	call   801e01 <syscall>
  8021a4:	83 c4 18             	add    $0x18,%esp
}
  8021a7:	c9                   	leave  
  8021a8:	c3                   	ret    

008021a9 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8021a9:	55                   	push   %ebp
  8021aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8021ac:	6a 00                	push   $0x0
  8021ae:	6a 00                	push   $0x0
  8021b0:	6a 00                	push   $0x0
  8021b2:	6a 00                	push   $0x0
  8021b4:	6a 00                	push   $0x0
  8021b6:	6a 20                	push   $0x20
  8021b8:	e8 44 fc ff ff       	call   801e01 <syscall>
  8021bd:	83 c4 18             	add    $0x18,%esp
}
  8021c0:	c9                   	leave  
  8021c1:	c3                   	ret    

008021c2 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8021c2:	55                   	push   %ebp
  8021c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8021c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c8:	6a 00                	push   $0x0
  8021ca:	ff 75 14             	pushl  0x14(%ebp)
  8021cd:	ff 75 10             	pushl  0x10(%ebp)
  8021d0:	ff 75 0c             	pushl  0xc(%ebp)
  8021d3:	50                   	push   %eax
  8021d4:	6a 21                	push   $0x21
  8021d6:	e8 26 fc ff ff       	call   801e01 <syscall>
  8021db:	83 c4 18             	add    $0x18,%esp
}
  8021de:	c9                   	leave  
  8021df:	c3                   	ret    

008021e0 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8021e0:	55                   	push   %ebp
  8021e1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8021e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8021e6:	6a 00                	push   $0x0
  8021e8:	6a 00                	push   $0x0
  8021ea:	6a 00                	push   $0x0
  8021ec:	6a 00                	push   $0x0
  8021ee:	50                   	push   %eax
  8021ef:	6a 22                	push   $0x22
  8021f1:	e8 0b fc ff ff       	call   801e01 <syscall>
  8021f6:	83 c4 18             	add    $0x18,%esp
}
  8021f9:	90                   	nop
  8021fa:	c9                   	leave  
  8021fb:	c3                   	ret    

008021fc <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8021fc:	55                   	push   %ebp
  8021fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8021ff:	8b 45 08             	mov    0x8(%ebp),%eax
  802202:	6a 00                	push   $0x0
  802204:	6a 00                	push   $0x0
  802206:	6a 00                	push   $0x0
  802208:	6a 00                	push   $0x0
  80220a:	50                   	push   %eax
  80220b:	6a 23                	push   $0x23
  80220d:	e8 ef fb ff ff       	call   801e01 <syscall>
  802212:	83 c4 18             	add    $0x18,%esp
}
  802215:	90                   	nop
  802216:	c9                   	leave  
  802217:	c3                   	ret    

00802218 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802218:	55                   	push   %ebp
  802219:	89 e5                	mov    %esp,%ebp
  80221b:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80221e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802221:	8d 50 04             	lea    0x4(%eax),%edx
  802224:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802227:	6a 00                	push   $0x0
  802229:	6a 00                	push   $0x0
  80222b:	6a 00                	push   $0x0
  80222d:	52                   	push   %edx
  80222e:	50                   	push   %eax
  80222f:	6a 24                	push   $0x24
  802231:	e8 cb fb ff ff       	call   801e01 <syscall>
  802236:	83 c4 18             	add    $0x18,%esp
	return result;
  802239:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80223c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80223f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802242:	89 01                	mov    %eax,(%ecx)
  802244:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802247:	8b 45 08             	mov    0x8(%ebp),%eax
  80224a:	c9                   	leave  
  80224b:	c2 04 00             	ret    $0x4

0080224e <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80224e:	55                   	push   %ebp
  80224f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802251:	6a 00                	push   $0x0
  802253:	6a 00                	push   $0x0
  802255:	ff 75 10             	pushl  0x10(%ebp)
  802258:	ff 75 0c             	pushl  0xc(%ebp)
  80225b:	ff 75 08             	pushl  0x8(%ebp)
  80225e:	6a 13                	push   $0x13
  802260:	e8 9c fb ff ff       	call   801e01 <syscall>
  802265:	83 c4 18             	add    $0x18,%esp
	return ;
  802268:	90                   	nop
}
  802269:	c9                   	leave  
  80226a:	c3                   	ret    

0080226b <sys_rcr2>:
uint32 sys_rcr2()
{
  80226b:	55                   	push   %ebp
  80226c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80226e:	6a 00                	push   $0x0
  802270:	6a 00                	push   $0x0
  802272:	6a 00                	push   $0x0
  802274:	6a 00                	push   $0x0
  802276:	6a 00                	push   $0x0
  802278:	6a 25                	push   $0x25
  80227a:	e8 82 fb ff ff       	call   801e01 <syscall>
  80227f:	83 c4 18             	add    $0x18,%esp
}
  802282:	c9                   	leave  
  802283:	c3                   	ret    

00802284 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802284:	55                   	push   %ebp
  802285:	89 e5                	mov    %esp,%ebp
  802287:	83 ec 04             	sub    $0x4,%esp
  80228a:	8b 45 08             	mov    0x8(%ebp),%eax
  80228d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802290:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802294:	6a 00                	push   $0x0
  802296:	6a 00                	push   $0x0
  802298:	6a 00                	push   $0x0
  80229a:	6a 00                	push   $0x0
  80229c:	50                   	push   %eax
  80229d:	6a 26                	push   $0x26
  80229f:	e8 5d fb ff ff       	call   801e01 <syscall>
  8022a4:	83 c4 18             	add    $0x18,%esp
	return ;
  8022a7:	90                   	nop
}
  8022a8:	c9                   	leave  
  8022a9:	c3                   	ret    

008022aa <rsttst>:
void rsttst()
{
  8022aa:	55                   	push   %ebp
  8022ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8022ad:	6a 00                	push   $0x0
  8022af:	6a 00                	push   $0x0
  8022b1:	6a 00                	push   $0x0
  8022b3:	6a 00                	push   $0x0
  8022b5:	6a 00                	push   $0x0
  8022b7:	6a 28                	push   $0x28
  8022b9:	e8 43 fb ff ff       	call   801e01 <syscall>
  8022be:	83 c4 18             	add    $0x18,%esp
	return ;
  8022c1:	90                   	nop
}
  8022c2:	c9                   	leave  
  8022c3:	c3                   	ret    

008022c4 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8022c4:	55                   	push   %ebp
  8022c5:	89 e5                	mov    %esp,%ebp
  8022c7:	83 ec 04             	sub    $0x4,%esp
  8022ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8022cd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8022d0:	8b 55 18             	mov    0x18(%ebp),%edx
  8022d3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8022d7:	52                   	push   %edx
  8022d8:	50                   	push   %eax
  8022d9:	ff 75 10             	pushl  0x10(%ebp)
  8022dc:	ff 75 0c             	pushl  0xc(%ebp)
  8022df:	ff 75 08             	pushl  0x8(%ebp)
  8022e2:	6a 27                	push   $0x27
  8022e4:	e8 18 fb ff ff       	call   801e01 <syscall>
  8022e9:	83 c4 18             	add    $0x18,%esp
	return ;
  8022ec:	90                   	nop
}
  8022ed:	c9                   	leave  
  8022ee:	c3                   	ret    

008022ef <chktst>:
void chktst(uint32 n)
{
  8022ef:	55                   	push   %ebp
  8022f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8022f2:	6a 00                	push   $0x0
  8022f4:	6a 00                	push   $0x0
  8022f6:	6a 00                	push   $0x0
  8022f8:	6a 00                	push   $0x0
  8022fa:	ff 75 08             	pushl  0x8(%ebp)
  8022fd:	6a 29                	push   $0x29
  8022ff:	e8 fd fa ff ff       	call   801e01 <syscall>
  802304:	83 c4 18             	add    $0x18,%esp
	return ;
  802307:	90                   	nop
}
  802308:	c9                   	leave  
  802309:	c3                   	ret    

0080230a <inctst>:

void inctst()
{
  80230a:	55                   	push   %ebp
  80230b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80230d:	6a 00                	push   $0x0
  80230f:	6a 00                	push   $0x0
  802311:	6a 00                	push   $0x0
  802313:	6a 00                	push   $0x0
  802315:	6a 00                	push   $0x0
  802317:	6a 2a                	push   $0x2a
  802319:	e8 e3 fa ff ff       	call   801e01 <syscall>
  80231e:	83 c4 18             	add    $0x18,%esp
	return ;
  802321:	90                   	nop
}
  802322:	c9                   	leave  
  802323:	c3                   	ret    

00802324 <gettst>:
uint32 gettst()
{
  802324:	55                   	push   %ebp
  802325:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802327:	6a 00                	push   $0x0
  802329:	6a 00                	push   $0x0
  80232b:	6a 00                	push   $0x0
  80232d:	6a 00                	push   $0x0
  80232f:	6a 00                	push   $0x0
  802331:	6a 2b                	push   $0x2b
  802333:	e8 c9 fa ff ff       	call   801e01 <syscall>
  802338:	83 c4 18             	add    $0x18,%esp
}
  80233b:	c9                   	leave  
  80233c:	c3                   	ret    

0080233d <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80233d:	55                   	push   %ebp
  80233e:	89 e5                	mov    %esp,%ebp
  802340:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802343:	6a 00                	push   $0x0
  802345:	6a 00                	push   $0x0
  802347:	6a 00                	push   $0x0
  802349:	6a 00                	push   $0x0
  80234b:	6a 00                	push   $0x0
  80234d:	6a 2c                	push   $0x2c
  80234f:	e8 ad fa ff ff       	call   801e01 <syscall>
  802354:	83 c4 18             	add    $0x18,%esp
  802357:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80235a:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80235e:	75 07                	jne    802367 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802360:	b8 01 00 00 00       	mov    $0x1,%eax
  802365:	eb 05                	jmp    80236c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802367:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80236c:	c9                   	leave  
  80236d:	c3                   	ret    

0080236e <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80236e:	55                   	push   %ebp
  80236f:	89 e5                	mov    %esp,%ebp
  802371:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802374:	6a 00                	push   $0x0
  802376:	6a 00                	push   $0x0
  802378:	6a 00                	push   $0x0
  80237a:	6a 00                	push   $0x0
  80237c:	6a 00                	push   $0x0
  80237e:	6a 2c                	push   $0x2c
  802380:	e8 7c fa ff ff       	call   801e01 <syscall>
  802385:	83 c4 18             	add    $0x18,%esp
  802388:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80238b:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80238f:	75 07                	jne    802398 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802391:	b8 01 00 00 00       	mov    $0x1,%eax
  802396:	eb 05                	jmp    80239d <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802398:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80239d:	c9                   	leave  
  80239e:	c3                   	ret    

0080239f <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80239f:	55                   	push   %ebp
  8023a0:	89 e5                	mov    %esp,%ebp
  8023a2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023a5:	6a 00                	push   $0x0
  8023a7:	6a 00                	push   $0x0
  8023a9:	6a 00                	push   $0x0
  8023ab:	6a 00                	push   $0x0
  8023ad:	6a 00                	push   $0x0
  8023af:	6a 2c                	push   $0x2c
  8023b1:	e8 4b fa ff ff       	call   801e01 <syscall>
  8023b6:	83 c4 18             	add    $0x18,%esp
  8023b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8023bc:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8023c0:	75 07                	jne    8023c9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8023c2:	b8 01 00 00 00       	mov    $0x1,%eax
  8023c7:	eb 05                	jmp    8023ce <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8023c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023ce:	c9                   	leave  
  8023cf:	c3                   	ret    

008023d0 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8023d0:	55                   	push   %ebp
  8023d1:	89 e5                	mov    %esp,%ebp
  8023d3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023d6:	6a 00                	push   $0x0
  8023d8:	6a 00                	push   $0x0
  8023da:	6a 00                	push   $0x0
  8023dc:	6a 00                	push   $0x0
  8023de:	6a 00                	push   $0x0
  8023e0:	6a 2c                	push   $0x2c
  8023e2:	e8 1a fa ff ff       	call   801e01 <syscall>
  8023e7:	83 c4 18             	add    $0x18,%esp
  8023ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8023ed:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8023f1:	75 07                	jne    8023fa <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8023f3:	b8 01 00 00 00       	mov    $0x1,%eax
  8023f8:	eb 05                	jmp    8023ff <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8023fa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023ff:	c9                   	leave  
  802400:	c3                   	ret    

00802401 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802401:	55                   	push   %ebp
  802402:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802404:	6a 00                	push   $0x0
  802406:	6a 00                	push   $0x0
  802408:	6a 00                	push   $0x0
  80240a:	6a 00                	push   $0x0
  80240c:	ff 75 08             	pushl  0x8(%ebp)
  80240f:	6a 2d                	push   $0x2d
  802411:	e8 eb f9 ff ff       	call   801e01 <syscall>
  802416:	83 c4 18             	add    $0x18,%esp
	return ;
  802419:	90                   	nop
}
  80241a:	c9                   	leave  
  80241b:	c3                   	ret    

0080241c <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80241c:	55                   	push   %ebp
  80241d:	89 e5                	mov    %esp,%ebp
  80241f:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802420:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802423:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802426:	8b 55 0c             	mov    0xc(%ebp),%edx
  802429:	8b 45 08             	mov    0x8(%ebp),%eax
  80242c:	6a 00                	push   $0x0
  80242e:	53                   	push   %ebx
  80242f:	51                   	push   %ecx
  802430:	52                   	push   %edx
  802431:	50                   	push   %eax
  802432:	6a 2e                	push   $0x2e
  802434:	e8 c8 f9 ff ff       	call   801e01 <syscall>
  802439:	83 c4 18             	add    $0x18,%esp
}
  80243c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80243f:	c9                   	leave  
  802440:	c3                   	ret    

00802441 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802441:	55                   	push   %ebp
  802442:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802444:	8b 55 0c             	mov    0xc(%ebp),%edx
  802447:	8b 45 08             	mov    0x8(%ebp),%eax
  80244a:	6a 00                	push   $0x0
  80244c:	6a 00                	push   $0x0
  80244e:	6a 00                	push   $0x0
  802450:	52                   	push   %edx
  802451:	50                   	push   %eax
  802452:	6a 2f                	push   $0x2f
  802454:	e8 a8 f9 ff ff       	call   801e01 <syscall>
  802459:	83 c4 18             	add    $0x18,%esp
}
  80245c:	c9                   	leave  
  80245d:	c3                   	ret    

0080245e <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  80245e:	55                   	push   %ebp
  80245f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  802461:	6a 00                	push   $0x0
  802463:	6a 00                	push   $0x0
  802465:	6a 00                	push   $0x0
  802467:	ff 75 0c             	pushl  0xc(%ebp)
  80246a:	ff 75 08             	pushl  0x8(%ebp)
  80246d:	6a 30                	push   $0x30
  80246f:	e8 8d f9 ff ff       	call   801e01 <syscall>
  802474:	83 c4 18             	add    $0x18,%esp
	return ;
  802477:	90                   	nop
}
  802478:	c9                   	leave  
  802479:	c3                   	ret    
  80247a:	66 90                	xchg   %ax,%ax

0080247c <__udivdi3>:
  80247c:	55                   	push   %ebp
  80247d:	57                   	push   %edi
  80247e:	56                   	push   %esi
  80247f:	53                   	push   %ebx
  802480:	83 ec 1c             	sub    $0x1c,%esp
  802483:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802487:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80248b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80248f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802493:	89 ca                	mov    %ecx,%edx
  802495:	89 f8                	mov    %edi,%eax
  802497:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80249b:	85 f6                	test   %esi,%esi
  80249d:	75 2d                	jne    8024cc <__udivdi3+0x50>
  80249f:	39 cf                	cmp    %ecx,%edi
  8024a1:	77 65                	ja     802508 <__udivdi3+0x8c>
  8024a3:	89 fd                	mov    %edi,%ebp
  8024a5:	85 ff                	test   %edi,%edi
  8024a7:	75 0b                	jne    8024b4 <__udivdi3+0x38>
  8024a9:	b8 01 00 00 00       	mov    $0x1,%eax
  8024ae:	31 d2                	xor    %edx,%edx
  8024b0:	f7 f7                	div    %edi
  8024b2:	89 c5                	mov    %eax,%ebp
  8024b4:	31 d2                	xor    %edx,%edx
  8024b6:	89 c8                	mov    %ecx,%eax
  8024b8:	f7 f5                	div    %ebp
  8024ba:	89 c1                	mov    %eax,%ecx
  8024bc:	89 d8                	mov    %ebx,%eax
  8024be:	f7 f5                	div    %ebp
  8024c0:	89 cf                	mov    %ecx,%edi
  8024c2:	89 fa                	mov    %edi,%edx
  8024c4:	83 c4 1c             	add    $0x1c,%esp
  8024c7:	5b                   	pop    %ebx
  8024c8:	5e                   	pop    %esi
  8024c9:	5f                   	pop    %edi
  8024ca:	5d                   	pop    %ebp
  8024cb:	c3                   	ret    
  8024cc:	39 ce                	cmp    %ecx,%esi
  8024ce:	77 28                	ja     8024f8 <__udivdi3+0x7c>
  8024d0:	0f bd fe             	bsr    %esi,%edi
  8024d3:	83 f7 1f             	xor    $0x1f,%edi
  8024d6:	75 40                	jne    802518 <__udivdi3+0x9c>
  8024d8:	39 ce                	cmp    %ecx,%esi
  8024da:	72 0a                	jb     8024e6 <__udivdi3+0x6a>
  8024dc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8024e0:	0f 87 9e 00 00 00    	ja     802584 <__udivdi3+0x108>
  8024e6:	b8 01 00 00 00       	mov    $0x1,%eax
  8024eb:	89 fa                	mov    %edi,%edx
  8024ed:	83 c4 1c             	add    $0x1c,%esp
  8024f0:	5b                   	pop    %ebx
  8024f1:	5e                   	pop    %esi
  8024f2:	5f                   	pop    %edi
  8024f3:	5d                   	pop    %ebp
  8024f4:	c3                   	ret    
  8024f5:	8d 76 00             	lea    0x0(%esi),%esi
  8024f8:	31 ff                	xor    %edi,%edi
  8024fa:	31 c0                	xor    %eax,%eax
  8024fc:	89 fa                	mov    %edi,%edx
  8024fe:	83 c4 1c             	add    $0x1c,%esp
  802501:	5b                   	pop    %ebx
  802502:	5e                   	pop    %esi
  802503:	5f                   	pop    %edi
  802504:	5d                   	pop    %ebp
  802505:	c3                   	ret    
  802506:	66 90                	xchg   %ax,%ax
  802508:	89 d8                	mov    %ebx,%eax
  80250a:	f7 f7                	div    %edi
  80250c:	31 ff                	xor    %edi,%edi
  80250e:	89 fa                	mov    %edi,%edx
  802510:	83 c4 1c             	add    $0x1c,%esp
  802513:	5b                   	pop    %ebx
  802514:	5e                   	pop    %esi
  802515:	5f                   	pop    %edi
  802516:	5d                   	pop    %ebp
  802517:	c3                   	ret    
  802518:	bd 20 00 00 00       	mov    $0x20,%ebp
  80251d:	89 eb                	mov    %ebp,%ebx
  80251f:	29 fb                	sub    %edi,%ebx
  802521:	89 f9                	mov    %edi,%ecx
  802523:	d3 e6                	shl    %cl,%esi
  802525:	89 c5                	mov    %eax,%ebp
  802527:	88 d9                	mov    %bl,%cl
  802529:	d3 ed                	shr    %cl,%ebp
  80252b:	89 e9                	mov    %ebp,%ecx
  80252d:	09 f1                	or     %esi,%ecx
  80252f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802533:	89 f9                	mov    %edi,%ecx
  802535:	d3 e0                	shl    %cl,%eax
  802537:	89 c5                	mov    %eax,%ebp
  802539:	89 d6                	mov    %edx,%esi
  80253b:	88 d9                	mov    %bl,%cl
  80253d:	d3 ee                	shr    %cl,%esi
  80253f:	89 f9                	mov    %edi,%ecx
  802541:	d3 e2                	shl    %cl,%edx
  802543:	8b 44 24 08          	mov    0x8(%esp),%eax
  802547:	88 d9                	mov    %bl,%cl
  802549:	d3 e8                	shr    %cl,%eax
  80254b:	09 c2                	or     %eax,%edx
  80254d:	89 d0                	mov    %edx,%eax
  80254f:	89 f2                	mov    %esi,%edx
  802551:	f7 74 24 0c          	divl   0xc(%esp)
  802555:	89 d6                	mov    %edx,%esi
  802557:	89 c3                	mov    %eax,%ebx
  802559:	f7 e5                	mul    %ebp
  80255b:	39 d6                	cmp    %edx,%esi
  80255d:	72 19                	jb     802578 <__udivdi3+0xfc>
  80255f:	74 0b                	je     80256c <__udivdi3+0xf0>
  802561:	89 d8                	mov    %ebx,%eax
  802563:	31 ff                	xor    %edi,%edi
  802565:	e9 58 ff ff ff       	jmp    8024c2 <__udivdi3+0x46>
  80256a:	66 90                	xchg   %ax,%ax
  80256c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802570:	89 f9                	mov    %edi,%ecx
  802572:	d3 e2                	shl    %cl,%edx
  802574:	39 c2                	cmp    %eax,%edx
  802576:	73 e9                	jae    802561 <__udivdi3+0xe5>
  802578:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80257b:	31 ff                	xor    %edi,%edi
  80257d:	e9 40 ff ff ff       	jmp    8024c2 <__udivdi3+0x46>
  802582:	66 90                	xchg   %ax,%ax
  802584:	31 c0                	xor    %eax,%eax
  802586:	e9 37 ff ff ff       	jmp    8024c2 <__udivdi3+0x46>
  80258b:	90                   	nop

0080258c <__umoddi3>:
  80258c:	55                   	push   %ebp
  80258d:	57                   	push   %edi
  80258e:	56                   	push   %esi
  80258f:	53                   	push   %ebx
  802590:	83 ec 1c             	sub    $0x1c,%esp
  802593:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802597:	8b 74 24 34          	mov    0x34(%esp),%esi
  80259b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80259f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8025a3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8025a7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8025ab:	89 f3                	mov    %esi,%ebx
  8025ad:	89 fa                	mov    %edi,%edx
  8025af:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8025b3:	89 34 24             	mov    %esi,(%esp)
  8025b6:	85 c0                	test   %eax,%eax
  8025b8:	75 1a                	jne    8025d4 <__umoddi3+0x48>
  8025ba:	39 f7                	cmp    %esi,%edi
  8025bc:	0f 86 a2 00 00 00    	jbe    802664 <__umoddi3+0xd8>
  8025c2:	89 c8                	mov    %ecx,%eax
  8025c4:	89 f2                	mov    %esi,%edx
  8025c6:	f7 f7                	div    %edi
  8025c8:	89 d0                	mov    %edx,%eax
  8025ca:	31 d2                	xor    %edx,%edx
  8025cc:	83 c4 1c             	add    $0x1c,%esp
  8025cf:	5b                   	pop    %ebx
  8025d0:	5e                   	pop    %esi
  8025d1:	5f                   	pop    %edi
  8025d2:	5d                   	pop    %ebp
  8025d3:	c3                   	ret    
  8025d4:	39 f0                	cmp    %esi,%eax
  8025d6:	0f 87 ac 00 00 00    	ja     802688 <__umoddi3+0xfc>
  8025dc:	0f bd e8             	bsr    %eax,%ebp
  8025df:	83 f5 1f             	xor    $0x1f,%ebp
  8025e2:	0f 84 ac 00 00 00    	je     802694 <__umoddi3+0x108>
  8025e8:	bf 20 00 00 00       	mov    $0x20,%edi
  8025ed:	29 ef                	sub    %ebp,%edi
  8025ef:	89 fe                	mov    %edi,%esi
  8025f1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8025f5:	89 e9                	mov    %ebp,%ecx
  8025f7:	d3 e0                	shl    %cl,%eax
  8025f9:	89 d7                	mov    %edx,%edi
  8025fb:	89 f1                	mov    %esi,%ecx
  8025fd:	d3 ef                	shr    %cl,%edi
  8025ff:	09 c7                	or     %eax,%edi
  802601:	89 e9                	mov    %ebp,%ecx
  802603:	d3 e2                	shl    %cl,%edx
  802605:	89 14 24             	mov    %edx,(%esp)
  802608:	89 d8                	mov    %ebx,%eax
  80260a:	d3 e0                	shl    %cl,%eax
  80260c:	89 c2                	mov    %eax,%edx
  80260e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802612:	d3 e0                	shl    %cl,%eax
  802614:	89 44 24 04          	mov    %eax,0x4(%esp)
  802618:	8b 44 24 08          	mov    0x8(%esp),%eax
  80261c:	89 f1                	mov    %esi,%ecx
  80261e:	d3 e8                	shr    %cl,%eax
  802620:	09 d0                	or     %edx,%eax
  802622:	d3 eb                	shr    %cl,%ebx
  802624:	89 da                	mov    %ebx,%edx
  802626:	f7 f7                	div    %edi
  802628:	89 d3                	mov    %edx,%ebx
  80262a:	f7 24 24             	mull   (%esp)
  80262d:	89 c6                	mov    %eax,%esi
  80262f:	89 d1                	mov    %edx,%ecx
  802631:	39 d3                	cmp    %edx,%ebx
  802633:	0f 82 87 00 00 00    	jb     8026c0 <__umoddi3+0x134>
  802639:	0f 84 91 00 00 00    	je     8026d0 <__umoddi3+0x144>
  80263f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802643:	29 f2                	sub    %esi,%edx
  802645:	19 cb                	sbb    %ecx,%ebx
  802647:	89 d8                	mov    %ebx,%eax
  802649:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80264d:	d3 e0                	shl    %cl,%eax
  80264f:	89 e9                	mov    %ebp,%ecx
  802651:	d3 ea                	shr    %cl,%edx
  802653:	09 d0                	or     %edx,%eax
  802655:	89 e9                	mov    %ebp,%ecx
  802657:	d3 eb                	shr    %cl,%ebx
  802659:	89 da                	mov    %ebx,%edx
  80265b:	83 c4 1c             	add    $0x1c,%esp
  80265e:	5b                   	pop    %ebx
  80265f:	5e                   	pop    %esi
  802660:	5f                   	pop    %edi
  802661:	5d                   	pop    %ebp
  802662:	c3                   	ret    
  802663:	90                   	nop
  802664:	89 fd                	mov    %edi,%ebp
  802666:	85 ff                	test   %edi,%edi
  802668:	75 0b                	jne    802675 <__umoddi3+0xe9>
  80266a:	b8 01 00 00 00       	mov    $0x1,%eax
  80266f:	31 d2                	xor    %edx,%edx
  802671:	f7 f7                	div    %edi
  802673:	89 c5                	mov    %eax,%ebp
  802675:	89 f0                	mov    %esi,%eax
  802677:	31 d2                	xor    %edx,%edx
  802679:	f7 f5                	div    %ebp
  80267b:	89 c8                	mov    %ecx,%eax
  80267d:	f7 f5                	div    %ebp
  80267f:	89 d0                	mov    %edx,%eax
  802681:	e9 44 ff ff ff       	jmp    8025ca <__umoddi3+0x3e>
  802686:	66 90                	xchg   %ax,%ax
  802688:	89 c8                	mov    %ecx,%eax
  80268a:	89 f2                	mov    %esi,%edx
  80268c:	83 c4 1c             	add    $0x1c,%esp
  80268f:	5b                   	pop    %ebx
  802690:	5e                   	pop    %esi
  802691:	5f                   	pop    %edi
  802692:	5d                   	pop    %ebp
  802693:	c3                   	ret    
  802694:	3b 04 24             	cmp    (%esp),%eax
  802697:	72 06                	jb     80269f <__umoddi3+0x113>
  802699:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80269d:	77 0f                	ja     8026ae <__umoddi3+0x122>
  80269f:	89 f2                	mov    %esi,%edx
  8026a1:	29 f9                	sub    %edi,%ecx
  8026a3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8026a7:	89 14 24             	mov    %edx,(%esp)
  8026aa:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8026ae:	8b 44 24 04          	mov    0x4(%esp),%eax
  8026b2:	8b 14 24             	mov    (%esp),%edx
  8026b5:	83 c4 1c             	add    $0x1c,%esp
  8026b8:	5b                   	pop    %ebx
  8026b9:	5e                   	pop    %esi
  8026ba:	5f                   	pop    %edi
  8026bb:	5d                   	pop    %ebp
  8026bc:	c3                   	ret    
  8026bd:	8d 76 00             	lea    0x0(%esi),%esi
  8026c0:	2b 04 24             	sub    (%esp),%eax
  8026c3:	19 fa                	sbb    %edi,%edx
  8026c5:	89 d1                	mov    %edx,%ecx
  8026c7:	89 c6                	mov    %eax,%esi
  8026c9:	e9 71 ff ff ff       	jmp    80263f <__umoddi3+0xb3>
  8026ce:	66 90                	xchg   %ax,%ax
  8026d0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8026d4:	72 ea                	jb     8026c0 <__umoddi3+0x134>
  8026d6:	89 d9                	mov    %ebx,%ecx
  8026d8:	e9 62 ff ff ff       	jmp    80263f <__umoddi3+0xb3>
