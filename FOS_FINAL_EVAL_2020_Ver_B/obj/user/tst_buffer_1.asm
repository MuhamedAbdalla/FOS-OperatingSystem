
obj/user/tst_buffer_1:     file format elf32-i386


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
  800031:	e8 87 05 00 00       	call   8005bd <libmain>
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
  80003b:	83 ec 58             	sub    $0x58,%esp



  //("STEP 0: checking Initial WS entries ...\n");
  {
    if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800049:	8b 00                	mov    (%eax),%eax
  80004b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80004e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800051:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800056:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005b:	74 14                	je     800071 <_main+0x39>
  80005d:	83 ec 04             	sub    $0x4,%esp
  800060:	68 00 20 80 00       	push   $0x802000
  800065:	6a 16                	push   $0x16
  800067:	68 48 20 80 00       	push   $0x802048
  80006c:	e8 71 06 00 00       	call   8006e2 <_panic>
    if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800071:	a1 20 30 80 00       	mov    0x803020,%eax
  800076:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80007c:	83 c0 14             	add    $0x14,%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800084:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 00 20 80 00       	push   $0x802000
  80009b:	6a 17                	push   $0x17
  80009d:	68 48 20 80 00       	push   $0x802048
  8000a2:	e8 3b 06 00 00       	call   8006e2 <_panic>
    if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ac:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8000b2:	83 c0 28             	add    $0x28,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000ba:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 00 20 80 00       	push   $0x802000
  8000d1:	6a 18                	push   $0x18
  8000d3:	68 48 20 80 00       	push   $0x802048
  8000d8:	e8 05 06 00 00       	call   8006e2 <_panic>
    if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8000e8:	83 c0 3c             	add    $0x3c,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8000f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 00 20 80 00       	push   $0x802000
  800107:	6a 19                	push   $0x19
  800109:	68 48 20 80 00       	push   $0x802048
  80010e:	e8 cf 05 00 00       	call   8006e2 <_panic>
    if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800113:	a1 20 30 80 00       	mov    0x803020,%eax
  800118:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80011e:	83 c0 50             	add    $0x50,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800126:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 00 20 80 00       	push   $0x802000
  80013d:	6a 1a                	push   $0x1a
  80013f:	68 48 20 80 00       	push   $0x802048
  800144:	e8 99 05 00 00       	call   8006e2 <_panic>
    if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800149:	a1 20 30 80 00       	mov    0x803020,%eax
  80014e:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800154:	83 c0 64             	add    $0x64,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80015c:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 00 20 80 00       	push   $0x802000
  800173:	6a 1b                	push   $0x1b
  800175:	68 48 20 80 00       	push   $0x802048
  80017a:	e8 63 05 00 00       	call   8006e2 <_panic>
    if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80017f:	a1 20 30 80 00       	mov    0x803020,%eax
  800184:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  80018a:	83 c0 78             	add    $0x78,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  800192:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 00 20 80 00       	push   $0x802000
  8001a9:	6a 1c                	push   $0x1c
  8001ab:	68 48 20 80 00       	push   $0x802048
  8001b0:	e8 2d 05 00 00       	call   8006e2 <_panic>
    if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ba:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8001c0:	05 8c 00 00 00       	add    $0x8c,%eax
  8001c5:	8b 00                	mov    (%eax),%eax
  8001c7:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8001ca:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d2:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d7:	74 14                	je     8001ed <_main+0x1b5>
  8001d9:	83 ec 04             	sub    $0x4,%esp
  8001dc:	68 00 20 80 00       	push   $0x802000
  8001e1:	6a 1d                	push   $0x1d
  8001e3:	68 48 20 80 00       	push   $0x802048
  8001e8:	e8 f5 04 00 00       	call   8006e2 <_panic>
    if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8001ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f2:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  8001f8:	05 a0 00 00 00       	add    $0xa0,%eax
  8001fd:	8b 00                	mov    (%eax),%eax
  8001ff:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800202:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800205:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80020a:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020f:	74 14                	je     800225 <_main+0x1ed>
  800211:	83 ec 04             	sub    $0x4,%esp
  800214:	68 00 20 80 00       	push   $0x802000
  800219:	6a 1e                	push   $0x1e
  80021b:	68 48 20 80 00       	push   $0x802048
  800220:	e8 bd 04 00 00       	call   8006e2 <_panic>
    if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800225:	a1 20 30 80 00       	mov    0x803020,%eax
  80022a:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800230:	05 b4 00 00 00       	add    $0xb4,%eax
  800235:	8b 00                	mov    (%eax),%eax
  800237:	89 45 b8             	mov    %eax,-0x48(%ebp)
  80023a:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80023d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800242:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800247:	74 14                	je     80025d <_main+0x225>
  800249:	83 ec 04             	sub    $0x4,%esp
  80024c:	68 00 20 80 00       	push   $0x802000
  800251:	6a 1f                	push   $0x1f
  800253:	68 48 20 80 00       	push   $0x802048
  800258:	e8 85 04 00 00       	call   8006e2 <_panic>
    if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80025d:	a1 20 30 80 00       	mov    0x803020,%eax
  800262:	8b 80 f0 52 00 00    	mov    0x52f0(%eax),%eax
  800268:	05 c8 00 00 00       	add    $0xc8,%eax
  80026d:	8b 00                	mov    (%eax),%eax
  80026f:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800272:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800275:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80027a:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80027f:	74 14                	je     800295 <_main+0x25d>
  800281:	83 ec 04             	sub    $0x4,%esp
  800284:	68 00 20 80 00       	push   $0x802000
  800289:	6a 20                	push   $0x20
  80028b:	68 48 20 80 00       	push   $0x802048
  800290:	e8 4d 04 00 00       	call   8006e2 <_panic>
    if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review sizes of the two WS's..!!");
  800295:	a1 20 30 80 00       	mov    0x803020,%eax
  80029a:	8b 80 80 52 00 00    	mov    0x5280(%eax),%eax
  8002a0:	85 c0                	test   %eax,%eax
  8002a2:	74 14                	je     8002b8 <_main+0x280>
  8002a4:	83 ec 04             	sub    $0x4,%esp
  8002a7:	68 5c 20 80 00       	push   $0x80205c
  8002ac:	6a 21                	push   $0x21
  8002ae:	68 48 20 80 00       	push   $0x802048
  8002b3:	e8 2a 04 00 00       	call   8006e2 <_panic>
  }

  int initModBufCnt = sys_calculate_modified_frames();
  8002b8:	e8 eb 15 00 00       	call   8018a8 <sys_calculate_modified_frames>
  8002bd:	89 45 b0             	mov    %eax,-0x50(%ebp)
  int initFreeBufCnt = sys_calculate_notmod_frames();
  8002c0:	e8 fc 15 00 00       	call   8018c1 <sys_calculate_notmod_frames>
  8002c5:	89 45 ac             	mov    %eax,-0x54(%ebp)
  int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002c8:	e8 45 16 00 00       	call   801912 <sys_pf_calculate_allocated_pages>
  8002cd:	89 45 a8             	mov    %eax,-0x58(%ebp)

  //[1]Bring 7 pages and modify them (7 unmodified will be buffered)
  int i=0;
  8002d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  int dstSum1 = 0;
  8002d7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  //cprintf("not modified frames= %d\n", sys_calculate_notmod_frames());
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
    dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  800301:	e8 bb 15 00 00       	call   8018c1 <sys_calculate_notmod_frames>
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
  //cprintf("not modified frames= %d\n", sys_calculate_notmod_frames());
  int dummy = 0;
  for(i=(PAGE_SIZE/4);i<arrSize;i+=PAGE_SIZE/4)
  80031a:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  800321:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800328:	7e c4                	jle    8002ee <_main+0x2b6>
    dstSum1 += i;
    dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  }


  if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  80032a:	e8 92 15 00 00       	call   8018c1 <sys_calculate_notmod_frames>
  80032f:	89 c2                	mov    %eax,%edx
  800331:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800334:	29 c2                	sub    %eax,%edx
  800336:	89 d0                	mov    %edx,%eax
  800338:	83 f8 07             	cmp    $0x7,%eax
  80033b:	74 14                	je     800351 <_main+0x319>
  80033d:	83 ec 04             	sub    $0x4,%esp
  800340:	68 ac 20 80 00       	push   $0x8020ac
  800345:	6a 35                	push   $0x35
  800347:	68 48 20 80 00       	push   $0x802048
  80034c:	e8 91 03 00 00       	call   8006e2 <_panic>
  if (sys_calculate_modified_frames() - initModBufCnt  != 0)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800351:	e8 52 15 00 00       	call   8018a8 <sys_calculate_modified_frames>
  800356:	89 c2                	mov    %eax,%edx
  800358:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80035b:	39 c2                	cmp    %eax,%edx
  80035d:	74 14                	je     800373 <_main+0x33b>
  80035f:	83 ec 04             	sub    $0x4,%esp
  800362:	68 10 21 80 00       	push   $0x802110
  800367:	6a 36                	push   $0x36
  800369:	68 48 20 80 00       	push   $0x802048
  80036e:	e8 6f 03 00 00       	call   8006e2 <_panic>

  initFreeBufCnt = sys_calculate_notmod_frames();
  800373:	e8 49 15 00 00       	call   8018c1 <sys_calculate_notmod_frames>
  800378:	89 45 ac             	mov    %eax,-0x54(%ebp)
  initModBufCnt = sys_calculate_modified_frames();
  80037b:	e8 28 15 00 00       	call   8018a8 <sys_calculate_modified_frames>
  800380:	89 45 b0             	mov    %eax,-0x50(%ebp)

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
    dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  8003a0:	e8 1c 15 00 00       	call   8018c1 <sys_calculate_notmod_frames>
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
  {
    srcSum1 += src[i];
    dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  }

  if (sys_calculate_notmod_frames()  - initFreeBufCnt != 0)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  8003c9:	e8 f3 14 00 00       	call   8018c1 <sys_calculate_notmod_frames>
  8003ce:	89 c2                	mov    %eax,%edx
  8003d0:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8003d3:	39 c2                	cmp    %eax,%edx
  8003d5:	74 14                	je     8003eb <_main+0x3b3>
  8003d7:	83 ec 04             	sub    $0x4,%esp
  8003da:	68 ac 20 80 00       	push   $0x8020ac
  8003df:	6a 44                	push   $0x44
  8003e1:	68 48 20 80 00       	push   $0x802048
  8003e6:	e8 f7 02 00 00       	call   8006e2 <_panic>
  if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  8003eb:	e8 b8 14 00 00       	call   8018a8 <sys_calculate_modified_frames>
  8003f0:	89 c2                	mov    %eax,%edx
  8003f2:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8003f5:	29 c2                	sub    %eax,%edx
  8003f7:	89 d0                	mov    %edx,%eax
  8003f9:	83 f8 07             	cmp    $0x7,%eax
  8003fc:	74 14                	je     800412 <_main+0x3da>
  8003fe:	83 ec 04             	sub    $0x4,%esp
  800401:	68 10 21 80 00       	push   $0x802110
  800406:	6a 45                	push   $0x45
  800408:	68 48 20 80 00       	push   $0x802048
  80040d:	e8 d0 02 00 00       	call   8006e2 <_panic>
  initFreeBufCnt = sys_calculate_notmod_frames();
  800412:	e8 aa 14 00 00       	call   8018c1 <sys_calculate_notmod_frames>
  800417:	89 45 ac             	mov    %eax,-0x54(%ebp)
  initModBufCnt = sys_calculate_modified_frames();
  80041a:	e8 89 14 00 00       	call   8018a8 <sys_calculate_modified_frames>
  80041f:	89 45 b0             	mov    %eax,-0x50(%ebp)

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
    dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  800446:	e8 76 14 00 00       	call   8018c1 <sys_calculate_notmod_frames>
  80044b:	89 c2                	mov    %eax,%edx
  80044d:	a1 20 30 80 00       	mov    0x803020,%eax
  800452:	8b 40 4c             	mov    0x4c(%eax),%eax
  800455:	01 c2                	add    %eax,%edx
  800457:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80045a:	01 d0                	add    %edx,%eax
  80045c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  initModBufCnt = sys_calculate_modified_frames();

  //[3]Bring the 7 modified pages again and ensure their values are correct (7 unmodified will be buffered)
  i = 0;
  int dstSum2 = 0 ;
  for(i=PAGE_SIZE/4;i<arrSize;i+=PAGE_SIZE/4)
  80045f:	81 45 f4 00 04 00 00 	addl   $0x400,-0xc(%ebp)
  800466:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  80046d:	7e ca                	jle    800439 <_main+0x401>
  {
    dstSum2 += dst[i];
    dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  }

  if (sys_calculate_notmod_frames()  - initFreeBufCnt != 7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  80046f:	e8 4d 14 00 00       	call   8018c1 <sys_calculate_notmod_frames>
  800474:	89 c2                	mov    %eax,%edx
  800476:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800479:	29 c2                	sub    %eax,%edx
  80047b:	89 d0                	mov    %edx,%eax
  80047d:	83 f8 07             	cmp    $0x7,%eax
  800480:	74 14                	je     800496 <_main+0x45e>
  800482:	83 ec 04             	sub    $0x4,%esp
  800485:	68 ac 20 80 00       	push   $0x8020ac
  80048a:	6a 52                	push   $0x52
  80048c:	68 48 20 80 00       	push   $0x802048
  800491:	e8 4c 02 00 00       	call   8006e2 <_panic>
  if (sys_calculate_modified_frames() - initModBufCnt  != -7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800496:	e8 0d 14 00 00       	call   8018a8 <sys_calculate_modified_frames>
  80049b:	89 c2                	mov    %eax,%edx
  80049d:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8004a0:	29 c2                	sub    %eax,%edx
  8004a2:	89 d0                	mov    %edx,%eax
  8004a4:	83 f8 f9             	cmp    $0xfffffff9,%eax
  8004a7:	74 14                	je     8004bd <_main+0x485>
  8004a9:	83 ec 04             	sub    $0x4,%esp
  8004ac:	68 10 21 80 00       	push   $0x802110
  8004b1:	6a 53                	push   $0x53
  8004b3:	68 48 20 80 00       	push   $0x802048
  8004b8:	e8 25 02 00 00       	call   8006e2 <_panic>

  initFreeBufCnt = sys_calculate_notmod_frames();
  8004bd:	e8 ff 13 00 00       	call   8018c1 <sys_calculate_notmod_frames>
  8004c2:	89 45 ac             	mov    %eax,-0x54(%ebp)
  initModBufCnt = sys_calculate_modified_frames();
  8004c5:	e8 de 13 00 00       	call   8018a8 <sys_calculate_modified_frames>
  8004ca:	89 45 b0             	mov    %eax,-0x50(%ebp)

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
    dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  8004f1:	e8 cb 13 00 00       	call   8018c1 <sys_calculate_notmod_frames>
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
    dummy += sys_calculate_notmod_frames() + myEnv->env_id; //Always use page #: 800000, 801000, 803000
  }

  if (sys_calculate_notmod_frames()  - initFreeBufCnt != -7)  panic("Error in BUFFERING/RESTORING of free frames... WRONG number of buffered pages in FREE frame list");
  80051a:	e8 a2 13 00 00       	call   8018c1 <sys_calculate_notmod_frames>
  80051f:	89 c2                	mov    %eax,%edx
  800521:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800524:	29 c2                	sub    %eax,%edx
  800526:	89 d0                	mov    %edx,%eax
  800528:	83 f8 f9             	cmp    $0xfffffff9,%eax
  80052b:	74 14                	je     800541 <_main+0x509>
  80052d:	83 ec 04             	sub    $0x4,%esp
  800530:	68 ac 20 80 00       	push   $0x8020ac
  800535:	6a 61                	push   $0x61
  800537:	68 48 20 80 00       	push   $0x802048
  80053c:	e8 a1 01 00 00       	call   8006e2 <_panic>
  if (sys_calculate_modified_frames() - initModBufCnt  != 7)  panic("Error in BUFFERING/RESTORING of modified frames... WRONG number of buffered pages in MODIFIED frame list");
  800541:	e8 62 13 00 00       	call   8018a8 <sys_calculate_modified_frames>
  800546:	89 c2                	mov    %eax,%edx
  800548:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80054b:	29 c2                	sub    %eax,%edx
  80054d:	89 d0                	mov    %edx,%eax
  80054f:	83 f8 07             	cmp    $0x7,%eax
  800552:	74 14                	je     800568 <_main+0x530>
  800554:	83 ec 04             	sub    $0x4,%esp
  800557:	68 10 21 80 00       	push   $0x802110
  80055c:	6a 62                	push   $0x62
  80055e:	68 48 20 80 00       	push   $0x802048
  800563:	e8 7a 01 00 00       	call   8006e2 <_panic>

  if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add any new page to the page file");
  800568:	e8 a5 13 00 00       	call   801912 <sys_pf_calculate_allocated_pages>
  80056d:	3b 45 a8             	cmp    -0x58(%ebp),%eax
  800570:	74 14                	je     800586 <_main+0x54e>
  800572:	83 ec 04             	sub    $0x4,%esp
  800575:	68 7c 21 80 00       	push   $0x80217c
  80057a:	6a 64                	push   $0x64
  80057c:	68 48 20 80 00       	push   $0x802048
  800581:	e8 5c 01 00 00       	call   8006e2 <_panic>

  if (srcSum1 != srcSum2 || dstSum1 != dstSum2) 	panic("Error in buffering/restoring modified/not modified pages") ;
  800586:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800589:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80058c:	75 08                	jne    800596 <_main+0x55e>
  80058e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800591:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800594:	74 14                	je     8005aa <_main+0x572>
  800596:	83 ec 04             	sub    $0x4,%esp
  800599:	68 ec 21 80 00       	push   $0x8021ec
  80059e:	6a 66                	push   $0x66
  8005a0:	68 48 20 80 00       	push   $0x802048
  8005a5:	e8 38 01 00 00       	call   8006e2 <_panic>

  cprintf("Congratulations!! test buffered pages inside REPLACEMENT is completed successfully.\n");
  8005aa:	83 ec 0c             	sub    $0xc,%esp
  8005ad:	68 28 22 80 00       	push   $0x802228
  8005b2:	e8 e2 03 00 00       	call   800999 <cprintf>
  8005b7:	83 c4 10             	add    $0x10,%esp
  return;
  8005ba:	90                   	nop

}
  8005bb:	c9                   	leave  
  8005bc:	c3                   	ret    

008005bd <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005bd:	55                   	push   %ebp
  8005be:	89 e5                	mov    %esp,%ebp
  8005c0:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005c3:	e8 fc 11 00 00       	call   8017c4 <sys_getenvindex>
  8005c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005cb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005ce:	89 d0                	mov    %edx,%eax
  8005d0:	c1 e0 03             	shl    $0x3,%eax
  8005d3:	01 d0                	add    %edx,%eax
  8005d5:	c1 e0 02             	shl    $0x2,%eax
  8005d8:	01 d0                	add    %edx,%eax
  8005da:	c1 e0 06             	shl    $0x6,%eax
  8005dd:	29 d0                	sub    %edx,%eax
  8005df:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8005e6:	01 c8                	add    %ecx,%eax
  8005e8:	01 d0                	add    %edx,%eax
  8005ea:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8005ef:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005f4:	a1 20 30 80 00       	mov    0x803020,%eax
  8005f9:	8a 80 b0 52 00 00    	mov    0x52b0(%eax),%al
  8005ff:	84 c0                	test   %al,%al
  800601:	74 0f                	je     800612 <libmain+0x55>
		binaryname = myEnv->prog_name;
  800603:	a1 20 30 80 00       	mov    0x803020,%eax
  800608:	05 b0 52 00 00       	add    $0x52b0,%eax
  80060d:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800612:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800616:	7e 0a                	jle    800622 <libmain+0x65>
		binaryname = argv[0];
  800618:	8b 45 0c             	mov    0xc(%ebp),%eax
  80061b:	8b 00                	mov    (%eax),%eax
  80061d:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800622:	83 ec 08             	sub    $0x8,%esp
  800625:	ff 75 0c             	pushl  0xc(%ebp)
  800628:	ff 75 08             	pushl  0x8(%ebp)
  80062b:	e8 08 fa ff ff       	call   800038 <_main>
  800630:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800633:	e8 27 13 00 00       	call   80195f <sys_disable_interrupt>
	cprintf("**************************************\n");
  800638:	83 ec 0c             	sub    $0xc,%esp
  80063b:	68 98 22 80 00       	push   $0x802298
  800640:	e8 54 03 00 00       	call   800999 <cprintf>
  800645:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800648:	a1 20 30 80 00       	mov    0x803020,%eax
  80064d:	8b 90 98 52 00 00    	mov    0x5298(%eax),%edx
  800653:	a1 20 30 80 00       	mov    0x803020,%eax
  800658:	8b 80 88 52 00 00    	mov    0x5288(%eax),%eax
  80065e:	83 ec 04             	sub    $0x4,%esp
  800661:	52                   	push   %edx
  800662:	50                   	push   %eax
  800663:	68 c0 22 80 00       	push   $0x8022c0
  800668:	e8 2c 03 00 00       	call   800999 <cprintf>
  80066d:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800670:	a1 20 30 80 00       	mov    0x803020,%eax
  800675:	8b 88 a8 52 00 00    	mov    0x52a8(%eax),%ecx
  80067b:	a1 20 30 80 00       	mov    0x803020,%eax
  800680:	8b 90 a4 52 00 00    	mov    0x52a4(%eax),%edx
  800686:	a1 20 30 80 00       	mov    0x803020,%eax
  80068b:	8b 80 a0 52 00 00    	mov    0x52a0(%eax),%eax
  800691:	51                   	push   %ecx
  800692:	52                   	push   %edx
  800693:	50                   	push   %eax
  800694:	68 e8 22 80 00       	push   $0x8022e8
  800699:	e8 fb 02 00 00       	call   800999 <cprintf>
  80069e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8006a1:	83 ec 0c             	sub    $0xc,%esp
  8006a4:	68 98 22 80 00       	push   $0x802298
  8006a9:	e8 eb 02 00 00       	call   800999 <cprintf>
  8006ae:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006b1:	e8 c3 12 00 00       	call   801979 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006b6:	e8 19 00 00 00       	call   8006d4 <exit>
}
  8006bb:	90                   	nop
  8006bc:	c9                   	leave  
  8006bd:	c3                   	ret    

008006be <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006be:	55                   	push   %ebp
  8006bf:	89 e5                	mov    %esp,%ebp
  8006c1:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006c4:	83 ec 0c             	sub    $0xc,%esp
  8006c7:	6a 00                	push   $0x0
  8006c9:	e8 c2 10 00 00       	call   801790 <sys_env_destroy>
  8006ce:	83 c4 10             	add    $0x10,%esp
}
  8006d1:	90                   	nop
  8006d2:	c9                   	leave  
  8006d3:	c3                   	ret    

008006d4 <exit>:

void
exit(void)
{
  8006d4:	55                   	push   %ebp
  8006d5:	89 e5                	mov    %esp,%ebp
  8006d7:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006da:	e8 17 11 00 00       	call   8017f6 <sys_env_exit>
}
  8006df:	90                   	nop
  8006e0:	c9                   	leave  
  8006e1:	c3                   	ret    

008006e2 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006e2:	55                   	push   %ebp
  8006e3:	89 e5                	mov    %esp,%ebp
  8006e5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006e8:	8d 45 10             	lea    0x10(%ebp),%eax
  8006eb:	83 c0 04             	add    $0x4,%eax
  8006ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006f1:	a1 24 31 81 00       	mov    0x813124,%eax
  8006f6:	85 c0                	test   %eax,%eax
  8006f8:	74 16                	je     800710 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006fa:	a1 24 31 81 00       	mov    0x813124,%eax
  8006ff:	83 ec 08             	sub    $0x8,%esp
  800702:	50                   	push   %eax
  800703:	68 40 23 80 00       	push   $0x802340
  800708:	e8 8c 02 00 00       	call   800999 <cprintf>
  80070d:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800710:	a1 00 30 80 00       	mov    0x803000,%eax
  800715:	ff 75 0c             	pushl  0xc(%ebp)
  800718:	ff 75 08             	pushl  0x8(%ebp)
  80071b:	50                   	push   %eax
  80071c:	68 45 23 80 00       	push   $0x802345
  800721:	e8 73 02 00 00       	call   800999 <cprintf>
  800726:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800729:	8b 45 10             	mov    0x10(%ebp),%eax
  80072c:	83 ec 08             	sub    $0x8,%esp
  80072f:	ff 75 f4             	pushl  -0xc(%ebp)
  800732:	50                   	push   %eax
  800733:	e8 f6 01 00 00       	call   80092e <vcprintf>
  800738:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80073b:	83 ec 08             	sub    $0x8,%esp
  80073e:	6a 00                	push   $0x0
  800740:	68 61 23 80 00       	push   $0x802361
  800745:	e8 e4 01 00 00       	call   80092e <vcprintf>
  80074a:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80074d:	e8 82 ff ff ff       	call   8006d4 <exit>

	// should not return here
	while (1) ;
  800752:	eb fe                	jmp    800752 <_panic+0x70>

00800754 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800754:	55                   	push   %ebp
  800755:	89 e5                	mov    %esp,%ebp
  800757:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80075a:	a1 20 30 80 00       	mov    0x803020,%eax
  80075f:	8b 50 74             	mov    0x74(%eax),%edx
  800762:	8b 45 0c             	mov    0xc(%ebp),%eax
  800765:	39 c2                	cmp    %eax,%edx
  800767:	74 14                	je     80077d <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800769:	83 ec 04             	sub    $0x4,%esp
  80076c:	68 64 23 80 00       	push   $0x802364
  800771:	6a 26                	push   $0x26
  800773:	68 b0 23 80 00       	push   $0x8023b0
  800778:	e8 65 ff ff ff       	call   8006e2 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80077d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800784:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80078b:	e9 c4 00 00 00       	jmp    800854 <CheckWSWithoutLastIndex+0x100>
		if (expectedPages[e] == 0) {
  800790:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800793:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80079a:	8b 45 08             	mov    0x8(%ebp),%eax
  80079d:	01 d0                	add    %edx,%eax
  80079f:	8b 00                	mov    (%eax),%eax
  8007a1:	85 c0                	test   %eax,%eax
  8007a3:	75 08                	jne    8007ad <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007a5:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007a8:	e9 a4 00 00 00       	jmp    800851 <CheckWSWithoutLastIndex+0xfd>
		}
		int found = 0;
  8007ad:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007b4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007bb:	eb 6b                	jmp    800828 <CheckWSWithoutLastIndex+0xd4>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007bd:	a1 20 30 80 00       	mov    0x803020,%eax
  8007c2:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8007c8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007cb:	89 d0                	mov    %edx,%eax
  8007cd:	c1 e0 02             	shl    $0x2,%eax
  8007d0:	01 d0                	add    %edx,%eax
  8007d2:	c1 e0 02             	shl    $0x2,%eax
  8007d5:	01 c8                	add    %ecx,%eax
  8007d7:	8a 40 04             	mov    0x4(%eax),%al
  8007da:	84 c0                	test   %al,%al
  8007dc:	75 47                	jne    800825 <CheckWSWithoutLastIndex+0xd1>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007de:	a1 20 30 80 00       	mov    0x803020,%eax
  8007e3:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  8007e9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007ec:	89 d0                	mov    %edx,%eax
  8007ee:	c1 e0 02             	shl    $0x2,%eax
  8007f1:	01 d0                	add    %edx,%eax
  8007f3:	c1 e0 02             	shl    $0x2,%eax
  8007f6:	01 c8                	add    %ecx,%eax
  8007f8:	8b 00                	mov    (%eax),%eax
  8007fa:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007fd:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800800:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800805:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800807:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80080a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800811:	8b 45 08             	mov    0x8(%ebp),%eax
  800814:	01 c8                	add    %ecx,%eax
  800816:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800818:	39 c2                	cmp    %eax,%edx
  80081a:	75 09                	jne    800825 <CheckWSWithoutLastIndex+0xd1>
						== expectedPages[e]) {
					found = 1;
  80081c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800823:	eb 12                	jmp    800837 <CheckWSWithoutLastIndex+0xe3>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800825:	ff 45 e8             	incl   -0x18(%ebp)
  800828:	a1 20 30 80 00       	mov    0x803020,%eax
  80082d:	8b 50 74             	mov    0x74(%eax),%edx
  800830:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800833:	39 c2                	cmp    %eax,%edx
  800835:	77 86                	ja     8007bd <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800837:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80083b:	75 14                	jne    800851 <CheckWSWithoutLastIndex+0xfd>
			panic(
  80083d:	83 ec 04             	sub    $0x4,%esp
  800840:	68 bc 23 80 00       	push   $0x8023bc
  800845:	6a 3a                	push   $0x3a
  800847:	68 b0 23 80 00       	push   $0x8023b0
  80084c:	e8 91 fe ff ff       	call   8006e2 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800851:	ff 45 f0             	incl   -0x10(%ebp)
  800854:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800857:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80085a:	0f 8c 30 ff ff ff    	jl     800790 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800860:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800867:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80086e:	eb 27                	jmp    800897 <CheckWSWithoutLastIndex+0x143>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800870:	a1 20 30 80 00       	mov    0x803020,%eax
  800875:	8b 88 f0 52 00 00    	mov    0x52f0(%eax),%ecx
  80087b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80087e:	89 d0                	mov    %edx,%eax
  800880:	c1 e0 02             	shl    $0x2,%eax
  800883:	01 d0                	add    %edx,%eax
  800885:	c1 e0 02             	shl    $0x2,%eax
  800888:	01 c8                	add    %ecx,%eax
  80088a:	8a 40 04             	mov    0x4(%eax),%al
  80088d:	3c 01                	cmp    $0x1,%al
  80088f:	75 03                	jne    800894 <CheckWSWithoutLastIndex+0x140>
			actualNumOfEmptyLocs++;
  800891:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800894:	ff 45 e0             	incl   -0x20(%ebp)
  800897:	a1 20 30 80 00       	mov    0x803020,%eax
  80089c:	8b 50 74             	mov    0x74(%eax),%edx
  80089f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008a2:	39 c2                	cmp    %eax,%edx
  8008a4:	77 ca                	ja     800870 <CheckWSWithoutLastIndex+0x11c>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008a9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008ac:	74 14                	je     8008c2 <CheckWSWithoutLastIndex+0x16e>
		panic(
  8008ae:	83 ec 04             	sub    $0x4,%esp
  8008b1:	68 10 24 80 00       	push   $0x802410
  8008b6:	6a 44                	push   $0x44
  8008b8:	68 b0 23 80 00       	push   $0x8023b0
  8008bd:	e8 20 fe ff ff       	call   8006e2 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008c2:	90                   	nop
  8008c3:	c9                   	leave  
  8008c4:	c3                   	ret    

008008c5 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008c5:	55                   	push   %ebp
  8008c6:	89 e5                	mov    %esp,%ebp
  8008c8:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ce:	8b 00                	mov    (%eax),%eax
  8008d0:	8d 48 01             	lea    0x1(%eax),%ecx
  8008d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008d6:	89 0a                	mov    %ecx,(%edx)
  8008d8:	8b 55 08             	mov    0x8(%ebp),%edx
  8008db:	88 d1                	mov    %dl,%cl
  8008dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008e0:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e7:	8b 00                	mov    (%eax),%eax
  8008e9:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008ee:	75 2c                	jne    80091c <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008f0:	a0 24 30 80 00       	mov    0x803024,%al
  8008f5:	0f b6 c0             	movzbl %al,%eax
  8008f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008fb:	8b 12                	mov    (%edx),%edx
  8008fd:	89 d1                	mov    %edx,%ecx
  8008ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  800902:	83 c2 08             	add    $0x8,%edx
  800905:	83 ec 04             	sub    $0x4,%esp
  800908:	50                   	push   %eax
  800909:	51                   	push   %ecx
  80090a:	52                   	push   %edx
  80090b:	e8 3e 0e 00 00       	call   80174e <sys_cputs>
  800910:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800913:	8b 45 0c             	mov    0xc(%ebp),%eax
  800916:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80091c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091f:	8b 40 04             	mov    0x4(%eax),%eax
  800922:	8d 50 01             	lea    0x1(%eax),%edx
  800925:	8b 45 0c             	mov    0xc(%ebp),%eax
  800928:	89 50 04             	mov    %edx,0x4(%eax)
}
  80092b:	90                   	nop
  80092c:	c9                   	leave  
  80092d:	c3                   	ret    

0080092e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80092e:	55                   	push   %ebp
  80092f:	89 e5                	mov    %esp,%ebp
  800931:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800937:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80093e:	00 00 00 
	b.cnt = 0;
  800941:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800948:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80094b:	ff 75 0c             	pushl  0xc(%ebp)
  80094e:	ff 75 08             	pushl  0x8(%ebp)
  800951:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800957:	50                   	push   %eax
  800958:	68 c5 08 80 00       	push   $0x8008c5
  80095d:	e8 11 02 00 00       	call   800b73 <vprintfmt>
  800962:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800965:	a0 24 30 80 00       	mov    0x803024,%al
  80096a:	0f b6 c0             	movzbl %al,%eax
  80096d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800973:	83 ec 04             	sub    $0x4,%esp
  800976:	50                   	push   %eax
  800977:	52                   	push   %edx
  800978:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80097e:	83 c0 08             	add    $0x8,%eax
  800981:	50                   	push   %eax
  800982:	e8 c7 0d 00 00       	call   80174e <sys_cputs>
  800987:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80098a:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800991:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800997:	c9                   	leave  
  800998:	c3                   	ret    

00800999 <cprintf>:

int cprintf(const char *fmt, ...) {
  800999:	55                   	push   %ebp
  80099a:	89 e5                	mov    %esp,%ebp
  80099c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80099f:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8009a6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8009af:	83 ec 08             	sub    $0x8,%esp
  8009b2:	ff 75 f4             	pushl  -0xc(%ebp)
  8009b5:	50                   	push   %eax
  8009b6:	e8 73 ff ff ff       	call   80092e <vcprintf>
  8009bb:	83 c4 10             	add    $0x10,%esp
  8009be:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009c4:	c9                   	leave  
  8009c5:	c3                   	ret    

008009c6 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009c6:	55                   	push   %ebp
  8009c7:	89 e5                	mov    %esp,%ebp
  8009c9:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009cc:	e8 8e 0f 00 00       	call   80195f <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009d1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009da:	83 ec 08             	sub    $0x8,%esp
  8009dd:	ff 75 f4             	pushl  -0xc(%ebp)
  8009e0:	50                   	push   %eax
  8009e1:	e8 48 ff ff ff       	call   80092e <vcprintf>
  8009e6:	83 c4 10             	add    $0x10,%esp
  8009e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009ec:	e8 88 0f 00 00       	call   801979 <sys_enable_interrupt>
	return cnt;
  8009f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009f4:	c9                   	leave  
  8009f5:	c3                   	ret    

008009f6 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009f6:	55                   	push   %ebp
  8009f7:	89 e5                	mov    %esp,%ebp
  8009f9:	53                   	push   %ebx
  8009fa:	83 ec 14             	sub    $0x14,%esp
  8009fd:	8b 45 10             	mov    0x10(%ebp),%eax
  800a00:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a03:	8b 45 14             	mov    0x14(%ebp),%eax
  800a06:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a09:	8b 45 18             	mov    0x18(%ebp),%eax
  800a0c:	ba 00 00 00 00       	mov    $0x0,%edx
  800a11:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a14:	77 55                	ja     800a6b <printnum+0x75>
  800a16:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a19:	72 05                	jb     800a20 <printnum+0x2a>
  800a1b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a1e:	77 4b                	ja     800a6b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a20:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a23:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a26:	8b 45 18             	mov    0x18(%ebp),%eax
  800a29:	ba 00 00 00 00       	mov    $0x0,%edx
  800a2e:	52                   	push   %edx
  800a2f:	50                   	push   %eax
  800a30:	ff 75 f4             	pushl  -0xc(%ebp)
  800a33:	ff 75 f0             	pushl  -0x10(%ebp)
  800a36:	e8 61 13 00 00       	call   801d9c <__udivdi3>
  800a3b:	83 c4 10             	add    $0x10,%esp
  800a3e:	83 ec 04             	sub    $0x4,%esp
  800a41:	ff 75 20             	pushl  0x20(%ebp)
  800a44:	53                   	push   %ebx
  800a45:	ff 75 18             	pushl  0x18(%ebp)
  800a48:	52                   	push   %edx
  800a49:	50                   	push   %eax
  800a4a:	ff 75 0c             	pushl  0xc(%ebp)
  800a4d:	ff 75 08             	pushl  0x8(%ebp)
  800a50:	e8 a1 ff ff ff       	call   8009f6 <printnum>
  800a55:	83 c4 20             	add    $0x20,%esp
  800a58:	eb 1a                	jmp    800a74 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a5a:	83 ec 08             	sub    $0x8,%esp
  800a5d:	ff 75 0c             	pushl  0xc(%ebp)
  800a60:	ff 75 20             	pushl  0x20(%ebp)
  800a63:	8b 45 08             	mov    0x8(%ebp),%eax
  800a66:	ff d0                	call   *%eax
  800a68:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a6b:	ff 4d 1c             	decl   0x1c(%ebp)
  800a6e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a72:	7f e6                	jg     800a5a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a74:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a77:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a7f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a82:	53                   	push   %ebx
  800a83:	51                   	push   %ecx
  800a84:	52                   	push   %edx
  800a85:	50                   	push   %eax
  800a86:	e8 21 14 00 00       	call   801eac <__umoddi3>
  800a8b:	83 c4 10             	add    $0x10,%esp
  800a8e:	05 74 26 80 00       	add    $0x802674,%eax
  800a93:	8a 00                	mov    (%eax),%al
  800a95:	0f be c0             	movsbl %al,%eax
  800a98:	83 ec 08             	sub    $0x8,%esp
  800a9b:	ff 75 0c             	pushl  0xc(%ebp)
  800a9e:	50                   	push   %eax
  800a9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa2:	ff d0                	call   *%eax
  800aa4:	83 c4 10             	add    $0x10,%esp
}
  800aa7:	90                   	nop
  800aa8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800aab:	c9                   	leave  
  800aac:	c3                   	ret    

00800aad <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800aad:	55                   	push   %ebp
  800aae:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ab0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ab4:	7e 1c                	jle    800ad2 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab9:	8b 00                	mov    (%eax),%eax
  800abb:	8d 50 08             	lea    0x8(%eax),%edx
  800abe:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac1:	89 10                	mov    %edx,(%eax)
  800ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac6:	8b 00                	mov    (%eax),%eax
  800ac8:	83 e8 08             	sub    $0x8,%eax
  800acb:	8b 50 04             	mov    0x4(%eax),%edx
  800ace:	8b 00                	mov    (%eax),%eax
  800ad0:	eb 40                	jmp    800b12 <getuint+0x65>
	else if (lflag)
  800ad2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ad6:	74 1e                	je     800af6 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	8b 00                	mov    (%eax),%eax
  800add:	8d 50 04             	lea    0x4(%eax),%edx
  800ae0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae3:	89 10                	mov    %edx,(%eax)
  800ae5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae8:	8b 00                	mov    (%eax),%eax
  800aea:	83 e8 04             	sub    $0x4,%eax
  800aed:	8b 00                	mov    (%eax),%eax
  800aef:	ba 00 00 00 00       	mov    $0x0,%edx
  800af4:	eb 1c                	jmp    800b12 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800af6:	8b 45 08             	mov    0x8(%ebp),%eax
  800af9:	8b 00                	mov    (%eax),%eax
  800afb:	8d 50 04             	lea    0x4(%eax),%edx
  800afe:	8b 45 08             	mov    0x8(%ebp),%eax
  800b01:	89 10                	mov    %edx,(%eax)
  800b03:	8b 45 08             	mov    0x8(%ebp),%eax
  800b06:	8b 00                	mov    (%eax),%eax
  800b08:	83 e8 04             	sub    $0x4,%eax
  800b0b:	8b 00                	mov    (%eax),%eax
  800b0d:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b12:	5d                   	pop    %ebp
  800b13:	c3                   	ret    

00800b14 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b14:	55                   	push   %ebp
  800b15:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b17:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b1b:	7e 1c                	jle    800b39 <getint+0x25>
		return va_arg(*ap, long long);
  800b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b20:	8b 00                	mov    (%eax),%eax
  800b22:	8d 50 08             	lea    0x8(%eax),%edx
  800b25:	8b 45 08             	mov    0x8(%ebp),%eax
  800b28:	89 10                	mov    %edx,(%eax)
  800b2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2d:	8b 00                	mov    (%eax),%eax
  800b2f:	83 e8 08             	sub    $0x8,%eax
  800b32:	8b 50 04             	mov    0x4(%eax),%edx
  800b35:	8b 00                	mov    (%eax),%eax
  800b37:	eb 38                	jmp    800b71 <getint+0x5d>
	else if (lflag)
  800b39:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b3d:	74 1a                	je     800b59 <getint+0x45>
		return va_arg(*ap, long);
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	8b 00                	mov    (%eax),%eax
  800b44:	8d 50 04             	lea    0x4(%eax),%edx
  800b47:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4a:	89 10                	mov    %edx,(%eax)
  800b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4f:	8b 00                	mov    (%eax),%eax
  800b51:	83 e8 04             	sub    $0x4,%eax
  800b54:	8b 00                	mov    (%eax),%eax
  800b56:	99                   	cltd   
  800b57:	eb 18                	jmp    800b71 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b59:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5c:	8b 00                	mov    (%eax),%eax
  800b5e:	8d 50 04             	lea    0x4(%eax),%edx
  800b61:	8b 45 08             	mov    0x8(%ebp),%eax
  800b64:	89 10                	mov    %edx,(%eax)
  800b66:	8b 45 08             	mov    0x8(%ebp),%eax
  800b69:	8b 00                	mov    (%eax),%eax
  800b6b:	83 e8 04             	sub    $0x4,%eax
  800b6e:	8b 00                	mov    (%eax),%eax
  800b70:	99                   	cltd   
}
  800b71:	5d                   	pop    %ebp
  800b72:	c3                   	ret    

00800b73 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b73:	55                   	push   %ebp
  800b74:	89 e5                	mov    %esp,%ebp
  800b76:	56                   	push   %esi
  800b77:	53                   	push   %ebx
  800b78:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b7b:	eb 17                	jmp    800b94 <vprintfmt+0x21>
			if (ch == '\0')
  800b7d:	85 db                	test   %ebx,%ebx
  800b7f:	0f 84 af 03 00 00    	je     800f34 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b85:	83 ec 08             	sub    $0x8,%esp
  800b88:	ff 75 0c             	pushl  0xc(%ebp)
  800b8b:	53                   	push   %ebx
  800b8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8f:	ff d0                	call   *%eax
  800b91:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b94:	8b 45 10             	mov    0x10(%ebp),%eax
  800b97:	8d 50 01             	lea    0x1(%eax),%edx
  800b9a:	89 55 10             	mov    %edx,0x10(%ebp)
  800b9d:	8a 00                	mov    (%eax),%al
  800b9f:	0f b6 d8             	movzbl %al,%ebx
  800ba2:	83 fb 25             	cmp    $0x25,%ebx
  800ba5:	75 d6                	jne    800b7d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800ba7:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bab:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bb2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bb9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bc0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bc7:	8b 45 10             	mov    0x10(%ebp),%eax
  800bca:	8d 50 01             	lea    0x1(%eax),%edx
  800bcd:	89 55 10             	mov    %edx,0x10(%ebp)
  800bd0:	8a 00                	mov    (%eax),%al
  800bd2:	0f b6 d8             	movzbl %al,%ebx
  800bd5:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bd8:	83 f8 55             	cmp    $0x55,%eax
  800bdb:	0f 87 2b 03 00 00    	ja     800f0c <vprintfmt+0x399>
  800be1:	8b 04 85 98 26 80 00 	mov    0x802698(,%eax,4),%eax
  800be8:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bea:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bee:	eb d7                	jmp    800bc7 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bf0:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bf4:	eb d1                	jmp    800bc7 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bf6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bfd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c00:	89 d0                	mov    %edx,%eax
  800c02:	c1 e0 02             	shl    $0x2,%eax
  800c05:	01 d0                	add    %edx,%eax
  800c07:	01 c0                	add    %eax,%eax
  800c09:	01 d8                	add    %ebx,%eax
  800c0b:	83 e8 30             	sub    $0x30,%eax
  800c0e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c11:	8b 45 10             	mov    0x10(%ebp),%eax
  800c14:	8a 00                	mov    (%eax),%al
  800c16:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c19:	83 fb 2f             	cmp    $0x2f,%ebx
  800c1c:	7e 3e                	jle    800c5c <vprintfmt+0xe9>
  800c1e:	83 fb 39             	cmp    $0x39,%ebx
  800c21:	7f 39                	jg     800c5c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c23:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c26:	eb d5                	jmp    800bfd <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c28:	8b 45 14             	mov    0x14(%ebp),%eax
  800c2b:	83 c0 04             	add    $0x4,%eax
  800c2e:	89 45 14             	mov    %eax,0x14(%ebp)
  800c31:	8b 45 14             	mov    0x14(%ebp),%eax
  800c34:	83 e8 04             	sub    $0x4,%eax
  800c37:	8b 00                	mov    (%eax),%eax
  800c39:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c3c:	eb 1f                	jmp    800c5d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c3e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c42:	79 83                	jns    800bc7 <vprintfmt+0x54>
				width = 0;
  800c44:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c4b:	e9 77 ff ff ff       	jmp    800bc7 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c50:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c57:	e9 6b ff ff ff       	jmp    800bc7 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c5c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c5d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c61:	0f 89 60 ff ff ff    	jns    800bc7 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c67:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c6a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c6d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c74:	e9 4e ff ff ff       	jmp    800bc7 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c79:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c7c:	e9 46 ff ff ff       	jmp    800bc7 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c81:	8b 45 14             	mov    0x14(%ebp),%eax
  800c84:	83 c0 04             	add    $0x4,%eax
  800c87:	89 45 14             	mov    %eax,0x14(%ebp)
  800c8a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c8d:	83 e8 04             	sub    $0x4,%eax
  800c90:	8b 00                	mov    (%eax),%eax
  800c92:	83 ec 08             	sub    $0x8,%esp
  800c95:	ff 75 0c             	pushl  0xc(%ebp)
  800c98:	50                   	push   %eax
  800c99:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9c:	ff d0                	call   *%eax
  800c9e:	83 c4 10             	add    $0x10,%esp
			break;
  800ca1:	e9 89 02 00 00       	jmp    800f2f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800ca6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca9:	83 c0 04             	add    $0x4,%eax
  800cac:	89 45 14             	mov    %eax,0x14(%ebp)
  800caf:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb2:	83 e8 04             	sub    $0x4,%eax
  800cb5:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cb7:	85 db                	test   %ebx,%ebx
  800cb9:	79 02                	jns    800cbd <vprintfmt+0x14a>
				err = -err;
  800cbb:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cbd:	83 fb 64             	cmp    $0x64,%ebx
  800cc0:	7f 0b                	jg     800ccd <vprintfmt+0x15a>
  800cc2:	8b 34 9d e0 24 80 00 	mov    0x8024e0(,%ebx,4),%esi
  800cc9:	85 f6                	test   %esi,%esi
  800ccb:	75 19                	jne    800ce6 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ccd:	53                   	push   %ebx
  800cce:	68 85 26 80 00       	push   $0x802685
  800cd3:	ff 75 0c             	pushl  0xc(%ebp)
  800cd6:	ff 75 08             	pushl  0x8(%ebp)
  800cd9:	e8 5e 02 00 00       	call   800f3c <printfmt>
  800cde:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ce1:	e9 49 02 00 00       	jmp    800f2f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ce6:	56                   	push   %esi
  800ce7:	68 8e 26 80 00       	push   $0x80268e
  800cec:	ff 75 0c             	pushl  0xc(%ebp)
  800cef:	ff 75 08             	pushl  0x8(%ebp)
  800cf2:	e8 45 02 00 00       	call   800f3c <printfmt>
  800cf7:	83 c4 10             	add    $0x10,%esp
			break;
  800cfa:	e9 30 02 00 00       	jmp    800f2f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cff:	8b 45 14             	mov    0x14(%ebp),%eax
  800d02:	83 c0 04             	add    $0x4,%eax
  800d05:	89 45 14             	mov    %eax,0x14(%ebp)
  800d08:	8b 45 14             	mov    0x14(%ebp),%eax
  800d0b:	83 e8 04             	sub    $0x4,%eax
  800d0e:	8b 30                	mov    (%eax),%esi
  800d10:	85 f6                	test   %esi,%esi
  800d12:	75 05                	jne    800d19 <vprintfmt+0x1a6>
				p = "(null)";
  800d14:	be 91 26 80 00       	mov    $0x802691,%esi
			if (width > 0 && padc != '-')
  800d19:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d1d:	7e 6d                	jle    800d8c <vprintfmt+0x219>
  800d1f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d23:	74 67                	je     800d8c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d25:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d28:	83 ec 08             	sub    $0x8,%esp
  800d2b:	50                   	push   %eax
  800d2c:	56                   	push   %esi
  800d2d:	e8 0c 03 00 00       	call   80103e <strnlen>
  800d32:	83 c4 10             	add    $0x10,%esp
  800d35:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d38:	eb 16                	jmp    800d50 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d3a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d3e:	83 ec 08             	sub    $0x8,%esp
  800d41:	ff 75 0c             	pushl  0xc(%ebp)
  800d44:	50                   	push   %eax
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
  800d48:	ff d0                	call   *%eax
  800d4a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d4d:	ff 4d e4             	decl   -0x1c(%ebp)
  800d50:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d54:	7f e4                	jg     800d3a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d56:	eb 34                	jmp    800d8c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d58:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d5c:	74 1c                	je     800d7a <vprintfmt+0x207>
  800d5e:	83 fb 1f             	cmp    $0x1f,%ebx
  800d61:	7e 05                	jle    800d68 <vprintfmt+0x1f5>
  800d63:	83 fb 7e             	cmp    $0x7e,%ebx
  800d66:	7e 12                	jle    800d7a <vprintfmt+0x207>
					putch('?', putdat);
  800d68:	83 ec 08             	sub    $0x8,%esp
  800d6b:	ff 75 0c             	pushl  0xc(%ebp)
  800d6e:	6a 3f                	push   $0x3f
  800d70:	8b 45 08             	mov    0x8(%ebp),%eax
  800d73:	ff d0                	call   *%eax
  800d75:	83 c4 10             	add    $0x10,%esp
  800d78:	eb 0f                	jmp    800d89 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d7a:	83 ec 08             	sub    $0x8,%esp
  800d7d:	ff 75 0c             	pushl  0xc(%ebp)
  800d80:	53                   	push   %ebx
  800d81:	8b 45 08             	mov    0x8(%ebp),%eax
  800d84:	ff d0                	call   *%eax
  800d86:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d89:	ff 4d e4             	decl   -0x1c(%ebp)
  800d8c:	89 f0                	mov    %esi,%eax
  800d8e:	8d 70 01             	lea    0x1(%eax),%esi
  800d91:	8a 00                	mov    (%eax),%al
  800d93:	0f be d8             	movsbl %al,%ebx
  800d96:	85 db                	test   %ebx,%ebx
  800d98:	74 24                	je     800dbe <vprintfmt+0x24b>
  800d9a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d9e:	78 b8                	js     800d58 <vprintfmt+0x1e5>
  800da0:	ff 4d e0             	decl   -0x20(%ebp)
  800da3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800da7:	79 af                	jns    800d58 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800da9:	eb 13                	jmp    800dbe <vprintfmt+0x24b>
				putch(' ', putdat);
  800dab:	83 ec 08             	sub    $0x8,%esp
  800dae:	ff 75 0c             	pushl  0xc(%ebp)
  800db1:	6a 20                	push   $0x20
  800db3:	8b 45 08             	mov    0x8(%ebp),%eax
  800db6:	ff d0                	call   *%eax
  800db8:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dbb:	ff 4d e4             	decl   -0x1c(%ebp)
  800dbe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dc2:	7f e7                	jg     800dab <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800dc4:	e9 66 01 00 00       	jmp    800f2f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800dc9:	83 ec 08             	sub    $0x8,%esp
  800dcc:	ff 75 e8             	pushl  -0x18(%ebp)
  800dcf:	8d 45 14             	lea    0x14(%ebp),%eax
  800dd2:	50                   	push   %eax
  800dd3:	e8 3c fd ff ff       	call   800b14 <getint>
  800dd8:	83 c4 10             	add    $0x10,%esp
  800ddb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dde:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800de1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800de4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800de7:	85 d2                	test   %edx,%edx
  800de9:	79 23                	jns    800e0e <vprintfmt+0x29b>
				putch('-', putdat);
  800deb:	83 ec 08             	sub    $0x8,%esp
  800dee:	ff 75 0c             	pushl  0xc(%ebp)
  800df1:	6a 2d                	push   $0x2d
  800df3:	8b 45 08             	mov    0x8(%ebp),%eax
  800df6:	ff d0                	call   *%eax
  800df8:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800dfb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dfe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e01:	f7 d8                	neg    %eax
  800e03:	83 d2 00             	adc    $0x0,%edx
  800e06:	f7 da                	neg    %edx
  800e08:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e0b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e0e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e15:	e9 bc 00 00 00       	jmp    800ed6 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e1a:	83 ec 08             	sub    $0x8,%esp
  800e1d:	ff 75 e8             	pushl  -0x18(%ebp)
  800e20:	8d 45 14             	lea    0x14(%ebp),%eax
  800e23:	50                   	push   %eax
  800e24:	e8 84 fc ff ff       	call   800aad <getuint>
  800e29:	83 c4 10             	add    $0x10,%esp
  800e2c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e2f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e32:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e39:	e9 98 00 00 00       	jmp    800ed6 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e3e:	83 ec 08             	sub    $0x8,%esp
  800e41:	ff 75 0c             	pushl  0xc(%ebp)
  800e44:	6a 58                	push   $0x58
  800e46:	8b 45 08             	mov    0x8(%ebp),%eax
  800e49:	ff d0                	call   *%eax
  800e4b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e4e:	83 ec 08             	sub    $0x8,%esp
  800e51:	ff 75 0c             	pushl  0xc(%ebp)
  800e54:	6a 58                	push   $0x58
  800e56:	8b 45 08             	mov    0x8(%ebp),%eax
  800e59:	ff d0                	call   *%eax
  800e5b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e5e:	83 ec 08             	sub    $0x8,%esp
  800e61:	ff 75 0c             	pushl  0xc(%ebp)
  800e64:	6a 58                	push   $0x58
  800e66:	8b 45 08             	mov    0x8(%ebp),%eax
  800e69:	ff d0                	call   *%eax
  800e6b:	83 c4 10             	add    $0x10,%esp
			break;
  800e6e:	e9 bc 00 00 00       	jmp    800f2f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e73:	83 ec 08             	sub    $0x8,%esp
  800e76:	ff 75 0c             	pushl  0xc(%ebp)
  800e79:	6a 30                	push   $0x30
  800e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7e:	ff d0                	call   *%eax
  800e80:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e83:	83 ec 08             	sub    $0x8,%esp
  800e86:	ff 75 0c             	pushl  0xc(%ebp)
  800e89:	6a 78                	push   $0x78
  800e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8e:	ff d0                	call   *%eax
  800e90:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e93:	8b 45 14             	mov    0x14(%ebp),%eax
  800e96:	83 c0 04             	add    $0x4,%eax
  800e99:	89 45 14             	mov    %eax,0x14(%ebp)
  800e9c:	8b 45 14             	mov    0x14(%ebp),%eax
  800e9f:	83 e8 04             	sub    $0x4,%eax
  800ea2:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ea4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ea7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800eae:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800eb5:	eb 1f                	jmp    800ed6 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800eb7:	83 ec 08             	sub    $0x8,%esp
  800eba:	ff 75 e8             	pushl  -0x18(%ebp)
  800ebd:	8d 45 14             	lea    0x14(%ebp),%eax
  800ec0:	50                   	push   %eax
  800ec1:	e8 e7 fb ff ff       	call   800aad <getuint>
  800ec6:	83 c4 10             	add    $0x10,%esp
  800ec9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ecc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ecf:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ed6:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800eda:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800edd:	83 ec 04             	sub    $0x4,%esp
  800ee0:	52                   	push   %edx
  800ee1:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ee4:	50                   	push   %eax
  800ee5:	ff 75 f4             	pushl  -0xc(%ebp)
  800ee8:	ff 75 f0             	pushl  -0x10(%ebp)
  800eeb:	ff 75 0c             	pushl  0xc(%ebp)
  800eee:	ff 75 08             	pushl  0x8(%ebp)
  800ef1:	e8 00 fb ff ff       	call   8009f6 <printnum>
  800ef6:	83 c4 20             	add    $0x20,%esp
			break;
  800ef9:	eb 34                	jmp    800f2f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800efb:	83 ec 08             	sub    $0x8,%esp
  800efe:	ff 75 0c             	pushl  0xc(%ebp)
  800f01:	53                   	push   %ebx
  800f02:	8b 45 08             	mov    0x8(%ebp),%eax
  800f05:	ff d0                	call   *%eax
  800f07:	83 c4 10             	add    $0x10,%esp
			break;
  800f0a:	eb 23                	jmp    800f2f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f0c:	83 ec 08             	sub    $0x8,%esp
  800f0f:	ff 75 0c             	pushl  0xc(%ebp)
  800f12:	6a 25                	push   $0x25
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
  800f17:	ff d0                	call   *%eax
  800f19:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f1c:	ff 4d 10             	decl   0x10(%ebp)
  800f1f:	eb 03                	jmp    800f24 <vprintfmt+0x3b1>
  800f21:	ff 4d 10             	decl   0x10(%ebp)
  800f24:	8b 45 10             	mov    0x10(%ebp),%eax
  800f27:	48                   	dec    %eax
  800f28:	8a 00                	mov    (%eax),%al
  800f2a:	3c 25                	cmp    $0x25,%al
  800f2c:	75 f3                	jne    800f21 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f2e:	90                   	nop
		}
	}
  800f2f:	e9 47 fc ff ff       	jmp    800b7b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f34:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f35:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f38:	5b                   	pop    %ebx
  800f39:	5e                   	pop    %esi
  800f3a:	5d                   	pop    %ebp
  800f3b:	c3                   	ret    

00800f3c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f3c:	55                   	push   %ebp
  800f3d:	89 e5                	mov    %esp,%ebp
  800f3f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f42:	8d 45 10             	lea    0x10(%ebp),%eax
  800f45:	83 c0 04             	add    $0x4,%eax
  800f48:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f4b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4e:	ff 75 f4             	pushl  -0xc(%ebp)
  800f51:	50                   	push   %eax
  800f52:	ff 75 0c             	pushl  0xc(%ebp)
  800f55:	ff 75 08             	pushl  0x8(%ebp)
  800f58:	e8 16 fc ff ff       	call   800b73 <vprintfmt>
  800f5d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f60:	90                   	nop
  800f61:	c9                   	leave  
  800f62:	c3                   	ret    

00800f63 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f63:	55                   	push   %ebp
  800f64:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f69:	8b 40 08             	mov    0x8(%eax),%eax
  800f6c:	8d 50 01             	lea    0x1(%eax),%edx
  800f6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f72:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f78:	8b 10                	mov    (%eax),%edx
  800f7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7d:	8b 40 04             	mov    0x4(%eax),%eax
  800f80:	39 c2                	cmp    %eax,%edx
  800f82:	73 12                	jae    800f96 <sprintputch+0x33>
		*b->buf++ = ch;
  800f84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f87:	8b 00                	mov    (%eax),%eax
  800f89:	8d 48 01             	lea    0x1(%eax),%ecx
  800f8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f8f:	89 0a                	mov    %ecx,(%edx)
  800f91:	8b 55 08             	mov    0x8(%ebp),%edx
  800f94:	88 10                	mov    %dl,(%eax)
}
  800f96:	90                   	nop
  800f97:	5d                   	pop    %ebp
  800f98:	c3                   	ret    

00800f99 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f99:	55                   	push   %ebp
  800f9a:	89 e5                	mov    %esp,%ebp
  800f9c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fa5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fab:	8b 45 08             	mov    0x8(%ebp),%eax
  800fae:	01 d0                	add    %edx,%eax
  800fb0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fb3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fba:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fbe:	74 06                	je     800fc6 <vsnprintf+0x2d>
  800fc0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fc4:	7f 07                	jg     800fcd <vsnprintf+0x34>
		return -E_INVAL;
  800fc6:	b8 03 00 00 00       	mov    $0x3,%eax
  800fcb:	eb 20                	jmp    800fed <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fcd:	ff 75 14             	pushl  0x14(%ebp)
  800fd0:	ff 75 10             	pushl  0x10(%ebp)
  800fd3:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fd6:	50                   	push   %eax
  800fd7:	68 63 0f 80 00       	push   $0x800f63
  800fdc:	e8 92 fb ff ff       	call   800b73 <vprintfmt>
  800fe1:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fe4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fe7:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fea:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fed:	c9                   	leave  
  800fee:	c3                   	ret    

00800fef <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fef:	55                   	push   %ebp
  800ff0:	89 e5                	mov    %esp,%ebp
  800ff2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ff5:	8d 45 10             	lea    0x10(%ebp),%eax
  800ff8:	83 c0 04             	add    $0x4,%eax
  800ffb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ffe:	8b 45 10             	mov    0x10(%ebp),%eax
  801001:	ff 75 f4             	pushl  -0xc(%ebp)
  801004:	50                   	push   %eax
  801005:	ff 75 0c             	pushl  0xc(%ebp)
  801008:	ff 75 08             	pushl  0x8(%ebp)
  80100b:	e8 89 ff ff ff       	call   800f99 <vsnprintf>
  801010:	83 c4 10             	add    $0x10,%esp
  801013:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801016:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801019:	c9                   	leave  
  80101a:	c3                   	ret    

0080101b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80101b:	55                   	push   %ebp
  80101c:	89 e5                	mov    %esp,%ebp
  80101e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801021:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801028:	eb 06                	jmp    801030 <strlen+0x15>
		n++;
  80102a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80102d:	ff 45 08             	incl   0x8(%ebp)
  801030:	8b 45 08             	mov    0x8(%ebp),%eax
  801033:	8a 00                	mov    (%eax),%al
  801035:	84 c0                	test   %al,%al
  801037:	75 f1                	jne    80102a <strlen+0xf>
		n++;
	return n;
  801039:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80103c:	c9                   	leave  
  80103d:	c3                   	ret    

0080103e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80103e:	55                   	push   %ebp
  80103f:	89 e5                	mov    %esp,%ebp
  801041:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801044:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80104b:	eb 09                	jmp    801056 <strnlen+0x18>
		n++;
  80104d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801050:	ff 45 08             	incl   0x8(%ebp)
  801053:	ff 4d 0c             	decl   0xc(%ebp)
  801056:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80105a:	74 09                	je     801065 <strnlen+0x27>
  80105c:	8b 45 08             	mov    0x8(%ebp),%eax
  80105f:	8a 00                	mov    (%eax),%al
  801061:	84 c0                	test   %al,%al
  801063:	75 e8                	jne    80104d <strnlen+0xf>
		n++;
	return n;
  801065:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801068:	c9                   	leave  
  801069:	c3                   	ret    

0080106a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80106a:	55                   	push   %ebp
  80106b:	89 e5                	mov    %esp,%ebp
  80106d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801070:	8b 45 08             	mov    0x8(%ebp),%eax
  801073:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801076:	90                   	nop
  801077:	8b 45 08             	mov    0x8(%ebp),%eax
  80107a:	8d 50 01             	lea    0x1(%eax),%edx
  80107d:	89 55 08             	mov    %edx,0x8(%ebp)
  801080:	8b 55 0c             	mov    0xc(%ebp),%edx
  801083:	8d 4a 01             	lea    0x1(%edx),%ecx
  801086:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801089:	8a 12                	mov    (%edx),%dl
  80108b:	88 10                	mov    %dl,(%eax)
  80108d:	8a 00                	mov    (%eax),%al
  80108f:	84 c0                	test   %al,%al
  801091:	75 e4                	jne    801077 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801093:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801096:	c9                   	leave  
  801097:	c3                   	ret    

00801098 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801098:	55                   	push   %ebp
  801099:	89 e5                	mov    %esp,%ebp
  80109b:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80109e:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8010a4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010ab:	eb 1f                	jmp    8010cc <strncpy+0x34>
		*dst++ = *src;
  8010ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b0:	8d 50 01             	lea    0x1(%eax),%edx
  8010b3:	89 55 08             	mov    %edx,0x8(%ebp)
  8010b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010b9:	8a 12                	mov    (%edx),%dl
  8010bb:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c0:	8a 00                	mov    (%eax),%al
  8010c2:	84 c0                	test   %al,%al
  8010c4:	74 03                	je     8010c9 <strncpy+0x31>
			src++;
  8010c6:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010c9:	ff 45 fc             	incl   -0x4(%ebp)
  8010cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010cf:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010d2:	72 d9                	jb     8010ad <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010d7:	c9                   	leave  
  8010d8:	c3                   	ret    

008010d9 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010d9:	55                   	push   %ebp
  8010da:	89 e5                	mov    %esp,%ebp
  8010dc:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010df:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010e5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010e9:	74 30                	je     80111b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010eb:	eb 16                	jmp    801103 <strlcpy+0x2a>
			*dst++ = *src++;
  8010ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f0:	8d 50 01             	lea    0x1(%eax),%edx
  8010f3:	89 55 08             	mov    %edx,0x8(%ebp)
  8010f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010f9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010fc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010ff:	8a 12                	mov    (%edx),%dl
  801101:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801103:	ff 4d 10             	decl   0x10(%ebp)
  801106:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80110a:	74 09                	je     801115 <strlcpy+0x3c>
  80110c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110f:	8a 00                	mov    (%eax),%al
  801111:	84 c0                	test   %al,%al
  801113:	75 d8                	jne    8010ed <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801115:	8b 45 08             	mov    0x8(%ebp),%eax
  801118:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80111b:	8b 55 08             	mov    0x8(%ebp),%edx
  80111e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801121:	29 c2                	sub    %eax,%edx
  801123:	89 d0                	mov    %edx,%eax
}
  801125:	c9                   	leave  
  801126:	c3                   	ret    

00801127 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801127:	55                   	push   %ebp
  801128:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80112a:	eb 06                	jmp    801132 <strcmp+0xb>
		p++, q++;
  80112c:	ff 45 08             	incl   0x8(%ebp)
  80112f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801132:	8b 45 08             	mov    0x8(%ebp),%eax
  801135:	8a 00                	mov    (%eax),%al
  801137:	84 c0                	test   %al,%al
  801139:	74 0e                	je     801149 <strcmp+0x22>
  80113b:	8b 45 08             	mov    0x8(%ebp),%eax
  80113e:	8a 10                	mov    (%eax),%dl
  801140:	8b 45 0c             	mov    0xc(%ebp),%eax
  801143:	8a 00                	mov    (%eax),%al
  801145:	38 c2                	cmp    %al,%dl
  801147:	74 e3                	je     80112c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801149:	8b 45 08             	mov    0x8(%ebp),%eax
  80114c:	8a 00                	mov    (%eax),%al
  80114e:	0f b6 d0             	movzbl %al,%edx
  801151:	8b 45 0c             	mov    0xc(%ebp),%eax
  801154:	8a 00                	mov    (%eax),%al
  801156:	0f b6 c0             	movzbl %al,%eax
  801159:	29 c2                	sub    %eax,%edx
  80115b:	89 d0                	mov    %edx,%eax
}
  80115d:	5d                   	pop    %ebp
  80115e:	c3                   	ret    

0080115f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80115f:	55                   	push   %ebp
  801160:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801162:	eb 09                	jmp    80116d <strncmp+0xe>
		n--, p++, q++;
  801164:	ff 4d 10             	decl   0x10(%ebp)
  801167:	ff 45 08             	incl   0x8(%ebp)
  80116a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80116d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801171:	74 17                	je     80118a <strncmp+0x2b>
  801173:	8b 45 08             	mov    0x8(%ebp),%eax
  801176:	8a 00                	mov    (%eax),%al
  801178:	84 c0                	test   %al,%al
  80117a:	74 0e                	je     80118a <strncmp+0x2b>
  80117c:	8b 45 08             	mov    0x8(%ebp),%eax
  80117f:	8a 10                	mov    (%eax),%dl
  801181:	8b 45 0c             	mov    0xc(%ebp),%eax
  801184:	8a 00                	mov    (%eax),%al
  801186:	38 c2                	cmp    %al,%dl
  801188:	74 da                	je     801164 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80118a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80118e:	75 07                	jne    801197 <strncmp+0x38>
		return 0;
  801190:	b8 00 00 00 00       	mov    $0x0,%eax
  801195:	eb 14                	jmp    8011ab <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801197:	8b 45 08             	mov    0x8(%ebp),%eax
  80119a:	8a 00                	mov    (%eax),%al
  80119c:	0f b6 d0             	movzbl %al,%edx
  80119f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a2:	8a 00                	mov    (%eax),%al
  8011a4:	0f b6 c0             	movzbl %al,%eax
  8011a7:	29 c2                	sub    %eax,%edx
  8011a9:	89 d0                	mov    %edx,%eax
}
  8011ab:	5d                   	pop    %ebp
  8011ac:	c3                   	ret    

008011ad <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011ad:	55                   	push   %ebp
  8011ae:	89 e5                	mov    %esp,%ebp
  8011b0:	83 ec 04             	sub    $0x4,%esp
  8011b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011b9:	eb 12                	jmp    8011cd <strchr+0x20>
		if (*s == c)
  8011bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011be:	8a 00                	mov    (%eax),%al
  8011c0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011c3:	75 05                	jne    8011ca <strchr+0x1d>
			return (char *) s;
  8011c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c8:	eb 11                	jmp    8011db <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011ca:	ff 45 08             	incl   0x8(%ebp)
  8011cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d0:	8a 00                	mov    (%eax),%al
  8011d2:	84 c0                	test   %al,%al
  8011d4:	75 e5                	jne    8011bb <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011d6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011db:	c9                   	leave  
  8011dc:	c3                   	ret    

008011dd <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011dd:	55                   	push   %ebp
  8011de:	89 e5                	mov    %esp,%ebp
  8011e0:	83 ec 04             	sub    $0x4,%esp
  8011e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011e9:	eb 0d                	jmp    8011f8 <strfind+0x1b>
		if (*s == c)
  8011eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ee:	8a 00                	mov    (%eax),%al
  8011f0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011f3:	74 0e                	je     801203 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011f5:	ff 45 08             	incl   0x8(%ebp)
  8011f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fb:	8a 00                	mov    (%eax),%al
  8011fd:	84 c0                	test   %al,%al
  8011ff:	75 ea                	jne    8011eb <strfind+0xe>
  801201:	eb 01                	jmp    801204 <strfind+0x27>
		if (*s == c)
			break;
  801203:	90                   	nop
	return (char *) s;
  801204:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801207:	c9                   	leave  
  801208:	c3                   	ret    

00801209 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801209:	55                   	push   %ebp
  80120a:	89 e5                	mov    %esp,%ebp
  80120c:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80120f:	8b 45 08             	mov    0x8(%ebp),%eax
  801212:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801215:	8b 45 10             	mov    0x10(%ebp),%eax
  801218:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80121b:	eb 0e                	jmp    80122b <memset+0x22>
		*p++ = c;
  80121d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801220:	8d 50 01             	lea    0x1(%eax),%edx
  801223:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801226:	8b 55 0c             	mov    0xc(%ebp),%edx
  801229:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80122b:	ff 4d f8             	decl   -0x8(%ebp)
  80122e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801232:	79 e9                	jns    80121d <memset+0x14>
		*p++ = c;

	return v;
  801234:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801237:	c9                   	leave  
  801238:	c3                   	ret    

00801239 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801239:	55                   	push   %ebp
  80123a:	89 e5                	mov    %esp,%ebp
  80123c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80123f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801242:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801245:	8b 45 08             	mov    0x8(%ebp),%eax
  801248:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80124b:	eb 16                	jmp    801263 <memcpy+0x2a>
		*d++ = *s++;
  80124d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801250:	8d 50 01             	lea    0x1(%eax),%edx
  801253:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801256:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801259:	8d 4a 01             	lea    0x1(%edx),%ecx
  80125c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80125f:	8a 12                	mov    (%edx),%dl
  801261:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801263:	8b 45 10             	mov    0x10(%ebp),%eax
  801266:	8d 50 ff             	lea    -0x1(%eax),%edx
  801269:	89 55 10             	mov    %edx,0x10(%ebp)
  80126c:	85 c0                	test   %eax,%eax
  80126e:	75 dd                	jne    80124d <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801270:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801273:	c9                   	leave  
  801274:	c3                   	ret    

00801275 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801275:	55                   	push   %ebp
  801276:	89 e5                	mov    %esp,%ebp
  801278:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80127b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801281:	8b 45 08             	mov    0x8(%ebp),%eax
  801284:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801287:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80128a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80128d:	73 50                	jae    8012df <memmove+0x6a>
  80128f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801292:	8b 45 10             	mov    0x10(%ebp),%eax
  801295:	01 d0                	add    %edx,%eax
  801297:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80129a:	76 43                	jbe    8012df <memmove+0x6a>
		s += n;
  80129c:	8b 45 10             	mov    0x10(%ebp),%eax
  80129f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8012a2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a5:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8012a8:	eb 10                	jmp    8012ba <memmove+0x45>
			*--d = *--s;
  8012aa:	ff 4d f8             	decl   -0x8(%ebp)
  8012ad:	ff 4d fc             	decl   -0x4(%ebp)
  8012b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012b3:	8a 10                	mov    (%eax),%dl
  8012b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012b8:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8012bd:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012c0:	89 55 10             	mov    %edx,0x10(%ebp)
  8012c3:	85 c0                	test   %eax,%eax
  8012c5:	75 e3                	jne    8012aa <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012c7:	eb 23                	jmp    8012ec <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012cc:	8d 50 01             	lea    0x1(%eax),%edx
  8012cf:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012d2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012d5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012d8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012db:	8a 12                	mov    (%edx),%dl
  8012dd:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012df:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012e5:	89 55 10             	mov    %edx,0x10(%ebp)
  8012e8:	85 c0                	test   %eax,%eax
  8012ea:	75 dd                	jne    8012c9 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012ec:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012ef:	c9                   	leave  
  8012f0:	c3                   	ret    

008012f1 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012f1:	55                   	push   %ebp
  8012f2:	89 e5                	mov    %esp,%ebp
  8012f4:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801300:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801303:	eb 2a                	jmp    80132f <memcmp+0x3e>
		if (*s1 != *s2)
  801305:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801308:	8a 10                	mov    (%eax),%dl
  80130a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80130d:	8a 00                	mov    (%eax),%al
  80130f:	38 c2                	cmp    %al,%dl
  801311:	74 16                	je     801329 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801313:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801316:	8a 00                	mov    (%eax),%al
  801318:	0f b6 d0             	movzbl %al,%edx
  80131b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80131e:	8a 00                	mov    (%eax),%al
  801320:	0f b6 c0             	movzbl %al,%eax
  801323:	29 c2                	sub    %eax,%edx
  801325:	89 d0                	mov    %edx,%eax
  801327:	eb 18                	jmp    801341 <memcmp+0x50>
		s1++, s2++;
  801329:	ff 45 fc             	incl   -0x4(%ebp)
  80132c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80132f:	8b 45 10             	mov    0x10(%ebp),%eax
  801332:	8d 50 ff             	lea    -0x1(%eax),%edx
  801335:	89 55 10             	mov    %edx,0x10(%ebp)
  801338:	85 c0                	test   %eax,%eax
  80133a:	75 c9                	jne    801305 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80133c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801341:	c9                   	leave  
  801342:	c3                   	ret    

00801343 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801343:	55                   	push   %ebp
  801344:	89 e5                	mov    %esp,%ebp
  801346:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801349:	8b 55 08             	mov    0x8(%ebp),%edx
  80134c:	8b 45 10             	mov    0x10(%ebp),%eax
  80134f:	01 d0                	add    %edx,%eax
  801351:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801354:	eb 15                	jmp    80136b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801356:	8b 45 08             	mov    0x8(%ebp),%eax
  801359:	8a 00                	mov    (%eax),%al
  80135b:	0f b6 d0             	movzbl %al,%edx
  80135e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801361:	0f b6 c0             	movzbl %al,%eax
  801364:	39 c2                	cmp    %eax,%edx
  801366:	74 0d                	je     801375 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801368:	ff 45 08             	incl   0x8(%ebp)
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801371:	72 e3                	jb     801356 <memfind+0x13>
  801373:	eb 01                	jmp    801376 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801375:	90                   	nop
	return (void *) s;
  801376:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801379:	c9                   	leave  
  80137a:	c3                   	ret    

0080137b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80137b:	55                   	push   %ebp
  80137c:	89 e5                	mov    %esp,%ebp
  80137e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801381:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801388:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80138f:	eb 03                	jmp    801394 <strtol+0x19>
		s++;
  801391:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801394:	8b 45 08             	mov    0x8(%ebp),%eax
  801397:	8a 00                	mov    (%eax),%al
  801399:	3c 20                	cmp    $0x20,%al
  80139b:	74 f4                	je     801391 <strtol+0x16>
  80139d:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a0:	8a 00                	mov    (%eax),%al
  8013a2:	3c 09                	cmp    $0x9,%al
  8013a4:	74 eb                	je     801391 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8013a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a9:	8a 00                	mov    (%eax),%al
  8013ab:	3c 2b                	cmp    $0x2b,%al
  8013ad:	75 05                	jne    8013b4 <strtol+0x39>
		s++;
  8013af:	ff 45 08             	incl   0x8(%ebp)
  8013b2:	eb 13                	jmp    8013c7 <strtol+0x4c>
	else if (*s == '-')
  8013b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b7:	8a 00                	mov    (%eax),%al
  8013b9:	3c 2d                	cmp    $0x2d,%al
  8013bb:	75 0a                	jne    8013c7 <strtol+0x4c>
		s++, neg = 1;
  8013bd:	ff 45 08             	incl   0x8(%ebp)
  8013c0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013c7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013cb:	74 06                	je     8013d3 <strtol+0x58>
  8013cd:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013d1:	75 20                	jne    8013f3 <strtol+0x78>
  8013d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d6:	8a 00                	mov    (%eax),%al
  8013d8:	3c 30                	cmp    $0x30,%al
  8013da:	75 17                	jne    8013f3 <strtol+0x78>
  8013dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013df:	40                   	inc    %eax
  8013e0:	8a 00                	mov    (%eax),%al
  8013e2:	3c 78                	cmp    $0x78,%al
  8013e4:	75 0d                	jne    8013f3 <strtol+0x78>
		s += 2, base = 16;
  8013e6:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013ea:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013f1:	eb 28                	jmp    80141b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013f3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013f7:	75 15                	jne    80140e <strtol+0x93>
  8013f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fc:	8a 00                	mov    (%eax),%al
  8013fe:	3c 30                	cmp    $0x30,%al
  801400:	75 0c                	jne    80140e <strtol+0x93>
		s++, base = 8;
  801402:	ff 45 08             	incl   0x8(%ebp)
  801405:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80140c:	eb 0d                	jmp    80141b <strtol+0xa0>
	else if (base == 0)
  80140e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801412:	75 07                	jne    80141b <strtol+0xa0>
		base = 10;
  801414:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80141b:	8b 45 08             	mov    0x8(%ebp),%eax
  80141e:	8a 00                	mov    (%eax),%al
  801420:	3c 2f                	cmp    $0x2f,%al
  801422:	7e 19                	jle    80143d <strtol+0xc2>
  801424:	8b 45 08             	mov    0x8(%ebp),%eax
  801427:	8a 00                	mov    (%eax),%al
  801429:	3c 39                	cmp    $0x39,%al
  80142b:	7f 10                	jg     80143d <strtol+0xc2>
			dig = *s - '0';
  80142d:	8b 45 08             	mov    0x8(%ebp),%eax
  801430:	8a 00                	mov    (%eax),%al
  801432:	0f be c0             	movsbl %al,%eax
  801435:	83 e8 30             	sub    $0x30,%eax
  801438:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80143b:	eb 42                	jmp    80147f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80143d:	8b 45 08             	mov    0x8(%ebp),%eax
  801440:	8a 00                	mov    (%eax),%al
  801442:	3c 60                	cmp    $0x60,%al
  801444:	7e 19                	jle    80145f <strtol+0xe4>
  801446:	8b 45 08             	mov    0x8(%ebp),%eax
  801449:	8a 00                	mov    (%eax),%al
  80144b:	3c 7a                	cmp    $0x7a,%al
  80144d:	7f 10                	jg     80145f <strtol+0xe4>
			dig = *s - 'a' + 10;
  80144f:	8b 45 08             	mov    0x8(%ebp),%eax
  801452:	8a 00                	mov    (%eax),%al
  801454:	0f be c0             	movsbl %al,%eax
  801457:	83 e8 57             	sub    $0x57,%eax
  80145a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80145d:	eb 20                	jmp    80147f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80145f:	8b 45 08             	mov    0x8(%ebp),%eax
  801462:	8a 00                	mov    (%eax),%al
  801464:	3c 40                	cmp    $0x40,%al
  801466:	7e 39                	jle    8014a1 <strtol+0x126>
  801468:	8b 45 08             	mov    0x8(%ebp),%eax
  80146b:	8a 00                	mov    (%eax),%al
  80146d:	3c 5a                	cmp    $0x5a,%al
  80146f:	7f 30                	jg     8014a1 <strtol+0x126>
			dig = *s - 'A' + 10;
  801471:	8b 45 08             	mov    0x8(%ebp),%eax
  801474:	8a 00                	mov    (%eax),%al
  801476:	0f be c0             	movsbl %al,%eax
  801479:	83 e8 37             	sub    $0x37,%eax
  80147c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80147f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801482:	3b 45 10             	cmp    0x10(%ebp),%eax
  801485:	7d 19                	jge    8014a0 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801487:	ff 45 08             	incl   0x8(%ebp)
  80148a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80148d:	0f af 45 10          	imul   0x10(%ebp),%eax
  801491:	89 c2                	mov    %eax,%edx
  801493:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801496:	01 d0                	add    %edx,%eax
  801498:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80149b:	e9 7b ff ff ff       	jmp    80141b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014a0:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8014a1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014a5:	74 08                	je     8014af <strtol+0x134>
		*endptr = (char *) s;
  8014a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014aa:	8b 55 08             	mov    0x8(%ebp),%edx
  8014ad:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014af:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014b3:	74 07                	je     8014bc <strtol+0x141>
  8014b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014b8:	f7 d8                	neg    %eax
  8014ba:	eb 03                	jmp    8014bf <strtol+0x144>
  8014bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014bf:	c9                   	leave  
  8014c0:	c3                   	ret    

008014c1 <ltostr>:

void
ltostr(long value, char *str)
{
  8014c1:	55                   	push   %ebp
  8014c2:	89 e5                	mov    %esp,%ebp
  8014c4:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014ce:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014d5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014d9:	79 13                	jns    8014ee <ltostr+0x2d>
	{
		neg = 1;
  8014db:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014e5:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014e8:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014eb:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f1:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014f6:	99                   	cltd   
  8014f7:	f7 f9                	idiv   %ecx
  8014f9:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ff:	8d 50 01             	lea    0x1(%eax),%edx
  801502:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801505:	89 c2                	mov    %eax,%edx
  801507:	8b 45 0c             	mov    0xc(%ebp),%eax
  80150a:	01 d0                	add    %edx,%eax
  80150c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80150f:	83 c2 30             	add    $0x30,%edx
  801512:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801514:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801517:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80151c:	f7 e9                	imul   %ecx
  80151e:	c1 fa 02             	sar    $0x2,%edx
  801521:	89 c8                	mov    %ecx,%eax
  801523:	c1 f8 1f             	sar    $0x1f,%eax
  801526:	29 c2                	sub    %eax,%edx
  801528:	89 d0                	mov    %edx,%eax
  80152a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80152d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801530:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801535:	f7 e9                	imul   %ecx
  801537:	c1 fa 02             	sar    $0x2,%edx
  80153a:	89 c8                	mov    %ecx,%eax
  80153c:	c1 f8 1f             	sar    $0x1f,%eax
  80153f:	29 c2                	sub    %eax,%edx
  801541:	89 d0                	mov    %edx,%eax
  801543:	c1 e0 02             	shl    $0x2,%eax
  801546:	01 d0                	add    %edx,%eax
  801548:	01 c0                	add    %eax,%eax
  80154a:	29 c1                	sub    %eax,%ecx
  80154c:	89 ca                	mov    %ecx,%edx
  80154e:	85 d2                	test   %edx,%edx
  801550:	75 9c                	jne    8014ee <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801552:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801559:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80155c:	48                   	dec    %eax
  80155d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801560:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801564:	74 3d                	je     8015a3 <ltostr+0xe2>
		start = 1 ;
  801566:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80156d:	eb 34                	jmp    8015a3 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80156f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801572:	8b 45 0c             	mov    0xc(%ebp),%eax
  801575:	01 d0                	add    %edx,%eax
  801577:	8a 00                	mov    (%eax),%al
  801579:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80157c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80157f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801582:	01 c2                	add    %eax,%edx
  801584:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801587:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158a:	01 c8                	add    %ecx,%eax
  80158c:	8a 00                	mov    (%eax),%al
  80158e:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801590:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801593:	8b 45 0c             	mov    0xc(%ebp),%eax
  801596:	01 c2                	add    %eax,%edx
  801598:	8a 45 eb             	mov    -0x15(%ebp),%al
  80159b:	88 02                	mov    %al,(%edx)
		start++ ;
  80159d:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015a0:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8015a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015a6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015a9:	7c c4                	jl     80156f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015ab:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b1:	01 d0                	add    %edx,%eax
  8015b3:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015b6:	90                   	nop
  8015b7:	c9                   	leave  
  8015b8:	c3                   	ret    

008015b9 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015b9:	55                   	push   %ebp
  8015ba:	89 e5                	mov    %esp,%ebp
  8015bc:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015bf:	ff 75 08             	pushl  0x8(%ebp)
  8015c2:	e8 54 fa ff ff       	call   80101b <strlen>
  8015c7:	83 c4 04             	add    $0x4,%esp
  8015ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015cd:	ff 75 0c             	pushl  0xc(%ebp)
  8015d0:	e8 46 fa ff ff       	call   80101b <strlen>
  8015d5:	83 c4 04             	add    $0x4,%esp
  8015d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015db:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015e9:	eb 17                	jmp    801602 <strcconcat+0x49>
		final[s] = str1[s] ;
  8015eb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f1:	01 c2                	add    %eax,%edx
  8015f3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f9:	01 c8                	add    %ecx,%eax
  8015fb:	8a 00                	mov    (%eax),%al
  8015fd:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015ff:	ff 45 fc             	incl   -0x4(%ebp)
  801602:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801605:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801608:	7c e1                	jl     8015eb <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80160a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801611:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801618:	eb 1f                	jmp    801639 <strcconcat+0x80>
		final[s++] = str2[i] ;
  80161a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80161d:	8d 50 01             	lea    0x1(%eax),%edx
  801620:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801623:	89 c2                	mov    %eax,%edx
  801625:	8b 45 10             	mov    0x10(%ebp),%eax
  801628:	01 c2                	add    %eax,%edx
  80162a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80162d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801630:	01 c8                	add    %ecx,%eax
  801632:	8a 00                	mov    (%eax),%al
  801634:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801636:	ff 45 f8             	incl   -0x8(%ebp)
  801639:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80163c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80163f:	7c d9                	jl     80161a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801641:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801644:	8b 45 10             	mov    0x10(%ebp),%eax
  801647:	01 d0                	add    %edx,%eax
  801649:	c6 00 00             	movb   $0x0,(%eax)
}
  80164c:	90                   	nop
  80164d:	c9                   	leave  
  80164e:	c3                   	ret    

0080164f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80164f:	55                   	push   %ebp
  801650:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801652:	8b 45 14             	mov    0x14(%ebp),%eax
  801655:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80165b:	8b 45 14             	mov    0x14(%ebp),%eax
  80165e:	8b 00                	mov    (%eax),%eax
  801660:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801667:	8b 45 10             	mov    0x10(%ebp),%eax
  80166a:	01 d0                	add    %edx,%eax
  80166c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801672:	eb 0c                	jmp    801680 <strsplit+0x31>
			*string++ = 0;
  801674:	8b 45 08             	mov    0x8(%ebp),%eax
  801677:	8d 50 01             	lea    0x1(%eax),%edx
  80167a:	89 55 08             	mov    %edx,0x8(%ebp)
  80167d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801680:	8b 45 08             	mov    0x8(%ebp),%eax
  801683:	8a 00                	mov    (%eax),%al
  801685:	84 c0                	test   %al,%al
  801687:	74 18                	je     8016a1 <strsplit+0x52>
  801689:	8b 45 08             	mov    0x8(%ebp),%eax
  80168c:	8a 00                	mov    (%eax),%al
  80168e:	0f be c0             	movsbl %al,%eax
  801691:	50                   	push   %eax
  801692:	ff 75 0c             	pushl  0xc(%ebp)
  801695:	e8 13 fb ff ff       	call   8011ad <strchr>
  80169a:	83 c4 08             	add    $0x8,%esp
  80169d:	85 c0                	test   %eax,%eax
  80169f:	75 d3                	jne    801674 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8016a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a4:	8a 00                	mov    (%eax),%al
  8016a6:	84 c0                	test   %al,%al
  8016a8:	74 5a                	je     801704 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8016aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8016ad:	8b 00                	mov    (%eax),%eax
  8016af:	83 f8 0f             	cmp    $0xf,%eax
  8016b2:	75 07                	jne    8016bb <strsplit+0x6c>
		{
			return 0;
  8016b4:	b8 00 00 00 00       	mov    $0x0,%eax
  8016b9:	eb 66                	jmp    801721 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016bb:	8b 45 14             	mov    0x14(%ebp),%eax
  8016be:	8b 00                	mov    (%eax),%eax
  8016c0:	8d 48 01             	lea    0x1(%eax),%ecx
  8016c3:	8b 55 14             	mov    0x14(%ebp),%edx
  8016c6:	89 0a                	mov    %ecx,(%edx)
  8016c8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d2:	01 c2                	add    %eax,%edx
  8016d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d7:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016d9:	eb 03                	jmp    8016de <strsplit+0x8f>
			string++;
  8016db:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016de:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e1:	8a 00                	mov    (%eax),%al
  8016e3:	84 c0                	test   %al,%al
  8016e5:	74 8b                	je     801672 <strsplit+0x23>
  8016e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ea:	8a 00                	mov    (%eax),%al
  8016ec:	0f be c0             	movsbl %al,%eax
  8016ef:	50                   	push   %eax
  8016f0:	ff 75 0c             	pushl  0xc(%ebp)
  8016f3:	e8 b5 fa ff ff       	call   8011ad <strchr>
  8016f8:	83 c4 08             	add    $0x8,%esp
  8016fb:	85 c0                	test   %eax,%eax
  8016fd:	74 dc                	je     8016db <strsplit+0x8c>
			string++;
	}
  8016ff:	e9 6e ff ff ff       	jmp    801672 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801704:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801705:	8b 45 14             	mov    0x14(%ebp),%eax
  801708:	8b 00                	mov    (%eax),%eax
  80170a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801711:	8b 45 10             	mov    0x10(%ebp),%eax
  801714:	01 d0                	add    %edx,%eax
  801716:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80171c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801721:	c9                   	leave  
  801722:	c3                   	ret    

00801723 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801723:	55                   	push   %ebp
  801724:	89 e5                	mov    %esp,%ebp
  801726:	57                   	push   %edi
  801727:	56                   	push   %esi
  801728:	53                   	push   %ebx
  801729:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80172c:	8b 45 08             	mov    0x8(%ebp),%eax
  80172f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801732:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801735:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801738:	8b 7d 18             	mov    0x18(%ebp),%edi
  80173b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80173e:	cd 30                	int    $0x30
  801740:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801743:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801746:	83 c4 10             	add    $0x10,%esp
  801749:	5b                   	pop    %ebx
  80174a:	5e                   	pop    %esi
  80174b:	5f                   	pop    %edi
  80174c:	5d                   	pop    %ebp
  80174d:	c3                   	ret    

0080174e <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80174e:	55                   	push   %ebp
  80174f:	89 e5                	mov    %esp,%ebp
  801751:	83 ec 04             	sub    $0x4,%esp
  801754:	8b 45 10             	mov    0x10(%ebp),%eax
  801757:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80175a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80175e:	8b 45 08             	mov    0x8(%ebp),%eax
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	52                   	push   %edx
  801766:	ff 75 0c             	pushl  0xc(%ebp)
  801769:	50                   	push   %eax
  80176a:	6a 00                	push   $0x0
  80176c:	e8 b2 ff ff ff       	call   801723 <syscall>
  801771:	83 c4 18             	add    $0x18,%esp
}
  801774:	90                   	nop
  801775:	c9                   	leave  
  801776:	c3                   	ret    

00801777 <sys_cgetc>:

int
sys_cgetc(void)
{
  801777:	55                   	push   %ebp
  801778:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	6a 01                	push   $0x1
  801786:	e8 98 ff ff ff       	call   801723 <syscall>
  80178b:	83 c4 18             	add    $0x18,%esp
}
  80178e:	c9                   	leave  
  80178f:	c3                   	ret    

00801790 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801790:	55                   	push   %ebp
  801791:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801793:	8b 45 08             	mov    0x8(%ebp),%eax
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	50                   	push   %eax
  80179f:	6a 05                	push   $0x5
  8017a1:	e8 7d ff ff ff       	call   801723 <syscall>
  8017a6:	83 c4 18             	add    $0x18,%esp
}
  8017a9:	c9                   	leave  
  8017aa:	c3                   	ret    

008017ab <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017ab:	55                   	push   %ebp
  8017ac:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 02                	push   $0x2
  8017ba:	e8 64 ff ff ff       	call   801723 <syscall>
  8017bf:	83 c4 18             	add    $0x18,%esp
}
  8017c2:	c9                   	leave  
  8017c3:	c3                   	ret    

008017c4 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017c4:	55                   	push   %ebp
  8017c5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 03                	push   $0x3
  8017d3:	e8 4b ff ff ff       	call   801723 <syscall>
  8017d8:	83 c4 18             	add    $0x18,%esp
}
  8017db:	c9                   	leave  
  8017dc:	c3                   	ret    

008017dd <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017dd:	55                   	push   %ebp
  8017de:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 04                	push   $0x4
  8017ec:	e8 32 ff ff ff       	call   801723 <syscall>
  8017f1:	83 c4 18             	add    $0x18,%esp
}
  8017f4:	c9                   	leave  
  8017f5:	c3                   	ret    

008017f6 <sys_env_exit>:


void sys_env_exit(void)
{
  8017f6:	55                   	push   %ebp
  8017f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 06                	push   $0x6
  801805:	e8 19 ff ff ff       	call   801723 <syscall>
  80180a:	83 c4 18             	add    $0x18,%esp
}
  80180d:	90                   	nop
  80180e:	c9                   	leave  
  80180f:	c3                   	ret    

00801810 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801810:	55                   	push   %ebp
  801811:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801813:	8b 55 0c             	mov    0xc(%ebp),%edx
  801816:	8b 45 08             	mov    0x8(%ebp),%eax
  801819:	6a 00                	push   $0x0
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	52                   	push   %edx
  801820:	50                   	push   %eax
  801821:	6a 07                	push   $0x7
  801823:	e8 fb fe ff ff       	call   801723 <syscall>
  801828:	83 c4 18             	add    $0x18,%esp
}
  80182b:	c9                   	leave  
  80182c:	c3                   	ret    

0080182d <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80182d:	55                   	push   %ebp
  80182e:	89 e5                	mov    %esp,%ebp
  801830:	56                   	push   %esi
  801831:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801832:	8b 75 18             	mov    0x18(%ebp),%esi
  801835:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801838:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80183b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80183e:	8b 45 08             	mov    0x8(%ebp),%eax
  801841:	56                   	push   %esi
  801842:	53                   	push   %ebx
  801843:	51                   	push   %ecx
  801844:	52                   	push   %edx
  801845:	50                   	push   %eax
  801846:	6a 08                	push   $0x8
  801848:	e8 d6 fe ff ff       	call   801723 <syscall>
  80184d:	83 c4 18             	add    $0x18,%esp
}
  801850:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801853:	5b                   	pop    %ebx
  801854:	5e                   	pop    %esi
  801855:	5d                   	pop    %ebp
  801856:	c3                   	ret    

00801857 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801857:	55                   	push   %ebp
  801858:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80185a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80185d:	8b 45 08             	mov    0x8(%ebp),%eax
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	52                   	push   %edx
  801867:	50                   	push   %eax
  801868:	6a 09                	push   $0x9
  80186a:	e8 b4 fe ff ff       	call   801723 <syscall>
  80186f:	83 c4 18             	add    $0x18,%esp
}
  801872:	c9                   	leave  
  801873:	c3                   	ret    

00801874 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801874:	55                   	push   %ebp
  801875:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	ff 75 0c             	pushl  0xc(%ebp)
  801880:	ff 75 08             	pushl  0x8(%ebp)
  801883:	6a 0a                	push   $0xa
  801885:	e8 99 fe ff ff       	call   801723 <syscall>
  80188a:	83 c4 18             	add    $0x18,%esp
}
  80188d:	c9                   	leave  
  80188e:	c3                   	ret    

0080188f <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80188f:	55                   	push   %ebp
  801890:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801892:	6a 00                	push   $0x0
  801894:	6a 00                	push   $0x0
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	6a 0b                	push   $0xb
  80189e:	e8 80 fe ff ff       	call   801723 <syscall>
  8018a3:	83 c4 18             	add    $0x18,%esp
}
  8018a6:	c9                   	leave  
  8018a7:	c3                   	ret    

008018a8 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8018a8:	55                   	push   %ebp
  8018a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 00                	push   $0x0
  8018b1:	6a 00                	push   $0x0
  8018b3:	6a 00                	push   $0x0
  8018b5:	6a 0c                	push   $0xc
  8018b7:	e8 67 fe ff ff       	call   801723 <syscall>
  8018bc:	83 c4 18             	add    $0x18,%esp
}
  8018bf:	c9                   	leave  
  8018c0:	c3                   	ret    

008018c1 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018c1:	55                   	push   %ebp
  8018c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 00                	push   $0x0
  8018c8:	6a 00                	push   $0x0
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 0d                	push   $0xd
  8018d0:	e8 4e fe ff ff       	call   801723 <syscall>
  8018d5:	83 c4 18             	add    $0x18,%esp
}
  8018d8:	c9                   	leave  
  8018d9:	c3                   	ret    

008018da <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018da:	55                   	push   %ebp
  8018db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	ff 75 0c             	pushl  0xc(%ebp)
  8018e6:	ff 75 08             	pushl  0x8(%ebp)
  8018e9:	6a 11                	push   $0x11
  8018eb:	e8 33 fe ff ff       	call   801723 <syscall>
  8018f0:	83 c4 18             	add    $0x18,%esp
	return;
  8018f3:	90                   	nop
}
  8018f4:	c9                   	leave  
  8018f5:	c3                   	ret    

008018f6 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018f6:	55                   	push   %ebp
  8018f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	ff 75 0c             	pushl  0xc(%ebp)
  801902:	ff 75 08             	pushl  0x8(%ebp)
  801905:	6a 12                	push   $0x12
  801907:	e8 17 fe ff ff       	call   801723 <syscall>
  80190c:	83 c4 18             	add    $0x18,%esp
	return ;
  80190f:	90                   	nop
}
  801910:	c9                   	leave  
  801911:	c3                   	ret    

00801912 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801912:	55                   	push   %ebp
  801913:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	6a 00                	push   $0x0
  80191b:	6a 00                	push   $0x0
  80191d:	6a 00                	push   $0x0
  80191f:	6a 0e                	push   $0xe
  801921:	e8 fd fd ff ff       	call   801723 <syscall>
  801926:	83 c4 18             	add    $0x18,%esp
}
  801929:	c9                   	leave  
  80192a:	c3                   	ret    

0080192b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80192b:	55                   	push   %ebp
  80192c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	ff 75 08             	pushl  0x8(%ebp)
  801939:	6a 0f                	push   $0xf
  80193b:	e8 e3 fd ff ff       	call   801723 <syscall>
  801940:	83 c4 18             	add    $0x18,%esp
}
  801943:	c9                   	leave  
  801944:	c3                   	ret    

00801945 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801945:	55                   	push   %ebp
  801946:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	6a 00                	push   $0x0
  801950:	6a 00                	push   $0x0
  801952:	6a 10                	push   $0x10
  801954:	e8 ca fd ff ff       	call   801723 <syscall>
  801959:	83 c4 18             	add    $0x18,%esp
}
  80195c:	90                   	nop
  80195d:	c9                   	leave  
  80195e:	c3                   	ret    

0080195f <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80195f:	55                   	push   %ebp
  801960:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	6a 00                	push   $0x0
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	6a 14                	push   $0x14
  80196e:	e8 b0 fd ff ff       	call   801723 <syscall>
  801973:	83 c4 18             	add    $0x18,%esp
}
  801976:	90                   	nop
  801977:	c9                   	leave  
  801978:	c3                   	ret    

00801979 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801979:	55                   	push   %ebp
  80197a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	6a 00                	push   $0x0
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 15                	push   $0x15
  801988:	e8 96 fd ff ff       	call   801723 <syscall>
  80198d:	83 c4 18             	add    $0x18,%esp
}
  801990:	90                   	nop
  801991:	c9                   	leave  
  801992:	c3                   	ret    

00801993 <sys_cputc>:


void
sys_cputc(const char c)
{
  801993:	55                   	push   %ebp
  801994:	89 e5                	mov    %esp,%ebp
  801996:	83 ec 04             	sub    $0x4,%esp
  801999:	8b 45 08             	mov    0x8(%ebp),%eax
  80199c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80199f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	6a 00                	push   $0x0
  8019a9:	6a 00                	push   $0x0
  8019ab:	50                   	push   %eax
  8019ac:	6a 16                	push   $0x16
  8019ae:	e8 70 fd ff ff       	call   801723 <syscall>
  8019b3:	83 c4 18             	add    $0x18,%esp
}
  8019b6:	90                   	nop
  8019b7:	c9                   	leave  
  8019b8:	c3                   	ret    

008019b9 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8019b9:	55                   	push   %ebp
  8019ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 00                	push   $0x0
  8019c6:	6a 17                	push   $0x17
  8019c8:	e8 56 fd ff ff       	call   801723 <syscall>
  8019cd:	83 c4 18             	add    $0x18,%esp
}
  8019d0:	90                   	nop
  8019d1:	c9                   	leave  
  8019d2:	c3                   	ret    

008019d3 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019d3:	55                   	push   %ebp
  8019d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 00                	push   $0x0
  8019df:	ff 75 0c             	pushl  0xc(%ebp)
  8019e2:	50                   	push   %eax
  8019e3:	6a 18                	push   $0x18
  8019e5:	e8 39 fd ff ff       	call   801723 <syscall>
  8019ea:	83 c4 18             	add    $0x18,%esp
}
  8019ed:	c9                   	leave  
  8019ee:	c3                   	ret    

008019ef <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019ef:	55                   	push   %ebp
  8019f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f8:	6a 00                	push   $0x0
  8019fa:	6a 00                	push   $0x0
  8019fc:	6a 00                	push   $0x0
  8019fe:	52                   	push   %edx
  8019ff:	50                   	push   %eax
  801a00:	6a 1b                	push   $0x1b
  801a02:	e8 1c fd ff ff       	call   801723 <syscall>
  801a07:	83 c4 18             	add    $0x18,%esp
}
  801a0a:	c9                   	leave  
  801a0b:	c3                   	ret    

00801a0c <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a0c:	55                   	push   %ebp
  801a0d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a12:	8b 45 08             	mov    0x8(%ebp),%eax
  801a15:	6a 00                	push   $0x0
  801a17:	6a 00                	push   $0x0
  801a19:	6a 00                	push   $0x0
  801a1b:	52                   	push   %edx
  801a1c:	50                   	push   %eax
  801a1d:	6a 19                	push   $0x19
  801a1f:	e8 ff fc ff ff       	call   801723 <syscall>
  801a24:	83 c4 18             	add    $0x18,%esp
}
  801a27:	90                   	nop
  801a28:	c9                   	leave  
  801a29:	c3                   	ret    

00801a2a <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a2a:	55                   	push   %ebp
  801a2b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a2d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a30:	8b 45 08             	mov    0x8(%ebp),%eax
  801a33:	6a 00                	push   $0x0
  801a35:	6a 00                	push   $0x0
  801a37:	6a 00                	push   $0x0
  801a39:	52                   	push   %edx
  801a3a:	50                   	push   %eax
  801a3b:	6a 1a                	push   $0x1a
  801a3d:	e8 e1 fc ff ff       	call   801723 <syscall>
  801a42:	83 c4 18             	add    $0x18,%esp
}
  801a45:	90                   	nop
  801a46:	c9                   	leave  
  801a47:	c3                   	ret    

00801a48 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a48:	55                   	push   %ebp
  801a49:	89 e5                	mov    %esp,%ebp
  801a4b:	83 ec 04             	sub    $0x4,%esp
  801a4e:	8b 45 10             	mov    0x10(%ebp),%eax
  801a51:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a54:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a57:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5e:	6a 00                	push   $0x0
  801a60:	51                   	push   %ecx
  801a61:	52                   	push   %edx
  801a62:	ff 75 0c             	pushl  0xc(%ebp)
  801a65:	50                   	push   %eax
  801a66:	6a 1c                	push   $0x1c
  801a68:	e8 b6 fc ff ff       	call   801723 <syscall>
  801a6d:	83 c4 18             	add    $0x18,%esp
}
  801a70:	c9                   	leave  
  801a71:	c3                   	ret    

00801a72 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a72:	55                   	push   %ebp
  801a73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a75:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a78:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	52                   	push   %edx
  801a82:	50                   	push   %eax
  801a83:	6a 1d                	push   $0x1d
  801a85:	e8 99 fc ff ff       	call   801723 <syscall>
  801a8a:	83 c4 18             	add    $0x18,%esp
}
  801a8d:	c9                   	leave  
  801a8e:	c3                   	ret    

00801a8f <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a8f:	55                   	push   %ebp
  801a90:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a92:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a95:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a98:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 00                	push   $0x0
  801a9f:	51                   	push   %ecx
  801aa0:	52                   	push   %edx
  801aa1:	50                   	push   %eax
  801aa2:	6a 1e                	push   $0x1e
  801aa4:	e8 7a fc ff ff       	call   801723 <syscall>
  801aa9:	83 c4 18             	add    $0x18,%esp
}
  801aac:	c9                   	leave  
  801aad:	c3                   	ret    

00801aae <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801aae:	55                   	push   %ebp
  801aaf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ab1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ab4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 00                	push   $0x0
  801abd:	52                   	push   %edx
  801abe:	50                   	push   %eax
  801abf:	6a 1f                	push   $0x1f
  801ac1:	e8 5d fc ff ff       	call   801723 <syscall>
  801ac6:	83 c4 18             	add    $0x18,%esp
}
  801ac9:	c9                   	leave  
  801aca:	c3                   	ret    

00801acb <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801acb:	55                   	push   %ebp
  801acc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 00                	push   $0x0
  801ad6:	6a 00                	push   $0x0
  801ad8:	6a 20                	push   $0x20
  801ada:	e8 44 fc ff ff       	call   801723 <syscall>
  801adf:	83 c4 18             	add    $0x18,%esp
}
  801ae2:	c9                   	leave  
  801ae3:	c3                   	ret    

00801ae4 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801ae4:	55                   	push   %ebp
  801ae5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  801aea:	6a 00                	push   $0x0
  801aec:	ff 75 14             	pushl  0x14(%ebp)
  801aef:	ff 75 10             	pushl  0x10(%ebp)
  801af2:	ff 75 0c             	pushl  0xc(%ebp)
  801af5:	50                   	push   %eax
  801af6:	6a 21                	push   $0x21
  801af8:	e8 26 fc ff ff       	call   801723 <syscall>
  801afd:	83 c4 18             	add    $0x18,%esp
}
  801b00:	c9                   	leave  
  801b01:	c3                   	ret    

00801b02 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801b02:	55                   	push   %ebp
  801b03:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801b05:	8b 45 08             	mov    0x8(%ebp),%eax
  801b08:	6a 00                	push   $0x0
  801b0a:	6a 00                	push   $0x0
  801b0c:	6a 00                	push   $0x0
  801b0e:	6a 00                	push   $0x0
  801b10:	50                   	push   %eax
  801b11:	6a 22                	push   $0x22
  801b13:	e8 0b fc ff ff       	call   801723 <syscall>
  801b18:	83 c4 18             	add    $0x18,%esp
}
  801b1b:	90                   	nop
  801b1c:	c9                   	leave  
  801b1d:	c3                   	ret    

00801b1e <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b1e:	55                   	push   %ebp
  801b1f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b21:	8b 45 08             	mov    0x8(%ebp),%eax
  801b24:	6a 00                	push   $0x0
  801b26:	6a 00                	push   $0x0
  801b28:	6a 00                	push   $0x0
  801b2a:	6a 00                	push   $0x0
  801b2c:	50                   	push   %eax
  801b2d:	6a 23                	push   $0x23
  801b2f:	e8 ef fb ff ff       	call   801723 <syscall>
  801b34:	83 c4 18             	add    $0x18,%esp
}
  801b37:	90                   	nop
  801b38:	c9                   	leave  
  801b39:	c3                   	ret    

00801b3a <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b3a:	55                   	push   %ebp
  801b3b:	89 e5                	mov    %esp,%ebp
  801b3d:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b40:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b43:	8d 50 04             	lea    0x4(%eax),%edx
  801b46:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b49:	6a 00                	push   $0x0
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 00                	push   $0x0
  801b4f:	52                   	push   %edx
  801b50:	50                   	push   %eax
  801b51:	6a 24                	push   $0x24
  801b53:	e8 cb fb ff ff       	call   801723 <syscall>
  801b58:	83 c4 18             	add    $0x18,%esp
	return result;
  801b5b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b5e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b61:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b64:	89 01                	mov    %eax,(%ecx)
  801b66:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b69:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6c:	c9                   	leave  
  801b6d:	c2 04 00             	ret    $0x4

00801b70 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b70:	55                   	push   %ebp
  801b71:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b73:	6a 00                	push   $0x0
  801b75:	6a 00                	push   $0x0
  801b77:	ff 75 10             	pushl  0x10(%ebp)
  801b7a:	ff 75 0c             	pushl  0xc(%ebp)
  801b7d:	ff 75 08             	pushl  0x8(%ebp)
  801b80:	6a 13                	push   $0x13
  801b82:	e8 9c fb ff ff       	call   801723 <syscall>
  801b87:	83 c4 18             	add    $0x18,%esp
	return ;
  801b8a:	90                   	nop
}
  801b8b:	c9                   	leave  
  801b8c:	c3                   	ret    

00801b8d <sys_rcr2>:
uint32 sys_rcr2()
{
  801b8d:	55                   	push   %ebp
  801b8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b90:	6a 00                	push   $0x0
  801b92:	6a 00                	push   $0x0
  801b94:	6a 00                	push   $0x0
  801b96:	6a 00                	push   $0x0
  801b98:	6a 00                	push   $0x0
  801b9a:	6a 25                	push   $0x25
  801b9c:	e8 82 fb ff ff       	call   801723 <syscall>
  801ba1:	83 c4 18             	add    $0x18,%esp
}
  801ba4:	c9                   	leave  
  801ba5:	c3                   	ret    

00801ba6 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801ba6:	55                   	push   %ebp
  801ba7:	89 e5                	mov    %esp,%ebp
  801ba9:	83 ec 04             	sub    $0x4,%esp
  801bac:	8b 45 08             	mov    0x8(%ebp),%eax
  801baf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801bb2:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 00                	push   $0x0
  801bba:	6a 00                	push   $0x0
  801bbc:	6a 00                	push   $0x0
  801bbe:	50                   	push   %eax
  801bbf:	6a 26                	push   $0x26
  801bc1:	e8 5d fb ff ff       	call   801723 <syscall>
  801bc6:	83 c4 18             	add    $0x18,%esp
	return ;
  801bc9:	90                   	nop
}
  801bca:	c9                   	leave  
  801bcb:	c3                   	ret    

00801bcc <rsttst>:
void rsttst()
{
  801bcc:	55                   	push   %ebp
  801bcd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bcf:	6a 00                	push   $0x0
  801bd1:	6a 00                	push   $0x0
  801bd3:	6a 00                	push   $0x0
  801bd5:	6a 00                	push   $0x0
  801bd7:	6a 00                	push   $0x0
  801bd9:	6a 28                	push   $0x28
  801bdb:	e8 43 fb ff ff       	call   801723 <syscall>
  801be0:	83 c4 18             	add    $0x18,%esp
	return ;
  801be3:	90                   	nop
}
  801be4:	c9                   	leave  
  801be5:	c3                   	ret    

00801be6 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801be6:	55                   	push   %ebp
  801be7:	89 e5                	mov    %esp,%ebp
  801be9:	83 ec 04             	sub    $0x4,%esp
  801bec:	8b 45 14             	mov    0x14(%ebp),%eax
  801bef:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bf2:	8b 55 18             	mov    0x18(%ebp),%edx
  801bf5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bf9:	52                   	push   %edx
  801bfa:	50                   	push   %eax
  801bfb:	ff 75 10             	pushl  0x10(%ebp)
  801bfe:	ff 75 0c             	pushl  0xc(%ebp)
  801c01:	ff 75 08             	pushl  0x8(%ebp)
  801c04:	6a 27                	push   $0x27
  801c06:	e8 18 fb ff ff       	call   801723 <syscall>
  801c0b:	83 c4 18             	add    $0x18,%esp
	return ;
  801c0e:	90                   	nop
}
  801c0f:	c9                   	leave  
  801c10:	c3                   	ret    

00801c11 <chktst>:
void chktst(uint32 n)
{
  801c11:	55                   	push   %ebp
  801c12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	ff 75 08             	pushl  0x8(%ebp)
  801c1f:	6a 29                	push   $0x29
  801c21:	e8 fd fa ff ff       	call   801723 <syscall>
  801c26:	83 c4 18             	add    $0x18,%esp
	return ;
  801c29:	90                   	nop
}
  801c2a:	c9                   	leave  
  801c2b:	c3                   	ret    

00801c2c <inctst>:

void inctst()
{
  801c2c:	55                   	push   %ebp
  801c2d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 00                	push   $0x0
  801c33:	6a 00                	push   $0x0
  801c35:	6a 00                	push   $0x0
  801c37:	6a 00                	push   $0x0
  801c39:	6a 2a                	push   $0x2a
  801c3b:	e8 e3 fa ff ff       	call   801723 <syscall>
  801c40:	83 c4 18             	add    $0x18,%esp
	return ;
  801c43:	90                   	nop
}
  801c44:	c9                   	leave  
  801c45:	c3                   	ret    

00801c46 <gettst>:
uint32 gettst()
{
  801c46:	55                   	push   %ebp
  801c47:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 00                	push   $0x0
  801c4f:	6a 00                	push   $0x0
  801c51:	6a 00                	push   $0x0
  801c53:	6a 2b                	push   $0x2b
  801c55:	e8 c9 fa ff ff       	call   801723 <syscall>
  801c5a:	83 c4 18             	add    $0x18,%esp
}
  801c5d:	c9                   	leave  
  801c5e:	c3                   	ret    

00801c5f <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c5f:	55                   	push   %ebp
  801c60:	89 e5                	mov    %esp,%ebp
  801c62:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c65:	6a 00                	push   $0x0
  801c67:	6a 00                	push   $0x0
  801c69:	6a 00                	push   $0x0
  801c6b:	6a 00                	push   $0x0
  801c6d:	6a 00                	push   $0x0
  801c6f:	6a 2c                	push   $0x2c
  801c71:	e8 ad fa ff ff       	call   801723 <syscall>
  801c76:	83 c4 18             	add    $0x18,%esp
  801c79:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c7c:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c80:	75 07                	jne    801c89 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c82:	b8 01 00 00 00       	mov    $0x1,%eax
  801c87:	eb 05                	jmp    801c8e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c89:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c8e:	c9                   	leave  
  801c8f:	c3                   	ret    

00801c90 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c90:	55                   	push   %ebp
  801c91:	89 e5                	mov    %esp,%ebp
  801c93:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c96:	6a 00                	push   $0x0
  801c98:	6a 00                	push   $0x0
  801c9a:	6a 00                	push   $0x0
  801c9c:	6a 00                	push   $0x0
  801c9e:	6a 00                	push   $0x0
  801ca0:	6a 2c                	push   $0x2c
  801ca2:	e8 7c fa ff ff       	call   801723 <syscall>
  801ca7:	83 c4 18             	add    $0x18,%esp
  801caa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801cad:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801cb1:	75 07                	jne    801cba <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801cb3:	b8 01 00 00 00       	mov    $0x1,%eax
  801cb8:	eb 05                	jmp    801cbf <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801cba:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cbf:	c9                   	leave  
  801cc0:	c3                   	ret    

00801cc1 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801cc1:	55                   	push   %ebp
  801cc2:	89 e5                	mov    %esp,%ebp
  801cc4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cc7:	6a 00                	push   $0x0
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 00                	push   $0x0
  801cd1:	6a 2c                	push   $0x2c
  801cd3:	e8 4b fa ff ff       	call   801723 <syscall>
  801cd8:	83 c4 18             	add    $0x18,%esp
  801cdb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801cde:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801ce2:	75 07                	jne    801ceb <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801ce4:	b8 01 00 00 00       	mov    $0x1,%eax
  801ce9:	eb 05                	jmp    801cf0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ceb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cf0:	c9                   	leave  
  801cf1:	c3                   	ret    

00801cf2 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801cf2:	55                   	push   %ebp
  801cf3:	89 e5                	mov    %esp,%ebp
  801cf5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cf8:	6a 00                	push   $0x0
  801cfa:	6a 00                	push   $0x0
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	6a 2c                	push   $0x2c
  801d04:	e8 1a fa ff ff       	call   801723 <syscall>
  801d09:	83 c4 18             	add    $0x18,%esp
  801d0c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d0f:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d13:	75 07                	jne    801d1c <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d15:	b8 01 00 00 00       	mov    $0x1,%eax
  801d1a:	eb 05                	jmp    801d21 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d1c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d21:	c9                   	leave  
  801d22:	c3                   	ret    

00801d23 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d23:	55                   	push   %ebp
  801d24:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d26:	6a 00                	push   $0x0
  801d28:	6a 00                	push   $0x0
  801d2a:	6a 00                	push   $0x0
  801d2c:	6a 00                	push   $0x0
  801d2e:	ff 75 08             	pushl  0x8(%ebp)
  801d31:	6a 2d                	push   $0x2d
  801d33:	e8 eb f9 ff ff       	call   801723 <syscall>
  801d38:	83 c4 18             	add    $0x18,%esp
	return ;
  801d3b:	90                   	nop
}
  801d3c:	c9                   	leave  
  801d3d:	c3                   	ret    

00801d3e <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d3e:	55                   	push   %ebp
  801d3f:	89 e5                	mov    %esp,%ebp
  801d41:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d42:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d45:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d48:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4e:	6a 00                	push   $0x0
  801d50:	53                   	push   %ebx
  801d51:	51                   	push   %ecx
  801d52:	52                   	push   %edx
  801d53:	50                   	push   %eax
  801d54:	6a 2e                	push   $0x2e
  801d56:	e8 c8 f9 ff ff       	call   801723 <syscall>
  801d5b:	83 c4 18             	add    $0x18,%esp
}
  801d5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d61:	c9                   	leave  
  801d62:	c3                   	ret    

00801d63 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d63:	55                   	push   %ebp
  801d64:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d66:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d69:	8b 45 08             	mov    0x8(%ebp),%eax
  801d6c:	6a 00                	push   $0x0
  801d6e:	6a 00                	push   $0x0
  801d70:	6a 00                	push   $0x0
  801d72:	52                   	push   %edx
  801d73:	50                   	push   %eax
  801d74:	6a 2f                	push   $0x2f
  801d76:	e8 a8 f9 ff ff       	call   801723 <syscall>
  801d7b:	83 c4 18             	add    $0x18,%esp
}
  801d7e:	c9                   	leave  
  801d7f:	c3                   	ret    

00801d80 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801d80:	55                   	push   %ebp
  801d81:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801d83:	6a 00                	push   $0x0
  801d85:	6a 00                	push   $0x0
  801d87:	6a 00                	push   $0x0
  801d89:	ff 75 0c             	pushl  0xc(%ebp)
  801d8c:	ff 75 08             	pushl  0x8(%ebp)
  801d8f:	6a 30                	push   $0x30
  801d91:	e8 8d f9 ff ff       	call   801723 <syscall>
  801d96:	83 c4 18             	add    $0x18,%esp
	return ;
  801d99:	90                   	nop
}
  801d9a:	c9                   	leave  
  801d9b:	c3                   	ret    

00801d9c <__udivdi3>:
  801d9c:	55                   	push   %ebp
  801d9d:	57                   	push   %edi
  801d9e:	56                   	push   %esi
  801d9f:	53                   	push   %ebx
  801da0:	83 ec 1c             	sub    $0x1c,%esp
  801da3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801da7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801dab:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801daf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801db3:	89 ca                	mov    %ecx,%edx
  801db5:	89 f8                	mov    %edi,%eax
  801db7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801dbb:	85 f6                	test   %esi,%esi
  801dbd:	75 2d                	jne    801dec <__udivdi3+0x50>
  801dbf:	39 cf                	cmp    %ecx,%edi
  801dc1:	77 65                	ja     801e28 <__udivdi3+0x8c>
  801dc3:	89 fd                	mov    %edi,%ebp
  801dc5:	85 ff                	test   %edi,%edi
  801dc7:	75 0b                	jne    801dd4 <__udivdi3+0x38>
  801dc9:	b8 01 00 00 00       	mov    $0x1,%eax
  801dce:	31 d2                	xor    %edx,%edx
  801dd0:	f7 f7                	div    %edi
  801dd2:	89 c5                	mov    %eax,%ebp
  801dd4:	31 d2                	xor    %edx,%edx
  801dd6:	89 c8                	mov    %ecx,%eax
  801dd8:	f7 f5                	div    %ebp
  801dda:	89 c1                	mov    %eax,%ecx
  801ddc:	89 d8                	mov    %ebx,%eax
  801dde:	f7 f5                	div    %ebp
  801de0:	89 cf                	mov    %ecx,%edi
  801de2:	89 fa                	mov    %edi,%edx
  801de4:	83 c4 1c             	add    $0x1c,%esp
  801de7:	5b                   	pop    %ebx
  801de8:	5e                   	pop    %esi
  801de9:	5f                   	pop    %edi
  801dea:	5d                   	pop    %ebp
  801deb:	c3                   	ret    
  801dec:	39 ce                	cmp    %ecx,%esi
  801dee:	77 28                	ja     801e18 <__udivdi3+0x7c>
  801df0:	0f bd fe             	bsr    %esi,%edi
  801df3:	83 f7 1f             	xor    $0x1f,%edi
  801df6:	75 40                	jne    801e38 <__udivdi3+0x9c>
  801df8:	39 ce                	cmp    %ecx,%esi
  801dfa:	72 0a                	jb     801e06 <__udivdi3+0x6a>
  801dfc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e00:	0f 87 9e 00 00 00    	ja     801ea4 <__udivdi3+0x108>
  801e06:	b8 01 00 00 00       	mov    $0x1,%eax
  801e0b:	89 fa                	mov    %edi,%edx
  801e0d:	83 c4 1c             	add    $0x1c,%esp
  801e10:	5b                   	pop    %ebx
  801e11:	5e                   	pop    %esi
  801e12:	5f                   	pop    %edi
  801e13:	5d                   	pop    %ebp
  801e14:	c3                   	ret    
  801e15:	8d 76 00             	lea    0x0(%esi),%esi
  801e18:	31 ff                	xor    %edi,%edi
  801e1a:	31 c0                	xor    %eax,%eax
  801e1c:	89 fa                	mov    %edi,%edx
  801e1e:	83 c4 1c             	add    $0x1c,%esp
  801e21:	5b                   	pop    %ebx
  801e22:	5e                   	pop    %esi
  801e23:	5f                   	pop    %edi
  801e24:	5d                   	pop    %ebp
  801e25:	c3                   	ret    
  801e26:	66 90                	xchg   %ax,%ax
  801e28:	89 d8                	mov    %ebx,%eax
  801e2a:	f7 f7                	div    %edi
  801e2c:	31 ff                	xor    %edi,%edi
  801e2e:	89 fa                	mov    %edi,%edx
  801e30:	83 c4 1c             	add    $0x1c,%esp
  801e33:	5b                   	pop    %ebx
  801e34:	5e                   	pop    %esi
  801e35:	5f                   	pop    %edi
  801e36:	5d                   	pop    %ebp
  801e37:	c3                   	ret    
  801e38:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e3d:	89 eb                	mov    %ebp,%ebx
  801e3f:	29 fb                	sub    %edi,%ebx
  801e41:	89 f9                	mov    %edi,%ecx
  801e43:	d3 e6                	shl    %cl,%esi
  801e45:	89 c5                	mov    %eax,%ebp
  801e47:	88 d9                	mov    %bl,%cl
  801e49:	d3 ed                	shr    %cl,%ebp
  801e4b:	89 e9                	mov    %ebp,%ecx
  801e4d:	09 f1                	or     %esi,%ecx
  801e4f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e53:	89 f9                	mov    %edi,%ecx
  801e55:	d3 e0                	shl    %cl,%eax
  801e57:	89 c5                	mov    %eax,%ebp
  801e59:	89 d6                	mov    %edx,%esi
  801e5b:	88 d9                	mov    %bl,%cl
  801e5d:	d3 ee                	shr    %cl,%esi
  801e5f:	89 f9                	mov    %edi,%ecx
  801e61:	d3 e2                	shl    %cl,%edx
  801e63:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e67:	88 d9                	mov    %bl,%cl
  801e69:	d3 e8                	shr    %cl,%eax
  801e6b:	09 c2                	or     %eax,%edx
  801e6d:	89 d0                	mov    %edx,%eax
  801e6f:	89 f2                	mov    %esi,%edx
  801e71:	f7 74 24 0c          	divl   0xc(%esp)
  801e75:	89 d6                	mov    %edx,%esi
  801e77:	89 c3                	mov    %eax,%ebx
  801e79:	f7 e5                	mul    %ebp
  801e7b:	39 d6                	cmp    %edx,%esi
  801e7d:	72 19                	jb     801e98 <__udivdi3+0xfc>
  801e7f:	74 0b                	je     801e8c <__udivdi3+0xf0>
  801e81:	89 d8                	mov    %ebx,%eax
  801e83:	31 ff                	xor    %edi,%edi
  801e85:	e9 58 ff ff ff       	jmp    801de2 <__udivdi3+0x46>
  801e8a:	66 90                	xchg   %ax,%ax
  801e8c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e90:	89 f9                	mov    %edi,%ecx
  801e92:	d3 e2                	shl    %cl,%edx
  801e94:	39 c2                	cmp    %eax,%edx
  801e96:	73 e9                	jae    801e81 <__udivdi3+0xe5>
  801e98:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e9b:	31 ff                	xor    %edi,%edi
  801e9d:	e9 40 ff ff ff       	jmp    801de2 <__udivdi3+0x46>
  801ea2:	66 90                	xchg   %ax,%ax
  801ea4:	31 c0                	xor    %eax,%eax
  801ea6:	e9 37 ff ff ff       	jmp    801de2 <__udivdi3+0x46>
  801eab:	90                   	nop

00801eac <__umoddi3>:
  801eac:	55                   	push   %ebp
  801ead:	57                   	push   %edi
  801eae:	56                   	push   %esi
  801eaf:	53                   	push   %ebx
  801eb0:	83 ec 1c             	sub    $0x1c,%esp
  801eb3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801eb7:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ebb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ebf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801ec3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ec7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801ecb:	89 f3                	mov    %esi,%ebx
  801ecd:	89 fa                	mov    %edi,%edx
  801ecf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ed3:	89 34 24             	mov    %esi,(%esp)
  801ed6:	85 c0                	test   %eax,%eax
  801ed8:	75 1a                	jne    801ef4 <__umoddi3+0x48>
  801eda:	39 f7                	cmp    %esi,%edi
  801edc:	0f 86 a2 00 00 00    	jbe    801f84 <__umoddi3+0xd8>
  801ee2:	89 c8                	mov    %ecx,%eax
  801ee4:	89 f2                	mov    %esi,%edx
  801ee6:	f7 f7                	div    %edi
  801ee8:	89 d0                	mov    %edx,%eax
  801eea:	31 d2                	xor    %edx,%edx
  801eec:	83 c4 1c             	add    $0x1c,%esp
  801eef:	5b                   	pop    %ebx
  801ef0:	5e                   	pop    %esi
  801ef1:	5f                   	pop    %edi
  801ef2:	5d                   	pop    %ebp
  801ef3:	c3                   	ret    
  801ef4:	39 f0                	cmp    %esi,%eax
  801ef6:	0f 87 ac 00 00 00    	ja     801fa8 <__umoddi3+0xfc>
  801efc:	0f bd e8             	bsr    %eax,%ebp
  801eff:	83 f5 1f             	xor    $0x1f,%ebp
  801f02:	0f 84 ac 00 00 00    	je     801fb4 <__umoddi3+0x108>
  801f08:	bf 20 00 00 00       	mov    $0x20,%edi
  801f0d:	29 ef                	sub    %ebp,%edi
  801f0f:	89 fe                	mov    %edi,%esi
  801f11:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f15:	89 e9                	mov    %ebp,%ecx
  801f17:	d3 e0                	shl    %cl,%eax
  801f19:	89 d7                	mov    %edx,%edi
  801f1b:	89 f1                	mov    %esi,%ecx
  801f1d:	d3 ef                	shr    %cl,%edi
  801f1f:	09 c7                	or     %eax,%edi
  801f21:	89 e9                	mov    %ebp,%ecx
  801f23:	d3 e2                	shl    %cl,%edx
  801f25:	89 14 24             	mov    %edx,(%esp)
  801f28:	89 d8                	mov    %ebx,%eax
  801f2a:	d3 e0                	shl    %cl,%eax
  801f2c:	89 c2                	mov    %eax,%edx
  801f2e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f32:	d3 e0                	shl    %cl,%eax
  801f34:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f38:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f3c:	89 f1                	mov    %esi,%ecx
  801f3e:	d3 e8                	shr    %cl,%eax
  801f40:	09 d0                	or     %edx,%eax
  801f42:	d3 eb                	shr    %cl,%ebx
  801f44:	89 da                	mov    %ebx,%edx
  801f46:	f7 f7                	div    %edi
  801f48:	89 d3                	mov    %edx,%ebx
  801f4a:	f7 24 24             	mull   (%esp)
  801f4d:	89 c6                	mov    %eax,%esi
  801f4f:	89 d1                	mov    %edx,%ecx
  801f51:	39 d3                	cmp    %edx,%ebx
  801f53:	0f 82 87 00 00 00    	jb     801fe0 <__umoddi3+0x134>
  801f59:	0f 84 91 00 00 00    	je     801ff0 <__umoddi3+0x144>
  801f5f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f63:	29 f2                	sub    %esi,%edx
  801f65:	19 cb                	sbb    %ecx,%ebx
  801f67:	89 d8                	mov    %ebx,%eax
  801f69:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f6d:	d3 e0                	shl    %cl,%eax
  801f6f:	89 e9                	mov    %ebp,%ecx
  801f71:	d3 ea                	shr    %cl,%edx
  801f73:	09 d0                	or     %edx,%eax
  801f75:	89 e9                	mov    %ebp,%ecx
  801f77:	d3 eb                	shr    %cl,%ebx
  801f79:	89 da                	mov    %ebx,%edx
  801f7b:	83 c4 1c             	add    $0x1c,%esp
  801f7e:	5b                   	pop    %ebx
  801f7f:	5e                   	pop    %esi
  801f80:	5f                   	pop    %edi
  801f81:	5d                   	pop    %ebp
  801f82:	c3                   	ret    
  801f83:	90                   	nop
  801f84:	89 fd                	mov    %edi,%ebp
  801f86:	85 ff                	test   %edi,%edi
  801f88:	75 0b                	jne    801f95 <__umoddi3+0xe9>
  801f8a:	b8 01 00 00 00       	mov    $0x1,%eax
  801f8f:	31 d2                	xor    %edx,%edx
  801f91:	f7 f7                	div    %edi
  801f93:	89 c5                	mov    %eax,%ebp
  801f95:	89 f0                	mov    %esi,%eax
  801f97:	31 d2                	xor    %edx,%edx
  801f99:	f7 f5                	div    %ebp
  801f9b:	89 c8                	mov    %ecx,%eax
  801f9d:	f7 f5                	div    %ebp
  801f9f:	89 d0                	mov    %edx,%eax
  801fa1:	e9 44 ff ff ff       	jmp    801eea <__umoddi3+0x3e>
  801fa6:	66 90                	xchg   %ax,%ax
  801fa8:	89 c8                	mov    %ecx,%eax
  801faa:	89 f2                	mov    %esi,%edx
  801fac:	83 c4 1c             	add    $0x1c,%esp
  801faf:	5b                   	pop    %ebx
  801fb0:	5e                   	pop    %esi
  801fb1:	5f                   	pop    %edi
  801fb2:	5d                   	pop    %ebp
  801fb3:	c3                   	ret    
  801fb4:	3b 04 24             	cmp    (%esp),%eax
  801fb7:	72 06                	jb     801fbf <__umoddi3+0x113>
  801fb9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801fbd:	77 0f                	ja     801fce <__umoddi3+0x122>
  801fbf:	89 f2                	mov    %esi,%edx
  801fc1:	29 f9                	sub    %edi,%ecx
  801fc3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801fc7:	89 14 24             	mov    %edx,(%esp)
  801fca:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801fce:	8b 44 24 04          	mov    0x4(%esp),%eax
  801fd2:	8b 14 24             	mov    (%esp),%edx
  801fd5:	83 c4 1c             	add    $0x1c,%esp
  801fd8:	5b                   	pop    %ebx
  801fd9:	5e                   	pop    %esi
  801fda:	5f                   	pop    %edi
  801fdb:	5d                   	pop    %ebp
  801fdc:	c3                   	ret    
  801fdd:	8d 76 00             	lea    0x0(%esi),%esi
  801fe0:	2b 04 24             	sub    (%esp),%eax
  801fe3:	19 fa                	sbb    %edi,%edx
  801fe5:	89 d1                	mov    %edx,%ecx
  801fe7:	89 c6                	mov    %eax,%esi
  801fe9:	e9 71 ff ff ff       	jmp    801f5f <__umoddi3+0xb3>
  801fee:	66 90                	xchg   %ax,%ax
  801ff0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ff4:	72 ea                	jb     801fe0 <__umoddi3+0x134>
  801ff6:	89 d9                	mov    %ebx,%ecx
  801ff8:	e9 62 ff ff ff       	jmp    801f5f <__umoddi3+0xb3>
