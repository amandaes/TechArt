using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ThirdPersonCameraController : MonoBehaviour {

   

    #region Internal References
    private Transform _app;
    private Transform _view;
    private Transform _cameraBaseTransform;
    private Transform _cameraTransform;
    private Transform _cameraLookTarget;
    private Transform _avatarTransform;
    private Rigidbody _avatarRigidbody;
    #endregion

    #region Public Tuning Variables
    public Vector3 avatarObservationOffset_Base;
    public float followDistance_Base;
    public float verticalOffset_Base;
    public float pitchGreaterLimit;
    public float pitchLowerLimit;
    public float fovAtUp;
    public float fovAtDown;
    #endregion

    public GameObject currentHitObj;
    public float sphereRadius;
    public LayerMask layerMask;
    private Vector3 originPoint;
    public float speed = 2f;
    bool oOIPresent;

    //camera cutting
    //public float minDistance = 0.1f;
    //public float maxDistance = 4f;
    //public float smooth = 10f;
    //Vector3 dollyDir;
    //public Vector3 dollyDirAdjusted;
    //public float distance;


    #region Persistent Outputs
    //Positions
    private Vector3 _camRelativePostion_Auto;

    //Directions
    private Vector3 _avatarLookForward;

    //Scalars
    private float _followDistance_Applied;
    private float _verticalOffset_Applied;
    #endregion

    enum CameraStates { auto, manual };
    CameraStates myCameraState;

    private void Awake()
    {
        _app = GameObject.Find("Application").transform;
        _view = _app.Find("View");
        _cameraBaseTransform = _view.Find("CameraBase");
        _cameraTransform = _cameraBaseTransform.Find("Camera");
        _cameraLookTarget = _cameraBaseTransform.Find("CameraLookTarget");
        _avatarTransform = _view.Find("AIThirdPersonController");
        _avatarRigidbody = _avatarTransform.GetComponent<Rigidbody>();

        //dollyDir = _cameraTransform.localPosition.normalized;
        //distance = _cameraTransform.localPosition.magnitude;

    }

    void Update()
    {
        //CameraCutting();

        if (myCameraState == CameraStates.manual)
        {
            if (Input.GetMouseButton(1))
            {
                _ManualUpdate();
            }
        }
        
        else if (myCameraState == CameraStates.auto)
        {
            _AutoUpdate();
        }
            

        //LOOK AT OBJ OF INTEREST
        originPoint = _avatarTransform.position;
        Collider[] hitOrbs = Physics.OverlapSphere(originPoint, sphereRadius, layerMask, QueryTriggerInteraction.UseGlobal);
        oOIPresent = false;

        foreach (Collider orbs in hitOrbs)
        {
            if(orbs.tag == "Objects")
            {
                oOIPresent = true;
                Debug.Log("FOUND AN ORB");
                currentHitObj = orbs.transform.gameObject; //hit a game object

                //how do I make it not look at the avatar anymore?

                Vector3 directionToLook = currentHitObj.transform.position - _cameraTransform.position;
                Quaternion toRotation = Quaternion.LookRotation(directionToLook);
                _cameraTransform.rotation = Quaternion.Lerp(_cameraTransform.rotation, toRotation, speed * Time.deltaTime);

                Debug.Log("Looking at orb");
               
                 //_cameraTransform.LookAt(currentHitObj.transform.position); //this works but it's not nice
            }
            else 
            {               
                _LookAtAvatar();
            }
            
        }
        

    }
    
    //draw a debug wire sphere to visualize spherecast
    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;

        Gizmos.DrawWireSphere(originPoint, sphereRadius);
    }


    #region States
    private void _AutoUpdate()
    {
        _ComputeData();
        _FollowAvatar();
        _LookAtAvatar();
    }
    private void _ManualUpdate()
    {
        _FollowAvatar();
        _ManualControl();
    }
    #endregion

    #region Internal Logic

    float _standingToWalkingSlider = 0;

    private void _ComputeData()
    {
        _avatarLookForward = Vector3.Normalize(Vector3.Scale(_avatarTransform.forward, new Vector3(1, 0, 1)));

        if (_Helper_IsWalking())
        {
            _standingToWalkingSlider = Mathf.MoveTowards(_standingToWalkingSlider, 1, Time.deltaTime * 3);
        }
        else
        {
           _standingToWalkingSlider = Mathf.MoveTowards(_standingToWalkingSlider, 0, Time.deltaTime);
        }

        float _followDistance_Walking = followDistance_Base;
        float _followDistance_Standing = followDistance_Base * 2;

        float _verticalOffset_Walking = verticalOffset_Base;
        float _verticalOffset_Standing = verticalOffset_Base * 4;

        _followDistance_Applied = Mathf.Lerp(_followDistance_Standing, _followDistance_Walking, _standingToWalkingSlider);
        _verticalOffset_Applied = Mathf.Lerp(_verticalOffset_Standing, _verticalOffset_Walking, _standingToWalkingSlider);
    }

    private void _FollowAvatar()
    {
        _camRelativePostion_Auto = _avatarTransform.position;

        _cameraLookTarget.position = _avatarTransform.position + avatarObservationOffset_Base;
        _cameraTransform.position = _avatarTransform.position - _avatarLookForward * _followDistance_Applied + Vector3.up * _verticalOffset_Applied;
    }

    private void _LookAtAvatar()
    {
        
        _cameraTransform.LookAt(_cameraLookTarget);
    }

    private void _ManualControl()
    {   

        Vector3 _camEulerHold = _cameraTransform.localEulerAngles; //local euler angles is angle degrees relative to the parent transform's rotation

        if (Input.GetAxis("Mouse X") != 0) //rotate camera by using mouse on X axis
            _camEulerHold.y += Input.GetAxis("Mouse X");

        if (Input.GetAxis("Mouse Y") != 0) //rotate camera by using mouse on X axis
        {
            float temp = _camEulerHold.x - Input.GetAxis("Mouse Y");
            temp = (temp + 360) % 360;

            if (temp < 180)
                temp = Mathf.Clamp(temp, 0, 80);
            else
                temp = Mathf.Clamp(temp, 360 - 80, 360);

            _camEulerHold.x = temp;
        }

        Debug.Log("The V3 to be applied is " + _camEulerHold);
        _cameraTransform.localRotation = Quaternion.Euler(_camEulerHold);       

    }

    //void CameraCutting() //MADE THINGS GO BAD.
    //{
    //    Vector3 desiredCamPos = _cameraTransform.TransformPoint(dollyDir * verticalOffset_Base);
    //    RaycastHit hit;

    //    if(Physics.Linecast (_cameraTransform.position, desiredCamPos, out hit))
    //    {
    //        followDistance_Base = Mathf.Clamp(hit.distance, minDistance, verticalOffset_Base);
    //    }
    //    else
    //    {
    //        followDistance_Base = verticalOffset_Base;
    //    }
    //    transform.localPosition = Vector3.Lerp(_cameraTransform.localPosition, dollyDir * followDistance_Base, smooth * Time.deltaTime);
    //}


    #endregion

    #region Helper Functions

    private Vector3 _lastPos;
    private Vector3 _currentPos;
    private bool _Helper_IsWalking()
    {
        _lastPos = _currentPos;
        _currentPos = _avatarTransform.position;
        float velInst = Vector3.Distance(_lastPos, _currentPos) / Time.deltaTime;

        if (velInst > .15f)
            return true;
        else return false;
    }

    #endregion

   
}
