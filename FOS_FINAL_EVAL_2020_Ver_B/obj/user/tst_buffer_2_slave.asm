
obj/user/tst_buffer_2_slave:     file format elf32-i386


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
  800031:	e8 7c 06 00 00       	call   8006b2 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#define arrSize PAGE_SIZE*8 / 4
int src[arrSize];
int dst[arrSize];

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 68             	sub    $0x68,%esp



	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800049:	8b 00                	mov    (%eax),%eax
  80004b:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80004e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800051:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800056:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005b:	74 14                	je     800071 <_main+0x39>
  80005d:	83 ec 04             	sub    $0x4,%esp
  800060:	68 c0 21 80 00       	push   $0x8021c0
  800065:	6a 17                	push   $0x17
  800067:	68 08 22 80 00       	push   $0x802208
  80006c:	e8 66 07 00 00       	call   8007d7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800071:	a1 20 30 80 00       	mov    0x803020,%eax
  800076:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80007c:	83 c0 14             	add    $0x14,%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  800084:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 c0 21 80 00       	push   $0x8021c0
  80009b:	6a 18                	push   $0x18
  80009d:	68 08 22 80 00       	push   $0x802208
  8000a2:	e8 30 07 00 00       	call   8007d7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ac:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8000b2:	83 c0 28             	add    $0x28,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8000ba:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 c0 21 80 00       	push   $0x8021c0
  8000d1:	6a 19                	push   $0x19
  8000d3:	68 08 22 80 00       	push   $0x802208
  8000d8:	e8 fa 06 00 00       	call   8007d7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8000e8:	83 c0 3c             	add    $0x3c,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8000f0:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 c0 21 80 00       	push   $0x8021c0
  800107:	6a 1a                	push   $0x1a
  800109:	68 08 22 80 00       	push   $0x802208
  80010e:	e8 c4 06 00 00       	call   8007d7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800113:	a1 20 30 80 00       	mov    0x803020,%eax
  800118:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80011e:	83 c0 50             	add    $0x50,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800126:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 c0 21 80 00       	push   $0x8021c0
  80013d:	6a 1b                	push   $0x1b
  80013f:	68 08 22 80 00       	push   $0x802208
  800144:	e8 8e 06 00 00       	call   8007d7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800149:	a1 20 30 80 00       	mov    0x803020,%eax
  80014e:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800154:	83 c0 64             	add    $0x64,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  80015c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 c0 21 80 00       	push   $0x8021c0
  800173:	6a 1c                	push   $0x1c
  800175:	68 08 22 80 00       	push   $0x802208
  80017a:	e8 58 06 00 00       	call   8007d7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80017f:	a1 20 30 80 00       	mov    0x803020,%eax
  800184:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80018a:	83 c0 78             	add    $0x78,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800192:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 c0 21 80 00       	push   $0x8021c0
  8001a9:	6a 1d                	push   $0x1d
  8001ab:	68 08 22 80 00       	push   $0x802208
  8001b0:	e8 22 06 00 00       	call   8007d7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ba:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8001c0:	05 8c 00 00 00       	add    $0x8c,%eax
  8001c5:	8b 00                	mov    (%eax),%eax
  8001c7:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8001ca:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8001cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d2:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d7:	74 14                	je     8001ed <_main+0x1b5>
  8001d9:	83 ec 04             	sub    $0x4,%esp
  8001dc:	68 c0 21 80 00       	push   $0x8021c0
  8001e1:	6a 1e                	push   $0x1e
  8001e3:	68 08 22 80 00       	push   $0x802208
  8001e8:	e8 ea 05 00 00       	call   8007d7 <_panic>
		//if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f2:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8001f8:	05 a0 00 00 00       	add    $0xa0,%eax
  8001fd:	8b 00                	mov    (%eax),%eax
  8001ff:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800202:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800205:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80020a:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020f:	74 14                	je     800225 <_main+0x1ed>
  800211:	83 ec 04             	sub    $0x4,%esp
  800214:	68 c0 21 80 00       	push   $0x8021c0
  800219:	6a 20                	push   $0x20
  80021b:	68 08 22 80 00       	push   $0x802208
  800220:	e8 b2 05 00 00       	call   8007d7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800225:	a1 20 30 80 00       	mov    0x803020,%eax
  80022a:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800230:	05 b4 00 00 00       	add    $0xb4,%eax
  800235:	8b 00                	mov    (%eax),%eax
  800237:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  80023a:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80023d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800242:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800247:	74 14                	je     80025d <_main+0x225>
  800249:	83 ec 04             	sub    $0x4,%esp
  80024c:	68 c0 21 80 00       	push   $0x8021c0
  800251:	6a 21                	push   $0x21
  800253:	68 08 22 80 00       	push   $0x802208
  800258:	e8 7a 05 00 00       	call   8007d7 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80025d:	a1 20 30 80 00       	mov    0x803020,%eax
  800262:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800268:	05 c8 00 00 00       	add    $0xc8,%eax
  80026d:	8b 00                	mov    (%eax),%eax
  80026f:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800272:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800275:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80027a:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80027f:	74 14                	je     800295 <_main+0x25d>
  800281:	83 ec 04             	sub    $0x4,%esp
  800284:	68 c0 21 80 00       	push   $0x8021c0
  800289:	6a 22                	push   $0x22
  80028b:	68 08 22 80 00       	push   $0x802208
  800290:	e8 42 05 00 00       	call   8007d7 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review sizes of the two WS's..!!");
  800295:	a1 20 30 80 00       	mov    0x803020,%eax
  80029a:	8b 80 80 52 00 00    	mov    0x5280(%eax),%eax
  8002a0:	85 c0                	test   %eax,%eax
  8002a2:	74 14                	je     8002b8 <_main+0x280>
  8002a4:	83 ec 04             	sub    $0x4,%esp
  8002a7:	68 24 22 80 00       	push   $0x802224
  8002ac:	6a 23                	push   $0x23
  8002ae:	68 08 22 80 00       	push   $0x802208
  8002b3:	e8 1f 05 00 00       	call   8007d7 <_panic>
	}

	int initModBufCnt = sys_calculate_modified_frames();
  8002b8:	e8 e0 16 00 00       	call   80199d <sys_calculate_modified_frames>
  8002bd:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int initFreeBufCnt = sys_calculate_notmod_frames();
  8002c0:	e8 f1 16 00 00       	call   8019b6 <sys_calculate_notmod_frames>
  8002c5:	89 45 a8             	mov    %eax,-0x58(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002c8:	e8 3a 17 00 00       	call   801a07 <sys_pf_calculate_allocated_pages>
  8002cd:	89 45 a4             	mov    %eax,-0x5c(%ebp)

	//[1]Bring 7 pages and modify them (7 unmodified will be buffered)
	int i=0;
  8002d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int dstSum1 = 0;
  8002d7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	int dummy = 0;
  8002de:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	for(i=(PAGE_SIZE/4);i<arrSize;i+=PAGE_SIZE/4)
  8002e5:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
  8002ec:	eb 33                	jmp    800321 <_main+0x2e9>
	{
		dst[i] = i;
  8002ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002f4:	89 14 85 00 31 80 00 	mov    %edx,0x803100(,%eax,4)
		dstSum1 += i;
  8002fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002fe:	01 45 f0             	add    %eax,-0x10(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  800301:	e8 b0 16 00 00       	call   8019b6 <sys_calculate_notmod_frames>
  800306:	89 c2                	mov    %eax,%edx
  800308:	a1 20 30 80 00       	mov    0x803020,%eax
  80030d:	8b 40 4c             	mov    0x4c(%eax),%eax
  800310:	01 c2                	add    %eax,%edx
  800312:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800315:	01 d0                	add    %edx,%eax
  800317:	89 45 ec             	mov    %eax,-0x14(%ebp)

	//[1]Bring 7 pages and modify them (7 unmodified will be buffered)
	int i=0;
	int dstSum1 = 0;
	int dummy = 0;
	for(i=(PAGE_SIZE/4);i<arrSize;i+=PAGE_SIZE/4)
  80031a:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  800321:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800328:	7e c4                	jle    8002ee <_main+0x2b6>
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}



	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  80032a:	e8 87 16 00 00       	call   8019b6 <sys_calculate_notmod_frames>
  80032f:	89 c2                	mov    %eax,%edx
  800331:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800334:	29 c2                	sub    %eax,%edx
  800336:	89 d0                	mov    %edx,%eax
  800338:	83 f8 07             	cmp    $0x7,%eax
  80033b:	74 14                	je     800351 <_main+0x319>
  80033d:	83 ec 04             	sub    $0x4,%esp
  800340:	68 74 22 80 00       	push   $0x802274
  800345:	6a 37                	push   $0x37
  800347:	68 08 22 80 00       	push   $0x802208
  80034c:	e8 86 04 00 00       	call   8007d7 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 0)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800351:	e8 47 16 00 00       	call   80199d <sys_calculate_modified_frames>
  800356:	89 c2                	mov    %eax,%edx
  800358:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80035b:	39 c2                	cmp    %eax,%edx
  80035d:	74 14                	je     800373 <_main+0x33b>
  80035f:	83 ec 04             	sub    $0x4,%esp
  800362:	68 d8 22 80 00       	push   $0x8022d8
  800367:	6a 38                	push   $0x38
  800369:	68 08 22 80 00       	push   $0x802208
  80036e:	e8 64 04 00 00       	call   8007d7 <_panic>

	initFreeBufCnt = sys_calculate_notmod_frames();
  800373:	e8 3e 16 00 00       	call   8019b6 <sys_calculate_notmod_frames>
  800378:	89 45 a8             	mov    %eax,-0x58(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  80037b:	e8 1d 16 00 00       	call   80199d <sys_calculate_modified_frames>
  800380:	89 45 ac             	mov    %eax,-0x54(%ebp)

	//[2]Bring 7 unmodified pages (7 modified will be buffered)
	int srcSum1 = 0 ;
  800383:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	i = PAGE_SIZE/4;
  80038a:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
	for(;i<arrSize;i+=PAGE_SIZE/4)
  800391:	eb 2d                	jmp    8003c0 <_main+0x388>
	{
		srcSum1 += src[i];
  800393:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800396:	8b 04 85 20 b1 80 00 	mov    0x80b120(,%eax,4),%eax
  80039d:	01 45 e8             	add    %eax,-0x18(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8003a0:	e8 11 16 00 00       	call   8019b6 <sys_calculate_notmod_frames>
  8003a5:	89 c2                	mov    %eax,%edx
  8003a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ac:	8b 40 4c             	mov    0x4c(%eax),%eax
  8003af:	01 c2                	add    %eax,%edx
  8003b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003b4:	01 d0                	add    %edx,%eax
  8003b6:	89 45 ec             	mov    %eax,-0x14(%ebp)
	initModBufCnt = sys_calculate_modified_frames();

	//[2]Bring 7 unmodified pages (7 modified will be buffered)
	int srcSum1 = 0 ;
	i = PAGE_SIZE/4;
	for(;i<arrSize;i+=PAGE_SIZE/4)
  8003b9:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  8003c0:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  8003c7:	7e ca                	jle    800393 <_main+0x35b>
		srcSum1 += src[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}

	//cprintf("sys_calculate_notmod_frames()  - initFreeBufCnt = %d\n", sys_calculate_notmod_frames()  - initFreeBufCnt);
	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 0)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  8003c9:	e8 e8 15 00 00       	call   8019b6 <sys_calculate_notmod_frames>
  8003ce:	89 c2                	mov    %eax,%edx
  8003d0:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003d3:	39 c2                	cmp    %eax,%edx
  8003d5:	74 14                	je     8003eb <_main+0x3b3>
  8003d7:	83 ec 04             	sub    $0x4,%esp
  8003da:	68 74 22 80 00       	push   $0x802274
  8003df:	6a 47                	push   $0x47
  8003e1:	68 08 22 80 00       	push   $0x802208
  8003e6:	e8 ec 03 00 00       	call   8007d7 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  8003eb:	e8 ad 15 00 00       	call   80199d <sys_calculate_modified_frames>
  8003f0:	89 c2                	mov    %eax,%edx
  8003f2:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8003f5:	29 c2                	sub    %eax,%edx
  8003f7:	89 d0                	mov    %edx,%eax
  8003f9:	83 f8 07             	cmp    $0x7,%eax
  8003fc:	74 14                	je     800412 <_main+0x3da>
  8003fe:	83 ec 04             	sub    $0x4,%esp
  800401:	68 d8 22 80 00       	push   $0x8022d8
  800406:	6a 48                	push   $0x48
  800408:	68 08 22 80 00       	push   $0x802208
  80040d:	e8 c5 03 00 00       	call   8007d7 <_panic>
	initFreeBufCnt = sys_calculate_notmod_frames();
  800412:	e8 9f 15 00 00       	call   8019b6 <sys_calculate_notmod_frames>
  800417:	89 45 a8             	mov    %eax,-0x58(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  80041a:	e8 7e 15 00 00       	call   80199d <sys_calculate_modified_frames>
  80041f:	89 45 ac             	mov    %eax,-0x54(%ebp)

	//[3]Bring the 7 modified pages again and ensure their values are correct (7 unmodified will be buffered)

	i = 0;
  800422:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int dstSum2 = 0 ;
  800429:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  800430:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
  800437:	eb 2d                	jmp    800466 <_main+0x42e>
	{
		dstSum2 += dst[i];
  800439:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80043c:	8b 04 85 00 31 80 00 	mov    0x803100(,%eax,4),%eax
  800443:	01 45 e4             	add    %eax,-0x1c(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  800446:	e8 6b 15 00 00       	call   8019b6 <sys_calculate_notmod_frames>
  80044b:	89 c2                	mov    %eax,%edx
  80044d:	a1 20 30 80 00       	mov    0x803020,%eax
  800452:	8b 40 4c             	mov    0x4c(%eax),%eax
  800455:	01 c2                	add    %eax,%edx
  800457:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80045a:	01 d0                	add    %edx,%eax
  80045c:	89 45 ec             	mov    %eax,-0x14(%ebp)

	//[3]Bring the 7 modified pages again and ensure their values are correct (7 unmodified will be buffered)

	i = 0;
	int dstSum2 = 0 ;
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  80045f:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  800466:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  80046d:	7e ca                	jle    800439 <_main+0x401>
	{
		dstSum2 += dst[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  80046f:	e8 42 15 00 00       	call   8019b6 <sys_calculate_notmod_frames>
  800474:	89 c2                	mov    %eax,%edx
  800476:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800479:	29 c2                	sub    %eax,%edx
  80047b:	89 d0                	mov    %edx,%eax
  80047d:	83 f8 07             	cmp    $0x7,%eax
  800480:	74 14                	je     800496 <_main+0x45e>
  800482:	83 ec 04             	sub    $0x4,%esp
  800485:	68 74 22 80 00       	push   $0x802274
  80048a:	6a 56                	push   $0x56
  80048c:	68 08 22 80 00       	push   $0x802208
  800491:	e8 41 03 00 00       	call   8007d7 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != -7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800496:	e8 02 15 00 00       	call   80199d <sys_calculate_modified_frames>
  80049b:	89 c2                	mov    %eax,%edx
  80049d:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8004a0:	29 c2                	sub    %eax,%edx
  8004a2:	89 d0                	mov    %edx,%eax
  8004a4:	83 f8 f9             	cmp    $0xfffffff9,%eax
  8004a7:	74 14                	je     8004bd <_main+0x485>
  8004a9:	83 ec 04             	sub    $0x4,%esp
  8004ac:	68 d8 22 80 00       	push   $0x8022d8
  8004b1:	6a 57                	push   $0x57
  8004b3:	68 08 22 80 00       	push   $0x802208
  8004b8:	e8 1a 03 00 00       	call   8007d7 <_panic>

	initFreeBufCnt = sys_calculate_notmod_frames();
  8004bd:	e8 f4 14 00 00       	call   8019b6 <sys_calculate_notmod_frames>
  8004c2:	89 45 a8             	mov    %eax,-0x58(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  8004c5:	e8 d3 14 00 00       	call   80199d <sys_calculate_modified_frames>
  8004ca:	89 45 ac             	mov    %eax,-0x54(%ebp)

	//[4]Bring the 7 unmodified pages again and ensure their values are correct (7 modified will be buffered)
	i = 0;
  8004cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int srcSum2 = 0 ;
  8004d4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  8004db:	c7 45 f4 00 04 00 00 	movl   $0x400,-0xc(%ebp)
  8004e2:	eb 2d                	jmp    800511 <_main+0x4d9>
	{
		srcSum2 += src[i];
  8004e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004e7:	8b 04 85 20 b1 80 00 	mov    0x80b120(,%eax,4),%eax
  8004ee:	01 45 e0             	add    %eax,-0x20(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8004f1:	e8 c0 14 00 00       	call   8019b6 <sys_calculate_notmod_frames>
  8004f6:	89 c2                	mov    %eax,%edx
  8004f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8004fd:	8b 40 4c             	mov    0x4c(%eax),%eax
  800500:	01 c2                	add    %eax,%edx
  800502:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800505:	01 d0                	add    %edx,%eax
  800507:	89 45 ec             	mov    %eax,-0x14(%ebp)
	initModBufCnt = sys_calculate_modified_frames();

	//[4]Bring the 7 unmodified pages again and ensure their values are correct (7 modified will be buffered)
	i = 0;
	int srcSum2 = 0 ;
	for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  80050a:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  800511:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800518:	7e ca                	jle    8004e4 <_main+0x4ac>
	{
		srcSum2 += src[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != -7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  80051a:	e8 97 14 00 00       	call   8019b6 <sys_calculate_notmod_frames>
  80051f:	89 c2                	mov    %eax,%edx
  800521:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800524:	29 c2                	sub    %eax,%edx
  800526:	89 d0                	mov    %edx,%eax
  800528:	83 f8 f9             	cmp    $0xfffffff9,%eax
  80052b:	74 14                	je     800541 <_main+0x509>
  80052d:	83 ec 04             	sub    $0x4,%esp
  800530:	68 74 22 80 00       	push   $0x802274
  800535:	6a 65                	push   $0x65
  800537:	68 08 22 80 00       	push   $0x802208
  80053c:	e8 96 02 00 00       	call   8007d7 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800541:	e8 57 14 00 00       	call   80199d <sys_calculate_modified_frames>
  800546:	89 c2                	mov    %eax,%edx
  800548:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80054b:	29 c2                	sub    %eax,%edx
  80054d:	89 d0                	mov    %edx,%eax
  80054f:	83 f8 07             	cmp    $0x7,%eax
  800552:	74 14                	je     800568 <_main+0x530>
  800554:	83 ec 04             	sub    $0x4,%esp
  800557:	68 d8 22 80 00       	push   $0x8022d8
  80055c:	6a 66                	push   $0x66
  80055e:	68 08 22 80 00       	push   $0x802208
  800563:	e8 6f 02 00 00       	call   8007d7 <_panic>

	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add any new page to the page file");
  800568:	e8 9a 14 00 00       	call   801a07 <sys_pf_calculate_allocated_pages>
  80056d:	3b 45 a4             	cmp    -0x5c(%ebp),%eax
  800570:	74 14                	je     800586 <_main+0x54e>
  800572:	83 ec 04             	sub    $0x4,%esp
  800575:	68 44 23 80 00       	push   $0x802344
  80057a:	6a 68                	push   $0x68
  80057c:	68 08 22 80 00       	push   $0x802208
  800581:	e8 51 02 00 00       	call   8007d7 <_panic>

	if (srcSum1 != srcSum2 || dstSum1 != dstSum2) 	panic("Error in buffering/restoring modified/not modified pages") ;
  800586:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800589:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80058c:	75 08                	jne    800596 <_main+0x55e>
  80058e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800591:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800594:	74 14                	je     8005aa <_main+0x572>
  800596:	83 ec 04             	sub    $0x4,%esp
  800599:	68 b4 23 80 00       	push   $0x8023b4
  80059e:	6a 6a                	push   $0x6a
  8005a0:	68 08 22 80 00       	push   $0x802208
  8005a5:	e8 2d 02 00 00       	call   8007d7 <_panic>

	/*[5] BUSY-WAIT FOR A WHILE TILL FINISHING THE MASTER PROGRAM */
	env_sleep(5000);
  8005aa:	83 ec 0c             	sub    $0xc,%esp
  8005ad:	68 88 13 00 00       	push   $0x1388
  8005b2:	e8 da 18 00 00       	call   801e91 <env_sleep>
  8005b7:	83 c4 10             	add    $0x10,%esp

	/*[6] Read the modified pages of this slave program (after they have been written on page file) */
	initFreeBufCnt = sys_calculate_notmod_frames();
  8005ba:	e8 f7 13 00 00       	call   8019b6 <sys_calculate_notmod_frames>
  8005bf:	89 45 a8             	mov    %eax,-0x58(%ebp)
	initModBufCnt = sys_calculate_modified_frames();
  8005c2:	e8 d6 13 00 00       	call   80199d <sys_calculate_modified_frames>
  8005c7:	89 45 ac             	mov    %eax,-0x54(%ebp)
	i = 0;
  8005ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int dstSum3 = 0 ;
  8005d1:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	dummy = 0;
  8005d8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	for(i=0;i<arrSize;i+=PAGE_SIZE/4)
  8005df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8005e6:	eb 2d                	jmp    800615 <_main+0x5dd>
	{
		dstSum3 += dst[i];
  8005e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005eb:	8b 04 85 00 31 80 00 	mov    0x803100(,%eax,4),%eax
  8005f2:	01 45 dc             	add    %eax,-0x24(%ebp)
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
  8005f5:	e8 bc 13 00 00       	call   8019b6 <sys_calculate_notmod_frames>
  8005fa:	89 c2                	mov    %eax,%edx
  8005fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800601:	8b 40 4c             	mov    0x4c(%eax),%eax
  800604:	01 c2                	add    %eax,%edx
  800606:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800609:	01 d0                	add    %edx,%eax
  80060b:	89 45 ec             	mov    %eax,-0x14(%ebp)
	initFreeBufCnt = sys_calculate_notmod_frames();
	initModBufCnt = sys_calculate_modified_frames();
	i = 0;
	int dstSum3 = 0 ;
	dummy = 0;
	for(i=0;i<arrSize;i+=PAGE_SIZE/4)
  80060e:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  800615:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  80061c:	7e ca                	jle    8005e8 <_main+0x5b0>
	{
		dstSum3 += dst[i];
		dummy += sys_calculate_notmod_frames() + myEnv->env_id;	//Always use page #: 800000, 801000, 803000
	}

	if (sys_calculate_notmod_frames()  - initFreeBufCnt != 0)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  80061e:	e8 93 13 00 00       	call   8019b6 <sys_calculate_notmod_frames>
  800623:	89 c2                	mov    %eax,%edx
  800625:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800628:	39 c2                	cmp    %eax,%edx
  80062a:	74 14                	je     800640 <_main+0x608>
  80062c:	83 ec 04             	sub    $0x4,%esp
  80062f:	68 74 22 80 00       	push   $0x802274
  800634:	6a 7b                	push   $0x7b
  800636:	68 08 22 80 00       	push   $0x802208
  80063b:	e8 97 01 00 00       	call   8007d7 <_panic>
	if (sys_calculate_modified_frames() - initModBufCnt  != 0)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800640:	e8 58 13 00 00       	call   80199d <sys_calculate_modified_frames>
  800645:	89 c2                	mov    %eax,%edx
  800647:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80064a:	39 c2                	cmp    %eax,%edx
  80064c:	74 14                	je     800662 <_main+0x62a>
  80064e:	83 ec 04             	sub    $0x4,%esp
  800651:	68 d8 22 80 00       	push   $0x8022d8
  800656:	6a 7c                	push   $0x7c
  800658:	68 08 22 80 00       	push   $0x802208
  80065d:	e8 75 01 00 00       	call   8007d7 <_panic>

	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add any new page to the page file");
  800662:	e8 a0 13 00 00       	call   801a07 <sys_pf_calculate_allocated_pages>
  800667:	3b 45 a4             	cmp    -0x5c(%ebp),%eax
  80066a:	74 14                	je     800680 <_main+0x648>
  80066c:	83 ec 04             	sub    $0x4,%esp
  80066f:	68 44 23 80 00       	push   $0x802344
  800674:	6a 7e                	push   $0x7e
  800676:	68 08 22 80 00       	push   $0x802208
  80067b:	e8 57 01 00 00       	call   8007d7 <_panic>

	if (dstSum1 != dstSum3) 	panic("Error in buffering/restoring modified pages after freeing the modified list") ;
  800680:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800683:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800686:	74 17                	je     80069f <_main+0x667>
  800688:	83 ec 04             	sub    $0x4,%esp
  80068b:	68 f0 23 80 00       	push   $0x8023f0
  800690:	68 80 00 00 00       	push   $0x80
  800695:	68 08 22 80 00       	push   $0x802208
  80069a:	e8 38 01 00 00       	call   8007d7 <_panic>

	cprintf("Congratulations!! modified list is cleared and updated successfully.\n");
  80069f:	83 ec 0c             	sub    $0xc,%esp
  8006a2:	68 3c 24 80 00       	push   $0x80243c
  8006a7:	e8 e2 03 00 00       	call   800a8e <cprintf>
  8006ac:	83 c4 10             	add    $0x10,%esp

	return;
  8006af:	90                   	nop

}
  8006b0:	c9                   	leave  
  8006b1:	c3                   	ret    

008006b2 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8006b2:	55                   	push   %ebp
  8006b3:	89 e5                	mov    %esp,%ebp
  8006b5:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8006b8:	e8 fc 11 00 00       	call   8018b9 <sys_getenvindex>
  8006bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8006c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006c3:	89 d0                	mov    %edx,%eax
  8006c5:	c1 e0 03             	shl    $0x3,%eax
  8006c8:	01 d0                	add    %edx,%eax
  8006ca:	c1 e0 02             	shl    $0x2,%eax
  8006cd:	01 d0                	add    %edx,%eax
  8006cf:	c1 e0 06             	shl    $0x6,%eax
  8006d2:	29 d0                	sub    %edx,%eax
  8006d4:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8006db:	01 c8                	add    %ecx,%eax
  8006dd:	01 d0                	add    %edx,%eax
  8006df:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8006e4:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8006e9:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ee:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  8006f4:	84 c0                	test   %al,%al
  8006f6:	74 0f                	je     800707 <libmain+0x55>
		binaryname = myEnv->prog_name;
  8006f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8006fd:	05 b0 52 00 00       	add    $0x52b0,%eax
  800702:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800707:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80070b:	7e 0a                	jle    800717 <libmain+0x65>
		binaryname = argv[0];
  80070d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800710:	8b 00                	mov    (%eax),%eax
  800712:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800717:	83 ec 08             	sub    $0x8,%esp
  80071a:	ff 75 0c             	pushl  0xc(%ebp)
  80071d:	ff 75 08             	pushl  0x8(%ebp)
  800720:	e8 13 f9 ff ff       	call   800038 <_main>
  800725:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800728:	e8 27 13 00 00       	call   801a54 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80072d:	83 ec 0c             	sub    $0xc,%esp
  800730:	68 9c 24 80 00       	push   $0x80249c
  800735:	e8 54 03 00 00       	call   800a8e <cprintf>
  80073a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80073d:	a1 20 30 80 00       	mov    0x803020,%eax
  800742:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  800748:	a1 20 30 80 00       	mov    0x803020,%eax
  80074d:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  800753:	83 ec 04             	sub    $0x4,%esp
  800756:	52                   	push   %edx
  800757:	50                   	push   %eax
  800758:	68 c4 24 80 00       	push   $0x8024c4
  80075d:	e8 2c 03 00 00       	call   800a8e <cprintf>
  800762:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800765:	a1 20 30 80 00       	mov    0x803020,%eax
  80076a:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  800770:	a1 20 30 80 00       	mov    0x803020,%eax
  800775:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  80077b:	a1 20 30 80 00       	mov    0x803020,%eax
  800780:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  800786:	51                   	push   %ecx
  800787:	52                   	push   %edx
  800788:	50                   	push   %eax
  800789:	68 ec 24 80 00       	push   $0x8024ec
  80078e:	e8 fb 02 00 00       	call   800a8e <cprintf>
  800793:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800796:	83 ec 0c             	sub    $0xc,%esp
  800799:	68 9c 24 80 00       	push   $0x80249c
  80079e:	e8 eb 02 00 00       	call   800a8e <cprintf>
  8007a3:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007a6:	e8 c3 12 00 00       	call   801a6e <sys_enable_interrupt>

	// exit gracefully
	exit();
  8007ab:	e8 19 00 00 00       	call   8007c9 <exit>
}
  8007b0:	90                   	nop
  8007b1:	c9                   	leave  
  8007b2:	c3                   	ret    

008007b3 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8007b3:	55                   	push   %ebp
  8007b4:	89 e5                	mov    %esp,%ebp
  8007b6:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8007b9:	83 ec 0c             	sub    $0xc,%esp
  8007bc:	6a 00                	push   $0x0
  8007be:	e8 c2 10 00 00       	call   801885 <sys_env_destroy>
  8007c3:	83 c4 10             	add    $0x10,%esp
}
  8007c6:	90                   	nop
  8007c7:	c9                   	leave  
  8007c8:	c3                   	ret    

008007c9 <exit>:

void
exit(void)
{
  8007c9:	55                   	push   %ebp
  8007ca:	89 e5                	mov    %esp,%ebp
  8007cc:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8007cf:	e8 17 11 00 00       	call   8018eb <sys_env_exit>
}
  8007d4:	90                   	nop
  8007d5:	c9                   	leave  
  8007d6:	c3                   	ret    

008007d7 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8007d7:	55                   	push   %ebp
  8007d8:	89 e5                	mov    %esp,%ebp
  8007da:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8007dd:	8d 45 10             	lea    0x10(%ebp),%eax
  8007e0:	83 c0 04             	add    $0x4,%eax
  8007e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8007e6:	a1 24 31 81 00       	mov    0x813124,%eax
  8007eb:	85 c0                	test   %eax,%eax
  8007ed:	74 16                	je     800805 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8007ef:	a1 24 31 81 00       	mov    0x813124,%eax
  8007f4:	83 ec 08             	sub    $0x8,%esp
  8007f7:	50                   	push   %eax
  8007f8:	68 44 25 80 00       	push   $0x802544
  8007fd:	e8 8c 02 00 00       	call   800a8e <cprintf>
  800802:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800805:	a1 00 30 80 00       	mov    0x803000,%eax
  80080a:	ff 75 0c             	pushl  0xc(%ebp)
  80080d:	ff 75 08             	pushl  0x8(%ebp)
  800810:	50                   	push   %eax
  800811:	68 49 25 80 00       	push   $0x802549
  800816:	e8 73 02 00 00       	call   800a8e <cprintf>
  80081b:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80081e:	8b 45 10             	mov    0x10(%ebp),%eax
  800821:	83 ec 08             	sub    $0x8,%esp
  800824:	ff 75 f4             	pushl  -0xc(%ebp)
  800827:	50                   	push   %eax
  800828:	e8 f6 01 00 00       	call   800a23 <vcprintf>
  80082d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800830:	83 ec 08             	sub    $0x8,%esp
  800833:	6a 00                	push   $0x0
  800835:	68 65 25 80 00       	push   $0x802565
  80083a:	e8 e4 01 00 00       	call   800a23 <vcprintf>
  80083f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800842:	e8 82 ff ff ff       	call   8007c9 <exit>

	// should not return here
	while (1) ;
  800847:	eb fe                	jmp    800847 <_panic+0x70>

00800849 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800849:	55                   	push   %ebp
  80084a:	89 e5                	mov    %esp,%ebp
  80084c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80084f:	a1 20 30 80 00       	mov    0x803020,%eax
  800854:	8b 50 74             	mov    0x74(%eax),%edx
  800857:	8b 45 0c             	mov    0xc(%ebp),%eax
  80085a:	39 c2                	cmp    %eax,%edx
  80085c:	74 14                	je     800872 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80085e:	83 ec 04             	sub    $0x4,%esp
  800861:	68 68 25 80 00       	push   $0x802568
  800866:	6a 26                	push   $0x26
  800868:	68 b4 25 80 00       	push   $0x8025b4
  80086d:	e8 65 ff ff ff       	call   8007d7 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800872:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800879:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800880:	e9 c4 00 00 00       	jmp    800949 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800885:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800888:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80088f:	8b 45 08             	mov    0x8(%ebp),%eax
  800892:	01 d0                	add    %edx,%eax
  800894:	8b 00                	mov    (%eax),%eax
  800896:	85 c0                	test   %eax,%eax
  800898:	75 08                	jne    8008a2 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80089a:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80089d:	e9 a4 00 00 00       	jmp    800946 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8008a2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008a9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8008b0:	eb 6b                	jmp    80091d <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8008b2:	a1 20 30 80 00       	mov    0x803020,%eax
  8008b7:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8008bd:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008c0:	89 d0                	mov    %edx,%eax
  8008c2:	c1 e0 02             	shl    $0x2,%eax
  8008c5:	01 d0                	add    %edx,%eax
  8008c7:	c1 e0 02             	shl    $0x2,%eax
  8008ca:	01 c8                	add    %ecx,%eax
  8008cc:	8a 40 04             	mov    0x4(%eax),%al
  8008cf:	84 c0                	test   %al,%al
  8008d1:	75 47                	jne    80091a <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8008d8:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8008de:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008e1:	89 d0                	mov    %edx,%eax
  8008e3:	c1 e0 02             	shl    $0x2,%eax
  8008e6:	01 d0                	add    %edx,%eax
  8008e8:	c1 e0 02             	shl    $0x2,%eax
  8008eb:	01 c8                	add    %ecx,%eax
  8008ed:	8b 00                	mov    (%eax),%eax
  8008ef:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8008f2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008f5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8008fa:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8008fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008ff:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800906:	8b 45 08             	mov    0x8(%ebp),%eax
  800909:	01 c8                	add    %ecx,%eax
  80090b:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80090d:	39 c2                	cmp    %eax,%edx
  80090f:	75 09                	jne    80091a <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  800911:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800918:	eb 12                	jmp    80092c <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80091a:	ff 45 e8             	incl   -0x18(%ebp)
  80091d:	a1 20 30 80 00       	mov    0x803020,%eax
  800922:	8b 50 74             	mov    0x74(%eax),%edx
  800925:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800928:	39 c2                	cmp    %eax,%edx
  80092a:	77 86                	ja     8008b2 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80092c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800930:	75 14                	jne    800946 <CheckWSWithoutLastIndex+0xfd>
			panic(
  800932:	83 ec 04             	sub    $0x4,%esp
  800935:	68 c0 25 80 00       	push   $0x8025c0
  80093a:	6a 3a                	push   $0x3a
  80093c:	68 b4 25 80 00       	push   $0x8025b4
  800941:	e8 91 fe ff ff       	call   8007d7 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800946:	ff 45 f0             	incl   -0x10(%ebp)
  800949:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80094c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80094f:	0f 8c 30 ff ff ff    	jl     800885 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800955:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80095c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800963:	eb 27                	jmp    80098c <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800965:	a1 20 30 80 00       	mov    0x803020,%eax
  80096a:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  800970:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800973:	89 d0                	mov    %edx,%eax
  800975:	c1 e0 02             	shl    $0x2,%eax
  800978:	01 d0                	add    %edx,%eax
  80097a:	c1 e0 02             	shl    $0x2,%eax
  80097d:	01 c8                	add    %ecx,%eax
  80097f:	8a 40 04             	mov    0x4(%eax),%al
  800982:	3c 01                	cmp    $0x1,%al
  800984:	75 03                	jne    800989 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800986:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800989:	ff 45 e0             	incl   -0x20(%ebp)
  80098c:	a1 20 30 80 00       	mov    0x803020,%eax
  800991:	8b 50 74             	mov    0x74(%eax),%edx
  800994:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800997:	39 c2                	cmp    %eax,%edx
  800999:	77 ca                	ja     800965 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80099b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80099e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8009a1:	74 14                	je     8009b7 <CheckWSWithoutLastIndex+0x16e>
		panic(
  8009a3:	83 ec 04             	sub    $0x4,%esp
  8009a6:	68 14 26 80 00       	push   $0x802614
  8009ab:	6a 44                	push   $0x44
  8009ad:	68 b4 25 80 00       	push   $0x8025b4
  8009b2:	e8 20 fe ff ff       	call   8007d7 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8009b7:	90                   	nop
  8009b8:	c9                   	leave  
  8009b9:	c3                   	ret    

008009ba <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8009ba:	55                   	push   %ebp
  8009bb:	89 e5                	mov    %esp,%ebp
  8009bd:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8009c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c3:	8b 00                	mov    (%eax),%eax
  8009c5:	8d 48 01             	lea    0x1(%eax),%ecx
  8009c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009cb:	89 0a                	mov    %ecx,(%edx)
  8009cd:	8b 55 08             	mov    0x8(%ebp),%edx
  8009d0:	88 d1                	mov    %dl,%cl
  8009d2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009d5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009dc:	8b 00                	mov    (%eax),%eax
  8009de:	3d ff 00 00 00       	cmp    $0xff,%eax
  8009e3:	75 2c                	jne    800a11 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8009e5:	a0 24 30 80 00       	mov    0x803024,%al
  8009ea:	0f b6 c0             	movzbl %al,%eax
  8009ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009f0:	8b 12                	mov    (%edx),%edx
  8009f2:	89 d1                	mov    %edx,%ecx
  8009f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009f7:	83 c2 08             	add    $0x8,%edx
  8009fa:	83 ec 04             	sub    $0x4,%esp
  8009fd:	50                   	push   %eax
  8009fe:	51                   	push   %ecx
  8009ff:	52                   	push   %edx
  800a00:	e8 3e 0e 00 00       	call   801843 <sys_cputs>
  800a05:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a08:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a0b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a11:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a14:	8b 40 04             	mov    0x4(%eax),%eax
  800a17:	8d 50 01             	lea    0x1(%eax),%edx
  800a1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a1d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a20:	90                   	nop
  800a21:	c9                   	leave  
  800a22:	c3                   	ret    

00800a23 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a23:	55                   	push   %ebp
  800a24:	89 e5                	mov    %esp,%ebp
  800a26:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a2c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a33:	00 00 00 
	b.cnt = 0;
  800a36:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a3d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a40:	ff 75 0c             	pushl  0xc(%ebp)
  800a43:	ff 75 08             	pushl  0x8(%ebp)
  800a46:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a4c:	50                   	push   %eax
  800a4d:	68 ba 09 80 00       	push   $0x8009ba
  800a52:	e8 11 02 00 00       	call   800c68 <vprintfmt>
  800a57:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a5a:	a0 24 30 80 00       	mov    0x803024,%al
  800a5f:	0f b6 c0             	movzbl %al,%eax
  800a62:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a68:	83 ec 04             	sub    $0x4,%esp
  800a6b:	50                   	push   %eax
  800a6c:	52                   	push   %edx
  800a6d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a73:	83 c0 08             	add    $0x8,%eax
  800a76:	50                   	push   %eax
  800a77:	e8 c7 0d 00 00       	call   801843 <sys_cputs>
  800a7c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a7f:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800a86:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a8c:	c9                   	leave  
  800a8d:	c3                   	ret    

00800a8e <cprintf>:

int cprintf(const char *fmt, ...) {
  800a8e:	55                   	push   %ebp
  800a8f:	89 e5                	mov    %esp,%ebp
  800a91:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a94:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800a9b:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800aa1:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa4:	83 ec 08             	sub    $0x8,%esp
  800aa7:	ff 75 f4             	pushl  -0xc(%ebp)
  800aaa:	50                   	push   %eax
  800aab:	e8 73 ff ff ff       	call   800a23 <vcprintf>
  800ab0:	83 c4 10             	add    $0x10,%esp
  800ab3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800ab6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ab9:	c9                   	leave  
  800aba:	c3                   	ret    

00800abb <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800abb:	55                   	push   %ebp
  800abc:	89 e5                	mov    %esp,%ebp
  800abe:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800ac1:	e8 8e 0f 00 00       	call   801a54 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800ac6:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ac9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800acc:	8b 45 08             	mov    0x8(%ebp),%eax
  800acf:	83 ec 08             	sub    $0x8,%esp
  800ad2:	ff 75 f4             	pushl  -0xc(%ebp)
  800ad5:	50                   	push   %eax
  800ad6:	e8 48 ff ff ff       	call   800a23 <vcprintf>
  800adb:	83 c4 10             	add    $0x10,%esp
  800ade:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800ae1:	e8 88 0f 00 00       	call   801a6e <sys_enable_interrupt>
	return cnt;
  800ae6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ae9:	c9                   	leave  
  800aea:	c3                   	ret    

00800aeb <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800aeb:	55                   	push   %ebp
  800aec:	89 e5                	mov    %esp,%ebp
  800aee:	53                   	push   %ebx
  800aef:	83 ec 14             	sub    $0x14,%esp
  800af2:	8b 45 10             	mov    0x10(%ebp),%eax
  800af5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800af8:	8b 45 14             	mov    0x14(%ebp),%eax
  800afb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800afe:	8b 45 18             	mov    0x18(%ebp),%eax
  800b01:	ba 00 00 00 00       	mov    $0x0,%edx
  800b06:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b09:	77 55                	ja     800b60 <printnum+0x75>
  800b0b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b0e:	72 05                	jb     800b15 <printnum+0x2a>
  800b10:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b13:	77 4b                	ja     800b60 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800b15:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b18:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800b1b:	8b 45 18             	mov    0x18(%ebp),%eax
  800b1e:	ba 00 00 00 00       	mov    $0x0,%edx
  800b23:	52                   	push   %edx
  800b24:	50                   	push   %eax
  800b25:	ff 75 f4             	pushl  -0xc(%ebp)
  800b28:	ff 75 f0             	pushl  -0x10(%ebp)
  800b2b:	e8 18 14 00 00       	call   801f48 <__udivdi3>
  800b30:	83 c4 10             	add    $0x10,%esp
  800b33:	83 ec 04             	sub    $0x4,%esp
  800b36:	ff 75 20             	pushl  0x20(%ebp)
  800b39:	53                   	push   %ebx
  800b3a:	ff 75 18             	pushl  0x18(%ebp)
  800b3d:	52                   	push   %edx
  800b3e:	50                   	push   %eax
  800b3f:	ff 75 0c             	pushl  0xc(%ebp)
  800b42:	ff 75 08             	pushl  0x8(%ebp)
  800b45:	e8 a1 ff ff ff       	call   800aeb <printnum>
  800b4a:	83 c4 20             	add    $0x20,%esp
  800b4d:	eb 1a                	jmp    800b69 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b4f:	83 ec 08             	sub    $0x8,%esp
  800b52:	ff 75 0c             	pushl  0xc(%ebp)
  800b55:	ff 75 20             	pushl  0x20(%ebp)
  800b58:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5b:	ff d0                	call   *%eax
  800b5d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b60:	ff 4d 1c             	decl   0x1c(%ebp)
  800b63:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b67:	7f e6                	jg     800b4f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b69:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b6c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b71:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b74:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b77:	53                   	push   %ebx
  800b78:	51                   	push   %ecx
  800b79:	52                   	push   %edx
  800b7a:	50                   	push   %eax
  800b7b:	e8 d8 14 00 00       	call   802058 <__umoddi3>
  800b80:	83 c4 10             	add    $0x10,%esp
  800b83:	05 74 28 80 00       	add    $0x802874,%eax
  800b88:	8a 00                	mov    (%eax),%al
  800b8a:	0f be c0             	movsbl %al,%eax
  800b8d:	83 ec 08             	sub    $0x8,%esp
  800b90:	ff 75 0c             	pushl  0xc(%ebp)
  800b93:	50                   	push   %eax
  800b94:	8b 45 08             	mov    0x8(%ebp),%eax
  800b97:	ff d0                	call   *%eax
  800b99:	83 c4 10             	add    $0x10,%esp
}
  800b9c:	90                   	nop
  800b9d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ba0:	c9                   	leave  
  800ba1:	c3                   	ret    

00800ba2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ba2:	55                   	push   %ebp
  800ba3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ba5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ba9:	7e 1c                	jle    800bc7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800bab:	8b 45 08             	mov    0x8(%ebp),%eax
  800bae:	8b 00                	mov    (%eax),%eax
  800bb0:	8d 50 08             	lea    0x8(%eax),%edx
  800bb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb6:	89 10                	mov    %edx,(%eax)
  800bb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbb:	8b 00                	mov    (%eax),%eax
  800bbd:	83 e8 08             	sub    $0x8,%eax
  800bc0:	8b 50 04             	mov    0x4(%eax),%edx
  800bc3:	8b 00                	mov    (%eax),%eax
  800bc5:	eb 40                	jmp    800c07 <getuint+0x65>
	else if (lflag)
  800bc7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bcb:	74 1e                	je     800beb <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800bcd:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd0:	8b 00                	mov    (%eax),%eax
  800bd2:	8d 50 04             	lea    0x4(%eax),%edx
  800bd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd8:	89 10                	mov    %edx,(%eax)
  800bda:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdd:	8b 00                	mov    (%eax),%eax
  800bdf:	83 e8 04             	sub    $0x4,%eax
  800be2:	8b 00                	mov    (%eax),%eax
  800be4:	ba 00 00 00 00       	mov    $0x0,%edx
  800be9:	eb 1c                	jmp    800c07 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800beb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bee:	8b 00                	mov    (%eax),%eax
  800bf0:	8d 50 04             	lea    0x4(%eax),%edx
  800bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf6:	89 10                	mov    %edx,(%eax)
  800bf8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfb:	8b 00                	mov    (%eax),%eax
  800bfd:	83 e8 04             	sub    $0x4,%eax
  800c00:	8b 00                	mov    (%eax),%eax
  800c02:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800c07:	5d                   	pop    %ebp
  800c08:	c3                   	ret    

00800c09 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800c09:	55                   	push   %ebp
  800c0a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c0c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c10:	7e 1c                	jle    800c2e <getint+0x25>
		return va_arg(*ap, long long);
  800c12:	8b 45 08             	mov    0x8(%ebp),%eax
  800c15:	8b 00                	mov    (%eax),%eax
  800c17:	8d 50 08             	lea    0x8(%eax),%edx
  800c1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1d:	89 10                	mov    %edx,(%eax)
  800c1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c22:	8b 00                	mov    (%eax),%eax
  800c24:	83 e8 08             	sub    $0x8,%eax
  800c27:	8b 50 04             	mov    0x4(%eax),%edx
  800c2a:	8b 00                	mov    (%eax),%eax
  800c2c:	eb 38                	jmp    800c66 <getint+0x5d>
	else if (lflag)
  800c2e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c32:	74 1a                	je     800c4e <getint+0x45>
		return va_arg(*ap, long);
  800c34:	8b 45 08             	mov    0x8(%ebp),%eax
  800c37:	8b 00                	mov    (%eax),%eax
  800c39:	8d 50 04             	lea    0x4(%eax),%edx
  800c3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3f:	89 10                	mov    %edx,(%eax)
  800c41:	8b 45 08             	mov    0x8(%ebp),%eax
  800c44:	8b 00                	mov    (%eax),%eax
  800c46:	83 e8 04             	sub    $0x4,%eax
  800c49:	8b 00                	mov    (%eax),%eax
  800c4b:	99                   	cltd   
  800c4c:	eb 18                	jmp    800c66 <getint+0x5d>
	else
		return va_arg(*ap, int);
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
}
  800c66:	5d                   	pop    %ebp
  800c67:	c3                   	ret    

00800c68 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c68:	55                   	push   %ebp
  800c69:	89 e5                	mov    %esp,%ebp
  800c6b:	56                   	push   %esi
  800c6c:	53                   	push   %ebx
  800c6d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c70:	eb 17                	jmp    800c89 <vprintfmt+0x21>
			if (ch == '\0')
  800c72:	85 db                	test   %ebx,%ebx
  800c74:	0f 84 af 03 00 00    	je     801029 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c7a:	83 ec 08             	sub    $0x8,%esp
  800c7d:	ff 75 0c             	pushl  0xc(%ebp)
  800c80:	53                   	push   %ebx
  800c81:	8b 45 08             	mov    0x8(%ebp),%eax
  800c84:	ff d0                	call   *%eax
  800c86:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c89:	8b 45 10             	mov    0x10(%ebp),%eax
  800c8c:	8d 50 01             	lea    0x1(%eax),%edx
  800c8f:	89 55 10             	mov    %edx,0x10(%ebp)
  800c92:	8a 00                	mov    (%eax),%al
  800c94:	0f b6 d8             	movzbl %al,%ebx
  800c97:	83 fb 25             	cmp    $0x25,%ebx
  800c9a:	75 d6                	jne    800c72 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c9c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800ca0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ca7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800cae:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800cb5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800cbc:	8b 45 10             	mov    0x10(%ebp),%eax
  800cbf:	8d 50 01             	lea    0x1(%eax),%edx
  800cc2:	89 55 10             	mov    %edx,0x10(%ebp)
  800cc5:	8a 00                	mov    (%eax),%al
  800cc7:	0f b6 d8             	movzbl %al,%ebx
  800cca:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800ccd:	83 f8 55             	cmp    $0x55,%eax
  800cd0:	0f 87 2b 03 00 00    	ja     801001 <vprintfmt+0x399>
  800cd6:	8b 04 85 98 28 80 00 	mov    0x802898(,%eax,4),%eax
  800cdd:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800cdf:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800ce3:	eb d7                	jmp    800cbc <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800ce5:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800ce9:	eb d1                	jmp    800cbc <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ceb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800cf2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800cf5:	89 d0                	mov    %edx,%eax
  800cf7:	c1 e0 02             	shl    $0x2,%eax
  800cfa:	01 d0                	add    %edx,%eax
  800cfc:	01 c0                	add    %eax,%eax
  800cfe:	01 d8                	add    %ebx,%eax
  800d00:	83 e8 30             	sub    $0x30,%eax
  800d03:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800d06:	8b 45 10             	mov    0x10(%ebp),%eax
  800d09:	8a 00                	mov    (%eax),%al
  800d0b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800d0e:	83 fb 2f             	cmp    $0x2f,%ebx
  800d11:	7e 3e                	jle    800d51 <vprintfmt+0xe9>
  800d13:	83 fb 39             	cmp    $0x39,%ebx
  800d16:	7f 39                	jg     800d51 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d18:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800d1b:	eb d5                	jmp    800cf2 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800d1d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d20:	83 c0 04             	add    $0x4,%eax
  800d23:	89 45 14             	mov    %eax,0x14(%ebp)
  800d26:	8b 45 14             	mov    0x14(%ebp),%eax
  800d29:	83 e8 04             	sub    $0x4,%eax
  800d2c:	8b 00                	mov    (%eax),%eax
  800d2e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d31:	eb 1f                	jmp    800d52 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d33:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d37:	79 83                	jns    800cbc <vprintfmt+0x54>
				width = 0;
  800d39:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d40:	e9 77 ff ff ff       	jmp    800cbc <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d45:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d4c:	e9 6b ff ff ff       	jmp    800cbc <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d51:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d52:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d56:	0f 89 60 ff ff ff    	jns    800cbc <vprintfmt+0x54>
				width = precision, precision = -1;
  800d5c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d5f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d62:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d69:	e9 4e ff ff ff       	jmp    800cbc <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d6e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d71:	e9 46 ff ff ff       	jmp    800cbc <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d76:	8b 45 14             	mov    0x14(%ebp),%eax
  800d79:	83 c0 04             	add    $0x4,%eax
  800d7c:	89 45 14             	mov    %eax,0x14(%ebp)
  800d7f:	8b 45 14             	mov    0x14(%ebp),%eax
  800d82:	83 e8 04             	sub    $0x4,%eax
  800d85:	8b 00                	mov    (%eax),%eax
  800d87:	83 ec 08             	sub    $0x8,%esp
  800d8a:	ff 75 0c             	pushl  0xc(%ebp)
  800d8d:	50                   	push   %eax
  800d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d91:	ff d0                	call   *%eax
  800d93:	83 c4 10             	add    $0x10,%esp
			break;
  800d96:	e9 89 02 00 00       	jmp    801024 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d9b:	8b 45 14             	mov    0x14(%ebp),%eax
  800d9e:	83 c0 04             	add    $0x4,%eax
  800da1:	89 45 14             	mov    %eax,0x14(%ebp)
  800da4:	8b 45 14             	mov    0x14(%ebp),%eax
  800da7:	83 e8 04             	sub    $0x4,%eax
  800daa:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800dac:	85 db                	test   %ebx,%ebx
  800dae:	79 02                	jns    800db2 <vprintfmt+0x14a>
				err = -err;
  800db0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800db2:	83 fb 64             	cmp    $0x64,%ebx
  800db5:	7f 0b                	jg     800dc2 <vprintfmt+0x15a>
  800db7:	8b 34 9d e0 26 80 00 	mov    0x8026e0(,%ebx,4),%esi
  800dbe:	85 f6                	test   %esi,%esi
  800dc0:	75 19                	jne    800ddb <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800dc2:	53                   	push   %ebx
  800dc3:	68 85 28 80 00       	push   $0x802885
  800dc8:	ff 75 0c             	pushl  0xc(%ebp)
  800dcb:	ff 75 08             	pushl  0x8(%ebp)
  800dce:	e8 5e 02 00 00       	call   801031 <printfmt>
  800dd3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800dd6:	e9 49 02 00 00       	jmp    801024 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ddb:	56                   	push   %esi
  800ddc:	68 8e 28 80 00       	push   $0x80288e
  800de1:	ff 75 0c             	pushl  0xc(%ebp)
  800de4:	ff 75 08             	pushl  0x8(%ebp)
  800de7:	e8 45 02 00 00       	call   801031 <printfmt>
  800dec:	83 c4 10             	add    $0x10,%esp
			break;
  800def:	e9 30 02 00 00       	jmp    801024 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800df4:	8b 45 14             	mov    0x14(%ebp),%eax
  800df7:	83 c0 04             	add    $0x4,%eax
  800dfa:	89 45 14             	mov    %eax,0x14(%ebp)
  800dfd:	8b 45 14             	mov    0x14(%ebp),%eax
  800e00:	83 e8 04             	sub    $0x4,%eax
  800e03:	8b 30                	mov    (%eax),%esi
  800e05:	85 f6                	test   %esi,%esi
  800e07:	75 05                	jne    800e0e <vprintfmt+0x1a6>
				p = "(null)";
  800e09:	be 91 28 80 00       	mov    $0x802891,%esi
			if (width > 0 && padc != '-')
  800e0e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e12:	7e 6d                	jle    800e81 <vprintfmt+0x219>
  800e14:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800e18:	74 67                	je     800e81 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800e1a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e1d:	83 ec 08             	sub    $0x8,%esp
  800e20:	50                   	push   %eax
  800e21:	56                   	push   %esi
  800e22:	e8 0c 03 00 00       	call   801133 <strnlen>
  800e27:	83 c4 10             	add    $0x10,%esp
  800e2a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e2d:	eb 16                	jmp    800e45 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e2f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e33:	83 ec 08             	sub    $0x8,%esp
  800e36:	ff 75 0c             	pushl  0xc(%ebp)
  800e39:	50                   	push   %eax
  800e3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3d:	ff d0                	call   *%eax
  800e3f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e42:	ff 4d e4             	decl   -0x1c(%ebp)
  800e45:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e49:	7f e4                	jg     800e2f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e4b:	eb 34                	jmp    800e81 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e4d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e51:	74 1c                	je     800e6f <vprintfmt+0x207>
  800e53:	83 fb 1f             	cmp    $0x1f,%ebx
  800e56:	7e 05                	jle    800e5d <vprintfmt+0x1f5>
  800e58:	83 fb 7e             	cmp    $0x7e,%ebx
  800e5b:	7e 12                	jle    800e6f <vprintfmt+0x207>
					putch('?', putdat);
  800e5d:	83 ec 08             	sub    $0x8,%esp
  800e60:	ff 75 0c             	pushl  0xc(%ebp)
  800e63:	6a 3f                	push   $0x3f
  800e65:	8b 45 08             	mov    0x8(%ebp),%eax
  800e68:	ff d0                	call   *%eax
  800e6a:	83 c4 10             	add    $0x10,%esp
  800e6d:	eb 0f                	jmp    800e7e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e6f:	83 ec 08             	sub    $0x8,%esp
  800e72:	ff 75 0c             	pushl  0xc(%ebp)
  800e75:	53                   	push   %ebx
  800e76:	8b 45 08             	mov    0x8(%ebp),%eax
  800e79:	ff d0                	call   *%eax
  800e7b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e7e:	ff 4d e4             	decl   -0x1c(%ebp)
  800e81:	89 f0                	mov    %esi,%eax
  800e83:	8d 70 01             	lea    0x1(%eax),%esi
  800e86:	8a 00                	mov    (%eax),%al
  800e88:	0f be d8             	movsbl %al,%ebx
  800e8b:	85 db                	test   %ebx,%ebx
  800e8d:	74 24                	je     800eb3 <vprintfmt+0x24b>
  800e8f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e93:	78 b8                	js     800e4d <vprintfmt+0x1e5>
  800e95:	ff 4d e0             	decl   -0x20(%ebp)
  800e98:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e9c:	79 af                	jns    800e4d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e9e:	eb 13                	jmp    800eb3 <vprintfmt+0x24b>
				putch(' ', putdat);
  800ea0:	83 ec 08             	sub    $0x8,%esp
  800ea3:	ff 75 0c             	pushl  0xc(%ebp)
  800ea6:	6a 20                	push   $0x20
  800ea8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eab:	ff d0                	call   *%eax
  800ead:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800eb0:	ff 4d e4             	decl   -0x1c(%ebp)
  800eb3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800eb7:	7f e7                	jg     800ea0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800eb9:	e9 66 01 00 00       	jmp    801024 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ebe:	83 ec 08             	sub    $0x8,%esp
  800ec1:	ff 75 e8             	pushl  -0x18(%ebp)
  800ec4:	8d 45 14             	lea    0x14(%ebp),%eax
  800ec7:	50                   	push   %eax
  800ec8:	e8 3c fd ff ff       	call   800c09 <getint>
  800ecd:	83 c4 10             	add    $0x10,%esp
  800ed0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ed3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ed6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ed9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800edc:	85 d2                	test   %edx,%edx
  800ede:	79 23                	jns    800f03 <vprintfmt+0x29b>
				putch('-', putdat);
  800ee0:	83 ec 08             	sub    $0x8,%esp
  800ee3:	ff 75 0c             	pushl  0xc(%ebp)
  800ee6:	6a 2d                	push   $0x2d
  800ee8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eeb:	ff d0                	call   *%eax
  800eed:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ef0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ef3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ef6:	f7 d8                	neg    %eax
  800ef8:	83 d2 00             	adc    $0x0,%edx
  800efb:	f7 da                	neg    %edx
  800efd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f00:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800f03:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f0a:	e9 bc 00 00 00       	jmp    800fcb <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800f0f:	83 ec 08             	sub    $0x8,%esp
  800f12:	ff 75 e8             	pushl  -0x18(%ebp)
  800f15:	8d 45 14             	lea    0x14(%ebp),%eax
  800f18:	50                   	push   %eax
  800f19:	e8 84 fc ff ff       	call   800ba2 <getuint>
  800f1e:	83 c4 10             	add    $0x10,%esp
  800f21:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f24:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f27:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f2e:	e9 98 00 00 00       	jmp    800fcb <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f33:	83 ec 08             	sub    $0x8,%esp
  800f36:	ff 75 0c             	pushl  0xc(%ebp)
  800f39:	6a 58                	push   $0x58
  800f3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3e:	ff d0                	call   *%eax
  800f40:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f43:	83 ec 08             	sub    $0x8,%esp
  800f46:	ff 75 0c             	pushl  0xc(%ebp)
  800f49:	6a 58                	push   $0x58
  800f4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4e:	ff d0                	call   *%eax
  800f50:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f53:	83 ec 08             	sub    $0x8,%esp
  800f56:	ff 75 0c             	pushl  0xc(%ebp)
  800f59:	6a 58                	push   $0x58
  800f5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5e:	ff d0                	call   *%eax
  800f60:	83 c4 10             	add    $0x10,%esp
			break;
  800f63:	e9 bc 00 00 00       	jmp    801024 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f68:	83 ec 08             	sub    $0x8,%esp
  800f6b:	ff 75 0c             	pushl  0xc(%ebp)
  800f6e:	6a 30                	push   $0x30
  800f70:	8b 45 08             	mov    0x8(%ebp),%eax
  800f73:	ff d0                	call   *%eax
  800f75:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f78:	83 ec 08             	sub    $0x8,%esp
  800f7b:	ff 75 0c             	pushl  0xc(%ebp)
  800f7e:	6a 78                	push   $0x78
  800f80:	8b 45 08             	mov    0x8(%ebp),%eax
  800f83:	ff d0                	call   *%eax
  800f85:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f88:	8b 45 14             	mov    0x14(%ebp),%eax
  800f8b:	83 c0 04             	add    $0x4,%eax
  800f8e:	89 45 14             	mov    %eax,0x14(%ebp)
  800f91:	8b 45 14             	mov    0x14(%ebp),%eax
  800f94:	83 e8 04             	sub    $0x4,%eax
  800f97:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f99:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f9c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800fa3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800faa:	eb 1f                	jmp    800fcb <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800fac:	83 ec 08             	sub    $0x8,%esp
  800faf:	ff 75 e8             	pushl  -0x18(%ebp)
  800fb2:	8d 45 14             	lea    0x14(%ebp),%eax
  800fb5:	50                   	push   %eax
  800fb6:	e8 e7 fb ff ff       	call   800ba2 <getuint>
  800fbb:	83 c4 10             	add    $0x10,%esp
  800fbe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fc1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800fc4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800fcb:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800fcf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fd2:	83 ec 04             	sub    $0x4,%esp
  800fd5:	52                   	push   %edx
  800fd6:	ff 75 e4             	pushl  -0x1c(%ebp)
  800fd9:	50                   	push   %eax
  800fda:	ff 75 f4             	pushl  -0xc(%ebp)
  800fdd:	ff 75 f0             	pushl  -0x10(%ebp)
  800fe0:	ff 75 0c             	pushl  0xc(%ebp)
  800fe3:	ff 75 08             	pushl  0x8(%ebp)
  800fe6:	e8 00 fb ff ff       	call   800aeb <printnum>
  800feb:	83 c4 20             	add    $0x20,%esp
			break;
  800fee:	eb 34                	jmp    801024 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ff0:	83 ec 08             	sub    $0x8,%esp
  800ff3:	ff 75 0c             	pushl  0xc(%ebp)
  800ff6:	53                   	push   %ebx
  800ff7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffa:	ff d0                	call   *%eax
  800ffc:	83 c4 10             	add    $0x10,%esp
			break;
  800fff:	eb 23                	jmp    801024 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801001:	83 ec 08             	sub    $0x8,%esp
  801004:	ff 75 0c             	pushl  0xc(%ebp)
  801007:	6a 25                	push   $0x25
  801009:	8b 45 08             	mov    0x8(%ebp),%eax
  80100c:	ff d0                	call   *%eax
  80100e:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801011:	ff 4d 10             	decl   0x10(%ebp)
  801014:	eb 03                	jmp    801019 <vprintfmt+0x3b1>
  801016:	ff 4d 10             	decl   0x10(%ebp)
  801019:	8b 45 10             	mov    0x10(%ebp),%eax
  80101c:	48                   	dec    %eax
  80101d:	8a 00                	mov    (%eax),%al
  80101f:	3c 25                	cmp    $0x25,%al
  801021:	75 f3                	jne    801016 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801023:	90                   	nop
		}
	}
  801024:	e9 47 fc ff ff       	jmp    800c70 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801029:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80102a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80102d:	5b                   	pop    %ebx
  80102e:	5e                   	pop    %esi
  80102f:	5d                   	pop    %ebp
  801030:	c3                   	ret    

00801031 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801031:	55                   	push   %ebp
  801032:	89 e5                	mov    %esp,%ebp
  801034:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801037:	8d 45 10             	lea    0x10(%ebp),%eax
  80103a:	83 c0 04             	add    $0x4,%eax
  80103d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801040:	8b 45 10             	mov    0x10(%ebp),%eax
  801043:	ff 75 f4             	pushl  -0xc(%ebp)
  801046:	50                   	push   %eax
  801047:	ff 75 0c             	pushl  0xc(%ebp)
  80104a:	ff 75 08             	pushl  0x8(%ebp)
  80104d:	e8 16 fc ff ff       	call   800c68 <vprintfmt>
  801052:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801055:	90                   	nop
  801056:	c9                   	leave  
  801057:	c3                   	ret    

00801058 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801058:	55                   	push   %ebp
  801059:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80105b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105e:	8b 40 08             	mov    0x8(%eax),%eax
  801061:	8d 50 01             	lea    0x1(%eax),%edx
  801064:	8b 45 0c             	mov    0xc(%ebp),%eax
  801067:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80106a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80106d:	8b 10                	mov    (%eax),%edx
  80106f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801072:	8b 40 04             	mov    0x4(%eax),%eax
  801075:	39 c2                	cmp    %eax,%edx
  801077:	73 12                	jae    80108b <sprintputch+0x33>
		*b->buf++ = ch;
  801079:	8b 45 0c             	mov    0xc(%ebp),%eax
  80107c:	8b 00                	mov    (%eax),%eax
  80107e:	8d 48 01             	lea    0x1(%eax),%ecx
  801081:	8b 55 0c             	mov    0xc(%ebp),%edx
  801084:	89 0a                	mov    %ecx,(%edx)
  801086:	8b 55 08             	mov    0x8(%ebp),%edx
  801089:	88 10                	mov    %dl,(%eax)
}
  80108b:	90                   	nop
  80108c:	5d                   	pop    %ebp
  80108d:	c3                   	ret    

0080108e <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80108e:	55                   	push   %ebp
  80108f:	89 e5                	mov    %esp,%ebp
  801091:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801094:	8b 45 08             	mov    0x8(%ebp),%eax
  801097:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80109a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109d:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a3:	01 d0                	add    %edx,%eax
  8010a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8010af:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010b3:	74 06                	je     8010bb <vsnprintf+0x2d>
  8010b5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010b9:	7f 07                	jg     8010c2 <vsnprintf+0x34>
		return -E_INVAL;
  8010bb:	b8 03 00 00 00       	mov    $0x3,%eax
  8010c0:	eb 20                	jmp    8010e2 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8010c2:	ff 75 14             	pushl  0x14(%ebp)
  8010c5:	ff 75 10             	pushl  0x10(%ebp)
  8010c8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8010cb:	50                   	push   %eax
  8010cc:	68 58 10 80 00       	push   $0x801058
  8010d1:	e8 92 fb ff ff       	call   800c68 <vprintfmt>
  8010d6:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010dc:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8010df:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8010e2:	c9                   	leave  
  8010e3:	c3                   	ret    

008010e4 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8010e4:	55                   	push   %ebp
  8010e5:	89 e5                	mov    %esp,%ebp
  8010e7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8010ea:	8d 45 10             	lea    0x10(%ebp),%eax
  8010ed:	83 c0 04             	add    $0x4,%eax
  8010f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8010f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f6:	ff 75 f4             	pushl  -0xc(%ebp)
  8010f9:	50                   	push   %eax
  8010fa:	ff 75 0c             	pushl  0xc(%ebp)
  8010fd:	ff 75 08             	pushl  0x8(%ebp)
  801100:	e8 89 ff ff ff       	call   80108e <vsnprintf>
  801105:	83 c4 10             	add    $0x10,%esp
  801108:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80110b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80110e:	c9                   	leave  
  80110f:	c3                   	ret    

00801110 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801110:	55                   	push   %ebp
  801111:	89 e5                	mov    %esp,%ebp
  801113:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801116:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80111d:	eb 06                	jmp    801125 <strlen+0x15>
		n++;
  80111f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801122:	ff 45 08             	incl   0x8(%ebp)
  801125:	8b 45 08             	mov    0x8(%ebp),%eax
  801128:	8a 00                	mov    (%eax),%al
  80112a:	84 c0                	test   %al,%al
  80112c:	75 f1                	jne    80111f <strlen+0xf>
		n++;
	return n;
  80112e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801131:	c9                   	leave  
  801132:	c3                   	ret    

00801133 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801133:	55                   	push   %ebp
  801134:	89 e5                	mov    %esp,%ebp
  801136:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801139:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801140:	eb 09                	jmp    80114b <strnlen+0x18>
		n++;
  801142:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801145:	ff 45 08             	incl   0x8(%ebp)
  801148:	ff 4d 0c             	decl   0xc(%ebp)
  80114b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80114f:	74 09                	je     80115a <strnlen+0x27>
  801151:	8b 45 08             	mov    0x8(%ebp),%eax
  801154:	8a 00                	mov    (%eax),%al
  801156:	84 c0                	test   %al,%al
  801158:	75 e8                	jne    801142 <strnlen+0xf>
		n++;
	return n;
  80115a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80115d:	c9                   	leave  
  80115e:	c3                   	ret    

0080115f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80115f:	55                   	push   %ebp
  801160:	89 e5                	mov    %esp,%ebp
  801162:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801165:	8b 45 08             	mov    0x8(%ebp),%eax
  801168:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80116b:	90                   	nop
  80116c:	8b 45 08             	mov    0x8(%ebp),%eax
  80116f:	8d 50 01             	lea    0x1(%eax),%edx
  801172:	89 55 08             	mov    %edx,0x8(%ebp)
  801175:	8b 55 0c             	mov    0xc(%ebp),%edx
  801178:	8d 4a 01             	lea    0x1(%edx),%ecx
  80117b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80117e:	8a 12                	mov    (%edx),%dl
  801180:	88 10                	mov    %dl,(%eax)
  801182:	8a 00                	mov    (%eax),%al
  801184:	84 c0                	test   %al,%al
  801186:	75 e4                	jne    80116c <strcpy+0xd>
		/* do nothing */;
	return ret;
  801188:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80118b:	c9                   	leave  
  80118c:	c3                   	ret    

0080118d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80118d:	55                   	push   %ebp
  80118e:	89 e5                	mov    %esp,%ebp
  801190:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801193:	8b 45 08             	mov    0x8(%ebp),%eax
  801196:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801199:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011a0:	eb 1f                	jmp    8011c1 <strncpy+0x34>
		*dst++ = *src;
  8011a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a5:	8d 50 01             	lea    0x1(%eax),%edx
  8011a8:	89 55 08             	mov    %edx,0x8(%ebp)
  8011ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011ae:	8a 12                	mov    (%edx),%dl
  8011b0:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8011b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b5:	8a 00                	mov    (%eax),%al
  8011b7:	84 c0                	test   %al,%al
  8011b9:	74 03                	je     8011be <strncpy+0x31>
			src++;
  8011bb:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8011be:	ff 45 fc             	incl   -0x4(%ebp)
  8011c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011c4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011c7:	72 d9                	jb     8011a2 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8011c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011cc:	c9                   	leave  
  8011cd:	c3                   	ret    

008011ce <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8011ce:	55                   	push   %ebp
  8011cf:	89 e5                	mov    %esp,%ebp
  8011d1:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8011d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8011da:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011de:	74 30                	je     801210 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8011e0:	eb 16                	jmp    8011f8 <strlcpy+0x2a>
			*dst++ = *src++;
  8011e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e5:	8d 50 01             	lea    0x1(%eax),%edx
  8011e8:	89 55 08             	mov    %edx,0x8(%ebp)
  8011eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011ee:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011f1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8011f4:	8a 12                	mov    (%edx),%dl
  8011f6:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8011f8:	ff 4d 10             	decl   0x10(%ebp)
  8011fb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011ff:	74 09                	je     80120a <strlcpy+0x3c>
  801201:	8b 45 0c             	mov    0xc(%ebp),%eax
  801204:	8a 00                	mov    (%eax),%al
  801206:	84 c0                	test   %al,%al
  801208:	75 d8                	jne    8011e2 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80120a:	8b 45 08             	mov    0x8(%ebp),%eax
  80120d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801210:	8b 55 08             	mov    0x8(%ebp),%edx
  801213:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801216:	29 c2                	sub    %eax,%edx
  801218:	89 d0                	mov    %edx,%eax
}
  80121a:	c9                   	leave  
  80121b:	c3                   	ret    

0080121c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80121c:	55                   	push   %ebp
  80121d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80121f:	eb 06                	jmp    801227 <strcmp+0xb>
		p++, q++;
  801221:	ff 45 08             	incl   0x8(%ebp)
  801224:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801227:	8b 45 08             	mov    0x8(%ebp),%eax
  80122a:	8a 00                	mov    (%eax),%al
  80122c:	84 c0                	test   %al,%al
  80122e:	74 0e                	je     80123e <strcmp+0x22>
  801230:	8b 45 08             	mov    0x8(%ebp),%eax
  801233:	8a 10                	mov    (%eax),%dl
  801235:	8b 45 0c             	mov    0xc(%ebp),%eax
  801238:	8a 00                	mov    (%eax),%al
  80123a:	38 c2                	cmp    %al,%dl
  80123c:	74 e3                	je     801221 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80123e:	8b 45 08             	mov    0x8(%ebp),%eax
  801241:	8a 00                	mov    (%eax),%al
  801243:	0f b6 d0             	movzbl %al,%edx
  801246:	8b 45 0c             	mov    0xc(%ebp),%eax
  801249:	8a 00                	mov    (%eax),%al
  80124b:	0f b6 c0             	movzbl %al,%eax
  80124e:	29 c2                	sub    %eax,%edx
  801250:	89 d0                	mov    %edx,%eax
}
  801252:	5d                   	pop    %ebp
  801253:	c3                   	ret    

00801254 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801254:	55                   	push   %ebp
  801255:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801257:	eb 09                	jmp    801262 <strncmp+0xe>
		n--, p++, q++;
  801259:	ff 4d 10             	decl   0x10(%ebp)
  80125c:	ff 45 08             	incl   0x8(%ebp)
  80125f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801262:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801266:	74 17                	je     80127f <strncmp+0x2b>
  801268:	8b 45 08             	mov    0x8(%ebp),%eax
  80126b:	8a 00                	mov    (%eax),%al
  80126d:	84 c0                	test   %al,%al
  80126f:	74 0e                	je     80127f <strncmp+0x2b>
  801271:	8b 45 08             	mov    0x8(%ebp),%eax
  801274:	8a 10                	mov    (%eax),%dl
  801276:	8b 45 0c             	mov    0xc(%ebp),%eax
  801279:	8a 00                	mov    (%eax),%al
  80127b:	38 c2                	cmp    %al,%dl
  80127d:	74 da                	je     801259 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80127f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801283:	75 07                	jne    80128c <strncmp+0x38>
		return 0;
  801285:	b8 00 00 00 00       	mov    $0x0,%eax
  80128a:	eb 14                	jmp    8012a0 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80128c:	8b 45 08             	mov    0x8(%ebp),%eax
  80128f:	8a 00                	mov    (%eax),%al
  801291:	0f b6 d0             	movzbl %al,%edx
  801294:	8b 45 0c             	mov    0xc(%ebp),%eax
  801297:	8a 00                	mov    (%eax),%al
  801299:	0f b6 c0             	movzbl %al,%eax
  80129c:	29 c2                	sub    %eax,%edx
  80129e:	89 d0                	mov    %edx,%eax
}
  8012a0:	5d                   	pop    %ebp
  8012a1:	c3                   	ret    

008012a2 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8012a2:	55                   	push   %ebp
  8012a3:	89 e5                	mov    %esp,%ebp
  8012a5:	83 ec 04             	sub    $0x4,%esp
  8012a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ab:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8012ae:	eb 12                	jmp    8012c2 <strchr+0x20>
		if (*s == c)
  8012b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b3:	8a 00                	mov    (%eax),%al
  8012b5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8012b8:	75 05                	jne    8012bf <strchr+0x1d>
			return (char *) s;
  8012ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bd:	eb 11                	jmp    8012d0 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8012bf:	ff 45 08             	incl   0x8(%ebp)
  8012c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c5:	8a 00                	mov    (%eax),%al
  8012c7:	84 c0                	test   %al,%al
  8012c9:	75 e5                	jne    8012b0 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8012cb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012d0:	c9                   	leave  
  8012d1:	c3                   	ret    

008012d2 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8012d2:	55                   	push   %ebp
  8012d3:	89 e5                	mov    %esp,%ebp
  8012d5:	83 ec 04             	sub    $0x4,%esp
  8012d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012db:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8012de:	eb 0d                	jmp    8012ed <strfind+0x1b>
		if (*s == c)
  8012e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e3:	8a 00                	mov    (%eax),%al
  8012e5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8012e8:	74 0e                	je     8012f8 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8012ea:	ff 45 08             	incl   0x8(%ebp)
  8012ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f0:	8a 00                	mov    (%eax),%al
  8012f2:	84 c0                	test   %al,%al
  8012f4:	75 ea                	jne    8012e0 <strfind+0xe>
  8012f6:	eb 01                	jmp    8012f9 <strfind+0x27>
		if (*s == c)
			break;
  8012f8:	90                   	nop
	return (char *) s;
  8012f9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012fc:	c9                   	leave  
  8012fd:	c3                   	ret    

008012fe <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8012fe:	55                   	push   %ebp
  8012ff:	89 e5                	mov    %esp,%ebp
  801301:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801304:	8b 45 08             	mov    0x8(%ebp),%eax
  801307:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80130a:	8b 45 10             	mov    0x10(%ebp),%eax
  80130d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801310:	eb 0e                	jmp    801320 <memset+0x22>
		*p++ = c;
  801312:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801315:	8d 50 01             	lea    0x1(%eax),%edx
  801318:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80131b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80131e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801320:	ff 4d f8             	decl   -0x8(%ebp)
  801323:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801327:	79 e9                	jns    801312 <memset+0x14>
		*p++ = c;

	return v;
  801329:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80132c:	c9                   	leave  
  80132d:	c3                   	ret    

0080132e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80132e:	55                   	push   %ebp
  80132f:	89 e5                	mov    %esp,%ebp
  801331:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801334:	8b 45 0c             	mov    0xc(%ebp),%eax
  801337:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80133a:	8b 45 08             	mov    0x8(%ebp),%eax
  80133d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801340:	eb 16                	jmp    801358 <memcpy+0x2a>
		*d++ = *s++;
  801342:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801345:	8d 50 01             	lea    0x1(%eax),%edx
  801348:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80134b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80134e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801351:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801354:	8a 12                	mov    (%edx),%dl
  801356:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801358:	8b 45 10             	mov    0x10(%ebp),%eax
  80135b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80135e:	89 55 10             	mov    %edx,0x10(%ebp)
  801361:	85 c0                	test   %eax,%eax
  801363:	75 dd                	jne    801342 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801365:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801368:	c9                   	leave  
  801369:	c3                   	ret    

0080136a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80136a:	55                   	push   %ebp
  80136b:	89 e5                	mov    %esp,%ebp
  80136d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801370:	8b 45 0c             	mov    0xc(%ebp),%eax
  801373:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801376:	8b 45 08             	mov    0x8(%ebp),%eax
  801379:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80137c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80137f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801382:	73 50                	jae    8013d4 <memmove+0x6a>
  801384:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801387:	8b 45 10             	mov    0x10(%ebp),%eax
  80138a:	01 d0                	add    %edx,%eax
  80138c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80138f:	76 43                	jbe    8013d4 <memmove+0x6a>
		s += n;
  801391:	8b 45 10             	mov    0x10(%ebp),%eax
  801394:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801397:	8b 45 10             	mov    0x10(%ebp),%eax
  80139a:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80139d:	eb 10                	jmp    8013af <memmove+0x45>
			*--d = *--s;
  80139f:	ff 4d f8             	decl   -0x8(%ebp)
  8013a2:	ff 4d fc             	decl   -0x4(%ebp)
  8013a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013a8:	8a 10                	mov    (%eax),%dl
  8013aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013ad:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8013af:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013b5:	89 55 10             	mov    %edx,0x10(%ebp)
  8013b8:	85 c0                	test   %eax,%eax
  8013ba:	75 e3                	jne    80139f <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8013bc:	eb 23                	jmp    8013e1 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8013be:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013c1:	8d 50 01             	lea    0x1(%eax),%edx
  8013c4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8013c7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013ca:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013cd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8013d0:	8a 12                	mov    (%edx),%dl
  8013d2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8013d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8013da:	89 55 10             	mov    %edx,0x10(%ebp)
  8013dd:	85 c0                	test   %eax,%eax
  8013df:	75 dd                	jne    8013be <memmove+0x54>
			*d++ = *s++;

	return dst;
  8013e1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013e4:	c9                   	leave  
  8013e5:	c3                   	ret    

008013e6 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8013e6:	55                   	push   %ebp
  8013e7:	89 e5                	mov    %esp,%ebp
  8013e9:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8013ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ef:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8013f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f5:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8013f8:	eb 2a                	jmp    801424 <memcmp+0x3e>
		if (*s1 != *s2)
  8013fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013fd:	8a 10                	mov    (%eax),%dl
  8013ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801402:	8a 00                	mov    (%eax),%al
  801404:	38 c2                	cmp    %al,%dl
  801406:	74 16                	je     80141e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801408:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80140b:	8a 00                	mov    (%eax),%al
  80140d:	0f b6 d0             	movzbl %al,%edx
  801410:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801413:	8a 00                	mov    (%eax),%al
  801415:	0f b6 c0             	movzbl %al,%eax
  801418:	29 c2                	sub    %eax,%edx
  80141a:	89 d0                	mov    %edx,%eax
  80141c:	eb 18                	jmp    801436 <memcmp+0x50>
		s1++, s2++;
  80141e:	ff 45 fc             	incl   -0x4(%ebp)
  801421:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801424:	8b 45 10             	mov    0x10(%ebp),%eax
  801427:	8d 50 ff             	lea    -0x1(%eax),%edx
  80142a:	89 55 10             	mov    %edx,0x10(%ebp)
  80142d:	85 c0                	test   %eax,%eax
  80142f:	75 c9                	jne    8013fa <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801431:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801436:	c9                   	leave  
  801437:	c3                   	ret    

00801438 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801438:	55                   	push   %ebp
  801439:	89 e5                	mov    %esp,%ebp
  80143b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80143e:	8b 55 08             	mov    0x8(%ebp),%edx
  801441:	8b 45 10             	mov    0x10(%ebp),%eax
  801444:	01 d0                	add    %edx,%eax
  801446:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801449:	eb 15                	jmp    801460 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80144b:	8b 45 08             	mov    0x8(%ebp),%eax
  80144e:	8a 00                	mov    (%eax),%al
  801450:	0f b6 d0             	movzbl %al,%edx
  801453:	8b 45 0c             	mov    0xc(%ebp),%eax
  801456:	0f b6 c0             	movzbl %al,%eax
  801459:	39 c2                	cmp    %eax,%edx
  80145b:	74 0d                	je     80146a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80145d:	ff 45 08             	incl   0x8(%ebp)
  801460:	8b 45 08             	mov    0x8(%ebp),%eax
  801463:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801466:	72 e3                	jb     80144b <memfind+0x13>
  801468:	eb 01                	jmp    80146b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80146a:	90                   	nop
	return (void *) s;
  80146b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80146e:	c9                   	leave  
  80146f:	c3                   	ret    

00801470 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801470:	55                   	push   %ebp
  801471:	89 e5                	mov    %esp,%ebp
  801473:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801476:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80147d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801484:	eb 03                	jmp    801489 <strtol+0x19>
		s++;
  801486:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801489:	8b 45 08             	mov    0x8(%ebp),%eax
  80148c:	8a 00                	mov    (%eax),%al
  80148e:	3c 20                	cmp    $0x20,%al
  801490:	74 f4                	je     801486 <strtol+0x16>
  801492:	8b 45 08             	mov    0x8(%ebp),%eax
  801495:	8a 00                	mov    (%eax),%al
  801497:	3c 09                	cmp    $0x9,%al
  801499:	74 eb                	je     801486 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80149b:	8b 45 08             	mov    0x8(%ebp),%eax
  80149e:	8a 00                	mov    (%eax),%al
  8014a0:	3c 2b                	cmp    $0x2b,%al
  8014a2:	75 05                	jne    8014a9 <strtol+0x39>
		s++;
  8014a4:	ff 45 08             	incl   0x8(%ebp)
  8014a7:	eb 13                	jmp    8014bc <strtol+0x4c>
	else if (*s == '-')
  8014a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ac:	8a 00                	mov    (%eax),%al
  8014ae:	3c 2d                	cmp    $0x2d,%al
  8014b0:	75 0a                	jne    8014bc <strtol+0x4c>
		s++, neg = 1;
  8014b2:	ff 45 08             	incl   0x8(%ebp)
  8014b5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8014bc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014c0:	74 06                	je     8014c8 <strtol+0x58>
  8014c2:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8014c6:	75 20                	jne    8014e8 <strtol+0x78>
  8014c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cb:	8a 00                	mov    (%eax),%al
  8014cd:	3c 30                	cmp    $0x30,%al
  8014cf:	75 17                	jne    8014e8 <strtol+0x78>
  8014d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d4:	40                   	inc    %eax
  8014d5:	8a 00                	mov    (%eax),%al
  8014d7:	3c 78                	cmp    $0x78,%al
  8014d9:	75 0d                	jne    8014e8 <strtol+0x78>
		s += 2, base = 16;
  8014db:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8014df:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8014e6:	eb 28                	jmp    801510 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8014e8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014ec:	75 15                	jne    801503 <strtol+0x93>
  8014ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f1:	8a 00                	mov    (%eax),%al
  8014f3:	3c 30                	cmp    $0x30,%al
  8014f5:	75 0c                	jne    801503 <strtol+0x93>
		s++, base = 8;
  8014f7:	ff 45 08             	incl   0x8(%ebp)
  8014fa:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801501:	eb 0d                	jmp    801510 <strtol+0xa0>
	else if (base == 0)
  801503:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801507:	75 07                	jne    801510 <strtol+0xa0>
		base = 10;
  801509:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801510:	8b 45 08             	mov    0x8(%ebp),%eax
  801513:	8a 00                	mov    (%eax),%al
  801515:	3c 2f                	cmp    $0x2f,%al
  801517:	7e 19                	jle    801532 <strtol+0xc2>
  801519:	8b 45 08             	mov    0x8(%ebp),%eax
  80151c:	8a 00                	mov    (%eax),%al
  80151e:	3c 39                	cmp    $0x39,%al
  801520:	7f 10                	jg     801532 <strtol+0xc2>
			dig = *s - '0';
  801522:	8b 45 08             	mov    0x8(%ebp),%eax
  801525:	8a 00                	mov    (%eax),%al
  801527:	0f be c0             	movsbl %al,%eax
  80152a:	83 e8 30             	sub    $0x30,%eax
  80152d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801530:	eb 42                	jmp    801574 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801532:	8b 45 08             	mov    0x8(%ebp),%eax
  801535:	8a 00                	mov    (%eax),%al
  801537:	3c 60                	cmp    $0x60,%al
  801539:	7e 19                	jle    801554 <strtol+0xe4>
  80153b:	8b 45 08             	mov    0x8(%ebp),%eax
  80153e:	8a 00                	mov    (%eax),%al
  801540:	3c 7a                	cmp    $0x7a,%al
  801542:	7f 10                	jg     801554 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801544:	8b 45 08             	mov    0x8(%ebp),%eax
  801547:	8a 00                	mov    (%eax),%al
  801549:	0f be c0             	movsbl %al,%eax
  80154c:	83 e8 57             	sub    $0x57,%eax
  80154f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801552:	eb 20                	jmp    801574 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801554:	8b 45 08             	mov    0x8(%ebp),%eax
  801557:	8a 00                	mov    (%eax),%al
  801559:	3c 40                	cmp    $0x40,%al
  80155b:	7e 39                	jle    801596 <strtol+0x126>
  80155d:	8b 45 08             	mov    0x8(%ebp),%eax
  801560:	8a 00                	mov    (%eax),%al
  801562:	3c 5a                	cmp    $0x5a,%al
  801564:	7f 30                	jg     801596 <strtol+0x126>
			dig = *s - 'A' + 10;
  801566:	8b 45 08             	mov    0x8(%ebp),%eax
  801569:	8a 00                	mov    (%eax),%al
  80156b:	0f be c0             	movsbl %al,%eax
  80156e:	83 e8 37             	sub    $0x37,%eax
  801571:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801574:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801577:	3b 45 10             	cmp    0x10(%ebp),%eax
  80157a:	7d 19                	jge    801595 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80157c:	ff 45 08             	incl   0x8(%ebp)
  80157f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801582:	0f af 45 10          	imul   0x10(%ebp),%eax
  801586:	89 c2                	mov    %eax,%edx
  801588:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80158b:	01 d0                	add    %edx,%eax
  80158d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801590:	e9 7b ff ff ff       	jmp    801510 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801595:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801596:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80159a:	74 08                	je     8015a4 <strtol+0x134>
		*endptr = (char *) s;
  80159c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159f:	8b 55 08             	mov    0x8(%ebp),%edx
  8015a2:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8015a4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8015a8:	74 07                	je     8015b1 <strtol+0x141>
  8015aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ad:	f7 d8                	neg    %eax
  8015af:	eb 03                	jmp    8015b4 <strtol+0x144>
  8015b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8015b4:	c9                   	leave  
  8015b5:	c3                   	ret    

008015b6 <ltostr>:

void
ltostr(long value, char *str)
{
  8015b6:	55                   	push   %ebp
  8015b7:	89 e5                	mov    %esp,%ebp
  8015b9:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8015bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8015c3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8015ca:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015ce:	79 13                	jns    8015e3 <ltostr+0x2d>
	{
		neg = 1;
  8015d0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8015d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015da:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8015dd:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8015e0:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8015e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e6:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8015eb:	99                   	cltd   
  8015ec:	f7 f9                	idiv   %ecx
  8015ee:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8015f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015f4:	8d 50 01             	lea    0x1(%eax),%edx
  8015f7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015fa:	89 c2                	mov    %eax,%edx
  8015fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ff:	01 d0                	add    %edx,%eax
  801601:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801604:	83 c2 30             	add    $0x30,%edx
  801607:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801609:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80160c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801611:	f7 e9                	imul   %ecx
  801613:	c1 fa 02             	sar    $0x2,%edx
  801616:	89 c8                	mov    %ecx,%eax
  801618:	c1 f8 1f             	sar    $0x1f,%eax
  80161b:	29 c2                	sub    %eax,%edx
  80161d:	89 d0                	mov    %edx,%eax
  80161f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801622:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801625:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80162a:	f7 e9                	imul   %ecx
  80162c:	c1 fa 02             	sar    $0x2,%edx
  80162f:	89 c8                	mov    %ecx,%eax
  801631:	c1 f8 1f             	sar    $0x1f,%eax
  801634:	29 c2                	sub    %eax,%edx
  801636:	89 d0                	mov    %edx,%eax
  801638:	c1 e0 02             	shl    $0x2,%eax
  80163b:	01 d0                	add    %edx,%eax
  80163d:	01 c0                	add    %eax,%eax
  80163f:	29 c1                	sub    %eax,%ecx
  801641:	89 ca                	mov    %ecx,%edx
  801643:	85 d2                	test   %edx,%edx
  801645:	75 9c                	jne    8015e3 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801647:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80164e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801651:	48                   	dec    %eax
  801652:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801655:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801659:	74 3d                	je     801698 <ltostr+0xe2>
		start = 1 ;
  80165b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801662:	eb 34                	jmp    801698 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801664:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801667:	8b 45 0c             	mov    0xc(%ebp),%eax
  80166a:	01 d0                	add    %edx,%eax
  80166c:	8a 00                	mov    (%eax),%al
  80166e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801671:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801674:	8b 45 0c             	mov    0xc(%ebp),%eax
  801677:	01 c2                	add    %eax,%edx
  801679:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80167c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80167f:	01 c8                	add    %ecx,%eax
  801681:	8a 00                	mov    (%eax),%al
  801683:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801685:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801688:	8b 45 0c             	mov    0xc(%ebp),%eax
  80168b:	01 c2                	add    %eax,%edx
  80168d:	8a 45 eb             	mov    -0x15(%ebp),%al
  801690:	88 02                	mov    %al,(%edx)
		start++ ;
  801692:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801695:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801698:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80169b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80169e:	7c c4                	jl     801664 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8016a0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8016a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016a6:	01 d0                	add    %edx,%eax
  8016a8:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8016ab:	90                   	nop
  8016ac:	c9                   	leave  
  8016ad:	c3                   	ret    

008016ae <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8016ae:	55                   	push   %ebp
  8016af:	89 e5                	mov    %esp,%ebp
  8016b1:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8016b4:	ff 75 08             	pushl  0x8(%ebp)
  8016b7:	e8 54 fa ff ff       	call   801110 <strlen>
  8016bc:	83 c4 04             	add    $0x4,%esp
  8016bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8016c2:	ff 75 0c             	pushl  0xc(%ebp)
  8016c5:	e8 46 fa ff ff       	call   801110 <strlen>
  8016ca:	83 c4 04             	add    $0x4,%esp
  8016cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8016d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8016d7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8016de:	eb 17                	jmp    8016f7 <strcconcat+0x49>
		final[s] = str1[s] ;
  8016e0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8016e6:	01 c2                	add    %eax,%edx
  8016e8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8016eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ee:	01 c8                	add    %ecx,%eax
  8016f0:	8a 00                	mov    (%eax),%al
  8016f2:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8016f4:	ff 45 fc             	incl   -0x4(%ebp)
  8016f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016fa:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8016fd:	7c e1                	jl     8016e0 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8016ff:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801706:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80170d:	eb 1f                	jmp    80172e <strcconcat+0x80>
		final[s++] = str2[i] ;
  80170f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801712:	8d 50 01             	lea    0x1(%eax),%edx
  801715:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801718:	89 c2                	mov    %eax,%edx
  80171a:	8b 45 10             	mov    0x10(%ebp),%eax
  80171d:	01 c2                	add    %eax,%edx
  80171f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801722:	8b 45 0c             	mov    0xc(%ebp),%eax
  801725:	01 c8                	add    %ecx,%eax
  801727:	8a 00                	mov    (%eax),%al
  801729:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80172b:	ff 45 f8             	incl   -0x8(%ebp)
  80172e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801731:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801734:	7c d9                	jl     80170f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801736:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801739:	8b 45 10             	mov    0x10(%ebp),%eax
  80173c:	01 d0                	add    %edx,%eax
  80173e:	c6 00 00             	movb   $0x0,(%eax)
}
  801741:	90                   	nop
  801742:	c9                   	leave  
  801743:	c3                   	ret    

00801744 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801744:	55                   	push   %ebp
  801745:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801747:	8b 45 14             	mov    0x14(%ebp),%eax
  80174a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801750:	8b 45 14             	mov    0x14(%ebp),%eax
  801753:	8b 00                	mov    (%eax),%eax
  801755:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80175c:	8b 45 10             	mov    0x10(%ebp),%eax
  80175f:	01 d0                	add    %edx,%eax
  801761:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801767:	eb 0c                	jmp    801775 <strsplit+0x31>
			*string++ = 0;
  801769:	8b 45 08             	mov    0x8(%ebp),%eax
  80176c:	8d 50 01             	lea    0x1(%eax),%edx
  80176f:	89 55 08             	mov    %edx,0x8(%ebp)
  801772:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801775:	8b 45 08             	mov    0x8(%ebp),%eax
  801778:	8a 00                	mov    (%eax),%al
  80177a:	84 c0                	test   %al,%al
  80177c:	74 18                	je     801796 <strsplit+0x52>
  80177e:	8b 45 08             	mov    0x8(%ebp),%eax
  801781:	8a 00                	mov    (%eax),%al
  801783:	0f be c0             	movsbl %al,%eax
  801786:	50                   	push   %eax
  801787:	ff 75 0c             	pushl  0xc(%ebp)
  80178a:	e8 13 fb ff ff       	call   8012a2 <strchr>
  80178f:	83 c4 08             	add    $0x8,%esp
  801792:	85 c0                	test   %eax,%eax
  801794:	75 d3                	jne    801769 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801796:	8b 45 08             	mov    0x8(%ebp),%eax
  801799:	8a 00                	mov    (%eax),%al
  80179b:	84 c0                	test   %al,%al
  80179d:	74 5a                	je     8017f9 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80179f:	8b 45 14             	mov    0x14(%ebp),%eax
  8017a2:	8b 00                	mov    (%eax),%eax
  8017a4:	83 f8 0f             	cmp    $0xf,%eax
  8017a7:	75 07                	jne    8017b0 <strsplit+0x6c>
		{
			return 0;
  8017a9:	b8 00 00 00 00       	mov    $0x0,%eax
  8017ae:	eb 66                	jmp    801816 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8017b0:	8b 45 14             	mov    0x14(%ebp),%eax
  8017b3:	8b 00                	mov    (%eax),%eax
  8017b5:	8d 48 01             	lea    0x1(%eax),%ecx
  8017b8:	8b 55 14             	mov    0x14(%ebp),%edx
  8017bb:	89 0a                	mov    %ecx,(%edx)
  8017bd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8017c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8017c7:	01 c2                	add    %eax,%edx
  8017c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cc:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8017ce:	eb 03                	jmp    8017d3 <strsplit+0x8f>
			string++;
  8017d0:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8017d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d6:	8a 00                	mov    (%eax),%al
  8017d8:	84 c0                	test   %al,%al
  8017da:	74 8b                	je     801767 <strsplit+0x23>
  8017dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017df:	8a 00                	mov    (%eax),%al
  8017e1:	0f be c0             	movsbl %al,%eax
  8017e4:	50                   	push   %eax
  8017e5:	ff 75 0c             	pushl  0xc(%ebp)
  8017e8:	e8 b5 fa ff ff       	call   8012a2 <strchr>
  8017ed:	83 c4 08             	add    $0x8,%esp
  8017f0:	85 c0                	test   %eax,%eax
  8017f2:	74 dc                	je     8017d0 <strsplit+0x8c>
			string++;
	}
  8017f4:	e9 6e ff ff ff       	jmp    801767 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8017f9:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8017fa:	8b 45 14             	mov    0x14(%ebp),%eax
  8017fd:	8b 00                	mov    (%eax),%eax
  8017ff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801806:	8b 45 10             	mov    0x10(%ebp),%eax
  801809:	01 d0                	add    %edx,%eax
  80180b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801811:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801816:	c9                   	leave  
  801817:	c3                   	ret    

00801818 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801818:	55                   	push   %ebp
  801819:	89 e5                	mov    %esp,%ebp
  80181b:	57                   	push   %edi
  80181c:	56                   	push   %esi
  80181d:	53                   	push   %ebx
  80181e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801821:	8b 45 08             	mov    0x8(%ebp),%eax
  801824:	8b 55 0c             	mov    0xc(%ebp),%edx
  801827:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80182a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80182d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801830:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801833:	cd 30                	int    $0x30
  801835:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801838:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80183b:	83 c4 10             	add    $0x10,%esp
  80183e:	5b                   	pop    %ebx
  80183f:	5e                   	pop    %esi
  801840:	5f                   	pop    %edi
  801841:	5d                   	pop    %ebp
  801842:	c3                   	ret    

00801843 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801843:	55                   	push   %ebp
  801844:	89 e5                	mov    %esp,%ebp
  801846:	83 ec 04             	sub    $0x4,%esp
  801849:	8b 45 10             	mov    0x10(%ebp),%eax
  80184c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80184f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801853:	8b 45 08             	mov    0x8(%ebp),%eax
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	52                   	push   %edx
  80185b:	ff 75 0c             	pushl  0xc(%ebp)
  80185e:	50                   	push   %eax
  80185f:	6a 00                	push   $0x0
  801861:	e8 b2 ff ff ff       	call   801818 <syscall>
  801866:	83 c4 18             	add    $0x18,%esp
}
  801869:	90                   	nop
  80186a:	c9                   	leave  
  80186b:	c3                   	ret    

0080186c <sys_cgetc>:

int
sys_cgetc(void)
{
  80186c:	55                   	push   %ebp
  80186d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80186f:	6a 00                	push   $0x0
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 01                	push   $0x1
  80187b:	e8 98 ff ff ff       	call   801818 <syscall>
  801880:	83 c4 18             	add    $0x18,%esp
}
  801883:	c9                   	leave  
  801884:	c3                   	ret    

00801885 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801885:	55                   	push   %ebp
  801886:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801888:	8b 45 08             	mov    0x8(%ebp),%eax
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	50                   	push   %eax
  801894:	6a 05                	push   $0x5
  801896:	e8 7d ff ff ff       	call   801818 <syscall>
  80189b:	83 c4 18             	add    $0x18,%esp
}
  80189e:	c9                   	leave  
  80189f:	c3                   	ret    

008018a0 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8018a0:	55                   	push   %ebp
  8018a1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 02                	push   $0x2
  8018af:	e8 64 ff ff ff       	call   801818 <syscall>
  8018b4:	83 c4 18             	add    $0x18,%esp
}
  8018b7:	c9                   	leave  
  8018b8:	c3                   	ret    

008018b9 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8018b9:	55                   	push   %ebp
  8018ba:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 00                	push   $0x0
  8018c2:	6a 00                	push   $0x0
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 03                	push   $0x3
  8018c8:	e8 4b ff ff ff       	call   801818 <syscall>
  8018cd:	83 c4 18             	add    $0x18,%esp
}
  8018d0:	c9                   	leave  
  8018d1:	c3                   	ret    

008018d2 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8018d2:	55                   	push   %ebp
  8018d3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 04                	push   $0x4
  8018e1:	e8 32 ff ff ff       	call   801818 <syscall>
  8018e6:	83 c4 18             	add    $0x18,%esp
}
  8018e9:	c9                   	leave  
  8018ea:	c3                   	ret    

008018eb <sys_env_exit>:


void sys_env_exit(void)
{
  8018eb:	55                   	push   %ebp
  8018ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 00                	push   $0x0
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 06                	push   $0x6
  8018fa:	e8 19 ff ff ff       	call   801818 <syscall>
  8018ff:	83 c4 18             	add    $0x18,%esp
}
  801902:	90                   	nop
  801903:	c9                   	leave  
  801904:	c3                   	ret    

00801905 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801905:	55                   	push   %ebp
  801906:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801908:	8b 55 0c             	mov    0xc(%ebp),%edx
  80190b:	8b 45 08             	mov    0x8(%ebp),%eax
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	52                   	push   %edx
  801915:	50                   	push   %eax
  801916:	6a 07                	push   $0x7
  801918:	e8 fb fe ff ff       	call   801818 <syscall>
  80191d:	83 c4 18             	add    $0x18,%esp
}
  801920:	c9                   	leave  
  801921:	c3                   	ret    

00801922 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801922:	55                   	push   %ebp
  801923:	89 e5                	mov    %esp,%ebp
  801925:	56                   	push   %esi
  801926:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801927:	8b 75 18             	mov    0x18(%ebp),%esi
  80192a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80192d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801930:	8b 55 0c             	mov    0xc(%ebp),%edx
  801933:	8b 45 08             	mov    0x8(%ebp),%eax
  801936:	56                   	push   %esi
  801937:	53                   	push   %ebx
  801938:	51                   	push   %ecx
  801939:	52                   	push   %edx
  80193a:	50                   	push   %eax
  80193b:	6a 08                	push   $0x8
  80193d:	e8 d6 fe ff ff       	call   801818 <syscall>
  801942:	83 c4 18             	add    $0x18,%esp
}
  801945:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801948:	5b                   	pop    %ebx
  801949:	5e                   	pop    %esi
  80194a:	5d                   	pop    %ebp
  80194b:	c3                   	ret    

0080194c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80194c:	55                   	push   %ebp
  80194d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80194f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801952:	8b 45 08             	mov    0x8(%ebp),%eax
  801955:	6a 00                	push   $0x0
  801957:	6a 00                	push   $0x0
  801959:	6a 00                	push   $0x0
  80195b:	52                   	push   %edx
  80195c:	50                   	push   %eax
  80195d:	6a 09                	push   $0x9
  80195f:	e8 b4 fe ff ff       	call   801818 <syscall>
  801964:	83 c4 18             	add    $0x18,%esp
}
  801967:	c9                   	leave  
  801968:	c3                   	ret    

00801969 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801969:	55                   	push   %ebp
  80196a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	6a 00                	push   $0x0
  801972:	ff 75 0c             	pushl  0xc(%ebp)
  801975:	ff 75 08             	pushl  0x8(%ebp)
  801978:	6a 0a                	push   $0xa
  80197a:	e8 99 fe ff ff       	call   801818 <syscall>
  80197f:	83 c4 18             	add    $0x18,%esp
}
  801982:	c9                   	leave  
  801983:	c3                   	ret    

00801984 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801984:	55                   	push   %ebp
  801985:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	6a 0b                	push   $0xb
  801993:	e8 80 fe ff ff       	call   801818 <syscall>
  801998:	83 c4 18             	add    $0x18,%esp
}
  80199b:	c9                   	leave  
  80199c:	c3                   	ret    

0080199d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80199d:	55                   	push   %ebp
  80199e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 00                	push   $0x0
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	6a 0c                	push   $0xc
  8019ac:	e8 67 fe ff ff       	call   801818 <syscall>
  8019b1:	83 c4 18             	add    $0x18,%esp
}
  8019b4:	c9                   	leave  
  8019b5:	c3                   	ret    

008019b6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8019b6:	55                   	push   %ebp
  8019b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8019b9:	6a 00                	push   $0x0
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 0d                	push   $0xd
  8019c5:	e8 4e fe ff ff       	call   801818 <syscall>
  8019ca:	83 c4 18             	add    $0x18,%esp
}
  8019cd:	c9                   	leave  
  8019ce:	c3                   	ret    

008019cf <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8019cf:	55                   	push   %ebp
  8019d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	ff 75 0c             	pushl  0xc(%ebp)
  8019db:	ff 75 08             	pushl  0x8(%ebp)
  8019de:	6a 11                	push   $0x11
  8019e0:	e8 33 fe ff ff       	call   801818 <syscall>
  8019e5:	83 c4 18             	add    $0x18,%esp
	return;
  8019e8:	90                   	nop
}
  8019e9:	c9                   	leave  
  8019ea:	c3                   	ret    

008019eb <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8019eb:	55                   	push   %ebp
  8019ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	6a 00                	push   $0x0
  8019f4:	ff 75 0c             	pushl  0xc(%ebp)
  8019f7:	ff 75 08             	pushl  0x8(%ebp)
  8019fa:	6a 12                	push   $0x12
  8019fc:	e8 17 fe ff ff       	call   801818 <syscall>
  801a01:	83 c4 18             	add    $0x18,%esp
	return ;
  801a04:	90                   	nop
}
  801a05:	c9                   	leave  
  801a06:	c3                   	ret    

00801a07 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801a07:	55                   	push   %ebp
  801a08:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801a0a:	6a 00                	push   $0x0
  801a0c:	6a 00                	push   $0x0
  801a0e:	6a 00                	push   $0x0
  801a10:	6a 00                	push   $0x0
  801a12:	6a 00                	push   $0x0
  801a14:	6a 0e                	push   $0xe
  801a16:	e8 fd fd ff ff       	call   801818 <syscall>
  801a1b:	83 c4 18             	add    $0x18,%esp
}
  801a1e:	c9                   	leave  
  801a1f:	c3                   	ret    

00801a20 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801a20:	55                   	push   %ebp
  801a21:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801a23:	6a 00                	push   $0x0
  801a25:	6a 00                	push   $0x0
  801a27:	6a 00                	push   $0x0
  801a29:	6a 00                	push   $0x0
  801a2b:	ff 75 08             	pushl  0x8(%ebp)
  801a2e:	6a 0f                	push   $0xf
  801a30:	e8 e3 fd ff ff       	call   801818 <syscall>
  801a35:	83 c4 18             	add    $0x18,%esp
}
  801a38:	c9                   	leave  
  801a39:	c3                   	ret    

00801a3a <sys_scarce_memory>:

void sys_scarce_memory()
{
  801a3a:	55                   	push   %ebp
  801a3b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 00                	push   $0x0
  801a43:	6a 00                	push   $0x0
  801a45:	6a 00                	push   $0x0
  801a47:	6a 10                	push   $0x10
  801a49:	e8 ca fd ff ff       	call   801818 <syscall>
  801a4e:	83 c4 18             	add    $0x18,%esp
}
  801a51:	90                   	nop
  801a52:	c9                   	leave  
  801a53:	c3                   	ret    

00801a54 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801a54:	55                   	push   %ebp
  801a55:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801a57:	6a 00                	push   $0x0
  801a59:	6a 00                	push   $0x0
  801a5b:	6a 00                	push   $0x0
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 14                	push   $0x14
  801a63:	e8 b0 fd ff ff       	call   801818 <syscall>
  801a68:	83 c4 18             	add    $0x18,%esp
}
  801a6b:	90                   	nop
  801a6c:	c9                   	leave  
  801a6d:	c3                   	ret    

00801a6e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801a6e:	55                   	push   %ebp
  801a6f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801a71:	6a 00                	push   $0x0
  801a73:	6a 00                	push   $0x0
  801a75:	6a 00                	push   $0x0
  801a77:	6a 00                	push   $0x0
  801a79:	6a 00                	push   $0x0
  801a7b:	6a 15                	push   $0x15
  801a7d:	e8 96 fd ff ff       	call   801818 <syscall>
  801a82:	83 c4 18             	add    $0x18,%esp
}
  801a85:	90                   	nop
  801a86:	c9                   	leave  
  801a87:	c3                   	ret    

00801a88 <sys_cputc>:


void
sys_cputc(const char c)
{
  801a88:	55                   	push   %ebp
  801a89:	89 e5                	mov    %esp,%ebp
  801a8b:	83 ec 04             	sub    $0x4,%esp
  801a8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a91:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801a94:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 00                	push   $0x0
  801aa0:	50                   	push   %eax
  801aa1:	6a 16                	push   $0x16
  801aa3:	e8 70 fd ff ff       	call   801818 <syscall>
  801aa8:	83 c4 18             	add    $0x18,%esp
}
  801aab:	90                   	nop
  801aac:	c9                   	leave  
  801aad:	c3                   	ret    

00801aae <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801aae:	55                   	push   %ebp
  801aaf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 17                	push   $0x17
  801abd:	e8 56 fd ff ff       	call   801818 <syscall>
  801ac2:	83 c4 18             	add    $0x18,%esp
}
  801ac5:	90                   	nop
  801ac6:	c9                   	leave  
  801ac7:	c3                   	ret    

00801ac8 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801ac8:	55                   	push   %ebp
  801ac9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801acb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	ff 75 0c             	pushl  0xc(%ebp)
  801ad7:	50                   	push   %eax
  801ad8:	6a 18                	push   $0x18
  801ada:	e8 39 fd ff ff       	call   801818 <syscall>
  801adf:	83 c4 18             	add    $0x18,%esp
}
  801ae2:	c9                   	leave  
  801ae3:	c3                   	ret    

00801ae4 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801ae4:	55                   	push   %ebp
  801ae5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ae7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aea:	8b 45 08             	mov    0x8(%ebp),%eax
  801aed:	6a 00                	push   $0x0
  801aef:	6a 00                	push   $0x0
  801af1:	6a 00                	push   $0x0
  801af3:	52                   	push   %edx
  801af4:	50                   	push   %eax
  801af5:	6a 1b                	push   $0x1b
  801af7:	e8 1c fd ff ff       	call   801818 <syscall>
  801afc:	83 c4 18             	add    $0x18,%esp
}
  801aff:	c9                   	leave  
  801b00:	c3                   	ret    

00801b01 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b01:	55                   	push   %ebp
  801b02:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b04:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b07:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0a:	6a 00                	push   $0x0
  801b0c:	6a 00                	push   $0x0
  801b0e:	6a 00                	push   $0x0
  801b10:	52                   	push   %edx
  801b11:	50                   	push   %eax
  801b12:	6a 19                	push   $0x19
  801b14:	e8 ff fc ff ff       	call   801818 <syscall>
  801b19:	83 c4 18             	add    $0x18,%esp
}
  801b1c:	90                   	nop
  801b1d:	c9                   	leave  
  801b1e:	c3                   	ret    

00801b1f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801b1f:	55                   	push   %ebp
  801b20:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801b22:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b25:	8b 45 08             	mov    0x8(%ebp),%eax
  801b28:	6a 00                	push   $0x0
  801b2a:	6a 00                	push   $0x0
  801b2c:	6a 00                	push   $0x0
  801b2e:	52                   	push   %edx
  801b2f:	50                   	push   %eax
  801b30:	6a 1a                	push   $0x1a
  801b32:	e8 e1 fc ff ff       	call   801818 <syscall>
  801b37:	83 c4 18             	add    $0x18,%esp
}
  801b3a:	90                   	nop
  801b3b:	c9                   	leave  
  801b3c:	c3                   	ret    

00801b3d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801b3d:	55                   	push   %ebp
  801b3e:	89 e5                	mov    %esp,%ebp
  801b40:	83 ec 04             	sub    $0x4,%esp
  801b43:	8b 45 10             	mov    0x10(%ebp),%eax
  801b46:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801b49:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801b4c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b50:	8b 45 08             	mov    0x8(%ebp),%eax
  801b53:	6a 00                	push   $0x0
  801b55:	51                   	push   %ecx
  801b56:	52                   	push   %edx
  801b57:	ff 75 0c             	pushl  0xc(%ebp)
  801b5a:	50                   	push   %eax
  801b5b:	6a 1c                	push   $0x1c
  801b5d:	e8 b6 fc ff ff       	call   801818 <syscall>
  801b62:	83 c4 18             	add    $0x18,%esp
}
  801b65:	c9                   	leave  
  801b66:	c3                   	ret    

00801b67 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801b67:	55                   	push   %ebp
  801b68:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801b6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b70:	6a 00                	push   $0x0
  801b72:	6a 00                	push   $0x0
  801b74:	6a 00                	push   $0x0
  801b76:	52                   	push   %edx
  801b77:	50                   	push   %eax
  801b78:	6a 1d                	push   $0x1d
  801b7a:	e8 99 fc ff ff       	call   801818 <syscall>
  801b7f:	83 c4 18             	add    $0x18,%esp
}
  801b82:	c9                   	leave  
  801b83:	c3                   	ret    

00801b84 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801b84:	55                   	push   %ebp
  801b85:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801b87:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b90:	6a 00                	push   $0x0
  801b92:	6a 00                	push   $0x0
  801b94:	51                   	push   %ecx
  801b95:	52                   	push   %edx
  801b96:	50                   	push   %eax
  801b97:	6a 1e                	push   $0x1e
  801b99:	e8 7a fc ff ff       	call   801818 <syscall>
  801b9e:	83 c4 18             	add    $0x18,%esp
}
  801ba1:	c9                   	leave  
  801ba2:	c3                   	ret    

00801ba3 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ba3:	55                   	push   %ebp
  801ba4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ba6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ba9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bac:	6a 00                	push   $0x0
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	52                   	push   %edx
  801bb3:	50                   	push   %eax
  801bb4:	6a 1f                	push   $0x1f
  801bb6:	e8 5d fc ff ff       	call   801818 <syscall>
  801bbb:	83 c4 18             	add    $0x18,%esp
}
  801bbe:	c9                   	leave  
  801bbf:	c3                   	ret    

00801bc0 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801bc0:	55                   	push   %ebp
  801bc1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 00                	push   $0x0
  801bc9:	6a 00                	push   $0x0
  801bcb:	6a 00                	push   $0x0
  801bcd:	6a 20                	push   $0x20
  801bcf:	e8 44 fc ff ff       	call   801818 <syscall>
  801bd4:	83 c4 18             	add    $0x18,%esp
}
  801bd7:	c9                   	leave  
  801bd8:	c3                   	ret    

00801bd9 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801bd9:	55                   	push   %ebp
  801bda:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdf:	6a 00                	push   $0x0
  801be1:	ff 75 14             	pushl  0x14(%ebp)
  801be4:	ff 75 10             	pushl  0x10(%ebp)
  801be7:	ff 75 0c             	pushl  0xc(%ebp)
  801bea:	50                   	push   %eax
  801beb:	6a 21                	push   $0x21
  801bed:	e8 26 fc ff ff       	call   801818 <syscall>
  801bf2:	83 c4 18             	add    $0x18,%esp
}
  801bf5:	c9                   	leave  
  801bf6:	c3                   	ret    

00801bf7 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801bf7:	55                   	push   %ebp
  801bf8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801bfa:	8b 45 08             	mov    0x8(%ebp),%eax
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	6a 00                	push   $0x0
  801c05:	50                   	push   %eax
  801c06:	6a 22                	push   $0x22
  801c08:	e8 0b fc ff ff       	call   801818 <syscall>
  801c0d:	83 c4 18             	add    $0x18,%esp
}
  801c10:	90                   	nop
  801c11:	c9                   	leave  
  801c12:	c3                   	ret    

00801c13 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801c13:	55                   	push   %ebp
  801c14:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801c16:	8b 45 08             	mov    0x8(%ebp),%eax
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 00                	push   $0x0
  801c21:	50                   	push   %eax
  801c22:	6a 23                	push   $0x23
  801c24:	e8 ef fb ff ff       	call   801818 <syscall>
  801c29:	83 c4 18             	add    $0x18,%esp
}
  801c2c:	90                   	nop
  801c2d:	c9                   	leave  
  801c2e:	c3                   	ret    

00801c2f <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801c2f:	55                   	push   %ebp
  801c30:	89 e5                	mov    %esp,%ebp
  801c32:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801c35:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c38:	8d 50 04             	lea    0x4(%eax),%edx
  801c3b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 00                	push   $0x0
  801c42:	6a 00                	push   $0x0
  801c44:	52                   	push   %edx
  801c45:	50                   	push   %eax
  801c46:	6a 24                	push   $0x24
  801c48:	e8 cb fb ff ff       	call   801818 <syscall>
  801c4d:	83 c4 18             	add    $0x18,%esp
	return result;
  801c50:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c53:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c56:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c59:	89 01                	mov    %eax,(%ecx)
  801c5b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801c5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c61:	c9                   	leave  
  801c62:	c2 04 00             	ret    $0x4

00801c65 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801c65:	55                   	push   %ebp
  801c66:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801c68:	6a 00                	push   $0x0
  801c6a:	6a 00                	push   $0x0
  801c6c:	ff 75 10             	pushl  0x10(%ebp)
  801c6f:	ff 75 0c             	pushl  0xc(%ebp)
  801c72:	ff 75 08             	pushl  0x8(%ebp)
  801c75:	6a 13                	push   $0x13
  801c77:	e8 9c fb ff ff       	call   801818 <syscall>
  801c7c:	83 c4 18             	add    $0x18,%esp
	return ;
  801c7f:	90                   	nop
}
  801c80:	c9                   	leave  
  801c81:	c3                   	ret    

00801c82 <sys_rcr2>:
uint32 sys_rcr2()
{
  801c82:	55                   	push   %ebp
  801c83:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801c85:	6a 00                	push   $0x0
  801c87:	6a 00                	push   $0x0
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 25                	push   $0x25
  801c91:	e8 82 fb ff ff       	call   801818 <syscall>
  801c96:	83 c4 18             	add    $0x18,%esp
}
  801c99:	c9                   	leave  
  801c9a:	c3                   	ret    

00801c9b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801c9b:	55                   	push   %ebp
  801c9c:	89 e5                	mov    %esp,%ebp
  801c9e:	83 ec 04             	sub    $0x4,%esp
  801ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801ca7:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	50                   	push   %eax
  801cb4:	6a 26                	push   $0x26
  801cb6:	e8 5d fb ff ff       	call   801818 <syscall>
  801cbb:	83 c4 18             	add    $0x18,%esp
	return ;
  801cbe:	90                   	nop
}
  801cbf:	c9                   	leave  
  801cc0:	c3                   	ret    

00801cc1 <rsttst>:
void rsttst()
{
  801cc1:	55                   	push   %ebp
  801cc2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 28                	push   $0x28
  801cd0:	e8 43 fb ff ff       	call   801818 <syscall>
  801cd5:	83 c4 18             	add    $0x18,%esp
	return ;
  801cd8:	90                   	nop
}
  801cd9:	c9                   	leave  
  801cda:	c3                   	ret    

00801cdb <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801cdb:	55                   	push   %ebp
  801cdc:	89 e5                	mov    %esp,%ebp
  801cde:	83 ec 04             	sub    $0x4,%esp
  801ce1:	8b 45 14             	mov    0x14(%ebp),%eax
  801ce4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ce7:	8b 55 18             	mov    0x18(%ebp),%edx
  801cea:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801cee:	52                   	push   %edx
  801cef:	50                   	push   %eax
  801cf0:	ff 75 10             	pushl  0x10(%ebp)
  801cf3:	ff 75 0c             	pushl  0xc(%ebp)
  801cf6:	ff 75 08             	pushl  0x8(%ebp)
  801cf9:	6a 27                	push   $0x27
  801cfb:	e8 18 fb ff ff       	call   801818 <syscall>
  801d00:	83 c4 18             	add    $0x18,%esp
	return ;
  801d03:	90                   	nop
}
  801d04:	c9                   	leave  
  801d05:	c3                   	ret    

00801d06 <chktst>:
void chktst(uint32 n)
{
  801d06:	55                   	push   %ebp
  801d07:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	ff 75 08             	pushl  0x8(%ebp)
  801d14:	6a 29                	push   $0x29
  801d16:	e8 fd fa ff ff       	call   801818 <syscall>
  801d1b:	83 c4 18             	add    $0x18,%esp
	return ;
  801d1e:	90                   	nop
}
  801d1f:	c9                   	leave  
  801d20:	c3                   	ret    

00801d21 <inctst>:

void inctst()
{
  801d21:	55                   	push   %ebp
  801d22:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801d24:	6a 00                	push   $0x0
  801d26:	6a 00                	push   $0x0
  801d28:	6a 00                	push   $0x0
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 2a                	push   $0x2a
  801d30:	e8 e3 fa ff ff       	call   801818 <syscall>
  801d35:	83 c4 18             	add    $0x18,%esp
	return ;
  801d38:	90                   	nop
}
  801d39:	c9                   	leave  
  801d3a:	c3                   	ret    

00801d3b <gettst>:
uint32 gettst()
{
  801d3b:	55                   	push   %ebp
  801d3c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801d3e:	6a 00                	push   $0x0
  801d40:	6a 00                	push   $0x0
  801d42:	6a 00                	push   $0x0
  801d44:	6a 00                	push   $0x0
  801d46:	6a 00                	push   $0x0
  801d48:	6a 2b                	push   $0x2b
  801d4a:	e8 c9 fa ff ff       	call   801818 <syscall>
  801d4f:	83 c4 18             	add    $0x18,%esp
}
  801d52:	c9                   	leave  
  801d53:	c3                   	ret    

00801d54 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801d54:	55                   	push   %ebp
  801d55:	89 e5                	mov    %esp,%ebp
  801d57:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d5a:	6a 00                	push   $0x0
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 00                	push   $0x0
  801d60:	6a 00                	push   $0x0
  801d62:	6a 00                	push   $0x0
  801d64:	6a 2c                	push   $0x2c
  801d66:	e8 ad fa ff ff       	call   801818 <syscall>
  801d6b:	83 c4 18             	add    $0x18,%esp
  801d6e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801d71:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801d75:	75 07                	jne    801d7e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801d77:	b8 01 00 00 00       	mov    $0x1,%eax
  801d7c:	eb 05                	jmp    801d83 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801d7e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d83:	c9                   	leave  
  801d84:	c3                   	ret    

00801d85 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801d85:	55                   	push   %ebp
  801d86:	89 e5                	mov    %esp,%ebp
  801d88:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d8b:	6a 00                	push   $0x0
  801d8d:	6a 00                	push   $0x0
  801d8f:	6a 00                	push   $0x0
  801d91:	6a 00                	push   $0x0
  801d93:	6a 00                	push   $0x0
  801d95:	6a 2c                	push   $0x2c
  801d97:	e8 7c fa ff ff       	call   801818 <syscall>
  801d9c:	83 c4 18             	add    $0x18,%esp
  801d9f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801da2:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801da6:	75 07                	jne    801daf <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801da8:	b8 01 00 00 00       	mov    $0x1,%eax
  801dad:	eb 05                	jmp    801db4 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801daf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801db4:	c9                   	leave  
  801db5:	c3                   	ret    

00801db6 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801db6:	55                   	push   %ebp
  801db7:	89 e5                	mov    %esp,%ebp
  801db9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 00                	push   $0x0
  801dc6:	6a 2c                	push   $0x2c
  801dc8:	e8 4b fa ff ff       	call   801818 <syscall>
  801dcd:	83 c4 18             	add    $0x18,%esp
  801dd0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801dd3:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801dd7:	75 07                	jne    801de0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801dd9:	b8 01 00 00 00       	mov    $0x1,%eax
  801dde:	eb 05                	jmp    801de5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801de0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801de5:	c9                   	leave  
  801de6:	c3                   	ret    

00801de7 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801de7:	55                   	push   %ebp
  801de8:	89 e5                	mov    %esp,%ebp
  801dea:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ded:	6a 00                	push   $0x0
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 2c                	push   $0x2c
  801df9:	e8 1a fa ff ff       	call   801818 <syscall>
  801dfe:	83 c4 18             	add    $0x18,%esp
  801e01:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801e04:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801e08:	75 07                	jne    801e11 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801e0a:	b8 01 00 00 00       	mov    $0x1,%eax
  801e0f:	eb 05                	jmp    801e16 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801e11:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801e16:	c9                   	leave  
  801e17:	c3                   	ret    

00801e18 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801e18:	55                   	push   %ebp
  801e19:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801e1b:	6a 00                	push   $0x0
  801e1d:	6a 00                	push   $0x0
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 00                	push   $0x0
  801e23:	ff 75 08             	pushl  0x8(%ebp)
  801e26:	6a 2d                	push   $0x2d
  801e28:	e8 eb f9 ff ff       	call   801818 <syscall>
  801e2d:	83 c4 18             	add    $0x18,%esp
	return ;
  801e30:	90                   	nop
}
  801e31:	c9                   	leave  
  801e32:	c3                   	ret    

00801e33 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801e33:	55                   	push   %ebp
  801e34:	89 e5                	mov    %esp,%ebp
  801e36:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801e37:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e3a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e3d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e40:	8b 45 08             	mov    0x8(%ebp),%eax
  801e43:	6a 00                	push   $0x0
  801e45:	53                   	push   %ebx
  801e46:	51                   	push   %ecx
  801e47:	52                   	push   %edx
  801e48:	50                   	push   %eax
  801e49:	6a 2e                	push   $0x2e
  801e4b:	e8 c8 f9 ff ff       	call   801818 <syscall>
  801e50:	83 c4 18             	add    $0x18,%esp
}
  801e53:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801e56:	c9                   	leave  
  801e57:	c3                   	ret    

00801e58 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801e58:	55                   	push   %ebp
  801e59:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801e5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e61:	6a 00                	push   $0x0
  801e63:	6a 00                	push   $0x0
  801e65:	6a 00                	push   $0x0
  801e67:	52                   	push   %edx
  801e68:	50                   	push   %eax
  801e69:	6a 2f                	push   $0x2f
  801e6b:	e8 a8 f9 ff ff       	call   801818 <syscall>
  801e70:	83 c4 18             	add    $0x18,%esp
}
  801e73:	c9                   	leave  
  801e74:	c3                   	ret    

00801e75 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801e75:	55                   	push   %ebp
  801e76:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801e78:	6a 00                	push   $0x0
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 00                	push   $0x0
  801e7e:	ff 75 0c             	pushl  0xc(%ebp)
  801e81:	ff 75 08             	pushl  0x8(%ebp)
  801e84:	6a 30                	push   $0x30
  801e86:	e8 8d f9 ff ff       	call   801818 <syscall>
  801e8b:	83 c4 18             	add    $0x18,%esp
	return ;
  801e8e:	90                   	nop
}
  801e8f:	c9                   	leave  
  801e90:	c3                   	ret    

00801e91 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801e91:	55                   	push   %ebp
  801e92:	89 e5                	mov    %esp,%ebp
  801e94:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801e97:	8b 55 08             	mov    0x8(%ebp),%edx
  801e9a:	89 d0                	mov    %edx,%eax
  801e9c:	c1 e0 02             	shl    $0x2,%eax
  801e9f:	01 d0                	add    %edx,%eax
  801ea1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ea8:	01 d0                	add    %edx,%eax
  801eaa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801eb1:	01 d0                	add    %edx,%eax
  801eb3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801eba:	01 d0                	add    %edx,%eax
  801ebc:	c1 e0 04             	shl    $0x4,%eax
  801ebf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801ec2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801ec9:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801ecc:	83 ec 0c             	sub    $0xc,%esp
  801ecf:	50                   	push   %eax
  801ed0:	e8 5a fd ff ff       	call   801c2f <sys_get_virtual_time>
  801ed5:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801ed8:	eb 41                	jmp    801f1b <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801eda:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801edd:	83 ec 0c             	sub    $0xc,%esp
  801ee0:	50                   	push   %eax
  801ee1:	e8 49 fd ff ff       	call   801c2f <sys_get_virtual_time>
  801ee6:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801ee9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801eec:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801eef:	29 c2                	sub    %eax,%edx
  801ef1:	89 d0                	mov    %edx,%eax
  801ef3:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801ef6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801ef9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801efc:	89 d1                	mov    %edx,%ecx
  801efe:	29 c1                	sub    %eax,%ecx
  801f00:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801f03:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801f06:	39 c2                	cmp    %eax,%edx
  801f08:	0f 97 c0             	seta   %al
  801f0b:	0f b6 c0             	movzbl %al,%eax
  801f0e:	29 c1                	sub    %eax,%ecx
  801f10:	89 c8                	mov    %ecx,%eax
  801f12:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801f15:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801f18:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801f1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f1e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801f21:	72 b7                	jb     801eda <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801f23:	90                   	nop
  801f24:	c9                   	leave  
  801f25:	c3                   	ret    

00801f26 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801f26:	55                   	push   %ebp
  801f27:	89 e5                	mov    %esp,%ebp
  801f29:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801f2c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801f33:	eb 03                	jmp    801f38 <busy_wait+0x12>
  801f35:	ff 45 fc             	incl   -0x4(%ebp)
  801f38:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801f3b:	3b 45 08             	cmp    0x8(%ebp),%eax
  801f3e:	72 f5                	jb     801f35 <busy_wait+0xf>
	return i;
  801f40:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801f43:	c9                   	leave  
  801f44:	c3                   	ret    
  801f45:	66 90                	xchg   %ax,%ax
  801f47:	90                   	nop

00801f48 <__udivdi3>:
  801f48:	55                   	push   %ebp
  801f49:	57                   	push   %edi
  801f4a:	56                   	push   %esi
  801f4b:	53                   	push   %ebx
  801f4c:	83 ec 1c             	sub    $0x1c,%esp
  801f4f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801f53:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801f57:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f5b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801f5f:	89 ca                	mov    %ecx,%edx
  801f61:	89 f8                	mov    %edi,%eax
  801f63:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801f67:	85 f6                	test   %esi,%esi
  801f69:	75 2d                	jne    801f98 <__udivdi3+0x50>
  801f6b:	39 cf                	cmp    %ecx,%edi
  801f6d:	77 65                	ja     801fd4 <__udivdi3+0x8c>
  801f6f:	89 fd                	mov    %edi,%ebp
  801f71:	85 ff                	test   %edi,%edi
  801f73:	75 0b                	jne    801f80 <__udivdi3+0x38>
  801f75:	b8 01 00 00 00       	mov    $0x1,%eax
  801f7a:	31 d2                	xor    %edx,%edx
  801f7c:	f7 f7                	div    %edi
  801f7e:	89 c5                	mov    %eax,%ebp
  801f80:	31 d2                	xor    %edx,%edx
  801f82:	89 c8                	mov    %ecx,%eax
  801f84:	f7 f5                	div    %ebp
  801f86:	89 c1                	mov    %eax,%ecx
  801f88:	89 d8                	mov    %ebx,%eax
  801f8a:	f7 f5                	div    %ebp
  801f8c:	89 cf                	mov    %ecx,%edi
  801f8e:	89 fa                	mov    %edi,%edx
  801f90:	83 c4 1c             	add    $0x1c,%esp
  801f93:	5b                   	pop    %ebx
  801f94:	5e                   	pop    %esi
  801f95:	5f                   	pop    %edi
  801f96:	5d                   	pop    %ebp
  801f97:	c3                   	ret    
  801f98:	39 ce                	cmp    %ecx,%esi
  801f9a:	77 28                	ja     801fc4 <__udivdi3+0x7c>
  801f9c:	0f bd fe             	bsr    %esi,%edi
  801f9f:	83 f7 1f             	xor    $0x1f,%edi
  801fa2:	75 40                	jne    801fe4 <__udivdi3+0x9c>
  801fa4:	39 ce                	cmp    %ecx,%esi
  801fa6:	72 0a                	jb     801fb2 <__udivdi3+0x6a>
  801fa8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801fac:	0f 87 9e 00 00 00    	ja     802050 <__udivdi3+0x108>
  801fb2:	b8 01 00 00 00       	mov    $0x1,%eax
  801fb7:	89 fa                	mov    %edi,%edx
  801fb9:	83 c4 1c             	add    $0x1c,%esp
  801fbc:	5b                   	pop    %ebx
  801fbd:	5e                   	pop    %esi
  801fbe:	5f                   	pop    %edi
  801fbf:	5d                   	pop    %ebp
  801fc0:	c3                   	ret    
  801fc1:	8d 76 00             	lea    0x0(%esi),%esi
  801fc4:	31 ff                	xor    %edi,%edi
  801fc6:	31 c0                	xor    %eax,%eax
  801fc8:	89 fa                	mov    %edi,%edx
  801fca:	83 c4 1c             	add    $0x1c,%esp
  801fcd:	5b                   	pop    %ebx
  801fce:	5e                   	pop    %esi
  801fcf:	5f                   	pop    %edi
  801fd0:	5d                   	pop    %ebp
  801fd1:	c3                   	ret    
  801fd2:	66 90                	xchg   %ax,%ax
  801fd4:	89 d8                	mov    %ebx,%eax
  801fd6:	f7 f7                	div    %edi
  801fd8:	31 ff                	xor    %edi,%edi
  801fda:	89 fa                	mov    %edi,%edx
  801fdc:	83 c4 1c             	add    $0x1c,%esp
  801fdf:	5b                   	pop    %ebx
  801fe0:	5e                   	pop    %esi
  801fe1:	5f                   	pop    %edi
  801fe2:	5d                   	pop    %ebp
  801fe3:	c3                   	ret    
  801fe4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801fe9:	89 eb                	mov    %ebp,%ebx
  801feb:	29 fb                	sub    %edi,%ebx
  801fed:	89 f9                	mov    %edi,%ecx
  801fef:	d3 e6                	shl    %cl,%esi
  801ff1:	89 c5                	mov    %eax,%ebp
  801ff3:	88 d9                	mov    %bl,%cl
  801ff5:	d3 ed                	shr    %cl,%ebp
  801ff7:	89 e9                	mov    %ebp,%ecx
  801ff9:	09 f1                	or     %esi,%ecx
  801ffb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801fff:	89 f9                	mov    %edi,%ecx
  802001:	d3 e0                	shl    %cl,%eax
  802003:	89 c5                	mov    %eax,%ebp
  802005:	89 d6                	mov    %edx,%esi
  802007:	88 d9                	mov    %bl,%cl
  802009:	d3 ee                	shr    %cl,%esi
  80200b:	89 f9                	mov    %edi,%ecx
  80200d:	d3 e2                	shl    %cl,%edx
  80200f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802013:	88 d9                	mov    %bl,%cl
  802015:	d3 e8                	shr    %cl,%eax
  802017:	09 c2                	or     %eax,%edx
  802019:	89 d0                	mov    %edx,%eax
  80201b:	89 f2                	mov    %esi,%edx
  80201d:	f7 74 24 0c          	divl   0xc(%esp)
  802021:	89 d6                	mov    %edx,%esi
  802023:	89 c3                	mov    %eax,%ebx
  802025:	f7 e5                	mul    %ebp
  802027:	39 d6                	cmp    %edx,%esi
  802029:	72 19                	jb     802044 <__udivdi3+0xfc>
  80202b:	74 0b                	je     802038 <__udivdi3+0xf0>
  80202d:	89 d8                	mov    %ebx,%eax
  80202f:	31 ff                	xor    %edi,%edi
  802031:	e9 58 ff ff ff       	jmp    801f8e <__udivdi3+0x46>
  802036:	66 90                	xchg   %ax,%ax
  802038:	8b 54 24 08          	mov    0x8(%esp),%edx
  80203c:	89 f9                	mov    %edi,%ecx
  80203e:	d3 e2                	shl    %cl,%edx
  802040:	39 c2                	cmp    %eax,%edx
  802042:	73 e9                	jae    80202d <__udivdi3+0xe5>
  802044:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802047:	31 ff                	xor    %edi,%edi
  802049:	e9 40 ff ff ff       	jmp    801f8e <__udivdi3+0x46>
  80204e:	66 90                	xchg   %ax,%ax
  802050:	31 c0                	xor    %eax,%eax
  802052:	e9 37 ff ff ff       	jmp    801f8e <__udivdi3+0x46>
  802057:	90                   	nop

00802058 <__umoddi3>:
  802058:	55                   	push   %ebp
  802059:	57                   	push   %edi
  80205a:	56                   	push   %esi
  80205b:	53                   	push   %ebx
  80205c:	83 ec 1c             	sub    $0x1c,%esp
  80205f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802063:	8b 74 24 34          	mov    0x34(%esp),%esi
  802067:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80206b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80206f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802073:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802077:	89 f3                	mov    %esi,%ebx
  802079:	89 fa                	mov    %edi,%edx
  80207b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80207f:	89 34 24             	mov    %esi,(%esp)
  802082:	85 c0                	test   %eax,%eax
  802084:	75 1a                	jne    8020a0 <__umoddi3+0x48>
  802086:	39 f7                	cmp    %esi,%edi
  802088:	0f 86 a2 00 00 00    	jbe    802130 <__umoddi3+0xd8>
  80208e:	89 c8                	mov    %ecx,%eax
  802090:	89 f2                	mov    %esi,%edx
  802092:	f7 f7                	div    %edi
  802094:	89 d0                	mov    %edx,%eax
  802096:	31 d2                	xor    %edx,%edx
  802098:	83 c4 1c             	add    $0x1c,%esp
  80209b:	5b                   	pop    %ebx
  80209c:	5e                   	pop    %esi
  80209d:	5f                   	pop    %edi
  80209e:	5d                   	pop    %ebp
  80209f:	c3                   	ret    
  8020a0:	39 f0                	cmp    %esi,%eax
  8020a2:	0f 87 ac 00 00 00    	ja     802154 <__umoddi3+0xfc>
  8020a8:	0f bd e8             	bsr    %eax,%ebp
  8020ab:	83 f5 1f             	xor    $0x1f,%ebp
  8020ae:	0f 84 ac 00 00 00    	je     802160 <__umoddi3+0x108>
  8020b4:	bf 20 00 00 00       	mov    $0x20,%edi
  8020b9:	29 ef                	sub    %ebp,%edi
  8020bb:	89 fe                	mov    %edi,%esi
  8020bd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8020c1:	89 e9                	mov    %ebp,%ecx
  8020c3:	d3 e0                	shl    %cl,%eax
  8020c5:	89 d7                	mov    %edx,%edi
  8020c7:	89 f1                	mov    %esi,%ecx
  8020c9:	d3 ef                	shr    %cl,%edi
  8020cb:	09 c7                	or     %eax,%edi
  8020cd:	89 e9                	mov    %ebp,%ecx
  8020cf:	d3 e2                	shl    %cl,%edx
  8020d1:	89 14 24             	mov    %edx,(%esp)
  8020d4:	89 d8                	mov    %ebx,%eax
  8020d6:	d3 e0                	shl    %cl,%eax
  8020d8:	89 c2                	mov    %eax,%edx
  8020da:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020de:	d3 e0                	shl    %cl,%eax
  8020e0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8020e4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8020e8:	89 f1                	mov    %esi,%ecx
  8020ea:	d3 e8                	shr    %cl,%eax
  8020ec:	09 d0                	or     %edx,%eax
  8020ee:	d3 eb                	shr    %cl,%ebx
  8020f0:	89 da                	mov    %ebx,%edx
  8020f2:	f7 f7                	div    %edi
  8020f4:	89 d3                	mov    %edx,%ebx
  8020f6:	f7 24 24             	mull   (%esp)
  8020f9:	89 c6                	mov    %eax,%esi
  8020fb:	89 d1                	mov    %edx,%ecx
  8020fd:	39 d3                	cmp    %edx,%ebx
  8020ff:	0f 82 87 00 00 00    	jb     80218c <__umoddi3+0x134>
  802105:	0f 84 91 00 00 00    	je     80219c <__umoddi3+0x144>
  80210b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80210f:	29 f2                	sub    %esi,%edx
  802111:	19 cb                	sbb    %ecx,%ebx
  802113:	89 d8                	mov    %ebx,%eax
  802115:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802119:	d3 e0                	shl    %cl,%eax
  80211b:	89 e9                	mov    %ebp,%ecx
  80211d:	d3 ea                	shr    %cl,%edx
  80211f:	09 d0                	or     %edx,%eax
  802121:	89 e9                	mov    %ebp,%ecx
  802123:	d3 eb                	shr    %cl,%ebx
  802125:	89 da                	mov    %ebx,%edx
  802127:	83 c4 1c             	add    $0x1c,%esp
  80212a:	5b                   	pop    %ebx
  80212b:	5e                   	pop    %esi
  80212c:	5f                   	pop    %edi
  80212d:	5d                   	pop    %ebp
  80212e:	c3                   	ret    
  80212f:	90                   	nop
  802130:	89 fd                	mov    %edi,%ebp
  802132:	85 ff                	test   %edi,%edi
  802134:	75 0b                	jne    802141 <__umoddi3+0xe9>
  802136:	b8 01 00 00 00       	mov    $0x1,%eax
  80213b:	31 d2                	xor    %edx,%edx
  80213d:	f7 f7                	div    %edi
  80213f:	89 c5                	mov    %eax,%ebp
  802141:	89 f0                	mov    %esi,%eax
  802143:	31 d2                	xor    %edx,%edx
  802145:	f7 f5                	div    %ebp
  802147:	89 c8                	mov    %ecx,%eax
  802149:	f7 f5                	div    %ebp
  80214b:	89 d0                	mov    %edx,%eax
  80214d:	e9 44 ff ff ff       	jmp    802096 <__umoddi3+0x3e>
  802152:	66 90                	xchg   %ax,%ax
  802154:	89 c8                	mov    %ecx,%eax
  802156:	89 f2                	mov    %esi,%edx
  802158:	83 c4 1c             	add    $0x1c,%esp
  80215b:	5b                   	pop    %ebx
  80215c:	5e                   	pop    %esi
  80215d:	5f                   	pop    %edi
  80215e:	5d                   	pop    %ebp
  80215f:	c3                   	ret    
  802160:	3b 04 24             	cmp    (%esp),%eax
  802163:	72 06                	jb     80216b <__umoddi3+0x113>
  802165:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802169:	77 0f                	ja     80217a <__umoddi3+0x122>
  80216b:	89 f2                	mov    %esi,%edx
  80216d:	29 f9                	sub    %edi,%ecx
  80216f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802173:	89 14 24             	mov    %edx,(%esp)
  802176:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80217a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80217e:	8b 14 24             	mov    (%esp),%edx
  802181:	83 c4 1c             	add    $0x1c,%esp
  802184:	5b                   	pop    %ebx
  802185:	5e                   	pop    %esi
  802186:	5f                   	pop    %edi
  802187:	5d                   	pop    %ebp
  802188:	c3                   	ret    
  802189:	8d 76 00             	lea    0x0(%esi),%esi
  80218c:	2b 04 24             	sub    (%esp),%eax
  80218f:	19 fa                	sbb    %edi,%edx
  802191:	89 d1                	mov    %edx,%ecx
  802193:	89 c6                	mov    %eax,%esi
  802195:	e9 71 ff ff ff       	jmp    80210b <__umoddi3+0xb3>
  80219a:	66 90                	xchg   %ax,%ax
  80219c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8021a0:	72 ea                	jb     80218c <__umoddi3+0x134>
  8021a2:	89 d9                	mov    %ebx,%ecx
  8021a4:	e9 62 ff ff ff       	jmp    80210b <__umoddi3+0xb3>
