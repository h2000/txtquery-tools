JsOsaDAS1.001.00bplist00�Vscripto� f u n c t i o n   r u n ( )   { 
 	 / * j s h i n t   m u l t i s t r : t r u e   * / 
 	 v a r   d c t O p t   =   { 
 	 	 t i t l e :   " V i e w / h i d e   t a g s   i n   F T   d o c u m e n t " , 
 	 	 v e r :   " 0 . 2 " , 
 	 	 d e s c r i p t i o n :   " H i d e s   o r   f o c u s e s   o n   p a r t i c u l a r   t a g s . \ 
 	 	 	 	 	     a n d   s h o w s   a c t i v e   n o d e   p a t h s   w i t h   c o u n t s   o f   h i d d e n \ 
 	 	 	 	 	     a n d   v i s i b l e   t a g s   o f   e a c h   k i n d . " , 
 	 	 a u t h o r :   " R o b T r e w " , 
 	 	 l i c e n s e :   " M I T " , 
 	 	 s i t e :   " h t t p s : / / g i t h u b . c o m / R o b T r e w / t x t q u e r y - t o o l s " 
 	 } ; 
 
 	 f u n c t i o n   v i s i b l e T a g s ( e d )   { 
 	 	 v a r   o T r e e   =   e d . t r e e ( ) , 
 	 	 	 l s t T a g s   =   o T r e e . t a g s ( ) . s o r t ( ) , 
 	 	 	 l s t N o d e s ,   l s t V i s i b l e   =   [ ] , 
 	 	 	 s t r T a g ,   j ,   l n g N o d e s , 
 	 	 	 l n g H i d d e n   =   0 , 
 	 	 	 l n g S h o w n   =   0 ; 
 
 	 	 f o r   ( v a r   l n g   =   l s t T a g s . l e n g t h ,   i   =   0 ;   i   <   l n g ;   i + + )   { 
 	 	 	 s t r T a g   =   l s t T a g s [ i ] ; 
 	 	 	 l s t N o d e s   =   o T r e e . e v a l u a t e N o d e P a t h ( ' / / @ '   +   s t r T a g ) ; 
 	 	 	 l n g N o d e s   =   l s t N o d e s . l e n g t h ; 
 
 	 	 	 l n g H i d d e n   =   0 ; 
 	 	 	 f o r   ( j   =   l n g N o d e s ;   j - - ; )   { 
 	 	 	 	 i f   ( e d . n o d e I s H i d d e n I n F o l d ( l s t N o d e s [ j ] ) )   l n g H i d d e n   + =   1 ; 
 	 	 	 } 
 	 	 	 l s t V i s i b l e . p u s h ( 
 	 	 	 	 l n g H i d d e n   ? 
 	 	 	 	 ( ' @ '   +   s t r T a g   +   ' \ t '   +   ( l n g N o d e s   -   l n g H i d d e n )   +   ' / '   +   l n g N o d e s )   +   '  !�   f o c u s '   : 
 	 	 	 	 ( ' @ '   +   s t r T a g   +   ' \ t '   +   l n g N o d e s )   +   '  !�   h i d e ' 
 	 	 	 ) ; 
 
 	 	 } 
 	 	 r e t u r n   l s t V i s i b l e ; 
 	 } 
 
 	 f u n c t i o n   u p d a t e V i e w ( e d ,   o p t )   { 
 
 	 	 f u n c t i o n   u p d a t e d P a t h ( s t r O l d P a t h ,   l s t C h o i c e )   { 
 	 	 	 v a r   l s t P a r t s ,   l s t S c o r e ,   l s t S h o w   =   [ ] , 
 	 	 	 	 l s t H i d e   =   [ ] , 
 	 	 	 	 s t r P a t h   =   ' ' , 
 	 	 	 	 s t r S h o w ,   s t r H i d e , 
 	 	 	 	 l n g V i s i b l e ,   l n g T o t a l , 
 	 	 	 	 l n g   =   l s t C h o i c e . l e n g t h , 
 	 	 	 	 i ; 
 
 	 	 	 / /   P a r t i a l   | |   N o n e   - -   >   F o c u s 
 	 	 	 / /   A l l   - -   >   H i d e 
 	 	 	 f o r   ( i   =   l n g ;   i - - ; )   { 
 	 	 	 	 l s t P a r t s   =   l s t C h o i c e [ i ] . s p l i t ( ' \ t ' ) ; 
 
 	 	 	 	 i f   ( ' S H O W   A L L '   = = =   l s t P a r t s [ 0 ] )   { 
 	 	 	 	 	 r e t u r n   ' / / / * ' ; 
 	 	 	 	 } 
 
 	 	 	 	 l s t S c o r e   =   l s t P a r t s [ 1 ] . s p l i t ( ' / ' ) ; 
 	 	 	 	 l n g V i s i b l e   =   l s t S c o r e [ 0 ] ; 
 	 	 	 	 l n g T o t a l   =   l s t S c o r e [ 1 ] ; 
 
 	 	 	 	 i f   ( l n g V i s i b l e   <   l n g T o t a l )   l s t S h o w . p u s h ( l s t P a r t s [ 0 ] ) ; 
 	 	 	 	 e l s e   l s t H i d e . p u s h ( l s t P a r t s [ 0 ] ) ; 
 	 	 	 } 
 
 	 	 	 l n g   =   l s t S h o w . l e n g t h ; 
 	 	 	 i f   ( l n g )   s t r P a t h   =   ' / / '   +   ( ( l n g   >   1 )   ? 
 	 	 	 	 ' ( '   +   l s t S h o w . j o i n ( '   o r   ' )   +   ' ) '   : 
 	 	 	 	 l s t S h o w [ 0 ] ) ; 
 
 	 	 	 l n g   =   l s t H i d e . l e n g t h ; 
 	 	 	 i f   ( l n g )   { 
 	 	 	 	 s t r H i d e   = 
 	 	 	 	 	 ( l n g   >   1 )   ?   ' ( '   +   l s t H i d e . j o i n ( '   o r   ' )   +   ' ) '   : 
 	 	 	 	 	 l s t H i d e [ 0 ] ; 
 
 	 	 	 	 s t r P a t h   =   s t r P a t h   ? 
 	 	 	 	 	 ( s t r P a t h   +   '   e x c e p t   / / '   +   s t r H i d e )   : 
 	 	 	 	 	 ( ' / / n o t   '   +   s t r H i d e ) ; 
 	 	 	 } 
 	 	 	 r e t u r n   s t r P a t h ; 
 	 	 } 
 
 	 	 v a r   s t r N e w P a t h   =   u p d a t e d P a t h ( o p t . o l d P a t h ,   o p t . c h o i c e ) ; 
 	 	 e d . s e t N o d e P a t h ( s t r N e w P a t h ) ; 
 	 	 r e t u r n   s t r N e w P a t h ; 
 	 } 
 
 	 f u n c t i o n   d o c P a t h ( e d )   { 
 	 	 r e t u r n   e d . n o d e P a t h ( ) . t o S t r i n g ( ) ; 
 	 } 
 
 	 v a r   d o c s F T   =   A p p l i c a t i o n ( " F o l d i n g T e x t " ) . d o c u m e n t s ( ) , 
 	 	 a p p   =   A p p l i c a t i o n . c u r r e n t A p p l i c a t i o n ( ) , 
 	 	 l n g D o c s   =   d o c s F T . l e n g t h , 
 	 	 o D o c   =   l n g D o c s   ?   d o c s F T [ 0 ]   :   n u l l , 
 	 	 s t r P a t h ,   s t r N e w P a t h   =   ' / / / * ' , 
 	 	 l s t H i d e   =   [ ] , 
 	 	 l s t F o c u s   =   [ ] , 
 	 	 l s t T a g S e t , 
 	 	 v a r C h o i c e   =   t r u e ; 
 
 	 i f   ( l n g D o c s )   { 
 	 	 l s t T a g S e t   =   o D o c . e v a l u a t e ( { 
 	 	 	 s c r i p t :   v i s i b l e T a g s . t o S t r i n g ( ) 
 	 	 } ) ; 
 	 	 l s t T a g S e t . p u s h ( ' S H O W   A L L \ t ' ) ; 
 	 	 s t r P a t h   =   o D o c . e v a l u a t e ( { 
 	 	 	 s c r i p t :   d o c P a t h . t o S t r i n g ( ) 
 	 	 } ) ; 
 
 	 	 a p p . i n c l u d e S t a n d a r d A d d i t i o n s   =   t r u e ; 
 	 	 i f   ( l s t T a g S e t . l e n g t h )   { 
 	 	 	 w h i l e   ( v a r C h o i c e )   { 
 	 	 	 	 a p p . a c t i v a t e ( ) ; 
 	 	 	 	 v a r C h o i c e   =   a p p . c h o o s e F r o m L i s t ( l s t T a g S e t ,   { 
 	 	 	 	 	 w i t h T i t l e :   d c t O p t . t i t l e   +   '   '   +   d c t O p t . v e r , 
 	 	 	 	 	 w i t h P r o m p t :   ' a c t i v e   n o d e   p a t h : \ n \ n '   +   s t r P a t h   + 
 	 	 	 	 	 	 ' \ n \ n '   +   ' (   v i s i b l e   /   t o t a l   )  !�   a c t i o n \ n \ n '   + 
 	 	 	 	 	 	 '# - c l i c k   f o r   m u l t i p l e   t a g ( s ) : ' , 
 	 	 	 	 	 d e f a u l t I t e m s :   [ l s t T a g S e t [ l s t T a g S e t . l e n g t h   -   1 ] ] , 
 	 	 	 	 	 m u l t i p l e S e l e c t i o n s A l l o w e d :   t r u e 
 	 	 	 	 } ) ; 
 
 	 	 	 	 i f   ( v a r C h o i c e )   { 
 	 	 	 	 	 / /   G e t   a   n e w   p a t h 
 	 	 	 	 	 s t r N e w P a t h   =   o D o c . e v a l u a t e ( { 
 	 	 	 	 	 	 s c r i p t :   u p d a t e V i e w . t o S t r i n g ( ) , 
 	 	 	 	 	 	 w i t h O p t i o n s :   { 
 	 	 	 	 	 	 	 o l d P a t h :   s t r P a t h , 
 	 	 	 	 	 	 	 c h o i c e :   v a r C h o i c e 
 	 	 	 	 	 	 } 
 	 	 	 	 	 } ) ; 
 	 	 	 	 	 / /   a n d   u p d a t e   t h e   l i s t   o f   t a g   v i s i b i l i t i e s 
 	 	 	 	 	 s t r P a t h   =   s t r N e w P a t h ; 
 	 	 	 	 	 l s t T a g S e t   =   o D o c . e v a l u a t e ( { 
 	 	 	 	 	 	 s c r i p t :   v i s i b l e T a g s . t o S t r i n g ( ) 
 	 	 	 	 	 } ) ; 
 	 	 	 	 	 l s t T a g S e t . p u s h ( ' S H O W   A L L \ t ' ) ; 
 	 	 	 	 } 
 	 	 	 } 
 	 	 } 
 	 } 
 
 	 r e t u r n   s t r N e w P a t h ; 
 }                              �jscr  ��ޭ