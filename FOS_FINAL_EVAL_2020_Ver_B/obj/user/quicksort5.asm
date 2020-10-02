
obj/user/quicksort5:     file format elf32-i386


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
  800031:	e8 96 06 00 00       	call   8006cc <libmain>
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
  800049:	e8 62 1b 00 00       	call   801bb0 <sys_getenvid>
  80004e:	89 45 e8             	mov    %eax,-0x18(%ebp)
	sys_createSemaphore("cs1", 1);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	6a 01                	push   $0x1
  800056:	68 20 24 80 00       	push   $0x802420
  80005b:	e8 78 1d 00 00       	call   801dd8 <sys_createSemaphore>
  800060:	83 c4 10             	add    $0x10,%esp
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800063:	e8 2c 1c 00 00       	call   801c94 <sys_calculate_free_frames>
  800068:	89 c3                	mov    %eax,%ebx
  80006a:	e8 3e 1c 00 00       	call   801cad <sys_calculate_modified_frames>
  80006f:	01 d8                	add    %ebx,%eax
  800071:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		Iteration++ ;
  800074:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();
		sys_waitSemaphore(envID, "cs1");
  800077:	83 ec 08             	sub    $0x8,%esp
  80007a:	68 20 24 80 00       	push   $0x802420
  80007f:	ff 75 e8             	pushl  -0x18(%ebp)
  800082:	e8 8a 1d 00 00       	call   801e11 <sys_waitSemaphore>
  800087:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  80008a:	83 ec 08             	sub    $0x8,%esp
  80008d:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  800093:	50                   	push   %eax
  800094:	68 24 24 80 00       	push   $0x802424
  800099:	e8 8c 10 00 00       	call   80112a <readline>
  80009e:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000a1:	83 ec 04             	sub    $0x4,%esp
  8000a4:	6a 0a                	push   $0xa
  8000a6:	6a 00                	push   $0x0
  8000a8:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  8000ae:	50                   	push   %eax
  8000af:	e8 dc 15 00 00       	call   801690 <strtol>
  8000b4:	83 c4 10             	add    $0x10,%esp
  8000b7:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000bd:	c1 e0 02             	shl    $0x2,%eax
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	50                   	push   %eax
  8000c4:	e8 6f 19 00 00       	call   801a38 <malloc>
  8000c9:	83 c4 10             	add    $0x10,%esp
  8000cc:	89 45 dc             	mov    %eax,-0x24(%ebp)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	68 44 24 80 00       	push   $0x802444
  8000d7:	e8 cc 09 00 00       	call   800aa8 <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	68 67 24 80 00       	push   $0x802467
  8000e7:	e8 bc 09 00 00       	call   800aa8 <cprintf>
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
  800114:	68 75 24 80 00       	push   $0x802475
  800119:	e8 8a 09 00 00       	call   800aa8 <cprintf>
  80011e:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800121:	83 ec 0c             	sub    $0xc,%esp
  800124:	68 84 24 80 00       	push   $0x802484
  800129:	e8 7a 09 00 00       	call   800aa8 <cprintf>
  80012e:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800131:	83 ec 0c             	sub    $0xc,%esp
  800134:	68 94 24 80 00       	push   $0x802494
  800139:	e8 6a 09 00 00       	call   800aa8 <cprintf>
  80013e:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800141:	e8 2e 05 00 00       	call   800674 <getchar>
  800146:	88 45 db             	mov    %al,-0x25(%ebp)
			cputchar(Chose);
  800149:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80014d:	83 ec 0c             	sub    $0xc,%esp
  800150:	50                   	push   %eax
  800151:	e8 d6 04 00 00       	call   80062c <cputchar>
  800156:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800159:	83 ec 0c             	sub    $0xc,%esp
  80015c:	6a 0a                	push   $0xa
  80015e:	e8 c9 04 00 00       	call   80062c <cputchar>
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
  80017b:	68 20 24 80 00       	push   $0x802420
  800180:	ff 75 e8             	pushl  -0x18(%ebp)
  800183:	e8 a7 1c 00 00       	call   801e2f <sys_signalSemaphore>
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
  8001a7:	e8 48 03 00 00       	call   8004f4 <InitializeAscending>
  8001ac:	83 c4 10             	add    $0x10,%esp
			break ;
  8001af:	eb 37                	jmp    8001e8 <_main+0x1b0>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  8001b1:	83 ec 08             	sub    $0x8,%esp
  8001b4:	ff 75 e0             	pushl  -0x20(%ebp)
  8001b7:	ff 75 dc             	pushl  -0x24(%ebp)
  8001ba:	e8 66 03 00 00       	call   800525 <InitializeDescending>
  8001bf:	83 c4 10             	add    $0x10,%esp
			break ;
  8001c2:	eb 24                	jmp    8001e8 <_main+0x1b0>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ca:	ff 75 dc             	pushl  -0x24(%ebp)
  8001cd:	e8 88 03 00 00       	call   80055a <InitializeSemiRandom>
  8001d2:	83 c4 10             	add    $0x10,%esp
			break ;
  8001d5:	eb 11                	jmp    8001e8 <_main+0x1b0>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001d7:	83 ec 08             	sub    $0x8,%esp
  8001da:	ff 75 e0             	pushl  -0x20(%ebp)
  8001dd:	ff 75 dc             	pushl  -0x24(%ebp)
  8001e0:	e8 75 03 00 00       	call   80055a <InitializeSemiRandom>
  8001e5:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001e8:	83 ec 08             	sub    $0x8,%esp
  8001eb:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ee:	ff 75 dc             	pushl  -0x24(%ebp)
  8001f1:	e8 43 01 00 00       	call   800339 <QuickSort>
  8001f6:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001f9:	83 ec 08             	sub    $0x8,%esp
  8001fc:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ff:	ff 75 dc             	pushl  -0x24(%ebp)
  800202:	e8 43 02 00 00       	call   80044a <CheckSorted>
  800207:	83 c4 10             	add    $0x10,%esp
  80020a:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  80020d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  800211:	75 14                	jne    800227 <_main+0x1ef>
  800213:	83 ec 04             	sub    $0x4,%esp
  800216:	68 a0 24 80 00       	push   $0x8024a0
  80021b:	6a 4f                	push   $0x4f
  80021d:	68 c2 24 80 00       	push   $0x8024c2
  800222:	e8 ca 05 00 00       	call   8007f1 <_panic>
		else
		{
			sys_waitSemaphore(envID, "cs1");
  800227:	83 ec 08             	sub    $0x8,%esp
  80022a:	68 20 24 80 00       	push   $0x802420
  80022f:	ff 75 e8             	pushl  -0x18(%ebp)
  800232:	e8 da 1b 00 00       	call   801e11 <sys_waitSemaphore>
  800237:	83 c4 10             	add    $0x10,%esp
			cprintf("\n===============================================\n") ;
  80023a:	83 ec 0c             	sub    $0xc,%esp
  80023d:	68 d4 24 80 00       	push   $0x8024d4
  800242:	e8 61 08 00 00       	call   800aa8 <cprintf>
  800247:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80024a:	83 ec 0c             	sub    $0xc,%esp
  80024d:	68 08 25 80 00       	push   $0x802508
  800252:	e8 51 08 00 00       	call   800aa8 <cprintf>
  800257:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80025a:	83 ec 0c             	sub    $0xc,%esp
  80025d:	68 3c 25 80 00       	push   $0x80253c
  800262:	e8 41 08 00 00       	call   800aa8 <cprintf>
  800267:	83 c4 10             	add    $0x10,%esp
			sys_signalSemaphore(envID, "cs1");
  80026a:	83 ec 08             	sub    $0x8,%esp
  80026d:	68 20 24 80 00       	push   $0x802420
  800272:	ff 75 e8             	pushl  -0x18(%ebp)
  800275:	e8 b5 1b 00 00       	call   801e2f <sys_signalSemaphore>
  80027a:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		sys_waitSemaphore(envID, "cs1");
  80027d:	83 ec 08             	sub    $0x8,%esp
  800280:	68 20 24 80 00       	push   $0x802420
  800285:	ff 75 e8             	pushl  -0x18(%ebp)
  800288:	e8 84 1b 00 00       	call   801e11 <sys_waitSemaphore>
  80028d:	83 c4 10             	add    $0x10,%esp
		cprintf("Freeing the Heap...\n\n") ;
  800290:	83 ec 0c             	sub    $0xc,%esp
  800293:	68 6e 25 80 00       	push   $0x80256e
  800298:	e8 0b 08 00 00       	call   800aa8 <cprintf>
  80029d:	83 c4 10             	add    $0x10,%esp
		sys_signalSemaphore(envID,"cs1");
  8002a0:	83 ec 08             	sub    $0x8,%esp
  8002a3:	68 20 24 80 00       	push   $0x802420
  8002a8:	ff 75 e8             	pushl  -0x18(%ebp)
  8002ab:	e8 7f 1b 00 00       	call   801e2f <sys_signalSemaphore>
  8002b0:	83 c4 10             	add    $0x10,%esp
		free(Elements) ;
  8002b3:	83 ec 0c             	sub    $0xc,%esp
  8002b6:	ff 75 dc             	pushl  -0x24(%ebp)
  8002b9:	e8 94 17 00 00       	call   801a52 <free>
  8002be:	83 c4 10             	add    $0x10,%esp


		///========================================================================
	//sys_disable_interrupt();
		sys_waitSemaphore(envID, "cs1");
  8002c1:	83 ec 08             	sub    $0x8,%esp
  8002c4:	68 20 24 80 00       	push   $0x802420
  8002c9:	ff 75 e8             	pushl  -0x18(%ebp)
  8002cc:	e8 40 1b 00 00       	call   801e11 <sys_waitSemaphore>
  8002d1:	83 c4 10             	add    $0x10,%esp
		cprintf("Do you want to repeat (y/n): ") ;
  8002d4:	83 ec 0c             	sub    $0xc,%esp
  8002d7:	68 84 25 80 00       	push   $0x802584
  8002dc:	e8 c7 07 00 00       	call   800aa8 <cprintf>
  8002e1:	83 c4 10             	add    $0x10,%esp

		Chose = getchar() ;
  8002e4:	e8 8b 03 00 00       	call   800674 <getchar>
  8002e9:	88 45 db             	mov    %al,-0x25(%ebp)
		cputchar(Chose);
  8002ec:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8002f0:	83 ec 0c             	sub    $0xc,%esp
  8002f3:	50                   	push   %eax
  8002f4:	e8 33 03 00 00       	call   80062c <cputchar>
  8002f9:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  8002fc:	83 ec 0c             	sub    $0xc,%esp
  8002ff:	6a 0a                	push   $0xa
  800301:	e8 26 03 00 00       	call   80062c <cputchar>
  800306:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800309:	83 ec 0c             	sub    $0xc,%esp
  80030c:	6a 0a                	push   $0xa
  80030e:	e8 19 03 00 00       	call   80062c <cputchar>
  800313:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();
		sys_signalSemaphore(envID,"cs1");
  800316:	83 ec 08             	sub    $0x8,%esp
  800319:	68 20 24 80 00       	push   $0x802420
  80031e:	ff 75 e8             	pushl  -0x18(%ebp)
  800321:	e8 09 1b 00 00       	call   801e2f <sys_signalSemaphore>
  800326:	83 c4 10             	add    $0x10,%esp

	} while (Chose == 'y');
  800329:	80 7d db 79          	cmpb   $0x79,-0x25(%ebp)
  80032d:	0f 84 30 fd ff ff    	je     800063 <_main+0x2b>

}
  800333:	90                   	nop
  800334:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800337:	c9                   	leave  
  800338:	c3                   	ret    

00800339 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  800339:	55                   	push   %ebp
  80033a:	89 e5                	mov    %esp,%ebp
  80033c:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  80033f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800342:	48                   	dec    %eax
  800343:	50                   	push   %eax
  800344:	6a 00                	push   $0x0
  800346:	ff 75 0c             	pushl  0xc(%ebp)
  800349:	ff 75 08             	pushl  0x8(%ebp)
  80034c:	e8 06 00 00 00       	call   800357 <QSort>
  800351:	83 c4 10             	add    $0x10,%esp
}
  800354:	90                   	nop
  800355:	c9                   	leave  
  800356:	c3                   	ret    

00800357 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800357:	55                   	push   %ebp
  800358:	89 e5                	mov    %esp,%ebp
  80035a:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  80035d:	8b 45 10             	mov    0x10(%ebp),%eax
  800360:	3b 45 14             	cmp    0x14(%ebp),%eax
  800363:	0f 8d de 00 00 00    	jge    800447 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800369:	8b 45 10             	mov    0x10(%ebp),%eax
  80036c:	40                   	inc    %eax
  80036d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800370:	8b 45 14             	mov    0x14(%ebp),%eax
  800373:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800376:	e9 80 00 00 00       	jmp    8003fb <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  80037b:	ff 45 f4             	incl   -0xc(%ebp)
  80037e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800381:	3b 45 14             	cmp    0x14(%ebp),%eax
  800384:	7f 2b                	jg     8003b1 <QSort+0x5a>
  800386:	8b 45 10             	mov    0x10(%ebp),%eax
  800389:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800390:	8b 45 08             	mov    0x8(%ebp),%eax
  800393:	01 d0                	add    %edx,%eax
  800395:	8b 10                	mov    (%eax),%edx
  800397:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80039a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a4:	01 c8                	add    %ecx,%eax
  8003a6:	8b 00                	mov    (%eax),%eax
  8003a8:	39 c2                	cmp    %eax,%edx
  8003aa:	7d cf                	jge    80037b <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8003ac:	eb 03                	jmp    8003b1 <QSort+0x5a>
  8003ae:	ff 4d f0             	decl   -0x10(%ebp)
  8003b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003b4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8003b7:	7e 26                	jle    8003df <QSort+0x88>
  8003b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8003bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c6:	01 d0                	add    %edx,%eax
  8003c8:	8b 10                	mov    (%eax),%edx
  8003ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003cd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d7:	01 c8                	add    %ecx,%eax
  8003d9:	8b 00                	mov    (%eax),%eax
  8003db:	39 c2                	cmp    %eax,%edx
  8003dd:	7e cf                	jle    8003ae <QSort+0x57>

		if (i <= j)
  8003df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003e2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003e5:	7f 14                	jg     8003fb <QSort+0xa4>
		{
			Swap(Elements, i, j);
  8003e7:	83 ec 04             	sub    $0x4,%esp
  8003ea:	ff 75 f0             	pushl  -0x10(%ebp)
  8003ed:	ff 75 f4             	pushl  -0xc(%ebp)
  8003f0:	ff 75 08             	pushl  0x8(%ebp)
  8003f3:	e8 a9 00 00 00       	call   8004a1 <Swap>
  8003f8:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  8003fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003fe:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800401:	0f 8e 77 ff ff ff    	jle    80037e <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800407:	83 ec 04             	sub    $0x4,%esp
  80040a:	ff 75 f0             	pushl  -0x10(%ebp)
  80040d:	ff 75 10             	pushl  0x10(%ebp)
  800410:	ff 75 08             	pushl  0x8(%ebp)
  800413:	e8 89 00 00 00       	call   8004a1 <Swap>
  800418:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  80041b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80041e:	48                   	dec    %eax
  80041f:	50                   	push   %eax
  800420:	ff 75 10             	pushl  0x10(%ebp)
  800423:	ff 75 0c             	pushl  0xc(%ebp)
  800426:	ff 75 08             	pushl  0x8(%ebp)
  800429:	e8 29 ff ff ff       	call   800357 <QSort>
  80042e:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800431:	ff 75 14             	pushl  0x14(%ebp)
  800434:	ff 75 f4             	pushl  -0xc(%ebp)
  800437:	ff 75 0c             	pushl  0xc(%ebp)
  80043a:	ff 75 08             	pushl  0x8(%ebp)
  80043d:	e8 15 ff ff ff       	call   800357 <QSort>
  800442:	83 c4 10             	add    $0x10,%esp
  800445:	eb 01                	jmp    800448 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800447:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800448:	c9                   	leave  
  800449:	c3                   	ret    

0080044a <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  80044a:	55                   	push   %ebp
  80044b:	89 e5                	mov    %esp,%ebp
  80044d:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  800450:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800457:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80045e:	eb 33                	jmp    800493 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  800460:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800463:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046a:	8b 45 08             	mov    0x8(%ebp),%eax
  80046d:	01 d0                	add    %edx,%eax
  80046f:	8b 10                	mov    (%eax),%edx
  800471:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800474:	40                   	inc    %eax
  800475:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80047c:	8b 45 08             	mov    0x8(%ebp),%eax
  80047f:	01 c8                	add    %ecx,%eax
  800481:	8b 00                	mov    (%eax),%eax
  800483:	39 c2                	cmp    %eax,%edx
  800485:	7e 09                	jle    800490 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800487:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80048e:	eb 0c                	jmp    80049c <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800490:	ff 45 f8             	incl   -0x8(%ebp)
  800493:	8b 45 0c             	mov    0xc(%ebp),%eax
  800496:	48                   	dec    %eax
  800497:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80049a:	7f c4                	jg     800460 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  80049c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80049f:	c9                   	leave  
  8004a0:	c3                   	ret    

008004a1 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8004a1:	55                   	push   %ebp
  8004a2:	89 e5                	mov    %esp,%ebp
  8004a4:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8004a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b4:	01 d0                	add    %edx,%eax
  8004b6:	8b 00                	mov    (%eax),%eax
  8004b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8004bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004be:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c8:	01 c2                	add    %eax,%edx
  8004ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8004cd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d7:	01 c8                	add    %ecx,%eax
  8004d9:	8b 00                	mov    (%eax),%eax
  8004db:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8004dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8004e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ea:	01 c2                	add    %eax,%edx
  8004ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ef:	89 02                	mov    %eax,(%edx)
}
  8004f1:	90                   	nop
  8004f2:	c9                   	leave  
  8004f3:	c3                   	ret    

008004f4 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8004f4:	55                   	push   %ebp
  8004f5:	89 e5                	mov    %esp,%ebp
  8004f7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800501:	eb 17                	jmp    80051a <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800503:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800506:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80050d:	8b 45 08             	mov    0x8(%ebp),%eax
  800510:	01 c2                	add    %eax,%edx
  800512:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800515:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800517:	ff 45 fc             	incl   -0x4(%ebp)
  80051a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80051d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800520:	7c e1                	jl     800503 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800522:	90                   	nop
  800523:	c9                   	leave  
  800524:	c3                   	ret    

00800525 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800525:	55                   	push   %ebp
  800526:	89 e5                	mov    %esp,%ebp
  800528:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80052b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800532:	eb 1b                	jmp    80054f <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800534:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800537:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80053e:	8b 45 08             	mov    0x8(%ebp),%eax
  800541:	01 c2                	add    %eax,%edx
  800543:	8b 45 0c             	mov    0xc(%ebp),%eax
  800546:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800549:	48                   	dec    %eax
  80054a:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80054c:	ff 45 fc             	incl   -0x4(%ebp)
  80054f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800552:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800555:	7c dd                	jl     800534 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800557:	90                   	nop
  800558:	c9                   	leave  
  800559:	c3                   	ret    

0080055a <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  80055a:	55                   	push   %ebp
  80055b:	89 e5                	mov    %esp,%ebp
  80055d:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  800560:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800563:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800568:	f7 e9                	imul   %ecx
  80056a:	c1 f9 1f             	sar    $0x1f,%ecx
  80056d:	89 d0                	mov    %edx,%eax
  80056f:	29 c8                	sub    %ecx,%eax
  800571:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800574:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80057b:	eb 1e                	jmp    80059b <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  80057d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800580:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800587:	8b 45 08             	mov    0x8(%ebp),%eax
  80058a:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80058d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800590:	99                   	cltd   
  800591:	f7 7d f8             	idivl  -0x8(%ebp)
  800594:	89 d0                	mov    %edx,%eax
  800596:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800598:	ff 45 fc             	incl   -0x4(%ebp)
  80059b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80059e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005a1:	7c da                	jl     80057d <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8005a3:	90                   	nop
  8005a4:	c9                   	leave  
  8005a5:	c3                   	ret    

008005a6 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8005a6:	55                   	push   %ebp
  8005a7:	89 e5                	mov    %esp,%ebp
  8005a9:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  8005ac:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8005b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8005ba:	eb 42                	jmp    8005fe <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  8005bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005bf:	99                   	cltd   
  8005c0:	f7 7d f0             	idivl  -0x10(%ebp)
  8005c3:	89 d0                	mov    %edx,%eax
  8005c5:	85 c0                	test   %eax,%eax
  8005c7:	75 10                	jne    8005d9 <PrintElements+0x33>
			cprintf("\n");
  8005c9:	83 ec 0c             	sub    $0xc,%esp
  8005cc:	68 a2 25 80 00       	push   $0x8025a2
  8005d1:	e8 d2 04 00 00       	call   800aa8 <cprintf>
  8005d6:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  8005d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e6:	01 d0                	add    %edx,%eax
  8005e8:	8b 00                	mov    (%eax),%eax
  8005ea:	83 ec 08             	sub    $0x8,%esp
  8005ed:	50                   	push   %eax
  8005ee:	68 a4 25 80 00       	push   $0x8025a4
  8005f3:	e8 b0 04 00 00       	call   800aa8 <cprintf>
  8005f8:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8005fb:	ff 45 f4             	incl   -0xc(%ebp)
  8005fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800601:	48                   	dec    %eax
  800602:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800605:	7f b5                	jg     8005bc <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800607:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80060a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800611:	8b 45 08             	mov    0x8(%ebp),%eax
  800614:	01 d0                	add    %edx,%eax
  800616:	8b 00                	mov    (%eax),%eax
  800618:	83 ec 08             	sub    $0x8,%esp
  80061b:	50                   	push   %eax
  80061c:	68 a9 25 80 00       	push   $0x8025a9
  800621:	e8 82 04 00 00       	call   800aa8 <cprintf>
  800626:	83 c4 10             	add    $0x10,%esp

}
  800629:	90                   	nop
  80062a:	c9                   	leave  
  80062b:	c3                   	ret    

0080062c <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80062c:	55                   	push   %ebp
  80062d:	89 e5                	mov    %esp,%ebp
  80062f:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800632:	8b 45 08             	mov    0x8(%ebp),%eax
  800635:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800638:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80063c:	83 ec 0c             	sub    $0xc,%esp
  80063f:	50                   	push   %eax
  800640:	e8 53 17 00 00       	call   801d98 <sys_cputc>
  800645:	83 c4 10             	add    $0x10,%esp
}
  800648:	90                   	nop
  800649:	c9                   	leave  
  80064a:	c3                   	ret    

0080064b <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80064b:	55                   	push   %ebp
  80064c:	89 e5                	mov    %esp,%ebp
  80064e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800651:	e8 0e 17 00 00       	call   801d64 <sys_disable_interrupt>
	char c = ch;
  800656:	8b 45 08             	mov    0x8(%ebp),%eax
  800659:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80065c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800660:	83 ec 0c             	sub    $0xc,%esp
  800663:	50                   	push   %eax
  800664:	e8 2f 17 00 00       	call   801d98 <sys_cputc>
  800669:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80066c:	e8 0d 17 00 00       	call   801d7e <sys_enable_interrupt>
}
  800671:	90                   	nop
  800672:	c9                   	leave  
  800673:	c3                   	ret    

00800674 <getchar>:

int
getchar(void)
{
  800674:	55                   	push   %ebp
  800675:	89 e5                	mov    %esp,%ebp
  800677:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  80067a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800681:	eb 08                	jmp    80068b <getchar+0x17>
	{
		c = sys_cgetc();
  800683:	e8 f4 14 00 00       	call   801b7c <sys_cgetc>
  800688:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  80068b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80068f:	74 f2                	je     800683 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  800691:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800694:	c9                   	leave  
  800695:	c3                   	ret    

00800696 <atomic_getchar>:

int
atomic_getchar(void)
{
  800696:	55                   	push   %ebp
  800697:	89 e5                	mov    %esp,%ebp
  800699:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80069c:	e8 c3 16 00 00       	call   801d64 <sys_disable_interrupt>
	int c=0;
  8006a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8006a8:	eb 08                	jmp    8006b2 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8006aa:	e8 cd 14 00 00       	call   801b7c <sys_cgetc>
  8006af:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8006b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8006b6:	74 f2                	je     8006aa <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8006b8:	e8 c1 16 00 00       	call   801d7e <sys_enable_interrupt>
	return c;
  8006bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8006c0:	c9                   	leave  
  8006c1:	c3                   	ret    

008006c2 <iscons>:

int iscons(int fdnum)
{
  8006c2:	55                   	push   %ebp
  8006c3:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8006c5:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8006ca:	5d                   	pop    %ebp
  8006cb:	c3                   	ret    

008006cc <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8006cc:	55                   	push   %ebp
  8006cd:	89 e5                	mov    %esp,%ebp
  8006cf:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8006d2:	e8 f2 14 00 00       	call   801bc9 <sys_getenvindex>
  8006d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8006da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006dd:	89 d0                	mov    %edx,%eax
  8006df:	c1 e0 03             	shl    $0x3,%eax
  8006e2:	01 d0                	add    %edx,%eax
  8006e4:	c1 e0 02             	shl    $0x2,%eax
  8006e7:	01 d0                	add    %edx,%eax
  8006e9:	c1 e0 06             	shl    $0x6,%eax
  8006ec:	29 d0                	sub    %edx,%eax
  8006ee:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8006f5:	01 c8                	add    %ecx,%eax
  8006f7:	01 d0                	add    %edx,%eax
  8006f9:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8006fe:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800703:	a1 24 30 80 00       	mov    0x803024,%eax
  800708:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  80070e:	84 c0                	test   %al,%al
  800710:	74 0f                	je     800721 <libmain+0x55>
		binaryname = myEnv->prog_name;
  800712:	a1 24 30 80 00       	mov    0x803024,%eax
  800717:	05 b0 52 00 00       	add    $0x52b0,%eax
  80071c:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800721:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800725:	7e 0a                	jle    800731 <libmain+0x65>
		binaryname = argv[0];
  800727:	8b 45 0c             	mov    0xc(%ebp),%eax
  80072a:	8b 00                	mov    (%eax),%eax
  80072c:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800731:	83 ec 08             	sub    $0x8,%esp
  800734:	ff 75 0c             	pushl  0xc(%ebp)
  800737:	ff 75 08             	pushl  0x8(%ebp)
  80073a:	e8 f9 f8 ff ff       	call   800038 <_main>
  80073f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800742:	e8 1d 16 00 00       	call   801d64 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800747:	83 ec 0c             	sub    $0xc,%esp
  80074a:	68 c8 25 80 00       	push   $0x8025c8
  80074f:	e8 54 03 00 00       	call   800aa8 <cprintf>
  800754:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800757:	a1 24 30 80 00       	mov    0x803024,%eax
  80075c:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  800762:	a1 24 30 80 00       	mov    0x803024,%eax
  800767:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  80076d:	83 ec 04             	sub    $0x4,%esp
  800770:	52                   	push   %edx
  800771:	50                   	push   %eax
  800772:	68 f0 25 80 00       	push   $0x8025f0
  800777:	e8 2c 03 00 00       	call   800aa8 <cprintf>
  80077c:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80077f:	a1 24 30 80 00       	mov    0x803024,%eax
  800784:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  80078a:	a1 24 30 80 00       	mov    0x803024,%eax
  80078f:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  800795:	a1 24 30 80 00       	mov    0x803024,%eax
  80079a:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  8007a0:	51                   	push   %ecx
  8007a1:	52                   	push   %edx
  8007a2:	50                   	push   %eax
  8007a3:	68 18 26 80 00       	push   $0x802618
  8007a8:	e8 fb 02 00 00       	call   800aa8 <cprintf>
  8007ad:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8007b0:	83 ec 0c             	sub    $0xc,%esp
  8007b3:	68 c8 25 80 00       	push   $0x8025c8
  8007b8:	e8 eb 02 00 00       	call   800aa8 <cprintf>
  8007bd:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007c0:	e8 b9 15 00 00       	call   801d7e <sys_enable_interrupt>

	// exit gracefully
	exit();
  8007c5:	e8 19 00 00 00       	call   8007e3 <exit>
}
  8007ca:	90                   	nop
  8007cb:	c9                   	leave  
  8007cc:	c3                   	ret    

008007cd <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8007cd:	55                   	push   %ebp
  8007ce:	89 e5                	mov    %esp,%ebp
  8007d0:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8007d3:	83 ec 0c             	sub    $0xc,%esp
  8007d6:	6a 00                	push   $0x0
  8007d8:	e8 b8 13 00 00       	call   801b95 <sys_env_destroy>
  8007dd:	83 c4 10             	add    $0x10,%esp
}
  8007e0:	90                   	nop
  8007e1:	c9                   	leave  
  8007e2:	c3                   	ret    

008007e3 <exit>:

void
exit(void)
{
  8007e3:	55                   	push   %ebp
  8007e4:	89 e5                	mov    %esp,%ebp
  8007e6:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8007e9:	e8 0d 14 00 00       	call   801bfb <sys_env_exit>
}
  8007ee:	90                   	nop
  8007ef:	c9                   	leave  
  8007f0:	c3                   	ret    

008007f1 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8007f1:	55                   	push   %ebp
  8007f2:	89 e5                	mov    %esp,%ebp
  8007f4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8007f7:	8d 45 10             	lea    0x10(%ebp),%eax
  8007fa:	83 c0 04             	add    $0x4,%eax
  8007fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800800:	a1 18 31 80 00       	mov    0x803118,%eax
  800805:	85 c0                	test   %eax,%eax
  800807:	74 16                	je     80081f <_panic+0x2e>
		cprintf("%s: ", argv0);
  800809:	a1 18 31 80 00       	mov    0x803118,%eax
  80080e:	83 ec 08             	sub    $0x8,%esp
  800811:	50                   	push   %eax
  800812:	68 70 26 80 00       	push   $0x802670
  800817:	e8 8c 02 00 00       	call   800aa8 <cprintf>
  80081c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80081f:	a1 00 30 80 00       	mov    0x803000,%eax
  800824:	ff 75 0c             	pushl  0xc(%ebp)
  800827:	ff 75 08             	pushl  0x8(%ebp)
  80082a:	50                   	push   %eax
  80082b:	68 75 26 80 00       	push   $0x802675
  800830:	e8 73 02 00 00       	call   800aa8 <cprintf>
  800835:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800838:	8b 45 10             	mov    0x10(%ebp),%eax
  80083b:	83 ec 08             	sub    $0x8,%esp
  80083e:	ff 75 f4             	pushl  -0xc(%ebp)
  800841:	50                   	push   %eax
  800842:	e8 f6 01 00 00       	call   800a3d <vcprintf>
  800847:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80084a:	83 ec 08             	sub    $0x8,%esp
  80084d:	6a 00                	push   $0x0
  80084f:	68 91 26 80 00       	push   $0x802691
  800854:	e8 e4 01 00 00       	call   800a3d <vcprintf>
  800859:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80085c:	e8 82 ff ff ff       	call   8007e3 <exit>

	// should not return here
	while (1) ;
  800861:	eb fe                	jmp    800861 <_panic+0x70>

00800863 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800863:	55                   	push   %ebp
  800864:	89 e5                	mov    %esp,%ebp
  800866:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800869:	a1 24 30 80 00       	mov    0x803024,%eax
  80086e:	8b 50 74             	mov    0x74(%eax),%edx
  800871:	8b 45 0c             	mov    0xc(%ebp),%eax
  800874:	39 c2                	cmp    %eax,%edx
  800876:	74 14                	je     80088c <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800878:	83 ec 04             	sub    $0x4,%esp
  80087b:	68 94 26 80 00       	push   $0x802694
  800880:	6a 26                	push   $0x26
  800882:	68 e0 26 80 00       	push   $0x8026e0
  800887:	e8 65 ff ff ff       	call   8007f1 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80088c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800893:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80089a:	e9 c4 00 00 00       	jmp    800963 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  80089f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008a2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8008a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ac:	01 d0                	add    %edx,%eax
  8008ae:	8b 00                	mov    (%eax),%eax
  8008b0:	85 c0                	test   %eax,%eax
  8008b2:	75 08                	jne    8008bc <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8008b4:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8008b7:	e9 a4 00 00 00       	jmp    800960 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8008bc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008c3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8008ca:	eb 6b                	jmp    800937 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8008cc:	a1 24 30 80 00       	mov    0x803024,%eax
  8008d1:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8008d7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008da:	89 d0                	mov    %edx,%eax
  8008dc:	c1 e0 02             	shl    $0x2,%eax
  8008df:	01 d0                	add    %edx,%eax
  8008e1:	c1 e0 02             	shl    $0x2,%eax
  8008e4:	01 c8                	add    %ecx,%eax
  8008e6:	8a 40 04             	mov    0x4(%eax),%al
  8008e9:	84 c0                	test   %al,%al
  8008eb:	75 47                	jne    800934 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008ed:	a1 24 30 80 00       	mov    0x803024,%eax
  8008f2:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8008f8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008fb:	89 d0                	mov    %edx,%eax
  8008fd:	c1 e0 02             	shl    $0x2,%eax
  800900:	01 d0                	add    %edx,%eax
  800902:	c1 e0 02             	shl    $0x2,%eax
  800905:	01 c8                	add    %ecx,%eax
  800907:	8b 00                	mov    (%eax),%eax
  800909:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80090c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80090f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800914:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800916:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800919:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800920:	8b 45 08             	mov    0x8(%ebp),%eax
  800923:	01 c8                	add    %ecx,%eax
  800925:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800927:	39 c2                	cmp    %eax,%edx
  800929:	75 09                	jne    800934 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  80092b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800932:	eb 12                	jmp    800946 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800934:	ff 45 e8             	incl   -0x18(%ebp)
  800937:	a1 24 30 80 00       	mov    0x803024,%eax
  80093c:	8b 50 74             	mov    0x74(%eax),%edx
  80093f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800942:	39 c2                	cmp    %eax,%edx
  800944:	77 86                	ja     8008cc <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800946:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80094a:	75 14                	jne    800960 <CheckWSWithoutLastIndex+0xfd>
			panic(
  80094c:	83 ec 04             	sub    $0x4,%esp
  80094f:	68 ec 26 80 00       	push   $0x8026ec
  800954:	6a 3a                	push   $0x3a
  800956:	68 e0 26 80 00       	push   $0x8026e0
  80095b:	e8 91 fe ff ff       	call   8007f1 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800960:	ff 45 f0             	incl   -0x10(%ebp)
  800963:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800966:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800969:	0f 8c 30 ff ff ff    	jl     80089f <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80096f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800976:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80097d:	eb 27                	jmp    8009a6 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80097f:	a1 24 30 80 00       	mov    0x803024,%eax
  800984:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  80098a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80098d:	89 d0                	mov    %edx,%eax
  80098f:	c1 e0 02             	shl    $0x2,%eax
  800992:	01 d0                	add    %edx,%eax
  800994:	c1 e0 02             	shl    $0x2,%eax
  800997:	01 c8                	add    %ecx,%eax
  800999:	8a 40 04             	mov    0x4(%eax),%al
  80099c:	3c 01                	cmp    $0x1,%al
  80099e:	75 03                	jne    8009a3 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  8009a0:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009a3:	ff 45 e0             	incl   -0x20(%ebp)
  8009a6:	a1 24 30 80 00       	mov    0x803024,%eax
  8009ab:	8b 50 74             	mov    0x74(%eax),%edx
  8009ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009b1:	39 c2                	cmp    %eax,%edx
  8009b3:	77 ca                	ja     80097f <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8009b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009b8:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8009bb:	74 14                	je     8009d1 <CheckWSWithoutLastIndex+0x16e>
		panic(
  8009bd:	83 ec 04             	sub    $0x4,%esp
  8009c0:	68 40 27 80 00       	push   $0x802740
  8009c5:	6a 44                	push   $0x44
  8009c7:	68 e0 26 80 00       	push   $0x8026e0
  8009cc:	e8 20 fe ff ff       	call   8007f1 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8009d1:	90                   	nop
  8009d2:	c9                   	leave  
  8009d3:	c3                   	ret    

008009d4 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8009d4:	55                   	push   %ebp
  8009d5:	89 e5                	mov    %esp,%ebp
  8009d7:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8009da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009dd:	8b 00                	mov    (%eax),%eax
  8009df:	8d 48 01             	lea    0x1(%eax),%ecx
  8009e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009e5:	89 0a                	mov    %ecx,(%edx)
  8009e7:	8b 55 08             	mov    0x8(%ebp),%edx
  8009ea:	88 d1                	mov    %dl,%cl
  8009ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009ef:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f6:	8b 00                	mov    (%eax),%eax
  8009f8:	3d ff 00 00 00       	cmp    $0xff,%eax
  8009fd:	75 2c                	jne    800a2b <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8009ff:	a0 28 30 80 00       	mov    0x803028,%al
  800a04:	0f b6 c0             	movzbl %al,%eax
  800a07:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a0a:	8b 12                	mov    (%edx),%edx
  800a0c:	89 d1                	mov    %edx,%ecx
  800a0e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a11:	83 c2 08             	add    $0x8,%edx
  800a14:	83 ec 04             	sub    $0x4,%esp
  800a17:	50                   	push   %eax
  800a18:	51                   	push   %ecx
  800a19:	52                   	push   %edx
  800a1a:	e8 34 11 00 00       	call   801b53 <sys_cputs>
  800a1f:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a25:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a2e:	8b 40 04             	mov    0x4(%eax),%eax
  800a31:	8d 50 01             	lea    0x1(%eax),%edx
  800a34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a37:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a3a:	90                   	nop
  800a3b:	c9                   	leave  
  800a3c:	c3                   	ret    

00800a3d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a3d:	55                   	push   %ebp
  800a3e:	89 e5                	mov    %esp,%ebp
  800a40:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a46:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a4d:	00 00 00 
	b.cnt = 0;
  800a50:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a57:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a5a:	ff 75 0c             	pushl  0xc(%ebp)
  800a5d:	ff 75 08             	pushl  0x8(%ebp)
  800a60:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a66:	50                   	push   %eax
  800a67:	68 d4 09 80 00       	push   $0x8009d4
  800a6c:	e8 11 02 00 00       	call   800c82 <vprintfmt>
  800a71:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a74:	a0 28 30 80 00       	mov    0x803028,%al
  800a79:	0f b6 c0             	movzbl %al,%eax
  800a7c:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a82:	83 ec 04             	sub    $0x4,%esp
  800a85:	50                   	push   %eax
  800a86:	52                   	push   %edx
  800a87:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a8d:	83 c0 08             	add    $0x8,%eax
  800a90:	50                   	push   %eax
  800a91:	e8 bd 10 00 00       	call   801b53 <sys_cputs>
  800a96:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a99:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800aa0:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800aa6:	c9                   	leave  
  800aa7:	c3                   	ret    

00800aa8 <cprintf>:

int cprintf(const char *fmt, ...) {
  800aa8:	55                   	push   %ebp
  800aa9:	89 e5                	mov    %esp,%ebp
  800aab:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800aae:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800ab5:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ab8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800abb:	8b 45 08             	mov    0x8(%ebp),%eax
  800abe:	83 ec 08             	sub    $0x8,%esp
  800ac1:	ff 75 f4             	pushl  -0xc(%ebp)
  800ac4:	50                   	push   %eax
  800ac5:	e8 73 ff ff ff       	call   800a3d <vcprintf>
  800aca:	83 c4 10             	add    $0x10,%esp
  800acd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800ad0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ad3:	c9                   	leave  
  800ad4:	c3                   	ret    

00800ad5 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ad5:	55                   	push   %ebp
  800ad6:	89 e5                	mov    %esp,%ebp
  800ad8:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800adb:	e8 84 12 00 00       	call   801d64 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800ae0:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ae3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae9:	83 ec 08             	sub    $0x8,%esp
  800aec:	ff 75 f4             	pushl  -0xc(%ebp)
  800aef:	50                   	push   %eax
  800af0:	e8 48 ff ff ff       	call   800a3d <vcprintf>
  800af5:	83 c4 10             	add    $0x10,%esp
  800af8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800afb:	e8 7e 12 00 00       	call   801d7e <sys_enable_interrupt>
	return cnt;
  800b00:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b03:	c9                   	leave  
  800b04:	c3                   	ret    

00800b05 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800b05:	55                   	push   %ebp
  800b06:	89 e5                	mov    %esp,%ebp
  800b08:	53                   	push   %ebx
  800b09:	83 ec 14             	sub    $0x14,%esp
  800b0c:	8b 45 10             	mov    0x10(%ebp),%eax
  800b0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b12:	8b 45 14             	mov    0x14(%ebp),%eax
  800b15:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800b18:	8b 45 18             	mov    0x18(%ebp),%eax
  800b1b:	ba 00 00 00 00       	mov    $0x0,%edx
  800b20:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b23:	77 55                	ja     800b7a <printnum+0x75>
  800b25:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b28:	72 05                	jb     800b2f <printnum+0x2a>
  800b2a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b2d:	77 4b                	ja     800b7a <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800b2f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b32:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800b35:	8b 45 18             	mov    0x18(%ebp),%eax
  800b38:	ba 00 00 00 00       	mov    $0x0,%edx
  800b3d:	52                   	push   %edx
  800b3e:	50                   	push   %eax
  800b3f:	ff 75 f4             	pushl  -0xc(%ebp)
  800b42:	ff 75 f0             	pushl  -0x10(%ebp)
  800b45:	e8 5a 16 00 00       	call   8021a4 <__udivdi3>
  800b4a:	83 c4 10             	add    $0x10,%esp
  800b4d:	83 ec 04             	sub    $0x4,%esp
  800b50:	ff 75 20             	pushl  0x20(%ebp)
  800b53:	53                   	push   %ebx
  800b54:	ff 75 18             	pushl  0x18(%ebp)
  800b57:	52                   	push   %edx
  800b58:	50                   	push   %eax
  800b59:	ff 75 0c             	pushl  0xc(%ebp)
  800b5c:	ff 75 08             	pushl  0x8(%ebp)
  800b5f:	e8 a1 ff ff ff       	call   800b05 <printnum>
  800b64:	83 c4 20             	add    $0x20,%esp
  800b67:	eb 1a                	jmp    800b83 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b69:	83 ec 08             	sub    $0x8,%esp
  800b6c:	ff 75 0c             	pushl  0xc(%ebp)
  800b6f:	ff 75 20             	pushl  0x20(%ebp)
  800b72:	8b 45 08             	mov    0x8(%ebp),%eax
  800b75:	ff d0                	call   *%eax
  800b77:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b7a:	ff 4d 1c             	decl   0x1c(%ebp)
  800b7d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b81:	7f e6                	jg     800b69 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b83:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b86:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b8e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b91:	53                   	push   %ebx
  800b92:	51                   	push   %ecx
  800b93:	52                   	push   %edx
  800b94:	50                   	push   %eax
  800b95:	e8 1a 17 00 00       	call   8022b4 <__umoddi3>
  800b9a:	83 c4 10             	add    $0x10,%esp
  800b9d:	05 b4 29 80 00       	add    $0x8029b4,%eax
  800ba2:	8a 00                	mov    (%eax),%al
  800ba4:	0f be c0             	movsbl %al,%eax
  800ba7:	83 ec 08             	sub    $0x8,%esp
  800baa:	ff 75 0c             	pushl  0xc(%ebp)
  800bad:	50                   	push   %eax
  800bae:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb1:	ff d0                	call   *%eax
  800bb3:	83 c4 10             	add    $0x10,%esp
}
  800bb6:	90                   	nop
  800bb7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800bba:	c9                   	leave  
  800bbb:	c3                   	ret    

00800bbc <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800bbc:	55                   	push   %ebp
  800bbd:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800bbf:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bc3:	7e 1c                	jle    800be1 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800bc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc8:	8b 00                	mov    (%eax),%eax
  800bca:	8d 50 08             	lea    0x8(%eax),%edx
  800bcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd0:	89 10                	mov    %edx,(%eax)
  800bd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd5:	8b 00                	mov    (%eax),%eax
  800bd7:	83 e8 08             	sub    $0x8,%eax
  800bda:	8b 50 04             	mov    0x4(%eax),%edx
  800bdd:	8b 00                	mov    (%eax),%eax
  800bdf:	eb 40                	jmp    800c21 <getuint+0x65>
	else if (lflag)
  800be1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800be5:	74 1e                	je     800c05 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800be7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bea:	8b 00                	mov    (%eax),%eax
  800bec:	8d 50 04             	lea    0x4(%eax),%edx
  800bef:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf2:	89 10                	mov    %edx,(%eax)
  800bf4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf7:	8b 00                	mov    (%eax),%eax
  800bf9:	83 e8 04             	sub    $0x4,%eax
  800bfc:	8b 00                	mov    (%eax),%eax
  800bfe:	ba 00 00 00 00       	mov    $0x0,%edx
  800c03:	eb 1c                	jmp    800c21 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800c05:	8b 45 08             	mov    0x8(%ebp),%eax
  800c08:	8b 00                	mov    (%eax),%eax
  800c0a:	8d 50 04             	lea    0x4(%eax),%edx
  800c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c10:	89 10                	mov    %edx,(%eax)
  800c12:	8b 45 08             	mov    0x8(%ebp),%eax
  800c15:	8b 00                	mov    (%eax),%eax
  800c17:	83 e8 04             	sub    $0x4,%eax
  800c1a:	8b 00                	mov    (%eax),%eax
  800c1c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800c21:	5d                   	pop    %ebp
  800c22:	c3                   	ret    

00800c23 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800c23:	55                   	push   %ebp
  800c24:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c26:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c2a:	7e 1c                	jle    800c48 <getint+0x25>
		return va_arg(*ap, long long);
  800c2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2f:	8b 00                	mov    (%eax),%eax
  800c31:	8d 50 08             	lea    0x8(%eax),%edx
  800c34:	8b 45 08             	mov    0x8(%ebp),%eax
  800c37:	89 10                	mov    %edx,(%eax)
  800c39:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3c:	8b 00                	mov    (%eax),%eax
  800c3e:	83 e8 08             	sub    $0x8,%eax
  800c41:	8b 50 04             	mov    0x4(%eax),%edx
  800c44:	8b 00                	mov    (%eax),%eax
  800c46:	eb 38                	jmp    800c80 <getint+0x5d>
	else if (lflag)
  800c48:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c4c:	74 1a                	je     800c68 <getint+0x45>
		return va_arg(*ap, long);
  800c4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c51:	8b 00                	mov    (%eax),%eax
  800c53:	8d 50 04             	lea    0x4(%eax),%edx
  800c56:	8b 45 08             	mov    0x8(%ebp),%eax
  800c59:	89 10                	mov    %edx,(%eax)
  800c5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5e:	8b 00                	mov    (%eax),%eax
  800c60:	83 e8 04             	sub    $0x4,%eax
  800c63:	8b 00                	mov    (%eax),%eax
  800c65:	99                   	cltd   
  800c66:	eb 18                	jmp    800c80 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c68:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6b:	8b 00                	mov    (%eax),%eax
  800c6d:	8d 50 04             	lea    0x4(%eax),%edx
  800c70:	8b 45 08             	mov    0x8(%ebp),%eax
  800c73:	89 10                	mov    %edx,(%eax)
  800c75:	8b 45 08             	mov    0x8(%ebp),%eax
  800c78:	8b 00                	mov    (%eax),%eax
  800c7a:	83 e8 04             	sub    $0x4,%eax
  800c7d:	8b 00                	mov    (%eax),%eax
  800c7f:	99                   	cltd   
}
  800c80:	5d                   	pop    %ebp
  800c81:	c3                   	ret    

00800c82 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c82:	55                   	push   %ebp
  800c83:	89 e5                	mov    %esp,%ebp
  800c85:	56                   	push   %esi
  800c86:	53                   	push   %ebx
  800c87:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c8a:	eb 17                	jmp    800ca3 <vprintfmt+0x21>
			if (ch == '\0')
  800c8c:	85 db                	test   %ebx,%ebx
  800c8e:	0f 84 af 03 00 00    	je     801043 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c94:	83 ec 08             	sub    $0x8,%esp
  800c97:	ff 75 0c             	pushl  0xc(%ebp)
  800c9a:	53                   	push   %ebx
  800c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9e:	ff d0                	call   *%eax
  800ca0:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ca3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca6:	8d 50 01             	lea    0x1(%eax),%edx
  800ca9:	89 55 10             	mov    %edx,0x10(%ebp)
  800cac:	8a 00                	mov    (%eax),%al
  800cae:	0f b6 d8             	movzbl %al,%ebx
  800cb1:	83 fb 25             	cmp    $0x25,%ebx
  800cb4:	75 d6                	jne    800c8c <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800cb6:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800cba:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800cc1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800cc8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800ccf:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800cd6:	8b 45 10             	mov    0x10(%ebp),%eax
  800cd9:	8d 50 01             	lea    0x1(%eax),%edx
  800cdc:	89 55 10             	mov    %edx,0x10(%ebp)
  800cdf:	8a 00                	mov    (%eax),%al
  800ce1:	0f b6 d8             	movzbl %al,%ebx
  800ce4:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800ce7:	83 f8 55             	cmp    $0x55,%eax
  800cea:	0f 87 2b 03 00 00    	ja     80101b <vprintfmt+0x399>
  800cf0:	8b 04 85 d8 29 80 00 	mov    0x8029d8(,%eax,4),%eax
  800cf7:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800cf9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800cfd:	eb d7                	jmp    800cd6 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800cff:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800d03:	eb d1                	jmp    800cd6 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d05:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800d0c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d0f:	89 d0                	mov    %edx,%eax
  800d11:	c1 e0 02             	shl    $0x2,%eax
  800d14:	01 d0                	add    %edx,%eax
  800d16:	01 c0                	add    %eax,%eax
  800d18:	01 d8                	add    %ebx,%eax
  800d1a:	83 e8 30             	sub    $0x30,%eax
  800d1d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800d20:	8b 45 10             	mov    0x10(%ebp),%eax
  800d23:	8a 00                	mov    (%eax),%al
  800d25:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800d28:	83 fb 2f             	cmp    $0x2f,%ebx
  800d2b:	7e 3e                	jle    800d6b <vprintfmt+0xe9>
  800d2d:	83 fb 39             	cmp    $0x39,%ebx
  800d30:	7f 39                	jg     800d6b <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d32:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800d35:	eb d5                	jmp    800d0c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800d37:	8b 45 14             	mov    0x14(%ebp),%eax
  800d3a:	83 c0 04             	add    $0x4,%eax
  800d3d:	89 45 14             	mov    %eax,0x14(%ebp)
  800d40:	8b 45 14             	mov    0x14(%ebp),%eax
  800d43:	83 e8 04             	sub    $0x4,%eax
  800d46:	8b 00                	mov    (%eax),%eax
  800d48:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d4b:	eb 1f                	jmp    800d6c <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d4d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d51:	79 83                	jns    800cd6 <vprintfmt+0x54>
				width = 0;
  800d53:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d5a:	e9 77 ff ff ff       	jmp    800cd6 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d5f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d66:	e9 6b ff ff ff       	jmp    800cd6 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d6b:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d6c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d70:	0f 89 60 ff ff ff    	jns    800cd6 <vprintfmt+0x54>
				width = precision, precision = -1;
  800d76:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d79:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d7c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d83:	e9 4e ff ff ff       	jmp    800cd6 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d88:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d8b:	e9 46 ff ff ff       	jmp    800cd6 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d90:	8b 45 14             	mov    0x14(%ebp),%eax
  800d93:	83 c0 04             	add    $0x4,%eax
  800d96:	89 45 14             	mov    %eax,0x14(%ebp)
  800d99:	8b 45 14             	mov    0x14(%ebp),%eax
  800d9c:	83 e8 04             	sub    $0x4,%eax
  800d9f:	8b 00                	mov    (%eax),%eax
  800da1:	83 ec 08             	sub    $0x8,%esp
  800da4:	ff 75 0c             	pushl  0xc(%ebp)
  800da7:	50                   	push   %eax
  800da8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dab:	ff d0                	call   *%eax
  800dad:	83 c4 10             	add    $0x10,%esp
			break;
  800db0:	e9 89 02 00 00       	jmp    80103e <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800db5:	8b 45 14             	mov    0x14(%ebp),%eax
  800db8:	83 c0 04             	add    $0x4,%eax
  800dbb:	89 45 14             	mov    %eax,0x14(%ebp)
  800dbe:	8b 45 14             	mov    0x14(%ebp),%eax
  800dc1:	83 e8 04             	sub    $0x4,%eax
  800dc4:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800dc6:	85 db                	test   %ebx,%ebx
  800dc8:	79 02                	jns    800dcc <vprintfmt+0x14a>
				err = -err;
  800dca:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800dcc:	83 fb 64             	cmp    $0x64,%ebx
  800dcf:	7f 0b                	jg     800ddc <vprintfmt+0x15a>
  800dd1:	8b 34 9d 20 28 80 00 	mov    0x802820(,%ebx,4),%esi
  800dd8:	85 f6                	test   %esi,%esi
  800dda:	75 19                	jne    800df5 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ddc:	53                   	push   %ebx
  800ddd:	68 c5 29 80 00       	push   $0x8029c5
  800de2:	ff 75 0c             	pushl  0xc(%ebp)
  800de5:	ff 75 08             	pushl  0x8(%ebp)
  800de8:	e8 5e 02 00 00       	call   80104b <printfmt>
  800ded:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800df0:	e9 49 02 00 00       	jmp    80103e <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800df5:	56                   	push   %esi
  800df6:	68 ce 29 80 00       	push   $0x8029ce
  800dfb:	ff 75 0c             	pushl  0xc(%ebp)
  800dfe:	ff 75 08             	pushl  0x8(%ebp)
  800e01:	e8 45 02 00 00       	call   80104b <printfmt>
  800e06:	83 c4 10             	add    $0x10,%esp
			break;
  800e09:	e9 30 02 00 00       	jmp    80103e <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800e0e:	8b 45 14             	mov    0x14(%ebp),%eax
  800e11:	83 c0 04             	add    $0x4,%eax
  800e14:	89 45 14             	mov    %eax,0x14(%ebp)
  800e17:	8b 45 14             	mov    0x14(%ebp),%eax
  800e1a:	83 e8 04             	sub    $0x4,%eax
  800e1d:	8b 30                	mov    (%eax),%esi
  800e1f:	85 f6                	test   %esi,%esi
  800e21:	75 05                	jne    800e28 <vprintfmt+0x1a6>
				p = "(null)";
  800e23:	be d1 29 80 00       	mov    $0x8029d1,%esi
			if (width > 0 && padc != '-')
  800e28:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e2c:	7e 6d                	jle    800e9b <vprintfmt+0x219>
  800e2e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800e32:	74 67                	je     800e9b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800e34:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e37:	83 ec 08             	sub    $0x8,%esp
  800e3a:	50                   	push   %eax
  800e3b:	56                   	push   %esi
  800e3c:	e8 12 05 00 00       	call   801353 <strnlen>
  800e41:	83 c4 10             	add    $0x10,%esp
  800e44:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e47:	eb 16                	jmp    800e5f <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e49:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e4d:	83 ec 08             	sub    $0x8,%esp
  800e50:	ff 75 0c             	pushl  0xc(%ebp)
  800e53:	50                   	push   %eax
  800e54:	8b 45 08             	mov    0x8(%ebp),%eax
  800e57:	ff d0                	call   *%eax
  800e59:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e5c:	ff 4d e4             	decl   -0x1c(%ebp)
  800e5f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e63:	7f e4                	jg     800e49 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e65:	eb 34                	jmp    800e9b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e67:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e6b:	74 1c                	je     800e89 <vprintfmt+0x207>
  800e6d:	83 fb 1f             	cmp    $0x1f,%ebx
  800e70:	7e 05                	jle    800e77 <vprintfmt+0x1f5>
  800e72:	83 fb 7e             	cmp    $0x7e,%ebx
  800e75:	7e 12                	jle    800e89 <vprintfmt+0x207>
					putch('?', putdat);
  800e77:	83 ec 08             	sub    $0x8,%esp
  800e7a:	ff 75 0c             	pushl  0xc(%ebp)
  800e7d:	6a 3f                	push   $0x3f
  800e7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e82:	ff d0                	call   *%eax
  800e84:	83 c4 10             	add    $0x10,%esp
  800e87:	eb 0f                	jmp    800e98 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e89:	83 ec 08             	sub    $0x8,%esp
  800e8c:	ff 75 0c             	pushl  0xc(%ebp)
  800e8f:	53                   	push   %ebx
  800e90:	8b 45 08             	mov    0x8(%ebp),%eax
  800e93:	ff d0                	call   *%eax
  800e95:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e98:	ff 4d e4             	decl   -0x1c(%ebp)
  800e9b:	89 f0                	mov    %esi,%eax
  800e9d:	8d 70 01             	lea    0x1(%eax),%esi
  800ea0:	8a 00                	mov    (%eax),%al
  800ea2:	0f be d8             	movsbl %al,%ebx
  800ea5:	85 db                	test   %ebx,%ebx
  800ea7:	74 24                	je     800ecd <vprintfmt+0x24b>
  800ea9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ead:	78 b8                	js     800e67 <vprintfmt+0x1e5>
  800eaf:	ff 4d e0             	decl   -0x20(%ebp)
  800eb2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800eb6:	79 af                	jns    800e67 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800eb8:	eb 13                	jmp    800ecd <vprintfmt+0x24b>
				putch(' ', putdat);
  800eba:	83 ec 08             	sub    $0x8,%esp
  800ebd:	ff 75 0c             	pushl  0xc(%ebp)
  800ec0:	6a 20                	push   $0x20
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec5:	ff d0                	call   *%eax
  800ec7:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800eca:	ff 4d e4             	decl   -0x1c(%ebp)
  800ecd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ed1:	7f e7                	jg     800eba <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ed3:	e9 66 01 00 00       	jmp    80103e <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ed8:	83 ec 08             	sub    $0x8,%esp
  800edb:	ff 75 e8             	pushl  -0x18(%ebp)
  800ede:	8d 45 14             	lea    0x14(%ebp),%eax
  800ee1:	50                   	push   %eax
  800ee2:	e8 3c fd ff ff       	call   800c23 <getint>
  800ee7:	83 c4 10             	add    $0x10,%esp
  800eea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eed:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ef0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ef3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ef6:	85 d2                	test   %edx,%edx
  800ef8:	79 23                	jns    800f1d <vprintfmt+0x29b>
				putch('-', putdat);
  800efa:	83 ec 08             	sub    $0x8,%esp
  800efd:	ff 75 0c             	pushl  0xc(%ebp)
  800f00:	6a 2d                	push   $0x2d
  800f02:	8b 45 08             	mov    0x8(%ebp),%eax
  800f05:	ff d0                	call   *%eax
  800f07:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800f0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f0d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f10:	f7 d8                	neg    %eax
  800f12:	83 d2 00             	adc    $0x0,%edx
  800f15:	f7 da                	neg    %edx
  800f17:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f1a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800f1d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f24:	e9 bc 00 00 00       	jmp    800fe5 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800f29:	83 ec 08             	sub    $0x8,%esp
  800f2c:	ff 75 e8             	pushl  -0x18(%ebp)
  800f2f:	8d 45 14             	lea    0x14(%ebp),%eax
  800f32:	50                   	push   %eax
  800f33:	e8 84 fc ff ff       	call   800bbc <getuint>
  800f38:	83 c4 10             	add    $0x10,%esp
  800f3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f3e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f41:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f48:	e9 98 00 00 00       	jmp    800fe5 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f4d:	83 ec 08             	sub    $0x8,%esp
  800f50:	ff 75 0c             	pushl  0xc(%ebp)
  800f53:	6a 58                	push   $0x58
  800f55:	8b 45 08             	mov    0x8(%ebp),%eax
  800f58:	ff d0                	call   *%eax
  800f5a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f5d:	83 ec 08             	sub    $0x8,%esp
  800f60:	ff 75 0c             	pushl  0xc(%ebp)
  800f63:	6a 58                	push   $0x58
  800f65:	8b 45 08             	mov    0x8(%ebp),%eax
  800f68:	ff d0                	call   *%eax
  800f6a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f6d:	83 ec 08             	sub    $0x8,%esp
  800f70:	ff 75 0c             	pushl  0xc(%ebp)
  800f73:	6a 58                	push   $0x58
  800f75:	8b 45 08             	mov    0x8(%ebp),%eax
  800f78:	ff d0                	call   *%eax
  800f7a:	83 c4 10             	add    $0x10,%esp
			break;
  800f7d:	e9 bc 00 00 00       	jmp    80103e <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f82:	83 ec 08             	sub    $0x8,%esp
  800f85:	ff 75 0c             	pushl  0xc(%ebp)
  800f88:	6a 30                	push   $0x30
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	ff d0                	call   *%eax
  800f8f:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f92:	83 ec 08             	sub    $0x8,%esp
  800f95:	ff 75 0c             	pushl  0xc(%ebp)
  800f98:	6a 78                	push   $0x78
  800f9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9d:	ff d0                	call   *%eax
  800f9f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800fa2:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa5:	83 c0 04             	add    $0x4,%eax
  800fa8:	89 45 14             	mov    %eax,0x14(%ebp)
  800fab:	8b 45 14             	mov    0x14(%ebp),%eax
  800fae:	83 e8 04             	sub    $0x4,%eax
  800fb1:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800fb3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fb6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800fbd:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800fc4:	eb 1f                	jmp    800fe5 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800fc6:	83 ec 08             	sub    $0x8,%esp
  800fc9:	ff 75 e8             	pushl  -0x18(%ebp)
  800fcc:	8d 45 14             	lea    0x14(%ebp),%eax
  800fcf:	50                   	push   %eax
  800fd0:	e8 e7 fb ff ff       	call   800bbc <getuint>
  800fd5:	83 c4 10             	add    $0x10,%esp
  800fd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fdb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800fde:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800fe5:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800fe9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fec:	83 ec 04             	sub    $0x4,%esp
  800fef:	52                   	push   %edx
  800ff0:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ff3:	50                   	push   %eax
  800ff4:	ff 75 f4             	pushl  -0xc(%ebp)
  800ff7:	ff 75 f0             	pushl  -0x10(%ebp)
  800ffa:	ff 75 0c             	pushl  0xc(%ebp)
  800ffd:	ff 75 08             	pushl  0x8(%ebp)
  801000:	e8 00 fb ff ff       	call   800b05 <printnum>
  801005:	83 c4 20             	add    $0x20,%esp
			break;
  801008:	eb 34                	jmp    80103e <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80100a:	83 ec 08             	sub    $0x8,%esp
  80100d:	ff 75 0c             	pushl  0xc(%ebp)
  801010:	53                   	push   %ebx
  801011:	8b 45 08             	mov    0x8(%ebp),%eax
  801014:	ff d0                	call   *%eax
  801016:	83 c4 10             	add    $0x10,%esp
			break;
  801019:	eb 23                	jmp    80103e <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80101b:	83 ec 08             	sub    $0x8,%esp
  80101e:	ff 75 0c             	pushl  0xc(%ebp)
  801021:	6a 25                	push   $0x25
  801023:	8b 45 08             	mov    0x8(%ebp),%eax
  801026:	ff d0                	call   *%eax
  801028:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80102b:	ff 4d 10             	decl   0x10(%ebp)
  80102e:	eb 03                	jmp    801033 <vprintfmt+0x3b1>
  801030:	ff 4d 10             	decl   0x10(%ebp)
  801033:	8b 45 10             	mov    0x10(%ebp),%eax
  801036:	48                   	dec    %eax
  801037:	8a 00                	mov    (%eax),%al
  801039:	3c 25                	cmp    $0x25,%al
  80103b:	75 f3                	jne    801030 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80103d:	90                   	nop
		}
	}
  80103e:	e9 47 fc ff ff       	jmp    800c8a <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801043:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801044:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801047:	5b                   	pop    %ebx
  801048:	5e                   	pop    %esi
  801049:	5d                   	pop    %ebp
  80104a:	c3                   	ret    

0080104b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80104b:	55                   	push   %ebp
  80104c:	89 e5                	mov    %esp,%ebp
  80104e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801051:	8d 45 10             	lea    0x10(%ebp),%eax
  801054:	83 c0 04             	add    $0x4,%eax
  801057:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80105a:	8b 45 10             	mov    0x10(%ebp),%eax
  80105d:	ff 75 f4             	pushl  -0xc(%ebp)
  801060:	50                   	push   %eax
  801061:	ff 75 0c             	pushl  0xc(%ebp)
  801064:	ff 75 08             	pushl  0x8(%ebp)
  801067:	e8 16 fc ff ff       	call   800c82 <vprintfmt>
  80106c:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80106f:	90                   	nop
  801070:	c9                   	leave  
  801071:	c3                   	ret    

00801072 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801072:	55                   	push   %ebp
  801073:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801075:	8b 45 0c             	mov    0xc(%ebp),%eax
  801078:	8b 40 08             	mov    0x8(%eax),%eax
  80107b:	8d 50 01             	lea    0x1(%eax),%edx
  80107e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801081:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801084:	8b 45 0c             	mov    0xc(%ebp),%eax
  801087:	8b 10                	mov    (%eax),%edx
  801089:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108c:	8b 40 04             	mov    0x4(%eax),%eax
  80108f:	39 c2                	cmp    %eax,%edx
  801091:	73 12                	jae    8010a5 <sprintputch+0x33>
		*b->buf++ = ch;
  801093:	8b 45 0c             	mov    0xc(%ebp),%eax
  801096:	8b 00                	mov    (%eax),%eax
  801098:	8d 48 01             	lea    0x1(%eax),%ecx
  80109b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80109e:	89 0a                	mov    %ecx,(%edx)
  8010a0:	8b 55 08             	mov    0x8(%ebp),%edx
  8010a3:	88 10                	mov    %dl,(%eax)
}
  8010a5:	90                   	nop
  8010a6:	5d                   	pop    %ebp
  8010a7:	c3                   	ret    

008010a8 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8010a8:	55                   	push   %ebp
  8010a9:	89 e5                	mov    %esp,%ebp
  8010ab:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8010ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8010b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bd:	01 d0                	add    %edx,%eax
  8010bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8010c9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010cd:	74 06                	je     8010d5 <vsnprintf+0x2d>
  8010cf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010d3:	7f 07                	jg     8010dc <vsnprintf+0x34>
		return -E_INVAL;
  8010d5:	b8 03 00 00 00       	mov    $0x3,%eax
  8010da:	eb 20                	jmp    8010fc <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8010dc:	ff 75 14             	pushl  0x14(%ebp)
  8010df:	ff 75 10             	pushl  0x10(%ebp)
  8010e2:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8010e5:	50                   	push   %eax
  8010e6:	68 72 10 80 00       	push   $0x801072
  8010eb:	e8 92 fb ff ff       	call   800c82 <vprintfmt>
  8010f0:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010f6:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8010f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8010fc:	c9                   	leave  
  8010fd:	c3                   	ret    

008010fe <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8010fe:	55                   	push   %ebp
  8010ff:	89 e5                	mov    %esp,%ebp
  801101:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801104:	8d 45 10             	lea    0x10(%ebp),%eax
  801107:	83 c0 04             	add    $0x4,%eax
  80110a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80110d:	8b 45 10             	mov    0x10(%ebp),%eax
  801110:	ff 75 f4             	pushl  -0xc(%ebp)
  801113:	50                   	push   %eax
  801114:	ff 75 0c             	pushl  0xc(%ebp)
  801117:	ff 75 08             	pushl  0x8(%ebp)
  80111a:	e8 89 ff ff ff       	call   8010a8 <vsnprintf>
  80111f:	83 c4 10             	add    $0x10,%esp
  801122:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801125:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801128:	c9                   	leave  
  801129:	c3                   	ret    

0080112a <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80112a:	55                   	push   %ebp
  80112b:	89 e5                	mov    %esp,%ebp
  80112d:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801130:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801134:	74 13                	je     801149 <readline+0x1f>
		cprintf("%s", prompt);
  801136:	83 ec 08             	sub    $0x8,%esp
  801139:	ff 75 08             	pushl  0x8(%ebp)
  80113c:	68 30 2b 80 00       	push   $0x802b30
  801141:	e8 62 f9 ff ff       	call   800aa8 <cprintf>
  801146:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801149:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801150:	83 ec 0c             	sub    $0xc,%esp
  801153:	6a 00                	push   $0x0
  801155:	e8 68 f5 ff ff       	call   8006c2 <iscons>
  80115a:	83 c4 10             	add    $0x10,%esp
  80115d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801160:	e8 0f f5 ff ff       	call   800674 <getchar>
  801165:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801168:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80116c:	79 22                	jns    801190 <readline+0x66>
			if (c != -E_EOF)
  80116e:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801172:	0f 84 ad 00 00 00    	je     801225 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801178:	83 ec 08             	sub    $0x8,%esp
  80117b:	ff 75 ec             	pushl  -0x14(%ebp)
  80117e:	68 33 2b 80 00       	push   $0x802b33
  801183:	e8 20 f9 ff ff       	call   800aa8 <cprintf>
  801188:	83 c4 10             	add    $0x10,%esp
			return;
  80118b:	e9 95 00 00 00       	jmp    801225 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801190:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801194:	7e 34                	jle    8011ca <readline+0xa0>
  801196:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80119d:	7f 2b                	jg     8011ca <readline+0xa0>
			if (echoing)
  80119f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011a3:	74 0e                	je     8011b3 <readline+0x89>
				cputchar(c);
  8011a5:	83 ec 0c             	sub    $0xc,%esp
  8011a8:	ff 75 ec             	pushl  -0x14(%ebp)
  8011ab:	e8 7c f4 ff ff       	call   80062c <cputchar>
  8011b0:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011b6:	8d 50 01             	lea    0x1(%eax),%edx
  8011b9:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011bc:	89 c2                	mov    %eax,%edx
  8011be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c1:	01 d0                	add    %edx,%eax
  8011c3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011c6:	88 10                	mov    %dl,(%eax)
  8011c8:	eb 56                	jmp    801220 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8011ca:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011ce:	75 1f                	jne    8011ef <readline+0xc5>
  8011d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011d4:	7e 19                	jle    8011ef <readline+0xc5>
			if (echoing)
  8011d6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011da:	74 0e                	je     8011ea <readline+0xc0>
				cputchar(c);
  8011dc:	83 ec 0c             	sub    $0xc,%esp
  8011df:	ff 75 ec             	pushl  -0x14(%ebp)
  8011e2:	e8 45 f4 ff ff       	call   80062c <cputchar>
  8011e7:	83 c4 10             	add    $0x10,%esp

			i--;
  8011ea:	ff 4d f4             	decl   -0xc(%ebp)
  8011ed:	eb 31                	jmp    801220 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8011ef:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011f3:	74 0a                	je     8011ff <readline+0xd5>
  8011f5:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8011f9:	0f 85 61 ff ff ff    	jne    801160 <readline+0x36>
			if (echoing)
  8011ff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801203:	74 0e                	je     801213 <readline+0xe9>
				cputchar(c);
  801205:	83 ec 0c             	sub    $0xc,%esp
  801208:	ff 75 ec             	pushl  -0x14(%ebp)
  80120b:	e8 1c f4 ff ff       	call   80062c <cputchar>
  801210:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801213:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801216:	8b 45 0c             	mov    0xc(%ebp),%eax
  801219:	01 d0                	add    %edx,%eax
  80121b:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80121e:	eb 06                	jmp    801226 <readline+0xfc>
		}
	}
  801220:	e9 3b ff ff ff       	jmp    801160 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801225:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801226:	c9                   	leave  
  801227:	c3                   	ret    

00801228 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801228:	55                   	push   %ebp
  801229:	89 e5                	mov    %esp,%ebp
  80122b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80122e:	e8 31 0b 00 00       	call   801d64 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801233:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801237:	74 13                	je     80124c <atomic_readline+0x24>
		cprintf("%s", prompt);
  801239:	83 ec 08             	sub    $0x8,%esp
  80123c:	ff 75 08             	pushl  0x8(%ebp)
  80123f:	68 30 2b 80 00       	push   $0x802b30
  801244:	e8 5f f8 ff ff       	call   800aa8 <cprintf>
  801249:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80124c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801253:	83 ec 0c             	sub    $0xc,%esp
  801256:	6a 00                	push   $0x0
  801258:	e8 65 f4 ff ff       	call   8006c2 <iscons>
  80125d:	83 c4 10             	add    $0x10,%esp
  801260:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801263:	e8 0c f4 ff ff       	call   800674 <getchar>
  801268:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80126b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80126f:	79 23                	jns    801294 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801271:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801275:	74 13                	je     80128a <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801277:	83 ec 08             	sub    $0x8,%esp
  80127a:	ff 75 ec             	pushl  -0x14(%ebp)
  80127d:	68 33 2b 80 00       	push   $0x802b33
  801282:	e8 21 f8 ff ff       	call   800aa8 <cprintf>
  801287:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80128a:	e8 ef 0a 00 00       	call   801d7e <sys_enable_interrupt>
			return;
  80128f:	e9 9a 00 00 00       	jmp    80132e <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801294:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801298:	7e 34                	jle    8012ce <atomic_readline+0xa6>
  80129a:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8012a1:	7f 2b                	jg     8012ce <atomic_readline+0xa6>
			if (echoing)
  8012a3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012a7:	74 0e                	je     8012b7 <atomic_readline+0x8f>
				cputchar(c);
  8012a9:	83 ec 0c             	sub    $0xc,%esp
  8012ac:	ff 75 ec             	pushl  -0x14(%ebp)
  8012af:	e8 78 f3 ff ff       	call   80062c <cputchar>
  8012b4:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8012b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012ba:	8d 50 01             	lea    0x1(%eax),%edx
  8012bd:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8012c0:	89 c2                	mov    %eax,%edx
  8012c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c5:	01 d0                	add    %edx,%eax
  8012c7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012ca:	88 10                	mov    %dl,(%eax)
  8012cc:	eb 5b                	jmp    801329 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8012ce:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012d2:	75 1f                	jne    8012f3 <atomic_readline+0xcb>
  8012d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012d8:	7e 19                	jle    8012f3 <atomic_readline+0xcb>
			if (echoing)
  8012da:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012de:	74 0e                	je     8012ee <atomic_readline+0xc6>
				cputchar(c);
  8012e0:	83 ec 0c             	sub    $0xc,%esp
  8012e3:	ff 75 ec             	pushl  -0x14(%ebp)
  8012e6:	e8 41 f3 ff ff       	call   80062c <cputchar>
  8012eb:	83 c4 10             	add    $0x10,%esp
			i--;
  8012ee:	ff 4d f4             	decl   -0xc(%ebp)
  8012f1:	eb 36                	jmp    801329 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8012f3:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012f7:	74 0a                	je     801303 <atomic_readline+0xdb>
  8012f9:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012fd:	0f 85 60 ff ff ff    	jne    801263 <atomic_readline+0x3b>
			if (echoing)
  801303:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801307:	74 0e                	je     801317 <atomic_readline+0xef>
				cputchar(c);
  801309:	83 ec 0c             	sub    $0xc,%esp
  80130c:	ff 75 ec             	pushl  -0x14(%ebp)
  80130f:	e8 18 f3 ff ff       	call   80062c <cputchar>
  801314:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801317:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80131a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80131d:	01 d0                	add    %edx,%eax
  80131f:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801322:	e8 57 0a 00 00       	call   801d7e <sys_enable_interrupt>
			return;
  801327:	eb 05                	jmp    80132e <atomic_readline+0x106>
		}
	}
  801329:	e9 35 ff ff ff       	jmp    801263 <atomic_readline+0x3b>
}
  80132e:	c9                   	leave  
  80132f:	c3                   	ret    

00801330 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801330:	55                   	push   %ebp
  801331:	89 e5                	mov    %esp,%ebp
  801333:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801336:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80133d:	eb 06                	jmp    801345 <strlen+0x15>
		n++;
  80133f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801342:	ff 45 08             	incl   0x8(%ebp)
  801345:	8b 45 08             	mov    0x8(%ebp),%eax
  801348:	8a 00                	mov    (%eax),%al
  80134a:	84 c0                	test   %al,%al
  80134c:	75 f1                	jne    80133f <strlen+0xf>
		n++;
	return n;
  80134e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801351:	c9                   	leave  
  801352:	c3                   	ret    

00801353 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801353:	55                   	push   %ebp
  801354:	89 e5                	mov    %esp,%ebp
  801356:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801359:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801360:	eb 09                	jmp    80136b <strnlen+0x18>
		n++;
  801362:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801365:	ff 45 08             	incl   0x8(%ebp)
  801368:	ff 4d 0c             	decl   0xc(%ebp)
  80136b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80136f:	74 09                	je     80137a <strnlen+0x27>
  801371:	8b 45 08             	mov    0x8(%ebp),%eax
  801374:	8a 00                	mov    (%eax),%al
  801376:	84 c0                	test   %al,%al
  801378:	75 e8                	jne    801362 <strnlen+0xf>
		n++;
	return n;
  80137a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80137d:	c9                   	leave  
  80137e:	c3                   	ret    

0080137f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80137f:	55                   	push   %ebp
  801380:	89 e5                	mov    %esp,%ebp
  801382:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80138b:	90                   	nop
  80138c:	8b 45 08             	mov    0x8(%ebp),%eax
  80138f:	8d 50 01             	lea    0x1(%eax),%edx
  801392:	89 55 08             	mov    %edx,0x8(%ebp)
  801395:	8b 55 0c             	mov    0xc(%ebp),%edx
  801398:	8d 4a 01             	lea    0x1(%edx),%ecx
  80139b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80139e:	8a 12                	mov    (%edx),%dl
  8013a0:	88 10                	mov    %dl,(%eax)
  8013a2:	8a 00                	mov    (%eax),%al
  8013a4:	84 c0                	test   %al,%al
  8013a6:	75 e4                	jne    80138c <strcpy+0xd>
		/* do nothing */;
	return ret;
  8013a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013ab:	c9                   	leave  
  8013ac:	c3                   	ret    

008013ad <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8013ad:	55                   	push   %ebp
  8013ae:	89 e5                	mov    %esp,%ebp
  8013b0:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8013b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013c0:	eb 1f                	jmp    8013e1 <strncpy+0x34>
		*dst++ = *src;
  8013c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c5:	8d 50 01             	lea    0x1(%eax),%edx
  8013c8:	89 55 08             	mov    %edx,0x8(%ebp)
  8013cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ce:	8a 12                	mov    (%edx),%dl
  8013d0:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d5:	8a 00                	mov    (%eax),%al
  8013d7:	84 c0                	test   %al,%al
  8013d9:	74 03                	je     8013de <strncpy+0x31>
			src++;
  8013db:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013de:	ff 45 fc             	incl   -0x4(%ebp)
  8013e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013e4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013e7:	72 d9                	jb     8013c2 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013ec:	c9                   	leave  
  8013ed:	c3                   	ret    

008013ee <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013ee:	55                   	push   %ebp
  8013ef:	89 e5                	mov    %esp,%ebp
  8013f1:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8013fa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013fe:	74 30                	je     801430 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801400:	eb 16                	jmp    801418 <strlcpy+0x2a>
			*dst++ = *src++;
  801402:	8b 45 08             	mov    0x8(%ebp),%eax
  801405:	8d 50 01             	lea    0x1(%eax),%edx
  801408:	89 55 08             	mov    %edx,0x8(%ebp)
  80140b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80140e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801411:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801414:	8a 12                	mov    (%edx),%dl
  801416:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801418:	ff 4d 10             	decl   0x10(%ebp)
  80141b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80141f:	74 09                	je     80142a <strlcpy+0x3c>
  801421:	8b 45 0c             	mov    0xc(%ebp),%eax
  801424:	8a 00                	mov    (%eax),%al
  801426:	84 c0                	test   %al,%al
  801428:	75 d8                	jne    801402 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80142a:	8b 45 08             	mov    0x8(%ebp),%eax
  80142d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801430:	8b 55 08             	mov    0x8(%ebp),%edx
  801433:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801436:	29 c2                	sub    %eax,%edx
  801438:	89 d0                	mov    %edx,%eax
}
  80143a:	c9                   	leave  
  80143b:	c3                   	ret    

0080143c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80143c:	55                   	push   %ebp
  80143d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80143f:	eb 06                	jmp    801447 <strcmp+0xb>
		p++, q++;
  801441:	ff 45 08             	incl   0x8(%ebp)
  801444:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801447:	8b 45 08             	mov    0x8(%ebp),%eax
  80144a:	8a 00                	mov    (%eax),%al
  80144c:	84 c0                	test   %al,%al
  80144e:	74 0e                	je     80145e <strcmp+0x22>
  801450:	8b 45 08             	mov    0x8(%ebp),%eax
  801453:	8a 10                	mov    (%eax),%dl
  801455:	8b 45 0c             	mov    0xc(%ebp),%eax
  801458:	8a 00                	mov    (%eax),%al
  80145a:	38 c2                	cmp    %al,%dl
  80145c:	74 e3                	je     801441 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80145e:	8b 45 08             	mov    0x8(%ebp),%eax
  801461:	8a 00                	mov    (%eax),%al
  801463:	0f b6 d0             	movzbl %al,%edx
  801466:	8b 45 0c             	mov    0xc(%ebp),%eax
  801469:	8a 00                	mov    (%eax),%al
  80146b:	0f b6 c0             	movzbl %al,%eax
  80146e:	29 c2                	sub    %eax,%edx
  801470:	89 d0                	mov    %edx,%eax
}
  801472:	5d                   	pop    %ebp
  801473:	c3                   	ret    

00801474 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801474:	55                   	push   %ebp
  801475:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801477:	eb 09                	jmp    801482 <strncmp+0xe>
		n--, p++, q++;
  801479:	ff 4d 10             	decl   0x10(%ebp)
  80147c:	ff 45 08             	incl   0x8(%ebp)
  80147f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801482:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801486:	74 17                	je     80149f <strncmp+0x2b>
  801488:	8b 45 08             	mov    0x8(%ebp),%eax
  80148b:	8a 00                	mov    (%eax),%al
  80148d:	84 c0                	test   %al,%al
  80148f:	74 0e                	je     80149f <strncmp+0x2b>
  801491:	8b 45 08             	mov    0x8(%ebp),%eax
  801494:	8a 10                	mov    (%eax),%dl
  801496:	8b 45 0c             	mov    0xc(%ebp),%eax
  801499:	8a 00                	mov    (%eax),%al
  80149b:	38 c2                	cmp    %al,%dl
  80149d:	74 da                	je     801479 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80149f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014a3:	75 07                	jne    8014ac <strncmp+0x38>
		return 0;
  8014a5:	b8 00 00 00 00       	mov    $0x0,%eax
  8014aa:	eb 14                	jmp    8014c0 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8014ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8014af:	8a 00                	mov    (%eax),%al
  8014b1:	0f b6 d0             	movzbl %al,%edx
  8014b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b7:	8a 00                	mov    (%eax),%al
  8014b9:	0f b6 c0             	movzbl %al,%eax
  8014bc:	29 c2                	sub    %eax,%edx
  8014be:	89 d0                	mov    %edx,%eax
}
  8014c0:	5d                   	pop    %ebp
  8014c1:	c3                   	ret    

008014c2 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014c2:	55                   	push   %ebp
  8014c3:	89 e5                	mov    %esp,%ebp
  8014c5:	83 ec 04             	sub    $0x4,%esp
  8014c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014cb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014ce:	eb 12                	jmp    8014e2 <strchr+0x20>
		if (*s == c)
  8014d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d3:	8a 00                	mov    (%eax),%al
  8014d5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014d8:	75 05                	jne    8014df <strchr+0x1d>
			return (char *) s;
  8014da:	8b 45 08             	mov    0x8(%ebp),%eax
  8014dd:	eb 11                	jmp    8014f0 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014df:	ff 45 08             	incl   0x8(%ebp)
  8014e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e5:	8a 00                	mov    (%eax),%al
  8014e7:	84 c0                	test   %al,%al
  8014e9:	75 e5                	jne    8014d0 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014f0:	c9                   	leave  
  8014f1:	c3                   	ret    

008014f2 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014f2:	55                   	push   %ebp
  8014f3:	89 e5                	mov    %esp,%ebp
  8014f5:	83 ec 04             	sub    $0x4,%esp
  8014f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014fb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014fe:	eb 0d                	jmp    80150d <strfind+0x1b>
		if (*s == c)
  801500:	8b 45 08             	mov    0x8(%ebp),%eax
  801503:	8a 00                	mov    (%eax),%al
  801505:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801508:	74 0e                	je     801518 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80150a:	ff 45 08             	incl   0x8(%ebp)
  80150d:	8b 45 08             	mov    0x8(%ebp),%eax
  801510:	8a 00                	mov    (%eax),%al
  801512:	84 c0                	test   %al,%al
  801514:	75 ea                	jne    801500 <strfind+0xe>
  801516:	eb 01                	jmp    801519 <strfind+0x27>
		if (*s == c)
			break;
  801518:	90                   	nop
	return (char *) s;
  801519:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80151c:	c9                   	leave  
  80151d:	c3                   	ret    

0080151e <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80151e:	55                   	push   %ebp
  80151f:	89 e5                	mov    %esp,%ebp
  801521:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801524:	8b 45 08             	mov    0x8(%ebp),%eax
  801527:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80152a:	8b 45 10             	mov    0x10(%ebp),%eax
  80152d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801530:	eb 0e                	jmp    801540 <memset+0x22>
		*p++ = c;
  801532:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801535:	8d 50 01             	lea    0x1(%eax),%edx
  801538:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80153b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80153e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801540:	ff 4d f8             	decl   -0x8(%ebp)
  801543:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801547:	79 e9                	jns    801532 <memset+0x14>
		*p++ = c;

	return v;
  801549:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80154c:	c9                   	leave  
  80154d:	c3                   	ret    

0080154e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80154e:	55                   	push   %ebp
  80154f:	89 e5                	mov    %esp,%ebp
  801551:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801554:	8b 45 0c             	mov    0xc(%ebp),%eax
  801557:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80155a:	8b 45 08             	mov    0x8(%ebp),%eax
  80155d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801560:	eb 16                	jmp    801578 <memcpy+0x2a>
		*d++ = *s++;
  801562:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801565:	8d 50 01             	lea    0x1(%eax),%edx
  801568:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80156b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80156e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801571:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801574:	8a 12                	mov    (%edx),%dl
  801576:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801578:	8b 45 10             	mov    0x10(%ebp),%eax
  80157b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80157e:	89 55 10             	mov    %edx,0x10(%ebp)
  801581:	85 c0                	test   %eax,%eax
  801583:	75 dd                	jne    801562 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801585:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801588:	c9                   	leave  
  801589:	c3                   	ret    

0080158a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80158a:	55                   	push   %ebp
  80158b:	89 e5                	mov    %esp,%ebp
  80158d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801590:	8b 45 0c             	mov    0xc(%ebp),%eax
  801593:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801596:	8b 45 08             	mov    0x8(%ebp),%eax
  801599:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80159c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80159f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015a2:	73 50                	jae    8015f4 <memmove+0x6a>
  8015a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015aa:	01 d0                	add    %edx,%eax
  8015ac:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015af:	76 43                	jbe    8015f4 <memmove+0x6a>
		s += n;
  8015b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b4:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8015b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ba:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015bd:	eb 10                	jmp    8015cf <memmove+0x45>
			*--d = *--s;
  8015bf:	ff 4d f8             	decl   -0x8(%ebp)
  8015c2:	ff 4d fc             	decl   -0x4(%ebp)
  8015c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015c8:	8a 10                	mov    (%eax),%dl
  8015ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015cd:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8015cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015d5:	89 55 10             	mov    %edx,0x10(%ebp)
  8015d8:	85 c0                	test   %eax,%eax
  8015da:	75 e3                	jne    8015bf <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8015dc:	eb 23                	jmp    801601 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8015de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e1:	8d 50 01             	lea    0x1(%eax),%edx
  8015e4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015e7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015ea:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015ed:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015f0:	8a 12                	mov    (%edx),%dl
  8015f2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015fa:	89 55 10             	mov    %edx,0x10(%ebp)
  8015fd:	85 c0                	test   %eax,%eax
  8015ff:	75 dd                	jne    8015de <memmove+0x54>
			*d++ = *s++;

	return dst;
  801601:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801604:	c9                   	leave  
  801605:	c3                   	ret    

00801606 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801606:	55                   	push   %ebp
  801607:	89 e5                	mov    %esp,%ebp
  801609:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80160c:	8b 45 08             	mov    0x8(%ebp),%eax
  80160f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801612:	8b 45 0c             	mov    0xc(%ebp),%eax
  801615:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801618:	eb 2a                	jmp    801644 <memcmp+0x3e>
		if (*s1 != *s2)
  80161a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80161d:	8a 10                	mov    (%eax),%dl
  80161f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801622:	8a 00                	mov    (%eax),%al
  801624:	38 c2                	cmp    %al,%dl
  801626:	74 16                	je     80163e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801628:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80162b:	8a 00                	mov    (%eax),%al
  80162d:	0f b6 d0             	movzbl %al,%edx
  801630:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801633:	8a 00                	mov    (%eax),%al
  801635:	0f b6 c0             	movzbl %al,%eax
  801638:	29 c2                	sub    %eax,%edx
  80163a:	89 d0                	mov    %edx,%eax
  80163c:	eb 18                	jmp    801656 <memcmp+0x50>
		s1++, s2++;
  80163e:	ff 45 fc             	incl   -0x4(%ebp)
  801641:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801644:	8b 45 10             	mov    0x10(%ebp),%eax
  801647:	8d 50 ff             	lea    -0x1(%eax),%edx
  80164a:	89 55 10             	mov    %edx,0x10(%ebp)
  80164d:	85 c0                	test   %eax,%eax
  80164f:	75 c9                	jne    80161a <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801651:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801656:	c9                   	leave  
  801657:	c3                   	ret    

00801658 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801658:	55                   	push   %ebp
  801659:	89 e5                	mov    %esp,%ebp
  80165b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80165e:	8b 55 08             	mov    0x8(%ebp),%edx
  801661:	8b 45 10             	mov    0x10(%ebp),%eax
  801664:	01 d0                	add    %edx,%eax
  801666:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801669:	eb 15                	jmp    801680 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80166b:	8b 45 08             	mov    0x8(%ebp),%eax
  80166e:	8a 00                	mov    (%eax),%al
  801670:	0f b6 d0             	movzbl %al,%edx
  801673:	8b 45 0c             	mov    0xc(%ebp),%eax
  801676:	0f b6 c0             	movzbl %al,%eax
  801679:	39 c2                	cmp    %eax,%edx
  80167b:	74 0d                	je     80168a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80167d:	ff 45 08             	incl   0x8(%ebp)
  801680:	8b 45 08             	mov    0x8(%ebp),%eax
  801683:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801686:	72 e3                	jb     80166b <memfind+0x13>
  801688:	eb 01                	jmp    80168b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80168a:	90                   	nop
	return (void *) s;
  80168b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80168e:	c9                   	leave  
  80168f:	c3                   	ret    

00801690 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801690:	55                   	push   %ebp
  801691:	89 e5                	mov    %esp,%ebp
  801693:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801696:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80169d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016a4:	eb 03                	jmp    8016a9 <strtol+0x19>
		s++;
  8016a6:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ac:	8a 00                	mov    (%eax),%al
  8016ae:	3c 20                	cmp    $0x20,%al
  8016b0:	74 f4                	je     8016a6 <strtol+0x16>
  8016b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b5:	8a 00                	mov    (%eax),%al
  8016b7:	3c 09                	cmp    $0x9,%al
  8016b9:	74 eb                	je     8016a6 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8016bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016be:	8a 00                	mov    (%eax),%al
  8016c0:	3c 2b                	cmp    $0x2b,%al
  8016c2:	75 05                	jne    8016c9 <strtol+0x39>
		s++;
  8016c4:	ff 45 08             	incl   0x8(%ebp)
  8016c7:	eb 13                	jmp    8016dc <strtol+0x4c>
	else if (*s == '-')
  8016c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cc:	8a 00                	mov    (%eax),%al
  8016ce:	3c 2d                	cmp    $0x2d,%al
  8016d0:	75 0a                	jne    8016dc <strtol+0x4c>
		s++, neg = 1;
  8016d2:	ff 45 08             	incl   0x8(%ebp)
  8016d5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8016dc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016e0:	74 06                	je     8016e8 <strtol+0x58>
  8016e2:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8016e6:	75 20                	jne    801708 <strtol+0x78>
  8016e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016eb:	8a 00                	mov    (%eax),%al
  8016ed:	3c 30                	cmp    $0x30,%al
  8016ef:	75 17                	jne    801708 <strtol+0x78>
  8016f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f4:	40                   	inc    %eax
  8016f5:	8a 00                	mov    (%eax),%al
  8016f7:	3c 78                	cmp    $0x78,%al
  8016f9:	75 0d                	jne    801708 <strtol+0x78>
		s += 2, base = 16;
  8016fb:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8016ff:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801706:	eb 28                	jmp    801730 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801708:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80170c:	75 15                	jne    801723 <strtol+0x93>
  80170e:	8b 45 08             	mov    0x8(%ebp),%eax
  801711:	8a 00                	mov    (%eax),%al
  801713:	3c 30                	cmp    $0x30,%al
  801715:	75 0c                	jne    801723 <strtol+0x93>
		s++, base = 8;
  801717:	ff 45 08             	incl   0x8(%ebp)
  80171a:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801721:	eb 0d                	jmp    801730 <strtol+0xa0>
	else if (base == 0)
  801723:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801727:	75 07                	jne    801730 <strtol+0xa0>
		base = 10;
  801729:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801730:	8b 45 08             	mov    0x8(%ebp),%eax
  801733:	8a 00                	mov    (%eax),%al
  801735:	3c 2f                	cmp    $0x2f,%al
  801737:	7e 19                	jle    801752 <strtol+0xc2>
  801739:	8b 45 08             	mov    0x8(%ebp),%eax
  80173c:	8a 00                	mov    (%eax),%al
  80173e:	3c 39                	cmp    $0x39,%al
  801740:	7f 10                	jg     801752 <strtol+0xc2>
			dig = *s - '0';
  801742:	8b 45 08             	mov    0x8(%ebp),%eax
  801745:	8a 00                	mov    (%eax),%al
  801747:	0f be c0             	movsbl %al,%eax
  80174a:	83 e8 30             	sub    $0x30,%eax
  80174d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801750:	eb 42                	jmp    801794 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801752:	8b 45 08             	mov    0x8(%ebp),%eax
  801755:	8a 00                	mov    (%eax),%al
  801757:	3c 60                	cmp    $0x60,%al
  801759:	7e 19                	jle    801774 <strtol+0xe4>
  80175b:	8b 45 08             	mov    0x8(%ebp),%eax
  80175e:	8a 00                	mov    (%eax),%al
  801760:	3c 7a                	cmp    $0x7a,%al
  801762:	7f 10                	jg     801774 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801764:	8b 45 08             	mov    0x8(%ebp),%eax
  801767:	8a 00                	mov    (%eax),%al
  801769:	0f be c0             	movsbl %al,%eax
  80176c:	83 e8 57             	sub    $0x57,%eax
  80176f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801772:	eb 20                	jmp    801794 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801774:	8b 45 08             	mov    0x8(%ebp),%eax
  801777:	8a 00                	mov    (%eax),%al
  801779:	3c 40                	cmp    $0x40,%al
  80177b:	7e 39                	jle    8017b6 <strtol+0x126>
  80177d:	8b 45 08             	mov    0x8(%ebp),%eax
  801780:	8a 00                	mov    (%eax),%al
  801782:	3c 5a                	cmp    $0x5a,%al
  801784:	7f 30                	jg     8017b6 <strtol+0x126>
			dig = *s - 'A' + 10;
  801786:	8b 45 08             	mov    0x8(%ebp),%eax
  801789:	8a 00                	mov    (%eax),%al
  80178b:	0f be c0             	movsbl %al,%eax
  80178e:	83 e8 37             	sub    $0x37,%eax
  801791:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801794:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801797:	3b 45 10             	cmp    0x10(%ebp),%eax
  80179a:	7d 19                	jge    8017b5 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80179c:	ff 45 08             	incl   0x8(%ebp)
  80179f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017a2:	0f af 45 10          	imul   0x10(%ebp),%eax
  8017a6:	89 c2                	mov    %eax,%edx
  8017a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017ab:	01 d0                	add    %edx,%eax
  8017ad:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8017b0:	e9 7b ff ff ff       	jmp    801730 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8017b5:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8017b6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017ba:	74 08                	je     8017c4 <strtol+0x134>
		*endptr = (char *) s;
  8017bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017bf:	8b 55 08             	mov    0x8(%ebp),%edx
  8017c2:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8017c4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017c8:	74 07                	je     8017d1 <strtol+0x141>
  8017ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017cd:	f7 d8                	neg    %eax
  8017cf:	eb 03                	jmp    8017d4 <strtol+0x144>
  8017d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8017d4:	c9                   	leave  
  8017d5:	c3                   	ret    

008017d6 <ltostr>:

void
ltostr(long value, char *str)
{
  8017d6:	55                   	push   %ebp
  8017d7:	89 e5                	mov    %esp,%ebp
  8017d9:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8017dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8017e3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017ea:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017ee:	79 13                	jns    801803 <ltostr+0x2d>
	{
		neg = 1;
  8017f0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8017f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017fa:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8017fd:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801800:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801803:	8b 45 08             	mov    0x8(%ebp),%eax
  801806:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80180b:	99                   	cltd   
  80180c:	f7 f9                	idiv   %ecx
  80180e:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801811:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801814:	8d 50 01             	lea    0x1(%eax),%edx
  801817:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80181a:	89 c2                	mov    %eax,%edx
  80181c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80181f:	01 d0                	add    %edx,%eax
  801821:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801824:	83 c2 30             	add    $0x30,%edx
  801827:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801829:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80182c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801831:	f7 e9                	imul   %ecx
  801833:	c1 fa 02             	sar    $0x2,%edx
  801836:	89 c8                	mov    %ecx,%eax
  801838:	c1 f8 1f             	sar    $0x1f,%eax
  80183b:	29 c2                	sub    %eax,%edx
  80183d:	89 d0                	mov    %edx,%eax
  80183f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801842:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801845:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80184a:	f7 e9                	imul   %ecx
  80184c:	c1 fa 02             	sar    $0x2,%edx
  80184f:	89 c8                	mov    %ecx,%eax
  801851:	c1 f8 1f             	sar    $0x1f,%eax
  801854:	29 c2                	sub    %eax,%edx
  801856:	89 d0                	mov    %edx,%eax
  801858:	c1 e0 02             	shl    $0x2,%eax
  80185b:	01 d0                	add    %edx,%eax
  80185d:	01 c0                	add    %eax,%eax
  80185f:	29 c1                	sub    %eax,%ecx
  801861:	89 ca                	mov    %ecx,%edx
  801863:	85 d2                	test   %edx,%edx
  801865:	75 9c                	jne    801803 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801867:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80186e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801871:	48                   	dec    %eax
  801872:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801875:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801879:	74 3d                	je     8018b8 <ltostr+0xe2>
		start = 1 ;
  80187b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801882:	eb 34                	jmp    8018b8 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801884:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801887:	8b 45 0c             	mov    0xc(%ebp),%eax
  80188a:	01 d0                	add    %edx,%eax
  80188c:	8a 00                	mov    (%eax),%al
  80188e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801891:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801894:	8b 45 0c             	mov    0xc(%ebp),%eax
  801897:	01 c2                	add    %eax,%edx
  801899:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80189c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80189f:	01 c8                	add    %ecx,%eax
  8018a1:	8a 00                	mov    (%eax),%al
  8018a3:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8018a5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8018a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ab:	01 c2                	add    %eax,%edx
  8018ad:	8a 45 eb             	mov    -0x15(%ebp),%al
  8018b0:	88 02                	mov    %al,(%edx)
		start++ ;
  8018b2:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8018b5:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8018b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018bb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018be:	7c c4                	jl     801884 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8018c0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8018c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018c6:	01 d0                	add    %edx,%eax
  8018c8:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8018cb:	90                   	nop
  8018cc:	c9                   	leave  
  8018cd:	c3                   	ret    

008018ce <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8018ce:	55                   	push   %ebp
  8018cf:	89 e5                	mov    %esp,%ebp
  8018d1:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8018d4:	ff 75 08             	pushl  0x8(%ebp)
  8018d7:	e8 54 fa ff ff       	call   801330 <strlen>
  8018dc:	83 c4 04             	add    $0x4,%esp
  8018df:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8018e2:	ff 75 0c             	pushl  0xc(%ebp)
  8018e5:	e8 46 fa ff ff       	call   801330 <strlen>
  8018ea:	83 c4 04             	add    $0x4,%esp
  8018ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8018f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018fe:	eb 17                	jmp    801917 <strcconcat+0x49>
		final[s] = str1[s] ;
  801900:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801903:	8b 45 10             	mov    0x10(%ebp),%eax
  801906:	01 c2                	add    %eax,%edx
  801908:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80190b:	8b 45 08             	mov    0x8(%ebp),%eax
  80190e:	01 c8                	add    %ecx,%eax
  801910:	8a 00                	mov    (%eax),%al
  801912:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801914:	ff 45 fc             	incl   -0x4(%ebp)
  801917:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80191a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80191d:	7c e1                	jl     801900 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80191f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801926:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80192d:	eb 1f                	jmp    80194e <strcconcat+0x80>
		final[s++] = str2[i] ;
  80192f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801932:	8d 50 01             	lea    0x1(%eax),%edx
  801935:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801938:	89 c2                	mov    %eax,%edx
  80193a:	8b 45 10             	mov    0x10(%ebp),%eax
  80193d:	01 c2                	add    %eax,%edx
  80193f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801942:	8b 45 0c             	mov    0xc(%ebp),%eax
  801945:	01 c8                	add    %ecx,%eax
  801947:	8a 00                	mov    (%eax),%al
  801949:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80194b:	ff 45 f8             	incl   -0x8(%ebp)
  80194e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801951:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801954:	7c d9                	jl     80192f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801956:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801959:	8b 45 10             	mov    0x10(%ebp),%eax
  80195c:	01 d0                	add    %edx,%eax
  80195e:	c6 00 00             	movb   $0x0,(%eax)
}
  801961:	90                   	nop
  801962:	c9                   	leave  
  801963:	c3                   	ret    

00801964 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801964:	55                   	push   %ebp
  801965:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801967:	8b 45 14             	mov    0x14(%ebp),%eax
  80196a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801970:	8b 45 14             	mov    0x14(%ebp),%eax
  801973:	8b 00                	mov    (%eax),%eax
  801975:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80197c:	8b 45 10             	mov    0x10(%ebp),%eax
  80197f:	01 d0                	add    %edx,%eax
  801981:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801987:	eb 0c                	jmp    801995 <strsplit+0x31>
			*string++ = 0;
  801989:	8b 45 08             	mov    0x8(%ebp),%eax
  80198c:	8d 50 01             	lea    0x1(%eax),%edx
  80198f:	89 55 08             	mov    %edx,0x8(%ebp)
  801992:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801995:	8b 45 08             	mov    0x8(%ebp),%eax
  801998:	8a 00                	mov    (%eax),%al
  80199a:	84 c0                	test   %al,%al
  80199c:	74 18                	je     8019b6 <strsplit+0x52>
  80199e:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a1:	8a 00                	mov    (%eax),%al
  8019a3:	0f be c0             	movsbl %al,%eax
  8019a6:	50                   	push   %eax
  8019a7:	ff 75 0c             	pushl  0xc(%ebp)
  8019aa:	e8 13 fb ff ff       	call   8014c2 <strchr>
  8019af:	83 c4 08             	add    $0x8,%esp
  8019b2:	85 c0                	test   %eax,%eax
  8019b4:	75 d3                	jne    801989 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8019b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b9:	8a 00                	mov    (%eax),%al
  8019bb:	84 c0                	test   %al,%al
  8019bd:	74 5a                	je     801a19 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8019bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8019c2:	8b 00                	mov    (%eax),%eax
  8019c4:	83 f8 0f             	cmp    $0xf,%eax
  8019c7:	75 07                	jne    8019d0 <strsplit+0x6c>
		{
			return 0;
  8019c9:	b8 00 00 00 00       	mov    $0x0,%eax
  8019ce:	eb 66                	jmp    801a36 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8019d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8019d3:	8b 00                	mov    (%eax),%eax
  8019d5:	8d 48 01             	lea    0x1(%eax),%ecx
  8019d8:	8b 55 14             	mov    0x14(%ebp),%edx
  8019db:	89 0a                	mov    %ecx,(%edx)
  8019dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8019e7:	01 c2                	add    %eax,%edx
  8019e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ec:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019ee:	eb 03                	jmp    8019f3 <strsplit+0x8f>
			string++;
  8019f0:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f6:	8a 00                	mov    (%eax),%al
  8019f8:	84 c0                	test   %al,%al
  8019fa:	74 8b                	je     801987 <strsplit+0x23>
  8019fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ff:	8a 00                	mov    (%eax),%al
  801a01:	0f be c0             	movsbl %al,%eax
  801a04:	50                   	push   %eax
  801a05:	ff 75 0c             	pushl  0xc(%ebp)
  801a08:	e8 b5 fa ff ff       	call   8014c2 <strchr>
  801a0d:	83 c4 08             	add    $0x8,%esp
  801a10:	85 c0                	test   %eax,%eax
  801a12:	74 dc                	je     8019f0 <strsplit+0x8c>
			string++;
	}
  801a14:	e9 6e ff ff ff       	jmp    801987 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801a19:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801a1a:	8b 45 14             	mov    0x14(%ebp),%eax
  801a1d:	8b 00                	mov    (%eax),%eax
  801a1f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a26:	8b 45 10             	mov    0x10(%ebp),%eax
  801a29:	01 d0                	add    %edx,%eax
  801a2b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801a31:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a36:	c9                   	leave  
  801a37:	c3                   	ret    

00801a38 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801a38:	55                   	push   %ebp
  801a39:	89 e5                	mov    %esp,%ebp
  801a3b:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801a3e:	83 ec 04             	sub    $0x4,%esp
  801a41:	68 44 2b 80 00       	push   $0x802b44
  801a46:	6a 15                	push   $0x15
  801a48:	68 69 2b 80 00       	push   $0x802b69
  801a4d:	e8 9f ed ff ff       	call   8007f1 <_panic>

00801a52 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801a52:	55                   	push   %ebp
  801a53:	89 e5                	mov    %esp,%ebp
  801a55:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801a58:	83 ec 04             	sub    $0x4,%esp
  801a5b:	68 78 2b 80 00       	push   $0x802b78
  801a60:	6a 2e                	push   $0x2e
  801a62:	68 69 2b 80 00       	push   $0x802b69
  801a67:	e8 85 ed ff ff       	call   8007f1 <_panic>

00801a6c <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801a6c:	55                   	push   %ebp
  801a6d:	89 e5                	mov    %esp,%ebp
  801a6f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a72:	83 ec 04             	sub    $0x4,%esp
  801a75:	68 9c 2b 80 00       	push   $0x802b9c
  801a7a:	6a 4c                	push   $0x4c
  801a7c:	68 69 2b 80 00       	push   $0x802b69
  801a81:	e8 6b ed ff ff       	call   8007f1 <_panic>

00801a86 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801a86:	55                   	push   %ebp
  801a87:	89 e5                	mov    %esp,%ebp
  801a89:	83 ec 18             	sub    $0x18,%esp
  801a8c:	8b 45 10             	mov    0x10(%ebp),%eax
  801a8f:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801a92:	83 ec 04             	sub    $0x4,%esp
  801a95:	68 9c 2b 80 00       	push   $0x802b9c
  801a9a:	6a 57                	push   $0x57
  801a9c:	68 69 2b 80 00       	push   $0x802b69
  801aa1:	e8 4b ed ff ff       	call   8007f1 <_panic>

00801aa6 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801aa6:	55                   	push   %ebp
  801aa7:	89 e5                	mov    %esp,%ebp
  801aa9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801aac:	83 ec 04             	sub    $0x4,%esp
  801aaf:	68 9c 2b 80 00       	push   $0x802b9c
  801ab4:	6a 5d                	push   $0x5d
  801ab6:	68 69 2b 80 00       	push   $0x802b69
  801abb:	e8 31 ed ff ff       	call   8007f1 <_panic>

00801ac0 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801ac0:	55                   	push   %ebp
  801ac1:	89 e5                	mov    %esp,%ebp
  801ac3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ac6:	83 ec 04             	sub    $0x4,%esp
  801ac9:	68 9c 2b 80 00       	push   $0x802b9c
  801ace:	6a 63                	push   $0x63
  801ad0:	68 69 2b 80 00       	push   $0x802b69
  801ad5:	e8 17 ed ff ff       	call   8007f1 <_panic>

00801ada <expand>:
}

void expand(uint32 newSize)
{
  801ada:	55                   	push   %ebp
  801adb:	89 e5                	mov    %esp,%ebp
  801add:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ae0:	83 ec 04             	sub    $0x4,%esp
  801ae3:	68 9c 2b 80 00       	push   $0x802b9c
  801ae8:	6a 68                	push   $0x68
  801aea:	68 69 2b 80 00       	push   $0x802b69
  801aef:	e8 fd ec ff ff       	call   8007f1 <_panic>

00801af4 <shrink>:
}
void shrink(uint32 newSize)
{
  801af4:	55                   	push   %ebp
  801af5:	89 e5                	mov    %esp,%ebp
  801af7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801afa:	83 ec 04             	sub    $0x4,%esp
  801afd:	68 9c 2b 80 00       	push   $0x802b9c
  801b02:	6a 6c                	push   $0x6c
  801b04:	68 69 2b 80 00       	push   $0x802b69
  801b09:	e8 e3 ec ff ff       	call   8007f1 <_panic>

00801b0e <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801b0e:	55                   	push   %ebp
  801b0f:	89 e5                	mov    %esp,%ebp
  801b11:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b14:	83 ec 04             	sub    $0x4,%esp
  801b17:	68 9c 2b 80 00       	push   $0x802b9c
  801b1c:	6a 71                	push   $0x71
  801b1e:	68 69 2b 80 00       	push   $0x802b69
  801b23:	e8 c9 ec ff ff       	call   8007f1 <_panic>

00801b28 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b28:	55                   	push   %ebp
  801b29:	89 e5                	mov    %esp,%ebp
  801b2b:	57                   	push   %edi
  801b2c:	56                   	push   %esi
  801b2d:	53                   	push   %ebx
  801b2e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801b31:	8b 45 08             	mov    0x8(%ebp),%eax
  801b34:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b37:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b3a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b3d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801b40:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801b43:	cd 30                	int    $0x30
  801b45:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801b48:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b4b:	83 c4 10             	add    $0x10,%esp
  801b4e:	5b                   	pop    %ebx
  801b4f:	5e                   	pop    %esi
  801b50:	5f                   	pop    %edi
  801b51:	5d                   	pop    %ebp
  801b52:	c3                   	ret    

00801b53 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801b53:	55                   	push   %ebp
  801b54:	89 e5                	mov    %esp,%ebp
  801b56:	83 ec 04             	sub    $0x4,%esp
  801b59:	8b 45 10             	mov    0x10(%ebp),%eax
  801b5c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801b5f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b63:	8b 45 08             	mov    0x8(%ebp),%eax
  801b66:	6a 00                	push   $0x0
  801b68:	6a 00                	push   $0x0
  801b6a:	52                   	push   %edx
  801b6b:	ff 75 0c             	pushl  0xc(%ebp)
  801b6e:	50                   	push   %eax
  801b6f:	6a 00                	push   $0x0
  801b71:	e8 b2 ff ff ff       	call   801b28 <syscall>
  801b76:	83 c4 18             	add    $0x18,%esp
}
  801b79:	90                   	nop
  801b7a:	c9                   	leave  
  801b7b:	c3                   	ret    

00801b7c <sys_cgetc>:

int
sys_cgetc(void)
{
  801b7c:	55                   	push   %ebp
  801b7d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b7f:	6a 00                	push   $0x0
  801b81:	6a 00                	push   $0x0
  801b83:	6a 00                	push   $0x0
  801b85:	6a 00                	push   $0x0
  801b87:	6a 00                	push   $0x0
  801b89:	6a 01                	push   $0x1
  801b8b:	e8 98 ff ff ff       	call   801b28 <syscall>
  801b90:	83 c4 18             	add    $0x18,%esp
}
  801b93:	c9                   	leave  
  801b94:	c3                   	ret    

00801b95 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801b95:	55                   	push   %ebp
  801b96:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801b98:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 00                	push   $0x0
  801ba1:	6a 00                	push   $0x0
  801ba3:	50                   	push   %eax
  801ba4:	6a 05                	push   $0x5
  801ba6:	e8 7d ff ff ff       	call   801b28 <syscall>
  801bab:	83 c4 18             	add    $0x18,%esp
}
  801bae:	c9                   	leave  
  801baf:	c3                   	ret    

00801bb0 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801bb0:	55                   	push   %ebp
  801bb1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 00                	push   $0x0
  801bb9:	6a 00                	push   $0x0
  801bbb:	6a 00                	push   $0x0
  801bbd:	6a 02                	push   $0x2
  801bbf:	e8 64 ff ff ff       	call   801b28 <syscall>
  801bc4:	83 c4 18             	add    $0x18,%esp
}
  801bc7:	c9                   	leave  
  801bc8:	c3                   	ret    

00801bc9 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801bc9:	55                   	push   %ebp
  801bca:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801bcc:	6a 00                	push   $0x0
  801bce:	6a 00                	push   $0x0
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 00                	push   $0x0
  801bd4:	6a 00                	push   $0x0
  801bd6:	6a 03                	push   $0x3
  801bd8:	e8 4b ff ff ff       	call   801b28 <syscall>
  801bdd:	83 c4 18             	add    $0x18,%esp
}
  801be0:	c9                   	leave  
  801be1:	c3                   	ret    

00801be2 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801be2:	55                   	push   %ebp
  801be3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801be5:	6a 00                	push   $0x0
  801be7:	6a 00                	push   $0x0
  801be9:	6a 00                	push   $0x0
  801beb:	6a 00                	push   $0x0
  801bed:	6a 00                	push   $0x0
  801bef:	6a 04                	push   $0x4
  801bf1:	e8 32 ff ff ff       	call   801b28 <syscall>
  801bf6:	83 c4 18             	add    $0x18,%esp
}
  801bf9:	c9                   	leave  
  801bfa:	c3                   	ret    

00801bfb <sys_env_exit>:


void sys_env_exit(void)
{
  801bfb:	55                   	push   %ebp
  801bfc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 00                	push   $0x0
  801c02:	6a 00                	push   $0x0
  801c04:	6a 00                	push   $0x0
  801c06:	6a 00                	push   $0x0
  801c08:	6a 06                	push   $0x6
  801c0a:	e8 19 ff ff ff       	call   801b28 <syscall>
  801c0f:	83 c4 18             	add    $0x18,%esp
}
  801c12:	90                   	nop
  801c13:	c9                   	leave  
  801c14:	c3                   	ret    

00801c15 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801c15:	55                   	push   %ebp
  801c16:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801c18:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1e:	6a 00                	push   $0x0
  801c20:	6a 00                	push   $0x0
  801c22:	6a 00                	push   $0x0
  801c24:	52                   	push   %edx
  801c25:	50                   	push   %eax
  801c26:	6a 07                	push   $0x7
  801c28:	e8 fb fe ff ff       	call   801b28 <syscall>
  801c2d:	83 c4 18             	add    $0x18,%esp
}
  801c30:	c9                   	leave  
  801c31:	c3                   	ret    

00801c32 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801c32:	55                   	push   %ebp
  801c33:	89 e5                	mov    %esp,%ebp
  801c35:	56                   	push   %esi
  801c36:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801c37:	8b 75 18             	mov    0x18(%ebp),%esi
  801c3a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c3d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c40:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c43:	8b 45 08             	mov    0x8(%ebp),%eax
  801c46:	56                   	push   %esi
  801c47:	53                   	push   %ebx
  801c48:	51                   	push   %ecx
  801c49:	52                   	push   %edx
  801c4a:	50                   	push   %eax
  801c4b:	6a 08                	push   $0x8
  801c4d:	e8 d6 fe ff ff       	call   801b28 <syscall>
  801c52:	83 c4 18             	add    $0x18,%esp
}
  801c55:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801c58:	5b                   	pop    %ebx
  801c59:	5e                   	pop    %esi
  801c5a:	5d                   	pop    %ebp
  801c5b:	c3                   	ret    

00801c5c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801c5c:	55                   	push   %ebp
  801c5d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801c5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c62:	8b 45 08             	mov    0x8(%ebp),%eax
  801c65:	6a 00                	push   $0x0
  801c67:	6a 00                	push   $0x0
  801c69:	6a 00                	push   $0x0
  801c6b:	52                   	push   %edx
  801c6c:	50                   	push   %eax
  801c6d:	6a 09                	push   $0x9
  801c6f:	e8 b4 fe ff ff       	call   801b28 <syscall>
  801c74:	83 c4 18             	add    $0x18,%esp
}
  801c77:	c9                   	leave  
  801c78:	c3                   	ret    

00801c79 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c79:	55                   	push   %ebp
  801c7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 00                	push   $0x0
  801c80:	6a 00                	push   $0x0
  801c82:	ff 75 0c             	pushl  0xc(%ebp)
  801c85:	ff 75 08             	pushl  0x8(%ebp)
  801c88:	6a 0a                	push   $0xa
  801c8a:	e8 99 fe ff ff       	call   801b28 <syscall>
  801c8f:	83 c4 18             	add    $0x18,%esp
}
  801c92:	c9                   	leave  
  801c93:	c3                   	ret    

00801c94 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c94:	55                   	push   %ebp
  801c95:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c97:	6a 00                	push   $0x0
  801c99:	6a 00                	push   $0x0
  801c9b:	6a 00                	push   $0x0
  801c9d:	6a 00                	push   $0x0
  801c9f:	6a 00                	push   $0x0
  801ca1:	6a 0b                	push   $0xb
  801ca3:	e8 80 fe ff ff       	call   801b28 <syscall>
  801ca8:	83 c4 18             	add    $0x18,%esp
}
  801cab:	c9                   	leave  
  801cac:	c3                   	ret    

00801cad <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801cad:	55                   	push   %ebp
  801cae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801cb0:	6a 00                	push   $0x0
  801cb2:	6a 00                	push   $0x0
  801cb4:	6a 00                	push   $0x0
  801cb6:	6a 00                	push   $0x0
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 0c                	push   $0xc
  801cbc:	e8 67 fe ff ff       	call   801b28 <syscall>
  801cc1:	83 c4 18             	add    $0x18,%esp
}
  801cc4:	c9                   	leave  
  801cc5:	c3                   	ret    

00801cc6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801cc6:	55                   	push   %ebp
  801cc7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 00                	push   $0x0
  801cd1:	6a 00                	push   $0x0
  801cd3:	6a 0d                	push   $0xd
  801cd5:	e8 4e fe ff ff       	call   801b28 <syscall>
  801cda:	83 c4 18             	add    $0x18,%esp
}
  801cdd:	c9                   	leave  
  801cde:	c3                   	ret    

00801cdf <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801cdf:	55                   	push   %ebp
  801ce0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	ff 75 0c             	pushl  0xc(%ebp)
  801ceb:	ff 75 08             	pushl  0x8(%ebp)
  801cee:	6a 11                	push   $0x11
  801cf0:	e8 33 fe ff ff       	call   801b28 <syscall>
  801cf5:	83 c4 18             	add    $0x18,%esp
	return;
  801cf8:	90                   	nop
}
  801cf9:	c9                   	leave  
  801cfa:	c3                   	ret    

00801cfb <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801cfb:	55                   	push   %ebp
  801cfc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	6a 00                	push   $0x0
  801d04:	ff 75 0c             	pushl  0xc(%ebp)
  801d07:	ff 75 08             	pushl  0x8(%ebp)
  801d0a:	6a 12                	push   $0x12
  801d0c:	e8 17 fe ff ff       	call   801b28 <syscall>
  801d11:	83 c4 18             	add    $0x18,%esp
	return ;
  801d14:	90                   	nop
}
  801d15:	c9                   	leave  
  801d16:	c3                   	ret    

00801d17 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801d17:	55                   	push   %ebp
  801d18:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801d1a:	6a 00                	push   $0x0
  801d1c:	6a 00                	push   $0x0
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	6a 00                	push   $0x0
  801d24:	6a 0e                	push   $0xe
  801d26:	e8 fd fd ff ff       	call   801b28 <syscall>
  801d2b:	83 c4 18             	add    $0x18,%esp
}
  801d2e:	c9                   	leave  
  801d2f:	c3                   	ret    

00801d30 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801d30:	55                   	push   %ebp
  801d31:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801d33:	6a 00                	push   $0x0
  801d35:	6a 00                	push   $0x0
  801d37:	6a 00                	push   $0x0
  801d39:	6a 00                	push   $0x0
  801d3b:	ff 75 08             	pushl  0x8(%ebp)
  801d3e:	6a 0f                	push   $0xf
  801d40:	e8 e3 fd ff ff       	call   801b28 <syscall>
  801d45:	83 c4 18             	add    $0x18,%esp
}
  801d48:	c9                   	leave  
  801d49:	c3                   	ret    

00801d4a <sys_scarce_memory>:

void sys_scarce_memory()
{
  801d4a:	55                   	push   %ebp
  801d4b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801d4d:	6a 00                	push   $0x0
  801d4f:	6a 00                	push   $0x0
  801d51:	6a 00                	push   $0x0
  801d53:	6a 00                	push   $0x0
  801d55:	6a 00                	push   $0x0
  801d57:	6a 10                	push   $0x10
  801d59:	e8 ca fd ff ff       	call   801b28 <syscall>
  801d5e:	83 c4 18             	add    $0x18,%esp
}
  801d61:	90                   	nop
  801d62:	c9                   	leave  
  801d63:	c3                   	ret    

00801d64 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801d64:	55                   	push   %ebp
  801d65:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801d67:	6a 00                	push   $0x0
  801d69:	6a 00                	push   $0x0
  801d6b:	6a 00                	push   $0x0
  801d6d:	6a 00                	push   $0x0
  801d6f:	6a 00                	push   $0x0
  801d71:	6a 14                	push   $0x14
  801d73:	e8 b0 fd ff ff       	call   801b28 <syscall>
  801d78:	83 c4 18             	add    $0x18,%esp
}
  801d7b:	90                   	nop
  801d7c:	c9                   	leave  
  801d7d:	c3                   	ret    

00801d7e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801d7e:	55                   	push   %ebp
  801d7f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	6a 00                	push   $0x0
  801d87:	6a 00                	push   $0x0
  801d89:	6a 00                	push   $0x0
  801d8b:	6a 15                	push   $0x15
  801d8d:	e8 96 fd ff ff       	call   801b28 <syscall>
  801d92:	83 c4 18             	add    $0x18,%esp
}
  801d95:	90                   	nop
  801d96:	c9                   	leave  
  801d97:	c3                   	ret    

00801d98 <sys_cputc>:


void
sys_cputc(const char c)
{
  801d98:	55                   	push   %ebp
  801d99:	89 e5                	mov    %esp,%ebp
  801d9b:	83 ec 04             	sub    $0x4,%esp
  801d9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801da1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801da4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801da8:	6a 00                	push   $0x0
  801daa:	6a 00                	push   $0x0
  801dac:	6a 00                	push   $0x0
  801dae:	6a 00                	push   $0x0
  801db0:	50                   	push   %eax
  801db1:	6a 16                	push   $0x16
  801db3:	e8 70 fd ff ff       	call   801b28 <syscall>
  801db8:	83 c4 18             	add    $0x18,%esp
}
  801dbb:	90                   	nop
  801dbc:	c9                   	leave  
  801dbd:	c3                   	ret    

00801dbe <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801dbe:	55                   	push   %ebp
  801dbf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801dc1:	6a 00                	push   $0x0
  801dc3:	6a 00                	push   $0x0
  801dc5:	6a 00                	push   $0x0
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 00                	push   $0x0
  801dcb:	6a 17                	push   $0x17
  801dcd:	e8 56 fd ff ff       	call   801b28 <syscall>
  801dd2:	83 c4 18             	add    $0x18,%esp
}
  801dd5:	90                   	nop
  801dd6:	c9                   	leave  
  801dd7:	c3                   	ret    

00801dd8 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801dd8:	55                   	push   %ebp
  801dd9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ddb:	8b 45 08             	mov    0x8(%ebp),%eax
  801dde:	6a 00                	push   $0x0
  801de0:	6a 00                	push   $0x0
  801de2:	6a 00                	push   $0x0
  801de4:	ff 75 0c             	pushl  0xc(%ebp)
  801de7:	50                   	push   %eax
  801de8:	6a 18                	push   $0x18
  801dea:	e8 39 fd ff ff       	call   801b28 <syscall>
  801def:	83 c4 18             	add    $0x18,%esp
}
  801df2:	c9                   	leave  
  801df3:	c3                   	ret    

00801df4 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801df4:	55                   	push   %ebp
  801df5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801df7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dfa:	8b 45 08             	mov    0x8(%ebp),%eax
  801dfd:	6a 00                	push   $0x0
  801dff:	6a 00                	push   $0x0
  801e01:	6a 00                	push   $0x0
  801e03:	52                   	push   %edx
  801e04:	50                   	push   %eax
  801e05:	6a 1b                	push   $0x1b
  801e07:	e8 1c fd ff ff       	call   801b28 <syscall>
  801e0c:	83 c4 18             	add    $0x18,%esp
}
  801e0f:	c9                   	leave  
  801e10:	c3                   	ret    

00801e11 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e11:	55                   	push   %ebp
  801e12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e14:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e17:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1a:	6a 00                	push   $0x0
  801e1c:	6a 00                	push   $0x0
  801e1e:	6a 00                	push   $0x0
  801e20:	52                   	push   %edx
  801e21:	50                   	push   %eax
  801e22:	6a 19                	push   $0x19
  801e24:	e8 ff fc ff ff       	call   801b28 <syscall>
  801e29:	83 c4 18             	add    $0x18,%esp
}
  801e2c:	90                   	nop
  801e2d:	c9                   	leave  
  801e2e:	c3                   	ret    

00801e2f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e2f:	55                   	push   %ebp
  801e30:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e32:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e35:	8b 45 08             	mov    0x8(%ebp),%eax
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 00                	push   $0x0
  801e3c:	6a 00                	push   $0x0
  801e3e:	52                   	push   %edx
  801e3f:	50                   	push   %eax
  801e40:	6a 1a                	push   $0x1a
  801e42:	e8 e1 fc ff ff       	call   801b28 <syscall>
  801e47:	83 c4 18             	add    $0x18,%esp
}
  801e4a:	90                   	nop
  801e4b:	c9                   	leave  
  801e4c:	c3                   	ret    

00801e4d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801e4d:	55                   	push   %ebp
  801e4e:	89 e5                	mov    %esp,%ebp
  801e50:	83 ec 04             	sub    $0x4,%esp
  801e53:	8b 45 10             	mov    0x10(%ebp),%eax
  801e56:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801e59:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801e5c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e60:	8b 45 08             	mov    0x8(%ebp),%eax
  801e63:	6a 00                	push   $0x0
  801e65:	51                   	push   %ecx
  801e66:	52                   	push   %edx
  801e67:	ff 75 0c             	pushl  0xc(%ebp)
  801e6a:	50                   	push   %eax
  801e6b:	6a 1c                	push   $0x1c
  801e6d:	e8 b6 fc ff ff       	call   801b28 <syscall>
  801e72:	83 c4 18             	add    $0x18,%esp
}
  801e75:	c9                   	leave  
  801e76:	c3                   	ret    

00801e77 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801e77:	55                   	push   %ebp
  801e78:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801e7a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e80:	6a 00                	push   $0x0
  801e82:	6a 00                	push   $0x0
  801e84:	6a 00                	push   $0x0
  801e86:	52                   	push   %edx
  801e87:	50                   	push   %eax
  801e88:	6a 1d                	push   $0x1d
  801e8a:	e8 99 fc ff ff       	call   801b28 <syscall>
  801e8f:	83 c4 18             	add    $0x18,%esp
}
  801e92:	c9                   	leave  
  801e93:	c3                   	ret    

00801e94 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801e94:	55                   	push   %ebp
  801e95:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801e97:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	51                   	push   %ecx
  801ea5:	52                   	push   %edx
  801ea6:	50                   	push   %eax
  801ea7:	6a 1e                	push   $0x1e
  801ea9:	e8 7a fc ff ff       	call   801b28 <syscall>
  801eae:	83 c4 18             	add    $0x18,%esp
}
  801eb1:	c9                   	leave  
  801eb2:	c3                   	ret    

00801eb3 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801eb3:	55                   	push   %ebp
  801eb4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801eb6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eb9:	8b 45 08             	mov    0x8(%ebp),%eax
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	52                   	push   %edx
  801ec3:	50                   	push   %eax
  801ec4:	6a 1f                	push   $0x1f
  801ec6:	e8 5d fc ff ff       	call   801b28 <syscall>
  801ecb:	83 c4 18             	add    $0x18,%esp
}
  801ece:	c9                   	leave  
  801ecf:	c3                   	ret    

00801ed0 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ed0:	55                   	push   %ebp
  801ed1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ed3:	6a 00                	push   $0x0
  801ed5:	6a 00                	push   $0x0
  801ed7:	6a 00                	push   $0x0
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	6a 20                	push   $0x20
  801edf:	e8 44 fc ff ff       	call   801b28 <syscall>
  801ee4:	83 c4 18             	add    $0x18,%esp
}
  801ee7:	c9                   	leave  
  801ee8:	c3                   	ret    

00801ee9 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801ee9:	55                   	push   %ebp
  801eea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801eec:	8b 45 08             	mov    0x8(%ebp),%eax
  801eef:	6a 00                	push   $0x0
  801ef1:	ff 75 14             	pushl  0x14(%ebp)
  801ef4:	ff 75 10             	pushl  0x10(%ebp)
  801ef7:	ff 75 0c             	pushl  0xc(%ebp)
  801efa:	50                   	push   %eax
  801efb:	6a 21                	push   $0x21
  801efd:	e8 26 fc ff ff       	call   801b28 <syscall>
  801f02:	83 c4 18             	add    $0x18,%esp
}
  801f05:	c9                   	leave  
  801f06:	c3                   	ret    

00801f07 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801f07:	55                   	push   %ebp
  801f08:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f0d:	6a 00                	push   $0x0
  801f0f:	6a 00                	push   $0x0
  801f11:	6a 00                	push   $0x0
  801f13:	6a 00                	push   $0x0
  801f15:	50                   	push   %eax
  801f16:	6a 22                	push   $0x22
  801f18:	e8 0b fc ff ff       	call   801b28 <syscall>
  801f1d:	83 c4 18             	add    $0x18,%esp
}
  801f20:	90                   	nop
  801f21:	c9                   	leave  
  801f22:	c3                   	ret    

00801f23 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801f23:	55                   	push   %ebp
  801f24:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801f26:	8b 45 08             	mov    0x8(%ebp),%eax
  801f29:	6a 00                	push   $0x0
  801f2b:	6a 00                	push   $0x0
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 00                	push   $0x0
  801f31:	50                   	push   %eax
  801f32:	6a 23                	push   $0x23
  801f34:	e8 ef fb ff ff       	call   801b28 <syscall>
  801f39:	83 c4 18             	add    $0x18,%esp
}
  801f3c:	90                   	nop
  801f3d:	c9                   	leave  
  801f3e:	c3                   	ret    

00801f3f <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801f3f:	55                   	push   %ebp
  801f40:	89 e5                	mov    %esp,%ebp
  801f42:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801f45:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f48:	8d 50 04             	lea    0x4(%eax),%edx
  801f4b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f4e:	6a 00                	push   $0x0
  801f50:	6a 00                	push   $0x0
  801f52:	6a 00                	push   $0x0
  801f54:	52                   	push   %edx
  801f55:	50                   	push   %eax
  801f56:	6a 24                	push   $0x24
  801f58:	e8 cb fb ff ff       	call   801b28 <syscall>
  801f5d:	83 c4 18             	add    $0x18,%esp
	return result;
  801f60:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801f63:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801f66:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f69:	89 01                	mov    %eax,(%ecx)
  801f6b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801f6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f71:	c9                   	leave  
  801f72:	c2 04 00             	ret    $0x4

00801f75 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801f75:	55                   	push   %ebp
  801f76:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801f78:	6a 00                	push   $0x0
  801f7a:	6a 00                	push   $0x0
  801f7c:	ff 75 10             	pushl  0x10(%ebp)
  801f7f:	ff 75 0c             	pushl  0xc(%ebp)
  801f82:	ff 75 08             	pushl  0x8(%ebp)
  801f85:	6a 13                	push   $0x13
  801f87:	e8 9c fb ff ff       	call   801b28 <syscall>
  801f8c:	83 c4 18             	add    $0x18,%esp
	return ;
  801f8f:	90                   	nop
}
  801f90:	c9                   	leave  
  801f91:	c3                   	ret    

00801f92 <sys_rcr2>:
uint32 sys_rcr2()
{
  801f92:	55                   	push   %ebp
  801f93:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801f95:	6a 00                	push   $0x0
  801f97:	6a 00                	push   $0x0
  801f99:	6a 00                	push   $0x0
  801f9b:	6a 00                	push   $0x0
  801f9d:	6a 00                	push   $0x0
  801f9f:	6a 25                	push   $0x25
  801fa1:	e8 82 fb ff ff       	call   801b28 <syscall>
  801fa6:	83 c4 18             	add    $0x18,%esp
}
  801fa9:	c9                   	leave  
  801faa:	c3                   	ret    

00801fab <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801fab:	55                   	push   %ebp
  801fac:	89 e5                	mov    %esp,%ebp
  801fae:	83 ec 04             	sub    $0x4,%esp
  801fb1:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801fb7:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 00                	push   $0x0
  801fc3:	50                   	push   %eax
  801fc4:	6a 26                	push   $0x26
  801fc6:	e8 5d fb ff ff       	call   801b28 <syscall>
  801fcb:	83 c4 18             	add    $0x18,%esp
	return ;
  801fce:	90                   	nop
}
  801fcf:	c9                   	leave  
  801fd0:	c3                   	ret    

00801fd1 <rsttst>:
void rsttst()
{
  801fd1:	55                   	push   %ebp
  801fd2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801fd4:	6a 00                	push   $0x0
  801fd6:	6a 00                	push   $0x0
  801fd8:	6a 00                	push   $0x0
  801fda:	6a 00                	push   $0x0
  801fdc:	6a 00                	push   $0x0
  801fde:	6a 28                	push   $0x28
  801fe0:	e8 43 fb ff ff       	call   801b28 <syscall>
  801fe5:	83 c4 18             	add    $0x18,%esp
	return ;
  801fe8:	90                   	nop
}
  801fe9:	c9                   	leave  
  801fea:	c3                   	ret    

00801feb <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801feb:	55                   	push   %ebp
  801fec:	89 e5                	mov    %esp,%ebp
  801fee:	83 ec 04             	sub    $0x4,%esp
  801ff1:	8b 45 14             	mov    0x14(%ebp),%eax
  801ff4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ff7:	8b 55 18             	mov    0x18(%ebp),%edx
  801ffa:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ffe:	52                   	push   %edx
  801fff:	50                   	push   %eax
  802000:	ff 75 10             	pushl  0x10(%ebp)
  802003:	ff 75 0c             	pushl  0xc(%ebp)
  802006:	ff 75 08             	pushl  0x8(%ebp)
  802009:	6a 27                	push   $0x27
  80200b:	e8 18 fb ff ff       	call   801b28 <syscall>
  802010:	83 c4 18             	add    $0x18,%esp
	return ;
  802013:	90                   	nop
}
  802014:	c9                   	leave  
  802015:	c3                   	ret    

00802016 <chktst>:
void chktst(uint32 n)
{
  802016:	55                   	push   %ebp
  802017:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802019:	6a 00                	push   $0x0
  80201b:	6a 00                	push   $0x0
  80201d:	6a 00                	push   $0x0
  80201f:	6a 00                	push   $0x0
  802021:	ff 75 08             	pushl  0x8(%ebp)
  802024:	6a 29                	push   $0x29
  802026:	e8 fd fa ff ff       	call   801b28 <syscall>
  80202b:	83 c4 18             	add    $0x18,%esp
	return ;
  80202e:	90                   	nop
}
  80202f:	c9                   	leave  
  802030:	c3                   	ret    

00802031 <inctst>:

void inctst()
{
  802031:	55                   	push   %ebp
  802032:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802034:	6a 00                	push   $0x0
  802036:	6a 00                	push   $0x0
  802038:	6a 00                	push   $0x0
  80203a:	6a 00                	push   $0x0
  80203c:	6a 00                	push   $0x0
  80203e:	6a 2a                	push   $0x2a
  802040:	e8 e3 fa ff ff       	call   801b28 <syscall>
  802045:	83 c4 18             	add    $0x18,%esp
	return ;
  802048:	90                   	nop
}
  802049:	c9                   	leave  
  80204a:	c3                   	ret    

0080204b <gettst>:
uint32 gettst()
{
  80204b:	55                   	push   %ebp
  80204c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80204e:	6a 00                	push   $0x0
  802050:	6a 00                	push   $0x0
  802052:	6a 00                	push   $0x0
  802054:	6a 00                	push   $0x0
  802056:	6a 00                	push   $0x0
  802058:	6a 2b                	push   $0x2b
  80205a:	e8 c9 fa ff ff       	call   801b28 <syscall>
  80205f:	83 c4 18             	add    $0x18,%esp
}
  802062:	c9                   	leave  
  802063:	c3                   	ret    

00802064 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802064:	55                   	push   %ebp
  802065:	89 e5                	mov    %esp,%ebp
  802067:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80206a:	6a 00                	push   $0x0
  80206c:	6a 00                	push   $0x0
  80206e:	6a 00                	push   $0x0
  802070:	6a 00                	push   $0x0
  802072:	6a 00                	push   $0x0
  802074:	6a 2c                	push   $0x2c
  802076:	e8 ad fa ff ff       	call   801b28 <syscall>
  80207b:	83 c4 18             	add    $0x18,%esp
  80207e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802081:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802085:	75 07                	jne    80208e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802087:	b8 01 00 00 00       	mov    $0x1,%eax
  80208c:	eb 05                	jmp    802093 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80208e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802093:	c9                   	leave  
  802094:	c3                   	ret    

00802095 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802095:	55                   	push   %ebp
  802096:	89 e5                	mov    %esp,%ebp
  802098:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80209b:	6a 00                	push   $0x0
  80209d:	6a 00                	push   $0x0
  80209f:	6a 00                	push   $0x0
  8020a1:	6a 00                	push   $0x0
  8020a3:	6a 00                	push   $0x0
  8020a5:	6a 2c                	push   $0x2c
  8020a7:	e8 7c fa ff ff       	call   801b28 <syscall>
  8020ac:	83 c4 18             	add    $0x18,%esp
  8020af:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8020b2:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8020b6:	75 07                	jne    8020bf <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8020b8:	b8 01 00 00 00       	mov    $0x1,%eax
  8020bd:	eb 05                	jmp    8020c4 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8020bf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020c4:	c9                   	leave  
  8020c5:	c3                   	ret    

008020c6 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8020c6:	55                   	push   %ebp
  8020c7:	89 e5                	mov    %esp,%ebp
  8020c9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020cc:	6a 00                	push   $0x0
  8020ce:	6a 00                	push   $0x0
  8020d0:	6a 00                	push   $0x0
  8020d2:	6a 00                	push   $0x0
  8020d4:	6a 00                	push   $0x0
  8020d6:	6a 2c                	push   $0x2c
  8020d8:	e8 4b fa ff ff       	call   801b28 <syscall>
  8020dd:	83 c4 18             	add    $0x18,%esp
  8020e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8020e3:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8020e7:	75 07                	jne    8020f0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8020e9:	b8 01 00 00 00       	mov    $0x1,%eax
  8020ee:	eb 05                	jmp    8020f5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8020f0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020f5:	c9                   	leave  
  8020f6:	c3                   	ret    

008020f7 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8020f7:	55                   	push   %ebp
  8020f8:	89 e5                	mov    %esp,%ebp
  8020fa:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020fd:	6a 00                	push   $0x0
  8020ff:	6a 00                	push   $0x0
  802101:	6a 00                	push   $0x0
  802103:	6a 00                	push   $0x0
  802105:	6a 00                	push   $0x0
  802107:	6a 2c                	push   $0x2c
  802109:	e8 1a fa ff ff       	call   801b28 <syscall>
  80210e:	83 c4 18             	add    $0x18,%esp
  802111:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802114:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802118:	75 07                	jne    802121 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80211a:	b8 01 00 00 00       	mov    $0x1,%eax
  80211f:	eb 05                	jmp    802126 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802121:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802126:	c9                   	leave  
  802127:	c3                   	ret    

00802128 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802128:	55                   	push   %ebp
  802129:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80212b:	6a 00                	push   $0x0
  80212d:	6a 00                	push   $0x0
  80212f:	6a 00                	push   $0x0
  802131:	6a 00                	push   $0x0
  802133:	ff 75 08             	pushl  0x8(%ebp)
  802136:	6a 2d                	push   $0x2d
  802138:	e8 eb f9 ff ff       	call   801b28 <syscall>
  80213d:	83 c4 18             	add    $0x18,%esp
	return ;
  802140:	90                   	nop
}
  802141:	c9                   	leave  
  802142:	c3                   	ret    

00802143 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802143:	55                   	push   %ebp
  802144:	89 e5                	mov    %esp,%ebp
  802146:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802147:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80214a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80214d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802150:	8b 45 08             	mov    0x8(%ebp),%eax
  802153:	6a 00                	push   $0x0
  802155:	53                   	push   %ebx
  802156:	51                   	push   %ecx
  802157:	52                   	push   %edx
  802158:	50                   	push   %eax
  802159:	6a 2e                	push   $0x2e
  80215b:	e8 c8 f9 ff ff       	call   801b28 <syscall>
  802160:	83 c4 18             	add    $0x18,%esp
}
  802163:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802166:	c9                   	leave  
  802167:	c3                   	ret    

00802168 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802168:	55                   	push   %ebp
  802169:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80216b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80216e:	8b 45 08             	mov    0x8(%ebp),%eax
  802171:	6a 00                	push   $0x0
  802173:	6a 00                	push   $0x0
  802175:	6a 00                	push   $0x0
  802177:	52                   	push   %edx
  802178:	50                   	push   %eax
  802179:	6a 2f                	push   $0x2f
  80217b:	e8 a8 f9 ff ff       	call   801b28 <syscall>
  802180:	83 c4 18             	add    $0x18,%esp
}
  802183:	c9                   	leave  
  802184:	c3                   	ret    

00802185 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  802185:	55                   	push   %ebp
  802186:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  802188:	6a 00                	push   $0x0
  80218a:	6a 00                	push   $0x0
  80218c:	6a 00                	push   $0x0
  80218e:	ff 75 0c             	pushl  0xc(%ebp)
  802191:	ff 75 08             	pushl  0x8(%ebp)
  802194:	6a 30                	push   $0x30
  802196:	e8 8d f9 ff ff       	call   801b28 <syscall>
  80219b:	83 c4 18             	add    $0x18,%esp
	return ;
  80219e:	90                   	nop
}
  80219f:	c9                   	leave  
  8021a0:	c3                   	ret    
  8021a1:	66 90                	xchg   %ax,%ax
  8021a3:	90                   	nop

008021a4 <__udivdi3>:
  8021a4:	55                   	push   %ebp
  8021a5:	57                   	push   %edi
  8021a6:	56                   	push   %esi
  8021a7:	53                   	push   %ebx
  8021a8:	83 ec 1c             	sub    $0x1c,%esp
  8021ab:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8021af:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8021b3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021b7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8021bb:	89 ca                	mov    %ecx,%edx
  8021bd:	89 f8                	mov    %edi,%eax
  8021bf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8021c3:	85 f6                	test   %esi,%esi
  8021c5:	75 2d                	jne    8021f4 <__udivdi3+0x50>
  8021c7:	39 cf                	cmp    %ecx,%edi
  8021c9:	77 65                	ja     802230 <__udivdi3+0x8c>
  8021cb:	89 fd                	mov    %edi,%ebp
  8021cd:	85 ff                	test   %edi,%edi
  8021cf:	75 0b                	jne    8021dc <__udivdi3+0x38>
  8021d1:	b8 01 00 00 00       	mov    $0x1,%eax
  8021d6:	31 d2                	xor    %edx,%edx
  8021d8:	f7 f7                	div    %edi
  8021da:	89 c5                	mov    %eax,%ebp
  8021dc:	31 d2                	xor    %edx,%edx
  8021de:	89 c8                	mov    %ecx,%eax
  8021e0:	f7 f5                	div    %ebp
  8021e2:	89 c1                	mov    %eax,%ecx
  8021e4:	89 d8                	mov    %ebx,%eax
  8021e6:	f7 f5                	div    %ebp
  8021e8:	89 cf                	mov    %ecx,%edi
  8021ea:	89 fa                	mov    %edi,%edx
  8021ec:	83 c4 1c             	add    $0x1c,%esp
  8021ef:	5b                   	pop    %ebx
  8021f0:	5e                   	pop    %esi
  8021f1:	5f                   	pop    %edi
  8021f2:	5d                   	pop    %ebp
  8021f3:	c3                   	ret    
  8021f4:	39 ce                	cmp    %ecx,%esi
  8021f6:	77 28                	ja     802220 <__udivdi3+0x7c>
  8021f8:	0f bd fe             	bsr    %esi,%edi
  8021fb:	83 f7 1f             	xor    $0x1f,%edi
  8021fe:	75 40                	jne    802240 <__udivdi3+0x9c>
  802200:	39 ce                	cmp    %ecx,%esi
  802202:	72 0a                	jb     80220e <__udivdi3+0x6a>
  802204:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802208:	0f 87 9e 00 00 00    	ja     8022ac <__udivdi3+0x108>
  80220e:	b8 01 00 00 00       	mov    $0x1,%eax
  802213:	89 fa                	mov    %edi,%edx
  802215:	83 c4 1c             	add    $0x1c,%esp
  802218:	5b                   	pop    %ebx
  802219:	5e                   	pop    %esi
  80221a:	5f                   	pop    %edi
  80221b:	5d                   	pop    %ebp
  80221c:	c3                   	ret    
  80221d:	8d 76 00             	lea    0x0(%esi),%esi
  802220:	31 ff                	xor    %edi,%edi
  802222:	31 c0                	xor    %eax,%eax
  802224:	89 fa                	mov    %edi,%edx
  802226:	83 c4 1c             	add    $0x1c,%esp
  802229:	5b                   	pop    %ebx
  80222a:	5e                   	pop    %esi
  80222b:	5f                   	pop    %edi
  80222c:	5d                   	pop    %ebp
  80222d:	c3                   	ret    
  80222e:	66 90                	xchg   %ax,%ax
  802230:	89 d8                	mov    %ebx,%eax
  802232:	f7 f7                	div    %edi
  802234:	31 ff                	xor    %edi,%edi
  802236:	89 fa                	mov    %edi,%edx
  802238:	83 c4 1c             	add    $0x1c,%esp
  80223b:	5b                   	pop    %ebx
  80223c:	5e                   	pop    %esi
  80223d:	5f                   	pop    %edi
  80223e:	5d                   	pop    %ebp
  80223f:	c3                   	ret    
  802240:	bd 20 00 00 00       	mov    $0x20,%ebp
  802245:	89 eb                	mov    %ebp,%ebx
  802247:	29 fb                	sub    %edi,%ebx
  802249:	89 f9                	mov    %edi,%ecx
  80224b:	d3 e6                	shl    %cl,%esi
  80224d:	89 c5                	mov    %eax,%ebp
  80224f:	88 d9                	mov    %bl,%cl
  802251:	d3 ed                	shr    %cl,%ebp
  802253:	89 e9                	mov    %ebp,%ecx
  802255:	09 f1                	or     %esi,%ecx
  802257:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80225b:	89 f9                	mov    %edi,%ecx
  80225d:	d3 e0                	shl    %cl,%eax
  80225f:	89 c5                	mov    %eax,%ebp
  802261:	89 d6                	mov    %edx,%esi
  802263:	88 d9                	mov    %bl,%cl
  802265:	d3 ee                	shr    %cl,%esi
  802267:	89 f9                	mov    %edi,%ecx
  802269:	d3 e2                	shl    %cl,%edx
  80226b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80226f:	88 d9                	mov    %bl,%cl
  802271:	d3 e8                	shr    %cl,%eax
  802273:	09 c2                	or     %eax,%edx
  802275:	89 d0                	mov    %edx,%eax
  802277:	89 f2                	mov    %esi,%edx
  802279:	f7 74 24 0c          	divl   0xc(%esp)
  80227d:	89 d6                	mov    %edx,%esi
  80227f:	89 c3                	mov    %eax,%ebx
  802281:	f7 e5                	mul    %ebp
  802283:	39 d6                	cmp    %edx,%esi
  802285:	72 19                	jb     8022a0 <__udivdi3+0xfc>
  802287:	74 0b                	je     802294 <__udivdi3+0xf0>
  802289:	89 d8                	mov    %ebx,%eax
  80228b:	31 ff                	xor    %edi,%edi
  80228d:	e9 58 ff ff ff       	jmp    8021ea <__udivdi3+0x46>
  802292:	66 90                	xchg   %ax,%ax
  802294:	8b 54 24 08          	mov    0x8(%esp),%edx
  802298:	89 f9                	mov    %edi,%ecx
  80229a:	d3 e2                	shl    %cl,%edx
  80229c:	39 c2                	cmp    %eax,%edx
  80229e:	73 e9                	jae    802289 <__udivdi3+0xe5>
  8022a0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8022a3:	31 ff                	xor    %edi,%edi
  8022a5:	e9 40 ff ff ff       	jmp    8021ea <__udivdi3+0x46>
  8022aa:	66 90                	xchg   %ax,%ax
  8022ac:	31 c0                	xor    %eax,%eax
  8022ae:	e9 37 ff ff ff       	jmp    8021ea <__udivdi3+0x46>
  8022b3:	90                   	nop

008022b4 <__umoddi3>:
  8022b4:	55                   	push   %ebp
  8022b5:	57                   	push   %edi
  8022b6:	56                   	push   %esi
  8022b7:	53                   	push   %ebx
  8022b8:	83 ec 1c             	sub    $0x1c,%esp
  8022bb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8022bf:	8b 74 24 34          	mov    0x34(%esp),%esi
  8022c3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022c7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8022cb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8022cf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8022d3:	89 f3                	mov    %esi,%ebx
  8022d5:	89 fa                	mov    %edi,%edx
  8022d7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022db:	89 34 24             	mov    %esi,(%esp)
  8022de:	85 c0                	test   %eax,%eax
  8022e0:	75 1a                	jne    8022fc <__umoddi3+0x48>
  8022e2:	39 f7                	cmp    %esi,%edi
  8022e4:	0f 86 a2 00 00 00    	jbe    80238c <__umoddi3+0xd8>
  8022ea:	89 c8                	mov    %ecx,%eax
  8022ec:	89 f2                	mov    %esi,%edx
  8022ee:	f7 f7                	div    %edi
  8022f0:	89 d0                	mov    %edx,%eax
  8022f2:	31 d2                	xor    %edx,%edx
  8022f4:	83 c4 1c             	add    $0x1c,%esp
  8022f7:	5b                   	pop    %ebx
  8022f8:	5e                   	pop    %esi
  8022f9:	5f                   	pop    %edi
  8022fa:	5d                   	pop    %ebp
  8022fb:	c3                   	ret    
  8022fc:	39 f0                	cmp    %esi,%eax
  8022fe:	0f 87 ac 00 00 00    	ja     8023b0 <__umoddi3+0xfc>
  802304:	0f bd e8             	bsr    %eax,%ebp
  802307:	83 f5 1f             	xor    $0x1f,%ebp
  80230a:	0f 84 ac 00 00 00    	je     8023bc <__umoddi3+0x108>
  802310:	bf 20 00 00 00       	mov    $0x20,%edi
  802315:	29 ef                	sub    %ebp,%edi
  802317:	89 fe                	mov    %edi,%esi
  802319:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80231d:	89 e9                	mov    %ebp,%ecx
  80231f:	d3 e0                	shl    %cl,%eax
  802321:	89 d7                	mov    %edx,%edi
  802323:	89 f1                	mov    %esi,%ecx
  802325:	d3 ef                	shr    %cl,%edi
  802327:	09 c7                	or     %eax,%edi
  802329:	89 e9                	mov    %ebp,%ecx
  80232b:	d3 e2                	shl    %cl,%edx
  80232d:	89 14 24             	mov    %edx,(%esp)
  802330:	89 d8                	mov    %ebx,%eax
  802332:	d3 e0                	shl    %cl,%eax
  802334:	89 c2                	mov    %eax,%edx
  802336:	8b 44 24 08          	mov    0x8(%esp),%eax
  80233a:	d3 e0                	shl    %cl,%eax
  80233c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802340:	8b 44 24 08          	mov    0x8(%esp),%eax
  802344:	89 f1                	mov    %esi,%ecx
  802346:	d3 e8                	shr    %cl,%eax
  802348:	09 d0                	or     %edx,%eax
  80234a:	d3 eb                	shr    %cl,%ebx
  80234c:	89 da                	mov    %ebx,%edx
  80234e:	f7 f7                	div    %edi
  802350:	89 d3                	mov    %edx,%ebx
  802352:	f7 24 24             	mull   (%esp)
  802355:	89 c6                	mov    %eax,%esi
  802357:	89 d1                	mov    %edx,%ecx
  802359:	39 d3                	cmp    %edx,%ebx
  80235b:	0f 82 87 00 00 00    	jb     8023e8 <__umoddi3+0x134>
  802361:	0f 84 91 00 00 00    	je     8023f8 <__umoddi3+0x144>
  802367:	8b 54 24 04          	mov    0x4(%esp),%edx
  80236b:	29 f2                	sub    %esi,%edx
  80236d:	19 cb                	sbb    %ecx,%ebx
  80236f:	89 d8                	mov    %ebx,%eax
  802371:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802375:	d3 e0                	shl    %cl,%eax
  802377:	89 e9                	mov    %ebp,%ecx
  802379:	d3 ea                	shr    %cl,%edx
  80237b:	09 d0                	or     %edx,%eax
  80237d:	89 e9                	mov    %ebp,%ecx
  80237f:	d3 eb                	shr    %cl,%ebx
  802381:	89 da                	mov    %ebx,%edx
  802383:	83 c4 1c             	add    $0x1c,%esp
  802386:	5b                   	pop    %ebx
  802387:	5e                   	pop    %esi
  802388:	5f                   	pop    %edi
  802389:	5d                   	pop    %ebp
  80238a:	c3                   	ret    
  80238b:	90                   	nop
  80238c:	89 fd                	mov    %edi,%ebp
  80238e:	85 ff                	test   %edi,%edi
  802390:	75 0b                	jne    80239d <__umoddi3+0xe9>
  802392:	b8 01 00 00 00       	mov    $0x1,%eax
  802397:	31 d2                	xor    %edx,%edx
  802399:	f7 f7                	div    %edi
  80239b:	89 c5                	mov    %eax,%ebp
  80239d:	89 f0                	mov    %esi,%eax
  80239f:	31 d2                	xor    %edx,%edx
  8023a1:	f7 f5                	div    %ebp
  8023a3:	89 c8                	mov    %ecx,%eax
  8023a5:	f7 f5                	div    %ebp
  8023a7:	89 d0                	mov    %edx,%eax
  8023a9:	e9 44 ff ff ff       	jmp    8022f2 <__umoddi3+0x3e>
  8023ae:	66 90                	xchg   %ax,%ax
  8023b0:	89 c8                	mov    %ecx,%eax
  8023b2:	89 f2                	mov    %esi,%edx
  8023b4:	83 c4 1c             	add    $0x1c,%esp
  8023b7:	5b                   	pop    %ebx
  8023b8:	5e                   	pop    %esi
  8023b9:	5f                   	pop    %edi
  8023ba:	5d                   	pop    %ebp
  8023bb:	c3                   	ret    
  8023bc:	3b 04 24             	cmp    (%esp),%eax
  8023bf:	72 06                	jb     8023c7 <__umoddi3+0x113>
  8023c1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8023c5:	77 0f                	ja     8023d6 <__umoddi3+0x122>
  8023c7:	89 f2                	mov    %esi,%edx
  8023c9:	29 f9                	sub    %edi,%ecx
  8023cb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8023cf:	89 14 24             	mov    %edx,(%esp)
  8023d2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023d6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8023da:	8b 14 24             	mov    (%esp),%edx
  8023dd:	83 c4 1c             	add    $0x1c,%esp
  8023e0:	5b                   	pop    %ebx
  8023e1:	5e                   	pop    %esi
  8023e2:	5f                   	pop    %edi
  8023e3:	5d                   	pop    %ebp
  8023e4:	c3                   	ret    
  8023e5:	8d 76 00             	lea    0x0(%esi),%esi
  8023e8:	2b 04 24             	sub    (%esp),%eax
  8023eb:	19 fa                	sbb    %edi,%edx
  8023ed:	89 d1                	mov    %edx,%ecx
  8023ef:	89 c6                	mov    %eax,%esi
  8023f1:	e9 71 ff ff ff       	jmp    802367 <__umoddi3+0xb3>
  8023f6:	66 90                	xchg   %ax,%ax
  8023f8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8023fc:	72 ea                	jb     8023e8 <__umoddi3+0x134>
  8023fe:	89 d9                	mov    %ebx,%ecx
  802400:	e9 62 ff ff ff       	jmp    802367 <__umoddi3+0xb3>
