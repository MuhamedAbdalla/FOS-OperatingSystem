
obj/user/tst_first_fit_1:     file format elf32-i386


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
  800031:	e8 b5 0b 00 00       	call   800beb <libmain>
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
	sys_set_uheap_strategy(UHP_PLACE_FIRSTFIT);
  800040:	83 ec 0c             	sub    $0xc,%esp
  800043:	6a 01                	push   $0x1
  800045:	e8 14 27 00 00       	call   80275e <sys_set_uheap_strategy>
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
  80005a:	a1 20 40 80 00       	mov    0x804020,%eax
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
	sys_set_uheap_strategy(UHP_PLACE_FIRSTFIT);

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800081:	ff 45 f0             	incl   -0x10(%ebp)
  800084:	a1 20 40 80 00       	mov    0x804020,%eax
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
  80009c:	68 40 2a 80 00       	push   $0x802a40
  8000a1:	6a 15                	push   $0x15
  8000a3:	68 5c 2a 80 00       	push   $0x802a5c
  8000a8:	e8 66 0c 00 00       	call   800d13 <_panic>
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
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8000cc:	e8 f9 21 00 00       	call   8022ca <sys_calculate_free_frames>
  8000d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8000d4:	e8 74 22 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  8000d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(1*Mega-kilo);
  8000dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000df:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000e2:	83 ec 0c             	sub    $0xc,%esp
  8000e5:	50                   	push   %eax
  8000e6:	e8 69 1c 00 00       	call   801d54 <malloc>
  8000eb:	83 c4 10             	add    $0x10,%esp
  8000ee:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  8000f1:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000f4:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8000f9:	74 14                	je     80010f <_main+0xd7>
  8000fb:	83 ec 04             	sub    $0x4,%esp
  8000fe:	68 74 2a 80 00       	push   $0x802a74
  800103:	6a 23                	push   $0x23
  800105:	68 5c 2a 80 00       	push   $0x802a5c
  80010a:	e8 04 0c 00 00       	call   800d13 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  80010f:	e8 39 22 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800114:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800117:	3d 00 01 00 00       	cmp    $0x100,%eax
  80011c:	74 14                	je     800132 <_main+0xfa>
  80011e:	83 ec 04             	sub    $0x4,%esp
  800121:	68 a4 2a 80 00       	push   $0x802aa4
  800126:	6a 25                	push   $0x25
  800128:	68 5c 2a 80 00       	push   $0x802a5c
  80012d:	e8 e1 0b 00 00       	call   800d13 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  800132:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800135:	e8 90 21 00 00       	call   8022ca <sys_calculate_free_frames>
  80013a:	29 c3                	sub    %eax,%ebx
  80013c:	89 d8                	mov    %ebx,%eax
  80013e:	83 f8 01             	cmp    $0x1,%eax
  800141:	74 14                	je     800157 <_main+0x11f>
  800143:	83 ec 04             	sub    $0x4,%esp
  800146:	68 c1 2a 80 00       	push   $0x802ac1
  80014b:	6a 26                	push   $0x26
  80014d:	68 5c 2a 80 00       	push   $0x802a5c
  800152:	e8 bc 0b 00 00       	call   800d13 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800157:	e8 6e 21 00 00       	call   8022ca <sys_calculate_free_frames>
  80015c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80015f:	e8 e9 21 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800164:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(1*Mega-kilo);
  800167:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80016a:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80016d:	83 ec 0c             	sub    $0xc,%esp
  800170:	50                   	push   %eax
  800171:	e8 de 1b 00 00       	call   801d54 <malloc>
  800176:	83 c4 10             	add    $0x10,%esp
  800179:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[1] != (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  80017c:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80017f:	89 c2                	mov    %eax,%edx
  800181:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800184:	05 00 00 00 80       	add    $0x80000000,%eax
  800189:	39 c2                	cmp    %eax,%edx
  80018b:	74 14                	je     8001a1 <_main+0x169>
  80018d:	83 ec 04             	sub    $0x4,%esp
  800190:	68 74 2a 80 00       	push   $0x802a74
  800195:	6a 2c                	push   $0x2c
  800197:	68 5c 2a 80 00       	push   $0x802a5c
  80019c:	e8 72 0b 00 00       	call   800d13 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8001a1:	e8 a7 21 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  8001a6:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001a9:	3d 00 01 00 00       	cmp    $0x100,%eax
  8001ae:	74 14                	je     8001c4 <_main+0x18c>
  8001b0:	83 ec 04             	sub    $0x4,%esp
  8001b3:	68 a4 2a 80 00       	push   $0x802aa4
  8001b8:	6a 2e                	push   $0x2e
  8001ba:	68 5c 2a 80 00       	push   $0x802a5c
  8001bf:	e8 4f 0b 00 00       	call   800d13 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  8001c4:	e8 01 21 00 00       	call   8022ca <sys_calculate_free_frames>
  8001c9:	89 c2                	mov    %eax,%edx
  8001cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001ce:	39 c2                	cmp    %eax,%edx
  8001d0:	74 14                	je     8001e6 <_main+0x1ae>
  8001d2:	83 ec 04             	sub    $0x4,%esp
  8001d5:	68 c1 2a 80 00       	push   $0x802ac1
  8001da:	6a 2f                	push   $0x2f
  8001dc:	68 5c 2a 80 00       	push   $0x802a5c
  8001e1:	e8 2d 0b 00 00       	call   800d13 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8001e6:	e8 df 20 00 00       	call   8022ca <sys_calculate_free_frames>
  8001eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001ee:	e8 5a 21 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  8001f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(1*Mega-kilo);
  8001f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001f9:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8001fc:	83 ec 0c             	sub    $0xc,%esp
  8001ff:	50                   	push   %eax
  800200:	e8 4f 1b 00 00       	call   801d54 <malloc>
  800205:	83 c4 10             	add    $0x10,%esp
  800208:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[2] != (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... ");
  80020b:	8b 45 98             	mov    -0x68(%ebp),%eax
  80020e:	89 c2                	mov    %eax,%edx
  800210:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800213:	01 c0                	add    %eax,%eax
  800215:	05 00 00 00 80       	add    $0x80000000,%eax
  80021a:	39 c2                	cmp    %eax,%edx
  80021c:	74 14                	je     800232 <_main+0x1fa>
  80021e:	83 ec 04             	sub    $0x4,%esp
  800221:	68 74 2a 80 00       	push   $0x802a74
  800226:	6a 35                	push   $0x35
  800228:	68 5c 2a 80 00       	push   $0x802a5c
  80022d:	e8 e1 0a 00 00       	call   800d13 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  800232:	e8 16 21 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800237:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80023a:	3d 00 01 00 00       	cmp    $0x100,%eax
  80023f:	74 14                	je     800255 <_main+0x21d>
  800241:	83 ec 04             	sub    $0x4,%esp
  800244:	68 a4 2a 80 00       	push   $0x802aa4
  800249:	6a 37                	push   $0x37
  80024b:	68 5c 2a 80 00       	push   $0x802a5c
  800250:	e8 be 0a 00 00       	call   800d13 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  800255:	e8 70 20 00 00       	call   8022ca <sys_calculate_free_frames>
  80025a:	89 c2                	mov    %eax,%edx
  80025c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80025f:	39 c2                	cmp    %eax,%edx
  800261:	74 14                	je     800277 <_main+0x23f>
  800263:	83 ec 04             	sub    $0x4,%esp
  800266:	68 c1 2a 80 00       	push   $0x802ac1
  80026b:	6a 38                	push   $0x38
  80026d:	68 5c 2a 80 00       	push   $0x802a5c
  800272:	e8 9c 0a 00 00       	call   800d13 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800277:	e8 4e 20 00 00       	call   8022ca <sys_calculate_free_frames>
  80027c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80027f:	e8 c9 20 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800284:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(1*Mega-kilo);
  800287:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80028a:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80028d:	83 ec 0c             	sub    $0xc,%esp
  800290:	50                   	push   %eax
  800291:	e8 be 1a 00 00       	call   801d54 <malloc>
  800296:	83 c4 10             	add    $0x10,%esp
  800299:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 3*Mega) ) panic("Wrong start address for the allocated space... ");
  80029c:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80029f:	89 c1                	mov    %eax,%ecx
  8002a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8002a4:	89 c2                	mov    %eax,%edx
  8002a6:	01 d2                	add    %edx,%edx
  8002a8:	01 d0                	add    %edx,%eax
  8002aa:	05 00 00 00 80       	add    $0x80000000,%eax
  8002af:	39 c1                	cmp    %eax,%ecx
  8002b1:	74 14                	je     8002c7 <_main+0x28f>
  8002b3:	83 ec 04             	sub    $0x4,%esp
  8002b6:	68 74 2a 80 00       	push   $0x802a74
  8002bb:	6a 3e                	push   $0x3e
  8002bd:	68 5c 2a 80 00       	push   $0x802a5c
  8002c2:	e8 4c 0a 00 00       	call   800d13 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8002c7:	e8 81 20 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  8002cc:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8002cf:	3d 00 01 00 00       	cmp    $0x100,%eax
  8002d4:	74 14                	je     8002ea <_main+0x2b2>
  8002d6:	83 ec 04             	sub    $0x4,%esp
  8002d9:	68 a4 2a 80 00       	push   $0x802aa4
  8002de:	6a 40                	push   $0x40
  8002e0:	68 5c 2a 80 00       	push   $0x802a5c
  8002e5:	e8 29 0a 00 00       	call   800d13 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  8002ea:	e8 db 1f 00 00       	call   8022ca <sys_calculate_free_frames>
  8002ef:	89 c2                	mov    %eax,%edx
  8002f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002f4:	39 c2                	cmp    %eax,%edx
  8002f6:	74 14                	je     80030c <_main+0x2d4>
  8002f8:	83 ec 04             	sub    $0x4,%esp
  8002fb:	68 c1 2a 80 00       	push   $0x802ac1
  800300:	6a 41                	push   $0x41
  800302:	68 5c 2a 80 00       	push   $0x802a5c
  800307:	e8 07 0a 00 00       	call   800d13 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  80030c:	e8 b9 1f 00 00       	call   8022ca <sys_calculate_free_frames>
  800311:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800314:	e8 34 20 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800319:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(2*Mega-kilo);
  80031c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80031f:	01 c0                	add    %eax,%eax
  800321:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800324:	83 ec 0c             	sub    $0xc,%esp
  800327:	50                   	push   %eax
  800328:	e8 27 1a 00 00       	call   801d54 <malloc>
  80032d:	83 c4 10             	add    $0x10,%esp
  800330:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[4] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  800333:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800336:	89 c2                	mov    %eax,%edx
  800338:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80033b:	c1 e0 02             	shl    $0x2,%eax
  80033e:	05 00 00 00 80       	add    $0x80000000,%eax
  800343:	39 c2                	cmp    %eax,%edx
  800345:	74 14                	je     80035b <_main+0x323>
  800347:	83 ec 04             	sub    $0x4,%esp
  80034a:	68 74 2a 80 00       	push   $0x802a74
  80034f:	6a 47                	push   $0x47
  800351:	68 5c 2a 80 00       	push   $0x802a5c
  800356:	e8 b8 09 00 00       	call   800d13 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  80035b:	e8 ed 1f 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800360:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800363:	3d 00 02 00 00       	cmp    $0x200,%eax
  800368:	74 14                	je     80037e <_main+0x346>
  80036a:	83 ec 04             	sub    $0x4,%esp
  80036d:	68 a4 2a 80 00       	push   $0x802aa4
  800372:	6a 49                	push   $0x49
  800374:	68 5c 2a 80 00       	push   $0x802a5c
  800379:	e8 95 09 00 00       	call   800d13 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  80037e:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800381:	e8 44 1f 00 00       	call   8022ca <sys_calculate_free_frames>
  800386:	29 c3                	sub    %eax,%ebx
  800388:	89 d8                	mov    %ebx,%eax
  80038a:	83 f8 01             	cmp    $0x1,%eax
  80038d:	74 14                	je     8003a3 <_main+0x36b>
  80038f:	83 ec 04             	sub    $0x4,%esp
  800392:	68 c1 2a 80 00       	push   $0x802ac1
  800397:	6a 4a                	push   $0x4a
  800399:	68 5c 2a 80 00       	push   $0x802a5c
  80039e:	e8 70 09 00 00       	call   800d13 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8003a3:	e8 22 1f 00 00       	call   8022ca <sys_calculate_free_frames>
  8003a8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003ab:	e8 9d 1f 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  8003b0:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(2*Mega-kilo);
  8003b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003b6:	01 c0                	add    %eax,%eax
  8003b8:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8003bb:	83 ec 0c             	sub    $0xc,%esp
  8003be:	50                   	push   %eax
  8003bf:	e8 90 19 00 00       	call   801d54 <malloc>
  8003c4:	83 c4 10             	add    $0x10,%esp
  8003c7:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] != (USER_HEAP_START + 6*Mega)) panic("Wrong start address for the allocated space... ");
  8003ca:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003cd:	89 c1                	mov    %eax,%ecx
  8003cf:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003d2:	89 d0                	mov    %edx,%eax
  8003d4:	01 c0                	add    %eax,%eax
  8003d6:	01 d0                	add    %edx,%eax
  8003d8:	01 c0                	add    %eax,%eax
  8003da:	05 00 00 00 80       	add    $0x80000000,%eax
  8003df:	39 c1                	cmp    %eax,%ecx
  8003e1:	74 14                	je     8003f7 <_main+0x3bf>
  8003e3:	83 ec 04             	sub    $0x4,%esp
  8003e6:	68 74 2a 80 00       	push   $0x802a74
  8003eb:	6a 50                	push   $0x50
  8003ed:	68 5c 2a 80 00       	push   $0x802a5c
  8003f2:	e8 1c 09 00 00       	call   800d13 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8003f7:	e8 51 1f 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  8003fc:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8003ff:	3d 00 02 00 00       	cmp    $0x200,%eax
  800404:	74 14                	je     80041a <_main+0x3e2>
  800406:	83 ec 04             	sub    $0x4,%esp
  800409:	68 a4 2a 80 00       	push   $0x802aa4
  80040e:	6a 52                	push   $0x52
  800410:	68 5c 2a 80 00       	push   $0x802a5c
  800415:	e8 f9 08 00 00       	call   800d13 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80041a:	e8 ab 1e 00 00       	call   8022ca <sys_calculate_free_frames>
  80041f:	89 c2                	mov    %eax,%edx
  800421:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800424:	39 c2                	cmp    %eax,%edx
  800426:	74 14                	je     80043c <_main+0x404>
  800428:	83 ec 04             	sub    $0x4,%esp
  80042b:	68 c1 2a 80 00       	push   $0x802ac1
  800430:	6a 53                	push   $0x53
  800432:	68 5c 2a 80 00       	push   $0x802a5c
  800437:	e8 d7 08 00 00       	call   800d13 <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  80043c:	e8 89 1e 00 00       	call   8022ca <sys_calculate_free_frames>
  800441:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800444:	e8 04 1f 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800449:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(3*Mega-kilo);
  80044c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80044f:	89 c2                	mov    %eax,%edx
  800451:	01 d2                	add    %edx,%edx
  800453:	01 d0                	add    %edx,%eax
  800455:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800458:	83 ec 0c             	sub    $0xc,%esp
  80045b:	50                   	push   %eax
  80045c:	e8 f3 18 00 00       	call   801d54 <malloc>
  800461:	83 c4 10             	add    $0x10,%esp
  800464:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  800467:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80046a:	89 c2                	mov    %eax,%edx
  80046c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80046f:	c1 e0 03             	shl    $0x3,%eax
  800472:	05 00 00 00 80       	add    $0x80000000,%eax
  800477:	39 c2                	cmp    %eax,%edx
  800479:	74 14                	je     80048f <_main+0x457>
  80047b:	83 ec 04             	sub    $0x4,%esp
  80047e:	68 74 2a 80 00       	push   $0x802a74
  800483:	6a 59                	push   $0x59
  800485:	68 5c 2a 80 00       	push   $0x802a5c
  80048a:	e8 84 08 00 00       	call   800d13 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  768) panic("Wrong page file allocation: ");
  80048f:	e8 b9 1e 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800494:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800497:	3d 00 03 00 00       	cmp    $0x300,%eax
  80049c:	74 14                	je     8004b2 <_main+0x47a>
  80049e:	83 ec 04             	sub    $0x4,%esp
  8004a1:	68 a4 2a 80 00       	push   $0x802aa4
  8004a6:	6a 5b                	push   $0x5b
  8004a8:	68 5c 2a 80 00       	push   $0x802a5c
  8004ad:	e8 61 08 00 00       	call   800d13 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  8004b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8004b5:	e8 10 1e 00 00       	call   8022ca <sys_calculate_free_frames>
  8004ba:	29 c3                	sub    %eax,%ebx
  8004bc:	89 d8                	mov    %ebx,%eax
  8004be:	83 f8 01             	cmp    $0x1,%eax
  8004c1:	74 14                	je     8004d7 <_main+0x49f>
  8004c3:	83 ec 04             	sub    $0x4,%esp
  8004c6:	68 c1 2a 80 00       	push   $0x802ac1
  8004cb:	6a 5c                	push   $0x5c
  8004cd:	68 5c 2a 80 00       	push   $0x802a5c
  8004d2:	e8 3c 08 00 00       	call   800d13 <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8004d7:	e8 ee 1d 00 00       	call   8022ca <sys_calculate_free_frames>
  8004dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004df:	e8 69 1e 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  8004e4:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(3*Mega-kilo);
  8004e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004ea:	89 c2                	mov    %eax,%edx
  8004ec:	01 d2                	add    %edx,%edx
  8004ee:	01 d0                	add    %edx,%eax
  8004f0:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8004f3:	83 ec 0c             	sub    $0xc,%esp
  8004f6:	50                   	push   %eax
  8004f7:	e8 58 18 00 00       	call   801d54 <malloc>
  8004fc:	83 c4 10             	add    $0x10,%esp
  8004ff:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 11*Mega)) panic("Wrong start address for the allocated space... ");
  800502:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800505:	89 c1                	mov    %eax,%ecx
  800507:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80050a:	89 d0                	mov    %edx,%eax
  80050c:	c1 e0 02             	shl    $0x2,%eax
  80050f:	01 d0                	add    %edx,%eax
  800511:	01 c0                	add    %eax,%eax
  800513:	01 d0                	add    %edx,%eax
  800515:	05 00 00 00 80       	add    $0x80000000,%eax
  80051a:	39 c1                	cmp    %eax,%ecx
  80051c:	74 14                	je     800532 <_main+0x4fa>
  80051e:	83 ec 04             	sub    $0x4,%esp
  800521:	68 74 2a 80 00       	push   $0x802a74
  800526:	6a 62                	push   $0x62
  800528:	68 5c 2a 80 00       	push   $0x802a5c
  80052d:	e8 e1 07 00 00       	call   800d13 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  768) panic("Wrong page file allocation: ");
  800532:	e8 16 1e 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800537:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80053a:	3d 00 03 00 00       	cmp    $0x300,%eax
  80053f:	74 14                	je     800555 <_main+0x51d>
  800541:	83 ec 04             	sub    $0x4,%esp
  800544:	68 a4 2a 80 00       	push   $0x802aa4
  800549:	6a 64                	push   $0x64
  80054b:	68 5c 2a 80 00       	push   $0x802a5c
  800550:	e8 be 07 00 00       	call   800d13 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  800555:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800558:	e8 6d 1d 00 00       	call   8022ca <sys_calculate_free_frames>
  80055d:	29 c3                	sub    %eax,%ebx
  80055f:	89 d8                	mov    %ebx,%eax
  800561:	83 f8 01             	cmp    $0x1,%eax
  800564:	74 14                	je     80057a <_main+0x542>
  800566:	83 ec 04             	sub    $0x4,%esp
  800569:	68 c1 2a 80 00       	push   $0x802ac1
  80056e:	6a 65                	push   $0x65
  800570:	68 5c 2a 80 00       	push   $0x802a5c
  800575:	e8 99 07 00 00       	call   800d13 <_panic>
	}

	//[2] Free some to create holes
	{
		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80057a:	e8 4b 1d 00 00       	call   8022ca <sys_calculate_free_frames>
  80057f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800582:	e8 c6 1d 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800587:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  80058a:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80058d:	83 ec 0c             	sub    $0xc,%esp
  800590:	50                   	push   %eax
  800591:	e8 83 1a 00 00       	call   802019 <free>
  800596:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800599:	e8 af 1d 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  80059e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005a1:	29 c2                	sub    %eax,%edx
  8005a3:	89 d0                	mov    %edx,%eax
  8005a5:	3d 00 01 00 00       	cmp    $0x100,%eax
  8005aa:	74 14                	je     8005c0 <_main+0x588>
  8005ac:	83 ec 04             	sub    $0x4,%esp
  8005af:	68 d4 2a 80 00       	push   $0x802ad4
  8005b4:	6a 6f                	push   $0x6f
  8005b6:	68 5c 2a 80 00       	push   $0x802a5c
  8005bb:	e8 53 07 00 00       	call   800d13 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8005c0:	e8 05 1d 00 00       	call   8022ca <sys_calculate_free_frames>
  8005c5:	89 c2                	mov    %eax,%edx
  8005c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005ca:	39 c2                	cmp    %eax,%edx
  8005cc:	74 14                	je     8005e2 <_main+0x5aa>
  8005ce:	83 ec 04             	sub    $0x4,%esp
  8005d1:	68 eb 2a 80 00       	push   $0x802aeb
  8005d6:	6a 70                	push   $0x70
  8005d8:	68 5c 2a 80 00       	push   $0x802a5c
  8005dd:	e8 31 07 00 00       	call   800d13 <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005e2:	e8 e3 1c 00 00       	call   8022ca <sys_calculate_free_frames>
  8005e7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8005ea:	e8 5e 1d 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  8005ef:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[4]);
  8005f2:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8005f5:	83 ec 0c             	sub    $0xc,%esp
  8005f8:	50                   	push   %eax
  8005f9:	e8 1b 1a 00 00       	call   802019 <free>
  8005fe:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  512) panic("Wrong page file free: ");
  800601:	e8 47 1d 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800606:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800609:	29 c2                	sub    %eax,%edx
  80060b:	89 d0                	mov    %edx,%eax
  80060d:	3d 00 02 00 00       	cmp    $0x200,%eax
  800612:	74 14                	je     800628 <_main+0x5f0>
  800614:	83 ec 04             	sub    $0x4,%esp
  800617:	68 d4 2a 80 00       	push   $0x802ad4
  80061c:	6a 77                	push   $0x77
  80061e:	68 5c 2a 80 00       	push   $0x802a5c
  800623:	e8 eb 06 00 00       	call   800d13 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800628:	e8 9d 1c 00 00       	call   8022ca <sys_calculate_free_frames>
  80062d:	89 c2                	mov    %eax,%edx
  80062f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800632:	39 c2                	cmp    %eax,%edx
  800634:	74 14                	je     80064a <_main+0x612>
  800636:	83 ec 04             	sub    $0x4,%esp
  800639:	68 eb 2a 80 00       	push   $0x802aeb
  80063e:	6a 78                	push   $0x78
  800640:	68 5c 2a 80 00       	push   $0x802a5c
  800645:	e8 c9 06 00 00       	call   800d13 <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  80064a:	e8 7b 1c 00 00       	call   8022ca <sys_calculate_free_frames>
  80064f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800652:	e8 f6 1c 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800657:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[6]);
  80065a:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80065d:	83 ec 0c             	sub    $0xc,%esp
  800660:	50                   	push   %eax
  800661:	e8 b3 19 00 00       	call   802019 <free>
  800666:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  768) panic("Wrong page file free: ");
  800669:	e8 df 1c 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  80066e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800671:	29 c2                	sub    %eax,%edx
  800673:	89 d0                	mov    %edx,%eax
  800675:	3d 00 03 00 00       	cmp    $0x300,%eax
  80067a:	74 14                	je     800690 <_main+0x658>
  80067c:	83 ec 04             	sub    $0x4,%esp
  80067f:	68 d4 2a 80 00       	push   $0x802ad4
  800684:	6a 7f                	push   $0x7f
  800686:	68 5c 2a 80 00       	push   $0x802a5c
  80068b:	e8 83 06 00 00       	call   800d13 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800690:	e8 35 1c 00 00       	call   8022ca <sys_calculate_free_frames>
  800695:	89 c2                	mov    %eax,%edx
  800697:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80069a:	39 c2                	cmp    %eax,%edx
  80069c:	74 17                	je     8006b5 <_main+0x67d>
  80069e:	83 ec 04             	sub    $0x4,%esp
  8006a1:	68 eb 2a 80 00       	push   $0x802aeb
  8006a6:	68 80 00 00 00       	push   $0x80
  8006ab:	68 5c 2a 80 00       	push   $0x802a5c
  8006b0:	e8 5e 06 00 00       	call   800d13 <_panic>
	}

	//[3] Allocate again [test first fit]
	{
		//Allocate 512 KB - should be placed in 1st hole
		freeFrames = sys_calculate_free_frames() ;
  8006b5:	e8 10 1c 00 00       	call   8022ca <sys_calculate_free_frames>
  8006ba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8006bd:	e8 8b 1c 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  8006c2:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(512*kilo - kilo);
  8006c5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8006c8:	89 d0                	mov    %edx,%eax
  8006ca:	c1 e0 09             	shl    $0x9,%eax
  8006cd:	29 d0                	sub    %edx,%eax
  8006cf:	83 ec 0c             	sub    $0xc,%esp
  8006d2:	50                   	push   %eax
  8006d3:	e8 7c 16 00 00       	call   801d54 <malloc>
  8006d8:	83 c4 10             	add    $0x10,%esp
  8006db:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[8] != (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  8006de:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8006e1:	89 c2                	mov    %eax,%edx
  8006e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8006e6:	05 00 00 00 80       	add    $0x80000000,%eax
  8006eb:	39 c2                	cmp    %eax,%edx
  8006ed:	74 17                	je     800706 <_main+0x6ce>
  8006ef:	83 ec 04             	sub    $0x4,%esp
  8006f2:	68 74 2a 80 00       	push   $0x802a74
  8006f7:	68 89 00 00 00       	push   $0x89
  8006fc:	68 5c 2a 80 00       	push   $0x802a5c
  800701:	e8 0d 06 00 00       	call   800d13 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 128) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  128) panic("Wrong page file allocation: ");
  800706:	e8 42 1c 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  80070b:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80070e:	3d 80 00 00 00       	cmp    $0x80,%eax
  800713:	74 17                	je     80072c <_main+0x6f4>
  800715:	83 ec 04             	sub    $0x4,%esp
  800718:	68 a4 2a 80 00       	push   $0x802aa4
  80071d:	68 8b 00 00 00       	push   $0x8b
  800722:	68 5c 2a 80 00       	push   $0x802a5c
  800727:	e8 e7 05 00 00       	call   800d13 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80072c:	e8 99 1b 00 00       	call   8022ca <sys_calculate_free_frames>
  800731:	89 c2                	mov    %eax,%edx
  800733:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800736:	39 c2                	cmp    %eax,%edx
  800738:	74 17                	je     800751 <_main+0x719>
  80073a:	83 ec 04             	sub    $0x4,%esp
  80073d:	68 c1 2a 80 00       	push   $0x802ac1
  800742:	68 8c 00 00 00       	push   $0x8c
  800747:	68 5c 2a 80 00       	push   $0x802a5c
  80074c:	e8 c2 05 00 00       	call   800d13 <_panic>

		//Allocate 1 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
  800751:	e8 74 1b 00 00       	call   8022ca <sys_calculate_free_frames>
  800756:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800759:	e8 ef 1b 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  80075e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[9] = malloc(1*Mega - kilo);
  800761:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800764:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800767:	83 ec 0c             	sub    $0xc,%esp
  80076a:	50                   	push   %eax
  80076b:	e8 e4 15 00 00       	call   801d54 <malloc>
  800770:	83 c4 10             	add    $0x10,%esp
  800773:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  800776:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800779:	89 c2                	mov    %eax,%edx
  80077b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80077e:	c1 e0 02             	shl    $0x2,%eax
  800781:	05 00 00 00 80       	add    $0x80000000,%eax
  800786:	39 c2                	cmp    %eax,%edx
  800788:	74 17                	je     8007a1 <_main+0x769>
  80078a:	83 ec 04             	sub    $0x4,%esp
  80078d:	68 74 2a 80 00       	push   $0x802a74
  800792:	68 92 00 00 00       	push   $0x92
  800797:	68 5c 2a 80 00       	push   $0x802a5c
  80079c:	e8 72 05 00 00       	call   800d13 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8007a1:	e8 a7 1b 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  8007a6:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8007a9:	3d 00 01 00 00       	cmp    $0x100,%eax
  8007ae:	74 17                	je     8007c7 <_main+0x78f>
  8007b0:	83 ec 04             	sub    $0x4,%esp
  8007b3:	68 a4 2a 80 00       	push   $0x802aa4
  8007b8:	68 94 00 00 00       	push   $0x94
  8007bd:	68 5c 2a 80 00       	push   $0x802a5c
  8007c2:	e8 4c 05 00 00       	call   800d13 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  8007c7:	e8 fe 1a 00 00       	call   8022ca <sys_calculate_free_frames>
  8007cc:	89 c2                	mov    %eax,%edx
  8007ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8007d1:	39 c2                	cmp    %eax,%edx
  8007d3:	74 17                	je     8007ec <_main+0x7b4>
  8007d5:	83 ec 04             	sub    $0x4,%esp
  8007d8:	68 c1 2a 80 00       	push   $0x802ac1
  8007dd:	68 95 00 00 00       	push   $0x95
  8007e2:	68 5c 2a 80 00       	push   $0x802a5c
  8007e7:	e8 27 05 00 00       	call   800d13 <_panic>

		//Allocate 256 KB - should be placed in remaining of 1st hole
		freeFrames = sys_calculate_free_frames() ;
  8007ec:	e8 d9 1a 00 00       	call   8022ca <sys_calculate_free_frames>
  8007f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8007f4:	e8 54 1b 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  8007f9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[10] = malloc(256*kilo - kilo);
  8007fc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007ff:	89 d0                	mov    %edx,%eax
  800801:	c1 e0 08             	shl    $0x8,%eax
  800804:	29 d0                	sub    %edx,%eax
  800806:	83 ec 0c             	sub    $0xc,%esp
  800809:	50                   	push   %eax
  80080a:	e8 45 15 00 00       	call   801d54 <malloc>
  80080f:	83 c4 10             	add    $0x10,%esp
  800812:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if ((uint32) ptr_allocations[10] != (USER_HEAP_START + 1*Mega + 512*kilo)) panic("Wrong start address for the allocated space... ");
  800815:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800818:	89 c2                	mov    %eax,%edx
  80081a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80081d:	c1 e0 09             	shl    $0x9,%eax
  800820:	89 c1                	mov    %eax,%ecx
  800822:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800825:	01 c8                	add    %ecx,%eax
  800827:	05 00 00 00 80       	add    $0x80000000,%eax
  80082c:	39 c2                	cmp    %eax,%edx
  80082e:	74 17                	je     800847 <_main+0x80f>
  800830:	83 ec 04             	sub    $0x4,%esp
  800833:	68 74 2a 80 00       	push   $0x802a74
  800838:	68 9b 00 00 00       	push   $0x9b
  80083d:	68 5c 2a 80 00       	push   $0x802a5c
  800842:	e8 cc 04 00 00       	call   800d13 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 64) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  64) panic("Wrong page file allocation: ");
  800847:	e8 01 1b 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  80084c:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80084f:	83 f8 40             	cmp    $0x40,%eax
  800852:	74 17                	je     80086b <_main+0x833>
  800854:	83 ec 04             	sub    $0x4,%esp
  800857:	68 a4 2a 80 00       	push   $0x802aa4
  80085c:	68 9d 00 00 00       	push   $0x9d
  800861:	68 5c 2a 80 00       	push   $0x802a5c
  800866:	e8 a8 04 00 00       	call   800d13 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80086b:	e8 5a 1a 00 00       	call   8022ca <sys_calculate_free_frames>
  800870:	89 c2                	mov    %eax,%edx
  800872:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800875:	39 c2                	cmp    %eax,%edx
  800877:	74 17                	je     800890 <_main+0x858>
  800879:	83 ec 04             	sub    $0x4,%esp
  80087c:	68 c1 2a 80 00       	push   $0x802ac1
  800881:	68 9e 00 00 00       	push   $0x9e
  800886:	68 5c 2a 80 00       	push   $0x802a5c
  80088b:	e8 83 04 00 00       	call   800d13 <_panic>

		//Allocate 2 MB - should be placed in 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  800890:	e8 35 1a 00 00       	call   8022ca <sys_calculate_free_frames>
  800895:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800898:	e8 b0 1a 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  80089d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[11] = malloc(2*Mega);
  8008a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008a3:	01 c0                	add    %eax,%eax
  8008a5:	83 ec 0c             	sub    $0xc,%esp
  8008a8:	50                   	push   %eax
  8008a9:	e8 a6 14 00 00       	call   801d54 <malloc>
  8008ae:	83 c4 10             	add    $0x10,%esp
  8008b1:	89 45 bc             	mov    %eax,-0x44(%ebp)
		if ((uint32) ptr_allocations[11] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  8008b4:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8008b7:	89 c2                	mov    %eax,%edx
  8008b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008bc:	c1 e0 03             	shl    $0x3,%eax
  8008bf:	05 00 00 00 80       	add    $0x80000000,%eax
  8008c4:	39 c2                	cmp    %eax,%edx
  8008c6:	74 17                	je     8008df <_main+0x8a7>
  8008c8:	83 ec 04             	sub    $0x4,%esp
  8008cb:	68 74 2a 80 00       	push   $0x802a74
  8008d0:	68 a4 00 00 00       	push   $0xa4
  8008d5:	68 5c 2a 80 00       	push   $0x802a5c
  8008da:	e8 34 04 00 00       	call   800d13 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8008df:	e8 69 1a 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  8008e4:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8008e7:	3d 00 02 00 00       	cmp    $0x200,%eax
  8008ec:	74 17                	je     800905 <_main+0x8cd>
  8008ee:	83 ec 04             	sub    $0x4,%esp
  8008f1:	68 a4 2a 80 00       	push   $0x802aa4
  8008f6:	68 a6 00 00 00       	push   $0xa6
  8008fb:	68 5c 2a 80 00       	push   $0x802a5c
  800900:	e8 0e 04 00 00       	call   800d13 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800905:	e8 c0 19 00 00       	call   8022ca <sys_calculate_free_frames>
  80090a:	89 c2                	mov    %eax,%edx
  80090c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80090f:	39 c2                	cmp    %eax,%edx
  800911:	74 17                	je     80092a <_main+0x8f2>
  800913:	83 ec 04             	sub    $0x4,%esp
  800916:	68 c1 2a 80 00       	push   $0x802ac1
  80091b:	68 a7 00 00 00       	push   $0xa7
  800920:	68 5c 2a 80 00       	push   $0x802a5c
  800925:	e8 e9 03 00 00       	call   800d13 <_panic>

		//Allocate 4 MB - should be placed in end of all allocations
		freeFrames = sys_calculate_free_frames() ;
  80092a:	e8 9b 19 00 00       	call   8022ca <sys_calculate_free_frames>
  80092f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800932:	e8 16 1a 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800937:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[12] = malloc(4*Mega - kilo);
  80093a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80093d:	c1 e0 02             	shl    $0x2,%eax
  800940:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800943:	83 ec 0c             	sub    $0xc,%esp
  800946:	50                   	push   %eax
  800947:	e8 08 14 00 00       	call   801d54 <malloc>
  80094c:	83 c4 10             	add    $0x10,%esp
  80094f:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if ((uint32) ptr_allocations[12] != (USER_HEAP_START + 14*Mega) ) panic("Wrong start address for the allocated space... ");
  800952:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800955:	89 c1                	mov    %eax,%ecx
  800957:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80095a:	89 d0                	mov    %edx,%eax
  80095c:	01 c0                	add    %eax,%eax
  80095e:	01 d0                	add    %edx,%eax
  800960:	01 c0                	add    %eax,%eax
  800962:	01 d0                	add    %edx,%eax
  800964:	01 c0                	add    %eax,%eax
  800966:	05 00 00 00 80       	add    $0x80000000,%eax
  80096b:	39 c1                	cmp    %eax,%ecx
  80096d:	74 17                	je     800986 <_main+0x94e>
  80096f:	83 ec 04             	sub    $0x4,%esp
  800972:	68 74 2a 80 00       	push   $0x802a74
  800977:	68 ad 00 00 00       	push   $0xad
  80097c:	68 5c 2a 80 00       	push   $0x802a5c
  800981:	e8 8d 03 00 00       	call   800d13 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1024 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1024) panic("Wrong page file allocation: ");
  800986:	e8 c2 19 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  80098b:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80098e:	3d 00 04 00 00       	cmp    $0x400,%eax
  800993:	74 17                	je     8009ac <_main+0x974>
  800995:	83 ec 04             	sub    $0x4,%esp
  800998:	68 a4 2a 80 00       	push   $0x802aa4
  80099d:	68 af 00 00 00       	push   $0xaf
  8009a2:	68 5c 2a 80 00       	push   $0x802a5c
  8009a7:	e8 67 03 00 00       	call   800d13 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  8009ac:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8009af:	e8 16 19 00 00       	call   8022ca <sys_calculate_free_frames>
  8009b4:	29 c3                	sub    %eax,%ebx
  8009b6:	89 d8                	mov    %ebx,%eax
  8009b8:	83 f8 01             	cmp    $0x1,%eax
  8009bb:	74 17                	je     8009d4 <_main+0x99c>
  8009bd:	83 ec 04             	sub    $0x4,%esp
  8009c0:	68 c1 2a 80 00       	push   $0x802ac1
  8009c5:	68 b0 00 00 00       	push   $0xb0
  8009ca:	68 5c 2a 80 00       	push   $0x802a5c
  8009cf:	e8 3f 03 00 00       	call   800d13 <_panic>
	}

	//[4] Free contiguous allocations
	{
		//1 MB Hole appended to previous 256 KB hole
		freeFrames = sys_calculate_free_frames() ;
  8009d4:	e8 f1 18 00 00       	call   8022ca <sys_calculate_free_frames>
  8009d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8009dc:	e8 6c 19 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  8009e1:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[2]);
  8009e4:	8b 45 98             	mov    -0x68(%ebp),%eax
  8009e7:	83 ec 0c             	sub    $0xc,%esp
  8009ea:	50                   	push   %eax
  8009eb:	e8 29 16 00 00       	call   802019 <free>
  8009f0:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  8009f3:	e8 55 19 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  8009f8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009fb:	29 c2                	sub    %eax,%edx
  8009fd:	89 d0                	mov    %edx,%eax
  8009ff:	3d 00 01 00 00       	cmp    $0x100,%eax
  800a04:	74 17                	je     800a1d <_main+0x9e5>
  800a06:	83 ec 04             	sub    $0x4,%esp
  800a09:	68 d4 2a 80 00       	push   $0x802ad4
  800a0e:	68 ba 00 00 00       	push   $0xba
  800a13:	68 5c 2a 80 00       	push   $0x802a5c
  800a18:	e8 f6 02 00 00       	call   800d13 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a1d:	e8 a8 18 00 00       	call   8022ca <sys_calculate_free_frames>
  800a22:	89 c2                	mov    %eax,%edx
  800a24:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a27:	39 c2                	cmp    %eax,%edx
  800a29:	74 17                	je     800a42 <_main+0xa0a>
  800a2b:	83 ec 04             	sub    $0x4,%esp
  800a2e:	68 eb 2a 80 00       	push   $0x802aeb
  800a33:	68 bb 00 00 00       	push   $0xbb
  800a38:	68 5c 2a 80 00       	push   $0x802a5c
  800a3d:	e8 d1 02 00 00       	call   800d13 <_panic>

		//1 MB Hole appended to next 1 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800a42:	e8 83 18 00 00       	call   8022ca <sys_calculate_free_frames>
  800a47:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800a4a:	e8 fe 18 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800a4f:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[9]);
  800a52:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800a55:	83 ec 0c             	sub    $0xc,%esp
  800a58:	50                   	push   %eax
  800a59:	e8 bb 15 00 00       	call   802019 <free>
  800a5e:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800a61:	e8 e7 18 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800a66:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a69:	29 c2                	sub    %eax,%edx
  800a6b:	89 d0                	mov    %edx,%eax
  800a6d:	3d 00 01 00 00       	cmp    $0x100,%eax
  800a72:	74 17                	je     800a8b <_main+0xa53>
  800a74:	83 ec 04             	sub    $0x4,%esp
  800a77:	68 d4 2a 80 00       	push   $0x802ad4
  800a7c:	68 c2 00 00 00       	push   $0xc2
  800a81:	68 5c 2a 80 00       	push   $0x802a5c
  800a86:	e8 88 02 00 00       	call   800d13 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a8b:	e8 3a 18 00 00       	call   8022ca <sys_calculate_free_frames>
  800a90:	89 c2                	mov    %eax,%edx
  800a92:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a95:	39 c2                	cmp    %eax,%edx
  800a97:	74 17                	je     800ab0 <_main+0xa78>
  800a99:	83 ec 04             	sub    $0x4,%esp
  800a9c:	68 eb 2a 80 00       	push   $0x802aeb
  800aa1:	68 c3 00 00 00       	push   $0xc3
  800aa6:	68 5c 2a 80 00       	push   $0x802a5c
  800aab:	e8 63 02 00 00       	call   800d13 <_panic>

		//1 MB Hole appended to previous 1 MB + 256 KB hole and next 2 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800ab0:	e8 15 18 00 00       	call   8022ca <sys_calculate_free_frames>
  800ab5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800ab8:	e8 90 18 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800abd:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[3]);
  800ac0:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800ac3:	83 ec 0c             	sub    $0xc,%esp
  800ac6:	50                   	push   %eax
  800ac7:	e8 4d 15 00 00       	call   802019 <free>
  800acc:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800acf:	e8 79 18 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800ad4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ad7:	29 c2                	sub    %eax,%edx
  800ad9:	89 d0                	mov    %edx,%eax
  800adb:	3d 00 01 00 00       	cmp    $0x100,%eax
  800ae0:	74 17                	je     800af9 <_main+0xac1>
  800ae2:	83 ec 04             	sub    $0x4,%esp
  800ae5:	68 d4 2a 80 00       	push   $0x802ad4
  800aea:	68 ca 00 00 00       	push   $0xca
  800aef:	68 5c 2a 80 00       	push   $0x802a5c
  800af4:	e8 1a 02 00 00       	call   800d13 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800af9:	e8 cc 17 00 00       	call   8022ca <sys_calculate_free_frames>
  800afe:	89 c2                	mov    %eax,%edx
  800b00:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800b03:	39 c2                	cmp    %eax,%edx
  800b05:	74 17                	je     800b1e <_main+0xae6>
  800b07:	83 ec 04             	sub    $0x4,%esp
  800b0a:	68 eb 2a 80 00       	push   $0x802aeb
  800b0f:	68 cb 00 00 00       	push   $0xcb
  800b14:	68 5c 2a 80 00       	push   $0x802a5c
  800b19:	e8 f5 01 00 00       	call   800d13 <_panic>

	//[5] Allocate again [test first fit]
	{
		//[FIRST FIT Case]
		//Allocate 4 MB + 256 KB - should be placed in the contiguous hole (256 KB + 4 MB)
		freeFrames = sys_calculate_free_frames() ;
  800b1e:	e8 a7 17 00 00       	call   8022ca <sys_calculate_free_frames>
  800b23:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800b26:	e8 22 18 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800b2b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[13] = malloc(4*Mega + 256*kilo - kilo);
  800b2e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b31:	c1 e0 06             	shl    $0x6,%eax
  800b34:	89 c2                	mov    %eax,%edx
  800b36:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b39:	01 d0                	add    %edx,%eax
  800b3b:	c1 e0 02             	shl    $0x2,%eax
  800b3e:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800b41:	83 ec 0c             	sub    $0xc,%esp
  800b44:	50                   	push   %eax
  800b45:	e8 0a 12 00 00       	call   801d54 <malloc>
  800b4a:	83 c4 10             	add    $0x10,%esp
  800b4d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		if ((uint32) ptr_allocations[13] != (USER_HEAP_START + 1*Mega + 768*kilo)) panic("Wrong start address for the allocated space... ");
  800b50:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800b53:	89 c1                	mov    %eax,%ecx
  800b55:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800b58:	89 d0                	mov    %edx,%eax
  800b5a:	01 c0                	add    %eax,%eax
  800b5c:	01 d0                	add    %edx,%eax
  800b5e:	c1 e0 08             	shl    $0x8,%eax
  800b61:	89 c2                	mov    %eax,%edx
  800b63:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b66:	01 d0                	add    %edx,%eax
  800b68:	05 00 00 00 80       	add    $0x80000000,%eax
  800b6d:	39 c1                	cmp    %eax,%ecx
  800b6f:	74 17                	je     800b88 <_main+0xb50>
  800b71:	83 ec 04             	sub    $0x4,%esp
  800b74:	68 74 2a 80 00       	push   $0x802a74
  800b79:	68 d5 00 00 00       	push   $0xd5
  800b7e:	68 5c 2a 80 00       	push   $0x802a5c
  800b83:	e8 8b 01 00 00       	call   800d13 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+32) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1024+64) panic("Wrong page file allocation: ");
  800b88:	e8 c0 17 00 00       	call   80234d <sys_pf_calculate_allocated_pages>
  800b8d:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800b90:	3d 40 04 00 00       	cmp    $0x440,%eax
  800b95:	74 17                	je     800bae <_main+0xb76>
  800b97:	83 ec 04             	sub    $0x4,%esp
  800b9a:	68 a4 2a 80 00       	push   $0x802aa4
  800b9f:	68 d7 00 00 00       	push   $0xd7
  800ba4:	68 5c 2a 80 00       	push   $0x802a5c
  800ba9:	e8 65 01 00 00       	call   800d13 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800bae:	e8 17 17 00 00       	call   8022ca <sys_calculate_free_frames>
  800bb3:	89 c2                	mov    %eax,%edx
  800bb5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800bb8:	39 c2                	cmp    %eax,%edx
  800bba:	74 17                	je     800bd3 <_main+0xb9b>
  800bbc:	83 ec 04             	sub    $0x4,%esp
  800bbf:	68 c1 2a 80 00       	push   $0x802ac1
  800bc4:	68 d8 00 00 00       	push   $0xd8
  800bc9:	68 5c 2a 80 00       	push   $0x802a5c
  800bce:	e8 40 01 00 00       	call   800d13 <_panic>
	}
	cprintf("Congratulations!! test FIRST FIT allocation (1) completed successfully.\n");
  800bd3:	83 ec 0c             	sub    $0xc,%esp
  800bd6:	68 f8 2a 80 00       	push   $0x802af8
  800bdb:	e8 ea 03 00 00       	call   800fca <cprintf>
  800be0:	83 c4 10             	add    $0x10,%esp

	return;
  800be3:	90                   	nop
}
  800be4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800be7:	5b                   	pop    %ebx
  800be8:	5f                   	pop    %edi
  800be9:	5d                   	pop    %ebp
  800bea:	c3                   	ret    

00800beb <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800beb:	55                   	push   %ebp
  800bec:	89 e5                	mov    %esp,%ebp
  800bee:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800bf1:	e8 09 16 00 00       	call   8021ff <sys_getenvindex>
  800bf6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800bf9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bfc:	89 d0                	mov    %edx,%eax
  800bfe:	01 c0                	add    %eax,%eax
  800c00:	01 d0                	add    %edx,%eax
  800c02:	c1 e0 07             	shl    $0x7,%eax
  800c05:	29 d0                	sub    %edx,%eax
  800c07:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800c0e:	01 c8                	add    %ecx,%eax
  800c10:	01 c0                	add    %eax,%eax
  800c12:	01 d0                	add    %edx,%eax
  800c14:	01 c0                	add    %eax,%eax
  800c16:	01 d0                	add    %edx,%eax
  800c18:	c1 e0 03             	shl    $0x3,%eax
  800c1b:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800c20:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800c25:	a1 20 40 80 00       	mov    0x804020,%eax
  800c2a:	8a 80 f0 ee 00 00    	mov    0xeef0(%eax),%al
  800c30:	84 c0                	test   %al,%al
  800c32:	74 0f                	je     800c43 <libmain+0x58>
		binaryname = myEnv->prog_name;
  800c34:	a1 20 40 80 00       	mov    0x804020,%eax
  800c39:	05 f0 ee 00 00       	add    $0xeef0,%eax
  800c3e:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800c43:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c47:	7e 0a                	jle    800c53 <libmain+0x68>
		binaryname = argv[0];
  800c49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4c:	8b 00                	mov    (%eax),%eax
  800c4e:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  800c53:	83 ec 08             	sub    $0x8,%esp
  800c56:	ff 75 0c             	pushl  0xc(%ebp)
  800c59:	ff 75 08             	pushl  0x8(%ebp)
  800c5c:	e8 d7 f3 ff ff       	call   800038 <_main>
  800c61:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800c64:	e8 31 17 00 00       	call   80239a <sys_disable_interrupt>
	cprintf("**************************************\n");
  800c69:	83 ec 0c             	sub    $0xc,%esp
  800c6c:	68 5c 2b 80 00       	push   $0x802b5c
  800c71:	e8 54 03 00 00       	call   800fca <cprintf>
  800c76:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800c79:	a1 20 40 80 00       	mov    0x804020,%eax
  800c7e:	8b 90 d8 ee 00 00    	mov    0xeed8(%eax),%edx
  800c84:	a1 20 40 80 00       	mov    0x804020,%eax
  800c89:	8b 80 c8 ee 00 00    	mov    0xeec8(%eax),%eax
  800c8f:	83 ec 04             	sub    $0x4,%esp
  800c92:	52                   	push   %edx
  800c93:	50                   	push   %eax
  800c94:	68 84 2b 80 00       	push   $0x802b84
  800c99:	e8 2c 03 00 00       	call   800fca <cprintf>
  800c9e:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800ca1:	a1 20 40 80 00       	mov    0x804020,%eax
  800ca6:	8b 88 e8 ee 00 00    	mov    0xeee8(%eax),%ecx
  800cac:	a1 20 40 80 00       	mov    0x804020,%eax
  800cb1:	8b 90 e4 ee 00 00    	mov    0xeee4(%eax),%edx
  800cb7:	a1 20 40 80 00       	mov    0x804020,%eax
  800cbc:	8b 80 e0 ee 00 00    	mov    0xeee0(%eax),%eax
  800cc2:	51                   	push   %ecx
  800cc3:	52                   	push   %edx
  800cc4:	50                   	push   %eax
  800cc5:	68 ac 2b 80 00       	push   $0x802bac
  800cca:	e8 fb 02 00 00       	call   800fca <cprintf>
  800ccf:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800cd2:	83 ec 0c             	sub    $0xc,%esp
  800cd5:	68 5c 2b 80 00       	push   $0x802b5c
  800cda:	e8 eb 02 00 00       	call   800fca <cprintf>
  800cdf:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800ce2:	e8 cd 16 00 00       	call   8023b4 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800ce7:	e8 19 00 00 00       	call   800d05 <exit>
}
  800cec:	90                   	nop
  800ced:	c9                   	leave  
  800cee:	c3                   	ret    

00800cef <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800cef:	55                   	push   %ebp
  800cf0:	89 e5                	mov    %esp,%ebp
  800cf2:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800cf5:	83 ec 0c             	sub    $0xc,%esp
  800cf8:	6a 00                	push   $0x0
  800cfa:	e8 cc 14 00 00       	call   8021cb <sys_env_destroy>
  800cff:	83 c4 10             	add    $0x10,%esp
}
  800d02:	90                   	nop
  800d03:	c9                   	leave  
  800d04:	c3                   	ret    

00800d05 <exit>:

void
exit(void)
{
  800d05:	55                   	push   %ebp
  800d06:	89 e5                	mov    %esp,%ebp
  800d08:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800d0b:	e8 21 15 00 00       	call   802231 <sys_env_exit>
}
  800d10:	90                   	nop
  800d11:	c9                   	leave  
  800d12:	c3                   	ret    

00800d13 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800d13:	55                   	push   %ebp
  800d14:	89 e5                	mov    %esp,%ebp
  800d16:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800d19:	8d 45 10             	lea    0x10(%ebp),%eax
  800d1c:	83 c0 04             	add    $0x4,%eax
  800d1f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800d22:	a1 18 41 80 00       	mov    0x804118,%eax
  800d27:	85 c0                	test   %eax,%eax
  800d29:	74 16                	je     800d41 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800d2b:	a1 18 41 80 00       	mov    0x804118,%eax
  800d30:	83 ec 08             	sub    $0x8,%esp
  800d33:	50                   	push   %eax
  800d34:	68 04 2c 80 00       	push   $0x802c04
  800d39:	e8 8c 02 00 00       	call   800fca <cprintf>
  800d3e:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800d41:	a1 00 40 80 00       	mov    0x804000,%eax
  800d46:	ff 75 0c             	pushl  0xc(%ebp)
  800d49:	ff 75 08             	pushl  0x8(%ebp)
  800d4c:	50                   	push   %eax
  800d4d:	68 09 2c 80 00       	push   $0x802c09
  800d52:	e8 73 02 00 00       	call   800fca <cprintf>
  800d57:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800d5a:	8b 45 10             	mov    0x10(%ebp),%eax
  800d5d:	83 ec 08             	sub    $0x8,%esp
  800d60:	ff 75 f4             	pushl  -0xc(%ebp)
  800d63:	50                   	push   %eax
  800d64:	e8 f6 01 00 00       	call   800f5f <vcprintf>
  800d69:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800d6c:	83 ec 08             	sub    $0x8,%esp
  800d6f:	6a 00                	push   $0x0
  800d71:	68 25 2c 80 00       	push   $0x802c25
  800d76:	e8 e4 01 00 00       	call   800f5f <vcprintf>
  800d7b:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800d7e:	e8 82 ff ff ff       	call   800d05 <exit>

	// should not return here
	while (1) ;
  800d83:	eb fe                	jmp    800d83 <_panic+0x70>

00800d85 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800d85:	55                   	push   %ebp
  800d86:	89 e5                	mov    %esp,%ebp
  800d88:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800d8b:	a1 20 40 80 00       	mov    0x804020,%eax
  800d90:	8b 50 74             	mov    0x74(%eax),%edx
  800d93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d96:	39 c2                	cmp    %eax,%edx
  800d98:	74 14                	je     800dae <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800d9a:	83 ec 04             	sub    $0x4,%esp
  800d9d:	68 28 2c 80 00       	push   $0x802c28
  800da2:	6a 26                	push   $0x26
  800da4:	68 74 2c 80 00       	push   $0x802c74
  800da9:	e8 65 ff ff ff       	call   800d13 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800dae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800db5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800dbc:	e9 c4 00 00 00       	jmp    800e85 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800dc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dc4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dce:	01 d0                	add    %edx,%eax
  800dd0:	8b 00                	mov    (%eax),%eax
  800dd2:	85 c0                	test   %eax,%eax
  800dd4:	75 08                	jne    800dde <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800dd6:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800dd9:	e9 a4 00 00 00       	jmp    800e82 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  800dde:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800de5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800dec:	eb 6b                	jmp    800e59 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800dee:	a1 20 40 80 00       	mov    0x804020,%eax
  800df3:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800df9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800dfc:	89 d0                	mov    %edx,%eax
  800dfe:	c1 e0 02             	shl    $0x2,%eax
  800e01:	01 d0                	add    %edx,%eax
  800e03:	c1 e0 02             	shl    $0x2,%eax
  800e06:	01 c8                	add    %ecx,%eax
  800e08:	8a 40 04             	mov    0x4(%eax),%al
  800e0b:	84 c0                	test   %al,%al
  800e0d:	75 47                	jne    800e56 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800e0f:	a1 20 40 80 00       	mov    0x804020,%eax
  800e14:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800e1a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800e1d:	89 d0                	mov    %edx,%eax
  800e1f:	c1 e0 02             	shl    $0x2,%eax
  800e22:	01 d0                	add    %edx,%eax
  800e24:	c1 e0 02             	shl    $0x2,%eax
  800e27:	01 c8                	add    %ecx,%eax
  800e29:	8b 00                	mov    (%eax),%eax
  800e2b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800e2e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800e31:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e36:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800e38:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e3b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800e42:	8b 45 08             	mov    0x8(%ebp),%eax
  800e45:	01 c8                	add    %ecx,%eax
  800e47:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800e49:	39 c2                	cmp    %eax,%edx
  800e4b:	75 09                	jne    800e56 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800e4d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800e54:	eb 12                	jmp    800e68 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e56:	ff 45 e8             	incl   -0x18(%ebp)
  800e59:	a1 20 40 80 00       	mov    0x804020,%eax
  800e5e:	8b 50 74             	mov    0x74(%eax),%edx
  800e61:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800e64:	39 c2                	cmp    %eax,%edx
  800e66:	77 86                	ja     800dee <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800e68:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800e6c:	75 14                	jne    800e82 <CheckWSWithoutLastIndex+0xfd>
			panic(
  800e6e:	83 ec 04             	sub    $0x4,%esp
  800e71:	68 80 2c 80 00       	push   $0x802c80
  800e76:	6a 3a                	push   $0x3a
  800e78:	68 74 2c 80 00       	push   $0x802c74
  800e7d:	e8 91 fe ff ff       	call   800d13 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800e82:	ff 45 f0             	incl   -0x10(%ebp)
  800e85:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e88:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800e8b:	0f 8c 30 ff ff ff    	jl     800dc1 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800e91:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e98:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800e9f:	eb 27                	jmp    800ec8 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800ea1:	a1 20 40 80 00       	mov    0x804020,%eax
  800ea6:	8b 88 30 ef 00 00    	mov    0xef30(%eax),%ecx
  800eac:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800eaf:	89 d0                	mov    %edx,%eax
  800eb1:	c1 e0 02             	shl    $0x2,%eax
  800eb4:	01 d0                	add    %edx,%eax
  800eb6:	c1 e0 02             	shl    $0x2,%eax
  800eb9:	01 c8                	add    %ecx,%eax
  800ebb:	8a 40 04             	mov    0x4(%eax),%al
  800ebe:	3c 01                	cmp    $0x1,%al
  800ec0:	75 03                	jne    800ec5 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800ec2:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ec5:	ff 45 e0             	incl   -0x20(%ebp)
  800ec8:	a1 20 40 80 00       	mov    0x804020,%eax
  800ecd:	8b 50 74             	mov    0x74(%eax),%edx
  800ed0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ed3:	39 c2                	cmp    %eax,%edx
  800ed5:	77 ca                	ja     800ea1 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800ed7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800eda:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800edd:	74 14                	je     800ef3 <CheckWSWithoutLastIndex+0x16e>
		panic(
  800edf:	83 ec 04             	sub    $0x4,%esp
  800ee2:	68 d4 2c 80 00       	push   $0x802cd4
  800ee7:	6a 44                	push   $0x44
  800ee9:	68 74 2c 80 00       	push   $0x802c74
  800eee:	e8 20 fe ff ff       	call   800d13 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800ef3:	90                   	nop
  800ef4:	c9                   	leave  
  800ef5:	c3                   	ret    

00800ef6 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800ef6:	55                   	push   %ebp
  800ef7:	89 e5                	mov    %esp,%ebp
  800ef9:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800efc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eff:	8b 00                	mov    (%eax),%eax
  800f01:	8d 48 01             	lea    0x1(%eax),%ecx
  800f04:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f07:	89 0a                	mov    %ecx,(%edx)
  800f09:	8b 55 08             	mov    0x8(%ebp),%edx
  800f0c:	88 d1                	mov    %dl,%cl
  800f0e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f11:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800f15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f18:	8b 00                	mov    (%eax),%eax
  800f1a:	3d ff 00 00 00       	cmp    $0xff,%eax
  800f1f:	75 2c                	jne    800f4d <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800f21:	a0 24 40 80 00       	mov    0x804024,%al
  800f26:	0f b6 c0             	movzbl %al,%eax
  800f29:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f2c:	8b 12                	mov    (%edx),%edx
  800f2e:	89 d1                	mov    %edx,%ecx
  800f30:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f33:	83 c2 08             	add    $0x8,%edx
  800f36:	83 ec 04             	sub    $0x4,%esp
  800f39:	50                   	push   %eax
  800f3a:	51                   	push   %ecx
  800f3b:	52                   	push   %edx
  800f3c:	e8 48 12 00 00       	call   802189 <sys_cputs>
  800f41:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800f44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f47:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800f4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f50:	8b 40 04             	mov    0x4(%eax),%eax
  800f53:	8d 50 01             	lea    0x1(%eax),%edx
  800f56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f59:	89 50 04             	mov    %edx,0x4(%eax)
}
  800f5c:	90                   	nop
  800f5d:	c9                   	leave  
  800f5e:	c3                   	ret    

00800f5f <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800f5f:	55                   	push   %ebp
  800f60:	89 e5                	mov    %esp,%ebp
  800f62:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800f68:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800f6f:	00 00 00 
	b.cnt = 0;
  800f72:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800f79:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800f7c:	ff 75 0c             	pushl  0xc(%ebp)
  800f7f:	ff 75 08             	pushl  0x8(%ebp)
  800f82:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800f88:	50                   	push   %eax
  800f89:	68 f6 0e 80 00       	push   $0x800ef6
  800f8e:	e8 11 02 00 00       	call   8011a4 <vprintfmt>
  800f93:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800f96:	a0 24 40 80 00       	mov    0x804024,%al
  800f9b:	0f b6 c0             	movzbl %al,%eax
  800f9e:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800fa4:	83 ec 04             	sub    $0x4,%esp
  800fa7:	50                   	push   %eax
  800fa8:	52                   	push   %edx
  800fa9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800faf:	83 c0 08             	add    $0x8,%eax
  800fb2:	50                   	push   %eax
  800fb3:	e8 d1 11 00 00       	call   802189 <sys_cputs>
  800fb8:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800fbb:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  800fc2:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800fc8:	c9                   	leave  
  800fc9:	c3                   	ret    

00800fca <cprintf>:

int cprintf(const char *fmt, ...) {
  800fca:	55                   	push   %ebp
  800fcb:	89 e5                	mov    %esp,%ebp
  800fcd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800fd0:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  800fd7:	8d 45 0c             	lea    0xc(%ebp),%eax
  800fda:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800fdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe0:	83 ec 08             	sub    $0x8,%esp
  800fe3:	ff 75 f4             	pushl  -0xc(%ebp)
  800fe6:	50                   	push   %eax
  800fe7:	e8 73 ff ff ff       	call   800f5f <vcprintf>
  800fec:	83 c4 10             	add    $0x10,%esp
  800fef:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800ff2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ff5:	c9                   	leave  
  800ff6:	c3                   	ret    

00800ff7 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ff7:	55                   	push   %ebp
  800ff8:	89 e5                	mov    %esp,%ebp
  800ffa:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800ffd:	e8 98 13 00 00       	call   80239a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801002:	8d 45 0c             	lea    0xc(%ebp),%eax
  801005:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801008:	8b 45 08             	mov    0x8(%ebp),%eax
  80100b:	83 ec 08             	sub    $0x8,%esp
  80100e:	ff 75 f4             	pushl  -0xc(%ebp)
  801011:	50                   	push   %eax
  801012:	e8 48 ff ff ff       	call   800f5f <vcprintf>
  801017:	83 c4 10             	add    $0x10,%esp
  80101a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80101d:	e8 92 13 00 00       	call   8023b4 <sys_enable_interrupt>
	return cnt;
  801022:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801025:	c9                   	leave  
  801026:	c3                   	ret    

00801027 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801027:	55                   	push   %ebp
  801028:	89 e5                	mov    %esp,%ebp
  80102a:	53                   	push   %ebx
  80102b:	83 ec 14             	sub    $0x14,%esp
  80102e:	8b 45 10             	mov    0x10(%ebp),%eax
  801031:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801034:	8b 45 14             	mov    0x14(%ebp),%eax
  801037:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80103a:	8b 45 18             	mov    0x18(%ebp),%eax
  80103d:	ba 00 00 00 00       	mov    $0x0,%edx
  801042:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801045:	77 55                	ja     80109c <printnum+0x75>
  801047:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80104a:	72 05                	jb     801051 <printnum+0x2a>
  80104c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80104f:	77 4b                	ja     80109c <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801051:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801054:	8d 58 ff             	lea    -0x1(%eax),%ebx
  801057:	8b 45 18             	mov    0x18(%ebp),%eax
  80105a:	ba 00 00 00 00       	mov    $0x0,%edx
  80105f:	52                   	push   %edx
  801060:	50                   	push   %eax
  801061:	ff 75 f4             	pushl  -0xc(%ebp)
  801064:	ff 75 f0             	pushl  -0x10(%ebp)
  801067:	e8 6c 17 00 00       	call   8027d8 <__udivdi3>
  80106c:	83 c4 10             	add    $0x10,%esp
  80106f:	83 ec 04             	sub    $0x4,%esp
  801072:	ff 75 20             	pushl  0x20(%ebp)
  801075:	53                   	push   %ebx
  801076:	ff 75 18             	pushl  0x18(%ebp)
  801079:	52                   	push   %edx
  80107a:	50                   	push   %eax
  80107b:	ff 75 0c             	pushl  0xc(%ebp)
  80107e:	ff 75 08             	pushl  0x8(%ebp)
  801081:	e8 a1 ff ff ff       	call   801027 <printnum>
  801086:	83 c4 20             	add    $0x20,%esp
  801089:	eb 1a                	jmp    8010a5 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80108b:	83 ec 08             	sub    $0x8,%esp
  80108e:	ff 75 0c             	pushl  0xc(%ebp)
  801091:	ff 75 20             	pushl  0x20(%ebp)
  801094:	8b 45 08             	mov    0x8(%ebp),%eax
  801097:	ff d0                	call   *%eax
  801099:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80109c:	ff 4d 1c             	decl   0x1c(%ebp)
  80109f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8010a3:	7f e6                	jg     80108b <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8010a5:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8010a8:	bb 00 00 00 00       	mov    $0x0,%ebx
  8010ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010b3:	53                   	push   %ebx
  8010b4:	51                   	push   %ecx
  8010b5:	52                   	push   %edx
  8010b6:	50                   	push   %eax
  8010b7:	e8 2c 18 00 00       	call   8028e8 <__umoddi3>
  8010bc:	83 c4 10             	add    $0x10,%esp
  8010bf:	05 34 2f 80 00       	add    $0x802f34,%eax
  8010c4:	8a 00                	mov    (%eax),%al
  8010c6:	0f be c0             	movsbl %al,%eax
  8010c9:	83 ec 08             	sub    $0x8,%esp
  8010cc:	ff 75 0c             	pushl  0xc(%ebp)
  8010cf:	50                   	push   %eax
  8010d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d3:	ff d0                	call   *%eax
  8010d5:	83 c4 10             	add    $0x10,%esp
}
  8010d8:	90                   	nop
  8010d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8010dc:	c9                   	leave  
  8010dd:	c3                   	ret    

008010de <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8010de:	55                   	push   %ebp
  8010df:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8010e1:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8010e5:	7e 1c                	jle    801103 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8010e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ea:	8b 00                	mov    (%eax),%eax
  8010ec:	8d 50 08             	lea    0x8(%eax),%edx
  8010ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f2:	89 10                	mov    %edx,(%eax)
  8010f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f7:	8b 00                	mov    (%eax),%eax
  8010f9:	83 e8 08             	sub    $0x8,%eax
  8010fc:	8b 50 04             	mov    0x4(%eax),%edx
  8010ff:	8b 00                	mov    (%eax),%eax
  801101:	eb 40                	jmp    801143 <getuint+0x65>
	else if (lflag)
  801103:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801107:	74 1e                	je     801127 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801109:	8b 45 08             	mov    0x8(%ebp),%eax
  80110c:	8b 00                	mov    (%eax),%eax
  80110e:	8d 50 04             	lea    0x4(%eax),%edx
  801111:	8b 45 08             	mov    0x8(%ebp),%eax
  801114:	89 10                	mov    %edx,(%eax)
  801116:	8b 45 08             	mov    0x8(%ebp),%eax
  801119:	8b 00                	mov    (%eax),%eax
  80111b:	83 e8 04             	sub    $0x4,%eax
  80111e:	8b 00                	mov    (%eax),%eax
  801120:	ba 00 00 00 00       	mov    $0x0,%edx
  801125:	eb 1c                	jmp    801143 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801127:	8b 45 08             	mov    0x8(%ebp),%eax
  80112a:	8b 00                	mov    (%eax),%eax
  80112c:	8d 50 04             	lea    0x4(%eax),%edx
  80112f:	8b 45 08             	mov    0x8(%ebp),%eax
  801132:	89 10                	mov    %edx,(%eax)
  801134:	8b 45 08             	mov    0x8(%ebp),%eax
  801137:	8b 00                	mov    (%eax),%eax
  801139:	83 e8 04             	sub    $0x4,%eax
  80113c:	8b 00                	mov    (%eax),%eax
  80113e:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801143:	5d                   	pop    %ebp
  801144:	c3                   	ret    

00801145 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801145:	55                   	push   %ebp
  801146:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801148:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80114c:	7e 1c                	jle    80116a <getint+0x25>
		return va_arg(*ap, long long);
  80114e:	8b 45 08             	mov    0x8(%ebp),%eax
  801151:	8b 00                	mov    (%eax),%eax
  801153:	8d 50 08             	lea    0x8(%eax),%edx
  801156:	8b 45 08             	mov    0x8(%ebp),%eax
  801159:	89 10                	mov    %edx,(%eax)
  80115b:	8b 45 08             	mov    0x8(%ebp),%eax
  80115e:	8b 00                	mov    (%eax),%eax
  801160:	83 e8 08             	sub    $0x8,%eax
  801163:	8b 50 04             	mov    0x4(%eax),%edx
  801166:	8b 00                	mov    (%eax),%eax
  801168:	eb 38                	jmp    8011a2 <getint+0x5d>
	else if (lflag)
  80116a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80116e:	74 1a                	je     80118a <getint+0x45>
		return va_arg(*ap, long);
  801170:	8b 45 08             	mov    0x8(%ebp),%eax
  801173:	8b 00                	mov    (%eax),%eax
  801175:	8d 50 04             	lea    0x4(%eax),%edx
  801178:	8b 45 08             	mov    0x8(%ebp),%eax
  80117b:	89 10                	mov    %edx,(%eax)
  80117d:	8b 45 08             	mov    0x8(%ebp),%eax
  801180:	8b 00                	mov    (%eax),%eax
  801182:	83 e8 04             	sub    $0x4,%eax
  801185:	8b 00                	mov    (%eax),%eax
  801187:	99                   	cltd   
  801188:	eb 18                	jmp    8011a2 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80118a:	8b 45 08             	mov    0x8(%ebp),%eax
  80118d:	8b 00                	mov    (%eax),%eax
  80118f:	8d 50 04             	lea    0x4(%eax),%edx
  801192:	8b 45 08             	mov    0x8(%ebp),%eax
  801195:	89 10                	mov    %edx,(%eax)
  801197:	8b 45 08             	mov    0x8(%ebp),%eax
  80119a:	8b 00                	mov    (%eax),%eax
  80119c:	83 e8 04             	sub    $0x4,%eax
  80119f:	8b 00                	mov    (%eax),%eax
  8011a1:	99                   	cltd   
}
  8011a2:	5d                   	pop    %ebp
  8011a3:	c3                   	ret    

008011a4 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8011a4:	55                   	push   %ebp
  8011a5:	89 e5                	mov    %esp,%ebp
  8011a7:	56                   	push   %esi
  8011a8:	53                   	push   %ebx
  8011a9:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8011ac:	eb 17                	jmp    8011c5 <vprintfmt+0x21>
			if (ch == '\0')
  8011ae:	85 db                	test   %ebx,%ebx
  8011b0:	0f 84 af 03 00 00    	je     801565 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8011b6:	83 ec 08             	sub    $0x8,%esp
  8011b9:	ff 75 0c             	pushl  0xc(%ebp)
  8011bc:	53                   	push   %ebx
  8011bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c0:	ff d0                	call   *%eax
  8011c2:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8011c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c8:	8d 50 01             	lea    0x1(%eax),%edx
  8011cb:	89 55 10             	mov    %edx,0x10(%ebp)
  8011ce:	8a 00                	mov    (%eax),%al
  8011d0:	0f b6 d8             	movzbl %al,%ebx
  8011d3:	83 fb 25             	cmp    $0x25,%ebx
  8011d6:	75 d6                	jne    8011ae <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8011d8:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8011dc:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8011e3:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8011ea:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8011f1:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8011f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fb:	8d 50 01             	lea    0x1(%eax),%edx
  8011fe:	89 55 10             	mov    %edx,0x10(%ebp)
  801201:	8a 00                	mov    (%eax),%al
  801203:	0f b6 d8             	movzbl %al,%ebx
  801206:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801209:	83 f8 55             	cmp    $0x55,%eax
  80120c:	0f 87 2b 03 00 00    	ja     80153d <vprintfmt+0x399>
  801212:	8b 04 85 58 2f 80 00 	mov    0x802f58(,%eax,4),%eax
  801219:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80121b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80121f:	eb d7                	jmp    8011f8 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801221:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801225:	eb d1                	jmp    8011f8 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801227:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80122e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801231:	89 d0                	mov    %edx,%eax
  801233:	c1 e0 02             	shl    $0x2,%eax
  801236:	01 d0                	add    %edx,%eax
  801238:	01 c0                	add    %eax,%eax
  80123a:	01 d8                	add    %ebx,%eax
  80123c:	83 e8 30             	sub    $0x30,%eax
  80123f:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801242:	8b 45 10             	mov    0x10(%ebp),%eax
  801245:	8a 00                	mov    (%eax),%al
  801247:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80124a:	83 fb 2f             	cmp    $0x2f,%ebx
  80124d:	7e 3e                	jle    80128d <vprintfmt+0xe9>
  80124f:	83 fb 39             	cmp    $0x39,%ebx
  801252:	7f 39                	jg     80128d <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801254:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801257:	eb d5                	jmp    80122e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801259:	8b 45 14             	mov    0x14(%ebp),%eax
  80125c:	83 c0 04             	add    $0x4,%eax
  80125f:	89 45 14             	mov    %eax,0x14(%ebp)
  801262:	8b 45 14             	mov    0x14(%ebp),%eax
  801265:	83 e8 04             	sub    $0x4,%eax
  801268:	8b 00                	mov    (%eax),%eax
  80126a:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80126d:	eb 1f                	jmp    80128e <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80126f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801273:	79 83                	jns    8011f8 <vprintfmt+0x54>
				width = 0;
  801275:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80127c:	e9 77 ff ff ff       	jmp    8011f8 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801281:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801288:	e9 6b ff ff ff       	jmp    8011f8 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80128d:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80128e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801292:	0f 89 60 ff ff ff    	jns    8011f8 <vprintfmt+0x54>
				width = precision, precision = -1;
  801298:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80129b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80129e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8012a5:	e9 4e ff ff ff       	jmp    8011f8 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8012aa:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8012ad:	e9 46 ff ff ff       	jmp    8011f8 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8012b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8012b5:	83 c0 04             	add    $0x4,%eax
  8012b8:	89 45 14             	mov    %eax,0x14(%ebp)
  8012bb:	8b 45 14             	mov    0x14(%ebp),%eax
  8012be:	83 e8 04             	sub    $0x4,%eax
  8012c1:	8b 00                	mov    (%eax),%eax
  8012c3:	83 ec 08             	sub    $0x8,%esp
  8012c6:	ff 75 0c             	pushl  0xc(%ebp)
  8012c9:	50                   	push   %eax
  8012ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cd:	ff d0                	call   *%eax
  8012cf:	83 c4 10             	add    $0x10,%esp
			break;
  8012d2:	e9 89 02 00 00       	jmp    801560 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8012d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8012da:	83 c0 04             	add    $0x4,%eax
  8012dd:	89 45 14             	mov    %eax,0x14(%ebp)
  8012e0:	8b 45 14             	mov    0x14(%ebp),%eax
  8012e3:	83 e8 04             	sub    $0x4,%eax
  8012e6:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8012e8:	85 db                	test   %ebx,%ebx
  8012ea:	79 02                	jns    8012ee <vprintfmt+0x14a>
				err = -err;
  8012ec:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8012ee:	83 fb 64             	cmp    $0x64,%ebx
  8012f1:	7f 0b                	jg     8012fe <vprintfmt+0x15a>
  8012f3:	8b 34 9d a0 2d 80 00 	mov    0x802da0(,%ebx,4),%esi
  8012fa:	85 f6                	test   %esi,%esi
  8012fc:	75 19                	jne    801317 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8012fe:	53                   	push   %ebx
  8012ff:	68 45 2f 80 00       	push   $0x802f45
  801304:	ff 75 0c             	pushl  0xc(%ebp)
  801307:	ff 75 08             	pushl  0x8(%ebp)
  80130a:	e8 5e 02 00 00       	call   80156d <printfmt>
  80130f:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801312:	e9 49 02 00 00       	jmp    801560 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801317:	56                   	push   %esi
  801318:	68 4e 2f 80 00       	push   $0x802f4e
  80131d:	ff 75 0c             	pushl  0xc(%ebp)
  801320:	ff 75 08             	pushl  0x8(%ebp)
  801323:	e8 45 02 00 00       	call   80156d <printfmt>
  801328:	83 c4 10             	add    $0x10,%esp
			break;
  80132b:	e9 30 02 00 00       	jmp    801560 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801330:	8b 45 14             	mov    0x14(%ebp),%eax
  801333:	83 c0 04             	add    $0x4,%eax
  801336:	89 45 14             	mov    %eax,0x14(%ebp)
  801339:	8b 45 14             	mov    0x14(%ebp),%eax
  80133c:	83 e8 04             	sub    $0x4,%eax
  80133f:	8b 30                	mov    (%eax),%esi
  801341:	85 f6                	test   %esi,%esi
  801343:	75 05                	jne    80134a <vprintfmt+0x1a6>
				p = "(null)";
  801345:	be 51 2f 80 00       	mov    $0x802f51,%esi
			if (width > 0 && padc != '-')
  80134a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80134e:	7e 6d                	jle    8013bd <vprintfmt+0x219>
  801350:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801354:	74 67                	je     8013bd <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801356:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801359:	83 ec 08             	sub    $0x8,%esp
  80135c:	50                   	push   %eax
  80135d:	56                   	push   %esi
  80135e:	e8 0c 03 00 00       	call   80166f <strnlen>
  801363:	83 c4 10             	add    $0x10,%esp
  801366:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801369:	eb 16                	jmp    801381 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80136b:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80136f:	83 ec 08             	sub    $0x8,%esp
  801372:	ff 75 0c             	pushl  0xc(%ebp)
  801375:	50                   	push   %eax
  801376:	8b 45 08             	mov    0x8(%ebp),%eax
  801379:	ff d0                	call   *%eax
  80137b:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80137e:	ff 4d e4             	decl   -0x1c(%ebp)
  801381:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801385:	7f e4                	jg     80136b <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801387:	eb 34                	jmp    8013bd <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801389:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80138d:	74 1c                	je     8013ab <vprintfmt+0x207>
  80138f:	83 fb 1f             	cmp    $0x1f,%ebx
  801392:	7e 05                	jle    801399 <vprintfmt+0x1f5>
  801394:	83 fb 7e             	cmp    $0x7e,%ebx
  801397:	7e 12                	jle    8013ab <vprintfmt+0x207>
					putch('?', putdat);
  801399:	83 ec 08             	sub    $0x8,%esp
  80139c:	ff 75 0c             	pushl  0xc(%ebp)
  80139f:	6a 3f                	push   $0x3f
  8013a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a4:	ff d0                	call   *%eax
  8013a6:	83 c4 10             	add    $0x10,%esp
  8013a9:	eb 0f                	jmp    8013ba <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8013ab:	83 ec 08             	sub    $0x8,%esp
  8013ae:	ff 75 0c             	pushl  0xc(%ebp)
  8013b1:	53                   	push   %ebx
  8013b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b5:	ff d0                	call   *%eax
  8013b7:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8013ba:	ff 4d e4             	decl   -0x1c(%ebp)
  8013bd:	89 f0                	mov    %esi,%eax
  8013bf:	8d 70 01             	lea    0x1(%eax),%esi
  8013c2:	8a 00                	mov    (%eax),%al
  8013c4:	0f be d8             	movsbl %al,%ebx
  8013c7:	85 db                	test   %ebx,%ebx
  8013c9:	74 24                	je     8013ef <vprintfmt+0x24b>
  8013cb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8013cf:	78 b8                	js     801389 <vprintfmt+0x1e5>
  8013d1:	ff 4d e0             	decl   -0x20(%ebp)
  8013d4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8013d8:	79 af                	jns    801389 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8013da:	eb 13                	jmp    8013ef <vprintfmt+0x24b>
				putch(' ', putdat);
  8013dc:	83 ec 08             	sub    $0x8,%esp
  8013df:	ff 75 0c             	pushl  0xc(%ebp)
  8013e2:	6a 20                	push   $0x20
  8013e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e7:	ff d0                	call   *%eax
  8013e9:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8013ec:	ff 4d e4             	decl   -0x1c(%ebp)
  8013ef:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8013f3:	7f e7                	jg     8013dc <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8013f5:	e9 66 01 00 00       	jmp    801560 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8013fa:	83 ec 08             	sub    $0x8,%esp
  8013fd:	ff 75 e8             	pushl  -0x18(%ebp)
  801400:	8d 45 14             	lea    0x14(%ebp),%eax
  801403:	50                   	push   %eax
  801404:	e8 3c fd ff ff       	call   801145 <getint>
  801409:	83 c4 10             	add    $0x10,%esp
  80140c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80140f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801412:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801415:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801418:	85 d2                	test   %edx,%edx
  80141a:	79 23                	jns    80143f <vprintfmt+0x29b>
				putch('-', putdat);
  80141c:	83 ec 08             	sub    $0x8,%esp
  80141f:	ff 75 0c             	pushl  0xc(%ebp)
  801422:	6a 2d                	push   $0x2d
  801424:	8b 45 08             	mov    0x8(%ebp),%eax
  801427:	ff d0                	call   *%eax
  801429:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80142c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80142f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801432:	f7 d8                	neg    %eax
  801434:	83 d2 00             	adc    $0x0,%edx
  801437:	f7 da                	neg    %edx
  801439:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80143c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80143f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801446:	e9 bc 00 00 00       	jmp    801507 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80144b:	83 ec 08             	sub    $0x8,%esp
  80144e:	ff 75 e8             	pushl  -0x18(%ebp)
  801451:	8d 45 14             	lea    0x14(%ebp),%eax
  801454:	50                   	push   %eax
  801455:	e8 84 fc ff ff       	call   8010de <getuint>
  80145a:	83 c4 10             	add    $0x10,%esp
  80145d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801460:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801463:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80146a:	e9 98 00 00 00       	jmp    801507 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80146f:	83 ec 08             	sub    $0x8,%esp
  801472:	ff 75 0c             	pushl  0xc(%ebp)
  801475:	6a 58                	push   $0x58
  801477:	8b 45 08             	mov    0x8(%ebp),%eax
  80147a:	ff d0                	call   *%eax
  80147c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80147f:	83 ec 08             	sub    $0x8,%esp
  801482:	ff 75 0c             	pushl  0xc(%ebp)
  801485:	6a 58                	push   $0x58
  801487:	8b 45 08             	mov    0x8(%ebp),%eax
  80148a:	ff d0                	call   *%eax
  80148c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80148f:	83 ec 08             	sub    $0x8,%esp
  801492:	ff 75 0c             	pushl  0xc(%ebp)
  801495:	6a 58                	push   $0x58
  801497:	8b 45 08             	mov    0x8(%ebp),%eax
  80149a:	ff d0                	call   *%eax
  80149c:	83 c4 10             	add    $0x10,%esp
			break;
  80149f:	e9 bc 00 00 00       	jmp    801560 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8014a4:	83 ec 08             	sub    $0x8,%esp
  8014a7:	ff 75 0c             	pushl  0xc(%ebp)
  8014aa:	6a 30                	push   $0x30
  8014ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8014af:	ff d0                	call   *%eax
  8014b1:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8014b4:	83 ec 08             	sub    $0x8,%esp
  8014b7:	ff 75 0c             	pushl  0xc(%ebp)
  8014ba:	6a 78                	push   $0x78
  8014bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bf:	ff d0                	call   *%eax
  8014c1:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8014c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8014c7:	83 c0 04             	add    $0x4,%eax
  8014ca:	89 45 14             	mov    %eax,0x14(%ebp)
  8014cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8014d0:	83 e8 04             	sub    $0x4,%eax
  8014d3:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8014d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8014d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8014df:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8014e6:	eb 1f                	jmp    801507 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8014e8:	83 ec 08             	sub    $0x8,%esp
  8014eb:	ff 75 e8             	pushl  -0x18(%ebp)
  8014ee:	8d 45 14             	lea    0x14(%ebp),%eax
  8014f1:	50                   	push   %eax
  8014f2:	e8 e7 fb ff ff       	call   8010de <getuint>
  8014f7:	83 c4 10             	add    $0x10,%esp
  8014fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8014fd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801500:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801507:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80150b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80150e:	83 ec 04             	sub    $0x4,%esp
  801511:	52                   	push   %edx
  801512:	ff 75 e4             	pushl  -0x1c(%ebp)
  801515:	50                   	push   %eax
  801516:	ff 75 f4             	pushl  -0xc(%ebp)
  801519:	ff 75 f0             	pushl  -0x10(%ebp)
  80151c:	ff 75 0c             	pushl  0xc(%ebp)
  80151f:	ff 75 08             	pushl  0x8(%ebp)
  801522:	e8 00 fb ff ff       	call   801027 <printnum>
  801527:	83 c4 20             	add    $0x20,%esp
			break;
  80152a:	eb 34                	jmp    801560 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80152c:	83 ec 08             	sub    $0x8,%esp
  80152f:	ff 75 0c             	pushl  0xc(%ebp)
  801532:	53                   	push   %ebx
  801533:	8b 45 08             	mov    0x8(%ebp),%eax
  801536:	ff d0                	call   *%eax
  801538:	83 c4 10             	add    $0x10,%esp
			break;
  80153b:	eb 23                	jmp    801560 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80153d:	83 ec 08             	sub    $0x8,%esp
  801540:	ff 75 0c             	pushl  0xc(%ebp)
  801543:	6a 25                	push   $0x25
  801545:	8b 45 08             	mov    0x8(%ebp),%eax
  801548:	ff d0                	call   *%eax
  80154a:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80154d:	ff 4d 10             	decl   0x10(%ebp)
  801550:	eb 03                	jmp    801555 <vprintfmt+0x3b1>
  801552:	ff 4d 10             	decl   0x10(%ebp)
  801555:	8b 45 10             	mov    0x10(%ebp),%eax
  801558:	48                   	dec    %eax
  801559:	8a 00                	mov    (%eax),%al
  80155b:	3c 25                	cmp    $0x25,%al
  80155d:	75 f3                	jne    801552 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80155f:	90                   	nop
		}
	}
  801560:	e9 47 fc ff ff       	jmp    8011ac <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801565:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801566:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801569:	5b                   	pop    %ebx
  80156a:	5e                   	pop    %esi
  80156b:	5d                   	pop    %ebp
  80156c:	c3                   	ret    

0080156d <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80156d:	55                   	push   %ebp
  80156e:	89 e5                	mov    %esp,%ebp
  801570:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801573:	8d 45 10             	lea    0x10(%ebp),%eax
  801576:	83 c0 04             	add    $0x4,%eax
  801579:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80157c:	8b 45 10             	mov    0x10(%ebp),%eax
  80157f:	ff 75 f4             	pushl  -0xc(%ebp)
  801582:	50                   	push   %eax
  801583:	ff 75 0c             	pushl  0xc(%ebp)
  801586:	ff 75 08             	pushl  0x8(%ebp)
  801589:	e8 16 fc ff ff       	call   8011a4 <vprintfmt>
  80158e:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801591:	90                   	nop
  801592:	c9                   	leave  
  801593:	c3                   	ret    

00801594 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801594:	55                   	push   %ebp
  801595:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801597:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159a:	8b 40 08             	mov    0x8(%eax),%eax
  80159d:	8d 50 01             	lea    0x1(%eax),%edx
  8015a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a3:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8015a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a9:	8b 10                	mov    (%eax),%edx
  8015ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ae:	8b 40 04             	mov    0x4(%eax),%eax
  8015b1:	39 c2                	cmp    %eax,%edx
  8015b3:	73 12                	jae    8015c7 <sprintputch+0x33>
		*b->buf++ = ch;
  8015b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b8:	8b 00                	mov    (%eax),%eax
  8015ba:	8d 48 01             	lea    0x1(%eax),%ecx
  8015bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015c0:	89 0a                	mov    %ecx,(%edx)
  8015c2:	8b 55 08             	mov    0x8(%ebp),%edx
  8015c5:	88 10                	mov    %dl,(%eax)
}
  8015c7:	90                   	nop
  8015c8:	5d                   	pop    %ebp
  8015c9:	c3                   	ret    

008015ca <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8015ca:	55                   	push   %ebp
  8015cb:	89 e5                	mov    %esp,%ebp
  8015cd:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8015d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8015d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015df:	01 d0                	add    %edx,%eax
  8015e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8015e4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8015eb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015ef:	74 06                	je     8015f7 <vsnprintf+0x2d>
  8015f1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8015f5:	7f 07                	jg     8015fe <vsnprintf+0x34>
		return -E_INVAL;
  8015f7:	b8 03 00 00 00       	mov    $0x3,%eax
  8015fc:	eb 20                	jmp    80161e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8015fe:	ff 75 14             	pushl  0x14(%ebp)
  801601:	ff 75 10             	pushl  0x10(%ebp)
  801604:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801607:	50                   	push   %eax
  801608:	68 94 15 80 00       	push   $0x801594
  80160d:	e8 92 fb ff ff       	call   8011a4 <vprintfmt>
  801612:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801615:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801618:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80161b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80161e:	c9                   	leave  
  80161f:	c3                   	ret    

00801620 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801620:	55                   	push   %ebp
  801621:	89 e5                	mov    %esp,%ebp
  801623:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801626:	8d 45 10             	lea    0x10(%ebp),%eax
  801629:	83 c0 04             	add    $0x4,%eax
  80162c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80162f:	8b 45 10             	mov    0x10(%ebp),%eax
  801632:	ff 75 f4             	pushl  -0xc(%ebp)
  801635:	50                   	push   %eax
  801636:	ff 75 0c             	pushl  0xc(%ebp)
  801639:	ff 75 08             	pushl  0x8(%ebp)
  80163c:	e8 89 ff ff ff       	call   8015ca <vsnprintf>
  801641:	83 c4 10             	add    $0x10,%esp
  801644:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801647:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80164a:	c9                   	leave  
  80164b:	c3                   	ret    

0080164c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80164c:	55                   	push   %ebp
  80164d:	89 e5                	mov    %esp,%ebp
  80164f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801652:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801659:	eb 06                	jmp    801661 <strlen+0x15>
		n++;
  80165b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80165e:	ff 45 08             	incl   0x8(%ebp)
  801661:	8b 45 08             	mov    0x8(%ebp),%eax
  801664:	8a 00                	mov    (%eax),%al
  801666:	84 c0                	test   %al,%al
  801668:	75 f1                	jne    80165b <strlen+0xf>
		n++;
	return n;
  80166a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80166d:	c9                   	leave  
  80166e:	c3                   	ret    

0080166f <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80166f:	55                   	push   %ebp
  801670:	89 e5                	mov    %esp,%ebp
  801672:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801675:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80167c:	eb 09                	jmp    801687 <strnlen+0x18>
		n++;
  80167e:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801681:	ff 45 08             	incl   0x8(%ebp)
  801684:	ff 4d 0c             	decl   0xc(%ebp)
  801687:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80168b:	74 09                	je     801696 <strnlen+0x27>
  80168d:	8b 45 08             	mov    0x8(%ebp),%eax
  801690:	8a 00                	mov    (%eax),%al
  801692:	84 c0                	test   %al,%al
  801694:	75 e8                	jne    80167e <strnlen+0xf>
		n++;
	return n;
  801696:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801699:	c9                   	leave  
  80169a:	c3                   	ret    

0080169b <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80169b:	55                   	push   %ebp
  80169c:	89 e5                	mov    %esp,%ebp
  80169e:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8016a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8016a7:	90                   	nop
  8016a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ab:	8d 50 01             	lea    0x1(%eax),%edx
  8016ae:	89 55 08             	mov    %edx,0x8(%ebp)
  8016b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016b7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8016ba:	8a 12                	mov    (%edx),%dl
  8016bc:	88 10                	mov    %dl,(%eax)
  8016be:	8a 00                	mov    (%eax),%al
  8016c0:	84 c0                	test   %al,%al
  8016c2:	75 e4                	jne    8016a8 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8016c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8016c7:	c9                   	leave  
  8016c8:	c3                   	ret    

008016c9 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8016c9:	55                   	push   %ebp
  8016ca:	89 e5                	mov    %esp,%ebp
  8016cc:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8016cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8016d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8016dc:	eb 1f                	jmp    8016fd <strncpy+0x34>
		*dst++ = *src;
  8016de:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e1:	8d 50 01             	lea    0x1(%eax),%edx
  8016e4:	89 55 08             	mov    %edx,0x8(%ebp)
  8016e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ea:	8a 12                	mov    (%edx),%dl
  8016ec:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8016ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f1:	8a 00                	mov    (%eax),%al
  8016f3:	84 c0                	test   %al,%al
  8016f5:	74 03                	je     8016fa <strncpy+0x31>
			src++;
  8016f7:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8016fa:	ff 45 fc             	incl   -0x4(%ebp)
  8016fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801700:	3b 45 10             	cmp    0x10(%ebp),%eax
  801703:	72 d9                	jb     8016de <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801705:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801708:	c9                   	leave  
  801709:	c3                   	ret    

0080170a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80170a:	55                   	push   %ebp
  80170b:	89 e5                	mov    %esp,%ebp
  80170d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801710:	8b 45 08             	mov    0x8(%ebp),%eax
  801713:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801716:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80171a:	74 30                	je     80174c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80171c:	eb 16                	jmp    801734 <strlcpy+0x2a>
			*dst++ = *src++;
  80171e:	8b 45 08             	mov    0x8(%ebp),%eax
  801721:	8d 50 01             	lea    0x1(%eax),%edx
  801724:	89 55 08             	mov    %edx,0x8(%ebp)
  801727:	8b 55 0c             	mov    0xc(%ebp),%edx
  80172a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80172d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801730:	8a 12                	mov    (%edx),%dl
  801732:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801734:	ff 4d 10             	decl   0x10(%ebp)
  801737:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80173b:	74 09                	je     801746 <strlcpy+0x3c>
  80173d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801740:	8a 00                	mov    (%eax),%al
  801742:	84 c0                	test   %al,%al
  801744:	75 d8                	jne    80171e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801746:	8b 45 08             	mov    0x8(%ebp),%eax
  801749:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80174c:	8b 55 08             	mov    0x8(%ebp),%edx
  80174f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801752:	29 c2                	sub    %eax,%edx
  801754:	89 d0                	mov    %edx,%eax
}
  801756:	c9                   	leave  
  801757:	c3                   	ret    

00801758 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801758:	55                   	push   %ebp
  801759:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80175b:	eb 06                	jmp    801763 <strcmp+0xb>
		p++, q++;
  80175d:	ff 45 08             	incl   0x8(%ebp)
  801760:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801763:	8b 45 08             	mov    0x8(%ebp),%eax
  801766:	8a 00                	mov    (%eax),%al
  801768:	84 c0                	test   %al,%al
  80176a:	74 0e                	je     80177a <strcmp+0x22>
  80176c:	8b 45 08             	mov    0x8(%ebp),%eax
  80176f:	8a 10                	mov    (%eax),%dl
  801771:	8b 45 0c             	mov    0xc(%ebp),%eax
  801774:	8a 00                	mov    (%eax),%al
  801776:	38 c2                	cmp    %al,%dl
  801778:	74 e3                	je     80175d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80177a:	8b 45 08             	mov    0x8(%ebp),%eax
  80177d:	8a 00                	mov    (%eax),%al
  80177f:	0f b6 d0             	movzbl %al,%edx
  801782:	8b 45 0c             	mov    0xc(%ebp),%eax
  801785:	8a 00                	mov    (%eax),%al
  801787:	0f b6 c0             	movzbl %al,%eax
  80178a:	29 c2                	sub    %eax,%edx
  80178c:	89 d0                	mov    %edx,%eax
}
  80178e:	5d                   	pop    %ebp
  80178f:	c3                   	ret    

00801790 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801790:	55                   	push   %ebp
  801791:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801793:	eb 09                	jmp    80179e <strncmp+0xe>
		n--, p++, q++;
  801795:	ff 4d 10             	decl   0x10(%ebp)
  801798:	ff 45 08             	incl   0x8(%ebp)
  80179b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80179e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017a2:	74 17                	je     8017bb <strncmp+0x2b>
  8017a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a7:	8a 00                	mov    (%eax),%al
  8017a9:	84 c0                	test   %al,%al
  8017ab:	74 0e                	je     8017bb <strncmp+0x2b>
  8017ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b0:	8a 10                	mov    (%eax),%dl
  8017b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b5:	8a 00                	mov    (%eax),%al
  8017b7:	38 c2                	cmp    %al,%dl
  8017b9:	74 da                	je     801795 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8017bb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017bf:	75 07                	jne    8017c8 <strncmp+0x38>
		return 0;
  8017c1:	b8 00 00 00 00       	mov    $0x0,%eax
  8017c6:	eb 14                	jmp    8017dc <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8017c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cb:	8a 00                	mov    (%eax),%al
  8017cd:	0f b6 d0             	movzbl %al,%edx
  8017d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d3:	8a 00                	mov    (%eax),%al
  8017d5:	0f b6 c0             	movzbl %al,%eax
  8017d8:	29 c2                	sub    %eax,%edx
  8017da:	89 d0                	mov    %edx,%eax
}
  8017dc:	5d                   	pop    %ebp
  8017dd:	c3                   	ret    

008017de <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8017de:	55                   	push   %ebp
  8017df:	89 e5                	mov    %esp,%ebp
  8017e1:	83 ec 04             	sub    $0x4,%esp
  8017e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8017ea:	eb 12                	jmp    8017fe <strchr+0x20>
		if (*s == c)
  8017ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ef:	8a 00                	mov    (%eax),%al
  8017f1:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8017f4:	75 05                	jne    8017fb <strchr+0x1d>
			return (char *) s;
  8017f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f9:	eb 11                	jmp    80180c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8017fb:	ff 45 08             	incl   0x8(%ebp)
  8017fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801801:	8a 00                	mov    (%eax),%al
  801803:	84 c0                	test   %al,%al
  801805:	75 e5                	jne    8017ec <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801807:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80180c:	c9                   	leave  
  80180d:	c3                   	ret    

0080180e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80180e:	55                   	push   %ebp
  80180f:	89 e5                	mov    %esp,%ebp
  801811:	83 ec 04             	sub    $0x4,%esp
  801814:	8b 45 0c             	mov    0xc(%ebp),%eax
  801817:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80181a:	eb 0d                	jmp    801829 <strfind+0x1b>
		if (*s == c)
  80181c:	8b 45 08             	mov    0x8(%ebp),%eax
  80181f:	8a 00                	mov    (%eax),%al
  801821:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801824:	74 0e                	je     801834 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801826:	ff 45 08             	incl   0x8(%ebp)
  801829:	8b 45 08             	mov    0x8(%ebp),%eax
  80182c:	8a 00                	mov    (%eax),%al
  80182e:	84 c0                	test   %al,%al
  801830:	75 ea                	jne    80181c <strfind+0xe>
  801832:	eb 01                	jmp    801835 <strfind+0x27>
		if (*s == c)
			break;
  801834:	90                   	nop
	return (char *) s;
  801835:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801838:	c9                   	leave  
  801839:	c3                   	ret    

0080183a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80183a:	55                   	push   %ebp
  80183b:	89 e5                	mov    %esp,%ebp
  80183d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801840:	8b 45 08             	mov    0x8(%ebp),%eax
  801843:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801846:	8b 45 10             	mov    0x10(%ebp),%eax
  801849:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80184c:	eb 0e                	jmp    80185c <memset+0x22>
		*p++ = c;
  80184e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801851:	8d 50 01             	lea    0x1(%eax),%edx
  801854:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801857:	8b 55 0c             	mov    0xc(%ebp),%edx
  80185a:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80185c:	ff 4d f8             	decl   -0x8(%ebp)
  80185f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801863:	79 e9                	jns    80184e <memset+0x14>
		*p++ = c;

	return v;
  801865:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801868:	c9                   	leave  
  801869:	c3                   	ret    

0080186a <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80186a:	55                   	push   %ebp
  80186b:	89 e5                	mov    %esp,%ebp
  80186d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801870:	8b 45 0c             	mov    0xc(%ebp),%eax
  801873:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801876:	8b 45 08             	mov    0x8(%ebp),%eax
  801879:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80187c:	eb 16                	jmp    801894 <memcpy+0x2a>
		*d++ = *s++;
  80187e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801881:	8d 50 01             	lea    0x1(%eax),%edx
  801884:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801887:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80188a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80188d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801890:	8a 12                	mov    (%edx),%dl
  801892:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801894:	8b 45 10             	mov    0x10(%ebp),%eax
  801897:	8d 50 ff             	lea    -0x1(%eax),%edx
  80189a:	89 55 10             	mov    %edx,0x10(%ebp)
  80189d:	85 c0                	test   %eax,%eax
  80189f:	75 dd                	jne    80187e <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8018a1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8018a4:	c9                   	leave  
  8018a5:	c3                   	ret    

008018a6 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8018a6:	55                   	push   %ebp
  8018a7:	89 e5                	mov    %esp,%ebp
  8018a9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8018ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018af:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8018b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8018b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018bb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8018be:	73 50                	jae    801910 <memmove+0x6a>
  8018c0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8018c6:	01 d0                	add    %edx,%eax
  8018c8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8018cb:	76 43                	jbe    801910 <memmove+0x6a>
		s += n;
  8018cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8018d0:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8018d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8018d6:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8018d9:	eb 10                	jmp    8018eb <memmove+0x45>
			*--d = *--s;
  8018db:	ff 4d f8             	decl   -0x8(%ebp)
  8018de:	ff 4d fc             	decl   -0x4(%ebp)
  8018e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018e4:	8a 10                	mov    (%eax),%dl
  8018e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018e9:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8018eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ee:	8d 50 ff             	lea    -0x1(%eax),%edx
  8018f1:	89 55 10             	mov    %edx,0x10(%ebp)
  8018f4:	85 c0                	test   %eax,%eax
  8018f6:	75 e3                	jne    8018db <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8018f8:	eb 23                	jmp    80191d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8018fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018fd:	8d 50 01             	lea    0x1(%eax),%edx
  801900:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801903:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801906:	8d 4a 01             	lea    0x1(%edx),%ecx
  801909:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80190c:	8a 12                	mov    (%edx),%dl
  80190e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801910:	8b 45 10             	mov    0x10(%ebp),%eax
  801913:	8d 50 ff             	lea    -0x1(%eax),%edx
  801916:	89 55 10             	mov    %edx,0x10(%ebp)
  801919:	85 c0                	test   %eax,%eax
  80191b:	75 dd                	jne    8018fa <memmove+0x54>
			*d++ = *s++;

	return dst;
  80191d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801920:	c9                   	leave  
  801921:	c3                   	ret    

00801922 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801922:	55                   	push   %ebp
  801923:	89 e5                	mov    %esp,%ebp
  801925:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801928:	8b 45 08             	mov    0x8(%ebp),%eax
  80192b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80192e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801931:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801934:	eb 2a                	jmp    801960 <memcmp+0x3e>
		if (*s1 != *s2)
  801936:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801939:	8a 10                	mov    (%eax),%dl
  80193b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80193e:	8a 00                	mov    (%eax),%al
  801940:	38 c2                	cmp    %al,%dl
  801942:	74 16                	je     80195a <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801944:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801947:	8a 00                	mov    (%eax),%al
  801949:	0f b6 d0             	movzbl %al,%edx
  80194c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80194f:	8a 00                	mov    (%eax),%al
  801951:	0f b6 c0             	movzbl %al,%eax
  801954:	29 c2                	sub    %eax,%edx
  801956:	89 d0                	mov    %edx,%eax
  801958:	eb 18                	jmp    801972 <memcmp+0x50>
		s1++, s2++;
  80195a:	ff 45 fc             	incl   -0x4(%ebp)
  80195d:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801960:	8b 45 10             	mov    0x10(%ebp),%eax
  801963:	8d 50 ff             	lea    -0x1(%eax),%edx
  801966:	89 55 10             	mov    %edx,0x10(%ebp)
  801969:	85 c0                	test   %eax,%eax
  80196b:	75 c9                	jne    801936 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80196d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801972:	c9                   	leave  
  801973:	c3                   	ret    

00801974 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801974:	55                   	push   %ebp
  801975:	89 e5                	mov    %esp,%ebp
  801977:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80197a:	8b 55 08             	mov    0x8(%ebp),%edx
  80197d:	8b 45 10             	mov    0x10(%ebp),%eax
  801980:	01 d0                	add    %edx,%eax
  801982:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801985:	eb 15                	jmp    80199c <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801987:	8b 45 08             	mov    0x8(%ebp),%eax
  80198a:	8a 00                	mov    (%eax),%al
  80198c:	0f b6 d0             	movzbl %al,%edx
  80198f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801992:	0f b6 c0             	movzbl %al,%eax
  801995:	39 c2                	cmp    %eax,%edx
  801997:	74 0d                	je     8019a6 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801999:	ff 45 08             	incl   0x8(%ebp)
  80199c:	8b 45 08             	mov    0x8(%ebp),%eax
  80199f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8019a2:	72 e3                	jb     801987 <memfind+0x13>
  8019a4:	eb 01                	jmp    8019a7 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8019a6:	90                   	nop
	return (void *) s;
  8019a7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8019aa:	c9                   	leave  
  8019ab:	c3                   	ret    

008019ac <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8019ac:	55                   	push   %ebp
  8019ad:	89 e5                	mov    %esp,%ebp
  8019af:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8019b2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8019b9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8019c0:	eb 03                	jmp    8019c5 <strtol+0x19>
		s++;
  8019c2:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8019c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c8:	8a 00                	mov    (%eax),%al
  8019ca:	3c 20                	cmp    $0x20,%al
  8019cc:	74 f4                	je     8019c2 <strtol+0x16>
  8019ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d1:	8a 00                	mov    (%eax),%al
  8019d3:	3c 09                	cmp    $0x9,%al
  8019d5:	74 eb                	je     8019c2 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8019d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019da:	8a 00                	mov    (%eax),%al
  8019dc:	3c 2b                	cmp    $0x2b,%al
  8019de:	75 05                	jne    8019e5 <strtol+0x39>
		s++;
  8019e0:	ff 45 08             	incl   0x8(%ebp)
  8019e3:	eb 13                	jmp    8019f8 <strtol+0x4c>
	else if (*s == '-')
  8019e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e8:	8a 00                	mov    (%eax),%al
  8019ea:	3c 2d                	cmp    $0x2d,%al
  8019ec:	75 0a                	jne    8019f8 <strtol+0x4c>
		s++, neg = 1;
  8019ee:	ff 45 08             	incl   0x8(%ebp)
  8019f1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8019f8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019fc:	74 06                	je     801a04 <strtol+0x58>
  8019fe:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801a02:	75 20                	jne    801a24 <strtol+0x78>
  801a04:	8b 45 08             	mov    0x8(%ebp),%eax
  801a07:	8a 00                	mov    (%eax),%al
  801a09:	3c 30                	cmp    $0x30,%al
  801a0b:	75 17                	jne    801a24 <strtol+0x78>
  801a0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a10:	40                   	inc    %eax
  801a11:	8a 00                	mov    (%eax),%al
  801a13:	3c 78                	cmp    $0x78,%al
  801a15:	75 0d                	jne    801a24 <strtol+0x78>
		s += 2, base = 16;
  801a17:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801a1b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801a22:	eb 28                	jmp    801a4c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801a24:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a28:	75 15                	jne    801a3f <strtol+0x93>
  801a2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2d:	8a 00                	mov    (%eax),%al
  801a2f:	3c 30                	cmp    $0x30,%al
  801a31:	75 0c                	jne    801a3f <strtol+0x93>
		s++, base = 8;
  801a33:	ff 45 08             	incl   0x8(%ebp)
  801a36:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801a3d:	eb 0d                	jmp    801a4c <strtol+0xa0>
	else if (base == 0)
  801a3f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a43:	75 07                	jne    801a4c <strtol+0xa0>
		base = 10;
  801a45:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801a4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4f:	8a 00                	mov    (%eax),%al
  801a51:	3c 2f                	cmp    $0x2f,%al
  801a53:	7e 19                	jle    801a6e <strtol+0xc2>
  801a55:	8b 45 08             	mov    0x8(%ebp),%eax
  801a58:	8a 00                	mov    (%eax),%al
  801a5a:	3c 39                	cmp    $0x39,%al
  801a5c:	7f 10                	jg     801a6e <strtol+0xc2>
			dig = *s - '0';
  801a5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a61:	8a 00                	mov    (%eax),%al
  801a63:	0f be c0             	movsbl %al,%eax
  801a66:	83 e8 30             	sub    $0x30,%eax
  801a69:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801a6c:	eb 42                	jmp    801ab0 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801a6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a71:	8a 00                	mov    (%eax),%al
  801a73:	3c 60                	cmp    $0x60,%al
  801a75:	7e 19                	jle    801a90 <strtol+0xe4>
  801a77:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7a:	8a 00                	mov    (%eax),%al
  801a7c:	3c 7a                	cmp    $0x7a,%al
  801a7e:	7f 10                	jg     801a90 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801a80:	8b 45 08             	mov    0x8(%ebp),%eax
  801a83:	8a 00                	mov    (%eax),%al
  801a85:	0f be c0             	movsbl %al,%eax
  801a88:	83 e8 57             	sub    $0x57,%eax
  801a8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801a8e:	eb 20                	jmp    801ab0 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801a90:	8b 45 08             	mov    0x8(%ebp),%eax
  801a93:	8a 00                	mov    (%eax),%al
  801a95:	3c 40                	cmp    $0x40,%al
  801a97:	7e 39                	jle    801ad2 <strtol+0x126>
  801a99:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9c:	8a 00                	mov    (%eax),%al
  801a9e:	3c 5a                	cmp    $0x5a,%al
  801aa0:	7f 30                	jg     801ad2 <strtol+0x126>
			dig = *s - 'A' + 10;
  801aa2:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa5:	8a 00                	mov    (%eax),%al
  801aa7:	0f be c0             	movsbl %al,%eax
  801aaa:	83 e8 37             	sub    $0x37,%eax
  801aad:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801ab0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ab3:	3b 45 10             	cmp    0x10(%ebp),%eax
  801ab6:	7d 19                	jge    801ad1 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801ab8:	ff 45 08             	incl   0x8(%ebp)
  801abb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801abe:	0f af 45 10          	imul   0x10(%ebp),%eax
  801ac2:	89 c2                	mov    %eax,%edx
  801ac4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ac7:	01 d0                	add    %edx,%eax
  801ac9:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801acc:	e9 7b ff ff ff       	jmp    801a4c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801ad1:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801ad2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801ad6:	74 08                	je     801ae0 <strtol+0x134>
		*endptr = (char *) s;
  801ad8:	8b 45 0c             	mov    0xc(%ebp),%eax
  801adb:	8b 55 08             	mov    0x8(%ebp),%edx
  801ade:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801ae0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801ae4:	74 07                	je     801aed <strtol+0x141>
  801ae6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ae9:	f7 d8                	neg    %eax
  801aeb:	eb 03                	jmp    801af0 <strtol+0x144>
  801aed:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801af0:	c9                   	leave  
  801af1:	c3                   	ret    

00801af2 <ltostr>:

void
ltostr(long value, char *str)
{
  801af2:	55                   	push   %ebp
  801af3:	89 e5                	mov    %esp,%ebp
  801af5:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801af8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801aff:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801b06:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801b0a:	79 13                	jns    801b1f <ltostr+0x2d>
	{
		neg = 1;
  801b0c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801b13:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b16:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801b19:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801b1c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b22:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801b27:	99                   	cltd   
  801b28:	f7 f9                	idiv   %ecx
  801b2a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801b2d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b30:	8d 50 01             	lea    0x1(%eax),%edx
  801b33:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801b36:	89 c2                	mov    %eax,%edx
  801b38:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b3b:	01 d0                	add    %edx,%eax
  801b3d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b40:	83 c2 30             	add    $0x30,%edx
  801b43:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801b45:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b48:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801b4d:	f7 e9                	imul   %ecx
  801b4f:	c1 fa 02             	sar    $0x2,%edx
  801b52:	89 c8                	mov    %ecx,%eax
  801b54:	c1 f8 1f             	sar    $0x1f,%eax
  801b57:	29 c2                	sub    %eax,%edx
  801b59:	89 d0                	mov    %edx,%eax
  801b5b:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801b5e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b61:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801b66:	f7 e9                	imul   %ecx
  801b68:	c1 fa 02             	sar    $0x2,%edx
  801b6b:	89 c8                	mov    %ecx,%eax
  801b6d:	c1 f8 1f             	sar    $0x1f,%eax
  801b70:	29 c2                	sub    %eax,%edx
  801b72:	89 d0                	mov    %edx,%eax
  801b74:	c1 e0 02             	shl    $0x2,%eax
  801b77:	01 d0                	add    %edx,%eax
  801b79:	01 c0                	add    %eax,%eax
  801b7b:	29 c1                	sub    %eax,%ecx
  801b7d:	89 ca                	mov    %ecx,%edx
  801b7f:	85 d2                	test   %edx,%edx
  801b81:	75 9c                	jne    801b1f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801b83:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801b8a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b8d:	48                   	dec    %eax
  801b8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801b91:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801b95:	74 3d                	je     801bd4 <ltostr+0xe2>
		start = 1 ;
  801b97:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801b9e:	eb 34                	jmp    801bd4 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801ba0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801ba3:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ba6:	01 d0                	add    %edx,%eax
  801ba8:	8a 00                	mov    (%eax),%al
  801baa:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801bad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801bb0:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bb3:	01 c2                	add    %eax,%edx
  801bb5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801bb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bbb:	01 c8                	add    %ecx,%eax
  801bbd:	8a 00                	mov    (%eax),%al
  801bbf:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801bc1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801bc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bc7:	01 c2                	add    %eax,%edx
  801bc9:	8a 45 eb             	mov    -0x15(%ebp),%al
  801bcc:	88 02                	mov    %al,(%edx)
		start++ ;
  801bce:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801bd1:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801bd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bd7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801bda:	7c c4                	jl     801ba0 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801bdc:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801bdf:	8b 45 0c             	mov    0xc(%ebp),%eax
  801be2:	01 d0                	add    %edx,%eax
  801be4:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801be7:	90                   	nop
  801be8:	c9                   	leave  
  801be9:	c3                   	ret    

00801bea <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801bea:	55                   	push   %ebp
  801beb:	89 e5                	mov    %esp,%ebp
  801bed:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801bf0:	ff 75 08             	pushl  0x8(%ebp)
  801bf3:	e8 54 fa ff ff       	call   80164c <strlen>
  801bf8:	83 c4 04             	add    $0x4,%esp
  801bfb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801bfe:	ff 75 0c             	pushl  0xc(%ebp)
  801c01:	e8 46 fa ff ff       	call   80164c <strlen>
  801c06:	83 c4 04             	add    $0x4,%esp
  801c09:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801c0c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801c13:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801c1a:	eb 17                	jmp    801c33 <strcconcat+0x49>
		final[s] = str1[s] ;
  801c1c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c1f:	8b 45 10             	mov    0x10(%ebp),%eax
  801c22:	01 c2                	add    %eax,%edx
  801c24:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801c27:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2a:	01 c8                	add    %ecx,%eax
  801c2c:	8a 00                	mov    (%eax),%al
  801c2e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801c30:	ff 45 fc             	incl   -0x4(%ebp)
  801c33:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c36:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801c39:	7c e1                	jl     801c1c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801c3b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801c42:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801c49:	eb 1f                	jmp    801c6a <strcconcat+0x80>
		final[s++] = str2[i] ;
  801c4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c4e:	8d 50 01             	lea    0x1(%eax),%edx
  801c51:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801c54:	89 c2                	mov    %eax,%edx
  801c56:	8b 45 10             	mov    0x10(%ebp),%eax
  801c59:	01 c2                	add    %eax,%edx
  801c5b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801c5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c61:	01 c8                	add    %ecx,%eax
  801c63:	8a 00                	mov    (%eax),%al
  801c65:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801c67:	ff 45 f8             	incl   -0x8(%ebp)
  801c6a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c6d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c70:	7c d9                	jl     801c4b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801c72:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c75:	8b 45 10             	mov    0x10(%ebp),%eax
  801c78:	01 d0                	add    %edx,%eax
  801c7a:	c6 00 00             	movb   $0x0,(%eax)
}
  801c7d:	90                   	nop
  801c7e:	c9                   	leave  
  801c7f:	c3                   	ret    

00801c80 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801c80:	55                   	push   %ebp
  801c81:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801c83:	8b 45 14             	mov    0x14(%ebp),%eax
  801c86:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801c8c:	8b 45 14             	mov    0x14(%ebp),%eax
  801c8f:	8b 00                	mov    (%eax),%eax
  801c91:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c98:	8b 45 10             	mov    0x10(%ebp),%eax
  801c9b:	01 d0                	add    %edx,%eax
  801c9d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801ca3:	eb 0c                	jmp    801cb1 <strsplit+0x31>
			*string++ = 0;
  801ca5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca8:	8d 50 01             	lea    0x1(%eax),%edx
  801cab:	89 55 08             	mov    %edx,0x8(%ebp)
  801cae:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801cb1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb4:	8a 00                	mov    (%eax),%al
  801cb6:	84 c0                	test   %al,%al
  801cb8:	74 18                	je     801cd2 <strsplit+0x52>
  801cba:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbd:	8a 00                	mov    (%eax),%al
  801cbf:	0f be c0             	movsbl %al,%eax
  801cc2:	50                   	push   %eax
  801cc3:	ff 75 0c             	pushl  0xc(%ebp)
  801cc6:	e8 13 fb ff ff       	call   8017de <strchr>
  801ccb:	83 c4 08             	add    $0x8,%esp
  801cce:	85 c0                	test   %eax,%eax
  801cd0:	75 d3                	jne    801ca5 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801cd2:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd5:	8a 00                	mov    (%eax),%al
  801cd7:	84 c0                	test   %al,%al
  801cd9:	74 5a                	je     801d35 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801cdb:	8b 45 14             	mov    0x14(%ebp),%eax
  801cde:	8b 00                	mov    (%eax),%eax
  801ce0:	83 f8 0f             	cmp    $0xf,%eax
  801ce3:	75 07                	jne    801cec <strsplit+0x6c>
		{
			return 0;
  801ce5:	b8 00 00 00 00       	mov    $0x0,%eax
  801cea:	eb 66                	jmp    801d52 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801cec:	8b 45 14             	mov    0x14(%ebp),%eax
  801cef:	8b 00                	mov    (%eax),%eax
  801cf1:	8d 48 01             	lea    0x1(%eax),%ecx
  801cf4:	8b 55 14             	mov    0x14(%ebp),%edx
  801cf7:	89 0a                	mov    %ecx,(%edx)
  801cf9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d00:	8b 45 10             	mov    0x10(%ebp),%eax
  801d03:	01 c2                	add    %eax,%edx
  801d05:	8b 45 08             	mov    0x8(%ebp),%eax
  801d08:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801d0a:	eb 03                	jmp    801d0f <strsplit+0x8f>
			string++;
  801d0c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801d0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d12:	8a 00                	mov    (%eax),%al
  801d14:	84 c0                	test   %al,%al
  801d16:	74 8b                	je     801ca3 <strsplit+0x23>
  801d18:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1b:	8a 00                	mov    (%eax),%al
  801d1d:	0f be c0             	movsbl %al,%eax
  801d20:	50                   	push   %eax
  801d21:	ff 75 0c             	pushl  0xc(%ebp)
  801d24:	e8 b5 fa ff ff       	call   8017de <strchr>
  801d29:	83 c4 08             	add    $0x8,%esp
  801d2c:	85 c0                	test   %eax,%eax
  801d2e:	74 dc                	je     801d0c <strsplit+0x8c>
			string++;
	}
  801d30:	e9 6e ff ff ff       	jmp    801ca3 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801d35:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801d36:	8b 45 14             	mov    0x14(%ebp),%eax
  801d39:	8b 00                	mov    (%eax),%eax
  801d3b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d42:	8b 45 10             	mov    0x10(%ebp),%eax
  801d45:	01 d0                	add    %edx,%eax
  801d47:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801d4d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801d52:	c9                   	leave  
  801d53:	c3                   	ret    

00801d54 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801d54:	55                   	push   %ebp
  801d55:	89 e5                	mov    %esp,%ebp
  801d57:	83 ec 58             	sub    $0x58,%esp
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){
  801d5a:	e8 3b 09 00 00       	call   80269a <sys_isUHeapPlacementStrategyFIRSTFIT>
  801d5f:	85 c0                	test   %eax,%eax
  801d61:	0f 84 3a 01 00 00    	je     801ea1 <malloc+0x14d>

		if(pl == 0){
  801d67:	a1 28 40 80 00       	mov    0x804028,%eax
  801d6c:	85 c0                	test   %eax,%eax
  801d6e:	75 24                	jne    801d94 <malloc+0x40>
			for(int k = 0; k < Size; k++){
  801d70:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  801d77:	eb 11                	jmp    801d8a <malloc+0x36>
				arr[k] = -10000;
  801d79:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d7c:	c7 04 85 20 41 80 00 	movl   $0xffffd8f0,0x804120(,%eax,4)
  801d83:	f0 d8 ff ff 
void* malloc(uint32 size)
{
	if(sys_isUHeapPlacementStrategyFIRSTFIT()){

		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801d87:	ff 45 f4             	incl   -0xc(%ebp)
  801d8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d8d:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801d92:	76 e5                	jbe    801d79 <malloc+0x25>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801d94:	c7 05 28 40 80 00 01 	movl   $0x1,0x804028
  801d9b:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801d9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801da1:	c1 e8 0c             	shr    $0xc,%eax
  801da4:	89 45 f0             	mov    %eax,-0x10(%ebp)
		if(size % PAGE_SIZE != 0){
  801da7:	8b 45 08             	mov    0x8(%ebp),%eax
  801daa:	25 ff 0f 00 00       	and    $0xfff,%eax
  801daf:	85 c0                	test   %eax,%eax
  801db1:	74 03                	je     801db6 <malloc+0x62>
			x++;
  801db3:	ff 45 f0             	incl   -0x10(%ebp)
		}
		bool p = 0;
  801db6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		uint32 idx = -1;
  801dbd:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801dc4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  801dcb:	eb 66                	jmp    801e33 <malloc+0xdf>
			if( arr[k] == -10000){
  801dcd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801dd0:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801dd7:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801ddc:	75 52                	jne    801e30 <malloc+0xdc>
				uint32 w = 0 ;
  801dde:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				idx = k ;
  801de5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801de8:	89 45 e8             	mov    %eax,-0x18(%ebp)
				for(int i=k ; i < Size && arr[i] == -10000 && w < x; i++, k++) w++ ;
  801deb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801dee:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801df1:	eb 09                	jmp    801dfc <malloc+0xa8>
  801df3:	ff 45 e0             	incl   -0x20(%ebp)
  801df6:	ff 45 dc             	incl   -0x24(%ebp)
  801df9:	ff 45 e4             	incl   -0x1c(%ebp)
  801dfc:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801dff:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801e04:	77 19                	ja     801e1f <malloc+0xcb>
  801e06:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801e09:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801e10:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801e15:	75 08                	jne    801e1f <malloc+0xcb>
  801e17:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e1a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801e1d:	72 d4                	jb     801df3 <malloc+0x9f>
				if(w >= x){
  801e1f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e22:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801e25:	72 09                	jb     801e30 <malloc+0xdc>
					p = 1 ;
  801e27:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break ;
  801e2e:	eb 0d                	jmp    801e3d <malloc+0xe9>
			x++;
		}
		bool p = 0;
		uint32 idx = -1;
		uint32 va ;
		for(int k=0 ; k < Size ; k++){
  801e30:	ff 45 e4             	incl   -0x1c(%ebp)
  801e33:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801e36:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801e3b:	76 90                	jbe    801dcd <malloc+0x79>
					break ;
				}
			}
		}

		if(p == 0) return NULL;
  801e3d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801e41:	75 0a                	jne    801e4d <malloc+0xf9>
  801e43:	b8 00 00 00 00       	mov    $0x0,%eax
  801e48:	e9 ca 01 00 00       	jmp    802017 <malloc+0x2c3>
		int q = idx;
  801e4d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801e50:	89 45 d8             	mov    %eax,-0x28(%ebp)
		for(int f = 0 ; f<x ; f++){
  801e53:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801e5a:	eb 16                	jmp    801e72 <malloc+0x11e>
			arr[q++] = x;
  801e5c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801e5f:	8d 50 01             	lea    0x1(%eax),%edx
  801e62:	89 55 d8             	mov    %edx,-0x28(%ebp)
  801e65:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801e68:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
			}
		}

		if(p == 0) return NULL;
		int q = idx;
		for(int f = 0 ; f<x ; f++){
  801e6f:	ff 45 d4             	incl   -0x2c(%ebp)
  801e72:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801e75:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801e78:	72 e2                	jb     801e5c <malloc+0x108>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801e7a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801e7d:	05 00 00 08 00       	add    $0x80000,%eax
  801e82:	c1 e0 0c             	shl    $0xc,%eax
  801e85:	89 45 ac             	mov    %eax,-0x54(%ebp)
		sys_allocateMem(va, x);
  801e88:	83 ec 08             	sub    $0x8,%esp
  801e8b:	ff 75 f0             	pushl  -0x10(%ebp)
  801e8e:	ff 75 ac             	pushl  -0x54(%ebp)
  801e91:	e8 9b 04 00 00       	call   802331 <sys_allocateMem>
  801e96:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  801e99:	8b 45 ac             	mov    -0x54(%ebp),%eax
  801e9c:	e9 76 01 00 00       	jmp    802017 <malloc+0x2c3>

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
  801ea1:	e8 25 08 00 00       	call   8026cb <sys_isUHeapPlacementStrategyBESTFIT>
  801ea6:	85 c0                	test   %eax,%eax
  801ea8:	0f 84 64 01 00 00    	je     802012 <malloc+0x2be>
		if(pl == 0){
  801eae:	a1 28 40 80 00       	mov    0x804028,%eax
  801eb3:	85 c0                	test   %eax,%eax
  801eb5:	75 24                	jne    801edb <malloc+0x187>
			for(int k = 0; k < Size; k++){
  801eb7:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  801ebe:	eb 11                	jmp    801ed1 <malloc+0x17d>
				arr[k] = -10000;
  801ec0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ec3:	c7 04 85 20 41 80 00 	movl   $0xffffd8f0,0x804120(,%eax,4)
  801eca:	f0 d8 ff ff 

	}

	else if(sys_isUHeapPlacementStrategyBESTFIT()){
		if(pl == 0){
			for(int k = 0; k < Size; k++){
  801ece:	ff 45 d0             	incl   -0x30(%ebp)
  801ed1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ed4:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801ed9:	76 e5                	jbe    801ec0 <malloc+0x16c>
				arr[k] = -10000;
			}
		}
		pl = 1;
  801edb:	c7 05 28 40 80 00 01 	movl   $0x1,0x804028
  801ee2:	00 00 00 
		uint32 x = size / PAGE_SIZE;
  801ee5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee8:	c1 e8 0c             	shr    $0xc,%eax
  801eeb:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(size % PAGE_SIZE != 0){
  801eee:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef1:	25 ff 0f 00 00       	and    $0xfff,%eax
  801ef6:	85 c0                	test   %eax,%eax
  801ef8:	74 03                	je     801efd <malloc+0x1a9>
			x++;
  801efa:	ff 45 cc             	incl   -0x34(%ebp)
		}
		uint32 q = Size + 1,va;
  801efd:	c7 45 c8 01 00 02 00 	movl   $0x20001,-0x38(%ebp)
		bool p = 0;
  801f04:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
		uint32 idx = -1;
  801f0b:	c7 45 c0 ff ff ff ff 	movl   $0xffffffff,-0x40(%ebp)
		for(int k = 0 ; k < Size ; k++){
  801f12:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  801f19:	e9 88 00 00 00       	jmp    801fa6 <malloc+0x252>
			if(arr[k] == -10000){
  801f1e:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801f21:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801f28:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801f2d:	75 64                	jne    801f93 <malloc+0x23f>
				uint32 w = 0 , i;
  801f2f:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
				for( i=k ; i < Size && arr[i] == -10000; i++) w++;
  801f36:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801f39:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  801f3c:	eb 06                	jmp    801f44 <malloc+0x1f0>
  801f3e:	ff 45 b8             	incl   -0x48(%ebp)
  801f41:	ff 45 b4             	incl   -0x4c(%ebp)
  801f44:	81 7d b4 ff ff 01 00 	cmpl   $0x1ffff,-0x4c(%ebp)
  801f4b:	77 11                	ja     801f5e <malloc+0x20a>
  801f4d:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801f50:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801f57:	3d f0 d8 ff ff       	cmp    $0xffffd8f0,%eax
  801f5c:	74 e0                	je     801f3e <malloc+0x1ea>
				if(w <q && w >= x){
  801f5e:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801f61:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  801f64:	73 24                	jae    801f8a <malloc+0x236>
  801f66:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801f69:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801f6c:	72 1c                	jb     801f8a <malloc+0x236>
					q = w;  p = 1;idx = k; k = i - 1;
  801f6e:	8b 45 b8             	mov    -0x48(%ebp),%eax
  801f71:	89 45 c8             	mov    %eax,-0x38(%ebp)
  801f74:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  801f7b:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801f7e:	89 45 c0             	mov    %eax,-0x40(%ebp)
  801f81:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801f84:	48                   	dec    %eax
  801f85:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801f88:	eb 19                	jmp    801fa3 <malloc+0x24f>
				}
				else {
					k = i - 1;
  801f8a:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801f8d:	48                   	dec    %eax
  801f8e:	89 45 bc             	mov    %eax,-0x44(%ebp)
  801f91:	eb 10                	jmp    801fa3 <malloc+0x24f>
				}
			} else {
				k += arr[k];
  801f93:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801f96:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801f9d:	01 45 bc             	add    %eax,-0x44(%ebp)
				k--;
  801fa0:	ff 4d bc             	decl   -0x44(%ebp)
			x++;
		}
		uint32 q = Size + 1,va;
		bool p = 0;
		uint32 idx = -1;
		for(int k = 0 ; k < Size ; k++){
  801fa3:	ff 45 bc             	incl   -0x44(%ebp)
  801fa6:	8b 45 bc             	mov    -0x44(%ebp),%eax
  801fa9:	3d ff ff 01 00       	cmp    $0x1ffff,%eax
  801fae:	0f 86 6a ff ff ff    	jbe    801f1e <malloc+0x1ca>
			} else {
				k += arr[k];
				k--;
			}
		}
		if(p == 0) return NULL;
  801fb4:	83 7d c4 00          	cmpl   $0x0,-0x3c(%ebp)
  801fb8:	75 07                	jne    801fc1 <malloc+0x26d>
  801fba:	b8 00 00 00 00       	mov    $0x0,%eax
  801fbf:	eb 56                	jmp    802017 <malloc+0x2c3>
	    q = idx;
  801fc1:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801fc4:	89 45 c8             	mov    %eax,-0x38(%ebp)
		for(int f = 0 ; f<x ; f++){
  801fc7:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
  801fce:	eb 16                	jmp    801fe6 <malloc+0x292>
			arr[q++] = x;
  801fd0:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801fd3:	8d 50 01             	lea    0x1(%eax),%edx
  801fd6:	89 55 c8             	mov    %edx,-0x38(%ebp)
  801fd9:	8b 55 cc             	mov    -0x34(%ebp),%edx
  801fdc:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				k--;
			}
		}
		if(p == 0) return NULL;
	    q = idx;
		for(int f = 0 ; f<x ; f++){
  801fe3:	ff 45 b0             	incl   -0x50(%ebp)
  801fe6:	8b 45 b0             	mov    -0x50(%ebp),%eax
  801fe9:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  801fec:	72 e2                	jb     801fd0 <malloc+0x27c>
			arr[q++] = x;
		}
		va = (PAGE_SIZE * idx) + USER_HEAP_START;
  801fee:	8b 45 c0             	mov    -0x40(%ebp),%eax
  801ff1:	05 00 00 08 00       	add    $0x80000,%eax
  801ff6:	c1 e0 0c             	shl    $0xc,%eax
  801ff9:	89 45 a8             	mov    %eax,-0x58(%ebp)
		sys_allocateMem(va, x);
  801ffc:	83 ec 08             	sub    $0x8,%esp
  801fff:	ff 75 cc             	pushl  -0x34(%ebp)
  802002:	ff 75 a8             	pushl  -0x58(%ebp)
  802005:	e8 27 03 00 00       	call   802331 <sys_allocateMem>
  80200a:	83 c4 10             	add    $0x10,%esp
		return (void *)va;
  80200d:	8b 45 a8             	mov    -0x58(%ebp),%eax
  802010:	eb 05                	jmp    802017 <malloc+0x2c3>
	//This function should find the space of the required range by either:
	//1) FIRST FIT strategy
	//2) BEST FIT strategy


	return NULL;
  802012:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802017:	c9                   	leave  
  802018:	c3                   	ret    

00802019 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  802019:	55                   	push   %ebp
  80201a:	89 e5                	mov    %esp,%ebp
  80201c:	83 ec 18             	sub    $0x18,%esp
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
  80201f:	8b 45 08             	mov    0x8(%ebp),%eax
  802022:	89 45 ec             	mov    %eax,-0x14(%ebp)
  802025:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802028:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80202d:	89 45 08             	mov    %eax,0x8(%ebp)
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
  802030:	8b 45 08             	mov    0x8(%ebp),%eax
  802033:	05 00 00 00 80       	add    $0x80000000,%eax
  802038:	c1 e8 0c             	shr    $0xc,%eax
  80203b:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802042:	89 45 e8             	mov    %eax,-0x18(%ebp)
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  802045:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80204c:	8b 45 08             	mov    0x8(%ebp),%eax
  80204f:	05 00 00 00 80       	add    $0x80000000,%eax
  802054:	c1 e8 0c             	shr    $0xc,%eax
  802057:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80205a:	eb 14                	jmp    802070 <free+0x57>
		arr[j] = -10000;
  80205c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80205f:	c7 04 85 20 41 80 00 	movl   $0xffffd8f0,0x804120(,%eax,4)
  802066:	f0 d8 ff ff 
{
	//TODO: [FINAL_EVAL_2020 - VER_C] - [2] USER HEAP [User Side free]
	// Write your code here, remove the panic and write your code
	virtual_address = ROUNDDOWN(virtual_address , PAGE_SIZE);
	uint32 a = arr[((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE];
	for(int i=0, j = ((uint32)virtual_address - USER_HEAP_START) / PAGE_SIZE ; i<a ; i++, j++){
  80206a:	ff 45 f4             	incl   -0xc(%ebp)
  80206d:	ff 45 f0             	incl   -0x10(%ebp)
  802070:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802073:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  802076:	72 e4                	jb     80205c <free+0x43>
		arr[j] = -10000;
	}
	sys_freeMem((uint32)virtual_address, a);
  802078:	8b 45 08             	mov    0x8(%ebp),%eax
  80207b:	83 ec 08             	sub    $0x8,%esp
  80207e:	ff 75 e8             	pushl  -0x18(%ebp)
  802081:	50                   	push   %eax
  802082:	e8 8e 02 00 00       	call   802315 <sys_freeMem>
  802087:	83 c4 10             	add    $0x10,%esp
	//you should get the size of the given allocation using its address

	//refer to the documentation for details
}
  80208a:	90                   	nop
  80208b:	c9                   	leave  
  80208c:	c3                   	ret    

0080208d <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  80208d:	55                   	push   %ebp
  80208e:	89 e5                	mov    %esp,%ebp
  802090:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802093:	83 ec 04             	sub    $0x4,%esp
  802096:	68 b0 30 80 00       	push   $0x8030b0
  80209b:	68 9e 00 00 00       	push   $0x9e
  8020a0:	68 d3 30 80 00       	push   $0x8030d3
  8020a5:	e8 69 ec ff ff       	call   800d13 <_panic>

008020aa <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8020aa:	55                   	push   %ebp
  8020ab:	89 e5                	mov    %esp,%ebp
  8020ad:	83 ec 18             	sub    $0x18,%esp
  8020b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8020b3:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8020b6:	83 ec 04             	sub    $0x4,%esp
  8020b9:	68 b0 30 80 00       	push   $0x8030b0
  8020be:	68 a9 00 00 00       	push   $0xa9
  8020c3:	68 d3 30 80 00       	push   $0x8030d3
  8020c8:	e8 46 ec ff ff       	call   800d13 <_panic>

008020cd <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8020cd:	55                   	push   %ebp
  8020ce:	89 e5                	mov    %esp,%ebp
  8020d0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8020d3:	83 ec 04             	sub    $0x4,%esp
  8020d6:	68 b0 30 80 00       	push   $0x8030b0
  8020db:	68 af 00 00 00       	push   $0xaf
  8020e0:	68 d3 30 80 00       	push   $0x8030d3
  8020e5:	e8 29 ec ff ff       	call   800d13 <_panic>

008020ea <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8020ea:	55                   	push   %ebp
  8020eb:	89 e5                	mov    %esp,%ebp
  8020ed:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8020f0:	83 ec 04             	sub    $0x4,%esp
  8020f3:	68 b0 30 80 00       	push   $0x8030b0
  8020f8:	68 b5 00 00 00       	push   $0xb5
  8020fd:	68 d3 30 80 00       	push   $0x8030d3
  802102:	e8 0c ec ff ff       	call   800d13 <_panic>

00802107 <expand>:
}

void expand(uint32 newSize)
{
  802107:	55                   	push   %ebp
  802108:	89 e5                	mov    %esp,%ebp
  80210a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80210d:	83 ec 04             	sub    $0x4,%esp
  802110:	68 b0 30 80 00       	push   $0x8030b0
  802115:	68 ba 00 00 00       	push   $0xba
  80211a:	68 d3 30 80 00       	push   $0x8030d3
  80211f:	e8 ef eb ff ff       	call   800d13 <_panic>

00802124 <shrink>:
}
void shrink(uint32 newSize)
{
  802124:	55                   	push   %ebp
  802125:	89 e5                	mov    %esp,%ebp
  802127:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80212a:	83 ec 04             	sub    $0x4,%esp
  80212d:	68 b0 30 80 00       	push   $0x8030b0
  802132:	68 be 00 00 00       	push   $0xbe
  802137:	68 d3 30 80 00       	push   $0x8030d3
  80213c:	e8 d2 eb ff ff       	call   800d13 <_panic>

00802141 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  802141:	55                   	push   %ebp
  802142:	89 e5                	mov    %esp,%ebp
  802144:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802147:	83 ec 04             	sub    $0x4,%esp
  80214a:	68 b0 30 80 00       	push   $0x8030b0
  80214f:	68 c3 00 00 00       	push   $0xc3
  802154:	68 d3 30 80 00       	push   $0x8030d3
  802159:	e8 b5 eb ff ff       	call   800d13 <_panic>

0080215e <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80215e:	55                   	push   %ebp
  80215f:	89 e5                	mov    %esp,%ebp
  802161:	57                   	push   %edi
  802162:	56                   	push   %esi
  802163:	53                   	push   %ebx
  802164:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802167:	8b 45 08             	mov    0x8(%ebp),%eax
  80216a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80216d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802170:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802173:	8b 7d 18             	mov    0x18(%ebp),%edi
  802176:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802179:	cd 30                	int    $0x30
  80217b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80217e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802181:	83 c4 10             	add    $0x10,%esp
  802184:	5b                   	pop    %ebx
  802185:	5e                   	pop    %esi
  802186:	5f                   	pop    %edi
  802187:	5d                   	pop    %ebp
  802188:	c3                   	ret    

00802189 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802189:	55                   	push   %ebp
  80218a:	89 e5                	mov    %esp,%ebp
  80218c:	83 ec 04             	sub    $0x4,%esp
  80218f:	8b 45 10             	mov    0x10(%ebp),%eax
  802192:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802195:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802199:	8b 45 08             	mov    0x8(%ebp),%eax
  80219c:	6a 00                	push   $0x0
  80219e:	6a 00                	push   $0x0
  8021a0:	52                   	push   %edx
  8021a1:	ff 75 0c             	pushl  0xc(%ebp)
  8021a4:	50                   	push   %eax
  8021a5:	6a 00                	push   $0x0
  8021a7:	e8 b2 ff ff ff       	call   80215e <syscall>
  8021ac:	83 c4 18             	add    $0x18,%esp
}
  8021af:	90                   	nop
  8021b0:	c9                   	leave  
  8021b1:	c3                   	ret    

008021b2 <sys_cgetc>:

int
sys_cgetc(void)
{
  8021b2:	55                   	push   %ebp
  8021b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8021b5:	6a 00                	push   $0x0
  8021b7:	6a 00                	push   $0x0
  8021b9:	6a 00                	push   $0x0
  8021bb:	6a 00                	push   $0x0
  8021bd:	6a 00                	push   $0x0
  8021bf:	6a 01                	push   $0x1
  8021c1:	e8 98 ff ff ff       	call   80215e <syscall>
  8021c6:	83 c4 18             	add    $0x18,%esp
}
  8021c9:	c9                   	leave  
  8021ca:	c3                   	ret    

008021cb <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8021cb:	55                   	push   %ebp
  8021cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8021ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8021d1:	6a 00                	push   $0x0
  8021d3:	6a 00                	push   $0x0
  8021d5:	6a 00                	push   $0x0
  8021d7:	6a 00                	push   $0x0
  8021d9:	50                   	push   %eax
  8021da:	6a 05                	push   $0x5
  8021dc:	e8 7d ff ff ff       	call   80215e <syscall>
  8021e1:	83 c4 18             	add    $0x18,%esp
}
  8021e4:	c9                   	leave  
  8021e5:	c3                   	ret    

008021e6 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8021e6:	55                   	push   %ebp
  8021e7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8021e9:	6a 00                	push   $0x0
  8021eb:	6a 00                	push   $0x0
  8021ed:	6a 00                	push   $0x0
  8021ef:	6a 00                	push   $0x0
  8021f1:	6a 00                	push   $0x0
  8021f3:	6a 02                	push   $0x2
  8021f5:	e8 64 ff ff ff       	call   80215e <syscall>
  8021fa:	83 c4 18             	add    $0x18,%esp
}
  8021fd:	c9                   	leave  
  8021fe:	c3                   	ret    

008021ff <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8021ff:	55                   	push   %ebp
  802200:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802202:	6a 00                	push   $0x0
  802204:	6a 00                	push   $0x0
  802206:	6a 00                	push   $0x0
  802208:	6a 00                	push   $0x0
  80220a:	6a 00                	push   $0x0
  80220c:	6a 03                	push   $0x3
  80220e:	e8 4b ff ff ff       	call   80215e <syscall>
  802213:	83 c4 18             	add    $0x18,%esp
}
  802216:	c9                   	leave  
  802217:	c3                   	ret    

00802218 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802218:	55                   	push   %ebp
  802219:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80221b:	6a 00                	push   $0x0
  80221d:	6a 00                	push   $0x0
  80221f:	6a 00                	push   $0x0
  802221:	6a 00                	push   $0x0
  802223:	6a 00                	push   $0x0
  802225:	6a 04                	push   $0x4
  802227:	e8 32 ff ff ff       	call   80215e <syscall>
  80222c:	83 c4 18             	add    $0x18,%esp
}
  80222f:	c9                   	leave  
  802230:	c3                   	ret    

00802231 <sys_env_exit>:


void sys_env_exit(void)
{
  802231:	55                   	push   %ebp
  802232:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802234:	6a 00                	push   $0x0
  802236:	6a 00                	push   $0x0
  802238:	6a 00                	push   $0x0
  80223a:	6a 00                	push   $0x0
  80223c:	6a 00                	push   $0x0
  80223e:	6a 06                	push   $0x6
  802240:	e8 19 ff ff ff       	call   80215e <syscall>
  802245:	83 c4 18             	add    $0x18,%esp
}
  802248:	90                   	nop
  802249:	c9                   	leave  
  80224a:	c3                   	ret    

0080224b <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80224b:	55                   	push   %ebp
  80224c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80224e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802251:	8b 45 08             	mov    0x8(%ebp),%eax
  802254:	6a 00                	push   $0x0
  802256:	6a 00                	push   $0x0
  802258:	6a 00                	push   $0x0
  80225a:	52                   	push   %edx
  80225b:	50                   	push   %eax
  80225c:	6a 07                	push   $0x7
  80225e:	e8 fb fe ff ff       	call   80215e <syscall>
  802263:	83 c4 18             	add    $0x18,%esp
}
  802266:	c9                   	leave  
  802267:	c3                   	ret    

00802268 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802268:	55                   	push   %ebp
  802269:	89 e5                	mov    %esp,%ebp
  80226b:	56                   	push   %esi
  80226c:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80226d:	8b 75 18             	mov    0x18(%ebp),%esi
  802270:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802273:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802276:	8b 55 0c             	mov    0xc(%ebp),%edx
  802279:	8b 45 08             	mov    0x8(%ebp),%eax
  80227c:	56                   	push   %esi
  80227d:	53                   	push   %ebx
  80227e:	51                   	push   %ecx
  80227f:	52                   	push   %edx
  802280:	50                   	push   %eax
  802281:	6a 08                	push   $0x8
  802283:	e8 d6 fe ff ff       	call   80215e <syscall>
  802288:	83 c4 18             	add    $0x18,%esp
}
  80228b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80228e:	5b                   	pop    %ebx
  80228f:	5e                   	pop    %esi
  802290:	5d                   	pop    %ebp
  802291:	c3                   	ret    

00802292 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802292:	55                   	push   %ebp
  802293:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802295:	8b 55 0c             	mov    0xc(%ebp),%edx
  802298:	8b 45 08             	mov    0x8(%ebp),%eax
  80229b:	6a 00                	push   $0x0
  80229d:	6a 00                	push   $0x0
  80229f:	6a 00                	push   $0x0
  8022a1:	52                   	push   %edx
  8022a2:	50                   	push   %eax
  8022a3:	6a 09                	push   $0x9
  8022a5:	e8 b4 fe ff ff       	call   80215e <syscall>
  8022aa:	83 c4 18             	add    $0x18,%esp
}
  8022ad:	c9                   	leave  
  8022ae:	c3                   	ret    

008022af <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8022af:	55                   	push   %ebp
  8022b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8022b2:	6a 00                	push   $0x0
  8022b4:	6a 00                	push   $0x0
  8022b6:	6a 00                	push   $0x0
  8022b8:	ff 75 0c             	pushl  0xc(%ebp)
  8022bb:	ff 75 08             	pushl  0x8(%ebp)
  8022be:	6a 0a                	push   $0xa
  8022c0:	e8 99 fe ff ff       	call   80215e <syscall>
  8022c5:	83 c4 18             	add    $0x18,%esp
}
  8022c8:	c9                   	leave  
  8022c9:	c3                   	ret    

008022ca <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8022ca:	55                   	push   %ebp
  8022cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8022cd:	6a 00                	push   $0x0
  8022cf:	6a 00                	push   $0x0
  8022d1:	6a 00                	push   $0x0
  8022d3:	6a 00                	push   $0x0
  8022d5:	6a 00                	push   $0x0
  8022d7:	6a 0b                	push   $0xb
  8022d9:	e8 80 fe ff ff       	call   80215e <syscall>
  8022de:	83 c4 18             	add    $0x18,%esp
}
  8022e1:	c9                   	leave  
  8022e2:	c3                   	ret    

008022e3 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8022e3:	55                   	push   %ebp
  8022e4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8022e6:	6a 00                	push   $0x0
  8022e8:	6a 00                	push   $0x0
  8022ea:	6a 00                	push   $0x0
  8022ec:	6a 00                	push   $0x0
  8022ee:	6a 00                	push   $0x0
  8022f0:	6a 0c                	push   $0xc
  8022f2:	e8 67 fe ff ff       	call   80215e <syscall>
  8022f7:	83 c4 18             	add    $0x18,%esp
}
  8022fa:	c9                   	leave  
  8022fb:	c3                   	ret    

008022fc <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8022fc:	55                   	push   %ebp
  8022fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8022ff:	6a 00                	push   $0x0
  802301:	6a 00                	push   $0x0
  802303:	6a 00                	push   $0x0
  802305:	6a 00                	push   $0x0
  802307:	6a 00                	push   $0x0
  802309:	6a 0d                	push   $0xd
  80230b:	e8 4e fe ff ff       	call   80215e <syscall>
  802310:	83 c4 18             	add    $0x18,%esp
}
  802313:	c9                   	leave  
  802314:	c3                   	ret    

00802315 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802315:	55                   	push   %ebp
  802316:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802318:	6a 00                	push   $0x0
  80231a:	6a 00                	push   $0x0
  80231c:	6a 00                	push   $0x0
  80231e:	ff 75 0c             	pushl  0xc(%ebp)
  802321:	ff 75 08             	pushl  0x8(%ebp)
  802324:	6a 11                	push   $0x11
  802326:	e8 33 fe ff ff       	call   80215e <syscall>
  80232b:	83 c4 18             	add    $0x18,%esp
	return;
  80232e:	90                   	nop
}
  80232f:	c9                   	leave  
  802330:	c3                   	ret    

00802331 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802331:	55                   	push   %ebp
  802332:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802334:	6a 00                	push   $0x0
  802336:	6a 00                	push   $0x0
  802338:	6a 00                	push   $0x0
  80233a:	ff 75 0c             	pushl  0xc(%ebp)
  80233d:	ff 75 08             	pushl  0x8(%ebp)
  802340:	6a 12                	push   $0x12
  802342:	e8 17 fe ff ff       	call   80215e <syscall>
  802347:	83 c4 18             	add    $0x18,%esp
	return ;
  80234a:	90                   	nop
}
  80234b:	c9                   	leave  
  80234c:	c3                   	ret    

0080234d <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80234d:	55                   	push   %ebp
  80234e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802350:	6a 00                	push   $0x0
  802352:	6a 00                	push   $0x0
  802354:	6a 00                	push   $0x0
  802356:	6a 00                	push   $0x0
  802358:	6a 00                	push   $0x0
  80235a:	6a 0e                	push   $0xe
  80235c:	e8 fd fd ff ff       	call   80215e <syscall>
  802361:	83 c4 18             	add    $0x18,%esp
}
  802364:	c9                   	leave  
  802365:	c3                   	ret    

00802366 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802366:	55                   	push   %ebp
  802367:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802369:	6a 00                	push   $0x0
  80236b:	6a 00                	push   $0x0
  80236d:	6a 00                	push   $0x0
  80236f:	6a 00                	push   $0x0
  802371:	ff 75 08             	pushl  0x8(%ebp)
  802374:	6a 0f                	push   $0xf
  802376:	e8 e3 fd ff ff       	call   80215e <syscall>
  80237b:	83 c4 18             	add    $0x18,%esp
}
  80237e:	c9                   	leave  
  80237f:	c3                   	ret    

00802380 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802380:	55                   	push   %ebp
  802381:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802383:	6a 00                	push   $0x0
  802385:	6a 00                	push   $0x0
  802387:	6a 00                	push   $0x0
  802389:	6a 00                	push   $0x0
  80238b:	6a 00                	push   $0x0
  80238d:	6a 10                	push   $0x10
  80238f:	e8 ca fd ff ff       	call   80215e <syscall>
  802394:	83 c4 18             	add    $0x18,%esp
}
  802397:	90                   	nop
  802398:	c9                   	leave  
  802399:	c3                   	ret    

0080239a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80239a:	55                   	push   %ebp
  80239b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80239d:	6a 00                	push   $0x0
  80239f:	6a 00                	push   $0x0
  8023a1:	6a 00                	push   $0x0
  8023a3:	6a 00                	push   $0x0
  8023a5:	6a 00                	push   $0x0
  8023a7:	6a 14                	push   $0x14
  8023a9:	e8 b0 fd ff ff       	call   80215e <syscall>
  8023ae:	83 c4 18             	add    $0x18,%esp
}
  8023b1:	90                   	nop
  8023b2:	c9                   	leave  
  8023b3:	c3                   	ret    

008023b4 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8023b4:	55                   	push   %ebp
  8023b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8023b7:	6a 00                	push   $0x0
  8023b9:	6a 00                	push   $0x0
  8023bb:	6a 00                	push   $0x0
  8023bd:	6a 00                	push   $0x0
  8023bf:	6a 00                	push   $0x0
  8023c1:	6a 15                	push   $0x15
  8023c3:	e8 96 fd ff ff       	call   80215e <syscall>
  8023c8:	83 c4 18             	add    $0x18,%esp
}
  8023cb:	90                   	nop
  8023cc:	c9                   	leave  
  8023cd:	c3                   	ret    

008023ce <sys_cputc>:


void
sys_cputc(const char c)
{
  8023ce:	55                   	push   %ebp
  8023cf:	89 e5                	mov    %esp,%ebp
  8023d1:	83 ec 04             	sub    $0x4,%esp
  8023d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8023d7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8023da:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8023de:	6a 00                	push   $0x0
  8023e0:	6a 00                	push   $0x0
  8023e2:	6a 00                	push   $0x0
  8023e4:	6a 00                	push   $0x0
  8023e6:	50                   	push   %eax
  8023e7:	6a 16                	push   $0x16
  8023e9:	e8 70 fd ff ff       	call   80215e <syscall>
  8023ee:	83 c4 18             	add    $0x18,%esp
}
  8023f1:	90                   	nop
  8023f2:	c9                   	leave  
  8023f3:	c3                   	ret    

008023f4 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8023f4:	55                   	push   %ebp
  8023f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8023f7:	6a 00                	push   $0x0
  8023f9:	6a 00                	push   $0x0
  8023fb:	6a 00                	push   $0x0
  8023fd:	6a 00                	push   $0x0
  8023ff:	6a 00                	push   $0x0
  802401:	6a 17                	push   $0x17
  802403:	e8 56 fd ff ff       	call   80215e <syscall>
  802408:	83 c4 18             	add    $0x18,%esp
}
  80240b:	90                   	nop
  80240c:	c9                   	leave  
  80240d:	c3                   	ret    

0080240e <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80240e:	55                   	push   %ebp
  80240f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802411:	8b 45 08             	mov    0x8(%ebp),%eax
  802414:	6a 00                	push   $0x0
  802416:	6a 00                	push   $0x0
  802418:	6a 00                	push   $0x0
  80241a:	ff 75 0c             	pushl  0xc(%ebp)
  80241d:	50                   	push   %eax
  80241e:	6a 18                	push   $0x18
  802420:	e8 39 fd ff ff       	call   80215e <syscall>
  802425:	83 c4 18             	add    $0x18,%esp
}
  802428:	c9                   	leave  
  802429:	c3                   	ret    

0080242a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80242a:	55                   	push   %ebp
  80242b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80242d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802430:	8b 45 08             	mov    0x8(%ebp),%eax
  802433:	6a 00                	push   $0x0
  802435:	6a 00                	push   $0x0
  802437:	6a 00                	push   $0x0
  802439:	52                   	push   %edx
  80243a:	50                   	push   %eax
  80243b:	6a 1b                	push   $0x1b
  80243d:	e8 1c fd ff ff       	call   80215e <syscall>
  802442:	83 c4 18             	add    $0x18,%esp
}
  802445:	c9                   	leave  
  802446:	c3                   	ret    

00802447 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802447:	55                   	push   %ebp
  802448:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80244a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80244d:	8b 45 08             	mov    0x8(%ebp),%eax
  802450:	6a 00                	push   $0x0
  802452:	6a 00                	push   $0x0
  802454:	6a 00                	push   $0x0
  802456:	52                   	push   %edx
  802457:	50                   	push   %eax
  802458:	6a 19                	push   $0x19
  80245a:	e8 ff fc ff ff       	call   80215e <syscall>
  80245f:	83 c4 18             	add    $0x18,%esp
}
  802462:	90                   	nop
  802463:	c9                   	leave  
  802464:	c3                   	ret    

00802465 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802465:	55                   	push   %ebp
  802466:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802468:	8b 55 0c             	mov    0xc(%ebp),%edx
  80246b:	8b 45 08             	mov    0x8(%ebp),%eax
  80246e:	6a 00                	push   $0x0
  802470:	6a 00                	push   $0x0
  802472:	6a 00                	push   $0x0
  802474:	52                   	push   %edx
  802475:	50                   	push   %eax
  802476:	6a 1a                	push   $0x1a
  802478:	e8 e1 fc ff ff       	call   80215e <syscall>
  80247d:	83 c4 18             	add    $0x18,%esp
}
  802480:	90                   	nop
  802481:	c9                   	leave  
  802482:	c3                   	ret    

00802483 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802483:	55                   	push   %ebp
  802484:	89 e5                	mov    %esp,%ebp
  802486:	83 ec 04             	sub    $0x4,%esp
  802489:	8b 45 10             	mov    0x10(%ebp),%eax
  80248c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80248f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802492:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802496:	8b 45 08             	mov    0x8(%ebp),%eax
  802499:	6a 00                	push   $0x0
  80249b:	51                   	push   %ecx
  80249c:	52                   	push   %edx
  80249d:	ff 75 0c             	pushl  0xc(%ebp)
  8024a0:	50                   	push   %eax
  8024a1:	6a 1c                	push   $0x1c
  8024a3:	e8 b6 fc ff ff       	call   80215e <syscall>
  8024a8:	83 c4 18             	add    $0x18,%esp
}
  8024ab:	c9                   	leave  
  8024ac:	c3                   	ret    

008024ad <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8024ad:	55                   	push   %ebp
  8024ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8024b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8024b6:	6a 00                	push   $0x0
  8024b8:	6a 00                	push   $0x0
  8024ba:	6a 00                	push   $0x0
  8024bc:	52                   	push   %edx
  8024bd:	50                   	push   %eax
  8024be:	6a 1d                	push   $0x1d
  8024c0:	e8 99 fc ff ff       	call   80215e <syscall>
  8024c5:	83 c4 18             	add    $0x18,%esp
}
  8024c8:	c9                   	leave  
  8024c9:	c3                   	ret    

008024ca <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8024ca:	55                   	push   %ebp
  8024cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8024cd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8024d0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8024d6:	6a 00                	push   $0x0
  8024d8:	6a 00                	push   $0x0
  8024da:	51                   	push   %ecx
  8024db:	52                   	push   %edx
  8024dc:	50                   	push   %eax
  8024dd:	6a 1e                	push   $0x1e
  8024df:	e8 7a fc ff ff       	call   80215e <syscall>
  8024e4:	83 c4 18             	add    $0x18,%esp
}
  8024e7:	c9                   	leave  
  8024e8:	c3                   	ret    

008024e9 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8024e9:	55                   	push   %ebp
  8024ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8024ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8024f2:	6a 00                	push   $0x0
  8024f4:	6a 00                	push   $0x0
  8024f6:	6a 00                	push   $0x0
  8024f8:	52                   	push   %edx
  8024f9:	50                   	push   %eax
  8024fa:	6a 1f                	push   $0x1f
  8024fc:	e8 5d fc ff ff       	call   80215e <syscall>
  802501:	83 c4 18             	add    $0x18,%esp
}
  802504:	c9                   	leave  
  802505:	c3                   	ret    

00802506 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802506:	55                   	push   %ebp
  802507:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802509:	6a 00                	push   $0x0
  80250b:	6a 00                	push   $0x0
  80250d:	6a 00                	push   $0x0
  80250f:	6a 00                	push   $0x0
  802511:	6a 00                	push   $0x0
  802513:	6a 20                	push   $0x20
  802515:	e8 44 fc ff ff       	call   80215e <syscall>
  80251a:	83 c4 18             	add    $0x18,%esp
}
  80251d:	c9                   	leave  
  80251e:	c3                   	ret    

0080251f <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80251f:	55                   	push   %ebp
  802520:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802522:	8b 45 08             	mov    0x8(%ebp),%eax
  802525:	6a 00                	push   $0x0
  802527:	ff 75 14             	pushl  0x14(%ebp)
  80252a:	ff 75 10             	pushl  0x10(%ebp)
  80252d:	ff 75 0c             	pushl  0xc(%ebp)
  802530:	50                   	push   %eax
  802531:	6a 21                	push   $0x21
  802533:	e8 26 fc ff ff       	call   80215e <syscall>
  802538:	83 c4 18             	add    $0x18,%esp
}
  80253b:	c9                   	leave  
  80253c:	c3                   	ret    

0080253d <sys_run_env>:


void
sys_run_env(int32 envId)
{
  80253d:	55                   	push   %ebp
  80253e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802540:	8b 45 08             	mov    0x8(%ebp),%eax
  802543:	6a 00                	push   $0x0
  802545:	6a 00                	push   $0x0
  802547:	6a 00                	push   $0x0
  802549:	6a 00                	push   $0x0
  80254b:	50                   	push   %eax
  80254c:	6a 22                	push   $0x22
  80254e:	e8 0b fc ff ff       	call   80215e <syscall>
  802553:	83 c4 18             	add    $0x18,%esp
}
  802556:	90                   	nop
  802557:	c9                   	leave  
  802558:	c3                   	ret    

00802559 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802559:	55                   	push   %ebp
  80255a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80255c:	8b 45 08             	mov    0x8(%ebp),%eax
  80255f:	6a 00                	push   $0x0
  802561:	6a 00                	push   $0x0
  802563:	6a 00                	push   $0x0
  802565:	6a 00                	push   $0x0
  802567:	50                   	push   %eax
  802568:	6a 23                	push   $0x23
  80256a:	e8 ef fb ff ff       	call   80215e <syscall>
  80256f:	83 c4 18             	add    $0x18,%esp
}
  802572:	90                   	nop
  802573:	c9                   	leave  
  802574:	c3                   	ret    

00802575 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802575:	55                   	push   %ebp
  802576:	89 e5                	mov    %esp,%ebp
  802578:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80257b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80257e:	8d 50 04             	lea    0x4(%eax),%edx
  802581:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802584:	6a 00                	push   $0x0
  802586:	6a 00                	push   $0x0
  802588:	6a 00                	push   $0x0
  80258a:	52                   	push   %edx
  80258b:	50                   	push   %eax
  80258c:	6a 24                	push   $0x24
  80258e:	e8 cb fb ff ff       	call   80215e <syscall>
  802593:	83 c4 18             	add    $0x18,%esp
	return result;
  802596:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802599:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80259c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80259f:	89 01                	mov    %eax,(%ecx)
  8025a1:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8025a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8025a7:	c9                   	leave  
  8025a8:	c2 04 00             	ret    $0x4

008025ab <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8025ab:	55                   	push   %ebp
  8025ac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8025ae:	6a 00                	push   $0x0
  8025b0:	6a 00                	push   $0x0
  8025b2:	ff 75 10             	pushl  0x10(%ebp)
  8025b5:	ff 75 0c             	pushl  0xc(%ebp)
  8025b8:	ff 75 08             	pushl  0x8(%ebp)
  8025bb:	6a 13                	push   $0x13
  8025bd:	e8 9c fb ff ff       	call   80215e <syscall>
  8025c2:	83 c4 18             	add    $0x18,%esp
	return ;
  8025c5:	90                   	nop
}
  8025c6:	c9                   	leave  
  8025c7:	c3                   	ret    

008025c8 <sys_rcr2>:
uint32 sys_rcr2()
{
  8025c8:	55                   	push   %ebp
  8025c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8025cb:	6a 00                	push   $0x0
  8025cd:	6a 00                	push   $0x0
  8025cf:	6a 00                	push   $0x0
  8025d1:	6a 00                	push   $0x0
  8025d3:	6a 00                	push   $0x0
  8025d5:	6a 25                	push   $0x25
  8025d7:	e8 82 fb ff ff       	call   80215e <syscall>
  8025dc:	83 c4 18             	add    $0x18,%esp
}
  8025df:	c9                   	leave  
  8025e0:	c3                   	ret    

008025e1 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8025e1:	55                   	push   %ebp
  8025e2:	89 e5                	mov    %esp,%ebp
  8025e4:	83 ec 04             	sub    $0x4,%esp
  8025e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8025ea:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8025ed:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8025f1:	6a 00                	push   $0x0
  8025f3:	6a 00                	push   $0x0
  8025f5:	6a 00                	push   $0x0
  8025f7:	6a 00                	push   $0x0
  8025f9:	50                   	push   %eax
  8025fa:	6a 26                	push   $0x26
  8025fc:	e8 5d fb ff ff       	call   80215e <syscall>
  802601:	83 c4 18             	add    $0x18,%esp
	return ;
  802604:	90                   	nop
}
  802605:	c9                   	leave  
  802606:	c3                   	ret    

00802607 <rsttst>:
void rsttst()
{
  802607:	55                   	push   %ebp
  802608:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80260a:	6a 00                	push   $0x0
  80260c:	6a 00                	push   $0x0
  80260e:	6a 00                	push   $0x0
  802610:	6a 00                	push   $0x0
  802612:	6a 00                	push   $0x0
  802614:	6a 28                	push   $0x28
  802616:	e8 43 fb ff ff       	call   80215e <syscall>
  80261b:	83 c4 18             	add    $0x18,%esp
	return ;
  80261e:	90                   	nop
}
  80261f:	c9                   	leave  
  802620:	c3                   	ret    

00802621 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802621:	55                   	push   %ebp
  802622:	89 e5                	mov    %esp,%ebp
  802624:	83 ec 04             	sub    $0x4,%esp
  802627:	8b 45 14             	mov    0x14(%ebp),%eax
  80262a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80262d:	8b 55 18             	mov    0x18(%ebp),%edx
  802630:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802634:	52                   	push   %edx
  802635:	50                   	push   %eax
  802636:	ff 75 10             	pushl  0x10(%ebp)
  802639:	ff 75 0c             	pushl  0xc(%ebp)
  80263c:	ff 75 08             	pushl  0x8(%ebp)
  80263f:	6a 27                	push   $0x27
  802641:	e8 18 fb ff ff       	call   80215e <syscall>
  802646:	83 c4 18             	add    $0x18,%esp
	return ;
  802649:	90                   	nop
}
  80264a:	c9                   	leave  
  80264b:	c3                   	ret    

0080264c <chktst>:
void chktst(uint32 n)
{
  80264c:	55                   	push   %ebp
  80264d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80264f:	6a 00                	push   $0x0
  802651:	6a 00                	push   $0x0
  802653:	6a 00                	push   $0x0
  802655:	6a 00                	push   $0x0
  802657:	ff 75 08             	pushl  0x8(%ebp)
  80265a:	6a 29                	push   $0x29
  80265c:	e8 fd fa ff ff       	call   80215e <syscall>
  802661:	83 c4 18             	add    $0x18,%esp
	return ;
  802664:	90                   	nop
}
  802665:	c9                   	leave  
  802666:	c3                   	ret    

00802667 <inctst>:

void inctst()
{
  802667:	55                   	push   %ebp
  802668:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80266a:	6a 00                	push   $0x0
  80266c:	6a 00                	push   $0x0
  80266e:	6a 00                	push   $0x0
  802670:	6a 00                	push   $0x0
  802672:	6a 00                	push   $0x0
  802674:	6a 2a                	push   $0x2a
  802676:	e8 e3 fa ff ff       	call   80215e <syscall>
  80267b:	83 c4 18             	add    $0x18,%esp
	return ;
  80267e:	90                   	nop
}
  80267f:	c9                   	leave  
  802680:	c3                   	ret    

00802681 <gettst>:
uint32 gettst()
{
  802681:	55                   	push   %ebp
  802682:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802684:	6a 00                	push   $0x0
  802686:	6a 00                	push   $0x0
  802688:	6a 00                	push   $0x0
  80268a:	6a 00                	push   $0x0
  80268c:	6a 00                	push   $0x0
  80268e:	6a 2b                	push   $0x2b
  802690:	e8 c9 fa ff ff       	call   80215e <syscall>
  802695:	83 c4 18             	add    $0x18,%esp
}
  802698:	c9                   	leave  
  802699:	c3                   	ret    

0080269a <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80269a:	55                   	push   %ebp
  80269b:	89 e5                	mov    %esp,%ebp
  80269d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8026a0:	6a 00                	push   $0x0
  8026a2:	6a 00                	push   $0x0
  8026a4:	6a 00                	push   $0x0
  8026a6:	6a 00                	push   $0x0
  8026a8:	6a 00                	push   $0x0
  8026aa:	6a 2c                	push   $0x2c
  8026ac:	e8 ad fa ff ff       	call   80215e <syscall>
  8026b1:	83 c4 18             	add    $0x18,%esp
  8026b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8026b7:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8026bb:	75 07                	jne    8026c4 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8026bd:	b8 01 00 00 00       	mov    $0x1,%eax
  8026c2:	eb 05                	jmp    8026c9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8026c4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8026c9:	c9                   	leave  
  8026ca:	c3                   	ret    

008026cb <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8026cb:	55                   	push   %ebp
  8026cc:	89 e5                	mov    %esp,%ebp
  8026ce:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8026d1:	6a 00                	push   $0x0
  8026d3:	6a 00                	push   $0x0
  8026d5:	6a 00                	push   $0x0
  8026d7:	6a 00                	push   $0x0
  8026d9:	6a 00                	push   $0x0
  8026db:	6a 2c                	push   $0x2c
  8026dd:	e8 7c fa ff ff       	call   80215e <syscall>
  8026e2:	83 c4 18             	add    $0x18,%esp
  8026e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8026e8:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8026ec:	75 07                	jne    8026f5 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8026ee:	b8 01 00 00 00       	mov    $0x1,%eax
  8026f3:	eb 05                	jmp    8026fa <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8026f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8026fa:	c9                   	leave  
  8026fb:	c3                   	ret    

008026fc <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8026fc:	55                   	push   %ebp
  8026fd:	89 e5                	mov    %esp,%ebp
  8026ff:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802702:	6a 00                	push   $0x0
  802704:	6a 00                	push   $0x0
  802706:	6a 00                	push   $0x0
  802708:	6a 00                	push   $0x0
  80270a:	6a 00                	push   $0x0
  80270c:	6a 2c                	push   $0x2c
  80270e:	e8 4b fa ff ff       	call   80215e <syscall>
  802713:	83 c4 18             	add    $0x18,%esp
  802716:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802719:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80271d:	75 07                	jne    802726 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80271f:	b8 01 00 00 00       	mov    $0x1,%eax
  802724:	eb 05                	jmp    80272b <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802726:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80272b:	c9                   	leave  
  80272c:	c3                   	ret    

0080272d <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80272d:	55                   	push   %ebp
  80272e:	89 e5                	mov    %esp,%ebp
  802730:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802733:	6a 00                	push   $0x0
  802735:	6a 00                	push   $0x0
  802737:	6a 00                	push   $0x0
  802739:	6a 00                	push   $0x0
  80273b:	6a 00                	push   $0x0
  80273d:	6a 2c                	push   $0x2c
  80273f:	e8 1a fa ff ff       	call   80215e <syscall>
  802744:	83 c4 18             	add    $0x18,%esp
  802747:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80274a:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80274e:	75 07                	jne    802757 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802750:	b8 01 00 00 00       	mov    $0x1,%eax
  802755:	eb 05                	jmp    80275c <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802757:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80275c:	c9                   	leave  
  80275d:	c3                   	ret    

0080275e <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80275e:	55                   	push   %ebp
  80275f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802761:	6a 00                	push   $0x0
  802763:	6a 00                	push   $0x0
  802765:	6a 00                	push   $0x0
  802767:	6a 00                	push   $0x0
  802769:	ff 75 08             	pushl  0x8(%ebp)
  80276c:	6a 2d                	push   $0x2d
  80276e:	e8 eb f9 ff ff       	call   80215e <syscall>
  802773:	83 c4 18             	add    $0x18,%esp
	return ;
  802776:	90                   	nop
}
  802777:	c9                   	leave  
  802778:	c3                   	ret    

00802779 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802779:	55                   	push   %ebp
  80277a:	89 e5                	mov    %esp,%ebp
  80277c:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80277d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802780:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802783:	8b 55 0c             	mov    0xc(%ebp),%edx
  802786:	8b 45 08             	mov    0x8(%ebp),%eax
  802789:	6a 00                	push   $0x0
  80278b:	53                   	push   %ebx
  80278c:	51                   	push   %ecx
  80278d:	52                   	push   %edx
  80278e:	50                   	push   %eax
  80278f:	6a 2e                	push   $0x2e
  802791:	e8 c8 f9 ff ff       	call   80215e <syscall>
  802796:	83 c4 18             	add    $0x18,%esp
}
  802799:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80279c:	c9                   	leave  
  80279d:	c3                   	ret    

0080279e <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80279e:	55                   	push   %ebp
  80279f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8027a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8027a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8027a7:	6a 00                	push   $0x0
  8027a9:	6a 00                	push   $0x0
  8027ab:	6a 00                	push   $0x0
  8027ad:	52                   	push   %edx
  8027ae:	50                   	push   %eax
  8027af:	6a 2f                	push   $0x2f
  8027b1:	e8 a8 f9 ff ff       	call   80215e <syscall>
  8027b6:	83 c4 18             	add    $0x18,%esp
}
  8027b9:	c9                   	leave  
  8027ba:	c3                   	ret    

008027bb <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8027bb:	55                   	push   %ebp
  8027bc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8027be:	6a 00                	push   $0x0
  8027c0:	6a 00                	push   $0x0
  8027c2:	6a 00                	push   $0x0
  8027c4:	ff 75 0c             	pushl  0xc(%ebp)
  8027c7:	ff 75 08             	pushl  0x8(%ebp)
  8027ca:	6a 30                	push   $0x30
  8027cc:	e8 8d f9 ff ff       	call   80215e <syscall>
  8027d1:	83 c4 18             	add    $0x18,%esp
	return ;
  8027d4:	90                   	nop
}
  8027d5:	c9                   	leave  
  8027d6:	c3                   	ret    
  8027d7:	90                   	nop

008027d8 <__udivdi3>:
  8027d8:	55                   	push   %ebp
  8027d9:	57                   	push   %edi
  8027da:	56                   	push   %esi
  8027db:	53                   	push   %ebx
  8027dc:	83 ec 1c             	sub    $0x1c,%esp
  8027df:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8027e3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8027e7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8027eb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8027ef:	89 ca                	mov    %ecx,%edx
  8027f1:	89 f8                	mov    %edi,%eax
  8027f3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8027f7:	85 f6                	test   %esi,%esi
  8027f9:	75 2d                	jne    802828 <__udivdi3+0x50>
  8027fb:	39 cf                	cmp    %ecx,%edi
  8027fd:	77 65                	ja     802864 <__udivdi3+0x8c>
  8027ff:	89 fd                	mov    %edi,%ebp
  802801:	85 ff                	test   %edi,%edi
  802803:	75 0b                	jne    802810 <__udivdi3+0x38>
  802805:	b8 01 00 00 00       	mov    $0x1,%eax
  80280a:	31 d2                	xor    %edx,%edx
  80280c:	f7 f7                	div    %edi
  80280e:	89 c5                	mov    %eax,%ebp
  802810:	31 d2                	xor    %edx,%edx
  802812:	89 c8                	mov    %ecx,%eax
  802814:	f7 f5                	div    %ebp
  802816:	89 c1                	mov    %eax,%ecx
  802818:	89 d8                	mov    %ebx,%eax
  80281a:	f7 f5                	div    %ebp
  80281c:	89 cf                	mov    %ecx,%edi
  80281e:	89 fa                	mov    %edi,%edx
  802820:	83 c4 1c             	add    $0x1c,%esp
  802823:	5b                   	pop    %ebx
  802824:	5e                   	pop    %esi
  802825:	5f                   	pop    %edi
  802826:	5d                   	pop    %ebp
  802827:	c3                   	ret    
  802828:	39 ce                	cmp    %ecx,%esi
  80282a:	77 28                	ja     802854 <__udivdi3+0x7c>
  80282c:	0f bd fe             	bsr    %esi,%edi
  80282f:	83 f7 1f             	xor    $0x1f,%edi
  802832:	75 40                	jne    802874 <__udivdi3+0x9c>
  802834:	39 ce                	cmp    %ecx,%esi
  802836:	72 0a                	jb     802842 <__udivdi3+0x6a>
  802838:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80283c:	0f 87 9e 00 00 00    	ja     8028e0 <__udivdi3+0x108>
  802842:	b8 01 00 00 00       	mov    $0x1,%eax
  802847:	89 fa                	mov    %edi,%edx
  802849:	83 c4 1c             	add    $0x1c,%esp
  80284c:	5b                   	pop    %ebx
  80284d:	5e                   	pop    %esi
  80284e:	5f                   	pop    %edi
  80284f:	5d                   	pop    %ebp
  802850:	c3                   	ret    
  802851:	8d 76 00             	lea    0x0(%esi),%esi
  802854:	31 ff                	xor    %edi,%edi
  802856:	31 c0                	xor    %eax,%eax
  802858:	89 fa                	mov    %edi,%edx
  80285a:	83 c4 1c             	add    $0x1c,%esp
  80285d:	5b                   	pop    %ebx
  80285e:	5e                   	pop    %esi
  80285f:	5f                   	pop    %edi
  802860:	5d                   	pop    %ebp
  802861:	c3                   	ret    
  802862:	66 90                	xchg   %ax,%ax
  802864:	89 d8                	mov    %ebx,%eax
  802866:	f7 f7                	div    %edi
  802868:	31 ff                	xor    %edi,%edi
  80286a:	89 fa                	mov    %edi,%edx
  80286c:	83 c4 1c             	add    $0x1c,%esp
  80286f:	5b                   	pop    %ebx
  802870:	5e                   	pop    %esi
  802871:	5f                   	pop    %edi
  802872:	5d                   	pop    %ebp
  802873:	c3                   	ret    
  802874:	bd 20 00 00 00       	mov    $0x20,%ebp
  802879:	89 eb                	mov    %ebp,%ebx
  80287b:	29 fb                	sub    %edi,%ebx
  80287d:	89 f9                	mov    %edi,%ecx
  80287f:	d3 e6                	shl    %cl,%esi
  802881:	89 c5                	mov    %eax,%ebp
  802883:	88 d9                	mov    %bl,%cl
  802885:	d3 ed                	shr    %cl,%ebp
  802887:	89 e9                	mov    %ebp,%ecx
  802889:	09 f1                	or     %esi,%ecx
  80288b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80288f:	89 f9                	mov    %edi,%ecx
  802891:	d3 e0                	shl    %cl,%eax
  802893:	89 c5                	mov    %eax,%ebp
  802895:	89 d6                	mov    %edx,%esi
  802897:	88 d9                	mov    %bl,%cl
  802899:	d3 ee                	shr    %cl,%esi
  80289b:	89 f9                	mov    %edi,%ecx
  80289d:	d3 e2                	shl    %cl,%edx
  80289f:	8b 44 24 08          	mov    0x8(%esp),%eax
  8028a3:	88 d9                	mov    %bl,%cl
  8028a5:	d3 e8                	shr    %cl,%eax
  8028a7:	09 c2                	or     %eax,%edx
  8028a9:	89 d0                	mov    %edx,%eax
  8028ab:	89 f2                	mov    %esi,%edx
  8028ad:	f7 74 24 0c          	divl   0xc(%esp)
  8028b1:	89 d6                	mov    %edx,%esi
  8028b3:	89 c3                	mov    %eax,%ebx
  8028b5:	f7 e5                	mul    %ebp
  8028b7:	39 d6                	cmp    %edx,%esi
  8028b9:	72 19                	jb     8028d4 <__udivdi3+0xfc>
  8028bb:	74 0b                	je     8028c8 <__udivdi3+0xf0>
  8028bd:	89 d8                	mov    %ebx,%eax
  8028bf:	31 ff                	xor    %edi,%edi
  8028c1:	e9 58 ff ff ff       	jmp    80281e <__udivdi3+0x46>
  8028c6:	66 90                	xchg   %ax,%ax
  8028c8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8028cc:	89 f9                	mov    %edi,%ecx
  8028ce:	d3 e2                	shl    %cl,%edx
  8028d0:	39 c2                	cmp    %eax,%edx
  8028d2:	73 e9                	jae    8028bd <__udivdi3+0xe5>
  8028d4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8028d7:	31 ff                	xor    %edi,%edi
  8028d9:	e9 40 ff ff ff       	jmp    80281e <__udivdi3+0x46>
  8028de:	66 90                	xchg   %ax,%ax
  8028e0:	31 c0                	xor    %eax,%eax
  8028e2:	e9 37 ff ff ff       	jmp    80281e <__udivdi3+0x46>
  8028e7:	90                   	nop

008028e8 <__umoddi3>:
  8028e8:	55                   	push   %ebp
  8028e9:	57                   	push   %edi
  8028ea:	56                   	push   %esi
  8028eb:	53                   	push   %ebx
  8028ec:	83 ec 1c             	sub    $0x1c,%esp
  8028ef:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8028f3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8028f7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8028fb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8028ff:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802903:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802907:	89 f3                	mov    %esi,%ebx
  802909:	89 fa                	mov    %edi,%edx
  80290b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80290f:	89 34 24             	mov    %esi,(%esp)
  802912:	85 c0                	test   %eax,%eax
  802914:	75 1a                	jne    802930 <__umoddi3+0x48>
  802916:	39 f7                	cmp    %esi,%edi
  802918:	0f 86 a2 00 00 00    	jbe    8029c0 <__umoddi3+0xd8>
  80291e:	89 c8                	mov    %ecx,%eax
  802920:	89 f2                	mov    %esi,%edx
  802922:	f7 f7                	div    %edi
  802924:	89 d0                	mov    %edx,%eax
  802926:	31 d2                	xor    %edx,%edx
  802928:	83 c4 1c             	add    $0x1c,%esp
  80292b:	5b                   	pop    %ebx
  80292c:	5e                   	pop    %esi
  80292d:	5f                   	pop    %edi
  80292e:	5d                   	pop    %ebp
  80292f:	c3                   	ret    
  802930:	39 f0                	cmp    %esi,%eax
  802932:	0f 87 ac 00 00 00    	ja     8029e4 <__umoddi3+0xfc>
  802938:	0f bd e8             	bsr    %eax,%ebp
  80293b:	83 f5 1f             	xor    $0x1f,%ebp
  80293e:	0f 84 ac 00 00 00    	je     8029f0 <__umoddi3+0x108>
  802944:	bf 20 00 00 00       	mov    $0x20,%edi
  802949:	29 ef                	sub    %ebp,%edi
  80294b:	89 fe                	mov    %edi,%esi
  80294d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802951:	89 e9                	mov    %ebp,%ecx
  802953:	d3 e0                	shl    %cl,%eax
  802955:	89 d7                	mov    %edx,%edi
  802957:	89 f1                	mov    %esi,%ecx
  802959:	d3 ef                	shr    %cl,%edi
  80295b:	09 c7                	or     %eax,%edi
  80295d:	89 e9                	mov    %ebp,%ecx
  80295f:	d3 e2                	shl    %cl,%edx
  802961:	89 14 24             	mov    %edx,(%esp)
  802964:	89 d8                	mov    %ebx,%eax
  802966:	d3 e0                	shl    %cl,%eax
  802968:	89 c2                	mov    %eax,%edx
  80296a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80296e:	d3 e0                	shl    %cl,%eax
  802970:	89 44 24 04          	mov    %eax,0x4(%esp)
  802974:	8b 44 24 08          	mov    0x8(%esp),%eax
  802978:	89 f1                	mov    %esi,%ecx
  80297a:	d3 e8                	shr    %cl,%eax
  80297c:	09 d0                	or     %edx,%eax
  80297e:	d3 eb                	shr    %cl,%ebx
  802980:	89 da                	mov    %ebx,%edx
  802982:	f7 f7                	div    %edi
  802984:	89 d3                	mov    %edx,%ebx
  802986:	f7 24 24             	mull   (%esp)
  802989:	89 c6                	mov    %eax,%esi
  80298b:	89 d1                	mov    %edx,%ecx
  80298d:	39 d3                	cmp    %edx,%ebx
  80298f:	0f 82 87 00 00 00    	jb     802a1c <__umoddi3+0x134>
  802995:	0f 84 91 00 00 00    	je     802a2c <__umoddi3+0x144>
  80299b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80299f:	29 f2                	sub    %esi,%edx
  8029a1:	19 cb                	sbb    %ecx,%ebx
  8029a3:	89 d8                	mov    %ebx,%eax
  8029a5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8029a9:	d3 e0                	shl    %cl,%eax
  8029ab:	89 e9                	mov    %ebp,%ecx
  8029ad:	d3 ea                	shr    %cl,%edx
  8029af:	09 d0                	or     %edx,%eax
  8029b1:	89 e9                	mov    %ebp,%ecx
  8029b3:	d3 eb                	shr    %cl,%ebx
  8029b5:	89 da                	mov    %ebx,%edx
  8029b7:	83 c4 1c             	add    $0x1c,%esp
  8029ba:	5b                   	pop    %ebx
  8029bb:	5e                   	pop    %esi
  8029bc:	5f                   	pop    %edi
  8029bd:	5d                   	pop    %ebp
  8029be:	c3                   	ret    
  8029bf:	90                   	nop
  8029c0:	89 fd                	mov    %edi,%ebp
  8029c2:	85 ff                	test   %edi,%edi
  8029c4:	75 0b                	jne    8029d1 <__umoddi3+0xe9>
  8029c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8029cb:	31 d2                	xor    %edx,%edx
  8029cd:	f7 f7                	div    %edi
  8029cf:	89 c5                	mov    %eax,%ebp
  8029d1:	89 f0                	mov    %esi,%eax
  8029d3:	31 d2                	xor    %edx,%edx
  8029d5:	f7 f5                	div    %ebp
  8029d7:	89 c8                	mov    %ecx,%eax
  8029d9:	f7 f5                	div    %ebp
  8029db:	89 d0                	mov    %edx,%eax
  8029dd:	e9 44 ff ff ff       	jmp    802926 <__umoddi3+0x3e>
  8029e2:	66 90                	xchg   %ax,%ax
  8029e4:	89 c8                	mov    %ecx,%eax
  8029e6:	89 f2                	mov    %esi,%edx
  8029e8:	83 c4 1c             	add    $0x1c,%esp
  8029eb:	5b                   	pop    %ebx
  8029ec:	5e                   	pop    %esi
  8029ed:	5f                   	pop    %edi
  8029ee:	5d                   	pop    %ebp
  8029ef:	c3                   	ret    
  8029f0:	3b 04 24             	cmp    (%esp),%eax
  8029f3:	72 06                	jb     8029fb <__umoddi3+0x113>
  8029f5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8029f9:	77 0f                	ja     802a0a <__umoddi3+0x122>
  8029fb:	89 f2                	mov    %esi,%edx
  8029fd:	29 f9                	sub    %edi,%ecx
  8029ff:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802a03:	89 14 24             	mov    %edx,(%esp)
  802a06:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802a0a:	8b 44 24 04          	mov    0x4(%esp),%eax
  802a0e:	8b 14 24             	mov    (%esp),%edx
  802a11:	83 c4 1c             	add    $0x1c,%esp
  802a14:	5b                   	pop    %ebx
  802a15:	5e                   	pop    %esi
  802a16:	5f                   	pop    %edi
  802a17:	5d                   	pop    %ebp
  802a18:	c3                   	ret    
  802a19:	8d 76 00             	lea    0x0(%esi),%esi
  802a1c:	2b 04 24             	sub    (%esp),%eax
  802a1f:	19 fa                	sbb    %edi,%edx
  802a21:	89 d1                	mov    %edx,%ecx
  802a23:	89 c6                	mov    %eax,%esi
  802a25:	e9 71 ff ff ff       	jmp    80299b <__umoddi3+0xb3>
  802a2a:	66 90                	xchg   %ax,%ax
  802a2c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802a30:	72 ea                	jb     802a1c <__umoddi3+0x134>
  802a32:	89 d9                	mov    %ebx,%ecx
  802a34:	e9 62 ff ff ff       	jmp    80299b <__umoddi3+0xb3>
