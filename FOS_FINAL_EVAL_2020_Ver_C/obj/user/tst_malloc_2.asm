
obj/user/tst_malloc_2:     file format elf32-i386


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
  800031:	e8 70 03 00 00       	call   8003a6 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
	char a;
	short b;
	int c;
};
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	81 ec 94 00 00 00    	sub    $0x94,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800042:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800046:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004d:	eb 2a                	jmp    800079 <_main+0x41>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004f:	a1 20 30 80 00       	mov    0x803020,%eax
  800054:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  80005a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005d:	89 d0                	mov    %edx,%eax
  80005f:	c1 e0 02             	shl    $0x2,%eax
  800062:	01 d0                	add    %edx,%eax
  800064:	c1 e0 02             	shl    $0x2,%eax
  800067:	01 c8                	add    %ecx,%eax
  800069:	8a 40 04             	mov    0x4(%eax),%al
  80006c:	84 c0                	test   %al,%al
  80006e:	74 06                	je     800076 <_main+0x3e>
			{
				fullWS = 0;
  800070:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800074:	eb 12                	jmp    800088 <_main+0x50>
void _main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800076:	ff 45 f0             	incl   -0x10(%ebp)
  800079:	a1 20 30 80 00       	mov    0x803020,%eax
  80007e:	8b 50 74             	mov    0x74(%eax),%edx
  800081:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800084:	39 c2                	cmp    %eax,%edx
  800086:	77 c7                	ja     80004f <_main+0x17>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800088:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  80008c:	74 14                	je     8000a2 <_main+0x6a>
  80008e:	83 ec 04             	sub    $0x4,%esp
  800091:	68 00 22 80 00       	push   $0x802200
  800096:	6a 1a                	push   $0x1a
  800098:	68 1c 22 80 00       	push   $0x80221c
  80009d:	e8 2c 04 00 00       	call   8004ce <_panic>
	}


	int Mega = 1024*1024;
  8000a2:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000a9:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)
	char minByte = 1<<7;
  8000b0:	c6 45 e7 80          	movb   $0x80,-0x19(%ebp)
	char maxByte = 0x7F;
  8000b4:	c6 45 e6 7f          	movb   $0x7f,-0x1a(%ebp)
	short minShort = 1<<15 ;
  8000b8:	66 c7 45 e4 00 80    	movw   $0x8000,-0x1c(%ebp)
	short maxShort = 0x7FFF;
  8000be:	66 c7 45 e2 ff 7f    	movw   $0x7fff,-0x1e(%ebp)
	int minInt = 1<<31 ;
  8000c4:	c7 45 dc 00 00 00 80 	movl   $0x80000000,-0x24(%ebp)
	int maxInt = 0x7FFFFFFF;
  8000cb:	c7 45 d8 ff ff ff 7f 	movl   $0x7fffffff,-0x28(%ebp)

	void* ptr_allocations[20] = {0};
  8000d2:	8d 95 68 ff ff ff    	lea    -0x98(%ebp),%edx
  8000d8:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000dd:	b8 00 00 00 00       	mov    $0x0,%eax
  8000e2:	89 d7                	mov    %edx,%edi
  8000e4:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000e9:	01 c0                	add    %eax,%eax
  8000eb:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000ee:	83 ec 0c             	sub    $0xc,%esp
  8000f1:	50                   	push   %eax
  8000f2:	e8 18 14 00 00       	call   80150f <malloc>
  8000f7:	83 c4 10             	add    $0x10,%esp
  8000fa:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
		char *byteArr = (char *) ptr_allocations[0];
  800100:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800106:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		int lastIndexOfByte = (2*Mega-kilo)/sizeof(char) - 1;
  800109:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80010c:	01 c0                	add    %eax,%eax
  80010e:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800111:	48                   	dec    %eax
  800112:	89 45 d0             	mov    %eax,-0x30(%ebp)
		byteArr[0] = minByte ;
  800115:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800118:	8a 55 e7             	mov    -0x19(%ebp),%dl
  80011b:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte ;
  80011d:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800120:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800123:	01 c2                	add    %eax,%edx
  800125:	8a 45 e6             	mov    -0x1a(%ebp),%al
  800128:	88 02                	mov    %al,(%edx)

		ptr_allocations[1] = malloc(2*Mega-kilo);
  80012a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80012d:	01 c0                	add    %eax,%eax
  80012f:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800132:	83 ec 0c             	sub    $0xc,%esp
  800135:	50                   	push   %eax
  800136:	e8 d4 13 00 00       	call   80150f <malloc>
  80013b:	83 c4 10             	add    $0x10,%esp
  80013e:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
		short *shortArr = (short *) ptr_allocations[1];
  800144:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80014a:	89 45 cc             	mov    %eax,-0x34(%ebp)
		int lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  80014d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800150:	01 c0                	add    %eax,%eax
  800152:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800155:	d1 e8                	shr    %eax
  800157:	48                   	dec    %eax
  800158:	89 45 c8             	mov    %eax,-0x38(%ebp)
		shortArr[0] = minShort;
  80015b:	8b 55 cc             	mov    -0x34(%ebp),%edx
  80015e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800161:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  800164:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800167:	01 c0                	add    %eax,%eax
  800169:	89 c2                	mov    %eax,%edx
  80016b:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80016e:	01 c2                	add    %eax,%edx
  800170:	66 8b 45 e2          	mov    -0x1e(%ebp),%ax
  800174:	66 89 02             	mov    %ax,(%edx)

		ptr_allocations[2] = malloc(2*kilo);
  800177:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80017a:	01 c0                	add    %eax,%eax
  80017c:	83 ec 0c             	sub    $0xc,%esp
  80017f:	50                   	push   %eax
  800180:	e8 8a 13 00 00       	call   80150f <malloc>
  800185:	83 c4 10             	add    $0x10,%esp
  800188:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		int *intArr = (int *) ptr_allocations[2];
  80018e:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800194:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		int lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
  800197:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80019a:	01 c0                	add    %eax,%eax
  80019c:	c1 e8 02             	shr    $0x2,%eax
  80019f:	48                   	dec    %eax
  8001a0:	89 45 c0             	mov    %eax,-0x40(%ebp)
		intArr[0] = minInt;
  8001a3:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001a6:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8001a9:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  8001ab:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001ae:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001b5:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001b8:	01 c2                	add    %eax,%edx
  8001ba:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001bd:	89 02                	mov    %eax,(%edx)

		ptr_allocations[3] = malloc(7*kilo);
  8001bf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8001c2:	89 d0                	mov    %edx,%eax
  8001c4:	01 c0                	add    %eax,%eax
  8001c6:	01 d0                	add    %edx,%eax
  8001c8:	01 c0                	add    %eax,%eax
  8001ca:	01 d0                	add    %edx,%eax
  8001cc:	83 ec 0c             	sub    $0xc,%esp
  8001cf:	50                   	push   %eax
  8001d0:	e8 3a 13 00 00       	call   80150f <malloc>
  8001d5:	83 c4 10             	add    $0x10,%esp
  8001d8:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
		struct MyStruct *structArr = (struct MyStruct *) ptr_allocations[3];
  8001de:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8001e4:	89 45 bc             	mov    %eax,-0x44(%ebp)
		int lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  8001e7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8001ea:	89 d0                	mov    %edx,%eax
  8001ec:	01 c0                	add    %eax,%eax
  8001ee:	01 d0                	add    %edx,%eax
  8001f0:	01 c0                	add    %eax,%eax
  8001f2:	01 d0                	add    %edx,%eax
  8001f4:	c1 e8 03             	shr    $0x3,%eax
  8001f7:	48                   	dec    %eax
  8001f8:	89 45 b8             	mov    %eax,-0x48(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  8001fb:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8001fe:	8a 55 e7             	mov    -0x19(%ebp),%dl
  800201:	88 10                	mov    %dl,(%eax)
  800203:	8b 55 bc             	mov    -0x44(%ebp),%edx
  800206:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800209:	66 89 42 02          	mov    %ax,0x2(%edx)
  80020d:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800210:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800213:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  800216:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800219:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800220:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800223:	01 c2                	add    %eax,%edx
  800225:	8a 45 e6             	mov    -0x1a(%ebp),%al
  800228:	88 02                	mov    %al,(%edx)
  80022a:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80022d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800234:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800237:	01 c2                	add    %eax,%edx
  800239:	66 8b 45 e2          	mov    -0x1e(%ebp),%ax
  80023d:	66 89 42 02          	mov    %ax,0x2(%edx)
  800241:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800244:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80024b:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80024e:	01 c2                	add    %eax,%edx
  800250:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800253:	89 42 04             	mov    %eax,0x4(%edx)

		//Check that the values are successfully stored
		if (byteArr[0] 	!= minByte 	|| byteArr[lastIndexOfByte] 	!= maxByte) panic("Wrong allocation: stored values are wrongly changed!");
  800256:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800259:	8a 00                	mov    (%eax),%al
  80025b:	3a 45 e7             	cmp    -0x19(%ebp),%al
  80025e:	75 0f                	jne    80026f <_main+0x237>
  800260:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800263:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800266:	01 d0                	add    %edx,%eax
  800268:	8a 00                	mov    (%eax),%al
  80026a:	3a 45 e6             	cmp    -0x1a(%ebp),%al
  80026d:	74 14                	je     800283 <_main+0x24b>
  80026f:	83 ec 04             	sub    $0x4,%esp
  800272:	68 30 22 80 00       	push   $0x802230
  800277:	6a 42                	push   $0x42
  800279:	68 1c 22 80 00       	push   $0x80221c
  80027e:	e8 4b 02 00 00       	call   8004ce <_panic>
		if (shortArr[0] != minShort || shortArr[lastIndexOfShort] 	!= maxShort) panic("Wrong allocation: stored values are wrongly changed!");
  800283:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800286:	66 8b 00             	mov    (%eax),%ax
  800289:	66 3b 45 e4          	cmp    -0x1c(%ebp),%ax
  80028d:	75 15                	jne    8002a4 <_main+0x26c>
  80028f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800292:	01 c0                	add    %eax,%eax
  800294:	89 c2                	mov    %eax,%edx
  800296:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800299:	01 d0                	add    %edx,%eax
  80029b:	66 8b 00             	mov    (%eax),%ax
  80029e:	66 3b 45 e2          	cmp    -0x1e(%ebp),%ax
  8002a2:	74 14                	je     8002b8 <_main+0x280>
  8002a4:	83 ec 04             	sub    $0x4,%esp
  8002a7:	68 30 22 80 00       	push   $0x802230
  8002ac:	6a 43                	push   $0x43
  8002ae:	68 1c 22 80 00       	push   $0x80221c
  8002b3:	e8 16 02 00 00       	call   8004ce <_panic>
		if (intArr[0] 	!= minInt 	|| intArr[lastIndexOfInt] 		!= maxInt) panic("Wrong allocation: stored values are wrongly changed!");
  8002b8:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8002bb:	8b 00                	mov    (%eax),%eax
  8002bd:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8002c0:	75 16                	jne    8002d8 <_main+0x2a0>
  8002c2:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8002c5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002cc:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8002cf:	01 d0                	add    %edx,%eax
  8002d1:	8b 00                	mov    (%eax),%eax
  8002d3:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  8002d6:	74 14                	je     8002ec <_main+0x2b4>
  8002d8:	83 ec 04             	sub    $0x4,%esp
  8002db:	68 30 22 80 00       	push   $0x802230
  8002e0:	6a 44                	push   $0x44
  8002e2:	68 1c 22 80 00       	push   $0x80221c
  8002e7:	e8 e2 01 00 00       	call   8004ce <_panic>

		if (structArr[0].a != minByte 	|| structArr[lastIndexOfStruct].a != maxByte) 	panic("Wrong allocation: stored values are wrongly changed!");
  8002ec:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8002ef:	8a 00                	mov    (%eax),%al
  8002f1:	3a 45 e7             	cmp    -0x19(%ebp),%al
  8002f4:	75 16                	jne    80030c <_main+0x2d4>
  8002f6:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8002f9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800300:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800303:	01 d0                	add    %edx,%eax
  800305:	8a 00                	mov    (%eax),%al
  800307:	3a 45 e6             	cmp    -0x1a(%ebp),%al
  80030a:	74 14                	je     800320 <_main+0x2e8>
  80030c:	83 ec 04             	sub    $0x4,%esp
  80030f:	68 30 22 80 00       	push   $0x802230
  800314:	6a 46                	push   $0x46
  800316:	68 1c 22 80 00       	push   $0x80221c
  80031b:	e8 ae 01 00 00       	call   8004ce <_panic>
		if (structArr[0].b != minShort 	|| structArr[lastIndexOfStruct].b != maxShort) 	panic("Wrong allocation: stored values are wrongly changed!");
  800320:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800323:	66 8b 40 02          	mov    0x2(%eax),%ax
  800327:	66 3b 45 e4          	cmp    -0x1c(%ebp),%ax
  80032b:	75 19                	jne    800346 <_main+0x30e>
  80032d:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800330:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800337:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80033a:	01 d0                	add    %edx,%eax
  80033c:	66 8b 40 02          	mov    0x2(%eax),%ax
  800340:	66 3b 45 e2          	cmp    -0x1e(%ebp),%ax
  800344:	74 14                	je     80035a <_main+0x322>
  800346:	83 ec 04             	sub    $0x4,%esp
  800349:	68 30 22 80 00       	push   $0x802230
  80034e:	6a 47                	push   $0x47
  800350:	68 1c 22 80 00       	push   $0x80221c
  800355:	e8 74 01 00 00       	call   8004ce <_panic>
		if (structArr[0].c != minInt 	|| structArr[lastIndexOfStruct].c != maxInt) 	panic("Wrong allocation: stored values are wrongly changed!");
  80035a:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80035d:	8b 40 04             	mov    0x4(%eax),%eax
  800360:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800363:	75 17                	jne    80037c <_main+0x344>
  800365:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800368:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80036f:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800372:	01 d0                	add    %edx,%eax
  800374:	8b 40 04             	mov    0x4(%eax),%eax
  800377:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  80037a:	74 14                	je     800390 <_main+0x358>
  80037c:	83 ec 04             	sub    $0x4,%esp
  80037f:	68 30 22 80 00       	push   $0x802230
  800384:	6a 48                	push   $0x48
  800386:	68 1c 22 80 00       	push   $0x80221c
  80038b:	e8 3e 01 00 00       	call   8004ce <_panic>


	}

	cprintf("Congratulations!! test malloc (2) completed successfully.\n");
  800390:	83 ec 0c             	sub    $0xc,%esp
  800393:	68 68 22 80 00       	push   $0x802268
  800398:	e8 e8 03 00 00       	call   800785 <cprintf>
  80039d:	83 c4 10             	add    $0x10,%esp

	return;
  8003a0:	90                   	nop
}
  8003a1:	8b 7d fc             	mov    -0x4(%ebp),%edi
  8003a4:	c9                   	leave  
  8003a5:	c3                   	ret    

008003a6 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8003a6:	55                   	push   %ebp
  8003a7:	89 e5                	mov    %esp,%ebp
  8003a9:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8003ac:	e8 09 16 00 00       	call   8019ba <sys_getenvindex>
  8003b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8003b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003b7:	89 d0                	mov    %edx,%eax
  8003b9:	01 c0                	add    %eax,%eax
  8003bb:	01 d0                	add    %edx,%eax
  8003bd:	c1 e0 07             	shl    $0x7,%eax
  8003c0:	29 d0                	sub    %edx,%eax
  8003c2:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003c9:	01 c8                	add    %ecx,%eax
  8003cb:	01 c0                	add    %eax,%eax
  8003cd:	01 d0                	add    %edx,%eax
  8003cf:	01 c0                	add    %eax,%eax
  8003d1:	01 d0                	add    %edx,%eax
  8003d3:	c1 e0 03             	shl    $0x3,%eax
  8003d6:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8003db:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8003e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e5:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  8003eb:	84 c0                	test   %al,%al
  8003ed:	74 0f                	je     8003fe <libmain+0x58>
		binaryname = myEnv->prog_name;
  8003ef:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f4:	05 f0 ee 00 00       	add    $0xeef0,%eax
  8003f9:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8003fe:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800402:	7e 0a                	jle    80040e <libmain+0x68>
		binaryname = argv[0];
  800404:	8b 45 0c             	mov    0xc(%ebp),%eax
  800407:	8b 00                	mov    (%eax),%eax
  800409:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80040e:	83 ec 08             	sub    $0x8,%esp
  800411:	ff 75 0c             	pushl  0xc(%ebp)
  800414:	ff 75 08             	pushl  0x8(%ebp)
  800417:	e8 1c fc ff ff       	call   800038 <_main>
  80041c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80041f:	e8 31 17 00 00       	call   801b55 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800424:	83 ec 0c             	sub    $0xc,%esp
  800427:	68 bc 22 80 00       	push   $0x8022bc
  80042c:	e8 54 03 00 00       	call   800785 <cprintf>
  800431:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800434:	a1 20 30 80 00       	mov    0x803020,%eax
  800439:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  80043f:	a1 20 30 80 00       	mov    0x803020,%eax
  800444:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  80044a:	83 ec 04             	sub    $0x4,%esp
  80044d:	52                   	push   %edx
  80044e:	50                   	push   %eax
  80044f:	68 e4 22 80 00       	push   $0x8022e4
  800454:	e8 2c 03 00 00       	call   800785 <cprintf>
  800459:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80045c:	a1 20 30 80 00       	mov    0x803020,%eax
  800461:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  800467:	a1 20 30 80 00       	mov    0x803020,%eax
  80046c:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  800472:	a1 20 30 80 00       	mov    0x803020,%eax
  800477:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  80047d:	51                   	push   %ecx
  80047e:	52                   	push   %edx
  80047f:	50                   	push   %eax
  800480:	68 0c 23 80 00       	push   $0x80230c
  800485:	e8 fb 02 00 00       	call   800785 <cprintf>
  80048a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80048d:	83 ec 0c             	sub    $0xc,%esp
  800490:	68 bc 22 80 00       	push   $0x8022bc
  800495:	e8 eb 02 00 00       	call   800785 <cprintf>
  80049a:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80049d:	e8 cd 16 00 00       	call   801b6f <sys_enable_interrupt>

	// exit gracefully
	exit();
  8004a2:	e8 19 00 00 00       	call   8004c0 <exit>
}
  8004a7:	90                   	nop
  8004a8:	c9                   	leave  
  8004a9:	c3                   	ret    

008004aa <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004aa:	55                   	push   %ebp
  8004ab:	89 e5                	mov    %esp,%ebp
  8004ad:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8004b0:	83 ec 0c             	sub    $0xc,%esp
  8004b3:	6a 00                	push   $0x0
  8004b5:	e8 cc 14 00 00       	call   801986 <sys_env_destroy>
  8004ba:	83 c4 10             	add    $0x10,%esp
}
  8004bd:	90                   	nop
  8004be:	c9                   	leave  
  8004bf:	c3                   	ret    

008004c0 <exit>:

void
exit(void)
{
  8004c0:	55                   	push   %ebp
  8004c1:	89 e5                	mov    %esp,%ebp
  8004c3:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8004c6:	e8 21 15 00 00       	call   8019ec <sys_env_exit>
}
  8004cb:	90                   	nop
  8004cc:	c9                   	leave  
  8004cd:	c3                   	ret    

008004ce <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8004ce:	55                   	push   %ebp
  8004cf:	89 e5                	mov    %esp,%ebp
  8004d1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8004d4:	8d 45 10             	lea    0x10(%ebp),%eax
  8004d7:	83 c0 04             	add    $0x4,%eax
  8004da:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8004dd:	a1 18 31 80 00       	mov    0x803118,%eax
  8004e2:	85 c0                	test   %eax,%eax
  8004e4:	74 16                	je     8004fc <_panic+0x2e>
		cprintf("%s: ", argv0);
  8004e6:	a1 18 31 80 00       	mov    0x803118,%eax
  8004eb:	83 ec 08             	sub    $0x8,%esp
  8004ee:	50                   	push   %eax
  8004ef:	68 64 23 80 00       	push   $0x802364
  8004f4:	e8 8c 02 00 00       	call   800785 <cprintf>
  8004f9:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8004fc:	a1 00 30 80 00       	mov    0x803000,%eax
  800501:	ff 75 0c             	pushl  0xc(%ebp)
  800504:	ff 75 08             	pushl  0x8(%ebp)
  800507:	50                   	push   %eax
  800508:	68 69 23 80 00       	push   $0x802369
  80050d:	e8 73 02 00 00       	call   800785 <cprintf>
  800512:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800515:	8b 45 10             	mov    0x10(%ebp),%eax
  800518:	83 ec 08             	sub    $0x8,%esp
  80051b:	ff 75 f4             	pushl  -0xc(%ebp)
  80051e:	50                   	push   %eax
  80051f:	e8 f6 01 00 00       	call   80071a <vcprintf>
  800524:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800527:	83 ec 08             	sub    $0x8,%esp
  80052a:	6a 00                	push   $0x0
  80052c:	68 85 23 80 00       	push   $0x802385
  800531:	e8 e4 01 00 00       	call   80071a <vcprintf>
  800536:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800539:	e8 82 ff ff ff       	call   8004c0 <exit>

	// should not return here
	while (1) ;
  80053e:	eb fe                	jmp    80053e <_panic+0x70>

00800540 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800540:	55                   	push   %ebp
  800541:	89 e5                	mov    %esp,%ebp
  800543:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800546:	a1 20 30 80 00       	mov    0x803020,%eax
  80054b:	8b 50 74             	mov    0x74(%eax),%edx
  80054e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800551:	39 c2                	cmp    %eax,%edx
  800553:	74 14                	je     800569 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800555:	83 ec 04             	sub    $0x4,%esp
  800558:	68 88 23 80 00       	push   $0x802388
  80055d:	6a 26                	push   $0x26
  80055f:	68 d4 23 80 00       	push   $0x8023d4
  800564:	e8 65 ff ff ff       	call   8004ce <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800569:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800570:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800577:	e9 c4 00 00 00       	jmp    800640 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  80057c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80057f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800586:	8b 45 08             	mov    0x8(%ebp),%eax
  800589:	01 d0                	add    %edx,%eax
  80058b:	8b 00                	mov    (%eax),%eax
  80058d:	85 c0                	test   %eax,%eax
  80058f:	75 08                	jne    800599 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800591:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800594:	e9 a4 00 00 00       	jmp    80063d <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  800599:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005a0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005a7:	eb 6b                	jmp    800614 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8005a9:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ae:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8005b4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005b7:	89 d0                	mov    %edx,%eax
  8005b9:	c1 e0 02             	shl    $0x2,%eax
  8005bc:	01 d0                	add    %edx,%eax
  8005be:	c1 e0 02             	shl    $0x2,%eax
  8005c1:	01 c8                	add    %ecx,%eax
  8005c3:	8a 40 04             	mov    0x4(%eax),%al
  8005c6:	84 c0                	test   %al,%al
  8005c8:	75 47                	jne    800611 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8005cf:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  8005d5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005d8:	89 d0                	mov    %edx,%eax
  8005da:	c1 e0 02             	shl    $0x2,%eax
  8005dd:	01 d0                	add    %edx,%eax
  8005df:	c1 e0 02             	shl    $0x2,%eax
  8005e2:	01 c8                	add    %ecx,%eax
  8005e4:	8b 00                	mov    (%eax),%eax
  8005e6:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8005e9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005ec:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005f1:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8005f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005f6:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800600:	01 c8                	add    %ecx,%eax
  800602:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800604:	39 c2                	cmp    %eax,%edx
  800606:	75 09                	jne    800611 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800608:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80060f:	eb 12                	jmp    800623 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800611:	ff 45 e8             	incl   -0x18(%ebp)
  800614:	a1 20 30 80 00       	mov    0x803020,%eax
  800619:	8b 50 74             	mov    0x74(%eax),%edx
  80061c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80061f:	39 c2                	cmp    %eax,%edx
  800621:	77 86                	ja     8005a9 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800623:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800627:	75 14                	jne    80063d <CheckWSWithoutLastIndex+0xfd>
			panic(
  800629:	83 ec 04             	sub    $0x4,%esp
  80062c:	68 e0 23 80 00       	push   $0x8023e0
  800631:	6a 3a                	push   $0x3a
  800633:	68 d4 23 80 00       	push   $0x8023d4
  800638:	e8 91 fe ff ff       	call   8004ce <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80063d:	ff 45 f0             	incl   -0x10(%ebp)
  800640:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800643:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800646:	0f 8c 30 ff ff ff    	jl     80057c <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80064c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800653:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80065a:	eb 27                	jmp    800683 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80065c:	a1 20 30 80 00       	mov    0x803020,%eax
  800661:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800667:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80066a:	89 d0                	mov    %edx,%eax
  80066c:	c1 e0 02             	shl    $0x2,%eax
  80066f:	01 d0                	add    %edx,%eax
  800671:	c1 e0 02             	shl    $0x2,%eax
  800674:	01 c8                	add    %ecx,%eax
  800676:	8a 40 04             	mov    0x4(%eax),%al
  800679:	3c 01                	cmp    $0x1,%al
  80067b:	75 03                	jne    800680 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  80067d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800680:	ff 45 e0             	incl   -0x20(%ebp)
  800683:	a1 20 30 80 00       	mov    0x803020,%eax
  800688:	8b 50 74             	mov    0x74(%eax),%edx
  80068b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80068e:	39 c2                	cmp    %eax,%edx
  800690:	77 ca                	ja     80065c <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800692:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800695:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800698:	74 14                	je     8006ae <CheckWSWithoutLastIndex+0x16e>
		panic(
  80069a:	83 ec 04             	sub    $0x4,%esp
  80069d:	68 34 24 80 00       	push   $0x802434
  8006a2:	6a 44                	push   $0x44
  8006a4:	68 d4 23 80 00       	push   $0x8023d4
  8006a9:	e8 20 fe ff ff       	call   8004ce <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8006ae:	90                   	nop
  8006af:	c9                   	leave  
  8006b0:	c3                   	ret    

008006b1 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8006b1:	55                   	push   %ebp
  8006b2:	89 e5                	mov    %esp,%ebp
  8006b4:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8006b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006ba:	8b 00                	mov    (%eax),%eax
  8006bc:	8d 48 01             	lea    0x1(%eax),%ecx
  8006bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006c2:	89 0a                	mov    %ecx,(%edx)
  8006c4:	8b 55 08             	mov    0x8(%ebp),%edx
  8006c7:	88 d1                	mov    %dl,%cl
  8006c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006cc:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8006d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006d3:	8b 00                	mov    (%eax),%eax
  8006d5:	3d ff 00 00 00       	cmp    $0xff,%eax
  8006da:	75 2c                	jne    800708 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8006dc:	a0 24 30 80 00       	mov    0x803024,%al
  8006e1:	0f b6 c0             	movzbl %al,%eax
  8006e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006e7:	8b 12                	mov    (%edx),%edx
  8006e9:	89 d1                	mov    %edx,%ecx
  8006eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006ee:	83 c2 08             	add    $0x8,%edx
  8006f1:	83 ec 04             	sub    $0x4,%esp
  8006f4:	50                   	push   %eax
  8006f5:	51                   	push   %ecx
  8006f6:	52                   	push   %edx
  8006f7:	e8 48 12 00 00       	call   801944 <sys_cputs>
  8006fc:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8006ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800702:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800708:	8b 45 0c             	mov    0xc(%ebp),%eax
  80070b:	8b 40 04             	mov    0x4(%eax),%eax
  80070e:	8d 50 01             	lea    0x1(%eax),%edx
  800711:	8b 45 0c             	mov    0xc(%ebp),%eax
  800714:	89 50 04             	mov    %edx,0x4(%eax)
}
  800717:	90                   	nop
  800718:	c9                   	leave  
  800719:	c3                   	ret    

0080071a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80071a:	55                   	push   %ebp
  80071b:	89 e5                	mov    %esp,%ebp
  80071d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800723:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80072a:	00 00 00 
	b.cnt = 0;
  80072d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800734:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800737:	ff 75 0c             	pushl  0xc(%ebp)
  80073a:	ff 75 08             	pushl  0x8(%ebp)
  80073d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800743:	50                   	push   %eax
  800744:	68 b1 06 80 00       	push   $0x8006b1
  800749:	e8 11 02 00 00       	call   80095f <vprintfmt>
  80074e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800751:	a0 24 30 80 00       	mov    0x803024,%al
  800756:	0f b6 c0             	movzbl %al,%eax
  800759:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80075f:	83 ec 04             	sub    $0x4,%esp
  800762:	50                   	push   %eax
  800763:	52                   	push   %edx
  800764:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80076a:	83 c0 08             	add    $0x8,%eax
  80076d:	50                   	push   %eax
  80076e:	e8 d1 11 00 00       	call   801944 <sys_cputs>
  800773:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800776:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80077d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800783:	c9                   	leave  
  800784:	c3                   	ret    

00800785 <cprintf>:

int cprintf(const char *fmt, ...) {
  800785:	55                   	push   %ebp
  800786:	89 e5                	mov    %esp,%ebp
  800788:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80078b:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800792:	8d 45 0c             	lea    0xc(%ebp),%eax
  800795:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800798:	8b 45 08             	mov    0x8(%ebp),%eax
  80079b:	83 ec 08             	sub    $0x8,%esp
  80079e:	ff 75 f4             	pushl  -0xc(%ebp)
  8007a1:	50                   	push   %eax
  8007a2:	e8 73 ff ff ff       	call   80071a <vcprintf>
  8007a7:	83 c4 10             	add    $0x10,%esp
  8007aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8007ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007b0:	c9                   	leave  
  8007b1:	c3                   	ret    

008007b2 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8007b2:	55                   	push   %ebp
  8007b3:	89 e5                	mov    %esp,%ebp
  8007b5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8007b8:	e8 98 13 00 00       	call   801b55 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8007bd:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c6:	83 ec 08             	sub    $0x8,%esp
  8007c9:	ff 75 f4             	pushl  -0xc(%ebp)
  8007cc:	50                   	push   %eax
  8007cd:	e8 48 ff ff ff       	call   80071a <vcprintf>
  8007d2:	83 c4 10             	add    $0x10,%esp
  8007d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8007d8:	e8 92 13 00 00       	call   801b6f <sys_enable_interrupt>
	return cnt;
  8007dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007e0:	c9                   	leave  
  8007e1:	c3                   	ret    

008007e2 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8007e2:	55                   	push   %ebp
  8007e3:	89 e5                	mov    %esp,%ebp
  8007e5:	53                   	push   %ebx
  8007e6:	83 ec 14             	sub    $0x14,%esp
  8007e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8007f5:	8b 45 18             	mov    0x18(%ebp),%eax
  8007f8:	ba 00 00 00 00       	mov    $0x0,%edx
  8007fd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800800:	77 55                	ja     800857 <printnum+0x75>
  800802:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800805:	72 05                	jb     80080c <printnum+0x2a>
  800807:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80080a:	77 4b                	ja     800857 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80080c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80080f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800812:	8b 45 18             	mov    0x18(%ebp),%eax
  800815:	ba 00 00 00 00       	mov    $0x0,%edx
  80081a:	52                   	push   %edx
  80081b:	50                   	push   %eax
  80081c:	ff 75 f4             	pushl  -0xc(%ebp)
  80081f:	ff 75 f0             	pushl  -0x10(%ebp)
  800822:	e8 6d 17 00 00       	call   801f94 <__udivdi3>
  800827:	83 c4 10             	add    $0x10,%esp
  80082a:	83 ec 04             	sub    $0x4,%esp
  80082d:	ff 75 20             	pushl  0x20(%ebp)
  800830:	53                   	push   %ebx
  800831:	ff 75 18             	pushl  0x18(%ebp)
  800834:	52                   	push   %edx
  800835:	50                   	push   %eax
  800836:	ff 75 0c             	pushl  0xc(%ebp)
  800839:	ff 75 08             	pushl  0x8(%ebp)
  80083c:	e8 a1 ff ff ff       	call   8007e2 <printnum>
  800841:	83 c4 20             	add    $0x20,%esp
  800844:	eb 1a                	jmp    800860 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800846:	83 ec 08             	sub    $0x8,%esp
  800849:	ff 75 0c             	pushl  0xc(%ebp)
  80084c:	ff 75 20             	pushl  0x20(%ebp)
  80084f:	8b 45 08             	mov    0x8(%ebp),%eax
  800852:	ff d0                	call   *%eax
  800854:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800857:	ff 4d 1c             	decl   0x1c(%ebp)
  80085a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80085e:	7f e6                	jg     800846 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800860:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800863:	bb 00 00 00 00       	mov    $0x0,%ebx
  800868:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80086b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80086e:	53                   	push   %ebx
  80086f:	51                   	push   %ecx
  800870:	52                   	push   %edx
  800871:	50                   	push   %eax
  800872:	e8 2d 18 00 00       	call   8020a4 <__umoddi3>
  800877:	83 c4 10             	add    $0x10,%esp
  80087a:	05 94 26 80 00       	add    $0x802694,%eax
  80087f:	8a 00                	mov    (%eax),%al
  800881:	0f be c0             	movsbl %al,%eax
  800884:	83 ec 08             	sub    $0x8,%esp
  800887:	ff 75 0c             	pushl  0xc(%ebp)
  80088a:	50                   	push   %eax
  80088b:	8b 45 08             	mov    0x8(%ebp),%eax
  80088e:	ff d0                	call   *%eax
  800890:	83 c4 10             	add    $0x10,%esp
}
  800893:	90                   	nop
  800894:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800897:	c9                   	leave  
  800898:	c3                   	ret    

00800899 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800899:	55                   	push   %ebp
  80089a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80089c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008a0:	7e 1c                	jle    8008be <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8008a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a5:	8b 00                	mov    (%eax),%eax
  8008a7:	8d 50 08             	lea    0x8(%eax),%edx
  8008aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ad:	89 10                	mov    %edx,(%eax)
  8008af:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b2:	8b 00                	mov    (%eax),%eax
  8008b4:	83 e8 08             	sub    $0x8,%eax
  8008b7:	8b 50 04             	mov    0x4(%eax),%edx
  8008ba:	8b 00                	mov    (%eax),%eax
  8008bc:	eb 40                	jmp    8008fe <getuint+0x65>
	else if (lflag)
  8008be:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008c2:	74 1e                	je     8008e2 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8008c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c7:	8b 00                	mov    (%eax),%eax
  8008c9:	8d 50 04             	lea    0x4(%eax),%edx
  8008cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cf:	89 10                	mov    %edx,(%eax)
  8008d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d4:	8b 00                	mov    (%eax),%eax
  8008d6:	83 e8 04             	sub    $0x4,%eax
  8008d9:	8b 00                	mov    (%eax),%eax
  8008db:	ba 00 00 00 00       	mov    $0x0,%edx
  8008e0:	eb 1c                	jmp    8008fe <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8008e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e5:	8b 00                	mov    (%eax),%eax
  8008e7:	8d 50 04             	lea    0x4(%eax),%edx
  8008ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ed:	89 10                	mov    %edx,(%eax)
  8008ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f2:	8b 00                	mov    (%eax),%eax
  8008f4:	83 e8 04             	sub    $0x4,%eax
  8008f7:	8b 00                	mov    (%eax),%eax
  8008f9:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8008fe:	5d                   	pop    %ebp
  8008ff:	c3                   	ret    

00800900 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800900:	55                   	push   %ebp
  800901:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800903:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800907:	7e 1c                	jle    800925 <getint+0x25>
		return va_arg(*ap, long long);
  800909:	8b 45 08             	mov    0x8(%ebp),%eax
  80090c:	8b 00                	mov    (%eax),%eax
  80090e:	8d 50 08             	lea    0x8(%eax),%edx
  800911:	8b 45 08             	mov    0x8(%ebp),%eax
  800914:	89 10                	mov    %edx,(%eax)
  800916:	8b 45 08             	mov    0x8(%ebp),%eax
  800919:	8b 00                	mov    (%eax),%eax
  80091b:	83 e8 08             	sub    $0x8,%eax
  80091e:	8b 50 04             	mov    0x4(%eax),%edx
  800921:	8b 00                	mov    (%eax),%eax
  800923:	eb 38                	jmp    80095d <getint+0x5d>
	else if (lflag)
  800925:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800929:	74 1a                	je     800945 <getint+0x45>
		return va_arg(*ap, long);
  80092b:	8b 45 08             	mov    0x8(%ebp),%eax
  80092e:	8b 00                	mov    (%eax),%eax
  800930:	8d 50 04             	lea    0x4(%eax),%edx
  800933:	8b 45 08             	mov    0x8(%ebp),%eax
  800936:	89 10                	mov    %edx,(%eax)
  800938:	8b 45 08             	mov    0x8(%ebp),%eax
  80093b:	8b 00                	mov    (%eax),%eax
  80093d:	83 e8 04             	sub    $0x4,%eax
  800940:	8b 00                	mov    (%eax),%eax
  800942:	99                   	cltd   
  800943:	eb 18                	jmp    80095d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800945:	8b 45 08             	mov    0x8(%ebp),%eax
  800948:	8b 00                	mov    (%eax),%eax
  80094a:	8d 50 04             	lea    0x4(%eax),%edx
  80094d:	8b 45 08             	mov    0x8(%ebp),%eax
  800950:	89 10                	mov    %edx,(%eax)
  800952:	8b 45 08             	mov    0x8(%ebp),%eax
  800955:	8b 00                	mov    (%eax),%eax
  800957:	83 e8 04             	sub    $0x4,%eax
  80095a:	8b 00                	mov    (%eax),%eax
  80095c:	99                   	cltd   
}
  80095d:	5d                   	pop    %ebp
  80095e:	c3                   	ret    

0080095f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80095f:	55                   	push   %ebp
  800960:	89 e5                	mov    %esp,%ebp
  800962:	56                   	push   %esi
  800963:	53                   	push   %ebx
  800964:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800967:	eb 17                	jmp    800980 <vprintfmt+0x21>
			if (ch == '\0')
  800969:	85 db                	test   %ebx,%ebx
  80096b:	0f 84 af 03 00 00    	je     800d20 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800971:	83 ec 08             	sub    $0x8,%esp
  800974:	ff 75 0c             	pushl  0xc(%ebp)
  800977:	53                   	push   %ebx
  800978:	8b 45 08             	mov    0x8(%ebp),%eax
  80097b:	ff d0                	call   *%eax
  80097d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800980:	8b 45 10             	mov    0x10(%ebp),%eax
  800983:	8d 50 01             	lea    0x1(%eax),%edx
  800986:	89 55 10             	mov    %edx,0x10(%ebp)
  800989:	8a 00                	mov    (%eax),%al
  80098b:	0f b6 d8             	movzbl %al,%ebx
  80098e:	83 fb 25             	cmp    $0x25,%ebx
  800991:	75 d6                	jne    800969 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800993:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800997:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80099e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8009a5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8009ac:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8009b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8009b6:	8d 50 01             	lea    0x1(%eax),%edx
  8009b9:	89 55 10             	mov    %edx,0x10(%ebp)
  8009bc:	8a 00                	mov    (%eax),%al
  8009be:	0f b6 d8             	movzbl %al,%ebx
  8009c1:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8009c4:	83 f8 55             	cmp    $0x55,%eax
  8009c7:	0f 87 2b 03 00 00    	ja     800cf8 <vprintfmt+0x399>
  8009cd:	8b 04 85 b8 26 80 00 	mov    0x8026b8(,%eax,4),%eax
  8009d4:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8009d6:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8009da:	eb d7                	jmp    8009b3 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8009dc:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8009e0:	eb d1                	jmp    8009b3 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009e2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8009e9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009ec:	89 d0                	mov    %edx,%eax
  8009ee:	c1 e0 02             	shl    $0x2,%eax
  8009f1:	01 d0                	add    %edx,%eax
  8009f3:	01 c0                	add    %eax,%eax
  8009f5:	01 d8                	add    %ebx,%eax
  8009f7:	83 e8 30             	sub    $0x30,%eax
  8009fa:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8009fd:	8b 45 10             	mov    0x10(%ebp),%eax
  800a00:	8a 00                	mov    (%eax),%al
  800a02:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800a05:	83 fb 2f             	cmp    $0x2f,%ebx
  800a08:	7e 3e                	jle    800a48 <vprintfmt+0xe9>
  800a0a:	83 fb 39             	cmp    $0x39,%ebx
  800a0d:	7f 39                	jg     800a48 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a0f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a12:	eb d5                	jmp    8009e9 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800a14:	8b 45 14             	mov    0x14(%ebp),%eax
  800a17:	83 c0 04             	add    $0x4,%eax
  800a1a:	89 45 14             	mov    %eax,0x14(%ebp)
  800a1d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a20:	83 e8 04             	sub    $0x4,%eax
  800a23:	8b 00                	mov    (%eax),%eax
  800a25:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a28:	eb 1f                	jmp    800a49 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a2a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a2e:	79 83                	jns    8009b3 <vprintfmt+0x54>
				width = 0;
  800a30:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a37:	e9 77 ff ff ff       	jmp    8009b3 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a3c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a43:	e9 6b ff ff ff       	jmp    8009b3 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a48:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a49:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a4d:	0f 89 60 ff ff ff    	jns    8009b3 <vprintfmt+0x54>
				width = precision, precision = -1;
  800a53:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a56:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a59:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a60:	e9 4e ff ff ff       	jmp    8009b3 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a65:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a68:	e9 46 ff ff ff       	jmp    8009b3 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a6d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a70:	83 c0 04             	add    $0x4,%eax
  800a73:	89 45 14             	mov    %eax,0x14(%ebp)
  800a76:	8b 45 14             	mov    0x14(%ebp),%eax
  800a79:	83 e8 04             	sub    $0x4,%eax
  800a7c:	8b 00                	mov    (%eax),%eax
  800a7e:	83 ec 08             	sub    $0x8,%esp
  800a81:	ff 75 0c             	pushl  0xc(%ebp)
  800a84:	50                   	push   %eax
  800a85:	8b 45 08             	mov    0x8(%ebp),%eax
  800a88:	ff d0                	call   *%eax
  800a8a:	83 c4 10             	add    $0x10,%esp
			break;
  800a8d:	e9 89 02 00 00       	jmp    800d1b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a92:	8b 45 14             	mov    0x14(%ebp),%eax
  800a95:	83 c0 04             	add    $0x4,%eax
  800a98:	89 45 14             	mov    %eax,0x14(%ebp)
  800a9b:	8b 45 14             	mov    0x14(%ebp),%eax
  800a9e:	83 e8 04             	sub    $0x4,%eax
  800aa1:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800aa3:	85 db                	test   %ebx,%ebx
  800aa5:	79 02                	jns    800aa9 <vprintfmt+0x14a>
				err = -err;
  800aa7:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800aa9:	83 fb 64             	cmp    $0x64,%ebx
  800aac:	7f 0b                	jg     800ab9 <vprintfmt+0x15a>
  800aae:	8b 34 9d 00 25 80 00 	mov    0x802500(,%ebx,4),%esi
  800ab5:	85 f6                	test   %esi,%esi
  800ab7:	75 19                	jne    800ad2 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ab9:	53                   	push   %ebx
  800aba:	68 a5 26 80 00       	push   $0x8026a5
  800abf:	ff 75 0c             	pushl  0xc(%ebp)
  800ac2:	ff 75 08             	pushl  0x8(%ebp)
  800ac5:	e8 5e 02 00 00       	call   800d28 <printfmt>
  800aca:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800acd:	e9 49 02 00 00       	jmp    800d1b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ad2:	56                   	push   %esi
  800ad3:	68 ae 26 80 00       	push   $0x8026ae
  800ad8:	ff 75 0c             	pushl  0xc(%ebp)
  800adb:	ff 75 08             	pushl  0x8(%ebp)
  800ade:	e8 45 02 00 00       	call   800d28 <printfmt>
  800ae3:	83 c4 10             	add    $0x10,%esp
			break;
  800ae6:	e9 30 02 00 00       	jmp    800d1b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800aeb:	8b 45 14             	mov    0x14(%ebp),%eax
  800aee:	83 c0 04             	add    $0x4,%eax
  800af1:	89 45 14             	mov    %eax,0x14(%ebp)
  800af4:	8b 45 14             	mov    0x14(%ebp),%eax
  800af7:	83 e8 04             	sub    $0x4,%eax
  800afa:	8b 30                	mov    (%eax),%esi
  800afc:	85 f6                	test   %esi,%esi
  800afe:	75 05                	jne    800b05 <vprintfmt+0x1a6>
				p = "(null)";
  800b00:	be b1 26 80 00       	mov    $0x8026b1,%esi
			if (width > 0 && padc != '-')
  800b05:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b09:	7e 6d                	jle    800b78 <vprintfmt+0x219>
  800b0b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b0f:	74 67                	je     800b78 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b11:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b14:	83 ec 08             	sub    $0x8,%esp
  800b17:	50                   	push   %eax
  800b18:	56                   	push   %esi
  800b19:	e8 0c 03 00 00       	call   800e2a <strnlen>
  800b1e:	83 c4 10             	add    $0x10,%esp
  800b21:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b24:	eb 16                	jmp    800b3c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b26:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b2a:	83 ec 08             	sub    $0x8,%esp
  800b2d:	ff 75 0c             	pushl  0xc(%ebp)
  800b30:	50                   	push   %eax
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	ff d0                	call   *%eax
  800b36:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b39:	ff 4d e4             	decl   -0x1c(%ebp)
  800b3c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b40:	7f e4                	jg     800b26 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b42:	eb 34                	jmp    800b78 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b44:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b48:	74 1c                	je     800b66 <vprintfmt+0x207>
  800b4a:	83 fb 1f             	cmp    $0x1f,%ebx
  800b4d:	7e 05                	jle    800b54 <vprintfmt+0x1f5>
  800b4f:	83 fb 7e             	cmp    $0x7e,%ebx
  800b52:	7e 12                	jle    800b66 <vprintfmt+0x207>
					putch('?', putdat);
  800b54:	83 ec 08             	sub    $0x8,%esp
  800b57:	ff 75 0c             	pushl  0xc(%ebp)
  800b5a:	6a 3f                	push   $0x3f
  800b5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5f:	ff d0                	call   *%eax
  800b61:	83 c4 10             	add    $0x10,%esp
  800b64:	eb 0f                	jmp    800b75 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b66:	83 ec 08             	sub    $0x8,%esp
  800b69:	ff 75 0c             	pushl  0xc(%ebp)
  800b6c:	53                   	push   %ebx
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b70:	ff d0                	call   *%eax
  800b72:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b75:	ff 4d e4             	decl   -0x1c(%ebp)
  800b78:	89 f0                	mov    %esi,%eax
  800b7a:	8d 70 01             	lea    0x1(%eax),%esi
  800b7d:	8a 00                	mov    (%eax),%al
  800b7f:	0f be d8             	movsbl %al,%ebx
  800b82:	85 db                	test   %ebx,%ebx
  800b84:	74 24                	je     800baa <vprintfmt+0x24b>
  800b86:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b8a:	78 b8                	js     800b44 <vprintfmt+0x1e5>
  800b8c:	ff 4d e0             	decl   -0x20(%ebp)
  800b8f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b93:	79 af                	jns    800b44 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b95:	eb 13                	jmp    800baa <vprintfmt+0x24b>
				putch(' ', putdat);
  800b97:	83 ec 08             	sub    $0x8,%esp
  800b9a:	ff 75 0c             	pushl  0xc(%ebp)
  800b9d:	6a 20                	push   $0x20
  800b9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba2:	ff d0                	call   *%eax
  800ba4:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ba7:	ff 4d e4             	decl   -0x1c(%ebp)
  800baa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bae:	7f e7                	jg     800b97 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800bb0:	e9 66 01 00 00       	jmp    800d1b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800bb5:	83 ec 08             	sub    $0x8,%esp
  800bb8:	ff 75 e8             	pushl  -0x18(%ebp)
  800bbb:	8d 45 14             	lea    0x14(%ebp),%eax
  800bbe:	50                   	push   %eax
  800bbf:	e8 3c fd ff ff       	call   800900 <getint>
  800bc4:	83 c4 10             	add    $0x10,%esp
  800bc7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bca:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800bcd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bd0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bd3:	85 d2                	test   %edx,%edx
  800bd5:	79 23                	jns    800bfa <vprintfmt+0x29b>
				putch('-', putdat);
  800bd7:	83 ec 08             	sub    $0x8,%esp
  800bda:	ff 75 0c             	pushl  0xc(%ebp)
  800bdd:	6a 2d                	push   $0x2d
  800bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800be2:	ff d0                	call   *%eax
  800be4:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800be7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bea:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bed:	f7 d8                	neg    %eax
  800bef:	83 d2 00             	adc    $0x0,%edx
  800bf2:	f7 da                	neg    %edx
  800bf4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bf7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800bfa:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c01:	e9 bc 00 00 00       	jmp    800cc2 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800c06:	83 ec 08             	sub    $0x8,%esp
  800c09:	ff 75 e8             	pushl  -0x18(%ebp)
  800c0c:	8d 45 14             	lea    0x14(%ebp),%eax
  800c0f:	50                   	push   %eax
  800c10:	e8 84 fc ff ff       	call   800899 <getuint>
  800c15:	83 c4 10             	add    $0x10,%esp
  800c18:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c1b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800c1e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c25:	e9 98 00 00 00       	jmp    800cc2 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c2a:	83 ec 08             	sub    $0x8,%esp
  800c2d:	ff 75 0c             	pushl  0xc(%ebp)
  800c30:	6a 58                	push   $0x58
  800c32:	8b 45 08             	mov    0x8(%ebp),%eax
  800c35:	ff d0                	call   *%eax
  800c37:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c3a:	83 ec 08             	sub    $0x8,%esp
  800c3d:	ff 75 0c             	pushl  0xc(%ebp)
  800c40:	6a 58                	push   $0x58
  800c42:	8b 45 08             	mov    0x8(%ebp),%eax
  800c45:	ff d0                	call   *%eax
  800c47:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c4a:	83 ec 08             	sub    $0x8,%esp
  800c4d:	ff 75 0c             	pushl  0xc(%ebp)
  800c50:	6a 58                	push   $0x58
  800c52:	8b 45 08             	mov    0x8(%ebp),%eax
  800c55:	ff d0                	call   *%eax
  800c57:	83 c4 10             	add    $0x10,%esp
			break;
  800c5a:	e9 bc 00 00 00       	jmp    800d1b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800c5f:	83 ec 08             	sub    $0x8,%esp
  800c62:	ff 75 0c             	pushl  0xc(%ebp)
  800c65:	6a 30                	push   $0x30
  800c67:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6a:	ff d0                	call   *%eax
  800c6c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c6f:	83 ec 08             	sub    $0x8,%esp
  800c72:	ff 75 0c             	pushl  0xc(%ebp)
  800c75:	6a 78                	push   $0x78
  800c77:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7a:	ff d0                	call   *%eax
  800c7c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c7f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c82:	83 c0 04             	add    $0x4,%eax
  800c85:	89 45 14             	mov    %eax,0x14(%ebp)
  800c88:	8b 45 14             	mov    0x14(%ebp),%eax
  800c8b:	83 e8 04             	sub    $0x4,%eax
  800c8e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c90:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c93:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c9a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ca1:	eb 1f                	jmp    800cc2 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ca3:	83 ec 08             	sub    $0x8,%esp
  800ca6:	ff 75 e8             	pushl  -0x18(%ebp)
  800ca9:	8d 45 14             	lea    0x14(%ebp),%eax
  800cac:	50                   	push   %eax
  800cad:	e8 e7 fb ff ff       	call   800899 <getuint>
  800cb2:	83 c4 10             	add    $0x10,%esp
  800cb5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cb8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800cbb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800cc2:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800cc6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cc9:	83 ec 04             	sub    $0x4,%esp
  800ccc:	52                   	push   %edx
  800ccd:	ff 75 e4             	pushl  -0x1c(%ebp)
  800cd0:	50                   	push   %eax
  800cd1:	ff 75 f4             	pushl  -0xc(%ebp)
  800cd4:	ff 75 f0             	pushl  -0x10(%ebp)
  800cd7:	ff 75 0c             	pushl  0xc(%ebp)
  800cda:	ff 75 08             	pushl  0x8(%ebp)
  800cdd:	e8 00 fb ff ff       	call   8007e2 <printnum>
  800ce2:	83 c4 20             	add    $0x20,%esp
			break;
  800ce5:	eb 34                	jmp    800d1b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ce7:	83 ec 08             	sub    $0x8,%esp
  800cea:	ff 75 0c             	pushl  0xc(%ebp)
  800ced:	53                   	push   %ebx
  800cee:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf1:	ff d0                	call   *%eax
  800cf3:	83 c4 10             	add    $0x10,%esp
			break;
  800cf6:	eb 23                	jmp    800d1b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800cf8:	83 ec 08             	sub    $0x8,%esp
  800cfb:	ff 75 0c             	pushl  0xc(%ebp)
  800cfe:	6a 25                	push   $0x25
  800d00:	8b 45 08             	mov    0x8(%ebp),%eax
  800d03:	ff d0                	call   *%eax
  800d05:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800d08:	ff 4d 10             	decl   0x10(%ebp)
  800d0b:	eb 03                	jmp    800d10 <vprintfmt+0x3b1>
  800d0d:	ff 4d 10             	decl   0x10(%ebp)
  800d10:	8b 45 10             	mov    0x10(%ebp),%eax
  800d13:	48                   	dec    %eax
  800d14:	8a 00                	mov    (%eax),%al
  800d16:	3c 25                	cmp    $0x25,%al
  800d18:	75 f3                	jne    800d0d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800d1a:	90                   	nop
		}
	}
  800d1b:	e9 47 fc ff ff       	jmp    800967 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800d20:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800d21:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d24:	5b                   	pop    %ebx
  800d25:	5e                   	pop    %esi
  800d26:	5d                   	pop    %ebp
  800d27:	c3                   	ret    

00800d28 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d28:	55                   	push   %ebp
  800d29:	89 e5                	mov    %esp,%ebp
  800d2b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d2e:	8d 45 10             	lea    0x10(%ebp),%eax
  800d31:	83 c0 04             	add    $0x4,%eax
  800d34:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d37:	8b 45 10             	mov    0x10(%ebp),%eax
  800d3a:	ff 75 f4             	pushl  -0xc(%ebp)
  800d3d:	50                   	push   %eax
  800d3e:	ff 75 0c             	pushl  0xc(%ebp)
  800d41:	ff 75 08             	pushl  0x8(%ebp)
  800d44:	e8 16 fc ff ff       	call   80095f <vprintfmt>
  800d49:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d4c:	90                   	nop
  800d4d:	c9                   	leave  
  800d4e:	c3                   	ret    

00800d4f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d4f:	55                   	push   %ebp
  800d50:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d55:	8b 40 08             	mov    0x8(%eax),%eax
  800d58:	8d 50 01             	lea    0x1(%eax),%edx
  800d5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d61:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d64:	8b 10                	mov    (%eax),%edx
  800d66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d69:	8b 40 04             	mov    0x4(%eax),%eax
  800d6c:	39 c2                	cmp    %eax,%edx
  800d6e:	73 12                	jae    800d82 <sprintputch+0x33>
		*b->buf++ = ch;
  800d70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d73:	8b 00                	mov    (%eax),%eax
  800d75:	8d 48 01             	lea    0x1(%eax),%ecx
  800d78:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d7b:	89 0a                	mov    %ecx,(%edx)
  800d7d:	8b 55 08             	mov    0x8(%ebp),%edx
  800d80:	88 10                	mov    %dl,(%eax)
}
  800d82:	90                   	nop
  800d83:	5d                   	pop    %ebp
  800d84:	c3                   	ret    

00800d85 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d85:	55                   	push   %ebp
  800d86:	89 e5                	mov    %esp,%ebp
  800d88:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d94:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d97:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9a:	01 d0                	add    %edx,%eax
  800d9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d9f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800da6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800daa:	74 06                	je     800db2 <vsnprintf+0x2d>
  800dac:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800db0:	7f 07                	jg     800db9 <vsnprintf+0x34>
		return -E_INVAL;
  800db2:	b8 03 00 00 00       	mov    $0x3,%eax
  800db7:	eb 20                	jmp    800dd9 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800db9:	ff 75 14             	pushl  0x14(%ebp)
  800dbc:	ff 75 10             	pushl  0x10(%ebp)
  800dbf:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800dc2:	50                   	push   %eax
  800dc3:	68 4f 0d 80 00       	push   $0x800d4f
  800dc8:	e8 92 fb ff ff       	call   80095f <vprintfmt>
  800dcd:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800dd0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800dd3:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800dd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800dd9:	c9                   	leave  
  800dda:	c3                   	ret    

00800ddb <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ddb:	55                   	push   %ebp
  800ddc:	89 e5                	mov    %esp,%ebp
  800dde:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800de1:	8d 45 10             	lea    0x10(%ebp),%eax
  800de4:	83 c0 04             	add    $0x4,%eax
  800de7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800dea:	8b 45 10             	mov    0x10(%ebp),%eax
  800ded:	ff 75 f4             	pushl  -0xc(%ebp)
  800df0:	50                   	push   %eax
  800df1:	ff 75 0c             	pushl  0xc(%ebp)
  800df4:	ff 75 08             	pushl  0x8(%ebp)
  800df7:	e8 89 ff ff ff       	call   800d85 <vsnprintf>
  800dfc:	83 c4 10             	add    $0x10,%esp
  800dff:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800e02:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e05:	c9                   	leave  
  800e06:	c3                   	ret    

00800e07 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e07:	55                   	push   %ebp
  800e08:	89 e5                	mov    %esp,%ebp
  800e0a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e0d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e14:	eb 06                	jmp    800e1c <strlen+0x15>
		n++;
  800e16:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e19:	ff 45 08             	incl   0x8(%ebp)
  800e1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1f:	8a 00                	mov    (%eax),%al
  800e21:	84 c0                	test   %al,%al
  800e23:	75 f1                	jne    800e16 <strlen+0xf>
		n++;
	return n;
  800e25:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e28:	c9                   	leave  
  800e29:	c3                   	ret    

00800e2a <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e2a:	55                   	push   %ebp
  800e2b:	89 e5                	mov    %esp,%ebp
  800e2d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e30:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e37:	eb 09                	jmp    800e42 <strnlen+0x18>
		n++;
  800e39:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e3c:	ff 45 08             	incl   0x8(%ebp)
  800e3f:	ff 4d 0c             	decl   0xc(%ebp)
  800e42:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e46:	74 09                	je     800e51 <strnlen+0x27>
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	8a 00                	mov    (%eax),%al
  800e4d:	84 c0                	test   %al,%al
  800e4f:	75 e8                	jne    800e39 <strnlen+0xf>
		n++;
	return n;
  800e51:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e54:	c9                   	leave  
  800e55:	c3                   	ret    

00800e56 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e56:	55                   	push   %ebp
  800e57:	89 e5                	mov    %esp,%ebp
  800e59:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e62:	90                   	nop
  800e63:	8b 45 08             	mov    0x8(%ebp),%eax
  800e66:	8d 50 01             	lea    0x1(%eax),%edx
  800e69:	89 55 08             	mov    %edx,0x8(%ebp)
  800e6c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e6f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e72:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e75:	8a 12                	mov    (%edx),%dl
  800e77:	88 10                	mov    %dl,(%eax)
  800e79:	8a 00                	mov    (%eax),%al
  800e7b:	84 c0                	test   %al,%al
  800e7d:	75 e4                	jne    800e63 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e7f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e82:	c9                   	leave  
  800e83:	c3                   	ret    

00800e84 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e84:	55                   	push   %ebp
  800e85:	89 e5                	mov    %esp,%ebp
  800e87:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e90:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e97:	eb 1f                	jmp    800eb8 <strncpy+0x34>
		*dst++ = *src;
  800e99:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9c:	8d 50 01             	lea    0x1(%eax),%edx
  800e9f:	89 55 08             	mov    %edx,0x8(%ebp)
  800ea2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ea5:	8a 12                	mov    (%edx),%dl
  800ea7:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800ea9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eac:	8a 00                	mov    (%eax),%al
  800eae:	84 c0                	test   %al,%al
  800eb0:	74 03                	je     800eb5 <strncpy+0x31>
			src++;
  800eb2:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800eb5:	ff 45 fc             	incl   -0x4(%ebp)
  800eb8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ebb:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ebe:	72 d9                	jb     800e99 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ec0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ec3:	c9                   	leave  
  800ec4:	c3                   	ret    

00800ec5 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ec5:	55                   	push   %ebp
  800ec6:	89 e5                	mov    %esp,%ebp
  800ec8:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ecb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ece:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ed1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ed5:	74 30                	je     800f07 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800ed7:	eb 16                	jmp    800eef <strlcpy+0x2a>
			*dst++ = *src++;
  800ed9:	8b 45 08             	mov    0x8(%ebp),%eax
  800edc:	8d 50 01             	lea    0x1(%eax),%edx
  800edf:	89 55 08             	mov    %edx,0x8(%ebp)
  800ee2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ee5:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ee8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800eeb:	8a 12                	mov    (%edx),%dl
  800eed:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800eef:	ff 4d 10             	decl   0x10(%ebp)
  800ef2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ef6:	74 09                	je     800f01 <strlcpy+0x3c>
  800ef8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efb:	8a 00                	mov    (%eax),%al
  800efd:	84 c0                	test   %al,%al
  800eff:	75 d8                	jne    800ed9 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f01:	8b 45 08             	mov    0x8(%ebp),%eax
  800f04:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f07:	8b 55 08             	mov    0x8(%ebp),%edx
  800f0a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f0d:	29 c2                	sub    %eax,%edx
  800f0f:	89 d0                	mov    %edx,%eax
}
  800f11:	c9                   	leave  
  800f12:	c3                   	ret    

00800f13 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f13:	55                   	push   %ebp
  800f14:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f16:	eb 06                	jmp    800f1e <strcmp+0xb>
		p++, q++;
  800f18:	ff 45 08             	incl   0x8(%ebp)
  800f1b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f21:	8a 00                	mov    (%eax),%al
  800f23:	84 c0                	test   %al,%al
  800f25:	74 0e                	je     800f35 <strcmp+0x22>
  800f27:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2a:	8a 10                	mov    (%eax),%dl
  800f2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2f:	8a 00                	mov    (%eax),%al
  800f31:	38 c2                	cmp    %al,%dl
  800f33:	74 e3                	je     800f18 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f35:	8b 45 08             	mov    0x8(%ebp),%eax
  800f38:	8a 00                	mov    (%eax),%al
  800f3a:	0f b6 d0             	movzbl %al,%edx
  800f3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f40:	8a 00                	mov    (%eax),%al
  800f42:	0f b6 c0             	movzbl %al,%eax
  800f45:	29 c2                	sub    %eax,%edx
  800f47:	89 d0                	mov    %edx,%eax
}
  800f49:	5d                   	pop    %ebp
  800f4a:	c3                   	ret    

00800f4b <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f4b:	55                   	push   %ebp
  800f4c:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f4e:	eb 09                	jmp    800f59 <strncmp+0xe>
		n--, p++, q++;
  800f50:	ff 4d 10             	decl   0x10(%ebp)
  800f53:	ff 45 08             	incl   0x8(%ebp)
  800f56:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f59:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5d:	74 17                	je     800f76 <strncmp+0x2b>
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	8a 00                	mov    (%eax),%al
  800f64:	84 c0                	test   %al,%al
  800f66:	74 0e                	je     800f76 <strncmp+0x2b>
  800f68:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6b:	8a 10                	mov    (%eax),%dl
  800f6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f70:	8a 00                	mov    (%eax),%al
  800f72:	38 c2                	cmp    %al,%dl
  800f74:	74 da                	je     800f50 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f76:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f7a:	75 07                	jne    800f83 <strncmp+0x38>
		return 0;
  800f7c:	b8 00 00 00 00       	mov    $0x0,%eax
  800f81:	eb 14                	jmp    800f97 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f83:	8b 45 08             	mov    0x8(%ebp),%eax
  800f86:	8a 00                	mov    (%eax),%al
  800f88:	0f b6 d0             	movzbl %al,%edx
  800f8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8e:	8a 00                	mov    (%eax),%al
  800f90:	0f b6 c0             	movzbl %al,%eax
  800f93:	29 c2                	sub    %eax,%edx
  800f95:	89 d0                	mov    %edx,%eax
}
  800f97:	5d                   	pop    %ebp
  800f98:	c3                   	ret    

00800f99 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f99:	55                   	push   %ebp
  800f9a:	89 e5                	mov    %esp,%ebp
  800f9c:	83 ec 04             	sub    $0x4,%esp
  800f9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fa5:	eb 12                	jmp    800fb9 <strchr+0x20>
		if (*s == c)
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	8a 00                	mov    (%eax),%al
  800fac:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800faf:	75 05                	jne    800fb6 <strchr+0x1d>
			return (char *) s;
  800fb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb4:	eb 11                	jmp    800fc7 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800fb6:	ff 45 08             	incl   0x8(%ebp)
  800fb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbc:	8a 00                	mov    (%eax),%al
  800fbe:	84 c0                	test   %al,%al
  800fc0:	75 e5                	jne    800fa7 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800fc2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fc7:	c9                   	leave  
  800fc8:	c3                   	ret    

00800fc9 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800fc9:	55                   	push   %ebp
  800fca:	89 e5                	mov    %esp,%ebp
  800fcc:	83 ec 04             	sub    $0x4,%esp
  800fcf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fd5:	eb 0d                	jmp    800fe4 <strfind+0x1b>
		if (*s == c)
  800fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fda:	8a 00                	mov    (%eax),%al
  800fdc:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fdf:	74 0e                	je     800fef <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800fe1:	ff 45 08             	incl   0x8(%ebp)
  800fe4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe7:	8a 00                	mov    (%eax),%al
  800fe9:	84 c0                	test   %al,%al
  800feb:	75 ea                	jne    800fd7 <strfind+0xe>
  800fed:	eb 01                	jmp    800ff0 <strfind+0x27>
		if (*s == c)
			break;
  800fef:	90                   	nop
	return (char *) s;
  800ff0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ff3:	c9                   	leave  
  800ff4:	c3                   	ret    

00800ff5 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ff5:	55                   	push   %ebp
  800ff6:	89 e5                	mov    %esp,%ebp
  800ff8:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801001:	8b 45 10             	mov    0x10(%ebp),%eax
  801004:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801007:	eb 0e                	jmp    801017 <memset+0x22>
		*p++ = c;
  801009:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80100c:	8d 50 01             	lea    0x1(%eax),%edx
  80100f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801012:	8b 55 0c             	mov    0xc(%ebp),%edx
  801015:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801017:	ff 4d f8             	decl   -0x8(%ebp)
  80101a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80101e:	79 e9                	jns    801009 <memset+0x14>
		*p++ = c;

	return v;
  801020:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801023:	c9                   	leave  
  801024:	c3                   	ret    

00801025 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801025:	55                   	push   %ebp
  801026:	89 e5                	mov    %esp,%ebp
  801028:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80102b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801031:	8b 45 08             	mov    0x8(%ebp),%eax
  801034:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801037:	eb 16                	jmp    80104f <memcpy+0x2a>
		*d++ = *s++;
  801039:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80103c:	8d 50 01             	lea    0x1(%eax),%edx
  80103f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801042:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801045:	8d 4a 01             	lea    0x1(%edx),%ecx
  801048:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80104b:	8a 12                	mov    (%edx),%dl
  80104d:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80104f:	8b 45 10             	mov    0x10(%ebp),%eax
  801052:	8d 50 ff             	lea    -0x1(%eax),%edx
  801055:	89 55 10             	mov    %edx,0x10(%ebp)
  801058:	85 c0                	test   %eax,%eax
  80105a:	75 dd                	jne    801039 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80105c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80105f:	c9                   	leave  
  801060:	c3                   	ret    

00801061 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801061:	55                   	push   %ebp
  801062:	89 e5                	mov    %esp,%ebp
  801064:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801067:	8b 45 0c             	mov    0xc(%ebp),%eax
  80106a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
  801070:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801073:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801076:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801079:	73 50                	jae    8010cb <memmove+0x6a>
  80107b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80107e:	8b 45 10             	mov    0x10(%ebp),%eax
  801081:	01 d0                	add    %edx,%eax
  801083:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801086:	76 43                	jbe    8010cb <memmove+0x6a>
		s += n;
  801088:	8b 45 10             	mov    0x10(%ebp),%eax
  80108b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80108e:	8b 45 10             	mov    0x10(%ebp),%eax
  801091:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801094:	eb 10                	jmp    8010a6 <memmove+0x45>
			*--d = *--s;
  801096:	ff 4d f8             	decl   -0x8(%ebp)
  801099:	ff 4d fc             	decl   -0x4(%ebp)
  80109c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80109f:	8a 10                	mov    (%eax),%dl
  8010a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010a4:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8010a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010ac:	89 55 10             	mov    %edx,0x10(%ebp)
  8010af:	85 c0                	test   %eax,%eax
  8010b1:	75 e3                	jne    801096 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8010b3:	eb 23                	jmp    8010d8 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8010b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b8:	8d 50 01             	lea    0x1(%eax),%edx
  8010bb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010be:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010c1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010c4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010c7:	8a 12                	mov    (%edx),%dl
  8010c9:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010cb:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ce:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010d1:	89 55 10             	mov    %edx,0x10(%ebp)
  8010d4:	85 c0                	test   %eax,%eax
  8010d6:	75 dd                	jne    8010b5 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8010d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010db:	c9                   	leave  
  8010dc:	c3                   	ret    

008010dd <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8010dd:	55                   	push   %ebp
  8010de:	89 e5                	mov    %esp,%ebp
  8010e0:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8010e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ec:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010ef:	eb 2a                	jmp    80111b <memcmp+0x3e>
		if (*s1 != *s2)
  8010f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010f4:	8a 10                	mov    (%eax),%dl
  8010f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010f9:	8a 00                	mov    (%eax),%al
  8010fb:	38 c2                	cmp    %al,%dl
  8010fd:	74 16                	je     801115 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801102:	8a 00                	mov    (%eax),%al
  801104:	0f b6 d0             	movzbl %al,%edx
  801107:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80110a:	8a 00                	mov    (%eax),%al
  80110c:	0f b6 c0             	movzbl %al,%eax
  80110f:	29 c2                	sub    %eax,%edx
  801111:	89 d0                	mov    %edx,%eax
  801113:	eb 18                	jmp    80112d <memcmp+0x50>
		s1++, s2++;
  801115:	ff 45 fc             	incl   -0x4(%ebp)
  801118:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80111b:	8b 45 10             	mov    0x10(%ebp),%eax
  80111e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801121:	89 55 10             	mov    %edx,0x10(%ebp)
  801124:	85 c0                	test   %eax,%eax
  801126:	75 c9                	jne    8010f1 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801128:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80112d:	c9                   	leave  
  80112e:	c3                   	ret    

0080112f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80112f:	55                   	push   %ebp
  801130:	89 e5                	mov    %esp,%ebp
  801132:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801135:	8b 55 08             	mov    0x8(%ebp),%edx
  801138:	8b 45 10             	mov    0x10(%ebp),%eax
  80113b:	01 d0                	add    %edx,%eax
  80113d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801140:	eb 15                	jmp    801157 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801142:	8b 45 08             	mov    0x8(%ebp),%eax
  801145:	8a 00                	mov    (%eax),%al
  801147:	0f b6 d0             	movzbl %al,%edx
  80114a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114d:	0f b6 c0             	movzbl %al,%eax
  801150:	39 c2                	cmp    %eax,%edx
  801152:	74 0d                	je     801161 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801154:	ff 45 08             	incl   0x8(%ebp)
  801157:	8b 45 08             	mov    0x8(%ebp),%eax
  80115a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80115d:	72 e3                	jb     801142 <memfind+0x13>
  80115f:	eb 01                	jmp    801162 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801161:	90                   	nop
	return (void *) s;
  801162:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801165:	c9                   	leave  
  801166:	c3                   	ret    

00801167 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801167:	55                   	push   %ebp
  801168:	89 e5                	mov    %esp,%ebp
  80116a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80116d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801174:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80117b:	eb 03                	jmp    801180 <strtol+0x19>
		s++;
  80117d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801180:	8b 45 08             	mov    0x8(%ebp),%eax
  801183:	8a 00                	mov    (%eax),%al
  801185:	3c 20                	cmp    $0x20,%al
  801187:	74 f4                	je     80117d <strtol+0x16>
  801189:	8b 45 08             	mov    0x8(%ebp),%eax
  80118c:	8a 00                	mov    (%eax),%al
  80118e:	3c 09                	cmp    $0x9,%al
  801190:	74 eb                	je     80117d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801192:	8b 45 08             	mov    0x8(%ebp),%eax
  801195:	8a 00                	mov    (%eax),%al
  801197:	3c 2b                	cmp    $0x2b,%al
  801199:	75 05                	jne    8011a0 <strtol+0x39>
		s++;
  80119b:	ff 45 08             	incl   0x8(%ebp)
  80119e:	eb 13                	jmp    8011b3 <strtol+0x4c>
	else if (*s == '-')
  8011a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a3:	8a 00                	mov    (%eax),%al
  8011a5:	3c 2d                	cmp    $0x2d,%al
  8011a7:	75 0a                	jne    8011b3 <strtol+0x4c>
		s++, neg = 1;
  8011a9:	ff 45 08             	incl   0x8(%ebp)
  8011ac:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8011b3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011b7:	74 06                	je     8011bf <strtol+0x58>
  8011b9:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8011bd:	75 20                	jne    8011df <strtol+0x78>
  8011bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c2:	8a 00                	mov    (%eax),%al
  8011c4:	3c 30                	cmp    $0x30,%al
  8011c6:	75 17                	jne    8011df <strtol+0x78>
  8011c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cb:	40                   	inc    %eax
  8011cc:	8a 00                	mov    (%eax),%al
  8011ce:	3c 78                	cmp    $0x78,%al
  8011d0:	75 0d                	jne    8011df <strtol+0x78>
		s += 2, base = 16;
  8011d2:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011d6:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8011dd:	eb 28                	jmp    801207 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8011df:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011e3:	75 15                	jne    8011fa <strtol+0x93>
  8011e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e8:	8a 00                	mov    (%eax),%al
  8011ea:	3c 30                	cmp    $0x30,%al
  8011ec:	75 0c                	jne    8011fa <strtol+0x93>
		s++, base = 8;
  8011ee:	ff 45 08             	incl   0x8(%ebp)
  8011f1:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011f8:	eb 0d                	jmp    801207 <strtol+0xa0>
	else if (base == 0)
  8011fa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011fe:	75 07                	jne    801207 <strtol+0xa0>
		base = 10;
  801200:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801207:	8b 45 08             	mov    0x8(%ebp),%eax
  80120a:	8a 00                	mov    (%eax),%al
  80120c:	3c 2f                	cmp    $0x2f,%al
  80120e:	7e 19                	jle    801229 <strtol+0xc2>
  801210:	8b 45 08             	mov    0x8(%ebp),%eax
  801213:	8a 00                	mov    (%eax),%al
  801215:	3c 39                	cmp    $0x39,%al
  801217:	7f 10                	jg     801229 <strtol+0xc2>
			dig = *s - '0';
  801219:	8b 45 08             	mov    0x8(%ebp),%eax
  80121c:	8a 00                	mov    (%eax),%al
  80121e:	0f be c0             	movsbl %al,%eax
  801221:	83 e8 30             	sub    $0x30,%eax
  801224:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801227:	eb 42                	jmp    80126b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801229:	8b 45 08             	mov    0x8(%ebp),%eax
  80122c:	8a 00                	mov    (%eax),%al
  80122e:	3c 60                	cmp    $0x60,%al
  801230:	7e 19                	jle    80124b <strtol+0xe4>
  801232:	8b 45 08             	mov    0x8(%ebp),%eax
  801235:	8a 00                	mov    (%eax),%al
  801237:	3c 7a                	cmp    $0x7a,%al
  801239:	7f 10                	jg     80124b <strtol+0xe4>
			dig = *s - 'a' + 10;
  80123b:	8b 45 08             	mov    0x8(%ebp),%eax
  80123e:	8a 00                	mov    (%eax),%al
  801240:	0f be c0             	movsbl %al,%eax
  801243:	83 e8 57             	sub    $0x57,%eax
  801246:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801249:	eb 20                	jmp    80126b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80124b:	8b 45 08             	mov    0x8(%ebp),%eax
  80124e:	8a 00                	mov    (%eax),%al
  801250:	3c 40                	cmp    $0x40,%al
  801252:	7e 39                	jle    80128d <strtol+0x126>
  801254:	8b 45 08             	mov    0x8(%ebp),%eax
  801257:	8a 00                	mov    (%eax),%al
  801259:	3c 5a                	cmp    $0x5a,%al
  80125b:	7f 30                	jg     80128d <strtol+0x126>
			dig = *s - 'A' + 10;
  80125d:	8b 45 08             	mov    0x8(%ebp),%eax
  801260:	8a 00                	mov    (%eax),%al
  801262:	0f be c0             	movsbl %al,%eax
  801265:	83 e8 37             	sub    $0x37,%eax
  801268:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80126b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80126e:	3b 45 10             	cmp    0x10(%ebp),%eax
  801271:	7d 19                	jge    80128c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801273:	ff 45 08             	incl   0x8(%ebp)
  801276:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801279:	0f af 45 10          	imul   0x10(%ebp),%eax
  80127d:	89 c2                	mov    %eax,%edx
  80127f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801282:	01 d0                	add    %edx,%eax
  801284:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801287:	e9 7b ff ff ff       	jmp    801207 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80128c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80128d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801291:	74 08                	je     80129b <strtol+0x134>
		*endptr = (char *) s;
  801293:	8b 45 0c             	mov    0xc(%ebp),%eax
  801296:	8b 55 08             	mov    0x8(%ebp),%edx
  801299:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80129b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80129f:	74 07                	je     8012a8 <strtol+0x141>
  8012a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012a4:	f7 d8                	neg    %eax
  8012a6:	eb 03                	jmp    8012ab <strtol+0x144>
  8012a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012ab:	c9                   	leave  
  8012ac:	c3                   	ret    

008012ad <ltostr>:

void
ltostr(long value, char *str)
{
  8012ad:	55                   	push   %ebp
  8012ae:	89 e5                	mov    %esp,%ebp
  8012b0:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8012b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8012ba:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8012c1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012c5:	79 13                	jns    8012da <ltostr+0x2d>
	{
		neg = 1;
  8012c7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d1:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012d4:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012d7:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8012da:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dd:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8012e2:	99                   	cltd   
  8012e3:	f7 f9                	idiv   %ecx
  8012e5:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012eb:	8d 50 01             	lea    0x1(%eax),%edx
  8012ee:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012f1:	89 c2                	mov    %eax,%edx
  8012f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f6:	01 d0                	add    %edx,%eax
  8012f8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012fb:	83 c2 30             	add    $0x30,%edx
  8012fe:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801300:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801303:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801308:	f7 e9                	imul   %ecx
  80130a:	c1 fa 02             	sar    $0x2,%edx
  80130d:	89 c8                	mov    %ecx,%eax
  80130f:	c1 f8 1f             	sar    $0x1f,%eax
  801312:	29 c2                	sub    %eax,%edx
  801314:	89 d0                	mov    %edx,%eax
  801316:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801319:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80131c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801321:	f7 e9                	imul   %ecx
  801323:	c1 fa 02             	sar    $0x2,%edx
  801326:	89 c8                	mov    %ecx,%eax
  801328:	c1 f8 1f             	sar    $0x1f,%eax
  80132b:	29 c2                	sub    %eax,%edx
  80132d:	89 d0                	mov    %edx,%eax
  80132f:	c1 e0 02             	shl    $0x2,%eax
  801332:	01 d0                	add    %edx,%eax
  801334:	01 c0                	add    %eax,%eax
  801336:	29 c1                	sub    %eax,%ecx
  801338:	89 ca                	mov    %ecx,%edx
  80133a:	85 d2                	test   %edx,%edx
  80133c:	75 9c                	jne    8012da <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80133e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801345:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801348:	48                   	dec    %eax
  801349:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80134c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801350:	74 3d                	je     80138f <ltostr+0xe2>
		start = 1 ;
  801352:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801359:	eb 34                	jmp    80138f <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80135b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80135e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801361:	01 d0                	add    %edx,%eax
  801363:	8a 00                	mov    (%eax),%al
  801365:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801368:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80136b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80136e:	01 c2                	add    %eax,%edx
  801370:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801373:	8b 45 0c             	mov    0xc(%ebp),%eax
  801376:	01 c8                	add    %ecx,%eax
  801378:	8a 00                	mov    (%eax),%al
  80137a:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80137c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80137f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801382:	01 c2                	add    %eax,%edx
  801384:	8a 45 eb             	mov    -0x15(%ebp),%al
  801387:	88 02                	mov    %al,(%edx)
		start++ ;
  801389:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80138c:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80138f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801392:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801395:	7c c4                	jl     80135b <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801397:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80139a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139d:	01 d0                	add    %edx,%eax
  80139f:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8013a2:	90                   	nop
  8013a3:	c9                   	leave  
  8013a4:	c3                   	ret    

008013a5 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8013a5:	55                   	push   %ebp
  8013a6:	89 e5                	mov    %esp,%ebp
  8013a8:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8013ab:	ff 75 08             	pushl  0x8(%ebp)
  8013ae:	e8 54 fa ff ff       	call   800e07 <strlen>
  8013b3:	83 c4 04             	add    $0x4,%esp
  8013b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8013b9:	ff 75 0c             	pushl  0xc(%ebp)
  8013bc:	e8 46 fa ff ff       	call   800e07 <strlen>
  8013c1:	83 c4 04             	add    $0x4,%esp
  8013c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8013c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8013ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013d5:	eb 17                	jmp    8013ee <strcconcat+0x49>
		final[s] = str1[s] ;
  8013d7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013da:	8b 45 10             	mov    0x10(%ebp),%eax
  8013dd:	01 c2                	add    %eax,%edx
  8013df:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8013e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e5:	01 c8                	add    %ecx,%eax
  8013e7:	8a 00                	mov    (%eax),%al
  8013e9:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013eb:	ff 45 fc             	incl   -0x4(%ebp)
  8013ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013f1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013f4:	7c e1                	jl     8013d7 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013f6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013fd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801404:	eb 1f                	jmp    801425 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801406:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801409:	8d 50 01             	lea    0x1(%eax),%edx
  80140c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80140f:	89 c2                	mov    %eax,%edx
  801411:	8b 45 10             	mov    0x10(%ebp),%eax
  801414:	01 c2                	add    %eax,%edx
  801416:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801419:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141c:	01 c8                	add    %ecx,%eax
  80141e:	8a 00                	mov    (%eax),%al
  801420:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801422:	ff 45 f8             	incl   -0x8(%ebp)
  801425:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801428:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80142b:	7c d9                	jl     801406 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80142d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801430:	8b 45 10             	mov    0x10(%ebp),%eax
  801433:	01 d0                	add    %edx,%eax
  801435:	c6 00 00             	movb   $0x0,(%eax)
}
  801438:	90                   	nop
  801439:	c9                   	leave  
  80143a:	c3                   	ret    

0080143b <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80143b:	55                   	push   %ebp
  80143c:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80143e:	8b 45 14             	mov    0x14(%ebp),%eax
  801441:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801447:	8b 45 14             	mov    0x14(%ebp),%eax
  80144a:	8b 00                	mov    (%eax),%eax
  80144c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801453:	8b 45 10             	mov    0x10(%ebp),%eax
  801456:	01 d0                	add    %edx,%eax
  801458:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80145e:	eb 0c                	jmp    80146c <strsplit+0x31>
			*string++ = 0;
  801460:	8b 45 08             	mov    0x8(%ebp),%eax
  801463:	8d 50 01             	lea    0x1(%eax),%edx
  801466:	89 55 08             	mov    %edx,0x8(%ebp)
  801469:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80146c:	8b 45 08             	mov    0x8(%ebp),%eax
  80146f:	8a 00                	mov    (%eax),%al
  801471:	84 c0                	test   %al,%al
  801473:	74 18                	je     80148d <strsplit+0x52>
  801475:	8b 45 08             	mov    0x8(%ebp),%eax
  801478:	8a 00                	mov    (%eax),%al
  80147a:	0f be c0             	movsbl %al,%eax
  80147d:	50                   	push   %eax
  80147e:	ff 75 0c             	pushl  0xc(%ebp)
  801481:	e8 13 fb ff ff       	call   800f99 <strchr>
  801486:	83 c4 08             	add    $0x8,%esp
  801489:	85 c0                	test   %eax,%eax
  80148b:	75 d3                	jne    801460 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80148d:	8b 45 08             	mov    0x8(%ebp),%eax
  801490:	8a 00                	mov    (%eax),%al
  801492:	84 c0                	test   %al,%al
  801494:	74 5a                	je     8014f0 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801496:	8b 45 14             	mov    0x14(%ebp),%eax
  801499:	8b 00                	mov    (%eax),%eax
  80149b:	83 f8 0f             	cmp    $0xf,%eax
  80149e:	75 07                	jne    8014a7 <strsplit+0x6c>
		{
			return 0;
  8014a0:	b8 00 00 00 00       	mov    $0x0,%eax
  8014a5:	eb 66                	jmp    80150d <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8014a7:	8b 45 14             	mov    0x14(%ebp),%eax
  8014aa:	8b 00                	mov    (%eax),%eax
  8014ac:	8d 48 01             	lea    0x1(%eax),%ecx
  8014af:	8b 55 14             	mov    0x14(%ebp),%edx
  8014b2:	89 0a                	mov    %ecx,(%edx)
  8014b4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8014be:	01 c2                	add    %eax,%edx
  8014c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c3:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014c5:	eb 03                	jmp    8014ca <strsplit+0x8f>
			string++;
  8014c7:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cd:	8a 00                	mov    (%eax),%al
  8014cf:	84 c0                	test   %al,%al
  8014d1:	74 8b                	je     80145e <strsplit+0x23>
  8014d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d6:	8a 00                	mov    (%eax),%al
  8014d8:	0f be c0             	movsbl %al,%eax
  8014db:	50                   	push   %eax
  8014dc:	ff 75 0c             	pushl  0xc(%ebp)
  8014df:	e8 b5 fa ff ff       	call   800f99 <strchr>
  8014e4:	83 c4 08             	add    $0x8,%esp
  8014e7:	85 c0                	test   %eax,%eax
  8014e9:	74 dc                	je     8014c7 <strsplit+0x8c>
			string++;
	}
  8014eb:	e9 6e ff ff ff       	jmp    80145e <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014f0:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014f1:	8b 45 14             	mov    0x14(%ebp),%eax
  8014f4:	8b 00                	mov    (%eax),%eax
  8014f6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801500:	01 d0                	add    %edx,%eax
  801502:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801508:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80150d:	c9                   	leave  
  80150e:	c3                   	ret    

0080150f <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  80150f:	55                   	push   %ebp
  801510:	89 e5                	mov    %esp,%ebp
  801512:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  801515:	e8 3b 09 00 00       	call   801e55 <sys_isUHeapPlacementStrategyFIRSTFIT>
  80151a:	85 c0                	test   %eax,%eax
  80151c:	0f 84 3a 01 00 00    	je     80165c <malloc+0x14d>

		if(pl == 0){
  801522:	a1 28 30 80 00       	mov    0x803028,%eax
  801527:	85 c0                	test   %eax,%eax
  801529:	75 24                	jne    80154f <malloc+0x40>
			for(int k = 0; k < Size; k++){
  80152b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801532:	eb 11                	jmp    801545 <malloc+0x36>
				arr[k] = -10000;
  801534:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801537:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  80153e:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801542:	ff 45 f4             	incl   -0xc(%ebp)
  801545:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801548:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  80154d:	76 e5                	jbe    801534 <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  80154f:	c7 05 28 30 80 00 01 	movl   $0x1,0x803028
  801556:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801559:	8b 45 08             	mov    0x8(%ebp),%eax
  80155c:	c1 e8 0c             	shr    $0xc,%eax
  80155f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  801562:	8b 45 08             	mov    0x8(%ebp),%eax
  801565:	25 ff 0f 00 00       	and    $0xfff,%eax
  80156a:	85 c0                	test   %eax,%eax
  80156c:	74 03                	je     801571 <malloc+0x62>
			x++;
  80156e:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  801571:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  801578:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  80157f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801586:	eb 66                	jmp    8015ee <malloc+0xdf>
			if( arr[k] == -10000){
  801588:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80158b:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801592:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801597:	75 52                	jne    8015eb <malloc+0xdc>
				uint32 w = 0 ;
  801599:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  8015a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8015a3:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  8015a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8015a9:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8015ac:	eb 09                	jmp    8015b7 <malloc+0xa8>
  8015ae:	ff 45 e0             	incl   -0x20(%ebp)
  8015b1:	ff 45 dc             	incl   -0x24(%ebp)
  8015b4:	ff 45 e4             	incl   -0x1c(%ebp)
  8015b7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8015ba:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8015bf:	77 19                	ja     8015da <malloc+0xcb>
  8015c1:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8015c4:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8015cb:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  8015d0:	75 08                	jne    8015da <malloc+0xcb>
  8015d2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8015d5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015d8:	72 d4                	jb     8015ae <malloc+0x9f>
				if(w >= x){
  8015da:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8015dd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015e0:	72 09                	jb     8015eb <malloc+0xdc>
					p = 1 ;
  8015e2:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  8015e9:	eb 0d                	jmp    8015f8 <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  8015eb:	ff 45 e4             	incl   -0x1c(%ebp)
  8015ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8015f1:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  8015f6:	76 90                	jbe    801588 <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  8015f8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8015fc:	75 0a                	jne    801608 <malloc+0xf9>
  8015fe:	b8 00 00 00 00       	mov    $0x0,%eax
  801603:	e9 ca 01 00 00       	jmp    8017d2 <malloc+0x2c3>
		int q = idx;
  801608:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80160b:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  80160e:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801615:	eb 16                	jmp    80162d <malloc+0x11e>
			arr[q++] = x;
  801617:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80161a:	8d 50 01             	lea    0x1(%eax),%edx
  80161d:	89 55 d8             	mov    %edx,-0x28(%ebp)
  801620:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801623:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  80162a:	ff 45 d4             	incl   -0x2c(%ebp)
  80162d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801630:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801633:	72 e2                	jb     801617 <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801635:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801638:	05 00 00 08 00       	add    $0x80000,%eax
  80163d:	c1 e0 0c             	shl    $0xc,%eax
  801640:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  801643:	83 ec 08             	sub    $0x8,%esp
  801646:	ff 75 f0             	pushl  -0x10(%ebp)
  801649:	ff 75 ac             	pushl  -0x54(%ebp)
  80164c:	e8 9b 04 00 00       	call   801aec <sys_allocateMem>
  801651:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801654:	8b 45 ac             	mov    -0x54(%ebp),%eax
  801657:	e9 76 01 00 00       	jmp    8017d2 <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  80165c:	e8 25 08 00 00       	call   801e86 <sys_isUHeapPlacementStrategyBESTFIT>
  801661:	85 c0                	test   %eax,%eax
  801663:	0f 84 64 01 00 00    	je     8017cd <malloc+0x2be>
		if(pl == 0){
  801669:	a1 28 30 80 00       	mov    0x803028,%eax
  80166e:	85 c0                	test   %eax,%eax
  801670:	75 24                	jne    801696 <malloc+0x187>
			for(int k = 0; k < Size; k++){
  801672:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  801679:	eb 11                	jmp    80168c <malloc+0x17d>
				arr[k] = -10000;
  80167b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80167e:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801685:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801689:	ff 45 d0             	incl   -0x30(%ebp)
  80168c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80168f:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801694:	76 e5                	jbe    80167b <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801696:	c7 05 28 30 80 00 01 	movl   $0x1,0x803028
  80169d:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  8016a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a3:	c1 e8 0c             	shr    $0xc,%eax
  8016a6:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  8016a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ac:	25 ff 0f 00 00       	and    $0xfff,%eax
  8016b1:	85 c0                	test   %eax,%eax
  8016b3:	74 03                	je     8016b8 <malloc+0x1a9>
			x++;
  8016b5:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  8016b8:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  8016bf:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  8016c6:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  8016cd:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  8016d4:	e9 88 00 00 00       	jmp    801761 <malloc+0x252>
			if(arr[k] == -10000){
  8016d9:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8016dc:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8016e3:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  8016e8:	75 64                	jne    80174e <malloc+0x23f>
				uint32 w = 0 , i;
  8016ea:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  8016f1:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8016f4:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8016f7:	eb 06                	jmp    8016ff <malloc+0x1f0>
  8016f9:	ff 45 b8             	incl   -0x48(%ebp)
  8016fc:	ff 45 b4             	incl   -0x4c(%ebp)
  8016ff:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  801706:	77 11                	ja     801719 <malloc+0x20a>
  801708:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80170b:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801712:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801717:	74 e0                	je     8016f9 <malloc+0x1ea>
				if(w <q && w >= x){
  801719:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80171c:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  80171f:	73 24                	jae    801745 <malloc+0x236>
  801721:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801724:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801727:	72 1c                	jb     801745 <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  801729:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80172c:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80172f:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  801736:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801739:	89 45 c0             	mov    %eax,-0x40(%ebp)
  80173c:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80173f:	48                   	dec    %eax
  801740:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801743:	eb 19                	jmp    80175e <malloc+0x24f>
				}
				else {
					k = i - 1;
  801745:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801748:	48                   	dec    %eax
  801749:	89 45 bc             	mov    %eax,-0x44(%ebp)
  80174c:	eb 10                	jmp    80175e <malloc+0x24f>
				}
			} else {
				k += arr[k];
  80174e:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801751:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801758:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  80175b:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  80175e:	ff 45 bc             	incl   -0x44(%ebp)
  801761:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801764:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801769:	0f 86 6a ff ff ff    	jbe    8016d9 <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  80176f:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  801773:	75 07                	jne    80177c <malloc+0x26d>
  801775:	b8 00 00 00 00       	mov    $0x0,%eax
  80177a:	eb 56                	jmp    8017d2 <malloc+0x2c3>
	    q = idx;
  80177c:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80177f:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  801782:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  801789:	eb 16                	jmp    8017a1 <malloc+0x292>
			arr[q++] = x;
  80178b:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80178e:	8d 50 01             	lea    0x1(%eax),%edx
  801791:	89 55 c8             	mov    %edx,-0x38(%ebp)
  801794:	8b 55 cc             	mov    -0x34(%ebp),%edx
  801797:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  80179e:	ff 45 b0             	incl   -0x50(%ebp)
  8017a1:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8017a4:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  8017a7:	72 e2                	jb     80178b <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  8017a9:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8017ac:	05 00 00 08 00       	add    $0x80000,%eax
  8017b1:	c1 e0 0c             	shl    $0xc,%eax
  8017b4:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  8017b7:	83 ec 08             	sub    $0x8,%esp
  8017ba:	ff 75 cc             	pushl  -0x34(%ebp)
  8017bd:	ff 75 a8             	pushl  -0x58(%ebp)
  8017c0:	e8 27 03 00 00       	call   801aec <sys_allocateMem>
  8017c5:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  8017c8:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8017cb:	eb 05                	jmp    8017d2 <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  8017cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017d2:	c9                   	leave  
  8017d3:	c3                   	ret    

008017d4 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8017d4:	55                   	push   %ebp
  8017d5:	89 e5                	mov    %esp,%ebp
  8017d7:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  8017da:	8b 45 08             	mov    0x8(%ebp),%eax
  8017dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8017e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8017e3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8017e8:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  8017eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ee:	05 00 00 00 80       	add    $0x80000000,%eax
  8017f3:	c1 e8 0c             	shr    $0xc,%eax
  8017f6:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  8017fd:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801800:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801807:	8b 45 08             	mov    0x8(%ebp),%eax
  80180a:	05 00 00 00 80       	add    $0x80000000,%eax
  80180f:	c1 e8 0c             	shr    $0xc,%eax
  801812:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801815:	eb 14                	jmp    80182b <free+0x57>
		arr[j] = -10000;
  801817:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80181a:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801821:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801825:	ff 45 f4             	incl   -0xc(%ebp)
  801828:	ff 45 f0             	incl   -0x10(%ebp)
  80182b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80182e:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801831:	72 e4                	jb     801817 <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  801833:	8b 45 08             	mov    0x8(%ebp),%eax
  801836:	83 ec 08             	sub    $0x8,%esp
  801839:	ff 75 e8             	pushl  -0x18(%ebp)
  80183c:	50                   	push   %eax
  80183d:	e8 8e 02 00 00       	call   801ad0 <sys_freeMem>
  801842:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  801845:	90                   	nop
  801846:	c9                   	leave  
  801847:	c3                   	ret    

00801848 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801848:	55                   	push   %ebp
  801849:	89 e5                	mov    %esp,%ebp
  80184b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80184e:	83 ec 04             	sub    $0x4,%esp
  801851:	68 10 28 80 00       	push   $0x802810
  801856:	68 9e 00 00 00       	push   $0x9e
  80185b:	68 33 28 80 00       	push   $0x802833
  801860:	e8 69 ec ff ff       	call   8004ce <_panic>

00801865 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801865:	55                   	push   %ebp
  801866:	89 e5                	mov    %esp,%ebp
  801868:	83 ec 18             	sub    $0x18,%esp
  80186b:	8b 45 10             	mov    0x10(%ebp),%eax
  80186e:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801871:	83 ec 04             	sub    $0x4,%esp
  801874:	68 10 28 80 00       	push   $0x802810
  801879:	68 a9 00 00 00       	push   $0xa9
  80187e:	68 33 28 80 00       	push   $0x802833
  801883:	e8 46 ec ff ff       	call   8004ce <_panic>

00801888 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801888:	55                   	push   %ebp
  801889:	89 e5                	mov    %esp,%ebp
  80188b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80188e:	83 ec 04             	sub    $0x4,%esp
  801891:	68 10 28 80 00       	push   $0x802810
  801896:	68 af 00 00 00       	push   $0xaf
  80189b:	68 33 28 80 00       	push   $0x802833
  8018a0:	e8 29 ec ff ff       	call   8004ce <_panic>

008018a5 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8018a5:	55                   	push   %ebp
  8018a6:	89 e5                	mov    %esp,%ebp
  8018a8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8018ab:	83 ec 04             	sub    $0x4,%esp
  8018ae:	68 10 28 80 00       	push   $0x802810
  8018b3:	68 b5 00 00 00       	push   $0xb5
  8018b8:	68 33 28 80 00       	push   $0x802833
  8018bd:	e8 0c ec ff ff       	call   8004ce <_panic>

008018c2 <expand>:
}

void expand(uint32 newSize)
{
  8018c2:	55                   	push   %ebp
  8018c3:	89 e5                	mov    %esp,%ebp
  8018c5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8018c8:	83 ec 04             	sub    $0x4,%esp
  8018cb:	68 10 28 80 00       	push   $0x802810
  8018d0:	68 ba 00 00 00       	push   $0xba
  8018d5:	68 33 28 80 00       	push   $0x802833
  8018da:	e8 ef eb ff ff       	call   8004ce <_panic>

008018df <shrink>:
}
void shrink(uint32 newSize)
{
  8018df:	55                   	push   %ebp
  8018e0:	89 e5                	mov    %esp,%ebp
  8018e2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8018e5:	83 ec 04             	sub    $0x4,%esp
  8018e8:	68 10 28 80 00       	push   $0x802810
  8018ed:	68 be 00 00 00       	push   $0xbe
  8018f2:	68 33 28 80 00       	push   $0x802833
  8018f7:	e8 d2 eb ff ff       	call   8004ce <_panic>

008018fc <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8018fc:	55                   	push   %ebp
  8018fd:	89 e5                	mov    %esp,%ebp
  8018ff:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801902:	83 ec 04             	sub    $0x4,%esp
  801905:	68 10 28 80 00       	push   $0x802810
  80190a:	68 c3 00 00 00       	push   $0xc3
  80190f:	68 33 28 80 00       	push   $0x802833
  801914:	e8 b5 eb ff ff       	call   8004ce <_panic>

00801919 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801919:	55                   	push   %ebp
  80191a:	89 e5                	mov    %esp,%ebp
  80191c:	57                   	push   %edi
  80191d:	56                   	push   %esi
  80191e:	53                   	push   %ebx
  80191f:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801922:	8b 45 08             	mov    0x8(%ebp),%eax
  801925:	8b 55 0c             	mov    0xc(%ebp),%edx
  801928:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80192b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80192e:	8b 7d 18             	mov    0x18(%ebp),%edi
  801931:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801934:	cd 30                	int    $0x30
  801936:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801939:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80193c:	83 c4 10             	add    $0x10,%esp
  80193f:	5b                   	pop    %ebx
  801940:	5e                   	pop    %esi
  801941:	5f                   	pop    %edi
  801942:	5d                   	pop    %ebp
  801943:	c3                   	ret    

00801944 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801944:	55                   	push   %ebp
  801945:	89 e5                	mov    %esp,%ebp
  801947:	83 ec 04             	sub    $0x4,%esp
  80194a:	8b 45 10             	mov    0x10(%ebp),%eax
  80194d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801950:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801954:	8b 45 08             	mov    0x8(%ebp),%eax
  801957:	6a 00                	push   $0x0
  801959:	6a 00                	push   $0x0
  80195b:	52                   	push   %edx
  80195c:	ff 75 0c             	pushl  0xc(%ebp)
  80195f:	50                   	push   %eax
  801960:	6a 00                	push   $0x0
  801962:	e8 b2 ff ff ff       	call   801919 <syscall>
  801967:	83 c4 18             	add    $0x18,%esp
}
  80196a:	90                   	nop
  80196b:	c9                   	leave  
  80196c:	c3                   	ret    

0080196d <sys_cgetc>:

int
sys_cgetc(void)
{
  80196d:	55                   	push   %ebp
  80196e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801970:	6a 00                	push   $0x0
  801972:	6a 00                	push   $0x0
  801974:	6a 00                	push   $0x0
  801976:	6a 00                	push   $0x0
  801978:	6a 00                	push   $0x0
  80197a:	6a 01                	push   $0x1
  80197c:	e8 98 ff ff ff       	call   801919 <syscall>
  801981:	83 c4 18             	add    $0x18,%esp
}
  801984:	c9                   	leave  
  801985:	c3                   	ret    

00801986 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801986:	55                   	push   %ebp
  801987:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801989:	8b 45 08             	mov    0x8(%ebp),%eax
  80198c:	6a 00                	push   $0x0
  80198e:	6a 00                	push   $0x0
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	50                   	push   %eax
  801995:	6a 05                	push   $0x5
  801997:	e8 7d ff ff ff       	call   801919 <syscall>
  80199c:	83 c4 18             	add    $0x18,%esp
}
  80199f:	c9                   	leave  
  8019a0:	c3                   	ret    

008019a1 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8019a1:	55                   	push   %ebp
  8019a2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	6a 00                	push   $0x0
  8019ac:	6a 00                	push   $0x0
  8019ae:	6a 02                	push   $0x2
  8019b0:	e8 64 ff ff ff       	call   801919 <syscall>
  8019b5:	83 c4 18             	add    $0x18,%esp
}
  8019b8:	c9                   	leave  
  8019b9:	c3                   	ret    

008019ba <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8019ba:	55                   	push   %ebp
  8019bb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 03                	push   $0x3
  8019c9:	e8 4b ff ff ff       	call   801919 <syscall>
  8019ce:	83 c4 18             	add    $0x18,%esp
}
  8019d1:	c9                   	leave  
  8019d2:	c3                   	ret    

008019d3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8019d3:	55                   	push   %ebp
  8019d4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 00                	push   $0x0
  8019da:	6a 00                	push   $0x0
  8019dc:	6a 00                	push   $0x0
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 04                	push   $0x4
  8019e2:	e8 32 ff ff ff       	call   801919 <syscall>
  8019e7:	83 c4 18             	add    $0x18,%esp
}
  8019ea:	c9                   	leave  
  8019eb:	c3                   	ret    

008019ec <sys_env_exit>:


void sys_env_exit(void)
{
  8019ec:	55                   	push   %ebp
  8019ed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 00                	push   $0x0
  8019f7:	6a 00                	push   $0x0
  8019f9:	6a 06                	push   $0x6
  8019fb:	e8 19 ff ff ff       	call   801919 <syscall>
  801a00:	83 c4 18             	add    $0x18,%esp
}
  801a03:	90                   	nop
  801a04:	c9                   	leave  
  801a05:	c3                   	ret    

00801a06 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801a06:	55                   	push   %ebp
  801a07:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801a09:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	52                   	push   %edx
  801a16:	50                   	push   %eax
  801a17:	6a 07                	push   $0x7
  801a19:	e8 fb fe ff ff       	call   801919 <syscall>
  801a1e:	83 c4 18             	add    $0x18,%esp
}
  801a21:	c9                   	leave  
  801a22:	c3                   	ret    

00801a23 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801a23:	55                   	push   %ebp
  801a24:	89 e5                	mov    %esp,%ebp
  801a26:	56                   	push   %esi
  801a27:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801a28:	8b 75 18             	mov    0x18(%ebp),%esi
  801a2b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a2e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a31:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a34:	8b 45 08             	mov    0x8(%ebp),%eax
  801a37:	56                   	push   %esi
  801a38:	53                   	push   %ebx
  801a39:	51                   	push   %ecx
  801a3a:	52                   	push   %edx
  801a3b:	50                   	push   %eax
  801a3c:	6a 08                	push   $0x8
  801a3e:	e8 d6 fe ff ff       	call   801919 <syscall>
  801a43:	83 c4 18             	add    $0x18,%esp
}
  801a46:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801a49:	5b                   	pop    %ebx
  801a4a:	5e                   	pop    %esi
  801a4b:	5d                   	pop    %ebp
  801a4c:	c3                   	ret    

00801a4d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801a4d:	55                   	push   %ebp
  801a4e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801a50:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a53:	8b 45 08             	mov    0x8(%ebp),%eax
  801a56:	6a 00                	push   $0x0
  801a58:	6a 00                	push   $0x0
  801a5a:	6a 00                	push   $0x0
  801a5c:	52                   	push   %edx
  801a5d:	50                   	push   %eax
  801a5e:	6a 09                	push   $0x9
  801a60:	e8 b4 fe ff ff       	call   801919 <syscall>
  801a65:	83 c4 18             	add    $0x18,%esp
}
  801a68:	c9                   	leave  
  801a69:	c3                   	ret    

00801a6a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801a6a:	55                   	push   %ebp
  801a6b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 00                	push   $0x0
  801a73:	ff 75 0c             	pushl  0xc(%ebp)
  801a76:	ff 75 08             	pushl  0x8(%ebp)
  801a79:	6a 0a                	push   $0xa
  801a7b:	e8 99 fe ff ff       	call   801919 <syscall>
  801a80:	83 c4 18             	add    $0x18,%esp
}
  801a83:	c9                   	leave  
  801a84:	c3                   	ret    

00801a85 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801a85:	55                   	push   %ebp
  801a86:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801a88:	6a 00                	push   $0x0
  801a8a:	6a 00                	push   $0x0
  801a8c:	6a 00                	push   $0x0
  801a8e:	6a 00                	push   $0x0
  801a90:	6a 00                	push   $0x0
  801a92:	6a 0b                	push   $0xb
  801a94:	e8 80 fe ff ff       	call   801919 <syscall>
  801a99:	83 c4 18             	add    $0x18,%esp
}
  801a9c:	c9                   	leave  
  801a9d:	c3                   	ret    

00801a9e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801a9e:	55                   	push   %ebp
  801a9f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 00                	push   $0x0
  801aa9:	6a 00                	push   $0x0
  801aab:	6a 0c                	push   $0xc
  801aad:	e8 67 fe ff ff       	call   801919 <syscall>
  801ab2:	83 c4 18             	add    $0x18,%esp
}
  801ab5:	c9                   	leave  
  801ab6:	c3                   	ret    

00801ab7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801ab7:	55                   	push   %ebp
  801ab8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801aba:	6a 00                	push   $0x0
  801abc:	6a 00                	push   $0x0
  801abe:	6a 00                	push   $0x0
  801ac0:	6a 00                	push   $0x0
  801ac2:	6a 00                	push   $0x0
  801ac4:	6a 0d                	push   $0xd
  801ac6:	e8 4e fe ff ff       	call   801919 <syscall>
  801acb:	83 c4 18             	add    $0x18,%esp
}
  801ace:	c9                   	leave  
  801acf:	c3                   	ret    

00801ad0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ad0:	55                   	push   %ebp
  801ad1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801ad3:	6a 00                	push   $0x0
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	ff 75 0c             	pushl  0xc(%ebp)
  801adc:	ff 75 08             	pushl  0x8(%ebp)
  801adf:	6a 11                	push   $0x11
  801ae1:	e8 33 fe ff ff       	call   801919 <syscall>
  801ae6:	83 c4 18             	add    $0x18,%esp
	return;
  801ae9:	90                   	nop
}
  801aea:	c9                   	leave  
  801aeb:	c3                   	ret    

00801aec <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801aec:	55                   	push   %ebp
  801aed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801aef:	6a 00                	push   $0x0
  801af1:	6a 00                	push   $0x0
  801af3:	6a 00                	push   $0x0
  801af5:	ff 75 0c             	pushl  0xc(%ebp)
  801af8:	ff 75 08             	pushl  0x8(%ebp)
  801afb:	6a 12                	push   $0x12
  801afd:	e8 17 fe ff ff       	call   801919 <syscall>
  801b02:	83 c4 18             	add    $0x18,%esp
	return ;
  801b05:	90                   	nop
}
  801b06:	c9                   	leave  
  801b07:	c3                   	ret    

00801b08 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801b08:	55                   	push   %ebp
  801b09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 00                	push   $0x0
  801b11:	6a 00                	push   $0x0
  801b13:	6a 00                	push   $0x0
  801b15:	6a 0e                	push   $0xe
  801b17:	e8 fd fd ff ff       	call   801919 <syscall>
  801b1c:	83 c4 18             	add    $0x18,%esp
}
  801b1f:	c9                   	leave  
  801b20:	c3                   	ret    

00801b21 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801b21:	55                   	push   %ebp
  801b22:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801b24:	6a 00                	push   $0x0
  801b26:	6a 00                	push   $0x0
  801b28:	6a 00                	push   $0x0
  801b2a:	6a 00                	push   $0x0
  801b2c:	ff 75 08             	pushl  0x8(%ebp)
  801b2f:	6a 0f                	push   $0xf
  801b31:	e8 e3 fd ff ff       	call   801919 <syscall>
  801b36:	83 c4 18             	add    $0x18,%esp
}
  801b39:	c9                   	leave  
  801b3a:	c3                   	ret    

00801b3b <sys_scarce_memory>:

void sys_scarce_memory()
{
  801b3b:	55                   	push   %ebp
  801b3c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801b3e:	6a 00                	push   $0x0
  801b40:	6a 00                	push   $0x0
  801b42:	6a 00                	push   $0x0
  801b44:	6a 00                	push   $0x0
  801b46:	6a 00                	push   $0x0
  801b48:	6a 10                	push   $0x10
  801b4a:	e8 ca fd ff ff       	call   801919 <syscall>
  801b4f:	83 c4 18             	add    $0x18,%esp
}
  801b52:	90                   	nop
  801b53:	c9                   	leave  
  801b54:	c3                   	ret    

00801b55 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801b55:	55                   	push   %ebp
  801b56:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801b58:	6a 00                	push   $0x0
  801b5a:	6a 00                	push   $0x0
  801b5c:	6a 00                	push   $0x0
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	6a 14                	push   $0x14
  801b64:	e8 b0 fd ff ff       	call   801919 <syscall>
  801b69:	83 c4 18             	add    $0x18,%esp
}
  801b6c:	90                   	nop
  801b6d:	c9                   	leave  
  801b6e:	c3                   	ret    

00801b6f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801b6f:	55                   	push   %ebp
  801b70:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801b72:	6a 00                	push   $0x0
  801b74:	6a 00                	push   $0x0
  801b76:	6a 00                	push   $0x0
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 15                	push   $0x15
  801b7e:	e8 96 fd ff ff       	call   801919 <syscall>
  801b83:	83 c4 18             	add    $0x18,%esp
}
  801b86:	90                   	nop
  801b87:	c9                   	leave  
  801b88:	c3                   	ret    

00801b89 <sys_cputc>:


void
sys_cputc(const char c)
{
  801b89:	55                   	push   %ebp
  801b8a:	89 e5                	mov    %esp,%ebp
  801b8c:	83 ec 04             	sub    $0x4,%esp
  801b8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b92:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801b95:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 00                	push   $0x0
  801ba1:	50                   	push   %eax
  801ba2:	6a 16                	push   $0x16
  801ba4:	e8 70 fd ff ff       	call   801919 <syscall>
  801ba9:	83 c4 18             	add    $0x18,%esp
}
  801bac:	90                   	nop
  801bad:	c9                   	leave  
  801bae:	c3                   	ret    

00801baf <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801baf:	55                   	push   %ebp
  801bb0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 00                	push   $0x0
  801bba:	6a 00                	push   $0x0
  801bbc:	6a 17                	push   $0x17
  801bbe:	e8 56 fd ff ff       	call   801919 <syscall>
  801bc3:	83 c4 18             	add    $0x18,%esp
}
  801bc6:	90                   	nop
  801bc7:	c9                   	leave  
  801bc8:	c3                   	ret    

00801bc9 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801bc9:	55                   	push   %ebp
  801bca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801bcc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bcf:	6a 00                	push   $0x0
  801bd1:	6a 00                	push   $0x0
  801bd3:	6a 00                	push   $0x0
  801bd5:	ff 75 0c             	pushl  0xc(%ebp)
  801bd8:	50                   	push   %eax
  801bd9:	6a 18                	push   $0x18
  801bdb:	e8 39 fd ff ff       	call   801919 <syscall>
  801be0:	83 c4 18             	add    $0x18,%esp
}
  801be3:	c9                   	leave  
  801be4:	c3                   	ret    

00801be5 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801be5:	55                   	push   %ebp
  801be6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801be8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801beb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bee:	6a 00                	push   $0x0
  801bf0:	6a 00                	push   $0x0
  801bf2:	6a 00                	push   $0x0
  801bf4:	52                   	push   %edx
  801bf5:	50                   	push   %eax
  801bf6:	6a 1b                	push   $0x1b
  801bf8:	e8 1c fd ff ff       	call   801919 <syscall>
  801bfd:	83 c4 18             	add    $0x18,%esp
}
  801c00:	c9                   	leave  
  801c01:	c3                   	ret    

00801c02 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c02:	55                   	push   %ebp
  801c03:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c05:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c08:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0b:	6a 00                	push   $0x0
  801c0d:	6a 00                	push   $0x0
  801c0f:	6a 00                	push   $0x0
  801c11:	52                   	push   %edx
  801c12:	50                   	push   %eax
  801c13:	6a 19                	push   $0x19
  801c15:	e8 ff fc ff ff       	call   801919 <syscall>
  801c1a:	83 c4 18             	add    $0x18,%esp
}
  801c1d:	90                   	nop
  801c1e:	c9                   	leave  
  801c1f:	c3                   	ret    

00801c20 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801c20:	55                   	push   %ebp
  801c21:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801c23:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c26:	8b 45 08             	mov    0x8(%ebp),%eax
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	52                   	push   %edx
  801c30:	50                   	push   %eax
  801c31:	6a 1a                	push   $0x1a
  801c33:	e8 e1 fc ff ff       	call   801919 <syscall>
  801c38:	83 c4 18             	add    $0x18,%esp
}
  801c3b:	90                   	nop
  801c3c:	c9                   	leave  
  801c3d:	c3                   	ret    

00801c3e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801c3e:	55                   	push   %ebp
  801c3f:	89 e5                	mov    %esp,%ebp
  801c41:	83 ec 04             	sub    $0x4,%esp
  801c44:	8b 45 10             	mov    0x10(%ebp),%eax
  801c47:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801c4a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801c4d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c51:	8b 45 08             	mov    0x8(%ebp),%eax
  801c54:	6a 00                	push   $0x0
  801c56:	51                   	push   %ecx
  801c57:	52                   	push   %edx
  801c58:	ff 75 0c             	pushl  0xc(%ebp)
  801c5b:	50                   	push   %eax
  801c5c:	6a 1c                	push   $0x1c
  801c5e:	e8 b6 fc ff ff       	call   801919 <syscall>
  801c63:	83 c4 18             	add    $0x18,%esp
}
  801c66:	c9                   	leave  
  801c67:	c3                   	ret    

00801c68 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801c68:	55                   	push   %ebp
  801c69:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801c6b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	52                   	push   %edx
  801c78:	50                   	push   %eax
  801c79:	6a 1d                	push   $0x1d
  801c7b:	e8 99 fc ff ff       	call   801919 <syscall>
  801c80:	83 c4 18             	add    $0x18,%esp
}
  801c83:	c9                   	leave  
  801c84:	c3                   	ret    

00801c85 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801c85:	55                   	push   %ebp
  801c86:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801c88:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c91:	6a 00                	push   $0x0
  801c93:	6a 00                	push   $0x0
  801c95:	51                   	push   %ecx
  801c96:	52                   	push   %edx
  801c97:	50                   	push   %eax
  801c98:	6a 1e                	push   $0x1e
  801c9a:	e8 7a fc ff ff       	call   801919 <syscall>
  801c9f:	83 c4 18             	add    $0x18,%esp
}
  801ca2:	c9                   	leave  
  801ca3:	c3                   	ret    

00801ca4 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ca4:	55                   	push   %ebp
  801ca5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ca7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801caa:	8b 45 08             	mov    0x8(%ebp),%eax
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	52                   	push   %edx
  801cb4:	50                   	push   %eax
  801cb5:	6a 1f                	push   $0x1f
  801cb7:	e8 5d fc ff ff       	call   801919 <syscall>
  801cbc:	83 c4 18             	add    $0x18,%esp
}
  801cbf:	c9                   	leave  
  801cc0:	c3                   	ret    

00801cc1 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801cc1:	55                   	push   %ebp
  801cc2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 20                	push   $0x20
  801cd0:	e8 44 fc ff ff       	call   801919 <syscall>
  801cd5:	83 c4 18             	add    $0x18,%esp
}
  801cd8:	c9                   	leave  
  801cd9:	c3                   	ret    

00801cda <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801cda:	55                   	push   %ebp
  801cdb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce0:	6a 00                	push   $0x0
  801ce2:	ff 75 14             	pushl  0x14(%ebp)
  801ce5:	ff 75 10             	pushl  0x10(%ebp)
  801ce8:	ff 75 0c             	pushl  0xc(%ebp)
  801ceb:	50                   	push   %eax
  801cec:	6a 21                	push   $0x21
  801cee:	e8 26 fc ff ff       	call   801919 <syscall>
  801cf3:	83 c4 18             	add    $0x18,%esp
}
  801cf6:	c9                   	leave  
  801cf7:	c3                   	ret    

00801cf8 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801cf8:	55                   	push   %ebp
  801cf9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	6a 00                	push   $0x0
  801d04:	6a 00                	push   $0x0
  801d06:	50                   	push   %eax
  801d07:	6a 22                	push   $0x22
  801d09:	e8 0b fc ff ff       	call   801919 <syscall>
  801d0e:	83 c4 18             	add    $0x18,%esp
}
  801d11:	90                   	nop
  801d12:	c9                   	leave  
  801d13:	c3                   	ret    

00801d14 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801d14:	55                   	push   %ebp
  801d15:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801d17:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1a:	6a 00                	push   $0x0
  801d1c:	6a 00                	push   $0x0
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	50                   	push   %eax
  801d23:	6a 23                	push   $0x23
  801d25:	e8 ef fb ff ff       	call   801919 <syscall>
  801d2a:	83 c4 18             	add    $0x18,%esp
}
  801d2d:	90                   	nop
  801d2e:	c9                   	leave  
  801d2f:	c3                   	ret    

00801d30 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801d30:	55                   	push   %ebp
  801d31:	89 e5                	mov    %esp,%ebp
  801d33:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801d36:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801d39:	8d 50 04             	lea    0x4(%eax),%edx
  801d3c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	52                   	push   %edx
  801d46:	50                   	push   %eax
  801d47:	6a 24                	push   $0x24
  801d49:	e8 cb fb ff ff       	call   801919 <syscall>
  801d4e:	83 c4 18             	add    $0x18,%esp
	return result;
  801d51:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801d54:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d57:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801d5a:	89 01                	mov    %eax,(%ecx)
  801d5c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d62:	c9                   	leave  
  801d63:	c2 04 00             	ret    $0x4

00801d66 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801d66:	55                   	push   %ebp
  801d67:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801d69:	6a 00                	push   $0x0
  801d6b:	6a 00                	push   $0x0
  801d6d:	ff 75 10             	pushl  0x10(%ebp)
  801d70:	ff 75 0c             	pushl  0xc(%ebp)
  801d73:	ff 75 08             	pushl  0x8(%ebp)
  801d76:	6a 13                	push   $0x13
  801d78:	e8 9c fb ff ff       	call   801919 <syscall>
  801d7d:	83 c4 18             	add    $0x18,%esp
	return ;
  801d80:	90                   	nop
}
  801d81:	c9                   	leave  
  801d82:	c3                   	ret    

00801d83 <sys_rcr2>:
uint32 sys_rcr2()
{
  801d83:	55                   	push   %ebp
  801d84:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801d86:	6a 00                	push   $0x0
  801d88:	6a 00                	push   $0x0
  801d8a:	6a 00                	push   $0x0
  801d8c:	6a 00                	push   $0x0
  801d8e:	6a 00                	push   $0x0
  801d90:	6a 25                	push   $0x25
  801d92:	e8 82 fb ff ff       	call   801919 <syscall>
  801d97:	83 c4 18             	add    $0x18,%esp
}
  801d9a:	c9                   	leave  
  801d9b:	c3                   	ret    

00801d9c <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801d9c:	55                   	push   %ebp
  801d9d:	89 e5                	mov    %esp,%ebp
  801d9f:	83 ec 04             	sub    $0x4,%esp
  801da2:	8b 45 08             	mov    0x8(%ebp),%eax
  801da5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801da8:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801dac:	6a 00                	push   $0x0
  801dae:	6a 00                	push   $0x0
  801db0:	6a 00                	push   $0x0
  801db2:	6a 00                	push   $0x0
  801db4:	50                   	push   %eax
  801db5:	6a 26                	push   $0x26
  801db7:	e8 5d fb ff ff       	call   801919 <syscall>
  801dbc:	83 c4 18             	add    $0x18,%esp
	return ;
  801dbf:	90                   	nop
}
  801dc0:	c9                   	leave  
  801dc1:	c3                   	ret    

00801dc2 <rsttst>:
void rsttst()
{
  801dc2:	55                   	push   %ebp
  801dc3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801dc5:	6a 00                	push   $0x0
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 00                	push   $0x0
  801dcb:	6a 00                	push   $0x0
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 28                	push   $0x28
  801dd1:	e8 43 fb ff ff       	call   801919 <syscall>
  801dd6:	83 c4 18             	add    $0x18,%esp
	return ;
  801dd9:	90                   	nop
}
  801dda:	c9                   	leave  
  801ddb:	c3                   	ret    

00801ddc <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801ddc:	55                   	push   %ebp
  801ddd:	89 e5                	mov    %esp,%ebp
  801ddf:	83 ec 04             	sub    $0x4,%esp
  801de2:	8b 45 14             	mov    0x14(%ebp),%eax
  801de5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801de8:	8b 55 18             	mov    0x18(%ebp),%edx
  801deb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801def:	52                   	push   %edx
  801df0:	50                   	push   %eax
  801df1:	ff 75 10             	pushl  0x10(%ebp)
  801df4:	ff 75 0c             	pushl  0xc(%ebp)
  801df7:	ff 75 08             	pushl  0x8(%ebp)
  801dfa:	6a 27                	push   $0x27
  801dfc:	e8 18 fb ff ff       	call   801919 <syscall>
  801e01:	83 c4 18             	add    $0x18,%esp
	return ;
  801e04:	90                   	nop
}
  801e05:	c9                   	leave  
  801e06:	c3                   	ret    

00801e07 <chktst>:
void chktst(uint32 n)
{
  801e07:	55                   	push   %ebp
  801e08:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801e0a:	6a 00                	push   $0x0
  801e0c:	6a 00                	push   $0x0
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 00                	push   $0x0
  801e12:	ff 75 08             	pushl  0x8(%ebp)
  801e15:	6a 29                	push   $0x29
  801e17:	e8 fd fa ff ff       	call   801919 <syscall>
  801e1c:	83 c4 18             	add    $0x18,%esp
	return ;
  801e1f:	90                   	nop
}
  801e20:	c9                   	leave  
  801e21:	c3                   	ret    

00801e22 <inctst>:

void inctst()
{
  801e22:	55                   	push   %ebp
  801e23:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801e25:	6a 00                	push   $0x0
  801e27:	6a 00                	push   $0x0
  801e29:	6a 00                	push   $0x0
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 00                	push   $0x0
  801e2f:	6a 2a                	push   $0x2a
  801e31:	e8 e3 fa ff ff       	call   801919 <syscall>
  801e36:	83 c4 18             	add    $0x18,%esp
	return ;
  801e39:	90                   	nop
}
  801e3a:	c9                   	leave  
  801e3b:	c3                   	ret    

00801e3c <gettst>:
uint32 gettst()
{
  801e3c:	55                   	push   %ebp
  801e3d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 00                	push   $0x0
  801e43:	6a 00                	push   $0x0
  801e45:	6a 00                	push   $0x0
  801e47:	6a 00                	push   $0x0
  801e49:	6a 2b                	push   $0x2b
  801e4b:	e8 c9 fa ff ff       	call   801919 <syscall>
  801e50:	83 c4 18             	add    $0x18,%esp
}
  801e53:	c9                   	leave  
  801e54:	c3                   	ret    

00801e55 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801e55:	55                   	push   %ebp
  801e56:	89 e5                	mov    %esp,%ebp
  801e58:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 00                	push   $0x0
  801e5f:	6a 00                	push   $0x0
  801e61:	6a 00                	push   $0x0
  801e63:	6a 00                	push   $0x0
  801e65:	6a 2c                	push   $0x2c
  801e67:	e8 ad fa ff ff       	call   801919 <syscall>
  801e6c:	83 c4 18             	add    $0x18,%esp
  801e6f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801e72:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801e76:	75 07                	jne    801e7f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801e78:	b8 01 00 00 00       	mov    $0x1,%eax
  801e7d:	eb 05                	jmp    801e84 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801e7f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e84:	c9                   	leave  
  801e85:	c3                   	ret    

00801e86 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801e86:	55                   	push   %ebp
  801e87:	89 e5                	mov    %esp,%ebp
  801e89:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801e8c:	6a 00                	push   $0x0
  801e8e:	6a 00                	push   $0x0
  801e90:	6a 00                	push   $0x0
  801e92:	6a 00                	push   $0x0
  801e94:	6a 00                	push   $0x0
  801e96:	6a 2c                	push   $0x2c
  801e98:	e8 7c fa ff ff       	call   801919 <syscall>
  801e9d:	83 c4 18             	add    $0x18,%esp
  801ea0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801ea3:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801ea7:	75 07                	jne    801eb0 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801ea9:	b8 01 00 00 00       	mov    $0x1,%eax
  801eae:	eb 05                	jmp    801eb5 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801eb0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801eb5:	c9                   	leave  
  801eb6:	c3                   	ret    

00801eb7 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801eb7:	55                   	push   %ebp
  801eb8:	89 e5                	mov    %esp,%ebp
  801eba:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ebd:	6a 00                	push   $0x0
  801ebf:	6a 00                	push   $0x0
  801ec1:	6a 00                	push   $0x0
  801ec3:	6a 00                	push   $0x0
  801ec5:	6a 00                	push   $0x0
  801ec7:	6a 2c                	push   $0x2c
  801ec9:	e8 4b fa ff ff       	call   801919 <syscall>
  801ece:	83 c4 18             	add    $0x18,%esp
  801ed1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801ed4:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801ed8:	75 07                	jne    801ee1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801eda:	b8 01 00 00 00       	mov    $0x1,%eax
  801edf:	eb 05                	jmp    801ee6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ee1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ee6:	c9                   	leave  
  801ee7:	c3                   	ret    

00801ee8 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801ee8:	55                   	push   %ebp
  801ee9:	89 e5                	mov    %esp,%ebp
  801eeb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801eee:	6a 00                	push   $0x0
  801ef0:	6a 00                	push   $0x0
  801ef2:	6a 00                	push   $0x0
  801ef4:	6a 00                	push   $0x0
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 2c                	push   $0x2c
  801efa:	e8 1a fa ff ff       	call   801919 <syscall>
  801eff:	83 c4 18             	add    $0x18,%esp
  801f02:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801f05:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801f09:	75 07                	jne    801f12 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801f0b:	b8 01 00 00 00       	mov    $0x1,%eax
  801f10:	eb 05                	jmp    801f17 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801f12:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f17:	c9                   	leave  
  801f18:	c3                   	ret    

00801f19 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801f19:	55                   	push   %ebp
  801f1a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 00                	push   $0x0
  801f20:	6a 00                	push   $0x0
  801f22:	6a 00                	push   $0x0
  801f24:	ff 75 08             	pushl  0x8(%ebp)
  801f27:	6a 2d                	push   $0x2d
  801f29:	e8 eb f9 ff ff       	call   801919 <syscall>
  801f2e:	83 c4 18             	add    $0x18,%esp
	return ;
  801f31:	90                   	nop
}
  801f32:	c9                   	leave  
  801f33:	c3                   	ret    

00801f34 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801f34:	55                   	push   %ebp
  801f35:	89 e5                	mov    %esp,%ebp
  801f37:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801f38:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f3b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f41:	8b 45 08             	mov    0x8(%ebp),%eax
  801f44:	6a 00                	push   $0x0
  801f46:	53                   	push   %ebx
  801f47:	51                   	push   %ecx
  801f48:	52                   	push   %edx
  801f49:	50                   	push   %eax
  801f4a:	6a 2e                	push   $0x2e
  801f4c:	e8 c8 f9 ff ff       	call   801919 <syscall>
  801f51:	83 c4 18             	add    $0x18,%esp
}
  801f54:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801f57:	c9                   	leave  
  801f58:	c3                   	ret    

00801f59 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801f59:	55                   	push   %ebp
  801f5a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801f5c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f62:	6a 00                	push   $0x0
  801f64:	6a 00                	push   $0x0
  801f66:	6a 00                	push   $0x0
  801f68:	52                   	push   %edx
  801f69:	50                   	push   %eax
  801f6a:	6a 2f                	push   $0x2f
  801f6c:	e8 a8 f9 ff ff       	call   801919 <syscall>
  801f71:	83 c4 18             	add    $0x18,%esp
}
  801f74:	c9                   	leave  
  801f75:	c3                   	ret    

00801f76 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801f76:	55                   	push   %ebp
  801f77:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801f79:	6a 00                	push   $0x0
  801f7b:	6a 00                	push   $0x0
  801f7d:	6a 00                	push   $0x0
  801f7f:	ff 75 0c             	pushl  0xc(%ebp)
  801f82:	ff 75 08             	pushl  0x8(%ebp)
  801f85:	6a 30                	push   $0x30
  801f87:	e8 8d f9 ff ff       	call   801919 <syscall>
  801f8c:	83 c4 18             	add    $0x18,%esp
	return ;
  801f8f:	90                   	nop
}
  801f90:	c9                   	leave  
  801f91:	c3                   	ret    
  801f92:	66 90                	xchg   %ax,%ax

00801f94 <__udivdi3>:
  801f94:	55                   	push   %ebp
  801f95:	57                   	push   %edi
  801f96:	56                   	push   %esi
  801f97:	53                   	push   %ebx
  801f98:	83 ec 1c             	sub    $0x1c,%esp
  801f9b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801f9f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801fa3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801fa7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801fab:	89 ca                	mov    %ecx,%edx
  801fad:	89 f8                	mov    %edi,%eax
  801faf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801fb3:	85 f6                	test   %esi,%esi
  801fb5:	75 2d                	jne    801fe4 <__udivdi3+0x50>
  801fb7:	39 cf                	cmp    %ecx,%edi
  801fb9:	77 65                	ja     802020 <__udivdi3+0x8c>
  801fbb:	89 fd                	mov    %edi,%ebp
  801fbd:	85 ff                	test   %edi,%edi
  801fbf:	75 0b                	jne    801fcc <__udivdi3+0x38>
  801fc1:	b8 01 00 00 00       	mov    $0x1,%eax
  801fc6:	31 d2                	xor    %edx,%edx
  801fc8:	f7 f7                	div    %edi
  801fca:	89 c5                	mov    %eax,%ebp
  801fcc:	31 d2                	xor    %edx,%edx
  801fce:	89 c8                	mov    %ecx,%eax
  801fd0:	f7 f5                	div    %ebp
  801fd2:	89 c1                	mov    %eax,%ecx
  801fd4:	89 d8                	mov    %ebx,%eax
  801fd6:	f7 f5                	div    %ebp
  801fd8:	89 cf                	mov    %ecx,%edi
  801fda:	89 fa                	mov    %edi,%edx
  801fdc:	83 c4 1c             	add    $0x1c,%esp
  801fdf:	5b                   	pop    %ebx
  801fe0:	5e                   	pop    %esi
  801fe1:	5f                   	pop    %edi
  801fe2:	5d                   	pop    %ebp
  801fe3:	c3                   	ret    
  801fe4:	39 ce                	cmp    %ecx,%esi
  801fe6:	77 28                	ja     802010 <__udivdi3+0x7c>
  801fe8:	0f bd fe             	bsr    %esi,%edi
  801feb:	83 f7 1f             	xor    $0x1f,%edi
  801fee:	75 40                	jne    802030 <__udivdi3+0x9c>
  801ff0:	39 ce                	cmp    %ecx,%esi
  801ff2:	72 0a                	jb     801ffe <__udivdi3+0x6a>
  801ff4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ff8:	0f 87 9e 00 00 00    	ja     80209c <__udivdi3+0x108>
  801ffe:	b8 01 00 00 00       	mov    $0x1,%eax
  802003:	89 fa                	mov    %edi,%edx
  802005:	83 c4 1c             	add    $0x1c,%esp
  802008:	5b                   	pop    %ebx
  802009:	5e                   	pop    %esi
  80200a:	5f                   	pop    %edi
  80200b:	5d                   	pop    %ebp
  80200c:	c3                   	ret    
  80200d:	8d 76 00             	lea    0x0(%esi),%esi
  802010:	31 ff                	xor    %edi,%edi
  802012:	31 c0                	xor    %eax,%eax
  802014:	89 fa                	mov    %edi,%edx
  802016:	83 c4 1c             	add    $0x1c,%esp
  802019:	5b                   	pop    %ebx
  80201a:	5e                   	pop    %esi
  80201b:	5f                   	pop    %edi
  80201c:	5d                   	pop    %ebp
  80201d:	c3                   	ret    
  80201e:	66 90                	xchg   %ax,%ax
  802020:	89 d8                	mov    %ebx,%eax
  802022:	f7 f7                	div    %edi
  802024:	31 ff                	xor    %edi,%edi
  802026:	89 fa                	mov    %edi,%edx
  802028:	83 c4 1c             	add    $0x1c,%esp
  80202b:	5b                   	pop    %ebx
  80202c:	5e                   	pop    %esi
  80202d:	5f                   	pop    %edi
  80202e:	5d                   	pop    %ebp
  80202f:	c3                   	ret    
  802030:	bd 20 00 00 00       	mov    $0x20,%ebp
  802035:	89 eb                	mov    %ebp,%ebx
  802037:	29 fb                	sub    %edi,%ebx
  802039:	89 f9                	mov    %edi,%ecx
  80203b:	d3 e6                	shl    %cl,%esi
  80203d:	89 c5                	mov    %eax,%ebp
  80203f:	88 d9                	mov    %bl,%cl
  802041:	d3 ed                	shr    %cl,%ebp
  802043:	89 e9                	mov    %ebp,%ecx
  802045:	09 f1                	or     %esi,%ecx
  802047:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80204b:	89 f9                	mov    %edi,%ecx
  80204d:	d3 e0                	shl    %cl,%eax
  80204f:	89 c5                	mov    %eax,%ebp
  802051:	89 d6                	mov    %edx,%esi
  802053:	88 d9                	mov    %bl,%cl
  802055:	d3 ee                	shr    %cl,%esi
  802057:	89 f9                	mov    %edi,%ecx
  802059:	d3 e2                	shl    %cl,%edx
  80205b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80205f:	88 d9                	mov    %bl,%cl
  802061:	d3 e8                	shr    %cl,%eax
  802063:	09 c2                	or     %eax,%edx
  802065:	89 d0                	mov    %edx,%eax
  802067:	89 f2                	mov    %esi,%edx
  802069:	f7 74 24 0c          	divl   0xc(%esp)
  80206d:	89 d6                	mov    %edx,%esi
  80206f:	89 c3                	mov    %eax,%ebx
  802071:	f7 e5                	mul    %ebp
  802073:	39 d6                	cmp    %edx,%esi
  802075:	72 19                	jb     802090 <__udivdi3+0xfc>
  802077:	74 0b                	je     802084 <__udivdi3+0xf0>
  802079:	89 d8                	mov    %ebx,%eax
  80207b:	31 ff                	xor    %edi,%edi
  80207d:	e9 58 ff ff ff       	jmp    801fda <__udivdi3+0x46>
  802082:	66 90                	xchg   %ax,%ax
  802084:	8b 54 24 08          	mov    0x8(%esp),%edx
  802088:	89 f9                	mov    %edi,%ecx
  80208a:	d3 e2                	shl    %cl,%edx
  80208c:	39 c2                	cmp    %eax,%edx
  80208e:	73 e9                	jae    802079 <__udivdi3+0xe5>
  802090:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802093:	31 ff                	xor    %edi,%edi
  802095:	e9 40 ff ff ff       	jmp    801fda <__udivdi3+0x46>
  80209a:	66 90                	xchg   %ax,%ax
  80209c:	31 c0                	xor    %eax,%eax
  80209e:	e9 37 ff ff ff       	jmp    801fda <__udivdi3+0x46>
  8020a3:	90                   	nop

008020a4 <__umoddi3>:
  8020a4:	55                   	push   %ebp
  8020a5:	57                   	push   %edi
  8020a6:	56                   	push   %esi
  8020a7:	53                   	push   %ebx
  8020a8:	83 ec 1c             	sub    $0x1c,%esp
  8020ab:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8020af:	8b 74 24 34          	mov    0x34(%esp),%esi
  8020b3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020b7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8020bb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8020bf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8020c3:	89 f3                	mov    %esi,%ebx
  8020c5:	89 fa                	mov    %edi,%edx
  8020c7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8020cb:	89 34 24             	mov    %esi,(%esp)
  8020ce:	85 c0                	test   %eax,%eax
  8020d0:	75 1a                	jne    8020ec <__umoddi3+0x48>
  8020d2:	39 f7                	cmp    %esi,%edi
  8020d4:	0f 86 a2 00 00 00    	jbe    80217c <__umoddi3+0xd8>
  8020da:	89 c8                	mov    %ecx,%eax
  8020dc:	89 f2                	mov    %esi,%edx
  8020de:	f7 f7                	div    %edi
  8020e0:	89 d0                	mov    %edx,%eax
  8020e2:	31 d2                	xor    %edx,%edx
  8020e4:	83 c4 1c             	add    $0x1c,%esp
  8020e7:	5b                   	pop    %ebx
  8020e8:	5e                   	pop    %esi
  8020e9:	5f                   	pop    %edi
  8020ea:	5d                   	pop    %ebp
  8020eb:	c3                   	ret    
  8020ec:	39 f0                	cmp    %esi,%eax
  8020ee:	0f 87 ac 00 00 00    	ja     8021a0 <__umoddi3+0xfc>
  8020f4:	0f bd e8             	bsr    %eax,%ebp
  8020f7:	83 f5 1f             	xor    $0x1f,%ebp
  8020fa:	0f 84 ac 00 00 00    	je     8021ac <__umoddi3+0x108>
  802100:	bf 20 00 00 00       	mov    $0x20,%edi
  802105:	29 ef                	sub    %ebp,%edi
  802107:	89 fe                	mov    %edi,%esi
  802109:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80210d:	89 e9                	mov    %ebp,%ecx
  80210f:	d3 e0                	shl    %cl,%eax
  802111:	89 d7                	mov    %edx,%edi
  802113:	89 f1                	mov    %esi,%ecx
  802115:	d3 ef                	shr    %cl,%edi
  802117:	09 c7                	or     %eax,%edi
  802119:	89 e9                	mov    %ebp,%ecx
  80211b:	d3 e2                	shl    %cl,%edx
  80211d:	89 14 24             	mov    %edx,(%esp)
  802120:	89 d8                	mov    %ebx,%eax
  802122:	d3 e0                	shl    %cl,%eax
  802124:	89 c2                	mov    %eax,%edx
  802126:	8b 44 24 08          	mov    0x8(%esp),%eax
  80212a:	d3 e0                	shl    %cl,%eax
  80212c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802130:	8b 44 24 08          	mov    0x8(%esp),%eax
  802134:	89 f1                	mov    %esi,%ecx
  802136:	d3 e8                	shr    %cl,%eax
  802138:	09 d0                	or     %edx,%eax
  80213a:	d3 eb                	shr    %cl,%ebx
  80213c:	89 da                	mov    %ebx,%edx
  80213e:	f7 f7                	div    %edi
  802140:	89 d3                	mov    %edx,%ebx
  802142:	f7 24 24             	mull   (%esp)
  802145:	89 c6                	mov    %eax,%esi
  802147:	89 d1                	mov    %edx,%ecx
  802149:	39 d3                	cmp    %edx,%ebx
  80214b:	0f 82 87 00 00 00    	jb     8021d8 <__umoddi3+0x134>
  802151:	0f 84 91 00 00 00    	je     8021e8 <__umoddi3+0x144>
  802157:	8b 54 24 04          	mov    0x4(%esp),%edx
  80215b:	29 f2                	sub    %esi,%edx
  80215d:	19 cb                	sbb    %ecx,%ebx
  80215f:	89 d8                	mov    %ebx,%eax
  802161:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802165:	d3 e0                	shl    %cl,%eax
  802167:	89 e9                	mov    %ebp,%ecx
  802169:	d3 ea                	shr    %cl,%edx
  80216b:	09 d0                	or     %edx,%eax
  80216d:	89 e9                	mov    %ebp,%ecx
  80216f:	d3 eb                	shr    %cl,%ebx
  802171:	89 da                	mov    %ebx,%edx
  802173:	83 c4 1c             	add    $0x1c,%esp
  802176:	5b                   	pop    %ebx
  802177:	5e                   	pop    %esi
  802178:	5f                   	pop    %edi
  802179:	5d                   	pop    %ebp
  80217a:	c3                   	ret    
  80217b:	90                   	nop
  80217c:	89 fd                	mov    %edi,%ebp
  80217e:	85 ff                	test   %edi,%edi
  802180:	75 0b                	jne    80218d <__umoddi3+0xe9>
  802182:	b8 01 00 00 00       	mov    $0x1,%eax
  802187:	31 d2                	xor    %edx,%edx
  802189:	f7 f7                	div    %edi
  80218b:	89 c5                	mov    %eax,%ebp
  80218d:	89 f0                	mov    %esi,%eax
  80218f:	31 d2                	xor    %edx,%edx
  802191:	f7 f5                	div    %ebp
  802193:	89 c8                	mov    %ecx,%eax
  802195:	f7 f5                	div    %ebp
  802197:	89 d0                	mov    %edx,%eax
  802199:	e9 44 ff ff ff       	jmp    8020e2 <__umoddi3+0x3e>
  80219e:	66 90                	xchg   %ax,%ax
  8021a0:	89 c8                	mov    %ecx,%eax
  8021a2:	89 f2                	mov    %esi,%edx
  8021a4:	83 c4 1c             	add    $0x1c,%esp
  8021a7:	5b                   	pop    %ebx
  8021a8:	5e                   	pop    %esi
  8021a9:	5f                   	pop    %edi
  8021aa:	5d                   	pop    %ebp
  8021ab:	c3                   	ret    
  8021ac:	3b 04 24             	cmp    (%esp),%eax
  8021af:	72 06                	jb     8021b7 <__umoddi3+0x113>
  8021b1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8021b5:	77 0f                	ja     8021c6 <__umoddi3+0x122>
  8021b7:	89 f2                	mov    %esi,%edx
  8021b9:	29 f9                	sub    %edi,%ecx
  8021bb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8021bf:	89 14 24             	mov    %edx,(%esp)
  8021c2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8021c6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8021ca:	8b 14 24             	mov    (%esp),%edx
  8021cd:	83 c4 1c             	add    $0x1c,%esp
  8021d0:	5b                   	pop    %ebx
  8021d1:	5e                   	pop    %esi
  8021d2:	5f                   	pop    %edi
  8021d3:	5d                   	pop    %ebp
  8021d4:	c3                   	ret    
  8021d5:	8d 76 00             	lea    0x0(%esi),%esi
  8021d8:	2b 04 24             	sub    (%esp),%eax
  8021db:	19 fa                	sbb    %edi,%edx
  8021dd:	89 d1                	mov    %edx,%ecx
  8021df:	89 c6                	mov    %eax,%esi
  8021e1:	e9 71 ff ff ff       	jmp    802157 <__umoddi3+0xb3>
  8021e6:	66 90                	xchg   %ax,%ax
  8021e8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8021ec:	72 ea                	jb     8021d8 <__umoddi3+0x134>
  8021ee:	89 d9                	mov    %ebx,%ecx
  8021f0:	e9 62 ff ff ff       	jmp    802157 <__umoddi3+0xb3>
