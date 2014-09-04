

#import "Block.h"

@implementation Block

@synthesize blockBody = _blockBody;
@synthesize blockFixture = _blockFixture;
@synthesize sprite = _sprite;
@synthesize isDynamic;

-(id) initWithSprite:(CCSprite*) _spriteInBlock {
    if (self = [super init]) {
        
        
        b2BodyDef blockBodyDef;
        blockBodyDef.type = b2_dynamicBody;
        
        if (_spriteInBlock.tag>=1 && _spriteInBlock.tag<100) {
            blockBodyDef.position.Set(_spriteInBlock.position.x/PTM_RATIO, _spriteInBlock.position.y/PTM_RATIO);
            blockBodyDef.userData = _spriteInBlock;
            self.blockBody = [World sharedWorld]->CreateBody(&blockBodyDef);
            
            b2PolygonShape blockShape;
            blockShape.SetAsBox(_spriteInBlock.contentSize.width/2.0/PTM_RATIO, _spriteInBlock.contentSize.height/2.0/PTM_RATIO);
            b2FixtureDef blockShapeDef;
            blockShapeDef.shape =&blockShape;
            blockShapeDef.density =100.0f;
            blockShapeDef.friction =10.0f;
            blockShapeDef.restitution =0.01f;
             self.blockFixture = _blockBody->CreateFixture(&blockShapeDef);
          
        }else if (_spriteInBlock.tag>=100 && _spriteInBlock.tag<200) {
            blockBodyDef.position.Set(_spriteInBlock.position.x/PTM_RATIO, _spriteInBlock.position.y/PTM_RATIO);
            blockBodyDef.userData = _spriteInBlock;
            self.blockBody = [World sharedWorld]->CreateBody(&blockBodyDef);
            
            b2CircleShape circle;
            circle.m_radius =_spriteInBlock.contentSize.width/2.0/PTM_RATIO;
            
            b2FixtureDef ballShapeDef;
            ballShapeDef.shape =&circle;
            ballShapeDef.density =100.0f;
            ballShapeDef.friction =10.0f;
            ballShapeDef.restitution =0.01f;
             self.blockFixture = _blockBody->CreateFixture(&ballShapeDef);
        }else if (_spriteInBlock.tag>=200 && _spriteInBlock.tag<300) {
            
            blockBodyDef.position.Set(_spriteInBlock.position.x/PTM_RATIO, _spriteInBlock.position.y/PTM_RATIO);
            blockBodyDef.userData = _spriteInBlock;
            blockBodyDef.angle=0;
            self.blockBody = [World sharedWorld]->CreateBody(&blockBodyDef);
            
            
            b2PolygonShape triangle;
            triangle.m_vertexCount=3;
            //148,0
            //74,148
            //0,0
            
            //74,-74
            //0,74
            //-74,-74
             CCLOG(@"the mass of triangle is:%f",_spriteInBlock.contentSize.width/2.0/PTM_RATIO);
            // ni clock
            triangle.m_vertices[1].Set(_spriteInBlock.contentSize.width/2.0/PTM_RATIO, -_spriteInBlock.contentSize.width/2.0/PTM_RATIO);
            triangle.m_vertices[2].Set(0,_spriteInBlock.contentSize.width/2.0/PTM_RATIO);
            triangle.m_vertices[0].Set( -_spriteInBlock.contentSize.width/2.0/PTM_RATIO, -_spriteInBlock.contentSize.width/2.0/PTM_RATIO);
            
            
 
            
            
//            triangle.m_vertices[2].Set(0, -_spriteInBlock.contentSize.width/2.0/PTM_RATIO);
//            triangle.m_vertices[0].Set(_spriteInBlock.contentSize.width/2.0/PTM_RATIO,_spriteInBlock.contentSize.width/2.0/PTM_RATIO);
//            triangle.m_vertices[1].Set( -_spriteInBlock.contentSize.width/2.0/PTM_RATIO, _spriteInBlock.contentSize.width/2.0/PTM_RATIO);
            
            
            
            b2FixtureDef triangleShapeDef;
            triangleShapeDef.shape =&triangle;
            triangleShapeDef.density =100.0f;
            triangleShapeDef.friction =10.0f;
            triangleShapeDef.restitution =0.01f;
            
            //_blockBody->CreateFixture(&triangle, 100.0f);
            CCLOG(@"the mass of triangle is:%f",_blockBody->GetMass());
            
            self.blockFixture = _blockBody->CreateFixture(&triangleShapeDef);
        }
       
        self.sprite = _spriteInBlock;
        self.isDynamic=YES;
    }
    
    return self;
}


@end

