/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

  This file is part of DarkStar-server source code.

===========================================================================
*/

#ifndef _BASEENTITY_H
#define _BASEENTITY_H

#include <memory>
#include <map>
#include "../../common/cbasetypes.h"
#include "../../common/mmo.h"
#include "../packets/message_basic.h"

enum ENTITYTYPE
{
    TYPE_NONE   = 0x00,
    TYPE_PC     = 0x01,
    TYPE_NPC    = 0x02,
    TYPE_MOB    = 0x04,
    TYPE_PET    = 0x08,
    TYPE_SHIP   = 0x10,
    TYPE_TRUST  = 0x20
};

enum STATUSTYPE
{
    STATUS_NORMAL        = 0,
    STATUS_MOB           = 1,
  //STATUS_UPDATE        = 1,
    STATUS_DISAPPEAR     = 2,
    STATUS_INVISIBLE     = 3,
    STATUS_4             = 4,
    STATUS_CUTSCENE_ONLY = 6,
    STATUS_18            = 18,
    STATUS_SHUTDOWN      = 20
};

enum ANIMATIONTYPE
{
    ANIMATION_NONE               = 0,
    ANIMATION_ATTACK             = 1,
    // Death                        = 2,
    ANIMATION_DEATH              = 3,
    ANIMATION_EVENT              = 4,
    ANIMATION_CHOCOBO            = 5,
    ANIMATION_FISHING            = 6,
    // Healing                      = 7,
    ANIMATION_OPEN_DOOR          = 8,
    ANIMATION_CLOSE_DOOR         = 9,
    ANIMATION_ELEVATOR_UP        = 10,
    ANIMATION_ELEVATOR_DOWN      = 11,
    // seems to be WALLHACK                     = 28,
    // seems to be WALLHACK also..              = 31,
    ANIMATION_HEALING            = 33,
    ANIMATION_FISHING_FISH       = 38,
    ANIMATION_FISHING_CAUGHT     = 39,
    ANIMATION_FISHING_ROD_BREAK  = 40,
    ANIMATION_FISHING_LINE_BREAK = 41,
    ANIMATION_FISHING_MONSTER    = 42,
    ANIMATION_FISHING_STOP       = 43,
    ANIMATION_SYNTH              = 44,
    ANIMATION_SIT                = 47,
    ANIMATION_RANGED             = 48,
    ANIMATION_FISHING_START_OLD  = 50,
    ANIMATION_FISHING_START      = 56,
    // 63 through 72 are used with /sitchair
    ANIMATION_SITCHAIR_0 = 63,
    ANIMATION_SITCHAIR_1 = 64,
    ANIMATION_SITCHAIR_2 = 65,
    ANIMATION_SITCHAIR_3 = 66,
    ANIMATION_SITCHAIR_4 = 67,
    ANIMATION_SITCHAIR_5 = 68,
    ANIMATION_SITCHAIR_6 = 69,
    ANIMATION_SITCHAIR_7 = 70,
    ANIMATION_SITCHAIR_8 = 71,
    ANIMATION_SITCHAIR_9 = 72,
    ANIMATION_SITCHAIR_10 = 73,
    // 74 through 83 sitting on air (guessing future use for more chairs..)
    ANIMATION_MOUNT              = 85,
    // ANIMATION_TRUST              = 90 // This is the animation for a trust NPC spawning in.
};

enum MOUNTTYPE
{
    MOUNT_CHOCOBO        = 0,
    MOUNT_QUEST_RAPTOR   = 1,
    MOUNT_RAPTOR         = 2,
    MOUNT_TIGER          = 3,
    MOUNT_CRAB           = 4,
    MOUNT_RED_CRAB       = 5,
    MOUNT_BOMB           = 6,
    MOUNT_RAM            = 7,
    MOUNT_MORBOL         = 8,
    MOUNT_CRAWLER        = 9,
    MOUNT_FENRIR         = 10,
    MOUNT_BEETLE         = 11,
    MOUNT_MOOGLE         = 12,
    MOUNT_MAGIC_POT      = 13,
    MOUNT_TULFAIRE       = 14,
    MOUNT_WARMACHINE     = 15,
    MOUNT_XZOMIT         = 16,
    MOUNT_HIPPOGRYPH     = 17,
    MOUNT_SPECTRAL_CHAIR = 18,
    MOUNT_SPHEROID       = 19,
    MOUNT_OMEGA          = 20,
};

enum ALLEGIANCETYPE
{
    ALLEGIANCE_MOB       = 0,
    ALLEGIANCE_PLAYER    = 1,
    ALLEGIANCE_SAN_DORIA = 2,
    ALLEGIANCE_BASTOK    = 3,
    ALLEGIANCE_WINDURST  = 4
};

enum UPDATETYPE
{
    UPDATE_NONE     = 0x00,
    UPDATE_POS      = 0x01,
    UPDATE_STATUS   = 0x02,
    UPDATE_HP       = 0x04,
    UPDATE_COMBAT   = 0x07,
    UPDATE_NAME     = 0x08,
    UPDATE_LOOK     = 0x10,
    UPDATE_ALL_MOB  = 0x0F,
    UPDATE_ALL_CHAR = 0x1F
};

enum ENTITYFLAGS
{
    FLAG_NONE          = 0x000,
    FLAG_HIDE_NAME     = 0x008,
    FLAG_CALL_FOR_HELP = 0x020,
    FLAG_HIDE_HP       = 0x100,
    FLAG_UNTARGETABLE  = 0x800,
};

// TODO: it is possible to make this structure part of the class, instead of the current id and targid, but without the clean method

struct EntityID_t
{
    void clean()
    {
        id = 0;
        targid = 0;
    }

    uint32 id;
    uint16 targid;
};

class CZone;

struct location_t
{
    position_t	p;              // entity position
    uint16		destination;    // current zone
    CZone*      zone;           // current zone
    uint16		prevzone;       // previous zone (for monsters and npc not used)
    bool		zoning;         // The flag is reset each time you enter a new zone. It is necessary to implement the logic of gaming tasks ("quests")
    uint16		boundary;       // a certain area in the zone in which the entity is located (used by characters and transport)
};

class CAIContainer;
class CInstance;
class CBattlefield;

/************************************************************************
*																		*
*  Base class for all entities in the game								*
*																		*
*                                                                       *
************************************************************************/

class CBaseEntity
{
public:

    CBaseEntity();						// constructor
    virtual ~CBaseEntity();				// destructor

    virtual void    Spawn();
    virtual void    FadeOut();
    virtual const int8* GetName();      // entity name
    uint16			getZone();			// current zone
    float			GetXPos();			// position by coordinates X
    float			GetYPos();			// position by coordinates Y
    float			GetZPos();			// position by coordinates Z
    uint8			GetRotPos();
    void			HideName(bool hide); // hide / show name
    bool			IsNameHidden();		// checks if name is hidden

    CBaseEntity*    GetEntity(uint16 targid, uint8 filter = -1);

    void            ResetLocalVars();
    uint32          GetLocalVar(const char* var);
    void            SetLocalVar(const char* var, uint32 val);

    //pre-tick update
    virtual void    Tick(time_point) = 0;
    //post-tick update
    virtual void    PostTick() = 0;

    void            SetModelId(uint16 modelId);     // Set new modelid
    uint16          GetModelId();                   // Get the modelid

    virtual void    HandleErrorMessage(std::unique_ptr<CBasicPacket>&) {};

    uint32			id;					// global identifier unique on the server
    uint16			targid;				// local identifier unique in the zone
    ENTITYTYPE		objtype;			// entity type
    STATUSTYPE		status;				// status of the entity (different entities - different statuses)
    uint16			m_TargID;			// targid объекта, на который смотрит сущность
    string_t		name;				// entity name
    look_t			look;				// Appearance of all entities
    look_t			mainlook;			// only used if mob use changeSkin() or player /lockstyle
    location_t		loc;				// entity location
    uint8			animation;			// animation
    uint8			animationsub;		// additional animation options
    uint8			speed;				// travel speed
    uint8			speedsub;			// traveling speed parameter
    uint8			namevis;
    uint8			allegiance;			// what types of targets the entity can fight
    uint8           updatemask;         // what to update next server tick to players nearby

    std::unique_ptr<CAIContainer> PAI;       // AI container
    CBattlefield* PBattlefield;            // pointer to battlefield (if in one)
    CInstance*		PInstance;
protected:
    std::map<std::string, uint32> m_localVars;
};

#endif

