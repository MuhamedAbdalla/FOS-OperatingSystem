
obj/user/tst_best_fit_1:     file format elf32-i386


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
  800031:	e8 c3 0a 00 00       	call   800af9 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* MAKE SURE PAGE_WS_MAX_SIZE = 1000 */
/* *********************************************************** */
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	83 ec 70             	sub    $0x70,%esp
	sys_set_uheap_strategy(UHP_PLACE_BESTFIT);
  800040:	83 ec 0c             	sub    $0xc,%esp
  800043:	6a 02                	push   $0x2
  800045:	e8 22 26 00 00       	call   80266c <sys_set_uheap_strategy>
  80004a:	83 c4 10             	add    $0x10,%esp

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80004d:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800051:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800058:	eb 2a                	jmp    800084 <_main+0x4c>
		{
			if (myEnv->__uptr_pws[i].empty)
  80005a:	a1 20 30 80 00       	mov    0x803020,%eax
  80005f:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800065:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800068:	89 d0                	mov    %edx,%eax
  80006a:	c1 e0 02             	shl    $0x2,%eax
  80006d:	01 d0                	add    %edx,%eax
  80006f:	c1 e0 02             	shl    $0x2,%eax
  800072:	01 c8                	add    %ecx,%eax
  800074:	8a 40 04             	mov    0x4(%eax),%al
  800077:	84 c0                	test   %al,%al
  800079:	74 06                	je     800081 <_main+0x49>
			{
				fullWS = 0;
  80007b:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  80007f:	eb 12                	jmp    800093 <_main+0x5b>
	sys_set_uheap_strategy(UHP_PLACE_BESTFIT);

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800081:	ff 45 f0             	incl   -0x10(%ebp)
  800084:	a1 20 30 80 00       	mov    0x803020,%eax
  800089:	8b 50 74             	mov    0x74(%eax),%edx
  80008c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80008f:	39 c2                	cmp    %eax,%edx
  800091:	77 c7                	ja     80005a <_main+0x22>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  800093:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800097:	74 14                	je     8000ad <_main+0x75>
  800099:	83 ec 04             	sub    $0x4,%esp
  80009c:	68 60 29 80 00       	push   $0x802960
  8000a1:	6a 15                	push   $0x15
  8000a3:	68 7c 29 80 00       	push   $0x80297c
  8000a8:	e8 74 0b 00 00       	call   800c21 <_panic>
	}

	int Mega = 1024*1024;
  8000ad:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000b4:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)
	void* ptr_allocations[20] = {0};
  8000bb:	8d 55 90             	lea    -0x70(%ebp),%edx
  8000be:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000c3:	b8 00 00 00 00       	mov    $0x0,%eax
  8000c8:	89 d7                	mov    %edx,%edi
  8000ca:	f3 ab                	rep stos %eax,%es:(%edi)
	int freeFrames ;
	int usedDiskPages;
	//[1] Allocate all
	{
		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8000cc:	e8 07 21 00 00       	call   8021d8 <sys_calculate_free_frames>
  8000d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8000d4:	e8 82 21 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  8000d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(3*Mega-kilo);
  8000dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000df:	89 c2                	mov    %eax,%edx
  8000e1:	01 d2                	add    %edx,%edx
  8000e3:	01 d0                	add    %edx,%eax
  8000e5:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000e8:	83 ec 0c             	sub    $0xc,%esp
  8000eb:	50                   	push   %eax
  8000ec:	e8 71 1b 00 00       	call   801c62 <malloc>
  8000f1:	83 c4 10             	add    $0x10,%esp
  8000f4:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  8000f7:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000fa:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8000ff:	74 14                	je     800115 <_main+0xdd>
  800101:	83 ec 04             	sub    $0x4,%esp
  800104:	68 94 29 80 00       	push   $0x802994
  800109:	6a 23                	push   $0x23
  80010b:	68 7c 29 80 00       	push   $0x80297c
  800110:	e8 0c 0b 00 00       	call   800c21 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*256) panic("Wrong page file allocation: ");
  800115:	e8 41 21 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  80011a:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80011d:	3d 00 03 00 00       	cmp    $0x300,%eax
  800122:	74 14                	je     800138 <_main+0x100>
  800124:	83 ec 04             	sub    $0x4,%esp
  800127:	68 c4 29 80 00       	push   $0x8029c4
  80012c:	6a 25                	push   $0x25
  80012e:	68 7c 29 80 00       	push   $0x80297c
  800133:	e8 e9 0a 00 00       	call   800c21 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  800138:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  80013b:	e8 98 20 00 00       	call   8021d8 <sys_calculate_free_frames>
  800140:	29 c3                	sub    %eax,%ebx
  800142:	89 d8                	mov    %ebx,%eax
  800144:	83 f8 01             	cmp    $0x1,%eax
  800147:	74 14                	je     80015d <_main+0x125>
  800149:	83 ec 04             	sub    $0x4,%esp
  80014c:	68 e1 29 80 00       	push   $0x8029e1
  800151:	6a 26                	push   $0x26
  800153:	68 7c 29 80 00       	push   $0x80297c
  800158:	e8 c4 0a 00 00       	call   800c21 <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  80015d:	e8 76 20 00 00       	call   8021d8 <sys_calculate_free_frames>
  800162:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800165:	e8 f1 20 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  80016a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(3*Mega-kilo);
  80016d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800170:	89 c2                	mov    %eax,%edx
  800172:	01 d2                	add    %edx,%edx
  800174:	01 d0                	add    %edx,%eax
  800176:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800179:	83 ec 0c             	sub    $0xc,%esp
  80017c:	50                   	push   %eax
  80017d:	e8 e0 1a 00 00       	call   801c62 <malloc>
  800182:	83 c4 10             	add    $0x10,%esp
  800185:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[1] !=  (USER_HEAP_START + 3*Mega)) panic("Wrong start address for the allocated space... ");
  800188:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80018b:	89 c1                	mov    %eax,%ecx
  80018d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800190:	89 c2                	mov    %eax,%edx
  800192:	01 d2                	add    %edx,%edx
  800194:	01 d0                	add    %edx,%eax
  800196:	05 00 00 00 80       	add    $0x80000000,%eax
  80019b:	39 c1                	cmp    %eax,%ecx
  80019d:	74 14                	je     8001b3 <_main+0x17b>
  80019f:	83 ec 04             	sub    $0x4,%esp
  8001a2:	68 94 29 80 00       	push   $0x802994
  8001a7:	6a 2c                	push   $0x2c
  8001a9:	68 7c 29 80 00       	push   $0x80297c
  8001ae:	e8 6e 0a 00 00       	call   800c21 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  3*256) panic("Wrong page file allocation: ");
  8001b3:	e8 a3 20 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  8001b8:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001bb:	3d 00 03 00 00       	cmp    $0x300,%eax
  8001c0:	74 14                	je     8001d6 <_main+0x19e>
  8001c2:	83 ec 04             	sub    $0x4,%esp
  8001c5:	68 c4 29 80 00       	push   $0x8029c4
  8001ca:	6a 2e                	push   $0x2e
  8001cc:	68 7c 29 80 00       	push   $0x80297c
  8001d1:	e8 4b 0a 00 00       	call   800c21 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  8001d6:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8001d9:	e8 fa 1f 00 00       	call   8021d8 <sys_calculate_free_frames>
  8001de:	29 c3                	sub    %eax,%ebx
  8001e0:	89 d8                	mov    %ebx,%eax
  8001e2:	83 f8 01             	cmp    $0x1,%eax
  8001e5:	74 14                	je     8001fb <_main+0x1c3>
  8001e7:	83 ec 04             	sub    $0x4,%esp
  8001ea:	68 e1 29 80 00       	push   $0x8029e1
  8001ef:	6a 2f                	push   $0x2f
  8001f1:	68 7c 29 80 00       	push   $0x80297c
  8001f6:	e8 26 0a 00 00       	call   800c21 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8001fb:	e8 d8 1f 00 00       	call   8021d8 <sys_calculate_free_frames>
  800200:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800203:	e8 53 20 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  800208:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(2*Mega-kilo);
  80020b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80020e:	01 c0                	add    %eax,%eax
  800210:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800213:	83 ec 0c             	sub    $0xc,%esp
  800216:	50                   	push   %eax
  800217:	e8 46 1a 00 00       	call   801c62 <malloc>
  80021c:	83 c4 10             	add    $0x10,%esp
  80021f:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[2] !=  (USER_HEAP_START + 6*Mega)) panic("Wrong start address for the allocated space... ");
  800222:	8b 45 98             	mov    -0x68(%ebp),%eax
  800225:	89 c1                	mov    %eax,%ecx
  800227:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80022a:	89 d0                	mov    %edx,%eax
  80022c:	01 c0                	add    %eax,%eax
  80022e:	01 d0                	add    %edx,%eax
  800230:	01 c0                	add    %eax,%eax
  800232:	05 00 00 00 80       	add    $0x80000000,%eax
  800237:	39 c1                	cmp    %eax,%ecx
  800239:	74 14                	je     80024f <_main+0x217>
  80023b:	83 ec 04             	sub    $0x4,%esp
  80023e:	68 94 29 80 00       	push   $0x802994
  800243:	6a 35                	push   $0x35
  800245:	68 7c 29 80 00       	push   $0x80297c
  80024a:	e8 d2 09 00 00       	call   800c21 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2*256) panic("Wrong page file allocation: ");
  80024f:	e8 07 20 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  800254:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800257:	3d 00 02 00 00       	cmp    $0x200,%eax
  80025c:	74 14                	je     800272 <_main+0x23a>
  80025e:	83 ec 04             	sub    $0x4,%esp
  800261:	68 c4 29 80 00       	push   $0x8029c4
  800266:	6a 37                	push   $0x37
  800268:	68 7c 29 80 00       	push   $0x80297c
  80026d:	e8 af 09 00 00       	call   800c21 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  800272:	e8 61 1f 00 00       	call   8021d8 <sys_calculate_free_frames>
  800277:	89 c2                	mov    %eax,%edx
  800279:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80027c:	39 c2                	cmp    %eax,%edx
  80027e:	74 14                	je     800294 <_main+0x25c>
  800280:	83 ec 04             	sub    $0x4,%esp
  800283:	68 e1 29 80 00       	push   $0x8029e1
  800288:	6a 38                	push   $0x38
  80028a:	68 7c 29 80 00       	push   $0x80297c
  80028f:	e8 8d 09 00 00       	call   800c21 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800294:	e8 3f 1f 00 00       	call   8021d8 <sys_calculate_free_frames>
  800299:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80029c:	e8 ba 1f 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  8002a1:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(2*Mega-kilo);
  8002a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002a7:	01 c0                	add    %eax,%eax
  8002a9:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8002ac:	83 ec 0c             	sub    $0xc,%esp
  8002af:	50                   	push   %eax
  8002b0:	e8 ad 19 00 00       	call   801c62 <malloc>
  8002b5:	83 c4 10             	add    $0x10,%esp
  8002b8:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  8002bb:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8002be:	89 c2                	mov    %eax,%edx
  8002c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002c3:	c1 e0 03             	shl    $0x3,%eax
  8002c6:	05 00 00 00 80       	add    $0x80000000,%eax
  8002cb:	39 c2                	cmp    %eax,%edx
  8002cd:	74 14                	je     8002e3 <_main+0x2ab>
  8002cf:	83 ec 04             	sub    $0x4,%esp
  8002d2:	68 94 29 80 00       	push   $0x802994
  8002d7:	6a 3e                	push   $0x3e
  8002d9:	68 7c 29 80 00       	push   $0x80297c
  8002de:	e8 3e 09 00 00       	call   800c21 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2*256) panic("Wrong page file allocation: ");
  8002e3:	e8 73 1f 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  8002e8:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8002eb:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002f0:	74 14                	je     800306 <_main+0x2ce>
  8002f2:	83 ec 04             	sub    $0x4,%esp
  8002f5:	68 c4 29 80 00       	push   $0x8029c4
  8002fa:	6a 40                	push   $0x40
  8002fc:	68 7c 29 80 00       	push   $0x80297c
  800301:	e8 1b 09 00 00       	call   800c21 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  800306:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800309:	e8 ca 1e 00 00       	call   8021d8 <sys_calculate_free_frames>
  80030e:	29 c3                	sub    %eax,%ebx
  800310:	89 d8                	mov    %ebx,%eax
  800312:	83 f8 01             	cmp    $0x1,%eax
  800315:	74 14                	je     80032b <_main+0x2f3>
  800317:	83 ec 04             	sub    $0x4,%esp
  80031a:	68 e1 29 80 00       	push   $0x8029e1
  80031f:	6a 41                	push   $0x41
  800321:	68 7c 29 80 00       	push   $0x80297c
  800326:	e8 f6 08 00 00       	call   800c21 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  80032b:	e8 a8 1e 00 00       	call   8021d8 <sys_calculate_free_frames>
  800330:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800333:	e8 23 1f 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  800338:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(1*Mega-kilo);
  80033b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80033e:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800341:	83 ec 0c             	sub    $0xc,%esp
  800344:	50                   	push   %eax
  800345:	e8 18 19 00 00       	call   801c62 <malloc>
  80034a:	83 c4 10             	add    $0x10,%esp
  80034d:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[4] !=  (USER_HEAP_START + 10*Mega) ) panic("Wrong start address for the allocated space... ");
  800350:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800353:	89 c1                	mov    %eax,%ecx
  800355:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800358:	89 d0                	mov    %edx,%eax
  80035a:	c1 e0 02             	shl    $0x2,%eax
  80035d:	01 d0                	add    %edx,%eax
  80035f:	01 c0                	add    %eax,%eax
  800361:	05 00 00 00 80       	add    $0x80000000,%eax
  800366:	39 c1                	cmp    %eax,%ecx
  800368:	74 14                	je     80037e <_main+0x346>
  80036a:	83 ec 04             	sub    $0x4,%esp
  80036d:	68 94 29 80 00       	push   $0x802994
  800372:	6a 47                	push   $0x47
  800374:	68 7c 29 80 00       	push   $0x80297c
  800379:	e8 a3 08 00 00       	call   800c21 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  80037e:	e8 d8 1e 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  800383:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800386:	3d 00 01 00 00       	cmp    $0x100,%eax
  80038b:	74 14                	je     8003a1 <_main+0x369>
  80038d:	83 ec 04             	sub    $0x4,%esp
  800390:	68 c4 29 80 00       	push   $0x8029c4
  800395:	6a 49                	push   $0x49
  800397:	68 7c 29 80 00       	push   $0x80297c
  80039c:	e8 80 08 00 00       	call   800c21 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  8003a1:	e8 32 1e 00 00       	call   8021d8 <sys_calculate_free_frames>
  8003a6:	89 c2                	mov    %eax,%edx
  8003a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8003ab:	39 c2                	cmp    %eax,%edx
  8003ad:	74 14                	je     8003c3 <_main+0x38b>
  8003af:	83 ec 04             	sub    $0x4,%esp
  8003b2:	68 e1 29 80 00       	push   $0x8029e1
  8003b7:	6a 4a                	push   $0x4a
  8003b9:	68 7c 29 80 00       	push   $0x80297c
  8003be:	e8 5e 08 00 00       	call   800c21 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8003c3:	e8 10 1e 00 00       	call   8021d8 <sys_calculate_free_frames>
  8003c8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003cb:	e8 8b 1e 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  8003d0:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(1*Mega-kilo);
  8003d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003d6:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8003d9:	83 ec 0c             	sub    $0xc,%esp
  8003dc:	50                   	push   %eax
  8003dd:	e8 80 18 00 00       	call   801c62 <malloc>
  8003e2:	83 c4 10             	add    $0x10,%esp
  8003e5:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] != (USER_HEAP_START + 11*Mega) ) panic("Wrong start address for the allocated space... ");
  8003e8:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003eb:	89 c1                	mov    %eax,%ecx
  8003ed:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003f0:	89 d0                	mov    %edx,%eax
  8003f2:	c1 e0 02             	shl    $0x2,%eax
  8003f5:	01 d0                	add    %edx,%eax
  8003f7:	01 c0                	add    %eax,%eax
  8003f9:	01 d0                	add    %edx,%eax
  8003fb:	05 00 00 00 80       	add    $0x80000000,%eax
  800400:	39 c1                	cmp    %eax,%ecx
  800402:	74 14                	je     800418 <_main+0x3e0>
  800404:	83 ec 04             	sub    $0x4,%esp
  800407:	68 94 29 80 00       	push   $0x802994
  80040c:	6a 50                	push   $0x50
  80040e:	68 7c 29 80 00       	push   $0x80297c
  800413:	e8 09 08 00 00       	call   800c21 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  800418:	e8 3e 1e 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  80041d:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800420:	3d 00 01 00 00       	cmp    $0x100,%eax
  800425:	74 14                	je     80043b <_main+0x403>
  800427:	83 ec 04             	sub    $0x4,%esp
  80042a:	68 c4 29 80 00       	push   $0x8029c4
  80042f:	6a 52                	push   $0x52
  800431:	68 7c 29 80 00       	push   $0x80297c
  800436:	e8 e6 07 00 00       	call   800c21 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80043b:	e8 98 1d 00 00       	call   8021d8 <sys_calculate_free_frames>
  800440:	89 c2                	mov    %eax,%edx
  800442:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800445:	39 c2                	cmp    %eax,%edx
  800447:	74 14                	je     80045d <_main+0x425>
  800449:	83 ec 04             	sub    $0x4,%esp
  80044c:	68 e1 29 80 00       	push   $0x8029e1
  800451:	6a 53                	push   $0x53
  800453:	68 7c 29 80 00       	push   $0x80297c
  800458:	e8 c4 07 00 00       	call   800c21 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  80045d:	e8 76 1d 00 00       	call   8021d8 <sys_calculate_free_frames>
  800462:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800465:	e8 f1 1d 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  80046a:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(1*Mega-kilo);
  80046d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800470:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800473:	83 ec 0c             	sub    $0xc,%esp
  800476:	50                   	push   %eax
  800477:	e8 e6 17 00 00       	call   801c62 <malloc>
  80047c:	83 c4 10             	add    $0x10,%esp
  80047f:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] != (USER_HEAP_START + 12*Mega) ) panic("Wrong start address for the allocated space... ");
  800482:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800485:	89 c1                	mov    %eax,%ecx
  800487:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80048a:	89 d0                	mov    %edx,%eax
  80048c:	01 c0                	add    %eax,%eax
  80048e:	01 d0                	add    %edx,%eax
  800490:	c1 e0 02             	shl    $0x2,%eax
  800493:	05 00 00 00 80       	add    $0x80000000,%eax
  800498:	39 c1                	cmp    %eax,%ecx
  80049a:	74 14                	je     8004b0 <_main+0x478>
  80049c:	83 ec 04             	sub    $0x4,%esp
  80049f:	68 94 29 80 00       	push   $0x802994
  8004a4:	6a 59                	push   $0x59
  8004a6:	68 7c 29 80 00       	push   $0x80297c
  8004ab:	e8 71 07 00 00       	call   800c21 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8004b0:	e8 a6 1d 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  8004b5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8004b8:	3d 00 01 00 00       	cmp    $0x100,%eax
  8004bd:	74 14                	je     8004d3 <_main+0x49b>
  8004bf:	83 ec 04             	sub    $0x4,%esp
  8004c2:	68 c4 29 80 00       	push   $0x8029c4
  8004c7:	6a 5b                	push   $0x5b
  8004c9:	68 7c 29 80 00       	push   $0x80297c
  8004ce:	e8 4e 07 00 00       	call   800c21 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  8004d3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8004d6:	e8 fd 1c 00 00       	call   8021d8 <sys_calculate_free_frames>
  8004db:	29 c3                	sub    %eax,%ebx
  8004dd:	89 d8                	mov    %ebx,%eax
  8004df:	83 f8 01             	cmp    $0x1,%eax
  8004e2:	74 14                	je     8004f8 <_main+0x4c0>
  8004e4:	83 ec 04             	sub    $0x4,%esp
  8004e7:	68 e1 29 80 00       	push   $0x8029e1
  8004ec:	6a 5c                	push   $0x5c
  8004ee:	68 7c 29 80 00       	push   $0x80297c
  8004f3:	e8 29 07 00 00       	call   800c21 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8004f8:	e8 db 1c 00 00       	call   8021d8 <sys_calculate_free_frames>
  8004fd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800500:	e8 56 1d 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  800505:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(1*Mega-kilo);
  800508:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80050b:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80050e:	83 ec 0c             	sub    $0xc,%esp
  800511:	50                   	push   %eax
  800512:	e8 4b 17 00 00       	call   801c62 <malloc>
  800517:	83 c4 10             	add    $0x10,%esp
  80051a:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 13*Mega)) panic("Wrong start address for the allocated space... ");
  80051d:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800520:	89 c1                	mov    %eax,%ecx
  800522:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800525:	89 d0                	mov    %edx,%eax
  800527:	01 c0                	add    %eax,%eax
  800529:	01 d0                	add    %edx,%eax
  80052b:	c1 e0 02             	shl    $0x2,%eax
  80052e:	01 d0                	add    %edx,%eax
  800530:	05 00 00 00 80       	add    $0x80000000,%eax
  800535:	39 c1                	cmp    %eax,%ecx
  800537:	74 14                	je     80054d <_main+0x515>
  800539:	83 ec 04             	sub    $0x4,%esp
  80053c:	68 94 29 80 00       	push   $0x802994
  800541:	6a 62                	push   $0x62
  800543:	68 7c 29 80 00       	push   $0x80297c
  800548:	e8 d4 06 00 00       	call   800c21 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  80054d:	e8 09 1d 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  800552:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800555:	3d 00 01 00 00       	cmp    $0x100,%eax
  80055a:	74 14                	je     800570 <_main+0x538>
  80055c:	83 ec 04             	sub    $0x4,%esp
  80055f:	68 c4 29 80 00       	push   $0x8029c4
  800564:	6a 64                	push   $0x64
  800566:	68 7c 29 80 00       	push   $0x80297c
  80056b:	e8 b1 06 00 00       	call   800c21 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800570:	e8 63 1c 00 00       	call   8021d8 <sys_calculate_free_frames>
  800575:	89 c2                	mov    %eax,%edx
  800577:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80057a:	39 c2                	cmp    %eax,%edx
  80057c:	74 14                	je     800592 <_main+0x55a>
  80057e:	83 ec 04             	sub    $0x4,%esp
  800581:	68 e1 29 80 00       	push   $0x8029e1
  800586:	6a 65                	push   $0x65
  800588:	68 7c 29 80 00       	push   $0x80297c
  80058d:	e8 8f 06 00 00       	call   800c21 <_panic>
	}

	//[2] Free some to create holes
	{
		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800592:	e8 41 1c 00 00       	call   8021d8 <sys_calculate_free_frames>
  800597:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80059a:	e8 bc 1c 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  80059f:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  8005a2:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8005a5:	83 ec 0c             	sub    $0xc,%esp
  8005a8:	50                   	push   %eax
  8005a9:	e8 79 19 00 00       	call   801f27 <free>
  8005ae:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  3*256) panic("Wrong page file free: ");
  8005b1:	e8 a5 1c 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  8005b6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005b9:	29 c2                	sub    %eax,%edx
  8005bb:	89 d0                	mov    %edx,%eax
  8005bd:	3d 00 03 00 00       	cmp    $0x300,%eax
  8005c2:	74 14                	je     8005d8 <_main+0x5a0>
  8005c4:	83 ec 04             	sub    $0x4,%esp
  8005c7:	68 f4 29 80 00       	push   $0x8029f4
  8005cc:	6a 6f                	push   $0x6f
  8005ce:	68 7c 29 80 00       	push   $0x80297c
  8005d3:	e8 49 06 00 00       	call   800c21 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8005d8:	e8 fb 1b 00 00       	call   8021d8 <sys_calculate_free_frames>
  8005dd:	89 c2                	mov    %eax,%edx
  8005df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005e2:	39 c2                	cmp    %eax,%edx
  8005e4:	74 14                	je     8005fa <_main+0x5c2>
  8005e6:	83 ec 04             	sub    $0x4,%esp
  8005e9:	68 0b 2a 80 00       	push   $0x802a0b
  8005ee:	6a 70                	push   $0x70
  8005f0:	68 7c 29 80 00       	push   $0x80297c
  8005f5:	e8 27 06 00 00       	call   800c21 <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005fa:	e8 d9 1b 00 00       	call   8021d8 <sys_calculate_free_frames>
  8005ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800602:	e8 54 1c 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  800607:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[3]);
  80060a:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80060d:	83 ec 0c             	sub    $0xc,%esp
  800610:	50                   	push   %eax
  800611:	e8 11 19 00 00       	call   801f27 <free>
  800616:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  2*256) panic("Wrong page file free: ");
  800619:	e8 3d 1c 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  80061e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800621:	29 c2                	sub    %eax,%edx
  800623:	89 d0                	mov    %edx,%eax
  800625:	3d 00 02 00 00       	cmp    $0x200,%eax
  80062a:	74 14                	je     800640 <_main+0x608>
  80062c:	83 ec 04             	sub    $0x4,%esp
  80062f:	68 f4 29 80 00       	push   $0x8029f4
  800634:	6a 77                	push   $0x77
  800636:	68 7c 29 80 00       	push   $0x80297c
  80063b:	e8 e1 05 00 00       	call   800c21 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800640:	e8 93 1b 00 00       	call   8021d8 <sys_calculate_free_frames>
  800645:	89 c2                	mov    %eax,%edx
  800647:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80064a:	39 c2                	cmp    %eax,%edx
  80064c:	74 14                	je     800662 <_main+0x62a>
  80064e:	83 ec 04             	sub    $0x4,%esp
  800651:	68 0b 2a 80 00       	push   $0x802a0b
  800656:	6a 78                	push   $0x78
  800658:	68 7c 29 80 00       	push   $0x80297c
  80065d:	e8 bf 05 00 00       	call   800c21 <_panic>

		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800662:	e8 71 1b 00 00       	call   8021d8 <sys_calculate_free_frames>
  800667:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80066a:	e8 ec 1b 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  80066f:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[5]);
  800672:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800675:	83 ec 0c             	sub    $0xc,%esp
  800678:	50                   	push   %eax
  800679:	e8 a9 18 00 00       	call   801f27 <free>
  80067e:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800681:	e8 d5 1b 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  800686:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800689:	29 c2                	sub    %eax,%edx
  80068b:	89 d0                	mov    %edx,%eax
  80068d:	3d 00 01 00 00       	cmp    $0x100,%eax
  800692:	74 14                	je     8006a8 <_main+0x670>
  800694:	83 ec 04             	sub    $0x4,%esp
  800697:	68 f4 29 80 00       	push   $0x8029f4
  80069c:	6a 7f                	push   $0x7f
  80069e:	68 7c 29 80 00       	push   $0x80297c
  8006a3:	e8 79 05 00 00       	call   800c21 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8006a8:	e8 2b 1b 00 00       	call   8021d8 <sys_calculate_free_frames>
  8006ad:	89 c2                	mov    %eax,%edx
  8006af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006b2:	39 c2                	cmp    %eax,%edx
  8006b4:	74 17                	je     8006cd <_main+0x695>
  8006b6:	83 ec 04             	sub    $0x4,%esp
  8006b9:	68 0b 2a 80 00       	push   $0x802a0b
  8006be:	68 80 00 00 00       	push   $0x80
  8006c3:	68 7c 29 80 00       	push   $0x80297c
  8006c8:	e8 54 05 00 00       	call   800c21 <_panic>
	}

	//[3] Allocate again [test best fit]
	{
		//Allocate 512 KB - should be placed in 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  8006cd:	e8 06 1b 00 00       	call   8021d8 <sys_calculate_free_frames>
  8006d2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8006d5:	e8 81 1b 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  8006da:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(512*kilo);
  8006dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006e0:	c1 e0 09             	shl    $0x9,%eax
  8006e3:	83 ec 0c             	sub    $0xc,%esp
  8006e6:	50                   	push   %eax
  8006e7:	e8 76 15 00 00       	call   801c62 <malloc>
  8006ec:	83 c4 10             	add    $0x10,%esp
  8006ef:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[8] !=  (USER_HEAP_START + 11*Mega)) panic("Wrong start address for the allocated space... ");
  8006f2:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8006f5:	89 c1                	mov    %eax,%ecx
  8006f7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8006fa:	89 d0                	mov    %edx,%eax
  8006fc:	c1 e0 02             	shl    $0x2,%eax
  8006ff:	01 d0                	add    %edx,%eax
  800701:	01 c0                	add    %eax,%eax
  800703:	01 d0                	add    %edx,%eax
  800705:	05 00 00 00 80       	add    $0x80000000,%eax
  80070a:	39 c1                	cmp    %eax,%ecx
  80070c:	74 17                	je     800725 <_main+0x6ed>
  80070e:	83 ec 04             	sub    $0x4,%esp
  800711:	68 94 29 80 00       	push   $0x802994
  800716:	68 89 00 00 00       	push   $0x89
  80071b:	68 7c 29 80 00       	push   $0x80297c
  800720:	e8 fc 04 00 00       	call   800c21 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 128) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  128) panic("Wrong page file allocation: ");
  800725:	e8 31 1b 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  80072a:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80072d:	3d 80 00 00 00       	cmp    $0x80,%eax
  800732:	74 17                	je     80074b <_main+0x713>
  800734:	83 ec 04             	sub    $0x4,%esp
  800737:	68 c4 29 80 00       	push   $0x8029c4
  80073c:	68 8b 00 00 00       	push   $0x8b
  800741:	68 7c 29 80 00       	push   $0x80297c
  800746:	e8 d6 04 00 00       	call   800c21 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80074b:	e8 88 1a 00 00       	call   8021d8 <sys_calculate_free_frames>
  800750:	89 c2                	mov    %eax,%edx
  800752:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800755:	39 c2                	cmp    %eax,%edx
  800757:	74 17                	je     800770 <_main+0x738>
  800759:	83 ec 04             	sub    $0x4,%esp
  80075c:	68 e1 29 80 00       	push   $0x8029e1
  800761:	68 8c 00 00 00       	push   $0x8c
  800766:	68 7c 29 80 00       	push   $0x80297c
  80076b:	e8 b1 04 00 00       	call   800c21 <_panic>
		//Allocate 1 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
  800770:	e8 63 1a 00 00       	call   8021d8 <sys_calculate_free_frames>
  800775:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800778:	e8 de 1a 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  80077d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[9] = malloc(1*Mega - kilo);
  800780:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800783:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800786:	83 ec 0c             	sub    $0xc,%esp
  800789:	50                   	push   %eax
  80078a:	e8 d3 14 00 00       	call   801c62 <malloc>
  80078f:	83 c4 10             	add    $0x10,%esp
  800792:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  800795:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800798:	89 c2                	mov    %eax,%edx
  80079a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80079d:	c1 e0 03             	shl    $0x3,%eax
  8007a0:	05 00 00 00 80       	add    $0x80000000,%eax
  8007a5:	39 c2                	cmp    %eax,%edx
  8007a7:	74 17                	je     8007c0 <_main+0x788>
  8007a9:	83 ec 04             	sub    $0x4,%esp
  8007ac:	68 94 29 80 00       	push   $0x802994
  8007b1:	68 91 00 00 00       	push   $0x91
  8007b6:	68 7c 29 80 00       	push   $0x80297c
  8007bb:	e8 61 04 00 00       	call   800c21 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8007c0:	e8 96 1a 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  8007c5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8007c8:	3d 00 01 00 00       	cmp    $0x100,%eax
  8007cd:	74 17                	je     8007e6 <_main+0x7ae>
  8007cf:	83 ec 04             	sub    $0x4,%esp
  8007d2:	68 c4 29 80 00       	push   $0x8029c4
  8007d7:	68 93 00 00 00       	push   $0x93
  8007dc:	68 7c 29 80 00       	push   $0x80297c
  8007e1:	e8 3b 04 00 00       	call   800c21 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  8007e6:	e8 ed 19 00 00       	call   8021d8 <sys_calculate_free_frames>
  8007eb:	89 c2                	mov    %eax,%edx
  8007ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8007f0:	39 c2                	cmp    %eax,%edx
  8007f2:	74 17                	je     80080b <_main+0x7d3>
  8007f4:	83 ec 04             	sub    $0x4,%esp
  8007f7:	68 e1 29 80 00       	push   $0x8029e1
  8007fc:	68 94 00 00 00       	push   $0x94
  800801:	68 7c 29 80 00       	push   $0x80297c
  800806:	e8 16 04 00 00       	call   800c21 <_panic>

		//Allocate 256 KB - should be placed in remaining of 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  80080b:	e8 c8 19 00 00       	call   8021d8 <sys_calculate_free_frames>
  800810:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800813:	e8 43 1a 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  800818:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[10] = malloc(256*kilo - kilo);
  80081b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80081e:	89 d0                	mov    %edx,%eax
  800820:	c1 e0 08             	shl    $0x8,%eax
  800823:	29 d0                	sub    %edx,%eax
  800825:	83 ec 0c             	sub    $0xc,%esp
  800828:	50                   	push   %eax
  800829:	e8 34 14 00 00       	call   801c62 <malloc>
  80082e:	83 c4 10             	add    $0x10,%esp
  800831:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if ((uint32) ptr_allocations[10] !=  (USER_HEAP_START + 11*Mega + 512*kilo)) panic("Wrong start address for the allocated space... ");
  800834:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800837:	89 c1                	mov    %eax,%ecx
  800839:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80083c:	89 d0                	mov    %edx,%eax
  80083e:	c1 e0 02             	shl    $0x2,%eax
  800841:	01 d0                	add    %edx,%eax
  800843:	01 c0                	add    %eax,%eax
  800845:	01 d0                	add    %edx,%eax
  800847:	89 c2                	mov    %eax,%edx
  800849:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80084c:	c1 e0 09             	shl    $0x9,%eax
  80084f:	01 d0                	add    %edx,%eax
  800851:	05 00 00 00 80       	add    $0x80000000,%eax
  800856:	39 c1                	cmp    %eax,%ecx
  800858:	74 17                	je     800871 <_main+0x839>
  80085a:	83 ec 04             	sub    $0x4,%esp
  80085d:	68 94 29 80 00       	push   $0x802994
  800862:	68 9a 00 00 00       	push   $0x9a
  800867:	68 7c 29 80 00       	push   $0x80297c
  80086c:	e8 b0 03 00 00       	call   800c21 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 64) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  64) panic("Wrong page file allocation: ");
  800871:	e8 e5 19 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  800876:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800879:	83 f8 40             	cmp    $0x40,%eax
  80087c:	74 17                	je     800895 <_main+0x85d>
  80087e:	83 ec 04             	sub    $0x4,%esp
  800881:	68 c4 29 80 00       	push   $0x8029c4
  800886:	68 9c 00 00 00       	push   $0x9c
  80088b:	68 7c 29 80 00       	push   $0x80297c
  800890:	e8 8c 03 00 00       	call   800c21 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800895:	e8 3e 19 00 00       	call   8021d8 <sys_calculate_free_frames>
  80089a:	89 c2                	mov    %eax,%edx
  80089c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80089f:	39 c2                	cmp    %eax,%edx
  8008a1:	74 17                	je     8008ba <_main+0x882>
  8008a3:	83 ec 04             	sub    $0x4,%esp
  8008a6:	68 e1 29 80 00       	push   $0x8029e1
  8008ab:	68 9d 00 00 00       	push   $0x9d
  8008b0:	68 7c 29 80 00       	push   $0x80297c
  8008b5:	e8 67 03 00 00       	call   800c21 <_panic>

		//Allocate 4 MB - should be placed in end of all allocations
		freeFrames = sys_calculate_free_frames() ;
  8008ba:	e8 19 19 00 00       	call   8021d8 <sys_calculate_free_frames>
  8008bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8008c2:	e8 94 19 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  8008c7:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[11] = malloc(4*Mega - kilo);
  8008ca:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008cd:	c1 e0 02             	shl    $0x2,%eax
  8008d0:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8008d3:	83 ec 0c             	sub    $0xc,%esp
  8008d6:	50                   	push   %eax
  8008d7:	e8 86 13 00 00       	call   801c62 <malloc>
  8008dc:	83 c4 10             	add    $0x10,%esp
  8008df:	89 45 bc             	mov    %eax,-0x44(%ebp)
		if ((uint32) ptr_allocations[11] != (USER_HEAP_START + 14*Mega)) panic("Wrong start address for the allocated space... ");
  8008e2:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8008e5:	89 c1                	mov    %eax,%ecx
  8008e7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8008ea:	89 d0                	mov    %edx,%eax
  8008ec:	01 c0                	add    %eax,%eax
  8008ee:	01 d0                	add    %edx,%eax
  8008f0:	01 c0                	add    %eax,%eax
  8008f2:	01 d0                	add    %edx,%eax
  8008f4:	01 c0                	add    %eax,%eax
  8008f6:	05 00 00 00 80       	add    $0x80000000,%eax
  8008fb:	39 c1                	cmp    %eax,%ecx
  8008fd:	74 17                	je     800916 <_main+0x8de>
  8008ff:	83 ec 04             	sub    $0x4,%esp
  800902:	68 94 29 80 00       	push   $0x802994
  800907:	68 a3 00 00 00       	push   $0xa3
  80090c:	68 7c 29 80 00       	push   $0x80297c
  800911:	e8 0b 03 00 00       	call   800c21 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1024 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1024) panic("Wrong page file allocation: ");
  800916:	e8 40 19 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  80091b:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80091e:	3d 00 04 00 00       	cmp    $0x400,%eax
  800923:	74 17                	je     80093c <_main+0x904>
  800925:	83 ec 04             	sub    $0x4,%esp
  800928:	68 c4 29 80 00       	push   $0x8029c4
  80092d:	68 a5 00 00 00       	push   $0xa5
  800932:	68 7c 29 80 00       	push   $0x80297c
  800937:	e8 e5 02 00 00       	call   800c21 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  80093c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  80093f:	e8 94 18 00 00       	call   8021d8 <sys_calculate_free_frames>
  800944:	29 c3                	sub    %eax,%ebx
  800946:	89 d8                	mov    %ebx,%eax
  800948:	83 f8 01             	cmp    $0x1,%eax
  80094b:	74 17                	je     800964 <_main+0x92c>
  80094d:	83 ec 04             	sub    $0x4,%esp
  800950:	68 e1 29 80 00       	push   $0x8029e1
  800955:	68 a6 00 00 00       	push   $0xa6
  80095a:	68 7c 29 80 00       	push   $0x80297c
  80095f:	e8 bd 02 00 00       	call   800c21 <_panic>
	}

	//[4] Free contiguous allocations
	{
		//1M Hole appended to already existing 1M hole in the middle
		freeFrames = sys_calculate_free_frames() ;
  800964:	e8 6f 18 00 00       	call   8021d8 <sys_calculate_free_frames>
  800969:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80096c:	e8 ea 18 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  800971:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[4]);
  800974:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800977:	83 ec 0c             	sub    $0xc,%esp
  80097a:	50                   	push   %eax
  80097b:	e8 a7 15 00 00       	call   801f27 <free>
  800980:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800983:	e8 d3 18 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  800988:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80098b:	29 c2                	sub    %eax,%edx
  80098d:	89 d0                	mov    %edx,%eax
  80098f:	3d 00 01 00 00       	cmp    $0x100,%eax
  800994:	74 17                	je     8009ad <_main+0x975>
  800996:	83 ec 04             	sub    $0x4,%esp
  800999:	68 f4 29 80 00       	push   $0x8029f4
  80099e:	68 b0 00 00 00       	push   $0xb0
  8009a3:	68 7c 29 80 00       	push   $0x80297c
  8009a8:	e8 74 02 00 00       	call   800c21 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8009ad:	e8 26 18 00 00       	call   8021d8 <sys_calculate_free_frames>
  8009b2:	89 c2                	mov    %eax,%edx
  8009b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8009b7:	39 c2                	cmp    %eax,%edx
  8009b9:	74 17                	je     8009d2 <_main+0x99a>
  8009bb:	83 ec 04             	sub    $0x4,%esp
  8009be:	68 0b 2a 80 00       	push   $0x802a0b
  8009c3:	68 b1 00 00 00       	push   $0xb1
  8009c8:	68 7c 29 80 00       	push   $0x80297c
  8009cd:	e8 4f 02 00 00       	call   800c21 <_panic>

		//another 512 KB Hole appended to the hole
		freeFrames = sys_calculate_free_frames() ;
  8009d2:	e8 01 18 00 00       	call   8021d8 <sys_calculate_free_frames>
  8009d7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8009da:	e8 7c 18 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  8009df:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[8]);
  8009e2:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8009e5:	83 ec 0c             	sub    $0xc,%esp
  8009e8:	50                   	push   %eax
  8009e9:	e8 39 15 00 00       	call   801f27 <free>
  8009ee:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  128) panic("Wrong page file free: ");
  8009f1:	e8 65 18 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  8009f6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009f9:	29 c2                	sub    %eax,%edx
  8009fb:	89 d0                	mov    %edx,%eax
  8009fd:	3d 80 00 00 00       	cmp    $0x80,%eax
  800a02:	74 17                	je     800a1b <_main+0x9e3>
  800a04:	83 ec 04             	sub    $0x4,%esp
  800a07:	68 f4 29 80 00       	push   $0x8029f4
  800a0c:	68 b8 00 00 00       	push   $0xb8
  800a11:	68 7c 29 80 00       	push   $0x80297c
  800a16:	e8 06 02 00 00       	call   800c21 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a1b:	e8 b8 17 00 00       	call   8021d8 <sys_calculate_free_frames>
  800a20:	89 c2                	mov    %eax,%edx
  800a22:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a25:	39 c2                	cmp    %eax,%edx
  800a27:	74 17                	je     800a40 <_main+0xa08>
  800a29:	83 ec 04             	sub    $0x4,%esp
  800a2c:	68 0b 2a 80 00       	push   $0x802a0b
  800a31:	68 b9 00 00 00       	push   $0xb9
  800a36:	68 7c 29 80 00       	push   $0x80297c
  800a3b:	e8 e1 01 00 00       	call   800c21 <_panic>
	}

	//[5] Allocate again [test best fit]
	{
		//Allocate 2 MB - should be placed in the contiguous hole (2 MB + 512 KB)
		freeFrames = sys_calculate_free_frames();
  800a40:	e8 93 17 00 00       	call   8021d8 <sys_calculate_free_frames>
  800a45:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800a48:	e8 0e 18 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  800a4d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[12] = malloc(2*Mega - kilo);
  800a50:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a53:	01 c0                	add    %eax,%eax
  800a55:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800a58:	83 ec 0c             	sub    $0xc,%esp
  800a5b:	50                   	push   %eax
  800a5c:	e8 01 12 00 00       	call   801c62 <malloc>
  800a61:	83 c4 10             	add    $0x10,%esp
  800a64:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if ((uint32) ptr_allocations[12] != (USER_HEAP_START + 9*Mega)) panic("Wrong start address for the allocated space... ");
  800a67:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800a6a:	89 c1                	mov    %eax,%ecx
  800a6c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800a6f:	89 d0                	mov    %edx,%eax
  800a71:	c1 e0 03             	shl    $0x3,%eax
  800a74:	01 d0                	add    %edx,%eax
  800a76:	05 00 00 00 80       	add    $0x80000000,%eax
  800a7b:	39 c1                	cmp    %eax,%ecx
  800a7d:	74 17                	je     800a96 <_main+0xa5e>
  800a7f:	83 ec 04             	sub    $0x4,%esp
  800a82:	68 94 29 80 00       	push   $0x802994
  800a87:	68 c2 00 00 00       	push   $0xc2
  800a8c:	68 7c 29 80 00       	push   $0x80297c
  800a91:	e8 8b 01 00 00       	call   800c21 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+32) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  2*256) panic("Wrong page file allocation: ");
  800a96:	e8 c0 17 00 00       	call   80225b <sys_pf_calculate_allocated_pages>
  800a9b:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800a9e:	3d 00 02 00 00       	cmp    $0x200,%eax
  800aa3:	74 17                	je     800abc <_main+0xa84>
  800aa5:	83 ec 04             	sub    $0x4,%esp
  800aa8:	68 c4 29 80 00       	push   $0x8029c4
  800aad:	68 c4 00 00 00       	push   $0xc4
  800ab2:	68 7c 29 80 00       	push   $0x80297c
  800ab7:	e8 65 01 00 00       	call   800c21 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800abc:	e8 17 17 00 00       	call   8021d8 <sys_calculate_free_frames>
  800ac1:	89 c2                	mov    %eax,%edx
  800ac3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800ac6:	39 c2                	cmp    %eax,%edx
  800ac8:	74 17                	je     800ae1 <_main+0xaa9>
  800aca:	83 ec 04             	sub    $0x4,%esp
  800acd:	68 e1 29 80 00       	push   $0x8029e1
  800ad2:	68 c5 00 00 00       	push   $0xc5
  800ad7:	68 7c 29 80 00       	push   $0x80297c
  800adc:	e8 40 01 00 00       	call   800c21 <_panic>
	}
	cprintf("Congratulations!! test BEST FIT allocation (1) completed successfully.\n");
  800ae1:	83 ec 0c             	sub    $0xc,%esp
  800ae4:	68 18 2a 80 00       	push   $0x802a18
  800ae9:	e8 ea 03 00 00       	call   800ed8 <cprintf>
  800aee:	83 c4 10             	add    $0x10,%esp

	return;
  800af1:	90                   	nop
}
  800af2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800af5:	5b                   	pop    %ebx
  800af6:	5f                   	pop    %edi
  800af7:	5d                   	pop    %ebp
  800af8:	c3                   	ret    

00800af9 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800af9:	55                   	push   %ebp
  800afa:	89 e5                	mov    %esp,%ebp
  800afc:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800aff:	e8 09 16 00 00       	call   80210d <sys_getenvindex>
  800b04:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800b07:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b0a:	89 d0                	mov    %edx,%eax
  800b0c:	01 c0                	add    %eax,%eax
  800b0e:	01 d0                	add    %edx,%eax
  800b10:	c1 e0 07             	shl    $0x7,%eax
  800b13:	29 d0                	sub    %edx,%eax
  800b15:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800b1c:	01 c8                	add    %ecx,%eax
  800b1e:	01 c0                	add    %eax,%eax
  800b20:	01 d0                	add    %edx,%eax
  800b22:	01 c0                	add    %eax,%eax
  800b24:	01 d0                	add    %edx,%eax
  800b26:	c1 e0 03             	shl    $0x3,%eax
  800b29:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800b2e:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800b33:	a1 20 30 80 00       	mov    0x803020,%eax
  800b38:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  800b3e:	84 c0                	test   %al,%al
  800b40:	74 0f                	je     800b51 <libmain+0x58>
		binaryname = myEnv->prog_name;
  800b42:	a1 20 30 80 00       	mov    0x803020,%eax
  800b47:	05 f0 ee 00 00       	add    $0xeef0,%eax
  800b4c:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800b51:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b55:	7e 0a                	jle    800b61 <libmain+0x68>
		binaryname = argv[0];
  800b57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5a:	8b 00                	mov    (%eax),%eax
  800b5c:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800b61:	83 ec 08             	sub    $0x8,%esp
  800b64:	ff 75 0c             	pushl  0xc(%ebp)
  800b67:	ff 75 08             	pushl  0x8(%ebp)
  800b6a:	e8 c9 f4 ff ff       	call   800038 <_main>
  800b6f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800b72:	e8 31 17 00 00       	call   8022a8 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800b77:	83 ec 0c             	sub    $0xc,%esp
  800b7a:	68 78 2a 80 00       	push   $0x802a78
  800b7f:	e8 54 03 00 00       	call   800ed8 <cprintf>
  800b84:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800b87:	a1 20 30 80 00       	mov    0x803020,%eax
  800b8c:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  800b92:	a1 20 30 80 00       	mov    0x803020,%eax
  800b97:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  800b9d:	83 ec 04             	sub    $0x4,%esp
  800ba0:	52                   	push   %edx
  800ba1:	50                   	push   %eax
  800ba2:	68 a0 2a 80 00       	push   $0x802aa0
  800ba7:	e8 2c 03 00 00       	call   800ed8 <cprintf>
  800bac:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800baf:	a1 20 30 80 00       	mov    0x803020,%eax
  800bb4:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  800bba:	a1 20 30 80 00       	mov    0x803020,%eax
  800bbf:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  800bc5:	a1 20 30 80 00       	mov    0x803020,%eax
  800bca:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  800bd0:	51                   	push   %ecx
  800bd1:	52                   	push   %edx
  800bd2:	50                   	push   %eax
  800bd3:	68 c8 2a 80 00       	push   $0x802ac8
  800bd8:	e8 fb 02 00 00       	call   800ed8 <cprintf>
  800bdd:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800be0:	83 ec 0c             	sub    $0xc,%esp
  800be3:	68 78 2a 80 00       	push   $0x802a78
  800be8:	e8 eb 02 00 00       	call   800ed8 <cprintf>
  800bed:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800bf0:	e8 cd 16 00 00       	call   8022c2 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800bf5:	e8 19 00 00 00       	call   800c13 <exit>
}
  800bfa:	90                   	nop
  800bfb:	c9                   	leave  
  800bfc:	c3                   	ret    

00800bfd <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800bfd:	55                   	push   %ebp
  800bfe:	89 e5                	mov    %esp,%ebp
  800c00:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800c03:	83 ec 0c             	sub    $0xc,%esp
  800c06:	6a 00                	push   $0x0
  800c08:	e8 cc 14 00 00       	call   8020d9 <sys_env_destroy>
  800c0d:	83 c4 10             	add    $0x10,%esp
}
  800c10:	90                   	nop
  800c11:	c9                   	leave  
  800c12:	c3                   	ret    

00800c13 <exit>:

void
exit(void)
{
  800c13:	55                   	push   %ebp
  800c14:	89 e5                	mov    %esp,%ebp
  800c16:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800c19:	e8 21 15 00 00       	call   80213f <sys_env_exit>
}
  800c1e:	90                   	nop
  800c1f:	c9                   	leave  
  800c20:	c3                   	ret    

00800c21 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800c21:	55                   	push   %ebp
  800c22:	89 e5                	mov    %esp,%ebp
  800c24:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800c27:	8d 45 10             	lea    0x10(%ebp),%eax
  800c2a:	83 c0 04             	add    $0x4,%eax
  800c2d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800c30:	a1 18 31 80 00       	mov    0x803118,%eax
  800c35:	85 c0                	test   %eax,%eax
  800c37:	74 16                	je     800c4f <_panic+0x2e>
		cprintf("%s: ", argv0);
  800c39:	a1 18 31 80 00       	mov    0x803118,%eax
  800c3e:	83 ec 08             	sub    $0x8,%esp
  800c41:	50                   	push   %eax
  800c42:	68 20 2b 80 00       	push   $0x802b20
  800c47:	e8 8c 02 00 00       	call   800ed8 <cprintf>
  800c4c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800c4f:	a1 00 30 80 00       	mov    0x803000,%eax
  800c54:	ff 75 0c             	pushl  0xc(%ebp)
  800c57:	ff 75 08             	pushl  0x8(%ebp)
  800c5a:	50                   	push   %eax
  800c5b:	68 25 2b 80 00       	push   $0x802b25
  800c60:	e8 73 02 00 00       	call   800ed8 <cprintf>
  800c65:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800c68:	8b 45 10             	mov    0x10(%ebp),%eax
  800c6b:	83 ec 08             	sub    $0x8,%esp
  800c6e:	ff 75 f4             	pushl  -0xc(%ebp)
  800c71:	50                   	push   %eax
  800c72:	e8 f6 01 00 00       	call   800e6d <vcprintf>
  800c77:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800c7a:	83 ec 08             	sub    $0x8,%esp
  800c7d:	6a 00                	push   $0x0
  800c7f:	68 41 2b 80 00       	push   $0x802b41
  800c84:	e8 e4 01 00 00       	call   800e6d <vcprintf>
  800c89:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800c8c:	e8 82 ff ff ff       	call   800c13 <exit>

	// should not return here
	while (1) ;
  800c91:	eb fe                	jmp    800c91 <_panic+0x70>

00800c93 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800c93:	55                   	push   %ebp
  800c94:	89 e5                	mov    %esp,%ebp
  800c96:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800c99:	a1 20 30 80 00       	mov    0x803020,%eax
  800c9e:	8b 50 74             	mov    0x74(%eax),%edx
  800ca1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca4:	39 c2                	cmp    %eax,%edx
  800ca6:	74 14                	je     800cbc <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800ca8:	83 ec 04             	sub    $0x4,%esp
  800cab:	68 44 2b 80 00       	push   $0x802b44
  800cb0:	6a 26                	push   $0x26
  800cb2:	68 90 2b 80 00       	push   $0x802b90
  800cb7:	e8 65 ff ff ff       	call   800c21 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800cbc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800cc3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800cca:	e9 c4 00 00 00       	jmp    800d93 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800ccf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cd2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800cd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdc:	01 d0                	add    %edx,%eax
  800cde:	8b 00                	mov    (%eax),%eax
  800ce0:	85 c0                	test   %eax,%eax
  800ce2:	75 08                	jne    800cec <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800ce4:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800ce7:	e9 a4 00 00 00       	jmp    800d90 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  800cec:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800cf3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800cfa:	eb 6b                	jmp    800d67 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800cfc:	a1 20 30 80 00       	mov    0x803020,%eax
  800d01:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800d07:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d0a:	89 d0                	mov    %edx,%eax
  800d0c:	c1 e0 02             	shl    $0x2,%eax
  800d0f:	01 d0                	add    %edx,%eax
  800d11:	c1 e0 02             	shl    $0x2,%eax
  800d14:	01 c8                	add    %ecx,%eax
  800d16:	8a 40 04             	mov    0x4(%eax),%al
  800d19:	84 c0                	test   %al,%al
  800d1b:	75 47                	jne    800d64 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800d1d:	a1 20 30 80 00       	mov    0x803020,%eax
  800d22:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800d28:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d2b:	89 d0                	mov    %edx,%eax
  800d2d:	c1 e0 02             	shl    $0x2,%eax
  800d30:	01 d0                	add    %edx,%eax
  800d32:	c1 e0 02             	shl    $0x2,%eax
  800d35:	01 c8                	add    %ecx,%eax
  800d37:	8b 00                	mov    (%eax),%eax
  800d39:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800d3c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800d3f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d44:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800d46:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d49:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800d50:	8b 45 08             	mov    0x8(%ebp),%eax
  800d53:	01 c8                	add    %ecx,%eax
  800d55:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800d57:	39 c2                	cmp    %eax,%edx
  800d59:	75 09                	jne    800d64 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800d5b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800d62:	eb 12                	jmp    800d76 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800d64:	ff 45 e8             	incl   -0x18(%ebp)
  800d67:	a1 20 30 80 00       	mov    0x803020,%eax
  800d6c:	8b 50 74             	mov    0x74(%eax),%edx
  800d6f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800d72:	39 c2                	cmp    %eax,%edx
  800d74:	77 86                	ja     800cfc <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800d76:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800d7a:	75 14                	jne    800d90 <CheckWSWithoutLastIndex+0xfd>
			panic(
  800d7c:	83 ec 04             	sub    $0x4,%esp
  800d7f:	68 9c 2b 80 00       	push   $0x802b9c
  800d84:	6a 3a                	push   $0x3a
  800d86:	68 90 2b 80 00       	push   $0x802b90
  800d8b:	e8 91 fe ff ff       	call   800c21 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800d90:	ff 45 f0             	incl   -0x10(%ebp)
  800d93:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d96:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800d99:	0f 8c 30 ff ff ff    	jl     800ccf <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800d9f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800da6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800dad:	eb 27                	jmp    800dd6 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800daf:	a1 20 30 80 00       	mov    0x803020,%eax
  800db4:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800dba:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800dbd:	89 d0                	mov    %edx,%eax
  800dbf:	c1 e0 02             	shl    $0x2,%eax
  800dc2:	01 d0                	add    %edx,%eax
  800dc4:	c1 e0 02             	shl    $0x2,%eax
  800dc7:	01 c8                	add    %ecx,%eax
  800dc9:	8a 40 04             	mov    0x4(%eax),%al
  800dcc:	3c 01                	cmp    $0x1,%al
  800dce:	75 03                	jne    800dd3 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800dd0:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800dd3:	ff 45 e0             	incl   -0x20(%ebp)
  800dd6:	a1 20 30 80 00       	mov    0x803020,%eax
  800ddb:	8b 50 74             	mov    0x74(%eax),%edx
  800dde:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800de1:	39 c2                	cmp    %eax,%edx
  800de3:	77 ca                	ja     800daf <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800de5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800de8:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800deb:	74 14                	je     800e01 <CheckWSWithoutLastIndex+0x16e>
		panic(
  800ded:	83 ec 04             	sub    $0x4,%esp
  800df0:	68 f0 2b 80 00       	push   $0x802bf0
  800df5:	6a 44                	push   $0x44
  800df7:	68 90 2b 80 00       	push   $0x802b90
  800dfc:	e8 20 fe ff ff       	call   800c21 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800e01:	90                   	nop
  800e02:	c9                   	leave  
  800e03:	c3                   	ret    

00800e04 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800e04:	55                   	push   %ebp
  800e05:	89 e5                	mov    %esp,%ebp
  800e07:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800e0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0d:	8b 00                	mov    (%eax),%eax
  800e0f:	8d 48 01             	lea    0x1(%eax),%ecx
  800e12:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e15:	89 0a                	mov    %ecx,(%edx)
  800e17:	8b 55 08             	mov    0x8(%ebp),%edx
  800e1a:	88 d1                	mov    %dl,%cl
  800e1c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e1f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800e23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e26:	8b 00                	mov    (%eax),%eax
  800e28:	3d ff 00 00 00       	cmp    $0xff,%eax
  800e2d:	75 2c                	jne    800e5b <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800e2f:	a0 24 30 80 00       	mov    0x803024,%al
  800e34:	0f b6 c0             	movzbl %al,%eax
  800e37:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e3a:	8b 12                	mov    (%edx),%edx
  800e3c:	89 d1                	mov    %edx,%ecx
  800e3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e41:	83 c2 08             	add    $0x8,%edx
  800e44:	83 ec 04             	sub    $0x4,%esp
  800e47:	50                   	push   %eax
  800e48:	51                   	push   %ecx
  800e49:	52                   	push   %edx
  800e4a:	e8 48 12 00 00       	call   802097 <sys_cputs>
  800e4f:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800e52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e55:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800e5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5e:	8b 40 04             	mov    0x4(%eax),%eax
  800e61:	8d 50 01             	lea    0x1(%eax),%edx
  800e64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e67:	89 50 04             	mov    %edx,0x4(%eax)
}
  800e6a:	90                   	nop
  800e6b:	c9                   	leave  
  800e6c:	c3                   	ret    

00800e6d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800e6d:	55                   	push   %ebp
  800e6e:	89 e5                	mov    %esp,%ebp
  800e70:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800e76:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800e7d:	00 00 00 
	b.cnt = 0;
  800e80:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800e87:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800e8a:	ff 75 0c             	pushl  0xc(%ebp)
  800e8d:	ff 75 08             	pushl  0x8(%ebp)
  800e90:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800e96:	50                   	push   %eax
  800e97:	68 04 0e 80 00       	push   $0x800e04
  800e9c:	e8 11 02 00 00       	call   8010b2 <vprintfmt>
  800ea1:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800ea4:	a0 24 30 80 00       	mov    0x803024,%al
  800ea9:	0f b6 c0             	movzbl %al,%eax
  800eac:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800eb2:	83 ec 04             	sub    $0x4,%esp
  800eb5:	50                   	push   %eax
  800eb6:	52                   	push   %edx
  800eb7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ebd:	83 c0 08             	add    $0x8,%eax
  800ec0:	50                   	push   %eax
  800ec1:	e8 d1 11 00 00       	call   802097 <sys_cputs>
  800ec6:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800ec9:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800ed0:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800ed6:	c9                   	leave  
  800ed7:	c3                   	ret    

00800ed8 <cprintf>:

int cprintf(const char *fmt, ...) {
  800ed8:	55                   	push   %ebp
  800ed9:	89 e5                	mov    %esp,%ebp
  800edb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800ede:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800ee5:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ee8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800eee:	83 ec 08             	sub    $0x8,%esp
  800ef1:	ff 75 f4             	pushl  -0xc(%ebp)
  800ef4:	50                   	push   %eax
  800ef5:	e8 73 ff ff ff       	call   800e6d <vcprintf>
  800efa:	83 c4 10             	add    $0x10,%esp
  800efd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800f00:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f03:	c9                   	leave  
  800f04:	c3                   	ret    

00800f05 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800f05:	55                   	push   %ebp
  800f06:	89 e5                	mov    %esp,%ebp
  800f08:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800f0b:	e8 98 13 00 00       	call   8022a8 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800f10:	8d 45 0c             	lea    0xc(%ebp),%eax
  800f13:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800f16:	8b 45 08             	mov    0x8(%ebp),%eax
  800f19:	83 ec 08             	sub    $0x8,%esp
  800f1c:	ff 75 f4             	pushl  -0xc(%ebp)
  800f1f:	50                   	push   %eax
  800f20:	e8 48 ff ff ff       	call   800e6d <vcprintf>
  800f25:	83 c4 10             	add    $0x10,%esp
  800f28:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800f2b:	e8 92 13 00 00       	call   8022c2 <sys_enable_interrupt>
	return cnt;
  800f30:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f33:	c9                   	leave  
  800f34:	c3                   	ret    

00800f35 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800f35:	55                   	push   %ebp
  800f36:	89 e5                	mov    %esp,%ebp
  800f38:	53                   	push   %ebx
  800f39:	83 ec 14             	sub    $0x14,%esp
  800f3c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f42:	8b 45 14             	mov    0x14(%ebp),%eax
  800f45:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800f48:	8b 45 18             	mov    0x18(%ebp),%eax
  800f4b:	ba 00 00 00 00       	mov    $0x0,%edx
  800f50:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800f53:	77 55                	ja     800faa <printnum+0x75>
  800f55:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800f58:	72 05                	jb     800f5f <printnum+0x2a>
  800f5a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f5d:	77 4b                	ja     800faa <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800f5f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800f62:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800f65:	8b 45 18             	mov    0x18(%ebp),%eax
  800f68:	ba 00 00 00 00       	mov    $0x0,%edx
  800f6d:	52                   	push   %edx
  800f6e:	50                   	push   %eax
  800f6f:	ff 75 f4             	pushl  -0xc(%ebp)
  800f72:	ff 75 f0             	pushl  -0x10(%ebp)
  800f75:	e8 6e 17 00 00       	call   8026e8 <__udivdi3>
  800f7a:	83 c4 10             	add    $0x10,%esp
  800f7d:	83 ec 04             	sub    $0x4,%esp
  800f80:	ff 75 20             	pushl  0x20(%ebp)
  800f83:	53                   	push   %ebx
  800f84:	ff 75 18             	pushl  0x18(%ebp)
  800f87:	52                   	push   %edx
  800f88:	50                   	push   %eax
  800f89:	ff 75 0c             	pushl  0xc(%ebp)
  800f8c:	ff 75 08             	pushl  0x8(%ebp)
  800f8f:	e8 a1 ff ff ff       	call   800f35 <printnum>
  800f94:	83 c4 20             	add    $0x20,%esp
  800f97:	eb 1a                	jmp    800fb3 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800f99:	83 ec 08             	sub    $0x8,%esp
  800f9c:	ff 75 0c             	pushl  0xc(%ebp)
  800f9f:	ff 75 20             	pushl  0x20(%ebp)
  800fa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa5:	ff d0                	call   *%eax
  800fa7:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800faa:	ff 4d 1c             	decl   0x1c(%ebp)
  800fad:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800fb1:	7f e6                	jg     800f99 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800fb3:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800fb6:	bb 00 00 00 00       	mov    $0x0,%ebx
  800fbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fbe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fc1:	53                   	push   %ebx
  800fc2:	51                   	push   %ecx
  800fc3:	52                   	push   %edx
  800fc4:	50                   	push   %eax
  800fc5:	e8 2e 18 00 00       	call   8027f8 <__umoddi3>
  800fca:	83 c4 10             	add    $0x10,%esp
  800fcd:	05 54 2e 80 00       	add    $0x802e54,%eax
  800fd2:	8a 00                	mov    (%eax),%al
  800fd4:	0f be c0             	movsbl %al,%eax
  800fd7:	83 ec 08             	sub    $0x8,%esp
  800fda:	ff 75 0c             	pushl  0xc(%ebp)
  800fdd:	50                   	push   %eax
  800fde:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe1:	ff d0                	call   *%eax
  800fe3:	83 c4 10             	add    $0x10,%esp
}
  800fe6:	90                   	nop
  800fe7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800fea:	c9                   	leave  
  800feb:	c3                   	ret    

00800fec <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800fec:	55                   	push   %ebp
  800fed:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800fef:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ff3:	7e 1c                	jle    801011 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ff5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff8:	8b 00                	mov    (%eax),%eax
  800ffa:	8d 50 08             	lea    0x8(%eax),%edx
  800ffd:	8b 45 08             	mov    0x8(%ebp),%eax
  801000:	89 10                	mov    %edx,(%eax)
  801002:	8b 45 08             	mov    0x8(%ebp),%eax
  801005:	8b 00                	mov    (%eax),%eax
  801007:	83 e8 08             	sub    $0x8,%eax
  80100a:	8b 50 04             	mov    0x4(%eax),%edx
  80100d:	8b 00                	mov    (%eax),%eax
  80100f:	eb 40                	jmp    801051 <getuint+0x65>
	else if (lflag)
  801011:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801015:	74 1e                	je     801035 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801017:	8b 45 08             	mov    0x8(%ebp),%eax
  80101a:	8b 00                	mov    (%eax),%eax
  80101c:	8d 50 04             	lea    0x4(%eax),%edx
  80101f:	8b 45 08             	mov    0x8(%ebp),%eax
  801022:	89 10                	mov    %edx,(%eax)
  801024:	8b 45 08             	mov    0x8(%ebp),%eax
  801027:	8b 00                	mov    (%eax),%eax
  801029:	83 e8 04             	sub    $0x4,%eax
  80102c:	8b 00                	mov    (%eax),%eax
  80102e:	ba 00 00 00 00       	mov    $0x0,%edx
  801033:	eb 1c                	jmp    801051 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801035:	8b 45 08             	mov    0x8(%ebp),%eax
  801038:	8b 00                	mov    (%eax),%eax
  80103a:	8d 50 04             	lea    0x4(%eax),%edx
  80103d:	8b 45 08             	mov    0x8(%ebp),%eax
  801040:	89 10                	mov    %edx,(%eax)
  801042:	8b 45 08             	mov    0x8(%ebp),%eax
  801045:	8b 00                	mov    (%eax),%eax
  801047:	83 e8 04             	sub    $0x4,%eax
  80104a:	8b 00                	mov    (%eax),%eax
  80104c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801051:	5d                   	pop    %ebp
  801052:	c3                   	ret    

00801053 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801053:	55                   	push   %ebp
  801054:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801056:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80105a:	7e 1c                	jle    801078 <getint+0x25>
		return va_arg(*ap, long long);
  80105c:	8b 45 08             	mov    0x8(%ebp),%eax
  80105f:	8b 00                	mov    (%eax),%eax
  801061:	8d 50 08             	lea    0x8(%eax),%edx
  801064:	8b 45 08             	mov    0x8(%ebp),%eax
  801067:	89 10                	mov    %edx,(%eax)
  801069:	8b 45 08             	mov    0x8(%ebp),%eax
  80106c:	8b 00                	mov    (%eax),%eax
  80106e:	83 e8 08             	sub    $0x8,%eax
  801071:	8b 50 04             	mov    0x4(%eax),%edx
  801074:	8b 00                	mov    (%eax),%eax
  801076:	eb 38                	jmp    8010b0 <getint+0x5d>
	else if (lflag)
  801078:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80107c:	74 1a                	je     801098 <getint+0x45>
		return va_arg(*ap, long);
  80107e:	8b 45 08             	mov    0x8(%ebp),%eax
  801081:	8b 00                	mov    (%eax),%eax
  801083:	8d 50 04             	lea    0x4(%eax),%edx
  801086:	8b 45 08             	mov    0x8(%ebp),%eax
  801089:	89 10                	mov    %edx,(%eax)
  80108b:	8b 45 08             	mov    0x8(%ebp),%eax
  80108e:	8b 00                	mov    (%eax),%eax
  801090:	83 e8 04             	sub    $0x4,%eax
  801093:	8b 00                	mov    (%eax),%eax
  801095:	99                   	cltd   
  801096:	eb 18                	jmp    8010b0 <getint+0x5d>
	else
		return va_arg(*ap, int);
  801098:	8b 45 08             	mov    0x8(%ebp),%eax
  80109b:	8b 00                	mov    (%eax),%eax
  80109d:	8d 50 04             	lea    0x4(%eax),%edx
  8010a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a3:	89 10                	mov    %edx,(%eax)
  8010a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a8:	8b 00                	mov    (%eax),%eax
  8010aa:	83 e8 04             	sub    $0x4,%eax
  8010ad:	8b 00                	mov    (%eax),%eax
  8010af:	99                   	cltd   
}
  8010b0:	5d                   	pop    %ebp
  8010b1:	c3                   	ret    

008010b2 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8010b2:	55                   	push   %ebp
  8010b3:	89 e5                	mov    %esp,%ebp
  8010b5:	56                   	push   %esi
  8010b6:	53                   	push   %ebx
  8010b7:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8010ba:	eb 17                	jmp    8010d3 <vprintfmt+0x21>
			if (ch == '\0')
  8010bc:	85 db                	test   %ebx,%ebx
  8010be:	0f 84 af 03 00 00    	je     801473 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8010c4:	83 ec 08             	sub    $0x8,%esp
  8010c7:	ff 75 0c             	pushl  0xc(%ebp)
  8010ca:	53                   	push   %ebx
  8010cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ce:	ff d0                	call   *%eax
  8010d0:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8010d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d6:	8d 50 01             	lea    0x1(%eax),%edx
  8010d9:	89 55 10             	mov    %edx,0x10(%ebp)
  8010dc:	8a 00                	mov    (%eax),%al
  8010de:	0f b6 d8             	movzbl %al,%ebx
  8010e1:	83 fb 25             	cmp    $0x25,%ebx
  8010e4:	75 d6                	jne    8010bc <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8010e6:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8010ea:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8010f1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8010f8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8010ff:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801106:	8b 45 10             	mov    0x10(%ebp),%eax
  801109:	8d 50 01             	lea    0x1(%eax),%edx
  80110c:	89 55 10             	mov    %edx,0x10(%ebp)
  80110f:	8a 00                	mov    (%eax),%al
  801111:	0f b6 d8             	movzbl %al,%ebx
  801114:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801117:	83 f8 55             	cmp    $0x55,%eax
  80111a:	0f 87 2b 03 00 00    	ja     80144b <vprintfmt+0x399>
  801120:	8b 04 85 78 2e 80 00 	mov    0x802e78(,%eax,4),%eax
  801127:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801129:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80112d:	eb d7                	jmp    801106 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80112f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801133:	eb d1                	jmp    801106 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801135:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80113c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80113f:	89 d0                	mov    %edx,%eax
  801141:	c1 e0 02             	shl    $0x2,%eax
  801144:	01 d0                	add    %edx,%eax
  801146:	01 c0                	add    %eax,%eax
  801148:	01 d8                	add    %ebx,%eax
  80114a:	83 e8 30             	sub    $0x30,%eax
  80114d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801150:	8b 45 10             	mov    0x10(%ebp),%eax
  801153:	8a 00                	mov    (%eax),%al
  801155:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801158:	83 fb 2f             	cmp    $0x2f,%ebx
  80115b:	7e 3e                	jle    80119b <vprintfmt+0xe9>
  80115d:	83 fb 39             	cmp    $0x39,%ebx
  801160:	7f 39                	jg     80119b <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801162:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801165:	eb d5                	jmp    80113c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801167:	8b 45 14             	mov    0x14(%ebp),%eax
  80116a:	83 c0 04             	add    $0x4,%eax
  80116d:	89 45 14             	mov    %eax,0x14(%ebp)
  801170:	8b 45 14             	mov    0x14(%ebp),%eax
  801173:	83 e8 04             	sub    $0x4,%eax
  801176:	8b 00                	mov    (%eax),%eax
  801178:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80117b:	eb 1f                	jmp    80119c <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80117d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801181:	79 83                	jns    801106 <vprintfmt+0x54>
				width = 0;
  801183:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80118a:	e9 77 ff ff ff       	jmp    801106 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80118f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801196:	e9 6b ff ff ff       	jmp    801106 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80119b:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80119c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8011a0:	0f 89 60 ff ff ff    	jns    801106 <vprintfmt+0x54>
				width = precision, precision = -1;
  8011a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8011a9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8011ac:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8011b3:	e9 4e ff ff ff       	jmp    801106 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8011b8:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8011bb:	e9 46 ff ff ff       	jmp    801106 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8011c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c3:	83 c0 04             	add    $0x4,%eax
  8011c6:	89 45 14             	mov    %eax,0x14(%ebp)
  8011c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8011cc:	83 e8 04             	sub    $0x4,%eax
  8011cf:	8b 00                	mov    (%eax),%eax
  8011d1:	83 ec 08             	sub    $0x8,%esp
  8011d4:	ff 75 0c             	pushl  0xc(%ebp)
  8011d7:	50                   	push   %eax
  8011d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011db:	ff d0                	call   *%eax
  8011dd:	83 c4 10             	add    $0x10,%esp
			break;
  8011e0:	e9 89 02 00 00       	jmp    80146e <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8011e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e8:	83 c0 04             	add    $0x4,%eax
  8011eb:	89 45 14             	mov    %eax,0x14(%ebp)
  8011ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f1:	83 e8 04             	sub    $0x4,%eax
  8011f4:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8011f6:	85 db                	test   %ebx,%ebx
  8011f8:	79 02                	jns    8011fc <vprintfmt+0x14a>
				err = -err;
  8011fa:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8011fc:	83 fb 64             	cmp    $0x64,%ebx
  8011ff:	7f 0b                	jg     80120c <vprintfmt+0x15a>
  801201:	8b 34 9d c0 2c 80 00 	mov    0x802cc0(,%ebx,4),%esi
  801208:	85 f6                	test   %esi,%esi
  80120a:	75 19                	jne    801225 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80120c:	53                   	push   %ebx
  80120d:	68 65 2e 80 00       	push   $0x802e65
  801212:	ff 75 0c             	pushl  0xc(%ebp)
  801215:	ff 75 08             	pushl  0x8(%ebp)
  801218:	e8 5e 02 00 00       	call   80147b <printfmt>
  80121d:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801220:	e9 49 02 00 00       	jmp    80146e <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801225:	56                   	push   %esi
  801226:	68 6e 2e 80 00       	push   $0x802e6e
  80122b:	ff 75 0c             	pushl  0xc(%ebp)
  80122e:	ff 75 08             	pushl  0x8(%ebp)
  801231:	e8 45 02 00 00       	call   80147b <printfmt>
  801236:	83 c4 10             	add    $0x10,%esp
			break;
  801239:	e9 30 02 00 00       	jmp    80146e <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80123e:	8b 45 14             	mov    0x14(%ebp),%eax
  801241:	83 c0 04             	add    $0x4,%eax
  801244:	89 45 14             	mov    %eax,0x14(%ebp)
  801247:	8b 45 14             	mov    0x14(%ebp),%eax
  80124a:	83 e8 04             	sub    $0x4,%eax
  80124d:	8b 30                	mov    (%eax),%esi
  80124f:	85 f6                	test   %esi,%esi
  801251:	75 05                	jne    801258 <vprintfmt+0x1a6>
				p = "(null)";
  801253:	be 71 2e 80 00       	mov    $0x802e71,%esi
			if (width > 0 && padc != '-')
  801258:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80125c:	7e 6d                	jle    8012cb <vprintfmt+0x219>
  80125e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801262:	74 67                	je     8012cb <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801264:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801267:	83 ec 08             	sub    $0x8,%esp
  80126a:	50                   	push   %eax
  80126b:	56                   	push   %esi
  80126c:	e8 0c 03 00 00       	call   80157d <strnlen>
  801271:	83 c4 10             	add    $0x10,%esp
  801274:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801277:	eb 16                	jmp    80128f <vprintfmt+0x1dd>
					putch(padc, putdat);
  801279:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80127d:	83 ec 08             	sub    $0x8,%esp
  801280:	ff 75 0c             	pushl  0xc(%ebp)
  801283:	50                   	push   %eax
  801284:	8b 45 08             	mov    0x8(%ebp),%eax
  801287:	ff d0                	call   *%eax
  801289:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80128c:	ff 4d e4             	decl   -0x1c(%ebp)
  80128f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801293:	7f e4                	jg     801279 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801295:	eb 34                	jmp    8012cb <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801297:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80129b:	74 1c                	je     8012b9 <vprintfmt+0x207>
  80129d:	83 fb 1f             	cmp    $0x1f,%ebx
  8012a0:	7e 05                	jle    8012a7 <vprintfmt+0x1f5>
  8012a2:	83 fb 7e             	cmp    $0x7e,%ebx
  8012a5:	7e 12                	jle    8012b9 <vprintfmt+0x207>
					putch('?', putdat);
  8012a7:	83 ec 08             	sub    $0x8,%esp
  8012aa:	ff 75 0c             	pushl  0xc(%ebp)
  8012ad:	6a 3f                	push   $0x3f
  8012af:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b2:	ff d0                	call   *%eax
  8012b4:	83 c4 10             	add    $0x10,%esp
  8012b7:	eb 0f                	jmp    8012c8 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8012b9:	83 ec 08             	sub    $0x8,%esp
  8012bc:	ff 75 0c             	pushl  0xc(%ebp)
  8012bf:	53                   	push   %ebx
  8012c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c3:	ff d0                	call   *%eax
  8012c5:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8012c8:	ff 4d e4             	decl   -0x1c(%ebp)
  8012cb:	89 f0                	mov    %esi,%eax
  8012cd:	8d 70 01             	lea    0x1(%eax),%esi
  8012d0:	8a 00                	mov    (%eax),%al
  8012d2:	0f be d8             	movsbl %al,%ebx
  8012d5:	85 db                	test   %ebx,%ebx
  8012d7:	74 24                	je     8012fd <vprintfmt+0x24b>
  8012d9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8012dd:	78 b8                	js     801297 <vprintfmt+0x1e5>
  8012df:	ff 4d e0             	decl   -0x20(%ebp)
  8012e2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8012e6:	79 af                	jns    801297 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8012e8:	eb 13                	jmp    8012fd <vprintfmt+0x24b>
				putch(' ', putdat);
  8012ea:	83 ec 08             	sub    $0x8,%esp
  8012ed:	ff 75 0c             	pushl  0xc(%ebp)
  8012f0:	6a 20                	push   $0x20
  8012f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f5:	ff d0                	call   *%eax
  8012f7:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8012fa:	ff 4d e4             	decl   -0x1c(%ebp)
  8012fd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801301:	7f e7                	jg     8012ea <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801303:	e9 66 01 00 00       	jmp    80146e <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801308:	83 ec 08             	sub    $0x8,%esp
  80130b:	ff 75 e8             	pushl  -0x18(%ebp)
  80130e:	8d 45 14             	lea    0x14(%ebp),%eax
  801311:	50                   	push   %eax
  801312:	e8 3c fd ff ff       	call   801053 <getint>
  801317:	83 c4 10             	add    $0x10,%esp
  80131a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80131d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801320:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801323:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801326:	85 d2                	test   %edx,%edx
  801328:	79 23                	jns    80134d <vprintfmt+0x29b>
				putch('-', putdat);
  80132a:	83 ec 08             	sub    $0x8,%esp
  80132d:	ff 75 0c             	pushl  0xc(%ebp)
  801330:	6a 2d                	push   $0x2d
  801332:	8b 45 08             	mov    0x8(%ebp),%eax
  801335:	ff d0                	call   *%eax
  801337:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80133a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80133d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801340:	f7 d8                	neg    %eax
  801342:	83 d2 00             	adc    $0x0,%edx
  801345:	f7 da                	neg    %edx
  801347:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80134a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80134d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801354:	e9 bc 00 00 00       	jmp    801415 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801359:	83 ec 08             	sub    $0x8,%esp
  80135c:	ff 75 e8             	pushl  -0x18(%ebp)
  80135f:	8d 45 14             	lea    0x14(%ebp),%eax
  801362:	50                   	push   %eax
  801363:	e8 84 fc ff ff       	call   800fec <getuint>
  801368:	83 c4 10             	add    $0x10,%esp
  80136b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80136e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801371:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801378:	e9 98 00 00 00       	jmp    801415 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80137d:	83 ec 08             	sub    $0x8,%esp
  801380:	ff 75 0c             	pushl  0xc(%ebp)
  801383:	6a 58                	push   $0x58
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	ff d0                	call   *%eax
  80138a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80138d:	83 ec 08             	sub    $0x8,%esp
  801390:	ff 75 0c             	pushl  0xc(%ebp)
  801393:	6a 58                	push   $0x58
  801395:	8b 45 08             	mov    0x8(%ebp),%eax
  801398:	ff d0                	call   *%eax
  80139a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80139d:	83 ec 08             	sub    $0x8,%esp
  8013a0:	ff 75 0c             	pushl  0xc(%ebp)
  8013a3:	6a 58                	push   $0x58
  8013a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a8:	ff d0                	call   *%eax
  8013aa:	83 c4 10             	add    $0x10,%esp
			break;
  8013ad:	e9 bc 00 00 00       	jmp    80146e <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8013b2:	83 ec 08             	sub    $0x8,%esp
  8013b5:	ff 75 0c             	pushl  0xc(%ebp)
  8013b8:	6a 30                	push   $0x30
  8013ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bd:	ff d0                	call   *%eax
  8013bf:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8013c2:	83 ec 08             	sub    $0x8,%esp
  8013c5:	ff 75 0c             	pushl  0xc(%ebp)
  8013c8:	6a 78                	push   $0x78
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	ff d0                	call   *%eax
  8013cf:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8013d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8013d5:	83 c0 04             	add    $0x4,%eax
  8013d8:	89 45 14             	mov    %eax,0x14(%ebp)
  8013db:	8b 45 14             	mov    0x14(%ebp),%eax
  8013de:	83 e8 04             	sub    $0x4,%eax
  8013e1:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8013e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8013ed:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8013f4:	eb 1f                	jmp    801415 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8013f6:	83 ec 08             	sub    $0x8,%esp
  8013f9:	ff 75 e8             	pushl  -0x18(%ebp)
  8013fc:	8d 45 14             	lea    0x14(%ebp),%eax
  8013ff:	50                   	push   %eax
  801400:	e8 e7 fb ff ff       	call   800fec <getuint>
  801405:	83 c4 10             	add    $0x10,%esp
  801408:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80140b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80140e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801415:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801419:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80141c:	83 ec 04             	sub    $0x4,%esp
  80141f:	52                   	push   %edx
  801420:	ff 75 e4             	pushl  -0x1c(%ebp)
  801423:	50                   	push   %eax
  801424:	ff 75 f4             	pushl  -0xc(%ebp)
  801427:	ff 75 f0             	pushl  -0x10(%ebp)
  80142a:	ff 75 0c             	pushl  0xc(%ebp)
  80142d:	ff 75 08             	pushl  0x8(%ebp)
  801430:	e8 00 fb ff ff       	call   800f35 <printnum>
  801435:	83 c4 20             	add    $0x20,%esp
			break;
  801438:	eb 34                	jmp    80146e <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80143a:	83 ec 08             	sub    $0x8,%esp
  80143d:	ff 75 0c             	pushl  0xc(%ebp)
  801440:	53                   	push   %ebx
  801441:	8b 45 08             	mov    0x8(%ebp),%eax
  801444:	ff d0                	call   *%eax
  801446:	83 c4 10             	add    $0x10,%esp
			break;
  801449:	eb 23                	jmp    80146e <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80144b:	83 ec 08             	sub    $0x8,%esp
  80144e:	ff 75 0c             	pushl  0xc(%ebp)
  801451:	6a 25                	push   $0x25
  801453:	8b 45 08             	mov    0x8(%ebp),%eax
  801456:	ff d0                	call   *%eax
  801458:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80145b:	ff 4d 10             	decl   0x10(%ebp)
  80145e:	eb 03                	jmp    801463 <vprintfmt+0x3b1>
  801460:	ff 4d 10             	decl   0x10(%ebp)
  801463:	8b 45 10             	mov    0x10(%ebp),%eax
  801466:	48                   	dec    %eax
  801467:	8a 00                	mov    (%eax),%al
  801469:	3c 25                	cmp    $0x25,%al
  80146b:	75 f3                	jne    801460 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80146d:	90                   	nop
		}
	}
  80146e:	e9 47 fc ff ff       	jmp    8010ba <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801473:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801474:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801477:	5b                   	pop    %ebx
  801478:	5e                   	pop    %esi
  801479:	5d                   	pop    %ebp
  80147a:	c3                   	ret    

0080147b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80147b:	55                   	push   %ebp
  80147c:	89 e5                	mov    %esp,%ebp
  80147e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801481:	8d 45 10             	lea    0x10(%ebp),%eax
  801484:	83 c0 04             	add    $0x4,%eax
  801487:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80148a:	8b 45 10             	mov    0x10(%ebp),%eax
  80148d:	ff 75 f4             	pushl  -0xc(%ebp)
  801490:	50                   	push   %eax
  801491:	ff 75 0c             	pushl  0xc(%ebp)
  801494:	ff 75 08             	pushl  0x8(%ebp)
  801497:	e8 16 fc ff ff       	call   8010b2 <vprintfmt>
  80149c:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80149f:	90                   	nop
  8014a0:	c9                   	leave  
  8014a1:	c3                   	ret    

008014a2 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8014a2:	55                   	push   %ebp
  8014a3:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8014a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a8:	8b 40 08             	mov    0x8(%eax),%eax
  8014ab:	8d 50 01             	lea    0x1(%eax),%edx
  8014ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b1:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8014b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b7:	8b 10                	mov    (%eax),%edx
  8014b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bc:	8b 40 04             	mov    0x4(%eax),%eax
  8014bf:	39 c2                	cmp    %eax,%edx
  8014c1:	73 12                	jae    8014d5 <sprintputch+0x33>
		*b->buf++ = ch;
  8014c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c6:	8b 00                	mov    (%eax),%eax
  8014c8:	8d 48 01             	lea    0x1(%eax),%ecx
  8014cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ce:	89 0a                	mov    %ecx,(%edx)
  8014d0:	8b 55 08             	mov    0x8(%ebp),%edx
  8014d3:	88 10                	mov    %dl,(%eax)
}
  8014d5:	90                   	nop
  8014d6:	5d                   	pop    %ebp
  8014d7:	c3                   	ret    

008014d8 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8014d8:	55                   	push   %ebp
  8014d9:	89 e5                	mov    %esp,%ebp
  8014db:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8014de:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8014e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ed:	01 d0                	add    %edx,%eax
  8014ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8014f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8014f9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014fd:	74 06                	je     801505 <vsnprintf+0x2d>
  8014ff:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801503:	7f 07                	jg     80150c <vsnprintf+0x34>
		return -E_INVAL;
  801505:	b8 03 00 00 00       	mov    $0x3,%eax
  80150a:	eb 20                	jmp    80152c <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80150c:	ff 75 14             	pushl  0x14(%ebp)
  80150f:	ff 75 10             	pushl  0x10(%ebp)
  801512:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801515:	50                   	push   %eax
  801516:	68 a2 14 80 00       	push   $0x8014a2
  80151b:	e8 92 fb ff ff       	call   8010b2 <vprintfmt>
  801520:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801523:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801526:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801529:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80152c:	c9                   	leave  
  80152d:	c3                   	ret    

0080152e <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80152e:	55                   	push   %ebp
  80152f:	89 e5                	mov    %esp,%ebp
  801531:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801534:	8d 45 10             	lea    0x10(%ebp),%eax
  801537:	83 c0 04             	add    $0x4,%eax
  80153a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80153d:	8b 45 10             	mov    0x10(%ebp),%eax
  801540:	ff 75 f4             	pushl  -0xc(%ebp)
  801543:	50                   	push   %eax
  801544:	ff 75 0c             	pushl  0xc(%ebp)
  801547:	ff 75 08             	pushl  0x8(%ebp)
  80154a:	e8 89 ff ff ff       	call   8014d8 <vsnprintf>
  80154f:	83 c4 10             	add    $0x10,%esp
  801552:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801555:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801558:	c9                   	leave  
  801559:	c3                   	ret    

0080155a <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80155a:	55                   	push   %ebp
  80155b:	89 e5                	mov    %esp,%ebp
  80155d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801560:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801567:	eb 06                	jmp    80156f <strlen+0x15>
		n++;
  801569:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80156c:	ff 45 08             	incl   0x8(%ebp)
  80156f:	8b 45 08             	mov    0x8(%ebp),%eax
  801572:	8a 00                	mov    (%eax),%al
  801574:	84 c0                	test   %al,%al
  801576:	75 f1                	jne    801569 <strlen+0xf>
		n++;
	return n;
  801578:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80157b:	c9                   	leave  
  80157c:	c3                   	ret    

0080157d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80157d:	55                   	push   %ebp
  80157e:	89 e5                	mov    %esp,%ebp
  801580:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801583:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80158a:	eb 09                	jmp    801595 <strnlen+0x18>
		n++;
  80158c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80158f:	ff 45 08             	incl   0x8(%ebp)
  801592:	ff 4d 0c             	decl   0xc(%ebp)
  801595:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801599:	74 09                	je     8015a4 <strnlen+0x27>
  80159b:	8b 45 08             	mov    0x8(%ebp),%eax
  80159e:	8a 00                	mov    (%eax),%al
  8015a0:	84 c0                	test   %al,%al
  8015a2:	75 e8                	jne    80158c <strnlen+0xf>
		n++;
	return n;
  8015a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8015a7:	c9                   	leave  
  8015a8:	c3                   	ret    

008015a9 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8015a9:	55                   	push   %ebp
  8015aa:	89 e5                	mov    %esp,%ebp
  8015ac:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8015af:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8015b5:	90                   	nop
  8015b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b9:	8d 50 01             	lea    0x1(%eax),%edx
  8015bc:	89 55 08             	mov    %edx,0x8(%ebp)
  8015bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015c2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015c5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8015c8:	8a 12                	mov    (%edx),%dl
  8015ca:	88 10                	mov    %dl,(%eax)
  8015cc:	8a 00                	mov    (%eax),%al
  8015ce:	84 c0                	test   %al,%al
  8015d0:	75 e4                	jne    8015b6 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8015d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8015d5:	c9                   	leave  
  8015d6:	c3                   	ret    

008015d7 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8015d7:	55                   	push   %ebp
  8015d8:	89 e5                	mov    %esp,%ebp
  8015da:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8015dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8015e3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015ea:	eb 1f                	jmp    80160b <strncpy+0x34>
		*dst++ = *src;
  8015ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ef:	8d 50 01             	lea    0x1(%eax),%edx
  8015f2:	89 55 08             	mov    %edx,0x8(%ebp)
  8015f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f8:	8a 12                	mov    (%edx),%dl
  8015fa:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8015fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ff:	8a 00                	mov    (%eax),%al
  801601:	84 c0                	test   %al,%al
  801603:	74 03                	je     801608 <strncpy+0x31>
			src++;
  801605:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801608:	ff 45 fc             	incl   -0x4(%ebp)
  80160b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80160e:	3b 45 10             	cmp    0x10(%ebp),%eax
  801611:	72 d9                	jb     8015ec <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801613:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801616:	c9                   	leave  
  801617:	c3                   	ret    

00801618 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801618:	55                   	push   %ebp
  801619:	89 e5                	mov    %esp,%ebp
  80161b:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80161e:	8b 45 08             	mov    0x8(%ebp),%eax
  801621:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801624:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801628:	74 30                	je     80165a <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80162a:	eb 16                	jmp    801642 <strlcpy+0x2a>
			*dst++ = *src++;
  80162c:	8b 45 08             	mov    0x8(%ebp),%eax
  80162f:	8d 50 01             	lea    0x1(%eax),%edx
  801632:	89 55 08             	mov    %edx,0x8(%ebp)
  801635:	8b 55 0c             	mov    0xc(%ebp),%edx
  801638:	8d 4a 01             	lea    0x1(%edx),%ecx
  80163b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80163e:	8a 12                	mov    (%edx),%dl
  801640:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801642:	ff 4d 10             	decl   0x10(%ebp)
  801645:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801649:	74 09                	je     801654 <strlcpy+0x3c>
  80164b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80164e:	8a 00                	mov    (%eax),%al
  801650:	84 c0                	test   %al,%al
  801652:	75 d8                	jne    80162c <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801654:	8b 45 08             	mov    0x8(%ebp),%eax
  801657:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80165a:	8b 55 08             	mov    0x8(%ebp),%edx
  80165d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801660:	29 c2                	sub    %eax,%edx
  801662:	89 d0                	mov    %edx,%eax
}
  801664:	c9                   	leave  
  801665:	c3                   	ret    

00801666 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801666:	55                   	push   %ebp
  801667:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801669:	eb 06                	jmp    801671 <strcmp+0xb>
		p++, q++;
  80166b:	ff 45 08             	incl   0x8(%ebp)
  80166e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801671:	8b 45 08             	mov    0x8(%ebp),%eax
  801674:	8a 00                	mov    (%eax),%al
  801676:	84 c0                	test   %al,%al
  801678:	74 0e                	je     801688 <strcmp+0x22>
  80167a:	8b 45 08             	mov    0x8(%ebp),%eax
  80167d:	8a 10                	mov    (%eax),%dl
  80167f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801682:	8a 00                	mov    (%eax),%al
  801684:	38 c2                	cmp    %al,%dl
  801686:	74 e3                	je     80166b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801688:	8b 45 08             	mov    0x8(%ebp),%eax
  80168b:	8a 00                	mov    (%eax),%al
  80168d:	0f b6 d0             	movzbl %al,%edx
  801690:	8b 45 0c             	mov    0xc(%ebp),%eax
  801693:	8a 00                	mov    (%eax),%al
  801695:	0f b6 c0             	movzbl %al,%eax
  801698:	29 c2                	sub    %eax,%edx
  80169a:	89 d0                	mov    %edx,%eax
}
  80169c:	5d                   	pop    %ebp
  80169d:	c3                   	ret    

0080169e <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80169e:	55                   	push   %ebp
  80169f:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8016a1:	eb 09                	jmp    8016ac <strncmp+0xe>
		n--, p++, q++;
  8016a3:	ff 4d 10             	decl   0x10(%ebp)
  8016a6:	ff 45 08             	incl   0x8(%ebp)
  8016a9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8016ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016b0:	74 17                	je     8016c9 <strncmp+0x2b>
  8016b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b5:	8a 00                	mov    (%eax),%al
  8016b7:	84 c0                	test   %al,%al
  8016b9:	74 0e                	je     8016c9 <strncmp+0x2b>
  8016bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016be:	8a 10                	mov    (%eax),%dl
  8016c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016c3:	8a 00                	mov    (%eax),%al
  8016c5:	38 c2                	cmp    %al,%dl
  8016c7:	74 da                	je     8016a3 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8016c9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016cd:	75 07                	jne    8016d6 <strncmp+0x38>
		return 0;
  8016cf:	b8 00 00 00 00       	mov    $0x0,%eax
  8016d4:	eb 14                	jmp    8016ea <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8016d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d9:	8a 00                	mov    (%eax),%al
  8016db:	0f b6 d0             	movzbl %al,%edx
  8016de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e1:	8a 00                	mov    (%eax),%al
  8016e3:	0f b6 c0             	movzbl %al,%eax
  8016e6:	29 c2                	sub    %eax,%edx
  8016e8:	89 d0                	mov    %edx,%eax
}
  8016ea:	5d                   	pop    %ebp
  8016eb:	c3                   	ret    

008016ec <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8016ec:	55                   	push   %ebp
  8016ed:	89 e5                	mov    %esp,%ebp
  8016ef:	83 ec 04             	sub    $0x4,%esp
  8016f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8016f8:	eb 12                	jmp    80170c <strchr+0x20>
		if (*s == c)
  8016fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fd:	8a 00                	mov    (%eax),%al
  8016ff:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801702:	75 05                	jne    801709 <strchr+0x1d>
			return (char *) s;
  801704:	8b 45 08             	mov    0x8(%ebp),%eax
  801707:	eb 11                	jmp    80171a <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801709:	ff 45 08             	incl   0x8(%ebp)
  80170c:	8b 45 08             	mov    0x8(%ebp),%eax
  80170f:	8a 00                	mov    (%eax),%al
  801711:	84 c0                	test   %al,%al
  801713:	75 e5                	jne    8016fa <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801715:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80171a:	c9                   	leave  
  80171b:	c3                   	ret    

0080171c <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80171c:	55                   	push   %ebp
  80171d:	89 e5                	mov    %esp,%ebp
  80171f:	83 ec 04             	sub    $0x4,%esp
  801722:	8b 45 0c             	mov    0xc(%ebp),%eax
  801725:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801728:	eb 0d                	jmp    801737 <strfind+0x1b>
		if (*s == c)
  80172a:	8b 45 08             	mov    0x8(%ebp),%eax
  80172d:	8a 00                	mov    (%eax),%al
  80172f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801732:	74 0e                	je     801742 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801734:	ff 45 08             	incl   0x8(%ebp)
  801737:	8b 45 08             	mov    0x8(%ebp),%eax
  80173a:	8a 00                	mov    (%eax),%al
  80173c:	84 c0                	test   %al,%al
  80173e:	75 ea                	jne    80172a <strfind+0xe>
  801740:	eb 01                	jmp    801743 <strfind+0x27>
		if (*s == c)
			break;
  801742:	90                   	nop
	return (char *) s;
  801743:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801746:	c9                   	leave  
  801747:	c3                   	ret    

00801748 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801748:	55                   	push   %ebp
  801749:	89 e5                	mov    %esp,%ebp
  80174b:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80174e:	8b 45 08             	mov    0x8(%ebp),%eax
  801751:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801754:	8b 45 10             	mov    0x10(%ebp),%eax
  801757:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80175a:	eb 0e                	jmp    80176a <memset+0x22>
		*p++ = c;
  80175c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80175f:	8d 50 01             	lea    0x1(%eax),%edx
  801762:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801765:	8b 55 0c             	mov    0xc(%ebp),%edx
  801768:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80176a:	ff 4d f8             	decl   -0x8(%ebp)
  80176d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801771:	79 e9                	jns    80175c <memset+0x14>
		*p++ = c;

	return v;
  801773:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801776:	c9                   	leave  
  801777:	c3                   	ret    

00801778 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801778:	55                   	push   %ebp
  801779:	89 e5                	mov    %esp,%ebp
  80177b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80177e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801781:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801784:	8b 45 08             	mov    0x8(%ebp),%eax
  801787:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80178a:	eb 16                	jmp    8017a2 <memcpy+0x2a>
		*d++ = *s++;
  80178c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80178f:	8d 50 01             	lea    0x1(%eax),%edx
  801792:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801795:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801798:	8d 4a 01             	lea    0x1(%edx),%ecx
  80179b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80179e:	8a 12                	mov    (%edx),%dl
  8017a0:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8017a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8017a5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017a8:	89 55 10             	mov    %edx,0x10(%ebp)
  8017ab:	85 c0                	test   %eax,%eax
  8017ad:	75 dd                	jne    80178c <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8017af:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017b2:	c9                   	leave  
  8017b3:	c3                   	ret    

008017b4 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8017b4:	55                   	push   %ebp
  8017b5:	89 e5                	mov    %esp,%ebp
  8017b7:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8017ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8017c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8017c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017c9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8017cc:	73 50                	jae    80181e <memmove+0x6a>
  8017ce:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8017d4:	01 d0                	add    %edx,%eax
  8017d6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8017d9:	76 43                	jbe    80181e <memmove+0x6a>
		s += n;
  8017db:	8b 45 10             	mov    0x10(%ebp),%eax
  8017de:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8017e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8017e4:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8017e7:	eb 10                	jmp    8017f9 <memmove+0x45>
			*--d = *--s;
  8017e9:	ff 4d f8             	decl   -0x8(%ebp)
  8017ec:	ff 4d fc             	decl   -0x4(%ebp)
  8017ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017f2:	8a 10                	mov    (%eax),%dl
  8017f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017f7:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8017f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8017fc:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017ff:	89 55 10             	mov    %edx,0x10(%ebp)
  801802:	85 c0                	test   %eax,%eax
  801804:	75 e3                	jne    8017e9 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801806:	eb 23                	jmp    80182b <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801808:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80180b:	8d 50 01             	lea    0x1(%eax),%edx
  80180e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801811:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801814:	8d 4a 01             	lea    0x1(%edx),%ecx
  801817:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80181a:	8a 12                	mov    (%edx),%dl
  80181c:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80181e:	8b 45 10             	mov    0x10(%ebp),%eax
  801821:	8d 50 ff             	lea    -0x1(%eax),%edx
  801824:	89 55 10             	mov    %edx,0x10(%ebp)
  801827:	85 c0                	test   %eax,%eax
  801829:	75 dd                	jne    801808 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80182b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80182e:	c9                   	leave  
  80182f:	c3                   	ret    

00801830 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801830:	55                   	push   %ebp
  801831:	89 e5                	mov    %esp,%ebp
  801833:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801836:	8b 45 08             	mov    0x8(%ebp),%eax
  801839:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80183c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80183f:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801842:	eb 2a                	jmp    80186e <memcmp+0x3e>
		if (*s1 != *s2)
  801844:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801847:	8a 10                	mov    (%eax),%dl
  801849:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80184c:	8a 00                	mov    (%eax),%al
  80184e:	38 c2                	cmp    %al,%dl
  801850:	74 16                	je     801868 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801852:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801855:	8a 00                	mov    (%eax),%al
  801857:	0f b6 d0             	movzbl %al,%edx
  80185a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80185d:	8a 00                	mov    (%eax),%al
  80185f:	0f b6 c0             	movzbl %al,%eax
  801862:	29 c2                	sub    %eax,%edx
  801864:	89 d0                	mov    %edx,%eax
  801866:	eb 18                	jmp    801880 <memcmp+0x50>
		s1++, s2++;
  801868:	ff 45 fc             	incl   -0x4(%ebp)
  80186b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80186e:	8b 45 10             	mov    0x10(%ebp),%eax
  801871:	8d 50 ff             	lea    -0x1(%eax),%edx
  801874:	89 55 10             	mov    %edx,0x10(%ebp)
  801877:	85 c0                	test   %eax,%eax
  801879:	75 c9                	jne    801844 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80187b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801880:	c9                   	leave  
  801881:	c3                   	ret    

00801882 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801882:	55                   	push   %ebp
  801883:	89 e5                	mov    %esp,%ebp
  801885:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801888:	8b 55 08             	mov    0x8(%ebp),%edx
  80188b:	8b 45 10             	mov    0x10(%ebp),%eax
  80188e:	01 d0                	add    %edx,%eax
  801890:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801893:	eb 15                	jmp    8018aa <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801895:	8b 45 08             	mov    0x8(%ebp),%eax
  801898:	8a 00                	mov    (%eax),%al
  80189a:	0f b6 d0             	movzbl %al,%edx
  80189d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a0:	0f b6 c0             	movzbl %al,%eax
  8018a3:	39 c2                	cmp    %eax,%edx
  8018a5:	74 0d                	je     8018b4 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8018a7:	ff 45 08             	incl   0x8(%ebp)
  8018aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ad:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8018b0:	72 e3                	jb     801895 <memfind+0x13>
  8018b2:	eb 01                	jmp    8018b5 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8018b4:	90                   	nop
	return (void *) s;
  8018b5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8018b8:	c9                   	leave  
  8018b9:	c3                   	ret    

008018ba <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8018ba:	55                   	push   %ebp
  8018bb:	89 e5                	mov    %esp,%ebp
  8018bd:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8018c0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8018c7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8018ce:	eb 03                	jmp    8018d3 <strtol+0x19>
		s++;
  8018d0:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8018d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d6:	8a 00                	mov    (%eax),%al
  8018d8:	3c 20                	cmp    $0x20,%al
  8018da:	74 f4                	je     8018d0 <strtol+0x16>
  8018dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018df:	8a 00                	mov    (%eax),%al
  8018e1:	3c 09                	cmp    $0x9,%al
  8018e3:	74 eb                	je     8018d0 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8018e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e8:	8a 00                	mov    (%eax),%al
  8018ea:	3c 2b                	cmp    $0x2b,%al
  8018ec:	75 05                	jne    8018f3 <strtol+0x39>
		s++;
  8018ee:	ff 45 08             	incl   0x8(%ebp)
  8018f1:	eb 13                	jmp    801906 <strtol+0x4c>
	else if (*s == '-')
  8018f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f6:	8a 00                	mov    (%eax),%al
  8018f8:	3c 2d                	cmp    $0x2d,%al
  8018fa:	75 0a                	jne    801906 <strtol+0x4c>
		s++, neg = 1;
  8018fc:	ff 45 08             	incl   0x8(%ebp)
  8018ff:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801906:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80190a:	74 06                	je     801912 <strtol+0x58>
  80190c:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801910:	75 20                	jne    801932 <strtol+0x78>
  801912:	8b 45 08             	mov    0x8(%ebp),%eax
  801915:	8a 00                	mov    (%eax),%al
  801917:	3c 30                	cmp    $0x30,%al
  801919:	75 17                	jne    801932 <strtol+0x78>
  80191b:	8b 45 08             	mov    0x8(%ebp),%eax
  80191e:	40                   	inc    %eax
  80191f:	8a 00                	mov    (%eax),%al
  801921:	3c 78                	cmp    $0x78,%al
  801923:	75 0d                	jne    801932 <strtol+0x78>
		s += 2, base = 16;
  801925:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801929:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801930:	eb 28                	jmp    80195a <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801932:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801936:	75 15                	jne    80194d <strtol+0x93>
  801938:	8b 45 08             	mov    0x8(%ebp),%eax
  80193b:	8a 00                	mov    (%eax),%al
  80193d:	3c 30                	cmp    $0x30,%al
  80193f:	75 0c                	jne    80194d <strtol+0x93>
		s++, base = 8;
  801941:	ff 45 08             	incl   0x8(%ebp)
  801944:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80194b:	eb 0d                	jmp    80195a <strtol+0xa0>
	else if (base == 0)
  80194d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801951:	75 07                	jne    80195a <strtol+0xa0>
		base = 10;
  801953:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80195a:	8b 45 08             	mov    0x8(%ebp),%eax
  80195d:	8a 00                	mov    (%eax),%al
  80195f:	3c 2f                	cmp    $0x2f,%al
  801961:	7e 19                	jle    80197c <strtol+0xc2>
  801963:	8b 45 08             	mov    0x8(%ebp),%eax
  801966:	8a 00                	mov    (%eax),%al
  801968:	3c 39                	cmp    $0x39,%al
  80196a:	7f 10                	jg     80197c <strtol+0xc2>
			dig = *s - '0';
  80196c:	8b 45 08             	mov    0x8(%ebp),%eax
  80196f:	8a 00                	mov    (%eax),%al
  801971:	0f be c0             	movsbl %al,%eax
  801974:	83 e8 30             	sub    $0x30,%eax
  801977:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80197a:	eb 42                	jmp    8019be <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80197c:	8b 45 08             	mov    0x8(%ebp),%eax
  80197f:	8a 00                	mov    (%eax),%al
  801981:	3c 60                	cmp    $0x60,%al
  801983:	7e 19                	jle    80199e <strtol+0xe4>
  801985:	8b 45 08             	mov    0x8(%ebp),%eax
  801988:	8a 00                	mov    (%eax),%al
  80198a:	3c 7a                	cmp    $0x7a,%al
  80198c:	7f 10                	jg     80199e <strtol+0xe4>
			dig = *s - 'a' + 10;
  80198e:	8b 45 08             	mov    0x8(%ebp),%eax
  801991:	8a 00                	mov    (%eax),%al
  801993:	0f be c0             	movsbl %al,%eax
  801996:	83 e8 57             	sub    $0x57,%eax
  801999:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80199c:	eb 20                	jmp    8019be <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80199e:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a1:	8a 00                	mov    (%eax),%al
  8019a3:	3c 40                	cmp    $0x40,%al
  8019a5:	7e 39                	jle    8019e0 <strtol+0x126>
  8019a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019aa:	8a 00                	mov    (%eax),%al
  8019ac:	3c 5a                	cmp    $0x5a,%al
  8019ae:	7f 30                	jg     8019e0 <strtol+0x126>
			dig = *s - 'A' + 10;
  8019b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b3:	8a 00                	mov    (%eax),%al
  8019b5:	0f be c0             	movsbl %al,%eax
  8019b8:	83 e8 37             	sub    $0x37,%eax
  8019bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8019be:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019c1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8019c4:	7d 19                	jge    8019df <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8019c6:	ff 45 08             	incl   0x8(%ebp)
  8019c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019cc:	0f af 45 10          	imul   0x10(%ebp),%eax
  8019d0:	89 c2                	mov    %eax,%edx
  8019d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019d5:	01 d0                	add    %edx,%eax
  8019d7:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8019da:	e9 7b ff ff ff       	jmp    80195a <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8019df:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8019e0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8019e4:	74 08                	je     8019ee <strtol+0x134>
		*endptr = (char *) s;
  8019e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019e9:	8b 55 08             	mov    0x8(%ebp),%edx
  8019ec:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8019ee:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8019f2:	74 07                	je     8019fb <strtol+0x141>
  8019f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019f7:	f7 d8                	neg    %eax
  8019f9:	eb 03                	jmp    8019fe <strtol+0x144>
  8019fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8019fe:	c9                   	leave  
  8019ff:	c3                   	ret    

00801a00 <ltostr>:

void
ltostr(long value, char *str)
{
  801a00:	55                   	push   %ebp
  801a01:	89 e5                	mov    %esp,%ebp
  801a03:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801a06:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801a0d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801a14:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801a18:	79 13                	jns    801a2d <ltostr+0x2d>
	{
		neg = 1;
  801a1a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801a21:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a24:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801a27:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801a2a:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801a2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a30:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801a35:	99                   	cltd   
  801a36:	f7 f9                	idiv   %ecx
  801a38:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801a3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a3e:	8d 50 01             	lea    0x1(%eax),%edx
  801a41:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801a44:	89 c2                	mov    %eax,%edx
  801a46:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a49:	01 d0                	add    %edx,%eax
  801a4b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801a4e:	83 c2 30             	add    $0x30,%edx
  801a51:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801a53:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a56:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801a5b:	f7 e9                	imul   %ecx
  801a5d:	c1 fa 02             	sar    $0x2,%edx
  801a60:	89 c8                	mov    %ecx,%eax
  801a62:	c1 f8 1f             	sar    $0x1f,%eax
  801a65:	29 c2                	sub    %eax,%edx
  801a67:	89 d0                	mov    %edx,%eax
  801a69:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801a6c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a6f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801a74:	f7 e9                	imul   %ecx
  801a76:	c1 fa 02             	sar    $0x2,%edx
  801a79:	89 c8                	mov    %ecx,%eax
  801a7b:	c1 f8 1f             	sar    $0x1f,%eax
  801a7e:	29 c2                	sub    %eax,%edx
  801a80:	89 d0                	mov    %edx,%eax
  801a82:	c1 e0 02             	shl    $0x2,%eax
  801a85:	01 d0                	add    %edx,%eax
  801a87:	01 c0                	add    %eax,%eax
  801a89:	29 c1                	sub    %eax,%ecx
  801a8b:	89 ca                	mov    %ecx,%edx
  801a8d:	85 d2                	test   %edx,%edx
  801a8f:	75 9c                	jne    801a2d <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801a91:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801a98:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a9b:	48                   	dec    %eax
  801a9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801a9f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801aa3:	74 3d                	je     801ae2 <ltostr+0xe2>
		start = 1 ;
  801aa5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801aac:	eb 34                	jmp    801ae2 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801aae:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801ab1:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ab4:	01 d0                	add    %edx,%eax
  801ab6:	8a 00                	mov    (%eax),%al
  801ab8:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801abb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801abe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ac1:	01 c2                	add    %eax,%edx
  801ac3:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801ac6:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ac9:	01 c8                	add    %ecx,%eax
  801acb:	8a 00                	mov    (%eax),%al
  801acd:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801acf:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801ad2:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ad5:	01 c2                	add    %eax,%edx
  801ad7:	8a 45 eb             	mov    -0x15(%ebp),%al
  801ada:	88 02                	mov    %al,(%edx)
		start++ ;
  801adc:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801adf:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801ae2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ae5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ae8:	7c c4                	jl     801aae <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801aea:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801aed:	8b 45 0c             	mov    0xc(%ebp),%eax
  801af0:	01 d0                	add    %edx,%eax
  801af2:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801af5:	90                   	nop
  801af6:	c9                   	leave  
  801af7:	c3                   	ret    

00801af8 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801af8:	55                   	push   %ebp
  801af9:	89 e5                	mov    %esp,%ebp
  801afb:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801afe:	ff 75 08             	pushl  0x8(%ebp)
  801b01:	e8 54 fa ff ff       	call   80155a <strlen>
  801b06:	83 c4 04             	add    $0x4,%esp
  801b09:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801b0c:	ff 75 0c             	pushl  0xc(%ebp)
  801b0f:	e8 46 fa ff ff       	call   80155a <strlen>
  801b14:	83 c4 04             	add    $0x4,%esp
  801b17:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801b1a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801b21:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801b28:	eb 17                	jmp    801b41 <strcconcat+0x49>
		final[s] = str1[s] ;
  801b2a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b2d:	8b 45 10             	mov    0x10(%ebp),%eax
  801b30:	01 c2                	add    %eax,%edx
  801b32:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801b35:	8b 45 08             	mov    0x8(%ebp),%eax
  801b38:	01 c8                	add    %ecx,%eax
  801b3a:	8a 00                	mov    (%eax),%al
  801b3c:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801b3e:	ff 45 fc             	incl   -0x4(%ebp)
  801b41:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b44:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801b47:	7c e1                	jl     801b2a <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801b49:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801b50:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801b57:	eb 1f                	jmp    801b78 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801b59:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b5c:	8d 50 01             	lea    0x1(%eax),%edx
  801b5f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801b62:	89 c2                	mov    %eax,%edx
  801b64:	8b 45 10             	mov    0x10(%ebp),%eax
  801b67:	01 c2                	add    %eax,%edx
  801b69:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801b6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b6f:	01 c8                	add    %ecx,%eax
  801b71:	8a 00                	mov    (%eax),%al
  801b73:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801b75:	ff 45 f8             	incl   -0x8(%ebp)
  801b78:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b7b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b7e:	7c d9                	jl     801b59 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801b80:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b83:	8b 45 10             	mov    0x10(%ebp),%eax
  801b86:	01 d0                	add    %edx,%eax
  801b88:	c6 00 00             	movb   $0x0,(%eax)
}
  801b8b:	90                   	nop
  801b8c:	c9                   	leave  
  801b8d:	c3                   	ret    

00801b8e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801b8e:	55                   	push   %ebp
  801b8f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801b91:	8b 45 14             	mov    0x14(%ebp),%eax
  801b94:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801b9a:	8b 45 14             	mov    0x14(%ebp),%eax
  801b9d:	8b 00                	mov    (%eax),%eax
  801b9f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ba6:	8b 45 10             	mov    0x10(%ebp),%eax
  801ba9:	01 d0                	add    %edx,%eax
  801bab:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801bb1:	eb 0c                	jmp    801bbf <strsplit+0x31>
			*string++ = 0;
  801bb3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb6:	8d 50 01             	lea    0x1(%eax),%edx
  801bb9:	89 55 08             	mov    %edx,0x8(%ebp)
  801bbc:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801bbf:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc2:	8a 00                	mov    (%eax),%al
  801bc4:	84 c0                	test   %al,%al
  801bc6:	74 18                	je     801be0 <strsplit+0x52>
  801bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bcb:	8a 00                	mov    (%eax),%al
  801bcd:	0f be c0             	movsbl %al,%eax
  801bd0:	50                   	push   %eax
  801bd1:	ff 75 0c             	pushl  0xc(%ebp)
  801bd4:	e8 13 fb ff ff       	call   8016ec <strchr>
  801bd9:	83 c4 08             	add    $0x8,%esp
  801bdc:	85 c0                	test   %eax,%eax
  801bde:	75 d3                	jne    801bb3 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801be0:	8b 45 08             	mov    0x8(%ebp),%eax
  801be3:	8a 00                	mov    (%eax),%al
  801be5:	84 c0                	test   %al,%al
  801be7:	74 5a                	je     801c43 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801be9:	8b 45 14             	mov    0x14(%ebp),%eax
  801bec:	8b 00                	mov    (%eax),%eax
  801bee:	83 f8 0f             	cmp    $0xf,%eax
  801bf1:	75 07                	jne    801bfa <strsplit+0x6c>
		{
			return 0;
  801bf3:	b8 00 00 00 00       	mov    $0x0,%eax
  801bf8:	eb 66                	jmp    801c60 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801bfa:	8b 45 14             	mov    0x14(%ebp),%eax
  801bfd:	8b 00                	mov    (%eax),%eax
  801bff:	8d 48 01             	lea    0x1(%eax),%ecx
  801c02:	8b 55 14             	mov    0x14(%ebp),%edx
  801c05:	89 0a                	mov    %ecx,(%edx)
  801c07:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c0e:	8b 45 10             	mov    0x10(%ebp),%eax
  801c11:	01 c2                	add    %eax,%edx
  801c13:	8b 45 08             	mov    0x8(%ebp),%eax
  801c16:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801c18:	eb 03                	jmp    801c1d <strsplit+0x8f>
			string++;
  801c1a:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c20:	8a 00                	mov    (%eax),%al
  801c22:	84 c0                	test   %al,%al
  801c24:	74 8b                	je     801bb1 <strsplit+0x23>
  801c26:	8b 45 08             	mov    0x8(%ebp),%eax
  801c29:	8a 00                	mov    (%eax),%al
  801c2b:	0f be c0             	movsbl %al,%eax
  801c2e:	50                   	push   %eax
  801c2f:	ff 75 0c             	pushl  0xc(%ebp)
  801c32:	e8 b5 fa ff ff       	call   8016ec <strchr>
  801c37:	83 c4 08             	add    $0x8,%esp
  801c3a:	85 c0                	test   %eax,%eax
  801c3c:	74 dc                	je     801c1a <strsplit+0x8c>
			string++;
	}
  801c3e:	e9 6e ff ff ff       	jmp    801bb1 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801c43:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801c44:	8b 45 14             	mov    0x14(%ebp),%eax
  801c47:	8b 00                	mov    (%eax),%eax
  801c49:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c50:	8b 45 10             	mov    0x10(%ebp),%eax
  801c53:	01 d0                	add    %edx,%eax
  801c55:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801c5b:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801c60:	c9                   	leave  
  801c61:	c3                   	ret    

00801c62 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801c62:	55                   	push   %ebp
  801c63:	89 e5                	mov    %esp,%ebp
  801c65:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  801c68:	e8 3b 09 00 00       	call   8025a8 <sys_isUHeapPlacementStrategyFIRSTFIT>
  801c6d:	85 c0                	test   %eax,%eax
  801c6f:	0f 84 3a 01 00 00    	je     801daf <malloc+0x14d>

		if(pl == 0){
  801c75:	a1 28 30 80 00       	mov    0x803028,%eax
  801c7a:	85 c0                	test   %eax,%eax
  801c7c:	75 24                	jne    801ca2 <malloc+0x40>
			for(int k = 0; k < Size; k++){
  801c7e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801c85:	eb 11                	jmp    801c98 <malloc+0x36>
				arr[k] = -10000;
  801c87:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c8a:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801c91:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801c95:	ff 45 f4             	incl   -0xc(%ebp)
  801c98:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c9b:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801ca0:	76 e5                	jbe    801c87 <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801ca2:	c7 05 28 30 80 00 01 	movl   $0x1,0x803028
  801ca9:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801cac:	8b 45 08             	mov    0x8(%ebp),%eax
  801caf:	c1 e8 0c             	shr    $0xc,%eax
  801cb2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  801cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb8:	25 ff 0f 00 00       	and    $0xfff,%eax
  801cbd:	85 c0                	test   %eax,%eax
  801cbf:	74 03                	je     801cc4 <malloc+0x62>
			x++;
  801cc1:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  801cc4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  801ccb:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801cd2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801cd9:	eb 66                	jmp    801d41 <malloc+0xdf>
			if( arr[k] == -10000){
  801cdb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801cde:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801ce5:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801cea:	75 52                	jne    801d3e <malloc+0xdc>
				uint32 w = 0 ;
  801cec:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  801cf3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801cf6:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  801cf9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801cfc:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801cff:	eb 09                	jmp    801d0a <malloc+0xa8>
  801d01:	ff 45 e0             	incl   -0x20(%ebp)
  801d04:	ff 45 dc             	incl   -0x24(%ebp)
  801d07:	ff 45 e4             	incl   -0x1c(%ebp)
  801d0a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801d0d:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801d12:	77 19                	ja     801d2d <malloc+0xcb>
  801d14:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801d17:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801d1e:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801d23:	75 08                	jne    801d2d <malloc+0xcb>
  801d25:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d28:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801d2b:	72 d4                	jb     801d01 <malloc+0x9f>
				if(w >= x){
  801d2d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d30:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801d33:	72 09                	jb     801d3e <malloc+0xdc>
					p = 1 ;
  801d35:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  801d3c:	eb 0d                	jmp    801d4b <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801d3e:	ff 45 e4             	incl   -0x1c(%ebp)
  801d41:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801d44:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801d49:	76 90                	jbe    801cdb <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  801d4b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801d4f:	75 0a                	jne    801d5b <malloc+0xf9>
  801d51:	b8 00 00 00 00       	mov    $0x0,%eax
  801d56:	e9 ca 01 00 00       	jmp    801f25 <malloc+0x2c3>
		int q = idx;
  801d5b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801d5e:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  801d61:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801d68:	eb 16                	jmp    801d80 <malloc+0x11e>
			arr[q++] = x;
  801d6a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801d6d:	8d 50 01             	lea    0x1(%eax),%edx
  801d70:	89 55 d8             	mov    %edx,-0x28(%ebp)
  801d73:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801d76:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  801d7d:	ff 45 d4             	incl   -0x2c(%ebp)
  801d80:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801d83:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801d86:	72 e2                	jb     801d6a <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801d88:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801d8b:	05 00 00 08 00       	add    $0x80000,%eax
  801d90:	c1 e0 0c             	shl    $0xc,%eax
  801d93:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  801d96:	83 ec 08             	sub    $0x8,%esp
  801d99:	ff 75 f0             	pushl  -0x10(%ebp)
  801d9c:	ff 75 ac             	pushl  -0x54(%ebp)
  801d9f:	e8 9b 04 00 00       	call   80223f <sys_allocateMem>
  801da4:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801da7:	8b 45 ac             	mov    -0x54(%ebp),%eax
  801daa:	e9 76 01 00 00       	jmp    801f25 <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  801daf:	e8 25 08 00 00       	call   8025d9 <sys_isUHeapPlacementStrategyBESTFIT>
  801db4:	85 c0                	test   %eax,%eax
  801db6:	0f 84 64 01 00 00    	je     801f20 <malloc+0x2be>
		if(pl == 0){
  801dbc:	a1 28 30 80 00       	mov    0x803028,%eax
  801dc1:	85 c0                	test   %eax,%eax
  801dc3:	75 24                	jne    801de9 <malloc+0x187>
			for(int k = 0; k < Size; k++){
  801dc5:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  801dcc:	eb 11                	jmp    801ddf <malloc+0x17d>
				arr[k] = -10000;
  801dce:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801dd1:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801dd8:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801ddc:	ff 45 d0             	incl   -0x30(%ebp)
  801ddf:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801de2:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801de7:	76 e5                	jbe    801dce <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801de9:	c7 05 28 30 80 00 01 	movl   $0x1,0x803028
  801df0:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801df3:	8b 45 08             	mov    0x8(%ebp),%eax
  801df6:	c1 e8 0c             	shr    $0xc,%eax
  801df9:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  801dfc:	8b 45 08             	mov    0x8(%ebp),%eax
  801dff:	25 ff 0f 00 00       	and    $0xfff,%eax
  801e04:	85 c0                	test   %eax,%eax
  801e06:	74 03                	je     801e0b <malloc+0x1a9>
			x++;
  801e08:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  801e0b:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  801e12:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  801e19:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  801e20:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  801e27:	e9 88 00 00 00       	jmp    801eb4 <malloc+0x252>
			if(arr[k] == -10000){
  801e2c:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801e2f:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801e36:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801e3b:	75 64                	jne    801ea1 <malloc+0x23f>
				uint32 w = 0 , i;
  801e3d:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  801e44:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801e47:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  801e4a:	eb 06                	jmp    801e52 <malloc+0x1f0>
  801e4c:	ff 45 b8             	incl   -0x48(%ebp)
  801e4f:	ff 45 b4             	incl   -0x4c(%ebp)
  801e52:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  801e59:	77 11                	ja     801e6c <malloc+0x20a>
  801e5b:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801e5e:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801e65:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801e6a:	74 e0                	je     801e4c <malloc+0x1ea>
				if(w <q && w >= x){
  801e6c:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801e6f:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  801e72:	73 24                	jae    801e98 <malloc+0x236>
  801e74:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801e77:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801e7a:	72 1c                	jb     801e98 <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  801e7c:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801e7f:	89 45 c8             	mov    %eax,-0x38(%ebp)
  801e82:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  801e89:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801e8c:	89 45 c0             	mov    %eax,-0x40(%ebp)
  801e8f:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801e92:	48                   	dec    %eax
  801e93:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801e96:	eb 19                	jmp    801eb1 <malloc+0x24f>
				}
				else {
					k = i - 1;
  801e98:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801e9b:	48                   	dec    %eax
  801e9c:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801e9f:	eb 10                	jmp    801eb1 <malloc+0x24f>
				}
			} else {
				k += arr[k];
  801ea1:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801ea4:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801eab:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  801eae:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  801eb1:	ff 45 bc             	incl   -0x44(%ebp)
  801eb4:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801eb7:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801ebc:	0f 86 6a ff ff ff    	jbe    801e2c <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  801ec2:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  801ec6:	75 07                	jne    801ecf <malloc+0x26d>
  801ec8:	b8 00 00 00 00       	mov    $0x0,%eax
  801ecd:	eb 56                	jmp    801f25 <malloc+0x2c3>
	    q = idx;
  801ecf:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801ed2:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  801ed5:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  801edc:	eb 16                	jmp    801ef4 <malloc+0x292>
			arr[q++] = x;
  801ede:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801ee1:	8d 50 01             	lea    0x1(%eax),%edx
  801ee4:	89 55 c8             	mov    %edx,-0x38(%ebp)
  801ee7:	8b 55 cc             	mov    -0x34(%ebp),%edx
  801eea:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  801ef1:	ff 45 b0             	incl   -0x50(%ebp)
  801ef4:	8b 45 b0             	mov    -0x50(%ebp),%eax
  801ef7:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801efa:	72 e2                	jb     801ede <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801efc:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801eff:	05 00 00 08 00       	add    $0x80000,%eax
  801f04:	c1 e0 0c             	shl    $0xc,%eax
  801f07:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  801f0a:	83 ec 08             	sub    $0x8,%esp
  801f0d:	ff 75 cc             	pushl  -0x34(%ebp)
  801f10:	ff 75 a8             	pushl  -0x58(%ebp)
  801f13:	e8 27 03 00 00       	call   80223f <sys_allocateMem>
  801f18:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801f1b:	8b 45 a8             	mov    -0x58(%ebp),%eax
  801f1e:	eb 05                	jmp    801f25 <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  801f20:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f25:	c9                   	leave  
  801f26:	c3                   	ret    

00801f27 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801f27:	55                   	push   %ebp
  801f28:	89 e5                	mov    %esp,%ebp
  801f2a:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  801f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f30:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801f33:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801f36:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801f3b:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  801f3e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f41:	05 00 00 00 80       	add    $0x80000000,%eax
  801f46:	c1 e8 0c             	shr    $0xc,%eax
  801f49:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801f50:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801f53:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801f5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f5d:	05 00 00 00 80       	add    $0x80000000,%eax
  801f62:	c1 e8 0c             	shr    $0xc,%eax
  801f65:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801f68:	eb 14                	jmp    801f7e <free+0x57>
		arr[j] = -10000;
  801f6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f6d:	c7 04 85 20 31 80 00 	movl   $0xffffd8f0,0x803120(,%eax,4)
  801f74:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  801f78:	ff 45 f4             	incl   -0xc(%ebp)
  801f7b:	ff 45 f0             	incl   -0x10(%ebp)
  801f7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f81:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801f84:	72 e4                	jb     801f6a <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  801f86:	8b 45 08             	mov    0x8(%ebp),%eax
  801f89:	83 ec 08             	sub    $0x8,%esp
  801f8c:	ff 75 e8             	pushl  -0x18(%ebp)
  801f8f:	50                   	push   %eax
  801f90:	e8 8e 02 00 00       	call   802223 <sys_freeMem>
  801f95:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  801f98:	90                   	nop
  801f99:	c9                   	leave  
  801f9a:	c3                   	ret    

00801f9b <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801f9b:	55                   	push   %ebp
  801f9c:	89 e5                	mov    %esp,%ebp
  801f9e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801fa1:	83 ec 04             	sub    $0x4,%esp
  801fa4:	68 d0 2f 80 00       	push   $0x802fd0
  801fa9:	68 9e 00 00 00       	push   $0x9e
  801fae:	68 f3 2f 80 00       	push   $0x802ff3
  801fb3:	e8 69 ec ff ff       	call   800c21 <_panic>

00801fb8 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801fb8:	55                   	push   %ebp
  801fb9:	89 e5                	mov    %esp,%ebp
  801fbb:	83 ec 18             	sub    $0x18,%esp
  801fbe:	8b 45 10             	mov    0x10(%ebp),%eax
  801fc1:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801fc4:	83 ec 04             	sub    $0x4,%esp
  801fc7:	68 d0 2f 80 00       	push   $0x802fd0
  801fcc:	68 a9 00 00 00       	push   $0xa9
  801fd1:	68 f3 2f 80 00       	push   $0x802ff3
  801fd6:	e8 46 ec ff ff       	call   800c21 <_panic>

00801fdb <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801fdb:	55                   	push   %ebp
  801fdc:	89 e5                	mov    %esp,%ebp
  801fde:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801fe1:	83 ec 04             	sub    $0x4,%esp
  801fe4:	68 d0 2f 80 00       	push   $0x802fd0
  801fe9:	68 af 00 00 00       	push   $0xaf
  801fee:	68 f3 2f 80 00       	push   $0x802ff3
  801ff3:	e8 29 ec ff ff       	call   800c21 <_panic>

00801ff8 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801ff8:	55                   	push   %ebp
  801ff9:	89 e5                	mov    %esp,%ebp
  801ffb:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ffe:	83 ec 04             	sub    $0x4,%esp
  802001:	68 d0 2f 80 00       	push   $0x802fd0
  802006:	68 b5 00 00 00       	push   $0xb5
  80200b:	68 f3 2f 80 00       	push   $0x802ff3
  802010:	e8 0c ec ff ff       	call   800c21 <_panic>

00802015 <expand>:
}

void expand(uint32 newSize)
{
  802015:	55                   	push   %ebp
  802016:	89 e5                	mov    %esp,%ebp
  802018:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80201b:	83 ec 04             	sub    $0x4,%esp
  80201e:	68 d0 2f 80 00       	push   $0x802fd0
  802023:	68 ba 00 00 00       	push   $0xba
  802028:	68 f3 2f 80 00       	push   $0x802ff3
  80202d:	e8 ef eb ff ff       	call   800c21 <_panic>

00802032 <shrink>:
}
void shrink(uint32 newSize)
{
  802032:	55                   	push   %ebp
  802033:	89 e5                	mov    %esp,%ebp
  802035:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802038:	83 ec 04             	sub    $0x4,%esp
  80203b:	68 d0 2f 80 00       	push   $0x802fd0
  802040:	68 be 00 00 00       	push   $0xbe
  802045:	68 f3 2f 80 00       	push   $0x802ff3
  80204a:	e8 d2 eb ff ff       	call   800c21 <_panic>

0080204f <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  80204f:	55                   	push   %ebp
  802050:	89 e5                	mov    %esp,%ebp
  802052:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802055:	83 ec 04             	sub    $0x4,%esp
  802058:	68 d0 2f 80 00       	push   $0x802fd0
  80205d:	68 c3 00 00 00       	push   $0xc3
  802062:	68 f3 2f 80 00       	push   $0x802ff3
  802067:	e8 b5 eb ff ff       	call   800c21 <_panic>

0080206c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80206c:	55                   	push   %ebp
  80206d:	89 e5                	mov    %esp,%ebp
  80206f:	57                   	push   %edi
  802070:	56                   	push   %esi
  802071:	53                   	push   %ebx
  802072:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802075:	8b 45 08             	mov    0x8(%ebp),%eax
  802078:	8b 55 0c             	mov    0xc(%ebp),%edx
  80207b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80207e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802081:	8b 7d 18             	mov    0x18(%ebp),%edi
  802084:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802087:	cd 30                	int    $0x30
  802089:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80208c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80208f:	83 c4 10             	add    $0x10,%esp
  802092:	5b                   	pop    %ebx
  802093:	5e                   	pop    %esi
  802094:	5f                   	pop    %edi
  802095:	5d                   	pop    %ebp
  802096:	c3                   	ret    

00802097 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802097:	55                   	push   %ebp
  802098:	89 e5                	mov    %esp,%ebp
  80209a:	83 ec 04             	sub    $0x4,%esp
  80209d:	8b 45 10             	mov    0x10(%ebp),%eax
  8020a0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8020a3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8020a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8020aa:	6a 00                	push   $0x0
  8020ac:	6a 00                	push   $0x0
  8020ae:	52                   	push   %edx
  8020af:	ff 75 0c             	pushl  0xc(%ebp)
  8020b2:	50                   	push   %eax
  8020b3:	6a 00                	push   $0x0
  8020b5:	e8 b2 ff ff ff       	call   80206c <syscall>
  8020ba:	83 c4 18             	add    $0x18,%esp
}
  8020bd:	90                   	nop
  8020be:	c9                   	leave  
  8020bf:	c3                   	ret    

008020c0 <sys_cgetc>:

int
sys_cgetc(void)
{
  8020c0:	55                   	push   %ebp
  8020c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8020c3:	6a 00                	push   $0x0
  8020c5:	6a 00                	push   $0x0
  8020c7:	6a 00                	push   $0x0
  8020c9:	6a 00                	push   $0x0
  8020cb:	6a 00                	push   $0x0
  8020cd:	6a 01                	push   $0x1
  8020cf:	e8 98 ff ff ff       	call   80206c <syscall>
  8020d4:	83 c4 18             	add    $0x18,%esp
}
  8020d7:	c9                   	leave  
  8020d8:	c3                   	ret    

008020d9 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8020d9:	55                   	push   %ebp
  8020da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8020dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8020df:	6a 00                	push   $0x0
  8020e1:	6a 00                	push   $0x0
  8020e3:	6a 00                	push   $0x0
  8020e5:	6a 00                	push   $0x0
  8020e7:	50                   	push   %eax
  8020e8:	6a 05                	push   $0x5
  8020ea:	e8 7d ff ff ff       	call   80206c <syscall>
  8020ef:	83 c4 18             	add    $0x18,%esp
}
  8020f2:	c9                   	leave  
  8020f3:	c3                   	ret    

008020f4 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8020f4:	55                   	push   %ebp
  8020f5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8020f7:	6a 00                	push   $0x0
  8020f9:	6a 00                	push   $0x0
  8020fb:	6a 00                	push   $0x0
  8020fd:	6a 00                	push   $0x0
  8020ff:	6a 00                	push   $0x0
  802101:	6a 02                	push   $0x2
  802103:	e8 64 ff ff ff       	call   80206c <syscall>
  802108:	83 c4 18             	add    $0x18,%esp
}
  80210b:	c9                   	leave  
  80210c:	c3                   	ret    

0080210d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80210d:	55                   	push   %ebp
  80210e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802110:	6a 00                	push   $0x0
  802112:	6a 00                	push   $0x0
  802114:	6a 00                	push   $0x0
  802116:	6a 00                	push   $0x0
  802118:	6a 00                	push   $0x0
  80211a:	6a 03                	push   $0x3
  80211c:	e8 4b ff ff ff       	call   80206c <syscall>
  802121:	83 c4 18             	add    $0x18,%esp
}
  802124:	c9                   	leave  
  802125:	c3                   	ret    

00802126 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802126:	55                   	push   %ebp
  802127:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802129:	6a 00                	push   $0x0
  80212b:	6a 00                	push   $0x0
  80212d:	6a 00                	push   $0x0
  80212f:	6a 00                	push   $0x0
  802131:	6a 00                	push   $0x0
  802133:	6a 04                	push   $0x4
  802135:	e8 32 ff ff ff       	call   80206c <syscall>
  80213a:	83 c4 18             	add    $0x18,%esp
}
  80213d:	c9                   	leave  
  80213e:	c3                   	ret    

0080213f <sys_env_exit>:


void sys_env_exit(void)
{
  80213f:	55                   	push   %ebp
  802140:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802142:	6a 00                	push   $0x0
  802144:	6a 00                	push   $0x0
  802146:	6a 00                	push   $0x0
  802148:	6a 00                	push   $0x0
  80214a:	6a 00                	push   $0x0
  80214c:	6a 06                	push   $0x6
  80214e:	e8 19 ff ff ff       	call   80206c <syscall>
  802153:	83 c4 18             	add    $0x18,%esp
}
  802156:	90                   	nop
  802157:	c9                   	leave  
  802158:	c3                   	ret    

00802159 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802159:	55                   	push   %ebp
  80215a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80215c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80215f:	8b 45 08             	mov    0x8(%ebp),%eax
  802162:	6a 00                	push   $0x0
  802164:	6a 00                	push   $0x0
  802166:	6a 00                	push   $0x0
  802168:	52                   	push   %edx
  802169:	50                   	push   %eax
  80216a:	6a 07                	push   $0x7
  80216c:	e8 fb fe ff ff       	call   80206c <syscall>
  802171:	83 c4 18             	add    $0x18,%esp
}
  802174:	c9                   	leave  
  802175:	c3                   	ret    

00802176 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802176:	55                   	push   %ebp
  802177:	89 e5                	mov    %esp,%ebp
  802179:	56                   	push   %esi
  80217a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80217b:	8b 75 18             	mov    0x18(%ebp),%esi
  80217e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802181:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802184:	8b 55 0c             	mov    0xc(%ebp),%edx
  802187:	8b 45 08             	mov    0x8(%ebp),%eax
  80218a:	56                   	push   %esi
  80218b:	53                   	push   %ebx
  80218c:	51                   	push   %ecx
  80218d:	52                   	push   %edx
  80218e:	50                   	push   %eax
  80218f:	6a 08                	push   $0x8
  802191:	e8 d6 fe ff ff       	call   80206c <syscall>
  802196:	83 c4 18             	add    $0x18,%esp
}
  802199:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80219c:	5b                   	pop    %ebx
  80219d:	5e                   	pop    %esi
  80219e:	5d                   	pop    %ebp
  80219f:	c3                   	ret    

008021a0 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8021a0:	55                   	push   %ebp
  8021a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8021a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	6a 00                	push   $0x0
  8021af:	52                   	push   %edx
  8021b0:	50                   	push   %eax
  8021b1:	6a 09                	push   $0x9
  8021b3:	e8 b4 fe ff ff       	call   80206c <syscall>
  8021b8:	83 c4 18             	add    $0x18,%esp
}
  8021bb:	c9                   	leave  
  8021bc:	c3                   	ret    

008021bd <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8021bd:	55                   	push   %ebp
  8021be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8021c0:	6a 00                	push   $0x0
  8021c2:	6a 00                	push   $0x0
  8021c4:	6a 00                	push   $0x0
  8021c6:	ff 75 0c             	pushl  0xc(%ebp)
  8021c9:	ff 75 08             	pushl  0x8(%ebp)
  8021cc:	6a 0a                	push   $0xa
  8021ce:	e8 99 fe ff ff       	call   80206c <syscall>
  8021d3:	83 c4 18             	add    $0x18,%esp
}
  8021d6:	c9                   	leave  
  8021d7:	c3                   	ret    

008021d8 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8021d8:	55                   	push   %ebp
  8021d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8021db:	6a 00                	push   $0x0
  8021dd:	6a 00                	push   $0x0
  8021df:	6a 00                	push   $0x0
  8021e1:	6a 00                	push   $0x0
  8021e3:	6a 00                	push   $0x0
  8021e5:	6a 0b                	push   $0xb
  8021e7:	e8 80 fe ff ff       	call   80206c <syscall>
  8021ec:	83 c4 18             	add    $0x18,%esp
}
  8021ef:	c9                   	leave  
  8021f0:	c3                   	ret    

008021f1 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8021f1:	55                   	push   %ebp
  8021f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8021f4:	6a 00                	push   $0x0
  8021f6:	6a 00                	push   $0x0
  8021f8:	6a 00                	push   $0x0
  8021fa:	6a 00                	push   $0x0
  8021fc:	6a 00                	push   $0x0
  8021fe:	6a 0c                	push   $0xc
  802200:	e8 67 fe ff ff       	call   80206c <syscall>
  802205:	83 c4 18             	add    $0x18,%esp
}
  802208:	c9                   	leave  
  802209:	c3                   	ret    

0080220a <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80220a:	55                   	push   %ebp
  80220b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80220d:	6a 00                	push   $0x0
  80220f:	6a 00                	push   $0x0
  802211:	6a 00                	push   $0x0
  802213:	6a 00                	push   $0x0
  802215:	6a 00                	push   $0x0
  802217:	6a 0d                	push   $0xd
  802219:	e8 4e fe ff ff       	call   80206c <syscall>
  80221e:	83 c4 18             	add    $0x18,%esp
}
  802221:	c9                   	leave  
  802222:	c3                   	ret    

00802223 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802223:	55                   	push   %ebp
  802224:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802226:	6a 00                	push   $0x0
  802228:	6a 00                	push   $0x0
  80222a:	6a 00                	push   $0x0
  80222c:	ff 75 0c             	pushl  0xc(%ebp)
  80222f:	ff 75 08             	pushl  0x8(%ebp)
  802232:	6a 11                	push   $0x11
  802234:	e8 33 fe ff ff       	call   80206c <syscall>
  802239:	83 c4 18             	add    $0x18,%esp
	return;
  80223c:	90                   	nop
}
  80223d:	c9                   	leave  
  80223e:	c3                   	ret    

0080223f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80223f:	55                   	push   %ebp
  802240:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802242:	6a 00                	push   $0x0
  802244:	6a 00                	push   $0x0
  802246:	6a 00                	push   $0x0
  802248:	ff 75 0c             	pushl  0xc(%ebp)
  80224b:	ff 75 08             	pushl  0x8(%ebp)
  80224e:	6a 12                	push   $0x12
  802250:	e8 17 fe ff ff       	call   80206c <syscall>
  802255:	83 c4 18             	add    $0x18,%esp
	return ;
  802258:	90                   	nop
}
  802259:	c9                   	leave  
  80225a:	c3                   	ret    

0080225b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80225b:	55                   	push   %ebp
  80225c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80225e:	6a 00                	push   $0x0
  802260:	6a 00                	push   $0x0
  802262:	6a 00                	push   $0x0
  802264:	6a 00                	push   $0x0
  802266:	6a 00                	push   $0x0
  802268:	6a 0e                	push   $0xe
  80226a:	e8 fd fd ff ff       	call   80206c <syscall>
  80226f:	83 c4 18             	add    $0x18,%esp
}
  802272:	c9                   	leave  
  802273:	c3                   	ret    

00802274 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802274:	55                   	push   %ebp
  802275:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802277:	6a 00                	push   $0x0
  802279:	6a 00                	push   $0x0
  80227b:	6a 00                	push   $0x0
  80227d:	6a 00                	push   $0x0
  80227f:	ff 75 08             	pushl  0x8(%ebp)
  802282:	6a 0f                	push   $0xf
  802284:	e8 e3 fd ff ff       	call   80206c <syscall>
  802289:	83 c4 18             	add    $0x18,%esp
}
  80228c:	c9                   	leave  
  80228d:	c3                   	ret    

0080228e <sys_scarce_memory>:

void sys_scarce_memory()
{
  80228e:	55                   	push   %ebp
  80228f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802291:	6a 00                	push   $0x0
  802293:	6a 00                	push   $0x0
  802295:	6a 00                	push   $0x0
  802297:	6a 00                	push   $0x0
  802299:	6a 00                	push   $0x0
  80229b:	6a 10                	push   $0x10
  80229d:	e8 ca fd ff ff       	call   80206c <syscall>
  8022a2:	83 c4 18             	add    $0x18,%esp
}
  8022a5:	90                   	nop
  8022a6:	c9                   	leave  
  8022a7:	c3                   	ret    

008022a8 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8022a8:	55                   	push   %ebp
  8022a9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8022ab:	6a 00                	push   $0x0
  8022ad:	6a 00                	push   $0x0
  8022af:	6a 00                	push   $0x0
  8022b1:	6a 00                	push   $0x0
  8022b3:	6a 00                	push   $0x0
  8022b5:	6a 14                	push   $0x14
  8022b7:	e8 b0 fd ff ff       	call   80206c <syscall>
  8022bc:	83 c4 18             	add    $0x18,%esp
}
  8022bf:	90                   	nop
  8022c0:	c9                   	leave  
  8022c1:	c3                   	ret    

008022c2 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8022c2:	55                   	push   %ebp
  8022c3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8022c5:	6a 00                	push   $0x0
  8022c7:	6a 00                	push   $0x0
  8022c9:	6a 00                	push   $0x0
  8022cb:	6a 00                	push   $0x0
  8022cd:	6a 00                	push   $0x0
  8022cf:	6a 15                	push   $0x15
  8022d1:	e8 96 fd ff ff       	call   80206c <syscall>
  8022d6:	83 c4 18             	add    $0x18,%esp
}
  8022d9:	90                   	nop
  8022da:	c9                   	leave  
  8022db:	c3                   	ret    

008022dc <sys_cputc>:


void
sys_cputc(const char c)
{
  8022dc:	55                   	push   %ebp
  8022dd:	89 e5                	mov    %esp,%ebp
  8022df:	83 ec 04             	sub    $0x4,%esp
  8022e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8022e5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8022e8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8022ec:	6a 00                	push   $0x0
  8022ee:	6a 00                	push   $0x0
  8022f0:	6a 00                	push   $0x0
  8022f2:	6a 00                	push   $0x0
  8022f4:	50                   	push   %eax
  8022f5:	6a 16                	push   $0x16
  8022f7:	e8 70 fd ff ff       	call   80206c <syscall>
  8022fc:	83 c4 18             	add    $0x18,%esp
}
  8022ff:	90                   	nop
  802300:	c9                   	leave  
  802301:	c3                   	ret    

00802302 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802302:	55                   	push   %ebp
  802303:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802305:	6a 00                	push   $0x0
  802307:	6a 00                	push   $0x0
  802309:	6a 00                	push   $0x0
  80230b:	6a 00                	push   $0x0
  80230d:	6a 00                	push   $0x0
  80230f:	6a 17                	push   $0x17
  802311:	e8 56 fd ff ff       	call   80206c <syscall>
  802316:	83 c4 18             	add    $0x18,%esp
}
  802319:	90                   	nop
  80231a:	c9                   	leave  
  80231b:	c3                   	ret    

0080231c <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80231c:	55                   	push   %ebp
  80231d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80231f:	8b 45 08             	mov    0x8(%ebp),%eax
  802322:	6a 00                	push   $0x0
  802324:	6a 00                	push   $0x0
  802326:	6a 00                	push   $0x0
  802328:	ff 75 0c             	pushl  0xc(%ebp)
  80232b:	50                   	push   %eax
  80232c:	6a 18                	push   $0x18
  80232e:	e8 39 fd ff ff       	call   80206c <syscall>
  802333:	83 c4 18             	add    $0x18,%esp
}
  802336:	c9                   	leave  
  802337:	c3                   	ret    

00802338 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802338:	55                   	push   %ebp
  802339:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80233b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80233e:	8b 45 08             	mov    0x8(%ebp),%eax
  802341:	6a 00                	push   $0x0
  802343:	6a 00                	push   $0x0
  802345:	6a 00                	push   $0x0
  802347:	52                   	push   %edx
  802348:	50                   	push   %eax
  802349:	6a 1b                	push   $0x1b
  80234b:	e8 1c fd ff ff       	call   80206c <syscall>
  802350:	83 c4 18             	add    $0x18,%esp
}
  802353:	c9                   	leave  
  802354:	c3                   	ret    

00802355 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802355:	55                   	push   %ebp
  802356:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802358:	8b 55 0c             	mov    0xc(%ebp),%edx
  80235b:	8b 45 08             	mov    0x8(%ebp),%eax
  80235e:	6a 00                	push   $0x0
  802360:	6a 00                	push   $0x0
  802362:	6a 00                	push   $0x0
  802364:	52                   	push   %edx
  802365:	50                   	push   %eax
  802366:	6a 19                	push   $0x19
  802368:	e8 ff fc ff ff       	call   80206c <syscall>
  80236d:	83 c4 18             	add    $0x18,%esp
}
  802370:	90                   	nop
  802371:	c9                   	leave  
  802372:	c3                   	ret    

00802373 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802373:	55                   	push   %ebp
  802374:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802376:	8b 55 0c             	mov    0xc(%ebp),%edx
  802379:	8b 45 08             	mov    0x8(%ebp),%eax
  80237c:	6a 00                	push   $0x0
  80237e:	6a 00                	push   $0x0
  802380:	6a 00                	push   $0x0
  802382:	52                   	push   %edx
  802383:	50                   	push   %eax
  802384:	6a 1a                	push   $0x1a
  802386:	e8 e1 fc ff ff       	call   80206c <syscall>
  80238b:	83 c4 18             	add    $0x18,%esp
}
  80238e:	90                   	nop
  80238f:	c9                   	leave  
  802390:	c3                   	ret    

00802391 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802391:	55                   	push   %ebp
  802392:	89 e5                	mov    %esp,%ebp
  802394:	83 ec 04             	sub    $0x4,%esp
  802397:	8b 45 10             	mov    0x10(%ebp),%eax
  80239a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80239d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8023a0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8023a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8023a7:	6a 00                	push   $0x0
  8023a9:	51                   	push   %ecx
  8023aa:	52                   	push   %edx
  8023ab:	ff 75 0c             	pushl  0xc(%ebp)
  8023ae:	50                   	push   %eax
  8023af:	6a 1c                	push   $0x1c
  8023b1:	e8 b6 fc ff ff       	call   80206c <syscall>
  8023b6:	83 c4 18             	add    $0x18,%esp
}
  8023b9:	c9                   	leave  
  8023ba:	c3                   	ret    

008023bb <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8023bb:	55                   	push   %ebp
  8023bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8023be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8023c4:	6a 00                	push   $0x0
  8023c6:	6a 00                	push   $0x0
  8023c8:	6a 00                	push   $0x0
  8023ca:	52                   	push   %edx
  8023cb:	50                   	push   %eax
  8023cc:	6a 1d                	push   $0x1d
  8023ce:	e8 99 fc ff ff       	call   80206c <syscall>
  8023d3:	83 c4 18             	add    $0x18,%esp
}
  8023d6:	c9                   	leave  
  8023d7:	c3                   	ret    

008023d8 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8023d8:	55                   	push   %ebp
  8023d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8023db:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8023de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8023e4:	6a 00                	push   $0x0
  8023e6:	6a 00                	push   $0x0
  8023e8:	51                   	push   %ecx
  8023e9:	52                   	push   %edx
  8023ea:	50                   	push   %eax
  8023eb:	6a 1e                	push   $0x1e
  8023ed:	e8 7a fc ff ff       	call   80206c <syscall>
  8023f2:	83 c4 18             	add    $0x18,%esp
}
  8023f5:	c9                   	leave  
  8023f6:	c3                   	ret    

008023f7 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8023f7:	55                   	push   %ebp
  8023f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8023fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023fd:	8b 45 08             	mov    0x8(%ebp),%eax
  802400:	6a 00                	push   $0x0
  802402:	6a 00                	push   $0x0
  802404:	6a 00                	push   $0x0
  802406:	52                   	push   %edx
  802407:	50                   	push   %eax
  802408:	6a 1f                	push   $0x1f
  80240a:	e8 5d fc ff ff       	call   80206c <syscall>
  80240f:	83 c4 18             	add    $0x18,%esp
}
  802412:	c9                   	leave  
  802413:	c3                   	ret    

00802414 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802414:	55                   	push   %ebp
  802415:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802417:	6a 00                	push   $0x0
  802419:	6a 00                	push   $0x0
  80241b:	6a 00                	push   $0x0
  80241d:	6a 00                	push   $0x0
  80241f:	6a 00                	push   $0x0
  802421:	6a 20                	push   $0x20
  802423:	e8 44 fc ff ff       	call   80206c <syscall>
  802428:	83 c4 18             	add    $0x18,%esp
}
  80242b:	c9                   	leave  
  80242c:	c3                   	ret    

0080242d <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80242d:	55                   	push   %ebp
  80242e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802430:	8b 45 08             	mov    0x8(%ebp),%eax
  802433:	6a 00                	push   $0x0
  802435:	ff 75 14             	pushl  0x14(%ebp)
  802438:	ff 75 10             	pushl  0x10(%ebp)
  80243b:	ff 75 0c             	pushl  0xc(%ebp)
  80243e:	50                   	push   %eax
  80243f:	6a 21                	push   $0x21
  802441:	e8 26 fc ff ff       	call   80206c <syscall>
  802446:	83 c4 18             	add    $0x18,%esp
}
  802449:	c9                   	leave  
  80244a:	c3                   	ret    

0080244b <sys_run_env>:


void
sys_run_env(int32 envId)
{
  80244b:	55                   	push   %ebp
  80244c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80244e:	8b 45 08             	mov    0x8(%ebp),%eax
  802451:	6a 00                	push   $0x0
  802453:	6a 00                	push   $0x0
  802455:	6a 00                	push   $0x0
  802457:	6a 00                	push   $0x0
  802459:	50                   	push   %eax
  80245a:	6a 22                	push   $0x22
  80245c:	e8 0b fc ff ff       	call   80206c <syscall>
  802461:	83 c4 18             	add    $0x18,%esp
}
  802464:	90                   	nop
  802465:	c9                   	leave  
  802466:	c3                   	ret    

00802467 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802467:	55                   	push   %ebp
  802468:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80246a:	8b 45 08             	mov    0x8(%ebp),%eax
  80246d:	6a 00                	push   $0x0
  80246f:	6a 00                	push   $0x0
  802471:	6a 00                	push   $0x0
  802473:	6a 00                	push   $0x0
  802475:	50                   	push   %eax
  802476:	6a 23                	push   $0x23
  802478:	e8 ef fb ff ff       	call   80206c <syscall>
  80247d:	83 c4 18             	add    $0x18,%esp
}
  802480:	90                   	nop
  802481:	c9                   	leave  
  802482:	c3                   	ret    

00802483 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802483:	55                   	push   %ebp
  802484:	89 e5                	mov    %esp,%ebp
  802486:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802489:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80248c:	8d 50 04             	lea    0x4(%eax),%edx
  80248f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802492:	6a 00                	push   $0x0
  802494:	6a 00                	push   $0x0
  802496:	6a 00                	push   $0x0
  802498:	52                   	push   %edx
  802499:	50                   	push   %eax
  80249a:	6a 24                	push   $0x24
  80249c:	e8 cb fb ff ff       	call   80206c <syscall>
  8024a1:	83 c4 18             	add    $0x18,%esp
	return result;
  8024a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8024a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8024aa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8024ad:	89 01                	mov    %eax,(%ecx)
  8024af:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8024b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8024b5:	c9                   	leave  
  8024b6:	c2 04 00             	ret    $0x4

008024b9 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8024b9:	55                   	push   %ebp
  8024ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8024bc:	6a 00                	push   $0x0
  8024be:	6a 00                	push   $0x0
  8024c0:	ff 75 10             	pushl  0x10(%ebp)
  8024c3:	ff 75 0c             	pushl  0xc(%ebp)
  8024c6:	ff 75 08             	pushl  0x8(%ebp)
  8024c9:	6a 13                	push   $0x13
  8024cb:	e8 9c fb ff ff       	call   80206c <syscall>
  8024d0:	83 c4 18             	add    $0x18,%esp
	return ;
  8024d3:	90                   	nop
}
  8024d4:	c9                   	leave  
  8024d5:	c3                   	ret    

008024d6 <sys_rcr2>:
uint32 sys_rcr2()
{
  8024d6:	55                   	push   %ebp
  8024d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8024d9:	6a 00                	push   $0x0
  8024db:	6a 00                	push   $0x0
  8024dd:	6a 00                	push   $0x0
  8024df:	6a 00                	push   $0x0
  8024e1:	6a 00                	push   $0x0
  8024e3:	6a 25                	push   $0x25
  8024e5:	e8 82 fb ff ff       	call   80206c <syscall>
  8024ea:	83 c4 18             	add    $0x18,%esp
}
  8024ed:	c9                   	leave  
  8024ee:	c3                   	ret    

008024ef <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8024ef:	55                   	push   %ebp
  8024f0:	89 e5                	mov    %esp,%ebp
  8024f2:	83 ec 04             	sub    $0x4,%esp
  8024f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8024f8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8024fb:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8024ff:	6a 00                	push   $0x0
  802501:	6a 00                	push   $0x0
  802503:	6a 00                	push   $0x0
  802505:	6a 00                	push   $0x0
  802507:	50                   	push   %eax
  802508:	6a 26                	push   $0x26
  80250a:	e8 5d fb ff ff       	call   80206c <syscall>
  80250f:	83 c4 18             	add    $0x18,%esp
	return ;
  802512:	90                   	nop
}
  802513:	c9                   	leave  
  802514:	c3                   	ret    

00802515 <rsttst>:
void rsttst()
{
  802515:	55                   	push   %ebp
  802516:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802518:	6a 00                	push   $0x0
  80251a:	6a 00                	push   $0x0
  80251c:	6a 00                	push   $0x0
  80251e:	6a 00                	push   $0x0
  802520:	6a 00                	push   $0x0
  802522:	6a 28                	push   $0x28
  802524:	e8 43 fb ff ff       	call   80206c <syscall>
  802529:	83 c4 18             	add    $0x18,%esp
	return ;
  80252c:	90                   	nop
}
  80252d:	c9                   	leave  
  80252e:	c3                   	ret    

0080252f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80252f:	55                   	push   %ebp
  802530:	89 e5                	mov    %esp,%ebp
  802532:	83 ec 04             	sub    $0x4,%esp
  802535:	8b 45 14             	mov    0x14(%ebp),%eax
  802538:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80253b:	8b 55 18             	mov    0x18(%ebp),%edx
  80253e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802542:	52                   	push   %edx
  802543:	50                   	push   %eax
  802544:	ff 75 10             	pushl  0x10(%ebp)
  802547:	ff 75 0c             	pushl  0xc(%ebp)
  80254a:	ff 75 08             	pushl  0x8(%ebp)
  80254d:	6a 27                	push   $0x27
  80254f:	e8 18 fb ff ff       	call   80206c <syscall>
  802554:	83 c4 18             	add    $0x18,%esp
	return ;
  802557:	90                   	nop
}
  802558:	c9                   	leave  
  802559:	c3                   	ret    

0080255a <chktst>:
void chktst(uint32 n)
{
  80255a:	55                   	push   %ebp
  80255b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80255d:	6a 00                	push   $0x0
  80255f:	6a 00                	push   $0x0
  802561:	6a 00                	push   $0x0
  802563:	6a 00                	push   $0x0
  802565:	ff 75 08             	pushl  0x8(%ebp)
  802568:	6a 29                	push   $0x29
  80256a:	e8 fd fa ff ff       	call   80206c <syscall>
  80256f:	83 c4 18             	add    $0x18,%esp
	return ;
  802572:	90                   	nop
}
  802573:	c9                   	leave  
  802574:	c3                   	ret    

00802575 <inctst>:

void inctst()
{
  802575:	55                   	push   %ebp
  802576:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802578:	6a 00                	push   $0x0
  80257a:	6a 00                	push   $0x0
  80257c:	6a 00                	push   $0x0
  80257e:	6a 00                	push   $0x0
  802580:	6a 00                	push   $0x0
  802582:	6a 2a                	push   $0x2a
  802584:	e8 e3 fa ff ff       	call   80206c <syscall>
  802589:	83 c4 18             	add    $0x18,%esp
	return ;
  80258c:	90                   	nop
}
  80258d:	c9                   	leave  
  80258e:	c3                   	ret    

0080258f <gettst>:
uint32 gettst()
{
  80258f:	55                   	push   %ebp
  802590:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802592:	6a 00                	push   $0x0
  802594:	6a 00                	push   $0x0
  802596:	6a 00                	push   $0x0
  802598:	6a 00                	push   $0x0
  80259a:	6a 00                	push   $0x0
  80259c:	6a 2b                	push   $0x2b
  80259e:	e8 c9 fa ff ff       	call   80206c <syscall>
  8025a3:	83 c4 18             	add    $0x18,%esp
}
  8025a6:	c9                   	leave  
  8025a7:	c3                   	ret    

008025a8 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8025a8:	55                   	push   %ebp
  8025a9:	89 e5                	mov    %esp,%ebp
  8025ab:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8025ae:	6a 00                	push   $0x0
  8025b0:	6a 00                	push   $0x0
  8025b2:	6a 00                	push   $0x0
  8025b4:	6a 00                	push   $0x0
  8025b6:	6a 00                	push   $0x0
  8025b8:	6a 2c                	push   $0x2c
  8025ba:	e8 ad fa ff ff       	call   80206c <syscall>
  8025bf:	83 c4 18             	add    $0x18,%esp
  8025c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8025c5:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8025c9:	75 07                	jne    8025d2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8025cb:	b8 01 00 00 00       	mov    $0x1,%eax
  8025d0:	eb 05                	jmp    8025d7 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8025d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8025d7:	c9                   	leave  
  8025d8:	c3                   	ret    

008025d9 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8025d9:	55                   	push   %ebp
  8025da:	89 e5                	mov    %esp,%ebp
  8025dc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8025df:	6a 00                	push   $0x0
  8025e1:	6a 00                	push   $0x0
  8025e3:	6a 00                	push   $0x0
  8025e5:	6a 00                	push   $0x0
  8025e7:	6a 00                	push   $0x0
  8025e9:	6a 2c                	push   $0x2c
  8025eb:	e8 7c fa ff ff       	call   80206c <syscall>
  8025f0:	83 c4 18             	add    $0x18,%esp
  8025f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8025f6:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8025fa:	75 07                	jne    802603 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8025fc:	b8 01 00 00 00       	mov    $0x1,%eax
  802601:	eb 05                	jmp    802608 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802603:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802608:	c9                   	leave  
  802609:	c3                   	ret    

0080260a <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80260a:	55                   	push   %ebp
  80260b:	89 e5                	mov    %esp,%ebp
  80260d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802610:	6a 00                	push   $0x0
  802612:	6a 00                	push   $0x0
  802614:	6a 00                	push   $0x0
  802616:	6a 00                	push   $0x0
  802618:	6a 00                	push   $0x0
  80261a:	6a 2c                	push   $0x2c
  80261c:	e8 4b fa ff ff       	call   80206c <syscall>
  802621:	83 c4 18             	add    $0x18,%esp
  802624:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802627:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80262b:	75 07                	jne    802634 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80262d:	b8 01 00 00 00       	mov    $0x1,%eax
  802632:	eb 05                	jmp    802639 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802634:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802639:	c9                   	leave  
  80263a:	c3                   	ret    

0080263b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80263b:	55                   	push   %ebp
  80263c:	89 e5                	mov    %esp,%ebp
  80263e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802641:	6a 00                	push   $0x0
  802643:	6a 00                	push   $0x0
  802645:	6a 00                	push   $0x0
  802647:	6a 00                	push   $0x0
  802649:	6a 00                	push   $0x0
  80264b:	6a 2c                	push   $0x2c
  80264d:	e8 1a fa ff ff       	call   80206c <syscall>
  802652:	83 c4 18             	add    $0x18,%esp
  802655:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802658:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80265c:	75 07                	jne    802665 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80265e:	b8 01 00 00 00       	mov    $0x1,%eax
  802663:	eb 05                	jmp    80266a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802665:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80266a:	c9                   	leave  
  80266b:	c3                   	ret    

0080266c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80266c:	55                   	push   %ebp
  80266d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80266f:	6a 00                	push   $0x0
  802671:	6a 00                	push   $0x0
  802673:	6a 00                	push   $0x0
  802675:	6a 00                	push   $0x0
  802677:	ff 75 08             	pushl  0x8(%ebp)
  80267a:	6a 2d                	push   $0x2d
  80267c:	e8 eb f9 ff ff       	call   80206c <syscall>
  802681:	83 c4 18             	add    $0x18,%esp
	return ;
  802684:	90                   	nop
}
  802685:	c9                   	leave  
  802686:	c3                   	ret    

00802687 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802687:	55                   	push   %ebp
  802688:	89 e5                	mov    %esp,%ebp
  80268a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80268b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80268e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802691:	8b 55 0c             	mov    0xc(%ebp),%edx
  802694:	8b 45 08             	mov    0x8(%ebp),%eax
  802697:	6a 00                	push   $0x0
  802699:	53                   	push   %ebx
  80269a:	51                   	push   %ecx
  80269b:	52                   	push   %edx
  80269c:	50                   	push   %eax
  80269d:	6a 2e                	push   $0x2e
  80269f:	e8 c8 f9 ff ff       	call   80206c <syscall>
  8026a4:	83 c4 18             	add    $0x18,%esp
}
  8026a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8026aa:	c9                   	leave  
  8026ab:	c3                   	ret    

008026ac <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8026ac:	55                   	push   %ebp
  8026ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8026af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8026b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8026b5:	6a 00                	push   $0x0
  8026b7:	6a 00                	push   $0x0
  8026b9:	6a 00                	push   $0x0
  8026bb:	52                   	push   %edx
  8026bc:	50                   	push   %eax
  8026bd:	6a 2f                	push   $0x2f
  8026bf:	e8 a8 f9 ff ff       	call   80206c <syscall>
  8026c4:	83 c4 18             	add    $0x18,%esp
}
  8026c7:	c9                   	leave  
  8026c8:	c3                   	ret    

008026c9 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8026c9:	55                   	push   %ebp
  8026ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8026cc:	6a 00                	push   $0x0
  8026ce:	6a 00                	push   $0x0
  8026d0:	6a 00                	push   $0x0
  8026d2:	ff 75 0c             	pushl  0xc(%ebp)
  8026d5:	ff 75 08             	pushl  0x8(%ebp)
  8026d8:	6a 30                	push   $0x30
  8026da:	e8 8d f9 ff ff       	call   80206c <syscall>
  8026df:	83 c4 18             	add    $0x18,%esp
	return ;
  8026e2:	90                   	nop
}
  8026e3:	c9                   	leave  
  8026e4:	c3                   	ret    
  8026e5:	66 90                	xchg   %ax,%ax
  8026e7:	90                   	nop

008026e8 <__udivdi3>:
  8026e8:	55                   	push   %ebp
  8026e9:	57                   	push   %edi
  8026ea:	56                   	push   %esi
  8026eb:	53                   	push   %ebx
  8026ec:	83 ec 1c             	sub    $0x1c,%esp
  8026ef:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8026f3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8026f7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8026fb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8026ff:	89 ca                	mov    %ecx,%edx
  802701:	89 f8                	mov    %edi,%eax
  802703:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802707:	85 f6                	test   %esi,%esi
  802709:	75 2d                	jne    802738 <__udivdi3+0x50>
  80270b:	39 cf                	cmp    %ecx,%edi
  80270d:	77 65                	ja     802774 <__udivdi3+0x8c>
  80270f:	89 fd                	mov    %edi,%ebp
  802711:	85 ff                	test   %edi,%edi
  802713:	75 0b                	jne    802720 <__udivdi3+0x38>
  802715:	b8 01 00 00 00       	mov    $0x1,%eax
  80271a:	31 d2                	xor    %edx,%edx
  80271c:	f7 f7                	div    %edi
  80271e:	89 c5                	mov    %eax,%ebp
  802720:	31 d2                	xor    %edx,%edx
  802722:	89 c8                	mov    %ecx,%eax
  802724:	f7 f5                	div    %ebp
  802726:	89 c1                	mov    %eax,%ecx
  802728:	89 d8                	mov    %ebx,%eax
  80272a:	f7 f5                	div    %ebp
  80272c:	89 cf                	mov    %ecx,%edi
  80272e:	89 fa                	mov    %edi,%edx
  802730:	83 c4 1c             	add    $0x1c,%esp
  802733:	5b                   	pop    %ebx
  802734:	5e                   	pop    %esi
  802735:	5f                   	pop    %edi
  802736:	5d                   	pop    %ebp
  802737:	c3                   	ret    
  802738:	39 ce                	cmp    %ecx,%esi
  80273a:	77 28                	ja     802764 <__udivdi3+0x7c>
  80273c:	0f bd fe             	bsr    %esi,%edi
  80273f:	83 f7 1f             	xor    $0x1f,%edi
  802742:	75 40                	jne    802784 <__udivdi3+0x9c>
  802744:	39 ce                	cmp    %ecx,%esi
  802746:	72 0a                	jb     802752 <__udivdi3+0x6a>
  802748:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80274c:	0f 87 9e 00 00 00    	ja     8027f0 <__udivdi3+0x108>
  802752:	b8 01 00 00 00       	mov    $0x1,%eax
  802757:	89 fa                	mov    %edi,%edx
  802759:	83 c4 1c             	add    $0x1c,%esp
  80275c:	5b                   	pop    %ebx
  80275d:	5e                   	pop    %esi
  80275e:	5f                   	pop    %edi
  80275f:	5d                   	pop    %ebp
  802760:	c3                   	ret    
  802761:	8d 76 00             	lea    0x0(%esi),%esi
  802764:	31 ff                	xor    %edi,%edi
  802766:	31 c0                	xor    %eax,%eax
  802768:	89 fa                	mov    %edi,%edx
  80276a:	83 c4 1c             	add    $0x1c,%esp
  80276d:	5b                   	pop    %ebx
  80276e:	5e                   	pop    %esi
  80276f:	5f                   	pop    %edi
  802770:	5d                   	pop    %ebp
  802771:	c3                   	ret    
  802772:	66 90                	xchg   %ax,%ax
  802774:	89 d8                	mov    %ebx,%eax
  802776:	f7 f7                	div    %edi
  802778:	31 ff                	xor    %edi,%edi
  80277a:	89 fa                	mov    %edi,%edx
  80277c:	83 c4 1c             	add    $0x1c,%esp
  80277f:	5b                   	pop    %ebx
  802780:	5e                   	pop    %esi
  802781:	5f                   	pop    %edi
  802782:	5d                   	pop    %ebp
  802783:	c3                   	ret    
  802784:	bd 20 00 00 00       	mov    $0x20,%ebp
  802789:	89 eb                	mov    %ebp,%ebx
  80278b:	29 fb                	sub    %edi,%ebx
  80278d:	89 f9                	mov    %edi,%ecx
  80278f:	d3 e6                	shl    %cl,%esi
  802791:	89 c5                	mov    %eax,%ebp
  802793:	88 d9                	mov    %bl,%cl
  802795:	d3 ed                	shr    %cl,%ebp
  802797:	89 e9                	mov    %ebp,%ecx
  802799:	09 f1                	or     %esi,%ecx
  80279b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80279f:	89 f9                	mov    %edi,%ecx
  8027a1:	d3 e0                	shl    %cl,%eax
  8027a3:	89 c5                	mov    %eax,%ebp
  8027a5:	89 d6                	mov    %edx,%esi
  8027a7:	88 d9                	mov    %bl,%cl
  8027a9:	d3 ee                	shr    %cl,%esi
  8027ab:	89 f9                	mov    %edi,%ecx
  8027ad:	d3 e2                	shl    %cl,%edx
  8027af:	8b 44 24 08          	mov    0x8(%esp),%eax
  8027b3:	88 d9                	mov    %bl,%cl
  8027b5:	d3 e8                	shr    %cl,%eax
  8027b7:	09 c2                	or     %eax,%edx
  8027b9:	89 d0                	mov    %edx,%eax
  8027bb:	89 f2                	mov    %esi,%edx
  8027bd:	f7 74 24 0c          	divl   0xc(%esp)
  8027c1:	89 d6                	mov    %edx,%esi
  8027c3:	89 c3                	mov    %eax,%ebx
  8027c5:	f7 e5                	mul    %ebp
  8027c7:	39 d6                	cmp    %edx,%esi
  8027c9:	72 19                	jb     8027e4 <__udivdi3+0xfc>
  8027cb:	74 0b                	je     8027d8 <__udivdi3+0xf0>
  8027cd:	89 d8                	mov    %ebx,%eax
  8027cf:	31 ff                	xor    %edi,%edi
  8027d1:	e9 58 ff ff ff       	jmp    80272e <__udivdi3+0x46>
  8027d6:	66 90                	xchg   %ax,%ax
  8027d8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8027dc:	89 f9                	mov    %edi,%ecx
  8027de:	d3 e2                	shl    %cl,%edx
  8027e0:	39 c2                	cmp    %eax,%edx
  8027e2:	73 e9                	jae    8027cd <__udivdi3+0xe5>
  8027e4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8027e7:	31 ff                	xor    %edi,%edi
  8027e9:	e9 40 ff ff ff       	jmp    80272e <__udivdi3+0x46>
  8027ee:	66 90                	xchg   %ax,%ax
  8027f0:	31 c0                	xor    %eax,%eax
  8027f2:	e9 37 ff ff ff       	jmp    80272e <__udivdi3+0x46>
  8027f7:	90                   	nop

008027f8 <__umoddi3>:
  8027f8:	55                   	push   %ebp
  8027f9:	57                   	push   %edi
  8027fa:	56                   	push   %esi
  8027fb:	53                   	push   %ebx
  8027fc:	83 ec 1c             	sub    $0x1c,%esp
  8027ff:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802803:	8b 74 24 34          	mov    0x34(%esp),%esi
  802807:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80280b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80280f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802813:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802817:	89 f3                	mov    %esi,%ebx
  802819:	89 fa                	mov    %edi,%edx
  80281b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80281f:	89 34 24             	mov    %esi,(%esp)
  802822:	85 c0                	test   %eax,%eax
  802824:	75 1a                	jne    802840 <__umoddi3+0x48>
  802826:	39 f7                	cmp    %esi,%edi
  802828:	0f 86 a2 00 00 00    	jbe    8028d0 <__umoddi3+0xd8>
  80282e:	89 c8                	mov    %ecx,%eax
  802830:	89 f2                	mov    %esi,%edx
  802832:	f7 f7                	div    %edi
  802834:	89 d0                	mov    %edx,%eax
  802836:	31 d2                	xor    %edx,%edx
  802838:	83 c4 1c             	add    $0x1c,%esp
  80283b:	5b                   	pop    %ebx
  80283c:	5e                   	pop    %esi
  80283d:	5f                   	pop    %edi
  80283e:	5d                   	pop    %ebp
  80283f:	c3                   	ret    
  802840:	39 f0                	cmp    %esi,%eax
  802842:	0f 87 ac 00 00 00    	ja     8028f4 <__umoddi3+0xfc>
  802848:	0f bd e8             	bsr    %eax,%ebp
  80284b:	83 f5 1f             	xor    $0x1f,%ebp
  80284e:	0f 84 ac 00 00 00    	je     802900 <__umoddi3+0x108>
  802854:	bf 20 00 00 00       	mov    $0x20,%edi
  802859:	29 ef                	sub    %ebp,%edi
  80285b:	89 fe                	mov    %edi,%esi
  80285d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802861:	89 e9                	mov    %ebp,%ecx
  802863:	d3 e0                	shl    %cl,%eax
  802865:	89 d7                	mov    %edx,%edi
  802867:	89 f1                	mov    %esi,%ecx
  802869:	d3 ef                	shr    %cl,%edi
  80286b:	09 c7                	or     %eax,%edi
  80286d:	89 e9                	mov    %ebp,%ecx
  80286f:	d3 e2                	shl    %cl,%edx
  802871:	89 14 24             	mov    %edx,(%esp)
  802874:	89 d8                	mov    %ebx,%eax
  802876:	d3 e0                	shl    %cl,%eax
  802878:	89 c2                	mov    %eax,%edx
  80287a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80287e:	d3 e0                	shl    %cl,%eax
  802880:	89 44 24 04          	mov    %eax,0x4(%esp)
  802884:	8b 44 24 08          	mov    0x8(%esp),%eax
  802888:	89 f1                	mov    %esi,%ecx
  80288a:	d3 e8                	shr    %cl,%eax
  80288c:	09 d0                	or     %edx,%eax
  80288e:	d3 eb                	shr    %cl,%ebx
  802890:	89 da                	mov    %ebx,%edx
  802892:	f7 f7                	div    %edi
  802894:	89 d3                	mov    %edx,%ebx
  802896:	f7 24 24             	mull   (%esp)
  802899:	89 c6                	mov    %eax,%esi
  80289b:	89 d1                	mov    %edx,%ecx
  80289d:	39 d3                	cmp    %edx,%ebx
  80289f:	0f 82 87 00 00 00    	jb     80292c <__umoddi3+0x134>
  8028a5:	0f 84 91 00 00 00    	je     80293c <__umoddi3+0x144>
  8028ab:	8b 54 24 04          	mov    0x4(%esp),%edx
  8028af:	29 f2                	sub    %esi,%edx
  8028b1:	19 cb                	sbb    %ecx,%ebx
  8028b3:	89 d8                	mov    %ebx,%eax
  8028b5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8028b9:	d3 e0                	shl    %cl,%eax
  8028bb:	89 e9                	mov    %ebp,%ecx
  8028bd:	d3 ea                	shr    %cl,%edx
  8028bf:	09 d0                	or     %edx,%eax
  8028c1:	89 e9                	mov    %ebp,%ecx
  8028c3:	d3 eb                	shr    %cl,%ebx
  8028c5:	89 da                	mov    %ebx,%edx
  8028c7:	83 c4 1c             	add    $0x1c,%esp
  8028ca:	5b                   	pop    %ebx
  8028cb:	5e                   	pop    %esi
  8028cc:	5f                   	pop    %edi
  8028cd:	5d                   	pop    %ebp
  8028ce:	c3                   	ret    
  8028cf:	90                   	nop
  8028d0:	89 fd                	mov    %edi,%ebp
  8028d2:	85 ff                	test   %edi,%edi
  8028d4:	75 0b                	jne    8028e1 <__umoddi3+0xe9>
  8028d6:	b8 01 00 00 00       	mov    $0x1,%eax
  8028db:	31 d2                	xor    %edx,%edx
  8028dd:	f7 f7                	div    %edi
  8028df:	89 c5                	mov    %eax,%ebp
  8028e1:	89 f0                	mov    %esi,%eax
  8028e3:	31 d2                	xor    %edx,%edx
  8028e5:	f7 f5                	div    %ebp
  8028e7:	89 c8                	mov    %ecx,%eax
  8028e9:	f7 f5                	div    %ebp
  8028eb:	89 d0                	mov    %edx,%eax
  8028ed:	e9 44 ff ff ff       	jmp    802836 <__umoddi3+0x3e>
  8028f2:	66 90                	xchg   %ax,%ax
  8028f4:	89 c8                	mov    %ecx,%eax
  8028f6:	89 f2                	mov    %esi,%edx
  8028f8:	83 c4 1c             	add    $0x1c,%esp
  8028fb:	5b                   	pop    %ebx
  8028fc:	5e                   	pop    %esi
  8028fd:	5f                   	pop    %edi
  8028fe:	5d                   	pop    %ebp
  8028ff:	c3                   	ret    
  802900:	3b 04 24             	cmp    (%esp),%eax
  802903:	72 06                	jb     80290b <__umoddi3+0x113>
  802905:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802909:	77 0f                	ja     80291a <__umoddi3+0x122>
  80290b:	89 f2                	mov    %esi,%edx
  80290d:	29 f9                	sub    %edi,%ecx
  80290f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802913:	89 14 24             	mov    %edx,(%esp)
  802916:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80291a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80291e:	8b 14 24             	mov    (%esp),%edx
  802921:	83 c4 1c             	add    $0x1c,%esp
  802924:	5b                   	pop    %ebx
  802925:	5e                   	pop    %esi
  802926:	5f                   	pop    %edi
  802927:	5d                   	pop    %ebp
  802928:	c3                   	ret    
  802929:	8d 76 00             	lea    0x0(%esi),%esi
  80292c:	2b 04 24             	sub    (%esp),%eax
  80292f:	19 fa                	sbb    %edi,%edx
  802931:	89 d1                	mov    %edx,%ecx
  802933:	89 c6                	mov    %eax,%esi
  802935:	e9 71 ff ff ff       	jmp    8028ab <__umoddi3+0xb3>
  80293a:	66 90                	xchg   %ax,%ax
  80293c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802940:	72 ea                	jb     80292c <__umoddi3+0x134>
  802942:	89 d9                	mov    %ebx,%ecx
  802944:	e9 62 ff ff ff       	jmp    8028ab <__umoddi3+0xb3>
