
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
  800049:	e8 7f 1e 00 00       	call   801ecd <sys_getenvid>
  80004e:	89 45 e8             	mov    %eax,-0x18(%ebp)
	sys_createSemaphore("cs1", 1);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	6a 01                	push   $0x1
  800056:	68 40 27 80 00       	push   $0x802740
  80005b:	e8 95 20 00 00       	call   8020f5 <sys_createSemaphore>
  800060:	83 c4 10             	add    $0x10,%esp
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800063:	e8 49 1f 00 00       	call   801fb1 <sys_calculate_free_frames>
  800068:	89 c3                	mov    %eax,%ebx
  80006a:	e8 5b 1f 00 00       	call   801fca <sys_calculate_modified_frames>
  80006f:	01 d8                	add    %ebx,%eax
  800071:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		Iteration++ ;
  800074:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();
		sys_waitSemaphore(envID, "cs1");
  800077:	83 ec 08             	sub    $0x8,%esp
  80007a:	68 40 27 80 00       	push   $0x802740
  80007f:	ff 75 e8             	pushl  -0x18(%ebp)
  800082:	e8 a7 20 00 00       	call   80212e <sys_waitSemaphore>
  800087:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  80008a:	83 ec 08             	sub    $0x8,%esp
  80008d:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  800093:	50                   	push   %eax
  800094:	68 44 27 80 00       	push   $0x802744
  800099:	e8 8f 10 00 00       	call   80112d <readline>
  80009e:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000a1:	83 ec 04             	sub    $0x4,%esp
  8000a4:	6a 0a                	push   $0xa
  8000a6:	6a 00                	push   $0x0
  8000a8:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  8000ae:	50                   	push   %eax
  8000af:	e8 df 15 00 00       	call   801693 <strtol>
  8000b4:	83 c4 10             	add    $0x10,%esp
  8000b7:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000bd:	c1 e0 02             	shl    $0x2,%eax
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	50                   	push   %eax
  8000c4:	e8 72 19 00 00       	call   801a3b <malloc>
  8000c9:	83 c4 10             	add    $0x10,%esp
  8000cc:	89 45 dc             	mov    %eax,-0x24(%ebp)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	68 64 27 80 00       	push   $0x802764
  8000d7:	e8 cf 09 00 00       	call   800aab <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	68 87 27 80 00       	push   $0x802787
  8000e7:	e8 bf 09 00 00       	call   800aab <cprintf>
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
  800114:	68 95 27 80 00       	push   $0x802795
  800119:	e8 8d 09 00 00       	call   800aab <cprintf>
  80011e:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800121:	83 ec 0c             	sub    $0xc,%esp
  800124:	68 a4 27 80 00       	push   $0x8027a4
  800129:	e8 7d 09 00 00       	call   800aab <cprintf>
  80012e:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800131:	83 ec 0c             	sub    $0xc,%esp
  800134:	68 b4 27 80 00       	push   $0x8027b4
  800139:	e8 6d 09 00 00       	call   800aab <cprintf>
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
  80017b:	68 40 27 80 00       	push   $0x802740
  800180:	ff 75 e8             	pushl  -0x18(%ebp)
  800183:	e8 c4 1f 00 00       	call   80214c <sys_signalSemaphore>
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
  800216:	68 c0 27 80 00       	push   $0x8027c0
  80021b:	6a 4f                	push   $0x4f
  80021d:	68 e2 27 80 00       	push   $0x8027e2
  800222:	e8 cd 05 00 00       	call   8007f4 <_panic>
		else
		{
			sys_waitSemaphore(envID, "cs1");
  800227:	83 ec 08             	sub    $0x8,%esp
  80022a:	68 40 27 80 00       	push   $0x802740
  80022f:	ff 75 e8             	pushl  -0x18(%ebp)
  800232:	e8 f7 1e 00 00       	call   80212e <sys_waitSemaphore>
  800237:	83 c4 10             	add    $0x10,%esp
			cprintf("\n===============================================\n") ;
  80023a:	83 ec 0c             	sub    $0xc,%esp
  80023d:	68 f4 27 80 00       	push   $0x8027f4
  800242:	e8 64 08 00 00       	call   800aab <cprintf>
  800247:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80024a:	83 ec 0c             	sub    $0xc,%esp
  80024d:	68 28 28 80 00       	push   $0x802828
  800252:	e8 54 08 00 00       	call   800aab <cprintf>
  800257:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80025a:	83 ec 0c             	sub    $0xc,%esp
  80025d:	68 5c 28 80 00       	push   $0x80285c
  800262:	e8 44 08 00 00       	call   800aab <cprintf>
  800267:	83 c4 10             	add    $0x10,%esp
			sys_signalSemaphore(envID, "cs1");
  80026a:	83 ec 08             	sub    $0x8,%esp
  80026d:	68 40 27 80 00       	push   $0x802740
  800272:	ff 75 e8             	pushl  -0x18(%ebp)
  800275:	e8 d2 1e 00 00       	call   80214c <sys_signalSemaphore>
  80027a:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		sys_waitSemaphore(envID, "cs1");
  80027d:	83 ec 08             	sub    $0x8,%esp
  800280:	68 40 27 80 00       	push   $0x802740
  800285:	ff 75 e8             	pushl  -0x18(%ebp)
  800288:	e8 a1 1e 00 00       	call   80212e <sys_waitSemaphore>
  80028d:	83 c4 10             	add    $0x10,%esp
		cprintf("Freeing the Heap...\n\n") ;
  800290:	83 ec 0c             	sub    $0xc,%esp
  800293:	68 8e 28 80 00       	push   $0x80288e
  800298:	e8 0e 08 00 00       	call   800aab <cprintf>
  80029d:	83 c4 10             	add    $0x10,%esp
		sys_signalSemaphore(envID,"cs1");
  8002a0:	83 ec 08             	sub    $0x8,%esp
  8002a3:	68 40 27 80 00       	push   $0x802740
  8002a8:	ff 75 e8             	pushl  -0x18(%ebp)
  8002ab:	e8 9c 1e 00 00       	call   80214c <sys_signalSemaphore>
  8002b0:	83 c4 10             	add    $0x10,%esp
		free(Elements) ;
  8002b3:	83 ec 0c             	sub    $0xc,%esp
  8002b6:	ff 75 dc             	pushl  -0x24(%ebp)
  8002b9:	e8 42 1a 00 00       	call   801d00 <free>
  8002be:	83 c4 10             	add    $0x10,%esp


		///========================================================================
	//sys_disable_interrupt();
		sys_waitSemaphore(envID, "cs1");
  8002c1:	83 ec 08             	sub    $0x8,%esp
  8002c4:	68 40 27 80 00       	push   $0x802740
  8002c9:	ff 75 e8             	pushl  -0x18(%ebp)
  8002cc:	e8 5d 1e 00 00       	call   80212e <sys_waitSemaphore>
  8002d1:	83 c4 10             	add    $0x10,%esp
		cprintf("Do you want to repeat (y/n): ") ;
  8002d4:	83 ec 0c             	sub    $0xc,%esp
  8002d7:	68 a4 28 80 00       	push   $0x8028a4
  8002dc:	e8 ca 07 00 00       	call   800aab <cprintf>
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
  800319:	68 40 27 80 00       	push   $0x802740
  80031e:	ff 75 e8             	pushl  -0x18(%ebp)
  800321:	e8 26 1e 00 00       	call   80214c <sys_signalSemaphore>
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
  8005cc:	68 c2 28 80 00       	push   $0x8028c2
  8005d1:	e8 d5 04 00 00       	call   800aab <cprintf>
  8005d6:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  8005d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e6:	01 d0                	add    %edx,%eax
  8005e8:	8b 00                	mov    (%eax),%eax
  8005ea:	83 ec 08             	sub    $0x8,%esp
  8005ed:	50                   	push   %eax
  8005ee:	68 c4 28 80 00       	push   $0x8028c4
  8005f3:	e8 b3 04 00 00       	call   800aab <cprintf>
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
  80061c:	68 c9 28 80 00       	push   $0x8028c9
  800621:	e8 85 04 00 00       	call   800aab <cprintf>
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
  800640:	e8 70 1a 00 00       	call   8020b5 <sys_cputc>
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
  800651:	e8 2b 1a 00 00       	call   802081 <sys_disable_interrupt>
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
  800664:	e8 4c 1a 00 00       	call   8020b5 <sys_cputc>
  800669:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80066c:	e8 2a 1a 00 00       	call   80209b <sys_enable_interrupt>
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
  800683:	e8 11 18 00 00       	call   801e99 <sys_cgetc>
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
  80069c:	e8 e0 19 00 00       	call   802081 <sys_disable_interrupt>
	int c=0;
  8006a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8006a8:	eb 08                	jmp    8006b2 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8006aa:	e8 ea 17 00 00       	call   801e99 <sys_cgetc>
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
  8006b8:	e8 de 19 00 00       	call   80209b <sys_enable_interrupt>
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
  8006d2:	e8 0f 18 00 00       	call   801ee6 <sys_getenvindex>
  8006d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8006da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006dd:	89 d0                	mov    %edx,%eax
  8006df:	01 c0                	add    %eax,%eax
  8006e1:	01 d0                	add    %edx,%eax
  8006e3:	c1 e0 07             	shl    $0x7,%eax
  8006e6:	29 d0                	sub    %edx,%eax
  8006e8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8006ef:	01 c8                	add    %ecx,%eax
  8006f1:	01 c0                	add    %eax,%eax
  8006f3:	01 d0                	add    %edx,%eax
  8006f5:	01 c0                	add    %eax,%eax
  8006f7:	01 d0                	add    %edx,%eax
  8006f9:	c1 e0 03             	shl    $0x3,%eax
  8006fc:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800701:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800706:	a1 24 30 80 00       	mov    0x803024,%eax
  80070b:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  800711:	84 c0                	test   %al,%al
  800713:	74 0f                	je     800724 <libmain+0x58>
		binaryname = myEnv->prog_name;
  800715:	a1 24 30 80 00       	mov    0x803024,%eax
  80071a:	05 f0 ee 00 00       	add    $0xeef0,%eax
  80071f:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800724:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800728:	7e 0a                	jle    800734 <libmain+0x68>
		binaryname = argv[0];
  80072a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80072d:	8b 00                	mov    (%eax),%eax
  80072f:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800734:	83 ec 08             	sub    $0x8,%esp
  800737:	ff 75 0c             	pushl  0xc(%ebp)
  80073a:	ff 75 08             	pushl  0x8(%ebp)
  80073d:	e8 f6 f8 ff ff       	call   800038 <_main>
  800742:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800745:	e8 37 19 00 00       	call   802081 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80074a:	83 ec 0c             	sub    $0xc,%esp
  80074d:	68 e8 28 80 00       	push   $0x8028e8
  800752:	e8 54 03 00 00       	call   800aab <cprintf>
  800757:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80075a:	a1 24 30 80 00       	mov    0x803024,%eax
  80075f:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  800765:	a1 24 30 80 00       	mov    0x803024,%eax
  80076a:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  800770:	83 ec 04             	sub    $0x4,%esp
  800773:	52                   	push   %edx
  800774:	50                   	push   %eax
  800775:	68 10 29 80 00       	push   $0x802910
  80077a:	e8 2c 03 00 00       	call   800aab <cprintf>
  80077f:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800782:	a1 24 30 80 00       	mov    0x803024,%eax
  800787:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  80078d:	a1 24 30 80 00       	mov    0x803024,%eax
  800792:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  800798:	a1 24 30 80 00       	mov    0x803024,%eax
  80079d:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  8007a3:	51                   	push   %ecx
  8007a4:	52                   	push   %edx
  8007a5:	50                   	push   %eax
  8007a6:	68 38 29 80 00       	push   $0x802938
  8007ab:	e8 fb 02 00 00       	call   800aab <cprintf>
  8007b0:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8007b3:	83 ec 0c             	sub    $0xc,%esp
  8007b6:	68 e8 28 80 00       	push   $0x8028e8
  8007bb:	e8 eb 02 00 00       	call   800aab <cprintf>
  8007c0:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007c3:	e8 d3 18 00 00       	call   80209b <sys_enable_interrupt>

	// exit gracefully
	exit();
  8007c8:	e8 19 00 00 00       	call   8007e6 <exit>
}
  8007cd:	90                   	nop
  8007ce:	c9                   	leave  
  8007cf:	c3                   	ret    

008007d0 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8007d0:	55                   	push   %ebp
  8007d1:	89 e5                	mov    %esp,%ebp
  8007d3:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8007d6:	83 ec 0c             	sub    $0xc,%esp
  8007d9:	6a 00                	push   $0x0
  8007db:	e8 d2 16 00 00       	call   801eb2 <sys_env_destroy>
  8007e0:	83 c4 10             	add    $0x10,%esp
}
  8007e3:	90                   	nop
  8007e4:	c9                   	leave  
  8007e5:	c3                   	ret    

008007e6 <exit>:

void
exit(void)
{
  8007e6:	55                   	push   %ebp
  8007e7:	89 e5                	mov    %esp,%ebp
  8007e9:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8007ec:	e8 27 17 00 00       	call   801f18 <sys_env_exit>
}
  8007f1:	90                   	nop
  8007f2:	c9                   	leave  
  8007f3:	c3                   	ret    

008007f4 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8007f4:	55                   	push   %ebp
  8007f5:	89 e5                	mov    %esp,%ebp
  8007f7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8007fa:	8d 45 10             	lea    0x10(%ebp),%eax
  8007fd:	83 c0 04             	add    $0x4,%eax
  800800:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800803:	a1 18 31 80 00       	mov    0x803118,%eax
  800808:	85 c0                	test   %eax,%eax
  80080a:	74 16                	je     800822 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80080c:	a1 18 31 80 00       	mov    0x803118,%eax
  800811:	83 ec 08             	sub    $0x8,%esp
  800814:	50                   	push   %eax
  800815:	68 90 29 80 00       	push   $0x802990
  80081a:	e8 8c 02 00 00       	call   800aab <cprintf>
  80081f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800822:	a1 00 30 80 00       	mov    0x803000,%eax
  800827:	ff 75 0c             	pushl  0xc(%ebp)
  80082a:	ff 75 08             	pushl  0x8(%ebp)
  80082d:	50                   	push   %eax
  80082e:	68 95 29 80 00       	push   $0x802995
  800833:	e8 73 02 00 00       	call   800aab <cprintf>
  800838:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80083b:	8b 45 10             	mov    0x10(%ebp),%eax
  80083e:	83 ec 08             	sub    $0x8,%esp
  800841:	ff 75 f4             	pushl  -0xc(%ebp)
  800844:	50                   	push   %eax
  800845:	e8 f6 01 00 00       	call   800a40 <vcprintf>
  80084a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80084d:	83 ec 08             	sub    $0x8,%esp
  800850:	6a 00                	push   $0x0
  800852:	68 b1 29 80 00       	push   $0x8029b1
  800857:	e8 e4 01 00 00       	call   800a40 <vcprintf>
  80085c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80085f:	e8 82 ff ff ff       	call   8007e6 <exit>

	// should not return here
	while (1) ;
  800864:	eb fe                	jmp    800864 <_panic+0x70>

00800866 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800866:	55                   	push   %ebp
  800867:	89 e5                	mov    %esp,%ebp
  800869:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80086c:	a1 24 30 80 00       	mov    0x803024,%eax
  800871:	8b 50 74             	mov    0x74(%eax),%edx
  800874:	8b 45 0c             	mov    0xc(%ebp),%eax
  800877:	39 c2                	cmp    %eax,%edx
  800879:	74 14                	je     80088f <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80087b:	83 ec 04             	sub    $0x4,%esp
  80087e:	68 b4 29 80 00       	push   $0x8029b4
  800883:	6a 26                	push   $0x26
  800885:	68 00 2a 80 00       	push   $0x802a00
  80088a:	e8 65 ff ff ff       	call   8007f4 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80088f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800896:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80089d:	e9 c4 00 00 00       	jmp    800966 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  8008a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008a5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8008ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8008af:	01 d0                	add    %edx,%eax
  8008b1:	8b 00                	mov    (%eax),%eax
  8008b3:	85 c0                	test   %eax,%eax
  8008b5:	75 08                	jne    8008bf <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8008b7:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8008ba:	e9 a4 00 00 00       	jmp    800963 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8008bf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008c6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8008cd:	eb 6b                	jmp    80093a <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8008cf:	a1 24 30 80 00       	mov    0x803024,%eax
  8008d4:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8008da:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008dd:	89 d0                	mov    %edx,%eax
  8008df:	c1 e0 02             	shl    $0x2,%eax
  8008e2:	01 d0                	add    %edx,%eax
  8008e4:	c1 e0 02             	shl    $0x2,%eax
  8008e7:	01 c8                	add    %ecx,%eax
  8008e9:	8a 40 04             	mov    0x4(%eax),%al
  8008ec:	84 c0                	test   %al,%al
  8008ee:	75 47                	jne    800937 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008f0:	a1 24 30 80 00       	mov    0x803024,%eax
  8008f5:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8008fb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008fe:	89 d0                	mov    %edx,%eax
  800900:	c1 e0 02             	shl    $0x2,%eax
  800903:	01 d0                	add    %edx,%eax
  800905:	c1 e0 02             	shl    $0x2,%eax
  800908:	01 c8                	add    %ecx,%eax
  80090a:	8b 00                	mov    (%eax),%eax
  80090c:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80090f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800912:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800917:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800919:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80091c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800923:	8b 45 08             	mov    0x8(%ebp),%eax
  800926:	01 c8                	add    %ecx,%eax
  800928:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80092a:	39 c2                	cmp    %eax,%edx
  80092c:	75 09                	jne    800937 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  80092e:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800935:	eb 12                	jmp    800949 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800937:	ff 45 e8             	incl   -0x18(%ebp)
  80093a:	a1 24 30 80 00       	mov    0x803024,%eax
  80093f:	8b 50 74             	mov    0x74(%eax),%edx
  800942:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800945:	39 c2                	cmp    %eax,%edx
  800947:	77 86                	ja     8008cf <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800949:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80094d:	75 14                	jne    800963 <CheckWSWithoutLastIndex+0xfd>
			panic(
  80094f:	83 ec 04             	sub    $0x4,%esp
  800952:	68 0c 2a 80 00       	push   $0x802a0c
  800957:	6a 3a                	push   $0x3a
  800959:	68 00 2a 80 00       	push   $0x802a00
  80095e:	e8 91 fe ff ff       	call   8007f4 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800963:	ff 45 f0             	incl   -0x10(%ebp)
  800966:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800969:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80096c:	0f 8c 30 ff ff ff    	jl     8008a2 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800972:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800979:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800980:	eb 27                	jmp    8009a9 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800982:	a1 24 30 80 00       	mov    0x803024,%eax
  800987:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80098d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800990:	89 d0                	mov    %edx,%eax
  800992:	c1 e0 02             	shl    $0x2,%eax
  800995:	01 d0                	add    %edx,%eax
  800997:	c1 e0 02             	shl    $0x2,%eax
  80099a:	01 c8                	add    %ecx,%eax
  80099c:	8a 40 04             	mov    0x4(%eax),%al
  80099f:	3c 01                	cmp    $0x1,%al
  8009a1:	75 03                	jne    8009a6 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  8009a3:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009a6:	ff 45 e0             	incl   -0x20(%ebp)
  8009a9:	a1 24 30 80 00       	mov    0x803024,%eax
  8009ae:	8b 50 74             	mov    0x74(%eax),%edx
  8009b1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009b4:	39 c2                	cmp    %eax,%edx
  8009b6:	77 ca                	ja     800982 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8009b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009bb:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8009be:	74 14                	je     8009d4 <CheckWSWithoutLastIndex+0x16e>
		panic(
  8009c0:	83 ec 04             	sub    $0x4,%esp
  8009c3:	68 60 2a 80 00       	push   $0x802a60
  8009c8:	6a 44                	push   $0x44
  8009ca:	68 00 2a 80 00       	push   $0x802a00
  8009cf:	e8 20 fe ff ff       	call   8007f4 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8009d4:	90                   	nop
  8009d5:	c9                   	leave  
  8009d6:	c3                   	ret    

008009d7 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8009d7:	55                   	push   %ebp
  8009d8:	89 e5                	mov    %esp,%ebp
  8009da:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8009dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e0:	8b 00                	mov    (%eax),%eax
  8009e2:	8d 48 01             	lea    0x1(%eax),%ecx
  8009e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009e8:	89 0a                	mov    %ecx,(%edx)
  8009ea:	8b 55 08             	mov    0x8(%ebp),%edx
  8009ed:	88 d1                	mov    %dl,%cl
  8009ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009f2:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f9:	8b 00                	mov    (%eax),%eax
  8009fb:	3d ff 00 00 00       	cmp    $0xff,%eax
  800a00:	75 2c                	jne    800a2e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800a02:	a0 28 30 80 00       	mov    0x803028,%al
  800a07:	0f b6 c0             	movzbl %al,%eax
  800a0a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a0d:	8b 12                	mov    (%edx),%edx
  800a0f:	89 d1                	mov    %edx,%ecx
  800a11:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a14:	83 c2 08             	add    $0x8,%edx
  800a17:	83 ec 04             	sub    $0x4,%esp
  800a1a:	50                   	push   %eax
  800a1b:	51                   	push   %ecx
  800a1c:	52                   	push   %edx
  800a1d:	e8 4e 14 00 00       	call   801e70 <sys_cputs>
  800a22:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a28:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a31:	8b 40 04             	mov    0x4(%eax),%eax
  800a34:	8d 50 01             	lea    0x1(%eax),%edx
  800a37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3a:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a3d:	90                   	nop
  800a3e:	c9                   	leave  
  800a3f:	c3                   	ret    

00800a40 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a40:	55                   	push   %ebp
  800a41:	89 e5                	mov    %esp,%ebp
  800a43:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a49:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a50:	00 00 00 
	b.cnt = 0;
  800a53:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a5a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a5d:	ff 75 0c             	pushl  0xc(%ebp)
  800a60:	ff 75 08             	pushl  0x8(%ebp)
  800a63:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a69:	50                   	push   %eax
  800a6a:	68 d7 09 80 00       	push   $0x8009d7
  800a6f:	e8 11 02 00 00       	call   800c85 <vprintfmt>
  800a74:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a77:	a0 28 30 80 00       	mov    0x803028,%al
  800a7c:	0f b6 c0             	movzbl %al,%eax
  800a7f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a85:	83 ec 04             	sub    $0x4,%esp
  800a88:	50                   	push   %eax
  800a89:	52                   	push   %edx
  800a8a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a90:	83 c0 08             	add    $0x8,%eax
  800a93:	50                   	push   %eax
  800a94:	e8 d7 13 00 00       	call   801e70 <sys_cputs>
  800a99:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a9c:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800aa3:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800aa9:	c9                   	leave  
  800aaa:	c3                   	ret    

00800aab <cprintf>:

int cprintf(const char *fmt, ...) {
  800aab:	55                   	push   %ebp
  800aac:	89 e5                	mov    %esp,%ebp
  800aae:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800ab1:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800ab8:	8d 45 0c             	lea    0xc(%ebp),%eax
  800abb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800abe:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac1:	83 ec 08             	sub    $0x8,%esp
  800ac4:	ff 75 f4             	pushl  -0xc(%ebp)
  800ac7:	50                   	push   %eax
  800ac8:	e8 73 ff ff ff       	call   800a40 <vcprintf>
  800acd:	83 c4 10             	add    $0x10,%esp
  800ad0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800ad3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ad6:	c9                   	leave  
  800ad7:	c3                   	ret    

00800ad8 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ad8:	55                   	push   %ebp
  800ad9:	89 e5                	mov    %esp,%ebp
  800adb:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800ade:	e8 9e 15 00 00       	call   802081 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800ae3:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ae6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ae9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aec:	83 ec 08             	sub    $0x8,%esp
  800aef:	ff 75 f4             	pushl  -0xc(%ebp)
  800af2:	50                   	push   %eax
  800af3:	e8 48 ff ff ff       	call   800a40 <vcprintf>
  800af8:	83 c4 10             	add    $0x10,%esp
  800afb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800afe:	e8 98 15 00 00       	call   80209b <sys_enable_interrupt>
	return cnt;
  800b03:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b06:	c9                   	leave  
  800b07:	c3                   	ret    

00800b08 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800b08:	55                   	push   %ebp
  800b09:	89 e5                	mov    %esp,%ebp
  800b0b:	53                   	push   %ebx
  800b0c:	83 ec 14             	sub    $0x14,%esp
  800b0f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b12:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b15:	8b 45 14             	mov    0x14(%ebp),%eax
  800b18:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800b1b:	8b 45 18             	mov    0x18(%ebp),%eax
  800b1e:	ba 00 00 00 00       	mov    $0x0,%edx
  800b23:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b26:	77 55                	ja     800b7d <printnum+0x75>
  800b28:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b2b:	72 05                	jb     800b32 <printnum+0x2a>
  800b2d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b30:	77 4b                	ja     800b7d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800b32:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b35:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800b38:	8b 45 18             	mov    0x18(%ebp),%eax
  800b3b:	ba 00 00 00 00       	mov    $0x0,%edx
  800b40:	52                   	push   %edx
  800b41:	50                   	push   %eax
  800b42:	ff 75 f4             	pushl  -0xc(%ebp)
  800b45:	ff 75 f0             	pushl  -0x10(%ebp)
  800b48:	e8 73 19 00 00       	call   8024c0 <__udivdi3>
  800b4d:	83 c4 10             	add    $0x10,%esp
  800b50:	83 ec 04             	sub    $0x4,%esp
  800b53:	ff 75 20             	pushl  0x20(%ebp)
  800b56:	53                   	push   %ebx
  800b57:	ff 75 18             	pushl  0x18(%ebp)
  800b5a:	52                   	push   %edx
  800b5b:	50                   	push   %eax
  800b5c:	ff 75 0c             	pushl  0xc(%ebp)
  800b5f:	ff 75 08             	pushl  0x8(%ebp)
  800b62:	e8 a1 ff ff ff       	call   800b08 <printnum>
  800b67:	83 c4 20             	add    $0x20,%esp
  800b6a:	eb 1a                	jmp    800b86 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b6c:	83 ec 08             	sub    $0x8,%esp
  800b6f:	ff 75 0c             	pushl  0xc(%ebp)
  800b72:	ff 75 20             	pushl  0x20(%ebp)
  800b75:	8b 45 08             	mov    0x8(%ebp),%eax
  800b78:	ff d0                	call   *%eax
  800b7a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b7d:	ff 4d 1c             	decl   0x1c(%ebp)
  800b80:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b84:	7f e6                	jg     800b6c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b86:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b89:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b91:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b94:	53                   	push   %ebx
  800b95:	51                   	push   %ecx
  800b96:	52                   	push   %edx
  800b97:	50                   	push   %eax
  800b98:	e8 33 1a 00 00       	call   8025d0 <__umoddi3>
  800b9d:	83 c4 10             	add    $0x10,%esp
  800ba0:	05 d4 2c 80 00       	add    $0x802cd4,%eax
  800ba5:	8a 00                	mov    (%eax),%al
  800ba7:	0f be c0             	movsbl %al,%eax
  800baa:	83 ec 08             	sub    $0x8,%esp
  800bad:	ff 75 0c             	pushl  0xc(%ebp)
  800bb0:	50                   	push   %eax
  800bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb4:	ff d0                	call   *%eax
  800bb6:	83 c4 10             	add    $0x10,%esp
}
  800bb9:	90                   	nop
  800bba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800bbd:	c9                   	leave  
  800bbe:	c3                   	ret    

00800bbf <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800bbf:	55                   	push   %ebp
  800bc0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800bc2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bc6:	7e 1c                	jle    800be4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcb:	8b 00                	mov    (%eax),%eax
  800bcd:	8d 50 08             	lea    0x8(%eax),%edx
  800bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd3:	89 10                	mov    %edx,(%eax)
  800bd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd8:	8b 00                	mov    (%eax),%eax
  800bda:	83 e8 08             	sub    $0x8,%eax
  800bdd:	8b 50 04             	mov    0x4(%eax),%edx
  800be0:	8b 00                	mov    (%eax),%eax
  800be2:	eb 40                	jmp    800c24 <getuint+0x65>
	else if (lflag)
  800be4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800be8:	74 1e                	je     800c08 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800bea:	8b 45 08             	mov    0x8(%ebp),%eax
  800bed:	8b 00                	mov    (%eax),%eax
  800bef:	8d 50 04             	lea    0x4(%eax),%edx
  800bf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf5:	89 10                	mov    %edx,(%eax)
  800bf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfa:	8b 00                	mov    (%eax),%eax
  800bfc:	83 e8 04             	sub    $0x4,%eax
  800bff:	8b 00                	mov    (%eax),%eax
  800c01:	ba 00 00 00 00       	mov    $0x0,%edx
  800c06:	eb 1c                	jmp    800c24 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800c08:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0b:	8b 00                	mov    (%eax),%eax
  800c0d:	8d 50 04             	lea    0x4(%eax),%edx
  800c10:	8b 45 08             	mov    0x8(%ebp),%eax
  800c13:	89 10                	mov    %edx,(%eax)
  800c15:	8b 45 08             	mov    0x8(%ebp),%eax
  800c18:	8b 00                	mov    (%eax),%eax
  800c1a:	83 e8 04             	sub    $0x4,%eax
  800c1d:	8b 00                	mov    (%eax),%eax
  800c1f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800c24:	5d                   	pop    %ebp
  800c25:	c3                   	ret    

00800c26 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800c26:	55                   	push   %ebp
  800c27:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c29:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c2d:	7e 1c                	jle    800c4b <getint+0x25>
		return va_arg(*ap, long long);
  800c2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c32:	8b 00                	mov    (%eax),%eax
  800c34:	8d 50 08             	lea    0x8(%eax),%edx
  800c37:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3a:	89 10                	mov    %edx,(%eax)
  800c3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3f:	8b 00                	mov    (%eax),%eax
  800c41:	83 e8 08             	sub    $0x8,%eax
  800c44:	8b 50 04             	mov    0x4(%eax),%edx
  800c47:	8b 00                	mov    (%eax),%eax
  800c49:	eb 38                	jmp    800c83 <getint+0x5d>
	else if (lflag)
  800c4b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c4f:	74 1a                	je     800c6b <getint+0x45>
		return va_arg(*ap, long);
  800c51:	8b 45 08             	mov    0x8(%ebp),%eax
  800c54:	8b 00                	mov    (%eax),%eax
  800c56:	8d 50 04             	lea    0x4(%eax),%edx
  800c59:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5c:	89 10                	mov    %edx,(%eax)
  800c5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c61:	8b 00                	mov    (%eax),%eax
  800c63:	83 e8 04             	sub    $0x4,%eax
  800c66:	8b 00                	mov    (%eax),%eax
  800c68:	99                   	cltd   
  800c69:	eb 18                	jmp    800c83 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6e:	8b 00                	mov    (%eax),%eax
  800c70:	8d 50 04             	lea    0x4(%eax),%edx
  800c73:	8b 45 08             	mov    0x8(%ebp),%eax
  800c76:	89 10                	mov    %edx,(%eax)
  800c78:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7b:	8b 00                	mov    (%eax),%eax
  800c7d:	83 e8 04             	sub    $0x4,%eax
  800c80:	8b 00                	mov    (%eax),%eax
  800c82:	99                   	cltd   
}
  800c83:	5d                   	pop    %ebp
  800c84:	c3                   	ret    

00800c85 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c85:	55                   	push   %ebp
  800c86:	89 e5                	mov    %esp,%ebp
  800c88:	56                   	push   %esi
  800c89:	53                   	push   %ebx
  800c8a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c8d:	eb 17                	jmp    800ca6 <vprintfmt+0x21>
			if (ch == '\0')
  800c8f:	85 db                	test   %ebx,%ebx
  800c91:	0f 84 af 03 00 00    	je     801046 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c97:	83 ec 08             	sub    $0x8,%esp
  800c9a:	ff 75 0c             	pushl  0xc(%ebp)
  800c9d:	53                   	push   %ebx
  800c9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca1:	ff d0                	call   *%eax
  800ca3:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ca6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca9:	8d 50 01             	lea    0x1(%eax),%edx
  800cac:	89 55 10             	mov    %edx,0x10(%ebp)
  800caf:	8a 00                	mov    (%eax),%al
  800cb1:	0f b6 d8             	movzbl %al,%ebx
  800cb4:	83 fb 25             	cmp    $0x25,%ebx
  800cb7:	75 d6                	jne    800c8f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800cb9:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800cbd:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800cc4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800ccb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800cd2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800cd9:	8b 45 10             	mov    0x10(%ebp),%eax
  800cdc:	8d 50 01             	lea    0x1(%eax),%edx
  800cdf:	89 55 10             	mov    %edx,0x10(%ebp)
  800ce2:	8a 00                	mov    (%eax),%al
  800ce4:	0f b6 d8             	movzbl %al,%ebx
  800ce7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800cea:	83 f8 55             	cmp    $0x55,%eax
  800ced:	0f 87 2b 03 00 00    	ja     80101e <vprintfmt+0x399>
  800cf3:	8b 04 85 f8 2c 80 00 	mov    0x802cf8(,%eax,4),%eax
  800cfa:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800cfc:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800d00:	eb d7                	jmp    800cd9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800d02:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800d06:	eb d1                	jmp    800cd9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d08:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800d0f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d12:	89 d0                	mov    %edx,%eax
  800d14:	c1 e0 02             	shl    $0x2,%eax
  800d17:	01 d0                	add    %edx,%eax
  800d19:	01 c0                	add    %eax,%eax
  800d1b:	01 d8                	add    %ebx,%eax
  800d1d:	83 e8 30             	sub    $0x30,%eax
  800d20:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800d23:	8b 45 10             	mov    0x10(%ebp),%eax
  800d26:	8a 00                	mov    (%eax),%al
  800d28:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800d2b:	83 fb 2f             	cmp    $0x2f,%ebx
  800d2e:	7e 3e                	jle    800d6e <vprintfmt+0xe9>
  800d30:	83 fb 39             	cmp    $0x39,%ebx
  800d33:	7f 39                	jg     800d6e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d35:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800d38:	eb d5                	jmp    800d0f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800d3a:	8b 45 14             	mov    0x14(%ebp),%eax
  800d3d:	83 c0 04             	add    $0x4,%eax
  800d40:	89 45 14             	mov    %eax,0x14(%ebp)
  800d43:	8b 45 14             	mov    0x14(%ebp),%eax
  800d46:	83 e8 04             	sub    $0x4,%eax
  800d49:	8b 00                	mov    (%eax),%eax
  800d4b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d4e:	eb 1f                	jmp    800d6f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d50:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d54:	79 83                	jns    800cd9 <vprintfmt+0x54>
				width = 0;
  800d56:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d5d:	e9 77 ff ff ff       	jmp    800cd9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d62:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d69:	e9 6b ff ff ff       	jmp    800cd9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d6e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d6f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d73:	0f 89 60 ff ff ff    	jns    800cd9 <vprintfmt+0x54>
				width = precision, precision = -1;
  800d79:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d7c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d7f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d86:	e9 4e ff ff ff       	jmp    800cd9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d8b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d8e:	e9 46 ff ff ff       	jmp    800cd9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d93:	8b 45 14             	mov    0x14(%ebp),%eax
  800d96:	83 c0 04             	add    $0x4,%eax
  800d99:	89 45 14             	mov    %eax,0x14(%ebp)
  800d9c:	8b 45 14             	mov    0x14(%ebp),%eax
  800d9f:	83 e8 04             	sub    $0x4,%eax
  800da2:	8b 00                	mov    (%eax),%eax
  800da4:	83 ec 08             	sub    $0x8,%esp
  800da7:	ff 75 0c             	pushl  0xc(%ebp)
  800daa:	50                   	push   %eax
  800dab:	8b 45 08             	mov    0x8(%ebp),%eax
  800dae:	ff d0                	call   *%eax
  800db0:	83 c4 10             	add    $0x10,%esp
			break;
  800db3:	e9 89 02 00 00       	jmp    801041 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800db8:	8b 45 14             	mov    0x14(%ebp),%eax
  800dbb:	83 c0 04             	add    $0x4,%eax
  800dbe:	89 45 14             	mov    %eax,0x14(%ebp)
  800dc1:	8b 45 14             	mov    0x14(%ebp),%eax
  800dc4:	83 e8 04             	sub    $0x4,%eax
  800dc7:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800dc9:	85 db                	test   %ebx,%ebx
  800dcb:	79 02                	jns    800dcf <vprintfmt+0x14a>
				err = -err;
  800dcd:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800dcf:	83 fb 64             	cmp    $0x64,%ebx
  800dd2:	7f 0b                	jg     800ddf <vprintfmt+0x15a>
  800dd4:	8b 34 9d 40 2b 80 00 	mov    0x802b40(,%ebx,4),%esi
  800ddb:	85 f6                	test   %esi,%esi
  800ddd:	75 19                	jne    800df8 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ddf:	53                   	push   %ebx
  800de0:	68 e5 2c 80 00       	push   $0x802ce5
  800de5:	ff 75 0c             	pushl  0xc(%ebp)
  800de8:	ff 75 08             	pushl  0x8(%ebp)
  800deb:	e8 5e 02 00 00       	call   80104e <printfmt>
  800df0:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800df3:	e9 49 02 00 00       	jmp    801041 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800df8:	56                   	push   %esi
  800df9:	68 ee 2c 80 00       	push   $0x802cee
  800dfe:	ff 75 0c             	pushl  0xc(%ebp)
  800e01:	ff 75 08             	pushl  0x8(%ebp)
  800e04:	e8 45 02 00 00       	call   80104e <printfmt>
  800e09:	83 c4 10             	add    $0x10,%esp
			break;
  800e0c:	e9 30 02 00 00       	jmp    801041 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800e11:	8b 45 14             	mov    0x14(%ebp),%eax
  800e14:	83 c0 04             	add    $0x4,%eax
  800e17:	89 45 14             	mov    %eax,0x14(%ebp)
  800e1a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e1d:	83 e8 04             	sub    $0x4,%eax
  800e20:	8b 30                	mov    (%eax),%esi
  800e22:	85 f6                	test   %esi,%esi
  800e24:	75 05                	jne    800e2b <vprintfmt+0x1a6>
				p = "(null)";
  800e26:	be f1 2c 80 00       	mov    $0x802cf1,%esi
			if (width > 0 && padc != '-')
  800e2b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e2f:	7e 6d                	jle    800e9e <vprintfmt+0x219>
  800e31:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800e35:	74 67                	je     800e9e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800e37:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e3a:	83 ec 08             	sub    $0x8,%esp
  800e3d:	50                   	push   %eax
  800e3e:	56                   	push   %esi
  800e3f:	e8 12 05 00 00       	call   801356 <strnlen>
  800e44:	83 c4 10             	add    $0x10,%esp
  800e47:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e4a:	eb 16                	jmp    800e62 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e4c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e50:	83 ec 08             	sub    $0x8,%esp
  800e53:	ff 75 0c             	pushl  0xc(%ebp)
  800e56:	50                   	push   %eax
  800e57:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5a:	ff d0                	call   *%eax
  800e5c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e5f:	ff 4d e4             	decl   -0x1c(%ebp)
  800e62:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e66:	7f e4                	jg     800e4c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e68:	eb 34                	jmp    800e9e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e6a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e6e:	74 1c                	je     800e8c <vprintfmt+0x207>
  800e70:	83 fb 1f             	cmp    $0x1f,%ebx
  800e73:	7e 05                	jle    800e7a <vprintfmt+0x1f5>
  800e75:	83 fb 7e             	cmp    $0x7e,%ebx
  800e78:	7e 12                	jle    800e8c <vprintfmt+0x207>
					putch('?', putdat);
  800e7a:	83 ec 08             	sub    $0x8,%esp
  800e7d:	ff 75 0c             	pushl  0xc(%ebp)
  800e80:	6a 3f                	push   $0x3f
  800e82:	8b 45 08             	mov    0x8(%ebp),%eax
  800e85:	ff d0                	call   *%eax
  800e87:	83 c4 10             	add    $0x10,%esp
  800e8a:	eb 0f                	jmp    800e9b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e8c:	83 ec 08             	sub    $0x8,%esp
  800e8f:	ff 75 0c             	pushl  0xc(%ebp)
  800e92:	53                   	push   %ebx
  800e93:	8b 45 08             	mov    0x8(%ebp),%eax
  800e96:	ff d0                	call   *%eax
  800e98:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e9b:	ff 4d e4             	decl   -0x1c(%ebp)
  800e9e:	89 f0                	mov    %esi,%eax
  800ea0:	8d 70 01             	lea    0x1(%eax),%esi
  800ea3:	8a 00                	mov    (%eax),%al
  800ea5:	0f be d8             	movsbl %al,%ebx
  800ea8:	85 db                	test   %ebx,%ebx
  800eaa:	74 24                	je     800ed0 <vprintfmt+0x24b>
  800eac:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800eb0:	78 b8                	js     800e6a <vprintfmt+0x1e5>
  800eb2:	ff 4d e0             	decl   -0x20(%ebp)
  800eb5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800eb9:	79 af                	jns    800e6a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ebb:	eb 13                	jmp    800ed0 <vprintfmt+0x24b>
				putch(' ', putdat);
  800ebd:	83 ec 08             	sub    $0x8,%esp
  800ec0:	ff 75 0c             	pushl  0xc(%ebp)
  800ec3:	6a 20                	push   $0x20
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	ff d0                	call   *%eax
  800eca:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ecd:	ff 4d e4             	decl   -0x1c(%ebp)
  800ed0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ed4:	7f e7                	jg     800ebd <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ed6:	e9 66 01 00 00       	jmp    801041 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800edb:	83 ec 08             	sub    $0x8,%esp
  800ede:	ff 75 e8             	pushl  -0x18(%ebp)
  800ee1:	8d 45 14             	lea    0x14(%ebp),%eax
  800ee4:	50                   	push   %eax
  800ee5:	e8 3c fd ff ff       	call   800c26 <getint>
  800eea:	83 c4 10             	add    $0x10,%esp
  800eed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ef0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ef3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ef6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ef9:	85 d2                	test   %edx,%edx
  800efb:	79 23                	jns    800f20 <vprintfmt+0x29b>
				putch('-', putdat);
  800efd:	83 ec 08             	sub    $0x8,%esp
  800f00:	ff 75 0c             	pushl  0xc(%ebp)
  800f03:	6a 2d                	push   $0x2d
  800f05:	8b 45 08             	mov    0x8(%ebp),%eax
  800f08:	ff d0                	call   *%eax
  800f0a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800f0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f10:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f13:	f7 d8                	neg    %eax
  800f15:	83 d2 00             	adc    $0x0,%edx
  800f18:	f7 da                	neg    %edx
  800f1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f1d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800f20:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f27:	e9 bc 00 00 00       	jmp    800fe8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800f2c:	83 ec 08             	sub    $0x8,%esp
  800f2f:	ff 75 e8             	pushl  -0x18(%ebp)
  800f32:	8d 45 14             	lea    0x14(%ebp),%eax
  800f35:	50                   	push   %eax
  800f36:	e8 84 fc ff ff       	call   800bbf <getuint>
  800f3b:	83 c4 10             	add    $0x10,%esp
  800f3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f41:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f44:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f4b:	e9 98 00 00 00       	jmp    800fe8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f50:	83 ec 08             	sub    $0x8,%esp
  800f53:	ff 75 0c             	pushl  0xc(%ebp)
  800f56:	6a 58                	push   $0x58
  800f58:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5b:	ff d0                	call   *%eax
  800f5d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f60:	83 ec 08             	sub    $0x8,%esp
  800f63:	ff 75 0c             	pushl  0xc(%ebp)
  800f66:	6a 58                	push   $0x58
  800f68:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6b:	ff d0                	call   *%eax
  800f6d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f70:	83 ec 08             	sub    $0x8,%esp
  800f73:	ff 75 0c             	pushl  0xc(%ebp)
  800f76:	6a 58                	push   $0x58
  800f78:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7b:	ff d0                	call   *%eax
  800f7d:	83 c4 10             	add    $0x10,%esp
			break;
  800f80:	e9 bc 00 00 00       	jmp    801041 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f85:	83 ec 08             	sub    $0x8,%esp
  800f88:	ff 75 0c             	pushl  0xc(%ebp)
  800f8b:	6a 30                	push   $0x30
  800f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f90:	ff d0                	call   *%eax
  800f92:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f95:	83 ec 08             	sub    $0x8,%esp
  800f98:	ff 75 0c             	pushl  0xc(%ebp)
  800f9b:	6a 78                	push   $0x78
  800f9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa0:	ff d0                	call   *%eax
  800fa2:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800fa5:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa8:	83 c0 04             	add    $0x4,%eax
  800fab:	89 45 14             	mov    %eax,0x14(%ebp)
  800fae:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb1:	83 e8 04             	sub    $0x4,%eax
  800fb4:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800fb6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fb9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800fc0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800fc7:	eb 1f                	jmp    800fe8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800fc9:	83 ec 08             	sub    $0x8,%esp
  800fcc:	ff 75 e8             	pushl  -0x18(%ebp)
  800fcf:	8d 45 14             	lea    0x14(%ebp),%eax
  800fd2:	50                   	push   %eax
  800fd3:	e8 e7 fb ff ff       	call   800bbf <getuint>
  800fd8:	83 c4 10             	add    $0x10,%esp
  800fdb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fde:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800fe1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800fe8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800fec:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fef:	83 ec 04             	sub    $0x4,%esp
  800ff2:	52                   	push   %edx
  800ff3:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ff6:	50                   	push   %eax
  800ff7:	ff 75 f4             	pushl  -0xc(%ebp)
  800ffa:	ff 75 f0             	pushl  -0x10(%ebp)
  800ffd:	ff 75 0c             	pushl  0xc(%ebp)
  801000:	ff 75 08             	pushl  0x8(%ebp)
  801003:	e8 00 fb ff ff       	call   800b08 <printnum>
  801008:	83 c4 20             	add    $0x20,%esp
			break;
  80100b:	eb 34                	jmp    801041 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80100d:	83 ec 08             	sub    $0x8,%esp
  801010:	ff 75 0c             	pushl  0xc(%ebp)
  801013:	53                   	push   %ebx
  801014:	8b 45 08             	mov    0x8(%ebp),%eax
  801017:	ff d0                	call   *%eax
  801019:	83 c4 10             	add    $0x10,%esp
			break;
  80101c:	eb 23                	jmp    801041 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80101e:	83 ec 08             	sub    $0x8,%esp
  801021:	ff 75 0c             	pushl  0xc(%ebp)
  801024:	6a 25                	push   $0x25
  801026:	8b 45 08             	mov    0x8(%ebp),%eax
  801029:	ff d0                	call   *%eax
  80102b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80102e:	ff 4d 10             	decl   0x10(%ebp)
  801031:	eb 03                	jmp    801036 <vprintfmt+0x3b1>
  801033:	ff 4d 10             	decl   0x10(%ebp)
  801036:	8b 45 10             	mov    0x10(%ebp),%eax
  801039:	48                   	dec    %eax
  80103a:	8a 00                	mov    (%eax),%al
  80103c:	3c 25                	cmp    $0x25,%al
  80103e:	75 f3                	jne    801033 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801040:	90                   	nop
		}
	}
  801041:	e9 47 fc ff ff       	jmp    800c8d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801046:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801047:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80104a:	5b                   	pop    %ebx
  80104b:	5e                   	pop    %esi
  80104c:	5d                   	pop    %ebp
  80104d:	c3                   	ret    

0080104e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80104e:	55                   	push   %ebp
  80104f:	89 e5                	mov    %esp,%ebp
  801051:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801054:	8d 45 10             	lea    0x10(%ebp),%eax
  801057:	83 c0 04             	add    $0x4,%eax
  80105a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80105d:	8b 45 10             	mov    0x10(%ebp),%eax
  801060:	ff 75 f4             	pushl  -0xc(%ebp)
  801063:	50                   	push   %eax
  801064:	ff 75 0c             	pushl  0xc(%ebp)
  801067:	ff 75 08             	pushl  0x8(%ebp)
  80106a:	e8 16 fc ff ff       	call   800c85 <vprintfmt>
  80106f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801072:	90                   	nop
  801073:	c9                   	leave  
  801074:	c3                   	ret    

00801075 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801075:	55                   	push   %ebp
  801076:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801078:	8b 45 0c             	mov    0xc(%ebp),%eax
  80107b:	8b 40 08             	mov    0x8(%eax),%eax
  80107e:	8d 50 01             	lea    0x1(%eax),%edx
  801081:	8b 45 0c             	mov    0xc(%ebp),%eax
  801084:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801087:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108a:	8b 10                	mov    (%eax),%edx
  80108c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108f:	8b 40 04             	mov    0x4(%eax),%eax
  801092:	39 c2                	cmp    %eax,%edx
  801094:	73 12                	jae    8010a8 <sprintputch+0x33>
		*b->buf++ = ch;
  801096:	8b 45 0c             	mov    0xc(%ebp),%eax
  801099:	8b 00                	mov    (%eax),%eax
  80109b:	8d 48 01             	lea    0x1(%eax),%ecx
  80109e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010a1:	89 0a                	mov    %ecx,(%edx)
  8010a3:	8b 55 08             	mov    0x8(%ebp),%edx
  8010a6:	88 10                	mov    %dl,(%eax)
}
  8010a8:	90                   	nop
  8010a9:	5d                   	pop    %ebp
  8010aa:	c3                   	ret    

008010ab <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8010ab:	55                   	push   %ebp
  8010ac:	89 e5                	mov    %esp,%ebp
  8010ae:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8010b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8010b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ba:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c0:	01 d0                	add    %edx,%eax
  8010c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010c5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8010cc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010d0:	74 06                	je     8010d8 <vsnprintf+0x2d>
  8010d2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010d6:	7f 07                	jg     8010df <vsnprintf+0x34>
		return -E_INVAL;
  8010d8:	b8 03 00 00 00       	mov    $0x3,%eax
  8010dd:	eb 20                	jmp    8010ff <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8010df:	ff 75 14             	pushl  0x14(%ebp)
  8010e2:	ff 75 10             	pushl  0x10(%ebp)
  8010e5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8010e8:	50                   	push   %eax
  8010e9:	68 75 10 80 00       	push   $0x801075
  8010ee:	e8 92 fb ff ff       	call   800c85 <vprintfmt>
  8010f3:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010f9:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8010fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8010ff:	c9                   	leave  
  801100:	c3                   	ret    

00801101 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801101:	55                   	push   %ebp
  801102:	89 e5                	mov    %esp,%ebp
  801104:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801107:	8d 45 10             	lea    0x10(%ebp),%eax
  80110a:	83 c0 04             	add    $0x4,%eax
  80110d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801110:	8b 45 10             	mov    0x10(%ebp),%eax
  801113:	ff 75 f4             	pushl  -0xc(%ebp)
  801116:	50                   	push   %eax
  801117:	ff 75 0c             	pushl  0xc(%ebp)
  80111a:	ff 75 08             	pushl  0x8(%ebp)
  80111d:	e8 89 ff ff ff       	call   8010ab <vsnprintf>
  801122:	83 c4 10             	add    $0x10,%esp
  801125:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801128:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80112b:	c9                   	leave  
  80112c:	c3                   	ret    

0080112d <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80112d:	55                   	push   %ebp
  80112e:	89 e5                	mov    %esp,%ebp
  801130:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801133:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801137:	74 13                	je     80114c <readline+0x1f>
		cprintf("%s", prompt);
  801139:	83 ec 08             	sub    $0x8,%esp
  80113c:	ff 75 08             	pushl  0x8(%ebp)
  80113f:	68 50 2e 80 00       	push   $0x802e50
  801144:	e8 62 f9 ff ff       	call   800aab <cprintf>
  801149:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80114c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801153:	83 ec 0c             	sub    $0xc,%esp
  801156:	6a 00                	push   $0x0
  801158:	e8 65 f5 ff ff       	call   8006c2 <iscons>
  80115d:	83 c4 10             	add    $0x10,%esp
  801160:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801163:	e8 0c f5 ff ff       	call   800674 <getchar>
  801168:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80116b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80116f:	79 22                	jns    801193 <readline+0x66>
			if (c != -E_EOF)
  801171:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801175:	0f 84 ad 00 00 00    	je     801228 <readline+0xfb>
				cprintf("read error: %e\n", c);
  80117b:	83 ec 08             	sub    $0x8,%esp
  80117e:	ff 75 ec             	pushl  -0x14(%ebp)
  801181:	68 53 2e 80 00       	push   $0x802e53
  801186:	e8 20 f9 ff ff       	call   800aab <cprintf>
  80118b:	83 c4 10             	add    $0x10,%esp
			return;
  80118e:	e9 95 00 00 00       	jmp    801228 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801193:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801197:	7e 34                	jle    8011cd <readline+0xa0>
  801199:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011a0:	7f 2b                	jg     8011cd <readline+0xa0>
			if (echoing)
  8011a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011a6:	74 0e                	je     8011b6 <readline+0x89>
				cputchar(c);
  8011a8:	83 ec 0c             	sub    $0xc,%esp
  8011ab:	ff 75 ec             	pushl  -0x14(%ebp)
  8011ae:	e8 79 f4 ff ff       	call   80062c <cputchar>
  8011b3:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011b9:	8d 50 01             	lea    0x1(%eax),%edx
  8011bc:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011bf:	89 c2                	mov    %eax,%edx
  8011c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c4:	01 d0                	add    %edx,%eax
  8011c6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011c9:	88 10                	mov    %dl,(%eax)
  8011cb:	eb 56                	jmp    801223 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8011cd:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011d1:	75 1f                	jne    8011f2 <readline+0xc5>
  8011d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011d7:	7e 19                	jle    8011f2 <readline+0xc5>
			if (echoing)
  8011d9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011dd:	74 0e                	je     8011ed <readline+0xc0>
				cputchar(c);
  8011df:	83 ec 0c             	sub    $0xc,%esp
  8011e2:	ff 75 ec             	pushl  -0x14(%ebp)
  8011e5:	e8 42 f4 ff ff       	call   80062c <cputchar>
  8011ea:	83 c4 10             	add    $0x10,%esp

			i--;
  8011ed:	ff 4d f4             	decl   -0xc(%ebp)
  8011f0:	eb 31                	jmp    801223 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8011f2:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011f6:	74 0a                	je     801202 <readline+0xd5>
  8011f8:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8011fc:	0f 85 61 ff ff ff    	jne    801163 <readline+0x36>
			if (echoing)
  801202:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801206:	74 0e                	je     801216 <readline+0xe9>
				cputchar(c);
  801208:	83 ec 0c             	sub    $0xc,%esp
  80120b:	ff 75 ec             	pushl  -0x14(%ebp)
  80120e:	e8 19 f4 ff ff       	call   80062c <cputchar>
  801213:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801216:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801219:	8b 45 0c             	mov    0xc(%ebp),%eax
  80121c:	01 d0                	add    %edx,%eax
  80121e:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801221:	eb 06                	jmp    801229 <readline+0xfc>
		}
	}
  801223:	e9 3b ff ff ff       	jmp    801163 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801228:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801229:	c9                   	leave  
  80122a:	c3                   	ret    

0080122b <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  80122b:	55                   	push   %ebp
  80122c:	89 e5                	mov    %esp,%ebp
  80122e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801231:	e8 4b 0e 00 00       	call   802081 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801236:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80123a:	74 13                	je     80124f <atomic_readline+0x24>
		cprintf("%s", prompt);
  80123c:	83 ec 08             	sub    $0x8,%esp
  80123f:	ff 75 08             	pushl  0x8(%ebp)
  801242:	68 50 2e 80 00       	push   $0x802e50
  801247:	e8 5f f8 ff ff       	call   800aab <cprintf>
  80124c:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80124f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801256:	83 ec 0c             	sub    $0xc,%esp
  801259:	6a 00                	push   $0x0
  80125b:	e8 62 f4 ff ff       	call   8006c2 <iscons>
  801260:	83 c4 10             	add    $0x10,%esp
  801263:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801266:	e8 09 f4 ff ff       	call   800674 <getchar>
  80126b:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80126e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801272:	79 23                	jns    801297 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801274:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801278:	74 13                	je     80128d <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80127a:	83 ec 08             	sub    $0x8,%esp
  80127d:	ff 75 ec             	pushl  -0x14(%ebp)
  801280:	68 53 2e 80 00       	push   $0x802e53
  801285:	e8 21 f8 ff ff       	call   800aab <cprintf>
  80128a:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80128d:	e8 09 0e 00 00       	call   80209b <sys_enable_interrupt>
			return;
  801292:	e9 9a 00 00 00       	jmp    801331 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801297:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80129b:	7e 34                	jle    8012d1 <atomic_readline+0xa6>
  80129d:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8012a4:	7f 2b                	jg     8012d1 <atomic_readline+0xa6>
			if (echoing)
  8012a6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012aa:	74 0e                	je     8012ba <atomic_readline+0x8f>
				cputchar(c);
  8012ac:	83 ec 0c             	sub    $0xc,%esp
  8012af:	ff 75 ec             	pushl  -0x14(%ebp)
  8012b2:	e8 75 f3 ff ff       	call   80062c <cputchar>
  8012b7:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8012ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012bd:	8d 50 01             	lea    0x1(%eax),%edx
  8012c0:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8012c3:	89 c2                	mov    %eax,%edx
  8012c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c8:	01 d0                	add    %edx,%eax
  8012ca:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012cd:	88 10                	mov    %dl,(%eax)
  8012cf:	eb 5b                	jmp    80132c <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8012d1:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012d5:	75 1f                	jne    8012f6 <atomic_readline+0xcb>
  8012d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012db:	7e 19                	jle    8012f6 <atomic_readline+0xcb>
			if (echoing)
  8012dd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012e1:	74 0e                	je     8012f1 <atomic_readline+0xc6>
				cputchar(c);
  8012e3:	83 ec 0c             	sub    $0xc,%esp
  8012e6:	ff 75 ec             	pushl  -0x14(%ebp)
  8012e9:	e8 3e f3 ff ff       	call   80062c <cputchar>
  8012ee:	83 c4 10             	add    $0x10,%esp
			i--;
  8012f1:	ff 4d f4             	decl   -0xc(%ebp)
  8012f4:	eb 36                	jmp    80132c <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8012f6:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012fa:	74 0a                	je     801306 <atomic_readline+0xdb>
  8012fc:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801300:	0f 85 60 ff ff ff    	jne    801266 <atomic_readline+0x3b>
			if (echoing)
  801306:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80130a:	74 0e                	je     80131a <atomic_readline+0xef>
				cputchar(c);
  80130c:	83 ec 0c             	sub    $0xc,%esp
  80130f:	ff 75 ec             	pushl  -0x14(%ebp)
  801312:	e8 15 f3 ff ff       	call   80062c <cputchar>
  801317:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  80131a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80131d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801320:	01 d0                	add    %edx,%eax
  801322:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801325:	e8 71 0d 00 00       	call   80209b <sys_enable_interrupt>
			return;
  80132a:	eb 05                	jmp    801331 <atomic_readline+0x106>
		}
	}
  80132c:	e9 35 ff ff ff       	jmp    801266 <atomic_readline+0x3b>
}
  801331:	c9                   	leave  
  801332:	c3                   	ret    

00801333 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801333:	55                   	push   %ebp
  801334:	89 e5                	mov    %esp,%ebp
  801336:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801339:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801340:	eb 06                	jmp    801348 <strlen+0x15>
		n++;
  801342:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801345:	ff 45 08             	incl   0x8(%ebp)
  801348:	8b 45 08             	mov    0x8(%ebp),%eax
  80134b:	8a 00                	mov    (%eax),%al
  80134d:	84 c0                	test   %al,%al
  80134f:	75 f1                	jne    801342 <strlen+0xf>
		n++;
	return n;
  801351:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801354:	c9                   	leave  
  801355:	c3                   	ret    

00801356 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801356:	55                   	push   %ebp
  801357:	89 e5                	mov    %esp,%ebp
  801359:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80135c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801363:	eb 09                	jmp    80136e <strnlen+0x18>
		n++;
  801365:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801368:	ff 45 08             	incl   0x8(%ebp)
  80136b:	ff 4d 0c             	decl   0xc(%ebp)
  80136e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801372:	74 09                	je     80137d <strnlen+0x27>
  801374:	8b 45 08             	mov    0x8(%ebp),%eax
  801377:	8a 00                	mov    (%eax),%al
  801379:	84 c0                	test   %al,%al
  80137b:	75 e8                	jne    801365 <strnlen+0xf>
		n++;
	return n;
  80137d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801380:	c9                   	leave  
  801381:	c3                   	ret    

00801382 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801382:	55                   	push   %ebp
  801383:	89 e5                	mov    %esp,%ebp
  801385:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801388:	8b 45 08             	mov    0x8(%ebp),%eax
  80138b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80138e:	90                   	nop
  80138f:	8b 45 08             	mov    0x8(%ebp),%eax
  801392:	8d 50 01             	lea    0x1(%eax),%edx
  801395:	89 55 08             	mov    %edx,0x8(%ebp)
  801398:	8b 55 0c             	mov    0xc(%ebp),%edx
  80139b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80139e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013a1:	8a 12                	mov    (%edx),%dl
  8013a3:	88 10                	mov    %dl,(%eax)
  8013a5:	8a 00                	mov    (%eax),%al
  8013a7:	84 c0                	test   %al,%al
  8013a9:	75 e4                	jne    80138f <strcpy+0xd>
		/* do nothing */;
	return ret;
  8013ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8013ae:	c9                   	leave  
  8013af:	c3                   	ret    

008013b0 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8013b0:	55                   	push   %ebp
  8013b1:	89 e5                	mov    %esp,%ebp
  8013b3:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8013b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013c3:	eb 1f                	jmp    8013e4 <strncpy+0x34>
		*dst++ = *src;
  8013c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c8:	8d 50 01             	lea    0x1(%eax),%edx
  8013cb:	89 55 08             	mov    %edx,0x8(%ebp)
  8013ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d1:	8a 12                	mov    (%edx),%dl
  8013d3:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d8:	8a 00                	mov    (%eax),%al
  8013da:	84 c0                	test   %al,%al
  8013dc:	74 03                	je     8013e1 <strncpy+0x31>
			src++;
  8013de:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013e1:	ff 45 fc             	incl   -0x4(%ebp)
  8013e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013e7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013ea:	72 d9                	jb     8013c5 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013ef:	c9                   	leave  
  8013f0:	c3                   	ret    

008013f1 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013f1:	55                   	push   %ebp
  8013f2:	89 e5                	mov    %esp,%ebp
  8013f4:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8013fd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801401:	74 30                	je     801433 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801403:	eb 16                	jmp    80141b <strlcpy+0x2a>
			*dst++ = *src++;
  801405:	8b 45 08             	mov    0x8(%ebp),%eax
  801408:	8d 50 01             	lea    0x1(%eax),%edx
  80140b:	89 55 08             	mov    %edx,0x8(%ebp)
  80140e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801411:	8d 4a 01             	lea    0x1(%edx),%ecx
  801414:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801417:	8a 12                	mov    (%edx),%dl
  801419:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80141b:	ff 4d 10             	decl   0x10(%ebp)
  80141e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801422:	74 09                	je     80142d <strlcpy+0x3c>
  801424:	8b 45 0c             	mov    0xc(%ebp),%eax
  801427:	8a 00                	mov    (%eax),%al
  801429:	84 c0                	test   %al,%al
  80142b:	75 d8                	jne    801405 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80142d:	8b 45 08             	mov    0x8(%ebp),%eax
  801430:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801433:	8b 55 08             	mov    0x8(%ebp),%edx
  801436:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801439:	29 c2                	sub    %eax,%edx
  80143b:	89 d0                	mov    %edx,%eax
}
  80143d:	c9                   	leave  
  80143e:	c3                   	ret    

0080143f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80143f:	55                   	push   %ebp
  801440:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801442:	eb 06                	jmp    80144a <strcmp+0xb>
		p++, q++;
  801444:	ff 45 08             	incl   0x8(%ebp)
  801447:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80144a:	8b 45 08             	mov    0x8(%ebp),%eax
  80144d:	8a 00                	mov    (%eax),%al
  80144f:	84 c0                	test   %al,%al
  801451:	74 0e                	je     801461 <strcmp+0x22>
  801453:	8b 45 08             	mov    0x8(%ebp),%eax
  801456:	8a 10                	mov    (%eax),%dl
  801458:	8b 45 0c             	mov    0xc(%ebp),%eax
  80145b:	8a 00                	mov    (%eax),%al
  80145d:	38 c2                	cmp    %al,%dl
  80145f:	74 e3                	je     801444 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801461:	8b 45 08             	mov    0x8(%ebp),%eax
  801464:	8a 00                	mov    (%eax),%al
  801466:	0f b6 d0             	movzbl %al,%edx
  801469:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146c:	8a 00                	mov    (%eax),%al
  80146e:	0f b6 c0             	movzbl %al,%eax
  801471:	29 c2                	sub    %eax,%edx
  801473:	89 d0                	mov    %edx,%eax
}
  801475:	5d                   	pop    %ebp
  801476:	c3                   	ret    

00801477 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801477:	55                   	push   %ebp
  801478:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80147a:	eb 09                	jmp    801485 <strncmp+0xe>
		n--, p++, q++;
  80147c:	ff 4d 10             	decl   0x10(%ebp)
  80147f:	ff 45 08             	incl   0x8(%ebp)
  801482:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801485:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801489:	74 17                	je     8014a2 <strncmp+0x2b>
  80148b:	8b 45 08             	mov    0x8(%ebp),%eax
  80148e:	8a 00                	mov    (%eax),%al
  801490:	84 c0                	test   %al,%al
  801492:	74 0e                	je     8014a2 <strncmp+0x2b>
  801494:	8b 45 08             	mov    0x8(%ebp),%eax
  801497:	8a 10                	mov    (%eax),%dl
  801499:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149c:	8a 00                	mov    (%eax),%al
  80149e:	38 c2                	cmp    %al,%dl
  8014a0:	74 da                	je     80147c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8014a2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014a6:	75 07                	jne    8014af <strncmp+0x38>
		return 0;
  8014a8:	b8 00 00 00 00       	mov    $0x0,%eax
  8014ad:	eb 14                	jmp    8014c3 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8014af:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b2:	8a 00                	mov    (%eax),%al
  8014b4:	0f b6 d0             	movzbl %al,%edx
  8014b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ba:	8a 00                	mov    (%eax),%al
  8014bc:	0f b6 c0             	movzbl %al,%eax
  8014bf:	29 c2                	sub    %eax,%edx
  8014c1:	89 d0                	mov    %edx,%eax
}
  8014c3:	5d                   	pop    %ebp
  8014c4:	c3                   	ret    

008014c5 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014c5:	55                   	push   %ebp
  8014c6:	89 e5                	mov    %esp,%ebp
  8014c8:	83 ec 04             	sub    $0x4,%esp
  8014cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ce:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014d1:	eb 12                	jmp    8014e5 <strchr+0x20>
		if (*s == c)
  8014d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d6:	8a 00                	mov    (%eax),%al
  8014d8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014db:	75 05                	jne    8014e2 <strchr+0x1d>
			return (char *) s;
  8014dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e0:	eb 11                	jmp    8014f3 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014e2:	ff 45 08             	incl   0x8(%ebp)
  8014e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e8:	8a 00                	mov    (%eax),%al
  8014ea:	84 c0                	test   %al,%al
  8014ec:	75 e5                	jne    8014d3 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014f3:	c9                   	leave  
  8014f4:	c3                   	ret    

008014f5 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014f5:	55                   	push   %ebp
  8014f6:	89 e5                	mov    %esp,%ebp
  8014f8:	83 ec 04             	sub    $0x4,%esp
  8014fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014fe:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801501:	eb 0d                	jmp    801510 <strfind+0x1b>
		if (*s == c)
  801503:	8b 45 08             	mov    0x8(%ebp),%eax
  801506:	8a 00                	mov    (%eax),%al
  801508:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80150b:	74 0e                	je     80151b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80150d:	ff 45 08             	incl   0x8(%ebp)
  801510:	8b 45 08             	mov    0x8(%ebp),%eax
  801513:	8a 00                	mov    (%eax),%al
  801515:	84 c0                	test   %al,%al
  801517:	75 ea                	jne    801503 <strfind+0xe>
  801519:	eb 01                	jmp    80151c <strfind+0x27>
		if (*s == c)
			break;
  80151b:	90                   	nop
	return (char *) s;
  80151c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80151f:	c9                   	leave  
  801520:	c3                   	ret    

00801521 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801521:	55                   	push   %ebp
  801522:	89 e5                	mov    %esp,%ebp
  801524:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801527:	8b 45 08             	mov    0x8(%ebp),%eax
  80152a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80152d:	8b 45 10             	mov    0x10(%ebp),%eax
  801530:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801533:	eb 0e                	jmp    801543 <memset+0x22>
		*p++ = c;
  801535:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801538:	8d 50 01             	lea    0x1(%eax),%edx
  80153b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80153e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801541:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801543:	ff 4d f8             	decl   -0x8(%ebp)
  801546:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80154a:	79 e9                	jns    801535 <memset+0x14>
		*p++ = c;

	return v;
  80154c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80154f:	c9                   	leave  
  801550:	c3                   	ret    

00801551 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801551:	55                   	push   %ebp
  801552:	89 e5                	mov    %esp,%ebp
  801554:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801557:	8b 45 0c             	mov    0xc(%ebp),%eax
  80155a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80155d:	8b 45 08             	mov    0x8(%ebp),%eax
  801560:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801563:	eb 16                	jmp    80157b <memcpy+0x2a>
		*d++ = *s++;
  801565:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801568:	8d 50 01             	lea    0x1(%eax),%edx
  80156b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80156e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801571:	8d 4a 01             	lea    0x1(%edx),%ecx
  801574:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801577:	8a 12                	mov    (%edx),%dl
  801579:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80157b:	8b 45 10             	mov    0x10(%ebp),%eax
  80157e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801581:	89 55 10             	mov    %edx,0x10(%ebp)
  801584:	85 c0                	test   %eax,%eax
  801586:	75 dd                	jne    801565 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801588:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80158b:	c9                   	leave  
  80158c:	c3                   	ret    

0080158d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80158d:	55                   	push   %ebp
  80158e:	89 e5                	mov    %esp,%ebp
  801590:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801593:	8b 45 0c             	mov    0xc(%ebp),%eax
  801596:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801599:	8b 45 08             	mov    0x8(%ebp),%eax
  80159c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80159f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015a2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015a5:	73 50                	jae    8015f7 <memmove+0x6a>
  8015a7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ad:	01 d0                	add    %edx,%eax
  8015af:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015b2:	76 43                	jbe    8015f7 <memmove+0x6a>
		s += n;
  8015b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b7:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8015ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8015bd:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015c0:	eb 10                	jmp    8015d2 <memmove+0x45>
			*--d = *--s;
  8015c2:	ff 4d f8             	decl   -0x8(%ebp)
  8015c5:	ff 4d fc             	decl   -0x4(%ebp)
  8015c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015cb:	8a 10                	mov    (%eax),%dl
  8015cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015d0:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8015d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015d8:	89 55 10             	mov    %edx,0x10(%ebp)
  8015db:	85 c0                	test   %eax,%eax
  8015dd:	75 e3                	jne    8015c2 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8015df:	eb 23                	jmp    801604 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8015e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e4:	8d 50 01             	lea    0x1(%eax),%edx
  8015e7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015ea:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015ed:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015f0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015f3:	8a 12                	mov    (%edx),%dl
  8015f5:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015fa:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015fd:	89 55 10             	mov    %edx,0x10(%ebp)
  801600:	85 c0                	test   %eax,%eax
  801602:	75 dd                	jne    8015e1 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801604:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801607:	c9                   	leave  
  801608:	c3                   	ret    

00801609 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801609:	55                   	push   %ebp
  80160a:	89 e5                	mov    %esp,%ebp
  80160c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80160f:	8b 45 08             	mov    0x8(%ebp),%eax
  801612:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801615:	8b 45 0c             	mov    0xc(%ebp),%eax
  801618:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80161b:	eb 2a                	jmp    801647 <memcmp+0x3e>
		if (*s1 != *s2)
  80161d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801620:	8a 10                	mov    (%eax),%dl
  801622:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801625:	8a 00                	mov    (%eax),%al
  801627:	38 c2                	cmp    %al,%dl
  801629:	74 16                	je     801641 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80162b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80162e:	8a 00                	mov    (%eax),%al
  801630:	0f b6 d0             	movzbl %al,%edx
  801633:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801636:	8a 00                	mov    (%eax),%al
  801638:	0f b6 c0             	movzbl %al,%eax
  80163b:	29 c2                	sub    %eax,%edx
  80163d:	89 d0                	mov    %edx,%eax
  80163f:	eb 18                	jmp    801659 <memcmp+0x50>
		s1++, s2++;
  801641:	ff 45 fc             	incl   -0x4(%ebp)
  801644:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801647:	8b 45 10             	mov    0x10(%ebp),%eax
  80164a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80164d:	89 55 10             	mov    %edx,0x10(%ebp)
  801650:	85 c0                	test   %eax,%eax
  801652:	75 c9                	jne    80161d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801654:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801659:	c9                   	leave  
  80165a:	c3                   	ret    

0080165b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80165b:	55                   	push   %ebp
  80165c:	89 e5                	mov    %esp,%ebp
  80165e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801661:	8b 55 08             	mov    0x8(%ebp),%edx
  801664:	8b 45 10             	mov    0x10(%ebp),%eax
  801667:	01 d0                	add    %edx,%eax
  801669:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80166c:	eb 15                	jmp    801683 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80166e:	8b 45 08             	mov    0x8(%ebp),%eax
  801671:	8a 00                	mov    (%eax),%al
  801673:	0f b6 d0             	movzbl %al,%edx
  801676:	8b 45 0c             	mov    0xc(%ebp),%eax
  801679:	0f b6 c0             	movzbl %al,%eax
  80167c:	39 c2                	cmp    %eax,%edx
  80167e:	74 0d                	je     80168d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801680:	ff 45 08             	incl   0x8(%ebp)
  801683:	8b 45 08             	mov    0x8(%ebp),%eax
  801686:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801689:	72 e3                	jb     80166e <memfind+0x13>
  80168b:	eb 01                	jmp    80168e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80168d:	90                   	nop
	return (void *) s;
  80168e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801691:	c9                   	leave  
  801692:	c3                   	ret    

00801693 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801693:	55                   	push   %ebp
  801694:	89 e5                	mov    %esp,%ebp
  801696:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801699:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8016a0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016a7:	eb 03                	jmp    8016ac <strtol+0x19>
		s++;
  8016a9:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8016ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8016af:	8a 00                	mov    (%eax),%al
  8016b1:	3c 20                	cmp    $0x20,%al
  8016b3:	74 f4                	je     8016a9 <strtol+0x16>
  8016b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b8:	8a 00                	mov    (%eax),%al
  8016ba:	3c 09                	cmp    $0x9,%al
  8016bc:	74 eb                	je     8016a9 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8016be:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c1:	8a 00                	mov    (%eax),%al
  8016c3:	3c 2b                	cmp    $0x2b,%al
  8016c5:	75 05                	jne    8016cc <strtol+0x39>
		s++;
  8016c7:	ff 45 08             	incl   0x8(%ebp)
  8016ca:	eb 13                	jmp    8016df <strtol+0x4c>
	else if (*s == '-')
  8016cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cf:	8a 00                	mov    (%eax),%al
  8016d1:	3c 2d                	cmp    $0x2d,%al
  8016d3:	75 0a                	jne    8016df <strtol+0x4c>
		s++, neg = 1;
  8016d5:	ff 45 08             	incl   0x8(%ebp)
  8016d8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8016df:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016e3:	74 06                	je     8016eb <strtol+0x58>
  8016e5:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8016e9:	75 20                	jne    80170b <strtol+0x78>
  8016eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ee:	8a 00                	mov    (%eax),%al
  8016f0:	3c 30                	cmp    $0x30,%al
  8016f2:	75 17                	jne    80170b <strtol+0x78>
  8016f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f7:	40                   	inc    %eax
  8016f8:	8a 00                	mov    (%eax),%al
  8016fa:	3c 78                	cmp    $0x78,%al
  8016fc:	75 0d                	jne    80170b <strtol+0x78>
		s += 2, base = 16;
  8016fe:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801702:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801709:	eb 28                	jmp    801733 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80170b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80170f:	75 15                	jne    801726 <strtol+0x93>
  801711:	8b 45 08             	mov    0x8(%ebp),%eax
  801714:	8a 00                	mov    (%eax),%al
  801716:	3c 30                	cmp    $0x30,%al
  801718:	75 0c                	jne    801726 <strtol+0x93>
		s++, base = 8;
  80171a:	ff 45 08             	incl   0x8(%ebp)
  80171d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801724:	eb 0d                	jmp    801733 <strtol+0xa0>
	else if (base == 0)
  801726:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80172a:	75 07                	jne    801733 <strtol+0xa0>
		base = 10;
  80172c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801733:	8b 45 08             	mov    0x8(%ebp),%eax
  801736:	8a 00                	mov    (%eax),%al
  801738:	3c 2f                	cmp    $0x2f,%al
  80173a:	7e 19                	jle    801755 <strtol+0xc2>
  80173c:	8b 45 08             	mov    0x8(%ebp),%eax
  80173f:	8a 00                	mov    (%eax),%al
  801741:	3c 39                	cmp    $0x39,%al
  801743:	7f 10                	jg     801755 <strtol+0xc2>
			dig = *s - '0';
  801745:	8b 45 08             	mov    0x8(%ebp),%eax
  801748:	8a 00                	mov    (%eax),%al
  80174a:	0f be c0             	movsbl %al,%eax
  80174d:	83 e8 30             	sub    $0x30,%eax
  801750:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801753:	eb 42                	jmp    801797 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801755:	8b 45 08             	mov    0x8(%ebp),%eax
  801758:	8a 00                	mov    (%eax),%al
  80175a:	3c 60                	cmp    $0x60,%al
  80175c:	7e 19                	jle    801777 <strtol+0xe4>
  80175e:	8b 45 08             	mov    0x8(%ebp),%eax
  801761:	8a 00                	mov    (%eax),%al
  801763:	3c 7a                	cmp    $0x7a,%al
  801765:	7f 10                	jg     801777 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801767:	8b 45 08             	mov    0x8(%ebp),%eax
  80176a:	8a 00                	mov    (%eax),%al
  80176c:	0f be c0             	movsbl %al,%eax
  80176f:	83 e8 57             	sub    $0x57,%eax
  801772:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801775:	eb 20                	jmp    801797 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801777:	8b 45 08             	mov    0x8(%ebp),%eax
  80177a:	8a 00                	mov    (%eax),%al
  80177c:	3c 40                	cmp    $0x40,%al
  80177e:	7e 39                	jle    8017b9 <strtol+0x126>
  801780:	8b 45 08             	mov    0x8(%ebp),%eax
  801783:	8a 00                	mov    (%eax),%al
  801785:	3c 5a                	cmp    $0x5a,%al
  801787:	7f 30                	jg     8017b9 <strtol+0x126>
			dig = *s - 'A' + 10;
  801789:	8b 45 08             	mov    0x8(%ebp),%eax
  80178c:	8a 00                	mov    (%eax),%al
  80178e:	0f be c0             	movsbl %al,%eax
  801791:	83 e8 37             	sub    $0x37,%eax
  801794:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801797:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80179a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80179d:	7d 19                	jge    8017b8 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80179f:	ff 45 08             	incl   0x8(%ebp)
  8017a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017a5:	0f af 45 10          	imul   0x10(%ebp),%eax
  8017a9:	89 c2                	mov    %eax,%edx
  8017ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017ae:	01 d0                	add    %edx,%eax
  8017b0:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8017b3:	e9 7b ff ff ff       	jmp    801733 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8017b8:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8017b9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017bd:	74 08                	je     8017c7 <strtol+0x134>
		*endptr = (char *) s;
  8017bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c2:	8b 55 08             	mov    0x8(%ebp),%edx
  8017c5:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8017c7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017cb:	74 07                	je     8017d4 <strtol+0x141>
  8017cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017d0:	f7 d8                	neg    %eax
  8017d2:	eb 03                	jmp    8017d7 <strtol+0x144>
  8017d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8017d7:	c9                   	leave  
  8017d8:	c3                   	ret    

008017d9 <ltostr>:

void
ltostr(long value, char *str)
{
  8017d9:	55                   	push   %ebp
  8017da:	89 e5                	mov    %esp,%ebp
  8017dc:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8017df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8017e6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017ed:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017f1:	79 13                	jns    801806 <ltostr+0x2d>
	{
		neg = 1;
  8017f3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8017fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017fd:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801800:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801803:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801806:	8b 45 08             	mov    0x8(%ebp),%eax
  801809:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80180e:	99                   	cltd   
  80180f:	f7 f9                	idiv   %ecx
  801811:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801814:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801817:	8d 50 01             	lea    0x1(%eax),%edx
  80181a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80181d:	89 c2                	mov    %eax,%edx
  80181f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801822:	01 d0                	add    %edx,%eax
  801824:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801827:	83 c2 30             	add    $0x30,%edx
  80182a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80182c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80182f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801834:	f7 e9                	imul   %ecx
  801836:	c1 fa 02             	sar    $0x2,%edx
  801839:	89 c8                	mov    %ecx,%eax
  80183b:	c1 f8 1f             	sar    $0x1f,%eax
  80183e:	29 c2                	sub    %eax,%edx
  801840:	89 d0                	mov    %edx,%eax
  801842:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801845:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801848:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80184d:	f7 e9                	imul   %ecx
  80184f:	c1 fa 02             	sar    $0x2,%edx
  801852:	89 c8                	mov    %ecx,%eax
  801854:	c1 f8 1f             	sar    $0x1f,%eax
  801857:	29 c2                	sub    %eax,%edx
  801859:	89 d0                	mov    %edx,%eax
  80185b:	c1 e0 02             	shl    $0x2,%eax
  80185e:	01 d0                	add    %edx,%eax
  801860:	01 c0                	add    %eax,%eax
  801862:	29 c1                	sub    %eax,%ecx
  801864:	89 ca                	mov    %ecx,%edx
  801866:	85 d2                	test   %edx,%edx
  801868:	75 9c                	jne    801806 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80186a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801871:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801874:	48                   	dec    %eax
  801875:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801878:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80187c:	74 3d                	je     8018bb <ltostr+0xe2>
		start = 1 ;
  80187e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801885:	eb 34                	jmp    8018bb <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801887:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80188a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80188d:	01 d0                	add    %edx,%eax
  80188f:	8a 00                	mov    (%eax),%al
  801891:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801894:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801897:	8b 45 0c             	mov    0xc(%ebp),%eax
  80189a:	01 c2                	add    %eax,%edx
  80189c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80189f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a2:	01 c8                	add    %ecx,%eax
  8018a4:	8a 00                	mov    (%eax),%al
  8018a6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8018a8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8018ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ae:	01 c2                	add    %eax,%edx
  8018b0:	8a 45 eb             	mov    -0x15(%ebp),%al
  8018b3:	88 02                	mov    %al,(%edx)
		start++ ;
  8018b5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8018b8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8018bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018be:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018c1:	7c c4                	jl     801887 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8018c3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8018c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018c9:	01 d0                	add    %edx,%eax
  8018cb:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8018ce:	90                   	nop
  8018cf:	c9                   	leave  
  8018d0:	c3                   	ret    

008018d1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8018d1:	55                   	push   %ebp
  8018d2:	89 e5                	mov    %esp,%ebp
  8018d4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8018d7:	ff 75 08             	pushl  0x8(%ebp)
  8018da:	e8 54 fa ff ff       	call   801333 <strlen>
  8018df:	83 c4 04             	add    $0x4,%esp
  8018e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8018e5:	ff 75 0c             	pushl  0xc(%ebp)
  8018e8:	e8 46 fa ff ff       	call   801333 <strlen>
  8018ed:	83 c4 04             	add    $0x4,%esp
  8018f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8018fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801901:	eb 17                	jmp    80191a <strcconcat+0x49>
		final[s] = str1[s] ;
  801903:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801906:	8b 45 10             	mov    0x10(%ebp),%eax
  801909:	01 c2                	add    %eax,%edx
  80190b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80190e:	8b 45 08             	mov    0x8(%ebp),%eax
  801911:	01 c8                	add    %ecx,%eax
  801913:	8a 00                	mov    (%eax),%al
  801915:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801917:	ff 45 fc             	incl   -0x4(%ebp)
  80191a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80191d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801920:	7c e1                	jl     801903 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801922:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801929:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801930:	eb 1f                	jmp    801951 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801932:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801935:	8d 50 01             	lea    0x1(%eax),%edx
  801938:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80193b:	89 c2                	mov    %eax,%edx
  80193d:	8b 45 10             	mov    0x10(%ebp),%eax
  801940:	01 c2                	add    %eax,%edx
  801942:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801945:	8b 45 0c             	mov    0xc(%ebp),%eax
  801948:	01 c8                	add    %ecx,%eax
  80194a:	8a 00                	mov    (%eax),%al
  80194c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80194e:	ff 45 f8             	incl   -0x8(%ebp)
  801951:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801954:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801957:	7c d9                	jl     801932 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801959:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80195c:	8b 45 10             	mov    0x10(%ebp),%eax
  80195f:	01 d0                	add    %edx,%eax
  801961:	c6 00 00             	movb   $0x0,(%eax)
}
  801964:	90                   	nop
  801965:	c9                   	leave  
  801966:	c3                   	ret    

00801967 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801967:	55                   	push   %ebp
  801968:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80196a:	8b 45 14             	mov    0x14(%ebp),%eax
  80196d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801973:	8b 45 14             	mov    0x14(%ebp),%eax
  801976:	8b 00                	mov    (%eax),%eax
  801978:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80197f:	8b 45 10             	mov    0x10(%ebp),%eax
  801982:	01 d0                	add    %edx,%eax
  801984:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80198a:	eb 0c                	jmp    801998 <strsplit+0x31>
			*string++ = 0;
  80198c:	8b 45 08             	mov    0x8(%ebp),%eax
  80198f:	8d 50 01             	lea    0x1(%eax),%edx
  801992:	89 55 08             	mov    %edx,0x8(%ebp)
  801995:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801998:	8b 45 08             	mov    0x8(%ebp),%eax
  80199b:	8a 00                	mov    (%eax),%al
  80199d:	84 c0                	test   %al,%al
  80199f:	74 18                	je     8019b9 <strsplit+0x52>
  8019a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a4:	8a 00                	mov    (%eax),%al
  8019a6:	0f be c0             	movsbl %al,%eax
  8019a9:	50                   	push   %eax
  8019aa:	ff 75 0c             	pushl  0xc(%ebp)
  8019ad:	e8 13 fb ff ff       	call   8014c5 <strchr>
  8019b2:	83 c4 08             	add    $0x8,%esp
  8019b5:	85 c0                	test   %eax,%eax
  8019b7:	75 d3                	jne    80198c <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8019b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bc:	8a 00                	mov    (%eax),%al
  8019be:	84 c0                	test   %al,%al
  8019c0:	74 5a                	je     801a1c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8019c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8019c5:	8b 00                	mov    (%eax),%eax
  8019c7:	83 f8 0f             	cmp    $0xf,%eax
  8019ca:	75 07                	jne    8019d3 <strsplit+0x6c>
		{
			return 0;
  8019cc:	b8 00 00 00 00       	mov    $0x0,%eax
  8019d1:	eb 66                	jmp    801a39 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8019d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8019d6:	8b 00                	mov    (%eax),%eax
  8019d8:	8d 48 01             	lea    0x1(%eax),%ecx
  8019db:	8b 55 14             	mov    0x14(%ebp),%edx
  8019de:	89 0a                	mov    %ecx,(%edx)
  8019e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ea:	01 c2                	add    %eax,%edx
  8019ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ef:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019f1:	eb 03                	jmp    8019f6 <strsplit+0x8f>
			string++;
  8019f3:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f9:	8a 00                	mov    (%eax),%al
  8019fb:	84 c0                	test   %al,%al
  8019fd:	74 8b                	je     80198a <strsplit+0x23>
  8019ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801a02:	8a 00                	mov    (%eax),%al
  801a04:	0f be c0             	movsbl %al,%eax
  801a07:	50                   	push   %eax
  801a08:	ff 75 0c             	pushl  0xc(%ebp)
  801a0b:	e8 b5 fa ff ff       	call   8014c5 <strchr>
  801a10:	83 c4 08             	add    $0x8,%esp
  801a13:	85 c0                	test   %eax,%eax
  801a15:	74 dc                	je     8019f3 <strsplit+0x8c>
			string++;
	}
  801a17:	e9 6e ff ff ff       	jmp    80198a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801a1c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801a1d:	8b 45 14             	mov    0x14(%ebp),%eax
  801a20:	8b 00                	mov    (%eax),%eax
  801a22:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a29:	8b 45 10             	mov    0x10(%ebp),%eax
  801a2c:	01 d0                	add    %edx,%eax
  801a2e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801a34:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a39:	c9                   	leave  
  801a3a:	c3                   	ret    

00801a3b <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801a3b:	55                   	push   %ebp
  801a3c:	89 e5                	mov    %esp,%ebp
  801a3e:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  801a41:	e8 3b 09 00 00       	call   802381 <sys_isUHeapPlacementStrategyFIRSTFIT>
  801a46:	85 c0                	test   %eax,%eax
  801a48:	0f 84 3a 01 00 00    	je     801b88 <malloc+0x14d>

		if(pl == 0){
  801a4e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a53:	85 c0                	test   %eax,%eax
  801a55:	75 24                	jne    801a7b <malloc+0x40>
			for(int k = 0; k < Size; k++){
  801a57:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801a5e:	eb 11                	jmp    801a71 <malloc+0x36>
				arr[k] = -10000;
  801a60:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a63:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801a6a:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801a6e:	ff 45 f4             	incl   -0xc(%ebp)
  801a71:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a74:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801a79:	76 e5                	jbe    801a60 <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801a7b:	c7 05 2c 30 80 00 01 	movl   $0x1,0x80302c
  801a82:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801a85:	8b 45 08             	mov    0x8(%ebp),%eax
  801a88:	c1 e8 0c             	shr    $0xc,%eax
  801a8b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  801a8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a91:	25 ff 0f 00 00       	and    $0xfff,%eax
  801a96:	85 c0                	test   %eax,%eax
  801a98:	74 03                	je     801a9d <malloc+0x62>
			x++;
  801a9a:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  801a9d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  801aa4:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801aab:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801ab2:	eb 66                	jmp    801b1a <malloc+0xdf>
			if( arr[k] == -10000){
  801ab4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ab7:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801abe:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801ac3:	75 52                	jne    801b17 <malloc+0xdc>
				uint32 w = 0 ;
  801ac5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  801acc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801acf:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  801ad2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ad5:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801ad8:	eb 09                	jmp    801ae3 <malloc+0xa8>
  801ada:	ff 45 e0             	incl   -0x20(%ebp)
  801add:	ff 45 dc             	incl   -0x24(%ebp)
  801ae0:	ff 45 e4             	incl   -0x1c(%ebp)
  801ae3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801ae6:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801aeb:	77 19                	ja     801b06 <malloc+0xcb>
  801aed:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801af0:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801af7:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801afc:	75 08                	jne    801b06 <malloc+0xcb>
  801afe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b01:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b04:	72 d4                	jb     801ada <malloc+0x9f>
				if(w >= x){
  801b06:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b09:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b0c:	72 09                	jb     801b17 <malloc+0xdc>
					p = 1 ;
  801b0e:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  801b15:	eb 0d                	jmp    801b24 <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801b17:	ff 45 e4             	incl   -0x1c(%ebp)
  801b1a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b1d:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801b22:	76 90                	jbe    801ab4 <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  801b24:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801b28:	75 0a                	jne    801b34 <malloc+0xf9>
  801b2a:	b8 00 00 00 00       	mov    $0x0,%eax
  801b2f:	e9 ca 01 00 00       	jmp    801cfe <malloc+0x2c3>
		int q = idx;
  801b34:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b37:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  801b3a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801b41:	eb 16                	jmp    801b59 <malloc+0x11e>
			arr[q++] = x;
  801b43:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801b46:	8d 50 01             	lea    0x1(%eax),%edx
  801b49:	89 55 d8             	mov    %edx,-0x28(%ebp)
  801b4c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801b4f:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  801b56:	ff 45 d4             	incl   -0x2c(%ebp)
  801b59:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801b5c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b5f:	72 e2                	jb     801b43 <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801b61:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b64:	05 00 00 08 00       	add    $0x80000,%eax
  801b69:	c1 e0 0c             	shl    $0xc,%eax
  801b6c:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  801b6f:	83 ec 08             	sub    $0x8,%esp
  801b72:	ff 75 f0             	pushl  -0x10(%ebp)
  801b75:	ff 75 ac             	pushl  -0x54(%ebp)
  801b78:	e8 9b 04 00 00       	call   802018 <sys_allocateMem>
  801b7d:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801b80:	8b 45 ac             	mov    -0x54(%ebp),%eax
  801b83:	e9 76 01 00 00       	jmp    801cfe <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  801b88:	e8 25 08 00 00       	call   8023b2 <sys_isUHeapPlacementStrategyBESTFIT>
  801b8d:	85 c0                	test   %eax,%eax
  801b8f:	0f 84 64 01 00 00    	je     801cf9 <malloc+0x2be>
		if(pl == 0){
  801b95:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801b9a:	85 c0                	test   %eax,%eax
  801b9c:	75 24                	jne    801bc2 <malloc+0x187>
			for(int k = 0; k < Size; k++){
  801b9e:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  801ba5:	eb 11                	jmp    801bb8 <malloc+0x17d>
				arr[k] = -10000;
  801ba7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801baa:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801bb1:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801bb5:	ff 45 d0             	incl   -0x30(%ebp)
  801bb8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801bbb:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801bc0:	76 e5                	jbe    801ba7 <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801bc2:	c7 05 2c 30 80 00 01 	movl   $0x1,0x80302c
  801bc9:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801bcc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bcf:	c1 e8 0c             	shr    $0xc,%eax
  801bd2:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  801bd5:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd8:	25 ff 0f 00 00       	and    $0xfff,%eax
  801bdd:	85 c0                	test   %eax,%eax
  801bdf:	74 03                	je     801be4 <malloc+0x1a9>
			x++;
  801be1:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  801be4:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  801beb:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  801bf2:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  801bf9:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  801c00:	e9 88 00 00 00       	jmp    801c8d <malloc+0x252>
			if(arr[k] == -10000){
  801c05:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801c08:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801c0f:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801c14:	75 64                	jne    801c7a <malloc+0x23f>
				uint32 w = 0 , i;
  801c16:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  801c1d:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801c20:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  801c23:	eb 06                	jmp    801c2b <malloc+0x1f0>
  801c25:	ff 45 b8             	incl   -0x48(%ebp)
  801c28:	ff 45 b4             	incl   -0x4c(%ebp)
  801c2b:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  801c32:	77 11                	ja     801c45 <malloc+0x20a>
  801c34:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801c37:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801c3e:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801c43:	74 e0                	je     801c25 <malloc+0x1ea>
				if(w <q && w >= x){
  801c45:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801c48:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  801c4b:	73 24                	jae    801c71 <malloc+0x236>
  801c4d:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801c50:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801c53:	72 1c                	jb     801c71 <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  801c55:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801c58:	89 45 c8             	mov    %eax,-0x38(%ebp)
  801c5b:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  801c62:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801c65:	89 45 c0             	mov    %eax,-0x40(%ebp)
  801c68:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801c6b:	48                   	dec    %eax
  801c6c:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801c6f:	eb 19                	jmp    801c8a <malloc+0x24f>
				}
				else {
					k = i - 1;
  801c71:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801c74:	48                   	dec    %eax
  801c75:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801c78:	eb 10                	jmp    801c8a <malloc+0x24f>
				}
			} else {
				k += arr[k];
  801c7a:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801c7d:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801c84:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  801c87:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  801c8a:	ff 45 bc             	incl   -0x44(%ebp)
  801c8d:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801c90:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801c95:	0f 86 6a ff ff ff    	jbe    801c05 <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  801c9b:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  801c9f:	75 07                	jne    801ca8 <malloc+0x26d>
  801ca1:	b8 00 00 00 00       	mov    $0x0,%eax
  801ca6:	eb 56                	jmp    801cfe <malloc+0x2c3>
	    q = idx;
  801ca8:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801cab:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  801cae:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  801cb5:	eb 16                	jmp    801ccd <malloc+0x292>
			arr[q++] = x;
  801cb7:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801cba:	8d 50 01             	lea    0x1(%eax),%edx
  801cbd:	89 55 c8             	mov    %edx,-0x38(%ebp)
  801cc0:	8b 55 cc             	mov    -0x34(%ebp),%edx
  801cc3:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  801cca:	ff 45 b0             	incl   -0x50(%ebp)
  801ccd:	8b 45 b0             	mov    -0x50(%ebp),%eax
  801cd0:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801cd3:	72 e2                	jb     801cb7 <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801cd5:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801cd8:	05 00 00 08 00       	add    $0x80000,%eax
  801cdd:	c1 e0 0c             	shl    $0xc,%eax
  801ce0:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  801ce3:	83 ec 08             	sub    $0x8,%esp
  801ce6:	ff 75 cc             	pushl  -0x34(%ebp)
  801ce9:	ff 75 a8             	pushl  -0x58(%ebp)
  801cec:	e8 27 03 00 00       	call   802018 <sys_allocateMem>
  801cf1:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801cf4:	8b 45 a8             	mov    -0x58(%ebp),%eax
  801cf7:	eb 05                	jmp    801cfe <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  801cf9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cfe:	c9                   	leave  
  801cff:	c3                   	ret    

00801d00 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801d00:	55                   	push   %ebp
  801d01:	89 e5                	mov    %esp,%ebp
  801d03:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  801d06:	8b 45 08             	mov    0x8(%ebp),%eax
  801d09:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801d0c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d0f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801d14:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  801d17:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1a:	05 00 00 00 80       	add    $0x80000000,%eax
  801d1f:	c1 e8 0c             	shr    $0xc,%eax
  801d22:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801d29:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801d2c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801d33:	8b 45 08             	mov    0x8(%ebp),%eax
  801d36:	05 00 00 00 80       	add    $0x80000000,%eax
  801d3b:	c1 e8 0c             	shr    $0xc,%eax
  801d3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801d41:	eb 14                	jmp    801d57 <free+0x57>
		arr[j] = -10000;
  801d43:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d46:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801d4d:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801d51:	ff 45 f4             	incl   -0xc(%ebp)
  801d54:	ff 45 f0             	incl   -0x10(%ebp)
  801d57:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d5a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801d5d:	72 e4                	jb     801d43 <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  801d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d62:	83 ec 08             	sub    $0x8,%esp
  801d65:	ff 75 e8             	pushl  -0x18(%ebp)
  801d68:	50                   	push   %eax
  801d69:	e8 8e 02 00 00       	call   801ffc <sys_freeMem>
  801d6e:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  801d71:	90                   	nop
  801d72:	c9                   	leave  
  801d73:	c3                   	ret    

00801d74 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801d74:	55                   	push   %ebp
  801d75:	89 e5                	mov    %esp,%ebp
  801d77:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d7a:	83 ec 04             	sub    $0x4,%esp
  801d7d:	68 64 2e 80 00       	push   $0x802e64
  801d82:	68 9e 00 00 00       	push   $0x9e
  801d87:	68 87 2e 80 00       	push   $0x802e87
  801d8c:	e8 63 ea ff ff       	call   8007f4 <_panic>

00801d91 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801d91:	55                   	push   %ebp
  801d92:	89 e5                	mov    %esp,%ebp
  801d94:	83 ec 18             	sub    $0x18,%esp
  801d97:	8b 45 10             	mov    0x10(%ebp),%eax
  801d9a:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801d9d:	83 ec 04             	sub    $0x4,%esp
  801da0:	68 64 2e 80 00       	push   $0x802e64
  801da5:	68 a9 00 00 00       	push   $0xa9
  801daa:	68 87 2e 80 00       	push   $0x802e87
  801daf:	e8 40 ea ff ff       	call   8007f4 <_panic>

00801db4 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801db4:	55                   	push   %ebp
  801db5:	89 e5                	mov    %esp,%ebp
  801db7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801dba:	83 ec 04             	sub    $0x4,%esp
  801dbd:	68 64 2e 80 00       	push   $0x802e64
  801dc2:	68 af 00 00 00       	push   $0xaf
  801dc7:	68 87 2e 80 00       	push   $0x802e87
  801dcc:	e8 23 ea ff ff       	call   8007f4 <_panic>

00801dd1 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801dd1:	55                   	push   %ebp
  801dd2:	89 e5                	mov    %esp,%ebp
  801dd4:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801dd7:	83 ec 04             	sub    $0x4,%esp
  801dda:	68 64 2e 80 00       	push   $0x802e64
  801ddf:	68 b5 00 00 00       	push   $0xb5
  801de4:	68 87 2e 80 00       	push   $0x802e87
  801de9:	e8 06 ea ff ff       	call   8007f4 <_panic>

00801dee <expand>:
}

void expand(uint32 newSize)
{
  801dee:	55                   	push   %ebp
  801def:	89 e5                	mov    %esp,%ebp
  801df1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801df4:	83 ec 04             	sub    $0x4,%esp
  801df7:	68 64 2e 80 00       	push   $0x802e64
  801dfc:	68 ba 00 00 00       	push   $0xba
  801e01:	68 87 2e 80 00       	push   $0x802e87
  801e06:	e8 e9 e9 ff ff       	call   8007f4 <_panic>

00801e0b <shrink>:
}
void shrink(uint32 newSize)
{
  801e0b:	55                   	push   %ebp
  801e0c:	89 e5                	mov    %esp,%ebp
  801e0e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e11:	83 ec 04             	sub    $0x4,%esp
  801e14:	68 64 2e 80 00       	push   $0x802e64
  801e19:	68 be 00 00 00       	push   $0xbe
  801e1e:	68 87 2e 80 00       	push   $0x802e87
  801e23:	e8 cc e9 ff ff       	call   8007f4 <_panic>

00801e28 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801e28:	55                   	push   %ebp
  801e29:	89 e5                	mov    %esp,%ebp
  801e2b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e2e:	83 ec 04             	sub    $0x4,%esp
  801e31:	68 64 2e 80 00       	push   $0x802e64
  801e36:	68 c3 00 00 00       	push   $0xc3
  801e3b:	68 87 2e 80 00       	push   $0x802e87
  801e40:	e8 af e9 ff ff       	call   8007f4 <_panic>

00801e45 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801e45:	55                   	push   %ebp
  801e46:	89 e5                	mov    %esp,%ebp
  801e48:	57                   	push   %edi
  801e49:	56                   	push   %esi
  801e4a:	53                   	push   %ebx
  801e4b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801e4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e51:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e54:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e57:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e5a:	8b 7d 18             	mov    0x18(%ebp),%edi
  801e5d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801e60:	cd 30                	int    $0x30
  801e62:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801e65:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801e68:	83 c4 10             	add    $0x10,%esp
  801e6b:	5b                   	pop    %ebx
  801e6c:	5e                   	pop    %esi
  801e6d:	5f                   	pop    %edi
  801e6e:	5d                   	pop    %ebp
  801e6f:	c3                   	ret    

00801e70 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801e70:	55                   	push   %ebp
  801e71:	89 e5                	mov    %esp,%ebp
  801e73:	83 ec 04             	sub    $0x4,%esp
  801e76:	8b 45 10             	mov    0x10(%ebp),%eax
  801e79:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801e7c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e80:	8b 45 08             	mov    0x8(%ebp),%eax
  801e83:	6a 00                	push   $0x0
  801e85:	6a 00                	push   $0x0
  801e87:	52                   	push   %edx
  801e88:	ff 75 0c             	pushl  0xc(%ebp)
  801e8b:	50                   	push   %eax
  801e8c:	6a 00                	push   $0x0
  801e8e:	e8 b2 ff ff ff       	call   801e45 <syscall>
  801e93:	83 c4 18             	add    $0x18,%esp
}
  801e96:	90                   	nop
  801e97:	c9                   	leave  
  801e98:	c3                   	ret    

00801e99 <sys_cgetc>:

int
sys_cgetc(void)
{
  801e99:	55                   	push   %ebp
  801e9a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801e9c:	6a 00                	push   $0x0
  801e9e:	6a 00                	push   $0x0
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	6a 00                	push   $0x0
  801ea6:	6a 01                	push   $0x1
  801ea8:	e8 98 ff ff ff       	call   801e45 <syscall>
  801ead:	83 c4 18             	add    $0x18,%esp
}
  801eb0:	c9                   	leave  
  801eb1:	c3                   	ret    

00801eb2 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801eb2:	55                   	push   %ebp
  801eb3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801eb5:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb8:	6a 00                	push   $0x0
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 00                	push   $0x0
  801ec0:	50                   	push   %eax
  801ec1:	6a 05                	push   $0x5
  801ec3:	e8 7d ff ff ff       	call   801e45 <syscall>
  801ec8:	83 c4 18             	add    $0x18,%esp
}
  801ecb:	c9                   	leave  
  801ecc:	c3                   	ret    

00801ecd <sys_getenvid>:

int32 sys_getenvid(void)
{
  801ecd:	55                   	push   %ebp
  801ece:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801ed0:	6a 00                	push   $0x0
  801ed2:	6a 00                	push   $0x0
  801ed4:	6a 00                	push   $0x0
  801ed6:	6a 00                	push   $0x0
  801ed8:	6a 00                	push   $0x0
  801eda:	6a 02                	push   $0x2
  801edc:	e8 64 ff ff ff       	call   801e45 <syscall>
  801ee1:	83 c4 18             	add    $0x18,%esp
}
  801ee4:	c9                   	leave  
  801ee5:	c3                   	ret    

00801ee6 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ee6:	55                   	push   %ebp
  801ee7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801ee9:	6a 00                	push   $0x0
  801eeb:	6a 00                	push   $0x0
  801eed:	6a 00                	push   $0x0
  801eef:	6a 00                	push   $0x0
  801ef1:	6a 00                	push   $0x0
  801ef3:	6a 03                	push   $0x3
  801ef5:	e8 4b ff ff ff       	call   801e45 <syscall>
  801efa:	83 c4 18             	add    $0x18,%esp
}
  801efd:	c9                   	leave  
  801efe:	c3                   	ret    

00801eff <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801eff:	55                   	push   %ebp
  801f00:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801f02:	6a 00                	push   $0x0
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	6a 00                	push   $0x0
  801f0a:	6a 00                	push   $0x0
  801f0c:	6a 04                	push   $0x4
  801f0e:	e8 32 ff ff ff       	call   801e45 <syscall>
  801f13:	83 c4 18             	add    $0x18,%esp
}
  801f16:	c9                   	leave  
  801f17:	c3                   	ret    

00801f18 <sys_env_exit>:


void sys_env_exit(void)
{
  801f18:	55                   	push   %ebp
  801f19:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801f1b:	6a 00                	push   $0x0
  801f1d:	6a 00                	push   $0x0
  801f1f:	6a 00                	push   $0x0
  801f21:	6a 00                	push   $0x0
  801f23:	6a 00                	push   $0x0
  801f25:	6a 06                	push   $0x6
  801f27:	e8 19 ff ff ff       	call   801e45 <syscall>
  801f2c:	83 c4 18             	add    $0x18,%esp
}
  801f2f:	90                   	nop
  801f30:	c9                   	leave  
  801f31:	c3                   	ret    

00801f32 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801f32:	55                   	push   %ebp
  801f33:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801f35:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f38:	8b 45 08             	mov    0x8(%ebp),%eax
  801f3b:	6a 00                	push   $0x0
  801f3d:	6a 00                	push   $0x0
  801f3f:	6a 00                	push   $0x0
  801f41:	52                   	push   %edx
  801f42:	50                   	push   %eax
  801f43:	6a 07                	push   $0x7
  801f45:	e8 fb fe ff ff       	call   801e45 <syscall>
  801f4a:	83 c4 18             	add    $0x18,%esp
}
  801f4d:	c9                   	leave  
  801f4e:	c3                   	ret    

00801f4f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801f4f:	55                   	push   %ebp
  801f50:	89 e5                	mov    %esp,%ebp
  801f52:	56                   	push   %esi
  801f53:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801f54:	8b 75 18             	mov    0x18(%ebp),%esi
  801f57:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f5a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f5d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f60:	8b 45 08             	mov    0x8(%ebp),%eax
  801f63:	56                   	push   %esi
  801f64:	53                   	push   %ebx
  801f65:	51                   	push   %ecx
  801f66:	52                   	push   %edx
  801f67:	50                   	push   %eax
  801f68:	6a 08                	push   $0x8
  801f6a:	e8 d6 fe ff ff       	call   801e45 <syscall>
  801f6f:	83 c4 18             	add    $0x18,%esp
}
  801f72:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801f75:	5b                   	pop    %ebx
  801f76:	5e                   	pop    %esi
  801f77:	5d                   	pop    %ebp
  801f78:	c3                   	ret    

00801f79 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801f79:	55                   	push   %ebp
  801f7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801f7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	6a 00                	push   $0x0
  801f88:	52                   	push   %edx
  801f89:	50                   	push   %eax
  801f8a:	6a 09                	push   $0x9
  801f8c:	e8 b4 fe ff ff       	call   801e45 <syscall>
  801f91:	83 c4 18             	add    $0x18,%esp
}
  801f94:	c9                   	leave  
  801f95:	c3                   	ret    

00801f96 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801f96:	55                   	push   %ebp
  801f97:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801f99:	6a 00                	push   $0x0
  801f9b:	6a 00                	push   $0x0
  801f9d:	6a 00                	push   $0x0
  801f9f:	ff 75 0c             	pushl  0xc(%ebp)
  801fa2:	ff 75 08             	pushl  0x8(%ebp)
  801fa5:	6a 0a                	push   $0xa
  801fa7:	e8 99 fe ff ff       	call   801e45 <syscall>
  801fac:	83 c4 18             	add    $0x18,%esp
}
  801faf:	c9                   	leave  
  801fb0:	c3                   	ret    

00801fb1 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801fb1:	55                   	push   %ebp
  801fb2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801fb4:	6a 00                	push   $0x0
  801fb6:	6a 00                	push   $0x0
  801fb8:	6a 00                	push   $0x0
  801fba:	6a 00                	push   $0x0
  801fbc:	6a 00                	push   $0x0
  801fbe:	6a 0b                	push   $0xb
  801fc0:	e8 80 fe ff ff       	call   801e45 <syscall>
  801fc5:	83 c4 18             	add    $0x18,%esp
}
  801fc8:	c9                   	leave  
  801fc9:	c3                   	ret    

00801fca <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801fca:	55                   	push   %ebp
  801fcb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	6a 00                	push   $0x0
  801fd5:	6a 00                	push   $0x0
  801fd7:	6a 0c                	push   $0xc
  801fd9:	e8 67 fe ff ff       	call   801e45 <syscall>
  801fde:	83 c4 18             	add    $0x18,%esp
}
  801fe1:	c9                   	leave  
  801fe2:	c3                   	ret    

00801fe3 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801fe3:	55                   	push   %ebp
  801fe4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801fe6:	6a 00                	push   $0x0
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 00                	push   $0x0
  801fec:	6a 00                	push   $0x0
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 0d                	push   $0xd
  801ff2:	e8 4e fe ff ff       	call   801e45 <syscall>
  801ff7:	83 c4 18             	add    $0x18,%esp
}
  801ffa:	c9                   	leave  
  801ffb:	c3                   	ret    

00801ffc <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ffc:	55                   	push   %ebp
  801ffd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801fff:	6a 00                	push   $0x0
  802001:	6a 00                	push   $0x0
  802003:	6a 00                	push   $0x0
  802005:	ff 75 0c             	pushl  0xc(%ebp)
  802008:	ff 75 08             	pushl  0x8(%ebp)
  80200b:	6a 11                	push   $0x11
  80200d:	e8 33 fe ff ff       	call   801e45 <syscall>
  802012:	83 c4 18             	add    $0x18,%esp
	return;
  802015:	90                   	nop
}
  802016:	c9                   	leave  
  802017:	c3                   	ret    

00802018 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802018:	55                   	push   %ebp
  802019:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80201b:	6a 00                	push   $0x0
  80201d:	6a 00                	push   $0x0
  80201f:	6a 00                	push   $0x0
  802021:	ff 75 0c             	pushl  0xc(%ebp)
  802024:	ff 75 08             	pushl  0x8(%ebp)
  802027:	6a 12                	push   $0x12
  802029:	e8 17 fe ff ff       	call   801e45 <syscall>
  80202e:	83 c4 18             	add    $0x18,%esp
	return ;
  802031:	90                   	nop
}
  802032:	c9                   	leave  
  802033:	c3                   	ret    

00802034 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802034:	55                   	push   %ebp
  802035:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802037:	6a 00                	push   $0x0
  802039:	6a 00                	push   $0x0
  80203b:	6a 00                	push   $0x0
  80203d:	6a 00                	push   $0x0
  80203f:	6a 00                	push   $0x0
  802041:	6a 0e                	push   $0xe
  802043:	e8 fd fd ff ff       	call   801e45 <syscall>
  802048:	83 c4 18             	add    $0x18,%esp
}
  80204b:	c9                   	leave  
  80204c:	c3                   	ret    

0080204d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80204d:	55                   	push   %ebp
  80204e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802050:	6a 00                	push   $0x0
  802052:	6a 00                	push   $0x0
  802054:	6a 00                	push   $0x0
  802056:	6a 00                	push   $0x0
  802058:	ff 75 08             	pushl  0x8(%ebp)
  80205b:	6a 0f                	push   $0xf
  80205d:	e8 e3 fd ff ff       	call   801e45 <syscall>
  802062:	83 c4 18             	add    $0x18,%esp
}
  802065:	c9                   	leave  
  802066:	c3                   	ret    

00802067 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802067:	55                   	push   %ebp
  802068:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80206a:	6a 00                	push   $0x0
  80206c:	6a 00                	push   $0x0
  80206e:	6a 00                	push   $0x0
  802070:	6a 00                	push   $0x0
  802072:	6a 00                	push   $0x0
  802074:	6a 10                	push   $0x10
  802076:	e8 ca fd ff ff       	call   801e45 <syscall>
  80207b:	83 c4 18             	add    $0x18,%esp
}
  80207e:	90                   	nop
  80207f:	c9                   	leave  
  802080:	c3                   	ret    

00802081 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802081:	55                   	push   %ebp
  802082:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802084:	6a 00                	push   $0x0
  802086:	6a 00                	push   $0x0
  802088:	6a 00                	push   $0x0
  80208a:	6a 00                	push   $0x0
  80208c:	6a 00                	push   $0x0
  80208e:	6a 14                	push   $0x14
  802090:	e8 b0 fd ff ff       	call   801e45 <syscall>
  802095:	83 c4 18             	add    $0x18,%esp
}
  802098:	90                   	nop
  802099:	c9                   	leave  
  80209a:	c3                   	ret    

0080209b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80209b:	55                   	push   %ebp
  80209c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 00                	push   $0x0
  8020a4:	6a 00                	push   $0x0
  8020a6:	6a 00                	push   $0x0
  8020a8:	6a 15                	push   $0x15
  8020aa:	e8 96 fd ff ff       	call   801e45 <syscall>
  8020af:	83 c4 18             	add    $0x18,%esp
}
  8020b2:	90                   	nop
  8020b3:	c9                   	leave  
  8020b4:	c3                   	ret    

008020b5 <sys_cputc>:


void
sys_cputc(const char c)
{
  8020b5:	55                   	push   %ebp
  8020b6:	89 e5                	mov    %esp,%ebp
  8020b8:	83 ec 04             	sub    $0x4,%esp
  8020bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8020be:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8020c1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8020c5:	6a 00                	push   $0x0
  8020c7:	6a 00                	push   $0x0
  8020c9:	6a 00                	push   $0x0
  8020cb:	6a 00                	push   $0x0
  8020cd:	50                   	push   %eax
  8020ce:	6a 16                	push   $0x16
  8020d0:	e8 70 fd ff ff       	call   801e45 <syscall>
  8020d5:	83 c4 18             	add    $0x18,%esp
}
  8020d8:	90                   	nop
  8020d9:	c9                   	leave  
  8020da:	c3                   	ret    

008020db <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8020db:	55                   	push   %ebp
  8020dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8020de:	6a 00                	push   $0x0
  8020e0:	6a 00                	push   $0x0
  8020e2:	6a 00                	push   $0x0
  8020e4:	6a 00                	push   $0x0
  8020e6:	6a 00                	push   $0x0
  8020e8:	6a 17                	push   $0x17
  8020ea:	e8 56 fd ff ff       	call   801e45 <syscall>
  8020ef:	83 c4 18             	add    $0x18,%esp
}
  8020f2:	90                   	nop
  8020f3:	c9                   	leave  
  8020f4:	c3                   	ret    

008020f5 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8020f5:	55                   	push   %ebp
  8020f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8020f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8020fb:	6a 00                	push   $0x0
  8020fd:	6a 00                	push   $0x0
  8020ff:	6a 00                	push   $0x0
  802101:	ff 75 0c             	pushl  0xc(%ebp)
  802104:	50                   	push   %eax
  802105:	6a 18                	push   $0x18
  802107:	e8 39 fd ff ff       	call   801e45 <syscall>
  80210c:	83 c4 18             	add    $0x18,%esp
}
  80210f:	c9                   	leave  
  802110:	c3                   	ret    

00802111 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802111:	55                   	push   %ebp
  802112:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802114:	8b 55 0c             	mov    0xc(%ebp),%edx
  802117:	8b 45 08             	mov    0x8(%ebp),%eax
  80211a:	6a 00                	push   $0x0
  80211c:	6a 00                	push   $0x0
  80211e:	6a 00                	push   $0x0
  802120:	52                   	push   %edx
  802121:	50                   	push   %eax
  802122:	6a 1b                	push   $0x1b
  802124:	e8 1c fd ff ff       	call   801e45 <syscall>
  802129:	83 c4 18             	add    $0x18,%esp
}
  80212c:	c9                   	leave  
  80212d:	c3                   	ret    

0080212e <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80212e:	55                   	push   %ebp
  80212f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802131:	8b 55 0c             	mov    0xc(%ebp),%edx
  802134:	8b 45 08             	mov    0x8(%ebp),%eax
  802137:	6a 00                	push   $0x0
  802139:	6a 00                	push   $0x0
  80213b:	6a 00                	push   $0x0
  80213d:	52                   	push   %edx
  80213e:	50                   	push   %eax
  80213f:	6a 19                	push   $0x19
  802141:	e8 ff fc ff ff       	call   801e45 <syscall>
  802146:	83 c4 18             	add    $0x18,%esp
}
  802149:	90                   	nop
  80214a:	c9                   	leave  
  80214b:	c3                   	ret    

0080214c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80214c:	55                   	push   %ebp
  80214d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80214f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802152:	8b 45 08             	mov    0x8(%ebp),%eax
  802155:	6a 00                	push   $0x0
  802157:	6a 00                	push   $0x0
  802159:	6a 00                	push   $0x0
  80215b:	52                   	push   %edx
  80215c:	50                   	push   %eax
  80215d:	6a 1a                	push   $0x1a
  80215f:	e8 e1 fc ff ff       	call   801e45 <syscall>
  802164:	83 c4 18             	add    $0x18,%esp
}
  802167:	90                   	nop
  802168:	c9                   	leave  
  802169:	c3                   	ret    

0080216a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80216a:	55                   	push   %ebp
  80216b:	89 e5                	mov    %esp,%ebp
  80216d:	83 ec 04             	sub    $0x4,%esp
  802170:	8b 45 10             	mov    0x10(%ebp),%eax
  802173:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802176:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802179:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80217d:	8b 45 08             	mov    0x8(%ebp),%eax
  802180:	6a 00                	push   $0x0
  802182:	51                   	push   %ecx
  802183:	52                   	push   %edx
  802184:	ff 75 0c             	pushl  0xc(%ebp)
  802187:	50                   	push   %eax
  802188:	6a 1c                	push   $0x1c
  80218a:	e8 b6 fc ff ff       	call   801e45 <syscall>
  80218f:	83 c4 18             	add    $0x18,%esp
}
  802192:	c9                   	leave  
  802193:	c3                   	ret    

00802194 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802194:	55                   	push   %ebp
  802195:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802197:	8b 55 0c             	mov    0xc(%ebp),%edx
  80219a:	8b 45 08             	mov    0x8(%ebp),%eax
  80219d:	6a 00                	push   $0x0
  80219f:	6a 00                	push   $0x0
  8021a1:	6a 00                	push   $0x0
  8021a3:	52                   	push   %edx
  8021a4:	50                   	push   %eax
  8021a5:	6a 1d                	push   $0x1d
  8021a7:	e8 99 fc ff ff       	call   801e45 <syscall>
  8021ac:	83 c4 18             	add    $0x18,%esp
}
  8021af:	c9                   	leave  
  8021b0:	c3                   	ret    

008021b1 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8021b1:	55                   	push   %ebp
  8021b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8021b4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8021b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8021bd:	6a 00                	push   $0x0
  8021bf:	6a 00                	push   $0x0
  8021c1:	51                   	push   %ecx
  8021c2:	52                   	push   %edx
  8021c3:	50                   	push   %eax
  8021c4:	6a 1e                	push   $0x1e
  8021c6:	e8 7a fc ff ff       	call   801e45 <syscall>
  8021cb:	83 c4 18             	add    $0x18,%esp
}
  8021ce:	c9                   	leave  
  8021cf:	c3                   	ret    

008021d0 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8021d0:	55                   	push   %ebp
  8021d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8021d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8021d9:	6a 00                	push   $0x0
  8021db:	6a 00                	push   $0x0
  8021dd:	6a 00                	push   $0x0
  8021df:	52                   	push   %edx
  8021e0:	50                   	push   %eax
  8021e1:	6a 1f                	push   $0x1f
  8021e3:	e8 5d fc ff ff       	call   801e45 <syscall>
  8021e8:	83 c4 18             	add    $0x18,%esp
}
  8021eb:	c9                   	leave  
  8021ec:	c3                   	ret    

008021ed <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8021ed:	55                   	push   %ebp
  8021ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8021f0:	6a 00                	push   $0x0
  8021f2:	6a 00                	push   $0x0
  8021f4:	6a 00                	push   $0x0
  8021f6:	6a 00                	push   $0x0
  8021f8:	6a 00                	push   $0x0
  8021fa:	6a 20                	push   $0x20
  8021fc:	e8 44 fc ff ff       	call   801e45 <syscall>
  802201:	83 c4 18             	add    $0x18,%esp
}
  802204:	c9                   	leave  
  802205:	c3                   	ret    

00802206 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802206:	55                   	push   %ebp
  802207:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802209:	8b 45 08             	mov    0x8(%ebp),%eax
  80220c:	6a 00                	push   $0x0
  80220e:	ff 75 14             	pushl  0x14(%ebp)
  802211:	ff 75 10             	pushl  0x10(%ebp)
  802214:	ff 75 0c             	pushl  0xc(%ebp)
  802217:	50                   	push   %eax
  802218:	6a 21                	push   $0x21
  80221a:	e8 26 fc ff ff       	call   801e45 <syscall>
  80221f:	83 c4 18             	add    $0x18,%esp
}
  802222:	c9                   	leave  
  802223:	c3                   	ret    

00802224 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  802224:	55                   	push   %ebp
  802225:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802227:	8b 45 08             	mov    0x8(%ebp),%eax
  80222a:	6a 00                	push   $0x0
  80222c:	6a 00                	push   $0x0
  80222e:	6a 00                	push   $0x0
  802230:	6a 00                	push   $0x0
  802232:	50                   	push   %eax
  802233:	6a 22                	push   $0x22
  802235:	e8 0b fc ff ff       	call   801e45 <syscall>
  80223a:	83 c4 18             	add    $0x18,%esp
}
  80223d:	90                   	nop
  80223e:	c9                   	leave  
  80223f:	c3                   	ret    

00802240 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802240:	55                   	push   %ebp
  802241:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802243:	8b 45 08             	mov    0x8(%ebp),%eax
  802246:	6a 00                	push   $0x0
  802248:	6a 00                	push   $0x0
  80224a:	6a 00                	push   $0x0
  80224c:	6a 00                	push   $0x0
  80224e:	50                   	push   %eax
  80224f:	6a 23                	push   $0x23
  802251:	e8 ef fb ff ff       	call   801e45 <syscall>
  802256:	83 c4 18             	add    $0x18,%esp
}
  802259:	90                   	nop
  80225a:	c9                   	leave  
  80225b:	c3                   	ret    

0080225c <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80225c:	55                   	push   %ebp
  80225d:	89 e5                	mov    %esp,%ebp
  80225f:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802262:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802265:	8d 50 04             	lea    0x4(%eax),%edx
  802268:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80226b:	6a 00                	push   $0x0
  80226d:	6a 00                	push   $0x0
  80226f:	6a 00                	push   $0x0
  802271:	52                   	push   %edx
  802272:	50                   	push   %eax
  802273:	6a 24                	push   $0x24
  802275:	e8 cb fb ff ff       	call   801e45 <syscall>
  80227a:	83 c4 18             	add    $0x18,%esp
	return result;
  80227d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802280:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802283:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802286:	89 01                	mov    %eax,(%ecx)
  802288:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80228b:	8b 45 08             	mov    0x8(%ebp),%eax
  80228e:	c9                   	leave  
  80228f:	c2 04 00             	ret    $0x4

00802292 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802292:	55                   	push   %ebp
  802293:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802295:	6a 00                	push   $0x0
  802297:	6a 00                	push   $0x0
  802299:	ff 75 10             	pushl  0x10(%ebp)
  80229c:	ff 75 0c             	pushl  0xc(%ebp)
  80229f:	ff 75 08             	pushl  0x8(%ebp)
  8022a2:	6a 13                	push   $0x13
  8022a4:	e8 9c fb ff ff       	call   801e45 <syscall>
  8022a9:	83 c4 18             	add    $0x18,%esp
	return ;
  8022ac:	90                   	nop
}
  8022ad:	c9                   	leave  
  8022ae:	c3                   	ret    

008022af <sys_rcr2>:
uint32 sys_rcr2()
{
  8022af:	55                   	push   %ebp
  8022b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8022b2:	6a 00                	push   $0x0
  8022b4:	6a 00                	push   $0x0
  8022b6:	6a 00                	push   $0x0
  8022b8:	6a 00                	push   $0x0
  8022ba:	6a 00                	push   $0x0
  8022bc:	6a 25                	push   $0x25
  8022be:	e8 82 fb ff ff       	call   801e45 <syscall>
  8022c3:	83 c4 18             	add    $0x18,%esp
}
  8022c6:	c9                   	leave  
  8022c7:	c3                   	ret    

008022c8 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8022c8:	55                   	push   %ebp
  8022c9:	89 e5                	mov    %esp,%ebp
  8022cb:	83 ec 04             	sub    $0x4,%esp
  8022ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8022d1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8022d4:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8022d8:	6a 00                	push   $0x0
  8022da:	6a 00                	push   $0x0
  8022dc:	6a 00                	push   $0x0
  8022de:	6a 00                	push   $0x0
  8022e0:	50                   	push   %eax
  8022e1:	6a 26                	push   $0x26
  8022e3:	e8 5d fb ff ff       	call   801e45 <syscall>
  8022e8:	83 c4 18             	add    $0x18,%esp
	return ;
  8022eb:	90                   	nop
}
  8022ec:	c9                   	leave  
  8022ed:	c3                   	ret    

008022ee <rsttst>:
void rsttst()
{
  8022ee:	55                   	push   %ebp
  8022ef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8022f1:	6a 00                	push   $0x0
  8022f3:	6a 00                	push   $0x0
  8022f5:	6a 00                	push   $0x0
  8022f7:	6a 00                	push   $0x0
  8022f9:	6a 00                	push   $0x0
  8022fb:	6a 28                	push   $0x28
  8022fd:	e8 43 fb ff ff       	call   801e45 <syscall>
  802302:	83 c4 18             	add    $0x18,%esp
	return ;
  802305:	90                   	nop
}
  802306:	c9                   	leave  
  802307:	c3                   	ret    

00802308 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802308:	55                   	push   %ebp
  802309:	89 e5                	mov    %esp,%ebp
  80230b:	83 ec 04             	sub    $0x4,%esp
  80230e:	8b 45 14             	mov    0x14(%ebp),%eax
  802311:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802314:	8b 55 18             	mov    0x18(%ebp),%edx
  802317:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80231b:	52                   	push   %edx
  80231c:	50                   	push   %eax
  80231d:	ff 75 10             	pushl  0x10(%ebp)
  802320:	ff 75 0c             	pushl  0xc(%ebp)
  802323:	ff 75 08             	pushl  0x8(%ebp)
  802326:	6a 27                	push   $0x27
  802328:	e8 18 fb ff ff       	call   801e45 <syscall>
  80232d:	83 c4 18             	add    $0x18,%esp
	return ;
  802330:	90                   	nop
}
  802331:	c9                   	leave  
  802332:	c3                   	ret    

00802333 <chktst>:
void chktst(uint32 n)
{
  802333:	55                   	push   %ebp
  802334:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802336:	6a 00                	push   $0x0
  802338:	6a 00                	push   $0x0
  80233a:	6a 00                	push   $0x0
  80233c:	6a 00                	push   $0x0
  80233e:	ff 75 08             	pushl  0x8(%ebp)
  802341:	6a 29                	push   $0x29
  802343:	e8 fd fa ff ff       	call   801e45 <syscall>
  802348:	83 c4 18             	add    $0x18,%esp
	return ;
  80234b:	90                   	nop
}
  80234c:	c9                   	leave  
  80234d:	c3                   	ret    

0080234e <inctst>:

void inctst()
{
  80234e:	55                   	push   %ebp
  80234f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802351:	6a 00                	push   $0x0
  802353:	6a 00                	push   $0x0
  802355:	6a 00                	push   $0x0
  802357:	6a 00                	push   $0x0
  802359:	6a 00                	push   $0x0
  80235b:	6a 2a                	push   $0x2a
  80235d:	e8 e3 fa ff ff       	call   801e45 <syscall>
  802362:	83 c4 18             	add    $0x18,%esp
	return ;
  802365:	90                   	nop
}
  802366:	c9                   	leave  
  802367:	c3                   	ret    

00802368 <gettst>:
uint32 gettst()
{
  802368:	55                   	push   %ebp
  802369:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80236b:	6a 00                	push   $0x0
  80236d:	6a 00                	push   $0x0
  80236f:	6a 00                	push   $0x0
  802371:	6a 00                	push   $0x0
  802373:	6a 00                	push   $0x0
  802375:	6a 2b                	push   $0x2b
  802377:	e8 c9 fa ff ff       	call   801e45 <syscall>
  80237c:	83 c4 18             	add    $0x18,%esp
}
  80237f:	c9                   	leave  
  802380:	c3                   	ret    

00802381 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802381:	55                   	push   %ebp
  802382:	89 e5                	mov    %esp,%ebp
  802384:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802387:	6a 00                	push   $0x0
  802389:	6a 00                	push   $0x0
  80238b:	6a 00                	push   $0x0
  80238d:	6a 00                	push   $0x0
  80238f:	6a 00                	push   $0x0
  802391:	6a 2c                	push   $0x2c
  802393:	e8 ad fa ff ff       	call   801e45 <syscall>
  802398:	83 c4 18             	add    $0x18,%esp
  80239b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80239e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8023a2:	75 07                	jne    8023ab <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8023a4:	b8 01 00 00 00       	mov    $0x1,%eax
  8023a9:	eb 05                	jmp    8023b0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8023ab:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023b0:	c9                   	leave  
  8023b1:	c3                   	ret    

008023b2 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8023b2:	55                   	push   %ebp
  8023b3:	89 e5                	mov    %esp,%ebp
  8023b5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023b8:	6a 00                	push   $0x0
  8023ba:	6a 00                	push   $0x0
  8023bc:	6a 00                	push   $0x0
  8023be:	6a 00                	push   $0x0
  8023c0:	6a 00                	push   $0x0
  8023c2:	6a 2c                	push   $0x2c
  8023c4:	e8 7c fa ff ff       	call   801e45 <syscall>
  8023c9:	83 c4 18             	add    $0x18,%esp
  8023cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8023cf:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8023d3:	75 07                	jne    8023dc <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8023d5:	b8 01 00 00 00       	mov    $0x1,%eax
  8023da:	eb 05                	jmp    8023e1 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8023dc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023e1:	c9                   	leave  
  8023e2:	c3                   	ret    

008023e3 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8023e3:	55                   	push   %ebp
  8023e4:	89 e5                	mov    %esp,%ebp
  8023e6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023e9:	6a 00                	push   $0x0
  8023eb:	6a 00                	push   $0x0
  8023ed:	6a 00                	push   $0x0
  8023ef:	6a 00                	push   $0x0
  8023f1:	6a 00                	push   $0x0
  8023f3:	6a 2c                	push   $0x2c
  8023f5:	e8 4b fa ff ff       	call   801e45 <syscall>
  8023fa:	83 c4 18             	add    $0x18,%esp
  8023fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802400:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802404:	75 07                	jne    80240d <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802406:	b8 01 00 00 00       	mov    $0x1,%eax
  80240b:	eb 05                	jmp    802412 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80240d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802412:	c9                   	leave  
  802413:	c3                   	ret    

00802414 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802414:	55                   	push   %ebp
  802415:	89 e5                	mov    %esp,%ebp
  802417:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80241a:	6a 00                	push   $0x0
  80241c:	6a 00                	push   $0x0
  80241e:	6a 00                	push   $0x0
  802420:	6a 00                	push   $0x0
  802422:	6a 00                	push   $0x0
  802424:	6a 2c                	push   $0x2c
  802426:	e8 1a fa ff ff       	call   801e45 <syscall>
  80242b:	83 c4 18             	add    $0x18,%esp
  80242e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802431:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802435:	75 07                	jne    80243e <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802437:	b8 01 00 00 00       	mov    $0x1,%eax
  80243c:	eb 05                	jmp    802443 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80243e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802443:	c9                   	leave  
  802444:	c3                   	ret    

00802445 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802445:	55                   	push   %ebp
  802446:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802448:	6a 00                	push   $0x0
  80244a:	6a 00                	push   $0x0
  80244c:	6a 00                	push   $0x0
  80244e:	6a 00                	push   $0x0
  802450:	ff 75 08             	pushl  0x8(%ebp)
  802453:	6a 2d                	push   $0x2d
  802455:	e8 eb f9 ff ff       	call   801e45 <syscall>
  80245a:	83 c4 18             	add    $0x18,%esp
	return ;
  80245d:	90                   	nop
}
  80245e:	c9                   	leave  
  80245f:	c3                   	ret    

00802460 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802460:	55                   	push   %ebp
  802461:	89 e5                	mov    %esp,%ebp
  802463:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802464:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802467:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80246a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80246d:	8b 45 08             	mov    0x8(%ebp),%eax
  802470:	6a 00                	push   $0x0
  802472:	53                   	push   %ebx
  802473:	51                   	push   %ecx
  802474:	52                   	push   %edx
  802475:	50                   	push   %eax
  802476:	6a 2e                	push   $0x2e
  802478:	e8 c8 f9 ff ff       	call   801e45 <syscall>
  80247d:	83 c4 18             	add    $0x18,%esp
}
  802480:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802483:	c9                   	leave  
  802484:	c3                   	ret    

00802485 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802485:	55                   	push   %ebp
  802486:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802488:	8b 55 0c             	mov    0xc(%ebp),%edx
  80248b:	8b 45 08             	mov    0x8(%ebp),%eax
  80248e:	6a 00                	push   $0x0
  802490:	6a 00                	push   $0x0
  802492:	6a 00                	push   $0x0
  802494:	52                   	push   %edx
  802495:	50                   	push   %eax
  802496:	6a 2f                	push   $0x2f
  802498:	e8 a8 f9 ff ff       	call   801e45 <syscall>
  80249d:	83 c4 18             	add    $0x18,%esp
}
  8024a0:	c9                   	leave  
  8024a1:	c3                   	ret    

008024a2 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8024a2:	55                   	push   %ebp
  8024a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8024a5:	6a 00                	push   $0x0
  8024a7:	6a 00                	push   $0x0
  8024a9:	6a 00                	push   $0x0
  8024ab:	ff 75 0c             	pushl  0xc(%ebp)
  8024ae:	ff 75 08             	pushl  0x8(%ebp)
  8024b1:	6a 30                	push   $0x30
  8024b3:	e8 8d f9 ff ff       	call   801e45 <syscall>
  8024b8:	83 c4 18             	add    $0x18,%esp
	return ;
  8024bb:	90                   	nop
}
  8024bc:	c9                   	leave  
  8024bd:	c3                   	ret    
  8024be:	66 90                	xchg   %ax,%ax

008024c0 <__udivdi3>:
  8024c0:	55                   	push   %ebp
  8024c1:	57                   	push   %edi
  8024c2:	56                   	push   %esi
  8024c3:	53                   	push   %ebx
  8024c4:	83 ec 1c             	sub    $0x1c,%esp
  8024c7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8024cb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8024cf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024d3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8024d7:	89 ca                	mov    %ecx,%edx
  8024d9:	89 f8                	mov    %edi,%eax
  8024db:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8024df:	85 f6                	test   %esi,%esi
  8024e1:	75 2d                	jne    802510 <__udivdi3+0x50>
  8024e3:	39 cf                	cmp    %ecx,%edi
  8024e5:	77 65                	ja     80254c <__udivdi3+0x8c>
  8024e7:	89 fd                	mov    %edi,%ebp
  8024e9:	85 ff                	test   %edi,%edi
  8024eb:	75 0b                	jne    8024f8 <__udivdi3+0x38>
  8024ed:	b8 01 00 00 00       	mov    $0x1,%eax
  8024f2:	31 d2                	xor    %edx,%edx
  8024f4:	f7 f7                	div    %edi
  8024f6:	89 c5                	mov    %eax,%ebp
  8024f8:	31 d2                	xor    %edx,%edx
  8024fa:	89 c8                	mov    %ecx,%eax
  8024fc:	f7 f5                	div    %ebp
  8024fe:	89 c1                	mov    %eax,%ecx
  802500:	89 d8                	mov    %ebx,%eax
  802502:	f7 f5                	div    %ebp
  802504:	89 cf                	mov    %ecx,%edi
  802506:	89 fa                	mov    %edi,%edx
  802508:	83 c4 1c             	add    $0x1c,%esp
  80250b:	5b                   	pop    %ebx
  80250c:	5e                   	pop    %esi
  80250d:	5f                   	pop    %edi
  80250e:	5d                   	pop    %ebp
  80250f:	c3                   	ret    
  802510:	39 ce                	cmp    %ecx,%esi
  802512:	77 28                	ja     80253c <__udivdi3+0x7c>
  802514:	0f bd fe             	bsr    %esi,%edi
  802517:	83 f7 1f             	xor    $0x1f,%edi
  80251a:	75 40                	jne    80255c <__udivdi3+0x9c>
  80251c:	39 ce                	cmp    %ecx,%esi
  80251e:	72 0a                	jb     80252a <__udivdi3+0x6a>
  802520:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802524:	0f 87 9e 00 00 00    	ja     8025c8 <__udivdi3+0x108>
  80252a:	b8 01 00 00 00       	mov    $0x1,%eax
  80252f:	89 fa                	mov    %edi,%edx
  802531:	83 c4 1c             	add    $0x1c,%esp
  802534:	5b                   	pop    %ebx
  802535:	5e                   	pop    %esi
  802536:	5f                   	pop    %edi
  802537:	5d                   	pop    %ebp
  802538:	c3                   	ret    
  802539:	8d 76 00             	lea    0x0(%esi),%esi
  80253c:	31 ff                	xor    %edi,%edi
  80253e:	31 c0                	xor    %eax,%eax
  802540:	89 fa                	mov    %edi,%edx
  802542:	83 c4 1c             	add    $0x1c,%esp
  802545:	5b                   	pop    %ebx
  802546:	5e                   	pop    %esi
  802547:	5f                   	pop    %edi
  802548:	5d                   	pop    %ebp
  802549:	c3                   	ret    
  80254a:	66 90                	xchg   %ax,%ax
  80254c:	89 d8                	mov    %ebx,%eax
  80254e:	f7 f7                	div    %edi
  802550:	31 ff                	xor    %edi,%edi
  802552:	89 fa                	mov    %edi,%edx
  802554:	83 c4 1c             	add    $0x1c,%esp
  802557:	5b                   	pop    %ebx
  802558:	5e                   	pop    %esi
  802559:	5f                   	pop    %edi
  80255a:	5d                   	pop    %ebp
  80255b:	c3                   	ret    
  80255c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802561:	89 eb                	mov    %ebp,%ebx
  802563:	29 fb                	sub    %edi,%ebx
  802565:	89 f9                	mov    %edi,%ecx
  802567:	d3 e6                	shl    %cl,%esi
  802569:	89 c5                	mov    %eax,%ebp
  80256b:	88 d9                	mov    %bl,%cl
  80256d:	d3 ed                	shr    %cl,%ebp
  80256f:	89 e9                	mov    %ebp,%ecx
  802571:	09 f1                	or     %esi,%ecx
  802573:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802577:	89 f9                	mov    %edi,%ecx
  802579:	d3 e0                	shl    %cl,%eax
  80257b:	89 c5                	mov    %eax,%ebp
  80257d:	89 d6                	mov    %edx,%esi
  80257f:	88 d9                	mov    %bl,%cl
  802581:	d3 ee                	shr    %cl,%esi
  802583:	89 f9                	mov    %edi,%ecx
  802585:	d3 e2                	shl    %cl,%edx
  802587:	8b 44 24 08          	mov    0x8(%esp),%eax
  80258b:	88 d9                	mov    %bl,%cl
  80258d:	d3 e8                	shr    %cl,%eax
  80258f:	09 c2                	or     %eax,%edx
  802591:	89 d0                	mov    %edx,%eax
  802593:	89 f2                	mov    %esi,%edx
  802595:	f7 74 24 0c          	divl   0xc(%esp)
  802599:	89 d6                	mov    %edx,%esi
  80259b:	89 c3                	mov    %eax,%ebx
  80259d:	f7 e5                	mul    %ebp
  80259f:	39 d6                	cmp    %edx,%esi
  8025a1:	72 19                	jb     8025bc <__udivdi3+0xfc>
  8025a3:	74 0b                	je     8025b0 <__udivdi3+0xf0>
  8025a5:	89 d8                	mov    %ebx,%eax
  8025a7:	31 ff                	xor    %edi,%edi
  8025a9:	e9 58 ff ff ff       	jmp    802506 <__udivdi3+0x46>
  8025ae:	66 90                	xchg   %ax,%ax
  8025b0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8025b4:	89 f9                	mov    %edi,%ecx
  8025b6:	d3 e2                	shl    %cl,%edx
  8025b8:	39 c2                	cmp    %eax,%edx
  8025ba:	73 e9                	jae    8025a5 <__udivdi3+0xe5>
  8025bc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8025bf:	31 ff                	xor    %edi,%edi
  8025c1:	e9 40 ff ff ff       	jmp    802506 <__udivdi3+0x46>
  8025c6:	66 90                	xchg   %ax,%ax
  8025c8:	31 c0                	xor    %eax,%eax
  8025ca:	e9 37 ff ff ff       	jmp    802506 <__udivdi3+0x46>
  8025cf:	90                   	nop

008025d0 <__umoddi3>:
  8025d0:	55                   	push   %ebp
  8025d1:	57                   	push   %edi
  8025d2:	56                   	push   %esi
  8025d3:	53                   	push   %ebx
  8025d4:	83 ec 1c             	sub    $0x1c,%esp
  8025d7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8025db:	8b 74 24 34          	mov    0x34(%esp),%esi
  8025df:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8025e3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8025e7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8025eb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8025ef:	89 f3                	mov    %esi,%ebx
  8025f1:	89 fa                	mov    %edi,%edx
  8025f3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8025f7:	89 34 24             	mov    %esi,(%esp)
  8025fa:	85 c0                	test   %eax,%eax
  8025fc:	75 1a                	jne    802618 <__umoddi3+0x48>
  8025fe:	39 f7                	cmp    %esi,%edi
  802600:	0f 86 a2 00 00 00    	jbe    8026a8 <__umoddi3+0xd8>
  802606:	89 c8                	mov    %ecx,%eax
  802608:	89 f2                	mov    %esi,%edx
  80260a:	f7 f7                	div    %edi
  80260c:	89 d0                	mov    %edx,%eax
  80260e:	31 d2                	xor    %edx,%edx
  802610:	83 c4 1c             	add    $0x1c,%esp
  802613:	5b                   	pop    %ebx
  802614:	5e                   	pop    %esi
  802615:	5f                   	pop    %edi
  802616:	5d                   	pop    %ebp
  802617:	c3                   	ret    
  802618:	39 f0                	cmp    %esi,%eax
  80261a:	0f 87 ac 00 00 00    	ja     8026cc <__umoddi3+0xfc>
  802620:	0f bd e8             	bsr    %eax,%ebp
  802623:	83 f5 1f             	xor    $0x1f,%ebp
  802626:	0f 84 ac 00 00 00    	je     8026d8 <__umoddi3+0x108>
  80262c:	bf 20 00 00 00       	mov    $0x20,%edi
  802631:	29 ef                	sub    %ebp,%edi
  802633:	89 fe                	mov    %edi,%esi
  802635:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802639:	89 e9                	mov    %ebp,%ecx
  80263b:	d3 e0                	shl    %cl,%eax
  80263d:	89 d7                	mov    %edx,%edi
  80263f:	89 f1                	mov    %esi,%ecx
  802641:	d3 ef                	shr    %cl,%edi
  802643:	09 c7                	or     %eax,%edi
  802645:	89 e9                	mov    %ebp,%ecx
  802647:	d3 e2                	shl    %cl,%edx
  802649:	89 14 24             	mov    %edx,(%esp)
  80264c:	89 d8                	mov    %ebx,%eax
  80264e:	d3 e0                	shl    %cl,%eax
  802650:	89 c2                	mov    %eax,%edx
  802652:	8b 44 24 08          	mov    0x8(%esp),%eax
  802656:	d3 e0                	shl    %cl,%eax
  802658:	89 44 24 04          	mov    %eax,0x4(%esp)
  80265c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802660:	89 f1                	mov    %esi,%ecx
  802662:	d3 e8                	shr    %cl,%eax
  802664:	09 d0                	or     %edx,%eax
  802666:	d3 eb                	shr    %cl,%ebx
  802668:	89 da                	mov    %ebx,%edx
  80266a:	f7 f7                	div    %edi
  80266c:	89 d3                	mov    %edx,%ebx
  80266e:	f7 24 24             	mull   (%esp)
  802671:	89 c6                	mov    %eax,%esi
  802673:	89 d1                	mov    %edx,%ecx
  802675:	39 d3                	cmp    %edx,%ebx
  802677:	0f 82 87 00 00 00    	jb     802704 <__umoddi3+0x134>
  80267d:	0f 84 91 00 00 00    	je     802714 <__umoddi3+0x144>
  802683:	8b 54 24 04          	mov    0x4(%esp),%edx
  802687:	29 f2                	sub    %esi,%edx
  802689:	19 cb                	sbb    %ecx,%ebx
  80268b:	89 d8                	mov    %ebx,%eax
  80268d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802691:	d3 e0                	shl    %cl,%eax
  802693:	89 e9                	mov    %ebp,%ecx
  802695:	d3 ea                	shr    %cl,%edx
  802697:	09 d0                	or     %edx,%eax
  802699:	89 e9                	mov    %ebp,%ecx
  80269b:	d3 eb                	shr    %cl,%ebx
  80269d:	89 da                	mov    %ebx,%edx
  80269f:	83 c4 1c             	add    $0x1c,%esp
  8026a2:	5b                   	pop    %ebx
  8026a3:	5e                   	pop    %esi
  8026a4:	5f                   	pop    %edi
  8026a5:	5d                   	pop    %ebp
  8026a6:	c3                   	ret    
  8026a7:	90                   	nop
  8026a8:	89 fd                	mov    %edi,%ebp
  8026aa:	85 ff                	test   %edi,%edi
  8026ac:	75 0b                	jne    8026b9 <__umoddi3+0xe9>
  8026ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8026b3:	31 d2                	xor    %edx,%edx
  8026b5:	f7 f7                	div    %edi
  8026b7:	89 c5                	mov    %eax,%ebp
  8026b9:	89 f0                	mov    %esi,%eax
  8026bb:	31 d2                	xor    %edx,%edx
  8026bd:	f7 f5                	div    %ebp
  8026bf:	89 c8                	mov    %ecx,%eax
  8026c1:	f7 f5                	div    %ebp
  8026c3:	89 d0                	mov    %edx,%eax
  8026c5:	e9 44 ff ff ff       	jmp    80260e <__umoddi3+0x3e>
  8026ca:	66 90                	xchg   %ax,%ax
  8026cc:	89 c8                	mov    %ecx,%eax
  8026ce:	89 f2                	mov    %esi,%edx
  8026d0:	83 c4 1c             	add    $0x1c,%esp
  8026d3:	5b                   	pop    %ebx
  8026d4:	5e                   	pop    %esi
  8026d5:	5f                   	pop    %edi
  8026d6:	5d                   	pop    %ebp
  8026d7:	c3                   	ret    
  8026d8:	3b 04 24             	cmp    (%esp),%eax
  8026db:	72 06                	jb     8026e3 <__umoddi3+0x113>
  8026dd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8026e1:	77 0f                	ja     8026f2 <__umoddi3+0x122>
  8026e3:	89 f2                	mov    %esi,%edx
  8026e5:	29 f9                	sub    %edi,%ecx
  8026e7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8026eb:	89 14 24             	mov    %edx,(%esp)
  8026ee:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8026f2:	8b 44 24 04          	mov    0x4(%esp),%eax
  8026f6:	8b 14 24             	mov    (%esp),%edx
  8026f9:	83 c4 1c             	add    $0x1c,%esp
  8026fc:	5b                   	pop    %ebx
  8026fd:	5e                   	pop    %esi
  8026fe:	5f                   	pop    %edi
  8026ff:	5d                   	pop    %ebp
  802700:	c3                   	ret    
  802701:	8d 76 00             	lea    0x0(%esi),%esi
  802704:	2b 04 24             	sub    (%esp),%eax
  802707:	19 fa                	sbb    %edi,%edx
  802709:	89 d1                	mov    %edx,%ecx
  80270b:	89 c6                	mov    %eax,%esi
  80270d:	e9 71 ff ff ff       	jmp    802683 <__umoddi3+0xb3>
  802712:	66 90                	xchg   %ax,%ax
  802714:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802718:	72 ea                	jb     802704 <__umoddi3+0x134>
  80271a:	89 d9                	mov    %ebx,%ecx
  80271c:	e9 62 ff ff ff       	jmp    802683 <__umoddi3+0xb3>
