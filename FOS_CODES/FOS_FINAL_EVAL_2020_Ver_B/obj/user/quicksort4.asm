
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
  800049:	e8 1e 1b 00 00       	call   801b6c <sys_getenvid>
  80004e:	89 45 e8             	mov    %eax,-0x18(%ebp)
	sys_createSemaphore("cs1", 1);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	6a 01                	push   $0x1
  800056:	68 e0 23 80 00       	push   $0x8023e0
  80005b:	e8 34 1d 00 00       	call   801d94 <sys_createSemaphore>
  800060:	83 c4 10             	add    $0x10,%esp
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800063:	e8 e8 1b 00 00       	call   801c50 <sys_calculate_free_frames>
  800068:	89 c3                	mov    %eax,%ebx
  80006a:	e8 fa 1b 00 00       	call   801c69 <sys_calculate_modified_frames>
  80006f:	01 d8                	add    %ebx,%eax
  800071:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		Iteration++ ;
  800074:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();
		sys_waitSemaphore(envID, "cs1");
  800077:	83 ec 08             	sub    $0x8,%esp
  80007a:	68 e0 23 80 00       	push   $0x8023e0
  80007f:	ff 75 e8             	pushl  -0x18(%ebp)
  800082:	e8 46 1d 00 00       	call   801dcd <sys_waitSemaphore>
  800087:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  80008a:	83 ec 08             	sub    $0x8,%esp
  80008d:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  800093:	50                   	push   %eax
  800094:	68 e4 23 80 00       	push   $0x8023e4
  800099:	e8 48 10 00 00       	call   8010e6 <readline>
  80009e:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000a1:	83 ec 04             	sub    $0x4,%esp
  8000a4:	6a 0a                	push   $0xa
  8000a6:	6a 00                	push   $0x0
  8000a8:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  8000ae:	50                   	push   %eax
  8000af:	e8 98 15 00 00       	call   80164c <strtol>
  8000b4:	83 c4 10             	add    $0x10,%esp
  8000b7:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000bd:	c1 e0 02             	shl    $0x2,%eax
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	50                   	push   %eax
  8000c4:	e8 2b 19 00 00       	call   8019f4 <malloc>
  8000c9:	83 c4 10             	add    $0x10,%esp
  8000cc:	89 45 dc             	mov    %eax,-0x24(%ebp)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	68 04 24 80 00       	push   $0x802404
  8000d7:	e8 88 09 00 00       	call   800a64 <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	68 27 24 80 00       	push   $0x802427
  8000e7:	e8 78 09 00 00       	call   800a64 <cprintf>
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
  800114:	68 35 24 80 00       	push   $0x802435
  800119:	e8 46 09 00 00       	call   800a64 <cprintf>
  80011e:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800121:	83 ec 0c             	sub    $0xc,%esp
  800124:	68 44 24 80 00       	push   $0x802444
  800129:	e8 36 09 00 00       	call   800a64 <cprintf>
  80012e:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800131:	83 ec 0c             	sub    $0xc,%esp
  800134:	68 54 24 80 00       	push   $0x802454
  800139:	e8 26 09 00 00       	call   800a64 <cprintf>
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
  80017b:	68 e0 23 80 00       	push   $0x8023e0
  800180:	ff 75 e8             	pushl  -0x18(%ebp)
  800183:	e8 63 1c 00 00       	call   801deb <sys_signalSemaphore>
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
  800216:	68 60 24 80 00       	push   $0x802460
  80021b:	6a 4f                	push   $0x4f
  80021d:	68 82 24 80 00       	push   $0x802482
  800222:	e8 86 05 00 00       	call   8007ad <_panic>
		else
		{
			sys_waitSemaphore(envID, "cs1");
  800227:	83 ec 08             	sub    $0x8,%esp
  80022a:	68 e0 23 80 00       	push   $0x8023e0
  80022f:	ff 75 e8             	pushl  -0x18(%ebp)
  800232:	e8 96 1b 00 00       	call   801dcd <sys_waitSemaphore>
  800237:	83 c4 10             	add    $0x10,%esp
			cprintf("\n===============================================\n") ;
  80023a:	83 ec 0c             	sub    $0xc,%esp
  80023d:	68 94 24 80 00       	push   $0x802494
  800242:	e8 1d 08 00 00       	call   800a64 <cprintf>
  800247:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80024a:	83 ec 0c             	sub    $0xc,%esp
  80024d:	68 c8 24 80 00       	push   $0x8024c8
  800252:	e8 0d 08 00 00       	call   800a64 <cprintf>
  800257:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80025a:	83 ec 0c             	sub    $0xc,%esp
  80025d:	68 fc 24 80 00       	push   $0x8024fc
  800262:	e8 fd 07 00 00       	call   800a64 <cprintf>
  800267:	83 c4 10             	add    $0x10,%esp
			sys_signalSemaphore(envID, "cs1");
  80026a:	83 ec 08             	sub    $0x8,%esp
  80026d:	68 e0 23 80 00       	push   $0x8023e0
  800272:	ff 75 e8             	pushl  -0x18(%ebp)
  800275:	e8 71 1b 00 00       	call   801deb <sys_signalSemaphore>
  80027a:	83 c4 10             	add    $0x10,%esp
//		free(Elements) ;


		///========================================================================
	//sys_disable_interrupt();
		sys_waitSemaphore(envID, "cs1");
  80027d:	83 ec 08             	sub    $0x8,%esp
  800280:	68 e0 23 80 00       	push   $0x8023e0
  800285:	ff 75 e8             	pushl  -0x18(%ebp)
  800288:	e8 40 1b 00 00       	call   801dcd <sys_waitSemaphore>
  80028d:	83 c4 10             	add    $0x10,%esp
		cprintf("Do you want to repeat (y/n): ") ;
  800290:	83 ec 0c             	sub    $0xc,%esp
  800293:	68 2e 25 80 00       	push   $0x80252e
  800298:	e8 c7 07 00 00       	call   800a64 <cprintf>
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
  8002d5:	68 e0 23 80 00       	push   $0x8023e0
  8002da:	ff 75 e8             	pushl  -0x18(%ebp)
  8002dd:	e8 09 1b 00 00       	call   801deb <sys_signalSemaphore>
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
  800588:	68 4c 25 80 00       	push   $0x80254c
  80058d:	e8 d2 04 00 00       	call   800a64 <cprintf>
  800592:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800595:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800598:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80059f:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a2:	01 d0                	add    %edx,%eax
  8005a4:	8b 00                	mov    (%eax),%eax
  8005a6:	83 ec 08             	sub    $0x8,%esp
  8005a9:	50                   	push   %eax
  8005aa:	68 4e 25 80 00       	push   $0x80254e
  8005af:	e8 b0 04 00 00       	call   800a64 <cprintf>
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
  8005d8:	68 53 25 80 00       	push   $0x802553
  8005dd:	e8 82 04 00 00       	call   800a64 <cprintf>
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
  8005fc:	e8 53 17 00 00       	call   801d54 <sys_cputc>
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
  80060d:	e8 0e 17 00 00       	call   801d20 <sys_disable_interrupt>
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
  800620:	e8 2f 17 00 00       	call   801d54 <sys_cputc>
  800625:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800628:	e8 0d 17 00 00       	call   801d3a <sys_enable_interrupt>
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
  80063f:	e8 f4 14 00 00       	call   801b38 <sys_cgetc>
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
  800658:	e8 c3 16 00 00       	call   801d20 <sys_disable_interrupt>
	int c=0;
  80065d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800664:	eb 08                	jmp    80066e <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800666:	e8 cd 14 00 00       	call   801b38 <sys_cgetc>
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
  800674:	e8 c1 16 00 00       	call   801d3a <sys_enable_interrupt>
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
  80068e:	e8 f2 14 00 00       	call   801b85 <sys_getenvindex>
  800693:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800696:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800699:	89 d0                	mov    %edx,%eax
  80069b:	c1 e0 03             	shl    $0x3,%eax
  80069e:	01 d0                	add    %edx,%eax
  8006a0:	c1 e0 02             	shl    $0x2,%eax
  8006a3:	01 d0                	add    %edx,%eax
  8006a5:	c1 e0 06             	shl    $0x6,%eax
  8006a8:	29 d0                	sub    %edx,%eax
  8006aa:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8006b1:	01 c8                	add    %ecx,%eax
  8006b3:	01 d0                	add    %edx,%eax
  8006b5:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8006ba:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8006bf:	a1 24 30 80 00       	mov    0x803024,%eax
  8006c4:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  8006ca:	84 c0                	test   %al,%al
  8006cc:	74 0f                	je     8006dd <libmain+0x55>
		binaryname = myEnv->prog_name;
  8006ce:	a1 24 30 80 00       	mov    0x803024,%eax
  8006d3:	05 b0 52 00 00       	add    $0x52b0,%eax
  8006d8:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006dd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8006e1:	7e 0a                	jle    8006ed <libmain+0x65>
		binaryname = argv[0];
  8006e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006e6:	8b 00                	mov    (%eax),%eax
  8006e8:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8006ed:	83 ec 08             	sub    $0x8,%esp
  8006f0:	ff 75 0c             	pushl  0xc(%ebp)
  8006f3:	ff 75 08             	pushl  0x8(%ebp)
  8006f6:	e8 3d f9 ff ff       	call   800038 <_main>
  8006fb:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8006fe:	e8 1d 16 00 00       	call   801d20 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800703:	83 ec 0c             	sub    $0xc,%esp
  800706:	68 70 25 80 00       	push   $0x802570
  80070b:	e8 54 03 00 00       	call   800a64 <cprintf>
  800710:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800713:	a1 24 30 80 00       	mov    0x803024,%eax
  800718:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  80071e:	a1 24 30 80 00       	mov    0x803024,%eax
  800723:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  800729:	83 ec 04             	sub    $0x4,%esp
  80072c:	52                   	push   %edx
  80072d:	50                   	push   %eax
  80072e:	68 98 25 80 00       	push   $0x802598
  800733:	e8 2c 03 00 00       	call   800a64 <cprintf>
  800738:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80073b:	a1 24 30 80 00       	mov    0x803024,%eax
  800740:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  800746:	a1 24 30 80 00       	mov    0x803024,%eax
  80074b:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  800751:	a1 24 30 80 00       	mov    0x803024,%eax
  800756:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  80075c:	51                   	push   %ecx
  80075d:	52                   	push   %edx
  80075e:	50                   	push   %eax
  80075f:	68 c0 25 80 00       	push   $0x8025c0
  800764:	e8 fb 02 00 00       	call   800a64 <cprintf>
  800769:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80076c:	83 ec 0c             	sub    $0xc,%esp
  80076f:	68 70 25 80 00       	push   $0x802570
  800774:	e8 eb 02 00 00       	call   800a64 <cprintf>
  800779:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80077c:	e8 b9 15 00 00       	call   801d3a <sys_enable_interrupt>

	// exit gracefully
	exit();
  800781:	e8 19 00 00 00       	call   80079f <exit>
}
  800786:	90                   	nop
  800787:	c9                   	leave  
  800788:	c3                   	ret    

00800789 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800789:	55                   	push   %ebp
  80078a:	89 e5                	mov    %esp,%ebp
  80078c:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80078f:	83 ec 0c             	sub    $0xc,%esp
  800792:	6a 00                	push   $0x0
  800794:	e8 b8 13 00 00       	call   801b51 <sys_env_destroy>
  800799:	83 c4 10             	add    $0x10,%esp
}
  80079c:	90                   	nop
  80079d:	c9                   	leave  
  80079e:	c3                   	ret    

0080079f <exit>:

void
exit(void)
{
  80079f:	55                   	push   %ebp
  8007a0:	89 e5                	mov    %esp,%ebp
  8007a2:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8007a5:	e8 0d 14 00 00       	call   801bb7 <sys_env_exit>
}
  8007aa:	90                   	nop
  8007ab:	c9                   	leave  
  8007ac:	c3                   	ret    

008007ad <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8007ad:	55                   	push   %ebp
  8007ae:	89 e5                	mov    %esp,%ebp
  8007b0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8007b3:	8d 45 10             	lea    0x10(%ebp),%eax
  8007b6:	83 c0 04             	add    $0x4,%eax
  8007b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8007bc:	a1 18 31 80 00       	mov    0x803118,%eax
  8007c1:	85 c0                	test   %eax,%eax
  8007c3:	74 16                	je     8007db <_panic+0x2e>
		cprintf("%s: ", argv0);
  8007c5:	a1 18 31 80 00       	mov    0x803118,%eax
  8007ca:	83 ec 08             	sub    $0x8,%esp
  8007cd:	50                   	push   %eax
  8007ce:	68 18 26 80 00       	push   $0x802618
  8007d3:	e8 8c 02 00 00       	call   800a64 <cprintf>
  8007d8:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8007db:	a1 00 30 80 00       	mov    0x803000,%eax
  8007e0:	ff 75 0c             	pushl  0xc(%ebp)
  8007e3:	ff 75 08             	pushl  0x8(%ebp)
  8007e6:	50                   	push   %eax
  8007e7:	68 1d 26 80 00       	push   $0x80261d
  8007ec:	e8 73 02 00 00       	call   800a64 <cprintf>
  8007f1:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8007f7:	83 ec 08             	sub    $0x8,%esp
  8007fa:	ff 75 f4             	pushl  -0xc(%ebp)
  8007fd:	50                   	push   %eax
  8007fe:	e8 f6 01 00 00       	call   8009f9 <vcprintf>
  800803:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800806:	83 ec 08             	sub    $0x8,%esp
  800809:	6a 00                	push   $0x0
  80080b:	68 39 26 80 00       	push   $0x802639
  800810:	e8 e4 01 00 00       	call   8009f9 <vcprintf>
  800815:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800818:	e8 82 ff ff ff       	call   80079f <exit>

	// should not return here
	while (1) ;
  80081d:	eb fe                	jmp    80081d <_panic+0x70>

0080081f <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80081f:	55                   	push   %ebp
  800820:	89 e5                	mov    %esp,%ebp
  800822:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800825:	a1 24 30 80 00       	mov    0x803024,%eax
  80082a:	8b 50 74             	mov    0x74(%eax),%edx
  80082d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800830:	39 c2                	cmp    %eax,%edx
  800832:	74 14                	je     800848 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800834:	83 ec 04             	sub    $0x4,%esp
  800837:	68 3c 26 80 00       	push   $0x80263c
  80083c:	6a 26                	push   $0x26
  80083e:	68 88 26 80 00       	push   $0x802688
  800843:	e8 65 ff ff ff       	call   8007ad <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800848:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80084f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800856:	e9 c4 00 00 00       	jmp    80091f <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  80085b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80085e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800865:	8b 45 08             	mov    0x8(%ebp),%eax
  800868:	01 d0                	add    %edx,%eax
  80086a:	8b 00                	mov    (%eax),%eax
  80086c:	85 c0                	test   %eax,%eax
  80086e:	75 08                	jne    800878 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800870:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800873:	e9 a4 00 00 00       	jmp    80091c <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  800878:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80087f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800886:	eb 6b                	jmp    8008f3 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800888:	a1 24 30 80 00       	mov    0x803024,%eax
  80088d:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800893:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800896:	89 d0                	mov    %edx,%eax
  800898:	c1 e0 02             	shl    $0x2,%eax
  80089b:	01 d0                	add    %edx,%eax
  80089d:	c1 e0 02             	shl    $0x2,%eax
  8008a0:	01 c8                	add    %ecx,%eax
  8008a2:	8a 40 04             	mov    0x4(%eax),%al
  8008a5:	84 c0                	test   %al,%al
  8008a7:	75 47                	jne    8008f0 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008a9:	a1 24 30 80 00       	mov    0x803024,%eax
  8008ae:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8008b4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008b7:	89 d0                	mov    %edx,%eax
  8008b9:	c1 e0 02             	shl    $0x2,%eax
  8008bc:	01 d0                	add    %edx,%eax
  8008be:	c1 e0 02             	shl    $0x2,%eax
  8008c1:	01 c8                	add    %ecx,%eax
  8008c3:	8b 00                	mov    (%eax),%eax
  8008c5:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8008c8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8008d0:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8008d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008d5:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8008dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8008df:	01 c8                	add    %ecx,%eax
  8008e1:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008e3:	39 c2                	cmp    %eax,%edx
  8008e5:	75 09                	jne    8008f0 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  8008e7:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008ee:	eb 12                	jmp    800902 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008f0:	ff 45 e8             	incl   -0x18(%ebp)
  8008f3:	a1 24 30 80 00       	mov    0x803024,%eax
  8008f8:	8b 50 74             	mov    0x74(%eax),%edx
  8008fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008fe:	39 c2                	cmp    %eax,%edx
  800900:	77 86                	ja     800888 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800902:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800906:	75 14                	jne    80091c <CheckWSWithoutLastIndex+0xfd>
			panic(
  800908:	83 ec 04             	sub    $0x4,%esp
  80090b:	68 94 26 80 00       	push   $0x802694
  800910:	6a 3a                	push   $0x3a
  800912:	68 88 26 80 00       	push   $0x802688
  800917:	e8 91 fe ff ff       	call   8007ad <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80091c:	ff 45 f0             	incl   -0x10(%ebp)
  80091f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800922:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800925:	0f 8c 30 ff ff ff    	jl     80085b <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80092b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800932:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800939:	eb 27                	jmp    800962 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80093b:	a1 24 30 80 00       	mov    0x803024,%eax
  800940:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800946:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800949:	89 d0                	mov    %edx,%eax
  80094b:	c1 e0 02             	shl    $0x2,%eax
  80094e:	01 d0                	add    %edx,%eax
  800950:	c1 e0 02             	shl    $0x2,%eax
  800953:	01 c8                	add    %ecx,%eax
  800955:	8a 40 04             	mov    0x4(%eax),%al
  800958:	3c 01                	cmp    $0x1,%al
  80095a:	75 03                	jne    80095f <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  80095c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80095f:	ff 45 e0             	incl   -0x20(%ebp)
  800962:	a1 24 30 80 00       	mov    0x803024,%eax
  800967:	8b 50 74             	mov    0x74(%eax),%edx
  80096a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80096d:	39 c2                	cmp    %eax,%edx
  80096f:	77 ca                	ja     80093b <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800971:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800974:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800977:	74 14                	je     80098d <CheckWSWithoutLastIndex+0x16e>
		panic(
  800979:	83 ec 04             	sub    $0x4,%esp
  80097c:	68 e8 26 80 00       	push   $0x8026e8
  800981:	6a 44                	push   $0x44
  800983:	68 88 26 80 00       	push   $0x802688
  800988:	e8 20 fe ff ff       	call   8007ad <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80098d:	90                   	nop
  80098e:	c9                   	leave  
  80098f:	c3                   	ret    

00800990 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800990:	55                   	push   %ebp
  800991:	89 e5                	mov    %esp,%ebp
  800993:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800996:	8b 45 0c             	mov    0xc(%ebp),%eax
  800999:	8b 00                	mov    (%eax),%eax
  80099b:	8d 48 01             	lea    0x1(%eax),%ecx
  80099e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009a1:	89 0a                	mov    %ecx,(%edx)
  8009a3:	8b 55 08             	mov    0x8(%ebp),%edx
  8009a6:	88 d1                	mov    %dl,%cl
  8009a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009ab:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b2:	8b 00                	mov    (%eax),%eax
  8009b4:	3d ff 00 00 00       	cmp    $0xff,%eax
  8009b9:	75 2c                	jne    8009e7 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8009bb:	a0 28 30 80 00       	mov    0x803028,%al
  8009c0:	0f b6 c0             	movzbl %al,%eax
  8009c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009c6:	8b 12                	mov    (%edx),%edx
  8009c8:	89 d1                	mov    %edx,%ecx
  8009ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009cd:	83 c2 08             	add    $0x8,%edx
  8009d0:	83 ec 04             	sub    $0x4,%esp
  8009d3:	50                   	push   %eax
  8009d4:	51                   	push   %ecx
  8009d5:	52                   	push   %edx
  8009d6:	e8 34 11 00 00       	call   801b0f <sys_cputs>
  8009db:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8009de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8009e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ea:	8b 40 04             	mov    0x4(%eax),%eax
  8009ed:	8d 50 01             	lea    0x1(%eax),%edx
  8009f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f3:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009f6:	90                   	nop
  8009f7:	c9                   	leave  
  8009f8:	c3                   	ret    

008009f9 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8009f9:	55                   	push   %ebp
  8009fa:	89 e5                	mov    %esp,%ebp
  8009fc:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a02:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a09:	00 00 00 
	b.cnt = 0;
  800a0c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a13:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a16:	ff 75 0c             	pushl  0xc(%ebp)
  800a19:	ff 75 08             	pushl  0x8(%ebp)
  800a1c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a22:	50                   	push   %eax
  800a23:	68 90 09 80 00       	push   $0x800990
  800a28:	e8 11 02 00 00       	call   800c3e <vprintfmt>
  800a2d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a30:	a0 28 30 80 00       	mov    0x803028,%al
  800a35:	0f b6 c0             	movzbl %al,%eax
  800a38:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a3e:	83 ec 04             	sub    $0x4,%esp
  800a41:	50                   	push   %eax
  800a42:	52                   	push   %edx
  800a43:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a49:	83 c0 08             	add    $0x8,%eax
  800a4c:	50                   	push   %eax
  800a4d:	e8 bd 10 00 00       	call   801b0f <sys_cputs>
  800a52:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a55:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800a5c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a62:	c9                   	leave  
  800a63:	c3                   	ret    

00800a64 <cprintf>:

int cprintf(const char *fmt, ...) {
  800a64:	55                   	push   %ebp
  800a65:	89 e5                	mov    %esp,%ebp
  800a67:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a6a:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800a71:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a74:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a77:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7a:	83 ec 08             	sub    $0x8,%esp
  800a7d:	ff 75 f4             	pushl  -0xc(%ebp)
  800a80:	50                   	push   %eax
  800a81:	e8 73 ff ff ff       	call   8009f9 <vcprintf>
  800a86:	83 c4 10             	add    $0x10,%esp
  800a89:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a8f:	c9                   	leave  
  800a90:	c3                   	ret    

00800a91 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a91:	55                   	push   %ebp
  800a92:	89 e5                	mov    %esp,%ebp
  800a94:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a97:	e8 84 12 00 00       	call   801d20 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a9c:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800aa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa5:	83 ec 08             	sub    $0x8,%esp
  800aa8:	ff 75 f4             	pushl  -0xc(%ebp)
  800aab:	50                   	push   %eax
  800aac:	e8 48 ff ff ff       	call   8009f9 <vcprintf>
  800ab1:	83 c4 10             	add    $0x10,%esp
  800ab4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800ab7:	e8 7e 12 00 00       	call   801d3a <sys_enable_interrupt>
	return cnt;
  800abc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800abf:	c9                   	leave  
  800ac0:	c3                   	ret    

00800ac1 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800ac1:	55                   	push   %ebp
  800ac2:	89 e5                	mov    %esp,%ebp
  800ac4:	53                   	push   %ebx
  800ac5:	83 ec 14             	sub    $0x14,%esp
  800ac8:	8b 45 10             	mov    0x10(%ebp),%eax
  800acb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ace:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800ad4:	8b 45 18             	mov    0x18(%ebp),%eax
  800ad7:	ba 00 00 00 00       	mov    $0x0,%edx
  800adc:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800adf:	77 55                	ja     800b36 <printnum+0x75>
  800ae1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ae4:	72 05                	jb     800aeb <printnum+0x2a>
  800ae6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ae9:	77 4b                	ja     800b36 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800aeb:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800aee:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800af1:	8b 45 18             	mov    0x18(%ebp),%eax
  800af4:	ba 00 00 00 00       	mov    $0x0,%edx
  800af9:	52                   	push   %edx
  800afa:	50                   	push   %eax
  800afb:	ff 75 f4             	pushl  -0xc(%ebp)
  800afe:	ff 75 f0             	pushl  -0x10(%ebp)
  800b01:	e8 5a 16 00 00       	call   802160 <__udivdi3>
  800b06:	83 c4 10             	add    $0x10,%esp
  800b09:	83 ec 04             	sub    $0x4,%esp
  800b0c:	ff 75 20             	pushl  0x20(%ebp)
  800b0f:	53                   	push   %ebx
  800b10:	ff 75 18             	pushl  0x18(%ebp)
  800b13:	52                   	push   %edx
  800b14:	50                   	push   %eax
  800b15:	ff 75 0c             	pushl  0xc(%ebp)
  800b18:	ff 75 08             	pushl  0x8(%ebp)
  800b1b:	e8 a1 ff ff ff       	call   800ac1 <printnum>
  800b20:	83 c4 20             	add    $0x20,%esp
  800b23:	eb 1a                	jmp    800b3f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b25:	83 ec 08             	sub    $0x8,%esp
  800b28:	ff 75 0c             	pushl  0xc(%ebp)
  800b2b:	ff 75 20             	pushl  0x20(%ebp)
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b31:	ff d0                	call   *%eax
  800b33:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b36:	ff 4d 1c             	decl   0x1c(%ebp)
  800b39:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b3d:	7f e6                	jg     800b25 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b3f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b42:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b47:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b4a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b4d:	53                   	push   %ebx
  800b4e:	51                   	push   %ecx
  800b4f:	52                   	push   %edx
  800b50:	50                   	push   %eax
  800b51:	e8 1a 17 00 00       	call   802270 <__umoddi3>
  800b56:	83 c4 10             	add    $0x10,%esp
  800b59:	05 54 29 80 00       	add    $0x802954,%eax
  800b5e:	8a 00                	mov    (%eax),%al
  800b60:	0f be c0             	movsbl %al,%eax
  800b63:	83 ec 08             	sub    $0x8,%esp
  800b66:	ff 75 0c             	pushl  0xc(%ebp)
  800b69:	50                   	push   %eax
  800b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6d:	ff d0                	call   *%eax
  800b6f:	83 c4 10             	add    $0x10,%esp
}
  800b72:	90                   	nop
  800b73:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b76:	c9                   	leave  
  800b77:	c3                   	ret    

00800b78 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b78:	55                   	push   %ebp
  800b79:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b7b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b7f:	7e 1c                	jle    800b9d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b81:	8b 45 08             	mov    0x8(%ebp),%eax
  800b84:	8b 00                	mov    (%eax),%eax
  800b86:	8d 50 08             	lea    0x8(%eax),%edx
  800b89:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8c:	89 10                	mov    %edx,(%eax)
  800b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b91:	8b 00                	mov    (%eax),%eax
  800b93:	83 e8 08             	sub    $0x8,%eax
  800b96:	8b 50 04             	mov    0x4(%eax),%edx
  800b99:	8b 00                	mov    (%eax),%eax
  800b9b:	eb 40                	jmp    800bdd <getuint+0x65>
	else if (lflag)
  800b9d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ba1:	74 1e                	je     800bc1 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba6:	8b 00                	mov    (%eax),%eax
  800ba8:	8d 50 04             	lea    0x4(%eax),%edx
  800bab:	8b 45 08             	mov    0x8(%ebp),%eax
  800bae:	89 10                	mov    %edx,(%eax)
  800bb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb3:	8b 00                	mov    (%eax),%eax
  800bb5:	83 e8 04             	sub    $0x4,%eax
  800bb8:	8b 00                	mov    (%eax),%eax
  800bba:	ba 00 00 00 00       	mov    $0x0,%edx
  800bbf:	eb 1c                	jmp    800bdd <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800bc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc4:	8b 00                	mov    (%eax),%eax
  800bc6:	8d 50 04             	lea    0x4(%eax),%edx
  800bc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcc:	89 10                	mov    %edx,(%eax)
  800bce:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd1:	8b 00                	mov    (%eax),%eax
  800bd3:	83 e8 04             	sub    $0x4,%eax
  800bd6:	8b 00                	mov    (%eax),%eax
  800bd8:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800bdd:	5d                   	pop    %ebp
  800bde:	c3                   	ret    

00800bdf <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800bdf:	55                   	push   %ebp
  800be0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800be2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800be6:	7e 1c                	jle    800c04 <getint+0x25>
		return va_arg(*ap, long long);
  800be8:	8b 45 08             	mov    0x8(%ebp),%eax
  800beb:	8b 00                	mov    (%eax),%eax
  800bed:	8d 50 08             	lea    0x8(%eax),%edx
  800bf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf3:	89 10                	mov    %edx,(%eax)
  800bf5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf8:	8b 00                	mov    (%eax),%eax
  800bfa:	83 e8 08             	sub    $0x8,%eax
  800bfd:	8b 50 04             	mov    0x4(%eax),%edx
  800c00:	8b 00                	mov    (%eax),%eax
  800c02:	eb 38                	jmp    800c3c <getint+0x5d>
	else if (lflag)
  800c04:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c08:	74 1a                	je     800c24 <getint+0x45>
		return va_arg(*ap, long);
  800c0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0d:	8b 00                	mov    (%eax),%eax
  800c0f:	8d 50 04             	lea    0x4(%eax),%edx
  800c12:	8b 45 08             	mov    0x8(%ebp),%eax
  800c15:	89 10                	mov    %edx,(%eax)
  800c17:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1a:	8b 00                	mov    (%eax),%eax
  800c1c:	83 e8 04             	sub    $0x4,%eax
  800c1f:	8b 00                	mov    (%eax),%eax
  800c21:	99                   	cltd   
  800c22:	eb 18                	jmp    800c3c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c24:	8b 45 08             	mov    0x8(%ebp),%eax
  800c27:	8b 00                	mov    (%eax),%eax
  800c29:	8d 50 04             	lea    0x4(%eax),%edx
  800c2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2f:	89 10                	mov    %edx,(%eax)
  800c31:	8b 45 08             	mov    0x8(%ebp),%eax
  800c34:	8b 00                	mov    (%eax),%eax
  800c36:	83 e8 04             	sub    $0x4,%eax
  800c39:	8b 00                	mov    (%eax),%eax
  800c3b:	99                   	cltd   
}
  800c3c:	5d                   	pop    %ebp
  800c3d:	c3                   	ret    

00800c3e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c3e:	55                   	push   %ebp
  800c3f:	89 e5                	mov    %esp,%ebp
  800c41:	56                   	push   %esi
  800c42:	53                   	push   %ebx
  800c43:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c46:	eb 17                	jmp    800c5f <vprintfmt+0x21>
			if (ch == '\0')
  800c48:	85 db                	test   %ebx,%ebx
  800c4a:	0f 84 af 03 00 00    	je     800fff <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c50:	83 ec 08             	sub    $0x8,%esp
  800c53:	ff 75 0c             	pushl  0xc(%ebp)
  800c56:	53                   	push   %ebx
  800c57:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5a:	ff d0                	call   *%eax
  800c5c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c5f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c62:	8d 50 01             	lea    0x1(%eax),%edx
  800c65:	89 55 10             	mov    %edx,0x10(%ebp)
  800c68:	8a 00                	mov    (%eax),%al
  800c6a:	0f b6 d8             	movzbl %al,%ebx
  800c6d:	83 fb 25             	cmp    $0x25,%ebx
  800c70:	75 d6                	jne    800c48 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c72:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c76:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c7d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c84:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c8b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c92:	8b 45 10             	mov    0x10(%ebp),%eax
  800c95:	8d 50 01             	lea    0x1(%eax),%edx
  800c98:	89 55 10             	mov    %edx,0x10(%ebp)
  800c9b:	8a 00                	mov    (%eax),%al
  800c9d:	0f b6 d8             	movzbl %al,%ebx
  800ca0:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800ca3:	83 f8 55             	cmp    $0x55,%eax
  800ca6:	0f 87 2b 03 00 00    	ja     800fd7 <vprintfmt+0x399>
  800cac:	8b 04 85 78 29 80 00 	mov    0x802978(,%eax,4),%eax
  800cb3:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800cb5:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800cb9:	eb d7                	jmp    800c92 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800cbb:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800cbf:	eb d1                	jmp    800c92 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cc1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800cc8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ccb:	89 d0                	mov    %edx,%eax
  800ccd:	c1 e0 02             	shl    $0x2,%eax
  800cd0:	01 d0                	add    %edx,%eax
  800cd2:	01 c0                	add    %eax,%eax
  800cd4:	01 d8                	add    %ebx,%eax
  800cd6:	83 e8 30             	sub    $0x30,%eax
  800cd9:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800cdc:	8b 45 10             	mov    0x10(%ebp),%eax
  800cdf:	8a 00                	mov    (%eax),%al
  800ce1:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ce4:	83 fb 2f             	cmp    $0x2f,%ebx
  800ce7:	7e 3e                	jle    800d27 <vprintfmt+0xe9>
  800ce9:	83 fb 39             	cmp    $0x39,%ebx
  800cec:	7f 39                	jg     800d27 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cee:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800cf1:	eb d5                	jmp    800cc8 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800cf3:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf6:	83 c0 04             	add    $0x4,%eax
  800cf9:	89 45 14             	mov    %eax,0x14(%ebp)
  800cfc:	8b 45 14             	mov    0x14(%ebp),%eax
  800cff:	83 e8 04             	sub    $0x4,%eax
  800d02:	8b 00                	mov    (%eax),%eax
  800d04:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d07:	eb 1f                	jmp    800d28 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d09:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d0d:	79 83                	jns    800c92 <vprintfmt+0x54>
				width = 0;
  800d0f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d16:	e9 77 ff ff ff       	jmp    800c92 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d1b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d22:	e9 6b ff ff ff       	jmp    800c92 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d27:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d28:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d2c:	0f 89 60 ff ff ff    	jns    800c92 <vprintfmt+0x54>
				width = precision, precision = -1;
  800d32:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d38:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d3f:	e9 4e ff ff ff       	jmp    800c92 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d44:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d47:	e9 46 ff ff ff       	jmp    800c92 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800d4f:	83 c0 04             	add    $0x4,%eax
  800d52:	89 45 14             	mov    %eax,0x14(%ebp)
  800d55:	8b 45 14             	mov    0x14(%ebp),%eax
  800d58:	83 e8 04             	sub    $0x4,%eax
  800d5b:	8b 00                	mov    (%eax),%eax
  800d5d:	83 ec 08             	sub    $0x8,%esp
  800d60:	ff 75 0c             	pushl  0xc(%ebp)
  800d63:	50                   	push   %eax
  800d64:	8b 45 08             	mov    0x8(%ebp),%eax
  800d67:	ff d0                	call   *%eax
  800d69:	83 c4 10             	add    $0x10,%esp
			break;
  800d6c:	e9 89 02 00 00       	jmp    800ffa <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d71:	8b 45 14             	mov    0x14(%ebp),%eax
  800d74:	83 c0 04             	add    $0x4,%eax
  800d77:	89 45 14             	mov    %eax,0x14(%ebp)
  800d7a:	8b 45 14             	mov    0x14(%ebp),%eax
  800d7d:	83 e8 04             	sub    $0x4,%eax
  800d80:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d82:	85 db                	test   %ebx,%ebx
  800d84:	79 02                	jns    800d88 <vprintfmt+0x14a>
				err = -err;
  800d86:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d88:	83 fb 64             	cmp    $0x64,%ebx
  800d8b:	7f 0b                	jg     800d98 <vprintfmt+0x15a>
  800d8d:	8b 34 9d c0 27 80 00 	mov    0x8027c0(,%ebx,4),%esi
  800d94:	85 f6                	test   %esi,%esi
  800d96:	75 19                	jne    800db1 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d98:	53                   	push   %ebx
  800d99:	68 65 29 80 00       	push   $0x802965
  800d9e:	ff 75 0c             	pushl  0xc(%ebp)
  800da1:	ff 75 08             	pushl  0x8(%ebp)
  800da4:	e8 5e 02 00 00       	call   801007 <printfmt>
  800da9:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800dac:	e9 49 02 00 00       	jmp    800ffa <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800db1:	56                   	push   %esi
  800db2:	68 6e 29 80 00       	push   $0x80296e
  800db7:	ff 75 0c             	pushl  0xc(%ebp)
  800dba:	ff 75 08             	pushl  0x8(%ebp)
  800dbd:	e8 45 02 00 00       	call   801007 <printfmt>
  800dc2:	83 c4 10             	add    $0x10,%esp
			break;
  800dc5:	e9 30 02 00 00       	jmp    800ffa <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800dca:	8b 45 14             	mov    0x14(%ebp),%eax
  800dcd:	83 c0 04             	add    $0x4,%eax
  800dd0:	89 45 14             	mov    %eax,0x14(%ebp)
  800dd3:	8b 45 14             	mov    0x14(%ebp),%eax
  800dd6:	83 e8 04             	sub    $0x4,%eax
  800dd9:	8b 30                	mov    (%eax),%esi
  800ddb:	85 f6                	test   %esi,%esi
  800ddd:	75 05                	jne    800de4 <vprintfmt+0x1a6>
				p = "(null)";
  800ddf:	be 71 29 80 00       	mov    $0x802971,%esi
			if (width > 0 && padc != '-')
  800de4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800de8:	7e 6d                	jle    800e57 <vprintfmt+0x219>
  800dea:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800dee:	74 67                	je     800e57 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800df0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800df3:	83 ec 08             	sub    $0x8,%esp
  800df6:	50                   	push   %eax
  800df7:	56                   	push   %esi
  800df8:	e8 12 05 00 00       	call   80130f <strnlen>
  800dfd:	83 c4 10             	add    $0x10,%esp
  800e00:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e03:	eb 16                	jmp    800e1b <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e05:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e09:	83 ec 08             	sub    $0x8,%esp
  800e0c:	ff 75 0c             	pushl  0xc(%ebp)
  800e0f:	50                   	push   %eax
  800e10:	8b 45 08             	mov    0x8(%ebp),%eax
  800e13:	ff d0                	call   *%eax
  800e15:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e18:	ff 4d e4             	decl   -0x1c(%ebp)
  800e1b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e1f:	7f e4                	jg     800e05 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e21:	eb 34                	jmp    800e57 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e23:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e27:	74 1c                	je     800e45 <vprintfmt+0x207>
  800e29:	83 fb 1f             	cmp    $0x1f,%ebx
  800e2c:	7e 05                	jle    800e33 <vprintfmt+0x1f5>
  800e2e:	83 fb 7e             	cmp    $0x7e,%ebx
  800e31:	7e 12                	jle    800e45 <vprintfmt+0x207>
					putch('?', putdat);
  800e33:	83 ec 08             	sub    $0x8,%esp
  800e36:	ff 75 0c             	pushl  0xc(%ebp)
  800e39:	6a 3f                	push   $0x3f
  800e3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3e:	ff d0                	call   *%eax
  800e40:	83 c4 10             	add    $0x10,%esp
  800e43:	eb 0f                	jmp    800e54 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e45:	83 ec 08             	sub    $0x8,%esp
  800e48:	ff 75 0c             	pushl  0xc(%ebp)
  800e4b:	53                   	push   %ebx
  800e4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4f:	ff d0                	call   *%eax
  800e51:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e54:	ff 4d e4             	decl   -0x1c(%ebp)
  800e57:	89 f0                	mov    %esi,%eax
  800e59:	8d 70 01             	lea    0x1(%eax),%esi
  800e5c:	8a 00                	mov    (%eax),%al
  800e5e:	0f be d8             	movsbl %al,%ebx
  800e61:	85 db                	test   %ebx,%ebx
  800e63:	74 24                	je     800e89 <vprintfmt+0x24b>
  800e65:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e69:	78 b8                	js     800e23 <vprintfmt+0x1e5>
  800e6b:	ff 4d e0             	decl   -0x20(%ebp)
  800e6e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e72:	79 af                	jns    800e23 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e74:	eb 13                	jmp    800e89 <vprintfmt+0x24b>
				putch(' ', putdat);
  800e76:	83 ec 08             	sub    $0x8,%esp
  800e79:	ff 75 0c             	pushl  0xc(%ebp)
  800e7c:	6a 20                	push   $0x20
  800e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e81:	ff d0                	call   *%eax
  800e83:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e86:	ff 4d e4             	decl   -0x1c(%ebp)
  800e89:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e8d:	7f e7                	jg     800e76 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e8f:	e9 66 01 00 00       	jmp    800ffa <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e94:	83 ec 08             	sub    $0x8,%esp
  800e97:	ff 75 e8             	pushl  -0x18(%ebp)
  800e9a:	8d 45 14             	lea    0x14(%ebp),%eax
  800e9d:	50                   	push   %eax
  800e9e:	e8 3c fd ff ff       	call   800bdf <getint>
  800ea3:	83 c4 10             	add    $0x10,%esp
  800ea6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ea9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800eac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800eaf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800eb2:	85 d2                	test   %edx,%edx
  800eb4:	79 23                	jns    800ed9 <vprintfmt+0x29b>
				putch('-', putdat);
  800eb6:	83 ec 08             	sub    $0x8,%esp
  800eb9:	ff 75 0c             	pushl  0xc(%ebp)
  800ebc:	6a 2d                	push   $0x2d
  800ebe:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec1:	ff d0                	call   *%eax
  800ec3:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ec6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ec9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ecc:	f7 d8                	neg    %eax
  800ece:	83 d2 00             	adc    $0x0,%edx
  800ed1:	f7 da                	neg    %edx
  800ed3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ed6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ed9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ee0:	e9 bc 00 00 00       	jmp    800fa1 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ee5:	83 ec 08             	sub    $0x8,%esp
  800ee8:	ff 75 e8             	pushl  -0x18(%ebp)
  800eeb:	8d 45 14             	lea    0x14(%ebp),%eax
  800eee:	50                   	push   %eax
  800eef:	e8 84 fc ff ff       	call   800b78 <getuint>
  800ef4:	83 c4 10             	add    $0x10,%esp
  800ef7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800efa:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800efd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f04:	e9 98 00 00 00       	jmp    800fa1 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f09:	83 ec 08             	sub    $0x8,%esp
  800f0c:	ff 75 0c             	pushl  0xc(%ebp)
  800f0f:	6a 58                	push   $0x58
  800f11:	8b 45 08             	mov    0x8(%ebp),%eax
  800f14:	ff d0                	call   *%eax
  800f16:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f19:	83 ec 08             	sub    $0x8,%esp
  800f1c:	ff 75 0c             	pushl  0xc(%ebp)
  800f1f:	6a 58                	push   $0x58
  800f21:	8b 45 08             	mov    0x8(%ebp),%eax
  800f24:	ff d0                	call   *%eax
  800f26:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f29:	83 ec 08             	sub    $0x8,%esp
  800f2c:	ff 75 0c             	pushl  0xc(%ebp)
  800f2f:	6a 58                	push   $0x58
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	ff d0                	call   *%eax
  800f36:	83 c4 10             	add    $0x10,%esp
			break;
  800f39:	e9 bc 00 00 00       	jmp    800ffa <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f3e:	83 ec 08             	sub    $0x8,%esp
  800f41:	ff 75 0c             	pushl  0xc(%ebp)
  800f44:	6a 30                	push   $0x30
  800f46:	8b 45 08             	mov    0x8(%ebp),%eax
  800f49:	ff d0                	call   *%eax
  800f4b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f4e:	83 ec 08             	sub    $0x8,%esp
  800f51:	ff 75 0c             	pushl  0xc(%ebp)
  800f54:	6a 78                	push   $0x78
  800f56:	8b 45 08             	mov    0x8(%ebp),%eax
  800f59:	ff d0                	call   *%eax
  800f5b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f5e:	8b 45 14             	mov    0x14(%ebp),%eax
  800f61:	83 c0 04             	add    $0x4,%eax
  800f64:	89 45 14             	mov    %eax,0x14(%ebp)
  800f67:	8b 45 14             	mov    0x14(%ebp),%eax
  800f6a:	83 e8 04             	sub    $0x4,%eax
  800f6d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f72:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f79:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f80:	eb 1f                	jmp    800fa1 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f82:	83 ec 08             	sub    $0x8,%esp
  800f85:	ff 75 e8             	pushl  -0x18(%ebp)
  800f88:	8d 45 14             	lea    0x14(%ebp),%eax
  800f8b:	50                   	push   %eax
  800f8c:	e8 e7 fb ff ff       	call   800b78 <getuint>
  800f91:	83 c4 10             	add    $0x10,%esp
  800f94:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f97:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f9a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800fa1:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800fa5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fa8:	83 ec 04             	sub    $0x4,%esp
  800fab:	52                   	push   %edx
  800fac:	ff 75 e4             	pushl  -0x1c(%ebp)
  800faf:	50                   	push   %eax
  800fb0:	ff 75 f4             	pushl  -0xc(%ebp)
  800fb3:	ff 75 f0             	pushl  -0x10(%ebp)
  800fb6:	ff 75 0c             	pushl  0xc(%ebp)
  800fb9:	ff 75 08             	pushl  0x8(%ebp)
  800fbc:	e8 00 fb ff ff       	call   800ac1 <printnum>
  800fc1:	83 c4 20             	add    $0x20,%esp
			break;
  800fc4:	eb 34                	jmp    800ffa <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800fc6:	83 ec 08             	sub    $0x8,%esp
  800fc9:	ff 75 0c             	pushl  0xc(%ebp)
  800fcc:	53                   	push   %ebx
  800fcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd0:	ff d0                	call   *%eax
  800fd2:	83 c4 10             	add    $0x10,%esp
			break;
  800fd5:	eb 23                	jmp    800ffa <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800fd7:	83 ec 08             	sub    $0x8,%esp
  800fda:	ff 75 0c             	pushl  0xc(%ebp)
  800fdd:	6a 25                	push   $0x25
  800fdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe2:	ff d0                	call   *%eax
  800fe4:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800fe7:	ff 4d 10             	decl   0x10(%ebp)
  800fea:	eb 03                	jmp    800fef <vprintfmt+0x3b1>
  800fec:	ff 4d 10             	decl   0x10(%ebp)
  800fef:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff2:	48                   	dec    %eax
  800ff3:	8a 00                	mov    (%eax),%al
  800ff5:	3c 25                	cmp    $0x25,%al
  800ff7:	75 f3                	jne    800fec <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ff9:	90                   	nop
		}
	}
  800ffa:	e9 47 fc ff ff       	jmp    800c46 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800fff:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801000:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801003:	5b                   	pop    %ebx
  801004:	5e                   	pop    %esi
  801005:	5d                   	pop    %ebp
  801006:	c3                   	ret    

00801007 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801007:	55                   	push   %ebp
  801008:	89 e5                	mov    %esp,%ebp
  80100a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80100d:	8d 45 10             	lea    0x10(%ebp),%eax
  801010:	83 c0 04             	add    $0x4,%eax
  801013:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801016:	8b 45 10             	mov    0x10(%ebp),%eax
  801019:	ff 75 f4             	pushl  -0xc(%ebp)
  80101c:	50                   	push   %eax
  80101d:	ff 75 0c             	pushl  0xc(%ebp)
  801020:	ff 75 08             	pushl  0x8(%ebp)
  801023:	e8 16 fc ff ff       	call   800c3e <vprintfmt>
  801028:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80102b:	90                   	nop
  80102c:	c9                   	leave  
  80102d:	c3                   	ret    

0080102e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80102e:	55                   	push   %ebp
  80102f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801031:	8b 45 0c             	mov    0xc(%ebp),%eax
  801034:	8b 40 08             	mov    0x8(%eax),%eax
  801037:	8d 50 01             	lea    0x1(%eax),%edx
  80103a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801040:	8b 45 0c             	mov    0xc(%ebp),%eax
  801043:	8b 10                	mov    (%eax),%edx
  801045:	8b 45 0c             	mov    0xc(%ebp),%eax
  801048:	8b 40 04             	mov    0x4(%eax),%eax
  80104b:	39 c2                	cmp    %eax,%edx
  80104d:	73 12                	jae    801061 <sprintputch+0x33>
		*b->buf++ = ch;
  80104f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801052:	8b 00                	mov    (%eax),%eax
  801054:	8d 48 01             	lea    0x1(%eax),%ecx
  801057:	8b 55 0c             	mov    0xc(%ebp),%edx
  80105a:	89 0a                	mov    %ecx,(%edx)
  80105c:	8b 55 08             	mov    0x8(%ebp),%edx
  80105f:	88 10                	mov    %dl,(%eax)
}
  801061:	90                   	nop
  801062:	5d                   	pop    %ebp
  801063:	c3                   	ret    

00801064 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801064:	55                   	push   %ebp
  801065:	89 e5                	mov    %esp,%ebp
  801067:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80106a:	8b 45 08             	mov    0x8(%ebp),%eax
  80106d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801070:	8b 45 0c             	mov    0xc(%ebp),%eax
  801073:	8d 50 ff             	lea    -0x1(%eax),%edx
  801076:	8b 45 08             	mov    0x8(%ebp),%eax
  801079:	01 d0                	add    %edx,%eax
  80107b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80107e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801085:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801089:	74 06                	je     801091 <vsnprintf+0x2d>
  80108b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80108f:	7f 07                	jg     801098 <vsnprintf+0x34>
		return -E_INVAL;
  801091:	b8 03 00 00 00       	mov    $0x3,%eax
  801096:	eb 20                	jmp    8010b8 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801098:	ff 75 14             	pushl  0x14(%ebp)
  80109b:	ff 75 10             	pushl  0x10(%ebp)
  80109e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8010a1:	50                   	push   %eax
  8010a2:	68 2e 10 80 00       	push   $0x80102e
  8010a7:	e8 92 fb ff ff       	call   800c3e <vprintfmt>
  8010ac:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010af:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010b2:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8010b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8010b8:	c9                   	leave  
  8010b9:	c3                   	ret    

008010ba <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8010ba:	55                   	push   %ebp
  8010bb:	89 e5                	mov    %esp,%ebp
  8010bd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8010c0:	8d 45 10             	lea    0x10(%ebp),%eax
  8010c3:	83 c0 04             	add    $0x4,%eax
  8010c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8010c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8010cc:	ff 75 f4             	pushl  -0xc(%ebp)
  8010cf:	50                   	push   %eax
  8010d0:	ff 75 0c             	pushl  0xc(%ebp)
  8010d3:	ff 75 08             	pushl  0x8(%ebp)
  8010d6:	e8 89 ff ff ff       	call   801064 <vsnprintf>
  8010db:	83 c4 10             	add    $0x10,%esp
  8010de:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8010e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010e4:	c9                   	leave  
  8010e5:	c3                   	ret    

008010e6 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8010e6:	55                   	push   %ebp
  8010e7:	89 e5                	mov    %esp,%ebp
  8010e9:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8010ec:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010f0:	74 13                	je     801105 <readline+0x1f>
		cprintf("%s", prompt);
  8010f2:	83 ec 08             	sub    $0x8,%esp
  8010f5:	ff 75 08             	pushl  0x8(%ebp)
  8010f8:	68 d0 2a 80 00       	push   $0x802ad0
  8010fd:	e8 62 f9 ff ff       	call   800a64 <cprintf>
  801102:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801105:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80110c:	83 ec 0c             	sub    $0xc,%esp
  80110f:	6a 00                	push   $0x0
  801111:	e8 68 f5 ff ff       	call   80067e <iscons>
  801116:	83 c4 10             	add    $0x10,%esp
  801119:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80111c:	e8 0f f5 ff ff       	call   800630 <getchar>
  801121:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801124:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801128:	79 22                	jns    80114c <readline+0x66>
			if (c != -E_EOF)
  80112a:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80112e:	0f 84 ad 00 00 00    	je     8011e1 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801134:	83 ec 08             	sub    $0x8,%esp
  801137:	ff 75 ec             	pushl  -0x14(%ebp)
  80113a:	68 d3 2a 80 00       	push   $0x802ad3
  80113f:	e8 20 f9 ff ff       	call   800a64 <cprintf>
  801144:	83 c4 10             	add    $0x10,%esp
			return;
  801147:	e9 95 00 00 00       	jmp    8011e1 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80114c:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801150:	7e 34                	jle    801186 <readline+0xa0>
  801152:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801159:	7f 2b                	jg     801186 <readline+0xa0>
			if (echoing)
  80115b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80115f:	74 0e                	je     80116f <readline+0x89>
				cputchar(c);
  801161:	83 ec 0c             	sub    $0xc,%esp
  801164:	ff 75 ec             	pushl  -0x14(%ebp)
  801167:	e8 7c f4 ff ff       	call   8005e8 <cputchar>
  80116c:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80116f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801172:	8d 50 01             	lea    0x1(%eax),%edx
  801175:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801178:	89 c2                	mov    %eax,%edx
  80117a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117d:	01 d0                	add    %edx,%eax
  80117f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801182:	88 10                	mov    %dl,(%eax)
  801184:	eb 56                	jmp    8011dc <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801186:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80118a:	75 1f                	jne    8011ab <readline+0xc5>
  80118c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801190:	7e 19                	jle    8011ab <readline+0xc5>
			if (echoing)
  801192:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801196:	74 0e                	je     8011a6 <readline+0xc0>
				cputchar(c);
  801198:	83 ec 0c             	sub    $0xc,%esp
  80119b:	ff 75 ec             	pushl  -0x14(%ebp)
  80119e:	e8 45 f4 ff ff       	call   8005e8 <cputchar>
  8011a3:	83 c4 10             	add    $0x10,%esp

			i--;
  8011a6:	ff 4d f4             	decl   -0xc(%ebp)
  8011a9:	eb 31                	jmp    8011dc <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8011ab:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011af:	74 0a                	je     8011bb <readline+0xd5>
  8011b1:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8011b5:	0f 85 61 ff ff ff    	jne    80111c <readline+0x36>
			if (echoing)
  8011bb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011bf:	74 0e                	je     8011cf <readline+0xe9>
				cputchar(c);
  8011c1:	83 ec 0c             	sub    $0xc,%esp
  8011c4:	ff 75 ec             	pushl  -0x14(%ebp)
  8011c7:	e8 1c f4 ff ff       	call   8005e8 <cputchar>
  8011cc:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8011cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d5:	01 d0                	add    %edx,%eax
  8011d7:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8011da:	eb 06                	jmp    8011e2 <readline+0xfc>
		}
	}
  8011dc:	e9 3b ff ff ff       	jmp    80111c <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8011e1:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8011e2:	c9                   	leave  
  8011e3:	c3                   	ret    

008011e4 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8011e4:	55                   	push   %ebp
  8011e5:	89 e5                	mov    %esp,%ebp
  8011e7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8011ea:	e8 31 0b 00 00       	call   801d20 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8011ef:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011f3:	74 13                	je     801208 <atomic_readline+0x24>
		cprintf("%s", prompt);
  8011f5:	83 ec 08             	sub    $0x8,%esp
  8011f8:	ff 75 08             	pushl  0x8(%ebp)
  8011fb:	68 d0 2a 80 00       	push   $0x802ad0
  801200:	e8 5f f8 ff ff       	call   800a64 <cprintf>
  801205:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801208:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80120f:	83 ec 0c             	sub    $0xc,%esp
  801212:	6a 00                	push   $0x0
  801214:	e8 65 f4 ff ff       	call   80067e <iscons>
  801219:	83 c4 10             	add    $0x10,%esp
  80121c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80121f:	e8 0c f4 ff ff       	call   800630 <getchar>
  801224:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801227:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80122b:	79 23                	jns    801250 <atomic_readline+0x6c>
			if (c != -E_EOF)
  80122d:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801231:	74 13                	je     801246 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801233:	83 ec 08             	sub    $0x8,%esp
  801236:	ff 75 ec             	pushl  -0x14(%ebp)
  801239:	68 d3 2a 80 00       	push   $0x802ad3
  80123e:	e8 21 f8 ff ff       	call   800a64 <cprintf>
  801243:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801246:	e8 ef 0a 00 00       	call   801d3a <sys_enable_interrupt>
			return;
  80124b:	e9 9a 00 00 00       	jmp    8012ea <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801250:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801254:	7e 34                	jle    80128a <atomic_readline+0xa6>
  801256:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80125d:	7f 2b                	jg     80128a <atomic_readline+0xa6>
			if (echoing)
  80125f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801263:	74 0e                	je     801273 <atomic_readline+0x8f>
				cputchar(c);
  801265:	83 ec 0c             	sub    $0xc,%esp
  801268:	ff 75 ec             	pushl  -0x14(%ebp)
  80126b:	e8 78 f3 ff ff       	call   8005e8 <cputchar>
  801270:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801273:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801276:	8d 50 01             	lea    0x1(%eax),%edx
  801279:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80127c:	89 c2                	mov    %eax,%edx
  80127e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801281:	01 d0                	add    %edx,%eax
  801283:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801286:	88 10                	mov    %dl,(%eax)
  801288:	eb 5b                	jmp    8012e5 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  80128a:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80128e:	75 1f                	jne    8012af <atomic_readline+0xcb>
  801290:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801294:	7e 19                	jle    8012af <atomic_readline+0xcb>
			if (echoing)
  801296:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80129a:	74 0e                	je     8012aa <atomic_readline+0xc6>
				cputchar(c);
  80129c:	83 ec 0c             	sub    $0xc,%esp
  80129f:	ff 75 ec             	pushl  -0x14(%ebp)
  8012a2:	e8 41 f3 ff ff       	call   8005e8 <cputchar>
  8012a7:	83 c4 10             	add    $0x10,%esp
			i--;
  8012aa:	ff 4d f4             	decl   -0xc(%ebp)
  8012ad:	eb 36                	jmp    8012e5 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8012af:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012b3:	74 0a                	je     8012bf <atomic_readline+0xdb>
  8012b5:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012b9:	0f 85 60 ff ff ff    	jne    80121f <atomic_readline+0x3b>
			if (echoing)
  8012bf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012c3:	74 0e                	je     8012d3 <atomic_readline+0xef>
				cputchar(c);
  8012c5:	83 ec 0c             	sub    $0xc,%esp
  8012c8:	ff 75 ec             	pushl  -0x14(%ebp)
  8012cb:	e8 18 f3 ff ff       	call   8005e8 <cputchar>
  8012d0:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8012d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d9:	01 d0                	add    %edx,%eax
  8012db:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8012de:	e8 57 0a 00 00       	call   801d3a <sys_enable_interrupt>
			return;
  8012e3:	eb 05                	jmp    8012ea <atomic_readline+0x106>
		}
	}
  8012e5:	e9 35 ff ff ff       	jmp    80121f <atomic_readline+0x3b>
}
  8012ea:	c9                   	leave  
  8012eb:	c3                   	ret    

008012ec <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8012ec:	55                   	push   %ebp
  8012ed:	89 e5                	mov    %esp,%ebp
  8012ef:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8012f2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012f9:	eb 06                	jmp    801301 <strlen+0x15>
		n++;
  8012fb:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8012fe:	ff 45 08             	incl   0x8(%ebp)
  801301:	8b 45 08             	mov    0x8(%ebp),%eax
  801304:	8a 00                	mov    (%eax),%al
  801306:	84 c0                	test   %al,%al
  801308:	75 f1                	jne    8012fb <strlen+0xf>
		n++;
	return n;
  80130a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80130d:	c9                   	leave  
  80130e:	c3                   	ret    

0080130f <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80130f:	55                   	push   %ebp
  801310:	89 e5                	mov    %esp,%ebp
  801312:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801315:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80131c:	eb 09                	jmp    801327 <strnlen+0x18>
		n++;
  80131e:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801321:	ff 45 08             	incl   0x8(%ebp)
  801324:	ff 4d 0c             	decl   0xc(%ebp)
  801327:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80132b:	74 09                	je     801336 <strnlen+0x27>
  80132d:	8b 45 08             	mov    0x8(%ebp),%eax
  801330:	8a 00                	mov    (%eax),%al
  801332:	84 c0                	test   %al,%al
  801334:	75 e8                	jne    80131e <strnlen+0xf>
		n++;
	return n;
  801336:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801339:	c9                   	leave  
  80133a:	c3                   	ret    

0080133b <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80133b:	55                   	push   %ebp
  80133c:	89 e5                	mov    %esp,%ebp
  80133e:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
  801344:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801347:	90                   	nop
  801348:	8b 45 08             	mov    0x8(%ebp),%eax
  80134b:	8d 50 01             	lea    0x1(%eax),%edx
  80134e:	89 55 08             	mov    %edx,0x8(%ebp)
  801351:	8b 55 0c             	mov    0xc(%ebp),%edx
  801354:	8d 4a 01             	lea    0x1(%edx),%ecx
  801357:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80135a:	8a 12                	mov    (%edx),%dl
  80135c:	88 10                	mov    %dl,(%eax)
  80135e:	8a 00                	mov    (%eax),%al
  801360:	84 c0                	test   %al,%al
  801362:	75 e4                	jne    801348 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801364:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801367:	c9                   	leave  
  801368:	c3                   	ret    

00801369 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801369:	55                   	push   %ebp
  80136a:	89 e5                	mov    %esp,%ebp
  80136c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80136f:	8b 45 08             	mov    0x8(%ebp),%eax
  801372:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801375:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80137c:	eb 1f                	jmp    80139d <strncpy+0x34>
		*dst++ = *src;
  80137e:	8b 45 08             	mov    0x8(%ebp),%eax
  801381:	8d 50 01             	lea    0x1(%eax),%edx
  801384:	89 55 08             	mov    %edx,0x8(%ebp)
  801387:	8b 55 0c             	mov    0xc(%ebp),%edx
  80138a:	8a 12                	mov    (%edx),%dl
  80138c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80138e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801391:	8a 00                	mov    (%eax),%al
  801393:	84 c0                	test   %al,%al
  801395:	74 03                	je     80139a <strncpy+0x31>
			src++;
  801397:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80139a:	ff 45 fc             	incl   -0x4(%ebp)
  80139d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013a0:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013a3:	72 d9                	jb     80137e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013a8:	c9                   	leave  
  8013a9:	c3                   	ret    

008013aa <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013aa:	55                   	push   %ebp
  8013ab:	89 e5                	mov    %esp,%ebp
  8013ad:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8013b6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013ba:	74 30                	je     8013ec <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8013bc:	eb 16                	jmp    8013d4 <strlcpy+0x2a>
			*dst++ = *src++;
  8013be:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c1:	8d 50 01             	lea    0x1(%eax),%edx
  8013c4:	89 55 08             	mov    %edx,0x8(%ebp)
  8013c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ca:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013cd:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013d0:	8a 12                	mov    (%edx),%dl
  8013d2:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8013d4:	ff 4d 10             	decl   0x10(%ebp)
  8013d7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013db:	74 09                	je     8013e6 <strlcpy+0x3c>
  8013dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e0:	8a 00                	mov    (%eax),%al
  8013e2:	84 c0                	test   %al,%al
  8013e4:	75 d8                	jne    8013be <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8013e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e9:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8013ec:	8b 55 08             	mov    0x8(%ebp),%edx
  8013ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013f2:	29 c2                	sub    %eax,%edx
  8013f4:	89 d0                	mov    %edx,%eax
}
  8013f6:	c9                   	leave  
  8013f7:	c3                   	ret    

008013f8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8013f8:	55                   	push   %ebp
  8013f9:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8013fb:	eb 06                	jmp    801403 <strcmp+0xb>
		p++, q++;
  8013fd:	ff 45 08             	incl   0x8(%ebp)
  801400:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801403:	8b 45 08             	mov    0x8(%ebp),%eax
  801406:	8a 00                	mov    (%eax),%al
  801408:	84 c0                	test   %al,%al
  80140a:	74 0e                	je     80141a <strcmp+0x22>
  80140c:	8b 45 08             	mov    0x8(%ebp),%eax
  80140f:	8a 10                	mov    (%eax),%dl
  801411:	8b 45 0c             	mov    0xc(%ebp),%eax
  801414:	8a 00                	mov    (%eax),%al
  801416:	38 c2                	cmp    %al,%dl
  801418:	74 e3                	je     8013fd <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80141a:	8b 45 08             	mov    0x8(%ebp),%eax
  80141d:	8a 00                	mov    (%eax),%al
  80141f:	0f b6 d0             	movzbl %al,%edx
  801422:	8b 45 0c             	mov    0xc(%ebp),%eax
  801425:	8a 00                	mov    (%eax),%al
  801427:	0f b6 c0             	movzbl %al,%eax
  80142a:	29 c2                	sub    %eax,%edx
  80142c:	89 d0                	mov    %edx,%eax
}
  80142e:	5d                   	pop    %ebp
  80142f:	c3                   	ret    

00801430 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801433:	eb 09                	jmp    80143e <strncmp+0xe>
		n--, p++, q++;
  801435:	ff 4d 10             	decl   0x10(%ebp)
  801438:	ff 45 08             	incl   0x8(%ebp)
  80143b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80143e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801442:	74 17                	je     80145b <strncmp+0x2b>
  801444:	8b 45 08             	mov    0x8(%ebp),%eax
  801447:	8a 00                	mov    (%eax),%al
  801449:	84 c0                	test   %al,%al
  80144b:	74 0e                	je     80145b <strncmp+0x2b>
  80144d:	8b 45 08             	mov    0x8(%ebp),%eax
  801450:	8a 10                	mov    (%eax),%dl
  801452:	8b 45 0c             	mov    0xc(%ebp),%eax
  801455:	8a 00                	mov    (%eax),%al
  801457:	38 c2                	cmp    %al,%dl
  801459:	74 da                	je     801435 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80145b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80145f:	75 07                	jne    801468 <strncmp+0x38>
		return 0;
  801461:	b8 00 00 00 00       	mov    $0x0,%eax
  801466:	eb 14                	jmp    80147c <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801468:	8b 45 08             	mov    0x8(%ebp),%eax
  80146b:	8a 00                	mov    (%eax),%al
  80146d:	0f b6 d0             	movzbl %al,%edx
  801470:	8b 45 0c             	mov    0xc(%ebp),%eax
  801473:	8a 00                	mov    (%eax),%al
  801475:	0f b6 c0             	movzbl %al,%eax
  801478:	29 c2                	sub    %eax,%edx
  80147a:	89 d0                	mov    %edx,%eax
}
  80147c:	5d                   	pop    %ebp
  80147d:	c3                   	ret    

0080147e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80147e:	55                   	push   %ebp
  80147f:	89 e5                	mov    %esp,%ebp
  801481:	83 ec 04             	sub    $0x4,%esp
  801484:	8b 45 0c             	mov    0xc(%ebp),%eax
  801487:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80148a:	eb 12                	jmp    80149e <strchr+0x20>
		if (*s == c)
  80148c:	8b 45 08             	mov    0x8(%ebp),%eax
  80148f:	8a 00                	mov    (%eax),%al
  801491:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801494:	75 05                	jne    80149b <strchr+0x1d>
			return (char *) s;
  801496:	8b 45 08             	mov    0x8(%ebp),%eax
  801499:	eb 11                	jmp    8014ac <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80149b:	ff 45 08             	incl   0x8(%ebp)
  80149e:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a1:	8a 00                	mov    (%eax),%al
  8014a3:	84 c0                	test   %al,%al
  8014a5:	75 e5                	jne    80148c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014a7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014ac:	c9                   	leave  
  8014ad:	c3                   	ret    

008014ae <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014ae:	55                   	push   %ebp
  8014af:	89 e5                	mov    %esp,%ebp
  8014b1:	83 ec 04             	sub    $0x4,%esp
  8014b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014ba:	eb 0d                	jmp    8014c9 <strfind+0x1b>
		if (*s == c)
  8014bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bf:	8a 00                	mov    (%eax),%al
  8014c1:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014c4:	74 0e                	je     8014d4 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8014c6:	ff 45 08             	incl   0x8(%ebp)
  8014c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cc:	8a 00                	mov    (%eax),%al
  8014ce:	84 c0                	test   %al,%al
  8014d0:	75 ea                	jne    8014bc <strfind+0xe>
  8014d2:	eb 01                	jmp    8014d5 <strfind+0x27>
		if (*s == c)
			break;
  8014d4:	90                   	nop
	return (char *) s;
  8014d5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014d8:	c9                   	leave  
  8014d9:	c3                   	ret    

008014da <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8014da:	55                   	push   %ebp
  8014db:	89 e5                	mov    %esp,%ebp
  8014dd:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8014e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8014e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8014ec:	eb 0e                	jmp    8014fc <memset+0x22>
		*p++ = c;
  8014ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014f1:	8d 50 01             	lea    0x1(%eax),%edx
  8014f4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014fa:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8014fc:	ff 4d f8             	decl   -0x8(%ebp)
  8014ff:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801503:	79 e9                	jns    8014ee <memset+0x14>
		*p++ = c;

	return v;
  801505:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801508:	c9                   	leave  
  801509:	c3                   	ret    

0080150a <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80150a:	55                   	push   %ebp
  80150b:	89 e5                	mov    %esp,%ebp
  80150d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801510:	8b 45 0c             	mov    0xc(%ebp),%eax
  801513:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801516:	8b 45 08             	mov    0x8(%ebp),%eax
  801519:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80151c:	eb 16                	jmp    801534 <memcpy+0x2a>
		*d++ = *s++;
  80151e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801521:	8d 50 01             	lea    0x1(%eax),%edx
  801524:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801527:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80152a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80152d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801530:	8a 12                	mov    (%edx),%dl
  801532:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801534:	8b 45 10             	mov    0x10(%ebp),%eax
  801537:	8d 50 ff             	lea    -0x1(%eax),%edx
  80153a:	89 55 10             	mov    %edx,0x10(%ebp)
  80153d:	85 c0                	test   %eax,%eax
  80153f:	75 dd                	jne    80151e <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801541:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801544:	c9                   	leave  
  801545:	c3                   	ret    

00801546 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801546:	55                   	push   %ebp
  801547:	89 e5                	mov    %esp,%ebp
  801549:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80154c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80154f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801552:	8b 45 08             	mov    0x8(%ebp),%eax
  801555:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801558:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80155b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80155e:	73 50                	jae    8015b0 <memmove+0x6a>
  801560:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801563:	8b 45 10             	mov    0x10(%ebp),%eax
  801566:	01 d0                	add    %edx,%eax
  801568:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80156b:	76 43                	jbe    8015b0 <memmove+0x6a>
		s += n;
  80156d:	8b 45 10             	mov    0x10(%ebp),%eax
  801570:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801573:	8b 45 10             	mov    0x10(%ebp),%eax
  801576:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801579:	eb 10                	jmp    80158b <memmove+0x45>
			*--d = *--s;
  80157b:	ff 4d f8             	decl   -0x8(%ebp)
  80157e:	ff 4d fc             	decl   -0x4(%ebp)
  801581:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801584:	8a 10                	mov    (%eax),%dl
  801586:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801589:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80158b:	8b 45 10             	mov    0x10(%ebp),%eax
  80158e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801591:	89 55 10             	mov    %edx,0x10(%ebp)
  801594:	85 c0                	test   %eax,%eax
  801596:	75 e3                	jne    80157b <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801598:	eb 23                	jmp    8015bd <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80159a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80159d:	8d 50 01             	lea    0x1(%eax),%edx
  8015a0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015a3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015a6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015a9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015ac:	8a 12                	mov    (%edx),%dl
  8015ae:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015b6:	89 55 10             	mov    %edx,0x10(%ebp)
  8015b9:	85 c0                	test   %eax,%eax
  8015bb:	75 dd                	jne    80159a <memmove+0x54>
			*d++ = *s++;

	return dst;
  8015bd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015c0:	c9                   	leave  
  8015c1:	c3                   	ret    

008015c2 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8015c2:	55                   	push   %ebp
  8015c3:	89 e5                	mov    %esp,%ebp
  8015c5:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8015c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8015ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d1:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8015d4:	eb 2a                	jmp    801600 <memcmp+0x3e>
		if (*s1 != *s2)
  8015d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015d9:	8a 10                	mov    (%eax),%dl
  8015db:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015de:	8a 00                	mov    (%eax),%al
  8015e0:	38 c2                	cmp    %al,%dl
  8015e2:	74 16                	je     8015fa <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015e7:	8a 00                	mov    (%eax),%al
  8015e9:	0f b6 d0             	movzbl %al,%edx
  8015ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ef:	8a 00                	mov    (%eax),%al
  8015f1:	0f b6 c0             	movzbl %al,%eax
  8015f4:	29 c2                	sub    %eax,%edx
  8015f6:	89 d0                	mov    %edx,%eax
  8015f8:	eb 18                	jmp    801612 <memcmp+0x50>
		s1++, s2++;
  8015fa:	ff 45 fc             	incl   -0x4(%ebp)
  8015fd:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801600:	8b 45 10             	mov    0x10(%ebp),%eax
  801603:	8d 50 ff             	lea    -0x1(%eax),%edx
  801606:	89 55 10             	mov    %edx,0x10(%ebp)
  801609:	85 c0                	test   %eax,%eax
  80160b:	75 c9                	jne    8015d6 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80160d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801612:	c9                   	leave  
  801613:	c3                   	ret    

00801614 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801614:	55                   	push   %ebp
  801615:	89 e5                	mov    %esp,%ebp
  801617:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80161a:	8b 55 08             	mov    0x8(%ebp),%edx
  80161d:	8b 45 10             	mov    0x10(%ebp),%eax
  801620:	01 d0                	add    %edx,%eax
  801622:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801625:	eb 15                	jmp    80163c <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801627:	8b 45 08             	mov    0x8(%ebp),%eax
  80162a:	8a 00                	mov    (%eax),%al
  80162c:	0f b6 d0             	movzbl %al,%edx
  80162f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801632:	0f b6 c0             	movzbl %al,%eax
  801635:	39 c2                	cmp    %eax,%edx
  801637:	74 0d                	je     801646 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801639:	ff 45 08             	incl   0x8(%ebp)
  80163c:	8b 45 08             	mov    0x8(%ebp),%eax
  80163f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801642:	72 e3                	jb     801627 <memfind+0x13>
  801644:	eb 01                	jmp    801647 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801646:	90                   	nop
	return (void *) s;
  801647:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80164a:	c9                   	leave  
  80164b:	c3                   	ret    

0080164c <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80164c:	55                   	push   %ebp
  80164d:	89 e5                	mov    %esp,%ebp
  80164f:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801652:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801659:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801660:	eb 03                	jmp    801665 <strtol+0x19>
		s++;
  801662:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801665:	8b 45 08             	mov    0x8(%ebp),%eax
  801668:	8a 00                	mov    (%eax),%al
  80166a:	3c 20                	cmp    $0x20,%al
  80166c:	74 f4                	je     801662 <strtol+0x16>
  80166e:	8b 45 08             	mov    0x8(%ebp),%eax
  801671:	8a 00                	mov    (%eax),%al
  801673:	3c 09                	cmp    $0x9,%al
  801675:	74 eb                	je     801662 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801677:	8b 45 08             	mov    0x8(%ebp),%eax
  80167a:	8a 00                	mov    (%eax),%al
  80167c:	3c 2b                	cmp    $0x2b,%al
  80167e:	75 05                	jne    801685 <strtol+0x39>
		s++;
  801680:	ff 45 08             	incl   0x8(%ebp)
  801683:	eb 13                	jmp    801698 <strtol+0x4c>
	else if (*s == '-')
  801685:	8b 45 08             	mov    0x8(%ebp),%eax
  801688:	8a 00                	mov    (%eax),%al
  80168a:	3c 2d                	cmp    $0x2d,%al
  80168c:	75 0a                	jne    801698 <strtol+0x4c>
		s++, neg = 1;
  80168e:	ff 45 08             	incl   0x8(%ebp)
  801691:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801698:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80169c:	74 06                	je     8016a4 <strtol+0x58>
  80169e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8016a2:	75 20                	jne    8016c4 <strtol+0x78>
  8016a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a7:	8a 00                	mov    (%eax),%al
  8016a9:	3c 30                	cmp    $0x30,%al
  8016ab:	75 17                	jne    8016c4 <strtol+0x78>
  8016ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b0:	40                   	inc    %eax
  8016b1:	8a 00                	mov    (%eax),%al
  8016b3:	3c 78                	cmp    $0x78,%al
  8016b5:	75 0d                	jne    8016c4 <strtol+0x78>
		s += 2, base = 16;
  8016b7:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8016bb:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8016c2:	eb 28                	jmp    8016ec <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8016c4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016c8:	75 15                	jne    8016df <strtol+0x93>
  8016ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cd:	8a 00                	mov    (%eax),%al
  8016cf:	3c 30                	cmp    $0x30,%al
  8016d1:	75 0c                	jne    8016df <strtol+0x93>
		s++, base = 8;
  8016d3:	ff 45 08             	incl   0x8(%ebp)
  8016d6:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8016dd:	eb 0d                	jmp    8016ec <strtol+0xa0>
	else if (base == 0)
  8016df:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016e3:	75 07                	jne    8016ec <strtol+0xa0>
		base = 10;
  8016e5:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ef:	8a 00                	mov    (%eax),%al
  8016f1:	3c 2f                	cmp    $0x2f,%al
  8016f3:	7e 19                	jle    80170e <strtol+0xc2>
  8016f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f8:	8a 00                	mov    (%eax),%al
  8016fa:	3c 39                	cmp    $0x39,%al
  8016fc:	7f 10                	jg     80170e <strtol+0xc2>
			dig = *s - '0';
  8016fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801701:	8a 00                	mov    (%eax),%al
  801703:	0f be c0             	movsbl %al,%eax
  801706:	83 e8 30             	sub    $0x30,%eax
  801709:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80170c:	eb 42                	jmp    801750 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80170e:	8b 45 08             	mov    0x8(%ebp),%eax
  801711:	8a 00                	mov    (%eax),%al
  801713:	3c 60                	cmp    $0x60,%al
  801715:	7e 19                	jle    801730 <strtol+0xe4>
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
  80171a:	8a 00                	mov    (%eax),%al
  80171c:	3c 7a                	cmp    $0x7a,%al
  80171e:	7f 10                	jg     801730 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801720:	8b 45 08             	mov    0x8(%ebp),%eax
  801723:	8a 00                	mov    (%eax),%al
  801725:	0f be c0             	movsbl %al,%eax
  801728:	83 e8 57             	sub    $0x57,%eax
  80172b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80172e:	eb 20                	jmp    801750 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801730:	8b 45 08             	mov    0x8(%ebp),%eax
  801733:	8a 00                	mov    (%eax),%al
  801735:	3c 40                	cmp    $0x40,%al
  801737:	7e 39                	jle    801772 <strtol+0x126>
  801739:	8b 45 08             	mov    0x8(%ebp),%eax
  80173c:	8a 00                	mov    (%eax),%al
  80173e:	3c 5a                	cmp    $0x5a,%al
  801740:	7f 30                	jg     801772 <strtol+0x126>
			dig = *s - 'A' + 10;
  801742:	8b 45 08             	mov    0x8(%ebp),%eax
  801745:	8a 00                	mov    (%eax),%al
  801747:	0f be c0             	movsbl %al,%eax
  80174a:	83 e8 37             	sub    $0x37,%eax
  80174d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801750:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801753:	3b 45 10             	cmp    0x10(%ebp),%eax
  801756:	7d 19                	jge    801771 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801758:	ff 45 08             	incl   0x8(%ebp)
  80175b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80175e:	0f af 45 10          	imul   0x10(%ebp),%eax
  801762:	89 c2                	mov    %eax,%edx
  801764:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801767:	01 d0                	add    %edx,%eax
  801769:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80176c:	e9 7b ff ff ff       	jmp    8016ec <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801771:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801772:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801776:	74 08                	je     801780 <strtol+0x134>
		*endptr = (char *) s;
  801778:	8b 45 0c             	mov    0xc(%ebp),%eax
  80177b:	8b 55 08             	mov    0x8(%ebp),%edx
  80177e:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801780:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801784:	74 07                	je     80178d <strtol+0x141>
  801786:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801789:	f7 d8                	neg    %eax
  80178b:	eb 03                	jmp    801790 <strtol+0x144>
  80178d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801790:	c9                   	leave  
  801791:	c3                   	ret    

00801792 <ltostr>:

void
ltostr(long value, char *str)
{
  801792:	55                   	push   %ebp
  801793:	89 e5                	mov    %esp,%ebp
  801795:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801798:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80179f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017a6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017aa:	79 13                	jns    8017bf <ltostr+0x2d>
	{
		neg = 1;
  8017ac:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8017b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b6:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8017b9:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8017bc:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8017bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c2:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8017c7:	99                   	cltd   
  8017c8:	f7 f9                	idiv   %ecx
  8017ca:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8017cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017d0:	8d 50 01             	lea    0x1(%eax),%edx
  8017d3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017d6:	89 c2                	mov    %eax,%edx
  8017d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017db:	01 d0                	add    %edx,%eax
  8017dd:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017e0:	83 c2 30             	add    $0x30,%edx
  8017e3:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017e5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017e8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017ed:	f7 e9                	imul   %ecx
  8017ef:	c1 fa 02             	sar    $0x2,%edx
  8017f2:	89 c8                	mov    %ecx,%eax
  8017f4:	c1 f8 1f             	sar    $0x1f,%eax
  8017f7:	29 c2                	sub    %eax,%edx
  8017f9:	89 d0                	mov    %edx,%eax
  8017fb:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8017fe:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801801:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801806:	f7 e9                	imul   %ecx
  801808:	c1 fa 02             	sar    $0x2,%edx
  80180b:	89 c8                	mov    %ecx,%eax
  80180d:	c1 f8 1f             	sar    $0x1f,%eax
  801810:	29 c2                	sub    %eax,%edx
  801812:	89 d0                	mov    %edx,%eax
  801814:	c1 e0 02             	shl    $0x2,%eax
  801817:	01 d0                	add    %edx,%eax
  801819:	01 c0                	add    %eax,%eax
  80181b:	29 c1                	sub    %eax,%ecx
  80181d:	89 ca                	mov    %ecx,%edx
  80181f:	85 d2                	test   %edx,%edx
  801821:	75 9c                	jne    8017bf <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801823:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80182a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80182d:	48                   	dec    %eax
  80182e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801831:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801835:	74 3d                	je     801874 <ltostr+0xe2>
		start = 1 ;
  801837:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80183e:	eb 34                	jmp    801874 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801840:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801843:	8b 45 0c             	mov    0xc(%ebp),%eax
  801846:	01 d0                	add    %edx,%eax
  801848:	8a 00                	mov    (%eax),%al
  80184a:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80184d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801850:	8b 45 0c             	mov    0xc(%ebp),%eax
  801853:	01 c2                	add    %eax,%edx
  801855:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801858:	8b 45 0c             	mov    0xc(%ebp),%eax
  80185b:	01 c8                	add    %ecx,%eax
  80185d:	8a 00                	mov    (%eax),%al
  80185f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801861:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801864:	8b 45 0c             	mov    0xc(%ebp),%eax
  801867:	01 c2                	add    %eax,%edx
  801869:	8a 45 eb             	mov    -0x15(%ebp),%al
  80186c:	88 02                	mov    %al,(%edx)
		start++ ;
  80186e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801871:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801874:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801877:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80187a:	7c c4                	jl     801840 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80187c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80187f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801882:	01 d0                	add    %edx,%eax
  801884:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801887:	90                   	nop
  801888:	c9                   	leave  
  801889:	c3                   	ret    

0080188a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80188a:	55                   	push   %ebp
  80188b:	89 e5                	mov    %esp,%ebp
  80188d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801890:	ff 75 08             	pushl  0x8(%ebp)
  801893:	e8 54 fa ff ff       	call   8012ec <strlen>
  801898:	83 c4 04             	add    $0x4,%esp
  80189b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80189e:	ff 75 0c             	pushl  0xc(%ebp)
  8018a1:	e8 46 fa ff ff       	call   8012ec <strlen>
  8018a6:	83 c4 04             	add    $0x4,%esp
  8018a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8018b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018ba:	eb 17                	jmp    8018d3 <strcconcat+0x49>
		final[s] = str1[s] ;
  8018bc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8018c2:	01 c2                	add    %eax,%edx
  8018c4:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8018c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ca:	01 c8                	add    %ecx,%eax
  8018cc:	8a 00                	mov    (%eax),%al
  8018ce:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8018d0:	ff 45 fc             	incl   -0x4(%ebp)
  8018d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018d6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018d9:	7c e1                	jl     8018bc <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8018db:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8018e2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8018e9:	eb 1f                	jmp    80190a <strcconcat+0x80>
		final[s++] = str2[i] ;
  8018eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018ee:	8d 50 01             	lea    0x1(%eax),%edx
  8018f1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018f4:	89 c2                	mov    %eax,%edx
  8018f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8018f9:	01 c2                	add    %eax,%edx
  8018fb:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801901:	01 c8                	add    %ecx,%eax
  801903:	8a 00                	mov    (%eax),%al
  801905:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801907:	ff 45 f8             	incl   -0x8(%ebp)
  80190a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80190d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801910:	7c d9                	jl     8018eb <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801912:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801915:	8b 45 10             	mov    0x10(%ebp),%eax
  801918:	01 d0                	add    %edx,%eax
  80191a:	c6 00 00             	movb   $0x0,(%eax)
}
  80191d:	90                   	nop
  80191e:	c9                   	leave  
  80191f:	c3                   	ret    

00801920 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801920:	55                   	push   %ebp
  801921:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801923:	8b 45 14             	mov    0x14(%ebp),%eax
  801926:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80192c:	8b 45 14             	mov    0x14(%ebp),%eax
  80192f:	8b 00                	mov    (%eax),%eax
  801931:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801938:	8b 45 10             	mov    0x10(%ebp),%eax
  80193b:	01 d0                	add    %edx,%eax
  80193d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801943:	eb 0c                	jmp    801951 <strsplit+0x31>
			*string++ = 0;
  801945:	8b 45 08             	mov    0x8(%ebp),%eax
  801948:	8d 50 01             	lea    0x1(%eax),%edx
  80194b:	89 55 08             	mov    %edx,0x8(%ebp)
  80194e:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801951:	8b 45 08             	mov    0x8(%ebp),%eax
  801954:	8a 00                	mov    (%eax),%al
  801956:	84 c0                	test   %al,%al
  801958:	74 18                	je     801972 <strsplit+0x52>
  80195a:	8b 45 08             	mov    0x8(%ebp),%eax
  80195d:	8a 00                	mov    (%eax),%al
  80195f:	0f be c0             	movsbl %al,%eax
  801962:	50                   	push   %eax
  801963:	ff 75 0c             	pushl  0xc(%ebp)
  801966:	e8 13 fb ff ff       	call   80147e <strchr>
  80196b:	83 c4 08             	add    $0x8,%esp
  80196e:	85 c0                	test   %eax,%eax
  801970:	75 d3                	jne    801945 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801972:	8b 45 08             	mov    0x8(%ebp),%eax
  801975:	8a 00                	mov    (%eax),%al
  801977:	84 c0                	test   %al,%al
  801979:	74 5a                	je     8019d5 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80197b:	8b 45 14             	mov    0x14(%ebp),%eax
  80197e:	8b 00                	mov    (%eax),%eax
  801980:	83 f8 0f             	cmp    $0xf,%eax
  801983:	75 07                	jne    80198c <strsplit+0x6c>
		{
			return 0;
  801985:	b8 00 00 00 00       	mov    $0x0,%eax
  80198a:	eb 66                	jmp    8019f2 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80198c:	8b 45 14             	mov    0x14(%ebp),%eax
  80198f:	8b 00                	mov    (%eax),%eax
  801991:	8d 48 01             	lea    0x1(%eax),%ecx
  801994:	8b 55 14             	mov    0x14(%ebp),%edx
  801997:	89 0a                	mov    %ecx,(%edx)
  801999:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8019a3:	01 c2                	add    %eax,%edx
  8019a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a8:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019aa:	eb 03                	jmp    8019af <strsplit+0x8f>
			string++;
  8019ac:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019af:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b2:	8a 00                	mov    (%eax),%al
  8019b4:	84 c0                	test   %al,%al
  8019b6:	74 8b                	je     801943 <strsplit+0x23>
  8019b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bb:	8a 00                	mov    (%eax),%al
  8019bd:	0f be c0             	movsbl %al,%eax
  8019c0:	50                   	push   %eax
  8019c1:	ff 75 0c             	pushl  0xc(%ebp)
  8019c4:	e8 b5 fa ff ff       	call   80147e <strchr>
  8019c9:	83 c4 08             	add    $0x8,%esp
  8019cc:	85 c0                	test   %eax,%eax
  8019ce:	74 dc                	je     8019ac <strsplit+0x8c>
			string++;
	}
  8019d0:	e9 6e ff ff ff       	jmp    801943 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8019d5:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8019d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8019d9:	8b 00                	mov    (%eax),%eax
  8019db:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8019e5:	01 d0                	add    %edx,%eax
  8019e7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019ed:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019f2:	c9                   	leave  
  8019f3:	c3                   	ret    

008019f4 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  8019f4:	55                   	push   %ebp
  8019f5:	89 e5                	mov    %esp,%ebp
  8019f7:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  8019fa:	83 ec 04             	sub    $0x4,%esp
  8019fd:	68 e4 2a 80 00       	push   $0x802ae4
  801a02:	6a 15                	push   $0x15
  801a04:	68 09 2b 80 00       	push   $0x802b09
  801a09:	e8 9f ed ff ff       	call   8007ad <_panic>

00801a0e <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801a0e:	55                   	push   %ebp
  801a0f:	89 e5                	mov    %esp,%ebp
  801a11:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801a14:	83 ec 04             	sub    $0x4,%esp
  801a17:	68 18 2b 80 00       	push   $0x802b18
  801a1c:	6a 2e                	push   $0x2e
  801a1e:	68 09 2b 80 00       	push   $0x802b09
  801a23:	e8 85 ed ff ff       	call   8007ad <_panic>

00801a28 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801a28:	55                   	push   %ebp
  801a29:	89 e5                	mov    %esp,%ebp
  801a2b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a2e:	83 ec 04             	sub    $0x4,%esp
  801a31:	68 3c 2b 80 00       	push   $0x802b3c
  801a36:	6a 4c                	push   $0x4c
  801a38:	68 09 2b 80 00       	push   $0x802b09
  801a3d:	e8 6b ed ff ff       	call   8007ad <_panic>

00801a42 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801a42:	55                   	push   %ebp
  801a43:	89 e5                	mov    %esp,%ebp
  801a45:	83 ec 18             	sub    $0x18,%esp
  801a48:	8b 45 10             	mov    0x10(%ebp),%eax
  801a4b:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801a4e:	83 ec 04             	sub    $0x4,%esp
  801a51:	68 3c 2b 80 00       	push   $0x802b3c
  801a56:	6a 57                	push   $0x57
  801a58:	68 09 2b 80 00       	push   $0x802b09
  801a5d:	e8 4b ed ff ff       	call   8007ad <_panic>

00801a62 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801a62:	55                   	push   %ebp
  801a63:	89 e5                	mov    %esp,%ebp
  801a65:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a68:	83 ec 04             	sub    $0x4,%esp
  801a6b:	68 3c 2b 80 00       	push   $0x802b3c
  801a70:	6a 5d                	push   $0x5d
  801a72:	68 09 2b 80 00       	push   $0x802b09
  801a77:	e8 31 ed ff ff       	call   8007ad <_panic>

00801a7c <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801a7c:	55                   	push   %ebp
  801a7d:	89 e5                	mov    %esp,%ebp
  801a7f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a82:	83 ec 04             	sub    $0x4,%esp
  801a85:	68 3c 2b 80 00       	push   $0x802b3c
  801a8a:	6a 63                	push   $0x63
  801a8c:	68 09 2b 80 00       	push   $0x802b09
  801a91:	e8 17 ed ff ff       	call   8007ad <_panic>

00801a96 <expand>:
}

void expand(uint32 newSize)
{
  801a96:	55                   	push   %ebp
  801a97:	89 e5                	mov    %esp,%ebp
  801a99:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a9c:	83 ec 04             	sub    $0x4,%esp
  801a9f:	68 3c 2b 80 00       	push   $0x802b3c
  801aa4:	6a 68                	push   $0x68
  801aa6:	68 09 2b 80 00       	push   $0x802b09
  801aab:	e8 fd ec ff ff       	call   8007ad <_panic>

00801ab0 <shrink>:
}
void shrink(uint32 newSize)
{
  801ab0:	55                   	push   %ebp
  801ab1:	89 e5                	mov    %esp,%ebp
  801ab3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ab6:	83 ec 04             	sub    $0x4,%esp
  801ab9:	68 3c 2b 80 00       	push   $0x802b3c
  801abe:	6a 6c                	push   $0x6c
  801ac0:	68 09 2b 80 00       	push   $0x802b09
  801ac5:	e8 e3 ec ff ff       	call   8007ad <_panic>

00801aca <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801aca:	55                   	push   %ebp
  801acb:	89 e5                	mov    %esp,%ebp
  801acd:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ad0:	83 ec 04             	sub    $0x4,%esp
  801ad3:	68 3c 2b 80 00       	push   $0x802b3c
  801ad8:	6a 71                	push   $0x71
  801ada:	68 09 2b 80 00       	push   $0x802b09
  801adf:	e8 c9 ec ff ff       	call   8007ad <_panic>

00801ae4 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801ae4:	55                   	push   %ebp
  801ae5:	89 e5                	mov    %esp,%ebp
  801ae7:	57                   	push   %edi
  801ae8:	56                   	push   %esi
  801ae9:	53                   	push   %ebx
  801aea:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801aed:	8b 45 08             	mov    0x8(%ebp),%eax
  801af0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801af3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801af6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801af9:	8b 7d 18             	mov    0x18(%ebp),%edi
  801afc:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801aff:	cd 30                	int    $0x30
  801b01:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801b04:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b07:	83 c4 10             	add    $0x10,%esp
  801b0a:	5b                   	pop    %ebx
  801b0b:	5e                   	pop    %esi
  801b0c:	5f                   	pop    %edi
  801b0d:	5d                   	pop    %ebp
  801b0e:	c3                   	ret    

00801b0f <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801b0f:	55                   	push   %ebp
  801b10:	89 e5                	mov    %esp,%ebp
  801b12:	83 ec 04             	sub    $0x4,%esp
  801b15:	8b 45 10             	mov    0x10(%ebp),%eax
  801b18:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801b1b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b22:	6a 00                	push   $0x0
  801b24:	6a 00                	push   $0x0
  801b26:	52                   	push   %edx
  801b27:	ff 75 0c             	pushl  0xc(%ebp)
  801b2a:	50                   	push   %eax
  801b2b:	6a 00                	push   $0x0
  801b2d:	e8 b2 ff ff ff       	call   801ae4 <syscall>
  801b32:	83 c4 18             	add    $0x18,%esp
}
  801b35:	90                   	nop
  801b36:	c9                   	leave  
  801b37:	c3                   	ret    

00801b38 <sys_cgetc>:

int
sys_cgetc(void)
{
  801b38:	55                   	push   %ebp
  801b39:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b3b:	6a 00                	push   $0x0
  801b3d:	6a 00                	push   $0x0
  801b3f:	6a 00                	push   $0x0
  801b41:	6a 00                	push   $0x0
  801b43:	6a 00                	push   $0x0
  801b45:	6a 01                	push   $0x1
  801b47:	e8 98 ff ff ff       	call   801ae4 <syscall>
  801b4c:	83 c4 18             	add    $0x18,%esp
}
  801b4f:	c9                   	leave  
  801b50:	c3                   	ret    

00801b51 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801b51:	55                   	push   %ebp
  801b52:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801b54:	8b 45 08             	mov    0x8(%ebp),%eax
  801b57:	6a 00                	push   $0x0
  801b59:	6a 00                	push   $0x0
  801b5b:	6a 00                	push   $0x0
  801b5d:	6a 00                	push   $0x0
  801b5f:	50                   	push   %eax
  801b60:	6a 05                	push   $0x5
  801b62:	e8 7d ff ff ff       	call   801ae4 <syscall>
  801b67:	83 c4 18             	add    $0x18,%esp
}
  801b6a:	c9                   	leave  
  801b6b:	c3                   	ret    

00801b6c <sys_getenvid>:

int32 sys_getenvid(void)
{
  801b6c:	55                   	push   %ebp
  801b6d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801b6f:	6a 00                	push   $0x0
  801b71:	6a 00                	push   $0x0
  801b73:	6a 00                	push   $0x0
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 02                	push   $0x2
  801b7b:	e8 64 ff ff ff       	call   801ae4 <syscall>
  801b80:	83 c4 18             	add    $0x18,%esp
}
  801b83:	c9                   	leave  
  801b84:	c3                   	ret    

00801b85 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801b85:	55                   	push   %ebp
  801b86:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801b88:	6a 00                	push   $0x0
  801b8a:	6a 00                	push   $0x0
  801b8c:	6a 00                	push   $0x0
  801b8e:	6a 00                	push   $0x0
  801b90:	6a 00                	push   $0x0
  801b92:	6a 03                	push   $0x3
  801b94:	e8 4b ff ff ff       	call   801ae4 <syscall>
  801b99:	83 c4 18             	add    $0x18,%esp
}
  801b9c:	c9                   	leave  
  801b9d:	c3                   	ret    

00801b9e <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b9e:	55                   	push   %ebp
  801b9f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801ba1:	6a 00                	push   $0x0
  801ba3:	6a 00                	push   $0x0
  801ba5:	6a 00                	push   $0x0
  801ba7:	6a 00                	push   $0x0
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 04                	push   $0x4
  801bad:	e8 32 ff ff ff       	call   801ae4 <syscall>
  801bb2:	83 c4 18             	add    $0x18,%esp
}
  801bb5:	c9                   	leave  
  801bb6:	c3                   	ret    

00801bb7 <sys_env_exit>:


void sys_env_exit(void)
{
  801bb7:	55                   	push   %ebp
  801bb8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801bba:	6a 00                	push   $0x0
  801bbc:	6a 00                	push   $0x0
  801bbe:	6a 00                	push   $0x0
  801bc0:	6a 00                	push   $0x0
  801bc2:	6a 00                	push   $0x0
  801bc4:	6a 06                	push   $0x6
  801bc6:	e8 19 ff ff ff       	call   801ae4 <syscall>
  801bcb:	83 c4 18             	add    $0x18,%esp
}
  801bce:	90                   	nop
  801bcf:	c9                   	leave  
  801bd0:	c3                   	ret    

00801bd1 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801bd1:	55                   	push   %ebp
  801bd2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801bd4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	52                   	push   %edx
  801be1:	50                   	push   %eax
  801be2:	6a 07                	push   $0x7
  801be4:	e8 fb fe ff ff       	call   801ae4 <syscall>
  801be9:	83 c4 18             	add    $0x18,%esp
}
  801bec:	c9                   	leave  
  801bed:	c3                   	ret    

00801bee <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801bee:	55                   	push   %ebp
  801bef:	89 e5                	mov    %esp,%ebp
  801bf1:	56                   	push   %esi
  801bf2:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801bf3:	8b 75 18             	mov    0x18(%ebp),%esi
  801bf6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bf9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bfc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bff:	8b 45 08             	mov    0x8(%ebp),%eax
  801c02:	56                   	push   %esi
  801c03:	53                   	push   %ebx
  801c04:	51                   	push   %ecx
  801c05:	52                   	push   %edx
  801c06:	50                   	push   %eax
  801c07:	6a 08                	push   $0x8
  801c09:	e8 d6 fe ff ff       	call   801ae4 <syscall>
  801c0e:	83 c4 18             	add    $0x18,%esp
}
  801c11:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801c14:	5b                   	pop    %ebx
  801c15:	5e                   	pop    %esi
  801c16:	5d                   	pop    %ebp
  801c17:	c3                   	ret    

00801c18 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801c18:	55                   	push   %ebp
  801c19:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801c1b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c21:	6a 00                	push   $0x0
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	52                   	push   %edx
  801c28:	50                   	push   %eax
  801c29:	6a 09                	push   $0x9
  801c2b:	e8 b4 fe ff ff       	call   801ae4 <syscall>
  801c30:	83 c4 18             	add    $0x18,%esp
}
  801c33:	c9                   	leave  
  801c34:	c3                   	ret    

00801c35 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c35:	55                   	push   %ebp
  801c36:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c38:	6a 00                	push   $0x0
  801c3a:	6a 00                	push   $0x0
  801c3c:	6a 00                	push   $0x0
  801c3e:	ff 75 0c             	pushl  0xc(%ebp)
  801c41:	ff 75 08             	pushl  0x8(%ebp)
  801c44:	6a 0a                	push   $0xa
  801c46:	e8 99 fe ff ff       	call   801ae4 <syscall>
  801c4b:	83 c4 18             	add    $0x18,%esp
}
  801c4e:	c9                   	leave  
  801c4f:	c3                   	ret    

00801c50 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c50:	55                   	push   %ebp
  801c51:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	6a 00                	push   $0x0
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 0b                	push   $0xb
  801c5f:	e8 80 fe ff ff       	call   801ae4 <syscall>
  801c64:	83 c4 18             	add    $0x18,%esp
}
  801c67:	c9                   	leave  
  801c68:	c3                   	ret    

00801c69 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c69:	55                   	push   %ebp
  801c6a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c6c:	6a 00                	push   $0x0
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	6a 0c                	push   $0xc
  801c78:	e8 67 fe ff ff       	call   801ae4 <syscall>
  801c7d:	83 c4 18             	add    $0x18,%esp
}
  801c80:	c9                   	leave  
  801c81:	c3                   	ret    

00801c82 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801c82:	55                   	push   %ebp
  801c83:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801c85:	6a 00                	push   $0x0
  801c87:	6a 00                	push   $0x0
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 0d                	push   $0xd
  801c91:	e8 4e fe ff ff       	call   801ae4 <syscall>
  801c96:	83 c4 18             	add    $0x18,%esp
}
  801c99:	c9                   	leave  
  801c9a:	c3                   	ret    

00801c9b <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801c9b:	55                   	push   %ebp
  801c9c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c9e:	6a 00                	push   $0x0
  801ca0:	6a 00                	push   $0x0
  801ca2:	6a 00                	push   $0x0
  801ca4:	ff 75 0c             	pushl  0xc(%ebp)
  801ca7:	ff 75 08             	pushl  0x8(%ebp)
  801caa:	6a 11                	push   $0x11
  801cac:	e8 33 fe ff ff       	call   801ae4 <syscall>
  801cb1:	83 c4 18             	add    $0x18,%esp
	return;
  801cb4:	90                   	nop
}
  801cb5:	c9                   	leave  
  801cb6:	c3                   	ret    

00801cb7 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801cb7:	55                   	push   %ebp
  801cb8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	ff 75 0c             	pushl  0xc(%ebp)
  801cc3:	ff 75 08             	pushl  0x8(%ebp)
  801cc6:	6a 12                	push   $0x12
  801cc8:	e8 17 fe ff ff       	call   801ae4 <syscall>
  801ccd:	83 c4 18             	add    $0x18,%esp
	return ;
  801cd0:	90                   	nop
}
  801cd1:	c9                   	leave  
  801cd2:	c3                   	ret    

00801cd3 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801cd3:	55                   	push   %ebp
  801cd4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801cd6:	6a 00                	push   $0x0
  801cd8:	6a 00                	push   $0x0
  801cda:	6a 00                	push   $0x0
  801cdc:	6a 00                	push   $0x0
  801cde:	6a 00                	push   $0x0
  801ce0:	6a 0e                	push   $0xe
  801ce2:	e8 fd fd ff ff       	call   801ae4 <syscall>
  801ce7:	83 c4 18             	add    $0x18,%esp
}
  801cea:	c9                   	leave  
  801ceb:	c3                   	ret    

00801cec <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801cec:	55                   	push   %ebp
  801ced:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801cef:	6a 00                	push   $0x0
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 00                	push   $0x0
  801cf7:	ff 75 08             	pushl  0x8(%ebp)
  801cfa:	6a 0f                	push   $0xf
  801cfc:	e8 e3 fd ff ff       	call   801ae4 <syscall>
  801d01:	83 c4 18             	add    $0x18,%esp
}
  801d04:	c9                   	leave  
  801d05:	c3                   	ret    

00801d06 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801d06:	55                   	push   %ebp
  801d07:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	6a 10                	push   $0x10
  801d15:	e8 ca fd ff ff       	call   801ae4 <syscall>
  801d1a:	83 c4 18             	add    $0x18,%esp
}
  801d1d:	90                   	nop
  801d1e:	c9                   	leave  
  801d1f:	c3                   	ret    

00801d20 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801d20:	55                   	push   %ebp
  801d21:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801d23:	6a 00                	push   $0x0
  801d25:	6a 00                	push   $0x0
  801d27:	6a 00                	push   $0x0
  801d29:	6a 00                	push   $0x0
  801d2b:	6a 00                	push   $0x0
  801d2d:	6a 14                	push   $0x14
  801d2f:	e8 b0 fd ff ff       	call   801ae4 <syscall>
  801d34:	83 c4 18             	add    $0x18,%esp
}
  801d37:	90                   	nop
  801d38:	c9                   	leave  
  801d39:	c3                   	ret    

00801d3a <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801d3a:	55                   	push   %ebp
  801d3b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	6a 15                	push   $0x15
  801d49:	e8 96 fd ff ff       	call   801ae4 <syscall>
  801d4e:	83 c4 18             	add    $0x18,%esp
}
  801d51:	90                   	nop
  801d52:	c9                   	leave  
  801d53:	c3                   	ret    

00801d54 <sys_cputc>:


void
sys_cputc(const char c)
{
  801d54:	55                   	push   %ebp
  801d55:	89 e5                	mov    %esp,%ebp
  801d57:	83 ec 04             	sub    $0x4,%esp
  801d5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801d60:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d64:	6a 00                	push   $0x0
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 00                	push   $0x0
  801d6c:	50                   	push   %eax
  801d6d:	6a 16                	push   $0x16
  801d6f:	e8 70 fd ff ff       	call   801ae4 <syscall>
  801d74:	83 c4 18             	add    $0x18,%esp
}
  801d77:	90                   	nop
  801d78:	c9                   	leave  
  801d79:	c3                   	ret    

00801d7a <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801d7a:	55                   	push   %ebp
  801d7b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	6a 00                	push   $0x0
  801d87:	6a 17                	push   $0x17
  801d89:	e8 56 fd ff ff       	call   801ae4 <syscall>
  801d8e:	83 c4 18             	add    $0x18,%esp
}
  801d91:	90                   	nop
  801d92:	c9                   	leave  
  801d93:	c3                   	ret    

00801d94 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801d94:	55                   	push   %ebp
  801d95:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801d97:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	ff 75 0c             	pushl  0xc(%ebp)
  801da3:	50                   	push   %eax
  801da4:	6a 18                	push   $0x18
  801da6:	e8 39 fd ff ff       	call   801ae4 <syscall>
  801dab:	83 c4 18             	add    $0x18,%esp
}
  801dae:	c9                   	leave  
  801daf:	c3                   	ret    

00801db0 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801db0:	55                   	push   %ebp
  801db1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801db3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801db6:	8b 45 08             	mov    0x8(%ebp),%eax
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 00                	push   $0x0
  801dbf:	52                   	push   %edx
  801dc0:	50                   	push   %eax
  801dc1:	6a 1b                	push   $0x1b
  801dc3:	e8 1c fd ff ff       	call   801ae4 <syscall>
  801dc8:	83 c4 18             	add    $0x18,%esp
}
  801dcb:	c9                   	leave  
  801dcc:	c3                   	ret    

00801dcd <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801dcd:	55                   	push   %ebp
  801dce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801dd0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd6:	6a 00                	push   $0x0
  801dd8:	6a 00                	push   $0x0
  801dda:	6a 00                	push   $0x0
  801ddc:	52                   	push   %edx
  801ddd:	50                   	push   %eax
  801dde:	6a 19                	push   $0x19
  801de0:	e8 ff fc ff ff       	call   801ae4 <syscall>
  801de5:	83 c4 18             	add    $0x18,%esp
}
  801de8:	90                   	nop
  801de9:	c9                   	leave  
  801dea:	c3                   	ret    

00801deb <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801deb:	55                   	push   %ebp
  801dec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801dee:	8b 55 0c             	mov    0xc(%ebp),%edx
  801df1:	8b 45 08             	mov    0x8(%ebp),%eax
  801df4:	6a 00                	push   $0x0
  801df6:	6a 00                	push   $0x0
  801df8:	6a 00                	push   $0x0
  801dfa:	52                   	push   %edx
  801dfb:	50                   	push   %eax
  801dfc:	6a 1a                	push   $0x1a
  801dfe:	e8 e1 fc ff ff       	call   801ae4 <syscall>
  801e03:	83 c4 18             	add    $0x18,%esp
}
  801e06:	90                   	nop
  801e07:	c9                   	leave  
  801e08:	c3                   	ret    

00801e09 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801e09:	55                   	push   %ebp
  801e0a:	89 e5                	mov    %esp,%ebp
  801e0c:	83 ec 04             	sub    $0x4,%esp
  801e0f:	8b 45 10             	mov    0x10(%ebp),%eax
  801e12:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801e15:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801e18:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1f:	6a 00                	push   $0x0
  801e21:	51                   	push   %ecx
  801e22:	52                   	push   %edx
  801e23:	ff 75 0c             	pushl  0xc(%ebp)
  801e26:	50                   	push   %eax
  801e27:	6a 1c                	push   $0x1c
  801e29:	e8 b6 fc ff ff       	call   801ae4 <syscall>
  801e2e:	83 c4 18             	add    $0x18,%esp
}
  801e31:	c9                   	leave  
  801e32:	c3                   	ret    

00801e33 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801e33:	55                   	push   %ebp
  801e34:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801e36:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e39:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 00                	push   $0x0
  801e40:	6a 00                	push   $0x0
  801e42:	52                   	push   %edx
  801e43:	50                   	push   %eax
  801e44:	6a 1d                	push   $0x1d
  801e46:	e8 99 fc ff ff       	call   801ae4 <syscall>
  801e4b:	83 c4 18             	add    $0x18,%esp
}
  801e4e:	c9                   	leave  
  801e4f:	c3                   	ret    

00801e50 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801e50:	55                   	push   %ebp
  801e51:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801e53:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e56:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e59:	8b 45 08             	mov    0x8(%ebp),%eax
  801e5c:	6a 00                	push   $0x0
  801e5e:	6a 00                	push   $0x0
  801e60:	51                   	push   %ecx
  801e61:	52                   	push   %edx
  801e62:	50                   	push   %eax
  801e63:	6a 1e                	push   $0x1e
  801e65:	e8 7a fc ff ff       	call   801ae4 <syscall>
  801e6a:	83 c4 18             	add    $0x18,%esp
}
  801e6d:	c9                   	leave  
  801e6e:	c3                   	ret    

00801e6f <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801e6f:	55                   	push   %ebp
  801e70:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801e72:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e75:	8b 45 08             	mov    0x8(%ebp),%eax
  801e78:	6a 00                	push   $0x0
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 00                	push   $0x0
  801e7e:	52                   	push   %edx
  801e7f:	50                   	push   %eax
  801e80:	6a 1f                	push   $0x1f
  801e82:	e8 5d fc ff ff       	call   801ae4 <syscall>
  801e87:	83 c4 18             	add    $0x18,%esp
}
  801e8a:	c9                   	leave  
  801e8b:	c3                   	ret    

00801e8c <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801e8c:	55                   	push   %ebp
  801e8d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801e8f:	6a 00                	push   $0x0
  801e91:	6a 00                	push   $0x0
  801e93:	6a 00                	push   $0x0
  801e95:	6a 00                	push   $0x0
  801e97:	6a 00                	push   $0x0
  801e99:	6a 20                	push   $0x20
  801e9b:	e8 44 fc ff ff       	call   801ae4 <syscall>
  801ea0:	83 c4 18             	add    $0x18,%esp
}
  801ea3:	c9                   	leave  
  801ea4:	c3                   	ret    

00801ea5 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801ea5:	55                   	push   %ebp
  801ea6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801ea8:	8b 45 08             	mov    0x8(%ebp),%eax
  801eab:	6a 00                	push   $0x0
  801ead:	ff 75 14             	pushl  0x14(%ebp)
  801eb0:	ff 75 10             	pushl  0x10(%ebp)
  801eb3:	ff 75 0c             	pushl  0xc(%ebp)
  801eb6:	50                   	push   %eax
  801eb7:	6a 21                	push   $0x21
  801eb9:	e8 26 fc ff ff       	call   801ae4 <syscall>
  801ebe:	83 c4 18             	add    $0x18,%esp
}
  801ec1:	c9                   	leave  
  801ec2:	c3                   	ret    

00801ec3 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801ec3:	55                   	push   %ebp
  801ec4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ec6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec9:	6a 00                	push   $0x0
  801ecb:	6a 00                	push   $0x0
  801ecd:	6a 00                	push   $0x0
  801ecf:	6a 00                	push   $0x0
  801ed1:	50                   	push   %eax
  801ed2:	6a 22                	push   $0x22
  801ed4:	e8 0b fc ff ff       	call   801ae4 <syscall>
  801ed9:	83 c4 18             	add    $0x18,%esp
}
  801edc:	90                   	nop
  801edd:	c9                   	leave  
  801ede:	c3                   	ret    

00801edf <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801edf:	55                   	push   %ebp
  801ee0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee5:	6a 00                	push   $0x0
  801ee7:	6a 00                	push   $0x0
  801ee9:	6a 00                	push   $0x0
  801eeb:	6a 00                	push   $0x0
  801eed:	50                   	push   %eax
  801eee:	6a 23                	push   $0x23
  801ef0:	e8 ef fb ff ff       	call   801ae4 <syscall>
  801ef5:	83 c4 18             	add    $0x18,%esp
}
  801ef8:	90                   	nop
  801ef9:	c9                   	leave  
  801efa:	c3                   	ret    

00801efb <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801efb:	55                   	push   %ebp
  801efc:	89 e5                	mov    %esp,%ebp
  801efe:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801f01:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f04:	8d 50 04             	lea    0x4(%eax),%edx
  801f07:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f0a:	6a 00                	push   $0x0
  801f0c:	6a 00                	push   $0x0
  801f0e:	6a 00                	push   $0x0
  801f10:	52                   	push   %edx
  801f11:	50                   	push   %eax
  801f12:	6a 24                	push   $0x24
  801f14:	e8 cb fb ff ff       	call   801ae4 <syscall>
  801f19:	83 c4 18             	add    $0x18,%esp
	return result;
  801f1c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801f1f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801f22:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f25:	89 01                	mov    %eax,(%ecx)
  801f27:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2d:	c9                   	leave  
  801f2e:	c2 04 00             	ret    $0x4

00801f31 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801f31:	55                   	push   %ebp
  801f32:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	ff 75 10             	pushl  0x10(%ebp)
  801f3b:	ff 75 0c             	pushl  0xc(%ebp)
  801f3e:	ff 75 08             	pushl  0x8(%ebp)
  801f41:	6a 13                	push   $0x13
  801f43:	e8 9c fb ff ff       	call   801ae4 <syscall>
  801f48:	83 c4 18             	add    $0x18,%esp
	return ;
  801f4b:	90                   	nop
}
  801f4c:	c9                   	leave  
  801f4d:	c3                   	ret    

00801f4e <sys_rcr2>:
uint32 sys_rcr2()
{
  801f4e:	55                   	push   %ebp
  801f4f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801f51:	6a 00                	push   $0x0
  801f53:	6a 00                	push   $0x0
  801f55:	6a 00                	push   $0x0
  801f57:	6a 00                	push   $0x0
  801f59:	6a 00                	push   $0x0
  801f5b:	6a 25                	push   $0x25
  801f5d:	e8 82 fb ff ff       	call   801ae4 <syscall>
  801f62:	83 c4 18             	add    $0x18,%esp
}
  801f65:	c9                   	leave  
  801f66:	c3                   	ret    

00801f67 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801f67:	55                   	push   %ebp
  801f68:	89 e5                	mov    %esp,%ebp
  801f6a:	83 ec 04             	sub    $0x4,%esp
  801f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f70:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801f73:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801f77:	6a 00                	push   $0x0
  801f79:	6a 00                	push   $0x0
  801f7b:	6a 00                	push   $0x0
  801f7d:	6a 00                	push   $0x0
  801f7f:	50                   	push   %eax
  801f80:	6a 26                	push   $0x26
  801f82:	e8 5d fb ff ff       	call   801ae4 <syscall>
  801f87:	83 c4 18             	add    $0x18,%esp
	return ;
  801f8a:	90                   	nop
}
  801f8b:	c9                   	leave  
  801f8c:	c3                   	ret    

00801f8d <rsttst>:
void rsttst()
{
  801f8d:	55                   	push   %ebp
  801f8e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801f90:	6a 00                	push   $0x0
  801f92:	6a 00                	push   $0x0
  801f94:	6a 00                	push   $0x0
  801f96:	6a 00                	push   $0x0
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 28                	push   $0x28
  801f9c:	e8 43 fb ff ff       	call   801ae4 <syscall>
  801fa1:	83 c4 18             	add    $0x18,%esp
	return ;
  801fa4:	90                   	nop
}
  801fa5:	c9                   	leave  
  801fa6:	c3                   	ret    

00801fa7 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801fa7:	55                   	push   %ebp
  801fa8:	89 e5                	mov    %esp,%ebp
  801faa:	83 ec 04             	sub    $0x4,%esp
  801fad:	8b 45 14             	mov    0x14(%ebp),%eax
  801fb0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801fb3:	8b 55 18             	mov    0x18(%ebp),%edx
  801fb6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801fba:	52                   	push   %edx
  801fbb:	50                   	push   %eax
  801fbc:	ff 75 10             	pushl  0x10(%ebp)
  801fbf:	ff 75 0c             	pushl  0xc(%ebp)
  801fc2:	ff 75 08             	pushl  0x8(%ebp)
  801fc5:	6a 27                	push   $0x27
  801fc7:	e8 18 fb ff ff       	call   801ae4 <syscall>
  801fcc:	83 c4 18             	add    $0x18,%esp
	return ;
  801fcf:	90                   	nop
}
  801fd0:	c9                   	leave  
  801fd1:	c3                   	ret    

00801fd2 <chktst>:
void chktst(uint32 n)
{
  801fd2:	55                   	push   %ebp
  801fd3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801fd5:	6a 00                	push   $0x0
  801fd7:	6a 00                	push   $0x0
  801fd9:	6a 00                	push   $0x0
  801fdb:	6a 00                	push   $0x0
  801fdd:	ff 75 08             	pushl  0x8(%ebp)
  801fe0:	6a 29                	push   $0x29
  801fe2:	e8 fd fa ff ff       	call   801ae4 <syscall>
  801fe7:	83 c4 18             	add    $0x18,%esp
	return ;
  801fea:	90                   	nop
}
  801feb:	c9                   	leave  
  801fec:	c3                   	ret    

00801fed <inctst>:

void inctst()
{
  801fed:	55                   	push   %ebp
  801fee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801ff0:	6a 00                	push   $0x0
  801ff2:	6a 00                	push   $0x0
  801ff4:	6a 00                	push   $0x0
  801ff6:	6a 00                	push   $0x0
  801ff8:	6a 00                	push   $0x0
  801ffa:	6a 2a                	push   $0x2a
  801ffc:	e8 e3 fa ff ff       	call   801ae4 <syscall>
  802001:	83 c4 18             	add    $0x18,%esp
	return ;
  802004:	90                   	nop
}
  802005:	c9                   	leave  
  802006:	c3                   	ret    

00802007 <gettst>:
uint32 gettst()
{
  802007:	55                   	push   %ebp
  802008:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80200a:	6a 00                	push   $0x0
  80200c:	6a 00                	push   $0x0
  80200e:	6a 00                	push   $0x0
  802010:	6a 00                	push   $0x0
  802012:	6a 00                	push   $0x0
  802014:	6a 2b                	push   $0x2b
  802016:	e8 c9 fa ff ff       	call   801ae4 <syscall>
  80201b:	83 c4 18             	add    $0x18,%esp
}
  80201e:	c9                   	leave  
  80201f:	c3                   	ret    

00802020 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802020:	55                   	push   %ebp
  802021:	89 e5                	mov    %esp,%ebp
  802023:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802026:	6a 00                	push   $0x0
  802028:	6a 00                	push   $0x0
  80202a:	6a 00                	push   $0x0
  80202c:	6a 00                	push   $0x0
  80202e:	6a 00                	push   $0x0
  802030:	6a 2c                	push   $0x2c
  802032:	e8 ad fa ff ff       	call   801ae4 <syscall>
  802037:	83 c4 18             	add    $0x18,%esp
  80203a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80203d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802041:	75 07                	jne    80204a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802043:	b8 01 00 00 00       	mov    $0x1,%eax
  802048:	eb 05                	jmp    80204f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80204a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80204f:	c9                   	leave  
  802050:	c3                   	ret    

00802051 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802051:	55                   	push   %ebp
  802052:	89 e5                	mov    %esp,%ebp
  802054:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802057:	6a 00                	push   $0x0
  802059:	6a 00                	push   $0x0
  80205b:	6a 00                	push   $0x0
  80205d:	6a 00                	push   $0x0
  80205f:	6a 00                	push   $0x0
  802061:	6a 2c                	push   $0x2c
  802063:	e8 7c fa ff ff       	call   801ae4 <syscall>
  802068:	83 c4 18             	add    $0x18,%esp
  80206b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80206e:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802072:	75 07                	jne    80207b <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802074:	b8 01 00 00 00       	mov    $0x1,%eax
  802079:	eb 05                	jmp    802080 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80207b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802080:	c9                   	leave  
  802081:	c3                   	ret    

00802082 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802082:	55                   	push   %ebp
  802083:	89 e5                	mov    %esp,%ebp
  802085:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802088:	6a 00                	push   $0x0
  80208a:	6a 00                	push   $0x0
  80208c:	6a 00                	push   $0x0
  80208e:	6a 00                	push   $0x0
  802090:	6a 00                	push   $0x0
  802092:	6a 2c                	push   $0x2c
  802094:	e8 4b fa ff ff       	call   801ae4 <syscall>
  802099:	83 c4 18             	add    $0x18,%esp
  80209c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80209f:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8020a3:	75 07                	jne    8020ac <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8020a5:	b8 01 00 00 00       	mov    $0x1,%eax
  8020aa:	eb 05                	jmp    8020b1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8020ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020b1:	c9                   	leave  
  8020b2:	c3                   	ret    

008020b3 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8020b3:	55                   	push   %ebp
  8020b4:	89 e5                	mov    %esp,%ebp
  8020b6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020b9:	6a 00                	push   $0x0
  8020bb:	6a 00                	push   $0x0
  8020bd:	6a 00                	push   $0x0
  8020bf:	6a 00                	push   $0x0
  8020c1:	6a 00                	push   $0x0
  8020c3:	6a 2c                	push   $0x2c
  8020c5:	e8 1a fa ff ff       	call   801ae4 <syscall>
  8020ca:	83 c4 18             	add    $0x18,%esp
  8020cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8020d0:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8020d4:	75 07                	jne    8020dd <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8020d6:	b8 01 00 00 00       	mov    $0x1,%eax
  8020db:	eb 05                	jmp    8020e2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8020dd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020e2:	c9                   	leave  
  8020e3:	c3                   	ret    

008020e4 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8020e4:	55                   	push   %ebp
  8020e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8020e7:	6a 00                	push   $0x0
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 00                	push   $0x0
  8020ef:	ff 75 08             	pushl  0x8(%ebp)
  8020f2:	6a 2d                	push   $0x2d
  8020f4:	e8 eb f9 ff ff       	call   801ae4 <syscall>
  8020f9:	83 c4 18             	add    $0x18,%esp
	return ;
  8020fc:	90                   	nop
}
  8020fd:	c9                   	leave  
  8020fe:	c3                   	ret    

008020ff <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8020ff:	55                   	push   %ebp
  802100:	89 e5                	mov    %esp,%ebp
  802102:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802103:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802106:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802109:	8b 55 0c             	mov    0xc(%ebp),%edx
  80210c:	8b 45 08             	mov    0x8(%ebp),%eax
  80210f:	6a 00                	push   $0x0
  802111:	53                   	push   %ebx
  802112:	51                   	push   %ecx
  802113:	52                   	push   %edx
  802114:	50                   	push   %eax
  802115:	6a 2e                	push   $0x2e
  802117:	e8 c8 f9 ff ff       	call   801ae4 <syscall>
  80211c:	83 c4 18             	add    $0x18,%esp
}
  80211f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802122:	c9                   	leave  
  802123:	c3                   	ret    

00802124 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802124:	55                   	push   %ebp
  802125:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802127:	8b 55 0c             	mov    0xc(%ebp),%edx
  80212a:	8b 45 08             	mov    0x8(%ebp),%eax
  80212d:	6a 00                	push   $0x0
  80212f:	6a 00                	push   $0x0
  802131:	6a 00                	push   $0x0
  802133:	52                   	push   %edx
  802134:	50                   	push   %eax
  802135:	6a 2f                	push   $0x2f
  802137:	e8 a8 f9 ff ff       	call   801ae4 <syscall>
  80213c:	83 c4 18             	add    $0x18,%esp
}
  80213f:	c9                   	leave  
  802140:	c3                   	ret    

00802141 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  802141:	55                   	push   %ebp
  802142:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  802144:	6a 00                	push   $0x0
  802146:	6a 00                	push   $0x0
  802148:	6a 00                	push   $0x0
  80214a:	ff 75 0c             	pushl  0xc(%ebp)
  80214d:	ff 75 08             	pushl  0x8(%ebp)
  802150:	6a 30                	push   $0x30
  802152:	e8 8d f9 ff ff       	call   801ae4 <syscall>
  802157:	83 c4 18             	add    $0x18,%esp
	return ;
  80215a:	90                   	nop
}
  80215b:	c9                   	leave  
  80215c:	c3                   	ret    
  80215d:	66 90                	xchg   %ax,%ax
  80215f:	90                   	nop

00802160 <__udivdi3>:
  802160:	55                   	push   %ebp
  802161:	57                   	push   %edi
  802162:	56                   	push   %esi
  802163:	53                   	push   %ebx
  802164:	83 ec 1c             	sub    $0x1c,%esp
  802167:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80216b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80216f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802173:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802177:	89 ca                	mov    %ecx,%edx
  802179:	89 f8                	mov    %edi,%eax
  80217b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80217f:	85 f6                	test   %esi,%esi
  802181:	75 2d                	jne    8021b0 <__udivdi3+0x50>
  802183:	39 cf                	cmp    %ecx,%edi
  802185:	77 65                	ja     8021ec <__udivdi3+0x8c>
  802187:	89 fd                	mov    %edi,%ebp
  802189:	85 ff                	test   %edi,%edi
  80218b:	75 0b                	jne    802198 <__udivdi3+0x38>
  80218d:	b8 01 00 00 00       	mov    $0x1,%eax
  802192:	31 d2                	xor    %edx,%edx
  802194:	f7 f7                	div    %edi
  802196:	89 c5                	mov    %eax,%ebp
  802198:	31 d2                	xor    %edx,%edx
  80219a:	89 c8                	mov    %ecx,%eax
  80219c:	f7 f5                	div    %ebp
  80219e:	89 c1                	mov    %eax,%ecx
  8021a0:	89 d8                	mov    %ebx,%eax
  8021a2:	f7 f5                	div    %ebp
  8021a4:	89 cf                	mov    %ecx,%edi
  8021a6:	89 fa                	mov    %edi,%edx
  8021a8:	83 c4 1c             	add    $0x1c,%esp
  8021ab:	5b                   	pop    %ebx
  8021ac:	5e                   	pop    %esi
  8021ad:	5f                   	pop    %edi
  8021ae:	5d                   	pop    %ebp
  8021af:	c3                   	ret    
  8021b0:	39 ce                	cmp    %ecx,%esi
  8021b2:	77 28                	ja     8021dc <__udivdi3+0x7c>
  8021b4:	0f bd fe             	bsr    %esi,%edi
  8021b7:	83 f7 1f             	xor    $0x1f,%edi
  8021ba:	75 40                	jne    8021fc <__udivdi3+0x9c>
  8021bc:	39 ce                	cmp    %ecx,%esi
  8021be:	72 0a                	jb     8021ca <__udivdi3+0x6a>
  8021c0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8021c4:	0f 87 9e 00 00 00    	ja     802268 <__udivdi3+0x108>
  8021ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8021cf:	89 fa                	mov    %edi,%edx
  8021d1:	83 c4 1c             	add    $0x1c,%esp
  8021d4:	5b                   	pop    %ebx
  8021d5:	5e                   	pop    %esi
  8021d6:	5f                   	pop    %edi
  8021d7:	5d                   	pop    %ebp
  8021d8:	c3                   	ret    
  8021d9:	8d 76 00             	lea    0x0(%esi),%esi
  8021dc:	31 ff                	xor    %edi,%edi
  8021de:	31 c0                	xor    %eax,%eax
  8021e0:	89 fa                	mov    %edi,%edx
  8021e2:	83 c4 1c             	add    $0x1c,%esp
  8021e5:	5b                   	pop    %ebx
  8021e6:	5e                   	pop    %esi
  8021e7:	5f                   	pop    %edi
  8021e8:	5d                   	pop    %ebp
  8021e9:	c3                   	ret    
  8021ea:	66 90                	xchg   %ax,%ax
  8021ec:	89 d8                	mov    %ebx,%eax
  8021ee:	f7 f7                	div    %edi
  8021f0:	31 ff                	xor    %edi,%edi
  8021f2:	89 fa                	mov    %edi,%edx
  8021f4:	83 c4 1c             	add    $0x1c,%esp
  8021f7:	5b                   	pop    %ebx
  8021f8:	5e                   	pop    %esi
  8021f9:	5f                   	pop    %edi
  8021fa:	5d                   	pop    %ebp
  8021fb:	c3                   	ret    
  8021fc:	bd 20 00 00 00       	mov    $0x20,%ebp
  802201:	89 eb                	mov    %ebp,%ebx
  802203:	29 fb                	sub    %edi,%ebx
  802205:	89 f9                	mov    %edi,%ecx
  802207:	d3 e6                	shl    %cl,%esi
  802209:	89 c5                	mov    %eax,%ebp
  80220b:	88 d9                	mov    %bl,%cl
  80220d:	d3 ed                	shr    %cl,%ebp
  80220f:	89 e9                	mov    %ebp,%ecx
  802211:	09 f1                	or     %esi,%ecx
  802213:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802217:	89 f9                	mov    %edi,%ecx
  802219:	d3 e0                	shl    %cl,%eax
  80221b:	89 c5                	mov    %eax,%ebp
  80221d:	89 d6                	mov    %edx,%esi
  80221f:	88 d9                	mov    %bl,%cl
  802221:	d3 ee                	shr    %cl,%esi
  802223:	89 f9                	mov    %edi,%ecx
  802225:	d3 e2                	shl    %cl,%edx
  802227:	8b 44 24 08          	mov    0x8(%esp),%eax
  80222b:	88 d9                	mov    %bl,%cl
  80222d:	d3 e8                	shr    %cl,%eax
  80222f:	09 c2                	or     %eax,%edx
  802231:	89 d0                	mov    %edx,%eax
  802233:	89 f2                	mov    %esi,%edx
  802235:	f7 74 24 0c          	divl   0xc(%esp)
  802239:	89 d6                	mov    %edx,%esi
  80223b:	89 c3                	mov    %eax,%ebx
  80223d:	f7 e5                	mul    %ebp
  80223f:	39 d6                	cmp    %edx,%esi
  802241:	72 19                	jb     80225c <__udivdi3+0xfc>
  802243:	74 0b                	je     802250 <__udivdi3+0xf0>
  802245:	89 d8                	mov    %ebx,%eax
  802247:	31 ff                	xor    %edi,%edi
  802249:	e9 58 ff ff ff       	jmp    8021a6 <__udivdi3+0x46>
  80224e:	66 90                	xchg   %ax,%ax
  802250:	8b 54 24 08          	mov    0x8(%esp),%edx
  802254:	89 f9                	mov    %edi,%ecx
  802256:	d3 e2                	shl    %cl,%edx
  802258:	39 c2                	cmp    %eax,%edx
  80225a:	73 e9                	jae    802245 <__udivdi3+0xe5>
  80225c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80225f:	31 ff                	xor    %edi,%edi
  802261:	e9 40 ff ff ff       	jmp    8021a6 <__udivdi3+0x46>
  802266:	66 90                	xchg   %ax,%ax
  802268:	31 c0                	xor    %eax,%eax
  80226a:	e9 37 ff ff ff       	jmp    8021a6 <__udivdi3+0x46>
  80226f:	90                   	nop

00802270 <__umoddi3>:
  802270:	55                   	push   %ebp
  802271:	57                   	push   %edi
  802272:	56                   	push   %esi
  802273:	53                   	push   %ebx
  802274:	83 ec 1c             	sub    $0x1c,%esp
  802277:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80227b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80227f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802283:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802287:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80228b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80228f:	89 f3                	mov    %esi,%ebx
  802291:	89 fa                	mov    %edi,%edx
  802293:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802297:	89 34 24             	mov    %esi,(%esp)
  80229a:	85 c0                	test   %eax,%eax
  80229c:	75 1a                	jne    8022b8 <__umoddi3+0x48>
  80229e:	39 f7                	cmp    %esi,%edi
  8022a0:	0f 86 a2 00 00 00    	jbe    802348 <__umoddi3+0xd8>
  8022a6:	89 c8                	mov    %ecx,%eax
  8022a8:	89 f2                	mov    %esi,%edx
  8022aa:	f7 f7                	div    %edi
  8022ac:	89 d0                	mov    %edx,%eax
  8022ae:	31 d2                	xor    %edx,%edx
  8022b0:	83 c4 1c             	add    $0x1c,%esp
  8022b3:	5b                   	pop    %ebx
  8022b4:	5e                   	pop    %esi
  8022b5:	5f                   	pop    %edi
  8022b6:	5d                   	pop    %ebp
  8022b7:	c3                   	ret    
  8022b8:	39 f0                	cmp    %esi,%eax
  8022ba:	0f 87 ac 00 00 00    	ja     80236c <__umoddi3+0xfc>
  8022c0:	0f bd e8             	bsr    %eax,%ebp
  8022c3:	83 f5 1f             	xor    $0x1f,%ebp
  8022c6:	0f 84 ac 00 00 00    	je     802378 <__umoddi3+0x108>
  8022cc:	bf 20 00 00 00       	mov    $0x20,%edi
  8022d1:	29 ef                	sub    %ebp,%edi
  8022d3:	89 fe                	mov    %edi,%esi
  8022d5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8022d9:	89 e9                	mov    %ebp,%ecx
  8022db:	d3 e0                	shl    %cl,%eax
  8022dd:	89 d7                	mov    %edx,%edi
  8022df:	89 f1                	mov    %esi,%ecx
  8022e1:	d3 ef                	shr    %cl,%edi
  8022e3:	09 c7                	or     %eax,%edi
  8022e5:	89 e9                	mov    %ebp,%ecx
  8022e7:	d3 e2                	shl    %cl,%edx
  8022e9:	89 14 24             	mov    %edx,(%esp)
  8022ec:	89 d8                	mov    %ebx,%eax
  8022ee:	d3 e0                	shl    %cl,%eax
  8022f0:	89 c2                	mov    %eax,%edx
  8022f2:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022f6:	d3 e0                	shl    %cl,%eax
  8022f8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8022fc:	8b 44 24 08          	mov    0x8(%esp),%eax
  802300:	89 f1                	mov    %esi,%ecx
  802302:	d3 e8                	shr    %cl,%eax
  802304:	09 d0                	or     %edx,%eax
  802306:	d3 eb                	shr    %cl,%ebx
  802308:	89 da                	mov    %ebx,%edx
  80230a:	f7 f7                	div    %edi
  80230c:	89 d3                	mov    %edx,%ebx
  80230e:	f7 24 24             	mull   (%esp)
  802311:	89 c6                	mov    %eax,%esi
  802313:	89 d1                	mov    %edx,%ecx
  802315:	39 d3                	cmp    %edx,%ebx
  802317:	0f 82 87 00 00 00    	jb     8023a4 <__umoddi3+0x134>
  80231d:	0f 84 91 00 00 00    	je     8023b4 <__umoddi3+0x144>
  802323:	8b 54 24 04          	mov    0x4(%esp),%edx
  802327:	29 f2                	sub    %esi,%edx
  802329:	19 cb                	sbb    %ecx,%ebx
  80232b:	89 d8                	mov    %ebx,%eax
  80232d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802331:	d3 e0                	shl    %cl,%eax
  802333:	89 e9                	mov    %ebp,%ecx
  802335:	d3 ea                	shr    %cl,%edx
  802337:	09 d0                	or     %edx,%eax
  802339:	89 e9                	mov    %ebp,%ecx
  80233b:	d3 eb                	shr    %cl,%ebx
  80233d:	89 da                	mov    %ebx,%edx
  80233f:	83 c4 1c             	add    $0x1c,%esp
  802342:	5b                   	pop    %ebx
  802343:	5e                   	pop    %esi
  802344:	5f                   	pop    %edi
  802345:	5d                   	pop    %ebp
  802346:	c3                   	ret    
  802347:	90                   	nop
  802348:	89 fd                	mov    %edi,%ebp
  80234a:	85 ff                	test   %edi,%edi
  80234c:	75 0b                	jne    802359 <__umoddi3+0xe9>
  80234e:	b8 01 00 00 00       	mov    $0x1,%eax
  802353:	31 d2                	xor    %edx,%edx
  802355:	f7 f7                	div    %edi
  802357:	89 c5                	mov    %eax,%ebp
  802359:	89 f0                	mov    %esi,%eax
  80235b:	31 d2                	xor    %edx,%edx
  80235d:	f7 f5                	div    %ebp
  80235f:	89 c8                	mov    %ecx,%eax
  802361:	f7 f5                	div    %ebp
  802363:	89 d0                	mov    %edx,%eax
  802365:	e9 44 ff ff ff       	jmp    8022ae <__umoddi3+0x3e>
  80236a:	66 90                	xchg   %ax,%ax
  80236c:	89 c8                	mov    %ecx,%eax
  80236e:	89 f2                	mov    %esi,%edx
  802370:	83 c4 1c             	add    $0x1c,%esp
  802373:	5b                   	pop    %ebx
  802374:	5e                   	pop    %esi
  802375:	5f                   	pop    %edi
  802376:	5d                   	pop    %ebp
  802377:	c3                   	ret    
  802378:	3b 04 24             	cmp    (%esp),%eax
  80237b:	72 06                	jb     802383 <__umoddi3+0x113>
  80237d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802381:	77 0f                	ja     802392 <__umoddi3+0x122>
  802383:	89 f2                	mov    %esi,%edx
  802385:	29 f9                	sub    %edi,%ecx
  802387:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80238b:	89 14 24             	mov    %edx,(%esp)
  80238e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802392:	8b 44 24 04          	mov    0x4(%esp),%eax
  802396:	8b 14 24             	mov    (%esp),%edx
  802399:	83 c4 1c             	add    $0x1c,%esp
  80239c:	5b                   	pop    %ebx
  80239d:	5e                   	pop    %esi
  80239e:	5f                   	pop    %edi
  80239f:	5d                   	pop    %ebp
  8023a0:	c3                   	ret    
  8023a1:	8d 76 00             	lea    0x0(%esi),%esi
  8023a4:	2b 04 24             	sub    (%esp),%eax
  8023a7:	19 fa                	sbb    %edi,%edx
  8023a9:	89 d1                	mov    %edx,%ecx
  8023ab:	89 c6                	mov    %eax,%esi
  8023ad:	e9 71 ff ff ff       	jmp    802323 <__umoddi3+0xb3>
  8023b2:	66 90                	xchg   %ax,%ax
  8023b4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8023b8:	72 ea                	jb     8023a4 <__umoddi3+0x134>
  8023ba:	89 d9                	mov    %ebx,%ecx
  8023bc:	e9 62 ff ff ff       	jmp    802323 <__umoddi3+0xb3>
